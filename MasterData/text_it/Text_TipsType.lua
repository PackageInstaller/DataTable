__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TipsType = readonly({
  TipsType_100001_Desc = {
    Text = "La modifica della risoluzione richiede il riavvio del client per avere effetto. Procedere?"
  },
  TipsType_100001_LeftBtnDesc = {Text = "Annulla"},
  TipsType_100001_RightBtnDesc = {Text = "Conferma"},
  TipsType_100001_Title = {
    Text = "Conferma cambio risoluzione"
  },
  TipsType_100002_Desc = {
    Text = "In Attesa che {s1} accetti il tuo invito..."
  },
  TipsType_100002_RightBtnDesc = {Text = "Annulla"},
  TipsType_100002_Title = {
    Text = "Un altro round"
  },
  TipsType_100003_Desc = {
    Text = "{s1} ti invita a giocare un altro round."
  },
  TipsType_100003_LeftBtnDesc = {Text = "Rifiuta"},
  TipsType_100003_RightBtnDesc = {Text = "Accetta"},
  TipsType_100003_Title = {
    Text = "Un altro round"
  },
  TipsType_100004_Desc = {
    Text = "Già impostato come sfondo attuale del dormitorio."
  },
  TipsType_100005_Desc = {
    Text = "Traphase non è ancora disponibile"
  },
  TipsType_100006_Desc = {
    Text = "L'altro giocatore non ha ancora sbloccato la modalità Traphase."
  },
  TipsType_100007_Desc = {
    Text = "Dovete seguirvi a vicenda per avviare una Partita Amichevole."
  },
  TipsType_100008_Desc = {
    Text = "L'altra parte è offline."
  },
  TipsType_100009_Desc = {
    Text = "L'altro giocatore è attualmente impegnato in un'indagine."
  },
  TipsType_100010_Desc = {
    Text = "La richiesta di Partita Amichevole è scaduta."
  },
  TipsType_100011_Desc = {
    Text = "Hai annullato la Partita Amichevole."
  },
  TipsType_100012_Desc = {
    Text = "Invito alla Partita Amichevole rifiutato."
  },
  TipsType_100012_LeftBtnDesc = {Text = "Conferma"},
  TipsType_100012_Title = {
    Text = "Indagine in corso"
  },
  TipsType_100013_Desc = {
    Text = "L'altra parte è offline."
  },
  TipsType_100014_Desc = {
    Text = "L'altro giocatore è entrato in un'altra modalità di gioco."
  },
  TipsType_100015_Desc = {
    Text = "Invito inviato troppo frequentemente. Riprova tra {s1}s."
  },
  TipsType_100016_Desc = {
    Text = "L'altro giocatore ha annullato la Partita Amichevole."
  },
  TipsType_100016_LeftBtnDesc = {Text = "Conferma"},
  TipsType_100016_Title = {
    Text = "Indagine in corso"
  },
  TipsType_100017_Desc = {
    Text = "Questo giocatore è attualmente in una Partita Amichevole."
  },
  TipsType_100017_LeftBtnDesc = {Text = "Conferma"},
  TipsType_100017_Title = {
    Text = "Indagine in corso"
  },
  TipsType_100018_Desc = {
    Text = [[
Questa squadra include carte a tempo limitato. Devi sbloccare i Temi Fondamentali di questa Stagione per continuare. Non vediamo l'ora di combattere di nuovo al tuo fianco!
Vuoi sbloccare i Temi Fondamentali adesso?]]
  },
  TipsType_100018_LeftBtnDesc = {Text = "Annulla"},
  TipsType_100018_RightBtnDesc = {Text = "Conferma"},
  TipsType_100018_Title = {
    Text = "I Temi Fondamentali sono scaduti"
  },
  TipsType_10001_Desc = {Text = "Successo"},
  TipsType_100020_Desc = {
    Text = "Desideri continuare l'indagine in corso?"
  },
  TipsType_100020_LeftBtnDesc = {Text = "Annulla"},
  TipsType_100020_RightBtnDesc = {Text = "Conferma"},
  TipsType_100020_Title = {
    Text = "Indagine in corso"
  },
  TipsType_10002_Desc = {
    Text = "Errore nei dati di configurazione"
  },
  TipsType_10003_Desc = {
    Text = "Errore nell'inserimento dati del client"
  },
  TipsType_10004_Desc = {
    Text = "Server non avviato"
  },
  TipsType_10005_Desc = {
    Text = "Errore nei dati del personaggio"
  },
  TipsType_10006_Desc = {
    Text = "Nessun dato del Risvegliatore trovato"
  },
  TipsType_10007_Desc = {
    Text = "Il Risvegliato ha raggiunto il livello massimo."
  },
  TipsType_10008_Desc = {
    Text = "Punti argomento insufficienti"
  },
  TipsType_10009_Desc = {
    Text = "Il Risveglio non ha raggiunto il livello massimo e non può essere Illuminato."
  },
  TipsType_100100_Desc = {
    Text = "È disponibile una nuova versione. Se l'aggiornamento non si avvia automaticamente, prova a riavviare Steam per verificare la presenza di aggiornamenti."
  },
  TipsType_100100_RightBtnDesc = {Text = "Conferma"},
  TipsType_100100_Title = {
    Text = "Suggerimento aggiornamento"
  },
  TipsType_10010_Desc = {
    Text = "Illuminazione Completa"
  },
  TipsType_10011_Desc = {
    Text = "Nessun personaggio è stato ancora creato."
  },
  TipsType_10012_Desc = {
    Text = "Personaggi attuali"
  },
  TipsType_10013_Desc = {
    Text = "Nome personaggio duplicato"
  },
  TipsType_10014_Desc = {
    Text = "Errore nell'area del Dominio"
  },
  TipsType_10015_Desc = {
    Text = "Impossibile localizzare l'area del Dominio."
  },
  TipsType_10016_Desc = {
    Text = "Gli HP attuali sono troppo bassi."
  },
  TipsType_10017_Desc = {
    Text = "Si sblocca da {s1} a {s2}"
  },
  TipsType_10018_Desc = {
    Text = "Dopo aver raggiunto il secondo piano di questo Dominio 1 volta, potrai effettuare un'Indagine Rapida."
  },
  TipsType_10019_Desc = {
    Text = "Evento Completato"
  },
  TipsType_10020_Desc = {
    Text = "Tipo di voce errato nella tabella di configurazione dell'evento."
  },
  TipsType_10021_Desc = {
    Text = "L'Evento non esiste"
  },
  TipsType_10022_Desc = {
    Text = "Sigilli Neri insufficienti per l'acquisto."
  },
  TipsType_10023_Desc = {
    Text = "Questa carta non può essere potenziata."
  },
  TipsType_10024_Desc = {
    Text = "Questa carta ha raggiunto il limite massimo di potenziamento."
  },
  TipsType_10025_Desc = {
    Text = "Il Mercante non vende questo oggetto."
  },
  TipsType_10026_Desc = {
    Text = "Ricompensa inesistente"
  },
  TipsType_10027_Desc = {
    Text = "Ricompensa riscossa"
  },
  TipsType_10028_Desc = {
    Text = "Errore nei dati dell'evento"
  },
  TipsType_10029_Desc = {
    Text = "Già acquistato"
  },
  TipsType_10030_Desc = {
    Text = "L'energia attuale è insufficiente per attivare il Portale. L'attivazione del Portale richiede {s1} energia."
  },
  TipsType_10031_Desc = {
    Text = "Nessun evento di dialogo della Storia trovato"
  },
  TipsType_10032_Desc = {
    Text = "Carte di comando selezionate insufficienti per l'evento."
  },
  TipsType_10033_Desc = {
    Text = "Troppe Carte di comando selezionate per l'evento."
  },
  TipsType_10034_Desc = {
    Text = "Le Carte di comando per la selezione dell'Evento non esistono."
  },
  TipsType_10035_Desc = {
    Text = "Nessun dato nel pool degli eventi casuali."
  },
  TipsType_10036_Desc = {
    Text = "Il Mercante non vende questo oggetto."
  },
  TipsType_10037_Desc = {
    Text = "Reliquie selezionate per l'evento insufficienti"
  },
  TipsType_10038_Desc = {
    Text = "Troppe Reliquie selezionate per l'Evento."
  },
  TipsType_10039_Desc = {
    Text = "La Reliquia selezionata per l'evento non esiste"
  },
  TipsType_10040_Desc = {
    Text = "Nodo dell'Evento non trovato"
  },
  TipsType_10041_Desc = {
    Text = "Il conteggio di Aggiornamento del Mercante è stato esaurito."
  },
  TipsType_10042_Desc = {
    Text = "Il conteggio di Aggiornamento delle Carte di comando ottenute in Battaglia è stato esaurito."
  },
  TipsType_10043_Desc = {
    Text = "I tentativi di Aggiornamento delle Reliquie ottenute in Battaglia sono stati esauriti."
  },
  TipsType_10044_Desc = {
    Text = "La funzione Giunzione è bloccata"
  },
  TipsType_10045_Desc = {
    Text = "Regione dell'Evento non corrispondente! Regione attuale: {s1}, regione configurata per l'evento: {s2}."
  },
  TipsType_10046_Desc = {
    Text = "I tentativi per rimuovere carte nel negozio dell'evento sono stati esauriti"
  },
  TipsType_10047_Desc = {
    Text = "Dati unità argomento non trovati"
  },
  TipsType_10048_Desc = {
    Text = "L'unità è già stata inviata. Non è necessario inviarla di nuovo."
  },
  TipsType_10049_Desc = {
    Text = "Non tutte le missioni dell'unità sono state completate. Impossibile inviare."
  },
  TipsType_10050_Desc = {
    Text = "Modulo del corso non trovato"
  },
  TipsType_10051_Desc = {
    Text = "Il Livello non contiene dati di sfida"
  },
  TipsType_10052_Desc = {
    Text = "Nessun corso disponibile per questo Dominio."
  },
  TipsType_10053_Desc = {
    Text = "Crediti insufficienti, impossibile riscuotere le ricompense."
  },
  TipsType_10054_Desc = {
    Text = "Le condizioni per la ricompensa in crediti non sono ancora state soddisfatte."
  },
  TipsType_10055_Desc = {
    Text = "Nessuna missione trovata nella sezione del soggetto."
  },
  TipsType_10056_Desc = {
    Text = "Sotto-missione completata"
  },
  TipsType_10057_Desc = {
    Text = "Le sotto-attività all'interno delle attività secondarie del progetto non sono completate."
  },
  TipsType_10058_Desc = {
    Text = "L'NPC è stato attivato"
  },
  TipsType_10059_Desc = {
    Text = "Errore nei dati dell'NPC"
  },
  TipsType_10060_Desc = {
    Text = "L'NPC non esiste"
  },
  TipsType_10061_Desc = {
    Text = "Non scoperto nel Dominio"
  },
  TipsType_10062_Desc = {
    Text = "Nessun dato di Risonanza trovato"
  },
  TipsType_10063_Desc = {
    Text = "La Risonanza ha raggiunto il livello massimo."
  },
  TipsType_10064_Desc = {
    Text = "Nessun dato relativo al Livello di Risonanza trovato."
  },
  TipsType_10065_Desc = {
    Text = "Nessun tentativo di ripristino disponibile"
  },
  TipsType_10066_Desc = {
    Text = "Condizioni di attivazione della Risonanza non soddisfatte."
  },
  TipsType_10067_Desc = {
    Text = "Particelle di Risonanza insufficienti"
  },
  TipsType_10068_Desc = {
    Text = "Illuminazione completa, impossibile Illuminare di nuovo."
  },
  TipsType_10069_Desc = {
    Text = "Materiali necessari per Illuminare insufficienti."
  },
  TipsType_10070_Desc = {
    Text = "Materiali insufficienti per potenziare il Risvegliatore."
  },
  TipsType_10071_Desc = {
    Text = "Rosa Scrip insufficienti per potenziare il Risvegliatore."
  },
  TipsType_10072_Desc = {
    Text = "Rosa Scrip insufficienti per potenziare il Risvegliatore."
  },
  TipsType_10073_Desc = {
    Text = "Nessuna Abilità del Risvegliatore"
  },
  TipsType_10074_Desc = {
    Text = "Abilità del Risvegliato non ancora sbloccate"
  },
  TipsType_10075_Desc = {
    Text = "\"Argento\" insufficiente per il Risveglio."
  },
  TipsType_10076_Desc = {
    Text = "Oggetti insufficienti"
  },
  TipsType_10077_Desc = {
    Text = "Hai raggiunto il limite di acquisto giornaliero"
  },
  TipsType_10078_Desc = {
    Text = "Impossibile utilizzare l'oggetto"
  },
  TipsType_10079_Desc = {
    Text = "Quantità di utilizzo dell'oggetto non corretta"
  },
  TipsType_10080_Desc = {
    Text = "L'abilità ha raggiunto il livello massimo"
  },
  TipsType_10081_Desc = {
    Text = "Materiali insufficienti per il Potenziamento"
  },
  TipsType_10082_Desc = {
    Text = "Valuta insufficiente per il Potenziamento"
  },
  TipsType_10083_Desc = {
    Text = "Il tasso di collegamento del Risvegliatore ha raggiunto il Livello massimo."
  },
  TipsType_10084_Desc = {
    Text = "Questo Risvegliatore ha Spirito Primordiale insufficiente."
  },
  TipsType_10085_Desc = {
    Text = "Il sentiero di potenziamento non ha un ID personaggio configurato"
  },
  TipsType_10086_Desc = {
    Text = "Impossibile trovare le informazioni sulla carta esclusiva specificata"
  },
  TipsType_10087_Desc = {
    Text = "Carta esclusiva designata non sbloccata"
  },
  TipsType_10088_Desc = {
    Text = "Impossibile trovare l'UUID per questa carta esclusiva"
  },
  TipsType_10089_Desc = {
    Text = "I punti richiesti per le ricompense del capitolo non sono stati raggiunti"
  },
  TipsType_10090_Desc = {
    Text = "Le ricompense del capitolo sono già state riscattate"
  },
  TipsType_10091_Desc = {
    Text = "La trama selezionata non è ancora stata sbloccata"
  },
  TipsType_10092_Desc = {
    Text = "L'istanza selezionata non è ancora stata sbloccata"
  },
  TipsType_10093_Desc = {
    Text = "L'area dell'istanza non è ancora stata sbloccata"
  },
  TipsType_10094_Desc = {
    Text = "Spazzata della trama non ancora sbloccata"
  },
  TipsType_10095_Desc = {
    Text = "Nessuna trama trovata per la sfida dell'istanza"
  },
  TipsType_10096_Desc = {
    Text = "Nessuna missione della trama trovata per le sfide dell'istanza"
  },
  TipsType_10097_Desc = {
    Text = "Sfida completata. Le ricompense non possono essere riscattate di nuovo."
  },
  TipsType_10098_Desc = {
    Text = "Sfida non completata. Ricompense non disponibili."
  },
  TipsType_10099_Desc = {
    Text = "L'edificio non esiste"
  },
  TipsType_10100_Desc = {
    Text = "L'edificio ha raggiunto il livello massimo"
  },
  TipsType_10101_Desc = {
    Text = "Condizioni insufficienti per potenziare/costruire edifici"
  },
  TipsType_10102_Desc = {
    Text = "L'edificio esiste già e non può essere costruito di nuovo"
  },
  TipsType_10103_Desc = {
    Text = "Oggetti insufficienti per il potenziamento/costruzione"
  },
  TipsType_10104_Desc = {
    Text = "La posizione è già occupata da un Risvegliato, impossibile entrare"
  },
  TipsType_10105_Desc = {
    Text = "Materiali insufficienti per fabbricare l'oggetto richiesto"
  },
  TipsType_10106_Desc = {
    Text = "Valuta insufficiente per fabbricare l'oggetto"
  },
  TipsType_10107_Desc = {
    Text = "Oggetto di sintesi non sbloccato"
  },
  TipsType_10108_Desc = {
    Text = "Connessione al server non riuscita. Controlla la tua rete e riprova."
  },
  TipsType_10109_Desc = {
    Text = "L'accampamento ha già selezionato una funzione e non è possibile effettuare un'altra selezione"
  },
  TipsType_10110_Desc = {
    Text = "La funzione accampamento non ha utilizzi rimanenti"
  },
  TipsType_10111_Desc = {
    Text = "Potenzia la carta esclusiva per cambiare"
  },
  TipsType_10112_Desc = {
    Text = "Cambia la carta esclusiva per cambiare"
  },
  TipsType_10113_Desc = {
    Text = "Impossibile cambiare la carta esclusiva"
  },
  TipsType_10114_Desc = {
    Text = "Risvegliatore {s1} ottenuto"
  },
  TipsType_10115_Desc = {
    Text = "{s1} ottenuto di nuovo, convertito in {s2}{s3}."
  },
  TipsType_10116_Desc = {
    Text = "{s1} ricordi hanno superato il limite e sono stati convertiti in {s2}{s3}."
  },
  TipsType_10117_Desc = {
    Text = "Registro caricato con successo"
  },
  TipsType_10118_Desc = {
    Text = "Istruzione non corrispondente, attualmente ne La Veglia per l'istruzione {s1}, ma è stata ricevuta {s2}."
  },
  TipsType_10119_Desc = {
    Text = "Carta perduta:{s1}; uid:{s2}"
  },
  TipsType_10120_Desc = {
    Text = "Impossibile Scatenare"
  },
  TipsType_10121_Desc = {
    Text = "Abilità inesistente"
  },
  TipsType_10122_Desc = {
    Text = "Abilità in ricarica"
  },
  TipsType_10123_Desc = {
    Text = "Utilizzi dell'Abilità esauriti"
  },
  TipsType_10124_Desc = {
    Text = "Verifica se l'ordine di potenziamento dell'edificio Tid {s1} è circolare."
  },
  TipsType_10125_Desc = {
    Text = "Verifica se l'edificio Tid {s1} non ha alcuna configurazione associata."
  },
  TipsType_10126_Desc = {
    Text = "Il Livello effettivo dell'edificio Tid {s1} dovrebbe essere {s2}, configurato come {s3}."
  },
  TipsType_10127_Desc = {
    Text = "Configurazione del tipo di edificio non trovata"
  },
  TipsType_10128_Desc = {
    Text = "Configurazione dell'edificio non trovata, o nessun tipo di edificio specificato."
  },
  TipsType_10129_Desc = {
    Text = "Questa missione della Storia non è stata ancora sbloccata."
  },
  TipsType_10130_Desc = {
    Text = "Rimosso con successo"
  },
  TipsType_10131_Desc = {
    Text = "\"Menofina\" × {s1} ottenuta con successo."
  },
  TipsType_10132_Desc = {
    Text = "Correzione completata"
  },
  TipsType_10133_Desc = {
    Text = "GM aggiunta oggetto per nome [\"..arg1..\"]: nessun oggetto corrispondente trovato."
  },
  TipsType_10134_Desc = {
    Text = "L'Evento [\"..arg1..\"] non esiste."
  },
  TipsType_10135_Desc = {
    Text = "Attuale: Premi {s1}"
  },
  TipsType_10136_Desc = {
    Text = "Abilità potenziata"
  },
  TipsType_10137_Desc = {
    Text = "Generato con successo"
  },
  TipsType_10138_Desc = {
    Text = "Ora del server aggiornata con successo."
  },
  TipsType_10139_Desc = {
    Text = "Impossibile modificare l'ora del server"
  },
  TipsType_10140_Desc = {
    Text = [[
Edifici totali: 17
Questa versione temporanea dispone solo di alcuni edifici.]]
  },
  TipsType_10141_Desc = {
    Text = "Condizioni di sblocco dell'edificio non soddisfatte."
  },
  TipsType_10142_Desc = {
    Text = "Edificio: l'interfaccia per la configurazione di {s1} non esiste {s2}."
  },
  TipsType_10143_Desc = {
    Text = "Questa ricetta di fabbricazione è attualmente bloccata."
  },
  TipsType_10144_Desc = {
    Text = "Materiali insufficienti"
  },
  TipsType_10145_Desc = {
    Text = "Fabbricazione riuscita"
  },
  TipsType_10146_Desc = {Text = "Potenziato"},
  TipsType_10147_Desc = {
    Text = "Lo slot del Mostro è vuoto, impossibile entrare in Battaglia."
  },
  TipsType_10148_Desc = {
    Text = "Recupero \"Menofina\""
  },
  TipsType_10149_Desc = {
    Text = "L'ID personaggio inserito è duplicato e non è possibile entrare in combattimento."
  },
  TipsType_10150_Desc = {
    Text = "L'ID {s1} inserito non esiste e non è possibile entrare in battaglia."
  },
  TipsType_10151_Desc = {
    Text = "Il Mostro non ha un'azione corrispondente."
  },
  TipsType_10152_Desc = {
    Text = "Non ancora disponibile"
  },
  TipsType_10153_Desc = {
    Text = "Nessuna carta nel mazzo attuale."
  },
  TipsType_10154_Desc = {
    Text = "Altre Carte sono in Effetto, Impossibile Giocare Carte."
  },
  TipsType_10155_Desc = {
    Text = "Non In Mano, impossibile giocare."
  },
  TipsType_10156_Desc = {
    Text = "Questa carta non può essere giocata."
  },
  TipsType_10157_Desc = {
    Text = "Questa carta non ha Abilità configurate."
  },
  TipsType_10158_Desc = {
    Text = "Questa carta non può essere giocata."
  },
  TipsType_10159_Desc = {
    Text = "Arithmetica insufficiente"
  },
  TipsType_10160_Desc = {
    Text = "Nessun Risvegliatore corrispondente sul campo."
  },
  TipsType_10161_Desc = {
    Text = "Tentativi rimanenti insufficienti"
  },
  TipsType_10162_Desc = {
    Text = "Usa un'Abilità di Esplorazione"
  },
  TipsType_10163_Desc = {
    Text = "%d Carte di comando selezionate"
  },
  TipsType_10164_Desc = {
    Text = "Limite di quantità raggiunto"
  },
  TipsType_10165_Desc = {
    Text = "Nessuna selezione effettuata"
  },
  TipsType_10166_Desc = {
    Text = "Questa carta non può essere giocata spendendo Arithmetica."
  },
  TipsType_10167_Desc = {
    Text = "Il consumo totale è stato superato"
  },
  TipsType_10168_Desc = {
    Text = "{s1} Carta/e selezionata/e"
  },
  TipsType_10169_Desc = {
    Text = "Il Numero di Tentacoli ha raggiunto il massimo."
  },
  TipsType_10170_Desc = {
    Text = "Rimosso con successo"
  },
  TipsType_10171_Desc = {Text = "Potenziato"},
  TipsType_10172_Desc = {
    Text = "Trasformazione riuscita"
  },
  TipsType_10173_Desc = {Text = "Copiato"},
  TipsType_10174_Desc = {
    Text = "Carta di comando ottenuta"
  },
  TipsType_10175_Desc = {
    Text = "Il numero di rimozioni è stato esaurito."
  },
  TipsType_10176_Desc = {
    Text = "Il numero di potenziamenti è stato esaurito."
  },
  TipsType_10177_Desc = {
    Text = "Il numero di trasformazioni è stato esaurito."
  },
  TipsType_10178_Desc = {
    Text = "Il numero di copie è stato esaurito."
  },
  TipsType_10179_Desc = {
    Text = "Limite di selezione Carte di comando raggiunto"
  },
  TipsType_10180_Desc = {
    Text = "Nessuna Carta di comando selezionata"
  },
  TipsType_10181_Desc = {
    Text = "Il Negozio non è ancora aperto. Resta in attesa."
  },
  TipsType_10182_Desc = {
    Text = "Restate sintonizzati"
  },
  TipsType_10183_Desc = {
    Text = "L'area bersaglio è troppo lontana per essere localizzata."
  },
  TipsType_10184_Desc = {
    Text = "Area del bersaglio mancata, impossibile completare."
  },
  TipsType_10185_Desc = {
    Text = "Questo argomento non è ancora sbloccato."
  },
  TipsType_10186_Desc = {
    Text = "Esplora i Domini per sbloccare ulteriori Indagini."
  },
  TipsType_10187_Desc = {
    Text = "Completa i compiti prerequisiti per sbloccare altre indagini."
  },
  TipsType_10188_Desc = {
    Text = "Invio riuscito, punti Ricerca +{s1}."
  },
  TipsType_10189_Desc = {
    Text = "Nessun compito disponibile da consegnare"
  },
  TipsType_10190_Desc = {
    Text = "Non ancora disponibile. Controlla il calendario di apertura del dungeon."
  },
  TipsType_10191_Desc = {
    Text = "Condizioni di sblocco del Livello non ancora soddisfatte"
  },
  TipsType_10192_Desc = {
    Text = "{s1} non può essere vuoto"
  },
  TipsType_10193_Desc = {
    Text = "{s1} e {s2} non possono essere vuoti."
  },
  TipsType_10194_Desc = {
    Text = "Il conteggio degli aggiornamenti è stato esaurito, impossibile aggiornare."
  },
  TipsType_10195_Desc = {
    Text = "Metodo di acquisizione non ancora sbloccato."
  },
  TipsType_10196_Desc = {
    Text = "Non rientra nel periodo di disponibilità."
  },
  TipsType_10197_Desc = {
    Text = "Seleziona una reliquia da trasformare"
  },
  TipsType_10198_Desc = {
    Text = "Rimosso con successo"
  },
  TipsType_10199_Desc = {
    Text = "Il numero di rimozioni è stato esaurito."
  },
  TipsType_10200_Desc = {
    Text = "Il numero di trasformazioni è stato esaurito."
  },
  TipsType_10201_Desc = {
    Text = "Seleziona una reliquia da rimuovere"
  },
  TipsType_10202_Desc = {
    Text = "La quantità ha raggiunto il limite"
  },
  TipsType_10203_Desc = {
    Text = "Seleziona almeno {s1} reliquie."
  },
  TipsType_10204_Desc = {
    Text = "Nessun cambio rimanente"
  },
  TipsType_10205_Desc = {
    Text = "Tutte le carte esclusive sono state potenziate al livello massimo."
  },
  TipsType_10206_Desc = {
    Text = "Il livello di repulsione attuale è 0 e non può essere ridotto ulteriormente."
  },
  TipsType_10207_Desc = {
    Text = "Non ancora disponibile"
  },
  TipsType_10208_Desc = {
    Text = "Àncore di vincolo dell'anima insufficienti per il potenziamento."
  },
  TipsType_10209_Desc = {
    Text = "È necessario che {s1} raggiunga il livello {s2} per eseguire l'Illuminazione."
  },
  TipsType_10210_Desc = {
    Text = "\"{s1}\" insufficiente"
  },
  TipsType_10211_Desc = {
    Text = "Non possiedi attualmente \"{s1}\""
  },
  TipsType_10212_Desc = {
    Text = "Livello Massimo Raggiunto"
  },
  TipsType_10213_Desc = {
    Text = "Seleziona prima un materiale"
  },
  TipsType_10214_Desc = {
    Text = "\"{s1}\" insufficiente"
  },
  TipsType_10215_Desc = {Text = "Potenziato"},
  TipsType_10216_Desc = {
    Text = "L'elisir di gnosi è stato aggiunto"
  },
  TipsType_10217_Desc = {
    Text = "Limite di illuminazione raggiunto"
  },
  TipsType_10218_Desc = {
    Text = "Potenziamento fallito"
  },
  TipsType_10219_Desc = {
    Text = "Oggetti insufficienti per il potenziamento"
  },
  TipsType_10220_Desc = {Text = "Liv. MAX"},
  TipsType_10221_Desc = {
    Text = "Abilità potenziata"
  },
  TipsType_10222_Desc = {
    Text = "Sigilli Neri insufficienti per l'acquisto."
  },
  TipsType_10223_Desc = {Text = "Esaurito"},
  TipsType_10224_Desc = {
    Text = "Sigilli Neri insufficienti per rimuovere la Carta di comando."
  },
  TipsType_10225_Desc = {
    Text = "Rimuovi {s1} carta/e di comando"
  },
  TipsType_10226_Desc = {
    Text = "Questa direzione non è ancora disponibile e non può essere potenziata."
  },
  TipsType_10227_Desc = {
    Text = "Questa direzione è stata potenziata al Livello massimo."
  },
  TipsType_10228_Desc = {
    Text = "Seleziona prima la direzione in cui desideri potenziare la tua carta esclusiva."
  },
  TipsType_10229_Desc = {
    Text = "Àncore di vincolo dell'anima insufficienti per il potenziamento."
  },
  TipsType_10230_Desc = {
    Text = "Non possiedi ancora il Risveglio per questo Reame e non puoi selezionarlo."
  },
  TipsType_10231_Desc = {
    Text = "Crea una squadra"
  },
  TipsType_10232_Desc = {
    Text = "Il nome della squadra non può superare {s1} caratteri."
  },
  TipsType_10233_Desc = {
    Text = "Il nome della squadra non può essere vuoto"
  },
  TipsType_10234_Desc = {
    Text = "Redenzione riuscita"
  },
  TipsType_10235_Desc = {
    Text = "Non rimane più \"argento\""
  },
  TipsType_10236_Desc = {
    Text = "Non può essere ridotto ulteriormente"
  },
  TipsType_10237_Desc = {
    Text = "{s1} non è ancora disponibile. Resta in attesa."
  },
  TipsType_10238_Desc = {
    Text = "Il richiamo non è ancora disponibile. Resta in attesa."
  },
  TipsType_10239_Desc = {
    Text = "La funzione minimappa del campus non è ancora disponibile."
  },
  TipsType_10240_Desc = {
    Text = "Si sblocca al livello argomento {s1}"
  },
  TipsType_10241_Desc = {
    Text = "Nessuna carta corrisponde ai criteri"
  },
  TipsType_10242_Desc = {
    Text = "Tutte le carte reame sono state potenziate."
  },
  TipsType_10243_Desc = {
    Text = "Nessuna carta di comando disponibile per il potenziamento."
  },
  TipsType_10244_Desc = {
    Text = "Scoperto un nuovo punto di teletrasporto! Ora puoi viaggiare verso {s1}."
  },
  TipsType_10245_Desc = {
    Text = "Già posseduto. Impossibile ottenerlo di nuovo."
  },
  TipsType_10246_Desc = {
    Text = "Recupero riuscito"
  },
  TipsType_10247_Desc = {
    Text = "Rimosso con successo"
  },
  TipsType_10248_Desc = {
    Text = "Apri l'interfaccia dello zaino"
  },
  TipsType_10249_Desc = {
    Text = "È stata rilevata una disconnessione anomala dalla tua ultima sessione. La tua \"Menofina\" e i rifornimenti ottenuti sono stati restituiti. Controlla il tuo Inventario per visualizzarli."
  },
  TipsType_10250_Desc = {
    Text = "La versione AVG fornisce solo edifici selezionati; il numero totale di edifici qui è 17."
  },
  TipsType_10251_Desc = {
    Text = "La versione AVG fornisce solo edifici selezionati; il numero totale di edifici qui è 17."
  },
  TipsType_10252_Desc = {
    Text = "La versione AVG fornisce solo edifici selezionati; il numero totale di edifici qui è 17."
  },
  TipsType_10253_Desc = {
    Text = "La versione AVG fornisce solo edifici selezionati; il numero totale di edifici qui è 17."
  },
  TipsType_10254_Desc = {
    Text = "La versione AVG fornisce solo edifici selezionati; il numero totale di edifici qui è 17."
  },
  TipsType_10255_Desc = {
    Text = "La versione AVG fornisce solo edifici selezionati; il numero totale di edifici qui è 17."
  },
  TipsType_10256_Desc = {
    Text = "La versione AVG fornisce solo edifici selezionati; il numero totale di edifici qui è 17."
  },
  TipsType_10257_Desc = {
    Text = "La versione AVG fornisce solo edifici selezionati; il numero totale di edifici qui è 17."
  },
  TipsType_10258_Desc = {
    Text = "La versione AVG fornisce solo edifici selezionati; il numero totale di edifici qui è 17."
  },
  TipsType_10259_Desc = {
    Text = "La versione AVG fornisce solo edifici selezionati; il numero totale di edifici qui è 17."
  },
  TipsType_10260_Desc = {
    Text = "La versione AVG fornisce solo edifici selezionati; il numero totale di edifici qui è 17."
  },
  TipsType_10261_Desc = {
    Text = "La versione AVG fornisce solo edifici selezionati; il numero totale di edifici qui è 17."
  },
  TipsType_10262_Desc = {
    Text = "La versione AVG fornisce solo edifici selezionati; il numero totale di edifici qui è 17."
  },
  TipsType_10263_Desc = {
    Text = "La versione AVG fornisce solo edifici selezionati; il numero totale di edifici qui è 17."
  },
  TipsType_10264_Desc = {
    Text = "La versione AVG fornisce solo edifici selezionati; il numero totale di edifici qui è 17."
  },
  TipsType_10265_Desc = {
    Text = "La versione AVG fornisce solo edifici selezionati; il numero totale di edifici qui è 17."
  },
  TipsType_10266_Desc = {
    Text = "La versione AVG fornisce solo edifici selezionati; il numero totale di edifici qui è 17."
  },
  TipsType_10267_Desc = {
    Text = "Condizioni non soddisfatte"
  },
  TipsType_10268_Desc = {
    Text = "Sblocca l'Indagine rapida al Livello Custode 2"
  },
  TipsType_10269_Desc = {
    Text = "Connessione persa"
  },
  TipsType_10270_Desc = {
    Text = "Connessione al server interrotta. Verrai reindirizzato alla pagina di accesso a breve."
  },
  TipsType_10271_Desc = {Text = "Conferma"},
  TipsType_10272_Desc = {
    Text = "Il server non è ancora disponibile. Riprova più tardi."
  },
  TipsType_10273_Desc = {Text = "Successo"},
  TipsType_10274_Desc = {
    Text = "Dominio non trovato"
  },
  TipsType_10275_Desc = {
    Text = "Evento del Dominio completato"
  },
  TipsType_10276_Desc = {
    Text = "Tipo di configurazione dell'Evento del Dominio non corretto"
  },
  TipsType_10277_Desc = {
    Text = "L'Evento del Dominio non esiste"
  },
  TipsType_10278_Desc = {
    Text = "Sigilli Neri insufficienti per l'acquisto."
  },
  TipsType_10279_Desc = {
    Text = "Questa carta non può essere potenziata."
  },
  TipsType_10280_Desc = {
    Text = "Questa carta ha raggiunto il limite massimo di potenziamento."
  },
  TipsType_10281_Desc = {
    Text = "Il Mercante non vende questo oggetto."
  },
  TipsType_10282_Desc = {
    Text = "Ricompensa inesistente"
  },
  TipsType_10283_Desc = {
    Text = "Ricompensa riscossa"
  },
  TipsType_10284_Desc = {
    Text = "Errore nei dati di configurazione"
  },
  TipsType_10285_Desc = {
    Text = "Errore nei dati dell'evento"
  },
  TipsType_10286_Desc = {
    Text = "Già acquistato"
  },
  TipsType_10287_Desc = {
    Text = "Dati unità argomento non trovati"
  },
  TipsType_10288_Desc = {
    Text = "L'unità è già stata inviata. Non è necessario inviarla di nuovo."
  },
  TipsType_10289_Desc = {
    Text = "Non tutte le missioni dell'unità sono state completate. Impossibile inviare."
  },
  TipsType_10290_Desc = {
    Text = "Nessun modulo per l'argomento"
  },
  TipsType_10291_Desc = {
    Text = "Dati argomento del Livello nulli"
  },
  TipsType_10292_Desc = {
    Text = "Errore nell'inserimento dati del client"
  },
  TipsType_10293_Desc = {
    Text = "Servizio non avviato"
  },
  TipsType_10294_Desc = {
    Text = "Errore nei dati del personaggio"
  },
  TipsType_10295_Desc = {
    Text = "Nessun personaggio trovato. Creane uno."
  },
  TipsType_10296_Desc = {
    Text = "Il personaggio esiste già; non è necessario crearlo di nuovo."
  },
  TipsType_10297_Desc = {
    Text = "Nome personaggio duplicato"
  },
  TipsType_10298_Desc = {
    Text = "Errore del Dominio"
  },
  TipsType_10299_Desc = {
    Text = "Questa linea narrativa non è ancora stata sbloccata."
  },
  TipsType_10300_Desc = {
    Text = "Visualizza gli Effetti terreno e le informazioni sui nemici."
  },
  TipsType_10301_Desc = {
    Text = "{s1} raggiunge {s2} per sbloccare {s3}."
  },
  TipsType_10302_Desc = {
    Text = "{s1} raggiunge {s2} per sbloccare {s3}."
  },
  TipsType_10303_Desc = {
    Text = "Condizioni di sblocco dell'edificio non soddisfatte."
  },
  TipsType_10304_Desc = {
    Text = "Requisiti di potenziamento dell'edificio non soddisfatti."
  },
  TipsType_10305_Desc = {
    Text = "Materiali insufficienti per potenziare l'edificio."
  },
  TipsType_10306_Desc = {
    Text = "Sono disponibili ricompense di missione."
  },
  TipsType_10307_Desc = {
    Text = "(I PV verranno ridotti del <Negative:10%>)"
  },
  TipsType_10308_Desc = {
    Text = "Alla fine di ogni turno, ottieni uno <BuffTipBlock:Scudo del Personaggio> pari al numero attuale di accumuli di Fortificazione. Ogni volta che subisci DAN, la Fortificazione diminuisce di <BuffTip:1> accumulo."
  },
  TipsType_10309_Desc = {
    Text = "Protezione multipla"
  },
  TipsType_10310_Desc = {
    Text = "Salute al di sotto del valore di Allerta, rischio dell'Indagine aumentato."
  },
  TipsType_10311_Desc = {
    Text = "La salute è al di sotto della soglia di Allerta. Il rischio dell'Indagine è estremamente elevato. Desideri procedere con la forza?"
  },
  TipsType_10312_Desc = {
    Text = "La stamina attuale è troppo bassa per entrare nel dominio."
  },
  TipsType_10313_Desc = {
    Text = "Seleziona una Carta esclusiva dello stesso Livello da scambiare."
  },
  TipsType_10314_Desc = {
    Text = "Sblocca questa direzione dopo che il Risveglio raggiunge il Livello di Illuminazione 2."
  },
  TipsType_10315_Desc = {
    Text = "Sblocca questa direzione dopo che il Risveglio raggiunge il Livello di Illuminazione 3."
  },
  TipsType_10316_Desc = {Text = "Attuale"},
  TipsType_10317_Desc = {
    Text = "Tutti i Risvegli hanno Abilità Bloccate e non possono effettuare la Carica."
  },
  TipsType_10318_Desc = {
    Text = "Tutte le abilità del risvegliato sono completamente cariche."
  },
  TipsType_10319_Desc = {Text = "Usato"},
  TipsType_10320_Desc = {
    Text = "Sigillo Nero insufficiente"
  },
  TipsType_10321_Desc = {
    Text = "Sigillo Nero insufficiente"
  },
  TipsType_10322_Desc = {
    Text = "Sigillo Nero insufficiente"
  },
  TipsType_10323_Desc = {
    Text = "Non è possibile ottenere una Reliquia già in tuo possesso."
  },
  TipsType_10324_Desc = {
    Text = "Aggiornamenti insufficienti"
  },
  TipsType_10325_Desc = {
    Text = "Infligge {s1} DAN agli alleati."
  },
  TipsType_10326_Desc = {Text = "ATT"},
  TipsType_10327_Desc = {
    Text = "Qui verrà mostrata un'anteprima della minimappa del Livello, permettendo ai giocatori di pianificare la propria Strategia in anticipo."
  },
  TipsType_10328_Desc = {
    Text = "Hai impiegato 10 minuti per completare un Livello nel dungeon giornaliero, dove hai acquisito un'esperienza di gioco unica e Rinforzato la tua comprensione del genere attraverso il design del Livello."
  },
  TipsType_10329_Desc = {
    Text = "Il limite attuale di PV è inferiore al 50% dei PV massimi, fai attenzione."
  },
  TipsType_10330_Desc = {
    Text = "L'energia che sostiene l'esistenza del Risveglio. Subire DAN riduce i PV, e quando i PV raggiungono lo zero, l'Indagine fallisce."
  },
  TipsType_10331_Desc = {
    Text = "Una misura dell'intensità d'Attacco del Risveglio. Più alta è la Forza, maggiori sono i DAN inflitti ai nemici quando si utilizzano le Carte di comando."
  },
  TipsType_10332_Desc = {
    Text = "Un riflesso della capacità difensiva del Risveglio. Più alta è l'Allerta, maggiore è lo Scudo del Personaggio ottenuto quando si utilizzano le Carte di comando."
  },
  TipsType_10333_Desc = {
    Text = "Clicca ovunque per continuare"
  },
  TipsType_10334_Desc = {
    Text = "Nessun oggetto d'indagine della missione ancora completato."
  },
  TipsType_10335_Desc = {
    Text = "Valutazione"
  },
  TipsType_10336_Desc = {
    Text = "Conferisci a 1 Carta Esclusiva lo Spirito di Rivelazione."
  },
  TipsType_10337_Desc = {
    Text = "Scegli la direzione di potenziamento per la Carta esclusiva."
  },
  TipsType_10338_Desc = {
    Text = "La minimappa della città principale non è ancora disponibile. Resta in attesa."
  },
  TipsType_10339_Desc = {
    Text = "Valore {s1}{s2}"
  },
  TipsType_10340_Desc = {
    Text = "Mazzo Base di {s1} — Aumento di Livello"
  },
  TipsType_10341_Desc = {
    Text = "<Positive:Affinità:>"
  },
  TipsType_10342_Desc = {
    Text = "Una manifestazione del legame emotivo con il Risvegliato. Man mano che l'affinità si approfondisce, potrai conoscere il Risvegliato più intimamente."
  },
  TipsType_10343_Desc = {
    Text = "<Positive:Livello attuale:>{s1}"
  },
  TipsType_10344_Desc = {
    Text = "<Positive:Mazzo Base:>"
  },
  TipsType_10345_Desc = {
    Text = "Il mazzo iniziale di cui il Reame dispone quando si entra in un dungeon."
  },
  TipsType_10346_Desc = {
    Text = "<Positive:Livello più alto nel Mazzo:>{s1} Livello"
  },
  TipsType_10347_Desc = {
    Text = "<Positive:Livello del Mazzo:>"
  },
  TipsType_10348_Desc = {
    Text = "Quando il numero specificato di Risvegliati in questo Reame raggiunge il livello di affinità designato, il mazzo base può essere potenziato."
  },
  TipsType_10349_Desc = {
    Text = "<Positive:Contenuto del Potenziamento:>"
  },
  TipsType_10350_Desc = {
    Text = "Ogni potenziamento migliorerà il valore base di una Carta di comando."
  },
  TipsType_10351_Desc = {
    Text = "Affetto di {s1} aumentato"
  },
  TipsType_10352_Desc = {
    Text = "Nel Silenzio del Dominio"
  },
  TipsType_10353_Desc = {
    Text = "I Domini respingono gli intrusi"
  },
  TipsType_10354_Desc = {
    Text = "Repulsione del Dominio aumentata"
  },
  TipsType_10355_Desc = {
    Text = "La repulsione raggiunge {s1}, il Dominio ti sta osservando."
  },
  TipsType_10356_Desc = {
    Text = "Illuminare 1"
  },
  TipsType_10357_Desc = {
    Text = "Comprendi questa Abilità"
  },
  TipsType_10358_Desc = {
    Text = "Il numero massimo di Tentacoli che possono esistere simultaneamente."
  },
  TipsType_10359_Desc = {
    Text = "Una misura della forza d'attacco del Tentacolo. Più è forte la Forza del Tentacolo, più danni infligge ai nemici quando viene attivato."
  },
  TipsType_10360_Desc = {
    Text = "Nessuna Carta di comando selezionata"
  },
  TipsType_10361_Desc = {
    Text = "Trasformazione riuscita"
  },
  TipsType_10362_Desc = {
    Text = "Nessuna Carta di comando selezionata"
  },
  TipsType_10363_Desc = {
    Text = "Copiato con successo"
  },
  TipsType_10364_Desc = {
    Text = "{s1} Carta/e di comando selezionata/e"
  },
  TipsType_10365_Desc = {
    Text = "Nessuna Carta di comando selezionata"
  },
  TipsType_10366_Desc = {
    Text = "Nessuna Carta di comando selezionata"
  },
  TipsType_10367_Desc = {Text = "Potenziato"},
  TipsType_10368_Desc = {
    Text = "L'interfaccia dell'inventario delle Reliquie è in fase di sviluppo. Resta in attesa di aggiornamenti."
  },
  TipsType_10369_Desc = {
    Text = "Seleziona una reliquia da trasformare"
  },
  TipsType_10370_Desc = {
    Text = "Gioco aggiornato. Scarica e installa nuovamente."
  },
  TipsType_10371_Desc = {
    Text = "Effetto avanzato"
  },
  TipsType_10372_Desc = {
    Text = "Info Dominio"
  },
  TipsType_10373_Desc = {
    Text = "Per ogni carta danno giocata, un Tentacolo infligge {s1} danni a un nemico casuale."
  },
  TipsType_10374_Desc = {
    Text = "Nessun argomento in sospeso al momento"
  },
  TipsType_10375_Desc = {
    Text = "Nessun argomento archiviato"
  },
  TipsType_10376_Desc = {
    Text = "Compiti incompiuti di questa indagine"
  },
  TipsType_10377_Desc = {
    Text = "Impossibile annullare"
  },
  TipsType_10378_Desc = {
    Text = "(I seguenti argomenti sono stati archiviati automaticamente.)"
  },
  TipsType_10379_Desc = {
    Text = "Argomento obiettivo completato"
  },
  TipsType_10380_Desc = {
    Text = "Oggetto non posseduto"
  },
  TipsType_10381_Desc = {
    Text = "Valore dell'indice non valido"
  },
  TipsType_10382_Desc = {Text = "Bloccato"},
  TipsType_10383_Desc = {
    Text = "Nessun tentativo di potenziamento della carta esclusiva rimanente"
  },
  TipsType_10384_Desc = {
    Text = "1 slot Conservare Reliquia sbloccato."
  },
  TipsType_10385_Desc = {
    Text = "Aumento del tasso di connessione"
  },
  TipsType_10386_Desc = {
    Text = "Nessuna informazione sullo slot disponibile"
  },
  TipsType_10387_Desc = {
    Text = "Valuta insufficiente"
  },
  TipsType_10388_Desc = {
    Text = "Livello massimo raggiunto"
  },
  TipsType_10389_Desc = {
    Text = "In fase di sviluppo, resta sintonizzato."
  },
  TipsType_10390_Desc = {
    Text = "Nessuno slot di potenziamento manuale disponibile"
  },
  TipsType_10391_Desc = {
    Text = "Può essere utilizzato dopo essere stato dissigillato in un negozio o accampamento."
  },
  TipsType_10392_Desc = {
    Text = "Questa Battaglia costa {s1} Stamina"
  },
  TipsType_10393_Desc = {
    Text = "L'energia del Risvegliato è al massimo e non può essere aumentata ulteriormente."
  },
  TipsType_10394_Desc = {
    Text = "L'energia di tutti i Risvegliati è stata potenziata al massimo."
  },
  TipsType_10395_Desc = {
    Text = "Richiede \"I Suoi Occhi\" per lo sblocco"
  },
  TipsType_10396_Desc = {
    Text = "Orazione incisa con successo"
  },
  TipsType_10397_Desc = {
    Text = "{s1} Risvegliato/i schierato/i, la squadra porterà con sé {s2} tratto/i del Reame."
  },
  TipsType_10398_Desc = {
    Text = "Il gruppo diventa Neutrale, senza portare alcun tratto del Reame."
  },
  TipsType_10399_Desc = {
    Text = "La verifica del sistema del ciclo minore si sblocca nei Livelli del Capitolo 4."
  },
  TipsType_10400_Desc = {
    Text = "Puoi ereditare un massimo di {s1} Reliquie. Riduci prima il numero di Reliquie selezionate."
  },
  TipsType_10401_Desc = {
    Text = "Le Reliquie non selezionate non possono essere ereditate."
  },
  TipsType_10405_Desc = {
    Text = "Ottieni {s1}"
  },
  TipsType_10406_Desc = {
    Text = "I Risvegliati sul campo hanno raggiunto il limite massimo."
  },
  TipsType_10407_Desc = {
    Text = "Questa Torre d'Oro non può essere sfidata."
  },
  TipsType_10408_Desc = {
    Text = "Questa Torre d'Oro è bloccata. Completa il dungeon d'indagine designato."
  },
  TipsType_10409_Desc = {
    Text = "Seleziona un Risvegliato da schierare"
  },
  TipsType_10410_Desc = {
    Text = "I Risveglio sono impegnati a completare gli Incarichi. Torna più tardi per riscuotere le tue ricompense."
  },
  TipsType_10411_Desc = {
    Text = "Ricevuti {s1} Certificati Rosa"
  },
  TipsType_10412_Desc = {
    Text = "Le ricompense temporali necessitano di tempo per accumularsi."
  },
  TipsType_10413_Desc = {
    Text = "\"Argento\" insufficiente"
  },
  TipsType_10414_Desc = {
    Text = "Nessun tentativo di sfida rimanente"
  },
  TipsType_10415_Desc = {
    Text = "Sfida in fase di recupero"
  },
  TipsType_10416_Desc = {
    Text = "Nessun avversario da sfidare"
  },
  TipsType_10417_Desc = {
    Text = "Seleziona un Risvegliato da schierare"
  },
  TipsType_10418_Desc = {
    Text = "Elisir di gnosi insufficiente, impossibile continuare a salire di livello."
  },
  TipsType_10419_Desc = {
    Text = "Il Livello attuale ha raggiunto il massimo."
  },
  TipsType_10420_Desc = {
    Text = "Risvegliatore bloccato"
  },
  TipsType_10421_Desc = {
    Text = "Rimosso dalla collezione con successo."
  },
  TipsType_10422_Desc = {
    Text = "Tentativi di acquisto insufficienti per le sfide della storia"
  },
  TipsType_10423_Desc = {
    Text = "Stelle della trama insufficienti per la spazzata"
  },
  TipsType_10424_Desc = {
    Text = "Configurazione del Reame non corretta per il gruppo del dungeon d'indagine."
  },
  TipsType_10425_Desc = {
    Text = "\"Argento\" insufficiente"
  },
  TipsType_10426_Desc = {
    Text = "Limite giornaliero di acquisto voucher raggiunto"
  },
  TipsType_10427_Desc = {
    Text = "Si sblocca dopo aver ottenuto 3 stelle nel Regno segreto."
  },
  TipsType_10428_Desc = {
    Text = "Ottenuti con successo {s1} voucher."
  },
  TipsType_10429_Desc = {
    Text = "Ottenuti con successo {s1} tentativi di sfida."
  },
  TipsType_10430_Desc = {
    Text = "Completa l'Indagine 4-6 per sbloccare"
  },
  TipsType_10431_Desc = {
    Text = "Voucher insufficienti"
  },
  TipsType_10432_Desc = {
    Text = "Tentativi di acquisto con voucher insufficienti"
  },
  TipsType_10433_Desc = {
    Text = "Il Livello di Illuminazione ha raggiunto il massimo."
  },
  TipsType_10434_Desc = {
    Text = "\"{s1}\" insufficiente"
  },
  TipsType_10435_Desc = {
    Text = "Oggetto non disponibile per la vendita"
  },
  TipsType_10436_Desc = {
    Text = "Nessun negozio di questo tipo"
  },
  TipsType_10437_Desc = {
    Text = "L'oggetto in vendita è esaurito"
  },
  TipsType_10438_Desc = {
    Text = "Nessun dato del negozio disponibile"
  },
  TipsType_10439_Desc = {
    Text = "Nessun tentativo di aggiornamento disponibile"
  },
  TipsType_10440_Desc = {
    Text = "Il limite di acquisto giornaliero di \"Menofina\" è stato raggiunto."
  },
  TipsType_10441_Desc = {
    Text = "Frammenti del Risvegliatore insufficienti"
  },
  TipsType_10442_Desc = {
    Text = "Illuminazione attivata"
  },
  TipsType_10443_Desc = {
    Text = "Illuminazione prerequisita non attivata"
  },
  TipsType_10444_Desc = {
    Text = "Acquistati con successo \"Menofina\" × {s1}."
  },
  TipsType_10445_Desc = {
    Text = "Limite di \"Menofina\" raggiunto"
  },
  TipsType_10446_Desc = {
    Text = "Completa l'Indagine 1-12 per sbloccare"
  },
  TipsType_10447_Desc = {
    Text = "Completa il Prologo per sbloccare"
  },
  TipsType_10448_Desc = {
    Text = "Completa il Prologo per sbloccare"
  },
  TipsType_10449_Desc = {
    Text = "Completa l'Indagine 2-14 per sbloccare"
  },
  TipsType_10450_Desc = {
    Text = "Questa Abilità ha raggiunto il Livello massimo"
  },
  TipsType_10451_Desc = {
    Text = "Grado di Edificazione insufficiente"
  },
  TipsType_10452_Desc = {
    Text = "Materiali insufficienti"
  },
  TipsType_10453_Desc = {
    Text = "Completa l'Indagine 3-15 per sbloccare"
  },
  TipsType_10454_Desc = {
    Text = "Completa l'Indagine 3-7 per sbloccare"
  },
  TipsType_10455_Desc = {
    Text = "Condizioni di potenziamento dell'abilità non soddisfatte"
  },
  TipsType_10456_Desc = {
    Text = "La versione di prova consente solo 1 operazione di ricarica per oggetto di ricarica."
  },
  TipsType_10457_Desc = {
    Text = "L'Avvento Genesi di questo Risvegliato è in fase di recupero; scatenalo al prossimo turno."
  },
  TipsType_10458_Desc = {
    Text = "Nessuna configurazione corrispondente nelle impostazioni di ricarica"
  },
  TipsType_10459_Desc = {
    Text = "Hai già ricevuto la ricarica gratuita e non puoi ricaricare di nuovo"
  },
  TipsType_10460_Desc = {
    Text = "Risonanza già attiva. Non è necessario attivarla di nuovo."
  },
  TipsType_10461_Desc = {
    Text = "Il prezzo di {s1} è cambiato. Si prega di confermare."
  },
  TipsType_10462_Desc = {
    Text = "Certificati Rosa insufficienti"
  },
  TipsType_10463_Desc = {
    Text = "\"Distintivo d'addestramento\" insufficiente"
  },
  TipsType_10464_Desc = {
    Text = "Completa l'Indagine 3-4 per sbloccare"
  },
  TipsType_10465_Desc = {
    Text = "Completa l'Indagine 2-16 per sbloccare"
  },
  TipsType_10466_Desc = {
    Text = "Completa l'Indagine 3-16 per sbloccare"
  },
  TipsType_10467_Desc = {
    Text = "Completa l'Indagine 4-12 per sbloccare"
  },
  TipsType_10468_Desc = {
    Text = "Completa l'Indagine 5-12 per sbloccare"
  },
  TipsType_10469_Desc = {
    Text = "Completa l'Indagine 6-12 per sbloccare"
  },
  TipsType_10470_Desc = {
    Text = "Completa l'Indagine 1-7 per sbloccare"
  },
  TipsType_10471_Desc = {
    Text = "Equipaggiato con successo"
  },
  TipsType_10472_Desc = {
    Text = "Rimosso l'equipaggiamento con successo"
  },
  TipsType_10473_Desc = {
    Text = "Livello Massimo Raggiunto"
  },
  TipsType_10474_Desc = {
    Text = "Certificati Rosa insufficienti"
  },
  TipsType_10475_Desc = {
    Text = "Seleziona i materiali"
  },
  TipsType_10476_Desc = {
    Text = "Attualmente bloccato e protetto. Si prega di sbloccarlo prima."
  },
  TipsType_10477_Desc = {
    Text = "Livello non disponibile"
  },
  TipsType_10478_Desc = {
    Text = "Non disponibile al di fuori del combattimento"
  },
  TipsType_10479_Desc = {
    Text = "La Pila degli scarti è vuota"
  },
  TipsType_10480_Desc = {
    Text = "Regolazione del combattimento RPG in corso, attualmente si conclude con una vittoria diretta"
  },
  TipsType_10482_Desc = {
    Text = "La Ruota del destino è bloccata"
  },
  TipsType_10483_Desc = {
    Text = "Ruota del destino non trovata"
  },
  TipsType_10484_Desc = {
    Text = "La Ruota del destino ha raggiunto il livello massimo."
  },
  TipsType_10485_Desc = {
    Text = "La Ruota del destino è stata equipaggiata"
  },
  TipsType_10486_Desc = {
    Text = "Ruota del destino non compatibile"
  },
  TipsType_10487_Desc = {
    Text = "Ruota del destino sbloccata"
  },
  TipsType_10488_Desc = {
    Text = "I Patti attualmente in una \"Formazione,\" \"Supporto\" o \"Piano Patto\" non possono essere smantellati."
  },
  TipsType_10489_Desc = {
    Text = "Le Ruote del Destino attualmente in una \"Formazione\" o \"Supporto\" non possono essere smantellate."
  },
  TipsType_10490_Desc = {
    Text = "Aliemus insufficiente per Scatenare l'Esaltazione."
  },
  TipsType_10491_Desc = {
    Text = "Riscuoti prima il pacchetto dono precedente."
  },
  TipsType_10492_Desc = {
    Text = "Il Patto attuale è bloccato. Sbloccalo per utilizzarlo come materiale."
  },
  TipsType_10493_Desc = {
    Text = "La Ruota del Destino attuale è bloccata. Sbloccala per utilizzarla come materiale."
  },
  TipsType_10494_Desc = {
    Text = "Completa l'Indagine 1-7 per sbloccare"
  },
  TipsType_10495_Desc = {
    Text = "Completa Indagine 1-13 per Sbloccare"
  },
  TipsType_10496_Desc = {
    Text = "Il livello attuale del Patto ha raggiunto il massimo."
  },
  TipsType_10497_Desc = {
    Text = "Reset del Negozio"
  },
  TipsType_10498_Desc = {Text = "Sostituito"},
  TipsType_10499_Desc = {
    Text = "Aggiunto ai preferiti"
  },
  TipsType_10500_Desc = {Text = "Asceso"},
  TipsType_10501_Desc = {
    Text = "La Sfida Attuale è Bloccata"
  },
  TipsType_10502_Desc = {
    Text = "Il Risvegliato attuale ha già affrontato un altro Livello in {s1} e non può essere schierato nuovamente."
  },
  TipsType_10503_Desc = {
    Text = "Il numero di Risvegliati in battaglia è inferiore a 4, impossibile lanciare la sfida."
  },
  TipsType_10504_Desc = {
    Text = "Completa l'Indagine 3-7 per sbloccare"
  },
  TipsType_10505_Desc = {
    Text = "Raggiungi 3 Stelle al Piano 1 per Sbloccare"
  },
  TipsType_10506_Desc = {
    Text = "Raggiungi 3 Stelle al Piano 2 per Sbloccare"
  },
  TipsType_10507_Desc = {
    Text = "Raggiungi 3 Stelle al Piano 3 per Sbloccare"
  },
  TipsType_10508_Desc = {
    Text = "Raggiungi 3 Stelle al Piano 4 per Sbloccare"
  },
  TipsType_10509_Desc = {
    Text = "Raggiungi 3 Stelle al Piano 5 per Sbloccare"
  },
  TipsType_10510_Desc = {
    Text = "Raggiungi 3 Stelle al Piano 6 per Sbloccare"
  },
  TipsType_10511_Desc = {
    Text = "Raggiungi 3 Stelle al Piano 7 per Sbloccare"
  },
  TipsType_10512_Desc = {
    Text = "Raggiungi 3 Stelle al Piano 8 per Sbloccare"
  },
  TipsType_10513_Desc = {
    Text = "Seleziona il Patto che desideri potenziare."
  },
  TipsType_10514_Desc = {Text = "Riscosso"},
  TipsType_10515_Desc = {
    Text = "Completa l'Indagine 2-14 per sbloccare"
  },
  TipsType_10516_Desc = {
    Text = "Completa Indagine 4-7 per Sbloccare"
  },
  TipsType_10517_Desc = {
    Text = "Completa Indagine 4-7 per Sbloccare"
  },
  TipsType_10518_Desc = {
    Text = "Formazione Salvata"
  },
  TipsType_10519_Desc = {
    Text = "Tocca l'Area Luminosa per Muoverti"
  },
  TipsType_10520_Desc = {
    Text = "I nomi delle squadre possono contenere solo caratteri cinesi, lettere inglesi e numeri."
  },
  TipsType_10521_Desc = {
    Text = "Il nome della squadra non può superare gli 8 caratteri"
  },
  TipsType_10522_Desc = {
    Text = "Il numero di Risvegliati nella squadra è inferiore a {s1}, impossibile condurre l'indagine."
  },
  TipsType_10523_Desc = {
    Text = "Il Risvegliato ha già partecipato a un combattimento in altri Domini di questo piano del Reame Senza Luce."
  },
  TipsType_10524_Desc = {
    Text = "La tua squadra ha già due Risvegliati dello stesso Reame, quindi non è possibile selezionare un Risvegliato di un altro Reame."
  },
  TipsType_10525_Desc = {
    Text = "Seleziona un Risvegliatore"
  },
  TipsType_10526_Desc = {
    Text = "Numero Massimo di Risvegliati Selezionato"
  },
  TipsType_10527_Desc = {
    Text = "Nota di Addestramento: nell'Immersione Fantasmatica, il Livello del Risvegliato e i livelli delle abilità sono entrambi impostati al Livello 1."
  },
  TipsType_10528_Desc = {
    Text = "Il Nome della Squadra Non Può Essere Vuoto"
  },
  TipsType_10529_Desc = {
    Text = "Nella squadra è presente un Risvegliato esausto, incapace di combattere ancora."
  },
  TipsType_10530_Desc = {
    Text = "Tutti gli allegati nella casella di posta sono stati riscossi."
  },
  TipsType_10531_Desc = {
    Text = "Si sblocca dopo aver completato il Prologo della Storia principale"
  },
  TipsType_10532_Desc = {
    Text = "L'Inventario è pieno. Alcuni oggetti non sono stati raccolti. Libera spazio nell'inventario e riprova."
  },
  TipsType_10533_Desc = {
    Text = "L'Inventario è pieno. Le tue ricompense saranno inviate alla tua casella di posta."
  },
  TipsType_10534_Desc = {
    Text = "L'Inventario è pieno. Alcuni oggetti non sono stati raccolti. Libera spazio nell'inventario e riprova."
  },
  TipsType_10535_Desc = {
    Text = "Nessun allegato nella posta"
  },
  TipsType_10536_Desc = {
    Text = "Riscatta Prima la Reliquia"
  },
  TipsType_10537_Desc = {
    Text = "Completa l'Indagine 2-14 per sbloccare"
  },
  TipsType_10538_Desc = {
    Text = "Completa l'Indagine 1-12 per sbloccare"
  },
  TipsType_10539_Desc = {
    Text = "Completa l'Indagine 1-12 per sbloccare"
  },
  TipsType_10540_Desc = {
    Text = "Completa l'Indagine 1-12 per sbloccare"
  },
  TipsType_10541_Desc = {
    Text = "Raggiungi 3 Stelle al Piano 9 per Sbloccare"
  },
  TipsType_10542_Desc = {
    Text = "Raggiungi 3 Stelle al Piano 10 per Sbloccare"
  },
  TipsType_10543_Desc = {
    Text = "Raggiungi 3 Stelle al Piano 11 per Sbloccare"
  },
  TipsType_10544_Desc = {
    Text = "Raggiungi 3 Stelle al Piano 12 per Sbloccare"
  },
  TipsType_10545_Desc = {
    Text = "Raggiungi 3 Stelle al Piano 13 per Sbloccare"
  },
  TipsType_10546_Desc = {
    Text = "Raggiungi 3 Stelle al Piano 14 per Sbloccare"
  },
  TipsType_10547_Desc = {
    Text = "Questa Funzione Sta per Essere Rimossa"
  },
  TipsType_10548_Desc = {
    Text = "Completa l'Indagine 1-7 per sbloccare"
  },
  TipsType_10549_Desc = {
    Text = "Non È Possibile Ottenere Altre Reliquie"
  },
  TipsType_10550_Desc = {
    Text = "{s1} ha completato il Legame, e ora puoi comandarla in battaglia."
  },
  TipsType_10551_Desc = {
    Text = "Il Livello e il Livello Abilità di {s1} superano quanto l'Amplificatore di Gnosi può fornire e non possono essere utilizzati."
  },
  TipsType_10552_Desc = {
    Text = "Il Livello del Risvegliatore e il Livello Abilità hanno superato il Livello fornito dall'Amplificatore di Gnosi e non possono essere utilizzati."
  },
  TipsType_10553_Desc = {
    Text = "Restate sintonizzati"
  },
  TipsType_10554_Desc = {
    Text = "Si sblocca dopo aver completato il Livello precedente."
  },
  TipsType_10555_Desc = {
    Text = "Non Si Torna Indietro sul Sentiero Fragile"
  },
  TipsType_10556_Desc = {
    Text = "Non ancora disponibile. Resta in attesa."
  },
  TipsType_10557_Desc = {
    Text = "Possiedi già questa Reliquia e non puoi ottenerla di nuovo."
  },
  TipsType_10558_Desc = {
    Text = [[
Stai per recuperare il contenuto dagli appunti di sistema ed eseguire <Positive:[Paste]>
Sei sicuro?]]
  },
  TipsType_10558_LeftBtnDesc = {Text = "Annulla"},
  TipsType_10558_RightBtnDesc = {Text = "Conferma"},
  TipsType_10558_Title = {
    Text = "Abilita incolla"
  },
  TipsType_10559_Desc = {
    Text = "Materiali insufficienti"
  },
  TipsType_10560_Desc = {
    Text = "Già nello Stato Iniziale"
  },
  TipsType_10561_Desc = {
    Text = "Certificati Rosa insufficienti"
  },
  TipsType_10562_Desc = {Text = "Non Asceso"},
  TipsType_10563_Desc = {
    Text = "Reset della Risonanza Riuscito"
  },
  TipsType_10564_Desc = {
    Text = "Raggiungi il Livello Custode {s1}"
  },
  TipsType_10565_Desc = {
    Text = "L'Aliemus Sigillato Non Può Essere Scatenato"
  },
  TipsType_1056601_Desc = {
    Text = "Errore di comunicazione Argento, controlla la connessione di rete e riprova ({s1})."
  },
  TipsType_10566_Desc = {
    Text = "Errore di comunicazione Argento, riprova più tardi ({s1})."
  },
  TipsType_10567_Desc = {
    Text = "Recupero delle informazioni del server non riuscito! {s1}."
  },
  TipsType_10568_Desc = {
    Text = "Seleziona Prima un Server"
  },
  TipsType_10569_Desc = {
    Text = "Non ancora sbloccato"
  },
  TipsType_10570_Desc = {
    Text = "Inserisci il tuo account"
  },
  TipsType_10571_Desc = {
    Text = "Materiali di attivazione della Risonanza insufficienti"
  },
  TipsType_10572_Desc = {
    Text = "Risonanza prerequisita non potenziata"
  },
  TipsType_10573_Desc = {
    Text = "Livello massimo"
  },
  TipsType_10574_Desc = {Text = "Potenziato"},
  TipsType_10575_Desc = {
    Text = "Questo Risvegliatore non può essere sostituito"
  },
  TipsType_10576_Desc = {
    Text = "Questo slot non è disponibile per lo schieramento"
  },
  TipsType_10577_Desc = {
    Text = "Risvegliatori insufficienti, impossibile accettare la sfida"
  },
  TipsType_10578_Desc = {
    Text = "Livello successivo Bloccato"
  },
  TipsType_10579_Desc = {
    Text = "Questo è già l'ultimo Livello"
  },
  TipsType_10580_Desc = {
    Text = "Limite EXP raggiunto, impossibile aggiungere"
  },
  TipsType_10581_Desc = {
    Text = "Slot della Ruota del destino pieni, impossibile aggiungere"
  },
  TipsType_10582_Desc = {
    Text = "Nessun materiale disponibile per il posizionamento rapido."
  },
  TipsType_10583_Desc = {
    Text = "Inserisci i materiali nello slot della Ruota del destino."
  },
  TipsType_10584_Desc = {
    Text = "Nessuna Ruota del destino Disponibile da equipaggiare"
  },
  TipsType_10585_Desc = {
    Text = "Completa l'Indagine 2-8 per sbloccare"
  },
  TipsType_10586_Desc = {
    Text = "Completa l'Indagine 2-14 per sbloccare"
  },
  TipsType_10587_Desc = {
    Text = "Completa l'Indagine 3-16 per sbloccare"
  },
  TipsType_10588_Desc = {
    Text = "Completa l'Indagine 4-12 per sbloccare"
  },
  TipsType_10589_Desc = {
    Text = "Completa l'Indagine 5-12 per sbloccare"
  },
  TipsType_10590_Desc = {
    Text = "Completa l'Indagine 6-12 per sbloccare"
  },
  TipsType_10591_Desc = {
    Text = "Completa l'Indagine 2-12 per sbloccare"
  },
  TipsType_10592_Desc = {
    Text = "Questo account è stato sospeso dall'accesso. Per qualsiasi domanda, contatta l'assistenza clienti."
  },
  TipsType_10593_Desc = {
    Text = "La sessione di accesso è scaduta. Effettua nuovamente il login."
  },
  TipsType_10594_Desc = {
    Text = "\"Menofina\" insufficiente"
  },
  TipsType_10595_Desc = {
    Text = "Attivare \"{s1}\"?"
  },
  TipsType_10595_Title = {
    Text = "Attiva Talento"
  },
  TipsType_10596_Desc = {
    Text = "Questo Risvegliatore non è ancora stato ottenuto"
  },
  TipsType_10597_Desc = {
    Text = "Nessuna Ruota del destino Disponibile da potenziare"
  },
  TipsType_10598_Desc = {
    Text = "Questo account è stato sospeso dall'accesso fino al {s1} per violazione delle normative vigenti. Per qualsiasi domanda, contatta l'assistenza clienti."
  },
  TipsType_10599_Desc = {
    Text = "Completa l'Indagine 2-15 per sbloccare"
  },
  TipsType_10600_Desc = {
    Text = "Livello massimo raggiunto, impossibile aggiungerne altri"
  },
  TipsType_10601_Desc = {
    Text = "Sblocca il Diario di Viaggio del Custode dopo il Completamento dell'Indagine 1-7."
  },
  TipsType_10602_Desc = {
    Text = "Sblocca le missioni di Padronanza del Reame dopo il Completamento dell'Indagine 1-7."
  },
  TipsType_10603_Desc = {
    Text = "Nessun materiale selezionato"
  },
  TipsType_10604_Desc = {
    Text = "Uscita automatica dall'istanza per inattività."
  },
  TipsType_10605_Desc = {
    Text = "Il questionario è stato completato. Grazie per il tuo supporto."
  },
  TipsType_10606_Desc = {
    Text = "Materiali insufficienti per l'attivazione"
  },
  TipsType_10607_Desc = {
    Text = "Il limite di ricompense per questa settimana è stato raggiunto. Non riceverai alcuna ricompensa dopo aver completato la sfida. Vuoi procedere comunque?"
  },
  TipsType_10607_LeftBtnDesc = {Text = "Annulla"},
  TipsType_10607_RightBtnDesc = {Text = "Conferma"},
  TipsType_10607_Title = {
    Text = "Suggerimento sfida"
  },
  TipsType_10608_Desc = {
    Text = "Manutenzione del campus in corso. Attendere il completamento."
  },
  TipsType_10609_Desc = {
    Text = "{s1} è stato invitato con successo nel tuo dormitorio."
  },
  TipsType_10610_Desc = {
    Text = "{s1} è già nel tuo dormitorio."
  },
  TipsType_10611_Desc = {
    Text = "Non sei connesso a una rete Wi-Fi. Vuoi usare i dati mobili per continuare il download?"
  },
  TipsType_10611_LeftBtnDesc = {Text = "Annulla"},
  TipsType_10611_RightBtnDesc = {Text = "Conferma"},
  TipsType_10611_Title = {
    Text = "Conferma download"
  },
  TipsType_10612_Desc = {
    Text = "Tutte le carte sono già incise."
  },
  TipsType_10613_Desc = {
    Text = "Errore di rete, attendere prego"
  },
  TipsType_10614_Desc = {
    Text = "La Sfida Attuale è Bloccata"
  },
  TipsType_10615_Desc = {
    Text = "In fase di recupero, impossibile Scatenare fino al prossimo turno."
  },
  TipsType_10616_Desc = {
    Text = "Selezione in corso, sarà possibile scatenare solo al termine della selezione."
  },
  TipsType_10617_Desc = {
    Text = "Nello stato Sigillato, impossibile scatenare l'Esaltazione."
  },
  TipsType_10618_Desc = {
    Text = "Il livello medio della squadra attuale {s1} è inferiore al livello raccomandato {s2}. L'indagine potrebbe incontrare difficoltà significative. Vuoi procedere comunque?"
  },
  TipsType_10618_LeftBtnDesc = {
    Text = "Potenzia Risvegliatori"
  },
  TipsType_10618_RightBtnDesc = {Text = "Conferma"},
  TipsType_10618_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_10619_Desc = {
    Text = "Raggiungi il Livello Custode {s1}"
  },
  TipsType_10620_Desc = {
    Text = "Connessione di rete insufficiente. Verifica la connessione a Steam oppure riavvia Steam e riprova."
  },
  TipsType_10621_Desc = {
    Text = "Sei sicuro di voler usare <WeaponEffect_Num:{s1}> come tuo nome?"
  },
  TipsType_10621_LeftBtnDesc = {Text = "Annulla"},
  TipsType_10621_RightBtnDesc = {Text = "Conferma"},
  TipsType_10621_Title = {
    Text = "Conferma il tuo nome"
  },
  TipsType_10622_Desc = {
    Text = "L'incisione è in fase di recupero. Il nome potrà essere nuovamente inciso tra {s1} ore e {s2} minuti."
  },
  TipsType_10623_Desc = {
    Text = "Incisione riuscita"
  },
  TipsType_10624_Desc = {
    Text = "I nomi possono contenere solo caratteri cinesi, lettere inglesi e numeri."
  },
  TipsType_10625_Desc = {
    Text = "Questa Carta sta per essere scartata"
  },
  TipsType_10626_Desc = {
    Text = "Abilita la seguente opzione in Steam: \n[Steam Settings - In-Game - Enable the Steam Overlay while in-game]\ne riavvia il gioco affinché le modifiche abbiano effetto."
  },
  TipsType_10626_RightBtnDesc = {Text = "Conferma"},
  TipsType_10626_Title = {
    Text = "Indagine in corso"
  },
  TipsType_10628_Desc = {
    Text = "Il nuovo nome non può essere uguale a quello attuale."
  },
  TipsType_10629_Desc = {
    Text = "Inserisci da {s1} a {s2} caratteri"
  },
  TipsType_10630_Desc = {
    Text = "Ricostituzione di {s1} disponibile dopo aver ottenuto 3 Stelle."
  },
  TipsType_10631_Desc = {
    Text = "Il tuo account è stato disconnesso forzatamente per violazione dei termini e delle condizioni vigenti."
  },
  TipsType_10631_RightBtnDesc = {Text = "Conferma"},
  TipsType_10631_Title = {Text = "Nota"},
  TipsType_10632_Desc = {
    Text = "Dopo aver completato la sfida, potrai effettuare la Ricostituzione oggi."
  },
  TipsType_10633_Desc = {
    Text = "I seguenti oggetti verranno consumati e <Blue:questa azione non può essere annullata>. Confermi lo smantellamento?"
  },
  TipsType_10633_LeftBtnDesc = {Text = "Annulla"},
  TipsType_10633_RightBtnDesc = {Text = "Conferma"},
  TipsType_10633_Title = {
    Text = "Conferma smantellamento"
  },
  TipsType_10634_Desc = {
    Text = "La carta mensile attuale ha ancora più di {s1} giorni rimanenti e non può essere accumulata."
  },
  TipsType_10635_Desc = {
    Text = "\"Essenza di Silver Core\" insufficiente. Desideri accedere all'Estrazione Primordiale?"
  },
  TipsType_10635_LeftBtnDesc = {Text = "Annulla"},
  TipsType_10635_RightBtnDesc = {Text = "Conferma"},
  TipsType_10635_Title = {
    Text = "Essenza di Silver Core insufficiente"
  },
  TipsType_10636_Desc = {
    Text = "Nessuna Ruota del destino inattiva Disponibile"
  },
  TipsType_10637_Desc = {
    Text = "Nessun Patto inattivo"
  },
  TipsType_10638_Desc = {
    Text = "Nessuno slot Patto disponibile. Rimuovi un Patto e riprova."
  },
  TipsType_10640_Desc = {
    Text = "Vuoi davvero rimuovere tutti i Patti da questo Risvegliatore?"
  },
  TipsType_10640_LeftBtnDesc = {Text = "Annulla"},
  TipsType_10640_RightBtnDesc = {Text = "Conferma"},
  TipsType_10640_Title = {
    Text = "Indagine in corso"
  },
  TipsType_10641_Desc = {
    Text = "È necessario riavviare il client per applicare le nuove impostazioni della lingua. Confermare?"
  },
  TipsType_10641_LeftBtnDesc = {Text = "Annulla"},
  TipsType_10641_RightBtnDesc = {Text = "Conferma"},
  TipsType_10641_Title = {
    Text = "Conferma cambio lingua"
  },
  TipsType_10642_Desc = {
    Text = "Livello giocatore insufficiente"
  },
  TipsType_10643_Desc = {
    Text = "Entrando in un'area pervasa dalla Dissoluzione, i PV vengono ridotti di {s1}."
  },
  TipsType_10644_Desc = {
    Text = "Questa Posse è già stata selezionata"
  },
  TipsType_10645_Desc = {
    Text = "Questa Posse non è ancora stata ottenuta"
  },
  TipsType_10646_Desc = {
    Text = "\"{s1}\" insufficiente"
  },
  TipsType_10647_Desc = {
    Text = "L'Evento d'Indagine non è ancora iniziato, {s1}."
  },
  TipsType_10648_Desc = {
    Text = "L'Intervallo di Rotazione è stato aggiornato"
  },
  TipsType_10649_Desc = {
    Text = "Limite di incarichi raggiunto."
  },
  TipsType_10650_Desc = {
    Text = "Nessun personaggio SSR è stato ancora sbloccato."
  },
  TipsType_10651_Desc = {
    Text = "Può essere utilizzato solo dopo aver raccolto una certa quantità."
  },
  TipsType_10652_Desc = {
    Text = "Tutti gli avatar e le Emote di Sfida sono stati ottenuti."
  },
  TipsType_10701_Desc = {
    Text = "Una Ruota del destino è attualmente equipaggiata. Rimuovila e riprova."
  },
  TipsType_10702_Desc = {
    Text = "Quando l'Ascensione extra totale delle Ruote del destino SSR equipaggiate raggiunge 12, è possibile equipaggiare due Ruote del destino SSR contemporaneamente."
  },
  TipsType_10703_Desc = {
    Text = "Il Risvegliatore ha già equipaggiato la stessa Ruota del destino e non può equipaggiarla di nuovo."
  },
  TipsType_10704_Desc = {
    Text = "Il Livello del Patto ha raggiunto il suo massimo"
  },
  TipsType_10705_Desc = {
    Text = "Il consumo di materiali ha raggiunto il suo massimo"
  },
  TipsType_10706_Desc = {
    Text = "Puoi bloccare fino a due stat secondarie"
  },
  TipsType_10707_Desc = {
    Text = "Materiali insufficienti"
  },
  TipsType_10708_Desc = {
    Text = "Si sblocca al Grado di Edificazione {s1}"
  },
  TipsType_10709_Desc = {
    Text = "\"{s1}\" insufficiente"
  },
  TipsType_10710_Desc = {Text = "Esaurito"},
  TipsType_10711_Desc = {
    Text = "Questo Oggetto è Bloccato"
  },
  TipsType_10712_Desc = {
    Text = "L'inventario dei materiali è pieno"
  },
  TipsType_10713_Desc = {
    Text = "L'Ascensione della Ruota del destino ha raggiunto il massimo."
  },
  TipsType_10714_Desc = {
    Text = "Condizioni dell'evento non soddisfatte, impossibile selezionare."
  },
  TipsType_10715_Desc = {
    Text = "Installa l'app corrispondente prima di condividere."
  },
  TipsType_10716_Desc = {
    Text = "Non è possibile selezionare altre Ruote del Destino."
  },
  TipsType_10717_Desc = {
    Text = "Non è possibile selezionare altre Posse"
  },
  TipsType_10718_Desc = {
    Text = "Attivazione riuscita"
  },
  TipsType_10719_Desc = {
    Text = "Sigillo dei mille volti insufficiente. Puoi convertire automaticamente i materiali in \"Impostazioni di Scambio\""
  },
  TipsType_10720_Desc = {
    Text = "Velocità impostata a 1x"
  },
  TipsType_10721_Desc = {
    Text = "Velocità impostata a 2x"
  },
  TipsType_10722_Desc = {
    Text = "L'ingresso del campus è congestionato, riprova più tardi."
  },
  TipsType_10723_Desc = {
    Text = "Salvataggio riuscito"
  },
  TipsType_10724_Desc = {
    Text = "Salvataggio non riuscito. I permessi dell'album non sono abilitati o lo spazio di archiviazione è insufficiente."
  },
  TipsType_10725_Desc = {
    Text = "Materiali di fabbricazione insufficienti"
  },
  TipsType_10726_Desc = {
    Text = "Seleziona una Carta"
  },
  TipsType_10727_Desc = {
    Text = "Questo Risvegliatore è stato disabilitato"
  },
  TipsType_10728_Desc = {
    Text = "I Risveglio della Genesi non possono essere schierati. Scegli di nuovo."
  },
  TipsType_10736_Desc = {
    Text = "La \"Menofina\" è sufficiente, non è necessario reintegrarla."
  },
  TipsType_10737_Desc = {
    Text = "È stata rilevata una nuova versione del gioco. Riavvia il gioco per aggiornare e garantire un'esperienza ottimale."
  },
  TipsType_10738_Desc = {
    Text = "Hai già letto tutti i tutorial disponibili."
  },
  TipsType_10739_Desc = {
    Text = "{s1} ha già partecipato a {s2} e non può accedervi di nuovo."
  },
  TipsType_10740_Desc = {
    Text = "Il livello medio della tua squadra {s1} è inferiore al livello raccomandato {s2}. L'indagine potrebbe incontrare difficoltà significative. Vuoi procedere comunque?"
  },
  TipsType_10740_LeftBtnDesc = {Text = "Annulla"},
  TipsType_10740_RightBtnDesc = {Text = "Conferma"},
  TipsType_10740_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_10741_Desc = {
    Text = "Il livello medio della tua squadra {s1} e il tuo livello Custode {s2} sono entrambi troppo bassi per questo livello. L'indagine potrebbe incontrare difficoltà significative. Vuoi procedere comunque?"
  },
  TipsType_10741_LeftBtnDesc = {Text = "Annulla"},
  TipsType_10741_RightBtnDesc = {Text = "Conferma"},
  TipsType_10741_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_10742_Desc = {
    Text = [[
Gli effetti duplicati della Ruota del destino non possono essere cumulati. Attualmente, <Blue:{s1}> ha una Ruota del destino inattiva. Ti consigliamo di modificare la formazione della Ruota del destino.
Procedere comunque?]]
  },
  TipsType_10742_LeftBtnDesc = {Text = "Annulla"},
  TipsType_10742_RightBtnDesc = {Text = "Conferma"},
  TipsType_10742_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_10743_Desc = {
    Text = "Nessuna assistenza rimanente nella Zona D-Effetto Regionale"
  },
  TipsType_10744_Desc = {
    Text = "Limite di seguiti raggiunto"
  },
  TipsType_10745_Desc = {
    Text = "Data di nascita non valida, impossibile impostare."
  },
  TipsType_10746_Desc = {Text = "Copiato"},
  TipsType_10747_Desc = {
    Text = "\"Mi piace\" aggiunto con successo"
  },
  TipsType_10748_Desc = {
    Text = "{s1} è già un Risvegliatore di supporto."
  },
  TipsType_10749_Desc = {
    Text = "Il Risvegliatore di supporto non può essere vuoto"
  },
  TipsType_10750_Desc = {
    Text = "Hai già messo \"Mi piace\" a questo Custode oggi."
  },
  TipsType_10751_Desc = {
    Text = "È possibile mostrare fino a 4 Risvegliatori"
  },
  TipsType_10752_Desc = {
    Text = "Il Reame non soddisfa i requisiti e non può essere schierato."
  },
  TipsType_10753_Desc = {
    Text = "{s1} è già nella formazione e non può essere selezionato di nuovo."
  },
  TipsType_10754_Desc = {
    Text = "{s1} è stato ripristinato"
  },
  TipsType_10755_Desc = {
    Text = "Sbloccato con successo"
  },
  TipsType_10756_Desc = {
    Text = "Nessun materiale di Ascensione disponibile"
  },
  TipsType_10757_Desc = {
    Text = "{s1} ha già partecipato alla sfida dell'evento odierno e non può competere di nuovo."
  },
  TipsType_10758_Desc = {
    Text = "Requisiti del Reame del gruppo non soddisfatti"
  },
  TipsType_10761_Desc = {
    Text = "Un Risvegliato in forma Genesi non può essere schierato contemporaneamente alla sua forma normale."
  },
  TipsType_10762_Desc = {
    Text = "La forma Genesi di un Risvegliato e la sua forma normale non possono essere visualizzate contemporaneamente."
  },
  TipsType_10799_Desc = {
    Text = "Attualmente, l'effetto set completo del Patto di <Blue:{s1}> non è attivo a causa del vincolo <Blue:Unicità Squadra>. Ti consigliamo di modificare la formazione del Patto.\nProcedere comunque?"
  },
  TipsType_10799_LeftBtnDesc = {Text = "Annulla"},
  TipsType_10799_RightBtnDesc = {Text = "Conferma"},
  TipsType_10799_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_10801_Desc = {
    Text = "Limite di piani del Patto raggiunto"
  },
  TipsType_10802_Desc = {
    Text = "{s1} è già in uso in un altro Piano del Patto e non può essere salvato."
  },
  TipsType_10803_Desc = {
    Text = "Il nome del piano del Patto non può essere vuoto"
  },
  TipsType_10804_Desc = {
    Text = "Contiene caratteri non validi, inserisci di nuovo."
  },
  TipsType_10805_Desc = {Text = "Salvato"},
  TipsType_10806_Desc = {
    Text = "Il Patto attuale è già attivo in {s1}."
  },
  TipsType_10807_Desc = {
    Text = "Equipaggiato"
  },
  TipsType_10808_Desc = {Text = "Rimosso"},
  TipsType_10809_Desc = {
    Text = "Il gruppo attuale è già schierato"
  },
  TipsType_10810_Desc = {
    Text = "Il piano del Patto non può essere vuoto"
  },
  TipsType_10811_Desc = {
    Text = "Questo piano è attualmente equipaggiato"
  },
  TipsType_10812_Desc = {
    Text = "Equipaggiato"
  },
  TipsType_10813_Desc = {
    Text = "Vuoi davvero eliminare il piano [{s1}]?"
  },
  TipsType_10813_LeftBtnDesc = {Text = "Annulla"},
  TipsType_10813_RightBtnDesc = {Text = "Conferma"},
  TipsType_10814_Desc = {
    Text = "I Risvegliati schierati in questa indagine non soddisfano i requisiti della squadra."
  },
  TipsType_10815_Desc = {
    Text = "Il Risvegliato attuale è stato progettato appositamente per la Storia e non è possibile visualizzarne i dettagli."
  },
  TipsType_10816_Desc = {
    Text = "\"Certificato di Procura\" insufficiente"
  },
  TipsType_10817_Desc = {
    Text = "Nessun registro di insediamento trovato. Completa prima una \"Sfida\" e riprova dopo il reset giornaliero delle 9:00."
  },
  TipsType_10818_Desc = {
    Text = "Emissario completato per oggi. Impossibile rigiocare."
  },
  TipsType_10821_Desc = {
    Text = "Nessun rifornimento disponibile al momento, ricontrolla più tardi."
  },
  TipsType_10822_Desc = {
    Text = "L'evento è terminato."
  },
  TipsType_10823_Desc = {
    Text = "I semi speciali possono essere riforniti nel negozio solo dopo che sono esauriti."
  },
  TipsType_10824_Desc = {
    Text = "Hai esaurito tutti i rifornimenti: non rimangono più scorte nell'inventario."
  },
  TipsType_10825_Desc = {
    Text = "\"{s1}\" insufficiente"
  },
  TipsType_10826_Desc = {
    Text = "I semi speciali sono esauriti. Puoi scegliere di piantarli per effettuare un ripristino."
  },
  TipsType_10827_Desc = {
    Text = "Il Seme speciale è stato ripristinato"
  },
  TipsType_10828_Desc = {
    Text = "Tutti gli oggetti sono stati scambiati. Seleziona Ripristino."
  },
  TipsType_10829_Desc = {
    Text = "Ripristino riuscito"
  },
  TipsType_10830_Desc = {
    Text = "La squadra contiene Awakener che non possono essere schierati. Impossibile avviare l'indagine."
  },
  TipsType_10831_Desc = {
    Text = "La squadra contiene la stessa Ruota del destino e non può accedere alla Zona D-Effetto Regionale."
  },
  TipsType_10832_Desc = {
    Text = "Nessuna Posse equipaggiata. Impossibile avviare l'indagine."
  },
  TipsType_10833_Desc = {
    Text = "La squadra contiene Ruote del destino non equipaggiabili. Impossibile avviare l'indagine."
  },
  TipsType_10834_Desc = {
    Text = "Impossibile equipaggiare la Ruota del destino sul Risvegliatore di supporto."
  },
  TipsType_10835_Desc = {
    Text = "Impossibile equipaggiare il Patto sul Risvegliatore di supporto."
  },
  TipsType_10836_Desc = {
    Text = "Impossibile equipaggiare la Ruota del destino sul Risvegliatore predefinito dalla storia."
  },
  TipsType_10837_Desc = {
    Text = "Impossibile equipaggiare un Patto per un Risvegliatore preimpostato dalla storia."
  },
  TipsType_10838_Desc = {
    Text = "Il numero di emoticon equipaggiate ha raggiunto il massimo."
  },
  TipsType_10839_Desc = {
    Text = "Emoticon in uso. Clicca su un'emoticon per rimuoverla."
  },
  TipsType_10840_Desc = {
    Text = "Stai inviando troppe emoticon. Rallenta :)"
  },
  TipsType_10841_Desc = {
    Text = "Il set di emoticon non può essere vuoto."
  },
  TipsType_10842_Desc = {
    Text = "Set di emoticon aggiornato."
  },
  TipsType_10843_Desc = {
    Text = "Questa voce è ancora bloccata"
  },
  TipsType_10844_Desc = {
    Text = "Non ancora sbloccato"
  },
  TipsType_10850_Desc = {
    Text = "La squadra contiene membri del Gruppo non equipaggiabili. Impossibile avviare l'indagine."
  },
  TipsType_10901_Desc = {Text = "Paralisi"},
  TipsType_10902_Desc = {Text = "Svenuto"},
  TipsType_10903_Desc = {
    Text = "Non ancora posseduto: {s1}"
  },
  TipsType_10904_Desc = {
    Text = "Completa la modalità \"Normale\" di questo capitolo per sbloccare la modalità \"Storia\" e guardare la Storia."
  },
  TipsType_10905_Desc = {
    Text = "Si sblocca dopo aver completato \"Operazione Indagine\" 1-15: Normale, e sblocca la trama \"Rimembranza\"."
  },
  TipsType_10906_Desc = {
    Text = "Soglia di Realtà insufficiente"
  },
  TipsType_10907_Desc = {Text = "Sbloccato"},
  TipsType_10908_Desc = {
    Text = "Il Livello di Illuminazione di {s1} è al massimo. I guadagni aggiuntivi saranno convertiti in <TipsHighlightText:\"Frammento di Gnosi Raffinata\" × 2>, <TipsHighlightText:\"Frammento di Gnosi\" × 6>, <TipsHighlightText:\"Sedimento Radicale\" × 250>. Confermi il Risveglio?"
  },
  TipsType_10908_LeftBtnDesc = {Text = "Annulla"},
  TipsType_10908_RightBtnDesc = {Text = "Conferma"},
  TipsType_10908_Title = {Text = "Conferma"},
  TipsType_10909_Desc = {
    Text = "{s1} è stato risvegliato. I guadagni ulteriori saranno convertiti in <TipsHighlightText:Frammento: {s2}*1> e <TipsHighlightText:Sedimento di Radix*50>. Confermare il risveglio?"
  },
  TipsType_10909_LeftBtnDesc = {Text = "Annulla"},
  TipsType_10909_RightBtnDesc = {Text = "Conferma"},
  TipsType_10909_Title = {Text = "Conferma"},
  TipsType_10910_Desc = {
    Text = "Confermi il risveglio di <TipsHighlightText:{s1}>?"
  },
  TipsType_10910_LeftBtnDesc = {Text = "Annulla"},
  TipsType_10910_RightBtnDesc = {Text = "Conferma"},
  TipsType_10910_Title = {Text = "Conferma"},
  TipsType_10911_Desc = {
    Text = "Spazio Insufficiente"
  },
  TipsType_10912_Desc = {
    Text = "Nessuna Carta di comando disponibile nello Spazio Ultra. Impossibile utilizzare."
  },
  TipsType_10913_Desc = {
    Text = "Non può essere utilizzato di nuovo in questo turno"
  },
  TipsType_10914_Desc = {
    Text = "Confermi la selezione di <TipsHighlightText:{s1}>?"
  },
  TipsType_10914_LeftBtnDesc = {Text = "Annulla"},
  TipsType_10914_RightBtnDesc = {Text = "Conferma"},
  TipsType_10914_Title = {
    Text = "Conferma selezione"
  },
  TipsType_10915_Desc = {
    Text = "Le Formazioni devono essere sbloccate in ordine. Non è possibile saltare le Formazioni bloccate."
  },
  TipsType_10916_Desc = {
    Text = "Consumare <Blue: {s1} × {s2}> per sbloccare?"
  },
  TipsType_10916_LeftBtnDesc = {Text = "Annulla"},
  TipsType_10916_RightBtnDesc = {Text = "Conferma"},
  TipsType_10916_Title = {
    Text = "Conferma Sblocco"
  },
  TipsType_10917_Desc = {
    Text = "{s1} Sbloccato"
  },
  TipsType_10918_Desc = {
    Text = "{s1} sbloccato. Tutte le formazioni sono state sbloccate."
  },
  TipsType_10919_Desc = {
    Text = "Sbloccabile dopo aver completato [{s1}: {s2}]. Andare a [{s1}] adesso?"
  },
  TipsType_10919_LeftBtnDesc = {Text = "Annulla"},
  TipsType_10919_RightBtnDesc = {Text = "Conferma"},
  TipsType_10919_Title = {
    Text = "Non Sbloccato"
  },
  TipsType_10920_Desc = {
    Text = "Accumula \"Ghianda Magica\" × {s1} nell'evento a tempo limitato \"Inversione di Fase\" per sbloccare. Vuoi andare a \"Inversione di Fase\"?"
  },
  TipsType_10920_LeftBtnDesc = {Text = "Annulla"},
  TipsType_10920_RightBtnDesc = {Text = "Conferma"},
  TipsType_10920_Title = {
    Text = "Non Sbloccato"
  },
  TipsType_10921_Desc = {
    Text = "Non è possibile equipaggiare contemporaneamente due Ruote del Destino con lo stesso attributo."
  },
  TipsType_20001_Desc = {
    Text = "Con Doppia Conferma tramite Casella di Spunta"
  },
  TipsType_20001_LeftBtnDesc = {Text = "Conferma"},
  TipsType_20001_Title = {Text = "Titolo"},
  TipsType_20002_Desc = {
    Text = "Senza Doppia Conferma tramite Casella di Spunta"
  },
  TipsType_20002_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20002_RightBtnDesc = {Text = "Conferma"},
  TipsType_20002_Title = {Text = "Titolo"},
  TipsType_20003_Desc = {
    Text = "Il tuo account è stato connesso su un altro dispositivo."
  },
  TipsType_20003_RightBtnDesc = {Text = "Conferma"},
  TipsType_20003_Title = {
    Text = "Suggerimento Disconnessione"
  },
  TipsType_20004_Desc = {
    Text = "Connessione al server interrotta. Effettua nuovamente l'accesso."
  },
  TipsType_20004_RightBtnDesc = {Text = "Conferma"},
  TipsType_20004_Title = {
    Text = "Suggerimento Disconnessione"
  },
  TipsType_20005_Desc = {
    Text = "Sincronizzazione fallita. Riprovare?"
  },
  TipsType_20005_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20005_RightBtnDesc = {Text = "Conferma"},
  TipsType_20005_Title = {
    Text = "Sincronizzazione Fallita"
  },
  TipsType_20006_Desc = {
    Text = "Sincronizzazione persa, ritorno alla schermata di accesso a breve."
  },
  TipsType_20006_RightBtnDesc = {Text = "Conferma"},
  TipsType_20006_Title = {
    Text = "Sincronizzazione Fallita"
  },
  TipsType_20007_Desc = {
    Text = "Sincronizzazione persa, ritorno alla schermata di accesso a breve."
  },
  TipsType_20007_RightBtnDesc = {Text = "Conferma"},
  TipsType_20007_Title = {
    Text = "Sincronizzazione Fallita"
  },
  TipsType_20008_Desc = {
    Text = "Questa indagine costa <Positive:{s1}> Stamina. Sei sicuro di volerla terminare?"
  },
  TipsType_20008_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20008_RightBtnDesc = {Text = "Conferma"},
  TipsType_20008_Title = {
    Text = "Termina Esplorazione"
  },
  TipsType_20009_Desc = {
    Text = "L'Aggiornamento modificherà Orazioni e Reliquie. I Risvegli dei Risvegliati e il conteggio delle vendite delle Carte di comando non verranno reimpostati. Confermi?"
  },
  TipsType_20009_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20009_RightBtnDesc = {Text = "Conferma"},
  TipsType_20009_Title = {
    Text = "Conferma Aggiornamento"
  },
  TipsType_20010_Desc = {
    Text = "Il numero di Risvegliati in questo Reame è insufficiente. Vuoi continuare a creare la squadra?"
  },
  TipsType_20010_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20010_RightBtnDesc = {Text = "Conferma"},
  TipsType_20011_Desc = {
    Text = "Nessun Risvegliato selezionato, la formazione non verrà conservata."
  },
  TipsType_20011_LeftBtnDesc = {
    Text = "Conferma uscita"
  },
  TipsType_20011_RightBtnDesc = {
    Text = "Continua formazione"
  },
  TipsType_20012_Desc = {
    Text = "Nessun Risveglio Selezionato"
  },
  TipsType_20012_RightBtnDesc = {Text = "Conferma"},
  TipsType_20013_Desc = {
    Text = "Formazione incompleta. Iniziare comunque?"
  },
  TipsType_20013_LeftBtnDesc = {Text = "Ritorno"},
  TipsType_20013_RightBtnDesc = {Text = "Parti"},
  TipsType_20014_Desc = {
    Text = "Il limite della squadra è stato raggiunto."
  },
  TipsType_20014_RightBtnDesc = {Text = "Conferma"},
  TipsType_20015_Desc = {
    Text = "Eliminare questa squadra?"
  },
  TipsType_20015_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20015_RightBtnDesc = {Text = "Conferma"},
  TipsType_20016_Desc = {
    Text = "{s1} Sbloccato dopo il Completamento"
  },
  TipsType_20016_RightBtnDesc = {Text = "Conferma"},
  TipsType_20017_Desc = {
    Text = "Qui puoi visualizzare le informazioni sulla mappa e sui mostri sconfitti. Questa funzione non è ancora disponibile nella versione attuale."
  },
  TipsType_20017_RightBtnDesc = {Text = "Conferma"},
  TipsType_20018_Desc = {
    Text = "Condizioni di sblocco del Livello non ancora soddisfatte"
  },
  TipsType_20018_RightBtnDesc = {Text = "Conferma"},
  TipsType_20018_Title = {
    Text = "Sondaggio Rapido"
  },
  TipsType_20019_Desc = {
    Text = "\"Argento\" insufficiente. Vuoi andare al negozio per acquistarne di più?"
  },
  TipsType_20019_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20019_RightBtnDesc = {Text = "Procedi"},
  TipsType_20020_Desc = {
    Text = "Sblocca questa difficoltà avanzata dopo aver completato Avanzato {s1}."
  },
  TipsType_20020_RightBtnDesc = {Text = "Conferma"},
  TipsType_20021_Desc = {
    Text = "{s1} Addestramento Avanzato sbloccato dopo il Completamento della Modalità Normale."
  },
  TipsType_20021_RightBtnDesc = {Text = "Conferma"},
  TipsType_20022_Desc = {
    Text = "\"Argento\" insufficiente. Vuoi procedere all'acquisto?"
  },
  TipsType_20022_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20022_RightBtnDesc = {Text = "Conferma"},
  TipsType_20022_Title = {
    Text = "Argento insufficiente"
  },
  TipsType_20023_Desc = {
    Text = "Questo Potenziamento comporterà uno Spreco di {s1} EXP (non rimborsabile), e i personaggi non potranno ottenere EXP dopo aver raggiunto il limite di Livello. Desideri continuare?"
  },
  TipsType_20023_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20023_RightBtnDesc = {Text = "Conferma"},
  TipsType_20024_Desc = {
    Text = "Il gruppo non è al completo e non può accedere all'istanza."
  },
  TipsType_20024_RightBtnDesc = {Text = "Conferma"},
  TipsType_20026_Desc = {
    Text = "Confermi la Ricarica Aliemus?"
  },
  TipsType_20026_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20026_RightBtnDesc = {Text = "Conferma"},
  TipsType_20027_Desc = {
    Text = "Confermi il ripristino dei HP?"
  },
  TipsType_20027_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20027_RightBtnDesc = {Text = "Conferma"},
  TipsType_20028_Desc = {
    Text = "Chiudendo questa finestra perderai [{s1}]. Vuoi procedere comunque?"
  },
  TipsType_20028_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20028_RightBtnDesc = {Text = "Conferma"},
  TipsType_20029_Desc = {
    Text = "Chiudendo questa schermata salterai l'evento corrente (la Reliquia non verrà rimossa). Confermi?"
  },
  TipsType_20029_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20029_RightBtnDesc = {Text = "Conferma"},
  TipsType_20030_Desc = {
    Text = "Le Reliquie selezionate non verranno trasferite. Abbandonare l'Eredità?"
  },
  TipsType_20030_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20030_RightBtnDesc = {Text = "Conferma"},
  TipsType_20031_Desc = {
    Text = "Uscire dalla Battaglia?"
  },
  TipsType_20031_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20031_RightBtnDesc = {Text = "Conferma"},
  TipsType_20032_Desc = {
    Text = "Il livello attuale non è ancora sbloccato. Desideri sbloccarlo completando il Livello Custode?"
  },
  TipsType_20032_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20032_RightBtnDesc = {Text = "Conferma"},
  TipsType_20032_Title = {
    Text = "Non Sbloccato"
  },
  TipsType_20033_Desc = {
    Text = "I tentativi di sfida sono insufficienti. Spendere 500 Argento per ripristinarli?"
  },
  TipsType_20033_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20033_RightBtnDesc = {Text = "Conferma"},
  TipsType_20034_Desc = {
    Text = "La sfida attuale è in fase di ricarica. Vuoi spendere \"Argento\" × 50 per ripristinarla?"
  },
  TipsType_20034_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20034_RightBtnDesc = {Text = "Conferma"},
  TipsType_20035_Desc = {
    Text = "Il Livello raccomandato è {s1}, e il Livello medio della squadra attuale è {s2}. L'Indagine incontrerà degli ostacoli. Desideri continuare?"
  },
  TipsType_20035_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20035_RightBtnDesc = {Text = "Conferma"},
  TipsType_20035_Title = {
    Text = "Forza Insufficiente"
  },
  TipsType_20036_Desc = {
    Text = "Il conteggio attuale di Spazzate è impostato su {s1}, ma affrontare il dungeon consumerà solo {s2} stamina per ottenere 1 ricompensa. Desideri procedere?"
  },
  TipsType_20036_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20036_RightBtnDesc = {Text = "Conferma"},
  TipsType_20036_Title = {
    Text = "Conferma Sfida"
  },
  TipsType_20037_Desc = {
    Text = "I materiali di potenziamento includono materiali di avanzamento. Sei sicuro di voler procedere con il potenziamento?"
  },
  TipsType_20037_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20037_RightBtnDesc = {Text = "Conferma"},
  TipsType_20037_Title = {
    Text = "Conferma Potenziamento"
  },
  TipsType_20038_Desc = {
    Text = "Questo equipaggiamento è attualmente bloccato. Desideri sbloccarlo?"
  },
  TipsType_20038_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20038_RightBtnDesc = {Text = "Conferma"},
  TipsType_20039_Desc = {
    Text = "L'Indagine fallirà e tutte le ricompense successive andranno perdute. Vuoi procedere comunque?"
  },
  TipsType_20039_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20039_RightBtnDesc = {Text = "Conferma"},
  TipsType_20039_Title = {Text = "Esci"},
  TipsType_20040_Desc = {
    Text = "<WeaponEffect_Num:Ritirarsi ora ti costerà {s1} Menofina.> L'Indagine fallirà e tutte le ricompense successive andranno perdute. Vuoi procedere comunque?"
  },
  TipsType_20040_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20040_RightBtnDesc = {Text = "Conferma"},
  TipsType_20040_Title = {Text = "Esci"},
  TipsType_20041_BottomDesc = {
    Text = "Permessi di compressione temporale posseduti: {s1}"
  },
  TipsType_20041_Desc = {
    Text = "Consumare {s1} Permessi di compressione temporale per accelerare?"
  },
  TipsType_20041_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20041_RightBtnDesc = {Text = "Conferma"},
  TipsType_20041_Title = {
    Text = "Conferma accelerazione"
  },
  TipsType_20042_Desc = {
    Text = "Regolazione del combattimento RPG in corso, attualmente si conclude con una vittoria diretta"
  },
  TipsType_20042_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20042_RightBtnDesc = {Text = "Conferma"},
  TipsType_20043_Desc = {
    Text = "Spendere {s1} Argento per aggiornare la missione attuale?"
  },
  TipsType_20043_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20043_RightBtnDesc = {Text = "Conferma"},
  TipsType_20043_Title = {
    Text = "Aggiornamento missione"
  },
  TipsType_20044_BottomDesc = {
    Text = "Consumo: {s1} permessi di ricerca"
  },
  TipsType_20044_Desc = {
    Text = [[
Condurre una ricerca su {s1}?
Effetto della Ricerca: {s2}]]
  },
  TipsType_20044_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20044_RightBtnDesc = {Text = "Conferma"},
  TipsType_20044_Title = {
    Text = "Conferma ricerca"
  },
  TipsType_20045_BottomDesc = {
    Text = "Annullare la Ricerca non conserverà i progressi già effettuati."
  },
  TipsType_20045_Desc = {
    Text = "Annullare la Ricerca su {s1}? (I permessi di Ricerca verranno rimborsati integralmente.)"
  },
  TipsType_20045_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20045_RightBtnDesc = {Text = "Conferma"},
  TipsType_20045_Title = {
    Text = "Annulla ricerca"
  },
  TipsType_20046_Desc = {
    Text = "Consumare {s1} \"Argento\" per accelerare?"
  },
  TipsType_20046_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20046_RightBtnDesc = {Text = "Conferma"},
  TipsType_20046_Title = {
    Text = "Conferma accelerazione"
  },
  TipsType_20047_Desc = {
    Text = "Mancano {s1} <Blue:\"{s2}\">, consumare <Blue:\"Argento\"×{s3}> per acquistarli?"
  },
  TipsType_20047_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20047_RightBtnDesc = {Text = "Conferma"},
  TipsType_20047_Title = {
    Text = "Conferma acquisto"
  },
  TipsType_20048_Desc = {
    Text = "Mancano {s1} <Blue:\"{s2}\">, consumare <Blue:\"Argento\"×{s3}> per acquistarli?"
  },
  TipsType_20048_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20048_RightBtnDesc = {Text = "Conferma"},
  TipsType_20048_Title = {
    Text = "Conferma acquisto"
  },
  TipsType_20049_Desc = {
    Text = "<Blue:\"{s1}\"> è già equipaggiato da <Blue:\"{s2}\">. Confermi la sostituzione?"
  },
  TipsType_20049_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20049_RightBtnDesc = {Text = "Conferma"},
  TipsType_20049_Title = {
    Text = "Cambia suggerimento"
  },
  TipsType_20050_Desc = {
    Text = "La Ruota del destino che stai utilizzando è stata sottoposta ad Ascensione. Continuare?"
  },
  TipsType_20050_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20050_RightBtnDesc = {Text = "Conferma"},
  TipsType_20050_Title = {Text = "Avviso"},
  TipsType_20051_Desc = {
    Text = "Il grado di Ascensione supererà il limite massimo. Le Ascensioni in eccesso verranno rimborsate di conseguenza. Continuare?"
  },
  TipsType_20051_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20051_RightBtnDesc = {Text = "Conferma"},
  TipsType_20051_Title = {Text = "Avviso"},
  TipsType_20052_Desc = {
    Text = "Il Livello raccomandato è {s1}, il Livello medio della squadra attuale è {s2}. L'Indagine incontrerà ostacoli significativi. Procedere comunque?"
  },
  TipsType_20052_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20052_RightBtnDesc = {Text = "Conferma"},
  TipsType_20052_Title = {
    Text = "Forza Insufficiente"
  },
  TipsType_20053_Desc = {
    Text = "Il Livello raccomandato è {s1}, il Livello medio della squadra attuale è {s2}. L'Indagine incontrerà ostacoli estremi. Procedere comunque?"
  },
  TipsType_20053_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20053_RightBtnDesc = {Text = "Conferma"},
  TipsType_20053_Title = {
    Text = "Forza Insufficiente"
  },
  TipsType_20054_Desc = {
    Text = "Tutte le ricompense della sfida sono state riscattate. Continuare la sfida non garantirà alcuna ricompensa aggiuntiva. Procedere comunque?"
  },
  TipsType_20054_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20054_RightBtnDesc = {Text = "Conferma"},
  TipsType_20054_Title = {
    Text = "Conferma Sfida"
  },
  TipsType_20055_Desc = {
    Text = "Il ripristino cancellerà tutte le Stelle ottenute per questo Livello e azzererà i registri di Battaglia dei Risvegliati. Confermi il ripristino?"
  },
  TipsType_20055_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20055_RightBtnDesc = {Text = "Conferma"},
  TipsType_20055_Title = {
    Text = "Conferma ripristino"
  },
  TipsType_20056_Desc = {
    Text = "In caso di vittoria, i 4 Risvegliati nella formazione attuale non potranno partecipare ad altri Livelli di {s1}. Confermi la sfida?"
  },
  TipsType_20056_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20056_RightBtnDesc = {Text = "Conferma"},
  TipsType_20056_Title = {
    Text = "Conferma Sfida"
  },
  TipsType_20057_Desc = {
    Text = "La composizione della squadra non rispetta le linee guida raccomandate nel Manuale dell'Accademia. Desideri comunque procedere con la sfida?"
  },
  TipsType_20057_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20057_RightBtnDesc = {Text = "Conferma"},
  TipsType_20057_Title = {
    Text = "Conferma formazione"
  },
  TipsType_20058_Desc = {
    Text = "Il Livello attuale è stato completato con successo. Per affrontarlo di nuovo, è necessario ripristinare i progressi del Livello corrente a 0 Stelle. Anche i registri di Battaglia dei Risvegliati verranno azzerati. Confermi il ripristino?"
  },
  TipsType_20058_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20058_RightBtnDesc = {Text = "Conferma"},
  TipsType_20058_Title = {
    Text = "Conferma ripristino"
  },
  TipsType_20059_Desc = {
    Text = "La squadra attuale non dispone di 4 Risvegliati e non può entrare in Battaglia."
  },
  TipsType_20059_Title = {
    Text = "Salva formazione"
  },
  TipsType_20060_BottomDesc = {
    Text = "Dopo la conferma, non potrai più effettuare un nuovo Risveglio."
  },
  TipsType_20060_Desc = {
    Text = "Confermi la selezione di questo risultato di Risveglio? (otterrai tutti i Risvegliati e le Ruote del Destino da questo Risveglio)?"
  },
  TipsType_20060_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20060_RightBtnDesc = {Text = "Conferma"},
  TipsType_20060_Title = {
    Text = "Conferma selezione"
  },
  TipsType_20061_BottomDesc = {
    Text = "Argento attuale: {s1}"
  },
  TipsType_20061_Desc = {
    Text = "Spendere {s1} \"Argento\" per effettuare un nuovo Risveglio?\nUn nuovo Risveglio non conserverà i risultati attuali del Mazzo di Pesca."
  },
  TipsType_20061_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20061_RightBtnDesc = {Text = "Conferma"},
  TipsType_20061_Title = {Text = "Risveglio"},
  TipsType_20062_Desc = {
    Text = "Eliminare tutta la posta letta?\nLa posta con allegati non riscattati non verrà eliminata."
  },
  TipsType_20062_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20062_RightBtnDesc = {Text = "Conferma"},
  TipsType_20062_Title = {
    Text = "Elimina letti"
  },
  TipsType_20063_Desc = {
    Text = "Confermi l'eliminazione?"
  },
  TipsType_20063_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20063_RightBtnDesc = {Text = "Conferma"},
  TipsType_20063_Title = {
    Text = "Elimina posta corrente"
  },
  TipsType_20064_Desc = {
    Text = "La posta eliminata dalla Scatola dei Ricordi non può essere recuperata.\nEliminare questa posta?"
  },
  TipsType_20064_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20064_RightBtnDesc = {Text = "Conferma"},
  TipsType_20064_Title = {
    Text = "Elimina lettere"
  },
  TipsType_20065_Desc = {
    Text = "Confermi di voler consumare <Blue:{s1}> per fabbricare <Blue:{s2}>?"
  },
  TipsType_20065_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20065_RightBtnDesc = {Text = "Conferma"},
  TipsType_20065_Title = {
    Text = "Conferma sintesi"
  },
  TipsType_20066_Desc = {
    Text = "Confermi di smantellare <Blue:{s1} per ricevere {s2}>?"
  },
  TipsType_20066_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20066_RightBtnDesc = {Text = "Conferma"},
  TipsType_20066_Title = {
    Text = "Conferma smantellamento"
  },
  TipsType_20067_Desc = {
    Text = "Confermi di voler consumare <Blue:{s1}> Patto/i SSR per ristampare <Blue:{s2}> <Blue:{s3}>?"
  },
  TipsType_20067_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20067_RightBtnDesc = {Text = "Conferma"},
  TipsType_20067_Title = {
    Text = "Conferma ri-Orazione"
  },
  TipsType_20068_Desc = {
    Text = [[
Tutti i Risvegliati sono stati sconfitti.

Oh solitario Custode,
Cosa sceglierai ora?]]
  },
  TipsType_20068_LeftBtnDesc = {
    Text = "Ritenta Battaglia"
  },
  TipsType_20068_RightBtnDesc = {
    Text = "Ritirata Temporanea"
  },
  TipsType_20068_Title = {
    Text = "Indagine fallita"
  },
  TipsType_20069_Desc = {
    Text = "L'Aliemus del Risveglio attualmente selezionato è al massimo. Sei sicuro di voler comunque selezionare questo Risveglio?"
  },
  TipsType_20069_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20069_RightBtnDesc = {Text = "Conferma"},
  TipsType_20069_Title = {
    Text = "Conferma selezione"
  },
  TipsType_20070_Desc = {
    Text = "Sei sicuro di voler utilizzare {s1}?\nI livelli e le abilità già potenziati sul Risveglio non verranno rimborsati."
  },
  TipsType_20070_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20070_RightBtnDesc = {Text = "Conferma"},
  TipsType_20070_Title = {
    Text = "Conferma potenziamento"
  },
  TipsType_20071_Desc = {
    Text = "A causa dei limiti del Livello Custode, il livello del Risvegliato verrà potenziato a {s1}. I materiali di potenziamento mancanti dall'Inventario non saranno rimborsati. Procedere?"
  },
  TipsType_20071_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20071_RightBtnDesc = {Text = "Conferma"},
  TipsType_20071_Title = {
    Text = "Conferma potenziamento"
  },
  TipsType_20072_Desc = {
    Text = [[
"Saltare tutta la Storia in questa sezione?
Nota: Potrai rientrare in questo Livello in seguito per guardare la Storia."]]
  },
  TipsType_20072_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20072_RightBtnDesc = {Text = "Conferma"},
  TipsType_20072_Title = {
    Text = "Salta Storia"
  },
  TipsType_20073_Desc = {
    Text = "Confermi lo smantellamento di {s1} per ottenere {s2}?\n(Il Patto attuale è stato potenziato; smantellandolo non verranno restituiti gli oggetti di potenziamento.)"
  },
  TipsType_20073_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20073_RightBtnDesc = {Text = "Conferma"},
  TipsType_20073_Title = {
    Text = "Conferma smantellamento"
  },
  TipsType_20074_Desc = {
    Text = "Confermi lo smantellamento di {s1} per ottenere {s2}?\n(La Ruota del destino selezionata è di alta rarità.)"
  },
  TipsType_20074_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20074_RightBtnDesc = {Text = "Conferma"},
  TipsType_20074_Title = {
    Text = "Conferma smantellamento"
  },
  TipsType_20075_BottomDesc = {
    Text = "Consumo: {s1} permessi di ricerca"
  },
  TipsType_20075_Desc = {
    Text = "Avviare la Ricerca su {s1}?\nEfficienza di produzione: {s2} Buoni Rosa/Ogni 6 ore\n     —>{s3} Buoni Rosa/Ogni 6 ore"
  },
  TipsType_20075_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20075_RightBtnDesc = {Text = "Conferma"},
  TipsType_20075_Title = {
    Text = "Conferma ricerca"
  },
  TipsType_20076_BottomDesc = {
    Text = "Consumo: {s1} permessi di ricerca"
  },
  TipsType_20076_Desc = {
    Text = "Avviare la Ricerca su {s1}?\nEfficienza di produzione: {s2} Elisir di Gnosi/6 ore\n     —>{s3} Elisir di Gnosi/6 ore"
  },
  TipsType_20076_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20076_RightBtnDesc = {Text = "Conferma"},
  TipsType_20076_Title = {
    Text = "Conferma ricerca"
  },
  TipsType_20077_BottomDesc = {
    Text = "Consumo: {s1} permessi di ricerca"
  },
  TipsType_20077_Desc = {
    Text = "Avviare la Ricerca su {s1}?\nEfficienza di produzione: {s2} Tracce del Patto/6 ore\n     —>{s3} Tracce del Patto/6 ore"
  },
  TipsType_20077_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20077_RightBtnDesc = {Text = "Conferma"},
  TipsType_20077_Title = {
    Text = "Conferma ricerca"
  },
  TipsType_20078_Desc = {
    Text = [[
"Saltare tutta la Storia in questa sezione?
Nota: Potrai rientrare in questo Livello in seguito per guardare la Storia."]]
  },
  TipsType_20078_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20078_RightBtnDesc = {Text = "Conferma"},
  TipsType_20078_Title = {
    Text = "Salta Storia"
  },
  TipsType_20079_Desc = {
    Text = "La Chiave d'argento percepisce una crisi fatale. Attivare il Corpo di Gnosi d'Emergenza?\n(La Rinascita consumerà 1 Corpo di Gnosi d'Emergenza. Ne ricevi 1 al giorno alle 9:00. Utilizzi rimanenti: {s1}/{s2})"
  },
  TipsType_20079_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20079_RightBtnDesc = {Text = "Conferma"},
  TipsType_20079_Title = {
    Text = "Rianimazione immediata?"
  },
  TipsType_20080_Desc = {
    Text = "La Chiave d'argento percepisce una crisi fatale. Attivare il Corpo di Gnosi d'Emergenza?\n(La Rinascita consumerà 1 Corpo di Gnosi d'Emergenza. Ne ricevi 1 al giorno alle 9:00. Utilizzi rimanenti: {s1}/{s2})"
  },
  TipsType_20080_RightBtnDesc = {Text = "Conferma"},
  TipsType_20080_Title = {
    Text = "Rianimazione immediata?"
  },
  TipsType_20081_Desc = {
    Text = "Inizializzazione del gioco fallita. {s1}."
  },
  TipsType_20081_RightBtnDesc = {Text = "Conferma"},
  TipsType_20081_Title = {
    Text = "Suggerimento errore di accesso"
  },
  TipsType_20082_Desc = {
    Text = "Vuoi consumare <Blue:\"Argento\" × {s1} > per acquistare <Blue: {s2} > livelli?"
  },
  TipsType_20082_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20082_RightBtnDesc = {Text = "Conferma"},
  TipsType_20082_Title = {
    Text = "Aumento di Livello"
  },
  TipsType_20083_Desc = {
    Text = "Consuma la Ruota del destino {s1}. Confermi il potenziamento?"
  },
  TipsType_20083_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20083_RightBtnDesc = {Text = "Conferma"},
  TipsType_20083_Title = {Text = "Conferma"},
  TipsType_20084_Desc = {
    Text = "Il livello medio della tua squadra è troppo basso per questo livello. L'indagine potrebbe incontrare difficoltà significative. Vuoi procedere comunque?"
  },
  TipsType_20084_LeftBtnDesc = {
    Text = "Potenzia Risvegliatori"
  },
  TipsType_20084_RightBtnDesc = {Text = "Conferma"},
  TipsType_20084_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20085_Desc = {
    Text = "Conferma uscita"
  },
  TipsType_20085_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20085_RightBtnDesc = {Text = "Conferma"},
  TipsType_20085_Title = {
    Text = "Esci dal Gioco"
  },
  TipsType_20086_Desc = {
    Text = "Server in manutenzione"
  },
  TipsType_20086_RightBtnDesc = {Text = "Conferma"},
  TipsType_20086_Title = {
    Text = "Suggerimento Disconnessione"
  },
  TipsType_20087_Desc = {
    Text = "Confermi il consumo di <TipsHighlightText:{s1} × {s2}> per sbloccare <TipsHighlightText:{s3}>?"
  },
  TipsType_20087_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20087_RightBtnDesc = {Text = "Conferma"},
  TipsType_20087_Title = {
    Text = "Conferma attivazione"
  },
  TipsType_20088_Desc = {
    Text = "Dopo la riscossione, la \"Menofina\" traboccherà e qualsiasi quantità eccedente {s1} non potrà essere ottenuta.\nDesideri continuare a riscuotere?"
  },
  TipsType_20088_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20088_RightBtnDesc = {Text = "Conferma"},
  TipsType_20088_Title = {
    Text = "Traboccamento di Menofina"
  },
  TipsType_20089_Desc = {
    Text = "Spendi <Blue:{s1}> Scrip di Rosa per aggiornare l'inventario\nAggiornamenti rimanenti: <Blue:{s2}>\nPiù aggiornamenti vengono effettuati, maggiore sarà il numero di Scrip di Rosa richiesti."
  },
  TipsType_20089_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20089_RightBtnDesc = {Text = "Conferma"},
  TipsType_20089_Title = {
    Text = "Aggiorna scorte"
  },
  TipsType_20090_Desc = {
    Text = "Il numero di Ruote del destino ha raggiunto il limite. È necessario eliminarne alcune prima di poter effettuare il Risveglio. Vuoi procedere?\n\n<color=#ADC0CB>*Puoi impostare lo smantellamento automatico delle Ruote del destino di grado SR/R nelle \"Impostazioni.\"</color>"
  },
  TipsType_20090_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20090_RightBtnDesc = {
    Text = "Completa ora"
  },
  TipsType_20090_Title = {
    Text = "Suggerimento pulizia"
  },
  TipsType_20091_Desc = {
    Text = "Il limite di Patti è stato raggiunto. È necessario eliminare alcuni Patti prima di indagare. Procedere?"
  },
  TipsType_20091_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20091_RightBtnDesc = {
    Text = "Completa ora"
  },
  TipsType_20091_Title = {
    Text = "Suggerimento pulizia"
  },
  TipsType_20092_Desc = {
    Text = "Vuoi davvero rimuovere tutte le Ruote del destino dall'equipaggiamento del Risvegliatore attuale?"
  },
  TipsType_20092_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20092_RightBtnDesc = {Text = "Conferma"},
  TipsType_20092_Title = {
    Text = "Conferma rimozione"
  },
  TipsType_20093_Desc = {
    Text = "Il Patto da consumare è stato potenziato. Confermare?"
  },
  TipsType_20093_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20093_RightBtnDesc = {Text = "Conferma"},
  TipsType_20093_Title = {
    Text = "Conferma potenziamento"
  },
  TipsType_20094_Desc = {
    Text = "Questo Patto ha una Sotto-statistica a Valore Massimo che non è stata bloccata. Se continui, verrà sovrascritta."
  },
  TipsType_20094_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20094_RightBtnDesc = {Text = "Conferma"},
  TipsType_20094_Title = {
    Text = "Sostituire le Sottostats?"
  },
  TipsType_20095_Desc = {
    Text = "C'è una Sotto-statistica a Valore Massimo in sospeso. Se continui la Trascrizione, andrà perduta."
  },
  TipsType_20095_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20095_RightBtnDesc = {Text = "Conferma"},
  TipsType_20095_Title = {
    Text = "Continuare la trascrizione?"
  },
  TipsType_20096_Desc = {
    Text = "Il potenziamento di questo Patto supererà il limite di livello. L'eccedenza verrà rimborsata in materiali di trascrizione. Confermare?"
  },
  TipsType_20096_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20096_RightBtnDesc = {Text = "Conferma"},
  TipsType_20096_Title = {
    Text = "Conferma potenziamento"
  },
  TipsType_20097_Desc = {
    Text = "Questo Risvegliatore ha raggiunto la massima Illuminazione.\nDopo la selezione, riceverai soltanto \"Frammento di Gnosi\" × 3 e \"Frammento di Gnosi Raffinata\" ×1"
  },
  TipsType_20097_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20097_RightBtnDesc = {Text = "Continua"},
  TipsType_20097_Title = {
    Text = "Conferma selezione"
  },
  TipsType_20098_Desc = {
    Text = "Questo oggetto può essere acquistato utilizzando <Blue:{s1}> Certificati di Scambio in Mithril"
  },
  TipsType_20098_LeftBtnDesc = {
    Text = "Pagamento in contanti"
  },
  TipsType_20098_RightBtnDesc = {
    Text = "Pagamento con voucher"
  },
  TipsType_20098_Title = {
    Text = "Metodo di insediamento"
  },
  TipsType_20099_Desc = {
    Text = "Uscire dal gioco?"
  },
  TipsType_20099_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20099_RightBtnDesc = {Text = "Conferma"},
  TipsType_20099_Title = {
    Text = "Indagine in corso"
  },
  TipsType_20100_Desc = {
    Text = "È stata rilevata una nuova versione del gioco. Riavvia il gioco per aggiornare le risorse."
  },
  TipsType_20100_RightBtnDesc = {Text = "Conferma"},
  TipsType_20100_Title = {
    Text = "Suggerimento aggiornamento"
  },
  TipsType_20101_Desc = {
    Text = "L'indagine è completa. Desideri saltare la storia?"
  },
  TipsType_20101_LeftBtnDesc = {
    Text = "Salta Storia"
  },
  TipsType_20101_RightBtnDesc = {
    Text = "Leggi la Storia"
  },
  TipsType_20101_Title = {
    Text = "Conferma storia"
  },
  TipsType_20102_Desc = {
    Text = "Vuoi davvero smettere di seguire {s1}?"
  },
  TipsType_20102_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20102_RightBtnDesc = {Text = "Conferma"},
  TipsType_20102_Title = {
    Text = "Smetti di seguire"
  },
  TipsType_20103_Desc = {
    Text = "Sblocca <WeaponEffect_Num:gratuitamente per un tempo limitato> durante l'evento. Vuoi procedere allo sblocco?"
  },
  TipsType_20103_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20103_RightBtnDesc = {Text = "Conferma"},
  TipsType_20103_Title = {
    Text = "Beni evento"
  },
  TipsType_20105_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_20105_LeftBtnDesc = {Text = "Esci"},
  TipsType_20105_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_20105_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20106_Desc = {
    Text = "Consumare <Blue:\"Essenza di Silver Core\" ×  {s1} > per acquistare?"
  },
  TipsType_20106_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20106_RightBtnDesc = {Text = "Acquista"},
  TipsType_20106_Title = {
    Text = "Conferma acquisto"
  },
  TipsType_20107_Desc = {
    Text = "Sei sicuro di voler selezionare <Blue:{s1}>?"
  },
  TipsType_20107_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20107_RightBtnDesc = {Text = "Conferma"},
  TipsType_20107_Title = {
    Text = "Conferma selezione"
  },
  TipsType_20108_Desc = {
    Text = [[
Questa azione consuma l'oggetto raro "Copia del Ciclo Temporale"
Continuare?]]
  },
  TipsType_20108_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20108_RightBtnDesc = {Text = "Conferma"},
  TipsType_20108_Title = {Text = "Conferma"},
  TipsType_20109_Desc = {
    Text = "Sei sicuro di voler ricominciare questa battaglia?"
  },
  TipsType_20109_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20109_RightBtnDesc = {Text = "Conferma"},
  TipsType_20109_Title = {
    Text = "Ritenta Battaglia"
  },
  TipsType_20110_Desc = {
    Text = "Impostare la data di nascita su {s1}/{s2}?\nNon sarà possibile modificarla."
  },
  TipsType_20110_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20110_RightBtnDesc = {Text = "Conferma"},
  TipsType_20110_Title = {
    Text = "Conferma compleanno"
  },
  TipsType_20111_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_20111_LeftBtnDesc = {Text = "Esci"},
  TipsType_20111_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_20111_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20112_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_20112_LeftBtnDesc = {Text = "Esci"},
  TipsType_20112_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_20112_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20113_Desc = {
    Text = "Contrassegnare tutti i tutorial sbloccati come letti e riscuotere le ricompense? (Ai nuovi Custodi si consiglia di consultare prima i tutorial~)"
  },
  TipsType_20113_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20113_RightBtnDesc = {Text = "Conferma"},
  TipsType_20113_Title = {
    Text = "Conferma lettura completa"
  },
  TipsType_20114_Desc = {
    Text = "Confermi la selezione di <WeaponEffect_Num:{s1}> per attivare il Ripristino?\nQuesta azione è irreversibile. Conferma con attenzione."
  },
  TipsType_20114_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20114_RightBtnDesc = {Text = "Conferma"},
  TipsType_20114_Title = {
    Text = "Ripristina selezione"
  },
  TipsType_201151_Desc = {
    Text = "Il Risvegliato attuale è a Livello Illuminazione 0. Non è necessario il Reset dell'Illuminazione."
  },
  TipsType_20115_Desc = {
    Text = "L'Awakener attuale non ha subito alcuno sviluppo, pertanto non è necessario alcun Ripristino dello Sviluppo."
  },
  TipsType_20116_Desc = {
    Text = "Il Ripristino di <WeaponEffect_Num:{s1}> è stato attivato.\nDesideri procedere con il Ripristino adesso?"
  },
  TipsType_20116_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20116_RightBtnDesc = {Text = "Procedi"},
  TipsType_20116_Title = {
    Text = "Sblocco riuscito"
  },
  TipsType_20117_Desc = {
    Text = "Ripristino del Livello, dell'Edificazione, delle Abilità, dei Talenti e dello stato di Avanzamento Gnostico del Risvegliato. Tutti i Materiali consumati verranno restituiti.\nConfermi il Ripristino dello Sviluppo per <WeaponEffect_Num:{s1}>?"
  },
  TipsType_20117_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20117_RightBtnDesc = {Text = "Conferma"},
  TipsType_20117_Title = {
    Text = "Ripristino dello Sviluppo"
  },
  TipsType_20118_Desc = {
    Text = [[
Ripristino dello stato di Illuminazione del Risvegliato e rimborso dei costi di Illuminazione.
Confermi il Reset dell'Illuminazione <WeaponEffect_Num:{s1}>?]]
  },
  TipsType_20118_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20118_RightBtnDesc = {Text = "Conferma"},
  TipsType_20118_Title = {
    Text = "Reset dell'Illuminazione"
  },
  TipsType_20119_Desc = {
    Text = "Ripristino del Livello, dell'Edificazione, delle Abilità, dei Talenti, dell'Illuminazione e dello stato di Avanzamento Gnostico del Risvegliato. Questo Risvegliato verrà restituito al Pozzo Oscuro.\nConfermi il Ritorno alla Genesi per <WeaponEffect_Num:{s1}>?"
  },
  TipsType_20119_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20119_RightBtnDesc = {Text = "Conferma"},
  TipsType_20119_Title = {
    Text = "Ritorno alla Genesi"
  },
  TipsType_20120_Desc = {
    Text = "I Risvegliatori speciali non possono essere ripristinati."
  },
  TipsType_20121_Desc = {
    Text = "Stai per ripristinare lo stato di Ascensione e rimborsare tutti i costi. Confermi il ripristino per <WeaponEffect_Num:{s1}>?"
  },
  TipsType_20121_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20121_RightBtnDesc = {Text = "Conferma"},
  TipsType_20121_Title = {
    Text = "Stack Traceback"
  },
  TipsType_20122_Desc = {
    Text = [[
Stai per ripristinare lo stato di Ascensione, rimborsare tutti i costi e restituire la Ruota del destino al Pool della Genesi.
Confermi il Ritorno alla Genesi per <WeaponEffect_Num:{s1}>?]]
  },
  TipsType_20122_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20122_RightBtnDesc = {Text = "Conferma"},
  TipsType_20122_Title = {
    Text = "Ritorno alla Genesi"
  },
  TipsType_20123_Desc = {
    Text = "Dopo aver completato la sfida, i Risvegliatori, le Ruote del destino e la Posse nella squadra non potranno partecipare ad altre Zone D-Effetto Regionali. Confermare?"
  },
  TipsType_20123_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20123_RightBtnDesc = {Text = "Conferma"},
  TipsType_20123_Title = {
    Text = "Conferma Sfida"
  },
  TipsType_20124_Desc = {
    Text = "Dopo il ripristino, i Risvegliatori, la Ruota del destino e le Chiavi nella squadra d'Indagine potranno essere rischierati, ma il Valore di Addestramento ottenuto da questo livello verrà detratto."
  },
  TipsType_20124_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20124_RightBtnDesc = {Text = "Conferma"},
  TipsType_20124_Title = {
    Text = "Conferma ripristino"
  },
  TipsType_20125_Desc = {
    Text = "Il livello di Ascensione della Ruota del destino attuale è 0, non è necessario alcun ripristino dell'Ascensione."
  },
  TipsType_20126_Desc = {
    Text = "Il Risveglio attuale è impegnato in un Incarico. Richiamalo prima di resettare o tornare indietro."
  },
  TipsType_20127_Desc = {
    Text = "La Ruota del destino attuale è bloccata. Sbloccala prima di procedere al ripristino."
  },
  TipsType_20128_Desc = {
    Text = "{s1} completato. Ripristinare per riprovare?\n(Dopo il ripristino, i Risvegliatori, la Ruota del destino e le Chiavi nella squadra d'Indagine potranno essere rischierati, ma il Valore di Addestramento ottenuto da questo livello verrà detratto.)"
  },
  TipsType_20128_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20128_RightBtnDesc = {Text = "Conferma"},
  TipsType_20128_Title = {
    Text = "Conferma ripristino"
  },
  TipsType_20129_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_20129_LeftBtnDesc = {Text = "Esci"},
  TipsType_20129_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_20129_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20130_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_20130_LeftBtnDesc = {Text = "Esci"},
  TipsType_20130_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_20130_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20131_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_20131_LeftBtnDesc = {Text = "Esci"},
  TipsType_20131_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_20131_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20132_Desc = {
    Text = "Se sono disponibili sufficienti <TipsHighlightText:Frammenti di Patto>, verranno utilizzati per primi.\nSe la quantità è insufficiente, verrà consumato <TipsHighlightText:\"{s1}\"> al loro posto."
  },
  TipsType_20132_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20132_RightBtnDesc = {Text = "Conferma"},
  TipsType_20132_Title = {
    Text = "Sostituzione automatica"
  },
  TipsType_20133_Desc = {
    Text = "Eseguire l'Avanzamento Gnostico su <TipsHighlightText:\"{s1}\">?"
  },
  TipsType_20133_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20133_RightBtnDesc = {Text = "Conferma"},
  TipsType_20133_Title = {
    Text = "Avanzamento Gnostico"
  },
  TipsType_20134_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_20134_LeftBtnDesc = {Text = "Esci"},
  TipsType_20134_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_20134_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20137_Desc = {
    Text = "Sbloccare questa traccia con <Blue:\"{s1}\"*{s2}>?"
  },
  TipsType_20137_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20137_RightBtnDesc = {Text = "Conferma"},
  TipsType_20137_Title = {
    Text = "Conferma Sblocco"
  },
  TipsType_20138_Desc = {
    Text = "<Blue:Sblocco Gratuito> solo per un tempo limitato. Sbloccare ora?"
  },
  TipsType_20138_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20138_RightBtnDesc = {Text = "Conferma"},
  TipsType_20138_Title = {
    Text = "Conferma Sblocco"
  },
  TipsType_20139_Desc = {
    Text = "Sbloccare <Blue:\"{s2}\"> con <Blue:\"{s1}\"*{s3}>?"
  },
  TipsType_20139_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20139_RightBtnDesc = {Text = "Conferma"},
  TipsType_20139_Title = {
    Text = "Conferma Sblocco"
  },
  TipsType_20140_Desc = {
    Text = "Hai raggiunto il limite massimo del conteggio di <Blue:{s1}>. Riscuoterne altri non garantirà oggetti aggiuntivi. Vuoi riscuotere comunque?"
  },
  TipsType_20140_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20140_RightBtnDesc = {Text = "Conferma"},
  TipsType_20140_Title = {
    Text = "Conferma riscossione"
  },
  TipsType_20141_Desc = {
    Text = [[
Spendere il 30% dei tuoi HP massimi ({s1}) per
saltare la battaglia ed eliminare il nemico istantaneamente?

HP attuali: {s2}]]
  },
  TipsType_20141_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20141_RightBtnDesc = {Text = "Conferma"},
  TipsType_20141_Title = {
    Text = "Memoria Muscolare"
  },
  TipsType_20142_Desc = {
    Text = "Consumare <color=#BB646D>{s1}</color> HP per ottenere {s2} Sigilli Neri?"
  },
  TipsType_20142_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20142_RightBtnDesc = {Text = "Conferma"},
  TipsType_20142_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20145_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20145_Title = {
    Text = "Ricompense di Accesso"
  },
  TipsType_20151_Desc = {
    Text = "Dopo il ripristino, la quantità residua di \"Oggetti Speciali\" verrà riportata al massimo. Sei sicuro?"
  },
  TipsType_20151_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20151_RightBtnDesc = {Text = "Conferma"},
  TipsType_20151_Title = {
    Text = "Conferma ripristino"
  },
  TipsType_20152_Desc = {
    Text = "{s1} insufficienti, usare Certificati Rosa *{s2} per compensare?"
  },
  TipsType_20152_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20152_RightBtnDesc = {Text = "Conferma"},
  TipsType_20152_Title = {
    Text = "Conferma attivazione"
  },
  TipsType_20153_Desc = {
    Text = "Dopo il ripristino, le quantità residue di \"Oggetti Speciali\" e \"Oggetti Comuni\" verranno riportate al massimo.\nDalla {s1} volta in poi, gli \"Oggetti Speciali\" non verranno più ripristinati.\nSei sicuro?"
  },
  TipsType_20153_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20153_RightBtnDesc = {Text = "Conferma"},
  TipsType_20153_Title = {
    Text = "Conferma ripristino"
  },
  TipsType_20154_Desc = {
    Text = "Dopo il ripristino, le quantità residue di \"Oggetti Speciali\" e \"Oggetti Comuni\" verranno riportate al massimo. \nDalla 3ª volta in poi, gli \"Oggetti Speciali\" non verranno più ripristinati. \n <Blue:Hai ancora \"Oggetti Comuni\" rimanenti>, sei sicuro?"
  },
  TipsType_20154_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20154_RightBtnDesc = {Text = "Conferma"},
  TipsType_20154_Title = {
    Text = "Conferma ripristino"
  },
  TipsType_20155_Desc = {
    Text = "I materiali di Ascensione includono una Ruota del destino bloccata. Confermi di consumarla per l'Ascensione?"
  },
  TipsType_20155_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20155_RightBtnDesc = {Text = "Conferma"},
  TipsType_20155_Title = {
    Text = "Conferma ascensione"
  },
  TipsType_20156_Desc = {
    Text = "Sei sicuro di voler usare <TipsHighlightText:Soglia della Realtà*1> per sbloccare?\n(Durante l'evento Desideri Carnali, le Soglie della Realtà necessarie sono ridotte da {s1} a {s2}.)"
  },
  TipsType_20156_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20156_RightBtnDesc = {Text = "Conferma"},
  TipsType_20156_Title = {
    Text = "Conferma Sblocco"
  },
  TipsType_20157_Desc = {
    Text = "Sei sicuro di voler usare <TipsHighlightText:Soglia della Realtà*{s1}> per sbloccare?"
  },
  TipsType_20157_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20157_RightBtnDesc = {Text = "Conferma"},
  TipsType_20157_Title = {
    Text = "Conferma Sblocco"
  },
  TipsType_20158_Desc = {
    Text = "La fase corrente è scaduta. Non verranno assegnate ricompense al completamento. Vuoi uscire?"
  },
  TipsType_20158_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20158_RightBtnDesc = {Text = "Conferma"},
  TipsType_20158_Title = {
    Text = "Conferma uscita"
  },
  TipsType_20159_Desc = {
    Text = "<TipsHighlightText:\"{s1}\"> ha superato il limite di <TipsHighlightText: {s2}>, ciascuno convertito in <Blue:\"Invito dell'Informe\" × 1>"
  },
  TipsType_20159_Title = {
    Text = "Suggerimento conversione"
  },
  TipsType_20160_Desc = {
    Text = [[
Hai sbloccato <TipsHighlightText:"{s1}">
Come bonus di sblocco gratuito, riceverai la seguente ricompensa.]]
  },
  TipsType_20160_RightBtnDesc = {Text = "Conferma"},
  TipsType_20160_Title = {
    Text = "Suggerimento compensazione"
  },
  TipsType_20161_Desc = {
    Text = "La quantità di <TipsHighlightText:{s1}> in tuo possesso ha subito un Traboccamento di <TipsHighlightText:{s2}>. Ogni oggetto in eccesso è stato convertito in <Blue:Scrip di Rosa*5000>"
  },
  TipsType_20161_Title = {
    Text = "Suggerimento conversione"
  },
  TipsType_20162_Desc = {
    Text = "Ripristino del Livello, dell'Edificazione, delle Abilità, dei Talenti e dello stato di Avanzamento Gnostico del Risvegliato. Tutti i Materiali consumati verranno restituiti.\nConfermi il Ripristino dello Sviluppo per <WeaponEffect_Num:{s1}>?"
  },
  TipsType_20162_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20162_RightBtnDesc = {Text = "Conferma"},
  TipsType_20162_Title = {
    Text = "Ripristino dello Sviluppo"
  },
  TipsType_20163_Desc = {
    Text = "Ripristinare lo Sviluppo? \nL'Illuminazione verrà azzerata e i costi rimborsati per {s1}. Confermi il ripristino?"
  },
  TipsType_20163_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20163_RightBtnDesc = {Text = "Conferma"},
  TipsType_20163_Title = {
    Text = "Reset dell'Illuminazione"
  },
  TipsType_20164_Desc = {
    Text = "Ripristino del Livello, dell'Edificazione, delle Abilità, dei Talenti, dell'Illuminazione e dello stato di Avanzamento Gnostico del Risvegliato. Questo Risvegliato verrà restituito al Pozzo Oscuro.\nConfermi il Ritorno alla Genesi per <WeaponEffect_Num:{s1}>?"
  },
  TipsType_20164_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20164_RightBtnDesc = {Text = "Conferma"},
  TipsType_20164_Title = {
    Text = "Ritorno alla Genesi"
  },
  TipsType_20165_Desc = {
    Text = "<WeaponEffect_Num:{s1}> è un Risvegliato Speciale. Possono essere reimpostati solo il Livello, l'Edificazione, le Abilità, i Talenti e lo stato di Avanzamento Gnostico. Il suo <Red:stato di Illuminazione> non può essere reimpostato. Sei sicuro di voler usare <WeaponEffect_Num:{s1}> su questo Risvegliato?\nQuesta operazione non può essere annullata."
  },
  TipsType_20165_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20165_RightBtnDesc = {Text = "Conferma"},
  TipsType_20165_Title = {
    Text = "Ripristina selezione"
  },
  TipsType_20166_Desc = {
    Text = "Il Reset dell'Illuminazione non è disponibile per i Risvegliati Speciali"
  },
  TipsType_20167_Desc = {
    Text = "Ripristino non disponibile. \nIl Ripristino dello Sviluppo è già stato utilizzato. Attendi il prossimo ciclo di ripristino."
  },
  TipsType_20168_Desc = {
    Text = "Hai già effettuato il Reset dell'Illuminazione durante questo Evento di Ripristino. Riprova la prossima volta."
  },
  TipsType_20169_BottomDesc = {
    Text = "<Blue:Nota: una volta effettuata, la scelta non potrà essere modificata per l'evento in corso!>"
  },
  TipsType_20169_Desc = {
    Text = "Confermare la scelta del Risvegliatore <OrangeQuality:\"{s1}\"> e della Ruota del destino consigliata <OrangeQuality:\"{s2}\"> come UP direzionale dell'evento di questo periodo."
  },
  TipsType_20169_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20169_RightBtnDesc = {Text = "Conferma"},
  TipsType_20169_Title = {
    Text = "Conferma selezione"
  },
  TipsType_20170_Desc = {
    Text = "Limite giornaliero di sfide raggiunto, torna domani per sfidarti di nuovo!"
  },
  TipsType_20171_Desc = {
    Text = "\"Immersione Fantasmatica\" sbloccata!"
  },
  TipsType_20173_Desc = {
    Text = "\"Traphase\" sbloccato!"
  },
  TipsType_20174_Desc = {
    Text = "\"Indagine: Difficile\" sbloccata!"
  },
  TipsType_20175_Desc = {
    Text = "\"Dominio Arcano\" sbloccato!"
  },
  TipsType_20176_Desc = {
    Text = "\"Zona D-Effetto regionale\" sbloccata!"
  },
  TipsType_20177_Desc = {
    Text = "\"Frenesia Riproduttiva\" sbloccata!"
  },
  TipsType_20178_Desc = {
    Text = "\"Seconda Ruota del destino\" sbloccata!"
  },
  TipsType_20179_Desc = {
    Text = "\"Ammasso del Caos\" sbloccato!"
  },
  TipsType_20180_Desc = {
    Text = "\"Patto Proibito\" sbloccato!"
  },
  TipsType_20181_Desc = {
    Text = "\"Potenziamento Patto\" sbloccato!"
  },
  TipsType_20182_Desc = {
    Text = "\"Trascrizione del Patto\" sbloccata!"
  },
  TipsType_20183_Desc = {
    Text = "L'evento in corso è terminato."
  },
  TipsType_20184_Desc = {
    Text = "\"Manuale\" sbloccato!"
  },
  TipsType_20185_Desc = {
    Text = "Saltare il segmento della storia?"
  },
  TipsType_20185_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20185_RightBtnDesc = {Text = "Conferma"},
  TipsType_20185_Title = {
    Text = "Salta Storia"
  },
  TipsType_20186_Desc = {
    Text = [[
Scaricare i dati di gioco? 
I file necessari sono pronti. Continuare? 
*(Si consiglia una connessione Wi-Fi)*]]
  },
  TipsType_20186_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20186_RightBtnDesc = {Text = "Conferma"},
  TipsType_20187_Desc = {
    Text = "Download completato."
  },
  TipsType_20187_LeftBtnDesc = {Text = "Conferma"},
  TipsType_20188_Desc = {
    Text = [[
Spazio di archiviazione quasi esaurito. 
Sono necessari almeno {s1} per evitare la perdita di dati. Continuare comunque?]]
  },
  TipsType_20188_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20188_RightBtnDesc = {Text = "Conferma"},
  TipsType_20189_Desc = {
    Text = "Download fallito. Riprovare?"
  },
  TipsType_20189_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20189_RightBtnDesc = {Text = "Conferma"},
  TipsType_20190_Desc = {
    Text = "<TipsHighlightText:{s1}> in Traboccamento! <TipsHighlightText: {s2}> oltre il limite convertiti in <Blue:{s3}> ciascuno."
  },
  TipsType_20190_Title = {
    Text = "Suggerimento conversione"
  },
  TipsType_20191_Desc = {
    Text = "\"Evento\" è ora disponibile!"
  },
  TipsType_20192_Desc = {
    Text = [[
Scarica i dati del Prologo 
Necessari per i contenuti successivi. 
Dimensione: {s1} 
*(Si consiglia il Wi-Fi)*]]
  },
  TipsType_20192_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20192_RightBtnDesc = {Text = "Download"},
  TipsType_20193_Desc = {
    Text = "\"Incarico\" è ora disponibile!"
  },
  TipsType_20194_Desc = {
    Text = "\"Comunicatore\" è ora disponibile!"
  },
  TipsType_20195_Desc = {
    Text = "\"Curriculum\" è ora disponibile!"
  },
  TipsType_20196_Desc = {
    Text = "\"Reame Senza Luce\" è ora disponibile!"
  },
  TipsType_20197_Desc = {
    Text = "Numero massimo di Risvegli raggiunto. Riscuoti le ricompense delle missioni!"
  },
  TipsType_20198_Desc = {
    Text = "Missione incompleta. Completa l'obiettivo per riscuotere le ricompense."
  },
  TipsType_20199_Desc = {
    Text = "Dopo la riscossione, il \"Certificato di Procura\" supererà il limite di possesso,\ne la parte in eccesso non verrà ottenuta.\nVuoi continuare?"
  },
  TipsType_20199_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20199_RightBtnDesc = {Text = "Conferma"},
  TipsType_20199_Title = {
    Text = "Conferma riscossione"
  },
  TipsType_20200_Desc = {
    Text = "Confermi l'utilizzo di <Blue:Certificato di Procura*1> per completare istantaneamente la Missione Quotidiana?"
  },
  TipsType_20200_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20200_RightBtnDesc = {Text = "Conferma"},
  TipsType_20200_Title = {
    Text = "Conferma Emissario"
  },
  TipsType_20201_Desc = {
    Text = "Il seguente Patto è attualmente equipaggiato. Vuoi sostituirlo?"
  },
  TipsType_20201_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20201_RightBtnDesc = {Text = "Conferma"},
  TipsType_20201_Title = {
    Text = "Sostituire le Sottostats?"
  },
  TipsType_20202_Desc = {
    Text = "Il piano attuale è attivo in {s1}. Eliminare comunque il piano {s2}?"
  },
  TipsType_20202_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20202_RightBtnDesc = {Text = "Conferma"},
  TipsType_20202_Title = {
    Text = "Conferma eliminazione"
  },
  TipsType_20203_Desc = {
    Text = "Effetti identici della Ruota del destino non possono essere cumulati nella stessa squadra. {s1} è già equipaggiato. Equipaggiare comunque?"
  },
  TipsType_20203_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20203_RightBtnDesc = {Text = "Conferma"},
  TipsType_20203_Title = {
    Text = "Conferma equipaggiamento"
  },
  TipsType_20204_Desc = {
    Text = "Il Patto attuale è già in uso in {s1}. Smantellandolo verrà rimosso da quella configurazione. Procedere comunque?"
  },
  TipsType_20204_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20204_RightBtnDesc = {Text = "Conferma"},
  TipsType_20204_Title = {
    Text = "Conferma eliminazione"
  },
  TipsType_20205_Desc = {
    Text = "Il Patto attuale è già in uso nella Formazione {s1}. Smantellandolo verrà rimosso dall'equipaggiamento. Procedere comunque?"
  },
  TipsType_20205_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20205_RightBtnDesc = {Text = "Conferma"},
  TipsType_20205_Title = {
    Text = "Conferma eliminazione"
  },
  TipsType_20206_Desc = {
    Text = "La Ruota del destino attuale è in uso nella Formazione {s1}. Smantellandola verrà rimossa dalla Formazione. Procedere comunque?"
  },
  TipsType_20206_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20206_RightBtnDesc = {Text = "Conferma"},
  TipsType_20206_Title = {
    Text = "Conferma eliminazione"
  },
  TipsType_20207_Desc = {
    Text = "Le modifiche non salvate andranno perse se esci. Uscire comunque?"
  },
  TipsType_20207_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20207_RightBtnDesc = {Text = "Conferma"},
  TipsType_20207_Title = {
    Text = "Applica Formazione"
  },
  TipsType_20208_Desc = {
    Text = "Ricompense riscattate! Dai un'occhiata agli altri compiti disponibili."
  },
  TipsType_20209_Desc = {
    Text = "Compito scaduto."
  },
  TipsType_20210_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_20210_LeftBtnDesc = {Text = "Esci"},
  TipsType_20210_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_20210_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20211_Desc = {
    Text = "Sblocco tra {s1}g {s2} ore"
  },
  TipsType_20212_Desc = {
    Text = "Sblocco tra {s1}ore {s2}min"
  },
  TipsType_20213_Desc = {
    Text = "{s1} ha innescato la Causalità Oltrelimite. Il riavvolgimento invaliderà questo effetto e rimuoverà l'unità dalla tua formazione. \nProcedere con il riavvolgimento? (L'azione è irreversibile)"
  },
  TipsType_20213_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20213_RightBtnDesc = {Text = "Conferma"},
  TipsType_20213_Title = {
    Text = "Ripristina selezione"
  },
  TipsType_20214_Desc = {
    Text = "Annullare l'Ascensione? \nReimpostare {s1} per rimborsare tutti i costi. La Causalità Oltrelimite verrà disattivata e l'unità rimossa dalla formazione. Confermare?"
  },
  TipsType_20214_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20214_RightBtnDesc = {Text = "Conferma"},
  TipsType_20214_Title = {
    Text = "Stack Traceback"
  },
  TipsType_20215_Desc = {
    Text = "Ritorno alla Genesi? \nReimpostare {s1} e restituirlo alla Pozza nera. Tutti i costi verranno rimborsati e l'unità verrà rimossa dalla formazione. Confermare?"
  },
  TipsType_20215_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20215_RightBtnDesc = {Text = "Conferma"},
  TipsType_20215_Title = {
    Text = "Ritorno alla Genesi"
  },
  TipsType_20216_Desc = {
    Text = "Acquistare con <Blue:{s1} × {s2}>?"
  },
  TipsType_20216_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20216_RightBtnDesc = {Text = "Acquista"},
  TipsType_20216_Title = {
    Text = "Conferma acquisto"
  },
  TipsType_20217_Desc = {
    Text = "{s1} si aprirà dopo {s2}."
  },
  TipsType_20218_Desc = {
    Text = "Il Risvegliatore preselezionato non può essere rimosso. Puoi solo sostituirlo con lo stesso Risvegliatore."
  },
  TipsType_20219_Desc = {
    Text = "Lo stesso Risvegliatore è già schierato. Impossibile selezionarlo di nuovo."
  },
  TipsType_20220_Desc = {
    Text = "Wi-Fi non rilevato. \nIl download ({s1}) consumerà dati mobili. Continuare?"
  },
  TipsType_20220_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20220_RightBtnDesc = {Text = "Download"},
  TipsType_20221_Desc = {
    Text = "Download completato."
  },
  TipsType_20221_LeftBtnDesc = {Text = "Conferma"},
  TipsType_20222_Desc = {
    Text = [[
Spazio di archiviazione quasi esaurito. 
Sono necessari almeno {s1} per evitare la perdita di dati. Continuare comunque?]]
  },
  TipsType_20222_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20222_RightBtnDesc = {Text = "Conferma"},
  TipsType_20223_Desc = {
    Text = "Download fallito. Riprovare?"
  },
  TipsType_20223_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20223_RightBtnDesc = {Text = "Conferma"},
  TipsType_20224_Desc = {
    Text = [[
Scarica i dati del Prologo 
Necessari per i contenuti successivi. 
Dimensione: {s1} 
*(Si consiglia il Wi-Fi)*]]
  },
  TipsType_20224_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20224_RightBtnDesc = {Text = "Download"},
  TipsType_20225_Desc = {
    Text = [[
{s1} completato! 
Accettare la sfida aggiuntiva per {s2} Punti Addestramento?]]
  },
  TipsType_20225_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20225_RightBtnDesc = {Text = "Conferma"},
  TipsType_20225_Title = {
    Text = "Sfida extra"
  },
  TipsType_20226_Desc = {
    Text = "Dopo il ripristino, il Risvegliatore, la Posse e la Ruota del destino della squadra della sfida extra potranno tutti rientrare in campo di battaglia, ma verranno detratti anche i Punti Addestramento ottenuti per il completamento di questo livello (ciò non influisce sullo stato delle ricompense). Sei sicuro di voler ripristinare?"
  },
  TipsType_20226_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20226_RightBtnDesc = {Text = "Conferma"},
  TipsType_20226_Title = {
    Text = "Conferma ripristino"
  },
  TipsType_20227_Desc = {
    Text = "Dopo il ripristino, il Risveglio, la Squadra e la Ruota del destino della squadra d'indagine attuale potranno essere schierati nuovamente. Inoltre, la squadra della sfida extra sostituirà l'attuale squadra d'indagine, ma i Punti Addestramento ottenuti completando questo livello come sfida extra verranno anch'essi detratti (ciò non influisce sullo stato delle ricompense). Sei sicuro di voler ripristinare?"
  },
  TipsType_20227_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20227_RightBtnDesc = {Text = "Conferma"},
  TipsType_20227_Title = {
    Text = "Conferma ripristino"
  },
  TipsType_20228_Desc = {
    Text = "Scorri verso il basso per altri annunci."
  },
  TipsType_20229_Desc = {
    Text = "\"<Blue:{s1}>\" ha raggiunto l'Ascensione Massima.\nVuoi acquistare comunque?\nQuantità rimanente: {s2}"
  },
  TipsType_20229_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20229_RightBtnDesc = {Text = "Conferma"},
  TipsType_20229_Title = {
    Text = "Conferma acquisto"
  },
  TipsType_20230_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_20230_LeftBtnDesc = {Text = "Esci"},
  TipsType_20230_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_20230_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20231_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_20231_LeftBtnDesc = {Text = "Esci"},
  TipsType_20231_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_20231_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20232_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_20232_LeftBtnDesc = {Text = "Esci"},
  TipsType_20232_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_20232_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20233_Desc = {
    Text = "Materiali necessari insufficienti. Desideri consumare i seguenti materiali in sostituzione?"
  },
  TipsType_20233_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20233_RightBtnDesc = {Text = "Conferma"},
  TipsType_20233_Title = {
    Text = "Conferma completa"
  },
  TipsType_20234_Desc = {
    Text = "Questo livello consente l'uso esclusivo della Posse equipaggiata, che non può essere sostituita."
  },
  TipsType_20235_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_20235_LeftBtnDesc = {Text = "Esci"},
  TipsType_20235_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_20235_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20236_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_20236_LeftBtnDesc = {Text = "Esci"},
  TipsType_20236_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_20236_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20237_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_20237_LeftBtnDesc = {Text = "Esci"},
  TipsType_20237_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_20237_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20238_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_20238_LeftBtnDesc = {Text = "Esci"},
  TipsType_20238_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_20238_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20239_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_20239_LeftBtnDesc = {Text = "Esci"},
  TipsType_20239_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_20239_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20240_Desc = {
    Text = "Riparazione completata. Riavvia il gioco."
  },
  TipsType_20240_RightBtnDesc = {Text = "Conferma"},
  TipsType_20240_Title = {Text = "Nota"},
  TipsType_20241_Desc = {
    Text = [[
Servono ancora {s1} "<Blue:{s2}>" per completare l'ascensione.
Desideri continuare l'acquisto?]]
  },
  TipsType_20241_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20241_RightBtnDesc = {Text = "Conferma"},
  TipsType_20241_Title = {
    Text = "Conferma acquisto"
  },
  TipsType_20250_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_20250_LeftBtnDesc = {Text = "Esci"},
  TipsType_20250_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_20250_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20251_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_20251_LeftBtnDesc = {Text = "Esci"},
  TipsType_20251_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_20251_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20252_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_20252_LeftBtnDesc = {Text = "Esci"},
  TipsType_20252_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_20252_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20259_Desc = {
    Text = "Impostazioni di scambio salvate per quando il \"Sigillo dei mille volti\" è insufficiente"
  },
  TipsType_20300_Desc = {
    Text = "Possiedi già {s1} Awakener con Ruoli Traphase; non è possibile utilizzare lo stesso Awakener con Ruoli Traphase nella stessa squadra."
  },
  TipsType_20301_Desc = {
    Text = "Compiti di Addestramento"
  },
  TipsType_20351_Desc = {
    Text = [[
{s1} insufficienti. 
Scambiare {s2} {s3} con {s4} {s5}?]]
  },
  TipsType_20351_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20351_RightBtnDesc = {Text = "Conferma"},
  TipsType_20351_Title = {
    Text = "{s1} insufficienti"
  },
  TipsType_20352_Desc = {
    Text = "Legarsi a questo Custode? \nNota: questa azione è permanente."
  },
  TipsType_20352_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20352_RightBtnDesc = {Text = "Conferma"},
  TipsType_20352_Title = {
    Text = "Conferma invito"
  },
  TipsType_20353_Desc = {
    Text = "Codice invito copiato!"
  },
  TipsType_20354_Desc = {
    Text = "Hai già invitato questo utente."
  },
  TipsType_20355_Desc = {
    Text = "Non puoi utilizzare il tuo stesso codice. Inserisci il codice di un altro Custode."
  },
  TipsType_20356_Desc = {
    Text = [[
Puoi rigiocare per rivivere la storia del Prologo e il tutorial!
Tuttavia, non riceverai nuovamente le stesse ricompense.
Vuoi procedere comunque?]]
  },
  TipsType_20356_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20356_RightBtnDesc = {Text = "Conferma"},
  TipsType_20356_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_20357_Desc = {
    Text = "Smettere di seguire i {s1} Custodi selezionati?"
  },
  TipsType_20357_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20357_RightBtnDesc = {Text = "Conferma"},
  TipsType_20357_Title = {
    Text = "Smetti di seguire"
  },
  TipsType_20358_Desc = {
    Text = "C'è un'azione di smetti di seguire non confermata. Uscire e annullare?"
  },
  TipsType_20358_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20358_RightBtnDesc = {Text = "Conferma"},
  TipsType_20358_Title = {
    Text = "Conferma uscita"
  },
  TipsType_20400_Desc = {
    Text = "<WeaponEffect_Num:{s1}> insufficienti. Vuoi scambiarne altri?"
  },
  TipsType_20400_LeftBtnDesc = {Text = "Annulla"},
  TipsType_20400_RightBtnDesc = {Text = "Conferma"},
  TipsType_20400_Title = {
    Text = "Oggetti della lotteria insufficienti"
  },
  TipsType_300001_Desc = {
    Text = "\"Alba Argentea\" offre una sola possibilità di Risveglio gratuita. Sei sicuro di volerla utilizzare?"
  },
  TipsType_300001_LeftBtnDesc = {Text = "Annulla"},
  TipsType_300001_RightBtnDesc = {Text = "Conferma"},
  TipsType_300001_Title = {Text = "Conferma"},
  TipsType_300002_Desc = {
    Text = "Confermi il risultato di questo Risveglio? Una volta confermato, il tentativo di Risveglio gratuito verrà consumato."
  },
  TipsType_300002_LeftBtnDesc = {Text = "Annulla"},
  TipsType_300002_RightBtnDesc = {Text = "Conferma"},
  TipsType_300002_Title = {Text = "Conferma"},
  TipsType_30001_Desc = {
    Text = "Suggerimento laterale senza icona"
  },
  TipsType_30003_Desc = {
    Text = "{s1} Sbloccato"
  },
  TipsType_30004_Desc = {
    Text = "{s1} Modalità Avanzata Sbloccata"
  },
  TipsType_30005_Desc = {
    Text = "{s1} (Difficile) Sbloccato"
  },
  TipsType_31000_Desc = {
    Text = "Confermare la data di nascita? \nUna volta confermata, la data di nascita non potrà essere modificata."
  },
  TipsType_31000_LeftBtnDesc = {Text = "Annulla"},
  TipsType_31000_RightBtnDesc = {Text = "Conferma"},
  TipsType_31000_Title = {
    Text = "Verifica dell'età"
  },
  TipsType_31001_Desc = {
    Text = "Questo mese hai ricaricato <Blue:{s1}> yuan, il limite massimo è <Blue:{s2}> yuan. Riprova il mese prossimo oppure scegli un importo inferiore."
  },
  TipsType_31002_Desc = {
    Text = "Completa prima la verifica dell'età"
  },
  TipsType_31003_Desc = {
    Text = "Attivare il Corpo di Gnosi d'Emergenza? \nRianimare adesso? (Consuma 1 Gnosi; si ricarica ogni giorno alle 9:00). \nRimanenti: {s1} \n<Blue:(La prima rianimazione è gratuita!)>"
  },
  TipsType_31003_LeftBtnDesc = {Text = "Annulla"},
  TipsType_31003_RightBtnDesc = {Text = "Conferma"},
  TipsType_31003_Title = {
    Text = "Rianimazione immediata?"
  },
  TipsType_31004_Desc = {
    Text = "Attivare il Corpo di Gnosi d'Emergenza? \nRianimare adesso? (Consuma 1 Gnosi; si ricarica ogni giorno alle 9:00). \nRimanenti: {s1} \n<Blue:(La prima rianimazione è gratuita!)>"
  },
  TipsType_31004_RightBtnDesc = {Text = "Conferma"},
  TipsType_31004_Title = {
    Text = "Rianimazione immediata?"
  },
  TipsType_40001_Desc = {
    Text = "Quando i PV raggiungono 0, l'indagine si interrompe immediatamente."
  },
  TipsType_40001_Title = {Text = "Vita"},
  TipsType_40002_Desc = {
    Text = [[
Movimento ed Eventi generano Stress, che si accumula in Sintomi Mentali.
Ogni casella percorsa aggiunge 10 Stress. Ogni 100 Stress causa 1 Sintomo.
A 500 Stress, ogni movimento riduce i Vita del 10%.]]
  },
  TipsType_40002_Title = {Text = "Stress"},
  TipsType_40003_Desc = {
    Text = "Livelli di Assegnazione più alti comportano maggiore difficoltà, ma ricompense migliori."
  },
  TipsType_40003_Title = {
    Text = "Livello Incarico"
  },
  TipsType_40004_Desc = {
    Text = "La prima Carta di comando giocata ogni turno crea una copia temporanea nello Spazio Ultra.\nQuando è pieno, ottieni 1 Turno Ultra aggiuntivo e conservi lo Scudo del turno precedente.\nEffetto Padronanza del Reame: Ha una probabilità di aggiungere 1 \"Intuizione\" alla mano a inizio turno."
  },
  TipsType_40004_Title = {
    Text = "Spazio Ultra"
  },
  TipsType_40005_Desc = {
    Text = "I Custodi ottengono EXP Custode tramite Indagini, Interludi e sfide. Livelli Custode più alti sbloccano ulteriori opzioni di gioco."
  },
  TipsType_40005_Title = {
    Text = "EXP Custode"
  },
  TipsType_40006_Desc = {
    Text = "Le Carte di comando consumano Arithmetica. I punti inutilizzati non vengono conservati. L'Arithmetica viene completamente ripristinata all'inizio di ogni turno."
  },
  TipsType_40006_Title = {
    Text = "Arithmetica"
  },
  TipsType_40007_Desc = {
    Text = "La Chiave d'argento percepisce un'energia speciale. Qualcosa di prezioso potrebbe celarsi qui..."
  },
  TipsType_40007_Title = {
    Text = "Risorsa Nascosta"
  },
  TipsType_40008_Desc = {
    Text = [[
Si attiva durante crisi letali (consuma 1 utilizzo).
Ripristina al massimo i PV della squadra e l'Aliemus dei Risvegliati.
Aggiornamento giornaliero: 1 alle 9:00.]]
  },
  TipsType_40008_Title = {
    Text = "Corpo di Gnosi d'Emergenza"
  },
  TipsType_40009_Desc = {
    Text = [[
Le Carte di comando consumano Arithmetica. I punti inutilizzati scadono.
Inizio turno: +1 al limite, ripristino al limite. Turno attuale: {s1}.]]
  },
  TipsType_40009_Title = {
    Text = "Arithmetica"
  },
  TipsType_AbyssChallengeResetTips_Desc = {
    Text = "La zona proibita del D-effetto regionale è stata reimpostata. La sfida in corso terminerà immediatamente."
  },
  TipsType_AbyssChallengeResetTips_RightBtnDesc = {Text = "Conferma"},
  TipsType_AbyssChallengeResetTips_Title = {
    Text = "Indagine in corso"
  },
  TipsType_AbyssChallengeRevivalTips_Desc = {
    Text = "La Chiave d'Argento percepisce una crisi fatale. Attivare la Gnosi d'Emergenza?\n(La Rinascita consumerà 1 Gnosi d'Emergenza. Ne ricevi 1 al giorno alle 9:00.)"
  },
  TipsType_AbyssChallengeRevivalTips_LeftBtnDesc = {Text = "Annulla"},
  TipsType_AbyssChallengeRevivalTips_RightBtnDesc = {Text = "Conferma"},
  TipsType_AbyssChallengeRevivalTips_Title = {
    Text = "Rianimazione immediata?"
  },
  TipsType_AcceptConfirm_Desc = {
    Text = "Accetti l'invito <Blue:{s2}> di <Blue:{s1}>?"
  },
  TipsType_AcceptConfirm_LeftBtnDesc = {Text = "Rifiuta"},
  TipsType_AcceptConfirm_RightBtnDesc = {Text = "Accetta"},
  TipsType_AcceptConfirm_Title = {
    Text = "Modalità Password"
  },
  TipsType_ActivitySignRewardTaskNotCompleteTips_Desc = {
    Text = "Completa i Compiti per il Risveglio"
  },
  TipsType_AlreadyIsBackgroundMusicTips_Desc = {
    Text = "Già impostato come BGM attuale"
  },
  TipsType_AwakerAutoInsertCoinNotEnoughTips_Desc = {
    Text = "Le \"Rosa dorata\" non sono sufficienti per utilizzare completamente gli \"Elisir di gnosi\" attualmente posseduti. Puoi provare dopo aver integrato le \"Rosa dorata\"."
  },
  TipsType_AwakerNotOpenTips_Desc = {
    Text = "Il Risvegliatore non è ancora disponibile. Resta sintonizzato!"
  },
  TipsType_AwakerRandomChestConfirm_Desc = {
    Text = "Confermi l'utilizzo di <Blue:{s1}> per ottenere 1 Risvegliatore <Blue:casuale>?"
  },
  TipsType_AwakerRandomChestConfirm_LeftBtnDesc = {Text = "Annulla"},
  TipsType_AwakerRandomChestConfirm_RightBtnDesc = {Text = "Conferma"},
  TipsType_AwakerRandomChestConfirm_Title = {
    Text = "Conferma utilizzo"
  },
  TipsType_BattleCreateFail_Desc = {
    Text = "Creazione Battaglia Fallita"
  },
  TipsType_BattlePassAllCompleteTips_Desc = {
    Text = "Tutti gli Archivi attuali sono stati completati."
  },
  TipsType_BestExperienceTips_Chapter3_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_BestExperienceTips_Chapter3_LeftBtnDesc = {Text = "Esci"},
  TipsType_BestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_BestExperienceTips_Chapter3_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_BestExperienceTips_Chapter7_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_BestExperienceTips_Chapter7_LeftBtnDesc = {Text = "Esci"},
  TipsType_BestExperienceTips_Chapter7_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_BestExperienceTips_Chapter7_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_BestExperienceTips_Chapter8_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_BestExperienceTips_Chapter8_LeftBtnDesc = {Text = "Esci"},
  TipsType_BestExperienceTips_Chapter8_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_BestExperienceTips_Chapter8_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_BestExperienceTips_ChapterS2_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_BestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "Esci"},
  TipsType_BestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_BestExperienceTips_ChapterS2_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_BestExperienceTips_ChapterS3_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_BestExperienceTips_ChapterS3_LeftBtnDesc = {Text = "Esci"},
  TipsType_BestExperienceTips_ChapterS3_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_BestExperienceTips_ChapterS3_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_BestExperienceTips_ChapterS4_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_BestExperienceTips_ChapterS4_LeftBtnDesc = {Text = "Esci"},
  TipsType_BestExperienceTips_ChapterS4_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_BestExperienceTips_ChapterS4_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_BestExperienceTips_ChapterS5_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_BestExperienceTips_ChapterS5_LeftBtnDesc = {Text = "Esci"},
  TipsType_BestExperienceTips_ChapterS5_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_BestExperienceTips_ChapterS5_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_LeftBtnDesc = {Text = "Esci"},
  TipsType_BestExperienceTips_MainStoryS1_6_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_LeftBtnDesc = {Text = "Esci"},
  TipsType_BestExperienceTips_TwoAnniversarySubStage_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_CancelCollectAwakerTips_Desc = {
    Text = "Rimosso dai preferiti"
  },
  TipsType_CoinBulkBuyConfirm_Desc = {
    Text = "Vuoi consumare \"Buono Rosa\" × {s1} per effettuare l'acquisto?"
  },
  TipsType_CoinBulkBuyConfirm_LeftBtnDesc = {Text = "Annulla"},
  TipsType_CoinBulkBuyConfirm_RightBtnDesc = {Text = "Conferma"},
  TipsType_CoinBulkBuyConfirm_Title = {
    Text = "Conferma acquisto"
  },
  TipsType_CollectAwakerTips_Desc = {
    Text = "Aggiunto ai preferiti"
  },
  TipsType_CommonUseBattleHelpLimitTips_Desc = {
    Text = "Hai aggiunto troppi Supporti preferiti. Per favore, modifica la lista."
  },
  TipsType_DiskIsFullOrViolation_Desc = {
    Text = "Impossibile caricare i file. Controlla lo spazio di archiviazione."
  },
  TipsType_DiskIsFullOrViolation_RightBtnDesc = {Text = "Conferma"},
  TipsType_DiskSpaceNotEnough_Desc = {
    Text = "Spazio di archiviazione insufficiente. Continuare il download?"
  },
  TipsType_DiskSpaceNotEnough_LeftBtnDesc = {Text = "Annulla"},
  TipsType_DiskSpaceNotEnough_RightBtnDesc = {Text = "Conferma"},
  TipsType_DoubleExBPBuyConfirm_Desc = {
    Text = "Acquistare con <Blue:{s1}> Essenza di Silver Core?\n <color=#ACBFCA>Questa è una Stagione speciale del Curriculum. I Temi Fondamentali sono scontati.</color>"
  },
  TipsType_DoubleExBPBuyConfirm_LeftBtnDesc = {Text = "Annulla"},
  TipsType_DoubleExBPBuyConfirm_RightBtnDesc = {Text = "Acquista"},
  TipsType_DoubleExBPBuyConfirm_Title = {
    Text = "Conferma acquisto"
  },
  TipsType_EnterSix_DigitPasswordTips_Desc = {
    Text = "Inserisci la <color=#5EF2FF>Password</color>"
  },
  TipsType_FilterMaxAwakerCountTips_Desc = {
    Text = "Seleziona fino a {s1} Risvegliatori da filtrare"
  },
  TipsType_FollowBackConfirm_Desc = {
    Text = [[
Seguire i Seguaci <color=#5EF2FF>{s1}</color> in questa pagina? 

<color=#96947F>Attualmente seguiti </color>{s2}<color=#A0A0A0>/{s3}
Non potrai seguire un numero di Custodi superiore a questo limite. </color>]]
  },
  TipsType_FollowBackConfirm_LeftBtnDesc = {Text = "Annulla"},
  TipsType_FollowBackConfirm_RightBtnDesc = {Text = "Conferma"},
  TipsType_FollowBackConfirm_Title = {
    Text = "Ricambiare il follow?"
  },
  TipsType_FrenziedOmenUpgradeConfirm_Desc = {
    Text = "Questa operazione consumerà molte risorse ed è adatta a chi vuole portare le capacità del Risvegliatore al limite. Confermare il Potenziare del \"Presagio di Follia\"?"
  },
  TipsType_FrenziedOmenUpgradeConfirm_LeftBtnDesc = {Text = "Annulla"},
  TipsType_FrenziedOmenUpgradeConfirm_RightBtnDesc = {Text = "Conferma"},
  TipsType_FrenziedOmenUpgradeConfirm_Title = {
    Text = "Conferma Potenziamento"
  },
  TipsType_GnosticPotentialUpgradeConfirm_Desc = {
    Text = "Questa operazione consumerà molte risorse ed è adatta a chi vuole portare le capacità del Risvegliatore al limite. Confermare il Potenziare del \"Potenziale Gnostico\"?"
  },
  TipsType_GnosticPotentialUpgradeConfirm_LeftBtnDesc = {Text = "Annulla"},
  TipsType_GnosticPotentialUpgradeConfirm_RightBtnDesc = {Text = "Conferma"},
  TipsType_GnosticPotentialUpgradeConfirm_Title = {
    Text = "Conferma Potenziamento"
  },
  TipsType_InCharging_Desc = {
    Text = "Il tuo ordine è in fase di elaborazione. Si prega di non effettuare pagamenti duplicati. \n\n• Pagamento completato? Attendi la consegna delle ricompense.\nPagamento non completato? Riavvia il gioco e riprova. \n\nIn caso di problemi, contatta il Servizio Clienti."
  },
  TipsType_InCharging_RightBtnDesc = {Text = "Conferma"},
  TipsType_InCharging_Title = {Text = "Nota"},
  TipsType_KeyShortNameDownLoadTips_Desc = {
    Text = "Download della chiave multilingue in corso. Attendi un momento."
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_Desc = {
    Text = "Questo Risvegliatore è completamente Illuminato.\nDopo la selezione, riceverai soltanto 6 Frammenti di Gnosi e 2 Frammenti di Gnosi Raffinata"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_LeftBtnDesc = {Text = "Annulla"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_RightBtnDesc = {Text = "Continua"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_Title = {
    Text = "Conferma selezione"
  },
  TipsType_MainResetBG_Desc = {
    Text = "Ripristinare l'<Blue:Immagine> e la <Blue:Musica> di sfondo del dormitorio ai valori predefiniti?"
  },
  TipsType_MainResetBG_LeftBtnDesc = {Text = "Annulla"},
  TipsType_MainResetBG_RightBtnDesc = {Text = "Conferma"},
  TipsType_MainResetBG_Title = {
    Text = "Ripristina Predefinito"
  },
  TipsType_MultiSelectBox_FixItemTips_Desc = {
    Text = "Oggetto garantito. Non modificabile."
  },
  TipsType_MultiSelectBox_SelectTips_Desc = {
    Text = "Completa la selezione di tutti gli oggetti a scelta libera prima di procedere all'acquisto"
  },
  TipsType_OppositeSideCancelMatchTips_Desc = {
    Text = "L'avversario ha annullato l'abbinamento"
  },
  TipsType_OppositeSideRejectTips_Desc = {
    Text = "L'avversario ha rifiutato l'invito <Blue:{s1}>, seleziona nuovamente una modalità."
  },
  TipsType_PVEExceedMaxRoundsTips_Desc = {
    Text = [[
Il numero di round di combattimento ha raggiunto il limite massimo

O unico Custode
Come sceglierai adesso?]]
  },
  TipsType_PVEExceedMaxRoundsTips_LeftBtnDesc = {
    Text = "Ritenta Battaglia"
  },
  TipsType_PVEExceedMaxRoundsTips_RightBtnDesc = {
    Text = "Ritirata Temporanea"
  },
  TipsType_PVEExceedMaxRoundsTips_Title = {
    Text = "Indagine fallita"
  },
  TipsType_PVEReplayErrorTips_Desc = {
    Text = "Errore nel recupero della riproduzione della battaglia, riprova più tardi"
  },
  TipsType_PVEReplayMaxRounds_Desc = {
    Text = [[
Il Replay ha raggiunto il limite massimo di 25 turni.
Il Replay termina.]]
  },
  TipsType_PVEReplayMaxRounds_RightBtnDesc = {Text = "Conferma"},
  TipsType_PVEReplayMaxRounds_Title = {Text = "Conferma"},
  TipsType_PVEReplayNoDataTips_Desc = {
    Text = "Nessun registro di Indagine"
  },
  TipsType_PVEReplayRepeatClickTips_Desc = {
    Text = "Caricamento della riproduzione della battaglia in corso, non ripetere le operazioni"
  },
  TipsType_PVEReplaySpecialTeamAssignTips_Desc = {
    Text = "La riproduzione della battaglia con schieramenti speciali non è al momento supportata."
  },
  TipsType_PVEReplayTimeoutTips_Desc = {
    Text = "Recupero del replay di battaglia scaduto"
  },
  TipsType_PVEReplayUnableOperateTips_Desc = {
    Text = "Non è possibile eseguire operazioni durante la riproduzione della battaglia"
  },
  TipsType_PVETeamShareCodeCopyTips_Desc = {Text = "Copiato"},
  TipsType_PVETeamShareCodeError_Desc = {
    Text = "Nessun schieramento di <color=#5EF2FF>Indagine</color> trovato negli appunti"
  },
  TipsType_PVETeamShareCodeSaveTips_Desc = {
    Text = [[
Applicare la formazione presente nel codice formazione?
Gli oggetti non posseduti saranno lasciati vuoti.]]
  },
  TipsType_PVETeamShareCodeSaveTips_LeftBtnDesc = {Text = "Annulla"},
  TipsType_PVETeamShareCodeSaveTips_RightBtnDesc = {Text = "Conferma"},
  TipsType_PVETeamShareCodeSaveTips_Title = {
    Text = "Applica Formazione"
  },
  TipsType_PVETeamShareCodeSpecialTeamAssignTips_Desc = {
    Text = "Questa squadra contiene un Risvegliatore preimpostato. Il codice dello schieramento non può essere copiato o importato"
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_Desc = {
    Text = "La partita ha raggiunto il limite massimo di round. Il primo giocatore non è riuscito a porre Fine alla partita, decretando la sua sconfitta."
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_RightBtnDesc = {Text = "Conferma"},
  TipsType_PVPExceedMaxRoundsTips_Loser_Title = {
    Text = "Scontro terminato"
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_Desc = {
    Text = "La partita ha raggiunto il limite massimo di round. Il secondo giocatore ha resistito fino alla Fine, decretando la sua vittoria."
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_RightBtnDesc = {Text = "Conferma"},
  TipsType_PVPExceedMaxRoundsTips_Winner_Title = {
    Text = "Scontro terminato"
  },
  TipsType_PVPSurrenderConfirm_Desc = {
    Text = "Vuoi arrenderti?"
  },
  TipsType_PVPSurrenderConfirm_LeftBtnDesc = {Text = "Annulla"},
  TipsType_PVPSurrenderConfirm_RightBtnDesc = {Text = "Conferma"},
  TipsType_PVPSurrenderConfirm_Title = {
    Text = "Conferma resa"
  },
  TipsType_PVPTeamShareCodeError_Desc = {
    Text = "Nessun schieramento di <color=#5EF2FF>Traphase</color> trovato negli appunti"
  },
  TipsType_PVP_PasswordBattle_BlockTips_Desc = {
    Text = "Vuoi bloccare questo Custode?"
  },
  TipsType_PVP_PasswordBattle_BlockTips_LeftBtnDesc = {Text = "Rifiuta"},
  TipsType_PVP_PasswordBattle_BlockTips_RightBtnDesc = {Text = "Accetta"},
  TipsType_PVP_PasswordBattle_BlockTips_Title = {Text = "Blocco?"},
  TipsType_PVP_PasswordBattle_GameStartedTips_Desc = {
    Text = "Questa Modalità Password è già iniziata."
  },
  TipsType_PVP_PasswordBattle_OthersEnterTips_Desc = {
    Text = "Un nuovo custode è entrato in questo turno della battaglia crittografica"
  },
  TipsType_PVP_PasswordBattle_QueueTips_Desc = {Text = "In coda..."},
  TipsType_PVP_PasswordBattle_QuitTips_Desc = {
    Text = "Vuoi uscire dalla battaglia con password?"
  },
  TipsType_PVP_PasswordBattle_QuitTips_LeftBtnDesc = {Text = "Annulla"},
  TipsType_PVP_PasswordBattle_QuitTips_RightBtnDesc = {Text = "Esci"},
  TipsType_PVP_PasswordBattle_QuitTips_Title = {
    Text = "Conferma uscita"
  },
  TipsType_PVP_PasswordBattle_RejectedTips_Desc = {
    Text = "L'avversario ha rifiutato di combattere contro di te"
  },
  TipsType_PassportHoistTips1_Desc = {
    Text = "\"Ione Attivo Base\"\n·Dopo lo sblocco, durante questa stagione degli Argomenti Premium, i \"Punto di partenza della realtà\", \"Nucleo puro\", \"ESP\" e \"Argento\" ottenuti nelle ricompense cumulative degli \"Ione Attivo Base\" nelle \"Esercitazioni Giornaliere\" vengono triplicati. Dopo aver acquistato gli \"Argomenti Premium\", la parte della moltiplicazione bonus delle ricompense cumulative degli \"Ione Attivo Base\" già riscossi in questa stagione verrà assegnata retroattivamente."
  },
  TipsType_PassportHoistTips2_Desc = {
    Text = [[
Inversione Temporale:
Ritorna a uno qualsiasi degli ultimi 25 turni durante la battaglia. Questa funzione resta utilizzabile anche dopo aver ritentato la sfida.]]
  },
  TipsType_PassportHoistTips3_Desc = {
    Text = [[
Traphase:
Durante questa Stagione del Curriculum, tutte le carte sono sbloccate in Traphase (incluse quelle non ottenute.)]]
  },
  TipsType_Password_CopiedTips_Desc = {
    Text = "La <color=#5EF2FF>Password</color> è stata copiata negli appunti"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_Desc = {
    Text = "Vuoi acquistare consumando <Blue:\"Argento primordiale\" × {s1} >?\n\n<size=30><color=#ACBFCA>Quando si consuma \"Argento primordiale\", viene detratto prima quello ricevuto in omaggio.\n(Estratto: {s2}, In omaggio: {s3})</color></size>"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_LeftBtnDesc = {Text = "Annulla"},
  TipsType_PayMoneyBuyConfirmDescDetail_RightBtnDesc = {Text = "Acquista"},
  TipsType_PayMoneyBuyConfirmDescDetail_Title = {
    Text = "Conferma acquisto"
  },
  TipsType_PublishEmptyCommentTips_Desc = {
    Text = "Il contenuto del commento non può essere vuoto."
  },
  TipsType_PvpCollectionCommentDeleteTips_Desc = {
    Text = "Vuoi eliminare questo commento?"
  },
  TipsType_PvpCollectionCommentDeleteTips_LeftBtnDesc = {Text = "Annulla"},
  TipsType_PvpCollectionCommentDeleteTips_RightBtnDesc = {Text = "Conferma"},
  TipsType_PvpCollectionCommentDeleteTips_Title = {
    Text = "Conferma eliminazione"
  },
  TipsType_PvpHideCommentConfirm_Desc = {
    Text = "Nascondere tutti i commenti di questo Custode?"
  },
  TipsType_PvpHideCommentConfirm_LeftBtnDesc = {Text = "No"},
  TipsType_PvpHideCommentConfirm_RightBtnDesc = {Text = "Sì"},
  TipsType_PvpHideCommentConfirm_Title = {Text = "Nascosto"},
  TipsType_PvpMatchingInterruptTips_Desc = {
    Text = "Rilevata anomalia di rete, abbinamento interrotto."
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Desc = {
    Text = "Sei ancora in combattimento. Vuoi continuare la battaglia precedente? \n\"Il treno della Gioia sfrecciante\" è stato aggiornato. Continuare la sfida ti permetterà di completare le missioni della stagione più recente, ma non potrai accedere alla \"Lista VIP\"."
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_LeftBtnDesc = {Text = "Annulla"},
  TipsType_RailWayContinueReconnectSeasonSwitchTips_RightBtnDesc = {Text = "Conferma"},
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Title = {
    Text = "Indagine in corso"
  },
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Desc = {
    Text = "L'ultimo progresso della sfida è {s1} - Fase {s2} - Combattimento {s3}, hai ottenuto \"Punti VIP\" × {s4}\nLa stagione è stata aggiornata. Continuare la sfida ti permetterà di completare le missioni della stagione più recente, ma non potrai accedere alla \"Lista VIP\". Vuoi continuare la sfida?"
  },
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_LeftBtnDesc = {Text = "Annulla"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_RightBtnDesc = {Text = "Conferma"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Title = {
    Text = "Continua la Sfida"
  },
  TipsType_RailWayContinueSaveStage_Desc = {
    Text = [[
Riprendi i progressi: {s1} - Fase {s2} - Battaglia {s3}.
Punti VIP ottenuti: {s4}.
Continuare la sfida?]]
  },
  TipsType_RailWayContinueSaveStage_LeftBtnDesc = {Text = "Annulla"},
  TipsType_RailWayContinueSaveStage_RightBtnDesc = {Text = "Conferma"},
  TipsType_RailWayContinueSaveStage_Title = {
    Text = "Continua la Sfida"
  },
  TipsType_RailWayHaveSaveStage_Desc = {
    Text = "Devi completare la sfida salvata in precedenza prima di iniziarne una nuova"
  },
  TipsType_RailWaySaveAndExitInBattleTips_Desc = {
    Text = "Abbandonare la sfida?\nI progressi verranno salvati. Riprendendo, la battaglia attuale verrà riavviata."
  },
  TipsType_RailWaySaveAndExitInBattleTips_LeftBtnDesc = {Text = "Annulla"},
  TipsType_RailWaySaveAndExitInBattleTips_RightBtnDesc = {Text = "Conferma"},
  TipsType_RailWaySaveAndExitInBattleTips_Title = {
    Text = "Salva ed Esci"
  },
  TipsType_RailWaySaveAndExitTips_Desc = {
    Text = [[
Uscire adesso?
I progressi attuali verranno salvati e potrai scegliere di riprendere da qui la prossima volta.]]
  },
  TipsType_RailWaySaveAndExitTips_LeftBtnDesc = {Text = "Annulla"},
  TipsType_RailWaySaveAndExitTips_RightBtnDesc = {Text = "Conferma"},
  TipsType_RailWaySaveAndExitTips_Title = {
    Text = "Salva ed Esci"
  },
  TipsType_RailWaySeasonSwitchTips_Desc = {
    Text = "La stagione è stata aggiornata. Continuare la sfida ti permetterà di completare le missioni della stagione più recente, ma non potrai accedere alla \"Lista VIP\"."
  },
  TipsType_ReplayNullTips_Desc = {
    Text = "Le informazioni del replay non possono essere vuote"
  },
  TipsType_SchoolConflictTips_Desc = {
    Text = "Conflitto di Reame. Riorganizza la formazione."
  },
  TipsType_SelectedAwakensAndCardsExceedLimit_Desc = {
    Text = "Hai superato il numero selezionato"
  },
  TipsType_ServerRankDataLoading_Desc = {
    Text = "I dati della classifica non sono ancora stati caricati. Riprova ad aprire la schermata più tardi."
  },
  TipsType_ServerRankDataLoading_RightBtnDesc = {Text = "Conferma"},
  TipsType_ServerRankDataLoading_Title = {
    Text = "Inizializzazione dati classifica del server in corso"
  },
  TipsType_ShopBulkBuyConfirm_Desc = {
    Text = "<Blue:{s1}> {s2} verrà utilizzato per scambiare <Blue:{s3}> {s4}. Confermi il riscatto?"
  },
  TipsType_ShopBulkBuyConfirm_LeftBtnDesc = {Text = "Annulla"},
  TipsType_ShopBulkBuyConfirm_RightBtnDesc = {Text = "Conferma"},
  TipsType_ShopBulkBuyConfirm_Title = {
    Text = "Conferma Redenzione"
  },
  TipsType_SocialRecordHideTips_Desc = {
    Text = "I registri di battaglia sono nascosti"
  },
  TipsType_SteamOverlayEnabledTips_Desc = {
    Text = "Abilita l'opzione \"Abilita l'interfaccia di Steam durante il gioco\" nelle impostazioni di Steam in \"Impostazioni-In gioco\" e nelle proprietà del gioco in \"Proprietà-Generale\", poi riavvia il gioco e riprova."
  },
  TipsType_SteamOverlayEnabledTips_LeftBtnDesc = {Text = "Conferma"},
  TipsType_SteamOverlayEnabledTips_Title = {Text = "Nota"},
  TipsType_SteamRestartTips_Desc = {
    Text = "Autorizzazione Steam anomala. Riavvia il client Steam e riprova."
  },
  TipsType_SteamRestartTips_RightBtnDesc = {Text = "Conferma"},
  TipsType_SteamRestartTips_Title = {
    Text = "Anomalia di accesso"
  },
  TipsType_SubBestExperienceTips_Chapter3_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_SubBestExperienceTips_Chapter3_LeftBtnDesc = {Text = "Esci"},
  TipsType_SubBestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_SubBestExperienceTips_Chapter3_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_SubBestExperienceTips_Chapter5_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_SubBestExperienceTips_Chapter5_LeftBtnDesc = {Text = "Esci"},
  TipsType_SubBestExperienceTips_Chapter5_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_SubBestExperienceTips_Chapter5_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Desc = {
    Text = "Completa prima i seguenti livelli per un'esperienza ottimale"
  },
  TipsType_SubBestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "Esci"},
  TipsType_SubBestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "Procedi Comunque"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Title = {
    Text = "Continuare l'indagine?"
  },
  TipsType_SummonFailureTips_Desc = {
    Text = "I costi dei materiali di Risveglio sono cambiati, prova a eseguire un nuovo Risveglio"
  },
  TipsType_SummonPriorityNotEnoughTips_Desc = {
    Text = "Ti mancano {s1} <Blue:\"{s2}\">. Consumare <Blue:{s4} × {s3} > invece?"
  },
  TipsType_SummonPriorityNotEnoughTips_LeftBtnDesc = {Text = "Annulla"},
  TipsType_SummonPriorityNotEnoughTips_RightBtnDesc = {Text = "Conferma"},
  TipsType_SummonPriorityNotEnoughTips_Title = {
    Text = "Conferma Redenzione"
  },
  TipsType_SummonType_14SelectConfirm_BottomDesc = {
    Text = "<Blue:Nota: una volta effettuata, la scelta non potrà essere modificata per l'evento in corso!>"
  },
  TipsType_SummonType_14SelectConfirm_Desc = {
    Text = "Confermi la selezione dei Risvegliati <OrangeQuality:{s1}, {s2}, {s3}, {s4}>?"
  },
  TipsType_SummonType_14SelectConfirm_LeftBtnDesc = {Text = "Annulla"},
  TipsType_SummonType_14SelectConfirm_RightBtnDesc = {Text = "Conferma"},
  TipsType_SummonType_14SelectConfirm_Title = {
    Text = "Conferma selezione"
  },
  TipsType_SummonType_14SelectLimitTips_BottomDesc = {
    Text = "<Blue:Nota: una volta effettuata, la scelta non potrà essere modificata per l'evento in corso!>"
  },
  TipsType_SummonType_14SelectLimitTips_Desc = {
    Text = "Limite di selezione raggiunto"
  },
  TipsType_SummonType_17IncompleteSelectionTips_Desc = {
    Text = "Completa tutte le selezioni prima di riprovare"
  },
  TipsType_SummonType_17SelectConfirm_Desc = {
    Text = "Confermare il completamento della selezione del Risvegliatore designato?\nUna volta confermata, la selezione di questo periodo non potrà essere modificata."
  },
  TipsType_SummonType_17SelectConfirm_LeftBtnDesc = {Text = "Annulla"},
  TipsType_SummonType_17SelectConfirm_RightBtnDesc = {Text = "Conferma"},
  TipsType_SummonType_17SelectConfirm_Title = {
    Text = "Conferma selezione"
  },
  TipsType_SupportListLatestTips_Desc = {
    Text = "Sei già aggiornato, vai a seguire altri ex compagni di scuola per ottenere più scelte di Supporto!"
  },
  TipsType_TrinketAutoRefineExitTips_Desc = {
    Text = "Trascrizione Automatica in corso, operazione non disponibile."
  },
  TipsType_TrinketAutoRefineTips_BottomDesc = {
    Text = "(La Trascrizione Automatica si interrompe quando una statistica sbloccata raggiunge 8.)"
  },
  TipsType_TrinketAutoRefineTips_Desc = {
    Text = [[
Trascrivi fino a {s1} volte
Consuma fino a]]
  },
  TipsType_TrinketAutoRefineTips_LeftBtnDesc = {Text = "Annulla"},
  TipsType_TrinketAutoRefineTips_RightBtnDesc = {Text = "Conferma"},
  TipsType_TrinketAutoRefineTips_Title = {
    Text = "Conferma Trascrizione Automatica"
  },
  TipsType_TrinketBagFullTips_Desc = {
    Text = "Lo zaino dei Patti è pieno"
  },
  TipsType_TrinketBatchUnbindTips_Desc = {
    Text = "Sciogliere tutti i Patti?"
  },
  TipsType_TrinketBatchUnbindTips_LeftBtnDesc = {Text = "Annulla"},
  TipsType_TrinketBatchUnbindTips_RightBtnDesc = {Text = "Conferma"},
  TipsType_TrinketBatchUnbindTips_Title = {
    Text = "Conferma Scioglimento"
  },
  TipsType_TrinketBindSaveTips_Desc = {
    Text = "Ci sono Patti vincolati, impossibile salvare come piano!"
  },
  TipsType_TrinketBindTips_Desc = {
    Text = "Confermi la combinazione dei seguenti Patti? I Patti già equipaggiati da altri Risvegliatori o presenti in formazioni/schemi/supporto verranno rimossi automaticamente."
  },
  TipsType_TrinketBindTips_LeftBtnDesc = {Text = "Annulla"},
  TipsType_TrinketBindTips_RightBtnDesc = {Text = "Conferma"},
  TipsType_TrinketBindTips_Title = {
    Text = "Conferma Modifica Vincolo"
  },
  TipsType_TrinketChangeBindTips_Desc = {
    Text = "Confermare la modifica del vincolo?"
  },
  TipsType_TrinketChangeBindTips_LeftBtnDesc = {Text = "Annulla"},
  TipsType_TrinketChangeBindTips_RightBtnDesc = {Text = "Conferma"},
  TipsType_TrinketChangeBindTips_Title = {
    Text = "Modifica Conferma Vincolo"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_Desc = {
    Text = [[
Sciogliere tutti i set di Patti?

<color=#9BA3A2><size=30>Inclusi +12 frammenti di Patto.</size></color>]]
  },
  TipsType_TrinketHighLevelBatchUnbindTips_LeftBtnDesc = {Text = "Annulla"},
  TipsType_TrinketHighLevelBatchUnbindTips_RightBtnDesc = {Text = "Conferma"},
  TipsType_TrinketHighLevelBatchUnbindTips_Title = {
    Text = "Conferma Scioglimento"
  },
  TipsType_TrinketHighLevelChangeBindTips_Desc = {
    Text = [[
Confermare la modifica?

<color=#9BA3A2><size=30>Inclusi +12 frammenti di Patto.</size></color>]]
  },
  TipsType_TrinketHighLevelChangeBindTips_LeftBtnDesc = {Text = "Annulla"},
  TipsType_TrinketHighLevelChangeBindTips_RightBtnDesc = {Text = "Conferma"},
  TipsType_TrinketHighLevelChangeBindTips_Title = {
    Text = "Modifica Conferma Vincolo"
  },
  TipsType_TrinketHighLevelUnbindTips_Desc = {
    Text = [[
Sciogliere questo set di Patti?

<color=#9BA3A2><size=30>Inclusi +12 frammenti di Patto.</size></color>]]
  },
  TipsType_TrinketHighLevelUnbindTips_LeftBtnDesc = {Text = "Annulla"},
  TipsType_TrinketHighLevelUnbindTips_RightBtnDesc = {Text = "Conferma"},
  TipsType_TrinketHighLevelUnbindTips_Title = {
    Text = "Conferma Scioglimento"
  },
  TipsType_TrinketUnbindTips_Desc = {
    Text = "Confermi lo scioglimento di questo Patto?"
  },
  TipsType_TrinketUnbindTips_LeftBtnDesc = {Text = "Annulla"},
  TipsType_TrinketUnbindTips_RightBtnDesc = {Text = "Conferma"},
  TipsType_TrinketUnbindTips_Title = {
    Text = "Conferma Scioglimento"
  },
  TipsType_TryAgainLaterTips_Desc = {
    Text = "La <color=#5EF2FF>Password</color> è attualmente in uso, riprova più tardi"
  },
  TipsType_WaitOppositeSideAccept_Desc = {
    Text = [[
In attesa che
{s1}
accetti l'invito <Blue:{s2}>...]]
  },
  TipsType_WaitOppositeSideAccept_LeftBtnDesc = {Text = "Annulla"},
  TipsType_WaitOppositeSideAccept_Title = {
    Text = "Modalità Password"
  },
  TipsType_WaitOthersEnter_Desc = {
    Text = [[
In attesa che altri Custodi entrino
<Blue:{s1}>
Battaglia con Password di abbinamento]]
  },
  TipsType_WaitOthersEnter_LeftBtnDesc = {Text = "Annulla"},
  TipsType_WaitOthersEnter_RightBtnDesc = {
    Text = "Copia <color=#5EF2FF>password</color>"
  },
  TipsType_WaitOthersEnter_Title = {
    Text = "Modalità Password"
  },
  TipsType_WeaponRandomChestConfirm_Desc = {
    Text = "Confermi l'utilizzo di <Blue:{s1}> per ottenere 1 Ruota del destino <Blue:casuale>?"
  },
  TipsType_WeaponRandomChestConfirm_LeftBtnDesc = {Text = "Annulla"},
  TipsType_WeaponRandomChestConfirm_RightBtnDesc = {Text = "Conferma"},
  TipsType_WeaponRandomChestConfirm_Title = {
    Text = "Conferma utilizzo"
  },
  TipsType_WeekChallengeSweepTips_Desc = {
    Text = "Il numero di ricompense ottenibili questa settimana è stato esaurito, impossibile rieseguire."
  }
})
return Text_TipsType
