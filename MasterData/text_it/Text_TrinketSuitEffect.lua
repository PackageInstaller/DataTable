__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TrinketSuitEffect = readonly({
  TrinketSuitEffect_18335_Name = {
    Text = "Tributo d'Aprile"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_1 = {
    Text = "Danno Crit. +7.2%"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Unico per Squadra>: A inizio turno, se gli HP totali dei nemici sono superiori al 75%, il Tasso critico temporaneo e il Danno Crit. del Portatore aumentano del 35%."
  },
  TrinketSuitEffect_18336_Name = {
    Text = "Poema Circolare (Incompiuto)"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_1 = {
    Text = "Resistenza alla Morte +16.8%"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_2 = {
    Text = "All'inizio dei turni pari, riduci di 1 il Costo di Arithmetica di una Carta casuale In Mano."
  },
  TrinketSuitEffect_18337_Name = {
    Text = "Linea di ritorno"
  },
  TrinketSuitEffect_18337_SuitEffectDesc_1 = {
    Text = "Padronanza del Reame +12"
  },
  TrinketSuitEffect_18337_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Unico per Squadra>: All'inizio della battaglia successiva, ottieni FOR pari al 12% dell'ATT del portatore. Se il Reame attuale è Aequor, l'effetto cambia in \"A inizio turno, c'è una probabilità del (50 + 0,25 * Padronanza del Reame della squadra)% di ottenere 1 accumulo di Raduno dei tentacoli. È possibile ottenere più accumuli se la probabilità supera il 100%, e la probabilità raddoppia nelle Battaglia Boss.\""
  },
  TrinketSuitEffect_18338_Name = {
    Text = "Coniglio Maledetto"
  },
  TrinketSuitEffect_18338_SuitEffectDesc_1 = {
    Text = "Padronanza del Reame +12"
  },
  TrinketSuitEffect_18338_SuitEffectDesc_2 = {
    Text = "Lo Scudo e il Recupero PV del Portatore aumentano del 12%."
  },
  TrinketSuitEffect_18339_Name = {Text = "Paradosso"},
  TrinketSuitEffect_18339_SuitEffectDesc_1 = {
    Text = "Livello di Ricarica della Chiave d'Argento +7.2"
  },
  TrinketSuitEffect_18339_SuitEffectDesc_2 = {
    Text = "<TeamUnique:Unico per Squadra>: Aumenta l'Aliemus Base del Portatore di 20. Aumenta il Tasso Crit., il Danno Crit., lo Scudo del Personaggio e il Recupero PV delle Carte di comando del Portatore del 20%."
  },
  TrinketSuitEffect_18340_Name = {
    Text = "Forma Organica"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_1 = {
    Text = "Bottino di Sigilli +3.6%"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Unico per Squadra>. All'inizio dell'esplorazione, riduci fino al 100% la Resistenza alla Morte. Per ogni 1% ridotto, aumenta l'Aliemus del Portatore dello 0,15%."
  },
  TrinketSuitEffect_18341_Name = {
    Text = "Pulsazione Cremisi"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_1 = {
    Text = "Danno Crit. +7.2%"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_2 = {
    Text = "Dopo aver rilasciato Posse, il Portatore ottiene il 30% di Tasso critico temporaneo."
  },
  TrinketSuitEffect_18342_Name = {
    Text = "Patto Standard SSR"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_1 = {
    Text = "Resistenza alla Morte +16.8%"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_2 = {
    Text = "Danno, Guarigione e Scudo generati dal Portatore aumentano del 15%."
  },
  TrinketSuitEffect_18343_Name = {
    Text = "Patto Standard R"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_1 = {
    Text = "Resistenza alla Morte +16.8%"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_2 = {
    Text = "Danno, Guarigione e Scudo generati dal Portatore aumentano del 15%."
  },
  TrinketSuitEffect_18344_Name = {
    Text = "Deus Ex Machina"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_1 = {
    Text = "Padronanza del Reame +12"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_2 = {
    Text = "Ottieni 1 Arithmetica al primo turno di ogni battaglia e ottieni 1 Arithmetica aggiuntiva ogni 4 turni durante le Battaglie Boss."
  },
  TrinketSuitEffect_18345_Name = {
    Text = "Rito di Fotosintesi"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_1 = {
    Text = "Amplificazione del Danno +7,2%"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Unicità di Squadra>: Dopo che la Carta di comando del portatore entra nell'Ultra Spazio, conferisce Fusione Embrionale +25~50. Più è bassa la Vita attuale, maggiore è la Fusione Embrionale ottenuta."
  },
  TrinketSuitEffect_18346_Name = {
    Text = "Ri-evoluzione"
  },
  TrinketSuitEffect_18346_SuitEffectDesc_1 = {
    Text = "Livello Ricarica Aliemus +2.4"
  },
  TrinketSuitEffect_18346_SuitEffectDesc_2 = {
    Text = "<TeamUnique:Unico per Squadra>: Ottieni 35 Aliemus all'inizio dell'esplorazione. Dopo aver usato Esaltazione in questa battaglia, ottieni 2 Aliemus alla fine del turno. Questo effetto è cumulabile fino a 3 volte."
  },
  TrinketSuitEffect_18347_Name = {
    Text = "Drenaggio Vitale"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_1 = {
    Text = "Livello di Ricarica della Chiave d'Argento +7.2"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Unicità di Squadra>: Alla fine del turno, ottieni Keyflare pari al 200% della Ricarica della chiave d'argento del portatore. Se il Reame attuale è \"Caro\", l'Effetto cambia in: ogni 5 punti di Ricarica della chiave d'argento, Fusione Embrionale +1."
  },
  TrinketSuitEffect_18348_Name = {
    Text = "Sogno di Medicina"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_1 = {
    Text = "Amplificazione del Danno +4,8%"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_2 = {
    Text = "<TeamUnique:Unico per Squadra>: Perde 8 Sigilli Neri al termine della Battaglia. All'Inizio della Battaglia, mischia una copia originale di ciascuna delle Carte di comando Innate del Portatore (eccetto Colpo e Difesa) nel Mazzo di Pesca."
  },
  TrinketSuitEffect_18349_Name = {
    Text = "Lumaca Dolce"
  },
  TrinketSuitEffect_18349_SuitEffectDesc_1 = {
    Text = "Resistenza alla Morte +25,2%"
  },
  TrinketSuitEffect_18349_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Unicità di Squadra>: se nello stesso turno vengono eseguiti sia \"Annientamento\" che un cambio di Postura del Tentacolo, lo Scudo, la Guarigione della Vita e il Danno Finale inflitti dal portatore in quel turno aumentano del +25%. Cooldown di 3 turni."
  },
  TrinketSuitEffect_18350_Name = {
    Text = "Gatto del Teatro (Incompiuto)"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_1 = {
    Text = "Resistenza alla Morte +16.8%"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_2 = {
    Text = "Gli attacchi del Portatore infliggono automaticamente un colpo critico ai nemici con più del 75% di PV."
  },
  TrinketSuitEffect_18351_Name = {
    Text = "Anello della Camera 36"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_1 = {
    Text = "Livello Ricarica Aliemus +2.4"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Unico per Squadra>. Limite Keyflare e costo Keyflare del Posse +200. Tasso Crit. da Esaltazione, Danno Crit., Scudo del Personaggio e Recupero PV +30%."
  },
  TrinketSuitEffect_18352_Name = {
    Text = "Gemelli Distorti: Bianco"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_1 = {
    Text = "Resistenza alla Morte +16.8%"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_2 = {
    Text = "Inizio dei turni pari: Aggiungi alla tua mano la \"Difesa\" del Portatore con <NothingnessIconKeywords:Fugace> e <DepleteIconKeywords:Consumo>."
  },
  TrinketSuitEffect_18353_Name = {
    Text = "Abbraccio Scarlatto"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_1 = {
    Text = "Tasso di Crit. +4.8%"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_2 = {
    Text = "Il Portatore ottiene 35 Keyflare quando infligge Danno, o 70 Keyflare per Danno Crit. Questo Effetto può attivarsi fino a 3 volte per turno."
  },
  TrinketSuitEffect_18354_Name = {
    Text = "Patto Standard SR"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_1 = {
    Text = "Resistenza alla Morte +16.8%"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_2 = {
    Text = "Danno, Guarigione e Scudo generati dal Portatore aumentano del 15%."
  },
  TrinketSuitEffect_18355_Name = {
    Text = "Cronaca Immacolata"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_1 = {
    Text = "Livello di Ricarica della Chiave d'Argento +7.2"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Unico per Squadra>: Dopo aver usato Posse, recupera HP pari al 12% della COS del Portatore, aumentando in base alla percentuale di HP persi, fino al 24% della COS del Portatore."
  },
  TrinketSuitEffect_18356_Name = {
    Text = "Steppenwolf"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_1 = {
    Text = "Amplificazione del Danno +4,8%"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_2 = {
    Text = "Il DAN Base inflitto dal Portatore è aumentato del 20%, e il <IntoxicationIconKeywords:Veleno> e il <RetaliateIconKeywords:Contatore> da lui inflitti sono aumentati del 10%."
  },
  TrinketSuitEffect_18357_Name = {
    Text = "Banchetto da Lontano"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_1 = {
    Text = "Bottino di Sigilli +3.6%"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_2 = {
    Text = "All'inizio dell'esplorazione, ottieni 10 Sigilli Neri. La \"Difesa\" del Portatore aumenta lo Scudo del 60%."
  },
  TrinketSuitEffect_18358_Name = {
    Text = "Gemelli Distorti: Nero"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_1 = {
    Text = "Tasso di Crit. +4.8%"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_2 = {
    Text = "All'inizio dei turni dispari, aggiungi alla tua mano il \"Colpo\" del Portatore con <NothingnessIconKeywords:Fugace> e <DepleteIconKeywords:Consumo>."
  },
  TrinketSuitEffect_18359_Name = {
    Text = "Crisalide della Fanciulla"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_1 = {
    Text = "Tasso di Critico +7,2%"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Unicità di Squadra>: dopo che il portatore consuma un Embrione per la prima volta in ogni turno, ottiene l'8% di DAN CRIT temporanei per ogni Tentacolo posseduto, fino a un massimo dell'80%."
  },
  TrinketSuitEffect_18360_Name = {
    Text = "Sussurri del Sepolcreto"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_1 = {
    Text = "Resistenza alla Morte +16.8%"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_2 = {
    Text = "All'inizio del livello, la <DeathResistanceIconKeywords:Resistenza alla Morte> aumenta del 25%. Dopo aver attivato la Resistenza alla Morte, il Portatore ottiene 50 Aliemus."
  },
  TrinketSuitEffect_99234_Name = {Text = "Humus"},
  TrinketSuitEffect_99234_SuitEffectDesc_1 = {
    Text = "Statistica principale scelta casualmente tra Tasso Crit., Danno Crit., Livello di Ricarica della Chiave d'Argento o Livello Ricarica Aliemus."
  },
  TrinketSuitEffect_99234_SuitEffectDesc_2 = {
    Text = "Statistica principale scelta casualmente tra Tasso Crit., Danno Crit., Livello di Ricarica della Chiave d'Argento o Livello Ricarica Aliemus."
  },
  TrinketSuitEffect_99235_Name = {Text = "Ascensione"},
  TrinketSuitEffect_99235_SuitEffectDesc_1 = {
    Text = "Statistica principale scelta casualmente tra Tasso Crit., Danno Crit., Livello di Ricarica della Chiave d'Argento o Livello Ricarica Aliemus."
  },
  TrinketSuitEffect_99235_SuitEffectDesc_2 = {
    Text = "Statistica principale scelta casualmente tra Tasso Crit., Danno Crit., Livello di Ricarica della Chiave d'Argento o Livello Ricarica Aliemus."
  },
  TrinketSuitEffect_99236_Name = {Text = "Stige"},
  TrinketSuitEffect_99236_SuitEffectDesc_1 = {
    Text = "Statistica principale scelta casualmente tra Tasso Crit., Danno Crit., Livello di Ricarica della Chiave d'Argento o Livello Ricarica Aliemus."
  },
  TrinketSuitEffect_99236_SuitEffectDesc_2 = {
    Text = "Statistica principale scelta casualmente tra Tasso Crit., Danno Crit., Livello di Ricarica della Chiave d'Argento o Livello Ricarica Aliemus."
  }
})
return Text_TrinketSuitEffect
