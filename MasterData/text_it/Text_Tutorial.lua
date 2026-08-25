__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Tutorial = readonly({
  Tutorial_120371_Desc_1 = {
    Text = "Puoi tornare a uno qualsiasi degli ultimi 25 turni in battaglia."
  },
  Tutorial_120371_Title_1 = {
    Text = "Inversione Temporale"
  },
  Tutorial_124999_Desc_1 = {
    Text = "Nella modalità <TutorialHighlight:Traphase-Modalità Selezione a Turno>, clicca \"Avvia ricerca avversario\" nell'angolo in basso a destra dell'interfaccia per entrare nel matchmaking senza dover costruire una squadra in anticipo."
  },
  Tutorial_124999_Desc_2 = {
    Text = "Prima dell'inizio del match, viene scelto casualmente un <TutorialHighlight:Reliquia> che influenzerà la battaglia imminente. I giocatori poi selezionano a turno Risvegliatori, Ruote del destino e Seguiti da un pool limitato per comporre le proprie formazioni. Per modificare la tua strategia, clicca su due Risvegliatori qualsiasi per scambiarne le posizioni (numerate da 1 a 4, dalla prima all'ultima linea)."
  },
  Tutorial_124999_Desc_3 = {
    Text = "Per modificare la formazione, clicca su due Risvegliatori qualsiasi per scambiarne le posizioni (numerate da 1 a 4, dalla prima all'ultima linea)."
  },
  Tutorial_124999_Title_1 = {
    Text = "Formazione Modalità Selezione a Turno"
  },
  Tutorial_126878_Desc_1 = {
    Text = "Quando l'Impulso della Psiche di determinati Risvegliatori raggiunge +12, ottengono automaticamente l'effetto \"Assioma Assoluto\", che varia per ciascun Risvegliatore."
  },
  Tutorial_126878_Desc_2 = {
    Text = "Dopo aver sbloccato l'\"Assioma Assoluto\" del Risvegliatore, riceverai un messaggio esclusivo dal Risvegliatore. Ricorda di leggerlo!"
  },
  Tutorial_126878_Title_1 = {
    Text = "Assioma assoluto"
  },
  Tutorial_126878_Title_2 = {
    Text = "Messaggio esclusivo"
  },
  Tutorial_148475_Desc_1 = {
    Text = "Dopo che l'Affinità del Risvegliatore raggiunge <TutorialHighlight:Lv20>, è possibile ottenere la <TutorialHighlight:Scintilla> esclusiva."
  },
  Tutorial_148475_Desc_2 = {
    Text = "La <TutorialHighlight:Scintilla> è la prova dell'Unione Sacra tra te e il Risvegliatore."
  },
  Tutorial_148475_Desc_3 = {
    Text = "D'ora in poi, le Carte di comando di questo Risvegliatore avranno una presentazione speciale in battaglia e potranno essere mostrate agli altri Custodi nelle occasioni sociali."
  },
  Tutorial_148475_Title_1 = {
    Text = "Unione Sacra"
  },
  Tutorial_17805_Desc_1 = {
    Text = "Tocca un nemico per visualizzare tutti i suoi stati. Gli stati di <TutorialHighlight:Avvertimento> richiedono particolare attenzione poiché rappresentano meccaniche uniche del nemico. La maggior parte dei casi in cui i Custodi non riescono a completare le indagini è spesso dovuta alla negligenza di queste meccaniche."
  },
  Tutorial_17805_Title_1 = {
    Text = "Stato del Nemico"
  },
  Tutorial_17806_Desc_1 = {
    Text = "Dopo aver sconfitto un nemico, puoi scegliere di eseguire un'<TutorialHighlight:Orazione>, oppure spendere il <TutorialHighlight:Sigillo Nero> presso il <TutorialHighlight:D-segno> per effettuare acquisti. L'Orazione conferisce diversi effetti aggiuntivi a specifiche Carte di comando. Ogni specifica Carta di comando può essere inscritta con un'Orazione solo fino a <TutorialHighlight:1> volta. Applica le Orazioni alle Carte di comando che utilizzi più frequentemente per massimizzarne l'effetto."
  },
  Tutorial_17806_Title_1 = {Text = "Orazione"},
  Tutorial_17807_Desc_1 = {
    Text = "Fornisce attributi multipli al Risvegliatore. Gli effetti speciali si attivano formando un <TutorialHighlight:set>. Ci sono 6 parti, ciascuna con diversi <TutorialHighlight:attributi principali>. Tasso critico e Danno critico compaiono nelle parti I, II e III; Livello di rigenerazione Aliemus e Livello di Ricarica della chiave d'argento compaiono nelle parti I, IV e V; Padronanza del Reame e Bottino di Sigilli compaiono nelle parti II, IV e VI; Amplificazione del Danno e Resistenza compaiono nelle parti III, V e VI."
  },
  Tutorial_17807_Title_1 = {Text = "Patto"},
  Tutorial_17808_Desc_1 = {
    Text = "Nella modalità <TutorialHighlight:Immersione Fantasmatica>, ogni volta che affronti uno stage, entrerai in una mappa casuale. Dopo aver completato con successo la sfida, otterrai punti corrispondenti in base alla difficoltà dello stage, ai Risvegliati potenziati e agli oggetti punteggio presenti nello stage. Le sfide di ogni settimana presenteranno reliquie iniziali e Risvegliati potenziati differenti."
  },
  Tutorial_17808_Desc_2 = {
    Text = "La <TutorialHighlight:Classifica esplorazione> si basa sui punteggi più alti ottenuti nelle sfide settimanali, e la classifica di esplorazione viene calcolata settimanalmente con le relative ricompense distribuite. La <TutorialHighlight:Classifica stagionale> si basa sui punteggi più alti raggiunti durante la stagione."
  },
  Tutorial_17808_Desc_3 = {
    Text = "Il Registro dell'Immersione Profonda ha molteplici obiettivi e al loro completamento si possono ottenere ricompense. Ogni volta che completi un obiettivo del \"Registro dell'Immersione Profonda\" o vinci una sfida di Immersione Fantasmatica, puoi guadagnare <TutorialHighlight:EXP Immersione Profonda>. Quando la tua EXP Immersione Profonda raggiunge un certo valore, il <TutorialHighlight:Livello Immersione Profonda> aumenterà, permettendoti di ricevere varie ricompense. Puoi controllare il tuo \"Registro dell'Immersione Profonda\" e il \"Livello Immersione Profonda\" nell'angolo in basso a sinistra dell'interfaccia."
  },
  Tutorial_17808_Title_1 = {
    Text = "Immersione Fantasmatica"
  },
  Tutorial_17809_Desc_1 = {
    Text = "Puoi ottenere <TutorialHighlight:Reliquie> tramite eventi e D-Mark. Queste Reliquie possono potenziare le abilità di combattimento della tua squadra. I Custodi esperti spesso selezionano <TutorialHighlight:Reliquie> più adatte in base alle esigenze della propria squadra."
  },
  Tutorial_17809_Title_1 = {Text = "Reliquia"},
  Tutorial_17810_Desc_1 = {
    Text = "Dissolve la nebbia, aumenta la visione sulla mappa di <TutorialHighlight:2> caselle, consentendo una migliore pianificazione del percorso."
  },
  Tutorial_17810_Title_1 = {Text = "Riflettore"},
  Tutorial_17811_Desc_1 = {
    Text = "I bersagli in stato di <TutorialHighlight:Avvelenamento> subiscono danni pari al numero di cariche di <TutorialHighlight:Veleno> alla fine del turno. Il danno da <TutorialHighlight:Veleno> <TutorialHighlight:non può essere critico>."
  },
  Tutorial_17811_Title_1 = {Text = "Veleno"},
  Tutorial_17812_Desc_1 = {
    Text = "I bersagli in stato <TutorialHighlight:Vulnerabile> subiscono il 50% di danni in più e perdono automaticamente 1 carica di <TutorialHighlight:Vulnerabile> alla fine del turno. Approfitta dello stato <TutorialHighlight:Vulnerabile> dei nemici per infliggere danni maggiori."
  },
  Tutorial_17812_Title_1 = {
    Text = "Vulnerabile"
  },
  Tutorial_17813_Desc_1 = {
    Text = "Dopo aver completato i livelli delle \"Rovine della Dissoluzione\", del \"Patto Proibito\" e del \"Dominio Arcano\", puoi <TutorialHighlight:Ricostituire> i livelli. Utilizzando la <TutorialHighlight:Ricostituzione>, puoi ottenere rapidamente le ricompense dei livelli."
  },
  Tutorial_17813_Title_1 = {
    Text = "Ricostituzione"
  },
  Tutorial_17814_Desc_1 = {
    Text = "Lo <TutorialHighlight:Scudo> può bloccare i danni. Lo Scudo viene <TutorialHighlight:rimosso automaticamente> alla fine del turno. Il limite dello Scudo è pari ai <TutorialHighlight:PV massimi> della squadra. Cerca di <TutorialHighlight:far corrispondere lo Scudo totale al danno totale in arrivo in questo turno> e vinci la battaglia."
  },
  Tutorial_17814_Title_1 = {Text = "Scudo"},
  Tutorial_17815_Desc_1 = {
    Text = "Ottenere ripetutamente dei Risvegliatori li convertirà in <TutorialHighlight:Frammenti>. Consumando i <TutorialHighlight:Frammenti> per potenziare il Livello di Illuminazione del Risvegliatore, si conferiranno abilità speciali aggiuntive alle abilità del Risvegliatore. Quando il Livello di Illuminazione del Risvegliatore raggiunge il massimo, i Frammenti corrispondenti ottenuti verranno convertiti in <TutorialHighlight:Frammenti Riavvolgi Anima>."
  },
  Tutorial_17815_Title_1 = {Text = "Frammento"},
  Tutorial_17816_Desc_1 = {
    Text = "L'Arithmetica è <TutorialHighlight:condivisa dall'intera squadra>; giocare carte consuma <TutorialHighlight:Arithmetica>. L'Arithmetica <TutorialHighlight:si ricarica automaticamente al massimo all'inizio di ogni turno> e viene <TutorialHighlight:azzerata automaticamente> alla fine del turno. Per massimizzare l'efficienza dell'Arithmetica, cerca di <TutorialHighlight:esaurire tutta l'Arithmetica prima di terminare il turno>."
  },
  Tutorial_17816_Title_1 = {
    Text = "Arithmetica"
  },
  Tutorial_17817_Desc_1 = {
    Text = "Sconfiggi i nemici nel <TutorialHighlight:Dominio Arcano> per ottenere <TutorialHighlight:Materiali di Potenziamento Abilità> premium. Le ricompense possono essere riscattate una volta a settimana. Vari materiali possono anche essere sintetizzati e scambiati nell'<TutorialHighlight:Alchimia>."
  },
  Tutorial_17817_Title_1 = {
    Text = "Dominio Arcano"
  },
  Tutorial_17818_Desc_1 = {
    Text = "Può essere utilizzato nelle <TutorialHighlight:Scorte> al momento dell'acquisizione, aumentando rapidamente il livello del Risvegliatore e il livello delle abilità secondo valori preimpostati."
  },
  Tutorial_17818_Title_1 = {
    Text = "Amplificatore di gnosi"
  },
  Tutorial_17819_Desc_1 = {
    Text = "Quando l'Aliemus di un Risvegliatore raggiunge <TutorialHighlight:100>, può scatenare l'<TutorialHighlight:Esaltazione>. Risvegliatori diversi possiedono effetti di Esaltazione differenti. Usali con saggezza per ottenere <TutorialHighlight:il doppio del risultato con la metà dello sforzo>."
  },
  Tutorial_17819_Title_1 = {
    Text = "Esaltazione"
  },
  Tutorial_17820_Desc_1 = {
    Text = "I bersagli in stato di <TutorialHighlight:Fragile> subiscono una riduzione del 25% dell'efficacia dello scudo, e 1 accumulo di <TutorialHighlight:Fragile> viene rimosso alla fine del turno. Se la tua squadra è in stato di <TutorialHighlight:Fragile>, assicurati di rimuovere lo stato di <TutorialHighlight:Fragile> prima di tentare di difendere, oppure modifica la tua strategia per concentrarti sull'offensiva aggressiva in questo turno."
  },
  Tutorial_17820_Title_1 = {Text = "Fragile"},
  Tutorial_17821_Desc_1 = {
    Text = "Equipaggiare il Risvegliatore con la <TutorialHighlight:Ruota del destino> può potenziare gli attributi del Risvegliatore e sbloccare abilità speciali."
  },
  Tutorial_17821_Title_1 = {
    Text = "Ruota del destino"
  },
  Tutorial_17822_Desc_1 = {
    Text = "I bersagli in stato di <TutorialHighlight:Sanguinamento> subiscono danni pari agli <TutorialHighlight:accumuli> di Sanguinamento alla fine del turno, dopodiché lo <TutorialHighlight:stato di Sanguinamento viene rimosso>.\nIl <TutorialHighlight:Recupero PV> rimuove una quantità di accumuli di Sanguinamento pari al <TutorialHighlight:doppio dell'ammontare di Guarigione>. Il danno da Sanguinamento <TutorialHighlight:non può essere critico>."
  },
  Tutorial_17822_Title_1 = {
    Text = "Sanguinamento"
  },
  Tutorial_17823_Desc_1 = {
    Text = "I Risvegliatori del Caos possono <TutorialHighlight:infrangere le restrizioni di reame> e formare formazioni con Risvegliatori di altri reami, fornendo effetti simbiotici differenti. Qualsiasi formazione che includa un Risvegliatore del Caos ottiene un ulteriore 100% di Resistenza alla Morte."
  },
  Tutorial_17823_Desc_2 = {
    Text = "Rispetto ad altri team di Reame, i team del Reame del Caos ottengono Keyflare più rapidamente e possono selezionare tra tutti i Posse disponibili al rilascio del secondo Posse, e il Posse selezionato si attiverà due volte. Pertanto, i team del Reame del Caos si affidano maggiormente alla coordinazione tra i Posse, e scegliere il Posse giusto può potenziare enormemente la forza di un team del Reame del Caos!"
  },
  Tutorial_17823_Title_1 = {Text = "Caos"},
  Tutorial_17824_Desc_1 = {
    Text = "Per ogni punto di <TutorialHighlight:Allerta>, si ottiene 1 punto aggiuntivo di Scudo quando si riceve uno Scudo."
  },
  Tutorial_17824_Title_1 = {Text = "Allerta"},
  Tutorial_17825_Desc_1 = {
    Text = "Dopo aver completato la prima Indagine, puoi ottenere <TutorialHighlight:Materiali di Attivazione della Risonanza>, utilizzabili per attivare potenti <TutorialHighlight:Risonanze>. Questa Risonanza avrà effetto in tutte le fasi di questo capitolo."
  },
  Tutorial_17825_Title_1 = {Text = "Risonanza"},
  Tutorial_17826_Desc_1 = {
    Text = "Quando la tua squadra è sotto lo stato di <TutorialHighlight:Sigillo Aliemus>, non è possibile scatenare l'Esaltazione. Usa l'Esaltazione prima che il nemico infligga il <TutorialHighlight:Sigillo Aliemus> per evitare di sprecare Aliemus."
  },
  Tutorial_17826_Title_1 = {
    Text = "Sigillo Aliemus"
  },
  Tutorial_17827_Desc_1 = {
    Text = "Consuma <TutorialHighlight:Elisir di gnosi> per aumentare il livello del Risvegliatore. Il potenziamento migliora gli attributi del Risvegliatore. Una volta raggiunto il livello massimo, è necessario eseguire l'Edificazione per innalzare il limite di livello del Risvegliatore."
  },
  Tutorial_17827_Title_1 = {
    Text = "Elisir di gnosi"
  },
  Tutorial_17828_Desc_1 = {
    Text = "Per ogni punto di <TutorialHighlight:FOR▼>, il <TutorialHighlight:Danno attivo> inflitto è ridotto di 1."
  },
  Tutorial_17828_Title_1 = {Text = "FOR▼"},
  Tutorial_17829_Desc_1 = {
    Text = "Prima di subire danni, si ottiene Immunità ai Danni e si rimuove 1 <TutorialHighlight:Barriera>. Più alto è il singolo colpo subito, maggiore è il beneficio della <TutorialHighlight:Barriera>."
  },
  Tutorial_17829_Title_1 = {Text = "Barriera"},
  Tutorial_17830_Desc_1 = {
    Text = "I bersagli in stato di <TutorialHighlight:Debolezza> infliggono il 25% di Danno in meno, e 1 accumulo di <TutorialHighlight:Debolezza> viene rimosso automaticamente alla fine del turno. Se il tuo team è in stato di <TutorialHighlight:Debolezza>, ricorda di provare a rimuovere lo stato di <TutorialHighlight:Debolezza> prima di attaccare, oppure cambia la Strategia concentrandoti sulla difesa totale in questo turno."
  },
  Tutorial_17830_Title_1 = {Text = "Debolezza"},
  Tutorial_17831_Desc_1 = {
    Text = "Sconfiggi i nemici nel <TutorialHighlight:Patto Proibito> per ottenere <TutorialHighlight:Patti> che potenziano le capacità del Risvegliatore. Ogni volta che si Azzera un capitolo della storia principale, si sbloccano nuovi Stadi del <TutorialHighlight:Patto Proibito>. I Patti possono essere ottenuti anche tramite il negozio."
  },
  Tutorial_17831_Title_1 = {
    Text = "Patto Proibito"
  },
  Tutorial_17832_Desc_1 = {
    Text = "Una copia temporanea della <TutorialHighlight:prima> Carta di comando giocata ogni turno dal team Ultra entra nello <TutorialHighlight:Spazio Ultra> e attiva potenti effetti di salto. Quando lo Spazio Ultra raggiunge il suo limite, si ottiene 1 <TutorialHighlight:Turno Ultra> aggiuntivo, durante il quale <TutorialHighlight:tutti gli effetti di salto vengono attivati>. La chiave per padroneggiare il Team Ultra: pianifica attentamente la prima carta giocata ogni turno."
  },
  Tutorial_17832_Title_1 = {Text = "Ultra"},
  Tutorial_17833_Desc_1 = {
    Text = "Quando i PV della tua squadra si esauriscono, puoi attivare il <TutorialHighlight:Corpo di Gnosi d'Emergenza> per ripristinare tutti gli Stati. Il Corpo di Gnosi d'Emergenza recupera automaticamente <TutorialHighlight:1> unità al giorno, con un massimo di <TutorialHighlight:5>. Usa il Corpo di Gnosi d'Emergenza con saggezza nelle <TutorialHighlight:Battaglie ad Alta Difficoltà> ed evita di sprecarlo con leggerezza."
  },
  Tutorial_17833_Title_1 = {
    Text = "Corpo di Gnosi d'Emergenza"
  },
  Tutorial_17834_Desc_1 = {
    Text = "Cerca con attenzione i punti debolmente luminescenti sulla mappa; indagarli potrebbe portare a un Guadagno Inaspettato."
  },
  Tutorial_17834_Title_1 = {
    Text = "Punto di Estrazione"
  },
  Tutorial_17835_Desc_1 = {
    Text = "Rappresenta il danno totale inflitto da tutti i nemici in questo turno. Un consiglio di combattimento semplice e pratico per i Custodi: <TutorialHighlight:Rendi il tuo scudo pari al danno totale dei nemici>."
  },
  Tutorial_17835_Title_1 = {
    Text = "DAN Totale del Nemico"
  },
  Tutorial_17837_Desc_1 = {
    Text = "Quando la <TutorialHighlight:Fusione Embrionale> della squadra Caro raggiunge il suo limite, otterrai 1 <TutorialHighlight:\"Embrione\">. Scatenare l'Esaltazione consuma <TutorialHighlight:\"Embrione\"> per attivare un potente Effetto <TutorialHighlight:Divorare>. Pertanto, cerca di Scatenare l'Esaltazione quando hai <TutorialHighlight:\"Embrione\"> nella tua Mano; altrimenti, non potrai sfruttare appieno il potenziale della squadra Caro."
  },
  Tutorial_17837_Desc_2 = {
    Text = "Dopo ogni battaglia, il 5% della guarigione basata sui PV massimi viene accumulato nella Fornace Cremisi. Se ci sono <TutorialHighlight:Embrioni> inutilizzati, ogni Embrione contribuisce anch'esso con il 5% della guarigione basata sui PV massimi alla Fornace. La Fornace Cremisi può essere usata per ripristinare i PV del gruppo, e può essere convertita in guarigione una volta per turno. Il Custode deve pianificare attentamente quando usare la Fornace Cremisi per ribaltare le sorti della battaglia."
  },
  Tutorial_17837_Title_1 = {Text = "Caro"},
  Tutorial_17838_Desc_1 = {
    Text = "Alla Giunzione, puoi scegliere di ripristinare il 50% degli HP persi della tua squadra o Risvegliare 1 Risvegliato. Scegli Recupero PV quando i PV della squadra sono bassi; altrimenti, scegli di Destare un Risvegliato."
  },
  Tutorial_17838_Title_1 = {Text = "Crocevia"},
  Tutorial_17839_Desc_1 = {
    Text = "Una struttura in cui consumare Sigilli Neri per potenziare la tua squadra. Di norma offre uno slot per un'Orazione, uno per una Reliquia d'argento e uno per una Reliquia dorata. Se non sono disponibili oggetti desiderati, clicca su <TutorialHighlight:Aggiornamento> e i D-Mark genereranno nuove opzioni."
  },
  Tutorial_17839_Title_1 = {Text = "D-segno"},
  Tutorial_17840_Desc_1 = {
    Text = "Forzare il passaggio attraverso l'<TutorialHighlight:Illusione> ti infetterà con un \"Sintomo\"."
  },
  Tutorial_17840_Title_1 = {Text = "Illusione"},
  Tutorial_17841_Desc_1 = {
    Text = "L'utilizzo delle Carte di comando consente ai Risvegliatori di accumulare <TutorialHighlight:Aliemus>. Più alto è il livello dell'abilità della Carta di comando, maggiore sarà l'Aliemus ottenuto."
  },
  Tutorial_17841_Title_1 = {Text = "Aliemus"},
  Tutorial_17842_Desc_1 = {
    Text = "Sconfiggere nemici o indagare eventi può concedere <TutorialHighlight:Sigilli Neri>. L'attributo <TutorialHighlight:Bottino di Sigilli> di un Risvegliato aumenta il numero di Sigilli Neri ottenuti."
  },
  Tutorial_17842_Desc_2 = {
    Text = "Nel D-Mark puoi consumare <TutorialHighlight:Sigilli Neri> per acquistare Orazioni e Reliquie, o risvegliare i Risvegliati. Prima della Battaglia finale, assicurati di spendere tutti i Sigilli Neri per potenziare la tua squadra."
  },
  Tutorial_17842_Title_1 = {
    Text = "Sigillo Nero"
  },
  Tutorial_17843_Desc_1 = {
    Text = "Quando si subisce un attacco, infligge all'attaccante un danno pari al numero di cariche di <TutorialHighlight:Contatore>. Il danno da <TutorialHighlight:Contatore> non può infliggere colpi critici."
  },
  Tutorial_17843_Title_1 = {Text = "Contatore"},
  Tutorial_17844_Desc_1 = {
    Text = "Per ogni punto di <TutorialHighlight:Forza>, il danno inflitto aumenta di 1 punto aggiuntivo con ogni attacco attivo."
  },
  Tutorial_17844_Title_1 = {Text = "Forza"},
  Tutorial_17845_Desc_1 = {
    Text = "Assegna i Risvegliatori al completamento di incarichi di ricerca per ricevere le ricompense corrispondenti. Più alto è il <TutorialHighlight:livello totale> dei Risvegliatori assegnati, migliori saranno le ricompense, con un calcolo massimo basato su un livello totale di 240."
  },
  Tutorial_17845_Title_1 = {Text = "Incarico"},
  Tutorial_17847_Desc_1 = {
    Text = "Quando si subisce un Danno Fatale, c'è una <TutorialHighlight:probabilità pari alla Resistenza alla Morte> di diventare immune al danno e conservare 1 PV, <TutorialHighlight:con la Resistenza alla Morte dimezzata dopo un'attivazione riuscita>. La Resistenza alla Morte della squadra equivale alla somma della Resistenza alla Morte di tutti i Risvegliati; aumentare la Resistenza alla Morte della squadra migliora la tolleranza agli errori in battaglia."
  },
  Tutorial_17847_Title_1 = {Text = "Resistenza"},
  Tutorial_17848_Desc_1 = {
    Text = "All'inizio di una battaglia del team Aequor, viene generato 1 <TutorialHighlight:Tentacolo>. Il <TutorialHighlight:Tentacolo> attacca i nemici in prima fila alla fine del turno. Puoi verificare il Danno attuale del Tentacolo e il numero di attacchi tramite la formula sotto l'icona del Tentacolo. Alcuni Awakener possono aumentare il Numero di Tentacoli e il loro Danno, infliggendo danni significativi alla fine del turno."
  },
  Tutorial_17848_Title_1 = {Text = "Aequor"},
  Tutorial_17850_Desc_1 = {
    Text = "Giocare carte consuma Arithmetica. Alla fine del turno, tutte le carte verranno spostate nella <TutorialHighlight:Pila degli scarti>. Pianificare adeguatamente l'<TutorialHighlight:ordine di gioco delle carte> sarà la chiave per la vittoria in battaglia."
  },
  Tutorial_17850_Title_1 = {Text = "Mano"},
  Tutorial_17851_Desc_1 = {
    Text = "Rappresenta l'azione che il nemico compirà nel turno successivo. Sfruttare l'<TutorialHighlight:Intenzione> per prendere decisioni durante il turno corrente è la meccanica di gioco fondamentale della battaglia."
  },
  Tutorial_17851_Title_1 = {
    Text = "Intenzione del Nemico"
  },
  Tutorial_17852_Desc_1 = {
    Text = "Il <TutorialHighlight:Potenziamento Abilità> può migliorare gli attributi del Risvegliato e potenziare gli effetti delle Carte di comando. Cliccando \"Livello successivo\" nell'interfaccia Abilità del Risvegliato è possibile visualizzare in anteprima l'effetto potenziato."
  },
  Tutorial_17852_Desc_2 = {
    Text = "Risvegliati di Reami diversi richiedono differenti <TutorialHighlight:Materiali di Potenziamento Abilità>."
  },
  Tutorial_17852_Title_1 = {
    Text = "Potenziamento Abilità"
  },
  Tutorial_20768_Desc_1 = {
    Text = "Quando un Risvegliatore consuma Arithmetica, ottiene <TutorialHighlight:Keyflare>. L'attributo <TutorialHighlight:Ricarica della chiave d'argento> aumenta la quantità di <TutorialHighlight:Keyflare> ottenuta."
  },
  Tutorial_20768_Title_1 = {Text = "Keyflare"},
  Tutorial_20769_Desc_1 = {
    Text = "La <TutorialHighlight:Porta arrugginita> blocca importanti percorsi d'indagine. Cerca sulla mappa un oggetto chiamato <TutorialHighlight:Chiave arrugginita>, che può essere usato per aprire la <TutorialHighlight:Porta arrugginita>."
  },
  Tutorial_20769_Title_1 = {
    Text = "Porta arrugginita"
  },
  Tutorial_20770_Desc_1 = {
    Text = "La <TutorialHighlight:Chiave arrugginita> può aprire la <TutorialHighlight:Porta arrugginita> che blocca il tuo cammino."
  },
  Tutorial_20770_Title_1 = {
    Text = "Chiave arrugginita"
  },
  Tutorial_20771_Desc_1 = {
    Text = "Il <TutorialHighlight:Reame Senza Luce> contiene una serie di fasi distribuite in quattro reami. Completarle garantisce ricompense come Argento ed Elisir di gnosi. Inoltre, raggiungere la valutazione in stelle totale richiesta sblocca ricompense aggiuntive come Argento e Nucleo puro!"
  },
  Tutorial_20771_Desc_2 = {
    Text = "Le diverse fasi della Fessura del Reame impongono requisiti sul Reame del Risvegliato all'interno della squadra d'indagine. Solo le squadre che <TutorialHighlight:soddisfano i requisiti> possono procedere con l'indagine."
  },
  Tutorial_20771_Title_1 = {
    Text = "Reame Senza Luce"
  },
  Tutorial_20772_Desc_1 = {
    Text = "Quando il Keyflare raggiunge <TutorialHighlight:1000>, puoi scatenare il tuo <TutorialHighlight:Seguito>. Puoi scatenare il Seguito due volte per turno. Durante il secondo scatenamento, devi selezionare 1 tra 3 opzioni casuali di Seguito, e il Seguito scelto non potrà essere riutilizzato durante questa indagine. Selezionare il Seguito appropriato per la tua squadra durante la formazione può rendere il processo d'indagine più agevole."
  },
  Tutorial_20772_Title_1 = {Text = "Posse"},
  Tutorial_20773_Desc_1 = {
    Text = "Consumare la stessa <TutorialHighlight:Ruota del destino> per l'Ascensione ne potenzia gli attributi e le abilità speciali. Con 1-3 Ascensioni, gli effetti della Ruota del destino si rafforzano; con 4-15 Ascensioni, i suoi attributi migliorano. Clicca il pulsante \"Stadio successivo\" nell'interfaccia di Ascensione per visualizzare in anteprima i cambiamenti post-Ascensione."
  },
  Tutorial_20773_Title_1 = {
    Text = "Ascensione della Ruota del destino"
  },
  Tutorial_22247_Desc_1 = {
    Text = "<TutorialHighlight:Potenziamento del Patto> Potenzia gli attributi del Patto fino al livello 12. Smontare i Patti produce i Frammento Residuo corrispondenti, che possono essere scambiati per il <TutorialHighlight:Sigillo dei mille volti> nell'Inventario. Potenziare i Patti consuma il <TutorialHighlight:Sigillo dei mille volti>, e smontare i Patti potenziati restituisce il <TutorialHighlight:Sigillo dei mille volti> consumato."
  },
  Tutorial_22247_Title_1 = {
    Text = "Potenziamento del Patto"
  },
  Tutorial_22248_Desc_1 = {
    Text = "La Trascrizione consente al <TutorialHighlight:Patto> di ottenere attributi casuali di vari tipi e intensità. Questi attributi non sono legati a parti specifiche dell'equipaggiamento e possono includere Tasso Crit., Danno Crit., Livello Ricarica Aliemus, Livello di Ricarica della Chiave d'Argento, Padronanza del Reame, Bottino di Sigilli, Amplificazione del Danno e Resistenza alla Morte. Durante la trascrizione, se desideri conservare un attributo specifico, puoi scegliere di <TutorialHighlight:Bloccare> l'attributo, assicurando che quello bloccato resti invariato durante la trascrizione."
  },
  Tutorial_22248_Title_1 = {
    Text = "Trascrizione del Patto"
  },
  Tutorial_23466_Desc_1 = {
    Text = "Con l'aumentare del Livello del Custode, la <TutorialHighlight:potenza delle Reliquie e delle Orazioni> migliora, e l'<TutorialHighlight:impatto di ogni punto di COS sui PV della squadra> del Risvegliato aumenta. Le Indagini e gli Interludi forniscono una quantità significativa di ESP Custode. Ogni punto di Stamina consumata garantisce 1 punto di ESP Custode."
  },
  Tutorial_23466_Title_1 = {
    Text = "Livello Custode"
  },
  Tutorial_47538_Desc_1 = {
    Text = "La Zona D-Effetto è un sistema di gioco ad alta difficoltà. I Custodi devono coordinare con flessibilità più squadre di sfida per ottenere quanti più Punti Addestramento possibile e guadagnare così maggiori ricompense. Nella difficoltà Allerta Massima, le unità nemiche non solo diventano più forti, ma subiscono anche vari effetti debilitanti."
  },
  Tutorial_47538_Desc_2 = {
    Text = "La Zona D-Effetto ha regole di restrizione uniche: lo stesso Risvegliato e Seguito, così come le Ruote del Destino con nome identico, non possono essere schierati ripetutamente. Il Custode può scegliere con flessibilità la squadra per questa sfida in base alle Reliquie iniziali, ai Mostri e ai Livelli raccomandati, utilizzando una strategia simile alla corsa dei cavalli di Tian Ji per massimizzare i Punti Addestramento ottenuti. I Risvegliati schierati tramite il sistema di <TutorialHighlight:Supporto> non sono soggetti a questa restrizione."
  },
  Tutorial_47538_Title_1 = {
    Text = "Zona D-Effetto"
  },
  Tutorial_54390_Desc_1 = {
    Text = "In modalità <TutorialHighlight:Traphase>, gli <TutorialHighlight:stati> posseduti sia dai Risvegliati nemici che alleati nell'interfaccia di battaglia verranno visualizzati sotto i loro PV e Aliemus. Clicca per visualizzare gli effetti specifici."
  },
  Tutorial_54390_Desc_2 = {
    Text = "Gli <TutorialHighlight:Stati positivi> sono i seguenti (clicca per i dettagli): <TauntKeywords:Scherno>, <PVPPowerIconKeywords:Potere>, <EnergyStorageKeywords:Carica>, <PVPProtectiveKeywords:Barriera>, <PVPRetaliateIconKeywords:Contrattacco>, <ReinforceKeywords:Rinforzato>, <StrengthenKeywords:Potenziare>."
  },
  Tutorial_54390_Desc_3 = {
    Text = "Appartiene agli <TutorialHighlight:Stati Negativi> come segue (clicca per i dettagli): <PVPEntanglementKeywords:Intrecciato>, <PVPVulnerabilityIconKeywords:Vulnerabile>, <PVPSlowKeywords:Stagnazione>, <ComaKeywords:Pietrificazione>, <DisarmKeywords:Paralisi>, <PVPMethysisKeywords:Veleno>, <PVPEmptinessKeywords:Vuoto>, <PVPBleedingKeywords:Salasso>, <PVPSeriousInjuryKeywords:Flagello>, <ComaKeywords:Svenuto>."
  },
  Tutorial_54390_Title_1 = {Text = "Stato"},
  Tutorial_54391_Desc_1 = {
    Text = "Nella modalità <TutorialHighlight:Traphase>, alcune carte Risvegliatore avranno diversi effetti di <TutorialHighlight:affisso>, consultabili nel sistema <TutorialHighlight:Collezione> o tenendo premuto sulla carta durante la battaglia. Gli affissi includono (clicca per i dettagli): <PVPPenetrateKeywords:Perforazione>, <PrepareKeywords:Preparazione>, <PVPResurrectionKeywords:Rinascita>, <PVPHoldingKeywords:In Mano>, <PhantomKeywords:Fantasma>, <PVPRaidKeywords:Imboscata>."
  },
  Tutorial_54391_Title_1 = {Text = "Affisso"},
  Tutorial_54392_Desc_1 = {
    Text = "Nella modalità <TutorialHighlight:Traphase>, i punti partita verranno azzerati alla fine di ogni stagione e all'inizio di una nuova. Informazioni come i nomi delle stagioni e la loro durata possono essere visualizzate sul lato destro dell'interfaccia. Quando i punti vengono azzerati, i giocatori che avevano oltre 1.000 punti nella stagione precedente vedranno la parte eccedente dimezzata."
  },
  Tutorial_54392_Desc_2 = {
    Text = "Durante ogni stagione, ci saranno delle <TutorialHighlight:Missioni stagionali>. Completa le Missioni stagionali per ottenere ricche ricompense. Le Missioni stagionali verranno azzerate al rinnovo della stagione."
  },
  Tutorial_54392_Title_1 = {Text = "Stagione"},
  Tutorial_54393_Desc_1 = {
    Text = "Nella modalità <TutorialHighlight:Traphase>, quando un Risvegliatore muore, le carte in mano appartenenti a quel Risvegliatore si trasformano in <TutorialHighlight:Illusione>. Equipaggiare la <TutorialHighlight:Ruota del destino> a un Risvegliatore deceduto garantisce 1 Illusione e rimborsa l'Arithmetica consumata. Le Illusioni possono essere combinate con effetti specifici della Ruota del destino per formare <TutorialHighlight:Piccolo Desiderio>."
  },
  Tutorial_54393_Title_1 = {Text = "Illusione"},
  Tutorial_54394_Desc_1 = {
    Text = "Nella modalità <TutorialHighlight:Traphase>, entrambi i giocatori iniziano con 3 <TutorialHighlight:Arithmetica> e un limite massimo al primo turno. Il secondo giocatore riceve una carta <TutorialHighlight:Colpisci per Ultimo, Colpisci Meglio>. All'inizio di ogni turno successivo, il limite massimo e la quantità di recupero dell'Arithmetica aumentano di 1 fino a raggiungere 10. Oltre alla crescita automatica, altri metodi possono aumentare o diminuire il limite massimo dell'Arithmetica. Una volta raggiunto il limite di 10, ogni punto aggiuntivo in eccesso viene convertito nel pescare 1 carta."
  },
  Tutorial_54394_Title_1 = {
    Text = "Arithmetica"
  },
  Tutorial_54395_Desc_1 = {
    Text = "Nella modalità <TutorialHighlight:Traphase>, ogni <TutorialHighlight:Risvegliatore> possiede anche <TutorialHighlight:Aliemus> ed <TutorialHighlight:Esaltazione>. L'Aliemus si ottiene utilizzando carte <TutorialHighlight:Attacco> o specifiche carte <TutorialHighlight:Abilità>, e perdendo PV dai danni subiti (si ottiene 1 Aliemus ogni 2% di PV o equivalente Scudo perso). Quando l'Aliemus raggiunge 100, clicca sul Risvegliatore corrispondente per scatenare l'Esaltazione."
  },
  Tutorial_54395_Title_1 = {Text = "Aliemus"},
  Tutorial_54396_Desc_1 = {
    Text = "Nella modalità <TutorialHighlight:Traphase>, completare gli obiettivi specificati nei \"Registri Partita\" durante il matchmaking ti permetterà di ricevere le ricompense corrispondenti. Questa ricompensa è una tantum e non verrà ripristinata con la stagione. Puoi consultarla attraverso i \"Registri Partita\" nell'angolo in basso a sinistra dell'interfaccia."
  },
  Tutorial_54396_Title_1 = {
    Text = "Registro Traphase"
  },
  Tutorial_54397_Desc_1 = {
    Text = "In modalità <TutorialHighlight:Traphase>, la scheda \"Collezione\" sul lato sinistro dell'interfaccia ti permette di consultare tutte le informazioni relative a Risvegliati, Ruote del Destino e Seguaci."
  },
  Tutorial_54397_Title_1 = {Text = "Raccogli"},
  Tutorial_54398_Desc_1 = {
    Text = "In modalità <TutorialHighlight:Traphase>, ogni <TutorialHighlight:Risvegliato> possiede 2 carte <TutorialHighlight:Colpo> e 3 carte <TutorialHighlight:Abilità>. Solitamente, carte abilità diverse hanno valori di <TutorialHighlight:Costo di Arithmetica> differenti."
  },
  Tutorial_54398_Title_1 = {Text = "Abilità"},
  Tutorial_54399_Desc_1 = {
    Text = "Nella modalità <TutorialHighlight:Traphase>, peschi automaticamente 5 carte ogni turno, e il <TutorialHighlight:Limite Massima della Mano> predefinito è 10. Puoi visualizzare il conteggio attuale delle carte in mano e il limite massimo della mano in basso a destra dell'interfaccia di battaglia, mentre le informazioni dell'avversario sono mostrate in alto a destra. Altri metodi possono modificare il numero di carte pescate per turno e il limite massimo della mano."
  },
  Tutorial_54399_Title_1 = {Text = "Mano"},
  Tutorial_54400_Desc_1 = {
    Text = "Nella modalità <TutorialHighlight:Traphase>, i diversi Risvegliatori hanno diversi <TutorialHighlight:ruoli>, per un totale di cinque. Nello specifico, sono: <TutorialHighlight:Guardiano>, <TutorialHighlight:Nato in Guerra>, <TutorialHighlight:Luminis>, <TutorialHighlight:Malphas> e <TutorialHighlight:Benedizione>. Quando componi una <TutorialHighlight:Formazione>, seleziona 4 Risvegliatori con ruoli distinti per formare la tua squadra."
  },
  Tutorial_54400_Title_1 = {
    Text = "Ruoli Traphase"
  },
  Tutorial_54401_Desc_1 = {
    Text = "In <TutorialHighlight:Traphase-Modalità Selezione Libera>, cliccando su \"Avvia Ricerca\" nell'angolo in basso a destra dell'interfaccia accederai alla schermata di Formazione. Puoi anche preparare la tua squadra in anticipo nella <TutorialHighlight:Modalità Selezione Libera> sul lato sinistro dell'interfaccia."
  },
  Tutorial_54401_Desc_2 = {
    Text = "Le formazioni predefinite supportano il salvataggio di più configurazioni. L'angolo in alto a sinistra consente di modificare i nomi delle squadre. Ogni squadra è composta da 4 Risvegliati, 4 Ruote del Destino e 2 Seguaci."
  },
  Tutorial_54401_Title_1 = {
    Text = "Formazione preimpostata"
  },
  Tutorial_54705_Desc_1 = {
    Text = "In modalità <TutorialHighlight:Traphase>, clicca sul tuo <TutorialHighlight:avatar>, seleziona l'<TutorialHighlight:Emote di Sfida> desiderata da inviare ed esprimi i tuoi sentimenti al tuo rivale!"
  },
  Tutorial_54705_Title_1 = {
    Text = "Espressione"
  },
  Tutorial_54706_Desc_1 = {
    Text = "<TutorialHighlight:Traphase> è un gioco competitivo a due giocatori in cui ciascun giocatore utilizza la propria squadra pre-costruita per la <TutorialHighlight:Battaglia di Match>. Il sistema di matchmaking ti abbina ad avversari di livello simile."
  },
  Tutorial_54706_Desc_2 = {
    Text = "Puoi ottenere <TutorialHighlight:EXP Selezione Libera> e <TutorialHighlight:EXP Selezione a Turno> tramite le battaglie. Sblocca livelli più alti di <TutorialHighlight:Livello Selezione Libera> e <TutorialHighlight:Livello Selezione a Turno> per ottenere <TutorialHighlight:Ricompense Una Tantum>!"
  },
  Tutorial_54706_Desc_3 = {
    Text = "Ogni settimana, in base alla classifica dei punti, riceverai un <TutorialHighlight:Titolo> e otterrai <TutorialHighlight:Rosa dorata> il giorno successivo. \n Se partecipi sia a \"Traphase\" che a \"Immersione Fantasmatica\", il calcolo della Rosa dorata si baserà sulla ricompensa <TutorialHighlight:più alta> tra queste due modalità di gioco."
  },
  Tutorial_54706_Title_1 = {
    Text = "Introduzione al Duello"
  },
  Tutorial_74798_Desc_1 = {
    Text = "Le diverse fasi presentano differenti <TutorialHighlight:Ambienti del Capitolo>, che modificano significativamente le regole generali e gli effetti delle reliquie. I dettagli specifici possono essere consultati nella schermata di ciascuna fase cliccando sulla scheda corrispondente."
  },
  Tutorial_74798_Title_1 = {
    Text = "Capitoli d'Indagine"
  },
  Tutorial_81370_Desc_1 = {
    Text = "Il <TutorialHighlight:Reset del Risvegliato> consente di recuperare le varie risorse di coltivazione consumate dai Risvegliati."
  },
  Tutorial_81370_Desc_2 = {
    Text = "Il <TutorialHighlight:Ripristino dello Sviluppo> resetterà il Livello, l'Edificazione, le Abilità e lo stato di Avanzamento Gnostico del Risvegliato. Tutti i Materiali e i Buoni d'Oro consumati verranno interamente restituiti."
  },
  Tutorial_81370_Desc_3 = {
    Text = "Il <TutorialHighlight:Reset dell'Illuminazione> resetterà lo stato di Illuminazione del Risvegliato e il Limite di Livello ottenuto tramite l'Illuminazione. Tutti i Materiali consumati verranno interamente restituiti."
  },
  Tutorial_81370_Desc_4 = {
    Text = "Il <TutorialHighlight:Ritorno alla Genesi> include l'effetto del \"Ripristino dello Sviluppo\" e in aggiunta resetta il Risvegliato stesso riportandolo allo stato di sbloccato."
  },
  Tutorial_81370_Title_1 = {
    Text = "Reset del Risvegliatore"
  },
  Tutorial_81371_Desc_1 = {
    Text = "Il <TutorialHighlight:Potenziamento del Risvegliato> è uno dei modi più rapidi per migliorare gli attributi del Risvegliato. Consuma <TutorialHighlight:Elisir di gnosi> per aumentare il livello del Risvegliato."
  },
  Tutorial_81371_Desc_2 = {
    Text = "I Risvegliati devono sottoporsi all'<TutorialHighlight:Edificazione> per innalzare il proprio Limite di Livello una volta raggiunto, e Risvegliati di Reami diversi richiedono differenti <TutorialHighlight:Materiali di Edificazione>."
  },
  Tutorial_81371_Title_1 = {
    Text = "Potenziamento Risvegliatore"
  },
  Tutorial_81372_Desc_1 = {
    Text = "L'<TutorialHighlight:Attivazione dell'Illuminazione> può potenziare notevolmente gli effetti delle Carte di comando dei Risvegliati. Il Livello di Illuminazione 7 sblocca la <TutorialHighlight:Sovraesaltazione>, che conferisce effetti aggiuntivi quando i Risvegliati entrano in Esaltazione. I Livelli di Illuminazione 11 e 15 aumentano il Limite di Livello dei Risvegliati di 5 livelli."
  },
  Tutorial_81372_Title_1 = {
    Text = "Attivazione Illuminare"
  }
})
return Text_Tutorial
