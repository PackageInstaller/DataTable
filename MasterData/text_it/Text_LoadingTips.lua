__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_LoadingTips = readonly({
  LoadingTips_17465_LoadingTips = {
    Text = "L'Affinità è il grado di sincronizzazione spirituale tra l'Investigatore/Custode e il Risvegliato a loro assegnato.\nUn'Affinità più elevata implica una comprensione reciproca più profonda, un legame più stretto e una fiducia più salda."
  },
  LoadingTips_17466_LoadingTips = {
    Text = "Nel Dominio, emozioni, pensieri e ossessioni possono generare proiezioni illusorie e osservabili, capaci di ingannare i sensi della Dimensione reale."
  },
  LoadingTips_17467_LoadingTips = {
    Text = "Il Trasferimento di gnosi è uno strumento contenuto nelle valigette degli Investigatori/Custodi che trasferisce la coscienza in Carte di comando ad alta dimensionalità, visualizzabili solo tramite un dispositivo di Osservazione della Dissoluzione."
  },
  LoadingTips_17468_LoadingTips = {
    Text = "Una D-fessura generata non può essere ridotta né terminata.\nI mezzi ordinari sono inefficaci contro le D-fessure; solo una Chiave d'argento può sopprimerle o \"chiuderle\"."
  },
  LoadingTips_17469_LoadingTips = {
    Text = "La maggior parte degli individui colpiti dall'Erosione da Dissoluzione soffre di pensieri disturbati, manifestando paranoia, Ossessione, iperattività e perdita di Memoria."
  },
  LoadingTips_17470_LoadingTips = {
    Text = "L'Erosione da Dissoluzione colpisce organismi organici (esseri umani, animali, piante) e sostanze inorganiche (minerali, metalli).\nAd oggi, non è stata trovata alcuna sostanza Immune al fenomeno della Dissoluzione."
  },
  LoadingTips_17471_LoadingTips = {
    Text = "La stragrande maggioranza degli esseri umani non è in grado di osservare il fenomeno della Dissoluzione a occhio nudo."
  },
  LoadingTips_17472_LoadingTips = {
    Text = "Le entità Dissolte vengono grossolanamente classificate in base alle loro Mutazioni. I tipi comuni sono i Dissoluti Collaborativi, da Interferenza e Dissoluti Compositi."
  },
  LoadingTips_17473_LoadingTips = {
    Text = "Il fenomeno della Dissoluzione si manifesta come piccole aperture a forma di uno o più triangoli rovesciati.\nQueste aperture variano da 3mm a 1cm; i segni della Dissoluzione si allargano gradualmente con il progredire del processo."
  },
  LoadingTips_17474_LoadingTips = {
    Text = "La Dissoluzione è un fenomeno materiale speciale, caratterizzato a livello regionale, di disfacimento e decadimento."
  },
  LoadingTips_17475_LoadingTips = {
    Text = [[
Dopo che il fenomeno della Dissoluzione raggiunge un certo Livello, organismi parassitari possono emergere dai segni.
Possono essere arti aggiuntivi, Tentacoli, o persino ingranaggi, metallo...]]
  },
  LoadingTips_17476_LoadingTips = {
    Text = "La D-melma è idrofoba, impermeabile, ha viscosità media, una certa estensibilità ed è difficile da sciogliere in acqua.\nCentinaia di anni fa, esseri umani incauti tentarono di utilizzarla come materia prima industriale e artistica."
  },
  LoadingTips_17477_LoadingTips = {
    Text = "\"Benvenuto al Barn — dove abbiamo il maggior numero di schedari e il minor numero di funerali.\"\nPer via della sua natura fonetica, l'Ufficio Archivio e Registri del MTC è scherzosamente chiamato \"Barn\" dai Membri del Comitato."
  },
  LoadingTips_17478_LoadingTips = {
    Text = "I membri dell'Associazione degli Scultori talvolta si definiscono \"Pigmalione,\" e il logo della loro organizzazione è uno scalpello."
  },
  LoadingTips_17479_LoadingTips = {
    Text = "La Dissoluzione non è riconosciuta dal mondo secolare, ma in certi circoli occulti si crede che sia una Parola Divina di Redenzione, non un disastro."
  },
  LoadingTips_17480_LoadingTips = {
    Text = "Un grande segno di Dissoluzione largo oltre 5 metri, con potenziale di espansione, è definito D-fessura.\nIl nucleo della fessura è noto come \"Cataclisma\"."
  },
  LoadingTips_17481_LoadingTips = {
    Text = "La Gnosi d'Emergenza agisce direttamente sullo Spirito del Risvegliato, ripristinandone istantaneamente lo Stato e stimolandone il potenziale; l'unico svantaggio è il suo costo elevato."
  },
  LoadingTips_17482_LoadingTips = {
    Text = "Le missioni sul campo mutano costantemente e sono altamente imprevedibili.\nPer far fronte a ciò, l'Università di Mythag fornisce dispositivi d'emergenza al personale operativo per garantire la massima sicurezza."
  },
  LoadingTips_17483_LoadingTips = {
    Text = "Gli Investigatori e i Custodi si concentrano su eventi speciali che coinvolgono la Dissoluzione, le Entità Dissolte e una connessione significativa con il Reame dello Spirito, non su eventi ordinari del mondo reale."
  },
  LoadingTips_17484_LoadingTips = {
    Text = "Laddove si manifestano fenomeni di Dissoluzione, la Proiezione del Reame dello Spirito è più nitida e il Dominio è più facile da osservare, ma anche più variabile e pericoloso."
  },
  LoadingTips_17485_LoadingTips = {
    Text = "In base alle diverse caratteristiche, i Risvegliati si suddividono approssimativamente in quattro reami: Aequor, Caro, Ultra e Chaos."
  },
  LoadingTips_17486_LoadingTips = {
    Text = "Dopo il Rito di Keygrave, l'Investigatore/Custode deve completare un incarico sul campo sotto supervisione insieme al proprio Risvegliato partner, al fine di garantire la capacità di svolgere missioni in autonomia in futuro."
  },
  LoadingTips_17487_LoadingTips = {
    Text = "Il Comitato del trattato di Mystia (MTC) è un'organizzazione segreta composta da esseri umani ordinari, istituita dai governi ma indipendente da essi.\nÈ il primo a individuare e rispondere alla Dissoluzione,\ne la prima linea di difesa degli esseri umani ordinari contro di essa."
  },
  LoadingTips_17488_LoadingTips = {
    Text = "Risvegliati appartenenti allo stesso Reame possono cooperare più efficacemente, mentre Reami differenti possono manifestare un certo grado di repulsione.\nSolo il Reame del Caos non presenta questo fenomeno."
  },
  LoadingTips_17489_LoadingTips = {
    Text = "Il Silver esiste generalmente nel mondo reale in due forme: Essenza di Silver Core e Silver Core Ortorombico."
  },
  LoadingTips_17490_LoadingTips = {
    Text = "L'Indice di Gnosi misura la stabilità dei Frammenti di Coscienza all'interno del Nucleo d'Argento di un Risvegliato.\nValori più elevati indicano una minore probabilità di perdita del controllo e un numero inferiore di potenziali vittime in caso ciò avvenga."
  },
  LoadingTips_17491_LoadingTips = {
    Text = [[
La creazione di una Chiave d'argento comporta processi complessi, che culminano nell'incisione di un numero univoco.
Il commercio e il trasferimento della Chiave d'argento sono severamente proibiti; Mythag recupera qualsiasi chiave non reclamata.]]
  },
  LoadingTips_17492_LoadingTips = {
    Text = "Le scritture proibite sono custodite sotto chiave sullo scaffale più alto della biblioteca; solo coloro che dispongono dell'autorizzazione possono consultarle."
  },
  LoadingTips_17493_LoadingTips = {
    Text = "In virtù del \"Trattato di Mystia,\" l'Università di Mythag fornisce supporto di Tecnologia del Silver al Comitato per contrastare la Dissoluzione e la crisi."
  },
  LoadingTips_17494_LoadingTips = {
    Text = "La quantità di Silver estratta durante la Dissoluzione varia da individuo a individuo.\nColoro che possiedono un potere mentale più forte producono più Silver; quelli più deboli ne producono meno."
  },
  LoadingTips_17495_LoadingTips = {
    Text = "Tra gli oggetti rappresentativi della Tecnologia del Silver figurano l'Equipaggiamento di Osservazione della Dissoluzione, il Comunicatore di Mythag e la Chiave d'argento.\nLa Chiave d'argento è il più speciale e prezioso tra questi oggetti."
  },
  LoadingTips_17496_LoadingTips = {
    Text = [[
Nella Cerimonia di risveglio, gli Investigatori/Custodi utilizzano la Chiave d'argento per potenziare la connessione tra l'Argento e il Reame dello Spirito.
Sfruttando questo legame, catturano Frammenti di Coscienza erranti e li fissano all'interno del Nucleo d'Argento.]]
  },
  LoadingTips_17497_LoadingTips = {
    Text = "I Risvegliati vengono creati forzatamente estraendo e fissando Frammenti di Coscienza dal Reame dello Spirito tramite l'Argento, e sono influenzati dal Reame dello Spirito. Pertanto, tutti i Risvegliati si trovano naturalmente in uno stato di Follia finché un Investigatore o un Custode non stabilisce un Legame."
  },
  LoadingTips_17498_LoadingTips = {
    Text = "L'Università di Mythag, fondata il 16 ottobre dell'anno 187 Dopo il diluvio, è un istituto di istruzione superiore dedicato alla Ricerca e al contrasto della Dissoluzione."
  },
  LoadingTips_17499_LoadingTips = {
    Text = "L'Università di Mythag, già Collegio di Mythag, fu fondata il 16 ottobre dell'anno 90 Dopo il diluvio da Ward Philips e altri due cofondatori."
  },
  LoadingTips_17500_LoadingTips = {
    Text = "Gli Investigatori e i Custodi in possesso di una Chiave d'argento possono attraversare la Nebbia del cortile scolastico insieme al proprio Risvegliato collegato per accedere al campus."
  },
  LoadingTips_17501_LoadingTips = {
    Text = "Trecentoquindici anni fa, un grande disastro si abbatté sul mondo intero.\nL'anno della catastrofe fu designato come Anno Uno di una nuova era: Dopo il diluvio (D.d.)"
  },
  LoadingTips_17502_LoadingTips = {
    Text = "\"Che la Chiave d'Argento Illumini il Cammino.\"\nUna Benedizione comune tra i membri dell'Università di Mythag, incarnazione della fede incrollabile del popolo di Mythag."
  },
  LoadingTips_17503_LoadingTips = {
    Text = "\"Giuro di squarciare l'Oscurità con la mia spada.\"\nUn detto comune tra i Membri del Comitato del MTC, che incarna la loro Tenace determinazione nel combattere la Dissoluzione."
  },
  LoadingTips_17504_LoadingTips = {
    Text = "Individui speciali dotati di più abilità rispetto agli Investigatori, capaci di collegarsi a più Risvegliati, ricevono il titolo di Custode.\nFinora, pochissimi individui calcano il mondo sotto il titolo di Custode."
  },
  LoadingTips_17505_LoadingTips = {
    Text = "In genere, un Investigatore può collegarsi a un solo Risvegliato alla volta, sebbene casi speciali consentano eccezioni."
  },
  LoadingTips_17506_LoadingTips = {
    Text = "Quando non sono impegnati in Incarichi sul campo, l'Investigatore/Custode e il Risvegliato a loro assegnato riposano presso l'Università di Mythag.\nTutti sono tenuti a frequentare le lezioni, sostenere esami e completare lunghi compiti assegnati."
  },
  LoadingTips_17507_LoadingTips = {
    Text = "Tutti i risvegli dei Risvegliati devono conformarsi alle disposizioni pertinenti dell'\"Accordo Mysteria\", e al termine è richiesta la registrazione."
  },
  LoadingTips_17508_LoadingTips = {
    Text = "A rigore, anche i Risvegliati sono un prodotto della Tecnologia dell'Argento."
  },
  LoadingTips_36756_LoadingTips = {
    Text = "A seconda del tipo di fessura, una fessura può avere uno o più nuclei noti come \"Cladi.\""
  },
  LoadingTips_36757_LoadingTips = {
    Text = "Mythag ha perfezionato e personalizzato una serie di processi di selezione basati sulla teoria \"La composizione spirituale dell'Investigatore e il suo potenziale\", per scoprire potenziali investigatori senza allarmare l'opinione pubblica."
  },
  LoadingTips_36758_LoadingTips = {
    Text = "Lo spirito di ciascuno è diverso, e ogni Custode possiede abilità uniche.\nTra le abilità conosciute vi sono: memoria condivisa, emozioni condivise e percezione emotiva."
  },
  LoadingTips_36759_LoadingTips = {
    Text = "Trecentoquindici anni fa, un grande diluvio travolse il mondo. L'ordine crollò, le città caddero e catene montuose sottomarine emersero improvvisamente, formando nuove terre."
  },
  LoadingTips_36760_LoadingTips = {
    Text = "Il Fiorino Leoniano è la valuta comune del Regno di Leo. Circolano anche monete ausiliarie come il Crest e il Pence: 1 Fiorino equivale a 10 Crest e 1 Crest equivale a 10 Pence."
  },
  LoadingTips_36761_LoadingTips = {
    Text = "Uno spazio speciale temporaneamente isolato tramite strumenti e Argento, non influenzato da altri Spiriti o dalla Dimensione della Realtà, è chiamato Dominio Artificiale."
  },
  LoadingTips_36762_LoadingTips = {
    Text = "Lo spazio sotterraneo di Mythag è accessibile tramite l'ascensore.\nOltre alla più grande fessura L-01 di Londinium, la \"Pozza nera\", contiene diverse aree riservate che richiedono un livello di sicurezza specifico per l'accesso."
  },
  LoadingTips_36763_LoadingTips = {
    Text = "A causa della connessione tra la Chiave d'argento e il Reame dello Spirito, la Chiave può produrre una reazione speciale in prossimità di individui con anomalie spirituali."
  },
  LoadingTips_36764_LoadingTips = {
    Text = [[
I Patti sono rune misteriose registrate su materiali contenenti Argento tramite metodi speciali.
Patti diversi offrono benefici differenti; Patti della stessa serie forniscono maggiore assistenza.]]
  },
  LoadingTips_36765_LoadingTips = {
    Text = "La D-melma è un liquido nero e viscoso che trabocca da un Marchio-D.\nCome il fenomeno della Dissoluzione stesso, le persone comuni non possono osservarla direttamente senza strumenti speciali."
  },
  LoadingTips_36766_LoadingTips = {
    Text = "Alcune Entità Dissolte, al momento della morte, si trasformano in una polvere nera nota come Polvere-D."
  },
  LoadingTips_36767_LoadingTips = {
    Text = "Il Regno di Leo si trova nell'Oceano Atlanta orientale, confinante con la Federazione Constante e L'unione sempreverde.\nIl regno è piccolo ma potente, essendo uno dei primi paesi a ricostruirsi Dopo il diluvio."
  },
  LoadingTips_36768_LoadingTips = {
    Text = "La Repubblica di Aglo si trova sul lato occidentale dell'Oceano Atlanta, vasta e circondata dal mare.\nPossiede un settore industriale e finanziario altamente sviluppato; il suo centro finanziario, Fletcher, è una città vivace e ambita."
  },
  LoadingTips_36769_LoadingTips = {
    Text = "Nel Dominio, emozioni, pensieri e ossessioni possono avere proiezioni osservabili.\nQueste proiezioni sono generalmente intangibili o si dissolvono al contatto, ingannando i sensi degli individui nella Dimensione della Realtà."
  },
  LoadingTips_36770_LoadingTips = {
    Text = "La Federazione Constante è un'unione di diversi piccoli paesi situati nella Laurasia orientale. All'interno della Federazione, l'arte è una ricerca comune per tutti."
  },
  LoadingTips_36771_LoadingTips = {
    Text = "Alcune proiezioni speciali possono essere catturate tramite il Trasferimento di gnosi e applicate alle Carte di comando, conferendo potenziamenti al Risvegliato. Queste proiezioni sono note come Orazioni."
  },
  LoadingTips_36772_LoadingTips = {
    Text = "In base alle dimensioni, le Fratture-D si suddividono approssimativamente in 6 categorie: C, B, A, S, SS, SSS."
  },
  LoadingTips_36773_LoadingTips = {
    Text = "L'Associazione degli Scultori, un'organizzazione estremista ossessionata da empi esperimenti sugli esseri umani, fu fondata da Robert Rosenthal, un traditore di Mythag."
  },
  LoadingTips_36774_LoadingTips = {
    Text = "L'Ordine dei Navigatori è un'antica organizzazione religiosa guidata da Miryam.\nSi adoperano instancabilmente per resuscitare il loro unico Re divino."
  },
  LoadingTips_36775_LoadingTips = {
    Text = "Diversi Domini regionali producono oggetti collezionabili differenti durante le indagini. Persino oggetti apparentemente identici possono possedere nature profondamente diverse."
  },
  LoadingTips_36776_LoadingTips = {
    Text = "Il Dominio è una Dimensione speciale tra il Reame dello Spirito e la Dimensione della Realtà, e lo spazio più vicino al Reame dello Spirito in cui gli esseri umani possono fisicamente accedere."
  },
  LoadingTips_36777_LoadingTips = {
    Text = "L'Università di Mythag è una terza parte assolutamente neutrale; tutte le questioni interne vengono decise collegialmente dal presidente e dalla Gestione, liberi da vincoli di organizzazioni esterne."
  },
  LoadingTips_36778_LoadingTips = {
    Text = "L'esistenza di una Frattura-D non dipende da oggetti tangibili; il cielo, il Mare profondo e altri luoghi sono tutti potenziali siti in cui può manifestarsi."
  },
  LoadingTips_36779_LoadingTips = {
    Text = "La Chiesa dei Portatori di Luce è un'organizzazione religiosa segreta e malevola. Sembra avere profondi legami con l'Associazione degli Scultori e i Navigatori."
  },
  LoadingTips_36780_LoadingTips = {
    Text = "Il Comitato del trattato di Mystia è un'organizzazione molto vasta.\nOltre al Regno di Leo, possiede sedi nella Repubblica di Aglo, nella Federazione Constante e persino nell'Impero di Remouahe."
  }
})
return Text_LoadingTips
