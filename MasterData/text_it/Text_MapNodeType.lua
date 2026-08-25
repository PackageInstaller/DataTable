__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MapNodeType = readonly({
  MapNodeType_116420_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_116420_Name = {
    Text = "Nodo casuale"
  },
  MapNodeType_116421_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_116421_Name = {
    Text = "Battaglia casuale"
  },
  MapNodeType_116422_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_116422_Name = {
    Text = "Evento casuale"
  },
  MapNodeType_121329_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_121329_Name = {
    Text = "Illusione di Murphy"
  },
  MapNodeType_128222_Name = {
    Text = "Nodo comando"
  },
  MapNodeType_130326_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_130326_Name = {
    Text = "Teatro del Fato"
  },
  MapNodeType_149067_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_149067_Name = {
    Text = "Miraggio Celeste"
  },
  MapNodeType_18391_Desc = {
    Text = "Pericolo o opportunità, la scelta è tua."
  },
  MapNodeType_18391_Name = {Text = "Evento"},
  MapNodeType_18392_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_18392_Name = {
    Text = "Pustola Bizzarra"
  },
  MapNodeType_18393_Desc = {
    Text = "La nebbia spiritica è intangibile eppure salda, e non consente alcun passaggio."
  },
  MapNodeType_18393_Name = {Text = "Effimero"},
  MapNodeType_18394_Desc = {
    Text = "Pericolo o opportunità, la scelta è tua."
  },
  MapNodeType_18394_Name = {Text = "Evento"},
  MapNodeType_18395_Desc = {
    Text = "Un incontro, una crisi o una memoria."
  },
  MapNodeType_18395_Name = {Text = "Storia"},
  MapNodeType_18396_Desc = {
    Text = "In ultima istanza, il nemico più forte. Sconfiggilo per concludere questa Indagine."
  },
  MapNodeType_18396_Name = {
    Text = "Battaglia finale"
  },
  MapNodeType_18397_Desc = {
    Text = "Entra nel Negozio D-Marchio, dove una presenza misteriosa prenderà i tuoi Sigilli Neri e offrirà potere in cambio."
  },
  MapNodeType_18397_Name = {
    Text = "D-segno Reliquia personalizzata"
  },
  MapNodeType_18398_Desc = {
    Text = "Attiva per ricevere aiuto dall'Università di Mythag, ripristinando i PV."
  },
  MapNodeType_18398_Name = {Text = "Crocevia"},
  MapNodeType_18399_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_18399_Name = {
    Text = "Idromele al Miele"
  },
  MapNodeType_18400_Desc = {
    Text = "Le profondità della Pozza d'Ombra sono insondabili e colme di ignoto. Attivarla concede ricompense casuali."
  },
  MapNodeType_18400_Name = {
    Text = "Pozza d'Ombra"
  },
  MapNodeType_18401_Desc = {
    Text = "Pericolo o opportunità, la scelta è tua."
  },
  MapNodeType_18401_Name = {Text = "Evento"},
  MapNodeType_18402_Desc = {
    Text = "Punto di partenza del giocatore. Non dovresti vedere questo nodo. Se lo vedi, è un BUG!"
  },
  MapNodeType_18402_Name = {Text = "Inizio"},
  MapNodeType_18403_Desc = {
    Text = "Spettacolo di Luci e Ombre"
  },
  MapNodeType_18403_Name = {
    Text = "Spettacolo di Luci e Ombre"
  },
  MapNodeType_18404_Desc = {
    Text = "Ottieni Sigillo Nero, una valuta del Paesaggio Onirico."
  },
  MapNodeType_18404_Name = {
    Text = "Sigillo Nero"
  },
  MapNodeType_18405_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_18405_Name = {
    Text = "Statua Incompiuta"
  },
  MapNodeType_18406_Desc = {
    Text = "L'uscita del Passaggio Unidirezionale. È già crollata, rendendo impossibile tornare indietro."
  },
  MapNodeType_18406_Name = {
    Text = "Uscita del Passaggio Segreto"
  },
  MapNodeType_18407_Desc = {
    Text = "Ottieni Reliquia."
  },
  MapNodeType_18407_Name = {Text = "Reliquia"},
  MapNodeType_18408_Desc = {
    Text = "Un passaggio a senso unico instabile; una volta entrati, non c'è modo di tornare indietro dall'uscita."
  },
  MapNodeType_18408_Name = {
    Text = "Passaggio a Senso Unico"
  },
  MapNodeType_18409_Desc = {
    Text = "Test Sfera di Cristallo"
  },
  MapNodeType_18409_Name = {
    Text = "Test Sfera di Cristallo"
  },
  MapNodeType_18410_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_18410_Name = {
    Text = "Rito della Surrogazione"
  },
  MapNodeType_18411_Desc = {
    Text = "Alcuni nemici moderatamente impegnativi innescheranno una battaglia più ardua."
  },
  MapNodeType_18411_Name = {Text = "Élite"},
  MapNodeType_18412_Desc = {
    Text = "Entra nel Negozio D-Marchio, dove una presenza misteriosa prenderà i tuoi Sigilli Neri e offrirà potere in cambio."
  },
  MapNodeType_18412_Name = {
    Text = "D-segno Orazione personalizzata"
  },
  MapNodeType_18413_Desc = {
    Text = "Attiva per ottenere assistenza dall'Università di Mythag: Ripristina PV o Risveglia un Risvegliatore."
  },
  MapNodeType_18413_Name = {Text = "Crocevia"},
  MapNodeType_18414_Desc = {
    Text = "Entra nel Negozio D-Marchio, dove una presenza misteriosa prenderà i tuoi Sigilli Neri e offrirà potere in cambio."
  },
  MapNodeType_18414_Name = {
    Text = "D-segno Orazione"
  },
  MapNodeType_18415_Desc = {
    Text = "Ricompensa Nascosta"
  },
  MapNodeType_18415_Name = {
    Text = "Ricompensa Nascosta"
  },
  MapNodeType_18416_Desc = {
    Text = "Entra nel Negozio D-Marchio, dove una presenza misteriosa prenderà i tuoi Sigilli Neri e offrirà potere in cambio."
  },
  MapNodeType_18416_Name = {
    Text = "D-segno Reliquia"
  },
  MapNodeType_18417_Desc = {
    Text = "La strada nerissima conduce verso l'ignoto, e una volta entrati, vi trasporterà all'altra estremità del Passaggio."
  },
  MapNodeType_18417_Name = {Text = "Tunnel"},
  MapNodeType_18419_Desc = {
    Text = "Test Pavimento a Crollo Programmato a tempo"
  },
  MapNodeType_18419_Name = {
    Text = "Pavimento a Crollo Programmato"
  },
  MapNodeType_18420_Desc = {
    Text = "Verifica il Passaggio Nascosto"
  },
  MapNodeType_18420_Name = {
    Text = "Verifica il Passaggio Nascosto"
  },
  MapNodeType_18421_Desc = {
    Text = "Un antico dispositivo di illuminazione in grado di dissipare la fitta nebbia circostante."
  },
  MapNodeType_18421_Name = {Text = "Riflettore"},
  MapNodeType_18422_Desc = {
    Text = "Una porta robusta e silenziosa. Richiede una Chiave arrugginita per essere aperta."
  },
  MapNodeType_18422_Name = {
    Text = "Porta arrugginita"
  },
  MapNodeType_18423_Desc = {
    Text = "Entra nel Negozio D-Marchio, dove una presenza misteriosa prenderà i tuoi Sigilli Neri e offrirà potere in cambio."
  },
  MapNodeType_18423_Name = {Text = "D-segno"},
  MapNodeType_18424_Desc = {
    Text = "Pavimento instabile"
  },
  MapNodeType_18424_Name = {
    Text = "Pavimento instabile"
  },
  MapNodeType_18425_Desc = {
    Text = "Cerca pazientemente la sua Porta."
  },
  MapNodeType_18425_Name = {
    Text = "Chiave arrugginita"
  },
  MapNodeType_18426_Desc = {
    Text = "Sostituto dell'Avatar"
  },
  MapNodeType_18426_Name = {
    Text = "Sostituto dell'Avatar"
  },
  MapNodeType_18427_Desc = {
    Text = "Un'illusione distorta blocca il tuo cammino; scegliere di infrangerla ti infetterà con un sintomo sconosciuto"
  },
  MapNodeType_18427_Name = {Text = "Illusione"},
  MapNodeType_18428_Desc = {
    Text = "Estrai un po' di Argento dall'aria."
  },
  MapNodeType_18428_Name = {Text = "Argento"},
  MapNodeType_18429_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_18429_Name = {
    Text = "Un Dono di Gentilezza"
  },
  MapNodeType_18430_Desc = {
    Text = "Nodo negozio speciale di test. Se vedi questo messaggio, non ti trovi in un livello ufficiale."
  },
  MapNodeType_18430_Name = {
    Text = "Negozio speciale"
  },
  MapNodeType_18431_Desc = {
    Text = "Alcuni nemici inattesi daranno inizio a una battaglia."
  },
  MapNodeType_18431_Name = {Text = "Battaglia"},
  MapNodeType_18432_Desc = {
    Text = "Zona di Dissoluzione pericolosa, non entrare alla leggera."
  },
  MapNodeType_18432_Name = {
    Text = "Palude Malefica"
  },
  MapNodeType_24876_Desc = {
    Text = "Alcuni nemici moderatamente impegnativi innescheranno una battaglia più ardua."
  },
  MapNodeType_24876_Name = {Text = "Élite"},
  MapNodeType_35056_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_35056_Name = {
    Text = "Il Mito del Produttore"
  },
  MapNodeType_35889_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_35889_Name = {
    Text = "Vele Pallide"
  },
  MapNodeType_37987_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_37987_Name = {
    Text = "Codice dell'Emissario"
  },
  MapNodeType_38711_Desc = {
    Text = "Entra nel Negozio D-Marchio, dove una presenza misteriosa prenderà i tuoi Sigilli Neri e offrirà potere in cambio."
  },
  MapNodeType_38711_Name = {
    Text = "Mercato di Charich"
  },
  MapNodeType_44838_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_44838_Name = {Text = "Desiderio"},
  MapNodeType_44839_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_44839_Name = {Text = "Redenzione"},
  MapNodeType_44840_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_44840_Name = {Text = "Pentimento"},
  MapNodeType_46149_Desc = {
    Text = "Entra nel Negozio D-Marchio, dove una presenza misteriosa prenderà i tuoi Sigilli Neri e offrirà potere in cambio."
  },
  MapNodeType_46149_Name = {Text = "D-segno"},
  MapNodeType_47473_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_47473_Name = {
    Text = "Sogno Lucido"
  },
  MapNodeType_47474_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_47474_Name = {
    Text = "Fusione del Nucleo"
  },
  MapNodeType_47475_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_47475_Name = {
    Text = "Serpente Ipnotico"
  },
  MapNodeType_48144_Desc = {
    Text = "Pericolo o opportunità, la scelta è tua."
  },
  MapNodeType_48144_Name = {
    Text = "Autoconsapevolezza"
  },
  MapNodeType_49058_Desc = {
    Text = "Qualcosa sembra celarsi nella pozza, il suo colore un rosso cupo che sconfina nel nero."
  },
  MapNodeType_49058_Name = {
    Text = "Pozza di Sangue Corrotto"
  },
  MapNodeType_49100_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_49100_Name = {
    Text = "Madre Nutrice"
  },
  MapNodeType_52484_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_52484_Name = {Text = "Calamità"},
  MapNodeType_52485_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_52485_Name = {Text = "Calamità"},
  MapNodeType_52486_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_52486_Name = {Text = "Calamità"},
  MapNodeType_52487_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_52487_Name = {
    Text = "Sacrificio Supremo"
  },
  MapNodeType_55797_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_55797_Name = {
    Text = "Dono della Primavera"
  },
  MapNodeType_55798_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_55798_Name = {
    Text = "Benedizione di Muzus"
  },
  MapNodeType_57740_Desc = {
    Text = "Quest'area, priva di qualsiasi ostruzione, è completamente esposta alla sorveglianza del Comitato."
  },
  MapNodeType_57740_Name = {
    Text = "Punto d'Osservazione"
  },
  MapNodeType_57741_Desc = {
    Text = "Le guardie del Comitato sono negligenti; forse questo potrebbe essere un percorso utilizzabile?"
  },
  MapNodeType_57741_Name = {
    Text = "Punto di Detenzione"
  },
  MapNodeType_57742_Desc = {
    Text = "Gli sgherri di Juliette sembrano non finire mai. Un'altra squadra di Agenti del Comitato vi sbarra la strada."
  },
  MapNodeType_57742_Name = {
    Text = "Agente del Comitato"
  },
  MapNodeType_59662_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_59662_Name = {
    Text = "Cerimonia d'Immatricolazione"
  },
  MapNodeType_65469_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_65469_Name = {
    Text = "Punto di Evacuazione Sicuro"
  },
  MapNodeType_74221_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_74221_Name = {
    Text = "Coscienza Non Ancora Perduta"
  },
  MapNodeType_76256_Desc = {
    Text = "Le rovine sommerse di Limoria, dove la presenza che si cela dietro di esse desidera scambiare poteri misteriosi con il Sigillo Nero nelle vostre mani."
  },
  MapNodeType_76256_Name = {
    Text = "Rovine di Cenere"
  },
  MapNodeType_76417_Desc = {
    Text = "Un frammento d'osso pallido, semi-sommerso nella D-melma nera"
  },
  MapNodeType_76417_Name = {
    Text = "Ossa Sbiadite"
  },
  MapNodeType_80599_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_80599_Name = {
    Text = "Metempsicosi"
  },
  MapNodeType_90661_Desc = {
    Text = "La Chiave d'Argento ti ha guidato fin qui. Entra in risonanza con ciò che esiste in questo luogo."
  },
  MapNodeType_90661_Name = {
    Text = "Gusto Perfetto"
  }
})
return Text_MapNodeType
