__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Event = readonly({
  Event_116371_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116371_Desc = {
    Text = "Hai accettato una richiesta di contatto dalla scuola. La voce familiare calma la tua mente. Raccogli le forze e prosegui."
  },
  Event_116371_Name = {Text = "Crocevia"},
  Event_116372_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116372_Desc = {
    Text = "Hai attivato una stanza sconosciuta."
  },
  Event_116372_Name = {
    Text = "Sconosciuto"
  },
  Event_116373_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116373_Desc = {
    Text = "Hai trovato il tesoro."
  },
  Event_116373_Name = {
    Text = "Tesoro segreto"
  },
  Event_116374_ChoiceDesc1 = {
    Text = "[Connect] Recupera Arg2 PV."
  },
  Event_116374_Desc = {
    Text = "La nebbia si aggrappa densa mentre il tuo distintivo emette un pallido bagliore argenteo. Il comunicatore crepita, prendendo vita. Qualcuno sta chiamando."
  },
  Event_116374_Name = {Text = "Crocevia"},
  Event_116389_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116389_Desc = {
    Text = "Pinch sta ancora dormendo...zzZZ"
  },
  Event_116389_Name = {Text = "Pinch"},
  Event_116429_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116429_Desc = {
    Text = "Hai attivato l'evento casuale 3."
  },
  Event_116429_Name = {
    Text = "Evento casuale 3"
  },
  Event_116430_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116430_Desc = {
    Text = "Hai attivato l'evento casuale 1."
  },
  Event_116430_Name = {
    Text = "Evento casuale 1"
  },
  Event_116431_ChoiceDesc1 = {Text = "[Leave]"},
  Event_116431_Desc = {
    Text = "Hai attivato l'evento casuale 2."
  },
  Event_116431_Name = {
    Text = "Evento casuale 2"
  },
  Event_117279_ChoiceDesc1 = {
    Text = "[You Once Longed for Innocence] Inserisci 3 [(Skill.Arg1)] nel tuo mazzo."
  },
  Event_117279_Desc = {
    Text = "\nUna tenue foschia bianca si leva dal mare, avvolgendo ogni cosa in un velo di bruma.\nOltrepassando il confine tra la vita e la morte, colmando la distanza tra l'interno e l'esterno del varco, attraversando memorie ormai da tempo sbiadite, scorgi la sagoma di una dama che regge un parasole controluce.\nIl tempo trascorso con lei è già passato, proprio come i suoi delicati eppure vividi colori giovanili.\nQuando il falso sole infine sorge, la nebbia si frantuma nel nulla, e il suo profilo ondeggia nel sogno, tramutandosi in luce e bolle illusorie, porgendoti un silenzioso addio."
  },
  Event_117279_Name = {
    Text = "Illusione di Murphy"
  },
  Event_117280_ChoiceDesc1 = {
    Text = "[You Once Longed for Innocence] Seleziona 2 Carte a cui conferire l'Orazione [Eco dell'Abisso]."
  },
  Event_117280_Desc = {
    Text = "\nUna tenue foschia bianca si leva dal mare, avvolgendo ogni cosa in un velo di bruma.\nOltrepassando il confine tra la vita e la morte, colmando la distanza tra l'interno e l'esterno del varco, attraversando memorie ormai da tempo sbiadite, scorgi la sagoma di una dama che regge un parasole controluce.\nIl tempo trascorso con lei è già passato, proprio come i suoi delicati eppure vividi colori giovanili.\nQuando il falso sole infine sorge, la nebbia si frantuma nel nulla, e il suo profilo ondeggia nel sogno, tramutandosi in luce e bolle illusorie, porgendoti un silenzioso addio."
  },
  Event_117280_Name = {
    Text = "Illusione di Murphy"
  },
  Event_118414_ChoiceDesc1 = {
    Text = "[Three Points]"
  },
  Event_118414_ChoiceDesc2 = {
    Text = "[Six Points]"
  },
  Event_118414_ChoiceDesc3 = {
    Text = "[One Point]"
  },
  Event_118414_Desc = {
    Text = [[
I dadi rotolano, emettendo un suono gorgogliante.
Quando si fermeranno?
Non lo sai, ma devi dare una risposta.]]
  },
  Event_118414_Name = {
    Text = "Scommessa del Destino"
  },
  Event_118415_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118415_Desc = {
    Text = "La tua risposta addolcisce il \"Cielo.\"\nTi bacia dolcemente la fronte.\nE lì, un fiore a forma d'onda sboccia."
  },
  Event_118415_Name = {
    Text = "Abbraccio del mare"
  },
  Event_118416_ChoiceDesc1 = {
    Text = "[Perdersi nelle illusioni] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_118416_ChoiceDesc2 = {
    Text = "[Maintain Sanity] Ottieni 15 Sigilli Neri per ogni Risvegliatore con 50 o più Aliemus"
  },
  Event_118416_ChoiceDesc3 = {
    Text = "[Leave by Force] Ottieni 1 Orazione su 3"
  },
  Event_118416_Desc = {
    Text = "Forse la lunga Battaglia ti ha lasciato disorientato, o forse la tua mente ha tradito il tuo corpo.\nUna sensazione di assenza di gravità pervade i tuoi pensieri.\nIn un istante, la tua mente diventa un Caleidoscopio — abbagliante, brillante, lampeggiante di ogni colore.\nInnumerevoli intuizioni, riflessioni e fantasie inondano la tua mente, colmando ogni fessura.\nSe questo continua, il tuo cervello presto esploderà nel caos."
  },
  Event_118416_Name = {
    Text = "Caleidoscopio del pensiero"
  },
  Event_118417_ChoiceDesc1 = {
    Text = "[Join the Gamble] Sviluppi [(Skill.Arg1)], entra nella scommessa"
  },
  Event_118417_ChoiceDesc2 = {
    Text = "[Forget It] Ottieni 25 Sigilli Neri"
  },
  Event_118417_Desc = {
    Text = "In uno stato di stordimento, la tua coscienza fluttuò attraverso strati di nebbia, disperdendosi nello spazio ignoto.\nDue dadi furono lanciati davanti a te, ma l'esistenza sconosciuta che ti aveva trascinato qui con la forza restava invisibile.\nPotevi solo udire le voci caotiche provenire da ogni direzione.\n\"Vuoi tornare indietro? Allora facciamo una partita.\"\n\"Con la tua vita come posta in gioco, che il gioco d'azzardo col destino abbia inizio.\""
  },
  Event_118417_Name = {
    Text = "Scommessa del Destino"
  },
  Event_118418_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118418_Desc = {
    Text = "Le esperienze trascendenti sono fugaci. Giungono senza preavviso e svaniscono altrettanto improvvisamente.\nMa almeno la tua testa è ancora intatta—non è davvero esplosa."
  },
  Event_118418_Name = {
    Text = "Caleidoscopio del pensiero"
  },
  Event_118419_ChoiceDesc1 = {
    Text = "[Leave] Acquisisci la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_118419_Desc = {
    Text = "Non hai perso, ma nemmeno hai vinto; il risultato non è né buono né cattivo.\n\"È un pareggio...\"\nL'esistenza sconosciuta sospirò, eppure non vi era traccia di rammarico nella sua Voce.\n\"Un piacevole passatempo.\""
  },
  Event_118419_Name = {
    Text = "Scommessa del Destino"
  },
  Event_118420_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118420_Desc = {
    Text = "Lentamente, la melodia frenetica si trasforma in qualcosa di armonioso e sacro.\nFinalmente comprendi perché viene chiamato l'\"Inno Perfetto\"—\npoiché è, in verità, impeccabile."
  },
  Event_118420_Name = {
    Text = "L'Inno \"Perfetto\""
  },
  Event_118421_ChoiceDesc1 = {
    Text = "[Perceive the Brain] Scegli 1 tra 3 Carte di comando per ottenere un'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_118421_ChoiceDesc2 = {
    Text = "[Perceive the Soul] Sviluppi [(Skill.Arg1)], reimprimi, fino a 2 volte"
  },
  Event_118421_Desc = {
    Text = "La prima gabbia di una persona è il proprio corpo.\nIn questa gabbia, il cervello è l'ultima e più importante prigione.\n\"Tesoro, credi davvero che solo perché sei vivo e respiri, sei al sicuro?\"\nQuando il tuo cervello tradirà la tua anima, sperimenterai il tormento più doloroso al mondo.\nE questo tormento ti accompagnerà per tutta la vita."
  },
  Event_118421_Name = {
    Text = "Prigione Cerebrale"
  },
  Event_118422_ChoiceDesc1 = {
    Text = "[Touch the Butterfly] Elimina 2 carte"
  },
  Event_118422_ChoiceDesc2 = {
    Text = "[Drive Away the Butterfly] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\""
  },
  Event_118422_ChoiceDesc3 = {
    Text = "[Leave] Ricevi Arg1 Sigilli Neri"
  },
  Event_118422_Desc = {
    Text = "Non ci sono farfalle nel mare profondo. Sono i sogni di una ragazza intrappolata in una stanza.\nCosì belle, danzano libere nell'aria.\n\"Se solo... potessi volare via come loro...\"\nUna farfalla singhiozza, il suo pianto soffocato dal battito d'ali e dal clangore delle macchine da scrivere."
  },
  Event_118422_Name = {
    Text = "L'anima danza come una Farfalla"
  },
  Event_118423_ChoiceDesc1 = {
    Text = "[Cut the Rope] Sviluppa \"(Skill.Arg1)\", ottieni la Reliquia maledetta \"(RelicConfig.Arg2)\""
  },
  Event_118423_ChoiceDesc2 = {
    Text = "[Loosen His Bonds] Sviluppa \"(Skill.Arg1)\" due volte, ottieni le Reliquie d'argento \"(RelicConfig.Arg2)\" e \"(RelicConfig.Arg3)\""
  },
  Event_118423_ChoiceDesc3 = {
    Text = "[Help Him Break Free] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_118423_Desc = {
    Text = "\"Alcuni dicono che il desiderio senza fine sia la forza motrice del progresso.\nMa quando quel desiderio cresce così potente da non poter più essere ignorato né reciso... sento che si trasforma dall'interno in una gabbia.\"\nUna voce debole emerse dall'oscurità. Non potevate vedere il volto di chi parlava, solo un paio di mani legate.\n\"Questi desideri si nutrono della mia paura, della mia debolezza, della mia speranza, del mio dolore... e così facendo, non fanno che crescere.\"\nLa voce pronunciò un'ultima, disperata supplica.\n\"Sono disposto a sacrificare tutto! Anima gentile, vi prego... salvatemi. O concedetemi la liberazione.\""
  },
  Event_118423_Name = {
    Text = "Desiderio Vincolante"
  },
  Event_118424_ChoiceDesc1 = {
    Text = "[Perceive the Brain] Scegli 1 tra 3 Carte di comando per ottenere un'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_118424_Desc = {
    Text = "Hai avvertito un fremito nella tua materia cerebrale.\n\"Ha un qualche significato particolare?\"\nTi sei chiesto, ma il tuo cervello è rimasto in silenzio.\nNon ogni domanda rivolta a sé stessi ottiene una risposta."
  },
  Event_118424_Name = {
    Text = "Prigione Cerebrale"
  },
  Event_118425_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118425_Desc = {
    Text = "Nuoti disperatamente verso l'alto e rompi la superficie.\nAria, densa del profumo del mare, inonda i tuoi polmoni—un monito che il pericolo è ancora in agguato.\nMa sai che il vero cielo è sopra di te.\nProprio come la verità, non può essere celato da dolci menzogne."
  },
  Event_118425_Name = {
    Text = "Abbraccio del mare"
  },
  Event_118426_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118426_Desc = {
    Text = "Nel momento in cui tocchi la corda del Desiderio, un dolore acuto sgorga dalle profondità della tua anima.\nLa tua paura, la tua Debolezza, la tua speranza e la tua agonia erompono, torcendosi in un cordone insanguinato che ti lega le mani.\nIn quell'istante, odi una voce esultare con malizia.\n\"Anima dal cuore buono, sarai ricompensata… e maledetta.\""
  },
  Event_118426_Name = {
    Text = "Desiderio Vincolante"
  },
  Event_118427_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118427_Desc = {
    Text = "Il tuo tocco fa tremare le farfalle.\nDalla loro creazione, non hanno mai conosciuto tale dolcezza.\nSopraffatte, dimenticano come volare.\nInnumerevoli farfalle precipitano, rivelando la Macchina da scrivere nascosta sotto le loro ali.\nQuello strumento pietoso, ormai privo di vita, ha usato le sue ultime forze per battere una sola parola: \"libertà.\""
  },
  Event_118427_Name = {
    Text = "L'anima danza come una Farfalla"
  },
  Event_118428_ChoiceDesc1 = {
    Text = "[Prepararsi al combattimento] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_118428_ChoiceDesc2 = {
    Text = "[Try to Detour] Ottieni 25 Sigilli Neri"
  },
  Event_118428_Desc = {
    Text = "Negli abissi stellati, i Navigatori hanno dormito per secoli.\nIl mare sconfinato è stato testimone della loro follia, della loro resistenza e della loro fede più devota.\nNessuno può ostacolare la grande venuta del loro Dio.\nColoro che si frappongono saranno ridotti in cenere dall'ira dei Navigatori."
  },
  Event_118428_Name = {
    Text = "Veglia sotto le Stelle"
  },
  Event_118429_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118429_Desc = {
    Text = "Istintivamente ti copri le orecchie.\nMiracolosamente, il suono proveniente dal profondo della tua anima tace.\nMa è solo temporaneo."
  },
  Event_118429_Name = {
    Text = "Melodia Profanatrice"
  },
  Event_118430_ChoiceDesc1 = {
    Text = "[Revisit the Past] Ottieni 1 Orazione avanzata tra 3"
  },
  Event_118430_ChoiceDesc2 = {
    Text = "[Gaze into the Future] Ottieni la Reliquia dorata \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\""
  },
  Event_118430_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_118430_Desc = {
    Text = "Nulla in questo mondo resta immutato—\nneppure il Paradise plasmato dalla Madre Divina.\nPer un istante fugace, scorgi qualcosa attraverso una crepa nel tempo.\nPassato, presente e futuro si intrecciano in quella fessura, mutando senza sosta,\nin attesa del tuo sguardo curioso."
  },
  Event_118430_Name = {
    Text = "Frattura Temporale"
  },
  Event_118431_ChoiceDesc1 = {
    Text = "[Tune] Ricevi 100 Sigilli Neri"
  },
  Event_118431_ChoiceDesc2 = {
    Text = "[2 Carte di comando casuali ottengono l'Orazione: \"(EnchantConfig.Arg1)\"]"
  },
  Event_118431_Desc = {
    Text = "La volontà informe rifiuta la tua scelta. Ti offre un'altra possibilità di cambiare il tuo cammino—\nAttento, anche una musica informe può reclamare vite."
  },
  Event_118431_Name = {
    Text = "L'Inno \"Perfetto\""
  },
  Event_118432_ChoiceDesc1 = {
    Text = "[Feed the Rats] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)], sviluppa 1 Sintomo"
  },
  Event_118432_ChoiceDesc2 = {
    Text = "[Drive the Rats Away] Incidi un'Orazione su 1 carta tra 3: \"(EnchantConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\""
  },
  Event_118432_ChoiceDesc3 = {
    Text = "[Ignore the Rats] Ottieni 25 Sigilli Neri"
  },
  Event_118432_Desc = {
    Text = "Tutto su questa nave è intrappolato nel Ciclo Temporale.\nPersino quelle disgustose, pelose piccole creature che lottano per sopravvivere qui non possono sfuggire al proprio destino.\nCiclo dopo ciclo, divorano tutto ciò che trovano, eppure la loro fame non è mai saziata.\n\"Così... affamati...\"\nOrde di ratti emettono Stridi striduli e malsani.\nI cicli infiniti li hanno resi affamati e folli — devono mangiare qualcosa.\nOra. Immediatamente."
  },
  Event_118432_Name = {
    Text = "Branco di Ratti Affamati"
  },
  Event_118433_ChoiceDesc1 = {
    Text = "[Avoid Their Gaze] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\""
  },
  Event_118433_ChoiceDesc2 = {
    Text = "[Stare into the Eyes] Risveglia casualmente 2 risvegliatori, ma sviluppa [(Skill.Arg1)] due volte"
  },
  Event_118433_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_118433_Desc = {
    Text = [[
Proprio come le stelle nel cielo, vi sono certamente molti occhi nel mare profondo.
Quegli occhi appartengono ai pesci che vivono sui fondali, alle specie branchiali profanate, e all'oceano stesso.
Shh, non disturbarli.
Non disturbare la follia del mare profondo.]]
  },
  Event_118433_Name = {
    Text = "Occhio del Mare Profondo"
  },
  Event_118434_ChoiceDesc1 = {
    Text = "[Ignore the Whispers]"
  },
  Event_118434_ChoiceDesc2 = {
    Text = "[Listen to the Whispers]"
  },
  Event_118434_ChoiceDesc3 = {
    Text = "[Make Something Up]"
  },
  Event_118434_Desc = {
    Text = "\"Desideri il favore di Dio? Vuoi conoscere il tuo significato?\"\nUn sospiro risuonò nel tuo orecchio, come il sussurro interiore di un folle, o l'intimo mormorio di qualcosa privo di forma.\nSotto la guida della ragione e della Vigilanza, rifiuti quella voce, ma essa continua a parlare tra sé.\n\"Ascolta con pazienza. Ciò che apprenderai è La Verità riguardante il destino del mondo...\""
  },
  Event_118434_Name = {
    Text = "Predica dell'Intangibile"
  },
  Event_118435_ChoiceDesc1 = {
    Text = "[Perceive the Brain] Scegli 1 tra 3 Carte di comando per ottenere un'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_118435_ChoiceDesc2 = {
    Text = "[Perceive the Soul] Sviluppi [(Skill.Arg1)], imprimi di nuovo casualmente"
  },
  Event_118435_Desc = {
    Text = "Il cervello, protetto al sicuro nel cranio, ti trasmetteva certi messaggi.\nNon sai se questi messaggi si siano deteriorati durante la conversione dei neurotrasmettitori e la trasmissione delle correnti bioelettriche.\nL'unico fatto certo è che hai ricevuto le informazioni e hai percepito la tua esistenza attraverso la presenza oggettiva del tuo corpo."
  },
  Event_118435_Name = {
    Text = "Prigione Cerebrale"
  },
  Event_118436_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_118436_Desc = {
    Text = "\"Buona risposta, ma sfortunatamente, non quella corretta.\"\n\"Qual è la risposta corretta?\"\nL'esistenza sconosciuta non rispose alla tua domanda, lasciando sfuggire solo una risata sprezzante.\n\"Chi ti ha detto che il destino ha una risposta corretta?\""
  },
  Event_118436_Name = {
    Text = "Scommessa del Destino"
  },
  Event_118437_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118437_Desc = {
    Text = "\"Credi che non abbia tentato di reciderle? No—resistere al desiderio non fa che renderlo più forte!\"\nMentre le corde del desiderio si stringono, incidendo la carne, la voce emette un urlo disperato.\n\"Non potrò mai liberarmene... mai!\""
  },
  Event_118437_Name = {
    Text = "Desiderio Vincolante"
  },
  Event_118438_ChoiceDesc1 = {
    Text = "[Listen to the Singing] Ottieni 25 Sigilli Neri, ma sviluppi [(Skill.Arg2)], continua a scegliere"
  },
  Event_118438_ChoiceDesc2 = {
    Text = "[Ignore It] Parti"
  },
  Event_118438_Desc = {
    Text = [[
Il corvo nero come la pece piange.
Il corvo nero come la pece urla.
Il corvo nero come la pece ulula.
Eppure per la gente, sembra solo un canto.
"Ah, che canzone spensierata. Vorrei essere un corvo, lontano dai tormenti del mondo."]]
  },
  Event_118438_Name = {
    Text = "Lamento impercepito"
  },
  Event_118439_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118439_Desc = {
    Text = [[
Quando le farfalle svaniscono, finalmente scorgi la macchina da scrivere sottostante.
Quel povero oggetto senza vita ha usato il suo ultimo respiro per battere due parole: "Vattene, ora."]]
  },
  Event_118439_Name = {
    Text = "L'anima danza come una Farfalla"
  },
  Event_118440_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118440_Desc = {
    Text = [[
Nell'ombra del passato, una ragazza in un soffice cappotto ti saluta con la mano.
Non riesci a udire le sue parole, ma vedi il suo sorriso.]]
  },
  Event_118440_Name = {
    Text = "Frattura Temporale"
  },
  Event_118441_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118441_Desc = {
    Text = [[
Il mare profondo torna al silenzio e all'ombra.
In quella quiete, odi ancora il battito del cuore.
Questa volta, proviene da dentro di te.
Per gli altri, non sei che un cuore pulsante alla deriva nell'abisso.]]
  },
  Event_118441_Name = {
    Text = "Legge del Più Forte"
  },
  Event_118442_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118442_Desc = {
    Text = "Questa volta non è l'ostacolo, ma i Navigatori a ridursi in cenere.\nLe stelle osservano in silenzio la scena, come hanno fatto per secoli, senza offrire risposta."
  },
  Event_118442_Name = {
    Text = "Veglia sotto le Stelle"
  },
  Event_118443_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118443_Desc = {
    Text = "Nonostante il loro numero, i luridi ratti possiedono più coraggio che forza.\nIntimiditi dalla tua postura tenace, si disperdono nel panico."
  },
  Event_118443_Name = {
    Text = "Branco di Ratti Affamati"
  },
  Event_118444_ChoiceDesc1 = {
    Text = "[Reach Out a Helping Hand] Risveglia casualmente 1 risvegliatore, ma sviluppi [(Skill.Arg1)]"
  },
  Event_118444_ChoiceDesc2 = {
    Text = "[Silently Observing] Ottieni 1 Orazione su 3"
  },
  Event_118444_Desc = {
    Text = "Un cuore pulsante vaga nel buio abissale.\nPotrebbe appartenere a un pesce, o a qualche creatura dotata di branchie.\nNon riesci a distinguere nulla—solo il cuore che pulsa, e dietro di esso, fauci insanguinate che si spalancano lentamente.\nCacciare o essere cacciati è la legge di natura,\nsia sulla terra che nel mare."
  },
  Event_118444_Name = {
    Text = "Legge del Più Forte"
  },
  Event_118445_ChoiceDesc1 = {
    Text = "[Agitare la mano per scacciare] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_118445_ChoiceDesc2 = {
    Text = "[Let It Stay] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_118445_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_118445_Desc = {
    Text = "Un suono flebile emerge dall'Oscurità.\nÈ una Farfalla, che chiede cortesemente:\n\"Posso riposare nel palmo della tua mano?\"\n\"Sono solo così stanca... desidero riposare un momento.\"\nMentre lo chiede, la Farfalla volteggia verso di te attraverso il buio.\nUn liquido nero e viscoso gocciola dalle sue ali — un dono delle ombre che ha attraversato."
  },
  Event_118445_Name = {
    Text = "Richiesta della Farfalla"
  },
  Event_118446_ChoiceDesc1 = {
    Text = "[Leave] Ottieni la Reliquia d'Oro [(RelicConfig.Arg1)]"
  },
  Event_118446_Desc = {
    Text = "Dopo un momento di silenzio, qualcosa ti fu gettato tra le braccia.\n\"Prendilo e vattene.\"\n\"Il destino è sempre generoso con i fortunati.\""
  },
  Event_118446_Name = {
    Text = "Scommessa del Destino"
  },
  Event_118447_ChoiceDesc1 = {
    Text = "[Seguire la Guida] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_118447_ChoiceDesc2 = {
    Text = "[Ignorare la Guida] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_118447_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_118447_Desc = {
    Text = "La festa è iniziata.\nTra fiamme spirituali e benedizioni intrise di sangue, innumerevoli credenti sono divenuti torce viventi—\nAnime eteree si disperdono intorno a te come spiriti guida, luminescenti, in attesa della tua scelta."
  },
  Event_118447_Name = {
    Text = "Faro dell'Anima"
  },
  Event_118448_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 50 Sigilli Neri, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_118448_Desc = {
    Text = "\"Umani ignoranti!\"\nQuela voce emise un lamento frustrato, ma non al punto di sfociare in collera.\nPoiché essa sa che gli ignoranti avranno sempre i loro momenti di illuminazione.\nDeve solo attendere che quel giorno giunga.\nE prima che quel giorno arrivi, imprimerà su di voi il sigillo di Dio, confermando l'appartenenza della vostra Anima."
  },
  Event_118448_Name = {
    Text = "Predica dell'Intangibile"
  },
  Event_118449_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118449_Desc = {
    Text = "[@2 of @3……]\nUn'ondata di conoscenza, accompagnata da quella melodia blasfema, si riversa nel tuo cervello.\nMa la tua forma mortale ti limita, rendendo la saggezza cosmica al di là della tua portata.\nChe doloroso rimpianto."
  },
  Event_118449_Name = {
    Text = "Melodia Profanatrice"
  },
  Event_118450_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 50 Sigilli Neri, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_118450_Desc = {
    Text = "\"In realtà, anch'io ho una verità sul mondo che vorrei raccontarti...\"\n\"Il mondo è stato creato da un dio di pasta volante composto da due saggi occhi di polpetta e pasta che simboleggia un'abilità infinita...\"\nCon aria seria, inventi una storia divertente che hai sentito, in attesa della reazione dell'altro.\nMa dopo lungo tempo, l'altra parte resta in silenzio.\n\"Ahimè, sembra che i ferventi credenti non comprendano l'umorismo.\"\nSospirando, non puoi far altro che andartene."
  },
  Event_118450_Name = {
    Text = "Predica dell'Intangibile"
  },
  Event_118451_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118451_Desc = {
    Text = "La tua accordatura non riesce a portare armonia alle sillabe caotiche.\nEppure la volontà invisibile ha riconosciuto il tuo sforzo.\nÈ un inizio."
  },
  Event_118451_Name = {
    Text = "L'Inno \"Perfetto\""
  },
  Event_118452_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118452_Desc = {
    Text = "Tre figure tremavano, piangendo in silenzio.\nLa loro fede era stata messa in dubbio da te, e quella era la più grande offesa che un fanatico non poteva tollerare."
  },
  Event_118452_Name = {
    Text = "Il miglior sacrificio"
  },
  Event_118453_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118453_Desc = {
    Text = "Nell'immagine del futuro, la ragazza con i tentacoli ti lanciò uno sguardo sprezzante e ti rimproverò.\n\"La vera forma della Madre Divina non può essere profanata.\"\nPoi l'immagine svanì e la frattura spazio-temporale si richiuse all'istante, lasciandoti a ricordare la scena di poco prima."
  },
  Event_118453_Name = {
    Text = "Frattura Temporale"
  },
  Event_118454_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118454_Desc = {
    Text = [[
Eludi i Navigatori e prosegui.
In alto, le stelle brillano sommessamente, come fanno da millenni.]]
  },
  Event_118454_Name = {
    Text = "Veglia sotto le Stelle"
  },
  Event_118455_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118455_Desc = {
    Text = "L'esistenza sconosciuta non ti ostacolò.\n\"Un giorno, farai Ritorno.\"\n\"Nessuno può rifiutare il Fato.\""
  },
  Event_118455_Name = {
    Text = "Scommessa del Destino"
  },
  Event_118456_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118456_Desc = {
    Text = "Con un gesto rapido e deciso, le mani si afflosciano.\nMa non ti sfugge l'ultimo sospiro dell'altro.\nFinalmente è libero dai suoi desideri senza fine."
  },
  Event_118456_Name = {
    Text = "Desiderio Vincolante"
  },
  Event_118457_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118457_Desc = {
    Text = "Non essere percepiti è il destino inevitabile del mondo.\nNessuno può provare completa empatia per un altro essere."
  },
  Event_118457_Name = {
    Text = "Lamento impercepito"
  },
  Event_118458_ChoiceDesc1 = {
    Text = "[Listen to the Singing] Ottieni 35 Sigilli Neri, ma sviluppi [(Skill.Arg2)], continua a scegliere"
  },
  Event_118458_ChoiceDesc2 = {
    Text = "[Ignore It] Parti"
  },
  Event_118458_Desc = {
    Text = [[
Il corvo nero come la pece piange.
Il corvo nero come la pece urla.
Il corvo nero come la pece ulula.
Eppure per la gente, sembra solo un canto.
"Ah, che canzone spensierata. Vorrei essere un corvo, lontano dai tormenti del mondo."]]
  },
  Event_118458_Name = {
    Text = "Lamento impercepito"
  },
  Event_118459_ChoiceDesc1 = {
    Text = "[Listen Closely] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_118459_ChoiceDesc2 = {
    Text = "[Plug Ears] Incidi 1 Orazione su 3"
  },
  Event_118459_Desc = {
    Text = "Nella frenesia informe, intravedi un pianoforte.\nUn paio di mani indistinte danza su tasti intangibili, suonando una melodia profana.\nLa musica bizzarra riecheggia dalle profondità della tua anima, viaggia attraverso le tue vene, raggiunge la tua mente tremante."
  },
  Event_118459_Name = {
    Text = "Melodia Profanatrice"
  },
  Event_118460_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118460_Desc = {
    Text = "Quelle ispirazioni, pensieri e fantasie si intrecciano, fondendosi nei colori più brillanti che si possano immaginare.\nVedi lo spazio piegarsi dentro il tuo corpo, il tempo vorticare al tuo comando.\nIn questo istante, sei onnipotente, onnisciente—un tutt'uno con il tempo e lo spazio.\nMa un tale potere ha sempre un prezzo."
  },
  Event_118460_Name = {
    Text = "Caleidoscopio del pensiero"
  },
  Event_118461_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118461_Desc = {
    Text = "L'anima caotica guida il tuo cammino con lamenti striduli.\nÈ sicuro? Non puoi saperlo.\nLa tua unica scelta è andare avanti."
  },
  Event_118461_Name = {
    Text = "Faro dell'Anima"
  },
  Event_118462_ChoiceDesc1 = {
    Text = "[Listen to the Singing] Ottieni 40 Sigilli Neri, ma sviluppi [(Skill.Arg2)], continua a scegliere"
  },
  Event_118462_ChoiceDesc2 = {
    Text = "[Ignore It] Ottieni 25 Sigilli Neri e vattene."
  },
  Event_118462_Desc = {
    Text = [[
Il corvo nero come la pece piange.
Il corvo nero come la pece urla.
Il corvo nero come la pece ulula.
Eppure per la gente, sembra solo un canto.
"Ah, che canzone spensierata. Vorrei essere un corvo, lontano dai tormenti del mondo."]]
  },
  Event_118462_Name = {
    Text = "Lamento impercepito"
  },
  Event_118463_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118463_Desc = {
    Text = "L'anima caotica emette un sospiro dolente.\nSvanisce lentamente, eppure quel suono di pianto, quasi tangibile, si posa sul tuo cuore.\nTum, tum—il tuo battito cardiaco si sincronizza con la melodia del rito."
  },
  Event_118463_Name = {
    Text = "Faro dell'Anima"
  },
  Event_118464_ChoiceDesc1 = {
    Text = "[Leave] Acquisisci la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_118464_Desc = {
    Text = "\"Ah, ah, che agnello devoto è mai questo!\"\nQuella voce sospira, colma di lodi giubilanti.\n\"Quando il mio signore si risveglierà, agnelli come te troveranno certamente un posto in quell'Eccelso e grandioso Reame Divino...\""
  },
  Event_118464_Name = {
    Text = "Predica dell'Intangibile"
  },
  Event_118465_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118465_Desc = {
    Text = "\"Il Cielo\" abbraccia la tua indisciplina.\nUn giorno, il figlio perduto tornerà nell'abbraccio della madre.\nPerché sei Senza Via di Fuga."
  },
  Event_118465_Name = {
    Text = "Abbraccio del mare"
  },
  Event_118466_ChoiceDesc1 = {
    Text = "[Accept the Embrace] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\""
  },
  Event_118466_ChoiceDesc2 = {
    Text = "[Reject the Embrace] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\""
  },
  Event_118466_ChoiceDesc3 = {
    Text = "[Swim to the Surface] Ottieni 25 Sigilli Neri"
  },
  Event_118466_Desc = {
    Text = "Il mondo si riversa fuori attraverso i tuoi occhi.\nIn questo istante, il mare profondo che ti circonda diventa il \"Cielo.\"\nNell'agonia del quasi-annegamento, questo \"Cielo\" blu intenso si avvicina, intenzionato ad abbracciarti.\nNon giudica—dona soltanto."
  },
  Event_118466_Name = {
    Text = "Abbraccio del mare"
  },
  Event_118467_ChoiceDesc1 = {
    Text = "[Scold Them] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\""
  },
  Event_118467_ChoiceDesc2 = {
    Text = "[Rispondere loro] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_118467_ChoiceDesc3 = {
    Text = "[Ignore Them] Ottieni 50 Sigilli Neri"
  },
  Event_118467_Desc = {
    Text = "Tre anime dalle forme vaghe bloccarono il tuo cammino.\nUna figura si inchinò solennemente davanti a te, implorandoti di concedere il tuo sangue. Il tuo sangue che scorre è il miglior sacrificio agli dèi.\nUna figura levò freddamente un coltello verso di te, intenzionata a intagliare la tua carne. Quella carne umana non mutata avrebbe sicuramente conquistato il Favore degli dèi.\nL'ultima ti osservava in silenzio, sperando che ti togliessi la vita per dimostrare la fede più devota."
  },
  Event_118467_Name = {
    Text = "Il miglior sacrificio"
  },
  Event_118468_ChoiceDesc1 = {
    Text = "[Listen to the Singing] Ottieni 30 Sigilli Neri, ma sviluppi [(Skill.Arg2)], continua a scegliere"
  },
  Event_118468_ChoiceDesc2 = {
    Text = "[Ignore It] Parti"
  },
  Event_118468_Desc = {
    Text = [[
Il corvo nero come la pece piange.
Il corvo nero come la pece urla.
Il corvo nero come la pece ulula.
Eppure per la gente, sembra solo un canto.
"Ah, che canzone spensierata. Vorrei essere un corvo, lontano dai tormenti del mondo."]]
  },
  Event_118468_Name = {
    Text = "Lamento impercepito"
  },
  Event_118469_ChoiceDesc1 = {
    Text = "[Leave] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_118469_ChoiceDesc2 = {
    Text = "[Leave] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_118469_ChoiceDesc3 = {
    Text = "[Leave] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_118469_Desc = {
    Text = "\"No! Rifiutiamo! Bramiamo qualcosa di più... delizioso.\"\n\"E allora sia... il vostro sangue e la vostra carne!\"\nUno sciame di ratti stride, avventandosi su di te.\nSembra che un cuore traboccante di bontà possa talvolta portare più guai che sollievo."
  },
  Event_118469_Name = {
    Text = "Branco di Ratti Affamati"
  },
  Event_118470_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118470_Desc = {
    Text = [[
Il tuo rispetto conquista il favore di quegli occhi invisibili.
Prima di svanire, inviano un dono attraverso il mare in tempesta:
un marchio del Mare Profondo impresso su di te.]]
  },
  Event_118470_Name = {
    Text = "Occhio del Mare Profondo"
  },
  Event_118471_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118471_Desc = {
    Text = "Sotto il tuo sguardo imperterrito, il mare profondo lentamente si desta.\nOnde caotiche ribollono intorno a te, portando deliri indescrivibili.\nSenti l'ira dell'abisso—una benedizione e una maledizione intrecciate."
  },
  Event_118471_Name = {
    Text = "Occhio del Mare Profondo"
  },
  Event_118472_ChoiceDesc1 = {
    Text = "[Listen to the Singing] Ottieni 20 Sigilli Neri, ma sviluppi [(Skill.Arg2)]"
  },
  Event_118472_ChoiceDesc2 = {
    Text = "[Ignore It] Parti"
  },
  Event_118472_Desc = {
    Text = [[
Il corvo nero come la pece piange.
Il corvo nero come la pece urla.
Il corvo nero come la pece ulula.
Eppure per la gente, sembra solo un canto.
"Ah, che canzone spensierata. Vorrei essere un corvo, lontano dai tormenti del mondo."]]
  },
  Event_118472_Name = {
    Text = "Lamento impercepito"
  },
  Event_118473_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118473_Desc = {
    Text = "Sangue, carne, vita.\nIl sacrificio è pronto, ora non resta che attendere in silenzio il banchetto divino."
  },
  Event_118473_Name = {
    Text = "Il miglior sacrificio"
  },
  Event_118474_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118474_Desc = {
    Text = [[
La farfalla comprende il tuo rifiuto.
Le sue ali, ricoperte di pece, tremano ancora una volta mentre svolazza incerta nel buio.
Presto le ombre la inghiottono di nuovo. Questa volta le mancano le forze per lottare.]]
  },
  Event_118474_Name = {
    Text = "Richiesta della Farfalla"
  },
  Event_118475_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118475_Desc = {
    Text = "La farfalla si posa nel tuo palmo, come Fiamma del Cuore, insieme alla melma nera delle sue ali variopinte.\nMentre sospiri, le ali vivaci si sciolgono lentamente, fondendosi col catrame in una forma indistinta e caotica.\nQuesta farfalla non conoscerà mai più l'oscurità.\nDorme serena nella tua mano."
  },
  Event_118475_Name = {
    Text = "Richiesta della Farfalla"
  },
  Event_118477_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118477_Desc = {
    Text = "Il corvo rauco infine chiuse gli occhi.\nNel risentimento misconosciuto e inosservato, esalò l'ultimo respiro, trasformandosi in una pozza di melma nera."
  },
  Event_118477_Name = {
    Text = "Lamento impercepito"
  },
  Event_118478_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118478_Desc = {
    Text = "\"Grazie...\"\nIl cuore pulsante balza verso l'orizzonte.\nBen presto, il suono di carne masticata riecheggiò dall'Aequor nero come la pece."
  },
  Event_118478_Name = {
    Text = "Legge del Più Forte"
  },
  Event_118479_ChoiceDesc1 = {
    Text = "[Accept the Invitation] Sviluppi \"(Skill.Arg1)\", ottieni la Reliquia maledetta \"(RelicConfig.Arg2)\""
  },
  Event_118479_ChoiceDesc2 = {
    Text = "[Refuse the Invitation] Scegli di distruggere 1 Reliquia e ottieni 1 Ricompensa"
  },
  Event_118479_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_118479_Desc = {
    Text = "\"Tutto ciò che si trova su questa nave deve diventare parte di questo paradise che si disintegra e si riavvia senza fine.\"\nLe melodie frenetiche risuonarono nella vostra mente, una rivelazione della volontà intangibile.\n\"Qui non vi sono lacrime, né tristezza, solo pura musica sacra e risate eterne.\"\n\"Desiderate unirvi al paradise e diventare parte di questa melodia perfetta?\""
  },
  Event_118479_Name = {
    Text = "L'Inno \"Perfetto\""
  },
  Event_118480_ChoiceDesc1 = {Text = "[Leave]"},
  Event_118480_Desc = {
    Text = [[
Nel tuo silenzio, le anime si dissipano senza un suono.
Coloro che non comprendono i credenti non meritano il loro tempo.]]
  },
  Event_118480_Name = {
    Text = "Il miglior sacrificio"
  },
  Event_123616_ChoiceDesc1 = {
    Text = "[Claim Standard Relic]"
  },
  Event_123616_Desc = {
    Text = [[
Imposta l'Aliemus di tutti i Risvegliati a 100, imposta il Keyflare a 1000 e imposta i PV all'80%.
Rimuovi 2 Carte e inserisci 3 Carte Sintomo.
Imposta la Fornace Cremisi al 12,5%, seleziona 4 Carte da collocare nello Spazio Ultra.
Ottieni il Pacchetto Reliquia Standard.]]
  },
  Event_123616_Name = {
    Text = "Salta il Sentiero"
  },
  Event_125696_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125696_Desc = {
    Text = "Una rabbia immotivata ti pervade. Alzi una mano, colpendo per scacciarli. Sei rimasto troppo a lungo tra gli enigmi; forse brami una battaglia senza tregua, o semplicemente una fine...\nMa i corvi non fanno nulla. Sotto il tuo sguardo, l'abisso si dissolve.\nLo stormo svanisce verso la fine del palcoscenico—il luogo dove devi andare."
  },
  Event_125696_Name = {
    Text = "Abisso dei corvi"
  },
  Event_125697_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125697_Desc = {
    Text = "\"Codardo.\" Non fa alcuno sforzo per nascondere la derisione nella sua risata.\n\"Vai, allora. Più lontano, meglio è.\""
  },
  Event_125697_Name = {
    Text = "Le Catene del Destino"
  },
  Event_125698_ChoiceDesc1 = {
    Text = "[Scacciare] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_125698_ChoiceDesc2 = {
    Text = "[Listen] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\""
  },
  Event_125698_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_125698_Desc = {
    Text = "Un debole fruscio emerge dall'oscurità. Una farfalla cade nel tuo palmo. La ricordi.\n\"Lady Arachne... non ci avete mai veramente abbandonati, vero?\"\nI bellissimi motivi sulle sue ali si rivolgono verso colui che è accanto a te."
  },
  Event_125698_Name = {
    Text = "Il crepuscolo di una Farfalla"
  },
  Event_125699_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125699_Desc = {
    Text = "I suoni e le scritture si insinuano nella tua mente come uno sciame ronzante. Trattieni il respiro, purgando le interferenze inutili dalla tua coscienza.\nIgnorare è ben più arduo che leggere—eppure, ci sei riuscito."
  },
  Event_125699_Name = {
    Text = "Telegramma dimensionale"
  },
  Event_125700_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125700_Desc = {
    Text = "È un'illusione evocata dal nemico!\nScuoti la testa, la lucidità ritorna, e stringi la presa sulla Chiave d'argento."
  },
  Event_125700_Name = {
    Text = "Riflesso nel Vetro"
  },
  Event_125701_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125701_Desc = {
    Text = "Fissi lo sguardo su quell'occhio, sforzandoti di guardare, di ascoltare. Tenti di entrare nel cuore dell'attore e sentire l'agonia che sopporta.\nTi avvicini, e ancora di più. Attraversi il suo corpo e tocchi la sua stessa anima...\nSpalanchi gli occhi e ti ritrovi al centro del palco, lacrime che scorrono lungo le tue dita.\nQuesta è la confessione che offri al pubblico."
  },
  Event_125701_Name = {
    Text = "La confessione di un attore"
  },
  Event_125702_ChoiceDesc1 = {
    Text = "[Discuti con lei] Distruggi una Carta di comando e ricevi Arg1 Sigilli neri"
  },
  Event_125702_ChoiceDesc2 = {
    Text = "[Resta in silenzio]"
  },
  Event_125702_Desc = {
    Text = "\"Un lieto fine va bene, eppure una gioia così vuota non potrà mai toccare i cuori del pubblico...\"\nLa drammaturga chiude gli occhi, assorta nei pensieri. Non è soddisfatta di questa conclusione."
  },
  Event_125702_Name = {
    Text = "Fine dello Spettacolo"
  },
  Event_125703_ChoiceDesc1 = {
    Text = "[Listen to the Singing] Ottieni 35 Sigilli Neri, ma sviluppi [(Skill.Arg2)], continua a scegliere"
  },
  Event_125703_ChoiceDesc2 = {
    Text = "[Ignore It] Parti"
  },
  Event_125703_Desc = {
    Text = "\"Cigola—cigola—la Dea del Destino gira il suo arcolaio.\nCigola—cigola—i Fili del Destino convergono nelle sue mani.\""
  },
  Event_125703_Name = {
    Text = "La Profezia Finale"
  },
  Event_125704_ChoiceDesc1 = {
    Text = "[Self] Duplica 1 di 3 Carte di comando casuali dal mazzo"
  },
  Event_125704_ChoiceDesc2 = {
    Text = "[William] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_125704_ChoiceDesc3 = {
    Text = "[Nessuno] Ricevi 25 Sigilli neri"
  },
  Event_125704_Desc = {
    Text = "Sei certo di non essere ubriaco, eppure mentre fissi l'alcol, ti ritrovi a sprofondare in un lago tranquillo.\nUna figura elegante appare nel vetro. Chi è?"
  },
  Event_125704_Name = {
    Text = "Riflesso nel Vetro"
  },
  Event_125705_ChoiceDesc1 = {
    Text = "[Listen] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_125705_ChoiceDesc2 = {
    Text = "[Dispel] Ricevi 75 Sigilli neri, ma sviluppi il Sintomo [(Skill.Arg2)]"
  },
  Event_125705_Desc = {
    Text = [[
Mentre ti avvicini al potere dell'Eone interiore, uno stormo di corvi appare nella tua mente, volteggiando nel tuo tumultuoso regno spirituale.

I corvi spiraleggiano intorno a te, come un vortice dell'abisso appeso capovolto in alto.
Centomila corvi gridano all'unisono, come una profezia beffarda.]]
  },
  Event_125705_Name = {
    Text = "Abisso dei corvi"
  },
  Event_125706_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125706_Desc = {
    Text = "Tu e Arachne vi sforzate di stabilizzare il destino che crolla accanto a voi. I vostri sforzi producono poco, eppure è sufficiente.\nSfruttando il tempo conquistato a caro prezzo, continui ad avvicinarti a Nefraea.\nSei venuto qui per concederle la liberazione."
  },
  Event_125706_Name = {
    Text = "Cala il sipario sulla Trama del Destino"
  },
  Event_125707_ChoiceDesc1 = {
    Text = "[Listen to the Singing] Ottieni 20 Sigilli Neri, ma sviluppi [(Skill.Arg2)]"
  },
  Event_125707_ChoiceDesc2 = {
    Text = "[Ignore It] Parti"
  },
  Event_125707_Desc = {
    Text = "\"Muoiono con la grande rete, in silenzio.\""
  },
  Event_125707_Name = {
    Text = "La Profezia Finale"
  },
  Event_125708_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125708_Desc = {
    Text = "È un telegramma indirizzato all'Abisso.\n\"Non temete, figli miei. Le porte della prigione si spalancheranno presto; la vostra liberazione è vicina.\""
  },
  Event_125708_Name = {
    Text = "Telegramma dimensionale"
  },
  Event_125709_ChoiceDesc1 = {
    Text = "[Scacciare] 1 Carta di comando casuale ottiene l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_125709_ChoiceDesc2 = {
    Text = "[Listen] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando"
  },
  Event_125709_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_125709_Desc = {
    Text = [[
Una farfalla si posa delicatamente sul tuo palmo. I suoi motivi squisiti ricordano occhi che non battono ciglio, fissandoti in silenzio.
Forse cerca di dirti qualcosa?]]
  },
  Event_125709_Name = {
    Text = "Il riposo della Farfalla"
  },
  Event_125710_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125710_Desc = {
    Text = "Venti paia di occhi addolorati si fissano su di te. Il corvo cessa il suo canto, abbandonando questa rete fatiscente con la sua ultima profezia."
  },
  Event_125710_Name = {
    Text = "La Profezia Finale"
  },
  Event_125711_ChoiceDesc1 = {
    Text = "[Lean Out] Ottieni la Reliquia d'Oro \"(RelicConfig.Arg2)\", ma sviluppi \"(Skill.Arg1)\"."
  },
  Event_125711_ChoiceDesc2 = {
    Text = "[Give Up Checking] Ricevi 50 Sigilli Neri"
  },
  Event_125711_Desc = {
    Text = "Passeggiando oltre l'angolo della strada, noti una modesta sala di proiezione. Non ricordi che un posto simile esistesse a Londinium."
  },
  Event_125711_Name = {
    Text = "Cinema della memoria"
  },
  Event_125712_ChoiceDesc1 = {
    Text = "[Accetta il destino] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando"
  },
  Event_125712_ChoiceDesc2 = {
    Text = "[Sfida il Destino] Sviluppa il Sintomo [(Skill.Arg1)] e cambia l'Orazione da incidere.(Utilizzi: 2/2)"
  },
  Event_125712_Desc = {
    Text = "\"Ah, ci rivediamo, mio caro.\"\nCominci a goderti quella voce femminile che riecheggia nella tua mente. È tenera e seducente, come una ragnatela per catturare le mosche.\n\"Avanti, dimmi—sei disposto ad abbracciare il tuo destino?\""
  },
  Event_125712_Name = {
    Text = "La gabbia del destino"
  },
  Event_125713_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125713_Desc = {
    Text = "\"Sciocco umano, ci conosciamo forse?\"\nIl gatto nero alza gli occhi al cielo con disprezzo e si volta.\n\"Vattene. E non fare mai più una cosa così stupida.\""
  },
  Event_125713_Name = {
    Text = "Forme Mutevoli"
  },
  Event_125714_ChoiceDesc1 = {
    Text = "[Scatta foto] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando"
  },
  Event_125714_ChoiceDesc2 = {
    Text = "[Cambia posa] Sviluppa il Sintomo [(Skill.Arg1)] e cambia l'Orazione da incidere.(Utilizzi: 2/2)"
  },
  Event_125714_Desc = {
    Text = "Una macchina fotografica solitaria si erge sul palco, il suo obiettivo nero pece fisso su di te come il criptico occhio composto forgiato da una divinità meccanica.\nQuesto teatro è rimasto vuoto per così tanto tempo... Benvenuto! Benvenuto! Avanti, scatta una foto! È completamente gratis!\nLa macchina fotografica strilla di eccitazione. Su questo palco abbandonato, è l'unica protagonista."
  },
  Event_125714_Name = {
    Text = "Istantanee dalle Tribune"
  },
  Event_125715_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125715_Desc = {
    Text = "\"Come può chi non chiede nulla al fato sperare in una risposta dal fato?\""
  },
  Event_125715_Name = {
    Text = "Le Catene del Destino"
  },
  Event_125716_ChoiceDesc1 = {
    Text = "[Trova una via d'uscita] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\""
  },
  Event_125716_ChoiceDesc2 = {
    Text = "[Lascia correre] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\" e \"(Skill.Arg3)\""
  },
  Event_125716_ChoiceDesc3 = {
    Text = "[Surface] Ricevi 25 Sigilli Neri"
  },
  Event_125716_Desc = {
    Text = "Un nuovo palcoscenico. Due vite intrecciate... Mentre sfuggi agli ufficiali, riordini le verità che Arachne ha condiviso con te.\nFra i pensieri aggrovigliati, sprofondi in un mare profondo e tranquillo."
  },
  Event_125716_Name = {Text = "Placido"},
  Event_125717_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125717_Desc = {
    Text = "La farfalla si posa sulla tua spalla, avvicinandosi al tuo orecchio. Ascolti attentamente, eppure odi solo il debole ronzio delle ali—un suono simile a un sospiro senza voce.\nMentre ascolti, le ali iridescenti cominciano a dissolversi, e la farfalla cade in un sonno eterno sulla tua spalla.\nIl messaggio che portava è perduto per te per sempre."
  },
  Event_125717_Name = {
    Text = "Il crepuscolo di una Farfalla"
  },
  Event_125718_ChoiceDesc1 = {
    Text = "[Dai un Morso] Risveglio di 1 Risvegliatore casuale, ma sviluppi [(Skill.Arg1)]"
  },
  Event_125718_ChoiceDesc2 = {
    Text = "[Refuse] Incidi 1 Orazione su 3"
  },
  Event_125718_Desc = {
    Text = [[
"Hai fame, mio caro ospite?"
Una voce viscosa si leva da dietro il bancone. Ti volti, ma non vedi nulla.
"Gli stuzzichini del Ballo in Maschera di Mezzanotte sono anch'essi piuttosto rinomati. Vuoi assaggiare?"]]
  },
  Event_125718_Name = {
    Text = "Il sapore del destino"
  },
  Event_125719_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125719_Desc = {
    Text = [[
Non osi leggere il testo all'interno, scegliendo invece di osservare la busta squisita.
Il sigillo di ceralacca reca uno stemma sfocato, con un'elegante scrittura corsiva sopra:
"Alla neonata signorina Arachne."
"Il vostro fedele maggiordomo, Edgar."]]
  },
  Event_125719_Name = {
    Text = "Buonanotte, Signor Edgar"
  },
  Event_125720_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125720_Desc = {
    Text = "\"Capisco. Ora comprendo, sorella...\"\n\"Una drammaturga non può mai riscrivere il finale di un personaggio. Quel destino miserabile era segnato da tempo; nemmeno tu potresti cambiarlo...\"\nIl singhiozzo triste svanisce. La macchina da scrivere della drammaturga si dissolve in farfalle, disperdendosi nel Teatro del Destino vuoto fino a non lasciare traccia."
  },
  Event_125720_Name = {
    Text = "Fine dello Spettacolo"
  },
  Event_125721_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125721_Desc = {
    Text = "Attori sconosciuti, passi pericolosi... che importa? Nulla può essere peggiore del destino stesso.\nTendi la mano e sali sul palcoscenico. Le marionette ti prendono per mano, trascinandoti in una danza gioiosa.\nSenti gli applausi."
  },
  Event_125721_Name = {
    Text = "Pas de Trois"
  },
  Event_125722_ChoiceDesc1 = {
    Text = "[Listen to the Singing] Ottieni 25 Sigilli Neri, ma sviluppi [(Skill.Arg2)], continua a scegliere"
  },
  Event_125722_ChoiceDesc2 = {
    Text = "[Ignore It] Parti"
  },
  Event_125722_Desc = {
    Text = "\"Danzano. Cantano. Scric—scric—\""
  },
  Event_125722_Name = {
    Text = "La Profezia Finale"
  },
  Event_125723_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125723_Desc = {
    Text = "La guida, il compagno—l'unico alleato in questa dimensione solitaria.\nRisolverete tutto qui insieme e tornerete a Kadath. Non ne hai mai dubitato."
  },
  Event_125723_Name = {
    Text = "Riflesso nel Vetro"
  },
  Event_125724_ChoiceDesc1 = {
    Text = "[Take a Gamble] Sviluppa [(Skill.Arg1)] e tenta la sorte"
  },
  Event_125724_ChoiceDesc2 = {
    Text = "[Forget It] Ottieni 25 Sigilli Neri"
  },
  Event_125724_Desc = {
    Text = "All'angolo di un vicolo, un paio di mani sudice ti sbarra il cammino.\nUn mendicante in stracci si avvicina, gli occhi avidi come quelli di una iena che fiuta la carogna.\n\"Avanti! Un giro! Ti dirò tutto ciò che desideri sapere... se solo vincerai...\""
  },
  Event_125724_Name = {
    Text = "Scommessa di Strada"
  },
  Event_125725_ChoiceDesc1 = {
    Text = "[Ignore] Distruggere una Carta di comando e ricevere 25 Sigilli neri"
  },
  Event_125725_ChoiceDesc2 = {
    Text = "[Read] Duplica 1 Carta dal mazzo, ma sviluppi il Sintomo [(Skill.Arg1)]"
  },
  Event_125725_Desc = {
    Text = "Tac, tac, tac... Tac, tac, tac...\nL'angolo del bar è deserto; il fax squilla con una cadenza nitida e ritmica, come una graziosa sonata per pianoforte."
  },
  Event_125725_Name = {
    Text = "Telegramma dimensionale"
  },
  Event_125726_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125726_Desc = {
    Text = "\"Silenzio. Sono un gatto. Non ho alcun interesse per le tue noiose storie.\"\n\nIl gatto sospira e si volta.\n\n\"Vattene. E non fare mai più una cosa così stupida.\""
  },
  Event_125726_Name = {
    Text = "Forme Mutevoli"
  },
  Event_125727_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125727_Desc = {
    Text = "Forse ha ragione. Quello sei tu—i pensieri più oscuri e abietti nel profondo della tua anima.\nOgni uomo è egoista; non sei mai stato nobile come gli altri credevano.\nAssapori quel dolore miserabile. Sai che il passato è andato, e la tua salvezza è davanti a te."
  },
  Event_125727_Name = {
    Text = "Agonia dilagante"
  },
  Event_125728_ChoiceDesc1 = {
    Text = "[Discuti con lei] Distruggi una Carta di comando e ricevi Arg1 Sigilli neri"
  },
  Event_125728_ChoiceDesc2 = {
    Text = "[Resta in silenzio]"
  },
  Event_125728_Desc = {
    Text = "\"Un finale tragico è veritiero, eppure la nostra realtà è già così miserabile. Non possiamo concederle un destino più gentile almeno in una storia...?\"\nLa drammaturga chiude gli occhi, assorta nei pensieri. Non è soddisfatta di questa conclusione."
  },
  Event_125728_Name = {
    Text = "Fine dello Spettacolo"
  },
  Event_125729_ChoiceDesc1 = {
    Text = "[Leave] Ottieni la Reliquia d'Oro [(RelicConfig.Arg1)]"
  },
  Event_125729_Desc = {
    Text = "Tric-trac. I dadi danzano selvaggiamente nel bicchiere, girando fino allo sfinimento.\n\n\"Perché... perché nessuno vince mai?!\""
  },
  Event_125729_Name = {
    Text = "Scommessa di Strada"
  },
  Event_125730_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125730_Desc = {
    Text = [[
Ti avvicini, sforzandoti di udire il suo sussurro.
La farfalla batte le ali e si allontana dal tuo palmo.
Non senti assolutamente nulla.]]
  },
  Event_125730_Name = {
    Text = "Il riposo della Farfalla"
  },
  Event_125731_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125731_Desc = {
    Text = "La farfalla non si lascia commuovere dai tuoi gesti.\nInsegue il tuo palmo con una quieta persistenza—e solo quando alzi il braccio un'ultima volta sceglie di andarsene.\nUn fremito di rimpianto si agita. Forse... avresti dovuto ascoltare?"
  },
  Event_125731_Name = {
    Text = "Il riposo della Farfalla"
  },
  Event_125732_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125732_Desc = {
    Text = [[
La nebbia nera freme nella desolazione; le grida agonizzanti del mendicante sono strazianti.
In un batter d'occhio, il dado e il mendicante svaniscono. Nel cappello logoro, la ricompensa del gioco rimane.]]
  },
  Event_125732_Name = {
    Text = "Scommessa di Strada"
  },
  Event_125733_ChoiceDesc1 = {
    Text = "[Unisciti ai festeggiamenti] Acquisisci la Reliquia maledetta \"(RelicConfig.Arg2)\", ma sviluppi \"(Skill.Arg1)\""
  },
  Event_125733_ChoiceDesc2 = {
    Text = "[Ferma la musica] Distruggi 1 Reliquia e ottieni 1 ricompensa"
  },
  Event_125733_ChoiceDesc3 = {
    Text = "[Copriti le orecchie] Ricevi 50 Sigilli neri"
  },
  Event_125733_Desc = {
    Text = "\"Ah! Musica! Come può esistere un grande spettacolo senza musica!!\"\nUna sinfonia discordante si leva nel teatro in frantumi, come un tripudio di caos. Attori dall'Abisso danzano e festeggiano in quest'ode disordinata, deliziandosi nelle note che li sostengono."
  },
  Event_125733_Name = {
    Text = "Ode al Destino"
  },
  Event_125734_ChoiceDesc1 = {
    Text = "[Tune] Ricevi 100 Sigilli Neri"
  },
  Event_125734_ChoiceDesc2 = {
    Text = "[2 Carte di comando casuali ottengono l'Orazione: \"(EnchantConfig.Arg1)\"]"
  },
  Event_125734_Desc = {
    Text = "Fili invisibili del destino danzano tra le note. In quel rumore caotico, inizi a seguire il filo della melodia ammaliante — in effetti, quello è il vero suono del destino.\nI reietti dell'Abisso esultano per te, affollandosi intorno a te, trascinandoti nel loro tripudio disordinato.\nCongratulazioni, spettatore fortunato! Ora ti unirai agli attori nel sipario finale del destino."
  },
  Event_125734_Name = {
    Text = "Ode al Destino"
  },
  Event_125735_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125735_Desc = {
    Text = "Non riesci a discernere il significato di questo suono, ma sai che deve cessare.\nLa luce d'Argento fende come una lama impazzita. Il suo ritmo, in qualche modo, cade perfettamente a tempo con le note.\nPrima che tu te ne renda conto, la musica è cessata. Non senti più nulla. Vedi solo la notte; odi solo il silenzio.\nCacofonia disordinata o silenzio assoluto — cosa è più terrificante... Custode?"
  },
  Event_125735_Name = {
    Text = "Ode al Destino"
  },
  Event_125736_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125736_Desc = {
    Text = "Tendi la mano; una farfalla si posa delicatamente sul tuo palmo.\nIn effetti. La morte, la dissoluzione, lo scorrere del tempo... La farfalla nasce dal bozzolo; l'agonia è il terreno eterno dell'arte.\nCome eccellente spettatore, questa è una verità che devi comprendere."
  },
  Event_125736_Name = {
    Text = "Fioritura nella Dissoluzione"
  },
  Event_125737_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125737_Desc = {
    Text = "Forse questo non è che un altro dei trucchi di Nefraea.\nLa farfalla comprende le tue parole; un sospiro silenzioso riecheggia nell'oscurità. Ali ricoperte di melma nera tremano, e presto, la sua forma appesantita viene inghiottita dall'oscurità sconfinata.\nIl messaggio che portava è perduto per te per sempre."
  },
  Event_125737_Name = {
    Text = "Il crepuscolo di una Farfalla"
  },
  Event_125738_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_125738_Desc = {
    Text = "Tric-trac. I dadi danzano selvaggiamente nel bicchiere, girando fino allo sfinimento.\n\n\"Perché... perché nessuno vince mai?!\""
  },
  Event_125738_Name = {
    Text = "Scommessa di Strada"
  },
  Event_125739_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125739_Desc = {
    Text = "Lasciare vagare i pensieri senza controllo ora è pericoloso. Scuoti la testa e riemergi immediatamente."
  },
  Event_125739_Name = {Text = "Placido"},
  Event_125740_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125740_Desc = {
    Text = [[
Non ogni nota richiede un ascoltatore; non ogni destino richiede una risposta.
Premi saldamente le mani sulle orecchie e lasci il palcoscenico clamoroso.
Rimani curioso riguardo al significato di quella musica discordante, eppure sai di aver fatto l'unica scelta giusta.]]
  },
  Event_125740_Name = {
    Text = "Ode al Destino"
  },
  Event_125741_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125741_Desc = {
    Text = "La luce argentea squarcia l'illusione; i gatti neri si dissolvono in pozze di melma nera.\nMutare in forma felina per nascondersi... il mostro non può sfuggire ai tuoi occhi."
  },
  Event_125741_Name = {
    Text = "Forme Mutevoli"
  },
  Event_125742_ChoiceDesc1 = {
    Text = "[Accetta il destino] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando"
  },
  Event_125742_Desc = {
    Text = "\"Nessuno può davvero sfidare il destino, mio caro. Non abbiamo mai posseduto il diritto di scegliere.\"\nLa voce si fa sconsolata e distante. Non sai se parli a te, o a qualcos'altro del tutto."
  },
  Event_125742_Name = {
    Text = "La gabbia del destino"
  },
  Event_125743_ChoiceDesc1 = {
    Text = "[Listen to the Singing] Ottieni 30 Sigilli Neri, ma sviluppi [(Skill.Arg2)], continua a scegliere"
  },
  Event_125743_ChoiceDesc2 = {
    Text = "[Ignore It] Parti"
  },
  Event_125743_Desc = {
    Text = "\"Le marionette si mettono in fila per il loro ingresso, entrando nella grande ragnatela del destino.\""
  },
  Event_125743_Name = {
    Text = "La Profezia Finale"
  },
  Event_125744_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125744_Desc = {
    Text = "Alzi lo sguardo verso il vortice dell'abisso, sforzandoti di udire l'oracolo dei corvi.\nMa non dicono nulla. Sotto il tuo sguardo, l'abisso si dissolve.\nLo stormo svanisce verso la fine del palcoscenico—il luogo dove devi andare."
  },
  Event_125744_Name = {
    Text = "Abisso dei corvi"
  },
  Event_125745_ChoiceDesc1 = {
    Text = "[Agree] Rimuovi 2 Carte"
  },
  Event_125745_ChoiceDesc2 = {
    Text = "[Disagree] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\""
  },
  Event_125745_ChoiceDesc3 = {
    Text = "[Leave] Ricevi Arg1 Sigilli Neri"
  },
  Event_125745_Desc = {
    Text = [[
Il sipario del palcoscenico tremola nel vento. Tra la melma nera che cola da un cadavere, scorgi un gruppo di farfalle.
"La vera arte fiorisce sempre nella dissoluzione... non sei d'accordo, Custode?"
Il cadavere della danzatrice ti sorride. Senti il battito delle ali.]]
  },
  Event_125745_Name = {
    Text = "Fioritura nella Dissoluzione"
  },
  Event_125746_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125746_Desc = {
    Text = [[
I sofismi non potranno mai piegarti. Sai chiaramente il sentiero che percorri e la destinazione che cerchi.
Le spine si dissolvono dentro di te. Ti incammini sulla strada, come hai sempre fatto.]]
  },
  Event_125746_Name = {
    Text = "Agonia dilagante"
  },
  Event_125747_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125747_Desc = {
    Text = "Ti volti, tentando di dimenticare gli occhi alle tue spalle. Ma scopri che il tuo corpo non si muove più liberamente come un tempo.\nLo sai—da quegli sguardi fissi, non sfuggirai mai."
  },
  Event_125747_Name = {
    Text = "Il pubblico"
  },
  Event_125748_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125748_Desc = {
    Text = [[
Che sia per rispetto o per timore, non riesci a disturbarla, e riponi la busta al suo posto. Mentre ti volti per andartene, una voce roca ma gentile emerge dalle ombre dietro la lettera:
"Grazie per ricordarvi ancora di me, signorina Arachne..."]]
  },
  Event_125748_Name = {
    Text = "Buonanotte, Signor Edgar"
  },
  Event_125749_ChoiceDesc1 = {
    Text = "[Potere per proteggere] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_125749_ChoiceDesc2 = {
    Text = "[Libertà di fuggire] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 Carta di comando casuale"
  },
  Event_125749_ChoiceDesc3 = {
    Text = "[Rifiuta di rispondere] Ricevi 50 Sigilli neri"
  },
  Event_125749_Desc = {
    Text = [[
Il liquore del Ballo in Maschera di Mezzanotte si insinua nella tua mente come catene che si stringono. Lungo i freddi anelli di ferro, la voce di una giovane donna perseguita la tua coscienza.
"Dimmi, caro. Quale destino desideri davvero?"]]
  },
  Event_125749_Name = {
    Text = "Le Catene del Destino"
  },
  Event_125750_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125750_Desc = {
    Text = "Anche gli affari più complicati devono essere risolti dalla tua mano.\nIl peso si fa più gravoso, eppure con esso sorge una forza nuova e sconosciuta."
  },
  Event_125750_Name = {Text = "Placido"},
  Event_125751_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125751_Desc = {
    Text = "Attori sconosciuti, passi pericolosi. In effetti, la fuga è l'unico porto sicuro.\nTi volti e corri, squarciando i tendoni del teatro, solo per ritrovarti in piedi sul palcoscenico. Le marionette ti prendono per mano, trascinandoti in una danza gioiosa.\nSul palcoscenico del destino, non esiste mai una scelta."
  },
  Event_125751_Name = {
    Text = "Pas de Trois"
  },
  Event_125752_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125752_Desc = {
    Text = "Non è il momento per un film."
  },
  Event_125752_Name = {
    Text = "Cinema della memoria"
  },
  Event_125753_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125753_Desc = {
    Text = "I pericoli del viaggio non sfiorano mai la tua mente. Cammini tra i frammenti del destino che crolla, avvicinandoti sempre più a Nefraea.\nSei venuto qui per concederle la liberazione."
  },
  Event_125753_Name = {
    Text = "Cala il sipario sulla Trama del Destino"
  },
  Event_125754_ChoiceDesc1 = {
    Text = "[Leggi la busta] Acquisisci la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\""
  },
  Event_125754_ChoiceDesc2 = {
    Text = "[Leggi la lettera] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando"
  },
  Event_125754_ChoiceDesc3 = {
    Text = "[Put it back]Ottieni 50 Il sigillo nero"
  },
  Event_125754_Desc = {
    Text = [[
I tuoi movimenti squarciano le fitte ragnatele; una lettera invecchiata cade dalla seta.
Il suo peso supera di gran lunga quello che un sottile foglio di carta dovrebbe avere.]]
  },
  Event_125754_Name = {
    Text = "Buonanotte, Signor Edgar"
  },
  Event_125755_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125755_Desc = {
    Text = "Lacrime cadono dagli occhi del corvo. Sangue cola dal suo becco. Con le ultime forze, il corvo canta la sua profezia finale per te."
  },
  Event_125755_Name = {
    Text = "La Profezia Finale"
  },
  Event_125756_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125756_Desc = {
    Text = "\"Hehe... Hahahaha!\"\n\"Com'è, mio ospite? Il sapore del destino... scoprirai di desiderarlo, follemente, senza fine…\""
  },
  Event_125756_Name = {
    Text = "Il sapore del destino"
  },
  Event_125757_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125757_Desc = {
    Text = [[
"Noioso." Emette uno sbadiglio svogliato.
"Prendi il tuo potere e vai a fare a pugni al club."]]
  },
  Event_125757_Name = {
    Text = "Le Catene del Destino"
  },
  Event_125758_ChoiceDesc1 = {
    Text = "[Stabilizza la Trama del destino] Ottieni 1 Orazione avanzata a scelta tra 3"
  },
  Event_125758_ChoiceDesc2 = {
    Text = "[Ignora il Pericolo] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\""
  },
  Event_125758_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_125758_Desc = {
    Text = "Lei è la prediletta della grazia. Lei è la trovatella del destino. Lei è la vendicatrice che strisciò fuori dall'abisso, seguendo una fioca scintilla di luce. Viene ora per portare la liberazione a tutti.\nLa Trama del Destino crolla e decade intorno a te. Ti trovi sul palcoscenico del teatro, la distanza tra te e Nefraea si riduce."
  },
  Event_125758_Name = {
    Text = "Cala il sipario sulla Trama del Destino"
  },
  Event_125759_ChoiceDesc1 = {
    Text = "[Indifferent] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_125759_ChoiceDesc2 = {
    Text = "[Empathetic] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\""
  },
  Event_125759_Desc = {
    Text = "Lamenti laceranti erompono dal palco mentre l'unico riflettore cade su una figura solitaria.\nTi offre la sua interpretazione più sincera—spalancando il petto per presentare le sue viscere a ogni spettatore.\nCos'è che tormenta tanto questo personaggio?"
  },
  Event_125759_Name = {
    Text = "La confessione di un attore"
  },
  Event_125760_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125760_Desc = {
    Text = "Tendi la mano verso destra.\nLì giace il tuo futuro: il tuo desiderio più intenso, il tuo rifugio ultimo e la destinazione che alla fine raggiungerai.\nLa tua esistenza serve solo a inseguire il sole che ti precede."
  },
  Event_125760_Name = {
    Text = "Passato, Futuro"
  },
  Event_125761_ChoiceDesc1 = {
    Text = "[Three Points]"
  },
  Event_125761_ChoiceDesc2 = {
    Text = "[Six Points]"
  },
  Event_125761_ChoiceDesc3 = {
    Text = "[One Point]"
  },
  Event_125761_Desc = {
    Text = "Potresti semplicemente andartene, eppure il dado squisito ti affascina completamente.\nDimenticando gli inseguitori alle tue spalle, lo raccogli con reverenza e lo lanci nel cilindro—"
  },
  Event_125761_Name = {
    Text = "Scommessa di Strada"
  },
  Event_125762_ChoiceDesc1 = {
    Text = "[Leave] Acquisisci la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_125762_Desc = {
    Text = "Tric-trac. I dadi danzano selvaggiamente nel bicchiere, girando fino allo sfinimento.\n\n\"Perché... perché nessuno vince mai?!\""
  },
  Event_125762_Name = {
    Text = "Scommessa di Strada"
  },
  Event_125763_ChoiceDesc1 = {
    Text = "[Accetta il destino] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando"
  },
  Event_125763_ChoiceDesc2 = {
    Text = "[Sfida il Destino] Sviluppa il Sintomo [(Skill.Arg1)] e cambia l'Orazione da incidere.(Utilizzi: 1/2)"
  },
  Event_125763_Desc = {
    Text = "\"Ah, birichino. Il destino è sempre misericordioso... ma ogni resistenza ha un prezzo. Ora, sei disposto ad accettarlo?\""
  },
  Event_125763_Name = {
    Text = "La gabbia del destino"
  },
  Event_125764_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125764_Desc = {
    Text = [[
Ti guardi intorno verso quegli sguardi e alzi una mano in saluto.
Presto, concederai loro il crescendo della storia.]]
  },
  Event_125764_Name = {
    Text = "Il pubblico"
  },
  Event_125765_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125765_Desc = {
    Text = "\"Cara signorina Arachne, oggi è il giorno della vostra nascita. Provo gioia per il Padrone, la Signora e per voi. Benvenuta in questo mondo meraviglioso. Vi offro questa dolce ninna nanna, augurandovi una vita libera da preoccupazioni da questo giorno in poi...\""
  },
  Event_125765_Name = {
    Text = "Buonanotte, Signor Edgar"
  },
  Event_125766_ChoiceDesc1 = {
    Text = "[Scatta foto] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando"
  },
  Event_125766_ChoiceDesc2 = {
    Text = "[Cambia ancora] Sviluppa il Sintomo [(Skill.Arg1)] e cambia l'Orazione da incidere.(Utilizzi: 1/2)"
  },
  Event_125766_Desc = {
    Text = "Senti un brivido di trepidazione davanti all'obiettivo. Forse questa posa sarebbe migliore? O quella?"
  },
  Event_125766_Name = {
    Text = "Istantanee dalle Tribune"
  },
  Event_125767_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125767_Desc = {
    Text = "Vorresti vederne il contenuto, ma lo schermo è vuoto. Solo il suono della pellicola che gira riecheggia nella sala.\nForse passerà molto tempo prima che tu scopra cosa si cela nelle bobine."
  },
  Event_125767_Name = {
    Text = "Cinema della memoria"
  },
  Event_125768_ChoiceDesc1 = {
    Text = "[Avoid Gaze] Risveglio di un Risvegliatore casuale"
  },
  Event_125768_ChoiceDesc2 = {
    Text = "[Stare] Scegli un Risvegliatore da Risvegliare, riduci il Costo di Arithmetica di quella Carta di 2, ma sviluppa [(Skill.Arg1)]."
  },
  Event_125768_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_125768_Desc = {
    Text = [[
Mentre sali sul palco, senti un frusciare di sussurri. Ti volti; diecimila paia di occhi fluttuano attorno al palco, fissandoti.
Vieni! dicono. Sicuramente lo squisito dramma non finisce qui?
Danza! dicono. Regalaci il climax di questa danza!]]
  },
  Event_125768_Name = {
    Text = "Il pubblico"
  },
  Event_125769_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125769_Desc = {
    Text = "Non comprendi il suo dolore, né ne hai bisogno.\nIl teatro ospita molti palchi, e i palchi molte marionette; tu sei solo una di esse.\nHai cose più importanti da fare."
  },
  Event_125769_Name = {
    Text = "La confessione di un attore"
  },
  Event_125770_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125770_Desc = {
    Text = "La morte, la dissoluzione, lo scorrere del tempo... L'arte non esiste per infliggere dolore. Se la bellezza risiede solo nella sofferenza, allora è meglio che tale bellezza non nasca affatto.\nColpisci per scacciarle. Le farfalle si disperdono, lasciando dietro un cadavere addolorato."
  },
  Event_125770_Name = {
    Text = "Fioritura nella Dissoluzione"
  },
  Event_125771_ChoiceDesc1 = {
    Text = "[Listen to the Singing] Ottieni 40 Sigilli Neri, ma sviluppi [(Skill.Arg2)], continua a scegliere"
  },
  Event_125771_ChoiceDesc2 = {
    Text = "[Ignore It] Ottieni 25 Sigilli Neri e vattene."
  },
  Event_125771_Desc = {
    Text = "I corvi sparsi che hanno incrociato il tuo cammino convergono in uno solo. Si posa davanti a te e canta, la sua melodia desolata—come l'ultima profezia."
  },
  Event_125771_Name = {
    Text = "La Profezia Finale"
  },
  Event_125772_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125772_Desc = {
    Text = "Tendi la mano verso sinistra.\nLì giace il tuo passato: i tuoi ricordi più preziosi, il cammino che hai percorso e il luogo a cui alla fine farai ritorno.\nTutto ciò che è stato forma tutto ciò che sei."
  },
  Event_125772_Name = {
    Text = "Passato, Futuro"
  },
  Event_125773_ChoiceDesc1 = {
    Text = "[Scatta foto] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando"
  },
  Event_125773_Desc = {
    Text = [[
Senti un brivido di trepidazione davanti all'obiettivo. Forse questa posa sarebbe migliore? O quella?
Esiti ancora, ma percepisci la crescente irritazione della macchina fotografica.]]
  },
  Event_125773_Name = {
    Text = "Istantanee dalle Tribune"
  },
  Event_125774_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125774_Desc = {
    Text = "Assumi una posa davanti alla macchina fotografica—composto, curioso, assorto. Come un vero spettatore.\nGorgoglio—\nL'otturatore scatta. Fanghiglia nera erutta dal corpo della macchina fotografica, schizzando su tutto il palco.\nNel centro cavo del corpo della macchina, la pellicola rimane vuota."
  },
  Event_125774_Name = {
    Text = "Istantanee dalle Tribune"
  },
  Event_125775_ChoiceDesc1 = {
    Text = "[Accept] Ottieni 1 Reliquia d'argento su 3"
  },
  Event_125775_ChoiceDesc2 = {
    Text = "[Flee] Ottieni le Reliquie d'argento \"(RelicConfig.Arg1)\" e \"(RelicConfig.Arg2)\", ma sviluppa \"(Skill.Arg3)\" due volte"
  },
  Event_125775_Desc = {
    Text = [[
Tac-tac, tac-tac... I tacchi colpiscono le assi del palco con un suono vivace e allegro.
Due marionette in uniforme scolastica danzano sul palcoscenico. All'improvviso, arrestano i loro passi e si voltano per tendere le mani verso di te.]]
  },
  Event_125775_Name = {
    Text = "Pas de Trois"
  },
  Event_125776_ChoiceDesc1 = {
    Text = "[Sopportare l'Agonia] Aumenta la Salute massima di Arg1"
  },
  Event_125776_ChoiceDesc2 = {
    Text = "[Confutare il dolore] 1 Carta di comando casuale ottiene l'Orazione: \"(EnchantConfig.Arg1)\", infetta 1 \"(Skill.Arg2)\""
  },
  Event_125776_Desc = {
    Text = "\"Non ti è mai importato della morte di Liz. Non ti è mai importato di nessuno.\"\n\"Ti importa solo di te stesso... tutti intorno a te non sono che strumenti per il tuo cammino verso la libertà e la pace.\"\n\"Non è forse così... Custode?\"\nIl sussurro dell'Annunciatrice ti graffia l'orecchio. Il tuo cuore si stringe; un'agonia acuta si diffonde nel tuo corpo con le sue parole..."
  },
  Event_125776_Name = {
    Text = "Agonia dilagante"
  },
  Event_125777_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125777_Desc = {
    Text = "Abbandonati alla discesa; il mare possiede la propria spinta, e il fato rivelerà il cammino per entrambi."
  },
  Event_125777_Name = {Text = "Placido"},
  Event_125778_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125778_Desc = {
    Text = "Sei tu stesso. La fonte del potere, il portatore del dovere, l'unico oggetto di lealtà.\nPercorri il sentiero che appartiene solo a te."
  },
  Event_125778_Name = {
    Text = "Riflesso nel Vetro"
  },
  Event_125779_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125779_Desc = {
    Text = "\"Che peccato, mio ospite. Il sapore del destino... non avrai mai più la possibilità di assaporarlo...\""
  },
  Event_125779_Name = {
    Text = "Il sapore del destino"
  },
  Event_125780_ChoiceDesc1 = {
    Text = "[Discuti con lei] Distruggi una Carta di comando e ricevi Arg1 Sigilli neri"
  },
  Event_125780_ChoiceDesc2 = {
    Text = "[Resta in silenzio]"
  },
  Event_125780_Desc = {
    Text = "\"Che spettacolo triste... Quella povera ragazza è stata abbandonata da colui che amava, sorella?\"\nIn quella voce familiare, non percepisci traccia di follia o malvagità. È limpida e malinconica, come un dolce ruscello nel bosco.\n\"La cantante, una foglia appassita alla deriva, indifesa, lasciata in balia del destino... Che anima miseranda...\"\n\"Sorella, se io fossi l'autrice... che finale dovrei scrivere per lei?\""
  },
  Event_125780_Name = {
    Text = "Fine dello Spettacolo"
  },
  Event_125781_ChoiceDesc1 = {
    Text = "[Accarezzali] 50% di probabilità di ricevere 125 Sigilli neri; 50% di probabilità di sviluppare [(Skill.Arg2)]"
  },
  Event_125781_ChoiceDesc2 = {
    Text = "[Explain] 75% di probabilità di ricevere 100 Sigilli neri; 25% di probabilità di sviluppare [(Skill.Arg2)]"
  },
  Event_125781_ChoiceDesc3 = {
    Text = "[Vedi oltre] Ricevi 50 Sigilli neri"
  },
  Event_125781_Desc = {
    Text = [[
Mentre insegui il mostro nel vicolo dietro il bar, la sua sagoma svanisce. Un gruppo di gatti neri ti sbarra la strada.
"Ehi, tu." Un gatto nero si lecca la zampa, guardando verso di te.
"Che ci fai nel nostro territorio?"]]
  },
  Event_125781_Name = {
    Text = "Forme Mutevoli"
  },
  Event_125782_ChoiceDesc1 = {
    Text = "[Abbraccia il Passato] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\""
  },
  Event_125782_ChoiceDesc2 = {
    Text = "[Accogli il Futuro] Ottieni 1 Reliquia d'oro su 3, ma sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_125782_ChoiceDesc3 = {
    Text = "[Leave] Acquisisci la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_125782_Desc = {
    Text = "La presenza di Nefraea ha perturbato i fili. Nel destino distorto, scorgi due apparizioni sfocate.\nUna è il tuo passato; l'altra, il tuo futuro. Cammini verso di loro e tendi la mano..."
  },
  Event_125782_Name = {
    Text = "Passato, Futuro"
  },
  Event_125855_ChoiceDesc1 = {
    Text = "[Perceive] Potenzia 1 Reliquia nella Reliquia d'oro [(RelicConfig.Arg1)]"
  },
  Event_125855_ChoiceDesc2 = {
    Text = "[Stare] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_125855_ChoiceDesc3 = {
    Text = "[Ignore] Ricevi 25 Sigilli Neri"
  },
  Event_125855_Desc = {
    Text = "Per le strade di Kasalim, lo splendido bagliore di un negozio di cristalli ti attira. Ti fermi davanti alla vetrina e raccogli un cristallo a forma di Nucleo d'argento."
  },
  Event_125855_Name = {
    Text = "Il Segreto del Cristallo"
  },
  Event_125856_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125856_Desc = {
    Text = [[
Chiudi gli occhi, percependolo con cura.
Un barlume di luce tremola nella tua coscienza, come se cercasse di dirti qualcosa...]]
  },
  Event_125856_Name = {
    Text = "Il Segreto del Cristallo"
  },
  Event_125857_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125857_Desc = {
    Text = "Qualsiasi resistenza o indagine sul destino è futile. Chiudi silenziosamente gli occhi, permettendo al fato di portarti dove sei destinato ad andare."
  },
  Event_125857_Name = {
    Text = "La Trappola del Destino"
  },
  Event_125858_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125858_Desc = {
    Text = "\"L'emozione è il senso dell'esistenza. Che tu non debba mai rimpiangere la tua scelta.\""
  },
  Event_125858_Name = {
    Text = "Il Prezzo della Scelta"
  },
  Event_125859_ChoiceDesc1 = {
    Text = "[Emotion] Ripristina Arg1 Vita"
  },
  Event_125859_ChoiceDesc2 = {
    Text = "[Reason] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 Carta di comando casuale"
  },
  Event_125859_ChoiceDesc3 = {
    Text = "[Refuse to Choose] Ricevi 25 Sigilli Neri"
  },
  Event_125859_Desc = {
    Text = "Una bilancia appare sul palcoscenico.\n\"Cervello e cuore, ragione ed emozione, grigio e rosso... non possiamo eludere la scelta; è il nostro destino.\"\n\"Il finale dello spettacolo è già scritto. Ora, scegli il sentiero che questa rappresentazione dovrà percorrere.\""
  },
  Event_125859_Name = {
    Text = "Il Prezzo della Scelta"
  },
  Event_125860_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125860_Desc = {
    Text = [[
"Non guardare in alto. Lascia questo luogo."
Odi la voce del destino. Sebbene tu brami di contemplare il cielo, sai che ha ragione.]]
  },
  Event_125860_Name = {
    Text = "Guardando in Alto"
  },
  Event_125861_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125861_Desc = {
    Text = [[
Non accetti mai il destino. Non accetti mai la prigionia.
Lotti con tutte le tue forze. Dopo aver sacrificato un arto di falena, finalmente conquisti la fuga...]]
  },
  Event_125861_Name = {
    Text = "La Trappola del Destino"
  },
  Event_125862_ChoiceDesc1 = {
    Text = "[Friendship] Ricevi 50 Sigilli neri"
  },
  Event_125862_ChoiceDesc2 = {
    Text = "[Help] Ricevi 75 Sigilli neri, ma sviluppa il Sintomo [(Skill.Arg2)]"
  },
  Event_125862_Desc = {
    Text = "Nel vicolo dietro il bar, incontri di nuovo quei gatti neri.\n\"Ho sentito. Quelle melme nere hanno preso la nostra forma e ti hanno causato parecchi problemi.\"\n\"Come scusa, dimmi—cosa desideri?\"\nI gatti neri girano attorno alle tue gambe due volte, guardandoti dal basso."
  },
  Event_125862_Name = {
    Text = "Dono del primo incontro"
  },
  Event_125863_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125863_Desc = {
    Text = "La forza bruta non può svelare il destino, ma forse la saggezza sì?\nOsservi la tela da vicino, cercando al suo interno qualche filo del disegno del fato..."
  },
  Event_125863_Name = {
    Text = "La Trappola del Destino"
  },
  Event_125864_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125864_Desc = {
    Text = [[
Ti avvicini, fissandolo intensamente.
Un barlume di luce tremola nei tuoi occhi, come se cercasse di dirti qualcosa...]]
  },
  Event_125864_Name = {
    Text = "Il Segreto del Cristallo"
  },
  Event_125865_ChoiceDesc1 = {
    Text = "[Struggle] Distruggi 1 di 3 Carte di comando casuali e ricevi 75 Sigilli neri"
  },
  Event_125865_ChoiceDesc2 = {
    Text = "[Rest] Duplica 1 di 3 Carte di comando e ricevi 25 Sigilli neri"
  },
  Event_125865_ChoiceDesc3 = {
    Text = "[Rest] Ricevi 50 Sigilli neri"
  },
  Event_125865_Desc = {
    Text = "Una sensazione familiare ti assale. Eppure questa volta, il tocco viscoso e l'istinto di impotenza sono più intensi, più letali.\nLa falena cade nella tela del ragno. E tu hai già messo piede sul palcoscenico."
  },
  Event_125865_Name = {
    Text = "La Trappola del Destino"
  },
  Event_125866_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125866_Desc = {
    Text = "\"La ragione è il senso dell'esistenza. Che tu non debba mai rimpiangere la tua scelta.\""
  },
  Event_125866_Name = {
    Text = "Il Prezzo della Scelta"
  },
  Event_125867_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125867_Desc = {
    Text = "La curiosità si accende. Ti fondi nella folla e alzi la testa come loro.\nLassù non c'è nulla, eppure per ragioni ignote, non riesci a distogliere lo sguardo. Desideri guardare così — guardare per sempre..."
  },
  Event_125867_Name = {
    Text = "Guardando in Alto"
  },
  Event_125868_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125868_Desc = {
    Text = "\"Rifiutare la scelta è di per sé una scelta—questa è la maledizione del fato. Che tu non debba mai rimpiangere la scelta che hai fatto.\""
  },
  Event_125868_Name = {
    Text = "Il Prezzo della Scelta"
  },
  Event_125869_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125869_Desc = {
    Text = "\"Ora è tuo.\"\nI gatti si strusciano contro il tuo stinco e presto svaniscono.\nDove sono scomparsi, un dono ti attende."
  },
  Event_125869_Name = {
    Text = "Dono del primo incontro"
  },
  Event_125870_ChoiceDesc1 = {Text = "[Leave]"},
  Event_125870_Desc = {
    Text = "\"Ora è tuo.\"\nI gatti si strusciano contro il tuo stinco e presto svaniscono.\nDove sono scomparsi, un dono ti attende."
  },
  Event_125870_Name = {
    Text = "Dono del primo incontro"
  },
  Event_125871_ChoiceDesc1 = {
    Text = "[Alzare la testa] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_125871_ChoiceDesc2 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_125871_Desc = {
    Text = "La cacofonia svanisce per un istante fugace. La folla per le strade cade in silenzio, alzando lo sguardo verso il cielo."
  },
  Event_125871_Name = {
    Text = "Guardando in Alto"
  },
  Event_129176_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129176_Name = {
    Text = "Oblio Capitolo 1@"
  },
  Event_129177_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129177_Name = {
    Text = "Astral Reign Capitolo 1@"
  },
  Event_129178_ChoiceDesc1 = {
    Text = "[Indicate Direction] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_129178_ChoiceDesc2 = {
    Text = "[Pregare insieme] Incidi 1 Orazione su 3 due volte"
  },
  Event_129178_Desc = {
    Text = "I suoni del pianoforte e dell'organo si intrecciano nel vento cupo. È come se melodie magiche fluttuassero per le strade deserte.\nUna suora senza nome prega tra le note.\n\"Le preghiere semplici non richiedono grandi cerimonie. Il Padre di Tutto seminerà speranza per noi, così come un tempo ci donò devoti insegnamenti.\""
  },
  Event_129178_Name = {
    Text = "Preghiera dell'Organo"
  },
  Event_129179_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129179_Name = {
    Text = "Astral Reign Capitolo 1@"
  },
  Event_129180_ChoiceDesc1 = {
    Text = "[Face It] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_129180_ChoiceDesc2 = {
    Text = "[Surrender] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: [(EnchantConfig.Arg1)] due volte"
  },
  Event_129180_ChoiceDesc3 = {
    Text = "[Run Away] Ricevi 50 Sigilli Neri"
  },
  Event_129180_Desc = {
    Text = [[
Alcuni blocchi di scultura di cera ostruiscono il tuo cammino.
Sono storti e rozzi nell'aspetto, ben lontani dalla maestria che ci si aspetterebbe da Rogers.
"Ordini... gli ordini del padrone..."]]
  },
  Event_129180_Name = {Text = "Bozzetto"},
  Event_129181_ChoiceDesc1 = {
    Text = "[Quit Thinking] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_129181_ChoiceDesc2 = {
    Text = "[Inseguire l'Ispirazione] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 Carta di comando casuale due volte"
  },
  Event_129181_Desc = {
    Text = "Il porto è sotto Attacco, con un misterioso mercantile che va e viene e \"nuovi amici\" dotati di pinne... Si tratta di una trappola meticolosamente preparata? O dell'ennesimo viaggio inaspettatamente pericoloso?\nRealtà e ragione si tirano e si torcono l'una contro l'altra, innumerevoli ispirazioni e pensieri che emergono dalla mente."
  },
  Event_129181_Name = {
    Text = "Impeto d'Ispirazione"
  },
  Event_129182_ChoiceDesc1 = {
    Text = "[Join] Sviluppa \"(Skill.Arg1)\" due volte e incidi l'Orazione \"(EnchantConfig.Arg2)\" su 1 Carta di comando casuale due volte"
  },
  Event_129182_ChoiceDesc2 = {
    Text = "[Dispel] Sviluppa \"(Skill.Arg1)\" due volte e incidi l'Orazione \"(EnchantConfig.Arg2)\" su 1 Carta di comando casuale due volte"
  },
  Event_129182_ChoiceDesc3 = {
    Text = "[Disregard] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 Carta di comando tra 3 due volte"
  },
  Event_129182_Desc = {
    Text = "Odi il suono fioco e lontano di un corno d'osso.\nLo sciame di ratti emerge dal fango nero, attirato dal suono, rodendo il cadavere senza nome che giace sul letto asciutto del fiume.\nFormano un cerchio — al centro vi sono le spoglie vuote, mentre la circonferenza segna un nuovo regno governato dalla legge dell'oblio.\nE tu ti trovi all'ingresso di questo regno."
  },
  Event_129182_Name = {
    Text = "Regno dell'Esilio"
  },
  Event_129183_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129183_Name = {
    Text = "Oblio Capitolo 5@"
  },
  Event_129184_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129184_Name = {
    Text = "Oblio Capitolo 8@"
  },
  Event_129185_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129185_Name = {
    Text = "Oblio Capitolo 1@"
  },
  Event_129186_ChoiceDesc1 = {
    Text = "[Salva il Ritratto] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 Carta di comando tra 3 due volte, ma sviluppa \"(Skill.Arg2)\" due volte"
  },
  Event_129186_ChoiceDesc2 = {
    Text = "[Accetta il Vuoto] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 Carta di comando tra 3 due volte, ma sviluppa \"(Skill.Arg2)\" due volte"
  },
  Event_129186_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_129186_Desc = {
    Text = "Ti trovi dinanzi al Dono di Pickman.\nÈ un ritratto dipinto col sangue, con fiamme nerissime che ardono in silenzio.\nAttraverso le orbite vuote della figura nel dipinto, vedi—\nI tuoi ricordi che si agitano e bruciano, si allungano, si distorcono, risplendono, come se un fuoco informe lambisse i corridoi della tua mente. Nel tuo stordimento, odi una voce.\n\"È ora di cucinare. La temperatura è perfetta.\"\nQuesta è la scena stessa della tua memoria forgiata—ti contorci e ti dimeni tra le fiamme."
  },
  Event_129186_Name = {
    Text = "Ritratto in Fiamme"
  },
  Event_129187_ChoiceDesc1 = {
    Text = "[Quale prezzo saresti disposto a pagare?] Migliora casualmente la qualità dell'Orazione di 1 Carta due volte"
  },
  Event_129187_ChoiceDesc2 = {
    Text = "[Offri loro un Bloody Mary scaduto] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\" due volte, infetta \"(Skill.Arg2)\" due volte"
  },
  Event_129187_Desc = {
    Text = "\"Benvenuto, mio prezioso ospite. Sentiti libero di scegliere; tutto questo sfavillante assortimento esiste per attenderti.\"\n\"Ehm, scusi il disturbo, posso chiedere... è lei la sorella gemella di Lady Daffodil?\"\n\"Io sono Lady Daffodil in persona. Posso chiederle cosa la porta qui oggi...?\"\n\"Scusi, scusi, siete diventata ancora più affascinante di prima. Non l'avevo riconosciuta. Si ricorda? Vent'anni fa, scacciò un mostro dal mio bar... Ieri, l'incubo è tornato. Ha occupato il bar, portando con sé i suoi simili in gran numero...\""
  },
  Event_129187_Name = {
    Text = "Frammento di Ricordi: Sogno del Passato Ritrovato"
  },
  Event_129188_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129188_Name = {
    Text = "Astral Reign Capitolo 3@"
  },
  Event_129189_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129189_Name = {
    Text = "Oblio Capitolo 8@"
  },
  Event_129190_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129190_Name = {
    Text = "Oblio Capitolo 1@"
  },
  Event_129191_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129191_Name = {
    Text = "Oblio Capitolo 6@"
  },
  Event_129192_ChoiceDesc1 = {
    Text = "[Grasp the Spark] Aumenta gli HP massimi di Arg1"
  },
  Event_129192_ChoiceDesc2 = {
    Text = "[Affrontare il proprio cuore] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 2 Carte di comando casuali due volte, ma sviluppa 2 \"(Skill.Arg2)\" due volte"
  },
  Event_129192_Desc = {
    Text = "In questa grande caccia, la Caccia di Golia è come una bestia nell'oscurità, intenta a Divorare Tutto della speranza. Tuttavia, questo inseguimento implacabile non ti congela; al contrario, accende una scintilla nel profondo, che si propaga e arde sempre più nel tuo petto."
  },
  Event_129192_Name = {
    Text = "Cacciatrice di Luce"
  },
  Event_129193_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129193_Name = {
    Text = "Oblio Capitolo 6@"
  },
  Event_129194_ChoiceDesc1 = {
    Text = "[Leggere il Sentiero dei predecessori] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_129194_ChoiceDesc2 = {
    Text = "[Write Your Own Path] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_129194_ChoiceDesc3 = {
    Text = "[Stare into Darkness] Ricevi 25 Sigilli Neri"
  },
  Event_129194_Desc = {
    Text = "Se stessi esplorando il Dominio da solo, non saresti così sicuro del tuo cammino come lo sei ora.\nLe impronte nel Dominio si sono divise in tre sentieri; ogni passo scrive un futuro invisibile."
  },
  Event_129194_Name = {
    Text = "La Via d'Uscita"
  },
  Event_129195_ChoiceDesc1 = {
    Text = "[Indicare l'errore] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\" due volte, infetta \"(Skill.Arg2)\" due volte"
  },
  Event_129195_ChoiceDesc2 = {
    Text = "[Listen to the Performance] Ricevi 15 Sigilli Neri per ogni Risvegliato con 50 o più Aliemus."
  },
  Event_129195_ChoiceDesc3 = {
    Text = "[Leave] Incidi 1 Orazione su 3"
  },
  Event_129195_Desc = {
    Text = "Il Ragazzo Scultura di Cera siede al pianoforte, esercitandosi.\nIl suo maestro—anch'egli una Scultura di Cera—lo guida lì accanto.\n133, 355, 244...\nSbagliato, ogni nota è sbagliata."
  },
  Event_129195_Name = {
    Text = "Lezione di pianoforte"
  },
  Event_129196_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129196_Name = {
    Text = "Oblio Capitolo 5@"
  },
  Event_129197_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129197_Name = {
    Text = "Astral Reign Capitolo 4@"
  },
  Event_129198_ChoiceDesc1 = {
    Text = "[Ascoltare la tristezza] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando due volte, ma sviluppa \"(Skill.Arg2)\" due volte"
  },
  Event_129198_ChoiceDesc2 = {
    Text = "[Hear Joy] Ricevi 15 Sigilli Neri per ogni Risvegliato con 50 o più Aliemus."
  },
  Event_129198_ChoiceDesc3 = {
    Text = "[Leave] Incidi 1 Orazione tra 3 due volte"
  },
  Event_129198_Desc = {
    Text = "Melodioso, lirico, gioioso, doloroso... Il motivo riecheggia nel Dominio, la sua origine incerta.\nÈ la sinfonia dall'impianto audio della nave fantasma, o una Rapsodia notturna imprigionata nel Dominio?"
  },
  Event_129198_Name = {
    Text = "Eco Senza Nome"
  },
  Event_129199_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129199_Name = {
    Text = "Astral Reign Capitolo 1@"
  },
  Event_129200_ChoiceDesc1 = {
    Text = "[Open the Envelope] Acquisisci la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_129200_ChoiceDesc2 = {
    Text = "[Read] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 Carta di comando tra 3 due volte"
  },
  Event_129200_ChoiceDesc3 = {
    Text = "[Put it back]Ottieni 50 Il sigillo nero"
  },
  Event_129200_Desc = {
    Text = "In un angolo dimenticato, è stata lasciata una lettera.\nMolte parole sulla lettera sono diventate irriconoscibili, ma una parola rimane. Trafigge la carta.\nQuesta parola è \"Madre\"."
  },
  Event_129200_Name = {
    Text = "Nostalgia Svanita"
  },
  Event_129201_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129201_Name = {
    Text = "Astral Reign Capitolo 4@"
  },
  Event_129202_ChoiceDesc1 = {
    Text = "[Ascoltare attentamente] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando due volte, ma sviluppa \"(Skill.Arg2)\" due volte"
  },
  Event_129202_ChoiceDesc2 = {
    Text = "[Cover Ears] Ricevi 15 Sigilli Neri per ogni Risvegliato con 50 o più Aliemus."
  },
  Event_129202_ChoiceDesc3 = {
    Text = "[Examine] Incidi 1 Orazione su 3 due volte"
  },
  Event_129202_Desc = {
    Text = "Quando entri nel piano delle Spoglie, un rintocco melodioso risuona bruscamente nella Fabbrica abbandonata e vuota. Il suono limpido del pianoforte contrasta nettamente con le rovine d'acciaio arrugginito."
  },
  Event_129202_Name = {
    Text = "Scala Inquietante"
  },
  Event_129203_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129203_Name = {
    Text = "Oblio Capitolo 3@"
  },
  Event_129204_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129204_Name = {
    Text = "Oblio Capitolo 6@"
  },
  Event_129205_ChoiceDesc1 = {
    Text = "[Spare Her] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_129205_ChoiceDesc2 = {
    Text = "[Aiutarla] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: [(EnchantConfig.Arg1)] due volte"
  },
  Event_129205_ChoiceDesc3 = {
    Text = "[Walk My Own Path] Ricevi 50 Sigilli Neri"
  },
  Event_129205_Desc = {
    Text = "Tre figure scure ed effimere ti sbarrano la strada.\n\"Puoi lasciarla andare,\" dice quella che tiene un orsacchiotto grondante di D-melma, \"è solo timida, non malvagia. Non vuole fare del male a nessuno.\"\n\"Puoi aiutarla,\" dice quella che tiene un sacchetto di Caramelle splendidamente confezionato, \"puoi fare ciò che lei non può. Puoi porre fine a tutto questo.\"\n\"Non devi ascoltarci,\" dice quella con le mani vuote, \"hai il tuo cammino.\""
  },
  Event_129205_Name = {
    Text = "Sentieri Biforcati"
  },
  Event_129206_ChoiceDesc1 = {
    Text = "[Feed the Rats] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)], sviluppa 1 Sintomo"
  },
  Event_129206_ChoiceDesc2 = {
    Text = "[Scaccia i Topi] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 Carta di comando tra 3 due volte, ma sviluppa \"(Skill.Arg2)\" due volte"
  },
  Event_129206_ChoiceDesc3 = {
    Text = "[Ignore the Rats] Ottieni 25 Sigilli Neri"
  },
  Event_129206_Desc = {
    Text = "Tutto su questa nave è intrappolato nel Ciclo Temporale.\nPersino quelle disgustose, pelose piccole creature che lottano per sopravvivere qui non possono sfuggire al proprio destino.\nCiclo dopo ciclo, divorano tutto ciò che trovano, eppure la loro fame non è mai saziata.\n\"Così... affamati...\"\nOrde di ratti emettono Stridi striduli e malsani.\nI cicli infiniti li hanno resi affamati e folli — devono mangiare qualcosa.\nOra. Immediatamente."
  },
  Event_129206_Name = {
    Text = "Branco di Ratti Affamati"
  },
  Event_129207_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129207_Name = {
    Text = "Oblio Capitolo 8@"
  },
  Event_129208_ChoiceDesc1 = {
    Text = "[Tocca il Cervello] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 Carta di comando casuale due volte"
  },
  Event_129208_ChoiceDesc2 = {
    Text = "[Touch the Heart] Aumenta gli HP massimi di Arg1, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_129208_Desc = {
    Text = "Varchi la soglia di una sala grigia e silenziosa, dove nessun sussurro indugia, e una coppia di bilance emerge fiocamente dalla foschia oscura.\nA sinistra, un cervello calmo come un lago, i cui solchi bianco-argentei brillano debolmente; a destra, un cuore rosso ardente che emana vapore e calore.\nAll'improvviso, avverti un aroma fragrante. Un desiderio insaziabile cresce dentro di te, e la tua ragione viene compressa dalla Sua oscurità sconfinata.\nTendi la mano."
  },
  Event_129208_Name = {
    Text = "Giochi della Fame"
  },
  Event_129209_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129209_Name = {
    Text = "Oblio Capitolo 4@"
  },
  Event_129210_ChoiceDesc1 = {
    Text = "[Abbattere la figura] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando due volte, ma sviluppa \"(Skill.Arg2)\" due volte"
  },
  Event_129210_ChoiceDesc2 = {
    Text = "[Schiacciare l'Embrione] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando due volte, ma sviluppa \"(Skill.Arg2)\" due volte"
  },
  Event_129210_ChoiceDesc3 = {
    Text = "[Close Your Eyes] Ricevi 25 Sigilli Neri"
  },
  Event_129210_Desc = {
    Text = [[
In uno stato confuso, vedi persone che hai incontrato ad Aram avvicinarsi a te.
Ridono e ti invitano a bere, danzare e goderti il banchetto.
Poi la loro carne inizia a staccarsi strato dopo strato, cadendo a terra e contorcendosi in nuovi Embrioni.
Ti tendono le mani, invitandoti a unirti alla celebrazione della carne e della rinascita.]]
  },
  Event_129210_Name = {
    Text = "Ombre del Passato"
  },
  Event_129211_ChoiceDesc1 = {
    Text = "[Feed Them] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)], ma sviluppa 1 Sintomo su 3."
  },
  Event_129211_ChoiceDesc2 = {
    Text = "[Non farci caso] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 Carta di comando tra 3 due volte, ma sviluppa \"(Skill.Arg2)\" due volte"
  },
  Event_129211_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_129211_Desc = {
    Text = "I Residenti vanno e vengono, eppure lo sciame di topi si estende all'infinito.\nRispetto agli umani, sono loro i veri \"nativi\" di questo castello.\nMa non hanno obiezioni al trasferimento degli umani.\nPerché quelle cose brutte, molli e bianche daranno loro da mangiare cose altrettanto brutte, molli e bianche.\n\"E tu, cosa brutta, a quale tipo appartieni?\""
  },
  Event_129211_Name = {
    Text = "Segreto della Cittadella"
  },
  Event_129212_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129212_Name = {
    Text = "Oblio Capitolo 5@"
  },
  Event_129213_ChoiceDesc1 = {
    Text = "[Discern Man's Voice] Duplica 1 di 3 Carte di comando"
  },
  Event_129213_ChoiceDesc2 = {
    Text = "[Distinguere la voce della Donna] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando due volte, ma sviluppa \"(Skill.Arg2)\" due volte"
  },
  Event_129213_ChoiceDesc3 = {
    Text = "[Discern the Elder's Voice] Ricevi 25 Sigilli Neri"
  },
  Event_129213_Desc = {
    Text = "Ti trovi da solo in una palude oscura.\nAttraverso la foschia, odi mormorii caotici sovrapporsi come maree—alcuni di anziani tremanti, alcuni di bambini che balbettano, alcuni di donne ansiose, e alcuni di uomini in preda a un terrore senza nome..."
  },
  Event_129213_Name = {
    Text = "Sussurro delle Ultime Parole"
  },
  Event_129214_ChoiceDesc1 = {
    Text = "[Osservare attentamente] Incidi 1 Orazione su 3 due volte"
  },
  Event_129214_ChoiceDesc2 = {
    Text = "[Strappare il manifesto] 1 Carta di comando casuale ottiene l'Orazione: \"(EnchantConfig.Arg1)\" due volte, infetta \"(Skill.Arg2)\" due volte"
  },
  Event_129214_Desc = {
    Text = [[
Un candelabro che si trova comunemente in un museo delle cere.
Alla luce arancione e inquietante, noti un poster disegnato a mano sulla parete.]]
  },
  Event_129214_Name = {
    Text = "Ilarità nelle Tenebre"
  },
  Event_129215_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129215_Name = {
    Text = "Oblio Capitolo 4@"
  },
  Event_129216_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129216_Name = {
    Text = "Oblio Capitolo 7@"
  },
  Event_129217_ChoiceDesc1 = {
    Text = "[Stare] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_129217_ChoiceDesc2 = {
    Text = "[Ignore] Incidi 1 Orazione su 3 due volte"
  },
  Event_129217_Desc = {
    Text = [[
Gli Aramiti si inginocchiano nella tempesta di sabbia.
La tempesta flagella i loro corpi, e la sabbia inghiotte i loro cuori devoti.
Nella polvere vorticante, innumerevoli occhi giganteschi sembrano scrutare dall'alto la terra distorta.]]
  },
  Event_129217_Name = {
    Text = "Colosso di Polvere"
  },
  Event_129218_ChoiceDesc1 = {
    Text = "[Scaccia la Farfalla] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 Carta di comando casuale due volte, ma sviluppa \"(Skill.Arg2)\" due volte"
  },
  Event_129218_ChoiceDesc2 = {
    Text = "[Ascolta il Desiderio] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 Carta di comando tra 3 due volte"
  },
  Event_129218_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_129218_Desc = {
    Text = "La piccola farfalla porta con sé molti sogni.\nQuesti sogni si disperdono nel mare di fiori, nel reparto, e nell'altare colmo di sangue e carne di @2.\nFinalmente, ha atteso il suo legame, senza sapere se sei disposto ad ascoltare il suo piccolo, piccolo desiderio."
  },
  Event_129218_Name = {
    Text = "Sogno di Lepidottero"
  },
  Event_129219_ChoiceDesc1 = {
    Text = "[Segui la Guida] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 Carta di comando tra 3 due volte, ma sviluppa \"(Skill.Arg2)\" due volte"
  },
  Event_129219_ChoiceDesc2 = {
    Text = "[Ignora la Guida] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 Carta di comando tra 3 due volte, ma sviluppa \"(Skill.Arg2)\" due volte"
  },
  Event_129219_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_129219_Desc = {
    Text = "La festa è iniziata.\nTra fiamme spirituali e benedizioni intrise di sangue, innumerevoli credenti sono divenuti torce viventi—\nAnime eteree si disperdono intorno a te come spiriti guida, luminescenti, in attesa della tua scelta."
  },
  Event_129219_Name = {
    Text = "Faro dell'Anima"
  },
  Event_129220_ChoiceDesc1 = {
    Text = "[Ignora il Campanello] Incidi 1 Orazione avanzata tra 3 due volte"
  },
  Event_129220_ChoiceDesc2 = {
    Text = "[Pick up the Receiver] Ottieni la Reliquia dorata \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\""
  },
  Event_129220_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_129220_Desc = {
    Text = "Non avrebbe dovuto squillare—il telefono, raggomitolato dietro la tela.\nIl cavo si avvolge attorno al corpo massiccio dell'apparecchio come un cordone ombelicale arrugginito, e sembra estendersi dalla tua stessa mente.\nCerchi di discernere con attenzione la frequenza della vibrazione; il suono sinistro ricorda l'arte surreale di Pickman."
  },
  Event_129220_Name = {
    Text = "Chiamata Persa"
  },
  Event_129221_ChoiceDesc1 = {
    Text = "[Stiamo tutti bene] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\" due volte, infetta \"(Skill.Arg2)\" due volte"
  },
  Event_129221_ChoiceDesc2 = {
    Text = "[Chi sei?] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\" due volte, infetta \"(Skill.Arg2)\" due volte"
  },
  Event_129221_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_129221_Desc = {
    Text = "La macchina da scrivere sputa inchiostro all'improvviso, con un numero accecante di punti esclamativi.\n\"Doll, stai bene??? Perché sei svanita quando anche il Custode è scomparso??? Per favore, se sei al sicuro, manda un messaggio!!! A William cadranno i capelli se aspettiamo ancora!!!\""
  },
  Event_129221_Name = {
    Text = "Missiva Urgente"
  },
  Event_129222_ChoiceDesc1 = {
    Text = "[Cut the Red Ribbon] Distruggi una Carta di comando e ricevi Arg1 Sigilli Neri."
  },
  Event_129222_ChoiceDesc2 = {
    Text = "[Resist] Duplica una Carta di comando, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_129222_ChoiceDesc3 = {
    Text = "[Richiamo di Ramona] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando due volte"
  },
  Event_129222_Desc = {
    Text = "Casiah lancia un nastro di seta rossa, che si avvolge istantaneamente attorno alla tua valigetta."
  },
  Event_129222_Name = {
    Text = "Seta Attorcigliata"
  },
  Event_129223_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129223_Name = {
    Text = "Oblio Capitolo 6@"
  },
  Event_129224_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129224_Name = {
    Text = "Astral Reign Capitolo 3@"
  },
  Event_129225_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129225_Name = {
    Text = "Oblio Capitolo 3@"
  },
  Event_129226_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129226_Name = {
    Text = "Oblio Capitolo 4@"
  },
  Event_129227_ChoiceDesc1 = {
    Text = "[Agita la Mano per Scacciare] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 Carta di comando tra 3 due volte, ma sviluppa \"(Skill.Arg2)\" due volte"
  },
  Event_129227_ChoiceDesc2 = {
    Text = "[Let It Stay] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_129227_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_129227_Desc = {
    Text = "Un suono flebile emerge dall'Oscurità.\nÈ una Farfalla, che chiede cortesemente:\n\"Posso riposare nel palmo della tua mano?\"\n\"Sono solo così stanca... desidero riposare un momento.\"\nMentre lo chiede, la Farfalla volteggia verso di te attraverso il buio.\nUn liquido nero e viscoso gocciola dalle sue ali — un dono delle ombre che ha attraversato."
  },
  Event_129227_Name = {
    Text = "Richiesta della Farfalla"
  },
  Event_129228_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129228_Name = {
    Text = "Oblio Capitolo 7@"
  },
  Event_129229_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129229_Name = {
    Text = "Oblio Capitolo 7@"
  },
  Event_129230_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129230_Name = {
    Text = "Oblio Capitolo 1@"
  },
  Event_129231_ChoiceDesc1 = {
    Text = "[Recognize Lyrics] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_129231_ChoiceDesc2 = {
    Text = "[Canticchiare dolcemente] Incidi 1 Orazione su 3 due volte"
  },
  Event_129231_Desc = {
    Text = [[
Antiche canzoni marinaresche echeggiano nel dominio.
Memorie confinate cantano di onde, cieli e liquori forti, in una lingua mai udita]]
  },
  Event_129231_Name = {
    Text = "Canto di Mare"
  },
  Event_129232_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129232_Name = {
    Text = "Oblio Capitolo 8@"
  },
  Event_129233_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129233_Name = {
    Text = "Astral Reign Capitolo 1@"
  },
  Event_129234_ChoiceDesc1 = {
    Text = "[Taglia il Palmo] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 Carta di comando tra 3 due volte, ma sviluppa \"(Skill.Arg2)\" due volte"
  },
  Event_129234_ChoiceDesc2 = {
    Text = "[Accept Growth] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_129234_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_129234_Desc = {
    Text = "Quella farfalla non volò dentro, ma piuttosto crebbe lentamente dal palmo della tua mano.\nAll'inizio, pensasti fosse solo sudore, ma tra le dita vedesti un liquido nero trasudare come un flusso invertito di vene, che si rapprendeva in ali fredde e pulsanti.\nOgni volta che batte le ali, invia increspature nel tuo flusso sanguigno."
  },
  Event_129234_Name = {Text = "Parassita"},
  Event_129235_ChoiceDesc1 = {
    Text = "[Continuare a sfogliare] 1 Carta di comando casuale ottiene l'Orazione: [(EnchantConfig.Arg1)] due volte"
  },
  Event_129235_ChoiceDesc2 = {
    Text = "[Leave] Aumenta gli HP massimi di Arg1, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_129235_Desc = {
    Text = "Una bilancia per pesare.\nDietro di essa, innumerevoli organi sono immersi in formalina rossa.\nSono impilati ordinatamente su scaffali.\nPrendi distrattamente un taccuino lì vicino e lo sfogli:\n\"Cuore: 8 oz, Cervello: 50 oz...\""
  },
  Event_129235_Name = {
    Text = "Registro degli Organi"
  },
  Event_129236_ChoiceDesc1 = {
    Text = "[Detour] Distruggi una Carta di comando e ricevi Arg1 Sigilli Neri."
  },
  Event_129236_ChoiceDesc2 = {
    Text = "[Ask Why It Sank] Duplica una Carta di comando, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_129236_ChoiceDesc3 = {
    Text = "[Salutare il Membro dell'Equipaggio] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando due volte"
  },
  Event_129236_Desc = {
    Text = [[

Mentre cammini verso la sala macchine, incontri di nuovo alcune "memorie" fissate nel dominio.
Non sono fantasmi, ma soltanto i pensieri persistenti del Capitano Elton per l'equipaggio perduto.]]
  },
  Event_129236_Name = {
    Text = "Il Padrone della Sona-Nyl"
  },
  Event_129237_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129237_Name = {
    Text = "Oblio Capitolo 3@"
  },
  Event_129238_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129238_Name = {
    Text = "Astral Reign Capitolo 1@"
  },
  Event_129239_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129239_Name = {
    Text = "Oblio Capitolo 6@"
  },
  Event_129240_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129240_Name = {
    Text = "Oblio Capitolo 5@"
  },
  Event_129241_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129241_Name = {
    Text = "Astral Reign Capitolo 4@"
  },
  Event_129242_ChoiceDesc1 = {
    Text = "[Suonare per lui] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 Carta di comando tra 3 due volte, ma sviluppa \"(Skill.Arg2)\" due volte"
  },
  Event_129242_ChoiceDesc2 = {
    Text = "[Listening to the Strings] Ricevi 15 Sigilli Neri per ogni Risvegliato con 50 o più Aliemus."
  },
  Event_129242_ChoiceDesc3 = {
    Text = "[Leave] Incidi 1 Orazione tra 3 due volte"
  },
  Event_129242_Desc = {
    Text = "\"Caro John:\nDi recente, mi sono improvvisamente reso conto che sono passati diversi anni dall'ultima volta che hai suonato il pianoforte per noi.\nQuest'anno ho 81 anni, e più invecchio, più custodisco gelosamente i ricordi della mia giovinezza.\nSe ricevi questa lettera, ti prego, fermati al mio appartamento la prossima volta che passi per Londinium e suona un brano per me.\""
  },
  Event_129242_Name = {
    Text = "Sonata del Rimpianto"
  },
  Event_129243_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129243_Name = {
    Text = "Astral Reign Capitolo 3@"
  },
  Event_129244_ChoiceDesc1 = {
    Text = "[Dire di non avere il Portafoglio] Incidi 1 Orazione su 3 due volte"
  },
  Event_129244_ChoiceDesc2 = {
    Text = "[Rompere la rete] 1 Carta di comando casuale ottiene l'Orazione: \"(EnchantConfig.Arg1)\" due volte, infetta \"(Skill.Arg2)\" due volte"
  },
  Event_129244_Desc = {
    Text = [[
Una ragnatela giallo-arancio fluttua silenziosa nell'aria, i suoi radi fori assai meno intricati di quelli delle sue parenti tessitrici annidate lungo il muro.
Non riesci a resistere e allunghi la mano; la Fragile tela si dissolve all'istante, e risate di Fanciulli risuonano nelle tue orecchie.
"Oro, argento, giallo, rosso, tutti i Portafogli sono nostri!"]]
  },
  Event_129244_Name = {
    Text = "Rete Vagale"
  },
  Event_129245_ChoiceDesc1 = {
    Text = "[Choose Emotion] Recupera Arg1 HP"
  },
  Event_129245_ChoiceDesc2 = {
    Text = "[Mantenere la razionalità] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 Carta di comando casuale due volte"
  },
  Event_129245_ChoiceDesc3 = {
    Text = "[Refuse to Choose] Ricevi 25 Sigilli Neri"
  },
  Event_129245_Desc = {
    Text = "\"Scegli, scegli.\"\nNell'oscurità incalzante, innumerevoli sussurri riecheggiavano.\nLa voce è dolcemente ipnotica, sembra portare con sé una magia infinita che induce in te una sorta di folle fantasma.\nIl tuo cervello sprofonda nella follia, contorcendosi lontano dal corpo, mentre il cuore sembra aver sviluppato una propria coscienza, urlando e chiamandoti.\n\"Scegli, scegli.\"\n\"Mantenere la razionalità o l'emozione; devi fare una scelta.\""
  },
  Event_129245_Name = {
    Text = "Il Prezzo dell'Umanità"
  },
  Event_129246_ChoiceDesc1 = {
    Text = "[Destroy Offering] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_129246_ChoiceDesc2 = {
    Text = "[Sciogliere le corde] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando due volte"
  },
  Event_129246_ChoiceDesc3 = {
    Text = "[Keep Going] Ricevi 50 Sigilli Neri"
  },
  Event_129246_Desc = {
    Text = "Tre Aramiti erano legati a una piattaforma sopraelevata.\nOscuri motivi simili a corteccia, che avevi già visto sulla pelle dei neonati, apparvero su di loro mentre intonavano incantesimi."
  },
  Event_129246_Name = {
    Text = "Tre Offerte"
  },
  Event_129247_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129247_Name = {
    Text = "Astral Reign Capitolo 3@"
  },
  Event_129248_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129248_Name = {
    Text = "Oblio Capitolo 6@"
  },
  Event_129249_ChoiceDesc1 = {
    Text = "[Struggle Forward] Distruggi una Carta di comando e ricevi Arg1 Sigilli Neri."
  },
  Event_129249_ChoiceDesc2 = {
    Text = "[Snap the Thread] Duplica una Carta di comando, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_129249_ChoiceDesc3 = {
    Text = "[Trattenersi] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando due volte"
  },
  Event_129249_Desc = {
    Text = "Per tutto il cammino vieni sospinto in avanti, ogni tua scelta manipolata da fili invisibili.\nLotti per aggrapparti a tutto ciò che ti sta a cuore.\nIl destino del mondo pende appena oltre la punta delle tue dita.\nInnumerevoli fili si intrecciano, imprigionando il tuo corpo intero."
  },
  Event_129249_Name = {
    Text = "Mani Burattino"
  },
  Event_129250_ChoiceDesc1 = {
    Text = "[Chiedergli il Sentiero] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\" due volte, infetta \"(Skill.Arg2)\" due volte"
  },
  Event_129250_ChoiceDesc2 = {
    Text = "[Allontanarsi] Scegli 1 tra 3 Carte di comando e ottieni Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_129250_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_129250_Desc = {
    Text = "L'ombra è ferma sotto l'alto lampione.\n\"Posso chiederle un po' di fuoco, signore?\"\nNon hai l'abitudine di @2, ma non ti dispiace usare un pizzico di \"magia\".\nCon il tuo aiuto, l'ombra accenderà @2 e lo immergerà in profondità in quel vortice nero insondabile.\nIn un attimo, vedi fumo bianco levarsi a volute.\n\"Ah—\"\nL'ombra emette un sospiro compiaciuto."
  },
  Event_129250_Name = {
    Text = "Silhouette sotto il Lampione"
  },
  Event_129251_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129251_Name = {
    Text = "Oblio Capitolo 1@"
  },
  Event_129252_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129252_Name = {
    Text = "Oblio Capitolo 8@"
  },
  Event_129253_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129253_Name = {
    Text = "Oblio Capitolo 3@"
  },
  Event_129254_ChoiceDesc1 = {
    Text = "[Accettare il Fantasma] 1 Carta di comando casuale ottiene l'Orazione: \"(EnchantConfig.Arg1)\" due volte, infetta \"(Skill.Arg2)\" due volte"
  },
  Event_129254_ChoiceDesc2 = {
    Text = "[Negare il Fantasma] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: [(EnchantConfig.Arg1)] due volte"
  },
  Event_129254_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_129254_Desc = {
    Text = "Sotto il pesante e oscuro ponte di ferro, su una riva silenziosa invasa dai giunchi, una farfalla luminosa prese improvvisamente il volo.\nLa farfalla si posò lievemente sul palmo della tua mano. Gli ululati terrificanti cessarono, sostituiti dal rombo di un treno che rotolava su binari arrugginiti, dal crepitio del carbone ardente e dallo stridore metallico degli assi in rotazione..."
  },
  Event_129254_Name = {
    Text = "Miraggio della Ferrovia"
  },
  Event_129255_ChoiceDesc1 = {
    Text = "[Refuse] Distruggi una Carta di comando e ricevi Arg1 Sigilli Neri."
  },
  Event_129255_ChoiceDesc2 = {
    Text = "[Comply] Duplica una Carta di comando, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_129255_ChoiceDesc3 = {
    Text = "[Scegli di Abbracciare] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 Carta di comando tra 3 due volte"
  },
  Event_129255_Desc = {
    Text = "\"Sono un uccello in gabbia, intrappolato in un cortile pieno di molte stanze.\"\nFigure vaghe vagano nell'Oscurità—Frammenti Residui delle Ossessioni del defunto.\n\"Dicono che sia un Manicomio, ma io so che è una gabbia speciale per gli esseri umani, che imprigiona uccelli liberi che rifiutano di obbedire alle Regole sociali.\"\n\"Ma se un uccello non può volare, può ancora essere chiamato uccello?\"\nLe Ossessioni si radunano intorno a te, implorando la Redenzione.\n\"Per favore, spezzami le ali, sono stanco di volare.\""
  },
  Event_129255_Name = {
    Text = "L'uomo vuoto"
  },
  Event_129256_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129256_Name = {
    Text = "Oblio Capitolo 2@"
  },
  Event_129257_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129257_Name = {
    Text = "Astral Reign Capitolo 2@"
  },
  Event_129258_ChoiceDesc1 = {
    Text = "[Scatenare la Farfalla] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando due volte, ma sviluppa \"(Skill.Arg2)\" due volte"
  },
  Event_129258_ChoiceDesc2 = {
    Text = "[Become a Butterfly] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_129258_ChoiceDesc3 = {
    Text = "[Swallow Back] Ricevi 25 Sigilli Neri"
  },
  Event_129258_Desc = {
    Text = "Tante cose sono accadute questa notte.\nL'assalto al molo, il cargo fantasma, il Navigatore, Tulu, Murphy, Ramona... tutto risucchiato in un vortice, rimestato nel porridge d'avena delle 7 del mattino al ristorante di Mythag.\nVorresti chiedere al Risvegliatore di fronte a te, ma non sai da dove cominciare, con un nodo alla gola — o farfalle nello stomaco."
  },
  Event_129258_Name = {
    Text = "L'Effetto Farfalla"
  },
  Event_129259_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129259_Name = {
    Text = "Oblio Capitolo 8@"
  },
  Event_129260_ChoiceDesc1 = {
    Text = "[Lasciarla restare] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\" due volte, infetta \"(Skill.Arg2)\" due volte"
  },
  Event_129260_ChoiceDesc2 = {
    Text = "[Wave Away] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_129260_ChoiceDesc3 = {
    Text = "[Welcome the Butterflies] Ricevi 25 Sigilli Neri"
  },
  Event_129260_Desc = {
    Text = [[
Vaghi per il gelido Sanatorio, dove una Farfalla nera che non dovrebbe esistere in questa stagione ti svolazza accanto.
Le sue ali, rivestite di melma nera, oscillano mentre vola, lasciando cadere strati di fanghiglia nera che si solidificano e si staccano nel vento.
Estenuta, si posa sulla punta del tuo dito.]]
  },
  Event_129260_Name = {
    Text = "Ciò che Non Dovrebbe Esistere"
  },
  Event_129261_ChoiceDesc1 = {
    Text = "[Rivivere il passato] Incidi 1 Orazione avanzata a scelta tra 3 due volte"
  },
  Event_129261_ChoiceDesc2 = {
    Text = "[Gaze into the Future] Ottieni la Reliquia dorata \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\""
  },
  Event_129261_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_129261_Desc = {
    Text = "Nulla in questo mondo resta immutato—\nneppure il Paradise plasmato dalla Madre Divina.\nPer un istante fugace, scorgi qualcosa attraverso una crepa nel tempo.\nPassato, presente e futuro si intrecciano in quella fessura, mutando senza sosta,\nin attesa del tuo sguardo curioso."
  },
  Event_129261_Name = {
    Text = "Frattura Temporale"
  },
  Event_129262_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129262_Name = {
    Text = "Oblio Capitolo 7@"
  },
  Event_129263_ChoiceDesc1 = {
    Text = "[Ignoralo] Incidi 1 Orazione tra 3 due volte"
  },
  Event_129263_ChoiceDesc2 = {
    Text = "[Toccalo] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 Carta di comando casuale due volte, ma sviluppa \"(Skill.Arg2)\" due volte"
  },
  Event_129263_Desc = {
    Text = "Una strana cosa simile a spore ha catturato la tua attenzione.\nEra come una delicata medusa fatta di carne e sangue, simile anche a fibre nervose che trattengono segnali nel profondo del cervello.\n\"Vieni a toccarmi,\" ti tenta in silenzio, \"ti mostrerò un ricordo crudele.\""
  },
  Event_129263_Name = {
    Text = "Memoria Profonda"
  },
  Event_129264_ChoiceDesc1 = {
    Text = "[Perdersi nell'Illusione] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 Carta di comando tra 3 due volte, ma sviluppa \"(Skill.Arg2)\" due volte"
  },
  Event_129264_ChoiceDesc2 = {
    Text = "[Maintain Sanity] Ottieni 15 Sigilli Neri per ogni Risvegliatore con 50 o più Aliemus"
  },
  Event_129264_ChoiceDesc3 = {
    Text = "[Andarsene a Forza] Incidi 1 Orazione a scelta tra 3 due volte"
  },
  Event_129264_Desc = {
    Text = "Forse la lunga Battaglia ti ha lasciato disorientato, o forse la tua mente ha tradito il tuo corpo.\nUna sensazione di assenza di gravità pervade i tuoi pensieri.\nIn un istante, la tua mente diventa un Caleidoscopio — abbagliante, brillante, lampeggiante di ogni colore.\nInnumerevoli intuizioni, riflessioni e fantasie inondano la tua mente, colmando ogni fessura.\nSe questo continua, il tuo cervello presto esploderà nel caos."
  },
  Event_129264_Name = {
    Text = "Caleidoscopio del pensiero"
  },
  Event_129265_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129265_Name = {
    Text = "Oblio Capitolo 5@"
  },
  Event_129266_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129266_Name = {
    Text = "Oblio Capitolo 4@"
  },
  Event_129267_ChoiceDesc1 = {
    Text = "[Listen] Incidi 1 Orazione avanzata su 3 due volte"
  },
  Event_129267_ChoiceDesc2 = {
    Text = "[Call Out] Ottieni la Reliquia dorata \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_129267_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_129267_Desc = {
    Text = "Dall'incidente, non hai più avuto notizie dalla tua compagna.\nInnumerevoli tentativi di contatto sono stati come gettare pietre nel mare, senza alcuna risposta.\nQuando hai perso ogni speranza, il comunicatore emette improvvisamente un suono.\nApri la valigetta, avvicinando il ricevitore all'orecchio.\n\"Custode...\"\nIn uno stato confuso, senti la voce a lungo desiderata, che riecheggia lontana attraverso il vuoto."
  },
  Event_129267_Name = {
    Text = "Eco della nostalgia"
  },
  Event_129268_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129268_Name = {
    Text = "Oblio Capitolo 1@"
  },
  Event_129269_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129269_Name = {
    Text = "Astral Reign Capitolo 1@"
  },
  Event_129270_ChoiceDesc1 = {
    Text = "[Stare Down the Hellhound Source] Ottieni la Reliquia dorata \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\""
  },
  Event_129270_ChoiceDesc2 = {
    Text = "[Concentrarsi sul combattimento] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando due volte"
  },
  Event_129270_Desc = {
    Text = [[
La sagoma del Segugio infernale muta.
Il suo corpo collega le crepe nei muri, rivelando sinistre Illusioni.]]
  },
  Event_129270_Name = {
    Text = "Dalla Prospettiva"
  },
  Event_129271_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129271_Name = {
    Text = "Oblio Capitolo 2@"
  },
  Event_129272_ChoiceDesc1 = {
    Text = "[Combine Pages] Ottieni la Reliquia d'Oro \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_129272_ChoiceDesc2 = {
    Text = "[Read] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 Carta di comando tra 3 due volte"
  },
  Event_129272_ChoiceDesc3 = {
    Text = "[Discard It] Ricevi 50 Sigilli Neri"
  },
  Event_129272_Desc = {
    Text = [[
Una pagina ingiallita cadde dalla veste del Devoto del Portatore di Luce.
Coperta di testi bizzarri, alcuni simili a geroglifici, altri stranamente inclinati, altri sovrapposti. Solo poche parole erano a malapena decifrabili.
Intitolata "La Nascita del Divus @2"]]
  },
  Event_129272_Name = {
    Text = "Editto Cifrato: Parte II"
  },
  Event_129273_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129273_Name = {
    Text = "Oblio Capitolo 2@"
  },
  Event_129274_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129274_Name = {
    Text = "Astral Reign Capitolo 2@"
  },
  Event_129275_ChoiceDesc1 = {
    Text = "[Preparati al Combattimento] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 Carta di comando tra 3 due volte, ma sviluppa \"(Skill.Arg2)\" due volte"
  },
  Event_129275_ChoiceDesc2 = {
    Text = "[Try to Detour] Ottieni 25 Sigilli Neri"
  },
  Event_129275_Desc = {
    Text = "Negli abissi stellati, i Navigatori hanno dormito per secoli.\nIl mare sconfinato è stato testimone della loro follia, della loro resistenza e della loro fede più devota.\nNessuno può ostacolare la grande venuta del loro Dio.\nColoro che si frappongono saranno ridotti in cenere dall'ira dei Navigatori."
  },
  Event_129275_Name = {
    Text = "Veglia sotto le Stelle"
  },
  Event_129276_ChoiceDesc1 = {
    Text = "[Play a Few Notes] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_129276_ChoiceDesc2 = {
    Text = "[Rimettere il coperchio] Incidi 1 Orazione su 3 due volte"
  },
  Event_129276_Desc = {
    Text = "Il pianoforte accostato al muro ha il coperchio aperto. I suoi tasti sono ingialliti e i bordi screpolati lasciano intravedere il legno sottostante, eppure ogni tasto è stato ripulito con cura.\nÈ una fonte di gioia per così tanti."
  },
  Event_129276_Name = {
    Text = "Filastrocca"
  },
  Event_129277_ChoiceDesc1 = {
    Text = "[Accettare il Fantasma] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\" due volte, infetta \"(Skill.Arg2)\" due volte"
  },
  Event_129277_ChoiceDesc2 = {
    Text = "[Deny the Illusion] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_129277_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_129277_Desc = {
    Text = [[
Sotto il pesante e cupo ponte di ferro, una farfalla scintillante si leva d'improvviso dalla silenziosa riva del fiume ricoperta di canne.
La farfalla si posa delicatamente sul tuo palmo, zittendo gli orrendi ululati. Al loro posto, odi le cantilene ritmiche degli operai che spostano l'acciaio, il battere dei martelli e il nitido tintinnio dei rivetti...]]
  },
  Event_129277_Name = {
    Text = "Miraggio del ponte d'acciaio"
  },
  Event_129278_ChoiceDesc1 = {
    Text = "[Mostrare la Maledizione] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\" due volte, infetta \"(Skill.Arg2)\" due volte"
  },
  Event_129278_ChoiceDesc2 = {
    Text = "[Rifiutare il corvo] Incidi 1 Orazione su 3 due volte"
  },
  Event_129278_ChoiceDesc3 = {Text = "[Ignore]"},
  Event_129278_Desc = {
    Text = "Un corvo policefalo, nero come la pece e dall'aspetto malsano, vola fuori dalla veste nera di un Devoto del Portatore di Luce e si posa sulla tua spalla.\n\"Vedi la mia testa? Finché assaggio la maledizione, mi crescerà una nuova testa. Fammi vedere, la tua maledizione!\""
  },
  Event_129278_Name = {
    Text = "Corvo Maledetto"
  },
  Event_129279_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129279_Name = {
    Text = "Oblio Capitolo 7@"
  },
  Event_129280_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129280_Name = {
    Text = "Oblio Capitolo 3@"
  },
  Event_129281_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129281_Name = {
    Text = "Oblio Capitolo 4@"
  },
  Event_129282_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129282_Name = {
    Text = "Oblio Capitolo 2@"
  },
  Event_129283_ChoiceDesc1 = {
    Text = "[Placeholder]Testo temporaneo."
  },
  Event_129283_Name = {
    Text = "Astral Reign Capitolo 2@"
  },
  Event_129900_ChoiceDesc1 = {
    Text = "[Bury] Distruggi una Carta di comando e recupera Arg2 PV. [ExDesc1]"
  },
  Event_129900_ChoiceDesc2 = {
    Text = "[Pray] Acquisisci la Reliquia d'oro \"(RelicConfig.Arg1),\" ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_129900_Desc = {
    Text = "Uno Scheletro pallido, per metà sommerso in una D-melma nero pece."
  },
  Event_129900_Name = {
    Text = "Ossa Sbiadite"
  },
  Event_130337_ChoiceDesc1 = {
    Text = "[Prendi Posto] Mescola [marionetta] nel tuo mazzo."
  },
  Event_130337_Desc = {
    Text = "Nel momento in cui posi piede sui gradini del teatro, il tuo sguardo non potrà mai più distogliersi da questo palcoscenico.\nI fili del destino trascinano innumerevoli storie nel loro flusso vorticoso qui—la polvere del passato, la luce tremolante del presente e le nebbie del futuro si agitano incessantemente sul palco.\nHai dimenticato la tua origine e la tua destinazione. Ogni vestigia del \"Sé\" si dissolve nelle ombre dei pesanti sipari. In quest'ora, sei lo spettatore silenzioso in platea e l'attore ardente sulle assi del palco.\nL'intera tua esistenza si riduce a due sole tracce: contemplare ed esibirsi."
  },
  Event_130337_Name = {
    Text = "Il palcoscenico del destino"
  },
  Event_131264_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131264_Desc = {
    Text = "Scegli il potere. Scegli una convinzione incrollabile e il coraggio di andare sempre avanti.\nEppure, il prezzo... Lo scopo stesso di un prezzo è essere pagato, non è vero?"
  },
  Event_131264_Name = {
    Text = "Sguardo nel passato"
  },
  Event_131265_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131265_Desc = {
    Text = [[
Sopportando l'agonia nella tua mente, afferri saldamente i frammenti frastagliati alla deriva. Grazie alla tua cupa perseveranza, le fratture iniziano a risanarsi.
Parti per ricordare, e combatti per ricordare. Non lascerai che alcun ricordo svanisca.]]
  },
  Event_131265_Name = {
    Text = "Ricordi infranti"
  },
  Event_131266_ChoiceDesc1 = {
    Text = "[Proteggi il ricordo] Incidi 1 Orazione su 3"
  },
  Event_131266_ChoiceDesc2 = {
    Text = "[Sigilla la frattura] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando, ma sviluppi \"(Skill.Arg2)\""
  },
  Event_131266_Desc = {
    Text = "Non hai mai dubitato dei tuoi ricordi. Erano caldi, resilienti—il tuo porto più sicuro e il tuo tesoro più prezioso.\nMa ora, sotto l'interferenza dell'Abisso, quei ricordi iniziano a creparsi e a frantumarsi."
  },
  Event_131266_Name = {
    Text = "Ricordi infranti"
  },
  Event_131267_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131267_Desc = {
    Text = "Un'ondata di energia spirituale inonda la tua mente, ricucendo le orribili lacerazioni. Con ogni briciolo di volontà, ripristini le fratture fino a renderle integre.\nParti per ricordare, e combatti per ricordare. Non lascerai che alcun ricordo svanisca."
  },
  Event_131267_Name = {
    Text = "Ricordi infranti"
  },
  Event_131268_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131268_Desc = {
    Text = [[
"Ooh... Hahahha!!"
Nessuno capisce la tua domanda. Rispondono con pianti e risate stridule.]]
  },
  Event_131268_Name = {
    Text = "Gli Abbandonati"
  },
  Event_131269_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131269_Desc = {
    Text = "Ricambi il loro sguardo. I fili si agitano; il tuo sguardo gentile attira i ricordi vicino, avvolgendoli in un abbraccio.\nOsservi in silenzio il burattinaio del destino. Se le fosse data un'altra possibilità, quale scelta farebbe?"
  },
  Event_131269_Name = {
    Text = "Sguardo nel passato"
  },
  Event_131270_ChoiceDesc1 = {Text = "[Leave]"},
  Event_131270_Desc = {
    Text = [[
"Ooh... Hahahha!!"
I pianti e le risate si affievoliscono, dissolvendosi nell'aria. Nessuna anima si alza per farti del male: hanno imparato da tempo a convivere con l'essere invisibili.]]
  },
  Event_131270_Name = {
    Text = "Gli Abbandonati"
  },
  Event_131271_ChoiceDesc1 = {
    Text = "[Fissa il ricordo] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\""
  },
  Event_131271_ChoiceDesc2 = {
    Text = "[Abbandona il ricordo] Risveglio di 2 Risvegliatori casuali, ma sviluppi [(Skill.Arg1)] due volte"
  },
  Event_131271_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_131271_Desc = {
    Text = [[
All'interno del vascello della ragazza, risuona il fragore di porcellana infranta. I ricordi si liberano dai loro contenitori, fluttuando verso di te.
Compagni di giochi d'infanzia, regali dei genitori, il puro capriccio delle nuvole e degli uccelli, ideali puri come il cielo aperto... Tutti i ricordi aprono gli occhi, fissandoti in silenzio.
Interrogano. Piangono. Attendono.]]
  },
  Event_131271_Name = {
    Text = "Sguardo nel passato"
  },
  Event_131272_ChoiceDesc1 = {
    Text = "[Chiedere] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_131272_ChoiceDesc2 = {
    Text = "[Ignorare] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_131272_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_131272_Desc = {
    Text = [[
Lamenti laceranti graffiano le tue orecchie; davanti a te, spiriti agonizzanti si strappano i volti e le forme...
Chi sono? Prigionieri dell'Abisso? Destini gettati via? Echi del passato, forse?]]
  },
  Event_131272_Name = {
    Text = "Gli Abbandonati"
  },
  Event_133380_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_133380_Desc = {
    Text = "Ti sei accomodato sulla tua poltrona di velluto, e i sipari cremisi si aprono in un sussurro sommesso.\nCaro spettatore, il palcoscenico si leverà per soddisfare ogni tua aspettativa.\nIl protagonista di questa rappresentazione ha già preso posizione."
  },
  Event_133380_Name = {
    Text = "Il palcoscenico del destino"
  },
  Event_141995_ChoiceDesc1 = {
    Text = "[Prova semplice] Elimina fino a 5 Carte qualsiasi"
  },
  Event_141995_ChoiceDesc2 = {
    Text = "[Lascia che studi] Elimina casualmente 5 Carte di comando, ottieni la Reliquia Benedetta [(RelicConfig.Arg1)]."
  },
  Event_141995_ChoiceDesc3 = {
    Text = "[Pensiero inverso?] Scegli fino a due Risvegliatori, genera un set completo delle loro Carte base e inseriscilo nel mazzo"
  },
  Event_141995_Desc = {
    Text = [[
Arrivi in una piazza affollata di gente indaffarata; forse qui puoi trovare qualcosa di interessante.
Bussi alla porta di una stanza illuminata da una luce fioca e gialla; una persona vestita da Ricercatore fa capolino. Vedi molti strumenti scientifici sconosciuti; ti prende per mano e ti fa sedere, dichiarando di essere un "evoluzionista". Con il volto pieno di Fervore, ti raccomanda con insistenza il suo "metodo scientifico".
"Solo eliminando le ridondanze inutili dell'essere umano si percorre la vera via dell'evoluzione!"]]
  },
  Event_141995_Name = {
    Text = "Evoluzionista"
  },
  Event_141996_ChoiceDesc1 = {
    Text = "[Allenamento speciale sull'attacco] Aggiunge un'Orazione casuale a tutti i Colpi Base privi di Orazione"
  },
  Event_141996_ChoiceDesc2 = {
    Text = "[Allenamento speciale sulla difesa] Aggiunge un'Orazione casuale a tutte le DIF base prive di Orazione"
  },
  Event_141996_ChoiceDesc3 = {
    Text = "[Allenamento speciale senza riserve] Aggiunge un'Orazione casuale a 15 Carte di comando casuali, ottieni 5 Carte sintomo casuali"
  },
  Event_141996_Desc = {
    Text = "Arrivi in una piazza affollata di persone indaffarate; forse qui puoi trovare qualcosa di interessante.\nIl tintinnio del metallo risuona nello spiazzo aperto: alcune persone si stanno sfidando a vicenda per affinare le proprie abilità marziali. Un giovane in vecchia armatura ti nota e ti lancia una spada, invitandoti ad allenarti con loro."
  },
  Event_141996_Name = {
    Text = "Ora di allenamento speciale"
  },
  Event_141997_ChoiceDesc1 = {
    Text = "[Puntare sul grande] 50% di possibilità di ottenere un'Orazione casuale e ripuntare, 50% di possibilità di ottenere 75 Il sigillo nero"
  },
  Event_141997_ChoiceDesc2 = {
    Text = "[Puntare sul piccolo] 50% di possibilità di ottenere un'Orazione casuale e ripuntare, 50% di possibilità di ottenere 75 Il sigillo nero"
  },
  Event_141997_Desc = {
    Text = "Il cameriere mantiene il suo sorriso immutato, solleva il bussolotto e un suono cristallino Eco nella sala mentre gli altri giocatori fanno le loro scelte. \"Le puntate sono chiuse\", dice, \"fate le vostre Scommesse—\""
  },
  Event_141997_Name = {
    Text = "Casinò chiassoso"
  },
  Event_141998_ChoiceDesc1 = {
    Text = "[Puntare onestamente] Elimina una Carta di comando"
  },
  Event_141998_ChoiceDesc2 = {
    Text = "[Tentare il baro] Elimina una Carta sintomo"
  },
  Event_141998_ChoiceDesc3 = {Text = "[Leave]"},
  Event_141998_Desc = {
    Text = "Giungi in un luogo estremamente animato, dove tutti hanno un'espressione felice e le luci colorate lampeggiano sfrenate, non lasciando spazio alla notte. Ovunque si vedono cartelli con scritto: \"Benvenuti al Carnevale! Qui i Sogni non hanno mai Fine, qui la Gioia non Cala mai il Sipario!\"\nTrascinato dalla folla, vieni spinto all'interno di un edificio sfarzoso: la sala è riccamente decorata, piena di voci e impregnata di un dolce profumo di vino. Un dado rotola fino ai tuoi piedi, e un cameriere con un sorriso adulatorio ti dice che è un simbolo di buona fortuna. Mosso dalla curiosità, fai un passo avanti — forse potresti metterti in mostra in questo gioco."
  },
  Event_141998_Name = {
    Text = "Casinò chiassoso"
  },
  Event_141999_ChoiceDesc1 = {
    Text = "[Baratto] Rimuovi 1 Reliquia, 50% Probabilità di ottenere 1 Reliquia d'oro a scelta tra 3, 50% Probabilità di ottenere 25 Il sigillo nero"
  },
  Event_141999_ChoiceDesc2 = {Text = "[Leave]"},
  Event_141999_Desc = {
    Text = "Giungi in un luogo estremamente animato, dove tutti hanno un'espressione felice sul Il Volto, e le luci colorate che brillano sfrenate non lasciano spazio alla notte. Ovunque si vedono cartelli con scritto: \"Benvenuto al Carnevale! Qui il Sogno non ha mai Fine, qui la Gioia non Cala il Sipario!\"\nTra la Folla, un Mercante dall'aspetto lacero ma con un pacco incredibilmente grande ti fa cenno con la mano. Batte la mano sul pacco accanto a sé, si avvicina abbassando la voce e ti propone un Baratto. Il vecchio sacchetto di tela oscilla dolcemente mentre lui parla, emettendo di tanto in tanto un crepitio."
  },
  Event_141999_Name = {
    Text = "Mercante Lacero"
  },
  Event_142000_ChoiceDesc1 = {
    Text = "[Prova a esprimere un desiderio] Consuma il 50% della Vita attuale, ottieni 2 Reliquie d'oro casuali"
  },
  Event_142000_ChoiceDesc2 = {
    Text = "[Esprimi un desiderio con tutto te stesso] Consuma il 99% della Vita attuale, ottieni il Pendolo crono [(RelicConfig.Arg2)]"
  },
  Event_142000_ChoiceDesc3 = {
    Text = "[Allunga la mano sul fondo della vasca] Ottieni la Reliquia d'oro [(RelicConfig.Arg1)]"
  },
  Event_142000_Desc = {
    Text = "Il Vento soffia sulla campagna, tutto intorno regna il silenzio, rotto Solo dal fruscio degli alberi.\nAll'improvviso, senti il gorgoglio di qualcosa che scorre. Seguendo il suono, un intenso odore dolciastro di Sangue ti colpisce per primo, e finalmente scorgi la fonte di quel rumore d'acqua: è una fontana dei desideri, colma di rosso, dove il Sangue di innumerevoli persone è in Ondata nella vasca, Come Se qualcosa stesse per emergere dalla superficie del liquido.\nUna voce risuona nel profondo del tuo cuore: \"Offri il tuo Sangue, e ti concederò la mia grazia.\""
  },
  Event_142000_Name = {
    Text = "Fonte di Sangue"
  },
  Event_142001_ChoiceDesc1 = {
    Text = "[Offerta semplice] Scegli di eliminare 2 Reliquie, ottieni la Reliquia peccaminosa [(RelicConfig.Arg1)]"
  },
  Event_142001_ChoiceDesc2 = {
    Text = "[Offerta devota] Scegli di eliminare 4 Reliquie, ottieni la Reliquia Benedetta [(RelicConfig.Arg1)]"
  },
  Event_142001_ChoiceDesc3 = {
    Text = "[Ruba qualche offerta, nessuno lo saprà] Ottieni la Reliquia d'oro [(RelicConfig.Arg1)]"
  },
  Event_142001_Desc = {
    Text = [[
Il Vento soffia sulla campagna, tutto intorno regna il silenzio, rotto Solo dal fruscio degli alberi.
Senza accorgertene, ti ritrovi davanti a un antico altare. Un'enorme statua ti osserva dall'alto con il suo Sguardo, come se volesse prendere qualcosa dalle tue mani. Vedi incise sotto l'altare delle parole sbiadite: "Dare e avere si equivalgono".]]
  },
  Event_142001_Name = {
    Text = "Altare del Dare e Avere"
  },
  Event_142002_ChoiceDesc1 = {
    Text = "[Prova gratuita] Potenziamento casuale di Arg2 Reliquia d'argento"
  },
  Event_142002_ChoiceDesc2 = {
    Text = "[Servizio standard] Consuma Arg1 Il sigillo nero: Potenziamento casuale di Arg2 Reliquia d'argento"
  },
  Event_142002_ChoiceDesc3 = {
    Text = "[Servizio deluxe] Consuma Arg1 Il sigillo nero: Potenziamento casuale di Arg2 Reliquia d'argento"
  },
  Event_142002_Desc = {
    Text = [[
Arrivi in una piazza affollata di gente indaffarata; forse qui puoi trovare qualcosa di interessante.
Un piccolo edificio illuminato da luci calde si erge silenzioso in un angolo della piazza. Sembra un club Av., ma la targa scura appesa al muro recita chiaramente: "Questo esercizio serve esclusivamente esseri non biologici."]]
  },
  Event_142002_Name = {
    Text = "Club Esclusivo"
  },
  Event_142003_ChoiceDesc1 = {
    Text = "[Estrai una volta] Ottieni una Carta sintomo"
  },
  Event_142003_ChoiceDesc2 = {
    Text = "[Vai via] Ottieni 75 Il sigillo nero"
  },
  Event_142003_Desc = {
    Text = "Giungi in un luogo estremamente animato, dove tutti hanno un'espressione felice e le luci colorate lampeggiano sfrenate, non lasciando spazio alla notte. Ovunque si vedono cartelli con scritto: \"Benvenuti al Carnevale! Qui i Sogni non hanno mai Fine, qui la Gioia non Cala mai il Sipario!\"\nNoti sul bordo del Sentiero una bancarella della lotteria circondata da una folla di persone: tutti gli occhi sono puntati sul grande premio, nascosto alla vista — il Venditore ne esalta la rarità e le persone fanno a gara per partecipare."
  },
  Event_142003_Name = {
    Text = "Sfida della lotteria"
  },
  Event_142004_ChoiceDesc1 = {
    Text = "[Usarla un momento]"
  },
  Event_142004_ChoiceDesc2 = {Text = "[Leave]"},
  Event_142004_Desc = {
    Text = "Il Vento soffia sulla campagna, tutto intorno regna il silenzio, rotto solo dal fruscio degli alberi.\nAll'improvviso, scorgi una vecchia capanna di paglia: al centro campeggia un'incudine, affiancata da numerose armi metalliche arrugginite. Sembra una fucina abbandonata da tempo. Accanto all'incudine è posta una guida dettagliata sull'utilizzo, che ti informa che puoi portarvi le Reliquie per modificarle."
  },
  Event_142004_Name = {Text = "Fucina"},
  Event_142005_ChoiceDesc1 = {
    Text = "[Puntare onestamente] Elimina una Carta di comando"
  },
  Event_142005_ChoiceDesc2 = {
    Text = "[Tentare il baro] Elimina una Carta sintomo"
  },
  Event_142005_ChoiceDesc3 = {Text = "[Leave]"},
  Event_142005_Desc = {
    Text = "Le Evviva degli astanti proclamano la tua vittoria. Tra le voci caotiche, anche tu, come loro, ti sei lasciato inebriare da questo Sogno bizzarro in cui si scommette tutto. Guardi le fiches tra le mani, Come Se fossero i compagni più fedeli che ti portano gloria. Un Sussurro giunge dal profondo del tavolo da gioco, avvolto in una richiesta ambigua: \"farlo di nuovo, vincere ancora una volta.\""
  },
  Event_142005_Name = {
    Text = "Casinò chiassoso"
  },
  Event_142013_ChoiceDesc1 = {
    Text = "[Puntare sul grande] 50% di possibilità di ottenere una Reliquia d'argento casuale e ripuntare, 50% di possibilità di ottenere 75 Il sigillo nero e entrare in combattimento Élite"
  },
  Event_142013_ChoiceDesc2 = {
    Text = "[Puntare sul piccolo] 50% di possibilità di ottenere una Reliquia d'argento casuale e ripuntare, 50% di possibilità di ottenere 75 Il sigillo nero e entrare in combattimento Élite"
  },
  Event_142013_Desc = {
    Text = "Il cameriere mantiene il suo sorriso immutato, solleva il bussolotto e un suono cristallino Eco nella sala mentre gli altri giocatori fanno le loro scelte. \"Le puntate sono chiuse\", dice, \"fate le vostre Scommesse—\""
  },
  Event_142013_Name = {
    Text = "Casinò chiassoso"
  },
  Event_142073_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142073_Desc = {
    Text = "Il cameriere solleva il bussolotto e per pochi secondi l'aria sembra Stagnare. Nel momento in cui la risposta viene rivelata, senti urla di gioia e lamenti mischiarsi insieme. La fortuna non ti ha Benedetto: i dadi posati in silenzio sul tavolo hanno dato una risposta opposta alla tua. Dai un ultimo sguardo in giro, osservando quei giocatori in preda alla Follia. È ora di andare."
  },
  Event_142073_Name = {
    Text = "Casinò chiassoso"
  },
  Event_142074_ChoiceDesc1 = {
    Text = "[Entra in combattimento]"
  },
  Event_142074_Desc = {
    Text = "Mentre fissi il tavolo da gioco con trepidazione, la tua mano viene improvvisamente afferrata con forza. Alzando lo sguardo, vedi il Boss del casinò che ti guarda dall'alto, pronto a cacciare chiunque non rispetti le regole. In un istante, tutti gli occhi si concentrano su di te — sguardi stupiti, ostili, compiaciuti... Realizzi che forse si può barare molte volte, ma Purché si venga Scoperti anche Solo una volta, si va incontro a una rovina totale."
  },
  Event_142074_Name = {
    Text = "Casinò chiassoso"
  },
  Event_142103_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142103_Desc = {
    Text = "Riesci a sgattaiolare dal casinò con mezzi fisici, lasciandoti alle spalle il clamore della Folla e accelerando il passo per allontanarti — quanto al caos lasciato dietro, ci penserà qualcun altro a sistemarlo."
  },
  Event_142103_Name = {
    Text = "Casinò chiassoso"
  },
  Event_142105_ChoiceDesc1 = {
    Text = "[Pesca di nuovo] Ottieni una Carta sintomo"
  },
  Event_142105_ChoiceDesc2 = {
    Text = "[Vai via] Ottieni 75 Il sigillo nero"
  },
  Event_142105_Desc = {
    Text = "Provi a estrarre una volta — non succede nulla. Ma sul retro della carta c'è scritto: \"La prossima volta sarà più facile\"\n...Vuoi riprovare?"
  },
  Event_142105_Name = {
    Text = "Sfida della lotteria"
  },
  Event_142106_ChoiceDesc1 = {
    Text = "[Pesca di nuovo] Ottieni una Carta sintomo"
  },
  Event_142106_ChoiceDesc2 = {
    Text = "[Vai via] Ottieni 75 Il sigillo nero"
  },
  Event_142106_Desc = {
    Text = "Provi a estrarre una volta — non succede nulla. Ma sul retro della carta c'è scritto: \"La prossima volta sarà più facile\"\n...Vuoi riprovare?"
  },
  Event_142106_Name = {
    Text = "Sfida della lotteria"
  },
  Event_142107_ChoiceDesc1 = {
    Text = "[Pesca di nuovo] Ottieni una Carta sintomo"
  },
  Event_142107_Desc = {
    Text = "Provi a estrarre una volta — non succede nulla. Ma sul retro della carta c'è scritto: \"La prossima volta sarà più facile\"\n...Vuoi riprovare?"
  },
  Event_142107_Name = {
    Text = "Sfida della lotteria"
  },
  Event_142108_ChoiceDesc1 = {
    Text = "[Pesca di nuovo] Ottieni una Carta sintomo"
  },
  Event_142108_ChoiceDesc2 = {
    Text = "[Vai via] Ottieni 75 Il sigillo nero"
  },
  Event_142108_Desc = {
    Text = "Provi a estrarre una volta — non succede nulla. Ma sul retro della carta c'è scritto: \"La prossima volta sarà più facile\"\n...Vuoi riprovare?"
  },
  Event_142108_Name = {
    Text = "Sfida della lotteria"
  },
  Event_142109_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142109_Desc = {
    Text = "Ascoltando il battito del cuore, Tu hai scoperto il biglietto della lotteria, e le abbaglianti lettere dorate ti sono saltate agli Occhi. Il Venditore ha agitato il campanello con Euforia, e tutti i passanti ti hanno lanciato sguardi invidiosi.\n\"Il premio maggiore è stato estratto!\""
  },
  Event_142109_Name = {
    Text = "Sfida della lotteria"
  },
  Event_142110_ChoiceDesc1 = {
    Text = "[Pesca di nuovo] Ottieni una Carta sintomo"
  },
  Event_142110_ChoiceDesc2 = {
    Text = "[Vai via] Ottieni 75 Il sigillo nero"
  },
  Event_142110_Desc = {
    Text = "Provi a estrarre una volta — non succede nulla. Ma sul retro della carta c'è scritto: \"La prossima volta sarà più facile\"\n...Vuoi riprovare?"
  },
  Event_142110_Name = {
    Text = "Sfida della lotteria"
  },
  Event_142118_ChoiceDesc1 = {
    Text = "[Baratto] Rimuovi 1 Reliquia, 25% Probabilità di ottenere 1 Pendolo crono a scelta tra 3, 50% Probabilità di ottenere 2 Reliquie d'oro casuali, 25% Probabilità di ottenere 25 Il sigillo nero"
  },
  Event_142118_ChoiceDesc2 = {Text = "[Leave]"},
  Event_142118_Desc = {
    Text = "Il Mercante prende l'oggetto che gli porgi e lo esamina alla luce della luna, girandolo e rivoltandolo, con gli Occhi quasi sul punto di uscire dalle orbite. Dopo una lunga attesa, finalmente si apre in un sorriso e tira fuori dal sacco una scatola di ferro arrugginita. \"Aprila e vedi, è la blind box più di tendenza del momento.\"\nLa apri, ma scopri che Dentro ci sono Solo alcuni Sigilli Neri tutt'altro che soddisfacenti. Il Mercante si strofina le mani e, con uno sguardo pieno di scuse, ti dice che puoi riprovare."
  },
  Event_142118_Name = {
    Text = "Mercante Lacero"
  },
  Event_142119_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142119_Desc = {
    Text = "Il Mercante prende l'oggetto che gli porgi e lo esamina alla luce della luna, girandolo e rivoltandolo, con gli Occhi quasi sul punto di uscire dalle orbite. Dopo una lunga attesa, finalmente si apre in un sorriso e tira fuori dal sacco una scatola di ferro arrugginita. \"Aprila e vedi, è la blind box più di tendenza del momento.\"\nLa apri, e dentro c'è qualcosa."
  },
  Event_142119_Name = {
    Text = "Mercante Lacero"
  },
  Event_142120_ChoiceDesc1 = {
    Text = "[Baratto] Rimuovi 1 Reliquia d'oro, 50% Probabilità di ottenere 1 Pendolo crono a scelta tra 3, 50% Probabilità di ottenere 1 Reliquia Benedetta a scelta tra 3"
  },
  Event_142120_ChoiceDesc2 = {Text = "[Leave]"},
  Event_142120_Desc = {
    Text = "Apri di nuovo la blind box, ma scopri che non c'è ancora l'oggetto che desideri. Il Mercante si affretta a sorridere imbarazzato e tira fuori un'altra scatola di ferro, porgendotela con entrambe le mani.\n\"Non arrabbiarti, cliente! Ti giuro, questa volta ci sarà sicuramente qualcosa di straordinario...\" dice, ma nel frattempo sposta di nascosto una mano verso di te, aprendola nel tuo senso, \"Naturalmente, un tesoro va scambiato con un tesoro.\""
  },
  Event_142120_Name = {
    Text = "Mercante Lacero"
  },
  Event_142138_ChoiceDesc1 = {
    Text = "[Usarla un momento]"
  },
  Event_142138_ChoiceDesc2 = {Text = "[Leave]"},
  Event_142138_Desc = {
    Text = "Hai usato con successo questi strumenti; nonostante qualche danno, sembrano ancora funzionare."
  },
  Event_142138_Name = {Text = "Fucina"},
  Event_142139_ChoiceDesc1 = {
    Text = "[Fusione frantumata] Scegli 1 Reliquia d'oro da eliminare, ottieni 2 Reliquie d'argento e 50 Il sigillo nero"
  },
  Event_142139_ChoiceDesc2 = {
    Text = "[Tempra] Scegli 2 Reliquie da eliminare, ottieni la Reliquia d'oro [(RelicConfig.Arg1)]."
  },
  Event_142139_ChoiceDesc3 = {
    Text = "[Tempra Premium] Scegli 2 Reliquie d'oro da eliminare, ottieni il Pendolo crono [(RelicConfig.Arg1)]."
  },
  Event_142139_Desc = {
    Text = "Prendi il martello lì accanto e ti prepari a..."
  },
  Event_142139_Name = {Text = "Fucina"},
  Event_142140_ChoiceDesc1 = {
    Text = "[Usarla un momento]"
  },
  Event_142140_ChoiceDesc2 = {Text = "[Leave]"},
  Event_142140_Desc = {
    Text = "Hai usato con successo questi strumenti; nonostante qualche danno, sembrano ancora funzionare."
  },
  Event_142140_Name = {Text = "Fucina"},
  Event_142141_ChoiceDesc1 = {
    Text = "[Fusione frantumata] Scegli 1 Reliquia d'oro da eliminare, ottieni 2 Reliquie d'argento e 50 Il sigillo nero"
  },
  Event_142141_ChoiceDesc2 = {
    Text = "[Tempra] Scegli 2 Reliquie da eliminare, ottieni la Reliquia d'oro [(RelicConfig.Arg1)]."
  },
  Event_142141_ChoiceDesc3 = {
    Text = "[Tempra Premium] Scegli 2 Reliquie d'oro da eliminare, ottieni il Pendolo crono [(RelicConfig.Arg1)]."
  },
  Event_142141_Desc = {
    Text = "Prendi il martello lì accanto e ti prepari a..."
  },
  Event_142141_Name = {Text = "Fucina"},
  Event_142142_ChoiceDesc1 = {
    Text = "[Fusione frantumata] Scegli 1 Reliquia d'oro da eliminare, ottieni 2 Reliquie d'argento e 50 Il sigillo nero"
  },
  Event_142142_ChoiceDesc2 = {
    Text = "[Tempra] Scegli 2 Reliquie da eliminare, ottieni la Reliquia d'oro [(RelicConfig.Arg1)]."
  },
  Event_142142_ChoiceDesc3 = {
    Text = "[Tempra Premium] Scegli 2 Reliquie d'oro da eliminare, ottieni il Pendolo crono [(RelicConfig.Arg1)]."
  },
  Event_142142_Desc = {
    Text = "Prendi il martello lì accanto e ti prepari a..."
  },
  Event_142142_Name = {Text = "Fucina"},
  Event_142167_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142167_Desc = {
    Text = "Dopo tre utilizzi, l'incudine si è completamente incavata e il martello è pieno di segni di usura: sembra ormai inutilizzabile."
  },
  Event_142167_Name = {Text = "Fucina"},
  Event_142235_ChoiceDesc1 = {
    Text = "[Andrò Avanti] Ottieni \"Immacolatezza\"—tutte le Carte di comando ricevono 20 accumuli permanenti di Potenziare."
  },
  Event_142235_ChoiceDesc2 = {
    Text = "[Non Tornerò Indietro] Ottieni \"Sublimazione\"—il Keyflare e il Limite di Aliemus diminuiscono permanentemente del -20%."
  },
  Event_142235_Desc = {
    Text = "I tuoi occhi vengono improvvisamente avvolti da una nebbia, il mondo inizia a diventare sempre più confuso, e in un momento di torpore, una voce risuona nel profondo del tuo cuore:\n\"Vuoi ancora andare avanti?\""
  },
  Event_142235_Name = {
    Text = "Il Capolinea si Avvicina"
  },
  Event_142925_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142925_Desc = {
    Text = "Il personale del club ha accettato il compenso e ti ha fornito il servizio base. Hanno portato gli oggetti che hai consegnato in uno scompartimento buio; l'attesa non è stata lunga e, quando sono riapparsi, le cose erano già sul vassoio, sembravano leggermente diverse da prima."
  },
  Event_142925_Name = {
    Text = "Club Esclusivo"
  },
  Event_142926_ChoiceDesc1 = {
    Text = "[Elimina una Reliquia d'oro] (è necessario avere una Reliquia d'oro)"
  },
  Event_142926_ChoiceDesc2 = {
    Text = "[Sono disponibili Reliquie con Potenziare (Forged)]"
  },
  Event_142926_ChoiceDesc3 = {Text = "[Leave]"},
  Event_142926_Desc = {
    Text = "Test \"Quantità di Reliquie\" \"Lista di selezione Reliquie\""
  },
  Event_142927_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142927_Desc = {
    Text = "Il personale del club ha accettato il compenso e ti ha fornito il servizio deluxe. Hanno riposto solennemente i tuoi oggetti in una scatola e li hanno portati in uno scompartimento buio. Hai atteso a lungo, finché non sono riapparsi, offrendoti gli oggetti con entrambe le mani, con un'espressione serena come sempre."
  },
  Event_142927_Name = {
    Text = "Club Esclusivo"
  },
  Event_142928_ChoiceDesc1 = {
    Text = "[Seleziona fino a 2 Risvegliatori per riempire l'Aliemus]"
  },
  Event_142928_ChoiceDesc2 = {
    Text = "[È necessario scegliere 2 Risvegliatori con Aliemus al massimo]"
  },
  Event_142928_ChoiceDesc3 = {Text = "[Leave]"},
  Event_142928_Desc = {
    Text = "Test \"Selezione condizionale Risvegliatore\""
  },
  Event_142929_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142929_Desc = {
    Text = "Il Ricercatore ti ha girato intorno più e più volte, osservandoti attentamente a lungo, prima di iniziare a lavorare — senza chiederti il permesso. Dopo un po', quando ti prepari a lasciare questo strano laboratorio, sai chiaramente di aver perso molto, eppure lui batte le mani per congratularsi con te: \"Questa è la vera essenza dell'evoluzione!\""
  },
  Event_142929_Name = {
    Text = "Evoluzionista"
  },
  Event_142930_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142930_Desc = {
    Text = "Hai allungato la mano nell'acqua Cremisi della vasca, tastando il fondo, e hai trovato qualcosa di utile."
  },
  Event_142930_Name = {
    Text = "Fonte di Sangue"
  },
  Event_142931_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142931_Desc = {
    Text = "La voce si allontana, il tuo cuore è colmo di determinazione e senti il Potere emergere."
  },
  Event_142931_Name = {
    Text = "Il Capolinea si Avvicina"
  },
  Event_142932_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142932_Desc = {
    Text = "La voce si allontana, il tuo cuore è colmo di determinazione e la mente è più lucida."
  },
  Event_142932_Name = {
    Text = "Il Capolinea si Avvicina"
  },
  Event_142933_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142933_Desc = {
    Text = "Hai preso un po' di cose dal mucchio di Offerte ammassate come una montagna, poi te ne sei andato rapidamente. Mentre ti allontanavi, gli Occhi della statua sembravano essersi mossi."
  },
  Event_142933_Name = {
    Text = "Altare del Dare e Avere"
  },
  Event_142934_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142934_Desc = {
    Text = "Ti sei allenato concentrandoti sulla Difesa e, di fronte all'Imboscata del tuo Rivale, hai continuato a parare con le armi, migliorando le tue capacità difensive e i tuoi riflessi."
  },
  Event_142934_Name = {
    Text = "Ora di allenamento speciale"
  },
  Event_142935_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142935_Desc = {
    Text = "Il Ricercatore ha indossato i guanti, ha preso dall'armadio alcuni strumenti dalla forma strana e li ha agitati davanti a te. Non sai cosa abbia fatto esattamente, ma sembra che tu ti senta davvero un po' più leggero."
  },
  Event_142935_Name = {
    Text = "Evoluzionista"
  },
  Event_142936_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142936_Desc = {
    Text = "Non hai scelto una direzione specifica, ma ti sei allenato con gli altri ignorando i limiti del tuo corpo, finché Tutti non erano esausti. Sai di aver migliorato molto, ma allo stesso tempo hai pagato un prezzo."
  },
  Event_142936_Name = {
    Text = "Ora di allenamento speciale"
  },
  Event_142937_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142937_Desc = {
    Text = "Hai preso a caso alcune cose dal tuo zaino come Offerta e hai ricevuto una ricompensa di pari valore."
  },
  Event_142937_Name = {
    Text = "Altare del Dare e Avere"
  },
  Event_142938_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142938_Desc = {
    Text = "Hai offerto alcune preziose Offerte e hai ricevuto una ricompensa di pari valore."
  },
  Event_142938_Name = {
    Text = "Altare del Dare e Avere"
  },
  Event_142939_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142939_Desc = {
    Text = "Sei pieno di dubbi sul suo metodo di ricerca e, dopo un acceso dibattito, lui accetta di lasciarti usare gli strumenti da solo, per cercare l'\"evoluzione\" a modo tuo.\nGli stessi attrezzi, eppure per caso e per errore hai fatto \"proliferare\" in abbondanza ciò che avrebbe dovuto essere \"eliminato\"; prima di andartene, hai sentito le urla disperate del Ricercatore."
  },
  Event_142939_Name = {
    Text = "Evoluzionista"
  },
  Event_142940_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142940_Desc = {
    Text = "Il personale del club ti ha offerto il servizio gratuito. Hanno portato gli oggetti che hai consegnato in uno scompartimento buio e, poco dopo, sono tornati, ti hanno restituito le cose in mano senza dire una parola."
  },
  Event_142940_Name = {
    Text = "Club Esclusivo"
  },
  Event_142941_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142941_Desc = {
    Text = "Hai offerto una grande quantità di Sangue alla vasca dei desideri, e un dono prezioso è emerso dalle sue acque."
  },
  Event_142941_Name = {
    Text = "Fonte di Sangue"
  },
  Event_142942_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142942_Desc = {
    Text = "Ti sei allenato concentrandoti sull'attacco e, nello scontro tra le lame, le tue tecniche di Colpo e la tua velocità sono migliorate."
  },
  Event_142942_Name = {
    Text = "Ora di allenamento speciale"
  },
  Event_142943_ChoiceDesc1 = {Text = "[Leave]"},
  Event_142943_Desc = {
    Text = "Hai offerto una piccola quantità di Sangue alla vasca dei desideri, e un dono è emerso dalle sue acque."
  },
  Event_142943_Name = {
    Text = "Fonte di Sangue"
  },
  Event_142944_ChoiceDesc1 = {
    Text = "[Scegli di potenziare una Reliquia]"
  },
  Event_142944_ChoiceDesc2 = {
    Text = "[Potenzia una Reliquia casualmente]"
  },
  Event_142944_ChoiceDesc3 = {
    Text = "[Lascia (Test)]"
  },
  Event_142944_Desc = {
    Text = "Test \"Funzione Potenziamento Reliquia\", la Reliquia si aggiunge da sola"
  },
  Event_146258_ChoiceDesc1 = {
    Text = "[Chiamalo] Ottieni Reliquia maledetta \"(RelicConfig.Arg1)\", Infetta \"(Skill.Arg2)\""
  },
  Event_146258_ChoiceDesc2 = {
    Text = "[Rispondere loro] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_146258_ChoiceDesc3 = {
    Text = "[Ignore Them] Ottieni 50 Sigilli Neri"
  },
  Event_146258_Desc = {
    Text = "Sull'altare, le vesti bianche di Juliette sono avvolte da un denso fumo, la cenere dell'incenso mescolata a un dolce, ramato profumo.\n\n\"La Portatrice di Luce ha pietà dei figli peccatori di questo mondo...\" la sua voce non è alta, eppure taglia nettamente attraverso le preghiere sussurrate del tempio, \"...come una madre amorevole ha pietà del neonato tra le sue braccia.\"\n\nAlla luce delle candele, le offerte sull'altare brillano unte di grasso. Sottili volute di fumo azzurro si attorcigliano verso l'alto lungo i loro contorni, offuscando i volti della folla sottostante.\n\nAttraverso quella foschia ondeggiante, guardi verso Pollux. Si trova tra i fedeli, gli occhi abbassati, il volto che porta un'espressione di pietà devota, perfettamente studiata."
  },
  Event_146258_Name = {
    Text = "Un Vecchio Sogno: III"
  },
  Event_146259_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146259_Desc = {
    Text = "Non farci caso. È solo l'ululato del vento nevoso, il sospiro del lago ghiacciato, o il lamento delle vette.\n\nSono i rami secchi e morti che sussurrano sfregandosi l'uno contro l'altro.\n\nMormorano in un eterno, malinconico dolore per ogni pioniere che sia mai morto nelle gelide crepacce."
  },
  Event_146259_Name = {
    Text = "Aria del Lago Ghiacciato"
  },
  Event_146260_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146260_Desc = {
    Text = "Se la giustizia significa assoluta parità, Helot-catena condivide il tuo diritto di esprimere un desiderio?\n\nIn tal caso, dovresti semplicemente scrollarti di dosso il fatto che ti abbia superato e abbia eliminato la concorrenza?\n\n\"Smettila di sognare ad occhi aperti e continua a scalare!\" La voce di Caraboo ti abbaia nell'orecchio."
  },
  Event_146260_Name = {
    Text = "Equità Assurda"
  },
  Event_146261_ChoiceDesc1 = {
    Text = "[La Montagna Teme la Fame]"
  },
  Event_146261_ChoiceDesc2 = {
    Text = "[La Montagna Teme la Perdita]"
  },
  Event_146261_ChoiceDesc3 = {
    Text = "[La Montagna Teme la Morte]"
  },
  Event_146261_Desc = {
    Text = "Cammini sul corpo della montagna. I suoi fremiti tradiscono i suoi segreti. Ciò che la montagna brama definisce ciò che la montagna teme."
  },
  Event_146261_Name = {
    Text = "Segreto della Montagna"
  },
  Event_146262_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146262_Desc = {
    Text = "Ti perdi nella seta del suo pelo, prigioniero volontario dei tuoi stessi desideri. Accarezzare il gatto è così soddisfacente. Che importa cosa si cela sotto la pelle? Ha davvero importanza?"
  },
  Event_146262_Name = {
    Text = "Il Gatto Nero Strisciante"
  },
  Event_146263_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146263_Desc = {
    Text = "Prendi in silenzio l'estremità del filo e lo annodi intorno al tuo polso.\n\nPollux fa lo stesso. Ben presto, un sottile filo rosso vi unisce entrambi.\n\nLimita quanto terreno potete coprire, ma eravate sempre destinati a vivere e morire insieme, no?\n\nLascerai che il destino si occupi del resto."
  },
  Event_146263_Name = {
    Text = "Un Vecchio Sogno: I"
  },
  Event_146264_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146264_Desc = {
    Text = "\"So che è difficile, figlio mio. Certo che lo so. Ma il mondo non è mai stato un posto gentile per nessuno di noi.\"\n\n\"Un giorno, la farfalla sfuggirà al tuo palmo, e sarà perduta per sempre.\""
  },
  Event_146264_Name = {
    Text = "Illusione, Non Verità"
  },
  Event_146265_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146265_Desc = {
    Text = [[
William alza lo sguardo, i suoi occhi ti sfiorano prima di posarsi sulle creste innevate in lontananza.

"Non hai nulla di cui scusarti," dice con calma, ma con fermezza. "Alcune domande appartengono solo a me, e solo io posso rispondervi."

"Ma grazie. Per i tuoi occhi acuti.]]
  },
  Event_146265_Name = {
    Text = "Immersione Delicata"
  },
  Event_146266_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146266_Desc = {
    Text = "Gli occhi di William vacillano.\n\nApri la bocca, ma scegli di non dire nulla. Il silenzio è la scelta migliore in questo momento. Tra voi due esiste ancora una rara e silenziosa comprensione; non c'è bisogno di rovinarla."
  },
  Event_146266_Name = {
    Text = "Immersione Delicata"
  },
  Event_146267_ChoiceDesc1 = {
    Text = "[Leave] Acquisisci la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_146267_Desc = {
    Text = "\"Ridammelo, ridammelo! Quello è il mio potere!\"\n\nLa montagna piange; la montagna si lamenta. Non riesce a sopportare di essere spogliata di tutto ciò che un tempo possedeva."
  },
  Event_146267_Name = {
    Text = "Segreto della Montagna"
  },
  Event_146268_ChoiceDesc1 = {
    Text = "[Continuare a correre] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando, ma sviluppa \"(Skill.Arg2)\""
  },
  Event_146268_ChoiceDesc2 = {
    Text = "[Aspetta il momento giusto] Ottieni 1 di 3 Orazioni"
  },
  Event_146268_ChoiceDesc3 = {
    Text = "[Allontanarsi lentamente]"
  },
  Event_146268_Desc = {
    Text = "\"Attento, Castor. Il corvo sta guardando.\"\n\nAvanzi in fretta, con Pollux sulle spalle. I suoi occhi in preda al panico scrutano ogni angolo buio, senza trovare nulla.\n\n\"Sopra di noi!\"\n\nUn brivido improvviso ti percorre. Alzi lo sguardo.\n\nAccovacciato in silenzio nell'ombra del cornicione c'è un corvo. Occhi grotteschi ricoprono il suo corpo, fissando in ogni direzione, ora concentrando il loro sguardo interamente su voi due."
  },
  Event_146268_Name = {
    Text = "Un Vecchio Sogno: II"
  },
  Event_146269_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146269_Desc = {
    Text = [[
Ricordi gli avvertimenti del tuo addestramento: non fare mai affidamento esclusivo sulla corda di sicurezza.

Spingendoti con i piedi contro la roccia a strapiombo, riesci disperatamente a controllare la discesa. Ma qualcosa scivola via dallo zaino, rotolando lungo la parete fino a ridursi a un puntino minuscolo, invisibile.

Non importa. Almeno sei vivo.]]
  },
  Event_146269_Name = {
    Text = "Caduta Silenziosa"
  },
  Event_146270_ChoiceDesc1 = {
    Text = "[Listen Closely] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_146270_ChoiceDesc2 = {
    Text = "[Plug Ears] Incidi 1 Orazione su 3"
  },
  Event_146270_Desc = {
    Text = "Il vento e la neve si abbattono sulla parete rocciosa, mescolandosi agli scricchiolii spettrali e fiochi provenienti dal profondo del ghiaccio, frantumandosi in una serie di sospiri piangenti.\n\nSolo in piedi nelle silenziose altezze, ascolti all'improvviso la melodia della montagna.\n\nÈ desolata e solenne — un canto basso e profondo destinato soltanto ai morti."
  },
  Event_146270_Name = {
    Text = "Fantasia della Natura"
  },
  Event_146271_ChoiceDesc1 = {
    Text = "[È il Campanello] Potenzia \"(Skill.Arg1),\" incidi l'Orazione \"(EnchantConfig.Arg2)\" su 1 Carta di comando casuale"
  },
  Event_146271_ChoiceDesc2 = {
    Text = "[È il Cibo] Potenzia \"(Skill.Arg1),\" incidi l'Orazione \"(EnchantConfig.Arg2)\" su 1 Carta di comando casuale"
  },
  Event_146271_ChoiceDesc3 = {
    Text = "[È l'Attesa del Cane] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 Carta di comando casuale"
  },
  Event_146271_Desc = {
    Text = "\"Pavlov suona il campanello, poi dà da mangiare al cane. Col tempo, il semplice tintinnio del campanello fa salivare il cane.\"\n\n\"Dunque. Cosa è, davvero, a far salivare il cane?\""
  },
  Event_146271_Name = {
    Text = "Riflesso Pavloviano"
  },
  Event_146272_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146272_Desc = {
    Text = "Non guardare indietro. William è proprio lì, a portata di mano. Non lasciare che il dolore ti inghiotta. Ti sei perso molto, ma puoi ancora rimediare."
  },
  Event_146272_Name = {
    Text = "Dall'Altra Riva"
  },
  Event_146273_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146273_Desc = {
    Text = "\"Chiudi la mano.\"\n\n\"Ciò che un tempo era squisito si dissolverà in nient'altro che fango nero nella tua stretta.\""
  },
  Event_146273_Name = {
    Text = "Illusione, Non Verità"
  },
  Event_146274_ChoiceDesc1 = {
    Text = "[Ehi! Torna indietro!] Ottieni 50 Sigilli neri"
  },
  Event_146274_ChoiceDesc2 = {
    Text = "[Accarezza il gatto] Ottieni 75 Sigilli neri, ma sviluppa \"(Skill.Arg2)\""
  },
  Event_146274_Desc = {
    Text = "<Italic:\"Miao.\"> Un gatto nero dagli occhi di giada brillante strofina la testa contro il tuo stinco con passi morbidi e silenziosi.\n\nIn quel momento, ti rendi conto che \"N\" è sparita."
  },
  Event_146274_Name = {
    Text = "Il Gatto Nero Strisciante"
  },
  Event_146275_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146275_Desc = {
    Text = "Non emetti un suono. Ti limiti a lasciare che il tuo sguardo vaghi attraverso la foschia, posandosi sugli occhi di Pollux, rifiutandoti di distoglierlo.\n\nNemmeno lui schiva il tuo sguardo. Tuo fratello è sempre stato così — testardo fino al midollo, rifiutandosi di essere il primo ad abbassare la testa.\n\nIl canto nella sala, l'odore di cenere, il sermone di Juliette sulla misericordia e il sacrificio... all'improvviso, tutto sfuma in lontananza. È come se rimaneste solo voi due, a fissarvi attraverso questa sala di vuota pietà, attraverso il vasto arco del tempo."
  },
  Event_146275_Name = {
    Text = "Un Vecchio Sogno: III"
  },
  Event_146276_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146276_Desc = {
    Text = "In questo momento, sei l'unico custode dei tuoi lunghi e pallidi ricordi.\n\nIl Wendigo allunga artigli simili a rami, puntando dritto al tuo cuore, ma tu lo respingi con la sola forza di volontà.\n\nInciampa, ritirandosi nella nebbia divoratrice, lasciando solo un sussurro rauco e secco:\n\n\"Prima o poi, li offrirai a me... e lo farai di buon grado.\""
  },
  Event_146276_Name = {
    Text = "Il Divoratore"
  },
  Event_146277_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146277_Desc = {
    Text = "È un sogno lontano. Un sogno della tua infanzia.\n\n\"Scuotiti,\" ti ricordi. \"Non siamo più lì.\"\n\nTorni alla realtà, solo per ritrovarti in piedi nella neve gelida, circondato da un cerchio di cultisti, con la lama di Pollux puntata direttamente al tuo petto."
  },
  Event_146277_Name = {
    Text = "Un Vecchio Sogno: I"
  },
  Event_146278_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146278_Desc = {
    Text = [[
"Accetto che la morte debba venire."

"Offro volentieri le mie ossa a questo arduo pellegrinaggio."

"Sotto il precipizio, il cielo e la terra forgeranno il mio monumento."]]
  },
  Event_146278_Name = {
    Text = "Presagio di Morte"
  },
  Event_146279_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146279_Desc = {
    Text = "Un riflesso non è altro che un gioco di luce. Quello che Tintura ha visto era probabilmente solo la sua stessa ombra.\n\nIl suo pianeta natale è a milioni di anni luce di distanza; il minimo errore di navigazione li avrebbe dispersi in galassie diverse. Consolandoti con questi pensieri, smetti di ossessionarti su ciò che si trova sotto i tuoi piedi."
  },
  Event_146279_Name = {
    Text = "Il Riflesso Sommerso"
  },
  Event_146280_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146280_Desc = {
    Text = "Viene dalle stelle. Dal profondo albore del tempo. Da cose che l'umanità non conosce ancora, e forse non conoscerà mai.\n\nNon chiedere Loro risposte.\n\nNon conosci il prezzo."
  },
  Event_146280_Name = {
    Text = "Aria del Lago Ghiacciato"
  },
  Event_146281_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146281_Desc = {
    Text = "Ti fermi, lasciando che quella musica tetra ti riempia le orecchie.\n\nIl vento è un violino, la neve pungente un ritmo di tamburi, e il rombo lontano del ghiaccio che si spacca un'armonia bassa e a lungo repressa.\n\nNon riesci a decifrarne il tema, ma sai che, sia nel passato che nel futuro, continuerà a suonare all'infinito per i tanti viaggiatori sepolti qui."
  },
  Event_146281_Name = {
    Text = "Fantasia della Natura"
  },
  Event_146283_ChoiceDesc1 = {
    Text = "[Occhi al Cielo] Tutti i Risvegliatori recuperano Arg1 Aliemus"
  },
  Event_146283_ChoiceDesc2 = {
    Text = "[Calpesta la Vetta Ghiacciata] Scegli di Risvegliare 2 Risvegliatori"
  },
  Event_146283_Desc = {
    Text = "La vetta brilla in silenzio dietro un velo di nuvole e nebbia. I crepacci, le pareti rocciose a strapiombo, le tempeste ululanti—nulla di ciò che dimora qui era mai stato concepito per occhi mortali. Di fronte a tutto questo, sei tremendamente fragile."
  },
  Event_146283_Name = {
    Text = "Toccare la Vetta"
  },
  Event_146284_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146284_Desc = {
    Text = "\"No, non è colpa tua. Sei solo un giocattolo a molla, caricato dal destino.\""
  },
  Event_146284_Name = {
    Text = "Ratto Ingordo"
  },
  Event_146285_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146285_Desc = {
    Text = "\"Capisco. Sei il tipo che si affida all'esperienza oggettiva. Ma non dimenticare: a volte, sotto superfici identiche, si celano verità completamente diverse.\"\n\nLa risata del campanello si allontana nell'ombra."
  },
  Event_146285_Name = {
    Text = "Riflesso Pavloviano"
  },
  Event_146286_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146286_Desc = {
    Text = "Se la giustizia significa che il bene e il male ricevono ciò che meritano, allora chi siede in giudizio?\n\nAnubi e la sua bilancia? Se la gravità dell'oltretomba obbedisce alle leggi della fisica, non sei particolarmente sicuro che il tuo cuore sia più leggero della sua piuma."
  },
  Event_146286_Name = {
    Text = "Equità Assurda"
  },
  Event_146287_ChoiceDesc1 = {
    Text = "[Cerca risposte] Ottieni Reliquia d'argento \"(RelicConfig.Arg1)\", sviluppa \"(Skill.Arg2)\""
  },
  Event_146287_ChoiceDesc2 = {
    Text = "[Resta in silenzio] Ottieni Reliquia d'argento \"(RelicConfig.Arg1)\", sviluppa \"(Skill.Arg2)\""
  },
  Event_146287_ChoiceDesc3 = {
    Text = "[Chiedi scusa] Ottieni 25 Il sigillo nero"
  },
  Event_146287_Desc = {
    Text = "\"Anziano William, quando l'incantesimo del Wendigo ha colpito tutti gli altri, sembrava che tu fossi il primo a liberartene. Stiamo per affrontarli direttamente. Hai qualche consiglio?\n\"\nGli occhi di William vacillano. In essi, cogli un fugace barlume di qualcosa di sfuggente, malinconico e sereno — come un corpo che deriva in acque illuminate dal sole, affondando lentamente verso il buio del fondale marino.\n\n\"Mi dispiace,\" dice. \"Temo di non poterti aiutare in questo.\""
  },
  Event_146287_Name = {
    Text = "Immersione Delicata"
  },
  Event_146288_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146288_Desc = {
    Text = "\"Così cieco all'arte, così terribilmente cieco,\" mormora un'ombra oscura, scuotendo il capo mentre emerge dal buio. \"La verità potrebbe essere veleno. A volte, un'illusione ben custodita è l'unica cosa che preserva la nostra fragile felicità, non è forse così?\""
  },
  Event_146288_Name = {
    Text = "Il Gatto Nero Strisciante"
  },
  Event_146290_ChoiceDesc1 = {
    Text = "[Chi è l'Assassino?] Potenzia \"(Skill.Arg1),\" incidi l'Orazione \"(EnchantConfig.Arg2)\" su 1 carta casuale"
  },
  Event_146290_ChoiceDesc2 = {
    Text = "[È Colpa Mia] Potenzia \"(Skill.Arg1),\" incidi l'Orazione \"(EnchantConfig.Arg2)\" su 1 carta casuale"
  },
  Event_146290_ChoiceDesc3 = {
    Text = "[È il Prezzo della Gola] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando"
  },
  Event_146290_Desc = {
    Text = "<Italic:\"Corri, corri, piccolo topo,\n\nNei canali lunghi e bui.\n\nAnnusa l'aria e senti il dolce—\n\nUna bella crosta di formaggio da mangiare.\n\"\n\n\n\"Trascinala a casa, corri, corri, corri,\n\nOra il ronzio è cominciato.\n\nRonzio, ronzio nella tua testa,\n\nRonzio, ronzio, pieno di terrore.\n\"\n\n\n\"Spingi la porta, spingi la porta,\n\nNessuno sussurra più.\n\"\n\n\"Fratelli, sorelle, in fila,\n\nGuarda come possono restare immobili.\n\nOgni pancia ha un buco,\n\nUn buco vuoto, un buco vuoto.\">"
  },
  Event_146290_Name = {
    Text = "Ratto Ingordo"
  },
  Event_146291_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146291_Desc = {
    Text = "Ti inginocchi e asciughi l'umidità dalla sua guancia. Non chiedi se le lacrime siano vere.\n\"Non importa se sono vere,\" dici. \"Non devi dimostrare nulla a nessuno.\"\nCaraboo apre la bocca, ma la risposta arguta e disinvolta che aveva preparato le muore in gola. Invece, la diga cede. Le sue lacrime scorrono senza preavviso, calde e pesanti sul dorso della tua mano."
  },
  Event_146291_Name = {
    Text = "Lacrime di Coccodrillo"
  },
  Event_146292_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146292_Desc = {
    Text = "\"È meglio non chiedere. Ci sono domande che non hanno bisogno di risposte.\""
  },
  Event_146292_Name = {
    Text = "Ratto Ingordo"
  },
  Event_146293_ChoiceDesc1 = {
    Text = "[Chiama] Ottieni Reliquia d'argento \"(RelicConfig.Arg1)\", sviluppa \"(Skill.Arg2)\""
  },
  Event_146293_ChoiceDesc2 = {
    Text = "[Continua ad ascoltare] Tutti i Risvegliatori recuperano 50 Aliemus, sviluppa \"(Skill.Arg1)\""
  },
  Event_146293_ChoiceDesc3 = {
    Text = "[Ignorare] Ottieni 1 Orazione su 3"
  },
  Event_146293_Desc = {
    Text = "Dove Naraka è caduta, rimane solo l'oscurità.\n\nUna melodia umida si diffonde dalla palude, fredda e pallida come un paio di mani che accarezzano le tue guance con tenera insistenza.\n\nCanta in un basso sussurro: \"Vieni da me. Vieni da me nel silenzio della notte.\""
  },
  Event_146293_Name = {
    Text = "Echi Persistenti"
  },
  Event_146294_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146294_Desc = {
    Text = "Abbassi la testa, lasciando che il fumo offuschi il profilo di Pollux, nascondendo la sua espressione nella nebbia grigio-bianca.\n\nÈ la cosa più sicura, ti dici. Non c'è bisogno di guardare, non c'è bisogno di pensare.\n\nIl sermone di Juliette continua a scorrerti addosso. Fissi le mani intrecciate, in silenzio.\n\nSolo quando la campana del rito suona osi alzare di nuovo gli occhi.\n\nPollux ha mantenuto la sua postura devota per tutto il tempo.\n\nAttraverso il vasto spazio del tempo e dell'illusione, non puoi essere certo se qualcosa sia scivolato via proprio in quell'istante."
  },
  Event_146294_Name = {
    Text = "Un Vecchio Sogno: III"
  },
  Event_146295_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146295_Desc = {
    Text = [[
"Pollux!"
Il nome riesce appena a lasciarti la gola prima che tu lo soffochi. Si disperde nel fumo dell'incenso come nient'altro che un fievole, impercettibile sospiro.

Intorno a te, il canto dei fedeli non vacilla, ma qualche sguardo silenzioso, appena percettibile, si volge verso di te.

Pollux si irrigidisce all'istante, un lampo di panico che attraversa i suoi occhi, sebbene venga rapidamente mascherato di nuovo da quell'espressione addestrata e sottomessa.

Non risponde. Tiene soltanto gli occhi abbassati, ma le sue dita si stringono silenziosamente dentro la manica. Sai che ti ha sentito.]]
  },
  Event_146295_Name = {
    Text = "Un Vecchio Sogno: III"
  },
  Event_146297_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146297_Desc = {
    Text = "Almeno, non avresti potuto restare a guardare mentre veniva esclusa da sola in quel momento. Lascia che i problemi di oggi spettino al sé di oggi."
  },
  Event_146297_Name = {
    Text = "Ingranaggi negli Ingranaggi"
  },
  Event_146298_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146298_Desc = {
    Text = "\"Pollux, dovremmo separarci. Avremo più possibilità di trovare il margine del bosco in quel modo.\n\"\n\"Ma come farai a trovarmi, fratello?\n\"\nAttraverso la nebbia dei ricordi, vedi il suo volto addolorato. Un dolore acuto ti trafigge il cuore. Fai un respiro lento e profondo.\n\n\"Non preoccuparti. Siamo gemelli; possiamo sentire i battiti del cuore l'uno dell'altro.\n\"\n\"Non siamo mai davvero separati.\""
  },
  Event_146298_Name = {
    Text = "Un Vecchio Sogno: I"
  },
  Event_146299_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146299_Desc = {
    Text = "Giudica. Interroga. Consegnerà una fine gelida e silenziosa a tutti coloro che hanno osato sfidarla."
  },
  Event_146299_Name = {
    Text = "Verdetto della Linea Nevosa"
  },
  Event_146300_ChoiceDesc1 = {
    Text = "[Ricominciare] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando, ma sviluppa \"(Skill.Arg2)\""
  },
  Event_146300_ChoiceDesc2 = {
    Text = "[È difficile] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1),\" ma sviluppa \"(Skill.Arg2)\""
  },
  Event_146300_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_146300_Desc = {
    Text = "Il Verme le ha insegnato l'arte della menzogna. Al di là di questo, non ha imparato nulla sulla sopravvivenza.\n\nEppure una bugia rimane sempre una bugia; arriva il giorno in cui l'impalcatura deve scomparire, e bisogna imparare a stare in piedi senza il suo sostegno."
  },
  Event_146300_Name = {
    Text = "Illusione, Non Verità"
  },
  Event_146301_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146301_Desc = {
    Text = "\"Certo. Ma come potrebbe un topo così piccolo conoscere mai il prezzo della sua fame?\""
  },
  Event_146301_Name = {
    Text = "Ratto Ingordo"
  },
  Event_146302_ChoiceDesc1 = {
    Text = "[Annoda il Filo rosso] Elimina 1 Carta di comando, ottieni Arg1 Sigilli neri"
  },
  Event_146302_ChoiceDesc2 = {
    Text = "[Rifiuta il Filo rosso] Copia 1 Carta di comando, ma sviluppa \"(Skill.Arg1)\""
  },
  Event_146302_ChoiceDesc3 = {
    Text = "[Ritorno alla Realtà] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando"
  },
  Event_146302_Desc = {
    Text = "Il primo sogno. La foresta. Tu e tuo fratello, appena dieci anni, siete stati abbandonati nel bosco oscuro e profondo dalla Signora Lanterna.\n\n<Italic:\"Quando cadrà la notte, le bestie addormentate inizieranno a cacciare. Fuggite prima che accada. Solo chi riesce a uscire potrà essere mio figlio prediletto.>\n\nTuo fratello ti afferra la mano e tira fuori un filo rosso.\n\n\"Castor, leghiamoci le mani insieme. Così non ci perderemo.\""
  },
  Event_146302_Name = {
    Text = "Un Vecchio Sogno: I"
  },
  Event_146304_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146304_Desc = {
    Text = "Senti una risata.\n\nGiocosa, beffarda, colma di divertimento.\n\nLa disperata lotta dell'umanità per esplorare il cosmo è, ai loro occhi, nient'altro che il trascinarsi delle formiche."
  },
  Event_146304_Name = {
    Text = "Coloro Sotto lo Sguardo"
  },
  Event_146306_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146306_Desc = {
    Text = "Purifica. Cancella. Raccoglierà nel suo silenzioso abbraccio tutti coloro che scalano e non fanno mai ritorno."
  },
  Event_146306_Name = {
    Text = "Verdetto della Linea Nevosa"
  },
  Event_146307_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146307_Desc = {
    Text = "Tu e il corvo vi fissate a vicenda.\n\nÈ ovvio che non vincerai questo stallo.\n\nMa poi, con Juliette, sembra che non vinca mai."
  },
  Event_146307_Name = {
    Text = "Un Vecchio Sogno: II"
  },
  Event_146308_ChoiceDesc1 = {
    Text = "[Chi mi sta osservando?] Risveglio casuale di 1 Risvegliatore, sviluppa \"(Skill.Arg1)\""
  },
  Event_146308_ChoiceDesc2 = {
    Text = "[Concentrati sul presente] Scegli 1 di 3 Carte di comando da Incidere: \"(EnchantConfig.Arg1)\""
  },
  Event_146308_Desc = {
    Text = "Un vento gelido e carico di neve ulula attraverso questo alto santuario, intatto dalle orme umane.\n\nAlzi lo sguardo. Ancora più in alto, c'è solo il sole eterno e impassibile.\n\nEppure sai che da qualche parte ancora più in alto, ancora più lontano, innumerevoli occhi si aprono e si chiudono.\n\nE alcuni di quegli occhi fissano silenziosamente dall'alto l'intero mondo sotto i tuoi piedi."
  },
  Event_146308_Name = {
    Text = "Coloro Sotto lo Sguardo"
  },
  Event_146309_ChoiceDesc1 = {
    Text = "[Non riesco ancora a lasciar andare] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1),\" ma sviluppa \"(Skill.Arg2)\""
  },
  Event_146309_ChoiceDesc2 = {
    Text = "[Ho dimenticato] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 carta casuale"
  },
  Event_146309_Desc = {
    Text = "Cerchi di sbarrare le camere della memoria. In quel cofanetto segreto giacciono tutte le risposte che ti definiscono — ogni impulso vergognoso, ogni fantasia nascosta. Ma il desiderio è una maledizione inconscia, un'ossessione troppo dolce per resistere."
  },
  Event_146309_Name = {
    Text = "Maledizione Subconscia"
  },
  Event_146310_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146310_Desc = {
    Text = "William evita il tuo sguardo.\n\"La mente è il nostro unico scudo contro l'illusione. Ma una mente è forgiata da una vita intera di esperienze. Non può essere condivisa, e non può essere insegnata.\"\n\n\"L'unica cosa che posso dirti è questa: non lasciare che la tua stessa debolezza ti inghiotta.\""
  },
  Event_146310_Name = {
    Text = "Immersione Delicata"
  },
  Event_146311_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146311_Desc = {
    Text = [[
"Capisco. Sei il tipo che vuole fare il filosofo. Ma non dimenticare: l'assenza di speranza non significa l'assenza di dolore."
La risata del campanello si allontana nell'ombra.]]
  },
  Event_146311_Name = {
    Text = "Riflesso Pavloviano"
  },
  Event_146312_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 50 Sigilli Neri, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_146312_Desc = {
    Text = [[
"Fame, tanta fame."


La montagna piange; la montagna si lamenta. Non riesce a sopportare il vasto e vuoto abisso nel suo ventre.]]
  },
  Event_146312_Name = {
    Text = "Segreto della Montagna"
  },
  Event_146313_ChoiceDesc1 = {
    Text = "[Cerca un appiglio] Elimina 1 Carta di comando, recupera Arg1 Vita"
  },
  Event_146313_ChoiceDesc2 = {
    Text = "[Afferra la corda di sicurezza] Ottieni Reliquia d'oro \"(RelicConfig.Arg1)\", sviluppa \"(Skill.Arg2)\""
  },
  Event_146313_Desc = {
    Text = "Un caleidoscopio di allucinazioni ribolle nella tua mente.\n\nPrima, polvere sciolta. Poi, una cornice che crolla.\n\nNon riesci a fermare la tua scivolata; la corda di sicurezza scintilla accecante contro il suo gancio mentre scivola via. Ma di fronte alle montagne, è così terribilmente piccola, così fragile."
  },
  Event_146313_Name = {
    Text = "Caduta Silenziosa"
  },
  Event_146314_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146314_Desc = {
    Text = "Vieni da me nei tuoi sogni. Lasciami vivere ancora una volta la mia vita.\n\nIl grammofono emette un gemito lamentoso. Poi, il suono del respiro svanisce nell'oscurità. Non rimane nulla tranne l'eco. Solo l'eco."
  },
  Event_146314_Name = {
    Text = "Echi Persistenti"
  },
  Event_146315_ChoiceDesc1 = {
    Text = "[Rimpiangere la Scelta] Ottieni Reliquia d'argento \"(RelicConfig.Arg1)\""
  },
  Event_146315_ChoiceDesc2 = {
    Text = "[Lascia decidere al Fato] Ottieni Reliquia d'oro \"(RelicConfig.Arg1)\", sviluppa \"(Skill.Arg2)\""
  },
  Event_146315_Desc = {
    Text = [[
Hai sempre saputo che questo viaggio non sarebbe stato semplice. La maggior parte degli scalatori di questa spedizione nutre i propri oscuri propositi.

Eppure, guardando il ghigno maniacale e beffardo che si allarga sul volto di Caraboo, senti ancora il crepitio improvviso e acuto di qualcosa che si frantuma nel petto.

Forse, quando Naraka voleva escluderla dal gruppo, avresti dovuto fare una scelta diversa.]]
  },
  Event_146315_Name = {
    Text = "Ingranaggi negli Ingranaggi"
  },
  Event_146316_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146316_Desc = {
    Text = "Quanti sono stati inghiottiti da questo luogo?\n\nMani nere si protendono dalla pozza densa e appiccicosa, cercando di trascinarti nel loro mondo. Ma tu continui semplicemente a camminare. Non fanno nulla per fermarti, scivolando silenziosamente di nuovo nelle profondità.\n\nLa vetta ti aspetta ancora davanti."
  },
  Event_146316_Name = {
    Text = "Echi Persistenti"
  },
  Event_146317_ChoiceDesc1 = {
    Text = "[Guarda altrove] Ottieni 25 Il sigillo nero"
  },
  Event_146317_ChoiceDesc2 = {
    Text = "[Guarda più da vicino] Ottieni Reliquia d'argento \"(RelicConfig.Arg1)\", sviluppa \"(Skill.Arg2)\""
  },
  Event_146317_Desc = {
    Text = "Seguendo lo sguardo di Tintura, non puoi fare a meno di fissare le profondità del lago.\n\nCos'è laggiù che la tiene così incantata?\n\nNon riesci a capirlo. Il ghiaccio è opaco e scuro, e non riflette altro che la tua stessa ombra."
  },
  Event_146317_Name = {
    Text = "Il Riflesso Sommerso"
  },
  Event_146318_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146318_Desc = {
    Text = "L'unico modo per fermare la fame è lasciar andare. Nessuno può perdere ciò che non possiede. Il Wendigo mostra i denti, lasciando sfuggire un ringhio frustrato, e si intrufola di nuovo nella nebbia."
  },
  Event_146318_Name = {
    Text = "Maledizione Subconscia"
  },
  Event_146319_ChoiceDesc1 = {
    Text = "[La neve mi purificherà] Migliora casualmente la qualità dell'Orazione di 1 Carta"
  },
  Event_146319_ChoiceDesc2 = {
    Text = "[La neve mi giudicherà] Scegli 1 di 3 Carte di comando da Incidere: \"(EnchantConfig.Arg1)\", sviluppa \"(Skill.Arg2)\""
  },
  Event_146319_Desc = {
    Text = "Davanti a te si trova l'ascesa finale, dove la fredda e infinita linea della neve si estende in lontananza.\n\nLa neve è di un bianco abbagliante e brillante. Qui, persino la morte sembra pulita."
  },
  Event_146319_Name = {
    Text = "Verdetto della Linea Nevosa"
  },
  Event_146320_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146320_Desc = {
    Text = "Non perdere nessun dettaglio della visione. Imprimili nella tua mente. Imprimici il vuoto improvviso, il dolore sordo, e il dolore acuto che ne seguì. Non lasciarli andare mai, mai più."
  },
  Event_146320_Name = {
    Text = "Dall'Altra Riva"
  },
  Event_146321_ChoiceDesc1 = {
    Text = "[Combattere insieme] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\""
  },
  Event_146321_ChoiceDesc2 = {
    Text = "[Consolarla] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1),\" ma sviluppa \"(Skill.Arg2)\""
  },
  Event_146321_Desc = {
    Text = "La montagna trema, una bestia morente. Carni pallide e segmentate erompono dalla pietra fratturata, avvolgendosi e arrampicandosi, scaraventando Caraboo a terra.\n\nQuando si rialza, solchi umidi segnano le sue guance impolveriate. Sono lacrime di dolore? Non puoi dirlo.\n\nTante menzogne sono uscite dalle sue labbra; chi può fidarsi delle lacrime di un coccodrillo?"
  },
  Event_146321_Name = {
    Text = "Lacrime di Coccodrillo"
  },
  Event_146322_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146322_Desc = {
    Text = "Non fai domande. Ti limiti a prendere posto al suo fianco.\n\"Alzati,\" dici. \"Sei solo a metà del tuo numero. Non mollare adesso.\"\nCaraboo esita, poi si asciuga il viso con una mano brusca e improvvisa. Si rialza barcollando, con le nocche bianche sull'arma, per affrontare la bocca spalancata e cremisi al tuo fianco.\nHa detto così tante bugie che nemmeno lei riesce a distinguere quali lacrime siano acqua e quali siano sale. Ma per ora, nessuno sta tenendo il conto."
  },
  Event_146322_Name = {
    Text = "Lacrime di Coccodrillo"
  },
  Event_146323_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146323_Desc = {
    Text = "\"Capisco. Sei il tipo che si vanta di vedere attraverso le illusioni. Ma non dimenticare: in quel breve momento di realtà, il cibo esisteva solo nella tua memoria e nel tuo desiderio.\"\nLa risata del campanello si allontana nell'ombra."
  },
  Event_146323_Name = {
    Text = "Riflesso Pavloviano"
  },
  Event_146324_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146324_Desc = {
    Text = "Rallenti il passo, ammorbidendo i tuoi passi.\n\nPiano, lentamente, senza fare rumore...\n\nScivolando oltre l'angolo successivo, svanisci.\n\nIl corvo ti ha mai seguito?\n\nNon lo ricordi più."
  },
  Event_146324_Name = {
    Text = "Un Vecchio Sogno: II"
  },
  Event_146325_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146325_Desc = {
    Text = [[
La melodia si interrompe.

Dalla palude nera, un paio di occhi ansiosi e bagnati si aprono per guardarti. Sussurrano parole che non riesci a distinguere, poi lentamente, lentamente si chiudono.]]
  },
  Event_146325_Name = {
    Text = "Echi Persistenti"
  },
  Event_146326_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146326_Desc = {
    Text = "Non ti attardi. Lasciandoti la melodia alle spalle, i tuoi stivali affondano nella neve, producendo un suono più affrettato del vento stesso.\n\nEppure, per quanto veloce tu cammini, quella melodia desolata si aggrappa ostinatamente ai tuoi talloni, senza mai restare indietro.\n\nNon puoi sfuggirle — è il respiro della montagna stessa. E tu sei soltanto un piccolo, fugace ascoltatore che per caso l'ha udita."
  },
  Event_146326_Name = {
    Text = "Fantasia della Natura"
  },
  Event_146327_ChoiceDesc1 = {
    Text = "[Ascoltarla] Scegli 1 di 3 Carte di comando da Incidere: \"(EnchantConfig.Arg1)\", sviluppa \"(Skill.Arg2)\""
  },
  Event_146327_ChoiceDesc2 = {
    Text = "[Non farci caso] Per ogni Risvegliatore con Aliemus pari o superiore a 50, ottieni 15 Sigilli neri"
  },
  Event_146327_ChoiceDesc3 = {
    Text = "[Leave by Force] Ottieni 1 Orazione su 3"
  },
  Event_146327_Desc = {
    Text = "Un canto lontano deriva nel vento.\n\nSembra provenire da ogni direzione, o forse dal profondo della terra.\n\nIn qualunque direzione tu ti volga per seguirlo, riecheggia nelle tue orecchie con la stessa implacabile intensità."
  },
  Event_146327_Name = {
    Text = "Aria del Lago Ghiacciato"
  },
  Event_146328_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146328_Desc = {
    Text = "\"O Stella del Malaugurio, questa non è l'ora del tuo splendore.\"\n\n\"Il mio pellegrinaggio ha mete che non ha ancora raggiunto.\"\n\n\"Spegniti, se non altro per ora, e lascia che la pace torni al cielo di questa notte.\""
  },
  Event_146328_Name = {
    Text = "Presagio di Morte"
  },
  Event_146329_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146329_Desc = {
    Text = "Un'inutile ondata di rimpianto ti travolge. Ma poi, siamo sempre costretti a ripulire i disastri lasciati dal nostro passato."
  },
  Event_146329_Name = {
    Text = "Ingranaggi negli Ingranaggi"
  },
  Event_146330_ChoiceDesc1 = {
    Text = "[Dai un Morso] Risveglio di 1 Risvegliatore casuale, ma sviluppi [(Skill.Arg1)]"
  },
  Event_146330_ChoiceDesc2 = {
    Text = "[Refuse] Incidi 1 Orazione su 3"
  },
  Event_146330_Desc = {
    Text = "Nel profondo della nebbia soffocata dalla neve si accovaccia una figura scheletrica, la pelle secca e screpolata tesa sulle costole sporgenti. In cima alla testa, corna contorte e avvizzite trafiggono la foschia. Un brontolio cavo e famelico echeggia dal suo ventre.\n\nQuando i vostri occhi si incontrano, immagini frammentate vorticano nelle sue orbite infossate — i tuoi ricordi. Ha già colto il profumo; li ha già assaporati.\n\n\"Non basta, non basta mai...\" geme, con un suono rauco e secco. Allunga una mano avvizzita, il suo atteggiamento quasi... implorante."
  },
  Event_146330_Name = {
    Text = "Il Divoratore"
  },
  Event_146332_ChoiceDesc1 = {
    Text = "[Eseguire la sepoltura celeste] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\""
  },
  Event_146332_ChoiceDesc2 = {
    Text = "[Dispel] Ricevi 75 Sigilli neri, ma sviluppi il Sintomo [(Skill.Arg2)]"
  },
  Event_146332_Desc = {
    Text = "In alto sulle correnti termiche ascendenti, gli avvoltoi barbuti volteggiano, pattugliando il loro dominio. Tra coloro che scalano, questo è sempre stato un cattivo presagio.\n\n\"Stanno cercando cibo. Un avvoltoio fiuta l'avvicinarsi della morte.\""
  },
  Event_146332_Name = {
    Text = "Presagio di Morte"
  },
  Event_146333_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146333_Desc = {
    Text = "Fidati delle tue gambe. Conquisterai questa vetta."
  },
  Event_146333_Name = {
    Text = "Toccare la Vetta"
  },
  Event_146334_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146334_Desc = {
    Text = "Nel momento in cui il desiderio divampa, sai di non poterlo combattere. Puoi solo guardare mentre sfonda i tuoi caveau a lungo sigillati. Zanne pallide e affilate affondano nelle tue tempie, strappando via i tuoi ricordi, fotogramma per fotogramma, dalle loro stesse radici."
  },
  Event_146334_Name = {
    Text = "Maledizione Subconscia"
  },
  Event_146335_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146335_Desc = {
    Text = "Si avvicina, il naso quasi a sfiorare la tua fronte, respirandoti con una devozione estatica e inebriata, come se fossi il miele più dolce.\n\nLe tue ansie inquiete e vorticanti vengono leccate via dalla tua mente.\n\nSi ritira con un basso ronzio soddisfatto, una luce selvaggia e seducente che guizza nei suoi occhi cavi. Il tuo petto si sente vuoto ora, un pezzo mancante — eppure, stranamente, ti senti più leggero."
  },
  Event_146335_Name = {
    Text = "Il Divoratore"
  },
  Event_146336_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146336_Desc = {
    Text = "\"Bada a dove metti i piedi. Assicurati che ogni passo sia solido,\" la voce di Naraka risuona nel tuo orecchio. \"Non aspettarti che gli altri ti prendano quando cadi.\""
  },
  Event_146336_Name = {
    Text = "Coloro Sotto lo Sguardo"
  },
  Event_146337_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146337_Desc = {
    Text = "L'umanità appartiene ai cieli. Un vero scopo fa dimenticare il precipizio sotto di sé. Il cielo è aperto, in attesa proprio lassù."
  },
  Event_146337_Name = {
    Text = "Toccare la Vetta"
  },
  Event_146338_ChoiceDesc1 = {
    Text = "[Lasciar andare i Ricordi] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1),\" ma sviluppa \"(Skill.Arg2)\""
  },
  Event_146338_ChoiceDesc2 = {
    Text = "[Aggrapparsi al Dolore] Ottieni 1 di 3 Reliquie d'oro, ma sviluppa \"(Skill.Arg1)\""
  },
  Event_146338_ChoiceDesc3 = {
    Text = "[Leave] Acquisisci la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_146338_Desc = {
    Text = [[
La persona che un tempo ha ucciso William si trova ora davanti a te.

Nell'aria stagnante e nauseabonda della tenda di Aram, i ricordi emergono come fantasmi: la figura esangue e fluttuante di William; il suo viso pallido e rivolto verso l'alto; e sul tavolo, il guscio dissezionato e vuoto di quella piccola lanterna.]]
  },
  Event_146338_Name = {
    Text = "Dall'Altra Riva"
  },
  Event_146339_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146339_Desc = {
    Text = [[
La corda di sicurezza si spezza all'istante sotto il tuo peso.

Cadi pesantemente in un cumulo di neve, ogni organo che urla in una sorda, straziante protesta. Ti costringi ad aprire gli occhi attraverso il dolore vertiginoso, solo per ritrovarti faccia a faccia con uno scheletro senza nome.

In fondo alle sue orbite vuote e cave, qualcosa brilla.]]
  },
  Event_146339_Name = {
    Text = "Caduta Silenziosa"
  },
  Event_146340_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146340_Desc = {
    Text = "Non c'è via d'uscita. Stringi i denti e scatti in avanti, cercando disperatamente di seminare il tuo sorvegliante. Il corvo emette un grido rauco, sbatte le ali e ti segue senza sforzo dall'alto, facendo persino dei giri per prendersi gioco di te. Una fredda disperazione ti penetra nella pelle sotto il suo sguardo.\n\nNon puoi scappare da loro."
  },
  Event_146340_Name = {
    Text = "Un Vecchio Sogno: II"
  },
  Event_146341_ChoiceDesc1 = {
    Text = "[Chi semina raccoglie] Una Carta di comando casuale ottiene Orazione: \"(EnchantConfig.Arg1)\""
  },
  Event_146341_ChoiceDesc2 = {
    Text = "[Parità assoluta] Aumenta la Salute massima di Arg1, sviluppa \"(Skill.Arg2)\""
  },
  Event_146341_Desc = {
    Text = "Appeso alla parete rocciosa a strapiombo, una domanda del tutto irrilevante ti affiora improvvisamente alla mente: Cos'è la giustizia?"
  },
  Event_146341_Name = {
    Text = "Equità Assurda"
  },
  Event_146342_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 50 Sigilli Neri, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_146342_Desc = {
    Text = [[
"Non posso morire! Non ancora!"
La montagna piange; la montagna si lamenta. Nella sua ingordigia insaziabile, ha consumato il proprio domani.]]
  },
  Event_146342_Name = {
    Text = "Segreto della Montagna"
  },
  Event_146343_ChoiceDesc1 = {Text = "[Leave]"},
  Event_146343_Desc = {
    Text = "Ti chini finché la tua guancia tocca il ghiaccio.\n\nUn freddo profondo e pungente penetra attraverso la pelle fino alle ossa, facendoti rabbrividire. Qualcosa di insondabile e lento si muove sotto la superficie ghiacciata. È una corrente, o qualche essere vivente?\n\nIn ogni caso, non ha nulla a che fare con il tuo viaggio."
  },
  Event_146343_Name = {
    Text = "Il Riflesso Sommerso"
  },
  Event_148532_ChoiceDesc1 = {
    Text = "[Ricevi la Benedizione] All'inizio della battaglia, aggiungi 1 \"Frutto Proteiforme\" casuale al tuo mazzo."
  },
  Event_148532_Desc = {
    Text = "La vasta distesa di neve si estende a perdita d'occhio, il vento gelido non porta con sé il minimo suono; un'ombra di origine indefinita emerge silenziosamente, porgendo un frutto tiepido.\nIl dolce profumo misto alla nebbia invade le narici intorpidite dal freddo del viaggiatore.\nQueste terre innevate sono ormai intrise di morte, nell'aria aleggia un odore nauseante di putrefazione e gelo, eppure il frutto nel palmo della mano è succoso e colmo di vita, come la promessa seducente di una fanciulla."
  },
  Event_148532_Name = {
    Text = "Miraggio Celeste"
  },
  Event_20778_ChoiceDesc1 = {
    Text = "[Leave It to Her] Tutti i Risvegliati ottengono Arg1 Aliemus"
  },
  Event_20778_ChoiceDesc2 = {
    Text = "[Require Support] Risveglia 2 Risvegliatori"
  },
  Event_20778_Desc = {
    Text = "\"Questa è una comunicazione da Mythag. Rilevata fluttuazione anomala dell'Indice di Gnosi nel Risvegliato. Necessitate di supporto?\""
  },
  Event_20778_Name = {
    Text = "Comunicazione di supporto"
  },
  Event_20779_ChoiceDesc1 = {Text = "[Leave]"},
  Event_20779_Desc = {
    Text = "\"Il soccorso d'emergenza è stato fornito. Si prega di toccare la spilla tre volte per confermare la ricezione.\""
  },
  Event_20779_Name = {
    Text = "Comunicazione di supporto"
  },
  Event_20780_ChoiceDesc1 = {Text = "[Leave]"},
  Event_20780_Desc = {
    Text = "Un Fantasma da un futuro remoto, occultato nei burroni di Elworth."
  },
  Event_20780_Name = {
    Text = "Fantasma del Vulcano"
  },
  Event_20781_ChoiceDesc1 = {
    Text = "[Gaze at Phantasm] Tutti i Risvegliatori ottengono Arg1 Aliemus"
  },
  Event_20781_ChoiceDesc2 = {
    Text = "[Approach Phantasm] Risveglia 2 Risvegliatori"
  },
  Event_20781_Desc = {
    Text = "In lontananza, sembra che un cono vulcanico sia eruttato, e una colonna di fumo dalla forma umana si leva nel cielo tempestoso.\nMa questa è Elworth, dove esistono solo infinite e svettanti montagne innevate e grotte carsiche calcaree.\nLe continue anomalie ti hanno forse condotto alla Confusione spirituale?"
  },
  Event_20781_Name = {
    Text = "Fantasma del Vulcano"
  },
  Event_20782_ChoiceDesc1 = {Text = "[Leave]"},
  Event_20782_Desc = {
    Text = "Il fantasma ti saluta con un cenno prima di svanire. Non restano che la neve gelida e le montagne imponenti."
  },
  Event_20782_Name = {
    Text = "Fantasma del Vulcano"
  },
  Event_20783_ChoiceDesc1 = {Text = "[Leave]"},
  Event_20783_Desc = {
    Text = "\"Ricevuto. Consegneremo le risorse Base. Si prega di verificare.\""
  },
  Event_20783_Name = {
    Text = "Comunicazione di supporto"
  },
  Event_21398_ChoiceDesc1 = {
    Text = "[Pick up the Photo] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_21398_Desc = {
    Text = "Macchine smantellate, verità svelata.\nLa vita brulicante svanisce nel nulla, lasciandoti con la soddisfazione di aver portato alla luce la verità."
  },
  Event_21398_Name = {
    Text = "Testimonianza Oculare"
  },
  Event_21399_ChoiceDesc1 = {
    Text = "[Pick up the Photo] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_21399_ChoiceDesc2 = {
    Text = "[Check Film] Sviluppa il Sintomo [(Skill.Arg1)] e cambia l'Orazione da incidere.(Utilizzi: 1/2)"
  },
  Event_21399_Desc = {
    Text = "Spinto dalla curiosità, scruti nella Pozza d'Ombra.\nLe immagini sono sommerse nel liquido scarlatto, e il peccatore ricoperto di nera lordura porta un volto identico al tuo."
  },
  Event_21399_Name = {
    Text = "Testimonianza Oculare"
  },
  Event_21400_ChoiceDesc1 = {Text = "[Leave]"},
  Event_21400_Desc = {
    Text = "Macchine smantellate, verità svelata.\nLa vita brulicante svanisce nel nulla, lasciandoti con la soddisfazione di aver portato alla luce la verità."
  },
  Event_21400_Name = {
    Text = "Testimonianza Oculare"
  },
  Event_21811_ChoiceDesc1 = {Text = "[Leave]"},
  Event_21811_Desc = {
    Text = "\n\"Venticinque anni... sì, mi ha fatto dormire per venticinque anni.\"\nLa ragazza ti risponde cupa e a bassa voce.\nAl suo risveglio, coloro che si erano presi cura di lei fin dall'Infanzia sono diventati nel corso degli anni Navigatori a tutti gli effetti.\nNessuno comprende più la sua angoscia, nessuno si cura del suo dolore, lasciandola sola nel culto.\nAvrebbe preferito che il giorno prima del suo sonno fosse stato \"Il Giorno dell'Allineamento Stellare\"."
  },
  Event_21811_Name = {
    Text = "Vita Imprigionata"
  },
  Event_22058_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22058_Desc = {
    Text = [[

"No, non ho fame."
Hai cortesemente declinato il caloroso invito al banchetto.
Non saresti mai disposto a ipotecare la tua anima per quello]]
  },
  Event_22058_Name = {
    Text = "Banchetto di Carne"
  },
  Event_22059_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22059_Desc = {
    Text = [[
Mordi avidamente lo scone sanguinante, l'aroma di un cuore pepato cotto nell'impasto riempie i tuoi sensi di un profumo familiare.
"Ottenere potere ha un prezzo."
Bevi l'ultima goccia di sangue.]]
  },
  Event_22059_Name = {
    Text = "Banchetto di Carne"
  },
  Event_22060_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22060_Desc = {
    Text = "Ingurgitasti il brodo e la carne, asciugandoti i resti con la manica.\nLa carne era tenera, il brodo saporito, ma a chi apparteneva un tempo?\nEra solo la punta dell'iceberg di ciò che avevi perduto."
  },
  Event_22060_Name = {
    Text = "Banchetto di Carne"
  },
  Event_22061_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22061_Desc = {
    Text = [[
Esamini con attenzione le antiche Orazioni incise sul carillon a vento.
Sono distorte in modo inimmaginabile, apparentemente concepite per restare incomprensibili.
Se non comprese, allora indisturbate.]]
  },
  Event_22061_Name = {
    Text = "Carillon arrugginito"
  },
  Event_22062_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22062_Desc = {
    Text = "\"Niente male, sei molto cauto.\"\nAll'improvviso, una Voce Lontana giunse dai campanelli a vento.\n\"La cautela ti porterà una piccola ricompensa, ma nulla di più.\""
  },
  Event_22062_Name = {
    Text = "Carillon arrugginito"
  },
  Event_22063_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22063_Desc = {
    Text = [[
Tocchi l'antica Orazione incisa sul carillon a vento.
Si contorcono in modi che trascendono la comprensione umana, rifiutando di essere capite.
Essere fraintese significa restare indisturbate.]]
  },
  Event_22063_Name = {
    Text = "Carillon arrugginito"
  },
  Event_22064_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22064_Desc = {
    Text = "\"Ah, che peccato... Suppongo che continuerò la mia esibizione solitaria.\" Non sai quando la cetra e le mani siano scomparse, ma la melodia, come acqua che scorre, resta nel tuo cuore per sempre."
  },
  Event_22064_Name = {
    Text = "Fantasma dell'arpa"
  },
  Event_22065_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22065_Desc = {
    Text = "\"Ah, che onore avere un amico così!\" Quelle mani si fecero frenetiche, e non riuscivi a stare al passo con la loro velocità. Anche molto tempo dopo la fine dell'esibizione, quel suono esaltante continuava a scuoterti il cuore."
  },
  Event_22065_Name = {
    Text = "Fantasma dell'arpa"
  },
  Event_22175_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22175_Desc = {
    Text = [[
La planchette si muove con sicurezza, il tuo sguardo ne segue ogni movimento.
Tuttavia, riesce a indicare appena due lettere prima di dissolversi in una poltiglia nera e viscosa con un grido pietoso.]]
  },
  Event_22175_Name = {
    Text = "Tavola Spiritica"
  },
  Event_22176_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22176_Desc = {
    Text = "\n\"Matematica! Matematica!!\"\nLa donna digrignò i denti, la tavola oracolare scivolava rapida tra i numeri, producendo un aspro suono di frizione lignea.\n\"Togli la tua matematica dalla mia vista!\""
  },
  Event_22176_Name = {
    Text = "Tavola Spiritica"
  },
  Event_22177_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22177_Desc = {
    Text = "\"Aspetta, aspetta!!\"\n\"Chiedi a me! Perché non chiedi!\""
  },
  Event_22177_Name = {
    Text = "Tavola Spiritica"
  },
  Event_22178_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22178_Desc = {
    Text = "Non ha mai pulsato con tanta intensità come in questo istante, eppure, al contrario, il vuoto nel mio cuore si sta lacerando..."
  },
  Event_22178_Name = {
    Text = "Brama Maledetta"
  },
  Event_22179_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22179_Desc = {
    Text = [[
L'anima e lo spirito colmano i tuoi polmoni, e tu fluttui verso l'alto in silenzio.
I suoni del mondo emergono gradualmente, componendo la sinfonia della vita.]]
  },
  Event_22179_Name = {
    Text = "Acque del Lete"
  },
  Event_22180_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22180_Desc = {
    Text = "Come sempre, la Distruzione giunge puntuale. Oggetti preziosi giacciono sepolti tra i resti non arsi, brillando splendidamente nell'Ombra."
  },
  Event_22180_Name = {
    Text = "Oltre la cruna"
  },
  Event_22181_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22181_Desc = {
    Text = "Incontro, separazione e passaggio."
  },
  Event_22181_Name = {
    Text = "Armonie Astrali"
  },
  Event_22182_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22182_Desc = {
    Text = "Il cuore rallenta gradualmente, ma forse la \"coscienza\" ha trovato un po' di conforto..."
  },
  Event_22182_Name = {
    Text = "Brama Maledetta"
  },
  Event_22183_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22183_Desc = {
    Text = "Chiudesti gli occhi, assaporando quel raro istante di Illusione e libertà. A poco a poco, sentisti il mondo emergere dal Silenzio, la vita sbocciare in quiete."
  },
  Event_22183_Name = {
    Text = "Acque del Lete"
  },
  Event_22184_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22184_Desc = {
    Text = "Fermi l'ago, schegge d'Argento che lampeggiano mentre incidono il tuo palmo morbido. La Distruzione non è ancora giunta, ma l'Ombra sotto i tuoi piedi viene Divorata da un'Oscurità d'inchiostro."
  },
  Event_22184_Name = {
    Text = "Oltre la cruna"
  },
  Event_22185_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22185_Desc = {
    Text = "\n\"Non puoi fuggire; nessuno può resistere al male interiore.\"\nPensieri malevoli lacerano i tuoi nervi, tentando di trascinarti nell'abisso. Ma il dolore dona alla tua mente una lucidità senza precedenti.\nIl male non può possederti; rimarrai te stesso."
  },
  Event_22185_Name = {
    Text = "Pensiero Inatteso"
  },
  Event_22186_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22186_Desc = {
    Text = "\"Perché no?\"\nUna volta che abbracci quei pensieri terrificanti, tutte le difficoltà si risolveranno con facilità, e il mondo non avrà più un Paradosso chiamato 'etica'.\""
  },
  Event_22186_Name = {
    Text = "Pensiero Inatteso"
  },
  Event_22187_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22187_Desc = {
    Text = "Una luce argentea balenò davanti ai miei occhi, e un vento sordo spazzò via ogni suono."
  },
  Event_22187_Name = {
    Text = "Pensiero Inatteso"
  },
  Event_22188_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22188_Desc = {
    Text = "Volubile, freddo e distante."
  },
  Event_22188_Name = {
    Text = "Armonie Astrali"
  },
  Event_22189_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22189_Desc = {
    Text = "Espansione, contrazione, sull'orlo del baratro."
  },
  Event_22189_Name = {
    Text = "Armonie Astrali"
  },
  Event_22190_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22190_Desc = {
    Text = "Perché non essere un po' spericolati?\nAbbattere ogni barriera e lanciarsi verso il traguardo.\nAnche se sollevi una tempesta nel lago dei pensieri, anche se diventi Icaro in caccia del sole, almeno avrai raggiunto il tuo obiettivo, no?"
  },
  Event_22190_Name = {
    Text = "Labirinto mentale"
  },
  Event_22191_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22191_Desc = {
    Text = "Il tuo cervello è un labirinto, e tu sei la sua Arianna.\nIn questo universo, nessuno conosce il labirinto meglio di te.\nNessuno."
  },
  Event_22191_Name = {
    Text = "Labirinto mentale"
  },
  Event_22192_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22192_Desc = {
    Text = "Con la giusta accordatura, gli intervalli dissonanti si sono ammorbiditi un poco.\nMa forse c'è ancora qualcosa che puoi fare."
  },
  Event_22192_Name = {Text = "Dissonanza"},
  Event_22193_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22193_Desc = {
    Text = [[
Sei al contempo un maestro della musica e un comune stonato.
Sotto la tua guida, le note adempiono al loro ruolo, e la vita finalmente risuona nel Dominio.]]
  },
  Event_22193_Name = {Text = "Dissonanza"},
  Event_22194_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22194_Desc = {
    Text = "La tua voce viene divorata dal silenzio. Il silenzio si fa sempre più forte e intenso, finché non si frantuma, lasciando dietro di sé solo frammenti residui."
  },
  Event_22194_Name = {
    Text = "Acque del Lete"
  },
  Event_22195_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22195_Desc = {
    Text = "Non ci sei cascato. Ti sei voltato con decisione e te ne sei andato."
  },
  Event_22195_Name = {
    Text = "Fessura Strisciante"
  },
  Event_22293_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22293_Desc = {
    Text = "Nel momento in cui afferri la penna, la lettera arde nel Dominio, le ceneri cadono nella mano.\nQuando torni in te, qualcosa è svanito insieme alla lettera."
  },
  Event_22293_Name = {Text = "Monologo"},
  Event_22294_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22294_Desc = {
    Text = "Mentre la lettera si dissolve nel Dominio, odi un'espressione di premura gentile ma debole.\n\"In una simile situazione, ricordarsi di me è un onore in quanto tuo maestro.\nTuttavia, è passato fin troppo tempo dall'ultima volta che ho percorso il Dominio. Ora, posso assisterti solo in questa misura...\""
  },
  Event_22294_Name = {Text = "Monologo"},
  Event_22295_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22295_Desc = {
    Text = "Quando la lettera si disintegrò nel Dominio, udisti un'esclamazione urgente.\n\"Custode, se c'è qualcosa che non va, per favore non esiti a farmelo sapere.\nIn qualità di suo partner, non risparmierò alcuno sforzo per assisterla.\""
  },
  Event_22295_Name = {Text = "Monologo"},
  Event_22296_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22296_Desc = {
    Text = "Mentre la lettera si dissolve nel Dominio, odi un freddo sospiro.\n\"Se solo fossi così sollecito nel chiedere aiuto quando non superi gli esami.\""
  },
  Event_22296_Name = {Text = "Monologo"},
  Event_22397_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22397_Desc = {
    Text = "Il tuo Avvento lasciò le ombre disorientate. Un raggio di luce stellare sfiorò le punte dei tuoi piedi, e La Folla si disperse all'improvviso, lasciando solo l'ombra più densa nella tua mano."
  },
  Event_22397_Name = {
    Text = "Voto Stellare"
  },
  Event_22398_ChoiceDesc1 = {Text = "[Leave]"},
  Event_22398_Desc = {
    Text = "I sussurri rumorosi si interrompono bruscamente. Ombre scure come inchiostro si voltano verso di te, fissandoti. Dai loro volti privi di lineamenti, percepisci un accenno di scherno..."
  },
  Event_22398_Name = {
    Text = "Voto Stellare"
  },
  Event_22399_ChoiceDesc1 = {
    Text = "[Osservare con calma] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_22399_ChoiceDesc2 = {
    Text = "[Ask Aloud] Ricevi 25 Sigilli Neri"
  },
  Event_22399_Desc = {
    Text = "Nell'intrecciarsi di stelle e luna, i sussurri sono incessanti.\n\"È questo? La persona di @4...\"\n\"Corpo umano, in fin dei conti pur sempre @3...\""
  },
  Event_22399_Name = {
    Text = "Voto Stellare"
  },
  Event_22411_ChoiceDesc1 = {
    Text = "[Mission Accomplished]"
  },
  Event_22411_Desc = {
    Text = "Trappole economiche ma efficaci!"
  },
  Event_22411_Name = {
    Text = "Fabbricazione di Trappole"
  },
  Event_24254_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24254_Desc = {
    Text = "La tempesta della Gnosi circonda Tulu. Scambi uno sguardo con lui e vi addentrate nell'Oscurità uno dopo l'altro."
  },
  Event_24254_Name = {Text = "Dal mare"},
  Event_24255_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24255_Desc = {
    Text = "La tempesta della Gnosi avvolge Tulu, mentre il pianto imperituro e il senso di colpa si propagano nello spazio."
  },
  Event_24255_Name = {
    Text = "Affrontare l'Abisso"
  },
  Event_24256_ChoiceDesc1 = {
    Text = "[Hold the Tentacle] Accetta l'aiuto di Tulu"
  },
  Event_24256_Desc = {
    Text = "La sua maestosa presenza riverbera attraverso il Dominio come un oggetto colossale che sprofonda nel mare.\nIl potere è antico, senza tempo, trascende ogni era.\nPer fortuna, non sei il suo nemico, almeno per ora."
  },
  Event_24256_Name = {Text = "Dal mare"},
  Event_24257_ChoiceDesc1 = {
    Text = "[Hold the Tentacle] Vai con Tulu"
  },
  Event_24257_Desc = {
    Text = [[
Tulu inspira profondamente e volge lo sguardo in lontananza verso Miryam.
Come se stesse rievocando la storia, i vecchi amici, la propria vita...
L'espressione complessa sul suo volto indugia solo un istante, prima che distolga lo sguardo da Miryam.
"Andiamo, lasciala."]]
  },
  Event_24257_Name = {
    Text = "Affrontare l'Abisso"
  },
  Event_24277_ChoiceDesc1 = {
    Text = "[Close the Hatch]"
  },
  Event_24277_Desc = {
    Text = "Ramona afferrò lo studente che era piombato dentro dall'esterno.\nQuel Custode impavido e forte, pur apparendo in disordine, sembrava sfocato attraverso i suoi occhi azzurri dietro le lenti.\nFu solo nell'istante in cui strinse quella mano che Ramona ebbe la conferma: vi siete riuniti."
  },
  Event_24277_Name = {
    Text = "Ricongiungimento Gioioso"
  },
  Event_24278_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24278_Desc = {
    Text = "Ramona non ti diede la possibilità di spiegarti. Ti trascinò nella cabina in penombra e chiuse con cura la porta..."
  },
  Event_24278_Name = {
    Text = "Ricongiungimento Gioioso"
  },
  Event_24540_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24540_Desc = {
    Text = "\"Lei è il tuo scudo saldo, la spada nella tua mano.\nLei è la tua compagna, la tua alleata, la tua amica fidata—non importa come cambi.\""
  },
  Event_24540_Name = {
    Text = "Estraneo Eppure Familiare"
  },
  Event_24541_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24541_Desc = {
    Text = "\n\"Sei tu... No, non può essere. Questa reincarnazione di te è già... E anch'io, ormai, ho già...\"\nLa voce svanì insieme alla figura, lasciando solo tristezza a indugiare nella nebbia."
  },
  Event_24541_Name = {
    Text = "Figura Familiare Eppure Sconosciuta"
  },
  Event_24542_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24542_Desc = {
    Text = "\"Per il mondo, per l'umanità, per tutto ciò che ci è caro.\nNaturalmente, la cosa più importante è—lei è per te.\""
  },
  Event_24542_Name = {
    Text = "Estraneo Eppure Familiare"
  },
  Event_24543_ChoiceDesc1 = {Text = "[Leave]"},
  Event_24543_Desc = {
    Text = [[
Non ti sei nemmeno avvicinato quando ti nota. Si immobilizza, come sotto shock, poi sembra sopraffatto da un dolore profondo.
Prima che tu possa pronunciare una parola, svanisce insieme alla nebbia.]]
  },
  Event_24543_Name = {
    Text = "Figura Familiare Eppure Sconosciuta"
  },
  Event_24544_ChoiceDesc1 = {
    Text = "[Who is She?] Duplica 1 Carta di comando su 3"
  },
  Event_24544_ChoiceDesc2 = {
    Text = "[Perché Lei è diventata così?] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_24544_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_24544_Desc = {
    Text = "Un'altra nebbia, un'altra sagoma. A differenza di prima, questa volta riesci a vedere chiaramente l'avversario.\nUna figura identica alla tua, in un'uniforme identica alla tua, con un volto identico al tuo.\n\"Sai perché sei qui,\" disse quella persona, \"così come sai perché lei è diventata così.\""
  },
  Event_24544_Name = {
    Text = "Estraneo Eppure Familiare"
  },
  Event_24545_ChoiceDesc1 = {
    Text = "[Console] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_24545_ChoiceDesc2 = {
    Text = "[Approach] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_24545_ChoiceDesc3 = {
    Text = "[Turn and Leave] Ricevi 25 Sigilli Neri"
  },
  Event_24545_Desc = {
    Text = "La nebbia avvolge il tuo cammino.\nUna figura emerge dalle ombre indistinte; socchiudi gli occhi ma non riesci a scorgerne il volto, odi solo sussurri intermittenti.\n\"Perché... perché non riesco a salvare... Il destino è davvero immutabile...\""
  },
  Event_24545_Name = {
    Text = "Figura Familiare Eppure Sconosciuta"
  },
  Event_35039_ChoiceDesc1 = {
    Text = "[Chiedere aiuto al socio] Ottieni un'Orazione avanzata con scelta 3 in 1"
  },
  Event_35039_ChoiceDesc2 = {
    Text = "[Manage the set] Ottieni la Reliquia d'Oro [(RelicConfig.Arg1)]"
  },
  Event_35039_ChoiceDesc3 = {
    Text = "[Phenomenal Frenzy] Ottieni la Reliquia [(RelicConfig.Arg1)]"
  },
  Event_35039_Desc = {
    Text = "\"Nel 'Guida alla Regia della Maestra Houdini', è chiaramente stabilito che Casiah, ovvero io, in qualità di produttore e regista, ha il dovere e il potere di supervisionare l'intero film. Pertanto, coraggiosi dipendenti di Casiah, scegliete il vostro prossimo programma d'azione!\"\n\"Programma? Un momento, quando sarei diventato un tuo dipendente?!\"\n\"L'occasione bussa una volta sola, non esitate!\""
  },
  Event_35039_Name = {
    Text = "Il Mito del Produttore"
  },
  Event_35103_ChoiceDesc1 = {
    Text = "[Connect] Recupera Arg2 HP. [ExDesc1] [ExDesc2]"
  },
  Event_35103_ChoiceDesc2 = {
    Text = "[Meditate] Risveglia un Risvegliato."
  },
  Event_35103_ChoiceDesc3 = {
    Text = "[Expel] Distruggi fino a 3 Carte sintomo e ottieni Arg2 Sigilli Neri."
  },
  Event_35103_Desc = {
    Text = "La nebbia si aggrappa densa mentre il tuo distintivo emette un pallido bagliore argenteo. Il comunicatore crepita, prendendo vita. Qualcuno sta chiamando."
  },
  Event_35103_Name = {Text = "Crocevia"},
  Event_35103_Tips3 = {
    Text = "Al momento non manifesti alcun Sintomo."
  },
  Event_35165_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35165_Desc = {
    Text = "Nel tuo momento di esitazione, hai preso l'iniziativa di contattare il misterioso benefattore.\n\"A questo punto, non si può più tornare indietro. Vi prego, Nobile, siate generoso...\"\nUna risata cordiale riecheggiò dall'altro lato del comunicatore d'Argento, e alla fine acconsentirono alla tua richiesta con un sorriso.\n\"A proposito, assicurati di nasconderlo a Ramona.\""
  },
  Event_35165_Name = {
    Text = "Il Mito del Produttore"
  },
  Event_35236_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35236_Desc = {
    Text = [[
Cosa fa un coordinatore di produzione? Hai tirato fuori una pila di documenti che Casiah aveva inconsapevolmente infilato nel Trasferimento di gnosi e hai cominciato a esaminarli con attenzione.
Poi, hai iniziato ad avere mal di testa.
Le spese sostenute da Lotan durante l'allestimento del set, gli snack consumati da Aurita e Brown, la richiesta di rimborso per le sfere magiche acquistate da Casiah... Ogni insediamento era disposto davanti a te, costringendoti a rannicchiarti dolorosamente a terra per i calcoli.
A proposito, cosa sono le sfere magiche di Casiah?]]
  },
  Event_35236_Name = {
    Text = "Il Mito del Produttore"
  },
  Event_35259_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Sviluppi il Sintomo [ExDesc1][ExDesc2]."
  },
  Event_35259_ChoiceDesc2 = {Text = "[Leave]"},
  Event_35259_Desc = {
    Text = "Volti sfocati appaiono all'improvviso, circondandoti e gemendo disperatamente con corde vocali inesistenti."
  },
  Event_35259_Name = {Text = "Illusione"},
  Event_35497_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35497_Desc = {
    Text = "Dietro il fenomeno del fanatismo estremo, serve un intermediario, e ogni volta che si menziona \"intermediario\", viene in mente una ragazza dai capelli verdi.\n\"Prima mediatrice dell'Università di Mythag, Hannah Peaslee al vostro servizio!\"\n\"Se questa è la prima richiesta di servizio del Custode, dovrete pagare soltanto il costo di tre pasti al curry della mensa!\""
  },
  Event_35497_Name = {
    Text = "Il Mito del Produttore"
  },
  Event_35887_ChoiceDesc1 = {
    Text = "[Move Forward]"
  },
  Event_35887_Desc = {
    Text = "Alzi la vela, solo per scoprire che sotto non c'è nulla. Quando torni in te, la vela è già svanita.\nLa vela bianca come la neve e il tenue volto di una ragazza formano un messaggio, ricordandoti che qualunque sia il viaggio che ti attende, non sei solo."
  },
  Event_35887_Name = {
    Text = "Vele Pallide"
  },
  Event_35888_ChoiceDesc1 = {
    Text = "[Raise the Sail]"
  },
  Event_35888_Desc = {
    Text = "Qui non c'è vento, eppure una candida barca a vela si erge con la sua vela fieramente spiegata, ancorata sul tranquillo mare blu.\nIntravedi vagamente il volto di una giovane ragazza, i suoi lineamenti sfocati, come osservati attraverso una sottile foschia o una superficie d'acqua increspata. La sua presenza sembra isolata da tutto ciò che la circonda, eppure resta il punto focale di questa scena.\nSebbene la sua immagine alterni chiarezza e oscurità, non vi è alcun dubbio—sai chi è."
  },
  Event_35888_Name = {
    Text = "Vele Pallide"
  },
  Event_35894_ChoiceDesc1 = {
    Text = "[Fall Downwards] Ricevi 35 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_35894_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_35894_Desc = {
    Text = "La voce della ragazza si dissipa nell'aria, vaga e lontana come una bolla."
  },
  Event_35894_Name = {
    Text = "Soglia della Morte"
  },
  Event_35895_ChoiceDesc1 = {
    Text = "[Cycle Again] Ricevi 30 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_35895_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_35895_Desc = {
    Text = "Gli arti si fanno straordinariamente pesanti, lo smog avvolge stretto il corpo fragile."
  },
  Event_35895_Name = {
    Text = "Soglia della Morte"
  },
  Event_35896_ChoiceDesc1 = {
    Text = "[Leggere il Sentiero dei predecessori] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_35896_ChoiceDesc2 = {
    Text = "[Write Your Own Path] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_35896_ChoiceDesc3 = {
    Text = "[Stare into Darkness] Ricevi 25 Sigilli Neri"
  },
  Event_35896_Desc = {
    Text = "Se stessi esplorando il Dominio da solo, non saresti così sicuro del tuo cammino come lo sei ora.\nLe impronte nel Dominio si sono divise in tre sentieri; ogni passo scrive un futuro invisibile."
  },
  Event_35896_Name = {
    Text = "La Via d'Uscita"
  },
  Event_35897_ChoiceDesc1 = {
    Text = "[Support Her]"
  },
  Event_35897_ChoiceDesc2 = {
    Text = "[Look at her]"
  },
  Event_35897_Desc = {
    Text = "Mormora, fermando la sua rotazione davanti a te.\nQualcuno ha turbato il suo dormiveglia; la sua coscienza è ancorata alla realtà, mentre la sua anima dimora in un reame dimenticato."
  },
  Event_35897_Name = {
    Text = "Fantasma perduto"
  },
  Event_35898_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35898_Desc = {
    Text = "In questa oscurità indifferenziata, una serie di impronte sfocate si estende, come quelle lasciate da un viandante notturno in un deserto invisibile."
  },
  Event_35898_Name = {
    Text = "La Via d'Uscita"
  },
  Event_35899_ChoiceDesc1 = {
    Text = "[Andarsene] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_35899_Desc = {
    Text = "Riflesso nei tuoi occhi vi è un faro lontano, solitario al limitare dell'oscurità, che emette una luce flebile eppure tenace, come una guida nel mare notturno, che richiama le anime perdute verso la quiete della riva.\nNon puoi fare a meno di seguirlo, ma all'improvviso il terreno sotto di te non è più solido.\nAvanzi in una zona acquitrinosa celata. La superficie dell'acqua è liscia come seta, e divora silenziosamente i tuoi passi."
  },
  Event_35899_Name = {
    Text = "Battito di ciglia"
  },
  Event_35900_ChoiceDesc1 = {
    Text = "[Listen to Her]"
  },
  Event_35900_ChoiceDesc2 = {
    Text = "[Ignore Her]"
  },
  Event_35900_Desc = {
    Text = "Vedi la fonte della luce—è un personaggio dalla figura femminile.\nUn flusso di radiosità si riversa dalla sua testa aliena, tracciando un sentiero verso l'ignoto.\n\"Ritorno... a Lemu@2a...\""
  },
  Event_35900_Name = {
    Text = "Luce Eterna"
  },
  Event_35901_ChoiceDesc1 = {
    Text = "[Approach the Lighthouse]"
  },
  Event_35901_ChoiceDesc2 = {
    Text = "[Stay away from the Lighthouse]"
  },
  Event_35901_Desc = {
    Text = "Svoltando l'angolo dove realtà e sogno si intrecciano, un terrificante paesaggio di tempesta si dispiega davanti ai tuoi occhi in un istante fugace. Come sollevato da un'invisibile mano gigantesca, il vento ruggisce come una bestia feroce, trascinando con sé polvere e speranza. Il cielo è greve e opprimente.\n\nNel cuore della tempesta si erge un faro che non dovrebbe esistere, apparendo al contempo come un frutto dell'immaginazione e una reliquia di antiche leggende. Emette una luce fioca, solitaria e tenace, sul palcoscenico della furia tempestosa."
  },
  Event_35901_Name = {
    Text = "Occhio della Tempesta"
  },
  Event_35902_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_35902_Desc = {
    Text = "\"Nel Dominio, luci eterne, fantasmi con tentacoli...\"\nTulu chiude gli occhi, riflette per un istante, poi lascia sfuggire un profondo sospiro.\n\"Il Guardiano di Lemuria... uno dei miei servitori. Alla fine non può sfuggire ai vincoli delle sue ossessioni.\""
  },
  Event_35902_Name = {
    Text = "L'Affondamento della Sona-Nyl"
  },
  Event_35903_ChoiceDesc1 = {
    Text = "[Touch the Silver Light] Ricevi 25 Sigilli Neri"
  },
  Event_35903_ChoiceDesc2 = {
    Text = "[Talk to Silverlight] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_35903_Desc = {
    Text = "Il comunicatore ermeticamente sigillato fu forzato, lasciando filtrare una luce fioca — probabilmente la prima conversazione tra Silver e il mondo esterno da quando fu rinchiusa"
  },
  Event_35903_Name = {
    Text = "Monumento di mithril"
  },
  Event_35904_ChoiceDesc1 = {
    Text = "[Leave] Acquisisci la Reliquia [(RelicConfig.Arg1)]"
  },
  Event_35904_Desc = {
    Text = "\"Una donna con la testa luminosa?\" Elton mostra un'espressione di stupore. Chiaramente, ha sentito parlare della figura avvistata di tanto in tanto nel dominio della nave cargo—è solo che—\n\"La notte in cui il Sona-Nyl affondò... la notte stessa in cui Risvegliai Celeste, vidi un'ombra simile nella tempesta.\"\n\"Sì, ne sono certo.\""
  },
  Event_35904_Name = {
    Text = "L'Affondamento della Sona-Nyl"
  },
  Event_35905_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35905_Desc = {
    Text = "Il dominio che si apre davanti è irto di pericoli, insondabilmente profondo.\nI tuoi occhi sono fissi sul caos invisibile, ma prima che possa divorarti, Ramona, dopo aver affrontato gli inseguitori, ti afferra e ti trascina in un'altra direzione."
  },
  Event_35905_Name = {
    Text = "La Via d'Uscita"
  },
  Event_35906_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35906_Desc = {
    Text = "È questo il frutto della tua anima misteriosa? Tutto ciò che stai vivendo è una collisione tra l'io e il super-io?\nPiù ci pensi, più il rumore nella tua testa si fa nitido. La tua Visuale trafigge una nebbia, ma un istante prima che tu possa scorgere la figura al suo interno, l'anima ti respinge."
  },
  Event_35906_Name = {
    Text = "Destino Invertito"
  },
  Event_35907_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35907_Desc = {
    Text = "Essa ribolle dentro, trasformandosi in potere impavido, sostenendoti nel squarciare la nebbia e lacerare la paura."
  },
  Event_35907_Name = {
    Text = "Cacciatrice di Luce"
  },
  Event_35908_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35908_Desc = {
    Text = "Quando la mente si concentra e il caos interiore si placa, le illusioni caotiche iniziano a dissolversi lentamente, ritirandosi come la marea.\nAlla fine, il rumore nel cervello svanisce senza lasciare traccia—ma quanto ti mancherà? Resta ignoto."
  },
  Event_35908_Name = {
    Text = "Premonizione del Futuro"
  },
  Event_35909_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35909_Desc = {
    Text = "La tua anima è completamente perduta nell'acufene, cerca disperatamente di liberarsi e decifrare il dolore, eppure puoi solo indugiare sul confine della coscienza..."
  },
  Event_35909_Name = {
    Text = "Soglia della Morte"
  },
  Event_35910_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 1 di 3 Reliquie dorate, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_35910_Desc = {
    Text = "Puoi sentire ogni raggio di luce del faro, ardente e guizzante nella tempesta come un richiamo dal profondo dell'anima, che non abbandona mai la sua missione di guidare il cammino verso casa nemmeno nel terrore più intenso."
  },
  Event_35910_Name = {
    Text = "Occhio della Tempesta"
  },
  Event_35911_ChoiceDesc1 = {
    Text = "[Leave] Incidi 1 Orazione Av. su 3"
  },
  Event_35911_Desc = {
    Text = "È un simbolo di speranza, o un presagio di distruzione?\nNon lo guardi più, come se la sua esistenza fosse soltanto un'illusione meticolosamente costruita."
  },
  Event_35911_Name = {
    Text = "Occhio della Tempesta"
  },
  Event_35912_ChoiceDesc1 = {
    Text = "[Sink into Oblivion] Ricevi 20 Sigilli Neri, ma sviluppa [(Skill.Arg2)]"
  },
  Event_35912_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_35912_Desc = {
    Text = "Poi, un insolito velo grigio copre i tuoi occhi. Qualche istante dopo, ti rendi conto che è la tua palpebra superiore semitrasparente."
  },
  Event_35912_Name = {
    Text = "Soglia della Morte"
  },
  Event_35913_ChoiceDesc1 = {
    Text = "[Leave] Risveglia un Risvegliatore casuale, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_35913_Desc = {
    Text = [[
Avverti una Risonanza indescrivibile.
Ma la logica ti dice: ignorala.]]
  },
  Event_35913_Name = {
    Text = "Luce Eterna"
  },
  Event_35914_ChoiceDesc1 = {
    Text = "[Andarsene] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_35914_Desc = {
    Text = "Le sue parole non sono mai state incise su alcuna stele conosciuta, eppure si solidificano nell'aria come il più profondo rimorso e richiamo. Sembrano giungere da un altro tempo, attraversando la Sedimentazione degli anni, portando con sé una profonda nostalgia per una lontana Terra dei Bianchi Uccelli."
  },
  Event_35914_Name = {
    Text = "Luce Eterna"
  },
  Event_35915_ChoiceDesc1 = {
    Text = "[Hold Her Hand] Potenzia una Reliquia d'Argento casuale nella Reliquia d'Oro [(RelicConfig.Arg1)]"
  },
  Event_35915_ChoiceDesc2 = {
    Text = "[Express Concern] Ottieni la Reliquia d'Argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_35915_ChoiceDesc3 = {
    Text = "[Gaze at Her] Ricevi 25 Sigilli Neri"
  },
  Event_35915_Desc = {
    Text = "Murphy è in fondo al gruppo, cammina fianco a fianco con Celeste.\nNon puoi fare a meno di voltarti spesso a guardarla, ma Murphy tiene gli occhi fissi sulle sue scarpe, nascondendo la sua espressione nel segreto."
  },
  Event_35915_Name = {
    Text = "Gestione del Dolore"
  },
  Event_35915_Tips1 = {
    Text = "Reliquia d'argento non ancora acquisita"
  },
  Event_35916_ChoiceDesc1 = {
    Text = "[No Way Out] Ricevi 40 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_35916_ChoiceDesc2 = {
    Text = "[Embrace Reality] Ricevi 25 Sigilli Neri e vattene."
  },
  Event_35916_Desc = {
    Text = [[
@1@1 si rianima, un'anima che attraversa il confine di @2, senza tuttavia abbracciare pienamente la carne.
Le parole preoccupate di Murphy svaniscono dalla tua coscienza, come i lamenti dei corvi, indugianti all'orecchio ma sempre bloccate dalle barriere della mente.]]
  },
  Event_35916_Name = {
    Text = "Soglia della Morte"
  },
  Event_35917_ChoiceDesc1 = {
    Text = "[Leave] Duplica una Carta di comando, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_35917_Desc = {
    Text = "Non è che un fantasma che indugia nella realtà, un Frammento antico che non può essere toccato eppure rifiuta di essere dimenticato."
  },
  Event_35917_Name = {
    Text = "Fantasma perduto"
  },
  Event_35918_ChoiceDesc1 = {
    Text = "[Leave] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_35918_Desc = {
    Text = "In quell'istante, odi un debole frantumarsi nel profondo della tua anima. Come fumo che si dissipa, la sua immagine si offusca e diviene meno reale.\nLei non è davvero lì; è soltanto una proiezione della memoria del Capitano Elton.\nTuttavia, il persistente senso di perdita e confusione è autentico."
  },
  Event_35918_Name = {
    Text = "Fantasma perduto"
  },
  Event_35919_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35919_Desc = {
    Text = "Nell'istante in cui le punte delle dita entrano in contatto, un'onda di sensazioni complesse ti travolge: al contempo rovente e gelida.\nLe anime dimenticate dal mondo urlano, cercando l'eternità."
  },
  Event_35919_Name = {
    Text = "Monumento di mithril"
  },
  Event_35920_ChoiceDesc1 = {
    Text = "[Grasp the Spark] Aumenta gli HP massimi di Arg1"
  },
  Event_35920_ChoiceDesc2 = {
    Text = "[Affrontare il proprio cuore] 2 Carte di comando casuali ottengono l'Orazione: \"(EnchantConfig.Arg1)\", infetta 2 \"(Skill.Arg2)\""
  },
  Event_35920_Desc = {
    Text = "In questa grande caccia, la Caccia di Golia è come una bestia nell'oscurità, intenta a Divorare Tutto della speranza. Tuttavia, questo inseguimento implacabile non ti congela; al contrario, accende una scintilla nel profondo, che si propaga e arde sempre più nel tuo petto."
  },
  Event_35920_Name = {
    Text = "Cacciatrice di Luce"
  },
  Event_35921_ChoiceDesc1 = {
    Text = "[Decipher It] Duplica 1 Carta di comando su 3"
  },
  Event_35921_ChoiceDesc2 = {
    Text = "[Diventare quello] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_35921_ChoiceDesc3 = {
    Text = "[Disregard It] Ricevi 25 Sigilli Neri"
  },
  Event_35921_Desc = {
    Text = "Mentre avanzi di un passo, un tremito invisibile afferra la tua mente, costringendo il tuo sguardo verso il confine caotico e illusorio del Dominio."
  },
  Event_35921_Name = {
    Text = "Premonizione del Futuro"
  },
  Event_35922_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35922_Desc = {
    Text = "Colori abbaglianti danzano davanti ai tuoi occhi, sussurri riempiono le tue orecchie, e scene fugaci con volti sfocati si intrecciano, come a narrare una serie di storie sconosciute. Le illusioni ti fanno sentire distaccato dalla realtà, trascinato in un Paesaggio Onirico al contempo familiare e alieno."
  },
  Event_35922_Name = {
    Text = "Premonizione del Futuro"
  },
  Event_35923_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35923_Desc = {
    Text = "Il tremore non proviene da rumori esterni né da vibrazioni fisiche, ma da un'indescrivibile, profonda premonizione interiore. È come un richiamo dal futuro, che pulsa nella tua coscienza."
  },
  Event_35923_Name = {
    Text = "Premonizione del Futuro"
  },
  Event_35924_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35924_Desc = {
    Text = "La sua mano si muove istintivamente verso il petto, cercando di controllare la sensazione di soffocamento.\nLa paura la costringe a serrare i denti, forzandosi a ignorare il dolore lancinante nel petto. Ogni minima contrazione sul volto di Murphy viene rapidamente occultata, celando la sofferenza dietro una facciata maldestra.\n—Finché non le prendi la mano, e la sorpresa colora la sua espressione."
  },
  Event_35924_Name = {
    Text = "Gestione del Dolore"
  },
  Event_35925_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35925_Desc = {
    Text = "\n\"Murphy? Stai bene?\"\n— Non ti risponde.\nLa palpabile stranezza le corrode il cuore, rendendole quasi impossibile respirare."
  },
  Event_35925_Name = {
    Text = "Gestione del Dolore"
  },
  Event_35926_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35926_Desc = {
    Text = "Non esiti più e ti addentri nell'ignoto più oscuro. Ovunque tu vada, si dischiude un sentiero che conduce a un tenue Bagliore."
  },
  Event_35926_Name = {
    Text = "La Via d'Uscita"
  },
  Event_35927_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35927_Desc = {
    Text = "\nDavanti a te c'è un fuoco pulsante.\nÈ fervido, vivo, avvolge una fiamma fredda tremolante, dissipando con splendore quei suoni discordanti.\nQuando torni in te, trovi Murphy che ti guarda con sconcerto —\n\"Stai davvero bene?\""
  },
  Event_35927_Name = {
    Text = "Soglia della Morte"
  },
  Event_35928_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35928_Desc = {
    Text = "Senti la tua coscienza iniziare a separarsi, lentamente trascinata via dal tuo corpo.\nVedi la tua anima danzare con i Frammenti Residui della coscienza di Argento, poi sprofondare in un abisso invisibile...\nLà giace pura Illusione."
  },
  Event_35928_Name = {
    Text = "Monumento di mithril"
  },
  Event_35929_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_35929_Desc = {
    Text = [[
Prima che tu possa indagare ulteriormente la fonte della luce, essa improvvisamente trema e si frantuma nell'aria.
La luce si propaga attraverso il Dominio, espandendosi in onde.
Poi, non restano che Spoglie.]]
  },
  Event_35929_Name = {
    Text = "Battito di ciglia"
  },
  Event_35930_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35930_Desc = {
    Text = "Come potrebbe essere te?\nSe quello fossi tu, perché non ti ha salvato quando il Pianto è disceso?\nSe quello fossi tu, perché non ti ha aiutato nelle tue avversità?\nDunque, è tutta un'Illusione."
  },
  Event_35930_Name = {
    Text = "Destino Invertito"
  },
  Event_35931_ChoiceDesc1 = {
    Text = "[Ask the Captain]"
  },
  Event_35931_ChoiceDesc2 = {Text = "[Ask Tulu]"},
  Event_35931_Desc = {
    Text = "Ancora una volta, vedi quella figura misteriosa scomparire nella paratia, svanendo senza lasciare traccia. I lunghi capelli luminescenti ricadono in diversi viticci che sfiorano il suolo.\nSai con certezza che, anche se non è una Navigatrice, deve avere legami profondi con la Nazione Perduta."
  },
  Event_35931_Name = {
    Text = "L'Affondamento della Sona-Nyl"
  },
  Event_35932_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35932_Desc = {
    Text = "Hai paura; è tutta l'Adrenalina.\nTemi che le tue decisioni possano ferire le anime che condividono l'oscurità con te."
  },
  Event_35932_Name = {
    Text = "Cacciatrice di Luce"
  },
  Event_35933_ChoiceDesc1 = {
    Text = "[Nowhere to Run] Ricevi 25 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_35933_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_35933_Desc = {
    Text = "Ogni nervo urla con un desiderio ardente di @2."
  },
  Event_35933_Name = {
    Text = "Soglia della Morte"
  },
  Event_35934_ChoiceDesc1 = {Text = "[Chase]"},
  Event_35934_ChoiceDesc2 = {
    Text = "[Ignore It]"
  },
  Event_35934_Desc = {
    Text = "In lontananza nel Dominio, appare una luce fioca e ammaliante.\nBrilla come luce solare che danza sull'acqua, come lo scintillio delle stelle, o come la fiamma di una candela...\nQuando ti avvicini, la luce svanisce bruscamente.\nSembra attirarti, proprio come una falena è attratta dalla fiamma per istinto."
  },
  Event_35934_Name = {
    Text = "Battito di ciglia"
  },
  Event_35935_ChoiceDesc1 = {Text = "[Leave]"},
  Event_35935_Desc = {
    Text = [[
A che serve soffermarsi su queste cose?
Sei come una foglia sospesa a mezz'aria, sospinta dai venti del destino. Nient'altro.]]
  },
  Event_35935_Name = {
    Text = "Destino Invertito"
  },
  Event_35936_ChoiceDesc1 = {
    Text = "[Self-Deprecation] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_35936_ChoiceDesc2 = {
    Text = "[Pursue] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\" e \"(Skill.Arg3)\"."
  },
  Event_35936_ChoiceDesc3 = {
    Text = "[Stop Thinking] Ricevi 25 Sigilli Neri"
  },
  Event_35936_Desc = {
    Text = "Il vento della vita sfiora la tua anima, scuotendoti nel vortice della realtà e trascinandoti nell'ignoto avvolto dalla nebbia.\nNon puoi fare a meno di chiedere alla voce nella tua testa: \"Quello sono io?\""
  },
  Event_35936_Name = {
    Text = "Destino Invertito"
  },
  Event_36146_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36146_Desc = {
    Text = "\nMurphy finalmente nota il tuo sguardo; forse è davvero troppo intenso.\nFa qualche respiro profondo, emettendo un debole \"hmm\" dal naso. Infine, prende Celeste per mano e ti segue da vicino."
  },
  Event_36146_Name = {
    Text = "Gestione del Dolore"
  },
  Event_36722_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36722_Desc = {
    Text = "Nell'istante in cui le punte delle dita entrano in contatto, un'onda di sensazioni complesse ti travolge: al contempo rovente e gelida.\nLe anime dimenticate dal mondo urlano, cercando l'eternità."
  },
  Event_36722_Name = {
    Text = "Monumento della Gnosi"
  },
  Event_36723_ChoiceDesc1 = {
    Text = "[Touch it] Risveglia un Risvegliatore casuale, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_36723_ChoiceDesc2 = {
    Text = "[Join the Spin] Incidi 1 Orazione su 3"
  },
  Event_36723_Desc = {
    Text = "Mentre avanzi di un passo, una crepa si forma silenziosamente nella parte più profonda del tuo Spirito. Un'aura profonda e indescrivibile filtra attraverso, increspando i tuoi pensieri.\nPercepisci un Pianeta caotico d'Argento che ruota e cresce silenziosamente dentro di te."
  },
  Event_36723_Name = {
    Text = "Monumento della Gnosi"
  },
  Event_36724_ChoiceDesc1 = {
    Text = "[Follow them] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_36724_ChoiceDesc2 = {
    Text = "[Pet Them] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\" e \"(Skill.Arg3)\"."
  },
  Event_36724_ChoiceDesc3 = {
    Text = "[Do Not Disturb] Ricevi 25 Sigilli Neri"
  },
  Event_36724_Desc = {
    Text = [[
Svoltando un angolo inaspettato, una strana visione si presenta ai tuoi occhi.
Diverse ombre feline si muovono indistintamente lungo lo scafo freddo.]]
  },
  Event_36724_Name = {
    Text = "Gatti di Bordo"
  },
  Event_36725_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36725_Desc = {
    Text = "Le \"Memorie\" non rispondono. Si aggrappano alla parete della cabina, fissandoti finché non svolti dietro l'angolo successivo."
  },
  Event_36725_Name = {
    Text = "Il Padrone della Sona-Nyl"
  },
  Event_36726_ChoiceDesc1 = {
    Text = "[Detour] Distruggi una Carta di comando e ricevi Arg1 Sigilli Neri."
  },
  Event_36726_ChoiceDesc2 = {
    Text = "[Ask Why It Sank] Duplica una Carta di comando, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_36726_ChoiceDesc3 = {
    Text = "[Greet the Crew] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_36726_Desc = {
    Text = [[

Mentre cammini verso la sala macchine, incontri di nuovo alcune "memorie" fissate nel dominio.
Non sono fantasmi, ma soltanto i pensieri persistenti del Capitano Elton per l'equipaggio perduto.]]
  },
  Event_36726_Name = {
    Text = "Il Padrone della Sona-Nyl"
  },
  Event_36727_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36727_Desc = {
    Text = "\nLe \"Memorie\" si staccano dalla paratia, distorcendo il proprio volto mentre emettono un lamento straziante.\n—Il faro.\n—Il faro isolato li aveva condotti nella tempesta."
  },
  Event_36727_Name = {
    Text = "Il Padrone della Sona-Nyl"
  },
  Event_36728_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36728_Desc = {
    Text = "Hai scelto di seguire il sentiero tracciato da anime gentili e libere, anche se le trappole oscure si celano più avanti"
  },
  Event_36728_Name = {
    Text = "Gatti di Bordo"
  },
  Event_36729_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36729_Desc = {
    Text = "Non disturbare i morti, né destare le Memorie di coloro che sono nel Dormiveglia."
  },
  Event_36729_Name = {
    Text = "Il Padrone della Sona-Nyl"
  },
  Event_36730_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36730_Desc = {
    Text = "Senti la tua coscienza iniziare a separarsi, lentamente trascinata via dal tuo corpo.\nVedi la tua anima danzare con il Pianeta, poi sprofondare in un abisso invisibile...\nLà giace il puro vuoto."
  },
  Event_36730_Name = {
    Text = "Monumento della Gnosi"
  },
  Event_36731_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36731_Desc = {
    Text = [[
Creature gentili, sono un lusso proibito in questo Dominio, meri fantasmi.
Pur comprendendolo, un tenue calore si increspa ancora nel tuo cuore.]]
  },
  Event_36731_Name = {
    Text = "Gatti di Bordo"
  },
  Event_36732_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36732_Desc = {
    Text = "Le loro figure sono sfocate, come un dipinto dissolto dai torrenti del tempo e dello spazio. Le profonde macchie nere ricordano nuvole alla deriva nel cielo notturno, ma i loro occhi brillano come il bagliore di stelle lontane, emanando una radiosità misteriosa e profonda.\nNon puoi resistere al loro richiamo, protendendoti verso un reame d'illusione."
  },
  Event_36732_Name = {
    Text = "Gatti di Bordo"
  },
  Event_36733_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36733_Desc = {
    Text = "Sai che devi continuare ad andare avanti, anche se inciampi, anche se cadi."
  },
  Event_36733_Name = {
    Text = "Tormento della Carne"
  },
  Event_36734_ChoiceDesc1 = {
    Text = "[Attempt to Call Him] Aumenta gli HP massimi di Arg1"
  },
  Event_36734_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36734_Desc = {
    Text = "Questo luogo è colmo di desideri celati e paure inviolate, un ricco arazzo dei suoi sogni e delle sue Memorie."
  },
  Event_36734_Name = {
    Text = "Alba Metamorfica"
  },
  Event_36735_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36735_Desc = {
    Text = "\"Custode, se non riesci a resistere, ti prego, non sopportare il dolore da solo.\"\nNon eviterai il dolore, poiché è parte della vita fugace.\nNon temerai le ombre della notte, perché non paventi l'essere divorato dalla sua oscurità."
  },
  Event_36735_Name = {
    Text = "Tormento della Carne"
  },
  Event_36736_ChoiceDesc1 = {
    Text = "[Keep Calling Him] Aumenta gli HP massimi di Arg1, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_36736_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36736_Desc = {
    Text = "Questo mondo è composto da scarabocchi ingenui."
  },
  Event_36736_Name = {
    Text = "Alba Metamorfica"
  },
  Event_36737_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36737_Desc = {
    Text = "Le preghiere dei Navigatori risuonano tutt'intorno, alienanti e soffocanti.\nMa non influenzeranno la tua volontà, assolutamente no."
  },
  Event_36737_Name = {Text = "Dal mare"},
  Event_36738_ChoiceDesc1 = {
    Text = "[Pick up the Photo] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_36738_Desc = {
    Text = "Il loro sguardo è profondo e limpido, come luce nel mare profondo, luminoso e caldo.\nNon parlano né appaiono, ma puoi percepire la loro presenza, come la carezza gentile di una brezza estiva."
  },
  Event_36738_Name = {
    Text = "Sguardo Benevolo"
  },
  Event_36739_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36739_Desc = {
    Text = "Vi sforzate di concentrarvi sulla crisi immediata, imponendovi severamente di ignorare il dolore."
  },
  Event_36739_Name = {
    Text = "Tormento della Carne"
  },
  Event_36740_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36740_Desc = {
    Text = "Sono i segni della vita, la prova dell'esistenza. Narrano storie, ma gradualmente perdono la voce sotto la furia della tempesta."
  },
  Event_36740_Name = {
    Text = "Addio, Icaro"
  },
  Event_36741_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36741_Desc = {
    Text = "Il loro sguardo è profondo e limpido, come luce nel mare profondo, luminoso e caldo.\nNon parlano né appaiono, ma puoi percepire la loro presenza, come la carezza gentile di una brezza estiva."
  },
  Event_36741_Name = {
    Text = "Sguardo Benevolo"
  },
  Event_36742_ChoiceDesc1 = {
    Text = "[The Last Call] Aumenta gli HP massimi di Arg1, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_36742_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36742_Desc = {
    Text = "Il mondo è fatto di dolorose fratture."
  },
  Event_36742_Name = {
    Text = "Alba Metamorfica"
  },
  Event_36743_ChoiceDesc1 = {
    Text = "[Embrace Pain] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_36743_ChoiceDesc2 = {
    Text = "[Refuse Pain] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\" e \"(Skill.Arg3)\"."
  },
  Event_36743_ChoiceDesc3 = {
    Text = "[Ignore Pain] Ricevi 25 Sigilli Neri"
  },
  Event_36743_Desc = {
    Text = "Il dolore è radicato nella tua mente come una roccia ostinata. L'agonia che si diffonde si intreccia a ogni nervo, distorcendo la tua coscienza."
  },
  Event_36743_Name = {
    Text = "Tormento della Carne"
  },
  Event_36744_ChoiceDesc1 = {
    Text = "[Firm Call] Aumenta gli HP massimi di Arg1, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_36744_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36744_Desc = {
    Text = "Il desiderio di riconoscimento plasma questo mondo."
  },
  Event_36744_Name = {
    Text = "Alba Metamorfica"
  },
  Event_36745_ChoiceDesc1 = {
    Text = "[Watch Them] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_36745_ChoiceDesc2 = {
    Text = "[Seek Help] Sviluppa il Sintomo [(Skill.Arg1)] e cambia l'Orazione da incidere.(Utilizzi: 2/2)"
  },
  Event_36745_Desc = {
    Text = "Nei colori fluenti del Dominio, avverti uno sguardo misterioso—occhi privi di forma, occultati nelle sue pieghe enigmatiche.\nNell'istante in cui volgono lo sguardo su di te, un desiderio potente sorge nel tuo cuore."
  },
  Event_36745_Name = {
    Text = "Sguardo Benevolo"
  },
  Event_36746_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36746_Desc = {
    Text = "Se non riuscirai a comprenderli, non potrai sfuggire a questo inferno caotico.\nQuando le stelle si riflettono sulla superficie dell'acqua, quei desideri e suppliche pulsanti, quelle preghiere, salgono come bolle verso il mare, solo per essere silenziosamente divorate dall'oscurità."
  },
  Event_36746_Name = {Text = "Dal mare"},
  Event_36747_ChoiceDesc1 = {
    Text = "[Eager Call] Aumenta gli HP massimi di Arg1, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_36747_ChoiceDesc2 = {Text = "[Leave]"},
  Event_36747_Desc = {
    Text = "Parole orribili compongono questo mondo."
  },
  Event_36747_Name = {
    Text = "Alba Metamorfica"
  },
  Event_36748_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36748_Desc = {
    Text = "Ti ergi dinanzi a lui, osservando la sua anima divorata da strane Memorie."
  },
  Event_36748_Name = {
    Text = "Alba Metamorfica"
  },
  Event_36749_ChoiceDesc1 = {
    Text = "[Tears of Sorrow] Distruggi una Carta"
  },
  Event_36749_ChoiceDesc2 = {
    Text = "[That's Blood] Ottieni la Reliquia \"(RelicConfig.Arg1)\", ma sviluppi il Sintomo \"(Skill.Arg2)\"."
  },
  Event_36749_Desc = {
    Text = "Alcune gocce di liquido si spargono liberamente sul ponte, infiltrandosi in silenzio attraverso le fessure.\nLe tracce sono delicate eppure tenaci, ogni segno umido porta con sé un senso di definitività, tessendo un quadro di vita e morte, quiete e caos tra il ruggito del vento marino e lo scricchiolio delle vele."
  },
  Event_36749_Name = {
    Text = "Addio, Icaro"
  },
  Event_36750_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36750_Desc = {
    Text = [[
Fissi le macchie che si espandono lentamente, cercando di discernerne la natura. Al confine dove cielo e terra si incontrano, la distinzione tra pioggia e sangue si fa sfumata.
Sono gocce di pioggia? O sono lacrime dell'oceano?
Non lo sai.]]
  },
  Event_36750_Name = {
    Text = "Addio, Icaro"
  },
  Event_36751_ChoiceDesc1 = {
    Text = "[Reject the Synchrony] Acquisisci 1 delle 3 Reliquie d'argento"
  },
  Event_36751_ChoiceDesc2 = {
    Text = "[Join the Synchrony] Acquisisci le Reliquie d'argento \"(RelicConfig.Arg1)\" e \"(RelicConfig.Arg2)\", ma sviluppa \"(Skill.Arg3)\" due volte."
  },
  Event_36751_Desc = {
    Text = "I sussurri dei Navigatori si intrecciano con il battito del \"Sacro Infante\", creando una sinfonia celata. Ogni vibrazione scatena un fragore nell'universo liquido e sconfinato."
  },
  Event_36751_Name = {Text = "Dal mare"},
  Event_36752_ChoiceDesc1 = {
    Text = "[Pick up the Photo] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_36752_ChoiceDesc2 = {
    Text = "[Check Film] Sviluppa il Sintomo [(Skill.Arg1)] e cambia l'Orazione da incidere.(Utilizzi: 1/2)"
  },
  Event_36752_Desc = {
    Text = "Non nutrono alcuna cattiva intenzione; questa sensazione è semplicemente istintiva, con radici salde nelle tue ossa.\nCosì, abbassi la guardia e tenti di cercare aiuto da questi osservatori nascosti: condividi la tua confusione e i tuoi desideri con quell'esistenza vaga, parlando con la stessa sincerità di chi si confida con un vecchio amico."
  },
  Event_36752_Name = {
    Text = "Sguardo Benevolo"
  },
  Event_36874_ChoiceDesc1 = {
    Text = "[Narrate school stories] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_36874_ChoiceDesc2 = {
    Text = "[Uneducated] Ricevi 75 Sigilli Neri, ma sviluppa il Sintomo [(Skill.Arg2)]"
  },
  Event_36874_Desc = {
    Text = "Passando accanto a una rovina, gli occhi di Aurita si illuminarono all'improvviso.\n\"La nonna diceva che un tempo questa era una scuola, ma è stata abbandonata da tempo per mancanza di studenti!\"\n\"Aurita non è mai andata a scuola. E tu, amico? Ci sei mai andato?\""
  },
  Event_36874_Name = {
    Text = "Gioia Perduta"
  },
  Event_36875_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36875_Desc = {
    Text = [[
Ricevendo una risposta negativa da te, Aurita scosse la testa con aria cupa.
"Quindi, nemmeno il mondo esterno ha studenti... Allora qual era lo scopo di fondare le scuole, in primo luogo?"]]
  },
  Event_36875_Name = {
    Text = "Gioia Perduta"
  },
  Event_36876_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36876_Desc = {
    Text = "\"Ospizio dei Poveri, Topolino, Scultura di Cera... Evviva! Avventura, è un'avventura!\"\nDisse Aurita, con un punto interrogativo invisibile che fluttuava sopra la sua testa.\n\"Però la nonna ha detto che la scuola è un posto che renderà Aurita più intelligente, ma...\"\nPrima che Aurita potesse proseguire con i suoi pensieri, la spinsi dietro un altro angolo."
  },
  Event_36876_Name = {
    Text = "Gioia Perduta"
  },
  Event_36877_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36877_Desc = {
    Text = "\n\"P-perché?\"\nAurita è rimasta spaventata da te e ha continuato a guidarti con un'espressione severa.\n\"Questa è la casa di Aurita. Aurita sa che la piazza—è proprio qui dentro!\""
  },
  Event_36877_Name = {
    Text = "Oscurità Invisibile"
  },
  Event_36878_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36878_Desc = {
    Text = "\"Non voglio prendere questa strada. Aurita conosce un'altra via per la piazza?\"\nAurita fece il broncio, con aria confusa, ma alla fine tirò il tuo mantello e ti guidò in una direzione diversa."
  },
  Event_36878_Name = {
    Text = "Oscurità Invisibile"
  },
  Event_36879_ChoiceDesc1 = {Text = "[Leave]"},
  Event_36879_Desc = {
    Text = "Questo è un sogno, solo un sogno.\nTe lo ripeti come un monito, o forse come una consolazione, mentre conduci Aurita nell'Oscurità invisibile."
  },
  Event_36879_Name = {
    Text = "Oscurità Invisibile"
  },
  Event_36880_ChoiceDesc1 = {
    Text = "[Listen to Her] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando, ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_36880_ChoiceDesc2 = {
    Text = "[Oppose Her] Risveglia un Risvegliatore, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_36880_ChoiceDesc3 = {
    Text = "[Negotiate with Her] Ricevi 25 Sigilli Neri"
  },
  Event_36880_Desc = {
    Text = "Aurita si aggrappa al tuo mantello, avanzando passo dopo passo nelle tue orme.\n\"Ehi... no! La piazza è da quella parte!\"\nVolgi la testa nella direzione indicata da Aurita, e i sentieri nel Dominio sono completamente bui. Il D-slime e le aberrazioni si contorcono e si intrecciano tra loro, trascinando il mondo reale nell'Abisso."
  },
  Event_36880_Name = {
    Text = "Oscurità Invisibile"
  },
  Event_37983_ChoiceDesc1 = {
    Text = "[Secure Funding] Ottieni Arg1 Sigilli Neri"
  },
  Event_37983_ChoiceDesc2 = {
    Text = "[Secure Funding] Ottieni Arg1 Sigilli Neri [ExDesc1]"
  },
  Event_37983_Desc = {
    Text = "\"Nessun signore lascerebbe un ospite misterioso senza sorveglianza, men che meno un monaco.\"\nLa regina sedeva in alto sul suo Trono, un Tremolio di tirannia nei suoi occhi.\n\"Dimostrate la vostra utilità, oppure...\"\nUtilità? Gettate lo sguardo sulla terra arida oltre la finestra, e un pensiero sorge d'improvviso: forse potreste usare la vostra Conoscenza economica per aiutare Wanda ad amministrare la tenuta?\nVi sforzate di richiamare alla mente i vostri studi—a Mythag, economia era solo un esame opzionale secondario...\nLa pazienza si esaurisce. La regina sbadiglia.\n\"Deludente. Esegu—\"\nProprio mentre la ghigliottina cala, gli spiriti di Adam Smith, Malthus, David Ricardo e altri grandi predecessori discendono nella vostra mente.\nDivisione del lavoro! Tassazione! Popolazione, maledetta popolazione!\nForse ricordate..."
  },
  Event_37983_Name = {
    Text = "Codice dell'Emissario"
  },
  Event_37984_ChoiceDesc1 = {Text = "[Leave]"},
  Event_37984_Desc = {
    Text = "Presenti con riluttanza il decreto.\nLa regina vi getta un'occhiata e abbozza un sorriso gelido:\n\"Se si rivelerà inutile, sai cosa accadrà.\""
  },
  Event_37984_Name = {
    Text = "Codice dell'Emissario"
  },
  Event_37985_ChoiceDesc1 = {
    Text = "[Propose Decree] Acquisisci la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_37985_ChoiceDesc2 = {
    Text = "[Propose Decree] Acquisisci la Reliquia maledetta [(RelicConfig.Arg1)]"
  },
  Event_37985_ChoiceDesc3 = {
    Text = "[Propose Decree] Acquisisci la Reliquia dorata [(RelicConfig.Arg1)]"
  },
  Event_37985_Desc = {
    Text = "\n\"Avendo preso i miei soldi, devi servirmi.\"\nLa regina posava il mento su una mano, guardandoti con noncuranza.\nChe lo ammetta o meno, è davvero curiosa al riguardo.\n\"Ora dunque, esponimi il tuo piano, grande riformatore.\""
  },
  Event_37985_Name = {
    Text = "Codice dell'Emissario"
  },
  Event_38700_ChoiceDesc1 = {
    Text = "[Connect] Recupera Arg2 HP. [ExDesc1]"
  },
  Event_38700_ChoiceDesc2 = {
    Text = "[Meditate] Risveglia un Risvegliato."
  },
  Event_38700_ChoiceDesc3 = {
    Text = "[Expel] Distruggi fino a 3 Carte sintomo e ottieni Arg2 Sigilli Neri."
  },
  Event_38700_Desc = {
    Text = "La nebbia si aggrappa densa mentre il tuo distintivo emette un pallido bagliore argenteo. Il comunicatore crepita, prendendo vita. Qualcuno sta chiamando."
  },
  Event_38700_Name = {Text = "Crocevia"},
  Event_38700_Tips3 = {
    Text = "Al momento non manifesti alcun Sintomo."
  },
  Event_38707_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Sviluppa un Sintomo casuale."
  },
  Event_38707_ChoiceDesc2 = {
    Text = "[Absorb Illusion] Perdi Arg1 HP e ottieni Arg2 Sigilli Neri"
  },
  Event_38707_ChoiceDesc3 = {Text = "[Leave]"},
  Event_38707_Desc = {
    Text = "Volti sfocati appaiono all'improvviso, circondandoti e gemendo disperatamente con corde vocali inesistenti."
  },
  Event_38707_Name = {Text = "Illusione"},
  Event_38715_ChoiceDesc1 = {
    Text = "[Propose Decree] Acquisisci le Reliquie d'argento \"(RelicConfig.Arg1)\" e \"(RelicConfig.Arg2)\""
  },
  Event_38715_ChoiceDesc2 = {
    Text = "[Propose Decree] Acquisisci la Reliquia maledetta [(RelicConfig.Arg1)]"
  },
  Event_38715_ChoiceDesc3 = {
    Text = "[Propose Decree] Acquisisci la Reliquia dorata [(RelicConfig.Arg1)]"
  },
  Event_38715_Desc = {
    Text = "\n\"Avendo preso i miei soldi, devi servirmi.\"\nLa regina posava il mento su una mano, guardandoti con noncuranza.\nChe lo ammetta o meno, è davvero curiosa al riguardo.\n\"Ora dunque, esponimi il tuo piano, grande riformatore.\""
  },
  Event_38715_Name = {
    Text = "Codice dell'Emissario"
  },
  Event_40452_ChoiceDesc1 = {
    Text = "[Chiedere l'Identità] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_40452_ChoiceDesc2 = {
    Text = "[Leave] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 3 Carte di comando casuali, ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_40452_Desc = {
    Text = "Tre fantasmi bloccavano il cammino.\nCircondavano il tavolo da gioco, gli occhi fissi sui dadi.\n\"Gulp, gulp.\"\nI dadi venivano lanciati e cadevano innumerevoli volte.\nQuesta è una scommessa senza fine."
  },
  Event_40452_Name = {
    Text = "Scommessa Infinita"
  },
  Event_40453_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40453_Desc = {
    Text = "\n\"Salve, siamo il primo, il secondo e il terzo marito di Wanda.\"\n\"Come? Chiedete dov'è il quarto marito?\nBeh... a dire il vero, a John mancava il senso dell'umorismo, così la signora lo ha trasformato in un Accolito Cieco.\"\n\"Ci manca a tutti. Naturalmente, solo un pochino.\""
  },
  Event_40453_Name = {
    Text = "Scommessa Infinita"
  },
  Event_40454_ChoiceDesc1 = {
    Text = "[Shake Hands] Risveglia un Risvegliatore casuale, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_40454_ChoiceDesc2 = {
    Text = "[Leave] Incidi 1 Orazione su 3"
  },
  Event_40454_Desc = {
    Text = [[
Mentre passavano davanti a una gabbia, una mano si protese dall'interno.
"Non lasciarmi, Rebecca..."
La voce era vecchia e riarsa, come un mantice logoro.]]
  },
  Event_40454_Name = {
    Text = "Prigioniero"
  },
  Event_40455_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40455_Desc = {
    Text = "Il palmo della mano è appiccicoso: è D-melma.\nIl proprietario della voce è svanito, celato negli angoli d'ombra."
  },
  Event_40455_Name = {
    Text = "Prigioniero"
  },
  Event_40456_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40456_Desc = {
    Text = "Te ne sei andato senza pensarci, perdendoti il racconto drammatico sul retro della lettera.\nMa ha importanza?\nOceani sconfinati, albe e tramonti, deserti equatoriali...\nIncontrerai di più, e perderai di più."
  },
  Event_40456_Name = {
    Text = "Alla mia amata signora"
  },
  Event_40457_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40457_Desc = {
    Text = "In un certo senso, non sei diverso da questo Prigioniero.\nNon è il momento di dare l'allarme.\nIgnori le suppliche del Prigioniero e te ne vai."
  },
  Event_40457_Name = {
    Text = "Prigioniero"
  },
  Event_40458_ChoiceDesc1 = {
    Text = "[Tear Letter] Trasforma una Reliquia nella Reliquia maledetta [(RelicConfig.Arg1)]"
  },
  Event_40458_ChoiceDesc2 = {
    Text = "[Ignore the Letter] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_40458_ChoiceDesc3 = {
    Text = "[Reply] Ricevi 25 Sigilli Neri"
  },
  Event_40458_Desc = {
    Text = [[
I. Lettera di John Cambrian a Wanda (B.F. @2)

Un marito ha il diritto di disporre della propria moglie, almeno a Cambrian.
Ma ho chiaramente sottovalutato la tua follia. Ora sono quasi cieco, e i miei arti stanno per essere amputati.
Figlia del male... No, tu sei il male stesso.
Ti maledico @1, ti maledico @2, ti maledico, ti maledico...]]
  },
  Event_40458_Name = {
    Text = "Alla mia amata signora"
  },
  Event_40459_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40459_Desc = {
    Text = "Hai usato il metodo più diretto per spezzare la maledizione.\nNon è successo nulla. Il foglio è caduto a terra, inerte.\nHai alzato le spalle e te ne sei andato, ma non riuscivi a scrollarti di dosso la sensazione che qualcosa non andasse."
  },
  Event_40459_Name = {
    Text = "Alla mia amata signora"
  },
  Event_40460_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40460_Desc = {
    Text = [[
Passi oltre il tavolo da gioco senza pensarci due volte.
Mentre te ne vai, i fantasmi parlano all'unisono:
"Porti i nostri saluti alla nostra comune ex moglie, la signora Wanda."]]
  },
  Event_40460_Name = {
    Text = "Scommessa Infinita"
  },
  Event_40461_ChoiceDesc1 = {Text = "[Leave]"},
  Event_40461_Desc = {
    Text = [[
Scrivi con cura la tua risposta in fondo alla lettera:
"Maledizione ricevuta. Ti auguro ogni bene."
Non appena cade l'ultimo tratto, fiamme blu furiose si accendono sulla carta.
Raccogli le ceneri.]]
  },
  Event_40461_Name = {
    Text = "Alla mia amata signora"
  },
  Event_44187_ChoiceDesc1 = {
    Text = "[Face the Darkness] [ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc2 = {
    Text = "[Face the Darkness] [ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc3 = {
    Text = "[Flee the Darkness] Acquisisci una Reliquia Dorata casuale"
  },
  Event_44187_Desc = {
    Text = "L'anima dinanzi a te è oscura e corrotta: luce e tenebre coesistono al suo interno. Lottano per il predominio, lasciando l'anima nella confusione.\n\"Provo pietà per loro, quelle povere anime che hanno perso tutto, ma non è forse così che va il mondo?\n\"Perché qualcuno possa guadagnare, qualcun altro deve perdere.\n\"Devo forse sacrificare la mia felicità per la gioia altrui?\""
  },
  Event_44187_Name = {
    Text = "L'Oscurità Interiore"
  },
  Event_44188_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44188_Desc = {
    Text = "\"Questo è il mio peccato, il mio fardello. Come posso salvarti, anima mia contraddittoria?\""
  },
  Event_44188_Name = {
    Text = "L'Oscurità Interiore"
  },
  Event_44299_ChoiceDesc1 = {
    Text = "[Plea to the Bishop] Purifica una Reliquia Peccaminosa. Se non ne possiedi, acquisisci una Reliquia dorata casuale."
  },
  Event_44299_Desc = {
    Text = "\"Ho ingannato e manipolato per ottenere la vita che desideravo—il denaro è diventato un mero numero, le prelibatezze si sono trasformate in pasti quotidiani, avevo l'ultima parola negli affari e esercitavo una Forte influenza in politica. Ma perché, perché non riesco a dimenticare quelle persone, quelle a cui ho portato via tutto? Perché non riesco a dimenticare la disperazione sui loro volti?\n\"L'alcol offre solo una Fuga fugace; la mia anima si sta lacerando, e il Pain mi sta quasi sommergendo.\n\"Cosa dovrei fare?\""
  },
  Event_44299_Name = {
    Text = "Colpa e Perdono"
  },
  Event_44301_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44301_Desc = {
    Text = [[
"Percorri un sentiero di sofferenza, smarrito lontano dalla gloria del Padre Supremo.
"Ritorna, agnello perduto. Ascolta gli insegnamenti del Padre Supremo e ritrova la retta via."]]
  },
  Event_44301_Name = {
    Text = "Colpa e Perdono"
  },
  Event_44395_ChoiceDesc1 = {
    Text = "[Want for the Worldly] Ricevi Arg1 Sigilli Neri. Il Vescovo assume un tuo Sintomo, se ne possiedi uno."
  },
  Event_44395_ChoiceDesc2 = {
    Text = "[Want for Blood] Il Vescovo assorbe 2 Sintomi. Incidi l'Orazione [(EnchantConfig.Arg1)]."
  },
  Event_44395_ChoiceDesc3 = {
    Text = "[Want for More] Il Vescovo può assorbire di più, se possiedi 4 o più Sintomi."
  },
  Event_44395_Desc = {
    Text = "\nL'anima illusoria formò un vago profilo, inginocchiandosi dinanzi al Vescovo per mostrare il suo corpo spezzato e i resti del suo cuore annerito.\n\"Mi hai donato guida, perdono e salvezza, ma misericordioso Vescovo, tutto ciò è ben lungi dall'essere sufficiente.\n\"Sono indigente e afflitto dalla malattia. La mia vita pende da un filo, e tu sei la mia unica salvezza. Ti prego, salvami, Vescovo, affinché io non debba più soffrire.\""
  },
  Event_44395_Name = {
    Text = "La \"benedizione\" del Vescovo"
  },
  Event_44396_ChoiceDesc1 = {
    Text = "[Bow and Leave]"
  },
  Event_44396_Desc = {
    Text = "Il Vescovo si tolse l'anello e la spilla. Le gemme azzurre che simboleggiavano il Padre Supremo furono deposte una a una nelle mani dell'anima. Il Vescovo si chinò, stringendo le mani della povera anima.\n\"Prendi il mio oro e il mio argento, prendi tutti i miei averi — se è ciò di cui hai bisogno. Gli insegnamenti del Padre Supremo sono tutto ciò che mi serve per vivere.\""
  },
  Event_44396_Name = {
    Text = "La \"benedizione\" del Vescovo"
  },
  Event_44400_ChoiceDesc1 = {
    Text = "[Indulge] Risveglia un Risvegliatore casuale, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_44400_ChoiceDesc2 = {Text = "[Give Up]"},
  Event_44400_Desc = {
    Text = "L'anima perduta rifiuta di abbandonare l'oscurità.\nSai cosa l'attende. Una vita assurda sta per dispiegarsi, e tu sei l'unico spettatore."
  },
  Event_44400_Name = {
    Text = "L'Oscurità Interiore"
  },
  Event_44401_ChoiceDesc1 = {
    Text = "[Quick Reflexes] Ricevi Arg1 Sigilli Neri"
  },
  Event_44401_ChoiceDesc2 = {
    Text = "[Seize Freely] Incidi 1 tra 3 Orazioni avanzate, ma sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_44401_Desc = {
    Text = "Un marchio nero trovato nel Dominio può essere sacrificato al D-Mark in cambio di Reliquie o altre proiezioni spirituali. Si dissolverà presto in una melma nera dopo aver lasciato l'area corrente."
  },
  Event_44401_Name = {
    Text = "Sigillo Nero"
  },
  Event_44407_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Sviluppa un Sintomo casuale."
  },
  Event_44407_ChoiceDesc2 = {
    Text = "[Embrace Delusion] Ricevi Arg1 Sigilli Neri, ma sviluppi 2 Sintomi casuali."
  },
  Event_44407_ChoiceDesc3 = {Text = "[Leave]"},
  Event_44407_Desc = {
    Text = "Volti sfocati appaiono all'improvviso, circondandoti e gemendo disperatamente con corde vocali inesistenti."
  },
  Event_44407_Name = {Text = "Illusione"},
  Event_44445_ChoiceDesc1 = {
    Text = "[Leave] Cerca il Riflettore"
  },
  Event_44445_ChoiceDesc2 = {
    Text = "[Break into Mist] Perde Arg2 HP"
  },
  Event_44445_ChoiceDesc3 = {
    Text = "[Discard Extraneous Items] Perdi 5 Sigilli Neri e aggiungi 1 [Intuizione] al mazzo."
  },
  Event_44445_Desc = {
    Text = "Davanti a te si stende una fitta nebbia nera; addentrarsi avventatamente porterà sciagura.\nForse dovresti trovare un \"Riflettore\" per disperdere la nebbia."
  },
  Event_44445_Name = {Text = "???"},
  Event_44469_ChoiceDesc1 = {
    Text = "[Want for Caro] Il Vescovo assorbe 4 Sintomi. Acquisisci 1 tra 3 Reliquie dorate+."
  },
  Event_44469_ChoiceDesc2 = {
    Text = "[Want for Sanctity] Il Vescovo assorbe 6 Sintomi. Acquisisci 1 tra 3 Pendoli crono."
  },
  Event_44469_ChoiceDesc3 = {Text = "[Return]"},
  Event_44469_Desc = {
    Text = "\nL'anima illusoria formò un vago profilo, inginocchiandosi dinanzi al Vescovo per mostrare il suo corpo spezzato e i resti del suo cuore annerito.\n\"Mi hai donato guida, perdono e salvezza, ma misericordioso Vescovo, tutto ciò è ben lungi dall'essere sufficiente.\n\"Sono indigente e afflitto dalla malattia. La mia vita pende da un filo, e tu sei la mia unica salvezza. Ti prego, salvami, Vescovo, affinché io non debba più soffrire.\""
  },
  Event_44469_Name = {
    Text = "La \"benedizione\" del Vescovo"
  },
  Event_44474_ChoiceDesc1 = {
    Text = "[Plea] Ricevi la Benedizione del Vescovo"
  },
  Event_44474_ChoiceDesc2 = {
    Text = "[Plea] Ricevi la Benedizione del Vescovo"
  },
  Event_44474_ChoiceDesc3 = {Text = "[Leave]"},
  Event_44474_Desc = {
    Text = "\"Questo è il mio peccato, il mio fardello. Come posso salvarti, anima mia contraddittoria?\""
  },
  Event_44474_Name = {
    Text = "L'Oscurità Interiore"
  },
  Event_44911_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44911_Desc = {
    Text = [[

"Tutto, tutto... Esatto, voglio tutto...!"
L'anima protese la mano, afferrando invano l'aria.
Ottenne qualcosa, ma perse ogni cosa.]]
  },
  Event_44911_Name = {
    Text = "Cosa Hai Ottenuto?"
  },
  Event_44913_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44913_Desc = {
    Text = "\"Solo il più importante... il più cruciale...\"\nL'Anima si accovacciò, dissotterrò un radioso desiderio dal suolo dell'Illusione e lo cullò tra le mani."
  },
  Event_44913_Name = {
    Text = "Cosa Hai Ottenuto?"
  },
  Event_44916_ChoiceDesc1 = {
    Text = "[Afferrare tutto] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_44916_ChoiceDesc2 = {
    Text = "[Learn to Let Go] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 3 Carte di comando casuali, ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_44916_Desc = {
    Text = "L'anima fioca è in agonia.\nVaga, confusa da tutte le scelte possibili e dalle loro conseguenze.\n\"Cosa dovrei scegliere?\" sussurra, \"Cosa dovrei fare?\"\n\"Come posso avere tutto?\""
  },
  Event_44916_Name = {
    Text = "Cosa Hai Ottenuto?"
  },
  Event_44919_ChoiceDesc1 = {
    Text = "[Self-Reflection] Risveglia un Risvegliatore casuale, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_44919_ChoiceDesc2 = {
    Text = "[Look Around] Incidi 1 Orazione su 3"
  },
  Event_44919_Desc = {
    Text = "L'anima fluttuante è intrappolata in un dilemma.\nSi ferma, oscillando tra i desideri.\n\"Cosa dovrei scegliere?\" mormora sommessamente, \"Cosa dovrei fare?\"\n\"Qual è il mio vero desiderio?\""
  },
  Event_44919_Name = {
    Text = "Qual È il Tuo Desiderio?"
  },
  Event_44920_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44920_Desc = {
    Text = "\n\"Hai ragione, devo vedere, devo vedere...\"\nAbbassa il capo, le mani che frugano nella cavità toracica, estraendo un cuore fantasmatico: una metà nera come l'inchiostro, l'altra luminosa come una stella."
  },
  Event_44920_Name = {
    Text = "Qual È il Tuo Desiderio?"
  },
  Event_44921_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44921_Desc = {
    Text = "\n\"Sì, sì... La gente dice che gli altri possono essere un riflesso... Devo vedere...\"\nSi avvicinò, guardandoti con il suo volto privo di fattezze.\n\"Perché non sei turbato? Che invidia, che invidia...\""
  },
  Event_44921_Name = {
    Text = "Qual È il Tuo Desiderio?"
  },
  Event_44998_ChoiceDesc1 = {Text = "[Leave]"},
  Event_44998_Desc = {
    Text = "\"Dicono che la sofferenza attuale sia temporanea, e che dopo la morte gioiremo eternamente nell'abbraccio del Padre di Tutto.\n\"Io non voglio aspettare fino a dopo la morte.\"\nLe ombre divorano avidamente ogni cosa; le anime si affievoliscono, quasi fondendosi con l'oscurità circostante.\nVorresti agire, ma ti senti impotente."
  },
  Event_44998_Name = {
    Text = "L'Oscurità Interiore"
  },
  Event_45000_ChoiceDesc1 = {
    Text = "[Bow and Leave]"
  },
  Event_45000_Desc = {
    Text = "Il vescovo si squarciò il palmo con una lama affilata, e il sangue che gocciolava sulla tavoletta si trasformò in una luce blu risanatrice, reintegrando il sangue mancante dell'anima.\n\"Prendi il mio sangue, colma la tua vita — se è ciò di cui hai bisogno. Questo è ciò che Il Padre di Tutto vuole che io faccia.\""
  },
  Event_45000_Name = {
    Text = "La \"benedizione\" del Vescovo"
  },
  Event_45001_ChoiceDesc1 = {
    Text = "[Bow and Leave]"
  },
  Event_45001_Desc = {
    Text = "Il Vescovo trasse la propria anima dal profondo del petto. La luce gentile si fuse nella Tavoletta, trasformandosi in un bagliore blu di Guarigione che colmò ogni crepa dell'anima.\n\"Ricevi questo; è un dono del Padre Supremo, un testamento del Suo amore. Che il tuo corpo sia sano, la tua anima integra, e che tu sia libero da ogni sofferenza.\""
  },
  Event_45001_Name = {
    Text = "La \"benedizione\" del Vescovo"
  },
  Event_45002_ChoiceDesc1 = {Text = "[Leave]"},
  Event_45002_Desc = {
    Text = "Ti avvicini a quei volti, e quando riapri gli occhi, tutto è avvolto dall'oscurità. Solo risate di origine ignota echeggiano intorno a te."
  },
  Event_45002_Name = {Text = "Illusione"},
  Event_45036_ChoiceDesc1 = {
    Text = "[Delete All Relics]"
  },
  Event_45036_Desc = {
    Text = "\"Questo è il mio peccato, il mio fardello. Come posso salvarti, anima mia contraddittoria?\""
  },
  Event_45036_Name = {
    Text = "L'Oscurità Interiore"
  },
  Event_45196_ChoiceDesc1 = {
    Text = "[Bow and Leave]"
  },
  Event_45196_Desc = {
    Text = "Il Vescovo usò una Lama affilata per ricavare osso e carne. Le ossa pallide e la carne Cremisi si fusero nella Tavoletta, trasformandosi in una luce blu di Guarigione che risanò l'anima fratturata.\n\"Prendi il mio osso e la mia carne per colmare ciò che manca al tuo corpo — se è questo ciò di cui hai bisogno. Questo è ciò che il Padre Supremo desidera da me.\""
  },
  Event_45196_Name = {
    Text = "La \"benedizione\" del Vescovo"
  },
  Event_46144_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 1 di 3 Reliquie d'argento, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_46144_Desc = {
    Text = "La figura indistinta si fa gradualmente nitida, e non è né un Dissoluto né segni di Cataclisma, ma una Clementine dall'aspetto normale, priva di ali.\n\"Che coincidenza, anche tu sei qui a goderti il chiaro di luna?\" dice con un sorriso, e avverti un'ondata di vertigine. \"Nelle notti nebbiose, resta prudente.\nQuei piccoli qui non sembrano molto ben educati.\""
  },
  Event_46144_Name = {
    Text = "Figura Avvolta nella Nebbia"
  },
  Event_46145_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 1 di 3 Reliquie dorate, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_46145_Desc = {
    Text = "Sei rimasto calmo e composto. Una dama di nobiltà si è precipitata improvvisamente sul palcoscenico.\nHa forzato freneticamente la bocca del ragazzo e vi ha conficcato con violenza un bastoncino.\n\"Parla, parlami.\"\nSangue nero sgorgava dalla bocca del ragazzo. Lui continuava a borbottare.\n\"Una canzone per la mamma...\""
  },
  Event_46145_Name = {
    Text = "Fine Ultima III"
  },
  Event_47309_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47309_Desc = {
    Text = "In quel giorno, gli dèi puniranno i Filistei con le loro spade possenti e potenti,\na causa della strage che hanno \"commesso\".\nCosa? Dici che è ingiusto?\nNo, questo è il destino del predatore."
  },
  Event_47309_Name = {
    Text = "Canto dei Marinai"
  },
  Event_47310_ChoiceDesc1 = {
    Text = "[Keep Listening] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_47310_ChoiceDesc2 = {
    Text = "[Andarsene] 1 Carta di comando casuale ottiene l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_47310_Desc = {
    Text = "Dio disse: Chiamatelo Filistea.\nGravatelo del compito della strage, maleditelo con l'avidità.\nFate risplendere il suo cammino, così che gli altri vedano l'abisso come candidi capelli.\nNel vasto oceano, non esiste squalo più grande.\nSia temuto e venerato da tutte le creature,\nfino al giorno in cui il Giudizio giungerà."
  },
  Event_47310_Name = {
    Text = "Canto dei Marinai"
  },
  Event_47311_ChoiceDesc1 = {
    Text = "[Leave] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_47311_ChoiceDesc2 = {
    Text = "[Leave] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_47311_ChoiceDesc3 = {
    Text = "[Leave] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_47311_Desc = {
    Text = "Il ragazzo era un umile schiavo.\nIl suo padrone lo trattava come un figlio, eppure fu pugnalato a morte nel suo letto.\n\"Ti amo, Padre. Semplicemente non voglio più essere uno schiavo.\"\nPiù tardi, il ragazzo si trovò dinanzi alla tomba del suo \"padre\", rievocando le parole del sacerdote:\n<Small:Non abbandonare la terra che ti ha nutrito.\nQuando verrà il momento, le tue mani saranno macchiate di sangue, e morirai senza dignità.\nI cani randagi, gli avvoltoi e i pesci del mare ti disprezzeranno.>\nIl ragazzo di nome Iglenn partì comunque.\nAvrebbe scritto la propria famigerata storia."
  },
  Event_47311_Name = {
    Text = "Il Ragazzo nella Botte"
  },
  Event_47312_ChoiceDesc1 = {
    Text = "[Turn Page Forward] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)], ma sviluppa 1 Sintomo su 3."
  },
  Event_47312_ChoiceDesc2 = {
    Text = "[Turn Page Backward] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando, ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_47312_ChoiceDesc3 = {
    Text = "[Discard] Ricevi 25 Sigilli Neri"
  },
  Event_47312_Desc = {
    Text = "Trovi un libro rilegato in papiro:\n..\nUn ragazzo si nasconde in un barile, alla deriva verso un'isola di Filistea.\nÈ fragile, spregevole e ambizioso.\nQuando la gloria del gigante immortale lascia Tutti in soggezione,\nil ragazzo resta nell'ombra, tenendo quella luce a distanza.\nIn seguito, Golia gli affida un compito importante.\nQuanto al motivo—"
  },
  Event_47312_Name = {
    Text = "Il Ragazzo nella Botte"
  },
  Event_47313_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47313_Desc = {
    Text = "Il gigante allora disse:\n\"Lo tengo al mio fianco perché è al tempo stesso malinconico e comico.\nE non potrà mai uccidermi.\""
  },
  Event_47313_Name = {
    Text = "Il Ragazzo nella Botte"
  },
  Event_47314_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47314_Desc = {
    Text = "\nNon hai udito la parte finale, ma il testo ti ha ricordato un'altra canzone:\n\"Questo raro squalo gigante, tra tempesta e pioggia,\nL'oceano è la sua dimora,\nPoiché il potere è giustizia, esso è il gigante della forza,\nIl re dell'oceano sconfinato.\""
  },
  Event_47314_Name = {
    Text = "Canto dei Marinai"
  },
  Event_47315_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47315_Desc = {
    Text = "Non è il momento adatto per leggere.\nGetti rapidamente il libro da parte, perdendo le ultime righe:\n..\nEgli si nasconde nelle ombre, non per invidia,\nma per puro terrore.\nUna volta nella luce, la sua meschina anima sarà completamente annientata.\nNon resteranno nemmeno le ceneri."
  },
  Event_47315_Name = {
    Text = "Il Ragazzo nella Botte"
  },
  Event_47463_ChoiceDesc1 = {
    Text = "[Enter Hypnosis] Seleziona un Risvegliatore da sottoporre a Scissione Spirituale, perdendo le sue quattro Carte di Comando iniziali."
  },
  Event_47463_Desc = {
    Text = "Il Dottore alzò lo sguardo dalla vasta collezione di libri:\n\"Sei un esemplare raro, perciò non ti farò pagare.\nMa ho bisogno di un'altra forma di compenso: un'ipnosi.\nÈ una nuova forma di terapia che porta a una coscienza senza riserve, completamente nuda.\nAllora, che ne dici? Vuoi provare?\""
  },
  Event_47463_Name = {
    Text = "\"Serpente Ipnotico\""
  },
  Event_47464_ChoiceDesc1 = {
    Text = "[Shining Memory] [ExDesc1][ExDesc2]"
  },
  Event_47464_ChoiceDesc2 = {
    Text = "[Faded Memory] Migliora la qualità dell'Orazione di tutte le Orazioni Ensemble incise."
  },
  Event_47464_Desc = {
    Text = [[
Vaga lungo la spiaggia del Mare della Coscienza.
L'orlo delle onde le lambisce i piedi, trascinando a riva memorie disperse.
Alcune sono luminose, altre fioche, altre ancora portano il profumo della stagione delle piogge di Londinium.
Quale memoria sceglierai di raccogliere? Vaga lungo la spiaggia del Mare della Coscienza.]]
  },
  Event_47464_Name = {
    Text = "\"Fusione del Nucleo\""
  },
  Event_47465_ChoiceDesc1 = {
    Text = "[Rifiutare di provare] 1 Carta di comando casuale ottiene l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_47465_ChoiceDesc2 = {
    Text = "[Smash the Solvent] Purifica una Reliquia Peccaminosa"
  },
  Event_47465_ChoiceDesc3 = {
    Text = "[Accept Experiment] Ottieni [(RelicConfig.Arg1)]"
  },
  Event_47465_Desc = {
    Text = "Il dottore agitò il solvente color smeraldo con eccitazione e le disse:\n\"Bevine un sorso, e entrerai in un Sogno Lucido.\nÈ la manifestazione psichica dell'inconscio collettivo.\nOra, condividerai lo stesso mare di coscienza con innumerevoli esseri.\nVuoi provare?\""
  },
  Event_47465_Name = {
    Text = "\"Sogno Lucido\""
  },
  Event_47466_ChoiceDesc1 = {
    Text = "[Answer Voice] Ottieni 1 Carta di comando dal Risvegliatore di Scissione spirituale."
  },
  Event_47466_Desc = {
    Text = "Il corpo è una gabbia che imprigiona personalità frammentate.\nLa prigione chiamata \"24\" è ormai sovraffollata.\n\"Non addormentarti, non trovare pace.\"\nNell'oscurità, una voce sommessa sussurra."
  },
  Event_47466_Name = {
    Text = "\"Autoconsapevolezza\""
  },
  Event_47848_ChoiceDesc1 = {
    Text = "[Close Your Eyes] Acquisisci 1 tra 3 Reliquie dorate"
  },
  Event_47848_ChoiceDesc2 = {
    Text = "[Sneak a Peek] Risveglia 2 Risvegliatori. Riduci di 1 il Costo di Arithmetica delle loro carte Risveglio."
  },
  Event_47848_ChoiceDesc3 = {
    Text = "[Open Your Eyes] Acquisisci le Reliquie d'argento \"(RelicConfig.Arg1)\", \"(RelicConfig.Arg2)\" e \"(RelicConfig.Arg3)\"."
  },
  Event_47848_Desc = {
    Text = "Prima di iniziare l'ipnosi, il dottore disse:\n\"Non aprire gli occhi senza il mio permesso.\"\nCosì lei tenne gli occhi chiusi, inspirando... espirando...\nIn dormiveglia, le sembrò di udire un sibilo.\nPoi avvertì lo sguardo di occhi gelidi—\nQualcosa la stava osservando.\nDovrebbe sbirciare?"
  },
  Event_47848_Name = {
    Text = "\"Serpente Ipnotico\""
  },
  Event_47876_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47876_Desc = {
    Text = "Si chinò a raccogliere le memorie scintillanti.\nUna, due... innumerevoli gioie la inondarono.\nAprì le braccia e danzò volteggiando tra di esse."
  },
  Event_47876_Name = {
    Text = "\"Fusione del Nucleo\""
  },
  Event_47877_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47877_Desc = {
    Text = "Si chinò a raccogliere i ricordi sbiaditi.\nUno, due... innumerevoli piccoli ricordi si riversarono dentro,\nAprì le braccia e li abbracciò tutti."
  },
  Event_47877_Name = {
    Text = "\"Fusione del Nucleo\""
  },
  Event_47878_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47878_Desc = {
    Text = "Ti rifiuti di diventare vittima di questi bizzarri solventi.\nIl Dottore è alquanto deluso, ma non ti costringe.\n\"Perdono la codardia e la miopia dell'umanità.\""
  },
  Event_47878_Name = {
    Text = "\"Sogno Lucido\""
  },
  Event_47879_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47879_Desc = {
    Text = "Crash! Frantumi la bottiglia.\nLa soluzione verde corrode rapidamente il pavimento.\n\"Be', è stata un'ignoranza avventata. Ma spero che non ci sarà una prossima volta.\nAltrimenti, potrei versare lacrime di tristezza.\""
  },
  Event_47879_Name = {
    Text = "\"Sogno Lucido\""
  },
  Event_47880_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47880_Desc = {
    Text = "L'hai mandata giù d'un fiato.\nGlug, glug... Bolle eruppero nel tuo cervello e nella tua gola.\nCome piccoli fuochi d'artificio scoppiettanti.\n\"Lode a te, coraggioso umano. Avrai la possibilità di sfiorare l'infinito.\nE io ne sarò testimone.\""
  },
  Event_47880_Name = {
    Text = "\"Sogno Lucido\""
  },
  Event_47881_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47881_Desc = {
    Text = "Aprì gli occhi e disse:\n\"Sì, è tutto sbagliato.\nLe lacrime vanno versate, e la Resistenza va opposta.\"\nNell'Oscurità, si udivano fruscii, segnale di una risposta benevola."
  },
  Event_47881_Name = {
    Text = "\"Autoconsapevolezza\""
  },
  Event_47900_ChoiceDesc1 = {
    Text = "[I Saw a Snake] Acquisisci la Reliquia dorata+ [(RelicConfig.Arg1)]"
  },
  Event_47900_ChoiceDesc2 = {
    Text = "[I Saw You] Acquisisci la Reliquia Peccaminosa [(RelicConfig.Arg1)]"
  },
  Event_47900_Desc = {
    Text = "Schiocco.\nUn lieve schiocco di dita la riportò alla realtà.\nIl Dottore, a un certo punto, aveva avvicinato il volto, i suoi occhi giallo cobalto scintillanti di eccitazione.\n\"Dimmi, cosa hai appena visto?\""
  },
  Event_47900_Name = {
    Text = "\"Serpente Ipnotico\""
  },
  Event_47901_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47901_Desc = {
    Text = "Aprì gli occhi.\nNel vago gioco di luci e ombre, le parve di scorgere un placido serpente bianco avvolto nell'Oscurità, che si muoveva lentamente.\nOh, e i suoi occhi —\nOro puro, immacolato.\nNessun dolore, nessuna gioia, nessun Giudizio,\nAbbastanza da svegliare un ghiro da un Incubo di mezza estate."
  },
  Event_47901_Name = {
    Text = "\"Serpente Ipnotico\""
  },
  Event_47909_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47909_Desc = {
    Text = "Aprì silenziosamente un occhio.\nCiò che vide fu una luce bianca sfocata, che si contorceva lentamente nell'oscurità.\nUn tenue bagliore dorato guizzava all'interno della luce, come ad ammonirla per la sua trasgressione.\nNon osò guardare oltre."
  },
  Event_47909_Name = {
    Text = "\"Serpente Ipnotico\""
  },
  Event_47910_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47910_Desc = {
    Text = "Seguì gli ordini del dottore, senza mai aprire gli occhi.\nUna brezza gelida attraversò l'aria intorno a lei, indugiando sul suo volto.\nDopo un po', tutto tornò alla normalità.\nCome se nulla fosse accaduto."
  },
  Event_47910_Name = {
    Text = "\"Serpente Ipnotico\""
  },
  Event_47911_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47911_Desc = {
    Text = "\n\"Ho visto... un serpente molto bello.\"\nIl dottore si fermò un istante, penna in mano.\n\"Che tipo di serpente?\"\n\"È bellissimo! È completamente bianco con motivi dorati...\"\nIl dottore non aggiunse altro, un accenno appena percettibile di sorriso agli angoli della bocca.\n\"Grazie.\""
  },
  Event_47911_Name = {
    Text = "\"Serpente Ipnotico\""
  },
  Event_47912_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47912_Desc = {
    Text = "Fissa dritto negli occhi giallo-cobalto del dottore.\n\"Vedo che ti sei trasformato in un serpente.\"\n\"Oh. Come puoi esserne così sicura che sono io?\"\nPerché è misterioso, immobile e complesso.\nE...\nAppare affaticato, come se si fosse appena risvegliato da un millennio di ibernazione."
  },
  Event_47912_Name = {
    Text = "\"Serpente Ipnotico\""
  },
  Event_47992_ChoiceDesc1 = {
    Text = "[Connect] Recupera Arg2 PV."
  },
  Event_47992_ChoiceDesc2 = {
    Text = "[Meditate] Risveglia un Risvegliato."
  },
  Event_47992_ChoiceDesc3 = {
    Text = "[Expel] Distruggi fino a 3 Carte sintomo e ottieni Arg2 Sigilli Neri."
  },
  Event_47992_Desc = {
    Text = "La nebbia si aggrappa densa mentre il tuo distintivo emette un pallido bagliore argenteo. Il comunicatore crepita, prendendo vita. Qualcuno sta chiamando."
  },
  Event_47992_Name = {Text = "Crocevia"},
  Event_47992_Tips3 = {
    Text = "Al momento non manifesti alcun Sintomo."
  },
  Event_47993_ChoiceDesc1 = {Text = "[Leave]"},
  Event_47993_ChoiceDesc2 = {
    Text = "[Leave] Duplica una Carta di comando casuale e incidi l'Orazione [(EnchantConfig.Arg1)] sulla copia."
  },
  Event_47993_Desc = {
    Text = "Hai accettato una richiesta di contatto dalla scuola. La voce familiare calma la tua mente. Raccogli le forze e prosegui."
  },
  Event_47993_Name = {Text = "Crocevia"},
  Event_48225_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48225_Desc = {
    Text = "Il gatto leccò felicemente il dorso della tua mano.\n\"Grazie. Non preoccuparti per me, miao.\nLe personalità qui muoiono e rinascono di continuo.\nTornerò sicuramente!\nMiao miao, miao miao miao!\""
  },
  Event_48225_Name = {
    Text = "Ultime Parole"
  },
  Event_48226_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48226_Desc = {
    Text = "Il gatto pensa che tu non l'abbia capito, così ti strofina il muso sulla mano.\n\"Se accetti, ti darò tutti i miei snack nascosti.\nSono custoditi al sicuro nel Distretto di Cambre @2...\""
  },
  Event_48226_Name = {
    Text = "Ultime Parole"
  },
  Event_48227_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48227_Desc = {
    Text = "Ti sei scusato sinceramente con George.\n\"Hmph, almeno conosci le buone maniere.\nGeorge prenderà in considerazione di ridurre il potere della maledizione del 10%,\nfino al 15%—quello è il limite di George.\""
  },
  Event_48227_Name = {
    Text = "Fantasma di George"
  },
  Event_48228_ChoiceDesc1 = {
    Text = "[Agree] Acquisisci la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_48228_ChoiceDesc2 = {
    Text = "[Reject It] Acquisisci 1 delle 3 Reliquie d'oro, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_48228_ChoiceDesc3 = {
    Text = "[Stay Silent] Acquisisci la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_48228_Desc = {
    Text = "\n\"Il Gatto 24 è gravemente ferito e, a fatica, cerca di dirti:\n\"Miao... il mio tempo sta per scadere...\nHo un amico, un merluzzo argentato miao.\nSe un giorno lo vedrai, digli che sono andato lontano, miao.\nStarò via per molto, molto tempo, miao.\nGli porterò un sacco di patatine fritte senza pesce fritto, miao.\nDevi dirglielo!\""
  },
  Event_48228_Name = {
    Text = "Ultime Parole"
  },
  Event_48229_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48229_Desc = {
    Text = "Il gatto si sentì un po' deluso.\nMa era sempre stato un micio educato e obbediente, che non forzava mai nessuno.\nAlla fine, chiuse gli occhi con rammarico."
  },
  Event_48229_Name = {
    Text = "Ultime Parole"
  },
  Event_48230_ChoiceDesc1 = {
    Text = "[Apologize to It] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_48230_ChoiceDesc2 = {
    Text = "[Taunt It] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_48230_ChoiceDesc3 = {
    Text = "[Disregard It] Ricevi 25 Sigilli Neri"
  },
  Event_48230_Desc = {
    Text = "Un fantasma, il Fantasma di George, aleggia sopra di te.\n\"George è morto senza dignità.\nMa non importa. George ricorderà sempre questa umiliazione.\nCustode, sei nei guai fino al collo, heh heh heh...\""
  },
  Event_48230_Name = {
    Text = "Fantasma di George"
  },
  Event_48231_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48231_Desc = {
    Text = "\"Hehe, come osi prendere in giro George.\nNon preoccuparti, che tu stia mangiando, dormendo o cantando...\nGeorge fluttuerà sempre intorno a te, per ricordarti e tormentarti.\nCosì che tu ricordi per sempre i tuoi peccati.\nNon catturerai mai un fantasma, la la la~\""
  },
  Event_48231_Name = {
    Text = "Fantasma di George"
  },
  Event_48232_ChoiceDesc1 = {Text = "[Leave]"},
  Event_48232_Desc = {
    Text = "Avanzasti a grandi passi, lasciandoti alle spalle la maledizione di George.\nDa dietro, si udì un singhiozzo; George piangeva a dirotto.\n\"Uuu... come può qualcuno adorabile come me finire per essere—\nDisgusto! Disgusto!\nGeorge preferirebbe morire sotto la frusta di Pandia!\""
  },
  Event_48232_Name = {
    Text = "Fantasma di George"
  },
  Event_49055_ChoiceDesc1 = {
    Text = "[Summon Awakeners] Tutti i Risvegli perdono 100 Aliemus. Distruggi una Carta sintomo."
  },
  Event_49055_ChoiceDesc2 = {
    Text = "[Struggle] Recupera Arg1 HP, ma sviluppa [(Skill.Arg2)] due volte."
  },
  Event_49055_ChoiceDesc3 = {
    Text = "[Harness Silver Key] Perdi tutti i Keyflare."
  },
  Event_49055_Desc = {
    Text = [[
Quando calpesti la pozza tremolante di schizzi di sangue, la sua vera forma si rivela.
Il sangue cremisi-nero protende innumerevoli braccia, aggrappandosi alle tue caviglie e trascinandoti inesorabilmente verso l'abisso insondabile.]]
  },
  Event_49055_Name = {
    Text = "Pozza di Sangue Corrotto"
  },
  Event_49097_ChoiceDesc1 = {
    Text = "[Move Forward]"
  },
  Event_49097_Desc = {
    Text = "Il tuo addome si contorce violentemente, ma miracolosamente si calma dopo pochi secondi. Stranamente, ti sembra di udire un altro battito cardiaco dentro di te..."
  },
  Event_49097_Name = {
    Text = "Madre Nutrice"
  },
  Event_49098_ChoiceDesc1 = {
    Text = "[Bere tutto d'un fiato] Scegli [ExDesc3] [ExDesc4] Carte di comando per ottenere l'Orazione: [(EnchantConfig.Arg1)] [ExDesc1] [ExDesc2]"
  },
  Event_49098_Desc = {
    Text = "Una pentola consunta ti osserva dalla fessura nel basso muro di roccia.\nL'acqua è l'Inventario più prezioso nel deserto; l'alcol è una porta verso la Follia e l'Illusione.\nIn questa terra desolata, sarebbe difficile per qualsiasi persona sana di mente resistere al suo fascino."
  },
  Event_49098_Name = {
    Text = "Madre Nutrice"
  },
  Event_49312_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49312_Desc = {
    Text = "La Chiave d'argento emette un Bagliore; le braccia sembrano intimidite da una qualche forza, ritirandosi nella pozza per poi scomparire."
  },
  Event_49312_Name = {
    Text = "Pozza di Sangue Corrotto"
  },
  Event_49313_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49313_Desc = {
    Text = "Lotti disperatamente, ma sprofondi sempre più, tormentato da Sussurri maledetti nella tua mente.\nQuando riprendi i sensi, i Tentacoli rosso sangue si sono ritirati, soddisfatti. Ti senti stranamente rigenerato, eppure qualcosa sembra perduto per sempre..."
  },
  Event_49313_Name = {
    Text = "Pozza di Sangue Corrotto"
  },
  Event_49314_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49314_Desc = {
    Text = "Il Risvegliatore emerso ti trascina fuori dalla pozza di sangue senza esitazione. Il tuo braccio collegato viene strappato, l'acqua fangosa schizza, e innumerevoli creature appena visibili si contorcono nell'acqua come se bramassero e divorassero qualcosa."
  },
  Event_49314_Name = {
    Text = "Pozza di Sangue Corrotto"
  },
  Event_49867_ChoiceDesc1 = {
    Text = "Un Risvegliato casuale ottiene 50 Aliemus."
  },
  Event_49867_Name = {Text = "Evento"},
  Event_49907_ChoiceDesc1 = {
    Text = "[Ask If They're Real]"
  },
  Event_49907_ChoiceDesc2 = {
    Text = "[Request to Touch]"
  },
  Event_49907_Desc = {
    Text = "\"Perché fissi sempre con curiosità le mie corna? Qualche domanda?\"\nThais si avvicina improvvisamente alla tua spalla, le perline color miele sfiorano delicatamente la tua guancia."
  },
  Event_49907_Name = {Text = "Il Cornuto"},
  Event_49908_ChoiceDesc1 = {Text = "[Look Up]"},
  Event_49908_ChoiceDesc2 = {
    Text = "[Approach Thais]"
  },
  Event_49908_Desc = {
    Text = "La polvere si disperde tra le rovine, e fuori da una finestra rotta, Thais appare all'improvviso. Si appoggia con nonchalance al davanzale polveroso, indicando misteriosamente la trave sopra."
  },
  Event_49908_Name = {
    Text = "Nato nell'Ombra"
  },
  Event_49909_ChoiceDesc1 = {
    Text = "[Leave] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_49909_Desc = {
    Text = "Alzi lo sguardo e vedi tubi di rame arrugginiti che si estendono come una gigantesca ragnatela sopra di te. Un'ombra guizza via: è un gatto randagio in cerca di cibo o un Mostro in agguato nell'oscurità?\nQuando ti volti, Thais è svanita."
  },
  Event_49909_Name = {
    Text = "Nato nell'Ombra"
  },
  Event_49910_ChoiceDesc1 = {
    Text = "[Stare at Her]"
  },
  Event_49910_ChoiceDesc2 = {Text = "[Call Her]"},
  Event_49910_Desc = {
    Text = "Rivedi quel Fantasma.\nQuesta volta, conosci già il suo nome.\nThais è in piedi sotto il lontano Albero Madre, in devota preghiera.\nI suoi contorni erano vaghi, fusi con il Fantasma dell'Albero Madre."
  },
  Event_49910_Name = {
    Text = "Colui che Desidera"
  },
  Event_49911_ChoiceDesc1 = {
    Text = "[Leave] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_49911_Desc = {
    Text = [[
Contempli la figura di Thais, la sua silhouette simile a una vetta solitaria, sacra e maestosa nel cuore della tempesta apocalittica, per nulla sminuita dalla furia della sabbia.
I suoi passi sono lenti eppure saldi, il suo portamento nobile e inviolabile, e ne resti ammaliato.]]
  },
  Event_49911_Name = {
    Text = "L'Immortale"
  },
  Event_49912_ChoiceDesc1 = {
    Text = "[Leave] Duplica una Carta di comando"
  },
  Event_49912_Desc = {
    Text = [[

"Cosa indovini?"
Sussurra "shh," avvicinandosi. Senti la punta del suo corno sfiorarti la guancia, lasciando una sensazione fresca e pungente...]]
  },
  Event_49912_Name = {Text = "Il Cornuto"},
  Event_49913_ChoiceDesc1 = {
    Text = "[Andarsene] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_49913_Desc = {
    Text = [[
"Se vuoi toccare, dillo apertamente. Credi che ti rifiuterei?"
Ridacchia sommessamente mentre prende la tua mano, e il calore e la levigatezza delle sue dita ti fanno sentire quasi in Trance...]]
  },
  Event_49913_Name = {Text = "Il Cornuto"},
  Event_49914_ChoiceDesc1 = {
    Text = "[Leave] Risveglia un Risvegliatore, riduci il Costo di Arithmetica di quella Carta di 1, ma sviluppa [(Skill.Arg1)]."
  },
  Event_49914_Desc = {
    Text = "Ti inginocchi insieme agli altri.\n\"Lo sapevo, lo sapevo! La Regina, Sua Maestà ci ha sempre protetti!\"\nIl suono di pianti gioiosi e lunghi lamenti si mescola all'ululato del vento, risuonando e vibrando attraverso il tuo cranio.\nVagamente, un pensiero cruciale ti attraversa la mente, ma non riesci ad afferrarlo."
  },
  Event_49914_Name = {
    Text = "L'Immortale"
  },
  Event_49915_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 1 di 3 Reliquie d'argento, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_49915_Desc = {
    Text = "Le fai un cenno con la mano.\n\"Che stai facendo?\" Ramona ti guarda con confusione.\n\"Laggiù...\"\nPrima che tu possa finire la frase, la donna in lontananza è già svanita.\nPotrebbe essere un'illusione?"
  },
  Event_49915_Name = {
    Text = "Colui che s'Inchina all'Acqua"
  },
  Event_49916_ChoiceDesc1 = {
    Text = "[Respond to Her]"
  },
  Event_49916_ChoiceDesc2 = {Text = "[Hesitate]"},
  Event_49916_Desc = {
    Text = [[
Da lontano, scorgi una donna che attinge acqua sulla riva del fiume.
Come se avvertisse il tuo sguardo, si volta e ti saluta con un cenno.
Noti qualcosa di insolito nel modo in cui si gira.]]
  },
  Event_49916_Name = {
    Text = "Colui che s'Inchina all'Acqua"
  },
  Event_49917_ChoiceDesc1 = {
    Text = "[Leave] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_49917_Desc = {
    Text = [[
Mentre esiti, la donna si volta e si tuffa nell'oasi, svanendo dalla vista.
Non riesci a credere ai tuoi occhi... Aveva zoccoli di capra?]]
  },
  Event_49917_Name = {
    Text = "Colui che s'Inchina all'Acqua"
  },
  Event_49918_ChoiceDesc1 = {
    Text = "[Leave] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_49918_Desc = {
    Text = "\"O Madre Albero, ascolta la preghiera di @1. Mi bagnerò nel tuo latte e rinascerò, diventando il tuo agente, camminando per te nelle sabbie, permettendo alle tue radici di raggiungere ogni angolo di Remouahe...\"\n\nLe preghiere innocenti che si alternano risuonano in tutto lo spazio."
  },
  Event_49918_Name = {
    Text = "Colui che Desidera"
  },
  Event_49919_ChoiceDesc1 = {
    Text = "[Leave] Risveglia un Risvegliatore casuale"
  },
  Event_49919_Desc = {
    Text = "Lo sguardo ambiguo ed enigmatico di Thais cattura la tua attenzione. Un potere strano e inquietante ti ammalia, come se fossi attratto irresistibilmente verso di lei.\n\"In effetti, ciò che non si vede continua a esistere.\"\nSussurra dolcemente al tuo orecchio. Senti di aver afferrato qualcosa, ma è velato da strati di garza bianca, e resta indistinto.\nÈ forse una sorta di profezia? In un batter d'occhio, Thais svanisce senza lasciare traccia."
  },
  Event_49919_Name = {
    Text = "Nato nell'Ombra"
  },
  Event_49920_ChoiceDesc1 = {Text = "[Gaze]"},
  Event_49920_ChoiceDesc2 = {Text = "[Kneel]"},
  Event_49920_Desc = {
    Text = [[
Gli zoccoli neri delle pecore calpestano la terra sabbiosa.
Thais intona una preghiera sconosciuta, e innumerevoli Aramiti si inginocchiano nella direzione in cui cammina.]]
  },
  Event_49920_Name = {
    Text = "L'Immortale"
  },
  Event_49921_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 1 di 3 Reliquie dorate, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_49921_Desc = {
    Text = [[
L'albero gigantesco estende migliaia di rami spessi, simili a Tentacoli avviluppanti, che legano i polsi e le caviglie di Thais, ignorando i suoi sforzi, e trascinano con forza il suo corpo nel tronco rigonfio dell'albero...

Persino come Illusione lontana, il suo dolore risuona nel tuo cuore attraverso l'acqua increspata.]]
  },
  Event_49921_Name = {
    Text = "Colui che Desidera"
  },
  Event_49922_ChoiceDesc1 = {
    Text = "[Leave] Acquisisci la Reliquia [(RelicConfig.Arg1)]"
  },
  Event_49922_Desc = {
    Text = "\nLe membra flosce scorrono come linfa lungo i rami; lei lotta con tutte le sue forze, eppure il suo corpo si comporta come un verme contorto e barcollante che non vuole obbedire.\n\"Le ossa si sono completamente dissolte,\" un'espressione addolorata si dipinge sui lineamenti di Thais, \"è diventata parte dell'albero.\"\n\"Ci serve il potere di invertire tutto questo... un potere che trascenda il tempo.\""
  },
  Event_49922_Name = {
    Text = "Il Corrotto"
  },
  Event_49923_ChoiceDesc1 = {
    Text = "[Leave] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_49923_Desc = {
    Text = "\"E quell'\"Occhio Invertito Senza Pupilla\"... risveglia qualcosa di profondo, che viene dritto dall'anima...\"\n\"Oh? Parlate di me?\"\n\"Medinet è in estasi per il tuo talento nel raccontare storie.\"\n\nQuella notte, accanto al fuoco che ardeva sommesso, lei ti riempì di nuovo il bicchiere."
  },
  Event_49923_Name = {
    Text = "Il Corrotto"
  },
  Event_49924_ChoiceDesc1 = {
    Text = "[Cut the Tumor]"
  },
  Event_49924_ChoiceDesc2 = {Text = "[Recall]"},
  Event_49924_Desc = {
    Text = "Un tumore arboreo.\nPulsa con un ritmo maligno e tumefatto, e attraverso la sua pelle rosso sangue, fragile e trasparente, si rivela un volto contorto e sofferente, come se stesse per liberarsi dal suo bozzolo.\n\"Medinite.\" Il volto di Thais si velò di pianto mentre chiamava dolcemente il nome di quel volto."
  },
  Event_49924_Name = {
    Text = "Il Corrotto"
  },
  Event_49939_ChoiceDesc1 = {
    Text = "[Trust Ryker] Aumenta l'Aliemus di tutti i Risvegliati di Arg1"
  },
  Event_49939_ChoiceDesc2 = {
    Text = "[Worry About Ryker] Risveglio di 2 Risvegliatori"
  },
  Event_49939_Desc = {
    Text = "\"Mi fido della mia fortuna.\""
  },
  Event_49939_Name = {
    Text = "Detective Fortunato"
  },
  Event_49940_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49940_Desc = {
    Text = "Ryker eccelle in tre cose: ricognizione, ascolto e lancio di dadi.\nIn altre parole, non è abile in battaglia.\nLa tua preoccupazione cresce in modo incontrollabile, e la follia si diffonde."
  },
  Event_49940_Name = {
    Text = "Detective Fortunato"
  },
  Event_49941_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49941_Desc = {
    Text = "Il cuore che crede è magia; egli supererà senza dubbio ogni ostacolo che gli si para dinanzi."
  },
  Event_49941_Name = {
    Text = "Detective Fortunato"
  },
  Event_49943_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49943_Desc = {
    Text = [[
Ti senti in imbarazzo, ma guardi comunque con speranza la malata Ramona.
"Lo faccio io."
Arrossendo, estrae una nuova fiala di raccolta dalla sua borsa a capienza infinita e copre rapidamente il ragno.]]
  },
  Event_49943_Name = {
    Text = "Ragno Velenoso"
  },
  Event_49944_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49944_Desc = {
    Text = "Ryker schiocca le dita, poi tende il suo peloso indice verso un ragno che solleva le zampe anteriori.\nQueste specie dai motivi colorati sono spesso velenose. Stai per avvertirlo, ma il ragno un tempo ostile balza lievemente sulla punta del suo dito e si raggomitola.\nPazienza, il destino è destino."
  },
  Event_49944_Name = {
    Text = "Ragno Velenoso"
  },
  Event_49945_ChoiceDesc1 = {
    Text = "[Look at Ramona] Incidi 1 Orazione su 3"
  },
  Event_49945_ChoiceDesc2 = {
    Text = "[Look at Ryker] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando, ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_49945_Desc = {
    Text = "Molteplici occhi composti si fissano su di te.\nLa creatura indietreggia, mostrando zanne e artigli nel tentativo di intimidirti.\nDalle zampe sollevate e dai pedipalpi, così come dalle due paia di arti che sostengono il corpo, si tratta chiaramente di un raro aracnide.\nLe parole d'addio di Czort risuonano nella tua mente: \"Compito aggiuntivo: raccogliere campioni di specie locali e conservarli presso la stazione di rilevamento locale.\"\nAgiti la bottiglia di raccolta nel tuo zaino, già colma di insetti dopo settimane di cammino."
  },
  Event_49945_Name = {
    Text = "Ragno Velenoso"
  },
  Event_49946_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49946_Desc = {
    Text = "\"L'avidità che ignora il momento giusto è una malattia.\""
  },
  Event_49946_Name = {
    Text = "La tua risposta"
  },
  Event_49947_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49947_Desc = {
    Text = "\"Recitare il copione non ti farà guadagnare alcun affetto, bambina.\""
  },
  Event_49947_Name = {
    Text = "La tua risposta"
  },
  Event_49948_ChoiceDesc1 = {
    Text = "[Golden Key] Acquisisci la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_49948_ChoiceDesc2 = {
    Text = "[Iron Key] Acquisisci 1 delle 3 Reliquie d'oro, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_49948_ChoiceDesc3 = {
    Text = "[Silver Key] Acquisisci la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_49948_Desc = {
    Text = "A mezzogiorno, il vapore del Fiume sacro si condensa in due fantasmi di vuoto.\nUna voce nebulosa dal fantasma ti chiede: È questa la chiave d'oro, la chiave d'argento o la chiave di ferro che hai lasciato cadere?"
  },
  Event_49948_Name = {
    Text = "La tua risposta"
  },
  Event_49949_ChoiceDesc1 = {Text = "[Leave]"},
  Event_49949_Desc = {
    Text = "\"L'onestà conduce spesso a esiti più sicuri, ma al contempo potresti lasciarti sfuggire qualcosa.\""
  },
  Event_49949_Name = {
    Text = "La tua risposta"
  },
  Event_50013_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50013_Desc = {
    Text = "Cerchi di distinguere il volto della persona, ma esso ondeggia con l'acqua, restando sfocato.\n\nPiù ti concentri, più il tuo respiro vacilla, e un senso vertiginoso di mancanza d'ossigeno ti annebbia la mente. Solo quando senti Ramona chiamare il tuo nome riesci a malapena a tornare alla realtà.\nIl riflesso del sole sull'acqua è accecante, ma qualcosa sembra luccicare sotto la superficie."
  },
  Event_50013_Name = {
    Text = "Miraggio della Morte"
  },
  Event_50014_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50014_Desc = {
    Text = "Il Fantasma svanisce all'istante dalle tue mani, lasciando solo un dolore acuto alle tempie.\nIl sole riflesso sull'acqua è accecante, ma qualcosa sembra luccicare sotto la superficie."
  },
  Event_50014_Name = {
    Text = "Miraggio della Morte"
  },
  Event_50015_ChoiceDesc1 = {
    Text = "[Strive to Recognize] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_50015_ChoiceDesc2 = {
    Text = "[Reach out and Touch] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_50015_ChoiceDesc3 = {
    Text = "[Rub Your Eyes] Ricevi 25 Sigilli Neri"
  },
  Event_50015_Desc = {
    Text = "Nubia ti spinge, e metà della tua gamba sprofonda nel Fiume sacro.\nLotti per ritrovare l'equilibrio, ma scorgi un riflesso inatteso nell'acqua increspata.\nÈ un giovane uomo alto in uniforme da Mythag, il corpo esanime sommerso nella corrente del Fiume sacro."
  },
  Event_50015_Name = {
    Text = "Miraggio della Morte"
  },
  Event_50016_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50016_Desc = {
    Text = "Il panico corrode la tua mente, il dolore offusca la tua coscienza. Ti dibatti disperatamente, ma le liane si stringono ancora di più; un muco maleodorante ti penetra nelle narici, ogni respiro intriso di appiccicosa disperazione.\nRamona colpisce. Nubia fugge con un piede mozzato. Strappi l'ultimo Tentacolo aggrappato al tuo volto, ricoperto di carne infangata."
  },
  Event_50016_Name = {
    Text = "Assalto Incombente"
  },
  Event_50017_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50017_Desc = {
    Text = [[
La luce argentea trafigge il corpo di Nubia, e la sensazione della carne che esplode viaggia attraverso la Chiave d'Argento fino alle tue dita e al tuo polso.
Gli arti contorti di Nubia si levano verso il cielo, emettendo uno strido terrificante e lugubre, trasformandosi interamente in un viscoso liquido sconosciuto.]]
  },
  Event_50017_Name = {
    Text = "Assalto Incombente"
  },
  Event_50018_ChoiceDesc1 = {
    Text = "[Tear] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_50018_ChoiceDesc2 = {
    Text = "[Perforazione] 1 Carta di comando casuale ottiene l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_50018_Desc = {
    Text = "I viticci simili a liane di Nubia si contorcono e danzano, cogliendo l'occasione per sferzarti il volto, invadendo violentemente la tua bocca e il tuo naso."
  },
  Event_50018_Name = {
    Text = "Assalto Incombente"
  },
  Event_50019_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50019_Desc = {
    Text = [[
La superficie dell'acqua brilla di riflessi increspati.
Sollevi le gambe inzuppate e versi la sabbia umida fuori dalle scarpe.
L'immagine di prima indugia ancora nella tua mente, rifiutandosi di svanire.]]
  },
  Event_50019_Name = {
    Text = "Miraggio della Morte"
  },
  Event_50029_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50029_Desc = {
    Text = "\"Tornerà? O ti abbandonerà per sempre in questo deserto sconfinato?\"\n\"Riuscirà a trovarti? O i venti mutevoli e le dune gli faranno perdere le tue coordinate?\"\n\"La speranza che riponi negli altri è davvero affidabile?\""
  },
  Event_50029_Name = {
    Text = "Banco Disperso"
  },
  Event_50030_ChoiceDesc1 = {
    Text = "[Seek Rescue] Risveglia un Risvegliatore casuale, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_50030_ChoiceDesc2 = {
    Text = "[Move Forward] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_50030_Desc = {
    Text = "Una voce antica e lontana, mescolata al suono dell'acqua che scorre, ti pone una domanda.\n\"Sei perduto tra sabbie infinite.\"\n\"Hai due scelte. Il tuo compagno viaggia più veloce; lascia che porti cibo e acqua per cercare aiuto, mentre tu resti indietro per ridurre i consumi.\"\n\"Oppure potete dividere tutto e proseguire insieme.\""
  },
  Event_50030_Name = {
    Text = "Banco Disperso"
  },
  Event_50031_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50031_Desc = {
    Text = "\"Forse non potrai andare oltre, ma il tuo spirito e la tua carne sono saldamente legati, e traggono forza l'uno dall'altra.\"\n\"Questa è la tua scelta.\"\nNon appena queste parole vengono pronunciate, il sole ardente in alto chiude il suo occhio."
  },
  Event_50031_Name = {
    Text = "Banco Disperso"
  },
  Event_50064_ChoiceDesc1 = {
    Text = "[Cut the Red Ribbon] Distruggi una Carta di comando e ricevi Arg1 Sigilli Neri."
  },
  Event_50064_ChoiceDesc2 = {
    Text = "[Resist] Duplica una Carta di comando, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_50064_ChoiceDesc3 = {
    Text = "[Call Ramona] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_50064_Desc = {
    Text = "Casiah lancia un nastro di seta rossa, che si avvolge istantaneamente attorno alla tua valigetta."
  },
  Event_50064_Name = {
    Text = "Seta Attorcigliata"
  },
  Event_50065_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50065_Desc = {
    Text = [[
Il picchiettio nitido e intermittente echeggia tra i tubi intrecciati sopra di te, come un fantasma che danza da solo, agitando debolmente le braccia in questo spazio di silenzio mortale.
Questa immagine evoca un antico Terrore Corrosivo nel profondo del tuo essere.]]
  },
  Event_50065_Name = {
    Text = "Scala Inquietante"
  },
  Event_50066_ChoiceDesc1 = {
    Text = "[Explore the Cave Entrance] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_50066_ChoiceDesc2 = {
    Text = "[Deep into the Cave] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_50066_Desc = {
    Text = "\"C'è una grotta qui.\"\nThais ti invita.\n\"Vogliamo entrare?\"\nLa grotta angusta è buia e profonda, simile alle fauci spalancate di un demone gigantesco, che si estendono in un'oscurità senza fine. Chiunque entri in questo luogo desolato non può sfuggire alla sensazione minacciosa che risale lungo la spina dorsale. È come se in ogni angolo, antiche creature che rifuggono la luce del sole stessero in agguato, in attesa degli intrusi."
  },
  Event_50066_Name = {
    Text = "Caverna Oscura"
  },
  Event_50067_ChoiceDesc1 = {
    Text = "[Strike One by One] Potenzia una Reliquia d'argento casuale nella Reliquia dorata [(RelicConfig.Arg1)]"
  },
  Event_50067_ChoiceDesc2 = {
    Text = "[Surround the Two] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_50067_ChoiceDesc3 = {
    Text = "[Eavesdrop] Ricevi 25 Sigilli Neri"
  },
  Event_50067_Desc = {
    Text = [[
Due guardie aramite sorvegliano il cancello della fabbrica.
Una di loro vaga pigramente nei dintorni, attaccando bottone con l'altra.
"Dicono che Lady Juliette stia di nuovo contando le squadre che tentano di sfondare il Muro della Tempesta."
"Spero davvero di non essere selezionato."]]
  },
  Event_50067_Name = {
    Text = "Guardiano Ozioso"
  },
  Event_50067_Tips1 = {
    Text = "Reliquia d'argento non ancora acquisita"
  },
  Event_50068_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50068_Desc = {
    Text = [[
Non guardare, non ascoltare, non pensare.
Senza chiederti da dove provenga quel suono inopportuno, ti dirigi dritto verso i Resti dell'Albero Madre.]]
  },
  Event_50068_Name = {
    Text = "Scala Inquietante"
  },
  Event_50069_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50069_Desc = {
    Text = "Ramona sferra un affondo con la spada contro Casiah, che sta agitando la seta rossa. Casiah schiva in fretta, facendo sì che la seta che ti avviluppa si allenti all'istante."
  },
  Event_50069_Name = {
    Text = "Seta Attorcigliata"
  },
  Event_50070_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50070_Desc = {
    Text = [[
Vi dividete in due gruppi. Tu e Ramona andate a sinistra, Ryker va a destra, attaccando da entrambi i lati.
Dai il segnale, e Ramona e Ryker colpiscono simultaneamente. Le due guardie aramite cadono in silenzio.]]
  },
  Event_50070_Name = {
    Text = "Guardiano Ozioso"
  },
  Event_50071_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50071_Desc = {
    Text = "Non è il momento di addentrarsi nelle trappole. Anche solo sostando all'ingresso della caverna, riesci quasi a percepire il pulsare maligno che throb nelle vene della roccia."
  },
  Event_50071_Name = {
    Text = "Caverna Oscura"
  },
  Event_50072_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50072_Desc = {
    Text = [[
Al tuo segnale, Ryker stende la guardia silenziosa di Aram con un dado, poi si avvicina furtivamente a un altro tizio che sta ancora blaterando.
"Ehi, fratello, e se quella Lady Juliette fosse un'impostora?"
"Non lo so neanch'io."
Ryker sfoggia un ghigno compiaciuto, facendo rabbrividire la guardia. Proprio mentre sta per urlare, Ryker gli copre bocca e naso.]]
  },
  Event_50072_Name = {
    Text = "Guardiano Ozioso"
  },
  Event_50073_ChoiceDesc1 = {
    Text = "[Ascoltare attentamente] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_50073_ChoiceDesc2 = {
    Text = "[Cover Ears] Ricevi 15 Sigilli Neri per ogni Risvegliato con 50 o più Aliemus."
  },
  Event_50073_ChoiceDesc3 = {
    Text = "[Check] Incidi 1 Orazione su 3"
  },
  Event_50073_Desc = {
    Text = "Quando entri nel piano delle Spoglie, un rintocco melodioso risuona bruscamente nella Fabbrica abbandonata e vuota. Il suono limpido del pianoforte contrasta nettamente con le rovine d'acciaio arrugginito."
  },
  Event_50073_Name = {
    Text = "Scala Inquietante"
  },
  Event_50074_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50074_Desc = {
    Text = "\"Ehi, fratello, e se quella Juliette fosse una bugiarda? Tu che ne pensi?\"\n\"Non dire sciocchezze. Da quando Juliette è arrivata, tutto è stato gestito in modo impeccabile. Se fosse una bugiarda, perché aiuterebbe così tanto gli Aramiti?\"\nMentre chiacchierano, Ryker si sposta silenziosamente nella sua posizione d'imboscata e, con un colpo secco, due dadi volano fuori, stendendo entrambi a terra."
  },
  Event_50074_Name = {
    Text = "Guardiano Ozioso"
  },
  Event_50075_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50075_Desc = {
    Text = [[
Trovi il coraggio di ricambiare lo sguardo con fierezza.
L'occhio gigantesco dietro la tenda si contorce in un ghigno orrendo, e la tua irremovibile resistenza vacilla e crolla.]]
  },
  Event_50075_Name = {
    Text = "Occhio Magico"
  },
  Event_50076_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50076_Desc = {
    Text = [[
Squarci la tenda con concentrazione incrollabile.
Sotto la tua mano, l'occhio gigante si trasforma in un pezzo di tessuto piatto e lacerato.]]
  },
  Event_50076_Name = {
    Text = "Occhio Magico"
  },
  Event_50077_ChoiceDesc1 = {
    Text = "[Stare Back] Ottieni la Reliquia d'Oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_50077_ChoiceDesc2 = {
    Text = "[Tear Curtain] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_50077_Desc = {
    Text = [[
Il sipario rivela innumerevoli occhi contorti.
L'essere immenso che si cela dietro di essi emana una fame intensa, pronto a balzare.]]
  },
  Event_50077_Name = {
    Text = "Occhio Magico"
  },
  Event_50078_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50078_Desc = {
    Text = "Si tratta di un componente allungato e abbandonato, smosso dai tuoi movimenti, che oscilla e batte contro il tubo di ferro."
  },
  Event_50078_Name = {
    Text = "Scala Inquietante"
  },
  Event_50079_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50079_Desc = {
    Text = "Thais entra con calma nella grotta, e tu la segui con cautela mentre esplorate.\n\"Attento!\" Vieni tirato indietro all'improvviso e cadi in un morbido abbraccio. Davanti a te, un colosso nero come la pece carica fuori dalla grotta con rapidità ineguagliabile.\n\"Guarda qui,\" dice Thais mentre resti attonito, i suoi occhi brillano debolmente nell'oscurità, \"Potrebbe essere il suo tesoro.\""
  },
  Event_50079_Name = {
    Text = "Caverna Oscura"
  },
  Event_50080_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50080_Desc = {
    Text = "Ti aggrappi disperatamente alla maniglia della valigia, lottando contro la seta rossa.\nMa la seta rossa è di una forza travolgente, facendo scivolare la valigia dalla tua presa e sparpagliando oggetti ovunque."
  },
  Event_50080_Name = {
    Text = "Seta Attorcigliata"
  },
  Event_50081_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50081_Desc = {
    Text = [[
Detesti la sensazione di essere vincolato.
Afferri la seta rossa e la strappi in due con un suono lacerante.
Il pezzo rimanente striscia via come un serpente scarlatto.]]
  },
  Event_50081_Name = {
    Text = "Seta Attorcigliata"
  },
  Event_50276_ChoiceDesc1 = {
    Text = "[Destroy Offering] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_50276_ChoiceDesc2 = {
    Text = "[Sciogliere le Corde] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_50276_ChoiceDesc3 = {
    Text = "[Keep Going] Ricevi 50 Sigilli Neri"
  },
  Event_50276_Desc = {
    Text = "Tre Aramiti erano legati a una piattaforma sopraelevata.\nOscuri motivi simili a corteccia, che avevi già visto sulla pelle dei neonati, apparvero su di loro mentre intonavano incantesimi."
  },
  Event_50276_Name = {
    Text = "Tre Offerte"
  },
  Event_50277_ChoiceDesc1 = {
    Text = "[Stare] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_50277_ChoiceDesc2 = {
    Text = "[Ignore] Incidi 1 Orazione su 3"
  },
  Event_50277_Desc = {
    Text = [[
Gli Aramiti si inginocchiano nella tempesta di sabbia.
La tempesta flagella i loro corpi, e la sabbia inghiotte i loro cuori devoti.
Nella polvere vorticante, innumerevoli occhi giganteschi sembrano scrutare dall'alto la terra distorta.]]
  },
  Event_50277_Name = {
    Text = "Colosso di Polvere"
  },
  Event_50278_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50278_Desc = {
    Text = [[
Le scene che non vuoi ricordare riappaiono davanti ai tuoi occhi.
Tentacoli guizzanti, sangue che trasuda dai tagli provocati da frammenti di vetro...
Senti la nausea salire.]]
  },
  Event_50278_Name = {
    Text = "Viaggio Solitario II"
  },
  Event_50279_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50279_Desc = {
    Text = "Lei non è qui; non è nel mezzo della più pericolosa tempesta.\nQuesto solo dovrebbe darti pace."
  },
  Event_50279_Name = {
    Text = "Viaggio Solitario I"
  },
  Event_50280_ChoiceDesc1 = {
    Text = "[Attacco a sorpresa] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_50280_ChoiceDesc2 = {
    Text = "[Attack] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 3 Carte di comando casuali, ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_50280_Desc = {
    Text = [[
Una Nubia lotta nella feroce tempesta di sabbia.
I suoi quattro zoccoli sono profondamente conficcati nella sabbia gialla, cercando di evitare di essere trascinata nel vortice.]]
  },
  Event_50280_Name = {
    Text = "Tempesta di sabbia naturale"
  },
  Event_50281_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50281_Desc = {
    Text = [[
Ti precipiti dentro, tagliando le corde tra le grida degli Aramiti.
Un guerriero aramita si avvicina; afferri la sua lancia e la punti verso la folla oscura.]]
  },
  Event_50281_Name = {
    Text = "Tre Offerte"
  },
  Event_50282_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50282_Desc = {
    Text = "La ragione ti dice che non tornerà.\nGià, chi si aspetterebbe che un giocatore d'azzardo mantenga la sua promessa?\nNon ti resta altro che la solitudine. Hai solo la solitudine."
  },
  Event_50282_Name = {
    Text = "Viaggio Solitario III"
  },
  Event_50283_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50283_Desc = {
    Text = "La febbre anomala peggiorerà con la Rinascita dell'Albero Madre?\nRamona riuscirà a cavarsela da sola oltre il Muro della Tempesta?\nNon è il momento di distrarsi, ma non puoi fare a meno di preoccuparti per la tua compagna."
  },
  Event_50283_Name = {
    Text = "Viaggio Solitario I"
  },
  Event_50284_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50284_Desc = {
    Text = "Decidi di affrontare la sfida a viso aperto, mentre Nubia sembra trovare un raro appiglio e balza su per aggrapparsi alla tua testa.\nSei intrappolato nel duplice groviglio della tempesta di sabbia e di Nubia.\n\"Il coraggio cieco da solo non è la via della vittoria,\" la voce fredda di William suona come un vangelo angelico alle tue orecchie ostruite. \"Impara a cogliere le opportunità.\""
  },
  Event_50284_Name = {
    Text = "Tempesta di sabbia naturale"
  },
  Event_50285_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50285_Desc = {
    Text = "Non è il momento di leggere il giornale con calma."
  },
  Event_50285_Name = {
    Text = "La Sua Ammonizione"
  },
  Event_50286_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50286_Desc = {
    Text = "Non pensi, non ricordi.\nNon vuoi pensare, non vuoi ricordare.\nLa leggenda di Mythag giungerà al termine, ma il suo viaggio non si fermerà.\nDevi continuare ad andare avanti. Devi continuare ad andare avanti."
  },
  Event_50286_Name = {
    Text = "Viaggio Solitario II"
  },
  Event_50287_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50287_Desc = {
    Text = "\n\"Caro Custode:\nSpero che questa lettera ti trovi in buona salute.\nMi dispiace di non aver potuto restare al tuo fianco durante questo viaggio a Remouahe, a causa della mia negligenza verso il mio corpo.\nMa nei momenti cruciali, ti prego, fidati della tua unica assistente.\nOgni volta che hai bisogno di me, io sono sempre lì.\"\nPer mancanza di tempo, non hai potuto leggere oltre.\nMa la calligrafia familiare ti ha donato una rassicurante sensazione di serenità."
  },
  Event_50287_Name = {
    Text = "La Sua Ammonizione"
  },
  Event_50288_ChoiceDesc1 = {
    Text = "[He'll Be Back] Ottieni la Reliquia d'Argento [(RelicConfig.Arg1)]"
  },
  Event_50288_ChoiceDesc2 = {
    Text = "[He Won't Come] Ottieni la Reliquia d'Oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_50288_Desc = {
    Text = "L'ultimo ad andarsene fu Ryker.\nPer fermare Casiah, scelse di restare nella tenda.\nTi promise che avrebbe sabotato il rituale, bruciato l'Albero Madre, e sarebbe rimasto al tuo fianco.\nMa ora, ancora non è venuto da te.\nLasciandoti completamente solo."
  },
  Event_50288_Name = {
    Text = "Viaggio Solitario III"
  },
  Event_50289_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50289_Desc = {
    Text = [[
Gorgogliando, tre orrori dei turni rotolano nel luogo del rituale.
Ti senti distaccato da te stesso; il fervore morboso del rituale ti inghiotte in un'Illusione indescrivibile.]]
  },
  Event_50289_Name = {
    Text = "Tre Offerte"
  },
  Event_50290_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50290_Desc = {
    Text = "La fede degli Aramiti è così devota che si lasciano seppellire dalla sabbia ancora e ancora.\nMa quando alzi lo sguardo, nella tempesta non c'è alcun sole."
  },
  Event_50290_Name = {
    Text = "Colosso di Polvere"
  },
  Event_50291_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50291_Desc = {
    Text = "Possa il Mare di Sabbia rispondere alla loro devozione."
  },
  Event_50291_Name = {
    Text = "Colosso di Polvere"
  },
  Event_50292_ChoiceDesc1 = {
    Text = "[Break Free from Memories] Potenzia la qualità dell'Orazione di una carta casuale."
  },
  Event_50292_ChoiceDesc2 = {
    Text = "[Catturare i Ricordi] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_50292_Desc = {
    Text = "La seconda persona ad andarsene fu William."
  },
  Event_50292_Name = {
    Text = "Viaggio Solitario II"
  },
  Event_50293_ChoiceDesc1 = {
    Text = "[Calm] Ricevi 25 Sigilli Neri"
  },
  Event_50293_ChoiceDesc2 = {
    Text = "[Worry] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_50293_Desc = {
    Text = "Ricordi all'improvviso il giorno in cui sei partito per il tuo viaggio.\nRamona ti ricordò di preparare i bagagli, William preparò un diario per te, e Ryker infilò di nascosto una bottiglia di whiskey nella tua borsa.\nOra non ci sono più.\n\nLa prima ad andarsene fu Ramona. Il potere di Tawil era in conflitto con l'Autorità del Muro della Tempesta, e lungo il cammino fu sopraffatta da una febbre altissima."
  },
  Event_50293_Name = {
    Text = "Viaggio Solitario I"
  },
  Event_50294_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50294_Desc = {
    Text = "Colpisci il piede di Nubia, facendole perdere l'Equilibrio. I suoi arti simili a liane si agitano freneticamente nell'aria prima di essere travolti dalla tempesta di sabbia."
  },
  Event_50294_Name = {
    Text = "Tempesta di sabbia naturale"
  },
  Event_50295_ChoiceDesc1 = {
    Text = "[Read] Distruggi una Carta"
  },
  Event_50295_ChoiceDesc2 = {
    Text = "[Put Away] Ottieni la Reliquia \"(RelicConfig.Arg1)\", ma sviluppi il Sintomo \"(Skill.Arg2)\"."
  },
  Event_50295_Desc = {
    Text = "Tic-tac.\nSotto questo altare ultraterreno e frenetico, i pesanti colpi di tamburo avanzano con la tempesta di sabbia. Tra il canto incessante, odi il debole suono di una Macchina da scrivere—il richiamo di Mythag, che placa il tuo cuore inquieto."
  },
  Event_50295_Name = {
    Text = "La Sua Ammonizione"
  },
  Event_50296_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50296_Desc = {
    Text = "Ryker ha una fortuna straordinaria.\nSe ti promette qualcosa, manterrà sicuramente la parola.\nSenza alcun dubbio."
  },
  Event_50296_Name = {
    Text = "Viaggio Solitario III"
  },
  Event_50297_ChoiceDesc1 = {Text = "[Leave]"},
  Event_50297_Desc = {
    Text = "Non sono affari tuoi.\nQuello che devi fare ora è avvicinarti rapidamente e distruggere i Resti dell'Albero Madre."
  },
  Event_50297_Name = {
    Text = "Tre Offerte"
  },
  Event_52373_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52373_Desc = {
    Text = "Sei sopravvissuto. Vedi innumerevoli tumuli e corpi carbonizzati.\nSembra che anche tu abbia bruciato qualcosa, ma ormai non ha più importanza.\nOdi le campane del Reame Divino risuonare."
  },
  Event_52373_Name = {
    Text = "Assalto della Pestilenza"
  },
  Event_52374_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52374_Desc = {
    Text = "Sei sopravvissuto. Vedi innumerevoli tumuli e corpi carbonizzati.\nHai combattuto con ferocia per proteggere ciò che avevi caro, pagando un prezzo altissimo. Ma ormai non ha più importanza.\nOdi le campane del Reame Divino risuonare."
  },
  Event_52374_Name = {
    Text = "Assalto della Pestilenza"
  },
  Event_52375_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52375_Desc = {
    Text = "La furia del gigante si è temporaneamente placata. Le nubi si sono diradate e regna la calma. L'oceano, come una madre eterna, accarezza dolcemente il dorso di Lemuria con maree soavi. Tutto ciò che resta su Lemuria sono cadaveri e rovine.\nHai combattuto disperatamente per proteggere ciò che avevi caro, pagando un prezzo altissimo. Ma ormai non ha più importanza.\nNell'oceano, hai intravisto il profilo del Regno Divino."
  },
  Event_52375_Name = {
    Text = "Ruggito dell'Oceano"
  },
  Event_52376_ChoiceDesc1 = {
    Text = "[Offer Additional Sacrifices] Distruggi una Carta di comando e ricevi 1 carta per ciascuno dei 3 tipi di [Illusione del Regno Divino]."
  },
  Event_52376_Desc = {
    Text = "In piedi dinanzi al Trono in rovina di Lemuria, offri il tuo ultimo Tributo.\nL'Abisso senza fine si rivela davanti a te. Ti inginocchi, sorridente, le lacrime che rigano il volto.\n\"Guarda, Padre, Deborah. Contemplate, mio Re supremo: il Reame Divino è disceso dinanzi a me!\""
  },
  Event_52376_Name = {
    Text = "Saluta il Regno Divino"
  },
  Event_52377_ChoiceDesc2 = {
    Text = "[Protect What You Cherish] Perdi Arg1 HP e sviluppi un Sintomo casuale."
  },
  Event_52377_Desc = {
    Text = "Terra. La silenziosa, Irremovibile Terra. Sostiene l'Umanità e perdura in eterno. Ma ora trema, spaccandosi in voragini senza fondo, scuotendo tutto ciò che sorregge.\nHai riposto ogni speranza nella Terra, ma quando essa inizia a tremare, dove andrai?\nSacrificio, il popolo di Lemuria ti invoca. Sacrifica tutto ciò che possiedi per far sorgere un Reame Divino incontaminato."
  },
  Event_52377_Name = {
    Text = "Tremito della Terra"
  },
  Event_52378_ChoiceDesc2 = {
    Text = "[Protect What You Cherish] Perdi Arg1 HP e sviluppi un Sintomo casuale."
  },
  Event_52378_Desc = {
    Text = "Oceano. L'oceano è la madre di Lemuria, la tua vita, la tua fede. Ora, l'oceano si erge come un'irata divinità gigantesca delle leggende. Ruggisce, trasformando acque placide in dura roccia e punte affilate, abbattendosi su tutto ciò che gli sta dinanzi. Osserva con fredda indifferenza Lemuria tremante ai suoi piedi, i Lemuriani che si agitano come insetti. Distruggerà Lemuria, a prescindere dalle azioni di Lemuria.\nSacrificio, gridano i Fanciulli di Lemuria. Sacrificate tutto affinché il Reame Divino possa giungere in pace."
  },
  Event_52378_Name = {
    Text = "Ruggito dell'Oceano"
  },
  Event_52379_ChoiceDesc2 = {
    Text = "[Protect What You Cherish] Perdi Arg1 HP e sviluppi un Sintomo casuale."
  },
  Event_52379_Desc = {
    Text = "La peste. È ovunque. La peste agisce come il più sfrontato dei servitori, dispensando morti indicibili per conto degli dèi, dopo che la loro ira si è abbattuta sulla terra e sul mare. Seppellite i corpi dei morti, bruciate i corpi dei morti, e pregate per coloro che sono morti per proteggervi — teneteli il più lontano possibile. La vita e l'umanità si sgretolano dinanzi alla peste.\nSacrificio, gridano i cittadini di Lemuria. Sacrificate tutto per far sorgere un Regno Divino libero dalla peste."
  },
  Event_52379_Name = {
    Text = "Assalto della Pestilenza"
  },
  Event_52380_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52380_Desc = {
    Text = "Il violento tremore si placò. Le strade erano macchiate di sangue Cremisi, e innumerevoli persone giacevano sepolte sotto le case crollate.\nHai combattuto con ferocia per proteggere ciò che avevi caro, pagando un prezzo altissimo. Ma ormai non ha più importanza.\nL'unica cosa che conta è che sei un passo più vicino al Reame Divino."
  },
  Event_52380_Name = {
    Text = "Tremito della Terra"
  },
  Event_52381_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52381_Desc = {
    Text = "In piedi dinanzi al Trono in rovina di Lemuria, reciti l'ultima Preghiera.\nL'Abisso senza fine si rivela davanti a te. Ti inginocchi, sorridente, le lacrime che rigano il volto.\n\"Guarda, padre, Deborah. Contemplate, mio re supremo: il Reame Divino è disceso dinanzi a me!\""
  },
  Event_52381_Name = {
    Text = "Saluta il Regno Divino"
  },
  Event_52382_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52382_Desc = {
    Text = "Il violento tremore si placò. Le strade erano macchiate di sangue Cremisi, e innumerevoli persone giacevano sepolte sotto le case crollate.\nQualcosa di tuo sembrava essere rimasto sepolto tra le macerie, ma ormai non ha più importanza.\nL'unica cosa che conta è che sei un passo più vicino al Reame Divino."
  },
  Event_52382_Name = {
    Text = "Tremito della Terra"
  },
  Event_52383_ChoiceDesc1 = {Text = "[Leave]"},
  Event_52383_Desc = {
    Text = "La furia del gigante si è temporaneamente placata. Le nubi si sono diradate e regna la calma. L'oceano, come una madre eterna, accarezza dolcemente il dorso di Lemuria con maree soavi. Tutto ciò che resta su Lemuria sono cadaveri e rovine.\nQualcosa di tuo sembra essere andato perduto in mare, ma ormai non ha più importanza.\nNell'oceano, hai intravisto il profilo del Reame Divino."
  },
  Event_52383_Name = {
    Text = "Ruggito dell'Oceano"
  },
  Event_52384_ChoiceDesc1 = {
    Text = "[Devout Prayer] Distruggi tutte le Carte sintomo base nel tuo mazzo. Ricevi altrettante più 2 carte [Illusione del Regno Divino] casuali."
  },
  Event_52384_ChoiceDesc2 = {
    Text = "[Devout Prayer] Distruggi tutte le Carte sintomo base nel tuo mazzo. Ricevi altrettante più 2 carte [Illusione del Regno Divino] casuali."
  },
  Event_52384_Desc = {
    Text = "La terra non trema più, l'oceano non ruggisce più, la peste non invade più. Il Cataclisma ha distrutto Lemuria, lasciando solo te. Ti guardi intorno e ovunque vedi rovine. Guardi le tue mani vuote.\nMa che importa, onorevole Vecchio Sommo Sacerdote? Calpesta le rovine e i cadaveri di Lemuria, e continua a strisciare in avanti.\nSei A un passo dal Regno Divino."
  },
  Event_52384_Name = {
    Text = "Saluta il Regno Divino"
  },
  Event_53140_ChoiceDesc1 = {Text = "[Leave]"},
  Event_53140_Desc = {
    Text = "Hai accettato una richiesta di contatto dalla scuola. La voce familiare calma la tua mente. Raccogli le forze e prosegui."
  },
  Event_53140_Name = {Text = "Crocevia"},
  Event_53141_ChoiceDesc1 = {
    Text = "[Connect] Recupera Arg2 PV."
  },
  Event_53141_ChoiceDesc2 = {
    Text = "[Meditate] Risveglia un Risvegliato."
  },
  Event_53141_ChoiceDesc3 = {
    Text = "[Expel] Distruggi fino a 3 Carte sintomo e ottieni Arg2 Sigilli Neri."
  },
  Event_53141_ChoiceDesc4 = {
    Text = "[Fall into Madness] Risveglia 2 Risvegliatori casuali, ma sviluppi un Sintomo casuale."
  },
  Event_53141_ChoiceDesc5 = {
    Text = "[Hesitation] Altri"
  },
  Event_53141_Desc = {
    Text = "La nebbia si aggrappa densa mentre il tuo distintivo emette un pallido bagliore argenteo. Il comunicatore crepita, prendendo vita. Qualcuno sta chiamando."
  },
  Event_53141_Name = {Text = "Crocevia"},
  Event_53141_Tips3 = {
    Text = "Al momento non manifesti alcun Sintomo."
  },
  Event_53142_ChoiceDesc1 = {Text = "[Leave]"},
  Event_53142_Desc = {
    Text = "Hai accettato una richiesta di contatto dalla scuola. La voce familiare calma la tua mente. Raccogli le forze e prosegui."
  },
  Event_53142_Name = {Text = "Crocevia"},
  Event_53143_ChoiceDesc1 = {Text = "[Leave]"},
  Event_53143_Desc = {
    Text = "Hai accettato una richiesta di contatto dalla scuola. La voce familiare calma la tua mente. Raccogli le forze e prosegui."
  },
  Event_53143_Name = {Text = "Crocevia"},
  Event_53147_ChoiceDesc1 = {
    Text = "[Expel] Distruggi fino a 3 Carte sintomo e ottieni Arg2 Sigilli Neri."
  },
  Event_53147_ChoiceDesc2 = {
    Text = "[Fall into Madness] Risveglia 2 Risvegliatori casuali, ma sviluppi un Sintomo casuale."
  },
  Event_53147_Desc = {
    Text = "La nebbia si aggrappa densa mentre il tuo distintivo emette un pallido bagliore argenteo. Il comunicatore crepita, prendendo vita. Qualcuno sta chiamando."
  },
  Event_53147_Name = {Text = "Crocevia"},
  Event_53147_Tips1 = {
    Text = "Al momento non manifesti alcun Sintomo."
  },
  Event_53148_ChoiceDesc1 = {Text = "[Leave]"},
  Event_53148_Desc = {
    Text = "Stabilisci la connessione. Una Voce, tanto folle quanto inebriante, giunge attraverso il dispositivo.\n\"Ricorda questo: è una Benedizione del Reame Divino.\""
  },
  Event_53148_Name = {Text = "Crocevia"},
  Event_55782_ChoiceDesc1 = {
    Text = "[Cut Through Thorns] Componi Arg1 Immagini [(Skill.Arg2)]. Nella prossima battaglia, i nemici hanno +30% HP e infliggono +15% DAN."
  },
  Event_55782_ChoiceDesc2 = {
    Text = "[Cut Through Thorns] Componi Arg1 Immagini [(Skill.Arg2)]. Nella prossima battaglia, i nemici hanno +30% HP e infliggono +15% DAN."
  },
  Event_55782_ChoiceDesc3 = {
    Text = "[Part the Thorns] Componi Arg1 Immagini \"(Skill.Arg2)\", ma sviluppi il Sintomo \"(Skill.Arg3)\"."
  },
  Event_55782_ChoiceDesc4 = {
    Text = "[Part the Thorns] Componi Arg1 Immagini \"(Skill.Arg2)\", ma sviluppi il Sintomo \"(Skill.Arg3)\"."
  },
  Event_55782_ChoiceDesc5 = {
    Text = "[Leave the Thorns] \"Penna e Inchiostro di Horla\" ottiene Arg1 accumulo/i di \"Inchiostro\"."
  },
  Event_55782_Desc = {
    Text = "Qualcosa ha toccato le corde del tuo cuore. Ti sei fermato e hai fissato l'angolo del giardino. Sotto cumuli di spine, una luce tremola, lottando per liberarsi.\nCos'è? Una Farfalla? Un uccello? Ti avvicini."
  },
  Event_55782_Name = {
    Text = "Benedizione di Muzus"
  },
  Event_55782_Tips1 = {
    Text = "I nemici nella prossima Battaglia sono stati potenziati e non possono essere scelti di nuovo."
  },
  Event_55783_ChoiceDesc1 = {
    Text = "[Create Offering] Scegli 3 carte Immagine e lascia che Horla crei un'[Offerta] per te."
  },
  Event_55783_ChoiceDesc2 = {Text = "[Leave]"},
  Event_55783_Desc = {
    Text = "Giungi a una splendida serra e guardi all'interno attraverso la finestra, ma non vedi nulla.\nUna folata di vento soffia, agitando i petali e le foglie all'interno. Tra i fiori e le foglie, scorgi la figura di una ragazza.\n\"Ah! Un ospite nel giardino!\" La ragazza ti guarda con sorpresa e nervosismo. \"Mi dispiace, Colette è uscita... Non conosco i prezzi di questi fiori...\"\nLa ragazza si ferma all'improvviso, si avvicina e ti osserva attentamente. \"Ah, caro ospite, percepisco un'immagine poetica in te... Forse potremmo comporre una poesia insieme?\""
  },
  Event_55783_Name = {
    Text = "Dono della Primavera"
  },
  Event_55783_Tips1 = {
    Text = "Immagini insufficienti. Ne sono necessarie almeno 3."
  },
  Event_55799_ChoiceDesc1 = {Text = "[Leave]"},
  Event_55799_Desc = {
    Text = "Le spine viventi sembrano irrequiete, ma questi costi sono irrisori— in quella scintilla di luce, odi il richiamo della Musa."
  },
  Event_55799_Name = {
    Text = "Benedizione di Muzus"
  },
  Event_55819_ChoiceDesc1 = {
    Text = "[Follow the Body's Memory] Salta la battaglia e ottieni una vittoria immediata, ma perdi Arg1 PV."
  },
  Event_55819_ChoiceDesc2 = {
    Text = "[Leave] Entra in Battaglia"
  },
  Event_55819_Desc = {
    Text = "Di fronte a nemici familiari, conosci già bene la Battaglia imminente."
  },
  Event_55819_Name = {
    Text = "Memoria Muscolare"
  },
  Event_55997_ChoiceDesc1 = {Text = "[Leave]"},
  Event_55997_Desc = {
    Text = "Hai selezionato alcune delle immagini raccolte e le hai consegnate alla ragazza.\n\"Che immagini meravigliose! Stimato ospite, attenda un momento... Ecco. Questa è un'offerta unica della primavera, esclusivamente per lei!\"\nUna poesia si materializzò nella tua mano, come un fiore che sboccia solo per te.\nVolevi ringraziare la ragazza, ma quando alzasti lo sguardo, la sua figura era già svanita. Nella serra desolata, restavano solo fiori e foglie appassite.\n—Le ceneri lasciate dopo l'incendio della primavera."
  },
  Event_55997_Name = {
    Text = "Dono della Primavera"
  },
  Event_55999_ChoiceDesc1 = {Text = "[Leave]"},
  Event_55999_Desc = {
    Text = "Le spine fitte ti fanno esitare. Lasci il punto di luce, ma il breve sguardo riempie comunque il tuo cuore di nuova Ispirazione— in quel punto, odi il richiamo della Musa."
  },
  Event_55999_Name = {
    Text = "Benedizione di Muzus"
  },
  Event_56000_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56000_Desc = {
    Text = "Scosti le spine con la mano, riportando ferite lievi, ma il prezzo è trascurabile—in quel punto di luce, odi il richiamo della Musa."
  },
  Event_56000_Name = {
    Text = "Benedizione di Muzus"
  },
  Event_56024_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56024_Desc = {
    Text = [[
Non basta... Continui verso la luce. Le spine si agitano, rivelando le loro punte affilate. Ma ne vale la pena.
La luce si disperde dal tuo palmo, e nel bagliore dello schermo luminoso, senti chiaramente la benedizione di Muzus.]]
  },
  Event_56024_Name = {
    Text = "Benedizione di Muzus"
  },
  Event_56025_ChoiceDesc1 = {
    Text = "[Approach Light Points] Potenzia una carta Immagine. Nella prossima battaglia, i nemici hanno +30% HP e infliggono +15% DAN."
  },
  Event_56025_ChoiceDesc2 = {Text = "[Leave]"},
  Event_56025_Desc = {
    Text = "Hai usato i tuoi strumenti per tagliare le spine. Le spine viventi sembravano irrequiete, ma il prezzo era trascurabile— in quel punto luminoso, hai udito il richiamo della Musa."
  },
  Event_56025_Name = {
    Text = "Benedizione di Muzus"
  },
  Event_56146_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56146_Desc = {
    Text = [[
Non basta... Ti avvicini alla luce. Spine affilate ti perforano la mano, facendo scorrere il sangue senza sosta. Ma ne vale la pena.
La luce si disperde dal tuo palmo, e nel bagliore dello schermo luminoso, senti chiaramente la benedizione di Muzus.]]
  },
  Event_56146_Name = {
    Text = "Benedizione di Muzus"
  },
  Event_56147_ChoiceDesc1 = {
    Text = "[Creative Impulse] Tutti i Risvegliatori perdono tutto l'Aliemus. Scegli 3 carte Immagine e lascia che Horla crei un'[Offerta] per te."
  },
  Event_56147_ChoiceDesc2 = {Text = "[Leave]"},
  Event_56147_Desc = {
    Text = "Hai accettato una richiesta di contatto dalla scuola. La voce familiare calma la tua mente. Raccogli le forze e prosegui."
  },
  Event_56147_Name = {Text = "Crocevia"},
  Event_56147_Tips1 = {
    Text = "Immagini insufficienti. Ne sono necessarie almeno 3."
  },
  Event_56148_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56148_Desc = {
    Text = "La luce argentea sull'emblema risveglia le tue emozioni. Seguendo la guida del tuo cuore, getti ciò che hai tra le spine. La luce sottostante comincia a risplendere — in quella luce, ottieni nuova ispirazione."
  },
  Event_56148_Name = {Text = "Crocevia"},
  Event_56149_ChoiceDesc1 = {
    Text = "[Approach Light Points] Potenzia una carta Immagine, ma riduci i tuoi HP massimi del 10%."
  },
  Event_56149_ChoiceDesc2 = {Text = "[Leave]"},
  Event_56149_Desc = {
    Text = "Scosti le spine con la mano, riportando ferite lievi, ma il prezzo è trascurabile—in quel punto di luce, odi il richiamo della Musa."
  },
  Event_56149_Name = {
    Text = "Benedizione di Muzus"
  },
  Event_56149_Tips1 = {
    Text = "Quell'Immagine non può essere potenziata."
  },
  Event_56150_ChoiceDesc1 = {Text = "[Leave]"},
  Event_56150_Desc = {
    Text = "La luce argentea sull'emblema suscita le tue emozioni. Senti un forte impulso a trascrivere il poema nella tua mente."
  },
  Event_56150_Name = {Text = "Crocevia"},
  Event_56151_ChoiceDesc1 = {
    Text = "[New Inspiration] Distruggi una carta Immagine e potenzia una carta Immagine casuale."
  },
  Event_56151_ChoiceDesc2 = {Text = "[Leave]"},
  Event_56151_Desc = {
    Text = "Hai accettato una richiesta di contatto dalla scuola. La voce familiare calma la tua mente. Raccogli le forze e prosegui."
  },
  Event_56151_Name = {Text = "Crocevia"},
  Event_56151_Tips1 = {
    Text = "Immagini insufficienti"
  },
  Event_57738_ChoiceDesc1 = {
    Text = "[Forceful Entry] Aumenta l'Aliemus di tutti i Risvegliati di 30, ma aggiungi due carte [(Skill.Arg1)] al mazzo."
  },
  Event_57738_ChoiceDesc2 = {
    Text = "[Disarm] I nemici nella prossima battaglia hanno il 60% di PV in più e infliggono il 30% di DAN in più."
  },
  Event_57738_ChoiceDesc3 = {
    Text = "[Ambush] Tutti i Risvegliati perdono tutto l'Aliemus; ricevi 30 Sigilli Neri."
  },
  Event_57738_Desc = {
    Text = [[
Sbirci dal punto cieco all'angolo. Gli Agenti del Comitato stanno guardando in un'altra direzione, ignari della tua presenza.
Memorie dell'addestramento passato ti balenano nella mente, e trovi rapidamente un modo per affrontare i nemici che bloccano il tuo cammino.]]
  },
  Event_57738_Name = {
    Text = "Agente del Comitato"
  },
  Event_57738_Tips3 = {
    Text = "Nessun Risvegliato possiede Aliemus."
  },
  Event_57739_ChoiceDesc1 = {Text = "[Leave]"},
  Event_57739_Desc = {
    Text = [[
Hai osservato con attenzione. Gli Agenti del Comitato ti sbarravano la strada, sorvegliando diligentemente l'area.
Di fronte a numerosi nemici, non potevi combatterli.
Avanzare o ritirarsi?]]
  },
  Event_57739_Name = {
    Text = "Punto di Detenzione"
  },
  Event_57776_ChoiceDesc1 = {Text = "[Leave]"},
  Event_57776_ChoiceDesc2 = {
    Text = "[Feign Surrender] Dopo aver esplorato quest'area, vieni trasferito al Punto di Detenzione e sviluppi due Sintomi casuali."
  },
  Event_57776_ChoiceDesc3 = {
    Text = "[Intrude] Dopo aver esplorato quest'area, vieni trasferito al Punto di Detenzione e perdi Arg1 HP."
  },
  Event_57776_Desc = {
    Text = [[
Hai osservato con attenzione. Gli Agenti del Comitato ti sbarravano la strada, sorvegliando diligentemente l'area.
Di fronte a numerosi nemici, non potevi combatterli.
Avanzare o ritirarsi?]]
  },
  Event_57776_Name = {
    Text = "Punto d'Osservazione"
  },
  Event_57776_Tips3 = {
    Text = "Non hai abbastanza HP."
  },
  Event_59193_ChoiceDesc1 = {
    Text = "[Alistair's Blessing] Aggiungi 1 [Bagliore Polare] al tuo mazzo."
  },
  Event_59193_Desc = {
    Text = "Il certificato di ammissione giaceva in fondo alla tua valigia. Ne accarezzasti delicatamente la cornice squisita, che pareva orlata dal bagliore persistente delle stelle, mentre inalavi il tenue profumo d'inchiostro peculiare di quella carta. L'Emblema di Mythag brillava come un radioso portale verso il futuro, catturando i tuoi occhi bramosi — proprio come quel giorno, proprio come oggi."
  },
  Event_59193_Name = {
    Text = "Cerimonia d'Immatricolazione"
  },
  Event_59527_ChoiceDesc1 = {
    Text = "Scegli una Carta per comprendere l'Orazione \"Lex Nous\". \"Lex Nous\": Dopo averla giocata, pesca 2 carte; il loro Costo di Arithmetica riduce il Costo di Arithmetica effettivo delle carte Orazione, e ha effetto solo una volta per battaglia."
  },
  Event_59527_Desc = {
    Text = "Il simbolo della conoscenza è inciso sul tuo documento.\nI pensieri di Tawil fluiscono nella tua mente. Tra le infinite possibilità, ti stai dirigendo verso l'unico vero cammino."
  },
  Event_59527_Name = {
    Text = "Cerimonia d'Immatricolazione"
  },
  Event_59528_ChoiceDesc1 = {
    Text = "Scegli una Carta per comprendere l'Orazione \"Lex Volis\". \"Lex Volis\": Dopo averla giocata, scarta tutte le carte diverse da questo Risveglio e ottieni 5 carte casuali non-Risveglio. Questo effetto è attivo solo una volta per battaglia."
  },
  Event_59528_Desc = {
    Text = "Il simbolo della gioia è inciso sul tuo documento.\nAttraverso il marchio, N ti sta osservando. Si aspetta che tu porti a compimento un esito che Egli non ha mai menzionato con leggerezza."
  },
  Event_59528_Name = {
    Text = "Cerimonia d'Immatricolazione"
  },
  Event_59529_ChoiceDesc1 = {
    Text = "Seleziona una Carta per comprendere l'Orazione \"Lex Genis\". \"Lex Genis\": Quando giocata, ottieni 3 Copie Base aggiuntive con \"Conservare\" ed \"Esaurimento\", efficace solo una volta per battaglia."
  },
  Event_59529_Desc = {
    Text = "Il simbolo della propagazione è inciso sul tuo documento.\nThais ripone le Sue speranze in te, e coesisterà con te in ogni mondo."
  },
  Event_59529_Name = {
    Text = "Cerimonia d'Immatricolazione"
  },
  Event_59566_ChoiceDesc1 = {
    Text = "[Asciugare le lacrime di Sangue] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_59566_ChoiceDesc2 = {
    Text = "[Eyes Open] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 3 Carte di comando casuali, ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_59566_Desc = {
    Text = [[
Innumerevoli desideri si fondono. Un tempo condividevate la stessa origine, e ora condividete lo stesso corpo.
Innumerevoli occhi si aprono insieme, affrontando il grande occhio.
Innumerevoli occhi si frantumano insieme, versando lacrime di sangue secco.]]
  },
  Event_59566_Name = {
    Text = "Fusione degli Io"
  },
  Event_59567_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59567_Desc = {
    Text = "Cerchi di discutere con la voce folle, confutando l'ideologia del vuoto.\n\"Tutto muore, questo rende la vita priva di significato?\"\nDiscuti con veemenza, ma le risate persistono, deridendo la tua stupidità."
  },
  Event_59567_Name = {
    Text = "Agnelli al Macello"
  },
  Event_59568_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59568_Desc = {
    Text = [[
Fissi il portale, incapace di sopportare l'angoscia dell'ignoranza.
Brami vedere cosa si cela oltre.
Il portale illusorio ondeggia ipnoticamente, balenando con fugaci visioni di innumerevoli mondi.
Senza il tempo di comprendere, un'ondata infinita di informazioni inonda il tuo spirito, riempiendo la tua mente di un rumore caotico.]]
  },
  Event_59568_Name = {
    Text = "Oltre il portale"
  },
  Event_59569_ChoiceDesc1 = {
    Text = "[Firm Command] Risveglia un Risvegliatore casuale, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_59569_ChoiceDesc2 = {
    Text = "[Joint Discussion] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_59569_Desc = {
    Text = "Tutto è accaduto così all'improvviso. Una nebbia ti avvolge e, nonostante i tuoi sforzi di guardarti intorno, non riesci a distinguere nulla.\nI Risvegliati attendono i tuoi ordini.\nOra, Isolato, devi fare affidamento sul tuo stesso Potere."
  },
  Event_59569_Name = {
    Text = "Sguardo dell'Ignoranza"
  },
  Event_59570_ChoiceDesc1 = {
    Text = "[With Sacrifice] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_59570_ChoiceDesc2 = {
    Text = "[Con Coraggio] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_59570_ChoiceDesc3 = {
    Text = "[With Direct Stare] Ricevi 50 Sigilli Neri"
  },
  Event_59570_Desc = {
    Text = [[
Innumerevoli versioni di te si ergono in innumerevoli mondi, spalla a spalla, mano nella mano, come fratelli.
Ora siete tutti sotto la grande Ombra, a testa alta, senza indietreggiare di un solo passo.
Che fare?
Come puoi sconfiggere quell'ultima versione di te stesso?]]
  },
  Event_59570_Name = {
    Text = "Risposta a sé stessi"
  },
  Event_59571_ChoiceDesc1 = {
    Text = "[Seek Answers] Ricevi Arg1 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_59571_ChoiceDesc2 = {
    Text = "[Give Up] Ricevi 25 Sigilli Neri e vattene."
  },
  Event_59571_Desc = {
    Text = [[
Attraversando il fantasma del Portale, innumerevoli esperienze di te stesso riaffiorano nella tua mente.
Alcuni morirono, alcuni impazzirono, alcuni perseverarono, altri caddero.
Innumerevoli sentieri e scelte ti scorrono davanti, e sembra che tu viva una lunga, interminabile esistenza in un istante.
Ora innumerevoli menti e bocche operano simultaneamente.
Tenti di conversare con innumerevoli versioni di te stesso attraverso il tempo e lo spazio, cercando risposte nei ricordi infiniti.]]
  },
  Event_59571_Name = {
    Text = "La Mia Domanda"
  },
  Event_59572_ChoiceDesc1 = {
    Text = "[Exchange Power] Incidi l'Orazione [(EnchantConfig.Arg1)] su una Carta di comando casuale."
  },
  Event_59572_ChoiceDesc2 = {
    Text = "[Exchange Fortune] Aumenta gli HP massimi di Arg1, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_59572_Desc = {
    Text = [[
Ogni scelta ha un prezzo.
Vita, spirito, emozione, memoria...
Cosa desideri scambiare con il destino, e cosa porrai sulla bilancia?]]
  },
  Event_59572_Name = {
    Text = "Scelta del Destino"
  },
  Event_59573_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59573_Desc = {
    Text = "Come si può vivere senza un cuore?\nCerchi freneticamente tutt'intorno, il tuo respiro si fa più affannoso ad ogni istante che passa, la paura della morte che offusca la tua mente.\n\"Non riesco a respirare... Il mio cuore si sta fermando...\"\nAspetta, ti rendi conto che non hai più bisogno del battito cardiaco.\nFinalmente comprendi e ridi di gioia."
  },
  Event_59573_Name = {
    Text = "Petto Vuoto"
  },
  Event_59574_ChoiceDesc1 = {
    Text = "[Peer] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_59574_ChoiceDesc2 = {
    Text = "[Evade] Risveglia 2 Risvegliatori casuali, ma sviluppa [(Skill.Arg1)] due volte."
  },
  Event_59574_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_59574_Desc = {
    Text = [[
Avverti una presenza nel vuoto che ti osserva.
Ovunque tu vada, quello sguardo ti segue come un'ombra.
Ti senti una piccola preda presa di mira, e la schiena comincia a dolerti come se fosse trafitta da aghi.]]
  },
  Event_59574_Name = {
    Text = "Il Suo Sguardo"
  },
  Event_59575_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59575_Desc = {
    Text = "Imperturbabile di fronte all'esibizione caotica, mantieni Irremovibile il tuo ritmo.\nGli attacchi e le tentazioni dell'avversario si rivelano inefficaci. Due melodie vengono suonate simultaneamente al pianoforte, e chi resiste fino alla fine padroneggerà tutte le note."
  },
  Event_59575_Name = {
    Text = "Rapsodia dell'Apocalisse"
  },
  Event_59576_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59576_Desc = {
    Text = "Con tutto il vostro coraggio, qualunque cosa accada, continuerete ad andare avanti al fianco dei vostri compagni."
  },
  Event_59576_Name = {
    Text = "Futuro Cristallizzato"
  },
  Event_59577_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59577_Desc = {
    Text = "\"Dove sei ora?\"\n\"Cosa stanno pianificando i maestri?\"\n\"Cosa dovrei fare dopo?\"\nChiedi ansiosamente, sperando di poter contare su quella presenza affidabile come sempre.\nIl comunicatore si blocca e perde la risposta. Scuoti il dispositivo, e le parole sulla risposta si contorcono in uno sciame di farfalle, svolazzando sul tuo viso.\nTi strofini gli occhi, rendendoti conto che è solo un fantasma.\nIl foglio di risposta è bianco."
  },
  Event_59577_Name = {
    Text = "Eco del Delirio"
  },
  Event_59578_ChoiceDesc1 = {
    Text = "[Panic Search] Aumenta gli HP massimi di Arg1"
  },
  Event_59578_ChoiceDesc2 = {
    Text = "[Tentare di riempire] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_59578_Desc = {
    Text = "Avverti un vuoto e una leggerezza nel petto. Abbassando lo sguardo, vedi che si è aperto come una serratura.\nIl tuo cuore è scomparso."
  },
  Event_59578_Name = {
    Text = "Petto Vuoto"
  },
  Event_59579_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59579_Desc = {
    Text = "Metti in discussione ad alta voce le sue intenzioni, ma ricevi soltanto un sorriso immutato.\n\nHa abbandonato il mondo da tempo. Un individuo distaccato non porta alcuna responsabilità.\nLa tua resistenza è vana."
  },
  Event_59579_Name = {
    Text = "Gentiluomo Folle"
  },
  Event_59580_ChoiceDesc1 = {
    Text = "[Disrupt Rhythm] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_59580_ChoiceDesc2 = {
    Text = "[Self-Preservation] Incidi 1 Orazione su 3"
  },
  Event_59580_Desc = {
    Text = [[
Suoni come se fossi accompagnato da una folle, lei ti lega ai tasti, trascinandoti nella sua melodia frenetica.
Fatichi a tenere il passo con il suo ritmo, procedendo a tentoni.
Lotti per prendere il controllo della melodia.]]
  },
  Event_59580_Name = {
    Text = "Rapsodia dell'Apocalisse"
  },
  Event_59581_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59581_Desc = {
    Text = "Desideri un potere senza pari per infrangere ogni catena e barriera.\nTuttavia, la forza umana ha i suoi limiti. Sfidare gli dèi con un corpo fragile finirà per consumare la tua vita come un fiammifero."
  },
  Event_59581_Name = {
    Text = "Scelta del Destino"
  },
  Event_59582_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59582_Desc = {
    Text = "\"Sparito... Tutto sparito...\"\nTi senti vuoto e raccogli un orologio da tasca, una mela e una giacca scolastica per colmare il vuoto.\nIl tuo petto si sente di nuovo pieno, anche se fin troppo.\nVa bene così; le cose non sono mai perfette."
  },
  Event_59582_Name = {
    Text = "Petto Vuoto"
  },
  Event_59583_ChoiceDesc1 = {
    Text = "[Persuade] Ricevi 25 Sigilli Neri"
  },
  Event_59583_ChoiceDesc2 = {
    Text = "[Question] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_59583_Desc = {
    Text = "Le scarpe di N si fermano davanti a te, un sorriso distorto sul suo viso scuro.\nVeste sempre in modo impeccabile, ma sotto quella facciata da gentiluomo si cela pura follia.\nNon ha amici, e pochi nemici.\nPerché scompaiono tutti nel modo più teatrale.\nSfortunatamente, ora sei la sua prossima protagonista.\nPreparazione della tua battuta d'apertura. Come soddisferai questo pubblico così esigente?"
  },
  Event_59583_Name = {
    Text = "Gentiluomo Folle"
  },
  Event_59584_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59584_Desc = {
    Text = "I Risvegliatori non ne sanno molto più di te, ma sono da tempo i tuoi compagni più leali, camerati e sostegno.\nDiscuti strategie con i Risvegliatori. Sebbene ancora incerti, trovate tutti il coraggio di andare avanti."
  },
  Event_59584_Name = {
    Text = "Sguardo dell'Ignoranza"
  },
  Event_59585_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59585_Desc = {
    Text = [[
Come a consolidare la tua determinazione, rispondi con voce forte e ferma.
La tua voce riverbera tra innumerevoli bolle, come se innumerevoli versioni di te stesso stessero pronunciando il giuramento insieme.
Ora sei pronto ad affrontare ogni cosa.]]
  },
  Event_59585_Name = {
    Text = "La Sua Inquisizione"
  },
  Event_59586_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59586_Desc = {
    Text = "Restate immobili, fissando intensamente le parole sulla risposta.\nSotto il vostro Sguardo, le parole sfumano e si contorcono gradualmente, trasformandosi in farfalle che svolazzano verso il vostro volto.\nAgitate le mani per scacciarle, solo per scoprire che il foglio di risposta è ora completamente bianco.\nIn effetti, i sogni troppo belli per essere veri sono sempre falsi."
  },
  Event_59586_Name = {
    Text = "Eco del Delirio"
  },
  Event_59587_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59587_Desc = {
    Text = [[
Detesti questi fili spregevoli.
Li tiri con tutte le tue forze; alcuni si spezzano, mentre innumerevoli altri si aggrovigliano di nuovo.
Esaurisci ogni energia nella lotta contro di essi.]]
  },
  Event_59587_Name = {
    Text = "Mani Burattino"
  },
  Event_59588_ChoiceDesc1 = {
    Text = "[Abbattere le ombre] Scegli 1 tra 3 Carte di comando e ottieni Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_59588_ChoiceDesc2 = {
    Text = "[Schiacciare l'Embrione] Scegli 1 tra 3 Carte di comando e ottieni Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_59588_ChoiceDesc3 = {
    Text = "[Close Your Eyes] Ricevi 25 Sigilli Neri"
  },
  Event_59588_Desc = {
    Text = [[
In uno stato confuso, vedi persone che hai incontrato ad Aram avvicinarsi a te.
Ridono e ti invitano a bere, danzare e goderti il banchetto.
Poi la loro carne inizia a staccarsi strato dopo strato, cadendo a terra e contorcendosi in nuovi Embrioni.
Ti tendono le mani, invitandoti a unirti alla celebrazione della carne e della rinascita.]]
  },
  Event_59588_Name = {
    Text = "Ombre del Passato"
  },
  Event_59589_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59589_Desc = {
    Text = [[
Prima di allungare la mano, ricordi improvvisamente di non aver mai posseduto un gatto simile.
Tu e il gatto incrociate gli sguardi attraverso l'aria, e lui sbatte le palpebre verso di te.
Al gatto non importa della tua indifferenza; sembra amarti comunque allo stesso modo.]]
  },
  Event_59589_Name = {
    Text = "Fascino Felino"
  },
  Event_59590_ChoiceDesc1 = {
    Text = "[Embed] Trasforma una Reliquia nella Reliquia maledetta [(RelicConfig.Arg1)]"
  },
  Event_59590_ChoiceDesc2 = {
    Text = "[Swallow] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_59590_ChoiceDesc3 = {
    Text = "[Store] Ricevi 25 Sigilli Neri"
  },
  Event_59590_Desc = {
    Text = [[
Il potere dei tre Eoni dentro di te si sta fondendo, e fai fatica a controllarlo.
Il tuo reame spirituale continua a espandersi mentre una galassia nasce e si diffonde.
Di fronte a un'ondata infinita di nemici, preghi sinceramente questo cielo stellato, augurandoti il suo aiuto.
Una stella cade dalla galassia nel palmo della tua mano, irradiando un bagliore incantevole.]]
  },
  Event_59590_Name = {
    Text = "Stella dei Desideri"
  },
  Event_59591_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59591_Desc = {
    Text = "Rispondi con il silenzio. Nessuna parola viene scambiata; il silenzio è la risposta.\nSei pronto ad affrontare ogni cosa."
  },
  Event_59591_Name = {
    Text = "La Sua Inquisizione"
  },
  Event_59592_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59592_Desc = {
    Text = "Quel gatto è un bugiardo?\nInizi a dubitare di quegli occhi blu profondi come pozze, mentre risate echeggiano intorno a te.\n\"Bugiardo, bugiardo, sei stato ingannato!\"\nUn senso di inquietudine affiora dentro di te."
  },
  Event_59592_Name = {
    Text = "Sussurro segreto"
  },
  Event_59593_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59593_Desc = {
    Text = "Come un osservatore, guardi in silenzio le emozioni che diventano gradualmente estranee.\nReprimi ogni desiderio residuo e senti la tua anima farsi fredda.\nQuesto è il tuo destino, il cammino che ti è stato assegnato."
  },
  Event_59593_Name = {
    Text = "Emozione Cristallizzata"
  },
  Event_59594_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59594_Desc = {
    Text = "Quel volto sorridente resta impassibile; né le tue argomentazioni logiche né i tuoi appelli emotivi riescono a smuoverlo.\nI desideri umani non lo riguardano.\nPossono le tue parole trascendere i limiti dell'immaginazione umana?"
  },
  Event_59594_Name = {
    Text = "Gentiluomo Folle"
  },
  Event_59595_ChoiceDesc1 = {
    Text = "[Answer] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_59595_ChoiceDesc2 = {
    Text = "[Remain Silent] Risveglia 2 Awakener casuali, ma sviluppa [(Skill.Arg1)] due volte."
  },
  Event_59595_Desc = {
    Text = [[
Innumerevoli bolle come innumerevoli occhi ti osservano in silenzio, come se ponessero domande senza emettere suono.
Sei pronto?
Pronto a rinunciare a tutto?
Pronto a sopportare ogni cosa?]]
  },
  Event_59595_Name = {
    Text = "La Sua Inquisizione"
  },
  Event_59596_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59596_Desc = {
    Text = "Quando gli avversari lanciano il loro attacco, contrattacchi immediatamente.\nHai identificato astutamente la loro vera natura—non sono altro che bestie che mostrano le zanne.\nSei fortunato a uscirne vittorioso.\nOra, fuggi per salvarti la vita e assicurati che non ti catturino."
  },
  Event_59596_Name = {
    Text = "Verso l'Abisso"
  },
  Event_59597_ChoiceDesc1 = {
    Text = "[Seek Answers] Ricevi Arg1 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_59597_ChoiceDesc2 = {
    Text = "[Give Up] Congedo"
  },
  Event_59597_Desc = {
    Text = [[
Cosa dovresti fare?
Vedi innumerevoli versioni di te stesso, i loro volti identici al tuo, che ti fissano, le labbra in movimento.
Come aggrappandoti a un filo di speranza, cerchi e ascolti disperatamente, sperando di trovare la risposta definitiva.]]
  },
  Event_59597_Name = {
    Text = "La Mia Domanda"
  },
  Event_59598_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59598_Desc = {
    Text = [[
Non ancora. Devi resistere e attendere.
Ingoi il risentimento e l'odio, in attesa del momento decisivo.]]
  },
  Event_59598_Name = {
    Text = "Mani Burattino"
  },
  Event_59599_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59599_Desc = {
    Text = "Avverti un richiamo inspiegabile, come se fossi attratto verso la fonte di sguardi invisibili.\nScruti nel vuoto, con la sensazione di aver intravisto qualcosa.\nLa tua Visuale è momentaneamente offuscata da sfocature simili a neve, e il mondo davanti ai tuoi occhi sembra trasformato.\nMentre ti strofini gli occhi, noti due rivoli di lacrime di sangue che ti scorrono lungo il volto."
  },
  Event_59599_Name = {
    Text = "Il Suo Sguardo"
  },
  Event_59600_ChoiceDesc1 = {
    Text = "[Sforzarsi di ricordare] Scegli 1 tra 3 Carte di comando e ottieni Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_59600_ChoiceDesc2 = {
    Text = "[Assaporare la tristezza] Scegli 1 tra 3 Carte di comando e ottieni Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_59600_ChoiceDesc3 = {
    Text = "[Accept Silently] Ricevi 25 Sigilli Neri"
  },
  Event_59600_Desc = {
    Text = "Come se stessi subendo il più preciso degli interventi chirurgici al cervello, puoi sentire distintamente i ricordi più cari venire estratti dalla tua mente, lasciando i tuoi pensieri offuscati come se il cervello si stesse sciogliendo.\nTremi dal dolore, premendo sulla mano che oppone resistenza.\nLacrime cristalline scorrono lungo il viso, ma perché stanno cadendo?\nSembra che tu l'abbia dimenticato.\nProvi una tristezza inspiegabile."
  },
  Event_59600_Name = {
    Text = "Dissociazione Mnemonica"
  },
  Event_59601_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59601_Desc = {
    Text = "Il tuo legame con il gatto è fuori discussione. Saluti con la mano e prosegui senza voltarti.\n\"Sciocco! Sciocco!\"\nLa voce alle tue spalle urla con frustrazione."
  },
  Event_59601_Name = {
    Text = "Sussurro segreto"
  },
  Event_59602_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59602_Desc = {
    Text = "Determinato/a, decidi di combattere fino alla fine, portando con te la Speranza di Tutti, a qualunque costo."
  },
  Event_59602_Name = {
    Text = "Futuro Cristallizzato"
  },
  Event_59603_ChoiceDesc1 = {
    Text = "[Restrain] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_59603_ChoiceDesc2 = {
    Text = "[Gaze] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_59603_Desc = {
    Text = "Oltre il Portale custodito da Tawil si estende un mondo senza fine e verità infinite.\nNon sai cosa lei veda oltre la porta, ma sai che lei sa tutto.\nOra, la porta si erge aperta davanti a te, invitandoti silenziosamente a scoprire tutte le verità celate dietro di essa."
  },
  Event_59603_Name = {
    Text = "Oltre il portale"
  },
  Event_59604_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59604_Desc = {
    Text = "\nMostra rispetto per l'ignoto; evitarne il filo è una scelta saggia.\nAbbassi lo sguardo e stringi la Chiave d'argento al petto, sentendoti leggermente confortato.\nAlmeno hai ancora il tuo potere e i tuoi Risvegliatori.\nCerchi di ignorare quegli sguardi e concentrarti sulla strada davanti a te.\nMa quegli sguardi sono davvero scomparsi? Conosci la risposta."
  },
  Event_59604_Name = {
    Text = "Il Suo Sguardo"
  },
  Event_59605_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59605_Desc = {
    Text = "Se ogni mezzo per opporsi agli dèi è futile quanto formiche che tentano di scuotere un albero, l'unica cosa a cui puoi aggrapparti è un coraggio incrollabile.\nQuando la Distruzione infinita incombe dall'alto, sarai tu a stare in prima linea."
  },
  Event_59605_Name = {
    Text = "Risposta a sé stessi"
  },
  Event_59606_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59606_Desc = {
    Text = "Tocchi le lacrime che cadono, rivivendo un dolore insondabile.\nÈ come se avessi perso qualcosa di prezioso, ma non riesci a ricordare cosa fosse.\nChe peccato.\nTi asciughi debolmente le lacrime, forzando un amaro sorriso."
  },
  Event_59606_Name = {
    Text = "Dissociazione Mnemonica"
  },
  Event_59607_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59607_Desc = {
    Text = "Ignori le loro voci.\nNon ti importa se il gatto è un bugiardo; ti fidi solo del tuo potere.\nVoci sospirano nelle tue orecchie."
  },
  Event_59607_Name = {
    Text = "Sussurro segreto"
  },
  Event_59608_ChoiceDesc1 = {
    Text = "[Seek Answers] Ricevi Arg1 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_59608_ChoiceDesc2 = {
    Text = "[Give Up] Congedo"
  },
  Event_59608_Desc = {
    Text = "Qualcuno ride come un folle.\nQuella versione di te stesso crede che tutto sia inutile, meglio arrendersi subito.\nAggrotti le sopracciglia, e quel sé sorride improvvisamente, suggerendo di porre fine alla vita di tutti per risparmiar loro la sofferenza.\nScacci via quella voce, saldo nelle tue convinzioni."
  },
  Event_59608_Name = {
    Text = "La Mia Domanda"
  },
  Event_59609_ChoiceDesc1 = {
    Text = "[Interrogate] Distruggi 2 Carte qualsiasi"
  },
  Event_59609_ChoiceDesc2 = {
    Text = "[Pierce] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_59609_ChoiceDesc3 = {
    Text = "[Leave] Ricevi Arg1 Sigilli Neri"
  },
  Event_59609_Desc = {
    Text = "Nella lunga attesa, riapri il Comunicatore. Forse la tua nostalgia e le tue Preghiere hanno dato frutto; vedi risposte familiari e affettuose comparire sulla lettera.\nOra è al sicuro, con tutto organizzato dai suoi mentori, e Mythag funziona senza intoppi...\nVedendo le buone notizie giungere come fiocchi di neve, non puoi fare a meno di sentire un fremito nel cuore."
  },
  Event_59609_Name = {
    Text = "Eco del Delirio"
  },
  Event_59610_ChoiceDesc1 = {
    Text = "[Catch the Stars] Potenzia una Reliquia d'argento nella Reliquia d'oro [(RelicConfig.Arg1)]"
  },
  Event_59610_ChoiceDesc2 = {
    Text = "[Crush the Stars] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\" e \"(Skill.Arg3)\"."
  },
  Event_59610_ChoiceDesc3 = {
    Text = "[Watch Silently] Ricevi 25 Sigilli Neri"
  },
  Event_59610_Desc = {
    Text = "Le tue emozioni vengono strappate via insieme ai tuoi ricordi. Senti te stesso trasformarti in un'entità immensa, come un mostro che ritorna al suo antico, caldo nido.\nInnumerevoli emozioni si condensano in stelle luminose, piovendo nel tuo regno spirituale.\nLe tracce della tua esistenza svaniscono come una stella cadente.\nOsservi in silenzio, raccogliendo una stella che riecheggia della tua risata.\nE così ridi anche tu, assaporando il momento."
  },
  Event_59610_Name = {
    Text = "Emozione Cristallizzata"
  },
  Event_59611_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59611_Desc = {
    Text = "Sai che queste sono soltanto Ombre del Passato; massacri senza pietà coloro che un tempo conversavano con te, privo di qualsiasi emozione.\nLe loro risate e lacrime si frantumano nella tua stretta, senza lasciare spazio all'esitazione.\nSe questa è una prova necessaria, allora diventerai il più spietato dei carnefici."
  },
  Event_59611_Name = {
    Text = "Ombre del Passato"
  },
  Event_59612_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59612_Desc = {
    Text = [[
Il suo pelo morbido e i suoi occhi limpidi ispirano naturalmente fiducia.
Ti avvicini al gatto, e lui si avvicina a te.
Nessuno dei due parla, ma la sua coda si erge dritta.]]
  },
  Event_59612_Name = {
    Text = "Fascino Felino"
  },
  Event_59613_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59613_Desc = {
    Text = "Reprimi la tua curiosità, sapendo che questo portale non deve mai essere aperto.\nTroppa verità a volte può essere una maledizione.\nStringendo la Chiave d'argento al petto, decidi di mantenere questo portale sigillato per sempre."
  },
  Event_59613_Name = {
    Text = "Oltre il portale"
  },
  Event_59614_ChoiceDesc1 = {
    Text = "[Courage] Migliora la qualità dell'Orazione di 2 carte casuali."
  },
  Event_59614_ChoiceDesc2 = {
    Text = "[Resolve] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_59614_Desc = {
    Text = [[
Le parole di Tawil echeggiano nella tua mente.
Tra innumerevoli finali, esiste un solo vero cammino.
In uno stato confuso, vedi le ombre fugaci di molti mondi balenare davanti ai tuoi occhi come fotogrammi di una pellicola, in attesa del momento in cui fermarsi.
Quale destino attende il mondo nel prossimo istante?]]
  },
  Event_59614_Name = {
    Text = "Futuro Cristallizzato"
  },
  Event_59615_ChoiceDesc1 = {
    Text = "[Ignore Suspicion] Ricevi 50 Sigilli Neri"
  },
  Event_59615_ChoiceDesc2 = {
    Text = "[Arbitrary] Ricevi 75 Sigilli Neri, ma sviluppi il Sintomo [(Skill.Arg2)]"
  },
  Event_59615_Desc = {
    Text = [[
Con le beffe di N, cominci a dubitare di tutti coloro che hai incontrato.
Quali sono i suoi avatar, e quali i tuoi veri mentori e amici?
Le sue ombre continuano a mutare, rivelando innumerevoli volti, tutti ghignanti verso di te.]]
  },
  Event_59615_Name = {
    Text = "Cento Volti dell'Ombra"
  },
  Event_59616_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59616_Desc = {
    Text = "Se tutti sono capaci di tradimento, allora non affidarti a nessuno.\nNell'oscurità, puoi confermare una sola verità.\nAlmeno hai ancora te stesso — la versione più leale di te in cui puoi confidare."
  },
  Event_59616_Name = {
    Text = "Cento Volti dell'Ombra"
  },
  Event_59617_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59617_Desc = {
    Text = [[
Stringi il cristallo luminoso fino a ridurlo in polvere.
Inali avidamente le emozioni del passato.
Un'intensa ondata di gioia inonda il tuo cervello, per poi dissolversi come un Fantasma.
Le tue labbra si incurvano verso l'alto, prima di ricadere lentamente.
Il tuo volto diviene gradualmente calmo e privo di Espressione.]]
  },
  Event_59617_Name = {
    Text = "Emozione Cristallizzata"
  },
  Event_59618_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59618_Desc = {
    Text = "Sai che ogni cosa ha un prezzo, e se il prezzo della salvezza è il Sacrificio, allora sei pronto a pagarlo per intero.\nSei pronto a dare tutto te stesso in qualsiasi momento."
  },
  Event_59618_Name = {
    Text = "Risposta a sé stessi"
  },
  Event_59619_ChoiceDesc1 = {
    Text = "[Seek Answers] Ricevi Arg1 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_59619_ChoiceDesc2 = {
    Text = "[Give Up] Congedo"
  },
  Event_59619_Desc = {
    Text = "Qualcuno grida.\nQuel sé, bramoso di fuggire, sostiene che la resistenza è futile.\nSolo una fuga senza fine può ritardare l'annientamento definitivo.\nSei scettico."
  },
  Event_59619_Name = {
    Text = "La Mia Domanda"
  },
  Event_59620_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59620_Desc = {
    Text = "Conosci la terrificante velocità di proliferazione degli embrioni; la nuova vita qui è una maledizione simile alle locuste.\nSchiacci i neonati prima che possano piangere.\nLe figure fatte di carne e sangue ti guardano con odio velenoso, accusandoti di profanare la vita sacra.\nRispondi con una strage implacabile."
  },
  Event_59620_Name = {
    Text = "Ombre del Passato"
  },
  Event_59621_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59621_Desc = {
    Text = "In questo momento, speri di essere la persona più fortunata, di raggiungere il finale più perfetto.\nMa il prezzo della buona sorte può talvolta essere più crudele. Fortuna e sventura camminano spesso mano nella mano. Quando ottieni qualcosa, non dimenticare di controllare ciò che hai perso."
  },
  Event_59621_Name = {
    Text = "Scelta del Destino"
  },
  Event_59622_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59622_Desc = {
    Text = "È come lottare per il volante di un'auto: le tue mani volano ovunque, cercando di prendere il controllo del ritmo della musica.\nNel vivo della contesa, premi improvvisamente un'intera fila di tasti.\nL'esecuzione caotica si spezza; sorridi beffardo e sprofondi in una follia ancora più profonda."
  },
  Event_59622_Name = {
    Text = "Rapsodia dell'Apocalisse"
  },
  Event_59623_ChoiceDesc1 = {
    Text = "[Approach] 100% di probabilità di ottenere 25 Sigilli Neri"
  },
  Event_59623_ChoiceDesc2 = {
    Text = "[Gaze] 50% di probabilità di ottenere 50 Sigilli Neri, 50% di probabilità di non ottenere nulla."
  },
  Event_59623_Desc = {
    Text = "Un gatto ti segue, il pelo liscio e pulito, le zampe anteriori bianche come la neve.\nIl gatto resta al tuo fianco, Passo dopo Passo, come il tuo servitore più fedele.\nOgni tua Confusione, impotenza, dolore e angoscia vengono leniti."
  },
  Event_59623_Name = {
    Text = "Fascino Felino"
  },
  Event_59624_ChoiceDesc1 = {
    Text = "[Deny] Ottieni la Reliquia maledetta \"(RelicConfig.Arg2)\", ma sviluppi \"(Skill.Arg1)\"."
  },
  Event_59624_ChoiceDesc2 = {
    Text = "[Retort] Ottieni le Reliquie d'argento \"(RelicConfig.Arg2)\" e \"(RelicConfig.Arg3)\", ma sviluppa \"(Skill.Arg1)\" due volte."
  },
  Event_59624_ChoiceDesc3 = {
    Text = "[Remain Silent] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_59624_Desc = {
    Text = "Cadi in un'illusione di nulla.\nVedi innumerevoli persone ridotte al silenzio sotto l'ombra della rovina, minuscole come granelli di polvere.\nSono prive di vita, grigie e senza speranza.\nSenti la risata lacerante di qualcuno.\n\"Guarda, questo è il risultato della tua ostinazione.\"\n\"Il mondo non finisce mai; tutto è privo di significato.\""
  },
  Event_59624_Name = {
    Text = "Agnelli al Macello"
  },
  Event_59625_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59625_Desc = {
    Text = "No, questo è sbagliato, questo non è reale.\nContinui a negare le voci folli, ma le ombre grigie restano immobili, come a confermare una fine illusoria.\nLe risate si fanno più forti, deridendo la tua impotenza"
  },
  Event_59625_Name = {
    Text = "Agnelli al Macello"
  },
  Event_59626_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59626_Desc = {
    Text = "Un profondo senso di rimpianto e riluttanza ti sopraffà; istintivamente lotti per Ricordare il Passato, cercandone le tracce tra i frammenti della Memoria.\nI riflessi sfocati si ritraggono rapidamente, e per quanto tu tenti disperatamente di afferrarli, scivolano tra le tue dita.\nTi rendi conto che stai per perdere tutto."
  },
  Event_59626_Name = {
    Text = "Dissociazione Mnemonica"
  },
  Event_59627_ChoiceDesc1 = {
    Text = "[Approach] 100% di probabilità di ottenere 25 Sigilli Neri"
  },
  Event_59627_ChoiceDesc2 = {
    Text = "[Gaze] 50% di probabilità di ottenere 50 Sigilli Neri, 50% di probabilità di non ottenere nulla."
  },
  Event_59627_Desc = {
    Text = "Un gatto ti segue, il pelo liscio e pulito, le zampe anteriori bianche come la neve.\nIl gatto resta al tuo fianco, Passo dopo Passo, come il tuo servitore più fedele.\nOgni tua Confusione, impotenza, dolore e angoscia vengono leniti."
  },
  Event_59627_Name = {
    Text = "Fascino Felino"
  },
  Event_59628_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59628_Desc = {
    Text = "Qui incontri il tuo sé supremo; la battaglia per distruggere il mondo non è che uno scambio di sguardi.\nQuando Esso ti guarda, devi ricambiare fermamente il Suo sguardo finché uno dei due non svanisce."
  },
  Event_59628_Name = {
    Text = "Risposta a sé stessi"
  },
  Event_59629_ChoiceDesc1 = {
    Text = "[Breath] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_59629_ChoiceDesc2 = {
    Text = "[Counterattack] Ottieni la Reliquia dorata \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\" e \"(Skill.Arg3)\"."
  },
  Event_59629_ChoiceDesc3 = {
    Text = "[Struggle] Ricevi 25 Sigilli Neri"
  },
  Event_59629_Desc = {
    Text = [[
Passi pesanti riecheggiano mentre un gruppo di Agenti del Comitato ti blocca la strada.
"La preghiamo di collaborare con la nostra indagine."
La voce fredda porta un accenno di malevolenza.
Con un tonfo, l'acqua calma viene disturbata, e ti gettano negli abissi.]]
  },
  Event_59629_Name = {
    Text = "Verso l'Abisso"
  },
  Event_59630_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59630_Desc = {
    Text = [[
Ti dibatti disperatamente.
Avanti, solo un poco ancora.
A qualunque costo, devi proteggere ogni cosa.
Tendi la mano mentre i fili ti incidono la carne, eppure non senti nulla.]]
  },
  Event_59630_Name = {
    Text = "Mani Burattino"
  },
  Event_59631_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59631_Desc = {
    Text = [[
Scuoti violentemente la testa, scacciando i ricordi caotici dalla mente.
Ben presto, la cacofonia svanisce e la tua coscienza riacquista la propria indipendenza.
Sai che non troverai aiuto nei fallimenti passati; solo concentrandoti sul presente potrai trovare speranza.]]
  },
  Event_59631_Name = {
    Text = "La Mia Domanda"
  },
  Event_59632_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_59632_Desc = {
    Text = [[
Prima di allungare la mano, ricordi improvvisamente di non aver mai posseduto un gatto simile.
Tu e il gatto incrociate gli sguardi attraverso l'aria, e lui sbatte le palpebre verso di te.
Al gatto non importa della tua indifferenza; sembra amarti comunque allo stesso modo.]]
  },
  Event_59632_Name = {
    Text = "Fascino Felino"
  },
  Event_59633_ChoiceDesc1 = {
    Text = "[Seek Answers] Ricevi Arg1 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_59633_ChoiceDesc2 = {
    Text = "[Give Up] Congedo"
  },
  Event_59633_Desc = {
    Text = "Qualcuno piange.\nColmo di dolore, anela ad abbracciare i propri cari.\nIl suo più grande rimpianto è non essere stato accanto a chi amava durante la Distruzione.\nIl tuo cuore si stringe mentre condividi il suo dolore."
  },
  Event_59633_Name = {
    Text = "La Mia Domanda"
  },
  Event_59634_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59634_Desc = {
    Text = [[
Fissi innumerevoli figure grigie, ignorando le risate beffarde.
Come puoi salvare un mondo che crolla?
Mediti nel mezzo dell'estinzione silenziosa.]]
  },
  Event_59634_Name = {
    Text = "Agnelli al Macello"
  },
  Event_59635_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59635_Desc = {
    Text = [[
L'aria nei tuoi alveoli scompare gradualmente, e tenti di respirare sott'acqua.
Che atto sciocco, eppure ci riesci.
I tuoi alveoli si riempiono di nuovo, e puoi respirare liberamente ancora una volta.
Ma cosa stai inalando esattamente?]]
  },
  Event_59635_Name = {
    Text = "Verso l'Abisso"
  },
  Event_59636_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59636_Desc = {
    Text = "Sprofondi nel liquido viscoso.\nPer quanto ti dibatta, non fai che sprofondare ancora di più.\nDa questa melma non puoi fuggire da solo."
  },
  Event_59636_Name = {
    Text = "Verso l'Abisso"
  },
  Event_59637_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59637_Desc = {
    Text = "Ti sforzi di dimenticare questi dubbi.\nSai che la diffidenza è futile in questo momento; puoi solo fidarti.\nFinché la scatola sigillata non verrà aperta, la sua verità ti resterà ignota.\nA volte, recitare la parte dello sciocco ignaro porta pace."
  },
  Event_59637_Name = {
    Text = "Cento Volti dell'Ombra"
  },
  Event_59638_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59638_Desc = {
    Text = "Tutti gli occhi sono puntati su di te. Come leader, non devi mostrare alcuna fragilità.\n\"Dirigetevi verso la Pozza Nera, andrà tutto bene.\"\nImpartisci con calma il comando, facendo una promessa a cui tu stesso fai fatica a credere."
  },
  Event_59638_Name = {
    Text = "Sguardo dell'Ignoranza"
  },
  Event_59639_ChoiceDesc1 = {
    Text = "[Suspect] Ottieni la Reliquia maledetta \"(RelicConfig.Arg2)\", ma sviluppa \"(Skill.Arg1)\"."
  },
  Event_59639_ChoiceDesc2 = {
    Text = "[Disdain] Ottieni le Reliquie d'argento \"(RelicConfig.Arg2)\" e \"(RelicConfig.Arg3)\", ma sviluppa \"(Skill.Arg1)\" due volte."
  },
  Event_59639_ChoiceDesc3 = {
    Text = "[Ignore] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_59639_Desc = {
    Text = "Tre figure esitanti mormorano qualcosa davanti a te.\nTi avvicini per ascoltare, le loro parole si fondono con il respiro, facendosi più chiare.\n\"Non fidarti di quel gatto; è un bugiardo.\"\nTi volti di scatto, ma non trovi nessuno accanto a te."
  },
  Event_59639_Name = {
    Text = "Sussurro segreto"
  },
  Event_59640_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59640_Desc = {
    Text = "Le stelle sembrano così appetitose, brami il loro potere e ne inghiotti una intera.\nGlup.\nIl tuo Spirito si sente più colmo che mai, e una luce brilla nella tua visione periferica.\nAbbassi lo sguardo e vedi la stella ancora luminosa nel tuo stomaco."
  },
  Event_59640_Name = {
    Text = "Stella dei Desideri"
  },
  Event_59641_ChoiceDesc1 = {
    Text = "[Struggle Forward] Distruggi una Carta di comando e ricevi Arg1 Sigilli Neri."
  },
  Event_59641_ChoiceDesc2 = {
    Text = "[Snap the Thread] Duplica una Carta di comando, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_59641_ChoiceDesc3 = {
    Text = "[Endure] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_59641_Desc = {
    Text = "Per tutto il cammino vieni sospinto in avanti, ogni tua scelta manipolata da fili invisibili.\nLotti per aggrapparti a tutto ciò che ti sta a cuore.\nIl destino del mondo pende appena oltre la punta delle tue dita.\nInnumerevoli fili si intrecciano, imprigionando il tuo corpo intero."
  },
  Event_59641_Name = {
    Text = "Mani Burattino"
  },
  Event_59642_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59642_Desc = {
    Text = [[
Ti asciughi le lacrime di sangue, ma altre continuano a scorrere.
Il rosso offusca la tua vista, come a presagire un sacrificio cruento.
Continui ad asciugarle, tremando dal dolore, ma senza un briciolo di paura.]]
  },
  Event_59642_Name = {
    Text = "Fusione degli Io"
  },
  Event_59643_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59643_Desc = {
    Text = [[
Accarezzi la gemma magica e la incastoni nella Chiave d'argento.
La luce delle stelle ti avvolge.
Ne resti abbagliato]]
  },
  Event_59643_Name = {
    Text = "Stella dei Desideri"
  },
  Event_59644_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59644_Desc = {
    Text = "Nonostante tutto, hai tenuto gli occhi spalancati, trasformando la pura volontà in un ruggito di sfida.\nAnche se dovessi frantumarti e svanire, non arretrerai di un solo passo."
  },
  Event_59644_Name = {
    Text = "Fusione degli Io"
  },
  Event_59645_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59645_Desc = {
    Text = "Qualcuno resta in silenzio.\nVedendo il volto del sé disperato, sai che nessuno di loro è arrivato alla fine.\nHai viaggiato più lontano di tutti i tuoi sé; solo la tua risposta custodisce l'ultima speranza."
  },
  Event_59645_Name = {
    Text = "La Mia Domanda"
  },
  Event_59646_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59646_Desc = {
    Text = [[
Tendi la mano, afferrando innumerevoli stelle cadenti, cristalli luminosi che sfiorano i tuoi polpastrelli.
Gioia, pianto, rabbia, paura...
Avidamente ghermisci ogni emozione, solo per vederla scivolare tra le dita.
Una luce brillante ti illumina il volto, i tuoi occhi si fanno gradualmente profondi e oscuri.]]
  },
  Event_59646_Name = {
    Text = "Emozione Cristallizzata"
  },
  Event_59657_ChoiceDesc1 = {
    Text = "[Call Out] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_59657_ChoiceDesc2 = {
    Text = "[Touch] Ottieni la Reliquia d'Oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_59657_Desc = {
    Text = "Assisti al malfunzionamento dell'automa.\nUn tempo era l'essere più razionale, la tua assistente più leale, che preservava con cura tutte le informazioni che avevi raccolto.\nOra, sembra che non ricordi più nessuno dei momenti che avete condiviso.\nVedi lacrime cristalline cadere dagli angoli dei suoi occhi."
  },
  Event_59657_Name = {
    Text = "Lacrima dell'Automa"
  },
  Event_59658_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59658_Desc = {
    Text = "Ti rifiuti di arrenderti e tenti di raggiungere il suo nucleo energetico.\nSe è una macchina, può essere riavviata, giusto?\nTuttavia, l'automa spietato non ti concede quell'ingenua opportunità.\nLa tua moderazione non riesce a suscitare pietà nell'automa, costringendoti a combattere con tutto ciò che hai."
  },
  Event_59658_Name = {
    Text = "Lacrima dell'Automa"
  },
  Event_59659_ChoiceDesc1 = {Text = "[Leave]"},
  Event_59659_Desc = {
    Text = "Non vuoi danneggiare la tua ex compagna.\nChiami disperatamente il suo nome e impartisci ogni comando, ma è tutto inutile.\nL'automa ti ha tradito, tornando alla freddezza di un oggetto inanimato."
  },
  Event_59659_Name = {
    Text = "Lacrima dell'Automa"
  },
  Event_60944_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60944_Desc = {
    Text = "Il tempo stringe, quindi scegli l'approccio più diretto e sfondare il blocco. I Risvegliati si sentono ispirati e si galvanizzano.\nQuanto all'aumentata Allerta dei nemici, non è motivo di preoccupazione."
  },
  Event_60944_Name = {
    Text = "Agente del Comitato"
  },
  Event_60945_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60945_Desc = {
    Text = "Prima che l'agente possa reagire, gli giri alle spalle e gli strappi l'arma. Prima che i rinforzi arrivino, riesci a fuggire.\nPurtroppo, la voce si è sparsa, e i prossimi nemici saranno più preparati. Tieniti pronto."
  },
  Event_60945_Name = {
    Text = "Agente del Comitato"
  },
  Event_60946_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60946_Desc = {
    Text = "L'agente è attirato da un fischio, avvicinandosi al tuo nascondiglio. Quando si avvicina, i Risvegliati in attesa lanciano il loro attacco.\nUn'imboscata perfetta. La minaccia qui è stata eliminata permanentemente."
  },
  Event_60946_Name = {
    Text = "Agente del Comitato"
  },
  Event_60947_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60947_Desc = {
    Text = "Di fronte a nemici numerosi, sei incapace di reagire. Ti esponi deliberatamente alla loro linea di vista, senza opporre resistenza.\nSai che presto verrai condotto a un Punto di Detenzione, e questo fa parte del piano.\nFuggirai da lì e troverai un nuovo cammino."
  },
  Event_60947_Name = {
    Text = "Punto d'Osservazione"
  },
  Event_60948_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60948_Desc = {
    Text = "Di fronte a numerosi nemici, non puoi competere con loro. Dopo un breve scontro, rinunci a resistere.\nSai che stai per essere condotto in un punto di detenzione, il che fa parte del piano.\nFuggirai da lì e troverai un nuovo cammino."
  },
  Event_60948_Name = {
    Text = "Punto d'Osservazione"
  },
  Event_60949_ChoiceDesc1 = {Text = "[Leave]"},
  Event_60949_Desc = {
    Text = [[
Di fronte a numerosi nemici, non puoi competere con loro.
Scegli di ritirarti temporaneamente e cercare un nuovo sentiero.]]
  },
  Event_60949_Name = {
    Text = "Punto d'Osservazione"
  },
  Event_61058_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61058_Desc = {
    Text = [[
Osservi le tue mani e il tuo intero corpo, colmo di speranza e determinazione.
Se tutto questo fa parte del disegno del destino, sei pronto ad affrontare ogni cosa.
Negli istanti finali, se ci saranno porte per il paradiso o l'inferno, sarai tu ad aprirle per il mondo.]]
  },
  Event_61058_Name = {Text = "Sbircia"},
  Event_61059_ChoiceDesc1 = {
    Text = "[Ready for Battle] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_61059_ChoiceDesc2 = {
    Text = "[Continue Observing] Sviluppa il Sintomo [(Skill.Arg1)] e trasforma l'Orazione in incisione.(Utilizzi: 1/2)"
  },
  Event_61059_Desc = {
    Text = "Non ti precipiti in battaglia, ma cerchi con calma di comprendere la situazione. Questo improvviso direttore d'orchestra sembra al contempo amico e nemico; non sei certo delle sue intenzioni. Ciononostante, decidi di prepararti al meglio, pronto ad affrontare la sua sfida prima di osservare i suoi veri propositi."
  },
  Event_61059_Name = {
    Text = "Direttore Demoniaco"
  },
  Event_61060_ChoiceDesc1 = {
    Text = "[Listen] Incidi 1 Orazione Avanzata su 3"
  },
  Event_61060_ChoiceDesc2 = {
    Text = "[Call Out] Ottieni la Reliquia dorata \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_61060_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_61060_Desc = {
    Text = "Dall'incidente, non hai più avuto notizie dalla tua compagna.\nInnumerevoli tentativi di contatto sono stati come gettare pietre nel mare, senza alcuna risposta.\nQuando hai perso ogni speranza, il comunicatore emette improvvisamente un suono.\nApri la valigetta, avvicinando il ricevitore all'orecchio.\n\"Custode...\"\nIn uno stato confuso, senti la voce a lungo desiderata, che riecheggia lontana attraverso il vuoto."
  },
  Event_61060_Name = {
    Text = "Eco della nostalgia"
  },
  Event_61061_ChoiceDesc1 = {
    Text = "[Embrace the Darkness] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_61061_ChoiceDesc2 = {
    Text = "[Attempt to Swim] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_61061_ChoiceDesc3 = {
    Text = "[Call to the Ghosts] Ricevi 25 Sigilli Neri"
  },
  Event_61061_Desc = {
    Text = "Ti slanci in avanti, e il terreno si trasforma improvvisamente in un mare invalicabile.\nSprofoni nel suolo.\nL'Oscurità, densa e appiccicosa come spettri in un cimitero, ti circonda, invadendo avidamente la tua bocca e le tue narici."
  },
  Event_61061_Name = {
    Text = "Sprofondamento nel Sottosuolo"
  },
  Event_61062_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61062_Desc = {
    Text = [[
Spalanchi gli occhi, cercando ogni indizio.
Cento occhi si muovono simultaneamente; vedi le impronte del segugio dal volto umano davanti a te e la traiettoria del bastone di Hameln che ondeggia alle tue spalle.
Osservi avidamente ogni cosa.
All'improvviso, noti un bulbo oculare familiare che rotola a terra.
Sembra essere uno dei tuoi.]]
  },
  Event_61062_Name = {
    Text = "Avidità di Sapere"
  },
  Event_61063_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61063_Desc = {
    Text = "No, non puoi vedere così tante cose.\nQuanti occhi hai, poi? Solo... pochi?\nIn fretta, chiudi gli occhi e ti tasti il viso.\nUno, due...\nQuando riapri gli occhi, la tua Visuale si fa angusta e ignara.\nAh, hai solo due occhi. Che peccato."
  },
  Event_61063_Name = {
    Text = "Avidità di Sapere"
  },
  Event_61064_ChoiceDesc1 = {
    Text = "[Search] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_61064_ChoiceDesc2 = {
    Text = "[Chiudere gli occhi] 1 Carta di comando casuale ottiene l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_61064_Desc = {
    Text = "Sempre più indizi si attorcigliano in un groviglio inestricabile, rendendoti ansioso, confuso, risentito — ti odi per non sapere nulla.\nUn'enorme pressione stringe il tuo spirito fino a ridurlo a un filo sottile.\nCon uno schiocco, senti il cuoio capelluto rilassarsi all'improvviso, e ti ritrovi capace di percepire tutto ciò che ti circonda, scorgendo le ombre che tremolano nel vuoto.\nDi più, devi vedere di più..."
  },
  Event_61064_Name = {
    Text = "Avidità di Sapere"
  },
  Event_61065_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61065_Desc = {
    Text = "Nuoti attraverso il terreno, immaginandoti il pesce più agile.\nPer diventare un pesce, devi rinunciare alle tue gambe umane.\nQuesto è il prezzo del patto.\nPresto, avverti un senso di libertà senza precedenti mentre divieni l'essere più libero del sottosuolo.\nRitorni in superficie, ma hai dimenticato come camminare."
  },
  Event_61065_Name = {
    Text = "Sprofondamento nel Sottosuolo"
  },
  Event_61066_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61066_Desc = {
    Text = "Le tue dita toccano la sensazione familiare della Chiave d'argento, il nucleo di tutta la luce.\nEssa incarna la tua vita e il tuo destino.\nI ricordi lampeggiano davanti ai tuoi occhi.\nLe tue scelte sono ormai indissolubilmente legate al destino del mondo.\nIl tuo destino è legato a quello di molti altri."
  },
  Event_61066_Name = {Text = "Sbircia"},
  Event_61067_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61067_Desc = {
    Text = [[
Senti intorno a te molte presenze familiari.
Tenti di chiamare i fantasmi che forse non esistono.
Un miracolo accade, e ti ritrovi di nuovo a terra.
Innumerevoli lapidi restano in silenzio.]]
  },
  Event_61067_Name = {
    Text = "Sprofondamento nel Sottosuolo"
  },
  Event_61068_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61068_Desc = {
    Text = "Non hai tempo per i sentimentalismi; il tuo unico scopo è salvare questo mondo che crolla.\nSe devi diventare una stella, allora sii una stella cadente.\nAnche se precipiti, purché tu illumini il cielo notturno."
  },
  Event_61068_Name = {Text = "Sbircia"},
  Event_61069_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61069_Desc = {
    Text = "Premi l'orecchio più vicino, cercando di cogliere ogni minimo suono.\n\"Io...\"\n\"Devi...\"\nRiesci a percepire solo frasi spezzate, impossibili da decifrare.\nMa non osi emettere un suono, per timore di perdere anche una sola parola.\nTuttavia, il destino non mostra pietà.\nL'ultima traccia di suono svanisce, lasciando solo silenzio."
  },
  Event_61069_Name = {
    Text = "Eco della nostalgia"
  },
  Event_61070_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61070_Desc = {
    Text = "Smetti di pensare oltre e ordini ai Risveglio di mettersi in fila per affrontare la sua sfida."
  },
  Event_61070_Name = {
    Text = "Direttore Demoniaco"
  },
  Event_61071_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61071_Desc = {
    Text = [[
Continui a chiamare il suo nome, cercando di trasmettere anche solo una traccia dei tuoi sentimenti.
Non sai se ti abbia udito. Ti sforzi di distinguere i suoni flebili che giungono attraverso il microfono.
Potrebbe essere la sua risposta, o forse frammenti del passato che si ripetono all'infinito.
Rivivendo le gioie e i dolori che un tempo condivideste insieme.]]
  },
  Event_61071_Name = {
    Text = "Eco della nostalgia"
  },
  Event_61072_ChoiceDesc1 = {Text = "[Leave]"},
  Event_61072_Desc = {
    Text = "Forse questa oscurità è il mondo reale. Cosa c'è di male nell'abbracciarlo?\nTi abbandoni completamente alle tenebre, e queste non ti respingono più. Puoi respirare liberamente.\nL'istante dopo, riemergi in superficie. Forse qualcosa è rimasto sottoterra, ma non ha più importanza."
  },
  Event_61072_Name = {
    Text = "Sprofondamento nel Sottosuolo"
  },
  Event_61073_ChoiceDesc1 = {
    Text = "[Gaze at Light] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando, ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_61073_ChoiceDesc2 = {
    Text = "[Touch Chest] Risveglia un Risvegliato, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_61073_ChoiceDesc3 = {
    Text = "[Keep Running] Ricevi 25 Sigilli Neri"
  },
  Event_61073_Desc = {
    Text = "Sei perso e puoi solo correre freneticamente, senza tempo per pensare.\nAll'improvviso, avverti un vuoto nel petto.\nAbbassando lo sguardo, vedi una luce a forma di chiave là dove dovrebbe trovarsi il tuo cuore.\nLa luce si fa più intensa, propagandosi su tutto il tuo corpo.\nTi vedi trasformare in una stella.\nComprendi d'un tratto che forse questa è sempre stata la tua missione."
  },
  Event_61073_Name = {Text = "Sbircia"},
  Event_61074_ChoiceDesc1 = {
    Text = "[Ready for Battle] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_61074_ChoiceDesc2 = {
    Text = "[Observe Carefully] Sviluppa il Sintomo [(Skill.Arg1)] e trasforma l'Orazione in incisione.(Utilizzi: 2/2)"
  },
  Event_61074_Desc = {
    Text = "\"Ehi... aspetta! Cosa sta succedendo...\"\n\"Prova generale.\"\nL'uomo ti guarda senza espressione.\n\"Usare la musica per mantenere il legame con il Risvegliatore è un nuovo esperimento. Garantire la qualità dell'orchestra assicura un'esecuzione perfetta.\"\nSolleva la bacchetta con grazia, segnando l'inizio.\n\"Suona, Custode. Mostrami cosa sai fare.\""
  },
  Event_61074_Name = {
    Text = "Direttore Demoniaco"
  },
  Event_61075_ChoiceDesc1 = {
    Text = "[Ready for Battle] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_61075_Desc = {
    Text = "Quali che siano le sue Intenzioni, ti ha salvato dagli esecutori del Comitato. Se avesse voluto farti del male, non ti avrebbe aiutato. Facendoti coraggio, ti prepari al peggio."
  },
  Event_61075_Name = {
    Text = "Direttore Demoniaco"
  },
  Event_65400_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65400_Desc = {
    Text = "Un emissario trasmise promesse di soccorso dall'esterno, riaccendendo la speranza mentre la squadra di salvataggio tentava di raggiungere la montagna."
  },
  Event_65400_Name = {Text = "Crocevia"},
  Event_65401_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65401_Desc = {
    Text = "Nessuno dei membri della spedizione è riuscito a uscire dalla Montagna Innevata. Di fronte al disastro, scegli sempre te stesso, e le vite della gente comune non significano nulla per te. Hai abbandonato la tua Umanità e hai raggiunto la fine in sicurezza.\nI soccorritori ti hanno guardato con emozioni contrastanti, ma tu sei rimasto impassibile e ti sei incamminato nella tempesta di neve. Forse a mezzanotte, le anime perite a causa della tua indifferenza si raduneranno attorno al tuo letto, osservandoti in silenzio."
  },
  Event_65401_Name = {
    Text = "Punto di Evacuazione Sicuro"
  },
  Event_65402_ChoiceDesc1 = {
    Text = "[Crowd Evacuation] Rimuovi la reliquia \"Squadra di Spedizione\" e ottieni diversi livelli di \"Medaglia di Soccorso\" in base al numero di membri della squadra di spedizione."
  },
  Event_65402_Desc = {
    Text = "Avete condotto in sicurezza la Squadra di Spedizione al punto di evacuazione. La squadra di soccorso prende il comando, e gli individui tratti in salvo crollano a terra, come se si trovassero in un altro mondo.\nMa voi sapete che la vera crisi è ben lungi dall'essere risolta. La bestia gigantesca si annida ancora nella Catena Montuosa, in agguato, affamata, in attesa della sua prossima mossa."
  },
  Event_65402_Name = {
    Text = "Punto di Evacuazione Sicuro"
  },
  Event_65403_ChoiceDesc1 = {
    Text = "[Supply Trade] Ricevi 25 Sigilli Neri, più 1 per ogni Membro della Spedizione (Arg1)."
  },
  Event_65403_ChoiceDesc2 = {
    Text = "[Rescue Promise] Incidi 1 Orazione tra 3. Ottieni 2 Membri della Spedizione."
  },
  Event_65403_ChoiceDesc3 = {
    Text = "[Profit First] Acquisisci una Reliquia Oro+ , ma perdi 10 Membri della Spedizione."
  },
  Event_65403_Desc = {
    Text = "Avanzi a fatica nella tempesta di neve, seguendo le luci tremolanti del lontano Punto di Contatto d'emergenza.\n○ Infine, dopo innumerevoli preghiere, scorgi la piccola capanna che custodisce la speranza."
  },
  Event_65403_Name = {Text = "Crocevia"},
  Event_65403_Tips3 = {
    Text = "Membri della Spedizione insufficienti"
  },
  Event_65404_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65404_Desc = {
    Text = "Hai ottenuto il codice del magazzino dal contatto e hai trovato scorte di inventario sufficienti per due giorni per tutti. Almeno non morirete di fame né di freddo sulla Montagna Innevata."
  },
  Event_65404_Name = {Text = "Crocevia"},
  Event_65415_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_65415_Desc = {
    Text = "La Montagna Innevata completò istantaneamente il suo \"pasto\": due persone scomparvero per sempre negli abissi senza fondo dei crepacci, del tutto inosservate da tutti voi."
  },
  Event_65415_Name = {Text = "Illusione"},
  Event_65416_ChoiceDesc1 = {
    Text = "[Leave] Cerca il Riflettore"
  },
  Event_65416_ChoiceDesc2 = {
    Text = "[Snow Intrusion] Perdi 2 Membri della Spedizione"
  },
  Event_65416_Desc = {
    Text = [[
Un'improvvisa raffica spazza la Montagna Innevata, l'ululato del vento simile all'urlo di una bestia, accecandoti con una nebbia di neve. Qualcosa sembra muoversi nell'infinita distesa bianca.
Sei costretto a fermarti, piantando saldamente le gambe nella neve per evitare di scivolare lungo il pendio.]]
  },
  Event_65416_Name = {Text = "???"},
  Event_65417_ChoiceDesc1 = {
    Text = "[Silent Evaporation] Perdi 2 Membri della Spedizione"
  },
  Event_65417_ChoiceDesc2 = {Text = "[Leave]"},
  Event_65417_Desc = {
    Text = [[
Suoni ruggenti emergono dalle viscere della Montagna Innevata, simili ai ringhi di una bestia affamata. Il terreno trema, il ghiaccio sotto la neve si incrina silenziosamente, come se la Montagna Innevata avesse spalancato le sue fauci.
Quando i tremori infine cessano, la gente si guarda intorno confusa, e tu ti volti a controllare il gruppo.]]
  },
  Event_65417_Name = {Text = "Illusione"},
  Event_65468_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65468_Desc = {
    Text = "Per garantire la mobilità della squadra, hai abbandonato coloro che lottavano per sopravvivere, lasciandoli in una capanna isolata. Potrebbe aumentare il tasso di sopravvivenza degli altri, ma non provi nulla di fronte ai loro sguardi carichi di rancore?"
  },
  Event_65468_Name = {Text = "Crocevia"},
  Event_65483_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65483_Desc = {
    Text = [[
Hai salvato alcune persone, ma molte altre sono rimaste sulla Montagna Innevata. Almeno hai fatto del tuo meglio.
I soccorritori hanno detto che i tuoi sforzi sarebbero stati riconosciuti in seguito. Li hai congedati con un cenno e sei tornato nella tormenta di neve.]]
  },
  Event_65483_Name = {
    Text = "Punto di Evacuazione Sicuro"
  },
  Event_65484_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65484_Desc = {
    Text = "Ti sei concentrato unicamente sulla fuga dalla Montagna Innevata, scegliendo il percorso più efficiente. Agli occhi dell'ultimo sopravvissuto, potresti essere apparso come un demone.\nI soccorritori hanno menzionato che i tuoi contributi sarebbero stati presto onorati. Li hai congedati con un gesto e sei entrato nella tempesta di neve."
  },
  Event_65484_Name = {
    Text = "Punto di Evacuazione Sicuro"
  },
  Event_65485_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65485_Desc = {
    Text = "Sotto la tua instancabile protezione, l'intera squadra di spedizione ne è uscita illesa. Incontrarti è stata la loro più grande fortuna nella sventura; sei il loro vero salvatore.\nHai creato un miracolo nel mezzo del disastro, e presto le storie dell'eroe della Montagna Innevata si diffonderanno ovunque. I soccorritori hanno dichiarato solennemente che i tuoi straordinari contributi sarebbero stati presto onorati. Con un sorriso, hai salutato con la mano e sei tornato nella tormenta di neve."
  },
  Event_65485_Name = {
    Text = "Punto di Evacuazione Sicuro"
  },
  Event_65486_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65486_Desc = {
    Text = "Ti preoccupi davvero della vita delle persone. La maggior parte di loro è stata salvata da te, e piangevano ringraziandoti senza sosta per la tua protezione.\nI soccorritori hanno promesso solennemente che il tuo contributo eccezionale sarebbe stato presto riconosciuto. Hai sorriso, salutato con la mano e ti sei incamminato nella tempesta di neve."
  },
  Event_65486_Name = {
    Text = "Punto di Evacuazione Sicuro"
  },
  Event_65487_ChoiceDesc1 = {Text = "[Leave]"},
  Event_65487_Desc = {
    Text = "Hai lottato contro il disastro in continuo mutamento e hai strappato le persone dalla Soglia della Morte. Grazie ai tuoi sforzi, il tragico epilogo si è lievemente alterato.\nLa squadra di soccorso ha solennemente riconosciuto il tuo inestimabile contributo e ha annunciato che saresti stato encomiato. Hai sorriso, salutato con la mano e sei tornato nella tempesta di neve."
  },
  Event_65487_Name = {
    Text = "Punto di Evacuazione Sicuro"
  },
  Event_6817_ChoiceDesc1 = {
    Text = "[Stop Here] Incidi 1 Orazione su 3"
  },
  Event_6817_ChoiceDesc2 = {
    Text = "[Continuare a leggere] 1 Carta di comando casuale ottiene Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_6817_Desc = {
    Text = "In cima a una libreria di legno, c'è un libro dalla copertina dorata. Dal livello del suolo, il suo titolo è indecifrabile.\nPer qualche ragione, un impulso irrefrenabile di leggerlo affiora dentro di te... Questo impulso diventa rapidamente incontrollabile. Ignorando il rischio di essere notato, sali la scala di legno accanto alla libreria, prendi il libro e cominci a leggerlo avidamente...\nVaghe impressioni affiorano nell'oceano della tua mente. Sei sommerso in un mare di illusioni..."
  },
  Event_6817_Name = {
    Text = "Tomo Giallo"
  },
  Event_6818_ChoiceDesc1 = {
    Text = "[Ascoltare] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_6818_ChoiceDesc2 = {
    Text = "[Ensemble] Ricevi 15 Sigilli Neri per ogni Risvegliato con 50 o più Aliemus."
  },
  Event_6818_ChoiceDesc3 = {
    Text = "[Leave] Incidi 1 Orazione su 3"
  },
  Event_6818_Desc = {
    Text = [[
Il suono del pianoforte raggiunge improvvisamente le tue orecchie. Dita eteree e verdastre danzano sui tasti, creando una melodia aggraziata come un ruscello che scorre.
"Caro amico, vorresti unirti a me in un duetto?"
Le mani non parlano; te lo chiedono attraverso la musica.]]
  },
  Event_6818_Name = {
    Text = "Fantasma dell'arpa"
  },
  Event_6819_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6819_Desc = {
    Text = "Ramona volse lo sguardo verso la fonte del suono, ma colse soltanto un Fantasma evanescente, come un grammofono che si dissolveva nel muro."
  },
  Event_6819_Name = {
    Text = "Orecchie Altrui"
  },
  Event_6820_ChoiceDesc1 = {
    Text = "[Clean the Typewriter] Distruggi una Carta di comando e ricevi 25 Sigilli Neri."
  },
  Event_6820_ChoiceDesc2 = {
    Text = "[Try to Identify Text] Duplica una Carta, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_6820_Desc = {
    Text = "La macchina da scrivere nella valigia eruttò improvvisamente inchiostro denso, che schizzò in rivoli lineari al dondolio del treno."
  },
  Event_6820_Name = {
    Text = "Sussurro della Macchina da Scrivere"
  },
  Event_6821_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6821_Desc = {
    Text = "Mentre il tuo pugno disperde il fantasma, le memorie irrompono nella tua mente, colpendo la tua anima con dolore"
  },
  Event_6821_Name = {Text = "Miraggio"},
  Event_6822_ChoiceDesc1 = {
    Text = "[Discard the Letter] Distruggi una Carta"
  },
  Event_6822_ChoiceDesc2 = {
    Text = "[Keep Close] Ottieni la Reliquia \"(RelicConfig.Arg1)\", ma sviluppi il Sintomo \"(Skill.Arg2)\"."
  },
  Event_6822_Desc = {
    Text = "\nEstrai alcuni fogli dalla macchina da scrivere. L'inchiostro sbavato emana un odore pungente. Scorri il contenuto, aggrottando istintivamente le sopracciglia.\nLa maggior parte della lettera è stata cancellata, lasciando solo frammenti che a malapena formano frasi, rendendola quasi illeggibile."
  },
  Event_6822_Name = {
    Text = "Lettera Macchiata"
  },
  Event_6823_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6823_Desc = {
    Text = "Ti sforzi di decifrare la scrittura sfocata sul foglio. Le parole si contorcono e poi rivelano qualcosa di completamente diverso.\n\"@2Presumo tu abbia visto la notizia sul giornale.\nSì, tuo padre ti ha rimosso dalla linea di successione... Non volevamo @2\nDiavolo, diavolo...\nSmetti immediatamente di frequentare il signor Herbert, o ti taglierò i fondi...\""
  },
  Event_6823_Name = {
    Text = "Presenza Inscritta"
  },
  Event_6824_ChoiceDesc1 = {
    Text = "[Hold Silver Key] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando, ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_6824_ChoiceDesc2 = {
    Text = "[Close Your Eyes] Risveglia un Risvegliato, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_6824_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_6824_Desc = {
    Text = "\nFosti dilaniato da un'ondata di assurdità, le membra contorte mentre strisciavi al suolo, apparentemente manipolato da qualcosa dall'aldilà della dimensione @2.\n\"No... no...\"\nLa tua sanità si sgretolò pezzo dopo pezzo, risate deliranti e urla si intrecciavano come una ragnatela gigantesca che imprigionava la tua coscienza, lasciando solo gemiti indistinti a colare dalle tue labbra."
  },
  Event_6824_Name = {
    Text = "Sguardo del Guardiano"
  },
  Event_6825_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6825_Desc = {
    Text = "Consegnalo al Custode perché se ne occupi; chissà che tipo di individuo potrebbe Risvegliare."
  },
  Event_6825_Name = {
    Text = "Nucleo d'Argento Solitario"
  },
  Event_6826_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6826_Desc = {
    Text = "Una melodia malinconica scorre all'orecchio, colmando la mente e l'anima di angoscia e dolore. Prima ancora di rendersene conto, le lacrime hanno già riempito gli occhi di qualcuno."
  },
  Event_6826_Name = {
    Text = "Eco Senza Nome"
  },
  Event_6827_ChoiceDesc1 = {
    Text = "[Open the Left Door] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_6827_ChoiceDesc2 = {
    Text = "[Open the Right Door] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_6827_Desc = {
    Text = "Porte. Porte. Innumerevoli porte.\nSembrano esserci più porte rispetto all'ultima volta che tu e Ramona avete ispezionato.\nTi trovi nel corridoio, pronto a spalancare la prossima porta.\nDietro la porta a sinistra, tutto tace, in silenziosa Attesa del tuo Avvento.\nDietro la porta a destra, si odono Voci Soffocate."
  },
  Event_6827_Name = {
    Text = "Porta dell'Infinito"
  },
  Event_6828_ChoiceDesc1 = {
    Text = "[Listen Closely] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_6828_ChoiceDesc2 = {
    Text = "[Plug Ears] Incidi 1 Orazione su 3"
  },
  Event_6828_Desc = {
    Text = [[
Riesci a udire soltanto i colpi frenetici sui tasti, che assalgono come una tempesta, come meteore che si schiantano al suolo, facendo tremare l'intero pianoforte.
I martelletti scricchiolano e i pedali emettono un lamento lugubre.
Nella melodia inquietante, motivi familiari vengono trascinati, graffiando i tuoi timpani.]]
  },
  Event_6828_Name = {
    Text = "Tono Proibito"
  },
  Event_6829_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6829_Desc = {
    Text = "\"L'Investigatore William ha predisposto una consegna d'emergenza dall'Inventario; toccate la vostra spilla tre volte dopo la ricezione per conferma.\""
  },
  Event_6829_Name = {
    Text = "Comunicazione di supporto"
  },
  Event_6830_ChoiceDesc1 = {
    Text = "[Push Left Door] Incidi 1 Orazione su 3"
  },
  Event_6830_ChoiceDesc2 = {
    Text = "[Push the Right Door] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando, ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_6830_Desc = {
    Text = "Porte. Porte. Innumerevoli porte.\nSembrano esserci più porte rispetto all'ultima volta che tu e Ramona avete ispezionato.\nTi trovi nel corridoio, pronto a spalancare la prossima porta.\nDietro la porta a sinistra, tutto tace, in silenziosa Attesa del tuo Avvento.\nDietro la porta a destra, si odono Voci Soffocate."
  },
  Event_6830_Name = {
    Text = "Porte Infinite"
  },
  Event_6831_ChoiceDesc1 = {
    Text = "[Read the Letter] Distruggi una Carta di comando e ricevi Arg1 Sigilli Neri."
  },
  Event_6831_ChoiceDesc2 = {
    Text = "[Close the Box]"
  },
  Event_6831_Desc = {
    Text = [[
La valigia trema incessantemente, come se una qualche forma di vita stesse rompendo un guscio d'uovo, sul punto di emergere.
Apri incontrollabilmente la valigia, e le lettere si disperdono come farfalle liberate.]]
  },
  Event_6831_Name = {
    Text = "Missiva Inattesa"
  },
  Event_6832_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6832_Desc = {
    Text = "Lo squillo insistente ti fa accelerare il battito. Sollevi la cornetta e la posi sul tavolo. Lo squillo si interrompe bruscamente, come se qualcuno l'avesse afferrato per la gola, lasciando solo un'eco a indugiare nella tua mente."
  },
  Event_6832_Name = {
    Text = "Chiamata dal Treno"
  },
  Event_6833_ChoiceDesc1 = {
    Text = "[Pick up the Photo] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_6833_ChoiceDesc2 = {
    Text = "[Check Film] Sviluppa il Sintomo [(Skill.Arg1)] e cambia l'Orazione da incidere.(Utilizzi: 2/2)"
  },
  Event_6833_Desc = {
    Text = "Nell'angolo dello studio giacciono una vecchia macchina fotografica, alcuni rullini e fotografie sparse. Documentano fedelmente il lavoro e l'estetica dello scultore di cera."
  },
  Event_6833_Name = {
    Text = "Verbale Fedele"
  },
  Event_6834_ChoiceDesc1 = {
    Text = "[Continue Questioning] Aumenta gli HP massimi di Arg1"
  },
  Event_6834_ChoiceDesc2 = {
    Text = "[Afferrare l'ombra] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_6834_Desc = {
    Text = "L'ombra intona nel pulviscolo dorato:\n\"Coloro che conoscono la verità...\nCon la chiave come loro Autorità, indicheranno la via.\"\nUn antico detto.\nIl tuo intuito ti dice che è vicino alla verità che cerchi.\nE il tuo intuito non sbaglia mai."
  },
  Event_6834_Name = {
    Text = "Portatore della Chiave d'Argento"
  },
  Event_6835_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6835_Desc = {
    Text = "Esprimi apertamente il tuo consenso ai Deliri folli, e sotto il fascino di quell'entità demente, rischi quasi di finire sulla sua tavola imbandita."
  },
  Event_6835_Name = {
    Text = "Rito Acquatico"
  },
  Event_6836_ChoiceDesc1 = {
    Text = "[Call the Crow] Ricevi 30 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_6836_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_6836_Desc = {
    Text = [[
Se non te ne vai, nemmeno loro se ne andranno.
Una strana corda lega i vostri spiriti; sembra che abbiano qualcosa da dirti.]]
  },
  Event_6836_Name = {
    Text = "Corvo Solitario"
  },
  Event_6837_ChoiceDesc1 = {
    Text = "[Give Up Resistance] Distruggi una Carta di comando e ricevi Arg1 Sigilli Neri."
  },
  Event_6837_ChoiceDesc2 = {
    Text = "[Pull Back Hands]"
  },
  Event_6837_Desc = {
    Text = "Uno, due, tre...\nSul volto, sulle dita, sciami di farfalle brillano come fuochi d'artificio nel cielo, il loro bagliore simile a gemme trafigge l'oscurità.\nQuesta macchina da scrivere non ha alcuna utilità pratica, ma è maestra nel creare bellezza."
  },
  Event_6837_Name = {
    Text = "Impeto d'Ispirazione"
  },
  Event_6838_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6838_Desc = {
    Text = "Ci sono questioni più importanti di cui occuparsi adesso. Chiudi la scatola, deciso a ignorarla, e la macchina da scrivere gradualmente tace."
  },
  Event_6838_Name = {
    Text = "Avvertimento non richiesto"
  },
  Event_6839_ChoiceDesc1 = {
    Text = "[Listen to the Moon] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_6839_ChoiceDesc2 = {
    Text = "[Listen to the Dwarf Star] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_6839_ChoiceDesc3 = {
    Text = "[Listen to the Meteor] Perdi 25 Sigilli Neri"
  },
  Event_6839_Desc = {
    Text = "Fervente, luminoso, senza fine."
  },
  Event_6839_Name = {
    Text = "Armonie Astrali"
  },
  Event_6840_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6840_Desc = {
    Text = "Al centro del bagliore vi è una goccia di Argento solidificato, eppure la tua ragione ti dice che non sta brillando.\nIl tuo sguardo segue la fonte della luce, solo per incontrare Oscurità e trappole sconosciute..."
  },
  Event_6840_Name = {
    Text = "Bagliore Notturno"
  },
  Event_6841_ChoiceDesc1 = {
    Text = "[Leave] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_6841_Desc = {
    Text = "Lato nord, uscita nord!\nSe Ramona ha deciso così, dev'esserci una via d'uscita a settentrione."
  },
  Event_6841_Name = {Text = "Verso Nord"},
  Event_6842_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6842_Desc = {
    Text = "Oh... l'argento immacolato, uno scherzo che la tua anima ti gioca.\nDunque, qual è la tua prossima scelta?"
  },
  Event_6842_Name = {Text = "Showtime"},
  Event_6843_ChoiceDesc1 = {
    Text = "[Andarsene] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_6843_Desc = {
    Text = [[
Scuoti la testa, scacciando le voci.
Un sospiro appena udibile offre un po' di assistenza.]]
  },
  Event_6843_Name = {Text = "Verso Nord"},
  Event_6844_ChoiceDesc1 = {
    Text = "[Proceed Deeper] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_6844_ChoiceDesc2 = {
    Text = "[Go Against the Flow] Ricevi 25 Sigilli Neri"
  },
  Event_6844_Desc = {
    Text = "La luce lunare svanisce, divorata dal corridoio, lasciando in vista solo una porta minacciosa."
  },
  Event_6844_Name = {
    Text = "Sala Silente"
  },
  Event_6845_ChoiceDesc1 = {
    Text = "[Proceed Deeper] Incidi l'Orazione [(EnchantConfig.Arg1)] su una Carta di comando casuale."
  },
  Event_6845_ChoiceDesc2 = {
    Text = "[Go Against the Flow] Ricevi 25 Sigilli Neri"
  },
  Event_6845_Desc = {
    Text = "Senza piena comprensione, non si dovrebbe indagare oltre."
  },
  Event_6845_Name = {
    Text = "Sala Silente"
  },
  Event_6846_ChoiceDesc1 = {
    Text = "[Proceed Deeper] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_6846_ChoiceDesc2 = {
    Text = "[Go Against the Flow] Ricevi 25 Sigilli Neri"
  },
  Event_6846_Desc = {
    Text = "La porta a sinistra emise una risatina sinistra, tremando leggermente e lasciando cadere fili di malevolenza."
  },
  Event_6846_Name = {
    Text = "Sala Silente"
  },
  Event_6847_ChoiceDesc1 = {
    Text = "[Proceed Deeper] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_6847_ChoiceDesc2 = {
    Text = "[Go Against the Flow] Ricevi 25 Sigilli Neri"
  },
  Event_6847_Desc = {
    Text = "La porta sulla destra è aperta, con tracce di Sangue che seguono un percorso predeterminato sul pavimento."
  },
  Event_6847_Name = {
    Text = "Sala Silente"
  },
  Event_6848_ChoiceDesc1 = {
    Text = "[Leave] Non resta più nulla per te qui."
  },
  Event_6848_Desc = {
    Text = "Chi dice che bisogna sempre lanciarsi in avanti? Fare un passo indietro potrebbe rivelare un mondo nuovo e sconfinato."
  },
  Event_6848_Name = {
    Text = "Sala Silente"
  },
  Event_6849_ChoiceDesc1 = {
    Text = "[Repair Wax Sculpture] Scegli una carta e riduci il suo Costo di Arithmetica di 1"
  },
  Event_6849_Desc = {
    Text = "Il restauro della Scultura di Cera è in corso.\nNon sei uno scultore di cera professionista, né hai ricevuto una formazione estetica formale.\nEppure, con mano esperta cominci a modellare, plasmare e dipingere...\nCome se fossi nato con uno scalpello in mano.\nCome se fosse destinata a essere incompleta, in attesa del tuo tocco."
  },
  Event_6849_Name = {
    Text = "Scultura di Cera Incompiuta"
  },
  Event_6850_ChoiceDesc1 = {
    Text = "[Repair Wax Sculpture] Scegli una carta e riduci il suo Costo di Arithmetica di 1"
  },
  Event_6850_Desc = {
    Text = "Galatea, Galatea...\nSeguendo ancora una volta il richiamo, hai trovato la Scultura di Cera Incompiuta.\nSembrava perfetta, persino in modo inquietante.\n\"La bruttezza è uno strappo nella perfezione.\"\nNell'ultimo istante, decidi di fare qualcosa."
  },
  Event_6850_Name = {
    Text = "Scultura di Cera Incompiuta"
  },
  Event_6851_ChoiceDesc1 = {
    Text = "[Accettare il Fantasma] 1 Carta di comando casuale ottiene l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_6851_ChoiceDesc2 = {
    Text = "[Deny the Illusion] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_6851_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_6851_Desc = {
    Text = "Sotto il pesante e oscuro ponte di ferro, su una riva silenziosa invasa dai giunchi, una farfalla luminosa prese improvvisamente il volo.\nLa farfalla si posò lievemente sul palmo della tua mano. Gli ululati terrificanti cessarono, sostituiti dal rombo di un treno che rotolava su binari arrugginiti, dal crepitio del carbone ardente e dallo stridore metallico degli assi in rotazione..."
  },
  Event_6851_Name = {
    Text = "Miraggio della Ferrovia"
  },
  Event_6852_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6852_Desc = {
    Text = "Sì, stai fuggendo, inseguito da qualche creatura. Il tuo istinto di sopravvivenza ti fa correre disperatamente finché non c'è più via d'uscita. Aspetta, non dovrebbero essere... i segugi infernali da cui non c'è nessuna via di fuga?"
  },
  Event_6852_Name = {Text = "Corri"},
  Event_6853_ChoiceDesc1 = {
    Text = "[This Isn't Real] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_6853_ChoiceDesc2 = {
    Text = "[Falling, falling...] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_6853_Desc = {
    Text = "Gli specchi a terra hanno cornici intricate, cornici dentro cornici, cornici dentro cornici...\nAlice salta giù e continua a cadere nell'infinita tana del coniglio, vedendo specchio dopo specchio, spirito dopo spirito intrappolato, incapace di vedere se stessa."
  },
  Event_6853_Name = {
    Text = "Specchio nello Specchio"
  },
  Event_6854_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6854_Desc = {
    Text = [[
Fissi attraverso la finestra coperta di neve la montagna innevata, molte formiche nere che inseguono una singola formica nera...
Il filo dei tuoi pensieri si interrompe.]]
  },
  Event_6854_Name = {
    Text = "Memoria Vulcanica"
  },
  Event_6855_ChoiceDesc1 = {
    Text = "[Step Forward and Grip] 100% di probabilità di ottenere 25 Sigilli Neri"
  },
  Event_6855_ChoiceDesc2 = {
    Text = "[Friendly Response] 50% di probabilità di ottenere 50 Sigilli Neri, 50% di probabilità di non ottenere nulla."
  },
  Event_6855_Desc = {
    Text = [[
Un gatto di origine sconosciuta siede tra le D-melma, il suo corpo sfocato suggerisce che appartenga alla Dimensione spirituale.
Questa indistinta Proiezione osserva Ramona con occhi saggi, alza la zampa bianca e la invita ad avvicinarsi.]]
  },
  Event_6855_Name = {
    Text = "Abitante Errante"
  },
  Event_6856_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6856_Desc = {
    Text = "Un vivace ritratto di gruppo.\nLe sculture di cera sono agghindate e sedute in bell'ordine, tutte con lo stesso sorriso esagerato.\nAppaiono armoniose quanto ciò che si potrebbe vedere in un qualsiasi manicomio.\n\nDatato: P.S. 305, @2 Rogers"
  },
  Event_6856_Name = {
    Text = "Galleria dei Ritratti"
  },
  Event_6857_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6857_Desc = {
    Text = "\nRaccogli con cura i frammenti e li esamini da vicino. È di nuovo immobile.\n\"Attento a quelle mani maldestre, non muoverti,\" Doll ti dà un leggero colpetto sulla nuca, \"non posso fabbricarne un secondo pezzo in poco tempo.\""
  },
  Event_6857_Name = {
    Text = "Spilla Inquieta"
  },
  Event_6858_ChoiceDesc1 = {Text = "[Use Key]"},
  Event_6858_ChoiceDesc2 = {Text = "[Leave]"},
  Event_6858_Desc = {
    Text = "Una porta blocca il tuo cammino. Hai provato ogni metodo, eppure resta saldamente al suo posto."
  },
  Event_6858_Name = {
    Text = "Porta arrugginita"
  },
  Event_6858_Tips1 = {
    Text = "Devi trovare la \"Chiave arrugginita\"."
  },
  Event_6859_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6859_Desc = {
    Text = "Ti sei vergognato della tua fretta.\nUn Custode qualificato deve essere rigoroso; non dovresti giudicare avventatamente che non siano \"Beni di pregio.\"\nCosì hai deciso di osservarli attentamente. Cinque minuti sono passati, dieci minuti sono passati...\nBene, ora puoi esprimere un giudizio—\nSono davvero cianfrusaglie."
  },
  Event_6859_Name = {
    Text = "Anima Incatenata"
  },
  Event_6860_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6860_Desc = {
    Text = "Tu e i tuoi compagni deponete le armi.\nNon è per bontà d'animo; sapete che i loro corpi fragili non possono resistere a lungo.\nSi scopre che avevate ragione."
  },
  Event_6860_Name = {Text = "Bozzetto"},
  Event_6861_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6861_Desc = {
    Text = [[

"Vieni a prendermi!"
"Forza, sciocco!"
"Se ci riesci, acchiappaci!"
Le voci dei fanciulli erano piene di orgoglio.
"Maledizione! Fermatevi!"
La voce dell'adulto era senza fiato.]]
  },
  Event_6861_Name = {
    Text = "I Nostri Ricordi"
  },
  Event_6862_ChoiceDesc1 = {
    Text = "[Enter] Guada attraverso la nebbia per raggiungere l'altro lato."
  },
  Event_6862_ChoiceDesc2 = {Text = "[Leave]"},
  Event_6862_Desc = {
    Text = "Ecco la persona che stavi cercando. Hai completato il compito."
  },
  Event_6862_Name = {
    Text = "Passaggio a Senso Unico 26"
  },
  Event_6863_ChoiceDesc1 = {
    Text = "[Leave] Acquisisci la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_6863_Desc = {
    Text = "Ah! Mancato per un soffio! Ma aspetta, com'è possibile che tre dadi diano dieci?\nI dadi giacciono quieti davanti a te, dall'aria innocente e obbediente."
  },
  Event_6863_Name = {
    Text = "Scommessa Senza Fine"
  },
  Event_6864_ChoiceDesc1 = {
    Text = "[Leave] Ottieni la Reliquia d'Oro [(RelicConfig.Arg1)]"
  },
  Event_6864_Desc = {
    Text = "Dannazione! Non sono le sei, ma c'è ancora qualche profitto da ricavare.\nQuindi, che ore sono esattamente?"
  },
  Event_6864_Name = {
    Text = "Scommessa Senza Fine"
  },
  Event_6865_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_6865_Desc = {
    Text = [[
Anche se non ho indovinato, posso accettarlo.
Ah, a che ora hanno votato?]]
  },
  Event_6865_Name = {
    Text = "Scommessa Senza Fine"
  },
  Event_6866_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6866_Desc = {
    Text = "Abbassi lo sguardo, raccogliendo frammenti di gesso, ricomponendola pezzo dopo pezzo. Parte del suo corpo prende gradualmente forma sotto le tue mani."
  },
  Event_6866_Name = {
    Text = "Resti Rattoppati"
  },
  Event_6867_ChoiceDesc1 = {
    Text = "[Pick Up Key]"
  },
  Event_6867_Desc = {
    Text = "Un mazzo di chiavi arrugginite. Può essere usato per aprire le porte."
  },
  Event_6867_Name = {
    Text = "Chiave arrugginita"
  },
  Event_6868_ChoiceDesc1 = {
    Text = "[Silver Chip] 50% di probabilità di ottenere la Reliquia d'oro \"(RelicConfig.Arg2)\", 50% di probabilità di sviluppare \"(Skill.Arg3)\""
  },
  Event_6868_ChoiceDesc2 = {
    Text = "[Red Chip] 50% di probabilità di ricevere 75 Sigilli Neri, 50% di probabilità di sviluppare [(Skill.Arg3)]"
  },
  Event_6868_ChoiceDesc3 = {
    Text = "[Let Them Choose] 50% di probabilità di ottenere la Reliquia maledetta \"(RelicConfig.Arg2)\", 50% di probabilità di sviluppare \"(Skill.Arg3)\""
  },
  Event_6868_Desc = {
    Text = "È solo una scommessa. Non perderai.\nLa moneta, incisa con motivi intricati, viene lanciata in alto nell'aria, ridiscende rapidamente e si scalda nel palmo della tua mano."
  },
  Event_6868_Name = {
    Text = "Giocatore d'Azzardo Famigerato"
  },
  Event_6869_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_6869_Desc = {
    Text = [[
"Coloro che ripongono la propria fiducia nel favore del destino ne saranno anche rovesciati."
Scegli di andartene.]]
  },
  Event_6869_Name = {
    Text = "Giocatore d'Azzardo Famigerato"
  },
  Event_6870_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6870_Desc = {
    Text = [[
"Custode."
La voce di Ramona ti riporta in te, ma la sensazione di cadere non si dissipa.]]
  },
  Event_6870_Name = {
    Text = "Specchio nello Specchio"
  },
  Event_6871_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6871_Desc = {
    Text = [[
Si dice che le serenate siano canti nati dall'amore.
Nelle notti d'estate, sotto la finestra dell'amata, la gente suona insieme queste tenere melodie.
Casuali e superficiali, non si addicono ai gusti di Rogers, eppure restano nel suo repertorio.
Forse solo lui ne conosce il motivo.]]
  },
  Event_6871_Name = {
    Text = "Cattivo Gusto"
  },
  Event_6872_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6872_Desc = {
    Text = "\nRifiuti di cedere alla tentazione dei loro sussurri.\nHai detto: \"Bugiardi! Siete intrappolati nella Notte Eterna più oscura. Come potreste attraversare l'universo?\"\nGli occhi risero. Innumerevoli risate confluirono in un fragore immenso, facendo tremare il tuo cuore.\nGli occhi dissero: \"Depredando altri occhi. Ogni occhio è un universo. Quando possiederai mille occhi, intraprenderai un vero viaggio attraverso il tempo e lo spazio.\""
  },
  Event_6872_Name = {Text = "Occhio"},
  Event_6873_ChoiceDesc1 = {
    Text = "[Receive] Acquisisci 1 Reliquia Dorata su 3"
  },
  Event_6873_Desc = {
    Text = "Oh sì, quel riflesso odioso sei tu.\nLa malevolenza montante si fonde con la melma nera ai tuoi piedi, contorcendosi e danzando insieme. Se non ti dispiace, vorrebbe arrampicarsi anche sulla tua spalla."
  },
  Event_6873_Name = {
    Text = "Sotto lo Specchio"
  },
  Event_6874_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6874_Desc = {
    Text = "Dopo poco, i vincoli si allentarono improvvisamente, facendoti inciampare.\nTi voltasti a guardare i fili silenziosi — \"Non disturbare le sabbie mobili\", questo detto potrebbe valere anche nel Dominio."
  },
  Event_6874_Name = {
    Text = "Intrappolato"
  },
  Event_6875_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6875_Desc = {
    Text = "Il Fuoco della Gnosi si accende, bruciando ogni vincolo—\nAlmeno, è ciò che credi."
  },
  Event_6875_Name = {
    Text = "Intrappolato"
  },
  Event_6876_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6876_Desc = {
    Text = "Ti liberi con tutte le tue forze. I fili strappano i tuoi vestiti, lasciando sottili tagli sulla pelle.\nSebbene la ragnatela abbia esatto il suo tributo, ti senti sollevato— sei libero."
  },
  Event_6876_Name = {
    Text = "Intrappolato"
  },
  Event_6877_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6877_Desc = {
    Text = "La lettera prodotta dall'escrescenza della Dissoluzione ha spesso la maggior parte delle informazioni cancellate.\nNon sei riuscito a estrarne alcuna informazione utile, così hai strappato la lettera e ne hai disperso i frammenti."
  },
  Event_6877_Name = {
    Text = "Capitolo della Farfalla"
  },
  Event_6878_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6878_Desc = {
    Text = "Anche se le parole sono state deliberatamente cancellate, riesci ancora a percepire chiaramente il valore della lettera."
  },
  Event_6878_Name = {
    Text = "Capitolo della Farfalla"
  },
  Event_6879_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6879_Desc = {
    Text = "Meglio prevenire che curare.\nRamona si accovacciò, tornò nel corridoio e si intrufolò nella stanza successiva."
  },
  Event_6879_Name = {
    Text = "Riflesso nella Finestra"
  },
  Event_6880_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6880_Desc = {
    Text = "Emetti uno Strido disperato.\nLo stormo di corvi, apparentemente attirato dalla tua voce, svanisce rapidamente, lasciando dietro di sé tracce oscure."
  },
  Event_6880_Name = {
    Text = "Canto dei Corvi"
  },
  Event_6881_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6881_Desc = {
    Text = [[
Rannicchi il tuo corpo, cercando di rimpicciolirti in un minuscolo punto nero.
Forse non ti noteranno.
Dopo qualche tempo, apri gli occhi.
Vedi la luce.]]
  },
  Event_6881_Name = {
    Text = "Canto dei Corvi"
  },
  Event_6882_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6882_Desc = {
    Text = "L'ombra scivola dolcemente tra le mie dita, lasciando dietro di sé una scia di polvere dorata."
  },
  Event_6882_Name = {
    Text = "Portatore della Chiave d'Argento"
  },
  Event_6883_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6883_Desc = {
    Text = [[
Ti scompigli i capelli con foga mentre immaginazioni selvagge e deliri ti attraversano la mente, con grumi neri e viscidi nascosti nel profondo.
Che tipo di dono riceverai se li dissezionassi?]]
  },
  Event_6883_Name = {
    Text = "Agitazione mentale"
  },
  Event_6884_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6884_Desc = {
    Text = "Macchie d'olio variopinte riempiono gradualmente la tua Visuale, trascinando le tue emozioni in un tripudio caotico."
  },
  Event_6884_Name = {
    Text = "Agitazione mentale"
  },
  Event_6885_ChoiceDesc1 = {Text = "[Take It]"},
  Event_6885_Desc = {
    Text = "Una sostanza argentea simile al mercurio, raffinata dalla D-melma, contenente un forte potere mentale, utilizzata per collegare più Risvegliatori nei rituali Una sostanza argentea simile al mercurio, raffinata dalla D-melma, contenente un forte potere mentale, utilizzata per collegare più Risvegliatori nei rituali."
  },
  Event_6885_Name = {Text = "Argento"},
  Event_6886_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6886_Desc = {
    Text = [[
Una risata sgorga dalla scatola e, dopo che il caldo bagliore svanisce, scorgi una cartolina con tre figure stilizzate: tu, Ramona dai capelli argentei e Ogier dai capelli biondi. Accanto, una riga di testo recita:
"Grazie a tutti!"]]
  },
  Event_6886_Name = {
    Text = "Un Dono di Gentilezza"
  },
  Event_6887_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6887_Desc = {
    Text = "Il tuo corpo ha schivato lo sciame di farfalle, ma esse non hanno perso il loro bersaglio. Si sono infilate nella tua valigia, succhiando avidamente l'inchiostro dalla tua Macchina da scrivere."
  },
  Event_6887_Name = {
    Text = "Eruzione di Delirio"
  },
  Event_6888_ChoiceDesc1 = {
    Text = "[Indicare l'errore] Scegli 1 Carta di comando per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_6888_ChoiceDesc2 = {
    Text = "[Listen to the Performance] Ricevi 15 Sigilli Neri per ogni Risvegliato con 50 o più Aliemus."
  },
  Event_6888_ChoiceDesc3 = {
    Text = "[Leave] Incidi 1 Orazione su 3"
  },
  Event_6888_Desc = {
    Text = "Il Ragazzo Scultura di Cera siede al pianoforte, esercitandosi.\nIl suo maestro—anch'egli una Scultura di Cera—lo guida lì accanto.\n133, 355, 244...\nSbagliato, ogni nota è sbagliata."
  },
  Event_6888_Name = {
    Text = "Lezione di pianoforte"
  },
  Event_6889_ChoiceDesc1 = {
    Text = "[Give Up Resistance] Distruggi una Carta di comando e ricevi Arg1 Sigilli Neri."
  },
  Event_6889_ChoiceDesc2 = {
    Text = "[Pull Back Hands]"
  },
  Event_6889_Desc = {
    Text = "Non riesci a resistere all'impulso che ti pervade.\nLe tue dita vagano e danzano sulla tastiera come fanciulli smarriti in una foresta...\nA poco a poco, farfalle emergono dalla macchina da scrivere.\nUna, due, tre...\nSul tuo volto, sulle tue dita, sciami di farfalle scintillano come fuochi d'artificio, brillando come gemme nell'oscurità.\nQuesta macchina da scrivere non ha alcun uso pratico, ma è maestra nel creare bellezza."
  },
  Event_6889_Name = {
    Text = "Impeto d'Ispirazione"
  },
  Event_6890_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6890_Desc = {
    Text = "\nHai sollevato il foglio contro la luce rosso scuro, temendo di perdere un dettaglio.\nEra un referto medico, e il soggetto esaminato era Mason.\n\"Peso 40 kg, livello di ossigeno nel sangue normale, Affinità 30%, valore di Risonanza...\"\nVolevi continuare a leggere, ma la scrittura svanì gradualmente.\nPulito, come se nulla fosse mai accaduto."
  },
  Event_6890_Name = {
    Text = "Macchina da scrivere"
  },
  Event_6891_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6891_Desc = {
    Text = "Sì, non stai fuggendo; stai inseguendo un bersaglio preciso — il \"Segugio infernale\" che sfreccia tra i vicoli umidi, angusti e innevati. Non lo dimenticherai, così come non dimenticherai il volto di colui che ti trasse dalle rovine quel giorno a Tunguska... Chi era, poi?"
  },
  Event_6891_Name = {Text = "Corri"},
  Event_6892_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6892_Desc = {
    Text = "In questo spazio isolato da tutto il resto, puoi contare solo su te stesso."
  },
  Event_6892_Name = {
    Text = "Viandante dell'Incubo"
  },
  Event_6893_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6893_Desc = {
    Text = "Crisi e rischio coesistono. Nel momento in cui tocchi la serratura di ferro, una melma corrosiva brucia il tuo palmo. Si spera che la reliquia dietro la porta ne valga la pena."
  },
  Event_6893_Name = {
    Text = "Dietro i Cancelli di Ferro"
  },
  Event_6894_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6894_Desc = {
    Text = "Vagando incautamente per mondi inesplorati, la tua fragile sanità mentale non si è ancora deteriorata al punto di perdere la ragione.\nL'orrore dell'ignoto è qualcosa che comprendi nel profondo."
  },
  Event_6894_Name = {
    Text = "Viandante dell'Incubo"
  },
  Event_6895_ChoiceDesc1 = {
    Text = "[Loud Shout] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_6895_ChoiceDesc2 = {
    Text = "[Embrace Silence] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\" e \"(Skill.Arg3)\"."
  },
  Event_6895_ChoiceDesc3 = {
    Text = "[Surface] Ricevi 25 Sigilli Neri"
  },
  Event_6895_Desc = {
    Text = [[
Odi il silenzio.
Un silenzio amplificato, come il suono delle onde, riempie l'intero spazio.

Alzi lo sguardo, come un minuscolo punto che contempla le stelle.]]
  },
  Event_6895_Name = {
    Text = "Acque del Lete"
  },
  Event_6896_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6896_Desc = {
    Text = [[
Tendi le orecchie, cercando la fonte del suono, tentando di cogliere il disturbatore.
Ma sembra uno scherzo deliberato. Proprio quando credi di averlo messo all'angolo, ti ritrovi al punto di partenza.
Frustrato, sfoghi un calcio contro un muro di mattoni, facendone cadere uno che rivela un segreto scintillante nascosto all'interno.]]
  },
  Event_6896_Name = {
    Text = "Eco Perduta"
  },
  Event_6897_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6897_Desc = {
    Text = "Dev'essere un problema di riproduzione, deve esserlo.\nCon scetticismo riporti indietro la puntina, sopportando la terribile prima metà, ma il familiare suono di bussare non arriva mai.\nDietro di te, nel vuoto, una piccola ombra sul pavimento sgattaiola via in silenzio."
  },
  Event_6897_Name = {
    Text = "Eco Perduta"
  },
  Event_6898_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6898_Desc = {
    Text = "Non c'è nessuno intorno a te. Il Segreto del ticchettio dev'essere nascosto nel meccanismo all'interno del Fonografo.\nFidandoti del tuo Giudizio, smonti il vecchio Fonografo.\nA parte parti metalliche corrose e uno spesso strato di polvere, non trovi nulla.\nSolo una risatina sommessa si dissolve nella nebbia, lieve come un Sogno."
  },
  Event_6898_Name = {
    Text = "Eco Perduta"
  },
  Event_6899_ChoiceDesc1 = {
    Text = "[Fool's White Matter] Recupera Arg1 HP"
  },
  Event_6899_ChoiceDesc2 = {
    Text = "[Madman's Heart] Incidi l'Orazione [(EnchantConfig.Arg1)] su una Carta di comando casuale."
  },
  Event_6899_ChoiceDesc3 = {
    Text = "[Refuse to Eat] Ricevi 25 Sigilli Neri"
  },
  Event_6899_Desc = {
    Text = "\"La materia bianca del Folle è deliziosa come una zuppa di pesce bollente, mentre il cuore del pazzo è cotto in uno scone caldo e sanguinolento.\"\nL'Ombra ghignò malignamente, presentandoti un piatto contenente ingredienti sconosciuti.\nInspirasti profondamente; l'aroma travolgente invase con prepotenza le tue narici. Le tue ghiandole salivari, del tutto umiliate, si arresero per prime, e il tuo stomaco si contorse in agonia, emettendo un gemito lamentoso di Desiderio."
  },
  Event_6899_Name = {
    Text = "Banchetto di Carne"
  },
  Event_6900_ChoiceDesc1 = {
    Text = "[Touch Wind Chime] Incidi l'Orazione \"(EnchantConfig.Arg2)\" su una Carta di comando casuale, ma sviluppa \"(Skill.Arg1)\"."
  },
  Event_6900_ChoiceDesc2 = {
    Text = "[Observe Wind Chime] Incidi l'Orazione \"(EnchantConfig.Arg2)\" su una Carta di comando casuale, ma sviluppa \"(Skill.Arg1)\"."
  },
  Event_6900_ChoiceDesc3 = {
    Text = "[Do Nothing] Incidi l'Orazione [(EnchantConfig.Arg1)] su una Carta di comando casuale."
  },
  Event_6900_Desc = {
    Text = "Din din, din din...\nQuesto è un carillon arrugginito, con note goffe che serpeggiano tra le fessure."
  },
  Event_6900_Name = {
    Text = "Carillon arrugginito"
  },
  Event_6901_ChoiceDesc1 = {
    Text = "[Wait and See] Cerca di sopravvivere"
  },
  Event_6901_ChoiceDesc2 = {
    Text = "[Swing Weapon] Tenta di sfondare"
  },
  Event_6901_ChoiceDesc3 = {
    Text = "[Hold a Hand] Ricevi 25 Sigilli Neri"
  },
  Event_6901_Desc = {
    Text = "Una palude nera si forma improvvisamente sotto i vostri piedi, con innumerevoli mani che ne emergono.\nEsibiscono una varietà di colori, texture e materiali — blu pavone, squamose, o persino dotate di occhi — sembrano attraversare innumerevoli dimensioni e spazi, tentando di trascinare la prossima anima sfortunata nella loro famiglia.\nDecidete di—"
  },
  Event_6901_Name = {
    Text = "Palude Cupa"
  },
  Event_6902_ChoiceDesc1 = {
    Text = "[Hold it] Duplica 1 Carta di comando su 3"
  },
  Event_6902_ChoiceDesc2 = {
    Text = "[Scuotere un po'] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_6902_ChoiceDesc3 = {
    Text = "[Do Nothing] Ricevi 25 Sigilli Neri"
  },
  Event_6902_Desc = {
    Text = "Din din, din din...\nQuesto è un carillon arrugginito, con note goffe che serpeggiano tra le fessure."
  },
  Event_6902_Name = {
    Text = "Piccolo Carillon"
  },
  Event_6903_ChoiceDesc1 = {
    Text = "[Counter Them] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)], ma sviluppa 1 Sintomo su 3."
  },
  Event_6903_ChoiceDesc2 = {
    Text = "[Follow Them] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando, ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_6903_ChoiceDesc3 = {
    Text = "[Suggest New Idea] Ricevi 25 Sigilli Neri"
  },
  Event_6903_Desc = {
    Text = "\n\"Per favore, mantenete le distanze da noi.\"\nUno sciame di ratti vi circondò, mantenendo almeno un metro e mezzo di distanza.\n\"Ci adoperiamo per moltiplicarci, prosperiamo; non siamo schizzinosi nel mangiare — e così portiamo malattie, angoscia e sofferenza all'umanità.\"\n\"Non dovremmo avvicinarci troppo agli umani; questo non è un posto per voi.\"\nPer far abbassare la guardia ai ratti, decideste di—"
  },
  Event_6903_Name = {Text = "Peste"},
  Event_6904_ChoiceDesc1 = {
    Text = "[Descend Further] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_6904_ChoiceDesc2 = {
    Text = "[Pull Away] Ricevi 25 Sigilli Neri"
  },
  Event_6904_Desc = {
    Text = "\"Tu\" ti invita ad andare più a fondo.\nNelle profondità della spirale, il \"tu\" del passato e del futuro ti inviano \"doni\" da dimensioni diverse."
  },
  Event_6904_Name = {Text = "Abisso"},
  Event_6905_ChoiceDesc1 = {
    Text = "[Pin Down the Crow] Ricevi 40 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_6905_ChoiceDesc2 = {
    Text = "[Ignore It] Ottieni 25 Sigilli Neri e vattene."
  },
  Event_6905_Desc = {
    Text = "Il corvo solitario, con voce rauca, si strappa le piume nere una a una.\nTrema di dolore, emettendo grida acute, eppure non riesce a fermare il suo ritmo sempre più frenetico.\n\"Cra—Cra—\"\nLacrime azzurre miste a melma nera gli colano dagli occhi, e tu sei l'unico testimone."
  },
  Event_6905_Name = {
    Text = "Lacrima di Magma"
  },
  Event_6906_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6906_Desc = {
    Text = "Rosso, appassionato, vibrante e sorprendente. Mi capita di conoscere una tale bellezza, e la incontrerai a tempo debito.\nQuindi, qual è la tua prossima scelta?"
  },
  Event_6906_Name = {Text = "Showtime"},
  Event_6907_ChoiceDesc1 = {
    Text = "[Loud Cheer]"
  },
  Event_6907_ChoiceDesc2 = {Text = "[Drowsy]"},
  Event_6907_Desc = {
    Text = "Hai fatto un Lungo Sogno.\nNel Sogno, eri tra il pubblico, a guardare un ragazzo cantare sul palco.\n\"Il vecchio Charlie aveva un'adorata gatta tigrata.\nQuando scomparve, la cercò ovunque.\"\n.....\nLa voce vuota e roca si ripeteva meccanicamente, senza fine."
  },
  Event_6907_Name = {
    Text = "Fine Ultima IV"
  },
  Event_6908_ChoiceDesc1 = {
    Text = "[Unravel the Upper Branch]"
  },
  Event_6908_ChoiceDesc2 = {
    Text = "[Unravel the Lower Branch]"
  },
  Event_6908_Desc = {
    Text = [[
La Gnosi residua nel Dominio si interconnette, intrecciandosi in un campo di forza instabile.
Forse, puoi dipanare la Gnosi e aprire un sentiero davanti a te.]]
  },
  Event_6908_Name = {
    Text = "Sentiero Intrecciato"
  },
  Event_6909_ChoiceDesc1 = {
    Text = "[Leave] Risveglio di 2 Risvegliatori"
  },
  Event_6909_Desc = {
    Text = "\nTi alzasti in piedi e ti lanciasti verso la porta.\n\"Hai sollevato il telo che la copriva...\nUn segreto, hai scoperto un segreto...\"\nIl fragore confluì in un oceano cacofonico, e il pavimento tremò violentemente con una risonanza terrificante.\nNon osasti voltarti indietro e fuggisti dalla scena più in fretta che potevi."
  },
  Event_6909_Name = {
    Text = "Fine Ultima V"
  },
  Event_6910_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6910_Desc = {
    Text = "Non opponi resistenza, ma neppure ti abbandoni."
  },
  Event_6910_Name = {
    Text = "Ulcera Cranica"
  },
  Event_6911_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6911_Desc = {
    Text = "Hai smesso di resistere, lasciando che la lordura divorasse il tuo corpo e il tuo spirito. Dopo un lungo dormiveglia, la luce argentea cadde nelle tue mani giunte."
  },
  Event_6911_Name = {
    Text = "Ulcera Cranica"
  },
  Event_6912_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6912_Desc = {
    Text = "Più ti dibatti, più la lordura affonda nella tua mente. Sepolto nelle profondità di un cervello oppresso dal peccato giace un dono enigmatico."
  },
  Event_6912_Name = {
    Text = "Ulcera Cranica"
  },
  Event_6913_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6913_Desc = {
    Text = "Quando la rete si frantuma, qualcosa lampeggia nella tua mente: sembrano i volti sorridenti di alcuni fanciulli."
  },
  Event_6913_Name = {
    Text = "Rete Vagale"
  },
  Event_6914_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_6914_Desc = {
    Text = "Il gatto annuì soddisfatto, poi svanì in un'ombra, lasciando dietro di sé diversi oggetti circolari neri."
  },
  Event_6914_Name = {
    Text = "Abitante Errante"
  },
  Event_6915_ChoiceDesc1 = {
    Text = "[Read the Letter] Distruggi una Carta di comando e ricevi Arg1 Sigilli Neri."
  },
  Event_6915_ChoiceDesc2 = {
    Text = "[Close the Box]"
  },
  Event_6915_Desc = {
    Text = "Lettere del Battito d'Ali riempiono il cielo, come un'esortazione silenziosa."
  },
  Event_6915_Name = {
    Text = "Missiva Inattesa"
  },
  Event_6916_ChoiceDesc1 = {
    Text = "[Enter] Guada attraverso la nebbia per raggiungere l'altro lato."
  },
  Event_6916_ChoiceDesc2 = {Text = "[Leave]"},
  Event_6916_Desc = {
    Text = "Un tunnel nascosto appare sulla strada davanti a te, avvolto da una nebbia nera. La sua destinazione è sconosciuta."
  },
  Event_6916_Name = {Text = "Tunnel"},
  Event_6917_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6917_Desc = {
    Text = [[
Decidi di porre fine alla sua sofferenza, allungando la mano per afferrare il suo corpo morbido, stringendo... stringendo...
Si dibatte disperatamente nel tuo palmo, esplodendo infine in un caldo schizzo di liquido.]]
  },
  Event_6917_Name = {
    Text = "Lacrima di Magma"
  },
  Event_6918_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6918_Desc = {
    Text = "Non preoccuparti, questi sono solo frammenti delle memorie altrui nella Dimensione. Tu hai un'ombra. Ma la persona nell'ombra è davvero ancora te?"
  },
  Event_6918_Name = {
    Text = "Frammento di Memoria: Birra"
  },
  Event_6919_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6919_Desc = {
    Text = [[
Allontani con forza il becco del corvo che si strappa le Piume, ma quello si contorce di nuovo implacabile, la sua forza fa Scricchiolare le tue ossa.
Il tuo viso si arrossa mentre impieghi tutta la tua forza per immobilizzare il corpo del corvo, arrestando la sua frenetica automutilazione.
Proprio mentre tiri un sospiro di sollievo, il collo mezzo spennato del corvo scatta bruscamente all'indietro, il corpo si affloscia e si trasforma in una pozza di melma nera tra le tue mani.]]
  },
  Event_6919_Name = {
    Text = "Lacrima di Magma"
  },
  Event_6920_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6920_Desc = {
    Text = "Hai ignorato con freddezza quegli squilli disperati.\nAnche se il secondo dopo saresti stato scaraventato nel mondo primitivo, anche se tu e la tua grande missione sareste stati sepolti insieme.\nUna chiamata a cui non si deve rispondere semplicemente non può ricevere risposta.\nComprendi bene questa semplice verità."
  },
  Event_6920_Name = {
    Text = "Rispondi alla Chiamata"
  },
  Event_6921_ChoiceDesc1 = {
    Text = "[Lower Gaze] Ricevi 25 Sigilli Neri"
  },
  Event_6921_ChoiceDesc2 = {
    Text = "[I Must Find It] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_6921_Desc = {
    Text = "\nHai inseguito l'ombra in avanti, mettendo improvvisamente il piede in una pozza poco profonda. Il liquido incolore ha inzuppato le tue scarpe, facendoti percorrere un brivido.\nUna voce parlò nell'acqua: \"Non vorresti scoprirlo.\""
  },
  Event_6921_Name = {
    Text = "Ciò che Non Dovresti Cercare"
  },
  Event_6922_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6922_Desc = {
    Text = "Una scelta sicura."
  },
  Event_6922_Name = {
    Text = "Sottovento del Pagliaio"
  },
  Event_6923_ChoiceDesc1 = {
    Text = "[Chase the Crows] Ricevi Arg1 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_6923_ChoiceDesc2 = {
    Text = "[Disregard] Ricevi 25 Sigilli Neri e vattene."
  },
  Event_6923_Desc = {
    Text = [[
Come possono esserci corvi nella stanza del manicomio?
Ma ne senti chiaramente il gracchiare. Una forza invisibile osserva dalle ombre, attraverso occhi cavi di uccello. Queste creature nere torcono il collo, appollaiate sui lampioni, fissandoti con sguardo malevolo. Le loro teste sovrapposte sembrano condividere un unico corpo immerso nella D-melma.]]
  },
  Event_6923_Name = {
    Text = "Corvo della Lanterna"
  },
  Event_6924_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6924_Desc = {
    Text = "Non temere la lordura; ne guadagni più di quanto perdi."
  },
  Event_6924_Name = {
    Text = "Sottovento del Pagliaio"
  },
  Event_6925_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6925_Desc = {
    Text = "La tempesta della Gnosi circonda Tulu. Scambi uno sguardo con lui e vi addentrate nell'Oscurità uno dopo l'altro."
  },
  Event_6925_Name = {
    Text = "Promessa dell'Emissario"
  },
  Event_6926_ChoiceDesc1 = {
    Text = "[Enter] Guada attraverso la nebbia per raggiungere l'altro lato."
  },
  Event_6926_ChoiceDesc2 = {Text = "[Leave]"},
  Event_6926_Desc = {
    Text = "Sprofondi nell'Oscurità.\nAl margine del tuo campo visivo, un filo di luce filtra attraverso una fessura simile a un buco della serratura.\nLa Chiave d'Argento emette un debole bagliore, guidandoti nel Passaggio Segreto."
  },
  Event_6926_Name = {
    Text = "Passaggio a Senso Unico"
  },
  Event_6927_ChoiceDesc1 = {
    Text = "[Infect \"(Skill.Arg1)\", acquire Relic: \"(RelicConfig.Arg2)\"]"
  },
  Event_6927_ChoiceDesc2 = {
    Text = "[Choose 1 out of 3 Command Cards to gain the Orison: \"(EnchantConfig.Arg1)\"]"
  },
  Event_6927_Desc = {
    Text = "Evento 203 (In sviluppo), Effetto non definitivo"
  },
  Event_6927_Name = {
    Text = "Evento 203 (In sviluppo)"
  },
  Event_6928_ChoiceDesc1 = {
    Text = "[Patch Her Up] Distruggi una Carta di comando e ottieni la Reliquia [(RelicConfig.Arg1)]."
  },
  Event_6928_ChoiceDesc2 = {
    Text = "[Touch] Distruggi una carta Colpo o Difesa e incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_6928_ChoiceDesc3 = {
    Text = "[Disgust] Ricevi 25 Sigilli Neri"
  },
  Event_6928_Desc = {
    Text = [[
"Ti piacciono i miei resti? Se possibile, potresti aiutarmi a ricomporre il mio corpo?"
Le labbra della statua di gesso dimezzata si mossero, e una voce delicata, morbida come seta, emerse da quelle labbra che avrebbero dovuto essere dure e fredde.]]
  },
  Event_6928_Name = {
    Text = "Resti Rattoppati"
  },
  Event_6929_ChoiceDesc1 = {
    Text = "[Discard Envelope] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_6929_ChoiceDesc2 = {
    Text = "[Tucked in the Chest] Ottieni la Reliquia \"(RelicConfig.Arg2)\", ma sviluppi il Sintomo \"(Skill.Arg1)\"."
  },
  Event_6929_Desc = {
    Text = "Questa è una lettera di soccorso. L'autore cerca di mantenere la calma, ma la grafia tremolante tradisce di tanto in tanto la sua paura più profonda.\n\"Tutto questo va completamente oltre ogni mia aspettativa. Se qualcuno mi dicesse che sono vittima di una maledizione, giurerei di crederci.\"\n\"Alcuni dicono che sono pazzo. Hanno ragione a metà. Sto barcollando sull'orlo della follia.\"\n\"Ma l'ho visto davvero! Muta e svanisce, quella melma nera proliferante che cerca di strisciare su tutto il mio corpo!\"\n\"Sono fuggito! Ho corso più veloce che potevo, ma lo sguardo non mi ha mai abbandonato. Ho la sensazione che mi troverà! Quella ripugnante fanghiglia nera invaderà di nuovo il mio cranio. Chiunque riceva questa lettera, vi prego, salvatemi—\""
  },
  Event_6929_Name = {
    Text = "Lettera di soccorso"
  },
  Event_6930_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6930_Desc = {
    Text = "\"Calmati,\" Ramona ti dà un colpetto sulla testa, \"sono solo frammenti del passato. Non so chi li abbia lasciati in questo passaggio dimensionale.\"\nIn effetti, c'è un profumo nostalgico."
  },
  Event_6930_Name = {
    Text = "Missiva Urgente"
  },
  Event_6931_ChoiceDesc1 = {
    Text = "[1 random Command Card gains Orison: \"(EnchantConfig.Arg1)\"]"
  },
  Event_6931_ChoiceDesc2 = {
    Text = "[1 random Command Card gains Orison: \"(EnchantConfig.Arg1)\"]"
  },
  Event_6931_ChoiceDesc3 = {
    Text = "[1 random Command Card gains Orison: \"(EnchantConfig.Arg1)\"]"
  },
  Event_6931_Desc = {
    Text = "Evento 205 (In sviluppo), Effetto non definitivo"
  },
  Event_6931_Name = {
    Text = "Evento 205 (In sviluppo)"
  },
  Event_6932_ChoiceDesc1 = {
    Text = "[Obtain Relic: (\"(RelicConfig.Arg1)\"]"
  },
  Event_6932_ChoiceDesc2 = {
    Text = "[Obtain Relic: (\"(RelicConfig.Arg1)\"]"
  },
  Event_6932_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_6932_Desc = {
    Text = "Evento 204 (In sviluppo), Effetto non definitivo"
  },
  Event_6932_Name = {
    Text = "Evento 204 (In sviluppo)"
  },
  Event_6933_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6933_Desc = {
    Text = "La luna solitaria pende alta nel cielo, eppure puoi udire chiaramente la sua preghiera — una strana cantilena simile ai sussurri della corruzione.\nLa preghiera cessa, e mentre stai per andartene, un fantasma bianco appare alle tue spalle.\n\"Coloro che trasgrediscono il fato e la preghiera, tanto le benedizioni quanto la punizione giungeranno come promesso.\""
  },
  Event_6933_Name = {
    Text = "Frammento di Luna d'Argento"
  },
  Event_6934_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6934_Desc = {
    Text = "Un nitido suono di frantumi giunge da dietro. Ti fermi un istante, perso nei pensieri, poi ti volti dall'altra parte."
  },
  Event_6934_Name = {
    Text = "Frammento di Luna d'Argento"
  },
  Event_6935_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6935_Desc = {
    Text = "Un pugno di luce lunare, raccolto nel palmo, fu cosparso sulla Tavoletta di pietra.\nQualcuno fu sepolto sotto uno spesso strato di fango, e gli astanti dichiararono che si trattava di una morte naturale, asserendo che avrebbe riposato in pace sottoterra.\nTuttavia, il fango che ricopriva il sepolto prese a ribollire, e tra le urla, una luna floscia ne strisciò fuori."
  },
  Event_6935_Name = {
    Text = "Frammento di Luna d'Argento"
  },
  Event_6936_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6936_Desc = {
    Text = [[
Nient'altro che un essere vivente che lotta per sopravvivere, in cerca di un pezzo di legno alla deriva su cui riposare...
Sospiri, lasciando che la melma nera fluisca dalla coda della Farfalla.]]
  },
  Event_6936_Name = {
    Text = "Ciò che Non Dovrebbe Esistere"
  },
  Event_6937_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6937_Desc = {
    Text = "Questa è una trappola premeditata, e sei ben consapevole del suo pericolo.\nRispetto ai gioielli, tu stessa— sei chiaramente la gemma più preziosa."
  },
  Event_6937_Name = {
    Text = "Artigli Rovescianti"
  },
  Event_6938_ChoiceDesc1 = {
    Text = "[Insert your Silver Key]"
  },
  Event_6938_Desc = {
    Text = "Sembra esserci qualcosa all'interno della D-melma sovrasatura... Usa la Chiave d'argento per convertirla nel tuo stesso Potere."
  },
  Event_6938_Name = {
    Text = "Punto di Estrazione"
  },
  Event_6939_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6939_Desc = {
    Text = "Hai accettato l'incarico, ma ti sei imbattuto in un piccolo problema.\n\"Che aspetto ha quella Scultura di Cera?\"\n\"È un busto di me, ovviamente mi somiglia in tutto e per tutto.\"\n\"Ma...\"\n\"Il tuo volto è ormai completamente marcito da tempo. Non lo sapevi?\""
  },
  Event_6939_Name = {
    Text = "La Mia Metà"
  },
  Event_6940_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6940_Desc = {
    Text = "Stringi forte la mano del tuo compagno. Ramona ti lancia uno sguardo perplesso, ma alla fine accetta la tua scortesia."
  },
  Event_6940_Name = {
    Text = "Preghiera Onirica"
  },
  Event_6941_ChoiceDesc1 = {
    Text = "[Ask Who It Is] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando, ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_6941_ChoiceDesc2 = {
    Text = "[Stare Back] Risveglia un Risvegliato, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_6941_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_6941_Desc = {
    Text = "Una forte sensazione di essere osservato ti blocca sul posto.\n\"Chi è?\" ti guardi intorno nella nebbia fitta, \"Jenkin, sei tu?\"\nLa foschia è densa, e dal profondo del cortile giungono flebili urla dei Dissolti. Non trovi nulla, e quando ti volti, per poco non urti un occhio sospeso a mezz'aria."
  },
  Event_6941_Name = {
    Text = "Sguardo Cieco"
  },
  Event_6942_ChoiceDesc1 = {
    Text = "[Avoid Coin] Incidi l'Orazione [(EnchantConfig.Arg1)] su una Carta di comando casuale."
  },
  Event_6942_ChoiceDesc2 = {
    Text = "[Touch the Coin] Aumenta gli HP massimi di Arg1, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_6942_Desc = {
    Text = "Avete trovato un'antica moneta incastonata nel fango nero.\nUn lato presenta intricati intagli di venature blu e rosse, mentre l'altro reca un rilievo finemente dettagliato di un ritratto bianco puro — una duchessa immacolata sorride lievemente, il suo sguardo incontra i vostri occhi pallidi per un breve istante, prima che questi comincino a guizzare inquieti tutt'intorno."
  },
  Event_6942_Name = {
    Text = "Reliquia Bifronte"
  },
  Event_6943_ChoiceDesc1 = {
    Text = "[Turn Around] Ricevi 25 Sigilli Neri"
  },
  Event_6943_ChoiceDesc2 = {
    Text = "[Keep Going] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_6943_Desc = {
    Text = "Eccolo di nuovo, quello strano passo.\nTi segue dallo studio alla stanza del curatore, poi dalla stanza del curatore al seminterrato.\nSai che è un essere cauto.\nMantiene scrupolosamente la distanza tra voi—né troppo lontano, né abbastanza vicino da risultare invadente.\nEppure, non riesci a scrollarti di dosso questa profonda sensazione di inquietudine."
  },
  Event_6943_Name = {Text = "Passi"},
  Event_6944_ChoiceDesc1 = {
    Text = "[Observe It] 100% di probabilità di ottenere 25 Sigilli Neri"
  },
  Event_6944_ChoiceDesc2 = {
    Text = "[Pet It] 50% di probabilità di ottenere 50 Sigilli Neri, 50% di probabilità di non ottenere nulla."
  },
  Event_6944_Desc = {
    Text = "Un gatto nero balzò fuori all'improvviso da un vicolo laterale, avvolgendosi affettuosamente attorno ai tuoi piedi. Le sue inquietanti pupille verticali verdi brillarono di una luce agghiacciante, come a dire: \"Non inseguirmi, vieni a giocare un po' con me.\"\n\"Lo hai già visto. È proprio accanto a te — coloro che sono contaminati dalla follia, le ombre frenetiche... Non fissare direttamente il Suo contorno.\""
  },
  Event_6944_Name = {
    Text = "Spiritello notturno"
  },
  Event_6945_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6945_Desc = {
    Text = "I Risvegliati attendono il tuo comando; non hai tempo per nient'altro."
  },
  Event_6945_Name = {
    Text = "Dalla Prospettiva"
  },
  Event_6946_ChoiceDesc1 = {
    Text = "[Check the Film] Ottieni la Reliquia d'Oro \"(RelicConfig.Arg2)\", ma sviluppi \"(Skill.Arg1)\"."
  },
  Event_6946_ChoiceDesc2 = {
    Text = "[Check Camera] Ricevi 50 Sigilli Neri"
  },
  Event_6946_Desc = {
    Text = "Come estrarre un pezzo di viscere, la pellicola all'interno della fotocamera fu ridotta a brandelli, scartata, sventrata e ignorata.\nUn lampo bianco accecante, la fotocamera abbandonata all'angolo della strada si inclinò, il suo otturatore scattò per mano di una forza invisibile.\n\"Click—\"\nLa tua espressione scioccata e attonita fu fedelmente catturata sulla pellicola"
  },
  Event_6946_Name = {
    Text = "Innocenza Registrata"
  },
  Event_6947_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6947_Desc = {
    Text = "È solo il suono del vento che scuote le Serrature di ferro, nulla di cui preoccuparsi. Ignoralo."
  },
  Event_6947_Name = {
    Text = "Dietro i Cancelli di Ferro"
  },
  Event_6948_ChoiceDesc1 = {
    Text = "[Choose] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_6948_ChoiceDesc2 = {
    Text = "[Choose] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_6948_ChoiceDesc3 = {
    Text = "[Choose] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_6948_Desc = {
    Text = "\"Io\" sono unico nel mio genere, insostituibile in milioni di universi."
  },
  Event_6948_Name = {
    Text = "Risonanza dell'Anima"
  },
  Event_6949_ChoiceDesc1 = {
    Text = "[Claim] Scegli una Reliquia d'argento"
  },
  Event_6949_Desc = {
    Text = [[

Quello potrebbe essere "me".
Attraverso le ombre del tempo, oltre le Barriere Dimensionali, attraverso una crepa fessurata, mi sono trovato faccia a faccia con "me stesso".]]
  },
  Event_6949_Name = {
    Text = "Risonanza dell'Anima"
  },
  Event_6950_ChoiceDesc1 = {
    Text = "[Point Out the Issue] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_6950_ChoiceDesc2 = {
    Text = "[Swallow Doubt] Sviluppa il Sintomo [(Skill.Arg1)] e cambia l'Orazione da incidere.(Utilizzi: 1/2)"
  },
  Event_6950_Desc = {
    Text = [[
Anche per la ragazza, era un dolore indicibile.
Inghiotti le tue domande mentre lei si porta la mano al cuore e inizia a raccontare un sogno lungo venticinque anni, e il senso di isolamento provato dopo il risveglio.]]
  },
  Event_6950_Name = {
    Text = "Vita Imprigionata"
  },
  Event_6951_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6951_Desc = {
    Text = "Getti la carta e i trucioli di legno tra le fiamme. Il fuoco li divora avidamente e lascia sfuggire un rutto soddisfatto. È pronto per la Distruzione, ma non prima di concederti una Benedizione."
  },
  Event_6951_Name = {
    Text = "Fuoco Pallido"
  },
  Event_6952_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6952_Desc = {
    Text = "Avete spento senza pietà l'ultima brace dell'odio, e il Risentimento e la riluttanza che aleggiavano intorno sembrarono placarsi."
  },
  Event_6952_Name = {
    Text = "Fuoco Pallido"
  },
  Event_6953_ChoiceDesc1 = {
    Text = "[Chase the Crows] Ricevi Arg1 Sigilli Neri, ma sviluppa [(Skill.Arg2)]"
  },
  Event_6953_ChoiceDesc2 = {
    Text = "[Ignore] Lascia"
  },
  Event_6953_Desc = {
    Text = "Cerchi di catturare il corvo, ma quello si limita a volare da un capo all'altro della camera da letto, continuando il suo sinistro gracchiare. Dove si posa, cola una melma nera, formando segni scuri."
  },
  Event_6953_Name = {
    Text = "Corvo della Lanterna"
  },
  Event_6954_ChoiceDesc1 = {
    Text = "[Leave] Ottieni la Reliquia \"(RelicConfig.Arg1)\", ma sviluppi il Sintomo \"(Skill.Arg2)\"."
  },
  Event_6954_Desc = {
    Text = "\n\"Avete un talento nel cogliere l'essenza,\" dice l'uomo con un sorriso radioso. \"Quello è il cibo più delizioso al mondo, degno di essere preparato con cura meticolosa e apprezzato da ogni ghiottone.\"\n\"È un peccato, ma questa volta non posso farvelo assaggiare. Come compenso, ho con me altre prelibatezze, che vi donerò.\"\nDetto ciò, l'uomo lancia un pezzo di carne rossa e tenera. La molle polpa atterra sul ponte, le sue appendici vischiose si contorcono in modo grottesco. Quando alzate di nuovo lo sguardo, la figura dell'uomo è svanita dietro le intricate strutture d'acciaio, senza lasciare traccia."
  },
  Event_6954_Name = {
    Text = "Compagno di viaggio insolito VI"
  },
  Event_6955_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6955_Desc = {
    Text = "Dipanare gli accumuli, Passo dopo Passo, è il tuo forte.\nUn lampo di Ispirazione ti schiarisce la mente, permettendoti di vedere la realtà davanti a te—\nNon importa chi tiri i fili, fuggi e sopravvivi."
  },
  Event_6955_Name = {
    Text = "Impeto d'Ispirazione"
  },
  Event_6956_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6956_Desc = {
    Text = "Una farfalla si frantuma nel tuo palmo, come un soffitto di vetro che improvvisamente va in pezzi, frammenti che cadono, cadono, cadono a terra—"
  },
  Event_6956_Name = {
    Text = "Miraggio della Ferrovia"
  },
  Event_6957_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6957_Desc = {
    Text = "Vedendo Ramona riluttante ad avvicinarsi, il gatto scosse la testa e si dissolse in un'Ombra."
  },
  Event_6957_Name = {
    Text = "Abitante Errante"
  },
  Event_6958_ChoiceDesc1 = {
    Text = "[Make a promise] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_6958_ChoiceDesc2 = {
    Text = "[Refuse] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_6958_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_6958_Desc = {
    Text = "\"Fu davvero una memoria indimenticabile.\nLa mia testa e i miei arti furono premuti con forza nel gesso.\nSoffocamento e fantasmi di quasi-morte mi avvolsero profondamente, poi mi sollevarono e mi gettarono su una riva oscura.\nLa guardai, sentendo che anche una parte di me era stata portata via.\nQuella metà perduta della mia Anima da allora risiede in quella piccola, prima Scultura di Cera.\nQuindi... puoi aiutarmi a trovare la mia metà?\""
  },
  Event_6958_Name = {
    Text = "La Mia Metà"
  },
  Event_6959_ChoiceDesc1 = {
    Text = "[Leave] Incidi 1 Orazione Av. su 3"
  },
  Event_6959_Desc = {
    Text = [[
Sei uno spettatore di memorie, costretto a guardare impotente la ragazza sprofondare nel Mare oscuro.
La corrente le solleva la gonna verso l'alto, ma lei affonda, come un fiore mai sbocciato.]]
  },
  Event_6959_Name = {
    Text = "Mare Sommerso"
  },
  Event_6960_ChoiceDesc1 = {
    Text = "[Insert your Silver Key]"
  },
  Event_6960_Desc = {
    Text = "Sembra esserci qualcosa all'interno della D-melma sovrasatura... Usa la Chiave d'argento per convertirla nel tuo stesso Potere."
  },
  Event_6960_Name = {
    Text = "Punto di Estrazione"
  },
  Event_6961_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6961_Desc = {
    Text = "Non cedere alla tentazione del nemico; potrebbe essere una trappola."
  },
  Event_6961_Name = {
    Text = "Corvo Maledetto"
  },
  Event_6962_ChoiceDesc1 = {Text = "[Help Him]"},
  Event_6962_ChoiceDesc2 = {
    Text = "[Observe Coldly]"
  },
  Event_6962_Desc = {
    Text = "Il ragazzo stava sul palco, una luce pallida a illuminargli il volto.\n\"De-dedicato a...\"\nIl volto del ragazzo si fece rosso. Aprì la bocca ma non riuscì a emettere alcun suono.\nLa sua bocca spalancata si allargava sempre di più..."
  },
  Event_6962_Name = {
    Text = "Fine Ultima III"
  },
  Event_6963_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6963_Desc = {
    Text = "\"Maledizione, maledizione!\" Come se avessi premuto un interruttore, il gatto nero diventa improvvisamente feroce, mordendo il tuo braccio. Per fortuna schivi appena in tempo, perdendo solo un pezzo della manica. Il gatto nero schizza verso l'angolo della strada e scompare nella fogna."
  },
  Event_6963_Name = {
    Text = "Spiritello notturno"
  },
  Event_6964_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6964_Desc = {
    Text = "Avvolto dai pensieri tumultuosi nella tua mente, spingi la porta e ti incammini su un sentiero senza ritorno.\nLa luce bianca ardente oltre la soglia è salvezza o distruzione?"
  },
  Event_6964_Name = {
    Text = "Oltre il portale"
  },
  Event_6965_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6965_Desc = {
    Text = "Avanzi con cautela per ispezionare, e la melma che ricopre il tavolo si spacca improvvisamente, rivelando ciò che si cela sotto."
  },
  Event_6965_Name = {
    Text = "Oltre il portale"
  },
  Event_6966_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6966_Desc = {
    Text = [[
Inghiotti i tuoi dubbi, concentrati sul nemico.
Lascia che le farfalle indugiino dentro il tuo corpo, anche se le loro ali ti lacerano gli organi.]]
  },
  Event_6966_Name = {
    Text = "L'Effetto Farfalla"
  },
  Event_6967_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_6967_Desc = {
    Text = "Il gatto annuì soddisfatto, poi svanì in un'ombra, lasciando dietro di sé diversi oggetti circolari neri."
  },
  Event_6967_Name = {
    Text = "Abitante Errante"
  },
  Event_6968_ChoiceDesc1 = {
    Text = "[Insert your Silver Key]"
  },
  Event_6968_Desc = {
    Text = "Sembra esserci qualcosa all'interno della D-melma sovrasatura... Usa la Chiave d'argento per convertirla nel tuo stesso Potere."
  },
  Event_6968_Name = {
    Text = "Punto di Estrazione"
  },
  Event_6969_ChoiceDesc1 = {
    Text = "[Leave] Ottieni una Reliquia dorata casuale, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_6969_Desc = {
    Text = "Vedendoti ancora esitare, Koum si avventò sul cumulo di terra, scavando rapidamente con le zampe anteriori, e spinse qualcosa davanti a te."
  },
  Event_6969_Name = {
    Text = "Sepolto nel Profondo"
  },
  Event_6970_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6970_Desc = {
    Text = "In cima al foglio è stampato con cura \"Mérimée\", non c'è mai stato alcun Mason.\nL'eccessiva Diffidenza non è un buon segno, Custode."
  },
  Event_6970_Name = {
    Text = "Macchina da scrivere"
  },
  Event_6971_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 1 di 3 Reliquie dorate, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_6971_Desc = {
    Text = "Sepolti nel tumulo giacciono gli innumerevoli crimini efferati dell'Associazione degli Scultori."
  },
  Event_6971_Name = {
    Text = "Sepolto nel Profondo"
  },
  Event_6972_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6972_Desc = {
    Text = "Gli uccelli seguono le proprie regole. Non agiscono secondo la tua volontà, né hai il diritto di interferire con le leggi della natura."
  },
  Event_6972_Name = {
    Text = "Corvo Solitario"
  },
  Event_6973_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 1 di 3 Reliquie dorate, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_6973_Desc = {
    Text = "Perché? Perché è affondato?\nQuel giorno non c'erano tuoni, né tempeste. Il cielo notturno era limpido, non una sola stella in vista, con una luna piena sospesa bassa sull'orizzonte, simile a un sole gelido."
  },
  Event_6973_Name = {
    Text = "Mare Sommerso"
  },
  Event_6974_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6974_Desc = {
    Text = "\"Conducente! Siamo sotto attacco!...Bzzz...\"\nSembra essere una chiamata dal conducente. Stavi per riagganciare.\n\"Ripeto, qui Squadra Operativa 4 di Mythag. Stavamo scortando ostaggi liberati sull'espresso notturno verso nord quando siamo stati... Ah!\"\nLa voce al telefono si trasforma in un sussurro rauco, mescolato a urla sinistre.\n\"Il rito è completo. Agnello smarrito, possa questo sacro bagno purificare la tua anima...\""
  },
  Event_6974_Name = {
    Text = "Chiamata dal Treno"
  },
  Event_6975_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6975_Desc = {
    Text = "Raccogliere Argenti è anch'esso uno dei compiti dei Custodi.\nLe anime che vagano nei cristalli bianco puro, in futuro, torneranno al mondo con un aspetto del tutto nuovo."
  },
  Event_6975_Name = {
    Text = "Anima Incatenata"
  },
  Event_6976_ChoiceDesc1 = {
    Text = "[Descend Further] Incidi l'Orazione [(EnchantConfig.Arg1)] su una Carta di comando casuale."
  },
  Event_6976_ChoiceDesc2 = {
    Text = "[Pull Away] Ricevi 25 Sigilli Neri"
  },
  Event_6976_Desc = {
    Text = "\"Tu\" ti invita ad andare più a fondo.\nNelle profondità della spirale, il \"tu\" del passato e del futuro ti inviano \"doni\" da dimensioni diverse."
  },
  Event_6976_Name = {Text = "Abisso"},
  Event_6977_ChoiceDesc1 = {
    Text = "[Lean Out] Ottieni la Reliquia d'Oro \"(RelicConfig.Arg2)\", ma sviluppi \"(Skill.Arg1)\"."
  },
  Event_6977_ChoiceDesc2 = {
    Text = "[Give Up Checking] Ricevi 50 Sigilli Neri"
  },
  Event_6977_Desc = {
    Text = "Sembra esserci un rotolo di pellicola incastrato sotto il tavolo operatorio."
  },
  Event_6977_Name = {
    Text = "Fantasmi Mnemonici"
  },
  Event_6978_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6978_Desc = {
    Text = "Ignora le distrazioni e concentrati sul presente.\nHai cose più importanti da fare."
  },
  Event_6978_Name = {
    Text = "La Mia Metà"
  },
  Event_6979_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6979_Desc = {
    Text = "Una reliquia perduta, un cimelio inestimabile, un dispositivo che esaudisce desideri...\nForse solo i tesori segreti possono essere così seducenti."
  },
  Event_6979_Name = {
    Text = "Input Enigmatico"
  },
  Event_6980_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6980_Desc = {
    Text = "『Sei la 'madre' di Lily, eppure la usi solo come strumento per la ricerca e la battaglia, 』 rispondi. 『Una figlia può obbedire alla madre, ma tu non dovresti essere la 'madre' di Lily.』"
  },
  Event_6980_Name = {
    Text = "La Sua Scelta"
  },
  Event_69813_ChoiceDesc1 = {Text = "[Leave]"},
  Event_69813_Desc = {
    Text = "La Chiave d'argento emette un Bagliore; le braccia sembrano intimidite da una qualche forza, ritirandosi nella pozza per poi scomparire."
  },
  Event_69813_Name = {
    Text = "Pozza di Sangue Corrotto"
  },
  Event_69814_ChoiceDesc1 = {Text = "[Leave]"},
  Event_69814_Desc = {
    Text = "Più sprofondi, più odi i sussurri caotici della Volontà suprema nella tua mente. Chiudi gli occhi, invocando l'Autorità dentro di te.\nAll'improvviso, tutti i suoni e le sensazioni estranee svaniscono. Ti trovi dietro la Porta, i Tentacoli rosso sangue accanto a te sono scomparsi senza lasciare traccia, come se non fossero mai esistiti.\nTi senti rinvigorito. Comprendi il prezzo che hai pagato, ma è insignificante— affronterai quell'esistenza suprema in una forma più Forte."
  },
  Event_69814_Name = {
    Text = "Pozza di Sangue Corrotto"
  },
  Event_69815_ChoiceDesc1 = {Text = "[Leave]"},
  Event_69815_Desc = {
    Text = "Il Risvegliatore plasmato dai tuoi ricordi ha agito senza un attimo di esitazione, trascinandoti fuori dalla pozza intrisa di sangue. Il tuo braccio lacerato è stato riconnesso mentre l'acqua fangosa schizzava, innumerevoli creature indistinguibili che si contorcevano nell'acqua. La Reliquia e il Distruttore originali bramavano disperatamente di divorare."
  },
  Event_69815_Name = {
    Text = "Pozza di Sangue Corrotto"
  },
  Event_69816_ChoiceDesc1 = {
    Text = "[Summon Awakeners] Tutti i Risvegli perdono 100 Aliemus. Distruggi una Carta sintomo."
  },
  Event_69816_ChoiceDesc2 = {
    Text = "[Drink the Blood] Aumenta gli HP massimi di Arg1, ma sviluppa [(Skill.Arg2)] due volte."
  },
  Event_69816_ChoiceDesc3 = {
    Text = "[Harness Silver Key] Perdi tutti i Keyflare."
  },
  Event_69816_Desc = {
    Text = "L'Autorità della vita si manifesta in forma di morte agli occhi del primordiale. Non appena metti piede su questo Dominio d'Ombra, la fetida pozza di sangue rivela istantaneamente la sua vera forma.\nIl sangue nero Cremisi protende innumerevoli braccia, aggrappandosi alle tue caviglie e tirando incessantemente verso l'alto, con l'intento di trascinarti nell'insondabile Abisso."
  },
  Event_69816_Name = {
    Text = "Pozza di Sangue Corrotto"
  },
  Event_6981_ChoiceDesc1 = {
    Text = "[Pick Up Key]"
  },
  Event_6981_Desc = {
    Text = "Un mazzo di chiavi arrugginite. Può essere usato per aprire le porte."
  },
  Event_6981_Name = {
    Text = "Chiave arrugginita"
  },
  Event_6982_ChoiceDesc1 = {
    Text = "[Leave] Duplica una Carta di comando, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_6982_Desc = {
    Text = "Guidato dallo shanty e da Celeste, scruti le profondità buie come la pece della cabina—la tua possibilità di sopravvivenza potrebbe celarsi in quell'Oscurità sconfinata?"
  },
  Event_6982_Name = {Text = "Shanty"},
  Event_6983_ChoiceDesc1 = {
    Text = "[Leave Together] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_6983_ChoiceDesc2 = {
    Text = "[Refuse to Leave] Ricevi 75 Sigilli Neri, ma sviluppa il Sintomo [(Skill.Arg2)]"
  },
  Event_6983_Desc = {
    Text = "È un Fantasma? Vedi corvi volteggiare in alto, canticchiando una melodia familiare:\n\"Allora partiamo insieme, tu ed io,\nQuando cala la notte,\nCome un ubriaco morente che crolla in strada.\""
  },
  Event_6983_Name = {
    Text = "Coro dei Corvi"
  },
  Event_6984_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6984_Desc = {
    Text = "Il potere della retrospezione non riesce a trovare un'altra Giunzione per te nel breve termine, ma almeno provi un Sollievo temporaneo."
  },
  Event_6984_Name = {
    Text = "Contatto Anomalo"
  },
  Event_6985_ChoiceDesc1 = {
    Text = "[Gaze into the Abyss]"
  },
  Event_6985_ChoiceDesc2 = {
    Text = "[Pull Away] Ricevi 25 Sigilli Neri"
  },
  Event_6985_Desc = {
    Text = "La superficie del mare è scomparsa dall'oblò.\nIl vetro riflette il tuo volto pallido, mentre nella tua pupilla, \"tu\" fissi l'oblò.\nRealtà e Dominio si sovrappongono e si intrecciano, distorcendosi infine in un'intricata spirale."
  },
  Event_6985_Name = {Text = "Abisso"},
  Event_6986_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6986_Desc = {
    Text = "Hai accettato una richiesta di contatto dalla scuola. La voce familiare calma la tua mente. Raccogli le forze e prosegui."
  },
  Event_6986_Name = {Text = "Crocevia"},
  Event_6987_ChoiceDesc1 = {Text = "[Agree]"},
  Event_6987_ChoiceDesc2 = {Text = "[Disagree]"},
  Event_6987_ChoiceDesc3 = {
    Text = "[No Comment]"
  },
  Event_6987_Desc = {
    Text = "\"Quanto tempo, amici.\" Dopo essere sfuggiti alla battaglia con i Devoti del Portatore di Luce e aver ripreso fiato, notate improvvisamente l'uomo dai capelli lunghi riapparire lungo la strada, sorridente come se il combattimento non fosse mai avvenuto.\n\"Rispetto all'ultima volta, l'odore di Cerbero su di voi è molto più forte. Dovete aver viaggiato a lungo in questo periodo, vero?\"\n"
  },
  Event_6987_Name = {
    Text = "Compagno di viaggio insolito V"
  },
  Event_6988_ChoiceDesc1 = {
    Text = "[Chiedergli il Sentiero] Scegli 1 tra 3 Carte di comando e ottieni Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_6988_ChoiceDesc2 = {
    Text = "[Allontanarsi] Scegli 1 tra 3 Carte di comando e ottieni Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_6988_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_6988_Desc = {
    Text = "L'ombra è ferma sotto l'alto lampione.\n\"Posso chiederle un po' di fuoco, signore?\"\nNon hai l'abitudine di @2, ma non ti dispiace usare un pizzico di \"magia\".\nCon il tuo aiuto, l'ombra accenderà @2 e lo immergerà in profondità in quel vortice nero insondabile.\nIn un attimo, vedi fumo bianco levarsi a volute.\n\"Ah—\"\nL'ombra emette un sospiro compiaciuto."
  },
  Event_6988_Name = {
    Text = "Silhouette sotto il Lampione"
  },
  Event_6989_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_6989_Desc = {
    Text = "Sulla scacchiera, ciò che vedi non è reale.\n\nCiò che blocca il tuo cammino potrebbe non essere un muro, ma la tua curiosità che si affievolisce."
  },
  Event_6989_Name = {
    Text = "Spazio Fantasma"
  },
  Event_6990_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6990_Desc = {
    Text = "\"Ho così tanto dolore... Sorella Sasha...\"\nLanci un'occhiata a Sarah. Lei sta — nervosamente — facendo scudo a due dei fanciulli, fingendo di non sentire nulla.\nLa voce svanisce gradualmente."
  },
  Event_6990_Name = {
    Text = "\"Sorella Sasha\""
  },
  Event_6991_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_6991_Desc = {
    Text = "Ti alzi in piedi e applaudi il ragazzo.\nPercependo il tuo incoraggiamento, il ragazzo gonfia il piccolo petto.\nSangue nero continua a sgorgare dalla sua bocca, eppure nulla può più fermare il suo canto."
  },
  Event_6991_Name = {
    Text = "Fine Ultima IV"
  },
  Event_6992_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6992_Desc = {
    Text = "Una parte del dolore sta evaporando, eppure le lacrime continuano a scorrere senza fine verso il passato mistico."
  },
  Event_6992_Name = {
    Text = "Lamento dello Stige"
  },
  Event_6993_ChoiceDesc1 = {
    Text = "[Choke the Singer] Ottieni la Reliquia maledetta \"(RelicConfig.Arg2)\", ma sviluppa \"(Skill.Arg1)\"."
  },
  Event_6993_ChoiceDesc2 = {
    Text = "[Stumbling Dancer's Steps] Ottieni le Reliquie d'argento \"(RelicConfig.Arg2)\" e \"(RelicConfig.Arg3)\", ma sviluppa \"(Skill.Arg1)\" due volte."
  },
  Event_6993_ChoiceDesc3 = {
    Text = "[Take a Detour] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_6993_Desc = {
    Text = "Tre figure viscose ti sbarrano il cammino.\nUna figura canta con voce roca e testi sinistri. Ti copri le orecchie e la oltrepassi.\nUn'altra figura danza rigidamente con passi esitanti. Chiudi gli occhi e la schivi.\nL'ultima figura recita poesie frammentate con frasi sconnesse. Incapace di sopportare oltre, tu—"
  },
  Event_6993_Name = {
    Text = "Bruto del Sentiero Stretto"
  },
  Event_6994_ChoiceDesc1 = {Text = "[Leave]"},
  Event_6994_Desc = {
    Text = "Una parte della rabbia ribolle, ma le lacrime continuano a scorrere verso un passato ignoto."
  },
  Event_6994_Name = {
    Text = "Lamento dello Stige"
  },
  Event_6995_ChoiceDesc1 = {
    Text = "[Ignore It] Ottieni una Reliquia, ma sviluppi il Sintomo [(Skill.Arg1)]"
  },
  Event_6995_ChoiceDesc2 = {
    Text = "[Turn Away] Risveglia un Risvegliatore casuale"
  },
  Event_6995_Desc = {
    Text = "Un destino crudele striscia sotto i piedi del viaggiatore. Il sentiero è limpido come uno specchio, con un debole suono di crepe alle spalle.\nChi ha calpestato il destino? È un'illusione, una trappola, o semplici deliri, inganni...\nDavanti ai vostri occhi appare una crepa che avanza lentamente.\n<Italic:Come se stesse per sprofondare per la Gnosi che si risveglia.>"
  },
  Event_6995_Name = {
    Text = "Fessura Strisciante"
  },
  Event_6996_ChoiceDesc1 = {
    Text = "[Initiate Trial] Sviluppa [(Skill.Arg1)] ; ottieni una Reliquia d'oro in caso di vittoria, o 50 Sigilli Neri in caso di sconfitta."
  },
  Event_6996_ChoiceDesc2 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_6996_Desc = {
    Text = "Hai intravisto alcuni segreti dalla melma nera simile a uno specchio sotto i tuoi piedi.\nIl suo riflesso è nebuloso, avvolto in una foschia scura e impenetrabile. Sembra stranamente familiare, eppure non riesci a distinguere cosa sia."
  },
  Event_6996_Name = {
    Text = "Sotto lo Specchio"
  },
  Event_6997_ChoiceDesc1 = {
    Text = "[Imitate Cat's Call] 50% di probabilità di ricevere 125 Sigilli Neri, 50% di probabilità di sviluppare [(Skill.Arg2)]"
  },
  Event_6997_ChoiceDesc2 = {
    Text = "[Feed] 75% di probabilità di ricevere 100 Sigilli Neri, 25% di probabilità di sviluppare [(Skill.Arg2)]"
  },
  Event_6997_ChoiceDesc3 = {
    Text = "[Run Away] Ricevi 50 Sigilli Neri"
  },
  Event_6997_Desc = {
    Text = "Sei entrato accidentalmente nel territorio del gatto nero.\nInnumerevoli occhi si sono aperti nell'Oscurità, colmi di curiosità, diffidenza e Allerta... ma privi di benevolenza.\nVerde smeraldo, giallo ambra, blu pavone...\nTi sei sentito come immerso in un mare di gemme scintillanti.\nPer fuggire, tu—"
  },
  Event_6997_Name = {
    Text = "Città dei Gatti"
  },
  Event_6998_ChoiceDesc1 = {
    Text = "[About Daffodil] Incidi le Orazioni \"(EnchantConfig.Arg1)\" e \"(EnchantConfig.Arg2)\" su 2 Carte di comando casuali."
  },
  Event_6998_ChoiceDesc2 = {
    Text = "[About Hellhound] Ottieni la Reliquia maledetta [(RelicConfig.Arg1)]"
  },
  Event_6998_ChoiceDesc3 = {
    Text = "[About Lily] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_6998_Desc = {
    Text = "\"È il tempo suggerimento di Daffodil.\""
  },
  Event_6998_Name = {
    Text = "Tempo suggerimento"
  },
  Event_6999_ChoiceDesc1 = {
    Text = "[Let Pointer] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_6999_ChoiceDesc2 = {
    Text = "[Hold Pointer] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_6999_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_6999_Desc = {
    Text = "Crac, scroc, crac—\nLe lancette del destino avanzano pollice dopo pollice, il freddo scattare degli ingranaggi che si muove inesorabilmente verso la direzione che temete."
  },
  Event_6999_Name = {
    Text = "Oltre la cruna"
  },
  Event_7000_ChoiceDesc1 = {
    Text = "[Turn a Deaf Ear] Distruggi 1 di 3 Carte di comando e ricevi 75 Sigilli Neri."
  },
  Event_7000_ChoiceDesc2 = {
    Text = "[Carefully Inspect] Duplica 1 di 3 Carte di comando e ricevi 25 Sigilli Neri."
  },
  Event_7000_ChoiceDesc3 = {
    Text = "[Turn and Leave] Ricevi 50 Sigilli Neri"
  },
  Event_7000_Desc = {
    Text = "Un destino crudele striscia sotto i piedi del viaggiatore, Il Sentiero riluce come uno specchio, con deboli suoni di crepe alle spalle.\nChi ha infranto il destino sotto i piedi? È Delirio, una trappola, o soltanto Deliri e inganni...\nDavanti ai tuoi occhi, appare una crepa che avanza lentamente."
  },
  Event_7000_Name = {
    Text = "Fessura Strisciante"
  },
  Event_7001_ChoiceDesc1 = {
    Text = "[Call the Crow] Ricevi 25 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_7001_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_7001_Desc = {
    Text = "L'Artiglio squarcia il mantello, affondando in profondità nella spalla."
  },
  Event_7001_Name = {
    Text = "Corvo Solitario"
  },
  Event_7002_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7002_Desc = {
    Text = "La paura talvolta non nasce da qualcosa di tangibile.\nIl \"Segugio infernale\" lascia dietro di sé gocce rosse ovunque passi, riflettendo la tua sagoma."
  },
  Event_7002_Name = {
    Text = "Riflesso Informe"
  },
  Event_7003_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7003_Desc = {
    Text = "Con un debole ronzio, odi il sussurro della donna.\nTra le lacrime, racconta incessantemente la sua storia.\nPassa un'ora, poi un giorno... finché hai da tempo dimenticato perché fosse triste.\nInfine, riattacca allegramente e promette di inviarti un regalo.\nLo accetti. Dopotutto, i regali fanno sempre piacere."
  },
  Event_7003_Name = {
    Text = "Rispondi alla Chiamata"
  },
  Event_7004_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7004_Desc = {
    Text = "Sotto gli sguardi perplessi dei tuoi compagni, abbassi il capo, pieghi un ginocchio a terra e posi il pugno destro sulla fronte.\nPerfetto, questo coprirà completamente il tuo volto."
  },
  Event_7004_Name = {
    Text = "Travestimento perfetto"
  },
  Event_7005_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7005_Desc = {
    Text = "\n\"Mi hai drappeggiato il velo addosso.\"\nLa Scultura di Cera ti sorride serenamente.\n\"Ti offro La Verità come ricompensa per il tuo duro lavoro.\"\nDal suo ventre cola incessantemente un liquido nero, che ti avvolge strettamente.\nIl mondo è nero pece, eppure immensamente caldo.\nTi rannicchi e sbadigli, entrando nel mondo dei sogni per la @1ª volta..."
  },
  Event_7005_Name = {
    Text = "Scultura di Cera Incompiuta"
  },
  Event_7006_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7006_Desc = {
    Text = "Non trovi nulla nella Nebbia."
  },
  Event_7006_Name = {
    Text = "Nebbia del Caos"
  },
  Event_7007_ChoiceDesc1 = {
    Text = "[Answer the Phone] Incidi 1 di 3 Orazioni Av."
  },
  Event_7007_ChoiceDesc2 = {
    Text = "[Ignore Bell] Ottieni la Reliquia d'Oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7007_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_7007_Desc = {
    Text = "\"Drin drin drin...\"\nUno squillo di telefono penetrante proveniva dall'angolo, urgente e assordante, ogni squillo più forte del precedente, quasi dandoti l'Illusione che, se non avessi risposto, sarebbe impazzito all'istante ed esploso, Distruggendo così il mondo."
  },
  Event_7007_Name = {
    Text = "Rispondi alla Chiamata"
  },
  Event_7008_ChoiceDesc1 = {
    Text = "[Approach Phantasm] Ottieni 1 di 3 Reliquie d'Argento"
  },
  Event_7008_ChoiceDesc2 = {
    Text = "[Break Phantasm] Ottieni le Reliquie d'Argento \"(RelicConfig.Arg1)\" e \"(RelicConfig.Arg2)\", ma sviluppa \"(Skill.Arg3)\" due volte."
  },
  Event_7008_Desc = {
    Text = "È un Miraggio nel Dominio? O un altro Ricordo da cui non si può sfuggire?\nTi strofini gli occhi. Un Fantasma si avvicina — è il mercato brulicante, il Museo delle Cere perduto nella Dissoluzione, l'asilo del villaggio innevato, o la sfocata Jakutsk?"
  },
  Event_7008_Name = {Text = "Miraggio"},
  Event_7009_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7009_Desc = {
    Text = "Come scottato dall'acqua bollente, istintivamente ti copri le orecchie, bloccando la musica malevola."
  },
  Event_7009_Name = {
    Text = "Tono Proibito"
  },
  Event_7010_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7010_Desc = {
    Text = "Un luminoso accordo maggiore dissipa la tensione e la paura. Sei appassionato, radioso, esuberante. Avanzi a grandi passi, lasciando Ramona molto indietro—\"Custode?! Non camminare così veloce!\""
  },
  Event_7010_Name = {
    Text = "Eco Senza Nome"
  },
  Event_7011_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7011_Desc = {
    Text = "\n\"Fermo lì!!! Persino il mostro in dissoluzione che striscia sul ventre conosce i propri arti meglio di te!\"\nLascia andare il pubblico...\nLo implori nel tuo cuore"
  },
  Event_7011_Name = {
    Text = "Bruto del Sentiero Stretto"
  },
  Event_7012_ChoiceDesc1 = {Text = "[Withdraw]"},
  Event_7012_Desc = {
    Text = "Questo è soltanto un Dominio.\nCiò che desideri proteggere e da cui cerchi di fuggire è una realtà unica."
  },
  Event_7012_Name = {Text = "Abisso"},
  Event_7013_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7013_Desc = {
    Text = "\n\"Tu sei il più detestabile.\"\nStrappi il manoscritto in frammenti, disperdendoli nel vento, frantumandoli in diversi grappoli di petali volanti.\nIl Poeta alza lo sguardo verso i caratteri che turbinano nel vento, un'espressione di ossessione che si increspa agli angoli della bocca.\n\"Bellissimo...\""
  },
  Event_7013_Name = {
    Text = "Bruto del Sentiero Stretto"
  },
  Event_7014_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7014_Desc = {
    Text = "\nHai strappato il manifesto e sul retro hai trovato delle spese frettolosamente annotate relative al museo delle cere.\nChi le aveva scritte non aveva evidentemente né pazienza né talento per l'aritmetica, e quei conti non tornavano in alcun modo.\nLe hai scorte brevemente, e la voce di spesa più consistente sembrava essere \"Manutenzione e Pulizia delle Sculture in Cera\".\nLe spese per il personale erano pietosamente basse, e l'esborso più recente riguardava 12 fruste di crine di cavallo a circa 20 Fang ciascuna.\nC'era anche una spesa particolare— \"Il Loro Cibo\".\nChi sono \"loro\"?"
  },
  Event_7014_Name = {
    Text = "Ilarità nelle Tenebre"
  },
  Event_7015_ChoiceDesc1 = {
    Text = "[Leave] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7015_Desc = {
    Text = [[
"Astuto... e una risposta corretta."
La voce sembrava incuriosita dalla risposta, mentre un oggetto d'Argento emergeva dall'acqua.
"Ricorda, ogni cosa ha un prezzo."]]
  },
  Event_7015_Name = {
    Text = "Voci dall'Oltre"
  },
  Event_7016_ChoiceDesc1 = {
    Text = "[Catch the Second Butterfly] Distruggi una Carta di comando e ricevi Arg1 Sigilli Neri."
  },
  Event_7016_ChoiceDesc2 = {
    Text = "[Linger No Longer]"
  },
  Event_7016_Desc = {
    Text = [[
Sono residenti della Dimensione spirituale? O vita nata dalla Dissoluzione?
Con domande nella mente, ti addentri in una tempesta di farfalle.]]
  },
  Event_7016_Name = {
    Text = "Tempesta di Gnosi"
  },
  Event_7017_ChoiceDesc1 = {
    Text = "[Observe the Third Butterfly] Distruggi una Carta di comando e ricevi Arg1 Sigilli Neri."
  },
  Event_7017_ChoiceDesc2 = {
    Text = "[Linger No Longer]"
  },
  Event_7017_Desc = {
    Text = "Il Pain alle dita diventa insopportabile, e lasci andare in fretta."
  },
  Event_7017_Name = {
    Text = "Tempesta di Gnosi"
  },
  Event_7018_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri, ma sviluppi il Sintomo [(Skill.Arg1)]"
  },
  Event_7018_Desc = {
    Text = "\"Voi umani non avete altre risposte?\"\nIl proprietario della voce emise un ringhio impaziente, scuotendo l'intero spazio.\n\"Avidi e ignoranti... Ecco perché sono stanco di voi.\""
  },
  Event_7018_Name = {
    Text = "Voci dall'Oltre"
  },
  Event_7019_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7019_Desc = {
    Text = "\"Non preoccuparti, ho solo dato un po' di punizione all'ospite avido. Non ci posso fare nulla—non mi piace la birra~\""
  },
  Event_7019_Name = {
    Text = "Frammento di Memoria: Birra"
  },
  Event_7020_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7020_Desc = {
    Text = "\"Smetti di cantare—\"\nAvverti il cantante stonato, rifiutandoti di lasciargli torturare oltre le tue orecchie."
  },
  Event_7020_Name = {
    Text = "Bruto del Sentiero Stretto"
  },
  Event_7021_ChoiceDesc1 = {
    Text = "[Leave] Risveglio di 2 Risvegliatori"
  },
  Event_7021_Desc = {
    Text = "Ti volti, solo per ritrovarti perso nel lungo corridoio.\nIl corridoio senza fine prosciuga completamente la tua pazienza, finché non noti un piccolo palcoscenico logoro.\nSbatti le palpebre, e il palcoscenico svanisce."
  },
  Event_7021_Name = {
    Text = "Fine Ultima II"
  },
  Event_7022_ChoiceDesc1 = {
    Text = "[Raise the Goblet] Ottieni [Idromele al Miele]"
  },
  Event_7022_Desc = {
    Text = "Una coppa di liquido dorato e limpido, scintillante come le onde dorate del grano nel tardo autunno, che emana un aroma dolce, simile al miele. Quali sono i suoi ingredienti? Chi l'ha messa qui? Perché è stata lasciata incustodita?\nPrima che queste domande trovino risposta, un pensiero misterioso si insinua nella tua mente: Devi berla ora, immediatamente.\nIn questo istante, ti trasformi improvvisamente in una falena stregata dalla fiamma, un insetto intrappolato da una Nepenthes, allungando incontrollabilmente la mano verso quella coppa di vino dolce—"
  },
  Event_7022_Name = {
    Text = "Idromele al Miele"
  },
  Event_7023_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7023_Desc = {
    Text = "Hai provato a esaminare questa porta. Quando l'hai toccata, la porta è svanita e hai udito qualcosa aprirsi in lontananza."
  },
  Event_7023_Name = {
    Text = "Porta Strana"
  },
  Event_7024_ChoiceDesc1 = {
    Text = "[No Action]"
  },
  Event_7024_ChoiceDesc2 = {
    Text = "[Wipe Palm Print]"
  },
  Event_7024_Desc = {
    Text = "L'ufficio di Francis è freddo e immacolato, riflesso della sua natura meticolosa.\nIn un angolo, su una scatola, trovi un'impronta nella polvere di circa cinque pollici quadrati.\nL'impronta è peculiare: il contorno della zampa di una bestia con una piccola impronta di mano di bambina incastonata al centro. Sembra che l'impronta della bambina sia stata lasciata per prima, seguita dall'enorme zampa della bestia a coprirla.\nPotresti immaginare una scena tenera, come una bestia addomesticata che posa delicatamente la zampa sulla mano della bambina in un gesto di conforto.\nMa conosci la verità: è il marchio lasciato da un mostro ibrido crudelmente sottoposto a esperimenti."
  },
  Event_7024_Name = {
    Text = "Impronta del Colosso"
  },
  Event_7025_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7025_Desc = {
    Text = "I soggetti del test Psyche Deepdive vi hanno sfinito, e persino un breve istante di tregua sembra pioggia nel deserto."
  },
  Event_7025_Name = {
    Text = "Porta dell'Infinito"
  },
  Event_7026_ChoiceDesc1 = {
    Text = "[Master] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7026_ChoiceDesc2 = {
    Text = "[Portarlo via] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_7026_ChoiceDesc3 = {
    Text = "[Disassemble It] Ricevi 50 Sigilli Neri"
  },
  Event_7026_Desc = {
    Text = "Stai camminando e per caso colpisci qualcosa con il piede.\nÈ una bussola, il vetro frantumato e ricoperto di D-Slime. Girandola con cautela, riesci a intravedere l'emblema dell'Università di Mythag inciso sul retro."
  },
  Event_7026_Name = {
    Text = "La Sua Scelta"
  },
  Event_7027_ChoiceDesc1 = {
    Text = "[Read the Letter] Distruggi una Carta di comando e ricevi Arg1 Sigilli Neri."
  },
  Event_7027_ChoiceDesc2 = {
    Text = "[Close the Box]"
  },
  Event_7027_Desc = {
    Text = "Una lettera, un'altra lettera, e un'altra ancora.\nLa carta è colma del tuo passato e raffigura il tuo futuro. Sotto un peculiare Incantamento, non puoi fare a meno di strappare e divorare la carta.\n\"Ehi? Che ti prende stavolta? Mangi l'aria?\"\nMurphy ti ridesta dal Fantasma con un calcio. Tornando alla realtà, non c'è nulla davanti a te."
  },
  Event_7027_Name = {
    Text = "Missiva Inattesa"
  },
  Event_7028_ChoiceDesc1 = {
    Text = "[Leave] Incidi 1 Orazione su 3"
  },
  Event_7028_Desc = {
    Text = "Sentendo la tua voce, la sagoma si ferma; la voce di Clementine riesce a malapena a filtrare attraverso la fitta nebbia.\n\"Oh—sei tu,\" dice, indistinta e sfumata, come la luce della luna che si dissolve nell'acqua. \"Non preoccuparti, starai bene\"— è un bel pensiero, ma difficile da credere.\n\"Una volta che avrai finito qui, ci incontreremo di nuovo.\""
  },
  Event_7028_Name = {
    Text = "Figura Avvolta nella Nebbia"
  },
  Event_7029_ChoiceDesc1 = {
    Text = "[Recipient: Academic Office] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_7029_ChoiceDesc2 = {
    Text = "[Recipient: My Partner] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_7029_Desc = {
    Text = "Mentre scrivi il nome del destinatario, dal foglio si leva del fumo. Una mano invisibile te lo strappa con forza—\nAccompagnato da un suono di masticazione, il tuo corpo si fa improvvisamente pesante.\nMa la reliquia nella tua mano ti dice che questo viaggio non è stato del tutto vano."
  },
  Event_7029_Name = {Text = "Monologo"},
  Event_7030_ChoiceDesc1 = {
    Text = "[Insert your Silver Key]"
  },
  Event_7030_Desc = {
    Text = "Sembra esserci qualcosa all'interno della D-melma sovrasatura... Usa la Chiave d'argento per convertirla nel tuo stesso Potere."
  },
  Event_7030_Name = {
    Text = "Punto di Estrazione"
  },
  Event_7031_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7031_Desc = {
    Text = "Aspettiamo che emergano dalle ombre."
  },
  Event_7031_Name = {
    Text = "Corvo della Lanterna"
  },
  Event_7032_ChoiceDesc1 = {
    Text = "[Call the Crow] Ricevi 35 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_7032_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_7032_Desc = {
    Text = [[
Gli uccelli oscuri, ispirati, si gonfiano e sputano qualcosa sulla tua mano.
Volano di nuovo sull'albero maestro, fissandoti con sguardi intensi.]]
  },
  Event_7032_Name = {
    Text = "Corvo Solitario"
  },
  Event_7033_ChoiceDesc1 = {
    Text = "[Enter Cave]"
  },
  Event_7033_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7033_Desc = {
    Text = "\"Cough, cough, cough...\"\nUna voce così familiare... La riconosco, squeak!\nGli umani fanno questo suono quando sono malati o in punto di morte!\nPresto, andiamo a vedere, squeak!"
  },
  Event_7033_Name = {
    Text = "Profondità della caverna"
  },
  Event_7034_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7034_Desc = {
    Text = "Hai studiato tutto ciò che riguarda gli Argenti, incluso come valutarne il grado.\nChiaramente, questi Argenti non soddisfano i requisiti minimi per la raffinazione.\nDevi abbandonarli, insieme alle Anime frammentate che potrebbero essere intrappolate.\nImparare a lasciar andare è una lezione essenziale per un Custode."
  },
  Event_7034_Name = {
    Text = "Anima Incatenata"
  },
  Event_7035_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7035_Desc = {
    Text = "Questo è un Passaggio Unidirezionale; non puoi tornare all'ingresso attraverso di esso."
  },
  Event_7035_Name = {Text = "Passaggio"},
  Event_7036_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7036_Desc = {
    Text = "Prima finisce, prima potremo riposare. Gli Investigatori Mythag non temono il pericolo."
  },
  Event_7036_Name = {
    Text = "Porta dell'Infinito"
  },
  Event_7037_ChoiceDesc1 = {
    Text = "[Per favore, spostatevi, ho una questione urgente.]"
  },
  Event_7037_ChoiceDesc2 = {
    Text = "[Would Love to Hear More]"
  },
  Event_7037_Desc = {
    Text = "\"Mi scusi, la prego attenda. Vedo che ha un'espressione seria e affrettata; forse si trova invischiato in qualche sorta di dilemma.\nMa non si dovrebbe perdere la visione d'insieme né la lucidità mentale a causa delle difficoltà presenti.\nAd esempio, negli ultimi giorni ho riflettuto seriamente su molte incongruenze tra la leggenda di Cerbero e la situazione attuale.\""
  },
  Event_7037_Name = {
    Text = "Compagno di viaggio insolito II"
  },
  Event_7038_ChoiceDesc1 = {
    Text = "[Receive the Gift]"
  },
  Event_7038_ChoiceDesc2 = {
    Text = "[Decline Kindly]"
  },
  Event_7038_Desc = {
    Text = "Il ragazzo siede sul davanzale, guardandovi. Vi aspetta da molto tempo.\n\"Lo spettacolo è stato un successo, g-grazie.\"\n\"Partirò presto... Questo è un regalo per voi.\"\nIl ragazzo vi tende la mano.\nVedete una confezione regalo splendidamente incartata, con del sangue che trasuda e macchia la mano del ragazzo."
  },
  Event_7038_Name = {
    Text = "Fine Ultima VI"
  },
  Event_7039_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7039_Desc = {
    Text = "Spero che tu possa avere sempre questo genere di sicurezza."
  },
  Event_7039_Name = {
    Text = "Riflesso Informe"
  },
  Event_7040_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7040_Desc = {
    Text = "Prendi questo piccolo, morbido orecchio.\nÈ avvolto in cera appiccicosa, adagiato silenziosamente al centro del tuo palmo.\nUn forte senso di responsabilità sgorga dentro di te.\nPrimo, il bar è fuori discussione; la musica lì è troppo chiassosa.\nSecondo, anche il Wellington Garden Theatre è da escludere; la sua orchestra è ormai superata da tempo.\nE allora...\nTu e i tuoi compagni accettate di buon grado il fatto di avere un nuovo piccolo animale da compagnia."
  },
  Event_7040_Name = {
    Text = "Ascolta attentamente"
  },
  Event_7041_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7041_Desc = {
    Text = "\"Il Professor Alistair è la pietra angolare di Mythag. Senza di lui, tutto cesserà di funzionare.\"\nRicordi vagamente Czort che diceva questo durante una lezione sonnolenta, battendo sulla lavagna con un'espressione severa.\nSe questa pietra angolare dovesse sgretolarsi, come faresti a farcela? Una paura profonda ti avvolge.\n\"Dove stai andando?\" La voce di Ramona ti riporta alla realtà.\nEra il passato o il futuro, reale o immaginario, o un sogno da un'altra dimensione? Non riesci a distinguerlo.\nNella tua mano appare un \"Dono\"."
  },
  Event_7041_Name = {
    Text = "Ululato del Caos"
  },
  Event_7042_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7042_Desc = {
    Text = "\"Questa sedia a rotelle è il mio secondo paio di gambe; probabilmente non me ne separerò mai in questa vita,\" disse il Professor Alistair con un sorriso amaro, \"ma la cosa sfortunata è che mi ha reso molto più basso.\"\n\nQuindi, questo non può essere il vero Professor Alistair."
  },
  Event_7042_Name = {
    Text = "Ululato del Caos"
  },
  Event_7043_ChoiceDesc1 = {
    Text = "[Chi sta parlando?] Scegli 1 tra 3 Carte di comando e ottieni Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7043_ChoiceDesc2 = {
    Text = "[Che Whiskey, fammi Assaggiare] Scegli 1 tra 3 Carte di comando e ottieni Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7043_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7043_Desc = {
    Text = "\n\"Davvero non vuoi nemmeno un sorso? Questo è whiskey pregiato. Se non fosse stato per la generosità del proprietario del bar nel regalarmi un'intera bottiglia, non oserei condividerne una goccia con te.\"\n\"Quindi, lo hai aiutato a liberarsi di quel tizio macilento dalla pelle gommosa che beveva solo Bloody Mary? È tutto ciò che il proprietario ti ha dato come ricompensa per quell'indagine. Ci hai speso un mese, hai visitato trenta famiglie, ti sei trovato davanti a undici porte chiuse e hai esaurito diciassette proiettili di revolver. Una bottiglia di whiskey, e non riesci nemmeno a rientrare delle spese.\"\n\"Va bene, va bene, non essere così tirchio. Almeno adesso abbiamo questa bottiglia di whiskey, no?\""
  },
  Event_7043_Name = {
    Text = "Frammento di Ricordi: Whiskey"
  },
  Event_7044_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7044_Desc = {
    Text = "Afferri i Tentacoli del Risvegliatore; lui si volta a guardarti, i suoi occhi balenano di una luce oscura.\nNon dice nulla, ma comprendi il messaggio celato—\n\"Stai oltrepassando i limiti.\""
  },
  Event_7044_Name = {
    Text = "L'Effetto Farfalla"
  },
  Event_7045_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7045_Desc = {
    Text = "Il telegrafo è completamente rotto. Puoi immaginare la disperazione del suo proprietario durante la tempesta... proprio come ti senti adesso."
  },
  Event_7045_Name = {
    Text = "Eredità Antica"
  },
  Event_7046_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7046_Desc = {
    Text = "Nome: Leigh\nEtà: 20\nComplicazioni: Sete di Sangue accompagnata da grave Isteria\nIperplasia: Tentacoli rosso intenso @2 apparato boccale\nInnesti: Organi e tessuti da consanguinei diretti @3\nMotivo del trasferimento: Nessun motivo particolare. Semplicemente non mi piace.\n(Il resto è cancellato)"
  },
  Event_7046_Name = {
    Text = "Registro degli Organi"
  },
  Event_7047_ChoiceDesc1 = {
    Text = "[Receive Blessing] Perdi tutti i Sigilli Neri. Ottieni una Reliquia d'Oro."
  },
  Event_7047_Desc = {
    Text = "Un grumo di melma nera appare dinanzi a te, tremante, mentre ti porge un documento.\n\"Non posso uscire adesso... ma puoi consultare i nostri servizi personalizzati...\"\nUna voce di donna risuona dall'interno del petto della melma, leggermente in preda al panico, come se si nascondesse da qualcosa.\n\"Le Benedizioni Fatate si attivano in base al livello di iscrizione, equità garantita per tutti.\"\n\"Firma, presto!\""
  },
  Event_7047_Name = {
    Text = "Benedizione della Fata"
  },
  Event_7048_ChoiceDesc1 = {
    Text = "[Listen Closely] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_7048_ChoiceDesc2 = {
    Text = "[Inspect] Tutti i Risvegliati ottengono 50 Aliemus, ma sviluppi [(Skill.Arg1)]."
  },
  Event_7048_ChoiceDesc3 = {
    Text = "[Leave Directly] Incidi 1 Orazione su 3"
  },
  Event_7048_Desc = {
    Text = "\"Lo sapevi?\" Mentre Ramona cercava la figura misteriosa, una voce sussurrò all'improvviso: \"Sai di quella faccenda? Quella faccenda terribilmente importante?\""
  },
  Event_7048_Name = {
    Text = "Orecchie Altrui"
  },
  Event_7049_ChoiceDesc1 = {
    Text = "[Focus] Distruggi fino a 2 Carte sintomo."
  },
  Event_7049_ChoiceDesc2 = {
    Text = "[Meditate] Risveglia un Risvegliato."
  },
  Event_7049_ChoiceDesc3 = {
    Text = "[Connect] Recupera Arg2 PV."
  },
  Event_7049_Desc = {
    Text = "La nebbia si aggrappa densa mentre il tuo distintivo emette un pallido bagliore argenteo. Il comunicatore crepita, prendendo vita. Qualcuno sta chiamando."
  },
  Event_7049_Name = {Text = "Crocevia"},
  Event_7050_ChoiceDesc1 = {
    Text = "[Handle Carefully] Aumenta gli HP massimi di Arg1"
  },
  Event_7050_ChoiceDesc2 = {
    Text = "[Farsi avanti] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7050_Desc = {
    Text = "Un'ombra evocata dal Dominio tende la mano verso di te, la sua figura indistinta.\nRicordi che un Investigatore di Mythag un tempo salì a bordo di questa nave. Potrebbe essere lui?\nO è soltanto un altro misero ricordo imprigionato dal Dominio?"
  },
  Event_7050_Name = {
    Text = "Portatore della Chiave d'Argento"
  },
  Event_7051_ChoiceDesc1 = {
    Text = "[Leave] Ottieni la Reliquia dorata \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7051_Desc = {
    Text = "\"Vedi, a causa di un mio commento casuale, ho trascurato la situazione più urgente, il che non va bene.\nSe indugiamo ancora, la tua preda fuggirà lontano.\nCome scusa, queste cose sono per te.\"\n\nL'uomo divaga su qualcos'altro, consegnandoti un certo oggetto."
  },
  Event_7051_Name = {
    Text = "Compagno di viaggio insolito II"
  },
  Event_7052_ChoiceDesc1 = {
    Text = "[Leave] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7052_Desc = {
    Text = "\"Che tu possa ottenere ciò che desideri.\"\nL'uomo scrollò le spalle e si fece da parte, liberando il passaggio."
  },
  Event_7052_Name = {
    Text = "Compagno di viaggio insolito II"
  },
  Event_7053_ChoiceDesc1 = {Text = "[Take It]"},
  Event_7053_Desc = {
    Text = "Una sostanza argentea simile al mercurio, raffinata dalla D-melma, contenente un forte potere mentale, utilizzata per collegare più Risvegliatori nei rituali Una sostanza argentea simile al mercurio, raffinata dalla D-melma, contenente un forte potere mentale, utilizzata per collegare più Risvegliatori nei rituali."
  },
  Event_7053_Name = {Text = "Argento"},
  Event_7054_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7054_Desc = {
    Text = [[
Ti incammini verso un nuovo bivio.
Il sole sorge come sempre, la gente muore come sempre, e tu ti perdi come sempre.
Nulla sembra nuovo.]]
  },
  Event_7054_Name = {
    Text = "Labirinto di Occhi"
  },
  Event_7055_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7055_Desc = {
    Text = "Sembra un'Ombra distorta, rifratta dalla luce."
  },
  Event_7055_Name = {
    Text = "Relitti nel Barile"
  },
  Event_7056_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7056_Desc = {
    Text = "Ti volti e vedi un paio solitario di scarpe di cuoio.\n\"Mi scusi, non ho cattive intenzioni.\"\n\"Se trova il mio corpo, gli dica che il suo più fedele compagno di cammino lo attende nella Vetrina 45, Sala Espositiva 1.\"\n\"— Ricordi, quelle di vacchetta, non quelle di capretto.\""
  },
  Event_7056_Name = {Text = "Oxford"},
  Event_7057_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7057_Desc = {
    Text = "Dev'essere l'ex allievo — gli apri le braccia, ma ciò che segue è un dolore gelido che penetra fino alle ossa.\nQuando il dolore svanisce, i tuoi arti diventano straordinariamente forti, più forti che mai."
  },
  Event_7057_Name = {
    Text = "Portatore della Chiave d'Argento"
  },
  Event_7058_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7058_Desc = {
    Text = "La nebbia davanti a te sembra diradarsi.\n\nSenti la tua Visuale farsi più nitida per la prossima mossa."
  },
  Event_7058_Name = {
    Text = "Prova Demoniaca"
  },
  Event_7059_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7059_Desc = {
    Text = "Il Fantasma si avvicina, le Memorie riaffiorano e la lucidità colpisce."
  },
  Event_7059_Name = {Text = "Miraggio"},
  Event_7060_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7060_Desc = {
    Text = "Il suo subconscio continua ad alterare qualcosa nell'invisibile."
  },
  Event_7060_Name = {
    Text = "Sguardo Divino"
  },
  Event_7061_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7061_Desc = {
    Text = "Nel pieno di una crisi, non è il momento di raccogliere Nuclei d'Argento."
  },
  Event_7061_Name = {
    Text = "Prova dell'Essere"
  },
  Event_7062_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 1 di 3 Reliquie d'argento, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_7062_Desc = {
    Text = "La figura indistinta si fa gradualmente nitida, e non è né un Dissoluto né segni di Cataclisma, ma una Clementine dall'aspetto normale, priva di ali.\n\"Che coincidenza, anche tu sei qui a goderti il chiaro di luna?\" dice con un sorriso, e avverti un'ondata di vertigine. \"Nelle notti nebbiose, resta prudente.\nQuei piccoli qui non sembrano molto ben educati.\""
  },
  Event_7062_Name = {
    Text = "Figura Avvolta nella Nebbia"
  },
  Event_7063_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7063_Desc = {
    Text = "Quando il blocco di gesso si frantumò al suolo, il suo corpo si spezzò. Ululati riluttanti invasero la tua mente, ma fortunatamente ti ritraesti in tempo."
  },
  Event_7063_Name = {
    Text = "Carne Riforgiata"
  },
  Event_7064_ChoiceDesc1 = {
    Text = "[Ascoltare la tristezza] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7064_ChoiceDesc2 = {
    Text = "[Hear Joy] Ricevi 15 Sigilli Neri per ogni Risvegliato con 50 o più Aliemus."
  },
  Event_7064_ChoiceDesc3 = {
    Text = "[Leave] Incidi 1 Orazione su 3"
  },
  Event_7064_Desc = {
    Text = "Melodioso, lirico, gioioso, doloroso... Il motivo riecheggia nel Dominio, la sua origine incerta.\nÈ la sinfonia dall'impianto audio della nave fantasma, o una Rapsodia notturna imprigionata nel Dominio?"
  },
  Event_7064_Name = {
    Text = "Eco Senza Nome"
  },
  Event_7065_ChoiceDesc1 = {
    Text = "[They're Searching for Someone] Distruggi una Carta di comando e ricevi 25 Sigilli Neri."
  },
  Event_7065_ChoiceDesc2 = {
    Text = "[They're Searching for Something] Duplica una Carta, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_7065_Desc = {
    Text = "Perché i Devoti del Portatore di Luce sono comparsi a Rye? Ci sono troppi misteri qui.\nIl Segugio infernale Cerberus, Francis, la direttrice del Sanatorio di Rye, l'Associazione degli Scultori, la Chiesa dei Portatori di Luce...\nDeve esserci un'origine che li ha condotti tutti in questa desolata cittadina.\nLa macchina da scrivere sputa improvvisamente inchiostro nero, come a esortarti a digitare qualcosa."
  },
  Event_7065_Name = {
    Text = "Input Enigmatico"
  },
  Event_7066_ChoiceDesc1 = {
    Text = "[Tightly Close Your Eyes]"
  },
  Event_7066_ChoiceDesc2 = {
    Text = "[Escape Scene]"
  },
  Event_7066_Desc = {
    Text = "L'esibizione si interrompe bruscamente. Ti guardi intorno e trovi il pubblico seduto tutto attorno a te.\nHanno tutti lo stesso volto del ragazzo, e ti fissano all'unisono.\nAh—\nAprono silenziosamente le loro bocche nere come la pece verso di te."
  },
  Event_7066_Name = {
    Text = "Fine Ultima V"
  },
  Event_7067_ChoiceDesc1 = {
    Text = "[Pick up the Photo] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7067_ChoiceDesc2 = {
    Text = "[Check Film] Sviluppa il Sintomo [(Skill.Arg1)] e cambia l'Orazione da incidere.(Utilizzi: 1/2)"
  },
  Event_7067_Desc = {
    Text = "Poni la pellicola sotto la fioca luce rossa, rivelando immagini sbiadite attraverso la base traslucida.\nMani, piedi, bulbi oculari, organi... ogni parte umana immaginabile e inimmaginabile è fedelmente impressa sulla pellicola.\nSono meticolosamente pulite e disposte, ordinate come la tua prima poesia in rima."
  },
  Event_7067_Name = {
    Text = "Verbale Fedele"
  },
  Event_7068_ChoiceDesc1 = {
    Text = "[Princess's Guard] Risveglia un Risvegliatore casuale, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_7068_ChoiceDesc2 = {
    Text = "[Thinker] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7068_Desc = {
    Text = "\"Ta, ta, ta...\"\nPassi si avvicinarono Da Lontano, e vedesti qualcuno sul punto di spalancare il grande portone dello studio.\nSenza più un posto dove rifugiarti, potevi solo fingere di essere una Scultura di Cera nella penombra, tentando di eludere quello Sguardo indagatore."
  },
  Event_7068_Name = {
    Text = "Travestimento perfetto"
  },
  Event_7069_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7069_Desc = {
    Text = "\"Bene, bene!\" La voce traboccava di gioia. \"Finalmente sei diventata come me, Sorella Sasha!\""
  },
  Event_7069_Name = {
    Text = "\"Sorella Sasha\""
  },
  Event_7070_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7070_Desc = {
    Text = "Forse qualcuno li ha condotti qui.\nProseguendo nell'esplorazione, l'identità di quella persona verrà infine alla luce."
  },
  Event_7070_Name = {
    Text = "Input Enigmatico"
  },
  Event_7071_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7071_Desc = {
    Text = "Prima finisce, prima potremo riposare. Gli Investigatori Mythag non temono il pericolo."
  },
  Event_7071_Name = {
    Text = "Porte Infinite"
  },
  Event_7072_ChoiceDesc1 = {
    Text = "[Choose Morality] Recupera Arg1 HP"
  },
  Event_7072_ChoiceDesc2 = {
    Text = "[Choose HP] Recupera tutti gli HP, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_7072_Desc = {
    Text = [[
Un tempo forse avevi un cuore d'oro.
Batteva instancabile giorno e notte, lottando per la tua vita e i tuoi sogni... caldo, appassionato, colmo di speranza.
Ma a un certo punto ha rallentato. Come se, stretto tra la vita e la morale, potesse sostenerne soltanto una.]]
  },
  Event_7072_Name = {
    Text = "Brama Maledetta"
  },
  Event_7073_ChoiceDesc1 = {
    Text = "[Pick up the Photo] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7073_ChoiceDesc2 = {
    Text = "[Check Film] Sviluppa il Sintomo [(Skill.Arg1)] e cambia l'Orazione da incidere.(Utilizzi: 2/2)"
  },
  Event_7073_Desc = {
    Text = "\n\"Dunque, hai registrato tutto fedelmente.\"\n\"Sì, la verità giace nella pellicola.\"\nLa conversazione si interruppe bruscamente, e innumerevoli occhi invisibili si volsero verso di te, come in attesa del tuo verdetto finale."
  },
  Event_7073_Name = {
    Text = "Testimonianza Oculare"
  },
  Event_7074_ChoiceDesc1 = {
    Text = "[Leave] Aumenta i PV massimi di Arg1 e ricevi 25 Sigilli Neri."
  },
  Event_7074_Desc = {
    Text = "La tua voce viene divorata dal vento ululante.\n\"Non hai bisogno di conoscermi,\" il sibilo si fa più nitido, \"Herbert, Herbert è colui che cerchi. Lascia che cada dal falso sogno nella realtà aspra e gelida.\"\n\"Ti elargirò la mia Benedizione, concedendoti il più delizioso...\""
  },
  Event_7074_Name = {
    Text = "Compagno di viaggio insolito VI"
  },
  Event_7075_ChoiceDesc1 = {
    Text = "[Leave] Ottieni la Reliquia \"(RelicConfig.Arg1)\", ma sviluppi il Sintomo \"(Skill.Arg2)\"."
  },
  Event_7075_Desc = {
    Text = "\n\"Sì, la povera anima smarrita, dotata di potere eppure incapace di riconoscere sé stessa.\nLe tenderai la mano? O alzerai la tua arma contro di Lui?\"\nL'uomo si gettò nelle acque impetuose. Proprio mentre la sua figura stava per cadere, il tuo sguardo incrociò per caso il suo. Era un paio di pupille dorate, simili al miele, con la fessura verticale di un serpente.\nE là dove si trovava un istante prima, vi era una piccola lampada che emanava fumo viola."
  },
  Event_7075_Name = {
    Text = "Compagno di viaggio insolito VI"
  },
  Event_7076_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7076_Desc = {
    Text = "\"La cautela è una virtù, ma la cautela eccessiva è una forma di inopportunità,\" osservò una voce monotona venata di disappunto, \"il moto delle stelle disturberà la genesi del dormiveglia del Risvegliato, e il momento giusto può far gonfiare rapidamente il suo Aliemus, come un palloncino che si dilata. In breve, c'è ancora tempo per afferrare la coda della cometa; ricordati di ottimizzare la tua velocità di reazione, che non è migliore di quella di una tartaruga, la prossima volta.\""
  },
  Event_7076_Name = {Text = "Elevazione"},
  Event_7077_ChoiceDesc1 = {
    Text = "[Restore] Riduci lo Stress attuale della metà."
  },
  Event_7077_Desc = {
    Text = "Avete toccato la camera di stabilizzazione, ripristinando il vostro livello di stress attuale."
  },
  Event_7077_Name = {
    Text = "Punto di Equilibrio dello Stress"
  },
  Event_7078_ChoiceDesc1 = {
    Text = "[Consolarla] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_7078_ChoiceDesc2 = {
    Text = "[Blame Her] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 3 Carte di comando casuali, ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7078_Desc = {
    Text = "\"Io sono l'Ombra dell'Investigatore defunto, e l'assassino è quella Chiave d'argento.\"\nLa donna si strinse la testa in preda all'agonia. I suoi folti capelli erano adornati da innumerevoli occhi scintillanti che battevano le palpebre...\n\"Dicevano sempre: No, Charlotte! Ahimè, Charlotte!\nCosì ho pensato: se potessi collegare molti Risvegliati contemporaneamente, Tutti farebbero silenzio.\"\n\"Poi... non so cosa sia successo, e quando mi sono svegliata, ero diventata così. Ahimè!\""
  },
  Event_7078_Name = {
    Text = "Ombra dell'Investigatore"
  },
  Event_7079_ChoiceDesc1 = {
    Text = "[Climb the Wall] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7079_ChoiceDesc2 = {
    Text = "[Entrare nel labirinto] 1 Carta casuale ottiene l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_7079_Desc = {
    Text = "Il tuo cervello è un labirinto.\nTroppi pensieri vi si intrecciano, l'uscita è a portata de Lo Sguardo, ma le alte mura del pensiero si ergono tra voi."
  },
  Event_7079_Name = {
    Text = "Labirinto mentale"
  },
  Event_7080_ChoiceDesc1 = {
    Text = "[Gaze at Phantasm] Ottieni 1 di 3 Reliquie d'Argento"
  },
  Event_7080_ChoiceDesc2 = {
    Text = "[Near Phantasm] Ottieni le Reliquie d'Argento \"(RelicConfig.Arg1)\" e \"(RelicConfig.Arg2)\", ma sviluppa \"(Skill.Arg3)\" due volte."
  },
  Event_7080_Desc = {
    Text = "In lontananza, sembra che un cono vulcanico sia eruttato, e una colonna di fumo dalla forma umana si leva nel cielo tempestoso.\nMa questa è Elworth, dove esistono solo infinite e svettanti montagne innevate e grotte carsiche calcaree.\nLe continue anomalie ti hanno forse condotto alla Confusione spirituale?"
  },
  Event_7080_Name = {
    Text = "Fantasma del Vulcano"
  },
  Event_7081_ChoiceDesc1 = {
    Text = "[What Did I See] Ottieni la Reliquia d'Argento [(RelicConfig.Arg1)]"
  },
  Event_7081_ChoiceDesc2 = {
    Text = "[I Saw Nothing] Ottieni la Reliquia d'Oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7081_Desc = {
    Text = "Un liquido trasuda dagli angoli dei tuoi occhi, la sua consistenza appiccicosa è inquietante.\nIn fin dei conti, è stato provocato da ciò che hai visto — o davvero non hai visto nulla?"
  },
  Event_7081_Name = {
    Text = "L'Invisibile"
  },
  Event_7082_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7082_Desc = {
    Text = "Hai provato gioia. Hai provato dolore. Ora riconosci che non sono le tue emozioni a sopraffarti.\nChiudendo gli occhi e coprendoti le orecchie, la Chiave d'argento risplende di una luce abbagliante.\nAndrà tutto bene. Finalmente, riesci a fare un respiro profondo."
  },
  Event_7082_Name = {Text = "Indulgenza"},
  Event_7083_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7083_Desc = {
    Text = [[
Il Portatore del Pugnale emette un grido simile a un uccello di morte in un cimitero a mezzanotte.
Il suono svanisce all'istante, e gli altri due Navigatori scompaiono anch'essi... Si scopre che era solo un'Illusione riflessa dal Dominio.]]
  },
  Event_7083_Name = {
    Text = "Caccia implacabile"
  },
  Event_7084_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7084_Desc = {
    Text = "Fluttua silenzioso nell'aria, senza battere ciglio, lo sguardo intenso — come se cercasse di dirti qualcosa.\nGli occhi possono celare un'anima, ma senza parole puoi solo percepire una traccia di urgenza e un accenno di dolore.\nSvanisce nel nulla."
  },
  Event_7084_Name = {
    Text = "Sguardo Cieco"
  },
  Event_7085_ChoiceDesc1 = {
    Text = "[Agree] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7085_ChoiceDesc2 = {
    Text = "[Gift] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7085_ChoiceDesc3 = {
    Text = "[Turn and Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7085_Desc = {
    Text = "\n\"Se un giorno dovrò cadere, allora spero di cadere nell'acqua.\nL'acqua corrente che mi copre le narici sembra un dolce vecchio sogno.\nIl liquido in cui sprofondo\nè la coppa che @2 desidera di più.\""
  },
  Event_7085_Name = {
    Text = "Rito Acquatico"
  },
  Event_7086_ChoiceDesc1 = {
    Text = "[Resist Phantasm] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7086_ChoiceDesc2 = {
    Text = "[Extract Aliemus] Risveglia 2 Risvegliatori casuali, ma sviluppa [(Skill.Arg1)] due volte."
  },
  Event_7086_Desc = {
    Text = "La Dimensione frammentata collassa gradualmente, e i Fantasmi di altre Dimensioni invadono la stanza demente."
  },
  Event_7086_Name = {
    Text = "Fantasma Dimensionale"
  },
  Event_7087_ChoiceDesc1 = {
    Text = "[Leave] Risveglia un Risvegliatore casuale"
  },
  Event_7087_Desc = {
    Text = "La ragazza si ferma, lisciandosi la gonna.\n\"Quello che posso fare per te... è solo questo.\""
  },
  Event_7087_Name = {
    Text = "Fanciulla in Bianco"
  },
  Event_7088_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7088_Desc = {
    Text = "Chi parla?\nAbbасsi lo sguardo e vedi un riflesso sfocato—indossa i tuoi stessi abiti ma tiene un coltello, sorridendoti."
  },
  Event_7088_Name = {
    Text = "Ciò che Non Dovresti Cercare"
  },
  Event_70892_ChoiceDesc1 = {
    Text = "[Follow the Body's Memory] Salta la battaglia e ottieni una vittoria immediata, ma perdi Arg1 PV."
  },
  Event_70892_ChoiceDesc2 = {
    Text = "[Leave] Entra in Battaglia"
  },
  Event_70892_Desc = {
    Text = "Sebbene il nemico sia straordinariamente potente, conosci già alla perfezione le tecniche per sconfiggerlo."
  },
  Event_70892_Name = {
    Text = "Memoria Muscolare"
  },
  Event_7089_ChoiceDesc1 = {
    Text = "[Rake Koum]"
  },
  Event_7089_ChoiceDesc2 = {
    Text = "[Attack the Test Subject]"
  },
  Event_7089_Desc = {
    Text = "Koum morse la nuca di un soggetto sperimentale, pronto a scagliarlo via. All'improvviso, il soggetto ruotò la testa di 180° come un gufo e beccò il volto di Koum."
  },
  Event_7089_Name = {Text = "Arena"},
  Event_7090_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7090_Desc = {
    Text = [[
Stringi la chiave d'argento, percependo il richiamo della genesi attraverso lo sconvolgimento della dimensione.
Per combattere il malvagio Segugio infernale sconosciuto, devi usare ogni potere a disposizione]]
  },
  Event_7090_Name = {
    Text = "Fantasma Dimensionale"
  },
  Event_7091_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7091_Desc = {
    Text = "\n\"Quanto a quell'investigatore, il curatore intende interrogarlo personalmente...\nPortatemelo vivo...\"\nLa voce si affievolì gradualmente, dissolvendosi infine nell'Oscurità."
  },
  Event_7091_Name = {
    Text = "Orecchio indiscreto"
  },
  Event_7092_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7092_Desc = {
    Text = "La sensazione di assenza di gravità ti scuote dal torpore. Il suolo sotto i tuoi piedi è solido e affidabile, e ai tuoi piedi giace uno specchio quadrato di fattura squisita."
  },
  Event_7092_Name = {
    Text = "Specchio nello Specchio"
  },
  Event_7093_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7093_Desc = {
    Text = "Tu non discuti mai con chi è già caduto nella Follia e non ha speranza di guarigione, questo lascerebbe la tua anima completamente Divorata dalle domande di mezzanotte — risparmia te stesso!"
  },
  Event_7093_Name = {
    Text = "Rito Acquatico"
  },
  Event_7094_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7094_Desc = {
    Text = [[
Che aspetto dovrebbe avere il volto della scultura di cera?
Chiudete gli occhi, e innumerevoli volti sfocati appaiono nella vostra mente.
Sono come candele dalle fiamme pallide, che emergono e svaniscono nel fiume oscuro...
Seguite il fiume fino alla sua fine, dove l'unica, ultima scultura di cera si erge.
Avvicinandovi, vedete...@2.]]
  },
  Event_7094_Name = {
    Text = "Scultura di Cera Incompiuta"
  },
  Event_7095_ChoiceDesc1 = {
    Text = "[Attack the Dagger-Wielder] Ottieni la Reliquia maledetta \"(RelicConfig.Arg2)\", ma sviluppi \"(Skill.Arg1)\"."
  },
  Event_7095_ChoiceDesc2 = {
    Text = "[Ambush the Blade-Wielder] Ottieni le Reliquie d'Argento \"(RelicConfig.Arg2)\" e \"(RelicConfig.Arg3)\", ma sviluppa \"(Skill.Arg1)\" due volte."
  },
  Event_7095_ChoiceDesc3 = {
    Text = "[Trip the Spear-Wielder] Ottieni la Reliquia d'Argento [(RelicConfig.Arg1)]"
  },
  Event_7095_Desc = {
    Text = "Tre Navigatori si aggrappano a te con forza, i loro sguardi frenetici e ardenti quasi incendiano il tuo mantello.\nUno sguardo all'indietro rivela che i tre sono diversi tra loro—\nIl Navigatore che brandisce un'enorme lama urla con la violenza maggiore, eppure agisce con una certa noncuranza.\nIl Navigatore che impugna una lancia si muove in sincronia, come un bambino che impara a parlare.\nIl Navigatore che stringe un Pugnale resta indietro, e il mormorio di Preghiere testimonia il suo fanatismo."
  },
  Event_7095_Name = {
    Text = "Caccia implacabile"
  },
  Event_7096_ChoiceDesc1 = {
    Text = "[Leave] Ottieni la Reliquia \"(RelicConfig.Arg1)\", ma sviluppi il Sintomo \"(Skill.Arg2)\"."
  },
  Event_7096_Desc = {
    Text = [[
Scarti con cura il dono.
Un paio di bulbi oculari riposa silenzioso nella scatola.
"Ti dono i miei occhi."
"Proprio come lui fece un tempo per me."]]
  },
  Event_7096_Name = {
    Text = "Fine Ultima VI"
  },
  Event_7097_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7097_Desc = {
    Text = "Allungando la mano attraverso il centro della luce, raccogli un Argento solidificato. Questo prezioso vascello di Memoria e Anima è rovente, e rifrange colori innaturali.\nPrima che distorca tutta la luce, il dolore bruciante ti costringe a rigettarlo nell'oscurità."
  },
  Event_7097_Name = {
    Text = "Bagliore Notturno"
  },
  Event_7098_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7098_Desc = {
    Text = "Hai rifiutato il dono del ragazzo.\nIl ragazzo ti ha fissato con occhi vuoti. Ha sospirato piano.\n\"Be', allora addio.\"\nCon quelle parole, il ragazzo ha fatto un inchino ed è caduto dalla finestra.\nÈ svanito, come una farfalla danzante o una brezza passeggera."
  },
  Event_7098_Name = {
    Text = "Fine Ultima VI"
  },
  Event_7099_ChoiceDesc1 = {
    Text = "Scegli un'Orazione Base"
  },
  Event_7100_ChoiceDesc1 = {
    Text = "[Accept Ear] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7100_ChoiceDesc2 = {
    Text = "[Reject Request] Incidi 1 Orazione su 3"
  },
  Event_7100_Desc = {
    Text = "Una cascata di note eleganti fluisce dalla punta delle dita.\nIl malinconico pianista di cera siede solo accanto alla finestra.\nDa quando ha acquisito coscienza, il Museo delle Cere è stato il suo intero mondo.\nBrama di udire qualcosa di diverso, specialmente... un genere musicale chiamato jazz.\nAlla fine, si strappa un orecchio e ti chiede di portarlo con te.\n\"Fammi ascoltare la musica del mondo esterno... mettilo semplicemente in tasca.\""
  },
  Event_7100_Name = {
    Text = "Ascolta attentamente"
  },
  Event_7101_ChoiceDesc1 = {
    Text = "[Connect] Recupera Arg2 HP. [ExDesc1]"
  },
  Event_7101_ChoiceDesc2 = {
    Text = "[Meditate] Risveglia un Awakener. [ExDesc1]"
  },
  Event_7101_ChoiceDesc3 = {
    Text = "[Expel] Distruggi fino a 3 Carte sintomo e ottieni Arg2 Sigilli Neri."
  },
  Event_7101_Desc = {
    Text = "La nebbia si aggrappa densa mentre il tuo distintivo emette un pallido bagliore argenteo. Il comunicatore crepita, prendendo vita. Qualcuno sta chiamando."
  },
  Event_7101_Name = {Text = "Crocevia"},
  Event_7101_Tips3 = {
    Text = "Al momento non manifesti alcun Sintomo."
  },
  Event_7102_ChoiceDesc1 = {
    Text = "[Accept Challenge]"
  },
  Event_7102_ChoiceDesc2 = {
    Text = "[Punch It] Ricevi 25 Sigilli Neri"
  },
  Event_7102_Desc = {
    Text = [[
Una figura emaciata emerge dall'ombra, sbarrandoti il cammino.
Un ricordo eternamente vincolato si intrude nel dominio, proclamandosi "N". L'apparizione lancia le fiches che tiene in mano, invitandoti a unirti al Suo gioco con un gemito soffocato.
Le fiches tricolori si dispiegano davanti a te; a meno che tu non giochi una "partita" con Lui, non sembra intenzionato a lasciarti andare.]]
  },
  Event_7102_Name = {Text = "Showtime"},
  Event_7103_ChoiceDesc1 = {
    Text = "[Insert your Silver Key]"
  },
  Event_7103_Desc = {
    Text = "Sembra esserci qualcosa all'interno della D-melma sovrasatura... Usa la Chiave d'argento per convertirla nel tuo stesso Potere."
  },
  Event_7103_Name = {
    Text = "Punto di Estrazione"
  },
  Event_7104_ChoiceDesc1 = {
    Text = "[Struggle Awake] Aumenta gli HP massimi di Arg1"
  },
  Event_7104_ChoiceDesc2 = {
    Text = "[Abbandonarsi al Sopore] 2 Carte di comando casuali ottengono l'Orazione: \"(EnchantConfig.Arg1)\", infetta 2 \"(Skill.Arg2)\""
  },
  Event_7104_Desc = {
    Text = "Stringi tra le braccia una gemma scintillante.\nSi propaga dal petto, colmando il tuo corpo del caldo bagliore di memorie a lume di candela, fino a inondare la tua mente.\nBraci crepitanti, un'accogliente poltrona accanto al camino, un ricco tè caldo e un gatto acciambellato ai tuoi piedi...\nIn questa confortante sonnolenza, la tua mente si annebbia e scivoli in un dolce dormiveglia."
  },
  Event_7104_Name = {
    Text = "Abbraccio del Passato"
  },
  Event_7105_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7105_Desc = {
    Text = "Hai estratto senza pietà un'altra pellicola nascosta dentro la fotocamera, rivelando immagini che ti hanno lasciato senza parole.\nLa pellicola non sviluppata aveva fedelmente registrato— te, disteso in una pozza di fango nero."
  },
  Event_7105_Name = {
    Text = "Innocenza Registrata"
  },
  Event_7106_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7106_Desc = {
    Text = [[
Hai esaminato attentamente la fotocamera, la cui pelle e le finiture nero-oro emanavano una lucentezza elegante.
L'obiettivo era puntato su di te, come se scrutasse e spiasse...]]
  },
  Event_7106_Name = {
    Text = "Innocenza Registrata"
  },
  Event_7107_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7107_Desc = {
    Text = "Un pugno di luce lunare, raccolto nel palmo, fu cosparso sulla Tavoletta di pietra.\nQualcuno fu sepolto sotto uno spesso strato di fango, e gli astanti dichiararono che si trattava di una morte naturale, asserendo che avrebbe riposato in pace sottoterra.\nTuttavia, il fango che ricopriva il sepolto prese a ribollire, e tra le urla, una luna floscia ne strisciò fuori."
  },
  Event_7107_Name = {
    Text = "Frammento di Luna d'Argento"
  },
  Event_7108_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7108_Desc = {
    Text = "Sfiori delicatamente le fragili ali nere della farfalla. Essa freme lievemente, poi si trasforma in gocce di nero pece, cadendo nel palmo della tua mano."
  },
  Event_7108_Name = {
    Text = "Ciò che Non Dovrebbe Esistere"
  },
  Event_7109_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7109_Desc = {
    Text = "La luna solitaria pende alta nel cielo, eppure puoi udire chiaramente la sua preghiera — una strana cantilena simile ai sussurri della corruzione.\nLa preghiera cessa, e mentre stai per andartene, un fantasma bianco appare alle tue spalle.\n\"Coloro che trasgrediscono il fato e la preghiera, tanto le benedizioni quanto la punizione giungeranno come promesso.\""
  },
  Event_7109_Name = {
    Text = "Frammento di Luna d'Argento"
  },
  Event_7110_ChoiceDesc1 = {
    Text = "[Three Points]"
  },
  Event_7110_ChoiceDesc2 = {
    Text = "[Six Points]"
  },
  Event_7110_ChoiceDesc3 = {
    Text = "[One Point]"
  },
  Event_7110_Desc = {
    Text = [[
Sembra che oggi la fortuna ti sorrida.
I dadi tremano ed emettono un ronzio eccitato.
Decidi di indovinare un numero.]]
  },
  Event_7110_Name = {
    Text = "Scommessa Senza Fine"
  },
  Event_7111_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7111_Desc = {
    Text = "Questa scommessa è un'enorme truffa!\nScatti in piedi con un \"tseng\", solo per avvertire un'ondata di vertigini.\nI dadi emettono un ronzio assordante, e una voce seducente continua a indugiare nella tua mente:\n\"L'unico... l'ultimo...\""
  },
  Event_7111_Name = {
    Text = "Scommessa Senza Fine"
  },
  Event_7112_ChoiceDesc1 = {
    Text = "[Use Silver] Potenzia una Reliquia d'argento nella Reliquia d'oro [(RelicConfig.Arg1)]"
  },
  Event_7112_ChoiceDesc2 = {
    Text = "[Store Silver] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\" e \"(Skill.Arg3)\"."
  },
  Event_7112_ChoiceDesc3 = {
    Text = "[Put Back in Drawer] Ricevi 25 Sigilli Neri"
  },
  Event_7112_Desc = {
    Text = "Nel secondo cassetto sul lato destro della tua scrivania giace un solitario Nucleo d'Argento. Al toccarlo, odi l'ululare delle tempeste, il frantumarsi dei fiocchi di neve e il lamento di un flauto..."
  },
  Event_7112_Name = {
    Text = "Nucleo d'Argento Solitario"
  },
  Event_7113_ChoiceDesc1 = {
    Text = "[Listen Closely] Ottieni la Reliquia maledetta \"(RelicConfig.Arg2)\", ma sviluppa \"(Skill.Arg1)\"."
  },
  Event_7113_ChoiceDesc2 = {
    Text = "[Make a Change] Distruggi una Reliquia e ottieni una ricompensa."
  },
  Event_7113_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_7113_Desc = {
    Text = [[
Non tutte le melodie sono commoventi.
La pura dissonanza compone un lamento.]]
  },
  Event_7113_Name = {Text = "Dissonanza"},
  Event_7114_ChoiceDesc1 = {
    Text = "[Pick It Up] Ottieni la Reliquia d'Argento \"(RelicConfig.Arg2)\", ma sviluppi \"(Skill.Arg1)\"."
  },
  Event_7114_ChoiceDesc2 = {
    Text = "[Abandon It] Ricevi 25 Sigilli Neri"
  },
  Event_7114_Desc = {
    Text = "Nell'angolo occultato e marcescente del pagliaio, dentro il D-segno incrinato, qualcosa giace silenziosamente."
  },
  Event_7114_Name = {
    Text = "Sottovento del Pagliaio"
  },
  Event_7115_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7115_Desc = {
    Text = "La figura non si avvicina. Ti fissa per un istante, poi si dissolve in un pugno di sabbia argentata."
  },
  Event_7115_Name = {
    Text = "Portatore della Chiave d'Argento"
  },
  Event_7116_ChoiceDesc1 = {
    Text = "[Hold the Tentacle] Accetta l'aiuto di Tulu"
  },
  Event_7116_Desc = {
    Text = "Con un sospiro, Tulu ti raggiunge.\nArti pesanti e gelidi si aggrappano a te, soffocando il tuo impulso di lanciarti tra le fila nemiche.\n\"Sarò il tuo aiuto, ma solo per ora.\""
  },
  Event_7116_Name = {
    Text = "Promessa dell'Emissario"
  },
  Event_7117_ChoiceDesc1 = {
    Text = "[Get the Key]"
  },
  Event_7117_Desc = {
    Text = "1, 2, 3...\nJenkin è a 10 piedi dalla scrivania.\nÈ una breve distanza, eppure a lei sembra un'eternità.\nRicorda i nastri morbidi, le carte dorate delle caramelle a forma di Farfalla, e le lacrime di sua madre.\nHa pensato a tante, tante cose...\nIl suo corpo fragile guada il fiume nero, avvicinandosi centimetro dopo centimetro alla scrivania.\nLa Chiave è nel cassetto, e il prezzo per ottenerla è semplice: coraggio, destrezza e un pizzico di fortuna.\nJenkin ha tutto tranne la fortuna."
  },
  Event_7117_Name = {
    Text = "Chiave Suprema"
  },
  Event_7118_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7118_Desc = {
    Text = "È solo una scommessa. Non perderai.\nLa moneta, incisa con motivi intricati, viene lanciata in alto nell'aria, ridiscende rapidamente e si scalda nel palmo della tua mano."
  },
  Event_7118_Name = {
    Text = "Giocatore d'Azzardo Famigerato"
  },
  Event_7119_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7119_Desc = {
    Text = "È solo una scommessa. Non perderai.\nLa moneta, incisa con motivi intricati, viene lanciata in alto nell'aria, ridiscende rapidamente e si scalda nel palmo della tua mano."
  },
  Event_7119_Name = {
    Text = "Giocatore d'Azzardo Famigerato"
  },
  Event_7120_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7120_Desc = {
    Text = "È solo una scommessa. Non perderai.\nLa moneta, incisa con motivi intricati, viene lanciata in alto nell'aria, ridiscende rapidamente e si scalda nel palmo della tua mano."
  },
  Event_7120_Name = {
    Text = "Giocatore d'Azzardo Famigerato"
  },
  Event_7121_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7121_Desc = {
    Text = "Non hai alcuna Intenzione di unirti a questa seria Lezione di pianoforte.\nDopo ogni battuta, gli Studenti si sforzano di girare la testa, fingendo di ascoltare.\nL'insegnante si china leggermente, le labbra si muovono, gli occhi fissi su uno spartito inesistente.\nChiaramente non sanno cosa stanno facendo e non capiranno mai perché gli esseri umani trascorrano anni in questa pratica meccanica.\nStanno solo imitando."
  },
  Event_7121_Name = {
    Text = "Lezione di pianoforte"
  },
  Event_7122_ChoiceDesc1 = {
    Text = "[Insert your Silver Key]"
  },
  Event_7122_Desc = {
    Text = "Sembra esserci qualcosa all'interno della D-melma sovrasatura... Usa la Chiave d'argento per convertirla nel tuo stesso Potere."
  },
  Event_7122_Name = {
    Text = "Punto di Estrazione"
  },
  Event_7123_ChoiceDesc1 = {
    Text = "[Recognize Lyrics] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7123_ChoiceDesc2 = {
    Text = "[Hum Softly] Incidi 1 Orazione su 3"
  },
  Event_7123_Desc = {
    Text = [[
Antiche canzoni marinaresche echeggiano nel dominio.
Memorie confinate cantano di onde, cieli e liquori forti, in una lingua mai udita]]
  },
  Event_7123_Name = {
    Text = "Canto di Mare"
  },
  Event_7124_ChoiceDesc1 = {
    Text = "[Call the Crow] Ricevi 20 Sigilli Neri, ma sviluppa [(Skill.Arg2)]"
  },
  Event_7124_ChoiceDesc2 = {
    Text = "[Get Far Away]"
  },
  Event_7124_Desc = {
    Text = "Gli uccelli dal piumaggio nero come la pece fissano lo sguardo su di te. Dopo un lungo istante, qualcosa cade dalle loro piume..."
  },
  Event_7124_Name = {
    Text = "Corvo Solitario"
  },
  Event_7125_ChoiceDesc1 = {
    Text = "[Step Forward and Grip] 100% di probabilità di ottenere 25 Sigilli Neri"
  },
  Event_7125_ChoiceDesc2 = {
    Text = "[Friendly Response] 50% di probabilità di ottenere 50 Sigilli Neri, 50% di probabilità di non ottenere nulla."
  },
  Event_7125_Desc = {
    Text = [[
Un gatto di origine sconosciuta siede tra le D-melma, il suo corpo sfocato suggerisce che appartenga alla Dimensione spirituale.
Questa indistinta Proiezione osserva Ramona con occhi saggi, alza la zampa bianca e la invita ad avvicinarsi.]]
  },
  Event_7125_Name = {
    Text = "Abitante Errante"
  },
  Event_7126_ChoiceDesc1 = {
    Text = "[Running North]"
  },
  Event_7126_ChoiceDesc2 = {
    Text = "[Ignore the Sound]"
  },
  Event_7126_Desc = {
    Text = "Gli attacchi del nemico piovono alle spalle, le loro lame sfiorano il mantello facendo levare in volo uno stormo di gabbiani al molo.\n\"Verso nord... o a bordo della nave...\"\nPersino il più stolto degli uomini avvertirebbe che una forza invisibile vi sta guidando."
  },
  Event_7126_Name = {Text = "Verso Nord"},
  Event_7127_ChoiceDesc1 = {
    Text = "[Listen to the Sun] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_7127_ChoiceDesc2 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7127_Desc = {
    Text = "Nell'intreccio tra realtà e Illusione, i corpi celesti ruotano eternamente lungo le loro orbite predeterminate.\nInnumerevoli incontri sfiorati hanno composto una sinfonia strana e inquietante..."
  },
  Event_7127_Name = {
    Text = "Armonie Astrali"
  },
  Event_7128_ChoiceDesc1 = {
    Text = "[Leave with Sorrow] Copia una carta. Se viene copiata una Carta sintomo, ricevi 75 Sigilli Neri."
  },
  Event_7128_ChoiceDesc2 = {
    Text = "[Andarsene con Rabbia] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_7128_Desc = {
    Text = "Un liquido sgorgò dalle pupille, freddo e turbolento, portando via un frammento dell'anima."
  },
  Event_7128_Name = {
    Text = "Lamento dello Stige"
  },
  Event_7129_ChoiceDesc1 = {
    Text = "[Into the Corridor]"
  },
  Event_7129_ChoiceDesc2 = {
    Text = "[Go Against the Flow] Ricevi 25 Sigilli Neri"
  },
  Event_7129_Desc = {
    Text = [[
Il pallido chiaro di luna ignora il Passaggio del tempo, riversandosi sul corridoio silenzioso.
L'ingresso emette un bagliore sinistro sotto i raggi lunari.]]
  },
  Event_7129_Name = {
    Text = "Sala Silente"
  },
  Event_7130_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7130_Desc = {
    Text = "Decidi di riparare la scultura di cera.\nSparsi lì vicino ci sono alcuni strumenti, e scegli un pigmento chiamato \"Blu di Prussia\".\nÈ blu come una malattia."
  },
  Event_7130_Name = {
    Text = "Scultura di Cera Incompiuta"
  },
  Event_7131_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7131_Desc = {
    Text = "La Pustola emise uno Strido acuto e sinistro, accompagnato da un fischio innaturale nelle orecchie, suoni fantasmatici di flauto e la Risonanza proibita di fluidi gocciolanti.\nLa Pustola sussultò in modo bizzarro per un istante prima di irrigidirsi nel Silenzio. Assistendo alla scena, il Risveglio accanto a te sembrò ricevere una sorta di richiamo."
  },
  Event_7131_Name = {
    Text = "Pustola Bizzarra"
  },
  Event_7132_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7132_Desc = {
    Text = "Le vostre dita sfiorano la statua, percependo rientranze inaspettatamente morbide. Avevate sempre creduto fosse un'Illusione."
  },
  Event_7132_Name = {
    Text = "Resti Rattoppati"
  },
  Event_7133_ChoiceDesc1 = {
    Text = "[Tear For Her]"
  },
  Event_7133_ChoiceDesc2 = {
    Text = "[Pray to Her]"
  },
  Event_7133_Desc = {
    Text = "Nell'istante in cui sfiori la ringhiera della nave, ricordi che non ti appartengono invadono la tua mente.\nLa vestirono con un candido abito bianco, la adornarono con gioielli eleganti e la posero su un alto altare. I cittadini si inginocchiarono e si prostrarono ai suoi piedi.\nI loro occhi erano colmi di speranza: i marinai imploravano la sua protezione durante i viaggi, i pescatori speravano in una stagione di pesca serena, e gli altri abitanti desideravano un anno di navigazione tranquilla.\nTra la folla inginocchiata vi erano i suoi amici d'infanzia e i suoi familiari più cari.\nLei non voleva nulla; non sapeva cosa volesse.\nRispondere passivamente alle preghiere sembrava essere il suo unico scopo nella vita."
  },
  Event_7133_Name = {
    Text = "Riti Pre-Viaggio"
  },
  Event_7134_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7134_Desc = {
    Text = "Le pallide pupille di quel corpo mutilato ruotarono lentamente, seguendo la tua figura che si allontanava e rivelando un debole sorriso."
  },
  Event_7134_Name = {
    Text = "Resti Rattoppati"
  },
  Event_7135_ChoiceDesc1 = {
    Text = "[Face It] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_7135_ChoiceDesc2 = {
    Text = "[Abbandonare la Resistenza] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_7135_ChoiceDesc3 = {
    Text = "[Run Away] Ricevi 50 Sigilli Neri"
  },
  Event_7135_Desc = {
    Text = [[
Alcuni blocchi di scultura di cera ostruiscono il tuo cammino.
Sono storti e rozzi nell'aspetto, ben lontani dalla maestria che ci si aspetterebbe da Rogers.
"Ordini... gli ordini del padrone..."]]
  },
  Event_7135_Name = {Text = "Bozzetto"},
  Event_7136_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7136_Desc = {
    Text = "\nScegliete di fissare coraggiosamente quegli occhi.\nSono stelle brillanti, scintillanti nell'oscurità.\nPoi risero e si trasformarono in innumerevoli lune crescenti.\n\"Non hai paura degli sguardi. Non dovresti avere paura di...\nÈ da tanto che non ci vediamo, @2\"\nPrima di svanire, vi lasciarono un piccolo dono come \"memoriale del ricongiungimento\"."
  },
  Event_7136_Name = {Text = "Occhio"},
  Event_7137_ChoiceDesc1 = {
    Text = "[Switch On] Espandi la visuale attuale[ExDesc1]."
  },
  Event_7137_Desc = {
    Text = [[
Un antico dispositivo di illuminazione dissipa la Nebbia nera che lo circonda.
La Nebbia attorno ad esso fluttua ritmicamente, come se fosse perturbata dal suo respiro.]]
  },
  Event_7137_Name = {Text = "Riflettore"},
  Event_7138_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7138_Desc = {
    Text = "Dalla tua schiena si dispiegano ali trasparenti, che volteggiano e turbinano con i corvi nel fondale marino silenzioso."
  },
  Event_7138_Name = {
    Text = "Coro dei Corvi"
  },
  Event_7139_ChoiceDesc1 = {
    Text = "[Destroy It] Ottieni un [Cuore Mutato]"
  },
  Event_7139_Desc = {
    Text = "Le Pustole deformi abbandonate da individui sconosciuti sul ciglio della strada luccicano di un lurido bagliore verde oleoso, contorcendosi e mutando senza sosta.\nPiuttosto che somigliare a un Mostro, sembrano più un gelato che si scioglie sotto il sole cocente, destinato a trasformarsi presto in una fanghiglia appiccicosa e a svanire nell'aria."
  },
  Event_7139_Name = {
    Text = "Pustola Bizzarra"
  },
  Event_7140_ChoiceDesc1 = {
    Text = "[Lower Your Hands] Sviluppa il Sintomo [(Skill.Arg1)] e scegli una ricompensa"
  },
  Event_7140_ChoiceDesc2 = {
    Text = "[Catch a Crow] Sviluppa il Sintomo [(Skill.Arg1)] e scegli una ricompensa"
  },
  Event_7140_ChoiceDesc3 = {
    Text = "[Close Your Eyes] Ricevi 50 Sigilli Neri"
  },
  Event_7140_Desc = {
    Text = "Stridii, stridii senza fine—\nIl Cantore Corvo è avvolto in lucide piume nere, il becco affilato che brilla di un freddo bagliore, ogni grido lugubre trafigge i tuoi timpani.\nScopri le orecchie!\nI corvi della notte si beano dei loro lamenti, bramosi di abbeverarsi ai tremiti indomiti del tuo corpo rannicchiato.\n"
  },
  Event_7140_Name = {
    Text = "Canto dei Corvi"
  },
  Event_7141_ChoiceDesc1 = {
    Text = "[Leave] Nulla trovato"
  },
  Event_7141_Desc = {
    Text = "Non è la persona che stai cercando"
  },
  Event_7141_Name = {
    Text = "Temporaneo 2_6"
  },
  Event_7142_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7142_Desc = {
    Text = "Hai scelto di proseguire.\nRispetto ai danni mentali e fisici inflitti da quelle orrende opere in Arte della Cera, questo piccolo inconveniente non è nulla.\nHai missioni più grandi da compiere."
  },
  Event_7142_Name = {Text = "Passi"},
  Event_7143_ChoiceDesc1 = {
    Text = "[Point Out the Issue] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7143_Desc = {
    Text = "\"Ma che ti prende! Ti piace proprio frugare nelle ferite degli altri, vero?\"\n\"Sì! Sono invecchiata di venticinque anni senza motivo! Adesso devi chiamarmi Sorella Murphy!\""
  },
  Event_7143_Name = {
    Text = "Vita Imprigionata"
  },
  Event_7144_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 1 di 3 Reliquie d'argento, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_7144_Desc = {
    Text = "Il volto della ragazza è sereno come il chiaro di luna di questa notte. Non ti risponde, ma solleva in alto la bussola che tiene in mano — sta tremando, come se sollevare quella piccola bussola avesse prosciugato tutte le sue forze."
  },
  Event_7144_Name = {
    Text = "Fanciulla in Bianco"
  },
  Event_7145_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7145_Desc = {
    Text = "\"Delizioso! Delizioso!\" Il corvo gracchiò, e il fetore della decomposizione si propagò fino al tuo naso mentre dispiegava le ali."
  },
  Event_7145_Name = {
    Text = "Corvo Maledetto"
  },
  Event_7146_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7146_Desc = {
    Text = "A mio parere, il rumore è il modello di una nuova era.\nAvanza implacabile attraverso il mondo con ritmi irregolari e melodie che conducono alla follia.\nNessuna pietà, nessuna esitazione, nessun compromesso.\nDetestando l'ordine, scartando i temi, il rumore non cerca mai di compiacere —\nE questo include il nostro Scultore di cera."
  },
  Event_7146_Name = {
    Text = "Cattivo Gusto"
  },
  Event_7147_ChoiceDesc1 = {Text = "[Guide]"},
  Event_7147_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7147_Desc = {
    Text = "Qualcuno ti tira delicatamente la manica.\nÈ il ragazzo che hai visto prima. È accovacciato nell'angolo e ti guarda con un'espressione triste.\n\"I-io voglio partecipare allo spettacolo dell'accademia.\nMa non riesco a trovare la strada per il palco.\""
  },
  Event_7147_Name = {
    Text = "Fine Ultima II"
  },
  Event_7148_ChoiceDesc1 = {
    Text = "[Keep Searching] Aumenta gli HP massimi di Arg1, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_7148_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7148_Desc = {
    Text = "La punta del tuo naso coglie un profumo familiare, casalingo e appagante. Proprio mentre cerchi di annusare ancora l'aroma della mensa, svanisce completamente."
  },
  Event_7148_Name = {
    Text = "Contatto Anomalo"
  },
  Event_7149_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7149_Desc = {
    Text = [[
Sono colori caldi.
Colori appassionati, gentili e amorevoli.
Hanno donato alla ragazza un abbraccio nostalgico, poi sono svaniti come il vento.]]
  },
  Event_7149_Name = {
    Text = "Sfumatura di Nostalgia"
  },
  Event_7150_ChoiceDesc1 = {
    Text = "[Who are you, really?]"
  },
  Event_7150_ChoiceDesc2 = {
    Text = "[How to Change Your Mindset?]"
  },
  Event_7150_Desc = {
    Text = "Un uomo dai capelli lunghi blocca nuovamente il tuo cammino. Forte dell'esperienza precedente, l'Espressione di Ramona è ostile.\n\"Calmati, amica mia,\" l'uomo parla lentamente. La sua voce è magnetica e seducente, come se il suono fluisse attraverso una via aerea stretta, mescolato a un fruscio sibilante.\n\"Vi osservo da qualche tempo; solo cambiando prospettiva potrete avvicinarvi al vostro obiettivo.\""
  },
  Event_7150_Name = {
    Text = "Compagno di viaggio insolito III"
  },
  Event_7151_ChoiceDesc1 = {
    Text = "[I Am Searching] Aumenta gli HP massimi di Arg1"
  },
  Event_7151_ChoiceDesc2 = {
    Text = "[Sto Schivando] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7151_Desc = {
    Text = "\"Vedo qualcuno che cerca, che insegue l'irraggiungibile, quella cosa relativa e dolorosa, ciò che chiamano verità.\nVedo qualcuno che fugge, che elude l'inevitabile, quella cosa crudele e nascosta, ciò che chiamano verità.\nTu quale sei?\""
  },
  Event_7151_Name = {Text = "Il Cercato"},
  Event_7152_ChoiceDesc1 = {
    Text = "[Examine Closely] Potenzia una Reliquia d'argento nella Reliquia d'oro [(RelicConfig.Arg1)]"
  },
  Event_7152_ChoiceDesc2 = {
    Text = "[Attempt to Listen] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\" e \"(Skill.Arg3)\"."
  },
  Event_7152_ChoiceDesc3 = {
    Text = "[Store Carefully] Ricevi 25 Sigilli Neri"
  },
  Event_7152_Desc = {
    Text = "La nebbia davanti a te era illuminata da un minuscolo oggetto, simile a una scheggia di vetro o cristallo, con innumerevoli colori, vividi e tenui al tempo stesso, che vorticavano al suo interno."
  },
  Event_7152_Name = {
    Text = "I Nostri Ricordi"
  },
  Event_7153_ChoiceDesc1 = {
    Text = "[Accept Challenge] Vinci per ottenere una Reliquia d'argento, perdi per sviluppare un Sintomo. L'esito non influenza le indagini successive."
  },
  Event_7153_ChoiceDesc2 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7153_Desc = {
    Text = "Chi è la persona nel riflesso?\nRespira con te, condivide il tuo battito cardiaco e nutre la stessa inquietante idea.\nÈ uno scherzo del Dominio, o un'Ombra che attraversa le dimensioni?\nQuesta sembra essere un invito a una sfida illusoria."
  },
  Event_7153_Name = {
    Text = "Risonanza dell'Anima"
  },
  Event_7154_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7154_Desc = {
    Text = [[
La visione trascende la storia e il tempo. Potrebbe essere non lineare, e osservarti dal caos precedente alla nascita del pianeta.
O forse, ti attende in un giorno lontano nel futuro.]]
  },
  Event_7154_Name = {Text = "Sbircia"},
  Event_7155_ChoiceDesc1 = {
    Text = "[Claim] Ricevi 50 Sigilli Neri"
  },
  Event_7155_Desc = {
    Text = "L'area è deserta, un liquido scuro scorre sul terreno, senza riflettere nulla.\nÈ un'illusione? Senti qualcosa scivolarti tra le dita."
  },
  Event_7155_Name = {
    Text = "Sotto lo Specchio"
  },
  Event_7156_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7156_Desc = {
    Text = "\"Sei una persona così generosa. Ti auguro tutti i tuoi desideri oggi, domani e dopodomani.\"\n\"A proposito, questa è un'offerta irripetibile...\"\nLa fata si leccò le labbra soddisfatta e a malincuore ti disse addio."
  },
  Event_7156_Name = {
    Text = "Benedizione della Fata"
  },
  Event_7157_ChoiceDesc1 = {
    Text = "[Give Me My Wallet Back!] Incidi 1 Orazione tra 3"
  },
  Event_7157_ChoiceDesc2 = {
    Text = "[Esitare] 1 Carta di comando casuale ottiene Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7157_Desc = {
    Text = "\n\"Forza, vieni a riprendere il tuo portafoglio!\" Un bambino in lontananza agitava la mano.\nCorresti avanti, e mentre allungavi la mano, un rumore improvviso, forte e caotico, risuonò nella tua mente.\n\"Da dove è sbucato questo moccioso sporco?\"\n\"È un topolino di strada! Come osa toccare l'abito della Duchessa!\"\n\"Portatelo via di qui!\"\n\"Hai qualche moneta? Senza monete, non pensare di poter prendere nemmeno un pezzo di pane nero!\""
  },
  Event_7157_Name = {
    Text = "Libro del Nulla"
  },
  Event_7158_ChoiceDesc1 = {
    Text = "[Chase the Song] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7158_ChoiceDesc2 = {
    Text = "[Sing Along] Sviluppa il Sintomo [(Skill.Arg1)] e cambia l'Orazione da incidere.(Utilizzi: 2/2)"
  },
  Event_7158_Desc = {
    Text = "Il canto lontano si frantumò in Polvere di Stelle:\n\"Maledico la lurida pozza nel vicolo notturno, fiori marcescenti si aggrappano al muro fatiscente, catene trascinano la mente nel fango. Prima che la nebbia cancelli la mia esistenza, il crepuscolo sprofonderà nella più profonda @2.\""
  },
  Event_7158_Name = {
    Text = "Maledizione Pallida"
  },
  Event_7159_ChoiceDesc1 = {
    Text = "[Lasciare un'Offerta] Scegli 1 tra 3 Carte di comando e ottieni Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7159_ChoiceDesc2 = {
    Text = "[Portarlo via] Scegli 1 tra 3 Carte di comando e ottieni Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7159_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7159_Desc = {
    Text = "Mentre ti avvicini, anime caotiche emergono improvvisamente dalla melma.\nArti neri ti avviluppano strettamente, piangendo e supplicando—\nFai un'offerta o portale via."
  },
  Event_7159_Name = {
    Text = "Spirito del Caos"
  },
  Event_7160_ChoiceDesc1 = {
    Text = "[Leave an Offering] Potenzia la qualità dell'Orazione di una carta casuale."
  },
  Event_7160_ChoiceDesc2 = {
    Text = "[Portarlo via] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7160_Desc = {
    Text = "Mentre ti avvicini, anime caotiche emergono improvvisamente dalla melma.\nArti neri ti avviluppano strettamente, piangendo e supplicando—\nFai un'offerta o portale via."
  },
  Event_7160_Name = {
    Text = "Spirito del Caos"
  },
  Event_7161_ChoiceDesc1 = {
    Text = "[Agitare la mano per scacciare] 1 Carta di comando casuale ottiene l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7161_ChoiceDesc2 = {
    Text = "[Let It Stay] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7161_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7161_Desc = {
    Text = [[
Una farfalla con melma nera sulle ali ondeggia nel volo, lasciando scie di fanghiglia scura che si solidificano e si sfaldano nel vento.
Si stanca e si posa sulla punta del tuo naso.]]
  },
  Event_7161_Name = {
    Text = "Lepidotteri d'Ossidiana"
  },
  Event_7162_ChoiceDesc1 = {
    Text = "[Agitare la mano per scacciare] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7162_ChoiceDesc2 = {
    Text = "[Let It Stay] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7162_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7162_Desc = {
    Text = [[
Una farfalla con melma nera sulle ali ondeggia nel volo, lasciando scie di fanghiglia scura che si solidificano e si sfaldano nel vento.
Si stanca e si posa sulla punta del tuo naso.]]
  },
  Event_7162_Name = {
    Text = "Lepidotteri d'Ossidiana"
  },
  Event_7163_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7163_Desc = {
    Text = "\"Vedo coraggio, forza di volontà e uno spirito che brilla come le stelle. Avanza verso quel ricordo sigillato con la cera, e il tuo desiderio sarà esaudito.\""
  },
  Event_7163_Name = {Text = "Il Cercato"},
  Event_7164_ChoiceDesc1 = {
    Text = "[Lasciare che rimanga] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7164_ChoiceDesc2 = {
    Text = "[Wave Away] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7164_ChoiceDesc3 = {
    Text = "[Welcome the Butterflies] Ricevi 25 Sigilli Neri"
  },
  Event_7164_Desc = {
    Text = [[
Vaghi per il gelido Sanatorio, dove una Farfalla nera che non dovrebbe esistere in questa stagione ti svolazza accanto.
Le sue ali, rivestite di melma nera, oscillano mentre vola, lasciando cadere strati di fanghiglia nera che si solidificano e si staccano nel vento.
Estenuta, si posa sulla punta del tuo dito.]]
  },
  Event_7164_Name = {
    Text = "Ciò che Non Dovrebbe Esistere"
  },
  Event_7165_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 1 di 3 Reliquie d'argento, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_7165_Desc = {
    Text = [[
Cominci a sentirti stanco.
La tua coscienza ti trasporta oltre stagni e catene montuose,
Oltre il sole, oltre gli anni luce,
Verso l'unica... culla cosmica.]]
  },
  Event_7165_Name = {
    Text = "Fine Ultima IV"
  },
  Event_7166_ChoiceDesc1 = {
    Text = "[Look More]"
  },
  Event_7166_Desc = {
    Text = "Un'ombra immensa ti inghiotte completamente, e saliva maleodorante ti inzuppa come un pulcino bagnato.\n\"Topolino, vieni qui. Solo un momento...\"\n\"Giuro, non ho nessuna intenzione di mangiarti...\"\n\"Non guarderò nemmeno la tua pancina grassottella e succulenta!\""
  },
  Event_7166_Name = {
    Text = "Materiale 12"
  },
  Event_7167_ChoiceDesc1 = {
    Text = "[Look More]"
  },
  Event_7167_Desc = {
    Text = "Il rinsecchito filosofo Scultura di Cera fuma, avvolto in una foschia bianca.\n\"L'altra sponda esiste ma è inconoscibile, perciò resta ignota.\"\n\"Immagina questo mondo come un gioco...\nCiò che cerchi potrebbe trovarsi dall'altro lato della mappa.\""
  },
  Event_7167_Name = {
    Text = "Materiale 45"
  },
  Event_7168_ChoiceDesc1 = {
    Text = "[Look More]"
  },
  Event_7168_Desc = {
    Text = "\"Mi dispiace, non volevo offendere...\"\n\"Non mi piacciono i topi. Il problema dei topi è che non hanno mai paura degli esseri umani...\"\nUn vecchio trasandato giaceva nell'angolo, i suoi occhi malinconici fissi su di te.\n\"Certo, sei molto ambizioso.\nQuesto è un bene, ma non basta per aiutarti a sfuggire al disastro...\""
  },
  Event_7168_Name = {
    Text = "Materiale 4"
  },
  Event_7169_ChoiceDesc1 = {
    Text = "[Mostrare la Maledizione] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7169_ChoiceDesc2 = {
    Text = "[Reject the Crow] Incidi 1 Orazione su 3"
  },
  Event_7169_ChoiceDesc3 = {Text = "[Ignore]"},
  Event_7169_Desc = {
    Text = "Un corvo policefalo, nero come la pece e dall'aspetto malsano, vola fuori dalla veste nera di un Devoto del Portatore di Luce e si posa sulla tua spalla.\n\"Vedi la mia testa? Finché assaggio la maledizione, mi crescerà una nuova testa. Fammi vedere, la tua maledizione!\""
  },
  Event_7169_Name = {
    Text = "Corvo Maledetto"
  },
  Event_7170_ChoiceDesc1 = {
    Text = "[Answer the Call] Distruggi una Carta di comando e recupera Arg1 PV"
  },
  Event_7170_ChoiceDesc2 = {
    Text = "[I'm Not Fleeing] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7170_Desc = {
    Text = "Corri a perdifiato per il vicolo. L'adrenalina esplode, l'acido lattico si accumula, il glucosio si esaurisce... Il caos invade la tua mente, spingendoti a fuggire in mezzo alla foschia psichedelica.\nSì, fuggire. Se non stai scappando, perché caos e illusione, fallimento e vuoto ti attendono?"
  },
  Event_7170_Name = {Text = "Corri"},
  Event_7171_ChoiceDesc1 = {
    Text = "[Trace Sound Source]"
  },
  Event_7171_ChoiceDesc2 = {
    Text = "[Summon Lily and Koum]"
  },
  Event_7171_Desc = {
    Text = "Da Lontano, nel Passaggio dimensionale, udiamo suoni gutturali e grevi intrisi di paura, attesa e ansia, come se ti stessero chiamando. Poi, i Deliri soffocati di una ragazza svaniscono gradualmente."
  },
  Event_7171_Name = {Text = "Voce Guida"},
  Event_7172_ChoiceDesc1 = {Text = "[Take It]"},
  Event_7172_Desc = {
    Text = "Una sostanza argentea simile al mercurio, raffinata dalla D-melma, contenente un forte potere mentale, utilizzata per collegare più Risvegliatori nei rituali Una sostanza argentea simile al mercurio, raffinata dalla D-melma, contenente un forte potere mentale, utilizzata per collegare più Risvegliatori nei rituali."
  },
  Event_7172_Name = {Text = "Argento"},
  Event_7173_ChoiceDesc1 = {
    Text = "[Ask to Clear the Path]"
  },
  Event_7173_ChoiceDesc2 = {
    Text = "[Ask Who He Is]"
  },
  Event_7173_Desc = {
    Text = "Sali su un vagone scarsamente illuminato, e una sensazione inquietante cresce dentro di te.\nIl vagone è vuoto; i passeggeri sono fuggiti da tempo, lasciandosi dietro Spoglie di Mostro sparse che si stanno lentamente dissipando.\nAl centro del vagone si erge un uomo.\n\"Credo nel destino, ed è il destino che ci ha condotti sulla stessa metropolitana.\""
  },
  Event_7173_Name = {
    Text = "Compagno di viaggio insolito IV"
  },
  Event_7174_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7174_Desc = {
    Text = "\"I tuoi occhi sono bellissimi, come stelle.\"\nCharlotte ridacchiò, i suoi capelli selvaggiamente vaganti si posarono dolcemente.\n\"Devi essere popolare a scuola. Mi piaci anche tu.\"\nPrima di andarsene, ti baciò sulla fronte.\nSentisti il tuo corpo scaldarsi e qualcosa sembrò cambiare."
  },
  Event_7174_Name = {
    Text = "Ombra dell'Investigatore"
  },
  Event_7175_ChoiceDesc1 = {
    Text = "[Read] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7175_ChoiceDesc2 = {
    Text = "[Store in Suitcase] Ottieni la Reliquia \"(RelicConfig.Arg2)\", ma sviluppa il Sintomo \"(Skill.Arg1)\"."
  },
  Event_7175_Desc = {
    Text = [[
Una pagina ingiallita cadde dalla veste del Devoto del Portatore di Luce.
Era ricoperta di testi strani, alcuni simili a geroglifici, altri curiosamente inclinati, altri ancora sovrapposti. Solo poche parole erano a malapena leggibili.]]
  },
  Event_7175_Name = {
    Text = "Editto Cifrato: Parte I"
  },
  Event_7176_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7176_Desc = {
    Text = "Dici: \"Oh, Charlotte! Non è possibile!\"\nI capelli di Charlotte si attorcigliano selvaggiamente, ed è furiosa.\n\"Te lo dimostrerò! Guarda le mie abilità!\""
  },
  Event_7176_Name = {
    Text = "Ombra dell'Investigatore"
  },
  Event_7177_ChoiceDesc1 = {
    Text = "[Infect with \"(Skill.Arg1)\" and obtain the Silver Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7177_ChoiceDesc2 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7177_Desc = {
    Text = "Evento 302 (In sviluppo), Effetti non definitivi"
  },
  Event_7177_Name = {
    Text = "Evento 302 (In sviluppo)"
  },
  Event_7178_ChoiceDesc1 = {
    Text = "[Accept Request] Ottieni la Reliquia d'Argento \"(RelicConfig.Arg2)\", ma sviluppi \"(Skill.Arg1)\"."
  },
  Event_7178_ChoiceDesc2 = {
    Text = "[Refuse Request] Ricevi 25 Sigilli Neri"
  },
  Event_7178_Desc = {
    Text = "La mandibola scricchiola ritmicamente, con un suono che porta una certa cadenza regolare, e il tuo compagno conosce per caso un po' di crittografia.\nIl testo decifrato è il seguente:\n\"Salve, vi prego di chiamarmi Dott. @2. Un tempo ero un collezionista e un naturalista...\n(Questa parte contiene una prolissa presentazione di carriere e titoli.)\nIn breve, potreste aiutarmi a trovare la mia metà? Si tratta di un piccolo frammento di mandibola superiore.\nUna volta trovato, il mio tesoro privato vi aprirà le sue porte.\""
  },
  Event_7178_Name = {
    Text = "Scricchiolio"
  },
  Event_7179_ChoiceDesc1 = {
    Text = "[Invest 100 Florins] Ottieni la Reliquia d'Argento \"(RelicConfig.Arg2)\", ma sviluppi \"(Skill.Arg1)\"."
  },
  Event_7179_ChoiceDesc2 = {
    Text = "[Invest Five Pence] Ricevi 25 Sigilli Neri"
  },
  Event_7179_Desc = {
    Text = "La borsetta ricamata si contorce, spalancando verso di te una bocca nero pece.\nDa quando si è separata dalla sua ricca padrona, ha patito la fame per decenni, bramando di essere nutrita.\nDai una sbirciatina al suo interno; è vuota, colma soltanto di un'oscurità impenetrabile."
  },
  Event_7179_Name = {
    Text = "Borsa Golosa"
  },
  Event_7180_ChoiceDesc1 = {
    Text = "[Steadfast Determination] Distruggi una Carta di comando e recupera Arg1 PV"
  },
  Event_7180_ChoiceDesc2 = {
    Text = "[Desire to Succeed] Ottieni la Reliquia Dorata \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_7180_Desc = {
    Text = "\"Due persone ostinate? L'Ospizio dei Poveri è già pericoloso—\" La voce di Doll giunge improvvisamente dal comunicatore, \"Qual è il vostro piano? Ricucirle la testa al corpo?\"\n\"Non è il momento per commenti sarcastici, Doll!\"\n\"Lo so, me ne rendo conto.\" Disse Doll, \"Calmati. Sai qual è la chiave del successo?\""
  },
  Event_7180_Name = {
    Text = "Regola di Rogues"
  },
  Event_7181_ChoiceDesc1 = {
    Text = "[Infect with \"(Skill.Arg1)\" and obtain the Silver Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7181_ChoiceDesc2 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7181_Desc = {
    Text = "Evento 304 (In Sviluppo), Effetto Non Definitivo"
  },
  Event_7181_Name = {
    Text = "Evento 304 (In Sviluppo)"
  },
  Event_7182_ChoiceDesc1 = {
    Text = "[Infect with \"(Skill.Arg1)\" and obtain the Silver Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7182_ChoiceDesc2 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7182_Desc = {
    Text = "Evento 305 (In Sviluppo), Effetti Non Definitivi"
  },
  Event_7182_Name = {
    Text = "Evento 305 (In Sviluppo)"
  },
  Event_7183_ChoiceDesc1 = {
    Text = "[Hang Up] Incidi 1 Orazione Avanzata su 3"
  },
  Event_7183_ChoiceDesc2 = {
    Text = "[Answer the Phone] Ottieni la Reliquia d'Oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7183_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_7183_Desc = {
    Text = "Mentre passi accanto all'Area di Riposo de Il Direttore d'Orchestra, un telefono squilla acutamente da un angolo nascosto."
  },
  Event_7183_Name = {
    Text = "Chiamata dal Treno"
  },
  Event_7184_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7184_Desc = {
    Text = "Fioco, eppure innegabilmente reale.\nUn Nucleo d'Argento così debole non può evocare un Risvegliato, ma è perfetto per il potenziamento — questa è l'essenza della Tecnologia di Chip d'Argento."
  },
  Event_7184_Name = {
    Text = "Prova dell'Essere"
  },
  Event_7185_ChoiceDesc1 = {
    Text = "[Lady's Portrait] Potenzia la qualità dell'Orazione di una carta casuale."
  },
  Event_7185_ChoiceDesc2 = {
    Text = "[Foto di famiglia in Scultura di Cera] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7185_Desc = {
    Text = "Il Museo delle Cere ospita anche molti dipinti.\nRitratti, paesaggi, nature morte, realisti, astratti...\nAdornano le pareti altrimenti spoglie, rendendole meno monotone.\nUno di essi cattura il tuo sguardo. Si tratta di —"
  },
  Event_7185_Name = {
    Text = "Galleria dei Ritratti"
  },
  Event_7186_ChoiceDesc1 = {
    Text = "[Keep Reading] Incidi l'Orazione [(EnchantConfig.Arg1)] su una Carta di comando casuale."
  },
  Event_7186_ChoiceDesc2 = {
    Text = "[Leave] Aumenta gli HP massimi di Arg1, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_7186_Desc = {
    Text = "Una bilancia per pesare.\nDietro di essa, innumerevoli organi sono immersi in formalina rossa.\nSono impilati ordinatamente su scaffali.\nPrendi distrattamente un taccuino lì vicino e lo sfogli:\n\"Cuore: 8 oz, Cervello: 50 oz...\""
  },
  Event_7186_Name = {
    Text = "Registro degli Organi"
  },
  Event_7187_ChoiceDesc1 = {
    Text = "[Open Gift] Ricevi un [Dono di Ritorno dell'Innocente]"
  },
  Event_7187_Desc = {
    Text = "L'Ombra di un bambino tremola davanti a te; non riesci a discernere se sia un bambino reale o la Proiezione di qualche Spirito nel Dominio. Ma — guardi la scatola lasciata a terra, sulla quale c'è scritto \"Regalo\" in una calligrafia infantile."
  },
  Event_7187_Name = {
    Text = "Un Dono di Gentilezza"
  },
  Event_7188_ChoiceDesc1 = {
    Text = "[Call the Crow] Ricevi 40 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_7188_ChoiceDesc2 = {
    Text = "[Stay Far Away] Ricevi 25 Sigilli Neri e vattene."
  },
  Event_7188_Desc = {
    Text = "I gabbiani bianchi riposano sull'albero ricoperto di brina.\nI richiami risonanti respingono l'oscurità e gli uccelli scuri che non appartengono al mare aperto."
  },
  Event_7188_Name = {
    Text = "Corvo Solitario"
  },
  Event_7189_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7189_Desc = {
    Text = "Hai riconosciuto che il canto era un adattamento di una canzone d'amore.\nAlla fine di quella canzone d'amore, il poeta disse:\n\"Finché la voce dell'Umanità non ci risveglierà, annegheremo.\"\nNon ora, pensasti.\nStai ancora aspettando che l'Umanità ti risvegli."
  },
  Event_7189_Name = {
    Text = "Coro dei Corvi"
  },
  Event_7190_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7190_Desc = {
    Text = "Una bobina di pellicola impolverata. Tuttavia, non c'è un proiettore in questa stanza, e non è il momento di godersi con calma il maniero, il film e il tè del pomeriggio.\nForse passerà molto tempo prima che tu abbia l'occasione di scoprire cosa contiene la bobina."
  },
  Event_7190_Name = {
    Text = "Fantasmi Mnemonici"
  },
  Event_7191_ChoiceDesc1 = {
    Text = "[Leave] Incidi 1 di 3 Orazioni Av., ma sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_7191_Desc = {
    Text = "Segui il ragazzo, né troppo vicino né troppo lontano.\nToc. Toc. Toc... Il ragazzo si ferma all'angolo della strada.\nNoti una luce rossa tremolante dietro di lui, e il tuo istinto ti dice che il museo delle cere si trova più avanti.\nIl ragazzo si volta. Non ha occhi, solo orbite scure.\nTi sorride."
  },
  Event_7191_Name = {
    Text = "Fine Ultima I"
  },
  Event_7192_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri, ma sviluppi il Sintomo [(Skill.Arg1)]"
  },
  Event_7192_Desc = {
    Text = "\nGli hai dato una pacca sulla spalla.\nIl ragazzo si è voltato. Non aveva occhi, solo orbite scure.\n\"Buonasera. Sto cercando la strada per il museo delle cere.\"\nIl ragazzo indicò avanti. Hai visto il bagliore rosso oscillare precariamente dietro di lui.\nIl tuo istinto ti diceva che il museo delle cere era proprio lì.\nQuando sei tornato in te, il ragazzo se n'era già andato, lasciando solo l'ombra proiettata dal lampione."
  },
  Event_7192_Name = {
    Text = "Fine Ultima I"
  },
  Event_7193_ChoiceDesc1 = {
    Text = "[Pin Down the Crow] Ricevi 35 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_7193_ChoiceDesc2 = {
    Text = "[Ignore It] Parti"
  },
  Event_7193_Desc = {
    Text = "Il corvo solitario, con voce rauca, si strappa le piume nere una a una.\nTrema di dolore, emettendo grida acute, eppure non riesce a fermare il suo ritmo sempre più frenetico.\n\"Cra—Cra—\"\nLacrime azzurre miste a melma nera gli colano dagli occhi, e tu sei l'unico testimone."
  },
  Event_7193_Name = {
    Text = "Lacrima di Magma"
  },
  Event_7194_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7194_Desc = {
    Text = "Una conoscenza inestimabile inonda la tua mente, poi si tramuta in nebbia... Quando riprendi i sensi, lo strano libro dalla copertina gialla è svanito..."
  },
  Event_7194_Name = {
    Text = "Tomo Giallo"
  },
  Event_7195_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7195_Desc = {
    Text = [[
Hai sconfitto facilmente le Sculture di Cera. Si accasciano davanti a te.
Sembrano esserci alcune righe di testo incise alla base.
"A.F. @2, Novembre
Realizzato da Rogers al @2 College"
Ricordi che Rogers studiava Scultura in una scuola d'arte. Queste goffe Sculture di Cera devono essere i suoi lavori da studente.]]
  },
  Event_7195_Name = {Text = "Bozzetto"},
  Event_7196_ChoiceDesc1 = {Text = "[Why?]"},
  Event_7196_ChoiceDesc2 = {
    Text = "[Descend into the Deep Sea]"
  },
  Event_7196_Desc = {
    Text = "\n\"Impostora! Ridammi mio figlio!\"\n\"Non sei tu la Fanciulla Benedetta dell'Arca? Non è forse tuo dovere proteggere l'Arca? Perché è tornata una sola nave? Dimmi, dimmi!\"\n\"Annegatela! Deve Sopportare la stessa sofferenza che mio padre ha patito prima di morire!\"\n\"Annegatela, annegatela!\"\n\"Annegate questa impostora! Legatela a una pietra!\"\nMentre l'acqua di mare le invadeva la bocca e il naso, espellendo l'aria da ogni angolo dei suoi polmoni, indossava ancora quel sontuoso e immacolato abito bianco.\nQuasi il primo pensiero sorto dopo essere diventata una Fanciulla Benedetta emerse dai recessi più oscuri della sua mente, giungendo in ritardo.\n\"Già, perché quelle navi sono affondate?\""
  },
  Event_7196_Name = {
    Text = "Mare Sommerso"
  },
  Event_7197_ChoiceDesc1 = {
    Text = "[Pin Down the Crow] Ricevi 30 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_7197_ChoiceDesc2 = {
    Text = "[Ignore It] Parti"
  },
  Event_7197_Desc = {
    Text = "Il corvo solitario, con voce rauca, si strappa le piume nere una a una.\nTrema di dolore, emettendo grida acute, eppure non riesce a fermare il suo ritmo sempre più frenetico.\n\"Cra—Cra—\"\nLacrime azzurre miste a melma nera gli colano dagli occhi, e tu sei l'unico testimone."
  },
  Event_7197_Name = {
    Text = "Lacrima di Magma"
  },
  Event_7198_ChoiceDesc1 = {
    Text = "[Keep Searching] Aumenta gli HP massimi di Arg1, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_7198_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7198_Desc = {
    Text = "È come se un paio di mani forti e salde si fossero posate sulle tue spalle, ma quando ti volti a guardare, il tocco un tempo tangibile diventa sfuggente."
  },
  Event_7198_Name = {
    Text = "Contatto Anomalo"
  },
  Event_7199_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7199_Desc = {
    Text = "Il ponte di Ryelway, sangue e nervi di Londinium, collega il cuore e le membra della città. L'Ospedale di Lai attende silenzioso sulla punta delle membra, pronto a ricevere sangue e segnali."
  },
  Event_7199_Name = {
    Text = "Miraggio della Ferrovia"
  },
  Event_7200_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7200_Desc = {
    Text = "Calpesti la valigia a terra finché non smette di tremare, poi la raccogli di nuovo.\nDopo aver spolverato la polvere, prosegui sotto lo sguardo perplesso di Murphy."
  },
  Event_7200_Name = {
    Text = "Missiva Inattesa"
  },
  Event_7201_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7201_Desc = {
    Text = "Il pericolo si cela dietro una porta di legno; non è un luogo in cui indugiare. Riponilo nella tua valigia."
  },
  Event_7201_Name = {
    Text = "Tomo Giallo"
  },
  Event_7202_ChoiceDesc1 = {
    Text = "[Chase the Crows] Ricevi Arg1 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_7202_ChoiceDesc2 = {
    Text = "[Ignore] Lascia"
  },
  Event_7202_Desc = {
    Text = "Essa, o meglio esse, fluttuano nella camera da letto, schiantandosi contro il paralume con un fragore."
  },
  Event_7202_Name = {
    Text = "Corvo della Lanterna"
  },
  Event_7203_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7203_Desc = {
    Text = "Questa è la Dimensione dello Spirito, il mondo della Gnosi.\nNon possono fare altro che tormentare la tua mente."
  },
  Event_7203_Name = {
    Text = "Tempesta di Gnosi"
  },
  Event_7204_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7204_Desc = {
    Text = [[
Cranio: Hank Tillinghast A.F.186-A.F.203 Isola Creola
Spina dorsale: Andy Crawford A.F.177-A.F.203 Narragansett
..Meglio non pensarci troppo.]]
  },
  Event_7204_Name = {Text = "Targhetta"},
  Event_7205_ChoiceDesc1 = {
    Text = "[Check Fragment] Distruggi 1 di 3 Carte di comando e ricevi 75 Sigilli Neri."
  },
  Event_7205_ChoiceDesc2 = {
    Text = "[Ask Doll] Duplica 1 di 3 Carte di comando e ricevi 25 Sigilli Neri."
  },
  Event_7205_ChoiceDesc3 = {
    Text = "[Disregard] Ricevi 50 Sigilli Neri"
  },
  Event_7205_Desc = {
    Text = "Il frammento di metallo che Doll ti ha dato freme inquieto nel tuo petto, come una farfalla disturbata."
  },
  Event_7205_Name = {
    Text = "Spilla Inquieta"
  },
  Event_7206_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7206_Desc = {
    Text = "\"Attende in silenzio al traguardo, non importa dove tu fissi il punto d'arrivo — guarda quella giovane guardiana; la sua elusione conduce infine alla Follia.\""
  },
  Event_7206_Name = {Text = "Il Cercato"},
  Event_7207_ChoiceDesc1 = {
    Text = "[Leave] Nulla trovato"
  },
  Event_7207_Desc = {
    Text = "In Sviluppo, Evento Speciale"
  },
  Event_7207_Name = {
    Text = "2_16 Temporaneo"
  },
  Event_7208_ChoiceDesc1 = {
    Text = "[Comfort It] Aumenta gli HP massimi di Arg1"
  },
  Event_7208_ChoiceDesc2 = {
    Text = "[Trascurarlo] 2 Carte di comando casuali ottengono l'Orazione: \"(EnchantConfig.Arg1)\", infetta 2 \"(Skill.Arg2)\""
  },
  Event_7208_Desc = {
    Text = "Il Legame riscalda il cuore che ancora Conserva la sua natura umana.\nIl cuore imita il ritmo del respiro dall'altra parte, come se così facendo potesse salvarsi dall'abbandono, ottenendo il diritto a un'eterna compagnia con il Legame."
  },
  Event_7208_Name = {
    Text = "Atrio Sinistro"
  },
  Event_7209_ChoiceDesc1 = {
    Text = "Orazione Avanzata casuale"
  },
  Event_7210_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7210_Desc = {
    Text = "La vostra freddezza lascia il proprietario della voce colmo di rimpianto, mentre l'acqua increspa pigramente e poi torna alla quiete."
  },
  Event_7210_Name = {
    Text = "Voci dall'Oltre"
  },
  Event_7211_ChoiceDesc1 = {
    Text = "[Select 1 Card to gain the Orison: \"(EnchantConfig.Arg1)\"] Orazione di Prova"
  },
  Event_7211_ChoiceDesc2 = {
    Text = "[Select 1 Card to gain the Orison: \"(EnchantConfig.Arg1)\"] Pacchetto Drop di Prova"
  },
  Event_7211_Desc = {
    Text = "Verifica l'Orazione specificata"
  },
  Event_7211_Name = {
    Text = "Test Orazione Designata 1"
  },
  Event_7212_ChoiceDesc1 = {
    Text = "[Leave] Risveglio di un Risvegliatore"
  },
  Event_7212_Desc = {
    Text = "Hai accarezzato dolcemente la testa del ragazzo, guidandolo a recitare insieme a te.\n\"Una canzone per la mamma —\"\nLe voci, come falene nella notte, si sono librate fianco a fianco dal palcoscenico vuoto,\nposandosi piano nella platea immersa nel buio."
  },
  Event_7212_Name = {
    Text = "Fine Ultima III"
  },
  Event_7213_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 1 di 3 Reliquie dorate, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_7213_Desc = {
    Text = "Sei rimasto calmo e composto. Una dama di nobiltà si è precipitata improvvisamente sul palcoscenico.\nHa forzato freneticamente la bocca del ragazzo e vi ha conficcato con violenza un bastoncino.\n\"Parla, parlami.\"\nSangue nero sgorgava dalla bocca del ragazzo. Lui continuava a borbottare.\n\"Una canzone per la mamma...\""
  },
  Event_7213_Name = {
    Text = "Fine Ultima III"
  },
  Event_7215_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7215_Desc = {
    Text = "Quella non è una finestra, è uno specchio. Il volto teso di Ramona vi si riflette.\nPerché non ci sono finestre in questa stanza, solo un enorme specchio appeso alla parete?"
  },
  Event_7215_Name = {
    Text = "Riflesso nella Finestra"
  },
  Event_7216_ChoiceDesc1 = {
    Text = "[Hold Silver Key] Risveglia un Risvegliatore casuale, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_7216_ChoiceDesc2 = {
    Text = "[Close Your Eyes] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7216_Desc = {
    Text = "\nFosti dilaniato da un'ondata di assurdità, le membra contorte mentre strisciavi al suolo, apparentemente manipolato da qualcosa dall'aldilà della dimensione @2.\n\"No... no...\"\nLa tua sanità si sgretolò pezzo dopo pezzo, risate deliranti e urla si intrecciavano come una ragnatela gigantesca che imprigionava la tua coscienza, lasciando solo gemiti indistinti a colare dalle tue labbra."
  },
  Event_7216_Name = {
    Text = "Sguardo del Guardiano"
  },
  Event_7217_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7217_Desc = {
    Text = "I colori della galassia mutano, formando disegni indescrivibili ai tuoi piedi. Sono belli come rubini, eppure gonfi come meduse. Un bagliore rosso emana dalla valigia..."
  },
  Event_7217_Name = {
    Text = "Crocevia Stellare"
  },
  Event_7218_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Aumenta lo Stress di 10."
  },
  Event_7218_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7218_Desc = {
    Text = "Volti sfocati appaiono all'improvviso, circondandoti e gemendo disperatamente con corde vocali inesistenti."
  },
  Event_7218_Name = {Text = "Illusione"},
  Event_7221_ChoiceDesc1 = {
    Text = "[Catch] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_7221_ChoiceDesc2 = {
    Text = "[Look Down] Ricevi 75 Sigilli Neri, ma sviluppa il Sintomo [(Skill.Arg2)]"
  },
  Event_7221_Desc = {
    Text = "I corvi volteggiavano nel cielo, segmentato come blocchi da costruzione dai vicoli, i loro rauchi richiami inquietanti.\nAll'improvviso, lo stormo si agitò, come se un istinto morboso fosse stato distorto o risvegliato. Si attaccarono e inseguirono a vicenda con ferocia, e qualcosa cadde nel mezzo del caos."
  },
  Event_7221_Name = {
    Text = "Stormo di Corvi Frenetici"
  },
  Event_7222_ChoiceDesc1 = {
    Text = "[Follow the Instructions] Aumenta gli HP massimi di Arg1"
  },
  Event_7222_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7222_Desc = {
    Text = "Tenti di usare il potere di tracciamento della Chiave d'argento per localizzare la Giunzione più vicina, ma le informazioni che ricevi contengono sottili anomalie, come se fossero state alterate da un'interferenza."
  },
  Event_7222_Name = {
    Text = "Contatto Anomalo"
  },
  Event_7223_ChoiceDesc1 = {
    Text = "[Give It to Doll] Incidi l'Orazione [(EnchantConfig.Arg1)] su una Carta di comando casuale."
  },
  Event_7223_ChoiceDesc2 = {
    Text = "[Read the Nameplate] Aumenta i PV massimi di Arg1, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_7223_Desc = {
    Text = "Dall'esperimento sconfitto dell'Associazione degli Scultori, è caduta una targhetta con cornice metallica. La Chiave d'argento la percepisce e si illumina debolmente."
  },
  Event_7223_Name = {Text = "Targhetta"},
  Event_7224_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7224_Desc = {
    Text = [[
Il Portatore della lama emette un lungo ululato, un suono capace di fendere montagne e mari.
Il suono svanisce all'istante, e anche gli altri due Navigatori scompaiono... Si scopre che era soltanto un'Illusione riflessa dal Dominio.]]
  },
  Event_7224_Name = {
    Text = "Caccia implacabile"
  },
  Event_7225_ChoiceDesc1 = {
    Text = "[Repair Wax Sculpture] Scegli una carta e riduci il suo Costo di Arithmetica di 1"
  },
  Event_7225_Desc = {
    Text = "Reggendo una candela, attraversi la nebbia fino a lei.\nÈ una Scultura di Cera Incompiuta.\nIl suo volto delicato è diviso in due, una metà sorridente, l'altra metà @1.\nDiventa il suo dio.\nDonale la bellezza, donale le lacrime.\nScolpiscila o distruggila."
  },
  Event_7225_Name = {
    Text = "Scultura di Cera Incompiuta"
  },
  Event_7226_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7226_Desc = {
    Text = "\"Certo, ho assistito all'estinzione con i miei stessi occhi.\" Rispondesti.\nSì, non era che la morte violenta di un topolino, il marcire di un cuore, e un bouquet di iris immerso nel funerale della notte."
  },
  Event_7226_Name = {
    Text = "Pantheon Perduto"
  },
  Event_7227_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7227_Desc = {
    Text = [[
"il Reame Divino... la fine... argomenti illusori... Non so cosa possa considerarsi fine."
Le due figure ridacchiano sommessamente, avvolte da frammenti di luce bianca e scintillante.
"Allora ora, assisterai alla vera fine."]]
  },
  Event_7227_Name = {
    Text = "Pantheon Perduto"
  },
  Event_7228_ChoiceDesc1 = {
    Text = "[Combine Pages] Ottieni la Reliquia d'Oro \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_7228_ChoiceDesc2 = {
    Text = "[Read] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7228_ChoiceDesc3 = {
    Text = "[Discard It] Ricevi 50 Sigilli Neri"
  },
  Event_7228_Desc = {
    Text = [[
Una pagina ingiallita cadde dalla veste del Devoto del Portatore di Luce.
Coperta di testi bizzarri, alcuni simili a geroglifici, altri stranamente inclinati, altri sovrapposti. Solo poche parole erano a malapena decifrabili.
Intitolata "La Nascita del Divus @2"]]
  },
  Event_7228_Name = {
    Text = "Editto Cifrato: Parte II"
  },
  Event_7229_ChoiceDesc1 = {
    Text = "[Struggle] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7229_ChoiceDesc2 = {
    Text = "[Wallow] Acquisisci la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7229_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7229_Desc = {
    Text = "\"Ho così tanto dolore, così tanto...\"\n\"Perché proprio a me? Perché devo sopportare tutto questo?\"\n\"Padre misericordioso, cosa ho fatto di sbagliato?\"\nDolore, sofferenza, rabbia, frustrazione... annegando nell'empatia, le emozioni di questi \"pazienti\" gravano pesantemente su di te. Stringendoti il petto, fai fatica a respirare."
  },
  Event_7229_Name = {Text = "Indulgenza"},
  Event_7230_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7230_Desc = {
    Text = "Lo Sguardo trafigge la carne, marchiando la retina dell'apripista.\nNessuno può sfuggire, così come nessuno@2"
  },
  Event_7230_Name = {Text = "Sbircia"},
  Event_7231_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7231_Desc = {
    Text = [[
Concentra la mente, identifica le parole, e poi senti le frasi caotiche schiantarsi contro la nuca.
Sono parole che trascendono la comprensione umana.]]
  },
  Event_7231_Name = {
    Text = "Canto di Mare"
  },
  Event_7232_ChoiceDesc1 = {
    Text = "[Initiate Trial] Sviluppa [(Skill.Arg1)] ; ottieni una Reliquia d'oro in caso di vittoria, o 50 Sigilli Neri in caso di sconfitta."
  },
  Event_7232_ChoiceDesc2 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_7232_Desc = {
    Text = "Hai intravisto alcuni segreti dalla melma nera simile a uno specchio sotto i tuoi piedi.\nIl suo riflesso è nebuloso, avvolto in una foschia scura e impenetrabile. Sembra stranamente familiare, eppure non riesci a distinguere cosa sia."
  },
  Event_7232_Name = {
    Text = "Sotto lo Specchio"
  },
  Event_7233_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7233_Desc = {
    Text = "Ignori la misteriosa lettera anonima e la bruci distrattamente, riducendola in cenere."
  },
  Event_7233_Name = {
    Text = "Un'altra Lettera di Soccorso"
  },
  Event_7234_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7234_Desc = {
    Text = "Esamini la lettera stessa. Il sigillo è ricoperto di un liquido appiccicoso, apparentemente una miscela di sangue e melma nera, con alcuni fili di capelli rimasti attaccati."
  },
  Event_7234_Name = {
    Text = "Un'altra Lettera di Soccorso"
  },
  Event_7235_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7235_Desc = {
    Text = "Segui la direzione in cui la lettera è andata alla deriva. All'angolo del muro, scorgi qualcosa di lucente."
  },
  Event_7235_Name = {
    Text = "Un'altra Lettera di Soccorso"
  },
  Event_7236_ChoiceDesc1 = {
    Text = "[Keep Searching] Aumenta gli HP massimi di Arg1, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_7236_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7236_Desc = {
    Text = "Una debole luce apparve, luminosa e calda. Tuttavia, svanì all'improvviso non appena tentasti di seguirla."
  },
  Event_7236_Name = {
    Text = "Contatto Anomalo"
  },
  Event_7237_ChoiceDesc1 = {
    Text = "[Leave] Aumenta l'Aliemus di tutti i Risvegliati di Arg1"
  },
  Event_7237_Desc = {
    Text = "Chiudi forte gli occhi per la paura.\n\"Hai sollevato il coperchio...\nSegreti, hai scoperto segreti...\"\nLe onde sonore formano un oceano ruggente, e il pavimento trema violentemente in una risonanza terrificante.\nIncapace di resistere oltre, spalanchi gli occhi di colpo, solo per scoprire che intorno a te non c'è nulla."
  },
  Event_7237_Name = {
    Text = "Fine Ultima V"
  },
  Event_7238_ChoiceDesc1 = {
    Text = "[Keep Searching] Aumenta gli HP massimi di Arg1, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_7238_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7238_Desc = {
    Text = "La punta del tuo naso coglie un profumo familiare, casalingo e appagante. Proprio mentre cerchi di annusare ancora l'aroma della mensa, svanisce completamente."
  },
  Event_7238_Name = {
    Text = "Contatto Anomalo"
  },
  Event_7239_ChoiceDesc1 = {
    Text = "[Keep Searching] Aumenta gli HP massimi di Arg1, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_7239_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7239_Desc = {
    Text = "Una voce familiare mi sussurrò all'orecchio, calda e confortante. Ma quando cercai di seguirla, il suono si interruppe bruscamente."
  },
  Event_7239_Name = {
    Text = "Contatto Anomalo"
  },
  Event_7240_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7240_Desc = {
    Text = "Il potere della retrospezione non riesce a trovare un'altra Giunzione per te nel breve termine, ma almeno provi un Sollievo temporaneo."
  },
  Event_7240_Name = {
    Text = "Contatto Anomalo"
  },
  Event_7241_ChoiceDesc1 = {
    Text = "[Keep Searching] Aumenta gli HP massimi di Arg1, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_7241_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7241_Desc = {
    Text = "È come se un paio di mani forti e salde si fossero posate sulle tue spalle, ma quando ti volti a guardare, il tocco un tempo tangibile diventa sfuggente."
  },
  Event_7241_Name = {
    Text = "Contatto Anomalo"
  },
  Event_7242_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7242_Desc = {
    Text = "L'Ombra di \"N\" viene dispersa dal pugno, particelle nere si fondono con la nebbia del Dominio, difficili da rintracciare.\n\"Non divertente, eppure intrigante. Attenderò con impazienza il nostro vero incontro...\""
  },
  Event_7242_Name = {Text = "Showtime"},
  Event_7243_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7243_Desc = {
    Text = "\n\"Brava bambina. Ma devo comunque darti una piccola Punizione.\"\nLa lieve risata di Daffodil svanì nella Fenditura Dimensionale."
  },
  Event_7243_Name = {
    Text = "Tempo suggerimento"
  },
  Event_7244_ChoiceDesc1 = {
    Text = "[Silver Chip] 50% di probabilità di ottenere la Reliquia d'oro \"(RelicConfig.Arg2)\", 50% di probabilità di sviluppare \"(Skill.Arg3)\""
  },
  Event_7244_ChoiceDesc2 = {
    Text = "[Red Chip] 50% di probabilità di ricevere 75 Sigilli Neri, 50% di probabilità di sviluppare [(Skill.Arg3)]"
  },
  Event_7244_ChoiceDesc3 = {
    Text = "[Black Chip] 50% di probabilità di ottenere la Reliquia maledetta \"(RelicConfig.Arg2)\", 50% di probabilità di sviluppare \"(Skill.Arg3)\""
  },
  Event_7244_Desc = {
    Text = [[
Bene... bene...
Ora, scegli il chip che desideri.]]
  },
  Event_7244_Name = {Text = "Showtime"},
  Event_7245_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7245_Desc = {
    Text = "\"Va bene, va bene. Quel tizio ha sempre avuto un debole per le creature interdimensionali. Mi è costata parecchia fatica navigare liberamente attraverso queste Fenditura Dimensionale. Ah, dev'essere stato 3.000 anni fa.\""
  },
  Event_7245_Name = {
    Text = "Tempo suggerimento"
  },
  Event_7246_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7246_Desc = {
    Text = "Speriamo che il direttore della ricerca non vi installi una bomba sul petto."
  },
  Event_7246_Name = {
    Text = "Spilla Inquieta"
  },
  Event_7247_ChoiceDesc1 = {
    Text = "[Leave] Distruggi una Carta di comando e ricevi 25 Sigilli Neri."
  },
  Event_7247_Desc = {
    Text = "\"Un gentile straniero, che offre guida a chi si è smarrito,\" sogghignò, \"Viaggia leggero. Cerbero attende.\"\nIl dispositivo nella sua mano vibrò all'improvviso."
  },
  Event_7247_Name = {
    Text = "Compagno di viaggio insolito III"
  },
  Event_7248_ChoiceDesc1 = {
    Text = "[Move Slowly] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7248_ChoiceDesc2 = {
    Text = "[Lie Down] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7248_Desc = {
    Text = "\"Quando incontri delle paludi, non agitarti mai.\"\nTieni a mente questa regola di sopravvivenza, restando immobile come una statua dell'Isola di Pasqua.\nCinque minuti, dieci minuti, un'ora... il fango nero alla fine ha perso la pazienza ed è scomparso da sotto i tuoi piedi."
  },
  Event_7248_Name = {
    Text = "Palude Cupa"
  },
  Event_7249_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7249_Desc = {
    Text = "Noti una mano insolita. È delicata, pallida, e per tutto il tempo è rimasta calma.\nMa soprattutto — la riconosci come la tua stessa mano.\nLa afferri dolcemente.\nLa mano ricambia la stretta. Avverti un freddo che gela le ossa e un'Illusione, poi la palude svanisce."
  },
  Event_7249_Name = {
    Text = "Palude Cupa"
  },
  Event_7250_ChoiceDesc1 = {
    Text = "[Cut Off Hand] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7250_ChoiceDesc2 = {
    Text = "[Soothe Them] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7250_Desc = {
    Text = "Brandisci la lama, abbattendole una dopo l'altra.\nIl sangue schizza sul tuo corpo, sul viso e tra i capelli, ma tu resti ignaro.\nInnumerevoli mani urlano di agonia, e la palude svanisce.\nCi vuole una settimana perché le grida smettano di tormentare i tuoi incubi."
  },
  Event_7250_Name = {
    Text = "Palude Cupa"
  },
  Event_7251_ChoiceDesc1 = {
    Text = "[Pick up the Silver Core] Potenzia una Reliquia d'Argento nella Reliquia Dorata [(RelicConfig.Arg1)]"
  },
  Event_7251_ChoiceDesc2 = {
    Text = "[Attempt Awakening] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\" e \"(Skill.Arg3)\"."
  },
  Event_7251_ChoiceDesc3 = {
    Text = "[Ignore] Ricevi 25 Sigilli Neri"
  },
  Event_7251_Desc = {
    Text = [[
Sotto l'asse allentata del ponte, una melma nera e lurida trasuda.
In mezzo alla melma, il familiare luccichio di un "Nucleo d'Argento" cattura il tuo sguardo.]]
  },
  Event_7251_Name = {
    Text = "Prova dell'Essere"
  },
  Event_7252_ChoiceDesc1 = {
    Text = "[The Rat] Incidi l'Orazione [(EnchantConfig.Arg1)] su una Carta di comando casuale."
  },
  Event_7252_ChoiceDesc2 = {
    Text = "[The Candle] Aumenta i PV massimi di Arg1, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_7252_Desc = {
    Text = [[
Il Dissoluto si dissipa davanti a te. Da esso, ceneri nere si condensano nella nebbia formando una strana coppia di piatti di una bilancia. Su un lato, un topo giace addormentato. Sull'altro siede una piccola candela, scolpita nella forma di un ragazzino.
Istintivamente sai che devi fare una scelta.]]
  },
  Event_7252_Name = {
    Text = "Ragione e sentimento"
  },
  Event_7253_ChoiceDesc1 = {Text = "[Call Out]"},
  Event_7253_ChoiceDesc2 = {
    Text = "[Check Carefully]"
  },
  Event_7253_Desc = {
    Text = "Svoltando un angolo, ciò che ti circonda diventa sempre più sfocato, eppure i ruggiti terrificanti restano nitidi.\nI Passi riecheggiano, e quando ti volti, riesci a distinguere vagamente una figura strana; la sua forma Umanoide si erge come farebbe una persona, ma dietro di essa si staglia un paio di ombre che ricordano le ali di una falena gigantesca.\n\"Fai attenzione,\" sussurra Ramona, \"In un Dominio, ciò che vedi non è necessariamente reale. Se non stai attento, potresti metterti in pericolo.\""
  },
  Event_7253_Name = {
    Text = "Figura Avvolta nella Nebbia"
  },
  Event_7254_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7254_Desc = {
    Text = [[
Estrai la Chiave d'argento, stringendola con dolore e reverenza. Un tenue bagliore simile a nebbia ti avvolge.
Nel silenzio, solo un sospiro permane.]]
  },
  Event_7254_Name = {
    Text = "Sguardo del Guardiano"
  },
  Event_7255_ChoiceDesc1 = {
    Text = "[Choose Silver River] Incidi l'Orazione [(EnchantConfig.Arg1)] su una Carta di comando casuale."
  },
  Event_7255_ChoiceDesc2 = {
    Text = "[Choose Rainbow Path] Aumenta gli HP massimi di Arg1, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_7255_Desc = {
    Text = "Tum, tum, tum.\nIl tuo cuore batte come un tamburo, la bocca è arida, e uno sguardo dall'alto ti trafigge la spina dorsale fino al petto.\nUn bivio si apre davanti a te: un sentiero scorre come un fiume di stelle, l'altro brilla di riflessi iridescenti."
  },
  Event_7255_Name = {
    Text = "Crocevia Stellare"
  },
  Event_7256_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7256_Desc = {
    Text = [[
Sguardi persistenti continuano a osservarti, mentre le cellule sotto la tua pelle urlano e fuggono, le tue vene si contorcono come vermi.
Senti un flusso di potere che monta, che esplode nello stato grottesco dei tuoi arti]]
  },
  Event_7256_Name = {
    Text = "Sguardo del Guardiano"
  },
  Event_7257_ChoiceDesc1 = {
    Text = "[Leave] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_7257_ChoiceDesc2 = {
    Text = "[Leave] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_7257_ChoiceDesc3 = {
    Text = "[Leave] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_7257_Desc = {
    Text = "\n\"No, non è vero. Rispetto agli scarafaggi, almeno voi avete dei corpicini pelosi.\nNessuno può resistere a un corpicino peloso.\"\nI topi sussurrarono tra loro e alla fine concordarono con il tuo punto di vista.\n\"Beh, non è che ci sia poi tutto questo pelo.\"\nRicevere un complimento fa sempre piacere. Prima di andarsene, i topi ti fecero un piccolo regalo"
  },
  Event_7257_Name = {Text = "Peste"},
  Event_7258_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7258_Desc = {
    Text = "\"Sono d'accordo! Umani e ratti non possono coesistere!\"\nI ratti sembravano un po' arrabbiati, mostrando le loro zanne bianche.\n\"Allora perché sei ancora qui? Prendi le tue cose e non tornare mai più.\""
  },
  Event_7258_Name = {Text = "Peste"},
  Event_7259_ChoiceDesc1 = {
    Text = "[Leave] Ottieni la Reliquia \"(RelicConfig.Arg1)\", ma sviluppi il Sintomo \"(Skill.Arg2)\"."
  },
  Event_7259_Desc = {
    Text = "Uno strano battito d'ali risuona intorno a te. In uno stato confuso, vedi Rogers che stringe la bambola George, disteso sul lettino con le mani macchiate di sangue.\nApri gli occhi e ti rendi conto che Clementine non si trova da nessuna parte.\nQuando ti risvegli, Clementine è ormai svanita da tempo."
  },
  Event_7259_Name = {
    Text = "Ipnoterapia"
  },
  Event_7260_ChoiceDesc1 = {
    Text = "[Unlock] Usa la chiave."
  },
  Event_7260_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7260_Desc = {
    Text = "Una porta blocca il tuo cammino. Hai provato ogni metodo, eppure resta saldamente al suo posto."
  },
  Event_7260_Name = {
    Text = "Porta arrugginita"
  },
  Event_7260_Tips1 = {
    Text = "Devi trovare la \"Chiave arrugginita\"."
  },
  Event_7261_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7261_Desc = {
    Text = "Volgi lo sguardo verso quella che credi essere la fonte dello Sguardo. Il soffitto del laboratorio sembra improvvisamente lontano, e le ombre sovrapposte di un'immensa pupilla incombono dall'alto. Sebbene incroci solo parzialmente il tuo sguardo, avverti comunque una pressione immane."
  },
  Event_7261_Name = {
    Text = "Di chi è lo sguardo?"
  },
  Event_7262_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7262_Desc = {
    Text = "Il gatto nero si avvicina con cautela e rigurgita una massa oscura nel palmo della tua mano."
  },
  Event_7262_Name = {
    Text = "Flagello del Gatto Notturno"
  },
  Event_7263_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7263_Desc = {
    Text = "\"Una scelta saggia. Quando si affronta un nemico formidabile, conoscere sé stessi e il proprio avversario è essenziale, non è vero? Ma attenzione: apprendere troppo sui segreti delle dimensioni potrebbe turbare la vostra mente.\"\n\"Quel tizio non riesce a smettere di ossessionarsi con gli esseri interdimensionali. Mi ci sono volute ere per muovermi liberamente attraverso queste fratture dimensionali. Ah, era 3.000 anni fa.\""
  },
  Event_7263_Name = {
    Text = "Tempo suggerimento"
  },
  Event_7264_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7264_Desc = {
    Text = "\"Miao, miao miao, miao miao miao...\"\nSforzavi la voce, cercando con ogni mezzo di apparire debole e innocuo.\n\"Miao! Miao miao! Miao miao miao!\"\nIl gruppo di gatti sembrò accettare la tua buona volontà, rispondendo con richiami allegri. I vostri versi si rincorrevano avanti e indietro, giorno e notte senza sosta, spaventando persino la luna che si nascose dietro le nuvole."
  },
  Event_7264_Name = {
    Text = "Città dei Gatti"
  },
  Event_7265_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7265_Desc = {
    Text = [[
Allontani con forza il becco del corvo che si strappa le Piume, ma quello si contorce di nuovo implacabile, la sua forza fa Scricchiolare le tue ossa.
Il tuo viso si arrossa mentre impieghi tutta la tua forza per immobilizzare il corpo del corvo, arrestando la sua frenetica automutilazione.
Proprio mentre tiri un sospiro di sollievo, il collo mezzo spennato del corvo scatta bruscamente all'indietro, il corpo si affloscia e si trasforma in una pozza di melma nera tra le tue mani.]]
  },
  Event_7265_Name = {
    Text = "Lacrima di Magma"
  },
  Event_7266_ChoiceDesc1 = {
    Text = "[Pin Down the Crow] Ricevi 20 Sigilli Neri, ma sviluppa [(Skill.Arg2)]"
  },
  Event_7266_ChoiceDesc2 = {
    Text = "[Ignore It] Parti"
  },
  Event_7266_Desc = {
    Text = "Il corvo solitario, con voce rauca, si strappa le piume nere una a una.\nTrema di dolore, emettendo grida acute, eppure non riesce a fermare il suo ritmo sempre più frenetico.\n\"Cra—Cra—\"\nLacrime azzurre miste a melma nera gli colano dagli occhi, e tu sei l'unico testimone."
  },
  Event_7266_Name = {
    Text = "Lacrima di Magma"
  },
  Event_7267_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7267_Desc = {
    Text = [[
Il corvo si strappa le piume, proprio come gli esseri umani si mordono il proprio corpo.
In questo mondo di paura, scene simili sono comuni. Non puoi salvare tutti gli esseri viventi.]]
  },
  Event_7267_Name = {
    Text = "Lacrima di Magma"
  },
  Event_7268_ChoiceDesc1 = {
    Text = "[Leave] Ottieni la Reliquia \"(RelicConfig.Arg1)\", ma sviluppi il Sintomo \"(Skill.Arg2)\"."
  },
  Event_7268_Desc = {
    Text = "\"Tornerò con gli studenti.\" La ragazza tirò la gonna dell'Awakener, tenace. \"Abbi cura di te... non cadere in mare.\""
  },
  Event_7268_Name = {
    Text = "Veglia della Fanciulla Sacra"
  },
  Event_7269_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7269_Desc = {
    Text = "Haha, nero, il mio preferito. Caos, Confusione, dolore... Ormai dovresti averlo capito—il nero non è mai un buon presagio.\nQuindi, qual è la tua prossima Scelta?"
  },
  Event_7269_Name = {Text = "Showtime"},
  Event_7270_ChoiceDesc1 = {
    Text = "[Pin Down the Crow] Ricevi 25 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_7270_ChoiceDesc2 = {
    Text = "[Ignore It] Parti"
  },
  Event_7270_Desc = {
    Text = "Il corvo solitario, con voce rauca, si strappa le piume nere una a una.\nTrema di dolore, emettendo grida acute, eppure non riesce a fermare il suo ritmo sempre più frenetico.\n\"Cra—Cra—\"\nLacrime azzurre miste a melma nera gli colano dagli occhi, e tu sei l'unico testimone."
  },
  Event_7270_Name = {
    Text = "Lacrima di Magma"
  },
  Event_7271_ChoiceDesc1 = {
    Text = "[Leave] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7271_Desc = {
    Text = "Quella era la parte più profonda della cabina, a lungo trascurata, scarsamente illuminata e priva di guida.\nLa ragazza sarebbe partita con la benedizione del santo della nave, come da accordo."
  },
  Event_7271_Name = {
    Text = "Veglia della Fanciulla Sacra"
  },
  Event_7272_ChoiceDesc1 = {
    Text = "[Chase the Song] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7272_ChoiceDesc2 = {
    Text = "[Sing Along] Sviluppa il Sintomo [(Skill.Arg1)] e cambia l'Orazione da incidere.(Utilizzi: 1/2)"
  },
  Event_7272_Desc = {
    Text = "Il canto lontano si frantuma in Polvere di Stelle:\n\"Maledico la lurida pozza nel vicolo notturno, i fiori marcescenti aggrappati al muro fatiscente, catene che avvolgono il cervello mentre sprofonda nel fango. Prima che la nebbia cancelli la mia esistenza, il crepuscolo discenderà nella più profonda @3.\""
  },
  Event_7272_Name = {
    Text = "Maledizione Pallida"
  },
  Event_7273_ChoiceDesc1 = {
    Text = "[Chase the Song] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7273_Desc = {
    Text = "Il canto lontano si frantuma in Polvere di Stelle:\n\"Maledico la lurida pozza nel vicolo notturno, fiori marcescenti si aggrappano al muro fatiscente, catene avviluppano il cervello che sprofonda nel fango. Prima che la nebbia cancelli la mia esistenza, il crepuscolo sprofonderà nella più profonda @4.\""
  },
  Event_7273_Name = {
    Text = "Maledizione Pallida"
  },
  Event_7274_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7274_Desc = {
    Text = "Il Nucleo d'Argento non ha risposto al tuo Risveglio, ma ha emanato un'aura calda."
  },
  Event_7274_Name = {
    Text = "Nucleo d'Argento Solitario"
  },
  Event_7275_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7275_Desc = {
    Text = "Una vorticosa nebbia nera ti risale lungo la spina dorsale finché non crolli a terra, ripetendo questa frase all'infinito."
  },
  Event_7275_Name = {
    Text = "L'Invisibile"
  },
  Event_7276_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7276_Desc = {
    Text = "Sì, l'umor vitreo che scorre lentamente dalle tue pupille è la prova della corruzione indotta dal tabù.\nL'onestà, in questo istante, si erge in opposizione alla virtù."
  },
  Event_7276_Name = {
    Text = "L'Invisibile"
  },
  Event_7277_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7277_Desc = {
    Text = "L'antica moneta è appiccicosa e umida, come se fosse ricoperta di residui immondi, da cui emanano visibili fumi neri."
  },
  Event_7277_Name = {
    Text = "Reliquia Bifronte"
  },
  Event_7278_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7278_Desc = {
    Text = [[
Le tue acute terminazioni nervose inviano un avvertimento fatale. Indietreggi bruscamente, ritraendoti a malincuore.
Ancora una volta, sfuggi per un soffio...
Una maledizione? O forse una rinascita dalla terra?]]
  },
  Event_7278_Name = {
    Text = "Reliquia Bifronte"
  },
  Event_7279_ChoiceDesc1 = {
    Text = "[Scatenare la Farfalla] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7279_ChoiceDesc2 = {
    Text = "[Become a Butterfly] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7279_ChoiceDesc3 = {
    Text = "[Swallow Back] Ricevi 25 Sigilli Neri"
  },
  Event_7279_Desc = {
    Text = "Tante cose sono accadute questa notte.\nL'assalto al molo, il cargo fantasma, il Navigatore, Tulu, Murphy, Ramona... tutto risucchiato in un vortice, rimestato nel porridge d'avena delle 7 del mattino al ristorante di Mythag.\nVorresti chiedere al Risvegliatore di fronte a te, ma non sai da dove cominciare, con un nodo alla gola — o farfalle nello stomaco."
  },
  Event_7279_Name = {
    Text = "L'Effetto Farfalla"
  },
  Event_7280_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Perdi Arg3 PV"
  },
  Event_7280_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7280_Desc = {
    Text = "Volti sfocati appaiono all'improvviso, circondandoti e gemendo disperatamente con corde vocali inesistenti."
  },
  Event_7280_Name = {Text = "Illusione"},
  Event_7281_ChoiceDesc1 = {
    Text = "[Join the Prayer] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7281_ChoiceDesc2 = {
    Text = "[Sink into Ocean] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\" e \"(Skill.Arg3)\"."
  },
  Event_7281_ChoiceDesc3 = {
    Text = "[Surface] Ricevi 25 Sigilli Neri"
  },
  Event_7281_Desc = {
    Text = [[
"Dio gentile, Dio onnipotente.
Placa la tempesta furiosa e arresta le correnti impetuose.
Fa' che l'oceano divenga la nostra dimora profonda, avvolgendo il nostro regno in un velo eterno..."
I sussurri dei devoti formano infine parole che riesci a comprendere, ma con esse giunge un soffocamento ineluttabile.]]
  },
  Event_7281_Name = {
    Text = "Preghiera Onirica"
  },
  Event_7282_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7282_Desc = {
    Text = "Lanci i pezzi di carne rimasti nello sciame di gatti.\nI gatti si precipitano come una Marea nera, dilaniando freneticamente la carne prima di disperdersi rapidamente.\nSfortunatamente, la carne è scaduta. Riempie i loro stomaci vuoti, ma porta ben poca soddisfazione."
  },
  Event_7282_Name = {
    Text = "Città dei Gatti"
  },
  Event_7283_ChoiceDesc1 = {Text = "[Take It]"},
  Event_7283_Desc = {
    Text = "Una sostanza argentea simile al mercurio, raffinata dalla D-melma, contenente un forte potere mentale, utilizzata per collegare più Risvegliatori nei rituali Una sostanza argentea simile al mercurio, raffinata dalla D-melma, contenente un forte potere mentale, utilizzata per collegare più Risvegliatori nei rituali."
  },
  Event_7283_Name = {Text = "Argento"},
  Event_7284_ChoiceDesc1 = {
    Text = "[Leave] Risveglia un Risvegliatore, riduci il Costo di Arithmetica di quella Carta di 2, ma sviluppa [(Skill.Arg1)]."
  },
  Event_7284_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7284_Desc = {
    Text = "Forse ora non ti sentono, ma alla fine udranno il tuo richiamo."
  },
  Event_7284_Name = {Text = "Voce Guida"},
  Event_7285_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7285_Desc = {
    Text = "I soggetti del test Psyche Deepdive vi hanno sfinito, e persino un breve istante di tregua sembra pioggia nel deserto."
  },
  Event_7285_Name = {
    Text = "Porte Infinite"
  },
  Event_7286_ChoiceDesc1 = {
    Text = "[Leave] Risveglia un Risvegliatore casuale"
  },
  Event_7286_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7286_Desc = {
    Text = "Quella voce ti guiderà senza dubbio alla tua destinazione, la risposta a questa indagine."
  },
  Event_7286_Name = {Text = "Voce Guida"},
  Event_7287_ChoiceDesc1 = {
    Text = "[Observe Carefully]"
  },
  Event_7287_Desc = {
    Text = "Attraverso la sfera di cristallo, puoi osservare luoghi lontani."
  },
  Event_7287_Name = {
    Text = "Sfera di Cristallo"
  },
  Event_7288_ChoiceDesc1 = {
    Text = "[Chase the Crows] Ricevi Arg1 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_7288_ChoiceDesc2 = {
    Text = "[Ignore] Lascia"
  },
  Event_7288_Desc = {
    Text = "Il corvo si appollaia sull'armadio, il suo becco affilato incide sinistri disegni sulla porta di legno."
  },
  Event_7288_Name = {
    Text = "Corvo della Lanterna"
  },
  Event_7289_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7289_Desc = {
    Text = "Hai accettato una richiesta di contatto dalla scuola. La voce familiare calma la tua mente. Raccogli le forze e prosegui."
  },
  Event_7289_Name = {Text = "Crocevia"},
  Event_7290_ChoiceDesc1 = {
    Text = "[Stay Here] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_7290_ChoiceDesc2 = {
    Text = "[Find the Exit] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7290_Desc = {
    Text = "Hai varcato la soglia di un silenzio inquietante, con le porte sovrapposte che ruotavano incontrollabilmente, trascinando il tuo corpo nel vortice.\nStordito e disorientato, ti sei dibattuto tra le porte capovolte, distinguendo a malapena La Via d'Uscita, eppure cadendo inevitabilmente in un'altra porta, ancora e ancora.\nQuesta volta ti sei fermato davanti a una porta, l'ignoto oltre di essa emanava un'attrazione fatale, stringendo le corde della tua sanità mentale.\nIn effetti, è letale."
  },
  Event_7290_Name = {
    Text = "Oltre il portale"
  },
  Event_7291_ChoiceDesc1 = {
    Text = "[Ecstasy] Distruggi una Carta di comando e recupera Arg1 PV"
  },
  Event_7291_ChoiceDesc2 = {
    Text = "[Stop] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7291_Desc = {
    Text = "È come se il tuo cranio fosse stato aperto senza sforzo, inondando il cervello con un'ondata di vertigini nauseanti. Una mano invisibile rimesta e sconvolge la tua mente, trasformando la sostanza già fluida in poltiglia.\nCome contenuto gastrico non digerito, simile a un porridge, sfida la gravità e si riversa nella tua corteccia cerebrale cava e desolata.\nImpasta, mescola e artigliava, cospargendo frammenti di gioia e amalgamando i residui del tramonto nella tua carne."
  },
  Event_7291_Name = {
    Text = "Agitazione mentale"
  },
  Event_7292_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7292_Desc = {
    Text = "Rispetto all'improvvisa comparsa dei Segugi infernali, una comune nevicata non merita la tua attenzione. Ignorando i fiocchi di neve che cadono gradualmente, ti lanci nella notte."
  },
  Event_7292_Name = {Text = "Neve"},
  Event_7293_ChoiceDesc1 = {
    Text = "[Connect] Recupera Arg2 PV."
  },
  Event_7293_Desc = {
    Text = "La nebbia si aggrappa densa mentre il tuo distintivo emette un pallido bagliore argenteo. Il comunicatore crepita, prendendo vita. Qualcuno sta chiamando."
  },
  Event_7293_Name = {Text = "Crocevia"},
  Event_7294_ChoiceDesc1 = {
    Text = "[Feel Fear] Ottieni la Reliquia d'Oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7294_ChoiceDesc2 = {
    Text = "[Steadfast Will] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7294_Desc = {
    Text = "Lamenti sinistri echeggiano, ma Londinium resta in silenzio, come morta o addormentata.\nVaghi sotto il ponte ferroviario, ricordando i consigli di Alistair.\nSi avvicina cortesemente, tentando di parlare, ma le sue parole sono confuse.\nAlzi lo sguardo — un fluido nero e viscoso gli cola dalla bocca, soffocandogli le parole —"
  },
  Event_7294_Name = {
    Text = "Ululato del Caos"
  },
  Event_7295_ChoiceDesc1 = {
    Text = "[Leave] Incidi 1 Orazione su 3"
  },
  Event_7295_Desc = {
    Text = "\"Ma certo, certo. Se non vi dispiace, posso darvi una mano.\"\nTi porge un antico specchio a mano.\n\"Il cavaliere ha già preso la scacchiera, e il re non tarderà a seguirlo. Probabilmente lo incontrerete presto. Davvero entusiasmante, non trovate?\""
  },
  Event_7295_Name = {
    Text = "Compagno di viaggio insolito IV"
  },
  Event_7296_ChoiceDesc1 = {
    Text = "[Shred the Letter] Distruggi 2 Carte qualsiasi"
  },
  Event_7296_ChoiceDesc2 = {
    Text = "[Continue Reading] Ottieni Reliquia maledetta \"(RelicConfig.Arg1)\", infetta \"(Skill.Arg2)\"."
  },
  Event_7296_ChoiceDesc3 = {
    Text = "[Leave] Ricevi Arg1 Sigilli Neri"
  },
  Event_7296_Desc = {
    Text = "Davanti ai tuoi occhi, un branco di farfalle nere erompe all'improvviso, riversandosi senza sosta, sbattendo le ali e precipitando sulla scrivania.\nIl foglio da lettera bianco, dispiegato, è macchiato d'inchiostro, con le farfalle ferite adagiate sulla sua superficie, a malapena vive.\nIl fluido nero e vischioso sulle loro ali forma parole proibite mentre si spalma sulla pagina.\nEstrai questo foglio dalla macchina da scrivere."
  },
  Event_7296_Name = {
    Text = "Capitolo della Farfalla"
  },
  Event_7297_ChoiceDesc1 = {
    Text = "[Go to the Butterflies] Distruggi una Carta di comando e ricevi Arg1 Sigilli Neri."
  },
  Event_7297_ChoiceDesc2 = {
    Text = "[Linger No Longer]"
  },
  Event_7297_Desc = {
    Text = "Un detto recente a Londinium recita: \"Il battito d'ali di una Farfalla a Yakutsk può scatenare una tempesta nel Regno di Leonia.\"\nQuando vedi le farfalle erompere in massa, non puoi fare a meno di ricordare questo detto.\nQueste farfalle potrebbero bastare a scatenare un disastro capace di inghiottire il pianeta."
  },
  Event_7297_Name = {
    Text = "Tempesta di Gnosi"
  },
  Event_7298_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_7298_Desc = {
    Text = [[
Porti un dito alle labbra, facendo segno di silenzio.
Il gatto nero sfreccia come un fantasma, lasciando un oscuro dono ai tuoi piedi.]]
  },
  Event_7298_Name = {
    Text = "Flagello del Gatto Notturno"
  },
  Event_7299_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7299_Desc = {
    Text = "È scivolato nella tua borsa come un pezzo di seta, il lieve aumento di peso appena percettibile, come se sussurrasse un sommesso ringraziamento.\nDopo di che, tutto fu silenzio."
  },
  Event_7299_Name = {
    Text = "Spirito del Caos"
  },
  Event_7300_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7300_Desc = {
    Text = "Le grida dello Spirito del Caos si fecero più acute, trasformandosi infine in un urlo lacerante che riecheggiò tutt'intorno.\nCon le tue offerte e un dolore ineluttabile, Esso sprofondò nuovamente nella melma."
  },
  Event_7300_Name = {
    Text = "Spirito del Caos"
  },
  Event_7301_ChoiceDesc1 = {
    Text = "[Answer Honestly]"
  },
  Event_7301_ChoiceDesc2 = {
    Text = "[Doodle Randomly]"
  },
  Event_7301_Desc = {
    Text = "Le strade del Distretto Est sono intricate e complesse, e ben presto perdi di vista i fanciulli.\nProprio quando cominci a perdere la speranza, una donna misteriosa ti si avvicina.\n\"So dove sono andati i fanciulli, ma prima di dirtelo, potresti farmi un piccolo favore?\"\nEstrae un foglio di carta e ti sorride con gentilezza.\n\"Mi chiamo Clementine. Sono una psicologa che sta conducendo un'indagine psicologica sui residenti di Londinium. Se potessi semplicemente compilare questo questionario,\nsarei più che lieta di offrire a te e ai tuoi compagni un po' di assistenza.\""
  },
  Event_7301_Name = {
    Text = "Valutazione Psicologica"
  },
  Event_7302_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7302_Desc = {
    Text = "\"Anche questa fu una mia decisione,\" dice la figura che stringe delle caramelle. \"Ma lei diventerà il suo pedone, e prima o poi sarai costretto a fare una Scelta.\nNon esistono finali perfetti in questo mondo.\"\nUn profondo dolore ti sopraffà. Le sagome svaniscono, lasciandoti con le mani strette al petto, incerto se si trattasse di una Proiezione o di un Fantasma generato dallo Stress mentale."
  },
  Event_7302_Name = {
    Text = "Sentieri Biforcati"
  },
  Event_7303_ChoiceDesc1 = {
    Text = "[Golden Axe]"
  },
  Event_7303_ChoiceDesc2 = {
    Text = "[Silver Axe]"
  },
  Event_7303_ChoiceDesc3 = {
    Text = "[I Haven't Dropped Anything]"
  },
  Event_7303_Desc = {
    Text = "\"O Pioniere dell'Attraversamento Dimensionale.\"\nUna voce antica riecheggia nelle tue orecchie, come proveniente dalla preistoria, trascendendo le ere.\nIn uno stato di estrema tensione, senti la voce porre una domanda vagamente familiare.\n\"È questa l'ascia d'oro che hai lasciato cadere, o è questa d'argento?\""
  },
  Event_7303_Name = {
    Text = "Voci dall'Oltre"
  },
  Event_7304_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7304_Desc = {
    Text = [[
"Oh, questo..." Riprende il questionario con un'espressione alquanto perplessa. "Pazienza, in fondo hai fretta. I fanciulli sono andati da quella parte, non dovrebbero essere troppo lontani."
Ti volti rapidamente e corri via, quasi perdendoti il sussurro alle tue spalle.
"Non importa, ci rincontreremo."]]
  },
  Event_7304_Name = {
    Text = "Valutazione Psicologica"
  },
  Event_7305_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7305_Desc = {
    Text = "\n\"Chi sei?\"\n\"Sono l'ombra del portatore della Chiave d'Argento, tragicamente assassinato. L'assassino è un astuto serpente albino.\"\n\"Serpente albino? Che cos'è?\"\n\"Un errore. Una blasfemia nata dall'unione di uomo e serpente...\"\nVorresti continuare a interrogarla, ma l'ombra si dissolve all'improvviso, lasciando dietro di sé un terreno ricoperto di polvere dorata."
  },
  Event_7305_Name = {
    Text = "Portatore della Chiave d'Argento"
  },
  Event_7306_ChoiceDesc1 = {
    Text = "[Infection\"(Skill.Arg1)\", Gain Golden Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7306_ChoiceDesc2 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_7306_Desc = {
    Text = "Evento 355 (In Sviluppo), Effetto Non Definitivo"
  },
  Event_7306_Name = {
    Text = "Evento 355 (In Sviluppo)"
  },
  Event_7307_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7307_Desc = {
    Text = "Sprofondare nello stomaco, danzando con le farfalle.\nLe squame del pensiero intrecciate con le farfalle scendono come una neve lieve al tuo interno.\nRicomponi gradualmente ogni cosa e parlerai quando si presenterà la prossima occasione."
  },
  Event_7307_Name = {
    Text = "L'Effetto Farfalla"
  },
  Event_7308_ChoiceDesc1 = {
    Text = "[Refute Them] Incidi l'Orazione \"(EnchantConfig.Arg2)\" su una Carta di comando casuale, ma sviluppa \"(Skill.Arg1)\"."
  },
  Event_7308_ChoiceDesc2 = {
    Text = "[Follow them] Incidi l'Orazione \"(EnchantConfig.Arg2)\" su una Carta di comando casuale, ma sviluppa \"(Skill.Arg1)\"."
  },
  Event_7308_ChoiceDesc3 = {
    Text = "[Propose New Idea] Incidi l'Orazione [(EnchantConfig.Arg1)] su una Carta di comando casuale."
  },
  Event_7308_Desc = {
    Text = "\n\"Per favore, mantenete le distanze da noi.\"\nUno sciame di ratti vi circondò, mantenendo almeno un metro e mezzo di distanza.\n\"Ci adoperiamo per moltiplicarci, prosperiamo; non siamo schizzinosi nel mangiare — e così portiamo malattie, angoscia e sofferenza all'umanità.\"\n\"Non dovremmo avvicinarci troppo agli umani; questo non è un posto per voi.\"\nPer far abbassare la guardia ai ratti, decideste di—"
  },
  Event_7308_Name = {Text = "Peste"},
  Event_7309_ChoiceDesc1 = {
    Text = "[Open Iron Door] Ottieni la Reliquia d'Oro \"(RelicConfig.Arg2)\", ma sviluppi \"(Skill.Arg1)\"."
  },
  Event_7309_ChoiceDesc2 = {
    Text = "[Ignore] Ricevi 50 Sigilli Neri"
  },
  Event_7309_Desc = {
    Text = "Questo è un tipico ponte ad arco sotto la carreggiata. Una scala accanto ai binari conduce a una porta di ferro. Dietro di essa, senti un ritmico e insolito rumore metallico.\nTi fermi a osservare la porta, notando un pesante lucchetto appeso, ma non è chiuso a chiave."
  },
  Event_7309_Name = {
    Text = "Dietro i Cancelli di Ferro"
  },
  Event_7310_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 50 Sigilli Neri, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_7310_Desc = {
    Text = [[
Resistendo alla tentazione, rimani impassibile.
Il proprietario della voce sembra deluso, causando qualche increspatura sulla superficie dell'acqua, e poi tutto torna calmo.]]
  },
  Event_7310_Name = {
    Text = "Voci dall'Oltre"
  },
  Event_7311_ChoiceDesc1 = {
    Text = "[Infection\"(Skill.Arg1)\", Gain Golden Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7311_ChoiceDesc2 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_7311_Desc = {
    Text = "Evento 353 (In Sviluppo), Effetto Non Definitivo"
  },
  Event_7311_Name = {
    Text = "Evento 353 (In Sviluppo)"
  },
  Event_7312_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 50 Sigilli Neri, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_7312_Desc = {
    Text = "\"Voi umani non avete altre risposte?\"\nIl proprietario della voce emise un ringhio impaziente, scuotendo l'intero spazio.\n\"Avidi e ignoranti... Ecco perché sono stanco di voi.\""
  },
  Event_7312_Name = {
    Text = "Voci dall'Oltre"
  },
  Event_7313_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7313_Desc = {
    Text = "Accetta la disposizione del Dominio, guadagna nella perdita e abbraccia il dono maledetto."
  },
  Event_7313_Name = {
    Text = "Eruzione di Delirio"
  },
  Event_7314_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7314_Desc = {
    Text = "Gli occhi battono lentamente le palpebre, incerti se abbiano compreso la tua domanda.\nUna singola lacrima dorata e vermiglia scende dall'angolo dell'occhio, come una piccola stella che irradia un caldo bagliore solare. La sua caduta porta con sé tristezza e pietà, finché non si frantuma in polvere sui mattoni.\nTorni bruscamente alla realtà: gli occhi sono scomparsi."
  },
  Event_7314_Name = {
    Text = "Sguardo Cieco"
  },
  Event_7315_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7315_Desc = {
    Text = "Alcuni bambini vestiti in modo semplice, persino un po' sporchi, corrono per la strada, inseguiti da un adulto in uniforme da poliziotto. Uno dei bambini indossa un cappuccio marrone che sembra vagamente familiare."
  },
  Event_7315_Name = {
    Text = "I Nostri Ricordi"
  },
  Event_7316_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7316_Desc = {
    Text = "\"Smetti di cantare—\"\nAvverti il cantante stonato, rifiutandoti di lasciargli torturare oltre le tue orecchie."
  },
  Event_7316_Name = {
    Text = "Bruto del Sentiero Stretto"
  },
  Event_7317_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7317_Desc = {
    Text = "\n\"Fermo lì!!! Persino il mostro in dissoluzione che striscia sul ventre conosce i propri arti meglio di te!\"\nLascia andare il pubblico...\nLo implori nel tuo cuore"
  },
  Event_7317_Name = {
    Text = "Bruto del Sentiero Stretto"
  },
  Event_7318_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7318_Desc = {
    Text = [[
Fanghiglia nera ti gocciola sul viso, provocando un prurito pungente.
Incapace di sopportarlo, colpisci la farfalla.
La farfalla schiva il tuo gesto ostile e svanisce silenziosamente in lontananza.]]
  },
  Event_7318_Name = {
    Text = "Ciò che Non Dovrebbe Esistere"
  },
  Event_7319_ChoiceDesc1 = {
    Text = "[Praise It] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7319_Desc = {
    Text = "Jenkin disse: \"Svegliati, Johnny! Scrivere poesie non pagherà i tuoi debiti né riparerà il tuo pavimento che perde.\"\nDicesti: \"Sfortunatamente, le tue cellule dedite alla ricerca della verità moriranno al ritmo di un milione al giorno. Presto non sarai altro che un tronco encefalico.\"\nIl cervello scrollò le spalle con indifferenza—se avesse potuto.\nIl cervello disse: \"Penso, dunque sono. Quando raggiungerai il mio livello di pensiero, non ti importerà più dei tronchi encefalici.\""
  },
  Event_7319_Name = {
    Text = "Cervello del Filosofo"
  },
  Event_7320_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7320_Desc = {
    Text = "Il pianoforte emette un lieve sospiro, persistente ma confortante, simile al sorriso di qualcuno giunto alla fine della propria melodia.\n\"Finché i fanciulli... finché...\"\nPrima che tu riesca a distinguere chiaramente le parole, il fantasma del pianoforte svanisce col vento."
  },
  Event_7320_Name = {
    Text = "Filastrocca"
  },
  Event_7321_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 1 di 3 Reliquie d'argento, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_7321_Desc = {
    Text = "\nPrendi la cartella clinica spessa e, aprendola, trovi \"G. R.\" sulla pagina del titolo.\n\"Oh cielo, oh cielo, questa non è la tua cartella, vero?\" dice Clementine, del tutto imperturbata. \"Non importa, dopotutto studiare la psiche altrui può giovare alla propria.\"\nPrima che tu potessi chiedere, la sua figura era già svanita da tempo."
  },
  Event_7321_Name = {
    Text = "Cartelle Cliniche"
  },
  Event_7322_ChoiceDesc1 = {
    Text = "[Leave] Risveglia un Risvegliatore, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_7322_Desc = {
    Text = "Prendi la sottile cartella clinica e, aprendola, trovi un singolo foglio all'interno, con una sola frase scritta.\n\"Nell'eterno mare del caos, un Occhio Pallido e Privo di Pupilla osserva senza fine.\"\nPrima che tu possa chiedere, la figura di Clementine era già svanita da tempo."
  },
  Event_7322_Name = {
    Text = "Cartelle Cliniche"
  },
  Event_7323_ChoiceDesc1 = {
    Text = "[Connect] Recupera tutti gli HP."
  },
  Event_7323_ChoiceDesc2 = {
    Text = "[Meditate] Risveglia un Risvegliato."
  },
  Event_7323_Desc = {
    Text = "La nebbia si aggrappa densa mentre il tuo distintivo emette un pallido bagliore argenteo. Il comunicatore crepita, prendendo vita. Qualcuno sta chiamando."
  },
  Event_7323_Name = {Text = "Crocevia"},
  Event_7324_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7324_Desc = {
    Text = "Le prove fisiche importanti dovrebbero essere accuratamente conservate e consegnate al dipartimento di storia per ricerca e analisi."
  },
  Event_7324_Name = {
    Text = "Editto Cifrato: Parte I"
  },
  Event_7325_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7325_Desc = {
    Text = "Il sole ardente risplende dall'alto dei cieli, squarciando la foschia e ridestando le anime stanche."
  },
  Event_7325_Name = {Text = "Elevazione"},
  Event_7326_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7326_Desc = {
    Text = "Avverti un senso di appagamento. Il loro sguardo tremola nel cielo notturno sopra di te, per poi fissarsi su un altro."
  },
  Event_7326_Name = {
    Text = "Occhio della Cupola"
  },
  Event_7327_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7327_Desc = {
    Text = "Non puoi sfuggire a quello sguardo inquietante, né puoi resistere ai doni degli dèi."
  },
  Event_7327_Name = {
    Text = "Occhio della Cupola"
  },
  Event_7328_ChoiceDesc1 = {
    Text = "[Leave] Ottieni la Reliquia \"(RelicConfig.Arg1)\", ma sviluppi il Sintomo \"(Skill.Arg2)\"."
  },
  Event_7328_Desc = {
    Text = "\n\"Che cosa sei esattamente?\" chiedi inorridito.\n\"Non c'è bisogno che te ne preoccupi. Il nemico del mio nemico è un amico, no?\" L'uomo sorride.\n\"Il dono è stato lasciato sulla sedia. Ti auguro buona fortuna.\""
  },
  Event_7328_Name = {
    Text = "Compagno di viaggio insolito IV"
  },
  Event_7329_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7329_Desc = {
    Text = "Ramona si sporse in avanti, sperando di sentire di più sul \"Camice Bianco\". \"Qualcuno sta origliando!\" La voce del fonografo si alzò improvvisamente: \"Origliando, origliando, origliando!\""
  },
  Event_7329_Name = {
    Text = "Orecchie Altrui"
  },
  Event_7330_ChoiceDesc1 = {
    Text = "[Leave] Aumenta l'Aliemus di tutti i Risvegliati di Arg1"
  },
  Event_7330_Desc = {
    Text = [[
Tieni la mano morbida del ragazzo, attraversando una porta dopo l'altra, fino a raggiungere un piccolo palcoscenico malandato.
Il ragazzo ti stringe la mano per esprimere la sua gratitudine.
"Grazie, addio."]]
  },
  Event_7330_Name = {
    Text = "Fine Ultima II"
  },
  Event_7331_ChoiceDesc1 = {
    Text = "[Descend Further] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_7331_ChoiceDesc2 = {
    Text = "[Pull Away] Ricevi 25 Sigilli Neri"
  },
  Event_7331_Desc = {
    Text = "\"Tu\" ti invita ad andare più in profondità.\nNelle profondità della spirale, il \"tu\" del passato e del futuro ti inviano \"doni\" da diverse dimensioni."
  },
  Event_7331_Name = {Text = "Abisso"},
  Event_7332_ChoiceDesc1 = {
    Text = "[Keep Silent] 100% di probabilità di ottenere 25 Sigilli Neri"
  },
  Event_7332_ChoiceDesc2 = {
    Text = "[Reach Out and Touch] 50% di probabilità di ottenere 50 Sigilli Neri, 50% di probabilità di non ottenere nulla."
  },
  Event_7332_Desc = {
    Text = "\"Tutto ciò che ho da dire si riassume in una massima: nessuno può uccidere un gatto!\"\n\"Quel maledetto gatto nero avrebbe dovuto essere sventrato e lasciato a marcire in aperta campagna, ma ha dissotterrato la tomba di famiglia, divorando i resti di carne umana e disperdendo ossa e arti ovunque.\"\n\"Sotto le sue fredde, scure pupille a fessura, il pus giallastro e putrido affiorava, e io strisciavo via, tormentato dagli incubi, con lo spirito prosciugato.\"\n\"Aspettate... Cosa state facendo? Non sono pazzo! Non lo sono! Voi dovete nascondere qualcosa! È la verità—\"\nÈ davvero la verità. Mentre osservate l'ombra del folle svanire, scambiate uno sguardo con il silenzioso gatto nero ai vostri piedi."
  },
  Event_7332_Name = {
    Text = "Flagello del Gatto Notturno"
  },
  Event_7333_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7333_Desc = {
    Text = "Gli chiedi indicazioni per il Museo delle Cere.\nStrano, è la quinta volta che lo incontri stanotte. Gli hai acceso il fuoco cinque volte e chiesto indicazioni cinque volte.\nEppure, non riesci ancora a ricordare dove si trovi il Museo delle Cere, così come continui a imbatterti in lui."
  },
  Event_7333_Name = {
    Text = "Silhouette sotto il Lampione"
  },
  Event_7334_ChoiceDesc1 = {
    Text = "[Chase the Crows] Ricevi 25 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_7334_ChoiceDesc2 = {
    Text = "[Continue chasing the child] Parti"
  },
  Event_7334_Desc = {
    Text = "Il terzo corvo se ne andò, volando oltre lo sguardo e nell'oscurità eterna."
  },
  Event_7334_Name = {
    Text = "Sguardo del Corvo"
  },
  Event_7335_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 75 Sigilli Neri, ma sviluppi il Sintomo [(Skill.Arg2)]"
  },
  Event_7335_Desc = {
    Text = "Il pelo è morbido e delicato, conserva ancora il calore della vita di Koum.\nÈ l'ultimo raggio di tramonto prima del crepuscolo, un fugace frammento residuo di tepore."
  },
  Event_7335_Name = {
    Text = "Calore Residuo"
  },
  Event_7336_ChoiceDesc1 = {Text = "[Chase]"},
  Event_7336_Desc = {
    Text = "Hai perquisito con cura la parete e infine hai scoperto un ingresso nascosto alla fogna dietro i cespugli. Ti sei trascinato attraverso la fogna, ma il Mostro era già fuggito."
  },
  Event_7336_Name = {
    Text = "Vicolo Cieco"
  },
  Event_7337_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7337_Desc = {
    Text = "Gli uccelli seguono le proprie regole. Non agiscono secondo la tua volontà, né hai il diritto di interferire con le leggi della natura."
  },
  Event_7337_Name = {
    Text = "Corvo Solitario"
  },
  Event_7338_ChoiceDesc1 = {
    Text = "[Overlook Reflection] Ricevi 25 Sigilli Neri"
  },
  Event_7338_ChoiceDesc2 = {
    Text = "[Are You Okay?] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_7338_Desc = {
    Text = "\"Sai che ti dico... quella nuova padrona del locale accanto non esce mai... L'altro giorno le ho offerto una birra, e quando la schiuma era completamente svanita, all'improvviso ho notato... nel bicchiere, lei non aveva ombra!\""
  },
  Event_7338_Name = {
    Text = "Frammento di Memoria: Birra"
  },
  Event_7339_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7339_Desc = {
    Text = [[
"Vorrei tanto cantare di nuovo con te..."
I lamenti folli e distorti di Sarah si interruppero all'improvviso, il suo volto deforme che mostrava una traccia di confusione.]]
  },
  Event_7339_Name = {
    Text = "\"Sorella Sasha\""
  },
  Event_7340_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_7340_Desc = {
    Text = "\"Che gioia! Che gioia!\" Una voce forte, acuta e infantile risuona nelle tue orecchie, \"Per te, per te!\""
  },
  Event_7340_Name = {
    Text = "Spiritello notturno"
  },
  Event_7341_ChoiceDesc1 = {
    Text = "[Thick Record]"
  },
  Event_7341_ChoiceDesc2 = {
    Text = "[Thin Record]"
  },
  Event_7341_Desc = {
    Text = "Una voce piuttosto familiare ti chiama. Strizzi gli occhi, ma non riesci a distinguere bene la figura.\n\"So che hai fretta,\" dice la Dott.ssa Clementine allegramente, \"prometto di non rubarti troppo tempo.\"\nDue mani si protendono attraverso la nebbia nella tua mente, ciascuna reggendo una cartella clinica — una spessa e consunta, l'altra sottile e immacolata.\n\"Sulla base dei risultati del tuo questionario, mi sono presa la libertà di preparare una cartella clinica per te. Tuttavia, sembra che abbia dimenticato quale sia la tua. Perché non scegli tu?\"\nPer qualche ragione, la cartella clinica sottile emana un'aura familiare, risuonando sottilmente con la connessione mentale tra te e la figura."
  },
  Event_7341_Name = {
    Text = "Cartelle Cliniche"
  },
  Event_7342_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7342_Desc = {
    Text = "Un muro apparentemente ordinario. Non hai potuto fare a meno di bussarvi, ma non sembrava solido."
  },
  Event_7342_Name = {
    Text = "Muro Strano"
  },
  Event_7343_ChoiceDesc1 = {
    Text = "[I'm Not on Water] Potenzia una Reliquia d'Argento casuale nella Reliquia d'Oro [(RelicConfig.Arg1)]"
  },
  Event_7343_ChoiceDesc2 = {
    Text = "[Look Down] Ottieni la Reliquia d'Argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7343_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7343_Desc = {
    Text = "\"Hehe, Custode, ricordi ancora l'avvertimento di Winkle? Ascolta, non guardare in basso il tuo riflesso a mezzogiorno.\""
  },
  Event_7343_Name = {
    Text = "Riflesso Informe"
  },
  Event_7343_Tips1 = {
    Text = "Reliquia d'argento non ancora acquisita"
  },
  Event_7344_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7344_Desc = {
    Text = "Un Fantasma da un futuro remoto, occultato nei burroni di Elworth."
  },
  Event_7344_Name = {
    Text = "Fantasma del Vulcano"
  },
  Event_7345_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7345_Desc = {
    Text = "Una farfalla si frantuma nel tuo palmo, come un soffitto di vetro che improvvisamente va in pezzi, frammenti che cadono, cadono, cadono a terra—"
  },
  Event_7345_Name = {
    Text = "Miraggio del ponte d'acciaio"
  },
  Event_7346_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7346_Desc = {
    Text = "Aspettiamo che emergano dalle ombre."
  },
  Event_7346_Name = {
    Text = "Corvo della Lanterna"
  },
  Event_7347_ChoiceDesc1 = {
    Text = "[Switch On] Espandi la visuale attuale."
  },
  Event_7347_Desc = {
    Text = [[
Un antico dispositivo di illuminazione dissipa la Nebbia nera che lo circonda.
La Nebbia attorno ad esso fluttua ritmicamente, come se fosse perturbata dal suo respiro.]]
  },
  Event_7347_Name = {Text = "Riflettore"},
  Event_7348_ChoiceDesc1 = {
    Text = "[Point Out the Issue] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7348_ChoiceDesc2 = {
    Text = "[Swallow Doubt] Sviluppa il Sintomo [(Skill.Arg1)] e cambia l'Orazione da incidere.(Utilizzi: 2/2)"
  },
  Event_7348_Desc = {
    Text = "Anche adesso, stai riflettendo sulla narrazione di Murphy riguardo al passato.\nLe memorie risuonano dentro di te, incatenando e stringendo la tua mente in una morsa. Nemmeno le ultime parole di conforto di Golia a Murphy sono riuscite a darti sollievo.\n...Aspetta, hanno detto che le stelle si allineeranno tra venticinque anni...\nMa Murphy, che ti sta davanti, è chiaramente solo un adolescente..."
  },
  Event_7348_Name = {
    Text = "Vita Imprigionata"
  },
  Event_7349_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 1 di 3 Reliquie d'argento, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_7349_Desc = {
    Text = "Dovrebbe essere lei a versare lacrime; nessuno ha più diritto di piangere di lei.\nMa perché non piange? Perché resta distaccata, come se quelle persone non fossero inginocchiate davanti a lei...?"
  },
  Event_7349_Name = {
    Text = "Riti Pre-Viaggio"
  },
  Event_7350_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7350_Desc = {
    Text = "In ogni caso, è scortese ficcare il naso nella vita privata altrui."
  },
  Event_7350_Name = {
    Text = "Presenza Inscritta"
  },
  Event_7351_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7351_Desc = {
    Text = "Dev'essere un'Illusione momentanea."
  },
  Event_7351_Name = {
    Text = "Sguardo del Corvo"
  },
  Event_7352_ChoiceDesc1 = {
    Text = "[Leave] Incidi 1 Orazione su 3"
  },
  Event_7352_Desc = {
    Text = "Tutti, nella sua memoria, la pregavano, la imploravano. Non hai potuto fare a meno di pregare in silenzio nel tuo cuore..."
  },
  Event_7352_Name = {
    Text = "Riti Pre-Viaggio"
  },
  Event_7353_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7353_Desc = {
    Text = "Sotto il gatto nero, un rivolo costante di melma nera scorre nella fogna all'ingresso del vicolo. Vedendo che non ti avvicini, il gatto si volta e balza nella fogna, scomparendo dalla vista."
  },
  Event_7353_Name = {
    Text = "Spiritello notturno"
  },
  Event_7354_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7354_Desc = {
    Text = [[
Nel panico, emetti un grido acuto.
Distratta dalla tua voce, la mano prima irrequieta esita per un istante.
Cogliendo l'occasione, fuggi immediatamente.]]
  },
  Event_7354_Name = {
    Text = "Palude Cupa"
  },
  Event_7355_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7355_Desc = {
    Text = [[
Torcendoti, contorcendoti, strisciando... Hai tentato ogni metodo per sfuggire a quelle fastidiose braccia.
Alla fine, sei riuscito a fuggire al costo di un'uniforme nuova di zecca, due costole e centinaia di capelli.]]
  },
  Event_7355_Name = {
    Text = "Palude Cupa"
  },
  Event_7356_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7356_Desc = {
    Text = [[

"Un fenomeno normale. Non allarmarti, come un novizio,"
Doll si avvicina, aggiustando la posizione della tua spilla. "Indica che ci sono passaggi di dimensioni speciali nelle vicinanze. Sembra essere nella direzione del manicomio."]]
  },
  Event_7356_Name = {
    Text = "Spilla Inquieta"
  },
  Event_7357_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7357_Desc = {
    Text = [[
Non hai alcun motivo di accettare le offerte somministrate dai Devoti del Portatore di Luce.
Un corvo, scuotendo con disappunto le sue sudice e grottesche teste ammassate, emette un suono che ricorda un cimitero mentre gracchia e vola via.]]
  },
  Event_7357_Name = {
    Text = "Corvo Maledetto"
  },
  Event_7358_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7358_Desc = {
    Text = "\"Anche questa fu una mia decisione,\" dice la figura che stringe un orso. \"Ma lei diventerà la sua marionetta, e moriranno tutti.\nE tu sarai stato complice di questa tragedia.\"\nUn senso di colpa lacerante ti sopraffà. Le sagome svaniscono, lasciandoti con le mani strette al petto, incerto se si trattasse di una Proiezione o di un Fantasma generato dallo Stress mentale."
  },
  Event_7358_Name = {
    Text = "Sentieri Biforcati"
  },
  Event_7359_ChoiceDesc1 = {
    Text = "[Keep Covering Ears] Ricevi Arg1 Sigilli Neri; un ammontare pari al valore di Aliemus più alto di un Risveglio."
  },
  Event_7359_ChoiceDesc2 = {
    Text = "[Keep Covering Ears] Recupera Arg1 PV; la quantità aumenta in base al numero di Sigilli Neri posseduti."
  },
  Event_7359_Desc = {
    Text = "Hai ceduto ai sussurri malevoli nel tuo orecchio. Un dolore lacerante, acuto come un ago, si torce in profondità nel tuo cranio.\n\n\"Smettila—ti prego smettila—ho fatto quello che chiedevi—falla smettere—\"\n\nTi stringi la testa in agonia, sentendo solo la risata beffarda e lontana dei corvi."
  },
  Event_7359_Name = {
    Text = "Canto dei Corvi"
  },
  Event_7360_ChoiceDesc1 = {
    Text = "[Catch a Crow] Ricevi 25 Sigilli Neri per ogni Risveglio attivato."
  },
  Event_7360_ChoiceDesc2 = {
    Text = "[Howl] Scegli una carta Risveglio nel tuo mazzo e applicale l'Affisso [Innato]."
  },
  Event_7360_Desc = {
    Text = [[
Ti senti improvvisamente dispettoso e catturi un corvo.
Si dibatte disperatamente nella tua mano, poi esplode in un caldo schizzo.]]
  },
  Event_7360_Name = {
    Text = "Canto dei Corvi"
  },
  Event_7361_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7361_Desc = {
    Text = [[
Ti copri le orecchie e chiudi gli occhi.
Tum, tum... Il tuo battito cardiaco si mescola allo stridio acuto, formando una caotica sinfonia di morte.
In questo istante, avverti una calma senza precedenti.]]
  },
  Event_7361_Name = {
    Text = "Canto dei Corvi"
  },
  Event_7362_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7362_Desc = {
    Text = "Il Dominio è irto di pericoli. Non tutte le luci servono da fari guida.\nAlcune sono candele che attirano le falene verso la loro rovina."
  },
  Event_7362_Name = {
    Text = "Bagliore Notturno"
  },
  Event_7363_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7363_Desc = {
    Text = "\"Sei morto da tempo, e non puoi tornare a La Nostra Casa.\" La tua voce è fredda Come Se fosse l'Ululato del Vento sulla Distesa di Neve di Ross. L'Espressione del viaggiatore non cambia affatto, Come Se le cose dovessero andare così. Ti afferra di nuovo la mano: \"Aiutami! Sono un Soldato, incaricato di recarmi nelle lontane terre d'Oriente…\""
  },
  Event_7363_Name = {Text = "Divoratore"},
  Event_7364_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7364_Desc = {
    Text = "Il telegrafo è rotto. Immagina la disperazione del suo proprietario nella tempesta... proprio come la tua, adesso."
  },
  Event_7364_Name = {
    Text = "Telegramma Silenzioso"
  },
  Event_7365_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7365_Desc = {
    Text = "\"Vai avanti cinquanta iarde, gira a sinistra, poi a destra, poi di nuovo a sinistra...\nPoi continua a camminare fino in fondo, e la tua casa sarà proprio lì.\"\nIl viaggiatore fu colmo di gioia. Salutò con un cenno e poi se ne andò.\nHai fatto un respiro profondo, e all'improvviso hai sentito qualcuno afferrarti la mano. Quella voce familiare riecheggiò nel tuo orecchio ancora una volta:\n\"Per favore, salvami.\nSono un soldato, inviato nel lontano Oriente...\""
  },
  Event_7365_Name = {Text = "Divoratore"},
  Event_7366_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7366_Desc = {
    Text = "Sei finalmente riuscito a uscire dal labirinto.\nIn quell'istante, realizzi improvvisamente che questo Museo delle Cere è vivo.\nTutta la stranezza, la bellezza e la crudeltà sono intrecciate attraverso un antico Rito.\nE al cuore del Rito si trova Rogers."
  },
  Event_7366_Name = {
    Text = "Labirinto di Occhi"
  },
  Event_7367_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7367_Desc = {
    Text = "\"È divertente il Gioco di Ruolo, Custode?\" Ramona ti tira la manica. \"L'uscita non è lontana. Spero che riuscirai a mantenere questo umorismo davanti a Lady Daffodil.\""
  },
  Event_7367_Name = {
    Text = "Frammento di Ricordi: Sogno del Passato Ritrovato"
  },
  Event_7368_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7368_Desc = {
    Text = "\"È difficile per un Risvegliatore resistere alla volontà del Connettore,\" rispondi, \"ma non rinunceremo.\""
  },
  Event_7368_Name = {
    Text = "La Sua Scelta"
  },
  Event_7369_ChoiceDesc1 = {
    Text = "[Enter] Attraverso il muro, addentrati più in profondità."
  },
  Event_7369_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7369_Desc = {
    Text = "Ti avvicini al muro, e questo si contorce improvvisamente come se cercasse di risucchiarti."
  },
  Event_7369_Name = {
    Text = "Spazio Distorto"
  },
  Event_7370_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7370_Desc = {
    Text = "\n\"No, non è vero. Rispetto agli scarafaggi, almeno voi avete dei corpicini pelosi.\nNessuno può resistere a un corpicino peloso.\"\nI topi sussurrarono tra loro e alla fine concordarono con il tuo punto di vista.\n\"Beh, non è che ci sia poi tutto questo pelo.\"\nRicevere un complimento fa sempre piacere. Prima di andarsene, i topi ti fecero un piccolo regalo"
  },
  Event_7370_Name = {Text = "Peste"},
  Event_7371_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7371_Desc = {
    Text = "\"Sono d'accordo! Umani e ratti non possono coesistere!\"\nI ratti sembravano un po' arrabbiati, mostrando le loro zanne bianche.\n\"Allora perché sei ancora qui? Prendi le tue cose e non tornare mai più.\""
  },
  Event_7371_Name = {Text = "Peste"},
  Event_7372_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7372_Desc = {
    Text = "Benvenuto nelle profondità del Mare profondo, dove ogni passo è gravato da un'immensa pressione.\n\nL'impenetrabile Nebbia del Caos cela ogni cosa; riuscirai a orientarti in questo Mare oscuro sotto tale pressione?"
  },
  Event_7372_Name = {
    Text = "Sotto la Marea"
  },
  Event_7373_ChoiceDesc1 = {
    Text = "[Just Take a Look] Distruggi una Carta"
  },
  Event_7373_ChoiceDesc2 = {
    Text = "[Take a closer look] Ottieni la Reliquia \"(RelicConfig.Arg1)\", ma sviluppi il Sintomo \"(Skill.Arg2)\"."
  },
  Event_7373_Desc = {
    Text = "\"Tap tap...\"\nLa macchina da scrivere, come un vecchio ubriacone che aveva bevuto un whiskey di troppo, balbettava mentre sputava inchiostro nero.\nNotasti subito il nome «Mason» e sfilasti prontamente il foglio dal rullo."
  },
  Event_7373_Name = {
    Text = "Macchina da scrivere"
  },
  Event_7374_ChoiceDesc1 = {
    Text = "[Eye Contact] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7374_ChoiceDesc2 = {
    Text = "[Close Your Eyes] Risveglia 2 Risvegliatori casuali, ma sviluppa [(Skill.Arg1)] due volte."
  },
  Event_7374_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_7374_Desc = {
    Text = [[
Innumerevoli occhi sussurrano attorno alle tue orecchie.
"Viaggiamo, ci fermiamo, avanziamo per decine di migliaia di anni e oltre.
Mentre il sole si spegne sotto il nostro sguardo vigile, mentre la vita sull'antica Terra viene divorata dalle inondazioni.
Siamo da tempo affascinati dai misteri dell'universo."]]
  },
  Event_7374_Name = {Text = "Occhio"},
  Event_7375_ChoiceDesc1 = {
    Text = "[Follow the Instructions] Aumenta gli HP massimi di Arg1"
  },
  Event_7375_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7375_Desc = {
    Text = "Tenti di usare il potere di tracciamento della Chiave d'argento per localizzare la Giunzione più vicina, ma le informazioni che ricevi contengono sottili anomalie, come se fossero state alterate da un'interferenza."
  },
  Event_7375_Name = {
    Text = "Contatto Anomalo"
  },
  Event_7376_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7376_Desc = {
    Text = [[
Pulisci delicatamente la Macchina da scrivere con il fazzoletto di lino standard del tuo kit da Studente Mythag.
La Macchina da scrivere si calma. Quanto al fazzoletto sporco... resta nel Dominio.]]
  },
  Event_7376_Name = {
    Text = "Sussurro della Macchina da Scrivere"
  },
  Event_7377_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7377_Desc = {
    Text = "Osservi attentamente e, attraverso le macchie d'inchiostro ondeggianti e sovrapposte, un nome emerge debolmente: \"Fingal Johansen\".\nChi è costui?"
  },
  Event_7377_Name = {
    Text = "Sussurro della Macchina da Scrivere"
  },
  Event_7378_ChoiceDesc1 = {
    Text = "[Look Up] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando, ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_7378_ChoiceDesc2 = {
    Text = "[Sun's Angle?] Risveglia un Risvegliato, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_7378_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7378_Desc = {
    Text = "\"Ora, guarda subito a sud-est. L'elevazione del sole è in posizione.\" L'ordine di Doll giunse attraverso il comunicatore."
  },
  Event_7378_Name = {Text = "Elevazione"},
  Event_7379_ChoiceDesc1 = {
    Text = "[Infection\"(Skill.Arg1)\", Gain Golden Relic \"(RelicConfig.Arg2)\"]"
  },
  Event_7379_ChoiceDesc2 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_7379_Desc = {
    Text = "Evento 354 (In Sviluppo), Effetto Non Definitivo"
  },
  Event_7379_Name = {
    Text = "Evento 354 (In Sviluppo)"
  },
  Event_7380_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7380_Desc = {
    Text = [[
Voci di fanciulli fluiscono da sotto i tasti del pianoforte.
<Italic:"Il vecchio gatto tigrato di Charlie, grasso e caro...">
Sotto il canto dei fanciulli, la voce gentile di una giovane donna si unisce sommessamente.
Stai sentendo cose che non esistono...?]]
  },
  Event_7380_Name = {
    Text = "Filastrocca"
  },
  Event_7381_ChoiceDesc1 = {
    Text = "[Turn Around] Ricevi 25 Sigilli Neri"
  },
  Event_7381_ChoiceDesc2 = {
    Text = "[Keep Going] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_7381_Desc = {
    Text = [[
Passi risuonano alle tue spalle.
Come un'ombra, ti seguono a un ritmo costante e senza fretta.
Si intrecciano con i tuoi passi, echeggiando nella sala espositiva deserta.]]
  },
  Event_7381_Name = {Text = "Oxford"},
  Event_7382_ChoiceDesc1 = {
    Text = "[Fold the Letter] Distruggi 2 Carte qualsiasi"
  },
  Event_7382_ChoiceDesc2 = {
    Text = "[Save Letters] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7382_ChoiceDesc3 = {
    Text = "[Leave] Ricevi Arg1 Sigilli Neri"
  },
  Event_7382_Desc = {
    Text = "Una nuova macchina da scrivere.\nHa un set di tasti unico, intricato ed elegante come un microscopio.\nMentre ne ammirate la perfetta struttura meccanica, un testo nero appare all'improvviso.\n\"Egregio Signor Rogers,\nCon profondo rammarico, La informiamo che è stato espulso dall'accademia.\nCome saprà, l'Accademia @2 è di Fama Rinomata in tutto il regno per i suoi rigorosi standard accademici, e quelle scioccanti voci @3 hanno profondamente turbato...\""
  },
  Event_7382_Name = {
    Text = "Presenza Inscritta"
  },
  Event_7383_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7383_Desc = {
    Text = "Il lontano, immobile orologio da tasca sembra incalzarti, ricordandoti di non cadere nelle trappole del tempo e dello spazio."
  },
  Event_7383_Name = {
    Text = "Sguardo Divino"
  },
  Event_7384_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7384_Desc = {
    Text = [[
Fanghiglia nera ti gocciola sul viso, provocando un prurito pungente.
Incapace di sopportarlo, colpisci la farfalla.
La farfalla schiva il tuo gesto ostile e svanisce silenziosamente in lontananza.]]
  },
  Event_7384_Name = {
    Text = "Lepidotteri d'Ossidiana"
  },
  Event_7385_ChoiceDesc1 = {
    Text = "[Observe Carefully]"
  },
  Event_7385_ChoiceDesc2 = {Text = "[Dig]"},
  Event_7385_Desc = {
    Text = "Koum vi trasporta tutti e tre attraverso il manicomio, cercando un ingresso.\nAll'improvviso si ferma di colpo, quasi scaraventandoti giù dalla sua schiena.\nTra le tue domande, Koum abbassa il muso, annusando il terreno soffice, poi si volta per indicare qualcosa sepolto sotto."
  },
  Event_7385_Name = {
    Text = "Sepolto nel Profondo"
  },
  Event_7386_ChoiceDesc1 = {
    Text = "[Receive] Acquisisci 1 Reliquia Dorata su 3"
  },
  Event_7386_Desc = {
    Text = "L'area è deserta, un liquido scuro scorre sul terreno, senza riflettere nulla.\nÈ un'illusione? Senti qualcosa scivolarti tra le dita."
  },
  Event_7386_Name = {
    Text = "Sotto lo Specchio"
  },
  Event_7387_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7387_Desc = {
    Text = "Ali nere caddero sul suolo umido del vicolo, trasformandosi in una D-melma nera e fangosa."
  },
  Event_7387_Name = {
    Text = "Stormo di Corvi Frenetici"
  },
  Event_7388_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7388_Desc = {
    Text = "\"La signorina Daffodil apprezzerà il suo umorismo.\" Ramona fece un cenno, e il Fantasma si dissolse. \"Non lasci che lei stessa diventi il prezzo del viaggio dimensionale.\""
  },
  Event_7388_Name = {
    Text = "Frammento di Ricordi: Sogno del Passato Ritrovato"
  },
  Event_7389_ChoiceDesc1 = {
    Text = "[Receive] Acquisisci 1 Reliquia Dorata su 3"
  },
  Event_7389_Desc = {
    Text = "Oh sì, quel riflesso odioso sei tu.\nLa malevolenza montante si fonde con la melma nera ai tuoi piedi, contorcendosi e danzando insieme. Se non ti dispiace, vorrebbe arrampicarsi anche sulla tua spalla."
  },
  Event_7389_Name = {
    Text = "Sotto lo Specchio"
  },
  Event_7390_ChoiceDesc1 = {
    Text = "[Stand Still] Ricevi 25 Sigilli Neri"
  },
  Event_7390_ChoiceDesc2 = {
    Text = "[Walk Casually] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_7390_Desc = {
    Text = "Frantumi la tua ombra in frammenti, precipitando in una pozza di notte.\nI resti sparsi di oscurità sono l'unico legame con il mondo svanito.\nPercorrerai davvero questo Incubo di pece? Non hai ancora trovato il tuo cammino."
  },
  Event_7390_Name = {
    Text = "Viandante dell'Incubo"
  },
  Event_7391_ChoiceDesc1 = {
    Text = "[Seek the Source] Acquisisci la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7391_ChoiceDesc2 = {
    Text = "[Replay Record] Tutti i Risvegli ottengono 50 Aliemus, ma sviluppi [(Skill.Arg1)]."
  },
  Event_7391_ChoiceDesc3 = {
    Text = "[Dismantle the Phonograph] Incidi 1 Orazione tra 3"
  },
  Event_7391_Desc = {
    Text = "\nTi imbatti in un Vecchio Grammofono.\nLo carichi e posi la puntina sul Disco in Vinile graffiato. La sinfonia è distorta, come se il nastro venisse lacerato, con ottoni e archi che si scontrano l'uno contro l'altro — nessuna voce può emergere indenne da questo brano.\nAlla fine crepitante della melodia, senti un battito ritmico.\n\"Toc toc... toc toc toc... toc...\"\nAggrottando le sopracciglia, sollevi la puntina, ma il battito continua immutato."
  },
  Event_7391_Name = {
    Text = "Eco Perduta"
  },
  Event_7392_ChoiceDesc1 = {
    Text = "[Gaze at Radiance] Trasforma una Reliquia nella Reliquia maledetta [(RelicConfig.Arg1)]"
  },
  Event_7392_ChoiceDesc2 = {
    Text = "[Touch the Light] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7392_ChoiceDesc3 = {
    Text = "[Turn and Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7392_Desc = {
    Text = "Sotto la Visione Onirica, la Nebbia del Dominio avvolge la realtà in un velo oscuro. Tutto appare sfocato, come se fosse appena percepibile.\nAttraverso la foschia, la luce di qualcosa trafigge la nebbia. Come un faro che guida una nave, o il fumo che conduce un bambino smarrito, indica la via verso la salvezza."
  },
  Event_7392_Name = {
    Text = "Bagliore Notturno"
  },
  Event_7393_ChoiceDesc1 = {
    Text = "[Pause Music] Potenzia una Reliquia d'argento nella Reliquia d'oro [(RelicConfig.Arg1)]"
  },
  Event_7393_ChoiceDesc2 = {
    Text = "[Talking with It] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\" e \"(Skill.Arg3)\"."
  },
  Event_7393_ChoiceDesc3 = {
    Text = "[Listen Quietly] Ricevi 25 Sigilli Neri"
  },
  Event_7393_Desc = {
    Text = "Hai raccolto frammenti di memorie da una pozza di sudicia melma nera.\nI cristalli brillavano di luce, volute che vorticavano e danzavano al loro interno, mentre schegge di memoria volavano come sabbia dispersa dal vento.\nScene caotiche, bizzarre e inquietanti si levarono intorno a te.\nHai contemplato—\n"
  },
  Event_7393_Name = {
    Text = "Frammento di Luna d'Argento"
  },
  Event_7394_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7394_Desc = {
    Text = "Raccogli alcuni fiocchi di neve che cadono e li osservi da vicino. Si sciolgono in una D-melma scura e densa invece che in gocce limpide."
  },
  Event_7394_Name = {Text = "Neve"},
  Event_7395_ChoiceDesc1 = {
    Text = "[I'm Not on Water] Potenzia una Reliquia d'Argento casuale nella Reliquia d'Oro [(RelicConfig.Arg1)]"
  },
  Event_7395_ChoiceDesc2 = {
    Text = "[Look Down] Ottieni la Reliquia d'Argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7395_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7395_Desc = {
    Text = "La nebbia si dirada, rivelando una mano scheletrica protesa verso di te.\nSembra essere stata corrosa, la superficie ruvida ricoperta di una melma nera e vischiosa. Adornata da anelli e collane che brillano di luce dorata.\nTi fa cenno di avvicinarti.\nSolo nell'ombra della crisi i tesori risplendono con più fulgore."
  },
  Event_7395_Name = {
    Text = "Artigli Rovescianti"
  },
  Event_7395_Tips1 = {
    Text = "Reliquia d'argento non ancora acquisita"
  },
  Event_7396_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7396_Desc = {
    Text = "Il fantasma ti saluta con un cenno prima di svanire. Non restano che la neve gelida e le montagne imponenti."
  },
  Event_7396_Name = {
    Text = "Fantasma del Vulcano"
  },
  Event_7397_ChoiceDesc1 = {
    Text = "[Silver Moon Funeral] Trasforma una Reliquia nella Reliquia maledetta [(RelicConfig.Arg1)]"
  },
  Event_7397_ChoiceDesc2 = {
    Text = "[Silver Moon Prayer] Acquisisci la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7397_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7397_Desc = {
    Text = "Hai raccolto frammenti di memorie da una pozza di melma nera e lurida.\nI cristalli brillavano di luce, volute vorticavano al loro interno, e schegge di memoria volavano come sabbia dispersa dal vento.\nScene caotiche, bizzarre e inquietanti si levarono intorno a te.\nHai guardato—"
  },
  Event_7397_Name = {
    Text = "Frammento di Luna d'Argento"
  },
  Event_7398_ChoiceDesc1 = {
    Text = "[Fuel Up] Incidi 1 Orazione su 3"
  },
  Event_7398_ChoiceDesc2 = {
    Text = "[Extinguish It] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando, ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_7398_Desc = {
    Text = "\"Sono l'Ombra della cameriera che fu assassinata, e l'assassino è quella ingannevole fiamma verde.\"\nLa fiamma debolmente rossa oscillava, accusandoti.\n\"Un tempo vivevo presso il lago che rifletteva la luna gonfia, gloriosa e radiosa.\""
  },
  Event_7398_Name = {
    Text = "Fuoco Pallido"
  },
  Event_7399_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7399_Desc = {
    Text = [[
Tu e l'ombra restavate sotto il lampione, in silenzio.
Non c'era luna stanotte, e tutte le case erano quiete.
Salutasti l'ombra con un cenno e te ne andasti.]]
  },
  Event_7399_Name = {
    Text = "Silhouette sotto il Lampione"
  },
  Event_7400_ChoiceDesc1 = {
    Text = "[Chase the Crows] Ricevi Arg1 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_7400_ChoiceDesc2 = {
    Text = "[Ignore] Lascia"
  },
  Event_7400_Desc = {
    Text = "Il corvo si appollaia sulla testata del letto, osservandoti con i suoi occhi iniettati di sangue."
  },
  Event_7400_Name = {
    Text = "Corvo della Lanterna"
  },
  Event_7401_ChoiceDesc1 = {
    Text = "[I've Got No Wallet] Incidi 1 Orazione su 3"
  },
  Event_7401_ChoiceDesc2 = {
    Text = "[Rompere la rete] 1 Carta di comando casuale ottiene Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7401_Desc = {
    Text = [[
Una ragnatela giallo-arancio fluttua silenziosa nell'aria, i suoi radi fori assai meno intricati di quelli delle sue parenti tessitrici annidate lungo il muro.
Non riesci a resistere e allunghi la mano; la Fragile tela si dissolve all'istante, e risate di Fanciulli risuonano nelle tue orecchie.
"Oro, argento, giallo, rosso, tutti i Portafogli sono nostri!"]]
  },
  Event_7401_Name = {
    Text = "Rete Vagale"
  },
  Event_7402_ChoiceDesc1 = {
    Text = "[Repair the Telegraph] Incidi l'Orazione \"(EnchantConfig.Arg2)\" su una Carta di comando casuale, ma sviluppa \"(Skill.Arg1)\"."
  },
  Event_7402_ChoiceDesc2 = {
    Text = "[Bury the Telegraph] Incidi l'Orazione \"(EnchantConfig.Arg2)\" su una Carta di comando casuale, ma sviluppa \"(Skill.Arg1)\"."
  },
  Event_7402_ChoiceDesc3 = {
    Text = "[Ignore] Incidi l'Orazione [(EnchantConfig.Arg1)] su una Carta di comando casuale."
  },
  Event_7402_Desc = {
    Text = "Ti nascondi in una stretta fessura della caverna, trovando riparo temporaneo dalla tempesta di neve. Ma sai che non puoi restare qui a lungo. Se quelle figure in vesti nere ti trovano qui, non ci sarà nessuna via di fuga.\nIn un angolo della fessura, scopri un telegrafo danneggiato."
  },
  Event_7402_Name = {
    Text = "Eredità Antica"
  },
  Event_7403_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7403_Desc = {
    Text = "Hai visto simili ritratti in molti luoghi del regno.\n\"La Regina\" si erge al centro, raggiante tra rose nere.\nTranne per un dettaglio — il suo volto è stato crudelmente scavato via, lasciando un vuoto annerito e carbonizzato.\nA tutt'oggi, non riesci ancora a scorgere il vero volto della Regina."
  },
  Event_7403_Name = {
    Text = "Galleria dei Ritratti"
  },
  Event_7404_ChoiceDesc1 = {
    Text = "[Spare Her] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_7404_ChoiceDesc2 = {
    Text = "[Aiutarla] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_7404_ChoiceDesc3 = {
    Text = "[Walk My Own Path] Ricevi 50 Sigilli Neri"
  },
  Event_7404_Desc = {
    Text = "Tre figure scure ed effimere ti sbarrano la strada.\n\"Puoi lasciarla andare,\" dice quella che tiene un orsacchiotto grondante di D-melma, \"è solo timida, non malvagia. Non vuole fare del male a nessuno.\"\n\"Puoi aiutarla,\" dice quella che tiene un sacchetto di Caramelle splendidamente confezionato, \"puoi fare ciò che lei non può. Puoi porre fine a tutto questo.\"\n\"Non devi ascoltarci,\" dice quella con le mani vuote, \"hai il tuo cammino.\""
  },
  Event_7404_Name = {
    Text = "Sentieri Biforcati"
  },
  Event_7405_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7405_Desc = {
    Text = "La voce di Daffodil si interruppe per un istante.\n\"Oh, hai scelto questo? Un'ottima scelta. Come ricompensa, ti farò un regalo speciale.\"\n\"Non conosco bene quella bambina, ma ho una congettura riguardo a Francis. Credo che l'emozione che la domina e le conferisce il potere di 'vedere' sia un intenso rimorso. Mi chiedo quale scelta farà riguardo a questo rimorso...\""
  },
  Event_7405_Name = {
    Text = "Tempo suggerimento"
  },
  Event_74068_ChoiceDesc1 = {
    Text = "[Incorporate into Brain Vat] Mischiare [Vasca Cerebrale di Riserva] nel Mazzo di Pesca."
  },
  Event_74068_Desc = {
    Text = "All'interno dell'arco finemente scolpito, sul tetto inclinato della facciata in mattoni rossi e davanti alle case a schiera dalle pareti svuotate, ombre allungate danzano, anelando risposte alle domande.\nLa mediocrità equivale alla morte?\nAccontentarsi dello stato attuale è destinato a tradursi in un fuoco morente?"
  },
  Event_74068_Name = {
    Text = "Coscienza Non Ancora Perduta"
  },
  Event_74069_ChoiceDesc1 = {
    Text = "[Continue Containment] Scegli fino a 2 Carte di Comando da rimuovere dal mazzo e collocale nella [Vasca Cerebrale di Riserva]."
  },
  Event_74069_Desc = {
    Text = "\"Li ho visti. Molte persone, molti mormorii, saggi, superficiali, razionali, folli. A volte, una scintilla di speranza nasce persino dalle ceneri.\""
  },
  Event_74069_Name = {
    Text = "Coscienza Non Ancora Perduta"
  },
  Event_7406_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7406_Desc = {
    Text = "Sollevi con cura il roditore dalla bilancia. Il suo respiro è regolare, il corpicino peloso è caldo nel palmo della tua mano."
  },
  Event_7406_Name = {
    Text = "Ragione e sentimento"
  },
  Event_7407_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7407_Desc = {
    Text = [[
Il fioco Nucleo d'Argento esplode in uno splendore abbagliante, ma svanisce in un istante, lasciando nella mano solo cenere indistinguibile dal suolo.
Il Nucleo d'Argento, prosciugato della sua ultima Gnosi, non riesce a riforgiare un corpo per l'Anima sconosciuta, ma lascia una traccia della sua esistenza prima di dissolversi completamente.]]
  },
  Event_7407_Name = {
    Text = "Prova dell'Essere"
  },
  Event_7408_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7408_Desc = {
    Text = "『Non conosco quella bambina, ma ho un'ipotesi riguardo a Francis. Credo che l'emozione che l'ha controllata e le ha conferito il potere di 'vedere' sia un profondo rimpianto. Mi chiedo quale scelta farà a causa di questo rimpianto...』"
  },
  Event_7408_Name = {
    Text = "Tempo suggerimento"
  },
  Event_7409_ChoiceDesc1 = {
    Text = "[Pull The Paper] Distruggi una Carta"
  },
  Event_7409_ChoiceDesc2 = {
    Text = "[Not Now] Ottieni la Reliquia \"(RelicConfig.Arg1)\", ma sviluppi il Sintomo \"(Skill.Arg2)\"."
  },
  Event_7409_Desc = {
    Text = "La macchina da scrivere portatile dentro la tua valigia ha improvvisamente iniziato a battere da sola, producendo mezza pagina di testo storto prima che tu potessi accorgertene.\n\"Lo hai visto. È sempre stato accanto a te — quelle ombre contaminate dalla follia e dallo zelo... Non fissare direttamente i Suoi contorni.\""
  },
  Event_7409_Name = {
    Text = "Avvertimento non richiesto"
  },
  Event_7410_ChoiceDesc1 = {
    Text = "[Go Left] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando, ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_7410_ChoiceDesc2 = {
    Text = "[Go Right] Risveglia un Risvegliato, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_7410_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7410_Desc = {
    Text = "Sembra che tu sia entrato in un labirinto.\nSinistra, destra, ancora sinistra... Perdi gradualmente la pazienza, finché alzi lo sguardo e vedi l'occhio.\nL'occhio ti osserva con calma e maestosità, come se fosse il sovrano di questo luogo."
  },
  Event_7410_Name = {
    Text = "Labirinto di Occhi"
  },
  Event_7411_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7411_Desc = {
    Text = "Ritrai le mani con grande sforzo, udendo chiaramente il suono delle ossa che si spezzano.\nQuesto è il prezzo che paghi per la tua curiosità."
  },
  Event_7411_Name = {
    Text = "Impeto d'Ispirazione"
  },
  Event_7412_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7412_Desc = {
    Text = [[
Hai esaminato attentamente la fotocamera, la cui pelle e le finiture nero-oro emanavano una lucentezza elegante.
L'obiettivo era puntato su di te, come se scrutasse e spiasse...]]
  },
  Event_7412_Name = {
    Text = "Innocenza Registrata"
  },
  Event_7413_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7413_Desc = {
    Text = "Hai estratto senza pietà un'altra pellicola nascosta dentro la fotocamera, rivelando immagini che ti hanno lasciato senza parole.\nLa pellicola non sviluppata aveva fedelmente registrato— te, disteso in una pozza di fango nero."
  },
  Event_7413_Name = {
    Text = "Innocenza Registrata"
  },
  Event_74145_ChoiceDesc1 = {
    Text = "[Read] Distruggi una Carta di comando e ricevi 25 Sigilli Neri."
  },
  Event_74145_ChoiceDesc2 = {
    Text = "[Continue Typing] Duplica una Carta, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_74145_Desc = {
    Text = [[
La stampante sta vomitando inchiostro con violenza.
Inchiostro nero sgorga dall'ugello come un fantasma, riempiendo l'aria e formando una fitta, opprimente nebbia nera.
Sembra esserci un indizio nascosto nella tastiera, in attesa che dita innocenti lo sfiorino.]]
  },
  Event_74145_Name = {
    Text = "Inchiostro Spettrale"
  },
  Event_74146_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74146_Desc = {
    Text = "Ti addentri in un vicolo buio, la nebbia rode i tuoi vestiti, mentre le ombre alle tue spalle si scindono in innumerevoli paia di occhi. Il rintocco della campana arrugginita porta con sé un presagio umido.\n\nSai che tutti i sentieri tortuosi finiranno per collassare in un bozzolo di cicli — prima dell'alba putrida, ti ricongiungerai con il tuo stesso riflesso."
  },
  Event_74146_Name = {
    Text = "Ceneri del Tempo"
  },
  Event_74147_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74147_Desc = {
    Text = "In silenzio, tracci un segno sul petto, offrendo una preghiera muta per i defunti.\nIn questo mondo annientato, troppe cose sfuggono alla tua capacità di salvare.\nL'osso riluce, rivelando un barlume di un Tesoro segreto un tempo caro al suo proprietario ormai defunto."
  },
  Event_74147_Name = {
    Text = "Ossa Sbiadite"
  },
  Event_74148_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74148_Desc = {
    Text = "\"L'Onnipotente ricorda la tua misericordia. L'Onnipotente veglierà su di noi, riscattandoci dal peso della sofferenza.\"\n\nIl suo fantasma svanisce gradualmente, e il suono della musica sacra si trasforma nell'incessante ululare del vento."
  },
  Event_74148_Name = {
    Text = "Preghiera dell'Organo"
  },
  Event_74149_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74149_Desc = {
    Text = [[
Spingi delicatamente lo Scheletro esposto, che lentamente sprofonda nella melma nera, svanendo senza lasciare traccia.
Possa l'anima trovare pace nel nulla.]]
  },
  Event_74149_Name = {
    Text = "Ossa Sbiadite"
  },
  Event_7414_ChoiceDesc1 = {
    Text = "[Leave] Hai sconfitto l'avversario, e non è successo nulla."
  },
  Event_7414_Desc = {
    Text = [[
"Sembra che la piccola debba imparare a proprie spese che i segreti di una donna non si svelano tanto facilmente."
Mentre le parole di Daffodil svaniscono, un enorme mostro appare dinanzi a te.]]
  },
  Event_7414_Name = {
    Text = "Tempo suggerimento"
  },
  Event_74150_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74150_Desc = {
    Text = "Giocattoli così macabri non dovrebbero esistere nella torre dell'orologio dove si nasconde Jenkin; questo suono ha origine nella tua mente, nella tua memoria.\nRicordi le sensazioni che provasti quando eri un Cervello in una Vasca — le correnti elettriche convertite dalle onde sonore.\nQuello strano rumore diventa gradualmente normale e rassicurante, trasformandosi in una fluida melodia classica che si ripete incessantemente nella tua mente."
  },
  Event_74150_Name = {
    Text = "Echi del campanile"
  },
  Event_74151_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74151_Desc = {
    Text = "Quelli non sono gatti... sono i Fedeli della luce del tempio agitati.\nSotto il velo nero, odio e ostilità trasudano. I mormorii graffiano la tua coscienza, portando allucinazioni bizzarre e inspiegabili."
  },
  Event_74151_Name = {
    Text = "Mormorio Felino"
  },
  Event_74152_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74152_Desc = {
    Text = [[
Si aggrappano alle tue scarpe, ti afferrano la caviglia; sono avidi, sono affamati, e si sforzano di trascinarti nell'abisso in cui dimorano.
Lotti disperatamente per mantenere l'equilibrio, barcollando all'indietro di qualche passo in cerca di una via di fuga.
Involontariamente, qualcosa ti cade.]]
  },
  Event_74152_Name = {
    Text = "Riflesso dell'Incubo"
  },
  Event_74153_ChoiceDesc1 = {
    Text = "[Dodge] Incidi 1 Orazione su 3"
  },
  Event_74153_ChoiceDesc2 = {
    Text = "[Stop] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando, ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_74153_Desc = {
    Text = "Una scena familiare fa sobbalzare i tuoi nervi, contorcersi e ritrarsi nel terrore.\n\"Ancora una volta...\"\nL'Incubo spietato giunge, e un opprimente senso di impotenza ti sommerge.\nNon c'è davvero modo di riscrivere il suo destino?\nNon c'è tempo. All'interno del cranio fratturato di Sarah, una bocca gigantesca luccica d'argento, bramosa di spezzarti in due, di divorarti e masticarti."
  },
  Event_74153_Name = {
    Text = "Incubo Rinato"
  },
  Event_74154_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74154_Desc = {
    Text = [[
Odi sussurri inquietanti.

"Veniamo dalle montagne e dalle paludi di stelle lontane. I nostri corpi sono lo stoppino e il combustibile delle lanterne, e daremo fuoco alla legna della terra, illuminando il sentiero verso un nuovo mondo."]]
  },
  Event_74154_Name = {
    Text = "Mormorio Felino"
  },
  Event_74155_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74155_Desc = {
    Text = "Tramonto, campanile, uccelli in volo...\nLa ragazza si tolse la benda dall'occhio, e Lo Sguardo delle sue pupille grigie ti inchiodò sul posto.\nIllusioni, come Miraggi, svanirono non appena apparvero, eppure le inquietudini persistenti non potevano essere dissipate."
  },
  Event_74155_Name = {
    Text = "Benda Bianca"
  },
  Event_74156_ChoiceDesc1 = {
    Text = "[Pick Up] Acquisisci 1 Reliquia d'argento su 3"
  },
  Event_74156_ChoiceDesc2 = {
    Text = "[Recall] Ottieni le Reliquie d'argento \"(RelicConfig.Arg1)\", \"(RelicConfig.Arg2)\", stipula un Contratto due volte con \"(Skill.Arg3)\""
  },
  Event_74156_Desc = {
    Text = [[
Nella melma corrosa dell'angolo giace una piccola Benda Bianca.
Le Memorie ti stringono il cuore.]]
  },
  Event_74156_Name = {
    Text = "Benda Bianca"
  },
  Event_74157_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74157_Desc = {
    Text = "La mano trasparente scivola con grazia sui tasti bianchi e neri, eppure le onde sonore che produce sono frammentate, simili a un carillon discordante. Ogni nota emette un lamento dissonante, come un grido d'aiuto nell'angoscia.\nInfine, l'esecuzione si arresta bruscamente su un accordo inerme.\nCiò che non si è potuto ottenere in vita ora indugia in questo istante, lasciando dietro di sé un profondo senso di rimpianto."
  },
  Event_74157_Name = {
    Text = "Sonata del Rimpianto"
  },
  Event_74158_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74158_Desc = {
    Text = "\"Cara Sig.ra Sarah:\nCon la presente rassegno le mie dimissioni dalla posizione di assistente presso l'ospizio.\nNon posso più sostenere la vostra filosofia. I vostri insegnamenti sono fuorvianti; i bambini del Distretto Est non dovrebbero crescere sotto la vostra influenza, né dovrebbero credere nella pura bontà e nel dare disinteressato.\nUn giorno, usciranno da sotto le vostre ali per apprendere le regole di sopravvivenza del Distretto Est.\n.....\"\n\nIl resto della lettera è sfocato e illeggibile, macchiato da un liquido scuro."
  },
  Event_74158_Name = {
    Text = "Inchiostro Spettrale"
  },
  Event_74159_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74159_Desc = {
    Text = "\"Ciò che posso offrire ai fanciulli è solo un tetto per ripararli dalla pioggia e cibo appena sufficiente a non farli morire di fame. Se non fosse per il gentile Sig. Rogers che porta il dottore, non avrebbero nemmeno una pillola quando si ammalano.\nNon ho letto molti libri; assicurarmi che non muoiano di freddo o di fame per le strade è tutto ciò che posso fare.\nNon ho mai interferito con il tipo di persone che scelgono di diventare, ma devono sopravvivere.\n.....\""
  },
  Event_74159_Name = {
    Text = "Inchiostro Spettrale"
  },
  Event_7415_ChoiceDesc1 = {
    Text = "[Seek the Source] Ottieni la Reliquia d'Oro [(RelicConfig.Arg1)]"
  },
  Event_7415_ChoiceDesc2 = {
    Text = "[Discard Letter] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7415_ChoiceDesc3 = {
    Text = "[Check Letter] Ricevi 50 Sigilli Neri"
  },
  Event_7415_Desc = {
    Text = "Un'altra lettera cade ai tuoi piedi. La carta strappata ti riempie di terrore mentre la dispieghi.\n\"È tornato di nuovo. I miei avvertimenti non erano vani! @4 Tutto è iniziato qui e qui finirà.\"\n\"Voglio fuggire... Mi sono nascosto nell'armadio di legno, le mani che tremano senza controllo. Ma gli arti viscosi che battono sul pavimento si avvicinano... Ho udito un nome! È quello! @5!\""
  },
  Event_7415_Name = {
    Text = "Un'altra Lettera di Soccorso"
  },
  Event_74160_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74160_Desc = {
    Text = "\"Grazie. Il potere creativo dell'Onnipotente rimodellerà infine le nostre forme, portandoci luce e fiamma eterne.\n\nQuando raggiungerò la fine, offrirò benedizioni per te al cospetto dell'Onnipotente.\"\n\nIl suo fantasma svanisce gradualmente, e il suono della musica sacra si trasforma nell'incessante ululare del vento."
  },
  Event_74160_Name = {
    Text = "Preghiera dell'Organo"
  },
  Event_74161_ChoiceDesc1 = {
    Text = "[Bury] Distruggi una Carta di comando e recupera Arg2 PV. [ExDesc1]"
  },
  Event_74161_ChoiceDesc2 = {
    Text = "[Pray] Acquisisci la Reliquia d'oro \"(RelicConfig.Arg1),\" ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_74161_Desc = {
    Text = "Uno Scheletro pallido, per metà sommerso in una D-melma nero pece."
  },
  Event_74161_Name = {
    Text = "Ossa Sbiadite"
  },
  Event_74162_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74162_Desc = {
    Text = [[
Ti addentri dritto nella nebbia, i fantasmi si aggrappano al tuo corpo come una ragnatela, sensazioni gelide penetrano nelle ossa.
I loro sussurri si trasformano in frammenti di memoria, trafiggendoti il cuore.
Quando li oltrepassi, dietro di te non resta che illusione, e davanti, altre figure oscure si profilano nella nebbia fitta, in attesa di divorare.]]
  },
  Event_74162_Name = {
    Text = "Ceneri del Tempo"
  },
  Event_74163_ChoiceDesc1 = {
    Text = "[Avoid Phantasm] Acquisisci la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_74163_ChoiceDesc2 = {
    Text = "[Pass Through Phantasm] Acquisisci 1 delle 3 Reliquie d'oro, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_74163_ChoiceDesc3 = {
    Text = "[Leave] Acquisisci la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_74163_Desc = {
    Text = "La polvere giace fitta come una pesante cortina sulle strade, e ogni passo sembra come se stessi calpestando le ceneri del tempo.\nIn lontananza, due figure oscure si stagliano nella foschia, come fantasmi del passato, sussurrando racconti da tempo dimenticati.\nL'immaginazione in fuga evoca fantasmi terrificanti, contorti e striscianti, come presagi di sventura futura, che gravano pesantemente sul tuo respiro.\nSai che la strada davanti a te non farà che oscurarsi, eppure i tuoi passi non possono e non devono arrestarsi."
  },
  Event_74163_Name = {
    Text = "Ceneri del Tempo"
  },
  Event_74164_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74164_Desc = {
    Text = [[
Schivi per un soffio il primo feroce attacco di Sarah.
La prossima volta, potresti non essere altrettanto fortunato.]]
  },
  Event_74164_Name = {
    Text = "Incubo Rinato"
  },
  Event_74165_ChoiceDesc1 = {
    Text = "[Indicate Direction] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_74165_ChoiceDesc2 = {
    Text = "[Pray Together] Incidi 1 Orazione su 3"
  },
  Event_74165_Desc = {
    Text = "I suoni del pianoforte e dell'organo si intrecciano nel vento cupo. È come se melodie magiche fluttuassero per le strade deserte.\nUna suora senza nome prega tra le note.\n\"Le preghiere semplici non richiedono grandi cerimonie. Il Padre di Tutto seminerà speranza per noi, così come un tempo ci donò devoti insegnamenti.\""
  },
  Event_74165_Name = {
    Text = "Preghiera dell'Organo"
  },
  Event_74166_ChoiceDesc1 = {
    Text = "[Parry the Monster] Potenzia una Reliquia nella Reliquia dorata [(RelicConfig.Arg1)]"
  },
  Event_74166_ChoiceDesc2 = {
    Text = "[Pick Up Stars] Acquisisci la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_74166_ChoiceDesc3 = {
    Text = "[Ignore] Ricevi 25 Sigilli Neri"
  },
  Event_74166_Desc = {
    Text = "La pioggia di meteore si abbatte sulla torre dell'orologio.\nUn cristallo trasparente atterra ai tuoi piedi, creando una piccola cavità.\nSei ancora circondato da Entità Dissolte in varie forme, come ombre contorte. I suoni di ruggiti e ululati proseguono senza sosta.\nDecidi—"
  },
  Event_74166_Name = {
    Text = "Una Stella Caduta"
  },
  Event_74167_ChoiceDesc1 = {
    Text = "[Rub Your Eyes] Ricevi 50 Sigilli Neri"
  },
  Event_74167_ChoiceDesc2 = {
    Text = "[Close Your Eyes] Ricevi 75 Sigilli Neri, ma sviluppi il Sintomo [(Skill.Arg2)]"
  },
  Event_74167_Desc = {
    Text = "Uno sciame orrendo di gatti neri si raduna dietro Juliette, mormorando cantilene sconosciute ed emanando una minaccia segreta e malevola."
  },
  Event_74167_Name = {
    Text = "Mormorio Felino"
  },
  Event_74168_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74168_Desc = {
    Text = "Il tessuto economico è un po' ruvido al tatto, ma è stato comunque accuratamente pulito.\nPrenditene cura e attendi il giorno in cui verrà restituito al suo legittimo proprietario."
  },
  Event_74168_Name = {
    Text = "Benda Bianca"
  },
  Event_74169_ChoiceDesc1 = {
    Text = "[Maintain Distance] Ricevi 25 Sigilli Neri"
  },
  Event_74169_ChoiceDesc2 = {
    Text = "[Show Mercy] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_74169_Desc = {
    Text = [[
Sciamano da sotto i tuoi piedi.
Nei loro volti sfocati di dolore, vedi la tua ombra trascinata via.
Hai davvero il diritto di giudicarli?]]
  },
  Event_74169_Name = {
    Text = "Riflesso dell'Incubo"
  },
  Event_7416_ChoiceDesc1 = {
    Text = "[Discard Fragments] Possiede una reliquia speciale, infetta da Orazione: [(EnchantConfig.Arg1)] - Sintomo: Dissoluzione Follia"
  },
  Event_7416_ChoiceDesc2 = {
    Text = "[Complete the Fragments] Nessuna Reliquia speciale, infetta \"(Skill.Arg1)\", ottieni infezione \"(Skill.Arg2)\""
  },
  Event_7416_Desc = {
    Text = "Le membra pallide si contorcono lentamente davanti a voi. Si china, protendendo il braccio spezzato verso di voi. I suoi occhi, socchiusi dal dolore, traboccano di lacrime bianche, simili a gesso.\n\"Solo... un altro pezzo, e potrò...\""
  },
  Event_7416_Name = {
    Text = "Carne Riforgiata"
  },
  Event_74170_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74170_Desc = {
    Text = [[
Devi cercare di salvarli.
Ma non lasciarti assimilare da loro.]]
  },
  Event_74170_Name = {
    Text = "Riflesso dell'Incubo"
  },
  Event_74171_ChoiceDesc1 = {
    Text = "[Avert Gaze] Aumenta gli HP massimi di Arg1"
  },
  Event_74171_ChoiceDesc2 = {
    Text = "[Continuare a osservare] 1 Carta di comando casuale ottiene l'Orazione: \"(EnchantConfig.Arg1)\", infetta 1 \"(Skill.Arg2)\""
  },
  Event_74171_Desc = {
    Text = "\"La fine è giunta.\"\nIl tuo cuore si stringe e si contrae.\nIl tono sicuro di Juliette porta indubbiamente l'influenza di qualche potere ipnotico e telepatico.\nCosa distingue questa Juliette in questa dimensione da quella che conoscevi in passato?\nTroppi misteri, troppi ostacoli.\nLanci un'occhiata a Juliette, solo per scoprire che ti sta fissando intensamente."
  },
  Event_74171_Name = {
    Text = "Ultimo Sguardo"
  },
  Event_74172_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74172_Desc = {
    Text = "Alzi la mano per sfiorare goffamente i tasti illusori del pianoforte.\nI tasti risuonano e si intrecciano, ogni nota come una goccia di rugiada—limpida e trasparente. L'esecuzione sapiente e squisita non proviene dalle tue dita.\nIn uno stato di torpore, scorgi un paio di mani informi e affusolate che ricoprono le tue, muovendosi su e giù seguendo il flusso dell'esecuzione.\nIl tempo sembra congelarsi, finché l'ultima nota persistente del pianoforte non svanisce.\nOdi un sospiro di appagamento."
  },
  Event_74172_Name = {
    Text = "Sonata del Rimpianto"
  },
  Event_74173_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74173_Desc = {
    Text = "La coscienza che muta di continuo è instabile, e devi eliminare le distrazioni prive di senso.\nConcentri l'attenzione su Jenkin davanti a te, e il suono del Fonografo sfuma gradualmente, dissolvendosi nella nebbia."
  },
  Event_74173_Name = {
    Text = "Echi del campanile"
  },
  Event_74174_ChoiceDesc1 = {
    Text = "[Locate the Source] Acquisisci la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_74174_ChoiceDesc2 = {
    Text = "[Reminisce] Tutti i Risvegli ottengono 50 Aliemus, ma sviluppi [(Skill.Arg1)]."
  },
  Event_74174_ChoiceDesc3 = {
    Text = "[Ignore Noise] Incidi 1 Orazione su 3"
  },
  Event_74174_Desc = {
    Text = [[
Odi il suono di una Distorsione della puntina del Fonografo.
La puntina distorta scivola sui solchi a spirale danneggiati, producendo un tremito lento e agghiacciante.]]
  },
  Event_74174_Name = {
    Text = "Echi del campanile"
  },
  Event_74175_ChoiceDesc1 = {
    Text = "[Suonare per lui] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_74175_ChoiceDesc2 = {
    Text = "[Listening to the Strings] Ricevi 15 Sigilli Neri per ogni Risvegliato con 50 o più Aliemus."
  },
  Event_74175_ChoiceDesc3 = {
    Text = "[Leave] Incidi 1 Orazione su 3"
  },
  Event_74175_Desc = {
    Text = "\"Caro John:\nDi recente, mi sono improvvisamente reso conto che sono passati diversi anni dall'ultima volta che hai suonato il pianoforte per noi.\nQuest'anno ho 81 anni, e più invecchio, più custodisco gelosamente i ricordi della mia giovinezza.\nSe ricevi questa lettera, ti prego, fermati al mio appartamento la prossima volta che passi per Londinium e suona un brano per me.\""
  },
  Event_74175_Name = {
    Text = "Sonata del Rimpianto"
  },
  Event_74176_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74176_Desc = {
    Text = "Il Desiderio di sopravvivere vi ribolle nel petto, e impartite il comando senza esitazione.\nDopo aver sfondato l'assedio e voltandovi a guardare, quella stella è stata sommersa dalla D-melma.\nNel vortice della D-melma, un suono acuto e ritmico riecheggia.\nToccate la superficie della D-melma, e una stella decomposta vi cade nel palmo."
  },
  Event_74176_Name = {
    Text = "Una Stella Caduta"
  },
  Event_74177_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74177_Desc = {
    Text = [[
Raccogli la stella, ma essa ha perso la sua lucentezza nel tuo palmo.
Un'improvvisa ondata di oppressione ti travolge, facendoti correre un brivido lungo la schiena.
Nell'istante tra la vita e la morte, scarti di lato per schivare un attacco feroce, ma un graffio lungo due pollici resta comunque sul tuo braccio.]]
  },
  Event_74177_Name = {
    Text = "Una Stella Caduta"
  },
  Event_74178_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74178_Desc = {
    Text = [[
Le zanne aguzze celate nei Tentacoli ti lacerano la manica, e sangue caldo scorre lungo il polso come un rivolo cremisi.
Non riesci a leggere l'Espressione di Sarah, ma il cranio crepato emette un debole, tremante grido d'agonia.]]
  },
  Event_74178_Name = {
    Text = "Incubo Rinato"
  },
  Event_74179_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74179_Desc = {
    Text = "Vi guardate intorno, spostandovi a sinistra e a destra. Il suono è come un topo che gioca a nascondino con voi — a volte a sinistra, a volte a destra, ora lontano, ora vicino.\nVagate qua e là, ma il rumore si fa più forte. Lo stridio metallico acuisce il vostro disagio.\nD'impulso, vi toccate la tasca. Sebbene non troviate la fonte del suono, raccogliete un piccolo Tesoro segreto."
  },
  Event_74179_Name = {
    Text = "Echi del campanile"
  },
  Event_7417_ChoiceDesc1 = {
    Text = "[Leave] Perdi Arg1 PV e sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_7417_Desc = {
    Text = "\n\"Brava bambina. Ma devo comunque darti una piccola Punizione.\"\nLa lieve risata di Daffodil svanì nella Fenditura Dimensionale."
  },
  Event_7417_Name = {
    Text = "Tempo suggerimento"
  },
  Event_74180_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74180_Desc = {
    Text = [[
Distogli lo sguardo, evitando di incrociare i suoi occhi.
Eppure una forza ti fa ancora battere il cuore con ansia.]]
  },
  Event_74180_Name = {
    Text = "Ultimo Sguardo"
  },
  Event_74181_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74181_Desc = {
    Text = [[
Juliette incrocia il tuo sguardo.
L'istante dopo, esplode in un sorriso completamente folle, come a deridere la tua arroganza e ignoranza.
Tuttavia, il sorriso svanisce in un attimo, e gli altri non reagiscono... Sembra non essere altro che una tua allucinazione.]]
  },
  Event_74181_Name = {
    Text = "Ultimo Sguardo"
  },
  Event_7418_ChoiceDesc1 = {
    Text = "[Task Relic] Ottieni la Reliquia Dorata [(RelicConfig.Arg1)]"
  },
  Event_7418_ChoiceDesc2 = {
    Text = "[Task Relic 2, Obtain Golden Relic \"(RelicConfig.Arg1)\"]"
  },
  Event_7418_ChoiceDesc3 = {
    Text = "[1 random Command Card gains Orison: \"(EnchantConfig.Arg1)\"]"
  },
  Event_7418_Desc = {
    Text = "Evento 254 (In sviluppo), Effetto non definitivo"
  },
  Event_7418_Name = {
    Text = "Evento 254 (In sviluppo)"
  },
  Event_7419_ChoiceDesc1 = {
    Text = "[Submit Special Orison 1] Ottieni casualmente un'Orazione su 1 Carta di comando: [(EnchantConfig.Arg1)]"
  },
  Event_7419_ChoiceDesc2 = {
    Text = "[Submit Special Orison 2] Concedi casualmente un'Orazione a 1 Carta di comando: [(EnchantConfig.Arg1)]"
  },
  Event_7419_ChoiceDesc3 = {
    Text = "[Infection \"(Skill.Arg1)\" and \"(Skill.Arg2)\", Gain Golden Relic \"(RelicConfig.Arg3)\"]"
  },
  Event_7419_Desc = {
    Text = "Evento 255 (In sviluppo), Effetto non definitivo"
  },
  Event_7419_Name = {
    Text = "Evento 255 (In sviluppo)"
  },
  Event_7420_ChoiceDesc1 = {
    Text = "[Dodge Butterfly Card] Distruggi 2 Carte qualsiasi"
  },
  Event_7420_ChoiceDesc2 = {
    Text = "[Embrace the Butterfly] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7420_ChoiceDesc3 = {
    Text = "[Leave] Ricevi Arg1 Sigilli Neri"
  },
  Event_7420_Desc = {
    Text = "Angolo dopo angolo, l'inseguimento del Segugio infernale sembra non avere fine.\nCaviglie doloranti, un cervello pulsante—nel caos, vedi ancora una volta le farfalle. Sai che sono i deliri della Follia, i sussurri del Dominio. Arrivano svolazzando da ogni direzione."
  },
  Event_7420_Name = {
    Text = "Eruzione di Delirio"
  },
  Event_7421_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7421_Desc = {
    Text = "Premi delicatamente lo scacciapensieri. Tintinna sommessamente qualche volta prima di ammutolire. Si è già ritirato — per fare Ritorno solo negli Incubi."
  },
  Event_7421_Name = {
    Text = "Piccolo Carillon"
  },
  Event_7422_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7422_Desc = {
    Text = "Il rintocco risuona brevemente prima di spegnersi nel silenzio. Si è ritirato — per tornare soltanto negli incubi."
  },
  Event_7422_Name = {
    Text = "Piccolo Carillon"
  },
  Event_7423_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7423_Desc = {
    Text = "\"Niente male, sei molto cauto.\"\nAll'improvviso, una Voce Lontana giunse dai campanelli a vento.\n\"La cautela ti porterà una piccola ricompensa, ma nulla di più.\""
  },
  Event_7423_Name = {
    Text = "Piccolo Carillon"
  },
  Event_74245_ChoiceDesc1 = {
    Text = "[Leave] Acquisisci la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_74245_Desc = {
    Text = [[
Tric trac, i dadi danzano eccitati dentro il bicchiere, danzano fino allo sfinimento.

"Hai perso. Tuttavia, come ricompensa per avermi intrattenuto, puoi comunque ricevere un premio."]]
  },
  Event_74245_Name = {
    Text = "Messaggio di N"
  },
  Event_74246_ChoiceDesc1 = {
    Text = "[Shut the Gate] Incidi l'Orazione \"(EnchantConfig.Arg2)\" su una Carta di comando casuale, ma sviluppa \"(Skill.Arg1)\"."
  },
  Event_74246_ChoiceDesc2 = {
    Text = "[Flee in Panic] Incidi l'Orazione \"(EnchantConfig.Arg2)\" su una Carta di comando casuale, ma sviluppi \"(Skill.Arg1)\"."
  },
  Event_74246_ChoiceDesc3 = {
    Text = "[Ignore] Incidi l'Orazione [(EnchantConfig.Arg1)] su una Carta di comando casuale."
  },
  Event_74246_Desc = {
    Text = "Sei profondamente intrappolato in un labirinto costruito di vapore e ingranaggi, con tubi d'ottone che si attorcigliano come ragnatele sopra la tua testa. Ogni respiro agita la densa nebbia di olio meccanico.\nQuadranti meccanici fuori controllo fremono sulle pareti, le loro lancette graffiano le scale graduali sprigionando scintille sporadiche, simili a lucciole morenti in un laboratorio vittoriano. Le giunture dei rivetti trasudano ruggine di rame, simili alle Ferite purulente di questo gigante d'acciaio, e il tuo orologio da tasca si è fermato da tempo—qui, il tempo è soltanto la Preghiera di ingranaggi che si intrecciano."
  },
  Event_74246_Name = {
    Text = "Labirinto di Vapore"
  },
  Event_74247_ChoiceDesc1 = {
    Text = "[Take a Gamble] Sviluppa [(Skill.Arg1)] e tenta la sorte"
  },
  Event_74247_ChoiceDesc2 = {
    Text = "[Forget It] Ottieni 25 Sigilli Neri"
  },
  Event_74247_Desc = {
    Text = [[
Nella fitta nebbia nera all'angolo della strada, un'aura soffocante si diffonde.
Dalla nebbia emergono due dadi antichi e agghiaccianti, le cui superfici sono coperte di simboli imperscrutabili e motivi sinistri.
Giacciono silenziosamente sulle tavole viscide, come in attesa di un richiamo sconosciuto.
"Sai chi sono. Ti va di fare una scommessa?"]]
  },
  Event_74247_Name = {
    Text = "Messaggio di N"
  },
  Event_74248_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74248_Desc = {
    Text = "\"Ho sognato un cataclisma che spazzava via ogni cosa, annegando lo splendore del passato. Provo rabbia verso la vita e impotenza di fronte a un futuro privo di speranza. Il mio spirito è dilaniato dalla paura; in questo imminente crollo, possa tu restare vigile e impedire a questo terribile fato di compiersi.\""
  },
  Event_74248_Name = {
    Text = "Sussurro delle Ultime Parole"
  },
  Event_74249_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74249_Desc = {
    Text = [[
Il fumo nero freme nella disperazione.
Poi i dadi svaniscono in un batter d'occhio.

Solo una domanda persiste nella tua mente:
Di cosa sono fatti davvero questi dadi?]]
  },
  Event_74249_Name = {
    Text = "Messaggio di N"
  },
  Event_7424_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7424_Desc = {
    Text = "Ti volti e vedi un paio di scarpe di cuoio insieme a un riflesso umano sfocato.\nSembra essere un giovane gentiluomo.\n\"Scusi il disturbo, ma ha visto per caso un paio di scarpe Oxford nere?\"\n\"Ce n'è un paio proprio davanti a lei.\"\n\"No, no... Queste sono di pelle di capra, non di vacchetta.\nSono intrappolato in questo Museo delle Cere da dodici anni — devono essere le scarpe sbagliate...\"\nLa voce mormora, dissolvendosi a poco a poco."
  },
  Event_7424_Name = {Text = "Passi"},
  Event_74250_ChoiceDesc1 = {
    Text = "[Discern Man's Voice] Duplica 1 di 3 Carte di comando"
  },
  Event_74250_ChoiceDesc2 = {
    Text = "[Distinguere la voce della Donna] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_74250_ChoiceDesc3 = {
    Text = "[Discern the Elder's Voice] Ricevi 25 Sigilli Neri"
  },
  Event_74250_Desc = {
    Text = "Ti trovi da solo in una palude oscura.\nAttraverso la foschia, odi mormorii caotici sovrapporsi come maree—alcuni di anziani tremanti, alcuni di bambini che balbettano, alcuni di donne ansiose, e alcuni di uomini in preda a un terrore senza nome..."
  },
  Event_74250_Name = {
    Text = "Sussurro delle Ultime Parole"
  },
  Event_74251_ChoiceDesc1 = {
    Text = "[Advance] Distruggi 1 di 3 Carte di comando e ricevi 75 Sigilli Neri."
  },
  Event_74251_ChoiceDesc2 = {
    Text = "[Rest] Duplica 1 di 3 Carte di comando e ricevi 25 Sigilli Neri."
  },
  Event_74251_ChoiceDesc3 = {
    Text = "[Look Back] Ricevi 50 Sigilli Neri"
  },
  Event_74251_Desc = {
    Text = "Cammini per strade deserte, lasciando ad ogni passo impronte profonde nella cenere.\n\nLe vie della città sono come ragnatele, e tu sei una falena intrappolata in esse."
  },
  Event_74251_Name = {
    Text = "Città Cupa"
  },
  Event_74252_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74252_Desc = {
    Text = "Nel momento in cui il portone a vapore si chiuse con un rombo, udisti la tua ombra venire strappata centimetro dopo centimetro dagli ingranaggi che si incastravano."
  },
  Event_74252_Name = {
    Text = "Labirinto di Vapore"
  },
  Event_74253_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74253_Desc = {
    Text = "Scene ripetute continuano ad Aggiornarsi davanti ai tuoi occhi, e non hai via di fuga."
  },
  Event_74253_Name = {
    Text = "Labirinto di Vapore"
  },
  Event_74254_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74254_Desc = {
    Text = "Il tempo è una coordinata priva di significato; solo La Verità è ciò che aneli."
  },
  Event_74254_Name = {
    Text = "Labirinto di Vapore"
  },
  Event_74255_ChoiceDesc1 = {
    Text = "[Three Points]"
  },
  Event_74255_ChoiceDesc2 = {
    Text = "[Six Points]"
  },
  Event_74255_ChoiceDesc3 = {
    Text = "[One Point]"
  },
  Event_74255_Desc = {
    Text = "Chi oserebbe lanciare questi dadi portatori di sventura e follia?\nTu, sei tu.\nScegli—"
  },
  Event_74255_Name = {
    Text = "Messaggio di N"
  },
  Event_74256_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_74256_Desc = {
    Text = [[
Tric trac, i dadi danzano eccitati dentro il bicchiere, danzano fino allo sfinimento.

"Hai perso. Tuttavia, come ricompensa per avermi intrattenuto, puoi comunque ricevere un premio."]]
  },
  Event_74256_Name = {
    Text = "Messaggio di N"
  },
  Event_74257_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74257_Desc = {
    Text = "Il viaggio è avvolto in un'oscurità senza fine e un caos sconfinato.\nNon c'è tempo per contemplare il tuo destino. Devi dissipare la paura e raggiungere la tua destinazione prima che il giudizio finale discenda."
  },
  Event_74257_Name = {
    Text = "Città Cupa"
  },
  Event_74258_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74258_Desc = {
    Text = "\"Mentre siedo nell'ombra degli anni, sentendo la mano gelida della morte avvicinarsi, il mondo esterno si fa sempre più cupo, colmo di sussurri di calamità. Temo il giudizio imminente, la resa dei conti per la nostra follia. Le strade sono pervase da un'aura minacciosa; temo che il nostro Giorno del Giudizio si avvicini rapidamente. La nostra civiltà vacilla sull'orlo del baratro, come se stesse per essere divorata dalla Distruzione, intrappolata dalla nostra stolta Arroganza.\""
  },
  Event_74258_Name = {
    Text = "Sussurro delle Ultime Parole"
  },
  Event_74259_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74259_Desc = {
    Text = "Essere sfuggiti alla morte è già un'impresa rara; non dovresti chiedere di più.\nLe ombre di resti infranti e rovine ti chiamano ancora."
  },
  Event_74259_Name = {
    Text = "Città Cupa"
  },
  Event_7425_ChoiceDesc1 = {
    Text = "[Leave] Incidi 1 Orazione su 3"
  },
  Event_7425_Desc = {
    Text = [[
"Davvero... molto interessante."
Ripiega il questionario e ti indica la direzione in cui sono andati i fanciulli. Ti allontani in fretta, quasi perdendoti il sussurro alle tue spalle.
"Non vedo l'ora che ci rincontreremo."]]
  },
  Event_7425_Name = {
    Text = "Valutazione Psicologica"
  },
  Event_74260_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74260_Desc = {
    Text = "Sei sotto il controllo di un grande potere o di un destino possente.\nUn breve riposo non può cambiare questa situazione, ma può almeno dare alle tue gambe stanche la forza per continuare a muoversi."
  },
  Event_74260_Name = {
    Text = "Città Cupa"
  },
  Event_74261_ChoiceDesc1 = {Text = "[Leave]"},
  Event_74261_Desc = {
    Text = "\"...La città non è più un rifugio caldo, ma una tomba nascosta, che nutre terrore e disperazione. Quei sogni un tempo vividi ora restano come schegge di paura. Non posso più fingere di essere impavido; il mondo davanti a me è come un Incubo dal quale non riesco a risvegliarmi.\""
  },
  Event_74261_Name = {
    Text = "Sussurro delle Ultime Parole"
  },
  Event_74262_ChoiceDesc1 = {
    Text = "[Leave] Ottieni la Reliquia d'Oro [(RelicConfig.Arg1)]"
  },
  Event_74262_Desc = {
    Text = [[
Tric trac, i dadi danzano eccitati dentro il bicchiere, danzano fino allo sfinimento.

"Hai perso. Tuttavia, come ricompensa per avermi intrattenuto, puoi comunque ricevere un premio."]]
  },
  Event_74262_Name = {
    Text = "Messaggio di N"
  },
  Event_7426_ChoiceDesc1 = {
    Text = "[Leave] Incidi l'Orazione [Riflesso] su una Carta di comando casuale."
  },
  Event_7426_Desc = {
    Text = "\"Va tutto bene, ho già visto la risposta nei tuoi occhi. Ho alcune commissioni da sbrigare, quindi mi congedo per ora. Anche tu hai delle faccende da sbrigare, non è vero? Guarda, qualcuno sta venendo a cercarti.\"\nTi volti, e una figura della Chiesa dei Portatori di Luce appare in fondo alla strada."
  },
  Event_7426_Name = {
    Text = "Compagno di viaggio insolito V"
  },
  Event_7427_ChoiceDesc1 = {
    Text = "[Leave] Incidi l'Orazione [Calcolo] su una Carta di comando casuale."
  },
  Event_7427_Desc = {
    Text = "\"Sembra che non siate disposti ad aprirvi con me. Sono deluso, ma non importa. Vi offrirò comunque un gentile suggerimento: cosa cerca qui la Chiesa dei Portatori di Luce?\"\n\"Oh, pare che qualcuno non voglia che chiacchieriamo. Guardate laggiù — qualcuno sta venendo per voi.\"\nVi voltate, e le sagome dei Devoti del Portatore di Luce appaiono in fondo alla strada."
  },
  Event_7427_Name = {
    Text = "Compagno di viaggio insolito V"
  },
  Event_7428_ChoiceDesc1 = {
    Text = "[Leave] Incidi l'Orazione [Intuizione] su una Carta di comando casuale."
  },
  Event_7428_Desc = {
    Text = "\"Sei onesto, e questo merita una ricompensa. Quindi, ecco un indizio: perché Lui ti ha preso di mira subito dopo il tuo arrivo alla Cittadina di Rye?\"\n\"Ops, sembra che qualcuno non voglia che chiacchieriamo. Guarda, qualcuno sta venendo a prenderti.\"\nTi volti e vedi i Devoti del Portatore di Luce in fondo alla strada."
  },
  Event_7428_Name = {
    Text = "Compagno di viaggio insolito V"
  },
  Event_7429_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7429_Desc = {
    Text = "I suoni caotici svaniscono gradualmente, le tue mani sono vuote, ma le emozioni fugaci sono già state registrate dalla chiave d'argento"
  },
  Event_7429_Name = {
    Text = "Libro del Nulla"
  },
  Event_7430_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7430_Desc = {
    Text = "Tendi la mano nel caos, afferrando qualcosa dalla consistenza insolita che gradualmente prende forma nella tua mano."
  },
  Event_7430_Name = {
    Text = "Libro del Nulla"
  },
  Event_7431_ChoiceDesc1 = {
    Text = "[Andarsene] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7431_Desc = {
    Text = "\"Avete mai sentito parlare del metodo di caccia dei serpenti? I serpenti possono solo strisciare al suolo e ondeggiare, perciò non possono inseguire la preda con scatti di velocità come un ghepardo, né circondare la preda come un branco di lupi. I serpenti, invece, hanno imparato ad attendere pazientemente.\"\n\"Attendono l'istante in cui la preda abbassa la Guardia, poi colpiscono all'improvviso, ingoiandola in un solo Morso.\""
  },
  Event_7431_Name = {
    Text = "Compagno di viaggio insolito III"
  },
  Event_7432_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7432_Desc = {
    Text = "Spaventato, il gatto nero dal pelo lucido lascia una sensazione bruciante sui tuoi polpastrelli prima di svanire nelle profondità della nebbia."
  },
  Event_7432_Name = {
    Text = "Flagello del Gatto Notturno"
  },
  Event_7433_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7433_Desc = {
    Text = "Solo gli assurdi sogni di quegli stolti credenti nella follia."
  },
  Event_7433_Name = {
    Text = "Editto Cifrato: Parte II"
  },
  Event_7434_ChoiceDesc1 = {
    Text = "[Keep Eavesdropping] Incidi 1 Orazione su 3"
  },
  Event_7434_ChoiceDesc2 = {
    Text = "[Cough Loudly] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando, ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7434_Desc = {
    Text = "\nL'angolo del muro si crepò, aprendosi in molte sottili Fessure, che si diramavano come vasi sanguigni.\nAccompagnato da un debole ronzio, odi una voce maschile profonda provenire dall'altro lato.\n\"Distretto Quentin 5, Distretto Wellington 10, Distretto Norman 15...\nTutti i materiali di questo mese sono stati caricati, pronti per la spedizione, numero di carico I-0234...\n.....\nInoltre, grazie a quella gente di Mythag, il Distretto di Whitechapel è attualmente sotto legge marziale, e abbiamo perso la nostra più grande fonte di materiali.\""
  },
  Event_7434_Name = {
    Text = "Orecchio indiscreto"
  },
  Event_7435_ChoiceDesc1 = {
    Text = "[Chase the Crows] Ricevi 20 Sigilli Neri, ma sviluppa [(Skill.Arg2)]"
  },
  Event_7435_ChoiceDesc2 = {
    Text = "[Continue chasing the child] Parti"
  },
  Event_7435_Desc = {
    Text = "Al tuo sussulto, tutti i corvi si sono involati in ogni direzione con un frullo d'ali, le loro piume nere cadenti si sono sciolte in melma, gocciolando fino a formare la sagoma del Sigillo Nero."
  },
  Event_7435_Name = {
    Text = "Sguardo del Corvo"
  },
  Event_7436_ChoiceDesc1 = {
    Text = "[Give Up Resistance] Distruggi una Carta di comando e ricevi Arg1 Sigilli Neri."
  },
  Event_7436_ChoiceDesc2 = {
    Text = "[Pull Back Hands]"
  },
  Event_7436_Desc = {
    Text = "Una nuova macchina da scrivere.\nHa un set di tasti unico, intricato ed elegante come un microscopio.\nPoni le mani su di essa per curiosità, solo per scoprire che volano incontrollabilmente sulla tastiera, sempre più veloci..."
  },
  Event_7436_Name = {
    Text = "Impeto d'Ispirazione"
  },
  Event_7437_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7437_Desc = {
    Text = [[
Solo una creatura in affanno che cerca un pezzo di legno alla deriva su cui riposare...
Sospiri mentre il fluido nero dalla coda della farfalla ti gocciola sulla guancia.]]
  },
  Event_7437_Name = {
    Text = "Lepidotteri d'Ossidiana"
  },
  Event_7438_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7438_Desc = {
    Text = "Hai accettato una richiesta di contatto dalla scuola. La voce familiare calma la tua mente. Raccogli le forze e prosegui."
  },
  Event_7438_Name = {Text = "Crocevia"},
  Event_7439_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7439_Desc = {
    Text = "Hai accettato una richiesta di contatto dalla scuola. La voce familiare calma la tua mente. Raccogli le forze e prosegui."
  },
  Event_7439_Name = {Text = "Crocevia"},
  Event_7440_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7440_Desc = {
    Text = "I tuoi dubbi restano sospesi nell'aria, senza risposta. Una calda luce gialla filtra dalla finestra, confortante come le memorie."
  },
  Event_7440_Name = {
    Text = "Memoria Vulcanica"
  },
  Event_7441_ChoiceDesc1 = {
    Text = "[Pick Up] Ottieni la Reliquia d'Argento \"(RelicConfig.Arg2)\", ma sviluppi \"(Skill.Arg1)\"."
  },
  Event_7441_ChoiceDesc2 = {
    Text = "[Hesitate] Ricevi 25 Sigilli Neri"
  },
  Event_7441_Desc = {
    Text = "In una botte di legno all'angolo del vicolo, un oggetto dal colore insolito galleggia. Il suo aspetto singolare sembra avvertirti: \"Non toccare\"."
  },
  Event_7441_Name = {
    Text = "Relitti nel Barile"
  },
  Event_7442_ChoiceDesc1 = {
    Text = "[Leave It to Her] Ottieni 1 di 3 Reliquie d'argento"
  },
  Event_7442_ChoiceDesc2 = {
    Text = "[Interesting Situation] Ottieni le Reliquie d'Argento \"(RelicConfig.Arg1)\" e \"(RelicConfig.Arg2)\", ma sviluppa \"(Skill.Arg3)\" due volte."
  },
  Event_7442_Desc = {
    Text = "\"Questa è una comunicazione da Mythag. Sono Erica. Rilevate fluttuazioni anomale dell'Indice di Gnosi nel Risvegliato Lotan. Necessitate di supporto?\""
  },
  Event_7442_Name = {
    Text = "Comunicazione di supporto"
  },
  Event_7443_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7443_Desc = {
    Text = "Hai ceduto ai sussurri malevoli nel tuo orecchio. Un dolore lacerante, acuto come un ago, si torce in profondità nel tuo cranio.\n\n\"Smettila—ti prego smettila—ho fatto quello che chiedevi—falla smettere—\"\n\nTi stringi la testa in agonia, sentendo solo la risata beffarda e lontana dei corvi."
  },
  Event_7443_Name = {
    Text = "Canto dei Corvi"
  },
  Event_7444_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7444_Desc = {
    Text = "Posto qui, potrebbe trattarsi di una delle due possibilità: qualcosa di trascurato o qualcosa di caro. Se è quest'ultimo caso, è meglio lasciarlo al suo proprietario."
  },
  Event_7444_Name = {
    Text = "Nucleo d'Argento Solitario"
  },
  Event_7445_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7445_Desc = {
    Text = "I più felici sono coloro che ignorano."
  },
  Event_7445_Name = {Text = "Sbircia"},
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
    Text = "Vediamo cosa si può generare."
  },
  Event_7446_Name = {
    Text = "[To Be Packaged]"
  },
  Event_7447_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7447_Desc = {
    Text = "\"Calmati,\" Ramona ti dà un colpetto sulla testa, \"sono solo frammenti del passato. Non so chi li abbia lasciati in questo passaggio dimensionale.\"\nIn effetti, c'è un profumo nostalgico."
  },
  Event_7447_Name = {
    Text = "Frammento di Ricordi: Whiskey"
  },
  Event_7448_ChoiceDesc1 = {
    Text = "[Collect] Potenzia una Reliquia d'argento nella Reliquia d'oro [(RelicConfig.Arg1)]"
  },
  Event_7448_ChoiceDesc2 = {
    Text = "[Throw Them Away] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\" e \"(Skill.Arg3)\"."
  },
  Event_7448_ChoiceDesc3 = {
    Text = "[Observe Carefully] Ricevi 25 Sigilli Neri"
  },
  Event_7448_Desc = {
    Text = "Ci sono molti Argenti frantumati qui.\nOpachi, rotti... chiaramente non Beni di pregio.\nForse sono una delle ragioni per cui queste sculture di cera possono \"prendere vita.\"\nPersino l'Argento più grezzo ha il potenziale di creare Miracoli"
  },
  Event_7448_Name = {
    Text = "Anima Incatenata"
  },
  Event_7449_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_7449_Desc = {
    Text = "Koum ha dato tutto ciò che poteva.\nOra tocca a te assicurarti che il suo sacrificio non sia stato vano."
  },
  Event_7449_Name = {
    Text = "Calore Residuo"
  },
  Event_7450_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7450_Desc = {
    Text = "Possano il vento e la neve concederti eterna tranquillità."
  },
  Event_7450_Name = {
    Text = "Eredità Antica"
  },
  Event_7451_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7451_Desc = {
    Text = "Rimanete saldi, recitando la cantilena restando fedeli a voi stessi.\nNon vi fidate dei sussurri nelle vostre orecchie, affidandovi unicamente alla ragione umana.\nTuttavia... quando il terreno solido su cui fate affidamento viene inghiottito da una densa melma nera, cavarvi gli occhi per usarli come strumenti di osservazione sarà la vostra unica scelta nei vostri ultimi istanti."
  },
  Event_7451_Name = {
    Text = "Canto dei Corvi"
  },
  Event_7452_ChoiceDesc1 = {
    Text = "[Leave] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7452_Desc = {
    Text = "Koum è stata tirata via da te, schivando per un soffio un colpo. Ti ha rivolto un cenno di gratitudine e si è lanciata di nuovo contro il soggetto sperimentale."
  },
  Event_7452_Name = {Text = "Arena"},
  Event_7453_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7453_Desc = {
    Text = "Din din...\nLe monete tintinnano nel portafoglio, producendo un suono nitido e piacevole.\nIl portafoglio mastica soddisfatto e lascia sfuggire un rutto.\nCommosso dalla tua generosità, abbassa completamente la guardia.\nOra è ai tuoi ordini."
  },
  Event_7453_Name = {
    Text = "Borsa Golosa"
  },
  Event_7454_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7454_Desc = {
    Text = [[
Una moneta di ottone cadde nell'abisso senza fondo, senza emettere alcun suono.
Hai atteso pazientemente per cinque minuti. Il portafoglio gemette di dolore, sputando infine una pozza di melma nera.
Questa era la sua silenziosa protesta.]]
  },
  Event_7454_Name = {
    Text = "Borsa Golosa"
  },
  Event_7455_ChoiceDesc1 = {
    Text = "[Look into the Distance]"
  },
  Event_7455_ChoiceDesc2 = {
    Text = "[Listen Carefully]"
  },
  Event_7455_Desc = {
    Text = "Celeste scuote la bussola che tiene in mano. Non parla, eppure un canto flebile riecheggia intorno a lei.\nQui, i canti dei marinai si intrecciano e si sovrappongono attraverso il tempo, uno shanty caotico eppure possente che ti guida e dirige il tuo sguardo verso l'altra estremità della nave."
  },
  Event_7455_Name = {Text = "Shanty"},
  Event_7456_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7456_Desc = {
    Text = "Intervieni e interrompi la piccola sessione di esercitazione.\nDalla posizione delle dita alla teoria musicale di base, critichi ogni dettaglio senza pietà.\nLa musica si interrompe bruscamente, e sia il ragazzo che l'insegnante si voltano verso di te con lo stesso inquietante sorriso.\n133, 355, 244...\nIl pianoforte riprende a suonare, ancora orribilmente stonato.\nA quanto pare, non riescono a sentire nulla."
  },
  Event_7456_Name = {
    Text = "Lezione di pianoforte"
  },
  Event_7457_ChoiceDesc1 = {Text = "[Take It]"},
  Event_7457_Desc = {
    Text = "Un marchio nero trovato nel Dominio può essere sacrificato al D-Mark in cambio di Reliquie o altre proiezioni spirituali. Si dissolverà presto in una melma nera dopo aver lasciato l'area corrente."
  },
  Event_7457_Name = {
    Text = "Sigillo Nero"
  },
  Event_7458_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7458_Desc = {
    Text = "Trovare quella persona misteriosa è più importante in questo momento. Con questo pensiero, Ramona se ne andò in fretta."
  },
  Event_7458_Name = {
    Text = "Orecchie Altrui"
  },
  Event_7459_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7459_Desc = {
    Text = [[
Abbandonati alla coscienza, sprofondando nel Mare profondo seguendo Il Sentiero delle Preghiere.
Vedi il paese dorato inabissato sul fondale, vedi le sculture di pietra immortali, e infine affronti gli occhi tremolanti nelle ombre...
"Coloro che non hanno versato sangue divino... andatevene, andatevene."]]
  },
  Event_7459_Name = {
    Text = "Preghiera Onirica"
  },
  Event_7460_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 1 di 3 Reliquie maledette, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_7460_Desc = {
    Text = "Ramona trafisse la gola del soggetto sperimentale con un singolo Affondo. Koum gettò via il corpo esanime e si lanciò verso il bersaglio successivo."
  },
  Event_7460_Name = {Text = "Arena"},
  Event_7461_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7461_Desc = {
    Text = [[
Il corvo si strappa le piume, proprio come gli esseri umani si mordono il proprio corpo.
In questo mondo di paura, scene simili sono comuni. Non puoi salvare tutti gli esseri viventi.]]
  },
  Event_7461_Name = {
    Text = "Lacrima di Magma"
  },
  Event_7462_ChoiceDesc1 = {
    Text = "[Soothe Koum]"
  },
  Event_7462_ChoiceDesc2 = {
    Text = "[Shout for Koum]"
  },
  Event_7462_Desc = {
    Text = "L'enorme bestia ruggisce disperatamente verso la piccola figura, tentando di risvegliare i suoi antichi compagni. Tuttavia, le sue corde vocali danneggiate riescono a emettere soltanto bassi e strani ringhi."
  },
  Event_7462_Name = {
    Text = "Richiamo dell'Amicizia"
  },
  Event_7463_ChoiceDesc1 = {
    Text = "[Leave] Cerca il Riflettore"
  },
  Event_7463_ChoiceDesc2 = {
    Text = "[Break into Mist] Perde Arg2 HP"
  },
  Event_7463_Desc = {
    Text = "Davanti a te si stende una fitta nebbia nera; addentrarsi avventatamente porterà sciagura.\nForse dovresti trovare un \"Riflettore\" per disperdere la nebbia."
  },
  Event_7463_Name = {Text = "???"},
  Event_7464_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7464_Desc = {
    Text = "\"Una mascella che scricchiola come la tua? Non ho mai visto nulla di simile in vita mia.\"\nHai rifiutato la sgarbata richiesta del Signor Mascella. Il Signor Mascella ne fu estremamente deluso, ma riuscì a mantenere la Compostezza.\nPer ringraziarti del tuo paziente ascolto, ti ha fatto un piccolo dono."
  },
  Event_7464_Name = {
    Text = "Scricchiolio"
  },
  Event_7465_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7465_Desc = {
    Text = "Hai acconsentito a questa bizzarra richiesta e hai portato con te il Signor Mandibola.\nRiposa nella tua tasca, schioccando incessantemente. Secondo la traduzione del tuo compagno, le sue parole esprimono per lo più gratitudine, nostalgia e rimpianto.\nQuanto al perché sia finito così? Il Signor Mandibola non vuole dilungarsi, dice soltanto:\n\"Lo sai. Quando fissi l'abisso di @2, @2 ricambia il tuo sguardo.\""
  },
  Event_7465_Name = {
    Text = "Scricchiolio"
  },
  Event_7466_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7466_Desc = {
    Text = "È scivolato nella tua borsa come un pezzo di seta, il lieve aumento di peso appena percettibile, come se sussurrasse un sommesso ringraziamento.\nDopo di che, tutto fu silenzio."
  },
  Event_7466_Name = {
    Text = "Spirito del Caos"
  },
  Event_7467_ChoiceDesc1 = {Text = "[Advance]"},
  Event_7467_Desc = {
    Text = [[
Clic.
Inserisci la chiave nella serratura e spingi delicatamente la porta aperta.
L'intero processo fila liscio, rafforzando la tua fiducia per l'indagine che ti attende.]]
  },
  Event_7467_Name = {
    Text = "Porta arrugginita"
  },
  Event_7468_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7468_Desc = {
    Text = "La voce ridacchiò profondamente, e increspature si formarono nel liquido ai tuoi piedi.\n\"Presto ti renderai conto che non c'è nulla che tu debba fare, se non affrontare la morte.\""
  },
  Event_7468_Name = {
    Text = "Ciò che Non Dovresti Cercare"
  },
  Event_7469_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7469_Desc = {
    Text = "Scarti questa Memoria, strappando la tua coscienza dal conforto illusorio."
  },
  Event_7469_Name = {
    Text = "Abbraccio del Passato"
  },
  Event_7470_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7470_Desc = {
    Text = "Solo un breve dormiveglia. Senza conforto, come potrai sopportare questa notte senza fine...?"
  },
  Event_7470_Name = {
    Text = "Abbraccio del Passato"
  },
  Event_7471_ChoiceDesc1 = {
    Text = "[Pick up the Photo] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7471_Desc = {
    Text = "È una foto di gruppo.\nPersone abbattute accovacciate dietro sbarre di ferro, i volti colmi di sofferenza.\nUna foto cattura il tuo sguardo. È una giovane donna esile, il viso inespressivo.\nEscrescenze blasfeme si intrecciano attorno al suo corpo.\nNon riesci a vederne il volto, ma immagini che sarebbe priva di espressione."
  },
  Event_7471_Name = {
    Text = "Verbale Fedele"
  },
  Event_7472_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7472_Desc = {
    Text = "Quelle sono le spoglie dell'uccello."
  },
  Event_7472_Name = {
    Text = "Stormo di Corvi Frenetici"
  },
  Event_7473_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7473_Desc = {
    Text = "Hai rifiutato freddamente la richiesta del pianista.\nIl pianista, profondamente deluso, si strappò l'altro orecchio e li gettò entrambi dalla finestra.\n\"Tanto non mi servono.\"\nIl pianista malinconico, con le lacrime che gli rigavano il volto, suonò una serie di note strazianti."
  },
  Event_7473_Name = {
    Text = "Ascolta attentamente"
  },
  Event_7474_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7474_Desc = {
    Text = "Le grida dello Spirito del Caos si fecero più acute, trasformandosi infine in un urlo lacerante che riecheggiò tutt'intorno.\nCon le tue offerte e un dolore ineluttabile, Esso sprofondò nuovamente nella melma."
  },
  Event_7474_Name = {
    Text = "Spirito del Caos"
  },
  Event_7475_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7475_Desc = {
    Text = "Questo è un Passaggio Unidirezionale; non puoi tornare all'ingresso attraverso di esso."
  },
  Event_7475_Name = {Text = "Passaggio"},
  Event_7476_ChoiceDesc1 = {
    Text = "[Leave] Ottieni la Reliquia \"(RelicConfig.Arg1)\", ma sviluppi il Sintomo \"(Skill.Arg2)\"."
  },
  Event_7476_Desc = {
    Text = "\"Bene allora, chiudi gli occhi e percepisci in silenzio il suono dei suoi Passi che si avvicinano.\"\nSeguendo il consiglio, hai chiuso gli occhi. In un istante, un sinistro respiro bestiale ti è rimbombato nelle orecchie.\nQuando hai riaperto gli occhi sotto shock, l'uomo di prima era già svanito."
  },
  Event_7476_Name = {
    Text = "Compagno di viaggio insolito I"
  },
  Event_7477_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7477_Desc = {
    Text = "\"È davvero un peccato.\"\nL'uomo si sistemò gli occhiali, la voce bassa.\n\"Tuttavia, se non ne avete sentito parlare, perché venire qui a quest'ora della notte?\"\nSenza attendere risposta, si fece da parte."
  },
  Event_7477_Name = {
    Text = "Compagno di viaggio insolito I"
  },
  Event_7478_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7478_Desc = {
    Text = "Avanzi con passi tenaci.\nUn passo, due passi, tre passi...\nI passi alle tue spalle svaniscono nell'oscurità.\nVi incontrerete di nuovo."
  },
  Event_7478_Name = {Text = "Oxford"},
  Event_7479_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7479_Desc = {
    Text = "Vi inchinate leggermente, sollevando il vassoio dal tavolo accanto a voi, trasformandovi nella Guardia della Principessa.\nQuanto a chi è diventata la fortunata Principessa — è stata, naturalmente, la vostra compagna più leale.\n\"Versami ancora il tè in faccia, e puoi scordarti gli appunti del mese prossimo.\"\nQuesto è l'avvertimento della Principessa per voi."
  },
  Event_7479_Name = {
    Text = "Travestimento perfetto"
  },
  Event_7480_ChoiceDesc1 = {
    Text = "[Listening Quietly] Potenzia la qualità dell'Orazione di una carta casuale."
  },
  Event_7480_ChoiceDesc2 = {
    Text = "[Lei è proprio Lei] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7480_Desc = {
    Text = [[
Le urla di Sarah riecheggiano nella tua mente. Una debole, familiare voce emerge dal nulla, sussurrando flebilmente "Sorella Sasha," "Sorella Sasha."
"Sorella Sasha, dove sei?"]]
  },
  Event_7480_Name = {
    Text = "\"Sorella Sasha\""
  },
  Event_7481_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7481_Desc = {
    Text = "\"...Non posso dire che non ci sia del vero in questo, ma il solo desiderio non risolverà il tuo problema con l'Entità Dissolta. Facciamo qualcosa di concreto.\""
  },
  Event_7481_Name = {
    Text = "Regola di Rogues"
  },
  Event_7482_ChoiceDesc1 = {
    Text = "[Tune] Ricevi 100 Sigilli Neri"
  },
  Event_7482_ChoiceDesc2 = {
    Text = "[2 Carte di comando casuali ottengono l'Orazione: \"(EnchantConfig.Arg1)\"]"
  },
  Event_7482_Desc = {
    Text = "Le reliquie formate dalla Gnosi stabilizzata possono forse generare melodie armoniose."
  },
  Event_7482_Name = {Text = "Dissonanza"},
  Event_7483_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7483_Desc = {
    Text = "\"È un frammento di memoria di qualcuno che è entrato in questa dimensione,\" rispose Ramona, \"È facile imbattersi in questo mentre si attraversano le dimensioni. Fai attenzione a non confonderlo con le tue memorie.\""
  },
  Event_7483_Name = {
    Text = "Frammento di Ricordi: Whiskey"
  },
  Event_7484_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7484_Desc = {
    Text = "Segui il ritmo del battito cardiaco e insegui il Bagliore. Non sarete separati, così come nessuno può distinguere con precisione il giorno dalla notte."
  },
  Event_7484_Name = {
    Text = "Atrio Sinistro"
  },
  Event_7485_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7485_Desc = {
    Text = [[
Continui ad accarezzare quelle mani irrequiete, cercando di calmarle.
In un istante, il tuo mondo diventa completamente silenzioso.
L'amore porta sempre la sua ricompensa.]]
  },
  Event_7485_Name = {
    Text = "Palude Cupa"
  },
  Event_7486_ChoiceDesc1 = {
    Text = "[Struggle] Ottieni la Reliquia d'argento \"(RelicConfig.Arg2)\", ma sviluppi \"(Skill.Arg1)\"."
  },
  Event_7486_ChoiceDesc2 = {
    Text = "[Give Up] Ottieni la Reliquia d'argento \"(RelicConfig.Arg2)\", ma sviluppi \"(Skill.Arg1)\"."
  },
  Event_7486_ChoiceDesc3 = {
    Text = "[Be Wary] Ricevi 25 Sigilli Neri"
  },
  Event_7486_Desc = {
    Text = "La tua mente è inondata di lordura, una nitida sensazione di corruzione.\nIl liquido torbido e maleodorante si insinua e si impossessa dei tuoi pensieri. Il dolore si diffonde sul tuo volto atterrito mentre sei intrappolato in un ciclo infinito di incubi, incapace di liberarti."
  },
  Event_7486_Name = {
    Text = "Ulcera Cranica"
  },
  Event_7487_ChoiceDesc1 = {
    Text = "[It's the Memphis Ritual Mirror]"
  },
  Event_7487_ChoiceDesc2 = {
    Text = "[It's a True North Compass]"
  },
  Event_7487_ChoiceDesc3 = {
    Text = "[I Haven't Dropped Anything]"
  },
  Event_7487_Desc = {
    Text = "\"O Pioniere dell'Attraversamento di Dimensione.\"\n\nUna Voce Antica riecheggia nelle tue orecchie, come proveniente dalla preistoria, trascendendo le ere.\n\nIn uno stato di estrema tensione, odi la voce porre una Domanda in qualche modo familiare.\n\n\"Cos'è quest'oggetto di turno che hai lasciato cadere e che ti permette di pescare carte a inizio turno?\""
  },
  Event_7487_Name = {
    Text = "Voci dall'Oltre"
  },
  Event_7488_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7488_Desc = {
    Text = "\"Questo non è un deposito di rottami,\" mormora Doll, accettandolo, \"ma va bene, posso ancora ricavarne qualcosa di utile.\""
  },
  Event_7488_Name = {Text = "Targhetta"},
  Event_7489_ChoiceDesc1 = {
    Text = "Orazione Comune casuale"
  },
  Event_7490_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7490_Desc = {
    Text = [[

Leggi il foglio logoro e consumato: "Gemelli", "Immersione", "Sacrificio", "Inefficace"...
Un groviglio di concetti frammentari e prosa criptica; solo un cervello pulsante dimostra che hai letto questo brandello di carta.]]
  },
  Event_7490_Name = {
    Text = "Editto Cifrato: Parte II"
  },
  Event_7491_ChoiceDesc1 = {
    Text = "[What Price Are You Willing to Pay?] Potenzia la qualità dell'Orazione di una carta casuale."
  },
  Event_7491_ChoiceDesc2 = {
    Text = "[Offri loro un Bloody Mary scaduto] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7491_Desc = {
    Text = "\"Benvenuto, mio prezioso ospite. Sentiti libero di scegliere; tutto questo sfavillante assortimento esiste per attenderti.\"\n\"Ehm, scusi il disturbo, posso chiedere... è lei la sorella gemella di Lady Daffodil?\"\n\"Io sono Lady Daffodil in persona. Posso chiederle cosa la porta qui oggi...?\"\n\"Scusi, scusi, siete diventata ancora più affascinante di prima. Non l'avevo riconosciuta. Si ricorda? Vent'anni fa, scacciò un mostro dal mio bar... Ieri, l'incubo è tornato. Ha occupato il bar, portando con sé i suoi simili in gran numero...\""
  },
  Event_7491_Name = {
    Text = "Frammento di Ricordi: Sogno del Passato Ritrovato"
  },
  Event_7492_ChoiceDesc1 = {
    Text = "[Chase the Crows] Ricevi 30 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_7492_ChoiceDesc2 = {
    Text = "[Continue chasing the child] Parti"
  },
  Event_7492_Desc = {
    Text = "Il secondo corvo è partito come Defunto, le sue Piume della coda rivelavano una sfumatura di bianco, reminiscente di ossa."
  },
  Event_7492_Name = {
    Text = "Sguardo del Corvo"
  },
  Event_7493_ChoiceDesc1 = {
    Text = "[Take a Gamble] Sviluppa [(Skill.Arg1)] e tenta la sorte"
  },
  Event_7493_ChoiceDesc2 = {
    Text = "[Forget It] Ottieni 25 Sigilli Neri"
  },
  Event_7493_Desc = {
    Text = [[

"Vi va di fare una scommessa? Indovinate i nostri numeri! Per un piccolo prezzo!"
I dadi scartati ronzavano rumorosamente, come se ti parlassero.
"Lanciami! Lanciami!"
"L'unico! L'ultimo!"
D'accordo, solo uno...
Hai raccolto una fiche. Decidi...]]
  },
  Event_7493_Name = {
    Text = "Scommessa Senza Fine"
  },
  Event_7494_ChoiceDesc1 = {
    Text = "[Resist Malice] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_7494_ChoiceDesc2 = {
    Text = "[Embrace Malice] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_7494_ChoiceDesc3 = {
    Text = "[Clear-Minded Departure] Ricevi 25 Sigilli Neri"
  },
  Event_7494_Desc = {
    Text = "I pensieri malvagi diventano lame, o denti affilati.\nRodono la sanità mentale che si indebolisce nel Dominio, divorando la volontà residua, proprio come la realtà infligge crudeltà su di te..."
  },
  Event_7494_Name = {
    Text = "Pensiero Inatteso"
  },
  Event_7495_ChoiceDesc1 = {
    Text = "[Struggle Fully] Distruggi una Carta di comando e ricevi Arg1 Sigilli Neri."
  },
  Event_7495_ChoiceDesc2 = {
    Text = "[Light the Web] Duplica una Carta di comando, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_7495_ChoiceDesc3 = {
    Text = "[Wait Quietly] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7495_Desc = {
    Text = "Fili sottili, come ragnatele, ti intrecciano; in questo momento, sei chiaramente diventato la preda del Dominio."
  },
  Event_7495_Name = {
    Text = "Intrappolato"
  },
  Event_7496_ChoiceDesc1 = {
    Text = "[Recipient: ∞] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_7496_ChoiceDesc2 = {
    Text = "[Recipient: Self] Distruggi una Carta"
  },
  Event_7496_ChoiceDesc3 = {
    Text = "[Recipient: Teacher] Ricevi 25 Sigilli Neri"
  },
  Event_7496_Desc = {
    Text = "Offrì al Camminatore del Dominio un'opportunità: un'opportunità di connettersi con la Creatura Sconosciuta.\nAlcune pagine logore, una Macchina da scrivere che trasudava inchiostro e un destinatario Sconosciuto, Unidirezionale.\nForse la volontà può determinare dove il tuo messaggio verrà recapitato."
  },
  Event_7496_Name = {Text = "Monologo"},
  Event_7497_ChoiceDesc1 = {Text = "[Accept]"},
  Event_7497_ChoiceDesc2 = {Text = "[Reject]"},
  Event_7497_Desc = {
    Text = [[
Sussurri echeggiano nello spazio vuoto.
"Oh, quel folle che continua a borbottare 'vincere o morire,' il famigerato giocatore d'azzardo. Faresti meglio a stargli alla larga."
Una figura esile e curva ti lancia alcune monete, il tintinnio metallico che atterra nel tuo palmo.
"Facciamo una partita."]]
  },
  Event_7497_Name = {
    Text = "Giocatore d'Azzardo Famigerato"
  },
  Event_7498_ChoiceDesc1 = {
    Text = "[Stiamo tutti bene] Scegli 1 tra 3 Carte di comando e ottieni Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7498_ChoiceDesc2 = {
    Text = "[Tu chi sei?] Scegli 1 tra 3 Carte di comando e ottieni Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7498_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7498_Desc = {
    Text = "La macchina da scrivere sputa inchiostro all'improvviso, con un numero accecante di punti esclamativi.\n\"Doll, stai bene??? Perché sei svanita quando anche il Custode è scomparso??? Per favore, se sei al sicuro, manda un messaggio!!! A William cadranno i capelli se aspettiamo ancora!!!\""
  },
  Event_7498_Name = {
    Text = "Missiva Urgente"
  },
  Event_7499_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7499_Desc = {
    Text = "Applichi l'ultimo pezzo di cerotto. Lei scoppia in una risata acuta, una nebbia nera si intreccia verso l'alto e la sua figura fluttuante svanisce dalla tua vista."
  },
  Event_7499_Name = {
    Text = "Carne Riforgiata"
  },
  Event_7500_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7500_Desc = {
    Text = [[
Estrai la Chiave d'argento, stringendola con dolore e reverenza. Un tenue bagliore simile a nebbia ti avvolge.
Nel silenzio, solo un sospiro permane.]]
  },
  Event_7500_Name = {
    Text = "Sguardo del Guardiano"
  },
  Event_7501_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7501_Desc = {
    Text = [[
Sguardi persistenti continuano a osservarti, mentre le cellule sotto la tua pelle urlano e fuggono, le tue vene si contorcono come vermi.
Senti un flusso di potere che monta, che esplode nello stato grottesco dei tuoi arti]]
  },
  Event_7501_Name = {
    Text = "Sguardo del Guardiano"
  },
  Event_7502_ChoiceDesc1 = {
    Text = "[Avoid Gaze] Risveglio di un Risvegliatore casuale"
  },
  Event_7502_ChoiceDesc2 = {
    Text = "[Stare] Scegli un Risvegliatore da Risvegliare, riduci il Costo di Arithmetica di quella Carta di 2, ma sviluppa [(Skill.Arg1)]."
  },
  Event_7502_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_7502_Desc = {
    Text = "I tunnel dimensionali collegano innumerevoli universi, con occhi senza numero che ti fissano mentre ti intrufoli attraverso il Passaggio supremo."
  },
  Event_7502_Name = {
    Text = "Sguardo Divino"
  },
  Event_7503_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7503_Desc = {
    Text = "È caos, caos totale.\nTutti i pensieri vengono spazzati via in un istante, trascinati dal torrente della mente.\nNegli abissi del cervello, restano soltanto infinita confusione e dolore, che sprofondano insieme."
  },
  Event_7503_Name = {
    Text = "Impeto d'Ispirazione"
  },
  Event_7504_ChoiceDesc1 = {Text = "[Take It]"},
  Event_7504_Desc = {
    Text = "Sembra esserci qualcosa all'interno della D-melma sovrasatura... Usa la Chiave d'argento per convertirla nel tuo stesso Potere."
  },
  Event_7504_Name = {
    Text = "Punto di Estrazione"
  },
  Event_7505_ChoiceDesc1 = {
    Text = "[Chase the Crows] Ricevi 35 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_7505_ChoiceDesc2 = {
    Text = "[Continue chasing the child] Parti"
  },
  Event_7505_Desc = {
    Text = "Un corvo volò via, lasciando una singola piuma nera fluttuare verso il basso."
  },
  Event_7505_Name = {
    Text = "Sguardo del Corvo"
  },
  Event_7506_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7506_Desc = {
    Text = [[
Qui si trova il Campo di Battaglia Abissale, dove il combattimento richiede sia coraggio che saggezza.

Affila lo sguardo e osserva i tuoi avversari. Non devi sconfiggerli tutti; abbatti il loro capo!]]
  },
  Event_7506_Name = {
    Text = "Prova Demoniaca"
  },
  Event_7507_ChoiceDesc1 = {
    Text = "[Connect] Recupera Arg2 PV."
  },
  Event_7507_Desc = {
    Text = "La nebbia si aggrappa densa mentre il tuo distintivo emette un pallido bagliore argenteo. Il comunicatore crepita, prendendo vita. Qualcuno sta chiamando."
  },
  Event_7507_Name = {Text = "Crocevia"},
  Event_7508_ChoiceDesc1 = {Text = "[Tail Him]"},
  Event_7508_ChoiceDesc2 = {
    Text = "[Greet Them]"
  },
  Event_7508_Desc = {
    Text = [[
Tap. Tap. Tap.
Una figura bianca si muove lentamente nella fitta nebbia, come una nave che salpa nella notte silenziosa.
Da dietro, sembra un ragazzo.
Ascoltando i suoi passi stanchi, prendi una decisione nel tuo cuore.]]
  },
  Event_7508_Name = {
    Text = "Fine Ultima I"
  },
  Event_7509_ChoiceDesc1 = {
    Text = "[Hesitantly Agree]"
  },
  Event_7509_ChoiceDesc2 = {
    Text = "[Express Caution]"
  },
  Event_7509_Desc = {
    Text = "Il Dissolto gridò mentre cadeva, e con tua sorpresa scopri Clementine in piedi dietro di esso.\n\"Sono qui per dire addio,\" dice. \"Come segno di ringraziamento, posso darti qualche indizio. Tuttavia... ciò richiederà la tua fiducia.\nPermettimi di ipnotizzarti, e condividerò con te tutto ciò che so.\"\nPuoi fidarti di lei?\n\"Fai attenzione,\" avvertì Ramona, \"Deve avere secondi fini.\""
  },
  Event_7509_Name = {
    Text = "Ipnoterapia"
  },
  Event_7510_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7510_Desc = {
    Text = "Ti concentri, e l'illusione si dissolve come inchiostro nell'acqua. Avanzi, ma l'ombra nel tuo cuore permane."
  },
  Event_7510_Name = {Text = "Illusione"},
  Event_7511_ChoiceDesc1 = {
    Text = "[Pitiful Creature?]"
  },
  Event_7511_ChoiceDesc2 = {
    Text = "[Evolved Human?]"
  },
  Event_7511_ChoiceDesc3 = {
    Text = "[Who are you?]"
  },
  Event_7511_Desc = {
    Text = "L'uomo che incontrasti per la sesta volta si ergeva sulla struttura d'acciaio, dominando la terra con lo sguardo. Il vento impetuoso gli sferzava i lunghi capelli all'indietro, rivelando la vera forma di un serpente.\nIl suo sguardo si fissò su di te, poi si spostò verso l'oscurità lontana.\n\"Ah, che creatura miserabile.\nIl sapore del tradimento dev'essere dolce quanto quello di un umano <Bold:evoluto>.\""
  },
  Event_7511_Name = {
    Text = "Compagno di viaggio insolito VI"
  },
  Event_7512_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7512_Desc = {
    Text = "Chi farebbe caso a un rullino di pellicola sotto lo sguardo di un segugio infernale?"
  },
  Event_7512_Name = {
    Text = "Fantasmi Mnemonici"
  },
  Event_7513_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7513_Desc = {
    Text = "Non guardare, non discutere, non ascoltare, e non pensare nemmeno— la scelta dei saggi."
  },
  Event_7513_Name = {
    Text = "Frenesia Runica"
  },
  Event_7514_ChoiceDesc1 = {
    Text = "[Leave] Distruggi 2 Carte qualsiasi"
  },
  Event_7514_Desc = {
    Text = [[
Attraverso la cacofonia di rumori, riesci a malapena a distinguere uno strano ronzio, simile al battito d'ali di un insetto. La Chiave d'Argento vibra con violenza contro il tuo petto; spinto da una forza ignota, alzi lo sguardo e vedi un enorme buco nero apparire nel cielo.
"Che peccato, senza dubbio, ma non importa. Ci Rincontreremo, mio stimato Occhio Senza Pupilla."]]
  },
  Event_7514_Name = {
    Text = "Ipnoterapia"
  },
  Event_7515_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7515_Desc = {
    Text = "Puoi ignorare tutto ciò che ti circonda, ma non il battito del tuo cuore. Accelera il suo ritmo, incalzandoti e rimproverandoti."
  },
  Event_7515_Name = {
    Text = "Atrio Sinistro"
  },
  Event_7516_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7516_Desc = {
    Text = "\"Fantastico!!! I capelli di William sono salvi ora!!\"\nIl testo del telegramma è breve, ma le parole praticamente vibrano sulla pagina."
  },
  Event_7516_Name = {
    Text = "Missiva Urgente"
  },
  Event_7517_ChoiceDesc1 = {
    Text = "[Tell Him the Truth] Risveglia un Risvegliatore casuale, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_7517_ChoiceDesc2 = {
    Text = "[Conceal the Truth] Incidi 1 Orazione su 3"
  },
  Event_7517_Desc = {
    Text = "\"Per favore, salvami.\"\nIl viaggiatore malinconico ti afferrò la mano. Vagava qui da centinaia di anni.\n\"Sono un soldato, incaricato di recarmi nell'estremo oriente per combattere gli eretici.\nHo attraversato fitte foreste, guadato fiumi, eppure ho smarrito la via, ritornando sempre nello stesso luogo.\nQualcosa mi osserva dall'Oscurità. Non riesco a vederlo, ma lo so. Mi ha sempre osservato.\nOra voglio solo tornare a casa...\"\nGuardi le ombre fluttuanti dietro di lui. Dapprima sfocate, poi via via più nitide — era una bocca spalancata, che attendeva famelica le anime perdute conservate per cento anni."
  },
  Event_7517_Name = {Text = "Divoratore"},
  Event_7518_ChoiceDesc1 = {
    Text = "[Into the Darkness]"
  },
  Event_7518_ChoiceDesc2 = {Text = "[Farewell]"},
  Event_7518_Desc = {
    Text = "\"Celeste, questa volta mi aiuterai, vero?\"\nLa ragazza camminava avanti e indietro nervosamente, lanciando di tanto in tanto occhiate alla silenziosa Risvegliatrice.\nLei non rispose alla ragazza, ma quando l'espressione di quest'ultima si fece più ansiosa, una brezza sollevò il velo bianco, sospingendola dolcemente in una certa direzione.\n\"Ti proteggerò.\"\nTi proteggerò, anche se una volta ho fallito in questa questione di \"protezione.\"\nMa questa volta, non permetterò che tu sia perduta nell'oscurità da sola."
  },
  Event_7518_Name = {
    Text = "Veglia della Fanciulla Sacra"
  },
  Event_7519_ChoiceDesc1 = {
    Text = "[Leave] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7519_Desc = {
    Text = "Alcuni canti sono antichi, perduti molto prima che il diluvio si diffondesse; altri sono recenti, parlano dello scorso Capodanno, quando una moglie comprò guanti nuovi ai grandi magazzini di Londinium... Dopo la caotica sovrapposizione di emozioni, non resta che un vuoto desolato nel cuore."
  },
  Event_7519_Name = {Text = "Shanty"},
  Event_7520_ChoiceDesc1 = {
    Text = "[Expel Colors] Acquisisci la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7520_ChoiceDesc2 = {
    Text = "[Embrace Colors] Acquisisci 1 delle 3 Reliquie d'oro, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_7520_ChoiceDesc3 = {
    Text = "[Turn and Leave] Acquisisci la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_7520_Desc = {
    Text = "Murphy lo seguì da vicino ma si bloccò a un angolo.\nUn'iridescenza fluida vorticava, facendo sospirare l'aria.\n\"Mur@1...\"\nÈ il fantasma di un'anima annegata intrappolata nel Sona-Nyl? O un defunto caro che segue i vivi?"
  },
  Event_7520_Name = {
    Text = "Sfumatura di Nostalgia"
  },
  Event_7521_ChoiceDesc1 = {
    Text = "[Keep Searching] Aumenta gli HP massimi di Arg1, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_7521_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7521_Desc = {
    Text = "Una voce familiare mi sussurrò all'orecchio, calda e confortante. Ma quando cercai di seguirla, il suono si interruppe bruscamente."
  },
  Event_7521_Name = {
    Text = "Contatto Anomalo"
  },
  Event_7522_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7522_Desc = {
    Text = [[
"Quella era una melodia blasfema."
Ti sei coperto le orecchie, il sangue scorreva fuori, e lo hai affermato con certezza.]]
  },
  Event_7522_Name = {
    Text = "Tono Proibito"
  },
  Event_7523_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7523_Desc = {
    Text = "I colori si contorcono vagamente in due forme umanoidi, ma restano immobili in quell'angolo, offrendoti le loro ultime benedizioni con lo sguardo."
  },
  Event_7523_Name = {
    Text = "Sfumatura di Nostalgia"
  },
  Event_7524_ChoiceDesc1 = {
    Text = "[Listen] Acquisisci 1 Reliquia Dorata su 3"
  },
  Event_7524_Desc = {
    Text = "La voce di Daffodil si interruppe per un istante.\n\"Oh, hai scelto questo? Una bella scelta. Come ricompensa, ti farò un dono speciale.\""
  },
  Event_7524_Name = {
    Text = "Tempo suggerimento"
  },
  Event_7525_ChoiceDesc1 = {
    Text = "[Keep Asking] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_7525_ChoiceDesc2 = {
    Text = "[Abandon Inquiry] Distruggi una Carta"
  },
  Event_7525_Desc = {
    Text = "\"Hmm, una scelta saggia. Di fronte a un nemico così formidabile, sicuramente vorrai conoscere te stesso e il tuo avversario, no? Tuttavia, sapere troppi segreti sulle Dimensioni potrebbe turbare la tua mente, sai?\""
  },
  Event_7525_Name = {
    Text = "Tempo suggerimento"
  },
  Event_7526_ChoiceDesc1 = {
    Text = "[Persistent Inquiry] Fai infuriare Daffodil ed entra in Battaglia."
  },
  Event_7526_ChoiceDesc2 = {
    Text = "[Give up asking] Ricevi una penalità minore"
  },
  Event_7526_Desc = {
    Text = "\"Oh? Anche adesso stai ancora pensando di rintracciarmi? Piccolo mio, essere troppo avidi non è cosa buona, sai?\""
  },
  Event_7526_Name = {
    Text = "Tempo suggerimento"
  },
  Event_7527_ChoiceDesc1 = {
    Text = "[Focus] Aumenta gli HP massimi di Arg1"
  },
  Event_7527_ChoiceDesc2 = {
    Text = "[Ignorare] 2 Carte di comando casuali ottengono l'Orazione: \"(EnchantConfig.Arg1)\", infetta 2 \"(Skill.Arg2)\""
  },
  Event_7527_Desc = {
    Text = [[
Insegui il Segugio infernale per le strade della cittadina.
Fiocchi di neve gelidi iniziano a cadere dal cielo, posandosi delicatamente sulle tue guance e sul petto, placando il tuo cuore inquieto.]]
  },
  Event_7527_Name = {Text = "Neve"},
  Event_7528_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7528_Desc = {
    Text = [[
Agiti le braccia, cercando di scacciare questi fastidiosi corvi.
Gracchiano beffardi, come se ridessero della tua stoltezza e Debolezza.
Ciononostante, il tuo coraggio li commuove, e ne ricevi la dovuta ricompensa.]]
  },
  Event_7528_Name = {
    Text = "Canto dei Corvi"
  },
  Event_7529_ChoiceDesc1 = {
    Text = "[About Lily] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_7529_ChoiceDesc2 = {
    Text = "[About Hellhound] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7529_Desc = {
    Text = "\nOltre la porta senza fine, da un luogo distante e irraggiungibile, giunge la voce di Daffodil.\n\"Questo è il tempo suggerimento di Daffodil.\""
  },
  Event_7529_Name = {
    Text = "Tempo suggerimento"
  },
  Event_7530_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7530_Desc = {
    Text = "Rimanete saldi, recitando la cantilena restando fedeli a voi stessi.\nNon vi fidate dei sussurri nelle vostre orecchie, affidandovi unicamente alla ragione umana.\nTuttavia... quando il terreno solido su cui fate affidamento viene inghiottito da una densa melma nera, cavarvi gli occhi per usarli come strumenti di osservazione sarà la vostra unica scelta nei vostri ultimi istanti."
  },
  Event_7530_Name = {
    Text = "Canto dei Corvi"
  },
  Event_7531_ChoiceDesc1 = {
    Text = "[Stare Down the Hellhound Source] Ottieni la Reliquia dorata \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\""
  },
  Event_7531_ChoiceDesc2 = {
    Text = "[Focus on Battle] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7531_Desc = {
    Text = [[
La sagoma del Segugio infernale muta.
Il suo corpo collega le crepe nei muri, rivelando sinistre Illusioni.]]
  },
  Event_7531_Name = {
    Text = "Dalla Prospettiva"
  },
  Event_7532_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7532_Desc = {
    Text = "\"Miao, miao miao, miao miao miao...\"\nSforzavi la voce, cercando con ogni mezzo di apparire debole e innocuo.\n\"Miao! Miao miao! Miao miao miao!\"\nIl gruppo di gatti sembrò accettare la tua buona volontà, rispondendo con richiami allegri. I vostri versi si rincorrevano avanti e indietro, giorno e notte senza sosta, spaventando persino la luna che si nascose dietro le nuvole."
  },
  Event_7532_Name = {
    Text = "Città dei Gatti"
  },
  Event_7533_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7533_Desc = {
    Text = [[
Solo una creatura in affanno che cerca un pezzo di legno alla deriva su cui riposare...
Sospiri mentre il fluido nero dalla coda della farfalla ti gocciola sulla guancia.]]
  },
  Event_7533_Name = {
    Text = "Lepidotteri d'Ossidiana"
  },
  Event_7534_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7534_Desc = {
    Text = "Hai usato ogni briciolo di forza per allontanarti dal gruppo di gatti.\nQuando ti sei voltato a guardare, i gatti avevano già ripreso le loro attività abituali: leccarsi il pelo, sonnecchiare, e persino azzuffarsi tra loro...\nA dire il vero, degli esseri umani non gli importa nulla."
  },
  Event_7534_Name = {
    Text = "Città dei Gatti"
  },
  Event_7535_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7535_Desc = {
    Text = "Lanci i pezzi di carne rimasti nello sciame di gatti.\nI gatti si precipitano come una Marea nera, dilaniando freneticamente la carne prima di disperdersi rapidamente.\nSfortunatamente, la carne è scaduta. Riempie i loro stomaci vuoti, ma porta ben poca soddisfazione."
  },
  Event_7535_Name = {
    Text = "Città dei Gatti"
  },
  Event_7536_ChoiceDesc1 = {
    Text = "[Eye Contact] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7536_ChoiceDesc2 = {
    Text = "[Stop Resisting] Risveglia 2 Risvegliatori casuali, ma sviluppa [(Skill.Arg1)] due volte."
  },
  Event_7536_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_7536_Desc = {
    Text = [[
Innumerevoli occhi sussurrano attorno alle tue orecchie.
"Viaggiamo, ci fermiamo, avanziamo per decine di migliaia di anni e oltre.
Mentre il sole si spegne sotto il nostro sguardo vigile, mentre la vita sull'antica Terra viene divorata dalle inondazioni.
Siamo da tempo affascinati dai misteri dell'universo."]]
  },
  Event_7536_Name = {Text = "Occhio"},
  Event_7537_ChoiceDesc1 = {
    Text = "[Feel Panic] Risveglio di un Risvegliatore casuale"
  },
  Event_7537_ChoiceDesc2 = {
    Text = "[Feel Content] Scegli un Risvegliatore da Risvegliare, riduci il Costo di Arithmetica di quella Carta di 2, ma sviluppa [(Skill.Arg1)]."
  },
  Event_7537_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_7537_Desc = {
    Text = "Hai visto un cielo privo di luna e stelle, con innumerevoli pupille ingrandite sospese in alto.\nSembra quasi di poter allungare la mano e strapparle giù, facendo schizzare sangue e carne.\nMa quando apri la mano, non c'è nulla.\nGli occhi del fato ti osservano senza battere ciglio, avendo trovato un granello di sabbia scintillante nel caotico universo."
  },
  Event_7537_Name = {
    Text = "Occhio della Cupola"
  },
  Event_7538_ChoiceDesc1 = {
    Text = "[Lower Hands] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_7538_ChoiceDesc2 = {
    Text = "[Keep Covering Ears] Ricevi 75 Sigilli Neri, ma sviluppi il Sintomo [(Skill.Arg2)]"
  },
  Event_7538_Desc = {
    Text = "Stridii, stridii senza fine—\nIl Cantore Corvo, avvolto in lucide piume nere, il becco affilato che brilla di un freddo bagliore, trafigge i tuoi timpani con ogni grido lugubre.\nScopri le orecchie!\nIl coro notturno dei corvi brama i crudi tremiti del tuo corpo rannicchiato."
  },
  Event_7538_Name = {
    Text = "Canto dei Corvi"
  },
  Event_7539_ChoiceDesc1 = {
    Text = "[Imitate Cat's Call] Ricevi 50 Sigilli Neri"
  },
  Event_7539_ChoiceDesc2 = {
    Text = "[Feed] Ricevi 75 Sigilli Neri, ma sviluppi il Sintomo [(Skill.Arg2)]"
  },
  Event_7539_Desc = {
    Text = "Sei entrato accidentalmente nel territorio del gatto nero.\nInnumerevoli occhi si sono aperti nell'Oscurità, colmi di curiosità, diffidenza e Allerta... ma privi di benevolenza.\nVerde smeraldo, giallo ambra, blu pavone...\nTi sei sentito come immerso in un mare di gemme scintillanti.\nPer fuggire, tu—"
  },
  Event_7539_Name = {
    Text = "Città dei Gatti"
  },
  Event_7540_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7540_Desc = {
    Text = "Noti una mano insolita. È delicata, candida, e resta calma per tutto il tempo.\nSoprattutto — la riconosci come la tua.\nSenza esitazione, la strappi via con forza.\nInnumerevoli grida acute risuonano, e la palude infine svanisce."
  },
  Event_7540_Name = {
    Text = "Palude Cupa"
  },
  Event_7541_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7541_Desc = {
    Text = [[
"Una decisione saggia," dice la figura a mani vuote. "Le scelte preordinate conducono a esiti predeterminati, mentre le azioni imprevedibili aprono la strada a nuovi futuri."
Un sottile senso di Speranza ti avvolge delicatamente. Le sagome svaniscono, lasciandoti con le mani strette al petto, incerto se si trattasse di una Proiezione o di un Fantasma generato dallo Stress mentale.]]
  },
  Event_7541_Name = {
    Text = "Sentieri Biforcati"
  },
  Event_7542_ChoiceDesc1 = {
    Text = "[Praise It] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7542_ChoiceDesc2 = {
    Text = "[Taunt It] Sviluppa il Sintomo [(Skill.Arg1)] e cambia l'Orazione da incidere.(Utilizzi: 2/2)"
  },
  Event_7542_Desc = {
    Text = "La mente dice: Le catene imprigionano il mio proencefalo, il mio tronco encefalico, la mia corteccia cerebrale, eppure non possono imprigionare gli oltre 10 miliardi di minuscole cellule che inseguono la verità.\nTu dici: Chi ti ha intrappolato qui? E il tuo corpo?\nLa mente dice: Corpo? Non scherzare! In passato mi chiamavano \"il Vecchio Johnny il macellaio\".\nQuando avevo un corpo, non riuscivo nemmeno a fare i conti fino a dieci.\nMa dopo che il curatore ha rimosso la mia carne superflua, guarda cosa sono diventato! Un fisico, un filosofo e un poeta dilettante."
  },
  Event_7542_Name = {
    Text = "Cervello del Filosofo"
  },
  Event_7543_ChoiceDesc1 = {
    Text = "[Prove Goldbach's Conjecture] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_7543_ChoiceDesc2 = {
    Text = "[Journey's End] Incidi l'Orazione [(EnchantConfig.Arg1)] su una Carta di comando casuale."
  },
  Event_7543_ChoiceDesc3 = {
    Text = "[Refuse to Ask] Ricevi 50 Sigilli Neri"
  },
  Event_7543_Desc = {
    Text = "Quando hai raccolto la tavola spiritica, la voce di una giovane donna si è riversata nella tua mente.\n\"Chiedimi qualsiasi cosa. Io so tutto.\"\n\"Dalle mie risposte, riceverai il dono del destino.\""
  },
  Event_7543_Name = {
    Text = "Tavola Spiritica"
  },
  Event_7544_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7544_Desc = {
    Text = "Leggi il foglio logoro e frammentario, frasi spezzate che sgorgano dalle tue labbra. Parole come \"Antenati\", \"Divus\", \"Morte Eterna\" e \"Lunga Memoria\" inondano la tua mente, agitando i tuoi nervi già Fragili, tormentati dagli Incubi."
  },
  Event_7544_Name = {
    Text = "Editto Cifrato: Parte I"
  },
  Event_7545_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7545_Desc = {
    Text = [[
Fanghiglia nera ti gocciola sul viso, provocando un prurito pungente.
Incapace di sopportarlo, colpisci la farfalla.
La farfalla schiva il tuo gesto ostile e svanisce silenziosamente in lontananza.]]
  },
  Event_7545_Name = {
    Text = "Lepidotteri d'Ossidiana"
  },
  Event_7546_ChoiceDesc1 = {
    Text = "[Leave] Cerca il Riflettore"
  },
  Event_7546_ChoiceDesc2 = {
    Text = "[Break into Mist] Perde Arg2 HP"
  },
  Event_7546_ChoiceDesc3 = {
    Text = "[Enter Directly]"
  },
  Event_7546_Desc = {
    Text = "Davanti a te si stende una fitta nebbia nera; addentrarsi avventatamente porterà sciagura.\nForse dovresti trovare un \"Riflettore\" per disperdere la nebbia."
  },
  Event_7546_Name = {Text = "???"},
  Event_7547_ChoiceDesc1 = {
    Text = "[Accettare il Fantasma] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7547_ChoiceDesc2 = {
    Text = "[Deny the Illusion] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7547_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7547_Desc = {
    Text = [[
Sotto il pesante e cupo ponte di ferro, una farfalla scintillante si leva d'improvviso dalla silenziosa riva del fiume ricoperta di canne.
La farfalla si posa delicatamente sul tuo palmo, zittendo gli orrendi ululati. Al loro posto, odi le cantilene ritmiche degli operai che spostano l'acciaio, il battere dei martelli e il nitido tintinnio dei rivetti...]]
  },
  Event_7547_Name = {
    Text = "Miraggio del ponte d'acciaio"
  },
  Event_7548_ChoiceDesc1 = {
    Text = "[Chase the Crows] Ricevi 40 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_7548_ChoiceDesc2 = {
    Text = "[Keep Chasing the Child] Ricevi 25 Sigilli Neri e vattene."
  },
  Event_7548_Desc = {
    Text = "Un corvo si posò sul lampadario.\nDue corvi si posarono sul lampadario.\nTre corvi si posarono sul lampadario.\n.....\nLe nere creature torsero il collo, fissando con malevolenza dal lampadario del vicolo. Le loro teste in ombra sembravano condividere un unico corpo immerso nella D-melma."
  },
  Event_7548_Name = {
    Text = "Sguardo del Corvo"
  },
  Event_7549_ChoiceDesc1 = {
    Text = "[Leave] Ottieni una Reliquia d'argento quando meno di 3 Risvegliatori sono risvegliati [(RelicConfig.Arg1)]"
  },
  Event_7549_ChoiceDesc2 = {
    Text = "[Leave] Ottieni una Reliquia Dorata quando almeno 3 Risvegliati sono al Risveglio[(RelicConfig.Arg1)]"
  },
  Event_7549_Desc = {
    Text = "Ignori il segno e avanzi.\n<Italic:Il peso della Gnosi risvegliata è così opprimente>, il segno si allarga e si contorce al tuo passaggio, come se una mano potesse emergere dalla crepa in qualsiasi momento e trascinarti negli abissi."
  },
  Event_7549_Name = {
    Text = "Fessura Strisciante"
  },
  Event_7550_ChoiceDesc1 = {
    Text = "[Return the Gaze] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7550_ChoiceDesc2 = {
    Text = "[Avoid the gaze] Risveglia 2 Risvegliatori casuali, ma sviluppa [(Skill.Arg1)] due volte."
  },
  Event_7550_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_7550_Desc = {
    Text = "Percepisci uno sguardo — trascendente, superiore a qualsiasi Dominio — che osserva te e la ragazza davanti a te.\nIl tuo respiro si fa affannoso, e una paura primordiale urla dal profondo della tua mente."
  },
  Event_7550_Name = {
    Text = "Di chi è lo sguardo?"
  },
  Event_7551_ChoiceDesc1 = {
    Text = "[Keep Searching] Aumenta gli HP massimi di Arg1, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_7551_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7551_Desc = {
    Text = "Una debole luce apparve, luminosa e calda. Tuttavia, svanì all'improvviso non appena tentasti di seguirla."
  },
  Event_7551_Name = {
    Text = "Contatto Anomalo"
  },
  Event_7552_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7552_Desc = {
    Text = "Sussurrando sommessamente le Loro cantilene, le correnti calde ti portano benedizioni di casa."
  },
  Event_7552_Name = {
    Text = "Canto di Mare"
  },
  Event_7553_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7553_Desc = {
    Text = "Scorgi una fioca luce davanti a te; hai finalmente attraversato la nebbia soffocante."
  },
  Event_7553_Name = {
    Text = "Nebbia del Caos"
  },
  Event_7554_ChoiceDesc1 = {
    Text = "[Unravel the Lower Branch]"
  },
  Event_7554_Desc = {
    Text = [[
La Gnosi residua nel Dominio si interconnette, intrecciandosi in un campo di forza instabile.
Forse, puoi dipanare la Gnosi e aprire un sentiero davanti a te.]]
  },
  Event_7554_Name = {
    Text = "Sentiero Intrecciato"
  },
  Event_7555_ChoiceDesc1 = {
    Text = "[Unravel the Upper Branch]"
  },
  Event_7555_Desc = {
    Text = [[
La Gnosi residua nel Dominio si interconnette, intrecciandosi in un campo di forza instabile.
Forse, puoi dipanare la Gnosi e aprire un sentiero davanti a te.]]
  },
  Event_7555_Name = {
    Text = "Sentiero Intrecciato"
  },
  Event_7556_ChoiceDesc1 = {
    Text = "[Unravel the Left Branch]"
  },
  Event_7556_Desc = {
    Text = [[
La Gnosi residua nel Dominio si interconnette, intrecciandosi in un campo di forza instabile.
Forse, puoi dipanare la Gnosi e aprire un sentiero davanti a te.]]
  },
  Event_7556_Name = {
    Text = "Sentiero Intrecciato"
  },
  Event_7557_ChoiceDesc1 = {
    Text = "[Unravel the Left Branch]"
  },
  Event_7557_Desc = {
    Text = [[
La Gnosi residua nel Dominio si interconnette, intrecciandosi in un campo di forza instabile.
Forse, puoi dipanare la Gnosi e aprire un sentiero davanti a te.]]
  },
  Event_7557_Name = {
    Text = "Sentiero Intrecciato"
  },
  Event_7558_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7558_Desc = {
    Text = "Ti attendono ancora diverse battaglie feroci. Non è il momento per un'indagine tranquilla."
  },
  Event_7558_Name = {
    Text = "Registro degli Organi"
  },
  Event_7559_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7559_Desc = {
    Text = "I caratteri sulla carta diventano improvvisamente completi e vividi, parole terrificanti capaci di scuotere la fede e le fondamenta di qualsiasi ignaro lettore. Più leggi, più ti senti confuso e atterrito, grattandoti il cuoio capelluto in modo incontrollabile.\nAll'improvviso, quei simboli maledetti svaniscono. Ramona interrompe la tua lettura e ficca a forza le pagine nella valigia."
  },
  Event_7559_Name = {
    Text = "Editto Cifrato: Parte II"
  },
  Event_7560_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7560_Desc = {
    Text = [[
Gioia, pianto, tristezza, angoscia... Queste sono le tue emozioni.
Tu, e innumerevoli versioni di te attraverso dimensioni differenti.]]
  },
  Event_7560_Name = {Text = "Indulgenza"},
  Event_7561_ChoiceDesc1 = {
    Text = "[Ascoltare in silenzio] Scegli 1 tra 3 Carte di comando e ottieni Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7561_ChoiceDesc2 = {
    Text = "[Lei è qui] Scegli 1 tra 3 Carte di comando e ottieni Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7561_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7561_Desc = {
    Text = "Le urla dei Dissoluti echeggiano nella tua mente. Una voce flebile ma familiare emerge dall'oscurità, sussurrando debolmente:\n\"Sorella Sasha,\" \"Sorella Sasha...\"\n\"Sorella Sasha, dove sei?\""
  },
  Event_7561_Name = {
    Text = "\"Sorella Sasha\""
  },
  Event_7562_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7562_Desc = {
    Text = [[
"Unisciti a Lui, unisciti a loro, unisciti a noi.
Diventa il Suo Guardiano, diventa il Suo tramite.
Lascia che il Suo Sogno guidi il tuo cammino..."
Le Preghiere caotiche agitano la tua mente. Dopo che le voci svaniscono, ti ritrovi madido di sudore.]]
  },
  Event_7562_Name = {
    Text = "Preghiera Onirica"
  },
  Event_7563_ChoiceDesc1 = {
    Text = "[Never Heard of It]"
  },
  Event_7563_ChoiceDesc2 = {
    Text = "[I've heard of it]"
  },
  Event_7563_Desc = {
    Text = "『Mi scusi, posso rubarle un momento?\nSpero di trattenerla qualche minuto per presentarle alcune leggende locali.\nHa mai sentito parlare di una creatura chiamata 'Cerbero'?』"
  },
  Event_7563_Name = {
    Text = "Compagno di viaggio insolito I"
  },
  Event_7564_ChoiceDesc1 = {
    Text = "[Quit Thinking] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7564_ChoiceDesc2 = {
    Text = "[Inseguire l'Ispirazione] 1 Carta di comando casuale ottiene l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_7564_Desc = {
    Text = "Il porto è sotto Attacco, con un misterioso mercantile che va e viene e \"nuovi amici\" dotati di pinne... Si tratta di una trappola meticolosamente preparata? O dell'ennesimo viaggio inaspettatamente pericoloso?\nRealtà e ragione si tirano e si torcono l'una contro l'altra, innumerevoli ispirazioni e pensieri che emergono dalla mente."
  },
  Event_7564_Name = {
    Text = "Impeto d'Ispirazione"
  },
  Event_7565_ChoiceDesc1 = {
    Text = "[Elworth's Volcano?] Aumenta i PV massimi di Arg1"
  },
  Event_7565_ChoiceDesc2 = {
    Text = "[Sforzarsi di ricordare] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7565_Desc = {
    Text = "Lacrime nere scorrono sulle guance di Lily. \"L'abbiamo visto, mamma,\" sussurra piano, \"nel vulcano di Elworth...\""
  },
  Event_7565_Name = {
    Text = "Memoria Vulcanica"
  },
  Event_7566_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7566_Desc = {
    Text = "\"Navi@1... gatore...\"\nRune tremolano apparendo e scomparendo davanti ai tuoi occhi, e non puoi fare a meno di protendere la mano nel vuoto, cercando di afferrarle—\n\"Che stai facendo?! Ci stanno raggiungendo!\"\nUna ragazza misteriosa ti trascina verso l'altra estremità del ponte, interrompendo la tua connessione con le rune.\nMa c'è sicuramente un potere che ha lasciato un segno sulla punta delle tue dita."
  },
  Event_7566_Name = {
    Text = "Frenesia Runica"
  },
  Event_7567_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7567_Desc = {
    Text = "Non hai alcun interesse per quei vaneggiamenti mistici, né vuoi rischiare la Follia avventurandoti nella notte oscura."
  },
  Event_7567_Name = {
    Text = "Lettera di soccorso"
  },
  Event_7568_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7568_Desc = {
    Text = "A prescindere da tutto, il dovere del Custode ti gonfia il petto. Non puoi abbandonare la speranza di trovare il mittente, per quanto vaga e oscura essa sia."
  },
  Event_7568_Name = {
    Text = "Lettera di soccorso"
  },
  Event_7569_ChoiceDesc1 = {
    Text = "[Observe It] 100% di probabilità di ottenere 25 Sigilli Neri"
  },
  Event_7569_ChoiceDesc2 = {
    Text = "[Pet It] 50% di probabilità di ottenere 50 Sigilli Neri, 50% di probabilità di non ottenere nulla."
  },
  Event_7569_Desc = {
    Text = "Un gatto nero balzò fuori all'improvviso da un vicolo laterale, avvolgendosi affettuosamente attorno ai tuoi piedi. Le sue inquietanti pupille verticali verdi brillarono di una luce agghiacciante, come a dire: \"Non inseguirmi, vieni a giocare un po' con me.\"\n\"Lo hai già visto. È proprio accanto a te — coloro che sono contaminati dalla follia, le ombre frenetiche... Non fissare direttamente il Suo contorno.\""
  },
  Event_7569_Name = {
    Text = "Spiritello notturno"
  },
  Event_7570_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7570_Desc = {
    Text = "\"Impossibile, incredibile!\" La voce urlò, \"Quella donna che mi ha mandato da questo demone NON è Sorella Sasha!\""
  },
  Event_7570_Name = {
    Text = "\"Sorella Sasha\""
  },
  Event_7571_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7571_Desc = {
    Text = "\"Ricevuto. Procederemo con la consegna dell'Inventario Base. Si prega di verificare e confermare.\""
  },
  Event_7571_Name = {
    Text = "Comunicazione di supporto"
  },
  Event_7572_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7572_Desc = {
    Text = "Non è più utile."
  },
  Event_7572_Name = {
    Text = "Eredità Antica"
  },
  Event_7573_ChoiceDesc1 = {
    Text = "[Look Closely] Incidi 1 Orazione su 3"
  },
  Event_7573_ChoiceDesc2 = {
    Text = "[Strappare il manifesto] 1 Carta di comando casuale ottiene Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7573_Desc = {
    Text = [[
Un candelabro che si trova comunemente in un museo delle cere.
Alla luce arancione e inquietante, noti un poster disegnato a mano sulla parete.]]
  },
  Event_7573_Name = {
    Text = "Ilarità nelle Tenebre"
  },
  Event_7574_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7574_Desc = {
    Text = [[
"Lily ha un cuore tutto suo; non ha bisogno di ascoltare nessuno." Rispondi con calma.
Francis sbuffa, senza offrire risposta.]]
  },
  Event_7574_Name = {
    Text = "La Sua Scelta"
  },
  Event_7575_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7575_Desc = {
    Text = "È una foto di gruppo.\nPersone abbattute accovacciate dietro sbarre di ferro, i volti colmi di sofferenza.\nUna foto cattura il tuo sguardo. È una giovane donna esile, il viso inespressivo.\nEscrescenze blasfeme si intrecciano attorno al suo corpo.\nNon riesci a vederne il volto, ma immagini che sarebbe priva di espressione."
  },
  Event_7575_Name = {
    Text = "Verbale Fedele"
  },
  Event_7576_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7576_Desc = {
    Text = "Fissi con ossessione quei gioielli scintillanti, e senza accorgertene hai già stretto la mano scheletrica e nera di melma.\nLei stringe appena la mano, poi la lascia andare.\nNon è successo nulla, solo un filo di nebbia nera che scivola lungo le tue dita dentro la manica."
  },
  Event_7576_Name = {
    Text = "Artigli Rovescianti"
  },
  Event_7577_ChoiceDesc1 = {
    Text = "[Play a Few Notes] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7577_ChoiceDesc2 = {
    Text = "[Close the Lid] Incidi 1 Orazione su 3"
  },
  Event_7577_Desc = {
    Text = "Il pianoforte accostato al muro ha il coperchio aperto. I suoi tasti sono ingialliti e i bordi screpolati lasciano intravedere il legno sottostante, eppure ogni tasto è stato ripulito con cura.\nÈ una fonte di gioia per così tanti."
  },
  Event_7577_Name = {
    Text = "Filastrocca"
  },
  Event_7578_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7578_Desc = {
    Text = [[
Il Portatore di lancia geme, piagnucolando come un bambino maltrattato.
Il suono svanisce all'istante, e anche gli altri due Navigatori scompaiono... Si scopre che era solo un'Illusione riflessa dal Dominio.]]
  },
  Event_7578_Name = {
    Text = "Caccia implacabile"
  },
  Event_7579_ChoiceDesc1 = {
    Text = "[Leave] Acquisisci la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_7579_Desc = {
    Text = [[
"Corretto."
Il proprietario della voce era molto soddisfatto di questa risposta, e un oggetto luccicante fu lanciato fuori dall'acqua.
"Ricorda, tutto ha un prezzo."]]
  },
  Event_7579_Name = {
    Text = "Voci dall'Oltre"
  },
  Event_7580_ChoiceDesc1 = {
    Text = "[Dispel the Illusion] Sviluppa un Sintomo casuale."
  },
  Event_7580_ChoiceDesc2 = {Text = "[Leave]"},
  Event_7580_Desc = {
    Text = "Volti sfocati appaiono all'improvviso, circondandoti e gemendo disperatamente con corde vocali inesistenti."
  },
  Event_7580_Name = {Text = "Illusione"},
  Event_7581_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7581_Desc = {
    Text = [[
Ignori il marchio e avanzi.
Ma sembra infuriato, si espande e si contorce a ogni tuo passo, come se una mano potesse emergere dalla crepa per trascinarti dentro.]]
  },
  Event_7581_Name = {
    Text = "Fessura Strisciante"
  },
  Event_7582_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7582_Desc = {
    Text = "Non ci sei cascato. Ti sei voltato con decisione e te ne sei andato."
  },
  Event_7582_Name = {
    Text = "Fessura Strisciante"
  },
  Event_7583_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7583_Desc = {
    Text = "Noti la crepa insolita e ti accovacci per esaminarla. Stranamente, la crepa che si stava espandendo solo un istante fa si arresta all'improvviso, sprofondando in un silenzio eterno."
  },
  Event_7583_Name = {
    Text = "Fessura Strisciante"
  },
  Event_7584_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7584_Desc = {
    Text = "\"No, è una mente lucida. La determinazione non ti aiuterà a fronteggiare l'Entità Dissolta, Custode. Rifletti sulla tua strategia.\""
  },
  Event_7584_Name = {
    Text = "Regola di Rogues"
  },
  Event_7585_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7585_Desc = {
    Text = "Non riesci a resistere all'impulso che ti pervade.\nLe tue dita vagano e danzano sulla tastiera come fanciulli smarriti in una foresta...\nA poco a poco, farfalle emergono dalla macchina da scrivere.\nUna, due, tre...\nSul tuo volto, sulle tue dita, sciami di farfalle scintillano come fuochi d'artificio, brillando come gemme nell'oscurità.\nQuesta macchina da scrivere non ha alcun uso pratico, ma è maestra nel creare bellezza."
  },
  Event_7585_Name = {Text = "Occhio"},
  Event_7586_ChoiceDesc1 = {
    Text = "[Tie the Hen]"
  },
  Event_7586_Desc = {
    Text = "La Specialità di Rye: gallina vivace, una tentazione culinaria!"
  },
  Event_7586_Name = {
    Text = "Fabbricazione di Trappole"
  },
  Event_7587_ChoiceDesc1 = {
    Text = "[Mission Accomplished]"
  },
  Event_7587_Desc = {
    Text = "Trappole economiche ma efficaci!"
  },
  Event_7587_Name = {
    Text = "Fabbricazione di Trappole"
  },
  Event_7588_ChoiceDesc1 = {
    Text = "[Set up a Trap]"
  },
  Event_7588_Desc = {
    Text = "Una tagliola metallica per animali, la migliore amica del cacciatore pigro."
  },
  Event_7588_Name = {
    Text = "Fabbricazione di Trappole"
  },
  Event_7589_ChoiceDesc1 = {
    Text = "[Check] Ottieni la Reliquia d'Oro \"(RelicConfig.Arg2)\", ma sviluppi \"(Skill.Arg1)\"."
  },
  Event_7589_ChoiceDesc2 = {
    Text = "[Disregard] Ricevi 50 Sigilli Neri"
  },
  Event_7589_Desc = {
    Text = "Ti rifugi in una stretta fessura nella roccia per sfuggire alla tempesta. Ma sai che non puoi restare qui a lungo — se quelle figure in vesti nere ti trovano, non ci sarà Nessuna Via di Fuga.\nIn un angolo della fessura, scopri inaspettatamente un telegrafo."
  },
  Event_7589_Name = {
    Text = "Telegramma Silenzioso"
  },
  Event_7590_ChoiceDesc1 = {
    Text = "[Check the Film] Migliora la qualità dell'Orazione di 2 carte casuali."
  },
  Event_7590_ChoiceDesc2 = {
    Text = "[Check Camera] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7590_Desc = {
    Text = "Come estrarre un pezzo di viscere, la pellicola all'interno della fotocamera fu ridotta a brandelli, scartata, sventrata e ignorata.\nUn lampo bianco accecante, la fotocamera abbandonata all'angolo della strada si inclinò, il suo otturatore scattò per mano di una forza invisibile.\n\"Click—\"\nLa tua espressione scioccata e attonita fu fedelmente catturata sulla pellicola"
  },
  Event_7590_Name = {
    Text = "Innocenza Registrata"
  },
  Event_7591_ChoiceDesc1 = {
    Text = "[Strangle the Singer] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_7591_ChoiceDesc2 = {
    Text = "[Inciampare nel Passo della Danzatrice] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_7591_ChoiceDesc3 = {
    Text = "[Steal the Poet's Manuscript] Ricevi 50 Sigilli Neri"
  },
  Event_7591_Desc = {
    Text = "Tre figure viscose ti sbarrano il cammino.\nUna figura canta con voce roca e testi sinistri. Ti copri le orecchie e la oltrepassi.\nUn'altra figura danza rigidamente con passi esitanti. Chiudi gli occhi e la schivi.\nL'ultima figura recita poesie frammentate con frasi sconnesse. Incapace di sopportare oltre, tu—"
  },
  Event_7591_Name = {
    Text = "Bruto del Sentiero Stretto"
  },
  Event_7592_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7592_Desc = {
    Text = "\n\"No! Il progresso dell'umanità non dipende dalla storia o dalla tecnologia, ma dai topi.\"\n\"I ratti hanno inaugurato l'era oscura, e solo allora l'umanità ha potuto accogliere l'alba della rinascita.\"\n\"L'umanità ha bisogno di voi... anche se non tutti lo comprendono.\"\nI topi rimasero alquanto confusi dal tuo lungo discorso, ma ti lasciarono andare comunque."
  },
  Event_7592_Name = {Text = "Peste"},
  Event_7593_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7593_Desc = {
    Text = [[
Ti sforzi di vedere attraverso gli spasmi del tuo nervo ottico...
Sembra esserci un cerchio magico lacerato, perfettamente circolare.
Al suo interno vi sono innumerevoli archi, statici eppure fluenti, ipnotici.]]
  },
  Event_7593_Name = {
    Text = "Dalla Prospettiva"
  },
  Event_7594_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7594_Desc = {
    Text = "<Bold>Museo delle Cere Rogers\n44 Via Nanhua, Città di Londinium, Distretto @2\nOrario di visita: 21:00-6:00\n3:00 chiusura ingressi (chiuso nei fine settimana)\n\n<Bold>Mostra in corso\nVladimir @2:\nFilosofia del Sorriso"
  },
  Event_7594_Name = {
    Text = "Ilarità nelle Tenebre"
  },
  Event_7595_ChoiceDesc1 = {
    Text = "[Eye Contact] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando, ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_7595_ChoiceDesc2 = {
    Text = "[Close Your Eyes] Risveglia un Risvegliato, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_7595_ChoiceDesc3 = {
    Text = "[Turn Your Back] Ricevi 25 Sigilli Neri"
  },
  Event_7595_Desc = {
    Text = "Non dovresti poter vedere le stelle.\nNel Dominio di Sona-Nyl, il cielo risplende di una brillantezza fluida, celando le stelle e la luna.\nNella cabina in penombra, non dovresti poter vedere le stelle nemmeno qui.\nDovrebbero esserci solo rare lampadine a incandescenza e vecchie lanterne — allora perché avverti ancora Lo Sguardo dall'alto?"
  },
  Event_7595_Name = {Text = "Sbircia"},
  Event_7596_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7596_Desc = {
    Text = "\nScegli di fissare coraggiosamente quegli occhi.\nSono Stelle brillanti, scintillanti nell'oscurità.\nPoi risero e si trasformarono in innumerevoli lune crescenti.\nGli occhi dissero: \"Non hai paura degli sguardi. Non dovresti avere paura di... È da tanto che non ci vediamo, @2.\"\nPrima di svanire, ti donarono un piccolo pegno come \"Memoriale del ricongiungimento.\""
  },
  Event_7596_Name = {Text = "Occhio"},
  Event_7597_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7597_Desc = {
    Text = "Il ponte ferroviario, sangue e nervi di Londinium, collega il cuore e le membra della città. Finché il sole non sarà tramontato qui, il cuore di Londinium pulserà vigorosamente."
  },
  Event_7597_Name = {
    Text = "Miraggio del ponte d'acciaio"
  },
  Event_7598_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7598_Desc = {
    Text = "Una fuga squisita, compositore ignoto.\nInnumerevoli voci dai temi affini si intrecciano, ogni nota precisa e fredda come il bisturi di un chirurgo.\nPrecisione e splendore: questa è l'estetica di Rogers.\nFuga, prendi il volo!"
  },
  Event_7598_Name = {
    Text = "Cattivo Gusto"
  },
  Event_7599_ChoiceDesc1 = {
    Text = "[Greet Out Loud]"
  },
  Event_7599_ChoiceDesc2 = {
    Text = "[Seek Help]"
  },
  Event_7599_Desc = {
    Text = "Nell'istante in cui ti appoggi alla ringhiera della nave, scorgi una ragazza in abito bianco.\nNobile, pura, eterea... e vagamente familiare.\nDove l'hai già vista? Tenti faticosamente di setacciare i tuoi ricordi caotici quando lei, d'improvviso, sembra avvertire la tua presenza, incrociando il tuo sguardo attraverso il vuoto.\nI suoi occhi sono calmi come l'oceano a inizio primavera, eppure stranamente avverti qualcosa in essi...\nSembra che stia aspettando che tu la saluti, anche solo per parlare del tempo di oggi."
  },
  Event_7599_Name = {
    Text = "Fanciulla in Bianco"
  },
  Event_7600_ChoiceDesc1 = {
    Text = "[Praise It] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_7600_ChoiceDesc2 = {
    Text = "[Taunt It] Sviluppa il Sintomo [(Skill.Arg1)] e cambia l'Orazione da incidere.(Utilizzi: 1/2)"
  },
  Event_7600_Desc = {
    Text = "Jenkin disse: \"Johnny! Sei davvero... diverso da prima, sotto ogni aspetto.\"\nDicesti: \"Sei davvero un cervello diligente e ambizioso.\"\nIl cervello si contorse e si agitò un poco, chiaramente molto compiaciuto.\nIl cervello disse: \"Avanti! Poiché apprezzi le mie conquiste, ti impartirò tutta la Conoscenza accumulata nella mia vita...\""
  },
  Event_7600_Name = {
    Text = "Cervello del Filosofo"
  },
  Event_7601_ChoiceDesc1 = {
    Text = "[Graceful Fugue] Acquisisci la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7601_ChoiceDesc2 = {
    Text = "[Simple Serenade] Tutti i Risvegli ottengono 50 Aliemus, ma sviluppi [(Skill.Arg1)]."
  },
  Event_7601_ChoiceDesc3 = {
    Text = "[Meaningless Noise] Incidi 1 Orazione su 3"
  },
  Event_7601_Desc = {
    Text = "\"Personalmente, non condivido molto i gusti musicali del curatore, sai...\nTroppo appariscente, e io sono una persona con i piedi per terra.\"\nUna voce maschile stanca emanava dal grammofono cigolante, lamentandosi in solitudine.\n\"Ma questo è il mio lavoro... D'accordo, risparmiamo tempo e scegliamone uno.\""
  },
  Event_7601_Name = {
    Text = "Cattivo Gusto"
  },
  Event_7602_ChoiceDesc1 = {
    Text = "[Special Relic] Ottieni una Reliquia Dorata[(RelicConfig.Arg1)]"
  },
  Event_7602_ChoiceDesc2 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_7602_Desc = {
    Text = "Evento 253 (In sviluppo), Effetto non definitivo"
  },
  Event_7602_Name = {
    Text = "Evento 253 (In sviluppo)"
  },
  Event_7603_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7603_Desc = {
    Text = "Fuggi più veloce che puoi.\nOra stai affrontando i Mostri più fastidiosi e disgustosi di sempre — le Sculture di Cera brulicanti.\nA confronto, queste rozze figure d'argilla non sono nulla.\nStabilire le priorità — questo è un principio a cui ogni Custode deve attenersi."
  },
  Event_7603_Name = {Text = "Bozzetto"},
  Event_7604_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7604_Desc = {
    Text = [[
La Chiave d'argento brilla, colmando lo spazio di un bagliore argenteo e trasformando i densi colori fluenti in argento puro.
La luce svanisce in un istante, lasciando solo il lamento lugubre del vento.]]
  },
  Event_7604_Name = {
    Text = "Sfumatura di Nostalgia"
  },
  Event_7605_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7605_Desc = {
    Text = "L'iridescenza vi abbaglia e, prima che ve ne rendiate conto, siete in trance..."
  },
  Event_7605_Name = {
    Text = "Crocevia Stellare"
  },
  Event_7606_ChoiceDesc1 = {
    Text = "[Descend Further] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_7606_ChoiceDesc2 = {
    Text = "[Pull Away] Ricevi 25 Sigilli Neri"
  },
  Event_7606_Desc = {
    Text = "\"Tu\" ti invita ad andare più in profondità.\nNelle profondità della spirale, il \"tu\" del passato e del futuro ti inviano \"doni\" da diverse dimensioni."
  },
  Event_7606_Name = {Text = "Abisso"},
  Event_7607_ChoiceDesc1 = {
    Text = "[Understanding] Acquisisci la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7607_ChoiceDesc2 = {
    Text = "[Innocence] Acquisisci 1 delle 3 Reliquie d'oro, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_7607_ChoiceDesc3 = {
    Text = "[Leave] Acquisisci la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_7607_Desc = {
    Text = "Due figure dal bagliore argenteo appaiono davanti ai tuoi occhi, presentando una forma liquida viscosa, fluttuanti nell'aria.\n\"È esattamente qui che sono perito.\" Una figura si accovaccia.\n\"Nel regno di Dio libero dalla malattia, non esistono cose come il desiderio e la perdita. Tu non comprendi davvero — cosa significhi cessare di esistere.\"\nL'altra figura sospira, volgendo lo sguardo verso di te."
  },
  Event_7607_Name = {
    Text = "Pantheon Perduto"
  },
  Event_7608_ChoiceDesc1 = {
    Text = "[Leave] Cerca il Riflettore"
  },
  Event_7608_ChoiceDesc2 = {
    Text = "[Enter the Mist] Sviluppa il Sintomo [(Skill.Arg2)]"
  },
  Event_7608_ChoiceDesc3 = {
    Text = "[Enter Directly]"
  },
  Event_7608_Desc = {
    Text = "Davanti a te si stende una fitta nebbia nera; addentrarsi avventatamente porterà sciagura.\nForse dovresti trovare un \"Riflettore\" per disperdere la nebbia."
  },
  Event_7608_Name = {Text = "???"},
  Event_7609_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7609_Desc = {
    Text = "\"Quella è la proiezione della memoria,\" ti spiegò Ramona, \"Potrebbe appartenere a una certa persona, o potrebbe essere un ricordo condiviso di più persone.\"\nI ricordi preziosi meritano di essere custoditi con cura."
  },
  Event_7609_Name = {
    Text = "I Nostri Ricordi"
  },
  Event_7610_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7610_Desc = {
    Text = [[
Anche se non riesci a decifrarla ora, non ti arrendi. La pieghi con cura e la infili in tasca, progettando di trovare un altro modo per leggerla una volta tornato a scuola.
Tuttavia, mentre la lettera si accartoccia misteriosamente a mezz'aria, un debole dolore inizia a emergere nel tuo petto.]]
  },
  Event_7610_Name = {
    Text = "Lettera Macchiata"
  },
  Event_7611_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7611_Desc = {
    Text = "La candela si accende nell'istante in cui lascia la bilancia, versando lacrime bianco latte che scivolano rapidamente tra le tue dita e scompaiono."
  },
  Event_7611_Name = {
    Text = "Ragione e sentimento"
  },
  Event_7612_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7612_Desc = {
    Text = "In fretta, strappi il foglio dalla macchina da scrivere, ma essa continua a funzionare. In questo momento di panico, una Carta di comando cade dentro e viene irrimediabilmente macchiata dal più nero degli inchiostri.\nTi prendi un istante per disfartene con cura, ma non puoi fare a meno di notare il testo minaccioso e ripetuto ora impresso su di essa;\n<Bold:NON GUARDARE DIRETTAMENTE>\n<Bold:NON GUARDARE DIRETTAMENTE>\n<Bold:NON GUARDARE DIRETTAMENTE>\n<Bold:NON GUARDARE DIRETTAMENTE>\n<Bold:NON GUARDARE DIRETTAMENTE>\n<Bold:NON GUARDARE DIRETTAMENTE>\n<Bold:NON GUARDARE DIRETTAMENTE>\n<Bold:NON GUARDARE DIRETTAMENTE>"
  },
  Event_7612_Name = {
    Text = "Avvertimento non richiesto"
  },
  Event_7613_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7613_Desc = {
    Text = [[
Quando le tue dita hanno toccato il bordo ghiacciato della coppa, freddo abbastanza da congelare il midollo delle ossa, hai rabbrividito e ti sei ridestato di colpo.
Comunque sia, non andrebbe lasciata sul ciglio della strada. Meglio riporla nella valigia.]]
  },
  Event_7613_Name = {
    Text = "Idromele al Miele"
  },
  Event_7614_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7614_Desc = {
    Text = "Tossisci violentemente.\nIl suono sembra Spaventato, poi cade nel silenzio.\nSenti di aver perso un indizio importante...\nMa la vita è sempre piena di occasioni mancate e rimpianti, non è vero?"
  },
  Event_7614_Name = {
    Text = "Orecchio indiscreto"
  },
  Event_7615_ChoiceDesc1 = {
    Text = "[Keep Silent] 100% di probabilità di ottenere 25 Sigilli Neri"
  },
  Event_7615_ChoiceDesc2 = {
    Text = "[Reach Out and Touch] 50% di probabilità di ottenere 50 Sigilli Neri, 50% di probabilità di non ottenere nulla."
  },
  Event_7615_Desc = {
    Text = "\"Tutto ciò che ho da dire si riassume in una massima: nessuno può uccidere un gatto!\"\n\"Quel maledetto gatto nero avrebbe dovuto essere sventrato e lasciato a marcire in aperta campagna, ma ha dissotterrato la tomba di famiglia, divorando i resti di carne umana e disperdendo ossa e arti ovunque.\"\n\"Sotto le sue fredde, scure pupille a fessura, il pus giallastro e putrido affiorava, e io strisciavo via, tormentato dagli incubi, con lo spirito prosciugato.\"\n\"Aspettate... Cosa state facendo? Non sono pazzo! Non lo sono! Voi dovete nascondere qualcosa! È la verità—\"\nÈ davvero la verità. Mentre osservate l'ombra del folle svanire, scambiate uno sguardo con il silenzioso gatto nero ai vostri piedi."
  },
  Event_7615_Name = {
    Text = "Flagello del Gatto Notturno"
  },
  Event_7616_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7616_Desc = {
    Text = "Mentre esitavi, si è dissolto nel D-segno ed è scomparso rapidamente."
  },
  Event_7616_Name = {
    Text = "Relitti nel Barile"
  },
  Event_7617_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7617_Desc = {
    Text = "Accartocciate la lettera con frustrazione e la gettate ai vostri piedi."
  },
  Event_7617_Name = {
    Text = "Lettera Macchiata"
  },
  Event_7618_ChoiceDesc1 = {Text = "[Confirm]"},
  Event_7618_Desc = {
    Text = "Ti concentri, e l'illusione si dissolve come inchiostro nell'acqua. Avanzi, ma l'ombra nel tuo cuore permane."
  },
  Event_7618_Name = {Text = "Illusione"},
  Event_7619_ChoiceDesc1 = {
    Text = "[Examine Carefully] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7619_ChoiceDesc2 = {
    Text = "[Avoid Shadows] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_7619_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_7619_Desc = {
    Text = "I nervi di Ramona erano tesi allo spasimo mentre si muoveva con cautela nel manicomio, evitando la folla.\nScivolò in una piccola stanza.\nUn'ombra apparve improvvisamente fuori dalla finestra."
  },
  Event_7619_Name = {
    Text = "Riflesso nella Finestra"
  },
  Event_7620_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_7620_Desc = {
    Text = "Il compito più urgente ora è assicurare il colpevole alla giustizia. Tuttavia, i semi della rabbia hanno già messo radici nel tuo cuore. Senza attendere la tua risposta, l'uomo si voltò e se ne andò."
  },
  Event_7620_Name = {
    Text = "Impronta del Colosso"
  },
  Event_7621_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 75 Sigilli Neri, ma sviluppi il Sintomo [(Skill.Arg2)]"
  },
  Event_7621_Desc = {
    Text = "L'educazione che hai ricevuto fin dall'Infanzia a Mythag ti ha reso impossibile ignorare questa Impronta. Hai spazzato via le impronte polverose, e in quel momento ti è parso di udire una risposta da una Dimensione lontana: \"Grazie\"."
  },
  Event_7621_Name = {
    Text = "Impronta del Colosso"
  },
  Event_7622_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7622_Desc = {
    Text = "Hai stretto la Chiave d'Argento, la cui tenue luce argentea e le lievi vibrazioni ti hanno portato conforto. Lo Sguardo sembrava svanire, eppure persisteva, lasciando su di te un marchio invisibile."
  },
  Event_7622_Name = {
    Text = "Di chi è lo sguardo?"
  },
  Event_7623_ChoiceDesc1 = {
    Text = "[Find the Secret Path]"
  },
  Event_7623_Desc = {
    Text = [[
Tu, Ramona e Lotan vi separate per inseguire il Segugio infernale.

Corri attraverso diversi vicoli, quando un corpo massiccio appare davanti a te.
Svolta l'angolo mentre lo insegui.
Lo raggiungi, ma ti trovi di fronte a un Vicolo Cieco, tre alte mura che racchiudono uno stretto riquadro di cielo.]]
  },
  Event_7623_Name = {
    Text = "Vicolo Cieco"
  },
  Event_7624_ChoiceDesc1 = {
    Text = "[Walk Past]"
  },
  Event_7624_ChoiceDesc2 = {Text = "[Pat]"},
  Event_7624_Desc = {
    Text = "Accanto al tavolo operatorio pulito e morbido giace il corpo ormai accasciato di Koum.\nÈ ancora imponente, come una piccola collina, proprio come la ricordavi quando la vedesti per la prima volta.\nTuttavia, rispetto ai veri \"Segugi infernali\" nel cielo, è così piccola, abbastanza piccola da sembrare una cucciola."
  },
  Event_7624_Name = {
    Text = "Calore Residuo"
  },
  Event_7625_ChoiceDesc1 = {
    Text = "[Get Silver]"
  },
  Event_7625_Desc = {
    Text = "Hmm, sembra che ci siano molte cose luccicanti più avanti!\nSniff... profumano.\nLick... è gelido!\nSembra qualcosa di prezioso. Portiamolo subito dal piccolo Jenkin, forse potremo avere un sacco di formaggio, squeak!"
  },
  Event_7625_Name = {
    Text = "Bagliore dorato"
  },
  Event_7626_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7626_Desc = {
    Text = "Un'ondata di insolita delusione affiora nel tuo cuore mentre la trama illusoria si dissolve gradualmente, rivelando il sentiero davanti a te."
  },
  Event_7626_Name = {
    Text = "Rete Vagale"
  },
  Event_7627_ChoiceDesc1 = {
    Text = "[Comprehend it] Risveglia un Risvegliatore casuale, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_7627_ChoiceDesc2 = {
    Text = "[Ignore It] Incidi 1 Orazione su 3"
  },
  Event_7627_Desc = {
    Text = "Rune scaturiscono dal ruggito della creatura pisciforme, colmandoti orecchie, cavità nasali e gola. Ti bruciano il corpo. In soli dieci secondi, afferrerai il significato profondo celato dietro quel ruggito..."
  },
  Event_7627_Name = {
    Text = "Frenesia Runica"
  },
  Event_7628_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7628_Desc = {
    Text = [[
Stringi i denti e cerchi di resistere al caotico fantasma. Ramona ti pone un oggetto freddo nel palmo della mano.
"Questa reliquia che ho scoperto potrebbe esserti d'aiuto."]]
  },
  Event_7628_Name = {
    Text = "Fantasma Dimensionale"
  },
  Event_7629_ChoiceDesc1 = {
    Text = "Scegli un'Orazione Avanzata"
  },
  Event_7630_ChoiceDesc1 = {
    Text = "[Bloccare il corvo] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_7630_ChoiceDesc2 = {
    Text = "[Kill Crow] Incidi 1 Orazione su 3"
  },
  Event_7630_ChoiceDesc3 = {Text = "[Leave]"},
  Event_7630_Desc = {
    Text = "Il corvo solitario gracchia raucamente, strappandosi le piume nere una a una.\nTrema di dolore, strillando senza controllo mentre i suoi movimenti frenetici si intensificano.\n\"Cra—Cra—\"\nLacrime azzurre miste a melma nera gli scorrono dagli occhi, e nessuno ne è testimone se non tu.\n"
  },
  Event_7630_Name = {
    Text = "Lacrima di Magma"
  },
  Event_7631_ChoiceDesc1 = {
    Text = "[Leave] Aumenta gli HP massimi di Arg1"
  },
  Event_7631_Desc = {
    Text = "\"Lascia fare a me,\" accarezzi dolcemente la spina dorsale del mostro, come per calmare un gattino furioso, \"Si sveglierà. Non le faremo del male.\""
  },
  Event_7631_Name = {
    Text = "Richiamo dell'Amicizia"
  },
  Event_7632_ChoiceDesc1 = {
    Text = "[Leave] Aumenta gli HP massimi di Arg1, ma sviluppa \"(Skill.Arg2)\" e \"(Skill.Arg3)\"."
  },
  Event_7632_Desc = {
    Text = "\"Svegliati, Lily. Anche Koum spera che ti risveglierai presto—\""
  },
  Event_7632_Name = {
    Text = "Richiamo dell'Amicizia"
  },
  Event_7633_ChoiceDesc1 = {Text = "[Leave]"},
  Event_7633_Desc = {
    Text = "Non è più utile."
  },
  Event_7633_Name = {
    Text = "Telegramma Silenzioso"
  },
  Event_79429_ChoiceDesc1 = {
    Text = "Scegli un Risvegliatore e trasformati in un \"Insettoide\" tramite il Rito della Vita. Le Carte di comando dell'\"Insettoide\" costano 1 Arithmetica in meno, ma vengono Esaurite dopo essere state giocate."
  },
  Event_79429_Desc = {
    Text = "\"Il processo di autoconsapevolezza è sempre accompagnato dal dolore; così è per la metamorfosi e la rinascita.\"\nSorrise teneramente, accarezzandoti il volto con amore.\n\"Non avere paura, sono qui con te, quindi apri il tuo spirito e accoglili.\"\n\"Buon fanciullo, attendo la tua rinascita, attendo che tu... diventi uno di noi.\""
  },
  Event_79429_Name = {
    Text = "Metempsicosi"
  },
  Event_80463_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 1 di 3 Reliquie d'argento, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_80463_Desc = {
    Text = [[
Scegli un sentiero, trascinando il piccolo William mentre corri freneticamente.
Per fortuna, la tua scelta era corretta.
Quelle distorsioni mentali, quelle Clementine identiche, sei finalmente riuscito a seminarle.
Naturalmente, hai pagato un prezzo.]]
  },
  Event_80463_Name = {
    Text = "Le\"Clementine\""
  },
  Event_80464_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80464_Desc = {
    Text = "Un ricordo al di là di ogni cognizione viene infuso nel tuo cervello, frantumando direttamente la tua ragione.\nIn quella scena accelerata, ricordi solo un'immagine: il Tempio triangolare.\nEra una grandiosa opera edificata dagli Shag@2ais per il Dio Cieco e Idiota @4."
  },
  Event_80464_Name = {
    Text = "Memoria Profonda"
  },
  Event_80465_ChoiceDesc1 = {
    Text = "[Leave] Risveglia un Risvegliatore, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_80465_Desc = {
    Text = [[
Scegli un sentiero, trascinando il piccolo William mentre corri freneticamente.
Per fortuna, la tua scelta era corretta.
Quelle distorsioni mentali, quelle Clementine identiche, sei finalmente riuscito a seminarle.
Naturalmente, hai pagato un prezzo.]]
  },
  Event_80465_Name = {
    Text = "Le\"Clementine\""
  },
  Event_80466_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80466_Desc = {
    Text = "\"Click. Click. Click\"\nIl \"lavoro\" è finalmente completato, ma a parte il \"lavoro\" stesso, cosa hai davvero ottenuto?"
  },
  Event_80466_Name = {
    Text = "Tormento Eterno"
  },
  Event_80467_ChoiceDesc1 = {
    Text = "[Leave] Incidi 1 Orazione su 3"
  },
  Event_80467_Desc = {
    Text = [[
"Sono lieto di sentire la tua risposta sincera."
"Non vedo l'ora del nostro prossimo incontro."]]
  },
  Event_80467_Name = {
    Text = "Richiamo Onirico"
  },
  Event_80468_ChoiceDesc1 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_80468_Desc = {
    Text = "\"Ah, che bambino disonesto.\"\n\"Ma non importa, la prossima volta ti farò dire la verità.\"\n\"Tutte le verità che sgorgano dal tuo cuore e dalla tua anima.\""
  },
  Event_80468_Name = {
    Text = "Richiamo Onirico"
  },
  Event_80469_ChoiceDesc1 = {
    Text = "[Start \"Working\"] Distruggere una Carta di comando e ricevere Arg1 Sigilli Neri."
  },
  Event_80469_ChoiceDesc2 = {
    Text = "[Retreat Far Away]"
  },
  Event_80469_Desc = {
    Text = "\"Click.\"\nIl suono della Macchina da scrivere riecheggia, e finché il \"lavoro\" non sarà terminato, sarai per sempre il suo schiavo."
  },
  Event_80469_Name = {
    Text = "Tormento Eterno"
  },
  Event_80470_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80470_Desc = {
    Text = "\"Che peccato, la tua cautela ti ha fatto perdere l'unica opportunità di scoprire la verità.\"\nSospira, dissolvendosi in silenzio."
  },
  Event_80470_Name = {
    Text = "Memoria Profonda"
  },
  Event_80471_ChoiceDesc1 = {
    Text = "[All-Out Attack]"
  },
  Event_80471_ChoiceDesc2 = {
    Text = "[Fight and Retreat]"
  },
  Event_80471_Desc = {
    Text = "Una figura inaspettata appare dinanzi a te — è Clementine.\n\"Non stupirti, voglio solo condurre un Test Speciale.\"\n\"In cosa consista il test, è un segreto.\" Clementine sorride, \"L'unico contenuto del test per te —\"\n\"è sopravvivere.\""
  },
  Event_80471_Name = {
    Text = "Test Speciale"
  },
  Event_80472_ChoiceDesc1 = {
    Text = "[Recall the Past]"
  },
  Event_80472_ChoiceDesc2 = {
    Text = "[Pull out the Scales]"
  },
  Event_80472_Desc = {
    Text = "\"Ti prego, credimi, non voglio farti del male, voglio solo aiutarti.\"\nClementine ti insegue, gridando a gran voce.\nLa sua voce suona incredibilmente sincera, eppure non riesci più a fidarti di nulla.\nLa tua morale è stata frantumata dalla \"Teoria della Cognizione Incarnata,\" e la tua sanità mentale è sull'orlo del collasso.\nDevi, devi assolutamente fare qualcosa per resistere alle scaglie d'insetto che crescono nella tua carne, resistere alla follia e alla disperazione che si infiltrano gradualmente nella tua anima."
  },
  Event_80472_Name = {
    Text = "Anime in Lotta"
  },
  Event_80473_ChoiceDesc1 = {
    Text = "[Leave] Distruggi 2 Carte qualsiasi"
  },
  Event_80473_Desc = {
    Text = "\"Vuoi conservare le forze per la Battaglia finale?\"\n\"Una scelta saggia. Ma nel guadagnare, si perde anche qualcosa.\"\n\"Perché in questo mondo crudele e ardente, la sopravvivenza stessa richiede un prezzo.\""
  },
  Event_80473_Name = {
    Text = "Test Speciale"
  },
  Event_80474_ChoiceDesc1 = {
    Text = "[Ignore It] Incidi 1 Orazione su 3"
  },
  Event_80474_ChoiceDesc2 = {
    Text = "[Toccarlo] 1 Carta di comando casuale ottiene Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_80474_Desc = {
    Text = "Una strana cosa simile a spore ha catturato la tua attenzione.\nEra come una delicata medusa fatta di carne e sangue, simile anche a fibre nervose che trattengono segnali nel profondo del cervello.\n\"Vieni a toccarmi,\" ti tenta in silenzio, \"ti mostrerò un ricordo crudele.\""
  },
  Event_80474_Name = {
    Text = "Memoria Profonda"
  },
  Event_80475_ChoiceDesc1 = {
    Text = "[Leave] Incidi 1 Orazione su 3"
  },
  Event_80475_Desc = {
    Text = "\"Ramona, Doll, Lotan, Ogier...\"\nContinui a Sussurrare nervosamente questi nomi.\nLa tua sanità mentale in frantumi non riesce più a ricordare i loro volti, ma l'esistenza che rappresentano scalda ancora il tuo cuore e la tua anima.\nSono esistiti, hanno riso, loro... sono il punto fermo e l'àncora che mantengono intatta la tua Umanità in questo istante."
  },
  Event_80475_Name = {
    Text = "Anime in Lotta"
  },
  Event_80476_ChoiceDesc1 = {
    Text = "[Leave] Ottieni 1 di 3 Reliquie d'argento, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_80476_Desc = {
    Text = "\"Ahhhhh—\"\nHai aperto la bocca, urlando, il suono, più che un grido, era simile a uno stridio.\nLe squame d'insetto strappate sono ricresciute, e la tua sanità frantumata è perduta per sempre."
  },
  Event_80476_Name = {
    Text = "Anime in Lotta"
  },
  Event_80477_ChoiceDesc1 = {
    Text = "[Leave] Ottieni la Reliquia \"(RelicConfig.Arg1)\", ma sviluppi il Sintomo \"(Skill.Arg2)\"."
  },
  Event_80477_Desc = {
    Text = [[
Non ti risparmi, dando tutto te stesso. Questo atteggiamento piace visibilmente a Clementine.
"Che bravo bambino."
"In tal caso, lascia che ti ricompensi un poco. Naturalmente, ha un prezzo."
"In questo mondo crudele e ardente, la sopravvivenza stessa esige un prezzo."]]
  },
  Event_80477_Name = {
    Text = "Test Speciale"
  },
  Event_80478_ChoiceDesc1 = {
    Text = "[Start \"Working\"] Distruggere una Carta di comando e ricevere Arg1 Sigilli Neri."
  },
  Event_80478_ChoiceDesc2 = {
    Text = "[Retreat Far Away]"
  },
  Event_80478_Desc = {
    Text = [[
"Click. Click."
Il suono della Macchina da scrivere riecheggia, e durante il "lavoro" non sei altro che uno strumento per portarlo a compimento.]]
  },
  Event_80478_Name = {
    Text = "Tormento Eterno"
  },
  Event_80479_ChoiceDesc1 = {
    Text = "[Run to the Left]"
  },
  Event_80479_ChoiceDesc2 = {
    Text = "[Run to the Right]"
  },
  Event_80479_Desc = {
    Text = "Una figura familiare ti insegue senza sosta—non una o due, ma decine, centinaia.\nLo stretto corridoio non poteva contenere così tante \"Clementine,\" e alcune \"Clementine\" vengono spinte a terra, altre calpestate fino a ridursi in poltiglia.\nMa tutte ti chiamano all'unisono, ripetendo la frase che avvelena la tua mente.\n\"Perché fuggi? Volevo solo offrirti un consulto.\"\nE tu corri come un forsennato per i corridoi del Sanatorio, trovandoti di fronte alla scelta di un bivio."
  },
  Event_80479_Name = {
    Text = "Le\"Clementine\""
  },
  Event_80480_ChoiceDesc1 = {
    Text = "[Start \"Working\"] Distruggere una Carta di comando e ricevere Arg1 Sigilli Neri."
  },
  Event_80480_ChoiceDesc2 = {
    Text = "[Retreat Far Away]"
  },
  Event_80480_Desc = {
    Text = "\"Correggi! Lavora! Non fermarti!\"\nInnumerevoli mormorii risuonano nelle tue orecchie, attirandoti verso la macchina da scrivere apparsa all'improvviso.\n\"Che fare, che fare, ho battuto i tasti dalla mattina alla sera, eppure il lavoro non finisce mai.\"\n\"Correggi! Correggi! Correggi il piano, presenta le richieste, completa il lavoro!\"\n\"Lavora! Lavora!! Lavora!!\"\nL'anima ronzante si schianta contro la macchina da scrivere che batte senza sosta, e infine, quella macchina da scrivere si ferma.\nMa un istante dopo, quella macchina da scrivere riprende a funzionare.\n\"Correggi! Lavora! Non fermarti!\"\nPerché il lavoro non ha fine."
  },
  Event_80480_Name = {
    Text = "Tormento Eterno"
  },
  Event_80481_ChoiceDesc1 = {
    Text = "[Answer Honestly]"
  },
  Event_80481_ChoiceDesc2 = {
    Text = "[Refuse to Answer]"
  },
  Event_80481_Desc = {
    Text = [[
In un istante, lo scenario davanti a te si fa sfocato e illusorio.
Pensi che sia la stanza a torcersi e mutare, ma poi ti rendi conto che i tuoi nervi ottici sono stati invasi.
"Ci rivediamo."
Nella visione offuscata, Clementine sorride dolcemente.
"Anche se ci incontriamo prima del previsto, sono comunque molto felice. Mi chiedo se tu, %player%, provi lo stesso?"]]
  },
  Event_80481_Name = {
    Text = "Richiamo Onirico"
  },
  Event_80595_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80595_Desc = {
    Text = "\nIn risposta al tuo tentativo di scacciarla, la farfalla resta indifferente.\nInsegue ostinatamente il tuo palmo, perdendo la sua vitalità nella tua mano.\n\"Ah, così caldo...\"\nQuesto fu il suo ultimo sussurro."
  },
  Event_80595_Name = {
    Text = "Sogno di Lepidottero"
  },
  Event_80596_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80596_Desc = {
    Text = "\"Voglio che i fiori sboccino per sempre, voglio che i sorrisi durino in eterno.\"\n\"Desidero che tutti coloro afflitti dalla Dissoluzione possano guarire in pace, desidero che questo mondo possa tornare al suo passato e smettere di bruciare.\"\n\"Voglio...\"\nLa piccola farfalla batté le ali, perdendo la sua vitalità nel palmo della tua mano.\nAlmeno, qualcuno ha ascoltato la sua voce."
  },
  Event_80596_Name = {
    Text = "Sogno di Lepidottero"
  },
  Event_80597_ChoiceDesc1 = {
    Text = "[Scacciare la Farfalla] 1 Carta di comando casuale ottiene l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_80597_ChoiceDesc2 = {
    Text = "[Listen to Their Wish] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_80597_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_80597_Desc = {
    Text = "La piccola farfalla porta con sé molti sogni.\nQuesti sogni si disperdono nel mare di fiori, nel reparto, e nell'altare colmo di sangue e carne di @2.\nFinalmente, ha atteso il suo legame, senza sapere se sei disposto ad ascoltare il suo piccolo, piccolo desiderio."
  },
  Event_80597_Name = {
    Text = "Sogno di Lepidottero"
  },
  Event_80610_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80610_Desc = {
    Text = "\"Razionalità? Una risposta interessante.\"\n\"Spero che non rimpiangerai la tua Scelta.\""
  },
  Event_80610_Name = {
    Text = "Il Prezzo dell'Umanità"
  },
  Event_80612_ChoiceDesc1 = {
    Text = "[Feed Them] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)], ma sviluppa 1 Sintomo su 3."
  },
  Event_80612_ChoiceDesc2 = {
    Text = "[Pay No Mind] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 1 di 3 Carte di comando, ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_80612_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_80612_Desc = {
    Text = "I Residenti vanno e vengono, eppure lo sciame di topi si estende all'infinito.\nRispetto agli umani, sono loro i veri \"nativi\" di questo castello.\nMa non hanno obiezioni al trasferimento degli umani.\nPerché quelle cose brutte, molli e bianche daranno loro da mangiare cose altrettanto brutte, molli e bianche.\n\"E tu, cosa brutta, a quale tipo appartieni?\""
  },
  Event_80612_Name = {
    Text = "Segreto della Cittadella"
  },
  Event_80613_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80613_Desc = {
    Text = "\nUna risata sommessa emerge dall'oscurità.\n\"Ti sto aspettando, perché tu venga a trovarmi.\"\n\"Coraggioso piccolo insetto.\""
  },
  Event_80613_Name = {
    Text = "Sguardo di \"Lei\""
  },
  Event_80614_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80614_Desc = {
    Text = "\"Taci, taci, sei insopportabile.\"\nIl gatto nero si copre le orecchie con le zampe in un gesto singolarmente umano.\n\"Umano, il tuo parlare felino è pessimo, quello che dici non ha alcun senso!\"\nNonostante queste parole, l'espressione del gatto nero si addolcisce.\n\"Dato che hai miagolato per compiacermi, ti lascerò un dono.\"\n\"Quanto al contenuto del dono, dipende dalla tua fortuna.\""
  },
  Event_80614_Name = {Text = "Nigelman"},
  Event_80615_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80615_Desc = {
    Text = "\n\"Madre, dopo aver perso amici, marito e figlio, ora ho perduto per sempre Diana, la mia piccola.\"\n\"Quando si è ridotta in cenere davanti ai miei occhi, la mia mente si è svuotata...\" La scrittura che segue non è più leggibile.\nNon puoi fare altro che passare a leggere la riga successiva.\nHo preso la mia decisione. Se dovessi rivedervi, vi prego, non biasimatemi; io solo... mi mancate tutti troppo."
  },
  Event_80615_Name = {
    Text = "Nostalgia Svanita"
  },
  Event_80616_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80616_Desc = {
    Text = "Il tuo tentativo di scacciarli ha effetto. Alcune figure indistinte si contorcono e fuggono, la maggior parte resta.\nNon ridono più né intonano canti, ma piangono a dirotto.\nIl pianto di un bambino ti esplode nelle orecchie, ripetendo una sola frase.\n\"Uccidete il mostro!\""
  },
  Event_80616_Name = {
    Text = "\"Sua\"Infanzia"
  },
  Event_80617_ChoiceDesc1 = {
    Text = "[Leave] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_80617_ChoiceDesc2 = {
    Text = "[Leave] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_80617_ChoiceDesc3 = {
    Text = "[Leave] Sviluppa il Sintomo [(Skill.Arg1)]"
  },
  Event_80617_Desc = {
    Text = "Il tuo nutrimento compiace lo sciame di ratti.\nL'enorme sciame si contorce, donandoti un regalo avvolto rozzamente.\nNon riesci a distinguerne la forma, vedi solo una grande quantità di sangue che ne imbeve l'involucro."
  },
  Event_80617_Name = {
    Text = "Segreto della Cittadella"
  },
  Event_80618_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80618_Desc = {
    Text = "\"...\"\n\"......\"\n\".........\"\nL'ombra resta in silenzio, vorrebbe piangere ma ha perso la capacità di farlo.\nAlla fine, emette solo un profondo sospiro.\n\"Amico, spero che tu possa custodire le tue cose più preziose.\""
  },
  Event_80618_Name = {
    Text = "L'uomo vuoto"
  },
  Event_80619_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80619_Desc = {
    Text = "I tuoi rimproveri non hanno alcun effetto, li rendono solo più fanaticamente gioiosi.\nLe risate e i canti si fanno ancora più forti mentre intonano un'altra filastrocca:\n\"Il piccolo William, nel castello alto,\nTopi mangia-uomini corrono nel muro senza fallo.\nQuando il sacrificio umano è compiuto,\nOgnuno viene rosicchiato, uno per uno, in assoluto.\""
  },
  Event_80619_Name = {
    Text = "\"Sua\"Infanzia"
  },
  Event_80620_ChoiceDesc1 = {
    Text = "[Avoid Gaze] Risveglio di un Risvegliatore casuale"
  },
  Event_80620_ChoiceDesc2 = {
    Text = "[Stare] Scegli un Risvegliatore da Risvegliare, riduci il Costo di Arithmetica di quella Carta di 2, ma sviluppa [(Skill.Arg1)]."
  },
  Event_80620_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_80620_Desc = {
    Text = "Tutto nel Sanatorio è sotto il suo controllo e la sua sorveglianza. Naturalmente, anche tu.\nMa è disposta a chiudere un occhio per te.\nDopotutto, un gioco dev'essere reciproco per risultare più interessante."
  },
  Event_80620_Name = {
    Text = "Sguardo di \"Lei\""
  },
  Event_80621_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80621_Desc = {
    Text = "Rimetti la busta al suo posto e ti prepari ad andartene, ma all'improvviso odi un mormorio sognante.\n\"Dietro mia insistenza, la Dottoressa Clementine ha infine ceduto.\nNel vasto e misterioso universo che mi ha descritto, deve esserci un modo per salvarvi tutti.\nSono già pronta per la \"rinascita.\" Non importa quanti anni luce dovrò vagare, desidero ardentemente rivedervi ancora una volta.\""
  },
  Event_80621_Name = {
    Text = "Nostalgia Svanita"
  },
  Event_80622_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80622_Desc = {
    Text = "La Dott.ssa Clementine mi ha salvato.\nÈ davvero una persona molto, molto buona, disposta ad ascoltarmi.\nVorrei tanto dire qualcosa di gioioso e felice, eppure in questo momento non ho che dolore e disperazione.\nTemo di non riuscire a soddisfare le aspettative del Dottore.\nDopo averti perso, la vita per me è desolazione."
  },
  Event_80622_Name = {
    Text = "Nostalgia Svanita"
  },
  Event_80623_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80623_Desc = {
    Text = "\"Tu, tu...\"\n\"Hmph, tecnica niente male—questa volta, passi. La prossima non sarà così facile!\"\nIl gatto nero balza via agilmente, e gli altri lo seguono a ruota."
  },
  Event_80623_Name = {Text = "Nigelman"},
  Event_80624_ChoiceDesc1 = {
    Text = "[Attack the Cat] 50% di probabilità di ricevere 125 Sigilli Neri, 50% di probabilità di sviluppare [(Skill.Arg2)]"
  },
  Event_80624_ChoiceDesc2 = {
    Text = "[Meow Like a Cat] 75% di probabilità di ricevere 100 Sigilli Neri, 25% di probabilità di sviluppare [(Skill.Arg2)]"
  },
  Event_80624_ChoiceDesc3 = {
    Text = "[Attempt to Pet the Cat] Ricevi 50 Sigilli Neri"
  },
  Event_80624_Desc = {
    Text = "\"Ehi! Tu, fermo lì.\"\nDei gatti neri balzano fuori dalle ombre, bloccandoti il cammino.\nSi leccano le zampe con eleganza, il portamento arrogante e fiero.\n\"Il sentiero che ti attende è colmo di pericoli, non è cosa che un debole umano come te possa esplorare.\"\nEsprimi la tua determinazione a proseguire. Le pupille verticali del capo della colonia si spostano, rivelando una crudele intenzione di giocare con la preda. \"Allora mostraci la tua determinazione.\""
  },
  Event_80624_Name = {Text = "Nigelman"},
  Event_80625_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80625_Desc = {
    Text = "\nLa tua negligenza ha fatto infuriare lo sciame di ratti, che si precipitano verso di te con stridii, e tu, sei già fuggito lontano prima che la marea di ratti dilagasse."
  },
  Event_80625_Name = {
    Text = "Segreto della Cittadella"
  },
  Event_80626_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80626_Desc = {
    Text = "\"Ah, proprio così, spezzate le mie ali.\"\n\"Tempo, salute, dignità, vita... mi hanno portato via troppo.\"\n\"Quest'ultimo sogno, naturalmente, non mi appartiene.\"\n\"Perché non sono che un uccello rinchiuso e privato della libertà.\""
  },
  Event_80626_Name = {
    Text = "L'uomo vuoto"
  },
  Event_80627_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80627_Desc = {
    Text = [[
"Emotivo? Una risposta interessante."
"Spero che non rimpiangerai la tua Scelta."]]
  },
  Event_80627_Name = {
    Text = "Il Prezzo dell'Umanità"
  },
  Event_80628_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80628_Desc = {
    Text = "\"Accolgo la tua preghiera.\"\nIl ronzio si avvicinò, penetrando lentamente nel tuo cervello attraverso il condotto uditivo.\nIl tuo cervello tremò, e in quel tremito udisti la 'voce' dell'universo.\n\"Connettiti con me.\""
  },
  Event_80628_Name = {
    Text = "Salvezza Oscura"
  },
  Event_80629_ChoiceDesc1 = {
    Text = "[Pray] Risveglia un Risvegliatore casuale, ma sviluppa il Sintomo [(Skill.Arg1)]."
  },
  Event_80629_ChoiceDesc2 = {
    Text = "[Refuse] Incidi 1 Orazione su 3"
  },
  Event_80629_Desc = {
    Text = "\"Non dovrebbe essere così, non dovrebbe essere così.\"\n\"Io chiaramente, chiaramente avrei dovuto distaccarmi da questa misera vita umana ed evolvermi in qualcosa di superiore...\"\nNell'Oscurità, il suono di singhiozzi strazianti riecheggiava.\nQuei singhiozzi si raccoglievano e si gonfiavano, formando un ronzio tremendo.\n\"Questo mondo in fiamme, come un buco nero insaziabile, Divora ogni singola persona, perciò—\"\n\"Pregate me, l'universo infinito vi concederà la Redenzione.\""
  },
  Event_80629_Name = {
    Text = "Salvezza Oscura"
  },
  Event_80630_ChoiceDesc1 = {
    Text = "[Open the Envelope] Acquisisci la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\"."
  },
  Event_80630_ChoiceDesc2 = {
    Text = "[Read] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_80630_ChoiceDesc3 = {
    Text = "[Put it back]Ottieni 50 Il sigillo nero"
  },
  Event_80630_Desc = {
    Text = "In un angolo dimenticato, è stata lasciata una lettera.\nMolte parole sulla lettera sono diventate irriconoscibili, ma una parola rimane. Trafigge la carta.\nQuesta parola è \"Madre\"."
  },
  Event_80630_Name = {
    Text = "Nostalgia Svanita"
  },
  Event_80631_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80631_Desc = {
    Text = [[
"Heh, insignificante umano, hai fatto la scelta sbagliata."
I gatti neri ti fissano freddamente, poi improvvisamente contrattaccano.
"Per quanto rispettiamo i coraggiosi, devi pagarne il prezzo."]]
  },
  Event_80631_Name = {Text = "Nigelman"},
  Event_80632_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80632_Desc = {
    Text = "\nUna risata sommessa emerge dall'oscurità.\n\"Ti sto aspettando, perché tu venga a trovarmi.\"\n\"Adorabile piccolo insetto.\""
  },
  Event_80632_Name = {
    Text = "Sguardo di \"Lei\""
  },
  Event_80633_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80633_Desc = {
    Text = "Sotto il tuo attacco, queste figure contorte e bizzarre finalmente fuggirono.\nL'ambiente è silenzioso, solo il tuo battito cardiaco piange sommessamente.\nSi scopre che questa è la «Sua» Infanzia."
  },
  Event_80633_Name = {
    Text = "\"Sua\"Infanzia"
  },
  Event_80635_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80635_Desc = {
    Text = "\"Ah, la piccola trappola testuale è stata scoperta.\"\n\"Questa è una ricompensa. Perché...\"\n\"Non ogni scelta deve essere compiuta.\""
  },
  Event_80635_Name = {
    Text = "Il Prezzo dell'Umanità"
  },
  Event_80636_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80636_Desc = {
    Text = "\"@3 Ribelle\"\nIl ronzio si affievolisce gradualmente fino a scomparire, lasciando solo le ultime parole.\n\"Mantenere l'Umanità non permette di sopravvivere in questo mondo crudele.\""
  },
  Event_80636_Name = {
    Text = "Salvezza Oscura"
  },
  Event_80637_ChoiceDesc1 = {
    Text = "[Refuse] Distruggi una Carta di comando e ricevi Arg1 Sigilli Neri."
  },
  Event_80637_ChoiceDesc2 = {
    Text = "[Comply] Duplica una Carta di comando, ma sviluppi il Sintomo [(Skill.Arg1)]."
  },
  Event_80637_ChoiceDesc3 = {
    Text = "[Embrace] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_80637_Desc = {
    Text = "\"Sono un uccello in gabbia, intrappolato in un cortile pieno di molte stanze.\"\nFigure vaghe vagano nell'Oscurità—Frammenti Residui delle Ossessioni del defunto.\n\"Dicono che sia un Manicomio, ma io so che è una gabbia speciale per gli esseri umani, che imprigiona uccelli liberi che rifiutano di obbedire alle Regole sociali.\"\n\"Ma se un uccello non può volare, può ancora essere chiamato uccello?\"\nLe Ossessioni si radunano intorno a te, implorando la Redenzione.\n\"Per favore, spezzami le ali, sono stanco di volare.\""
  },
  Event_80637_Name = {
    Text = "L'uomo vuoto"
  },
  Event_80638_ChoiceDesc1 = {Text = "[Leave]"},
  Event_80638_Desc = {
    Text = "\"...\"\n\"......\"\n\".........\"\nL'ombra trema improvvisamente e si fonde nel tuo corpo.\n\"Amico, vai avanti, per proteggere le tue cose più preziose.\"\n\"Sebbene siamo già trapassati, siamo ancora disposti a offrirti la nostra ultima benedizione... per il tuo sogno.\""
  },
  Event_80638_Name = {
    Text = "L'uomo vuoto"
  },
  Event_80639_ChoiceDesc1 = {
    Text = "[Choose Emotion] Recupera Arg1 HP"
  },
  Event_80639_ChoiceDesc2 = {
    Text = "[Maintain Rationality] Incidi l'Orazione [(EnchantConfig.Arg1)] su una Carta di comando casuale."
  },
  Event_80639_ChoiceDesc3 = {
    Text = "[Refuse to Choose] Ricevi 25 Sigilli Neri"
  },
  Event_80639_Desc = {
    Text = "\"Scegli, scegli.\"\nNell'oscurità incalzante, innumerevoli sussurri riecheggiavano.\nLa voce è dolcemente ipnotica, sembra portare con sé una magia infinita che induce in te una sorta di folle fantasma.\nIl tuo cervello sprofonda nella follia, contorcendosi lontano dal corpo, mentre il cuore sembra aver sviluppato una propria coscienza, urlando e chiamandoti.\n\"Scegli, scegli.\"\n\"Mantenere la razionalità o l'emozione; devi fare una scelta.\""
  },
  Event_80639_Name = {
    Text = "Il Prezzo dell'Umanità"
  },
  Event_80641_ChoiceDesc1 = {
    Text = "[Scold \"Them\"] Acquisisci la Reliquia maledetta \"(RelicConfig.Arg2)\", ma sviluppi \"(Skill.Arg1)\"."
  },
  Event_80641_ChoiceDesc2 = {
    Text = "[Drive \"Them\" Away] Acquisisci le Reliquie d'argento \"(RelicConfig.Arg2)\" e \"(RelicConfig.Arg3)\", ma sviluppi \"(Skill.Arg1)\" due volte."
  },
  Event_80641_ChoiceDesc3 = {
    Text = "[Attack \"Them\"] Acquisisci la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_80641_Desc = {
    Text = "\"Piccolo William, che mostro che è,\nDorme nelle tombe, al freddo e al gelo.\nNessuno lo ama, state alla larga,\nO un giorno vi pugnalerà alle spalle.\"\nLe figure, dai contorni sfocati e i corpi contorti, parlano con voci di bambini.\nScherniscono e cantilenano, osservandoti con occhi colmi di disprezzo e di una strana bramosia.\nDa loro emana pura malevolenza."
  },
  Event_80641_Name = {
    Text = "\"Sua\"Infanzia"
  },
  Event_90571_ChoiceDesc1 = {
    Text = "[Indulge] Mescola 1 [Miscela Speciale di Soulsfeast] nel tuo mazzo."
  },
  Event_90571_Desc = {
    Text = "Un grande tavolo da pranzo, una vivace pista da ballo, stoviglie eleganti e il ricco aroma di cadaveri...\nOh, so che siete già impazienti, ma vi prego di attendere ancora un poco, caro ospite.\nQuesta bevanda, preparata appositamente dal padrone di casa del banchetto, è un dono esclusivo per gli ospiti d'onore.\nPrendetela tra le mani. Sorseggiatela. E nel suo retrogusto persistente, abbandonatevi a questa gioiosa occasione!"
  },
  Event_90571_Name = {
    Text = "Rituale Pre-Banchetto"
  },
  Event_91460_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91460_Desc = {
    Text = "Non hai difese, e puoi solo lasciare che il suono ti trafigga.\nUn grido acuto ti squarcia il cervello, e una paura dimenticata ne fuoriesce—ne avverti la fame.\nUna terrificante creatura cannibale..."
  },
  Event_91460_Name = {
    Text = "Confessione Silenziosa"
  },
  Event_91461_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91461_Desc = {
    Text = "Non ti trattieni più, lasciando che quella passione ardente si scateni pienamente, mentre tutte le parole mai dette erompono senza sosta dalla tua mente.\nAvverti una meravigliosa Intuizione, immergendoti nel Talento di Pickman."
  },
  Event_91461_Name = {
    Text = "Vulcano Dormiente"
  },
  Event_91462_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91462_Desc = {
    Text = "Le fiamme si avvolsero attorno alle macchie d'inchiostro, lasciando dietro di sé una scia di schizzi di sangue.\nIn quell'istante, cadesti sul confine tra sogno e realtà. Ti vedesti trasformato in una bambina, che prendeva la mano di Doresain e danzava con lui.\nQuando ti svegliasti e guardasti di nuovo Doresain, una profonda tristezza sopraffece la tua mente."
  },
  Event_91462_Name = {
    Text = "Rivelazione del Sogno"
  },
  Event_91463_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91463_Desc = {
    Text = "Ti slanci in avanti, le fiamme svaniscono sotto la tua pelle. Quanto al dipinto, chiunque lo osservi non vi scorge altro che un comune ritratto.\nNei sogni che seguono, ti vedi sempre ardere — arrostito alla perfezione — prima di essere servito sulla tua stessa tavola da pranzo, un giorno."
  },
  Event_91463_Name = {
    Text = "Ritratto in Fiamme"
  },
  Event_91464_ChoiceDesc1 = {
    Text = "[Listen] Ricevi 30 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_91464_ChoiceDesc2 = {
    Text = "[Ignore] Lascia"
  },
  Event_91464_Desc = {
    Text = "Nella silenziosa cacofonia, comprendi gradualmente le parole del corvo..."
  },
  Event_91464_Name = {
    Text = "Confessione Silenziosa"
  },
  Event_91465_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91465_Desc = {
    Text = "Raccogli una Pietra e risvegli le Ombre dei ratti, concentrate e intente a rodere.\nTi fissano con avidità.\nSenti l'odore umido e lurido dei loro corpi, come se fosse una sorta di presagio."
  },
  Event_91465_Name = {
    Text = "Regno dell'Esilio"
  },
  Event_91466_ChoiceDesc1 = {
    Text = "[Listen] Ricevi 25 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_91466_ChoiceDesc2 = {
    Text = "[Ignore] Lascia"
  },
  Event_91466_Desc = {
    Text = "Ti dà il benvenuto. A chi?\nA te, naturalmente!\nForse ti vede come il delizioso pasto di domani."
  },
  Event_91466_Name = {
    Text = "Confessione Silenziosa"
  },
  Event_91467_ChoiceDesc1 = {
    Text = "[Tagliarsi il palmo] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_91467_ChoiceDesc2 = {
    Text = "[Accept Growth] Ottieni la Reliquia d'argento \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_91467_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_91467_Desc = {
    Text = "Quella farfalla non volò dentro, ma piuttosto crebbe lentamente dal palmo della tua mano.\nAll'inizio, pensasti fosse solo sudore, ma tra le dita vedesti un liquido nero trasudare come un flusso invertito di vene, che si rapprendeva in ali fredde e pulsanti.\nOgni volta che batte le ali, invia increspature nel tuo flusso sanguigno."
  },
  Event_91467_Name = {Text = "Parassita"},
  Event_91468_ChoiceDesc1 = {
    Text = "[Salvare il Ritratto] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_91468_ChoiceDesc2 = {
    Text = "[Accettare il Vuoto] Scegli 1 Carta di comando tra 3 per ottenere l'Orazione: \"(EnchantConfig.Arg1)\", infetta \"(Skill.Arg2)\""
  },
  Event_91468_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 25 Sigilli Neri"
  },
  Event_91468_Desc = {
    Text = "Ti trovi dinanzi al Dono di Pickman.\nÈ un ritratto dipinto col sangue, con fiamme nerissime che ardono in silenzio.\nAttraverso le orbite vuote della figura nel dipinto, vedi—\nI tuoi ricordi che si agitano e bruciano, si allungano, si distorcono, risplendono, come se un fuoco informe lambisse i corridoi della tua mente. Nel tuo stordimento, odi una voce.\n\"È ora di cucinare. La temperatura è perfetta.\"\nQuesta è la scena stessa della tua memoria forgiata—ti contorci e ti dimeni tra le fiamme."
  },
  Event_91468_Name = {
    Text = "Ritratto in Fiamme"
  },
  Event_91469_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91469_Desc = {
    Text = [[
Ti rifiuti di rispondere, osservando in silenzio le vibrazioni fino a quando cessano.
Nel corso degli anni, hai imparato da tempo a combattere contro la Follia.]]
  },
  Event_91469_Name = {
    Text = "Chiamata Persa"
  },
  Event_91470_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91470_Desc = {
    Text = "Fai un passo indietro e lasci che la tela bruci tra le fiamme.\nOsservi la tua immagine assumere un invitante color bruno dorato, il grasso che sfrigola e crepita. Quasi ti sembra di percepire l'aroma di carne arrostita attraverso la tela.\nÈ questa la tentazione che prova Doresain?"
  },
  Event_91470_Name = {
    Text = "Ritratto in Fiamme"
  },
  Event_91471_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91471_Desc = {
    Text = "Spinta da una curiosità quasi sacrilega, o forse da un disperato coraggio di affrontare l'ignoto, cerchi la rivelazione tra le ombre del passato.\nVedi una ragazza danzare con un uomo alto dal volto indistinto, e una gioia inspiegabile ti colma il cuore."
  },
  Event_91471_Name = {
    Text = "Ombre del Passato"
  },
  Event_91472_ChoiceDesc1 = {
    Text = "[End Record] Distruggi 2 Carte qualsiasi"
  },
  Event_91472_ChoiceDesc2 = {
    Text = "[Continue Writing] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_91472_ChoiceDesc3 = {
    Text = "[Leave] Ricevi Arg1 Sigilli Neri"
  },
  Event_91472_Desc = {
    Text = "Sei finalmente riuscito a sfuggire temporaneamente al mercato dei ghoul, trovando un angolo tranquillo per iniziare a registrare come al solito.\nLa Macchina da scrivere ha iniziato a vibrare violentemente, i suoi tasti si premevano su e giù da soli, mentre un liquido nero e viscoso fuoriusciva dalle fessure, schizzando sulle tue dita e inzuppando il tuo senso della ragione.\nHai visto un'ombra di Farfalla emergere gradualmente e farsi vivida sulla carta..."
  },
  Event_91472_Name = {
    Text = "Ombre di Farfalle"
  },
  Event_91473_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91473_Desc = {
    Text = "Stranamente, sebbene sia una lingua che non hai mai studiato, in qualche modo ne comprendi il significato.\nIl verso è colmo di nostalgia per le persone amate, una nostalgia che trascende la vita e la morte, trasmessa a te attraverso il tuo sogno.\nRiconosci vagamente la calligrafia in fondo al poema—\nÈ Celina."
  },
  Event_91473_Name = {
    Text = "Rivelazione del Sogno"
  },
  Event_91474_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91474_Desc = {
    Text = [[
Sopporti il dolore mentre tagli la pelle del palmo, usando le fiamme per bruciare la carne alata appena formatasi.
Il liquido nero evapora e le farfalle si frantumano.
Tutto diventa pulito e privo di segni, eppure non puoi fare a meno di avvertire una lieve sensazione di battito nel palmo, come se il pensiero di qualcosa mai completamente schiuso respirasse ancora lentamente nelle tue vene.
Doresain non esprime alcuna opinione al riguardo, limitandosi a raccogliere il sangue che hai lasciato.]]
  },
  Event_91474_Name = {Text = "Parassita"},
  Event_91475_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91475_Desc = {
    Text = "Sai che un'Intuizione fervente conduce sempre al Cataclisma, perciò sigilli ogni cosa con la ragione."
  },
  Event_91475_Name = {
    Text = "Vulcano Dormiente"
  },
  Event_91476_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91476_Desc = {
    Text = "Fissi intensamente l'Occhio, cercando di decifrare il messaggio che trasmette.\nSebbene tu sia ormai temprato da innumerevoli battaglie, questa volta di fronte a Golia... la paura ti attanaglia il cuore.\n\"Quasi Normale— è la forma più quieta prima che il Cataclisma si manifesti.\""
  },
  Event_91476_Name = {
    Text = "Quasi Normale"
  },
  Event_91477_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91477_Desc = {
    Text = "Chiudi gli occhi e ti volti per incamminarti nelle terre selvagge.\nPercepisci il desiderio e il presagio nascosti, ma non sarai mai in grado di sedarli con le tue stesse mani.\nTi guardi intorno tra le lapidi senza nome. Forse è così che la tua storia finisce."
  },
  Event_91477_Name = {
    Text = "Banchetto dei Corvi"
  },
  Event_91478_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91478_Desc = {
    Text = "Sollevi lentamente il capo. In quell'istante, la luce trafigge le tue pupille e un calore bruciante sboccia in un vuoto dentro la tua mente.\nLe stelle di Necrovia non sono diverse da quelle di altrove, eppure persino i ghoul apparentemente eterni possono solo vivere sotto le stelle, privi di libertà."
  },
  Event_91478_Name = {
    Text = "Notte delle Stelle"
  },
  Event_91479_ChoiceDesc1 = {
    Text = "[Throw into the Flames] Distruggi una Carta"
  },
  Event_91479_ChoiceDesc2 = {
    Text = "[Attempt Interpretation] Ottieni la Reliquia \"(RelicConfig.Arg1)\", ma sviluppi il Sintomo \"(Skill.Arg2)\"."
  },
  Event_91479_Desc = {
    Text = "La tua coscienza fluttua e vaga in un mare infinito di nebbia nera, attraversando i paesaggi mentali di innumerevoli anime vive e morte.\nNel tuo sogno, una strana macchina da scrivere produce un passaggio di versi sconosciuti. Di chi è questa storia?\nÈ impressa su carta di origine ignota, la sua grafia distorta somiglia a quella di un ubriaco sobrio.\nSpinto da un impulso indescrivibile nel sogno, raccogli il foglio — l'inchiostro danza nella luce tremolante del focolare."
  },
  Event_91479_Name = {
    Text = "Rivelazione del Sogno"
  },
  Event_91480_ChoiceDesc1 = {
    Text = "[Apply] Incidi l'Orazione \"(EnchantConfig.Arg2)\" su una Carta di comando casuale, ma sviluppa \"(Skill.Arg1)\"."
  },
  Event_91480_ChoiceDesc2 = {
    Text = "[Drive] Incidi l'Orazione \"(EnchantConfig.Arg2)\" su una Carta di comando casuale, ma sviluppa \"(Skill.Arg1)\"."
  },
  Event_91480_ChoiceDesc3 = {
    Text = "[Ostracise] Incidi l'Orazione [(EnchantConfig.Arg1)] su una Carta di comando casuale."
  },
  Event_91480_Desc = {
    Text = "Odi il suono fioco e lontano di un corno d'osso.\nLo sciame di ratti emerge dal fango nero, attirato dal suono, rodendo il cadavere senza nome che giace sul letto asciutto del fiume.\nFormano un cerchio — al centro vi sono le spoglie vuote, mentre la circonferenza segna un nuovo regno governato dalla legge dell'oblio.\nE tu ti trovi all'ingresso di questo regno."
  },
  Event_91480_Name = {
    Text = "Regno dell'Esilio"
  },
  Event_91481_ChoiceDesc1 = {
    Text = "[Look Up] Ottieni la Reliquia d'argento [(RelicConfig.Arg1)]"
  },
  Event_91481_ChoiceDesc2 = {
    Text = "[Black Sigil] Ricevi 75 Sigilli Neri, ma sviluppi il Sintomo [(Skill.Arg2)]"
  },
  Event_91481_Desc = {
    Text = "I corvi vorticano nel cielo come una sega esitante, segando più e più volte la spina dorsale dei cieli.\nVolano bassi intorno a te, come se prevedessero la tua morte, attendendo pazienti l'inizio del banchetto."
  },
  Event_91481_Name = {
    Text = "Banchetto dei Corvi"
  },
  Event_91482_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91482_Desc = {
    Text = "Lasci che continui a scrivere, con il tuo battito, il tuo senso del dolore, il tuo passato e la tua immaginazione.\nLa farfalla si libera dai vincoli della carta, e la tua anima la segue in volo.\nCominci a immaginarti mentre ti godi il parco divertimenti. Quello che non hai detto a Doresain è che, in verità, i parchi divertimenti ti piacciono davvero — anche se si tratta di uno a tema cadaveri...\nSpero... che non sia troppo bizzarro."
  },
  Event_91482_Name = {
    Text = "Ombre di Farfalle"
  },
  Event_91483_ChoiceDesc1 = {
    Text = "[Reobserve] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_91483_Desc = {
    Text = "La cena un tempo limpida si è trasformata in un banchetto sanguinolento e indistinto. Ricordi gli ingredienti sui fornelli, e il fetore della decomposizione ti assale le narici.\nLa paura ti attanaglia il cuore—devi fare una scelta."
  },
  Event_91483_Name = {
    Text = "Ombre del Passato"
  },
  Event_91484_ChoiceDesc1 = {
    Text = "[Ignore the Ring] Incidi 1 Orazione Avanzata su 3"
  },
  Event_91484_ChoiceDesc2 = {
    Text = "[Pick up the Receiver] Ottieni la Reliquia dorata \"(RelicConfig.Arg1)\", ma sviluppi \"(Skill.Arg2)\""
  },
  Event_91484_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_91484_Desc = {
    Text = "Non avrebbe dovuto squillare—il telefono, raggomitolato dietro la tela.\nIl cavo si avvolge attorno al corpo massiccio dell'apparecchio come un cordone ombelicale arrugginito, e sembra estendersi dalla tua stessa mente.\nCerchi di discernere con attenzione la frequenza della vibrazione; il suono sinistro ricorda l'arte surreale di Pickman."
  },
  Event_91484_Name = {
    Text = "Chiamata Persa"
  },
  Event_91485_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91485_Desc = {
    Text = "Culli il cervello freddo, ma in un istante si tramuta in acqua, scivolando silenziosamente tra le tue dita.\nLa bilancia perde immediatamente l'equilibrio, e il cuore collassa come un frutto marcio, dissolvendosi in una pozza di acqua nera e silenziosa.\nOgni fame svanisce; ora possiedi una calma agghiacciante, nessun rimpianto, e una fugace lucidità."
  },
  Event_91485_Name = {
    Text = "Giochi della Fame"
  },
  Event_91486_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91486_Desc = {
    Text = [[
Nessun suono, nessuna risposta. Potrebbe essere stato solo uno scherzo?
Mentre posi la cornetta, un'emozione greve ti risale dentro.]]
  },
  Event_91486_Name = {
    Text = "Chiamata Persa"
  },
  Event_91487_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91487_Desc = {
    Text = "Il corvo scompare.\nMa ti vedi riflesso nello specchio di un'altra notte, intento a fissare questo corvo.\nAnche lì stride in silenzio, come se attendesse la tua risposta."
  },
  Event_91487_Name = {
    Text = "Confessione Silenziosa"
  },
  Event_91488_ChoiceDesc1 = {
    Text = "[Reobserve] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_91488_ChoiceDesc2 = {
    Text = "[Give Up] Sviluppa il Sintomo [(Skill.Arg1)] e cambia l'Orazione da incidere.(Utilizzi: 1/2)"
  },
  Event_91488_Desc = {
    Text = "Distogli risolutamente lo sguardo, eppure quelle immagini persistono come fantasmi nella tua Visuale...\nÈ un duetto di Pianto."
  },
  Event_91488_Name = {
    Text = "Ombre del Passato"
  },
  Event_91489_ChoiceDesc1 = {
    Text = "[Consume] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_91489_ChoiceDesc2 = {
    Text = "[Decline] Sviluppa il Sintomo [(Skill.Arg1)] e cambia l'Orazione da incidere.(Utilizzi: 2/2)"
  },
  Event_91489_Desc = {
    Text = "È stato preparato con cura da Doresain per la tua ardua indagine.\nSenza condimenti eppure inodore, come ha detto Doresain, questo è l'ingrediente più pregiato.\nIl banchetto è imbandito per te, e il cervello giace silenzioso nel piatto.\n\"Vorresti assaggiarlo?\""
  },
  Event_91489_Name = {
    Text = "Assaporare la Prelibatezza"
  },
  Event_91490_ChoiceDesc1 = {
    Text = "[Listen] Ricevi 40 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_91490_ChoiceDesc2 = {
    Text = "[Disregard] Ricevi 25 Sigilli Neri e vattene."
  },
  Event_91490_Desc = {
    Text = "È un corvo.\nSe ne sta appollaiato su una lampada a forma di teschio, apre il becco, ma non emette alcun suono."
  },
  Event_91490_Name = {
    Text = "Confessione Silenziosa"
  },
  Event_91491_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91491_Desc = {
    Text = "Lentamente tendi la mano verso quel cuore ancora tiepido; esso pulsa e si contrae, fino a dissiparsi in un fragrante sbuffo di calore.\nLa bilancia trema violentemente, e il tuo cervello precipita in un'oscurità senza fine.\nUna sensazione di sazietà sostituisce la fame, e giungi a comprendere la passione, il dolore e la vera Memoria."
  },
  Event_91491_Name = {
    Text = "Giochi della Fame"
  },
  Event_91492_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91492_Desc = {
    Text = "Alzi il capo, accogliendo la rotazione silenziosa, come un pellegrino in un antico rito.\nBanchettano gioiosamente sulla tua carne; provi dolore, eppure lucidità.\nVedi il tuo io perduto—le parti che non sono riuscite a morire—finalmente portate via.\nQuando la coscienza ritorna, ti ritrovi illeso."
  },
  Event_91492_Name = {
    Text = "Banchetto dei Corvi"
  },
  Event_91493_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91493_Desc = {
    Text = "Hai usato cemento fatto di memorie ed emozioni per sigillare il buco della serratura, lasciando la verità impotente nel tentarti.\nVedendo la tua postura, come se ti trovassi di fronte a un nemico formidabile, Doresain si leccò le labbra.\n\"Vorresti riprovare? Questa è una Mozzarella di Fogliacerebrale preparata appositamente, creata in esclusiva per {Male=Sig.,Female=Sig.na} Custode.\""
  },
  Event_91493_Name = {
    Text = "Rivelazione"
  },
  Event_91494_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91494_Desc = {
    Text = "In realtà, sei sempre stato curioso di sapere cosa si provi a essere un ghoul.\n\"Così ti addentri nello sciame di ratti e diventi uno di loro—\"\nDevi ammetterlo, l'Avvento del Navigatore ha reso la tua mente un po' annebbiata."
  },
  Event_91494_Name = {
    Text = "Regno dell'Esilio"
  },
  Event_91495_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91495_Desc = {
    Text = [[
Rifiuti di essere contaminato dalla corruzione e dal Caos.
Ti ci sei abituato da tempo; ogni Decomposizione ti sembra la norma.]]
  },
  Event_91495_Name = {
    Text = "Regno dell'Esilio"
  },
  Event_91496_ChoiceDesc1 = {
    Text = "[Consume] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_91496_ChoiceDesc2 = {
    Text = "[Decline] Sviluppa il Sintomo [(Skill.Arg1)] e cambia l'Orazione da incidere.(Utilizzi: 1/2)"
  },
  Event_91496_Desc = {
    Text = [[
Doresain ti taglia con eleganza un pezzo di "cervello".
Quel sapore dolce...
Quella consistenza morbida e delicata...
Vorresti davvero prenderne un altro boccone.]]
  },
  Event_91496_Name = {
    Text = "Assaporare la Prelibatezza"
  },
  Event_91497_ChoiceDesc1 = {
    Text = "[I'm Dreaming] Ottieni la Reliquia d'Argento [(RelicConfig.Arg1)]"
  },
  Event_91497_ChoiceDesc2 = {
    Text = "[This is Not Normal] Ottieni la Reliquia d'Oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_91497_Desc = {
    Text = "Una lapide levigata riflette un occhio che si sta lentamente distorcendo.\nCome se portasse un'immagine oltre ogni descrizione visiva, una memoria che non ti appartiene si è profondamente insediata nelle pieghe dei tuoi occhi.\nProvi a sbattere le palpebre, a cancellarla con la punta delle dita, ma quell'occhio non ti appartiene più — comincia a riflettere una scena caleidoscopica."
  },
  Event_91497_Name = {
    Text = "Quasi Normale"
  },
  Event_91498_ChoiceDesc1 = {
    Text = "[Continue Observation] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_91498_ChoiceDesc2 = {
    Text = "[Look Away] Sviluppa il Sintomo [(Skill.Arg1)] e cambia l'Orazione da incidere.(Utilizzi: 2/2)"
  },
  Event_91498_Desc = {
    Text = "In un angolo umido dell'antico castello, scopristi quella bobina di pellicola.\nLe immagini somigliano a fantasmi annegati nel fiume del tempo, che si cristallizzano al rallentatore — talvolta espandendosi in forme colossali indescrivibili, talvolta collassando in stelle tremolanti.\nPerso in esse, un'improvvisa vertigine ti ricordò il passaggio del tempo."
  },
  Event_91498_Name = {
    Text = "Ombre del Passato"
  },
  Event_91499_ChoiceDesc1 = {
    Text = "[Gaze at the Stars] Ottieni la Reliquia d'oro \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_91499_ChoiceDesc2 = {
    Text = "[Close Your Eyes] Risveglia 2 Risvegliatori casuali, ma sviluppa [(Skill.Arg1)] due volte."
  },
  Event_91499_ChoiceDesc3 = {
    Text = "[Leave] Ricevi 50 Sigilli Neri"
  },
  Event_91499_Desc = {
    Text = "Ti trovi in un cimitero abbandonato, dove la presenza delle stelle illumina la notte come fosse giorno.\nLe sfere di luce fluttuanti nelle profondità insondabili del tempo restano silenziose, eppure convergono lentamente attraverso rotazioni infinite come deliri in un sogno.\nEsse contemplano la stella solitaria dimenticata.\nEgli contempla te, contempla ogni morte e ogni eternità."
  },
  Event_91499_Name = {
    Text = "Notte delle Stelle"
  },
  Event_91500_ChoiceDesc1 = {
    Text = "[Listen] Ricevi 20 Sigilli Neri, ma sviluppa [(Skill.Arg2)]"
  },
  Event_91500_ChoiceDesc2 = {
    Text = "[Ignore] Lascia"
  },
  Event_91500_Desc = {
    Text = "Incroci il suo sguardo.\nNell'oscurità più nera, scorgi il fuoco selvaggio dell'avidità."
  },
  Event_91500_Name = {
    Text = "Confessione Silenziosa"
  },
  Event_91501_ChoiceDesc1 = {
    Text = "[Open Socket] Ottieni la Reliquia maledetta \"(RelicConfig.Arg1)\", ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_91501_ChoiceDesc2 = {
    Text = "[Sigillare la serratura] 1 Carta casuale ottiene l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_91501_Desc = {
    Text = "Resisti più volte mentre Doresain ti offre il lobo cerebrale, ma alla fine non riesci a resistere alla tentazione della conoscenza.\nLa saggezza non giunge gradualmente, ma si riversa all'improvviso.\nLa testa inizia a dolerti e i tuoi pensieri si espandono come pane che lievita. Quando infine crolli, il dolore si ritira come una marea, lasciando nella tua coscienza un buco di serratura cavo e antico.\nDunque questa è la forma della conoscenza! Avverti un'ondata di saggezza senza precedenti.\nForse... puoi ottenerne ancora di più?"
  },
  Event_91501_Name = {
    Text = "Rivelazione"
  },
  Event_91502_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91502_Desc = {
    Text = "Hai usato la lama residua della tua coscienza per scrutare attraverso quella serratura.\nNon sapevi cosa fosse una chiave, così ti sei affidato unicamente all'ossessione per tentare.\nIn quell'istante, i tuoi pensieri bruciarono completamente, lasciando solo qualcosa di disumano a sussurrare nel vuoto della serratura.\nÈ questa la sensazione della rivelazione? L'hai condivisa con entusiasmo con Doresain.\n\"Vorresti provare? Questa è una speciale mozzarella cerebrale preparata esclusivamente per il {Male=Sig.,Female=Sig.na} Custode.\""
  },
  Event_91502_Name = {
    Text = "Rivelazione"
  },
  Event_91503_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91503_Desc = {
    Text = "Non la fai detonare, né la sopprimi.\nIn un sottile Stato di distaccata Osservazione, consideri i pensieri tumultuosi come parte del mutare del clima, lasciandoli fluire naturalmente verso una conclusione ignota.\nNel dipinto di sangue e carne, giungi ad apprezzare l'arte dell'eternità."
  },
  Event_91503_Name = {
    Text = "Vulcano Dormiente"
  },
  Event_91504_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91504_Desc = {
    Text = [[
I tasti si fermano all'improvviso, e le ombre di farfalle svaniscono in un istante.
Era un'illusione? Avverti un senso di perdita.
Forse dovrei dare ascolto a Doresain e comprare qualche foglia di cervello dal negozio di conserve della memoria.
"No, cosa sto pensando?"]]
  },
  Event_91504_Name = {
    Text = "Ombre di Farfalle"
  },
  Event_91505_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91505_Desc = {
    Text = "Smetti di lottare e permetti alle ali e al liquido nero di Perforare il tuo palmo.\nDiventi il suo vascello, e quello ti usa come guscio, proseguendo i suoi pensieri.\nLa Farfalla cresce sempre di più, finché non riesci più a sopportarne il peso.\nVedendo ciò, Doresain recide avidamente il legame tra te e la Farfalla con un coltello da tavola. Lo sguardo famelico nei suoi occhi rivela chiaramente il suo Desiderio...\nRifiuti la sua richiesta."
  },
  Event_91505_Name = {Text = "Parassita"},
  Event_91506_ChoiceDesc1 = {
    Text = "[Listen] Ricevi 35 Sigilli Neri, sviluppa [(Skill.Arg2)] e continua a scegliere."
  },
  Event_91506_ChoiceDesc2 = {
    Text = "[Ignore] Lascia"
  },
  Event_91506_Desc = {
    Text = "Credevi fosse silenzioso, finché la tua coscienza non si è improvvisamente inclinata, come se i teschi di innumerevoli corvi stessero stridendo dentro la tua mente.\nCadi in ginocchio, e il mondo vortica davanti ai tuoi occhi."
  },
  Event_91506_Name = {
    Text = "Confessione Silenziosa"
  },
  Event_91507_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91507_Desc = {
    Text = "Chiudi gli occhi e avanzi nell'infinita, soffice foschia di polvere, dove la nebulosa ti avvolge e perdi la tua forma — una presenza più stabile del tuo corpo si insedia dentro di te.\nQuella notte, le stelle continuarono a ruotare, luminose come sempre.\nPer un essere immortale, cosa significa il cielo stellato? Forse dovresti andare a chiederlo a Doresain."
  },
  Event_91507_Name = {
    Text = "Notte delle Stelle"
  },
  Event_91508_ChoiceDesc1 = {
    Text = "[Consume] Incidi l'Orazione [(EnchantConfig.Arg1)] su 1 di 3 Carte di comando."
  },
  Event_91508_Desc = {
    Text = "Si rivela essere formaggio. Mentre provi sollievo, avverti anche una punta di rimpianto."
  },
  Event_91508_Name = {
    Text = "Assaporare la Prelibatezza"
  },
  Event_91509_ChoiceDesc1 = {
    Text = "[Ignite] Ottieni la Reliquia d'argento \"(RelicConfig.Arg2)\", ma sviluppa \"(Skill.Arg1)\"."
  },
  Event_91509_ChoiceDesc2 = {
    Text = "[The Vigil] Ottieni la Reliquia d'argento \"(RelicConfig.Arg2)\", ma sviluppa \"(Skill.Arg1)\"."
  },
  Event_91509_ChoiceDesc3 = {
    Text = "[Sealed] Ricevi 25 Sigilli Neri"
  },
  Event_91509_Desc = {
    Text = "Fissi lo sguardo sul dipinto di Pickman, e il nauseabondo fetore di Decomposizione ti lascia stordito.\nI pensieri affiorano lentamente dalla tua mente — prima solo calore, poi nebbia, e infine—"
  },
  Event_91509_Name = {
    Text = "Vulcano Dormiente"
  },
  Event_91510_ChoiceDesc1 = {
    Text = "[Touch the Brain] Incidi l'Orazione [(EnchantConfig.Arg1)] su una Carta di comando casuale."
  },
  Event_91510_ChoiceDesc2 = {
    Text = "[Touch the Heart] Aumenta gli HP massimi di Arg1, ma sviluppa il Sintomo [(Skill.Arg2)]."
  },
  Event_91510_Desc = {
    Text = "Varchi la soglia di una sala grigia e silenziosa, dove nessun sussurro indugia, e una coppia di bilance emerge fiocamente dalla foschia oscura.\nA sinistra, un cervello calmo come un lago, i cui solchi bianco-argentei brillano debolmente; a destra, un cuore rosso ardente che emana vapore e calore.\nAll'improvviso, avverti un aroma fragrante. Un desiderio insaziabile cresce dentro di te, e la tua ragione viene compressa dalla Sua oscurità sconfinata.\nTendi la mano."
  },
  Event_91510_Name = {
    Text = "Giochi della Fame"
  },
  Event_91511_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91511_Desc = {
    Text = "Deve essere un sogno, continui a convincerti.\nPrima di rendertene conto, ti sei davvero addormentato.\nForse a causa delle troppe interazioni recenti, hai effettivamente sognato Doresain—lasciare intenzionalmente che Doresain consumi il tuo stesso sangue e la tua carne? Che razza di storia dell'orrore è questa?"
  },
  Event_91511_Name = {
    Text = "Quasi Normale"
  },
  Event_91660_ChoiceDesc1 = {
    Text = "[Trovare un'altra via] Scegli 1 tra 3 Carte di comando per ottenere l'Orazione: [(EnchantConfig.Arg1)]"
  },
  Event_91660_ChoiceDesc2 = {
    Text = "[Let It Be] Incidi l'Orazione \"(EnchantConfig.Arg1)\" su 3 Carte di comando casuali, ma sviluppa \"(Skill.Arg2)\"."
  },
  Event_91660_Desc = {
    Text = "\"Guida l'anima — devi condurre i morti fino alla fine.\"\nMentre Doresain parla, avverti un'improvvisa epifania.\nNon è conoscenza, né memoria — sembra piuttosto un peso, che entra attraverso i tuoi occhi e inonda la tua mente come un torrente.\nLe tue emozioni non sembrano più appartenere a questo istante; si ritraggono, rivelando una fessura trascurata dall'universo.\nTutto ciò che riesci a percepire semplicemente si arresta lì, come se avessi raggiunto la fine ultima di un sentiero."
  },
  Event_91660_Name = {
    Text = "Fine dell'Anima"
  },
  Event_91661_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91661_Desc = {
    Text = "Lasci vagare la tua anima lontano.\nAl confine del \"sé\", ti sembra di udire il sussurro dei defunti.\nMa quando tendi l'orecchio, tutto svanisce."
  },
  Event_91661_Name = {
    Text = "Fine dell'Anima"
  },
  Event_91662_ChoiceDesc1 = {Text = "[Leave]"},
  Event_91662_Desc = {
    Text = "Hai avvolto la tua coscienza, isolandoti così dalle tentazioni sconosciute.\nTi sei smarrito ai confini della tua anima, vedendo soltanto te stesso.\nCome previsto, in quanto persona vivente, non puoi possedere le capacità di un ghoul."
  },
  Event_91662_Name = {
    Text = "Fine dell'Anima"
  }
})
return Text_Event
