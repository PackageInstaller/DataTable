__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_GuideConfig = readonly({
  GuideConfig_10_Content_1 = {
    Text = "Davanti si erge il <RedQuality:Mostro Argenteo dalle Sei Ali>, il cui fulgore acceca."
  },
  GuideConfig_11_Content_1 = {
    Text = "Possiamo affrontarli ora... oppure eliminare i mostri nelle vicinanze per mettere in sicurezza la Giunzione. A te la scelta, Custode."
  },
  GuideConfig_12_Content_1 = {
    Text = "Tieni premuta la Carta di comando e trascina verso l'alto per impartire comandi."
  },
  GuideConfig_13_Content_1 = {
    Text = "Il nemico sta preparando un colpo letale. Difenditi ora, Custode!"
  },
  GuideConfig_14_Content_1 = {
    Text = "Concatenare gli attacchi della Spada della Regina genera una forza travolgente. Vuoi annientarli con questa tecnica?"
  },
  GuideConfig_15_Content_1 = {
    Text = "Mettere a segno attacchi accumula Aliemus. A carica massima, scatena un'Esaltazione devastante."
  },
  GuideConfig_1_Content_1 = {
    Text = "Custode, ora puoi avanzare ed esplorare."
  },
  GuideConfig_2_Content_1 = {
    Text = "Questa Giunzione è stata preparata dalla nostra squadra di supporto. Usa qui la tua Chiave d'argento per ripristinare i PS."
  },
  GuideConfig_34_Content_1 = {
    Text = "Sono disponibili altre Carte di comando. Prova a giocarle tutte prima. Potrai giocare come preferisci al termine del tutorial."
  },
  GuideConfig_35_Content_1 = {
    Text = "Sono disponibili altre Carte di comando. Prova a giocarle tutte prima. Potrai giocare come preferisci al termine del tutorial."
  },
  GuideConfig_36_Content_1 = {
    Text = "Sono disponibili altre Carte di comando. Prova a giocarle tutte prima. Potrai giocare come preferisci al termine del tutorial."
  },
  GuideConfig_37_Content_1 = {
    Text = "Sono disponibili altre Carte di comando. Prova a giocarle tutte prima. Potrai giocare come preferisci al termine del tutorial."
  },
  GuideConfig_38_Content_1 = {
    Text = "L'Esaltazione è disponibile. Prova a usare l'Esaltazione prima. Potrai giocare come preferisci al termine del tutorial."
  },
  GuideConfig_39_Content_1 = {
    Text = "L'Esaltazione è disponibile. Prova a usare l'Esaltazione prima. Potrai giocare come preferisci al termine del tutorial."
  },
  GuideConfig_3_Content_1 = {
    Text = "Dobbiamo sconfiggere il <RedQuality:Lotan Furente> in fretta. Non sopporto di assistere a un'altra tragedia come quella di prima."
  },
  GuideConfig_40_Content_1 = {
    Text = "L'Esaltazione è disponibile. Prova a usare l'Esaltazione prima. Potrai giocare come preferisci al termine del tutorial."
  },
  GuideConfig_41_Content_1 = {
    Text = "L'Esaltazione è disponibile. Prova a usare l'Esaltazione prima. Potrai giocare come preferisci al termine del tutorial."
  },
  GuideConfig_42_Content_1 = {
    Text = "La Squadra è disponibile. Prova a usare la Squadra prima. Potrai giocare come preferisci al termine del tutorial."
  },
  GuideConfig_47_Content_1 = {
    Text = "Il Reame del Caos ha una forte Risonanza con la Chiave d'argento, che garantisce 250 Keyflare ogni turno per aiutarti a Scatenare la tua Posse più velocemente. Se non ci sono Risvegliatori di altri Reami nella tua squadra, riceverai anche una Reliquia d'argento all'ingresso nello Stadio. Usa la Reliquia per aiutarti a sconfiggere i tuoi nemici."
  },
  GuideConfig_47_TipsTitle_1 = {Text = "Caos"},
  GuideConfig_49_Content_1 = {
    Text = "Il Reame del Mare Profondo genera 1 Tentacolo all'inizio della battaglia. Il Tentacolo attacca il nemico in prima fila alla fine di ogni turno. I Risvegliatori di Aequor possono fornire vari potenziamenti al Tentacolo. Puoi controllare i Danni da tentacolo attuali tramite il valore visualizzato sotto l'icona del Tentacolo."
  },
  GuideConfig_49_TipsTitle_1 = {Text = "Aequor"},
  GuideConfig_4_Content_1 = {
    Text = "Possiamo sacrificare Sigilli Neri al <Yellow:Marchio-D> del Dominio per ottenere varie <Yellow:Reliquie>. Sono inestimabili in combattimento."
  },
  GuideConfig_55_Content_1 = {
    Text = "Il Reame Caro accumula Fusione Embrionale e Fornace Cremisi a ogni turno: più bassi sono i tuoi Vita, più veloce è l'accumulo. Quando il Livello di Fusione Embrionale raggiunge il limite massimo, viene generato un Embrione e collocato nella tua Mano. Gli Embrioni possono essere usati direttamente per conferire Aliemus al Risvegliatore corrispondente e Tasso di crit. temporaneo; oppure possono essere Divorati da un Risvegliatore di Caro tramite Esaltazione per attivare Effetti aggiuntivi."
  },
  GuideConfig_55_TipsTitle_1 = {Text = "Caro"},
  GuideConfig_57_Content_1 = {
    Text = "Usa la \"Fornace Cremisi\" per il Recupero PV per resistere agli attacchi!"
  },
  GuideConfig_58_Content_1 = {
    Text = "Quando un Risvegliatore di Caro scatena l'Esaltazione, può Divorare gli Embrioni nella tua Mano per Potenziare l'Effetto dell'Esaltazione. Scatena l'Occhio dell'Eternità e attiva Divorare!"
  },
  GuideConfig_5_Content_1 = {
    Text = "Ecco un <Yellow:Marchio-D>. Investiamo i Sigilli Neri che hai accumulato."
  },
  GuideConfig_60_Content_1 = {
    Text = "Nel Reame Ultra, una copia Temporanea della prima Carta di comando giocata ogni turno entra nell'Ultra Spazio. Quando l'Ultra Spazio raggiunge il suo limite, puoi iniziare un nuovo turno. In questo nuovo turno, non Pescherai Carte; al loro posto, le Carte dall'Ultra Spazio vengono inserite nella tua Mano."
  },
  GuideConfig_60_TipsTitle_1 = {Text = "Ultra"},
  GuideConfig_6_Content_1 = {
    Text = "Questa <Yellow:Reliquia> proviene dal Dominio. Ne sentirai presto il potere, anche se svanisce al di fuori del Dominio."
  },
  GuideConfig_7_Content_1 = {
    Text = "Un <Yellow:Evento> è apparso più avanti; indaghiamo. Potremmo ottenere più forza... anche se talvolta a un prezzo."
  },
  GuideConfig_8_Content_1 = {
    Text = "Dei nemici attendono più avanti."
  },
  GuideConfig_9_Content_1 = {
    Text = "Questo passaggio unidirezionale conduce alla sala sotterranea. La nostra missione si trova oltre."
  }
})
return Text_GuideConfig
