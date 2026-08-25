__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_State = readonly({
  State_100291_Desc = {
    Text = "Tutti i Risvegliati generano il 50% in più di Aliemus."
  },
  State_100291_Name = {
    Text = "Confessione"
  },
  State_100292_Name = {
    Text = "Inizio Turno"
  },
  State_100293_Desc = {
    Text = "Riduce l'Aliemus causato da tutti i Risvegliati del 50%."
  },
  State_100293_Name = {
    Text = "Ombra della Personalità"
  },
  State_100295_Name = {
    Text = "Ricettore di Danno"
  },
  State_100296_Desc = {
    Text = "A ogni inizio turno, tutti i Risvegliati ottengono <Energy:5> Aliemus per ogni accumulo."
  },
  State_100296_Name = {
    Text = "L'\"Es\" Oscuro"
  },
  State_100297_Desc = {
    Text = "Generazione di Aliemus di tutti i Risvegliati +50%. A fine turno, ottieni uno Scudo pari al 20% dei PV massimi."
  },
  State_100297_Name = {
    Text = "Barriera Mentale"
  },
  State_100298_Desc = {
    Text = "A inizio turno, perdi il 10% dei PV attuali e ottieni [DescArg1] <PowerIconKeywords:FOR>. Generazione di Aliemus di tutti i Risvegliati -50%."
  },
  State_100298_Name = {
    Text = "Crollo della Fortezza"
  },
  State_100299_Desc = {
    Text = "Conteggio Esaltazione"
  },
  State_100299_Name = {
    Text = "Conteggio Esaltazione"
  },
  State_100302_Name = {
    Text = "Ricettore di Esaltazione"
  },
  State_100307_Desc = {
    Text = "Unico per Squadra: Dopo che il Portatore scatena un'Esaltazione, ottiene 1 accumulo di \"Collaborazione\". La successiva Esaltazione di altri Risvegliati in questo turno può consumare \"Collaborazione\", aumentando il suo Tasso di Crit. del <WeaponEffect_Num:[StateArg1]%>, e il Risvegliato che consuma \"Collaborazione\" ottiene Aliemus pari al <WeaponEffect_Num:[StateArg1]%> della Ricarica Aliemus del Portatore."
  },
  State_100307_WeaponDesc = {
    Text = "Dopo che il Portatore scatena un'Esaltazione, ottiene 1 accumulo di \"Collaborazione\". La successiva Esaltazione di altri Risvegliati entro questo turno può consumare \"Collaborazione\", aumentando il suo Tasso di Crit. del <WeaponEffect_Num:[StateArg1]%> e concedendo <WeaponEffect_Num:[DescArg1]> Aliemus al Risvegliato che ha consumato \"Collaborazione\"."
  },
  State_100326_Desc = {
    Text = "All'inizio di ogni turno, tutti i Risvegliati ottengono <Energy:3> Aliemus per ogni carica di questo effetto."
  },
  State_100326_Name = {
    Text = "<DarkEgo:L'\"Es\" Oscuro>"
  },
  State_100327_Desc = {
    Text = "Generazione di Aliemus di tutti i Risvegliati +50%. A fine turno, ottieni uno Scudo pari al 20% dei PV massimi."
  },
  State_100327_Name = {
    Text = "<MindWall:Barriera Mentale>"
  },
  State_100328_Desc = {
    Text = "Tutti i Risvegliati generano il 50% in più di Aliemus."
  },
  State_100328_Name = {
    Text = "<TrueConfess:Confessione>"
  },
  State_100329_Desc = {
    Text = "Generazione di Aliemus di tutti i Risvegliati -50%. A fine turno, ottieni 1 accumulo di <DarkEgo:L'\"Es\" Oscuro>: a inizio turno, tutti i Risvegliati ottengono 3 Aliemus."
  },
  State_100329_Name = {
    Text = "<ShadowSelf:Ombra della Personalità>"
  },
  State_100330_Desc = {
    Text = "A inizio turno, perdi il 10% dei PV attuali e ottieni [DescArg1] <PowerIconKeywords:FOR>. Generazione di Aliemus di tutti i Risvegliati -50%."
  },
  State_100330_Name = {
    Text = "<BarrierCrash:Crollo della Fortezza>"
  },
  State_100395_Name = {
    Text = "Sangue benedetto della Creazione+"
  },
  State_100396_Name = {
    Text = "Sangue benedetto della Creazione"
  },
  State_100527_Desc = {
    Text = "Quando Pickman attiva l'effetto \"Scoperta\", fornisce l'opzione \"Ispirazione!\": Consuma 1 accumulo di \"Fantasia\", scegli tutti gli effetti \"Scoperta\" e ottieni 1 accumulo di \"Creatività\"."
  },
  State_100527_Name = {Text = "Frenesia"},
  State_100541_Desc = {
    Text = "Quando Pickman ha 10 cariche di \"Creatività\" e usa Esaltazione, consuma tutte le cariche di \"Creatività\" per ottenere una carica di \"Rapsodia\". Questo conferisce inoltre 15 Aliemus a tutti i compagni di squadra. La sua \"Creatività\" può accumularsi fino a 10 cariche e viene conservata tra le battaglie."
  },
  State_100541_Name = {
    Text = "<Chuangyi:Creatività>"
  },
  State_100542_Desc = {
    Text = "Quando Pickman attiva l'effetto \"Scoperta\", fornisce l'opzione \"Ispirazione!\": Consuma 1 accumulo di \"Fantasia\", scegli tutti gli effetti \"Scoperta\" e ottieni 1 accumulo di \"Creatività\"."
  },
  State_100542_Name = {
    Text = "<Kuangxiang:Fantasia>"
  },
  State_100544_Name = {
    Text = "Lumaca Dolce"
  },
  State_100544_WeaponDesc = {
    Text = "La Generazione di Scudo e il Recupero PV causati dal portatore sono aumentati del 6%. Se la Padronanza del Reame del portatore è superiore a 50, la Generazione di Scudo e il Recupero PV sono ulteriormente aumentati del 6%."
  },
  State_100545_Name = {
    Text = "Lumaca Dolce"
  },
  State_100545_WeaponDesc = {
    Text = "La Generazione di Scudo e il Recupero PV causati dal portatore sono aumentati del 6%. Se la Padronanza del Reame del portatore è superiore a 50, la Generazione di Scudo e il Recupero PV sono ulteriormente aumentati del 6%."
  },
  State_100558_Desc = {
    Text = "La prossima Esaltazione usata da altri Risvegliati in questo turno aumenta il Tasso di Crit. del [StateArg1]%, e dopo l'uso, si ottengono [DescArg1] Aliemus."
  },
  State_100558_Name = {
    Text = "Collaborazione"
  },
  State_100559_Desc = {
    Text = "Include le seguenti \"Reliquie del Capitolo Astrale\": Bambino Maligno, La Sagra della Primavera, Serratura di ferro, Agata Filigranata, Sangue Benedetto, Sega Arrugginita, Reverie dorata, Ciottolo Insanguinato."
  },
  State_100559_Name = {
    Text = "<Chuanggouzaowu:Reliquia Dipinta>"
  },
  State_100562_Desc = {
    Text = "Le prossime [Layer] Carte di comando giocate in questo turno costano 2 Arithmetica in meno."
  },
  State_100562_Name = {
    Text = "Verità, e anche Illusione"
  },
  State_100564_Desc = {
    Text = "Include le seguenti \"Orazioni\": Calcolo, Finezza, Berserk, Catalizzatore, Potenza, Baluardo, Risucchio, Intuizione."
  },
  State_100564_Name = {
    Text = "<Chuanggoukeyin:Orazione Dipinta>"
  },
  State_100566_WeaponDesc = {
    Text = "Modifica l'Arithmetica della carta prima di giocarla"
  },
  State_100617_Desc = {
    Text = "A fine turno, Limite Tentacoli +1."
  },
  State_100617_Name = {
    Text = "Ossessione Abissale"
  },
  State_100619_Desc = {
    Text = "Quando la Forza viene ridotta, solo il 50% degli accumuli di Forza viene ridotto."
  },
  State_100619_Name = {
    Text = "Resistenza all'Esaurimento"
  },
  State_100621_Desc = {
    Text = "Ogni accumulo riduce il tuo DAN Base del 25% e può guidare la direzione della navigazione successiva."
  },
  State_100621_Name = {
    Text = "Faint Candlelight"
  },
  State_100623_Desc = {
    Text = "Ogni accumulo riduce il tuo DAN Base del 30%. Dopo aver inflitto DAN attivo o da Tentacolo, il tuo Veleno -[DescArg1]."
  },
  State_100623_Name = {
    Text = "Luce dei Perduti"
  },
  State_100639_Desc = {
    Text = "I danni da Tentacolo sono temporaneamente ridotti del 50%."
  },
  State_100639_Name = {
    Text = "Città Perduta di Lemuria"
  },
  State_100644_Desc = {
    Text = "Riduci permanentemente la FOR del bersaglio e ottieni la stessa quantità di FOR."
  },
  State_100644_Name = {
    Text = "<TouquKeywords:Rubare Permanentemente>"
  },
  State_100647_Desc = {
    Text = "Immune a tutti i danni."
  },
  State_100647_Name = {
    Text = "Immune a tutti i danni."
  },
  State_100694_Desc = {
    Text = "Ogni accumulo riduce il tuo DAN Base del 30%. Dopo aver inflitto DAN attivo o da Tentacolo, riduci i tuoi accumuli di Veleno."
  },
  State_100694_Name = {
    Text = "Luce dei Perduti"
  },
  State_116342_Desc = {
    Text = "Gioca una carta <ErosionColorInkKeywords:Distorsione Percettiva> per concedere a \"Il Pittore\" 1 accumulo di <DecayDye:Tintura Fantasma>."
  },
  State_116342_Name = {
    Text = "Tavolozza Distorta"
  },
  State_116406_Name = {Text = "Avanzato"},
  State_116407_Name = {
    Text = "Stato vuoto"
  },
  State_116858_Desc = {
    Text = "Questo Stato utilizza il moltiplicatore Vulnerabile, fungendo da moltiplicatore indipendente."
  },
  State_116858_Name = {
    Text = "Se possiedi un determinato Stato, subisci Danno doppio"
  },
  State_116859_Desc = {
    Text = "Ottieni Cedimento all'inizio del prossimo turno."
  },
  State_116859_Name = {
    Text = "Cedimento Ritardato"
  },
  State_116958_Desc = {
    Text = "Dopo aver giocato una carta, subisci Danno pari al numero di accumuli."
  },
  State_116958_Name = {
    Text = "<PVPCardLockColour:Lucchetto Carta>"
  },
  State_117154_Desc = {
    Text = "Questo effetto si applica a un solo Risvegliato nella squadra."
  },
  State_117154_Name = {
    Text = "<TeamUnique:Unico per Squadra>"
  },
  State_117212_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: prima di una «Tecnica» e alla fine del turno, applica <Damage:[Damage:StateArg1]> stack di <PVPCorrosionKeywords:marchio del peccato> al nemico con <HPAndShieldMax:vita e scudo più alti>."
  },
  State_117212_Name = {
    Text = "Ballata del Cavaliere Distorto"
  },
  State_117213_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Quando la Carta abilità del portatore viene giocata e alla fine del turno, infliggi [StateArg1] <PVPfengsuoKeywords:Blocco dell'Esaltazione> al nemico con l'Aliemus più alto."
  },
  State_117213_Name = {
    Text = "Il Volto del Divus"
  },
  State_117346_Desc = {
    Text = "Pollux infligge Salasso pari al [Layer]% del danno inflitto."
  },
  State_117346_Name = {
    Text = "Marchio del Peccato"
  },
  State_117355_Desc = {
    Text = "La prossima Carta di comando di Pollux ha effetto 2 volte."
  },
  State_117355_Name = {
    Text = "Rivelazione Divina"
  },
  State_117357_Desc = {
    Text = "Unico per Squadra: Dopo aver ripristinato le scorte presso \"D-segno\" e \"Rovine di Cenere\", il Portatore ottiene <WeaponEffect_Num:[StateArg1]> Aliemus."
  },
  State_117357_WeaponDesc = {
    Text = "Dopo aver ripristinato le scorte presso \"D-segno\" e \"Rovine di Cenere\", il Portatore ottiene <WeaponEffect_Num:[StateArg1]> Aliemus."
  },
  State_117358_Desc = {
    Text = "Ogni accumulo conferisce al danno di Pollux un effetto Sanguinamento dell'1%."
  },
  State_117358_Name = {
    Text = "<ZuiyinKeywords:Marchio del Peccato>"
  },
  State_117744_Desc = {
    Text = "<MaxHPKeywords:Salute massima> -[Layer]. Quando attivato, subisci [Layer] Danno Passivo, Permanente. Quando dissolto, i PV Massimi del bersaglio non si rigenerano."
  },
  State_117744_Name = {
    Text = "Marchio del Peccato"
  },
  State_117745_Desc = {
    Text = "Ogni accumulo riduce la <MaxHPKeywords:Salute massima> del bersaglio. Quando il Marchio del Peccato viene attivato, il bersaglio subisce Danno Passivo pari al numero di accumuli. Quando viene dissolto, i PV Massimi del bersaglio non si rigenerano."
  },
  State_117745_Name = {
    Text = "<PVPCorrosionKeywords:Marchio del Peccato>"
  },
  State_117755_Desc = {
    Text = "Impossibile compiere qualsiasi azione fino a fine turno."
  },
  State_117755_Name = {Text = "Svenuto"},
  State_117756_Desc = {
    Text = "Impossibile compiere qualsiasi azione fino a fine turno."
  },
  State_117756_Name = {Text = "Svenuto"},
  State_117776_Desc = {
    Text = "In questo turno, il Danno Finale e la Generazione di Scudo del Personaggio delle prossime [Layer] Carte di comando +[StateArg1] %."
  },
  State_117776_Name = {Text = "In fiamme"},
  State_117777_Desc = {
    Text = "Unico per Squadra: Le carte del portatore ottengono +<WeaponEffect_Num:[StateArg1]%> DAN Base e Danno Crit. All'inizio del tuo turno e dopo aver usato l'Esaltazione del portatore, ottieni 1 accumulo di \"Ardente\". Quando viene giocata una Carta di comando del portatore, consuma 1 accumulo per aumentarne il Danno Finale e lo Scudo del <WeaponEffect_Num:[StateArg2]%>. Durante un Turno Ultra, ottieni invece \"Fiammeggiante\" (effetto raddoppiato)."
  },
  State_117777_WeaponDesc = {
    Text = "Le carte del portatore ottengono +<WeaponEffect_Num:[StateArg1]%> DAN Base e Danno Crit. All'inizio del tuo turno e dopo aver usato l'Esaltazione, ottieni 1 accumulo di \"Ardente\". Quando viene giocata una Carta di comando del portatore, consuma 1 accumulo per aumentarne il Danno Finale e lo Scudo del <WeaponEffect_Num:[StateArg2]%>. Durante un Turno Ultra, ottieni invece \"Fiammeggiante\" (effetto raddoppiato)."
  },
  State_117778_Desc = {
    Text = "In questo turno, il Danno Finale e la Generazione di Scudo del Personaggio delle prossime [Layer] Carte di comando +[StateArg1] %."
  },
  State_117778_Name = {Text = "Acceso"},
  State_117779_Desc = {
    Text = "Unico per Squadra: Nel Turno Ultra: Ottieni 3 accumuli di \"Ardore\". Quando il Portatore gioca una Carta di comando, consuma 1 accumulo per aumentare il suo Danno Finale e la Generazione di Scudo del <WeaponEffect_Num:[StateArg1]%>."
  },
  State_117779_WeaponDesc = {
    Text = "Nel Turno Ultra: Ottieni 3 accumuli di \"Ardore\". Quando il Portatore gioca una Carta di comando, consuma 1 accumulo per aumentare il suo Danno Finale e la Generazione di Scudo del <WeaponEffect_Num:[StateArg1]%>."
  },
  State_117851_Desc = {
    Text = "Tutte le Carte di comando di Pollux ottengono +50% all'effetto \"Espiazione nel Dolore\". Questo effetto dura [Layer] turni."
  },
  State_117851_Name = {
    Text = "Lo Spezzanotte"
  },
  State_117853_Desc = {
    Text = "In questo turno, le prossime [Layer] Carte di comando di Pollux ricevono: DAN +[DescArg1], Scudo del Personaggio +[DescArg2] e Aliemus +10."
  },
  State_117853_Name = {
    Text = "Espiazione nel Dolore"
  },
  State_117869_Desc = {
    Text = "Ogni volta che Esaltazione viene scatenata, aumenta la \"Chiamata\" di 1 accumulo. Per ogni accumulo di \"Chiamata\", ottieni [DescArg1] Forza, fino a un massimo di 5 accumuli."
  },
  State_117869_Name = {
    Text = "Sacerdotessa degli Abissi"
  },
  State_117870_Desc = {
    Text = "Quando questa unità viene uccisa, chi l'ha eliminata recupera il 20% degli HP persi."
  },
  State_117870_Name = {Text = "Sashimi"},
  State_117875_Desc = {
    Text = "Se ci sono spazi vuoti dietro, perdi 1 accumulo dopo l'azione e richiama 1 \"Avannotto\" con lo stato \"Sashimi\"."
  },
  State_117875_Name = {
    Text = "Contratto: Frenesia Ittica"
  },
  State_117876_Desc = {
    Text = "Gli effetti di <WeaknessIconKeywords:Debolezza>, <FragileIconKeywords:Fragile> e <HeavyInjuryKeywords:Flagello> sono aumentati al 50%."
  },
  State_117876_Name = {
    Text = "Debolezza & Fragilità & Flagello+"
  },
  State_117880_Desc = {
    Text = "In questa battaglia, \"Balzo del Branco\" si attiverà una volta aggiuntiva dopo questo effetto."
  },
  State_117880_Name = {
    Text = "Attivazione aggiuntiva salto scuola"
  },
  State_117883_Desc = {
    Text = "A 5 accumuli, sigilla immediatamente tutti i Risvegliati e cambia l'intenzione in: \"Gloria di Lemuria! +\"."
  },
  State_117883_Name = {Text = "Richiamo"},
  State_117885_Desc = {
    Text = "Quando subisce l'effetto FOR▼, imporrà una quantità equivalente di effetto FOR▼ anche al lanciatore."
  },
  State_117885_Name = {
    Text = "Occhio per Occhio"
  },
  State_117889_Desc = {
    Text = "Entrando in campo di battaglia, aumenta i tuoi HP massimi del 10% e conferisci agli altri alleati [DescArg1] di <PowerIconKeywords:FOR>, facendo sì che l'aumento di HP e il guadagno di FOR del <FishLeapWords:Potere dello Sciame> si attivino una volta aggiuntiva in questa battaglia."
  },
  State_117889_Name = {
    Text = "Potere dello Sciame"
  },
  State_118112_Desc = {
    Text = "Il danno massimo ricevuto da un singolo colpo è di [DescArg1] punti, e verrà rimosso quando gli HP scendono sotto il 50%."
  },
  State_118112_Name = {
    Text = "Soglia del Dolore I"
  },
  State_118113_Desc = {
    Text = "Dopo aver perso HP a causa di Danno attivo ricevuto, ottieni Scudo del Personaggio pari al 15% degli HP persi e <AlertIconKeywords:Allerta temporanea> pari al 5% degli HP persi."
  },
  State_118113_Name = {Text = "Mollusca I"},
  State_118114_Desc = {
    Text = "Dopo aver perso HP a causa di Danno attivo ricevuto, ottieni Scudo del Personaggio pari al 35% degli HP persi e <AlertIconKeywords:Allerta temporanea> pari al 10% degli HP persi."
  },
  State_118114_Name = {
    Text = "Mollusca III"
  },
  State_118115_Desc = {
    Text = "Se ci sono spazi vuoti davanti, perdi 1 accumulo dopo l'azione e richiama 1 \"Escrescenza degli Abissi\"."
  },
  State_118115_Name = {
    Text = "Contratto: Escrescenza degli Abissi"
  },
  State_118116_Desc = {
    Text = "Il danno massimo ricevuto da un singolo colpo è di [DescArg1] punti, e verrà rimosso quando gli HP scendono sotto il 50%."
  },
  State_118116_Name = {
    Text = "Soglia del Dolore II"
  },
  State_118117_Desc = {
    Text = "Il danno massimo ricevuto da un singolo colpo è di [DescArg1] punti, e verrà rimosso quando gli HP scendono sotto il 50%."
  },
  State_118117_Name = {
    Text = "Soglia del Dolore III"
  },
  State_118118_Desc = {
    Text = "Ottieni 1 Tentacolo con <TentacleInjurieIconKeywords:Danno Tentacolo> pari a [TentaclePower:DescArg1] e 5 Limite Tentacoli. Ottieni 1 Tentacolo alla fine del turno. Gli effetti che riducono la Forza sono ridotti del 50%."
  },
  State_118118_Name = {
    Text = "Raduno dei tentacoli"
  },
  State_118119_Desc = {
    Text = "Dopo aver perso HP a causa di Danno attivo ricevuto, ottieni Scudo del Personaggio pari al 25% degli HP persi e <AlertIconKeywords:Allerta temporanea> pari al 5% degli HP persi."
  },
  State_118119_Name = {
    Text = "Mollusca II"
  },
  State_118319_Desc = {
    Text = "Il danno massimo ricevuto da un singolo colpo è di [DescArg1] punti, e verrà rimosso quando gli HP scendono sotto il 50%."
  },
  State_118319_Name = {
    Text = "Limite di Danno dello Scudo Abissale"
  },
  State_118320_Name = {
    Text = "Contromisura Temporanea di esaurimento"
  },
  State_118321_Name = {
    Text = "Conteggio contromisura esaurimento"
  },
  State_118322_Name = {
    Text = "Indicatori di Evocazione"
  },
  State_118323_Desc = {
    Text = "Balzo del Branco attivato"
  },
  State_118323_Name = {
    Text = "Marcatore ingresso salto scuola"
  },
  State_118324_Desc = {
    Text = "Per ogni 1 Danno inflitto, genera 1 Tentacolo Temporaneo."
  },
  State_118324_Name = {
    Text = "Rituale della Pioggia di Serpenti"
  },
  State_118325_Desc = {
    Text = "Quando infliggi Danno non bloccato, mischia [DescArg1] carte Soffocamento in cima al Mazzo di Pesca"
  },
  State_118325_Name = {
    Text = "Tremito Testa del Serpente del Nuovo Mondo"
  },
  State_118656_Desc = {
    Text = "Subisci [StateArg1] DAN e rimuovi 1 accumulo quando giochi una carta. Quando gli accumuli raggiungono 0, schiudi una \"Creatura Marina\" più debole. Se ancora parassitato a fine turno, schiudi una \"Creatura Marina\" con PV basati sugli accumuli."
  },
  State_118656_Name = {
    Text = "Parassitato Ripetutamente"
  },
  State_118657_Desc = {
    Text = "Subisci [StateArg1] DAN e rimuovi 1 accumulo quando giochi una carta. Quando gli accumuli raggiungono 0, schiudi una \"Creatura Marina\" più debole. Se ancora parassitato a fine turno, schiudi una \"Creatura Marina\" con PV basati sugli accumuli."
  },
  State_118657_Name = {
    Text = "Parassitato di Nuovo"
  },
  State_118659_Desc = {
    Text = "Subisci [StateArg1] DAN e rimuovi 1 accumulo quando giochi una carta. Quando gli accumuli raggiungono 0, schiudi una \"Creatura Marina\" più debole. Se ancora parassitato a fine turno, schiudi una \"Creatura Marina\" con PV basati sugli accumuli."
  },
  State_118659_Name = {
    Text = "Parassitato"
  },
  State_118663_Name = {
    Text = "Ascolto intenzionale della testa del Serpente del Nuovo Mondo"
  },
  State_118669_Name = {
    Text = "Inizializzazione Testa del Serpente del Nuovo Mondo"
  },
  State_118670_Desc = {
    Text = "Rilevamento di segni di contromisura al prosciugamento"
  },
  State_118670_Name = {
    Text = "Rilevamento contromisura esaurimento"
  },
  State_118671_Desc = {
    Text = "Rilevamento del comportamento del giocatore che mostra prosciugamento"
  },
  State_118671_Name = {
    Text = "Monitoraggio contromisura esaurimento"
  },
  State_118672_Name = {
    Text = "Tempo di ricarica dell'ascolto intenzionale della testa del Serpente del Nuovo Mondo"
  },
  State_118741_Name = {
    Text = "Rimuovi tentacoli temporanei"
  },
  State_118743_Name = {
    Text = "La posizione di evocazione preparatoria richiede indicatori di evocazione"
  },
  State_118759_Name = {
    Text = "Conteggio tentacoli permanenti attuali del mostro"
  },
  State_118760_Name = {
    Text = "Limite tentacoli permanenti del mostro"
  },
  State_118762_Name = {
    Text = "Primo suggerimento decadimento"
  },
  State_118763_Name = {
    Text = "Primo suggerimento sangue neurotossina"
  },
  State_118764_Name = {
    Text = "Primo suggerimento soffio maledetto"
  },
  State_118766_Name = {
    Text = "Il BOSS polpo dagli anelli blu intende monitorare"
  },
  State_118769_Name = {
    Text = "Suggerimento Lanterna Nucleo d'Argento"
  },
  State_118771_Name = {
    Text = "Primo suggerimento sonda"
  },
  State_118772_Name = {
    Text = "Primo suggerimento lacerazione del serpente"
  },
  State_118935_Name = {
    Text = "Il murphy dei mostri intende origliare"
  },
  State_118938_Desc = {
    Text = "La Dama delle Profondità si è Ridestata, aumentando enormemente la quantità di Scudo del Personaggio creato!"
  },
  State_118938_Name = {
    Text = "Creatura plasmata"
  },
  State_118943_Desc = {
    Text = "Il danno subito durante il tuo turno è raddoppiato. Quando perdi HP, perdi una quantità equivalente di accumuli. Quando gli accumuli raggiungono 0, riduci permanentemente il numero di tentacoli di 1 e reimposta gli accumuli, con un minimo di 1 tentacolo."
  },
  State_118943_Name = {
    Text = "Sacrificio della Deipara"
  },
  State_118973_Name = {
    Text = "Gestione Ribellione nascosta"
  },
  State_119051_Desc = {
    Text = "Si attiva a fine turno: subisci questa quantità di Danno passivo e rimuovi metà degli accumuli; non può essere dissolto."
  },
  State_119051_Name = {
    Text = "<PVPSacrificeKeyWords:Sacrificio>"
  },
  State_119052_Desc = {
    Text = "Ottieni Sacrificio pari al [Layer]% del Danno attivo ricevuto."
  },
  State_119052_Name = {
    Text = "Rituale di Nascita"
  },
  State_119053_Desc = {
    Text = "Si attiva a fine turno: subisci [Layer] Danno passivo e rimuovi metà degli accumuli; non può essere dissolto."
  },
  State_119053_Name = {Text = "Sacrificio"},
  State_119058_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Al termine del turno, applica [StateArg1] <PVPSacrificeKeyWords:Sacrificio> al nemico con meno Sacrificio, ripetuto [StateArg2] volte. Tutti gli alleati non sono più influenzati dagli effetti di riduzione del <PVPCapKeywords:Limite di Arithmetica>."
  },
  State_119058_Name = {
    Text = "Uteri Somnia"
  },
  State_119059_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del Destino>: Dopo \"Esaltazione\", tutti i nemici otterranno <PVPSacrificeKeyWords:Sacrificio> pari al [StateArg1]% del Danno attivo ricevuto in questo turno."
  },
  State_119059_Name = {
    Text = "Tossina dell'Anello Blu"
  },
  State_119060_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Danno \"Colpo\" +[StateArg1]%, dopo che un qualsiasi alleato gioca un \"Colpo\", pesca [StateArg3] carte, attivabile un massimo di [StateArg2] volte per turno. (attualmente attivato [DescArg1] volte)."
  },
  State_119060_Name = {
    Text = "Furia dell'Apocalisse"
  },
  State_119061_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Danno \"Colpo\" di tutti gli alleati +[StateArg1]%."
  },
  State_119061_Name = {
    Text = "Luce dell'Intelletto"
  },
  State_119063_Desc = {
    Text = "A 5 accumuli, l'intenzione cambia in: \"Gloria di Lemuria!\"."
  },
  State_119063_Name = {Text = "Richiamo"},
  State_119075_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_119075_Name = {
    Text = "Non Risvegliato"
  },
  State_119076_Desc = {
    Text = "Se ci sono posizioni vuote nella fila anteriore, perdi 1 accumulo dopo aver agito e richiama casualmente 1 \"Risvegliato Lemuriano\"."
  },
  State_119076_Name = {
    Text = "Contratto: Lemuria"
  },
  State_119077_Desc = {
    Text = "Quando la \"Chiamata\" raggiunge 5 accumuli, sigilla immediatamente tutti i Risvegliati."
  },
  State_119077_Name = {
    Text = "Risveglio di Miryam!"
  },
  State_119077_WeaponDesc = {
    Text = "A inizio del turno successivo, ottieni Scudo del Personaggio pari alla quantità di HP persi nel turno precedente."
  },
  State_119080_Desc = {
    Text = "Quando si scatena \"Memorie del Caos\" o \"Crepuscolo Non Dimenticato\", il Seguito selezionato si attiva 1 volta aggiuntiva."
  },
  State_119080_Name = {
    Text = "Ex Oblivione"
  },
  State_119082_Desc = {
    Text = "Ogni volta che un Risvegliato Scatena un'Esaltazione, il suo Aliemus Base +10."
  },
  State_119082_Name = {
    Text = "Esaurimento Aliemus"
  },
  State_119083_Desc = {
    Text = "Quando una Carta di comando viene presa dallo Spazio Ultra, il suo Costo di Arithmetica -1."
  },
  State_119083_Name = {
    Text = "Fine dell'Oltremondo"
  },
  State_119084_Desc = {
    Text = "Ogni volta che scateni Seguito, il Keyflare richiesto aumenta di 100."
  },
  State_119084_Name = {
    Text = "Onda d'Urto della Chiave d'Argento"
  },
  State_119085_Desc = {
    Text = "Dopo aver usato Fornace Cremisi, trasforma 1 Embrione in un Rampollo della Purezza, con un tempo di ricarica di 3 turni."
  },
  State_119085_Name = {
    Text = "Nutrimento Cremisi"
  },
  State_119086_Desc = {
    Text = "Il Potere di Allevamento è in ricarica, [Layer] turni rimanenti."
  },
  State_119086_Name = {
    Text = "Tempo di ricarica Potere di Allevamento"
  },
  State_119104_Desc = {
    Text = "Ottieni [DescArg1] accumuli di \"Sigillo Vitale\" a inizio turno."
  },
  State_119104_Name = {
    Text = "Sacramento della Marea"
  },
  State_119105_Desc = {
    Text = "Alla morte perdi tutti gli accumuli di \"Sigillo Vitale\". Ripristina l'1% degli HP massimi per accumulo e aumenta il Danno del Tentacolo dell'1%."
  },
  State_119105_Name = {Text = "Patto"},
  State_119106_Name = {
    Text = "Il murphy delirante dei mostri intende origliare"
  },
  State_119107_Name = {
    Text = "Gestione dell'Ordine del Reame di Dio"
  },
  State_119108_Desc = {
    Text = "Quando perdi Vita, per ogni accumulo ottieni <SacrificeKeyWord:Sacrificio> pari all'1% della Vita persa."
  },
  State_119108_Name = {
    Text = "Rituale di Nascita"
  },
  State_119109_Desc = {
    Text = "Quando subisci danni da fonti diverse da <SacrificeKeyWord:Sacrificio>, perdi una quantità equivalente di \"Ordine del Reame Divino\" e ottieni un <SacrificeKeyWord:Sacrificio> pari al 50% del danno subito. Se gli accumuli sono a 0, ottieni 1 accumulo di \"Sigillo Vitale\" e gli accumuli vengono ripristinati."
  },
  State_119109_Name = {
    Text = "Ordine del Reame Divino"
  },
  State_119132_Desc = {
    Text = "Questo turno, danni \"Colpo\" +[Layer]%."
  },
  State_119132_Name = {
    Text = "Potenziamento Colpo"
  },
  State_119134_Name = {
    Text = "Messaggio del Primo Creatore dell'Illusione"
  },
  State_119359_Name = {
    Text = "Conteggio Rituale della Chiave d'Argento"
  },
  State_119362_Name = {
    Text = "Celebra il Rituale"
  },
  State_119363_Name = {
    Text = "Carta Propria"
  },
  State_119364_Name = {
    Text = "Conteggio rituale della Follia"
  },
  State_119365_Desc = {
    Text = "La Guarigione e la Generazione di Scudi di tutti i Risvegliati sono aumentate del 40%."
  },
  State_119365_Name = {
    Text = "Compostezza"
  },
  State_119366_Desc = {
    Text = "Ritorno in Mano dopo essere stata scartata"
  },
  State_119366_Name = {
    Text = "Ritorno in Mano dopo essere stata scartata"
  },
  State_119367_Name = {
    Text = "Conteggio Rito Vitale"
  },
  State_119368_Desc = {
    Text = "Ottieni 500 Keyflare all'inizio di ogni turno."
  },
  State_119368_Name = {
    Text = "Chiaroveggenza"
  },
  State_119369_Desc = {
    Text = "Generazione Aliemus di tutti i Risvegliati +50%."
  },
  State_119369_Name = {Text = "Autorità"},
  State_119370_Name = {Text = "Reliquia"},
  State_119373_Name = {
    Text = "Il nemico sta eseguendo un sacrificio"
  },
  State_119567_Name = {
    Text = "Completa il Rituale"
  },
  State_119568_Desc = {
    Text = "Danni Colpo +[Layer]."
  },
  State_119568_Name = {Text = "Amp. Colpo"},
  State_119583_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del Destino>: Prima di \"Colpo\", \"Abilità\" ed \"Esaltazione\", <StrongEffectKeywords:Amplificazione> Temporaneo/a +[StateArg1]. Si attiva solo una volta per ogni tipo di carta per turno."
  },
  State_119583_Name = {
    Text = "Ci rivedremo"
  },
  State_119588_Name = {Text = "Caro CD"},
  State_119589_Name = {Text = "Ultra cd"},
  State_119590_Desc = {
    Text = "Unicità di Squadra: Dopo aver cambiato Postura del Tentacolo, usato la Fornace Cremisi, o scatenato \"Annientamento\", pesca la Carta di comando del portatore ×1; ogni effetto ha un cooldown di 3 turni. Dopo l'Esplorazione, tutti i Risvegliatori nel team guadagnano +<WeaponEffect_Num:[StateArg1]%> di Affinità."
  },
  State_119590_WeaponDesc = {
    Text = "Dopo aver cambiato manualmente la Postura del Tentacolo (raffreddamento rimanente: [DescArg1] turni), aver usato la Fornace Cremisi (raffreddamento rimanente: [DescArg2] turni) o aver rilasciato l'\"Annientamento\" (raffreddamento rimanente: [DescArg3] turni), pesca 1 Carta di comando del portatore. Ogni Effetto ha un raffreddamento di 3 turni. Al termine dell'esplorazione, l'Affinità ottenuta da tutti i Risvegliatori aumenta del <WeaponEffect_Num:[StateArg1]%>."
  },
  State_119591_Name = {
    Text = "Abisso Marino cd"
  },
  State_119741_Desc = {
    Text = "Generazione FOR di tutti i Risvegliati -50%."
  },
  State_119741_Name = {
    Text = "Maledizione: Declino"
  },
  State_119742_Desc = {
    Text = "All'inizio di ogni turno, recupera il 15% dei PV persi."
  },
  State_119742_Name = {
    Text = "Benedizione: Eternità"
  },
  State_119743_Desc = {
    Text = "Recupero PV di tutti i Risvegliati -50%."
  },
  State_119743_Name = {
    Text = "Maledizione: Distruzione"
  },
  State_119744_Desc = {
    Text = "Maledizione: Distruzione è inattiva per 1 turno."
  },
  State_119744_Name = {
    Text = "Immune a Maledizione: Distruzione"
  },
  State_119746_Name = {
    Text = "Numero di volte in cui il Sigillo Abissale è stato perso"
  },
  State_119747_Desc = {
    Text = "Non subirà DAN per 1 turno."
  },
  State_119747_Name = {
    Text = "Chiave d'Argento, Guidaci Avanti"
  },
  State_119748_Desc = {
    Text = "Maledizione: Declino è inattiva per 1 turno."
  },
  State_119748_Name = {
    Text = "Immune a Maledizione: Declino"
  },
  State_119749_Desc = {
    Text = "A inizio turno del Custode, applica alla sua mano 1 accumulo di <SlowIconKeywords:Stagnazione> pari al numero di accumuli di <Abyssallock:Catene del Sogno>."
  },
  State_119749_Name = {
    Text = "Catene del Sogno"
  },
  State_119750_Name = {
    Text = "L'intenzione del sipario celeste ascolta"
  },
  State_119751_Name = {
    Text = "Il sipario riattiva il segno di rilascio"
  },
  State_119752_Desc = {
    Text = "A ogni inizio turno, ottieni il 5% degli HP massimi come <PowerIconKeywords:FOR>, con un Tasso critico temporaneo del +25%."
  },
  State_119752_Name = {
    Text = "Benedizione: Potenza"
  },
  State_119753_Name = {
    Text = "Conteggio delle maree fioche dell'abisso"
  },
  State_119754_Desc = {
    Text = "Riduce l'Aliemus causato da tutti i Risvegliati del 50%."
  },
  State_119754_Name = {
    Text = "Maledizione: Follia"
  },
  State_119755_Name = {
    Text = "Conteggio delle morti"
  },
  State_119756_Desc = {
    Text = "Maledizione: Follia è inattiva per 1 turno."
  },
  State_119756_Name = {
    Text = "Immune a Maledizione: Follia"
  },
  State_119757_Desc = {
    Text = "All'inizio del turno del Custode, applica alla sua mano un numero di accumuli di <SlowIconKeywords:Stagnazione> pari al numero di accumuli di <Abyssallock:Catene del Sogno>. Ogni volta che il \"Velo del Paradiso\" viene infranto dal Danno attivo, riduci di 1 accumulo e Sigilla completamente il Risvegliato attaccante per 1 turno."
  },
  State_119757_Name = {
    Text = "Catene del Sogno"
  },
  State_119758_Desc = {
    Text = "A ogni inizio turno, tutti i Risvegliati ottengono 10 Aliemus."
  },
  State_119758_Name = {
    Text = "Benedizione: Saggezza"
  },
  State_119760_Name = {
    Text = "Monitoraggio della morte"
  },
  State_119789_Desc = {
    Text = "A inizio turno, ripristina [Layer] HP."
  },
  State_119789_Name = {
    Text = "Fiore di Melma"
  },
  State_119837_Desc = {
    Text = "La prossima Carta di comando che Ramona gioca in questo turno ha effetto 2 volte."
  },
  State_119837_Name = {
    Text = "Mani Ricongiunte"
  },
  State_119847_Desc = {
    Text = "Modifica l'Arithmetica della carta prima di giocarla"
  },
  State_119847_Name = {
    Text = "Modifica il Costo di Arithmetica prima di giocare"
  },
  State_119928_Desc = {
    Text = "Dopo averla giocata, si attiva [StateArg1] volte aggiuntive, <DepleteIconKeywords:Consumo>. <RippleKeywords:Onda d'Urto Residua>: Pesca 2 carte."
  },
  State_119928_Name = {
    Text = "<Rune_20:Eco dell'Abisso>"
  },
  State_119958_Desc = {
    Text = "Richiama immediatamente uno \"Sciame\" casuale dopo la morte, riducendo la sua \"Migrazione delle Maree\" di 1 accumulo."
  },
  State_119958_Name = {
    Text = "Migrazione delle Maree"
  },
  State_119959_Desc = {
    Text = "Richiama immediatamente una \"Nidiata\" casuale dopo la morte, riducendo il suo \"Ciclo Eterno\" di 1 accumulo."
  },
  State_119959_Name = {
    Text = "Ciclo Eterno"
  },
  State_119960_Desc = {
    Text = "Danno Attivo e da Tentacolo inflitto -35%. Questo stato viene rimosso quando la tua Vita attuale è superiore al 50%."
  },
  State_119960_Name = {
    Text = "<PurpleKeyWord:Decadimento>"
  },
  State_120215_Desc = {
    Text = "All'inizio del turno del Custode, applica alla sua mano un numero di accumuli di <SlowIconKeywords:Stagnazione> pari al numero di accumuli di <Abyssallock:Catene del Sogno>. Ogni volta che il \"Velo del Paradiso\" viene infranto dal Danno attivo, riduci di 1 accumulo e Sigilla completamente il Risvegliato attaccante per 1 turno."
  },
  State_120215_Name = {
    Text = "Sigillo dell'Abisso"
  },
  State_120216_Desc = {
    Text = "A inizio turno del Custode, applica alla sua mano 1 accumulo di <SlowIconKeywords:Stagnazione> pari al numero di accumuli di <Abyssallock:Sigillo dell'Abisso>."
  },
  State_120216_Name = {
    Text = "Sigillo dell'Abisso"
  },
  State_120218_Name = {
    Text = "Scegli il supporto di Murphy alla fine del turno"
  },
  State_120222_Name = {
    Text = "Inizio turno: Seleziona Inversione della Maledizione"
  },
  State_120292_Name = {
    Text = "Angoscia del reietto"
  },
  State_120293_Desc = {
    Text = "Recupera [Layer] HP a fine turno."
  },
  State_120293_Name = {
    Text = "Angoscia del reietto"
  },
  State_120312_Desc = {
    Text = "Richiama immediatamente un \"Tiranno\" casuale dopo la morte, riducendo la sua \"Migrazione delle Maree\" di 1 accumulo."
  },
  State_120312_Name = {
    Text = "Migrazione delle Maree"
  },
  State_120320_Desc = {
    Text = "Ogni carica aumenta il prossimo \"Rituale di Nascita\" applicato da \"Principessa delle Illusioni\" del 20%, accumulabile fino a 5 cariche. Al raggiungimento di 5 cariche, la prossima \"Principessa delle Illusioni\" raddoppia il conteggio dei danni."
  },
  State_120320_Name = {Text = "Patto"},
  State_120321_Desc = {
    Text = "Ogni accumulo infligge accumuli di \"Sacrificio\" pari all'1% del Danno attivo o dei Danni da tentacolo subiti. Si accumula fino a 75. Rimosso al termine del turno."
  },
  State_120321_Name = {
    Text = "<DwmofeiKeywords:Rituale di Nascita>"
  },
  State_120322_Desc = {
    Text = [[
Unico per Squadra: Limite Mano +2. Effetti dello stesso tipo non sono cumulabili. Rigenerazione Keyflare del Portatore e Danno Finale & Generazione Scudo del Personaggio dell'Esaltazione +<WeaponEffect_Num:[StateArg1]%>.
Passare alla posizione "Mare Tranquillo" aumenta l'Aliemus del Portatore di <WeaponEffect_Num:[StateArg2]>, tempo di ricarica 3 turni.
Passare alla posizione "Onde Furiose" infligge <WeaponEffect_Num:[StateArg3]> accumuli di <DwmofeiKeywords:Rituale di Nascita> a tutti i nemici, tempo di ricarica 3 turni.]]
  },
  State_120322_WeaponDesc = {
    Text = [[
Limite Mano +2. Effetti dello stesso tipo non sono cumulabili. Rigenerazione Keyflare del Portatore e Danno Finale & Generazione Scudo del Personaggio dell'Esaltazione +<WeaponEffect_Num:[StateArg1]%>.
Passare alla posizione "Mare Tranquillo" aumenta l'Aliemus del Portatore di <WeaponEffect_Num:[StateArg2]>, tempo di ricarica 3 turni.
Passare alla posizione "Onde Furiose" infligge <WeaponEffect_Num:[StateArg3]> accumuli di <DwmofeiKeywords:Rituale di Nascita> a tutti i nemici, tempo di ricarica 3 turni.]]
  },
  State_120324_Desc = {
    Text = "Ogni accumulo infligge accumuli di \"Sacrificio\" pari al [Layer]% del Danno Attivo o da Tentacolo subito. Si accumula fino a 75. Rimosso al termine del turno."
  },
  State_120324_Name = {
    Text = "Rituale di Nascita"
  },
  State_120350_Desc = {Text = "—"},
  State_120350_WeaponDesc = {Text = "—"},
  State_120351_Desc = {
    Text = "[Layer] turni prima che \"Regno Divino: Mare Tranquillo\" sia disponibile"
  },
  State_120351_Name = {
    Text = "Regno Divino: Mare Tranquillo TdR"
  },
  State_120352_Desc = {Text = "—"},
  State_120352_WeaponDesc = {Text = "—"},
  State_120353_Desc = {Text = "—"},
  State_120354_Desc = {
    Text = "[Layer] turni prima che \"Regno Divino: Onde Furiose\" sia disponibile"
  },
  State_120354_Name = {
    Text = "Regno Divino: Onde Furiose TdR"
  },
  State_120357_Desc = {Text = "—"},
  State_120357_Name = {Text = "Tentacolo"},
  State_120357_WeaponDesc = {Text = "—"},
  State_120362_Desc = {
    Text = "Quando subisci Danno da fonti diverse da <SacrificeKeyWord:Sacrificio>, ottieni il 50% del Danno come <SacrificeKeyWord:Sacrificio>."
  },
  State_120362_Name = {
    Text = "Gestione generale del sacrificio dei mostri"
  },
  State_120363_Desc = {
    Text = "Alla fine del turno subisci [Layer] punti di Danno e riduci gli accumuli di <SacrificeKeyWord:Sacrificio> del 50%."
  },
  State_120363_Name = {
    Text = "<BlueKeyWord:Sacrificio>"
  },
  State_120364_Desc = {
    Text = "Evoca \"Guardia del Navigatore\" alla tua morte."
  },
  State_120364_Name = {
    Text = "Fede Eterna"
  },
  State_120401_Desc = {
    Text = "Costo di Arithmetica -[StateArg5]. Pesca [StateArg4] carte dopo averla giocata."
  },
  State_120401_Name = {
    Text = "<OrangeQuality:Insegna Mythag>"
  },
  State_120450_Name = {
    Text = "Il polpo dagli anelli blu registra la vita del giocatore"
  },
  State_120462_Desc = {
    Text = "Rimane nel mazzo al termine del combattimento, ma viene rimossa permanentemente dopo essere stata giocata o consumata."
  },
  State_120462_Name = {
    Text = "<DestructionKeywords:Distruzione>"
  },
  State_120900_Name = {
    Text = "Preparazione per evocare il conteggio \"Risvegliatore di Lemuria\""
  },
  State_120907_Desc = {
    Text = "Se l'ATK del Tentacolo viene bloccato, infligge [DescArg1] stack di <IntoxicationIconKeywords:Veleno>."
  },
  State_120907_Name = {
    Text = "Corrente Sotterranea"
  },
  State_120908_Desc = {
    Text = "Se un Attacco del tentacolo viene bloccato, infliggi una quantità equivalente di <IntoxicationIconKeywords:Veleno>."
  },
  State_120908_Name = {
    Text = "Corrente Sotterranea"
  },
  State_120910_Desc = {
    Text = "Costo di Arithmetica +[StateArg5]. Pesca [StateArg4] carte dopo averla giocata."
  },
  State_120910_Name = {
    Text = "<OrangeQuality:Insegna Mythag>"
  },
  State_120924_Desc = {
    Text = "Ottieni Fortezza all'inizio del prossimo turno."
  },
  State_120924_Name = {
    Text = "Fortezza di Ritardo"
  },
  State_120929_Desc = {
    Text = "La carta viene mantenuta, ma dopo essere giocata rimuoverà la Contaminazione e invocherà 1 \"Escrescenza degli Abissi\". Se non c'è spazio per l'invocazione, si otterrà 1 carica di \"Prepara Invocazione: Escrescenza degli Abissi\"."
  },
  State_120929_Name = {
    Text = "<SeastriderCurse:Maledizione degli Abissi>"
  },
  State_120930_Desc = {
    Text = "Se c'è spazio libero, perdi 1 carica dopo l'azione e invoca 1 \"Escrescenza degli Abissi\"."
  },
  State_120930_Name = {
    Text = "Contratto: Escrescenza degli Abissi"
  },
  State_120934_Desc = {
    Text = "Ogni volta che subisci un Danno critico, ottieni il 3% di <Baojidikang:Res. Critica Temporanea>. A inizio di ogni turno, applica \"<SeastriderCurse:Maledizione del Navigatore>\" a 2 carte."
  },
  State_120934_Name = {
    Text = "Riti del Mare Profondo"
  },
  State_120941_Desc = {
    Text = "Amplifica le abilità del nemico. Il nemico perde 1 carica quando subisce DAN."
  },
  State_120941_Name = {
    Text = "Giuramento di Sangue"
  },
  State_121006_Desc = {
    Text = "Unico per Squadra: Rigenerazione Keyflare, Danno Finale dell'Esaltazione e Scudo del portatore +<WeaponEffect_Num:[StateArg1]%>."
  },
  State_121006_WeaponDesc = {
    Text = "Rigenerazione Keyflare, Danno Finale dell'Esaltazione e Scudo del portatore +<WeaponEffect_Num:[StateArg1]%>."
  },
  State_121014_Name = {
    Text = "Protezione del Feto Divino"
  },
  State_121015_Desc = {
    Text = "Gli Scudi del Personaggio non vengono rimossi a inizio turno. Quando possiedi uno scudo, ottieni 50 accumuli di <ReinforcePVEKeywords:Fortezza>, e <ReinforcePVEKeywords:Fortezza> viene rimosso quando lo scudo viene infranto."
  },
  State_121015_Name = {
    Text = "Protezione del Feto Divino"
  },
  State_121151_Desc = {
    Text = "La carta viene mantenuta, ma dopo essere giocata rimuoverà la Contaminazione e invocherà 1 \"Escrescenza degli Abissi\". Se non c'è spazio per l'invocazione, si otterrà 1 carica di \"Prepara Invocazione: Escrescenza degli Abissi\"."
  },
  State_121151_Name = {
    Text = "<SeastriderCurse:Maledizione degli Abissi>"
  },
  State_121210_Name = {
    Text = "Infliggi a tutti i nemici un <PVPWonderfulEffectKeywords:Effetto meraviglioso> negativo, efficace 2 volte"
  },
  State_121211_Name = {
    Text = "Pesca 2 carte, ottenendo 2 Arithmetica"
  },
  State_121212_Name = {
    Text = "Concedi a tutti gli alleati un <PVPWonderfulEffectKeywords:Effetto meraviglioso> positivo, efficace 2 volte"
  },
  State_121213_Desc = {
    Text = "Immune a tutti i danni."
  },
  State_121213_Name = {
    Text = "Immune a tutti i danni."
  },
  State_121231_Desc = {
    Text = "Ogni accumulo conferisce alla prossima \"Principessa delle Illusioni\" +20% di \"Rituale di Nascita\", fino a 5 accumuli, al raggiungimento dei quali il conteggio DAN della prossima \"Principessa delle Illusioni\" raddoppia."
  },
  State_121231_Name = {
    Text = "<MingqiKeywords:Sigillo Vitale>"
  },
  State_121365_Desc = {
    Text = "Subisci un ulteriore [Layer]% di Danno da Tentacolo."
  },
  State_121377_Name = {
    Text = "<RetainIconKeywords:Conservare>: All'inizio di ogni turno, ottieni 500 Keyflare"
  },
  State_121378_Name = {
    Text = "<RetainIconKeywords:Conservare>: Recupero PV e generazione Scudo del Personaggio di tutti i Risvegliati +40%"
  },
  State_121380_Name = {
    Text = "<RetainIconKeywords:Conservare>: Generazione di Aliemus di tutti i Risvegliati +50%"
  },
  State_121719_Name = {
    Text = "<RippleKeywords:Onda d'Urto Residua>: Pesca 1 carta e ottieni [DescArg1] <PowerIconKeywords:FOR> Temporanea"
  },
  State_121734_Desc = {
    Text = "Per ogni Carta di Comando giocata, scarta una Carta con il Costo di Arithmetica più basso del Risvegliato."
  },
  State_121734_Name = {
    Text = "Flusso di Follia"
  },
  State_121735_Desc = {
    Text = "Il Costo di Arithmetica di tutte le Carte di Comando aumenta di 1. Alla fine di ogni 3 turni, aggiungi 1 \"Pietrificazione Graduale\" alla tua mano."
  },
  State_121735_Name = {
    Text = "Flusso di Pianto"
  },
  State_121736_Desc = {
    Text = "A fine turno, ripristina il 10% degli HP persi, rimuovi i debuff da te stesso e i buff dalla tua squadra."
  },
  State_121736_Name = {
    Text = "Flusso di Nascita"
  },
  State_121737_Desc = {
    Text = "All'inizio della battaglia, ottieni 15 cariche di \"Barriera Temporanea\". A fine turno, ottieni 15 cariche di \"Barriera Temporanea\" e applica \"Dissoluzione Temporanea\" a 10 carte casuali."
  },
  State_121737_Name = {
    Text = "Flusso di Flagello"
  },
  State_121738_Desc = {
    Text = "La Generazione di FOR dei Risvegliati è ridotta del 75%. Ogni volta che si perdono HP, ottieni [DescArg1] Scudo e 1 carica di Fortezza Temporanea."
  },
  State_121738_Name = {
    Text = "Flusso dell'Eresia"
  },
  State_121739_Desc = {
    Text = "Il Limite Aliemus di tutti i Risvegliati è aumentato del 50%. Alla fine di ogni turno, tutti i Risvegliati perdono 10 Aliemus e ripristinano il 3% dei loro HP massimi."
  },
  State_121739_Name = {
    Text = "Flusso di Paura"
  },
  State_121740_Desc = {
    Text = "All'inizio del combattimento e alla fine di ogni turno, ottiene 2 strati temporanei di <ResentChainsKeywords:Catene del Risentimento>."
  },
  State_121740_Name = {
    Text = "Flusso dell'Inganno"
  },
  State_121797_Desc = {
    Text = "Tutti i Danni, le cure e gli effetti Scudo inflitti sono ridotti del 10%, limite di 2 strati, non può essere dissipato. Tutti gli effetti Ammaliato vengono rimossi dal bersaglio alla morte dell'ultimo applicatore di Ammaliato."
  },
  State_121797_Name = {
    Text = "<PVPLostSoulKeyWords:Ammaliamento>"
  },
  State_121798_Desc = {
    Text = "Il Danno inflitto, la cura e l'effetto Scudo vengono ridotti del [DescArg1]%, non può essere disperso. Limite di 2 accumuli.\nRimosso dopo aver ottenuto un'Uccisione<StatusApplier:>."
  },
  State_121798_Name = {
    Text = "Ammaliamento"
  },
  State_121799_Name = {
    Text = "Capitolo Quattro: Carta Supporto di Lemuria"
  },
  State_121850_Desc = {
    Text = "DAN da Tentacolo -80%"
  },
  State_121850_Name = {
    Text = "Golia: Supporto"
  },
  State_121863_Name = {
    Text = "<RippleKeywords:Onda d'Urto Residua>: Pesca 2 carte"
  },
  State_121878_Name = {
    Text = "Prima selezione della narrativa Maledizione Inversa"
  },
  State_122428_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_122428_Name = {
    Text = "Non Risvegliato"
  },
  State_122431_Desc = {
    Text = "Quando Mouchette infligge Danno non bloccato, ottiene 2 accumuli di <Monster_Fervor:Fervore Temporaneo>."
  },
  State_122431_Name = {
    Text = "Vestigia del Reame di Nebbia"
  },
  State_122441_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del Destino>: Equipaggia per ottenere 3 accumuli di <PVPReciprocalKeywords:Momento del Conto alla Rovescia>."
  },
  State_122441_Name = {
    Text = "Conto alla rovescia di Capodanno"
  },
  State_122442_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del Destino>: Equipaggia per ottenere <Block:[Block:StateArg1]> Scudo e <Energy:[Energy:StateArg1]> Aliemus. Alla fine del turno, questa Ruota del Destino viene automaticamente disequipaggiata. La prossima volta che il Mazzo di Pesca viene rimischiato, colloca questa RdD nel Mazzo di Pesca, e l'Aliemus e lo Scudo ottenuti equipaggiando \"Caro Babbo Natale\" +[StateArg2]."
  },
  State_122442_Name = {
    Text = "Caro Babbo Natale"
  },
  State_122443_Desc = {
    Text = "A inizio turno, conteggio accumuli -1. Una volta esauriti gli accumuli, dissolve i debuff da sé e ottiene 100 Aliemus, poi riacquista 3 accumuli di Conto alla rovescia. Cambiare la Ruota del destino rimuoverà gli accumuli."
  },
  State_122443_Name = {
    Text = "<PVPFlowerKeywords:Momento del Conto alla Rovescia>"
  },
  State_122596_Desc = {
    Text = "Impossibile giocare carte, impossibile scatenare Esaltazione."
  },
  State_122596_Name = {
    Text = "<Seal1:Sigillato>"
  },
  State_122636_Desc = {
    Text = "La prima \"Abilità\" giocata ogni turno ha Danno, Guarigione e Scudo del Personaggio +[StateArg1]%."
  },
  State_122636_Name = {
    Text = "Spilla di Rubino"
  },
  State_122650_Desc = {
    Text = "La reliquia <OrangeQuality:Guanti Arcani> ha aggiunto questa carta."
  },
  State_122650_Name = {
    Text = "Carta Strana"
  },
  State_122654_Name = {
    Text = "Tenterà di ripristinare un mazzo giocatore vuoto all'Inizio del turno e dopo la fine del turno. Un mazzo non vuoto non verrà ripristinato."
  },
  State_122706_Name = {
    Text = "<CardKeyWord:Desiderio di ricongiungimento>"
  },
  State_122707_Desc = {
    Text = "Tratta questa come l'ultima \"Abilità\" giocata in questo turno. Costo di Arithmetica -1."
  },
  State_122707_Name = {
    Text = "<CardKeyWord:Desiderio di ricongiungimento>"
  },
  State_123109_Desc = {
    Text = "Unico per Squadra: Il tuo primo acquisto di un'\"Orazione\" nel negozio \"D-segno\" o il tuo primo acquisto di un oggetto scontato nelle \"Rovine di Cenere\" ha una probabilità del <WeaponEffect_Num:[StateArg1]%> di costare 0 Sigilli Neri. Può attivarsi solo una volta per Esplorazione."
  },
  State_123109_WeaponDesc = {
    Text = "Il primo acquisto di un\"Orazione\" nel \"D-marchio\", o il primo acquisto di un articolo scontato nelle \"Rovine Cinerea\", ha una probabilità del <WeaponEffect_Num:[StateArg1]%> di richiedere 0 Il sigillo nero. Può attivarsi al massimo 1 volta per esplorazione."
  },
  State_123177_Desc = {
    Text = "Si azzera a inizio turno. Dopo aver raggiunto 10 accumuli, la prossima volta che viene giocata una carta, Mouchette agisce immediatamente, rimuovendo \"Fervore Temporaneo\" e aggiungendo l'intenzione \"Esplosione Mortale\"."
  },
  State_123177_Name = {
    Text = "Fervore Temporaneo"
  },
  State_123178_Desc = {
    Text = "L'effetto di Guarigione di <Guaiwusiwangdikang:Resistenza alla Morte> è aumentato di 5 volte. Per ogni carta giocata dal nemico, ottiene 1 accumulo di <Monster_Fervor:Fervore Temporaneo>."
  },
  State_123178_Name = {
    Text = "Risveglio scontroso"
  },
  State_123243_Desc = {
    Text = "Rimuovi tutti gli accumuli di questo stato quando uccidi un nemico. Ottieni 30 Aliemus per ogni accumulo rimosso, fino a un massimo di 2 accumuli."
  },
  State_123243_Name = {Text = "Vortice"},
  State_123246_Desc = {
    Text = "Rimuovi tutti gli accumuli di questo stato quando uccidi un nemico. Ottieni 30 Aliemus per ogni accumulo rimosso, fino a un massimo di 2 accumuli."
  },
  State_123246_Name = {
    Text = "<PVPWaterPowerKeyWords:Vortice>"
  },
  State_123294_Desc = {
    Text = "Questo turno, [DescArg1] carte sono state pescate tramite \"Colpo\"."
  },
  State_123294_Name = {
    Text = "Furia Cieca"
  },
  State_123507_Desc = {
    Text = "Unico per Squadra: All'inizio dell'esplorazione, aggiungi 1 carta \"Momento del Conto alla Rovescia: 5\" al mazzo. \"Momento del Conto alla Rovescia: 5\": Pesca 1 carta dopo essere stata giocata, mischia il prossimo \"Momento del Conto alla Rovescia\" nella Pila degli scarti, <DestructionKeywords:Distruzione>. \"Momento del Conto alla Rovescia: 0\": Pesca 3 carte, ottieni 3 Arithmetica e hai una probabilità del <WeaponEffect_Num:[StateArg1]%> di mischiare \"Momento del Conto alla Rovescia: 5\" nella Pila degli scarti, Conserva, Distruggi."
  },
  State_123507_WeaponDesc = {
    Text = "All'inizio dell'esplorazione, aggiungi 1 carta \"Momento del Conto alla Rovescia: 5\" al mazzo. \"Momento del Conto alla Rovescia: 5\": Pesca 1 carta dopo essere stata giocata, mischia il prossimo \"Momento del Conto alla Rovescia\" nella Pila degli scarti, <DestructionKeywords:Distruzione>. \"Momento del Conto alla Rovescia: 0\": Pesca 3 carte, ottieni 3 Arithmetica e hai una probabilità del <WeaponEffect_Num:[StateArg1]%> di mischiare \"Momento del Conto alla Rovescia: 5\" nella Pila degli scarti, Conserva, Distruggi."
  },
  State_123520_Desc = {
    Text = "Unico per Squadra: Dopo il primo rilascio di Posse in ogni turno, c'è una probabilità del <WeaponEffect_Num:[StateArg1]>% di pescare 1 \"Colpo\" del Portatore."
  },
  State_123520_WeaponDesc = {
    Text = "Dopo il primo rilascio di Posse in ogni turno, c'è una probabilità del <WeaponEffect_Num:[StateArg1]>% di pescare 1 \"Colpo\" del Portatore."
  },
  State_123521_Desc = {
    Text = "Unico per Squadra: DAN Base di Esaltazione e Caccia del Portatore +<WeaponEffect_Num:[StateArg1]%>. Dopo aver giocato un \"Colpo\" di qualsiasi Risvegliato in questo turno, il DAN del \"Colpo\" del Portatore temporaneamente +<WeaponEffect_Num:[StateArg2]%> dell'ATT del Portatore. Questo effetto si attiva fino a 8 volte per turno."
  },
  State_123521_WeaponDesc = {
    Text = "DAN Base di Esaltazione e Caccia del Portatore +<WeaponEffect_Num:[StateArg1]%>. Dopo aver giocato un \"Colpo\" di qualsiasi Risvegliato in questo turno, il DAN del \"Colpo\" del Portatore temporaneamente +<WeaponEffect_Num:[DescArg2]>. Questo effetto si attiva fino a 8 volte per turno."
  },
  State_123810_Desc = {
    Text = "Sostituisci l'intenzione attuale del nemico con \"Impossibilitato ad Agire\"."
  },
  State_123810_Name = {
    Text = "<HunmiKeywords:Faint>"
  },
  State_123812_Desc = {
    Text = "A fine turno, il Costo di Arithmetica diminuisce."
  },
  State_123812_Name = {
    Text = "<PrepareKeywords:Preparazione>"
  },
  State_123994_Desc = {
    Text = "Impossibile agire."
  },
  State_123994_Name = {
    Text = "Sonno di Qualità"
  },
  State_124010_Desc = {
    Text = "All'inizio del prossimo turno, ottieni [Layer] Arithmetica."
  },
  State_124010_Name = {
    Text = "Arithmetica Ritardata"
  },
  State_124024_Desc = {
    Text = "In questo turno, sono state giocate [Layer] carte \"Colpo\", attivando [DescArg1] volte \"Incontro Drammatico\"."
  },
  State_124024_Name = {
    Text = "Incontro Drammatico"
  },
  State_124034_Desc = {
    Text = "DAN del \"Colpo\" di tutti i Risvegliati +[StateArg1] per [Layer] turni."
  },
  State_124034_Name = {
    Text = "Brillante☆Tornado"
  },
  State_124037_Desc = {
    Text = "Conteggio colpi di Mouchette +1, DAN del \"Colpo\" di tutti i Risvegliati +[StateArg1] per [Layer] turni."
  },
  State_124037_Name = {
    Text = "Brillante☆Tornado"
  },
  State_124107_Desc = {
    Text = "Alla morte del \"Germoglio Stellare\", diventa immune a tutti i Danni e al Risveglio, raddoppiando i PV massimi e ottenendo PV massimi aggiuntivi pari ai PV rimanenti. Dissolve tutti i debuff su di sé."
  },
  State_124107_Name = {
    Text = "Non Risvegliato"
  },
  State_124108_Name = {
    Text = "Conteggio Voci dall'Oltre"
  },
  State_124109_Desc = {
    Text = "Il <RetaliateIconKeywords:Contatore> ottenuto da questa unità beneficia inoltre di un bonus del 5% di <PowerIconKeywords:FOR>. Dopo aver perso [DescArg1] PV in un singolo turno, scambia posizione con \"La Cantante\""
  },
  State_124109_Name = {
    Text = "Fascia Secondaria"
  },
  State_124111_Desc = {
    Text = "Il Recupero PV della Resistenza alla Morte è aumentato al 25%. Per ogni Carta di comando giocata dal nemico, <TouquKeywords:Ruba> temporaneamente [DescArg1] <PowerIconKeywords:FOR>."
  },
  State_124111_Name = {
    Text = "Luce Stellare Infinita"
  },
  State_124112_Desc = {
    Text = "Alla morte de \"La Cantante\", diventa immune a tutti i DAN e alla Stimolazione, raddoppiando i PV Max e ottenendo PV Max aggiuntivi pari ai PV rimanenti."
  },
  State_124112_Name = {
    Text = "Non Risvegliato"
  },
  State_124113_Desc = {
    Text = "L'avversario non scarterà le carte dalla mano a fine turno. Alla fine del turno, infligge in ordine 2 accumuli di stato <FragileIconKeywords:Fragile>, <WeaknessIconKeywords:Debolezza>, <HeavyInjuryKeywords:Flagello> e <VulnerabilityIconKeywords:Vulnerabile>."
  },
  State_124113_Name = {
    Text = "Voci dall'Oltre"
  },
  State_124115_Desc = {
    Text = "Gli effetti di <FragileIconKeywords:Fragile>, <HeavyInjuryKeywords:Flagello> e <WeaknessIconKeywords:Sintomo: Debolezza> vengono aumentati al 50%. Dopo aver giocato altre [DescArg1] carte <SlowIconKeywords:Stagnazione>, scambia la posizione con \"Germoglio Stellare\"."
  },
  State_124115_Name = {
    Text = "Viaggiatore Planetario"
  },
  State_124121_Name = {
    Text = "Conteggio Viaggiatore Planetario"
  },
  State_124122_Name = {
    Text = "Ascoltatore del Giocatore Viaggiatore Planetario"
  },
  State_124190_Desc = {
    Text = "Il <RetaliateIconKeywords:Contatore> ottenuto da questa unità beneficia di un bonus aggiuntivo del 5% di <PowerIconKeywords:FOR>."
  },
  State_124190_Name = {
    Text = "Fascia Secondaria"
  },
  State_124193_Name = {
    Text = "L'effetto di guarigione della Resistenza alla Morte è aumentato al 25%."
  },
  State_124198_Desc = {
    Text = "Gli effetti di <FragileIconKeywords:Fragile>, <HeavyInjuryKeywords:Flagello> e <WeaknessIconKeywords:Sintomo: Debolezza> inflitti vengono aumentati al 50%."
  },
  State_124198_Name = {
    Text = "Viaggiatore Planetario"
  },
  State_124277_Desc = {
    Text = "Visualizzazione dei valori intermedi nel processo di esecuzione."
  },
  State_124277_Name = {
    Text = "Stampa Valore 2"
  },
  State_124278_Desc = {
    Text = "Visualizzazione dei valori intermedi nel processo di esecuzione."
  },
  State_124278_Name = {
    Text = "Stampa Valore 4"
  },
  State_124279_Desc = {
    Text = "Visualizzazione dei valori intermedi nel processo di esecuzione."
  },
  State_124279_Name = {
    Text = "Stampa Valore 5"
  },
  State_124280_Desc = {
    Text = "Visualizzazione dei valori intermedi nel processo di esecuzione."
  },
  State_124280_Name = {
    Text = "Stampa Valore 1"
  },
  State_124282_Desc = {
    Text = "Visualizzazione dei valori intermedi nel processo di esecuzione."
  },
  State_124282_Name = {
    Text = "Stampa Valore 7"
  },
  State_124283_Desc = {
    Text = "Visualizzazione dei valori intermedi nel processo di esecuzione."
  },
  State_124283_Name = {
    Text = "Valore Stampa 8"
  },
  State_124284_Desc = {
    Text = "Visualizzazione dei valori intermedi nel processo di esecuzione."
  },
  State_124284_Name = {
    Text = "Valore Stampa 9"
  },
  State_124285_Desc = {
    Text = "Visualizzazione dei valori intermedi nel processo di esecuzione."
  },
  State_124285_Name = {
    Text = "Valore Stampa 10"
  },
  State_124286_Desc = {
    Text = "Visualizzazione dei valori intermedi nel processo di esecuzione."
  },
  State_124286_Name = {
    Text = "Stampa Valore 6"
  },
  State_124287_Desc = {
    Text = "Visualizzazione dei valori intermedi nel processo di esecuzione."
  },
  State_124287_Name = {
    Text = "Stampa Valore 3"
  },
  State_124736_Desc = {
    Text = "Verifica se il parametro 3 dell'interfaccia BEAttachPostAction filtra o attiva correttamente il trigger corrispondente."
  },
  State_124736_Name = {
    Text = "Test ascoltatore 1"
  },
  State_124747_Desc = {
    Text = "Verifica se il parametro 3 dell'interfaccia BEAttachPostAction filtra o attiva correttamente il trigger corrispondente."
  },
  State_124747_Name = {
    Text = "Test Listener 2"
  },
  State_124748_Desc = {
    Text = "Quando il nemico gioca carte con <BurningKeywords:Bruciatura>, ottieni 1 accumulo di <MonsterExFlameKeywords:Deflagrazione>, ma perdi temporaneamente [DescArg1] <PowerIconKeywords:FOR>."
  },
  State_124748_Name = {
    Text = "Fiamma inestinguibile"
  },
  State_124752_Desc = {
    Text = "Verifica se il parametro 3 dell'interfaccia BEAttachPostAction filtra o attiva correttamente il trigger corrispondente."
  },
  State_124752_Name = {
    Text = "Test Listener 3"
  },
  State_124753_Desc = {
    Text = "Verifica se il parametro 3 dell'interfaccia BEAttachPostAction filtra o attiva correttamente il trigger corrispondente."
  },
  State_124753_Name = {
    Text = "Test Listener 4"
  },
  State_124754_Desc = {
    Text = "Verifica se il parametro 3 dell'interfaccia BEAttachPostAction filtra o attiva correttamente il trigger corrispondente."
  },
  State_124754_Name = {
    Text = "Test Listener 5"
  },
  State_124765_Desc = {
    Text = "Tasso di Crit. aumentato del [Layer]%."
  },
  State_124765_Name = {
    Text = "Tasso di Crit."
  },
  State_124766_Desc = {
    Text = "Tasso di Crit. aumentato del [Layer]% in questa battaglia."
  },
  State_124766_Name = {
    Text = "Tasso di Crit."
  },
  State_124766_WeaponDesc = {
    Text = "Tasso di Crit. aumentato del [Layer]% in questa battaglia."
  },
  State_124767_Desc = {
    Text = "Danno Crit. aumentato del [Layer]%."
  },
  State_124767_Name = {
    Text = "Danno critico"
  },
  State_124811_Desc = {
    Text = "Verifica se il parametro 3 dell'interfaccia BEAttachPostAction filtra o attiva correttamente il trigger corrispondente."
  },
  State_124811_Name = {
    Text = "Test Listener 8"
  },
  State_124812_Desc = {
    Text = "Verifica se il parametro 3 dell'interfaccia BEAttachPostAction filtra o attiva correttamente il trigger corrispondente."
  },
  State_124812_Name = {
    Text = "Test Listener 7"
  },
  State_124813_Desc = {
    Text = "Verifica se il parametro 3 dell'interfaccia BEAttachPostAction filtra o attiva correttamente il trigger corrispondente."
  },
  State_124813_Name = {
    Text = "Test Listener 6"
  },
  State_124826_Desc = {
    Text = "Verifica se il parametro 3 dell'interfaccia BEAttachPostAction filtra o attiva correttamente il trigger corrispondente."
  },
  State_124826_Name = {
    Text = "Test Listener 9"
  },
  State_124843_Desc = {
    Text = "Verifica i listener dei trigger BSTAfterAttachPostAction e BSTAfterDoActiveDamage.AttachPostAction"
  },
  State_124843_Name = {
    Text = "Test Listener 9"
  },
  State_124886_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo che il Portatore gioca una Carta abilità, pesca [StateArg1] carte, dando priorità alle carte di altri Risvegliatori. L'effetto può attivarsi solo una volta per turno."
  },
  State_124886_Name = {
    Text = "Rota Fortunae"
  },
  State_124887_Desc = {
    Text = "Il numero di colpi del Danno di \"Intreccio\" di questo Risvegliatore aumenta di [Layer]."
  },
  State_124887_Name = {Text = "Trama"},
  State_124888_Desc = {
    Text = "Si trasforma in un'\"Abilità\" nemica casuale con costo -1 dopo essere giocata."
  },
  State_124888_Name = {
    Text = "<CardKeyWord:Profezia>"
  },
  State_124890_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo \"Esaltazione\", fa sì che la prossima [StateArg1] \"Abilità\" giocata si attivi 2 volte."
  },
  State_124890_Name = {
    Text = "Trama dell'Eternità"
  },
  State_124892_Name = {
    Text = "<CardKeyWord:Profezia>"
  },
  State_124916_Desc = {
    Text = "Alla fine del turno, rimuovi tutti gli accumuli e infliggi [DescArg1] Danno passivo. Non può essere dissolto."
  },
  State_124916_Name = {
    Text = "Morte predestinata"
  },
  State_124917_Desc = {
    Text = "Alla fine del turno, rimuovi tutti gli accumuli e infliggi Danno passivo. Non può essere dissolto."
  },
  State_124917_Name = {
    Text = "<PVPDestinedDeathKeyWords:Morte predestinata>"
  },
  State_124992_Desc = {
    Text = "Le prossime [DescArg1] carte \"Abilità\" hanno effetto 1 volta aggiuntiva."
  },
  State_124992_Name = {
    Text = "Trascendere"
  },
  State_124993_Desc = {
    Text = "Il Danno attivo inflitto e subito viene applicato come una quantità equivalente di <PVPDestinedDeathKeyWords:Presagio Destinato>. Non può essere dissolto."
  },
  State_124993_Name = {
    Text = "Fuso del Destino"
  },
  State_124997_Desc = {
    Text = "Il Danno attivo letale inflitto e subito viene invece convertito nell'applicazione di un equivalente <PVPDestinedDeathKeyWords:Presagio Destinato>. Non può essere disperso."
  },
  State_124997_Name = {
    Text = "<PVPEternalDimensionKeyWords:Moira, come decreto>"
  },
  State_125002_Name = {
    Text = "Stato@Listener Valore Scudo Fase Scarto Giocatore Generale"
  },
  State_125003_Name = {
    Text = "Valore Scudo"
  },
  State_125004_Name = {
    Text = "Stato@Conteggio Applicazione Scudo Giocatore Generale"
  },
  State_125472_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: dopo «Esplosione di follia», applica [StateArg1] stack di <PVPLostSoulKeyWords:ebbrezza> al nemico con <HPAndShieldMax:vita e scudo più alti>."
  },
  State_125472_Name = {
    Text = "Lusinghe di Magnolia"
  },
  State_125486_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo che gli altri alleati scatenano l'\"Esaltazione\", riduci il Costo di Arithmetica di tutte le \"Abilità\" appartenenti al portatore nella mano di [StateArg1]."
  },
  State_125486_Name = {
    Text = "Rimpianti Vani"
  },
  State_125925_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_125925_Name = {
    Text = "Non Risvegliato"
  },
  State_125926_Name = {
    Text = "Stato@Listener Cambio Intento Giocatore Mostro Tawil"
  },
  State_125927_Desc = {
    Text = "Dopo aver giocato [DescArg1] Carte di comando, cambia l'intenzione in \"Sei Ali\"."
  },
  State_125927_Name = {
    Text = "Quattro Ali"
  },
  State_125928_Desc = {
    Text = "Dopo aver giocato una Carta di comando, sigilla l'Esaltazione del Risvegliatore corrispondente e tutte le Carte di comando per 2 turni."
  },
  State_125928_Name = {
    Text = "Pignoni del Tempo"
  },
  State_125929_Desc = {
    Text = "Dopo aver subito [DescArg1] DAN in un singolo turno, ottieni 70 accumuli di <ReinforceColour:Fortezza> Temporaneo e 1 accumulo di <ResentChainsKeywords:Catene del risentimento>."
  },
  State_125929_Name = {
    Text = "Esistenza Inesistente"
  },
  State_125933_Desc = {
    Text = "Dopo aver giocato [DescArg1] Carte di comando, cambia l'intenzione in \"Quattro Ali\"."
  },
  State_125933_Name = {
    Text = "Ali Gemelle"
  },
  State_125934_Desc = {
    Text = "Quando si consuma Arithmetica, il Keyflare ottenuto è ridotto del 50%. Dopo che Tawil infligge danni non bloccati, aggiungi 1 \"<DerivativeCardKeywords_131:Paradosso Temporale EX>\" alla mano."
  },
  State_125934_Name = {
    Text = "Il Portale della Chiave d'Argento"
  },
  State_125935_Name = {Text = "Silenzio"},
  State_125935_WeaponDesc = {
    Text = "Quando pescata, applica Debolezza a te stesso per 1 turno. Quando usata, applica Debolezza a tutti i nemici per 1 turno. Non può essere venduta."
  },
  State_125937_Desc = {
    Text = "Dopo aver giocato una Carta di comando, sigilla l'Esaltazione del Risvegliatore corrispondente e tutte le Carte di comando per 2 turni."
  },
  State_125937_Name = {
    Text = "Pignoni del Tempo"
  },
  State_125964_Desc = {
    Text = "Quando si consuma Arithmetica, la Keyflare ottenuta -50%. Dopo che Tawil infligge Danno non bloccato, metti 1 \"<DerivativeCardKeywords_131:Paradosso Temporale EX>\" nella mano."
  },
  State_125964_Name = {
    Text = "Il Portale della Chiave d'Argento"
  },
  State_126010_Desc = {
    Text = "Unico per Squadra: Il Veleno fisso e gli effetti di Veleno attivato del portatore sono aumentati del <WeaponEffect_Num:[StateArg1]%>, e la <EmbryoFusionIconKeywords:Fusione Embrionale> ripristinata automaticamente nel Reame di Caro è aumentata del <WeaponEffect_Num:[StateArg2]%>. La prima volta che il portatore attiva la \"Risonanza\" ogni turno, gli altri Risvegliatori ottengono <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_126010_WeaponDesc = {
    Text = "Il Veleno Fisso e gli effetti di Veleno Attivato del portatore +<WeaponEffect_Num:[StateArg1]%>, e la <EmbryoFusionIconKeywords:Fusione Embrionale> ripristinata automaticamente dal Reame di Caro +<WeaponEffect_Num:[StateArg2]%>. La prima volta che il portatore attiva la \"Risonanza\" ogni turno, gli altri Risvegliatori ottengono <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_126463_Name = {
    Text = "Stato@Listener Danno Luce Seduttrice Mostro Liz"
  },
  State_126464_Desc = {
    Text = "Massimo 10 accumuli, ogni accumulo aumenta i DAN inflitti da Liz del [DescArg1]."
  },
  State_126464_Name = {
    Text = "<GreenWord:Scintilla Verdeggiante>"
  },
  State_126465_Name = {
    Text = "Listener Intenzione Mostro Liz"
  },
  State_126466_Desc = {
    Text = "L'avversario non scarterà la propria mano alla fine del proprio turno. Quando l'intenzione passa a Fiamme Verdi: se ci sono almeno 6 cariche di <MonsterLizVerdantSpark:Brace di Smeraldo>, consuma 6 cariche per potenziare l'intenzione a \"Fiamme Letali\" che infligge <Damage:[Damage:DescArg1]> DAN [AttackTimes:DescArg2] volte; se ci sono almeno 3 cariche, consuma 3 cariche per potenziare l'intenzione a \"Fiamme Corrotte\" che infligge <Damage:[Damage:DescArg3]> DAN [AttackTimes:DescArg4] volte."
  },
  State_126466_Name = {
    Text = "Fiamme Eterne"
  },
  State_126467_Desc = {
    Text = "Questo Risvegliato non è ancora stato Risvegliato... Si Risveglierà quando starà per essere sconfitto, ripristinerà i PV e combatterà a piena potenza, conferendo l'abilità di rimuovere gli stati negativi per \"Danza verso la distruzione.\""
  },
  State_126467_Name = {
    Text = "Non Risvegliato"
  },
  State_126468_Name = {
    Text = "Stato@Gestione Riflesso di Smeraldo Mostro Liz"
  },
  State_126469_Desc = {
    Text = "Per ogni [DescArg1] HP persi, ottieni [DescArg2] accumulo/i di <MonsterLizVerdantSpark:Brace di Smeraldo>."
  },
  State_126469_Name = {
    Text = "Riflesso di Smeraldo"
  },
  State_126470_Name = {
    Text = "Stato@Conteggio Suggerimenti Mostro Liz"
  },
  State_126479_Desc = {
    Text = "Massimo 10 accumuli, aumenta i DAN inflitti da Liz."
  },
  State_126479_Name = {
    Text = "<GreenWord:Scintilla Verdeggiante>"
  },
  State_126540_Desc = {
    Text = "Quando la Risonanza viene attivata per le successive [Layer] volte, l'effetto di Risonanza è raddoppiato."
  },
  State_126540_Name = {
    Text = "Giuramento Avvolto nella Nebbia"
  },
  State_126568_Desc = {
    Text = "Ogni volta che un Risvegliatore infligge Danno attivo, comanda 1 Tentacolo di attaccare il bersaglio, infliggendo [Layer]% di Danno Tentacolo."
  },
  State_126568_Name = {
    Text = "Onde Furiose"
  },
  State_126569_Desc = {
    Text = "Ogni volta che il Risvegliatore infligge danni attivi, comanda 1 Tentacolo di attaccare il bersaglio, infliggendo il 50% di Danni da tentacolo."
  },
  State_126569_Name = {
    Text = "Onde Furiose"
  },
  State_126643_Desc = {
    Text = "Questo stato ha MaxLayer=1. Risvegliatore di origine: [DescArg1]"
  },
  State_126643_Name = {
    Text = "Limite Livello 1"
  },
  State_126644_Desc = {
    Text = "Dopo l'ottenimento, cancella e riapplica [Layer] accumuli dello Stato Dimostrazione. \n Il numero massimo di accumuli per lo Stato Dimostrazione è 1."
  },
  State_126644_Name = {
    Text = "Supera il massimo di accumuli"
  },
  State_126645_Desc = {
    Text = "Il DAN Base di Ramona aumenta del [DescArg1]%"
  },
  State_126645_Name = {
    Text = "Tempra Sublime"
  },
  State_126651_Desc = {
    Text = "L'ascoltatore dopo aver scatenato la Caccia è stato soddisfatto [Layer] volte."
  },
  State_126651_Name = {Text = "Contatore"},
  State_126652_Desc = {
    Text = "Dopo l'ottenimento, ordina al nemico in prima fila di aggiungere un'azione ritardata, eseguendo la sua intenzione attuale."
  },
  State_126652_Name = {
    Text = "Fai dare la Caccia al mostro"
  },
  State_126653_Desc = {
    Text = "Dopo l'ottenimento, consenti al Risvegliatore in posizione 1 di aggiungere un'azione di follow-up per giocare la sua Carta Attacco."
  },
  State_126653_Name = {
    Text = "Ordina al Risvegliatore di dare la Caccia"
  },
  State_126654_Desc = {
    Text = "Quando l'Ascoltatore Nominato viene attivato, stampa il conteggio 1 volta."
  },
  State_126654_Name = {
    Text = "Ascoltatore Nominato"
  },
  State_126655_Desc = {
    Text = "Dopo l'ottenimento, ordina al Custode di aggiungere un'azione di follow-up e giocare l'abilità @Protagonist Skill@Voci nella Tua Testa."
  },
  State_126655_Name = {
    Text = "Ordina al Custode di dare la Caccia"
  },
  State_126677_Desc = {
    Text = "In questo turno, la prossima [Layer] \"Lama della Sfida\" ha effetto due volte."
  },
  State_126677_Name = {
    Text = "Leviatano Primordiale"
  },
  State_126678_WeaponDesc = {
    Text = "Tutti i Danni da Salto di Balzo della Balena +1."
  },
  State_126714_Desc = {
    Text = "La prossima [Layer] \"Difesa\" di Aigis ha effetto 3 volte."
  },
  State_126714_Name = {
    Text = "Lacrima Cristallizzata"
  },
  State_126714_WeaponDesc = {
    Text = "Tutti i Danni da Salto di Balzo della Balena +1."
  },
  State_126715_WeaponDesc = {
    Text = "Tutti i Danni da Salto di Balzo della Balena +1."
  },
  State_126776_Desc = {
    Text = "Per ogni accumulo, Veleno Fisso subito +5%, Danno inflitto -[DescArg1]%. Si accumula fino a [DescArg2]."
  },
  State_126776_Name = {
    Text = "<WitherKeywords:Ammaliamento>"
  },
  State_126783_Name = {
    Text = "Temporaneamente deprecato"
  },
  State_126784_Desc = {
    Text = "Veleno Fisso subito +[DescArg1]%, DAN inflitti -[DescArg2]%. Si accumula fino a [DescArg3]."
  },
  State_126784_Name = {
    Text = "Ammaliamento"
  },
  State_126785_Desc = {
    Text = "Se altri Risvegliati hanno giocato un totale di X Carte di comando, attiva effetti aggiuntivi dopo aver giocato questa carta. Il Risvegliato a cui appartiene questa carta vedrà la propria Risonanza azzerata quando una qualsiasi delle sue carte viene giocata, o alla fine del turno."
  },
  State_126785_Name = {
    Text = "<ResonanceKeywords:Risonanza X>"
  },
  State_126789_Desc = {
    Text = "Infliggi 2 accumuli di <WitherKeywords:Malia> a tutti i nemici."
  },
  State_126789_Name = {
    Text = "<WitherKeywords1:Promessa nuziale>"
  },
  State_126790_Desc = {
    Text = "Rimuovi l'\"<WitherKeywords:Ammaliato>\" da tutti i nemici. Per ogni accumulo rimosso, infliggi il [DescArg1]% dei PV massimi del bersaglio come Danno Fisso e attiva il 40% del Veleno."
  },
  State_126790_Name = {
    Text = "<WitherKeywords2:Soggiogamento>"
  },
  State_126803_Desc = {
    Text = "Le prossime [DescArg1] Carte di comando giocate verranno inviate nel futuro di 3 turni."
  },
  State_126803_Name = {
    Text = "Orbis Fatum"
  },
  State_126893_Name = {
    Text = "Stato@Identificatore Puro Destino Ultra"
  },
  State_126895_Desc = {
    Text = "Il Danno Finale di questa carta, il guadagno fisso di <PowerIconKeywords:Potere> e <TentacleInjurieIconKeywords:Danni da tentacolo>, il <IntoxicationIconKeywords:Veleno> fisso e il <RetaliateIconKeywords:Contrattacco> ciascuno +[DescArg1]%; il Scudo Fisso Finale di questa carta, il Recupero PV Fisso e la <ExhaustionIconKeywords:Riduzione del potere> ciascuno +[DescArg2]%. Le carte con \"Faro di Singolarità\" non possono attivare la \"Navetta Dimensionale\"."
  },
  State_126895_Name = {
    Text = "<SingularityKeywords:Faro di Singolarità [DescArg2]>"
  },
  State_126896_Name = {
    Text = "Stato@La carta Luce della Trascendenza riduce gli accumuli di Armonia di Arithmetica"
  },
  State_126900_Name = {
    Text = "Stato@Inizializzazione Classe Destino Ultra Dimensione 2"
  },
  State_126901_Name = {
    Text = "Stato@Inizializzazione Classe Destino Ultra Dimensione 1"
  },
  State_126903_Name = {
    Text = "Stato@Marcatore Quasar Spazio Ultra"
  },
  State_126927_Desc = {
    Text = "Unico per Squadra: Veleno Fisso ed effetti di Veleno Attivato inflitti dal Portatore +<WeaponEffect_Num:[StateArg1]%>. La prima volta che il Portatore attiva \"Risonanza\" ogni turno, ottiene <WeaponEffect_Num:[StateArg2]> Aliemus."
  },
  State_126927_WeaponDesc = {
    Text = "Veleno Fisso ed effetti di Veleno Attivato inflitti dal Portatore +<WeaponEffect_Num:[StateArg1]%>. Il Portatore ottiene <WeaponEffect_Num:[StateArg2]> Aliemus la prima volta che attiva \"Risonanza\" ogni turno."
  },
  State_126990_Name = {
    Text = "<IntoxicationColour:Veleno>"
  },
  State_127108_Desc = {
    Text = "Infliggi 5 accumuli di <WitherKeywords:Ammaliamento> a tutti i nemici."
  },
  State_127108_Name = {
    Text = "<WitherKeywords3:Promettere>"
  },
  State_127109_Desc = {
    Text = "Rimuovi l'\"<WitherKeywords:Ammaliato>\" da tutti i nemici. Per ogni accumulo rimosso, accumula Fornace Cremisi pari al 20% della COS, infliggi il [DescArg1]% dei PV massimi del bersaglio come Danno Fisso e attiva il 40% del Veleno."
  },
  State_127109_Name = {
    Text = "<WitherKeywords4:Soggiogamento>"
  },
  State_127176_Desc = {
    Text = "Per ogni accumulo, Veleno Fisso subito +5%, Danno inflitto -[DescArg1]%. Si accumula fino a [DescArg2]."
  },
  State_127176_Name = {
    Text = "<WitherKeywords0:Ammaliato>"
  },
  State_127264_Desc = {
    Text = "Quando giochi questa carta, \"La Percettrice\" ottiene 1 accumulo di <MonsterTimeBeacon:Ciclo>. Se questa carta viene scartata, \"La Percettrice\" perde 1 accumulo di <MonsterTimeBeacon:Ciclo>."
  },
  State_127264_Name = {
    Text = "<MonsterSightUnbound:Vista Libera>"
  },
  State_127266_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_127266_Name = {
    Text = "Non Risvegliato"
  },
  State_127267_Desc = {
    Text = "Alla fine del turno, ottieni 1 accumulo di <MonsterTimeBeacon:Ciclo>."
  },
  State_127267_Name = {
    Text = "Entropia Invertita"
  },
  State_127271_Desc = {
    Text = "Dopo aver rilasciato il Seguito, ottieni 1 accumulo di <MonsterTimeBeacon:Ciclo>."
  },
  State_127271_Name = {
    Text = "Prigioniero di Möbius"
  },
  State_127272_Desc = {
    Text = "Massimo 3 accumuli. Quando \"La Percettrice\" scatena l'intenzione con 3 accumuli di <MonsterTimeBeacon:Ciclo>, attiva l'effetto di <MonsterTimeBeacon:Ciclo>, azzera <MonsterTimeBeacon:Ciclo> e rimuove gli stati negativi."
  },
  State_127272_Name = {
    Text = "<WhiteWord:Ciclo>"
  },
  State_127275_Desc = {
    Text = "Per ogni accumulo, Veleno Fisso subito +5%, Danno inflitto -[DescArg1]%. Si accumula fino a [DescArg2]."
  },
  State_127275_Name = {
    Text = "<WitherKeywords:Ammaliamento>"
  },
  State_127276_Desc = {
    Text = "Quando giochi questa carta, \"La Percettrice\" ottiene 1 accumulo di <MonsterTimeBeacon:Ciclo>. Se questa carta viene scartata, \"La Percettrice\" perde 1 accumulo di <MonsterTimeBeacon:Ciclo>."
  },
  State_127276_Name = {
    Text = "<MonsterSightUnbound:Vista Libera>"
  },
  State_127312_Desc = {
    Text = "Quando l'Impulso della Psiche del Risvegliatore raggiunge +12, viene attivato l'\"Assioma Assoluto\", che conferisce effetti unici."
  },
  State_127312_Name = {
    Text = "<UltraPotencyKeywords:Regola Finale>"
  },
  State_127705_Desc = {
    Text = "La carta è stata manomessa! Subisci [Layer] danni quando viene giocata. Riduce gli accumuli di <CardKeyWord:Sabotaggio> della metà."
  },
  State_127705_Name = {
    Text = "<CardKeyWord:Sabotaggio>"
  },
  State_127705_WeaponDesc = {
    Text = "La Carta subisce [StateArg1] Danno quando viene giocata."
  },
  State_127708_Desc = {
    Text = "Dopo che il nemico gioca una carta che non sia una Carta di comando, tutti gli alleati ottengono [DescArg1] accumulo/i di <PowerIconKeywords:Forza>. Diventa inattivo dopo che le Braci dei Giorni Passati vengono Spezzate."
  },
  State_127708_Name = {
    Text = "Filo del Caos"
  },
  State_127709_Name = {
    Text = "Stato Giocatore del Filo Nero"
  },
  State_127710_Name = {
    Text = "Innesco del Filo Nero"
  },
  State_128026_Name = {
    Text = "Stato Giocatore del Filo Bianco"
  },
  State_128027_Desc = {
    Text = "Dopo che il nemico gioca una Carta di comando, tutti gli alleati ottengono [DescArg1] accumuli di <ReinforcePVEKeywords:Rinforzato> Temporaneo. Le Braci Antiche diventano inefficaci dopo essere state spezzate."
  },
  State_128027_Name = {
    Text = "Filo dell'Ordine"
  },
  State_128028_Desc = {
    Text = "La carta è stata manomessa! Una volta giocata, subisci <FixedDamage:DAN Puro> e riduci gli accumuli di <BrokenCard:Sabotaggio> della metà."
  },
  State_128028_Name = {
    Text = "<CardKeyWord:Sabotaggio>"
  },
  State_128028_WeaponDesc = {
    Text = "La Carta subisce [StateArg1] Danno quando viene giocata."
  },
  State_128029_Name = {
    Text = "Innesco del Filo Bianco"
  },
  State_128067_Name = {
    Text = "Stato@Fredda Ancella Ragno Ascoltatore Ceneri"
  },
  State_128069_Name = {
    Text = "Stato@Fredda Ancella Ragno Rilevamento Colpo Intrecciare"
  },
  State_128071_Name = {
    Text = "Stato@Fredda Ancella Ragno Posizione Frontale Richiede Marcatore Evocazione"
  },
  State_128073_Desc = {
    Text = "Ottieni [DescArg1] <plural value=\"[DescArg1]\" singular=\"accumulo\" plural=\"accumuli\"> di <ParcloseIconKeywords:Barriera> e [DescArg2] <plural value=\"[DescArg2]\" singular=\"accumulo\" plural=\"accumuli\"> di <Chapter5_Monster_Fervor1:Fervore> dopo ogni azione."
  },
  State_128073_Name = {
    Text = "Culla della Tessitrice"
  },
  State_128082_Desc = {
    Text = "Gioca questa carta per concedere a Hameln 3 Aliemus."
  },
  State_128082_Name = {
    Text = "<XushiBKeywords:Crescendo>"
  },
  State_128086_Desc = {
    Text = "Dopo che il nemico gioca una Carta di comando, ottieni [DescArg1] accumulo/i di <Chapter5_Monster_Fervor1:Fervore>, e scambia posizione con l'alleato nella retroguardia dopo che \"Braci Antiche\" si esaurisce."
  },
  State_128086_Name = {
    Text = "Rotazione del Destino"
  },
  State_128087_Name = {
    Text = "Stato@Fredda Ancella Ragno Marcatore Innesco Ciclo Bianco"
  },
  State_128089_Name = {
    Text = "Innesco del Ciclo Bianco"
  },
  State_128216_Name = {
    Text = "Stato Giocatore del Ciclo Bianco"
  },
  State_128245_Desc = {
    Text = "Si azzera dopo l'inizio del turno. Al raggiungimento di 10 accumuli, agisce immediatamente la prossima volta che una carta viene giocata, rimuovendo <Chapter5_Monster_Fervor2:Fervore> e cambiando l'intenzione per infliggere <FragileIconKeywords:Fragile> e applicare casualmente <BrokenCard:Sabotaggio> \"Filo del Collasso\"."
  },
  State_128245_Name = {
    Text = "Fervore Temporaneo"
  },
  State_128246_Name = {
    Text = "Stato Giocatore del Ciclo Nero"
  },
  State_128247_Desc = {
    Text = "Alla morte, si rianima con Immunità ai Danni e 100% dei PV. Cambia l'intenzione in \"Fervore Predestinato\": dopo ogni azione, ottiene [DescArg1] <PowerIconKeywords:Forza> e [DescArg2] <Chapter5_Monster_Fervor2:Fervore>."
  },
  State_128247_Name = {
    Text = "Rinascita dal Bozzolo"
  },
  State_128248_Desc = {
    Text = "Si azzera dopo l'inizio del turno. Al raggiungimento di 10 accumuli, agisce immediatamente la prossima volta che una carta viene giocata, rimuove <Chapter5_Monster_Fervor1:Fervore> e cambia l'intenzione in \"Trama del Vincolo\", che infligge <WeaknessIconKeywords:Debolezza> e Sigilla casualmente le Carte di comando."
  },
  State_128248_Name = {
    Text = "Fervore Temporaneo"
  },
  State_128250_Name = {
    Text = "Innesco del Ciclo Nero"
  },
  State_128251_Desc = {
    Text = "Dopo che il nemico gioca una Carta di comando, ottieni [DescArg1] accumulo/i di <Chapter5_Monster_Fervor1:Fervore>, e scambia posizione con l'alleato nella retroguardia dopo che \"Braci Antiche\" si esaurisce."
  },
  State_128251_Name = {
    Text = "Rotazione dell'Abisso"
  },
  State_128253_Desc = {
    Text = "Dopo la morte, si rianima con Immunità ai Danni e 100% dei PV. Cambia l'Intenzione in \"Fervore Predestinato\": dopo ogni azione, ottiene [DescArg1] accumulo/i di <ParcloseIconKeywords:Barriera> e [DescArg2] accumulo/i di <Chapter5_Monster_Fervor1:Fervore>."
  },
  State_128253_Name = {
    Text = "Rinascita dal Bozzolo"
  },
  State_128257_Desc = {
    Text = "Ottieni [DescArg1] <PowerIconKeywords:FOR> e [DescArg2] accumuli di <Chapter5_Monster_Fervor2:Fervore> al termine di ogni azione."
  },
  State_128257_Name = {
    Text = "Sussurro della Tessitrice"
  },
  State_128643_Name = {
    Text = "Stato@Giocatore Conteggio Sintomi Giocati Questo Turno"
  },
  State_128644_Desc = {
    Text = "Si azzera all'inizio del turno. Dopo aver raggiunto 10 accumuli, agisci immediatamente dopo che la prossima carta viene giocata, rimuovendo il <Chapter5_Monster_Fervor3:Fervore> e cambiando casualmente l'intenzione."
  },
  State_128644_Name = {
    Text = "Fervore Temporaneo"
  },
  State_128645_Desc = {
    Text = "L'intenzione verrà scelta casualmente tra quattro tipi, ma non si ripeterà. Cambia immediatamente intenzione dopo aver rilasciato un'Esaltazione. Ottieni 1 accumulo di <Chapter5_Monster_Fervor3:Fervore> dopo aver giocato una Carta di comando."
  },
  State_128645_Name = {
    Text = "Armonia dell'Omnifex"
  },
  State_128646_Name = {
    Text = "Stato@Destino Folle Rilevamento Giocata Colpo Pesante Squalificato"
  },
  State_128648_Desc = {
    Text = "Fino all'inizio del prossimo turno, ottieni [DescArg1] <PowerIconKeywords:FOR> Temporaneo ogni volta che giochi una Carta di comando."
  },
  State_128648_Name = {
    Text = "Bozzolo del Furore"
  },
  State_128692_Desc = {
    Text = "Dopo aver subito danni attivi o danni da tentacolo, rimuovi una quantità equivalente di \"Vecchie Braci\" e perdi il 300% della quantità rimossa in vita; quando si subiscono altri danni, rimuovi la metà. Il numero di \"Vecchie Braci\" si ripristina ogni round."
  },
  State_128692_Name = {
    Text = "<AshesPastKeyWord:Braci dei Giorni Passati>"
  },
  State_128695_Name = {
    Text = "Stato@Destino Folle Marcatore Intenzione"
  },
  State_129297_Desc = {
    Text = "All'inizio delle prossime [Layer] battaglie, imposta gli HP di tutti i nemici a 1."
  },
  State_129297_Name = {
    Text = "L'Aiuto del Piccolo N"
  },
  State_129569_Name = {
    Text = "Stato@Destino Folle Marcatore Innesco Teatro della Gioia"
  },
  State_129570_Name = {
    Text = "Stato@Destino Folle Marcatore Innesco Sussurro del Destino"
  },
  State_129571_Name = {
    Text = "Stato@Destino Folle Marcatore Innesco Nullità Infinita"
  },
  State_129612_Desc = {
    Text = "L'intenzione verrà scelta casualmente tra quattro tipi, ma non si ripeterà. Cambia immediatamente intenzione dopo aver rilasciato un'Esaltazione. Ottieni 1 accumulo di <Chapter5_Monster_Fervor3:Fervore> dopo aver giocato una Carta di comando."
  },
  State_129612_Name = {
    Text = "Armonia dell'Omnifex"
  },
  State_129625_Desc = {
    Text = "L'intenzione verrà scelta casualmente tra quattro tipi, ma non si ripeterà. Cambia immediatamente intenzione dopo aver rilasciato un'Esaltazione. Ottieni 1 accumulo di <Chapter5_Monster_Fervor3:Fervore> dopo aver giocato una Carta di comando. Ottieni 1 accumulo di \"Fusione della Distorsione\" ogni volta che l'intenzione viene cambiata."
  },
  State_129625_Name = {
    Text = "Armonia dell'Omnifex"
  },
  State_129643_Desc = {
    Text = "Ottieni 1 accumulo ogni volta che l'intenzione viene cambiata. Con 10 accumuli di \"Destino Dissolto,\" l'intenzione cambia nell'immutabile \"Emersione Frenetica,\" che infligge Danno massiccio e applica debuff."
  },
  State_129643_Name = {
    Text = "Fusione Distorta"
  },
  State_129644_Name = {
    Text = "Intenzioni della Serratura Fusa Distorta"
  },
  State_129650_Desc = {
    Text = "Unicità di Squadra: Se il portatore è il Risvegliatore \"Circuito·Ramona\", l'Affinità guadagnata dagli altri Risvegliatori al completamento dello stage +<WeaponEffect_Num:[StateArg1]%>, ma il portatore non guadagna Affinità."
  },
  State_129650_WeaponDesc = {
    Text = "Se il portatore è il Risvegliatore \"Circuito·Ramona\", quando uno Stage viene completato, gli altri Risvegliatori ottengono +<WeaponEffect_Num:[StateArg1]%> Affinità, ma il portatore non ottiene alcuna Affinità."
  },
  State_129761_Desc = {
    Text = "Modifica l'interfaccia per restituire l'intensità di crescita in gioco per i giocatori, aumentando dell'1% per ogni accumulo."
  },
  State_129761_Name = {
    Text = "Regolazione dell'Intensità di Crescita in Gioco"
  },
  State_129845_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_129845_Name = {
    Text = "Non Risvegliato"
  },
  State_129846_Name = {
    Text = "Conteggio Scuotimento Spaziale"
  },
  State_129848_Desc = {
    Text = "Ogni volta che [DescArg1] carte lasciano la Fenditura Dimensionale, conferisci loro [DescArg2] accumuli di <BrokenCard:Sabotaggio>."
  },
  State_129848_Name = {
    Text = "Taglio del Futuro"
  },
  State_129849_Desc = {
    Text = "Crea una copia della prima Carta di comando giocata dal nemico ogni turno e collocala nella Fenditura Dimensionale. Quando la carta entra nella Fenditura Dimensionale, applicale <DepleteIconKeywords:Consumo>. La prima volta che un Gruppo viene scatenato ogni turno, prendi la carta più a sinistra e collocala in cima al Mazzo di Pesca."
  },
  State_129849_Name = {
    Text = "Tessere il Destino"
  },
  State_129850_Desc = {
    Text = "Per ogni Carta di comando nella Fenditura Dimensionale, il limite di carte in mano del giocatore diminuisce di 1. Se è già piena, la prossima volta che una carta viene giocata, la \"Tela Eterna\" agirà immediatamente, svuotando la Fenditura Dimensionale e cambiando l'intento in \"Elegia del Fato Trasceso.\""
  },
  State_129850_Name = {
    Text = "Scuotimento Spaziale"
  },
  State_129854_Desc = {
    Text = "Per ogni Carta di comando nella Frattura Dimensionale, il limite di carte in mano del giocatore diminuisce di 1. Se è già piena, la prossima volta che una carta viene giocata, la \"Ragnatela Eterna\" agirà immediatamente, svuotando la Frattura Dimensionale e cambiando l'intento in \"Ruota Filante del Destino\"."
  },
  State_129854_Name = {
    Text = "Scuotimento Spaziale"
  },
  State_129864_Desc = {
    Text = "Rimuovi 1 strato di \"Sonnolenza\" ogni volta che viene giocata una carta. All'inizio del turno, ripristina a 12 strati di \"Sonnolenza\"."
  },
  State_129864_Name = {Text = "Furia"},
  State_129865_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_129865_Name = {
    Text = "Non Risvegliato"
  },
  State_129872_Desc = {
    Text = "Variabile temporanea."
  },
  State_129872_Name = {
    Text = "Contrattacco 1"
  },
  State_129873_Desc = {
    Text = "Ottieni [Layer] accumuli di Stato _Contrattacco1_."
  },
  State_129873_Name = {
    Text = "Test Incapsulamento 1"
  },
  State_129874_Desc = {
    Text = "Variabile temporanea."
  },
  State_129874_Name = {
    Text = "Amplificatore 1"
  },
  State_130358_Desc = {
    Text = "La prossima Carta di comando giocata ha effetto 2 volte aggiuntive."
  },
  State_130358_Name = {Text = "Marionetta"},
  State_130387_Desc = {
    Text = "Dopo che \"Marionetta\" viene Esaurita, la prima Carta di comando giocata in ogni turno successivo ha effetto 2 volte aggiuntive. Se si tratta di una Battaglia Boss, tutti i Risvegliati ottengono 50 Aliemus e 1000 Keyflare."
  },
  State_130387_Name = {
    Text = "Funerale del Fato"
  },
  State_130388_Name = {
    Text = "<RetainIconKeywords:Conservare>: Ottieni [DescArg1] Keyflare"
  },
  State_130389_Desc = {
    Text = "Quando giocata, conferisce a tutti i Risvegliati [DescArg1] Aliemus"
  },
  State_130389_Name = {
    Text = "Quando giocata, conferisce a tutti i Risvegliati [DescArg1] Aliemus"
  },
  State_130390_Desc = {
    Text = "Limite di Arithmetica e Limite Massima della Mano aumentati di 1."
  },
  State_130390_Name = {
    Text = "Profilo Ridondante"
  },
  State_130391_Desc = {
    Text = "Ogni volta che giochi 1 \"Carta sintomo\", il Costo di Arithmetica di \"Marionetta\" si riduce di 1."
  },
  State_130391_Name = {
    Text = "Echi di Lordura"
  },
  State_130490_Desc = {
    Text = "Il Danno, lo Scudo del Personaggio, la Guarigione, la Forza, il Risucchio, il Danno del Tentacolo, il Veleno fisso e il Contatore fisso forniti da questa carta sono aumentati, calcolati moltiplicativamente come 1+[Layer]%."
  },
  State_130490_Name = {
    Text = "Faro di Singolarità α"
  },
  State_130498_Desc = {
    Text = "La prossima Carta di comando giocata ha effetto 2 volte aggiuntive."
  },
  State_130498_Name = {
    Text = "Funerale del Fato"
  },
  State_130500_Desc = {
    Text = "Resistenza alla Morte +100% nella Battaglia Boss. Dopo aver attivato \"Resistenza alla Morte\", \"Marionetta\" non forzerà più il gioco di una Carta di comando nel turno successivo; scegli invece una Carta di comando dalla tua mano."
  },
  State_130500_Name = {
    Text = "Visione del Martire"
  },
  State_130501_Desc = {
    Text = "Il Costo di Arithmetica della prossima Carta di comando è ridotto a 0."
  },
  State_130501_WeaponDesc = {
    Text = "Modifica l'Arithmetica della carta prima di giocarla"
  },
  State_130512_Desc = {
    Text = "La prossima Carta di comando giocata ha effetto 2 volte aggiuntive e il suo Costo di Arithmetica è ridotto di 2."
  },
  State_130512_Name = {Text = "Marionetta"},
  State_130517_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: all'equipaggiamento e all'inizio del turno, attiva casualmente uno dei seguenti Effetti: ottiene <Energy:[Energy:StateArg1]> Aliemus e <PVPSlowKeywords:Stagnazione> su se stesso; ottiene <Energy:[Energy:StateArg3]> Aliemus; ottiene <Energy:[Energy:StateArg4]> e [StateArg5] carte <PVPDerivativeCardKeywords_17:\"Ispirazione\">."
  },
  State_130517_Name = {
    Text = "Posta della Saggezza"
  },
  State_131046_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del Destino>: Dopo \"Esaltazione\", conferisci a se stessi <Block:[Block:StateArg1]> Scudo del Personaggio e <DelayKeywords:Ritardo>: <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_131046_Name = {
    Text = "L'Eden lontano"
  },
  State_131047_Desc = {
    Text = "In questo turno, i prossimi [Layer] utilizzi di Posse avranno effetto due volte."
  },
  State_131047_Name = {
    Text = "Doppio Decreto"
  },
  State_131048_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: la prima volta che viene giocata una «Tecnica» in ogni turno, infligge <Damage:[Damage:StateArg1]> danni al nemico con <HPAndShieldMin:vita e scudo più bassi>."
  },
  State_131048_Name = {
    Text = "Follia Imprigionata"
  },
  State_131055_Desc = {
    Text = "Pesca -1 carta per turno. Lo Scudo del Personaggio e il recupero salute di tutti i Risvegliatori sono aumentati del 20%."
  },
  State_131055_Name = {
    Text = "Grattini sul mento"
  },
  State_131056_Desc = {
    Text = "Dopo aver perso HP, converti una quantità equivalente di Aliemus Ritardato in Scudo del Personaggio."
  },
  State_131056_Name = {
    Text = "Scudo Vortice"
  },
  State_131058_Desc = {
    Text = "Aliemus base di tutti i Risvegliati +10. Ottieni 1 Arithmetica dopo aver scatenato l'Esaltazione, e ogni Risvegliato può attivarla solo una volta per turno."
  },
  State_131058_Name = {
    Text = "Strofinata di guance"
  },
  State_131059_Name = {
    Text = "Indicatore Potenziamento Supremo Vortice"
  },
  State_131061_Desc = {
    Text = "Limite Energia Chiave d'argento e Consumo Gettoni Chiave Energia Chiave d'argento +350. Il primo Gettone Chiave ha effetto 2 volte per turno."
  },
  State_131061_Name = {
    Text = "Dai da mangiare alla lontra"
  },
  State_131064_Desc = {
    Text = "Ottieni 1 Potere dopo aver scatenato Esplosione Frenetica; ogni Risvegliatore può attivarlo solo una volta per turno."
  },
  State_131064_Name = {
    Text = "Strofinata di guance"
  },
  State_131069_Desc = {
    Text = "Generazione di Scudo del Personaggio e Recupero PV di tutti i Risvegliati +20%."
  },
  State_131069_Name = {
    Text = "Grattini sul mento"
  },
  State_131073_Desc = {
    Text = [[
Unico per Squadra: Ottieni Aliemus pari a <WeaponEffect_Num:[StateArg1]%> dell'Aliemus Base all'inizio della battaglia. Il Danno Finale da Esaltazione del portatore aumenta di una percentuale pari a <WeaponEffect_Num:[StateArg2]%> dell'Aliemus Base.
Quando passi alla postura "Onde Furiose", ottieni Padronanza del Reame temporanea pari a <WeaponEffect_Num:[StateArg3]%> della tua Padronanza del Reame attuale. Tempo di ricarica: 3 turni.]]
  },
  State_131073_WeaponDesc = {
    Text = [[
Ottieni [DescArg1] Aliemus all'inizio della Battaglia. Danno Finale Esaltazione del Portatore +[DescArg2] %.
Quando si passa alla posizione "Onde Furiose", ottieni [DescArg3] Padronanza del Reame temporanea. Tempo di recupero di 3 turni(Turni rimanenti: [DescArg4]).]]
  },
  State_131078_Desc = {
    Text = "La prima attivazione della Squadra per turno ha effetto due volte."
  },
  State_131078_Name = {
    Text = "Dai da mangiare alla lontra"
  },
  State_131118_Desc = {
    Text = "Ogni volta che subisci Danno o perdi Vita, non può superare il 5% della Salute massima."
  },
  State_131118_Name = {
    Text = "Bozzolo del Destino"
  },
  State_131123_Desc = {
    Text = "Si azzera all'inizio del turno. Dopo aver raggiunto 10 accumuli, agisce immediatamente e passa all'intento successivo la prossima volta che viene giocata una carta, rimuovendo <Chapter5_Monster_Fervor4:Fervore>."
  },
  State_131123_Name = {
    Text = "Fervore Temporaneo"
  },
  State_131127_Desc = {
    Text = "Una postura legata al Destino. Ogni volta che il nemico gioca 1 Carta di comando, Arachne Oscura guadagna 1 accumulo di \"Fervore Temporaneo\"."
  },
  State_131127_Name = {
    Text = "Vincolato dal Giuramento del Destino"
  },
  State_131134_Desc = {
    Text = "Dopo la morte, Nefraea ottiene [DescArg1] <plural value=\"[DescArg1]\" singular=\"accumulo\" plural=\"accumuli\"> di Fervore Temporaneo, ma perde il 3% della Salute massima."
  },
  State_131134_Name = {
    Text = "Irrequietezza"
  },
  State_131186_Desc = {
    Text = "Ha effetto 1 volta aggiuntiva, ma subisce [DescArg1] Danno dopo essere stata giocata."
  },
  State_131186_Name = {
    Text = "<ExclamationPointColour:Fato Infranto>"
  },
  State_131188_Desc = {
    Text = "L'\"Abilità\" giocata entra nella \"Frattura Dimensionale\" e assegna \"Frammento del Destino\" a tutte le Abilità con lo stesso nome, rimosso all'uscita dalla Frattura Dimensionale. Quando la Frattura Dimensionale è piena, Nefraea \"Rete del Tradimento\" la svuota dopo l'azione e trasforma la prossima intenzione in una potente Esaltazione."
  },
  State_131188_Name = {
    Text = "Fenditura Dimensionale"
  },
  State_131191_Name = {
    Text = "Deterioramento Cognitivo"
  },
  State_131242_Desc = {
    Text = "Il Danno, lo Scudo del Personaggio, la Guarigione, la Forza, il Risucchio, il Danno del Tentacolo, il Veleno fisso e il Contatore fisso forniti da questa carta sono aumentati, calcolati moltiplicativamente come 1+[Layer]%."
  },
  State_131242_Name = {
    Text = "Faro di Singolarità β"
  },
  State_131258_Desc = {
    Text = "I fili del fuso in rotazione disturbano il Destino errato. Dopo aver scatenato una Posse o giocato una Carta \"Destino Infranto\", rimuovi 1 strato; una volta rimossi tutti, Arachne scatena l'Inseguimento \"Fili al Loro Posto\", causando un Danno elevato. Dopo 3 attivazioni, il \"Bozzolo del Destino\" del nemico si frantumerà completamente!"
  },
  State_131258_Name = {
    Text = "Disruzione del Destino"
  },
  State_131261_Name = {
    Text = "Teatro di Arachne"
  },
  State_131351_Desc = {
    Text = "Dopo che altri Risvegliati scatenano Esaltazione, consuma 1 accumulo, e Vortice scatena \"Vortice! Conchiglia!\" come Caccia."
  },
  State_131351_Name = {
    Text = "Ricarica del Vortice"
  },
  State_131439_Desc = {
    Text = "La prossima Carta di comando giocata ha effetto 2 volte aggiuntive e il suo Costo di Arithmetica è ridotto a 0."
  },
  State_131439_Name = {Text = "Marionetta"},
  State_131637_Desc = {
    Text = "Alla morte, evoca un \"Raggruppamento di ragni abissali\" o un \"Raggruppamento di ragni di Leng\" casuale, riducendo il suo \"Effetto raggruppamento\" di 1 accumulo."
  },
  State_131637_Name = {
    Text = "Effetto Cluster"
  },
  State_131638_Desc = {
    Text = "Alla morte, evoca una \"Matriarca fratturata\" o una \"Matriarca spettrosetosa\" casuale, riducendo il suo \"Effetto raggruppamento\" di 1 accumulo."
  },
  State_131638_Name = {
    Text = "Effetto Cluster"
  },
  State_131645_Desc = {
    Text = "Unico per Squadra: Quando passi alla postura \"Onde Furiose\", ottieni Padronanza del Reame temporanea pari al <WeaponEffect_Num:[StateArg1]%> della tua Padronanza del Reame attuale. Tempo di ricarica: 3 turni."
  },
  State_131645_WeaponDesc = {
    Text = "Quando si passa alla postura \"Onde Furiose\", ottieni [DescArg2] Padronanza del Reame temporanea. Tempo di ricarica di 3 turni (Turni rimanenti: [DescArg1])."
  },
  State_131657_Desc = {
    Text = "Dopo che altri Risvegliati scatenano Esaltazione, consuma 1 accumulo, e Vortice scatena \"Vortice! Conchiglia!\" come Caccia."
  },
  State_131657_Name = {
    Text = "<WhirlpoolKeywords:Ricarica del Vortice>"
  },
  State_131660_Desc = {
    Text = "Per ogni accumulo, l'Aliemus necessario per scatenare l'Esaltazione aumenta di 1."
  },
  State_131660_Name = {
    Text = "Regolazione Quantità Consumo Aliemus"
  },
  State_131675_Desc = {
    Text = "Questa Carta ha una probabilità del [StateArg1]% di attivarsi 1 volta aggiuntiva la prossima volta che viene giocata."
  },
  State_131675_Name = {
    Text = "<CardKeyWord:Azzardo>"
  },
  State_131684_Desc = {
    Text = "I prossimi [Layer] utilizzi di \"Vortice! Conchiglia!\" si attivano due volte."
  },
  State_131684_Name = {
    Text = "Moskstraumen! BOOM!"
  },
  State_131749_Desc = {
    Text = "Unico per Squadra: Dopo l'inizio dell'esplorazione, mescola 1 \"Pali della Saggezza\" nel Mazzo di Pesca. \"Pali della Saggezza\": Costa 1 Arithmetica. Mescola tutte le Carte di Comando in mano casualmente nel Mazzo di Pesca. Le Carte di Comando mescolate hanno una probabilità del <WeaponEffect_Num:[StateArg1]%> di attivarsi 1 volta aggiuntiva quando giocate successivamente, e per ogni Carta di Comando mescolata, tutti i Risvegliatori ottengono 2 Aliemus. <RetainIconKeywords:Conserva>. <DepleteIconKeywords:Consumo>. <GuyouKeywords:Innata>."
  },
  State_131749_WeaponDesc = {
    Text = "Dopo l'inizio dell'esplorazione, mescola 1 \"Pali della Saggezza\" nel Mazzo di Pesca. \"Pali della Saggezza\": Costa 1 Arithmetica. Mescola tutte le Carte di Comando in mano casualmente nel Mazzo di Pesca, le Carte di Comando mescolate hanno una probabilità del <WeaponEffect_Num:[StateArg1]%> di attivarsi 1 volta aggiuntiva quando giocate successivamente, e per ogni Carta di Comando mescolata, tutti i Risvegliatori ottengono 2 Aliemus. <RetainIconKeywords:Conserva>. <DepleteIconKeywords:Consumo>. <GuyouKeywords:Innata>."
  },
  State_131769_Name = {
    Text = "Stato@Inizializzazione Classe Allevamento Caro 1"
  },
  State_131779_Desc = {
    Text = "Entra nella Pila degli scarti e azzera il conteggio solo dopo essere stata usata [Layer] volte, ma \"Orazione\" ha effetto solo la prima volta che viene utilizzata."
  },
  State_131779_Name = {
    Text = "Utilizzabile [Layer] volte"
  },
  State_131789_Desc = {
    Text = "Un'opzione di riserva. Aggiungi 1 carta con tid [Layer] alla tua mano."
  },
  State_131789_Name = {
    Text = "Aggiungi Carta Specificata"
  },
  State_131807_Name = {
    Text = "Stato@Identificatore Puro Allevamento Caro"
  },
  State_131824_Name = {
    Text = "Stato@Listener Cambio Intento Giocatore Mostro Tawil"
  },
  State_131846_Desc = {
    Text = "Alla morte, evoca un \"Raggruppamento di ragni abissali\" o un \"Raggruppamento di ragni di Leng\" casuale, riducendo il suo \"Effetto raggruppamento\" di 1 accumulo."
  },
  State_131846_Name = {
    Text = "Effetto Cluster"
  },
  State_131908_Desc = {
    Text = "Condividi Vita, Scudo e Aliemus del bersaglio, ma non generare statistiche di combattimento."
  },
  State_131908_Name = {
    Text = "Banchetto della Decomposizione Trampolino"
  },
  State_131909_Desc = {
    Text = "Possedere questo Stato impedisce l'uso dell'Esaltazione."
  },
  State_131909_Name = {
    Text = "Sigillato Permanentemente"
  },
  State_132366_Desc = {
    Text = "Esegue un Inseguimento dopo che un altro Risvegliato usa una carta Attacco"
  },
  State_132366_Name = {
    Text = "Inseguimento"
  },
  State_132465_Desc = {
    Text = "Il danno, lo Scudo, le cure, la Forza, l'Esaurimento, il danno Tentacolo, l'Avvelenamento fisso e il Contrattacco fisso di questo Risvegliato aumentano, moltiplicatore indipendente 1+[Layer]%."
  },
  State_132465_Name = {
    Text = "Divoramento Potenziato α"
  },
  State_132469_Desc = {
    Text = "Il danno, lo Scudo, le cure, la Forza, l'Esaurimento, il danno Tentacolo, l'Avvelenamento fisso e il Contrattacco fisso di questo Risvegliato aumentano, moltiplicatore indipendente 1+[Layer]%."
  },
  State_132469_Name = {
    Text = "Divoramento Potenziato β"
  },
  State_132539_Desc = {
    Text = "Artefatto test raccolta"
  },
  State_132539_Name = {
    Text = "Artefatto test raccolta"
  },
  State_132539_WeaponDesc = {Text = "Test"},
  State_132560_WeaponDesc = {
    Text = "Ogni [Damage:StateArg2] volte che il Fuoco Cinereo infligge DAN, ottieni un [Green Flames] con Esaurisci."
  },
  State_132564_WeaponDesc = {
    Text = "Ogni [Damage:StateArg2] volte che il Fuoco Cinereo infligge DAN, ottieni un [Green Flames] con Esaurisci."
  },
  State_132565_WeaponDesc = {
    Text = "Ogni [Damage:StateArg2] volte che il Fuoco Cinereo infligge DAN, ottieni un [Green Flames] con Esaurisci."
  },
  State_132598_Desc = {
    Text = "Quando si infliggono Danni da tentacolo in questo turno, infliggi inoltre Veleno pari al [Layer]% del Danno inflitto."
  },
  State_132598_Name = {
    Text = "Ossessione Abissale"
  },
  State_132609_Desc = {
    Text = "Quando lo Scultore applica uno scudo, il danno dei Tentacoli è aumentato di [StateArg1]."
  },
  State_132609_Name = {
    Text = "Regno dell'Oblio"
  },
  State_132609_WeaponDesc = {
    Text = "Quando lo Scultore applica uno scudo, il danno dei Tentacoli è aumentato di [StateArg1]."
  },
  State_132669_Desc = {
    Text = "Il danno, lo Scudo, le cure, la Forza, l'Esaurimento, il danno Tentacolo, l'Avvelenamento fisso e il Contrattacco fisso delle carte di questo Risvegliato aumentano, moltiplicatore indipendente 1+[Layer]%."
  },
  State_132669_Name = {
    Text = "Iperdimensione Predestinata α"
  },
  State_132840_Name = {
    Text = "Il bonus dell'effetto personalità della Carta di comando di \"24\" è raddoppiato. Dopo che \"24\" scatena l'Esaltazione, il bonus personalità raddoppiato si esaurisce in questo turno"
  },
  State_132891_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: All'equipaggiamento ottieni [StateArg1] <StrongEffectKeywords:Forte>, dopo l'Esaltazione di altri alleati, fai ottenere loro <PVPOneMeetingKeywords:Ichigo Ichie>."
  },
  State_132891_Name = {
    Text = "Fantasticherie tra i ciliegi"
  },
  State_132892_Desc = {
    Text = "·All'acquisizione, rimuove lo Stato \"Ichigo Ichie\" dagli altri alleati, ottenendo l'effetto Forte equivalente agli alleati equipaggiati con \"Fantasticherie di Sakura\", fino a 3 livelli.\n·I personaggi equipaggiati con \"Fantasticherie di Sakura\" non possono ottenere \"Ichigo Ichie\"."
  },
  State_132892_Name = {
    Text = "Ichigo Ichie"
  },
  State_133294_Name = {
    Text = "Invito Cremisi"
  },
  State_133353_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Una volta equipaggiata, le descrizioni di \"Colpo,\" \"Abilità\" e \"Esaltazione\" del portatore diventano non identificabili, ma ogni istanza di Danno, Scudo e Recupero PV viene aumentata casualmente del [StateArg1]%~[StateArg2]%."
  },
  State_133353_Name = {
    Text = "Fiaba nel fango"
  },
  State_133354_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Si Conserva dopo la morte di questa Ruota del destino. Quando il portatore muore e alla fine dei successivi [Layer] turni nello Stato di morte, gli altri alleati ottengono <Heal:[Heal:StateArg1]> <PVPFeatheredSeedsKeyWords:Gynoecium> e Vita."
  },
  State_133354_Name = {
    Text = "Possa il mondo trasformarsi in profumo"
  },
  State_133369_Desc = {
    Text = "Le prossime [DescArg1] Carte di comando non-Tawil giocate hanno effetto due volte."
  },
  State_133369_Name = {
    Text = "Il Portale della Chiave d'Argento"
  },
  State_133372_Desc = {
    Text = "Se ci si trova attualmente in un Turno Ultra, attiva l'effetto \"Distorsione della singolarità\". \"Annientamento della singolarità\" garantisce inoltre l'attivazione della prossima \"Distorsione della singolarità\" in questo turno."
  },
  State_133372_Name = {
    Text = "<SingularityKeywords:Distorsione della singolarità>"
  },
  State_133391_Desc = {
    Text = "Se i Vita del bersaglio sono uguali o inferiori al numero di accumuli, rimuovi tutti i Verdetto finale e uccidilo istantaneamente."
  },
  State_133391_Name = {
    Text = "<CutKeywords:Verdetto finale>"
  },
  State_133395_Desc = {
    Text = "Le prossime [Layer] Carte di comando giocate attiveranno \"Navetta Dimensionale.\""
  },
  State_133395_Name = {
    Text = "Navetta Dimensionale"
  },
  State_133717_Desc = {
    Text = "Il proprietario attuale è [Layer], e tutte le sue carte attuali e future otterranno l'attributo corrispondente (Attuale: Sigillo Carta)."
  },
  State_133717_Name = {
    Text = "Propagazione attributi carta"
  },
  State_133774_Desc = {
    Text = "Ogni accumulo aumenta il Danno Finale di questa carta, il guadagno fisso di <PowerIconKeywords:Potere> e <TentacleInjurieIconKeywords:Danni da tentacolo>, il <IntoxicationIconKeywords:Veleno> fisso e il <RetaliateIconKeywords:Contrattacco> del 2%, e il suo Scudo Fisso Finale, il Recupero PV Fisso e la <ExhaustionIconKeywords:Riduzione del potere> dell'1%. Questa carta non può attivare la <SingularityKeywords3:Navetta Dimensionale>."
  },
  State_133774_Name = {
    Text = "<SingularityKeywords1:Faro di Singolarità>"
  },
  State_133775_Desc = {
    Text = "Ogni accumulo aumenta il Danno Finale di questa carta, il guadagno fisso di <PowerIconKeywords:Potere> e <TentacleInjurieIconKeywords:Danni da tentacolo>, il <IntoxicationIconKeywords:Veleno> fisso e il <RetaliateIconKeywords:Contrattacco> del 2%, e il suo Scudo Fisso Finale, il Recupero PV Fisso e la <ExhaustionIconKeywords:Riduzione del potere> dell'1%"
  },
  State_133775_Name = {
    Text = "<SingularityKeywords2:Prisma di Singolarità>"
  },
  State_133961_Desc = {
    Text = "Unicità di Squadra: Dopo l'inizio dell'esplorazione, mescola 1 \"Messaggio Primaverile\" nel mazzo: Costo di Arithmetica 1, guadagna <WeaponEffect_Num:[StateArg1]> Keyflare, si trasforma permanentemente in \"Fiori di Sakura\" dopo essere stata giocata: Costo di Arithmetica 1, guadagna <WeaponEffect_Num:[StateArg2]> Keyflare, dopo averla giocata si trasforma permanentemente in \"Hanafubuki\": Costo di Arithmetica 1, guadagna <WeaponEffect_Num:[StateArg3]> Keyflare, si trasforma permanentemente in \"Ichigo Ichie\" dopo essere stata giocata: Costo di Arithmetica 1, scegli 1 tra 3 Posse sbloccate casuali da scatenare immediatamente e attivare 2 volte, si trasforma permanentemente in \"Messaggio Primaverile\" dopo essere stata giocata. Tutte queste carte hanno \"Conservare\"."
  },
  State_133961_WeaponDesc = {
    Text = "Dopo l'inizio dell'esplorazione, mescola 1 \"Messaggio Primaverile\" nel mazzo: Costo di Arithmetica 1, ottieni <WeaponEffect_Num:[StateArg1]> Energia-S, si trasforma permanentemente in \"Fiori di Sakura\" dopo essere stata giocata: Costo di Arithmetica 1, ottieni <WeaponEffect_Num:[StateArg2]> Energia-S, dopo averla giocata si trasforma permanentemente in \"Hanafubuki\": Costo di Arithmetica 1, ottieni <WeaponEffect_Num:[StateArg3]> Energia-S, si trasforma permanentemente in \"Ichigo Ichie\" dopo essere stata giocata: Costo di Arithmetica 1, scegli 1 tra 3 Posse sbloccate casuali da scatenare immediatamente e attivare 2 volte, si trasforma permanentemente in \"Messaggio Primaverile\" dopo essere stata giocata. Tutte queste Carte hanno \"Conservare\"."
  },
  State_133994_Desc = {
    Text = "Il Danno Finale di tutti i Risvegliatori, il guadagno fisso di <PowerIconKeywords:Potere> e <TentacleInjurieIconKeywords:Danni da tentacolo>, il <IntoxicationIconKeywords:Veleno> fisso e il <RetaliateIconKeywords:Contrattacco> ciascuno +[DescArg1]%; il Scudo Fisso Finale di questa carta, il Recupero PV Fisso e la <ExhaustionIconKeywords:Riduzione del potere> ciascuno +[DescArg2]%"
  },
  State_133994_Name = {
    Text = "Prisma di Singolarità"
  },
  State_133998_Desc = {
    Text = "Il Danno, lo Scudo e le variazioni di Potere causati da questa Carta aumentano del [DescArg2]%, l'Effetto finale dei Danni da tentacolo, della Guarigione, del Veleno fisso e del Contrattacco fisso aumenta del [DescArg1]%. Viene rimossa alla fine del turno o dopo essere stata giocata."
  },
  State_133998_Name = {
    Text = "<TempPowerKeywords1:Potenziare Temporaneo [DescArg1]>"
  },
  State_133999_Desc = {
    Text = "Ogni accumulo aumenta il Danno Finale di questa carta, il guadagno fisso di <PowerIconKeywords:Potere> e <TentacleInjurieIconKeywords:Danni da tentacolo>, il <IntoxicationIconKeywords:Veleno> fisso e il <RetaliateIconKeywords:Contrattacco> del 2%, e il suo Scudo Fisso Finale, il Recupero PV Fisso e la <ExhaustionIconKeywords:Riduzione del potere> dell'1%. Si azzera quando viene giocata o alla fine del turno."
  },
  State_133999_Name = {
    Text = "<TempPowerKeywords:Potenziamento Temporaneo>"
  },
  State_134100_Desc = {
    Text = "Quando si subisce un danno letale in questa battaglia, si risorge, si recuperano [Layer] PV e tutti i Risvegliati ottengono [StateArg1] punti Furia e [DescArg1] punti di danno Tentacolo temporaneo. Non può essere dissolto."
  },
  State_134100_Name = {
    Text = "Uccello del paradiso immortale"
  },
  State_134191_Desc = {
    Text = "Unico nel gruppo: dopo l'inizio dell'esplorazione, mescola 1 carta \"Pausa Pranzo Privata\" nel mazzo di pesca. \"Pausa Pranzo Privata\": consuma 1 potenza di calcolo. Danno critico temporaneo +<WeaponEffect_Num:[StateArg1]%>. <RetainIconKeywords:Conserva>. <DepleteIconKeywords:Consuma>."
  },
  State_134191_WeaponDesc = {
    Text = "Dopo l'inizio dell'esplorazione, mescola 1 carta \"Pausa Pranzo Privata\" nel mazzo di pesca. \"Pausa Pranzo Privata\": consuma 1 potenza di calcolo. Danno critico temporaneo +<WeaponEffect_Num:[StateArg1]%>. <RetainIconKeywords:Conserva>. <DepleteIconKeywords:Consuma>."
  },
  State_134195_Desc = {
    Text = "I livelli di Avvelenamento fisso, Contrattacco fisso e Giudizio del Destino fisso inflitti da questa carta aumentano, moltiplicatore indipendente 1+[Layer]%."
  },
  State_134195_Name = {
    Text = "Forza Trifase α1"
  },
  State_134196_Desc = {
    Text = "I livelli di Avvelenamento fisso, Contrattacco fisso e Giudizio del Destino fisso inflitti dalle carte Comando di questo Risvegliato aumentano, moltiplicatore indipendente 1+[StateArg1]%."
  },
  State_134196_Name = {
    Text = "Forza Trifase β3"
  },
  State_134197_Desc = {
    Text = "I livelli di Avvelenamento fisso, Contrattacco fisso e Giudizio del Destino fisso inflitti da questa carta aumentano, moltiplicatore indipendente 1+[StateArg1]%."
  },
  State_134197_Name = {
    Text = "Forza Trifase β1"
  },
  State_134198_Desc = {
    Text = "I livelli di Avvelenamento fisso, Contrattacco fisso e Giudizio del Destino fisso inflitti dalle carte Comando di questo Risvegliato aumentano, moltiplicatore indipendente 1+[Layer]%."
  },
  State_134198_Name = {
    Text = "Forza Trifase α3"
  },
  State_134199_Desc = {
    Text = "I livelli di Avvelenamento fisso, Contrattacco fisso e Giudizio del Destino fisso inflitti dall'Esplosione di Furia di questo Risvegliato aumentano, moltiplicatore indipendente 1+[StateArg1]%."
  },
  State_134199_Name = {
    Text = "Forza Trifase β2"
  },
  State_134200_Desc = {
    Text = "I livelli di Avvelenamento fisso, Contrattacco fisso e Giudizio del Destino fisso inflitti dall'Esplosione di Furia di questo Risvegliato aumentano, moltiplicatore indipendente 1+[Layer]%."
  },
  State_134200_Name = {
    Text = "Forza Trifase α2"
  },
  State_134227_Desc = {
    Text = "La Tessitrice del Destino tira i suoi fili. Massimo [DescArg1] accumuli, persistono tra le battaglie e possono essere consumati dall'Esaltazione per scatenare la Caccia: \"Fili Infiniti\"."
  },
  State_134227_Name = {
    Text = "<SilkKeywords:Tessifato>"
  },
  State_134231_Desc = {
    Text = "Unico di squadra: Scudo generato dal portatore +<WeaponEffect_Num:[StateArg1]%>, e quando il portatore usa \"Caccia\", Forte Temporaneo +<WeaponEffect_Num:[StateArg2]%>, fino a 5 volte per turno. Ogni volta che viene attivata \"Navetta Dimensionale\", il portatore ottiene <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_134231_WeaponDesc = {
    Text = "Scudo generato dal portatore +<WeaponEffect_Num:[StateArg1]%>, e quando il portatore usa \"Caccia,\" Forte Temporaneo +<WeaponEffect_Num:[StateArg2]%>, fino a 5 volte per turno. Ogni volta che \"Navetta Dimensionale\" viene attivata, il portatore ottiene <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_134237_Desc = {
    Text = "La Tessitrice del Fato tesse i suoi fili. Max [DescArg1] accumuli, persistono tra le battaglie e possono essere consumati dall'Esaltazione per scatenare la Caccia: \"<DerivativeCardKeywords_144:Matassa Infinita>."
  },
  State_134237_Name = {Text = "Tessifato"},
  State_134240_Desc = {
    Text = "Per <plural value=\"[Layer]\" singular=\"il prossimo uso\" plural=\"i prossimi usi\"> di \"Telaio Eterno,\" genera un extra \"Fili Guida\" e posizionalo nel Mazzo di Pesca e nella Pila degli scarti."
  },
  State_134240_Name = {
    Text = "Ragnatela del Vincolo Fatale"
  },
  State_134261_Desc = {
    Text = "I prossimi [Layer] danni inflitti sono raddoppiati."
  },
  State_134261_Name = {
    Text = "Pomeriggio privato"
  },
  State_134262_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo l'\"Esaltazione\", la prossima istanza di Danno inflitta da te stesso è raddoppiata."
  },
  State_134262_Name = {
    Text = "Pomeriggio privato"
  },
  State_134285_Desc = {
    Text = "Se i Vita del bersaglio sono uguali o inferiori al numero di accumuli, rimuovi tutti i Verdetto finale e uccidilo istantaneamente."
  },
  State_134285_Name = {
    Text = "Giudizio del Destino"
  },
  State_134313_Desc = {
    Text = "Unico di squadra: Scudo generato dal portatore +<WeaponEffect_Num:[StateArg1]%>, e quando il portatore usa \"Caccia\", Forte Temporaneo +<WeaponEffect_Num:[StateArg2]%>, fino a 5 volte per turno."
  },
  State_134313_WeaponDesc = {
    Text = "Scudo generato dal portatore +<WeaponEffect_Num:[StateArg1]%>, e quando il portatore usa \"Caccia\", Forte Temporaneo +<WeaponEffect_Num:[StateArg2]%>, fino a 5 volte per turno."
  },
  State_134384_Desc = {
    Text = "Le prossime [Layer] Carte di comando giocate attiveranno \"Navetta Dimensionale.\""
  },
  State_134384_Name = {
    Text = "Navetta Dimensionale"
  },
  State_134389_Desc = {
    Text = "Il Danno Finale di questa carta, il guadagno fisso di <PowerIconKeywords:Potere> e <TentacleInjurieIconKeywords:Danni da tentacolo>, il <IntoxicationIconKeywords:Veleno> fisso e il <RetaliateIconKeywords:Contrattacco> ciascuno +[DescArg1]%; il Scudo Fisso Finale di questa carta, il Recupero PV Fisso e la <ExhaustionIconKeywords:Riduzione del potere> ciascuno +[DescArg2]%. Le carte con \"Faro di Singolarità\" non possono attivare la \"Navetta Dimensionale\"."
  },
  State_134389_Name = {
    Text = "<SingularityKeywords:Faro di Singolarità [DescArg2]>"
  },
  State_134391_Desc = {
    Text = "Ogni turno, dopo che la prima Carta di comando viene giocata, si attiva questo Effetto: la Copia Base Temporanea della Carta di comando giocata viene collocata nello Spazio Ultra. Questo Effetto non può essere attivato durante i Turni Ultra."
  },
  State_134391_Name = {
    Text = "<SingularityKeywords3:Navetta Dimensionale>"
  },
  State_135232_Name = {
    Text = "<SingularityKeywords:Distorsione Singolare>: Per il resto di questo turno, ogni volta che un altro Risvegliatore gioca una Carta di comando, consuma 1 <SilkKeywords:Tessitrice> per scatenare Caccia: <DerivativeCardKeywords_137:\"Fili Infiniti\">"
  },
  State_135233_Name = {
    Text = "<SingularityKeywords:Distorsione Singolare>: Per il resto di questo turno, ogni volta che un altro Risvegliatore gioca una Carta di comando, consuma 1 <SilkKeywords:Tessitrice> per scatenare Caccia: <DerivativeCardKeywords_137:\"Fili Infiniti\">"
  },
  State_135919_Name = {
    Text = "<SingularityKeywords:Distorsione Singolare>: Per il resto di questo turno, ogni volta che un altro Risvegliatore gioca una Carta di comando, consuma 1 <SilkKeywords:Tessitrice> per scatenare Caccia: <DerivativeCardKeywords_137:\"Fili Infiniti\">"
  },
  State_135920_Name = {
    Text = "<SingularityKeywords:Distorsione Singolare>: Per il resto di questo turno, ogni volta che un altro Risvegliatore gioca una Carta di comando, consuma 1 <SilkKeywords:Tessitrice> per scatenare Caccia: <DerivativeCardKeywords_137:\"Fili Infiniti\">"
  },
  State_135921_Desc = {
    Text = "Chi esegue il Risveglio infligge il 25% di Danno in più."
  },
  State_135921_Name = {
    Text = "<CardKeyWord:Castigare, per saldare un debito di sangue>"
  },
  State_138824_Desc = {
    Text = "Una vita splendente loda la libertà, intonando un canto di trionfo; può essere consumata dall'Esaltazione di Aliemus di Saya per potenziarne l'Effetto. Questo Stato si accumula fino a un massimo di 4 livelli e viene conservato al termine del combattimento."
  },
  State_138824_Name = {
    Text = "<KaiHuajishu1:Gynoecium>"
  },
  State_139039_Desc = {
    Text = "L'effetto finale del prossimo Esaltazione di questo Risvegliatore nel turno corrente, inclusi Danno, Scudo fisso, Guarigione Vita fissa, Potere fisso, Riduzione del potere, Aumento DAN da Tentacolo, Veleno fisso e Contrattacco fisso, aumenta del [Layer]%."
  },
  State_139039_Name = {
    Text = "<BreedingKeywords2:Festa della Propagazione>"
  },
  State_139687_Desc = {
    Text = "Una vita splendente loda la libertà, intonando un canto di trionfo; può essere consumata dall'Esaltazione di Aliemus di Saya per potenziarne l'Effetto. Questo Stato si accumula fino a un massimo di 4 livelli e viene conservato al termine del combattimento."
  },
  State_139687_Name = {
    Text = "<KaiHuajishu:Gynoecium>"
  },
  State_139688_Desc = {
    Text = "Unicità di Squadra: Limite di Arithmetica +1, gli effetti dello stesso tipo non si accumulano.\nPer ogni 10 Base Aliemus del portatore, infligge +<WeaponEffect_Num:[StateArg1]%> accumuli di <Corrosion:Corrosione> e causa +<WeaponEffect_Num:[Float:StateArg2]％> di Fusione Embrionale."
  },
  State_139688_WeaponDesc = {
    Text = [[
Limite di Arithmetica +1, gli effetti dello stesso tipo non si accumulano.
Per ogni 10 Base Aliemus del portatore, infligge +<WeaponEffect_Num:[StateArg1]%> accumuli fissi di <Corrosion:Corrosione> e causa +<WeaponEffect_Num:[Float:StateArg2]%> di Fusione Embrionale.]]
  },
  State_139689_Desc = {
    Text = "Unicità di Squadra: Dopo aver usato la \"Fornace Cremisi\", il portatore guadagna Aliemus pari al <WeaponEffect_Num:[StateArg1]%> della Base Aliemus. Tempo di recupero di 3 turni."
  },
  State_139689_WeaponDesc = {
    Text = "Dopo aver usato \"Fornace Cremisi\", il portatore ottiene il <WeaponEffect_Num:[StateArg1]%> dell'Aliemus Base come Aliemus, con un cooldown di 3 turni."
  },
  State_139977_Desc = {
    Text = "Questo turno, se giochi \"Colpo,\" \"Colpo\" infligge +[DescArg1]% Danno con Perforazione; altrimenti, ottieni +[Layer] Barriera a fine turno."
  },
  State_139977_Name = {
    Text = "Bestia Stellare"
  },
  State_140063_Desc = {
    Text = "Questo è un \"pagherò\" creato prendendo in prestito Arithmetica dal prossimo turno. [Layer] Arithmetica verrà detratta all'inizio del prossimo turno. Non può essere dissolto."
  },
  State_140063_Name = {Text = "In Rosso"},
  State_140068_Desc = {
    Text = "Le prossime [DescArg1] Carta/e \"Abilità\" costano - [StateArg1] Arithmetica."
  },
  State_140068_Name = {Text = "Epifania"},
  State_140135_Desc = {
    Text = "Per ogni livello posseduto, l'effetto finale del prossimo Esaltazione di questo Risvegliatore nel turno corrente, inclusi Danno, Scudo fisso, Guarigione Vita fissa, Potere fisso, Riduzione del potere, Aumento DAN da Tentacolo, Veleno fisso e Contrattacco fisso, aumenta dell'1%."
  },
  State_140135_Name = {
    Text = "<BreedingKeywords2:Festa della Propagazione>"
  },
  State_140186_WeaponDesc = {
    Text = "Tutti i Danni da Salto di Balzo della Balena +1."
  },
  State_140454_Desc = {
    Text = "Unico nella squadra: per ogni 1% di Marchio Nero perso dall'equipaggiatore, dalla Ruota del Destino o dal Patto Segreto, recupera <WeaponEffect_Num:[StateArg1] %> della Vita massima alla fine della battaglia. L'effetto di recupero si riduce del 30% alla fine di ogni turno, calcolato indipendentemente per ogni istanza. Dopo aver attivato \"Percezione\" nelle \"Rovine di Cenere\", l'aggiornamento delle \"Rovine di Cenere\" correnti non richiede consumo di Marchio Nero."
  },
  State_140454_WeaponDesc = {
    Text = "Per ogni 1% di Bottino di Sigilli che il portatore, i suoi WoD e i Patti possiedono, recupera il <WeaponEffect_Num:[DescArg2]%> della Salute massima ([DescArg1]) alla fine della battaglia. Questo effetto diminuisce del 30% alla fine di ogni turno ed è calcolato individualmente per ogni battaglia.\nDopo aver scelto \"Percezione\" alle \"Rovine Cinerea\", i rinnovi saranno gratuiti in queste \"Rovine Cinerea\"."
  },
  State_140456_WeaponDesc = {
    Text = "Rimuovila permanentemente dopo l'uso."
  },
  State_140458_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del Destino>: Quando equipaggiato e dopo che un qualsiasi Risvegliato rilascia uno \"Scoppio di Furia\", ottiene <Block:[Block:StateArg1]> scudo."
  },
  State_140458_Name = {
    Text = "Verso le Stelle"
  },
  State_140489_Desc = {
    Text = "Ottieni una quantità equivalente di Vita massima. I livelli non possono superare la Vita massima iniziale del Risvegliato."
  },
  State_140489_Name = {Text = "Gynoecium"},
  State_140490_Desc = {
    Text = "Ottieni una quantità equivalente di Vita massima. I livelli non possono superare la Vita massima iniziale di questo Risvegliato [DescArg1]."
  },
  State_140490_Name = {Text = "Gynoecium"},
  State_140495_Desc = {
    Text = "L'Arithmetica consumata dalla prossima \"Abilità\" - [Layer] ."
  },
  State_140495_Name = {Text = "Riscrivere"},
  State_140517_Desc = {
    Text = "La potenza di calcolo consumata dalla prossima \"Abilità\"- [DescArg1]."
  },
  State_140517_Name = {Text = "Riscrivere"},
  State_140547_Desc = {
    Text = "Questo effetto può aumentare la Fusione Embrionale al massimo di + 100, e non beneficia dei bonus di aumento della Fusione Embrionale."
  },
  State_140547_Name = {
    Text = "Fusione Embrionale Doppia"
  },
  State_140645_Desc = {
    Text = "Effetto di Inattività"
  },
  State_140645_Name = {
    Text = "Effetto di Inattività"
  },
  State_140647_Name = {
    Text = "Giocato Monitoraggio Dissonanza Cognitiva"
  },
  State_140648_Name = {
    Text = "Giocatore possiede Contatore Dissonanza Cognitiva"
  },
  State_140650_Desc = {
    Text = "Le prime 3 volte per turno in cui giochi una Carta di comando con \"Distorsione Percettiva\", Saya ottiene [Layer] Aliemus."
  },
  State_140650_Name = {
    Text = "Trasformazione cognitiva"
  },
  State_140651_Desc = {
    Text = "Effetto di Inattività"
  },
  State_140651_Name = {
    Text = "Effetto di Inattività"
  },
  State_140653_Desc = {
    Text = "Il Costo di Arithmetica di questa Carta ha il 10% di probabilità di -2, il 25% di probabilità di -1, il 30% di probabilità di nessuna variazione, il 25% di probabilità di +1 e il 10% di probabilità di +2. Rimuove questo Stato dopo aver giocato o scartato la Carta."
  },
  State_140653_Name = {
    Text = "<ExclamationPointColour:Ridipintura>"
  },
  State_140654_Desc = {
    Text = "Effetto di Inattività"
  },
  State_140654_Name = {
    Text = "Effetto di Inattività"
  },
  State_140655_Desc = {
    Text = "Questa Carta è coperta dalla Dissoluzione e il suo testo non può essere visualizzato; il Costo di Arithmetica ha il 10% di probabilità di -2, il 25% di probabilità di -1, il 30% di probabilità di nessuna variazione, il 25% di probabilità di +1 e il 10% di probabilità di +2. Rimuove questo Stato dopo aver giocato o scartato la Carta."
  },
  State_140655_Name = {
    Text = "<ErosionColorInkKeywords:Distorsione Percettiva>"
  },
  State_140656_Desc = {
    Text = "Il Costo di Arithmetica di questa Carta ha il 10% di probabilità di -2, il 25% di probabilità di -1, il 30% di probabilità di nessuna variazione, il 25% di probabilità di +1 e il 10% di probabilità di +2. Rimuove questo Stato dopo aver giocato o scartato la Carta."
  },
  State_140656_Name = {
    Text = "<ColorInkKeywords:Copertura d'Inchiostro Colorato>"
  },
  State_140657_Desc = {
    Text = "Questa Carta è coperta dalla Dissoluzione e il suo testo non può essere visualizzato; il Costo di Arithmetica ha il 10% di probabilità di -2, il 25% di probabilità di -1, il 30% di probabilità di nessuna variazione, il 25% di probabilità di +1 e il 10% di probabilità di +2. Rimuove questo Stato dopo aver giocato o scartato la Carta."
  },
  State_140657_Name = {
    Text = "<ExclamationPointColour:Distorsione Percettiva>"
  },
  State_140658_Name = {
    Text = "Giocatore possiede Monitoraggio Dissonanza Cognitiva"
  },
  State_140659_Desc = {
    Text = "Effetto di Inattività"
  },
  State_140659_Name = {
    Text = "Effetto di Inattività"
  },
  State_140662_Desc = {
    Text = "All'inizio di ogni turno, \"Distorsione Percettiva\" viene applicata casualmente a 2 Carte di comando che non hanno \"Distorsione Percettiva\"."
  },
  State_140662_Name = {
    Text = "Ricostruzione della Forma Vitale"
  },
  State_140672_Desc = {
    Text = "Questo Risvegliatore cade nel caos, riducendo il Danno inflitto, il Recupero PV e lo Scudo di un valore casuale compreso tra il 15%~35%, e non può essere dissipato."
  },
  State_140672_Name = {
    Text = "<PVPCognitiveDissonanceKeyWords:Distorsione Percettiva>"
  },
  State_140673_Desc = {
    Text = "Questo Risvegliatore cade nel caos, riducendo il Danno inflitto, il Recupero PV e lo Scudo di un valore casuale compreso tra il 15%~35%, e non può essere dissipato."
  },
  State_140673_Name = {
    Text = "Distorsione Percettiva"
  },
  State_140683_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Quando equipaggiato, ottieni [StateArg1] <MaxHPKeywords:Salute massima>. Al termine del turno, recupera <Heal:[Heal:DescArg1]> Vita. Il Recupero PV aumenta man mano che la Vita del portatore diminuisce, fino a un massimo di [StateArg3]%."
  },
  State_140683_Name = {
    Text = "Lily nel Paese delle Meraviglie"
  },
  State_140724_Name = {Text = "Nutrimento"},
  State_140726_Desc = {
    Text = "L'Effetto finale di Danno, Potere, Danni da tentacolo, Veleno fisso, Contrattacco fisso, Scudo, Guarigione PV e Riduzione del potere inflitti da questa Carta è ridotto del [DescArg1]%."
  },
  State_140726_Name = {
    Text = "<AdaptKeywords1:Adattamento [DescArg1]>"
  },
  State_140727_Desc = {
    Text = "Quando la Fame raggiunge 5 livelli, al termine del turno consuma tutta la Fame, cambia l'intenzione in Attacco Potente e ottieni [DescArg1] punti Potere."
  },
  State_140727_Name = {Text = "Fame"},
  State_140728_Desc = {
    Text = "All'inizio di ogni turno ottieni 1 strato di Fame; quando infliggi Danno non bloccato, ottieni uno Scudo pari al 2% ([DescArg1]) della Salute massima. Il numero massimo di livelli di Adattamento aumenta a 75."
  },
  State_140728_Name = {
    Text = "Protezione del Cibo"
  },
  State_140730_Desc = {
    Text = "Dopo aver giocato una Carta di comando, applica 10 livelli di <AdaptKeywords:Adattamento> alle Carte del Risvegliatore associato in ogni luogo, e rimuove 5 livelli di <AdaptKeywords:Adattamento> dalle Carte degli altri Risvegliatori. Ogni livello di <AdaptKeywords:Adattamento> riduce dell'1% l'Effetto finale di Danno, Potere, Danni da tentacolo, Veleno fisso, Contrattacco fisso, Scudo, Guarigione della Vita e Riduzione del potere inflitti dalla Carta, fino a un massimo di [DescArg1] livelli."
  },
  State_140730_Name = {Text = "Mimetismo"},
  State_140838_Desc = {
    Text = "Il Danno inflitto in questo turno è ridotto del [Layer]%."
  },
  State_140838_Name = {
    Text = "Muro di Incubi che Oscura il Sole"
  },
  State_140839_Desc = {
    Text = "Il Danno Finale di tutti i Risvegliatori aumenta del [Layer]% in questo turno."
  },
  State_140839_Name = {
    Text = "Caccia Accompagnatrice"
  },
  State_140856_Desc = {
    Text = "Il Risvegliatore non può agire. Rimuovi 1 accumulo di Interferenza della Coscienza alla fine del turno. Dopo che tutti gli accumuli sono stati rimossi, la prossima Esaltazione del Risvegliatore viene considerata come Esaltazione Eccessiva; se l'Esaltazione Eccessiva è già stata rilasciata, restituisce il 100% dell'Aliemus Base."
  },
  State_140856_Name = {
    Text = "<Yishiganshe:Interferenza della Coscienza>"
  },
  State_140860_Desc = {
    Text = "Il Risvegliatore non può agire. Rimuovi 1 accumulo di Interferenza della Coscienza alla fine del turno. Dopo che tutti gli accumuli sono stati rimossi, la prossima Esaltazione del Risvegliatore viene considerata come Esaltazione Eccessiva; se l'Esaltazione Eccessiva è già stata rilasciata, restituisce il 100% dell'Aliemus Base."
  },
  State_140860_Name = {
    Text = "<Yishiganshe:Interferenza della Coscienza>"
  },
  State_140861_Desc = {
    Text = "La prossima Esaltazione viene considerata come Esaltazione Eccessiva; se l'Esaltazione Eccessiva è già stata rilasciata, restituisce il 100% dell'Aliemus Base."
  },
  State_140861_Name = {
    Text = "Lily nel Paese delle Meraviglie"
  },
  State_140873_Desc = {
    Text = "Ogni livello riduce dell'1% l'Effetto finale di Danno, Potere, Danni da tentacolo, Veleno fisso, Contrattacco fisso, Scudo, Guarigione della Vita e Riduzione del potere inflitti da questa Carta, fino a un massimo di [DescArg1] livelli."
  },
  State_140873_Name = {
    Text = "<AdaptKeywords:Adattamento>"
  },
  State_140877_Name = {
    Text = "Si attiva [DescArg1] volte in più"
  },
  State_141468_Desc = {
    Text = "Quando la Fame raggiunge 5 livelli, alla fine del turno consuma tutta la Fame, cambia l'intenzione in Attacco Potente e ottieni Potere."
  },
  State_141468_Name = {
    Text = "<HungerKeywords:Fame>"
  },
  State_141504_Desc = {
    Text = "Si accumulano al massimo 3 carcasse; una volta raggiunto il limite, la prossima \"Gala Necrotico\" potrà consumarle e potenziarne l'Effetto. Le carcasse vengono ereditate nel combattimento successivo."
  },
  State_141504_Name = {Text = "Cadavere"},
  State_141950_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: All'equipaggiamento e al termine del turno, <PVPDiscoveryKeyWords:Scopri> [StateArg1] carte \"Abilità\" con <PVPVoidKeywords:Illusione> aggiunta e inseriscile in Mano."
  },
  State_141950_Name = {
    Text = "Discesa verso l'Alto"
  },
  State_141988_Desc = {
    Text = "Il Danno, lo Scudo, la cura inflitti da questa Carta, il Potere, il Prosciugamento, i Danni da tentacolo, il Veleno, il Contrattacco, il Verdetto Finale, il Veleno fisso, il Contrattacco fisso, il Verdetto Finale fisso applicati aumentano del [Layer]%."
  },
  State_141988_Name = {
    Text = "Iridescenza di questa Carta"
  },
  State_141989_Desc = {
    Text = "Crea Carte casuali."
  },
  State_141989_Name = {
    Text = "<CardKeyWord:Scoperta>"
  },
  State_141991_Desc = {
    Text = "Il Danno, lo Scudo, la cura inflitti dall'Esaltazione di questo Risvegliatore, il Potere, il Prosciugamento, i Danni da tentacolo, il Veleno, il Contrattacco, il Verdetto Finale, il Veleno fisso, il Contrattacco fisso, il Verdetto Finale fisso applicati aumentano del [Layer]%."
  },
  State_141991_Name = {
    Text = "Iridescenza dell'Esaltazione"
  },
  State_141992_Desc = {
    Text = "Il Danno, lo Scudo, la cura inflitti dalle Carte di questo Risvegliatore, il Potere, il Prosciugamento, i Danni da tentacolo, il Veleno, il Contrattacco, il Verdetto Finale, il Veleno fisso, il Contrattacco fisso, il Verdetto Finale fisso applicati aumentano del [Layer]%."
  },
  State_141992_Name = {
    Text = "Iridescenza di questa Carta"
  },
  State_141993_Desc = {
    Text = "Il Danno, lo Scudo, la cura inflitti dalle Carte di comando di questo Risvegliatore, il Potere, il Prosciugamento, i Danni da tentacolo, il Veleno, il Contrattacco, il Verdetto Finale, il Veleno fisso, il Contrattacco fisso, il Verdetto Finale fisso applicati aumentano del [Layer]%."
  },
  State_141993_Name = {
    Text = "Iridescenza delle Carte di comando"
  },
  State_141994_Desc = {
    Text = "Dopo aver giocato una Carta, dopo aver scatenato un'Esaltazione causando Danno, ottenendo uno Scudo, curando, applicando Potere, Prosciugamento, Danni da tentacolo, Veleno, Contrattacco, Verdetto Finale, Veleno fisso, Contrattacco fisso, Verdetto Finale fisso."
  },
  State_141994_Name = {
    Text = "Comando Attivazione Multicolore"
  },
  State_142018_Desc = {
    Text = "All'inizio del turno, ottieni 1 accumulo di <Guaiwucanhai:Relitto>"
  },
  State_142018_Name = {
    Text = "Invito Cremisi"
  },
  State_142057_Desc = {
    Text = "Dopo aver usato una Posse, cambia la propria intenzione. All'inizio del combattimento, il Livello Rigenerazione Keyflare di tutti i Risvegliatori aumenta del 25%."
  },
  State_142057_Name = {
    Text = "Epifania di Causa ed Effetto"
  },
  State_142058_Desc = {
    Text = "Il DAN base, il Veleno e il Contrattacco inflitti sono ridotti del [DescArg1]%"
  },
  State_142058_Name = {Text = "Ali Impure"},
  State_142060_Desc = {
    Text = "Ogni volta che il nemico usa una Carta di comando, si ottiene 1 stack di Fervore Temporaneo. Quando il Fervore Temporaneo raggiunge 10 stack, dopo aver giocato la prossima Carta di comando, si agisce immediatamente e si rimuove tutto il Fervore Temporaneo."
  },
  State_142060_Name = {
    Text = "Eco dell'Abisso"
  },
  State_142062_Desc = {
    Text = "L'Effetto iniziale di 0246 è casuale ogni volta"
  },
  State_142062_Name = {
    Text = "Intenzione Casuale"
  },
  State_142063_Desc = {
    Text = "Durante il proprio turno, il Danno subito è ridotto del [DescArg1]%."
  },
  State_142063_Name = {Text = "Ali Sacre"},
  State_142065_Desc = {
    Text = "Rimosso all'inizio del turno. Quando raggiunge 10 stack, dopo aver giocato la prossima Carta di comando, si agisce immediatamente e si rimuove tutto il Fervore Temporaneo."
  },
  State_142065_Name = {
    Text = "Fervore Temporaneo"
  },
  State_142066_Desc = {
    Text = "Gli effetti di <WeaknessIconKeywords:Debolezza>, <FragileIconKeywords:Fragile> e <HeavyInjuryKeywords:Flagello> sono aumentati al 50%."
  },
  State_142066_Name = {
    Text = "Intuizione Essenziale"
  },
  State_142067_Desc = {
    Text = "Il Potere, il Contrattacco e i Danni da tentacolo inflitti sono ridotti del [DescArg1]%"
  },
  State_142067_Name = {
    Text = "Ali Maledette"
  },
  State_142072_Desc = {
    Text = "Ogni volta che subisci Danno o perdi PV, la quantità non può superare il 5% dei PV massimi."
  },
  State_142072_Name = {
    Text = "Soglia di Sopportazione del Dolore"
  },
  State_142091_Desc = {
    Text = "Conteggio Raddoppio delle Sei Ali"
  },
  State_142091_Name = {
    Text = "Conteggio Raddoppio delle Sei Ali"
  },
  State_142092_Desc = {
    Text = "Il Livello Rigenerazione Keyflare di tutti i Risvegliatori aumenta del 25%."
  },
  State_142092_Name = {
    Text = "Epifania di Causa ed Effetto"
  },
  State_142093_Desc = {
    Text = "Progresso consumo Raddoppio delle Sei Ali: [DescArg1], valore di danno subito attualmente richiesto: [DescArg2]."
  },
  State_142093_Name = {
    Text = "Raddoppio delle Sei Ali"
  },
  State_142095_Desc = {
    Text = "Indicatore Raddoppio delle Sei Ali"
  },
  State_142095_Name = {
    Text = "Indicatore Raddoppio delle Sei Ali"
  },
  State_142166_Desc = {
    Text = "Per gli effetti specifici, consulta la logica base di Colpo."
  },
  State_142213_Name = {
    Text = "Limite di Arithmetica-"
  },
  State_142215_Desc = {
    Text = "Se all'inizio del turno successivo è ancora morto, rinasce e ottiene [StateArg1] Scudo. Non può essere disperso."
  },
  State_142215_Name = {
    Text = "Ossessione Eterna"
  },
  State_142228_Desc = {
    Text = "Questa carta è stata creata dalla Ruota del destino \"Discesa verso l'Alto\"."
  },
  State_142228_Name = {
    Text = "Discesa verso l'Alto"
  },
  State_142229_Desc = {
    Text = "Unicità di Squadra: dopo l'inizio dell'esplorazione, aggiungi 1 carta \"Lily nel Paese delle Meraviglie\" al mazzo. \"Lily nel Paese delle Meraviglie\": consuma 2 punti di Arithmetica, il portatore ottiene <WeaponEffect_Num:[StateArg1]> punti di Aliemus e 3 accumuli di <Yishiganshe:\"Interferenza della Coscienza\">. <RetainIconKeywords:Conservare>. <DepleteIconKeywords:Consumare>."
  },
  State_142229_Name = {
    Text = "Lily nel Paese delle Meraviglie"
  },
  State_142229_WeaponDesc = {
    Text = "Dopo l'inizio dell'esplorazione, aggiungi 1 carta \"Lily nel Paese delle Meraviglie\" al mazzo. \"Lily nel Paese delle Meraviglie\": Consuma 2 punti di Arithmetica, il portatore ottiene <WeaponEffect_Num:[StateArg1]> punti di Aliemus e <Yishiganshe:\"Interferenza della Coscienza\">. <RetainIconKeywords:Conservare>. <DepleteIconKeywords:Consumare>."
  },
  State_142452_Desc = {
    Text = "Gli effetti di Riduzione del potere subiti vengono ridotti del 50%."
  },
  State_142452_Name = {
    Text = "Esistenza Immortale"
  },
  State_142663_Desc = {
    Text = "All'inizio del prossimo turno, ottieni <DelayKeywords:Ritardo>: [Layer] Aliemus."
  },
  State_142663_Name = {
    Text = "Aliemus Ritardato in Ritardo"
  },
  State_142688_Desc = {
    Text = "La Ruota del destino equipaggiata dal bersaglio viene disattivata. Non può essere disperso."
  },
  State_142688_Name = {
    Text = "Super Intrecciare"
  },
  State_142692_Desc = {
    Text = "Stanno emergendo nuove piccole idee."
  },
  State_142692_Name = {
    Text = "Lampo di genio"
  },
  State_142715_Desc = {
    Text = "Il Danno di questa \"abilità\" aumenta del [DescArg1]%, e per ogni punto di Arithmetica consumato da questa abilità aumenta del [StateArg1]%."
  },
  State_142715_Name = {
    Text = "Morte color ambra"
  },
  State_142887_Desc = {
    Text = "Se in questo turno si subisce nuovamente la \"Paralisi\", tutti i \"Colpi\" diventano \"Illusioni\", non possono essere dispersi e l'effetto dura fino alla fine del turno."
  },
  State_142887_Name = {
    Text = "Un po' intorpidito"
  },
  State_142954_Desc = {
    Text = "Il Limite di Arithmetica è minimo 0. All'inizio di ogni turno, se è inferiore a 10, aumenta di 1. Dopo aver raggiunto 10, ogni ulteriore Limite di Arithmetica ottenuto viene convertito nel pescare un numero equivalente di Carte."
  },
  State_142954_Name = {
    Text = "Limite di Arithmetica"
  },
  State_143002_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Non configurata"
  },
  State_143002_Name = {
    Text = "Sartogua SR (testo temporaneo)"
  },
  State_143004_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Non configurata"
  },
  State_143004_Name = {
    Text = "Arma esclusiva Tsathoggua (testo temporaneo)"
  },
  State_143005_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Non configurata"
  },
  State_143005_Name = {
    Text = "Lantigos SR (testo temporaneo)"
  },
  State_143006_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Non configurata"
  },
  State_143006_Name = {
    Text = "Arma esclusiva Nephren-Ka (testo temporaneo)"
  },
  State_143007_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Quando equipaggiata e all'inizio del turno, applica [StateArg1] <plural value=\"[StateArg1]\" singular=\"accumulo\" plural=\"accumuli\"> di <PVPCompassKeywords:La Bussola Errante> a un nemico casuale."
  },
  State_143007_Name = {
    Text = "La Bussola Errante"
  },
  State_143008_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Non configurata"
  },
  State_143008_Name = {
    Text = "Arma esclusiva Shantak (testo temporaneo)"
  },
  State_143009_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Non configurata"
  },
  State_143009_Name = {
    Text = "Arma esclusiva Aforgomon (testo temporaneo)"
  },
  State_143010_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Limite Massima della Mano+ [StateArg1]. Quando il portatore o un alleato muore, le sue Carte non vengono più convertite in <PVPDerivativeCardKeywords_2:\"Illusione\">, bensì in <PVPDerivativeCardKeywords_30:\"Gaunt-Predone\">."
  },
  State_143010_Name = {
    Text = "Gabbia Vivente"
  },
  State_143011_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Non configurata"
  },
  State_143011_Name = {
    Text = "Avvoltoio SR (Testo Temporaneo)"
  },
  State_143012_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Non configurata"
  },
  State_143012_Name = {
    Text = "Uccello Shatak SR (Testo Temporaneo)"
  },
  State_143013_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Non configurata"
  },
  State_143013_Name = {
    Text = "Genesi Ogier SR (Testo Temporaneo)"
  },
  State_143014_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Prima dell'\"Esaltazione\" perde il 25% della Vita attuale; dopo l'\"Esaltazione\" infligge [StateArg1] Danno a tutti i nemici e drena una quantità equivalente di Vita."
  },
  State_143014_Name = {
    Text = "Inganno melato"
  },
  State_143016_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Non configurata"
  },
  State_143016_Name = {
    Text = "Faraone Nero SR (testo temporaneo)"
  },
  State_143017_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Non configurata"
  },
  State_143017_Name = {
    Text = "Arma esclusiva Rhan-Tegoth (testo temporaneo)"
  },
  State_143018_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Non configurata"
  },
  State_143018_Name = {
    Text = "Genesi Tulu SR (Testo Temporaneo)"
  },
  State_143019_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo \"Esaltazione\", applica [StateArg1] strati di <PVPBless:Benedire> a tutti i nemici."
  },
  State_143019_Name = {
    Text = "La Verità Dolce"
  },
  State_143020_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Non configurata"
  },
  State_143020_Name = {
    Text = "Arma Esclusiva Genesi Ogier (Testo Temporaneo)"
  },
  State_143022_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Non configurata"
  },
  State_143022_Name = {
    Text = "Arma esclusiva Avvoltoio (testo temporaneo)"
  },
  State_143023_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Non configurata"
  },
  State_143023_Name = {
    Text = "Yafagomon SR (Testo Temporaneo)"
  },
  State_143326_Desc = {
    Text = "Ricarica della chiave d'argento aumentata di [DescArg1]."
  },
  State_143326_Name = {
    Text = "Epifania di Causa ed Effetto"
  },
  State_143331_Desc = {
    Text = "Prima della fine del prossimo turno assorbe metà del Danno per <StatusApplier:>, questo Stato è Unicità di Squadra, viene rimosso quando uno dei due legati muore, non può essere dissipato."
  },
  State_143331_Name = {
    Text = "Ricezione Danno"
  },
  State_143333_Desc = {
    Text = "Prima dell'inizio del prossimo turno <StatusApplier:> assorbe metà del Danno al suo posto, questo Stato è Unicità di Squadra, viene rimosso quando uno dei due legati muore, non può essere dissipato."
  },
  State_143333_Name = {
    Text = "Deviazione Danno"
  },
  State_143336_Desc = {
    Text = "Conferisce a \"Thrall-Gaunt\" Ha effetto 1 volta aggiuntiva. Quando si gioca \"Thrall-Gaunt\", consuma 1 livello, fino a un massimo di 9 livelli, non vengono rimossi al termine del combattimento."
  },
  State_143336_Name = {
    Text = "<BattueKeywords:La Caccia>"
  },
  State_143340_Desc = {
    Text = "Conferisce a \"Thrall-Gaunt\" Ha effetto 1 volta aggiuntiva. Quando si gioca \"Thrall-Gaunt\", consuma 1 livello, fino a un massimo di 9 livelli, non vengono rimossi al termine del combattimento."
  },
  State_143340_Name = {
    Text = "<BattueKeywords:La Caccia>"
  },
  State_143386_Desc = {
    Text = "Assorbe metà del Danno per <StatusApplier:>, non può essere dissipato."
  },
  State_143386_Name = {
    Text = "Ricezione Danno"
  },
  State_143387_Desc = {
    Text = "<StatusApplier:> assorbe metà del Danno al suo posto, non può essere dissipato."
  },
  State_143387_Name = {
    Text = "Deviazione Danno"
  },
  State_143406_Name = {
    Text = "Questa Carta ha effetto [DescArg1] volte aggiuntive"
  },
  State_143408_Desc = {
    Text = "Quando attaccato da un nemico, converti all'Aliemus dell'attaccante."
  },
  State_143408_Name = {
    Text = "La Bussola Errante"
  },
  State_143409_Desc = {
    Text = "Quando attaccato da un nemico, converti all'Aliemus dell'attaccante."
  },
  State_143409_Name = {
    Text = "<CardKeyWord:La Bussola Errante>"
  },
  State_143419_Desc = {
    Text = "Questa carta proviene da <PVPDerivativeCardKeywords_31:\"Il Tesoro di Aurita\">."
  },
  State_143419_Name = {
    Text = "Il Tesoro di Aurita"
  },
  State_143426_Desc = {
    Text = "Dopo l'inizio del turno, detrae [Layer] Arithmetica, non può essere dissipato."
  },
  State_143426_Name = {
    Text = "Detrazione Arithmetica Ritardata"
  },
  State_143441_Desc = {
    Text = "Il Risvegliatore selezionato durante il turno [StateArg1]."
  },
  State_143441_Name = {
    Text = "Segnalino di test 1"
  },
  State_143442_Desc = {
    Text = "Il Risvegliatore selezionato durante il turno [StateArg1]."
  },
  State_143442_Name = {
    Text = "Segnalino di test 2"
  },
  State_143444_Desc = {
    Text = "Il Risvegliatore selezionato durante il turno [StateArg1]."
  },
  State_143444_Name = {
    Text = "Segnalino di test 4"
  },
  State_143445_Desc = {
    Text = "Il Risvegliatore selezionato durante il turno [StateArg1]."
  },
  State_143445_Name = {
    Text = "Segnalino di test 3"
  },
  State_143499_Name = {
    Text = "Immune al Danno attivo__\"Solo per sviluppo\""
  },
  State_143500_Name = {
    Text = "Immune al Danno puro__\"Solo per sviluppo\""
  },
  State_143541_Desc = {
    Text = "Il Danno inflitto da tutti i nemici in questo turno è ridotto del [DescArg1]%, e si ottengono [DescArg2] punti Potere."
  },
  State_143541_Name = {Text = "Scorta"},
  State_143542_Desc = {
    Text = "Danno Finale Temporaneo +[DescArg1]%, e infligge Corrosione pari al [DescArg2]% della Salute massima a tutti i nemici."
  },
  State_143542_Name = {Text = "Caccia"},
  State_143548_Desc = {
    Text = "Infligge Scudo e aggiunge Stato, Mostro, ramo 1."
  },
  State_143548_Name = {
    Text = "Scudo Mostro Ramo 1"
  },
  State_143549_Desc = {
    Text = "Infligge Scudo e aggiunge Stato, Risvegliatore, ramo 2."
  },
  State_143549_Name = {
    Text = "Scudo Personaggio Ramo 2"
  },
  State_143550_Desc = {
    Text = "Infligge Scudo e aggiunge Stato, Risvegliatore, ramo 1."
  },
  State_143550_Name = {
    Text = "Scudo Personaggio Ramo 1"
  },
  State_143551_Desc = {
    Text = "Infligge Scudo e aggiunge Stato, Mostro, ramo 2."
  },
  State_143551_Name = {
    Text = "Scudo Mostro Ramo 2"
  },
  State_143552_Desc = {
    Text = "Infligge Scudo e aggiunge Stato, giocatore, ramo 1."
  },
  State_143552_Name = {
    Text = "Scudo Giocatore Ramo 1"
  },
  State_143553_Desc = {
    Text = "Infligge Scudo e aggiunge Stato, giocatore, ramo 2."
  },
  State_143553_Name = {
    Text = "Scudo Giocatore Ramo 2"
  },
  State_143573_Desc = {
    Text = "Il Gaunt è una carta potenziamento di Pontos che include \"Gaunt-Razziatore\", \"Gaunt-Tormento\" e \"Gaunt-Uccisore\", per un totale di 3 tipi. Quando si genera un \"Gaunt\" permanente, se i \"Gaunt\" permanenti superano 6, un \"Gaunt\" permanente casuale viene potenziato in \"Gaunt Congiunti\" con Costo di Arithmetica +1 ma che Ha effetto 1 volta aggiuntiva; se tutti i \"Gaunt\" sono già stati potenziati, si aggiunge in mano 1 \"Av. Intuizione\" con <DestructionKeywords:Distruggere>."
  },
  State_143573_Name = {Text = "Gaunt"},
  State_143578_Desc = {
    Text = "In questo turno, ogni volta che si subisce un Danno attivo, aggiungi [Layer] carte <PVPDerivativeCardKeywords_30:\"Thrall-Gaunt\"> alla Mano."
  },
  State_143578_Name = {
    Text = "Rito del Signore"
  },
  State_143595_Desc = {
    Text = "Questa Carta ha ricevuto <PrepareKeywords:Preparazione> [StateArg1]."
  },
  State_143595_Name = {
    Text = "Danza del Cigno Nero"
  },
  State_143597_Desc = {
    Text = "Unicità di Squadra: l'Effetto di Riduzione del potere causato dal portatore aumenta del <WeaponEffect_Num:[StateArg1]%>. Quando si passa alla postura \"Onde Impetuose\", i DAN CRIT temporanei aumentano di un valore pari al <WeaponEffect_Num:[StateArg1]%> del proprio Danno critico base, con un cooldown di 3 turni."
  },
  State_143597_WeaponDesc = {
    Text = "L'Effetto di Riduzione del potere causato dal portatore aumenta del <WeaponEffect_Num:[StateArg1]%>. Dopo essere passati alla postura \"Onde Impetuose\", i DAN CRIT temporanei aumentano del <WeaponEffect_Num:[DescArg1]%>, con un cooldown di 3 turni."
  },
  State_143598_Desc = {
    Text = "Unicità di Squadra: l'Effetto di Riduzione del potere causato dal portatore aumenta del <WeaponEffect_Num:[StateArg1]%>; per ogni nemico ucciso, l'Aliemus recuperato a fine turno di esplorazione dal portatore aumenta di 2 punti, con un massimo di <WeaponEffect_Num:[StateArg2]> accumuli. Dopo essere passati alla postura \"Onde Impetuose\", i DAN CRIT temporanei aumentano di un valore pari al <WeaponEffect_Num:[StateArg1]%> del proprio Danno critico base, con un cooldown di 3 turni."
  },
  State_143598_WeaponDesc = {
    Text = "L'Effetto di Riduzione del potere causato dal portatore aumenta del <WeaponEffect_Num:[StateArg1]%>; per ogni nemico ucciso, l'Aliemus recuperato a fine turno di esplorazione dal portatore aumenta di 2 punti, con un massimo di <WeaponEffect_Num:[StateArg2]> accumuli. Dopo essere passati alla postura \"Onde Impetuose\", i DAN CRIT temporanei aumentano del <WeaponEffect_Num:[DescArg1]%>, con un cooldown di 3 turni."
  },
  State_143683_Desc = {
    Text = "L'Inseguimento di questo Risvegliatore è Sigillato e non può essere utilizzato, il Sigillo viene rimosso dopo [Layer] turni."
  },
  State_143683_Name = {
    Text = "<Seal1:Inseguimento Sigillato>"
  },
  State_144381_Desc = {
    Text = "Impossibile eseguire Azioni, Rimanente [DescArg1] turni."
  },
  State_144381_Name = {
    Text = "<Yishiganshe:Interferenza della Coscienza>"
  },
  State_144441_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Quando un alleato muore, ottieni <Energy:[Energy:StateArg1]> Aliemus. Quando un alleato viene riportato in vita, ottiene <Energy:[Energy:StateArg2]> Aliemus. L'effetto di acquisizione Aliemus si attiva solo se l'Aliemus del bersaglio non è pieno; rimane attivo per [Layer] volte, dopodiché questa Ruota del destino viene Distrutta."
  },
  State_144441_Name = {
    Text = "Sincronizzazione dell'Anima"
  },
  State_144494_Desc = {
    Text = "Ci sono 7 tipi di effetti, tra cui: pescare 8 carte, ottenere 6 Arithmetica, ottenere Energia-S, tutti i Risvegliatori ottengono Aliemus Fisso, ottenere FOR, ridurre temporaneamente la FOR di tutti i nemici, aumentare temporaneamente l'Amplificazione del Danno."
  },
  State_144494_Name = {
    Text = "<Blessing:Benedizione>"
  },
  State_144508_Desc = {
    Text = [[
Il "Prezzo" si presenta in 3 tipi:

Occasione Persa: Ritarda l'effetto del "Dono" associato di 2 turni.
Parole Dorate: Riduce l'effetto del "Dono" associato del 50%.
Malizia Velata: Infligge 1 effetto negativo casuale alla tua squadra:
<Italic:2 turni di Sintomo: Debolezza; 2 turni di Fragile, 2 turni di Flagello; accumuli di Veleno pari all'1% della Salute massima; 2 accumuli di Vuoto; 1 accumulo di Stagnazione su 2 carte casuali in mano; oppure genera 2 Carte sintomo Temporanee (che non persistono tra le battaglie) e le posiziona in cima al Mazzo di Pesca.>]]
  },
  State_144508_Name = {
    Text = "<BlessingNegativeEffect:Prezzo>"
  },
  State_144519_Desc = {
    Text = "Variabile di processo di test, si aggiorna dopo l'inizio del turno o dopo aver giocato una Carta. Attualmente possiede [Layer] spiriti del Reame."
  },
  State_144519_Name = {
    Text = "Spirito del nuovo Reame del Caos"
  },
  State_145228_Name = {
    Text = "<WormGrowth:Banchetto>"
  },
  State_145229_Desc = {
    Text = "Fai parte della Benedizione~! Può essere consumata dall'Esaltazione di Caraboo per un potenziamento, si accumula fino a 5. Persiste tra le battaglie."
  },
  State_145229_Name = {
    Text = "<SacrificialMark:Sacrificio>"
  },
  State_145436_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Il Danno del \"Colpo\" aumenta del [DescArg1]%, dopo ogni \"Colpo\" il Danno aumenta ulteriormente del [StateArg2]%, fino a un massimo del [StateArg3]%."
  },
  State_145436_Name = {
    Text = "Ossa della Fame Immortale"
  },
  State_145437_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: All'equipaggiamento ottieni [StateArg2] accumuli di <EnergyStorageKeywords:Carica>, il Danno del \"Colpo\" aumenta del [StateArg1]% e diventa <PVPPunctureDamagewords:Danni Perforanti>."
  },
  State_145437_Name = {
    Text = "Rovina Celeste"
  },
  State_145456_Desc = {
    Text = "Quando si seleziona un bersaglio, ignora Scherno, Furtività e Blocco. Se più bersagli soddisfano la stessa condizione, viene selezionato prima il Risvegliatore in posizione anteriore."
  },
  State_145456_Name = {
    Text = "Vita e Scudo Minimi"
  },
  State_145457_Desc = {
    Text = "Quando si seleziona un bersaglio, ignora Scherno, Furtività e Blocco. Se più bersagli soddisfano la stessa condizione, viene selezionato prima il Risvegliatore in posizione anteriore."
  },
  State_145457_Name = {
    Text = "Vita e Scudo Massimi"
  },
  State_145495_Desc = {
    Text = "Questa Carta viene giocata con Doppio Colpo."
  },
  State_145495_Name = {
    Text = "<CardKeyWord:Doppio Colpo>"
  },
  State_145554_Desc = {
    Text = "Unicità di Squadra: Dopo l'inizio dell'esplorazione, aggiunge 1 carta <Falltospace1[StateArg3]:\"Soggiorno Mortale\"> al mazzo. \"Soggiorno Mortale\": Consuma 0 Arithmetica. Infligge a tutti i nemici una <Corrosion:Corrosione> fissa pari al <WeaponEffect_Num:[StateArg1]%> dell'ATT del portatore e al <WeaponEffect_Num:[Float:StateArg4]%> della sua Salute massima, fa sì che le Carte di comando degli altri Risvegliatori in ogni posizione acquisiscano <ErosionColorInkKeywords:Distorsione Percettiva> e mischia 1 carta <Falltospace2[StateArg3]:\"Discesa verso l'Alto\"> nel Mazzo di Pesca. <RetainIconKeywords:Conservare>. <DepleteIconKeywords:Consumo>."
  },
  State_145554_Name = {
    Text = "Discesa verso l'Alto"
  },
  State_145554_WeaponDesc = {
    Text = "Dopo l'inizio dell'esplorazione, aggiunge 1 carta <Falltospace1[StateArg3]:\"Soggiorno Mortale\"> al mazzo. \"Soggiorno Mortale\": Consuma 0 Arithmetica. Infligge a tutti i nemici una <Corrosion:Corrosione> fissa pari al <WeaponEffect_Num:[StateArg1]%> dell'ATT del portatore e al <WeaponEffect_Num:[Float:StateArg4]%> della sua Salute massima, fa sì che le Carte di comando degli altri Risvegliatori in ogni posizione acquisiscano <ErosionColorInkKeywords:Distorsione Percettiva> e mischia 1 carta <Falltospace2[StateArg3]:\"Discesa verso l'Alto\"> nel Mazzo di Pesca. <RetainIconKeywords:Conservare>. <DepleteIconKeywords:Consumo>"
  },
  State_145572_Desc = {
    Text = "All'Inizio di ogni turno, tutti gli altri Risvegliatori infliggono <Damage:[Damage:Layer]> Danni Perforanti."
  },
  State_145572_Name = {
    Text = "Tempesta Divoratrice di Cetus"
  },
  State_145590_Desc = {
    Text = "Quando una Carta identica con la stessa appartenenza viene aggiunta alla mano, si attiva l'Effetto di Fusione e quella Carta viene consumata."
  },
  State_145590_Name = {
    Text = "<CardKeyWord:Fusione>"
  },
  State_145592_Desc = {
    Text = "Aggancia un nemico, rendendolo il bersaglio prioritario per gli attacchi. Quando si seleziona un bersaglio singolo, è possibile selezionare solo il bersaglio agganciato, ignorando Scherno e occultamento."
  },
  State_145592_Name = {
    Text = "<CardKeyWord:Aggancio>"
  },
  State_145619_Name = {Text = "Flagello"},
  State_145620_Name = {Text = "Vuoto"},
  State_145621_Desc = {
    Text = "L'effetto \"Benedizione\" viene ridotto del 50%."
  },
  State_145621_Name = {
    Text = "<Bleesing_Exaggerate:Esagerazione>"
  },
  State_145622_Name = {
    Text = "Stagnazione"
  },
  State_145623_Desc = {
    Text = [[
Infligge 1 effetto negativo casuale alla tua squadra:
<Italic:2 turni di Sintomo: Debolezza; 2 turni di Fragile, 2 turni di Flagello; accumuli di Veleno pari all'1% della Salute massima; 2 accumuli di Vuoto; 1 accumulo di Stagnazione su 2 carte casuali in mano; oppure genera 2 Carte sintomo Temporanee (che non persistono tra le battaglie) e le posiziona in cima al Mazzo di Pesca.>]]
  },
  State_145623_Name = {
    Text = "<Bleesing_Negative:Malizia Velata>"
  },
  State_145624_Name = {Text = "Debolezza"},
  State_145625_Name = {
    Text = "2 \"Carte sintomo\" temporanee identiche"
  },
  State_145626_Name = {Text = "Fragile"},
  State_145627_Name = {Text = "Veleno"},
  State_145628_Desc = {
    Text = "Ottieni l'effetto \"Benedizione\" dopo 2 turni."
  },
  State_145628_Name = {
    Text = "<Bleesing_Delay:Occasione Mancata>"
  },
  State_145631_Desc = {
    Text = "Il Danno del \"Colpo\" aumenta del [StateArg1]% e diventa <PVPPunctureDamagewords:Danni Perforanti>."
  },
  State_145631_Name = {
    Text = "Rovina Celeste"
  },
  State_145632_Desc = {
    Text = "Questa carta proviene dalla Ruota del destino \"Ora della Fortuna\"."
  },
  State_145632_Name = {
    Text = "Ora della Fortuna"
  },
  State_145638_Desc = {
    Text = "Il Costo di Arithmetica di questa Carta aumenta di [Layer]."
  },
  State_145638_Name = {
    Text = "Omaggio Crudele"
  },
  State_145642_Desc = {
    Text = "Dopo 2 turni tutti i Risvegliatori ottengono [StateArg1] punti di Aliemus [Layer] volte."
  },
  State_145642_Name = {
    Text = "Aliemus Ritardato"
  },
  State_145644_Desc = {
    Text = "Dopo 2 turni ottieni <Posse:[StateArg1]> punti di Energia-S [Layer] volte."
  },
  State_145644_Name = {
    Text = "Energia-S Ritardata"
  },
  State_145645_Desc = {
    Text = "Dopo 2 turni riduce temporaneamente la <ExhaustionIconKeywords:Forza> di tutti i nemici di [StateArg1] punti [Layer] volte"
  },
  State_145645_Name = {
    Text = "Risucchio Ritardato"
  },
  State_145646_Desc = {
    Text = "Dopo 2 turni ottieni [StateArg1] punti di Arithmetica [Layer] volte."
  },
  State_145646_Name = {
    Text = "Arithmetica Ritardata"
  },
  State_145647_Desc = {
    Text = "Dopo 2 turni ottieni [StateArg1] punti di <PowerIconKeywords:Forza> [Layer] volte."
  },
  State_145647_Name = {
    Text = "Potere Ritardato"
  },
  State_145648_Desc = {
    Text = "Dopo 2 turni pesca [StateArg1] Carte [Layer] volte."
  },
  State_145648_Name = {
    Text = "Pescata Ritardata"
  },
  State_145649_Desc = {
    Text = "Dopo 2 turni Amplificazione del Danno temporanea del [StateArg1]% [Layer] volte."
  },
  State_145649_Name = {
    Text = "Ritardo Amplificazione del Danno Temporanea"
  },
  State_145652_Desc = {
    Text = "Costo di Arithmetica di questa carta -[Layer]."
  },
  State_145652_Name = {
    Text = "Libertà Insostenibile"
  },
  State_145654_Desc = {
    Text = "Test. Dopo essere stata giocata, o dopo aver lasciato la Mano, viene Distrutta."
  },
  State_145654_Name = {
    Text = "Test. Istante"
  },
  State_145660_Desc = {
    Text = [=[
Alleati
1.<AllyPosAwaker1Name:> [DescArg1]
2.<AllyPosAwaker2Name:> [DescArg2]
3.<AllyPosAwaker3Name:> [DescArg3]
4.<AllyPosAwaker4Name:> [DescArg4]
Nemici
1.<EnemyPosAwaker1Name:> [DescArg5]
2.<EnemyPosAwaker2Name:> [DescArg6]
3.<EnemyPosAwaker3Name:> [DescArg7]
4.<EnemyPosAwaker4Name:> [DescArg8]]=]
  },
  State_145660_Name = {
    Text = "Variazione di Vita Dopo Reimposta"
  },
  State_145693_Desc = {
    Text = "A fine turno, Costo di Arithmetica -[Layer]. Questo Effetto si attiva anche se scartata."
  },
  State_145693_Name = {
    Text = "<PrepareKeypvewordscolour:Preparazione[Layer]>"
  },
  State_145693_WeaponDesc = {
    Text = "La carta non entra nella Pila degli scarti, ma rimane In Mano."
  },
  State_145694_Desc = {Text = "—"},
  State_145694_Name = {
    Text = "Simbiosi con la Palude Nera"
  },
  State_145694_WeaponDesc = {Text = "—"},
  State_145698_Desc = {
    Text = "Attacca prioritariamente il bersaglio in Blocco con <StatusApplier:>, quando si seleziona un bersaglio singolo è possibile selezionare solo il bersaglio in Blocco, ignorando Scherno e occultamento."
  },
  State_145698_Name = {Text = "Aggancio"},
  State_145699_Desc = {
    Text = "·Attacca prioritariamente il <StatusApplier:> agganciato; quando si seleziona un bersaglio singolo, è possibile selezionare solo il bersaglio agganciato, ignorando Scherno e occultamento.\n·Dopo la propria morte, <StatusApplier:> ottiene \"<PVPDerivativeCardKeywords_32:Vieni a combattere!>\"."
  },
  State_145699_Name = {Text = "Aggancio"},
  State_145709_Desc = {
    Text = "Ogni accumulo aumenta la Salute massima del 10% del COS di Caraboo (max 50 accumuli). Al massimo degli accumuli, gli accumuli in eccesso curano invece per 3× questo valore di Vita. Si possono ottenere fino a 10 accumuli di \"Sazietà\" per battaglia non Boss. La \"Sazietà\" persiste tra le battaglie."
  },
  State_145709_Name = {
    Text = "<WormGrowth:Banchetto>"
  },
  State_145710_Desc = {
    Text = "Fai parte della Benedizione~! Può essere consumata dall'Esaltazione di Caraboo per un potenziamento, si accumula fino a 5. Persiste tra le battaglie."
  },
  State_145710_Name = {
    Text = "<SacrificialMark:Sacrificio>"
  },
  State_145901_Desc = {
    Text = [=[
Nostri
1.<AllyPosAwaker1Name:> [DescArg1]
2.<AllyPosAwaker2Name:> [DescArg2]
3.<AllyPosAwaker3Name:> [DescArg3]
4.<AllyPosAwaker4Name:> [DescArg4]]=]
  },
  State_145901_Name = {
    Text = "Variazione di Vita Dopo Reimposta"
  },
  State_146041_Desc = {
    Text = "Il Risvegliatore si sente distaccato dal clamore del mondo.\nPrima della fine del turno non può compiere alcuna Azione, riduce il Danno subito del 99%, se il bersaglio non ha Resistenza gli conferisce Resistenza.\nPrima della fine del turno non può compiere alcuna Azione, riduce il Danno subito del 99%, se il bersaglio non ha Resistenza gli conferisce Resistenza.\n·Al termine dell'effetto infligge <Damage:[Layer]> Danno passivo a tutti gli alleati.\n·Se al momento dell'applicazione il bersaglio possiede Resistenza, il Raggiro termina immediatamente e il Danno al bersaglio raddoppia."
  },
  State_146041_Name = {Text = "Raggiro"},
  State_146043_Desc = {
    Text = "All'inizio del prossimo turno, detrae [Layer] Aliemus."
  },
  State_146043_Name = {
    Text = "Detrazione Aliemus Ritardata"
  },
  State_146058_Desc = {
    Text = "Variabile di processo di test, si aggiorna dopo l'inizio del turno o dopo aver giocato una Carta. Dovrebbe avere attualmente [Layer]% di efficacia ATT."
  },
  State_146058_Name = {
    Text = "Efficacia ATT della Posse"
  },
  State_146059_Desc = {
    Text = "Variabile di processo di test, si aggiorna dopo l'inizio del turno o dopo aver giocato una Carta. Dovrebbe avere attualmente [Layer]% di efficacia DIF."
  },
  State_146059_Name = {
    Text = "Efficacia DIF della Posse"
  },
  State_146079_Desc = {
    Text = "Questa Carta ritorna in mano dopo essere stata giocata o scartata."
  },
  State_146079_Name = {
    Text = "<Recycle:Ritorna in mano>"
  },
  State_146085_Desc = {
    Text = "Modifica l'Arithmetica della Carta giocata in questo turno"
  },
  State_146085_Name = {
    Text = "Modifica l'Arithmetica della Carta giocata in questo turno"
  },
  State_146085_WeaponDesc = {
    Text = "Modifica l'Arithmetica della carta prima di giocarla"
  },
  State_146086_Desc = {
    Text = "Modifica l'Arithmetica della Carta giocata in questo turno"
  },
  State_146086_Name = {
    Text = "Modifica l'Arithmetica della Carta giocata in questo turno"
  },
  State_146086_WeaponDesc = {
    Text = "Modifica l'Arithmetica della carta prima di giocarla"
  },
  State_146117_Desc = {
    Text = "Può essere consumato da \"<DerivativeCardKeywords_157:Osso della Spada>\" per ottenere un potenziamento. Questo Stato può accumularsi fino a 15 livelli."
  },
  State_146117_Name = {
    Text = "<Shimieluotanhuodong2:Intento di Battaglia>"
  },
  State_146129_Desc = {
    Text = "Danno Finale di tutti i Risvegliatori +[Layer]%."
  },
  State_146129_Name = {
    Text = "Intento Omicida del Cielo-Balena"
  },
  State_146147_Desc = {
    Text = "Può essere consumato da \"<DerivativeCardKeywords_157:Osso della Spada>\" per ottenere un potenziamento. Questo Stato può accumularsi fino a 15 livelli."
  },
  State_146147_Name = {
    Text = "<Shimieluotanhuodong1:Intento di Battaglia>"
  },
  State_146154_Desc = {
    Text = "Fa sentire bene questo Risvegliatore; la sua \"Abilità\" verrà trasformata in \"Benedire?\", e dopo la trasformazione consuma un numero equivalente di accumuli."
  },
  State_146154_Name = {
    Text = "<PVPBlessColour:Benedire>"
  },
  State_146155_Desc = {
    Text = "Il Risvegliatore si sente bene.\n·Nelle prossime mosse [Layer] \"Abilità\" verranno trasformate in \"Benedire?\", dopo la trasformazione consuma un numero equivalente di accumuli."
  },
  State_146155_Name = {
    Text = "Benedizione"
  },
  State_146155_WeaponDesc = {Text = "No"},
  State_146202_Desc = {
    Text = "Fa sentire il Risvegliatore distaccato dal clamore del mondo. \nNon può eseguire alcuna Azione fino alla fine del turno, riduce il Danno subito del 99%; se il bersaglio non ha Resistenza, gli conferisce Resistenza.\n·Al termine dell'Effetto, infligge Danno passivo equivalente agli accumuli a tutti gli alleati.\n·Se al momento dell'applicazione il bersaglio possiede già Resistenza, il Raggiro termina immediatamente e il Danno al bersaglio viene raddoppiato."
  },
  State_146202_Name = {
    Text = "<CardKeyWord:Raggiro>"
  },
  State_146352_Desc = {
    Text = "Ogni volta che si subisce 1 Danno, accumula [StateArg1] livelli di <Shimieluotanhuodong1:Intento di Battaglia>"
  },
  State_146352_Name = {
    Text = "Temprato dalla Battaglia"
  },
  State_146363_Desc = {
    Text = "All'Inizio del prossimo turno, rimuove [Layer] Vita. Quando si perde Vita, riduce di pari quantità gli accumuli di questo Stato."
  },
  State_146363_Name = {
    Text = "Ciò che Non è Menzogna"
  },
  State_146383_Desc = {
    Text = "Dopo aver aggiunto uno Stato e dopo aver giocato una Carta, rigenera e stampa il Livello Rigenerazione Keyflare di ogni Risvegliatore."
  },
  State_146383_Name = {
    Text = "Ingresso Efficienza"
  },
  State_146384_Desc = {
    Text = "Valore P1 [StateArg1], Valore P2 [StateArg2], Valore P3 [StateArg3], Valore P4 [StateArg4]."
  },
  State_146384_Name = {
    Text = "Valore Efficienza"
  },
  State_146385_Desc = {
    Text = "Dopo aver aggiunto uno Stato e dopo aver giocato una Carta, rigenera e stampa il Livello Rigenerazione Keyflare di ogni Risvegliatore."
  },
  State_146385_Name = {
    Text = "Ingresso Livello"
  },
  State_146386_Desc = {
    Text = "Valore P1 [StateArg1], Valore P2 [StateArg2], Valore P3 [StateArg3], Valore P4 [StateArg4]."
  },
  State_146386_Name = {
    Text = "Valore Livello"
  },
  State_146446_Desc = {
    Text = "DIF del Risvegliatore, P1: [StateArg1], P2: [StateArg2], P3: [StateArg3], P4: [StateArg4]."
  },
  State_146446_Name = {
    Text = "Elenco attributi DIF"
  },
  State_146448_Desc = {
    Text = "ATT del Risvegliatore, P1: forza[StateArg1] intensità[StateArg2], P2: forza[StateArg3] intensità[StateArg4], P3: forza[StateArg5] intensità[StateArg6], P4: forza[StateArg7] intensità[StateArg8]."
  },
  State_146448_Name = {
    Text = "Elenco attributi ATT"
  },
  State_146452_Desc = {
    Text = "Unicità di Squadra: Il Danno critico del \"Colpo\" del portatore aumenta del <WeaponEffect_Num:[StateArg1]%>. Alla fine del turno, il Danno critico della prossima Esaltazione del portatore aumenta di una percentuale pari al <WeaponEffect_Num:[StateArg2]%> del suo Base Aliemus, fino a un massimo di 5 accumuli."
  },
  State_146452_WeaponDesc = {
    Text = "Il Danno critico del \"Colpo\" del portatore aumenta del <WeaponEffect_Num:[StateArg1]%>. Al termine del turno il Danno critico della prossima Esaltazione del portatore aumenta del <WeaponEffect_Num:[DescArg1]%>, fino a un massimo di 5 accumuli (attualmente beneficia del [DescArg2]%)."
  },
  State_146456_Desc = {
    Text = "Unicità di Squadra: Il Danno critico del \"Colpo\" del portatore aumenta del <WeaponEffect_Num:[StateArg1]%>."
  },
  State_146456_WeaponDesc = {
    Text = "Il Danno critico del \"Colpo\" del portatore aumenta del <WeaponEffect_Num:[StateArg1]%>."
  },
  State_146534_Desc = {
    Text = "Dopo l'Inizio dello Stadio, aggiunge al Custode i contenitori di ogni meccanismo del Caos Origine."
  },
  State_146534_Name = {
    Text = "Inizializzazione Caos Origine"
  },
  State_146535_Desc = {
    Text = "Contenitore attributi."
  },
  State_146535_Name = {
    Text = "Identificatore Caos Origine"
  },
  State_146536_Desc = {
    Text = "Contenitore meccanismo."
  },
  State_146536_Name = {
    Text = "Meccanismo Caos Origine"
  },
  State_146644_Desc = {
    Text = "Il Risveglio della Gnosi ottiene Preparazione 1; la prima volta che si gioca una Carta per turno, la Posse trasportata viene scatenata automaticamente."
  },
  State_146644_Name = {
    Text = "Eco Primordiale"
  },
  State_146645_Desc = {
    Text = "Il nuovo Reame del Caos rilascia automaticamente la Posse al primo Risveglio di Gnosi giocato per turno. Attualmente disponibile."
  },
  State_146645_Name = {
    Text = "Identificatore Disponibile"
  },
  State_146646_Desc = {
    Text = "Il limite massimo di Energia-S di base viene modificato a 2000. La regola per ottenere Energia-S viene sostituita con: la prima volta che un Risvegliatore gioca una Carta di comando per turno, ottiene Energia-S pari a 3 volte la Ricarica della chiave d'argento + 100."
  },
  State_146646_Name = {
    Text = "Nuove regole Keyflare del Caos"
  },
  State_146651_Desc = {
    Text = "Aumenta l'attributo ATT di questo Risvegliatore del [Layer]%."
  },
  State_146651_Name = {
    Text = "Caos·Attacco"
  },
  State_146652_Desc = {
    Text = "Solo una volta dopo l'inizio del combattimento, modifica l'efficienza di Ricarica della chiave d'argento di ogni Risvegliatore alla media del Livello Rigenerazione Keyflare."
  },
  State_146652_Name = {
    Text = "Equilibrio Origine"
  },
  State_146653_Desc = {
    Text = "Aumenta l'attributo DIF di questo Risvegliatore del [Layer]%."
  },
  State_146653_Name = {
    Text = "Caos·Difesa"
  },
  State_146663_Desc = {
    Text = "Il \"Colpo\" delle prossime [Layer] carte Lotan: Cetarcon Ha effetto 1 volta aggiuntiva."
  },
  State_146663_Name = {
    Text = "Tempesta Divoratrice di Cetus"
  },
  State_147058_Name = {
    Text = "Accessorio: Anello della Stanza 36"
  },
  State_147079_Desc = {
    Text = "Questa carta non può essere scartata o trasformata."
  },
  State_147079_Name = {
    Text = "<RetainIconKeywordsColour:Conservare Forzato>"
  },
  State_147545_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Non configurata"
  },
  State_147545_Name = {
    Text = "Tinct: Vespera SR (Testo Temporaneo)"
  },
  State_147546_Name = {Text = "Obsoleto"},
  State_147546_WeaponDesc = {
    Text = "Voci dall'Oltre"
  },
  State_147584_Desc = {
    Text = "L'effetto <Blessing:Benedizione> della prossima <DerivativeCardKeywords_152:\"Dono della Fata\"> giocata aumenta del 50%"
  },
  State_147737_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: All'equipaggiamento, ottieni [StateArg1] <MaxHPKeywords:Salute massima>. All'inizio del turno, infliggi <Damage:[Damage:StateArg2]> danni da <PVPBleedingKeywords:Sanguinamento> a tutti i nemici,"
  },
  State_147737_Name = {
    Text = "Più oscuro dell'oscurità"
  },
  State_147764_Name = {
    Text = "Stato@Conteggio scelta errata evento Caraboo"
  },
  State_147765_Desc = {
    Text = "All'inizio del prossimo turno perdi 2 punti Arithmetica e peschi 2 carte in meno."
  },
  State_147765_Name = {
    Text = "Pistoles de Marie"
  },
  State_147768_Desc = {
    Text = "All'inizio del prossimo turno ottieni [DescArg1] Av. Intuizione."
  },
  State_147768_Name = {
    Text = "Monete d'oro Pistoles de Marie"
  },
  State_147769_Desc = {
    Text = "In questa battaglia, \"Banchetto\" ha attualmente accumulato [Layer] strati."
  },
  State_147769_Name = {
    Text = "Limite di Accumulo"
  },
  State_147772_Name = {
    Text = "Stato@Evento Caraboo aggiunge limite Keyflare temporaneo"
  },
  State_147773_Name = {
    Text = "Stato@Evento Caraboo aggiunge limite Keyflare temporaneo"
  },
  State_147774_Name = {
    Text = "Stato@Evento Caraboo aggiunge limite Keyflare temporaneo_Caos normale"
  },
  State_147797_Desc = {
    Text = "Possibilità di ottenere o perdere Aliemus, <PowerIconKeywords:forza>, PV, Energia-S, Arithmetica e Pesca."
  },
  State_147797_Name = {
    Text = "Pistoles de Marie"
  },
  State_147800_Desc = {
    Text = "All'inizio del prossimo turno perdi 2 punti Arithmetica e peschi 2 carte in meno."
  },
  State_147800_Name = {
    Text = "Pistoles de Marie"
  },
  State_147869_Name = {
    Text = "Pesca [Layer] carte"
  },
  State_147870_Name = {
    Text = "Infliggi [Layer] turni di Debolezza a tutti i nemici"
  },
  State_147871_Name = {
    Text = "Ottieni [Energy:DescArg1] Aliemus"
  },
  State_147872_Name = {
    Text = "Infliggi [Layer] turni di Vulnerabile a tutti i nemici"
  },
  State_147873_Name = {
    Text = "Ottieni [Layer] Arithmetica"
  },
  State_147874_Name = {
    Text = "Ottieni [Block:DescArg1] Scudo"
  },
  State_147962_Desc = {
    Text = "Quando il giocatore gioca \"<DerivativeCardKeywords_158:Espiazione>\", disperde solo il 50% degli accumuli di <MonsterSinMarkKeywords:Marchio del Peccato> e, per ogni Carta di comando giocata, \"Divus: La Notte Bianca\" guadagna 1 accumulo di <MonsterSinMarkKeywords:Marchio del Peccato>."
  },
  State_147962_Name = {
    Text = "Sentiero della Purificazione"
  },
  State_147967_Desc = {
    Text = "I danni inflitti da \"Divus: La Notte Bianca\" applicano [DescArg1]% di <BleedingIconKeywords:Sanguinamento>."
  },
  State_147967_Name = {
    Text = "Marchio del Peccato"
  },
  State_147968_Desc = {
    Text = "Limite di 3 strati. Quando si passa all'intenzione di attacco, il Potenziamento DAN di \"Divus: La Notte Bianca\" aumenta del 25% e consuma 1 strato."
  },
  State_147968_Name = {
    Text = "Espiazione nel Dolore"
  },
  State_147969_Desc = {
    Text = "Quando \"Divus: La Notte Bianca\" si trova nell'intenzione \"Sacro Cuore\", ogni volta che viene giocata 1 Carta di comando accumula 2 strati di <MonsterPolluxFever:Fervore>."
  },
  State_147969_Name = {
    Text = "Rivelazione Divina"
  },
  State_147971_Desc = {
    Text = "Questo Risvegliatore non si è ancora Risvegliato... Quando sta per essere sconfitto, la Vita verrà ripristinata e otterrà 1 accumulo di <InvincibleUntilRoused:Corazza Impenetrabile>. Dopo il Risveglio, <InvincibleUntilRoused:Corazza Impenetrabile> viene rimossa e inizia la battaglia nella sua vera forma."
  },
  State_147971_Name = {
    Text = "Non Risvegliato"
  },
  State_147972_Desc = {
    Text = "Ogni strato fa sì che i danni inflitti da \"Divus: La Notte Bianca\" applichino 1% di <BleedingIconKeywords:Sanguinamento>."
  },
  State_147972_Name = {
    Text = "<MonsterSinMarkKeywords:Marchio del Peccato>"
  },
  State_147974_Desc = {
    Text = "Rimosso all'inizio del turno. Dopo aver raggiunto 10 strati, alla prossima giocata di una carta agisce immediatamente, rimuove il Fervore e cambia l'intenzione in \"Sacro Cuore\"."
  },
  State_147974_Name = {
    Text = "Fervore Temporaneo"
  },
  State_147975_Desc = {
    Text = "All'inizio del combattimento, inserisce una carta \"<DerivativeCardKeywords_158:Espiazione>\" nella Mano. Al termine del turno, ottiene 5 strati di <MonsterSinMarkKeywords:Marchio del Peccato>."
  },
  State_147975_Name = {
    Text = "Araldo del Portatore di Luce"
  },
  State_147993_Desc = {
    Text = "Limite di 3 strati. Quando si passa all'intenzione di attacco, il Potenziamento DAN di \"Divus: La Notte Bianca\" aumenta del 25% e consuma 1 strato."
  },
  State_147993_Name = {
    Text = "Espiazione nel Dolore"
  },
  State_148020_Desc = {
    Text = "Immune a tutti i danni e non può perdere Vita; rimossa dopo il Risveglio."
  },
  State_148020_Name = {
    Text = "Solidificazione del Nucleo d'Argento"
  },
  State_148021_Name = {
    Text = "Stato@Identificatore rimozione Immune Rinascita mostro generico pre-Risveglio"
  },
  State_148073_Name = {
    Text = "Pesca 1 carta."
  },
  State_148074_Desc = {
    Text = "La carta non entra nella Pila degli scarti, ma rimane In Mano."
  },
  State_148074_Name = {
    Text = "<RetainIconKeywords:Conservare>"
  },
  State_148074_WeaponDesc = {
    Text = "La carta non entra nella Pila degli scarti, ma rimane In Mano."
  },
  State_148076_Name = {
    Text = "Ascolto giocata carte Sentiero dell'Abluzione"
  },
  State_148116_Desc = {
    Text = "Dopo 1 turno, pesca [StateArg1] carte [Layer] volte."
  },
  State_148116_Name = {
    Text = "Pescata Ritardata1"
  },
  State_148381_Desc = {
    Text = "Fino alla fine del turno, i danni inflitti aggiungono il 100% di <BleedingIconKeywords:Sanguinamento>."
  },
  State_148381_Name = {
    Text = "Rancore in Catene"
  },
  State_148383_Desc = {
    Text = "Massimo 3 accumuli. Se si possiedono 3 accumuli di \"Massacro Infinito\", la prossima volta che l'Intenzione passa a \"Catene Cremisi\", cambia invece l'Intenzione in \"Flagello Assetato di Sangue\" e azzera \"Massacro Infinito\"."
  },
  State_148383_Name = {
    Text = "\"Risentimento\""
  },
  State_148385_Desc = {
    Text = "Ogni volta che il nemico gioca una Carta di comando, ottieni 2 strati di <MonsterB05EXFever:Fervore Temporaneo>."
  },
  State_148385_Name = {
    Text = "Forma irregolare"
  },
  State_148386_Desc = {
    Text = "Impossibile ottenere Scudo fino alla fine del turno."
  },
  State_148386_Name = {
    Text = "Catene Sanguigne"
  },
  State_148387_Desc = {
    Text = "Questo Risvegliatore non si è ancora Risvegliato... Quando sta per essere sconfitto, la Vita verrà ripristinata e otterrà 1 accumulo di <InvincibleUntilRoused:Corazza Impenetrabile>. Dopo il Risveglio, <InvincibleUntilRoused:Corazza Impenetrabile> viene rimossa e inizia la battaglia nella sua vera forma."
  },
  State_148387_Name = {
    Text = "Non Risvegliato"
  },
  State_148391_Desc = {
    Text = "Fino alla fine del turno, i danni inflitti aggiungono il 100% di <BleedingIconKeywords:Sanguinamento>."
  },
  State_148391_Name = {
    Text = "Catene Sanguigne"
  },
  State_148392_Desc = {
    Text = "Rimosso all'inizio del turno. Dopo aver raggiunto 10 strati, alla prossima giocata di una carta agisce immediatamente, rimuove il Fervore e cambia l'intenzione in \"Catene Cremisi\"."
  },
  State_148392_Name = {
    Text = "Fervore Temporaneo"
  },
  State_148394_Desc = {
    Text = "All'inizio del turno, ottieni 1 accumulo di <ResentChainsKeywords:Catene del Risentimento>. Quando l'intenzione passa a \"Flagello Assetato di Sangue\", diventa immune a tutti i danni e agli effetti di perdita di Vita fino alla fine del turno nemico."
  },
  State_148394_Name = {
    Text = "Dichiarazione della Mietitrice"
  },
  State_148395_Desc = {
    Text = "Immune a tutti i danni (inclusi i Danni Perforanti) e impossibile perdere Vita; rimosso alla fine del turno nemico."
  },
  State_148395_Name = {
    Text = "Dichiarazione della Mietitrice - Flagello Assetato di Sangue"
  },
  State_148421_Desc = {
    Text = "Dopo 1 turno, riduce temporaneamente [StateArg1] punti di <ExhaustionIconKeywords:Forza> a tutti i nemici [Layer] volte"
  },
  State_148421_Name = {
    Text = "Ritardo Prosciugamento 1"
  },
  State_148422_Desc = {
    Text = "Dopo 1 turno, Amplificazione del Danno temporanea [StateArg1]% [Layer] volte."
  },
  State_148422_Name = {
    Text = "Amplificazione del Danno Temporanea Ritardata1"
  },
  State_148423_Desc = {
    Text = "Dopo 1 turno ottieni <Posse:[StateArg1]> punti di Energia-S [Layer] volte."
  },
  State_148423_Name = {
    Text = "Ritardo Energia-S 1"
  },
  State_148426_Desc = {
    Text = "Dopo 1 turno ottieni [StateArg1] punti di Arithmetica [Layer] volte."
  },
  State_148426_Name = {
    Text = "Ritardo Arithmetica 1"
  },
  State_148427_Desc = {
    Text = "Dopo 1 turno, tutti i Risvegliatori ottengono [StateArg1] punti di Aliemus [Layer] volte."
  },
  State_148427_Name = {
    Text = "Aliemus Ritardato1"
  },
  State_148428_Desc = {
    Text = "Dopo 1 turno ottieni [StateArg1] punti di <PowerIconKeywords:Forza> [Layer] volte."
  },
  State_148428_Name = {
    Text = "Ritardo Forza 1"
  },
  State_148511_Desc = {
    Text = "Unicità di Squadra: Dopo l'inizio dell'esplorazione, aggiunge 1 carta <Backupbody[StateArg3]:\"Sincronizzazione dell'Anima\"> al mazzo. \"Sincronizzazione dell'Anima\": Costo di Arithmetica 0, dopo averla giocata ottieni 1 punto di Arithmetica. <RetainIconKeywords:Conservare>: Accumula in questa carta una quantità fissa di Guarigione pari al <WeaponEffect_Num:[StateArg1]%> del COS del portatore e <WeaponEffect_Num:[StateArg2]> punti fissi di Aliemus. Se questa carta non viene Distrutta, puoi essere Immune alla morte una volta e rilasciare tutta la Guarigione e l'Aliemus accumulati, dopodiché <DestructionKeywords:Distruggere> questa carta."
  },
  State_148511_Name = {
    Text = "Sincronizzazione dell'Anima"
  },
  State_148511_WeaponDesc = {
    Text = "Dopo l'inizio dell'esplorazione, aggiunge 1 carta <Backupbody[StateArg3]:\"Sincronizzazione dell'Anima\"> al mazzo. \"Sincronizzazione dell'Anima\": Costo di Arithmetica 0, dopo averla giocata ottieni 1 punto di Arithmetica. <RetainIconKeywords:Conservare>: Accumula in questa carta una quantità fissa di Guarigione pari al <WeaponEffect_Num:[StateArg1]%> del COS del portatore e <WeaponEffect_Num:[StateArg2]> punti fissi di Aliemus. Se questa carta non viene Distrutta, puoi essere Immune alla morte una volta e rilasciare tutta la Guarigione e l'Aliemus accumulati, dopodiché <DestructionKeywords:Distruggere> questa carta."
  },
  State_148513_Desc = {
    Text = "L'avversario non scarterà le carte dalla mano a fine turno. Alla fine del turno, infligge in ordine 2 accumuli di stato <FragileIconKeywords:Fragile>, <WeaknessIconKeywords:Debolezza>, <HeavyInjuryKeywords:Flagello> e <VulnerabilityIconKeywords:Vulnerabile>."
  },
  State_148513_Name = {
    Text = "Voci dall'Oltre"
  },
  State_148520_Desc = {
    Text = "Impossibile ottenere Scudo fino alla fine del turno."
  },
  State_148520_Name = {
    Text = "Rancore in Catene"
  },
  State_148522_Desc = {
    Text = "Unicità di Squadra: Lo Scudo e la forza causati dall'\"Esaltazione\" del portatore aumentano del <WeaponEffect_Num:[StateArg1]%>."
  },
  State_148524_Desc = {
    Text = "Unicità di Squadra: Lo Scudo e la forza causati dall'\"Esaltazione\" del portatore aumentano del <WeaponEffect_Num:[StateArg1]%>. Il Potenziamento Scudo causato dalla \"Difesa\" del portatore aumenta del <WeaponEffect_Num:[StateArg2]%>. Dopo che il portatore gioca \"Difesa\", ottiene forza pari al <WeaponEffect_Num:[StateArg3]%> dell'ATT del portatore."
  },
  State_148540_Desc = {
    Text = "Ritardo[Layer]: Il Costo di Arithmetica delle [StateArg1] Carte di comando con Arithmetica più alta di <AwakerName:[DescArg1]> si riduce di [StateArg2]."
  },
  State_148540_Name = {
    Text = "Specchio della Preveggenza - Ritardo[Layer]"
  },
  State_148541_Name = {
    Text = "Rimuovi l'effetto \"Stagnazione\" dalla carta del Risvegliatore selezionato in mano"
  },
  State_148544_Desc = {
    Text = "Ritardo[Layer] : La prossima Esaltazione di <AwakerName:[DescArg1]> ottiene [StateArg1] punti di Energia-S per ogni punto di Aliemus consumato."
  },
  State_148544_Name = {
    Text = "Chiave di Goetia - Ritardo[Layer]"
  },
  State_148547_Desc = {
    Text = "La prossima Esaltazione di <AwakerName:[DescArg1]> viene considerata come Sovraesaltazione; se è già una Sovraesaltazione, restituisce il 100% dell'Aliemus Base."
  },
  State_148547_Name = {
    Text = "Corona dell'Eternità"
  },
  State_148548_Desc = {
    Text = "Conservare: Tutti i Risvegliatori guadagnano 5 Aliemus."
  },
  State_148548_Name = {
    Text = "Assorto nella Riflessione"
  },
  State_148549_Name = {
    Text = "Attiva tutti gli effetti \"Preparazione\" presenti in mano"
  },
  State_148553_Desc = {
    Text = "Ritardo[Layer]: Le prossime [Layer] Carte di comando giocate da <AwakerName:[DescArg1]> ottengono uno Scudo pari al [StateArg2]% della Vita persa."
  },
  State_148553_Name = {
    Text = "Frutto della Tentazione - Ritardo[Layer]"
  },
  State_148554_Desc = {
    Text = "I danni inflitti dalle Carte di comando di <AwakerName:[DescArg1]> applicano [Layer]% di Sanguinamento."
  },
  State_148554_Name = {
    Text = "Occhio della Rovina"
  },
  State_148556_Desc = {
    Text = "Mentre è in mano, tutti i Risvegliatori infliggono un 10% aggiuntivo di Sanguinamento quando infliggono Danno attivo."
  },
  State_148556_Name = {
    Text = "Un Incubo Preannunciato"
  },
  State_148557_Desc = {
    Text = "Le prossime [Layer] Carte di comando giocate da <AwakerName:[DescArg1]> ottengono uno Scudo pari al [StateArg1]% della Vita persa."
  },
  State_148557_Name = {
    Text = "Frutto della Tentazione"
  },
  State_148559_Desc = {
    Text = "La prossima Esaltazione di <AwakerName:[DescArg1]> ottiene [Layer] punti di Energia-S per ogni punto di Aliemus consumato."
  },
  State_148559_Name = {
    Text = "Chiave di Goetia"
  },
  State_148561_Desc = {
    Text = "Quando questa Carta viene giocata, si attiva casualmente uno dei seguenti tre effetti negativi: Effetto ridotto del 50%/Ritardo di 2 turni prima dell'attivazione/Ottieni casualmente 1 effetto negativo."
  },
  State_148561_Name = {
    Text = "<ExclamationPointColour:Desiderio Distorto>"
  },
  State_148562_Name = {
    Text = "Il Risvegliatore scelto ottiene 10 punti di Aliemus"
  },
  State_148563_Desc = {
    Text = "Ritardo[Layer]: Lo Scudo e la Guarigione ottenuti dalla prossima Esaltazione di <AwakerName:[DescArg1]> aumentano del [StateArg1]%."
  },
  State_148563_Name = {
    Text = "Piuma della Giustizia - Ritardo[Layer]"
  },
  State_148566_Desc = {
    Text = "I danni inflitti dalla prossima Esaltazione di <AwakerName:[DescArg1]> applicano [Layer]% di Verdetto Finale."
  },
  State_148566_Name = {
    Text = "Filo del Destino"
  },
  State_148569_Desc = {
    Text = "Lo Scudo e la Guarigione ottenuti dalla prossima Esaltazione di <AwakerName:[DescArg1]> aumentano del [Layer]%."
  },
  State_148569_Name = {
    Text = "Piuma della Giustizia"
  },
  State_148571_Desc = {
    Text = "Ritardo[Layer] : I danni inflitti dalle Carte di comando di <AwakerName:[DescArg1]> applicano [StateArg1]% di Sanguinamento."
  },
  State_148571_Name = {
    Text = "Occhio della Rovina - Ritardo[Layer]"
  },
  State_148574_Desc = {
    Text = "Ritardo[Layer] : I danni inflitti dalla prossima Esaltazione di <AwakerName:[DescArg1]> applicano [StateArg1]% di Verdetto Finale."
  },
  State_148574_Name = {
    Text = "Filo del Destino - Ritardo[Layer]"
  },
  State_148575_Name = {
    Text = "Il Risvegliatore scelto ottiene 20 punti di Aliemus"
  },
  State_149089_Name = {
    Text = "Stato@Identificatore Aliemus Piccola Ingestione Segugio della Lanterna"
  },
  State_149092_Desc = {
    Text = "Ha ingerito <Energy:[Energy:DescArg2]> punti di Aliemus di \"<AwakerName:[DescArg1]>\"; restituiti alla morte."
  },
  State_149092_Name = {Text = "Divorare"},
  State_149094_Desc = {
    Text = "Unicità di Squadra: Lo Scudo Base generato dall'Esaltazione del portatore +<WeaponEffect_Num:[StateArg1]%>. Dopo che il portatore gioca una Carta di comando che infligge <WeaknessIconKeywords:Sintomo: Debolezza>, lo Scudo Base generato dalla prossima Carta di comando dell'equipaggiamento +<WeaponEffect_Num:[StateArg1]%>. Non si accumula. Quando si usa \"Fornace Cremisi\", pesca la carta abilità del portatore con il Costo di Arithmetica più alto, Fusione Embrionale <EmbryoFusionIconKeywords:>+<WeaponEffect_Num:[StateArg1]%>, cooldown di 3 turni."
  },
  State_149094_WeaponDesc = {
    Text = "Lo Scudo Base dell'Esaltazione del portatore +<WeaponEffect_Num:[StateArg1]%>. Dopo che il portatore gioca una Carta di comando che infligge <WeaknessIconKeywords:Sintomo: Debolezza>, lo Scudo Base della sua Carta di comando +<WeaponEffect_Num:[StateArg1]%>. Quando si usa \"Fornace Cremisi\", pesca la Carta Abilità del portatore con il Costo di Arithmetica più alto, <EmbryoFusionIconKeywords:Fusione Embrionale> +<WeaponEffect_Num: [StateArg1]>, cooldown di 3 turni."
  },
  State_149122_Desc = {
    Text = "Alla morte, evoca immediatamente 1 \"Segugio della Lanterna\" casuale con il suo \"Effetto Grappolo\" ridotto di 1 accumulo."
  },
  State_149122_Name = {
    Text = "Effetto Cluster"
  },
  State_149123_Desc = {
    Text = "I danni ricevuti dall'Esaltazione sono ridotti del 50%."
  },
  State_149123_Name = {
    Text = "Mod Lanterna Umbrale"
  },
  State_149124_Desc = {
    Text = "I danni ricevuti dalle Carte di comando sono ridotti del 50%."
  },
  State_149124_Name = {
    Text = "Mod Lanterna Glaciale"
  },
  State_149125_Desc = {
    Text = "Ha congelato la Carta di comando di \"<AwakerName:[DescArg1]>\"; alla morte, il Congelamento di quel Risvegliatore viene rimosso."
  },
  State_149125_Name = {Text = "Divorare"},
  State_149126_Desc = {
    Text = "Alla morte, evoca immediatamente 1 \"Segugio della Lanterna\" casuale con il suo \"Effetto Grappolo\" ridotto di 1 accumulo."
  },
  State_149126_Name = {
    Text = "Effetto Cluster"
  },
  State_149128_Name = {
    Text = "Stato@Identificatore Carta Congelamento Piccolo Segugio della Lanterna Glaciale"
  },
  State_149140_Desc = {
    Text = "Amplifica le abilità del nemico. Il nemico perde 1 carica quando subisce DAN."
  },
  State_149140_Name = {
    Text = "Giuramento di Sangue"
  },
  State_149143_Desc = {
    Text = "Dopo la fase di Pesca, per ogni [DescArg1] Carta di comando con <SlowIconKeywords:Stagnazione> in mano al nemico, ottieni [DescArg2] accumuli di <BloodOath_New:Giuramento di Sangue>. Dopo aver inflitto danni non bloccati, applica [DescArg4] accumuli di <SlowIconKeywords:Stagnazione> a [DescArg3] Carte di comando nella Mano o nel Mazzo di Pesca prive di <SlowIconKeywords:Stagnazione>, scelte casualmente."
  },
  State_149143_Name = {
    Text = "Voto Glaciale"
  },
  State_149162_Desc = {
    Text = "Quando infligge danno non bloccato, rimuove la Resistenza."
  },
  State_149162_Name = {
    Text = "Magia dell'Estremo Oriente"
  },
  State_149163_Desc = {
    Text = "La Salute massima viene ridotta di un numero pari agli accumuli; dimezzata al termine del combattimento."
  },
  State_149163_Name = {
    Text = "<BoneHitKeywords:Flagello>"
  },
  State_149164_Desc = {
    Text = "Infliggendo danno applica Flagello."
  },
  State_149164_Name = {
    Text = "Gelo Perforante"
  },
  State_149167_Desc = {
    Text = "Salute massima ridotta di [Layer], dimezzata al termine del combattimento."
  },
  State_149167_Name = {
    Text = "<BoneHitKeywords:Flagello>"
  },
  State_149169_Desc = {
    Text = "Ogni accumulo aumenta la Salute massima del 10% del COS di Caraboo (max 50 accumuli). Al massimo degli accumuli, gli accumuli in eccesso curano invece per 3× questo valore di Vita. Si possono ottenere fino a 10 accumuli di \"Sazietà\" per battaglia non Boss. La \"Sazietà\" persiste tra le battaglie."
  },
  State_149169_Name = {
    Text = "<WormGrowth:Banchetto>"
  },
  State_149172_Desc = {
    Text = "Unicità di Squadra: Dopo che il portatore gioca una Carta di comando che infligge <WeaknessIconKeywords:Sintomo: Debolezza>, lo Scudo Base generato dalla prossima Carta di comando dell'equipaggiamento +<WeaponEffect_Num:[StateArg1]%>. Non si accumula."
  },
  State_149172_WeaponDesc = {
    Text = "Dopo che il portatore gioca una Carta di comando che infligge <WeaknessIconKeywords:Sintomo: Debolezza>, lo Scudo Base della sua prossima Carta di comando +<WeaponEffect_Num:[StateArg1]%>."
  },
  State_149187_Desc = {
    Text = "Test | Monitora dopo aver subito Danno Fisso, dopo che il Danno Fisso causa un'Uccisione, e stampa il valore di attivazione e l'associato."
  },
  State_149187_Name = {
    Text = "Test Danno Fisso"
  },
  State_149188_Desc = {
    Text = "Test｜Dopo aver ucciso con Danno Fisso, valore di attivazione 1, danno effettivo dell'uccisione:[Layer]"
  },
  State_149188_Name = {
    Text = "Test Valore Attivazione Uccisione Danno Fisso 2"
  },
  State_149189_Desc = {
    Text = "Test | Dopo che il Danno Fisso causa un'Uccisione, Associato 2, fonte dell'Uccisione: [Layer]"
  },
  State_149189_Name = {
    Text = "Test Associato Uccisione Danno Fisso 2"
  },
  State_149190_Desc = {
    Text = "Test｜Dopo aver ucciso con Danno Fisso, valore di attivazione 1, danno in eccesso dell'uccisione:[Layer]"
  },
  State_149190_Name = {
    Text = "Test attivazione uccisione fissa valore 3"
  },
  State_149191_Desc = {
    Text = "Test | Dopo aver subito Danno Fisso, Valore di Attivazione 1, danno totale: [Layer]"
  },
  State_149191_Name = {
    Text = "Test Valore Attivazione Danno Fisso 1"
  },
  State_149192_Desc = {
    Text = "Test | Dopo che il Danno Fisso causa un'Uccisione, Associato 1, bersaglio ucciso: [Layer]"
  },
  State_149192_Name = {
    Text = "Test Associato Uccisione Danno Fisso 1"
  },
  State_149193_Desc = {
    Text = "Test | Dopo aver subito Danno Fisso, Associato 2, bersaglio colpito: [Layer]"
  },
  State_149193_Name = {
    Text = "Test Associato Danno Fisso 2"
  },
  State_149194_Desc = {
    Text = "Test | Dopo aver subito Danno Fisso, Valore di Attivazione 1, danno totale: [Layer]"
  },
  State_149194_Name = {
    Text = "Test Valore Attivazione Danno Fisso 2"
  },
  State_149195_Desc = {
    Text = "Test | Dopo che il Danno Fisso causa un'Uccisione, Valore di Attivazione 1, danno totale dell'Uccisione: [Layer]"
  },
  State_149195_Name = {
    Text = "Test Valore Attivazione Uccisione Danno Fisso 1"
  },
  State_149196_Desc = {
    Text = "Test | Dopo aver subito Danno Fisso, Associato 1, fonte del danno: [Layer]"
  },
  State_149196_Name = {
    Text = "Test Associato Danno Fisso 1"
  },
  State_149227_Desc = {
    Text = "Lo Scudo non svanisce al termine del turno. Quando possiede uno Scudo, il Potenziamento DAN Esaltato subito aumenta del 50% e il danno subito dalle Carte di comando si riduce del 50%."
  },
  State_149227_Name = {
    Text = "Manto Glaciale"
  },
  State_149228_Desc = {
    Text = "Infliggendo danno applica Sanguinamento."
  },
  State_149228_Name = {
    Text = "Trafittura Sanguigna"
  },
  State_149229_Desc = {
    Text = "All'entrata in campo perde il 25% della Salute massima, convertita in uno \"Scudo di Gelo\" pari al [DescArg1]% del valore perso."
  },
  State_149229_Name = {
    Text = "Conversione Scudo di Gelo"
  },
  State_149230_Desc = {
    Text = "Il danno subito dalle Carte di comando aumenta del 50%, il Potenziamento DAN Esaltato subito si riduce del 50%."
  },
  State_149230_Name = {
    Text = "Stato@Aumento/Riduzione DAN Manto Umbrale"
  },
  State_149232_Desc = {
    Text = "Lo Scudo non svanisce al termine del turno. Quando possiede uno Scudo, il danno subito dalle Carte di comando aumenta del 50% e il Potenziamento DAN Esaltato subito si riduce del 50%."
  },
  State_149232_Name = {
    Text = "Manto Umbrale"
  },
  State_149233_Desc = {
    Text = "Il Potenziamento DAN Esaltato subito aumenta del 50%, il danno subito dalle Carte di comando si riduce del 50%."
  },
  State_149233_Name = {
    Text = "Stato@Aumento/Riduzione DAN Manto Glaciale"
  },
  State_149234_Desc = {
    Text = "All'entrata in campo perde il 25% della Salute massima, convertita in una \"Protezione Maledetta\" pari al [DescArg1]% del valore perso."
  },
  State_149234_Name = {
    Text = "Conversione Protezione Maledetta"
  },
  State_149235_Desc = {
    Text = "Quando infligge danno non bloccato, rimuove la Resistenza."
  },
  State_149235_Name = {
    Text = "Stregoneria della Lanterna"
  },
  State_149250_Desc = {
    Text = "Danni da Carte di comando subiti +50%"
  },
  State_149250_Name = {
    Text = "Danni da Carte di comando subiti +50%"
  },
  State_149251_Desc = {
    Text = "Danni da Carte di comando subiti -50%"
  },
  State_149251_Name = {
    Text = "Danni da Carte di comando subiti -50%"
  },
  State_149252_Desc = {
    Text = "Danni da Esaltazione subiti -50%"
  },
  State_149252_Name = {
    Text = "Danni da Esaltazione subiti -50%"
  },
  State_149253_Desc = {
    Text = "Danni da Esaltazione subiti +50%"
  },
  State_149253_Name = {
    Text = "Danni da Esaltazione subiti +50%"
  },
  State_149265_Desc = {
    Text = "Dopo la morte, evoca immediatamente un \"Wendigo\" casuale, riducendo il suo \"Effetto Grappolo\" di 1 strato."
  },
  State_149265_Name = {
    Text = "Effetto Cluster"
  },
  State_149268_Desc = {
    Text = "Quando si perdono tutti gli Scudi, si ottengono 75 strati di Rinforzato Temporaneo e si rimuove 1 strato di \"Sudario di Bufera\", sostituendo l'intenzione con un attacco potente che infligge <BoneHitKeywords:Flagello>."
  },
  State_149268_Name = {
    Text = "Sudario di Bufera"
  },
  State_149269_Desc = {
    Text = "Quando si perdono tutti gli Scudi, si ottengono 75 strati di Rinforzato Temporaneo e si rimuove 1 strato di \"Sudario d'Ombra\", sostituendo l'intenzione con un attacco potente che sottrae Aliemus."
  },
  State_149269_Name = {
    Text = "Sudario d'Ombra"
  },
  State_149270_Desc = {
    Text = "Dopo la morte, evoca immediatamente un \"Wendigo\" casuale, riducendo il suo \"Effetto Grappolo\" di 1 strato."
  },
  State_149270_Name = {
    Text = "Effetto Cluster"
  },
  State_149308_Name = {
    Text = "Stato@Registro Accumuli Stagnazione Orante della Lanterna"
  },
  State_149391_Desc = {
    Text = "Questo Risvegliatore non si è ancora Risvegliato... Quando sta per essere sconfitto, la Vita verrà ripristinata e otterrà 1 accumulo di <InvincibleUntilRoused:Corazza Impenetrabile>. Dopo il Risveglio, <InvincibleUntilRoused:Corazza Impenetrabile> viene rimossa e inizia la battaglia nella sua vera forma."
  },
  State_149391_Name = {
    Text = "Non Risvegliato"
  },
  State_149398_Desc = {
    Text = "Quando l'intenzione di \"Biancaneve la Fata\" passa a \"Maleficio Nevoso\", consuma 1 strato e trasforma l'intenzione in \"Benedizione Miracolosa\"."
  },
  State_149398_Name = {Text = "Banchetto"},
  State_149399_Desc = {
    Text = "Dopo che \"Biancaneve la Fata\" usa \"Fiaba Perfetta\", le successive [DescArg1] intenzioni diventano tutte \"Maleficio Nevoso\". Ogni turno, mescola [DescArg2] carte <SlowIconKeywords:Stagnazione> casuali con [DescArg3] strati di <Blessing:Benedizione> nel mazzo."
  },
  State_149399_Name = {
    Text = "Frutto del Miele Tentatore"
  },
  State_149418_Desc = {
    Text = "non può essere un Colpo Critico, non è considerato DAN base e non è influenzato da bonus come il Danno Finale."
  },
  State_149418_Name = {
    Text = "<RealDamage:Danno Fisso>"
  },
  State_149419_Name = {
    Text = "<Rune_6:Bastione>"
  },
  State_149420_Name = {
    Text = "<Rune_3:Finezza>"
  },
  State_149421_Name = {
    Text = "<Rune_15:Detonazione>"
  },
  State_149422_Name = {
    Text = "<Rune_4:Calcolo>"
  },
  State_149423_Name = {
    Text = "<Rune_11:Dominio>"
  },
  State_149424_Name = {
    Text = "<Rune_12:Sete di Sangue>"
  },
  State_149425_Name = {
    Text = "<Rune_1:Vulnerabile>"
  },
  State_149426_Name = {
    Text = "<Rune_14:Potenza>"
  },
  State_149427_Name = {
    Text = "<Rune_2:Debolezza>"
  },
  State_149428_Name = {
    Text = "<Rune_9:Spina>"
  },
  State_149429_Name = {
    Text = "<Rune_10:Tossina>"
  },
  State_149430_Name = {
    Text = "<Rune_18:Risucchio>"
  },
  State_149576_Desc = {
    Text = "Quando l'intenzione di \"Biancaneve la Fata\" passa a \"Maleficio Nevoso\", consuma 1 strato e trasforma l'intenzione in \"Benedizione Miracolosa\"."
  },
  State_149576_Name = {Text = "Banchetto"},
  State_149618_Desc = {
    Text = [[
Dopo 2 turni, attiva i seguenti Effetti:
Ottieni [DescArg1] punti di Arithmetica. 
Ottieni [DescArg2] punti di Forza. 
Ottieni [DescArg3] punti di Energia-S. 
Ottieni [DescArg5] punti di Aliemus. 
Pesca [DescArg6] carte.
Ottieni [DescArg7] punti di Amplificazione del Danno temporanea.
Riduce temporaneamente [DescArg4] punti di Forza a tutti i nemici.]]
  },
  State_149618_Name = {
    Text = "Occasione Mancata2"
  },
  State_149619_Desc = {
    Text = [[
Dopo 1 turno, attiva i seguenti Effetti:
Ottieni [DescArg1] punti di Arithmetica. 
Ottieni [DescArg2] punti di Forza. 
Ottieni [DescArg3] punti di Energia-S. 
Ottieni [DescArg5] punti di Aliemus. 
Pesca [DescArg6] carte.
Ottieni [DescArg7] punti di Amplificazione del Danno temporanea.
Riduce temporaneamente [DescArg4] punti di Forza a tutti i nemici.]]
  },
  State_149619_Name = {
    Text = "Occasione Mancata1"
  },
  State_149628_Desc = {
    Text = "Se prima della fine del turno il nemico possiede almeno 1000 punti di Energia-S, Divorare 1000 Energia-S."
  },
  State_149628_Name = {
    Text = "Sacrificio di Keyflare"
  },
  State_149629_Desc = {
    Text = "Se prima della fine del turno il Risvegliatore con Aliemus più alto possiede almeno 100 punti di Aliemus, Divorare 50 punti di Aliemus."
  },
  State_149629_Name = {
    Text = "Sacrificio Aliemus"
  },
  State_149630_Desc = {
    Text = "Se prima della fine del turno il nemico possiede almeno 1000 punti di Energia-S, Divorare 1000 Energia-S."
  },
  State_149630_Name = {
    Text = "Sacrificio di Keyflare"
  },
  State_149631_Desc = {
    Text = "Se prima della fine del turno il nemico possiede almeno 3 punti di Arithmetica, Divora 3 punti di Arithmetica."
  },
  State_149631_Name = {
    Text = "Sacrificio di Arithmetica"
  },
  State_149632_Desc = {
    Text = "Se prima della fine del turno il nemico possiede almeno 3 punti di Arithmetica, Divora 3 punti di Arithmetica."
  },
  State_149632_Name = {
    Text = "Sacrificio di Arithmetica"
  },
  State_149633_Desc = {
    Text = "Se prima della fase di scarto il nemico ha almeno 4 Carte di comando rimanenti in Mano, Divorare 2 Carte di comando casuali."
  },
  State_149633_Name = {
    Text = "Sacrificio Carta"
  },
  State_149634_Desc = {
    Text = "Se prima della fase di scarto il nemico ha almeno 4 Carte di comando rimanenti in Mano, Divorare 2 Carte di comando casuali."
  },
  State_149634_Name = {
    Text = "Sacrificio Carta"
  },
  State_149635_Desc = {
    Text = "Se prima della fine del turno il Risvegliatore con Aliemus più alto possiede almeno 100 punti di Aliemus, Divorare 50 punti di Aliemus."
  },
  State_149635_Name = {
    Text = "Sacrificio Aliemus"
  },
  State_149652_Desc = {
    Text = "Impossibile effettuare Colpi Critici, non considerato come danno inflitto dal Risvegliatore corrispondente."
  },
  State_149652_Name = {
    Text = "<FixedDamage:DAN Puro>"
  },
  State_149660_Desc = {
    Text = "I danni, lo Scudo e le variazioni di forza causati da questa Carta aumentano del [DescArg2]%, l'Effetto finale dei Danni da tentacolo, della Guarigione, del Veleno fisso e del Contrattacco fisso aumenta del [DescArg1]%; rimossa dopo essere stata giocata."
  },
  State_149660_Name = {
    Text = "Potenziare [DescArg1]"
  },
  State_149664_Desc = {
    Text = "Per ogni livello, i danni causati da questa Carta, il Potenziamento DAN fisso e Danni da tentacolo, il Veleno fisso e l'Effetto finale del Contrattacco fisso aumentano del 2%; l'Effetto finale dello Scudo fisso, della Guarigione fissa e della Riduzione del potere aumenta dell'1%; rimossa dopo essere stata giocata."
  },
  State_149664_Name = {Text = "Potenzia"},
  State_149719_Name = {
    Text = "Immune DAN Puro PVP__\"Solo per sviluppo\""
  },
  State_149736_Desc = {
    Text = "Le prossime [Layer] Carte di comando di <AwakerName:[DescArg1]> hanno lo Scudo Base aumentato del [StateArg1]%."
  },
  State_149736_Name = {
    Text = "Inganno melato"
  },
  State_149744_Desc = {
    Text = "La prossima Benedizione giocata non attiverà effetti negativi"
  },
  State_149744_Name = {
    Text = "Immunità ai Debuff"
  },
  State_149772_Desc = {
    Text = "Ogni volta che viene subito un Danno attivo, tutti i Risvegliatori perdono 3 Aliemus. Si attiva al massimo 5 volte per turno. Rimuove lo Stato \"Protezione Maledetta\" dopo che lo Scudo viene distrutto."
  },
  State_149772_Name = {
    Text = "Protezione Maledetta"
  },
  State_149773_Desc = {
    Text = "Ogni volta che viene subito un Danno attivo, applica 1 accumulo di \"Stagnazione\" Temporanea a 1 Carta casuale in mano. Si attiva al massimo 5 volte per turno. Rimuove lo \"Scudo di Gelo\" dopo che lo Scudo viene distrutto."
  },
  State_149773_Name = {
    Text = "Scudo di Brina"
  },
  State_149782_Desc = {
    Text = "Esaurisci: Dopo aver pescato carte nel prossimo turno, mescola 1 \"Frutto Proteiforme\" nel Mazzo di Pesca."
  },
  State_149782_Name = {
    Text = "Frutto Proteiforme"
  },
  State_149787_Desc = {
    Text = "Per ogni strato posseduto, il Danno Finale delle Carte di comando di Ogier il Giuramento Infranto aumenta del [DescArg2]%, il numero di carte pescate all'inizio del turno diminuisce di 1, il Danno critico aumenta del [DescArg3]%, limite massimo di [DescArg1] strati, non viene rimosso al termine della battaglia."
  },
  State_149787_Name = {
    Text = "<KuangNu:Corrente Sotterranea>"
  },
  State_149788_Desc = {
    Text = "Quando si gioca la \"Abilità\" di Giuramento Infranto·Ogier, consuma 1 accumulo per Pescare 1 carta \"Difesa\", che guadagna Conservare prima della prossima giocata. Massimo [DescArg1] accumuli. Non viene azzerato alla fine della battaglia."
  },
  State_149788_Name = {
    Text = "<ShuZui:Senso di Colpa>"
  },
  State_149789_Desc = {
    Text = "Per ogni strato posseduto, il Danno Finale delle Carte di comando di Ogier il Giuramento Infranto aumenta del 33%, il numero di carte pescate all'inizio del turno diminuisce di 1, limite massimo di [DescArg1] strati, non viene rimosso al termine della battaglia."
  },
  State_149789_Name = {
    Text = "<KuangNu:Corrente Sotterranea>"
  },
  State_149790_Desc = {
    Text = "Per ogni strato posseduto, il Danno Finale delle Carte di comando di Ogier il Giuramento Infranto aumenta del [DescArg2]%, il numero di carte pescate all'inizio del turno diminuisce di 1, limite massimo di [DescArg1] strati, non viene rimosso al termine della battaglia."
  },
  State_149790_Name = {
    Text = "<KuangNu:Corrente Sotterranea>"
  },
  State_149791_Desc = {
    Text = "Quando si gioca la \"Abilità\" di Giuramento Infranto·Ogier, consuma 1 accumulo per Pescare 1 carta \"Difesa\", che guadagna Conservare prima della prossima giocata. Massimo [DescArg1] accumuli. Non viene azzerato alla fine della battaglia."
  },
  State_149791_Name = {
    Text = "<ShuZui:Senso di Colpa>"
  },
  State_149814_Desc = {
    Text = "Amplificazione del Danno Temp. +[Layer]."
  },
  State_149814_Name = {
    Text = "Amplificazione del Danno Temporanea"
  },
  State_149819_Desc = {
    Text = "Immune a tutti i Danni"
  },
  State_149819_Name = {Text = "Immune"},
  State_149892_Desc = {
    Text = "Le prossime [Layer] Carte di comando di <AwakerName:[DescArg1]> hanno lo Scudo Base aumentato del [StateArg1]%."
  },
  State_149892_Name = {
    Text = "Verità Serena"
  },
  State_149913_Name = {
    Text = "Stato@Effetto Tesoro Verme Macrofago_Tintura Danneggiato"
  },
  State_149914_Name = {
    Text = "Stato@Effetto Tesoro del Verme Macrofago_William Danneggiato"
  },
  State_149915_Name = {
    Text = "Stato@Effetto Tesoro del Verme Macrofago_William"
  },
  State_149916_Name = {
    Text = "Stato@Effetto Tesoro del Verme Macrofago_Castor Danneggiato"
  },
  State_149917_Name = {
    Text = "Stato@Effetto Tesoro Verme Macrofago_Helot Helot Danneggiato"
  },
  State_149918_Name = {
    Text = "Stato@Test Inizio Turno Verme Macrofago"
  },
  State_149919_Name = {
    Text = "Stato@Effetto Tesoro Verme Macrofago_Tintura"
  },
  State_149920_Name = {
    Text = "Stato@Effetto Tesoro Verme Macrofago_Arachne"
  },
  State_149921_Name = {
    Text = "Stato@Effetto Tesoro Verme Macrofago_Arachne Danneggiato"
  },
  State_149922_Name = {
    Text = "Stato@Effetto Tesoro del Verme Macrofago_Castor"
  },
  State_149923_Name = {
    Text = "Stato@Effetto Tesoro Verme Macrofago_Helot Helot"
  },
  State_149930_Desc = {
    Text = "Per ogni accumulo, il Danno Finale delle Carte di comando di Giuramento Infranto·Ogier viene aumentato del 50%. All'inizio del turno, conteggio Pesca -1. Massimo [DescArg1] accumuli. Non viene azzerato alla fine della battaglia."
  },
  State_149930_Name = {
    Text = "<KuangNu2:Corrente Sotterranea>"
  },
  State_149931_Desc = {
    Text = "Ci sono 7 tipi di effetti, tra cui: ottenere STR, accumulare Guarigione della Fornace Cremisi, tutti i Risvegliatori ottengono Aliemus, potenziamento della Fusione Embrionale, pescare carte, ottenere Keyflare e potenziamento temporaneo dell'Amplificazione del Danno."
  },
  State_149931_Name = {
    Text = "<Blessing:Benedizione>"
  },
  State_149933_Name = {
    Text = "Stato@Bolla di Offerta del Mostro Caraboo"
  },
  State_149934_Name = {
    Text = "Stato@Bolla di Offerta del Mostro Caraboo"
  },
  State_149939_Desc = {
    Text = "Impossibile ottenere Scudo fino alla fine del turno."
  },
  State_149939_Name = {
    Text = "Catene Sanguigne"
  },
  State_19507_Desc = {
    Text = "Danno attivo e accumuli di Salasso ricevuti +25% fino all'inizio del prossimo turno, compensati dagli accumuli di Fortezza."
  },
  State_19507_Name = {
    Text = "<PVPVulnerabilityIconColour:Vulnerabile>"
  },
  State_19508_Desc = {
    Text = "A fine turno, scarta questa carta."
  },
  State_19508_Name = {
    Text = "<PVPVoidKeyColour:Illusione>"
  },
  State_19509_Desc = {
    Text = "Modifica temporaneamente l'Arithmetica della carta."
  },
  State_19509_Name = {
    Text = "Modifica Permanente Costo Arithmetica"
  },
  State_19511_Desc = {
    Text = "Alla morte, sostituisci le carte in mano con carte Illusione"
  },
  State_19511_Name = {
    Text = "La morte attiva la sostituzione delle carte in mano con Illusione."
  },
  State_19513_Name = {
    Text = "Applica duello mortale"
  },
  State_19516_Name = {
    Text = "Modifica temporanea costo Arithmetica"
  },
  State_19517_Desc = {
    Text = "Ottieni 1 Aliemus per ogni 2% di PV persi"
  },
  State_19517_Name = {
    Text = "Subire DAN concede Aliemus."
  },
  State_19519_Desc = {
    Text = "Dopo aver usato \"Colpo\", consuma tutti gli accumuli. Ogni accumulo aumenta il Danno di questo \"Colpo\" del 50%, fino a un massimo di 5 accumuli. (Attualmente +[DescArg1]%)"
  },
  State_19519_Name = {Text = "Carica"},
  State_19521_Desc = {
    Text = "Ogni accumulo aumenta di 1 punto tutti i danni inflitti in questa battaglia; non può essere dissolto."
  },
  State_19521_Name = {
    Text = "<PowerColourKeywords:FOR>"
  },
  State_19522_Name = {
    Text = "Modifica temporanea costo Arithmetica"
  },
  State_19523_Name = {
    Text = "Modifica Permanente Costo Arithmetica"
  },
  State_19524_Desc = {
    Text = "Prima dell'inizio del prossimo turno, infliggi [Layer] Danno passivo all'attaccante ogni volta che subisci un attacco."
  },
  State_19524_Name = {Text = "Contatore"},
  State_19525_Desc = {
    Text = "Rimuovi lo Scudo del Personaggio del Risvegliatore prima dell'Inizio del turno."
  },
  State_19525_Name = {
    Text = "Rimuovi lo Scudo del Personaggio prima dell'Inizio del turno"
  },
  State_19527_Desc = {
    Text = "Ogni accumulo aumenta il Costo di Arithmetica della \"Tecnica\" di +1 in questo turno, fino a un massimo di 3 accumuli. Dopo averla giocata, se gli accumuli sono maggiori di 1, gli accumuli diminuiscono di 1."
  },
  State_19527_Name = {
    Text = "<SlowColour:Stagnazione>"
  },
  State_19528_Desc = {
    Text = "Una carta con effetti potenti."
  },
  State_19528_Name = {
    Text = "<SilverKeyColour:Squadra>"
  },
  State_19529_Desc = {
    Text = "Ogni volta che giochi un'altra carta, riduci il Costo di Arithmetica di questa carta di 1 per la prossima giocata; dopo aver giocato questa carta, restituiscila alla tua mano e aumenta il suo Costo di Arithmetica di 1, poi scartala alla fine del turno."
  },
  State_19529_Name = {
    Text = "<CardKeyWord:Fantasma>"
  },
  State_19530_Desc = {
    Text = "Gli avversari devono dare priorità a questa unità per attacchi e abilità a bersaglio singolo.\nAll'attivazione: Sé: Rimuove la Furtività attuale. Alleati: Rimuove la loro Provocazione. Nemici: Dissolve tutta la Furtività nemica."
  },
  State_19530_Name = {
    Text = "<TauntColour:Scherno>"
  },
  State_19532_Desc = {
    Text = "I DAN inflitti sono ridotti del [DescArg1]% fino alla fine del turno, annullando i potenziamenti al momento dell'applicazione."
  },
  State_19532_Name = {Text = "Debolezza"},
  State_19533_Desc = {
    Text = "Danno inflitto -50% fino alla fine del turno, annullando il Potenziamento quando applicato."
  },
  State_19533_Name = {
    Text = "<WeaknessColour:Debolezza>"
  },
  State_19534_Desc = {
    Text = "Danno attivo e accumuli di Salasso subiti +[DescArg1]% fino all'inizio del prossimo turno, compensati dagli accumuli di Fortezza."
  },
  State_19534_Name = {
    Text = "Vulnerabile"
  },
  State_19535_Desc = {
    Text = "Gli avversari devono dare priorità a questa unità per attacchi e abilità a bersaglio singolo.\nAll'attivazione: Sé: Rimuove la Furtività attuale. Alleati: Rimuove la loro Provocazione. Nemici: Dissolve tutta la Furtività nemica."
  },
  State_19535_Name = {
    Text = "Provocazione"
  },
  State_19536_Desc = {
    Text = "A fine turno, ottieni 10 Aliemus"
  },
  State_19536_Name = {
    Text = "Ottieni innesco Aliemus a fine turno"
  },
  State_19537_Desc = {
    Text = "Prima della fine di questo turno, i DAN inflitti aumentano del [DescArg1]%, compensati dalla Debolezza."
  },
  State_19537_Name = {Text = "Potenzia"},
  State_19538_Desc = {
    Text = "Ottieni 1 accumulo all'inizio dei turni 8 e 9\nOgni accumulo di Lotta Feroce riduce il recupero di scudo del personaggio e di vita del 50% e diminuisce di 1 il numero di accumuli di barriera accumulabili\nLotta Feroce non può essere dissolta e colpisce anche i Risvegliatori caduti."
  },
  State_19538_Name = {
    Text = "Lotta Mortale"
  },
  State_19540_Name = {
    Text = "Limite di Arithmetica"
  },
  State_19541_Desc = {
    Text = "Impossibile compiere qualsiasi azione fino a fine turno."
  },
  State_19541_Name = {Text = "Svenuto"},
  State_19544_Desc = {
    Text = "Dopo aver usato \"Colpo\", consuma tutti gli accumuli. Ogni accumulo consumato aumenta il Danno di questo \"Colpo\" del 50%, fino a un massimo di 5 accumuli."
  },
  State_19544_Name = {
    Text = "<EnergyStorageColour:Carica>"
  },
  State_19545_Name = {
    Text = "Questa carta è considerata \"Colpo\""
  },
  State_19546_Desc = {
    Text = "Modifica l'Arithmetica della carta prima di giocarla"
  },
  State_19546_Name = {
    Text = "Modifica il Costo di Arithmetica prima di giocare"
  },
  State_19547_Desc = {
    Text = "A fine turno, subisci [Layer] Danno passivo. Permanente."
  },
  State_19547_Name = {Text = "Veleno"},
  State_19549_Desc = {
    Text = "Prima dell'inizio del prossimo turno, il Danno da attacco attivo subito è ridotto del 50% e annulla Vulnerabile quando applicato."
  },
  State_19549_Name = {
    Text = "<ReinforceColour:Fortezza>"
  },
  State_19552_Desc = {
    Text = "Attualmente possiedi [Layer] Scudo del Personaggio. Lo Scudo del Personaggio non può superare gli HP massimi e dura 1 turno."
  },
  State_19552_Name = {Text = "Scudo"},
  State_19553_Desc = {
    Text = "Ottieni \"Colpisci per Ultimo, Colpisci Meglio\" dopo la fase di pescata"
  },
  State_19553_Name = {
    Text = "Innesco Contrattacco"
  },
  State_19554_Name = {
    Text = "Stato vuoto"
  },
  State_19555_Desc = {
    Text = "·In questo turno il Costo di Arithmetica della \"Tecnica\" aumenta di +[Layer], fino a un massimo di 3 accumuli.\n·Dopo aver giocato una \"Tecnica\", se gli accumuli sono maggiori di 1, gli accumuli diminuiscono di 1."
  },
  State_19555_Name = {
    Text = "Stagnazione"
  },
  State_19556_Desc = {
    Text = "A fine turno, il Costo di Arithmetica di questa carta -[Layer]."
  },
  State_19556_Name = {
    Text = "<PrepareKeywords:Preparazione [Layer] >"
  },
  State_19557_Desc = {
    Text = "Prima dell'inizio del prossimo turno, il Danno da attacco attivo ricevuto è ridotto del [DescArg1]%, e si annulla con Vulnerabile quando applicato."
  },
  State_19557_Name = {Text = "Fortezza"},
  State_19558_Name = {
    Text = "Innesco Aggiunta Carta al Mazzo di Resurrezione"
  },
  State_19560_Desc = {
    Text = "Impossibile usare Esaltazione fino a fine turno."
  },
  State_19560_Name = {Text = "Sigillato"},
  State_19561_Name = {
    Text = ", può essere usato 3 volte"
  },
  State_19990_Desc = {
    Text = "All'inizio del prossimo turno, ottieni [Layer] Aliemus."
  },
  State_19990_Name = {
    Text = "Aliemus Ritardato"
  },
  State_19992_Desc = {
    Text = "Quando è Svenuto, il bersaglio non può agire fino alla fine del turno. Subire Danno da Svenimento conferisce Resistenza. Se la Resistenza è attiva, il Danno da Svenimento successivo è raddoppiato, ma l'effetto di Svenimento viene negato."
  },
  State_19992_Name = {
    Text = "<ComaColour:Faint>"
  },
  State_19995_Desc = {
    Text = "A fine turno, infligge Danno passivo pari al numero di accumuli. Permanente."
  },
  State_19995_Name = {
    Text = "<IntoxicationColour:Veleno>"
  },
  State_19996_Desc = {
    Text = "Prima della fine di questo turno, il Danno inflitto aumenta del 25%, compensato dalla Debolezza."
  },
  State_19996_Name = {
    Text = "<StrengthenColour:Potenziare>"
  },
  State_19998_Desc = {
    Text = "Prima dell'inizio del prossimo turno, ogni volta che subisci un attacco, infliggi all'attaccante un numero equivalente di accumuli di Danno passivo."
  },
  State_19998_Name = {
    Text = "<RetaliateColour:Contrattacco>"
  },
  State_20012_Desc = {
    Text = "Ogni Arithmetica rimanente ti consente di pescare 1 carta all'inizio del turno successivo; ogni carta rimanente in mano ti conferisce 1 Arithmetica all'inizio del turno successivo."
  },
  State_20012_Name = {
    Text = "Frammento dei Saggi"
  },
  State_20012_WeaponDesc = {
    Text = "Ogni Arithmetica rimanente ti consente di pescare 1 carta all'inizio del turno successivo; ogni carta rimanente in mano ti conferisce 1 Arithmetica all'inizio del turno successivo."
  },
  State_20013_Desc = {
    Text = "La <ProficientInRealmsIconKeywords:Padronanza del Reame> aumenta di 100. Ritorna la prima carta giocata ogni turno nella tua mano. All'inizio di un Turno Ultra, aumenta il Limite di Mano di 5 e Copia la tua mano."
  },
  State_20013_Name = {
    Text = "Stato@Pendolo crono Riflesso"
  },
  State_20014_Name = {
    Text = "Cronopendolo \"Intervallo\""
  },
  State_20016_Name = {
    Text = "Reliquia Guanti Arcani"
  },
  State_20017_Desc = {
    Text = "Il prossimo effetto Balzo si attiverà sicuramente."
  },
  State_20017_Name = {Text = "Balzo"},
  State_20021_Desc = {
    Text = "La <ProficientInRealmsIconKeywords:Padronanza del Reame> aumenta di 100. Ritorna la prima carta giocata ogni turno nella tua mano. All'inizio di un Turno Ultra, aumenta il Limite di Mano di 5 e Copia la tua mano."
  },
  State_20021_Name = {
    Text = "Stato@Pendolo crono Riflesso"
  },
  State_20023_Desc = {
    Text = "All'Inizio della Battaglia, mischia due carte Carica di Aliemus nel mazzo."
  },
  State_20023_Name = {
    Text = "Cucitore del Caos"
  },
  State_20023_WeaponDesc = {
    Text = "All'Inizio della Battaglia, mischia due carte Carica di Aliemus nel mazzo."
  },
  State_20024_Desc = {
    Text = "Ottieni 1 \"Infusione Tossica\" che può applicare [Arg1] Veleno al rilascio di Exaslt. A fine turno, per ogni 3 carte \"Infusione Tossica\" In Mano, sintetizza 1 \"Esplosione Tossica\" che attiva il Veleno."
  },
  State_20024_Name = {
    Text = "Stato@Reliquia Lingua di Mutazione"
  },
  State_20026_Desc = {
    Text = "La carta non entra nella Pila degli scarti, ma rimane In Mano. Attiverà gli effetti successivi."
  },
  State_20026_Name = {
    Text = "<RetainIconKeywords:Conservare>"
  },
  State_20026_WeaponDesc = {
    Text = "Dopo essere stata giocata, la carta non finirà nella Pila degli scarti e non potrà essere usata di nuovo in questa Battaglia."
  },
  State_20028_Desc = {
    Text = "La <ProficientInRealmsIconKeywords:Padronanza del Reame> aumenta di 100. Ogni carta giocata conferisce +10 Fusione Embrionale. Quando i Vita sono inferiori al 25%, l'aumento diventa 20. Si attiva fino a 10 volte per turno."
  },
  State_20028_Name = {
    Text = "Stato@Pendolo crono Corruzione"
  },
  State_20029_Desc = {
    Text = "Ottieni 1 \"Infusione Tossica\" che può applicare [Arg1] Veleno al rilascio di Exaslt. A fine turno, per ogni 3 carte \"Infusione Tossica\" In Mano, sintetizza 1 \"Esplosione Tossica\" che attiva il Veleno."
  },
  State_20029_Name = {
    Text = "Stato@Reliquia Lingua di Mutazione"
  },
  State_20035_Name = {
    Text = "Stato@Pendolo crono Addormentato"
  },
  State_20038_Name = {
    Text = "Simbionte del Caos"
  },
  State_20038_WeaponDesc = {
    Text = "Quando la squadra è composta da Caos e altre classi, tutti i Risvegliati ottengono 20 Aliemus all'inizio del loro turno."
  },
  State_20039_Desc = {
    Text = "Se conservata In Mano durante la fase di scarto, Esaurimento. Non riapparirà."
  },
  State_20039_Name = {
    Text = "<NothingnessIconKeywords:Effimero>"
  },
  State_20039_WeaponDesc = {
    Text = "Dopo essere stata giocata, la carta non finirà nella Pila degli scarti e non potrà essere usata di nuovo in questa Battaglia."
  },
  State_20040_Name = {
    Text = "Stato@Pendolo crono Conteggio Risveglio"
  },
  State_20041_Desc = {
    Text = "A inizio turno, ottieni 1 Arithmetica e pesca 1 carta per ogni nemico. Quando un nemico viene sconfitto dal Danno attivo, infliggi il doppio del danno in eccesso come Salasso agli altri nemici."
  },
  State_20041_Name = {
    Text = "Canto della Folla Mutata"
  },
  State_20042_Desc = {
    Text = "Infliggi il 25% di Danno in più ai nemici con debuff e ottieni 20 Aliemus uccidendoli."
  },
  State_20044_Desc = {
    Text = "Aumenta l'effetto di Sintomo: Debolezza del 10%. Aggiunge 1 accumulo di Sintomo: Debolezza a tutti i nemici ogni 3 turni."
  },
  State_20045_Desc = {
    Text = "All'inizio del prossimo turno, seleziona 3 carte qualsiasi dal tuo mazzo e aggiungile alla tua mano."
  },
  State_20045_Name = {
    Text = "Danza del Pendolo Crono"
  },
  State_20306_Name = {
    Text = "Reliquia Guanti Arcani"
  },
  State_20419_Desc = {
    Text = "Applica [Arg1] cariche di Veleno per ogni colpo. Se attivato 25 volte durante questa battaglia, applica immediatamente Veleno a tutti i nemici."
  },
  State_20425_Desc = {
    Text = "A inizio turno, ottieni [Layer] <PowerIconKeywords:FOR> Temporanea e Scudo del Personaggio."
  },
  State_20425_Name = {
    Text = "Divoratore Assetato di Sangue"
  },
  State_20600_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: le prime [StateArg2] carte \"Abilità\" di ogni turno riducono il Costo di Arithmetica di -[StateArg1]."
  },
  State_20600_Name = {Text = "Epifania"},
  State_20601_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Danno da \"Colpo\" + [StateArg1]%. Ottieni [StateArg2] accumuli di <EnergyStorageKeywords:Carica> per ogni attacco subito."
  },
  State_20601_Name = {Text = "Gola"},
  State_20602_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: \"Colpo\" può selezionare un bersaglio e applicare [StateArg1] accumuli di <PVPSlowKeywords:Stagnazione>. L'effetto raddoppia quando attivato sul primo bersaglio di ogni turno."
  },
  State_20602_Name = {
    Text = "Mano dell'Oblio"
  },
  State_20603_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo \"Esaltazione\", concede a sé <Energy:[Energy:StateArg1]> Aliemus."
  },
  State_20603_Name = {
    Text = "Divoramento Aberrante"
  },
  State_20604_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: \"Colpo\" ripristina <Heal:[Heal:StateArg1]> HP a sé."
  },
  State_20604_Name = {Text = "Suzione"},
  State_20605_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del Destino>: Quando equipaggiata, <ComaKeywords:Svenimento> su di sé. Dissolvi tutti i debuff degli alleati prima di \"Esaltazione\"."
  },
  State_20605_Name = {
    Text = "Bastone del Nobiluomo"
  },
  State_20606_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del Destino>: \"Colpo\" conferisce al Portatore <Energy:[Energy:StateArg1]> Aliemus."
  },
  State_20606_Name = {Text = "Frenesia"},
  State_20607_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: «Colpo» attacca il nemico con <HPAndShieldMax:vita e scudo più alti> e infligge inoltre <PVPBleedingKeywords:emorragia> pari al [StateArg1]% dei danni."
  },
  State_20607_Name = {
    Text = "Recidere e Cicatrizzare"
  },
  State_20608_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo aver usato un'\"Abilità\" e a fine turno, ottieni <Energy:[Energy:StateArg1]> Aliemus."
  },
  State_20608_Name = {Text = "Sussurro"},
  State_20609_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: L'Aliemus ottenuto dalla perdita di HP viene raddoppiato."
  },
  State_20609_Name = {
    Text = "Sogno del mare"
  },
  State_20610_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Aumento DAN di \"Colpo\" [DescArg1]%, dopo \"Esaltazione\" aumenta il proprio <PVPPowerIconKeywords:Potere>+ [StateArg2] e aumenta ulteriormente il Danno di \"Colpo\" del [StateArg3]%, massimo 100%."
  },
  State_20610_Name = {
    Text = "Bestia Celeste"
  },
  State_20611_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: \"Abilità\", e alla fine del turno, ripristina <Heal:[Heal:StateArg1]> HP all'alleato con più HP persi."
  },
  State_20611_Name = {Text = "Speranza"},
  State_20612_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: A fine turno, concede all'alleato con l'Aliemus più basso <Energy:[Energy:StateArg1]> Aliemus e cura l'alleato con più HP persi di <Heal:[Heal:StateArg2]> HP."
  },
  State_20612_Name = {
    Text = "Nutrimento Misericordioso"
  },
  State_20613_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del Destino>: A fine turno, concedi agli altri alleati <Block:[Block:StateArg1]> Scudo."
  },
  State_20613_Name = {
    Text = "La Terra dell'Inesistenza"
  },
  State_20614_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: A fine turno, ottieni [StateArg1] <PVPRetaliateIconKeywords:Contatore> Temporaneo."
  },
  State_20614_Name = {
    Text = "Fusione del Nucleo"
  },
  State_20615_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Il primo \"Colpo\" di ogni turno infligge [StateArg1] Danni aggiuntivi e infligge la stessa quantità di <PVPMethysisKeywords:Veleno>."
  },
  State_20615_Name = {
    Text = "Vincolo Maledetto"
  },
  State_20616_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Ottieni <Energy:[Energy:StateArg1]> Aliemus a fine turno."
  },
  State_20616_Name = {
    Text = "Primavera a Yakutsk"
  },
  State_20617_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Alla fine del turno, ottieni [Block:StateArg1] di <Block:Scudo del Personaggio>."
  },
  State_20617_Name = {Text = "Esilio"},
  State_20618_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Prima di \"Esaltazione\", entrambe le parti scartano tutte le carte in mano, poi pescano un numero di carte pari alla quantità scartata +1."
  },
  State_20618_Name = {
    Text = "Spettacolo di magia felice"
  },
  State_20619_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Ottieni <Energy:[Energy:StateArg1]> Aliemus quando equipaggiata. Dopo che un Risvegliatore alleato scatena \"Esaltazione\", ottieni <DelayKeywords:Ritardo>: <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_20619_Name = {
    Text = "Inno al Sovrano"
  },
  State_20620_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Limite Mano + [StateArg2]. A fine turno, ottieni copie casuali di [StateArg1] \"Abilità\" dalla mano."
  },
  State_20620_Name = {
    Text = "Momento della Riunione"
  },
  State_20621_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Prima dell'\"Esaltazione\", applica <StrengthenKeywords:Potenziare> e <ReinforceKeywords:Fortezza> a se stesso."
  },
  State_20621_Name = {
    Text = "Grazia Attraverso il Dolore"
  },
  State_20622_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: alla fine del turno ottiene <Energy:[Energy:StateArg1]> Aliemus, consuma tutta l'Arithmetica rimanente, ogni 1 Arithmetica consumata aumenta l'Aliemus ottenuto di [StateArg3]."
  },
  State_20622_Name = {
    Text = "Nascita Celata"
  },
  State_20623_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo l'\"Esaltazione\", pesca [StateArg1] carte."
  },
  State_20623_Name = {Text = "Emersione"},
  State_20624_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo \"Esaltazione\", pesca [StateArg1] carte e ne aggiunge [StateArg2] copie alla mano."
  },
  State_20624_Name = {
    Text = "Ora della Fortuna"
  },
  State_20625_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo \"Esaltazione\", <DelayKeywords:Ritardo>: Ripristina <Heal:[Heal:StateArg1]> PV a tutte le unità alleate."
  },
  State_20625_Name = {
    Text = "La Favola del Divoratore"
  },
  State_20626_Desc = {
    Text = "<ReinforceKeywords:Ruota del destino>: Danno da \"Colpo\" +[StateArg1]% e <PVPWeaponKeywords:Fortezza> su di sé."
  },
  State_20626_Name = {
    Text = "Volontà Indomita"
  },
  State_20627_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: A fine turno, ripristina <Heal:[Heal:StateArg1]> PV a tutti gli alleati."
  },
  State_20627_Name = {
    Text = "Benedizione"
  },
  State_20628_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo l'\"Esaltazione\", conferisci agli altri alleati <Energy:[Energy:StateArg1]> Aliemus. Se questo conferisce a un alleato più Aliemus di quanti ne servano per attivare la sua Esaltazione, il Portatore ottiene la metà dell'eccedenza."
  },
  State_20628_Name = {
    Text = "Gravità del Dovere"
  },
  State_20629_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Gli effetti di Danno, Guarigione e Scudo del Personaggio dell'\"Esaltazione\" sono aumentati del [StateArg1]%."
  },
  State_20629_Name = {
    Text = "In Nome della Rosa"
  },
  State_20630_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: A fine turno, ottieni uno Scudo <Block:[Block:StateArg1]> e <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_20630_Name = {
    Text = "Requiem d'Inverno"
  },
  State_20631_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: \"Colpo\" infligge <PVPVulnerabilityIconKeywords:Vulnerabile> al bersaglio. A fine turno, ottieni [StateArg1] <EnergyStorageKeywords:Carica>."
  },
  State_20631_Name = {
    Text = "Punto critico"
  },
  State_20632_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Limite di Mano +[StateArg1]."
  },
  State_20632_Name = {
    Text = "Spirale della Memoria"
  },
  State_20633_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Quando il Portatore subisce un attacco diretto per la prima volta ogni turno, infliggi [StateArg1] Danno all'attaccante, <PVPEntanglementKeywords:Intrecciare>."
  },
  State_20633_Name = {
    Text = "Discendente Pallido"
  },
  State_20634_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Danni, Guarigione e Scudo da \"Colpo\", \"Abilità\" ed \"Esaltazione\" aumentati del [DescArg1]%. <PVPGrowthKeywords:Crescita>: [StateArg2]%."
  },
  State_20634_Name = {
    Text = "Tramonto Solare"
  },
  State_20635_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Concedi <StrengthenKeywords:Potenziare> a tutti gli alleati prima dell'\"Esaltazione\"."
  },
  State_20635_Name = {
    Text = "Potere dei devoti"
  },
  State_20636_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: A fine turno, ottieni un'<PVPDerivativeCardKeywords_2:\"Illusione\">. Per ogni due <PVPDerivativeCardKeywords_2:\"Illusione\"> nella tua mano, fondile in un <PVPDerivativeCardKeywords_12:\"Piccolo Desiderio\">."
  },
  State_20636_Name = {
    Text = "Invecchiato"
  },
  State_20637_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Alla fine del tuo turno, Mischia [StateArg1] <PVPDerivativeCardKeywords_11:\"Scambio Ineguale\"> nel tuo Mazzo di Pesca."
  },
  State_20637_Name = {
    Text = "I dati sono vita"
  },
  State_20639_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: alla fine del turno, il portatore infligge [StateArg1] danni al nemico con <HPAndShieldMax:vita e scudo più alti>, <PVPMethysisKeywords:avvelenamento>."
  },
  State_20639_Name = {
    Text = "Dono della Decomposizione"
  },
  State_20640_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Quando equipaggiata e a inizio turno, infligge <Damage:[Damage:StateArg1]> DAN da <PVPBleedingKeywords:Salasso> a tutti i nemici. Per ogni carta nella mano del bersaglio, il DAN da <PVPBleedingKeywords:Salasso> aumenta di +[StateArg2]."
  },
  State_20640_Name = {
    Text = "Banchetto Sanguinario"
  },
  State_20641_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Alla morte, concede agli altri alleati [StateArg1] cariche di <PVPProtectiveKeywords:Barriera>."
  },
  State_20641_Name = {
    Text = "Analisi della Morte"
  },
  State_20642_Desc = {
    Text = "<PVPHoldingKeywords:In Mano>: Ogni volta che giochi una carta, questa carta si trasforma in una \"Ruota del destino\" casuale con -1 al Costo di Arithmetica."
  },
  State_20642_Name = {
    Text = "Nascita di un'anima"
  },
  State_20643_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: dopo l'\"Esaltazione\" ottiene [StateArg1] Arithmetica, <DelayKeywords:Ritardo>: sottrae [StateArg2] Arithmetica."
  },
  State_20643_Name = {
    Text = "Sindrome della Memoria"
  },
  State_20644_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Quando equipaggiata, infliggi [StateArg2] Danno a te stesso, <PVPEntanglementKeywords:Intrecciare>. Per ogni alleato Decaduto, <StrongEffectKeywords:Amplificazione> +[StateArg1]."
  },
  State_20644_Name = {
    Text = "Rarità Preziosa"
  },
  State_20645_Name = {
    Text = "Zaino dell'Avventuriero"
  },
  State_20646_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: I DAN da \"Colpo\" aumentano del [StateArg1]%, e \"Esaltazione\" cura sé stessi di <Heal:[Heal:StateArg2]> PV."
  },
  State_20646_Name = {
    Text = "Ninnananna Divorata"
  },
  State_20647_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo \"Esaltazione\", inserisci [StateArg1] <PVPDerivativeCardKeywords_11:\"Scambio Ineguale\"> nella tua mano."
  },
  State_20647_Name = {
    Text = "Nel cuore del diluvio"
  },
  State_20648_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: A inizio turno, ottiene un <PVPWonderfulEffectKeywords:Effetto meraviglioso> positivo. Quando il nemico usa \"Posse\" per la prima volta ogni turno, [StateArg1] carte \"Spettacolo magnifico\" vengono aggiunte alla tua mano."
  },
  State_20648_Name = {
    Text = "Banchetto Silenzioso"
  },
  State_20649_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo \"Esaltazione\", riporta in mano l'ultima \"Abilità\" giocata nel turno precedente; il suo Costo di Arithmetica -1. Se questo tipo di Effetto viene attivato più volte, risale ulteriormente indietro."
  },
  State_20649_Name = {
    Text = "Orologio del tempo riavvolto"
  },
  State_20650_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Quando equipaggiata, infliggi <ComaKeywords:Svenuto> a se stessi. Dissolvi tutti i potenziamenti dai nemici prima di \"Esaltazione\"."
  },
  State_20650_Name = {Text = "Delirium"},
  State_20651_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: A fine turno, pesca [StateArg1] carte."
  },
  State_20651_Name = {Text = "Avidità"},
  State_20652_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo l'\"Esaltazione\", infliggi [StateArg1] Danno a tutti i nemici, <DisarmKeywords:Paralisi>."
  },
  State_20652_Name = {Text = "Punizione"},
  State_20653_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: \"Colpo\" può selezionare un bersaglio e detrarre <Energy:[Energy:StateArg1]> Aliemus da quel bersaglio."
  },
  State_20653_Name = {
    Text = "Alla deriva nel Desiderio"
  },
  State_20654_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: All'Inizio del turno, infliggi <PVPSeriousInjuryKeywords:Flagello> a te stesso e ottieni <Damage:[Damage:StateArg1]> stack di <PVPCorrosionKeywords:Marchio del Peccato>. Alla fine del turno, <ReinforceKeywords:Rinforzato> te stesso."
  },
  State_20654_Name = {
    Text = "Editto della Regina"
  },
  State_20655_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Danno \"Colpo\" +[StateArg1]%, il \"Colpo\" può selezionare i bersagli."
  },
  State_20655_Name = {Text = "Favore"},
  State_20656_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: I danni, le cure e gli effetti Scudo da \"Abilità\" sono aumentati del [StateArg1]%. Se non c'è alcuna <PVPProtectiveKeywords:Barriera> dopo aver usato \"Abilità\", ottieni 1 accumulo."
  },
  State_20656_Name = {
    Text = "L'Ultimo Verso"
  },
  State_20657_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Ogni turno, quando l'avversario gioca la [StateArg1]ª \"Abilità\", colloca in mano una copia con il Costo di Arithmetica ridotto di [StateArg2]."
  },
  State_20657_Name = {Text = "Intuizione"},
  State_20658_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: \"Colpo\" genera [StateArg1] Arithmetica per ogni bersaglio colpito."
  },
  State_20658_Name = {
    Text = "Canto del Prigioniero"
  },
  State_20659_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Alla morte, <PVPResurrectionKeywords:Rianimazione> a inizio del turno successivo con <Heal:[Heal:StateArg1]> HP e <Block:[Block:StateArg2]> Scudo, distruggendo questa \"Ruota del destino\"."
  },
  State_20659_Name = {Text = "Vitalità"},
  State_20660_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del Destino>: Dopo \"Esaltazione\", tutti gli alleati ottengono <Block:[Block:StateArg1]> Scudo del Personaggio."
  },
  State_20660_Name = {
    Text = "Barriera Mentale"
  },
  State_20661_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo \"Esaltazione\", infliggi <Damage:[Damage:StateArg1]> di Danno da <PVPBleedingKeywords:Salasso> a tutti i nemici."
  },
  State_20661_Name = {
    Text = "Sentiero Abbandonato"
  },
  State_20662_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: alla fine del turno, per ogni punto di <PVPCapKeywords:capacità di calcolo massima> infligge [StateArg1] <PVPBleedingKeywords:emorragia> al nemico con <HPAndShieldMin:vita e scudo più bassi>, per un totale di <Damage:[Damage:DescArg1]> danni da <PVPBleedingKeywords:emorragia>."
  },
  State_20662_Name = {
    Text = "Celato nella Notte"
  },
  State_20663_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dissolvi i propri debuff e ottieni [StateArg1] accumuli di <EnergyStorageKeywords:Carica> prima dell'\"Esaltazione\"."
  },
  State_20663_Name = {
    Text = "Catene Infrante"
  },
  State_20664_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: \"Abilità\" applica <ReinforceKeywords:Fortezza> su di sé."
  },
  State_20664_Name = {
    Text = "Il Voto di un Cavaliere"
  },
  State_20665_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Se non ci sono debuff da dissolvere, ripristina <Heal:[Heal:StateArg1]> PV. A fine turno, <DelayKeywords:Ritardo>: Dissolvi i propri debuff."
  },
  State_20665_Name = {
    Text = "Vela della Provvidenza"
  },
  State_20666_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: dopo «Esplosione di follia», l'alleato con <HPAndShieldMin:vita e scudo più bassi> ottiene [StateArg1] stack di <PVPProtectiveKeywords:barriera>."
  },
  State_20666_Name = {
    Text = "Al Mio Caro Amico"
  },
  State_20667_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: La prima \"Abilità\" giocata dal portatore ogni turno infligge +[StateArg1]% Danno."
  },
  State_20667_Name = {
    Text = "Lama del Titano"
  },
  State_20668_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Quando un nostro Risvegliato muore, infligge <Damage:[Damage:StateArg1]> DAN da <PVPBleedingKeywords:Salasso> a tutti i bersagli nemici. Quando il Portatore muore, infligge <Damage:[Damage:StateArg2]> Danno da <PVPBleedingKeywords:Salasso> aggiuntivo."
  },
  State_20668_Name = {
    Text = "Morte della Sig.ra Coral"
  },
  State_20669_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Quando equipaggiata e a inizio turno, se non è presente alcuna <PVPProtectiveKeywords:Barriera>, ottieni [StateArg1] accumuli di <PVPProtectiveKeywords:Barriera>; altrimenti, il costo di 1 carta \"Abilità\" con il costo più alto in mano -1."
  },
  State_20669_Name = {
    Text = "Tavola delle Scritture"
  },
  State_20670_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: \"Colpo\" infligge <PVPSeriousInjuryKeywords:Ferita Grave>, aumentando il Danno del [StateArg1]%, ma il lanciatore perde metà del Danno inflitto come PV."
  },
  State_20670_Name = {
    Text = "Pinna del Dolore"
  },
  State_20671_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo \"Esaltazione\", ripristina <Heal:[Heal:StateArg1]> PV a sé stessi."
  },
  State_20671_Name = {
    Text = "Ascesa Immortale"
  },
  State_20672_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: A fine turno, riduce il Costo di Arithmetica della carta con il Costo di Arithmetica più alto in mano di [StateArg1]. <PrepareKeywords:Preparazione>."
  },
  State_20672_Name = {
    Text = "Concentrazione Elevata"
  },
  State_20673_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo \"Esaltazione\", concede a sé <Block:[Block:StateArg1]> Scudo del Personaggio e agli altri alleati <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_20673_Name = {
    Text = "Fattore incalcolabile"
  },
  State_20696_Name = {
    Text = "Stato@Paura dei Giganti"
  },
  State_20723_Desc = {
    Text = "Danno di \"Colpo\" aumentato di [Layer]."
  },
  State_20723_Name = {
    Text = "Danno Fisso delle carte Colpo aumentato"
  },
  State_20724_Desc = {
    Text = "Danno di \"Colpo\" ridotto di [Layer]."
  },
  State_20724_Name = {
    Text = "Danno Fisso delle carte Colpo ridotto"
  },
  State_20749_Desc = {
    Text = "Contatore Traccia Universale."
  },
  State_20758_Desc = {
    Text = "All'inizio del prossimo turno, pesca [Layer] carte."
  },
  State_20758_Name = {
    Text = "Pescata Ritardata"
  },
  State_20766_Desc = {
    Text = "Per gli effetti specifici, consulta la logica base di Colpo."
  },
  State_20802_Desc = {
    Text = "Questa carta non può essere giocata."
  },
  State_20802_Name = {
    Text = "Non Giocabile"
  },
  State_20803_Desc = {
    Text = "Questa carta riduce il Costo di Arithmetica di 1. Dopo aver usato un'altra carta, questa carta si trasforma in una carta Ruota del Destino casuale."
  },
  State_20803_Name = {
    Text = "<CardKeyWord:Nascita di un'anima>"
  },
  State_20805_Desc = {
    Text = "La carta non entra nella Pila degli scarti, ma rimane In Mano."
  },
  State_20805_Name = {
    Text = "<RetainIconKeywords:Conservare>"
  },
  State_20806_Desc = {
    Text = "Dopo essere stata giocata, questa carta viene rimossa dal mazzo anziché entrare nella Pila degli scarti."
  },
  State_20806_Name = {
    Text = "<DepleteIconKeywords:Consumo>"
  },
  State_20820_Desc = {
    Text = "Rianimazione all'inizio del prossimo turno con [Layer] PV e [Layer] Scudo."
  },
  State_20820_Name = {
    Text = "Rinascita Ritardata"
  },
  State_20851_Name = {
    Text = "Concessione Carta"
  },
  State_20981_Desc = {
    Text = "\"Cremisi\" è stato Risvegliato, aumentando significativamente il Danno inflitto."
  },
  State_20981_Name = {
    Text = "Risveglio di Uvhash!"
  },
  State_20981_WeaponDesc = {
    Text = "A inizio del turno successivo, ottieni Scudo del Personaggio pari alla quantità di HP persi nel turno precedente."
  },
  State_20982_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_20982_Name = {
    Text = "Non Risvegliato"
  },
  State_20988_Desc = {
    Text = "Si inizia con +80 Aliemus. Si ottengono 20 Aliemus ogni turno."
  },
  State_20988_Name = {
    Text = "Daffodil: Primo Incontro"
  },
  State_20989_Desc = {
    Text = "Si inizia con +80 Aliemus. Si ottengono 2 Arithmetica e 20 Aliemus per turno."
  },
  State_20989_Name = {
    Text = "Tulu: Primo Incontro"
  },
  State_21306_Desc = {
    Text = "Resetta la combo a ogni turno."
  },
  State_21306_Name = {
    Text = "Reset Combo"
  },
  State_21307_Desc = {
    Text = "Ogni accumulo aumenta il conteggio degli attacchi di 1. Perdi 1 accumulo per ogni istanza di Danno subito, con un minimo di 1 accumulo rimanente, e perdi tutti gli accumuli a fine turno."
  },
  State_21307_Name = {Text = "Combo"},
  State_21342_Desc = {
    Text = "All'inizio del prossimo turno, ottieni [Layer] PV"
  },
  State_21342_Name = {
    Text = "Cura Ritardata"
  },
  State_21345_Desc = {
    Text = "Prima che il Rituale della Discesa Divina abbia inizio, la morte ti rianimerà, rimuoverà i debuff, garantirà immunità al Danno e ripristinerà il 30% dei PV. Dopo l'inizio della cerimonia, la morte ti rianima completamente, rimuove i debuff e l'Ossessione Rituale, e richiama due Progenie."
  },
  State_21345_Name = {
    Text = "Ossessione Rituale"
  },
  State_21358_Desc = {
    Text = "La mano di questo giocatore non ha limiti di dimensione."
  },
  State_21381_Name = {
    Text = "Conteggio Utilizzi Sigillo"
  },
  State_21385_Desc = {
    Text = "Diminuisce di 1 carica ogni volta che si perde 1 PV. Quando il numero di cariche si riduce a 0, l'intenzione si trasforma in un'Esaltazione ad alto Danno e rimuove l'effetto Pietrificare."
  },
  State_21385_Name = {
    Text = "Frenesia del Sangue"
  },
  State_21450_Desc = {
    Text = "A inizio del turno successivo, rimuove tutte le penalità da sé."
  },
  State_21450_Name = {
    Text = "Purificazione Ritardata"
  },
  State_21488_Desc = {
    Text = "Per gli effetti specifici, consulta la logica base di Colpo."
  },
  State_21492_Desc = {
    Text = "Il Danno aumenta del 50% con un Colpo Critico."
  },
  State_21492_Name = {
    Text = "<CardKeyWord:Colpo Critico>"
  },
  State_21546_Desc = {
    Text = "All'inizio del prossimo turno, ottieni [Layer] Scudo del Personaggio."
  },
  State_21546_Name = {
    Text = "Scudo Ritardato"
  },
  State_21547_Desc = {
    Text = "A inizio turno, conserva metà del tuo Scudo del Personaggio."
  },
  State_21547_Name = {Text = "Tenace"},
  State_21548_Desc = {
    Text = "All'inizio del prossimo turno, ottieni Potenziamento."
  },
  State_21548_Name = {
    Text = "Potenziamento Ritardato"
  },
  State_21580_Desc = {
    Text = "Il Cacciatore di Teschi sta seguendo i tuoi movimenti. Per ogni carta pescata, il Cacciatore di Teschi ottiene [StateArg1] FOR temporanea."
  },
  State_21580_Name = {Text = "Traccia"},
  State_21587_Name = {
    Text = "In questo turno è stato trovato un nuovo Risvegliatore casuale."
  },
  State_21590_Name = {
    Text = "Numero di tentativi per trovare un nuovo Risvegliato"
  },
  State_21601_Name = {
    Text = "Nuovo Risvegliatore trovato"
  },
  State_21616_Desc = {
    Text = "Dopo aver usato Esaltazione, sigilla tutti i Risvegliatori per un turno."
  },
  State_21616_Name = {
    Text = "Resti del Viandante"
  },
  State_21671_Name = {
    Text = "Infliggi Danno ad Area"
  },
  State_21688_Name = {
    Text = ", può essere usato 1 volta"
  },
  State_21689_Name = {
    Text = ", può essere usato 2 volte"
  },
  State_21720_Desc = {
    Text = "Colpisce anche il Risvegliatore dietro il bersaglio. Se non ve n'è alcuno, solo il bersaglio viene colpito."
  },
  State_21720_Name = {
    Text = "<CardKeyWord:Perforazione>"
  },
  State_21726_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo che il portatore gioca la sua prima \"Abilità\" in ogni turno, mescola una copia con Costo di Arithmetica - [StateArg1] nel Mazzo di Pesca."
  },
  State_21726_Name = {Text = "Fouetté"},
  State_21744_Name = {
    Text = "Numero di tentativi per trovare un nuovo Risvegliato"
  },
  State_21745_Name = {
    Text = "Nuovo Risvegliatore trovato"
  },
  State_21746_Name = {
    Text = "In questo turno è stato trovato un nuovo Risvegliatore casuale."
  },
  State_21747_Desc = {
    Text = "Ci sono [Layer] Risvegliatori sotto Caccia, e per ogni carta giocata dai Risvegliatori sotto Caccia, il \"Cacciatore di Teschi Impazzito\" accumula 1 livello di Marchio di Caccia."
  },
  State_21747_Name = {
    Text = "Cerimonia di Caccia"
  },
  State_21751_Desc = {
    Text = "Pesca metà delle carte con Marchio di Caccia ([DescArg1]) e aumenta di 1 il numero di Marchi di Caccia su \"Cacciatore di Teschi Impazzito\"."
  },
  State_21751_Name = {
    Text = "<CardKeyWord:Braccato>"
  },
  State_21754_Desc = {
    Text = "Alla morte, dissolvi tutta la FOR temporanea del \"Cacciatore di Teschi Impazzito\" e dimezza gli accumuli del suo \"Marchio di Caccia\"."
  },
  State_21754_Name = {
    Text = "Sollievo temporaneo"
  },
  State_21765_Desc = {
    Text = "Equipaggia una \"Ruota del destino\" a un Risvegliato per attivarla.\nSe ne è già equipaggiata una, la vecchia Ruota viene distrutta.\nSe il Risvegliato muore, la Ruota viene distrutta.\nEquipaggiarla a un Risvegliato morto la distrugge, concede 1 Illusione e rimborsa il costo."
  },
  State_21765_Name = {
    Text = "<PVPWeaponKeywords:Ruota del destino>"
  },
  State_21785_Name = {
    Text = "Grido di Battaglia"
  },
  State_21787_Name = {
    Text = "Aggiungi Gridi di Battaglia"
  },
  State_21826_Name = {
    Text = "\"Il Re Bambino inizia il suo discorso\""
  },
  State_21829_Name = {
    Text = "Effetto Rantolo di Morte"
  },
  State_21838_Name = {
    Text = "Presentazione d'Apertura"
  },
  State_21843_Name = {
    Text = "Applica Stato all'inizio"
  },
  State_21895_Name = {
    Text = "Dichiarazione d'Apertura"
  },
  State_21905_Desc = {
    Text = "\"Colpo\" ottiene 2 Arithmetica e scarta 1 carta casuale; \"Difesa\" pesca 2 carte e perde 1 Arithmetica."
  },
  State_21928_Name = {
    Text = "Indagine in corso"
  },
  State_22054_Name = {
    Text = "Dichiarazione d'Apertura"
  },
  State_22055_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_22055_Name = {
    Text = "Non Risvegliato"
  },
  State_22067_Desc = {
    Text = "A fine turno, effettua 1 Attacco del Tentacolo [Layer] volte."
  },
  State_22067_Name = {
    Text = "Raduno dei tentacoli"
  },
  State_22074_Desc = {
    Text = "Sopravvivi fino al 7° turno per cambiare l'Intenzione in Fissare, dall'8° turno in poi per cambiare l'Intenzione in Profanazione"
  },
  State_22134_Desc = {
    Text = "Infligge Danno allo Scudo, alla Vita e alla Barriera del bersaglio simultaneamente."
  },
  State_22134_Name = {
    Text = "<CardKeyWord:Danni perforanti>"
  },
  State_22157_Desc = {
    Text = "Quando i PV scendono sotto il 50%([StateArg1]), si dividerà in \"Corrente\" e \"Marea\" con PV equamente distribuiti."
  },
  State_22157_Name = {Text = "Scissione"},
  State_22204_Desc = {
    Text = "A inizio turno, ottieni [Layer]% di Tasso critico temporaneo e Danno critico temporaneo."
  },
  State_22204_Name = {
    Text = "Melodia distante"
  },
  State_22204_WeaponDesc = {
    Text = "fino all'inizio del turno successivo senza perdere PV, Tasso Crit. +[StateArg1]%."
  },
  State_22210_Desc = {
    Text = "Costo di Arithmetica +100, impossibile usare Colpo e impossibile ottenere Aliemus."
  },
  State_22210_Name = {
    Text = "Super Stagnazione"
  },
  State_22238_Name = {
    Text = "Duello all'Ultimo Sangue tra Giocatori"
  },
  State_22239_Name = {
    Text = "Attiva Duello all'Ultimo Sangue tra Giocatori"
  },
  State_22249_Desc = {
    Text = "All'Inizio del prossimo turno, pesca [Layer] carte in meno."
  },
  State_22249_Name = {
    Text = "Scambio Ineguale"
  },
  State_22300_Desc = {
    Text = "Questo \"Colpo\" non può essere giocato."
  },
  State_22300_Name = {
    Text = "Disarmo impedisce l'utilizzo delle carte Colpo."
  },
  State_22303_Desc = {
    Text = "Ogni volta che subisci Danno, una carta casuale In Mano ottiene uno stato Temporaneo di \"Stagnazione\". Dopo che lo Scudo del Personaggio viene distrutto, lo stato \"Scudo di Brina\" verrà rimosso."
  },
  State_22303_Name = {
    Text = "Scudo di Brina"
  },
  State_22324_Desc = {
    Text = "Per ogni accumulo, ottieni 1 attacco aggiuntivo in questo turno."
  },
  State_22324_Name = {
    Text = "Eco delle Onde Furiose"
  },
  State_22325_Desc = {
    Text = "Ogni volta che subisci un attacco, ottieni [StateArg1] FOR temporanea."
  },
  State_22325_Name = {
    Text = "Stirpe del Gigante"
  },
  State_22326_Desc = {
    Text = "Sei il bersaglio! Dopo aver giocato, la Guardia del Navigatore ottiene 1 accumulo di Follia Temporanea e rimuove il Marchio di Furia da questa Carta di Comando."
  },
  State_22326_Name = {
    Text = "<CardKeyWord:Marchio della Furia>"
  },
  State_22328_Desc = {
    Text = "Ogni volta che viene utilizzata una Carta di comando con \"Marchio di Furia\", aumenta il conteggio degli attacchi di 1 per questo turno."
  },
  State_22328_Name = {
    Text = "Eco delle Onde Furiose"
  },
  State_22334_Desc = {
    Text = "Ogni volta che una carta \"Colpo\" viene giocata, posiziona [StateArg1] \"Ferite\" in cima al Mazzo di Pesca."
  },
  State_22334_Name = {Text = "Trauma"},
  State_22404_Desc = {
    Text = "Lo Scudo del Personaggio generato in questa battaglia è aumentato di [Layer]."
  },
  State_22404_Name = {Text = "Allerta"},
  State_22405_Desc = {
    Text = "Aumenta la generazione di Scudo del Personaggio in questa battaglia."
  },
  State_22405_Name = {
    Text = "<PVPAlertKeywords:Allerta>"
  },
  State_22702_Desc = {
    Text = "La prima \"Carta\" giocata ogni turno innesca un Effetto aggiuntivo."
  },
  State_22702_Name = {
    Text = "<CardKeyWord:Imboscata>"
  },
  State_22706_Name = {
    Text = "Marchio d'Assalto"
  },
  State_22707_Desc = {
    Text = "Dopo ogni turno in cui giochi carte, ti contrassegna con uno Stato di Imboscata."
  },
  State_22707_Name = {
    Text = "Innesco Imboscata"
  },
  State_22721_Name = {
    Text = "Cronopendolo \"Intervallo\""
  },
  State_23405_Desc = {
    Text = "Questo Risvegliatore non è ancora Non Risvegliato... Si Risveglierà quando starà per essere sconfitto, otterrà FOR pari agli accumuli attuali del Contatore, ripristinerà i PV e combatterà con tutta la sua potenza."
  },
  State_23405_Name = {
    Text = "Non Risvegliato"
  },
  State_23406_Desc = {
    Text = "\"Abitante dell'Abisso\" ottiene [StateArg1] cariche di Contatore alla fine di ogni turno."
  },
  State_23406_Name = {
    Text = "Caecus Risveglio!"
  },
  State_23512_Name = {
    Text = "Concedi Miraggio dai Mille Volti"
  },
  State_23514_Name = {
    Text = "Concedi Miraggio dai Mille Volti"
  },
  State_23515_Name = {
    Text = "Concedi Miraggio dai Mille Volti"
  },
  State_23516_Name = {
    Text = "Concedi Miraggio dai Mille Volti"
  },
  State_23517_Name = {
    Text = "Concedi al giocatore il BUFF"
  },
  State_23518_Desc = {
    Text = "Applica 2 turni di Vulnerabile / Attacca 1 volta in più / Applica FOR▼"
  },
  State_23518_Name = {
    Text = "<CardKeyWord:Selezione dell'Intento>"
  },
  State_23519_Name = {
    Text = "Intenzione 2b"
  },
  State_23520_Name = {
    Text = "Intenzione 2c"
  },
  State_23521_Name = {
    Text = "Allo scarto, Esaurisci e l'Aliemus di tutti i Risvegliatori diminuisce di [StateArg1]. Mescola 5 Carte \"Sintomo\" nel Mazzo di Pesca."
  },
  State_23522_Name = {
    Text = "Allo scarto, Esaurisci e l'Aliemus di tutti i Risvegliatori diminuisce di [StateArg1]."
  },
  State_23524_Name = {
    Text = "Intenzione 3a"
  },
  State_23525_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_23525_Name = {
    Text = "Non Risvegliato"
  },
  State_23526_Name = {
    Text = "Intenzione 2a"
  },
  State_23527_Name = {
    Text = "Intenzione 3c"
  },
  State_23528_Name = {
    Text = "Intenzione 3b"
  },
  State_23529_Desc = {
    Text = "Aumenta la Forza / Infliggi Danno extra / Ottieni Scudo del Personaggio"
  },
  State_23529_Name = {
    Text = "<CardKeyWord:Selezione dell'Intento>"
  },
  State_23530_Desc = {
    Text = "Usare \"Mille miraggi\" richiede due scelte di intenzione. Se scartata, tutti i Risvegliatori perdono 20 Aliemus e 5 carte \"Sintomo\" vengono mischiate nel tuo Mazzo di Pesca."
  },
  State_23530_Name = {
    Text = "Daffodil, Risvegliati!"
  },
  State_23531_Name = {
    Text = "Concedi Miraggio dai Mille Volti"
  },
  State_23532_Name = {
    Text = "Concedi Miraggio dai Mille Volti"
  },
  State_23533_Desc = {
    Text = "Infliggi Carta sintomo / Applica Salasso / Riduci Aliemus"
  },
  State_23533_Name = {
    Text = "<CardKeyWord:Selezione dell'Intento>"
  },
  State_23534_Name = {
    Text = "Intenzione 1a"
  },
  State_23535_Name = {
    Text = "Intenzione 1c"
  },
  State_23536_Name = {
    Text = "Intenzione 1b"
  },
  State_23612_Desc = {
    Text = "Diminuisce di 1 carica ogni volta che si perde 1 PV. Quando il numero di cariche si riduce a 0, l'intenzione si trasforma in un'Esaltazione ad alto Danno e rimuove l'effetto Pietrificare."
  },
  State_23612_Name = {
    Text = "Frenesia del Sangue: Finale"
  },
  State_23687_Name = {
    Text = "Pendolo crono \"maree\""
  },
  State_23726_Desc = {
    Text = "Impedisce al Risvegliato di morire una volta prima del prossimo turno, fino a 1 accumulo."
  },
  State_23726_Name = {Text = "Resistenza"},
  State_23732_Desc = {
    Text = "Fino all'inizio del prossimo turno, guadagna [Layer] <plural value=\"[Layer]\" singular=\"accumulo\" plural=\"accumuli\"> di <PainWord:Sopportare> per ogni istanza di Danno attivo subito."
  },
  State_23732_Name = {
    Text = "Palude proibita"
  },
  State_23736_Name = {
    Text = "Carte pescate in questo turno"
  },
  State_23737_Name = {
    Text = "Registro Conteggio Pesca"
  },
  State_23741_Name = {
    Text = "Applica registro di pescata"
  },
  State_23744_Desc = {
    Text = "Se non ci sono \"Morti\" sul campo, richiama 1 \"Morto\" all'inizio del turno; i PV aumenteranno a ogni richiamo."
  },
  State_23744_Name = {
    Text = "Evocazione dei Morti"
  },
  State_23747_Name = {
    Text = "Potenzia PV"
  },
  State_23748_Name = {
    Text = "Conteggio Evocazioni"
  },
  State_23769_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_23769_Name = {
    Text = "Non Risvegliato"
  },
  State_23771_Desc = {
    Text = "\"L'Arcanista\" è stata Risvegliata. Attenzione ai cloni creati dal suo \"Fantasma\". Per ogni carta giocata dall'avversario dopo il suo Risveglio, Casiah ottiene 1 accumulo di \"Fantasma\"."
  },
  State_23771_Name = {
    Text = "Casiah si Risveglia!"
  },
  State_23771_WeaponDesc = {
    Text = "A inizio del turno successivo, ottieni Scudo del Personaggio pari alla quantità di HP persi nel turno precedente."
  },
  State_23782_Desc = {
    Text = "Dopo aver ottenuto 10 accumuli di Fantasma, azzera il conteggio degli accumuli di \"Fantasma\" e richiama 1 fantasma davanti, con un massimo di 2 fantasmi esistenti. Il fantasma avrà 3 accumuli di <ParcloseIconKeywords:Barriera> al momento del richiamo."
  },
  State_23782_Name = {Text = "Fantasma"},
  State_23786_Name = {
    Text = "Stato@Risvegliatore Casiah Telecinesi"
  },
  State_23787_Name = {
    Text = "Stato@Risvegliatore Casiah@Telecinesi@Riduzione Pesca"
  },
  State_23788_Desc = {
    Text = "All'inizio del turno 3, aggiungi 1 carta \"Echi del Passato—Scarta tutte le carte, ripristina HP attuali e Scudo allo stato della fine del turno precedente. Conserva, Esaurisci.\" alla tua mano."
  },
  State_23791_Name = {
    Text = "Suggerimento d'Apertura"
  },
  State_23823_Name = {Text = "Bomba 1"},
  State_23825_Name = {
    Text = "Stato@Risvegliatore Casiah@Poof"
  },
  State_23827_Desc = {
    Text = "Dopo averla giocata, perdi [DescArg1] HP massimi. Il grande mago ottiene 1 accumulo di \"Ego Boost\" in questo turno."
  },
  State_23827_Name = {
    Text = "<CardCheerKeywords:Applausi>"
  },
  State_23828_Desc = {
    Text = "La grande maga si sta godendo appieno la sua esibizione. Per ogni carica di \"Esaltazione dell'Ego\", l'effetto Abilità e la FOR delle sue abilità sono ridotti di [DescArg1], fino a un massimo di 5 cariche."
  },
  State_23828_Name = {
    Text = "Esaltazione dell'Ego"
  },
  State_23871_Desc = {
    Text = "Aumentare i PV massimi non ripristina i PV attuali. Ridurre i PV massimi rimuove comunque i PV attuali in eccesso. I PV massimi modificati hanno un minimo di 1 e non si ripristinano alla morte."
  },
  State_23871_Name = {
    Text = "<MaxHPColour:PV Max>"
  },
  State_23934_Name = {
    Text = "Stato@Monitor Carte Mano Telecinesi"
  },
  State_23935_Name = {
    Text = "Stato@Risvegliatore Casiah@Telecinesi Attiva"
  },
  State_2393_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_2393_Name = {
    Text = "Non Risvegliato"
  },
  State_2394_Name = {
    Text = "Potenziamento Illuminare Forza Scarlatta"
  },
  State_2395_Name = {
    Text = "Accessorio: Banchetto del Distante"
  },
  State_2395_WeaponDesc = {
    Text = "\"Difesa\" aumenta lo scudo del 30%. Se il portatore possiede più del 15% di Bottino di Sigilli, \"Difesa\" conferisce un ulteriore 30% di scudo."
  },
  State_2396_Desc = {
    Text = "Danno Crit. +20%. Colpo Critico garantito contro i nemici con Scudo del Personaggio."
  },
  State_2398_Desc = {
    Text = "Subire Danno conferisce [Layer] Scudo del Personaggio, che aumenta con ogni colpo e si ripristina a fine turno."
  },
  State_2398_Name = {
    Text = "Barriera Dimensionale"
  },
  State_2398_WeaponDesc = {
    Text = "Il Danno attivo subito è aumentato di [Layer]. Ogni volta che si subiscono DAN, la Ferita da Dissoluzione si espande e si riassorbe all'inizio del Turno."
  },
  State_2399_Desc = {
    Text = "Dopo aver ripristinato PV, tutti i Risvegliati ottengono 3 Aliemus. Ogni 5 ripristini di PV, il Danno dell'Esaltazione aumenta di [Arg1] per questa battaglia."
  },
  State_2400_Desc = {
    Text = "Limite Tentacoli aumentato di 1. Quando i PV sono inferiori al 50%, il danno dei Tentacoli aumenta di [StateArg1]."
  },
  State_2400_Name = {
    Text = "Creazione Reliquia del Passato"
  },
  State_2400_WeaponDesc = {
    Text = "Limite Tentacoli aumentato di 1. Quando i PV sono inferiori al 50%, il danno dei Tentacoli aumenta di [StateArg1]."
  },
  State_2401_Desc = {
    Text = "Aggiungi la carta in cima alla Pila degli scarti alla tua mano all'inizio del turno."
  },
  State_2402_Desc = {
    Text = "A inizio turno, ottieni [Arg1] FOR temporanea per ogni Carta nello Spazio Ultra in questo turno."
  },
  State_2403_Desc = {
    Text = "La generazione di Scudo del Personaggio è aumentata di [Layer] in questa Battaglia."
  },
  State_2403_Name = {Text = "Allerta"},
  State_2403_WeaponDesc = {
    Text = "La generazione di Scudo del Personaggio è aumentata di [Layer] in questa Battaglia."
  },
  State_2404_Desc = {
    Text = "Rimuovi 1 Carta Sintomo al momento della raccolta. Il Tasso di Orison Fortunato aumenta del 50%."
  },
  State_2405_Desc = {
    Text = "Modifica temporaneamente l'Arithmetica della carta"
  },
  State_2405_Name = {
    Text = "Modifica temporaneamente l'Arithmetica della carta"
  },
  State_2405_WeaponDesc = {
    Text = "Modifica temporaneamente l'Arithmetica della carta"
  },
  State_2406_Desc = {
    Text = "Quando esaurisci l'ultimo 1 Arithmetica, ottieni 2 Arithmetica. Massimo 2 attivazioni per turno."
  },
  State_2407_Name = {
    Text = "Valori di Osservazione"
  },
  State_2408_Name = {
    Text = "Fischietto del marinaio"
  },
  State_2409_Desc = {
    Text = "In questo turno, ogni carta [Strike] giocata riduce il Costo di Arithmetica di 1."
  },
  State_2409_Name = {
    Text = "Lama della Sfida"
  },
  State_2409_WeaponDesc = {
    Text = "In questo turno, ogni carta [Strike] giocata riduce il Costo di Arithmetica di 1."
  },
  State_2410_Desc = {
    Text = "Non può agire per 1 turno. I nemici pietrificati non possono essere pietrificati di nuovo."
  },
  State_2410_Name = {
    Text = "<PetrifactionIconKeywords:Pietrificare>"
  },
  State_2410_WeaponDesc = {
    Text = "Stordisci il Mostro per un turno."
  },
  State_2411_Desc = {
    Text = "A fine turno, applica [Layer] accumuli di Sanguinamento alla tua squadra."
  },
  State_2411_Name = {
    Text = "Lume di Sangue"
  },
  State_2411_WeaponDesc = {
    Text = "A fine turno, applica [Layer] accumuli di Sanguinamento alla tua squadra."
  },
  State_2412_Desc = {
    Text = "Raddoppia i danni inflitti nel turno successivo."
  },
  State_2412_Name = {
    Text = "Impasse Sopravvissuta"
  },
  State_2412_WeaponDesc = {
    Text = "Raddoppia i danni inflitti nel turno successivo."
  },
  State_2413_Desc = {
    Text = "L'Aliemus ottenuto da Colpo e Difesa è ridotto del [Layer] %."
  },
  State_2413_Name = {Text = "Vuoto"},
  State_2413_WeaponDesc = {
    Text = "Ottieni [StateArg1]% di Aliemus da Colpo e Difesa."
  },
  State_2415_Desc = {
    Text = "Se hai subito DAN l'ultimo turno, ottieni immunità per 1 turno all'inizio di questo turno."
  },
  State_2415_Name = {
    Text = "Adattamento"
  },
  State_2415_WeaponDesc = {
    Text = "Se hai subito DAN l'ultimo turno, ottieni immunità per 1 turno all'inizio di questo turno."
  },
  State_2416_Desc = {
    Text = "I PV e il Danno dei Mostri che evoca sono raddoppiati."
  },
  State_2416_Name = {
    Text = "\"Mondo della Scultura di Cera\""
  },
  State_2416_WeaponDesc = {
    Text = "I PV e il Danno dei Mostri che evoca sono raddoppiati."
  },
  State_24174_Desc = {
    Text = "Questo Risvegliato non vedrà i propri PV scendere sotto 1 a causa del Danno."
  },
  State_24174_Name = {
    Text = "Immunità alla Morte"
  },
  State_2418_Desc = {
    Text = "[Exalt] conferisce 30 Aliemus."
  },
  State_2418_Name = {
    Text = "Velo del Dio Alienato"
  },
  State_2418_WeaponDesc = {
    Text = "[Exalt] conferisce 30 Aliemus."
  },
  State_2419_Name = {
    Text = "Reliquia Specchio Bianco"
  },
  State_2420_Desc = {
    Text = "In questo turno, ogni carta [Defense] giocata riduce il Costo di Arithmetica di 1."
  },
  State_2420_Name = {
    Text = "Lama di Precisione"
  },
  State_2420_WeaponDesc = {
    Text = "In questo turno, ogni carta [Defense] giocata riduce il Costo di Arithmetica di 1."
  },
  State_24210_Desc = {
    Text = "In questo turno, l'Attacco del tentacolo del Re Divino colpisce tutti i nemici"
  },
  State_24210_Name = {
    Text = "Arto del Regno Divino: Decreto"
  },
  State_24211_Desc = {
    Text = "\nAlla fine del turno, infligge [DescArg4] istanze di [DescArg2] DAN ai nemici in prima fila. Se un nemico viene ucciso, il DAN aumenta di [DescArg3] punti, fino a 5 volte (attualmente [DescArg6] volte).\nOgni volta che il Risvegliato usa Esaltazione, un attacco aggiuntivo verrà attivato in questo turno.\nDopo che il Custode usa Seguito, il bersaglio dell'attacco per questo turno cambia in tutti i nemici. Se si tratta di una Battaglia Boss, il DAN inflitto dall'\"Arto del Regno Divino\" riceve anche +[DescArg5] punti."
  },
  State_24211_Name = {
    Text = "Arto Divino"
  },
  State_24213_Name = {
    Text = "Se questa carta è nella tua mano, ottieni 150 Keyflare alla fine del turno."
  },
  State_24214_Desc = {
    Text = "A fine turno, infliggi [DescArg2] DAN ai nemici in prima fila."
  },
  State_24214_Name = {
    Text = "Arto Divino"
  },
  State_24215_Desc = {
    Text = "A fine turno, infliggi [DescArg2] DAN ai nemici in prima fila. Se un nemico viene ucciso, aumenta questo DAN di [DescArg3], fino a 5 volte (attualmente [DescArg4] volte)."
  },
  State_24215_Name = {
    Text = "Arto Divino"
  },
  State_24217_Name = {
    Text = "Dissolvi gli stati di <VulnerabilityIconKeywords:Vulnerabile>, <WeaknessIconKeywords:Debolezza> e <FragileIconKeywords:Fragile> da te stesso"
  },
  State_24220_Name = {
    Text = "Ottieni [DescArg1] Punti Scudo"
  },
  State_24222_Desc = {
    Text = [[
Alla fine del turno, infligge [DescArg4] istanze di [DescArg2] DAN ai nemici in prima fila. Se un nemico viene ucciso, il DAN aumenta di [DescArg3] punti, fino a 5 volte (attualmente [DescArg5] volte).
Ogni volta che un Risvegliato usa Esaltazione, esegue un attacco aggiuntivo in questo turno.
Ogni volta che un Custode usa Seguito in questo turno, l'attacco colpisce tutti i nemici.]]
  },
  State_24222_Name = {
    Text = "Arto Divino"
  },
  State_24223_Desc = {
    Text = [[
A fine turno, infliggi [DescArg2] DAN ai nemici in prima fila. Se un nemico viene ucciso, aumenta questo DAN di [DescArg3], fino a 5 volte (attualmente [DescArg4] volte).
Ogni volta che il Custode usa il Seguito, cambia il bersaglio degli attacchi di questo turno a tutti i nemici.]]
  },
  State_24223_Name = {
    Text = "Arto Divino"
  },
  State_24224_Desc = {
    Text = [[
Dopo ogni turno, infliggi [DescArg4] colpi da [DescArg2] DAN ai nemici in prima fila. Se un nemico viene ucciso, il DAN aumenta di [DescArg3] punti, fino a 5 volte (attualmente [DescArg5] volte).
Ogni volta che un Risvegliatore esegue un'Esaltazione in questo turno, effettua un attacco aggiuntivo.]]
  },
  State_24224_Name = {
    Text = "Arto Divino"
  },
  State_24226_Desc = {
    Text = "\nAlla fine del turno, infligge [DescArg4] istanze di [DescArg2] DAN ai nemici in prima fila. Se un nemico viene ucciso, il DAN aumenta di [DescArg3] punti, fino a 5 volte (attualmente [DescArg6] volte).\nOgni volta che il Risvegliato usa Esaltazione, un attacco aggiuntivo verrà attivato in questo turno.\nIn una Battaglia Boss, ogni volta che il Custode usa Seguito, il DAN dell'\"Arto del Regno Divino\" aumenta di [DescArg5] punti."
  },
  State_24226_Name = {
    Text = "Arto Divino"
  },
  State_24227_Desc = {
    Text = [[

Alla fine del turno, infligge [DescArg2] DAN ai nemici in prima fila. Se un nemico viene ucciso, il DAN aumenta di [DescArg3] punti, fino a 5 volte (attualmente [DescArg5] volte).
Dopo che il Custode usa Seguito, il bersaglio dell'attacco per questo turno cambia in tutti i nemici. Se si tratta di una Battaglia Boss, il DAN inflitto dall'"Arto del Regno Divino" riceve anche +[DescArg4] punti.]]
  },
  State_24227_Name = {
    Text = "Arto Divino"
  },
  State_2422_Desc = {
    Text = "Quando giocata, ottieni <Block:[StateArg1]> Scudo del Personaggio."
  },
  State_2422_Name = {
    Text = "<Rune_6:Bastione>"
  },
  State_24245_Desc = {
    Text = "A fine turno, rianima tutti i consanguinei di \"Hydra\". Ogni volta che un consanguineo muore, riduci di 1 accumulo; se gli accumuli raggiungono 0,\"Hydra\" si trasformerà per la battaglia finale."
  },
  State_24245_Name = {
    Text = "Manipolazione dei Serpenti"
  },
  State_24247_Desc = {
    Text = "I danni subiti sono ridotti del 90%. Se all'inizio del turno non ci sono cariche di \"Manipolazione dei Serpenti\", rimuovi questo stato."
  },
  State_24247_Name = {
    Text = "Barriera Serpentina"
  },
  State_2425_Desc = {
    Text = "Quando giocata, Esaurimento. Se è una Carta di comando, il suo Danno e la sua Difesa vengono aumentati di 2 volte."
  },
  State_2425_Name = {
    Text = "<CardKeyWord:Dissoluzione>"
  },
  State_2426_Desc = {
    Text = "La prima carta giocata ogni turno si attiva un'ulteriore volta, ma puoi giocare fino a 4 carte per turno."
  },
  State_2427_Name = {
    Text = "Stato@Chiave d'argento dell'Illusione: Contrattacco Cuore dell'Abisso di Sangue"
  },
  State_2428_Desc = {
    Text = "Il numero di <ParcloseIconKeywords:Barriere> del Fiore del Male aumenta di [Layer] livelli."
  },
  State_2428_Name = {
    Text = "Barriera di rancore"
  },
  State_2428_WeaponDesc = {
    Text = "La quantità di Barriere Fiore del Male è aumentata di [Layer] accumuli."
  },
  State_24292_Name = {
    Text = "Retroguardia Avanti"
  },
  State_24293_Name = {
    Text = "Retrocessione Prima Fila"
  },
  State_2429_Desc = {
    Text = "Tutti i Danni inflitti sono ridotti del [Layer]%."
  },
  State_2429_Name = {
    Text = "Riduzione DAN Temporanea"
  },
  State_2429_WeaponDesc = {
    Text = "Tutti i Danni inflitti sono ridotti del [Layer]%."
  },
  State_2430_Desc = {
    Text = "A inizio battaglia, tutti gli alleati ottengono 3 accumuli di [Waxed Armor]. A fine turno, infligge [Arg1] accumuli di Sanguinamento alla tua squadra."
  },
  State_2430_Name = {
    Text = "\"Gentiluomo di Cera\""
  },
  State_2430_WeaponDesc = {
    Text = "A inizio battaglia, tutti gli alleati ottengono 3 accumuli di [Waxed Armor]. A fine turno, infligge [Arg1] accumuli di Sanguinamento alla tua squadra."
  },
  State_2431_Desc = {
    Text = "Unico per Squadra: Lo Scudo e il Recupero PV del portatore aumentano del <WeaponEffect_Num:[StateArg1]%> della sua COS. Il Contrattacco inflitto dal portatore +<WeaponEffect_Num:[StateArg3]%>. Dopo aver giocato \"Difesa\", ottieni <WeaponEffect_Num:Contrattacco> pari a <RetaliateIconKeywords:[StateArg4]%> della sua DIF. All'inizio della battaglia, ottieni <WeaponEffect_Num:FOR> pari a <PowerIconKeywords:[StateArg2]%> della sua COS. Se il reame attuale è \"Aequor\", ottieni Danno Tentacolo aggiuntivo dello stesso ammontare."
  },
  State_2431_WeaponDesc = {
    Text = "La Generazione di Scudo del Personaggio e il Recupero PV aumentano di <WeaponEffect_Num:[DescArg1]>. Il Contatore del Portatore aumenta di <WeaponEffect_Num:[StateArg3]>. Dopo aver giocato \"Difesa\", ottieni <WeaponEffect_Num:[Counterattack:DescArg3]> accumuli di <RetaliateIconKeywords:Contatore>. All'inizio della battaglia, ottieni <WeaponEffect_Num:[Power:DescArg2]> <PowerIconKeywords:FOR>. Se il Reame corrente è \"Aequor\", ottieni DAN del Tentacolo aggiuntivo dello stesso ammontare."
  },
  State_2432_Desc = {
    Text = "Danno attivo e Danni da tentacolo subiti +50%, rimuovi 1 accumulo al termine del turno."
  },
  State_2432_Name = {
    Text = "<VulnerabilityIconKeywords:Vulnerabile>"
  },
  State_2432_WeaponDesc = {
    Text = "Tutti i Danni subiti sono aumentati del 50%."
  },
  State_2433_Desc = {
    Text = "Ottieni [Layer] FOR alla fine di ogni turno."
  },
  State_2433_Name = {Text = "Ira"},
  State_2434_Name = {
    Text = "Accessorio: Anello della Stanza 36"
  },
  State_2434_WeaponDesc = {
    Text = "Quando la carta del Portatore viene pescata, la sua Arithmetica cambia casualmente tra 0 e 3."
  },
  State_2435_Desc = {
    Text = "Evento 19_2"
  },
  State_2435_Name = {
    Text = "Evento 19_2"
  },
  State_2435_WeaponDesc = {
    Text = "Evento 19_2"
  },
  State_2436_Desc = {
    Text = "La Forza e lo Scudo del Personaggio ottenuti sono ridotti del 50% per [Layer] turni."
  },
  State_2436_Name = {
    Text = "Maledizione Temporanea"
  },
  State_2436_WeaponDesc = {
    Text = "Prima della fine del tuo turno, Immune agli effetti di potenziamento applicati a sé."
  },
  State_2437_Desc = {Text = "—"},
  State_2437_WeaponDesc = {Text = "—"},
  State_2438_Desc = {
    Text = "Stato@Conteggio Reliquia Argento Motore Differenziale"
  },
  State_2438_Name = {
    Text = "Stato@Conteggio Reliquia Argento Motore Differenziale"
  },
  State_2438_WeaponDesc = {
    Text = "Stato@Conteggio Reliquia Argento Motore Differenziale"
  },
  State_2440_Name = {
    Text = "Pesca 1 carta."
  },
  State_2441_Name = {
    Text = "Ottieni 1 Arithmetica."
  },
  State_2442_Name = {
    Text = "Infliggi <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici per 1 pila"
  },
  State_2443_Name = {
    Text = "Infliggi <WeaknessIconKeywords:Debolezza> a tutti i nemici per 1 accumulo"
  },
  State_2444_Name = {
    Text = "Ottieni <Energy:[DescArg1]> Aliemus"
  },
  State_2445_Name = {
    Text = "Gli altri Risvegliatori ottengono <Energy:[DescArg1]> Aliemus"
  },
  State_2446_Name = {
    Text = "Aggiungi 1 <DerivativeCardKeywords_4:\"Intuizione\"> al tuo Mazzo di pesca."
  },
  State_2447_Desc = {
    Text = "Unico per Squadra: Il Tasso di Crit. e il Danno Crit. delle Carte di comando, la Generazione di Scudo del Personaggio, il Recupero PV, l'Aliemus e la Forza del Portatore aumentano di <WeaponEffect_Num:[StateArg1]%>. Se il reame corrente è \"Ultra\", ottieni <WeaponEffect_Num:[StateArg2]> Keyflare dopo aver rilasciato \"Annientamento\". Dopo essere entrati nel Turno Ultra, la prossima Squadra viene rilasciata due volte in questo turno."
  },
  State_2447_WeaponDesc = {
    Text = "Il Tasso Crit. e il Danno Crit. delle Carte di Comando, la Generazione di Scudo del Personaggio, il Recupero PV, l'Aliemus e la Forza del Portatore aumentano del <WeaponEffect_Num:[StateArg1]%>. Se il reame attuale è \"Ultra\", ottieni <WeaponEffect_Num:[StateArg2]> Keyflare dopo aver rilasciato \"Annientamento\". Dopo essere entrato nel Turno Ultra, il prossimo Seguito viene rilasciato due volte in questo turno."
  },
  State_2448_Desc = {
    Text = "La carta non entra nella Pila degli scarti, ma rimane In Mano."
  },
  State_2448_Name = {
    Text = "<CardKeyWord:Conserva>"
  },
  State_2449_Desc = {
    Text = "Ottieni [Layer] Scudo del Personaggio dopo aver subito Danno effettivo."
  },
  State_2449_Name = {Text = "Riserva"},
  State_2449_WeaponDesc = {
    Text = "Ottieni [Layer] Scudo del Personaggio dopo aver subito Danno effettivo."
  },
  State_2450_Desc = {
    Text = "\"Colpo\" garantisce un Colpo Critico. Danno Crit. aumentato del 50%."
  },
  State_2451_Desc = {
    Text = "A fine turno, gli altri alleati ottengono [Layer] FOR."
  },
  State_2451_Name = {
    Text = "\"Fiamma dell'Illuminazione\""
  },
  State_2452_Desc = {
    Text = "Quando giocata, ottieni [StateArg1] <PowerIconKeywords:FOR> dopo la risoluzione dei suoi effetti."
  },
  State_2452_Name = {
    Text = "<Rune_14_High:Potenza Avanzata>"
  },
  State_2453_Name = {
    Text = "Accessorio: Rituale di Fotosintesi"
  },
  State_2453_WeaponDesc = {
    Text = "All'inizio della battaglia, tutte le carte del Portatore ottengono Conservare."
  },
  State_2454_Desc = {
    Text = "Dopo essere stata giocata, questa carta viene rimossa dal mazzo anziché entrare nella Pila degli scarti."
  },
  State_2454_Name = {
    Text = "<DepleteIconKeywords:Consumo>"
  },
  State_2454_WeaponDesc = {
    Text = "Dopo essere stata giocata, la carta non finirà nella Pila degli scarti e non potrà essere usata di nuovo in questa Battaglia."
  },
  State_24556_Name = {
    Text = "Stato@Gran Mago Houdini@Applausi Pubblico Fortunato Aggiunti"
  },
  State_2455_Name = {
    Text = "Stato @ Danzatrice Fiamma Blu Illuminare 7"
  },
  State_24560_Desc = {
    Text = "Ogni volta che utilizzi un Gruppo, Ramona: Logorata dal tempo ottiene un aumento Temporaneo del 25% di Tasso Crit. e Danno Crit."
  },
  State_24560_Name = {
    Text = "Viaggiatore della Bottiglia di Klein"
  },
  State_24562_Desc = {
    Text = "Ottieni 1 accumulo di Negentropia alla fine del turno."
  },
  State_24562_Name = {
    Text = "Pellegrino di Penrose"
  },
  State_24564_Desc = {
    Text = "Con 3 cariche di Negentropia, l'uso delle Carte di comando di Ramona: Logora consuma tutte le cariche e attiva l'effetto extra Ciclo. (Max 3 cariche)"
  },
  State_24564_Name = {
    Text = "Negentropia"
  },
  State_2456_Name = {
    Text = "Stato @ Danzatrice della Fiamma Blu Illuminare 15"
  },
  State_2457_Name = {
    Text = "Pesca 1 carta."
  },
  State_24584_Name = {
    Text = "Stato@Clone di N@Cambio Stato Sussurro1"
  },
  State_2458_Name = {
    Text = "Stato@Conteggio Effetto Accessorio Abbraccio Cremisi"
  },
  State_24593_Desc = {
    Text = "Quando il numero di accumuli è 0, cambia l'Intenzione in \"Evocazione Nera\". A fine turno, diminuisce di 1 accumulo, con un massimo di 4 accumuli."
  },
  State_24593_Name = {Text = "Caos"},
  State_24595_Desc = {
    Text = "Alla morte, riduci immediatamente \"N\" di 1 accumulo di \"Caos\"."
  },
  State_24595_Name = {Text = "Diffusione"},
  State_24596_Desc = {
    Text = "Quando si evoca un clone di \"N\", evoca un clone aggiuntivo per ogni accumulo di \"Oscurità\"."
  },
  State_24596_Name = {Text = "Oscurità"},
  State_2460_Desc = {
    Text = "Unico per Squadra: il DAN Base, il <IntoxicationIconKeywords:Veleno> e il <RetaliateIconKeywords:Contatore> del Portatore sono aumentati del <WeaponEffect_Num:[StateArg1]%>. Tasso di Crit. e Danno Crit. sono aumentati del <WeaponEffect_Num:[StateArg2]%>."
  },
  State_2460_WeaponDesc = {
    Text = "Il DAN Base, il <IntoxicationIconKeywords:Veleno> e il <RetaliateIconKeywords:Contatore> del portatore sono aumentati di <WeaponEffect_Num:[StateArg1]%>. Il Tasso Crit. e il Danno Crit. sono aumentati di <WeaponEffect_Num:[StateArg2]%>."
  },
  State_2461_Desc = {
    Text = "In questa battaglia, quando si ricevono danni fatali, risorgi, recuperi [Layer] PV e concedi a tutti i Risvegliatori [StateArg1] Aliemus. Questo effetto non può essere dissolto."
  },
  State_2461_Name = {
    Text = "Uccello del paradiso immortale"
  },
  State_2463_Desc = {
    Text = "A inizio battaglia, Fusione Embrionale +20%. Per ogni Risvegliatore con Aliemus al massimo, la Fusione Embrionale aumenta di un ulteriore +20%."
  },
  State_24640_Desc = {
    Text = "All'inizio del combattimento, Fusione Embrionale +[Blood:DescArg1]; ogni volta che si attiva la Resistenza, Fusione Embrionale +[Blood:DescArg1]. Ogni volta che Sorel infligge Danno, l'Aumento DAN inflitto da sé stessa in questo turno aumenta di un valore pari al 4% dell'ATT."
  },
  State_24640_Name = {
    Text = "Gioiello della corona"
  },
  State_2464_Desc = {
    Text = "Aumento Arithmetica Carta"
  },
  State_2464_Name = {
    Text = "Aumento Permanente Arithmetica Carta"
  },
  State_2464_WeaponDesc = {
    Text = "Aumento Arithmetica Carta"
  },
  State_24654_Desc = {
    Text = "Daffodil aumenta permanentemente il Tasso di Critico della squadra del 5% ogni volta che uccide un nemico, accumulabile fino a 5 volte in questa run. (Accumuli attuali: [DescArg1])"
  },
  State_24654_Name = {
    Text = "Nebbia dell'avidità"
  },
  State_2466_Desc = {
    Text = "Fino all'inizio del prossimo turno, per ogni istanza di DAN subito, il Tentacolo contrattacca l'attaccante una volta. DAN Tentacolo temporanei +[Layer]."
  },
  State_2466_Name = {
    Text = "Stirpe dell'Eresia"
  },
  State_24678_Name = {
    Text = "Stato@Clone di N@Cambio Stato Sussurro2"
  },
  State_24679_Name = {
    Text = "Stato@Clone di N 3@Cambio Stato Sussurro 6"
  },
  State_2467_Desc = {
    Text = "Stato@Prologo Analisi Offensiva"
  },
  State_2467_Name = {
    Text = "Stato@Prologo Analisi Offensiva"
  },
  State_2467_WeaponDesc = {
    Text = "Stato@Prologo Analisi Offensiva"
  },
  State_24680_Name = {
    Text = "Stato@Clone 2 di N@Cambio Stato Sussurro 1"
  },
  State_24681_Name = {
    Text = "Stato@Clone di N@Cambio Stato Sussurro6"
  },
  State_24682_Name = {
    Text = "Stato@Clone di N 3@Cambio Stato Sussurro 3"
  },
  State_24683_Name = {
    Text = "Stato@Clone 2 di N@Cambio Stato Sussurro 2"
  },
  State_24684_Name = {
    Text = "Stato@Clone di N@Cambio Stato Sussurro4"
  },
  State_24685_Name = {
    Text = "Stato@Clone di N@Cambio Stato Sussurro5"
  },
  State_24686_Name = {
    Text = "Stato@Clone di N 3@Cambio Stato Sussurro 5"
  },
  State_24687_Name = {
    Text = "Stato@Clone di N 3@Cambio Stato Sussurro 2"
  },
  State_24688_Name = {
    Text = "Stato@Clone di N 2@Cambio Stato Sussurro 6"
  },
  State_24689_Name = {
    Text = "Stato@Clone di N 3@Cambio Stato Sussurro 4"
  },
  State_24690_Name = {
    Text = "Stato@Clone di N 3@Cambio Stato Sussurro 1"
  },
  State_24691_Name = {
    Text = "Stato Clone@N2@Cambio Stato Sussurro 4"
  },
  State_24692_Name = {
    Text = "Stato@Clone di N 2@Cambio Stato Sussurro 3"
  },
  State_24693_Name = {
    Text = "Stato@Clone di N@Cambio Stato Sussurro3"
  },
  State_24694_Name = {
    Text = "Stato@Clone di N 2@Cambio Stato Sussurro 5"
  },
  State_2470_Desc = {
    Text = "Perdi permanentemente [Arg1] Allerta quando raccolto. Il Danno attivo ottiene un bonus di 1x FOR."
  },
  State_24719_Desc = {
    Text = "\"@2\" è disceso nella sua vera forma, con PV x3."
  },
  State_24719_Name = {
    Text = "Risveglio del Destino"
  },
  State_24719_WeaponDesc = {
    Text = "A inizio del turno successivo, ottieni Scudo del Personaggio pari alla quantità di HP persi nel turno precedente."
  },
  State_2471_Desc = {
    Text = "A inizio turno, riduci di 1 l'Allerta della tua squadra."
  },
  State_2471_Name = {Text = "Corrosione"},
  State_2471_WeaponDesc = {
    Text = "A inizio turno, riduci di 1 l'Allerta della tua squadra."
  },
  State_24720_Desc = {
    Text = "Questa entità sconosciuta si cela ancora sotto la Pozza nera. Si risveglierà completamente e rinascerà in prossimità della sconfitta, pronta a combattere nella sua forma liberata."
  },
  State_24720_Name = {Text = "Dormienza"},
  State_2472_Desc = {
    Text = "Il Danno riduce sia lo Scudo del Personaggio che i PV. Non può essere reso Immune."
  },
  State_2472_Name = {
    Text = "<PunctureDamagewords:Danni Perforanti>"
  },
  State_2472_WeaponDesc = {
    Text = "I Danni Perforanti ignorano lo Scudo del Personaggio del bersaglio, la riduzione dei Danni e il blocco, infliggendo Danno diretto."
  },
  State_24730_Desc = {
    Text = "Aumenta temporaneamente lo Spazio Ultra, fino a 10. Durante il prossimo Turno Ultra, le carte nello Spazio Ultra Temporaneo verranno aggiunte alla tua mano, e lo Spazio Ultra Temporaneo verrà rimosso."
  },
  State_24730_Name = {
    Text = "<CardKeyWord:Ultra Spazio temporaneo>"
  },
  State_24737_Desc = {
    Text = "A inizio turno, infliggi Salasso all'avversario. Ogni accumulo di destino causa [StateArg1] Salasso."
  },
  State_24737_Name = {Text = "Fato"},
  State_24738_Desc = {
    Text = "Ogni livello di Fato infligge [StateArg1] danni da Salasso quando è attivo; giocare una Carta riduce di un livello il Fato."
  },
  State_24738_Name = {Text = "Fato"},
  State_24739_Name = {Text = "Fato"},
  State_2473_Desc = {
    Text = "[Defense] Perde 1 Tentacolo, ripristina [StateArg1] PV. [Strike] Perde [StateArg2] PV, genera 1 Tentacolo."
  },
  State_2473_Name = {
    Text = "Reliquia Carne dell'Immortale"
  },
  State_2473_WeaponDesc = {
    Text = "[Defense] Perde 1 Tentacolo, ripristina [StateArg1] PV. [Strike] Perde [StateArg2] PV, genera 1 Tentacolo."
  },
  State_2474_Desc = {
    Text = "Aumenta l'Attacco del [Layer]%"
  },
  State_2474_Name = {
    Text = "Aumenta l'Attacco generale di una percentuale"
  },
  State_2474_WeaponDesc = {
    Text = "Aumenta l'Attacco del [Layer]%"
  },
  State_2475_Desc = {
    Text = "Unico per Squadra: il Danno attivo del Portatore aumenta di un valore pari all'ATT del Portatore ×<WeaponEffect_Num:[StateArg3]%>. Dopo aver giocato o scartato 1 Carta di comando del Portatore, infligge una volta Danno pari all'ATT del Portatore ×<WeaponEffect_Num:[StateArg1]%> come <IntoxicationIconKeywords:Veleno> a un nemico casuale. Al termine del Turno Ultra, c'è una probabilità del <WeaponEffect_Num:[StateArg2]%> di attivare il 100% del Veleno su tutti i nemici."
  },
  State_2475_WeaponDesc = {
    Text = "Il Danno attivo del Portatore è aumentato di <WeaponEffect_Num:[DescArg2]> punti. Dopo aver giocato o scartato 1 Carta di comando del Portatore, infliggi <WeaponEffect_Num:[DescArg1]> accumuli di <IntoxicationIconKeywords:Veleno> a un nemico casuale. Quando il Turno Ultra termina, c'è una probabilità del <WeaponEffect_Num:[StateArg2]>% di infliggere [DescArg3]% di Veleno a tutti i nemici."
  },
  State_2476_Name = {
    Text = "Stato@Illuminare Veggente della Genesi 1"
  },
  State_2478_Desc = {
    Text = "Lo Scudo del Personaggio applicato da Nautilus è raddoppiato."
  },
  State_2478_Name = {
    Text = "Esperto di manutenzione"
  },
  State_2478_WeaponDesc = {
    Text = "Lo Scudo del Personaggio applicato da Nautilus è raddoppiato."
  },
  State_2479_Desc = {
    Text = "+1 accumulo per ogni istanza di Danno inflitta da Fuoco Smeraldo"
  },
  State_2479_Name = {
    Text = "Conteggio Riflesso di Smeraldo"
  },
  State_2479_WeaponDesc = {
    Text = "+1 accumulo per ogni istanza di Danno inflitta da Fuoco Smeraldo"
  },
  State_2480_Desc = {
    Text = "Ottieni [StateArg1] Contatore quando effettui una Guarigione. Abitante dell'Abisso ripristina 1 PV per ogni carta giocata."
  },
  State_2480_Name = {
    Text = "Corpo Metamorfosato"
  },
  State_2481_Desc = {
    Text = "Stato@Prologo Reset Mazzo 0_2_3_1"
  },
  State_2481_Name = {
    Text = "Stato@Prologo Reset Mazzo 0_2_3_1"
  },
  State_2481_WeaponDesc = {
    Text = "Stato@Prologo Reset Mazzo 0_2_3_1"
  },
  State_2482_Desc = {
    Text = "PV sotto il 50%: evoca 1 Triangolo di Dissoluzione con PV pari"
  },
  State_2482_Name = {Text = "Evocazione"},
  State_2482_WeaponDesc = {
    Text = "PV sotto il 50%: evoca 1 Triangolo di Dissoluzione con PV pari"
  },
  State_2486_Desc = {
    Text = "A inizio turno, ottieni 1 Arithmetica per ogni nemico. Quando un nemico viene sconfitto dal Danno attivo, infliggi il danno in eccesso come Salasso agli altri nemici."
  },
  State_24879_Desc = {
    Text = "Mille anni trascorsero, diecimila anni trascorsero, attesero in silenzio nell'eterna oscurità. Alla morte, riduci di 1 accumulo il \"Caos\" di \"N\" e concedi a \"N\" [DescArg1] Scudo e [DescArg2] Forza."
  },
  State_24879_Name = {
    Text = "Doppio Fantasma"
  },
  State_2488_Desc = {
    Text = "Quando giochi una Carta potenziamento, una Carta sintomo o una Carta di stato, il Risvegliato con l'Aliemus più basso guadagna 10 Aliemus."
  },
  State_2489_Desc = {
    Text = "Tasso di Crit. +10%. Dopo il primo Colpo Critico di ogni turno, aumenta il Tasso di Crit. di un ulteriore 20%. Dopo il 3° Colpo Critico di ogni turno, aumenta il Danno Crit. di un ulteriore 50%."
  },
  State_2490_Desc = {
    Text = "Ogni accumulo aumenta il conteggio degli attacchi di 1. Perdi 1 accumulo quando subisci Danno, e perdi tutti gli accumuli alla fine del turno."
  },
  State_2490_Name = {Text = "Preghiera"},
  State_2491_Desc = {
    Text = "Ottieni uno Scudo del Personaggio pari alla quantità di PV ripristinati durante la Guarigione."
  },
  State_2491_Name = {
    Text = "Indurimento temporaneo"
  },
  State_2492_Desc = {
    Text = "Immune al primo Danno attivo di ogni turno."
  },
  State_2492_Name = {Text = "Tenace"},
  State_2492_WeaponDesc = {
    Text = "Immune al primo Danno attivo di ogni turno."
  },
  State_2493_Desc = {
    Text = "Riduci il Danno attivo di [Layer]."
  },
  State_2493_Name = {Text = "FOR▼"},
  State_2494_Desc = {
    Text = "Stato@Prologo Aliemus 0_1_4_1"
  },
  State_2494_Name = {
    Text = "Stato@Prologo Aliemus 0_1_4_1"
  },
  State_2494_WeaponDesc = {
    Text = "Stato@Prologo Aliemus 0_1_4_1"
  },
  State_2495_Desc = {
    Text = "Stato@Prologo Aliemus 0_1_4_2"
  },
  State_2495_Name = {
    Text = "Stato@Prologo Aliemus 0_1_4_2"
  },
  State_2495_WeaponDesc = {
    Text = "Stato@Prologo Aliemus 0_1_4_2"
  },
  State_24968_Desc = {
    Text = "All'inizio del combattimento, Fusione Embrionale +[Blood:DescArg2]; ogni volta che si attiva la Resistenza, Fusione Embrionale +[Blood:DescArg2]. Ogni volta che Sorel infligge Danno, l'Aumento DAN inflitto da sé stessa in questo turno aumenta di [DescArg1] punti."
  },
  State_24968_Name = {
    Text = "Gioiello della corona"
  },
  State_2496_Desc = {
    Text = "All'inizio del turno, ripristina [Arg1] PV. Se i PV sono inferiori al 50%, ripristina invece [Arg2] PV."
  },
  State_2496_Name = {
    Text = "Sangue Benedetto"
  },
  State_24976_Desc = {
    Text = "\"Ancella della Luna Gibbosa\" è stata Risvegliata. Attenzione ai danni causati dai suoi piatti speciali!"
  },
  State_24976_Name = {
    Text = "Karen si risveglia!"
  },
  State_24976_WeaponDesc = {
    Text = "A inizio del turno successivo, ottieni Scudo del Personaggio pari alla quantità di HP persi nel turno precedente."
  },
  State_24977_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_24977_Name = {
    Text = "Non Risvegliato"
  },
  State_2497_Desc = {
    Text = "Lily imita la prima Carta di comando che giochi ogni turno. Se è una carta Attacco, Lily ottiene +1 attacco; se è una carta Difesa, Lily ottiene uno Scudo pari al 10% dei suoi PV; se è un'altra Carta di comando, Lily si confonderà e piazzerà una pustola qui."
  },
  State_2497_Name = {
    Text = "Lily, Risveglio!"
  },
  State_2497_WeaponDesc = {
    Text = "A inizio del turno successivo, ottieni Scudo del Personaggio pari alla quantità di HP persi nel turno precedente."
  },
  State_2498_Name = {
    Text = "Accessorio Coniglio Maledetto"
  },
  State_2498_WeaponDesc = {
    Text = "La Generazione di Scudo e il Recupero PV causati dal portatore sono aumentati del 6%. Se la Padronanza del Reame del portatore è superiore a 50, la Generazione di Scudo e il Recupero PV sono ulteriormente aumentati del 6%."
  },
  State_2499_Name = {
    Text = "Maledizione Stagnante"
  },
  State_2500_Desc = {
    Text = "Infligge Veleno quando si infligge Danno effettivo."
  },
  State_2500_Name = {Text = "Tossina"},
  State_2501_Desc = {
    Text = "Unico per Squadra: Gli HP massimi della squadra aumentano del 10%. La Guarigione e lo Scudo del Personaggio forniti dal Portatore aumentano del <WeaponEffect_Num:[StateArg3]%>. Dopo aver giocato il \"Colpo\" del Portatore, ripristina il <WeaponEffect_Num:[StateArg1]%> degli HP persi. Dopo aver giocato la \"Difesa\" del Portatore, ottieni uno Scudo del Personaggio pari al <WeaponEffect_Num:[StateArg2]%> della vita attuale. Questo effetto può attivarsi al massimo 1 volta ciascuno per turno."
  },
  State_2501_Name = {
    Text = "Nascita di un'anima"
  },
  State_2501_WeaponDesc = {
    Text = "HP Max della squadra +10%. La Guarigione e la Generazione di Scudo del portatore sono aumentate di <WeaponEffect_Num:[StateArg3]%>. Dopo aver giocato l'\"Attacco\" del portatore, ripristina [StateArg1]%(<WeaponEffect_Num:[Heal:DescArg1]>) degli HP persi. Dopo aver giocato la \"Difesa\" del portatore, ottieni Scudo pari a [StateArg1]%(<WeaponEffect_Num:[Block:DescArg2]>) degli HP attuali. Questo effetto si attiva fino a 1 volta per turno."
  },
  State_2502_Desc = {
    Text = "Tutti i Danni attivi e Danni da tentacolo inflitti -50%."
  },
  State_2502_Name = {
    Text = "Debolezza del Silenzio Eterno"
  },
  State_2502_WeaponDesc = {
    Text = "Tutti i Danni subiti sono ridotti del 50%."
  },
  State_2503_Desc = {
    Text = "Unico per Squadra: Il DAN Base inflitto dalle carte del Portatore è aumentato del <WeaponEffect_Num:[StateArg1]%>. A inizio turno, c'è una probabilità del <WeaponEffect_Num:[StateArg2]%> di generare una Carta casuale del Portatore nella mano con Esaurimento aggiunto. Se il reame corrente è \"Caro\", usare \"Embrione\" sul Portatore aumenta il Tasso Critico del Danno della prossima carta Colpo del Portatore in questo turno di <WeaponEffect_Num:+[StateArg3]%>."
  },
  State_2503_WeaponDesc = {
    Text = "Il DAN Base inflitto dalle carte del portatore è aumentato del <WeaponEffect_Num:[StateArg1]%>. A inizio turno, c'è una probabilità del <WeaponEffect_Num:[StateArg2]%> di mettere 1 carta casuale del portatore in mano e aggiungere Esaurimento ad essa. Se il reame attuale è \"Caro\", quando si usa \"Embrione\" sul portatore, il Tasso Crit. dei DAN della sua prossima Carta Colpo in questo turno sarà aumentato del <WeaponEffect_Num:+[StateArg3]%>."
  },
  State_2504_Desc = {
    Text = "\"Colpo\" ottiene 2 Arithmetica e scarta 1 carta casuale; \"Difesa\" pesca 2 carte e perde 1 Arithmetica."
  },
  State_25056_Desc = {
    Text = "Ogni volta che Arithmetica viene esaurita, Karen ottiene [Layer] FOR temporanea."
  },
  State_25056_Name = {
    Text = "Ben Nutrito"
  },
  State_25057_Desc = {
    Text = "Karen ottiene [StateArg1] FOR temporanea ogni volta che viene consumata Arithmetica, e 1 accumulo viene rimosso a fine turno."
  },
  State_25057_Name = {
    Text = "Ben Nutrito"
  },
  State_2505_Name = {
    Text = "Accessorio: Lode d'Aprile"
  },
  State_2505_WeaponDesc = {
    Text = "A inizio Battaglia, se il Portatore è di classe Ultra, aumenta l'ATT del 25%."
  },
  State_2507_Desc = {
    Text = "Aumenta i PV massimi del 100% quando raccolto. Perdi [Arg1] PV all'inizio del turno."
  },
  State_2509_Name = {
    Text = "Stato@Padronanza del Reame Generale"
  },
  State_2511_Desc = {
    Text = "Stato @ Prologo Tutorial Keyflare"
  },
  State_2511_Name = {
    Text = "Stato @ Prologo Tutorial Keyflare"
  },
  State_2511_WeaponDesc = {
    Text = "Stato@Prologo Ripristina Mazzo 0_1_2_2"
  },
  State_2512_Desc = {
    Text = "Quando giochi una carta con un Costo di Arithmetica pari o superiore a 3, peschi 1 carta e ottieni 1 Arithmetica."
  },
  State_2514_Desc = {
    Text = "La generazione di Scudo del Personaggio è ridotta di [Layer] in questa Battaglia."
  },
  State_2514_Name = {
    Text = "Allerta Ridotta"
  },
  State_2514_WeaponDesc = {
    Text = "La generazione di Scudo del Personaggio è ridotta di [Layer] in questa Battaglia."
  },
  State_2515_Desc = {
    Text = "[Strike] applica [StateArg1] accumuli di Veleno a tutti i nemici."
  },
  State_2515_Name = {
    Text = "Reliquia Neurotossina"
  },
  State_25163_Desc = {
    Text = "È sfuggente come la nebbia."
  },
  State_25163_Name = {
    Text = "Ombre del Passato"
  },
  State_25165_Desc = {
    Text = "Ramona: Logorata dal Tempo: Effetto aggiuntivo unico della Carta di comando di Ramona, attivato quando ci sono 3 accumuli di Negentropia. Il Ciclo verrà trasferito alla Battaglia successiva."
  },
  State_25165_Name = {
    Text = "<TimeBeacon:Ciclo>"
  },
  State_25166_Desc = {
    Text = "Con 3 cariche di Negentropia, l'uso delle Carte di comando di Ramona: Logora consuma tutte le cariche e attiva l'effetto extra Ciclo. (Max 3 cariche)"
  },
  State_25166_Name = {
    Text = "<TimeBeacon2:Negentropia>"
  },
  State_2516_Desc = {
    Text = "Non può essere giocata."
  },
  State_2516_Name = {
    Text = "Non Giocabile"
  },
  State_2516_WeaponDesc = {
    Text = "La carta non può essere giocata."
  },
  State_25179_Name = {
    Text = "Giudizio Aliemus"
  },
  State_2517_Desc = {
    Text = "Dopo che la tua squadra attiva Esaltazione, perdiamo Forza per il turno corrente. Una volta per turno."
  },
  State_2517_Name = {
    Text = "Paura dell'Alienus"
  },
  State_25181_Name = {
    Text = "Effetto di Conservazione della Reincarnazione"
  },
  State_2518_Desc = {
    Text = "Stato@Prologo Ripristina Mazzo 0_1_1_3"
  },
  State_2518_Name = {
    Text = "Stato@Prologo Ripristina Mazzo 0_1_1_3"
  },
  State_2518_WeaponDesc = {
    Text = "Stato@Prologo Ripristina Mazzo 0_1_1_3"
  },
  State_25194_Desc = {
    Text = "Dopo la morte, concedi a \"N\" uno Scudo di [DescArg1] e [DescArg2] FRZ Permanente"
  },
  State_2519_Desc = {
    Text = "Stato@Prologo Ripristina Mazzo 0_1_1_3"
  },
  State_2519_Name = {
    Text = "Stato@Prologo Ripristina Mazzo 0_1_1_3"
  },
  State_2519_WeaponDesc = {
    Text = "Stato@Prologo Ripristina Mazzo 0_1_1_3"
  },
  State_25204_Name = {
    Text = "Stato @ Clone 2 di N @ Giudizio Intenzione"
  },
  State_25205_Name = {
    Text = "Stato @ Clone 3 di N @ Giudizio Intenzione"
  },
  State_25206_Name = {
    Text = "Stato@N@Aggiungi un controllo duplicato per N"
  },
  State_25207_Name = {
    Text = "Stato @ Clone di N @ Giudizio Intenzione"
  },
  State_2520_Desc = {
    Text = "Stato@Prologo Ripristina Mazzo 0_1_1_2"
  },
  State_2520_Name = {
    Text = "Stato@Prologo Ripristina Mazzo 0_1_1_2"
  },
  State_2520_WeaponDesc = {
    Text = "Stato@Prologo Ripristina Mazzo 0_1_1_2"
  },
  State_2522_Desc = {
    Text = "Helot si è Destata. Scatenerà attacchi più potenti!"
  },
  State_2522_Name = {
    Text = "Risveglio di Helot"
  },
  State_2523_Desc = {
    Text = "All'inizio dei turni dispari, ottieni [Arg1] Forza per questo turno. All'inizio dei turni pari, ottieni [Arg2] Allerta per questo turno."
  },
  State_2524_Desc = {
    Text = "A inizio battaglia, ottieni 1 Forza."
  },
  State_2524_Name = {
    Text = "Fama Rinomata"
  },
  State_2525_Desc = {
    Text = "Conteggio attacchi -1, ottieni [Layer] FOR"
  },
  State_2525_Name = {
    Text = "Dissolutezza"
  },
  State_2527_Name = {
    Text = "Bonus FOR Cremisi"
  },
  State_2528_Desc = {
    Text = "Quando giochi una carta con un Costo di Arithmetica effettivo di 3, pesca 1 carta e ottieni 2 Arithmetica."
  },
  State_2529_Desc = {
    Text = "Il Danno Crit. è aumentato del [Layer]% in questo turno."
  },
  State_2529_Name = {
    Text = "Danno critico temporaneo"
  },
  State_2529_WeaponDesc = {
    Text = "Il Danno Crit. è aumentato del [Layer]% in questo turno."
  },
  State_2531_Desc = {
    Text = "Ogni [Damage:StateArg2] volte che il Fuoco Cinereo infligge DAN, ottieni un [Green Flames] con Esaurisci."
  },
  State_2531_Name = {
    Text = "Riflesso di Smeraldo"
  },
  State_2531_WeaponDesc = {
    Text = "Ogni [Damage:StateArg2] volte che il Fuoco Cinereo infligge DAN, ottieni un [Green Flames] con Esaurisci."
  },
  State_2532_Name = {
    Text = "Accessorio: Brivido Scarlatto"
  },
  State_2534_Desc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_3_3"
  },
  State_2534_Name = {
    Text = "Stato@Prologo Reset Mazzo 0_1_3_3"
  },
  State_2534_WeaponDesc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_3_3"
  },
  State_2535_Desc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_3_2"
  },
  State_2535_Name = {
    Text = "Stato@Prologo Reset Mazzo 0_1_3_2"
  },
  State_2535_WeaponDesc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_3_2"
  },
  State_2536_Name = {
    Text = "Stato @ Aumento Temporaneo Danno Critico Carta Attacco"
  },
  State_2537_Desc = {
    Text = "Quando la Lama dell'utopia applica uno scudo, ottieni [StateArg2] Allerta temporanea."
  },
  State_2537_Name = {
    Text = "Saggezza del Campo di Battaglia"
  },
  State_2537_WeaponDesc = {
    Text = "Quando la Lama dell'utopia applica uno scudo, ottieni [StateArg2] Allerta temporanea."
  },
  State_2538_Desc = {
    Text = "Quando giocata, ottieni [StateArg1] <RetaliateIconKeywords:Contrattacco>, poi infliggi Danni Reali a tutti i nemici pari al [StateArg2]% del tuo <RetaliateIconKeywords:Contrattacco>."
  },
  State_2538_Name = {
    Text = "<Rune_9_High:Av. Spina>"
  },
  State_25391_Desc = {
    Text = "Un Risvegliatore nel gruppo è stato selezionato come \"Pubblico Fortunato\", e tutte le carte di quel Risvegliatore ottengono l'effetto \"Tifo\"."
  },
  State_25391_Name = {
    Text = "Pubblico Fortunato"
  },
  State_25392_Desc = {
    Text = "Dopo averla giocata, perdi il 2% degli HP massimi. Il grande mago ottiene 1 accumulo di \"Ego Boost\" in questo turno."
  },
  State_25392_Name = {
    Text = "<CardCheerKeywords:Applausi>"
  },
  State_25401_Desc = {
    Text = "Quando questa carta è In Mano, il limite di carte in mano aumenta di 1."
  },
  State_25401_Name = {
    Text = "Ignora Limite Carte in Mano"
  },
  State_25403_Desc = {
    Text = "DAN da Tentacolo -50%, ottieni [Layer] Scudo del Personaggio per ogni DAN da Tentacolo inflitto."
  },
  State_25403_Name = {
    Text = "Mare Tranquillo"
  },
  State_25405_Desc = {
    Text = "Questa carta rimarrà sempre nella tua mano in qualsiasi circostanza."
  },
  State_25405_Name = {
    Text = "Conservata Permanentemente"
  },
  State_25406_Desc = {
    Text = "Non è possibile cambiare Postura del tentacolo per il resto di questo turno"
  },
  State_25406_Name = {
    Text = "Follia di Aequor: Restrizione"
  },
  State_25407_Desc = {
    Text = "Danni da Tentacolo -25%, Tentacoli -1 a fine turno"
  },
  State_25407_Name = {
    Text = "Follia Abissale"
  },
  State_25415_Desc = {
    Text = "Dopo aver rilasciato la Posse, ottieni [Layer] Energia Posse."
  },
  State_25415_Name = {
    Text = "Traboccamento Keyflare Temporaneo del Caos"
  },
  State_25417_Name = {Text = "Bomba"},
  State_25418_Name = {Text = "Bomba 2"},
  State_2542_Name = {
    Text = "Conteggio Reliquia Appendice Senza Nome"
  },
  State_2543_Name = {
    Text = "Stato@Stage2_14Battle8Bubble1"
  },
  State_2544_Desc = {
    Text = "Stato@Prologo Mostro Passivo"
  },
  State_2544_Name = {
    Text = "Stato@Prologo Mostro Passivo"
  },
  State_2544_WeaponDesc = {
    Text = "Stato@Prologo Mostro Passivo"
  },
  State_2545_Desc = {
    Text = "A inizio battaglia, Fusione Embrionale +20%. Per ogni Risvegliatore con Aliemus al massimo, la Fusione Embrionale aumenta di un ulteriore +20%."
  },
  State_2547_Desc = {
    Text = "A inizio turno, aggiungi un \"Tridente Uncinato\" che conferisce [Arg1] Forza alla tua mano. Dopo aver rilasciato l'Esaltazione, aumenta la Forza di tutti i \"Tridente Uncinato\" In Mano di [Arg2]."
  },
  State_2548_Desc = {
    Text = "Immune a una morte, ripristina 50 PV dopo l'attivazione e disabilita permanentemente questa Reliquia."
  },
  State_2548_Name = {
    Text = "Reliquia Bambola Sostituta"
  },
  State_2548_WeaponDesc = {
    Text = "Immune a una morte, ripristina 50 PV dopo l'attivazione e disabilita permanentemente questa Reliquia."
  },
  State_2549_Desc = {
    Text = "Riduce il Danno attivo e del Tentacolo."
  },
  State_2549_Name = {
    Text = "<ExhaustionIconKeywords: FOR▼>"
  },
  State_2549_WeaponDesc = {
    Text = "Ogni accumulo di Risucchio riduce i DAN e i DAN del Tentacolo di 1."
  },
  State_2550_Desc = {
    Text = "Quando pescata, rendi te stesso Fragile per 1 turno. Quando usata, rendi tutti i nemici Vulnerabile per 1 turno. Non può essere venduta."
  },
  State_2550_Name = {
    Text = "Stato Maledizione Collasso"
  },
  State_2550_WeaponDesc = {
    Text = "Quando pescata, rendi te stesso Fragile per 1 turno. Quando usata, rendi tutti i nemici Vulnerabile per 1 turno. Non può essere venduta."
  },
  State_2552_Desc = {
    Text = "La carta non entra nella Pila degli scarti, ma rimane In Mano."
  },
  State_2552_Name = {
    Text = "<RetainIconKeywords:Conservare>"
  },
  State_2552_WeaponDesc = {
    Text = "La carta non entra nella Pila degli scarti, ma rimane In Mano."
  },
  State_2553_Desc = {
    Text = "A inizio turno, ottieni 1 Arithmetica."
  },
  State_2553_Name = {
    Text = "Reliquia Arcana Arithmetica"
  },
  State_2553_WeaponDesc = {
    Text = "A inizio turno, ottieni 1 Arithmetica."
  },
  State_2554_Name = {
    Text = "Corriere del mattino di Putney"
  },
  State_2556_Desc = {
    Text = "Quando gli HP diminuiscono, ottieni uno Scudo del Personaggio pari al [Layer]% della quantità ridotta."
  },
  State_2556_Name = {
    Text = "Scudo di Sangue"
  },
  State_2556_WeaponDesc = {
    Text = "Dopo una riduzione dei PV, ottieni uno Scudo del Personaggio pari al [Layer]% del valore perso."
  },
  State_2557_Desc = {
    Text = "All'inizio del prossimo turno, ottieni [Layer] Scudo del Personaggio."
  },
  State_2557_Name = {
    Text = "Scudo di Dolore e Piacere"
  },
  State_2558_Desc = {
    Text = "Quando i PV scendono sotto il 50% ([StateArg1]), si dividerà in 2 \"Dissoluto di Tipo Interferenza\" con PV uguali."
  },
  State_2558_Name = {Text = "Scissione"},
  State_2558_WeaponDesc = {
    Text = "Quando i PV scendono sotto il 50% ([StateArg1]), si dividerà in 2 \"Entità Dissolte di Tipo II\" con PV uguali."
  },
  State_2559_Desc = {
    Text = "Dopo ogni attacco, perdi [Layer] FOR temporanea."
  },
  State_2559_Name = {
    Text = "Il Prezzo dell'Impulsività"
  },
  State_2560_Desc = {
    Text = "Ottieni [Layer] Scudo del Personaggio dopo l'inizio del prossimo turno."
  },
  State_2560_Name = {
    Text = "Opus dell'Isolamento"
  },
  State_2560_WeaponDesc = {
    Text = "Ottieni [Layer] Scudo del Personaggio dopo l'inizio del prossimo turno."
  },
  State_2561_Desc = {
    Text = "Talento Malinconico"
  },
  State_2561_Name = {
    Text = "Talento Malinconico"
  },
  State_2561_WeaponDesc = {
    Text = "Talento Malinconico"
  },
  State_2562_Name = {
    Text = "Stato@Capitolo 3_Risonanza 1_Segno"
  },
  State_2563_Desc = {
    Text = "Giocare la decima carta aumenta il Danno del Tentacolo di 2 e fa attaccare tutti i Tentacoli una volta."
  },
  State_2563_Name = {
    Text = "Reliquia Tridente Uncinato"
  },
  State_2563_WeaponDesc = {
    Text = "Giocare la decima carta aumenta il Danno del Tentacolo di 2 e fa attaccare tutti i Tentacoli una volta."
  },
  State_2564_Desc = {
    Text = "Tutti gli Scudo del Personaggio ottenuti sono ridotti del [DescArg1]%."
  },
  State_2564_Name = {
    Text = "<FragileColour:Fragile>"
  },
  State_2564_WeaponDesc = {
    Text = "Tutti gli Scudi del Personaggio ottenuti sono ridotti del 33%."
  },
  State_2565_Name = {
    Text = "Accessorio: Abbraccio Scarlatto"
  },
  State_2565_WeaponDesc = {
    Text = "Ottieni 20 Keyflare quando il portatore infligge danni, o 50 Keyflare in caso di Colpo Critico. Questo effetto può attivarsi fino a 3 volte per turno."
  },
  State_2566_Desc = {
    Text = "Dopo aver ricevuto 3 attacchi in un turno, guadagna 1 stack di Follia Temporanea."
  },
  State_2566_Name = {
    Text = "\"Dolce Agonia\""
  },
  State_2567_Desc = {
    Text = "Ha subito [Layer] Danni; dopo aver raggiunto 3 volte, \"Dolce Malevolenza\" guadagna 1 stack di follia per questo turno."
  },
  State_2567_Name = {
    Text = "Conteggio\"Dolce Agonia\""
  },
  State_2567_WeaponDesc = {
    Text = "Ha subito danni [Layer] volte. Al raggiungimento di 3 volte, \"Dolce Demone\" ottiene 1 accumulo di Follia in questo turno."
  },
  State_2569_Desc = {
    Text = "L'effetto bonus del Reame raccomandato è aumentato del 50% e la tua Padronanza del Reame aumenta di 100 all'inizio del livello."
  },
  State_2569_Name = {
    Text = "Stato@Chiave d'argento Fantasmatica: Separazione di Compatibilità"
  },
  State_2570_Desc = {
    Text = "Quando giocata, pesca [StateArg1] carte."
  },
  State_2570_Name = {
    Text = "<Rune_3:Finezza>"
  },
  State_2571_Desc = {
    Text = "Per ogni Risvegliato [Chaos] nella squadra, i PV Max (Non completo), la Difesa e l'Attacco di tutti i membri aumentano del 50%."
  },
  State_2571_Name = {Text = "Bonus Caos"},
  State_2571_WeaponDesc = {
    Text = "Per ogni Risvegliato [Chaos] nella squadra, i PV Max (Non completo), la Difesa e l'Attacco di tutti i membri aumentano del 50%."
  },
  State_2572_Desc = {
    Text = "Quando giocata, <EmbryoFusionIconKeywords:Fusione Embrionale> +[StateArg1]."
  },
  State_2572_Name = {
    Text = "<Rune_12:Sete di Sangue>"
  },
  State_2573_Desc = {
    Text = "Ottieni 5 cariche di [Fuse]. Diminuisce di 1 quando giochi una carta. Quando raggiunge 0, si autodistrugge, infliggendo DAN pari a ATT * 2,5."
  },
  State_2573_Name = {Text = "Bomba"},
  State_2573_WeaponDesc = {
    Text = "Ottieni 5 cariche di [Fuse]. Diminuisce di 1 quando giochi una carta. Quando raggiunge 0, si autodistrugge, infliggendo DAN pari a ATT * 2,5."
  },
  State_2574_Desc = {
    Text = "Danno Crit. +50%. Se non viene effettuato nessun Attacco in questo turno, un Colpo Critico è garantito nel turno successivo."
  },
  State_2574_Name = {
    Text = "Stato@Chiave d'argento Fantasma: Rondò"
  },
  State_2575_Desc = {
    Text = "Unico per Squadra: All'inizio della battaglia, il Tasso di Crit. delle Carte di comando del Portatore +[StateArg1]% per ogni reliquia posseduta. Dopo aver usato l'Esaltazione, tira un dado a 4 facce; il Portatore ottiene Aliemus e Danno critico temporaneo pari a <WeaponEffect_Num:[StateArg2]> volte il risultato del tiro. Se il risultato è 4 o superiore, anche gli altri Risvegliati ne ottengono la metà."
  },
  State_2575_WeaponDesc = {
    Text = "All'inizio della battaglia, ogni Reliquia aumenta il Tasso Crit. delle Carte di Comando del Portatore del [StateArg1]%. Dopo che il Portatore esegue un'Esaltazione, lancia un dado a 4 facce; il Portatore ottiene <WeaponEffect_Num:[StateArg2]> volte il risultato del dado in Aliemus e Danno Crit. Temporaneo. Se il risultato è 4 o superiore, anche gli altri Risvegliati ottengono la metà."
  },
  State_2576_Desc = {
    Text = "Ogni volta che una carta entra nello Spazio Ultra, riduci il suo Costo di Arithmetica di 1."
  },
  State_2579_Desc = {
    Text = "Aumenta le istanze di Danno attivo inflitto di [Layer] in questo turno."
  },
  State_2579_Name = {
    Text = "Follia Temporanea"
  },
  State_2580_Desc = {
    Text = "Ogni volta che una carta Cacciatrice di Teschi entra o esce dallo Spazio Ultra, ottieni 1 Arithmetica."
  },
  State_2580_Name = {
    Text = "Proiezione Dimensionale"
  },
  State_2581_Desc = {
    Text = "La Rigenerazione Keyflare di tutti i Risvegliatori è aumentata di 30. Dopo aver rilasciato il Gruppo, mischia 3 <DerivativeCardKeywords_4:\"Intuizione\"> nel tuo mazzo."
  },
  State_2581_Name = {
    Text = "Stato@Pendolo crono Intuizione"
  },
  State_2582_Desc = {
    Text = "Danno, Scudo del Personaggio e Guarigione del Portatore +[StateArg1]%. (Temporaneo)"
  },
  State_2582_Name = {
    Text = "Stato@Proto Cannone Laser Aliemus"
  },
  State_2583_Desc = {
    Text = "Aggiungi un accumulo alla tua squadra ogni volta che si riceve Danno attivo."
  },
  State_2583_Name = {
    Text = "Stato @ Contrattacco Danni da decapitazione della Grande Lama del Vendicatore"
  },
  State_2583_WeaponDesc = {
    Text = "Aggiungi un accumulo alla tua squadra ogni volta che si riceve Danno attivo."
  },
  State_2584_Desc = {
    Text = "Ottieni [Arg1] Forza ogni volta che il mazzo viene rimischiato."
  },
  State_2586_Desc = {
    Text = "Tutti gli Scudi del Personaggio ottenuti -25%, rimuove 1 accumulo alla fine del turno."
  },
  State_2586_Name = {
    Text = "<FragileIconKeywords:Fragile>"
  },
  State_2586_WeaponDesc = {
    Text = "Tutti gli Scudi del Personaggio ottenuti sono ridotti del 25%."
  },
  State_2587_Desc = {
    Text = "Il Danno da Ferita raddoppia. Ogni volta che vengono inflitti Danni effettivi, ottieni [Layer] punti scudo."
  },
  State_2587_Name = {
    Text = "\"Fauci Divoratrici del Cielo\""
  },
  State_2587_WeaponDesc = {
    Text = "Il Danno da Ferita raddoppia. Ogni volta che vengono inflitti Danni effettivi, ottieni [Layer] punti scudo."
  },
  State_2588_Desc = {
    Text = "Subisci [Layer] <FixedDamage:DAN Puro> e rimuovi questo stato alla fine del turno. Quando si ripristina la Vita, rimuovi accumuli di Sanguinamento pari al doppio della quantità ripristinata."
  },
  State_2588_Name = {
    Text = "Permanente<BleedingColour:Salasso>"
  },
  State_2588_WeaponDesc = {
    Text = "A fine turno, subisci [Layer] DAN e rimuovi questo stato. Ogni cura riduce gli accumuli della metà."
  },
  State_2589_Name = {
    Text = "Accessorio: Gemello Contorto Nero"
  },
  State_2589_WeaponDesc = {
    Text = "All'inizio dei turni dispari, aggiungi il \"Colpo\" del Portatore con Esaurimento e Fugace alla tua mano."
  },
  State_2590_Desc = {
    Text = "Ottieni 10 Sigilli Neri quando ti muovi"
  },
  State_2590_Name = {
    Text = "Borsa Senza Fondo delle Reliquie"
  },
  State_2590_WeaponDesc = {
    Text = "Ottieni 10 Sigilli Neri quando ti muovi"
  },
  State_2592_Desc = {
    Text = "Per ogni 1 PV perso, rimuovi 1 accumulo. Quando il numero di accumuli raggiunge 0, ottieni [DescArg1] Scudo del Personaggio."
  },
  State_2592_Name = {
    Text = "Barriera Dimensionale"
  },
  State_2593_Name = {
    Text = "Stato@Inno del Sangue Cremisi e della Sabbia"
  },
  State_2594_Desc = {
    Text = "Ottieni uno Scudo del Personaggio infliggendo Danno effettivo."
  },
  State_2594_Name = {
    Text = "\"Fauci Divoratrici del Cielo\""
  },
  State_2594_WeaponDesc = {
    Text = "Ottieni uno Scudo del Personaggio infliggendo Danno effettivo."
  },
  State_2595_Desc = {
    Text = "Ottieni [StateArg2] FOR temporanea per ogni Colpo Subito."
  },
  State_2595_Name = {
    Text = "Spada della Regina Saggia"
  },
  State_2597_Desc = {
    Text = "A inizio turno, ottieni [Layer] punti Scudo del Personaggio."
  },
  State_2597_Name = {
    Text = "Scudo Ritardato"
  },
  State_2597_WeaponDesc = {
    Text = "A inizio turno, ottieni [Layer] punti Scudo del Personaggio."
  },
  State_2600_Desc = {
    Text = "Ogni volta che perdi PV, il Risvegliatore con l'Aliemus più basso guadagna 10 Aliemus. Ogni volta che perdi PV 5 volte, ottieni 1 livello di Barriera."
  },
  State_2600_Name = {
    Text = "Cronopendolo \"Analisi\""
  },
  State_2601_Desc = {
    Text = "Turni pari: DAN ricevuti -50%, DAN inflitti +33%."
  },
  State_2601_Name = {Text = "Volubile"},
  State_2601_WeaponDesc = {
    Text = "Turni pari: DAN ricevuti -50%, DAN inflitti +33%."
  },
  State_2602_Desc = {
    Text = "Sei il bersaglio! Dopo essere stata giocata, Zelota Eterno ottiene [StateArg1] FOR temporanea e rimuove il Marchio dell'Abisso da questo comando."
  },
  State_2602_Name = {
    Text = "<CardKeyWord:Marchio dell'Abisso>"
  },
  State_2602_WeaponDesc = {
    Text = "Dopo aver giocato la carta, l'Élite del Sommozzatore Profondo ottiene [StateArg1] FOR temporanea."
  },
  State_2603_Desc = {
    Text = "Se carte \"Embrione\" sono In Mano, le consuma tutte per attivare l'effetto Divorare una volta per Embrione."
  },
  State_2603_Name = {
    Text = "<UnlimitedDevouredIconKeywords:Divorazione Infinita>"
  },
  State_2604_Desc = {
    Text = "Tasso di Crit. aumentato del [Layer]% in questo turno."
  },
  State_2604_Name = {
    Text = "Tasso critico temporaneo"
  },
  State_2604_WeaponDesc = {
    Text = "Tasso di Crit. aumentato del [Layer]% in questo turno."
  },
  State_2605_Desc = {
    Text = "Quando i PV scendono sotto il 95% ([StateArg1]), si divide in 2 \"Opere Sperimentali\" con PV equamente distribuiti."
  },
  State_2605_Name = {Text = "Scissione"},
  State_2605_WeaponDesc = {
    Text = "Quando i PV scendono sotto il 30% ([StateArg1]), si dividerà in 3 \"Gruppo di Sculture di Cera di Entità Dissolta di Tipo II\" con PV equamente distribuiti."
  },
  State_2606_Desc = {
    Text = "Quando i PV scendono sotto il 90% ([StateArg1]), si divide in 2 \"Opere Sperimentali\" con PV equamente distribuiti."
  },
  State_2606_Name = {Text = "Scissione"},
  State_2606_WeaponDesc = {
    Text = "Quando i PV scendono sotto il 30% ([StateArg1]), si dividerà in 3 \"Gruppo di Sculture di Cera di Entità Dissolta di Tipo II\" con PV equamente distribuiti."
  },
  State_2607_Desc = {
    Text = "Ripristina 5 PV alla fine della battaglia."
  },
  State_2607_Name = {
    Text = "Fanciulla della Luna Gibbosa Illuminazione 3"
  },
  State_2607_WeaponDesc = {
    Text = "Ripristina 5 PV alla fine della battaglia."
  },
  State_2609_Desc = {
    Text = "Quando i PV scendono sotto il 30% ([StateArg1]), si divide in 2 \"Opere Sperimentali\" con PV equamente distribuiti."
  },
  State_2609_Name = {Text = "Scissione"},
  State_2609_WeaponDesc = {
    Text = "Quando i PV scendono sotto il 30% ([StateArg1]), si dividerà in 3 \"Gruppo di Sculture di Cera di Entità Dissolta di Tipo II\" con PV equamente distribuiti."
  },
  State_2610_Desc = {
    Text = "Quando i PV scendono sotto il 70% ([StateArg1]), si divide in 2 \"Opere Sperimentali\" con PV equamente distribuiti."
  },
  State_2610_Name = {Text = "Scissione"},
  State_2610_WeaponDesc = {
    Text = "Quando i PV scendono sotto il 30% ([StateArg1]), si dividerà in 3 \"Gruppo di Sculture di Cera di Entità Dissolta di Tipo II\" con PV equamente distribuiti."
  },
  State_2611_Desc = {
    Text = "Quando i PV scendono sotto il 50% ([StateArg1]), si divide in 2 \"Creazioni Sperimentali\" con PV equamente distribuiti."
  },
  State_2611_Name = {Text = "Scissione"},
  State_2611_WeaponDesc = {
    Text = "Quando i PV scendono sotto il 30% ([StateArg1]), si dividerà in 3 \"Gruppo di Sculture di Cera di Entità Dissolta di Tipo II\" con PV equamente distribuiti."
  },
  State_2612_Desc = {
    Text = "Imitatore Antico"
  },
  State_2612_Name = {
    Text = "Imitatore Antico"
  },
  State_2612_WeaponDesc = {
    Text = "Imitatore Antico"
  },
  State_2614_Desc = {
    Text = "Unico per Squadra: Dopo aver giocato la Carta di comando del Portatore, c'è una probabilità del <WeaponEffect_Num:[StateArg1]%> di farla tornare in mano dalla Pila degli scarti. Questo effetto può attivarsi solo una volta per turno."
  },
  State_2614_WeaponDesc = {
    Text = "Quando giochi una Carta di comando del portatore, c'è una probabilità del <WeaponEffect_Num:[StateArg1]%> di riportarla dalla Pila degli scarti alla mano. Questo effetto si attiva solo una volta per turno."
  },
  State_2617_Desc = {
    Text = "All'inizio del prossimo turno, pesca [DescArg1] carte aggiuntive."
  },
  State_2617_Name = {Text = "Mania"},
  State_2619_Desc = {
    Text = "Il Danno attivo inflitto è ridotto di [Layer] in questa battaglia."
  },
  State_2619_Name = {Text = "FOR▼"},
  State_2619_WeaponDesc = {
    Text = "I DAN inflitti durante questa battaglia sono ridotti di [Layer]."
  },
  State_2620_Desc = {
    Text = "Reliquia Bisturi Arrugginito"
  },
  State_2620_Name = {
    Text = "Bisturi Arrugginito"
  },
  State_2623_Desc = {
    Text = "A inizio turno, ottieni 1 Arithmetica."
  },
  State_2624_Desc = {
    Text = "Quando giocata, infliggi [StateArg1] <ExhaustionIconKeywords:FOR▼> Temp. a tutti i nemici."
  },
  State_2624_Name = {
    Text = "<Rune_18:Risucchio>"
  },
  State_2625_Desc = {
    Text = "Il tuo effetto Balzo si attiva due volte. All'ingresso nel Turno Ultra, tutti i nemici ottengono 5 FOR temporanea."
  },
  State_2625_Name = {
    Text = "Reliquia Lanterna dell'Incubo"
  },
  State_2626_Desc = {
    Text = "Limite Tentacoli -1. A fine turno, tutti i Tentacoli attaccano 1 volta aggiuntiva."
  },
  State_2627_Name = {
    Text = "Ottieni [StateArg1] Keyflare"
  },
  State_2627_WeaponDesc = {
    Text = "Le carte scelte al nodo \"Scultura di Cera Incompiuta\" ottengono Keyflare."
  },
  State_2628_Desc = {
    Text = "Le carte copiate al nodo \"Scultura di Cera Incompiuta\" ottengono l'effetto Orazione."
  },
  State_2628_Name = {
    Text = "Stato@Capitolo Due_Risonanza 3"
  },
  State_2628_WeaponDesc = {
    Text = "Le carte copiate al nodo \"Scultura di Cera Incompiuta\" ottengono l'effetto Orazione."
  },
  State_2629_Desc = {
    Text = "Trovato presso la \"Scultura di Cera Incompiuta\": gamma ampliata di carte copiabili."
  },
  State_2629_Name = {
    Text = "Stato@Capitolo 2_Risonanza 2"
  },
  State_2629_WeaponDesc = {
    Text = "Le carte copiate al nodo \"Scultura di Cera Incompiuta\" e i loro originali ottengono l'effetto \"Innato\"."
  },
  State_2630_Desc = {
    Text = "Le carte copiate presso la \"Scultura di Cera Incompiuta\" e i loro originali ottengono l'effetto \"Conservare\""
  },
  State_2630_Name = {
    Text = "Stato@Capitolo2_Risonanza4"
  },
  State_2630_WeaponDesc = {
    Text = "Le carte copiate al nodo \"Scultura di Cera Incompiuta\" e i loro originali ottengono l'effetto \"Conservare\"."
  },
  State_2631_Desc = {
    Text = "Duplica una Carta presso la \"Scultura di Cera Incompiuta\""
  },
  State_2631_Name = {
    Text = "Stato@Capitolo 2_Risonanza 6"
  },
  State_2631_WeaponDesc = {
    Text = "Copia una carta aggiuntiva al nodo \"Scultura di Cera Incompiuta\""
  },
  State_2633_Desc = {
    Text = "Ogni volta che si subisce Danno attivo, aggiungi in mano 1 [Fiamme Verdi] con Esaurimento per [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turni\">."
  },
  State_2633_Name = {
    Text = "Fuoco Cattura-Falene"
  },
  State_2633_WeaponDesc = {
    Text = "Ogni volta che subisci un Attacco prima del tuo prossimo turno, aggiungi una carta [Green Flames] alla tua mano."
  },
  State_2634_Desc = {
    Text = "Subisci [StateArg1] DAN e rimuovi 1 accumulo quando giochi una carta. Quando gli accumuli raggiungono 0, schiudi una \"Creatura Marina\" più debole. Se ancora parassitato a fine turno, schiudi una \"Creatura Marina\" con PV basati sugli accumuli."
  },
  State_2634_Name = {
    Text = "Parassitato"
  },
  State_2635_Desc = {
    Text = "Stato@Prologo Indicatore Analisi Offensiva"
  },
  State_2635_Name = {
    Text = "Stato@Prologo Indicatore Analisi Offensiva"
  },
  State_2635_WeaponDesc = {
    Text = "Stato@Prologo Indicatore Analisi Offensiva"
  },
  State_2636_Name = {
    Text = "Stato@Capitolo 4 Risonanza@Pesca 1 Carta il Prossimo Turno"
  },
  State_2637_Desc = {
    Text = "A inizio turno, ottieni [StateArg1] Arithmetica."
  },
  State_2637_Name = {
    Text = "Reliquia Iniezione di Vitalità"
  },
  State_2637_WeaponDesc = {
    Text = "A inizio turno, ottieni [StateArg1] Arithmetica."
  },
  State_2639_Desc = {
    Text = "Quando subisci Danno letale, c'è una probabilità di attivare la Resistenza alla Morte e sopravvivere con 1 HP. Ogni attivazione dimezza la tua % di Resistenza alla Morte e i guadagni successivi di Resistenza alla Morte durante questa esplorazione."
  },
  State_2639_Name = {
    Text = "<DeathResistanceIconKeywords:Resistenza alla Morte>"
  },
  State_2640_Name = {
    Text = "L'effetto generale si ripete una volta"
  },
  State_2645_Desc = {
    Text = "Stato@Prologo Mostro Passivo 1"
  },
  State_2645_Name = {
    Text = "Stato@Prologo Mostro Passivo 1"
  },
  State_2645_WeaponDesc = {
    Text = "Stato@Prologo Mostro Passivo 1"
  },
  State_2646_Desc = {
    Text = "Stato@Prologo Mostro Passivo 2"
  },
  State_2646_Name = {
    Text = "Stato@Prologo Mostro Passivo 2"
  },
  State_2646_WeaponDesc = {
    Text = "Stato@Prologo Mostro Passivo 2"
  },
  State_2647_Desc = {
    Text = "Stato@Prologo Mostro Passivo 3"
  },
  State_2647_Name = {
    Text = "Stato@Prologo Mostro Passivo 3"
  },
  State_2647_WeaponDesc = {
    Text = "Stato@Prologo Mostro Passivo 3"
  },
  State_2648_Desc = {
    Text = "Stato @ Prologo Mostro Passivo 4"
  },
  State_2648_Name = {
    Text = "Stato @ Prologo Mostro Passivo 4"
  },
  State_2648_WeaponDesc = {
    Text = "Stato @ Prologo Mostro Passivo 4"
  },
  State_2649_Desc = {
    Text = "Stato@Prologo Mostro Passivo 5"
  },
  State_2649_Name = {
    Text = "Stato@Prologo Mostro Passivo 5"
  },
  State_2649_WeaponDesc = {
    Text = "Stato@Prologo Mostro Passivo 5"
  },
  State_2650_Desc = {
    Text = "Stato @ Prologo Mostro Passivo 6"
  },
  State_2650_Name = {
    Text = "Stato @ Prologo Mostro Passivo 6"
  },
  State_2650_WeaponDesc = {
    Text = "Stato @ Prologo Mostro Passivo 6"
  },
  State_2651_Desc = {
    Text = "Stato@Prologo Mostro Passivo 7"
  },
  State_2651_Name = {
    Text = "Stato@Prologo Mostro Passivo 7"
  },
  State_2651_WeaponDesc = {
    Text = "Stato@Prologo Mostro Passivo 7"
  },
  State_2652_Desc = {
    Text = "Stato@Prologo Mostro Passivo 8"
  },
  State_2652_Name = {
    Text = "Stato@Prologo Mostro Passivo 8"
  },
  State_2652_WeaponDesc = {
    Text = "Stato@Prologo Mostro Passivo 8"
  },
  State_2653_Desc = {
    Text = "Stato@Prologo Mostro Passivo 9"
  },
  State_2653_Name = {
    Text = "Stato@Prologo Mostro Passivo 9"
  },
  State_2653_WeaponDesc = {
    Text = "Stato@Prologo Mostro Passivo 9"
  },
  State_2655_Desc = {
    Text = "Cura di un ammontare pari ai DAN inflitti non bloccati. Rimosso dopo aver inflitto Danno."
  },
  State_2655_Name = {
    Text = "Drenaggio Vitale"
  },
  State_2656_Desc = {
    Text = "Fuggi a inizio del prossimo turno!"
  },
  State_2656_Name = {Text = "Fuga"},
  State_2660_Desc = {
    Text = "All'inizio della battaglia, ottieni Forza, ma subisci 5 Danni aggiuntivi."
  },
  State_2660_Name = {
    Text = "Ultimo Grido"
  },
  State_2661_Desc = {
    Text = "All'inizio della battaglia, tutti i nemici perdono [Arg1] Forza."
  },
  State_2662_Name = {
    Text = "Stato@Capitolo_3_Stato_Test"
  },
  State_2663_Desc = {
    Text = "Quando pescata, applica Debolezza a te stesso per 1 turno. Quando usata, applica Debolezza a tutti i nemici per 1 turno. Non può essere venduta."
  },
  State_2663_Name = {
    Text = "Stato Maledizione Indebolimento"
  },
  State_2663_WeaponDesc = {
    Text = "Quando pescata, applica Debolezza a te stesso per 1 turno. Quando usata, applica Debolezza a tutti i nemici per 1 turno. Non può essere venduta."
  },
  State_2666_Name = {
    Text = "Tasso Crit. del Pugnale Ricorrente"
  },
  State_2667_Desc = {
    Text = "Danno delle carte Colpo aumentato del [Layer]%."
  },
  State_2667_Name = {
    Text = "Danno delle carte Colpo aumentato"
  },
  State_2667_WeaponDesc = {
    Text = "Danno delle carte Colpo aumentato del [Layer]%."
  },
  State_2668_Desc = {
    Text = "Aumenta l'Attacco del [Layer]%"
  },
  State_2668_Name = {
    Text = "Aumenta la percentuale di attacco permanente universale"
  },
  State_2668_WeaponDesc = {
    Text = "Aumenta l'Attacco del [Layer]%"
  },
  State_2669_Desc = {
    Text = "Il Danno Crit. è aumentato del [Layer]% in questa battaglia."
  },
  State_2669_Name = {
    Text = "Danno critico"
  },
  State_2670_Desc = {
    Text = "Quando infliggi Debolezza, ottieni [Arg1] Scudo; quando infliggi Vulnerabilità, ottieni [Arg2] Forza. Attivare entrambi gli effetti in 1 turno concede [Arg1] Scudo e [Arg2] Forza aggiuntivi."
  },
  State_2670_Name = {
    Text = "Cornice Dorata"
  },
  State_2671_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_2671_Name = {
    Text = "Non Risvegliato"
  },
  State_2672_Desc = {
    Text = "All'inizio del turno, applica un accumulo di [Bondage] alla tua squadra."
  },
  State_2672_Name = {Text = "Vincolo"},
  State_2672_WeaponDesc = {
    Text = "All'inizio del turno, applica un accumulo di [Bondage] alla tua squadra."
  },
  State_2674_Desc = {
    Text = "Tasso di Crit. aumentato del [Layer]% in questo turno."
  },
  State_2674_Name = {
    Text = "Tasso critico temporaneo"
  },
  State_2676_Name = {
    Text = "Accessorio: Brivido Scarlatto"
  },
  State_2676_WeaponDesc = {
    Text = "Dopo aver rilasciato il Posse, il portatore ottiene il 15% di Tasso critico temporaneo. Se il Danno Crit. attuale del portatore è superiore all'80%, ottiene un ulteriore 15% di Tasso critico temporaneo."
  },
  State_2677_Desc = {
    Text = "Le prime 3 istanze di DAN subiti da attacchi attivi/del Tentacolo ogni turno sono ridotte del 75%."
  },
  State_2677_Name = {
    Text = "\"Vestigia Immortali\""
  },
  State_2677_WeaponDesc = {
    Text = "Le prime 3 istanze di DAN subiti da attacchi attivi/del Tentacolo ogni turno sono ridotte del 75%."
  },
  State_2679_Name = {
    Text = "Stato@Capitolo3_Risonanza7_Segno"
  },
  State_2680_Desc = {
    Text = "Probabilità di colpo critico aumentata del 20%. Colpo Critico garantito in questo turno se i PV sono sotto il 25% a inizio turno."
  },
  State_2681_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_2681_Name = {
    Text = "Non Risvegliato"
  },
  State_2682_Desc = {
    Text = "Potenziamento Scudo e Cura aumentato del 50%."
  },
  State_2682_Name = {
    Text = "Guardiano del Giardino Alienato"
  },
  State_2682_WeaponDesc = {
    Text = "Potenziamento Scudo e Cura aumentato del 50%."
  },
  State_2683_Desc = {
    Text = "Carta che pesca accumuli di stato."
  },
  State_2683_Name = {Text = "Pesca"},
  State_2684_Desc = {
    Text = "Unico per Squadra: Lo \"Colpo\" del Portatore ha una probabilità del <WeaponEffect_Num:[StateArg1]%> di ottenere 1 Arithmetica e infliggere il 10% di <IntoxicationIconKeywords:Veleno> a tutti i nemici; se il Reame corrente è \"Aequor\", l'attivazione di questo effetto fa sì che 1 Tentacolo attacchi una volta. Questo effetto si attiva solo una volta per turno."
  },
  State_2684_WeaponDesc = {
    Text = "Lo \"Colpo\" del Portatore ha una probabilità del <WeaponEffect_Num:[StateArg1]%> di ottenere 1 Arithmetica e infliggere [DescArg1]% di <IntoxicationIconKeywords:Veleno> a tutti i nemici. Se il Reame corrente è \"Aequor\", quando questo effetto viene attivato, 1 Tentacolo attaccherà una volta. Questo effetto può attivarsi un massimo di 1 volta per turno."
  },
  State_2685_Desc = {
    Text = "Immunità alla Debolezza, Fragilità e Vulnerabile. Rimuove 1 accumulo alla fine del turno."
  },
  State_2685_Name = {
    Text = "<BlessingIconKeywords:Benedizione>"
  },
  State_2685_WeaponDesc = {
    Text = "Immune ai debuff applicati agli alleati in questo turno."
  },
  State_2686_Desc = {
    Text = "Carte temporanee ottenute durante la battaglia."
  },
  State_2686_Name = {
    Text = "<CardKeyWord:Carta di stato>"
  },
  State_2687_Desc = {
    Text = "Tasso di critico + 100% in questo turno."
  },
  State_2687_Name = {
    Text = "Critico garantito temporaneo"
  },
  State_2687_WeaponDesc = {
    Text = "Tasso di critico + 100% in questo turno."
  },
  State_2688_Desc = {
    Text = "Dopo aver giocato la 3ª carta ogni turno, colloca 1 \"Intuizione\" nella Pila degli scarti. Dopo aver giocato la 6ª carta ogni turno, colloca 1 \"Intuizione\" dalla Pila degli scarti nella mano."
  },
  State_2689_Desc = {
    Text = "Pesca 2 carte a Inizio turno. La capacità degli slot carte Ultra è aumentata di 2."
  },
  State_2689_Name = {
    Text = "Reliquia Cappello dell'Imbroglione"
  },
  State_2689_WeaponDesc = {
    Text = "Pesca 2 carte a Inizio turno. La capacità degli slot carte Ultra è aumentata di 2."
  },
  State_2690_Desc = {
    Text = "Quando il Cavaliere Virtuoso gioca una carta, ottiene [StateArg1] Forza."
  },
  State_2690_Name = {
    Text = "Zelo del Cavaliere"
  },
  State_2691_Desc = {
    Text = "Unico per Squadra: Dopo che il Portatore rilascia un Esaltazione, ottiene <WeaponEffect_Num:[StateArg1]> Aliemus e <WeaponEffect_Num:[StateArg2]> Keyflare, ripetendo una volta per ogni 4 carte In Mano. Se il Reame corrente è \"Ultra\", dopo che le Carte del Portatore entrano nello Spazio Ultra, ottiene FOR temporanea pari a <WeaponEffect_Num:[StateArg3]%> dell'Attacco del Portatore, attivandosi fino a 2 volte per turno."
  },
  State_2691_WeaponDesc = {
    Text = "Dopo che il portatore rilascia l'Esaltazione, ottiene <WeaponEffect_Num:[StateArg1]> Aliemus e <WeaponEffect_Num:[StateArg2]> Keyflare, ripetendo una volta per ogni 4 carte in mano. Se il Reame attuale è \"Ultra\", dopo che le carte del portatore entrano nello Spazio Ultra, ottiene <WeaponEffect_Num:[Power:DescArg1]> FOR temporanea, attivandosi un massimo di 2 volte per turno."
  },
  State_2693_Desc = {
    Text = "Stato@Prologo Aliemus 0_1_2 Effetto"
  },
  State_2693_Name = {
    Text = "Stato@Prologo Aliemus 0_1_2 Effetto"
  },
  State_2693_WeaponDesc = {
    Text = "Stato@Prologo Aliemus 0_1_2 Effetto"
  },
  State_2694_Desc = {
    Text = "Per ogni Sigillo Nero consumato, tutti i Risvegliatori ottengono 1 Aliemus."
  },
  State_2694_Name = {
    Text = "Stato Fiore Inverso della Reliquia"
  },
  State_2694_WeaponDesc = {
    Text = "Per ogni Sigillo Nero consumato, tutti i Risvegliatori ottengono 1 Aliemus."
  },
  State_2695_Desc = {
    Text = "Ogni volta che una carta di un Risveglio entra nello Spazio Ultra, il Risveglio corrispondente ottiene 15 Aliemus."
  },
  State_2696_Desc = {
    Text = "Stato@Prologo Aliemus 0_1_2 Attivo"
  },
  State_2696_Name = {
    Text = "Stato@Prologo Aliemus 0_1_2 Attivo"
  },
  State_2696_WeaponDesc = {
    Text = "Stato@Prologo Aliemus 0_1_2 Attivo"
  },
  State_2698_Name = {
    Text = "Ottieni +1 Arithmetica all'inizio del prossimo turno."
  },
  State_2699_Name = {
    Text = "Ottieni +2 Arithmetica all'inizio del prossimo turno."
  },
  State_2701_Desc = {
    Text = "La Dama delle Profondità aumenta il [StateArg1] Danno tentacolo temporaneo al momento di ottenere uno scudo."
  },
  State_2701_Name = {
    Text = "Creatura plasmata"
  },
  State_2701_WeaponDesc = {
    Text = "La Dama delle Profondità aumenta il [StateArg1] Danno tentacolo temporaneo al momento di ottenere uno scudo."
  },
  State_2702_Desc = {
    Text = "Ottieni il 100% di Resistenza alla Morte al momento della raccolta. Dopo aver attivato la Resistenza alla Morte, ripristina [Arg1] PV a inizio turno in questa battaglia."
  },
  State_2702_Name = {
    Text = "Soffio vitale"
  },
  State_2703_Desc = {
    Text = "La copia Temporanea della prima carta Risvegliatore giocata ogni turno entra in una Fenditura Dimensionale, utilizzabile per l'Autoprotezione nei momenti di pericolo!"
  },
  State_2703_Name = {
    Text = "Fenditura Dimensionale"
  },
  State_2705_Desc = {Text = "—"},
  State_2705_Name = {
    Text = "Vendetta su di te"
  },
  State_2705_WeaponDesc = {Text = "—"},
  State_2706_Desc = {
    Text = "Rilevamento Pietrificazione Graduale"
  },
  State_2706_Name = {
    Text = "Rilevamento Pietrificazione Graduale"
  },
  State_2706_WeaponDesc = {
    Text = "Rilevamento Pietrificazione Graduale"
  },
  State_2707_Desc = {
    Text = "Questo turno, il Tentacolo attacca tutti i nemici."
  },
  State_2707_Name = {
    Text = "Attacco totale dei tentacoli"
  },
  State_2707_WeaponDesc = {
    Text = "Questo turno, il Tentacolo attacca tutti i nemici."
  },
  State_2708_Desc = {
    Text = "Limite Tentacoli aumentato di 1. Quando i PV sono inferiori al 50%, il danno dei Tentacoli aumenta di [StateArg1]."
  },
  State_2708_Name = {
    Text = "Reliquia del Passato mutata"
  },
  State_2708_WeaponDesc = {
    Text = "Limite Tentacoli aumentato di 1. Quando i PV sono inferiori al 50%, il danno dei Tentacoli aumenta di [StateArg1]."
  },
  State_2709_Desc = {
    Text = "Conteggio reliquia Bisturi Arrugginito"
  },
  State_2710_Desc = {Text = "Impronta"},
  State_2710_Name = {Text = "Impronta"},
  State_2710_WeaponDesc = {Text = "Impronta"},
  State_2711_Desc = {
    Text = "Modifica temporaneamente l'Arithmetica della carta"
  },
  State_2711_Name = {
    Text = "Modifica temporaneamente l'Arithmetica della carta"
  },
  State_2711_WeaponDesc = {
    Text = "Modifica temporaneamente l'Arithmetica della carta"
  },
  State_2712_Desc = {
    Text = "Aumenta la generazione di Scudo del Personaggio."
  },
  State_2712_Name = {
    Text = "<AlertIconKeywords:Allerta>"
  },
  State_2712_WeaponDesc = {
    Text = "Aumenta lo Scudo del Personaggio ottenuto."
  },
  State_2713_Desc = {
    Text = "La Lama della Vendetta ottiene Forza ogni turno."
  },
  State_2713_Name = {
    Text = "Risveglio del Golia"
  },
  State_2713_WeaponDesc = {
    Text = "A inizio del turno successivo, ottieni Scudo del Personaggio pari alla quantità di HP persi nel turno precedente."
  },
  State_2715_Desc = {
    Text = "La generazione di Scudo del Personaggio è aumentata di [Layer] in questa fase."
  },
  State_2715_Name = {
    Text = "Allerta Permanente"
  },
  State_2715_WeaponDesc = {
    Text = "La generazione di Scudo del Personaggio è aumentata di [Layer] in questa fase."
  },
  State_2718_Desc = {
    Text = "Unico per Squadra: A fine turno, il Portatore ottiene <WeaponEffect_Num:[StateArg1]> Aliemus e Keyflare pari alla propria Rigenerazione Keyflare."
  },
  State_2718_WeaponDesc = {
    Text = "A fine turno, il Portatore ottiene <WeaponEffect_Num:[StateArg1]> Aliemus e Keyflare pari alla Rigenerazione Keyflare del Portatore."
  },
  State_2720_Desc = {
    Text = "Dopo aver inflitto Danno effettivo, riduci di 10 l'Aliemus del Risvegliatore con l'Aliemus più alto."
  },
  State_2720_Name = {Text = "Effimero"},
  State_2720_WeaponDesc = {
    Text = "Dopo aver inflitto Danno effettivo, riduci di 10 l'Aliemus del Risvegliatore con l'Aliemus più alto."
  },
  State_2721_Name = {
    Text = "Stato@Level2_9Battle5Bubble1"
  },
  State_2722_Desc = {
    Text = "Quando giocata, mischia [StateArg1] <DerivativeCardKeywords_4:\"Intuizione\"> nel Mazzo di Pesca."
  },
  State_2722_Name = {
    Text = "<Rune_17_High:Av. Intuizione>"
  },
  State_2723_Desc = {
    Text = "Quando giocata, infliggi [StateArg1] turni di <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici."
  },
  State_2723_Name = {
    Text = "<Rune_1_High:Av. Vulnerabile>"
  },
  State_2724_Desc = {
    Text = "Aumenta il numero di attacchi di 1."
  },
  State_2724_Name = {
    Text = "Contrattacco del Nucleo Fantasma"
  },
  State_2726_Desc = {
    Text = "Quando giocata, infliggi [StateArg1] <IntoxicationIconKeywords:Veleno> a tutti i nemici, poi attiva il [StateArg2]% del <IntoxicationIconKeywords:Veleno> di ciascun nemico."
  },
  State_2726_Name = {
    Text = "<Rune_10_High:Av. Tossina>"
  },
  State_2727_Desc = {
    Text = "Quando sei in punto di morte, cura 1 PV e rimuovi questo Stato."
  },
  State_2727_Name = {Text = "Grinta"},
  State_2727_WeaponDesc = {
    Text = "Quando sei in punto di morte, cura 1 PV e rimuovi questo Stato."
  },
  State_2728_Desc = {
    Text = "A inizio turno, ottieni 1 accumulo di <ParcloseIconKeywords:Barriera> per ogni altra unità alleata."
  },
  State_2728_Name = {
    Text = "Barriera di Legame"
  },
  State_2728_WeaponDesc = {
    Text = "A inizio turno, ottieni uno Scudo pari a [Layer]% dei PV massimi per ogni altra unità alleata."
  },
  State_2729_Desc = {
    Text = "Quando attivato, pesca una carta corrispondente al Risvegliatore."
  },
  State_2729_Name = {
    Text = "Pescata Deflettore spaziale Mutato"
  },
  State_2729_WeaponDesc = {
    Text = "Quando attivato, pesca una carta corrispondente al Risvegliatore."
  },
  State_2730_Desc = {
    Text = "Alla morte, l'Idra riduce di 1 accumulo lo stato \"Manipolazione dei Serpenti\"."
  },
  State_2730_Name = {Text = "Stirpe"},
  State_2732_Desc = {
    Text = "Stato@Prologo Aliemus Init 0_2_3"
  },
  State_2732_Name = {
    Text = "Stato@Prologo Aliemus Init 0_2_3"
  },
  State_2732_WeaponDesc = {
    Text = "Stato@Prologo Aliemus Init 0_2_3"
  },
  State_2734_Name = {
    Text = "Pesca +1 carta all'inizio del prossimo turno"
  },
  State_2735_Desc = {
    Text = "Se questa carta attiva \"Navetta Dimensionale\" dopo essere stata giocata o se ci si trova attualmente in un Turno Ultra, attiva l'effetto successivo."
  },
  State_2735_Name = {
    Text = "<TransitionIconKeywords:Balzo>"
  },
  State_2735_WeaponDesc = {
    Text = "Se ci si trova attualmente in un Turno Ultra, gli effetti Balzo possono essere attivati."
  },
  State_2737_Desc = {
    Text = "Quando il mazzo della tua squadra viene rimescolato, ottieni [Layer] FOR."
  },
  State_2737_Name = {
    Text = "Gelo Eterno"
  },
  State_2738_Name = {
    Text = "Potenziamento Effetto Debolezza"
  },
  State_2740_Desc = {
    Text = "Le carte copiate al nodo \"Scultura di Cera Incompiuta\" e i loro originali hanno Costo di Arithmetica -1 e ottengono una Carta Sintomo."
  },
  State_2740_Name = {
    Text = "Stato@CapitoloDue_Risonanza5_2"
  },
  State_2740_WeaponDesc = {
    Text = "Le carte copiate al nodo \"Scultura di Cera Incompiuta\" e i loro originali hanno il Costo di Arithmetica ridotto di 1."
  },
  State_2741_Desc = {
    Text = "Le carte copiate al nodo \"Scultura di Cera Incompiuta\" e i loro originali hanno Costo di Arithmetica -1 e ottengono una Carta Sintomo."
  },
  State_2741_Name = {
    Text = "Stato @ Capitolo Due_Risonanza 5_1"
  },
  State_2741_WeaponDesc = {
    Text = "Le carte copiate al nodo \"Scultura di Cera Incompiuta\" e i loro originali hanno il Costo di Arithmetica ridotto di 1."
  },
  State_2742_Desc = {
    Text = "Per ogni punto di danno inflitto dall'Uomo Tic-Tac, ottieni [StateArg2] FOR temporanea; per ogni punto di Scudo, ricevi [StateArg3] Allerta temporanea."
  },
  State_2742_Name = {
    Text = "Adattamento dei Parametri"
  },
  State_2744_Desc = {
    Text = "Ogni volta che una carta di un Risvegliato entra nello Spazio Ultra, ottiene 15 Aliemus."
  },
  State_2744_Name = {
    Text = "Reliquia Dispositivo di Salto"
  },
  State_2744_WeaponDesc = {
    Text = "Ogni volta che una carta di un Risvegliato entra nello Spazio Ultra, ottiene 15 Aliemus."
  },
  State_2746_Desc = {
    Text = "Conteggio attacchi +1, perdi [Layer] FOR"
  },
  State_2746_Name = {Text = "Ansia"},
  State_2747_Desc = {
    Text = "Quando giocata, aumenta l'Aliemus di tutti gli altri Risvegliati di <Energy:[StateArg1]>."
  },
  State_2747_Name = {
    Text = "<Rune_16:Catalizzatore>"
  },
  State_2748_Desc = {
    Text = "Stato@Cerimonia delle Lanterne"
  },
  State_2748_Name = {
    Text = "Stato@Cerimonia delle Lanterne"
  },
  State_2748_WeaponDesc = {
    Text = "Stato@Cerimonia delle Lanterne"
  },
  State_2749_Desc = {
    Text = "In questo turno, dopo aver inflitto danni da Tentacolo, applica [Layer] accumuli di Veleno al bersaglio."
  },
  State_2749_Name = {
    Text = "Correnti profonde"
  },
  State_2750_Desc = {
    Text = "Affonda con me negli abissi del mare..."
  },
  State_2750_Name = {
    Text = "Risveglio di Nymphaea"
  },
  State_2752_Desc = {
    Text = "Quando Ninfea infligge DAN, ottieni [StateArg2] Aliemus."
  },
  State_2752_Name = {
    Text = "Annegati nel Dolore"
  },
  State_2752_WeaponDesc = {
    Text = "Quando Ninfea infligge DAN, ottieni [StateArg2] Aliemus."
  },
  State_2753_Desc = {
    Text = "Se i PV sono superiori a [Arg1] a inizio turno, perdi [Arg1] PV, ottieni [Arg2] Forza e [Arg3] Allerta per il turno."
  },
  State_2754_Name = {
    Text = "Stato @ Aumento Temporaneo Tasso Critico Carta Attacco"
  },
  State_2757_Desc = {
    Text = "All'inizio del prossimo turno, ottieni [DescArg1] punti Arithmetica aggiuntivi."
  },
  State_2757_Name = {Text = "Paranoia"},
  State_2758_Desc = {
    Text = "Tutti i tuoi effetti di Recupero PV sono aumentati di [Arg1], e il recupero in eccesso viene convertito in una quantità equivalente di Scudo del Personaggio."
  },
  State_2758_Name = {
    Text = "Farfalla conservata"
  },
  State_2760_Desc = {
    Text = "Ogni volta che un Risvegliato esegue un Divoramento, gli altri Risvegliati ottengono 10 Aliemus."
  },
  State_2762_Desc = {
    Text = "Quando giocata, ha effetto [StateArg1] volte aggiuntive e ricevi [StateArg2] Sigilli Neri. (Questa Orazione ha anche applicato <DepleteIconKeywords:Consumo> e <GuyouKeywords:Innato> alla carta.)"
  },
  State_2762_Name = {
    Text = "<Rune_7_High:Av. Eco>"
  },
  State_2762_WeaponDesc = {
    Text = "Dopo essere stata giocata, ha Effetto [StateArg1] volte aggiuntive. Esaurimento."
  },
  State_2763_Desc = {
    Text = "Ogni volta che il Sovrano Dormiente consuma 1 Arithmetica, aumenta il Danno del Tentacolo di [StateArg1]."
  },
  State_2763_Name = {
    Text = "Maestà immortale"
  },
  State_2763_WeaponDesc = {
    Text = "Ogni volta che il Sovrano Dormiente consuma 1 Arithmetica, aumenta il Danno del Tentacolo di [StateArg1]."
  },
  State_2764_Desc = {
    Text = "Aggiunge [StateArg1] accumuli di Salasso quando si infliggono DAN non bloccati."
  },
  State_2764_Name = {
    Text = "Salasso Malevolo"
  },
  State_2765_Name = {
    Text = "Stato@George@Cura alla morte"
  },
  State_2767_Name = {
    Text = "Stato@Il sigillo nero e Efficienza Ricarica della chiave d'argento"
  },
  State_2769_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_2769_Name = {
    Text = "Non Risvegliato"
  },
  State_2771_Desc = {
    Text = "Forza del Mostro"
  },
  State_2771_Name = {
    Text = "Forza del Mostro"
  },
  State_2772_Name = {
    Text = "Stato@Stage2_5Battle3Bubble1"
  },
  State_2773_Desc = {
    Text = "A inizio battaglia, metti 1 \"Bellezza Fugace - Sostituisci tutte le carte dei Risvegliati in mano con 'Colpo' fino a fine turno. Conservare, Esaurimento.\" in mano."
  },
  State_2775_Desc = {
    Text = "Conteggio Estrazioni al Ritorno"
  },
  State_2775_Name = {
    Text = "Ripristino Conteggio Pesca"
  },
  State_2776_Name = {
    Text = "Occhi Pietrificanti Maledizione Stagnante Potenziata"
  },
  State_2777_Name = {
    Text = "Stato@Capitolo Tre_Stato Vuoto"
  },
  State_2778_Desc = {
    Text = "All'inizio della battaglia, ottieni [Arg1] Scudo del Personaggio. Dopo aver giocato 7 \"Difese\" in questa battaglia, ottieni immediatamente [Arg2] Scudo del Personaggio."
  },
  State_2778_Name = {
    Text = "Corriere del mattino di Putney"
  },
  State_2779_Desc = {
    Text = "Quando i PV scendono sotto il 50% ([StateArg1]), si dividerà in 3 \"Dissoluto di Tipo Interferenza\" con PV uguali."
  },
  State_2779_Name = {Text = "Scissione"},
  State_2779_WeaponDesc = {
    Text = "Quando i PV scendono sotto il 50% ([StateArg1]), si dividerà in 2 \"Entità Dissolte di Tipo II\" con PV uguali."
  },
  State_2780_Desc = {
    Text = "Quando giocata, recupera [StateArg1] Arithmetica."
  },
  State_2780_Name = {
    Text = "<Rune_4:Calcolo>"
  },
  State_2781_Desc = {
    Text = "Ogni volta che giochi [Layer] carte, se non possiedi una Barriera, aggiungi un accumulo di <ParcloseIconKeywords:Barriera>."
  },
  State_2781_Name = {
    Text = "Barriera di Ricarica"
  },
  State_2781_WeaponDesc = {
    Text = "Ogni volta che la tua squadra gioca [Layer] carte, il Mostro ripristina una carica di Barriera."
  },
  State_2784_Desc = {
    Text = "Anche al di fuori dei Turni Ultra, puoi attivare un effetto Balzo una volta per turno. Aumenta la capacità dello Spazio Ultra di 2."
  },
  State_2785_Desc = {
    Text = "Unico per Squadra: Dopo che il Portatore gioca una carta, il Portatore ottiene 1 punto di Aliemus. All'inizio del combattimento, ottieni il <WeaponEffect_Num:[StateArg1]%> dell'Attacco del Portatore come <PowerIconKeywords:FOR>, e se il Reame attuale è \"Aequor\", ottieni inoltre il <WeaponEffect_Num:[StateArg2]%> di <CardKeyWord:Danno Tentacolo>. Successivamente, all'inizio di ogni turno seguente, ottieni il <WeaponEffect_Num:[StateArg3]%> dell'Attacco del Portatore come <PowerIconKeywords:FOR>, e se il Reame attuale è \"Aequor\", ottieni inoltre il <WeaponEffect_Num:[StateArg4]%> di <CardKeyWord:Danno Tentacolo>."
  },
  State_2785_WeaponDesc = {
    Text = "Dopo che il Portatore gioca una carta, il Portatore ottiene 1 Aliemus. All'inizio della battaglia, ottieni <WeaponEffect_Num:[Power:DescArg1]> <PowerIconKeywords:FOR>. Se il Reame corrente è \"Aequor\", ottieni inoltre <WeaponEffect_Num:[DescArg2]> <CardKeyWord:DAN del Tentacolo>. Dopo l'inizio di ogni turno successivo, ottieni <WeaponEffect_Num:[Power:DescArg3]> <PowerIconKeywords:FOR>. Se il Reame corrente è \"Aequor\", ottieni inoltre <WeaponEffect_Num:[DescArg4]> <CardKeyWord:DAN del Tentacolo>."
  },
  State_2786_Name = {
    Text = "Conteggio Reliquia Ciottolo Insanguinato"
  },
  State_2787_Desc = {
    Text = "Recupero PV, Mischiare 1 [Illusion's End] nella Pila degli scarti. Permanente, Distruggere."
  },
  State_2787_Name = {
    Text = "<CardKeyWord:Cercatore di Verità>"
  },
  State_2787_WeaponDesc = {
    Text = "Recupero PV, Mischiare 1 [Illusion's End] nella Pila degli scarti. Permanente, Distruggere."
  },
  State_2788_Desc = {
    Text = "Pesca [StateArg1] carte a inizio turno."
  },
  State_2788_Name = {
    Text = "Reliquia Lampada del Profeta 1"
  },
  State_2788_WeaponDesc = {
    Text = "Pesca [StateArg1] carte a inizio turno."
  },
  State_2789_Desc = {
    Text = "La carta è stata manomessa da Jenkin! Subisci [Layer] <FixedDamage:DAN Puro> quando viene giocata."
  },
  State_2789_Name = {
    Text = "<CardKeyWord:Subisce [Layer] danni quando giocata>"
  },
  State_2789_WeaponDesc = {
    Text = "La Carta subisce [StateArg1] Danno quando viene giocata."
  },
  State_2790_Desc = {
    Text = "Alla fine del tuo turno, puoi scegliere di Conservare [StateArg1] carte In Mano."
  },
  State_2790_Name = {
    Text = "Reliquia Lampada del Profeta 2"
  },
  State_2790_WeaponDesc = {
    Text = "Alla fine del tuo turno, puoi scegliere di Conservare [StateArg1] carte In Mano."
  },
  State_2792_Desc = {
    Text = "All'inizio della battaglia, tutti gli alleati ottengono 3 accumuli di [Waxed Armor]. All'inizio del turno, mescola un [Convulsion] nel Mazzo di Pesca della tua squadra."
  },
  State_2792_Name = {
    Text = "\"Gentildonna di Cera\""
  },
  State_2792_WeaponDesc = {
    Text = "All'inizio della battaglia, tutti gli alleati ottengono 3 accumuli di [Waxed Armor]. All'inizio del turno, mescola un [Convulsion] nel Mazzo di Pesca della tua squadra."
  },
  State_2793_Desc = {
    Text = "Stato@Lotta Disperata dell'Occhio di Pietra"
  },
  State_2793_Name = {
    Text = "Stato@Lotta Disperata dell'Occhio di Pietra"
  },
  State_2793_WeaponDesc = {
    Text = "Stato@Lotta Disperata dell'Occhio di Pietra"
  },
  State_2796_Desc = {
    Text = "Ogni volta che perdi PV, applica [Arg1] accumuli di Veleno a tutti i nemici. Aumenta il valore del Veleno di [Arg2] ogni turno."
  },
  State_2797_Desc = {
    Text = "All'inizio del turno, aggiungi alla tua mano un \"Parasole\" con [Arg1] Allerta ottenuto in questo turno. Dopo aver giocato 6 Carte, aumenta l'Allerta di tutti i \"Parasole\" nella tua mano di [Arg2]."
  },
  State_2798_Desc = {
    Text = "Il Vecchio Sommo Sacerdote Amorevole riduce il Costo di Arithmetica di 1 carta casuale nella tua mano di 1 finché non viene giocata quando applica uno Scudo."
  },
  State_2798_Name = {
    Text = "Compassione del Padre Supremo"
  },
  State_2798_WeaponDesc = {
    Text = "Il Vecchio Sommo Sacerdote Amorevole riduce il Costo di Arithmetica di 1 carta casuale nella tua mano di 1 finché non viene giocata quando applica uno Scudo."
  },
  State_2799_Desc = {
    Text = "Quando la Medusa lunare infligge Danno attivo, attiva [StateArg1] attacchi del Tentacolo sul bersaglio."
  },
  State_2799_Name = {
    Text = "Autoproliferazione"
  },
  State_2799_WeaponDesc = {
    Text = "Quando Hydromedusa infligge Danni, attiva [StateArg1] Attacchi del tentacolo sul bersaglio."
  },
  State_2800_Desc = {
    Text = "Danno, Scudo del Personaggio e Guarigione del Portatore +[StateArg1]%. (Temporaneo)"
  },
  State_2800_Name = {
    Text = "Stato@Prototipo Pugnale Danno Critico"
  },
  State_2801_Desc = {
    Text = "Aumenta gli accumuli di Dissoluzione Profonda quando si subisce Danno effettivo"
  },
  State_2801_Name = {
    Text = "Subire Danno aumenta le cariche di Dissoluzione."
  },
  State_2801_WeaponDesc = {
    Text = "Aumenta gli accumuli di Dissoluzione Profonda quando si subisce Danno effettivo"
  },
  State_2802_Desc = {
    Text = "A inizio turno, ottieni FOR temporanea"
  },
  State_2802_Name = {
    Text = "Ottieni FOR temporanea"
  },
  State_2804_Desc = {
    Text = "Danno, Scudo del Personaggio e Guarigione del Portatore +[StateArg1]%. (Temporaneo)"
  },
  State_2804_Name = {
    Text = "Stato@Prototipo Cannone Laser Danno Critico"
  },
  State_2805_Desc = {
    Text = "A fine turno, gli altri alleati ottengono Forza."
  },
  State_2805_Name = {
    Text = "\"Fiamma dell'Illuminazione\""
  },
  State_2807_Desc = {
    Text = "All'inizio del turno, aggiungi alla tua mano un \"Parasole\" con [Arg1] Allerta ottenuto in questo turno. Dopo aver giocato 6 Carte, aumenta l'Allerta di tutti i \"Parasole\" nella tua mano di [Arg2]."
  },
  State_2808_Desc = {
    Text = "A fine turno, genera 1 Livello di Fusione. Se c'è una carta Embrione in mano, recupera 15 PV."
  },
  State_2808_Name = {
    Text = "Pinza Emostatica Alienata"
  },
  State_2808_WeaponDesc = {
    Text = "A fine turno, genera 1 Livello di Fusione. Se c'è una carta Embrione in mano, recupera 15 PV."
  },
  State_2809_Desc = {
    Text = "Perdi permanentemente [Arg1] Forza al momento della raccolta. Cura [Arg2] HP ogni volta che infliggi Danno, fino a 6 volte per turno."
  },
  State_2809_Name = {
    Text = "Bacio della Lampreda"
  },
  State_2810_Desc = {
    Text = "A fine turno, ripristina il [Layer]% dei PV massimi."
  },
  State_2810_Name = {
    Text = "Autoguarigione"
  },
  State_2810_WeaponDesc = {
    Text = "Alla fine del turno del mostro, ripristina il [Layer]% della Salute massima"
  },
  State_2811_Desc = {
    Text = "Quando una Carta sintomo viene pescata, ottieni [Arg1] Forza. Per ogni Orazione maledetta o Reliquia maledetta posseduta, Tasso Crit. e Danno Crit. aumentano del 10%."
  },
  State_2812_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_2812_Name = {
    Text = "Non Risvegliato"
  },
  State_2813_Desc = {
    Text = "Perdi Arithmetica a inizio turno"
  },
  State_2813_Name = {
    Text = "Errore di calcolo!"
  },
  State_2814_Desc = {
    Text = "Vincere la battaglia trasforma l'Orazione in una potente e pericolosa Orazione maledetta."
  },
  State_2817_Desc = {
    Text = "Ogni accumulo riduce il danno subito di [StateArg1]. Si perde 1 accumulo per ogni Colpo Critico."
  },
  State_2817_Name = {
    Text = "Armatura Cerata"
  },
  State_2817_WeaponDesc = {
    Text = "Immune agli stati anomali, rimosso in caso di colpo critico subito."
  },
  State_2818_Desc = {
    Text = "Si divide in Triangolo di Dissoluzione A e Triangolo di Dissoluzione B."
  },
  State_2818_Name = {Text = "Scissione"},
  State_2818_WeaponDesc = {
    Text = "Si divide in Triangolo di Dissoluzione A e Triangolo di Dissoluzione B."
  },
  State_2820_Desc = {
    Text = "Quando giocata, ottieni prima [StateArg1] <PowerIconKeywords:FOR> Temp., poi risolvi gli effetti della carta. (I suoi effetti di danno beneficeranno di questa FOR.)"
  },
  State_2820_Name = {
    Text = "<Rune_15:Detonazione>"
  },
  State_2821_Name = {
    Text = "Immunità temporanea a Vulnerabile"
  },
  State_2823_Desc = {
    Text = "Unicità di Squadra: all'inizio del combattimento, applica 2 livelli di <VulnerabilityIconKeywords:Vulnerabile> ai nemici in prima fila. All'inizio del turno, i nemici in Stato Vulnerabile perdono <PowerIconKeywords:Potere> Temporaneo pari al <WeaponEffect_Num:[StateArg1]%> dell'ATT del portatore. Se il Reame attuale è \"Caro\", dopo che il portatore scatena \"Esaltazione\", Fusione Embrionale +<WeaponEffect_Num:[Blood:StateArg2]>."
  },
  State_2823_WeaponDesc = {
    Text = "All'inizio del combattimento, applica 2 livelli di <VulnerabilityIconKeywords:Vulnerabile> ai nemici in prima fila. All'inizio del turno, i nemici in Stato Vulnerabile perdono <WeaponEffect_Num:[Power:DescArg1]> punti di <PowerIconKeywords:Potere> Temporaneo. Se il Reame attuale è \"Caro\", dopo che il portatore scatena \"Esaltazione\", Fusione Embrionale +<WeaponEffect_Num:[Blood:StateArg2]>."
  },
  State_2825_Desc = {
    Text = "Limite slot ultra mostro"
  },
  State_2825_Name = {
    Text = "Limite slot ultra mostro"
  },
  State_2825_WeaponDesc = {
    Text = "Limite slot ultra mostro"
  },
  State_2826_Desc = {
    Text = "Quando 2 carte con Costo di Arithmetica inferiore a quello della carta precedente vengono giocate consecutivamente, il Risvegliatore con il minor numero di Aliemus ottiene 50 Aliemus."
  },
  State_2826_Name = {
    Text = "Creazione Reliquia Arcana"
  },
  State_2827_Desc = {
    Text = "Numero di colpi e Danno aumentati."
  },
  State_2827_Name = {
    Text = "<CardKeyWord:Potenziamento>"
  },
  State_2829_Desc = {
    Text = "Ottieni [Layer] FOR dopo aver inflitto Danno effettivo."
  },
  State_2829_Name = {
    Text = "\"Persona Caotica\""
  },
  State_2830_Desc = {
    Text = "Per ogni Risvegliato di classe [Aequor] nella squadra, i PV Max (Non completo), la Difesa e l'Attacco dell'intera squadra aumentano del 50%."
  },
  State_2830_Name = {
    Text = "Potenziamento di Aequor"
  },
  State_2830_WeaponDesc = {
    Text = "Per ogni Risvegliato di classe [Aequor] nella squadra, i PV Max (Non completo), la Difesa e l'Attacco dell'intera squadra aumentano del 50%."
  },
  State_2832_Desc = {
    Text = "Danno, Scudo del Personaggio e Guarigione del Portatore +[StateArg1]%. (Temporaneo)"
  },
  State_2832_Name = {
    Text = "Stato@Prototipo Cannone Laser Resistenza"
  },
  State_2833_Desc = {
    Text = "Pesca 1 carta a inizio turno. Ogni carta pescata altera casualmente il proprio Costo di Arithmetica (0-4)."
  },
  State_2835_Desc = {
    Text = "Per ogni Divorare, ruba [Arg1] FOR temporanea da tutti i nemici."
  },
  State_2836_Name = {
    Text = "Stato@Cecità Obbedienza Maledetta"
  },
  State_2837_Name = {
    Text = "Stato@Cecità Obbedienza Maledetta"
  },
  State_2838_Name = {
    Text = "Stato@Cecità Obbedienza Maledetta"
  },
  State_2840_Desc = {
    Text = "Subisci [Layer] <FixedDamage:DAN Puro> e rimuovi [DescArg1]% degli accumuli alla fine del turno. Quando si ripristina la Vita, rimuovi il doppio degli accumuli di Sanguinamento rispetto alla quantità curata."
  },
  State_2840_Name = {
    Text = "<BleedingColour:Salasso>"
  },
  State_2840_WeaponDesc = {
    Text = "A fine turno, subisci [Layer] DAN e rimuovi questo stato. Ogni cura riduce gli accumuli della metà."
  },
  State_2842_Desc = {
    Text = "Quando giocata, ottieni [StateArg1] <RetaliateIconKeywords:Contrattacco>, poi infliggi Danni Reali a tutti i nemici pari al [StateArg2]% del tuo <RetaliateIconKeywords:Contrattacco>."
  },
  State_2842_Name = {
    Text = "<Rune_9:Spina>"
  },
  State_2843_Desc = {
    Text = "La tua squadra ottiene [StateArg1] cariche di Scudo per ogni carta giocata. Dura 1 turno."
  },
  State_2843_Name = {
    Text = "Bufera di Piume"
  },
  State_2843_WeaponDesc = {
    Text = "La tua squadra ottiene [StateArg1] cariche di Scudo per ogni carta giocata. Dura 1 turno."
  },
  State_2844_Desc = {
    Text = "Ottieni una Barriera che blocca 1 Danno la prima volta che perdi PV in ogni battaglia."
  },
  State_2845_Name = {
    Text = "Accessorio: Mormorii in Sogno del Cimitero"
  },
  State_2845_WeaponDesc = {
    Text = "A inizio livello, la Resistenza alla Morte aumenta del 25%. Dopo aver attivato la Resistenza alla Morte, il portatore ottiene 50 Aliemus."
  },
  State_2846_Desc = {
    Text = "Immune a una morte, ripristina [Arg1] PV dopo l'attivazione, e disabilita permanentemente questa Reliquia."
  },
  State_2846_Name = {
    Text = "Bambola sostituta"
  },
  State_2847_Desc = {
    Text = "Ogni volta che un Risvegliato Cacciato usa una carta, viene aggiunto 1 Marchio di Caccia, e pesca un numero di carte pari alla metà degli accumuli attuali di Marchio di Caccia."
  },
  State_2847_Name = {
    Text = "Cerimonia di Caccia"
  },
  State_2849_Desc = {
    Text = "Ogni volta che perdi HP, ottieni [Arg1] Forza, accumulabile fino a 10 volte. Al massimo degli accumuli, ripristina il 25% degli HP persi."
  },
  State_2849_Name = {
    Text = "Onore Supremo"
  },
  State_2853_Desc = {
    Text = "Conteggio reliquia Poltrona Eterna"
  },
  State_2854_Desc = {
    Text = "Nessun Aliemus per i Risvegliati dopo la morte."
  },
  State_2854_Name = {Text = "Egoismo"},
  State_2854_WeaponDesc = {
    Text = "Nessun Aliemus per i Risvegliati dopo la morte."
  },
  State_2855_Desc = {
    Text = "Il Danno da \"Colpo\" aumenta del [StateArg1]%, per [Layer] turni."
  },
  State_2855_Name = {
    Text = "Impasse Sopravvissuta: Colpo"
  },
  State_2855_WeaponDesc = {
    Text = "In questo turno, i DAN delle tue Carte Colpo sono potenziati del [Layer]%."
  },
  State_2856_Desc = {
    Text = "Unico per Squadra: Generazione di Scudo del Personaggio del Portatore +<WeaponEffect_Num:[StateArg1]%>. Quando si genera uno Scudo del Personaggio, tutti gli alleati ottengono un Tasso Critico Temporaneo di <WeaponEffect_Num:[StateArg3]%> e Keyflare dalla Rigenerazione Keyflare del Portatore per <WeaponEffect_Num:[StateArg4]%>, fino a 2 volte per turno. Se il reame corrente è \"Aequor\", ogni volta che un Tentacolo attacca, il Portatore ottiene 1 punto di Aliemus, fino a <WeaponEffect_Num:[StateArg2]> per turno."
  },
  State_2856_WeaponDesc = {
    Text = "La Generazione di Scudo del Personaggio del Portatore aumenta di <WeaponEffect_Num:[StateArg1]％>. Quando viene generato uno Scudo del Personaggio, tutti gli alleati ottengono <WeaponEffect_Num:[StateArg3]％> di Tasso critico temporaneo e <WeaponEffect_Num:[StateArg4]%> della Rigenerazione Keyflare del Portatore come Keyflare, fino a 2 volte per turno. Se il reame corrente è \"Aequor\", ogni volta che un Tentacolo attacca, il Portatore ottiene 1 Aliemus, fino a <WeaponEffect_Num:[StateArg2]> per turno."
  },
  State_2857_Desc = {
    Text = "Tutti i Risvegliatori ottengono 10 Aliemus a inizio turno. Gli HP Massimi sono ridotti del 50%."
  },
  State_2858_Name = {
    Text = "Ottieni 2 cariche extra di Barriera quando giocata"
  },
  State_2859_Desc = {
    Text = "All'inizio della battaglia, questa carta è fissata in mano."
  },
  State_2859_Name = {
    Text = "<CardKeyWord:Innato>"
  },
  State_2860_Desc = {
    Text = "Al momento del pescaggio, riduci i PV Max propri del 10%. Dopo l'uso, aumenta il Danno Crit. di tutti i Risvegliatori del 100% per questo turno. Non può essere venduta."
  },
  State_2860_Name = {
    Text = "Stato Maledizione Dissoluzione"
  },
  State_2860_WeaponDesc = {
    Text = "Al momento del pescaggio, riduci i PV Max propri del 10%. Dopo l'uso, aumenta il Danno Crit. di tutti i Risvegliatori del 100% per questo turno. Non può essere venduta."
  },
  State_2861_Name = {
    Text = "(Rimanenti:[Layer])"
  },
  State_2862_Desc = {
    Text = "A fine turno, subisci un'istanza aggiuntiva di danno da Veleno."
  },
  State_2862_Name = {
    Text = "Debolezza Fisica"
  },
  State_2863_Desc = {
    Text = "Livello di Evoluzione"
  },
  State_2863_Name = {
    Text = "Livello di Evoluzione"
  },
  State_2863_WeaponDesc = {
    Text = "Livello di Evoluzione"
  },
  State_2864_Desc = {
    Text = "\"24\" è stato Risvegliato. Usa l'ultimo \"Salvami\" per trovare la tua occasione!"
  },
  State_2864_Name = {
    Text = "\"24\"Risveglio!"
  },
  State_2864_WeaponDesc = {
    Text = "A inizio del turno successivo, ottieni Scudo del Personaggio pari alla quantità di HP persi nel turno precedente."
  },
  State_2866_Desc = {
    Text = "Unicità di Squadra: Limite Massima della Mano +2, al termine del turno ottieni Energia-S pari al <WeaponEffect_Num:[StateArg1]%> di Ricarica della chiave d'argento del portatore. Dopo ogni rilascio di Posse, tutti i Risvegliatori ottengono <WeaponEffect_Num:[StateArg2]> punti di Aliemus; se il Reame attuale è \"Caro\", la Fusione Embrionale aumenta di <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_2866_WeaponDesc = {
    Text = "Limite Massima della Mano +2, al termine del turno ottieni <WeaponEffect_Num:[DescArg1]> punti di Energia-S. Dopo ogni rilascio di Posse, tutti i Risvegliatori ottengono <WeaponEffect_Num:[StateArg2]> punti di Aliemus; se il Reame attuale è \"Caro\", la Fusione Embrionale aumenta di <WeaponEffect_Num:+[Blood:StateArg3]> ."
  },
  State_2868_Desc = {
    Text = "A fine turno, per ogni carta non giocata in mano, tutti i Risvegliatori ottengono 2 Aliemus."
  },
  State_2871_Desc = {
    Text = "Evoca 1 Triangolo di Dissoluzione con HP equivalenti quando gli HP scendono sotto il 50% ([StateArg1])"
  },
  State_2871_Name = {Text = "Evocazione"},
  State_2871_WeaponDesc = {
    Text = "Evoca 1 Triangolo di Dissoluzione con HP equivalenti quando gli HP scendono sotto il 50% ([StateArg1])"
  },
  State_2874_Desc = {
    Text = "Quando il Risveglio viene osservato dal Cacciatore di Teschi, giocare la sua carta permette di pescare 2 carte extra."
  },
  State_2875_Desc = {
    Text = "Quando giocata, <EmbryoFusionIconKeywords:Fusione Embrionale> +[StateArg1]."
  },
  State_2875_Name = {
    Text = "<Rune_12_High:Av. Sete di Sangue>"
  },
  State_2875_WeaponDesc = {
    Text = "Dopo aver giocato, Fusione Embrionale+ [Blood:StateArg1]."
  },
  State_2876_Desc = {
    Text = "Dopo la Battaglia, ottieni 50 Sigilli Neri aggiuntivi, ma sviluppi un Sintomo casuale."
  },
  State_2877_Desc = {
    Text = "Ogni volta che la Dama in Rosso infligge DAN, ottiene [StateArg2] FOR temporanea."
  },
  State_2877_Name = {
    Text = "Privilegio della Dama Ospite"
  },
  State_2878_Desc = {
    Text = "Numero di colpi aumentato di 1, ma Danno ridotto del 25%."
  },
  State_2878_Name = {Text = "Frenesia"},
  State_2878_WeaponDesc = {
    Text = "Numero di colpi aumentato di 1, ma Danno ridotto del 25%."
  },
  State_2879_Name = {
    Text = "Lumaca Dolce"
  },
  State_2879_WeaponDesc = {
    Text = "Dopo aver usato \"Annientamento\", se nella Postura Mare Tranquillo, gli effetti di Scudo e Guarigione del portatore in questo turno +30%."
  },
  State_2880_Name = {
    Text = "Stato@Apostolo del Mare Illuminare 7"
  },
  State_2881_Desc = {
    Text = "Ogni volta che 1 \"Sacramento\" viene trasformato in \"Ossessione\", il DAN Base inflitto da Miryam in questa battaglia aumenta del 15%."
  },
  State_2881_Name = {
    Text = "Crollo dell'illusione"
  },
  State_2883_Desc = {
    Text = "Unicità di Squadra: Dopo che il portatore infligge un Danno attivo, c'è una probabilità del <WeaponEffect_Num:[StateArg1]%> di pescare 1 delle sue Carte di comando e ridurne il Costo di Arithmetica di 1. Questo effetto si attiva solo una volta per turno."
  },
  State_2883_WeaponDesc = {
    Text = "Dopo che il portatore infligge un Danno attivo, c'è una probabilità del <WeaponEffect_Num:[StateArg1]%> di pescare 1 delle sue Carte di comando e ridurne il Costo di Arithmetica di 1. Questo effetto si attiva solo una volta per turno."
  },
  State_2884_Name = {
    Text = "Infliggi <PunctureDamagewords:Danni Perforanti>. Riduci di 1 il Costo di Arithmetica della carta con il costo più alto nella tua mano."
  },
  State_2885_Name = {
    Text = "Status: Pesca 2 carte all'inizio di ogni turno"
  },
  State_2887_Desc = {
    Text = "Unico per Squadra: Dopo che il Portatore ha terminato di usare Esaltazione, il suo Danno Crit. è aumentato del <WeaponEffect_Num:[StateArg1]%> per il resto di questo turno. Le carte del Portatore In Mano hanno una probabilità del <WeaponEffect_Num:[StateArg2]%> di ridurre il Costo di Arithmetica di 1 in questo turno."
  },
  State_2887_WeaponDesc = {
    Text = "Dopo che il Portatore usa Esaltazione, il suo Danno Crit. aumenta del <WeaponEffect_Num:[StateArg1]%> per il resto del turno. Inoltre, c'è una probabilità del <WeaponEffect_Num:[StateArg2]%> che tutte le carte in mano al Portatore riducano il proprio Costo di Arithmetica di 1 punto durante questo turno."
  },
  State_2888_Desc = {
    Text = "Se un \"Embrione\" è In Mano, ne consuma 1 per attivare l'effetto Divorare."
  },
  State_2888_Name = {
    Text = "<DevouredIconKeywords:Divorare>"
  },
  State_2888_WeaponDesc = {
    Text = "Esaurisci gli embrioni in mano, innescando un potente Effetto divorante."
  },
  State_2889_Name = {
    Text = "Scegli un Risvegliato per ottenere <Energy:[DescArg1]> Aliemus"
  },
  State_2890_Desc = {
    Text = "Quando inizia la battaglia, applica 1 accumulo di Fragile alla tua squadra."
  },
  State_2890_Name = {
    Text = "Penetrazione armatura"
  },
  State_2890_WeaponDesc = {
    Text = "Quando inizia la battaglia, applica 1 accumulo di Fragile alla tua squadra."
  },
  State_2891_Name = {
    Text = "Potenziamento Recupero Iniziale Aliemus"
  },
  State_2892_Desc = {
    Text = "A fine turno, ripristina [Layer] PV."
  },
  State_2892_Name = {
    Text = "Recupero PV Ritardato"
  },
  State_2892_WeaponDesc = {
    Text = "Fino a fine turno, cura [Layer] PV per ogni uccisione."
  },
  State_2897_Desc = {
    Text = "All'Avvento della Genesi, riduce la FOR temporanea dei nemici."
  },
  State_2897_Name = {
    Text = "Paura dell'Alienus"
  },
  State_2899_Desc = {
    Text = "Se l'avversario ha 4 o più carte In Mano, ottieni [StateArg1] Scudo del Personaggio quando subisci Danno."
  },
  State_2899_Name = {
    Text = "Forma Serpentina"
  },
  State_2900_Desc = {
    Text = "I DAN inflitti sono aumentati di [Layer] in questa battaglia."
  },
  State_2900_Name = {Text = "Forza"},
  State_2900_WeaponDesc = {
    Text = "I DAN inflitti sono aumentati di [Layer] in questa battaglia."
  },
  State_2901_Desc = {
    Text = "[Exalt] conferisce 20 Aliemus."
  },
  State_2901_Name = {
    Text = "Reliquia Velo della Divinità Senza Nome"
  },
  State_2901_WeaponDesc = {
    Text = "[Exalt] conferisce 20 Aliemus."
  },
  State_2902_Desc = {
    Text = "Cervello in una Giara ripristina il doppio dei HP."
  },
  State_2902_Name = {
    Text = "Carne Distaccata"
  },
  State_2902_WeaponDesc = {
    Text = "Cervello in una Giara ripristina il doppio dei HP."
  },
  State_2903_Desc = {
    Text = "Danno, Scudo del Personaggio e Guarigione del Portatore +[StateArg1]%. (Temporaneo)"
  },
  State_2903_Name = {
    Text = "Stato@Pugnale Prototipo Critico"
  },
  State_2904_Desc = {
    Text = "Dopo aver subito Danno effettivo, ottieni 10 Scudo del Personaggio."
  },
  State_2904_Name = {Text = "Riserva"},
  State_2904_WeaponDesc = {
    Text = "Dopo aver subito Danno effettivo, ottieni 10 Scudo del Personaggio."
  },
  State_2905_Desc = {
    Text = "Unico per Squadra: Lo scudo generato dall'Esaltazione del portatore è aumentato del <WeaponEffect_Num:[StateArg2]%>. Dopo che il portatore rilascia l'Esaltazione, ottiene <PowerIconKeywords:FOR> Temporanea pari al <WeaponEffect_Num:[StateArg1]%> della DIF del portatore. Se la tua squadra è in stato di <FragileIconKeywords:Fragilità>, l'effetto è raddoppiato."
  },
  State_2905_WeaponDesc = {
    Text = "L'\"Esaltazione\" del portatore aumenta la Generazione Scudo di <WeaponEffect_Num:[StateArg2]%>. Dopo che il portatore rilascia l'\"Esaltazione\", ottiene [Power:DescArg1] <PowerIconKeywords:FOR> Temporanea. Se la squadra è in stato di <FragileIconKeywords:Fragile>, l'effetto è raddoppiato."
  },
  State_2906_Desc = {
    Text = "Dopo aver inflitto Danno effettivo, riduci temporaneamente la Forza della tua squadra di [Layer]."
  },
  State_2906_Name = {
    Text = "Scarica Paralizzante"
  },
  State_2909_Desc = {
    Text = "Possiede [Layer] Aliemus. Se Aliemus è maggiore o uguale a 5, l'intenzione diventa \"Macabro Banchetto Contorto\" e Aliemus si recupererà al diminuire."
  },
  State_2909_Name = {
    Text = "Stato@Mostro 24 Banchetto dei Morti Contorti Contrattacco"
  },
  State_2909_WeaponDesc = {
    Text = "Possiede [Layer] Aliemus. Se Aliemus è maggiore o uguale a 5, l'intenzione diventa \"Macabro Banchetto Contorto\" e Aliemus si recupererà al diminuire."
  },
  State_2910_Desc = {
    Text = "Unico per Squadra: All'inizio dell'esplorazione, aggiungi un'\"Intuizione\" e l'\"Attacco\" del portatore al mazzo. Il DAN Base dell'\"Attacco\" del portatore aumenta del <WeaponEffect_Num:[StateArg1]%>, e dopo averlo giocato, c'è una probabilità del <WeaponEffect_Num:[StateArg2]%> di pescare 1 carta. Questo effetto può attivarsi al massimo una volta per turno. Se il Reame corrente è \"Ultra\" e durante il Turno Ultra, l'\"Attacco\" inserirà 1 \"Intuizione\" nella mano, attivandosi al massimo una volta durante quel turno."
  },
  State_2910_WeaponDesc = {
    Text = "All'inizio dell'esplorazione, aggiungi una carta di \"Intuizione\" e un \"Colpo\" del portatore al mazzo. Il DAN Base del \"Colpo\" del portatore aumenta del <WeaponEffect_Num:[StateArg1]%>, e c'è una probabilità del <WeaponEffect_Num:[StateArg2]%> di pescare 1 carta dopo averlo giocato. Questo effetto può attivarsi un massimo di 1 volta per turno. Se il reame attuale è \"Ultra\" e durante il Turno Ultra, \"Colpo\" metterà 1 \"Intuizione\" in mano, attivandosi un massimo di 1 volta in quel turno."
  },
  State_2911_Desc = {
    Text = "Stato@Contatore del Mondo Fantasma Bianco Puro"
  },
  State_2911_Name = {
    Text = "Stato@Conteggio Mondo Fantasma Bianco Puro"
  },
  State_2911_WeaponDesc = {
    Text = "Stato@Contatore del Mondo Fantasma Bianco Puro"
  },
  State_2912_Desc = {
    Text = "Il bersaglio sei tu! Dopo essere stata giocata, la Guardia Scelta del Navigatore ottiene [StateArg1] FOR temporanea e rimuove il Marchio dell'Abisso."
  },
  State_2912_Name = {
    Text = "<CardKeyWord:Marchio dell'Abisso>"
  },
  State_2912_WeaponDesc = {
    Text = "Dopo aver giocato la carta, la Guardia del corpo del Sommozzatore Profondo ottiene [StateArg1] FOR temporanea."
  },
  State_2913_Desc = {
    Text = "All'inizio della battaglia, diventa Vulnerabile per 3 turni."
  },
  State_2913_Name = {
    Text = "Reliquia Uncino Sinistro 2"
  },
  State_2913_WeaponDesc = {
    Text = "All'inizio della battaglia, diventa Vulnerabile per 3 turni."
  },
  State_2914_Desc = {
    Text = "Quando i PV sono sotto il 50%, l'Intenzione cambia per evocare un [Dissolution Triangle] con PV equivalenti."
  },
  State_2914_Name = {Text = "Fissione"},
  State_2914_WeaponDesc = {
    Text = "Quando i PV sono sotto il 50%, l'Intenzione cambia per evocare un [Dissolution Triangle] con PV equivalenti."
  },
  State_2915_Desc = {
    Text = "Aumenta il Danno di \"Catena di risentimento\" di [Layer] volte."
  },
  State_2915_Name = {Text = "Odio"},
  State_2915_WeaponDesc = {
    Text = "Aumenta il Danno di \"Catena di risentimento\" di [Layer] volte."
  },
  State_2917_Desc = {
    Text = "Alla fine del turno, per ogni carta rimanente in mano, ottieni 1 Arithmetica all'inizio del turno successivo."
  },
  State_2917_Name = {
    Text = "Stato@Chiave d'argento Fantasma: Calcolo"
  },
  State_2918_Desc = {
    Text = "Riduce i danni subiti del 99%. Rimuovi 1 carica dopo aver subito Danno attivo, e ripristina a 3 cariche a inizio turno."
  },
  State_2918_Name = {
    Text = "\"Vestigia Immortali\""
  },
  State_2918_WeaponDesc = {
    Text = "Riduce i danni subiti del 99%. Rimuovi 1 carica dopo aver subito Danno attivo, e ripristina a 3 cariche a inizio turno."
  },
  State_2919_Desc = {
    Text = "Stato@Avanzamento Immagine Fuoco di Giada Smeraldo"
  },
  State_2919_Name = {
    Text = "Stato@Avanzamento Immagine Fuoco di Giada Smeraldo"
  },
  State_2919_WeaponDesc = {
    Text = "Stato@Avanzamento Immagine Fuoco di Giada Smeraldo"
  },
  State_2922_Desc = {
    Text = "Per ogni 1 Arithmetica consumata, il Risvegliatore corrispondente ottiene 2 Aliemus."
  },
  State_2923_Desc = {
    Text = "A fine turno, aumenta la Forza di [Layer]."
  },
  State_2923_Name = {
    Text = "Rituale della Discesa Divina"
  },
  State_2923_WeaponDesc = {
    Text = "Ottieni [Layer] FOR alla fine di ogni turno."
  },
  State_2925_Desc = {
    Text = "+1 accumulo per ogni istanza di Danno inflitta da Fuoco Smeraldo"
  },
  State_2925_Name = {
    Text = "Conteggio Riflesso di Smeraldo"
  },
  State_2925_WeaponDesc = {
    Text = "+1 accumulo per ogni istanza di Danno inflitta da Fuoco Smeraldo"
  },
  State_2927_Name = {
    Text = "Stato@Mutamento Allucinazioni Maledette"
  },
  State_2929_Desc = {
    Text = "Unicità di Squadra: ogni volta che il portatore infligge 1 Danno, c'è una probabilità del <WeaponEffect_Num:[StateArg3]%> che il portatore ottenga il 2% di DAN CRIT temporanei. Dopo che il portatore rilascia l'Esaltazione, infligge 3 volte Danno attivo pari al <WeaponEffect_Num:[StateArg1]%> dell'ATT del portatore a nemici casuali. Se il Reame attuale è \"Caro\", ogni volta che il portatore Divora un Embrione, la Fusione Embrionale aumenta di <WeaponEffect_Num:[Blood:StateArg2]> ."
  },
  State_2929_WeaponDesc = {
    Text = "Ogni volta che il portatore infligge 1 Danno, c'è una probabilità del <WeaponEffect_Num:[StateArg3]%> che il portatore ottenga il 2% di DAN CRIT temporanei. Dopo che il portatore rilascia l'Esaltazione, infligge 3 volte [DescArg1] punti di Danno attivo a nemici casuali. Se il Reame attuale è \"Caro\", ogni volta che il portatore Divora un Embrione, la Fusione Embrionale aumenta di <WeaponEffect_Num:+[Blood:StateArg2]> ."
  },
  State_2930_Name = {
    Text = "Stato@George@Ottieni Potere alla morte"
  },
  State_2931_Desc = {
    Text = "Ogni volta che Divori, rubi 4 FOR temporanea a tutti i nemici."
  },
  State_2931_Name = {
    Text = "Agata del Baco da Seta Alterata"
  },
  State_2933_Name = {
    Text = "Accessorio: Gemello Contorto Bianco"
  },
  State_2933_WeaponDesc = {
    Text = "All'inizio dei turni pari, aggiungi la \"Difesa\" del portatore con Esaurimento e Fugace alla tua mano."
  },
  State_2934_Desc = {
    Text = "Tutti i Danni attivi e Danni da tentacolo subiti +[DescArg1]%."
  },
  State_2934_Name = {
    Text = "<VulnerabilityColour:Vulnerabile>"
  },
  State_2934_WeaponDesc = {
    Text = "Tutti i Danni subiti sono aumentati del 50%."
  },
  State_2937_Desc = {
    Text = "Quando si ottiene uno Scudo del Personaggio per la 3ª volta, si ottiene anche un pari ammontare di Contatore."
  },
  State_2938_Desc = {
    Text = "Pesca 1 carta a inizio turno e puoi scegliere di conservare 1 carta in mano a fine turno."
  },
  State_2939_Name = {
    Text = "Immunità alla Fragilità"
  },
  State_2940_Desc = {
    Text = "Effetto Rigenerazione migliorato."
  },
  State_2940_Name = {
    Text = "Crescere in Potenza con il Sangue Aberrante"
  },
  State_2941_Desc = {
    Text = "Quando giocata, infliggi [StateArg1] <IntoxicationIconKeywords:Veleno> a tutti i nemici, poi attiva il [StateArg2]% del <IntoxicationIconKeywords:Veleno> di ciascun nemico."
  },
  State_2941_Name = {
    Text = "<Rune_10:Tossina>"
  },
  State_2942_Desc = {
    Text = "A fine turno, ripristina il [Layer]% dei PV agli altri alleati e rimuove il Danno continuato."
  },
  State_2942_Name = {
    Text = "Medico di Battaglia"
  },
  State_2946_Desc = {
    Text = "Combo frenetica conferisce uno Scudo del Personaggio estremamente elevato."
  },
  State_2946_Name = {
    Text = "\"Fortezza Immobile\""
  },
  State_2946_WeaponDesc = {
    Text = "Combo frenetica conferisce uno Scudo del Personaggio estremamente elevato."
  },
  State_2947_Name = {
    Text = "Dissoluzione 2"
  },
  State_2948_Desc = {
    Text = "Modifica l'Arithmetica della carta prima di giocarla"
  },
  State_2948_Name = {
    Text = "Modifica l'Arithmetica della carta prima di giocarla"
  },
  State_2948_WeaponDesc = {
    Text = "Modifica l'Arithmetica della carta prima di giocarla"
  },
  State_2949_Name = {
    Text = "Battaglia della Ruota del destino: Rinuncia all'Orazione"
  },
  State_2951_Desc = {
    Text = "Reliquia Poltrona Eterna"
  },
  State_2951_Name = {
    Text = "Guanti silenziati"
  },
  State_2952_Desc = {
    Text = "Alla fine del turno, ripristina [Layer] PV. Rimuovi 1 accumulo ogni 5 PV persi."
  },
  State_2952_Name = {
    Text = "Rigenerazione"
  },
  State_2954_Name = {
    Text = "Stato@2-8Mostro24@Salvami"
  },
  State_2955_Desc = {
    Text = "Tutti i nemici perdono PV. Permanente, Distruggere."
  },
  State_2955_Name = {
    Text = "<CardKeyWord:Fine dell'Illusione>"
  },
  State_2955_WeaponDesc = {
    Text = "Tutti i nemici perdono PV. Permanente, Distruggere."
  },
  State_2956_Desc = {
    Text = "Ogni istanza di danno subito conferisce a tutti i Risvegliati [StateArg1] Aliemus."
  },
  State_2956_Name = {
    Text = "Raggio Fantasmatico"
  },
  State_2956_WeaponDesc = {
    Text = "Ogni istanza di danno subito conferisce a tutti i Risvegliati [StateArg1] Aliemus."
  },
  State_2957_Desc = {
    Text = "Dopo la morte, richiama un [Dissolution Triangle] con 1/3 dei tuoi PV nella posizione."
  },
  State_2957_Name = {
    Text = "Dissoluzione"
  },
  State_2957_WeaponDesc = {
    Text = "Dopo la morte, richiama un [Dissolution Triangle] con 1/3 dei tuoi PV nella posizione."
  },
  State_2960_Desc = {
    Text = "Nei turni pari, ottieni 2 Arithmetica se la tua Arithmetica è 0."
  },
  State_2960_Name = {
    Text = "Puzzle Antico"
  },
  State_2960_WeaponDesc = {
    Text = "Nei turni pari, ottieni 2 Arithmetica se la tua Arithmetica è 0."
  },
  State_2961_Desc = {
    Text = "Unico per Squadra: l'Effetto <IntoxicationIconKeywords:Veleno> del Portatore è aumentato del <WeaponEffect_Num:[StateArg1]%>. Prima che il Portatore rilasci un'Esaltazione, applica Veleno pari al <WeaponEffect_Num:[StateArg2]%> del suo ATT a tutti i nemici. Dopo aver usato un Seguito, il Portatore ottiene <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_2961_WeaponDesc = {
    Text = "Il Danno da <IntoxicationIconKeywords:Veleno> del Portatore è aumentato del <WeaponEffect_Num:[StateArg1]%>. Prima che il Portatore rilasci un'Esaltazione, infligge prima <WeaponEffect_Num:[Poison:DescArg1]> accumuli di Veleno a tutti i nemici. Dopo aver usato il Seguito, il Portatore ottiene <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_2962_Desc = {
    Text = "Quando giocata, infliggi [StateArg1] turni di <WeaknessIconKeywords:Debolezza> a tutti i nemici."
  },
  State_2962_Name = {
    Text = "<Rune_2:Debolezza>"
  },
  State_2965_Name = {
    Text = "Stato@Ancella Crescente Illuminare 7"
  },
  State_2967_Desc = {
    Text = "Quando si usano Carte sintomo, lo stato di Pandia alterna tra \"Irrequieta\" e \"Dissolutezza\". Irrequieta: istanze di Danno attivo +1, FOR ridotta. Dissolutezza: istanze di Danno attivo -1, FOR aumentata."
  },
  State_2967_Name = {
    Text = "Pandia, risvegliati!"
  },
  State_2967_WeaponDesc = {
    Text = "A inizio del turno successivo, ottieni Scudo del Personaggio pari alla quantità di HP persi nel turno precedente."
  },
  State_2968_Name = {
    Text = "Stato@Stage2_14Battle8Bubble4"
  },
  State_2969_Name = {
    Text = "Stato@Level2_14Battle8Bubble5"
  },
  State_2970_Desc = {
    Text = "Progenie Primordiale"
  },
  State_2970_Name = {
    Text = "Progenie Primordiale"
  },
  State_2970_WeaponDesc = {
    Text = "Progenie Primordiale"
  },
  State_2971_Desc = {
    Text = "Stato@Prologo: Riduci Vita della Metà"
  },
  State_2971_Name = {
    Text = "Stato@Prologo: Riduci Vita della Metà"
  },
  State_2971_WeaponDesc = {
    Text = "Stato@Prologo: Riduci Vita della Metà"
  },
  State_2972_Name = {
    Text = "Stato@Level2_14Battle8Bubble2"
  },
  State_2973_Name = {
    Text = "Stato@Level2_14Battle8Bubble3"
  },
  State_2975_Desc = {
    Text = "I primi 5 effetti Balzo in ogni battaglia vengono attivati una volta aggiuntiva."
  },
  State_2976_Desc = {
    Text = "A fine turno, se il tuo Scudo del Personaggio è 0 o un multiplo di 10, ottieni [Arg1] Scudo del Personaggio. Se i tuoi HP sono un multiplo di 10, ottieni [Arg2] Forza."
  },
  State_2976_Name = {
    Text = "Segnale di soccorso"
  },
  State_2977_Desc = {
    Text = "Nei turni dispari, se hai 0 carte in mano, pesca 2 carte."
  },
  State_2977_Name = {
    Text = "Puzzle Antico"
  },
  State_2977_WeaponDesc = {
    Text = "Nei turni dispari, se hai 0 carte in mano, pesca 2 carte."
  },
  State_2978_Desc = {
    Text = "Perde 1 accumulo per ogni 1 danno subito. Passa alla modalità Difesa quando gli accumuli raggiungono 0."
  },
  State_2978_Name = {
    Text = "Conteggio Carte"
  },
  State_2978_WeaponDesc = {
    Text = "Perde 1 accumulo per ogni 1 danno subito. Passa alla modalità Difesa quando gli accumuli raggiungono 0."
  },
  State_2979_Desc = {
    Text = "Unico per Squadra: Veleno e Generazione di Scudo del Personaggio del Portatore +<WeaponEffect_Num:[StateArg3]%>. Il Tasso di Crit. e il Danno Crit. di \"Colpo\" del Portatore aumentano di <WeaponEffect_Num:[StateArg1]%>, e ottiene uno Scudo del Personaggio pari a <WeaponEffect_Num:[StateArg2]%> dei PV massimi. L'Effetto Scudo può attivarsi solo una volta per turno."
  },
  State_2979_Name = {
    Text = "Grazia Attraverso il Dolore"
  },
  State_2979_WeaponDesc = {
    Text = "Gli effetti di Veleno e Generazione di Scudo del Personaggio del Portatore aumentano del <WeaponEffect_Num:[StateArg3]%>. Il Tasso Crit. e il Danno Crit. del \"Colpo\" del Portatore aumentano del <WeaponEffect_Num:[StateArg1]%>, e ottiene uno Scudo del Personaggio pari al [StateArg2]% ([DescArg1]) dei PV massimi, con l'effetto scudo attivabile una volta per turno."
  },
  State_2983_Desc = {
    Text = "Se conservata In Mano durante la fase di scarto, Esaurimento. Non riapparirà."
  },
  State_2983_Name = {
    Text = "<NothingnessIconKeywords:Effimero>"
  },
  State_2983_WeaponDesc = {
    Text = "Se rimane nella tua mano durante la fase di scarto, non andrà nella Pila degli scarti e non potrà essere usata di nuovo in questa battaglia."
  },
  State_2985_Desc = {
    Text = "Fino alla fine del turno, ogni volta che infliggi Danno, recupera [Layer] PV alla fine del turno."
  },
  State_2985_Name = {
    Text = "Diamante grezzo"
  },
  State_2985_WeaponDesc = {
    Text = "Fino alla fine del turno, ripristina [Layer] PV ogni volta che vengono inflitti Danni."
  },
  State_2987_Desc = {
    Text = "Evento 19_1"
  },
  State_2987_Name = {
    Text = "Evento 19_1"
  },
  State_2987_WeaponDesc = {
    Text = "Evento 19_1"
  },
  State_2988_Desc = {
    Text = "Quando si divorano gli embrioni, essi ritornano dalla Pila degli scarti al mazzo in mano, e l'Arithmetica diventa zero."
  },
  State_2988_Name = {
    Text = "Prole Malefica"
  },
  State_2988_WeaponDesc = {
    Text = "Quando si divorano gli embrioni, essi ritornano dalla Pila degli scarti al mazzo in mano, e l'Arithmetica diventa zero."
  },
  State_2989_Desc = {
    Text = "Dopo aver giocato una carta Risvegliatore, mischia una copia Temporanea di quella carta con il costo ridotto di 1 nel mazzo."
  },
  State_2990_Desc = {
    Text = "Quando giocata, infliggi [StateArg1] <ExhaustionIconKeywords:FOR▼> Temp. a tutti i nemici."
  },
  State_2990_Name = {
    Text = "<Rune_18_High:Esaurimento Avanzato>"
  },
  State_2992_Desc = {
    Text = "Dopo aver pescato \"Vuoto\", riduci del 50% tutto l'Aliemus ottenuto dai Risvegliati in questo turno."
  },
  State_2992_Name = {Text = "Vuoto"},
  State_2992_WeaponDesc = {
    Text = "Dopo aver pescato \"Vuoto\", riduci del 50% tutto l'Aliemus ottenuto dai Risvegliati in questo turno."
  },
  State_2993_Name = {
    Text = "Conteggio Reliquia Muta di Pelle di Serpente"
  },
  State_2994_Desc = {
    Text = "Danno dei Tentacoli +[StateArg1] quando i Tentacoli sono in Traboccamento."
  },
  State_2994_Name = {
    Text = "Potere della Benedizione"
  },
  State_2994_WeaponDesc = {
    Text = "Danno dei Tentacoli +[StateArg1] quando i Tentacoli sono in Traboccamento."
  },
  State_2996_Desc = {
    Text = "Quando giocata, attiva [StateArg1] Attacchi del tentacolo."
  },
  State_2996_Name = {
    Text = "<Rune_11:Dominio>"
  },
  State_2997_Desc = {
    Text = "Dopo aver inflitto il 3° Danno ogni turno, ottieni [Arg1] Scudo. Dopo aver inflitto il 6° Danno ogni turno, ottieni [Arg2] Forza."
  },
  State_2997_Name = {
    Text = "Passaggio sicuro"
  },
  State_3001_Desc = {
    Text = "Aumenta di 2 la quantità di Aliemus ottenuta quando si subisce un attacco."
  },
  State_3002_Desc = {
    Text = "Danno, Scudo del Personaggio e Guarigione del Portatore +[StateArg1]%. (Temporaneo)"
  },
  State_3002_Name = {
    Text = "Stato@Prototipo Cannone Laser Fortuna"
  },
  State_3003_Desc = {
    Text = "Dopo essere stata giocata, questa carta viene rimossa dal mazzo anziché entrare nella Pila degli scarti."
  },
  State_3003_Name = {
    Text = "<DepleteIconKeywords:Consumo>"
  },
  State_3003_WeaponDesc = {
    Text = "Dopo essere stata giocata, la carta non finirà nella Pila degli scarti e non potrà essere usata di nuovo in questa Battaglia."
  },
  State_3004_Desc = {
    Text = "[Layer] Immune all'inflizione dello Stato Veleno durante il turno."
  },
  State_3004_Name = {
    Text = "Immunità al Veleno"
  },
  State_3008_Desc = {
    Text = "All'inizio del turno, aggiungi 1 accumulo di Stagnazione alle carte rimanenti nella tua mano. Le carte con un Costo di Arithmetica superiore a 5 si trasformeranno in pietra."
  },
  State_3008_Name = {
    Text = "Aigis Risveglio!"
  },
  State_3008_WeaponDesc = {
    Text = "A inizio del turno successivo, ottieni Scudo del Personaggio pari alla quantità di HP persi nel turno precedente."
  },
  State_3011_Desc = {
    Text = "Unico per Squadra: Il Tasso Crit. e il Danno Crit. dell'\"Esaltazione\" del Portatore sono aumentati del <WeaponEffect_Num:[StateArg2]%>. Dopo che il Portatore rilascia l'\"Esaltazione\", ottiene <PowerIconKeywords:FOR> pari alla propria COS <WeaponEffect_Num:[StateArg1]%>. Se questa Esaltazione attiva l'effetto <CardKeyWord:Divorare>, ottiene 1 istanza aggiuntiva di <PowerIconKeywords:FOR>."
  },
  State_3011_WeaponDesc = {
    Text = "Il Tasso Crit. e il Danno Crit. dell'\"Esaltazione\" del Portatore sono aumentati del <WeaponEffect_Num:[StateArg2]%>. Dopo che il Portatore rilascia l'\"Esaltazione\", ottiene <WeaponEffect_Num:[Power:DescArg1]> Forza. Se questa Esaltazione attiva l'effetto <CardKeyWord:Divorare>, ottiene inoltre 1 <PowerIconKeywords:FOR>."
  },
  State_3012_Desc = {
    Text = "Stato vuoto inutile"
  },
  State_3012_Name = {
    Text = "Stato vuoto inutile"
  },
  State_3012_WeaponDesc = {
    Text = "Stato vuoto inutile"
  },
  State_3013_Desc = {
    Text = "Quando la Paziente Sanguivora potenzia Fusione Embrionale, ottieni [StateArg1] Forza."
  },
  State_3013_Name = {Text = "Sanguivoro"},
  State_3014_Desc = {
    Text = "Se l'avversario ha 4 o più carte In Mano, ottieni [StateArg1] Scudo del Personaggio quando subisci Danno."
  },
  State_3014_Name = {
    Text = "Forma Serpentina"
  },
  State_3015_Desc = {
    Text = "Stato@Armatura di Cera - Nostra Squadra"
  },
  State_3015_Name = {
    Text = "Stato@Armatura di Cera - Nostra Squadra"
  },
  State_3015_WeaponDesc = {
    Text = "Stato@Armatura di Cera - Nostra Squadra"
  },
  State_3016_Desc = {
    Text = "I PV dei mostri evocati sono raddoppiati."
  },
  State_3016_Name = {
    Text = "\"Colpa Dilagante\""
  },
  State_3016_WeaponDesc = {
    Text = "I PV dei mostri evocati sono raddoppiati."
  },
  State_3017_Name = {
    Text = "Stato@Allucinazioni Maledette"
  },
  State_3018_Desc = {
    Text = "\"Segugio Dimensionale\" rimuove 1 accumulo per ogni HP perso; quando gli accumuli raggiungono 0, ottieni uno Scudo di [StateArg1] e riacquisti [StateArg2] Barriera Dimensionale."
  },
  State_3018_Name = {
    Text = "Barriera Dimensionale"
  },
  State_3019_Desc = {
    Text = "Consumare 10 Sigilli Neri ripristina l'1% degli HP"
  },
  State_3019_Name = {
    Text = "Stato Radice Inversa della Reliquia"
  },
  State_3019_WeaponDesc = {
    Text = "Consumare 10 Sigilli Neri ripristina l'1% degli HP"
  },
  State_3020_Desc = {
    Text = "Se hai subito DAN l'ultimo turno, ottieni immunità per 1 turno all'inizio di questo turno."
  },
  State_3020_Name = {
    Text = "Adattamento"
  },
  State_3020_WeaponDesc = {
    Text = "Se hai subito DAN l'ultimo turno, ottieni immunità per 1 turno all'inizio di questo turno."
  },
  State_3021_Desc = {
    Text = "A inizio turno, ottieni 1 Arithmetica."
  },
  State_3021_Name = {
    Text = "Stato@Arithmetica massima -2"
  },
  State_3023_Desc = {
    Text = "Ogni volta che si subisce un Danno attivo in questo turno, infliggi [Layer] <FixedDamage:DAN Puro> alla fonte del danno."
  },
  State_3023_Name = {Text = "Contatore"},
  State_3023_WeaponDesc = {
    Text = "Ogni volta che si subisce un Danno attivo, infliggi [Layer] <FixedDamage:DAN Puro> all'Attaccante."
  },
  State_3024_Desc = {
    Text = "Danno, Scudo del Personaggio e Guarigione del Portatore +[StateArg1]%. (Temporaneo)"
  },
  State_3024_Name = {
    Text = "Stato@Prototipo Pugnale Resistenza"
  },
  State_3025_Desc = {
    Text = "Ogni carta giocata aumenta la Probabilità di Crit. del 10% in questo turno."
  },
  State_3026_Desc = {
    Text = "All'inizio della battaglia, [StateArg1] copie di questa carta sono state mischiate nel Mazzo di Pesca. (Questa Orazione ha applicato <RetainIconKeywords:Conservare> alle carte.)"
  },
  State_3026_Name = {
    Text = "<Rune_8_High:Specchio Avanzato>"
  },
  State_3026_WeaponDesc = {
    Text = "All'inizio della battaglia, [StateArg1] copie di questa carta sono state mischiate nel Mazzo di Pesca. (Questa Orazione ha applicato <RetainIconKeywords:Conservare> alle carte.)"
  },
  State_3027_Desc = {
    Text = "Dopo la Battaglia, ottieni 50 Sigilli Neri aggiuntivi, ma sviluppi un Sintomo casuale."
  },
  State_3028_Name = {
    Text = "Stato@Inizio Turno Arithmetica +2"
  },
  State_3029_Desc = {
    Text = "Perde 1 accumulo per ogni 1 danno subito. Passa alla modalità Difesa quando gli accumuli raggiungono 0."
  },
  State_3029_Name = {
    Text = "Conteggio Carte"
  },
  State_3029_WeaponDesc = {
    Text = "Perde 1 accumulo per ogni 1 danno subito. Passa alla modalità Difesa quando gli accumuli raggiungono 0."
  },
  State_3033_Desc = {
    Text = "Giocando 10 carte, si ottiene una Barriera che blocca qualsiasi Danno. Se si possiede già una Barriera, si ripristinano [Arg1] PV invece."
  },
  State_3034_Desc = {
    Text = "Unico per Squadra: Ogni volta che una carta del Portatore viene giocata, ottieni <WeaponEffect_Num:[StateArg1]> Keyflare. Questo effetto può attivarsi fino a 3 volte per turno."
  },
  State_3034_WeaponDesc = {
    Text = "Per ogni carta giocata dal portatore, ottieni <WeaponEffect_Num:[StateArg1]> Keyflare. Questo effetto può attivarsi fino a 3 volte per turno."
  },
  State_3035_Desc = {
    Text = "Quando giocata, attiva [StateArg1] Attacchi del tentacolo."
  },
  State_3035_Name = {
    Text = "<Rune_11_High:Dominio Avanzato>"
  },
  State_3035_WeaponDesc = {
    Text = "Quando giocata, attiva [StateArg1] Attacchi del tentacolo."
  },
  State_30364_Desc = {
    Text = "Quando questa carta è In Mano, il limite di carte in mano aumenta di 1."
  },
  State_30364_Name = {
    Text = "Ignora Limite Carte in Mano"
  },
  State_30369_Desc = {
    Text = "Il limite di carte in mano in questo turno è aumentato di +[Layer]."
  },
  State_30369_Name = {
    Text = "Limite Massima della Mano"
  },
  State_3036_Desc = {
    Text = "Aumenta l'Effetto di Fragile e Debolezza dal 33% al 50%."
  },
  State_3036_Name = {
    Text = "\"Echi dell'Annientamento\""
  },
  State_3036_WeaponDesc = {
    Text = "Aumenta l'Effetto di Fragile e Debolezza dal 33% al 50%."
  },
  State_3038_Desc = {
    Text = "Unico per Squadra: Dopo aver attivato Posse, il Portatore ottiene <WeaponEffect_Num:[StateArg1]> Aliemus."
  },
  State_3038_WeaponDesc = {
    Text = "Dopo aver rilasciato il Seguito, il portatore ottiene <WeaponEffect_Num:[StateArg1]> Aliemus."
  },
  State_3040_Desc = {
    Text = "All'inizio del turno, applica [Layer] accumuli di Vincolo alla tua squadra."
  },
  State_3040_Name = {Text = "Vincolo"},
  State_3040_WeaponDesc = {
    Text = "All'inizio del turno, applica [Layer] accumuli di Vincolo alla tua squadra."
  },
  State_3041_Desc = {
    Text = "Rimane permanentemente nel mazzo."
  },
  State_3041_Name = {
    Text = "<CardKeyWord:Carta sintomo>"
  },
  State_3042_Desc = {
    Text = "Ottieni [Arg1] Forza in questo turno quando infliggi Danno, fino a un massimo di 3 accumuli. Raddoppia l'Effetto quando gli accumuli sono al massimo."
  },
  State_3043_Desc = {
    Text = "Turni pari: DAN ricevuti -50%, DAN inflitti +33%."
  },
  State_3043_Name = {Text = "Volubile"},
  State_3043_WeaponDesc = {
    Text = "Turni pari: DAN ricevuti -50%, DAN inflitti +33%."
  },
  State_3045_Desc = {
    Text = "Dopo l'Esaltazione, il Risvegliatore corrispondente ottiene 20 Aliemus."
  },
  State_3045_Name = {
    Text = "Velo della Divinità Senza Nome"
  },
  State_3046_Desc = {
    Text = "Unico per Squadra: Si ottengono [StateArg1] Sigilli Neri ogni volta che un nemico muore. Dopo che il Portatore uccide un nemico, il Danno Crit. del Portatore in questo livello aumenta Permanentemente del <WeaponEffect_Num:[StateArg2]%>, accumulabile fino a 5 accumuli. Ogni volta che il Portatore attiva l'Effetto Balzo, il Danno Finale inflitto dal Portatore in questo turno aumenta del <WeaponEffect_Num:[StateArg3]%>, accumulabile fino a 3 accumuli."
  },
  State_3046_WeaponDesc = {
    Text = "Ottiene [StateArg1] Sigillo Nero ogni volta che un nemico muore. Quando il portatore uccide un nemico, il Danno Crit. del portatore in questo scontro aumenta permanentemente del <WeaponEffect_Num:[StateArg2]%>, accumulabile fino a 5 cariche. Ogni volta che il portatore attiva un effetto Balzo, il Danno Finale inflitto dal portatore in questo turno aumenta del <WeaponEffect_Num:[StateArg3]%>, accumulabile fino a 3 cariche."
  },
  State_3047_Desc = {
    Text = "Ottieni [Arg1] Scudo all'inizio del turno, aumentando di [Arg2] ogni turno."
  },
  State_3047_Name = {
    Text = "Mano del Guardiano"
  },
  State_3048_Desc = {
    Text = "L'Intento di Battaglia di Lotan non cessa mai. Alla fine di ogni turno, Lotan rimuove 3 accumuli di Debolezza e stato Vulnerabile."
  },
  State_3048_Name = {
    Text = "Risveglio di Lotan"
  },
  State_3049_Desc = {
    Text = "Aumenta di 1 il numero di istanze di danno del prossimo attacco di George."
  },
  State_3049_Name = {
    Text = "Risentimento"
  },
  State_3049_WeaponDesc = {
    Text = "Aumenta di 1 il numero di istanze di danno del prossimo attacco di George."
  },
  State_3050_Desc = {
    Text = "All'inizio della battaglia, mischia un [Convulsion] nel tuo Mazzo di Pesca."
  },
  State_3050_Name = {Text = "Paura"},
  State_3050_WeaponDesc = {
    Text = "All'inizio della battaglia, mischia un [Convulsion] nel tuo Mazzo di Pesca."
  },
  State_3051_Desc = {
    Text = "Mischia un Grido nel Mazzo di Pesca quando infliggi Danno non bloccabile."
  },
  State_3051_Name = {
    Text = "Desiderio Ardente come Cera"
  },
  State_3051_WeaponDesc = {
    Text = "Mischia una carta \"Gridare\" nel Mazzo di Pesca dopo aver inflitto Danni effettivi."
  },
  State_3054_Name = {
    Text = "Stato@Sintomo: Shock Maledetto"
  },
  State_3055_Desc = {
    Text = "Quando inizia la battaglia, applica 1 accumulo di Fragile alla tua squadra."
  },
  State_3055_Name = {Text = "Penetrare"},
  State_3055_WeaponDesc = {
    Text = "Quando inizia la battaglia, applica 1 accumulo di Fragile alla tua squadra."
  },
  State_3056_Desc = {
    Text = "A fine turno, rimuovi 1 accumulo di Debolezza e Vulnerabile."
  },
  State_3056_Name = {Text = "Minaccioso"},
  State_3058_Desc = {
    Text = "Per ogni Tentacolo, ottieni [Arg1] Scudo del Personaggio a fine turno."
  },
  State_3058_Name = {
    Text = "Appendice senza nome"
  },
  State_3060_Desc = {
    Text = "Ottieni [Layer] Scudo del Personaggio all'inizio del prossimo turno."
  },
  State_3060_Name = {
    Text = "Psiche Riforgiata"
  },
  State_3060_WeaponDesc = {
    Text = "Pesca [Layer] carte all'inizio del prossimo turno."
  },
  State_3063_Desc = {
    Text = "Infliggi [Layer] Veleno quando si infligge Danno effettivo."
  },
  State_3063_Name = {Text = "Tossina"},
  State_3064_Desc = {
    Text = "Subisci un numero equivalente di accumuli di Danno prima di giocare la carta. Rimossi a fine turno."
  },
  State_3064_Name = {Text = "Vincolo"},
  State_3064_WeaponDesc = {
    Text = "Subisci un numero equivalente di accumuli di Danno prima di giocare la carta. Rimossi a fine turno."
  },
  State_3065_Name = {
    Text = "Stato@Reliquia Offerta Passata 2"
  },
  State_3068_Desc = {
    Text = "Alla fine del turno, subisci [Layer] <FixedDamage:DAN Puro>."
  },
  State_3068_Name = {
    Text = "<IntoxicationColour:Veleno>"
  },
  State_3068_WeaponDesc = {
    Text = "Alla fine del turno, subisci [Layer] <FixedDamage:DAN Puro>."
  },
  State_3069_Name = {
    Text = "Accessorio: Deus Ex Machina"
  },
  State_3069_WeaponDesc = {
    Text = "Ottieni 1 Arithmetica aggiuntiva all'inizio del primo Turno di ogni Battaglia."
  },
  State_3070_Desc = {
    Text = "Unico per Squadra: il \"Colpo\" del Portatore fa perdere al nemico bersaglio <PowerIconKeywords:FOR> Temporanea pari al <WeaponEffect_Num:[StateArg1]%> dell'ATT del Portatore. Questo effetto può attivarsi un massimo di 3 volte per turno."
  },
  State_3070_WeaponDesc = {
    Text = "Il \"Colpo\" del portatore riduce temporaneamente <WeaponEffect_Num:[Power:DescArg1]> <PowerIconKeywords:FOR> del nemico bersaglio. Questo effetto può attivarsi un massimo di 3 volte per turno."
  },
  State_3071_Desc = {
    Text = "Unico per Squadra: dopo aver giocato la \"Difesa\" del Portatore, ottieni <PowerIconKeywords:FOR> Temporanea pari al <WeaponEffect_Num:[StateArg1]%> dell'ATT del Portatore."
  },
  State_3071_WeaponDesc = {
    Text = "Dopo aver giocato la \"Difesa\" del Portatore, ottieni <WeaponEffect_Num:[Power:DescArg1]> <PowerIconKeywords:FOR> Temporanea."
  },
  State_3072_Desc = {
    Text = "Unico per Squadra: Dopo aver ucciso un nemico, il Portatore ottiene <WeaponEffect_Num:[StateArg1]> Aliemus e 1% Danno Crit., effettivo per l'intera esplorazione."
  },
  State_3072_WeaponDesc = {
    Text = "Dopo aver ucciso un nemico, il Portatore ottiene <WeaponEffect_Num:[StateArg1]> Aliemus e 1% Danno Crit., effettivo per l'intera esplorazione."
  },
  State_3073_Desc = {
    Text = "Unico per Squadra: Dopo che il Portatore usa Exalt, la Prob. Crit. di tutti gli alleati + <WeaponEffect_Num:[StateArg1]%> per questo turno."
  },
  State_3073_WeaponDesc = {
    Text = "Dopo che il portatore rilascia l'Esaltazione, il Tasso di Crit. di tutti gli alleati + <WeaponEffect_Num:[StateArg1]%> in questo turno."
  },
  State_3074_Desc = {
    Text = "Unico per Squadra: Dopo aver giocato una Carta sintomo, il Portatore ottiene <WeaponEffect_Num:[StateArg1]> Aliemus. Questo effetto si attiva fino a 2 volte per turno. Dopo aver giocato una Carta di comando, il Portatore ottiene 1 Aliemus."
  },
  State_3074_WeaponDesc = {
    Text = "Gioca una Carta sintomo. Il portatore ottiene <WeaponEffect_Num:[StateArg1]> Aliemus. Questo effetto può attivarsi fino a 2 volte per turno. Quando il portatore gioca 1 Carta di comando, ottiene 1 Aliemus."
  },
  State_3075_Desc = {
    Text = "Unico per Squadra: Dopo Exalt, ottieni Scudo pari al <WeaponEffect_Num:[StateArg1]%> della DIF del Portatore."
  },
  State_3075_Name = {
    Text = "Barriera Mentale"
  },
  State_3075_WeaponDesc = {
    Text = "Dopo che il portatore rilascia Esaltazione, ottiene <WeaponEffect_Num:[Block:DescArg1]> Scudi."
  },
  State_3076_Desc = {
    Text = "Unicità di Squadra: Dopo aver inflitto un Danno attivo, il Tasso critico del portatore + <WeaponEffect_Num:[StateArg1]%>. Dopo un colpo critico, il Tasso critico ottenuto da questo effetto viene azzerato."
  },
  State_3076_WeaponDesc = {
    Text = "Dopo aver inflitto un Danno attivo, il Tasso critico del portatore + <WeaponEffect_Num:[StateArg1]%>. Dopo un colpo critico, il Tasso critico ottenuto da questo effetto viene azzerato."
  },
  State_3078_Desc = {
    Text = "In questo turno, tutto il Danno inflitto è garantito come Colpo Critico."
  },
  State_3078_Name = {
    Text = "Critico garantito temporaneo"
  },
  State_3078_WeaponDesc = {
    Text = "Tasso di critico + 100% in questo turno."
  },
  State_3082_Desc = {
    Text = "Dopo l'Esaltazione, aggiungi alla mano una carta casuale corrispondente al Risvegliatore. La carta ottiene Esaurimento e Fugace."
  },
  State_3082_Name = {
    Text = "Valigetta del dottore"
  },
  State_3084_Desc = {
    Text = "Quando giocata, aggiungi [StateArg1] copie negli slot Temporanei di <DimensionalSpaceIconKeywords:Spazio Ultra>."
  },
  State_3084_Name = {
    Text = "<Rune_13_High:Av. Distorsione>"
  },
  State_3084_WeaponDesc = {
    Text = "Quando giocata, aggiungi [StateArg1] copie negli slot Temporanei di <DimensionalSpaceIconKeywords:Spazio Ultra>."
  },
  State_3087_Desc = {
    Text = "Danno delle carte Colpo aumentato del [Layer]%."
  },
  State_3087_Name = {
    Text = "DAN delle carte Attacco temporaneamente aumentato"
  },
  State_3087_WeaponDesc = {
    Text = "Danno delle carte Colpo aumentato del [Layer]%."
  },
  State_3088_Desc = {
    Text = "Il Danno attivo ricevuto aumenta di [Layer]. Le Ferite da Dissoluzione si espandono a ogni colpo e si recuperano all'inizio del turno."
  },
  State_3088_Name = {
    Text = "Dissoluzione Profonda"
  },
  State_3088_WeaponDesc = {
    Text = "Il Danno attivo subito è aumentato di [Layer]. Ogni volta che si subiscono DAN, la Ferita da Dissoluzione si espande e si riassorbe all'inizio del Turno."
  },
  State_3092_Name = {
    Text = "Nelle Battaglie Boss, tutti i Risvegliati ottengono 30 Aliemus e vengono liberati dallo Stato Sigillato."
  },
  State_3093_Name = {
    Text = "Stato@Conteggio Mimetismo del Mago"
  },
  State_3094_Desc = {
    Text = "Quando pescata, rendi te stesso Fragile per 1 turno. Quando usata, rendi tutti i nemici Vulnerabile per 1 turno. Non può essere venduta."
  },
  State_3094_Name = {
    Text = "Stato Maledizione Collasso"
  },
  State_3094_WeaponDesc = {
    Text = "Quando pescata, rendi te stesso Fragile per 1 turno. Quando usata, rendi tutti i nemici Vulnerabile per 1 turno. Non può essere venduta."
  },
  State_3095_Desc = {
    Text = "I DAN inflitti in questo livello sono aumentati di [Layer]."
  },
  State_3095_Name = {
    Text = "Forza Permanente"
  },
  State_3095_WeaponDesc = {
    Text = "I DAN inflitti in questo livello sono aumentati di [Layer]."
  },
  State_3096_Desc = {
    Text = "C'è ancora molta strada da fare per convincere Lotan."
  },
  State_3096_Name = {
    Text = "Risveglio di Lotan"
  },
  State_3098_Desc = {
    Text = "Al momento della raccolta, scegli una carta per ridurre permanentemente il suo Costo di Arithmetica a 1."
  },
  State_3099_Desc = {
    Text = "Dopo aver rilasciato un'Esaltazione, ottieni [Arg1] Forza in questo turno."
  },
  State_3100_Desc = {
    Text = "A inizio turno, la Resistenza alla Morte aumenta del 10%. Quando la Resistenza alla Morte supera il 100%, ottieni 30 di Padronanza del Reame aggiuntivi."
  },
  State_3104_Desc = {
    Text = "Questo turno, per ogni volta che subisce Danno attivo, il danno di \"Dolce Demone\" si moltiplica +1."
  },
  State_3104_Name = {
    Text = "Sofferenza Condivisa"
  },
  State_3104_WeaponDesc = {
    Text = "Questo turno, per ogni volta che subisce Danno attivo, il danno di \"Dolce Demone\" si moltiplica +1."
  },
  State_3106_Desc = {
    Text = "Quando i PV scendono sotto il 50% ([StateArg1]), si divide in 2 \"Creazioni Sperimentali\" con PV equamente distribuiti."
  },
  State_3106_Name = {Text = "Scissione"},
  State_3106_WeaponDesc = {
    Text = "Quando i PV scendono sotto il 50% ([StateArg1]), si dividerà in 3 \"Gruppo di Sculture di Cera di Entità Dissolta di Tipo II\" con PV equamente distribuiti."
  },
  State_3108_Name = {
    Text = "Accessorio: Anello del Verso"
  },
  State_3108_WeaponDesc = {
    Text = "All'inizio dei turni pari, ottieni 1 Arithmetica."
  },
  State_3109_Name = {
    Text = "Stato@Capitolo 4 Risonanza@Arithmetica -1"
  },
  State_3109_WeaponDesc = {
    Text = "\"Dono dell'Innocente\" Costo di Arithmetica -1"
  },
  State_3110_Name = {
    Text = "Stato@Capitolo 4 Risonanza@Arithmetica -1"
  },
  State_3110_WeaponDesc = {
    Text = "\"Dono dell'Innocente\" Costo di Arithmetica -1"
  },
  State_3111_Desc = {
    Text = "All'inizio del turno successivo, converti lo Scudo del Personaggio rimanente in PV x2."
  },
  State_3111_Name = {
    Text = "Fiore eterno"
  },
  State_3112_Desc = {
    Text = "Unico per Squadra: Aumenta i DAN da Veleno del Portatore di <WeaponEffect_Num:[StateArg3]%>. Dopo aver usato Esaltazione, ripristina salute pari al <WeaponEffect_Num:[StateArg1]%> della COS del Portatore, più salute aggiuntiva pari al <WeaponEffect_Num:[StateArg2]%> della COS del Portatore per ogni Arithmetica rimanente."
  },
  State_3112_Name = {
    Text = "Banchetto Silenzioso"
  },
  State_3112_WeaponDesc = {
    Text = "Aumenta il Veleno inflitto del <WeaponEffect_Num:[StateArg3]%>. Dopo che il Portatore esegue Esaltazione, recupera <WeaponEffect_Num:[Heal:DescArg1]> punti PV, e per ogni Arithmetica rimanente, ottieni ulteriori <WeaponEffect_Num:[Heal:DescArg2]> punti PV."
  },
  State_3113_Desc = {
    Text = "Stato@Prologo Aliemus 0_1_4"
  },
  State_3113_Name = {
    Text = "Stato@Prologo Aliemus 0_1_4"
  },
  State_3113_WeaponDesc = {
    Text = "Stato@Prologo Aliemus 0_1_4"
  },
  State_3114_Desc = {
    Text = "Stato@Prologo Aliemus 0_1_2"
  },
  State_3114_Name = {
    Text = "Stato@Prologo Aliemus 0_1_2"
  },
  State_3114_WeaponDesc = {
    Text = "Stato@Prologo Aliemus 0_1_2"
  },
  State_3115_Desc = {
    Text = "Stato@Prologo Aliemus 0_1_2"
  },
  State_3115_Name = {
    Text = "Stato@Prologo Aliemus 0_1_2"
  },
  State_3115_WeaponDesc = {
    Text = "Stato@Prologo Aliemus 0_1_2"
  },
  State_3116_Name = {
    Text = "Stato@Prologo Aliemus 0_1_1"
  },
  State_3117_Desc = {
    Text = "Unico per Squadra: Il DAN Base di \"Colpo\" e \"Esaltazione\" del Portatore è aumentato del <WeaponEffect_Num:[StateArg1]%>. Dopo che il Portatore usa \"Colpo\", ottiene un 5% di Tasso critico temporaneo, accumulabile fino a 3 volte per turno. Al raggiungimento di 3 accumuli, ottiene il 15% di Danno critico temporaneo."
  },
  State_3117_WeaponDesc = {
    Text = "Il DAN Base di \"Colpo\" e \"Esaltazione\" del portatore aumenta del <WeaponEffect_Num:[StateArg1]%>. Dopo aver usato \"Colpo\", il portatore ottiene il 5% di Tasso critico temporaneo, fino a 3 volte per turno. Al raggiungimento di 3 accumuli, ottiene il 15% di Danno Crit. temporaneo."
  },
  State_3118_Desc = {
    Text = "A inizio turno, ripristina il [Layer]% degli HP persi."
  },
  State_3118_Name = {
    Text = "Rifugio della Vela del Pilota"
  },
  State_3120_Desc = {
    Text = "[Defense] Ottieni [Arg1] Contatori."
  },
  State_3121_Desc = {
    Text = "Se l'Intenzione del nemico non è attaccare, infliggi Danno Attivo o da Tentacolo per applicare Sanguinamento pari alla metà del Danno inflitto."
  },
  State_3123_Desc = {
    Text = "Unico per Squadra: Il <RetaliateIconKeywords:Contatore> del Portatore è aumentato del <WeaponEffect_Num:[StateArg3]%>. Per ogni attacco ricevuto, ottieni <PowerIconKeywords:FOR> Temporaneo pari al <WeaponEffect_Num:[StateArg1]%> dell'ATT del Portatore. Dopo che il Portatore usa Esaltazione, ottieni <RetaliateIconKeywords:Contatore> pari al <WeaponEffect_Num:[StateArg2]%> dell'ATT del Portatore."
  },
  State_3123_WeaponDesc = {
    Text = "I danni da Contatore del portatore sono aumentati del <WeaponEffect_Num:[StateArg3]%>. Per ogni attacco subito, ottieni <WeaponEffect_Num:[Power:DescArg1]> <PowerIconKeywords:FOR> Temporanea. Dopo che il portatore usa Esaltazione, ottieni <WeaponEffect_Num:[Counterattack:DescArg2]> Contatore."
  },
  State_3124_Desc = {
    Text = "Il numero di Sigilli Neri ottenuti dal Detective Fortunato è raddoppiato."
  },
  State_3124_Name = {
    Text = "Fortuna Eccezionale"
  },
  State_3124_WeaponDesc = {
    Text = "Il numero di Sigilli Neri ottenuti dal Detective Fortunato è raddoppiato."
  },
  State_3127_Name = {
    Text = "Stato@Level2_10Battle3Bubble1"
  },
  State_3128_Desc = {
    Text = "Tutto lo Scudo del Personaggio e il recupero salute dei Risvegliatori aumentati del [StateArg1]%"
  },
  State_3128_Name = {Text = "Culla"},
  State_3129_Desc = {
    Text = "Prima dell'inizio del prossimo turno, ogni istanza di Danno attivo subito attiva [Layer] contrattacchi aggiuntivi e contrattacchi del Tentacolo, infliggendo il 50% di DAN."
  },
  State_3129_Name = {
    Text = "Scaglie Protettive"
  },
  State_3130_Desc = {
    Text = "In questo turno, i DAN aumentano di [Layer]."
  },
  State_3130_Name = {
    Text = "FOR temporanea"
  },
  State_3130_WeaponDesc = {
    Text = "In questo turno, i DAN aumentano di [Layer]."
  },
  State_3135_Desc = {
    Text = "Ogni accumulo aumenta le istanze di danno inflitto di 1."
  },
  State_3135_Name = {
    Text = "<MadnessIconKeywords:Follia>"
  },
  State_3136_Name = {Text = "Aliemus"},
  State_3137_Desc = {
    Text = "All'inizio della battaglia, ottieni 1 Tentacolo. Il Danno del Tentacolo aumenta permanentemente di [Arg1]."
  },
  State_3138_Name = {
    Text = "Accessorio Paradosso"
  },
  State_3138_WeaponDesc = {
    Text = "Dopo che il portatore usa l'Esaltazione, gli alleati ottengono <RetaliateIconKeywords:Contatore> basato sul 100% della DIF del portatore. Aumenta inoltre il <RetaliateIconKeywords:Contatore> attuale del portatore del 10%."
  },
  State_3139_Desc = {
    Text = "All'inizio del Turno Ultra, rimuovi da te stesso gli stati Debolezza e Fragilità e applica Debolezza e Vulnerabile a tutti i nemici per 2 turni."
  },
  State_3140_Desc = {
    Text = "All'inizio della battaglia, colloca \"Fantasma\" nello Spazio Ultra fino ad avere 4 carte nello Spazio Ultra."
  },
  State_3143_Desc = {
    Text = "Dopo aver inflitto Danno effettivo, la tua squadra perde [Layer] FOR temporanea."
  },
  State_3143_Name = {Text = "Paralisi"},
  State_3144_Name = {
    Text = "Il numero di accumuli di \"Veleno\" e \"Sanguinamento\" nella tua squadra è dimezzato."
  },
  State_3145_Desc = {
    Text = "Impossibile usare carte per [Layer] turni."
  },
  State_3145_Name = {
    Text = "Impossibile Giocare Carte"
  },
  State_3146_Desc = {
    Text = "Quando l'Apostolo del mare gioca 1 carta, genera [StateArg1] Tentacoli temporanei che ignorano il Limite Tentacoli."
  },
  State_3146_Name = {
    Text = "Autorità Delegata"
  },
  State_3146_WeaponDesc = {
    Text = "Quando l'Apostolo del mare gioca 1 carta, genera [StateArg1] Tentacoli temporanei che ignorano il Limite Tentacoli."
  },
  State_3149_Desc = {
    Text = "All'inizio del prossimo turno, tutti i Danni attivi e Danni da tentacolo subiti +50%."
  },
  State_3149_Name = {
    Text = "Vulnerabilità Ritardata"
  },
  State_3149_WeaponDesc = {
    Text = "Tutti i Danni subiti sono aumentati del 50%."
  },
  State_3150_Desc = {
    Text = "Dopo aver ricevuto 3 attacchi in un turno, guadagna 1 stack di Follia Temporanea."
  },
  State_3150_Name = {
    Text = "\"Dolce Agonia\""
  },
  State_3151_Desc = {
    Text = "Ottieni [Arg1] Forza permanentemente al momento della raccolta."
  },
  State_3152_Name = {
    Text = "Stato@Ri-evoluzione Accessorio"
  },
  State_3152_WeaponDesc = {
    Text = "Ottieni 3 Aliemus alla fine del turno del portatore. Ottieni 2 Aliemus aggiuntivi se la Ricarica Aliemus del portatore è superiore a 10."
  },
  State_3153_Name = {
    Text = "Stato@Ripristino Allucinazioni Maledette"
  },
  State_3154_Name = {
    Text = "Tasso di Crit."
  },
  State_3155_Desc = {
    Text = "Recupera il 10% degli HP persi a ogni turno."
  },
  State_3155_Name = {Text = "Medico"},
  State_3155_WeaponDesc = {
    Text = "Recupera il 10% degli HP persi a ogni turno."
  },
  State_3156_Desc = {
    Text = "La prima istanza di danno subito in ogni turno viene moltiplicata per cinque."
  },
  State_3156_Name = {
    Text = "Preda del Panico"
  },
  State_3160_Desc = {
    Text = "All'inizio del turno, aggiungi alla tua mano un \"Parasole\" con [Arg1] Allerta ottenuto in questo turno. Dopo aver giocato 6 Carte, aumenta l'Allerta di tutti i \"Parasole\" nella tua mano di [Arg2]."
  },
  State_3161_Desc = {
    Text = "L'avversario pesca [Layer] carte in meno, ma tutte le carte vengono conservate."
  },
  State_3161_WeaponDesc = {
    Text = "La quantità di carte pescate dalla nostra squadra è ridotta di [Layer], e tutte le carte ottengono Conservare."
  },
  State_3163_Desc = {
    Text = "Attiva Resistenza alla Morte, curando [Layer] PV."
  },
  State_3163_Name = {
    Text = "Culla delle Stelle"
  },
  State_3163_WeaponDesc = {
    Text = "Attiva Resistenza alla Morte, curando [Layer] PV."
  },
  State_3164_Desc = {Text = "—"},
  State_3164_Name = {
    Text = "Conteggio Helot del Risentimento"
  },
  State_3164_WeaponDesc = {Text = "—"},
  State_3165_Name = {
    Text = "La Sgattaiolante Illuminazione 3"
  },
  State_3166_Name = {
    Text = "Questa battaglia è già stata attivata."
  },
  State_3168_Desc = {
    Text = "Aggiunge un conteggio di Attacco a tutti i Mostri all'inizio del turno."
  },
  State_3168_Name = {
    Text = "Stato @ Danni da decapitazione della Grande Lama del Vendicatore"
  },
  State_3168_WeaponDesc = {
    Text = "Aggiunge un conteggio di Attacco a tutti i Mostri all'inizio del turno."
  },
  State_3170_Desc = {
    Text = "Infliggi Il Prezzo dell'Impulsività"
  },
  State_3170_Name = {
    Text = "Infliggi Il Prezzo dell'Impulsività"
  },
  State_3170_WeaponDesc = {
    Text = "Infliggi Il Prezzo dell'Impulsività"
  },
  State_3171_Name = {
    Text = "Stato@Stage2_1Battle3Bubble1"
  },
  State_3172_Desc = {
    Text = "Ottieni [StateArg1] FOR temporanea quando infliggi Danno, accumulabile fino a [StateArg2] volte. Raddoppia l'Effetto quando completamente accumulato."
  },
  State_3172_Name = {
    Text = "Reliquia Ciottolo Insanguinato"
  },
  State_3174_Desc = {
    Text = "PV massimi ridotti del 30%."
  },
  State_3174_Name = {
    Text = "Reliquia Sestante 2"
  },
  State_3174_WeaponDesc = {
    Text = "PV massimi ridotti del 30%."
  },
  State_3175_Desc = {
    Text = "Tutti i Risvegliati ottengono 10 Aliemus a inizio turno."
  },
  State_3175_Name = {
    Text = "Reliquia Sestante 1"
  },
  State_3175_WeaponDesc = {
    Text = "Tutti i Risvegliati ottengono 10 Aliemus a inizio turno."
  },
  State_3176_Desc = {
    Text = "Prologo: Ripristina Mazzo 0_1_1_1"
  },
  State_3176_Name = {
    Text = "Prologo Ripristina Mazzo 0_1_1_1_2"
  },
  State_3176_WeaponDesc = {
    Text = "Prologo: Ripristina Mazzo 0_1_1_1"
  },
  State_3177_Desc = {
    Text = "Quando \"Vigilanza\" raggiunge 3 cariche, ritirati e invoca una \"Scultura di Cera Esca\". Le cariche vengono azzerate a inizio turno."
  },
  State_3177_Name = {Text = "Vigilanza"},
  State_3177_WeaponDesc = {
    Text = "Quando \"Vigilanza\" raggiunge 3 cariche, ritirati e invoca una \"Scultura di Cera Esca\". Le cariche vengono azzerate a inizio turno."
  },
  State_3178_Desc = {
    Text = "Aumenta il Costo di Arithmetica di una carta."
  },
  State_3178_Name = {
    Text = "<SlowIconKeywords:Stagnazione>"
  },
  State_3178_WeaponDesc = {
    Text = "Ogni accumulo di Stagnazione aumenta di 1 il Costo di Arithmetica delle carte."
  },
  State_3179_Desc = {
    Text = "Ottieni 20 Scudo all'inizio della battaglia. All'inizio del turno, se possiedi Scudo, la Generazione di Scudo e l'Amp. di Cura aumentano del 50% per quel turno."
  },
  State_3179_Name = {
    Text = "Guardiano del Giardino Alienato"
  },
  State_3179_WeaponDesc = {
    Text = "Ottieni 20 Scudo all'inizio della battaglia. All'inizio del turno, se possiedi Scudo, la Generazione di Scudo e l'Amp. di Cura aumentano del 50% per quel turno."
  },
  State_3180_Desc = {
    Text = "Tasso di crit. aumentato del 25%. Dopo aver ripristinato i PV, c'è una probabilità di ripristinare i PV un'ulteriore volta, con probabilità pari al tasso di crit. di chi cura."
  },
  State_3180_Name = {
    Text = "Stato@Chiave d'argento Fantasma: Cura Critica"
  },
  State_3181_Name = {
    Text = "Tasso di Crit."
  },
  State_3183_Desc = {
    Text = "Il Danno Crit. è aumentato del [Layer]% in questo turno."
  },
  State_3183_Name = {
    Text = "Danno critico temporaneo"
  },
  State_3185_Desc = {
    Text = "Stress aggiuntivo durante lo spostamento"
  },
  State_3185_Name = {
    Text = "Borsa Senza Fondo delle Reliquie 2"
  },
  State_3185_WeaponDesc = {
    Text = "Stress aggiuntivo durante lo spostamento"
  },
  State_3189_Name = {
    Text = "Forza Ritardata del Mostro"
  },
  State_3190_Name = {
    Text = "Reliquia Chiave"
  },
  State_3193_Desc = {
    Text = "Ottieni [Layer] Scudo del Personaggio dopo l'inizio del prossimo turno."
  },
  State_3193_Name = {
    Text = "L'Arte Perduta"
  },
  State_3193_WeaponDesc = {
    Text = "Ottieni [Layer] Scudo del Personaggio dopo l'inizio del prossimo turno."
  },
  State_3196_Desc = {
    Text = "Quando giocata, recupera [StateArg1] Arithmetica."
  },
  State_3196_Name = {
    Text = "<Rune_4_High:Calcolo Avanzato>"
  },
  State_3196_WeaponDesc = {
    Text = "Quando giocata, recupera [StateArg1] Arithmetica."
  },
  State_3197_Desc = {
    Text = "\"Colpo\" ripristina [Arg1] HP e dimezza i tuoi accumuli di Salasso e Veleno."
  },
  State_3197_Name = {
    Text = "Pinza emostatica"
  },
  State_3200_Desc = {
    Text = "Unico per Squadra: Il DAN Base e lo Scudo del Personaggio del Portatore aumentano del <WeaponEffect_Num:[StateArg1]%>. All'inizio dell'esplorazione, aggiungi un \"Colpo\" del Portatore e una \"Difesa\" al mazzo. Dopo che il Portatore gioca \"Difesa\", il Tasso Crit. e il Danno Crit. del prossimo \"Colpo\" aumentano del 15%. Dopo che il Portatore gioca \"Colpo\", lo Scudo del Personaggio della prossima \"Difesa\" aumenta del 15%. Cumulabile fino a 3 volte."
  },
  State_3200_WeaponDesc = {
    Text = "Il DAN Base e la Generazione di Scudo del Personaggio del Portatore <WeaponEffect_Num:[StateArg1]%>. All'inizio dell'esplorazione, aggiungi un \"Colpo\" e una \"Difesa\" del Portatore al mazzo. Dopo che il Portatore gioca \"Difesa\", il prossimo \"Colpo\" ottiene +15% di Tasso Crit. e Danno Crit. Dopo che il Portatore gioca \"Colpo\", la prossima \"Difesa\" genera +15% di Scudo del Personaggio, cumulabile fino a 3 volte."
  },
  State_3201_Desc = {Text = "—"},
  State_3201_Name = {
    Text = "Catena di risentimento"
  },
  State_3201_WeaponDesc = {Text = "—"},
  State_3203_Desc = {
    Text = "Unicità di Squadra: il Potenziamento Scudo del portatore aumenta del <WeaponEffect_Num:[StateArg3]%>. La \"Difesa\" del portatore infligge <IntoxicationIconKeywords:Veleno> pari al <WeaponEffect_Num:[StateArg1]%> della DIF del portatore al nemico con la Vita più alta. Se il Reame attuale è \"Caro\", quando si applica <IntoxicationIconKeywords:Veleno>, <EmbryoFusionIconKeywords:Fusione Embrionale> + <WeaponEffect_Num:[Blood:StateArg2]>; questo Effetto può attivarsi al massimo 3 volte per turno."
  },
  State_3203_WeaponDesc = {
    Text = "Il Potenziamento Scudo del portatore aumenta del <WeaponEffect_Num:[StateArg3]%>. La \"Difesa\" del portatore infligge <WeaponEffect_Num:[Poison:DescArg1]> livelli di <IntoxicationIconKeywords:Veleno> al nemico con la Vita più alta. Se il Reame attuale è \"Caro\", quando si applica <IntoxicationIconKeywords:Veleno>, <EmbryoFusionIconKeywords:Fusione Embrionale> +<WeaponEffect_Num:[Blood:StateArg2]>; questo Effetto può attivarsi al massimo 3 volte per turno."
  },
  State_3204_Desc = {
    Text = "Quando si infliggono Danni effettivi, mischia [StateArg1] \"Ferita\" nel Mazzo di Pesca."
  },
  State_3204_Name = {
    Text = "Lacerazione"
  },
  State_3204_WeaponDesc = {
    Text = "Quando pescata, applica Debolezza a te stesso per 1 turno. Quando usata, applica Debolezza a tutti i nemici per 1 turno. Non può essere venduta."
  },
  State_3206_Desc = {
    Text = "Ogni carta giocata aumenta il Tasso di Critico del [StateArg1]% in questo turno, fino a un massimo di [StateArg2] accumuli. L'effetto raddoppia quando gli accumuli sono al massimo."
  },
  State_3206_Name = {
    Text = "Reliquia Specchio Rituale di Memphis"
  },
  State_3206_WeaponDesc = {
    Text = "Ogni carta giocata aumenta il Tasso di Critico del [StateArg1]% in questo turno, fino a un massimo di [StateArg2] accumuli. L'effetto raddoppia quando gli accumuli sono al massimo."
  },
  State_3207_Desc = {
    Text = "Per ogni 1 PV perso, rimuovi 1 accumulo. Quando il numero di accumuli raggiunge 0, ottieni [DescArg1] Scudo del Personaggio."
  },
  State_3207_Name = {
    Text = "Barriera Dimensionale"
  },
  State_3208_Desc = {
    Text = "Pietrificato, impossibile agire. Rimosso a fine turno."
  },
  State_3208_Name = {
    Text = "<PetrifactionColour:Pietrificare>"
  },
  State_3209_Name = {
    Text = "Accessorio Prosciugamento Vitale"
  },
  State_3209_WeaponDesc = {
    Text = "A inizio Battaglia, se il Portatore è di classe Caro, aumenta l'ATT del 25%."
  },
  State_3210_Name = {
    Text = "Stato@Lama della Vendetta Illuminare 1"
  },
  State_3211_Desc = {
    Text = "Aumenta il limite di carte In Mano di 2. Non scartare le carte In Mano a fine turno. Ogni volta che perdi PV, scarta 2 carte casuali."
  },
  State_3212_Desc = {
    Text = "Danno attivo e Danni da tentacolo inflitti -25%, rimuovi 1 accumulo al termine del turno."
  },
  State_3212_Name = {
    Text = "<WeaknessIconKeywords:Debolezza>"
  },
  State_3212_WeaponDesc = {
    Text = "Tutti i Danni sono ridotti del 25%."
  },
  State_3213_Desc = {
    Text = "Gli effetti di Scudo e Guarigione sono aumentati del [Layer]%"
  },
  State_3213_Name = {
    Text = "Effetto di Amplificazione Scudo e Guarigione Temporaneo"
  },
  State_3213_WeaponDesc = {
    Text = "Gli effetti di Scudo e Guarigione sono aumentati del [Layer]%"
  },
  State_3215_Name = {
    Text = "Cronopendolo \"Occulto\""
  },
  State_3216_Desc = {
    Text = "Dopo la Battaglia, ottieni 100 Sigilli Neri aggiuntivi, ma sviluppi un Sintomo casuale."
  },
  State_3216_Name = {
    Text = "Reliquia dell'Anello della Buona Sorte"
  },
  State_3216_WeaponDesc = {
    Text = "Dopo la Battaglia, ottieni 100 Sigilli Neri aggiuntivi, ma sviluppi un Sintomo casuale."
  },
  State_3220_Desc = {
    Text = "Dopo aver rilasciato un'Esaltazione, pesca 1 carta. Se i PV sono inferiori al 25%, pesca una carta aggiuntiva."
  },
  State_3223_Desc = {
    Text = "Aumenta l'effetto di Debolezza del 10%. Aggiunge 1 accumulo di Debolezza a tutti i nemici ogni 3 turni."
  },
  State_3224_Name = {
    Text = "Reliquia Archivio Arcana Arithmetica"
  },
  State_3225_Name = {
    Text = "Mietitore di Teschi"
  },
  State_3226_Desc = {
    Text = "Dopo essere stata giocata, la carta non finirà nella Pila degli scarti e non potrà essere usata di nuovo in questa Battaglia."
  },
  State_3226_Name = {
    Text = "Esaurimento"
  },
  State_3226_WeaponDesc = {
    Text = "Dopo essere stata giocata, la carta non finirà nella Pila degli scarti e non potrà essere usata di nuovo in questa Battaglia."
  },
  State_3227_Desc = {
    Text = "Tutti i prezzi delle Reliquie ridotti del 50%."
  },
  State_3227_Name = {
    Text = "Reliquia Medaglia di Scambio"
  },
  State_3227_WeaponDesc = {
    Text = "Tutti i prezzi delle Reliquie ridotti del 50%."
  },
  State_3228_Desc = {
    Text = "All'inizio del turno, il Risvegliato con meno Aliemus guadagna 25 Aliemus."
  },
  State_3228_Name = {
    Text = "Reliquia Arcana Aliemus"
  },
  State_3228_WeaponDesc = {
    Text = "All'inizio del turno, il Risvegliato con meno Aliemus guadagna 25 Aliemus."
  },
  State_3229_Desc = {
    Text = "Prologo: Ripristina Mazzo 0_1_1_1"
  },
  State_3229_Name = {
    Text = "Prologo: Ripristina Mazzo 0_1_1_1"
  },
  State_3229_WeaponDesc = {
    Text = "Prologo: Ripristina Mazzo 0_1_1_1"
  },
  State_3230_Name = {
    Text = "Stato@Ritardo Gen Arithmetica"
  },
  State_3232_Desc = {
    Text = "Stato@Attivazione Slot Ultra Mostro"
  },
  State_3232_Name = {
    Text = "Stato@Attivazione Slot Ultra Mostro"
  },
  State_3232_WeaponDesc = {
    Text = "Stato@Attivazione Slot Ultra Mostro"
  },
  State_3234_Desc = {
    Text = "All'inizio della battaglia, ottieni 3 Forza, ma subisci 5 Danno aggiuntivo."
  },
  State_3234_Name = {
    Text = "Ultimo Grido"
  },
  State_3235_Desc = {
    Text = "All'inizio della battaglia, ottieni [Layer] FOR, ma subisci 5 Danni aggiuntivi."
  },
  State_3235_Name = {
    Text = "Ultimo Grido"
  },
  State_3236_Desc = {
    Text = "Quando giocata, aumenta l'Aliemus di tutti gli altri Risvegliati di <Energy:[StateArg1]>."
  },
  State_3236_Name = {
    Text = "<Rune_16_High:Av. Catalisi>"
  },
  State_3237_Desc = {
    Text = "Ottieni 3 Tentacoli ogni 3 turni. Questi Tentacoli ignorano il Limite Tentacoli e vengono rimossi alla fine del turno."
  },
  State_3238_Desc = {
    Text = "All'inizio della battaglia, conferisce lo stato che aumenta tutti i DAN inflitti ai mostri."
  },
  State_3238_Name = {
    Text = "All'inizio della battaglia, conferisce lo stato che aumenta tutti i DAN inflitti ai mostri."
  },
  State_3238_WeaponDesc = {
    Text = "All'inizio della battaglia, conferisce lo stato che aumenta tutti i DAN inflitti ai mostri."
  },
  State_3239_Desc = {
    Text = "Aumenta l'ATT di [Layer]."
  },
  State_3239_Name = {
    Text = "Aumenta Attacco Generale"
  },
  State_3239_WeaponDesc = {
    Text = "Aumenta l'ATT di [Layer]."
  },
  State_3242_Name = {
    Text = "Aggiungi 2 carte <DerivativeCardKeywords_4:\"Intuizione\"> al Mazzo di pesca."
  },
  State_3243_Desc = {
    Text = "Aumento Arithmetica Carta"
  },
  State_3243_Name = {
    Text = "Aumento Arithmetica Carta"
  },
  State_3243_WeaponDesc = {
    Text = "Aumento Arithmetica Carta"
  },
  State_3244_Desc = {
    Text = "I PV dei mostri evocati sono raddoppiati."
  },
  State_3244_Name = {
    Text = "\"Colpa Dilagante\""
  },
  State_3244_WeaponDesc = {
    Text = "I PV dei mostri evocati sono raddoppiati."
  },
  State_3245_Desc = {
    Text = "All'inizio della battaglia, il Tasso Crit. della tua squadra diminuisce del 30% e il Danno Crit. aumenta del 30%."
  },
  State_3245_Name = {
    Text = "Soppressione"
  },
  State_3245_WeaponDesc = {
    Text = "All'inizio della battaglia, il Tasso Crit. della tua squadra diminuisce del 30% e il Danno Crit. aumenta del 30%."
  },
  State_3246_Desc = {
    Text = "All'inizio della battaglia, gli HP di tutti i nemici ordinari aumentano del 30%. In caso di vittoria in battaglia, si ottengono 25 Sigilli Neri aggiuntivi."
  },
  State_3246_Name = {
    Text = "Reliquia Stendardo di Guerra Logoro"
  },
  State_3246_WeaponDesc = {
    Text = "All'inizio della battaglia, gli HP di tutti i nemici ordinari aumentano del 30%. In caso di vittoria in battaglia, si ottengono 25 Sigilli Neri aggiuntivi."
  },
  State_3247_Desc = {
    Text = "[Exalt] Riduce di 1 il Costo di Arithmetica di tutte le carte in mano."
  },
  State_3247_Name = {
    Text = "Luce della Civiltà Mutata"
  },
  State_3247_WeaponDesc = {
    Text = "[Exalt] Riduce di 1 il Costo di Arithmetica di tutte le carte in mano."
  },
  State_3249_Desc = {
    Text = "Gli altri alleati guadagnano 1 stack di Follia, che viene rimosso alla morte di questa unità."
  },
  State_3249_Name = {
    Text = "Irrequietezza"
  },
  State_3249_WeaponDesc = {
    Text = "Gli altri alleati ottengono 1 accumulo di Follia, che viene rimosso alla morte del lanciaincantesimi."
  },
  State_3250_Desc = {
    Text = "Rimane nel mazzo al termine del combattimento, ma viene rimossa permanentemente dopo essere stata giocata o consumata."
  },
  State_3250_Name = {
    Text = "<DestructionKeywords:Distruzione>"
  },
  State_3250_WeaponDesc = {
    Text = "Rimuovila permanentemente dopo l'uso."
  },
  State_3251_Desc = {
    Text = "Quando si subisce un Danno attivo o Danni da tentacolo, immunità ai danni e si perde 1 stack. Rimosso all'inizio del turno."
  },
  State_3251_Name = {
    Text = "<ParcloseColour:Barriera temporanea>"
  },
  State_3252_Desc = {
    Text = "Fiore di Melma aumenta i PV massimi di [StateArg2] quando si applica uno scudo."
  },
  State_3252_Name = {
    Text = "Convergenza di Melma"
  },
  State_3252_WeaponDesc = {
    Text = "Fiore di Melma aumenta i PV massimi di [StateArg2] quando si applica uno scudo."
  },
  State_3253_Desc = {
    Text = "Ottieni [StateArg1] Allerta temporanea."
  },
  State_3253_Name = {
    Text = "<CardKeyWord:Scudo: Mecha>"
  },
  State_3253_WeaponDesc = {
    Text = "Ottieni [StateArg1] Allerta temporanea"
  },
  State_3255_Name = {Text = "Contatore"},
  State_3256_Name = {
    Text = "State@Mania Maledetta"
  },
  State_3259_Desc = {
    Text = "Aumenta le istanze di Danno attivo inflitto di [Layer]."
  },
  State_3259_Name = {
    Text = "<MadnessColour:Follia>"
  },
  State_3260_Desc = {
    Text = "Quando lo Spazio Ultra è pieno, si ottiene un turno extra. In questo turno, non si pesca alcuna carta dal Mazzo di Pesca; le carte nello Spazio Ultra vengono invece poste In Mano."
  },
  State_3260_Name = {
    Text = "<DimensionalSpaceIconKeywords:Spazio Ultra>"
  },
  State_3260_WeaponDesc = {
    Text = "Quando lo Spazio Ultra raggiunge il limite, ottieni un Turno Ultra aggiuntivo e aggiungi tutte le carte Spazio Ultra alla tua mano."
  },
  State_3261_Desc = {
    Text = "Il DAN dei mostri evocati è raddoppiato."
  },
  State_3261_Name = {
    Text = "\"Esercito di Sculture di Cera\""
  },
  State_3261_WeaponDesc = {
    Text = "Il DAN dei mostri evocati è raddoppiato."
  },
  State_3262_Desc = {
    Text = "Stato@Rivestimento di Cera per la Nostra Squadra"
  },
  State_3262_Name = {
    Text = "Stato@Rivestimento di Cera per la Nostra Squadra"
  },
  State_3262_WeaponDesc = {
    Text = "Stato@Rivestimento di Cera per la Nostra Squadra"
  },
  State_3263_Name = {
    Text = "Stato@Contrattacco Guscio di Nautilus"
  },
  State_3264_Name = {
    Text = "Critico Garantito"
  },
  State_3265_Name = {
    Text = "Rimosso quando scartato"
  },
  State_3266_Desc = {
    Text = "Salto potenziato della Necropoli dei Sogni"
  },
  State_3266_Name = {
    Text = "Stato@Città del Sogno Mortale Potenzia Salto"
  },
  State_3267_Desc = {
    Text = "Quando inizia la battaglia, ottieni 5 accumuli di [Waxed Armor]."
  },
  State_3267_Name = {
    Text = "\"Gentiluomo di Cera\""
  },
  State_3267_WeaponDesc = {
    Text = "Quando inizia la battaglia, ottieni 5 accumuli di [Waxed Armor]."
  },
  State_3268_Desc = {
    Text = "Pesca 1 carta a inizio turno. Ogni carta pescata altera casualmente il proprio Costo di Arithmetica (0-4)."
  },
  State_3268_Name = {
    Text = "Reliquia Caleidoscopio"
  },
  State_3268_WeaponDesc = {
    Text = "Pesca 1 carta a inizio turno. Ogni carta pescata altera casualmente il proprio Costo di Arithmetica (0-4)."
  },
  State_3269_Desc = {
    Text = "Ottieni [Arg1] accumuli di Contatore quando ottieni il secondo Scudo in ogni turno. Infliggi 1 DAN da Contatore a tutti i nemici quando ottieni il 4° Scudo in ogni turno."
  },
  State_3269_Name = {
    Text = "Verità senza vincoli"
  },
  State_3270_Name = {
    Text = "Stato@Capitolo Due Copia Risonanza"
  },
  State_3271_Desc = {
    Text = "[Strike] Applica [Arg1] accumuli di Veleno a tutti i nemici."
  },
  State_3272_Desc = {
    Text = "Quando infliggi DAN non bloccato, curati per 3 volte il DAN effettivo inflitto. Questo effetto viene rimosso quando infliggi Danno."
  },
  State_3272_Name = {
    Text = "Drenaggio Vitale"
  },
  State_3273_Desc = {
    Text = "Unico per Squadra: Dopo aver giocato la carta del Portatore, ottieni uno Scudo del Personaggio pari al <WeaponEffect_Num:[StateArg1]%> della Difesa del Portatore. Per ogni Tentacolo, aumenta lo Scudo del Personaggio del <WeaponEffect_Num:[StateArg2]%> della Difesa del Portatore. Questo effetto si attiva solo una volta per turno."
  },
  State_3273_Name = {
    Text = "Morte della Sig.ra Coral"
  },
  State_3273_WeaponDesc = {
    Text = "Dopo aver giocato una carta del portatore, ottieni <WeaponEffect_Num:[Block:DescArg1]> Scudo. Per ogni Tentacolo, lo Scudo aumenta di <WeaponEffect_Num:[DescArg2]>. Questo effetto si attiva solo una volta per turno."
  },
  State_3274_Desc = {
    Text = "Aggiungi un accumulo alla tua squadra ogni volta che si riceve Danno attivo."
  },
  State_3274_Name = {
    Text = "Stato@Conteggio Danni da decapitazione della Grande Lama Vendicativa alla Nostra Squadra"
  },
  State_3274_WeaponDesc = {
    Text = "Aggiungi un accumulo alla tua squadra ogni volta che si riceve Danno attivo."
  },
  State_3277_Desc = {
    Text = "Quando giocata, aumenta l'Aliemus di questo Risvegliato di <Energy:[StateArg1]>."
  },
  State_3277_Name = {
    Text = "<Rune_5:Berserk>"
  },
  State_3280_Name = {
    Text = "Colpo Predestinato"
  },
  State_3281_Desc = {
    Text = "Aumenta il Danno attivo inflitto."
  },
  State_3281_Name = {
    Text = "<PowerIconKeywords:FOR>"
  },
  State_3281_WeaponDesc = {
    Text = "Aumenta i DAN inflitti."
  },
  State_3282_Desc = {
    Text = "Numero di colpi e Danno aumentati."
  },
  State_3282_Name = {
    Text = "<CardKeyWord:Potenziamento>"
  },
  State_3282_WeaponDesc = {
    Text = "Aumenta il Danno di un'istanza"
  },
  State_3283_Desc = {
    Text = "A inizio turno, ripristina [StateArg1] HP. Se gli HP sono inferiori al 50%, la cura diventa [StateArg2]."
  },
  State_3283_Name = {
    Text = "Reliquia Composto d'Incenso"
  },
  State_3283_WeaponDesc = {
    Text = "A inizio turno, ripristina [StateArg1] HP. Se gli HP sono inferiori al 50%, la cura diventa [StateArg2]."
  },
  State_3287_Desc = {
    Text = "All'inizio della battaglia, mischia 2 carte \"Intuizione\" nel tuo mazzo. Ogni vittoria in battaglia potenzia questa reliquia, fino a un massimo di 3 volte."
  },
  State_3288_Desc = {
    Text = "Stato@Stato Vuoto"
  },
  State_3288_Name = {
    Text = "Stato@Stato Vuoto"
  },
  State_3288_WeaponDesc = {
    Text = "Stato@Stato Vuoto"
  },
  State_3289_Desc = {
    Text = "Ogni punto di Danno subito riduce un accumulo. A 0 accumuli, sostituisci l'intenzione con Fiore eterno e usa abilità incentrate sulla Difesa."
  },
  State_3289_Name = {
    Text = "Fiore eterno"
  },
  State_3289_WeaponDesc = {
    Text = "Perde 1 accumulo per ogni 1 danno subito. Passa alla modalità Difesa quando gli accumuli raggiungono 0."
  },
  State_3290_Desc = {
    Text = "La creatura un tempo nota come \"Miryam\" sprofondò in una paranoia e una disperazione estreme. Frantuma le sue ultime illusioni per porre fine a millenni di Follia."
  },
  State_3290_Name = {Text = "Ossessione"},
  State_3291_Desc = {
    Text = "Dopo aver inflitto Danno effettivo, la tua squadra perde 3 FOR temporanea."
  },
  State_3291_Name = {Text = "Paralisi"},
  State_3292_Desc = {
    Text = "Quando si scatena l'Esaltazione, ogni volta che un nemico sta per infliggere 1 istanza di danno, gli si applicano [Arg1] accumuli di Veleno."
  },
  State_3293_Desc = {
    Text = "Il Danno inflitto in questo livello è ridotto di [Layer]."
  },
  State_3293_Name = {Text = "FOR▼"},
  State_3293_WeaponDesc = {
    Text = "Il Danno e la Riduzione danni da tentacolo in questa fase sono ridotti di [Layer]."
  },
  State_3294_Name = {
    Text = "State@Paranoia Maledetta"
  },
  State_3296_Desc = {
    Text = "Rimuovilo quando viene scartato o giocato."
  },
  State_3296_Name = {
    Text = "Rimuovi questa carta quando viene scartata o giocata."
  },
  State_3296_WeaponDesc = {
    Text = "Quando pescata, applica Debolezza a te stesso per 1 turno. Quando usata, applica Debolezza a tutti i nemici per 1 turno. Non può essere venduta."
  },
  State_3297_Desc = {
    Text = "Stato@Regina delle Spine Qiming_Forma"
  },
  State_3297_Name = {
    Text = "Stato@Regina delle Spine Qiming_Forma"
  },
  State_3297_WeaponDesc = {
    Text = "Stato@Regina delle Spine Qiming_Forma"
  },
  State_3298_Desc = {
    Text = "Il prossimo Effetto Balzo in questo turno è garantito che si attivi."
  },
  State_3298_Name = {
    Text = "Salto Garantito"
  },
  State_3298_WeaponDesc = {
    Text = "L'Effetto Balzo non richiede condizioni in questo turno."
  },
  State_3301_Name = {
    Text = "Conteggio Vino Stellare"
  },
  State_3302_Desc = {
    Text = "Applica Gelo Eterno"
  },
  State_3302_Name = {
    Text = "Applica Gelo Eterno"
  },
  State_3302_WeaponDesc = {
    Text = "Applica Gelo Eterno"
  },
  State_3304_Desc = {
    Text = "Alla fine di ogni turno, quando viene giocato il Risvegliatore corrispondente all'ultima Carta di comando, ottieni 15 Aliemus. Se possiedi anche \"Effigie della Madre\", concedi agli altri Risvegliatori 5 Aliemus."
  },
  State_3305_Desc = {
    Text = "Quando giocata, mischia [StateArg1] <DerivativeCardKeywords_4:\"Intuizione\"> nel Mazzo di Pesca."
  },
  State_3305_Name = {
    Text = "<Rune_17:Intuizione>"
  },
  State_3307_Name = {
    Text = "(Rimanenti:[Layer])"
  },
  State_3308_Desc = {
    Text = "A inizio turno, se nel turno precedente sono rimaste più di 2 carte in mano, ottieni 2 Arithmetica."
  },
  State_3309_Desc = {
    Text = "Danno, Scudo del Personaggio e Guarigione del Portatore +[StateArg1]%. (Temporaneo)"
  },
  State_3309_Name = {
    Text = "Stato@Prototipo Spadone Resistenza"
  },
  State_3310_Desc = {
    Text = "Quando il Migrante applica uno scudo, ottieni [Energy:StateArg2] Aliemus."
  },
  State_3310_Name = {
    Text = "Auto-Reclusione"
  },
  State_3310_WeaponDesc = {
    Text = "Quando il Migrante applica uno scudo, ottieni [Energy:StateArg2] Aliemus."
  },
  State_3312_Desc = {
    Text = "Ogni volta che ripristini PV, ottieni [Arg1] Contatore. Se i tuoi PV sono superiori al 75%, ottieni ulteriori [Arg2] Contatore."
  },
  State_3313_Desc = {
    Text = "All'inizio del turno, ottieni [Arg1] Forza per questo turno. Perdi [Arg2] Forza per questo turno per ogni carta giocata."
  },
  State_3314_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_3314_Name = {
    Text = "Non Risvegliato"
  },
  State_3315_Desc = {
    Text = "Dopo aver giocato la prima carta di ogni turno, trasforma 2 carte casuali in mano nelle loro versioni originali. Tornano allo stato precedente alla fine del turno."
  },
  State_3315_Name = {
    Text = "Reliquia Campanella Ammaliatrice"
  },
  State_3316_Desc = {
    Text = "Lo Scudo del Personaggio verrà conservato a fine turno."
  },
  State_3316_Name = {
    Text = "Barriera Protettrice"
  },
  State_3316_WeaponDesc = {
    Text = "Lo Scudo del Personaggio verrà conservato a fine turno."
  },
  State_3317_Desc = {
    Text = "Perdi tutto lo Scudo del Personaggio a fine turno"
  },
  State_3317_Name = {
    Text = "Catene: Padre Biologico"
  },
  State_3318_Name = {
    Text = "Stato@Marcatore Divorare Abbraccio Assetato di Sangue"
  },
  State_3323_Desc = {
    Text = "Danno, Scudo del Personaggio e Guarigione del Portatore +[StateArg1]%. (Temporaneo)"
  },
  State_3323_Name = {
    Text = "Stato@Proto Spadone Aliemus"
  },
  State_3324_Desc = {
    Text = "Il Danno Crit. è aumentato del [Layer]% in questo turno."
  },
  State_3324_Name = {
    Text = "Danno critico temporaneo"
  },
  State_3324_WeaponDesc = {
    Text = "Il Danno Crit. è aumentato del [Layer]% in questo turno."
  },
  State_3325_Desc = {
    Text = "Ogni volta che rimescoli il mazzo, aggiungi alla tua mano 2 \"Tridente Spinato\" che hanno ottenuto [Arg1] Forza in questo turno e 1 \"Parasole\" che ha ottenuto [Arg2] Allerta in questo turno."
  },
  State_3326_Desc = {
    Text = "Immune al primo Danno attivo di ogni turno."
  },
  State_3326_Name = {Text = "Tenace"},
  State_3326_WeaponDesc = {
    Text = "Immune al primo Danno attivo di ogni turno."
  },
  State_3327_Desc = {
    Text = "HP del mostro prima della morte."
  },
  State_3327_Name = {
    Text = "HP del mostro prima della morte"
  },
  State_3327_WeaponDesc = {
    Text = "HP del mostro prima della morte."
  },
  State_3328_Desc = {
    Text = "In questa battaglia, quando subisci DAN fatali, risorgerai una volta e recupererai [Layer] PV. Questo effetto non può essere dissolto."
  },
  State_3328_Name = {
    Text = "Uccello del paradiso immortale"
  },
  State_3329_Desc = {
    Text = "Gioca 5 carte per ottenere una copia della carta più a sinistra nella tua mano, con Esaurimento e Fugace applicati."
  },
  State_3330_Desc = {
    Text = "Il Costo di Arithmetica della carta aumenta di [Layer]. Questa penalità viene rimossa dopo aver giocato la carta."
  },
  State_3330_Name = {
    Text = "<SlowColour:Stagnazione [Layer]>"
  },
  State_3330_WeaponDesc = {
    Text = "Il Costo di Arithmetica della carta aumenta di [Layer]."
  },
  State_3332_Desc = {
    Text = "Quando si subisce Danno attivo o Danni da tentacolo, diventa immune ai danni e perdi 1 accumulo."
  },
  State_3332_Name = {
    Text = "<ParcloseColour:Barriera>"
  },
  State_3335_Desc = {
    Text = "All'inizio della battaglia, applica 1 accumulo di Vulnerabile a tutti i nemici. \"Maledizione Stagnante\" aumenta l'effetto di Vulnerabile sui nemici del 25%."
  },
  State_3335_Name = {
    Text = "Occhio di Pietra Illuminazione 6"
  },
  State_3336_Name = {
    Text = "Stato@George@Cura alla morte"
  },
  State_3337_Desc = {Text = "—"},
  State_3337_Name = {
    Text = "Rito Vermiglio"
  },
  State_3337_WeaponDesc = {Text = "—"},
  State_3339_Desc = {
    Text = "Aumenta l'ATT di [Layer]."
  },
  State_3339_Name = {
    Text = "Potenziamento Attacco Temporaneo"
  },
  State_3339_WeaponDesc = {
    Text = "Aumenta l'ATT di [Layer]."
  },
  State_3340_Desc = {
    Text = "Dopo aver usato l'Esaltazione, aumenta i DAN dell'Esaltazione di [Arg1] per questa battaglia, accumulabile fino a 5 volte. Quando gli accumuli sono al massimo, il Risvegliato che ha usato questa Esaltazione ottiene 100 Aliemus."
  },
  State_3341_Desc = {
    Text = "Stato@Prologo Ripristina Mazzo 0_1_2_1"
  },
  State_3341_Name = {
    Text = "Stato@Prologo Ripristina Mazzo 0_1_2_1"
  },
  State_3341_WeaponDesc = {
    Text = "Stato@Prologo Ripristina Mazzo 0_1_2_1"
  },
  State_3342_Desc = {
    Text = "Stato@Prologo Ripristina Mazzo 0_1_2_2"
  },
  State_3342_Name = {
    Text = "Stato@Prologo Ripristina Mazzo 0_1_2_2"
  },
  State_3342_WeaponDesc = {
    Text = "Stato@Prologo Ripristina Mazzo 0_1_2_2"
  },
  State_3343_Desc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_2_3"
  },
  State_3343_Name = {
    Text = "Stato@Prologo Reset Mazzo 0_1_2_3"
  },
  State_3343_WeaponDesc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_2_3"
  },
  State_3344_Desc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_2_4"
  },
  State_3344_Name = {
    Text = "Stato@Prologo Reset Mazzo 0_1_2_4"
  },
  State_3344_WeaponDesc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_2_4"
  },
  State_3345_Desc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_2_5"
  },
  State_3345_Name = {
    Text = "Stato@Prologo Reset Mazzo 0_1_2_5"
  },
  State_3345_WeaponDesc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_2_5"
  },
  State_3346_Desc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_2_5"
  },
  State_3346_Name = {
    Text = "Stato@Prologo Reset Mazzo 0_1_2_5"
  },
  State_3346_WeaponDesc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_2_6"
  },
  State_3347_Desc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_2_5"
  },
  State_3347_Name = {
    Text = "Stato@Prologo Reset Mazzo 0_1_2_5"
  },
  State_3347_WeaponDesc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_2_7"
  },
  State_3348_Desc = {
    Text = "Quando giocata, pesca [StateArg1] carte."
  },
  State_3348_Name = {
    Text = "<Rune_3_High:Av. Destrezza>"
  },
  State_3348_WeaponDesc = {
    Text = "Quando giocata, pesca [StateArg1] carte."
  },
  State_3350_Desc = {
    Text = "Dopo aver rilasciato un'Esaltazione, perdi il 10% dei PV attuali e rubi [Arg1] Forza da tutti i nemici in questo turno."
  },
  State_3351_Name = {
    Text = "Stato@Dopo l'aggiunta al mazzo"
  },
  State_3352_Name = {
    Text = "Reliquia Astrolabio Celeste 1"
  },
  State_3354_Name = {
    Text = "Reliquia Astrolabio Celeste 2"
  },
  State_3356_Name = {
    Text = "Fine del Turno: Avvelenamento per Soffocamento"
  },
  State_3357_Desc = {
    Text = "Danno Tentacolo +[Layer] dopo l'inizio del prossimo turno."
  },
  State_3357_Name = {
    Text = "DAN Tentacolo Ritardato"
  },
  State_3358_Desc = {
    Text = "All'inizio del prossimo turno, ottieni [Layer] Scudo del Personaggio."
  },
  State_3358_Name = {
    Text = "L'arte perduta: Scudo"
  },
  State_3359_Desc = {
    Text = "Ogni terza carta giocata avrà Effetto due volte."
  },
  State_3359_Name = {
    Text = "Reliquia Birra Stellare+"
  },
  State_3359_WeaponDesc = {
    Text = "Ogni terza carta giocata avrà Effetto due volte."
  },
  State_3360_Desc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_4_1"
  },
  State_3360_Name = {
    Text = "Stato@Prologo Reset Mazzo 0_1_4_1"
  },
  State_3360_WeaponDesc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_4_1"
  },
  State_3362_Desc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_4_1"
  },
  State_3362_Name = {
    Text = "Stato@Prologo Reset Mazzo 0_1_4_1"
  },
  State_3362_WeaponDesc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_4_1"
  },
  State_3364_Desc = {
    Text = "Al momento della raccolta, scegli una carta e applicale due effetti di potenziamento a tre scelte. (Nota: simile alla creazione di carte di Mille Miraggi)"
  },
  State_3365_Desc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_4_1"
  },
  State_3365_Name = {
    Text = "Stato@Prologo Reset Mazzo 0_1_4_1"
  },
  State_3365_WeaponDesc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_4_1"
  },
  State_3366_Desc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_4_1"
  },
  State_3366_Name = {
    Text = "Stato@Prologo Reset Mazzo 0_1_4_1"
  },
  State_3366_WeaponDesc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_4_1"
  },
  State_3368_Desc = {
    Text = "Se il Costo di Arithmetica supera 5 prima della fase di scarto, si pietrifica."
  },
  State_3368_Name = {
    Text = "Pietrificazione"
  },
  State_3368_WeaponDesc = {
    Text = "Prima della fase di scarto, trasforma le carte in mano in pietre."
  },
  State_3369_Desc = {
    Text = "Tutti i tuoi Effetti divoranti diventano Divorazione Infinita."
  },
  State_3369_Name = {
    Text = "Divorazione Infinita"
  },
  State_3369_WeaponDesc = {
    Text = "Tutti i tuoi Effetti divoranti diventano Divorazione Infinita."
  },
  State_3370_Desc = {
    Text = "La generazione di Scudo del Personaggio è ridotta di [Layer] in questa fase."
  },
  State_3370_Name = {
    Text = "Allerta Permanente-"
  },
  State_3370_WeaponDesc = {
    Text = "La generazione di Scudo del Personaggio è ridotta di [Layer] in questa fase."
  },
  State_3372_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_3372_Name = {
    Text = "Non Risvegliato"
  },
  State_3373_Desc = {
    Text = "Quando si infliggono Danni effettivi, mischia [StateArg1] \"Ferita\" nel Mazzo di Pesca."
  },
  State_3373_Name = {
    Text = "Soffocamento"
  },
  State_3373_WeaponDesc = {
    Text = "Quando pescata, applica Debolezza a te stesso per 1 turno. Quando usata, applica Debolezza a tutti i nemici per 1 turno. Non può essere venduta."
  },
  State_3374_Desc = {
    Text = "Dopo la fine del turno, ottieni un numero uguale di accumuli di Forza."
  },
  State_3374_Name = {Text = "Ira"},
  State_3376_Desc = {
    Text = "I danni da Esaltazione aumentano di [Layer] durante questa battaglia."
  },
  State_3376_Name = {
    Text = "Potenziamento Danni Esaltazione"
  },
  State_3378_Desc = {
    Text = "Dopo aver attivato un'Esaltazione, la prossima Carta giocata ha Effetto due volte."
  },
  State_3378_Name = {
    Text = "Stato@Chiave d'argento Illusoria: Detonazione"
  },
  State_3379_Desc = {
    Text = "Quando i PV scendono sotto il 50%, lo Spezzacatene entra in modalità Berserk."
  },
  State_3379_Name = {
    Text = "Momento della Vendetta"
  },
  State_3379_WeaponDesc = {
    Text = "Quando i PV scendono sotto il 50%, lo Spezzacatene entra in modalità Berserk."
  },
  State_3380_Desc = {
    Text = "All'inizio della battaglia, mischia un [Confusion] nel tuo Mazzo di Pesca."
  },
  State_3380_Name = {
    Text = "Incantamento"
  },
  State_3380_WeaponDesc = {
    Text = "All'inizio della battaglia, mischia un [Confusion] nel tuo Mazzo di Pesca."
  },
  State_3381_Name = {
    Text = "Inizializzazione Classe Ultra Dimensione"
  },
  State_3382_Desc = {
    Text = "Ottieni una missione. Completa la missione per ricevere ricompense. [Event Placeholder]"
  },
  State_3383_Name = {
    Text = "Inizializzazione Classe Ultra Dimensione"
  },
  State_3385_Desc = {
    Text = "Riduce il Danno attivo e da Tentacolo in arrivo del 33%."
  },
  State_3385_Name = {
    Text = "Scudo specchiato"
  },
  State_3385_WeaponDesc = {
    Text = "Riduce il Danno attivo e da Tentacolo in arrivo del 33%."
  },
  State_3386_Desc = {
    Text = "Danno, Scudo del Personaggio e Guarigione del Portatore +[StateArg1]%. (Temporaneo)"
  },
  State_3386_Name = {
    Text = "Stato@Spadone Prototipo Critico"
  },
  State_3387_Name = {
    Text = "Stato@Level2_3Battle3Bubble1"
  },
  State_3388_Desc = {
    Text = "Quando giocata, ottieni [StateArg1] <PowerIconKeywords:FOR> dopo la risoluzione dei suoi effetti."
  },
  State_3388_Name = {
    Text = "<Rune_14:Potenza>"
  },
  State_3389_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_3389_Name = {
    Text = "Non Risvegliato"
  },
  State_3390_Desc = {
    Text = "All'inizio della Battaglia, tutti i nemici subiscono Debolezza e Vulnerabile per 1 turno."
  },
  State_3392_Desc = {
    Text = "Ottieni [Arg1] Forza quando raccolto. Ogni volta che un \"Embrione\" viene fuso, ottieni [Arg2] Forza in questo turno."
  },
  State_3393_Desc = {
    Text = "A inizio turno, Fusione Embrionale +30%. Tutti i tuoi effetti divoranti diventano Divorare illimitato."
  },
  State_3394_Name = {
    Text = "Aggiungi 1 <DerivativeCardKeywords_4:\"Intuizione\"> al Mazzo di pesca"
  },
  State_3395_Desc = {
    Text = "Unico per Squadra: Il Danno Base dell'\"Attacco\" del portatore è aumentato del 25%, e lo scudo base della \"Difesa\" è aumentato del 25%. Quando si gioca l'\"Attacco\" del portatore, ottieni <WeaponEffect_Num:FOR> Temporanea pari all'ATT del portatore <PowerIconKeywords:[StateArg1]%>, e quando si gioca la \"Difesa\" del portatore, ottieni <WeaponEffect_Num:allerta> Temporanea pari alla DIF del portatore <AlertIconKeywords:[StateArg2]%>. Se il reame attuale è \"Ultra\", ricevi <PowerIconKeywords:potenza> Temporanea e <AlertIconKeywords:allerta> Temporanea quando entri nel Turno Ultra"
  },
  State_3395_WeaponDesc = {
    Text = "Il DAN Base di \"Colpo\" del Portatore è aumentato del 25%, e lo Scudo del Personaggio Base di \"Difesa\" è aumentato del 25%. Quando il Portatore esegue un \"Colpo\", ottiene <WeaponEffect_Num:[Power:DescArg1]> <PowerIconKeywords:FOR> Temporanea. Quando il Portatore esegue una \"Difesa\", ottiene <WeaponEffect_Num:[DescArg2]> <AlertIconKeywords:Allerta> Temporanea. Se il Reame Corrente è \"Ultra\", ottiene 1 <PowerIconKeywords:FOR> Temporanea e 1 <AlertIconKeywords:Allerta> Temporanea all'ingresso nel Turno Ultra."
  },
  State_3397_Desc = {
    Text = "Giocare la 10ª carta aumenta il Danno del Tentacolo di [Arg1] e fa attaccare tutti i Tentacoli una volta."
  },
  State_3400_Desc = {
    Text = "I PV massimi dei nemici Élite e Boss sono ridotti del 20%."
  },
  State_3401_Desc = {
    Text = "Quando giocata, ha effetto [StateArg1] volte aggiuntive e ricevi [StateArg2] Sigilli Neri. (Questa Orazione ha anche applicato <DepleteIconKeywords:Consumo> e <GuyouKeywords:Innato> alla carta.)"
  },
  State_3401_Name = {
    Text = "<Rune_7:Eco>"
  },
  State_3402_Desc = {
    Text = "Il Danno del colpo pesante di \"Piccone di ferro\" di Lusen è aumentato del [Layer]%."
  },
  State_3402_Name = {
    Text = "Danno da Attacco Pesante aumentato"
  },
  State_3402_WeaponDesc = {
    Text = "Danno di Colpo Pesante di \"Piccone di Ferro\"Lucen +[Layer]%"
  },
  State_3403_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_3403_Name = {
    Text = "Non Risvegliato"
  },
  State_3405_Name = {
    Text = "Tutti i nemici perdono temporaneamente [Power:StateArg1] <PowerIconKeywords:FOR> e i loro guadagni di Scudo del Personaggio e <PowerIconKeywords:FOR> sono ridotti del 50% per 1 turno."
  },
  State_3406_Name = {
    Text = "Ottieni [StateArg1] <PowerIconKeywords:FOR>"
  },
  State_3407_Name = {
    Text = "Scegli 1 carta dal Mazzo di Pesca, aggiungila alla tua mano e riduci il suo Costo di Arithmetica di 1."
  },
  State_3408_Name = {
    Text = "Ottieni <Posse:[DescArg1]> Keyflare. In questa Battaglia, il DAN Base di \"Decapitazione\" e \"Mille miraggi\" è aumentato del 10%."
  },
  State_3409_Name = {
    Text = "Scegli un Risvegliato per ottenere <Energy:[DescArg1]> Aliemus"
  },
  State_3410_Name = {
    Text = "Il Tasso Crit. e il Danno Crit. di questa carta aumentano del 50%, infliggendo Danni Perforanti."
  },
  State_3411_Name = {
    Text = "Diventa Immune a <FragileIconKeywords:Fragile>, <WeaknessIconKeywords:Debolezza>, <VulnerabilityIconKeywords:Vulnerabile> per 1 turno. Ottieni <Block:[Block:StateArg1]> Scudo del Personaggio."
  },
  State_3412_Desc = {
    Text = "Immune ai debuff. Si riduce di 1 accumulo alla fine di ogni turno o quando si subisce un colpo critico."
  },
  State_3412_Name = {
    Text = "Rivestimento di Cera"
  },
  State_3412_WeaponDesc = {
    Text = "Ogni accumulo riduce il danno subito del 10%. Perde 1 accumulo quando si subisce un Colpo Critico."
  },
  State_3415_Desc = {
    Text = "Scegli 1 tra 3 Orazioni Corrotte quando raccolte. Le Orazioni Corrotte sono più potenti ma esauriscono una carta quando giocate."
  },
  State_3415_Name = {
    Text = "Reliquia Impronta di Giada"
  },
  State_3415_WeaponDesc = {
    Text = "Scegli 1 tra 3 Orazioni Corrotte quando raccolte. Le Orazioni Corrotte sono più potenti ma esauriscono una carta quando giocate."
  },
  State_3416_Desc = {
    Text = "Unicità di Squadra: dopo l'inizio del combattimento, ottieni Contrattacco pari al <WeaponEffect_Num:[StateArg1]%> della DIF del portatore. Dopo aver attivato <DeathResistanceIconKeywords: Resistenza>, ottieni fino a un totale di 2 livelli di \"Culla\": il Potenziamento Scudo e la Guarigione della Vita di tutti gli alleati aumentano del <WeaponEffect_Num:[StateArg2]%>; alla fine del turno viene rimosso 1 livello. Se il Reame attuale è \"Caro\", dopo aver attivato <DeathResistanceIconKeywords: Resistenza>, Fusione Embrionale <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_3416_WeaponDesc = {
    Text = "Dopo l'inizio del combattimento, ottieni <WeaponEffect_Num:[Counterattack:DescArg1]> livelli di Contrattacco. Dopo aver attivato <DeathResistanceIconKeywords: Resistenza>, ottieni fino a un totale di 2 livelli di \"Culla\": il Potenziamento Scudo e la Guarigione della Vita di tutti gli alleati aumentano del <WeaponEffect_Num:[StateArg2]%>; alla fine del turno viene rimosso 1 livello. Se il Reame attuale è \"Caro\", dopo aver attivato <DeathResistanceIconKeywords: Resistenza>, Fusione Embrionale <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_3418_Desc = {
    Text = "Dopo la fine del turno, perdi la FOR temporanea"
  },
  State_3418_Name = {
    Text = "Risucchio Ritardato"
  },
  State_3419_Desc = {
    Text = "Al momento della raccolta, mostra 3 carte con Orazioni Avanzate o Maledette; scegline una per assegnarne l'Orazione."
  },
  State_3420_Desc = {
    Text = "Ogni azione causa Sanguinamento. La Guarigione può ridurre della metà il numero di accumuli di Sanguinamento."
  },
  State_3420_Name = {
    Text = "Schizzo di Sangue"
  },
  State_3420_WeaponDesc = {
    Text = "Ogni azione causa Sanguinamento. La Guarigione può ridurre della metà il numero di accumuli di Sanguinamento."
  },
  State_3421_Desc = {
    Text = "A inizio turno, aggiungi un \"Tridente Uncinato\" che conferisce [Arg1] Forza alla tua mano. Dopo aver rilasciato l'Esaltazione, aumenta la Forza di tutti i \"Tridente Uncinato\" In Mano di [Arg2]."
  },
  State_3422_Name = {
    Text = "Stato@Accessorio Rivelazione Pura"
  },
  State_3422_WeaponDesc = {
    Text = "Dopo aver rilasciato il Seguito, cura [DescArg1] HP. Se il Livello di Ricarica della Chiave d'Argento del portatore è superiore a 20, cura ulteriormente [DescArg1] HP. Effetti simili non si cumulano."
  },
  State_3423_Desc = {
    Text = "Padronanza del Reame 100 aumenta il Danno e il Danno tentacolo temporaneo."
  },
  State_3423_Name = {
    Text = "Cronopendolo \"Incubo\""
  },
  State_3424_Desc = {
    Text = "All'inizio del turno, se hai giocato più di 3 carte nel turno precedente, pesca 2 carte."
  },
  State_3425_Desc = {
    Text = "Quando i PV scendono sotto il 50% ([StateArg1]), l'intenzione cambia in \"Impasse Sopravvissuta\": rimuove gli stati Fragilità, Debolezza e Veleno, infliggendo 99 accumuli di Debolezza e Fragilità alla tua squadra."
  },
  State_3425_Name = {
    Text = "Momento della Vendetta"
  },
  State_3425_WeaponDesc = {
    Text = "Quando i PV scendono sotto il 50% ([StateArg1]), l'intenzione cambia in \"Impasse Sopravvissuta\": rimuove gli stati Fragilità, Debolezza e Veleno, infliggendo 99 accumuli di Debolezza e Fragilità alla tua squadra."
  },
  State_3429_Desc = {
    Text = "Ogni azione aggiunge Salasso; la guarigione rimuove l'effetto Salasso."
  },
  State_3429_Name = {
    Text = "Ferita Grave"
  },
  State_3429_WeaponDesc = {
    Text = "Ogni azione aggiunge Salasso; la guarigione rimuove l'effetto Salasso."
  },
  State_3430_Desc = {
    Text = "Dopo aver rilasciato un'Esaltazione, ottieni [Arg1] Contatore. Se questa è la sesta volta che si attiva in questa battaglia, raddoppia il tuo Contatore."
  },
  State_3431_Name = {
    Text = "Immunità al Veleno"
  },
  State_3432_Desc = {
    Text = "Esaurimento quando scartata"
  },
  State_3432_Name = {
    Text = "Costo di Scarto"
  },
  State_3432_WeaponDesc = {
    Text = "Quando pescata, applica Debolezza a te stesso per 1 turno. Quando usata, applica Debolezza a tutti i nemici per 1 turno. Non può essere venduta."
  },
  State_3434_Name = {
    Text = "Stato @ Modificatore Vulnerabile Generico"
  },
  State_3436_Desc = {
    Text = "[Layer] Risvegliati sono Cacciati."
  },
  State_3436_Name = {Text = "Braccato"},
  State_3437_Desc = {
    Text = "Stato@Mostro Balena Salto Fantasma Pianeta Progenie_Bestia del Caos"
  },
  State_3437_Name = {
    Text = "Stato@Mostro Balena Salto Fantasma Pianeta Progenie_Bestia del Caos"
  },
  State_3437_WeaponDesc = {
    Text = "Stato@Mostro Balena Salto Fantasma Pianeta Progenie_Bestia del Caos"
  },
  State_3438_Desc = {
    Text = "Ottieni [StateArg1] FOR temporanea."
  },
  State_3438_Name = {
    Text = "<CardKeyWord:Spada: Mecha>"
  },
  State_3439_Desc = {
    Text = "A fine turno, Tulu ottiene 5 Aliemus."
  },
  State_3439_Name = {
    Text = "Le Stelle Sono Allineate"
  },
  State_3440_Name = {
    Text = "Guida dorata"
  },
  State_3441_Desc = {
    Text = "Nei turni dispari, pesca 2 carte se non hai carte in mano; nei turni pari, ottieni 2 Arithmetica se non te ne rimane alcuna."
  },
  State_3441_Name = {
    Text = "Puzzle Antico"
  },
  State_3441_WeaponDesc = {
    Text = "Nei turni dispari, pesca 2 carte se non hai carte in mano; nei turni pari, ottieni 2 Arithmetica se non te ne rimane alcuna."
  },
  State_3442_Desc = {
    Text = "Perdi permanentemente [Arg1] Forza al momento della raccolta. Cura [Arg2] HP ogni volta che infliggi Danno, fino a 6 volte per turno."
  },
  State_3442_Name = {
    Text = "Bacio della Lampreda"
  },
  State_3444_Desc = {
    Text = "Pesca 1 carta all'inizio del turno."
  },
  State_3445_Desc = {
    Text = "Aumenta la DIF del [Layer]%."
  },
  State_3445_Name = {
    Text = "Aumenta la Difesa Generica in percentuale"
  },
  State_3445_WeaponDesc = {
    Text = "Aumenta la DIF del [Layer]%."
  },
  State_3446_Desc = {
    Text = "Ottieni 5 cariche di [Fuse]. Diminuisce di 1 quando giochi una carta. Quando raggiunge 0, si autodistrugge, infliggendo DAN pari a ATT * 2,5."
  },
  State_3446_Name = {Text = "Bomba"},
  State_3446_WeaponDesc = {
    Text = "Ottieni 5 cariche di [Fuse]. Diminuisce di 1 quando giochi una carta. Quando raggiunge 0, si autodistrugge, infliggendo DAN pari a ATT * 2,5."
  },
  State_3447_Desc = {
    Text = "Ottieni 5 cariche di [Fuse]. Diminuisce di 1 quando giochi una carta. Quando raggiunge 0, si autodistrugge, infliggendo DAN pari a ATT * 2,5."
  },
  State_3447_Name = {Text = "Bomba"},
  State_3447_WeaponDesc = {
    Text = "Ottieni 5 cariche di [Fuse]. Diminuisce di 1 quando giochi una carta. Quando raggiunge 0, si autodistrugge, infliggendo DAN pari a ATT * 2,5."
  },
  State_3448_Desc = {
    Text = "Alla fine di ogni turno, attiva tutti i Tentacoli"
  },
  State_3448_Name = {
    Text = "Auto-attivazione del tentacolo"
  },
  State_3448_WeaponDesc = {
    Text = "Alla fine di ogni turno, attiva tutti i Tentacoli"
  },
  State_3449_Desc = {
    Text = "Stato@Prologo Aliemus 0_1_1 Attivo"
  },
  State_3449_Name = {
    Text = "Stato@Prologo Aliemus 0_1_1 Attivo"
  },
  State_3449_WeaponDesc = {
    Text = "Stato@Prologo Aliemus 0_1_1 Attivo"
  },
  State_3450_Desc = {
    Text = "Quando si subisce Danno attivo o Danni da tentacolo, diventa Immune ai danni e rimuovi 1 accumulo."
  },
  State_3450_Name = {
    Text = "<ParcloseIconKeywords:Barriera>"
  },
  State_3450_WeaponDesc = {
    Text = "Danni subiti -99%. Dopo aver subito danni, perdi 1 accumulo."
  },
  State_3451_Desc = {
    Text = "Tutti i Risvegliati ottengono 10 Aliemus alla morte."
  },
  State_3451_Name = {
    Text = "Scaglie d'Argento Residue"
  },
  State_3451_WeaponDesc = {
    Text = "Tutti i Risvegliati ottengono 10 Aliemus alla morte."
  },
  State_3452_Desc = {
    Text = "Ogni volta che giochi una carta, subisci [StateArg1] Danno e rimuovi 1 accumulo. A fine turno, se rimangono accumuli, schiudi una \"Creatura Marina\". Per ogni accumulo, i PV aumentano del 10%."
  },
  State_3452_Name = {
    Text = "Erosione Abissale"
  },
  State_3453_Name = {
    Text = "Stato@Moltiplicatore Potere Lama della Vendetta"
  },
  State_3455_Desc = {
    Text = "Stato@Prologo Aliemus Init 0_2_3 Effetto"
  },
  State_3455_Name = {
    Text = "Stato@Prologo Aliemus Init 0_2_3 Effetto"
  },
  State_3455_WeaponDesc = {
    Text = "Stato@Prologo Aliemus Init 0_2_3 Effetto"
  },
  State_3456_Desc = {
    Text = "[Defense] Ottieni [StateArg1] Contatore."
  },
  State_3456_Name = {
    Text = "Reliquia Gilet d'Ortica"
  },
  State_3457_Name = {
    Text = "Immunità alla Vulnerabilità"
  },
  State_3458_Desc = {
    Text = "Gioca [Strike] e [Defense]. Il Risvegliato corrispondente ottiene 35 Aliemus, ma il suo Costo di Arithmetica aumenta di 1."
  },
  State_3459_Desc = {
    Text = "I danni da Esaltazione aumentano di [Layer] durante questa battaglia."
  },
  State_3459_Name = {
    Text = "Potenziamento Danni Esaltazione"
  },
  State_3461_Desc = {
    Text = "Il tuo quinto attacco infligge sempre Danno Crit."
  },
  State_3462_Name = {
    Text = "Stato@Moltiplicatore Potere Spadone della Vendetta 3"
  },
  State_3463_Name = {
    Text = "Stato@Moltiplicatore Potere Spadone della Vendetta 2"
  },
  State_3464_Desc = {
    Text = "Il Limite Tentacoli aumenta di 1. Se i PV sono inferiori al 50%, il Danno del Tentacolo aumenta di [Arg1]."
  },
  State_3465_Desc = {
    Text = "Questa Carta verrà portata in Battaglia e sarà efficace all'interno del Livello."
  },
  State_3465_Name = {
    Text = "<CardKeyWord:Permanente>"
  },
  State_3465_WeaponDesc = {
    Text = "Questa carta può essere portata fuori dalla Battaglia ed è efficace all'interno dello stage."
  },
  State_3466_Desc = {
    Text = "Al momento della raccolta, scegli un Risvegliatore da Risvegliare. Il Costo di Arithmetica della sua carta Rouse è ridotto permanentemente di 1."
  },
  State_34671_Desc = {
    Text = "Torna in mano dopo essere stata giocata."
  },
  State_34671_Name = {
    Text = "<CardKeyWord:Ritorno in Mano>"
  },
  State_34685_Name = {
    Text = "Giocatore Bomba 2"
  },
  State_34689_Desc = {
    Text = "Per ogni punto di HP perso, ottieni 1 accumulo di <PainWord:Sopportare>, fino al 100% degli HP massimi. Sopportare verrà mantenuto nella battaglia successiva."
  },
  State_34689_Name = {
    Text = "<CardKeyWord:Sopportare>"
  },
  State_3468_Desc = {
    Text = "Stato @ Risentimento del Difettoso"
  },
  State_3468_Name = {
    Text = "Stato @ Risentimento del Difettoso"
  },
  State_3468_WeaponDesc = {
    Text = "Stato @ Risentimento del Difettoso"
  },
  State_34691_Desc = {
    Text = "Ogni volta che si perde 1 punto Vita, si ottiene 1 livello di <PainWord:Sopportare>. Il limite massimo è [DescArg1] livelli. Sopportare viene ereditato nel combattimento successivo."
  },
  State_34691_Name = {
    Text = "<CardKeyWord:Sopportare>"
  },
  State_34696_Desc = {
    Text = "Questa carta resta sempre nella tua mano e aumenta il limite della mano di +1."
  },
  State_34696_Name = {
    Text = "Conservata Permanentemente ignorando il limite di mano"
  },
  State_3469_Desc = {
    Text = "Tutti i Danni attivi e Danni da tentacolo inflitti -[DescArg1]%."
  },
  State_3469_Name = {
    Text = "<WeaknessColour:Debolezza>"
  },
  State_3469_WeaponDesc = {
    Text = "Riduce tutti i danni inflitti del [DescArg1]%."
  },
  State_3470_Desc = {
    Text = "Applica Rilevamento Pietrificazione Graduale"
  },
  State_3470_Name = {
    Text = "Applica Rilevamento Pietrificazione Graduale"
  },
  State_3470_WeaponDesc = {
    Text = "Applica Rilevamento Pietrificazione Graduale"
  },
  State_3471_Desc = {
    Text = "Ogni volta che giochi la [StateArg1]ª carta, essa ha effetto due volte."
  },
  State_3471_Name = {
    Text = "Conteggio Vino Stellare"
  },
  State_3471_WeaponDesc = {
    Text = "Ogni volta che giochi la [StateArg1]ª carta, essa ha effetto due volte."
  },
  State_3473_Desc = {
    Text = "Quando i PV scendono sotto il 50%, il \"Pastore della Lanterna\" pregherà per \"La Discesa del Divino\" e andrà in Berserk dopo aver assorbito tutti i seguaci."
  },
  State_3473_Name = {
    Text = "Marchio dello Stoppino"
  },
  State_3473_WeaponDesc = {
    Text = "Quando i PV scendono sotto il 50%, il \"Pastore della Lanterna\" pregherà per \"La Discesa del Divino\" e andrà in Berserk dopo aver assorbito tutti i seguaci."
  },
  State_3475_Desc = {
    Text = "[Strike] e [Defense] Costo di Arithmetica +1."
  },
  State_3475_Name = {
    Text = "Reliquia Stele Maledetta"
  },
  State_3475_WeaponDesc = {
    Text = "[Strike] e [Defense] Costo di Arithmetica +1."
  },
  State_3476_Desc = {
    Text = "Ogni volta che perdi HP, Fusione Embrionale +10%. Se gli HP sono sotto il 50%, questo effetto raddoppia."
  },
  State_3477_Desc = {
    Text = "Recupera [Layer] Vita quando attaccato; sviene e rimuove questo stato se il Danno supera il 15% della Salute massima"
  },
  State_3477_Name = {
    Text = "Fauci d'Ossidiana"
  },
  State_3478_Name = {
    Text = "Stato@Patto Accessorio Standard"
  },
  State_3479_Desc = {
    Text = "Per ogni Sigillo Nero consumato, tutti i Risvegliatori ottengono 1 Aliemus."
  },
  State_3479_Name = {
    Text = "Fiore Inverso della Reliquia"
  },
  State_3479_WeaponDesc = {
    Text = "Per ogni Sigillo Nero consumato, tutti i Risvegliatori ottengono 1 Aliemus."
  },
  State_3480_Desc = {
    Text = "Fino alla fine del turno, gli HP non scenderanno a 0."
  },
  State_3480_Name = {
    Text = "Diamante grezzo: Immortale"
  },
  State_3480_WeaponDesc = {
    Text = "Fino alla fine del turno, gli HP non scenderanno a 0."
  },
  State_3481_Desc = {
    Text = "All'inizio del Livello, raddoppia i tassi di Resistenza alla Morte e Orazione."
  },
  State_3481_Name = {
    Text = "Stato@Chiave d'argento Illusoria: Doppia Fortuna"
  },
  State_3482_Desc = {
    Text = "Aumenta l'effetto di Vulnerabile del 25%. Ogni 3 turni, aggiungi 1 accumulo di Vulnerabile a tutti i nemici."
  },
  State_3483_Desc = {
    Text = "Ogni azione aggiunge Salasso; la guarigione rimuove l'effetto Salasso."
  },
  State_3483_Name = {
    Text = "Ferita Grave"
  },
  State_3483_WeaponDesc = {
    Text = "Ogni azione aggiunge Salasso; la guarigione rimuove l'effetto Salasso."
  },
  State_3484_Desc = {
    Text = "Ottieni Forza dopo aver inflitto Danno effettivo."
  },
  State_3484_Name = {
    Text = "\"Persona Caotica\""
  },
  State_3485_Desc = {
    Text = "Stato@Cerimonia delle Lanterne Attiva"
  },
  State_3485_Name = {
    Text = "Stato@Cerimonia delle Lanterne Attiva"
  },
  State_3485_WeaponDesc = {
    Text = "Stato@Cerimonia delle Lanterne Attiva"
  },
  State_3486_Name = {
    Text = "Colpo Predestinato"
  },
  State_3488_Desc = {
    Text = "Subisci [StateArg1] DAN e rimuovi 1 accumulo quando giochi una carta. Quando gli accumuli raggiungono 0, schiudi una \"Creatura Marina\" più debole. Se ancora parassitato a fine turno, schiudi una \"Creatura Marina\" con PV basati sugli accumuli."
  },
  State_3488_Name = {
    Text = "Parassitato Ripetutamente"
  },
  State_3489_Name = {
    Text = "A fine turno, se in mano o nello <DimensionalSpaceIconKeywords:Spazio Ultra>, potenzia a \"Fiamme Corrotte\""
  },
  State_3489_WeaponDesc = {
    Text = "Potenzia se In Mano o nello Spazio Ultra alla fine del turno."
  },
  State_3490_Desc = {
    Text = "Subisci [StateArg1] DAN e rimuovi 1 accumulo quando giochi una carta. Quando gli accumuli raggiungono 0, schiudi una \"Creatura Marina\" più debole. Se ancora parassitato a fine turno, schiudi una \"Creatura Marina\" con PV basati sugli accumuli."
  },
  State_3490_Name = {
    Text = "Parassitato di Nuovo"
  },
  State_3492_Desc = {
    Text = "Riduce la Forza della squadra di [Layer] ogni turno pari."
  },
  State_3492_Name = {Text = "Scarica"},
  State_3495_Desc = {
    Text = "Ogni azione applica [Layer] Sanguinamento."
  },
  State_3495_Name = {
    Text = "Ferita Grave"
  },
  State_3495_WeaponDesc = {
    Text = "Ogni azione aggiunge [Layer] Sanguinamento; la Guarigione può rimuovere l'Effetto Sanguinamento."
  },
  State_34964_Desc = {
    Text = "All'inizio del turno, ottieni il 10% dei PV massimi da <PainWord:Sopportare>."
  },
  State_34964_Name = {
    Text = "Mai Dimenticare"
  },
  State_3496_Name = {
    Text = "A fine turno, se in mano o nello <DimensionalSpaceIconKeywords:Spazio Ultra>, potenzia a \"Fiamme Letali\""
  },
  State_3496_WeaponDesc = {
    Text = "Potenzia se In Mano o nello Spazio Ultra alla fine del turno."
  },
  State_3497_Desc = {
    Text = "Quando la squadra è composta da Risvegliati di professioni diverse, i PV della squadra e l'Attacco e la Difesa di tutti i Risvegliati aumentano del 200%."
  },
  State_3497_Name = {
    Text = "Bonus Misto"
  },
  State_3497_WeaponDesc = {
    Text = "Quando la squadra è composta da Risvegliati di professioni diverse, i PV della squadra e l'Attacco e la Difesa di tutti i Risvegliati aumentano del 200%."
  },
  State_3499_Desc = {
    Text = "Unico per Squadra: L'Aliemus generato dal Portatore aumenta del <WeaponEffect_Num:[StateArg1]%>. Il Portatore ottiene <WeaponEffect_Num:[StateArg2]> Keyflare dopo aver rilasciato l'Esaltazione."
  },
  State_3499_WeaponDesc = {
    Text = "L'Aliemus generato dal portatore aumenta del <WeaponEffect_Num:[StateArg1]%>. Dopo aver attivato l'Esaltazione, il portatore ottiene <WeaponEffect_Num:[StateArg2]> Keyflare."
  },
  State_3502_Desc = {
    Text = "Danno, Scudo del Personaggio e Guarigione del Portatore +[StateArg1]%. (Temporaneo)"
  },
  State_3502_Name = {
    Text = "Stato@Proto Coltello Aliemus"
  },
  State_3504_Desc = {
    Text = "Pesca [StateArg1] carte a inizio turno."
  },
  State_3504_Name = {
    Text = "Reliquia Bussola del Nord Vero"
  },
  State_3504_WeaponDesc = {
    Text = "Pesca [StateArg1] carte a inizio turno."
  },
  State_3507_Name = {
    Text = "Accessorio: Forma Organica"
  },
  State_3507_WeaponDesc = {
    Text = "Dopo che il Portatore usa Esaltazione, il suo Scudo e il suo Pot. Guarigione vengono raddoppiati per questo turno."
  },
  State_3508_Name = {
    Text = "Accessorio: Crisalide della Fanciulla"
  },
  State_3508_WeaponDesc = {
    Text = "All'inizio della battaglia, se il portatore appartiene al Reame del Caos, ATT +25%."
  },
  State_3510_Desc = {
    Text = "Lo Scudo del Personaggio del Risvegliatore aumenta di [Layer]."
  },
  State_3510_Name = {
    Text = "<AlertColour:Allerta>"
  },
  State_3511_Desc = {
    Text = "Danno, Scudo del Personaggio e Guarigione del Portatore +[StateArg1]%. (Temporaneo)"
  },
  State_3511_Name = {
    Text = "Stato@Prototipo Spada della Fortuna"
  },
  State_35120_Desc = {
    Text = "Per ogni istanza di Danno attivo subito, applica [StateArg1] <plural value=\"[Poison:StateArg1]\" singular=\"accumulo\" plural=\"accumuli\"> di Veleno all'attaccante, per [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turni\">."
  },
  State_35120_Name = {
    Text = "Fiore Immortale sulla Melma"
  },
  State_3512_Name = {
    Text = "Immunità temporanea a Fragile"
  },
  State_3514_Desc = {
    Text = "Al termine del turno, subisci <FixedDamage:DAN Puro> pari al numero di accumuli e rimuovi questo stato."
  },
  State_3514_Name = {
    Text = "<BleedingIconKeywords:Salasso>"
  },
  State_3514_WeaponDesc = {
    Text = "Subisci danni a inizio turno."
  },
  State_35158_Name = {
    Text = "Cronopendolo \"Trance\""
  },
  State_3515_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_3515_Name = {
    Text = "Non Risvegliato"
  },
  State_35161_Name = {
    Text = "Cronopendolo \"Carica\""
  },
  State_3516_Name = {
    Text = "Stato@Sintomo: Sconforto Maledetto"
  },
  State_3518_Desc = {
    Text = "Ogni volta che La Maga gioca una carta, ottiene [StateArg2] FOR temporanea."
  },
  State_3518_Name = {
    Text = "Atto d'Apertura"
  },
  State_3519_Desc = {
    Text = "Anche al di fuori dei Turni Ultra, puoi attivare un Effetto Balzo una volta per turno."
  },
  State_3519_Name = {
    Text = "Deflettore spaziale"
  },
  State_3519_WeaponDesc = {
    Text = "Anche al di fuori dei Turni Ultra, puoi attivare un Effetto Balzo una volta per turno."
  },
  State_3520_Desc = {
    Text = "All'inizio della battaglia, seleziona un Risvegliatore e concedigli 50 Aliemus."
  },
  State_35228_Name = {
    Text = "Cronopendolo \"Carica\""
  },
  State_3522_Name = {
    Text = "Conteggio Reliquia Tridente"
  },
  State_35238_Desc = {
    Text = "Unico per Squadra: Lo Scudo e il Veleno causati dal Portatore aumentano del <WeaponEffect_Num:[StateArg1]%>. Ogni volta che la Resistenza viene attivata, tutti i Risvegliati ottengono <WeaponEffect_Num:[StateArg2]%> di Tasso critico temporaneo e Danno Crit."
  },
  State_35238_WeaponDesc = {
    Text = "Aumenta la Generazione di Scudo e il Veleno del Portatore del <WeaponEffect_Num:[StateArg1]%>. All'attivazione della Resistenza alla Morte, tutti i Risvegliati ottengono <WeaponEffect_Num:[StateArg2]%> di Tasso critico temporaneo e Danno Crit."
  },
  State_3523_Desc = {
    Text = "Quando giocata, infliggi [StateArg1] turni di <WeaknessIconKeywords:Debolezza> a tutti i nemici."
  },
  State_3523_Name = {
    Text = "<Rune_2_High:Debolezza avanz.>"
  },
  State_3524_Desc = {
    Text = "Danno subito aumentato di [Layer]."
  },
  State_3524_Name = {
    Text = "Ferita da Dissoluzione"
  },
  State_3524_WeaponDesc = {
    Text = "Danno subito aumentato di [Layer]."
  },
  State_3525_Desc = {
    Text = "Ogni volta che la mia squadra gioca una carta, applica 2 accumuli di [Bind]."
  },
  State_3525_Name = {
    Text = "\"Esclusiva del Distretto Est\""
  },
  State_3525_WeaponDesc = {
    Text = "Ogni volta che la mia squadra gioca una carta, applica 2 accumuli di [Bind]."
  },
  State_35264_Desc = {
    Text = "In questo turno, \"L'Arcanista\" ottiene 1 accumulo di Fantasma per ogni carta giocata."
  },
  State_35264_Name = {
    Text = "Registro dello scambio d'ombre"
  },
  State_35277_Name = {
    Text = "Difesa Magica di Casiah"
  },
  State_3527_Desc = {
    Text = "Alla fine di ogni turno, il Risvegliatore corrispondente alla prima Carta di comando ottiene 15 Aliemus. Quando possiedi \"Cuore Devoto\", concedi agli altri Risvegliatori 5 Aliemus."
  },
  State_3528_Desc = {
    Text = "Danno, Scudo del Personaggio e Guarigione del Portatore +[StateArg1]%. (Temporaneo)"
  },
  State_3528_Name = {
    Text = "Stato@Proto Cannone Laser Reame"
  },
  State_3529_Desc = {
    Text = "Immune a tutti i Danni. Rimosso a inizio turno."
  },
  State_3529_Name = {
    Text = "Immunità ai Danni"
  },
  State_3530_Desc = {
    Text = "Stato@Segno All-in Detective Fortunato 8"
  },
  State_3530_Name = {
    Text = "Stato@Segno All-in Detective Fortunato 8"
  },
  State_3530_WeaponDesc = {
    Text = "Stato@Segno All-in Detective Fortunato 8"
  },
  State_3531_Desc = {
    Text = "Unico per squadra: All'inizio della battaglia, il portatore ottiene <WeaponEffect_Num:[StateArg1]> Aliemus. Ogni volta che un altro Risvegliatore rilascia un'Esaltazione, il portatore ottiene <WeaponEffect_Num:[StateArg2]> Aliemus. Se il Reame attuale è \"Aequor\", dopo che il portatore rilascia un'Esaltazione, ottiene Danni da tentacolo pari al <WeaponEffect_Num:[StateArg3]%> del suo Attacco."
  },
  State_3531_WeaponDesc = {
    Text = "A inizio battaglia, il portatore ottiene <WeaponEffect_Num:[StateArg1]> Aliemus. Ogni volta che un altro Risvegliato si Esalta, il portatore ottiene <WeaponEffect_Num:[StateArg2]> Aliemus. Se il Reame attuale è \"Aequor\", i Danni da Tentacolo aumentano di <WeaponEffect_Num:+[DescArg1]> dopo che il portatore si Esalta."
  },
  State_3532_Desc = {
    Text = "A inizio turno, ottieni [StateArg1] Arithmetica."
  },
  State_3532_Name = {
    Text = "Reliquia Candela nera 1"
  },
  State_3533_Desc = {
    Text = "Appare sempre nella mano iniziale."
  },
  State_3533_Name = {
    Text = "<GuyouKeywords:Innato>"
  },
  State_3533_WeaponDesc = {
    Text = "All'inizio della battaglia, questa carta è fissata in mano."
  },
  State_3535_Desc = {
    Text = "Il Costo di Arithmetica della Carta aumenta di [Layer]. Questo debuff verrà rimosso a fine turno o dopo aver giocato una carta."
  },
  State_3535_Name = {
    Text = "<SlowColour:Stagnante temp. [Layer]>"
  },
  State_3535_WeaponDesc = {
    Text = "Il Costo di Arithmetica della carta aumenta di [Layer]."
  },
  State_3536_Name = {
    Text = "Può essere usato fino a 3 volte nelle battaglie Boss."
  },
  State_3537_Desc = {
    Text = "Ottieni un'Orazione al momento di ricevere \"Dono dell'Innocente.\""
  },
  State_3537_Name = {
    Text = "Stato@Capitolo1_Risonanza4"
  },
  State_3537_WeaponDesc = {
    Text = "Ottieni un'Orazione al momento di ricevere \"Dono dell'Innocente.\""
  },
  State_3538_Desc = {
    Text = "\"Dono di ritorno dell'Innocente\" genera più Aliemus"
  },
  State_3538_Name = {
    Text = "Stato@Capitolo Uno_Risonanza1"
  },
  State_3538_WeaponDesc = {
    Text = "\"Dono di ritorno dell'Innocente\" genera più Aliemus"
  },
  State_3539_Desc = {
    Text = "\"Dono dell'Innocente\" Costo di Arithmetica -1"
  },
  State_3539_Name = {
    Text = "Stato@Capitolo 1_Risonanza 3"
  },
  State_3539_WeaponDesc = {
    Text = "\"Dono dell'Innocente\" Costo di Arithmetica -1"
  },
  State_3540_Desc = {
    Text = "\"Regalo Innocente di Ritorno\" può designare un bersaglio"
  },
  State_3540_Name = {
    Text = "Stato@Capitolo 1_Risonanza 2"
  },
  State_3540_WeaponDesc = {
    Text = "\"Regalo Innocente di Ritorno\" può designare un bersaglio"
  },
  State_3541_Desc = {
    Text = "Koom è caduto nella trappola che hai teso."
  },
  State_3541_Name = {
    Text = "Intrappolato"
  },
  State_3542_Desc = {
    Text = "All'inizio della battaglia, ottieni [Arg1] Forza per ogni Orazione nel mazzo e ripristina [Arg2] PV per ogni Reliquia."
  },
  State_3542_Name = {
    Text = "☆Medaglia Gilda☆"
  },
  State_3545_Name = {
    Text = "Resistenza a Colore Accecante"
  },
  State_3545_WeaponDesc = {
    Text = "Ottieni [StateArg1]% di Resistenza alla Morte per ogni carta giocata. Recupera [StateArg2] PV quando ottieni Resistenza alla Morte."
  },
  State_3546_Desc = {
    Text = "Ogni volta che la mia squadra gioca una carta, applica [Layer] accumuli di [Bind]."
  },
  State_3546_Name = {
    Text = "\"Esclusiva del Distretto Est\""
  },
  State_3546_WeaponDesc = {
    Text = "Ogni volta che la mia squadra gioca una carta, applica [Layer] accumuli di [Bind]."
  },
  State_3547_Desc = {
    Text = "Ogni volta che la mia squadra gioca una carta, applica [Layer] accumuli di [Bind]."
  },
  State_3547_Name = {
    Text = "\"Esclusiva del Distretto Est\""
  },
  State_3547_WeaponDesc = {
    Text = "Ogni volta che la mia squadra gioca una carta, applica [Layer] accumuli di [Bind]."
  },
  State_3548_Desc = {
    Text = "Quando pescata, applica Debolezza a te stesso per 1 turno. Quando usata, applica Debolezza a tutti i nemici per 1 turno. Non può essere venduta."
  },
  State_3548_Name = {
    Text = "Stato Maledizione Indebolimento"
  },
  State_3548_WeaponDesc = {
    Text = "Quando pescata, applica Debolezza a te stesso per 1 turno. Quando usata, applica Debolezza a tutti i nemici per 1 turno. Non può essere venduta."
  },
  State_3549_Name = {
    Text = "Stato Accessorio Steppenwolf"
  },
  State_3549_WeaponDesc = {
    Text = "DAN Base del portatore +10%. Se l'Amplificazione del Danno del portatore supera il 20%, il DAN Base ulteriormente +10%."
  },
  State_35503_Name = {
    Text = "Cronopendolo \"Proliferazione\""
  },
  State_3551_Desc = {
    Text = "A inizio turno, se più di [StateArg1] carte sono rimaste in mano nel turno precedente, ottieni [StateArg2] Arithmetica."
  },
  State_3551_Name = {
    Text = "Reliquia Motore Differenziale"
  },
  State_3551_WeaponDesc = {
    Text = "A inizio turno, se più di [StateArg1] carte sono rimaste in mano nel turno precedente, ottieni [StateArg2] Arithmetica."
  },
  State_35539_Desc = {
    Text = "Subisci Danno doppio per [Layer] turni."
  },
  State_35539_Name = {
    Text = "Resti del Viandante"
  },
  State_3553_Desc = {
    Text = "Tasso di crit. aumentato del 25%. Dopo aver ripristinato i PV, c'è una probabilità di ripristinare i PV un'ulteriore volta, con probabilità pari al tasso di crit. di chi cura."
  },
  State_3553_Name = {
    Text = "Stato@Chiave d'argento Fantasma: Cura Critica"
  },
  State_3554_Desc = {
    Text = "Gli effetti di Scudo e Guarigione sono aumentati del [Layer]%"
  },
  State_3554_Name = {
    Text = "Amp. Scudo e Guarigione"
  },
  State_3554_WeaponDesc = {
    Text = "Gli effetti di Scudo e Guarigione sono aumentati del [Layer]%"
  },
  State_3555_Desc = {
    Text = "Ottieni il 100% di Resistenza alla Morte al momento della raccolta. Dopo aver attivato la Resistenza alla Morte, ripristina [Arg1] PV a inizio turno in questa battaglia."
  },
  State_3555_Name = {
    Text = "Soffio vitale"
  },
  State_3556_Desc = {
    Text = "Quando questa reliquia viene raccolta, scegli una carta e aggiungi una sua copia al mazzo."
  },
  State_3558_Desc = {
    Text = "A inizio turno, se il numero di Sigilli Neri supera 10, esaurisci 10 Sigilli Neri; il Danno inflitto durante quel turno è raddoppiato."
  },
  State_3559_Desc = {
    Text = "Applica 1 Fragile quando infliggi Danno non bloccabile."
  },
  State_3559_Name = {Text = "Artiglio"},
  State_3559_WeaponDesc = {
    Text = "Quando si infliggono Danni effettivi, mischia [StateArg1] \"Ferita\" nel Mazzo di Pesca."
  },
  State_3561_Name = {
    Text = "Stato@Chiave d'argento Fantasma: Contrattacco Fendente"
  },
  State_3562_Desc = {
    Text = "Dopo la morte, la Forza degli altri alleati aumenta di [Layer]."
  },
  State_3562_Name = {
    Text = "Sussurro della Morte"
  },
  State_35635_Name = {
    Text = "Stato@Risvegliatore Casiah Attivazione Telecinesi Consentita"
  },
  State_35636_Name = {
    Text = "Stato@Risvegliatore Casiah Aggiungi Telecinesi"
  },
  State_3563_Desc = {
    Text = "Quando si infligge Danno non bloccato, mischia [StateArg1] \"Ferita\" nel Mazzo di Pesca."
  },
  State_3563_Name = {Text = "Lama"},
  State_3563_WeaponDesc = {
    Text = "Quando si infliggono Danni effettivi, mischia [StateArg1] \"Ferita\" nel Mazzo di Pesca."
  },
  State_35645_Desc = {
    Text = "Pesca [Layer] carte in meno in questo turno."
  },
  State_35645_Name = {
    Text = "Riduzione Pesca"
  },
  State_35646_Desc = {
    Text = "Pesca [Layer] carte in meno in questo turno."
  },
  State_35646_Name = {
    Text = "Riduzione Pesca"
  },
  State_3564_Desc = {
    Text = "Quando giocata, ottieni prima [StateArg1] <PowerIconKeywords:FOR> Temp., poi risolvi gli effetti della carta. (I suoi effetti di danno beneficeranno di questa FOR.)"
  },
  State_3564_Name = {
    Text = "<Rune_15_High:Esplosione Avanzata>"
  },
  State_3565_Desc = {
    Text = "Quando lo Scultore applica uno scudo, il danno dei Tentacoli è aumentato di [StateArg1]."
  },
  State_3565_Name = {
    Text = "Regno dell'Oblio"
  },
  State_3565_WeaponDesc = {
    Text = "Quando lo Scultore applica uno scudo, il danno dei Tentacoli è aumentato di [StateArg1]."
  },
  State_3566_Desc = {
    Text = "A inizio turno, ottieni 3 FOR temporanea. [Exalt] raddoppia questa FOR temporanea, fino a 2 accumuli."
  },
  State_3566_Name = {
    Text = "Reliquia Spoglia del serpente"
  },
  State_3567_Desc = {
    Text = "Danno, Scudo del Personaggio e Guarigione del Portatore +[StateArg1]%. (Temporaneo)"
  },
  State_3567_Name = {
    Text = "Stato@Proto Cannone Laser Colpo Critico"
  },
  State_35684_Desc = {
    Text = "Dopo che la tua squadra attiva Esaltazione, perdiamo Forza per il turno corrente. Una volta per turno."
  },
  State_35684_Name = {
    Text = "Paura dell'Alienus"
  },
  State_35685_Desc = {
    Text = "All'Avvento della Genesi, riduce la FOR temporanea dei nemici."
  },
  State_35685_Name = {
    Text = "Paura dell'Alienus"
  },
  State_3568_Desc = {
    Text = "Quando Ramona infligge DAN, ottiene [StateArg1] Arithmetica."
  },
  State_3568_Name = {
    Text = "Prima Dottrina"
  },
  State_3568_WeaponDesc = {
    Text = "Quando Ramona infligge DAN, ottiene [StateArg1] Arithmetica."
  },
  State_3570_Name = {
    Text = "Pesca +2 carte all'inizio del prossimo turno"
  },
  State_3571_Name = {
    Text = "Immunità temporanea a Debolezza"
  },
  State_3572_Desc = {
    Text = "Il DAN dei mostri evocati è raddoppiato."
  },
  State_3572_Name = {Text = "Comandante"},
  State_3572_WeaponDesc = {
    Text = "Il DAN dei mostri evocati è raddoppiato."
  },
  State_3573_Desc = {
    Text = "La prima istanza di danno subito in ogni turno viene moltiplicata per cinque."
  },
  State_3573_Name = {Text = "Arroganza"},
  State_3573_WeaponDesc = {
    Text = "Il primo Danno subito ogni turno è raddoppiato."
  },
  State_3574_Desc = {
    Text = "Quando si giocano carte consecutive dello stesso Risvegliato, quel Risvegliato ottiene 10 Aliemus."
  },
  State_35768_Name = {
    Text = "Ottieni 300 Keyflare"
  },
  State_35769_Name = {
    Text = "Ottieni 1 Arithmetica."
  },
  State_35770_Name = {
    Text = "Dissolvi gli stati di <IntoxicationIconKeywords:Veleno>, Sigillato e <SlowIconKeywords:Stagnazione> da te stesso"
  },
  State_35771_Name = {
    Text = "Ottieni uno Scudo del Personaggio pari al [DescArg1]% (<Block:[DescArg2]>) dei PV massimi."
  },
  State_35772_Name = {
    Text = "Disponibile ancora [StateArg1] volte nelle Battaglie Boss."
  },
  State_35774_Desc = {
    Text = "Prima della morte, invoca l'aiuto di Celeste, ripristinando tutta la Vita, Aliemus e Keyflare."
  },
  State_35774_Name = {
    Text = "Velo Utopico"
  },
  State_3577_Name = {
    Text = "Potenziamento Recupero Automatico Aliemus"
  },
  State_35809_Desc = {
    Text = "Il Danno inflitto è ridotto del [StateArg1]%, per [Layer] turni."
  },
  State_35809_Name = {
    Text = "Erede dell'Illusione"
  },
  State_35809_WeaponDesc = {
    Text = "Stato@Aequor Tè e Dolci della Dama"
  },
  State_3580_Desc = {
    Text = "[Layer] Gli Attacchi del tentacolo infliggono Danni Perforanti in questo turno."
  },
  State_3580_Name = {
    Text = "Tentacolo Perforante"
  },
  State_35811_Desc = {
    Text = "Quando si subisce un Danno attivo o da Tentacolo, si ottiene metà del danno come <SacrificeKeyWord:Sacrificio> per [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turni\">."
  },
  State_35811_Name = {
    Text = "Erede dell'Illusione"
  },
  State_35819_Desc = {
    Text = "A fine turno, Murphy ottiene 5 Aliemus. Al rilascio di Posse, rimuovi il 2% degli HP massimi con <SacrificeKeyWord:Sacrificio>."
  },
  State_35819_Name = {
    Text = "Tè Nero e Torta"
  },
  State_3581_Desc = {
    Text = "Stato@Contrattacco Valzer Lussurioso della Dama Rossa"
  },
  State_3581_Name = {
    Text = "Stato@Contrattacco Valzer Lussurioso della Dama Rossa"
  },
  State_3582_Desc = {
    Text = "Anche al di fuori dei Turni Ultra, puoi attivare un effetto Balzo una volta per turno. Quando attivato, pesca una carta corrispondente al Risvegliato."
  },
  State_3582_Name = {
    Text = "Deflettore spaziale mutato"
  },
  State_3582_WeaponDesc = {
    Text = "Anche al di fuori dei Turni Ultra, puoi attivare un effetto Balzo una volta per turno. Quando attivato, pesca una carta corrispondente al Risvegliato."
  },
  State_3584_Desc = {
    Text = "Danno, Scudo del Personaggio e Guarigione del Portatore +[StateArg1]%. (Temporaneo)"
  },
  State_3584_Name = {
    Text = "Stato@Proto Coltello Reame"
  },
  State_35858_Desc = {
    Text = "A fine turno, Murphy ottiene 5 Aliemus. Dopo aver rilasciato il Seguito, infliggi Danno da Tentacolo pari al 3% dell'attacco di Murphy."
  },
  State_35858_Name = {
    Text = "Tè Nero e Torta"
  },
  State_3585_Desc = {
    Text = "Quando i PV scendono sotto il 50% ([StateArg1]), il \"Pastore della Lanterna\" pregherà per la \"Discesa del Divino\" e impazzirà dopo aver assorbito tutti i seguaci."
  },
  State_3585_Name = {
    Text = "Marchio dello Stoppino"
  },
  State_3585_WeaponDesc = {
    Text = "Quando i PV scendono sotto il 50% ([StateArg1]), il \"Pastore della Lanterna\" pregherà per la \"Discesa del Divino\" e impazzirà dopo aver assorbito tutti i seguaci."
  },
  State_3588_Name = {
    Text = "Creazione Reliquia Arcana Arithmetica"
  },
  State_3589_Desc = {
    Text = "Quando si subisce Danno attivo o Danni da tentacolo, diventa immune ai danni e perdi 1 accumulo."
  },
  State_3589_Name = {
    Text = "<ParcloseColour:Barriera>"
  },
  State_3591_Desc = {
    Text = "Unicità di Squadra: Il <RetaliateIconKeywords:Contrattacco> del portatore +<WeaponEffect_Num:[StateArg1]%>. \"Difesa\" concede un Contrattacco Temporaneo pari alla DIF del portatore ×<WeaponEffect_Num:[StateArg2]%>. Nelle Battaglie Boss, questo diventa 3 volte il Contrattacco Temporaneo. Dopo che si attiva la Resistenza, attiva un [StateArg3]% di <RetaliateIconKeywords:Contrattacco> contro tutti i nemici."
  },
  State_3591_Name = {
    Text = "Celato nella Notte"
  },
  State_3591_WeaponDesc = {
    Text = "<RetaliateIconKeywords:Contrattacco> del portatore +<WeaponEffect_Num:[StateArg1]%>. Dopo aver giocato la \"Difesa\" del portatore, ottieni <WeaponEffect_Num:[Counterattack:DescArg1]> accumuli di Contrattacco Temporaneo. Nelle Battaglie Boss, questo diventa 3 volte il Contrattacco Temporaneo. Dopo che si attiva la Resistenza, attiva [StateArg3]% di <RetaliateIconKeywords:Contrattacco> contro tutti i nemici."
  },
  State_3592_Desc = {
    Text = "Aumenta il danno del Tentacolo."
  },
  State_3592_Name = {
    Text = "<TentacleInjurieIconKeywords:Danno del Tentacolo>"
  },
  State_3592_WeaponDesc = {
    Text = "Aumenta la quantità di DAN inflitti dai Tentacoli."
  },
  State_3593_Desc = {
    Text = "Unico per Squadra: il <IntoxicationIconKeywords:Veleno> inflitto dal Portatore è aumentato del <WeaponEffect_Num:[StateArg1]%>. \"Colpo\" infligge DAN pari al <WeaponEffect_Num:[StateArg2]%> dell'ATT dell'attaccante come <IntoxicationIconKeywords:Veleno>. Questo effetto può attivarsi un massimo di 3 volte per turno."
  },
  State_3593_WeaponDesc = {
    Text = "Il <IntoxicationIconKeywords:Veleno> inflitto dal portatore è aumentato del <WeaponEffect_Num:[StateArg1]%>. \"Colpo\" infligge <WeaponEffect_Num:[Poison:DescArg1]> cariche di <IntoxicationIconKeywords:Veleno> al nemico bersaglio. Questo effetto può attivarsi un massimo di 3 volte per turno."
  },
  State_3596_Name = {
    Text = "Argento Residuo"
  },
  State_35970_Desc = {
    Text = "Dopo la morte, infliggi 1 turno di <VulnerabilityIconKeywords:Vulnerabile> alla tua squadra."
  },
  State_35970_Name = {
    Text = "Morte Prematura"
  },
  State_35971_Desc = {
    Text = "Ottiene uno Scudo del Personaggio pari al 50% dei PV massimi al momento della comparsa."
  },
  State_35971_Name = {
    Text = "Guscio d'Uovo"
  },
  State_3597_Name = {
    Text = "Argento Residuo"
  },
  State_3598_Name = {
    Text = "Argento Residuo"
  },
  State_3599_Desc = {
    Text = "Quando giochi una carta con un Costo di Arithmetica effettivo pari o superiore a 4, riduci di 1 il Costo di Arithmetica delle altre carte nella tua mano."
  },
  State_36006_Desc = {
    Text = "Alla morte, un \"Figlio del Sonno\" apparirà al suo posto."
  },
  State_36006_Name = {
    Text = "Incarnazione"
  },
  State_3600_Name = {
    Text = "Argento Residuo"
  },
  State_36013_Desc = {
    Text = "Questo stato conta anche come <SacrificeKeyWord:Sacrificio>, ottenendo [Layer] accumuli dello stato <SacrificeKeyWord:Sacrificio> all'inizio del prossimo turno."
  },
  State_36013_Name = {
    Text = "<BlueKeyWord:Sacrificio Ritardato>"
  },
  State_36014_Desc = {
    Text = "A fine turno, subisci [Layer] DAN e riduci le cariche di <SacrificeKeyWord:Sacrificio> del 50%."
  },
  State_36014_Name = {
    Text = "<BlueKeyWord:Sacrificio>"
  },
  State_3601_Name = {
    Text = "Stato@Chiave d'argento Fantasma: Conteggio Rotazione"
  },
  State_36022_Desc = {
    Text = "Quando subisci Danno da fonti diverse da <SacrificeKeyWord:Sacrificio>, ottieni il 50% del Danno come <SacrificeKeyWord:Sacrificio>."
  },
  State_36022_Name = {Text = "Tributo"},
  State_36023_Desc = {
    Text = "Alla morte, se sono presenti altri alleati, apparirà un \"Figlio dell'Acqua\"."
  },
  State_36023_Name = {
    Text = "Incarnazione"
  },
  State_36024_Desc = {
    Text = "Alla morte, se sono presenti altri alleati, verrà evocato un \"Figlio del Sonno\"."
  },
  State_36024_Name = {
    Text = "Incarnazione"
  },
  State_3603_Name = {
    Text = "Nelle Battaglie Boss, può essere utilizzata due volte e torna In Mano dopo il primo utilizzo."
  },
  State_3604_Desc = {
    Text = "Quando la squadra è composta da Risvegliati di professioni diverse, i PV della squadra e l'Attacco e la Difesa di tutti i Risvegliati aumentano del 200%."
  },
  State_3604_Name = {
    Text = "Stato @ Bonus Combinazione"
  },
  State_3604_WeaponDesc = {
    Text = "Quando la squadra è composta da Risvegliati di professioni diverse, i PV della squadra e l'Attacco e la Difesa di tutti i Risvegliati aumentano del 200%."
  },
  State_3607_Desc = {
    Text = "Conferisce al Risvegliato potenziamenti permanenti in combattimento. Utilizzi ripetuti di Incitamento non si accumulano."
  },
  State_3607_Name = {
    Text = "<ExaltIconKeywords:Risveglio>"
  },
  State_3607_WeaponDesc = {
    Text = "Dopo aver giocato Risveglio, il Risvegliatore ottiene un potenziamento speciale delle abilità in questa battaglia. Tuttavia, giocare Risveglio più volte non accumula l'effetto."
  },
  State_3608_Name = {
    Text = "Tutti gli alleati ottengono [StateArg1] Aliemus."
  },
  State_36092_Desc = {
    Text = "Alla morte, se sono presenti altri alleati, un \"Figlio dell'Acqua\" apparirà al suo posto."
  },
  State_36092_Name = {
    Text = "Incarnazione"
  },
  State_36093_Desc = {
    Text = "Per ogni 1 PV perso, riduci di 1 accumulo. Quando il numero di accumuli raggiunge 0, alla fine del turno del mostro, evoca 1 \"Figlio dell'Acqua\" e riacquisisci [DescArg1] accumuli di \"Ospite dell'Acqua\", con un massimo di 4 \"Figlio dell'Acqua\"."
  },
  State_36093_Name = {
    Text = "Ospite dell'Acqua"
  },
  State_36094_Desc = {
    Text = "Perdi 1 punto HP per ridurre 1 accumulo; quando il numero di accumuli è 0, evoca 1 \"Figlio dell'Incanto\" e riacquisisci [DescArg1] accumuli di \"Ospite del Corallo\", fino a un massimo di 4."
  },
  State_36094_Name = {
    Text = "Ospite del Senso Spirituale"
  },
  State_3609_Name = {
    Text = "Nella Battaglia Boss, può essere usata due volte e ritorna in mano dopo il primo utilizzo, con il Costo di Arithmetica ridotto di 1 per il resto del turno"
  },
  State_36111_Desc = {
    Text = "Alla morte, aggiungi 1 \"Iperplasia corallina\" alla tua mano."
  },
  State_36111_Name = {
    Text = "Iperplasia corallina"
  },
  State_3611_Desc = {
    Text = "Stato@Prologo Mostro Passiva 12"
  },
  State_3611_Name = {
    Text = "Stato@Prologo Mostro Passiva 12"
  },
  State_3611_WeaponDesc = {
    Text = "Stato@Prologo Mostro Passiva 12"
  },
  State_36124_Desc = {
    Text = "A fine turno, subisci [Layer] DAN e riduci gli accumuli di \"Sacrificio\" del 50%."
  },
  State_36124_Name = {
    Text = "<BlueKeyWord:Sacrificio>"
  },
  State_3612_Desc = {
    Text = "Stato@Prologo Mostro Passiva 13"
  },
  State_3612_Name = {
    Text = "Stato@Prologo Mostro Passiva 13"
  },
  State_3612_WeaponDesc = {
    Text = "Stato@Prologo Mostro Passiva 13"
  },
  State_36136_Name = {
    Text = "Mentre in mano, subisci [StateArg1] <FixedDamage:DAN Puro> per ogni altra carta giocata."
  },
  State_3613_Desc = {
    Text = "Stato@Prologo Mostro Passivo 10"
  },
  State_3613_Name = {
    Text = "Stato@Prologo Mostro Passivo 10"
  },
  State_3613_WeaponDesc = {
    Text = "Stato@Prologo Mostro Passivo 10"
  },
  State_3614_Desc = {
    Text = "Stato@Prologo Mostro Passiva 11"
  },
  State_3614_Name = {
    Text = "Stato@Prologo Mostro Passiva 11"
  },
  State_3614_WeaponDesc = {
    Text = "Stato@Prologo Mostro Passiva 11"
  },
  State_36152_Desc = {
    Text = "A fine turno, subisci danni pari al numero di accumuli, poi rimuovi il 50% degli accumuli di <SacrificeKeyWord:Sacrificio>. Il Sacrificio si mantiene nella battaglia successiva."
  },
  State_36152_Name = {
    Text = "<SacrificeKeyWord:Sacrificio>"
  },
  State_3615_Desc = {
    Text = "Stato @ Prologo Mostro Passiva 16"
  },
  State_3615_Name = {
    Text = "Stato @ Prologo Mostro Passiva 16"
  },
  State_3615_WeaponDesc = {
    Text = "Stato @ Prologo Mostro Passiva 16"
  },
  State_3616_Desc = {
    Text = "Stato@Prologo Mostro Passiva 14"
  },
  State_3616_Name = {
    Text = "Stato@Prologo Mostro Passiva 14"
  },
  State_3616_WeaponDesc = {
    Text = "Stato@Prologo Mostro Passiva 14"
  },
  State_36173_Name = {
    Text = "Utilizzabile [DescArg1] volte nelle Battaglia Boss."
  },
  State_36174_Name = {
    Text = "([Layer] volte rimanenti)"
  },
  State_3617_Desc = {
    Text = "Stato@Prologo Mostro Passiva 15"
  },
  State_3617_Name = {
    Text = "Stato@Prologo Mostro Passiva 15"
  },
  State_3617_WeaponDesc = {
    Text = "Stato@Prologo Mostro Passiva 15"
  },
  State_36182_Name = {
    Text = "Ottieni uno Scudo pari al [DescArg1]% (<Block:[DescArg2]>) degli HP massimi e ripristina la stessa quantità di HP; lo Scudo aumenta con gli HP persi."
  },
  State_3618_Desc = {
    Text = "Ottieni uno scudo quando subisci Danno effettivo."
  },
  State_3618_Name = {Text = "Riserva"},
  State_3618_WeaponDesc = {
    Text = "Ottieni uno scudo quando subisci Danno effettivo."
  },
  State_36196_Desc = {
    Text = "Il Danno di \"Colpo\" di Lotan è aumentato del 30%."
  },
  State_36196_Name = {
    Text = "Spade scatenate"
  },
  State_3619_Desc = {
    Text = "Stato @ Difesa Colpo Danzatrice Fiamma Blu"
  },
  State_3619_Name = {
    Text = "Stato @ Difesa Colpo Danzatrice Fiamma Blu"
  },
  State_3619_WeaponDesc = {
    Text = "Stato @ Difesa Colpo Danzatrice Fiamma Blu"
  },
  State_3620_Desc = {
    Text = "Ogni volta che sviluppi un Sintomo, aumenta i PV massimi di [Arg1]."
  },
  State_3621_Desc = {
    Text = "Per ogni carta giocata dal Discepolo Primordiale, pesca [StateArg1] carte e applica il 5% di Veleno a tutti i nemici."
  },
  State_3621_Name = {
    Text = "Ossessione Abissale"
  },
  State_3621_WeaponDesc = {
    Text = "Per ogni carta giocata dalla Devota Primordiale, pesca [StateArg1] carte."
  },
  State_3622_Desc = {
    Text = "Potenzia gli effetti delle abilità di \"Cacciatore di Teschi Impazzito\" e \"Il Defunto\", ottenendo [StateArg1] FOR temporanea all'inizio del turno e aumentando [StateArg1] per ogni carica di \"Marchio di Caccia\"."
  },
  State_3622_Name = {
    Text = "Marchio di Caccia"
  },
  State_36242_Desc = {
    Text = "All'inizio della battaglia, ottieni [StateArg1] Scudo del Personaggio. Dopo aver perso PV, il \"Sacro Infante\" si risveglierà dal suo sonno profondo e inizierà a piangere."
  },
  State_36242_Name = {
    Text = "Sonno Profondo"
  },
  State_3624_Desc = {
    Text = "Stato@Riduzione Potere Analisi Offensiva del Conoscitore"
  },
  State_3624_Name = {
    Text = "Stato@Riduzione Potere Analisi Offensiva del Conoscitore"
  },
  State_3625_Desc = {
    Text = "Quando possiedi uno Scudo del Personaggio, il danno inflitto aumenta di [Arg1]. Quando lo Scudo del Personaggio supera i tuoi PV attuali, il danno inflitto aumenta ulteriormente di [Arg2]."
  },
  State_36263_Desc = {
    Text = "Non subisce più Danno, si prepara a rilasciare \"Spora della Nascita\"."
  },
  State_36263_Name = {Text = "Immune"},
  State_3628_Name = {
    Text = "Stato@Rompi Difesa Dopo Giocata"
  },
  State_3629_Name = {
    Text = "Pesca 2 carte."
  },
  State_3630_Name = {
    Text = "Infliggi 2 accumuli di <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici"
  },
  State_36315_Desc = {
    Text = "Ottieni [Layer] FOR a fine turno."
  },
  State_36315_Name = {Text = "Benedetto"},
  State_3631_Name = {
    Text = "Ottieni 2 Arithmetica."
  },
  State_3632_Name = {
    Text = "Ottieni <Energy:[DescArg1]> Aliemus"
  },
  State_36332_Desc = {
    Text = "A inizio turno, scegli se ottenere 1 accumulo di Potere della Madre Divina o consumare Autorità Divina per ricevere l'aiuto di Murphy una volta."
  },
  State_36332_Name = {
    Text = "Potere della Madre Divina"
  },
  State_36334_Desc = {
    Text = "Ottieni 1 Tentacolo alla fine di ogni turno."
  },
  State_36334_Name = {
    Text = "Il Richiamo di Lemuria"
  },
  State_3633_Name = {
    Text = "Infliggi <WeaknessIconKeywords:Debolezza> a tutti i nemici per 2 accumuli"
  },
  State_36346_Desc = {
    Text = "Quando gli HP scendono a 0, vengono impostati a 1 punto, non subisce più Danno, si prepara a rilasciare \"Seme della Nascita\"."
  },
  State_36346_Name = {
    Text = "Spora della Nascita"
  },
  State_3634_Name = {
    Text = "Aggiungi 2 <DerivativeCardKeywords_4:\"Intuizione\"> al tuo Mazzo di pesca."
  },
  State_3635_Name = {
    Text = "Gli altri Risvegliatori ottengono <Energy:[DescArg1]> Aliemus"
  },
  State_36360_Desc = {
    Text = "A inizio turno, c'è una probabilità del [DescArg1]% di ottenere 1 accumulo di Raduno dei tentacoli. Se supera il 100%, è possibile ottenere accumuli multipli."
  },
  State_36360_Name = {
    Text = "Linea di ritorno"
  },
  State_36361_Desc = {
    Text = "Alla comparsa, gli altri alleati ottengono [Layer] FOR."
  },
  State_36361_Name = {
    Text = "Mutazione Divina"
  },
  State_3636_Desc = {
    Text = "Stato@Reliquia Campana Incantata Attiva"
  },
  State_3636_Name = {
    Text = "Stato@Reliquia Campana Incantata Attiva"
  },
  State_3637_Desc = {
    Text = "Quando i tuoi PV sono inferiori al 25% e non sei morto, recuperi istantaneamente [Arg1] PV. Permanentemente disabilitato dopo 3 attivazioni."
  },
  State_3637_Name = {
    Text = "☆Cibo d'emergenza☆"
  },
  State_3638_Desc = {
    Text = "Quando si subisce Danno attivo o Danni da tentacolo, diventa immune ai danni e perdi 1 accumulo."
  },
  State_3638_Name = {
    Text = "<ParcloseColour:Barriera>"
  },
  State_3638_WeaponDesc = {
    Text = "Danni subiti -99%. Ogni volta che si subiscono danni, perdi 1 accumulo."
  },
  State_3639_Desc = {
    Text = "Quando Ramona infligge DAN, ottiene [StateArg1] Arithmetica."
  },
  State_3639_Name = {
    Text = "La Terza Filosofia"
  },
  State_3639_WeaponDesc = {
    Text = "Quando Ramona infligge DAN, ottiene [StateArg1] Arithmetica."
  },
  State_3641_Desc = {
    Text = "Seleziona una carta al nodo \"Scultura di Cera Incompiuta\" per ridurne il Costo di Arithmetica di 1"
  },
  State_3641_Name = {
    Text = "Stato@Capitolo Due_Risonanza_Effetto Base"
  },
  State_3641_WeaponDesc = {
    Text = "Aumenta di +1 il livello delle carte copiate al nodo \"Scultura di Cera Incompiuta\""
  },
  State_3642_Desc = {
    Text = "Ogni volta che perdi HP, ottieni [Arg1] accumuli di Contatore. Se è la 3ª attivazione in un singolo turno, infliggi 1 istanza di DAN da Contatore a tutti i nemici."
  },
  State_3642_Name = {
    Text = "Crono del defunto"
  },
  State_3646_Desc = {
    Text = "I PV non possono scendere sotto 1. Quando si subiscono DAN letali, l'Intenzione cambia in Impasse Sopravvissuta. [Surviving Impasse]: Ripristina il 100% dei PV massimi, raddoppia la Forza e Potenzia le abilità successive."
  },
  State_3646_Name = {
    Text = "Impasse Sopravvissuta"
  },
  State_3647_Name = {
    Text = "Conteggio Arcana Reliquia"
  },
  State_3648_Desc = {
    Text = "Unico per Squadra: l'Effetto di Guarigione del Portatore è aumentato del <WeaponEffect_Num:[StateArg2]%>. A inizio turno, ottieni <PowerIconKeywords:FOR> Temporanea e Scudo del Personaggio pari al <WeaponEffect_Num:[StateArg1]%> dei PV persi nel turno precedente."
  },
  State_3648_WeaponDesc = {
    Text = "L'effetto di Recupero PV del portatore aumenta del <WeaponEffect_Num:[StateArg2]%>. All'inizio del turno, ottieni <PowerIconKeywords:FOR> Temporanea e Scudo pari al <WeaponEffect_Num:[StateArg1]%> dei PV persi nel turno precedente."
  },
  State_3649_Desc = {
    Text = "Per ogni Risvegliato di classe [Ultra] nella squadra, i PV Max (Non completo), la Difesa e l'Attacco dell'intera squadra aumentano del 50%."
  },
  State_3649_Name = {
    Text = "Ultra Bonus"
  },
  State_3649_WeaponDesc = {
    Text = "Per ogni Risvegliato di classe [Ultra] nella squadra, i PV Max (Non completo), la Difesa e l'Attacco dell'intera squadra aumentano del 50%."
  },
  State_3651_Desc = {
    Text = "Modifica l'Arithmetica della carta prima di giocarla"
  },
  State_3651_Name = {
    Text = "Modifica l'Arithmetica della carta prima di giocarla"
  },
  State_3651_WeaponDesc = {
    Text = "Modifica l'Arithmetica della carta prima di giocarla"
  },
  State_3652_Desc = {
    Text = "A inizio turno, se sono state giocate più di [StateArg1] carte nel turno precedente, pesca [StateArg2] carte."
  },
  State_3652_Name = {
    Text = "Reliquia Guanti Arcani"
  },
  State_3652_WeaponDesc = {
    Text = "A inizio turno, se sono state giocate più di [StateArg1] carte nel turno precedente, pesca [StateArg2] carte."
  },
  State_3653_Name = {
    Text = "Reliquia Vessillo di Battaglia Logoro 2"
  },
  State_3654_Desc = {
    Text = "Ottieni [Layer]% Tasso critico temporaneo a inizio turno."
  },
  State_3654_Name = {
    Text = "Melodia distante"
  },
  State_3654_WeaponDesc = {
    Text = "fino all'inizio del turno successivo senza perdere PV, Tasso Crit. +[StateArg1]%."
  },
  State_3656_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_3656_Name = {
    Text = "Non Risvegliato"
  },
  State_3658_Desc = {
    Text = "Quando giochi l'ultima carta nella tua mano, pesca 2 carte. Questo effetto può attivarsi fino a 2 volte per turno."
  },
  State_3659_Name = {
    Text = "Stato @ Aumento Tasso Critico e Danno Critico Carta Attacco"
  },
  State_36613_Name = {
    Text = "Stato@Accessorio Divinità Meccanica Contrattacco"
  },
  State_3661_Desc = {
    Text = "Aumenta gli accumuli di Dissoluzione Profonda quando si subisce Danno effettivo"
  },
  State_3661_Name = {
    Text = "Subire Danno aumenta le cariche di Dissoluzione."
  },
  State_3661_WeaponDesc = {
    Text = "Aumenta gli accumuli di Dissoluzione Profonda quando si subisce Danno effettivo"
  },
  State_3662_Desc = {
    Text = "Il Danno Crit. è aumentato del [Layer]% in questa battaglia."
  },
  State_3662_Name = {
    Text = "Danno critico"
  },
  State_3662_WeaponDesc = {
    Text = "Il Danno Crit. è aumentato del [Layer]% in questa battaglia."
  },
  State_36631_Desc = {
    Text = "Ogni volta che rilasci un'Esaltazione, ottieni 1 carica di \"Gestazione\". Per ogni carica di Gestazione, ottieni [StateArg1] Forza, fino a un massimo di 5 cariche."
  },
  State_36631_Name = {
    Text = "Ospite di Falsa Gravidanza"
  },
  State_36635_Desc = {
    Text = "Ogni volta che rilasci un'Esaltazione, ottieni 1 carica di \"Gestazione\". Per ogni carica di Gestazione, ottieni [StateArg1] Forza, fino a un massimo di 5 cariche."
  },
  State_36635_Name = {
    Text = "L'Ultima Discesa Divina di Lemuria"
  },
  State_36636_Desc = {
    Text = "Al raggiungimento di 5 accumuli, scatena \"Gloria di Lemuria!\", infliggendo DAN ingenti e richiamando la progenie."
  },
  State_36636_Name = {Text = "Nascita"},
  State_36637_Desc = {
    Text = "Al raggiungimento di 5 cariche, scatena \"Per Lemuria!\", infliggendo DAN massicci e evocando i consanguinei."
  },
  State_36637_Name = {Text = "Nascita"},
  State_3663_Desc = {
    Text = "Dopo aver giocato una carta per la prima volta ogni turno, inserisci un \"Colpo\" del Risvegliatore corrispondente nella mano."
  },
  State_3664_Desc = {
    Text = "Ottieni 5 Aliemus quando giocata."
  },
  State_3664_Name = {Text = "Memorie"},
  State_3664_WeaponDesc = {
    Text = "Ottieni 5 Aliemus quando giocata."
  },
  State_3665_Desc = {
    Text = "Quando la Fusione Embrionale raggiunge il limite, metti un \"Embrione\" nella tua mano."
  },
  State_3665_Name = {
    Text = "<EmbryoFusionIconKeywords:Fusione Embrionale>"
  },
  State_3666_Desc = {
    Text = "Tasso di Crit. aumentato del [Layer]%."
  },
  State_3666_Name = {
    Text = "Tasso di Crit."
  },
  State_3666_WeaponDesc = {
    Text = "Tasso di Crit. aumentato del [Layer]%."
  },
  State_36670_Name = {
    Text = "Stato @ Conteggio Ri-evoluzione Accessorio"
  },
  State_36670_WeaponDesc = {
    Text = "Ottieni 3 Aliemus alla fine del turno del portatore. Ottieni 2 Aliemus aggiuntivi se la Ricarica Aliemus del portatore è superiore a 10."
  },
  State_3667_Desc = {
    Text = "Unico per Squadra: Generazione di <RetaliateIconKeywords:Contrattacco> del portatore +<WeaponEffect_Num:[StateArg4]%>. Dopo aver giocato una carta, ottieni <WeaponEffect_Num:Contrattacco> pari a <RetaliateIconKeywords:[StateArg1]%> della DIF del portatore, fino a 2 volte per turno. Se la carta giocata entra nello Spazio Ultra, il portatore ottiene anche <WeaponEffect_Num:[StateArg2]> Aliemus. Dopo aver rilasciato Esaltazione, tutti i nemici perdono <WeaponEffect_Num:[StateArg3]%> FOR temporanea pari alla DIF del portatore."
  },
  State_3667_WeaponDesc = {
    Text = "Aumenta il <RetaliateIconKeywords:Contatore> inflitto dal Portatore di <WeaponEffect_Num:[StateArg4]%>. Dopo che il Portatore gioca una carta, ottiene <WeaponEffect_Num:[Counterattack:DescArg1]> <RetaliateIconKeywords:Contatore>, fino a 2 volte per turno. Se la carta giocata entra nello Spazio Ultra, ottiene anche <WeaponEffect_Num:[StateArg2]> Aliemus. Dopo l'Esaltazione, tutti i nemici perdono temporaneamente <WeaponEffect_Num:[Power:DescArg2]> Forza."
  },
  State_3668_Desc = {
    Text = "Stato@Distintivo del Guardiano del Giardino Alterato"
  },
  State_3668_Name = {
    Text = "Stato@Distintivo del Guardiano del Giardino Alterato"
  },
  State_3668_WeaponDesc = {
    Text = "Stato@Distintivo del Guardiano del Giardino Alterato"
  },
  State_3669_Desc = {
    Text = "Immunità alla Debolezza, Fragilità e stati di Vulnerabile per [Layer] turni."
  },
  State_3669_Name = {
    Text = "<BlessingColour:Benedizione>"
  },
  State_3669_WeaponDesc = {
    Text = "[Layer] Immune ai debuff applicati durante il turno."
  },
  State_36710_Name = {
    Text = "Danza della Luna Gibbosa"
  },
  State_3673_Desc = {
    Text = "Scegli 2 carte da eliminare al momento della raccolta, ottieni [StateArg1] Forza."
  },
  State_3673_Name = {
    Text = "Reliquia Brace della Stella Nera"
  },
  State_3674_Desc = {
    Text = "A fine turno, riduci di 10 l'Aliemus di tutti i Risvegliati."
  },
  State_3674_Name = {Text = "Oblio"},
  State_3674_WeaponDesc = {
    Text = "A fine turno, riduci di 10 l'Aliemus di tutti i Risvegliati."
  },
  State_3675_Name = {
    Text = "Pesca carte scartate +1 × carte"
  },
  State_3676_Desc = {
    Text = "Subisci [Layer]% di danni in meno durante il turno dell'avversario."
  },
  State_3676_Name = {Text = "Vigile"},
  State_3676_WeaponDesc = {
    Text = "I Mostri ottengono [Layer]% di riduzione dei DAN durante il turno della tua squadra."
  },
  State_3677_Desc = {
    Text = "Aumenta la DIF del [Layer]%."
  },
  State_3677_Name = {
    Text = "Aumento percentuale Difesa Temporaneo"
  },
  State_3677_WeaponDesc = {
    Text = "Aumenta la DIF del [Layer]%."
  },
  State_36781_Desc = {
    Text = "Quando la Forza viene ridotta, solo il 50% degli accumuli di Forza viene ridotto."
  },
  State_36781_Name = {
    Text = "Volontà di Incarnare la Brama"
  },
  State_3678_Name = {
    Text = "Stato@Reliquia Evento 1"
  },
  State_36797_Desc = {
    Text = "In questo turno, il Danno Tentacolo è ridotto di [Layer]."
  },
  State_36797_Name = {
    Text = "Riduzione danni da tentacolo"
  },
  State_3679_Name = {
    Text = "Stato@Reliquia Evento 2"
  },
  State_3680_Desc = {
    Text = "Applica [Arg1] cariche di Veleno per ogni colpo. Se attivato 25 volte durante questa battaglia, applica immediatamente Veleno a tutti i nemici."
  },
  State_3681_Desc = {
    Text = "Quando si infliggono danni non bloccati, lascia [DescArg1] accumuli di <BrokenCard:Sabotaggio> su 2 \"Carte di comando\" casuali."
  },
  State_3681_Name = {
    Text = "Jenkin Risveglio!"
  },
  State_3681_WeaponDesc = {
    Text = "A inizio del turno successivo, ottieni Scudo del Personaggio pari alla quantità di HP persi nel turno precedente."
  },
  State_3682_Desc = {
    Text = "Per ogni 10% di PV persi, tutti i Risvegliati ottengono 10 Aliemus e il danno da Tentacolo aumenta alla morte."
  },
  State_3682_Name = {
    Text = "Argento Sepolto"
  },
  State_3682_WeaponDesc = {
    Text = "Per ogni 10% di PV persi, tutti i Risvegliati ottengono 10 Aliemus e il danno da Tentacolo aumenta alla morte."
  },
  State_3683_Desc = {
    Text = "Unico per Squadra: la Guarigione causata dalla Carta di comando del Portatore è aumentata del <WeaponEffect_Num:[StateArg2]%>. Prima che il Portatore rilasci \"Esaltazione\", gli altri Risvegliati ottengono <WeaponEffect_Num:[StateArg1]> Aliemus. Se la tua squadra è in stato di <VulnerabilityIconKeywords:Vulnerabile>, l'effetto è raddoppiato."
  },
  State_3683_WeaponDesc = {
    Text = "La Guarigione dalla Carta di comando del portatore è aumentata di <WeaponEffect_Num:[StateArg2]%>. Prima che il portatore rilasci l'Esaltazione, gli altri Risvegliati ottengono <WeaponEffect_Num:[StateArg1]> Aliemus. Se la squadra è in stato di <VulnerabilityIconKeywords:Vulnerabile>, l'effetto è raddoppiato."
  },
  State_3684_Desc = {
    Text = "Ogni punto di Danno subito riduce un accumulo. A 0 accumuli, sostituisci l'intenzione con Fiore eterno e usa abilità incentrate sulla Difesa."
  },
  State_3684_Name = {
    Text = "Fiore eterno"
  },
  State_3684_WeaponDesc = {
    Text = "Perde 1 accumulo per ogni 1 danno subito. Passa alla modalità Difesa quando gli accumuli raggiungono 0."
  },
  State_3685_Desc = {
    Text = "Quando pescata, perdi 1 Arithmetica e pesca 1 carta."
  },
  State_3685_Name = {Text = "Confusione"},
  State_3685_WeaponDesc = {
    Text = "Quando pescata, perdi 1 Arithmetica e pesca 1 carta."
  },
  State_3686_Desc = {
    Text = "Quando pescata, perdi 1 Arithmetica e pesca 1 carta."
  },
  State_3686_Name = {
    Text = "Dimensione Sigillata"
  },
  State_3686_WeaponDesc = {
    Text = "Quando pescata, perdi 1 Arithmetica e pesca 1 carta."
  },
  State_36884_Desc = {
    Text = "L'ultimo voto in questa Battaglia non può più concedere uno Scudo tramite l'attivazione volontaria della Resistenza alla Morte."
  },
  State_36884_Name = {
    Text = "L'ultimo voto"
  },
  State_3688_Desc = {
    Text = "Quando giochi 2 carte con un Costo di Arithmetica superiore a quello della carta precedente, ottieni 2 Arithmetica."
  },
  State_3688_Name = {
    Text = "Reliquia Archivio Arcana"
  },
  State_3688_WeaponDesc = {
    Text = "Quando giochi 2 carte con un Costo di Arithmetica superiore a quello della carta precedente, ottieni 2 Arithmetica."
  },
  State_3689_Desc = {
    Text = "All'inizio del turno, aumenta la Padronanza del Reame di 30. Quando non si è sotto un debuff, la Padronanza del Reame aumenta di 100."
  },
  State_3692_Desc = {
    Text = "Carte misteriose dalle mille forme. Scegli quella di cui hai più bisogno!"
  },
  State_3692_Name = {
    Text = "<CardKeyWord:Mille miraggi>"
  },
  State_3692_WeaponDesc = {
    Text = "Carte misteriose dalle mille forme. Scegli quella di cui hai più bisogno!"
  },
  State_3693_Desc = {
    Text = "Tasso di crit. aumentato del 25%. Dopo aver ripristinato i PV, c'è una probabilità di ripristinare i PV un'ulteriore volta, con probabilità pari al tasso di crit. di chi cura."
  },
  State_3693_Name = {
    Text = "Stato@Chiave d'argento Fantasma: Cura Critica"
  },
  State_3696_Desc = {
    Text = "Ottieni [Arg1] Allerta per colpo in questo turno. Ottieni 1 Forza ogni 3 Scudo rimanente all'inizio del turno."
  },
  State_3696_Name = {
    Text = "Cronopendolo \"Occulto\""
  },
  State_3697_Desc = {
    Text = "Pesca 1 carta a inizio turno. Pesca 1 carta aggiuntiva se giochi 2 carte con lo stesso Costo di Arithmetica consecutivamente."
  },
  State_3698_Desc = {
    Text = "Quando giocata, aggiungi [StateArg1] copie negli slot Temporanei di <DimensionalSpaceIconKeywords:Spazio Ultra>."
  },
  State_3698_Name = {
    Text = "<Rune_13:Distorsione>"
  },
  State_3699_Name = {
    Text = "Argento Residuo"
  },
  State_3700_Desc = {
    Text = "Aumenta l'Attacco del [Layer]%"
  },
  State_3700_Name = {
    Text = "Aumento percentuale Attacco Temporaneo"
  },
  State_3700_WeaponDesc = {
    Text = "Aumenta l'Attacco del [Layer]%"
  },
  State_3702_Desc = {
    Text = "Stato @ Modifica Vita Massima Generica"
  },
  State_3702_Name = {
    Text = "Stato @ Modifica Vita Massima Generica"
  },
  State_3702_WeaponDesc = {
    Text = "Stato @ Modifica Vita Massima Generica"
  },
  State_3703_Name = {
    Text = "Stato@Capitolo 4 Risonanza@Pesca 2 carte il prossimo turno"
  },
  State_3704_Desc = {
    Text = "Padronanza del Reame aumentata di 30. Al momento della raccolta, scegli una Reliquia e sostituiscila con una casuale."
  },
  State_3705_Name = {
    Text = "Illuminazione Aequor 3"
  },
  State_3707_Desc = {
    Text = "All'inizio della battaglia, [StateArg1] copie di questa carta sono state mischiate nel Mazzo di Pesca. (Questa Orazione ha applicato <RetainIconKeywords:Conservare> alle carte.)"
  },
  State_3707_Name = {
    Text = "<Rune_8:Specchio>"
  },
  State_3708_Desc = {
    Text = "Alla fine dei turni pari, ottieni 1 Arithmetica per ogni carta rimanente all'inizio del turno successivo."
  },
  State_3708_Name = {
    Text = "Reliquia Frammento dei Saggi 2"
  },
  State_3708_WeaponDesc = {
    Text = "Alla fine dei turni pari, ottieni 1 Arithmetica per ogni carta rimanente all'inizio del turno successivo."
  },
  State_3709_Desc = {
    Text = "Alla fine dei turni dispari, ogni Arithmetica rimanente ti consente di pescare 1 carta aggiuntiva all'inizio del turno successivo."
  },
  State_3709_Name = {
    Text = "Reliquia Frammento dei Saggi 1"
  },
  State_3709_WeaponDesc = {
    Text = "Alla fine dei turni dispari, ogni Arithmetica rimanente ti consente di pescare 1 carta aggiuntiva all'inizio del turno successivo."
  },
  State_3711_Desc = {
    Text = "Ogni azione infligge [Layer] Salasso"
  },
  State_3711_Name = {
    Text = "Schizzo di Sangue"
  },
  State_3711_WeaponDesc = {
    Text = "Ogni azione infligge [Layer] Sanguinamento; la Guarigione dimezza gli accumuli di Sanguinamento."
  },
  State_3712_Desc = {
    Text = "Dopo aver giocato la carta, viene esaurita. Le Carte di comando forniscono Danno e difesa x3 per 1 turno."
  },
  State_3712_Name = {Text = "Dissolvere"},
  State_3714_Desc = {
    Text = "Quando giocata, ottieni <Block:[StateArg1]> Scudo del Personaggio."
  },
  State_3714_Name = {
    Text = "<Rune_6:Bastione>"
  },
  State_3716_Desc = {
    Text = "Tasso di Crit. aumentato del [Layer]% in questa battaglia."
  },
  State_3716_Name = {
    Text = "Tasso di Crit."
  },
  State_3719_Desc = {
    Text = "Per ogni istanza di Danno attivo subito, il Tentacolo contrattacca la fonte del danno una volta, per [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turni\">."
  },
  State_3719_Name = {
    Text = "Stirpe dell'Eresia"
  },
  State_3720_Desc = {
    Text = "Aumenta la DIF di [Layer]."
  },
  State_3720_Name = {
    Text = "Aumenta Difesa Generale"
  },
  State_3720_WeaponDesc = {
    Text = "Aumenta la DIF di [Layer]."
  },
  State_3721_Desc = {
    Text = "Dopo essere stata giocata, questa carta viene rimossa dal mazzo anziché entrare nella Pila degli scarti."
  },
  State_3721_Name = {
    Text = "Esaurimento"
  },
  State_3721_WeaponDesc = {
    Text = "Dopo essere stata giocata, la carta non finirà nella Pila degli scarti e non potrà essere usata di nuovo in questa Battaglia."
  },
  State_3722_Desc = {
    Text = "Aumenta temporaneamente il danno del Tentacolo di [StateArg1] quando si infliggono danni, accumulabile fino a 5 volte. Genera 1 Tentacolo quando completamente accumulato."
  },
  State_3722_Name = {
    Text = "Reliquia Bastone dell'Ierofante"
  },
  State_3722_WeaponDesc = {
    Text = "Aumenta temporaneamente il danno del Tentacolo di [StateArg1] quando si infliggono danni, accumulabile fino a 5 volte. Genera 1 Tentacolo quando completamente accumulato."
  },
  State_3723_Name = {
    Text = "Reliquia dello Specchio Nero"
  },
  State_3724_Desc = {
    Text = "Perdi tutte le altre reliquie al momento della raccolta. Ottieni casualmente 2 Reliquie Dorate."
  },
  State_3726_Name = {
    Text = "Tripudio di Carogne Contorte"
  },
  State_3728_Desc = {
    Text = "All'inizio della battaglia, ottieni una carta [Strike]."
  },
  State_3728_Name = {
    Text = "Illuminazione Salto della Balena 1"
  },
  State_3728_WeaponDesc = {
    Text = "All'inizio della battaglia, ottieni una carta [Strike]."
  },
  State_3730_Desc = {
    Text = "Stato@Demone della Dolcezza Tragedia Color Miele"
  },
  State_3730_Name = {
    Text = "Stato@Demone della Dolcezza Tragedia Color Miele"
  },
  State_3730_WeaponDesc = {
    Text = "Stato@Demone della Dolcezza Tragedia Color Miele"
  },
  State_3731_Desc = {
    Text = "Ogni volta che acquisti al Negozio D-Marchio, pesca 1 carta extra e ottieni 1 Arithmetica per turno durante la prossima battaglia."
  },
  State_3732_Desc = {
    Text = "Ogni 3 turni, ottieni 3 Tentacoli temporanei. Questi Tentacoli ignorano il Limite Tentacoli."
  },
  State_3732_Name = {
    Text = "Reliquia Appendice Senza Nome"
  },
  State_3732_WeaponDesc = {
    Text = "Ogni 3 turni, ottieni 3 Tentacoli temporanei. Questi Tentacoli ignorano il Limite Tentacoli."
  },
  State_3733_Desc = {
    Text = "Alla fine dei turni dispari, l'Arithmetica rimanente viene convertita in pescate extra per il turno successivo; alla fine dei turni pari, le carte rimanenti vengono convertite in Arithmetica extra per il turno successivo."
  },
  State_3735_Name = {
    Text = "Il numero di accumuli di \"Veleno\" nella tua squadra è ridotto della metà."
  },
  State_3738_Desc = {
    Text = "Alla fine del turno, Fusione Embrionale +15%. Se hai un \"Embrione\" in mano, ripristina [Arg1] PV."
  },
  State_3738_Name = {
    Text = "Registro della Pestilenza"
  },
  State_3739_Name = {
    Text = "Effetto Accessorio Forma Organica"
  },
  State_3739_WeaponDesc = {
    Text = "Dopo che il Portatore usa Esaltazione, il suo Scudo e il suo Pot. Guarigione vengono raddoppiati per questo turno."
  },
  State_3740_Name = {
    Text = "Stato@Conteggio Colpi Critici Dolce Demone"
  },
  State_3741_Desc = {
    Text = "All'inizio del turno 3, aggiungi 1 carta \"Echi del Passato—Scarta tutte le carte, ripristina HP attuali e Scudo allo stato della fine del turno precedente. Conserva, Esaurisci.\" alla tua mano."
  },
  State_3742_Desc = {
    Text = "Quando giocata, infliggi [StateArg1] turni di <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici."
  },
  State_3742_Name = {
    Text = "<Rune_1:Vulnerabile>"
  },
  State_3743_Desc = {
    Text = "Ogni 6ª carta che giochi avrà effetto due volte."
  },
  State_3743_Name = {
    Text = "Reliquia Birra Stellare+"
  },
  State_3744_Name = {
    Text = "Conteggio Reliquia Riflesso Rituale di Memphis"
  },
  State_3747_Name = {
    Text = "Scegli 1 carta dal Mazzo di Pesca e aggiungila alla tua mano."
  },
  State_3748_Name = {
    Text = "Aumenta il Tasso Crit. del [DescArg1]% e il Danno Crit. del [DescArg2]%"
  },
  State_3750_Name = {
    Text = "Tasso critico temporaneo +[DescArg1]%. In questa battaglia, il DAN Base di \"Mietitore di Teschi\" e \"Mille Miraggi\" è aumentato del 5%."
  },
  State_3751_Name = {
    Text = "Ottieni [StateArg1] <PowerIconKeywords:FOR>"
  },
  State_3752_Name = {
    Text = "Ottieni <Posse:[DescArg1]> Keyflare. Ottieni <Block:[Block:StateArg1]> Scudo."
  },
  State_3753_Desc = {
    Text = "La carta non entra nella Pila degli scarti, ma rimane In Mano."
  },
  State_3753_Name = {
    Text = "<RetainIconKeywords:Conservare>"
  },
  State_3753_WeaponDesc = {
    Text = "La carta non entra nella Pila degli scarti, ma rimane In Mano."
  },
  State_3754_Desc = {
    Text = "Quando infliggi Danno attivo, aumenta il Danno del Tentacolo di [Arg1] per questo turno, accumulabile fino a 3 volte. Genera 1 Tentacolo quando completamente accumulato, che verrà rimosso a fine turno."
  },
  State_3755_Desc = {
    Text = "Unico per Squadra: Generazione Scudo del Portatore +<WeaponEffect_Num:[StateArg1]%>, e Recupero PV +<WeaponEffect_Num:[StateArg1]%>. Alla fine dei turni dispari, il Tasso Crit. del Portatore +<WeaponEffect_Num:[StateArg2]%>, ottenendo <WeaponEffect_Num:[StateArg3]> Aliemus; alla fine dei turni pari, il Danno Crit. del Portatore aumenta del <WeaponEffect_Num:[StateArg2]%>, ottenendo <WeaponEffect_Num:[StateArg4]> Keyflare. Se il reame attuale è \"Caro\", l'accumulo massimo della Fornace Cremisi è aumentato del <WeaponEffect_Num:[StateArg5]%>."
  },
  State_3755_WeaponDesc = {
    Text = "La Generazione Scudo del Portatore aumenta del <WeaponEffect_Num:[StateArg1]%>, e il Recupero PV aumenta del <WeaponEffect_Num:[StateArg1]%>. Alla fine dei turni dispari, il Tasso Crit. del Portatore +<WeaponEffect_Num:[StateArg2]%>, ottenendo <WeaponEffect_Num:[StateArg3]> Aliemus; alla fine dei turni pari, il Danno Crit. del Portatore aumenta del <WeaponEffect_Num:[StateArg2]%>, ottenendo <WeaponEffect_Num:[StateArg4]> Keyflare. Se il reame attuale è \"Caro\", il limite della Fornace Cremisi è aumentato del <WeaponEffect_Num:[StateArg5]%>."
  },
  State_3757_Desc = {
    Text = "La tua squadra ottiene [StateArg1] cariche di Scudo per ogni carta giocata. Dura 1 turno."
  },
  State_3757_Name = {
    Text = "Bufera di Piume"
  },
  State_3757_WeaponDesc = {
    Text = "La tua squadra ottiene [StateArg1] cariche di Scudo per ogni carta giocata. Dura 1 turno."
  },
  State_3759_Name = {Text = "Mecha 1"},
  State_3760_Desc = {
    Text = "Se possiedi almeno [StateArg1] Sigilli Neri, [Exalt] consuma [StateArg1] Sigilli Neri e rende tutti i nemici Vulnerabili e in stato di Debolezza per 1 turno."
  },
  State_3760_Name = {
    Text = "Reliquia Uccello Rituale del Presagio"
  },
  State_3760_WeaponDesc = {
    Text = "Se possiedi almeno [StateArg1] Sigilli Neri, [Exalt] consuma [StateArg1] Sigilli Neri e rende tutti i nemici Vulnerabili e in stato di Debolezza per 1 turno."
  },
  State_3761_Desc = {
    Text = "Ogni volta che la tua squadra pesca 1 Barcollamento, ottieni [Layer] FOR."
  },
  State_3761_Name = {
    Text = "Cerimonia della Lanterna"
  },
  State_3761_WeaponDesc = {
    Text = "Ogni volta che la tua squadra pesca 1 Barcollamento, ottieni [Layer] FOR."
  },
  State_3763_Desc = {
    Text = "Per ogni colpo inferto dallo Skulker in questo turno, il Danno Crit. aumenta del [StateArg3]%."
  },
  State_3763_Name = {
    Text = "Varco Dimensionale"
  },
  State_3763_WeaponDesc = {
    Text = "Per ogni colpo inferto dallo Skulker in questo turno, il Danno Crit. aumenta del [StateArg3]%."
  },
  State_3764_Name = {Text = "Mecha 2"},
  State_3766_Name = {
    Text = "Aggiungi Moltiplicatore Forza Scarlatta"
  },
  State_3767_Desc = {
    Text = "A inizio turno, infliggi [Arg1] DAN a un nemico casuale. Dopo aver giocato \"Colpo\" 7 volte in questa battaglia, i DAN inflitti diventeranno [Arg2]."
  },
  State_3767_Name = {
    Text = "Puzzle Antico"
  },
  State_3768_Desc = {
    Text = "Il Danno attivo subito sarà sicuramente un colpo critico e verrà rimosso alla fine del turno."
  },
  State_3768_Name = {Text = "Cedimento"},
  State_3768_WeaponDesc = {
    Text = "Il Danno attivo subito sarà sicuramente un colpo critico e verrà rimosso alla fine del turno."
  },
  State_3770_Name = {
    Text = "Conteggio Arcana Reliquia"
  },
  State_3771_Desc = {
    Text = "All'inizio della battaglia, ottieni 3 Arithmetica."
  },
  State_3772_Desc = {
    Text = "Per ogni colpo, Lama della Vendetta ottiene FOR temporanea pari al Danno del Tentacolo attuale."
  },
  State_3772_Name = {
    Text = "Vendetta Preventiva"
  },
  State_3773_Desc = {
    Text = "Al termine del turno, subisci <FixedDamage:DAN Puro> pari al numero di accumuli."
  },
  State_3773_Name = {
    Text = "<IntoxicationIconKeywords:Veleno>"
  },
  State_3773_WeaponDesc = {
    Text = "Subisci danni a inizio turno."
  },
  State_3774_Desc = {
    Text = "Ottieni 1 \"Infusione Tossica\" che può applicare [Arg1] Veleno al rilascio di Exaslt. A fine turno, per ogni 3 carte \"Infusione Tossica\" In Mano, sintetizza 1 \"Esplosione Tossica\" che attiva il Veleno."
  },
  State_3776_Desc = {
    Text = "Ogni volta che subisci Danno attivo, ottieni una carica di \"Vigilanza\". Ritirati quando \"Vigilanza\" raggiunge 3 cariche."
  },
  State_3776_Name = {
    Text = "Bambola Timida"
  },
  State_3776_WeaponDesc = {
    Text = "Ogni volta che subisci Danno attivo, ottieni una carica di \"Vigilanza\". Ritirati quando \"Vigilanza\" raggiunge 3 cariche."
  },
  State_3777_Desc = {
    Text = "Quando giocata, aumenta l'Aliemus di questo Risvegliato di <Energy:[StateArg1]>."
  },
  State_3777_Name = {
    Text = "<Rune_5_High:Furia Avanzata>"
  },
  State_3777_WeaponDesc = {
    Text = "Quando giocata, aumenta l'Aliemus di questo Risvegliato di <Energy:[StateArg1]>."
  },
  State_3778_Desc = {
    Text = "Infliggi il 25% di Danno in più ai nemici con debuff e ottieni 20 Aliemus uccidendoli."
  },
  State_3779_Desc = {
    Text = "Limite Tentacoli ridotto di 2. A fine turno, tutti i Tentacoli attaccano ancora una volta."
  },
  State_3779_Name = {
    Text = "Reliquia Agonia Sacra"
  },
  State_3779_WeaponDesc = {
    Text = "Riduci il Limite Tentacoli di 2. Alla fine di ogni turno, tutti i Tentacoli effettuano un attacco aggiuntivo."
  },
  State_3781_Desc = {
    Text = "A inizio turno, applica \"Maledizione Stagnante\" alle prime 2 carte del mazzo."
  },
  State_3781_Name = {
    Text = "\"Occhio Maledetto dell'Abisso\""
  },
  State_3781_WeaponDesc = {
    Text = "A inizio turno, applica \"Maledizione Stagnante\" alle prime 2 carte del mazzo."
  },
  State_3782_Desc = {
    Text = "Unico per Squadra: All'inizio dell'esplorazione, aggiungi una \"Difesa\" del Portatore al mazzo, aumentando lo Scudo della \"Difesa\" del Portatore del <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3782_WeaponDesc = {
    Text = "All'inizio dell'esplorazione, aggiungi una carta \"Difesa\" al mazzo. Lo Scudo della \"Difesa\" del Portatore è aumentato del <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3783_Desc = {
    Text = "Unico per Squadra: Aumenta il DAN Exalt base del Portatore del <WeaponEffect_Num:[StateArg1]%>, e aumenta Scudo e Recupero PV del <WeaponEffect_Num:[StateArg2]%>."
  },
  State_3783_WeaponDesc = {
    Text = "Aumenta i DAN Base Esaltazione del Portatore del <WeaponEffect_Num:[StateArg1]%>. Aumenta la Generazione di Scudo e il Recupero PV del <WeaponEffect_Num:[StateArg2]%>."
  },
  State_3784_Desc = {
    Text = "Unico per Squadra: Aumenta il DAN Base della Carta di comando del Portatore del <WeaponEffect_Num:[StateArg1]%>, e aumenta Scudo e Recupero PV del <WeaponEffect_Num:[StateArg2]%>."
  },
  State_3784_WeaponDesc = {
    Text = "I DAN Base della Carta di comando del Portatore sono aumentati del <WeaponEffect_Num:[StateArg1]%>, e lo Scudo/Recupero PV è aumentato del <WeaponEffect_Num:[StateArg2]%.>"
  },
  State_3786_Desc = {
    Text = "Sei il bersaglio! Dopo averla giocata, tutti i mostri ottengono [StateArg1] FOR temporanea, e il Marchio dell'Abisso di questo comando viene rimosso."
  },
  State_3786_Name = {
    Text = "<CardKeyWord:Marchio dell'Abisso>"
  },
  State_3786_WeaponDesc = {
    Text = "Dopo aver giocato la carta, il Sommozzatore Profondo ottiene [StateArg1] FOR temporanea."
  },
  State_3787_Desc = {
    Text = "Unico per Squadra: Dopo che il Portatore attiva Exalt, tutti gli alleati ottengono <WeaponEffect_Num:[StateArg1]> Aliemus."
  },
  State_3787_WeaponDesc = {
    Text = "Dopo che il portatore rilascia Esaltazione, tutti gli alleati ottengono <WeaponEffect_Num:[StateArg1]> Aliemus."
  },
  State_3788_Desc = {
    Text = "Unico per Squadra: All'inizio dell'esplorazione, aggiungi un \"Colpo\" del Portatore al mazzo, aumentando il DAN Base del \"Colpo\" del Portatore del <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3788_WeaponDesc = {
    Text = "All'inizio dell'esplorazione, aggiungi una carta \"Colpo\" al mazzo e aumenta il DAN Base di \"Colpo\" del portatore di <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3790_Desc = {
    Text = "Stato@Conteggio Sostanza Indeterminata"
  },
  State_3790_Name = {
    Text = "Stato@Conteggio Sostanza Indeterminata"
  },
  State_3790_WeaponDesc = {
    Text = "Stato@Conteggio Sostanza Indeterminata"
  },
  State_3791_Desc = {
    Text = "Ogni volta che vengono inflitti DAN, ottieni [Arg1] Scudo del Personaggio, cumulabile fino a 5 volte per turno. Quando completamente cumulato, colloca una carta \"Intuizione\" nella mano."
  },
  State_3792_Desc = {
    Text = "Non più soggetto a Pietrificare."
  },
  State_3792_Name = {
    Text = "Resistenza alla Pietrificazione"
  },
  State_3792_WeaponDesc = {
    Text = "Non più pietrificato, ora subisce il triplo del Danno"
  },
  State_3793_Desc = {
    Text = "Il Danno Crit. è aumentato del [Layer]% in questo livello."
  },
  State_3793_Name = {
    Text = "DAN da Colpo Crit. Permanente"
  },
  State_3793_WeaponDesc = {
    Text = "Il Danno Crit. è aumentato del [Layer]% in questo livello."
  },
  State_3794_Desc = {
    Text = "Danno, Scudo del Personaggio e Guarigione del Portatore +[StateArg1]%. (Temporaneo)"
  },
  State_3794_Name = {
    Text = "Stato@Prototipo Spadone Danno Critico"
  },
  State_3796_Desc = {
    Text = "I PV diminuiscono del 20%, tutti i Risvegliati ottengono 10 Aliemus, aggiunge danno da Tentacolo alla morte"
  },
  State_3796_Name = {
    Text = "Granuli d'Argento Estratti"
  },
  State_3796_WeaponDesc = {
    Text = "I PV diminuiscono del 20%, tutti i Risvegliati ottengono 10 Aliemus, aggiunge danno da Tentacolo alla morte"
  },
  State_3797_Desc = {
    Text = "Ottieni [StateArg1] FOR temporanea per danno subito, rimossa a inizio turno."
  },
  State_3797_Name = {
    Text = "Ira dello Sciame di Ratti!"
  },
  State_37980_Desc = {
    Text = "Padronanza del Reame aumentata di [Layer] in questa battaglia."
  },
  State_37980_Name = {
    Text = "Padronanza del Reame"
  },
  State_3798_Desc = {
    Text = "Ripristina PV dopo aver inflitto Danno effettivo."
  },
  State_3798_Name = {
    Text = "Lama Vampirica"
  },
  State_3798_WeaponDesc = {
    Text = "Ripristina PV dopo aver inflitto Danno effettivo."
  },
  State_3799_Desc = {
    Text = "Per ogni Risvegliato di classe [Caro] nella squadra, i PV Max (Non completo), la Difesa e l'Attacco dell'intera squadra aumentano del 50%."
  },
  State_3799_Name = {Text = "Bonus Caro"},
  State_3799_WeaponDesc = {
    Text = "Per ogni Risvegliato di classe [Caro] nella squadra, i PV Max (Non completo), la Difesa e l'Attacco dell'intera squadra aumentano del 50%."
  },
  State_3800_Desc = {
    Text = "Infliggi Danno a tutti i nemici. <CardKeyWord:Forza> potenzia questo Danno più volte."
  },
  State_3800_Name = {
    Text = "<CardKeyWord:Dominio della Lama>"
  },
  State_3801_Desc = {
    Text = "Aggiunge [StateArg1] accumuli di Salasso quando si infliggono DAN non bloccati."
  },
  State_3801_Name = {Text = "Salasso"},
  State_3802_Desc = {
    Text = "Finché è In Mano, ogni Carta di Comando utilizzata diventa una copia con 0 Arithmetica."
  },
  State_3802_Name = {
    Text = "<CardKeyWord:Rampollo della Purezza>"
  },
  State_3802_WeaponDesc = {
    Text = "Mentre è In Mano, l'uso di ogni carta crea una copia con 0 Arithmetica."
  },
  State_3803_Desc = {
    Text = "All'inizio della battaglia, tutte le carte con un Costo di Arithmetica attuale pari a 1 ottengono +[Arg1] Danno, Scudo e Guarigione per questa battaglia."
  },
  State_3804_Desc = {
    Text = "Conteggio Tridente Mutato"
  },
  State_3804_Name = {
    Text = "Conteggio Tridente Mutato"
  },
  State_3804_WeaponDesc = {
    Text = "Conteggio Tridente Mutato"
  },
  State_3807_Name = {
    Text = "Sogno di Medicina dagli Accessori"
  },
  State_3807_WeaponDesc = {
    Text = "All'inizio della battaglia, mischia un set aggiuntivo delle carte del Portatore nel Mazzo di Pesca."
  },
  State_3808_Desc = {
    Text = "Stato@CambiaVitaCorrente"
  },
  State_3808_Name = {
    Text = "Stato@CambiaVitaCorrente"
  },
  State_3808_WeaponDesc = {
    Text = "Stato@CambiaVitaCorrente"
  },
  State_3810_Desc = {
    Text = "Dopo la morte, la Forza degli altri alleati aumenta."
  },
  State_3810_Name = {
    Text = "Sussurro della Morte"
  },
  State_3811_Desc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_4_1"
  },
  State_3811_Name = {
    Text = "Stato@Prologo Reset Mazzo 0_1_4_1"
  },
  State_3811_WeaponDesc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_4_1"
  },
  State_3813_Name = {
    Text = "Immunità alla Debolezza"
  },
  State_3815_Desc = {
    Text = "A fine turno, tutti i Risvegliatori perdono [Layer] Aliemus."
  },
  State_3815_Name = {
    Text = "<EnergyColour:Vuoto>"
  },
  State_3815_WeaponDesc = {
    Text = "Ottenimento: Aliemus ridotto del [Layer]%."
  },
  State_3817_Desc = {
    Text = "All'inizio del turno, infliggi [DescArg1] Esaurimento all'avversario."
  },
  State_3817_Name = {
    Text = "Dissipazione"
  },
  State_3817_WeaponDesc = {
    Text = "A inizio turno, la tua squadra ottiene [DescArg1*Layer*0.01] cariche di Risucchio."
  },
  State_3818_Name = {
    Text = "Stato@Illuminato dal Saggio 1"
  },
  State_3819_Name = {
    Text = "Spezzacatene Illuminazione 1"
  },
  State_3819_WeaponDesc = {
    Text = "Imitatore Antico"
  },
  State_3821_Desc = {
    Text = "A inizio turno, ottieni uno Scudo del Personaggio pari alla metà dei PV persi nel turno precedente."
  },
  State_3821_Name = {
    Text = "Dolore e Piacere"
  },
  State_3821_WeaponDesc = {
    Text = "A inizio del turno successivo, ottieni Scudo del Personaggio pari alla quantità di HP persi nel turno precedente."
  },
  State_3824_Desc = {
    Text = [[
Unico di squadra: Danno base dell'Esaltazione +[StateArg1]%. All'inizio dell'esplorazione, il portatore entra nella Persona dello Studioso. Usare l'Esaltazione alterna il portatore tra le Persona dello Studioso e del Giullare.
Studioso: Ottieni <WeaponEffect_Num:[StateArg2]> Aliemus a fine turno.
Giullare: Tasso critico e Danno critico +<WeaponEffect_Num:[StateArg3]%> a fine turno.]]
  },
  State_3824_WeaponDesc = {
    Text = [[
Danno base dell'Esaltazione del portatore +[StateArg1]%. All'inizio dell'esplorazione, il portatore entra nella Persona dello Studioso. Dopo aver eseguito un'Esaltazione, il portatore alterna tra le Persona dello Studioso e del Giullare.
Studioso: A fine turno, il portatore ottiene <WeaponEffect_Num:[StateArg2]> Aliemus.
Giullare: A fine turno, il Tasso critico e il Danno critico del portatore aumentano di <WeaponEffect_Num:+[StateArg3]%>.]]
  },
  State_3825_Desc = {
    Text = "Quando si subisce Danno attivo, infliggi <FixedDamage:DAN Puro> alla Fonte del Danno pari al numero di accumuli."
  },
  State_3825_Name = {
    Text = "<RetaliateIconKeywords:Contatore>"
  },
  State_3825_WeaponDesc = {
    Text = "Ogni volta che si subisce Danno attivo, infliggi <FixedDamage:DAN Puro> all'attaccante."
  },
  State_3826_Name = {
    Text = "Stato@Chiave d'argento fantasma: Conteggio Detonazione"
  },
  State_3827_Desc = {
    Text = "Unico per Squadra: Aumenta il Recupero PV del Portatore del <WeaponEffect_Num:[StateArg1]%>. Dopo aver rilasciato l'Esaltazione, recupera il <WeaponEffect_Num:[StateArg2]%> degli HP persi all'inizio del turno successivo."
  },
  State_3827_WeaponDesc = {
    Text = "Aumenta la rigenerazione degli HP del Portatore del <WeaponEffect_Num:[StateArg1]%>. Dopo l'Esaltazione, recupera il <WeaponEffect_Num:[DescArg1]%> degli HP persi all'inizio del turno successivo."
  },
  State_3830_Name = {
    Text = "Si attiva 1 volta aggiuntiva"
  },
  State_3831_Name = {
    Text = "Radice Inversa della Reliquia"
  },
  State_3834_Desc = {
    Text = "Il Danno da Veleno inflitto dal Ragno del Labirinto è raddoppiato."
  },
  State_3834_Name = {
    Text = "Sentiero degli Smarriti"
  },
  State_3835_Desc = {
    Text = "Il Danno Crit. è aumentato del [Layer]% in questo turno."
  },
  State_3835_Name = {
    Text = "Danno critico temporaneo"
  },
  State_3835_WeaponDesc = {
    Text = "Il Danno Crit. è aumentato del [Layer]% in questo turno."
  },
  State_3836_Desc = {Text = "Test 123"},
  State_3836_Name = {Text = "Test 123"},
  State_3837_Desc = {
    Text = "Unicità di Squadra: L'Aliemus generato dal portatore +<WeaponEffect_Num:[StateArg1]%>, e il <IntoxicationIconKeywords:Veleno> inflitto dal portatore +<WeaponEffect_Num:[StateArg2]%>.\nDopo che il portatore infligge un Danno attivo, tutti i Risvegliatori ottengono DAN CRIT temporanei pari al <WeaponEffect_Num:[StateArg3]%> del DAN crit. base del portatore.\nSe il Reame include Aequor, il Limite dei Tentacoli +1 e viene generato 1 Tentacolo all'inizio della battaglia."
  },
  State_3837_WeaponDesc = {
    Text = [[
L'Aliemus generato dal portatore +<WeaponEffect_Num:[StateArg1]%>, e il <IntoxicationIconKeywords:Veleno> inflitto dal portatore +<WeaponEffect_Num:[StateArg2]%>.
Dopo che il portatore infligge un Danno attivo, i DAN CRIT temporanei di tutti i Risvegliatori +<WeaponEffect_Num:[DescArg1]%>.
Se il Reame include Aequor, il Limite dei Tentacoli +1 e viene generato 1 Tentacolo all'inizio della battaglia.]]
  },
  State_3839_Desc = {
    Text = "All'inizio della battaglia, ottieni [Arg1] Forza per ogni Carta sintomo nel tuo mazzo. Tutte le tue Carte sintomo ottengono Fugace."
  },
  State_3840_Desc = {
    Text = "Ogni volta che i PV diminuiscono, ottiene [StateArg1] Allerta."
  },
  State_3840_Name = {Text = "Vigilanza"},
  State_3842_Desc = {
    Text = "Tutti i Danni attivi e Danni da tentacolo inflitti -[DescArg1]%."
  },
  State_3842_Name = {Text = "Debolezza"},
  State_3842_WeaponDesc = {
    Text = "Riduce tutti i danni inflitti del [DescArg1]%."
  },
  State_3843_Desc = {
    Text = "Ogni azione applica [Layer] Sanguinamento."
  },
  State_3843_Name = {
    Text = "Ferita Grave"
  },
  State_3843_WeaponDesc = {
    Text = "Ogni azione aggiunge [Layer] Sanguinamento; la Guarigione può rimuovere l'Effetto Sanguinamento."
  },
  State_3844_Desc = {
    Text = "Tutti i Danni da Salto di Balzo della Balena +1."
  },
  State_3844_Name = {
    Text = "Sete di Battaglia"
  },
  State_3844_WeaponDesc = {
    Text = "Tutti i Danni da Salto di Balzo della Balena +1."
  },
  State_3845_Desc = {
    Text = "Arithmetica Carta-"
  },
  State_3845_Name = {
    Text = "Arithmetica Carta-"
  },
  State_3845_WeaponDesc = {
    Text = "Arithmetica Carta-"
  },
  State_3846_Name = {
    Text = "Reliquia Impronta di Giada"
  },
  State_3848_Desc = {
    Text = "In questa battaglia, l'Esaltazione di un Risvegliato casuale viene sigillata e non può essere utilizzata."
  },
  State_3848_Name = {Text = "Sigillato"},
  State_3850_Desc = {
    Text = "Ogni volta che giochi la [StateArg1]ª carta, aumenta il danno del Tentacolo di [StateArg2] e fai attaccare tutti i Tentacoli una volta."
  },
  State_3850_Name = {
    Text = "Tridente Mutato"
  },
  State_3850_WeaponDesc = {
    Text = "Ogni volta che giochi la [StateArg1]ª carta, aumenta il danno del Tentacolo di [StateArg2] e fai attaccare tutti i Tentacoli una volta."
  },
  State_3851_Name = {
    Text = "Accessorio Gatto del Teatro"
  },
  State_3851_WeaponDesc = {
    Text = "Tutti i DAN inflitti +10% dei PV Max del Portatore."
  },
  State_3852_Desc = {
    Text = "Aumenta il numero di istanze di danno di Morso di [Layer]."
  },
  State_3852_Name = {
    Text = "Morsi Crescenti"
  },
  State_3852_WeaponDesc = {
    Text = "Aumenta il numero di istanze di danno di Morso di [Layer]."
  },
  State_3853_Desc = {
    Text = "All'inizio del turno, si trasforma casualmente in una copia di una Carta di comando nel Mazzo di Pesca, con un Costo di Arithmetica fisso di 3. Ritorna alla forma originale a fine turno."
  },
  State_3853_Name = {
    Text = "<CardKeyWord:Delirium>"
  },
  State_3853_WeaponDesc = {
    Text = "La carta non entra nella Pila degli scarti, ma rimane In Mano."
  },
  State_3854_Desc = {
    Text = "Pesca 2 carte, ma questo attirerà l'attenzione del Cacciatore di Teschi."
  },
  State_3854_Name = {
    Text = "<CardKeyWord:Braccato>"
  },
  State_3855_Name = {Text = "Forza"},
  State_3856_Desc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_3_1"
  },
  State_3856_Name = {
    Text = "Stato@Prologo Reset Mazzo 0_1_3_1"
  },
  State_3856_WeaponDesc = {
    Text = "Stato@Prologo Reset Mazzo 0_1_3_1"
  },
  State_3859_Desc = {
    Text = "L'Aliemus fornito dal Soffio di Fertilità è raddoppiato."
  },
  State_3859_Name = {
    Text = "Ad Matrem Vocatus"
  },
  State_3859_WeaponDesc = {
    Text = "L'Aliemus fornito dal Soffio di Fertilità è raddoppiato."
  },
  State_3860_Desc = {
    Text = "Danno, Scudo del Personaggio e Guarigione del Portatore +[StateArg1]%. (Temporaneo)"
  },
  State_3860_Name = {
    Text = "Stato@Prototipo Pugnale Fortuna"
  },
  State_3862_Name = {
    Text = "Stato@Level2_15Battle4Bubble1"
  },
  State_3863_Desc = {
    Text = "Dopo aver rilasciato Esaltazione 3 volte, riduci il Costo di Arithmetica di tutte le carte In Mano di 1."
  },
  State_3866_Desc = {
    Text = "Durante questo turno, il limite di carte in mano è aumentato di [Layer]."
  },
  State_3866_Name = {
    Text = "Limite di Mano+"
  },
  State_3867_Name = {
    Text = "Contrattacco Classe Ultra"
  },
  State_3868_Desc = {
    Text = "La generazione di Scudo del Personaggio è aumentata di [Layer] in questo turno."
  },
  State_3868_Name = {
    Text = "Allerta temporanea"
  },
  State_3868_WeaponDesc = {
    Text = "La generazione di Scudo del Personaggio è aumentata di [Layer] in questo turno."
  },
  State_3872_Desc = {
    Text = "Subire DAN annulla la FOR temporanea."
  },
  State_3872_Name = {Text = "Cedimento"},
  State_38730_Desc = {
    Text = "A inizio turno, c'è una probabilità del [DescArg1]% di ottenere 1 accumulo di Raduno dei tentacoli. Se supera il 100%, è possibile ottenere accumuli multipli."
  },
  State_38730_Name = {
    Text = "Linea di ritorno"
  },
  State_38735_Desc = {
    Text = "Danno attivo inflitto -[StateArg1]%, raddoppia il numero di attacchi, e dura per [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turni\">."
  },
  State_38735_Name = {Text = "Deliri"},
  State_38738_Desc = {
    Text = "Massimo 10 accumuli, si trasferiscono alla Battaglia successiva."
  },
  State_38738_Name = {
    Text = "Esca Onirica"
  },
  State_3873_Desc = {
    Text = "Padronanza del Reame aumentata di [Layer] in questa battaglia."
  },
  State_3873_Name = {
    Text = "Padronanza del Reame"
  },
  State_3874_Name = {
    Text = "Stato@Ripristino Carta Campana del Vento"
  },
  State_3876_Desc = {
    Text = "Riduce la Forza della squadra ogni turno pari."
  },
  State_3876_Name = {
    Text = "\"Fossa del Sogno Morente\""
  },
  State_3878_Desc = {
    Text = "Per ogni 2 PV persi, ottieni [Layer] Scudo all'inizio del turno successivo."
  },
  State_3878_Name = {
    Text = "Dolore e Piacere"
  },
  State_3878_WeaponDesc = {
    Text = "A inizio del turno successivo, ottieni Scudo del Personaggio pari alla quantità di HP persi nel turno precedente."
  },
  State_3879_Desc = {
    Text = "I PV massimi aumentano di [Arg1] quando raccolto. Se i PV sono sotto il 25% quando raccolto, l'aumento dei PV massimi diventa [Arg2]."
  },
  State_3881_Desc = {
    Text = "Stato@Mostro George divora servitore scultura di cera"
  },
  State_3881_Name = {
    Text = "Stato@Mostro George divora servitore scultura di cera"
  },
  State_3881_WeaponDesc = {
    Text = "Stato@Mostro George divora servitore scultura di cera"
  },
  State_3882_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_3882_Name = {
    Text = "Non Risvegliato"
  },
  State_3883_Desc = {
    Text = "Tasso di Crit. + [Layer]% in questo livello."
  },
  State_3883_Name = {
    Text = "Tasso di Crit. Permanente"
  },
  State_3883_WeaponDesc = {
    Text = "Tasso di Crit. + [Layer]% in questo livello."
  },
  State_3884_Desc = {
    Text = "Genera 1 Fusione Embrionale aggiuntiva ogni turno. Tutti i tuoi Effetti divoranti diventano Divorazione Infinita."
  },
  State_3884_Name = {
    Text = "Reliquia Cordone Strisciante"
  },
  State_3884_WeaponDesc = {
    Text = "Genera 1 Fusione Embrionale aggiuntiva ogni turno. Tutti i tuoi Effetti divoranti diventano Divorazione Infinita."
  },
  State_3888_Desc = {
    Text = "Impossibile scatenare l'Esaltazione; rimuovi 1 accumulo a fine turno."
  },
  State_3888_Name = {
    Text = "<CardKeyWord:Sigillato>"
  },
  State_3888_WeaponDesc = {
    Text = "L'Esaltazione di tutti i Risvegliati è inutilizzabile."
  },
  State_3890_Name = {
    Text = "Pesca un numero di Scarti +[DescArg1] × carte"
  },
  State_3893_Desc = {
    Text = "Ottieni [Arg1] Scudo del Personaggio quando infliggi Danno. Ottieni [Arg2] FOR temporanea quando guarisci PV."
  },
  State_3893_Name = {
    Text = "La Nostra Casa"
  },
  State_3894_Desc = {
    Text = "Prima della fase di scarto, trasforma le carte in mano in pietre."
  },
  State_3894_Name = {
    Text = "Pietrificazione"
  },
  State_3894_WeaponDesc = {
    Text = "Prima della fase di scarto, trasforma le carte in mano in pietre."
  },
  State_3895_Desc = {
    Text = "Tasso di Crit. aumentato del [Layer]% in questo turno."
  },
  State_3895_Name = {
    Text = "Tasso critico temporaneo"
  },
  State_3895_WeaponDesc = {
    Text = "Tasso di Crit. aumentato del [Layer]% in questo turno."
  },
  State_3898_Desc = {
    Text = "Ottieni [Layer] Scudo del Personaggio all'inizio del prossimo turno."
  },
  State_3898_Name = {
    Text = "Scudo di Dolore e Piacere"
  },
  State_3900_Name = {
    Text = "La carta è sigillata e non può essere giocata. Scartala per rimuovere il sigillo."
  },
  State_3901_Name = {
    Text = "Conteggio Reliquia Bastone del Sacerdote"
  },
  State_3902_Desc = {
    Text = "In questo turno, il Danno attivo inflitto è ridotto di [Layer]."
  },
  State_3902_Name = {Text = "FOR▼"},
  State_3902_WeaponDesc = {
    Text = "I DAN inflitti in questo turno sono ridotti di [Layer]."
  },
  State_3904_Desc = {
    Text = "Per ogni punto di HP persi, rimuovi 1 accumulo; quando gli accumuli raggiungono 0, ottieni [StateArg1] Scudo del Personaggio e riacquisisci [StateArg2] accumuli di Barriera di Sangue."
  },
  State_3904_Name = {
    Text = "Risveglio - Barriera di Sangue"
  },
  State_3905_Desc = {
    Text = "Ogni volta che si subisce un Danno attivo, infliggi [Layer] <FixedDamage:DAN Puro> alla fonte del danno."
  },
  State_3905_Name = {Text = "Contatore"},
  State_3905_WeaponDesc = {
    Text = "Ogni volta che si subisce un Danno attivo, infliggi [Layer] <FixedDamage:DAN Puro> all'Attaccante."
  },
  State_3906_Name = {
    Text = "Argento Residuo"
  },
  State_3907_Name = {
    Text = "Argento Residuo"
  },
  State_3908_Desc = {
    Text = "Quando Cervello in una Vasca applica guarigione, pesca [Arg2] carte."
  },
  State_3908_Name = {
    Text = "Dualità delle Illusioni"
  },
  State_3908_WeaponDesc = {
    Text = "Quando Cervello in una Vasca applica guarigione, pesca [Arg2] carte."
  },
  State_3909_Name = {
    Text = "Argento Residuo"
  },
  State_3910_Name = {
    Text = "Argento Residuo"
  },
  State_3911_Name = {
    Text = "Argento Residuo"
  },
  State_3912_Name = {
    Text = "Argento Residuo"
  },
  State_3913_Desc = {
    Text = "Unico per Squadra: Generazione Scudo del Personaggio del Portatore +<WeaponEffect_Num:[StateArg1]%>. A inizio turno, conserva il <WeaponEffect_Num:[StateArg2]%> dello Scudo del Personaggio rimanente, fino al <WeaponEffect_Num:[StateArg3]%> dei PV massimi."
  },
  State_3913_WeaponDesc = {
    Text = "Generazione Scudo del Personaggio del Portatore +<WeaponEffect_Num:[StateArg1]%>. A inizio turno, conserva il <WeaponEffect_Num:[StateArg2]%> dello Scudo del Personaggio rimanente, fino al <WeaponEffect_Num:[StateArg3]%> dei PV massimi."
  },
  State_3914_Desc = {
    Text = "Dopo aver rilasciato la 2ª Esaltazione ogni turno, tutti i Risvegliati ottengono 10 Aliemus. Dopo aver rilasciato la 3ª Esaltazione ogni turno, il tempo di ricarica dell'Aliemus di tutti i Risvegliati viene azzerato e vengono concessi ulteriori 10 Aliemus."
  },
  State_3915_Name = {
    Text = "Argento Residuo"
  },
  State_3916_Name = {
    Text = "Argento Residuo"
  },
  State_3917_Desc = {
    Text = "Ottieni FOR temporanea al prossimo turno"
  },
  State_3917_Name = {Text = "Carica"},
  State_3918_Desc = {
    Text = "Ottieni lo Stato che raddoppia il primo Danno subito all'inizio di ogni turno."
  },
  State_3918_Name = {Text = "Arroganza"},
  State_3918_WeaponDesc = {
    Text = "Ottieni lo Stato che raddoppia il primo Danno subito all'inizio di ogni turno."
  },
  State_3921_Desc = {
    Text = "In questo turno, la carta non entra nella Pila degli scarti, ma rimane In Mano."
  },
  State_3921_Name = {
    Text = "<RetainIconKeywords:Conservare>"
  },
  State_3921_WeaponDesc = {
    Text = "La carta non entra nella Pila degli scarti, ma rimane In Mano."
  },
  State_3923_Desc = {
    Text = "Arithmetica Carta-"
  },
  State_3923_Name = {
    Text = "Riduzione Permanente Arithmetica Carta"
  },
  State_3923_WeaponDesc = {
    Text = "Arithmetica Carta-"
  },
  State_3925_Name = {
    Text = "Stato@Capitolo 4 Risonanza@Inizio Nostro Turno Arithmetica 2"
  },
  State_3926_Desc = {
    Text = "\"Festino dei Morti Contorti\" aumenta il Danno di [Layer]."
  },
  State_3926_Name = {
    Text = "Distorsione"
  },
  State_3926_WeaponDesc = {
    Text = "Aumenta il Danno da \"Mania\"."
  },
  State_3927_Desc = {
    Text = "Dopo aver pescato \"Vuoto\", l'Aliemus ottenuto da tutti i Risvegli è ridotto del [Layer]% in questo turno."
  },
  State_3927_Name = {Text = "Vuoto"},
  State_3927_WeaponDesc = {
    Text = "Dopo aver pescato \"Vuoto\", l'Aliemus ottenuto da tutti i Risvegli è ridotto del [Layer]% in questo turno."
  },
  State_3928_Desc = {
    Text = "Quando Dolce Demone infligge Danno, ottieni [StateArg2] Contatore."
  },
  State_3928_Name = {
    Text = "Dare e Avere"
  },
  State_3929_Desc = {
    Text = "Ottieni il 50% in meno di Forza e Scudo del Personaggio, e rimuovi 1 accumulo a fine turno."
  },
  State_3929_Name = {
    Text = "<CardKeyWord:Maledizione>"
  },
  State_3929_WeaponDesc = {
    Text = "Immune ai potenziamenti positivi applicati a sé in questo turno"
  },
  State_3930_Name = {
    Text = "Stato@Capitolo 4 Risonanza@Inizio Nostro Turno Arithmetica 1"
  },
  State_3931_Name = {
    Text = "Stato@Inno del Sangue Cremisi e della Sabbia"
  },
  State_3932_Desc = {
    Text = "Conferisce alla carta Conserva. Ogni carica di Maledizione Stagnante aumenta il costo della carta di 1. Rimuove la Maledizione Stagnante dopo averla giocata."
  },
  State_3932_Name = {
    Text = "Maledizione Stagnante ([Layer])"
  },
  State_3932_WeaponDesc = {
    Text = "Conferisce alla carta Conserva. Ogni carica di Maledizione Stagnante aumenta il costo della carta di 1. Rimuove la Maledizione Stagnante dopo averla giocata."
  },
  State_3933_Desc = {
    Text = "Aumenta la DIF di [Layer]."
  },
  State_3933_Name = {
    Text = "Aumento Difesa Temporaneo"
  },
  State_3933_WeaponDesc = {
    Text = "Aumenta la DIF di [Layer]."
  },
  State_3934_Desc = {
    Text = "Tutti gli Scudi del Personaggio ottenuti sono ridotti del 50%."
  },
  State_3934_Name = {
    Text = "Oblio Fragile"
  },
  State_3934_WeaponDesc = {
    Text = "Tutti gli Scudi del Personaggio ottenuti sono ridotti del 50%."
  },
  State_3935_Desc = {
    Text = "Ogni volta che la tua squadra usa una carta, ottieni 1 accumulo di \"Osservazione\". Al raggiungimento di 10 accumuli, vieni stordito."
  },
  State_3935_Name = {
    Text = "Osservazione"
  },
  State_3936_Desc = {
    Text = "Danno, Scudo del Personaggio e Guarigione del Portatore +[StateArg1]%. (Temporaneo)"
  },
  State_3936_Name = {
    Text = "Stato@Proto Spadone Reame"
  },
  State_3937_Desc = {
    Text = "Quando la Regina delle Spine esegue un contrattacco, ottiene uno Scudo del Personaggio pari alla metà dei DAN del contrattacco."
  },
  State_3937_Name = {
    Text = "Muro di Cadaveri"
  },
  State_3938_Name = {
    Text = "Crea Scultura di Cera"
  },
  State_3941_Desc = {
    Text = "Quando divora un Embrione, ritorna dalla Pila degli scarti al mazzo in mano."
  },
  State_3941_Name = {
    Text = "Spirale Incolore"
  },
  State_3941_WeaponDesc = {
    Text = "Quando divora un Embrione, ritorna dalla Pila degli scarti al mazzo in mano."
  },
  State_3942_Name = {
    Text = "Accessorio Linea di ritorno"
  },
  State_3942_WeaponDesc = {
    Text = "A inizio Battaglia, se il Portatore è di classe Aequor, aumenta l'ATT del 25%."
  },
  State_3943_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_3943_Name = {
    Text = "Non Risvegliato"
  },
  State_3944_Desc = {
    Text = "Al termine del turno, tutti i Risvegliati ottengono 5 Aliemus. Per ogni Arithmetica rimanente, tutti i Risvegliati ottengono 3 Aliemus aggiuntivi."
  },
  State_3945_Desc = {
    Text = "Tutti i prezzi delle Reliquie ridotti del 50%."
  },
  State_39547_Desc = {
    Text = "Dopo la battaglia, ottieni 5 Sigilli Neri extra. Questo effetto è potenziato dal Bottino di Sigilli. Dopo che Wanda gioca una carta, ottieni 1 accumulo di Dreamlead. Questo effetto può attivarsi fino a 2 volte per turno. Attualmente, [DescArg1] volte rimanenti."
  },
  State_39547_Name = {
    Text = "Venere e Pelliccia"
  },
  State_40483_Name = {
    Text = "Alabarda Infranta"
  },
  State_40484_Desc = {
    Text = "Quando l'abilità di Wanda attiva l'effetto Balzo e sono presenti 5 accumuli, consuma 5 accumuli per conferire un effetto aggiuntivo. Il limite per Esca Onirica è di 10 accumuli, che verranno trasferiti alla battaglia successiva."
  },
  State_40484_Name = {
    Text = "<PurpleKeyWord:Esca Onirica>"
  },
  State_41337_Desc = {
    Text = "Recupera [Layer] HP a fine turno."
  },
  State_41337_Name = {
    Text = "Vittoria della Rosa: Guarigione"
  },
  State_41340_Desc = {
    Text = "Unico per Squadra: Aumenta Scudo e Contatore del Portatore del <WeaponEffect_Num:[StateArg1]%>. Quando subisce un attacco, c'è una probabilità del <WeaponEffect_Num:[StateArg2]%> che tutti i Risvegliati ottengano 1 Aliemus."
  },
  State_41340_WeaponDesc = {
    Text = "Aumenta la Generazione di Scudo e il Contatore del portatore del <WeaponEffect_Num:[StateArg1]%>. Ogni volta che viene attaccato, c'è una probabilità del <WeaponEffect_Num:[StateArg2]%> che tutti i Risvegliati ottengano 1 Aliemus."
  },
  State_41342_Name = {
    Text = "Effetti Variabili"
  },
  State_41344_Name = {
    Text = "Effetti Variabili"
  },
  State_41360_Desc = {
    Text = "Consuma 5 pile di <DreamGuide:Esca Onirica>, Wanda ottiene <Energy:[StateArg1]> Aliemus e guadagna <RetaliateIconKeywords:Contatore> Temporaneo pari al [StateArg2]% del <RetaliateIconKeywords:Contatore> Permanente."
  },
  State_41360_Name = {
    Text = "Contrattacco del Sopore"
  },
  State_41361_Desc = {
    Text = "Esaurisci 10 accumuli di <DreamGuide:Esca Onirica>, facendo entrare tutti i nemici nello stato \"Mormorio\" per 1 turno: Danno attivo inflitto -[StateArg3]%, ma il numero di attacchi raddoppia."
  },
  State_41361_Name = {
    Text = "Echi di Deliri"
  },
  State_43818_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_43818_Name = {
    Text = "Non Risvegliato"
  },
  State_44398_Desc = {
    Text = "Dopo aver giocato una carta per la prima volta ogni turno, inserisci una \"Difesa\" del Risvegliatore corrispondente nella mano."
  },
  State_44484_Name = {
    Text = "Può essere usato 3 volte nelle battaglie boss."
  },
  State_44485_Name = {
    Text = "(Rimanenti:[Layer])"
  },
  State_44491_Name = {
    Text = "Effetto Disabilitato"
  },
  State_44562_Name = {
    Text = "Effetto Disabilitato"
  },
  State_44575_Desc = {
    Text = "Lo Scudo del Personaggio rimanente in questo turno non verrà rimosso e verrà conservato per il turno successivo."
  },
  State_44575_Name = {
    Text = "Mantenimento Scudo"
  },
  State_44653_Desc = {
    Text = "Tutti i Risvegli ottengono 20 Aliemus a inizio turno. I PV massimi sono ridotti del 50% al momento della raccolta."
  },
  State_44665_Desc = {
    Text = "In questo turno, il Tasso di Critico di \"Colpo\" aumenta del [Layer]%."
  },
  State_44665_Name = {
    Text = "Tasso di Crit. Colpo"
  },
  State_44667_Desc = {
    Text = "\"Colpo\" ottiene [DescArg1] Arithmetica. Se la posizione attuale è \"Impeto\", non si ottiene Arithmetica, ma 1 Tentacolo riceve il comando di attaccare [DescArg2] volte."
  },
  State_44667_Name = {
    Text = "Regno del Gigante"
  },
  State_44671_Desc = {
    Text = "Tutti i Risvegli ottengono 25 Aliemus a inizio turno. PV massimi x3 al momento della raccolta."
  },
  State_44672_Name = {
    Text = "Benedetto: Mente dello Sciame"
  },
  State_44711_Desc = {
    Text = "Capacità Reliquie +5, +1 Aggiornamento in [D-Mark]. Dopo la Battaglia, ottieni 125 Sigilli Neri. Quando raccolto, puoi scegliere di Distruggere fino a 6 Carte sintomo."
  },
  State_44713_Desc = {
    Text = "Dopo la Battaglia, ottieni 100 Sigilli Neri aggiuntivi, ma sviluppi 2 Sintomi casuali."
  },
  State_44730_Desc = {
    Text = "All'inizio del turno, accumula <Heal:[Heal:StateArg1]> guarigione dalla Fornace Cremisi."
  },
  State_44730_Name = {
    Text = "Elargizione della Salvezza"
  },
  State_44731_Desc = {
    Text = "Combatti il dolore con il dolore. Consuma tutta la Guarigione residua della Fornace Cremisi, ogni 1 punto consumato aumenta il Danno di 3 punti; in una Battaglia Boss, aumenta invece di 9 punti per ogni punto consumato. Ogni 1% di Salute massima consumata dalla Fornace Cremisi aumenta il Danno Finale di [DescArg1]%."
  },
  State_44731_Name = {
    Text = "Liberazione"
  },
  State_44732_Desc = {
    Text = "Guarisci col sangue. Dopo aver inflitto Danno, perdi il 10% dei PV attuali e accumuli una quantità equivalente di Guarigione nella Fornace Cremisi."
  },
  State_44732_Name = {Text = "Dedizione"},
  State_44739_Desc = {
    Text = "Perdi permanentemente [Arg1] Forza al momento della raccolta. Cura [Arg2] HP ogni volta che infliggi Danno, fino a 6 volte per turno."
  },
  State_44739_Name = {
    Text = "Peccaminoso: Bacio della Lampreda"
  },
  State_44740_Name = {
    Text = "Benedetto: Bacio di Lampreda"
  },
  State_44741_Desc = {
    Text = "Perdi permanentemente [Arg1] Forza al momento della raccolta. Cura [Arg2] HP ogni volta che infliggi Danno, fino a 6 volte per turno."
  },
  State_44741_Name = {
    Text = "Peccaminoso: Bacio della Lampreda"
  },
  State_44742_Desc = {
    Text = "Perdi permanentemente [Arg1] Forza al momento della raccolta. Cura [Arg2] HP ogni volta che infliggi Danno, fino a 6 volte per turno."
  },
  State_44742_Name = {
    Text = "Benedetto: Bacio di Lampreda"
  },
  State_44743_WeaponDesc = {
    Text = "All'inizio della battaglia, diventa Vulnerabile per 3 turni."
  },
  State_44744_WeaponDesc = {
    Text = "All'inizio della battaglia, diventa Vulnerabile per 3 turni."
  },
  State_44750_Desc = {
    Text = "A inizio turno, ottieni [StateArg1] Arithmetica."
  },
  State_44750_Name = {
    Text = "Reliquia Candela nera 1"
  },
  State_44751_Desc = {
    Text = "A inizio turno, ottieni [StateArg1] Arithmetica."
  },
  State_44751_Name = {
    Text = "Reliquia Candela nera 1"
  },
  State_44752_Desc = {
    Text = "Ogni volta che \"Sophia\" perde 1 punto PV, perde 1 carica; quando il numero di cariche raggiunge 0, sostituisce l'Intenzione con \"Occhio per Occhio\" e ottiene [StateArg2] Scudo. La prima attivazione ripristinerà tutte le cariche."
  },
  State_44752_Name = {
    Text = "Impulso Sepolto"
  },
  State_44762_Desc = {
    Text = "Quando giochi \"Difesa\", mischia 1 ferita nel Mazzo di Pesca."
  },
  State_44762_Name = {
    Text = "Lacerazione"
  },
  State_44763_Desc = {
    Text = "Il Danno Crit. di tutti i Risvegliatori è dimezzato."
  },
  State_44763_Name = {
    Text = "<PurpleKeyWord:Cecità>"
  },
  State_44764_Desc = {
    Text = "Quando giochi \"Colpo\", mischia 1 carta Ferita nel tuo Mazzo di Pesca."
  },
  State_44764_Name = {Text = "Trauma"},
  State_44807_Desc = {
    Text = "Quando sta per essere sconfitto per la prima volta, recupera HP e cambia Intenzione in \"Giudizio dello Specchio\", potenziando sé stesso. Quando sta per essere sconfitto per la seconda volta, recupera HP e cambia Intenzione in \"Morso della Follia\", infliggendo Danni singoli estremamente elevati."
  },
  State_44807_Name = {
    Text = "Massacro Sepolto"
  },
  State_44819_Desc = {
    Text = "Se non c'è una <ParcloseIconKeywords:Barriera>, ottieni una pila Temporanea di <ParcloseIconKeywords:Barriera>. Altrimenti, ottieni il 10% di Tasso Crit. e Danno Crit."
  },
  State_44819_Name = {
    Text = "<CardKeyWord:Protezione del Padre Supremo>"
  },
  State_44828_Desc = {
    Text = "Unicità di Squadra: Al termine del turno, il portatore ottiene [StateArg1] Aliemus. Quando si subiscono Danni Attivi e da Tentacolo, ottieni uno Scudo pari al <WeaponEffect_Num:[StateArg2]%> del danno all'inizio del turno successivo. Se il Reame attuale è Caro, ottieni invece Fornace Cremisi pari al <WeaponEffect_Num:[StateArg2]%> del danno."
  },
  State_44828_WeaponDesc = {
    Text = "Al termine del turno, il portatore ottiene <WeaponEffect_Num:[StateArg1]> Aliemus. Quando si subiscono Danni Attivi o da Tentacolo, ottieni uno Scudo pari al <WeaponEffect_Num:[Float:StateArg2]%> del danno all'inizio del turno successivo. Se il Reame attuale è Caro, ottieni invece Fornace Cremisi pari al <WeaponEffect_Num:[Float:StateArg2]%> del danno."
  },
  State_44889_Name = {
    Text = "Stato@Cane dal Volto Umano BOSS@Riflesso della Fine 1"
  },
  State_44890_Name = {
    Text = "Stato@Uomo Segugio BOSS@Riflesso della Fine 2"
  },
  State_44891_Name = {
    Text = "Stato@Segugio BOSS@Riflesso della Fine 3"
  },
  State_44903_Desc = {
    Text = "Quando si subisce un Danno attivo o Danni da tentacolo, il [StateArg1]% del danno verrà convertito nell'importo di recupero per la Fornace Cremisi, per [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turni\">."
  },
  State_44903_Name = {
    Text = "Colui che protegge"
  },
  State_44909_Name = {
    Text = "Esaurimento"
  },
  State_45018_Desc = {
    Text = "Non puoi usare \"Colpo\" prima della fine del turno."
  },
  State_45018_Name = {Text = "Paralisi"},
  State_45025_Desc = {
    Text = "Per gli effetti specifici, consulta la logica base di Colpo."
  },
  State_45029_Desc = {
    Text = "Per gli effetti specifici, consulta la logica base di Colpo."
  },
  State_45032_Desc = {
    Text = "Alla fine del prossimo turno, subisci [Layer] Danno."
  },
  State_45032_Name = {
    Text = "Sanguinamento"
  },
  State_45039_Desc = {
    Text = "Fino all'inizio del turno successivo, ogni volta che si subisce Danno attivo o Danni da tentacolo, ottieni uno Scudo pari a [Layer]% del danno all'inizio del turno successivo."
  },
  State_45039_Name = {
    Text = "Alba del Miracolo"
  },
  State_45040_Desc = {
    Text = "Fino all'inizio del turno successivo, ogni volta che si subisce Danno attivo o Danni da tentacolo, accumula [Layer]% del danno come cura per la Fornace Cremisi."
  },
  State_45040_Name = {
    Text = "Alba del Miracolo"
  },
  State_45049_Desc = {
    Text = "Nega il Danno del prossimo attacco attivo (fino a 3 accumuli). Ogni accumulo di Lotta Mortale riduce gli accumuli massimi di Barriera di 1, ma non rimuove le Barriere già ottenute."
  },
  State_45049_Name = {Text = "Barriera"},
  State_45050_Desc = {
    Text = "Nega il Danno del prossimo attacco attivo (fino a 3 accumuli). Ogni accumulo di Lotta Mortale riduce gli accumuli massimi di Barriera di 1, ma non rimuove le Barriere già ottenute."
  },
  State_45050_Name = {
    Text = "<ReinforceColour:Barriera>"
  },
  State_45064_Name = {
    Text = "Contrattacco del Banchetto Silenzioso__\"For Development Use Only\""
  },
  State_45069_Desc = {
    Text = "Per gli effetti specifici, consulta la logica base di Colpo."
  },
  State_45072_Name = {
    Text = "Conteggio Santificazione"
  },
  State_45073_Desc = {
    Text = "Arithmetica Carta-"
  },
  State_45076_Desc = {
    Text = "Quando applicato, dissolve lo Scudo del Personaggio e la Cura Ritardata sul bersaglio. Riduce gli effetti di Guarigione e Scudo del Personaggio ricevuti del 50% fino a fine turno"
  },
  State_45076_Name = {Text = "Flagello"},
  State_45137_Desc = {
    Text = "Dopo aver usato Esaltazione, sigilla tutti i Risvegliatori per un turno e ottieni Vulnerabile per un turno."
  },
  State_45137_Name = {
    Text = "Peccato Originale: Resti del Viandante"
  },
  State_45139_Desc = {
    Text = "Dopo aver usato Esaltazione, dissolvi casualmente 1 debuff."
  },
  State_45139_Name = {
    Text = "Benedetto: Resti del Viandante"
  },
  State_45148_Desc = {
    Text = "Il Danno Crit. di tutti i Risvegliatori è dimezzato."
  },
  State_45148_Name = {
    Text = "<PurpleKeyWord:Cecità>"
  },
  State_45166_Desc = {
    Text = "Ruota del destino disabilitata fino alla fine del turno."
  },
  State_45166_Name = {
    Text = "Intrecciati"
  },
  State_45206_Desc = {
    Text = "Redenzione attraverso la fede. Consuma tutta la rigenerazione residua della Fornace Cremisi per ottenere uno Scudo pari al 150% dell'ammontare consumato. Questo Scudo non è influenzato da bonus o debuff allo Scudo e ignora i limiti dello Scudo."
  },
  State_45206_Name = {Text = "Redenzione"},
  State_45248_Name = {Text = "Contatore"},
  State_45328_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo l'\"Esaltazione\", conferisci a se stesso <TauntKeywords:Scherno> e <Block:[Block:StateArg1]> Scudo del Personaggio."
  },
  State_45328_Name = {
    Text = "Magia del 35mm"
  },
  State_45329_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: \"Colpo\" può selezionare un bersaglio. Prima di ogni \"Colpo\", <PVPRepelKeywords:Respinta> tutti i potenziamenti dissolubili del bersaglio al Risvegliato dietro di lui."
  },
  State_45329_Name = {
    Text = "Chiamata del Mare Profondo"
  },
  State_45331_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: All'equipaggiamento e dopo il \"Colpo\", le \"Abilità\" Non-Derivate del Portatore In Mano cambieranno sequenzialmente nelle altre \"Abilità\" [ShowIfState:, <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]."
  },
  State_45331_Name = {
    Text = "Fiori e Poesie d'un Tempo"
  },
  State_45332_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Ogni volta che il Portatore subisce Danno attivo, gli altri alleati ottengono <Energy:[Energy:StateArg1]> Aliemus."
  },
  State_45332_Name = {
    Text = "Lo Sguardo di Isarawu"
  },
  State_45333_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Limite di carte in mano +[StateArg1]. Dopo l'\"Esaltazione\", ottieni <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_45333_Name = {
    Text = "Bacio d'Addio"
  },
  State_45334_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del Destino>: \"Abilità\" cambia il prossimo \"Colpo\" di questo turno per colpire bersagli casuali e attacca inoltre [StateArg1] bersagli casuali aggiuntivi."
  },
  State_45334_Name = {
    Text = "Uomo nello specchio"
  },
  State_45345_Desc = {
    Text = "Utilizzato per registrare il numero di volte in cui l'Abilità fertilità della Fase 1 è stata usata"
  },
  State_45345_Name = {
    Text = "Marchio di Fertilità 1"
  },
  State_45346_Desc = {
    Text = "Utilizzato per registrare il numero di volte in cui l'Abilità Fertilità della Fase 2 è stata usata"
  },
  State_45346_Name = {
    Text = "Marchio di Fertilità 2"
  },
  State_45354_Desc = {
    Text = "Questa carta non può essere giocata."
  },
  State_45354_Name = {
    Text = "Non Giocabile"
  },
  State_45356_Desc = {
    Text = "A fine turno, si trasforma nell'ultima carta \"Abilità\" giocata con Costo di Arithmetica -2. Dopo averla giocata, \"Verità Dietro la Nebbia Grigia\" viene mischiata nel mazzo."
  },
  State_45356_Name = {
    Text = "<CardKeyWord:Verità Dietro la Nebbia Grigia>"
  },
  State_45364_Desc = {
    Text = "All'inizio del prossimo turno, il Risveglio ottiene [Layer] \"Colpo\"."
  },
  State_45364_Name = {
    Text = "Ritarda Ottieni Colpo"
  },
  State_45385_Desc = {
    Text = "Tutto il Danno inflitto in questa Battaglia è ridotto di [Layer] e non può essere dissolto. Include [DescArg1] accumuli di riduzione di FOR temporanea, che verranno rimossi a fine turno."
  },
  State_45385_Name = {Text = "FOR▼"},
  State_45387_Desc = {
    Text = "Tutti i Danni inflitti +[Layer] in questa battaglia, non dissipabile. [DescArg1] accumuli di FOR temporanea verranno rimossi a fine turno."
  },
  State_45387_Name = {Text = "Forza"},
  State_45397_Desc = {
    Text = "A inizio turno, converte 1 accumulo di Barriera in Forza."
  },
  State_45397_Name = {
    Text = "Vittoria delle Rose"
  },
  State_45403_Desc = {
    Text = "All'Inizio del prossimo turno, ottieni [Layer] accumuli di Carica."
  },
  State_45403_Name = {
    Text = "Ritarda Carica"
  },
  State_45407_Desc = {
    Text = "L'Aliemus e l'Aliemus Ritardato ottenuti vengono ridotti del 50%, e tutto l'Aliemus Ritardato viene rimosso immediatamente."
  },
  State_45407_Name = {Text = "Vuoto"},
  State_45656_Desc = {
    Text = "L'Albero Madre si rianima per la terza volta, attivando l'Abilità Fertilità 2."
  },
  State_45658_Desc = {
    Text = "L'Albero Madre si rianima per la prima volta, attivando l'Abilità Fertilità."
  },
  State_45661_Desc = {
    Text = "Quando gli HP scendono a 0, vengono impostati a 1 punto, non subisce più Danno, si prepara a rilasciare \"Multi-Fusione\"."
  },
  State_45661_Name = {
    Text = "Multi-Fusione"
  },
  State_45715_Desc = {
    Text = "Ottieni FOR temporanea pari al [StateArg1]% del Danno da Tentacolo."
  },
  State_45715_Name = {Text = "Usurpare"},
  State_45716_Desc = {
    Text = "Ottieni FOR temporanea pari al [StateArg1]% del danno da Tentacolo. Golia ottiene un Tasso critico temporaneo del 25%."
  },
  State_45716_Name = {Text = "Usurpare"},
  State_45717_Desc = {
    Text = "Aumenta il DAN Base di \"Dominio della Lama\" e \"Danni da decapitazione\" del 25% in questa Battaglia. Golia ottiene <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_45717_Name = {Text = "Dormienza"},
  State_45718_Desc = {
    Text = "Aumenta il DAN Base di \"Dominio della Lama\" e \"Danni da decapitazione\" del 25% in questa battaglia."
  },
  State_45718_Name = {Text = "Dormienza"},
  State_46057_Name = {
    Text = "Arithmetica"
  },
  State_46079_Desc = {
    Text = "In questo turno, ogni volta che il bersaglio subisce Danno attivo, cura l'alleato con più HP persi di [Layer]."
  },
  State_46079_Name = {
    Text = "Guida del Santo Sangue"
  },
  State_46119_Desc = {
    Text = "La prossima volta che subisci un attacco, applica Intrecciare sull'attaccante."
  },
  State_46119_Name = {
    Text = "Trappola del Labirinto"
  },
  State_46124_Desc = {
    Text = "Impossibile compiere qualsiasi azione fino a fine turno."
  },
  State_46124_Name = {
    Text = "Pietrificazione"
  },
  State_46138_Desc = {
    Text = "Diventa l'ultima \"Abilità\" giocata dall'avversario, riducendone il costo di -1."
  },
  State_46138_Name = {
    Text = "<CardKeyWord:Mimetismo Stellare>"
  },
  State_46139_Desc = {
    Text = "Ottieni [Layer] accumuli di Carica e infliggi [Layer] accumuli di Stagnazione all'attaccante quando subisci Danno attivo."
  },
  State_46139_Name = {
    Text = "Gravità Anomala"
  },
  State_46155_Desc = {
    Text = "Dopo aver usato \"Abilità\", ottieni [StateArg1] Carica e perdi 1 accumulo di questo stato. A fine turno, consuma tutti gli accumuli, ripristinando [StateArg2] PV per ogni accumulo."
  },
  State_46155_Name = {
    Text = "Sangue Aberrante"
  },
  State_46243_Name = {
    Text = "Contrattacco Intuizione__\"Solo per sviluppo\""
  },
  State_46255_Desc = {
    Text = "Per gli effetti specifici, consulta la logica base di Colpo."
  },
  State_46256_Desc = {
    Text = "Per gli effetti specifici, consulta la logica base di Colpo."
  },
  State_46322_Desc = {
    Text = "All'inizio del turno, ottieni 30 Fusione Embrionale."
  },
  State_46322_Name = {
    Text = "Prova di Uvhash"
  },
  State_46323_Desc = {
    Text = "All'inizio del Turno Ultra, ottieni 100 Aliemus. A inizio turno, ottieni 7 Forza."
  },
  State_46323_Name = {
    Text = "Prova di Liz"
  },
  State_46324_Desc = {
    Text = "Ottieni 1 \"Intuizione\" per turno."
  },
  State_46324_Name = {
    Text = "Prova di Jenkin"
  },
  State_46329_Desc = {
    Text = "All'Inizio della Battaglia, ottieni 600 Keyflare. Lotan ottiene 50 Aliemus. Dopo l'Esaltazione di Lotan, si ottengono 44 Aliemus aggiuntivi."
  },
  State_46329_Name = {
    Text = "Bonus della Prova"
  },
  State_46330_Desc = {
    Text = "All'inizio del turno, ottieni 30 Fusione Embrionale, 10 Aliemus, [DescArg1] FOR e aggiungi 3 \"Colpo\" al Mazzo di Pesca."
  },
  State_46330_Name = {
    Text = "Prova dell'Ilota"
  },
  State_46333_Name = {
    Text = "Prova di Leigh"
  },
  State_46334_Desc = {
    Text = "Dopo il 4° turno, ottieni 100 Aliemus."
  },
  State_46334_Name = {
    Text = "Prova di Faros"
  },
  State_46336_Desc = {
    Text = "A inizio turno, ottieni 30 Fusione Embrionale e 10 Aliemus."
  },
  State_46336_Name = {
    Text = "Prova di Agrippa"
  },
  State_46337_Desc = {
    Text = "A inizio turno, ottieni 10 Aliemus."
  },
  State_46337_Name = {
    Text = "Prova di Caecus"
  },
  State_46338_Desc = {
    Text = "A inizio turno, ottieni 30 Fusione Embrionale e 10 Aliemus."
  },
  State_46338_Name = {
    Text = "Prova di Svenimento"
  },
  State_46427_Desc = {
    Text = "Per gli effetti specifici, consulta la logica base di Colpo."
  },
  State_46428_Desc = {
    Text = "Per gli effetti specifici, consulta la logica base di Colpo."
  },
  State_46429_Desc = {
    Text = "Per gli effetti specifici, consulta la logica base di Colpo."
  },
  State_46441_Desc = {
    Text = "Immune a tutti i Danni. Rimosso a inizio turno."
  },
  State_46441_Name = {
    Text = "Immunità ai Danni"
  },
  State_46442_Name = {
    Text = "La modifica del tipo di bersaglio della carta è proibita."
  },
  State_46500_Desc = {
    Text = "Per gli effetti specifici, consulta la logica base di Colpo."
  },
  State_46505_Desc = {
    Text = "In questo turno, ogni volta che si subisce un Danno attivo, si ottiene [Layer] Aliemus."
  },
  State_46505_Name = {
    Text = "Conversione del Dolore"
  },
  State_46508_Desc = {
    Text = "Quando è Svenuto, il bersaglio non può agire fino alla fine del turno. Subire Danno da Svenimento conferisce Resistenza. Se la Resistenza è attiva, il Danno da Svenimento successivo è raddoppiato, ma l'effetto di Svenimento viene negato."
  },
  State_46508_Name = {Text = "Resistenza"},
  State_46511_Desc = {
    Text = "Il Danno di \"Sovrapposizione di volti\" di questo Risvegliatore aumenta di [Layer]."
  },
  State_46511_Name = {
    Text = "Sovrapposizione di volti"
  },
  State_46512_Desc = {
    Text = "Prima della fine del turno, questo Risvegliato subisce [Layer] Danno per ogni carta giocata."
  },
  State_46512_Name = {
    Text = "Blocco d'Azione"
  },
  State_46513_Desc = {
    Text = "Potenzia il prossimo Salmo per conferire effetti aggiuntivi. Non può essere dissolto."
  },
  State_46513_Name = {
    Text = "Inchiostro del Lutto"
  },
  State_46536_Desc = {
    Text = "Se il parametro di stato 1 è 0, pesca una carta; altrimenti, mostra semplicemente il testo"
  },
  State_46536_Name = {Text = "Pesca"},
  State_46538_Desc = {
    Text = "All'inizio dell'esplorazione, ottieni [StateArg1] Aliemus."
  },
  State_46538_Name = {
    Text = "Presagio di Follia"
  },
  State_47072_Desc = {
    Text = "Il tasso di critico di \"Colpo\" è aumentato del [Layer]% in questo turno."
  },
  State_47072_Name = {
    Text = "Colpo Critico da Colpo"
  },
  State_47089_Name = {
    Text = "Effetto di prova__\"Solo per lo sviluppo\""
  },
  State_47096_Desc = {
    Text = "Ogni volta che viene giocata una carta \"Intuizione\", Daffodil ottiene [StateArg1] Aliemus e [StateArg2] Forza, attivandosi un massimo di 5 volte per turno. (Attualmente [DescArg1] volte rimanenti)"
  },
  State_47096_Name = {
    Text = "Sedimentazione dell'Essenza"
  },
  State_47189_Name = {
    Text = "Passa alla Persona Maniacale. Caro·Depressa: <EmbryoFusionIconKeywords:Fusione Embrionale> +[Blood:StateArg5], accumula [StateArg6] punti di Guarigione della Fornace Cremisi"
  },
  State_47192_Name = {
    Text = "Persona depressa: fa ottenere anche agli altri Risvegliatori [DescArg1] volte l'Aliemus. Persona Maniacale: ottiene [DescArg2] volte l'Aliemus aggiuntivo"
  },
  State_47199_Name = {
    Text = "Passa a Persona depressa. Caro: Follia: il Danno beneficia di [DescArg1]x il Buff <PowerIconKeywords:FOR> e infligge <BleedingIconKeywords:Sanguinamento> pari al 200% del Danno inflitto al bersaglio. Ottieni [StateArg7] <PowerIconKeywords:FOR>"
  },
  State_47204_Name = {
    Text = "Passa alla Personalità Maniacale. Caos: Depressione: Ottieni <Posse:[StateArg1]> Keyflare. La prossima attivazione della Posse avverrà 2 volte"
  },
  State_47206_Name = {
    Text = "Passa alla Personalità Maniacale. Aequor: Depressione: Applica <WeaknessIconKeywords:Debolezza> e <VulnerabilityIconKeywords:Vulnerabile> al bersaglio per 2 turni, genera 1 Tentacolo, <TentacleInjurieIconKeywords:Danno Tentacolo> + [TentaclePower:StateArg3]"
  },
  State_47209_Name = {
    Text = "Passa alla Persona depressa. Ultra: Sintomo: Follia: Ottieni il 15% del DAN inflitto come <RetaliateIconKeywords:Contrattacco>, poi infliggi una quantità equivalente di <FixedDamage:DAN Puro> agli altri nemici. Per ogni carta \"Intuizione\" giocata in questo turno, aumenta questo DAN di [StateArg9] per il resto del turno, fino a [StateArg10]"
  },
  State_47211_Name = {
    Text = "Persona depressa: riduce il Costo di Arithmetica di 1 punto per le [DescArg1] Carte con Arithmetica più alta nella Mano e ottiene <RetainIconKeywords:Conservare> Temporaneo. Persona Maniacale: infligge [DescArg2] Danni aggiuntivi"
  },
  State_47212_Name = {
    Text = "\"24\" alterna tra Personalità Maniacale e Depressa. Attiva effetti aggiuntivi in base al Reame e alla Personalità correnti"
  },
  State_47216_Name = {
    Text = "Passa alla Personalità Depressa. Aequor: Mania: Questo attacco beneficia di un bonus del [StateArg4]% al <TentacleInjurieIconKeywords:Danno Tentacolo>. Infliggi il 30% del danno inflitto come <IntoxicationIconKeywords:Veleno> a tutti i nemici."
  },
  State_47217_Name = {
    Text = "Passa alla Personalità Depressa. Caos: Mania: Infliggi 3 istanze di DAN e aumenta tutti i DAN inflitti da \"24\" di [StateArg2]"
  },
  State_47218_Name = {
    Text = "Passa alla Personalità Maniacale. Ultra: Depressione: Aggiungi 2 carte \"Intuizione\" alla mano, riduci temporaneamente [Power:StateArg8] <PowerIconKeywords:FOR> del bersaglio"
  },
  State_47222_Name = {
    Text = "Persona depressa: riduce il Costo di Arithmetica di 1 punto per le [DescArg1] Carte con Arithmetica più alta nella Mano e ottiene <RetainIconKeywords:Conservare> Temporaneo. <AwakerCard_24Lost:Persona Maniacale: infligge [DescArg2] Danni aggiuntivi>"
  },
  State_47224_Name = {
    Text = "Persona depressa: fa ottenere anche agli altri Risvegliatori [DescArg1] volte l'Aliemus. <AwakerCard_24Lost:Persona Maniacale: ottiene [DescArg2] volte l'Aliemus aggiuntivo>"
  },
  State_47228_Name = {
    Text = "<AwakerCard_24Lost:Persona depressa: fa ottenere anche agli altri Risvegliatori [DescArg1] volte l'Aliemus.>Persona Maniacale: ottiene [DescArg2] volte l'Aliemus aggiuntivo"
  },
  State_47229_Name = {
    Text = "<AwakerCard_24Lost:Persona depressa: riduce il Costo di Arithmetica di 1 punto per le [DescArg1] Carte con Arithmetica più alta nella Mano e ottiene <RetainIconKeywords:Conservare> Temporaneo. >Persona Maniacale: infligge [DescArg2] Danni aggiuntivi"
  },
  State_47451_Name = {
    Text = "La Banda di Ryker disabilita gli effetti della Ruota del destino"
  },
  State_47485_Name = {
    Text = "Persona depressa: riduce il Costo di Arithmetica di 2 punti per le [DescArg1] Carte con Arithmetica più alta nella Mano e ottiene <RetainIconKeywords:Conservare> Temporaneo. Persona Maniacale: infligge [DescArg2] Danni aggiuntivi"
  },
  State_47486_Name = {
    Text = "Persona depressa: riduce il Costo di Arithmetica di 2 punti per le [DescArg1] Carte con Arithmetica più alta nella Mano e ottiene <RetainIconKeywords:Conservare> Temporaneo. <AwakerCard_24Lost:Persona Maniacale: infligge [DescArg2] Danni aggiuntivi>"
  },
  State_47488_Name = {
    Text = "Persona depressa: ottiene <Energy: [DescArg1]> punti Aliemus aggiuntivi. Persona Maniacale: ottiene [DescArg2] Scudi aggiuntivi"
  },
  State_47489_Name = {
    Text = "<AwakerCard_24Lost:Persona depressa: riduce il Costo di Arithmetica di 2 punti per le [DescArg1] Carte con Arithmetica più alta nella Mano e ottiene <RetainIconKeywords:Conservare> Temporaneo. >Persona Maniacale: infligge [DescArg2] Danni aggiuntivi"
  },
  State_47492_Name = {
    Text = "Persona depressa: ottiene <Energy: [DescArg1]> punti Aliemus aggiuntivi. <AwakerCard_24Lost:Persona Maniacale: infligge [DescArg2] Danni aggiuntivi>"
  },
  State_47493_Name = {
    Text = "Persona depressa: ottiene <Energy: [DescArg1]> punti Aliemus aggiuntivi. Persona Maniacale: infligge [DescArg2] Danni aggiuntivi"
  },
  State_47494_Name = {
    Text = "Persona depressa: fa ottenere anche agli altri Risvegliatori [DescArg1] volte l'Aliemus, applica <WeaknessIconKeywords:Debolezza> a tutti i nemici per [DescArg3] turni. Persona Maniacale: ottiene [DescArg2] volte l'Aliemus aggiuntivo, applica <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici per [DescArg3] turni"
  },
  State_47495_Name = {
    Text = "Persona depressa: fa ottenere anche agli altri Risvegliatori [DescArg1] volte l'Aliemus, applica <WeaknessIconKeywords:Debolezza> a tutti i nemici per [DescArg3] turni. <AwakerCard_24Lost:Persona Maniacale: ottiene [DescArg2] volte l'Aliemus aggiuntivo, applica Vulnerabile a tutti i nemici per [DescArg3] turni>"
  },
  State_47496_Name = {
    Text = "<AwakerCard_24Lost:Persona depressa: fa ottenere anche agli altri Risvegliatori [DescArg1] volte l'Aliemus, applica Debolezza a tutti i nemici per [DescArg3] turni.>Persona Maniacale: ottiene [DescArg2] volte l'Aliemus aggiuntivo, applica <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici per [DescArg3] turni"
  },
  State_47498_Name = {
    Text = "<AwakerCard_24Lost:Persona depressa: ottieni [DescArg1] punti Aliemus aggiuntivi.>Persona Maniacale: infliggi [DescArg2] Danno aggiuntivo"
  },
  State_47499_Name = {
    Text = "<AwakerCard_24Lost:Persona depressa: ottieni [DescArg1] punti Aliemus aggiuntivi.>Persona Maniacale: ottieni [DescArg2] Scudo aggiuntivo"
  },
  State_47500_Name = {
    Text = "Persona depressa: ottieni <Energy: [DescArg1] > punti Aliemus aggiuntivi. <AwakerCard_24Lost:Persona Maniacale: ottieni [DescArg2] Scudo aggiuntivo>"
  },
  State_47517_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: A fine turno, scarta [StateArg1] carte dagli altri Risvegliati; in caso di successo, pesca [StateArg2] carte."
  },
  State_47517_Name = {
    Text = "Determinazione del Merluzzo Argenteo"
  },
  State_47518_Name = {
    Text = "Contrattacco della Risolutezza del Merluzzo d'Argento __ \"For Development Only\""
  },
  State_47528_Desc = {
    Text = "Questo turno, \"Colpo\" infligge +[DescArg1]% Danno. <PVPPenetrateKeywords:Perforazione>."
  },
  State_47528_Name = {
    Text = "Bagliore Residuo della Bestia Stellare"
  },
  State_47530_Desc = {
    Text = "Considerata come l'ultima \"Abilità\" giocata in questo turno."
  },
  State_47530_Name = {
    Text = "<CardKeyWord:Simulazione Riecheggiata>"
  },
  State_47557_Desc = {
    Text = "Unicità di Squadra: Il portatore passa alla Persona Merluzzo Argentato dopo l'inizio dell'esplorazione. Alternerà tra le Persona Merluzzo Argentato e Gatto dopo aver usato l'Esaltazione.\nMerluzzo Argentato: Ottieni <WeaponEffect_Num:[StateArg1]> Keyflare dopo aver inflitto un Danno attivo. Gatto: Ottieni un aumento dei DAN CRIT temporanei di <WeaponEffect_Num:+[StateArg2]%> dopo aver inflitto un Danno attivo. Questi effetti condividono un massimo di 5 attivazioni per turno."
  },
  State_47557_WeaponDesc = {
    Text = "Il portatore passa alla Persona Merluzzo Argentato dopo l'inizio dell'esplorazione. Alternerà tra le Persona Merluzzo Argentato e Gatto dopo aver usato l'Esaltazione.\nMerluzzo Argentato: Ottieni <WeaponEffect_Num:[StateArg1]> Keyflare dopo aver inflitto un Danno attivo. Gatto: Ottieni un aumento dei DAN CRIT temporanei di <WeaponEffect_Num:+[StateArg2]%> dopo aver inflitto un Danno attivo. Questi effetti condividono un massimo di 5 attivazioni per turno."
  },
  State_47822_Desc = {
    Text = "Se nel turno successivo si subisce nuovamente la \"Paralisi\", tutti i \"Colpi\" diventano \"Illusioni\", non possono essere dispersi e l'effetto dura fino alla fine del turno successivo."
  },
  State_47822_Name = {
    Text = "Un po' intorpidito"
  },
  State_47825_Desc = {
    Text = "All'inizio del turno, viene attivato l'Effetto dell'Abilità corrispondente."
  },
  State_47825_Name = {
    Text = "<CardKeyWord:Ritardo>"
  },
  State_47826_Desc = {
    Text = "·Il Danno raddoppia quando il bersaglio è in stato di \"Paralisi\", altrimenti il suo \"Colpo\" non può essere utilizzato in questo turno.\n·Se rimane in stato di \"Paralisi\" per 2 turni consecutivi, tutti i suoi \"Colpi\" diventano \"Illusioni\"."
  },
  State_47826_Name = {
    Text = "<WeaknessColour:Paralisi>"
  },
  State_47827_Desc = {
    Text = "Ogni accumulo riduce di 1 punto tutti i danni inflitti in questa battaglia; non può essere dissolto."
  },
  State_47827_Name = {
    Text = "<WeaknessColour:FOR▼>"
  },
  State_47828_Desc = {
    Text = "Quando questo stato viene inflitto a un nemico, infliggi un ammontare equivalente di Danno. Se il bersaglio è già \"Intrecciato\", il Danno inflitto è raddoppiato. \"Intrecciare\" disabilita la Ruota del destino equipaggiata dal bersaglio fino alla fine del turno."
  },
  State_47828_Name = {
    Text = "<WeaknessColour:Intrappolamento>"
  },
  State_47830_Desc = {
    Text = "Quando applicato, dissolve lo Scudo del Personaggio e la Cura Ritardata sul bersaglio. Riduce gli effetti di Guarigione e Scudo del Personaggio ricevuti del 50% fino a fine turno"
  },
  State_47830_Name = {
    Text = "<PVPVulnerabilityIconColour:Flagello>"
  },
  State_47831_Desc = {
    Text = "Quando è Svenuto, il bersaglio non può agire fino alla fine del turno. Subire Danno da Svenimento conferisce Resistenza. Se la Resistenza è attiva, il Danno da Svenimento successivo è raddoppiato, ma l'effetto di Svenimento viene negato."
  },
  State_47831_Name = {
    Text = "<ComaColour:Pietrificare>"
  },
  State_47832_Desc = {
    Text = "Comprende Topi infetti, Topi elettrici e Topi dementi"
  },
  State_47832_Name = {
    Text = "<CardKeyWord:Carta Ratto>"
  },
  State_47833_Desc = {
    Text = "Include il Fazzoletto Ricamato con Colombe, la Scatola Magica a Divisione Inversa e il Microfono Telepatico."
  },
  State_47833_Name = {
    Text = "<CardKeyWord:Magia Prodigiosa>"
  },
  State_47841_Desc = {
    Text = "I prossimi [Layer] utilizzi di Posse in questa Battaglia avranno effetto due volte."
  },
  State_47841_Name = {
    Text = "Doppio Decreto"
  },
  State_47842_Desc = {
    Text = "L'Aliemus e l'Aliemus Ritardato ottenuti vengono ridotti del 50%, e tutto l'Aliemus Ritardato viene rimosso immediatamente."
  },
  State_47842_Name = {
    Text = "<PVPEmptinessColour:Vuoto>"
  },
  State_47843_Desc = {
    Text = "Rianima il Risvegliatore dallo stato di morte e colloca tutte le sue carte nel Mazzo di Pesca."
  },
  State_47843_Name = {
    Text = "<PVPResurrectionColour:Rinascita>"
  },
  State_47844_Desc = {
    Text = "Genera un effetto sconcertante casuale."
  },
  State_47844_Name = {
    Text = "<PVPWonderfulEffectKeywords:Effetto meraviglioso>"
  },
  State_47845_Desc = {
    Text = "La carta genera un effetto mentre è in mano."
  },
  State_47845_Name = {
    Text = "<CardKeyWord:In Mano>"
  },
  State_47873_Desc = {
    Text = "Alla fine del prossimo turno, infliggi DAN pari al numero di accumuli."
  },
  State_47873_Name = {
    Text = "<PVPVulnerabilityIconColour:Emorragia>"
  },
  State_47887_Name = {
    Text = "Effetti diversi in base al Reame della squadra attuale"
  },
  State_47888_Name = {
    Text = "Caro: ogni punto di Arithmetica consumato da \"24\" aumenta la <EmbryoFusionIconKeywords:Fusione Embrionale> di +[Blood:DescArg1] e conferisce [StateArg3] punti di <PowerIconKeywords:Potere>; l'Esaltazione di \"24\" beneficia di un bonus aggiuntivo del 300% al Potere"
  },
  State_47889_Name = {
    Text = "Aequor: Il Danno inflitto da \"24\" gode di un bonus di [StateArg2]% <TentacleInjurieIconKeywords:Danno Tentacolo> e infligge <IntoxicationIconKeywords:Veleno> pari al 10% del Danno inflitto. L'Esaltazione di \"24\" può attivare [StateArg6]% di <IntoxicationIconKeywords:Veleno> sui nemici."
  },
  State_47892_Name = {
    Text = "Caos: Il Tasso critico e il Danno critico di \"24\" +[StateArg4]%. Ogni volta che viene usata una Posse, il Danno Finale dell'Esaltazione di \"24\" aumenta del [StateArg1]%"
  },
  State_47894_Name = {
    Text = "Ultra: Il danno inflitto da \"24\" beneficia di un bonus del [StateArg5]% al <RetaliateIconKeywords:Contatore>. Mescola 1 \"Intuizione\" nella Pila degli scarti a fine turno, Limite Mano +2"
  },
  State_48009_Desc = {
    Text = "La prima volta che viene giocata ogni turno, attiva [StateArg1] volte aggiuntive."
  },
  State_48009_Name = {
    Text = "<Rune_19:Ensemble>"
  },
  State_48010_Desc = {
    Text = "Marchio d'Ensemble"
  },
  State_48010_Name = {
    Text = "Marchio d'Ensemble"
  },
  State_48011_Desc = {
    Text = "La prima volta che viene giocata ogni turno, attiva [StateArg1] volte aggiuntive."
  },
  State_48011_Name = {
    Text = "<Rune_19_High:Av. Ensemble>"
  },
  State_48011_WeaponDesc = {
    Text = "Dopo essere stata giocata, ha Effetto [StateArg1] volte aggiuntive. Esaurimento."
  },
  State_48012_Desc = {
    Text = "Fa sì che la carta con l'Orazione si attivi 2 volte la prima volta che viene giocata in ogni turno."
  },
  State_48012_Name = {
    Text = "<CardKeyWord:Ensemble>"
  },
  State_48013_Desc = {
    Text = "Fa sì che la carta con l'Orazione si attivi 3 volte la prima volta che viene giocata in ogni turno."
  },
  State_48013_Name = {
    Text = "<CardKeyWord:Av. Ensemble>"
  },
  State_48019_Name = {
    Text = "<CardKeyWord:Simulazione Riecheggiata>"
  },
  State_48020_Name = {
    Text = "<CardKeyWord:Nascita di un'anima>"
  },
  State_48021_Name = {
    Text = "<CardKeyWord:Verità Dietro la Nebbia Grigia>"
  },
  State_48078_Name = {
    Text = "<CardKeyWord:Mimetismo Stellare>"
  },
  State_48099_Desc = {
    Text = "A fine turno, \"24\" ottiene [DescArg1] Aliemus. Ogni volta che \"24\" attiva un'Esaltazione, la quantità di Aliemus ottenuta da questo effetto aumenta di 1."
  },
  State_48099_Name = {
    Text = "Studio sul condizionamento pavloviano"
  },
  State_48099_WeaponDesc = {
    Text = "Ottieni 3 Aliemus alla fine del turno del portatore. Ottieni 2 Aliemus aggiuntivi se la Ricarica Aliemus del portatore è superiore a 10."
  },
  State_48100_Name = {
    Text = "Stato@24 Conteggio Ricerca Comportamentale di Pavlov"
  },
  State_48100_WeaponDesc = {
    Text = "Ottieni 3 Aliemus alla fine del turno del portatore. Ottieni 2 Aliemus aggiuntivi se la Ricarica Aliemus del portatore è superiore a 10."
  },
  State_48107_Desc = {
    Text = "La prima \"Abilità\" giocata dal portatore ogni turno infligge +[StateArg1]% Danno."
  },
  State_48107_Name = {
    Text = "Lama del Titano"
  },
  State_48108_Desc = {
    Text = "Dopo che il Portatore gioca un'\"Abilità\" per la prima volta ogni turno, mischierà una copia con Costo di Arithmetica - [StateArg1] nel Mazzo di Pesca."
  },
  State_48108_Name = {Text = "Fouetté"},
  State_48110_Desc = {
    Text = "\"Abilità\" fa sì che il prossimo \"Colpo\" di questo turno colpisca un nemico casuale e attacchi inoltre [StateArg1] bersagli casuali aggiuntivi."
  },
  State_48110_Name = {
    Text = "Uomo nello specchio"
  },
  State_48140_Desc = {
    Text = "All'inizio dell'esplorazione, \"24\" entra nello Stato di Persona depressa.\n<School_1:Caos·Depressa>: ottieni <Posse:[StateArg1]> punti di Energia-S, la prossima Posse si attiva 2 volte.\n<School_1:Caos·Maniacale>: infliggi Danno 3 volte, aumentando tutti i Danni inflitti da \"24\" di [StateArg2].\n<School_2:Aequor·Depressa>: applica <WeaknessIconKeywords:Debolezza> e <VulnerabilityIconKeywords:Vulnerabile> al bersaglio per 2 turni, genera 1 Tentacolo, <TentacleInjurieIconKeywords:Danni da tentacolo> +[StateArg3].\n<School_2:Aequor·Maniacale>: questo Danno beneficia del [StateArg4]% di bonus <TentacleInjurieIconKeywords:Danni da tentacolo>, e infligge <IntoxicationIconKeywords:Veleno> pari al 30% del Danno inflitto a tutti i nemici.\n<School_3:Caro·Depressa>: <EmbryoFusionIconKeywords:Fusione Embrionale> +[Blood:StateArg5], accumula [StateArg6] punti di Guarigione della Fornace Cremisi.\n<School_3:Caro·Maniacale>: il Danno beneficia di 6 volte il bonus <PowerIconKeywords:STR> e applica al bersaglio <BleedingIconKeywords:Sanguinamento> pari al 200% del Danno inflitto, ottenendo [StateArg7] <PowerIconKeywords:STR>.\n<School_4:Ultra·Depressa>: aggiungi 2 carte \"Ispirazione\" in mano, riducendo temporaneamente il <PowerIconKeywords:STR> del bersaglio di [StateArg8].\n<School_4:Ultra·Maniacale>: ottieni <RetaliateIconKeywords:Contrattacco> pari al 15% del Danno inflitto, poi infliggi lo stesso <RealDamage:Danno Fisso> agli altri nemici. Per ogni carta \"Ispirazione\" giocata in questo turno, questo Danno aumenta di [StateArg9], fino a un massimo di [StateArg10]."
  },
  State_48140_Name = {
    Text = "Effetti di Reame e Persona"
  },
  State_48141_Desc = {
    Text = "<School_1:Caos>: il Tasso critico e il Danno critico di \"24\" +[StateArg4]%. Ogni volta che si usa una Posse, il Danno Finale dell'Esaltazione di \"24\" aumenta del [StateArg1]%.\n<School_2:Aequor>: il Danno inflitto da \"24\" beneficia del [StateArg2]% di bonus <TentacleInjurieIconKeywords:Danni da tentacolo>, e infligge <IntoxicationIconKeywords:Veleno> pari al 10% del Danno. L'Esaltazione di \"24\" può attivare il 50% del <IntoxicationIconKeywords:Veleno> del nemico.\n<School_3:Caro>: ogni punto di Arithmetica consumato da \"24\" aumenta la <EmbryoFusionIconKeywords:Fusione Embrionale> +[Blood:5], ottenendo [StateArg3] punti di <PowerIconKeywords:Potere>. L'Esaltazione di \"24\" beneficia inoltre di 300% di bonus Potere\n<School_4:Ultra>: il Danno inflitto da \"24\" beneficia del [StateArg5]% di Bonus DAN <RetaliateIconKeywords:Contrattacco>, alla fine del turno Mischiare 1 carta \"Ispirazione\" nella Pila degli scarti, Limite Massima della Mano +2."
  },
  State_48141_Name = {
    Text = "Effetto del Reame"
  },
  State_48149_Name = {
    Text = "Effetto Speciale della Carta Non Disponibile"
  },
  State_48176_Desc = {
    Text = "In questa prova, ottieni 1 Arithmetica ogni turno; \"24\" per ogni 1 Arithmetica consumata, ottieni 30 Keyflare."
  },
  State_48176_Name = {Text = "\"24\"Prova"},
  State_48198_Desc = {
    Text = "In questa prova, ottieni 1 \"Intuizione\" ogni turno."
  },
  State_48198_Name = {Text = "\"24\"Prova"},
  State_48199_Desc = {
    Text = "Ottieni 1 Arithmetica per turno in questa demo."
  },
  State_48199_Name = {Text = "\"24\"Prova"},
  State_48589_Desc = {
    Text = "Questo Risvegliatore non è ancora Non Risvegliato... Si Risveglierà quando starà per essere sconfitto, con PV Massimi +200%, e combatterà con tutta la sua potenza."
  },
  State_48589_Name = {
    Text = "Non Risvegliato"
  },
  State_48607_Name = {
    Text = "Riduci l'Arithmetica Primordiale delle Carte Generiche"
  },
  State_48822_Desc = {
    Text = "All'inizio dei turni nel Regno di Caro, il guadagno di Fusione Embrionale aumenta del 50%."
  },
  State_48822_Name = {
    Text = "Ciclo Eterno"
  },
  State_48923_Desc = {
    Text = "Ombra\"24\" è stata Risvegliata. Usa l'ultimo \"Salvami\" per trovare la tua occasione!"
  },
  State_48923_Name = {
    Text = "Ombra\"24\"Risveglio!"
  },
  State_48923_WeaponDesc = {
    Text = "A inizio del turno successivo, ottieni Scudo del Personaggio pari alla quantità di HP persi nel turno precedente."
  },
  State_49063_Desc = {
    Text = "Il Danno di \"Colpo\" di Lotan è aumentato del 30%."
  },
  State_49063_Name = {
    Text = "Ardore Bellico Impetuoso"
  },
  State_49109_Desc = {
    Text = "Le carte ottengono l'effetto Conservare. A fine turno, se questa carta è In Mano, ottieni una copia originale della Carta di comando con Esaurimento."
  },
  State_49109_Name = {
    Text = "<Rune_20_High:Nascita>"
  },
  State_49109_WeaponDesc = {
    Text = "Dopo essere stata giocata, ha Effetto [StateArg1] volte aggiuntive. Esaurimento."
  },
  State_49148_Desc = {
    Text = "Alla morte, applica \"Mutazione 1\" a una carta con Costo di Arithmetica diverso da zero. Mutazione: Permane dopo la fine della battaglia. Ogni accumulo riduce il Costo di Arithmetica di 1, ma dopo aver giocato, ogni accumulo aggiungerà 1 Mutazione casuale alla tua mano (ignorando il limite della mano), rimuovendo tutte le Mutazioni."
  },
  State_49148_Name = {
    Text = "Progenie Aberrante"
  },
  State_49149_Desc = {
    Text = "Ogni accumulo riduce il Costo di Arithmetica delle carte di 1. Dopo essere stata giocata, per ogni accumulo di Mutazione, aggiungi una carta Distorsione casuale alla tua mano e rimuovi questo stato. Questo stato persiste dopo la battaglia."
  },
  State_49149_Name = {
    Text = "<ExclamationPointColour:Mutazione [Layer]>"
  },
  State_49149_WeaponDesc = {
    Text = "Rimuovila permanentemente dopo l'uso."
  },
  State_49207_Name = {
    Text = "Ottieni 100 Keyflare"
  },
  State_49225_Desc = {
    Text = "A fine turno, effettua 1 Attacco del Tentacolo [Layer] volte."
  },
  State_49225_Name = {
    Text = "<CardKeyWord:Raduno dei tentacoli>"
  },
  State_49226_Desc = {
    Text = "Alla fine del turno, per ogni carta In Mano, infliggi il 3% di Veleno a tutti i nemici e ottieni 3 Aliemus."
  },
  State_49226_Name = {
    Text = "Faint Candlelight"
  },
  State_49260_Desc = {
    Text = "Ripristina PV pari al 7,5% della COS a fine turno."
  },
  State_49260_Name = {
    Text = "Angoscia del reietto"
  },
  State_49270_Desc = {
    Text = "Danno delle carte Colpo aumentato del [Layer]%."
  },
  State_49270_Name = {
    Text = "Danno delle carte Colpo aumentato"
  },
  State_49270_WeaponDesc = {
    Text = "Danno delle carte Colpo aumentato del [Layer]%."
  },
  State_49278_Desc = {
    Text = "A fine turno, ripristina HP pari al 5% degli HP persi. Se gli HP sono sotto il 50% ([StateArg1]), ottieni [StateArg2] Forza."
  },
  State_49278_Name = {
    Text = "Altare Cremisi"
  },
  State_49430_Desc = {
    Text = "Danno subito -1% per accumulo. Lo Stato si azzera quando gli alleati muoiono."
  },
  State_49430_Name = {
    Text = "<AberrationColour:Occultare>"
  },
  State_49500_Desc = {
    Text = "Ogni accumulo aumenta il conteggio degli attacchi di 1. Perdi 1 accumulo quando subisci Danno, e perdi tutti gli accumuli alla fine del turno."
  },
  State_49500_Name = {Text = "Preghiera"},
  State_49524_Desc = {
    Text = "A fine turno, ripristina HP pari al 5% degli HP persi. Ogni volta che peschi una Carta di stato o una Carta sintomo, tutti i \"Nubia\" ottengono [StateArg1] FOR temporanea."
  },
  State_49524_Name = {
    Text = "Vangelo Cremisi"
  },
  State_49526_Desc = {
    Text = "Alla morte, ripristina [StateArg2] PV e diventa immune ai danni per 1 turno, modificando l'Intenzione in \"Diffusione della corruzione\"."
  },
  State_49526_Name = {Text = "Semina"},
  State_49542_Desc = {
    Text = "Unico per Squadra: Dopo l'Inizio della Battaglia, ottieni FOR pari al <WeaponEffect_Num:[StateArg1]%> dell'ATT del Portatore. Se il reame attuale è \"Aequor\", aumenta anche il Danno del Tentacolo del <WeaponEffect_Num:[StateArg2]%> dell'ATT del Portatore."
  },
  State_49542_WeaponDesc = {
    Text = "All'inizio della battaglia, ottieni <WeaponEffect_Num:[Power:DescArg1]> Forza; se il Reame attuale è \"Aequor\", ottieni anche <WeaponEffect_Num:[DescArg2]> danni da Tentacolo."
  },
  State_49546_Desc = {
    Text = "Appare sempre con 2 guardie d'élite. Moriranno quando esso morirà."
  },
  State_49546_Name = {Text = "Formazione"},
  State_49547_Desc = {
    Text = "Alla morte, il Capitano della guardia di Aram ottiene [StateArg1] Forza e uno Scudo del Personaggio pari al 50% dei PV massimi."
  },
  State_49547_Name = {Text = "Lealtà"},
  State_49558_Desc = {
    Text = "Aumenta la Forza di [StateArg1] ogni turno."
  },
  State_49558_Name = {
    Text = "Benedizione delle Sabbie"
  },
  State_49582_Desc = {
    Text = "Lo Scudo del Personaggio rimanente alla fine di ogni turno in questa battaglia non verrà rimosso e resterà intatto."
  },
  State_49582_Name = {
    Text = "Mantenimento Scudo Permanente"
  },
  State_49583_Desc = {
    Text = "A fine turno, ottieni [StateArg1] Scudo del Personaggio, potenziato da Allerta"
  },
  State_49583_Name = {
    Text = "Scudo di Aram"
  },
  State_49595_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_49595_Name = {
    Text = "Non Risvegliato"
  },
  State_49596_Desc = {
    Text = "\"Lama dell'Utopia\" si è Risvegliata. Otterrà più Scudo del Personaggio e Forza."
  },
  State_49596_Name = {
    Text = "Alva Risveglio!"
  },
  State_49596_WeaponDesc = {
    Text = "A inizio del turno successivo, ottieni Scudo del Personaggio pari alla quantità di HP persi nel turno precedente."
  },
  State_49597_Name = {
    Text = "Già paralizzato in questo turno"
  },
  State_49600_Desc = {
    Text = "Applica Debolezza a tutti i nemici per 2 turni."
  },
  State_49600_Name = {
    Text = "Sangue della paura"
  },
  State_49601_Desc = {
    Text = "Rendi tutti i nemici Vulnerabili per 2 turni."
  },
  State_49601_Name = {
    Text = "Sangue della Putrefazione"
  },
  State_49602_Desc = {
    Text = "Rendi tutti i nemici vulnerabili per 1 turno."
  },
  State_49602_Name = {
    Text = "Sangue della Putrefazione"
  },
  State_49603_Desc = {
    Text = "Fusione Embrionale +[Blood:DescArg1]."
  },
  State_49603_Name = {
    Text = "Sangue del Coito"
  },
  State_49604_Desc = {
    Text = "Fusione Embrionale +[Blood:DescArg1]."
  },
  State_49604_Name = {
    Text = "Sangue del Coito"
  },
  State_49605_Desc = {
    Text = "Applica Debolezza a tutti i nemici per 1 turno."
  },
  State_49605_Name = {
    Text = "Sangue della paura"
  },
  State_49623_Desc = {
    Text = "Recupero PV ridotto del [DescArg1]%. Rimuove 1 accumulo alla fine del turno."
  },
  State_49623_Name = {
    Text = "<BaseDamageColour:Flagello>"
  },
  State_49623_WeaponDesc = {
    Text = "Riduce tutti i danni inflitti del [DescArg1]%."
  },
  State_49627_Desc = {
    Text = "Inizia con 2 accumuli di <ParcloseIconKeywords:Barriera>. Alla morte, tutti i \"Nubia\" ottengono [StateArg1] Forza."
  },
  State_49627_Name = {
    Text = "Ondata di Sangue"
  },
  State_49628_Desc = {
    Text = "Alla morte, tutti i \"Nubia\" ottengono [StateArg1] Forza."
  },
  State_49628_Name = {
    Text = "Legame di Sangue"
  },
  State_49638_Desc = {
    Text = "Identifica se si tratta di uno status mostro della serie Capra Nera."
  },
  State_49833_Desc = {
    Text = "Alla fine del turno, applica 1 turno di stato \"Cecità\" a tutti i nemici. Quando il proprio Scudo viene distrutto, rimuovi lo stato \"Cecità\"."
  },
  State_49833_Name = {
    Text = "Barriera di Polvere"
  },
  State_49844_Desc = {
    Text = "Unico per Squadra: Ottieni <WeaponEffect_Num:[StateArg1]> Keyflare a fine turno. Ottieni <WeaponEffect_Num:[StateArg2]> Keyflare dopo aver attivato Resistenza alla Morte. Usare il Corpo di Gnosi d'Emergenza aumenta il limite di Arithmetica di 3 e permette di pescare 3 carte per turno."
  },
  State_49844_WeaponDesc = {
    Text = "Ottieni <WeaponEffect_Num:[StateArg1]> Keyflare a fine turno. Ottieni <WeaponEffect_Num:[StateArg2]> Keyflare dopo aver attivato la Resistenza alla Morte. Usare il Corpo di Gnosi d'Emergenza aumenta il Limite di Arithmetica di 3 e ti permette di pescare 3 carte in più per turno."
  },
  State_49877_Desc = {
    Text = "Riduci il Costo di Arithmetica di questa carta. Dopo averla giocata, aggiungi 1 Carta Mutazione casuale per ogni accumulo di Mutazione e rimuovi lo Stato. Lo Stato persiste dopo la Battaglia."
  },
  State_49877_Name = {
    Text = "<AberrationKeywords:Mutazione>"
  },
  State_49877_WeaponDesc = {
    Text = "Ogni accumulo di Stagnazione aumenta di 1 il Costo di Arithmetica delle carte."
  },
  State_49954_Desc = {
    Text = "Il Danno Crit. di tutti i Risvegliatori è dimezzato."
  },
  State_49954_Name = {
    Text = "<BlindingKeywords:Cecità>"
  },
  State_49954_WeaponDesc = {
    Text = "Ogni accumulo di Stagnazione aumenta di 1 il Costo di Arithmetica delle carte."
  },
  State_49957_Desc = {
    Text = "Quando si subisce Danno attivo, blocca l'Esaltazione e le Carte di comando del Risvegliatore attaccante per 1 turno, rimuovi 1 accumulo di <ResentChainsKeywords:Catene del Risentimento>. Si azzera al termine del turno."
  },
  State_49957_Name = {
    Text = "<ResentChainsKeywords:Catene del risentimento>"
  },
  State_49957_WeaponDesc = {
    Text = "Ogni accumulo di Stagnazione aumenta di 1 il Costo di Arithmetica delle carte."
  },
  State_49958_Desc = {
    Text = "Quando si subiscono Danni Attivi e da Tentacolo, sigilla l'Esaltazione e le Carte di Comando del Risvegliatore attaccante per 1 turno, rimuovi 1 accumulo di <ResentChainsKeywords:Catene del Risentimento>."
  },
  State_49958_Name = {
    Text = "<ResentChainsKeywords1:Catene del Risentimento>"
  },
  State_49959_Desc = {
    Text = "A inizio turno, ottieni 1 accumulo di <ResentChainsKeywords:Catene del risentimento>."
  },
  State_49959_Name = {
    Text = "Serratura Multidimensionale"
  },
  State_50010_Desc = {
    Text = "Guarigione ricevuta -25%. Rimuovi 1 accumulo a fine turno."
  },
  State_50010_Name = {
    Text = "<HeavyInjuryKeywords:Flagello>"
  },
  State_50021_Desc = {
    Text = "Unicità di Squadra: dopo che il portatore rilascia l'Esaltazione, ottiene <PowerIconKeywords:Potere> pari al <WeaponEffect_Num:[StateArg1]%> dell'ATT del portatore. Se il Reame attuale è \"Caro\", dopo il rilascio dell'Esaltazione, la Fusione Embrionale aumenta di <WeaponEffect_Num:+[Blood:StateArg2]> ."
  },
  State_50021_WeaponDesc = {
    Text = "Dopo che il portatore rilascia l'Esaltazione, ottiene <WeaponEffect_Num:[Power:DescArg1]> punti di <PowerIconKeywords:Potere>. Se il Reame attuale è \"Caro\", dopo il rilascio dell'Esaltazione, la Fusione Embrionale aumenta di <WeaponEffect_Num:+[Blood:StateArg2]> ."
  },
  State_50302_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Resisti a 1 morte e distruggi questa \"Ruota del destino\", ottieni [StateArg1] <plural value=\"[StateArg1]\" singular=\"accumulo\" plural=\"accumuli\"> di <PVPProtectiveKeywords:Barriera>. Se il portatore è l'unico alleato sopravvissuto quando si attiva, ottieni [StateArg2] \"Posse\" casuali all'inizio del turno successivo."
  },
  State_50302_Name = {
    Text = "Notte polare e alba nascente"
  },
  State_50323_Desc = {
    Text = "Prima dell'inizio del prossimo turno, ottieni [Layer] carte Seguito casuali."
  },
  State_50323_Name = {
    Text = "Ritarda Schiera"
  },
  State_50333_Desc = {
    Text = "A fine turno, tutti i Risvegliatori perdono Aliemus."
  },
  State_50333_Name = {
    Text = "<EmptinessKeywords:Vuoto>"
  },
  State_50333_WeaponDesc = {
    Text = "Ogni accumulo di Stagnazione aumenta di 1 il Costo di Arithmetica delle carte."
  },
  State_50352_Name = {
    Text = "Prova di Thais"
  },
  State_50353_Name = {
    Text = "Prova di Thais"
  },
  State_50358_Desc = {
    Text = "Danno subito -1% per accumulo. Lo Stato si azzera quando gli alleati muoiono."
  },
  State_50358_Name = {
    Text = "<ConcealmentKeywords:Occultamento>"
  },
  State_50375_Desc = {
    Text = "Questi Effetti includono: il personaggio ottiene 10 Aliemus, gli altri alleati ottengono 5 Aliemus, applica 1 accumulo di Vulnerabile a tutti i nemici, applica 1 accumulo di Debolezza a tutti i nemici, pesca 1 carta, ottieni 200 Keyflare."
  },
  State_50375_Name = {
    Text = "<MysterybuffKeywords:Effetto meraviglioso>"
  },
  State_50389_Desc = {
    Text = "All'inizio del turno, aggiungi un \"Dadi Fortunati di Ryker\" alla mano."
  },
  State_50389_Name = {
    Text = "Supporto di Ryker"
  },
  State_50390_Desc = {
    Text = "A inizio turno, ottieni [StateArg1] Forza."
  },
  State_50390_Name = {
    Text = "Veterano Eccezionale"
  },
  State_50491_Name = {
    Text = "Pendolo Crono \"Equilibrio\""
  },
  State_50735_Desc = {
    Text = "Quando sta per essere sconfitto per la prima volta, recupera HP e cambia l'Intenzione in \"Lamento lacerante\", infliggendo Danno a bersaglio singolo estremamente elevato."
  },
  State_50735_Name = {
    Text = "Risolutezza Vana"
  },
  State_50854_Desc = {
    Text = "All'inizio della Battaglia, ottieni [StateArg1] <RetaliateIconKeywords:Contatore>. Dopo il tuo turno, ottieni [StateArg2] Scudo; questa Generazione di Scudo aumenta di [StateArg3] ogni turno."
  },
  State_50854_Name = {
    Text = "Corteccia Robusta"
  },
  State_50861_Desc = {
    Text = "Non subisce più Danno, si prepara a liberare la \"Madre di Innumerevoli Progenie\"."
  },
  State_50861_Name = {Text = "Derivato"},
  State_50862_Desc = {
    Text = "Non subisce più Danno, si prepara a rilasciare \"Allevamento\"."
  },
  State_50862_Name = {Text = "Schiusa"},
  State_50863_Desc = {
    Text = "Non subisce più Danno, si prepara a rilasciare \"Linfa d'Albero Selvaggio\"."
  },
  State_50863_Name = {Text = "Immune"},
  State_50864_Desc = {
    Text = "Non subisce più Danno, si prepara a rilasciare \"Resina d'Albero\"."
  },
  State_50864_Name = {Text = "Immune"},
  State_50891_Desc = {
    Text = "Non subisce più Danno, si prepara a rilasciare \"Multi-Fusione\"."
  },
  State_50891_Name = {Text = "Divorare"},
  State_51016_Desc = {
    Text = "L'effetto Veleno ricevuto aumenta al 1000%."
  },
  State_51016_Name = {
    Text = "Legno Rinsecchito e Marcio"
  },
  State_51017_Desc = {
    Text = "L'Effetto Veleno ricevuto diventa il 500%."
  },
  State_51017_Name = {
    Text = "Legno Rinsecchito e Marcio"
  },
  State_51607_Desc = {
    Text = "Immune a tutti i Danni. Rimosso a inizio turno."
  },
  State_51607_Name = {
    Text = "Immunità ai Danni"
  },
  State_51695_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_51695_Name = {
    Text = "Non Risvegliato"
  },
  State_51696_Desc = {
    Text = "\"Apostolo del Mare\"è stato Risvegliato, con maggiore resistenza all'Esaltazione."
  },
  State_51696_Name = {
    Text = "Risveglio di Miryam!"
  },
  State_51696_WeaponDesc = {
    Text = "A inizio del turno successivo, ottieni Scudo del Personaggio pari alla quantità di HP persi nel turno precedente."
  },
  State_51739_Desc = {
    Text = "A fine turno, ottieni casualmente 1 \"Illusione del Regno Divino\". Non può essere dissolto."
  },
  State_51739_Name = {
    Text = "La fine della fede"
  },
  State_51740_Desc = {
    Text = "All'inizio della battaglia, metti 1 \"Ossessione\" in mano."
  },
  State_51740_Name = {
    Text = "Pietà inestinguibile"
  },
  State_51741_Desc = {
    Text = "Ottieni [Layer] Scudo del Personaggio a inizio turno. Non può essere dissolto."
  },
  State_51741_Name = {
    Text = "Risolutezza di Ferro"
  },
  State_51742_Desc = {
    Text = "Ottieni [Layer] DAN Tentacolo e Forza a inizio turno. Non può essere dissolto."
  },
  State_51742_Name = {
    Text = "Rivelare la Devozione"
  },
  State_51743_Desc = {
    Text = "Questo turno, ogni volta che il Tentacolo attacca, ottiene i seguenti effetti in base alla Postura del tentacolo: Maree crescenti: Tutti i Risvegliatori ottengono <Energy:[Energy:StateArg1]> Aliemus; Mare Tranquillo: Infligge [StateArg2] <IntoxicationIconKeywords:Veleno> a tutti i nemici; Onde Furiose: <TentacleInjurieIconKeywords:DAN Tentacolo> Temporaneo +[StateArg3]."
  },
  State_51743_Name = {
    Text = "Benedizione della Deipara"
  },
  State_51745_Desc = {
    Text = "Quando l'Apostolo del mare gioca 1 carta, genera [StateArg1] Tentacoli temporanei che ignorano il Limite Tentacoli."
  },
  State_51745_Name = {
    Text = "Autorità Delegata"
  },
  State_51745_WeaponDesc = {
    Text = "Quando l'Apostolo del mare gioca 1 carta, genera [StateArg1] Tentacoli temporanei che ignorano il Limite Tentacoli."
  },
  State_51811_Name = {
    Text = "Effetto Curativo della Vela Timoniera"
  },
  State_51813_Desc = {
    Text = "A fine turno, Costo di Arithmetica -[Layer]. Questo Effetto si attiva anche se scartata."
  },
  State_51813_Name = {
    Text = "<PrepareKeypvewordscolour:Preparazione[Layer]>"
  },
  State_51820_Desc = {
    Text = "\"Nascita\" ottiene un effetto aggiuntivo: a 5 accumuli, richiama istantaneamente 1 \"Figlio dell'Acqua\", fino a un massimo di 2 \"Figlio dell'Acqua\"."
  },
  State_51820_Name = {
    Text = "Risveglio di Miryam"
  },
  State_51822_Desc = {
    Text = "Ogni volta che rilasci un'Esaltazione, ottieni 1 carica di \"Gestazione\". Per ogni carica di Gestazione, ottieni [StateArg1] Forza, fino a un massimo di 5 cariche."
  },
  State_51822_Name = {
    Text = "L'Ultima Discesa Divina di Lemuria"
  },
  State_52068_Desc = {
    Text = "Converti fino a 3 \"Sacramento\" In Mano in \"Ossessione\", ottenendo diversi effetti aggiuntivi in base al numero di conversioni."
  },
  State_52068_Name = {
    Text = "<CardKeyWord:Rito>"
  },
  State_52087_Desc = {
    Text = "\"Uccello del paradiso immortale\" può applicare nuovamente lo stato di rinascita solo dopo [Layer] turni"
  },
  State_52087_Name = {
    Text = "Tempo di Ricarica della Rinascita"
  },
  State_52116_Desc = {
    Text = "Prima della fine del turno, questo Risvegliato subisce [Layer] Danno per ogni uso dell'Esaltazione."
  },
  State_52116_Name = {
    Text = "Blocco dell'Esaltazione"
  },
  State_52369_Desc = {
    Text = "Dopo aver giocato [DescArg1] Carte sintomo, ottieni la carta supporto \"Autorità Reale\" da Tulu: infligge DAN massicci e causa lo svenimento del bersaglio per 1 turno."
  },
  State_52369_Name = {
    Text = "Il Regno Divino tornerà"
  },
  State_53115_Desc = {
    Text = "Questo turno, il prossimo effetto \"Rito\" attivato di Miryam +50%."
  },
  State_53115_Name = {
    Text = "Preghiera all'Abisso"
  },
  State_53144_Desc = {
    Text = "Ottieni <Block:[Block:StateArg1]> Scudo del Personaggio a inizio turno."
  },
  State_53144_Name = {
    Text = "<CardKeyWord:Risolutezza di Ferro>"
  },
  State_53145_Desc = {
    Text = "A inizio turno, <PowerIconKeywords:FOR> e <TentacleInjurieIconKeywords:Danno Tentacolo>+[StateArg2]."
  },
  State_53145_Name = {
    Text = "<CardKeyWord:Rivelare la Devozione>"
  },
  State_53673_Desc = {
    Text = "Puoi accumulare fino a 10 Divisione Ghiandolare."
  },
  State_53673_Name = {
    Text = "Limite di Divisione Ghiandolare"
  },
  State_53674_Desc = {
    Text = "Limite di carte in mano +2. A inizio turno, Miryam ottiene 20 Aliemus."
  },
  State_53674_Name = {
    Text = "Prova di Miryam"
  },
  State_53755_Desc = {
    Text = "La <PowerIconKeywords:FOR> ottenuta, il <RetaliateIconKeywords:Contatore> ottenuto e il <IntoxicationIconKeywords:Veleno> applicato da tutti i Risvegliati sono aumentati del +[DescArg1]%. Aumenta la <PowerIconKeywords:FOR> ottenuta dai \"Capitoli Risplendenti\"."
  },
  State_53755_Name = {Text = "Paura"},
  State_53756_Desc = {
    Text = "L'Aliemus ottenuto da tutti i Risvegliati è aumentato del [DescArg1]%. Tutte le Carte di comando ottengono Conservare. L'Arithmetica non utilizzata viene conservata. Aumenta l'Aliemus concesso dai \"Capitoli Risplendenti\"."
  },
  State_53756_Name = {Text = "Felicità"},
  State_53758_Desc = {
    Text = "Il Danno Finale di tutti i Risvegliati è aumentato del [DescArg1]%. Aumenta il Tasso critico e il Danno Crit. ottenuti dai \"Capitoli Risplendenti\"."
  },
  State_53758_Name = {Text = "Ira"},
  State_53759_Desc = {
    Text = "Il guadagno di Scudo del Personaggio, gli effetti di Recupero PV e l'effetto di riduzione della <PowerIconKeywords:FOR> applicato da tutti i Risvegliati sono aumentati del [DescArg1]%. Aumenta il Recupero PV dei \"Capitoli Risplendenti\"."
  },
  State_53759_Name = {Text = "Dolore"},
  State_53772_Name = {
    Text = "Accessorio Paradosso"
  },
  State_53772_WeaponDesc = {
    Text = "Dopo che il portatore usa l'Esaltazione, gli alleati ottengono <RetaliateIconKeywords:Contatore> basato sul 100% della DIF del portatore. Aumenta inoltre il <RetaliateIconKeywords:Contatore> attuale del portatore del 10%."
  },
  State_53870_Name = {
    Text = "Accessorio: Anello della Stanza 36"
  },
  State_53870_WeaponDesc = {
    Text = "Quando la carta del Portatore viene pescata, la sua Arithmetica cambia casualmente tra 0 e 3."
  },
  State_53981_Name = {
    Text = "Accessorio: Regolazione de Il sigillo nero nel Sogno dei Farmaci"
  },
  State_53981_WeaponDesc = {
    Text = "All'inizio della battaglia, mischia un set aggiuntivo delle carte del Portatore nel Mazzo di Pesca."
  },
  State_54002_Name = {
    Text = "Stato@Marchio Filtro Sogno Accessorio"
  },
  State_54002_WeaponDesc = {
    Text = "Dopo che il portatore usa l'Esaltazione, gli alleati ottengono <RetaliateIconKeywords:Contatore> basato sul 100% della DIF del portatore. Aumenta inoltre il <RetaliateIconKeywords:Contatore> attuale del portatore del 10%."
  },
  State_54011_Name = {
    Text = "Stato@Copia Sogno Accessorio 1 Disponibile"
  },
  State_54011_WeaponDesc = {
    Text = "Dopo che il portatore usa l'Esaltazione, gli alleati ottengono <RetaliateIconKeywords:Contatore> basato sul 100% della DIF del portatore. Aumenta inoltre il <RetaliateIconKeywords:Contatore> attuale del portatore del 10%."
  },
  State_54012_Name = {
    Text = "Stato@Copia Sogno Accessorio 2 Disponibile"
  },
  State_54012_WeaponDesc = {
    Text = "Dopo che il portatore usa l'Esaltazione, gli alleati ottengono <RetaliateIconKeywords:Contatore> basato sul 100% della DIF del portatore. Aumenta inoltre il <RetaliateIconKeywords:Contatore> attuale del portatore del 10%."
  },
  State_54013_Desc = {
    Text = "In questo turno, la Padronanza del Reame aumenta di [Layer]."
  },
  State_54013_Name = {
    Text = "Padronanza del Reame temporanea"
  },
  State_54014_Desc = {
    Text = "Padronanza del Reame aumentata di [Layer]."
  },
  State_54014_Name = {
    Text = "Padronanza del Reame"
  },
  State_54043_WeaponDesc = {
    Text = "Dopo che il Portatore usa Esaltazione, il suo Scudo e il suo Pot. Guarigione vengono raddoppiati per questo turno."
  },
  State_54044_Desc = {
    Text = "Infliggi il doppio del Danno e ottieni aggiuntivamente il 600% di Keyflare pari alla Ricarica della chiave d'argento di Circuito·Ramona, ma <DepleteIconKeywords:Esaurisci> dopo aver giocato."
  },
  State_54044_Name = {
    Text = "Ode al Domani"
  },
  State_54045_Desc = {
    Text = "Ottieni 3 Arithmetica."
  },
  State_54045_Name = {
    Text = "Tribunale della Rinascita"
  },
  State_54046_Desc = {
    Text = "A inizio turno, ripristina [StateArg1] HP per [Layer] turni."
  },
  State_54046_Name = {
    Text = "Razionalità, verità e realtà"
  },
  State_54071_Desc = {
    Text = "Il conteggio del Danno attivo di Ogier +1, per [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turni\">."
  },
  State_54071_Name = {
    Text = "Sette Arti, Otto Virtù"
  },
  State_54121_Desc = {
    Text = "Il DAN Base inflitto da \"Bestia del Caos\" aumenta del [Layer]% in questa battaglia."
  },
  State_54121_Name = {
    Text = "Bestia del Caos"
  },
  State_54138_Desc = {
    Text = "La Carta di comando di Sorel giocata in [Layer] ha effetto due volte."
  },
  State_54138_Name = {
    Text = "Carosello dell'Ambizione"
  },
  State_54384_Desc = {
    Text = "L'effetto <IntoxicationIconKeywords:Veleno> di Nymphaea aumenta del 50%, per [Layer] turni."
  },
  State_54384_Name = {
    Text = "Passaggio dell'Ego"
  },
  State_54416_Desc = {
    Text = "Una volta sbloccata la Sovraesaltazione, l'indicatore di Aliemus può essere riempito due volte. Raggiungere una seconda carica completa potenzia l'abilità a Sovraesaltazione, aggiungendo potenti effetti bonus. Scatenare un'Esaltazione normale consumerà invece il 50% dell'Aliemus in eccesso."
  },
  State_54416_Name = {
    Text = "<OverLimitUtlSkillKeywords:Sovraesaltazione>"
  },
  State_54416_WeaponDesc = {
    Text = "Esaurisci gli embrioni in mano, innescando un potente Effetto divorante."
  },
  State_54561_Desc = {
    Text = "Unico per Squadra: Aumenta il Danno inflitto dal Portatore del <WeaponEffect_Num:[StateArg1]%> del suo Attacco. Se il Reame attuale è \"Caro\", ogni volta che l'Effetto divorante viene attivato, aumenta ulteriormente il Danno inflitto dal Portatore del 3% del suo Attacco."
  },
  State_54561_WeaponDesc = {
    Text = "I DAN inflitti dal portatore aumentano di [DescArg1] punti. Se il reame attuale è\"Caro\", ogni volta che l'Effetto divorante viene attivato, i DAN inflitti dal portatore aumentano ulteriormente di [DescArg2] punti."
  },
  State_54568_Name = {
    Text = "Fino alla Fine del Pianeta"
  },
  State_54597_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo la morte di un Risvegliatore nemico, ottieni [StateArg1] <StrongEffectKeywords:Forte>, metti in mano l'\"Abilità\" con il Costo di Arithmetica più alto dotata di <PVPVoidKeywords:Illusione>."
  },
  State_54597_Name = {
    Text = "Milioni di sguardi amorevoli"
  },
  State_54704_Desc = {
    Text = "La prossima Carta di comando di '24' ha effetto 3 volte."
  },
  State_54704_Name = {
    Text = "Tripudio di Carogne Contorte"
  },
  State_54798_Desc = {
    Text = "Scudo Generato, Recupero PV ed effetto Riduzione FOR di <PowerIconKeywords:FOR> di tutti i Risvegliati +[StateArg1]%. Aumenta il Recupero PV dei Capitoli Risplendenti."
  },
  State_54798_Name = {Text = "\"Dolore\""},
  State_54799_Desc = {
    Text = "FOR ottenuta, Contrattacco ottenuto e Veleno inflitto da tutti i Risvegliati +[StateArg1]%. Aumenta la Generazione di FOR dei Capitoli Risplendenti."
  },
  State_54799_Name = {Text = "\"Paura\""},
  State_54800_Desc = {
    Text = "Il Danno Finale inflitto da tutti i Risvegliati è aumentato del [StateArg1]%. Aumenta il Tasso critico temporaneo e il Danno Crit. ottenuti dai Capitoli Risplendenti."
  },
  State_54800_Name = {Text = "\"Ira\""},
  State_55108_Desc = {
    Text = "All'inizio del turno, potenzia \"Fiamme Verdi\" o \"Fiamme Corrotte\" in mano a \"Fiamme Letali\", per [Layer] turni."
  },
  State_55108_Name = {
    Text = "Discesa del Presagio"
  },
  State_55108_WeaponDesc = {
    Text = "Potenziata se in mano o nello Spazio Ultra all'inizio del turno."
  },
  State_55113_Desc = {
    Text = "Horla ottiene 10 Aliemus dopo aver giocato la prima carta Salmo in ogni turno."
  },
  State_55113_Name = {
    Text = "Fiori e Versi Riuniti"
  },
  State_55465_Name = {
    Text = "Consuma [Layer] accumuli della Metafora \"Ira\", infliggendo [DescArg1] istanza aggiuntiva di danno"
  },
  State_55466_Name = {
    Text = "Consuma [Layer] accumuli della Metafora \"Dolore\", ripristinando <Heal:[Heal:DescArg1]> PV"
  },
  State_55467_Name = {
    Text = "Consuma [Layer] accumulo della Metafora \"Paura\", ottieni [Power:DescArg1] <PowerIconKeywords:FOR> aggiuntiva"
  },
  State_55469_Name = {
    Text = "Consuma [Layer] accumuli della Metafora \"Gioia\" per concedere <Energy:[Energy:DescArg1]> Aliemus aggiuntivi"
  },
  State_55470_Name = {
    Text = "Mietitore di Teschi"
  },
  State_55485_Desc = {
    Text = "Le prossime [Layer] <plural value=\"[Layer]\" singular=\"carta\" plural=\"carte\"> giocate da Casiah ottengono una forza pari all'8% del suo ATT."
  },
  State_55485_Name = {
    Text = "Riso Gioioso"
  },
  State_55486_Name = {
    Text = "La Sovraesaltazione della Città dei Sogni Morti esenta il consumo di Esca Onirica."
  },
  State_55487_Desc = {
    Text = "Il \"Colpo\" di Erica infligge 2 istanze di Danno aggiuntive, e la \"Difesa\" ottiene 2 istanze di Scudo extra, per [Layer] turni."
  },
  State_55487_Name = {
    Text = "Calcoli Multipli"
  },
  State_55489_Name = {
    Text = "Piega Spazio-Temporale"
  },
  State_55806_Name = {
    Text = "<PoetryKeywords:Offerta>: Conferisci a tutti i nemici un <PVPWonderfulEffectKeywords:Effetto meraviglioso> negativo oppure conferisci a tutti gli alleati un <PVPWonderfulEffectKeywords:Effetto meraviglioso> positivo oppure pesca 1 carta e ottieni 1 Arithmetica. L'ultima Offerta ha effetto 2 volte"
  },
  State_55807_Name = {
    Text = "Pesca 1 carta, ottieni 1 Arithmetica"
  },
  State_55808_Name = {
    Text = "<PoetryKeywords:Offerta>: Conferisci a tutti gli alleati un <PVPWonderfulEffectKeywords:Effetto meraviglioso> positivo oppure pesca 1 carta e ottieni 1 Arithmetica. L'ultima Offerta ha effetto 2 volte"
  },
  State_55809_Name = {
    Text = "Applica <PVPWonderfulEffectKeywords:Effetto meraviglioso> negativo a tutti i nemici"
  },
  State_55811_Desc = {
    Text = "Scegli un'opzione tra quelle elencate per attivarla."
  },
  State_55811_Name = {
    Text = "<ComaColour:Scelta>"
  },
  State_55813_Name = {
    Text = "<PoetryKeywords:Offerta>: Conferisci a tutti i nemici un <PVPWonderfulEffectKeywords:Effetto meraviglioso> negativo oppure pesca 1 carta e ottieni 1 Arithmetica. L'ultima Offerta ha effetto 2 volte"
  },
  State_55814_Name = {
    Text = "<PoetryKeywords:Offerta>: Conferisci a tutti i nemici un <PVPWonderfulEffectKeywords:Effetto meraviglioso> negativo oppure conferisci a tutti gli alleati un <PVPWonderfulEffectKeywords:Effetto meraviglioso> positivo. L'ultima Offerta ha effetto 2 volte"
  },
  State_55816_Name = {
    Text = "Applica <PVPWonderfulEffectKeywords:Effetto meraviglioso> positivo a tutti gli alleati"
  },
  State_55824_Desc = {
    Text = "Scegli un'opzione tra quelle elencate. Dopo la selezione, rimuovi l'opzione scelta. Se rimangono altre opzioni, colloca questa carta nella mano dell'avversario."
  },
  State_55824_Name = {
    Text = "<ComaColour:Offerta>"
  },
  State_55836_Desc = {
    Text = "Alla fine del turno, riduci di 1 il Costo di Arithmetica delle Carte di comando di Horla in mano."
  },
  State_55836_Name = {
    Text = "Sonetto Tinto d'Inchiostro"
  },
  State_55839_Desc = {
    Text = "Perdi tutte le altre reliquie al momento della raccolta. Ottieni casualmente 2 Reliquie Dorate."
  },
  State_55866_Desc = {
    Text = "Unico per Squadra: All'Inizio della Battaglia, pesca 1 Carta di comando del Portatore con una probabilità del <WeaponEffect_Num:[StateArg1]%> di ridurne il Costo di Arithmetica di 1. Ogni volta che la Resistenza viene attivata, questo Effetto si ripete una volta."
  },
  State_55866_WeaponDesc = {
    Text = "All'inizio della battaglia, pesca 1 Carta di comando del portatore e ha una probabilità del <WeaponEffect_Num:[StateArg1]%> di ridurne il Costo di Arithmetica di 1. Ogni volta che si attiva la Resistenza alla Morte, questo effetto si attiva nuovamente."
  },
  State_55992_Desc = {
    Text = "Quando l'Arithmetica è insufficiente, le carte verranno contrassegnate ed esaurite."
  },
  State_55992_Name = {Text = "Ceneri"},
  State_55993_Name = {
    Text = "Marchio di Brace"
  },
  State_56018_Desc = {
    Text = "I PV massimi aumentano del [Layer]% in questa battaglia."
  },
  State_56018_Name = {
    Text = "Benedizione di Muzus: Vita"
  },
  State_56020_Desc = {
    Text = "In questa battaglia, il Danno è aumentato del [Layer]%."
  },
  State_56020_Name = {
    Text = "Benedizione di Muzus: Forza"
  },
  State_56030_Desc = {
    Text = "Questo turno, lo Scudo del Personaggio e la Guarigione forniti dai Risvegliatori +[Layer]%."
  },
  State_56030_Name = {Text = "Neve"},
  State_56031_Desc = {
    Text = "Per ogni istanza di Danno inflitto in questo turno, Tasso critico temporaneo +[Layer]%."
  },
  State_56031_Name = {Text = "Farfalla"},
  State_56034_Desc = {
    Text = "Ogni tipo di \"Metafora\" può avere un massimo di 3 accumuli. Diverse \"Metafore\" potenzieranno effetti diversi dei Salmi: \n<D06CardKeyWordnu:Salmo del Ringhio>: Consuma tutte le Metafore \"Rabbia\", ogni accumulo di Metafora infligge 2 istanze di Danno aggiuntive. \n<D06CardKeyWordai:Salmo dell'Elegia>: Consuma tutte le Metafore \"Dolore\", ogni accumulo di Metafora fornisce Recupero PV aggiuntivo. \n<D06CardKeyWordxi:Poema Fantasmatico>: Consuma tutte le Metafore \"Felicità\", ogni accumulo di Metafora concede 10 Aliemus aggiuntivi. \n<D06CardKeyWordju:Poema Misterioso>: Consuma tutte le Metafore \"Paura\", ogni accumulo di Metafora concede <PowerIconKeywords:Potere> aggiuntivo."
  },
  State_56034_Name = {Text = "Metafora"},
  State_56208_Desc = {
    Text = [[
Elegia della Pioggia: Recupera <Heal:[DescArg1]> Vita.
Salmo del Vento: Ottieni [DescArg2] <PowerIconKeywords:Potere>.
Inno Floreale: Concede a tutti i Risvegliatori <Energy:10> Aliemus.
Inno della Luna: Tasso critico +30% in questo turno.]]
  },
  State_56208_Name = {
    Text = "Pagina di Poesia"
  },
  State_56330_Desc = {
    Text = "Ottieni [DescArg1] Scudo del Personaggio. Se sono state eseguite 3 azioni Esaltazione in questo turno, questa carta si attiverà 1 volta aggiuntiva."
  },
  State_56330_Name = {
    Text = "Immaginario Avanzato"
  },
  State_56331_Desc = {
    Text = "Scegli 1 Carta di comando dal Mazzo di pesca o dalla Pila degli scarti e aggiungila alla tua mano, poi riduci il suo Costo di Arithmetica di 2."
  },
  State_56331_Name = {
    Text = "Immaginario Avanzato"
  },
  State_56332_Desc = {
    Text = "Ottieni [DescArg1] <PowerIconKeywords:FOR> Temporanea. Dopo essere stata giocata, per ogni danno inflitto in questo turno, Tasso critico temporaneo +3%."
  },
  State_56332_Name = {
    Text = "Immaginario Avanzato"
  },
  State_56333_Desc = {
    Text = "Recupera il 10% degli HP persi. Se gli HP attuali sono inferiori al 25%, questa carta ha effetto un'ulteriore volta."
  },
  State_56333_Name = {
    Text = "Immaginario Avanzato"
  },
  State_56334_Desc = {
    Text = "La prossima Posse si attiva due volte."
  },
  State_56334_Name = {
    Text = "Immaginario Avanzato"
  },
  State_56335_Desc = {
    Text = "Infligge <FixedDamage:DAN Puro> pari al 150% della Salute massima, che beneficia di un bonus <PowerIconKeywords:STR> 10×."
  },
  State_56335_Name = {
    Text = "Immaginario Avanzato"
  },
  State_56336_Desc = {
    Text = "Pesca 5 carte."
  },
  State_56336_Name = {
    Text = "Immaginario Avanzato"
  },
  State_56337_Desc = {
    Text = "Ottieni [DescArg1] <AlertIconKeywords:Allerta> Temporanea. Dopo l'uso, lo Scudo del Personaggio e la Guarigione per questo turno sono aumentati del [DescArg2]%."
  },
  State_56337_Name = {
    Text = "Immaginario Avanzato"
  },
  State_56338_Desc = {
    Text = "Ottieni 3 Arithmetica."
  },
  State_56338_Name = {
    Text = "Immaginario Avanzato"
  },
  State_56339_Desc = {
    Text = "Rimuovi un debuff casuale. Questa carta si attiva 3 volte aggiuntive. Esaurimento."
  },
  State_56339_Name = {
    Text = "Immaginario Avanzato"
  },
  State_56340_Desc = {
    Text = "Infliggi <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici per 3 turni. Ogni volta che un nemico muore, sposta questa carta dal mazzo alla mano."
  },
  State_56340_Name = {
    Text = "Immaginario Avanzato"
  },
  State_56341_Desc = {
    Text = "Padronanza del Reame +25, Padronanza del Reame temporanea +125."
  },
  State_56341_Name = {
    Text = "Immaginario Avanzato"
  },
  State_56342_Desc = {
    Text = "Tutti i Risvegliatori ottengono 15 Aliemus."
  },
  State_56342_Name = {
    Text = "Immaginario Avanzato"
  },
  State_56343_Desc = {
    Text = "Infliggi <WeaknessIconKeywords:Debolezza> a tutti i nemici per 3 turni, colloca 1 copia di questa carta nella Pila degli scarti e applica <DepleteIconKeywords:Consumo>, <NothingnessIconKeywords:Effimero>."
  },
  State_56343_Name = {
    Text = "Immaginario Avanzato"
  },
  State_56372_Desc = {
    Text = "Alla morte, rimuovi l'ultimo debuff da te acquisito."
  },
  State_56372_Name = {
    Text = "Fiori e Poesia"
  },
  State_56400_Desc = {
    Text = "Dopo il \"Colpo\", cambia sequenzialmente le Abilità di questo Risvegliato In Mano in altre Abilità: [ShowIfState:, <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]."
  },
  State_56400_Name = {
    Text = "Fiori e Poesie d'un Tempo"
  },
  State_56402_Desc = {
    Text = "Possiedi la metafora <D06CardKeyWordnu:\"Rabbia\"> [DescArg2] <plural value=\"[DescArg2]\" singular=\"accumulo\" plural=\"accumuli\">: \"Salmo del Ringhio\" attiva il Salto e infligge Danno aggiuntivo.\nPossiedi la metafora <D06CardKeyWordai:\"Dolore\"> [DescArg3] <plural value=\"[DescArg3]\" singular=\"accumulo\" plural=\"accumuli\">: \"Salmo dell'Elegia\" attiva il Salto e ripristina Vita aggiuntiva.\nPossiedi la metafora <D06CardKeyWordxi:\"Felicità\"> [DescArg1] <plural value=\"[DescArg1]\" singular=\"accumulo\" plural=\"accumuli\">: \"Poema Fantasmatico\" attiva il Salto e concede Aliemus aggiuntivi al Risvegliatore selezionato.\nPossiedi la metafora <D06CardKeyWordju:\"Paura\"> [DescArg4] <plural value=\"[DescArg4]\" singular=\"accumulo\" plural=\"accumuli\">: \"Poema Misterioso\" attiva il Salto e concede Potere aggiuntivo."
  },
  State_56402_Name = {Text = "Metafora"},
  State_57166_Desc = {
    Text = "Chi esegue il Risveglio infligge il 25% di Danno in più."
  },
  State_57170_Desc = {
    Text = "Limite Mano +2. A fine turno, scegli 1 carta in mano da conservare e riduci il suo Costo di Arithmetica di 1 per 3 turni."
  },
  State_57170_Name = {
    Text = "Luce dei Perduti"
  },
  State_57316_Desc = {
    Text = "All'inizio di ogni turno, converte 1 \"Embrione\" in \"Rampollo della Purezza\"; se non sono presenti \"Embrioni\", la <EmbryoFusionIconKeywords:Fusione Embrionale> aumenta di +[Blood:DescArg1], senza essere influenzata dagli effetti di aumento della Fusione Embrionale. Sostenuto per [Layer] turni."
  },
  State_57316_Name = {
    Text = "Eredità delle Sacre Reliquie Perpetue"
  },
  State_57317_Desc = {
    Text = "Finché questa Ruota del destino è nel mazzo, puoi vedere le prossime modifiche alle tue abilità."
  },
  State_57317_Name = {
    Text = "<PVPFlowerKeywords:Fiori e Poesia dei Giorni Passati>"
  },
  State_57324_Desc = {
    Text = "Se questo Risvegliato attiva \"Fiori e Poesie d'un Tempo\", questa carta si trasforma in <CardKeyWord:<SkillName1:>>."
  },
  State_57324_Name = {
    Text = "Fiori e Poesie d'un Tempo"
  },
  State_57325_Desc = {
    Text = "Se questo Risvegliato attiva \"Fiori e Poesie d'un Tempo\", questa carta si trasforma in <CardKeyWord:<SkillName2:>>."
  },
  State_57325_Name = {
    Text = "Fiori e Poesie d'un Tempo"
  },
  State_57326_Desc = {
    Text = "Se questo Risvegliato attiva \"Fiori e Poesie d'un Tempo\", questa carta si trasforma in <CardKeyWord:<SkillName3:>>."
  },
  State_57326_Name = {
    Text = "Fiori e Poesie d'un Tempo"
  },
  State_57335_Name = {
    Text = "Il DAN di questa carta ottiene un potenziamento di Forza aggiuntivo di [DescArg1] volte."
  },
  State_57356_Name = {
    Text = "Stato@Calcolo Contrattacco Abissale"
  },
  State_57368_Name = {
    Text = "Stato@Salto Contrattacco Abissale"
  },
  State_57413_Name = {
    Text = "Ogni punto di Scudo del Personaggio aumenta il danno di questa carta di [DescArg1]"
  },
  State_57417_Desc = {
    Text = "Ogni volta che la Resistenza alla Morte si attiva, infliggi il 100% di Danno Fisso da contraccolpo. Ogni volta che la Resistenza alla Morte si attiva in questa battaglia, il Danno Fisso aumenta del 25%."
  },
  State_57417_Name = {
    Text = "Culla dell'Amore"
  },
  State_57566_Name = {
    Text = "Impasse Sopravvissuta"
  },
  State_57587_Desc = {
    Text = "Quando si gioca \"Divisione Ghiandolare\", pesca 1 carta, con [Layer] utilizzi rimanenti."
  },
  State_57587_Name = {
    Text = "Meduse, a Raccolta!"
  },
  State_57665_Name = {
    Text = "Protezione della madre divina"
  },
  State_57728_Desc = {
    Text = "Le istanze di Danno di Uvhash aumentate di 1."
  },
  State_57728_Name = {
    Text = "Dono del Sangue Impetuoso"
  },
  State_57751_Desc = {
    Text = "Unico per Squadra: Lo Scudo generato dal Portatore +<WeaponEffect_Num:[StateArg1]%>. Dopo aver rilasciato il Posse, tutti i Risvegliati ottengono un ulteriore <WeaponEffect_Num:[StateArg2]%> di Tasso critico temporaneo e Danno Crit., ma subiscono un Sacrificio del 3% dei PV massimi. Se il Reame corrente è \"Aequor\", rilasciare il Posse aumenterà anche il danno del Tentacolo del <WeaponEffect_Num:[StateArg3]%> dell'Attacco del Portatore."
  },
  State_57751_WeaponDesc = {
    Text = "Gli effetti di Generazione di Scudo del Personaggio causati dal Portatore aumentano del <WeaponEffect_Num:[StateArg1]%>. Dopo aver rilasciato il Seguito, tutti i Risvegliatori ottengono <WeaponEffect_Num:[StateArg2]%> di Tasso Critico Temporaneo e Danno Critico Temporaneo, ma ricevono [DescArg1] Sacrificio. Se il reame attuale è \"Aequor\", rilasciare un Seguito aumenta anche il DAN da Tentacolo di [DescArg2]."
  },
  State_57753_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Ottieni [StateArg1] accumuli di <PVPSleepKeywords:Sonno di Qualità> quando equipaggiata."
  },
  State_57753_Name = {
    Text = "Sonno Sotto il Ghiacciaio"
  },
  State_57766_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo la prima \"Esaltazione\" di ogni turno, ottieni <StrongEffectKeywords:Amplificazione> Temporanea +[StateArg1]."
  },
  State_57766_Name = {
    Text = "Bastone del Pastore"
  },
  State_57767_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: A fine turno, deduce <Energy:[Energy:StateArg1]> Aliemus e ottiene un <PVPDerivativeCardKeywords_12:\"Piccolo Desiderio\">. Se non c'è abbastanza Aliemus da dedurre, ottiene <Energy:[Energy:StateArg2]> Aliemus invece."
  },
  State_57767_Name = {
    Text = "Esecuzione Senza Fine"
  },
  State_57768_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Danno \"Abilità\" +[StateArg1]%. Recupera il [StateArg2]% degli HP persi dopo l'\"Esaltazione\"."
  },
  State_57768_Name = {
    Text = "Quando la Neve si Scioglie"
  },
  State_57769_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo che il Portatore gioca una carta abilità, pesca 1 carta abilità del Portatore. L'effetto può attivarsi solo una volta per turno."
  },
  State_57769_Name = {
    Text = "Portale della Verità"
  },
  State_57770_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Il Danno, la cura e l'Effetto Scudo causati dall'\"Abilità\" aumentano del [StateArg1]~[StateArg2]% (attualmente [Layer] %), <PhantomKeywords:Fantasma>."
  },
  State_57770_Name = {
    Text = "Roulette del Destino"
  },
  State_57814_Name = {
    Text = "Quando questo marcatore è presente, indica che una Ruota del destino è in fase di modifica. Alcune logiche richiedono questo marcatore per il riconoscimento."
  },
  State_57817_Desc = {
    Text = "Impossibilitato ad agire, accumuli -1 a fine turno. Quando gli accumuli sono esauriti, <StrongEffectKeywords:Amplificazione> +5, non può essere dissolto. Cambiare la Ruota del destino farà perdere lo stato Sonno di Qualità."
  },
  State_57817_Name = {
    Text = "Sonno di Qualità"
  },
  State_57854_Desc = {
    Text = "A inizio turno, ottieni [StateArg1] Scudo e [StateArg2] Danno Tentacolo, e genera 2 Tentacoli Temporanei della durata di [Layer] turni."
  },
  State_57854_Name = {
    Text = "Giuramento di Libertà"
  },
  State_57854_WeaponDesc = {
    Text = "Stato@Aequor Tè e Dolci della Dama"
  },
  State_57864_Name = {
    Text = "Aggiornamento Potenziamento Forza"
  },
  State_57942_Desc = {
    Text = "Tasso di fusione attuale [Layer]%. Quando raggiunge il 100%, il nemico entrerà forzatamente nella fase successiva e scatenerà abilità di transizione più potenti."
  },
  State_57942_Name = {
    Text = "Livello di Fusione"
  },
  State_57952_Desc = {
    Text = "Quando la Forza viene ridotta, solo il 50% degli accumuli di Forza viene ridotto."
  },
  State_57952_Name = {
    Text = "Immersione Profonda"
  },
  State_57953_Desc = {
    Text = "Alla fine del round, genera 1 Tentacolo. Lo stato viene rimosso al Risveglio."
  },
  State_57953_Name = {Text = "Sopore"},
  State_57955_Desc = {
    Text = "I DAN dell'Ilota aumentano del [StateArg1]%, per una durata di [Layer] turni."
  },
  State_57955_Name = {
    Text = "Impasse Sopravvissuta: Danno"
  },
  State_57968_Desc = {
    Text = "Sotto l'influenza di Juliette, l'indicatore di Fusione Gemellare aumenta del 10% alla fine di ogni turno e 1 carta \"Mutazione\" viene mischiata nel Mazzo di Pesca."
  },
  State_57968_Name = {
    Text = "\"Canto di Juliette\""
  },
  State_57970_Name = {
    Text = "Protezione della madre divina"
  },
  State_57976_Desc = {
    Text = "\"Figlio dell'Oscurità\" esegue una Fusione Forzata, infliggendo Danno Fisso pari a 3 volte i suoi PV attuali a \"Inizio Dimenticato\"."
  },
  State_57976_Name = {Text = "Sacrificio"},
  State_58051_Desc = {
    Text = "Danno Crit. +[Layer]%."
  },
  State_58051_Name = {
    Text = "Danno critico"
  },
  State_58052_Desc = {
    Text = "Per ogni punto di Sigillo Nero consumato durante l'esplorazione, il DAN Base di \"All-In\" aumenta dello 0,5%. (Aumentato del [DescArg1]%)"
  },
  State_58052_Name = {
    Text = "Guadagno sicuro"
  },
  State_58061_Name = {
    Text = "Restituzione Onesta"
  },
  State_58063_Desc = {
    Text = "Il Danno inflitto dal Risvegliato aumenta del 25% e dura per [Layer] turni."
  },
  State_58063_Name = {
    Text = "Sguardo Oltre gli Eoni"
  },
  State_58144_Desc = {
    Text = "Tasso di Crit. + [Layer]% in questo livello."
  },
  State_58144_Name = {
    Text = "Tasso di Crit. Permanente"
  },
  State_58144_WeaponDesc = {
    Text = "Tasso di Crit. + [Layer]% in questo livello."
  },
  State_58259_Desc = {
    Text = "Unico per Squadra: Aumenta il Tasso Crit. del Portatore del <WeaponEffect_Num:[StateArg1]%>. Si ottiene <WeaponEffect_Num:[StateArg2]> Sigillo Nero all'uccisione di un nemico, fino a 3 volte durante l'esplorazione. Dopo 3 attivazioni, il Tasso Crit. del Portatore aumenta permanentemente del <WeaponEffect_Num:[StateArg3]%> per il resto dell'esplorazione."
  },
  State_58259_WeaponDesc = {
    Text = "Tasso Crit. del portatore +<WeaponEffect_Num:[StateArg1]%>. Il portatore ottiene <WeaponEffect_Num:[DescArg2]> Sigilli Neri dopo aver ucciso un nemico, fino a 3 volte per esplorazione ([DescArg1]/3). Dopo 3 attivazioni, il portatore ottiene permanentemente +<WeaponEffect_Num:[StateArg3]%> Tasso Crit. per l'esplorazione in corso."
  },
  State_58297_Desc = {
    Text = "Quando Ryker uccide un nemico, ottiene [DescArg3] Sigilli Neri, con un massimo di 5 volte per esplorazione. ([DescArg1]/5)\nAcquisendo 75/150/300 Sigilli Neri in battaglia, aumenta la Capacità Reliquie di 1. Alla fine della battaglia, seleziona un'\"Eredità Caotica\" da aggiungere alla lista delle reliquie. (Già acquisiti [DescArg2] Sigilli Neri)"
  },
  State_58297_Name = {
    Text = "Il Vincitore Prende Tutto"
  },
  State_58447_Desc = {
    Text = [[
Include le seguenti tre reliquie:
"Mantello del Vento Fortunato": Aumenta il Tasso critico di tutti i Risvegliatori del 10%. Tutti i tiri di Ryker e dei dadi non risulteranno mai nel valore minimo.
<TentacleInjurieIconKeywords:Potenziamento>: L'aumento del Tasso critico diventa del 15%, e il valore massimo dei risultati casuali +1.
"Dadi Ottaedrici": Ogni volta che una Posse viene attivata, aggiungi 1 "<C05_yansheng1:Dadi Ottaedrici>" alla tua mano.
<TentacleInjurieIconKeywords:Potenziamento>: Cambia in aggiungi 1 "<C05_yansheng2:Dado Ottaedrico Brillante>" alla tua mano.
"Bottone Bocca Grande": All'inizio del turno e quando l'effetto casuale di Ryker o dei dadi si attiva, ottieni 50 Keyflare e 2% di Danno critico, fino a un massimo del 30% di Danno critico.
<TentacleInjurieIconKeywords:Potenziamento>: Cambia in ottieni 100 Keyflare e 4% di Danno critico, fino a un massimo del 50% di Danno critico.]]
  },
  State_58447_Name = {
    Text = "<CardKeyWord:Eredità del Caos>"
  },
  State_58490_Desc = {
    Text = "Quando tutta la Sonnolenza viene rimossa, tutti i Risvegliatori e le Carte verranno sigillati, e l'Intenzione del \"Sovrano Dormiente\" verrà modificata in \"Autorità del Monarca\"."
  },
  State_58490_Name = {Text = "Sonnolenza"},
  State_58491_Desc = {
    Text = "Rimuovi 1 strato di \"Sonnolenza\" ogni volta che viene giocata una carta. All'inizio del turno, ripristina a 12 strati di \"Sonnolenza\"."
  },
  State_58491_Name = {Text = "Furia"},
  State_58492_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_58492_Name = {
    Text = "Non Risvegliato"
  },
  State_58493_Desc = {
    Text = "Rimuovi 1 strato di \"Sonnolenza\" ogni volta che viene giocata una carta. All'inizio del turno, ripristina a 12 strati di \"Sonnolenza\"."
  },
  State_58493_Name = {Text = "Furia"},
  State_58947_Desc = {
    Text = "Tasso di Crit. + [Layer]% in questo livello."
  },
  State_59078_Name = {
    Text = ", può essere usato 1 volta"
  },
  State_59079_Name = {
    Text = ", può essere usato 2 volte"
  },
  State_59080_Name = {
    Text = ", può essere usato 3 volte"
  },
  State_59117_Desc = {
    Text = "Danno Crit. +[Layer]%."
  },
  State_59117_Name = {
    Text = "Danno critico"
  },
  State_59160_Desc = {
    Text = "Ogni accumulo aumenta del 10% tutti i danni, la guarigione e gli effetti di Scudo inflitti da \"Carte di comando\" ed \"Esaltazione\" in questa battaglia; non può essere dissolto."
  },
  State_59160_Name = {
    Text = "<CardKeyWord:Amplificazione>"
  },
  State_59161_Desc = {
    Text = "Carta di comando ed Esaltazione Danno, Guarigione, Scudo +[DescArg1]%, non può essere dissolto."
  },
  State_59161_Name = {
    Text = "Amplificazione"
  },
  State_59169_Desc = {
    Text = "Il Costo di Arithmetica base di questa carta non supererà il Limite di Arithmetica."
  },
  State_59169_Name = {Text = "Equilibrio"},
  State_59173_Name = {
    Text = "Quando questo marcatore è presente, indica che sono in corso Colpi multipli, e i Colpi multipli non verranno attivati nuovamente."
  },
  State_59208_Desc = {
    Text = "Ogni accumulo riduce del 10% tutti i danni, la guarigione e gli effetti di Scudo causati da \"Carte di comando\" ed \"Esaltazione\" in questa battaglia; non può essere dissolto."
  },
  State_59208_Name = {
    Text = "<WeaknessColour:Amplificazione▼>"
  },
  State_59209_Desc = {
    Text = "Carta di comando ed Esaltazione Danno, Guarigione, Scudo -[DescArg1]%, non può essere dissolto."
  },
  State_59209_Name = {
    Text = "Amplificazione▼"
  },
  State_59423_Desc = {
    Text = "Quando Ryker uccide un nemico, ottiene 5 Sigilli Neri. Per ogni 1% di Bottino di Sigilli di Ryker, la quantità ottenuta +1%, con un massimo di 5 attivazioni per esplorazione.\nAcquisendo 75/150/300 Sigilli Neri in battaglia, aumenta la Capacità Reliquie di 1. Alla fine della battaglia, scegli un'\"Eredità Caotica\" da aggiungere alla lista delle reliquie."
  },
  State_59423_Name = {
    Text = "Il Vincitore Prende Tutto"
  },
  State_59424_Desc = {
    Text = "Per ogni punto di Sigillo Nero consumato durante l'esplorazione, il DAN Base di \"All-In\" aumenta dello 0,5%."
  },
  State_59424_Name = {
    Text = "Guadagno sicuro"
  },
  State_59439_Desc = {
    Text = "Questo Stato utilizza il moltiplicatore Vulnerabile, fungendo da moltiplicatore indipendente."
  },
  State_59439_Name = {
    Text = "Se possiedi un determinato Stato, subisci Danno doppio"
  },
  State_59519_Name = {
    Text = "Scegli 1 Carta di comando dal Mazzo di Pesca o dalla Pila degli scarti e aggiungila alla tua mano, impostando il suo Costo di Arithmetica a 0."
  },
  State_59520_Desc = {
    Text = "All'utilizzo, pesca 2 carte, riducendo il loro Costo di Arithmetica di un importo pari al Costo di Arithmetica della carta in Orazione. Ha effetto una volta per battaglia."
  },
  State_59520_Name = {
    Text = "<WhiteQuality:Lex Nous>"
  },
  State_59521_Name = {
    Text = "Perdi il 10% degli HP attuali ([DescArg1])"
  },
  State_59522_Desc = {
    Text = "All'utilizzo, scarta tutte le carte In Mano che non appartengono a questo Risvegliatore. Ottieni 5 carte non di comando. Ha effetto una volta per battaglia."
  },
  State_59522_Name = {
    Text = "<WhiteQuality:Lex Volis>"
  },
  State_59525_Name = {
    Text = "Il proprietario di questa Carta di comando ottiene 50 Aliemus."
  },
  State_59526_Desc = {
    Text = "Dopo averla giocata, ottieni 3 Copie Base con <RetainIconKeywords:Conservare> e <DepleteIconKeywords:Consumo> applicati. Ha effetto una volta per battaglia."
  },
  State_59526_Name = {
    Text = "<WhiteQuality:Lex Genis>"
  },
  State_59534_Name = {
    Text = "Quando questo marcatore è presente, indica che a questa carta è proibito attivare il Fantasma."
  },
  State_59560_Name = {
    Text = "Scegli una carta che ha ricevuto le Orazioni dei Tre Eoni da aggiungere alla tua mano."
  },
  State_59671_Desc = {
    Text = "Tutti i Risvegliati infliggono il 15% in più di Danno Finale in questo turno."
  },
  State_59671_Name = {
    Text = "Orologio a Supercorde"
  },
  State_59673_Name = {
    Text = "Piccolo carillon"
  },
  State_59678_Desc = {
    Text = "Perdi tutte le altre reliquie al momento della raccolta. Ottieni casualmente 2 Reliquie Dorate."
  },
  State_59878_Desc = {
    Text = "A fine turno, riduce inoltre 1 accumulo di \"Caos\" e ottiene [StateArg1] <PowerIconKeywords:FOR>. I cloni di \"N\" evocati successivamente avranno la Vita aumentata del 200%, e la loro morte non causerà più la riduzione degli accumuli di \"Caos\" di \"N\" né l'ottenimento di <PowerIconKeywords:FOR>."
  },
  State_59878_Name = {
    Text = "Avvento del Caos"
  },
  State_59991_Name = {
    Text = ", questa carta consuma fino a 5 accumuli di <EnergyStorageKeywords:Carica> quando viene giocata"
  },
  State_59993_Name = {
    Text = "Recupera il 10% degli HP persi ([DescArg1])"
  },
  State_60000_Desc = {
    Text = "Ottieni 1 accumulo di <MadnessIconKeywords:Follia> Temporanea quando subisci Danno Attivo."
  },
  State_60000_Name = {
    Text = "Furia crescente"
  },
  State_60028_Desc = {
    Text = "A inizio turno, il Costo di Arithmetica di una carta casuale viene impostato a 3. Alla morte, rimuovi questo effetto e riduci di 1 il Costo di Arithmetica delle carte dell'uccisore per quel turno."
  },
  State_60028_Name = {
    Text = "Gabbia del Delirium"
  },
  State_60044_Name = {
    Text = "\"Si consuma dopo [Layer] utilizzi\""
  },
  State_60083_Desc = {
    Text = "Danni subiti in questo turno -[Layer]%."
  },
  State_60083_Name = {
    Text = "<ReinforceColour:Fortezza>"
  },
  State_60083_WeaponDesc = {
    Text = "Riduce tutti i danni inflitti del [DescArg1]%."
  },
  State_60085_Desc = {
    Text = "Ottieni Fortezza Temporanea a inizio Battaglia e a ogni turno. Più alti sono i tuoi HP, più accumuli ottieni, fino a 50."
  },
  State_60085_Name = {
    Text = "Crisalide Suprema"
  },
  State_60085_WeaponDesc = {
    Text = "Riduce tutti i danni inflitti del [DescArg1]%."
  },
  State_60086_Desc = {
    Text = "Ottieni Fortezza Temporanea a inizio Battaglia e a ogni turno. Più alti sono i tuoi HP, più accumuli ottieni, fino a 25."
  },
  State_60086_Name = {
    Text = "Crisalidazione"
  },
  State_60086_WeaponDesc = {
    Text = "Riduce tutti i danni inflitti del [DescArg1]%."
  },
  State_60087_Desc = {
    Text = "L'effetto Flagello causato riduce il [Layer]% della Rigenerazione PV."
  },
  State_60087_Name = {
    Text = "<Rune_14_High:Amplificazione del Flagello>"
  },
  State_60087_WeaponDesc = {
    Text = "Riduce tutti i danni inflitti del [DescArg1]%."
  },
  State_60088_Desc = {
    Text = "Ogni accumulo riduce i danni subiti dell'1%."
  },
  State_60088_Name = {
    Text = "<ReinforcePVEKeywords:Fortezza>"
  },
  State_60088_WeaponDesc = {
    Text = "Tutti gli Scudi del Personaggio ottenuti sono ridotti del 25%."
  },
  State_60089_Desc = {
    Text = "Danni subiti -[Layer]%."
  },
  State_60089_Name = {
    Text = "<ReinforceColour:Fortezza>"
  },
  State_60089_WeaponDesc = {
    Text = "Riduce tutti i danni inflitti del [DescArg1]%."
  },
  State_60106_Desc = {
    Text = "All'inizio del turno, il Costo di Arithmetica di una carta casuale in mano cambia a 3 e si ripristina a fine turno."
  },
  State_60106_Name = {
    Text = "Gabbia del Delirium"
  },
  State_60112_Desc = {
    Text = "Tutti i Risvegliati ottengono 1 punto di Aliemus per ogni Carta di comando giocata in questo turno."
  },
  State_60112_Name = {Text = "Concerto"},
  State_60115_Desc = {
    Text = "Dopo aver rilasciato l'Esaltazione in questo turno, il tasso di Fusione Gemellare diminuisce del 3%."
  },
  State_60115_Name = {Text = "Requiem"},
  State_60118_Desc = {
    Text = "Danno, Veleno e Contatore di questo turno +[Layer]%."
  },
  State_60118_Name = {Text = "Rapsodia"},
  State_60128_Desc = {
    Text = "Modifica l'Arithmetica della carta prima di giocarla"
  },
  State_60128_WeaponDesc = {
    Text = "Modifica l'Arithmetica della carta prima di giocarla"
  },
  State_60129_Desc = {
    Text = "Le prossime [Layer] Carte Comando Non-Derivate che giochi hanno -2 al Costo di Arithmetica."
  },
  State_60129_Name = {
    Text = "Scala Discendente"
  },
  State_60130_Desc = {
    Text = "La prossima [Layer] Carta Comando Non-Derivata che giochi ha +2 al Costo di Arithmetica e ha effetto 2 volte."
  },
  State_60130_Name = {
    Text = "Scala Ascendente"
  },
  State_60148_Desc = {
    Text = "A fine turno, ottieni effetti diversi in base allo stato: Rilascio - Ottieni 1 accumulo di <MadnessIconKeywords:Follia> Temporanea. Contenimento - Ottieni 50 accumuli di <ReinforcePVEKeywords:Fortezza> Temporanea."
  },
  State_60148_Name = {
    Text = "Adattamento dei Parametri"
  },
  State_60150_Desc = {
    Text = "Alterna tra le modalità \"Scatenare\" e \"Raccogliere\" ogni volta che usi un Seguito. Ottieni [StateArg1] FOR temporanea quando passi a Scatenare, e ottieni [StateArg2] Scudo quando passi a Raccogliere."
  },
  State_60150_Name = {
    Text = "Percezione Funzionale"
  },
  State_60151_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_60151_Name = {
    Text = "Non Risvegliato"
  },
  State_60154_Desc = {
    Text = "Attualmente in Modalità Raccogliere. L'Armamento Meccanico ottiene Scudo e Allerta, con intenzioni concentrate sulla difesa."
  },
  State_60154_Name = {
    Text = "Ritirare: Mecha"
  },
  State_60155_Desc = {
    Text = "Attualmente in Modalità Scatenare. L'Armamento Meccanico ottiene FOR extra, con intenzioni concentrate sull'offensiva."
  },
  State_60155_Name = {
    Text = "Scatenare: Mecha"
  },
  State_60167_Desc = {
    Text = "Modifica l'Arithmetica della carta prima di giocarla"
  },
  State_60167_WeaponDesc = {
    Text = "Modifica l'Arithmetica della carta prima di giocarla"
  },
  State_60184_Desc = {
    Text = "Ogni volta che viene giocata una carta, i \"Gemelli della Contraddizione\" cambiano la loro Intenzione."
  },
  State_60184_Name = {Text = "Paradosso"},
  State_60187_Desc = {
    Text = "Infligge stati di Debolezza, Fragile e Flagello al 50%."
  },
  State_60187_Name = {
    Text = "La Fine è l'Inizio"
  },
  State_60201_Name = {
    Text = "Forza Ritardata del Mostro"
  },
  State_60263_Desc = {
    Text = "L'effetto Fragile applicato viene modificato per ridurre la generazione di Scudo del Personaggio del [Layer]%."
  },
  State_60263_Name = {
    Text = "<Rune_14_High:Amplificazione della Fragilità>"
  },
  State_60264_Desc = {
    Text = "Gli effetti di Salasso inflitti verranno rimossi automaticamente solo del 50% alla fine di ogni turno."
  },
  State_60264_Name = {
    Text = "<Rune_14_High:Emolisi>"
  },
  State_60265_Desc = {
    Text = "\"L'effetto Salasso rimuove solo il 50% a fine turno.\""
  },
  State_60265_Name = {
    Text = "<BleedingColour:Emolisi>"
  },
  State_60279_Name = {
    Text = "Questa carta verrà consumata alla fine del turno."
  },
  State_60284_Desc = {
    Text = "Ottieni Fortezza Temporanea a inizio Battaglia e a ogni turno; più bassi sono i tuoi HP, più accumuli ottieni, fino a 50."
  },
  State_60284_Name = {
    Text = "Formazione di spade infrangibile"
  },
  State_60284_WeaponDesc = {
    Text = "Riduce tutti i danni inflitti del [DescArg1]%."
  },
  State_60297_Desc = {
    Text = "\"@2\" discende nella sua vera forma, gli HP diventano 3x. Ogni turno, pone una Domanda al Custode, aggiungendo una carta \"Rispondi a Tawil\" alla mano."
  },
  State_60297_Name = {
    Text = "Indagine della Verità"
  },
  State_60297_WeaponDesc = {
    Text = "A inizio del turno successivo, ottieni Scudo del Personaggio pari alla quantità di HP persi nel turno precedente."
  },
  State_60298_Desc = {
    Text = "Questa entità sconosciuta si cela ancora sotto la Pozza nera. Si risveglierà completamente e rinascerà in prossimità della sconfitta, pronta a combattere nella sua forma liberata."
  },
  State_60298_Name = {Text = "Dormienza"},
  State_60312_Desc = {
    Text = "Ogni turno, quando il Danno accumulato raggiunge il 10% dei PV, ottieni [Layer] accumuli di \"Fortezza\" Temporanea."
  },
  State_60312_Name = {
    Text = "Scudo di Nebbia Dissolutiva"
  },
  State_60315_Desc = {
    Text = "Dopo aver rilasciato Esaltazione in questo turno, recupera il 5% degli HP persi ([DescArg1])."
  },
  State_60315_Name = {Text = "Requiem"},
  State_60336_Name = {
    Text = "Ottieni 1 Arithmetica e pesca 1 carta, ma questa carta sarà Esaurita."
  },
  State_60339_Name = {
    Text = "Ottieni 1 Arithmetica e pesca 1 carta dopo aver giocato in questo turno, ma questa carta verrà esaurita"
  },
  State_60367_Desc = {
    Text = "A inizio turno, il Costo di Arithmetica di una carta casuale viene impostato a 3. Alla morte, rimuovi questo effetto e riduci di 1 il Costo di Arithmetica delle carte dell'uccisore per quel turno."
  },
  State_60367_Name = {
    Text = "Gabbia del Delirium"
  },
  State_60386_Desc = {
    Text = "Effetti: Sanguinamento (150% DAN), Veleno (75% DAN), applica 1 Debolezza, applica 1 Vulnerabile, FOR temp. -[DescArg1]."
  },
  State_60386_Name = {
    Text = "<MysterydebuffKeywords:Debuff meraviglioso>"
  },
  State_60404_Desc = {
    Text = "Ottieni 2 accumuli di Rinforzo temporaneo ogni volta che subisci 1 Danno."
  },
  State_60404_Name = {
    Text = "Trasformazione Finale"
  },
  State_60408_Desc = {
    Text = "Quando i PV scendono al 33% ([DescArg1] mancanti), in questo turno non si subiranno DAN e si scatenerà \"Morso Spettrale\"."
  },
  State_60408_Name = {
    Text = "Morso Spettrale"
  },
  State_60409_Desc = {
    Text = "Quando i PV scendono al 66% ([DescArg1] mancanti), in questo turno non si subiranno DAN e si scatenerà \"Trasformazione Finale\"."
  },
  State_60409_Name = {
    Text = "Specchio della Fine"
  },
  State_60429_Name = {
    Text = "Stato@Risvegliatore Hameln@Melodia Primordiale"
  },
  State_60430_Desc = {
    Text = "Giocando una carta il cui Costo di Arithmetica effettivo corrisponde all'Intenzione mostrata, la esaurisce e riduce la FOR temporanea di tutti i nemici di [DescArg1]."
  },
  State_60430_Name = {
    Text = "Comando di Nota"
  },
  State_60431_Name = {
    Text = "Stato@Risvegliatore Hameln@Tono Ascendente"
  },
  State_60432_Name = {
    Text = "Stato@Risvegliatore Hameln@Ouverture dell'Anima"
  },
  State_60433_Name = {
    Text = "Stato@Risvegliatore Hameln@Tono Discendente"
  },
  State_60434_Name = {
    Text = "Stato@Risvegliatore Hameln@Rondò dei Ricordi"
  },
  State_60435_Name = {
    Text = "Stato@Risvegliatore Hameln@Contrattacco Preludio dell'Anima"
  },
  State_60436_Desc = {
    Text = "Quando si infligge Danno non bloccato, mischia [StateArg1] \"Ferita\" nel Mazzo di Pesca."
  },
  State_60436_Name = {
    Text = "Ouverture dell'Anima"
  },
  State_60438_Name = {
    Text = "Stato@Risvegliatore Hameln@Monitor Tono Ascendente"
  },
  State_60439_Name = {
    Text = "Stato@Risvegliatore Hameln@Monitor Tono Discendente"
  },
  State_60440_Name = {
    Text = "Stato@Risvegliatore Hameln@Ascoltatore Preludio dell'Anima"
  },
  State_60441_Name = {
    Text = "Stato@Risvegliatore Hameln@Ascoltatore Rondò dei Ricordi"
  },
  State_60442_Name = {
    Text = "Stato@Risvegliatore Hameln@Monitor Melodia Primordiale"
  },
  State_60486_Desc = {
    Text = "All'Inizio della Battaglia, l'Aliemus di tutti i Risvegliatori è ridotto della metà."
  },
  State_60486_Name = {
    Text = "Assorbimento della Dea Madre"
  },
  State_60487_Desc = {
    Text = "Questo Risvegliatore non è ancora Non Risvegliato... Si Risveglierà quando starà per essere sconfitto, con PV Massimi +200%, e combatterà con tutta la sua potenza."
  },
  State_60487_Name = {
    Text = "Non Risvegliato"
  },
  State_60490_Desc = {
    Text = "Alla morte, tutti i Risvegliati ottengono 30 Aliemus."
  },
  State_60490_Name = {
    Text = "Volontà di Vivere"
  },
  State_60491_Desc = {
    Text = "Riduce l'Aliemus causato da tutti i Risvegliati del 50%."
  },
  State_60491_Name = {
    Text = "Cerimonia dell'Albero Madre"
  },
  State_60493_Desc = {
    Text = "Per ogni [Layer] HP persi, evoca un Risvegliatore Mimetico. Se ci sono già 2 Risvegliatori Mimetici in campo, aumenta gli HP massimi di tutti i Risvegliatori Mimetici del 50%."
  },
  State_60493_Name = {
    Text = "Madre Nutrice"
  },
  State_60500_Desc = {
    Text = "Se è presente un Risvegliatore con Mimetismo, ottieni 50 accumuli di \"Occultare\"."
  },
  State_60500_Name = {
    Text = "Nascosto nel Bosco"
  },
  State_60511_Desc = {
    Text = "Appare sempre nella mano iniziale."
  },
  State_60511_Name = {
    Text = "<GuyouKeywords:Innato>"
  },
  State_60511_WeaponDesc = {
    Text = "Dopo essere stata giocata, la carta non finirà nella Pila degli scarti e non potrà essere usata di nuovo in questa Battaglia."
  },
  State_60522_Desc = {
    Text = "Aumenta gli effetti di Fragile e Flagello al 50%."
  },
  State_60522_Name = {
    Text = "Distruzione"
  },
  State_60523_Desc = {
    Text = "Ogni accumulo aumenta il conteggio degli attacchi di 1. Perdi 1 accumulo quando subisci Danno, e perdi tutti gli accumuli alla fine del turno."
  },
  State_60523_Name = {Text = "Preghiera"},
  State_60524_Desc = {
    Text = "Ottieni [Layer] accumuli di Fortezza all'inizio della battaglia e all'inizio del turno, fino a un massimo di 50 accumuli."
  },
  State_60524_Name = {
    Text = "Santificazione"
  },
  State_60524_WeaponDesc = {
    Text = "Riduce tutti i danni inflitti del [DescArg1]%."
  },
  State_60527_Desc = {
    Text = "Quando giocata, Esaurimento, riduce la FOR temporanea dei nemici."
  },
  State_60527_Name = {
    Text = "<CardKeyWord:Coro del Paradiso>"
  },
  State_60543_Desc = {
    Text = "A fine turno, ottieni 10 accumuli di \"Giuramento di Sangue\"; \"Giuramento di Sangue\" rimuove 1 accumulo dopo aver subito Danno."
  },
  State_60543_Name = {
    Text = "Fiamma dello Stoppino"
  },
  State_60554_Name = {
    Text = "<HuihuanbKeywords:Rondino>"
  },
  State_60558_Name = {
    Text = "<HuihuanbKeywords:Rondino>"
  },
  State_60562_Desc = {
    Text = "Quando giocata, ha Effetto 2 volte e cambia in \"Crescendo\""
  },
  State_60562_Name = {
    Text = "<HuihuanaKeywords:Rondino>"
  },
  State_60564_Desc = {
    Text = "Quando sta per essere sconfitto per la prima volta, recupera PV e cambia intenzione in \"Evoluzione Finale\", ottenendo Forza e rinforzo. Quando sta per essere sconfitto per la seconda volta, recupera PV e cambia intenzione in \"Morso Spettrale\", infliggendo DAN singolo estremamente elevato."
  },
  State_60564_Name = {
    Text = "Demone d'Ombra"
  },
  State_60567_Desc = {
    Text = "Gioca questa carta per concedere a Hameln 3 Aliemus."
  },
  State_60567_Name = {
    Text = "<XushiAKeywords:Crescendo>"
  },
  State_60568_Name = {
    Text = "<XushiAKeywords:Crescendo>"
  },
  State_60569_Name = {
    Text = "<XushiBKeywords:Crescendo>"
  },
  State_60570_Desc = {
    Text = "Gioca questa carta per concedere a Hameln 3 Aliemus."
  },
  State_60570_Name = {
    Text = "<XushiBKeywords:Crescendo>"
  },
  State_60571_Name = {
    Text = "<HuihuanaKeywords:Rondino>"
  },
  State_60576_Desc = {
    Text = "A inizio turno, il Costo di Arithmetica di una carta casuale viene impostato a 3. Alla morte, rimuovi questo effetto e riduci di 1 il Costo di Arithmetica delle carte dell'uccisore per quel turno."
  },
  State_60576_Name = {
    Text = "Gabbia del Delirium"
  },
  State_60578_Desc = {
    Text = "Rianimazione al 50% dei PV dopo danno fatale, Immune ai danni per 1 turno, l'Intenzione cambia in \"Rottura della Crisalide\"."
  },
  State_60578_Name = {
    Text = "Rottura della Crisalide"
  },
  State_60592_Desc = {
    Text = [[
All'inizio dell'esplorazione, aggiungi 1 "Aurora della Chiave d'Argento" con <DestructionKeywords:Distruggere> al mazzo.
Ogni volta che la Posse viene scatenata, il DAN crit. del portatore +<WeaponEffect_Num:[StateArg1]%>.
Ogni volta che il portatore infligge un Danno attivo, il suo Tasso critico +<WeaponEffect_Num:[StateArg3]%> in questo turno e si ottiene Keyflare pari al <WeaponEffect_Num:[StateArg2]%> della sua Ricarica della chiave d'argento, fino a 5 volte per turno.]]
  },
  State_60592_WeaponDesc = {
    Text = [[
All'inizio dell'esplorazione, aggiungi 1 "Aurora della Chiave d'Argento" con <DestructionKeywords:Distruggere> al mazzo.
Ogni volta che la Posse viene scatenata, il DAN crit. del portatore +<WeaponEffect_Num:[StateArg1]%>.
Ogni volta che il portatore infligge un Danno attivo, il suo Tasso critico temporaneo +<WeaponEffect_Num:[StateArg3]%> e si ottengono <WeaponEffect_Num:[DescArg1]> Keyflare, fino a 5 volte per turno.]]
  },
  State_60594_Desc = {
    Text = "Unico per Squadra: Alla fine del turno, il Portatore ottiene 5 Aliemus. Dopo che il Portatore rilascia l'Esaltazione, la prossima Carta di comando giocata dal Portatore in questo turno aumenta il suo Tasso Crit., Danno Crit., Scudo del Personaggio e recupero salute del <WeaponEffect_Num:[StateArg1]%>."
  },
  State_60594_WeaponDesc = {
    Text = "A fine turno, il portatore ottiene 5 Aliemus. Dopo aver attivato l'Esaltazione, la prossima Carta di comando giocata dal portatore in questo turno aumenta Tasso Crit., Danno Crit., Scudo e Recupero PV del <WeaponEffect_Num:[StateArg1]%>."
  },
  State_60898_Desc = {
    Text = "Quando si subiscono Danni Attivi e da Tentacolo, sigilla l'Esaltazione e le Carte di Comando del Risvegliatore attaccante per 1 turno, rimuovi 1 accumulo di <ResentChainsKeywords:Catene del Risentimento>."
  },
  State_60898_Name = {
    Text = "<ResentChainsKeywords1:Catene del Risentimento>"
  },
  State_60925_Desc = {
    Text = "A fine turno, recupera il 5% degli HP persi. Ogni volta che peschi una carta Sintomo o Carta di stato, tutti gli alleati ottengono [Layer] FOR."
  },
  State_60925_Name = {
    Text = "Lume di Sangue"
  },
  State_60926_Desc = {
    Text = "A fine turno, se i PV attuali sono inferiori al 50%, ottieni [Layer] FOR e [StateArg1] cariche di Barriera."
  },
  State_60926_Name = {
    Text = "Altare della Lanterna"
  },
  State_60953_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Prima dell'\"Esaltazione\", infliggi [StateArg1] accumuli di <PVPSlowKeywords:Stagnazione> a tutti i bersagli nemici."
  },
  State_60953_Name = {
    Text = "Requiem Eterno"
  },
  State_60962_Desc = {
    Text = "I PV massimi aumentano del [Layer]% in questa battaglia."
  },
  State_60962_Name = {Text = "Aumento PV"},
  State_60964_Desc = {
    Text = "In questa battaglia, il Danno è aumentato del [Layer]%."
  },
  State_60964_Name = {
    Text = "Aumento Danno"
  },
  State_61038_Name = {
    Text = "Prova di Hameln"
  },
  State_61050_Desc = {
    Text = "Dopo aver attivato l'effetto \"Melodia\" o aver giocato la \"Sinfonia dell'Armonia\", Hameln ottiene l'1% di Prob. Crit. e Danno Crit. (Attualmente ottenuto: [DescArg1]%). Ogni 10 attivazioni, il numero di istanze di DAN di \"Ouverture dell'Anima\" e \"Accordo Primordiale\" +1 in questa battaglia, fino a un massimo di 3 volte."
  },
  State_61050_Name = {
    Text = "Rapsodia al chiaro di luna"
  },
  State_61051_Desc = {
    Text = "Dopo aver attivato l'effetto \"Melodia\" o aver giocato la \"Sinfonia dell'Armonia\", Hameln ottiene 1% di Tasso Crit. e Danno Crit. Ogni 10 attivazioni, il numero di istanze di DAN di \"Ouverture dell'Anima\" e \"Accordo Primordiale\" +1 in questa Battaglia, fino a un massimo di 3 volte."
  },
  State_61051_Name = {
    Text = "Rapsodia al chiaro di luna"
  },
  State_61056_Desc = {
    Text = "Ottieni 100 FOR temporanea al primo turno."
  },
  State_61056_Name = {Text = "Furia"},
  State_61084_Desc = {
    Text = "Questo turno ha giocato [Layer] carte: se il Costo di Arithmetica è maggiore o uguale a 3, ottieni 2 Arithmetica; altrimenti pesca 2 carte."
  },
  State_61084_Name = {
    Text = "Sinfonia Quarta"
  },
  State_61085_Desc = {
    Text = "Costo di Arithmetica -2, ha Effetto 2 volte, poi cambia in \"Crescendo\""
  },
  State_61085_Name = {
    Text = "<HuihuanbKeywords:Rondino>"
  },
  State_61089_Desc = {
    Text = "La prossima Carta di comando giocata avrà effetto due volte."
  },
  State_61089_Name = {
    Text = "Bacchetta del Direttore"
  },
  State_61145_Name = {
    Text = "<BleedingColour:Salasso>"
  },
  State_61174_Desc = {
    Text = "Impossibile ottenere Scudo del Personaggio."
  },
  State_61174_Name = {
    Text = "Requiem dei Residui"
  },
  State_61180_Desc = {
    Text = "Il DAN Base di Helot: Catena in questa battaglia è aumentato del [DescArg1]%."
  },
  State_61180_Name = {
    Text = "Lama della Vendetta"
  },
  State_61185_Desc = {
    Text = "Amplifica le abilità del nemico. Il nemico perde 1 carica quando subisce DAN."
  },
  State_61185_Name = {
    Text = "Giuramento di Sangue"
  },
  State_62213_Desc = {
    Text = "Cambia l'effetto Sintomo: Debolezza per ridurre i Danni attivi e Danni da tentacolo inflitti del [Layer]%."
  },
  State_62213_Name = {
    Text = "<Rune_14_High:Amplificazione della Debolezza>"
  },
  State_62309_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: All'equipaggiamento ottieni [StateArg1] <StrongEffectKeywords:Forte>. Ogni volta che perdi Vita, se la Vita attuale è inferiore al [StateArg2]%, ottieni <ReinforceKeywords:Rinforzato> e <StrengthenKeywords:Potenziare>."
  },
  State_62309_Name = {
    Text = "Annegare nel Cremisi"
  },
  State_62317_Desc = {
    Text = "Immune a tutti i Danni. Rimosso a inizio turno."
  },
  State_62317_Name = {
    Text = "Immunità ai DAN"
  },
  State_62336_Desc = {
    Text = "Dopo aver giocato 3 carte (con [Layer] carte rimanenti), pesca 1 carta e congela casualmente 1 Carta di comando in mano."
  },
  State_62336_Name = {
    Text = "Gelo dell'Inverno"
  },
  State_62337_Desc = {
    Text = "Dopo aver giocato 3 carte (con [Layer] carte rimanenti), pesca 1 carta e congela casualmente 1 Carta di comando in mano."
  },
  State_62337_Name = {
    Text = "Gelo dell'Inverno"
  },
  State_62338_Desc = {
    Text = "Questa carta non può essere giocata, non verrà scartata a fine turno e conferisce al Risvegliato associato 5 Aliemus. Si scongela dopo che il Risvegliato rilascia l'Esaltazione."
  },
  State_62338_Name = {
    Text = "<CardKeyWord:Congelamento>"
  },
  State_65332_Desc = {
    Text = "Alla morte, tutti i Risvegliati ottengono 30 Aliemus."
  },
  State_65332_Name = {
    Text = "Dissoluzione"
  },
  State_65342_Desc = {
    Text = "Alla sconfitta, risorge con un ulteriore 100% di HP massimi e scatena \"Gelo che Penetra le Ossa\"."
  },
  State_65342_Name = {Text = "Silenzio"},
  State_65346_Desc = {
    Text = "Alla morte, congela 2 Carte di comando nella mano."
  },
  State_65346_Name = {
    Text = "Caduta di Brina"
  },
  State_65358_Desc = {
    Text = "Unico per Squadra: Il DAN Base del Portatore aumenta del <WeaponEffect_Num:[StateArg1]%>. Prima di Exalt, dimensione mano Temporaneo +1, pesca 1 Carta di comando. Nel reame \"Caro\", attivare Divorare aumenta temporaneamente il Danno Crit. del <WeaponEffect_Num:[StateArg1]%>, una volta per turno"
  },
  State_65358_WeaponDesc = {
    Text = "Il DAN Base del Portatore aumenta del <WeaponEffect_Num:[StateArg1]%>. Prima di rilasciare l'Esaltazione, il limite temporaneo di carte in mano del Portatore aumenta di 1, e pesca 1 Carta di Comando del Portatore. Se il reame attuale è \"Caro\", quando il Portatore attiva Divorare, il suo Danno Critico Temporaneo aumenta del <WeaponEffect_Num:[StateArg1]%>, con l'effetto attivabile una volta per turno."
  },
  State_65360_Desc = {
    Text = "Unico per Squadra: Il DAN Base del Portatore aumenta del <WeaponEffect_Num:[StateArg1]%>. All'inizio della Battaglia, il Portatore ottiene 25 accumuli di \"Neve\". Giocare una carta concede 2 Aliemus e rimuove 1 accumulo. Una volta rimossi tutti gli accumuli di \"Neve\", il Portatore ottiene <WeaponEffect_Num:[StateArg2]%> Prob. Crit."
  },
  State_65360_WeaponDesc = {
    Text = "Il DAN Base del portatore aumenta del <WeaponEffect_Num:[StateArg1]%>. All'inizio della battaglia, il portatore ottiene 25 cariche di \"Neve\", guadagnando 2 Aliemus e rimuovendo 1 carica dopo aver giocato una carta. Dopo che \"Neve\" è stata completamente rimossa, il portatore ottiene <WeaponEffect_Num:[StateArg2]%> di Tasso Crit. (attualmente [DescArg1] cariche di Neve rimanenti)."
  },
  State_65362_Desc = {
    Text = "Dopo aver ricevuto [StateArg1] istanze di Danno attivo (rimanenti: [Layer]), congela casualmente 1 Carta di comando In Mano."
  },
  State_65362_Name = {
    Text = "Ritorno del Gelo"
  },
  State_65463_Name = {
    Text = "Ottieni 5 punti Sigillo Nero"
  },
  State_65490_Desc = {
    Text = "A fine turno, ottieni [StateArg1] Scudo Gelo e [StateArg2] Potere."
  },
  State_65490_Name = {
    Text = "Zero Assoluto"
  },
  State_65497_Name = {
    Text = "Helot: Catena Prova"
  },
  State_65553_Desc = {
    Text = "Alla fine di ogni turno, ottieni Forza in base al numero di carte rimaste in mano, ricevendo [Layer] per carta."
  },
  State_65553_Name = {
    Text = "Lama di Ghiaccio"
  },
  State_65557_Desc = {
    Text = "Dopo aver subito DAN Fatale, ripristina tutti i PV e converti l'intenzione in \"Sguardo dello Spazio Profondo EX\", ottenendo 80 accumuli di Fortezza Temporanea e rimuovendo tutti i debuff da sé e i buff dal giocatore. A fine turno, rimuovi 20 accumuli di Fortezza."
  },
  State_65557_Name = {
    Text = "Caos primordiale"
  },
  State_65558_Desc = {
    Text = "Dopo aver ricevuto danni fatali, l'intento si trasforma in \"Sguardo dello Spazio Profondo\" e ottiene 80 cariche di Fortezza, ripristinando tutti i PV. Può attivarsi [DescArg1] volte. Una volta esaurite le attivazioni, subendo nuovamente danni fatali, verrà conservato 1 PV e l'intento cambierà in \"Occhi dei Mondi Infiniti\". A fine turno, rimuovi 20 cariche di Fortezza."
  },
  State_65558_Name = {
    Text = "Polvere di Stelle"
  },
  State_65559_Desc = {
    Text = "Tohuwabohu riapparirà dopo che tutti saranno morti."
  },
  State_65559_Name = {
    Text = "\"Frammenti primordiali\""
  },
  State_65564_Name = {
    Text = [[

<D05EX_Relic:La Diffidenza del team di Ricerca nei confronti di Helot sta crescendo, e devi trovare un modo per calmarli prima che i nemici vi trovino.>]]
  },
  State_65565_Name = {
    Text = [[

<D05EX_Relic:Ignora la diffidenza della squadra e continua ad avanzare>]]
  },
  State_65566_Name = {
    Text = [[

<D05EX_Relic:Spiega la situazione al Team di Ricerca>]]
  },
  State_65567_Name = {
    Text = [[

<D05EX_Relic:Limita Helot per proteggere ulteriormente i membri della squadra>]]
  },
  State_65568_Name = {
    Text = [[

<D05EX_Relic:Limita Helot e sfrutta il potere degli altri Risvegliatori per proteggere tutti i membri della squadra>]]
  },
  State_65585_Desc = {
    Text = "Dopo aver giocato questa carta, ritorna nella tua mano. L'Orazione è disabilitata fino a fine turno."
  },
  State_65585_Name = {
    Text = "<CardKeyWord:Eco>"
  },
  State_66305_Desc = {
    Text = "Alla fine del turno, ottiene 1 strato temporaneo di <ResentChainsKeywords:Catene del Risentimento>."
  },
  State_66305_Name = {
    Text = "La serratura senza tempo"
  },
  State_66306_Desc = {
    Text = "Quando si subiscono Danni Attivi e da Tentacolo, sigilla l'Esaltazione e le Carte di Comando del Risvegliatore attaccante per 1 turno, rimuovi 1 accumulo di <ResentChainsKeywords:Catene del Risentimento>."
  },
  State_66306_Name = {
    Text = "<ResentChainsKeywords1:Catene del Risentimento>"
  },
  State_66308_Desc = {
    Text = "Dopo aver subito Danno fatale, blocca gli HP a 1."
  },
  State_66308_Name = {
    Text = "Caos primordiale"
  },
  State_66311_Desc = {
    Text = "Le Memorie dei Risvegliatori emergono dai margini della tua mente, mettendo radici e crescendo. Non importa quante volte le recidi, non importa quanto la Dissoluzione le sopraffaccia, non se ne sono mai andate."
  },
  State_66311_Name = {
    Text = "Memorie Infrante"
  },
  State_66313_Desc = {
    Text = "Per ogni Carta di Comando giocata, scarta una Carta con il Costo di Arithmetica più basso del Risvegliato."
  },
  State_66313_Name = {
    Text = "Oppressione della Volontà Suprema"
  },
  State_66314_Desc = {
    Text = "Immune a tutti i danni."
  },
  State_66314_Name = {
    Text = "Immunità ai DAN"
  },
  State_66317_Desc = {
    Text = "\"Le Memorie dei Risvegliati affiorano dai margini della tua mente, mettendo radici e crescendo dentro di te. Non importa quante volte le recidi, non importa quante volte la Dissoluzione le sovverte, non se ne sono mai veramente andate. All'inizio del turno, ripristina 1 punto al Limite di Arithmetica e aumenta il limite di carte di 2.\""
  },
  State_66317_Name = {
    Text = "Frammenti di Memoria"
  },
  State_66325_Desc = {
    Text = "\"Le Memorie dei Risvegliati affiorano dai margini della tua mente, mettendo radici e crescendo dentro di te. Non importa quante volte le recidi, non importa quante volte la Dissoluzione le sovverte, non se ne sono mai veramente andate. All'inizio del turno, ripristina 1 punto al Limite di Arithmetica e aumenta il limite di carte di 2.\""
  },
  State_66325_Name = {
    Text = "Frammenti di Memoria"
  },
  State_66358_Desc = {
    Text = "Alla prima attivazione della Resistenza alla Morte durante l'esplorazione, aggiungi \"<DerivativeCardKeywords_39:Echi del Passato>\" alla tua mano."
  },
  State_66358_Name = {
    Text = "Esistenza Inesistente"
  },
  State_66359_Desc = {
    Text = "Genera opzioni casuali tra cui scegliere."
  },
  State_66359_Name = {
    Text = "<FaxianKeywords:Scoperta>"
  },
  State_66360_Desc = {
    Text = "Tasso di Crit. aumentato del [Layer]% in questa battaglia."
  },
  State_66360_Name = {
    Text = "Tasso di Crit."
  },
  State_66362_Desc = {
    Text = "Il Danno Crit. è aumentato del [Layer]% in questa battaglia."
  },
  State_66362_Name = {
    Text = "Danno critico"
  },
  State_66409_Name = {
    Text = "Verdetto dell'Emissario"
  },
  State_66410_Desc = {
    Text = "\"Le prossime [DescArg1] Carte di comando giocate da Tawil hanno effetto due volte.\""
  },
  State_66410_Name = {
    Text = "Convergenza Omnifex"
  },
  State_66414_Desc = {
    Text = "Mentre è In Mano, se la carta in cima al Mazzo di Pesca è una Carta di comando, diventa una copia di essa."
  },
  State_66414_Name = {
    Text = "Verità Onnisciente"
  },
  State_66454_Desc = {
    Text = "Il Costo di Arithmetica delle Carte abilità diminuisce in base agli accumuli di \"Occultare\", fino a 5 accumuli. Dopo aver subito DAN o giocato un'abilità, 1 accumulo viene rimosso."
  },
  State_66454_Name = {Text = "Occultare"},
  State_66456_Desc = {
    Text = "Il Costo di Arithmetica delle Carte abilità diminuisce in base agli accumuli di \"Occultare\", fino a 5 accumuli. Dopo aver subito DAN o giocato un'abilità, 1 accumulo viene rimosso."
  },
  State_66456_Name = {
    Text = "<YinniColour:Occultare>"
  },
  State_66465_Desc = {
    Text = "Dopo aver usato Esaltazione, subisci DAN corrispondenti al numero di accumuli."
  },
  State_66465_Name = {
    Text = "<PVPfengsuoColour:Blocco dell'Esaltazione>"
  },
  State_66522_Desc = {
    Text = "Ogni 8ª carta che giochi ha effetto due volte."
  },
  State_66522_Name = {
    Text = "Birra Stellare+"
  },
  State_66553_Desc = {
    Text = "Dopo aver usato \"Colpo\" e \"Difesa\", i Risvegliatori corrispondenti ottengono 35 Aliemus. Tuttavia, il loro Costo di Arithmetica aumenta di +1."
  },
  State_66553_Name = {
    Text = "Volto Infranto"
  },
  State_66554_Desc = {
    Text = "Quando raccolto, colloca 1 <DerivativeCardKeywords_1:\"Echi di Ombre Perdute\"> in mano."
  },
  State_66554_Name = {
    Text = "Relè di Segnale"
  },
  State_66555_Desc = {
    Text = "Arithmetica massima aumentata di 1."
  },
  State_66555_Name = {
    Text = "Iniezione di Vitalità"
  },
  State_66556_Desc = {
    Text = "Quando si giocano carte consecutive dello stesso Risvegliato, quel Risvegliato ottiene 8 Aliemus."
  },
  State_66556_Name = {
    Text = "Dispositivo Cronometrico"
  },
  State_66557_Desc = {
    Text = "Ogni volta che perdi PS, ottieni [DescArg1] <PowerIconKeywords:FOR>, cumulabile fino a 10 volte per battaglia. Quando completamente accumulato, ripristina il 25% degli HP persi."
  },
  State_66557_Name = {
    Text = "Onore Supremo"
  },
  State_66558_Desc = {
    Text = "Ogni 3 turni, aggiunge 1 accumulo di <WeaknessIconKeywords:Debolezza> a tutti i nemici. Dopo aver inflitto DAN a un nemico con <WeaknessIconKeywords:Debolezza>, ottieni [DescArg1] <PowerIconKeywords:FOR> Temporaneo, con un massimo di 3 attivazioni per turno."
  },
  State_66558_Name = {
    Text = "Bambino Maligno"
  },
  State_66559_Desc = {
    Text = "Quando giochi una carta con un Costo di Arithmetica pari o superiore a 3, peschi 1 carta e ottieni 1 Arithmetica."
  },
  State_66559_Name = {
    Text = "Bellezza nella perdita"
  },
  State_66560_Desc = {
    Text = "\"Colpo\" ottiene 2 Arithmetica e scarta 1 carta casuale; \"Difesa\" pesca 2 carte e perde 1 Arithmetica. Può essere attivato fino a 3 volte per turno."
  },
  State_66560_Name = {
    Text = "Disco Gioioso"
  },
  State_66561_Desc = {
    Text = "Ogni 3 turni, aggiungi 1 accumulo di <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici. Dopo aver inflitto danno a un nemico <VulnerabilityIconKeywords:Vulnerabile>, gli fai perdere [DescArg1] <PowerIconKeywords:FOR> Temporanea, con un massimo di 3 attivazioni per turno."
  },
  State_66561_Name = {
    Text = "La Sagra della Primavera"
  },
  State_66562_Desc = {
    Text = "Ogni 4 turni, raddoppia il danno subito da tutti i nemici in questo turno. Tuttavia, dopo aver rilasciato l'Esaltazione in questo turno, sigilla tutti i Risvegliatori per 1 turno."
  },
  State_66562_Name = {
    Text = "Resti del Viandante"
  },
  State_66563_Desc = {
    Text = "All'inizio del turno, se hai giocato più di 3 carte nel turno precedente, pesca 2 carte."
  },
  State_66563_Name = {
    Text = "Portafoglio Nuovo di Zecca"
  },
  State_66564_Desc = {
    Text = "Quando raccolto, ottieni 3 Arithmetica."
  },
  State_66564_Name = {
    Text = "Specchio dell'Orologio da Tasca"
  },
  State_66565_Desc = {
    Text = "Quando raccolto, infliggi 1 turno di <WeaknessIconKeywords:Debolezza> e <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici."
  },
  State_66565_Name = {
    Text = "Camicia di Forza Cangiante"
  },
  State_66566_Desc = {
    Text = "All'inizio del turno, la <DeathResistanceIconKeywords:Resistenza alla Morte> aumenta del 10% (ogni volta che la Resistenza alla Morte si attiva in questo livello, la Resistenza alla Morte ottenuta viene dimezzata). Quando la <DeathResistanceIconKeywords:Resistenza alla Morte> supera il 100%, la <ProficientInRealmsIconKeywords:Padronanza del Reame> aumenta di 100."
  },
  State_66566_Name = {
    Text = "Lacrima di Sirena"
  },
  State_66703_Desc = {
    Text = "Unico per Squadra: Limite Keyflare +100%. Limite Mano +2, non cumulabile con altre RdD con lo stesso effetto. Aumenta la Rigenerazione Keyflare del portatore del <WeaponEffect_Num:[StateArg1]%>. Dopo che il portatore gioca una carta, in questo turno, il Tasso Crit., il Danno Crit., la Generazione di Scudo, la Generazione di Aliemus e la Generazione di FOR delle Carte di comando del portatore +<WeaponEffect_Num:[StateArg2]%>, cumulabile fino a 5 volte."
  },
  State_66703_WeaponDesc = {
    Text = "Limite Keyflare +100%. Limite Mano +2, non cumulabile con altri AdD con lo stesso effetto. Aumenta la Rigenerazione Keyflare del Portatore di <WeaponEffect_Num:[DescArg2]>. Dopo che il Portatore gioca una carta, il Tasso Crit. e il Danno Crit., la Generazione di Scudo, l'Aliemus e la Forza delle Carte di comando del Portatore aumentano del <WeaponEffect_Num:[StateArg2]%> per questo turno, accumulabile fino a 5 accumuli (attualmente [DescArg1] accumuli)."
  },
  State_66722_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Quando equipaggiata e a inizio turno, se non è presente alcuna <PVPProtectiveKeywords:Barriera>, ottieni [StateArg1] accumuli di <PVPProtectiveKeywords:Barriera>; altrimenti ottieni <StrengthenKeywords:Potenziamento>."
  },
  State_66722_Name = {
    Text = "Ruota Invisibile"
  },
  State_66872_Desc = {
    Text = "Il Danno, lo Scudo e il Recupero PV forniti da Tawil sono temporaneamente aumentati del [StateArg1]%, per una durata di [Layer] turni."
  },
  State_66872_Name = {
    Text = "Infinito Splendore Radioso"
  },
  State_66884_Desc = {
    Text = "A fine turno, il Costo di Arithmetica diminuisce e l'effetto si attiva anche se la carta viene scartata."
  },
  State_66884_Name = {
    Text = "<PrepareKeypvewords:Preparazione 1>"
  },
  State_66888_Desc = {
    Text = "Unico per Squadra: All'attivazione di Posse, si ottiene il <WeaponEffect_Num:[StateArg1]%> dell'ATT del Portatore come <PowerIconKeywords:FOR> e Scudo del Personaggio pari al <WeaponEffect_Num:[StateArg2]%> della sua DIF. All'utilizzo di un Corpo di Gnosi d'Emergenza, tutti i Risvegliatori ottengono <WeaponEffect_Num:[StateArg3]> Aliemus a fine turno."
  },
  State_66888_Name = {
    Text = "Cuore d'Argento Puro"
  },
  State_66888_WeaponDesc = {
    Text = "Dopo aver rilasciato il Seguito, ottieni <WeaponEffect_Num:[Power:DescArg1]> <PowerIconKeywords:FOR> e <WeaponEffect_Num:[Block:DescArg2]> Scudo. Dopo aver usato il Corpo di Gnosi d'Emergenza, tutti i Risvegliati ottengono <WeaponEffect_Num:[StateArg3]> Aliemus a fine turno."
  },
  State_66893_Desc = {
    Text = "Unico per Squadra: Dopo l'Inizio della Battaglia, ottieni Keyflare pari al <WeaponEffect_Num:[StateArg1]%> della Rigenerazione Keyflare del Portatore. La prima emissione di Posse in ogni Battaglia ripete questo Effetto."
  },
  State_66893_WeaponDesc = {
    Text = "Dopo l'inizio della Battaglia, ottieni <WeaponEffect_Num:[DescArg1]> Keyflare. Dopo la prima volta che rilasci un Posse in ogni Battaglia, questo effetto si attiva nuovamente."
  },
  State_66896_WeaponDesc = {
    Text = "Modifica l'Arithmetica della carta prima di giocarla"
  },
  State_66900_Desc = {
    Text = "Danno, Guarigione e Generazione di Scudo del Personaggio di questa carta +[StateArg1]%"
  },
  State_66900_Name = {
    Text = "Cuore d'Argento Puro"
  },
  State_66901_Desc = {
    Text = "Carta di comando ed Esaltazione Danno, Guarigione, Scudo +[DescArg1]% per 1 turno."
  },
  State_66901_Name = {
    Text = "Amplificazione Temporanea"
  },
  State_66902_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Quando un Risvegliato alleato muore, ottieni <Block:[Block:StateArg1]> Scudo e pesca la sua carta \"Abilità\" con il costo più basso."
  },
  State_66902_Name = {
    Text = "Cuore d'Argento Puro"
  },
  State_66971_Desc = {
    Text = "Quando i PV scendono a 0, i PV vengono impostati a 1 e non subirà più alcun Danno."
  },
  State_66971_Name = {
    Text = "Separazione del Mondo"
  },
  State_67234_Desc = {
    Text = "A fine turno, evoca un \"Clone Cervello in un Vaso\", che dura [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turni\">."
  },
  State_67234_Name = {
    Text = "Separazione"
  },
  State_67235_Desc = {
    Text = "Alla morte, ripristina tutti gli HP, HP massimi +100%, rilascia \"Pestilenza dell'anima\"."
  },
  State_67235_Name = {
    Text = "Non Risvegliato"
  },
  State_67237_Desc = {
    Text = "Al raggiungimento del livello 10, l'intenzione cambia in \"Fine dell'Illusione\": riduce i PV massimi dell'avversario a 1."
  },
  State_67237_Name = {
    Text = "Fine Ultima"
  },
  State_67238_Desc = {
    Text = "A fine turno, ottieni 1 accumulo di \"Fine\". Dopo aver subito DAN fatali, rimuovi questo stato, diventa immune ai DAN per 1 turno, ripristina il 15% dei PV e ottieni 10 accumuli di \"Fine\"."
  },
  State_67238_Name = {
    Text = "Morbo dell'Anima"
  },
  State_67240_Desc = {
    Text = "\"Saggio\" ottiene 25 accumuli di <ReinforcePVEKeywords:Fortezza> temporanea e [Power:StateArg1] <PowerIconKeywords:FOR> temporanea, poi rimuove questo Stato."
  },
  State_67240_Name = {
    Text = "<TuiyanColour:Deduzione>"
  },
  State_67241_Desc = {
    Text = "Alla morte, ripristina tutti gli HP, HP massimi +100%, rilascia \"Zelo del Cavaliere\"."
  },
  State_67241_Name = {
    Text = "Non Risvegliato"
  },
  State_67242_Desc = {
    Text = "Alla morte, ripristina tutti gli HP, HP Massimi +100%, rilascia \"Carne @1staccata\"."
  },
  State_67242_Name = {
    Text = "Non Risvegliato"
  },
  State_67243_Desc = {
    Text = "A fine turno, evoca un \"Clone del Cervello in una Vasca\". Quando il clone del \"Cervello in una Vasca\" attiva \"Separazione Spirituale\", ruba in aggiunta il 5% della tua FOR."
  },
  State_67243_Name = {
    Text = "Carne Dist@1ccata"
  },
  State_67245_Desc = {
    Text = "A fine turno, ottieni [StateArg1] <PowerIconKeywords:FOR>."
  },
  State_67245_Name = {
    Text = "Zelo del Cavaliere"
  },
  State_67246_Desc = {
    Text = "Ogni volta che il tuo scudo viene rotto per la prima volta in un turno, perdi il 25% dei tuoi PV massimi e ottieni [Power:DescArg1] <PowerIconKeywords:FOR temporanea> e [Layer] accumuli di Fortezza Temporanea. All'inizio del turno successivo, recuperi <Block:[Block:DescArg2]> accumuli di Scudo del Personaggio. Ogni volta che \"Credo del Cavaliere\" si attiva, ottieni un accumulo aggiuntivo di Scudo del Personaggio."
  },
  State_67246_Name = {
    Text = "Fede del Cavaliere"
  },
  State_67247_Desc = {
    Text = "Alla fine di ogni turno, i nemici vengono reintegrati, fino a 2 contemporaneamente. Quando un nemico muore, il \"Cervello Corrotto\" perde il 5% dei PV massimi."
  },
  State_67247_Name = {
    Text = "Portale dell'Abisso"
  },
  State_67252_Desc = {
    Text = "Quando subisci Danno letale, spostati nella fila posteriore e conserva 1 PV, poi diventa immune a ogni ulteriore Danno. La <PowerIconKeywords:FOR> aumenta di [DescArg1]. L'Autodistruzione non attiva questo effetto."
  },
  State_67252_Name = {
    Text = "Separazione Spirituale"
  },
  State_67253_Desc = {
    Text = "Dopo aver giocato [Layer] carte, genera 1 \"Clone del Cervello in una Vasca\" davanti a te, con un massimo di 3 cloni esistenti simultaneamente."
  },
  State_67253_Name = {
    Text = "Cervello in una Vasca"
  },
  State_67255_Desc = {
    Text = "Alla morte, ripristina tutti gli HP, HP massimi +100%, rilascia \"Prima Dottrina\"."
  },
  State_67255_Name = {
    Text = "Non Risvegliato"
  },
  State_67256_Desc = {
    Text = "Dopo la fase di pescata, rivela casualmente tre Carte di comando dalla tua mano, scegline una a cui conferire l'Orazione \"Eco\" e scarta le altre."
  },
  State_67256_Name = {
    Text = "Prima Dottrina"
  },
  State_67257_Desc = {
    Text = "Dopo aver rilasciato un Seguito per la prima volta ogni turno, tutti i Risvegliati ottengono 10 Aliemus, ma il costo per rilasciare un Seguito aumenta permanentemente del 10%."
  },
  State_67257_Name = {
    Text = "Legame in Frantumi"
  },
  State_67258_Desc = {
    Text = "All'inizio della battaglia, ottieni <Block:[Block:DescArg1]> cariche di Scudo. Lo Scudo non scomparirà a fine turno."
  },
  State_67258_Name = {
    Text = "Risolutezza del Cavaliere"
  },
  State_67347_Desc = {
    Text = "Mentre è In Mano, se la carta in cima al Mazzo di Pesca è una Carta di comando, diventa una copia di essa con -1 al Costo di Arithmetica."
  },
  State_67347_Name = {
    Text = "Verità Onnisciente"
  },
  State_67353_Desc = {
    Text = "Alla morte, il \"Cervello Corrotto\" perde il 5% dei PV massimi."
  },
  State_67353_Name = {Text = "Fusione"},
  State_67358_Desc = {
    Text = "Ogni volta che consumi 1 Arithmetica, ottieni immediatamente <Block:[Block:StateArg1]> Scudo e 3 cariche di Fortezza Temporanea."
  },
  State_67358_Name = {
    Text = "Barriera Instabile"
  },
  State_67414_Desc = {
    Text = "Occhi che non devono essere scrutati. Un'aura che non deve essere sfidata. Frammenti di ogni cosa restano pur sempre frammenti. Ora, affronta la Distruzione predestinata..."
  },
  State_67414_Name = {
    Text = "Affrontare le Miriadi della Genesi"
  },
  State_67418_Desc = {
    Text = "All'utilizzo, scarta tutte le carte In Mano che non appartengono a questo Risvegliatore. Ottieni 5 carte non di comando. Ha effetto una volta per battaglia."
  },
  State_67418_Name = {
    Text = "<WhiteQuality:Av. Lex Volis>"
  },
  State_67419_Desc = {
    Text = "All'uso, ottieni 3 Copie Base con <RetainIconKeywords:Conserva> e <DepleteIconKeywords:Consumo> applicati, con -1 al Costo di Arithmetica. Ha effetto una volta per battaglia."
  },
  State_67419_Name = {
    Text = "<WhiteQuality:Lex Genis Avanzata>"
  },
  State_67420_Desc = {
    Text = "All'uso, pesca 4 carte, riducendo il loro Costo di Arithmetica di un ammontare pari al Costo di Arithmetica della Carta Consacrata. Ha effetto una volta per battaglia."
  },
  State_67420_Name = {
    Text = "<WhiteQuality:Av. Lex Nous>"
  },
  State_67598_Desc = {
    Text = "Dopo aver rilasciato l'Esaltazione, aggiungi alla mano una carta casuale corrispondente al Risvegliatore. La carta ottiene <DepleteIconKeywords:Consumo> e <NothingnessIconKeywords:Effimera>. Al termine della battaglia, ripristina [DescArg1] PV."
  },
  State_67598_Name = {
    Text = "Valigetta del dottore"
  },
  State_67599_Desc = {
    Text = "Dopo aver giocato una Carta di comando che non sia \"Attacco\" o \"Difesa\", il Risvegliatore corrispondente ottiene 15 Aliemus, attivandosi un massimo di 5 volte per turno. La prima attivazione di ogni turno restituirà anche la carta giocata alla mano."
  },
  State_67599_Name = {
    Text = "Pendolo Crono: Proiezione"
  },
  State_67600_Desc = {
    Text = "Arithmetica massima +4. Ogni volta che il mazzo viene rimescolato, aggiungi 4 <DerivativeCardKeywords_4:\"Intuizione\"> al Mazzo di pesca."
  },
  State_67600_Name = {
    Text = "Benedetto: Candela Nera"
  },
  State_67602_Name = {Text = "Obsoleto"},
  State_67603_Desc = {
    Text = "Infliggi il 20% di Danno in più ai nemici con debuff e ottieni 20 Aliemus uccidendoli."
  },
  State_67603_Name = {
    Text = "Bastone dell'Ierofante"
  },
  State_67604_Desc = {
    Text = "Ogni volta che viene giocata una Carta di comando appartenente a un Risveglio diverso dall'ultimo giocato, quel Risveglio ottiene 3 Aliemus e accumula 1 accumulo di \"Vitalità\". Al raggiungimento di 10 accumuli, tutta la \"Vitalità\" viene azzerata e una Carta di comando casuale con \"Esaurimento\" e Costo di Arithmetica ridotto di 1 viene posta In Mano per ciascun Risveglio. Questo effetto può attivarsi un massimo di 1 volta per turno."
  },
  State_67604_Name = {
    Text = "Pendolo Crono: Evoluzione"
  },
  State_67605_Desc = {
    Text = "Quando possiedi uno scudo, questa Reliquia fornisce [DescArg1] <PowerIconKeywords:FOR> temporanea. Se il tuo Scudo del Personaggio è superiore ai tuoi PV attuali, fornisce ulteriori [DescArg2] <PowerIconKeywords:FOR> temporanea."
  },
  State_67605_Name = {
    Text = "Ventaglio di Piume di Colomba"
  },
  State_67606_Desc = {
    Text = "A inizio turno, ottieni 1 Arithmetica per ogni nemico. Quando un nemico viene ucciso da Danno attivo, infliggi <BleedingIconKeywords:Salasso> agli altri nemici pari al Danno in eccesso."
  },
  State_67606_Name = {
    Text = "Canto della Folla"
  },
  State_67607_Desc = {
    Text = "Dopo aver rilasciato 5 Esaltazioni, il Risveglio che le ha rilasciate ottiene 100 Aliemus."
  },
  State_67607_Name = {
    Text = "Piccola Culla"
  },
  State_67608_Name = {Text = "Obsoleto"},
  State_67609_Desc = {
    Text = "Dopo aver rilasciato l'Esaltazione, perdi l'8% dei PV attuali, rubi [DescArg1] <PowerIconKeywords:FOR> temporanea a tutti i nemici. Se è presente solo 1 nemico, rubi ulteriori [DescArg2] <PowerIconKeywords:FOR> temporanea."
  },
  State_67609_Name = {
    Text = "Uccello Rituale del Presagio"
  },
  State_67611_Desc = {
    Text = "Ogni 2 turni, raddoppia i DAN subiti da tutti i nemici e dissolvi casualmente 1 debuff per ogni Esaltazione utilizzata in questo turno."
  },
  State_67611_Name = {
    Text = "Benedetto: Resti del Viandante"
  },
  State_67612_Desc = {
    Text = "Il Danno Crit. di tutti i \"Colpo\" è aumentato del 20%. Al momento della raccolta, aggiungi 1 <DerivativeCardKeywords_40:\"Bellezza Fugace\"> alla tua mano."
  },
  State_67612_Name = {
    Text = "Bellezza Fugace β"
  },
  State_67614_Desc = {
    Text = "A inizio turno, tutti i Risvegliati ottengono 25 Aliemus. Quando raccolto, gli HP massimi diventano 1,5 volte."
  },
  State_67614_Name = {
    Text = "Benedetto: Manifestazione dell'Incubo β"
  },
  State_67615_Desc = {
    Text = "Giocare la 6ª Carta di comando la fa tornare nella tua mano dalla Pila degli scarti."
  },
  State_67615_Name = {
    Text = "Nel Crepuscolo"
  },
  State_67616_Name = {Text = "Obsoleto"},
  State_67618_Desc = {
    Text = "A inizio turno, tutti i Risvegliati ottengono 25 Aliemus. Quando raccolto, gli HP massimi diventano 1,5 volte."
  },
  State_67619_Desc = {
    Text = "Limite di carte In Mano +5. Al momento della raccolta, riempi la mano di carte. A inizio turno, pesca 1 carta aggiuntiva. A fine turno, scarta tutte le Carte sintomo e le Carte di stato in mano, conserva le altre carte."
  },
  State_67619_Name = {
    Text = "Benedetto: Incisione Mentale β"
  },
  State_67620_Desc = {
    Text = "Dopo aver giocato la 3ª carta ogni turno, colloca 1 <DerivativeCardKeywords_4:\"Intuizione\"> nella Pila degli scarti. Dopo aver giocato la 6ª carta ogni turno, colloca 1 <DerivativeCardKeywords_4:\"Intuizione\"> dalla Pila degli scarti nella mano."
  },
  State_67620_Name = {
    Text = "Luce della Civiltà"
  },
  State_67621_Desc = {
    Text = "Dopo aver rilasciato l'Esaltazione, ottieni [DescArg1] FOR temporanea e rubi [DescArg1] <PowerIconKeywords:FOR> temporanea a tutti i nemici. Se è presente solo 1 nemico, rubi ulteriori [DescArg2] <PowerIconKeywords:FOR> temporanea."
  },
  State_67621_Name = {
    Text = "Benedetto: Uccello Rituale del Presagio"
  },
  State_67622_Desc = {
    Text = "Quando esaurisci l'ultimo 1 Arithmetica, ottieni 2 Arithmetica. Massimo 2 attivazioni per turno."
  },
  State_67622_Name = {
    Text = "Motore Differenziale"
  },
  State_67623_Desc = {
    Text = "Ottieni permanentemente [DescArg1] <PowerIconKeywords:FOR> dopo la raccolta. Ogni volta che infliggi Danno, cura [DescArg2] PV, con un massimo di 6 attivazioni per turno."
  },
  State_67623_Name = {
    Text = "Benedetto: Bacio di Lampreda"
  },
  State_67624_Name = {Text = "Obsoleto"},
  State_67625_Desc = {
    Text = "Quando una Carta di comando entra per la prima volta nella Pila degli scarti ogni turno, mischia una copia Temporanea con Costo di Arithmetica ridotto di 1 nel mazzo di pesca."
  },
  State_67625_Name = {
    Text = "Jukebox muto"
  },
  State_67626_Desc = {
    Text = "Arithmetica massima +1. Quando giochi 2 carte consecutive con Costo di Arithmetica superiore a quello della carta precedente, ottieni 1 Arithmetica."
  },
  State_67626_Name = {
    Text = "Archivio Arcana"
  },
  State_67628_Name = {Text = "Obsoleto"},
  State_67630_Name = {Text = "Obsoleto"},
  State_67631_Desc = {
    Text = "Arithmetica massima +2. Ogni volta che il mazzo viene rimescolato, aggiungi 1 <DerivativeCardKeywords_9:\"Barcollare\"> al Mazzo di Pesca."
  },
  State_67631_Name = {
    Text = "Candela Nera"
  },
  State_67632_Name = {Text = "Obsoleto"},
  State_67634_Desc = {
    Text = "A fine turno, per ogni carta non giocata in mano, tutti i Risvegliatori ottengono 2 Aliemus."
  },
  State_67634_Name = {
    Text = "Bilancia squilibrata"
  },
  State_67635_Desc = {
    Text = "Quando raccolto, tutti i Risvegliati ottengono 50 Aliemus e mischiano 2 <DerivativeCardKeywords_1:\"Echi di Ombre Perdute\"> nel Mazzo di Pesca."
  },
  State_67635_Name = {
    Text = "Relè di Segnale +β"
  },
  State_67636_Desc = {
    Text = "Danno Crit. +15%. Colpo Critico garantito contro i nemici con Scudo del Personaggio."
  },
  State_67636_Name = {
    Text = "Principi dell'Estetica"
  },
  State_67637_Desc = {
    Text = "A inizio turno, pesca 2 carte e ottieni 2 Arithmetica. Ogni volta che peschi una Carta di comando o attivi un Risveglio, il suo Costo di Arithmetica viene alterato casualmente. (0-4)"
  },
  State_67637_Name = {
    Text = "Cappello del Truffatore"
  },
  State_67638_Desc = {
    Text = "Infliggi il 50% di Danno in più ai nemici con debuff e ottieni 100 Aliemus alla loro eliminazione."
  },
  State_67638_Name = {
    Text = "Bastone del Ierofante +"
  },
  State_67639_Desc = {
    Text = "Tasso Crit. aumentato del 50%, Danno Crit. aumentato del 100%."
  },
  State_67639_Name = {
    Text = "Benedetto: Uncino Sinistro"
  },
  State_67640_Desc = {
    Text = "Tasso Crit. e Danno Crit. +100%. Per ogni istanza di danno/danno da Tentacolo inflitta in questo turno, il Tasso Crit. e il Danno Crit. di tutti i Risvegliatori si riducono del 10%, fino al 50%. Danno da veleno e da contatore +10%, fino al 50%."
  },
  State_67640_Name = {
    Text = "Pendolo Crono: Ondata"
  },
  State_67641_Desc = {
    Text = "Dopo aver rilasciato l'Esaltazione, ottieni [DescArg1] <PowerIconKeywords:FOR> temporanea."
  },
  State_67641_Name = {
    Text = "Serratura di Ferro"
  },
  State_67643_Desc = {
    Text = "Ottieni [DescArg1] Scudo del Personaggio quando infliggi Danno attivo. Ottieni [DescArg2] <PowerIconKeywords:FOR> temporanea quando recuperi PV."
  },
  State_67643_Name = {
    Text = "La Nostra Casa"
  },
  State_67645_Desc = {
    Text = "Tasso di Crit. +10%. Dopo il primo Colpo Critico di ogni turno, aumenta il Tasso di Crit. di un ulteriore 20%. Dopo il 3° Colpo Critico di ogni turno, aumenta il Danno Crit. di un ulteriore 50%."
  },
  State_67645_Name = {
    Text = "Benedizione Festiva"
  },
  State_67646_Desc = {
    Text = "Alla fine dei turni dispari, se rimane Arithmetica, pesca 2 carte extra nel turno successivo; alla fine dei turni pari, se rimangono carte, ottieni 2 Arithmetica extra nel turno successivo."
  },
  State_67646_Name = {
    Text = "Disco Solare"
  },
  State_67647_Desc = {
    Text = "Ogni 5ª Carta di comando che giochi avrà Effetto due volte e tornerà nella tua mano dopo essere stata giocata."
  },
  State_67647_Name = {
    Text = "Birra Stellare+"
  },
  State_67649_Desc = {
    Text = "Nascondi le Intenzioni del Mostro. Ottieni 1 Arithmetica ogni turno e pesca 1 carta."
  },
  State_67649_Name = {
    Text = "Campanella Ammaliatrice"
  },
  State_67650_Desc = {
    Text = "\"Attacco\" e \"Difesa\" ottengono 50 Keyflare aggiuntivi. Ogni volta che giochi una carta con un Costo di Arithmetica pari o superiore a 2, pesca una carta con Costo di Arithmetica pari a 1 e riducine il costo a 0, fino a 3 volte per turno."
  },
  State_67650_Name = {
    Text = "Pendolo Crono: Gemelli"
  },
  State_67651_Desc = {
    Text = "Quando raccolto, la Padronanza del Reame della squadra aumenta al 150% del suo valore base. Dopo aver giocato la 5ª Carta di comando ogni turno, tutti i Risvegliatori ottengono 20 Aliemus."
  },
  State_67651_Name = {
    Text = "Pendolo Crono: Impuro"
  },
  State_67653_Desc = {
    Text = "Dopo aver rilasciato 2 Esaltazioni per turno, tutti i Risvegliati ottengono 8 Aliemus. Dopo aver rilasciato 3 Esaltazioni, tutti i Risvegliati ottengono ulteriori 8 Aliemus."
  },
  State_67653_Name = {
    Text = "Sangue dei Dimenticati"
  },
  State_67654_Name = {
    Text = "Si attiva [DescArg1] volte in più"
  },
  State_67656_Desc = {
    Text = "Probabilità di critico aumentata del 50%, applica <FragileIconKeywords:Fragile> a te stesso per 3 turni."
  },
  State_67656_Name = {
    Text = "Uncino Sinistro"
  },
  State_67657_Desc = {
    Text = "Pesca 1 carta a inizio turno. Pesca 1 carta aggiuntiva se giochi 2 carte con lo stesso Costo di Arithmetica consecutivamente, fino a 3 volte per turno."
  },
  State_67657_Name = {
    Text = "Dispositivo di Gnosi"
  },
  State_67658_Desc = {
    Text = "Quando giochi una carta con un Costo di Arithmetica effettivo di 3, pesca 1 carta e ottieni 2 Arithmetica; quando giochi una carta con un Costo di Arithmetica effettivo di 4 o più, riduci di 1 il Costo di Arithmetica delle altre carte nella tua mano."
  },
  State_67658_Name = {
    Text = "Pendolo Crono: Occhio"
  },
  State_67659_Desc = {
    Text = "A inizio turno, ottieni 2 Arithmetica per ogni nemico. Quando un nemico viene ucciso da Danno attivo, infliggi il doppio del Danno in eccesso agli altri nemici come <BleedingIconKeywords:Salasso>."
  },
  State_67659_Name = {
    Text = "Canto della Folla +"
  },
  State_67660_Desc = {
    Text = "Ogni tre volte che viene giocato \"Colpo\", infligge [DescArg1] DAN a tutti i nemici. Il Risvegliato corrispondente ottiene 15 Aliemus."
  },
  State_67660_Name = {
    Text = "Bisturi Arrugginito"
  },
  State_67661_Desc = {
    Text = "Pesca 1 carta ogni volta che viene spesa Arithmetica, fino a 5 volte per turno. Ottieni 2 Arithmetica ogni volta che il mazzo viene rimischiato."
  },
  State_67661_Name = {
    Text = "Pendolo Crono: Insonne"
  },
  State_67662_Desc = {
    Text = "Quando giochi una Carta potenziamento, una Carta sintomo o una Carta di stato, il Risvegliato con l'Aliemus più basso guadagna 10 Aliemus."
  },
  State_67662_Name = {
    Text = "Album di Francobolli Stranieri"
  },
  State_67665_Desc = {
    Text = "L'Arithmetica massima aumenta di 2. Dopo aver giocato \"Attacco\" o \"Difesa\", il Risvegliatore corrispondente ottiene 5 Aliemus. Dopo aver rilasciato l'Esaltazione, ottieni 1 \"Attacco\" del Risvegliatore corrispondente con Consumo e Fugace applicati. Dopo aver rilasciato il Seguito, ottieni casualmente una \"Difesa\" con Consumo e Fugace."
  },
  State_67665_Name = {
    Text = "Pendolo Crono: Ali"
  },
  State_67666_Desc = {
    Text = "Ogni volta che infliggi Danno, ottieni [DescArg1] <PowerIconKeywords:FOR> temporanea, cumulabile fino a 3 volte. Quando gli accumuli sono al massimo, l'effetto è raddoppiato."
  },
  State_67666_Name = {
    Text = "Agata Filigranata"
  },
  State_67667_Desc = {
    Text = "Al termine del turno, tutti i Risvegliati ottengono 5 Aliemus. Per ogni Arithmetica rimanente, tutti i Risvegliati ottengono 3 Aliemus aggiuntivi."
  },
  State_67667_Name = {
    Text = "Batteria Prototipo"
  },
  State_67668_Desc = {
    Text = "Danno Crit. aumentato del 15%. Probabilità di Crit. di \"Colpo\" aumentata del 40%."
  },
  State_67668_Name = {
    Text = "Becco di Corvo d'Avorio"
  },
  State_67669_Name = {Text = "Obsoleto"},
  State_67670_Desc = {
    Text = "Dopo aver rilasciato un'Esaltazione, pesca 1 carta. Se i PV sono inferiori al 25%, pesca una carta aggiuntiva."
  },
  State_67670_Name = {
    Text = "Ruota della Conoscenza"
  },
  State_67671_Desc = {
    Text = "Per ogni Danno attivo inflitto, ripristina [DescArg1] PV e infliggi [DescArg2] accumuli di <BleedingIconKeywords:Salasso> al bersaglio del Danno."
  },
  State_67671_Name = {
    Text = "Benedetto: Mente dello Sciame"
  },
  State_67672_Desc = {
    Text = "L'effetto di <WeaknessIconKeywords:Debolezza> è aumentato dell'8% e l'effetto di <VulnerabilityIconKeywords:Vulnerabile> è aumentato del 25%. Quando applichi <WeaknessIconKeywords:Debolezza> o <VulnerabilityIconKeywords:Vulnerabile>, rubi temporaneamente [DescArg1] <PowerIconKeywords:FOR> al bersaglio."
  },
  State_67672_Name = {
    Text = "Foto Sbiadita +"
  },
  State_67673_Desc = {
    Text = "Pesca 1 carta all'inizio del turno."
  },
  State_67673_Name = {
    Text = "Bussola del Nord Vero"
  },
  State_67674_Desc = {
    Text = "Per ogni Carta di comando giocata, ottieni [DescArg2]% di <DeathResistanceIconKeywords:Resistenza> (ogni volta che la Resistenza viene attivata in questo Stadio, la Resistenza ottenuta si dimezza). Se la tua <DeathResistanceIconKeywords:Resistenza> è pari o superiore al 100%, ottieni invece [DescArg1] punti di <PowerIconKeywords:Potere> temporaneo."
  },
  State_67674_Name = {
    Text = "Spoglia del serpente"
  },
  State_67675_Desc = {
    Text = "A fine turno, se rimane Arithmetica, pesca 2 carte extra il turno successivo; se rimangono carte in mano, ottieni 2 Arithmetica extra il turno successivo."
  },
  State_67675_Name = {
    Text = "Disco Solare+ +"
  },
  State_67677_Desc = {
    Text = "Quando infliggi <WeaknessIconKeywords:Debolezza>, ottieni [DescArg1] scudo; quando infliggi <VulnerabilityIconKeywords:Vulnerabile>, ottieni [DescArg2] <PowerIconKeywords:FOR> temporanea. Se entrambi gli effetti vengono attivati in 1 turno, ottieni in aggiunta [DescArg1] scudo e [DescArg2] <PowerIconKeywords:FOR> temporanea."
  },
  State_67677_Name = {
    Text = "Cornice Dorata"
  },
  State_67703_Desc = {
    Text = "A inizio turno, se nel turno precedente sono rimaste più di 3 carte in mano, ottieni 2 Arithmetica."
  },
  State_67703_Name = {
    Text = "Insegna Mythag"
  },
  State_67704_Desc = {
    Text = "Al rilascio dell'Esaltazione, ottieni 10 Aliemus per il Risvegliato corrispondente e ricevi [DescArg1] Scudo."
  },
  State_67704_Name = {
    Text = "Velo della Divinità Senza Nome"
  },
  State_67796_Name = {
    Text = "<TongxiaoKeywords:Verità Onnisciente>: Si ripristina dopo l'uso e ottieni <Energy:[StateArg1]> Aliemus"
  },
  State_67841_WeaponDesc = {
    Text = "Modifica l'Arithmetica della carta prima di giocarla"
  },
  State_67844_Desc = {
    Text = "Dopo aver subito Danno fatale, recupera tutti gli HP. Può essere attivato @1 volta. Attualmente attivato [DescArg1] volte."
  },
  State_67844_Name = {
    Text = "Caos primordiale"
  },
  State_67866_Name = {
    Text = "<BleedingColour:Salasso>"
  },
  State_68298_Desc = {
    Text = "Dopo aver subito Danno Fatale, converti l'intenzione in \"Sguardo dello Spazio Profondo\" e ottieni 80 accumuli di Fortezza Temporanea, ripristinando tutti i PV. Può attivarsi [DescArg1] volte. Alla fine del turno, rimuovi 20 accumuli di Fortezza."
  },
  State_68298_Name = {
    Text = "Polvere di Stelle"
  },
  State_68554_Desc = {
    Text = "Recupera tutti gli HP dopo aver subito DAN fatali, e rimuovi questo Stato dopo che tutti gli altri nemici sono morti. Può essere attivato @1 volta, attualmente attivato [DescArg1] volte."
  },
  State_68554_Name = {
    Text = "Detriti del Caos primordiale"
  },
  State_68621_Desc = {
    Text = "All'inizio del combattimento e alla fine di ogni turno, ottiene 2 strati temporanei di <ResentChainsKeywords:Catene del Risentimento>."
  },
  State_68621_Name = {
    Text = "Flusso dell'Inganno"
  },
  State_68622_Desc = {
    Text = "La Generazione di FOR dei Risvegliati è ridotta del 75%. Ogni volta che si perdono HP, ottieni [DescArg1] Scudo e 1 carica di Fortezza Temporanea."
  },
  State_68622_Name = {
    Text = "Flusso dell'Eresia"
  },
  State_68623_Desc = {
    Text = "Per ogni Carta di Comando giocata, scarta una Carta con il Costo di Arithmetica più basso del Risvegliato."
  },
  State_68623_Name = {
    Text = "Flusso di Follia"
  },
  State_68624_Desc = {
    Text = "A fine turno, ripristina il 10% degli HP persi, rimuovi i debuff da te stesso e i buff dalla tua squadra."
  },
  State_68624_Name = {
    Text = "Flusso di Nascita"
  },
  State_68626_Desc = {
    Text = "L'Aliemus Base di tutti i Risvegliati aumenta del 50%. Alla fine di ogni turno, deduci 10 Aliemus da tutti i Risvegliati e ripristina il 3% dei loro HP massimi."
  },
  State_68626_Name = {
    Text = "Flusso di Paura"
  },
  State_68627_Desc = {
    Text = "All'inizio della battaglia, ottieni 15 cariche di \"Barriera Temporanea\". A fine turno, ottieni 15 cariche di \"Barriera Temporanea\" e applica \"Dissoluzione Temporanea\" a 10 carte casuali."
  },
  State_68627_Name = {
    Text = "Flusso di Flagello"
  },
  State_68632_Desc = {
    Text = "Il Costo di Arithmetica di tutte le Carte di Comando aumenta di 1. Alla fine di ogni 3 turni, aggiungi 1 \"Pietrificazione Graduale\" alla tua mano."
  },
  State_68632_Name = {
    Text = "Flusso di Pianto"
  },
  State_68635_Name = {
    Text = "Nucleo d'Argento Puro· Paura"
  },
  State_68637_Desc = {
    Text = "Quando perdi PV, perdi la stessa quantità di accumuli. A 0 accumuli, ottieni 2 accumuli di Barriera temporanea e guadagni [DescArg1] Scudo, [DescArg2] Fortezza Temporanea e recuperi [DescArg3] accumuli di Barriera Dimensionale."
  },
  State_68637_Name = {
    Text = "Barriera Dimensionale"
  },
  State_68638_Name = {
    Text = "Nucleo d'Argento Puro· Eresia"
  },
  State_68646_Desc = {
    Text = "DAN Base e valore dello Scudo del Personaggio aumentati del 200%, ma si esaurirà dopo l'uso."
  },
  State_68646_Name = {
    Text = "<RedQuality1:Dissoluzione temporanea>"
  },
  State_68647_Name = {
    Text = "\"Nucleo Tono Puro · Follia\""
  },
  State_68680_Desc = {
    Text = "Rimuovi detriti ancestrali"
  },
  State_68680_Name = {
    Text = "Rimuovi detriti ancestrali"
  },
  State_68704_Desc = {
    Text = "Mancano ancora [DescArg1] turni al vero Avvento di Tohuwabohu..."
  },
  State_68704_Name = {Text = "L'Arrivo"},
  State_68829_Desc = {
    Text = "Quando si subisce un Danno attivo o Danni da tentacolo, immunità ai danni e si perde 1 stack. Rimosso all'inizio del turno."
  },
  State_68829_Name = {
    Text = "<ParcloseColour:Barriera temporanea>"
  },
  State_68829_WeaponDesc = {
    Text = "Danni subiti -99%. Ogni volta che si subiscono danni, perdi 1 accumulo."
  },
  State_70026_Desc = {
    Text = "Questa carta ha \"Conserva\". Aumenta temporaneamente il Tasso Crit. di tutti i Risvegliati del [StateArg1]% quando giocata, e rimuove \"Dominio immortale\". Se il Reame corrente è Aequor, dopo aver rimosso \"Dominio immortale\", ottieni 1 Arithmetica."
  },
  State_70026_Name = {
    Text = "<OrangeQuality:Dominio immortale>"
  },
  State_70031_Desc = {
    Text = "Unico per Squadra: All'inizio della battaglia, conferisci l'effetto \"Dominio Immortale\" a tutte le Carte di comando nel Mazzo di Pesca con consumo di Arithmetica maggiore o uguale a 3. Questa carta ha l'effetto \"Conservare\". Dopo essere stata giocata, tutti i Risvegliati aumentano temporaneamente il loro Tasso di Crit. di <WeaponEffect_Num:[StateArg1]%> e rimuovono \"Dominio Immortale\". Se il Reame corrente è Aequor, ottieni 1 Arithmetica dopo la rimozione di \"Dominio Immortale\"."
  },
  State_70031_WeaponDesc = {
    Text = "All'inizio della battaglia, conferisci a tutte le Carte di Comando nel Mazzo di Pesca del Portatore con un Costo di Arithmetica pari o superiore a 3 l'effetto \"Dominio Immortale\": questa carta ha \"Conservare\" e, dopo averla giocata, tutti i Risvegliati ottengono temporaneamente un aumento del Tasso Crit. di <WeaponEffect_Num:[StateArg1]%> e \"Dominio Immortale\" viene rimosso. Se il reame corrente è Aequor, ottieni 1 Arithmetica dopo la rimozione di \"Dominio Immortale\"."
  },
  State_70182_Desc = {
    Text = "Tutti gli Scudo del Personaggio ottenuti sono ridotti del [DescArg1]%."
  },
  State_70182_Name = {
    Text = "<FragileColour:Fragile>"
  },
  State_70182_WeaponDesc = {
    Text = "Tutti gli Scudi del Personaggio ottenuti sono ridotti del 33%."
  },
  State_70277_Desc = {
    Text = "Quando si subisce un Danno attivo o Danni da tentacolo, il [StateArg1]% del danno verrà convertito nell'importo di recupero per la Fornace Cremisi, per [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turni\">."
  },
  State_70277_Name = {
    Text = "Rito della Creazione"
  },
  State_70287_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: A fine turno, aumenta il Danno, la Guarigione e lo Scudo del Personaggio delle carte \"Abilità\" del Portatore nella tua mano del [StateArg1]%."
  },
  State_70287_Name = {
    Text = "Trono di Pietra Azzurra"
  },
  State_70288_Desc = {
    Text = "Il Danno, la Guarigione e lo Scudo del Personaggio forniti da questa carta sono aumentati del [DescArg1]%."
  },
  State_70288_Name = {
    Text = "Trono di Pietra Azzurra"
  },
  State_70313_Desc = {
    Text = "Durante le Battaglia Boss, all'inizio del turno e dopo che \"Bambola della Fusione\" attiva Esaltazione, ottieni 1 accumulo di \"<Zhongmowuqiling:Finale>\". \"Finale\" è accumulabile fino a 10 volte e, al raggiungimento di 10 accumuli, aggiungi 1 carta \"Fine dell'Illusione\" alla mano."
  },
  State_70313_Name = {
    Text = "Sentiero dell'Annientamento"
  },
  State_70318_Desc = {
    Text = "Infliggi [StateArg1] <plural value=\"[StateArg1]\" singular=\"turno\" plural=\"turni\"> di <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici, ottieni 1 turno di stato \"Euforia\": Amplificazione del Danno del Team +[StateArg2]%."
  },
  State_70318_Name = {
    Text = "Esaltazione"
  },
  State_70322_Desc = {
    Text = "Quando possiedi 10 accumuli di Finale, colloca 1 \"Fine dell'Illusione\" nella mano."
  },
  State_70322_Name = {
    Text = "Fine Ultima"
  },
  State_70330_Desc = {
    Text = "Ottieni 1 turno di stato \"Euforia\": l'Amplificazione del Danno del team aumenta del [Arg2]%."
  },
  State_70330_Name = {
    Text = "Esaltazione"
  },
  State_70346_Desc = {
    Text = "Infliggi <WeaknessIconKeywords:Debolezza> a tutti i nemici per [StateArg1] turni e riduci la loro <PowerIconKeywords:FOR> di [Exhaustion:StateArg3] in questo turno."
  },
  State_70346_Name = {
    Text = "Maledizione"
  },
  State_70347_Desc = {
    Text = "Riduci la <PowerIconKeywords:FOR> di tutti i nemici di [Exhaustion:StateArg3] in questo turno."
  },
  State_70347_Name = {
    Text = "Maledizione"
  },
  State_70374_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Le prime [StateArg1] volte per turno in cui il portatore subisce un ATK, infligge <PVPEmptinessKeywords:Vuoto> all'attaccante."
  },
  State_70374_Name = {
    Text = "Marionetta dell'Oblio"
  },
  State_70379_Desc = {
    Text = "Infligge <PVPEmptinessKeywords:Vuoto> all'attaccante. Rimuove questo Stato dopo aver subito un attacco."
  },
  State_70379_Name = {
    Text = "Contrattacco del Vuoto"
  },
  State_70443_Desc = {
    Text = "Quando possiedi 10 accumuli di Finale, colloca 1 \"Fine dell'Illusione\" nella mano."
  },
  State_70443_Name = {
    Text = "Fine Ultima"
  },
  State_70539_Name = {
    Text = "Morbo dell'Anima"
  },
  State_70589_Desc = {
    Text = "Giocando 2 carte consecutive con Costo di Arithmetica inferiore alla precedente, infliggi 40/80 Veleno a tutti i nemici. (Max 5 attivazioni per turno)"
  },
  State_70590_Desc = {
    Text = "Dopo aver usato Embrione direttamente per la prima volta ogni turno, il Danno attivo inflitto in questo turno causerà Salasso pari al 15/30% del Danno."
  },
  State_70593_Desc = {
    Text = "Dopo aver giocato una Carta Comando Non-Derivata, riduci il Costo di Arithmetica di quella carta di 2 e mischia 1/2 copie Temporanee di essa nel Mazzo di Pesca. Questo effetto ha un tempo di ricarica di 3 turni."
  },
  State_70594_Desc = {
    Text = "A fine turno, se nella postura Maree crescenti, ottieni 32/64 Danno Tentacolo, con un tempo di recupero di 3 turni."
  },
  State_70595_Desc = {
    Text = "All'inizio della Battaglia, applica 1280 Veleno a tutti i nemici, raddoppiando l'Effetto nelle Battaglie Boss."
  },
  State_70598_Desc = {
    Text = "Ogni volta che una carta entra nello Spazio Ultra, se questa carta appartiene a un proprietario diverso rispetto alle altre carte nello Spazio Ultra, colloca 1/2 dell'Ispirazione In Mano."
  },
  State_70600_Desc = {
    Text = "A fine turno, ripristina 32 HP."
  },
  State_70600_Name = {
    Text = "Sangue Benedetto"
  },
  State_70602_Desc = {
    Text = "Pesca 4 carte dopo il Risveglio di Keyflare."
  },
  State_70603_Desc = {
    Text = "Tutti i Risvegliatori ottengono 10 Aliemus dopo il Risveglio Keyflare."
  },
  State_70605_Desc = {
    Text = "Ottieni 32 Forza dopo il Risveglio Keyflare."
  },
  State_70607_Desc = {
    Text = "Quando giochi due carte consecutive con un Costo di Arithmetica superiore a quello della carta precedente, ottieni 24/48 Contatore. Questo effetto può attivarsi fino a 5 volte per turno."
  },
  State_70609_Desc = {
    Text = "Ottieni 96 Scudo del Personaggio dopo il Risveglio Keyflare."
  },
  State_70609_Name = {
    Text = "Farfalla conservata"
  },
  State_70611_Desc = {
    Text = "Aumenta il DAN Base inflitto da tutti i Risvegliatori del 25%/50% dopo aver eseguito un Keyflare Rouse."
  },
  State_70614_Name = {
    Text = "Mandibola di Radio+"
  },
  State_70617_Desc = {
    Text = "Aumenta i danni dei primi cinque Colpo inflitti ogni turno del 15%/30%."
  },
  State_70618_Desc = {
    Text = "Pesca 1 carta all'inizio del turno."
  },
  State_70619_Desc = {
    Text = "\"Colpo\" infligge il 10%/20% di danni da Veleno, infliggendo fino a 320/640 punti per turno."
  },
  State_70620_Desc = {
    Text = "Quando si viene attaccati dai nemici, infligge un Danno Fisso pari al 25%/50% dei nostri HP massimi. Questo danno beneficia di un bonus Contrattacco del 100%/200% e può attivarsi al massimo una volta per nemico per turno."
  },
  State_70620_Name = {
    Text = "Pugnale Rituale"
  },
  State_70621_Desc = {
    Text = "Ottieni 192 Scudo del Personaggio dopo il Keyflare Rouse."
  },
  State_70621_Name = {
    Text = "Esemplare di farfalla+"
  },
  State_70623_Desc = {
    Text = "Tutti i Risvegliati ottengono 10 Aliemus a inizio turno."
  },
  State_70624_Desc = {
    Text = "Tutti i Risvegliatori ottengono 20 Aliemus dopo il Risveglio Keyflare."
  },
  State_70628_Desc = {
    Text = "All'inizio del turno, pesca 2 carte."
  },
  State_70629_Desc = {
    Text = "Al primo Divorare di ogni turno, gli altri Risvegliatori ottengono 10/20 Aliemus."
  },
  State_70635_Desc = {
    Text = "Ottieni 416 Contatore dopo il Keyflare Rouse."
  },
  State_70636_Desc = {
    Text = "La Fornace Cremisi concede il 10%/20% della quantità di PV persi alla perdita di un PV."
  },
  State_70637_Desc = {
    Text = "All'inizio della Battaglia, aumenta il Limite Tentacoli di 1/2 e ottieni 1/2 Tentacolo."
  },
  State_70641_Desc = {
    Text = "Ottieni 160/320 Scudo del Personaggio dall'Annientamento, con un tempo di recupero di 3 turni."
  },
  State_70641_Name = {
    Text = "Orologio a Supercorde"
  },
  State_70643_Desc = {
    Text = "A inizio turno, ottieni 1 Arithmetica."
  },
  State_70644_Desc = {
    Text = "Dopo aver scatenato l'Esaltazione, ottieni 16/32 FOR temporanea."
  },
  State_70645_Desc = {
    Text = "A inizio turno, ottieni 2 Arithmetica."
  },
  State_70646_Name = {
    Text = "Pugnale Rituale+"
  },
  State_70647_Desc = {
    Text = "Tutti i Risvegliati aumentano il DAN Base del 30%."
  },
  State_70648_Desc = {
    Text = "All'inizio della battaglia, applica 640 Veleno a tutti i nemici, raddoppiando l'effetto nelle Battaglia Boss."
  },
  State_70656_Desc = {
    Text = "\"Attacco\" infligge 1/2 istanza aggiuntiva di DAN pari al 60% dell'Attacco del Risvegliato, attivabile fino a 3 volte per turno."
  },
  State_70657_Desc = {
    Text = "A inizio battaglia, ottieni 32 Forza."
  },
  State_70660_Desc = {
    Text = "A inizio battaglia, ottieni 64 Forza."
  },
  State_70661_Desc = {
    Text = "A fine turno, ripristina 64 HP."
  },
  State_70661_Name = {
    Text = "Sangue benedetto+"
  },
  State_70662_Desc = {
    Text = "Ottieni 2 Arithmetica dopo il Risveglio Keyflare."
  },
  State_70664_Desc = {
    Text = "Ottieni 16 Forza dopo il Risveglio Keyflare."
  },
  State_70666_Desc = {
    Text = "All'inizio della battaglia, ottieni 100/200 Padronanza del Reame. Il Veleno base inflitto da tutti i Risvegliati e il Veleno inflitto dalle Reliquie aumentano del 10%/20%."
  },
  State_70667_Desc = {
    Text = "Ottieni 4 Arithmetica dopo il Risveglio Keyflare."
  },
  State_70670_Desc = {
    Text = "All'inizio della Battaglia, ottieni 320 Contatore. Nelle Battaglie Boss, l'Effetto è raddoppiato."
  },
  State_70671_Desc = {
    Text = "Dopo essere entrati nel Turno Ultra, la prima Carta Comando Non-Derivata giocata si attiverà ulteriormente 1/2 volte."
  },
  State_70678_Desc = {
    Text = "All'inizio della Battaglia, ottieni 640 Contatore. Nelle Battaglie Boss, l'Effetto è raddoppiato."
  },
  State_70681_Desc = {
    Text = "Tutti i Risvegliati aumentano il DAN Base del 60%."
  },
  State_70682_Desc = {
    Text = "Quando il numero di carte in mano è inferiore o uguale a 2, pesca 1/2 carte. Questo effetto può essere attivato fino a 2 volte per turno."
  },
  State_70683_Desc = {
    Text = "Il Risvegliatore con meno Aliemus ottiene 50/100 Aliemus, con un tempo di ricarica di 3 turni."
  },
  State_70684_Desc = {
    Text = "All'inizio del turno, se i PV sono inferiori al 25%, ottieni 72/144 FOR temporanea."
  },
  State_70685_Desc = {
    Text = "Applica 416 Veleno a tutti i nemici dopo il Risveglio Keyflare."
  },
  State_70686_Desc = {
    Text = "Dopo aver scatenato l'Esaltazione, tutti i nemici subiscono <FixedDamage:DAN Puro> pari al 15%/30% della tua Salute massima e vengono afflitti con Veleno al 10%/20%."
  },
  State_70687_Name = {
    Text = "Orologio da Tasca Ipercorda+"
  },
  State_70689_Desc = {
    Text = "Applica 832 Veleno a tutti i nemici dopo il Risveglio Keyflare."
  },
  State_70690_Desc = {
    Text = "All'inizio della battaglia, ottieni 100/200 Padronanza del Reame. Il Contatore base inflitto da tutti i Risvegliati e il Contatore inflitto dalle Reliquie aumentano del 10%/20%."
  },
  State_70691_Desc = {
    Text = "Ottieni 4/8 FOR temporanea ogni volta che viene inflitto Danno, attivabile fino a 15 volte per turno."
  },
  State_70693_Desc = {
    Text = "Quantità di acquisizione automatica di Fusione Embrionale aumentata del 100%/200%."
  },
  State_70694_Desc = {
    Text = "Pesca 2 carte dopo il Risveglio di Keyflare."
  },
  State_70695_Desc = {
    Text = "A inizio turno, tutti i Risvegliati ottengono 5 Aliemus."
  },
  State_70696_Desc = {
    Text = "Ottieni 208 Contatore dopo il Keyflare Rouse."
  },
  State_70698_Desc = {
    Text = "La Difesa ottiene 200/400 contatori Temporanei, attivabili un massimo di 3 volte per turno."
  },
  State_70804_Name = {
    Text = "Limite di Tempo di Vita e Morte"
  },
  State_70805_Desc = {
    Text = "All'inizio della battaglia, applica 1/2 cariche di Debolezza a tutti i nemici, raddoppiando l'effetto sui Boss. Tutti i Risvegliati aumentano il proprio DAN Base del 15%/30%."
  },
  State_70806_Name = {
    Text = "Mano del guardiano+"
  },
  State_70808_Desc = {
    Text = "In posizione Mare Tranquillo, infliggi 64/128 Risucchio a tutti i nemici. Tempo di ricarica: 3 turni."
  },
  State_70809_Desc = {
    Text = "A inizio turno, se i PV sono inferiori al 25%, ottieni 100/200 Scudo del Personaggio."
  },
  State_70809_Name = {
    Text = "Mano del Guardiano"
  },
  State_70810_Desc = {
    Text = "Attiva immediatamente tutti gli Attacchi del tentacolo sui nemici usando la postura Onda di Rabbia 1/2 volte, con un tempo di ricarica di 3 turni."
  },
  State_70812_Desc = {
    Text = "All'inizio della battaglia, applica 1/2 cariche di Vulnerabile a tutti i nemici, raddoppiando l'effetto sui Boss. Tutti i Risvegliati aumentano il proprio DAN Base del 15%/30%."
  },
  State_70832_Desc = {
    Text = "Unico per Squadra: All'inizio della Battaglia, l'equipaggiato ottiene Aliemus pari al <WeaponEffect_Num:[StateArg1]%> della Ricarica Aliemus del Portatore. Dopo che l'equipaggiato attiva Exalt per la prima volta in ogni Battaglia, questo effetto si ripete una volta."
  },
  State_70832_WeaponDesc = {
    Text = "All'inizio della battaglia, il portatore ottiene Esaltazione pari al <WeaponEffect_Num:[StateArg1]%> della Ricarica Aliemus del portatore (<WeaponEffect_Num:[DescArg1]>). Dopo che il portatore rilascia l'Esaltazione per la prima volta in ogni battaglia, questo effetto si ripete una volta."
  },
  State_70835_Desc = {
    Text = "Unico per Squadra: Gli effetti di Aliemus, Veleno e Recupero PV del Portatore sono aumentati del <WeaponEffect_Num:[StateArg1]%>. Dopo che il Portatore attiva Exalt, ottiene Aliemus pari al <WeaponEffect_Num:[StateArg2]%> degli Aliemus consumati."
  },
  State_70835_WeaponDesc = {
    Text = "Gli effetti di Aliemus, Veleno e Recupero PV del portatore aumentano del <WeaponEffect_Num:[StateArg1]%>. Dopo che il portatore rilascia l'Esaltazione, ottiene una quantità di Aliemus pari al Consumo Aliemus di questa istanza moltiplicato per <WeaponEffect_Num:[StateArg2]>."
  },
  State_70989_Desc = {
    Text = "Dopo aver usato Esaltazione 4 volte in un turno, ottieni 3/6 Arithmetica, con un tempo di recupero di 3 turni."
  },
  State_71001_Desc = {
    Text = "Dopo aver giocato 4 Carte di comando appartenenti a Risvegliatori diversi in un turno, tutti i Risvegliatori guadagnano 20/40 Aliemus, con un tempo di ricarica di 3 turni."
  },
  State_71153_Desc = {
    Text = "A inizio turno, Caecus ottiene 15 Aliemus. Quando Caecus ottiene uno Scudo del Personaggio, recupera il 50% dell'ammontare dello Scudo del Personaggio come HP."
  },
  State_71154_Desc = {
    Text = "All'inizio del turno, Aigis ottiene 15 Aliemus. Quando Aigis infligge danni ai nemici con Vulnerabile, ruba 10 della loro FOR temporanea, con un effetto massimo di 5 volte per turno."
  },
  State_71155_Desc = {
    Text = "A inizio turno, Leigh ottiene 15 Aliemus. Ogni volta che perde PV, ottiene 8 Forza, accumulabile fino a 10 volte per battaglia. Dopo 10 accumuli, \"Dolore e Piacere\" ha un Costo di Arithmetica di 1, aumentando il suo conteggio di danni di 1."
  },
  State_71156_Desc = {
    Text = "A inizio turno, Agrippa ottiene 15 Aliemus. \"Elemosina riluttante\" ridurrà inoltre il Costo di Arithmetica di Agrippa di 1 per questo turno, attivandosi un massimo di una volta per turno."
  },
  State_71157_Desc = {
    Text = "A inizio turno, Sanga ottiene 15 Aliemus. All'inizio della battaglia, conferisci a tutte le Carte di comando di Sanga Conservare e Preparazione 1, e ottieni 24 Scudo del Personaggio."
  },
  State_71157_Name = {
    Text = "Immagine Dimensione · Sanga"
  },
  State_71158_Desc = {
    Text = "A inizio turno, la Bambola ottiene 15 Aliemus. Dopo l'inizio della battaglia, imposta il Costo di Arithmetica di \"Scambio Equivalente\" della Bambola a 0. Una volta giocata, pesca 2 carte extra nel turno successivo."
  },
  State_71159_Desc = {
    Text = "A inizio turno, Faros ottiene 15 Aliemus. Per ogni istanza di DAN da Tentacolo inflitta, aumenta il Veleno causato da Faros in questa battaglia dell'1%, fino a un massimo del 100%."
  },
  State_71160_Desc = {
    Text = "All'inizio del turno, \"24\" ottiene 15 Aliemus. Se \"24\" è nella \"Personalità Depressa\", ottiene 25 Aliemus aggiuntivi; se è nella \"Personalità Maniacale\", aumenta temporaneamente il Tasso Crit. e il Danno Crit. di \"24\" del 35%."
  },
  State_71161_Desc = {
    Text = "A inizio turno, Faint ottiene 15 Aliemus. Ogni volta che la Resistenza alla Morte viene attivata, aumenta gli effetti di Scudo, Contatore e Recupero PV causati da Faint durante questa esplorazione del 20%, fino a un massimo di 5 volte."
  },
  State_71162_Desc = {
    Text = "A inizio turno, Golia ottiene 15 Aliemus. Se Golia infligge DAN 3 volte in 1 turno, i DAN inflitti da Golia in questa battaglia ottengono un bonus di FOR aggiuntivo di 1x, con un tempo di ricarica di 3 turni."
  },
  State_71163_Desc = {
    Text = "All'inizio del turno, Helot: Catena ottiene 15 Aliemus. Il Danno attivo di Helot: Catena applica un ulteriore 20% di Salasso, e uccidere un nemico infligge Salasso pari al danno in eccesso sugli altri nemici."
  },
  State_71164_Desc = {
    Text = "A inizio turno, Aurita ottiene 15 Aliemus. Il conteggio danni di \"Divisione Ghiandolare\" aumenta di 1 e, dopo aver giocato la \"Difesa\" di Aurita, mette 1 \"Divisione Ghiandolare\" in mano."
  },
  State_71166_Desc = {
    Text = "A inizio turno, Lily ottiene 15 Aliemus. Il limite di Resistenza di Lily aumenta del 100% e, quando usa \"Fiore Immortale sulla Melma\" o \"Colpo di Protezione\", ripristina l'8% dei PV per ogni accumulo di \"Resistenza\"."
  },
  State_71167_Desc = {
    Text = "A inizio turno, Lotan ottiene 15 Aliemus. Dopo il primo utilizzo della \"Difesa\" di Lotan ogni turno, metti 2 \"Lama della Sfida\" con Esaurimento e Fugace in mano."
  },
  State_71168_Desc = {
    Text = "A inizio turno, Pandia ottiene 15 Aliemus. A inizio turno, ottieni 64 Contatore. Per ogni 4 Contatore non Temporaneo, i DAN inflitti dalla Carta di comando di \"Pandia\" aumentano di 1."
  },
  State_71169_Desc = {
    Text = "All'inizio del turno, l'Ilota ottiene 15 Aliemus. Ogni volta che una carta viene scartata, \"Ilota\" ottiene 5 Aliemus."
  },
  State_71170_Desc = {
    Text = "A inizio turno, Tawil ottiene 15 Aliemus. Se 6 Carte di comando di Tawil vengono giocate in un turno, metti 1 \"Aurora della Chiave d'Argento\" in mano. Ricarica: 3 turni."
  },
  State_71171_Desc = {
    Text = "A inizio turno, Miryam ottiene 15 Aliemus e aggiunge 1 \"Sacramento\" alla mano."
  },
  State_71172_Desc = {
    Text = "A inizio turno, Doll: Inferno ottiene 15 Aliemus. Dopo che Doll: Inferno rilascia l'Esaltazione, ogni 20 Aliemus consumati concedono 1 Aliemus agli altri Risvegliati."
  },
  State_71173_Desc = {
    Text = "A inizio turno, Salvador ottiene 15 Aliemus. Ogni volta che accumula Fornace Cremisi, ottiene anche FOR pari al 5% della quantità accumulata. \"Colpo\" e \"Fine della Sofferenza\" di Salvador ricevono inoltre un bonus di FOR di 1x."
  },
  State_71175_Desc = {
    Text = "All'inizio del turno, Nautila ottiene 15 Aliemus. Dopo aver usato \"Esaltazione\" di Nautila, ottiene Contatore pari al 50% dello Scudo del Personaggio attuale, attivabile fino a 1 volta per turno."
  },
  State_71177_Desc = {
    Text = "A inizio turno, Liz ottiene 15 Aliemus. Le carte scartate da \"Danza verso la distruzione\" ottengono un effetto aggiuntivo una volta, con un tempo di ricarica di 3 turni."
  },
  State_71178_Desc = {
    Text = "A inizio turno, Ramona ottiene 15 Aliemus. Ogni 3ª Carta di comando giocata da Ramona conferisce un effetto aggiuntivo 1 volta."
  },
  State_71179_Desc = {
    Text = "A inizio turno, Uvhash ottiene 15 Aliemus. Consumo Aliemus dell'Esaltazione di Uvhash -10, ulteriormente ridotto di 5 ogni volta che rilascia l'Esaltazione. Può rilasciare l'Esaltazione 2 volte per turno."
  },
  State_71180_Desc = {
    Text = "A inizio turno, Alva ottiene 15 Aliemus. Se Alva ha giocato 2 \"Difesa\" nel turno precedente, aggiunge alla mano una \"Lama di Precisione\" consumata; se Alva ha giocato 2 \"Attacco\", aggiunge alla mano 1 \"Postura di combattimento\" consumata."
  },
  State_71181_Desc = {
    Text = "A inizio turno, Sorel ottiene 15 Aliemus. Per ogni istanza di Danno inflitta, Fusione Embrionale +10, fino a 10 volte per turno. Dopo aver raggiunto 10 attivazioni, Danno critico di Sorel +20% per questa battaglia."
  },
  State_71182_Desc = {
    Text = "All'inizio del turno, Hameln ottiene 15 Aliemus. Il Costo di Arithmetica di \"Ouverture dell'Anima\" è ridotto di 1 e il conteggio del DAN Base è aumentato di 1."
  },
  State_71183_Desc = {
    Text = "A inizio turno, Thais ottiene 15 Aliemus. Dopo aver giocato 3 Carte di comando in un turno, Thais ottiene 1 \"Rampollo della Purezza\" e 72 FOR temporanea, con un tempo di recupero di 3 turni."
  },
  State_71187_Desc = {
    Text = "A inizio turno, Celeste ottiene 15 Aliemus. Prima della fine del turno, per ogni Carta di comando di Celeste in mano, 1 Tentacolo attacca un nemico e ripristina 8 PV."
  },
  State_71188_Desc = {
    Text = "A inizio turno, Murphy ottiene 15 Aliemus. \"Colpo\" e \"Difesa\" di Murphy possono convertire il 25% del \"Sacrificio\" in Danno tentacolo temporaneo, ma può attivarsi solo una volta per turno."
  },
  State_71189_Desc = {
    Text = "A inizio turno, Nymphaea ottiene 15 Aliemus. Dopo aver usato l'\"Attacco\" di Nymphaea, il Veleno inflitto da \"Nymphaea\" in questa battaglia aumenta del 20%. Dopo aver usato la \"Difesa\" di Nymphaea, infligge il 50% di Veleno a tutti i nemici. Ogni effetto può attivarsi al massimo una volta per turno."
  },
  State_71190_Desc = {
    Text = "All'inizio del turno, Ogier ottiene 15 Aliemus. Dopo la prima volta che Ogier gioca \"Lancia Perforante\" o \"Colpo\" in ogni turno, lo Scudo e la FOR generati da Ogier in quel turno aumentano del +50%."
  },
  State_71191_Desc = {
    Text = "A inizio turno, Ryker ottiene 15 Aliemus. Il risultato del primo lancio di dado di ogni turno è sempre 6."
  },
  State_71192_Desc = {
    Text = "All'inizio del turno, Circuito·Ramona ottiene 15 Aliemus. La prima volta che \"Loop\" viene attivato ogni turno, ottieni 500 Keyflare e 1 accumulo di \"Negentropia\"."
  },
  State_71193_Desc = {
    Text = "A inizio turno, Tulu ottiene 15 Aliemus. Il consumo di Aliemus per Tulu è ridotto di 10 punti e, dopo aver rilasciato l'Esaltazione, genera istantaneamente 2 Tentacoli Temporanei."
  },
  State_71194_Desc = {
    Text = "All'inizio del turno, Karen ottiene 15 Aliemus. Giocare \"Fedeltà Silenziosa\" restituirà il doppio dell'Arithmetica esaurita, con un tempo di ricarica di 3 turni."
  },
  State_71271_Desc = {
    Text = "A inizio turno, Horla ottiene 15 Aliemus. A inizio battaglia, ottiene 1 carica di \"Metafora\" per tutte le emozioni. L'effetto \"Metafora\" +50%."
  },
  State_71272_Desc = {
    Text = "A inizio turno, Jenkin ottiene 15 Aliemus e il Danno Finale aumenta del 5%. Il DAN Base e la crescita dei DAN di \"Prendeteli! Brown!\" aumentano del 200%."
  },
  State_71273_Desc = {
    Text = "A inizio turno, Daffodil ottiene 15 Aliemus e 1 \"Intuizione\". Ogni volta che gioca \"Marea Eterogenea\", la Forza ottenuta durante questa esplorazione aumenta permanentemente del 25%, fino al 300%."
  },
  State_71274_Desc = {
    Text = "A inizio turno, Tintura ottiene 15 Aliemus. Quando la Carta di comando di Tintura attiva Balzo, restituiscila alla sua mano, con un massimo di 3 attivazioni per turno."
  },
  State_71275_Desc = {
    Text = "A inizio turno, Wanda ottiene 15 Aliemus e riceve 1 accumulo di \"Esca Onirica\". Se è un Turno Ultra, colloca inoltre 1 \"Catene di Aghi Spinali\" Temporaneo e \"Custode degli Smarriti\" in mano."
  },
  State_71276_Desc = {
    Text = "A inizio turno, Erica ottiene 15 Aliemus. Dopo aver giocato 3 Carte di comando in un turno, Erica ottiene 1 \"Intuizione\" e raddoppia i bonus di Forza e Allerta di \"Esplosione Elettromagnetica\" in questa battaglia."
  },
  State_71277_Desc = {
    Text = "A inizio turno, Casiah ottiene 15 Aliemus. Pescare 1 carta conferisce a Casiah 1 punto di Aliemus. Quando Casiah scatena l'Esaltazione, tutti i nemici perdono 32 Forza."
  },
  State_71278_Desc = {
    Text = "A inizio turno, Winkle ottiene 15 Aliemus. Ogni volta che un altro Risvegliato scatena l'Esaltazione, Winkle ottiene 5 Aliemus e il Costo di Arithmetica di \"Psiche Riforgiata\" in mano è ridotto di 1."
  },
  State_71279_Desc = {
    Text = "L'Amplificazione del Danno del Team aumenta del [StateArg1]%, per [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turni\">."
  },
  State_71279_Name = {
    Text = "Esaltazione"
  },
  State_71503_Name = {
    Text = "\"Forma Finale\": Pesca 3 carte aggiuntive, ottieni 3 Arithmetica, attiva [DescArg1] % <IntoxicationIconKeywords:Veleno> su tutti i nemici, aumenta il Limite Aliemus di \"Doll: Inferno\" di 50, fino a 3 volte"
  },
  State_71581_Name = {
    Text = "Attitudine Forgianima"
  },
  State_71589_Name = {
    Text = "Innesca 1 Attacco del tentacolo contro il nemico e ripristina 8."
  },
  State_71605_Name = {
    Text = "Ottieni [StateArg1] Scudo"
  },
  State_71650_Desc = {
    Text = "Alla morte, viene rianimato e richiama un numero variabile di cloni. Sorprendentemente, non ottiene alcun effetto di Fortezza o Immunità alla rinascita. L'effetto può ancora essere attivato [Layer] volte."
  },
  State_71650_Name = {
    Text = "Bestia delle Mille Dimensioni"
  },
  State_71651_Desc = {
    Text = "Ogni volta che perdi PV, perdi [StateArg1] FOR temporanea. Può ancora avere effetto [Layer] volte e il numero di attivazioni si ripristina all'inizio del turno."
  },
  State_71651_Name = {
    Text = "Cilindro del Gentiluomo"
  },
  State_71707_Desc = {
    Text = "Per ogni istanza di Danno attivo subito, recupera [StateArg1] Vita, per [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turni\">."
  },
  State_71707_Name = {
    Text = "Caecus: Supporto"
  },
  State_71708_Desc = {
    Text = "A fine turno, per ogni Carta In Mano, tutti i Risvegliati ottengono [DescArg1] Aliemus."
  },
  State_71708_Name = {
    Text = "Casiah: Supporto"
  },
  State_71709_Desc = {
    Text = "A fine turno, ottieni 35 Aliemus per [Layer] turni."
  },
  State_71709_Name = {
    Text = "Winkle: Supporto"
  },
  State_71711_Desc = {
    Text = "Il Danno inflitto dal Risvegliato aumenta del 25% e dura per [Layer] turni."
  },
  State_71711_Name = {
    Text = "Jenkin: Supporto"
  },
  State_71712_Desc = {
    Text = "Quando si infligge Danno attivo, attiva 1 attacco del Tentacolo una volta, per [Layer] <plural value=\"[Layer]\" singular=\"turno\" plural=\"turni\">."
  },
  State_71712_Name = {
    Text = "Aurita: Supporto"
  },
  State_71712_WeaponDesc = {
    Text = "Quando Hydromedusa infligge Danni, attiva [StateArg1] Attacchi del tentacolo sul bersaglio."
  },
  State_71713_Desc = {
    Text = "Ogni volta che si esegue \"Divorare\", pesca 2 \"Colpo\" e riduci il loro Costo di Arithmetica di 1, per [Layer] turni."
  },
  State_71713_Name = {
    Text = "Helot: Supporto"
  },
  State_71740_Desc = {
    Text = "Ottieni [Layer] Scudo del Personaggio all'inizio del prossimo turno."
  },
  State_71740_Name = {
    Text = "Leigh: Scudo di Supporto"
  },
  State_71741_Desc = {
    Text = "All'inizio del prossimo turno, ottieni uno Scudo del Personaggio pari ai PV persi in questo turno, della durata di [Layer] turni."
  },
  State_71741_Name = {
    Text = "Leigh: Supporto"
  },
  State_71741_WeaponDesc = {
    Text = "A inizio del turno successivo, ottieni Scudo del Personaggio pari alla quantità di HP persi nel turno precedente."
  },
  State_71742_Desc = {
    Text = "Il Danno da \"Colpo\" aumenta del [Layer]%."
  },
  State_71742_Name = {
    Text = "Helot: Supporto"
  },
  State_71742_WeaponDesc = {
    Text = "In questo turno, i DAN delle tue Carte Colpo sono potenziati del [Layer]%."
  },
  State_71837_Desc = {
    Text = "All'inizio del prossimo turno, ottieni Vulnerabile."
  },
  State_71837_Name = {
    Text = "Vulnerabilità Ritardata"
  },
  State_71839_Desc = {
    Text = "Quando usi \"Risveglio\", ottieni [Layer] Arithmetica. Se il Reame attuale è \"Aequor\", vengono generati temporaneamente [Layer] Tentacoli aggiuntivi."
  },
  State_71839_Name = {
    Text = "Protezione Stellare"
  },
  State_71856_Desc = {
    Text = "Ogni volta che perdi PV, perdi [StateArg1] FOR temporanea. Può ancora avere effetto [Layer] volte e il numero di attivazioni si ripristina all'inizio del turno."
  },
  State_71856_Name = {
    Text = "Cilindro del Gentiluomo"
  },
  State_72016_Name = {
    Text = "Maestria di Caro"
  },
  State_72018_WeaponDesc = {
    Text = "Ogni volta che si subiscono DAN, l'Aliemus di tutti i Risvegliati aumenta di 1."
  },
  State_72033_Desc = {Text = "—"},
  State_72033_Name = {Text = "Tentacolo"},
  State_72033_WeaponDesc = {Text = "—"},
  State_72034_Desc = {Text = "—"},
  State_72034_WeaponDesc = {Text = "—"},
  State_72036_Name = {
    Text = "Inizializzazione Classe Caos"
  },
  State_72079_Name = {
    Text = "Onde Furiose"
  },
  State_72102_Desc = {
    Text = "L'esperienza di gioco classica di \"Morimens\"."
  },
  State_72102_Name = {
    Text = "Capitolo dell'Oblio"
  },
  State_72137_Name = {
    Text = "Overflow di Arithmetica"
  },
  State_72206_Name = {
    Text = "Progresso Ricerca \"[DescArg1]/15\""
  },
  State_72208_Name = {
    Text = "Progresso della ricerca \"[DescArg1]/2\""
  },
  State_72212_Name = {
    Text = "Progresso Ricerca \"[DescArg1]/10\""
  },
  State_72213_Name = {
    Text = "Progresso Ricerca \"[DescArg1]/30\""
  },
  State_72220_Name = {
    Text = "Progresso della ricerca \"[DescArg1]/5\""
  },
  State_73518_Desc = {
    Text = "Il Danno inflitto è aumentato del 100%. Lo stato viene rimosso alla perdita di PV, ma viene concesso uno Scudo del Personaggio pari al 50% dei PV massimi."
  },
  State_73518_Name = {
    Text = "\"Assassino\""
  },
  State_73520_Desc = {
    Text = "Al momento della morte, conserva 1 punto di HP e diventa immune a tutti i Danni, convertendo l'Intenzione in \"Rilascio della Connessione\"."
  },
  State_73520_Name = {
    Text = "\"Connettore\""
  },
  State_73533_Desc = {
    Text = "Non scartare più carte alla fine dei turni. All'inizio della battaglia, imposta il limite della mano a 8."
  },
  State_73533_Name = {
    Text = "Risonanza dell'Alveare"
  },
  State_73535_Desc = {
    Text = "Durante il tuo turno, il Danno subito è ridotto del 75%. Quando la Forza viene ridotta, solo il 50% degli accumuli di Forza verrà diminuito."
  },
  State_73535_Name = {
    Text = "Autoprotezione"
  },
  State_73566_Desc = {
    Text = "Per ogni carta non di comando giocata, ottieni [Power:StateArg1] <PowerIconKeywords:FOR> e <Block:[Block:StateArg2]> Scudo del Personaggio."
  },
  State_73566_Name = {
    Text = "\"Comunicatore\""
  },
  State_73567_Desc = {
    Text = "Per ogni carta non di comando giocata, ottieni [Power:StateArg1] <PowerIconKeywords:FOR> e <Block:[Block:StateArg2]> Scudo del Personaggio."
  },
  State_73567_Name = {
    Text = "\"Comunicatore\""
  },
  State_73570_Desc = {
    Text = "Per ogni carta non di comando giocata, ottieni [Power:StateArg1] <PowerIconKeywords:FOR> e <Block:[Block:StateArg2]> Scudo del Personaggio."
  },
  State_73570_Name = {
    Text = "\"Comunicatore\""
  },
  State_73573_Desc = {
    Text = "Per ogni carta non di comando giocata, ottieni [Power:StateArg1] <PowerIconKeywords:FOR> e <Block:[Block:StateArg2]> Scudo del Personaggio."
  },
  State_73573_Name = {
    Text = "\"Comunicatore\""
  },
  State_73649_Desc = {
    Text = "Amplificazione del Danno della squadra aumentata del [Layer]%."
  },
  State_73649_Name = {
    Text = "Marionetta dell'Oblio"
  },
  State_73655_Name = {
    Text = "Identificatore di Forma Organica"
  },
  State_73664_Name = {
    Text = "Effetto Accessorio Forma Organica"
  },
  State_73664_WeaponDesc = {
    Text = "Dopo che il Portatore usa Esaltazione, il suo Scudo e il suo Pot. Guarigione vengono raddoppiati per questo turno."
  },
  State_74012_Desc = {
    Text = "Infligge [StateArg1]% degli HP massimi di tutti i nemici come <RealDamage:Danno Fisso> (minimo [DescArg1]). Dopo l'uso, l'abilità specifica di \"Doll: Inferno\" cambia in \"Finale\"."
  },
  State_74012_Name = {
    Text = "Fine dell'Illusione"
  },
  State_74013_Desc = {
    Text = "Infligge [StateArg1]% degli HP massimi di tutti i nemici come <RealDamage:Danno Fisso>. Questo Danno non può essere inferiore al 500% degli HP massimi del lanciatore. Dopo l'uso, l'abilità specifica di \"Doll: Inferno\" cambia in \"Finale\"."
  },
  State_74013_Name = {
    Text = "Fine dell'Illusione"
  },
  State_74014_Desc = {
    Text = "Infligge [StateArg1]% degli HP massimi di tutti i nemici come <RealDamage:Danno Fisso> (questo Danno non può essere inferiore al 500% dei propri HP massimi), ripristina il 30% degli HP persi. Dopo l'uso, l'abilità specifica di \"Doll: Inferno\" cambia in \"Finale\"."
  },
  State_74014_Name = {
    Text = "Fine dell'Illusione"
  },
  State_74015_Desc = {
    Text = "Infligge [StateArg1]% degli HP massimi di tutti i nemici come <RealDamage:Danno Fisso> (minimo [DescArg1]), ripristinando <Heal:[Heal:DescArg2]> punti di HP, e dopo l'uso, l'abilità specifica di \"Doll: Inferno\" cambia in \"Finale\"."
  },
  State_74015_Name = {
    Text = "Fine dell'Illusione"
  },
  State_74019_Desc = {
    Text = "Veleno, Contatore e DAN Base di tutti i Risvegliatori +[Layer]%."
  },
  State_74019_Name = {
    Text = "Infezione della Follia"
  },
  State_74142_Desc = {
    Text = "All'inizio dell'esplorazione, COS, ATT e DIF aumentano del [StateArg1]%."
  },
  State_74142_Name = {
    Text = "Attitudine Forgianima"
  },
  State_74219_Name = {
    Text = "Torna nella tua mano dopo essere stata giocata"
  },
  State_74273_Desc = {
    Text = "Quando Helot: Catena infligge Danno attivo, applica [StateArg1]% di Salasso, con durata di [Layer] turni."
  },
  State_74273_Name = {
    Text = "Catene Sanguigne"
  },
  State_74771_Desc = {
    Text = "La quantità di Aliemus necessaria per attivare un'Esaltazione."
  },
  State_74771_Name = {
    Text = "Limite Aliemus"
  },
  State_74788_Desc = {
    Text = "\nParadosso dell'Esistenza: All'inizio dell'esplorazione, il 75% della Resistenza alla Morte viene convertito in bonus ai PV massimi, con una conversione massima del 300% di Resistenza alla Morte, aumentando i PV massimi fino al 10%. Ogni volta che la Resistenza alla Morte viene attivata, un \"Bagliore della Chiave d'Argento\" aggiuntivo viene aggiunto alla mano. \nCicatrice Senza Fondo: Nelle Battaglie Boss, per ogni 100% del limite di PV raggiunto dalle cure ricevute dal nostro schieramento, gli effetti curativi successivi vengono ridotti del 25%, ma la Resistenza alla Morte totale aumenta del 25%, attivandosi fino a 3 volte. \nLente Prismatica: All'inizio del turno, se il Contrattacco supera il 750% del limite di PV, le cariche in eccesso vengono dimezzate, e il Contrattacco Permanente può accumularsi fino al 2250% del limite di PV; se il nemico è Avvelenato oltre il 1000% del limite di PV, le cariche in eccesso vengono dimezzate, e il Veleno può accumularsi fino al 3000% del limite di PV. Per ogni 4% dell'attributo Amplificazione del Danno della squadra, i limiti totali sopra indicati possono essere aumentati dell'1%. Il bonus ai danni da Contrattacco del Risvegliato è ridotto del 70%, ma tutti i danni da Veleno e Contrattacco inflitti sono aumentati del 10%. All'inizio del turno del nemico, per ogni Gnosi attivata, si ottiene il 25% del Contrattacco Permanente attuale come Contrattacco Temporaneo, e si attiva il 25% di Veleno su tutti i nemici. \nCono di Luce del Destino: Il numero di turni necessari ai Mostri ordinari per rilasciare lo \"Sguardo\" viene modificato a 6 turni. Tutte le battaglie hanno un limite di 15 turni, ma all'inizio del 15° turno, viene aggiunto un \"Confine del Cono di Luce\" alla mano: Keyflare e Aliemus di tutti i Risvegliati vengono portati al massimo."
  },
  State_74788_Name = {
    Text = "(Scarto Temporaneo)"
  },
  State_74791_Desc = {
    Text = "\nArmonia di Arithmetica: Per ogni Carta di comando giocata dopo la 10ª in un turno, guadagna 1 \"Armonia di Arithmetica\". Ogni accumulo aumenta il costo della carta di 1 Arithmetica, che viene poi convertita nel 100% della Ricarica della chiave d'argento del Risvegliatore (cumulabile). Gli accumuli si azzerano all'ingresso nell'Ultra Spazio.\nOverflow Aritmetico: Quando si gioca una carta, rimuove il suo effetto di riduzione del Costo di Arithmetica in questo turno. Quando l'Arithmetica corrente supera 12, ogni punto in eccesso viene convertito nel 300% della Ricarica della chiave d'argento media del team.\nArmonia di Aliemus: L'effetto dell'aumento percentuale di Aliemus è dimezzato. Ogni Esaltazione aumenta la Base Aliemus di 10. Guadagna il 200% della Ricarica della chiave d'argento media del team alla fine del turno per ogni Risvegliatore che non ha Esaltato."
  },
  State_74791_Name = {
    Text = "Armonia del Keyflare"
  },
  State_74809_Name = {
    Text = "\"Forma Finale\": Pesca 3 carte aggiuntive, ottieni 3 Arithmetica, attiva [DescArg1] % <IntoxicationIconKeywords:Veleno> su tutti i nemici, aumenta il Limite Aliemus di \"Doll: Inferno\" di 50, fino a 3 volte"
  },
  State_74826_Name = {
    Text = "Infliggi casualmente [DescArg1] <FixedDamage:DAN Puro> [DescArg2] <plural value=\"[DescArg2]\" singular=\"volta\" plural=\"volte\"> (beneficia di 1× <PowerIconKeywords:STR>)"
  },
  State_74827_Name = {
    Text = [[

Ottieni +[DescArg1]% Tasso critico temporaneo e Danno Crit.]]
  },
  State_74828_Name = {
    Text = [[

Infliggi [DescArg1] <IntoxicationIconKeywords:Veleno> a tutti i nemici]]
  },
  State_74829_Name = {
    Text = "Infliggi <FixedDamage:DAN Puro> a tutti i nemici pari al [DescArg1]% della loro Vita mancante"
  },
  State_74830_Name = {
    Text = "Ottieni [DescArg1] Forza"
  },
  State_74831_Name = {
    Text = [[

Concedi a tutti i Risvegliatori <Energy:[DescArg1]> Aliemus]]
  },
  State_74847_Desc = {
    Text = "Unico per Squadra: Il DAN Base inflitto dalla prima Carta di comando usata dal Portatore ogni turno è aumentato del <WeaponEffect_Num:[StateArg1]%>. Se entra nello Spazio Ultra, il Portatore ottiene <WeaponEffect_Num:[StateArg2]> Aliemus."
  },
  State_74847_WeaponDesc = {
    Text = "I DAN Base della prima Carta di comando utilizzata dal portatore ogni turno aumentano del <WeaponEffect_Num:[StateArg1]%>. Se entra nello Spazio Ultra, il portatore ottiene <WeaponEffect_Num:[StateArg2]> Aliemus."
  },
  State_74879_Name = {
    Text = [[

Ottieni [DescArg1] Arithmetica]]
  },
  State_74881_Name = {
    Text = [[

Concedi a un Risvegliato scelto <Energy:[DescArg1]> Aliemus]]
  },
  State_74882_Name = {
    Text = [[

Ottieni [DescArg1] <ProficientInRealmsIconKeywords:Padronanza del Reame>]]
  },
  State_74883_Name = {
    Text = [[

Le prossime [DescArg1] Carte di comando giocate conferiranno un Keyflare <Posse:[DescArg2]> extra]]
  },
  State_74884_Name = {
    Text = [[

<RetaliateIconKeywords:Contatore> ottenuto e <IntoxicationIconKeywords:Veleno> e <BleedingIconKeywords:Salasso> inflitti ciascuno +[DescArg1]% in questo turno]]
  },
  State_74885_Name = {
    Text = [[

Concedi a tutti i Risvegliatori <Energy:[DescArg1]> Aliemus]]
  },
  State_74887_Name = {
    Text = "Ottieni [DescArg1] Punti Scudo"
  },
  State_74888_Name = {
    Text = [[

Aumenta la <DeathResistanceIconKeywords:Resistenza alla Morte> di +[DescArg1]%]]
  },
  State_74889_Name = {
    Text = [[

Ottieni [DescArg1] <RetaliateIconKeywords:Contatore>]]
  },
  State_74890_Name = {
    Text = "Rubare [DescArg1] punti di FOR temporanea a tutti i nemici"
  },
  State_74891_Name = {
    Text = "Infliggi casualmente [DescArg1] <FixedDamage:DAN Puro> [DescArg2] <plural value=\"[DescArg2]\" singular=\"volta\" plural=\"volte\"> (beneficia di 1× <PowerIconKeywords:STR>)"
  },
  State_74910_Desc = {
    Text = "Unicità di Squadra: Se il portatore è il Risvegliatore \"Ramona\", l'Affinità guadagnata al completamento dello stage +<WeaponEffect_Num:[StateArg1]%>."
  },
  State_74910_WeaponDesc = {
    Text = "Se l'equipaggiatore è il Risvegliatore \"Ramona\", l'Affinità ottenuta al completamento di un livello è aumentata di <WeaponEffect_Num:[StateArg1]%>."
  },
  State_74932_Desc = {
    Text = "Giocare un Comando \"Colpo\", un Comando \"Difesa\" o un Comando \"Abilità\" potenzierà rispettivamente il 1°, 2° o 3° effetto del Commercio Proibito."
  },
  State_74932_Name = {
    Text = "Commercio Proibito"
  },
  State_74947_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: all'inizio del turno, applica [StateArg1] stack di blocco azione al nemico con <HPAndShieldMin:vita e scudo più bassi>. Dopo che il portatore infligge un colpo letale, questo effetto si attiva immediatamente un'altra volta."
  },
  State_74947_Name = {
    Text = "Cappello a Tesa Larga della Strega"
  },
  State_74948_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo \"Esaltazione\", il nemico con più Aliemus perde [StateArg1] Aliemus e ottiene <PVPEmptinessKeywords:Vuoto>."
  },
  State_74948_Name = {
    Text = "Pendolo Ipnotico"
  },
  State_76236_Desc = {
    Text = "\nRisveglio della Chiave d'Argento: Quando la Keyflare è piena, puoi scegliere aggiuntivamente \"Risveglio della Chiave d'Argento\" per inserire la carta Risveglio del Risvegliatore designato in mano e conferirle \"Conservare\" per questa battaglia. \"Risveglio della Chiave d'Argento\" può attivarsi solo una volta per turno e ha un cooldown indipendente da \"Posse\".\nSovraccarico Keyflare: Quando si usa \"Risveglio della Chiave d'Argento\", per ogni Risvegliatore Risvegliato vengono detratti 1000 Keyflare, il che può portare la Keyflare in negativo.\nMarchio d'Archivio: Per ogni Posse che il Custode possiede, la Profondità di \"Ricerca Esoterica\" e \"Ricerca Occulta\" aumenta dell'1%, fino al 50%. Tutti gli effetti delle Ruote del Destino R vengono modificati per aumentare del 100% la probabilità che appaia la Reliquia Immagine Dimensionale del portatore."
  },
  State_76236_Name = {
    Text = "Bagliore argenteo radioso"
  },
  State_76277_Desc = {
    Text = "Unico per Squadra: Dopo l'inizio della Battaglia Boss, consuma fino a 50 Sigilli Neri; ogni punto di Sigillo Nero consumato conferisce il <WeaponEffect_Num:[StateArg1]%> di <DeathResistanceIconKeywords:Resistenza alla Morte>. Nel Capitolo Astrale, l'effetto diventa \"Aumenta del 100% la probabilità che appaia la Reliquia dell'Immagine Dimensionale del portatore.\""
  },
  State_76277_WeaponDesc = {
    Text = "Dopo l'inizio della Battaglia Boss, consuma fino a 50 Sigilli Neri. Per ogni Sigillo Nero consumato, ottieni <WeaponEffect_Num:[StateArg1]%> di <DeathResistanceIconKeywords: Resistenza alla Morte>. Nel Capitolo Astrale, l'effetto cambia in \"Aumenta del 100% la probabilità di comparsa della Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76278_Desc = {
    Text = "Unico per Squadra: Recupera il <WeaponEffect_Num:[StateArg1]%> degli HP persi dopo aver percorso una nuova Casella. Dopo aver utilizzato un Corpo di Gnosi d'Emergenza, aumenta il Tasso Crit. e il Danno Crit. di tutti i Risvegliatori del 100%. Nel \"Capitolo Astrale\", questo effetto diventa \"Aumenta del 100% la probabilità che appaia la Reliquia dell'Immagine Dimensionale del portatore.\""
  },
  State_76278_WeaponDesc = {
    Text = "Recupera il [StateArg1]% degli HP persi ([DescArg1]) dopo aver percorso una nuova Casella. Dopo aver utilizzato un Corpo di Gnosi d'Emergenza, aumenta il Tasso Crit. e il Danno Crit. di tutti i Risvegliati del 100%. In \"Capitolo Astrale\", questo effetto cambia in \"Aumenta del 100% la probabilità che appaia la Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76279_Desc = {
    Text = "Unico per Squadra: Riduce il costo delle Carte Risveglio nel Negozio D-Marchio di <WeaponEffect_Num:[StateArg1]> Sigilli Neri. La carta Risveglio del Portatore ottiene Innato. In \"Capitolo Astrale\", questo effetto cambia in \"Aumenta del 100% la probabilità che appaia la Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76279_WeaponDesc = {
    Text = "Il prezzo dei Risvegliati Evocati nel Negozio D-Marchio è ridotto di <WeaponEffect_Num:[StateArg1]> Sigilli Neri. Il Risveglio del Portatore ottiene un effetto Innato. In Capitolo Astrale, l'effetto cambia in \"Aumenta del 100% la probabilità che appaia la Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76280_Desc = {
    Text = "Unico per Squadra: Aumenta il Recupero PV nelle Aree di Riposo del <WeaponEffect_Num:[StateArg1]%>. Dopo aver scelto di recuperare PV, aggiungi 2 carte \"Intuizione\" al mazzo. In \"Capitolo Astrale\", questo effetto cambia in \"Aumenta del 100% la probabilità di comparsa della Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76280_WeaponDesc = {
    Text = "La quantità di Guarigione nell'Area di Riposo è aumentata del <WeaponEffect_Num:[StateArg1]%>. Dopo aver scelto il Recupero PV, aggiungi 2 carte \"Intuizione\" al mazzo. Nel Capitolo Astrale, l'effetto cambia in \"Aumenta del 100% la probabilità di comparsa della Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76281_Desc = {
    Text = "Unico per Squadra: Dopo la fine di ogni battaglia, il Risvegliato con meno Aliemus ottiene <WeaponEffect_Num:[StateArg1]> Aliemus. In \"Capitolo Astrale\", questo effetto cambia in \"Aumenta del 100% la probabilità che appaia la Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76281_WeaponDesc = {
    Text = "Dopo la fine della battaglia, il Risvegliato con meno Aliemus ottiene <WeaponEffect_Num:[Energy:StateArg1]> Aliemus. In Capitolo Astrale, questo effetto cambia in \"Aumenta del 100% la probabilità che appaia la Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76282_Desc = {
    Text = "Unico per Squadra: Tentativi di aggiornamento del Negozio D-Marchio +1, costo di aggiornamento ridotto di <WeaponEffect_Num:[StateArg1]> Sigilli Neri. In \"Capitolo Astrale\", questo effetto cambia in \"Aumenta del 100% la probabilità che appaia la Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76282_WeaponDesc = {
    Text = "Tentativi di aggiornamento del Negozio D-Marchio +1, costo di aggiornamento -<WeaponEffect_Num:[StateArg1]> Sigilli Neri. In \"Capitolo Astrale\", l'effetto cambia in \"Aumenta del 100% la probabilità che appaia la Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76283_Desc = {
    Text = "Unico per Squadra: Il numero di Slot Reliquia diventa 3, di cui uno è uno Slot Reliquia maledetta. Acquistare una Reliquia maledetta conferisce <WeaponEffect_Num:[StateArg1]> Sigilli Neri. In \"Capitolo Astrale\", questo effetto cambia in \"Aumenta del 100% la probabilità che appaia la Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76283_WeaponDesc = {
    Text = "Gli Slot Reliquia diventano 3, di cui uno è una Reliquia maledetta. Dopo aver acquistato una Reliquia maledetta, si ottengono <WeaponEffect_Num:[StateArg1]> Sigilli Neri. In Capitolo Astrale, l'effetto cambia in \"Aumenta del 100% la probabilità che appaia la Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76284_Desc = {
    Text = "Unico per Squadra: Dopo l'inizio di ogni fase, tutti i Risvegliati ottengono <WeaponEffect_Num:[StateArg1]> Aliemus. All'inizio di una Battaglia Boss, pesca 2 carte. In \"Capitolo Astrale\", questo effetto cambia in \"Aumenta del 100% la probabilità che appaia la Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76284_WeaponDesc = {
    Text = "Dopo l'inizio del livello, tutti i Risvegliati ottengono <WeaponEffect_Num:[Energy:StateArg1]> Aliemus. Dopo l'inizio della Battaglia Boss, pesca 2 carte. In Capitolo Astrale, l'effetto cambia in \"Aumenta del 100% la probabilità che appaia la Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76285_Desc = {
    Text = "Unico per Squadra: Dopo l'inizio di ogni livello, ottieni <WeaponEffect_Num:[StateArg1]> Keyflare. All'inizio di una Battaglia Boss, ottieni 2 Arithmetica. In \"Capitolo Astrale\", questo effetto cambia in \"Aumenta del 100% la probabilità di comparsa della Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76285_WeaponDesc = {
    Text = "Dopo l'inizio del livello, ottieni <WeaponEffect_Num:[StateArg1]> Keyflare. Dopo l'inizio della Battaglia Boss, ottieni 2 Arithmetica. In \"Capitolo Astrale\", l'effetto cambia in \"Aumenta del 100% la probabilità di comparsa della Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76286_Desc = {
    Text = "Unico per Squadra: Le Aree di Riposo forniscono un'opzione aggiuntiva: Distruggere fino a 3 Carte sintomo, ottenere <WeaponEffect_Num:[StateArg1]> Sigilli Neri. In \"Capitolo Astrale\", questo effetto cambia in \"Aumenta del 100% la probabilità di comparsa della Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76286_WeaponDesc = {
    Text = "Le Aree di Riposo forniscono un'opzione aggiuntiva: Distruggere fino a 3 Carte sintomo, ottenere <WeaponEffect_Num:[StateArg1]> Sigilli Neri. In \"Capitolo Astrale\", questo effetto cambia in \"Aumenta del 100% la probabilità di comparsa della Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76287_Desc = {
    Text = "Unico per Squadra: Al termine di una battaglia normale, il numero di Orazioni disponibili diventa 4. Le Orazioni sulle carte del portatore hanno una probabilità del <WeaponEffect_Num:[StateArg1]%> di essere potenziate ad Avanzate. Nel \"Capitolo Astrale\", questo effetto diventa \"Aumenta del 100% la probabilità che appaia la Reliquia dell'Immagine Dimensionale del portatore.\""
  },
  State_76287_WeaponDesc = {
    Text = "Al termine di una battaglia ordinaria, il numero di Orazioni disponibili diventa 4. Le Orazioni sulle carte del portatore hanno una probabilità del <WeaponEffect_Num:[StateArg1]%> di essere potenziate a Orazioni Avanzate. Nel Capitolo Astrale, questo effetto diventa \"Aumenta del 100% la probabilità che appaia la Reliquia dell'Immagine Dimensionale del portatore.\""
  },
  State_76288_Desc = {
    Text = "Unico per Squadra: Dopo la fine di ogni battaglia, ottieni <WeaponEffect_Num:[StateArg1]> Keyflare. In \"Capitolo Astrale\", questo effetto cambia in \"Aumenta del 100% la probabilità di comparsa della Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76288_WeaponDesc = {
    Text = "Dopo la fine della battaglia, ottieni <WeaponEffect_Num:[StateArg1]> Keyflare. In Capitolo Astrale, questo effetto cambia in \"Aumenta del 100% la probabilità che appaia la Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76289_Desc = {
    Text = "Unico per Squadra: Visione +1 durante l'esplorazione, ottieni <WeaponEffect_Num:[StateArg1]> Sigillo Nero dopo che la mappa è stata completamente rivelata. All'inizio delle Battaglie Boss, infliggi <WeaknessIconKeywords:Debolezza> e <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici per 1 turno. Nel Capitolo Astrale, l'effetto viene modificato in \"Aumenta del 100% la probabilità che appaia la Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76289_WeaponDesc = {
    Text = "Visione in esplorazione +1, ottieni <WeaponEffect_Num:[StateArg1]> Sigillo Nero dopo che la mappa è stata completamente rivelata. All'inizio di una Battaglia Boss, infliggi <WeaknessIconKeywords:Debolezza> e <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici per 1 turno. Nel Capitolo Astrale, l'effetto viene modificato in \"Aumenta del 100% la probabilità che appaia la Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76290_Desc = {
    Text = "Unico per Squadra: Dopo una battaglia normale, puoi scegliere di rinunciare a un'Orazione e aumentare gli HP massimi del <WeaponEffect_Num:[StateArg1]%>. Ha effetto fino a 2 volte. In \"Capitolo Astrale\", questo effetto cambia in \"Aumenta del 100% la probabilità che appaia la Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76290_WeaponDesc = {
    Text = "Dopo una battaglia ordinaria, puoi scegliere di rinunciare a un'Orazione e aumentare gli HP massimi di <WeaponEffect_Num:[DescArg1]>. Questo effetto ha effetto fino a 2 volte. In Capitolo Astrale, l'effetto cambia in \"Aumenta del 100% la probabilità che appaia la Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76291_Desc = {
    Text = "Unico per Squadra: Dopo l'inizio di ogni livello, ottieni <WeaponEffect_Num:[StateArg1]> Sigilli Neri. Capacità Reliquie +2. In \"Capitolo Astrale\", questo effetto cambia in \"Aumenta del 100% la probabilità di comparsa della Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76291_WeaponDesc = {
    Text = "Dopo l'inizio del livello, ottieni <WeaponEffect_Num:[StateArg1]> Sigilli Neri. Capacità Reliquie +2. Nel Capitolo Astrale, l'effetto cambia in \"Aumenta del 100% la probabilità di comparsa della Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76292_Desc = {
    Text = "Unico per Squadra: Le Carte sintomo possono essere vendute per <WeaponEffect_Num:[StateArg1]> Sigilli Neri. In \"Capitolo Astrale\", questo effetto cambia in \"Aumenta del 100% la probabilità di comparsa della Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76292_WeaponDesc = {
    Text = "I D-Marchio possono essere ottenuti vendendo Carte sintomo al Negozio D-Marchio per <WeaponEffect_Num:[StateArg1]> Sigilli Neri. Nel Capitolo Astrale, l'effetto cambia in \"Aumenta del 100% la probabilità di comparsa della Reliquia Immagine Dimensionale del Portatore.\""
  },
  State_76321_Name = {
    Text = "Lente Prismatica"
  },
  State_76323_Name = {
    Text = "Armonia Aliemus"
  },
  State_76324_Name = {
    Text = "Armonia di Arithmetica"
  },
  State_76325_Desc = {
    Text = "Dopo aver giocato [DescArg1] Carte di Comando, entra nello stato di \"Armonia di Arithmetica\"."
  },
  State_76325_Name = {
    Text = "Armonia di Arithmetica"
  },
  State_76326_Name = {
    Text = "Paradosso dell'Esistenza"
  },
  State_76328_Name = {
    Text = "Cono di Luce del Destino"
  },
  State_76337_Name = {
    Text = "Cicatrice Senza Fondo"
  },
  State_76338_Desc = {
    Text = "La Guarigione ricevuta è ridotta del [Layer]%."
  },
  State_76338_Name = {
    Text = "Cicatrice Senza Fondo"
  },
  State_76430_Name = {
    Text = "Immagine Dimensione · Lily"
  },
  State_76433_Name = {
    Text = "Armonia di Arithmetica"
  },
  State_76434_Desc = {
    Text = "Ogni volta che una Carta di comando viene giocata, se Arithmetica è stata consumata in eccesso a causa dell'Armonia di Arithmetica, ottieni un ulteriore 100% della Rigenerazione Keyflare del Risvegliato in Keyflare. Questo Effetto è cumulabile."
  },
  State_76434_Name = {
    Text = "Armonia di Arithmetica"
  },
  State_76435_Name = {
    Text = "Lente Prismatica"
  },
  State_76528_Name = {
    Text = "Questa carta è considerata \"Colpo\""
  },
  State_76529_Desc = {
    Text = "Quando raccolta, scegli una carta di un Risvegliato per ridurne il Costo di Arithmetica di 1. Dopo averla giocata, pesca 1 carta e trattala come \"Colpo\"."
  },
  State_76533_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: A fine turno, assegna casualmente a [StateArg1] carte nella mano dell'avversario [StateArg2] accumuli di <PVPAcheKeywords:Angoscia Velata>."
  },
  State_76533_Name = {
    Text = "Angoscia Velata"
  },
  State_76553_Desc = {
    Text = "Riduci il Costo di Arithmetica di questa Carta di [StateArg1]."
  },
  State_76553_Name = {
    Text = "Milioni di sguardi amorevoli"
  },
  State_77686_Name = {
    Text = "Forma semi-meccanica"
  },
  State_77688_Desc = {
    Text = "All'inizio del quinto turno o in punto di morte, diventa immune alla morte e cambia l'Intenzione in \"Ascensione Meccanica\"."
  },
  State_77688_Name = {
    Text = "La Carne è Debole"
  },
  State_77690_Desc = {
    Text = "Dopo il passaggio alla \"Forma semi-meccanica\", ogni carica di Finale concede un ulteriore 10% di HP Max. In \"Forma semi-meccanica\",\"Doll: Inferno\" scatenerà Abilità più minacciose all'aumentare delle cariche di \"Finale\"."
  },
  State_77690_Name = {
    Text = "Fine Ultima"
  },
  State_77692_Desc = {
    Text = "A fine turno, evoca 2 Mostri Dissoluzione, con un massimo di 2 esistenti simultaneamente. Quando i Mostri Dissoluzione evocati muoiono,\"Doll: Inferno\" perde il 5% dei suoi PV massimi."
  },
  State_77692_Name = {
    Text = "Portale dell'Abisso"
  },
  State_77693_Desc = {
    Text = "Alla morte,\"Doll: Inferno\" perde il 5% degli HP massimi."
  },
  State_77693_Name = {Text = "Fusione"},
  State_78102_Desc = {
    Text = "Il Danno inflitto è ridotto del 15% e il Danno subito è aumentato del 30%, fino alla fine della Battaglia."
  },
  State_78102_Name = {
    Text = "Paralisi da Sovrafrequenza"
  },
  State_78694_Desc = {
    Text = "Ottieni [Arg1] Forza all'inizio della battaglia. All'inizio del turno, per ogni [Arg2] FRZ Permanente, ottieni [Arg3] FOR temporanea, fino a un massimo di [Arg4] FOR temporanea, e perdi metà della FOR temporanea ottenuta da quella Reliquia alla fine del turno."
  },
  State_78696_Desc = {
    Text = "Dopo aver usato Rouse di Keyflare, seleziona [Arg1] \"Abilità\" del Risvegliatore corrispondente da portare a Esaurimento, e mischia [Arg2] copie con Esaurimento nel Mazzo di Pesca."
  },
  State_78697_Desc = {
    Text = "A inizio turno, ottieni [Arg1] FOR per ogni spazio vacante nello Spazio Ultra, ma subisci [Arg2] cariche di Veleno."
  },
  State_78698_Desc = {
    Text = "Limite di Arithmetica -[Arg1]. Ogni volta che giochi una carta con un Costo di Arithmetica pari o superiore a [Arg2], ottieni 1 Arithmetica. Questo effetto può attivarsi fino a [Arg3] volte per turno."
  },
  State_78699_Desc = {
    Text = "Dopo aver pescato, pesca [Arg1] carte aggiuntive, ma scegli [Arg2] carte dalla tua mano da scartare."
  },
  State_78700_Desc = {
    Text = "Aumenta il DAN Base di tutti i Risvegliati del [Arg1]%. Ogni volta che il mazzo viene rimescolato, viene concesso un ulteriore [Arg2]%, ma una carta \"Barcollamento\" viene aggiunta alla tua mano. L'aumento massimo è del [Arg3]%."
  },
  State_78701_Desc = {
    Text = "A inizio turno, se ci sono più di [Arg1] Tentacoli Permanenti, perdi [Arg2] Tentacoli per ottenere [Arg3] Tentacoli Temporanei; altrimenti, ottieni [Arg4] Tentacoli Temporanei."
  },
  State_78702_Desc = {
    Text = "Dopo aver usato il Risveglio Keyflare, consuma [Arg1] Keyflare aggiuntivi, riducendo il consumo di Arithmetica della carta Risveglio ricevuta a 0. Al momento di giocarla, il Risvegliato corrispondente ottiene [Arg2] Aliemus aggiuntivi."
  },
  State_78703_Desc = {
    Text = "All'inizio della battaglia, infliggi [Arg1] Veleno a tutti i nemici. Prima dell'inizio di ogni turno, rimuovi il [Arg2]% del Veleno del nemico e infliggi il [Arg3]% della quantità rimossa come Salasso."
  },
  State_78710_Desc = {
    Text = "Per ogni Carta di comando giocata, il Danno Finale del Risvegliatore corrispondente per quel turno aumenta di [Arg1]%, ma perde [Arg2] Aliemus. Questo effetto può attivarsi fino a [Arg3] volte per turno."
  },
  State_78712_Desc = {
    Text = "A inizio turno, livello Fusione Embrionale +[Arg1]. Il tuo Embrione verrà scartato a fine turno."
  },
  State_78713_Desc = {
    Text = "A inizio turno, ottieni [Arg1] Contatore. Dopo aver usato l'Esaltazione [Arg2] volte in un turno, rimuovi il [Arg3]% del Contatore Permanente e ottieni il [Arg4]% della quantità rimossa come Contatore Temporaneo. Tempo di ricarica: [Arg5] turni."
  },
  State_78781_Desc = {
    Text = "Riduci temporaneamente la FOR del bersaglio e ottieni la stessa quantità di FOR temporanea."
  },
  State_78781_Name = {
    Text = "<TouquKeywords:Rubare>"
  },
  State_79405_Desc = {
    Text = "Quando giocata, aumenta la \"Memoria Lucida\" di 1. Al raggiungimento di 10, bloccala per 1 turno e ottieni 3 carte \"Intuizione\", poi ripristinala a 5 all'inizio del turno successivo."
  },
  State_79405_Name = {
    Text = "Vero Passato"
  },
  State_79406_Desc = {
    Text = "Quando giocata, riduce \"Memoria Lucida\" di 1. Al raggiungimento di 0, bloccala per 1 turno e tutti i Risvegliati ottengono 30 Aliemus. Si ripristina a 5 all'inizio del turno successivo."
  },
  State_79406_Name = {
    Text = "L'Illusione della Vanità"
  },
  State_80052_Desc = {Text = "Test"},
  State_80052_Name = {Text = "Test 123"},
  State_80052_WeaponDesc = {Text = "Test"},
  State_80161_Desc = {
    Text = "Unico per Squadra: i DAN Base di Esaltazione del portatore +<WeaponEffect_Num:[StateArg1]%>, e Rigenerazione Keyflare +<WeaponEffect_Num:[StateArg2]>. Dopo essere entrati nel Turno Ultra, tutti i Risvegliatori ottengono <WeaponEffect_Num:[StateArg4]> Aliemus. Dopo aver rilasciato \"Annientamento\", il portatore ottiene <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_80161_WeaponDesc = {
    Text = "DAN Base dell'Esaltazione del Portatore +<WeaponEffect_Num:[StateArg1]%>, e Rigenerazione Keyflare +<WeaponEffect_Num:[DescArg1]>. Dopo essere entrati nel Turno Ultra, tutti i Risvegliati ottengono <WeaponEffect_Num:[StateArg4]> Aliemus. Dopo aver rilasciato \"Annientamento\", il Portatore ottiene <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_80174_Desc = {
    Text = "Unico per Squadra: Aumenta la Rigenerazione Keyflare del Portatore del <WeaponEffect_Num:[StateArg1]%>. All'inizio della prima battaglia, applica 1 accumulo di debolezza e vulnerabilità a tutti i nemici."
  },
  State_80174_WeaponDesc = {
    Text = "Aumenta la Rigenerazione Keyflare del portatore di <WeaponEffect_Num:[DescArg1]>. All'inizio della prima battaglia, infligge 1 accumulo di Debolezza e Vulnerabile a tutti i nemici."
  },
  State_80207_Desc = {
    Text = "Se questa carta attiva \"Navetta Dimensionale\" dopo essere stata giocata, attiva l'effetto successivo. Costo di Arithmetica -1 quando presa dallo Spazio Ultra."
  },
  State_80207_Name = {
    Text = "<WormholeKeywords:Quasar>"
  },
  State_80328_Desc = {
    Text = "Le sue emozioni, la sua cognizione e tutto il resto sono eternamente legati alla Volontà dello Sciame. Questo effetto è cumulabile fino a 15 volte. \"Simbiosi\" può essere trasformata in effetti debuff dall'Esaltazione di Clementine \"Ricostruzione della Forma Vitale\"."
  },
  State_80328_Name = {Text = "Simbiosi"},
  State_80331_Desc = {
    Text = "Sotto l'erosione dell'Alveare, le tue debolezze sono completamente esposte. Il Danno Attivo e da Tentacolo subito in questo turno è aumentato del [DescArg1]%."
  },
  State_80331_Name = {
    Text = "<D13Colour:Trauma Psichico>"
  },
  State_80332_Desc = {
    Text = "Le sue emozioni, la sua cognizione e tutto il resto sono eternamente legati alla Volontà dello Sciame. Questo effetto è cumulabile fino a 10 volte. \"Simbiosi\" può essere trasformata in effetti debuff dall'Esaltazione di Clementine \"Ricostruzione della Forma Vitale\"."
  },
  State_80332_Name = {Text = "Simbiosi"},
  State_80335_Desc = {
    Text = "Sotto l'erosione dell'Alveare, le tue debolezze sono completamente esposte. Il Danno Attivo e da Tentacolo subito in questo turno è aumentato del [DescArg1]%."
  },
  State_80335_Name = {
    Text = "<D13Colour:Trauma Psichico>"
  },
  State_80336_Desc = {
    Text = "Sotto l'erosione dell'Alveare, le tue paure vengono allo scoperto. Il Danno Attivo e da Tentacolo inflitto in questo turno è ridotto del [DescArg1]%."
  },
  State_80336_Name = {
    Text = "<D13Colour:Fissazione fobica>"
  },
  State_80338_Desc = {
    Text = "Sotto l'erosione dell'Alveare, le tue paure vengono allo scoperto. Il Danno Attivo e da Tentacolo inflitto in questo turno è ridotto del [DescArg1]%."
  },
  State_80338_Name = {
    Text = "<D13Colour:Fissazione fobica>"
  },
  State_80575_Desc = {
    Text = "Dopo aver subito danni attivi o Danni da tentacolo, rimuovi una quantità equivalente di \"Vecchie Braci\" e perdi il 300% della quantità rimossa in vita; quando subisci altri danni, rimuovi la metà. Il numero di \"Vecchie Braci\" si ripristina a ogni round."
  },
  State_80575_Name = {
    Text = "Braci dei Giorni Passati"
  },
  State_80644_Name = {
    Text = "Stato@Luce della Trascendenza"
  },
  State_80773_Desc = {
    Text = "Effetto STR ▼ subito -50%. Durante il proprio turno, Danno non Attivo e da Tentacolo subito +100%."
  },
  State_80773_Name = {
    Text = "Anticorpo Extradimensionale"
  },
  State_80774_Desc = {
    Text = "Dopo aver subito Danno attivo o Danno da Tentacolo, rimuovi una quantità equivalente di \"Braci Antiche\" e perdi il 300% della quantità rimossa in PV; quando subisci altri tipi di Danno, rimuovine la metà. Il conteggio degli accumuli di \"Braci Antiche\" si azzera ogni turno. Dopo che tutte le \"Braci Antiche\" sono state rimosse, ottieni 50 accumuli di \"Fortezza\"."
  },
  State_80774_Name = {
    Text = "Braci dei Giorni Passati"
  },
  State_80777_Desc = {
    Text = "A inizio battaglia, riduci il Tasso di Critico di tutti i Risvegliatori del 10%. Alla morte, gli altri alleati ottengono [DescArg1] Forza e [DescArg2] accumuli di \"Braci Antiche\"."
  },
  State_80777_Name = {
    Text = "Empatia dello Sciame - Eredità"
  },
  State_80778_Desc = {
    Text = "Dopo la morte, gli altri alleati guadagnano 1 stack di \"Follia Temporanea\"."
  },
  State_80778_Name = {
    Text = "Empatia dello Sciame - Fusione"
  },
  State_80782_Desc = {
    Text = "In questa Battaglia, il Tasso di Crit. di tutti i Risvegliatori -[Layer] %."
  },
  State_80782_Name = {
    Text = "Tasso di Crit.-"
  },
  State_80783_Desc = {
    Text = "A fine turno, guadagna 1 stack di \"Follia.\""
  },
  State_80783_Name = {
    Text = "Legame di Sangue"
  },
  State_80784_Desc = {
    Text = "Quando gli HP sono inferiori al 50%, evoca un \"Primo Variante\" nelle retrovie; può essere attivato solo una volta per Battaglia."
  },
  State_80784_Name = {
    Text = "Empatia dello Sciame - Fissione"
  },
  State_80785_Desc = {
    Text = "La Riduzione FOR ha effetto solo al 50% su questo nemico. Ogni volta che rilasci un'Esaltazione, guadagna 1 stack di \"Follia Temporanea\"."
  },
  State_80785_Name = {
    Text = "Empatia dello Sciame - Dimensione"
  },
  State_80788_Desc = {
    Text = "La Riduzione FOR ha effetto solo al 25% su questo nemico. Ogni volta che rilasci un'Esaltazione, guadagna 1 stack di \"Follia Temporanea\"."
  },
  State_80788_Name = {
    Text = "Empatia dello Sciame - Dimensione"
  },
  State_80789_Desc = {
    Text = "Danno Attivo e da Tentacolo subito +100%, per 1 turno."
  },
  State_80789_Name = {Text = "Dormienza"},
  State_80790_Desc = {
    Text = "Dopo la metamorfosi, ogni accumulo di Etere Cosmico lo renderà perfetto..."
  },
  State_80790_Name = {
    Text = "Etere Cosmico"
  },
  State_80792_Desc = {
    Text = "Ogni volta che rilasci un'Esaltazione, guadagna 1 stack di \"Follia Temporanea\"."
  },
  State_80792_Name = {
    Text = "Empatia dello Sciame - Dimensione"
  },
  State_80794_Desc = {
    Text = "Le carte non possono essere giocate e rimangono In Mano a fine turno."
  },
  State_80794_Name = {
    Text = "<Boundkeywords:Vincolo>"
  },
  State_80807_Desc = {
    Text = "Quando inizia il quinto turno o sta per morire, rimuovi tutti gli altri nemici e cambia l'intenzione in \"Momento della Metamorfosi\"."
  },
  State_80807_Name = {
    Text = "Momento della Trasformazione"
  },
  State_80809_Desc = {
    Text = "A fine turno, le carte con Effimero In Mano verranno scartate."
  },
  State_80809_Name = {
    Text = "<PVPVoidKeyColour:Illusione>"
  },
  State_80810_Desc = {
    Text = "Dopo aver subito danni attivi o Danni da tentacolo, rimuovi una quantità equivalente di \"Vecchie Braci\" e perdi il 300% della quantità rimossa in vita; quando subisci altri danni, rimuovi la metà. Il numero di \"Vecchie Braci\" si ripristina a ogni round."
  },
  State_80810_Name = {
    Text = "Braci dei Giorni Passati"
  },
  State_80827_Desc = {
    Text = "Ogni 15 carte giocate, sostituisci l'intenzione corrente con \"Colpo Traumatico\" (attualmente mancano [Layer] carte)."
  },
  State_80827_Name = {
    Text = "Punizione Furiosa"
  },
  State_81022_WeaponDesc = {
    Text = "Ogni volta che si subiscono DAN, l'Aliemus di tutti i Risvegliati aumenta di 1."
  },
  State_81027_Desc = {
    Text = "Il proprietario di questa carta è \"Insettoide\", Costo di Arithmetica -1, Esaurita dopo essere stata giocata."
  },
  State_81027_Name = {
    Text = "Rito Vitale"
  },
  State_81054_Desc = {
    Text = "Sotto l'erosione dell'Alveare, le tue paure vengono allo scoperto. Per ogni accumulo, Danno attivo e Danni da tentacolo inflitti in questo turno -3%, fino a un massimo di 15 accumuli."
  },
  State_81054_Name = {
    Text = "<D13AFKeyWordQ1:Fissazione fobica>"
  },
  State_81055_Desc = {
    Text = "Sotto l'erosione dell'Alveare, le tue paure vengono allo scoperto. Per ogni accumulo, Danno attivo e Danni da tentacolo subiti in questo turno +3%, fino a un massimo di 10 accumuli."
  },
  State_81055_Name = {
    Text = "<D13AFKeyWord2:Trauma Psichico>"
  },
  State_81056_Desc = {
    Text = "Sotto l'erosione dell'Alveare, le tue paure vengono allo scoperto. Per ogni accumulo, Danno attivo e Danni da tentacolo subiti in questo turno +3%, fino a un massimo di 15 accumuli."
  },
  State_81056_Name = {
    Text = "<D13AFKeyWordQ2:Trauma Psichico>"
  },
  State_81057_Desc = {
    Text = "Sotto l'erosione dell'Alveare, le tue paure vengono allo scoperto. Per ogni accumulo, Danno attivo e Danni da tentacolo inflitti in questo turno -3%, fino a un massimo di 10 accumuli."
  },
  State_81057_Name = {
    Text = "<D13AFKeyWord1:Fissazione fobica>"
  },
  State_81058_Desc = {
    Text = "Le sue emozioni, la sua cognizione e tutto il resto sono eternamente legati alla Volontà dello Sciame. \"Empatia\" può essere trasformata in effetti debuff dall'Esaltazione di Clementine \"Ricostruzione della Forma Vitale\", cumulabile fino a 15 cariche."
  },
  State_81058_Name = {
    Text = "<AnalysisKeywords3:Simbiosi>"
  },
  State_81059_Desc = {
    Text = "Le sue emozioni, la sua cognizione e tutto il resto sono eternamente legati alla Volontà dello Sciame. \"Simbiosi\" può essere trasformata in effetti debuff dall'Esaltazione di Clementine \"Ricostruzione della Forma Vitale\", cumulabile fino a 10 cariche."
  },
  State_81059_Name = {
    Text = "<AnalysisKeywords0:Simbiosi>"
  },
  State_81073_Desc = {
    Text = "Ripristina immediatamente tutti i PV e ottieni l'80% di Fortezza Temporanea al subire danno fatale, evocando un \"Primo Variante\" in retroguardia. Può attivarsi 2 volte."
  },
  State_81073_Name = {
    Text = "Empatia dello Sciame - Fissione"
  },
  State_81278_Desc = {
    Text = "Dopo aver rilasciato un Seguito per la prima volta ogni turno, tutti i Risvegliati ottengono 10 Aliemus, ma il costo per rilasciare un Seguito aumenta permanentemente del 10%."
  },
  State_81278_Name = {
    Text = "Soppressione della Chiave d'Argento"
  },
  State_81312_Desc = {
    Text = "Dopo aver subito DAN Fatali, ripristina tutti i PV e ottieni 50 cariche di rinforzo Temporaneo. Può attivarsi anche [Layer] volte."
  },
  State_81312_Name = {
    Text = "Reincarnazione Cosmica"
  },
  State_81331_Desc = {
    Text = "A inizio turno, scegli 1 Risveglio, sigillando tutte le sue carte e la sua Esaltazione per 3 turni."
  },
  State_81331_Name = {
    Text = "Imprigionamento della Coscienza"
  },
  State_81340_Desc = {
    Text = "Questa carta è sigillata e non può essere giocata fino a [Layer] turni dopo, quando il sigillo verrà rimosso."
  },
  State_81340_Name = {
    Text = "<Seal1:Sigillo Carta>"
  },
  State_81341_Desc = {
    Text = "L'Esaltazione di questo Risvegliato è sigillata e non può essere utilizzata fino a [Layer] turni, quando il sigillo verrà rimosso."
  },
  State_81341_Name = {
    Text = "<Seal1:Sigillo di Aliemus>"
  },
  State_81354_Desc = {
    Text = "Subisce [DescArg1] DAN quando viene giocata. Se è ancora in mano alla fine del turno, Esaurimento."
  },
  State_81354_Name = {
    Text = "<BurningKeywords:Bruciare>"
  },
  State_81356_Desc = {
    Text = "La carta brucia, subisce [DescArg1] DAN quando viene giocata. Se è ancora in mano alla fine del turno, Esaurimento."
  },
  State_81356_Name = {
    Text = "<BurningKeywords:Bruciare>"
  },
  State_81356_WeaponDesc = {
    Text = "Ogni accumulo di Stagnazione aumenta di 1 il Costo di Arithmetica delle carte."
  },
  State_83587_Desc = {
    Text = "Può potenziare l'Effetto quando si seleziona \"Archor Off\", limite di 10 accumuli."
  },
  State_83587_Name = {
    Text = "Salpa l'Ancora"
  },
  State_83589_Desc = {
    Text = "Può potenziare l'Effetto quando si seleziona \"Riposo in Porto\", fino a 10 accumuli."
  },
  State_83589_Name = {Text = "Ormeggio"},
  State_83593_Desc = {
    Text = "Tutto il Danno Finale inflitto dai Risvegliatori in questo turno è aumentato"
  },
  State_83593_Name = {
    Text = "Danno Finale"
  },
  State_83596_Desc = {
    Text = "Limite della mano +1. Se \"Il Dilemma del Navigatore\" non è nel mazzo a inizio turno, aggiungilo alla tua mano. Ottieni 1 accumulo di \"Spiega le Vele\" ogni volta che il leader perde il 10% dei PV massimi; ottieni 1 accumulo di \"Ormeggio\" ogni volta che perdi il 10% dei tuoi PV massimi."
  },
  State_83596_Name = {
    Text = "Guida di Erasmo: \"Spiega le Vele\""
  },
  State_83607_Desc = {
    Text = "Identificatore di perdita cumulativa del dieci percento di HP del Boss"
  },
  State_83607_Name = {
    Text = "Stato@Identificatore perdita cumulativa dieci percento vita Boss"
  },
  State_83609_Desc = {
    Text = "Identificatore di perdita cumulativa del dieci percento di HP del Giocatore"
  },
  State_83609_Name = {
    Text = "Stato@Identificatore perdita cumulativa dieci percento vita Giocatore"
  },
  State_83614_Desc = {
    Text = "10% PV Max del Giocatore"
  },
  State_83614_Name = {
    Text = "Stato@Valore dieci percento salute Giocatore"
  },
  State_83615_Desc = {
    Text = "Dopo aver perso [Layer] HP, ottieni 1 accumulo di \"Spiega le Vele\"."
  },
  State_83615_Name = {
    Text = "Progresso di\"Salpa\""
  },
  State_83616_Desc = {
    Text = "Dopo aver perso [Layer] HP, ottieni 1 accumulo di \"Ormeggio\"."
  },
  State_83616_Name = {
    Text = "Progresso di \"Ormeggio\""
  },
  State_83617_Desc = {
    Text = "Boss al 10% di salute"
  },
  State_83617_Name = {
    Text = "Stato@Valore dieci percento salute Boss"
  },
  State_83618_Desc = {
    Text = "HP attuali durante il test: [Layer]"
  },
  State_83618_Name = {
    Text = "Conteggio salute attuale del nemico"
  },
  State_83619_Desc = {
    Text = "HP massimi durante il test: [Layer]"
  },
  State_83619_Name = {
    Text = "Conteggio salute massima del nemico"
  },
  State_83620_Desc = {
    Text = "Il valore attuale del parametro 4 moltiplicato per 100 è [Layer]."
  },
  State_83620_Name = {
    Text = "Stampa dei Parametri"
  },
  State_83621_Desc = {
    Text = "Conteggio del punto intermedio alla perdita del dieci percento di salute del Boss"
  },
  State_83621_Name = {
    Text = "Stato@Valore intermedio conteggio perdita dieci percento salute Boss"
  },
  State_83622_Desc = {
    Text = "Perdita del dieci percento di salute del giocatore calcolando il valore medio"
  },
  State_83622_Name = {
    Text = "Stato@Valore intermedio conteggio perdita dieci percento salute Giocatore"
  },
  State_83627_Desc = {
    Text = "Dopo aver perso [DescArg1] PV, ottieni 1 accumulo di \"Spiega le Vele\""
  },
  State_83627_Name = {
    Text = "Progresso di\"Salpa\""
  },
  State_83805_Name = {
    Text = "Scossa Residua"
  },
  State_83807_Name = {
    Text = "Sommerso nel Profondo"
  },
  State_83808_Desc = {
    Text = "Attiva l'effetto \"Onda d'Urto Residua\" quando viene scartata."
  },
  State_83808_Name = {
    Text = "<RippleKeywords:Onda d'Urto Residua>"
  },
  State_83811_Desc = {
    Text = "Subisci un ulteriore [Layer]% di Danno da Tentacolo."
  },
  State_83812_Desc = {
    Text = "Subisci un ulteriore [Layer]% di Danno da Tentacolo."
  },
  State_83814_Desc = {
    Text = "Boss al 10% di salute"
  },
  State_83814_Name = {
    Text = "Boss al dieci percento di salute"
  },
  State_84140_Desc = {
    Text = "[Layer] carte \"Divisione Ghiandolare\" Esaurite tramite \"Oceano Clamoroso\" in questa battaglia."
  },
  State_84140_Name = {
    Text = "Oceano Clamoroso"
  },
  State_84184_Name = {
    Text = "Gode di un bonus di FOR aggiuntivo del [Layer]%"
  },
  State_84255_Desc = {
    Text = "Unico per Squadra: All'inizio della battaglia, ottieni uno Scudo del Personaggio pari al <WeaponEffect_Num:[StateArg1]%> della DIF del Portatore. Dopo aver attivato la Resistenza alla Morte, questo effetto si riattiva all'inizio del turno successivo."
  },
  State_84255_Name = {
    Text = "Navigatore d'alto mare"
  },
  State_84255_WeaponDesc = {
    Text = "All'inizio della battaglia, ottieni <WeaponEffect_Num:[Block:DescArg1]> Scudo. Dopo aver attivato la Resistenza alla Morte, attiva nuovamente questo effetto all'inizio del turno successivo."
  },
  State_84257_Desc = {
    Text = "Unico per Squadra: Lo Scudo del Personaggio causato dall'Esaltazione del Portatore aumenta di <WeaponEffect_Num:[StateArg1]%>. Dopo aver rilasciato l'Esaltazione, il Danno critico temporaneo di tutti i Risvegliati aumenta di <WeaponEffect_Num:[StateArg2]%>, con ogni Tentacolo che lo incrementa dell'1%. Dopo ogni esplorazione, attiva la Resistenza per la prima volta, ripristinando <WeaponEffect_Num:[StateArg3]%> dei PV massimi all'inizio del turno successivo."
  },
  State_84257_WeaponDesc = {
    Text = "L'Esaltazione del Portatore genera <WeaponEffect_Num:[StateArg1]%> Scudo in più. Dopo aver usato l'Esaltazione, tutti i Risvegliati ottengono <WeaponEffect_Num:[StateArg2]%> di Danno critico temporaneo, e ogni Tentacolo conferisce un ulteriore 1%. Dopo aver attivato la Resistenza alla Morte per la prima volta in ogni Esplorazione, recupera <WeaponEffect_Num:[StateArg3]%> dei PV massimi all'inizio del turno successivo."
  },
  State_84272_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del Destino>: A fine turno, ripristina i PV dell'alleato che ha perso più PV <Heal:[Heal:StateArg1]>."
  },
  State_84272_Name = {
    Text = "Navigatore d'alto mare"
  },
  State_84273_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Quando equipaggiata e a inizio turno, se non c'è <PVPProtectiveKeywords:Barriera>, ottiene [StateArg1] accumuli di <PVPProtectiveKeywords:Barriera>; altrimenti, ottiene <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_84273_Name = {
    Text = "Guida nella Fiamma Sacra"
  },
  State_84364_Desc = {
    Text = "Danno Crit. +[Layer]%."
  },
  State_84364_Name = {
    Text = "Danno critico"
  },
  State_84368_Desc = {
    Text = "[Layer] turni di recupero rimanenti."
  },
  State_84368_Name = {
    Text = "Sommerso nel Profondo"
  },
  State_84375_Desc = {
    Text = "All'inizio del turno, ottieni [Layer] Scudo del Personaggio."
  },
  State_84375_Name = {
    Text = "Navigatore d'alto mare"
  },
  State_84376_Desc = {
    Text = "All'inizio del turno, cura [Layer] HP."
  },
  State_84376_Name = {
    Text = "Guida nella Fiamma Sacra"
  },
  State_84399_Desc = {
    Text = "Alla fine di ogni turno, aumenta i DAN subiti del 5% e ottieni 2 accumuli di Barriera."
  },
  State_84399_Name = {
    Text = "Sommerso nel Profondo"
  },
  State_84400_Desc = {
    Text = "All'inizio del prossimo turno, ogni barriera viene convertita in 1 carica di <ReinforcePVEKeywords:Fortezza>."
  },
  State_84400_Name = {Text = "\"Pilota\""},
  State_84402_Desc = {
    Text = "Aumenta i Danni subiti del [Layer]%."
  },
  State_84402_Name = {
    Text = "Forza Sovrasfruttata"
  },
  State_89340_Desc = {
    Text = "Subisci un ulteriore [Layer]% di Danno da Tentacolo."
  },
  State_89340_Name = {
    Text = "Vulnerabilità del tentacolo"
  },
  State_89422_Desc = {
    Text = "Tutti i Risvegliatori generano il 100% in più di Aliemus e possono scatenare Esaltazione 2 volte per turno."
  },
  State_89422_Name = {
    Text = "\"Cuore Indomito\""
  },
  State_89447_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Limite Massima della Mano + [StateArg2]. Ottieni [StateArg1] Arithmetica dopo \"Esaltazione\"."
  },
  State_89447_Name = {
    Text = "Libertà Insostenibile"
  },
  State_89448_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: A fine turno, l'alleato con i PV e lo Scudo più bassi otterrà [StateArg1] <PVPDerivativeCardKeywords_16:\"Piuma d'Onice\">."
  },
  State_89448_Name = {
    Text = "Piuma Solitaria"
  },
  State_89554_Name = {
    Text = "Cono di Luce del Destino"
  },
  State_89555_Desc = {
    Text = "Unicità di Squadra: Dopo che il portatore rilascia l'Esaltazione, DAN base dell'Esaltazione +<WeaponEffect_Num:[StateArg1]%>, Scudo e Recupero PV +<WeaponEffect_Num:[StateArg2]%>, fino a 5 accumuli. Durante l'esplorazione, l'Affinità guadagnata dal portatore +<WeaponEffect_Num:[StateArg3]%>."
  },
  State_89555_WeaponDesc = {
    Text = "Dopo che il Portatore rilascia l'Esaltazione, il DAN Base dell'Esaltazione aumenta del <WeaponEffect_Num:[StateArg1]%>, la Generazione di Scudo del Personaggio e il Recupero PV aumentano del <WeaponEffect_Num:[StateArg2]%>, cumulabile fino a 5 volte. Al termine dell'esplorazione, l'Affinità ottenuta dal Portatore aumenta del <WeaponEffect_Num:[StateArg3]>%."
  },
  State_89557_Name = {
    Text = "Lente Prismatica"
  },
  State_89559_Desc = {
    Text = "\n·Paradosso Esistenziale: All'inizio dell'esplorazione, il 75% della Resistenza alla Morte viene convertito in bonus ai Punti Vita massimi, fino a un massimo di 300% di Resistenza alla Morte convertita, aumentando i Punti Vita massimi al massimo del 10%. Ogni volta che si attiva la Resistenza alla Morte, viene aggiunta 1 carta «Bagliore della Chiave d'Argento» in mano.\n·Ferita Senza Fondo: Durante la battaglia contro il boss, ogni volta che la quantità di recupero vita ricevuta dalla nostra parte raggiunge il 100% del limite di vita, l'effetto di recupero vita successivo si riduce del 25%, ma la quantità totale attuale di Resistenza alla Morte aumenta del 25%, fino a un massimo di 3 attivazioni.\n·Lente Prismatica: All'inizio del turno, se il Contrattacco supera il 2000% del limite di vita, le pile eccedenti vengono dimezzate e il Contrattacco permanente può accumularsi al massimo fino al 6000% del limite di vita; se il Veleno del nemico supera il 3000% del limite di vita, le pile eccedenti vengono dimezzate e il Veleno può accumularsi al massimo fino al 9000% del limite di vita. Il bonus ai danni ottenuto dall'Evocato tramite il Contrattacco è ridotto del 70%, ma tutto il Veleno e il Contrattacco inflitti aumentano del 10%. Per ogni Evocato risvegliato: alla fine del turno si ottiene un Contrattacco temporaneo pari al 25% del Contrattacco permanente attuale; alla fine del turno del nemico, viene attivato un ulteriore 25% di Veleno su tutti i nemici.\n·Cono di Luce del Destino: Il numero di turni in cui i mostri comuni usano «Sguardo Fisso» diventa 6 turni. All'inizio del 15° turno, viene aggiunta 1 carta «Limite del Cono di Luce» in mano: riempie l'energia della Chiave d'Argento e la Follia di tutti gli Evocati al valore massimo."
  },
  State_89559_Name = {
    Text = "Distorsione Temporale"
  },
  State_89567_Desc = {
    Text = "Riduci il Costo di Arithmetica di questa Carta di [StateArg1]."
  },
  State_89567_Name = {
    Text = "Rinascita dalle Ceneri"
  },
  State_89568_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo la morte del portatore, mischia tutte le \"Abilità\" che consumano Arithmetica -[StateArg1] nel Mazzo Pesca, con il proprietario cambiato nell'unità alleata con i PV rimanenti più alti."
  },
  State_89568_Name = {
    Text = "Rinascita dalle Ceneri"
  },
  State_89571_Name = {
    Text = "\"Teatro in Fiamme\""
  },
  State_89572_Desc = {
    Text = "A inizio turno, aggiunge casualmente [DescArg1] carte al mazzo in mano con l'effetto <BurningKeywords:Bruciatura>, ottenendo [DescArg2] potere Temporaneo. Ogni 2 turni, il numero di carte bruciatura aggiunte aumenta di 1 e il potere Temporaneo ottenuto aumenta di [DescArg3]."
  },
  State_89572_Name = {
    Text = "\"Teatro in Fiamme\""
  },
  State_89626_Desc = {
    Text = "Dopo il Risveglio Keyflare, metti 1 carta \"Bagliore della Chiave d'Argento\" in mano. Dopo che tutti i Risvegliati si sono risvegliati, scopri 1 carta Supporto dei Risvegliati casuale a inizio turno."
  },
  State_89631_Desc = {
    Text = "[Layer] Transiti extra"
  },
  State_89634_Desc = {
    Text = "Risveglio 4"
  },
  State_89634_Name = {
    Text = "Risveglio 4"
  },
  State_89637_Desc = {
    Text = "La prima Carta di comando di ogni turno avrà effetto una volta aggiuntiva. Genera 1 Tentacolo all'Annientamento. Dopo aver cambiato la posizione del Tentacolo in \"Marea Furiosa\", l'effetto Balzo di 2 Carte di comando in questo turno deve attivarsi, entrando nello Spazio Ultra, con un tempo di ricarica di 3 turni."
  },
  State_89640_Desc = {
    Text = "Padronanza del Reame aumentata di 200 punti. Quando si consuma la Fornace Cremisi, i DAN del Tentacolo aumentano del 15%. Accumula [Arg3] Fornace Cremisi con ogni Attacco del tentacolo."
  },
  State_89642_Desc = {
    Text = "Limite di Mano +2, dopo l'Esaltazione, il Danno Finale Temporaneo aumenta del 10%. Quando la carta entra nello Spazio Ultra, 1 \"Embrione\" In Mano si trasforma in \"Rampollo della Purezza\". Ogni volta che viene generato 1 \"Embrione\", il costo di una Carta casuale nello Spazio Ultra diminuisce di 1."
  },
  State_89669_Desc = {
    Text = "Risveglio Keyflare 4"
  },
  State_89669_Name = {
    Text = "Risveglio Keyflare 4"
  },
  State_89759_Desc = {
    Text = "Dopo aver rilasciato il Seguito, Ramona ottiene un Tasso critico temporaneo del 50%."
  },
  State_89759_Name = {
    Text = "Legami preziosi"
  },
  State_90023_Name = {
    Text = "Stato utilizzato per la configurazione della tabella costante, temporaneamente scartato."
  },
  State_90059_Desc = {
    Text = "Quando si subiscono Danni attivi o Danni da tentacolo in questo turno, rimuove una quantità equivalente di Corrosione e si perde il [DescArg1]% della quantità rimossa come Vita. Quando si subiscono altri tipi di Danno, rimuove Corrosione pari al 50% del Danno subito."
  },
  State_90059_Name = {Text = "Corrosione"},
  State_90094_Name = {
    Text = "Piuma d'Onice"
  },
  State_90218_Desc = {
    Text = [[
Unico per Squadra: Limite di carte In Mano +2. Gli effetti dello stesso tipo non sono cumulabili. Il DAN Base e la Generazione di Scudo del portatore sono aumentati del <WeaponEffect_Num:[StateArg1]%>.
Ottieni <WeaponEffect_Num:[StateArg2]> Aliemus all'inizio del Turno Ultra.
Rilascia "Annientamento" per conferire a tutti i Risvegliati Danno critico temporaneo +<WeaponEffect_Num:[StateArg3]%>. Questo effetto ha un Tempo di Ricarica di 3 turni.]]
  },
  State_90218_WeaponDesc = {
    Text = [[
Limite di carte In Mano +2. Gli effetti dello stesso tipo non sono cumulabili. Il DAN Base e la Generazione di Scudo del portatore sono aumentati del <WeaponEffect_Num:[StateArg1]%>.
Ottieni <WeaponEffect_Num:[StateArg2]> Aliemus all'inizio del Turno Ultra.
Rilascia "Annientamento" per conferire a tutti i Risvegliati Danno critico temporaneo +<WeaponEffect_Num:[StateArg3]%>. Questo effetto ha un Tempo di Ricarica di 3 turni.]]
  },
  State_90221_Desc = {
    Text = "Unico per Squadra: la Generazione di Scudo del Personaggio del Portatore aumenta del <WeaponEffect_Num:[StateArg1]%>. Ottiene Scudo del Personaggio pari al <WeaponEffect_Num:[StateArg2]%> della DIF del Portatore a fine turno, che aumenta del 2% della DIF del Portatore per turno."
  },
  State_90221_Name = {
    Text = "Piuma Solitaria"
  },
  State_90221_WeaponDesc = {
    Text = "La Generazione di Scudo del Personaggio del Portatore aumenta del <WeaponEffect_Num:[StateArg1]%>. Ottiene Scudo del Personaggio pari a <WeaponEffect_Num:[Block:DescArg1]> a fine turno."
  },
  State_90294_Desc = {
    Text = "Quando si subiscono Danni attivi o Danni da tentacolo in questo turno, rimuove una quantità equivalente di Corrosione e si perde il [DescArg1]% della quantità rimossa come Vita. Quando si subiscono altri tipi di Danno, rimuove Corrosione pari al 50% del Danno subito."
  },
  State_90294_Name = {
    Text = "<Corrosion:Corrosione>"
  },
  State_90591_Name = {
    Text = "Aggiungi [Layer] carte \"Intuizione\" alla tua mano"
  },
  State_90594_Name = {
    Text = "con [Layer] Allerta temporanea"
  },
  State_90599_Name = {
    Text = "Tutti i Risvegliati ottengono [Layer] Aliemus."
  },
  State_90600_Name = {
    Text = "Ottieni [Layer] punti Keyflare"
  },
  State_90601_Name = {
    Text = "([DescArg1] <harmonyKeyWord: \"Condimento\"> tentativi rimasti)"
  },
  State_90603_Name = {
    Text = "Ottieni [Layer] FOR temporanea"
  },
  State_90604_Name = {
    Text = "Ripristina [Layer] HP, aumenta con gli HP persi"
  },
  State_90696_Desc = {
    Text = "Prima di giocare, effettua 1 Scoperta di un \"Condimento\" da inserire al suo interno e attivarne l'Effetto, aumentando il numero di tentativi di armonizzazione di 1 nelle Battaglie Boss."
  },
  State_90696_Name = {
    Text = "<harmonyKeyWord:Armonizzazione>"
  },
  State_91106_Desc = {
    Text = "Ogni accumulo di \"Fervore\" converte il 10% del Danno attivo e del Danno da Tentacolo inflitto in accumuli di <BleedingIconKeywords:Salasso>."
  },
  State_91106_Name = {Text = "Frenesia"},
  State_91165_Name = {
    Text = "Uovo Pallido"
  },
  State_91235_Desc = {
    Text = "Quando si perde Vita, riduce un numero uguale di accumuli. Quando Infortunio raggiunge 0, tutti i Risvegliatori guadagnano 10 Aliemus e gli accumuli di Infortunio vengono azzerati."
  },
  State_91235_Name = {Text = "Ferita"},
  State_91236_Name = {
    Text = "Roma Event Apply Boss HP Count"
  },
  State_91329_Desc = {
    Text = "Riduci il Costo di Arithmetica di questa Carta di [StateArg1]."
  },
  State_91329_Name = {
    Text = "Prelibatezze Macabre"
  },
  State_91521_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: A fine turno, mischia [StateArg1] <PVPDerivativeCardKeywords_17:\"Intuizione\"> In Mano."
  },
  State_91521_Name = {
    Text = "Addestramento speciale"
  },
  State_91522_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Quando equipaggiata e a fine turno, il Portatore infligge <Damage:[Damage:StateArg1]> Danno al nemico in retroguardia."
  },
  State_91522_Name = {
    Text = "Giorno di Scuola"
  },
  State_91676_Desc = {
    Text = "Per gli effetti specifici, consulta la logica base di Colpo."
  },
  State_91706_Desc = {
    Text = "Ottieni un numero uguale di accumuli di Arithmetica all'inizio del turno successivo."
  },
  State_91706_Name = {
    Text = "<CardKeyWord:Conservare Arithmetica>"
  },
  State_91717_Desc = {
    Text = "Si accumulano al massimo 3 carcasse; una volta raggiunto il limite, la prossima \"Gala Necrotico\" potrà consumarle e potenziarne l'Effetto. Le carcasse vengono ereditate nel combattimento successivo."
  },
  State_91717_Name = {Text = "Cadavere"},
  State_91759_Desc = {
    Text = "\"Piuma d'Onice\" può potenziare le abilità di \"Divus: La Piuma d'Onice\"."
  },
  State_91759_Name = {
    Text = "Piuma d'Onice"
  },
  State_91761_Desc = {
    Text = "\"Divus: La Piuma d'Onice\" conserva il 50% dello Scudo del Personaggio integro per il turno successivo e ottiene 1 accumulo di <Guaiwuheiyu:Piuma d'Onice> a fine turno."
  },
  State_91761_Name = {
    Text = "Giuramento Celeste"
  },
  State_91797_Desc = {
    Text = "Dopo che questa carta viene giocata e scartata, applica questa quantità di Scudo del Personaggio ai nemici in prima fila."
  },
  State_91797_Name = {
    Text = "<PVPredKeyword:Angoscia Velata>"
  },
  State_91799_Desc = {
    Text = "Questa carta applica [Layer] Scudo del Personaggio al nemico più avanzato quando viene giocata."
  },
  State_91799_Name = {
    Text = "<PVPredKeyword:Angoscia Velata [Layer] >"
  },
  State_91809_Desc = {
    Text = "Costo di Arithmetica di questa carta -[Layer]."
  },
  State_91809_Name = {
    Text = "Concentrazione Elevata"
  },
  State_91819_Desc = {
    Text = "Ottiene il potenziamento corrispondente in base al turno di battaglia attuale."
  },
  State_91819_Name = {
    Text = "<CardKeyWord:Crescita>"
  },
  State_91827_Desc = {
    Text = "\"Colpo\" può selezionare un bersaglio. Prima del \"Colpo\", tutti gli effetti di stato positivi del bersaglio vengono respinti al Risvegliato dietro di esso."
  },
  State_91827_Name = {
    Text = "<CardKeyWord:Chiamata del Mare Profondo>"
  },
  State_94410_Name = {
    Text = "Tenterà di ripristinare un mazzo giocatore vuoto all'Inizio del turno e dopo la fine del turno. Un mazzo non vuoto non verrà ripristinato."
  },
  State_94411_Name = {
    Text = "Tenterà di ripristinare un mazzo giocatore vuoto all'Inizio del turno e dopo la fine del turno. Un mazzo non vuoto non verrà ripristinato."
  },
  State_94426_Name = {
    Text = "Scudo del Personaggio Passivo"
  },
  State_94540_Desc = {
    Text = "Se non c'è un altro Risvegliato dietro il bersaglio, dissolvi invece i buff del bersaglio."
  },
  State_94540_Name = {
    Text = "<CardKeyWord:Respingere Potenziamenti>"
  },
  State_94600_Desc = {
    Text = "Rimuovi 1 accumulo e ripristina il 5% dei PV massimi dopo aver subito danni fatali. Ogni attivazione aumenta la quantità di guarigione dell'1% per questo turno."
  },
  State_94600_Name = {Text = "Resistenza"},
  State_94603_Name = {
    Text = "Marchio del Ghoul"
  },
  State_94608_Name = {
    Text = "Conteggio attivazioni Resistenza alla Morte"
  },
  State_94623_Desc = {
    Text = "Ogni accumulo di \"Fervore\" converte il 10% del Danno attivo e del Danno da Tentacolo inflitto in accumuli di <BleedingIconKeywords:Salasso>."
  },
  State_94623_Name = {
    Text = "<Kuangre:Fervore>"
  },
  State_94657_Desc = {
    Text = "Attiva gli effetti corrispondenti quando si uccide o si attiva l'effetto di resurrezione del nemico"
  },
  State_94657_Name = {
    Text = "<KillKeywords:Eliminazione>"
  },
  State_94692_Desc = {
    Text = "Rimuovi 1 accumulo e ripristina il 5% dei PV massimi dopo aver subito danni fatali. Ogni attivazione aumenta la quantità di guarigione dell'1% per questo turno."
  },
  State_94692_Name = {
    Text = "<Guaiwusiwangdikang: Resistenza alla Morte>"
  },
  State_94693_Desc = {
    Text = "All'inizio del turno, se sono presenti altri alleati, perdi [DescArg1] HP e concedi all'alleato con più HP 1 accumulo di <Guaiwusiwangdikang:Resistenza alla Morte> e [DescArg2] <PowerIconKeywords:FOR>."
  },
  State_94693_Name = {
    Text = "Condivisione della Carogna"
  },
  State_94708_Desc = {
    Text = "All'inizio del turno, se sono presenti altri alleati, perdi [DescArg1] HP e concedi all'alleato con più HP 1 accumulo di <Guaiwusiwangdikang:Resistenza alla Morte> e [DescArg2] <Duren:Lama Avvelenata>."
  },
  State_94708_Name = {
    Text = "Banchetto di Aequor"
  },
  State_94730_Desc = {
    Text = "Quando infliggi danno non bloccato, applica [Layer] <IntoxicationIconKeywords:Veleno> per accumulo."
  },
  State_94730_Name = {
    Text = "Lama Avvelenata"
  },
  State_94993_Desc = {
    Text = "Ripristina il numero di Tsunami Terrificanti a ogni turno."
  },
  State_94993_Name = {
    Text = "Reset Conteggio Onde Furiose"
  },
  State_94994_Desc = {
    Text = "Ogni strato aggiunge 1 al numero di attacchi, perde 1 strato quando si subisce Danno critico, con un minimo di 1 strato, e perde tutti gli accumuli alla fine del round."
  },
  State_94994_Name = {
    Text = "Conteggio Onde Furiose"
  },
  State_94995_Desc = {
    Text = "Ogni volta che si subisce un Danno critico, si ottiene il 3% di <Baojidikang:Res. Critica Temporanea>. Ogni volta che si infligge Danno, applica \"Marchio dell'Abisso\" a una carta casuale."
  },
  State_94995_Name = {
    Text = "Riti del Mare Profondo"
  },
  State_94996_Desc = {
    Text = "Quando subisci danni, ottieni un ammontare equivalente di FOR temporanea."
  },
  State_94996_Name = {Text = "Furia"},
  State_94997_Desc = {
    Text = "Ogni volta che si subisce un Danno critico, si ottiene il 5% di <Baojidikang:Res. Critica Temporanea>. Ogni volta che si infligge Danno, applica \"Marchio dell'Abisso\" a una carta casuale."
  },
  State_94997_Name = {
    Text = "Riti del Mare Profondo"
  },
  State_94998_Desc = {
    Text = "Quando <Guaiwusiwangdikang:Resistenza alla Morte> viene attivata, applica <SlowIconKeywords:Stagnazione> a una carta casuale nel Mazzo di Pesca o nella Mano."
  },
  State_94998_Name = {
    Text = "Incarnazione della Disperazione"
  },
  State_94999_Desc = {
    Text = "Reimposta il numero di Onde del Divoratore a ogni turno."
  },
  State_94999_Name = {
    Text = "Reset Conteggio Onde Divoratrici"
  },
  State_95000_Desc = {
    Text = "Ottiene immunità agli stati negativi."
  },
  State_95000_Name = {
    Text = "Immune ai Debuff"
  },
  State_95001_Desc = {
    Text = "Ogni strato aggiunge 1 al numero di attacchi, perde 1 strato quando si subisce Danno critico, con un minimo di 1 strato, e perde tutti gli accumuli alla fine del round."
  },
  State_95001_Name = {
    Text = "Conteggio Onde Divoratrici"
  },
  State_95002_Desc = {
    Text = "Probabilità di Colpo Critico ridotta del [Layer]% in questo turno."
  },
  State_95002_Name = {
    Text = "Res. Critica Temporaneo"
  },
  State_95002_WeaponDesc = {
    Text = "Probabilità di Colpo Critico ridotta del [Layer]% in questo turno."
  },
  State_95035_Desc = {
    Text = "Quando infliggi danno non bloccato, applica 1 <IntoxicationIconKeywords:Veleno> per accumulo."
  },
  State_95035_Name = {
    Text = "<Duren: Lama Avvelenata>"
  },
  State_95038_Desc = {
    Text = "Quando subisci danni, ottieni un ammontare equivalente di FOR temporanea."
  },
  State_95038_Name = {
    Text = "<Kuangbao: Furia>"
  },
  State_95040_Desc = {
    Text = "Registro vita persa"
  },
  State_95040_Name = {
    Text = "Registro vita persa"
  },
  State_95932_Name = {
    Text = "Veglia del Ghoul Risucchiante"
  },
  State_95937_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del Destino>: Dopo aver usato \"Esaltazione\", pesca [StateArg1] carte, dando priorità alle tue carte \"Abilità\", e riduci il loro Costo di Arithmetica di [StateArg2]."
  },
  State_95937_Name = {
    Text = "Prelibatezze Macabre"
  },
  State_95938_Desc = {
    Text = "Per ogni carta rimossa, ottieni 1 accumulo di Sazietà, fino a un massimo di 10 accumuli."
  },
  State_95938_Name = {Text = "Sazietà"},
  State_95943_Desc = {
    Text = "I danni inflitti sono temporaneamente ridotti del 30%."
  },
  State_95943_Name = {
    Text = "Interferenza"
  },
  State_95944_Desc = {
    Text = "Unico per Squadra: DAN Base del portatore +<WeaponEffect_Num:[StateArg1]%> Durante questa esplorazione, ogni volta che il portatore uccide un nemico, il suo Tasso Crit. +2% e DAN Base di Esaltazione +<WeaponEffect_Num:[StateArg2]%>, fino a 10 volte. Se il Reame attuale è Caro, il portatore ottiene <WeaponEffect_Num:[StateArg4]> Aliemus extra quando consuma direttamente un Embrione (ricarica 3 turni)."
  },
  State_95944_WeaponDesc = {
    Text = "Unico per Squadra: DAN Base del portatore +<WeaponEffect_Num:[StateArg1]%> Durante questa esplorazione, ogni volta che il portatore uccide un nemico, il suo Tasso Crit. +2% e DAN Base di Esaltazione +<WeaponEffect_Num:[StateArg2]%>, fino a 10 volte. Se il Reame attuale è Caro, il portatore ottiene <WeaponEffect_Num:[StateArg4]> Aliemus extra quando consuma direttamente un Embrione (ricarica 3 turni)."
  },
  State_95948_Name = {
    Text = "Ghoul Risucchiante"
  },
  State_95949_Desc = {
    Text = "Dopo aver giocato, Doresain perde metà dei <Guaiwucanhai:Relitti>."
  },
  State_95949_Name = {Text = "Imboscata"},
  State_95953_Desc = {
    Text = "L'effetto di Guarigione della Resistenza alla Morte è aumentato di 5 volte."
  },
  State_95953_Name = {
    Text = "Velo dei Sussurri"
  },
  State_95954_Name = {
    Text = "Ghoul Risucchiante: Edizione Risvegliata"
  },
  State_95960_Desc = {
    Text = "Le cariche di «Carcassa» potenziano l'effetto di \"Raccolta di Cadaveri\"."
  },
  State_95960_Name = {Text = "Cadavere"},
  State_95962_Name = {
    Text = "Conteggio Uccisioni"
  },
  State_95964_Desc = {
    Text = "Unico per Squadra: DAN Base del Portatore +<WeaponEffect_Num:[StateArg1]%>. Ogni volta che il Portatore uccide un nemico, accumula Fornace Cremisi pari a <WeaponEffect_Num:[StateArg2]%> dell'ATT del Portatore se il Reame attuale è Caro."
  },
  State_95964_WeaponDesc = {
    Text = "DAN Base del Portatore +<WeaponEffect_Num:[StateArg1]%>%. Ogni volta che il Portatore uccide un nemico, accumula Fornace Cremisi pari a <WeaponEffect_Num:[DescArg1]>."
  },
  State_95966_Desc = {
    Text = "All'inizio del prossimo turno, pesca [Layer] carte di questo Risvegliato."
  },
  State_95966_Name = {
    Text = "Omaggio Crudele"
  },
  State_95967_Desc = {
    Text = "Le cariche di «Carcassa» potenziano l'effetto di \"Raccolta di Cadaveri\"."
  },
  State_95967_Name = {
    Text = "<Guaiwucanhai:Cadavere>"
  },
  State_95968_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Ottieni [StateArg1] <StrongEffectKeywords:Amplificazione> quando equipaggiata. Quando il Portatore uccide un nemico, il Danno in eccesso si trasferisce al Risvegliatore alle spalle."
  },
  State_95968_Name = {
    Text = "Bacio del Riposo"
  },
  State_96167_Desc = {
    Text = "Non può essere dissolto. Dopo che un Risvegliato viene ucciso, gli altri alleati ricevono [StateArg1] <StrongEffectKeywords:Amplificazione>."
  },
  State_96167_Name = {
    Text = "Brace della Stella Nera"
  },
  State_96183_Desc = {
    Text = "Alla fine del turno, se non ci sono altri alleati in campo, passa alla modalità di autodistruzione."
  },
  State_96183_Name = {
    Text = "Autodistruzione del Ghoul"
  },
  State_96193_Name = {
    Text = "Ouverture del Banchetto"
  },
  State_96330_Desc = {
    Text = "Per ogni 1% di HP persi, il DAN Base, lo Scudo del Personaggio e l'Aliemus forniti dalle Carte di comando di Doresain aumentano dell'1%."
  },
  State_96330_Name = {
    Text = "Sussurri Spettrali"
  },
  State_96352_Name = {
    Text = "Conteggio Ghoul iniziale"
  },
  State_96354_Name = {
    Text = "PV massimi iniziali"
  },
  State_96355_Desc = {
    Text = "La probabilità di Colpo Critico è ridotta del [Layer]%."
  },
  State_96355_Name = {
    Text = "Res. Critica"
  },
  State_96355_WeaponDesc = {
    Text = "La probabilità di subire un Colpo Critico in questa battaglia è ridotta del [Layer]%."
  },
  State_96356_Desc = {
    Text = "Per ogni [DescArg1] HP persi, ottieni [DescArg2] accumulo/i di <ReinforcePVEKeywords:Fortezza>, fino a [DescArg3] accumuli. Dopo aver attivato \"<Guaiwusiwangdikang:Resistenza alla Morte>\", gli HP massimi del bersaglio aumentano del [DescArg4]%."
  },
  State_96356_Name = {
    Text = "Protezione di Elena"
  },
  State_96357_Desc = {
    Text = "Dopo la fine del turno, ottieni un numero uguale di accumuli di Forza."
  },
  State_96357_Name = {
    Text = "<Fennu:Rabbia>"
  },
  State_96358_Desc = {
    Text = "Probabilità di Colpo Critico ridotta del [Layer]%."
  },
  State_96358_Name = {
    Text = "<Baojidikang:Res. Critica>"
  },
  State_96412_Name = {
    Text = "Ascoltatore della Bestia Divoratrice"
  },
  State_96416_Desc = {
    Text = "La probabilità di Colpo Critico è ridotta del [Layer]%."
  },
  State_96416_Name = {
    Text = "Res. Critica"
  },
  State_96603_Name = {
    Text = "Se non giocata in questo turno, attiva l'effetto \"Armonia\" una volta all'inizio del turno successivo."
  },
  State_96610_Name = {
    Text = "Resistenza alla Prima Morte"
  },
  State_96613_Name = {
    Text = "Ascoltando le Onde Giganti"
  },
  State_96650_Desc = {
    Text = "Ogni accumulo aumenta il Tasso di Colpo Crit. del Risvegliatore del [DescArg1]%."
  },
  State_96650_Name = {
    Text = "<ExclamationPointColour:Fiamma Oscura>"
  },
  State_96719_Desc = {
    Text = "In questo turno, giocare carte con <BurningKeywords:Bruciatura> non genera più <Heat:Fiamma Oscura>. Invece, consuma 1 accumulo di <Heat:Fiamma Oscura> per far attivare detta carta due volte. Rimuovi tutta la <Heat:Fiamma Oscura> alla fine del turno."
  },
  State_96719_Name = {
    Text = "Combustione Infinita"
  },
  State_96731_Desc = {
    Text = "In questo turno, giocare carte con <BurningKeywords:Bruciatura> non genera più <Heat:Fiamma Oscura>. Invece, consuma 1 accumulo di <Heat:Fiamma Oscura> per far attivare detta carta due volte. Rimuovi tutta la <Heat:Fiamma Oscura> alla fine del turno."
  },
  State_96731_Name = {
    Text = "<Overload:Combustione Infinita>"
  },
  State_96732_Desc = {
    Text = "Ogni accumulo aumenta il Tasso di Colpo Crit. del Risvegliatore del [DescArg1]%."
  },
  State_96732_Name = {
    Text = "<Heat:Fiamma Oscura>"
  },
  State_96740_Desc = {
    Text = "Danno attivo e accumuli di Sanguinamento subiti +50%. Rimosso quando si subisce Danno o a inizio turno."
  },
  State_96740_Name = {
    Text = "<CardKeyWord:Cedimento>"
  },
  State_96741_Desc = {
    Text = "Dopo averla giocata, se l'Arithmetica rimanente è superiore a [StateArg1], consuma ulteriormente [StateArg1] Arithmetica per attivare gli Effetti successivi."
  },
  State_96741_Name = {
    Text = "<CardKeyWord:Sovraccarico Arithmetica>"
  },
  State_96742_Name = {
    Text = "Il sovraccarico di Arithmetica attiva il marchio"
  },
  State_96743_Desc = {
    Text = "Dopo averla giocata, se l'Arithmetica rimanente supera la quantità richiesta dal Sovraccarico di Arithmetica, consuma ulteriore Arithmetica per attivare gli effetti successivi."
  },
  State_96743_Name = {
    Text = "<CardKeyWord:Sovraccarico Arithmetica>"
  },
  State_96744_Desc = {
    Text = "Danno attivo e accumuli di Sanguinamento subiti +50%. Rimosso quando si subisce Danno o a inizio turno."
  },
  State_96744_Name = {Text = "Cedimento"},
  State_96774_Desc = {
    Text = "Ogni volta che si subisce Danno Crit., si ottiene il 3% di Resistenza Critica Temporanea."
  },
  State_96774_Name = {
    Text = "Spettro del Mare profondo"
  },
  State_96780_Desc = {
    Text = "La Carta viene Conservata, ma quando giocata o scartata, rimuovi Contaminazione e richiama 1 \"Escrescenza degli Abissi\", fino a 2. Se non c'è spazio per il richiamo, la Marionetta della Putrescenza ottiene immediatamente [DescArg1] Forza e [DescArg2] PV."
  },
  State_96780_Name = {
    Text = "<Kuangluan:Frenesia del Navigatore>"
  },
  State_96783_Desc = {
    Text = "Ogni turno, applica \"<Kuangluan:Frenesia del Navigatore>\" a 2 carte."
  },
  State_96783_Name = {
    Text = "Rituale del Navigatore"
  },
  State_96784_Desc = {
    Text = "Può ridurre l'Assalto della Marionetta della Putrescenza, fino a 5 accumuli."
  },
  State_96784_Name = {Text = "Caos"},
  State_96808_Desc = {
    Text = "Per ogni [DescArg1] HP persi, ottieni 15 accumuli di \"<ReinforcePVEKeywords:Fortezza>\", fino a un massimo di 75 accumuli. Quando viene infranto, rimuovi tutti gli accumuli e ottieni 1 accumulo di \"<Chaos:Caos>\". Se la Riforma non è stata scatenata, al ricevere danni fatali, cambia l'Intenzione in \"Riforma\" e diventa immune a tutti i danni."
  },
  State_96808_Name = {
    Text = "Marionetta Chimera"
  },
  State_96809_Name = {
    Text = "Conteggio Marionette della Chimera"
  },
  State_96810_Desc = {
    Text = "Danno inflitto -25%."
  },
  State_96810_Name = {
    Text = "Velo dei Sussurri"
  },
  State_96813_Name = {
    Text = "Marcatore di Ricostruzione"
  },
  State_97114_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Il \"Colpo\" genera [StateArg1] Arithmetica, Danno \"Abilità\" +[StateArg2]%."
  },
  State_97114_Name = {
    Text = "Sole Incombente"
  },
  State_97118_Name = {
    Text = "Rottura della Marionetta Chimerica"
  },
  State_97119_Desc = {
    Text = "La Carta viene Conservata, ma quando giocata o scartata, rimuovi Contaminazione e richiama 1 \"Escrescenza degli Abissi\", fino a 2. Se non c'è spazio per il richiamo, la Marionetta della Putrescenza ottiene immediatamente [DescArg1] Forza e [DescArg2] PV."
  },
  State_97119_Name = {
    Text = "<Kuangluan:Frenesia del Navigatore>"
  },
  State_97120_Desc = {
    Text = "Protetti dal cerchio magico, il danno di tutti i nemici è ridotto del 25%."
  },
  State_97120_Name = {
    Text = "Velo dei Sussurri"
  },
  State_97131_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Per ogni 1 Arithmetica consumata dall'\"Abilità\", Aumento DAN del [StateArg1]%. Dopo aver ottenuto un'Uccisione, il Danno dell'\"Esaltazione\" aumenta del [StateArg2]%, bonus attuale [DescArg1]%."
  },
  State_97131_Name = {
    Text = "Morte color ambra"
  },
  State_97134_Desc = {
    Text = "Il Danno Finale inflitto è aumentato del 50%."
  },
  State_97134_Name = {
    Text = "Cantilena di Celina"
  },
  State_97135_Desc = {
    Text = "Danno Finale +25%."
  },
  State_97135_Name = {
    Text = "Sussurro di Celina"
  },
  State_97136_Desc = {
    Text = "Danno Finale +100%"
  },
  State_97136_Name = {
    Text = "Aria di Celina"
  },
  State_97137_Desc = {
    Text = "Scarta e poi ritorna in mano."
  },
  State_97137_Name = {
    Text = "Scarta e poi ritorna in mano"
  },
  State_97137_WeaponDesc = {
    Text = "Quando pescata, applica Debolezza a te stesso per 1 turno. Quando usata, applica Debolezza a tutti i nemici per 1 turno. Non può essere venduta."
  },
  State_97219_Desc = {
    Text = "Le prossime <plural value=\"[Layer]\" singular=\"carta\" plural=\"carte\"> che Wanda gioca hanno effetto 1 volta aggiuntiva."
  },
  State_97219_Name = {
    Text = "Regina delle Spine"
  },
  State_97251_Desc = {
    Text = "Non può essere bersagliato o avere priorità da attacchi nemici o abilità a bersaglio singolo.\nRimozione automatica: Se l'unità ottiene Provocazione; Se non rimangono alleati; Se un nemico ottiene Provocazione.\nAll'attivazione: Rimuove la Furtività attuale e qualsiasi Provocazione degli alleati."
  },
  State_97251_Name = {Text = "Furtività"},
  State_97252_Desc = {
    Text = "Non può essere bersagliato o avere priorità da attacchi nemici o abilità a bersaglio singolo.\nRimozione automatica: Se l'unità ottiene Provocazione; Se non rimangono alleati; Se un nemico ottiene Provocazione.\nAll'attivazione: Rimuove la Furtività attuale e qualsiasi Provocazione degli alleati."
  },
  State_97252_Name = {
    Text = "<PVPSneakKeywords:Furtività>"
  },
  State_97339_Name = {
    Text = "Coppa del Campione di Mythag"
  },
  State_97742_Desc = {
    Text = "Ogni volta che si subisce un Danno attivo, infliggi [Layer] <FixedDamage:DAN Puro> alla fonte del danno."
  },
  State_97742_Name = {Text = "Contatore"},
  State_97743_Desc = {
    Text = "Il Danno attivo inflitto è aumentato di [Layer]."
  },
  State_97743_Name = {
    Text = "<PowerColourKeywords:FOR>"
  },
  State_97744_Desc = {
    Text = "Danni subiti -[Layer]%."
  },
  State_97744_Name = {
    Text = "<ReinforceColour:Fortezza>"
  },
  State_97744_WeaponDesc = {
    Text = "Riduce tutti i danni inflitti del [DescArg1]%."
  },
  State_97938_Desc = {
    Text = "Danno Finale aumentato del [DescArg1]%."
  },
  State_97938_Name = {
    Text = "Coppa del Campione di Mythag"
  },
  State_97939_Desc = {
    Text = "Il Danno Finale inflitto è aumentato del 50%."
  },
  State_97939_Name = {
    Text = "Coppa del Campione di Mythag"
  },
  State_97941_Desc = {
    Text = "DAN Base aumentato del 100%."
  },
  State_97941_Name = {
    Text = "Coppa del Campione di Mythag"
  },
  State_97942_Desc = {
    Text = "Ottieni 35 Aliemus dopo aver usato Esaltazione."
  },
  State_97942_Name = {
    Text = "Coppa del Campione di Mythag"
  },
  State_97943_Name = {
    Text = "Conteggio Conservare di Arithmetica"
  },
  State_98055_Desc = {
    Text = "Alla fine del round, genera 1 Tentacolo. Lo stato viene rimosso al Risveglio."
  },
  State_98055_Name = {Text = "Sopore"},
  State_98060_Desc = {
    Text = "Questo Risvegliatore è ancora Non Risvegliato... Si Desterà quando sarà sul punto di essere sconfitto, ripristinerà la Vita e inizierà a combattere nella sua vera forma."
  },
  State_98060_Name = {
    Text = "Non Risvegliato"
  },
  State_98068_Desc = {
    Text = "Quando \"Deflagrazione\" raggiunge 10 accumuli, ottieni 2 Arithmetica e potenzia tutti i \"Bagliore solare\" in \"Iperbrillamento\"."
  },
  State_98068_Name = {
    Text = "<BaoyanKeywords:Deflagrazione>"
  },
  State_98139_Desc = {
    Text = "<BurningKeywords:Brucia> casualmente 1 carta dalla mano dell'avversario all'inizio del suo turno."
  },
  State_98139_Name = {
    Text = "Braci del Karma"
  },
  State_98140_Desc = {
    Text = "Dopo aver accumulato 10 accumuli di <MonsterExFlameKeywords:Deflagrazione>, cambia Intenzione nell'Iperbrillamento dal danno estremamente elevato!"
  },
  State_98140_Name = {
    Text = "<BurningColor:Deflagrazione>"
  },
  State_98147_Desc = {
    Text = "Quando il nemico gioca carte con <BurningKeywords:Bruciatura>, ottieni 1 accumulo di <MonsterExFlameKeywords:Deflagrazione>, ma perdi temporaneamente [DescArg1] <PowerIconKeywords:FOR>."
  },
  State_98147_Name = {
    Text = "Fiamma inestinguibile"
  },
  State_98148_Desc = {
    Text = "Questo Risvegliatore non è ancora Non Risvegliato... Si Risveglierà quando starà per essere sconfitto, scarterà tutte le carte rimanenti in mano e conferirà <BurningKeywords:Bruciatura>, ripristinerà i PV e combatterà a piena potenza."
  },
  State_98148_Name = {
    Text = "Non Risvegliato"
  },
  State_98302_Desc = {
    Text = "Unico per Squadra: DAN Base inflitto dal portatore +<WeaponEffect_Num:[StateArg1]%>, e Generazione di FOR +<WeaponEffect_Num:[StateArg2]%>. Dopo aver giocato la Carta di comando del portatore, ottieni FOR temporanea pari al <WeaponEffect_Num:[StateArg3]%> dell'ATT del portatore, attivabile fino a 5 volte per turno."
  },
  State_98302_WeaponDesc = {
    Text = "DAN Base inflitto dal Portatore +<WeaponEffect_Num:[StateArg1]%>, e FOR generata +<WeaponEffect_Num:[StateArg2]%>. Dopo aver giocato la Carta di comando del Portatore, ottieni <WeaponEffect_Num:[Power:DescArg1]> FOR temporanea, attivabile fino a 5 volte per turno. (attualmente attivato [DescArg2]/5 volte)."
  },
  State_98323_Desc = {
    Text = "La carta torna nella tua mano dopo essere stata scartata"
  },
  State_98323_Name = {
    Text = "Ritorno in Mano dopo essere stata scartata"
  },
  State_98341_Desc = {
    Text = "Può essere mescolato con altri colori primari per creare nuovi colori."
  },
  State_98341_Name = {
    Text = "<Yellow:Colore: Giallo>"
  },
  State_98344_Desc = {
    Text = "Può essere mescolato con altri colori primari per creare nuovi colori."
  },
  State_98344_Name = {
    Text = "<Red:Colore: Rosso>"
  },
  State_98345_Desc = {
    Text = "Può essere mescolato con altri colori primari per creare nuovi colori."
  },
  State_98345_Name = {
    Text = "<Blue:Colore: Blu>"
  },
  State_98366_Desc = {
    Text = "All'inizio del turno, se il Keyflare è superiore a [Arg1], consuma [Arg1] Keyflare per mettere 1 <DerivativeCardKeywords_115:\"Av. Intuizione\"> nella tua mano."
  },
  State_98435_Desc = {
    Text = "Una miscela di rosso e blu. Per ogni istanza di danno attivo inflitto, ottieni <Block:[DescArg1]> Scudo."
  },
  State_98435_Name = {
    Text = "<PurpleKeyWord:Visuale: Viola>"
  },
  State_98436_Desc = {
    Text = "Una miscela di rosso e giallo. Dopo aver rilasciato l'Esaltazione, il Risvegliatore corrispondente ottiene <Energy:15> Aliemus."
  },
  State_98436_Name = {
    Text = "<ExclamationPointColour:Visuale: Arancione>"
  },
  State_98437_Desc = {
    Text = "Danno Finale aumentato del 10%."
  },
  State_98437_Name = {
    Text = "<Red:Colore: Rosso>"
  },
  State_98438_Desc = {
    Text = "Una miscela di giallo e blu. Dopo aver giocato \"Difesa\", ripristina <Heal:[DescArg1]> PV."
  },
  State_98438_Name = {
    Text = "<GreenWord:Visuale: Verde>"
  },
  State_98439_Desc = {
    Text = "Una miscela di giallo e blu. Dopo aver giocato \"Difesa\", ripristina <Heal:[DescArg1]> PV."
  },
  State_98439_Name = {
    Text = "<GreenWord:Visuale: Verde>"
  },
  State_98440_Desc = {
    Text = "Una miscela di rosso e blu. Per ogni istanza di danno attivo inflitto, ottieni <Block:[DescArg1]> Scudo."
  },
  State_98440_Name = {
    Text = "<PurpleKeyWord:Visuale: Viola>"
  },
  State_98441_Desc = {
    Text = "Una miscela di rosso e giallo. Dopo aver rilasciato l'Esaltazione, il Risvegliatore corrispondente ottiene <Energy:15> Aliemus."
  },
  State_98441_Name = {
    Text = "<ExclamationPointColour:Visuale: Arancione>"
  },
  State_98444_Desc = {
    Text = "Unico per Squadra: il DAN Base del portatore è potenziato del <WeaponEffect_Num:[StateArg1]%>. Dopo aver giocato 5 Carte di comando del portatore, il portatore ottiene <WeaponEffect_Num:[StateArg2]%> di Tasso critico temporaneo. Questo effetto può attivarsi solo una volta per turno."
  },
  State_98444_WeaponDesc = {
    Text = "Il DAN Base inflitto dal Portatore è aumentato del <WeaponEffect_Num:[StateArg1]%>. Dopo aver giocato 5 Carte di comando del Portatore, il Portatore ottiene <WeaponEffect_Num:[StateArg2]%> di Tasso critico temporaneo, e questo effetto può attivarsi solo una volta per turno (carte giocate attualmente [DescArg1]/5)."
  },
  State_98466_Name = {
    Text = "<HuoyanKeywords1:Fiamma1>"
  },
  State_98468_Name = {
    Text = "<HuoyanKeywords3:Fiamma3>"
  },
  State_98470_Name = {
    Text = "<HuoyanKeywords2:Fiamma2>"
  },
  State_98474_Desc = {
    Text = "I colori primari che possono essere mescolati per creare altri colori, composti da rosso, giallo e blu."
  },
  State_98474_Name = {Text = "Colore"},
  State_98484_Name = {
    Text = "Annegati nel Dolore"
  },
  State_98485_Desc = {
    Text = "Il Danno Finale e la FOR concessi da questa carta +[DescArg1]%; Scudo e Aliemus +[DescArg2]%. Ottiene \"Conservare\". Dopo averla giocata, consuma tutti gli accumuli di \"Fiamma\" e trasferisce 1 accumulo di \"Fiamma\" a un'altra Carta di comando di Kathigu-Ra nella mano."
  },
  State_98485_Name = {
    Text = "<HuoyanKeywords2:Fiamma2>"
  },
  State_98486_Desc = {
    Text = "Il Danno Finale e la FOR concessi da questa carta +[DescArg1]%; Scudo e Aliemus +[DescArg2]%. Ottiene \"Conservare\". Dopo averla giocata, consuma tutti gli accumuli di \"Fiamma\" e trasferisce 1 accumulo di \"Fiamma\" a un'altra Carta di comando di Kathigu-Ra nella mano."
  },
  State_98486_Name = {
    Text = "<HuoyanKeywords3:Fiamma3>"
  },
  State_98487_Desc = {
    Text = "Il Danno Finale e la FOR concessi da questa carta +[DescArg1]%; Scudo e Aliemus +[DescArg2]%. Ottiene \"Conservare\". Dopo averla giocata, consuma tutti gli accumuli di \"Fiamma\" e trasferisce 1 accumulo di \"Fiamma\" a un'altra Carta di comando di Kathigu-Ra nella mano."
  },
  State_98487_Name = {
    Text = "<HuoyanKeywords1:Fiamma1>"
  },
  State_98488_Desc = {
    Text = "Il Danno Finale, lo Scudo, l'Aliemus e la FOR concessi da questa carta +30%. Ottiene \"Conserva\". Dopo averla giocata, consuma tutti gli accumuli di \"Fiamma\" e trasferisci 1 accumulo di \"Fiamma\" a un'altra Carta di comando di Kathigu-Ra in mano."
  },
  State_98488_Name = {
    Text = "<HuoyanKeywords:Fiamma>"
  },
  State_98492_Desc = {
    Text = "All'inizio dell'esplorazione, COS, ATT e DIF aumentano del [StateArg1]%."
  },
  State_98492_Name = {
    Text = "Attitudine Forgianima"
  },
  State_98495_Desc = {
    Text = "All'inizio dell'esplorazione, COS, ATT e DIF aumentano del [StateArg1]%."
  },
  State_98495_Name = {
    Text = "Attitudine Forgianima"
  },
  State_98507_Desc = {
    Text = "All'inizio dell'esplorazione, COS, ATT e DIF aumentano del [StateArg1]%."
  },
  State_98507_Name = {
    Text = "Attitudine Forgianima"
  },
  State_98511_Name = {
    Text = "Ottieni Carta Derivata"
  },
  State_98551_Desc = {
    Text = "All'inizio della Battaglia, Padronanza del Reame +[Arg1]. All'inizio dei turni dispari, pesca 1 carta. All'inizio dei turni pari, ottieni 1 Arithmetica."
  },
  State_98553_Desc = {
    Text = "Ogni volta che viene generato 1 \"Embrione\", ottieni [Arg1] Fornace Cremisi, fino a 3 volte per turno."
  },
  State_98555_Desc = {
    Text = "All'inizio della Battaglia, ottieni [Arg1]% di Amplificazione. Dopo aver applicato Veleno per la prima volta ogni turno, pesca [Arg2] carte."
  },
  State_98556_Desc = {
    Text = "Gli effetti base di tutti i Risvegliatori per la Guarigione dei PV e lo Scudo del Personaggio sono aumentati del [Arg1]%."
  },
  State_98557_Desc = {
    Text = "Ogni volta che viene generato 1 \"Embrione\", ottieni [Arg1] Fornace Cremisi, fino a 3 volte per turno."
  },
  State_98559_Desc = {
    Text = "Ottieni [Arg1] FOR temporanea ogni volta che peschi o scarti una carta, fino a [Arg2] FOR temporanea."
  },
  State_98560_Desc = {
    Text = "Tutti i Risvegliati infliggono DAN Base aumentato del [Arg1]%. Prima di scatenare l'Esaltazione, aumenta temporaneamente il DAN Base inflitto dal Risvegliato che scatena l'Esaltazione del [Arg2]%."
  },
  State_98561_Desc = {
    Text = "All'inizio del turno, se i PV sono inferiori al 50%, ottieni temporaneamente Amplificazione del Danno +[Arg1]%. Se i PV sono inferiori al 25%, pesca [Arg2] carte aggiuntive e ottieni [Arg2] Arithmetica."
  },
  State_98562_Desc = {
    Text = "Dopo aver inflitto Danno attivo o danno da Tentacolo, aumenta il danno da Tentacolo subito dal bersaglio del [Arg1]% per il resto del turno. Può attivarsi fino a 20 volte per turno."
  },
  State_98563_Desc = {
    Text = "All'inizio della battaglia, ottieni [Arg1] Forza. Ottieni [Arg2] FOR temporanea ogni volta che giochi una carta \"Esaurimento\", fino a [Arg3] volte."
  },
  State_98564_Desc = {
    Text = "L'Esaltazione ottiene [Arg1] Keyflare, con un massimo di 3 attivazioni per turno."
  },
  State_98565_Desc = {
    Text = "Ogni volta che una carta entra nello Spazio Ultra, pesca [Arg1] Carte di comando appartenenti al proprietario di questa carta dal Mazzo di Pesca. Se non è possibile pescare, ottieni una quantità equivalente di Arithmetica. Questo effetto può attivarsi al massimo 2 volte per turno."
  },
  State_98567_Desc = {
    Text = "Prima della fine del turno, ogni Risvegliatore a cui appartiene una Carta di comando In Mano ottiene [Arg1] Aliemus."
  },
  State_98568_Desc = {
    Text = "All'inizio della battaglia, ottieni Amplificazione del Danno +[Arg1]%. Dopo aver inflitto Danno attivo, infliggi [Arg2] Veleno a tutti i nemici, con un massimo di 5 attivazioni aggiuntive per turno."
  },
  State_98569_Desc = {
    Text = "Dopo il primo \"Posse\" di ogni turno, applica [Arg1] Veleno a tutti i nemici e ottieni [Arg2] Contatore."
  },
  State_98571_Desc = {
    Text = "Ripristina [Arg1] PV e concede [Arg2] Keyflare dopo aver usato Stimolo Keyflare."
  },
  State_98571_Name = {
    Text = "Parasole del Viaggiatore"
  },
  State_98572_Desc = {
    Text = "Dopo aver rilasciato il secondo \"Posse\" di ogni turno, ottieni [Arg1] Keyflare e tutti i Risvegliatori ottengono [Arg2] Aliemus."
  },
  State_98575_Desc = {
    Text = "All'inizio della battaglia, ottieni Amplificazione del Danno +[Arg1]%. Dopo aver inflitto Danno attivo, infliggi [Arg2] Veleno a tutti i nemici, con un massimo di 5 attivazioni aggiuntive per turno."
  },
  State_98576_Desc = {
    Text = "All'inizio della battaglia, applica [Arg1] Debolezza e Vulnerabile a tutti i nemici. Questo effetto viene attivato anche dopo \"Annientamento\", ma ha un tempo di ricarica di 3 turni."
  },
  State_98577_Desc = {
    Text = "Tutti i Risvegliati infliggono DAN Base aumentato del [Arg1]%. Prima di scatenare l'Esaltazione, aumenta temporaneamente il DAN Base inflitto dal Risvegliato che scatena l'Esaltazione del [Arg2]%."
  },
  State_98579_Desc = {
    Text = "All'inizio del turno, se i PV sono inferiori al 50%, ottieni temporaneamente Amplificazione del Danno +[Arg1]%. Se i PV sono inferiori al 25%, pesca [Arg2] carte aggiuntive e ottieni [Arg2] Arithmetica."
  },
  State_98581_Desc = {
    Text = "Tutti i Risvegliati ottengono [Arg1] Keyflare dalla loro prima \"Carta di comando\" di ogni turno."
  },
  State_98582_Desc = {
    Text = "Ogni 5 utilizzi di \"Esaltazione\", le successive [Arg1] Carte Comando Non-Derivate si attivano 1 volta aggiuntiva."
  },
  State_98583_Desc = {
    Text = "Tutti i Risvegliati ottengono [Arg1] Keyflare dalla loro prima \"Carta di comando\" di ogni turno."
  },
  State_98586_Desc = {
    Text = "All'inizio del turno, tutti i Risvegliati il cui Aliemus è insufficiente per scatenare l'Esaltazione ottengono [Arg1] Aliemus."
  },
  State_98587_Desc = {
    Text = "Ottieni [Arg1] FOR temporanea ogni volta che peschi o scarti una carta, fino a [Arg2] FOR temporanea."
  },
  State_98588_Desc = {
    Text = "Prima della fine del turno, ogni Risvegliatore a cui appartiene una Carta di comando In Mano ottiene [Arg1] Aliemus."
  },
  State_98589_Desc = {
    Text = "All'inizio della battaglia, tutti i nemici perdono temporaneamente [Arg1] Forza. Anche l'uso della \"Fornace Cremisi\" attiva questo effetto, ma ha un tempo di ricarica di 3 turni."
  },
  State_98590_Desc = {
    Text = "All'inizio della Battaglia, ottieni [Arg1]% di Amplificazione. Dopo aver applicato Veleno per la prima volta ogni turno, pesca [Arg2] carte."
  },
  State_98591_Desc = {
    Text = "Dopo il primo \"Posse\" di ogni turno, applica [Arg1] Veleno a tutti i nemici e ottieni [Arg2] Contatore."
  },
  State_98596_Desc = {
    Text = "Il primo \"Posse\" di ogni turno rimborsa il [Arg1]% del Keyflare consumato."
  },
  State_98597_Desc = {
    Text = "Ripristina [Arg1] PV e concede [Arg2] Keyflare dopo aver usato Stimolo Keyflare."
  },
  State_98597_Name = {
    Text = "Parasole del Viaggiatore+"
  },
  State_98598_Desc = {
    Text = "All'inizio della battaglia, ottieni [Arg1] Forza. Ottieni [Arg2] FOR temporanea ogni volta che giochi una carta \"Esaurimento\", fino a [Arg3] volte."
  },
  State_98600_Desc = {
    Text = "All'inizio della battaglia, tutti i nemici perdono temporaneamente [Arg1] Forza. Anche l'uso della \"Fornace Cremisi\" attiva questo effetto, ma ha un tempo di ricarica di 3 turni."
  },
  State_98602_Desc = {
    Text = "All'inizio della Battaglia, ottieni [Arg1]% di Amplificazione del Danno. Quando ottieni un Contatore per la prima volta ogni turno, ottieni 1/2 Arithmetica."
  },
  State_98603_Desc = {
    Text = "All'inizio della battaglia, guadagna Amplificazione del Danno +[Arg1]%. Dopo aver subito Danni Attivi o Danni da tentacolo, guadagna [Arg2] Contrattacco, fino a 3 volte per turno."
  },
  State_98604_Desc = {
    Text = "All'inizio della battaglia, guadagna Amplificazione del Danno +[Arg1]%. Dopo aver subito Danni Attivi o Danni da tentacolo, guadagna [Arg2] Contrattacco, fino a 3 volte per turno."
  },
  State_98606_Desc = {
    Text = "Ogni volta che una carta entra nello Spazio Ultra, pesca [Arg1] Carte di comando appartenenti al proprietario di questa carta dal Mazzo di Pesca. Se non è possibile pescare, ottieni una quantità equivalente di Arithmetica. Questo effetto può attivarsi al massimo 2 volte per turno."
  },
  State_98607_Desc = {
    Text = "La prima attivazione di \"Posse\" ogni turno innesca tutti gli Attacchi del tentacolo [Arg1] volte contro i nemici, infliggendo il 50% di Danno."
  },
  State_98608_Desc = {
    Text = "All'inizio della Battaglia, ottieni [Arg1]% di Amplificazione del Danno. Per ogni diversa Carta di comando di un Risvegliatore giocata, ottieni un ulteriore 15/30% di Amplificazione del Danno Temporanea."
  },
  State_98610_Desc = {
    Text = "Dopo aver usato il Risveglio Keyflare, le 2/4 carte con l'Arithmetica più alta In Mano ottengono Conserva e Preparazione prima di essere giocate successivamente, e ottengono 100/200 Keyflare."
  },
  State_98611_Desc = {
    Text = "All'inizio della Battaglia, Padronanza del Reame +[Arg1]. All'inizio dei turni dispari, pesca 1 carta. All'inizio dei turni pari, ottieni 1 Arithmetica."
  },
  State_98612_Desc = {
    Text = "Il primo \"Posse\" di ogni turno conferisce Amplificazione del Danno Temporanea +[Arg1]%, con effetti più potenti a PV più bassi."
  },
  State_98613_Desc = {
    Text = "All'inizio della Battaglia, ottieni [Arg1]% di Amplificazione del Danno. Per ogni diversa Carta di comando di un Risvegliatore giocata, ottieni un ulteriore 15/30% di Amplificazione del Danno Temporanea."
  },
  State_98614_Desc = {
    Text = "Ogni 5 utilizzi di \"Esaltazione\", le successive [Arg1] Carte Comando Non-Derivate si attivano 1 volta aggiuntiva."
  },
  State_98615_Desc = {
    Text = "Il primo \"Posse\" di ogni turno rimborsa il [Arg1]% del Keyflare consumato."
  },
  State_98616_Desc = {
    Text = "Gli effetti base di tutti i Risvegliatori per la Guarigione dei PV e lo Scudo del Personaggio sono aumentati del [Arg1]%."
  },
  State_98617_Desc = {
    Text = "Dopo aver inflitto Danno attivo o danno da Tentacolo, aumenta il danno da Tentacolo subito dal bersaglio del [Arg1]% per il resto del turno. Può attivarsi fino a 20 volte per turno."
  },
  State_98619_Desc = {
    Text = "Alla fine del round, se il Keyflare è al massimo, consuma [Arg1] Keyflare per aggiungere un \"Bagliore della Chiave d'Argento\" alla tua mano."
  },
  State_98621_Desc = {
    Text = "Alla fine del round, se il Keyflare è al massimo, consuma [Arg1] Keyflare per aggiungere un'\"Aurora della Chiave d'Argento\" alla tua mano."
  },
  State_98623_Desc = {
    Text = "All'inizio del turno, tutti i Risvegliati il cui Aliemus è insufficiente per scatenare l'Esaltazione ottengono [Arg1] Aliemus."
  },
  State_98624_Desc = {
    Text = "All'inizio della Battaglia e dopo aver attivato la Resistenza alla Morte, ottieni [Arg1] Keyflare."
  },
  State_98625_Desc = {
    Text = "All'inizio della battaglia, applica [Arg1] Debolezza e Vulnerabile a tutti i nemici. Questo effetto viene attivato anche dopo \"Annientamento\", ma ha un tempo di ricarica di 3 turni."
  },
  State_98626_Desc = {
    Text = "Il primo \"Posse\" di ogni turno conferisce Amplificazione del Danno Temporanea +[Arg1]%, con effetti più potenti a PV più bassi."
  },
  State_98627_Desc = {
    Text = "L'Esaltazione ottiene [Arg1] Keyflare, con un massimo di 3 attivazioni per turno."
  },
  State_98628_Desc = {
    Text = "La prima attivazione di \"Posse\" ogni turno innesca tutti gli Attacchi del tentacolo [Arg1] volte contro i nemici, infliggendo il 50% di Danno."
  },
  State_98629_Desc = {
    Text = "Dopo aver rilasciato il secondo \"Posse\" di ogni turno, ottieni [Arg1] Keyflare e tutti i Risvegliatori ottengono [Arg2] Aliemus."
  },
  State_98630_Desc = {
    Text = "All'inizio della Battaglia e dopo aver attivato la Resistenza alla Morte, ottieni [Arg1] Keyflare."
  },
  State_98632_Desc = {
    Text = "All'inizio della Battaglia, ottieni [Arg1]% di Amplificazione del Danno. Quando ottieni un Contatore per la prima volta ogni turno, ottieni 1/2 Arithmetica."
  },
  State_98686_Desc = {
    Text = "Le successive [Layer] Carte Comando Non-Derivate si attivano 1 volta aggiuntiva."
  },
  State_98686_Name = {
    Text = "Doppia Impugnatura Carta Comando Non-Derivata"
  },
  State_98739_Desc = {
    Text = "Quando l'Intenzione viene convertita in Spirale Incolore, aumenta il numero di istanze di Danno di un valore pari agli accumuli dello Stato, e cancella lo Stato al termine del turno. Una volta raggiunti 3 accumuli, converte immediatamente l'Intenzione in Spirale Incolore."
  },
  State_98739_Name = {
    Text = "Bacio della Regina Ragno"
  },
  State_98742_Desc = {
    Text = "Applica il 100% in più di Veleno. Ottieni <Block:[Block:DescArg1]> Scudo del Personaggio alla fine di ogni turno."
  },
  State_98742_Name = {
    Text = "Sentiero degli Smarriti"
  },
  State_98743_Desc = {
    Text = "Dopo aver subito [DescArg1] DAN in un turno, ottiene 75 accumuli di Fortezza Temporanea, converte l'Intenzione in \"Elemosina Impaziente\", rimuove l'effetto Pietrificazione e ottiene 1 accumulo di \"Bacio della Regina Ragno\"."
  },
  State_98743_Name = {
    Text = "L'Usurpatore"
  },
  State_98752_Desc = {
    Text = "Dà fuoco alla carta, infliggendo il 5% dei PV massimi come danno quando viene giocata, e se è ancora In Mano alla fine del turno, verrà esaurita."
  },
  State_98752_Name = {
    Text = "<BurningKeywords2:Bruciatura>"
  },
  State_98752_WeaponDesc = {
    Text = "Ogni accumulo di Stagnazione aumenta di 1 il Costo di Arithmetica delle carte."
  },
  State_98887_Name = {
    Text = "Lampada della Salvezza"
  },
  State_98889_Desc = {
    Text = "Quando una Carta di comando con <DepleteIconKeywords:Consumo> viene giocata per la prima volta ogni turno, metti questa carta nella Pila degli scarti."
  },
  State_98889_Name = {
    Text = "Lampada della Salvezza"
  },
  State_98912_Desc = {
    Text = "Ogni accumulo riduce il Danno Finale inflitto da tutti i Risvegliati del 10%."
  },
  State_98912_Name = {
    Text = "<LostWay:Smarrito>"
  },
  State_98913_Desc = {
    Text = "Ogni accumulo riduce il Danno Finale inflitto da tutti i Risvegliati del 10%."
  },
  State_98913_Name = {Text = "Smarrito"},
  State_99007_Desc = {
    Text = "Dopo essere stata giocata, questa carta viene rimossa dal mazzo anziché entrare nella Pila degli scarti."
  },
  State_99007_Name = {
    Text = "<DepleteIconKeywords:Consumo>"
  },
  State_99007_WeaponDesc = {
    Text = "Dopo essere stata giocata, la carta non finirà nella Pila degli scarti e non potrà essere usata di nuovo in questa Battaglia."
  },
  State_99053_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Pesca [StateArg1] carte quando altri alleati usano \"Esaltazione\" per la prima volta in ogni turno."
  },
  State_99053_Name = {
    Text = "Pennello Assetato"
  },
  State_99055_Desc = {
    Text = "<PVPWeaponKeywords:Ruota del destino>: Dopo l'\"Esaltazione\", posiziona casualmente [StateArg1] \"Abilità\" appartenente al portatore nella mano e riduci il suo Costo di Arithmetica a 0."
  },
  State_99055_Name = {
    Text = "Paradosso del Realismo"
  },
  State_99056_Desc = {
    Text = "Unico per Squadra: Dopo aver scatenato un Posse, il Tasso di Crit. del Portatore aumenta temporaneamente del <WeaponEffect_Num:[StateArg1]%>."
  },
  State_99056_WeaponDesc = {
    Text = "Scatena il Posse, aumenta temporaneamente il Tasso di Crit. del Portatore del <WeaponEffect_Num:[StateArg1]%>."
  },
  State_99134_Desc = {
    Text = "La tintura utilizzata dal \"Pittore\". Potenzia gli effetti delle abilità. Accumulabile fino a 10."
  },
  State_99134_Name = {
    Text = "Tintura Fantasmatica"
  },
  State_99237_Name = {
    Text = "Stato oggetto Ascensione"
  },
  State_99237_WeaponDesc = {
    Text = "DAN Base del portatore +10%. Se l'Amplificazione del Danno del portatore supera il 20%, il DAN Base ulteriormente +10%."
  },
  State_99238_Name = {
    Text = "Stato oggetto Humus"
  },
  State_99238_WeaponDesc = {
    Text = "DAN Base del portatore +10%. Se l'Amplificazione del Danno del portatore supera il 20%, il DAN Base ulteriormente +10%."
  },
  State_99239_Name = {
    Text = "Stato oggetto Stige"
  },
  State_99239_WeaponDesc = {
    Text = "DAN Base del portatore +10%. Se l'Amplificazione del Danno del portatore supera il 20%, il DAN Base ulteriormente +10%."
  },
  State_99258_Desc = {
    Text = "Unico per Squadra: Dopo aver rilasciato il 2° Posse in ogni turno, c'è una probabilità del <WeaponEffect_Num:[StateArg1]%> di pescare 1 Carta di comando del Portatore. Dopo aver giocato la 3ª Carta di comando del Portatore in ogni turno, ottieni <WeaponEffect_Num:[StateArg2]> Keyflare."
  },
  State_99258_WeaponDesc = {
    Text = "Dopo aver rilasciato il 2° Posse per turno, c'è una probabilità del <WeaponEffect_Num:[StateArg1]%> di pescare 1 Carta di comando del Portatore. Dopo aver giocato la 3ª Carta di comando del Portatore per turno, ottieni <WeaponEffect_Num:[StateArg2]> Keyflare."
  },
  State_99294_Desc = {
    Text = "L'Aliemus generato da tutti i Risvegliatori è aumentato del [DescArg1]%. Arithmetica e le Carte di comando a fine turno possono essere conservate fino al turno successivo. I Capitoli Risplendenti generano più Aliemus."
  },
  State_99294_Name = {Text = "\"Gioia\""},
  State_99295_Desc = {
    Text = "L'Aliemus generato da tutti i Risvegliati è aumentato del [StateArg1]%. L'Arithmetica e le Carte di comando alla fine del turno possono essere conservate fino al turno successivo. I Capitoli Risplendenti generano più Aliemus."
  },
  State_99295_Name = {Text = "\"Gioia\""},
  State_99336_Desc = {
    Text = "La tintura utilizzata dal \"Pittore\". Potenzia gli effetti delle abilità. Accumulabile fino a 10."
  },
  State_99336_Name = {
    Text = "<DecayDye:Tintura del Miraggio>"
  },
  State_99533_Name = {
    Text = "Accessorio: Crisalide della Fanciulla"
  },
  State_99533_WeaponDesc = {
    Text = "All'inizio della battaglia, se il portatore appartiene al Reame del Caos, ATT +25%."
  },
  State_99534_Name = {
    Text = "Lumaca Dolce"
  },
  State_99534_WeaponDesc = {
    Text = "La Generazione di Scudo e il Recupero PV causati dal portatore sono aumentati del 6%. Se la Padronanza del Reame del portatore è superiore a 50, la Generazione di Scudo e il Recupero PV sono ulteriormente aumentati del 6%."
  },
  State_99640_Desc = {
    Text = "Se Pickman ha attualmente 10 cariche di Creatività, consuma tutta la Creatività dopo che usa Esaltazione. Tutti i Risvegliati ottengono 15 Aliemus. Ottieni 1 carica di \"Rapsodia\". Pickman può accumulare fino a 10 cariche di Creatività. Possono essere trasferite alla battaglia successiva."
  },
  State_99640_Name = {
    Text = "Creatività"
  },
  State_99723_Desc = {
    Text = "Unico per Squadra: Aliemus e Generazione di FOR del portatore +<WeaponEffect_Num:[StateArg1]%>. Dopo aver scatenato Esaltazione, il Danno Finale, lo Scudo e la Guarigione delle Esaltazioni degli altri Risvegliati in questo turno +<WeaponEffect_Num:[StateArg2]%>. Se questa Esaltazione ha attivato \"Divorare\", il portatore ottiene <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_99723_WeaponDesc = {
    Text = "L'Aliemus e la Forza generati dal Portatore sono aumentati del <WeaponEffect_Num:[StateArg1]%>. Dopo aver scatenato un'Esaltazione, il Danno Finale, lo Scudo e la Guarigione delle Esaltazioni degli altri Risvegliati in questo turno +<WeaponEffect_Num:[StateArg2]%>. Se questa Esaltazione ha attivato \"Divorare\", il Portatore ottiene <WeaponEffect_Num:[StateArg3]> Aliemus."
  }
})
return Text_State
