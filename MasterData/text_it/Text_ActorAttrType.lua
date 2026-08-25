__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ActorAttrType = readonly({
  ActorAttrType_121209_AttributeDesc = {
    Text = "Il Livello di Sapere Proibito (SP) inizia pari al Livello del Custode (LC) e determina la potenza di tutti e tre i livelli di ricerca. Viene sovrascritto e impostato sul livello medio dei Risvegliatori e del Livello del Custode se tale media è superiore al LC.\nRicerca Somatica: <Blue:{s1}>\nDetermina quanta Vita di Squadra si ottiene per ogni 100 punti della statistica COS del Risvegliatore.\nRicerca Esoterica: <Blue:{s2}>\nDetermina la potenza degli effetti di Generazione FOR, Danni da tentacolo, Scudo, Recupero PV e Riduzione FOR causati da Reliquie, Orazioni e Posse.\nRicerca Occulta: <Blue:{s3}>\nDetermina la potenza degli effetti di Veleno Fisso, Contrattacco Fisso, Danno Fisso e Sanguinamento Fisso di Reliquie, Orazioni e Posse.\n"
  },
  ActorAttrType_121209_Text = {
    Text = "Sapere Proibito"
  },
  ActorAttrType_18103_Text = {Text = "Scudo"},
  ActorAttrType_18104_Text = {
    Text = "Regolazione % Danno da Colpo"
  },
  ActorAttrType_18105_AttributeUpText = {
    Text = "Danno critico +{s1}"
  },
  ActorAttrType_18105_Text = {
    Text = "Danno critico"
  },
  ActorAttrType_18106_Text = {
    Text = "Aumento Scudo"
  },
  ActorAttrType_18107_AttributeUpText = {Text = "ATT+{s1}"},
  ActorAttrType_18107_Text = {Text = "ATT"},
  ActorAttrType_18108_Text = {Text = "COS"},
  ActorAttrType_18109_Text = {
    Text = "Regolazione % Danno da Carta"
  },
  ActorAttrType_18110_Text = {
    Text = "Regolazione % Fragile"
  },
  ActorAttrType_18111_Text = {
    Text = "Regolazione % Scudo Ricevuto"
  },
  ActorAttrType_18112_AttributeUpText = {
    Text = "Difesa +{s1}"
  },
  ActorAttrType_18112_Text = {Text = "Difesa+"},
  ActorAttrType_18113_AttributeDesc = {
    Text = "Rigenerazione Aliemus del Risvegliatore"
  },
  ActorAttrType_18113_Text = {
    Text = "Aliemus Iniziale"
  },
  ActorAttrType_18114_AttributeDesc = {
    Text = "Più alta è la COS, maggiore sarà la Salute massima del Risvegliatore.\nPiù alto è il Livello del Custode, più forte sarà l'effetto della COS sulla Salute massima del Risvegliatore."
  },
  ActorAttrType_18114_AttributeUpText = {Text = "COS+{s1}"},
  ActorAttrType_18114_Text = {Text = "COS"},
  ActorAttrType_18115_AttributeDesc = {
    Text = "Aliemus rimborsato dopo l'Esaltazione"
  },
  ActorAttrType_18115_AttributeUpText = {
    Text = "Costo Aliemus-{s1}"
  },
  ActorAttrType_18115_Text = {
    Text = "Costo Aliemus-"
  },
  ActorAttrType_18116_AttributeDesc = {
    Text = "Più alta è la COS, maggiore sarà la Salute massima del Risvegliatore.\nPiù alto è il Livello del Custode, più forte sarà l'effetto della COS sulla Salute massima del Risvegliatore."
  },
  ActorAttrType_18116_AttributeUpText = {Text = "COS+{s1}"},
  ActorAttrType_18116_Text = {Text = "COS+"},
  ActorAttrType_18117_Text = {
    Text = "Danni da tentacolo"
  },
  ActorAttrType_18118_Text = {Text = "Slot Ultra"},
  ActorAttrType_18119_Text = {
    Text = "Regolazione % Danno Subito"
  },
  ActorAttrType_18120_AttributeDesc = {
    Text = "Il Limite Massimo di Aliemus del Risvegliatore e il Costo in Aliemus dell'Esaltazione sono entrambi pari al suo Aliemus Base."
  },
  ActorAttrType_18120_AttributeUpText = {
    Text = "Limite Aliemus +{s1}"
  },
  ActorAttrType_18120_Text = {
    Text = "Aliemus Base"
  },
  ActorAttrType_18121_AttributeDesc = {
    Text = "Livello Abilità 2"
  },
  ActorAttrType_18121_AttributeUpText = {
    Text = "Livello Abilità 2 +{s1}"
  },
  ActorAttrType_18121_Text = {
    Text = "Livello Abilità 2"
  },
  ActorAttrType_18122_AttributeDesc = {
    Text = "Livello Difesa"
  },
  ActorAttrType_18122_AttributeUpText = {
    Text = "Livello Difesa +{s1}"
  },
  ActorAttrType_18122_Text = {
    Text = "Livello Difesa"
  },
  ActorAttrType_18123_Text = {
    Text = "Modifica numero colpi"
  },
  ActorAttrType_18124_Text = {
    Text = "Modifica quantità Scudo"
  },
  ActorAttrType_18125_Text = {
    Text = "Regolazione Num. Scudo Ricevuto"
  },
  ActorAttrType_18126_AttributeDesc = {
    Text = "La Padronanza del Reame della squadra è pari alla somma della Padronanza del Reame dei Risvegliatori presenti. La Padronanza del Reame può potenziare gli effetti del Dono della squadra. Se la squadra attuale è \"Puro Aequor/Puro Caro/Puro Ultra\", gli effetti della Padronanza del Reame sono raddoppiati.\nPer una squadra nel Reame del <Blue:Caos>, per ogni punto di Padronanza del Reame, quando si rilascia una Posse, tutti i Risvegliatori ottengono <Blue:0,05> Aliemus aggiuntivi.\nPer una squadra nel Reame di <Blue:Aequor>, per ogni punto di Padronanza del Reame, dopo aver rilasciato un'Esaltazione, c'è una probabilità dello <Blue:0,25%> di ottenere un accumulo aggiuntivo di Raccolta Tentacoli (se la probabilità supera il 100%, è possibile ottenere più accumuli). Quando si passa a \"Mare Calmo\", lo Scudo ottenuto aumenta dello <Blue:0,01%> della Salute massima, e gli Attacchi del tentacolo attivati dal Danno attivo in \"Onde Impetuose\" aumentano i Danni da tentacolo dello <Blue:0,02%>.\nPer una squadra nel Reame di <Blue:Caro>, per ogni punto di Padronanza del Reame, la prima volta che si attiva Divorare in ogni round, si ottiene uno Scudo pari allo <Blue:0,01%> della Salute massima e lo <Blue:0,005%> di FOR temporanea (aumenta con i Vita persi, fino al 100%).\nPer una squadra nel Reame <Blue:Ultra>, per ogni punto di Padronanza del Reame, all'inizio del turno, c'è una probabilità dello <Blue:0,125%> di ottenere 1 \"Intuizione\" (se la probabilità supera il 100%, è possibile ottenerne più di una)."
  },
  ActorAttrType_18126_AttributeUpText = {
    Text = "Padronanza del Reame +{s1}"
  },
  ActorAttrType_18126_Text = {
    Text = "Padronanza del Reame"
  },
  ActorAttrType_18127_Text = {Text = "Vita"},
  ActorAttrType_18128_AttributeUpText = {Text = "ATT+{s1}"},
  ActorAttrType_18128_Text = {Text = "ATT+"},
  ActorAttrType_18129_AttributeDesc = {
    Text = "Più alto è il Bonus Danno Base, più Danno infligge il Risvegliatore"
  },
  ActorAttrType_18129_AttributeUpText = {
    Text = "Danno base +{s1}"
  },
  ActorAttrType_18129_Text = {Text = "Danno base"},
  ActorAttrType_18130_Text = {
    Text = "EXP Custode"
  },
  ActorAttrType_18131_AttributeDesc = {
    Text = "Quantità di Aliemus recuperata automaticamente alla fine dei turni"
  },
  ActorAttrType_18131_AttributeUpText = {
    Text = "Recupero Automatico Aliemus +{s1}"
  },
  ActorAttrType_18131_Text = {
    Text = "Recupero Automatico Aliemus"
  },
  ActorAttrType_18132_Text = {
    Text = "Livello di Illuminazione"
  },
  ActorAttrType_18133_Text = {
    Text = "Regolazione % Aliemus Ricevuto"
  },
  ActorAttrType_18134_Text = {
    Text = "Limite Fusione Embrionale"
  },
  ActorAttrType_18135_Text = {
    Text = "Aliemus attuale"
  },
  ActorAttrType_18136_Text = {
    Text = "Regolazione Num. Danno Subito"
  },
  ActorAttrType_18137_AttributeDesc = {
    Text = "Aumenta in percentuale lo Scudo generato e i Vita recuperati dai Risvegliatori"
  },
  ActorAttrType_18137_AttributeUpText = {
    Text = "Amp. Scudo e Guarigione +{s1}"
  },
  ActorAttrType_18137_Text = {
    Text = "Amp. Scudo e Guarigione"
  },
  ActorAttrType_18138_Text = {
    Text = "Aumento Guarigione"
  },
  ActorAttrType_18139_AttributeDesc = {
    Text = "Quando giochi una Carta di comando o attivi il Risveglio, ottieni {s1} punti di Energia-S per ogni punto di Arithmetica consumato. All'aumentare di questo attributo, il bonus aggiuntivo di Energia-S diminuirà gradualmente."
  },
  ActorAttrType_18139_AttributeUpText = {
    Text = "Ricarica Keyflare +{s1}"
  },
  ActorAttrType_18139_Text = {
    Text = "Livello di Ricarica della chiave d'argento"
  },
  ActorAttrType_18140_Text = {
    Text = "Conteggio Res. alla Morte"
  },
  ActorAttrType_18141_AttributeDesc = {
    Text = "Livello Attacco"
  },
  ActorAttrType_18141_AttributeUpText = {
    Text = "Livello Attacco +{s1}"
  },
  ActorAttrType_18141_Text = {
    Text = "Livello Attacco"
  },
  ActorAttrType_18142_AttributeDesc = {
    Text = "Aumenta in percentuale il \"Danno base\" di tutti i Risvegliatori, gli accumuli di \"Veleno a valore fisso\" e \"Contrattacco a valore fisso\", e i Danni da tentacolo iniziali."
  },
  ActorAttrType_18142_AttributeUpText = {
    Text = "Amplificazione del Danno +{s1}"
  },
  ActorAttrType_18142_Text = {
    Text = "Amplificazione del Danno"
  },
  ActorAttrType_18143_Text = {
    Text = "Regolazione % Danno da Esaltazione"
  },
  ActorAttrType_18144_AttributeDesc = {
    Text = "Probabilità di resistere a un Colpo Critico in arrivo quando si viene attaccati dai Risvegliatori"
  },
  ActorAttrType_18144_AttributeUpText = {
    Text = "Res. Critica +{s1}"
  },
  ActorAttrType_18144_Text = {
    Text = "Res. Critica"
  },
  ActorAttrType_18145_AttributeDesc = {
    Text = "Livello Esaltazione"
  },
  ActorAttrType_18145_AttributeUpText = {
    Text = "Liv. Esaltazione +{s1}"
  },
  ActorAttrType_18145_Text = {
    Text = "Livello Esaltazione"
  },
  ActorAttrType_18146_Text = {
    Text = "Regolazione Num. Guarigione Ricevuta"
  },
  ActorAttrType_18147_AttributeUpText = {
    Text = "Tasso di Orison Fortunato +{s1}"
  },
  ActorAttrType_18147_Text = {
    Text = "Tasso di Orazione fortunata"
  },
  ActorAttrType_18148_Text = {
    Text = "Modifica quantità Guarigione"
  },
  ActorAttrType_18149_Text = {Text = "COS+"},
  ActorAttrType_18150_Text = {
    Text = "Regolazione % Sintomo: Debolezza"
  },
  ActorAttrType_18151_AttributeDesc = {
    Text = "La Resistenza della squadra è pari alla somma della Resistenza di tutti i Risvegliatori presenti. Quando si subisce un colpo fatale in battaglia, c'è una probabilità di attivare la Resistenza e conservare 1 punto di Vita. Dopo l'attivazione, si ottengono 2 Arithmetica aggiuntive e si pescano 2 carte nel turno successivo. La percentuale di Resistenza attuale e successiva viene dimezzata fino al termine dell'Operazione."
  },
  ActorAttrType_18151_AttributeUpText = {
    Text = "Resistenza +{s1}"
  },
  ActorAttrType_18151_Text = {Text = "Resistenza"},
  ActorAttrType_18152_Text = {
    Text = "Regolazione % Aliemus"
  },
  ActorAttrType_18154_Text = {
    Text = "Limite Tentacoli"
  },
  ActorAttrType_18155_AttributeDesc = {
    Text = "Aumenta in percentuale le ricompense de Il sigillo nero"
  },
  ActorAttrType_18155_AttributeUpText = {
    Text = "Bottino di Sigilli +{s1}"
  },
  ActorAttrType_18155_Text = {
    Text = "Bottino di Sigilli"
  },
  ActorAttrType_18156_Text = {
    Text = "Regolazione Num. Aliemus Ricevuto"
  },
  ActorAttrType_18157_Text = {
    Text = "Intenzioni Nascoste"
  },
  ActorAttrType_18158_Text = {
    Text = "Modifica quantità Danno"
  },
  ActorAttrType_18159_AttributeUpText = {
    Text = "Tasso critico +{s1}"
  },
  ActorAttrType_18159_Text = {
    Text = "Tasso di Crit."
  },
  ActorAttrType_18160_AttributeDesc = {
    Text = "Livello Abilità 1"
  },
  ActorAttrType_18160_AttributeUpText = {
    Text = "Livello Abilità 1 +{s1}"
  },
  ActorAttrType_18160_Text = {
    Text = "Livello Abilità 1"
  },
  ActorAttrType_18161_Text = {
    Text = "EXP Custode"
  },
  ActorAttrType_18162_Text = {
    Text = "Aumento Danno"
  },
  ActorAttrType_18163_Text = {
    Text = "Numero di Tentacoli"
  },
  ActorAttrType_18164_Text = {
    Text = "Regolazione % Guarigione Ricevuta"
  },
  ActorAttrType_18165_Text = {
    Text = "Arithmetica massima"
  },
  ActorAttrType_18166_Text = {
    Text = "Regolazione % Vulnerabile"
  },
  ActorAttrType_18167_AttributeUpText = {
    Text = "Difesa +{s1}"
  },
  ActorAttrType_18167_Text = {Text = "Difesa"},
  ActorAttrType_18168_AttributeDesc = {
    Text = "Livello Risveglio"
  },
  ActorAttrType_18168_AttributeUpText = {
    Text = "Livello di Risveglio +{s1}"
  },
  ActorAttrType_18168_Text = {
    Text = "Livello Risveglio"
  },
  ActorAttrType_21322_Text = {
    Text = "Ricarica della chiave d'argento"
  },
  ActorAttrType_22207_AttributeDesc = {
    Text = "Rigenera {s1} Aliemus dopo ogni Esaltazione. Il bonus extra di rigenerazione Aliemus si riduce man mano che questo Attributo cresce."
  },
  ActorAttrType_22207_AttributeUpText = {
    Text = "Livello rigenerazione Aliemus +{s1}"
  },
  ActorAttrType_22207_Text = {
    Text = "Livello rigenerazione Aliemus"
  },
  ActorAttrType_22214_Text = {
    Text = "Rigenerazione Aliemus"
  }
})
return Text_ActorAttrType
