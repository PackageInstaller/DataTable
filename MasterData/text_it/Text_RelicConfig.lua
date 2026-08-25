__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_RelicConfig = readonly({
  RelicConfig_100300_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni 1 accumulo di \"<MindWall:Barriera Mentale>\", e dopo 3 turni, convertilo in \"<BarrierCrash:Sgretolamento>\"."
  },
  RelicConfig_100300_Desc = {
    Text = "All'inizio della battaglia, ottieni 1 accumulo di \"<MindWall:Barriera Mentale>\", e dopo 3 turni, convertilo in \"<BarrierCrash:Sgretolamento>\"."
  },
  RelicConfig_100300_Name = {
    Text = "Analisi della Psiche"
  },
  RelicConfig_100300_StoryDesc = {
    Text = "Scruta attentamente il tuo cuore e non compiere la scelta sbagliata."
  },
  RelicConfig_100399_BattleDesc = {
    Text = "Dopo aver attivato l'effetto <DevouredIconKeywords:Divorare>, gli altri Risvegliati ottengono [Arg1] Aliemus. Si attiva una volta per turno."
  },
  RelicConfig_100399_Desc = {
    Text = "Dopo aver attivato l'effetto <DevouredIconKeywords:Divorare>, gli altri Risvegliati ottengono [Arg1] Aliemus. Si attiva una volta per turno."
  },
  RelicConfig_100399_Name = {
    Text = "<OrangeQuality:Fantasticheria Dorata Dipinta+>"
  },
  RelicConfig_100399_StoryDesc = {
    Text = "Il giorno della trasformazione sarà la tua rovina."
  },
  RelicConfig_100400_BattleDesc = {
    Text = "A fine turno, ripristina [Heal:Arg1] HP."
  },
  RelicConfig_100400_Desc = {
    Text = "A fine turno, ripristina [Heal:Arg1] HP."
  },
  RelicConfig_100400_Name = {
    Text = "<OrangeQuality:Sangue Benedetto Dipinto+>"
  },
  RelicConfig_100400_StoryDesc = {
    Text = "È dolce e vellutato, con una fragranza di rose."
  },
  RelicConfig_100401_BattleDesc = {
    Text = "Alla perdita di PV, accumula Fornace Cremisi pari al [Arg1]% dei PV persi."
  },
  RelicConfig_100401_Desc = {
    Text = "Alla perdita di PV, accumula Fornace Cremisi pari al [Arg1]% dei PV persi."
  },
  RelicConfig_100401_Name = {
    Text = "<OrangeQuality:Sega Arrugginita Dipinta+>"
  },
  RelicConfig_100401_StoryDesc = {
    Text = "Il dottore anatomista trascorre la sua vita senza mai vedere una bella donna, solo sacchi d'ossa, nervi infiammati, muscoli e tessuti corrosi dalle malattie."
  },
  RelicConfig_100402_BattleDesc = {
    Text = "Al momento della raccolta, infliggi [Arg1] accumuli di <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici. Il DAN Base inflitto da tutti i Risvegliati +[Arg2]%."
  },
  RelicConfig_100402_Desc = {
    Text = "Al momento della raccolta, infliggi [Arg1] accumuli di <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici. Il DAN Base inflitto da tutti i Risvegliati +[Arg2]%."
  },
  RelicConfig_100402_Name = {
    Text = "<WhiteQuality:La Sagra della Primavera Dipinta>"
  },
  RelicConfig_100402_StoryDesc = {
    Text = "Tra le risa della notte, la sagoma della canoa scivola senza sforzo attraverso il lago."
  },
  RelicConfig_100404_BattleDesc = {
    Text = "Dopo aver rilasciato \"Esaltazione\", ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_100404_Desc = {
    Text = "Dopo aver rilasciato \"Esaltazione\", ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_100404_Name = {
    Text = "<WhiteQuality:Serratura di ferro Dipinta>"
  },
  RelicConfig_100404_StoryDesc = {
    Text = "Un lucchetto spesso e robusto, difficile da aprire senza una chiave.\nNaturalmente, questo non è nulla per un maestro ladro"
  },
  RelicConfig_100405_BattleDesc = {
    Text = "Al momento della raccolta, infliggi [Arg1] accumuli di <WeaknessIconKeywords:Debolezza> a tutti i nemici. Il DAN Base inflitto da tutti i Risvegliati +[Arg2]%."
  },
  RelicConfig_100405_Desc = {
    Text = "Al momento della raccolta, infliggi [Arg1] accumuli di <WeaknessIconKeywords:Debolezza> a tutti i nemici. Il DAN Base inflitto da tutti i Risvegliati +[Arg2]%."
  },
  RelicConfig_100405_Name = {
    Text = "<WhiteQuality:Bambino Maligno Dipinto>"
  },
  RelicConfig_100405_StoryDesc = {
    Text = "Nato dal male puro, sebbene non fosse per sua volontà."
  },
  RelicConfig_100406_BattleDesc = {
    Text = "Dopo aver attivato l'effetto <DevouredIconKeywords:Divorare>, gli altri Risvegliati ottengono [Arg1] Aliemus. Si attiva una volta per turno."
  },
  RelicConfig_100406_Desc = {
    Text = "Dopo aver attivato l'effetto <DevouredIconKeywords:Divorare>, gli altri Risvegliati ottengono [Arg1] Aliemus. Si attiva una volta per turno."
  },
  RelicConfig_100406_Name = {
    Text = "<WhiteQuality:Fantasticheria Dorata Dipinta>"
  },
  RelicConfig_100406_StoryDesc = {
    Text = "Il giorno della trasformazione sarà la tua rovina."
  },
  RelicConfig_100407_BattleDesc = {
    Text = "Ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea ogni volta che vengono inflitti danni, fino a 15 volte per turno."
  },
  RelicConfig_100407_Desc = {
    Text = "Ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea ogni volta che vengono inflitti danni, fino a 15 volte per turno."
  },
  RelicConfig_100407_Name = {
    Text = "<WhiteQuality:Agata Filigranata Dipinta>"
  },
  RelicConfig_100407_StoryDesc = {
    Text = "Probabilmente sono solo comuni venature d'agata. Forse."
  },
  RelicConfig_100408_BattleDesc = {
    Text = "Dopo aver rilasciato \"Esaltazione\", ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_100408_Desc = {
    Text = "Dopo aver rilasciato \"Esaltazione\", ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_100408_Name = {
    Text = "<OrangeQuality:Serratura di ferro Dipinta+>"
  },
  RelicConfig_100408_StoryDesc = {
    Text = "Un lucchetto spesso e robusto, difficile da aprire senza una chiave.\nNaturalmente, questo non è nulla per un maestro ladro"
  },
  RelicConfig_100409_BattleDesc = {
    Text = "Al momento della raccolta, infliggi [Arg1] accumuli di <WeaknessIconKeywords:Debolezza> a tutti i nemici. Il DAN Base inflitto da tutti i Risvegliati +[Arg2]%."
  },
  RelicConfig_100409_Desc = {
    Text = "Al momento della raccolta, infliggi [Arg1] accumuli di <WeaknessIconKeywords:Debolezza> a tutti i nemici. Il DAN Base inflitto da tutti i Risvegliati +[Arg2]%."
  },
  RelicConfig_100409_Name = {
    Text = "<OrangeQuality:Bambino Maligno Dipinto+>"
  },
  RelicConfig_100409_StoryDesc = {
    Text = "Nato dal male puro, sebbene non fosse per sua volontà."
  },
  RelicConfig_100410_BattleDesc = {
    Text = "Ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea ogni volta che vengono inflitti danni, fino a 15 volte per turno."
  },
  RelicConfig_100410_Desc = {
    Text = "Ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea ogni volta che vengono inflitti danni, fino a 15 volte per turno."
  },
  RelicConfig_100410_Name = {
    Text = "<OrangeQuality:Agata Filigranata Dipinta+>"
  },
  RelicConfig_100410_StoryDesc = {
    Text = "Probabilmente sono solo comuni venature d'agata. Forse."
  },
  RelicConfig_100411_BattleDesc = {
    Text = "Al momento della raccolta, infliggi [Arg1] accumuli di <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici. Il DAN Base inflitto da tutti i Risvegliati +[Arg2]%."
  },
  RelicConfig_100411_Desc = {
    Text = "Al momento della raccolta, infliggi [Arg1] accumuli di <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici. Il DAN Base inflitto da tutti i Risvegliati +[Arg2]%."
  },
  RelicConfig_100411_Name = {
    Text = "<OrangeQuality:La Sagra della Primavera Dipinta+>"
  },
  RelicConfig_100411_StoryDesc = {
    Text = "Tra le risa della notte, la sagoma della canoa scivola senza sforzo attraverso il lago."
  },
  RelicConfig_100412_BattleDesc = {
    Text = "A fine turno, ripristina [Heal:Arg1] HP."
  },
  RelicConfig_100412_Desc = {
    Text = "A fine turno, ripristina [Heal:Arg1] HP."
  },
  RelicConfig_100412_Name = {
    Text = "<WhiteQuality:Sangue Benedetto Dipinto>"
  },
  RelicConfig_100412_StoryDesc = {
    Text = "È dolce e vellutato, con una fragranza di rose."
  },
  RelicConfig_100413_BattleDesc = {
    Text = "Alla perdita di PV, accumula Fornace Cremisi pari al [Arg1]% dei PV persi."
  },
  RelicConfig_100413_Desc = {
    Text = "Alla perdita di PV, accumula Fornace Cremisi pari al [Arg1]% dei PV persi."
  },
  RelicConfig_100413_Name = {
    Text = "<WhiteQuality:Sega Arrugginita Dipinta>"
  },
  RelicConfig_100413_StoryDesc = {
    Text = "Il dottore anatomista trascorre la sua vita senza mai vedere una bella donna, solo sacchi d'ossa, nervi infiammati, muscoli e tessuti corrosi dalle malattie."
  },
  RelicConfig_100539_BattleDesc = {
    Text = "Dopo aver utilizzato direttamente \"Embrione\" per la prima volta ogni turno, il Danno attivo infliggerà il [Arg1]% del Danno inflitto come <BleedingIconKeywords:Salasso> per il resto del turno."
  },
  RelicConfig_100539_Desc = {
    Text = "Dopo aver utilizzato direttamente \"Embrione\" per la prima volta ogni turno, il Danno attivo infliggerà il [Arg1]% del Danno inflitto come <BleedingIconKeywords:Salasso> per il resto del turno."
  },
  RelicConfig_100539_Name = {
    Text = "<WhiteQuality:Ciottolo Insanguinato Dipinto>"
  },
  RelicConfig_100539_StoryDesc = {
    Text = "Uno, Due, Tre, Quattro, Cinque."
  },
  RelicConfig_100540_BattleDesc = {
    Text = "Dopo aver utilizzato direttamente \"Embrione\" per la prima volta ogni turno, il Danno attivo infliggerà il [Arg1]% del Danno inflitto come <BleedingIconKeywords:Salasso> per il resto del turno."
  },
  RelicConfig_100540_Desc = {
    Text = "Dopo aver utilizzato direttamente \"Embrione\" per la prima volta ogni turno, il Danno attivo infliggerà il [Arg1]% del Danno inflitto come <BleedingIconKeywords:Salasso> per il resto del turno."
  },
  RelicConfig_100540_Name = {
    Text = "<OrangeQuality:Ciottolo Insanguinato Dipinto+>"
  },
  RelicConfig_100540_StoryDesc = {
    Text = "Uno, Due, Tre, Quattro, Cinque."
  },
  RelicConfig_116382_BattleDesc = {
    Text = "Un mazzo di chiavi arrugginite. Può essere usato per aprire le porte."
  },
  RelicConfig_116382_Desc = {
    Text = "Un mazzo di chiavi arrugginite. Può essere usato per aprire le porte."
  },
  RelicConfig_116382_Name = {
    Text = "Chiave arrugginita"
  },
  RelicConfig_116383_BattleDesc = {
    Text = "Un mazzo di chiavi arrugginite. Può essere usato per aprire le porte."
  },
  RelicConfig_116383_Desc = {
    Text = "Un mazzo di chiavi arrugginite. Può essere usato per aprire le porte."
  },
  RelicConfig_116383_Name = {
    Text = "Chiave arrugginita"
  },
  RelicConfig_116384_BattleDesc = {
    Text = "Un mazzo di chiavi arrugginite. Può essere usato per aprire le porte."
  },
  RelicConfig_116384_Desc = {
    Text = "Un mazzo di chiavi arrugginite. Può essere usato per aprire le porte."
  },
  RelicConfig_116384_Name = {
    Text = "Chiave arrugginita"
  },
  RelicConfig_119371_BattleDesc = {
    Text = [[
Limite mano +1.
All'inizio del turno, se non tutti i rituali sono completati, subisci <SacrificeKeyWord:Sacrificio> pari al 10% dei PV massimi. Metti 1 "<DerivativeCardKeywords_119:Dedizione Divina>" in mano, massimo 1.]]
  },
  RelicConfig_119371_Desc = {
    Text = [[
Limite mano +1.
All'inizio del turno, se non tutti i rituali sono completati, subisci <SacrificeKeyWord:Sacrificio> pari al 10% dei PV massimi. Metti 1 "<DerivativeCardKeywords_119:Dedizione Divina>" in mano, massimo 1.]]
  },
  RelicConfig_119371_Name = {
    Text = "Incensiere di Ottone"
  },
  RelicConfig_119371_StoryDesc = {
    Text = "\"Questo incensiere è stato forgiato imitando l'artigianato di Lemuria, possa aiutarti a dormire serenamente ogni notte. Da Miryam.\""
  },
  RelicConfig_120372_BattleDesc = {
    Text = "Limite della mano +[Arg1]. All'inizio di ogni turno, aggiungi [Arg2] \"<PVPDerivativeCardKeywords_11:Scambio Ineguale>\" alla mano."
  },
  RelicConfig_120372_Desc = {
    Text = "Limite della mano +[Arg1]. All'inizio di ogni turno, aggiungi [Arg2] \"<PVPDerivativeCardKeywords_11:Scambio Ineguale>\" alla mano."
  },
  RelicConfig_120372_Name = {
    Text = "<OrangeQuality:Caleidoscopio>"
  },
  RelicConfig_120373_BattleDesc = {
    Text = "Le prime [Arg1] carte \"<PVPWeaponKeywords:RdD>\" hanno Costo di Arithmetica -5/-3/-1/+1, rispettivamente. Pesca 1 carta dopo aver giocato carte RdD."
  },
  RelicConfig_120373_Desc = {
    Text = "Le prime [Arg1] carte \"<PVPWeaponKeywords:RdD>\" hanno Costo di Arithmetica -5/-3/-1/+1, rispettivamente. Pesca 1 carta dopo aver giocato carte RdD."
  },
  RelicConfig_120373_Name = {
    Text = "<OrangeQuality:Insegna Mythag>"
  },
  RelicConfig_121214_BattleDesc = {
    Text = "Immunità ai Danni"
  },
  RelicConfig_121214_Desc = {
    Text = "Immunità ai Danni"
  },
  RelicConfig_121214_Name = {
    Text = "Reliquia di Test Invincibile"
  },
  RelicConfig_121689_BattleDesc = {
    Text = "Aumenta il Danno Finale del 250%. Ogni volta che si infligge danno, questo bonus si riduce del 50% (fino a 5 volte), mentre la Generazione di Scudo del Personaggio aumenta del 10%. Si ripristina ogni turno."
  },
  RelicConfig_121689_Desc = {
    Text = "Aumenta il Danno Finale del 250%. Ogni volta che si infligge danno, questo bonus si riduce del 50% (fino a 5 volte), mentre la Generazione di Scudo del Personaggio aumenta del 10%. Si ripristina ogni turno."
  },
  RelicConfig_121689_Name = {
    Text = "<OrangeQuality:\"Ritorno d'Argento Puro: Nascita\">"
  },
  RelicConfig_121690_BattleDesc = {
    Text = "All'inizio della battaglia, scegli 3 carte per conferire loro \"<RippleKeywords:Onda d'Urto Residua>: Pesca una carta e ottieni [Arg3] <PowerIconKeywords:STR> Temporaneo/a\". All'inizio del turno, pesca 2 carte con <RippleKeywords:Onda d'Urto Residua>, tutti gli effetti di <RippleKeywords:Onda d'Urto Residua> si attivano una volta aggiuntiva. Dopo aver attivato <RippleKeywords:Onda d'Urto Residua> 10 volte, aggiungi 1 <DerivativeCardKeywords_1:Echi di Ombre Perdute> alla tua mano."
  },
  RelicConfig_121690_Desc = {
    Text = "All'inizio della battaglia, scegli 3 carte per conferire loro \"<RippleKeywords:Onda d'Urto Residua>: Pesca una carta e ottieni [Arg3] <PowerIconKeywords:STR> Temporaneo/a\". All'inizio del turno, pesca 2 carte con <RippleKeywords:Onda d'Urto Residua>, tutti gli effetti di <RippleKeywords:Onda d'Urto Residua> si attivano una volta aggiuntiva. Dopo aver attivato <RippleKeywords:Onda d'Urto Residua> 10 volte, aggiungi 1 <DerivativeCardKeywords_1:Echi di Ombre Perdute> alla tua mano."
  },
  RelicConfig_121690_Name = {
    Text = "<OrangeQuality:\"Ritorno d'Argento Puro: Follia\">"
  },
  RelicConfig_121691_BattleDesc = {
    Text = "Danno Finale dell'Esaltazione di tutti i Risvegliati +100%. Ogni volta che un Risvegliato usa l'Esaltazione, ottieni Keyflare pari al 500% dell'Aliemus Base di quel Risvegliato, e riduci l'Aliemus Base di tutti i Risvegliati di 20, fino a 5 volte."
  },
  RelicConfig_121691_Desc = {
    Text = "Danno Finale dell'Esaltazione di tutti i Risvegliati +100%. Ogni volta che un Risvegliato usa l'Esaltazione, ottieni Keyflare pari al 500% dell'Aliemus Base di quel Risvegliato, e riduci l'Aliemus Base di tutti i Risvegliati di 20, fino a 5 volte."
  },
  RelicConfig_121691_Name = {
    Text = "<OrangeQuality:\"Ritorno d'Argento Puro: Paura\">"
  },
  RelicConfig_121692_BattleDesc = {
    Text = "Gli effetti di <RetaliateIconKeywords:Contatore>, <IntoxicationIconKeywords:Veleno>, Scudo del Personaggio e Recupero PV generati da tutti i risvegliati sono aumentati del 50%. Alla fine del turno, ottieni <RetaliateIconKeywords:Contatore> Temporaneo pari al 500% dello Scudo del Personaggio attuale."
  },
  RelicConfig_121692_Desc = {
    Text = "Gli effetti di <RetaliateIconKeywords:Contatore>, <IntoxicationIconKeywords:Veleno>, Scudo del Personaggio e Recupero PV generati da tutti i risvegliati sono aumentati del 50%. Alla fine del turno, ottieni <RetaliateIconKeywords:Contatore> Temporaneo pari al 500% dello Scudo del Personaggio attuale."
  },
  RelicConfig_121692_Name = {
    Text = "<OrangeQuality:\"Ritorno d'Argento Puro: Eresia\">"
  },
  RelicConfig_121693_BattleDesc = {
    Text = "Limite Massima della Mano +5. All'inizio del tuo turno, pesca 2 carte e ottieni 2 Arithmetica. Ogni volta che il mazzo viene rimescolato, ottieni [Arg3] <PowerIconKeywords:FOR> e [Arg4] <AlertIconKeywords:Allerta> Temporaneo, genera 1 Carta Comando Non-Derivata di ciascun tipo per il Risvegliatore con il più alto Aliemus e inseriscile nel Mazzo di Pesca, riducendo il loro Costo di Arithmetica di 1."
  },
  RelicConfig_121693_Desc = {
    Text = "Limite Massima della Mano +5. All'inizio del tuo turno, pesca 2 carte e ottieni 2 Arithmetica. Ogni volta che il mazzo viene rimescolato, ottieni [Arg3] <PowerIconKeywords:FOR> e [Arg4] <AlertIconKeywords:Allerta> Temporaneo, genera 1 Carta Comando Non-Derivata di ciascun tipo per il Risvegliatore con il più alto Aliemus e inseriscile nel Mazzo di Pesca, riducendo il loro Costo di Arithmetica di 1."
  },
  RelicConfig_121693_Name = {
    Text = "<OrangeQuality:\"Ritorno d'Argento Puro: Flagello\">"
  },
  RelicConfig_121694_BattleDesc = {
    Text = "All'inizio di ogni turno, tutti i risvegliati ottengono 25 Aliemus e pescano un'<DerivativeCardKeywords_4:Intuizione> nella propria Mano. Dopo aver scatenato \"Esaltazione\" 4 volte, rimuovi lo stato <Seal:Sigillato> da tutti i risvegliati e concedi loro 50 Aliemus."
  },
  RelicConfig_121694_Desc = {
    Text = "All'inizio di ogni turno, tutti i risvegliati ottengono 25 Aliemus e pescano un'<DerivativeCardKeywords_4:Intuizione> nella propria Mano. Dopo aver scatenato \"Esaltazione\" 4 volte, rimuovi lo stato <Seal:Sigillato> da tutti i risvegliati e concedi loro 50 Aliemus."
  },
  RelicConfig_121694_Name = {
    Text = "<OrangeQuality:\"Ritorno d'Argento Puro: Inganno\">"
  },
  RelicConfig_121695_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni [Arg4] <PowerIconKeywords:FOR> e aumenta il limite di Keyflare del 100%. Il Keyflare ottenuto per ogni punto di Arithmetica consumato è aumentato del 100%. Dopo aver usato il Risveglio Keyflare o aver scatenato il Posse, ottieni <PowerIconKeywords:FOR> Temporanea pari al 20% della <PowerIconKeywords:FOR> attuale e concedi a tutti i Risvegliatori 20 Aliemus."
  },
  RelicConfig_121695_Desc = {
    Text = "All'inizio della battaglia, ottieni [Arg4] <PowerIconKeywords:FOR> e aumenta il limite di Keyflare del 100%. Il Keyflare ottenuto per ogni punto di Arithmetica consumato è aumentato del 100%. Dopo aver usato il Risveglio Keyflare o aver scatenato il Posse, ottieni <PowerIconKeywords:FOR> Temporanea pari al 20% della <PowerIconKeywords:FOR> attuale e concedi a tutti i Risvegliatori 20 Aliemus."
  },
  RelicConfig_121695_Name = {
    Text = "<OrangeQuality:\"Ritorno d'Argento Puro: Dolore\">"
  },
  RelicConfig_122625_BattleDesc = {
    Text = "All'inizio della battaglia, aggiungi [Arg1] \"<PVPDerivativeCardKeywords_25:Il Tè Rosso di Sylvia>\" alla mano."
  },
  RelicConfig_122625_Desc = {
    Text = "All'inizio della battaglia, aggiungi [Arg1] \"<PVPDerivativeCardKeywords_25:Il Tè Rosso di Sylvia>\" alla mano."
  },
  RelicConfig_122625_Name = {
    Text = "<OrangeQuality:Tè di Ceylon>"
  },
  RelicConfig_122626_BattleDesc = {
    Text = "Mischia [Arg1] \"<PVPDerivativeCardKeywords_14:Imitazione della Realtà>\" nel Mazzo di Pesca ogni turno; il proprietario è un Risvegliato casuale."
  },
  RelicConfig_122626_Desc = {
    Text = "Mischia [Arg1] \"<PVPDerivativeCardKeywords_14:Imitazione della Realtà>\" nel Mazzo di Pesca ogni turno; il proprietario è un Risvegliato casuale."
  },
  RelicConfig_122626_Name = {
    Text = "<OrangeQuality:Guanti Arcani>"
  },
  RelicConfig_122627_BattleDesc = {
    Text = "La prima \"Abilità\" giocata ogni turno ha Danno, Guarigione e Scudo del Personaggio +[Arg1]%."
  },
  RelicConfig_122627_Desc = {
    Text = "La prima \"Abilità\" giocata ogni turno ha Danno, Guarigione e Scudo del Personaggio +[Arg1]%."
  },
  RelicConfig_122627_Name = {
    Text = "<OrangeQuality:Spilla di Rubino>"
  },
  RelicConfig_122628_BattleDesc = {
    Text = "Alla fine del turno, ottieni <Energy:[Arg1]> Aliemus aggiuntivi."
  },
  RelicConfig_122628_Desc = {
    Text = "Alla fine del turno, ottieni <Energy:[Arg1]> Aliemus aggiuntivi."
  },
  RelicConfig_122628_Name = {
    Text = "<OrangeQuality:Manifestazione dell'Incubo>"
  },
  RelicConfig_122629_BattleDesc = {
    Text = "Nel Mazzo di Pesca ci sarà il doppio delle carte Risvegliato. Dopo aver giocato una carta, quando il numero di carte scende sotto [Arg1] per la prima volta in questo turno, pesca [Arg2] carte."
  },
  RelicConfig_122629_Desc = {
    Text = "Nel Mazzo di Pesca ci sarà il doppio delle carte Risvegliato. Dopo aver giocato una carta, quando il numero di carte scende sotto [Arg1] per la prima volta in questo turno, pesca [Arg2] carte."
  },
  RelicConfig_122629_Name = {
    Text = "<OrangeQuality:Disco Gioioso>"
  },
  RelicConfig_122630_BattleDesc = {
    Text = "Limite della mano +[Arg1]. Inserisci [Arg2] \"<PVPDerivativeCardKeywords_13:Funus Aeternum>\" nel Mazzo di Pesca ogni turno."
  },
  RelicConfig_122630_Desc = {
    Text = "Limite della mano +[Arg1]. Inserisci [Arg2] \"<PVPDerivativeCardKeywords_13:Funus Aeternum>\" nel Mazzo di Pesca ogni turno."
  },
  RelicConfig_122630_Name = {
    Text = "<OrangeQuality:Pugnale Rituale>"
  },
  RelicConfig_122768_BattleDesc = {
    Text = [[
A inizio turno, pesca [Arg1] carte "Colpo" con Costo di Arithmetica -1. Dopo aver rilasciato l'Esaltazione, genera [Arg2] carte "Colpo" del Risvegliato corrispondente con <DepleteIconKeywords:Consumo>, <PrepareKeypvewords:Preparazione 1> e <RetainIconKeywords:Conserva>.
Per ogni [Arg3] "Colpo" giocato in 1 turno, ottieni [Arg4] <PowerIconKeywords:FOR> Temporanea; dopo aver giocato [Arg5] carte "Colpo", pesca [Arg6] carte e ottieni [Arg7] Arithmetica; dopo aver giocato [Arg8] carte "Colpo", tutti i Risvegliati ottengono [Arg9] Aliemus.]]
  },
  RelicConfig_122768_Desc = {
    Text = [[
A inizio turno, pesca [Arg1] carte "Colpo" con Costo di Arithmetica -1. Dopo aver rilasciato l'Esaltazione, genera [Arg2] carte "Colpo" del Risvegliato corrispondente con <DepleteIconKeywords:Consumo>, <PrepareKeypvewords:Preparazione 1> e <RetainIconKeywords:Conserva>.
Per ogni [Arg3] "Colpo" giocato in 1 turno, ottieni [Arg4] <PowerIconKeywords:FOR> Temporanea; dopo aver giocato [Arg5] carte "Colpo", pesca [Arg6] carte e ottieni [Arg7] Arithmetica; dopo aver giocato [Arg8] carte "Colpo", tutti i Risvegliati ottengono [Arg9] Aliemus.]]
  },
  RelicConfig_122768_Name = {
    Text = "Echi dall'Aldilà"
  },
  RelicConfig_122768_StoryDesc = {
    Text = "Echi che si mescolano nella nebbia di un altro mondo, conducendo a distorsione, follia e innegabile realtà."
  },
  RelicConfig_123724_BattleDesc = {
    Text = "All'inizio del turno, Mouchette ottiene [Arg1] Aliemus e genera 1 Colpo Temporaneo con Costo di Arithmetica pari a 0. Ogni volta che \"Incontro Drammatico\" si attiva, aumenta il DAN Base e l'effetto di aumento del DAN Colpo di \"Brillante☆Tornado\" del [Arg2] % per questa battaglia."
  },
  RelicConfig_123724_Desc = {
    Text = "All'inizio del turno, Mouchette ottiene [Arg1] Aliemus e genera 1 Colpo Temporaneo con Costo di Arithmetica pari a 0. Ogni volta che \"Incontro Drammatico\" si attiva, aumenta il DAN Base e l'effetto di aumento del DAN Colpo di \"Brillante☆Tornado\" del [Arg2] % per questa battaglia."
  },
  RelicConfig_123724_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Mouchette>"
  },
  RelicConfig_125488_BattleDesc = {
    Text = "Tutti i Risvegliati ottengono [Arg1] Aliemus la prima volta che giocano una Carta di comando ogni turno. Dopo aver giocato 4 Carte di comando appartenenti a Risvegliati diversi in un turno, infliggi il [Arg2]% dei PV massimi della tua squadra come <IntoxicationIconKeywords:Veleno> a tutti i nemici."
  },
  RelicConfig_125488_Desc = {
    Text = "Tutti i Risvegliati ottengono [Arg1] Aliemus la prima volta che giocano una Carta di comando ogni turno. Dopo aver giocato 4 Carte di comando appartenenti a Risvegliati diversi in un turno, infliggi il [Arg2]% dei PV massimi della tua squadra come <IntoxicationIconKeywords:Veleno> a tutti i nemici."
  },
  RelicConfig_125488_Name = {
    Text = "Vanità delle Concubine"
  },
  RelicConfig_125489_BattleDesc = {
    Text = "A inizio turno, Xu ottiene [Arg1] Aliemus e infligge 1 accumulo di <WitherKeywords:Ammaliamento> a tutti i nemici. La prima Carta di comando giocata da Xu ogni turno attiverà l'effetto \"Risonanza\"."
  },
  RelicConfig_125489_Desc = {
    Text = "A inizio turno, Xu ottiene [Arg1] Aliemus e infligge 1 accumulo di <WitherKeywords:Ammaliamento> a tutti i nemici. La prima Carta di comando giocata da Xu ogni turno attiverà l'effetto \"Risonanza\"."
  },
  RelicConfig_125489_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Xu>"
  },
  RelicConfig_126673_BattleDesc = {
    Text = "Limite Massima della Mano +3. Registra le prime 3 Carte Comando Non-Derivate giocate ogni turno e, all'inizio del turno 3 turni dopo, riduci il loro Costo di Arithmetica di 1 e aggiungi copie con <DepleteIconKeywords:Consumo> alla tua mano."
  },
  RelicConfig_126673_Desc = {
    Text = "Limite Massima della Mano +3. Registra le prime 3 Carte Comando Non-Derivate giocate ogni turno e, all'inizio del turno 3 turni dopo, riduci il loro Costo di Arithmetica di 1 e aggiungi copie con <DepleteIconKeywords:Consumo> alla tua mano."
  },
  RelicConfig_126673_Name = {
    Text = "Orbis Fatum"
  },
  RelicConfig_126673_StoryDesc = {
    Text = "La ruota gira in eterno."
  },
  RelicConfig_129304_BattleDesc = {
    Text = "<OrangeQuality:Armonia Dorata>: \"Armonia di Arithmetica\" ora aumenta il Costo di Arithmetica solo di 1. Ogni 1% di Amplificazione del Danno aumenta la Profondità della Ricerca Occulta dell'1%.\n<OrangeQuality:Dono Dimensionale>: Ottieni 1 Reliquia Immagine Dimensionale casuale all'inizio dell'esplorazione. Limite Mano +1.\n<RedQuality:Fatica da Transito>: Tutti gli effetti di Recupero PV sono ridotti del 50% in battaglia. Quando si seleziona \"Sepoltura\" presso \"Ossa Sbiadite\", l'effetto cambia in ripristino del 25% dei PV Max.\n<OrangeQuality:Rituale Benedetto>: Le ricompense per aver sconfitto i Boss di Fase 1, 2 e 3 vengono sostituite con una scelta tra 3 Reliquie Benedette. \n<RedQuality:Vertigine da Movimento>: Tutti i Risvegliatori iniziano la battaglia con il 50% in meno di Aliemus Attuale del Personaggio e Keyflare. \n<RedQuality:Ferrovia della Notte Eterna>: Tutti i Risvegliatori ottengono +100% al loro Tetto Base di Aliemus e Keyflare all'inizio dell'esplorazione."
  },
  RelicConfig_129304_Desc = {
    Text = "<OrangeQuality:Armonia Dorata>: \"Armonia di Arithmetica\" ora aumenta il Costo di Arithmetica solo di 1. Ogni 1% di Amplificazione del Danno aumenta la Profondità della Ricerca Occulta dell'1%.\n<OrangeQuality:Dono Dimensionale>: Ottieni 1 Reliquia Immagine Dimensionale casuale all'inizio dell'esplorazione. Limite Mano +1.\n<RedQuality:Fatica da Transito>: Tutti gli effetti di Recupero PV sono ridotti del 50% in battaglia. Quando si seleziona \"Sepoltura\" presso \"Ossa Sbiadite\", l'effetto cambia in ripristino del 25% dei PV Max.\n<OrangeQuality:Rituale Benedetto>: Le ricompense per aver sconfitto i Boss di Fase 1, 2 e 3 vengono sostituite con una scelta tra 3 Reliquie Benedette. \n<RedQuality:Vertigine da Movimento>: Tutti i Risvegliatori iniziano la battaglia con il 50% in meno di Aliemus Attuale del Personaggio e Keyflare. \n<RedQuality:Ferrovia della Notte Eterna>: Tutti i Risvegliatori ottengono +100% al loro Tetto Base di Aliemus e Keyflare all'inizio dell'esplorazione."
  },
  RelicConfig_129304_Name = {
    Text = "<OrangeQuality:Fotocamera caotica di Little N>"
  },
  RelicConfig_129304_StoryDesc = {
    Text = "Oh no! È completamente distrutta! Aspetta... funziona ancora? Ma guarda quante restrizioni!"
  },
  RelicConfig_129305_BattleDesc = {
    Text = "<OrangeQuality:Armonia Dorata>: \"Armonia di Arithmetica\" ora aumenta il Costo di Arithmetica solo di 1. Ogni 1% di Amplificazione del Danno aumenta la Profondità della Ricerca Occulta dell'1%.\n<RedQuality:Fatica di Transito>: tutti gli effetti di Recupero PV sono ridotti del 50% in battaglia. Quando si seleziona \"Sepoltura\" presso \"Ossa Sbiadite\", l'effetto cambia e ripristina il 25% dei PV massimi."
  },
  RelicConfig_129305_Desc = {
    Text = "<OrangeQuality:Armonia Dorata>: \"Armonia di Arithmetica\" ora aumenta il Costo di Arithmetica solo di 1. Ogni 1% di Amplificazione del Danno aumenta la Profondità della Ricerca Occulta dell'1%.\n<RedQuality:Fatica di Transito>: tutti gli effetti di Recupero PV sono ridotti del 50% in battaglia. Quando si seleziona \"Sepoltura\" presso \"Ossa Sbiadite\", l'effetto cambia e ripristina il 25% dei PV massimi."
  },
  RelicConfig_129305_Name = {
    Text = "<OrangeQuality:Fotocamera immacolata di Little N>"
  },
  RelicConfig_129305_StoryDesc = {
    Text = "Non cercare oltre: è proprio quello giusto! Nuovo di zecca, appena uscito dalla Fabbrica, soddisfazione garantita."
  },
  RelicConfig_129306_BattleDesc = {
    Text = "<OrangeQuality:Armonia Dorata>: \"Armonia di Arithmetica\" ora aumenta il Costo di Arithmetica solo di 1. Ogni 1% di Amplificazione del Danno aumenta la Profondità della Ricerca Occulta dell'1%.\n<OrangeQuality:Dono Dimensionale>: Ottieni 1 Reliquia Immagine Dimensionale casuale all'inizio dell'esplorazione. Limite di carte in mano +1.\n<RedQuality:Fatica del Transito>: Tutti gli effetti di Recupero PV sono ridotti del 50% in battaglia. Quando si seleziona \"Sepoltura\" presso \"Ossa Sbiadite\", l'effetto cambia in ripristino del 25% dei PV massimi.\n<RedQuality:Vertigine da Movimento>: Tutti i Risvegliati iniziano la battaglia con il 50% in meno di Aliemus Attuale del Personaggio e Keyflare."
  },
  RelicConfig_129306_Desc = {
    Text = "<OrangeQuality:Armonia Dorata>: \"Armonia di Arithmetica\" ora aumenta il Costo di Arithmetica solo di 1. Ogni 1% di Amplificazione del Danno aumenta la Profondità della Ricerca Occulta dell'1%.\n<OrangeQuality:Dono Dimensionale>: Ottieni 1 Reliquia Immagine Dimensionale casuale all'inizio dell'esplorazione. Limite di carte in mano +1.\n<RedQuality:Fatica del Transito>: Tutti gli effetti di Recupero PV sono ridotti del 50% in battaglia. Quando si seleziona \"Sepoltura\" presso \"Ossa Sbiadite\", l'effetto cambia in ripristino del 25% dei PV massimi.\n<RedQuality:Vertigine da Movimento>: Tutti i Risvegliati iniziano la battaglia con il 50% in meno di Aliemus Attuale del Personaggio e Keyflare."
  },
  RelicConfig_129306_Name = {
    Text = "<OrangeQuality:Fotocamera logora di Little N>"
  },
  RelicConfig_129306_StoryDesc = {
    Text = "È rovinata! La fotocamera è rotta! Fammi vedere se riesco a ripararla... oh, si sta accendendo! Ma perché adesso sembra così strana?"
  },
  RelicConfig_131079_BattleDesc = {
    Text = "All'Inizio del turno, Vortice ottiene [Arg1] Aliemus. La prima \"Carica!\" o \"Ricarica!\" giocata ogni turno ha effetto due volte."
  },
  RelicConfig_131079_Desc = {
    Text = "All'Inizio del turno, Vortice ottiene [Arg1] Aliemus. La prima \"Carica!\" o \"Ricarica!\" giocata ogni turno ha effetto due volte."
  },
  RelicConfig_131079_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Vortice>"
  },
  RelicConfig_131080_BattleDesc = {
    Text = "All'inizio di ciascuno dei primi 3 turni, attiva \"Dilemma della Lontra\" una volta per turno. All'inizio del 5° turno, rimuovi tutti gli effetti negativi di \"Dilemma della Lontra\" e ottieni <DerivativeCardKeywords_135:\"SBERLA di Coalsie!\">."
  },
  RelicConfig_131080_Desc = {
    Text = "All'inizio di ciascuno dei primi 3 turni, attiva \"Dilemma della Lontra\" una volta per turno. All'inizio del 5° turno, rimuovi tutti gli effetti negativi di \"Dilemma della Lontra\" e ottieni <DerivativeCardKeywords_135:\"SBERLA di Coalsie!\">."
  },
  RelicConfig_131080_Name = {Text = "Coalsie II"},
  RelicConfig_131080_StoryDesc = {
    Text = [[
La signorina Vortice insiste che questa sia una Reliquia.
"Cattivo! Mordilo!"]]
  },
  RelicConfig_131178_BattleDesc = {
    Text = "A Inizio battaglia, Mischia una \"<DerivativeCardKeywords_134:Verità Proibita>\" nel mazzo. Pesca +[Arg1] ogni turno. Dopo aver giocato una Carta di comando, applica casualmente <ErosionColorInkKeywords:Distorsione Percettiva> a [Arg2] Carte di comando nella mano dell'avversario."
  },
  RelicConfig_131178_Desc = {
    Text = "A Inizio battaglia, Mischia una \"<DerivativeCardKeywords_134:Verità Proibita>\" nel mazzo. Pesca +[Arg1] ogni turno. Dopo aver giocato una Carta di comando, applica casualmente <ErosionColorInkKeywords:Distorsione Percettiva> a [Arg2] Carte di comando nella mano dell'avversario."
  },
  RelicConfig_131178_Name = {
    Text = "Appunti di Ogai"
  },
  RelicConfig_131178_StoryDesc = {
    Text = "Il registro contiene 70 numeri primi di Mason."
  },
  RelicConfig_132540_BattleDesc = {
    Text = "Immunità ai Danni"
  },
  RelicConfig_132540_Name = {
    Text = "Artefatto test raccolta"
  },
  RelicConfig_13740_BattleDesc = {
    Text = "Prob. di critico +15%. Se gli HP sono inferiori al 25% ([Arg1]) a inizio turno, prob. di critico ulteriore +30% per quel turno."
  },
  RelicConfig_13740_Desc = {
    Text = "Prob. di critico +15%. Se gli HP sono inferiori al 25% a inizio turno, prob. di critico ulteriore +30% per quel turno."
  },
  RelicConfig_13740_Name = {
    Text = "<OrangeQuality:Astrolabio Celeste>"
  },
  RelicConfig_13740_StoryDesc = {
    Text = "Le meraviglie dell'universo."
  },
  RelicConfig_13741_BattleDesc = {
    Text = "Danno Crit. +15%. Colpo Critico garantito contro i nemici con Scudo del Personaggio."
  },
  RelicConfig_13741_Desc = {
    Text = "Danno Crit. +15%. Colpo Critico garantito contro i nemici con Scudo del Personaggio."
  },
  RelicConfig_13741_Name = {
    Text = "<WhiteQuality:Principi dell'Estetica>"
  },
  RelicConfig_13741_StoryDesc = {
    Text = "Scultore di cera: l'assistente del dottore, il patrono del becchino e il fornitore dei vermi della fossa."
  },
  RelicConfig_13742_BattleDesc = {
    Text = "Danno Crit. +50%. Ogni terzo attacco è garantito essere un Colpo Critico."
  },
  RelicConfig_13742_Desc = {
    Text = "Danno Crit. +50%. Ogni terzo attacco è garantito essere un Colpo Critico."
  },
  RelicConfig_13742_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Meditazione\">"
  },
  RelicConfig_13743_BattleDesc = {
    Text = "All'inizio del turno, il Risveglio con il valore più basso di Aliemus guadagna 15 Aliemus. Quando 2 carte vengono giocate consecutivamente con un Costo di Arithmetica inferiore rispetto alla carta precedente, il Risveglio con il valore più basso di Aliemus guadagna 15 Aliemus."
  },
  RelicConfig_13743_Desc = {
    Text = "All'inizio del turno, il Risveglio con il valore più basso di Aliemus guadagna 15 Aliemus. Quando 2 carte vengono giocate consecutivamente con un Costo di Arithmetica inferiore rispetto alla carta precedente, il Risveglio con il valore più basso di Aliemus guadagna 15 Aliemus."
  },
  RelicConfig_13743_Name = {
    Text = "<OrangeQuality:Reliquia Arcana>"
  },
  RelicConfig_13743_StoryDesc = {
    Text = "La Fine del Fato"
  },
  RelicConfig_13744_BattleDesc = {
    Text = "Il Risveglio con il valore più basso di Aliemus guadagna 15 Aliemus dopo l'inizio del turno."
  },
  RelicConfig_13744_Desc = {
    Text = "Il Risveglio con il valore più basso di Aliemus guadagna 15 Aliemus dopo l'inizio del turno."
  },
  RelicConfig_13744_Name = {
    Text = "<WhiteQuality:Gemelli da Polso all'Alloro>"
  },
  RelicConfig_13744_StoryDesc = {
    Text = [[
Gemelli da polso in argento incisi con motivi di foglie di osmanto.
Finemente lavorati e scintillanti, un tempo incarnavano l'amicizia di due fanciulli.]]
  },
  RelicConfig_13745_BattleDesc = {
    Text = "L'effetto del bonus del Reame raccomandato è aumentato del 50% e il tuo Tasso di Orison Fortunato raddoppia all'inizio del livello."
  },
  RelicConfig_13745_Desc = {
    Text = "L'effetto del bonus del Reame raccomandato è aumentato del 50% e il tuo Tasso di Orison Fortunato raddoppia all'inizio del livello."
  },
  RelicConfig_13745_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Sonno Profondo\">"
  },
  RelicConfig_13747_BattleDesc = {
    Text = "Immune alla morte una volta, recupera istantaneamente il 10% dei PV dopo l'attivazione, permanentemente disabilitata dopo 3 attivazioni."
  },
  RelicConfig_13747_Desc = {
    Text = "Immune alla morte una volta, recupera istantaneamente il 10% dei PV dopo l'attivazione, permanentemente disabilitata dopo 3 attivazioni."
  },
  RelicConfig_13747_Name = {
    Text = "<WhiteQuality:☆Pacco di Razioni☆>"
  },
  RelicConfig_13747_StoryDesc = {
    Text = "Mangialo solo come ultima, disperata risorsa."
  },
  RelicConfig_13748_BattleDesc = {
    Text = "All'inizio della battaglia, tutte le carte con un Costo di Arithmetica attuale pari a 1 ottengono +[Arg1] DAN e +[Arg2] generazione di Scudo del Personaggio per questa battaglia."
  },
  RelicConfig_13748_Desc = {
    Text = "All'inizio della battaglia, tutte le carte con un Costo di Arithmetica attuale pari a 1 ottengono +[Arg1] DAN e +[Arg2] generazione di Scudo del Personaggio per questa battaglia."
  },
  RelicConfig_13748_Name = {
    Text = "<OrangeQuality:Mary la Pura>"
  },
  RelicConfig_13748_StoryDesc = {
    Text = "La logica è come un cocktail: troppa ne diminuisce i benefici."
  },
  RelicConfig_13749_BattleDesc = {
    Text = "Ogni 4 turni, raddoppia il Danno Attivo e da Tentacolo subito da tutti i nemici in quel turno. Tuttavia, dopo aver attivato Esaltazione in quel turno, sigilla tutti i Risvegliatori per 1 turno."
  },
  RelicConfig_13749_Desc = {
    Text = "Ogni 4 turni, raddoppia il Danno Attivo e da Tentacolo subito da tutti i nemici in quel turno. Tuttavia, dopo aver attivato Esaltazione in quel turno, sigilla tutti i Risvegliatori per 1 turno."
  },
  RelicConfig_13749_Name = {
    Text = "<RedQuality:Resti del Viandante>"
  },
  RelicConfig_13749_StoryDesc = {
    Text = [[
Un frammento sacro.
Sebbene si sia separato dal corpo, le sue impronte si sono propagate per il mondo.]]
  },
  RelicConfig_13750_BattleDesc = {
    Text = "A fine turno, se non è presente alcuno scudo, ottieni 1 accumulo di <ParcloseIconKeywords:Barriera> che garantisce immunità a un'istanza di DAN. Questo effetto si attiva solo una volta per battaglia."
  },
  RelicConfig_13750_Desc = {
    Text = "A fine turno, se non è presente alcuno scudo, ottieni 1 accumulo di <ParcloseIconKeywords:Barriera> che garantisce immunità a un'istanza di DAN. Questo effetto si attiva solo una volta per battaglia."
  },
  RelicConfig_13750_Name = {
    Text = "<WhiteQuality:☆Compresse analgesiche☆>"
  },
  RelicConfig_13750_StoryDesc = {
    Text = "L'effetto non è una soluzione definitiva."
  },
  RelicConfig_13751_BattleDesc = {
    Text = "Prob. di critico +25%; raddoppia il primo danno inflitto ogni turno."
  },
  RelicConfig_13751_Desc = {
    Text = "Prob. di critico +25%; raddoppia il primo danno inflitto ogni turno."
  },
  RelicConfig_13751_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Approfondimento\">"
  },
  RelicConfig_13752_BattleDesc = {
    Text = "All'inizio del turno, ripristina [Arg1] PV. Se i PV sono inferiori al 50%, ripristina invece [Arg2] PV."
  },
  RelicConfig_13752_Desc = {
    Text = "All'inizio del turno, ripristina [Arg1] PV. Se i PV sono inferiori al 50%, ripristina invece [Arg2] PV."
  },
  RelicConfig_13752_Name = {
    Text = "<WhiteQuality:Sangue Benedetto>"
  },
  RelicConfig_13752_StoryDesc = {
    Text = "È dolce e vellutato, con una fragranza di rose."
  },
  RelicConfig_13753_BattleDesc = {
    Text = "Questa è una reliquia di missione senza alcun effetto."
  },
  RelicConfig_13753_Desc = {
    Text = "Questa è una reliquia di missione senza alcun effetto."
  },
  RelicConfig_13753_Name = {
    Text = "Test Reliquia di Missione"
  },
  RelicConfig_13753_StoryDesc = {
    Text = "Una reliquia che richiede contenuti aggiuntivi"
  },
  RelicConfig_13754_BattleDesc = {
    Text = "Il tuo quinto attacco infligge sempre Danno Crit."
  },
  RelicConfig_13754_Desc = {
    Text = "Il tuo quinto attacco infligge sempre Danno Crit."
  },
  RelicConfig_13754_Name = {
    Text = "<WhiteQuality:Correttore Visivo>"
  },
  RelicConfig_13754_StoryDesc = {
    Text = "Qualcuno un tempo scoprì la verità attraverso di esso."
  },
  RelicConfig_13755_BattleDesc = {
    Text = "A inizio turno, per ogni carta nello <DimensionalSpaceIconKeywords:Spazio Ultra>, ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea. Se questo turno è un Turno Ultra, ottieni [Arg2] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_13755_Desc = {
    Text = "A inizio turno, per ogni carta nello <DimensionalSpaceIconKeywords:Spazio Ultra>, ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea. Se questo turno è un Turno Ultra, ottieni [Arg2] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_13755_Name = {
    Text = "<WhiteQuality:Prisma Trigonale>"
  },
  RelicConfig_13755_StoryDesc = {
    Text = "\"La luce è composta di sette colori.\""
  },
  RelicConfig_13756_BattleDesc = {
    Text = "Perdi tutte le altre reliquie al momento della raccolta. Ottieni casualmente 2 Reliquie Dorate."
  },
  RelicConfig_13756_Desc = {
    Text = "Perdi tutte le altre reliquie al momento della raccolta. Ottieni casualmente 2 Reliquie Dorate."
  },
  RelicConfig_13756_Name = {
    Text = "<RedQuality:☆Visione Inversa☆>"
  },
  RelicConfig_13756_StoryDesc = {
    Text = "Nella strana era, i fiori sono i principali spettatori dell'umanità.\nResta immobile; preferiscono le esibizioni silenziose."
  },
  RelicConfig_13757_BattleDesc = {
    Text = "Ogni 8ª Carta di comando giocata avrà effetto due volte."
  },
  RelicConfig_13757_Desc = {
    Text = "Ogni 8ª Carta di comando giocata avrà effetto due volte."
  },
  RelicConfig_13757_Name = {
    Text = "<OrangeQuality:Birra Stellare>"
  },
  RelicConfig_13757_StoryDesc = {
    Text = "Vagando tra le stelle."
  },
  RelicConfig_13758_BattleDesc = {
    Text = "Aumenta i PV massimi di [Arg1] quando raccolto e aumenta l'Aliemus guadagnato di 2 quando si subisce un attacco."
  },
  RelicConfig_13758_Desc = {
    Text = "Aumenta i PV massimi di [Arg1] quando raccolto e aumenta l'Aliemus guadagnato di 2 quando si subisce un attacco."
  },
  RelicConfig_13758_Name = {
    Text = "<WhiteQuality:Inchiostro dolce>"
  },
  RelicConfig_13758_StoryDesc = {
    Text = "C'è chi dice che questo sia il sangue del diavolo, ma ehi, provalo!"
  },
  RelicConfig_13759_BattleDesc = {
    Text = "Quando rilasci l'Esaltazione, per ogni istanza di DAN inflitta dai nemici, applica [Arg1] accumuli di <IntoxicationIconKeywords:Veleno>"
  },
  RelicConfig_13759_Desc = {
    Text = "Quando rilasci l'Esaltazione, per ogni istanza di DAN inflitta dai nemici, applica [Arg1] accumuli di <IntoxicationIconKeywords:Veleno>"
  },
  RelicConfig_13759_Name = {
    Text = "<WhiteQuality:☆Mandibola al Radio☆>"
  },
  RelicConfig_13759_StoryDesc = {
    Text = "Esposto nella sala privata di un collezionista.\nIl collezionista rimase ammaliato dalla sua splendida fluorescenza, ammirandolo giorno e notte, finché non avvizzì e divenne uno dei suoi simili."
  },
  RelicConfig_13760_BattleDesc = {
    Text = "Arithmetica massima +1. Quando giochi 2 carte consecutive con Costo di Arithmetica superiore a quello della carta precedente, ottieni 1 Arithmetica."
  },
  RelicConfig_13760_Desc = {
    Text = "Arithmetica massima +1. Quando giochi 2 carte consecutive con Costo di Arithmetica superiore a quello della carta precedente, ottieni 1 Arithmetica."
  },
  RelicConfig_13760_Name = {
    Text = "<OrangeQuality:Archivio Arcana>"
  },
  RelicConfig_13760_StoryDesc = {
    Text = "Il flusso del fato."
  },
  RelicConfig_13761_BattleDesc = {
    Text = "A inizio turno, se nel turno precedente sono rimaste più di 3 carte in mano, ottieni 2 Arithmetica."
  },
  RelicConfig_13761_Desc = {
    Text = "A inizio turno, se nel turno precedente sono rimaste più di 3 carte in mano, ottieni 2 Arithmetica."
  },
  RelicConfig_13761_Name = {
    Text = "<WhiteQuality:Insegna Mythag>"
  },
  RelicConfig_13761_StoryDesc = {
    Text = "Distintivi distribuiti agli Investigatori dall'Università di Mythag. Non solo simboleggiano l'identità di chi li indossa, ma fungono anche da strumenti per la comunicazione a distanza."
  },
  RelicConfig_13762_BattleDesc = {
    Text = "Gioca \"Difesa\" per ottenere [Arg1] <RetaliateIconKeywords:Contatore>."
  },
  RelicConfig_13762_Desc = {
    Text = "Gioca \"Difesa\" per ottenere [Arg1] <RetaliateIconKeywords:Contatore>."
  },
  RelicConfig_13762_Name = {
    Text = "Gilet d'Ortica Mutato"
  },
  RelicConfig_13762_StoryDesc = {
    Text = "Impossibile identificare il liquido che è stato contaminato."
  },
  RelicConfig_13763_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni [Arg1] Scudo del Personaggio. Se possiedi Scudo del Personaggio all'inizio del tuo turno, Scudo del Personaggio e Amp. di Guarigione +50% per quel turno."
  },
  RelicConfig_13763_Desc = {
    Text = "All'inizio della battaglia, ottieni [Arg1] Scudo del Personaggio. Se possiedi Scudo del Personaggio all'inizio del tuo turno, Scudo del Personaggio e Amp. di Guarigione +50% per quel turno."
  },
  RelicConfig_13763_Name = {
    Text = "Guardiano del Giardino Alienato"
  },
  RelicConfig_13764_BattleDesc = {
    Text = "Ottieni permanentemente [Arg1] <PowerIconKeywords:FOR>."
  },
  RelicConfig_13764_Desc = {
    Text = "Ottieni permanentemente [Arg1] <PowerIconKeywords:FOR>."
  },
  RelicConfig_13764_Name = {
    Text = "<WhiteQuality:Spilla di Rubino>"
  },
  RelicConfig_13764_StoryDesc = {
    Text = "Un accenno di rosso vivo traspare."
  },
  RelicConfig_13766_BattleDesc = {
    Text = "Al momento della raccolta, scegli una carta e applicale due effetti di potenziamento a tre scelte. (Nota: simile alla creazione di carte di Mille Miraggi)"
  },
  RelicConfig_13766_Desc = {
    Text = "Al momento della raccolta, scegli una carta e applicale due effetti di potenziamento a tre scelte. (Nota: simile alla creazione di carte di Mille Miraggi)"
  },
  RelicConfig_13766_Name = {
    Text = "<OrangeQuality:☆Macchina da Scrivere d'Autore☆>"
  },
  RelicConfig_13766_StoryDesc = {
    Text = "Si mormora che il vero autore del capolavoro sia in realtà la macchina da scrivere."
  },
  RelicConfig_13767_BattleDesc = {
    Text = "Al momento della raccolta, ottieni 1 tra 3 Orazioni avanzate casuali e assegnala alla carta corrispondente."
  },
  RelicConfig_13767_Desc = {
    Text = "Al momento della raccolta, ottieni 1 tra 3 Orazioni avanzate casuali e assegnala alla carta corrispondente."
  },
  RelicConfig_13767_Name = {
    Text = "<WhiteQuality:Papiro di Rhind>"
  },
  RelicConfig_13767_StoryDesc = {
    Text = "Ecco la domanda: 10 monaci si dividono 6 pagnotte. Quanto riceve ciascun monaco?"
  },
  RelicConfig_13768_BattleDesc = {
    Text = "L'Arithmetica massima aumenta di 2. Dopo aver giocato \"Attacco\" o \"Difesa\", il Risvegliatore corrispondente ottiene 5 Aliemus. Dopo aver rilasciato l'Esaltazione, ottieni 1 \"Attacco\" del Risvegliatore corrispondente con Consumo e Fugace applicati. Dopo aver rilasciato il Seguito, ottieni casualmente una \"Difesa\" con Consumo e Fugace."
  },
  RelicConfig_13768_Desc = {
    Text = "L'Arithmetica massima aumenta di 2. Dopo aver giocato \"Attacco\" o \"Difesa\", il Risvegliatore corrispondente ottiene 5 Aliemus. Dopo aver rilasciato l'Esaltazione, ottieni 1 \"Attacco\" del Risvegliatore corrispondente con Consumo e Fugace applicati. Dopo aver rilasciato il Seguito, ottieni casualmente una \"Difesa\" con Consumo e Fugace."
  },
  RelicConfig_13768_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Ali\">"
  },
  RelicConfig_13769_BattleDesc = {
    Text = "A inizio turno, <EmbryoFusionIconKeywords:Fusione Embrionale>+30. Tutti i tuoi effetti <DevouredIconKeywords:Divorare> diventano <UnlimitedDevouredIconKeywords:Divorazione Infinita>."
  },
  RelicConfig_13769_Desc = {
    Text = "A inizio turno, <EmbryoFusionIconKeywords:Fusione Embrionale>+30. Tutti i tuoi effetti <DevouredIconKeywords:Divorare> diventano <UnlimitedDevouredIconKeywords:Divorazione Infinita>."
  },
  RelicConfig_13769_Name = {
    Text = "<RedQuality:Cordone Strisciante>"
  },
  RelicConfig_13769_StoryDesc = {
    Text = "Avvinghiarsi al collo."
  },
  RelicConfig_13770_BattleDesc = {
    Text = "Ottieni [Arg1] Scudo a inizio turno, aumentando di [Arg2] per turno."
  },
  RelicConfig_13770_Desc = {
    Text = "Ottieni [Arg1] Scudo a inizio turno, aumentando di [Arg2] per turno."
  },
  RelicConfig_13770_Name = {
    Text = "<WhiteQuality:Mano Protettrice>"
  },
  RelicConfig_13770_StoryDesc = {
    Text = "La mano che prega, il pugno che resta irremovibile."
  },
  RelicConfig_13771_BattleDesc = {
    Text = "La Rigenerazione Keyflare di tutti i Risvegliatori è aumentata di 30. Dopo aver rilasciato il Gruppo, mischia 3 <DerivativeCardKeywords_4:\"Intuizione\"> nel tuo mazzo."
  },
  RelicConfig_13771_Desc = {
    Text = "La Rigenerazione Keyflare di tutti i Risvegliatori è aumentata di 30. Dopo aver rilasciato il Gruppo, mischia 3 <DerivativeCardKeywords_4:\"Intuizione\"> nel tuo mazzo."
  },
  RelicConfig_13771_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Dormiveglia\">"
  },
  RelicConfig_13772_BattleDesc = {
    Text = "Dopo la battaglia, ottieni 75 Sigilli Neri aggiuntivi e 1 Carta sintomo."
  },
  RelicConfig_13772_Desc = {
    Text = "Dopo la battaglia, ottieni 75 Sigilli Neri aggiuntivi e 1 Carta sintomo."
  },
  RelicConfig_13772_Name = {
    Text = "<RedQuality:Impronta di Giada>"
  },
  RelicConfig_13772_StoryDesc = {
    Text = "Questa impronta sopporta i millenni senza decomposizione."
  },
  RelicConfig_13773_BattleDesc = {
    Text = "Per ogni istanza di Danno attivo inflitta, infliggi [Arg1] accumuli di <BleedingIconKeywords:Salasso> a te stesso e [Arg2] accumuli di <BleedingIconKeywords:Salasso> al bersaglio. Per ogni nemico ucciso, dissolvi lo stato di <BleedingIconKeywords:Salasso> da te stesso."
  },
  RelicConfig_13773_Desc = {
    Text = "Per ogni istanza di Danno attivo inflitta, infliggi [Arg1] accumuli di <BleedingIconKeywords:Salasso> a te stesso e [Arg2] accumuli di <BleedingIconKeywords:Salasso> al bersaglio. Per ogni nemico ucciso, dissolvi lo stato di <BleedingIconKeywords:Salasso> da te stesso."
  },
  RelicConfig_13773_Name = {
    Text = "<RedQuality:Mente dello Sciame>"
  },
  RelicConfig_13773_StoryDesc = {
    Text = "Intrecciare, Simbiosi, Sciame; Paura, Creatura Sconosciuta, Controllo."
  },
  RelicConfig_13774_BattleDesc = {
    Text = "Quando giochi una carta con un Costo di Arithmetica effettivo di 3, pesca 1 carta e ottieni 2 Arithmetica; quando giochi una carta con un Costo di Arithmetica effettivo di 4 o più, riduci di 1 il Costo di Arithmetica delle altre carte nella tua mano."
  },
  RelicConfig_13774_Desc = {
    Text = "Quando giochi una carta con un Costo di Arithmetica effettivo di 3, pesca 1 carta e ottieni 2 Arithmetica; quando giochi una carta con un Costo di Arithmetica effettivo di 4 o più, riduci di 1 il Costo di Arithmetica delle altre carte nella tua mano."
  },
  RelicConfig_13774_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Occhio\">"
  },
  RelicConfig_13775_BattleDesc = {
    Text = "Quando raccolto, scegli una Carta di comando per conferirle \"Innato\", \"Conservare\" e \"Pesca 1 carta dopo averla giocata\"."
  },
  RelicConfig_13775_Desc = {
    Text = "Quando raccolto, scegli una Carta di comando per conferirle \"Innato\", \"Conservare\" e \"Pesca 1 carta dopo averla giocata\"."
  },
  RelicConfig_13775_Name = {
    Text = "<WhiteQuality:Dossier>"
  },
  RelicConfig_13775_StoryDesc = {
    Text = "Shh, questo è un affare segreto tra te e me."
  },
  RelicConfig_13776_BattleDesc = {
    Text = "Ottieni 1 Tentacolo all'inizio della battaglia."
  },
  RelicConfig_13776_Desc = {
    Text = "Ottieni 1 Tentacolo all'inizio della battaglia."
  },
  RelicConfig_13776_Name = {
    Text = "<WhiteQuality:Lumachina Gialla>"
  },
  RelicConfig_13776_StoryDesc = {
    Text = "Questa piccola Lumachina Gialla proviene da nobili origini, con un lignaggio Primordiale perfetto e impeccabile."
  },
  RelicConfig_13777_BattleDesc = {
    Text = "Alla fine dei turni dispari, se rimane Arithmetica, pesca 2 carte extra nel turno successivo; alla fine dei turni pari, se rimangono carte, ottieni 2 Arithmetica extra nel turno successivo."
  },
  RelicConfig_13777_Desc = {
    Text = "Alla fine dei turni dispari, se rimane Arithmetica, pesca 2 carte extra nel turno successivo; alla fine dei turni pari, se rimangono carte, ottieni 2 Arithmetica extra nel turno successivo."
  },
  RelicConfig_13777_Name = {
    Text = "<OrangeQuality:Disco Solare>"
  },
  RelicConfig_13777_StoryDesc = {
    Text = "Indovina, è nero o bianco?"
  },
  RelicConfig_13778_BattleDesc = {
    Text = "Limite Tentacoli +1. Quando gli HP sono inferiori al 50%, <TentacleInjurieIconKeywords:Danno Tentacolo> +[Arg1]."
  },
  RelicConfig_13778_Desc = {
    Text = "Limite Tentacoli +1. Quando gli HP sono inferiori al 50%, <TentacleInjurieIconKeywords:Danno Tentacolo> +[Arg1]."
  },
  RelicConfig_13778_Name = {
    Text = "<OrangeQuality:Canto delle maree>"
  },
  RelicConfig_13778_StoryDesc = {
    Text = "Si dice che animali non commestibili come i buccini assorbano circa l'80% dei nutrienti dell'oceano"
  },
  RelicConfig_13779_BattleDesc = {
    Text = "Pesca 1 carta a inizio turno e puoi scegliere di conservare 1 carta in mano a fine turno."
  },
  RelicConfig_13779_Desc = {
    Text = "Pesca 1 carta a inizio turno e puoi scegliere di conservare 1 carta in mano a fine turno."
  },
  RelicConfig_13779_Name = {
    Text = "<OrangeQuality:Lampada del Profeta>"
  },
  RelicConfig_13779_StoryDesc = {
    Text = "Esaudisci il tuo desiderio."
  },
  RelicConfig_13780_BattleDesc = {
    Text = "Ogni volta che rilasci un'Esaltazione, ottieni 1 <DerivativeCardKeywords_7:\"Infusione Tossica\">. Se hai 3 <DerivativeCardKeywords_7:\"Infusione Tossica\"> nella tua mano, sintetizzale in un'<DerivativeCardKeywords_8:\"Esplosione Tossica\"> che attiva <IntoxicationIconKeywords:Veleno>."
  },
  RelicConfig_13780_Desc = {
    Text = "Ogni volta che rilasci un'Esaltazione, ottieni 1 <DerivativeCardKeywords_7:\"Infusione Tossica\">. Se hai 3 <DerivativeCardKeywords_7:\"Infusione Tossica\"> nella tua mano, sintetizzale in un'<DerivativeCardKeywords_8:\"Esplosione Tossica\"> che attiva <IntoxicationIconKeywords:Veleno>."
  },
  RelicConfig_13780_Name = {
    Text = "<OrangeQuality:Lingua Aliena>"
  },
  RelicConfig_13780_StoryDesc = {
    Text = "Non è un demone, eppure trasmette davvero sussurri provenienti da oltre il regno dei mortali."
  },
  RelicConfig_13781_BattleDesc = {
    Text = "Per ogni Sigillo Nero consumato, tutti i Risvegliatori ottengono 1 Aliemus."
  },
  RelicConfig_13781_Desc = {
    Text = "Per ogni Sigillo Nero consumato, tutti i Risvegliatori ottengono 1 Aliemus."
  },
  RelicConfig_13781_Name = {
    Text = "Fioritura Inversa"
  },
  RelicConfig_13782_BattleDesc = {
    Text = "Immunità ai Danni"
  },
  RelicConfig_13782_Desc = {
    Text = "Immunità ai Danni"
  },
  RelicConfig_13782_Name = {
    Text = "Reliquia di Prova"
  },
  RelicConfig_13783_BattleDesc = {
    Text = "Dopo aver giocato la 3ª carta ogni turno, colloca 1 <DerivativeCardKeywords_4:\"Intuizione\"> nella Pila degli scarti. Dopo aver giocato la 6ª carta ogni turno, colloca 1 <DerivativeCardKeywords_4:\"Intuizione\"> dalla Pila degli scarti nella mano."
  },
  RelicConfig_13783_Desc = {
    Text = "Dopo aver giocato la 3ª carta ogni turno, colloca 1 <DerivativeCardKeywords_4:\"Intuizione\"> nella Pila degli scarti. Dopo aver giocato la 6ª carta ogni turno, colloca 1 <DerivativeCardKeywords_4:\"Intuizione\"> dalla Pila degli scarti nella mano."
  },
  RelicConfig_13783_Name = {
    Text = "<WhiteQuality:Luce della Civiltà>"
  },
  RelicConfig_13783_StoryDesc = {
    Text = "Una meteora che solca il cielo notturno."
  },
  RelicConfig_13784_BattleDesc = {
    Text = "A inizio turno, ottieni 1 Arithmetica per ogni nemico. Quando un nemico viene ucciso da Danno attivo, infliggi <BleedingIconKeywords:Salasso> agli altri nemici pari al Danno in eccesso."
  },
  RelicConfig_13784_Desc = {
    Text = "A inizio turno, ottieni 1 Arithmetica per ogni nemico. Quando un nemico viene ucciso da Danno attivo, infliggi <BleedingIconKeywords:Salasso> agli altri nemici pari al Danno in eccesso."
  },
  RelicConfig_13784_Name = {
    Text = "<OrangeQuality:Canto della Folla>"
  },
  RelicConfig_13784_StoryDesc = {
    Text = "Progettato appositamente per tormentare le orecchie."
  },
  RelicConfig_13785_BattleDesc = {
    Text = "A fine turno, <EmbryoFusionIconKeywords:Fusione Embrionale> +15, se hai un <DerivativeCardKeywords_2:\"Embrione\"> in mano, ripristina [Arg1] Vita."
  },
  RelicConfig_13785_Desc = {
    Text = "A fine turno, <EmbryoFusionIconKeywords:Fusione Embrionale> +15, se hai un <DerivativeCardKeywords_2:\"Embrione\"> in mano, ripristina [Arg1] Vita."
  },
  RelicConfig_13785_Name = {
    Text = "<WhiteQuality:Referto della Pestilenza>"
  },
  RelicConfig_13785_StoryDesc = {
    Text = "Peste — una manifestazione inconscia e inquieta della natura."
  },
  RelicConfig_13786_BattleDesc = {
    Text = "Dopo aver rilasciato l'Esaltazione, ottieni [Arg1] <PowerIconKeywords:STR> Temporaneo."
  },
  RelicConfig_13786_Desc = {
    Text = "Dopo aver rilasciato l'Esaltazione, ottieni [Arg1] <PowerIconKeywords:STR> Temporaneo."
  },
  RelicConfig_13786_Name = {
    Text = "<WhiteQuality:Serratura di Ferro>"
  },
  RelicConfig_13786_StoryDesc = {
    Text = "Un lucchetto spesso e robusto, difficile da aprire senza una chiave.\nNaturalmente, questo non è nulla per un maestro ladro"
  },
  RelicConfig_13787_BattleDesc = {
    Text = "All'inizio del turno, infliggi [Arg1] <FixedDamage:DAN Puro> a un nemico casuale. Dopo aver giocato \"Colpo\" 7 volte in questa battaglia, il DAN inflitto cambierà a [Arg2]. Dopo aver giocato \"Colpo\" 21 volte, infliggi immediatamente [Arg3] <FixedDamage:DAN Puro> a tutti i nemici."
  },
  RelicConfig_13787_Desc = {
    Text = "All'inizio del turno, infliggi [Arg1] <FixedDamage:DAN Puro> a un nemico casuale. Dopo aver giocato \"Colpo\" 7 volte in questa battaglia, il DAN inflitto cambierà a [Arg2]. Dopo aver giocato \"Colpo\" 21 volte, infliggi immediatamente [Arg3] <FixedDamage:DAN Puro> a tutti i nemici."
  },
  RelicConfig_13787_Name = {
    Text = "<OrangeQuality:Puzzle Antico>"
  },
  RelicConfig_13787_StoryDesc = {
    Text = "L'opera d'arte, un tempo incastonata nella pesante cornice, manca di un pezzo dal giorno in cui fu esposta."
  },
  RelicConfig_13788_BattleDesc = {
    Text = "Limite Tentacoli ridotto di 2. A fine turno, tutti i Tentacoli attaccano ancora una volta."
  },
  RelicConfig_13788_Desc = {
    Text = "Limite Tentacoli ridotto di 2. A fine turno, tutti i Tentacoli attaccano ancora una volta."
  },
  RelicConfig_13788_Name = {
    Text = "<RedQuality:Agonia Sacra>"
  },
  RelicConfig_13788_StoryDesc = {
    Text = "Abbraccia l'agonia."
  },
  RelicConfig_13789_BattleDesc = {
    Text = "Ogni volta che il mazzo viene rimescolato, ottieni [Arg1] <PowerIconKeywords:FOR>."
  },
  RelicConfig_13789_Desc = {
    Text = "Ogni volta che il mazzo viene rimescolato, ottieni [Arg1] <PowerIconKeywords:FOR>."
  },
  RelicConfig_13789_Name = {
    Text = "<WhiteQuality:Pipa Piangente>"
  },
  RelicConfig_13789_StoryDesc = {
    Text = "È il frutto dell'Odio o il risultato della vendetta?"
  },
  RelicConfig_13790_BattleDesc = {
    Text = "Ogni spostamento sulla mappa conferisce 10 Sigilli Neri, ma aumenta lo Stress di 10 punti."
  },
  RelicConfig_13790_Desc = {
    Text = "Ogni spostamento sulla mappa conferisce 10 Sigilli Neri, ma aumenta lo Stress di 10 punti."
  },
  RelicConfig_13790_Name = {
    Text = "Borsa Senza Fondo"
  },
  RelicConfig_13791_BattleDesc = {
    Text = "Quando questa Reliquia viene raccolta, scegli una Carta di comando e aggiungine una copia al mazzo."
  },
  RelicConfig_13791_Desc = {
    Text = "Quando questa Reliquia viene raccolta, scegli una Carta di comando e aggiungine una copia al mazzo."
  },
  RelicConfig_13791_Name = {
    Text = "<WhiteQuality:Fuoco Effimero>"
  },
  RelicConfig_13791_StoryDesc = {
    Text = "Luce tremolante, speranza faint."
  },
  RelicConfig_13792_BattleDesc = {
    Text = "Ogni volta che perdi Vita, <EmbryoFusionIconKeywords:Fusione Embrionale>+10. L'effetto è raddoppiato se i tuoi Vita sono sotto il 50%."
  },
  RelicConfig_13792_Desc = {
    Text = "Ogni volta che perdi Vita, <EmbryoFusionIconKeywords:Fusione Embrionale>+10. L'effetto è raddoppiato se i tuoi Vita sono sotto il 50%."
  },
  RelicConfig_13792_Name = {
    Text = "<WhiteQuality:Sega Arrugginita>"
  },
  RelicConfig_13792_StoryDesc = {
    Text = "Il dottore anatomista trascorre la sua vita senza mai vedere una bella donna, solo sacchi d'ossa, nervi infiammati, muscoli e tessuti corrosi dalle malattie."
  },
  RelicConfig_13793_BattleDesc = {
    Text = "Quando raccolto, il Bottino di Sigilli della squadra diventa il 150% del valore originale. Dopo il Recupero PV, tutti i Risvegliatori ottengono 3 Aliemus; dopo aver perso PV, ottieni [Arg1] <PowerIconKeywords:FOR> e Danno Tentacolo, con un effetto combinato massimo di 5 volte per turno."
  },
  RelicConfig_13793_Desc = {
    Text = "Quando raccolto, il Bottino di Sigilli della squadra diventa il 150% del valore originale. Dopo il Recupero PV, tutti i Risvegliatori ottengono 3 Aliemus; dopo aver perso PV, ottieni [Arg1] <PowerIconKeywords:FOR> e Danno Tentacolo, con un effetto combinato massimo di 5 volte per turno."
  },
  RelicConfig_13793_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Luna\">"
  },
  RelicConfig_13794_BattleDesc = {
    Text = "Al termine del turno, tutti i Risvegliati ottengono 5 Aliemus. Per ogni Arithmetica rimanente, tutti i Risvegliati ottengono 3 Aliemus aggiuntivi."
  },
  RelicConfig_13794_Desc = {
    Text = "Al termine del turno, tutti i Risvegliati ottengono 5 Aliemus. Per ogni Arithmetica rimanente, tutti i Risvegliati ottengono 3 Aliemus aggiuntivi."
  },
  RelicConfig_13794_Name = {
    Text = "<OrangeQuality:Batteria Prototipo>"
  },
  RelicConfig_13794_StoryDesc = {
    Text = "Speranza Portatile"
  },
  RelicConfig_13795_BattleDesc = {
    Text = "Arithmetica massima aumentata di 1."
  },
  RelicConfig_13795_Desc = {
    Text = "Arithmetica massima aumentata di 1."
  },
  RelicConfig_13795_Name = {
    Text = "<WhiteQuality:Iniezione di Vitalità>"
  },
  RelicConfig_13795_StoryDesc = {
    Text = "Anche il fremito è una forma di vitalità."
  },
  RelicConfig_13796_BattleDesc = {
    Text = "Si potenzia a Reliquia d'Argento se gli HP sono inferiori al 50% alla fine della battaglia"
  },
  RelicConfig_13796_Desc = {
    Text = "Si potenzia a una Reliquia d'argento se i Vita sono sotto il 50% alla fine della battaglia."
  },
  RelicConfig_13796_Name = {
    Text = "Taccuino Logoro 2"
  },
  RelicConfig_13796_StoryDesc = {
    Text = "Un vecchio diario zeppo di inserti, tra cui mappe di Elworth, registri di esperimenti e lettere contrassegnate da D-segni triangolari.\nLa calligrafia all'inizio è ordinata e precisa, ma gradualmente diventa disordinata e caotica."
  },
  RelicConfig_13797_BattleDesc = {
    Text = "Gioca 3 carte Colpo per potenziare a Reliquia Dorata."
  },
  RelicConfig_13797_Desc = {
    Text = "Gioca 3 Carte Attacco per potenziare a una Reliquia d'oro."
  },
  RelicConfig_13797_Name = {
    Text = "Taccuino Logoro 1"
  },
  RelicConfig_13797_StoryDesc = {
    Text = "Un vecchio diario zeppo di inserti, tra cui mappe di Elworth, registri di esperimenti e lettere contrassegnate da D-segni triangolari.\nLa calligrafia all'inizio è ordinata e precisa, ma gradualmente diventa disordinata e caotica."
  },
  RelicConfig_13798_BattleDesc = {
    Text = "All'inizio della Battaglia, tutte le tue Carte Sintomo ottengono <NothingnessIconKeywords:Fugace>, e per ogni Carta Sintomo nel tuo mazzo, ottieni [Arg1] <PowerIconKeywords:FOR>."
  },
  RelicConfig_13798_Desc = {
    Text = "All'inizio della Battaglia, tutte le tue Carte Sintomo ottengono <NothingnessIconKeywords:Fugace>, e per ogni Carta Sintomo nel tuo mazzo, ottieni [Arg1] <PowerIconKeywords:FOR>."
  },
  RelicConfig_13798_Name = {
    Text = "<WhiteQuality:Elisir di Harford>"
  },
  RelicConfig_13798_StoryDesc = {
    Text = [[
Medicina dalla composizione sconosciuta.
Si dice che il rinomato violinista Eric ne sia particolarmente ghiotto.]]
  },
  RelicConfig_13799_BattleDesc = {
    Text = "All'inizio del primo turno di battaglia, aggiungi <DerivativeCardKeywords_1:\"Echi di Ombre Perdute\"> alla tua mano; al secondo turno, aggiungi <DerivativeCardKeywords_41:\"Risonanza della Chiave d'Argento\"> alla tua mano; al terzo turno, aggiungi <DerivativeCardKeywords_39:\"Echi del Passato\"> alla tua mano."
  },
  RelicConfig_13799_Desc = {
    Text = "All'inizio del primo turno di battaglia, aggiungi <DerivativeCardKeywords_1:\"Echi di Ombre Perdute\"> alla tua mano; al secondo turno, aggiungi <DerivativeCardKeywords_41:\"Risonanza della Chiave d'Argento\"> alla tua mano; al terzo turno, aggiungi <DerivativeCardKeywords_39:\"Echi del Passato\"> alla tua mano."
  },
  RelicConfig_13799_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Stelle\">"
  },
  RelicConfig_13800_BattleDesc = {
    Text = "All'inizio del turno, aggiungi 1 <DerivativeCardKeywords_6:\"Parasole\"> alla tua mano. Dopo aver giocato 6 carte, aumenta l'<AlertIconKeywords:Allerta> di tutti i <DerivativeCardKeywords_6:\"Parasole\"> nella tua mano di [Arg2]."
  },
  RelicConfig_13800_Desc = {
    Text = "All'inizio del turno, aggiungi 1 <DerivativeCardKeywords_6:\"Parasole\"> alla tua mano. Dopo aver giocato 6 carte, aumenta l'<AlertIconKeywords:Allerta> di tutti i <DerivativeCardKeywords_6:\"Parasole\"> nella tua mano di [Arg2]."
  },
  RelicConfig_13800_Name = {
    Text = "<WhiteQuality:Parasole del Viaggiatore>"
  },
  RelicConfig_13800_StoryDesc = {
    Text = "Fioritura nella Terra Senza Luce"
  },
  RelicConfig_13801_BattleDesc = {
    Text = "Aumenta gli HP di tutti i nemici del 30% nelle battaglie normali. Ottieni 25 Sigilli Neri extra in caso di vittoria."
  },
  RelicConfig_13801_Desc = {
    Text = "Aumenta gli HP di tutti i nemici del 30% nelle battaglie normali. Ottieni 25 Sigilli Neri extra in caso di vittoria."
  },
  RelicConfig_13801_Name = {
    Text = "Stendardo di Battaglia Logoro"
  },
  RelicConfig_13802_BattleDesc = {
    Text = "I PV massimi aumentano di [Arg1] quando raccolto. Se i PV sono sotto il 25% quando raccolto, l'aumento dei PV massimi diventa [Arg2]."
  },
  RelicConfig_13802_Desc = {
    Text = "I PV massimi aumentano di [Arg1] quando raccolto. Se i PV sono sotto il 25% quando raccolto, l'aumento dei PV massimi diventa [Arg2]."
  },
  RelicConfig_13802_Name = {
    Text = "<WhiteQuality:Tè di Ceylon>"
  },
  RelicConfig_13802_StoryDesc = {
    Text = "Un'alimentazione sana inizia da te e da me."
  },
  RelicConfig_13803_BattleDesc = {
    Text = "Ottieni 3 Tentacoli Temporanei ogni 3 turni."
  },
  RelicConfig_13803_Desc = {
    Text = "Ottieni 3 Tentacoli Temporanei ogni 3 turni."
  },
  RelicConfig_13803_Name = {
    Text = "<WhiteQuality:Elmo da sommozzatore>"
  },
  RelicConfig_13803_StoryDesc = {
    Text = "I sogni sono le stelle e il mare!"
  },
  RelicConfig_13804_BattleDesc = {
    Text = "Ottieni [Arg1] Scudo del Personaggio alla fine del tuo turno. Se il tuo Scudo del Personaggio è 0 o un multiplo di 3, ottieni [Arg2] <PowerIconKeywords:STR>."
  },
  RelicConfig_13804_Desc = {
    Text = "Ottieni [Arg1] Scudo del Personaggio alla fine del tuo turno. Se il tuo Scudo del Personaggio è 0 o un multiplo di 3, ottieni [Arg2] <PowerIconKeywords:STR>."
  },
  RelicConfig_13804_Name = {
    Text = "<OrangeQuality:Segnale di Soccorso>"
  },
  RelicConfig_13804_StoryDesc = {
    Text = "Non ha atteso i soccorsi."
  },
  RelicConfig_13806_BattleDesc = {
    Text = "Ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea quando peschi una Carta sintomo. Per ogni Reliquia maledetta in tuo possesso, il Tasso di Crit. e il Danno Crit. aumentano del 10%."
  },
  RelicConfig_13806_Desc = {
    Text = "Ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea quando peschi una Carta sintomo. Per ogni Reliquia maledetta in tuo possesso, il Tasso di Crit. e il Danno Crit. aumentano del 10%."
  },
  RelicConfig_13806_Name = {
    Text = "<OrangeQuality:Legame Abissale>"
  },
  RelicConfig_13806_StoryDesc = {
    Text = "Nella desolazione della periferia, un telefono squilla nella cabina solitaria.\n\"Oscurità... ssss... infinita... ssssss... Oscurità...\""
  },
  RelicConfig_13807_BattleDesc = {
    Text = "A inizio battaglia, <EmbryoFusionIconKeywords:Fusione Embrionale>+50. Per ogni Risvegliatore con almeno 50 Aliemus, si attiva 1 volta aggiuntiva."
  },
  RelicConfig_13807_Desc = {
    Text = "A inizio battaglia, <EmbryoFusionIconKeywords:Fusione Embrionale>+50. Per ogni Risvegliatore con almeno 50 Aliemus, si attiva 1 volta aggiuntiva."
  },
  RelicConfig_13807_Name = {
    Text = "<WhiteQuality:Caro Tesoro>"
  },
  RelicConfig_13807_StoryDesc = {
    Text = "Il falegname costruì per sua moglie un burattino incredibilmente realistico, che avrebbe preso il posto del figlio, riposando nel suo grembo."
  },
  RelicConfig_13808_BattleDesc = {
    Text = "Dopo aver rilasciato l'Esaltazione, aggiungi alla tua mano una carta casuale corrispondente al Risveglio. La carta ottiene <DepleteIconKeywords:Consumo> e <NothingnessIconKeywords:Fleeting>. Al termine della battaglia, ripristina [Arg1] PV."
  },
  RelicConfig_13808_Desc = {
    Text = "Dopo aver rilasciato l'Esaltazione, aggiungi alla tua mano una carta casuale corrispondente al Risveglio. La carta ottiene <DepleteIconKeywords:Consumo> e <NothingnessIconKeywords:Fleeting>. Al termine della battaglia, ripristina [Arg1] PV."
  },
  RelicConfig_13808_Name = {
    Text = "<WhiteQuality:Valigetta del dottore>"
  },
  RelicConfig_13808_StoryDesc = {
    Text = "Una valigetta che simboleggia l'identità di un dottore, molto pesante.\nAprirla non garantisce che appartenga a un vero dottore."
  },
  RelicConfig_13809_BattleDesc = {
    Text = "Tutti i prezzi delle Reliquie ridotti di 20."
  },
  RelicConfig_13809_Desc = {
    Text = "Tutti i prezzi delle Reliquie ridotti di 20."
  },
  RelicConfig_13809_Name = {
    Text = "<WhiteQuality:Lingua d'Argento>"
  },
  RelicConfig_13809_StoryDesc = {
    Text = "Non solo i mercanti sono eloquenti, ma anche i devoti."
  },
  RelicConfig_13811_BattleDesc = {
    Text = "Ogni 3a volta che \"Colpo\" viene giocato, infliggi [Arg1] <FixedDamage:DAN Puro> a tutti i nemici. Il Risvegliatore corrispondente ottiene 15 Aliemus."
  },
  RelicConfig_13811_Desc = {
    Text = "Ogni 3a volta che \"Colpo\" viene giocato, infliggi [Arg1] <FixedDamage:DAN Puro> a tutti i nemici. Il Risvegliatore corrispondente ottiene 15 Aliemus."
  },
  RelicConfig_13811_Name = {
    Text = "<WhiteQuality:Bisturi Arrugginito>"
  },
  RelicConfig_13811_StoryDesc = {
    Text = "Non adatto a tagliare tessuti vivi."
  },
  RelicConfig_13812_BattleDesc = {
    Text = "Aumenta i PV massimi del 100% quando raccolto. Perdi [Arg1] PV all'inizio del turno."
  },
  RelicConfig_13812_Desc = {
    Text = "Aumenta i PV massimi del 100% quando raccolto. Perdi [Arg1] PV all'inizio del turno."
  },
  RelicConfig_13812_Name = {
    Text = "<RedQuality:☆Carne dell'Immortale☆>"
  },
  RelicConfig_13812_StoryDesc = {
    Text = "\"Le creature marine spesso si amputano gli arti per sopravvivere.\""
  },
  RelicConfig_13813_BattleDesc = {
    Text = "All'inizio della battaglia, gli PV attuali dei nemici élite e boss sono ridotti del 20%."
  },
  RelicConfig_13813_Desc = {
    Text = "All'inizio della battaglia, gli PV attuali dei nemici élite e boss sono ridotti del 20%."
  },
  RelicConfig_13813_Name = {
    Text = "<WhiteQuality:☆Ancora Antica☆>"
  },
  RelicConfig_13813_StoryDesc = {
    Text = "Torna al focolare, mio vecchio marinaio."
  },
  RelicConfig_13814_BattleDesc = {
    Text = "A fine turno, per ogni carta non giocata in mano, tutti i Risvegliatori ottengono 2 Aliemus."
  },
  RelicConfig_13814_Desc = {
    Text = "A fine turno, per ogni carta non giocata in mano, tutti i Risvegliatori ottengono 2 Aliemus."
  },
  RelicConfig_13814_Name = {
    Text = "<WhiteQuality:Bilancia squilibrata>"
  },
  RelicConfig_13814_StoryDesc = {
    Text = "Non simboleggia più la giustizia."
  },
  RelicConfig_13815_BattleDesc = {
    Text = "Al momento della raccolta, scegli una carta per ridurre permanentemente il suo Costo di Arithmetica a 1."
  },
  RelicConfig_13815_Desc = {
    Text = "Al momento della raccolta, scegli una carta per ridurre permanentemente il suo Costo di Arithmetica a 1."
  },
  RelicConfig_13815_Name = {
    Text = "<WhiteQuality:☆Protesi Raffinata☆>"
  },
  RelicConfig_13815_StoryDesc = {
    Text = "Un occhio che non è più puro."
  },
  RelicConfig_13816_BattleDesc = {
    Text = "All'inizio della battaglia, tutti i nemici ottengono [Arg1] <RetaliateIconKeywords:Contatore>. Ogni volta che vengono inflitti DAN, il Risvegliato con meno Aliemus ottiene 6 Aliemus."
  },
  RelicConfig_13816_Desc = {
    Text = "All'inizio della battaglia, tutti i nemici ottengono [Arg1] <RetaliateIconKeywords:Contatore>. Ogni volta che vengono inflitti DAN, il Risvegliato con meno Aliemus ottiene 6 Aliemus."
  },
  RelicConfig_13816_Name = {
    Text = "<RedQuality:☆Campana del Lamento☆>"
  },
  RelicConfig_13816_StoryDesc = {
    Text = [[
Din, din, il bimbo piange;
Din, din, il bimbo grida.
Din, din, il bimbo si lamenta;
Din, din, ha fame, lo sai.]]
  },
  RelicConfig_13817_BattleDesc = {
    Text = "Ogni 6 Carte di Comando giocate, <TentacleInjurieIconKeywords:Danno Tentacolo> +[Arg1]."
  },
  RelicConfig_13817_Desc = {
    Text = "Ogni 6 Carte di Comando giocate, <TentacleInjurieIconKeywords:Danno Tentacolo> +[Arg1]."
  },
  RelicConfig_13817_Name = {
    Text = "<WhiteQuality:Verme Spargano>"
  },
  RelicConfig_13817_StoryDesc = {
    Text = "Finché il nostro cervello resta un mistero, non è poi così grave se è pieno di tentacoli."
  },
  RelicConfig_13818_BattleDesc = {
    Text = "Il Tasso di Crit. aumenta del 50%, ma all'inizio della battaglia, infliggi <FragileIconKeywords:Fragile> a te stesso per 3 turni."
  },
  RelicConfig_13818_Desc = {
    Text = "Il Tasso di Crit. aumenta del 50%, ma all'inizio della battaglia, infliggi <FragileIconKeywords:Fragile> a te stesso per 3 turni."
  },
  RelicConfig_13818_Name = {
    Text = "<RedQuality:Uncino Sinistro>"
  },
  RelicConfig_13818_StoryDesc = {
    Text = "Specie difficili da identificare."
  },
  RelicConfig_13819_BattleDesc = {
    Text = "Quando giochi una carta con un Costo di Arithmetica pari o superiore a 3, peschi 1 carta e ottieni 1 Arithmetica."
  },
  RelicConfig_13819_Desc = {
    Text = "Quando giochi una carta con un Costo di Arithmetica pari o superiore a 3, peschi 1 carta e ottieni 1 Arithmetica."
  },
  RelicConfig_13819_Name = {
    Text = "<OrangeQuality:☆Bellezza nella perdita☆>"
  },
  RelicConfig_13819_StoryDesc = {
    Text = "Nessuno ricorda più la sua bellezza."
  },
  RelicConfig_13820_BattleDesc = {
    Text = "Ogni volta che sviluppi un Sintomo, aumenta i PV massimi di [Arg1]."
  },
  RelicConfig_13820_Desc = {
    Text = "Ogni volta che sviluppi un Sintomo, aumenta i PV massimi di [Arg1]."
  },
  RelicConfig_13820_Name = {
    Text = "<WhiteQuality:☆Composto d'Incenso☆>"
  },
  RelicConfig_13820_StoryDesc = {
    Text = "\"Un aroma dolce e seducente.\""
  },
  RelicConfig_13821_BattleDesc = {
    Text = "Dopo aver rilasciato un'Esaltazione, pesca 1 carta. Se i PV sono inferiori al 25%, pesca una carta aggiuntiva."
  },
  RelicConfig_13821_Desc = {
    Text = "Dopo aver rilasciato un'Esaltazione, pesca 1 carta. Se i PV sono inferiori al 25%, pesca una carta aggiuntiva."
  },
  RelicConfig_13821_Name = {
    Text = "<OrangeQuality:Ruota della Conoscenza>"
  },
  RelicConfig_13821_StoryDesc = {
    Text = "Si prega di leggere con cautela."
  },
  RelicConfig_13822_BattleDesc = {
    Text = "Ogni turno, quando si infligge Danno Attivo, aumenta di [Arg1] il <TentacleInjurieIconKeywords:Danno Tentacolo> Temporaneo, fino a 3 volte. Quando la pila è completa, genera 1 Tentacolo Temporaneo che ignora il Limite Tentacoli."
  },
  RelicConfig_13822_Desc = {
    Text = "Ogni turno, quando si infligge Danno Attivo, aumenta di [Arg1] il <TentacleInjurieIconKeywords:Danno Tentacolo> Temporaneo, fino a 3 volte. Quando la pila è completa, genera 1 Tentacolo Temporaneo che ignora il Limite Tentacoli."
  },
  RelicConfig_13822_Name = {
    Text = "<OrangeQuality:Delizia Lemuriana>"
  },
  RelicConfig_13822_StoryDesc = {
    Text = "Il Signore del Riposo Eterno ti attende nei tuoi sogni."
  },
  RelicConfig_13823_BattleDesc = {
    Text = "La tua [Arg1]ª Carta di comando giocata ogni turno si attiva due volte e ritorna nella tua mano."
  },
  RelicConfig_13823_Desc = {
    Text = "La tua [Arg1]ª Carta di comando giocata ogni turno si attiva due volte e ritorna nella tua mano."
  },
  RelicConfig_13823_Name = {
    Text = "<OrangeQuality:Birra Stellare+>"
  },
  RelicConfig_13823_StoryDesc = {
    Text = "Vagando tra le stelle."
  },
  RelicConfig_13824_BattleDesc = {
    Text = "All'inizio del turno, la <DeathResistanceIconKeywords:Resistenza alla Morte> aumenta del 10% (ogni volta che la Resistenza alla Morte si attiva in questo livello, la Resistenza alla Morte ottenuta viene dimezzata). Quando la <DeathResistanceIconKeywords:Resistenza alla Morte> supera il 100%, la <ProficientInRealmsIconKeywords:Padronanza del Reame> aumenta di 100."
  },
  RelicConfig_13824_Desc = {
    Text = "All'inizio del turno, la <DeathResistanceIconKeywords:Resistenza alla Morte> aumenta del 10% (ogni volta che la Resistenza alla Morte si attiva in questo livello, la Resistenza alla Morte ottenuta viene dimezzata). Quando la <DeathResistanceIconKeywords:Resistenza alla Morte> supera il 100%, la <ProficientInRealmsIconKeywords:Padronanza del Reame> aumenta di 100."
  },
  RelicConfig_13824_Name = {
    Text = "<WhiteQuality:Lacrima di Sirena>"
  },
  RelicConfig_13824_StoryDesc = {
    Text = "Non immergerlo nell'acqua."
  },
  RelicConfig_13825_BattleDesc = {
    Text = "Ogni 10 Sigilli Neri consumati, ripristina [Arg1] HP."
  },
  RelicConfig_13825_Desc = {
    Text = "Ogni 10 Sigilli Neri consumati, ripristina l'1% degli HP."
  },
  RelicConfig_13825_Name = {
    Text = "Radice Inversa"
  },
  RelicConfig_13826_BattleDesc = {
    Text = "Quando giochi una Carta potenziamento, una Carta sintomo o una Carta di stato, il Risvegliato con l'Aliemus più basso guadagna 10 Aliemus."
  },
  RelicConfig_13826_Desc = {
    Text = "Quando giochi una Carta potenziamento, una Carta sintomo o una Carta di stato, il Risvegliato con l'Aliemus più basso guadagna 10 Aliemus."
  },
  RelicConfig_13826_Name = {
    Text = "<WhiteQuality:Album di Francobolli Stranieri>"
  },
  RelicConfig_13826_StoryDesc = {
    Text = "Nostalgia quantificata."
  },
  RelicConfig_13827_BattleDesc = {
    Text = "Al momento della raccolta, ottieni 75 Sigillo Nero. Scegli 1 Reliquia per trasformarla in una Reliquia maledetta casuale."
  },
  RelicConfig_13827_Desc = {
    Text = "Al momento della raccolta, ottieni 75 Sigillo Nero. Scegli 1 Reliquia per trasformarla in una Reliquia maledetta casuale."
  },
  RelicConfig_13827_Name = {
    Text = "<RedQuality:Stele Maledetta>"
  },
  RelicConfig_13827_StoryDesc = {
    Text = "Hai udito il richiamo del Mare profondo sfiorando questa stele."
  },
  RelicConfig_13828_BattleDesc = {
    Text = "Quando una Carta di comando entra per la prima volta nella Pila degli scarti ogni turno, mischia una copia Temporanea con Costo di Arithmetica ridotto di 1 nel mazzo di pesca."
  },
  RelicConfig_13828_Desc = {
    Text = "Quando una Carta di comando entra per la prima volta nella Pila degli scarti ogni turno, mischia una copia Temporanea con Costo di Arithmetica ridotto di 1 nel mazzo di pesca."
  },
  RelicConfig_13828_Name = {
    Text = "<WhiteQuality:Jukebox muto>"
  },
  RelicConfig_13828_StoryDesc = {
    Text = "La sua voce svanì nel vento."
  },
  RelicConfig_13829_BattleDesc = {
    Text = "Un mazzo di chiavi arrugginite. Può essere usato per aprire le porte."
  },
  RelicConfig_13829_Desc = {
    Text = "Un mazzo di chiavi arrugginite. Può essere usato per aprire le porte."
  },
  RelicConfig_13829_Name = {
    Text = "Chiave arrugginita"
  },
  RelicConfig_13830_BattleDesc = {
    Text = "Quando si causa Recupero PV, ottieni anche [Arg1] Scudo del Personaggio. Dopo l'inizio del 3° turno, ottieni [Arg2] <AlertIconKeywords:Allerta>."
  },
  RelicConfig_13830_Desc = {
    Text = "Quando si causa Recupero PV, ottieni anche [Arg1] Scudo del Personaggio. Dopo l'inizio del 3° turno, ottieni [Arg2] <AlertIconKeywords:Allerta>."
  },
  RelicConfig_13830_Name = {
    Text = "<WhiteQuality:Farfalla Conservata>"
  },
  RelicConfig_13830_StoryDesc = {
    Text = "Ancora oggi, qualcuno lo ama profondamente."
  },
  RelicConfig_13831_BattleDesc = {
    Text = "Ogni volta che una Carta di comando entra nello <DimensionalSpaceIconKeywords:Spazio Ultra>, concedi al Risvegliatore corrispondente 15 Aliemus."
  },
  RelicConfig_13831_Desc = {
    Text = "Ogni volta che una Carta di comando entra nello <DimensionalSpaceIconKeywords:Spazio Ultra>, concedi al Risvegliatore corrispondente 15 Aliemus."
  },
  RelicConfig_13831_Name = {
    Text = "<WhiteQuality:Scarabeo del Tempo>"
  },
  RelicConfig_13831_StoryDesc = {
    Text = "Un orologio da tasca rinvenuto sia in un negozio di orologi che in un museo entomologico.\nÈ stato inserito nella collezione dell'università sin dal Diluvio."
  },
  RelicConfig_13832_BattleDesc = {
    Text = "Entrando nel Turno Ultra, rimuovi lo stato di <WeaknessIconKeywords:Debolezza> e <FragileIconKeywords:Fragile> da te stesso e infliggi lo stato di <WeaknessIconKeywords:Debolezza> e <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici per 3 turni. In questo turno, il Danno Finale di tutti i Risvegliatori è aumentato del 15%."
  },
  RelicConfig_13832_Desc = {
    Text = "Entrando nel Turno Ultra, rimuovi lo stato di <WeaknessIconKeywords:Debolezza> e <FragileIconKeywords:Fragile> da te stesso e infliggi lo stato di <WeaknessIconKeywords:Debolezza> e <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici per 3 turni. In questo turno, il Danno Finale di tutti i Risvegliatori è aumentato del 15%."
  },
  RelicConfig_13832_Name = {
    Text = "<WhiteQuality:Orologio a Supercorde>"
  },
  RelicConfig_13832_StoryDesc = {
    Text = "\"Oh no, l'orologio da tasca si è fermato.\""
  },
  RelicConfig_13833_BattleDesc = {
    Text = "Per ogni 1 istanza di DAN inflitta, applica [Arg1] accumuli di <IntoxicationIconKeywords:Veleno> al bersaglio. Se il numero di attivazioni raggiunge 25 in questa battaglia, attiva immediatamente il <IntoxicationIconKeywords:Veleno> per tutti i nemici."
  },
  RelicConfig_13833_Desc = {
    Text = "Per ogni 1 istanza di DAN inflitta, applica [Arg1] accumuli di <IntoxicationIconKeywords:Veleno> al bersaglio. Se il numero di attivazioni raggiunge 25 in questa battaglia, attiva immediatamente il <IntoxicationIconKeywords:Veleno> per tutti i nemici."
  },
  RelicConfig_13833_Name = {
    Text = "<OrangeQuality:☆Telaio Dimenticato☆>"
  },
  RelicConfig_13833_StoryDesc = {
    Text = "Una madre amorevole risana le ferite del cuore."
  },
  RelicConfig_13834_BattleDesc = {
    Text = "Ogni 5 volte che ottieni uno Scudo del Personaggio, ottieni anche <RetaliateIconKeywords:Contatore>, con un valore del Contatore pari al [Arg1]% dello Scudo del Personaggio ottenuto."
  },
  RelicConfig_13834_Desc = {
    Text = "Ogni 5 volte che ottieni uno Scudo del Personaggio, ottieni anche <RetaliateIconKeywords:Contatore>, con un valore del Contatore pari al [Arg1]% dello Scudo del Personaggio ottenuto."
  },
  RelicConfig_13834_Name = {
    Text = "<OrangeQuality:Frammento dei Saggi>"
  },
  RelicConfig_13834_StoryDesc = {
    Text = "\"Quanto sono sciocchi gli umani, che credono ciecamente solo perché qualcosa è antico.\""
  },
  RelicConfig_13835_BattleDesc = {
    Text = "Pesca 1 carta all'inizio del turno."
  },
  RelicConfig_13835_Desc = {
    Text = "Pesca 1 carta all'inizio del turno."
  },
  RelicConfig_13835_Name = {
    Text = "<WhiteQuality:Bussola del Nord Vero>"
  },
  RelicConfig_13835_StoryDesc = {
    Text = "L'indicazione non è una direzione, bensì un campo magnetico."
  },
  RelicConfig_13836_BattleDesc = {
    Text = "A inizio battaglia, posiziona casualmente <DerivativeCardKeywords_3:\"Convulsione\"> e <DerivativeCardKeywords_4:\"Intuizione\"> nello <DimensionalSpaceIconKeywords:Spazio Ultra> fino al raggiungimento del limite. Dopo essere entrato nel Turno Ultra, ottieni [Arg1] <PowerIconKeywords:FOR>."
  },
  RelicConfig_13836_Desc = {
    Text = "A inizio battaglia, posiziona casualmente <DerivativeCardKeywords_3:\"Convulsione\"> e <DerivativeCardKeywords_4:\"Intuizione\"> nello <DimensionalSpaceIconKeywords:Spazio Ultra> fino al raggiungimento del limite. Dopo essere entrato nel Turno Ultra, ottieni [Arg1] <PowerIconKeywords:FOR>."
  },
  RelicConfig_13836_Name = {
    Text = "<RedQuality:Artefatto di Alfonso>"
  },
  RelicConfig_13836_StoryDesc = {
    Text = "A differenza dell'imprevedibile fato, le stelle seguono leggi proprie."
  },
  RelicConfig_13837_BattleDesc = {
    Text = "<DeathResistanceIconKeywords:Resistenza alla Morte> +100% al momento della raccolta. (Ogni volta che la Resistenza alla Morte si attiva in questa sfida, la Resistenza alla Morte ottenuta viene dimezzata). Dopo aver attivato <DeathResistanceIconKeywords:Resistenza alla Morte>, recupera [Arg1] HP a inizio turno in questa battaglia."
  },
  RelicConfig_13837_Desc = {
    Text = "<DeathResistanceIconKeywords:Resistenza alla Morte> +100% al momento della raccolta. (Ogni volta che la Resistenza alla Morte si attiva in questa sfida, la Resistenza alla Morte ottenuta viene dimezzata). Dopo aver attivato <DeathResistanceIconKeywords:Resistenza alla Morte>, recupera [Arg1] HP a inizio turno in questa battaglia."
  },
  RelicConfig_13837_Name = {
    Text = "<WhiteQuality:Respirazione Artificiale>"
  },
  RelicConfig_13837_StoryDesc = {
    Text = "Un oggetto indispensabile per gli esploratori. Farvi troppo affidamento lo renderà parte di voi."
  },
  RelicConfig_13838_BattleDesc = {
    Text = "Questa è una Reliquia di Compito 2 senza Effetto"
  },
  RelicConfig_13838_Desc = {
    Text = "Questa è una Reliquia di Compito 2 senza Effetto"
  },
  RelicConfig_13838_Name = {
    Text = "Test Reliquia Missione 2"
  },
  RelicConfig_13838_StoryDesc = {
    Text = "Una reliquia che richiede contenuti aggiuntivi"
  },
  RelicConfig_13839_BattleDesc = {
    Text = "Quando giochi l'ultima carta nella tua mano, pesca 2 carte. Questo effetto può attivarsi fino a 2 volte per turno."
  },
  RelicConfig_13839_Desc = {
    Text = "Quando giochi l'ultima carta nella tua mano, pesca 2 carte. Questo effetto può attivarsi fino a 2 volte per turno."
  },
  RelicConfig_13839_Name = {
    Text = "<WhiteQuality:☆Guanti Arcani☆>"
  },
  RelicConfig_13839_StoryDesc = {
    Text = "\"Non temere, è solo un'illusione.\""
  },
  RelicConfig_13840_BattleDesc = {
    Text = "Ogni 3 turni, aggiungi 1 accumulo di <WeaknessIconKeywords:Debolezza> a tutti i nemici. Dopo aver inflitto DAN a un nemico con <WeaknessIconKeywords:Debolezza>, ottieni [Arg1] <PowerIconKeywords:FOR> Temporaneo, con un massimo di 3 attivazioni per turno."
  },
  RelicConfig_13840_Desc = {
    Text = "Ogni 3 turni, aggiungi 1 accumulo di <WeaknessIconKeywords:Sintomo: Debolezza> a tutti i nemici. Dopo aver inflitto Danno a un nemico con <WeaknessIconKeywords:Sintomo: Debolezza>, ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea, con un massimo di 3 attivazioni per turno."
  },
  RelicConfig_13840_Name = {
    Text = "<WhiteQuality:Bambino Maligno>"
  },
  RelicConfig_13840_StoryDesc = {
    Text = "Nato dal male puro, sebbene non fosse per sua volontà."
  },
  RelicConfig_13841_BattleDesc = {
    Text = "Il Danno Crit. di tutti i \"Colpo\" è aumentato del 20%. All'inizio della Battaglia, aggiungi 1 <DerivativeCardKeywords_40:\"Bellezza Fugace\"> alla mano."
  },
  RelicConfig_13841_Desc = {
    Text = "Il Danno Crit. di tutti i \"Colpo\" è aumentato del 20%. All'inizio della Battaglia, aggiungi 1 <DerivativeCardKeywords_40:\"Bellezza Fugace\"> alla mano."
  },
  RelicConfig_13841_Name = {
    Text = "<WhiteQuality:Bellezza Fugace>"
  },
  RelicConfig_13841_StoryDesc = {
    Text = "Preserva per sempre la bellezza degli istanti fugaci."
  },
  RelicConfig_13842_BattleDesc = {
    Text = "Immune a un'istanza di Danno Letale se la Resistenza alla Morte non è stata attivata, ripristina [Arg1] PV e rimuovi permanentemente questa Reliquia."
  },
  RelicConfig_13842_Desc = {
    Text = "Immune a un'istanza di Danno Letale se la Resistenza alla Morte non è stata attivata, ripristina [Arg1] PV e rimuovi permanentemente questa Reliquia."
  },
  RelicConfig_13842_Name = {
    Text = "<OrangeQuality:Bambola Sostituta>"
  },
  RelicConfig_13842_StoryDesc = {
    Text = "Hehehe, hehehe. Sei tu che sei in debito con me, giusto?"
  },
  RelicConfig_13844_BattleDesc = {
    Text = "Ottieni [Arg1] Scudo del Personaggio quando infliggi <WeaknessIconKeywords:Debolezza>; ottieni [Arg2] <PowerIconKeywords:FOR> Temporanea quando infliggi <VulnerabilityIconKeywords:Vulnerabile>. Se entrambi gli effetti si attivano in 1 turno, ottieni inoltre [Arg1] Scudo del Personaggio e [Arg2] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_13844_Desc = {
    Text = "Ottieni [Arg1] Scudo del Personaggio quando infliggi <WeaknessIconKeywords:Debolezza>; ottieni [Arg2] <PowerIconKeywords:FOR> Temporanea quando infliggi <VulnerabilityIconKeywords:Vulnerabile>. Se entrambi gli effetti si attivano in 1 turno, ottieni inoltre [Arg1] Scudo del Personaggio e [Arg2] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_13844_Name = {
    Text = "<OrangeQuality:Cornice Dorata>"
  },
  RelicConfig_13844_StoryDesc = {
    Text = "L'ultima opera di un artista dalla mente disturbata; si dice che riveli il suo volto atterrito."
  },
  RelicConfig_13845_BattleDesc = {
    Text = "Quando esaurisci l'ultimo 1 Arithmetica, ottieni 2 Arithmetica. Massimo 2 attivazioni per turno."
  },
  RelicConfig_13845_Desc = {
    Text = "Quando esaurisci l'ultimo 1 Arithmetica, ottieni 2 Arithmetica. Massimo 2 attivazioni per turno."
  },
  RelicConfig_13845_Name = {
    Text = "<OrangeQuality:☆Motore Differenziale☆>"
  },
  RelicConfig_13845_StoryDesc = {
    Text = "\"Ha cambiato la storia.\""
  },
  RelicConfig_13846_BattleDesc = {
    Text = "Ogni volta che perdi HP, ottieni [Arg1] <PowerIconKeywords:FOR>, fino a 10 volte per battaglia. Quando gli accumuli sono al massimo, recupera il 25% degli HP persi."
  },
  RelicConfig_13846_Desc = {
    Text = "Ogni volta che perdi HP, ottieni [Arg1] <PowerIconKeywords:FOR>, fino a 10 volte per battaglia. Quando gli accumuli sono al massimo, recupera il 25% degli HP persi."
  },
  RelicConfig_13846_Name = {
    Text = "<OrangeQuality:Onore Supremo>"
  },
  RelicConfig_13846_StoryDesc = {
    Text = "Un elegante e misterioso gatto nero a pelo corto, che si dice fosse venerato come divinità in un lontano regno desertico. Il nome di quella divinità è ormai perduto nel tempo.\nAdorato, venerato, dimenticato — forse questo è il destino di tutti gli dèi."
  },
  RelicConfig_13847_BattleDesc = {
    Text = "Infliggi il 20% di Danno in più ai nemici con debuff e ottieni 20 Aliemus uccidendoli."
  },
  RelicConfig_13847_Desc = {
    Text = "Infliggi il 20% di Danno in più ai nemici con debuff e ottieni 20 Aliemus uccidendoli."
  },
  RelicConfig_13847_Name = {
    Text = "<OrangeQuality:Bastone dell'Ierofante>"
  },
  RelicConfig_13847_StoryDesc = {
    Text = "Pietà Insanzionata"
  },
  RelicConfig_13848_BattleDesc = {
    Text = "Quando raccolto, la Padronanza del Reame della squadra aumenta al 150% del suo valore base. Dopo aver giocato la 5ª Carta di comando ogni turno, tutti i Risvegliatori ottengono 20 Aliemus."
  },
  RelicConfig_13848_Desc = {
    Text = "Quando raccolto, la Padronanza del Reame della squadra aumenta al 150% del suo valore base. Dopo aver giocato la 5ª Carta di comando ogni turno, tutti i Risvegliatori ottengono 20 Aliemus."
  },
  RelicConfig_13848_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Impurità\">"
  },
  RelicConfig_13849_BattleDesc = {
    Text = "Dopo aver inflitto il 3° danno ogni turno, ottieni [Arg1] Scudo del Personaggio. Dopo aver inflitto il 6° danno ogni turno, ottieni [Arg2] <PowerIconKeywords:FOR>."
  },
  RelicConfig_13849_Desc = {
    Text = "Dopo aver inflitto il 3° danno ogni turno, ottieni [Arg1] Scudo del Personaggio. Dopo aver inflitto il 6° danno ogni turno, ottieni [Arg2] <PowerIconKeywords:FOR>."
  },
  RelicConfig_13849_Name = {
    Text = "<WhiteQuality:Uscita di Sicurezza>"
  },
  RelicConfig_13849_StoryDesc = {
    Text = "A quanto pare, nemmeno lui è riuscito a uscirne."
  },
  RelicConfig_13851_BattleDesc = {
    Text = "Per ogni <DevouredIconKeywords:Divorare>, ruba [Arg1] <PowerIconKeywords:FRZ> Temporanea da tutti i nemici."
  },
  RelicConfig_13851_Desc = {
    Text = "Per ogni <DevouredIconKeywords:Divorare>, ruba [Arg1] <PowerIconKeywords:FRZ> Temporanea da tutti i nemici."
  },
  RelicConfig_13851_Name = {
    Text = "<OrangeQuality:Mano Fantasma>"
  },
  RelicConfig_13851_StoryDesc = {
    Text = "Lo strumento perfetto per uccidere, saccheggiare e graffiare."
  },
  RelicConfig_13852_BattleDesc = {
    Text = "Al momento della raccolta, scegli un Risvegliatore da Risvegliare. Il Costo di Arithmetica della sua carta Rouse è ridotto permanentemente di 1."
  },
  RelicConfig_13852_Desc = {
    Text = "Al momento della raccolta, scegli un Risvegliatore da Risvegliare. Il Costo di Arithmetica della sua carta Rouse è ridotto permanentemente di 1."
  },
  RelicConfig_13852_Name = {
    Text = "<WhiteQuality:Momento Sorpresa>"
  },
  RelicConfig_13852_StoryDesc = {
    Text = "Goditi il divertimento, ma non mangiarlo."
  },
  RelicConfig_13853_BattleDesc = {
    Text = "Ogni volta che si infligge Danno, ottieni [Arg1] <RetaliateIconKeywords:Contrattacco> Temporaneo. Può attivarsi fino a 5 volte per turno, e quando si attiva per la 5ª volta, metti una <DerivativeCardKeywords_4:\"Intuizione\"> nel Mazzo di Pesca."
  },
  RelicConfig_13853_Desc = {
    Text = "Ogni volta che si infligge Danno, ottieni [Arg1] <RetaliateIconKeywords:Contrattacco> Temporaneo. Può attivarsi fino a 5 volte per turno, e quando si attiva per la 5ª volta, metti una <DerivativeCardKeywords_4:\"Intuizione\"> nel Mazzo di Pesca."
  },
  RelicConfig_13853_Name = {
    Text = "<WhiteQuality:Pugnale Rituale>"
  },
  RelicConfig_13853_StoryDesc = {
    Text = "Un pugnale dalla lama ricurva, comunemente usato nei riti sacrificali."
  },
  RelicConfig_13854_BattleDesc = {
    Text = "A inizio turno, pesca 2 carte e ottieni 2 Arithmetica. Ogni volta che peschi una Carta di comando o attivi un Risveglio, il suo Costo di Arithmetica viene alterato casualmente. (0-4)"
  },
  RelicConfig_13854_Desc = {
    Text = "A inizio turno, pesca 2 carte e ottieni 2 Arithmetica. Ogni volta che peschi una Carta di comando o attivi un Risveglio, il suo Costo di Arithmetica viene alterato casualmente. (0-4)"
  },
  RelicConfig_13854_Name = {
    Text = "<RedQuality:Cappello del Truffatore>"
  },
  RelicConfig_13854_StoryDesc = {
    Text = "Benvenuto al Circo delle Meraviglie di Miss Casiah! Attenzione, non toccare gli oggetti magici. Se vieni morso, potrebbe andare male.\nL'ultima volta che ha assaggiato il sangue, l'esito fu terribile.\n\nIl cilindro ammiccò, come pronto a emergere."
  },
  RelicConfig_13855_BattleDesc = {
    Text = "All'inizio del turno e ogni volta che la Vita viene recuperata, ottieni [Arg1] <RetaliateIconKeywords:Contrattacco>. Può verificarsi fino a 3 volte per turno. Quando il limite viene raggiunto, attiva il <RetaliateIconKeywords:Contrattacco> al 100% contro tutti i nemici."
  },
  RelicConfig_13855_Desc = {
    Text = "All'inizio del turno e ogni volta che la Vita viene recuperata, ottieni [Arg1] <RetaliateIconKeywords:Contrattacco>. Può verificarsi fino a 3 volte per turno. Quando il limite viene raggiunto, attiva il <RetaliateIconKeywords:Contrattacco> al 100% contro tutti i nemici."
  },
  RelicConfig_13855_Name = {
    Text = "<OrangeQuality:Piccolo Carillon>"
  },
  RelicConfig_13855_StoryDesc = {
    Text = "La magione di Dexter custodisce molte collezioni. Prima di rompersi, il piccolo carillon era il giocattolo preferito della signorina Dexter.\nCol passare del tempo, quando la signorina Dexter lo ritrovò, i suoi ingranaggi erano allentati, la melodia stonata, ma continuava ancora a girare."
  },
  RelicConfig_13856_BattleDesc = {
    Text = "Danno Crit. aumentato del 15%. Probabilità di Crit. di \"Colpo\" aumentata del 40%."
  },
  RelicConfig_13856_Desc = {
    Text = "Danno Crit. aumentato del 15%. Probabilità di Crit. di \"Colpo\" aumentata del 40%."
  },
  RelicConfig_13856_Name = {
    Text = "<WhiteQuality:Becco di Corvo d'Avorio>"
  },
  RelicConfig_13856_StoryDesc = {
    Text = "Non esistono segreti dinanzi ad esso."
  },
  RelicConfig_13857_BattleDesc = {
    Text = "Dopo aver rilasciato l'Esaltazione, ottieni [Arg1] <RetaliateIconKeywords:Contatore>. Se questa è la 6ª attivazione in questa battaglia, raddoppia il tuo <RetaliateIconKeywords:Contatore>."
  },
  RelicConfig_13857_Desc = {
    Text = "Dopo aver rilasciato l'Esaltazione, ottieni [Arg1] <RetaliateIconKeywords:Contatore>. Se questa è la 6ª attivazione in questa battaglia, raddoppia il tuo <RetaliateIconKeywords:Contatore>."
  },
  RelicConfig_13857_Name = {
    Text = "<OrangeQuality:☆Sestante☆>"
  },
  RelicConfig_13857_StoryDesc = {
    Text = "L'unico sentiero dinanzi a te è quello dello smarrimento."
  },
  RelicConfig_13858_BattleDesc = {
    Text = "Pesca 1 carta extra e ottieni 1 Arithmetica ogni turno."
  },
  RelicConfig_13858_Desc = {
    Text = "Pesca 1 carta extra e ottieni 1 Arithmetica ogni turno."
  },
  RelicConfig_13858_Name = {
    Text = "<OrangeQuality:☆Dolce Reminiscenza☆>"
  },
  RelicConfig_13858_StoryDesc = {
    Text = "Alcuni rimasero in quell'estate per sempre."
  },
  RelicConfig_13859_BattleDesc = {
    Text = "A inizio turno, pesca 1 carta. A inizio battaglia, mischia 1 <DerivativeCardKeywords_4:\"Intuizione\"> nel tuo mazzo. Ogni battaglia aumenta di 1 il numero di carte <DerivativeCardKeywords_4:\"Intuizione\"> mischiate nel tuo mazzo, fino a un massimo di 3 volte."
  },
  RelicConfig_13859_Desc = {
    Text = "A inizio turno, pesca 1 carta. A inizio battaglia, mischia 1 <DerivativeCardKeywords_4:\"Intuizione\"> nel tuo mazzo. Ogni battaglia aumenta di 1 il numero di carte <DerivativeCardKeywords_4:\"Intuizione\"> mischiate nel tuo mazzo, fino a un massimo di 3 volte."
  },
  RelicConfig_13859_Name = {
    Text = "<OrangeQuality:Lente di Prasno>"
  },
  RelicConfig_13859_StoryDesc = {
    Text = "Il Gioco di Luce e Ombra"
  },
  RelicConfig_13860_BattleDesc = {
    Text = "Quando si giocano carte consecutive dello stesso Risvegliato, quel Risvegliato ottiene 8 Aliemus."
  },
  RelicConfig_13860_Desc = {
    Text = "Quando si giocano carte consecutive dello stesso Risvegliato, quel Risvegliato ottiene 8 Aliemus."
  },
  RelicConfig_13860_Name = {
    Text = "<WhiteQuality:Dispositivo Cronometrico>"
  },
  RelicConfig_13860_StoryDesc = {
    Text = "Una delle invenzioni più sinistre nella storia dell'umanità."
  },
  RelicConfig_13861_BattleDesc = {
    Text = "Quando selezionato, scegli una carta di un Risvegliatore per ridurne il Costo di Arithmetica di 1 e trattarla come \"Colpo\"."
  },
  RelicConfig_13861_Desc = {
    Text = "Quando selezionato, scegli una carta di un Risvegliatore per ridurne il Costo di Arithmetica di 1 e trattarla come \"Colpo\"."
  },
  RelicConfig_13861_Name = {
    Text = "<OrangeQuality:Fallacia Accidentale>"
  },
  RelicConfig_13861_StoryDesc = {
    Text = "Ridi a più non posso!"
  },
  RelicConfig_13862_BattleDesc = {
    Text = "Raccoglierla ti farà perdere permanentemente [Arg1] <PowerIconKeywords:FOR>. Ogni volta che infliggi Danno, cura [Arg2] HP, con un massimo di 6 attivazioni per turno."
  },
  RelicConfig_13862_Desc = {
    Text = "Raccoglierla ti farà perdere permanentemente [Arg1] <PowerIconKeywords:FOR>. Ogni volta che infliggi Danno, cura [Arg2] HP, con un massimo di 6 attivazioni per turno."
  },
  RelicConfig_13862_Name = {
    Text = "<RedQuality:Bacio della Lampreda>"
  },
  RelicConfig_13862_StoryDesc = {
    Text = "Vuoi un bacio profondo? Di quelli che ti tolgono la vita."
  },
  RelicConfig_13863_BattleDesc = {
    Text = "Ottieni 3 Arithmetica nel primo turno di ogni battaglia."
  },
  RelicConfig_13863_Desc = {
    Text = "Ottieni 3 Arithmetica nel primo turno di ogni battaglia."
  },
  RelicConfig_13863_Name = {
    Text = "<WhiteQuality:Specchio da Orologio da Tasca>"
  },
  RelicConfig_13863_StoryDesc = {
    Text = "Memorie solidificate nel passato, sepolte in profondità negli abissi neri."
  },
  RelicConfig_13864_BattleDesc = {
    Text = "Dopo aver giocato una Carta di Comando per la prima volta ogni turno, inserisci in mano un \"Colpo\" corrispondente al Risvegliatore, conferendogli <NothingnessIconKeywords:Fugace> e <DepleteIconKeywords:Consumo>."
  },
  RelicConfig_13864_Desc = {
    Text = "Dopo aver giocato una Carta di Comando per la prima volta ogni turno, inserisci in mano un \"Colpo\" corrispondente al Risvegliatore, conferendogli <NothingnessIconKeywords:Fugace> e <DepleteIconKeywords:Consumo>."
  },
  RelicConfig_13864_Name = {
    Text = "<WhiteQuality:Asse Moderno>"
  },
  RelicConfig_13864_StoryDesc = {
    Text = "Cavalca dalla campagna alla città, dalla calamità alla rinascita dalla terra."
  },
  RelicConfig_13865_BattleDesc = {
    Text = "Dopo aver giocato una Carta di comando per la prima volta ogni turno, aggiungi alla mano una carta \"Difesa\" corrispondente al Risvegliatore con <NothingnessIconKeywords:Effimero> e <DepleteIconKeywords:Consumo>."
  },
  RelicConfig_13865_Desc = {
    Text = "Dopo aver giocato una Carta di comando per la prima volta ogni turno, aggiungi alla mano una carta \"Difesa\" corrispondente al Risvegliatore con <NothingnessIconKeywords:Effimero> e <DepleteIconKeywords:Consumo>."
  },
  RelicConfig_13865_Name = {
    Text = "<WhiteQuality:Preludio Silente>"
  },
  RelicConfig_13865_StoryDesc = {
    Text = "Il violino del celebre violinista Eric Eckstein.\nOra non può più essere suonato."
  },
  RelicConfig_13866_BattleDesc = {
    Text = "Ogni 3 turni, aggiunge 1 accumulo di <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici. Dopo aver inflitto danni a un nemico <VulnerabilityIconKeywords:Vulnerabile>, riduce il suo Potere Temporaneo <PowerIconKeywords:FOR> di [Arg1], con un massimo di 3 attivazioni per turno."
  },
  RelicConfig_13866_Desc = {
    Text = "Ogni 3 turni, aggiunge 1 accumulo di <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici. Dopo aver inflitto danni a un nemico <VulnerabilityIconKeywords:Vulnerabile>, riduce il suo Potere Temporaneo <PowerIconKeywords:FOR> di [Arg1], con un massimo di 3 attivazioni per turno."
  },
  RelicConfig_13866_Name = {
    Text = "<WhiteQuality:La Sagra della Primavera>"
  },
  RelicConfig_13866_StoryDesc = {
    Text = "Tra le risa della notte, la sagoma della canoa scivola senza sforzo attraverso il lago."
  },
  RelicConfig_13867_BattleDesc = {
    Text = "Aumenta il limite di carte in mano di 3, ma pesca 1 carta in meno ogni turno. Scarta tutte le Carte Sintomo e le Carte di Stato alla fine del turno, conservando le altre carte."
  },
  RelicConfig_13867_Desc = {
    Text = "Aumenta il limite di carte in mano di 3, ma pesca 1 carta in meno ogni turno. Scarta tutte le Carte Sintomo e le Carte di Stato alla fine del turno, conservando le altre carte."
  },
  RelicConfig_13867_Name = {
    Text = "<RedQuality:Incisione della Coscienza>"
  },
  RelicConfig_13867_StoryDesc = {
    Text = "L'antica tribù credeva che incidere simboli speciali sui teschi dei defunti potesse trattenerne le anime per una compagnia eterna."
  },
  RelicConfig_13868_BattleDesc = {
    Text = "Dopo aver rilasciato l'Esaltazione 4 volte, riduci di 1 il Costo di Arithmetica di tutte le carte in mano."
  },
  RelicConfig_13868_Desc = {
    Text = "Dopo aver rilasciato l'Esaltazione 4 volte, riduci di 1 il Costo di Arithmetica di tutte le carte in mano."
  },
  RelicConfig_13868_Name = {
    Text = "<WhiteQuality:☆Mappa di Evacuazione☆>"
  },
  RelicConfig_13868_StoryDesc = {
    Text = "\"Dopo l'imbarco, individuate innanzitutto l'uscita di emergenza più vicina alla vostra cabina.\""
  },
  RelicConfig_13869_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Padronanza del Reame> aumentata di 100. Ogni volta che viene inflitto Danno attivo, il Danno tentacolo temporaneo aumenta di [Arg1]; ogni volta che viene inflitto Danno da Tentacolo, si ottiene uno Scudo pari a [Arg2]. Questo effetto può attivarsi un massimo di 6 volte per turno."
  },
  RelicConfig_13869_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Padronanza del Reame> aumentata di 100. Ogni volta che viene inflitto Danno attivo, il Danno tentacolo temporaneo aumenta di [Arg1]; ogni volta che viene inflitto Danno da Tentacolo, si ottiene uno Scudo pari a [Arg2]. Questo effetto può attivarsi un massimo di 6 volte per turno."
  },
  RelicConfig_13869_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Incubo\">"
  },
  RelicConfig_13870_BattleDesc = {
    Text = "Per ogni 1 Arithmetica consumata, il Risvegliatore corrispondente ottiene 2 Aliemus."
  },
  RelicConfig_13870_Desc = {
    Text = "Per ogni 1 Arithmetica consumata, il Risvegliatore corrispondente ottiene 2 Aliemus."
  },
  RelicConfig_13870_Name = {
    Text = "<WhiteQuality:Nastro d'Argento>"
  },
  RelicConfig_13870_StoryDesc = {
    Text = "Il nastro rinvenuto sulla scena del crimine era stato strappato in due pezzi con la forza.\nUn frammento fluttuò dall'alto e si posò nel palmo della ragazza."
  },
  RelicConfig_13871_BattleDesc = {
    Text = "Tutti i Risvegliatori ottengono 10 Aliemus a inizio turno. Riduce i PV massimi del 30% al momento della raccolta."
  },
  RelicConfig_13871_Desc = {
    Text = "Tutti i Risvegliatori ottengono 10 Aliemus a inizio turno. Riduce i PV massimi del 30% al momento della raccolta."
  },
  RelicConfig_13871_Name = {
    Text = "<RedQuality:Manifestazione dell'Incubo>"
  },
  RelicConfig_13871_StoryDesc = {
    Text = "Attento, un sonno profondo e indulgente divorerà ogni cosa senza che tu te ne accorga."
  },
  RelicConfig_13873_BattleDesc = {
    Text = "Gioca \"<ExaltIconKeywords:Risveglio>\" per rimuovere tutto lo Scudo del Personaggio nemico."
  },
  RelicConfig_13873_Desc = {
    Text = "Gioca \"<ExaltIconKeywords:Risveglio>\" per rimuovere tutto lo Scudo del Personaggio nemico."
  },
  RelicConfig_13873_Name = {
    Text = "Riflesso Nero"
  },
  RelicConfig_13874_BattleDesc = {
    Text = "Nei turni dispari, pesca 2 carte se non te ne rimangono; nei turni pari, ottieni 2 Arithmetica se non te ne rimane."
  },
  RelicConfig_13874_Desc = {
    Text = "Nei turni dispari, pesca 2 carte se non te ne rimangono; nei turni pari, ottieni 2 Arithmetica se non te ne rimane."
  },
  RelicConfig_13874_Name = {
    Text = "Guida Dorata Mutata"
  },
  RelicConfig_13875_BattleDesc = {
    Text = "Dopo aver usato \"Colpo\" e \"Difesa\", i Risvegliatori corrispondenti ottengono 35 Aliemus. Tuttavia, il loro Costo di Arithmetica aumenta di +1."
  },
  RelicConfig_13875_Desc = {
    Text = "Dopo aver usato \"Colpo\" e \"Difesa\", i Risvegliatori corrispondenti ottengono 35 Aliemus. Tuttavia, il loro Costo di Arithmetica aumenta di +1."
  },
  RelicConfig_13875_Name = {
    Text = "<RedQuality:Volto Infranto>"
  },
  RelicConfig_13875_StoryDesc = {
    Text = "Il cui volto, colmo di terrore, è cristallizzato nel tempo."
  },
  RelicConfig_13877_BattleDesc = {
    Text = "Dopo aver ottenuto il 2° Scudo ogni turno, ottieni [Arg1] <plural value=\"[Arg1]\" singular=\"accumulo\" plural=\"accumuli\"> di <RetaliateIconKeywords:Contrattacco>. Dopo aver ottenuto il 4° Scudo ogni turno, attiva il <RetaliateIconKeywords:Contrattacco> al 100% contro tutti i nemici."
  },
  RelicConfig_13877_Desc = {
    Text = "Dopo aver ottenuto il 2° Scudo ogni turno, ottieni [Arg1] <plural value=\"[Arg1]\" singular=\"accumulo\" plural=\"accumuli\"> di <RetaliateIconKeywords:Contrattacco>. Dopo aver ottenuto il 4° Scudo ogni turno, attiva il <RetaliateIconKeywords:Contrattacco> al 100% contro tutti i nemici."
  },
  RelicConfig_13877_Name = {
    Text = "<WhiteQuality:Verità Senza Riserve>"
  },
  RelicConfig_13877_StoryDesc = {
    Text = "Trasmette innumerevoli Segreti, che siano pronunciati attivamente o passivamente."
  },
  RelicConfig_13878_BattleDesc = {
    Text = "Giocare la 6ª Carta di comando la fa tornare nella tua mano dalla Pila degli scarti."
  },
  RelicConfig_13878_Desc = {
    Text = "Giocare la 6ª Carta di comando la fa tornare nella tua mano dalla Pila degli scarti."
  },
  RelicConfig_13878_Name = {
    Text = "<OrangeQuality:Nel crepuscolo>"
  },
  RelicConfig_13878_StoryDesc = {
    Text = "Facciamoci una foto insieme! Prova la sensazione del vero dolore."
  },
  RelicConfig_13879_BattleDesc = {
    Text = "Dopo aver rilasciato 5 Esaltazioni, il Risveglio che le ha rilasciate ottiene 100 Aliemus."
  },
  RelicConfig_13879_Desc = {
    Text = "Dopo aver rilasciato 5 Esaltazioni, il Risveglio che le ha rilasciate ottiene 100 Aliemus."
  },
  RelicConfig_13879_Name = {
    Text = "<OrangeQuality:Piccola Culla>"
  },
  RelicConfig_13879_StoryDesc = {
    Text = "Portando speranza, benedizioni e amore."
  },
  RelicConfig_13880_BattleDesc = {
    Text = "Ottieni [Arg1] Scudo quando infliggi Danno attivo. Ottieni [Arg2] <PowerIconKeywords:FOR> Temporanea quando ripristini PV."
  },
  RelicConfig_13880_Desc = {
    Text = "Ottieni [Arg1] Scudo quando infliggi Danno attivo. Ottieni [Arg2] <PowerIconKeywords:FOR> Temporanea quando ripristini PV."
  },
  RelicConfig_13880_Name = {
    Text = "<OrangeQuality:Casa Nostra>"
  },
  RelicConfig_13880_StoryDesc = {
    Text = "Erano insieme in passato, e saranno sempre insieme in futuro. Sono una famiglia unita e amorevole."
  },
  RelicConfig_13881_BattleDesc = {
    Text = "All'inizio di un turno dispari, ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea. All'inizio di un turno pari, ottieni [Arg2] <AlertIconKeywords:Allerta> Temporanea."
  },
  RelicConfig_13881_Desc = {
    Text = "All'inizio di un turno dispari, ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea. All'inizio di un turno pari, ottieni [Arg2] <AlertIconKeywords:Allerta> Temporanea."
  },
  RelicConfig_13881_Name = {
    Text = "<WhiteQuality:Bambole Gemelle>"
  },
  RelicConfig_13881_StoryDesc = {
    Text = "Nascita Gemellare è un Dono dell'era antica, una parabola per il futuro."
  },
  RelicConfig_13882_BattleDesc = {
    Text = "Alla fine di ogni turno, giocando la prima Carta di comando con il Risvegliatore corrispondente, ottieni 20 Aliemus. Se possiedi anche la Reliquia \"Cuore Devoto\", gli altri Risvegliatori ottengono 5 Aliemus."
  },
  RelicConfig_13882_Desc = {
    Text = "Alla fine di ogni turno, giocando la prima Carta di comando con il Risvegliatore corrispondente, ottieni 20 Aliemus. Se possiedi anche la Reliquia \"Cuore Devoto\", gli altri Risvegliatori ottengono 5 Aliemus."
  },
  RelicConfig_13882_Name = {
    Text = "<WhiteQuality:Effigie della Madre>"
  },
  RelicConfig_13882_StoryDesc = {
    Text = "\"Ti darò qualsiasi cosa, qualunque cosa tu voglia, ti prego, lascialo andare.\""
  },
  RelicConfig_13883_BattleDesc = {
    Text = "Ogni volta che un Risvegliato esegue <DevouredIconKeywords:Divorare>, gli altri Risvegliati ottengono 10 Aliemus."
  },
  RelicConfig_13883_Desc = {
    Text = "Ogni volta che un Risvegliato esegue <DevouredIconKeywords:Divorare>, gli altri Risvegliati ottengono 10 Aliemus."
  },
  RelicConfig_13883_Name = {
    Text = "<OrangeQuality:Reverie dorata>"
  },
  RelicConfig_13883_StoryDesc = {
    Text = "Il giorno della trasformazione sarà la tua rovina."
  },
  RelicConfig_13884_BattleDesc = {
    Text = "\"Colpo\" infligge [Arg1] accumuli di <IntoxicationIconKeywords:Veleno> a tutti i nemici."
  },
  RelicConfig_13884_Desc = {
    Text = "\"Colpo\" infligge [Arg1] accumuli di <IntoxicationIconKeywords:Veleno> a tutti i nemici."
  },
  RelicConfig_13884_Name = {
    Text = "<WhiteQuality:Neurotossina>"
  },
  RelicConfig_13884_StoryDesc = {
    Text = "Estrarre, Raffinare."
  },
  RelicConfig_13885_BattleDesc = {
    Text = "All'inizio della battaglia, colloca 1 <DerivativeCardKeywords_1:Echi di Ombre Perdute> nella mano. Se si tratta di una Battaglia Boss, ottieni 1 <DerivativeCardKeywords_1:Echi di Ombre Perdute> aggiuntivo."
  },
  RelicConfig_13885_Desc = {
    Text = "All'inizio della battaglia, colloca 1 <DerivativeCardKeywords_1:Echi di Ombre Perdute> nella mano. Se si tratta di una Battaglia Boss, ottieni 1 <DerivativeCardKeywords_1:Echi di Ombre Perdute> aggiuntivo."
  },
  RelicConfig_13885_Name = {
    Text = "<WhiteQuality:Relè di Segnale>"
  },
  RelicConfig_13885_StoryDesc = {
    Text = "Attendi o temi il momento in cui suonerà."
  },
  RelicConfig_13886_BattleDesc = {
    Text = "Ogni volta che rimescoli il mazzo, aggiungi 2 <DerivativeCardKeywords_5:Tridente Uncinato> e 1 <DerivativeCardKeywords_6:Parasole> alla tua mano."
  },
  RelicConfig_13886_Desc = {
    Text = "Ogni volta che rimescoli il mazzo, aggiungi 2 <DerivativeCardKeywords_5:Tridente Uncinato> e 1 <DerivativeCardKeywords_6:Parasole> alla tua mano."
  },
  RelicConfig_13886_Name = {
    Text = "<WhiteQuality:☆Borsetta della Dama☆>"
  },
  RelicConfig_13886_StoryDesc = {
    Text = "Era destinata a portare raffinatezza, non morte."
  },
  RelicConfig_13887_BattleDesc = {
    Text = "All'inizio del turno, aggiungi 1 <DerivativeCardKeywords_5:\"Tridente Spinato\"> alla tua mano. Dopo aver rilasciato Esaltazione, aumenta la <PowerIconKeywords:FOR> di tutti i <DerivativeCardKeywords_5:\"Tridente Spinato\"> nella tua mano di [Arg2]."
  },
  RelicConfig_13887_Desc = {
    Text = "All'inizio del turno, aggiungi 1 <DerivativeCardKeywords_5:\"Tridente Spinato\"> alla tua mano. Dopo aver rilasciato Esaltazione, aumenta la <PowerIconKeywords:FOR> di tutti i <DerivativeCardKeywords_5:\"Tridente Spinato\"> nella tua mano di [Arg2]."
  },
  RelicConfig_13887_Name = {
    Text = "<WhiteQuality:Tridente Uncinato>"
  },
  RelicConfig_13887_StoryDesc = {
    Text = "Da qualunque angolazione lo si guardi, è semplicemente ordinario."
  },
  RelicConfig_13888_BattleDesc = {
    Text = "Ottieni [Arg1] Scudo del Personaggio all'inizio della battaglia. Dopo aver giocato \"Difesa\" 7 volte in questa battaglia, ottieni immediatamente [Arg2] Scudo del Personaggio. Dopo aver giocato \"Difesa\" 21 volte in questa battaglia, ottieni 1 accumulo di Barriera temporanea."
  },
  RelicConfig_13888_Desc = {
    Text = "Ottieni [Arg1] Scudo del Personaggio all'inizio della battaglia. Dopo aver giocato \"Difesa\" 7 volte in questa battaglia, ottieni immediatamente [Arg2] Scudo del Personaggio. Dopo aver giocato \"Difesa\" 21 volte in questa battaglia, ottieni 1 accumulo di Barriera temporanea."
  },
  RelicConfig_13888_Name = {
    Text = "<WhiteQuality:Gazzetta Mattutina di Putney>"
  },
  RelicConfig_13888_StoryDesc = {
    Text = "Il tuo più premuroso compagno da toilette."
  },
  RelicConfig_13889_BattleDesc = {
    Text = "All'ingresso nel Turno Ultra, ottieni 3 Arithmetica."
  },
  RelicConfig_13889_Desc = {
    Text = "All'ingresso nel Turno Ultra, ottieni 3 Arithmetica."
  },
  RelicConfig_13889_Name = {
    Text = "<WhiteQuality:Clessidra Luminosa>"
  },
  RelicConfig_13889_StoryDesc = {
    Text = "Una quantità misurabile di tempo."
  },
  RelicConfig_13890_BattleDesc = {
    Text = "A inizio battaglia, infliggi 1 turno di <WeaknessIconKeywords:Debolezza> e <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici. Se è una Battaglia Boss, infliggi inoltre 2 turni di <WeaknessIconKeywords:Debolezza> e <VulnerabilityIconKeywords:Vulnerabile>."
  },
  RelicConfig_13890_Desc = {
    Text = "A inizio battaglia, infliggi 1 turno di <WeaknessIconKeywords:Debolezza> e <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici. Se è una Battaglia Boss, infliggi inoltre 2 turni di <WeaknessIconKeywords:Debolezza> e <VulnerabilityIconKeywords:Vulnerabile>."
  },
  RelicConfig_13890_Name = {
    Text = "<WhiteQuality:Camicia di Forza Cangiante>"
  },
  RelicConfig_13890_StoryDesc = {
    Text = "Non solo il tempo può far sbiadire i tessuti, ma anche il terrore e il pain."
  },
  RelicConfig_13891_BattleDesc = {
    Text = "La prima Carta di comando giocata ogni turno che attiva un effetto Balzo pesca 1 carta; altrimenti, ottieni 1 Arithmetica. Durante i Turni Ultra, entrambi gli effetti si applicano."
  },
  RelicConfig_13891_Desc = {
    Text = "La prima Carta di comando giocata ogni turno che attiva un effetto Balzo pesca 1 carta; altrimenti, ottieni 1 Arithmetica. Durante i Turni Ultra, entrambi gli effetti si applicano."
  },
  RelicConfig_13891_Name = {
    Text = "<OrangeQuality:Dispositivo di Distorsione>"
  },
  RelicConfig_13891_StoryDesc = {
    Text = "Riflette un'ombra distorta."
  },
  RelicConfig_13892_BattleDesc = {
    Text = "Ottieni una missione. Completa la missione per ricevere ricompense. [Event Placeholder]"
  },
  RelicConfig_13892_Desc = {
    Text = "Ottieni una missione. Completa la missione per ricevere ricompense. [Event Placeholder]"
  },
  RelicConfig_13892_Name = {
    Text = "<WhiteQuality:Diario Logoro>"
  },
  RelicConfig_13892_StoryDesc = {
    Text = "Un vecchio diario zeppo di inserti, tra cui mappe di Elworth, registri di esperimenti e lettere contrassegnate da D-segni triangolari.\nLa calligrafia all'inizio è ordinata e precisa, ma gradualmente diventa disordinata e caotica."
  },
  RelicConfig_13893_BattleDesc = {
    Text = "Ogni 4 volte che ottieni Scudo del Personaggio, recuperi PV pari al 50% del valore di quello Scudo del Personaggio."
  },
  RelicConfig_13893_Desc = {
    Text = "Ogni 4 volte che ottieni Scudo del Personaggio, recuperi PV pari al 50% del valore di quello Scudo del Personaggio."
  },
  RelicConfig_13893_Name = {
    Text = "<WhiteQuality:Fischietto del Marinaio>"
  },
  RelicConfig_13893_StoryDesc = {
    Text = "Oltre alle sirene, il fischietto può richiamare uragani, stivali maleodoranti e marinai che non si lavano da cento giorni."
  },
  RelicConfig_13894_BattleDesc = {
    Text = "Se il numero di carte giocate nel turno precedente è minore o uguale a 4, la prima carta giocata in questo turno ha effetto due volte."
  },
  RelicConfig_13894_Desc = {
    Text = "Se il numero di carte giocate nel turno precedente è minore o uguale a 4, la prima carta giocata in questo turno ha effetto due volte."
  },
  RelicConfig_13894_Name = {
    Text = "<OrangeQuality:☆Lanterna dell'Incubo☆>"
  },
  RelicConfig_13894_StoryDesc = {
    Text = "Introduci il Fantasma."
  },
  RelicConfig_13895_BattleDesc = {
    Text = "Ogni volta che perdi HP, il Risvegliatore con meno Aliemus ottiene 10 Aliemus. Ogni 5ª volta che perdi HP, recuperi il 20% degli HP persi."
  },
  RelicConfig_13895_Desc = {
    Text = "Ogni volta che perdi HP, il Risvegliatore con meno Aliemus ottiene 10 Aliemus. Ogni 5ª volta che perdi HP, recuperi il 20% degli HP persi."
  },
  RelicConfig_13895_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Analisi\">"
  },
  RelicConfig_13896_BattleDesc = {
    Text = "Arithmetica massima +2. Ogni volta che il mazzo viene rimescolato, aggiungi 1 <DerivativeCardKeywords_9:\"Barcollare\"> al Mazzo di Pesca."
  },
  RelicConfig_13896_Desc = {
    Text = "Arithmetica massima +2. Ogni volta che il mazzo viene rimescolato, aggiungi 1 <DerivativeCardKeywords_9:\"Barcollare\"> al Mazzo di Pesca."
  },
  RelicConfig_13896_Name = {
    Text = "<RedQuality:Candela nera>"
  },
  RelicConfig_13896_StoryDesc = {
    Text = "Brucia nella lucidità, sprofonda nell'illusione."
  },
  RelicConfig_13897_BattleDesc = {
    Text = "\"Le carte <ExaltIconKeywords:Risveglio> vengono conservate a fine turno."
  },
  RelicConfig_13897_Desc = {
    Text = "\"Le carte <ExaltIconKeywords:Risveglio> vengono conservate a fine turno."
  },
  RelicConfig_13897_Name = {
    Text = "Riflesso Bianco"
  },
  RelicConfig_13898_BattleDesc = {
    Text = "Per ogni Risvegliatore che ha effettuato il Risveglio, aumenta la <ProficientInRealmsIconKeywords:Padronanza del Reame> di 35. Dopo aver giocato \"<ExaltIconKeywords:Risveglio>\", ottieni casualmente 2 Carte di Comando di quel Risvegliatore con \"Esaurimento\" applicato."
  },
  RelicConfig_13898_Desc = {
    Text = "Per ogni Risvegliatore che ha effettuato il Risveglio, aumenta la <ProficientInRealmsIconKeywords:Padronanza del Reame> di 35. Dopo aver giocato \"<ExaltIconKeywords:Risveglio>\", ottieni casualmente 2 Carte di Comando di quel Risvegliatore con \"Esaurimento\" applicato."
  },
  RelicConfig_13898_Name = {
    Text = "<OrangeQuality:Oracolo Divino>"
  },
  RelicConfig_13898_StoryDesc = {
    Text = "Egli disse: \"Non avere paura.\""
  },
  RelicConfig_13899_BattleDesc = {
    Text = "A inizio turno, la <ProficientInRealmsIconKeywords:Padronanza del Reame> aumenta di 50. Se non si è sotto un debuff, la <ProficientInRealmsIconKeywords:Padronanza del Reame> aumenta fino a 150."
  },
  RelicConfig_13899_Desc = {
    Text = "A inizio turno, la <ProficientInRealmsIconKeywords:Padronanza del Reame> aumenta di 50. Se non si è sotto un debuff, la <ProficientInRealmsIconKeywords:Padronanza del Reame> aumenta fino a 150."
  },
  RelicConfig_13899_Name = {
    Text = "<WhiteQuality:☆\"Alla Libertà\"☆>"
  },
  RelicConfig_13899_StoryDesc = {
    Text = "Una manciata d'Argento che evoca un senso di Nostalgia."
  },
  RelicConfig_13900_BattleDesc = {
    Text = "Dopo aver usato \"Risveglio\", il Costo di Arithmetica di tutte le carte si riduce di 1."
  },
  RelicConfig_13900_Desc = {
    Text = "Dopo aver usato \"Risveglio\", il Costo di Arithmetica di tutte le carte In Mano si riduce di 1."
  },
  RelicConfig_13900_Name = {
    Text = "Luce della Civiltà Mutata"
  },
  RelicConfig_13901_BattleDesc = {
    Text = "Ottieni [Arg2]% di <DeathResistanceIconKeywords:Resistenza alla Morte> ogni volta che giochi una Carta di comando (ogni volta che la Resistenza alla Morte si attiva in questo livello, la Resistenza alla Morte ottenuta viene dimezzata). Se la tua <DeathResistanceIconKeywords:Resistenza alla Morte> è maggiore o uguale al 100%, ottieni invece [Arg1] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_13901_Desc = {
    Text = "Ottieni [Arg2]% di <DeathResistanceIconKeywords:Resistenza alla Morte> ogni volta che giochi una Carta di comando (ogni volta che la Resistenza alla Morte si attiva in questo livello, la Resistenza alla Morte ottenuta viene dimezzata). Se la tua <DeathResistanceIconKeywords:Resistenza alla Morte> è maggiore o uguale al 100%, ottieni invece [Arg1] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_13901_Name = {
    Text = "<OrangeQuality:Spoglia del serpente>"
  },
  RelicConfig_13901_StoryDesc = {
    Text = "Rinascita dalla Terra attraverso l'automutilazione"
  },
  RelicConfig_13902_BattleDesc = {
    Text = "All'inizio del turno, ottieni [Arg2] Scudo. Alla fine del turno, infliggi <FixedDamage:DAN Puro> pari al [Arg1]% del tuo Scudo attuale a un nemico casuale. L'effetto DAN è raddoppiato nelle Battaglie Boss."
  },
  RelicConfig_13902_Desc = {
    Text = "All'inizio del turno, ottieni [Arg2] Scudo. Alla fine del turno, infliggi <FixedDamage:DAN Puro> pari al [Arg1]% del tuo Scudo attuale a un nemico casuale. L'effetto DAN è raddoppiato nelle Battaglie Boss."
  },
  RelicConfig_13902_Name = {
    Text = "<WhiteQuality:Guida Dorata>"
  },
  RelicConfig_13902_StoryDesc = {
    Text = "Quando sei smarrito, aprilo. Ma sii cauto: la sua corona non deve essere esposta alla luce del sole."
  },
  RelicConfig_13904_BattleDesc = {
    Text = "Nascondi le Intenzioni del Mostro. Ottieni 1 Arithmetica ogni turno e pesca 1 carta."
  },
  RelicConfig_13904_Desc = {
    Text = "Nascondi le Intenzioni del Mostro. Ottieni 1 Arithmetica ogni turno e pesca 1 carta."
  },
  RelicConfig_13904_Name = {
    Text = "<RedQuality:Campanella Ammaliatrice>"
  },
  RelicConfig_13904_StoryDesc = {
    Text = "Tintinnio, tintinnio."
  },
  RelicConfig_13905_BattleDesc = {
    Text = "Dopo l'inizio della battaglia, ottieni [Arg2] accumuli di <RetaliateIconKeywords:Contatore>. Gioca \"Difesa\" per ottenere [Arg1] accumuli di <RetaliateIconKeywords:Contatore>."
  },
  RelicConfig_13905_Desc = {
    Text = "Dopo l'inizio della battaglia, ottieni [Arg2] accumuli di <RetaliateIconKeywords:Contatore>. Gioca \"Difesa\" per ottenere [Arg1] accumuli di <RetaliateIconKeywords:Contatore>."
  },
  RelicConfig_13905_Name = {
    Text = "<WhiteQuality:Veste d'Ortica>"
  },
  RelicConfig_13905_StoryDesc = {
    Text = "Impossibile identificare il liquido che è stato contaminato."
  },
  RelicConfig_13906_BattleDesc = {
    Text = "Questa è una Reliquia settimanale 4 senza Effetto"
  },
  RelicConfig_13906_Desc = {
    Text = "Questa è una Reliquia settimanale 4 senza Effetto"
  },
  RelicConfig_13906_Name = {
    Text = "Sfida Giornaliera Reliquia Sostituto settimanale 4"
  },
  RelicConfig_13907_BattleDesc = {
    Text = "All'inizio del turno, se hai giocato più di 3 carte nel turno precedente, pesca 2 carte."
  },
  RelicConfig_13907_Desc = {
    Text = "All'inizio del turno, se hai giocato più di 3 carte nel turno precedente, pesca 2 carte."
  },
  RelicConfig_13907_Name = {
    Text = "<WhiteQuality:Portafoglio Nuovo di Zecca>"
  },
  RelicConfig_13907_StoryDesc = {
    Text = "Un portafoglio in pelle inciso con l'emblema dell'Università di Mythag.\nOra è vuoto, non contiene più nulla."
  },
  RelicConfig_13908_BattleDesc = {
    Text = "Dopo aver usato \"Risveglio\", il Risvegliatore ottiene [Arg1] Aliemus."
  },
  RelicConfig_13908_Desc = {
    Text = "Dopo aver usato \"Risveglio\", il Risvegliatore ottiene [Arg1] Aliemus."
  },
  RelicConfig_13908_Name = {
    Text = "Velo della Divinità Senza Nome Mutato"
  },
  RelicConfig_13909_BattleDesc = {
    Text = "Dopo aver attivato Esaltazione, perdi l'8% degli HP attuali, ruba [Arg1] <PowerIconKeywords:FOR> Temporanea da tutti i nemici. Se c'è solo 1 nemico, ruba ulteriori [Arg2] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_13909_Desc = {
    Text = "Dopo aver attivato Esaltazione, perdi l'8% degli HP attuali, ruba [Arg1] <PowerIconKeywords:FOR> Temporanea da tutti i nemici. Se c'è solo 1 nemico, ruba ulteriori [Arg2] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_13909_Name = {
    Text = "<RedQuality:Uccello Rituale del Presagio>"
  },
  RelicConfig_13909_StoryDesc = {
    Text = "Il cadavere rinsecchito emise uno stridio."
  },
  RelicConfig_13910_BattleDesc = {
    Text = "Dopo l'Esaltazione, il Risveglio corrispondente guadagna 10 Aliemus e [Arg1] Scudo del Personaggio."
  },
  RelicConfig_13910_Desc = {
    Text = "Dopo l'Esaltazione, il Risveglio corrispondente guadagna 10 Aliemus e [Arg1] Scudo del Personaggio."
  },
  RelicConfig_13910_Name = {
    Text = "<OrangeQuality:Velo della Divinità Senza Nome>"
  },
  RelicConfig_13910_StoryDesc = {
    Text = "Non guardare direttamente gli dèi."
  },
  RelicConfig_13911_BattleDesc = {
    Text = "Alla fine di ogni turno, il Risvegliatore corrispondente che ha giocato l'ultima Carta di comando ottiene 20 Aliemus. Se possiede anche la Reliquia \"Effigie della Madre\", gli altri Risvegliatori ottengono 5 Aliemus."
  },
  RelicConfig_13911_Desc = {
    Text = "Alla fine di ogni turno, il Risvegliatore corrispondente che ha giocato l'ultima Carta di comando ottiene 20 Aliemus. Se possiede anche la Reliquia \"Effigie della Madre\", gli altri Risvegliatori ottengono 5 Aliemus."
  },
  RelicConfig_13911_Name = {
    Text = "<WhiteQuality:Cuore Devoto>"
  },
  RelicConfig_13911_StoryDesc = {
    Text = "\"Ti darò qualsiasi cosa, qualunque cosa. Ti prego, risparmiami.\""
  },
  RelicConfig_13912_BattleDesc = {
    Text = "Alla fine del turno, per ogni carta rimanente in mano, ottieni 1 Arithmetica all'inizio del turno successivo."
  },
  RelicConfig_13912_Desc = {
    Text = "Alla fine del turno, per ogni carta rimanente in mano, ottieni 1 Arithmetica all'inizio del turno successivo."
  },
  RelicConfig_13912_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Emulazione\">"
  },
  RelicConfig_13913_BattleDesc = {
    Text = "All'inizio del turno, se i PV sono superiori a [Arg1], perdi [Arg1] PV e ottieni [Arg2] <PowerIconKeywords:FOR> e [Arg3] <AlertIconKeywords:Allerta> per questo turno."
  },
  RelicConfig_13913_Desc = {
    Text = "All'inizio del turno, se i PV sono superiori a [Arg1], perdi [Arg1] PV e ottieni [Arg2] <PowerIconKeywords:FOR> e [Arg3] <AlertIconKeywords:Allerta> per questo turno."
  },
  RelicConfig_13913_Name = {
    Text = "<RedQuality:Arto Salvifico>"
  },
  RelicConfig_13913_StoryDesc = {
    Text = [[
Una parte sacra.
Anche quando separata dal corpo, se ne percepisce ancora il calore.]]
  },
  RelicConfig_13914_BattleDesc = {
    Text = "\"Colpo\" ottiene 2 Arithmetica e scarta 1 carta casuale; \"Difesa\" pesca 2 carte e perde 1 Arithmetica. Può essere attivato fino a 3 volte per turno."
  },
  RelicConfig_13914_Desc = {
    Text = "\"Colpo\" ottiene 2 Arithmetica e scarta 1 carta casuale; \"Difesa\" pesca 2 carte e perde 1 Arithmetica. Può essere attivato fino a 3 volte per turno."
  },
  RelicConfig_13914_Name = {
    Text = "<RedQuality:Disco Gioioso>"
  },
  RelicConfig_13914_StoryDesc = {
    Text = "La registrazione dell'ultima esibizione del celebre violinista.\nDa allora, è in grado di evocare le fiamme."
  },
  RelicConfig_13915_BattleDesc = {
    Text = "L'effetto del bonus del Reame raccomandato è aumentato al 50% e la tua <ProficientInRealmsIconKeywords:Padronanza del Reame> è raddoppiata all'inizio del livello."
  },
  RelicConfig_13915_Desc = {
    Text = "L'effetto del bonus del Reame raccomandato è aumentato al 50% e la tua <ProficientInRealmsIconKeywords:Padronanza del Reame> è raddoppiata all'inizio del livello."
  },
  RelicConfig_13915_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Morfeo\">"
  },
  RelicConfig_13916_BattleDesc = {
    Text = "Dopo aver attivato un'Esaltazione, la prossima Carta di comando giocata ha effetto due volte."
  },
  RelicConfig_13916_Desc = {
    Text = "Dopo aver attivato un'Esaltazione, la prossima Carta di comando giocata ha effetto due volte."
  },
  RelicConfig_13916_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Immersione\">"
  },
  RelicConfig_13917_BattleDesc = {
    Text = "Se l'intenzione del nemico è attaccare, riduce temporaneamente la sua <PowerIconKeywords:FOR> di [Arg1] dopo aver inflitto Danno. Altrimenti, applica <BleedingIconKeywords:Salasso> pari al 25% del Danno inflitto, fino a 6 volte per turno."
  },
  RelicConfig_13917_Desc = {
    Text = "Se l'intenzione del nemico è attaccare, riduce temporaneamente la sua <PowerIconKeywords:FOR> di [Arg1] dopo aver inflitto Danno. Altrimenti, applica <BleedingIconKeywords:Salasso> pari al 25% del Danno inflitto, fino a 6 volte per turno."
  },
  RelicConfig_13917_Name = {
    Text = "<WhiteQuality:Cuore Alieno>"
  },
  RelicConfig_13917_StoryDesc = {
    Text = "Due \"cuori\" stretti l'uno accanto all'altro"
  },
  RelicConfig_13918_BattleDesc = {
    Text = "Ogni volta che vengono inflitti DAN, ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea, fino a 3 volte. Quando gli accumuli sono al massimo, l'effetto è raddoppiato."
  },
  RelicConfig_13918_Desc = {
    Text = "Ogni volta che vengono inflitti DAN, ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea, fino a 3 volte. Quando gli accumuli sono al massimo, l'effetto è raddoppiato."
  },
  RelicConfig_13918_Name = {
    Text = "<WhiteQuality:Agata Filigranata>"
  },
  RelicConfig_13918_StoryDesc = {
    Text = "Probabilmente sono solo comuni venature d'agata. Forse."
  },
  RelicConfig_13919_BattleDesc = {
    Text = "La <ProficientInRealmsIconKeywords:Padronanza del Reame> aumenta di 50. Al momento della raccolta, scegli una Reliquia e trasformala in una casuale."
  },
  RelicConfig_13919_Desc = {
    Text = "La <ProficientInRealmsIconKeywords:Padronanza del Reame> aumenta di 50. Al momento della raccolta, scegli una Reliquia e trasformala in una casuale."
  },
  RelicConfig_13919_Name = {
    Text = "<WhiteQuality:Caleidoscopio>"
  },
  RelicConfig_13919_StoryDesc = {
    Text = "Ciò che pensi e vedi non sono che illusioni."
  },
  RelicConfig_13920_BattleDesc = {
    Text = "L'effetto di Debolezza inflitto aumenta del 5%. Quando applichi <WeaknessIconKeywords:Debolezza>, rubi temporaneamente [Arg1] <PowerIconKeywords:FOR> dal bersaglio."
  },
  RelicConfig_13920_Desc = {
    Text = "L'effetto Sintomo: Debolezza causato +5%. Quando applichi <WeaknessIconKeywords:Sintomo: Debolezza>, ruba temporaneamente [Arg1] <PowerIconKeywords:FOR> dal bersaglio."
  },
  RelicConfig_13920_Name = {
    Text = "<WhiteQuality:Foto Sbiadita>"
  },
  RelicConfig_13920_StoryDesc = {
    Text = "La foto sfocata porta con sé una Memoria sfocata, o forse — è l'incompletezza della Memoria a far sbiadire la foto."
  },
  RelicConfig_13921_BattleDesc = {
    Text = "Quando selezionato, scegli 2 Carte di Comando da eliminare e ottieni [Arg1] <PowerIconKeywords:FOR>."
  },
  RelicConfig_13921_Desc = {
    Text = "Quando selezionato, scegli 2 Carte di Comando da eliminare e ottieni [Arg1] <PowerIconKeywords:FOR>."
  },
  RelicConfig_13921_Name = {
    Text = "<RedQuality:Brace della Stella Nera>"
  },
  RelicConfig_13921_StoryDesc = {
    Text = "Le braci ancora ardono."
  },
  RelicConfig_13922_BattleDesc = {
    Text = "Dopo aver rilasciato 2 Esaltazioni per turno, tutti i Risvegliati ottengono 8 Aliemus. Dopo aver rilasciato 3 Esaltazioni, tutti i Risvegliati ottengono ulteriori 8 Aliemus."
  },
  RelicConfig_13922_Desc = {
    Text = "Dopo aver rilasciato 2 Esaltazioni per turno, tutti i Risvegliati ottengono 8 Aliemus. Dopo aver rilasciato 3 Esaltazioni, tutti i Risvegliati ottengono ulteriori 8 Aliemus."
  },
  RelicConfig_13922_Name = {
    Text = "<OrangeQuality:Sangue dei Dimenticati>"
  },
  RelicConfig_13922_StoryDesc = {
    Text = "Si scioglie gradualmente."
  },
  RelicConfig_13923_BattleDesc = {
    Text = "Per ogni istanza di Danno inflitta, ottieni [Arg1] Scudo. A inizio turno, per ogni 3 Scudi rimanenti, ottieni 1 <PowerIconKeywords:FOR> Temporanea e Danno Tentacolo."
  },
  RelicConfig_13923_Desc = {
    Text = "Per ogni istanza di Danno inflitta, ottieni [Arg1] Scudo. A inizio turno, per ogni 3 Scudi rimanenti, ottieni 1 <PowerIconKeywords:FOR> Temporanea e Danno Tentacolo."
  },
  RelicConfig_13923_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Occulto\">"
  },
  RelicConfig_13924_BattleDesc = {
    Text = "Ogni volta che l'effetto <TransitionIconKeywords:Balzo> viene attivato, ruba [Arg1] <PowerIconKeywords:FOR> Temporanea da tutti i nemici. Se è presente solo 1 nemico, ruba ulteriori [Arg2] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_13924_Desc = {
    Text = "Ogni volta che l'effetto <TransitionIconKeywords:Balzo> viene attivato, ruba [Arg1] <PowerIconKeywords:FOR> Temporanea da tutti i nemici. Se è presente solo 1 nemico, ruba ulteriori [Arg2] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_13924_Name = {
    Text = "<OrangeQuality:Deflettore spaziale>"
  },
  RelicConfig_13924_StoryDesc = {
    Text = "Lanciati nel vuoto."
  },
  RelicConfig_13925_BattleDesc = {
    Text = "Pesca 1 carta a inizio turno. Pesca 1 carta aggiuntiva se giochi 2 carte con lo stesso Costo di Arithmetica consecutivamente, fino a 3 volte per turno."
  },
  RelicConfig_13925_Desc = {
    Text = "Pesca 1 carta a inizio turno. Pesca 1 carta aggiuntiva se giochi 2 carte con lo stesso Costo di Arithmetica consecutivamente, fino a 3 volte per turno."
  },
  RelicConfig_13925_Name = {
    Text = "<OrangeQuality:Dispositivo di Gnosi>"
  },
  RelicConfig_13925_StoryDesc = {
    Text = "Onnisciente e Onnipotente."
  },
  RelicConfig_13926_BattleDesc = {
    Text = "All'inizio della battaglia, per ogni Orazione nel tuo mazzo, ottieni [Arg1] <PowerIconKeywords:FOR>. Per ogni Reliquia, recupera [Arg2] PV."
  },
  RelicConfig_13926_Desc = {
    Text = "All'inizio della battaglia, per ogni Orazione nel tuo mazzo, ottieni [Arg1] <PowerIconKeywords:FOR>. Per ogni Reliquia, recupera [Arg2] PV."
  },
  RelicConfig_13926_Name = {
    Text = "<OrangeQuality:☆Medaglia della Gilda☆>"
  },
  RelicConfig_13926_StoryDesc = {
    Text = "\"Indossalo, e sarai un membro della Camera di Commercio di Londinium.\""
  },
  RelicConfig_13927_BattleDesc = {
    Text = "Rimuovi 1 Carta sintomo al momento della raccolta. Potenzia 1 Orazione casuale a Orazione avanzata."
  },
  RelicConfig_13927_Desc = {
    Text = "Rimuovi 1 Carta sintomo al momento della raccolta. Potenzia 1 Orazione casuale a Orazione avanzata."
  },
  RelicConfig_13927_Name = {
    Text = "<WhiteQuality:Zampa di Coniglio Fortunata>"
  },
  RelicConfig_13927_StoryDesc = {
    Text = "Non così fortunato per il coniglio."
  },
  RelicConfig_13928_BattleDesc = {
    Text = "Tasso critico aumentato del 15%. Ogni carta giocata aumenta il Tasso critico temporaneo del 5%."
  },
  RelicConfig_13928_Desc = {
    Text = "Tasso critico aumentato del 15%. Ogni carta giocata aumenta il Tasso critico temporaneo del 5%."
  },
  RelicConfig_13928_Name = {
    Text = "<OrangeQuality:Specchio Rituale di Memphis>"
  },
  RelicConfig_13928_StoryDesc = {
    Text = "\"Cosa hai visto là dentro?\""
  },
  RelicConfig_13929_BattleDesc = {
    Text = "Ogni volta che perdi Vita, ottieni [Arg1] <plural value=\"[Arg1]\" singular=\"accumulo\" plural=\"accumuli\"> di <RetaliateIconKeywords:Contrattacco>. Se questo è il 3° attivazione in un singolo turno, attiva il <RetaliateIconKeywords:Contrattacco> al 100% contro tutti i nemici."
  },
  RelicConfig_13929_Desc = {
    Text = "Ogni volta che perdi Vita, ottieni [Arg1] <plural value=\"[Arg1]\" singular=\"accumulo\" plural=\"accumuli\"> di <RetaliateIconKeywords:Contrattacco>. Se questo è il 3° attivazione in un singolo turno, attiva il <RetaliateIconKeywords:Contrattacco> al 100% contro tutti i nemici."
  },
  RelicConfig_13929_Name = {
    Text = "<WhiteQuality:Orologio del Defunto>"
  },
  RelicConfig_13929_StoryDesc = {
    Text = "Portando con sé memorie e pianto, in cammino verso l'ignoto."
  },
  RelicConfig_13930_BattleDesc = {
    Text = "A fine turno, per ogni carta in mano, applica [Arg1] accumuli di <IntoxicationIconKeywords:Veleno> a tutti i nemici."
  },
  RelicConfig_13930_Desc = {
    Text = "A fine turno, per ogni carta in mano, applica [Arg1] accumuli di <IntoxicationIconKeywords:Veleno> a tutti i nemici."
  },
  RelicConfig_13930_Name = {
    Text = "<WhiteQuality:Unguento Sospetto>"
  },
  RelicConfig_13930_StoryDesc = {
    Text = "Una sorta di unguento artigianale per ferite esterne. Non utilizzare senza la supervisione di un dottore."
  },
  RelicConfig_13931_BattleDesc = {
    Text = "Ottieni [Arg1] <PowerIconKeywords:FRZ> quando raccolto. Ogni volta che un <DerivativeCardKeywords_2:\"Embrione\"> viene fuso, ottieni [Arg2] <PowerIconKeywords:FRZ> Temporanea."
  },
  RelicConfig_13931_Desc = {
    Text = "Ottieni [Arg1] <PowerIconKeywords:FRZ> quando raccolto. Ogni volta che un <DerivativeCardKeywords_2:\"Embrione\"> viene fuso, ottieni [Arg2] <PowerIconKeywords:FRZ> Temporanea."
  },
  RelicConfig_13931_Name = {
    Text = "<WhiteQuality:Ciottolo Insanguinato Dipinto>"
  },
  RelicConfig_13931_StoryDesc = {
    Text = "Uno, Due, Tre, Quattro, Cinque."
  },
  RelicConfig_13932_BattleDesc = {
    Text = "Ogni 3 volte che viene giocata \"Difesa\", ottieni [Arg1] Scudo del Personaggio. Il Risvegliatore corrispondente ottiene 15 Aliemus."
  },
  RelicConfig_13932_Desc = {
    Text = "Ogni 3 volte che viene giocata \"Difesa\", ottieni [Arg1] Scudo del Personaggio. Il Risvegliatore corrispondente ottiene 15 Aliemus."
  },
  RelicConfig_13932_Name = {
    Text = "<WhiteQuality:Guanti del Silenzio>"
  },
  RelicConfig_13932_StoryDesc = {
    Text = "Sono state macchiate da innumerevole sangue, lacrime e muffa."
  },
  RelicConfig_13933_BattleDesc = {
    Text = "Questa è una Reliquia settimanale 6 senza Effetto"
  },
  RelicConfig_13933_Desc = {
    Text = "Questa è una Reliquia settimanale 6 senza Effetto"
  },
  RelicConfig_13933_Name = {
    Text = "Sfida Giornaliera - Reliquia settimanale 6"
  },
  RelicConfig_13934_BattleDesc = {
    Text = "Questa è una Reliquia settimanale 5 senza Effetto"
  },
  RelicConfig_13934_Desc = {
    Text = "Questa è una Reliquia settimanale 5 senza Effetto"
  },
  RelicConfig_13934_Name = {
    Text = "Sfida Giornaliera Reliquia Sostituto settimanale 5"
  },
  RelicConfig_13935_BattleDesc = {
    Text = "Tasso di Crit. +10%. Dopo il primo Colpo Critico di ogni turno, aumenta il Tasso di Crit. di un ulteriore 20%. Dopo il 3° Colpo Critico di ogni turno, aumenta il Danno Crit. di un ulteriore 50%."
  },
  RelicConfig_13935_Desc = {
    Text = "Tasso di Crit. +10%. Dopo il primo Colpo Critico di ogni turno, aumenta il Tasso di Crit. di un ulteriore 20%. Dopo il 3° Colpo Critico di ogni turno, aumenta il Danno Crit. di un ulteriore 50%."
  },
  RelicConfig_13935_Name = {
    Text = "<WhiteQuality:Benedizione Festiva>"
  },
  RelicConfig_13935_StoryDesc = {
    Text = "Dovrebbe portare benedizioni a chi si ama."
  },
  RelicConfig_13936_BattleDesc = {
    Text = "Questa è una Reliquia settimanale 3 senza Effetto"
  },
  RelicConfig_13936_Desc = {
    Text = "Questa è una Reliquia settimanale 3 senza Effetto"
  },
  RelicConfig_13936_Name = {
    Text = "Sfida Giornaliera - Reliquia settimanale 3"
  },
  RelicConfig_13937_BattleDesc = {
    Text = "Questa è una Reliquia settimanale 2 senza Effetto"
  },
  RelicConfig_13937_Desc = {
    Text = "Questa è una Reliquia settimanale 2 senza Effetto"
  },
  RelicConfig_13937_Name = {
    Text = "Reliquia Sostituto settimanale 2 per le Sfide Giornaliere"
  },
  RelicConfig_13938_BattleDesc = {
    Text = "Questa è una Reliquia settimanale 1 senza Effetto"
  },
  RelicConfig_13938_Desc = {
    Text = "Questa è una Reliquia settimanale 1 senza Effetto"
  },
  RelicConfig_13938_Name = {
    Text = "Reliquia Sostituto settimanale 1 per la Sfida Giornaliera"
  },
  RelicConfig_13939_BattleDesc = {
    Text = "All'inizio del turno 3, aumenta il Tasso critico in questa battaglia del 15% e aggiungi 1 <DerivativeCardKeywords_39:Echi del Passato> alla tua mano."
  },
  RelicConfig_13939_Desc = {
    Text = "All'inizio del turno 3, aumenta il Tasso critico in questa battaglia del 15% e aggiungi 1 <DerivativeCardKeywords_39:Echi del Passato> alla tua mano."
  },
  RelicConfig_13939_Name = {
    Text = "<OrangeQuality:Reliquia del Passato>"
  },
  RelicConfig_13939_StoryDesc = {
    Text = "Un'offerta presentata un tempo."
  },
  RelicConfig_13940_BattleDesc = {
    Text = "Quando possiedi uno Scudo del Personaggio, questa Reliquia fornisce [Arg1] <PowerIconKeywords:FOR> Temporanea. Quando il tuo Scudo del Personaggio è superiore ai tuoi PV attuali, fornisce ulteriori [Arg2] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_13940_Desc = {
    Text = "Quando possiedi uno Scudo del Personaggio, questa Reliquia fornisce [Arg1] <PowerIconKeywords:FOR> Temporanea. Quando il tuo Scudo del Personaggio è superiore ai tuoi PV attuali, fornisce ulteriori [Arg2] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_13940_Name = {
    Text = "<WhiteQuality:Ventaglio di Piume di Colomba>"
  },
  RelicConfig_13940_StoryDesc = {
    Text = "Squisito, costoso, eppure poco pratico."
  },
  RelicConfig_13941_BattleDesc = {
    Text = "\"Colpo\" ripristina [Arg1] PV e riduce il proprio <IntoxicationIconKeywords:Veleno> di [Arg1] accumuli."
  },
  RelicConfig_13941_Desc = {
    Text = "\"Colpo\" ripristina [Arg1] PV e riduce il proprio <IntoxicationIconKeywords:Veleno> di [Arg1] accumuli."
  },
  RelicConfig_13941_Name = {
    Text = "<WhiteQuality:Pinza Emostatica>"
  },
  RelicConfig_13941_StoryDesc = {
    Text = "\"Presto, presto! Dammelo!\""
  },
  RelicConfig_13942_BattleDesc = {
    Text = "Ogni Tentacolo conferisce [Arg1] Scudo del Personaggio a fine turno. Nella Posizione Mare Tranquillo, questo effetto conferisce il 50% di Scudo del Personaggio aggiuntivo."
  },
  RelicConfig_13942_Desc = {
    Text = "Ogni Tentacolo conferisce [Arg1] Scudo del Personaggio a fine turno. Nella Posizione Mare Tranquillo, questo effetto conferisce il 50% di Scudo del Personaggio aggiuntivo."
  },
  RelicConfig_13942_Name = {
    Text = "<WhiteQuality:Appendice Senza Nome>"
  },
  RelicConfig_13942_StoryDesc = {
    Text = "Attenta a non pungerti."
  },
  RelicConfig_139929_BattleDesc = {
    Text = "A inizio turno, Saya ottiene [Arg1] Aliemus. Per ogni 100 Aliemus consumati dall'Esaltazione di Saya, un'\"Abilità\" generata casualmente si attiva 1 volta aggiuntiva."
  },
  RelicConfig_139929_Desc = {
    Text = "A inizio turno, Saya ottiene [Arg1] Aliemus. Per ogni 100 Aliemus consumati dall'Esaltazione di Saya, un'\"Abilità\" generata casualmente si attiva 1 volta aggiuntiva."
  },
  RelicConfig_139929_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale · Saya>"
  },
  RelicConfig_140276_BattleDesc = {
    Text = "<OrangeQuality:Ultima risorsa>: All'inizio del turno, per ogni 1% di vita massima persa, il danno finale temporaneo aumenta del 5%. Se nel turno precedente è stata attivata la resistenza alla morte, l'effetto raddoppia.\n<RedQuality:Supremo>: La vita massima di tutti i nemici aumenta del 300%."
  },
  RelicConfig_140276_Desc = {
    Text = "<OrangeQuality:Ultima risorsa>: All'inizio del turno, per ogni 1% di vita massima persa, il danno finale temporaneo aumenta del 5%. Se nel turno precedente è stata attivata la resistenza alla morte, l'effetto raddoppia.\n<RedQuality:Supremo>: La vita massima di tutti i nemici aumenta del 300%."
  },
  RelicConfig_140276_Name = {
    Text = "<RedQuality:Pendolo Dimensione-Duello>"
  },
  RelicConfig_140277_BattleDesc = {
    Text = "<OrangeQuality:Proliferazione>: Ogni turno, quando ciascun Risvegliato gioca la prima \"Abilità\", genera 2 copie originali temporanee di essa. Quando si gioca una carta comando con costo di calcolo pari a 0 o 1, tutti i Risvegliati ottengono 5 punti Furia.\n<RedQuality:Fortezza>: Quando si gioca una carta con costo di calcolo originale pari o superiore a 3, tutti i nemici ottengono uno scudo pari al 20% della vita massima."
  },
  RelicConfig_140277_Desc = {
    Text = "<OrangeQuality:Proliferazione>: Ogni turno, quando ciascun Risvegliato gioca la prima \"Abilità\", genera 2 copie originali temporanee di essa. Quando si gioca una carta comando con costo di calcolo pari a 0 o 1, tutti i Risvegliati ottengono 5 punti Furia.\n<RedQuality:Fortezza>: Quando si gioca una carta con costo di calcolo originale pari o superiore a 3, tutti i nemici ottengono uno scudo pari al 20% della vita massima."
  },
  RelicConfig_140277_Name = {
    Text = "<RedQuality:Pendolo Dimensione-Allerta>"
  },
  RelicConfig_140278_BattleDesc = {
    Text = [[
<OrangeQuality:Rigenerazione>: Gli effetti di scudo e recupero ottenuti aumentano del 25%. Quando si recupera vita o si ottiene uno scudo, per ogni 1% di vita massima recuperata o scudo ottenuto, si ottiene il 10% di potenziamento danno temporaneo.
<RedQuality:Sussurro>: Ogni turno si ottiene una riduzione della forza pari al 10% della vita massima.]]
  },
  RelicConfig_140278_Desc = {
    Text = [[
<OrangeQuality:Rigenerazione>: Gli effetti di scudo e recupero ottenuti aumentano del 25%. Quando si recupera vita o si ottiene uno scudo, per ogni 1% di vita massima recuperata o scudo ottenuto, si ottiene il 10% di potenziamento danno temporaneo.
<RedQuality:Sussurro>: Ogni turno si ottiene una riduzione della forza pari al 10% della vita massima.]]
  },
  RelicConfig_140278_Name = {
    Text = "<RedQuality:Pendolo Dimensione-Spavento>"
  },
  RelicConfig_140279_BattleDesc = {
    Text = [[
<OrangeQuality:Alba>: La Furia base di tutti i Risvegliati diminuisce di 30 punti. Il danno finale del primo Scoppio di Furia rilasciato ogni turno aumenta del 200%, scudo e recupero vita aumentano del 100%. Dopo aver rilasciato 5 Scoppi di Furia, scegli 1 Risvegliato da risvegliare e aggiorna gli effetti di potenziamento dello Scoppio di Furia.
<RedQuality:Esaurimento>: L'energia base della Chiave d'Argento aumenta del 200%]]
  },
  RelicConfig_140279_Desc = {
    Text = [[
<OrangeQuality:Alba>: La Furia base di tutti i Risvegliati diminuisce di 30 punti. Il danno finale del primo Scoppio di Furia rilasciato ogni turno aumenta del 200%, scudo e recupero vita aumentano del 100%. Dopo aver rilasciato 5 Scoppi di Furia, scegli 1 Risvegliato da risvegliare e aggiorna gli effetti di potenziamento dello Scoppio di Furia.
<RedQuality:Esaurimento>: L'energia base della Chiave d'Argento aumenta del 200%]]
  },
  RelicConfig_140279_Name = {
    Text = "<RedQuality:Pendolo Dimensione-Vudù>"
  },
  RelicConfig_140280_BattleDesc = {
    Text = "<OrangeQuality:Risveglio>: Dopo il primo Scoppio di Furia rilasciato ogni turno, resetta il tempo di ricarica dello Scoppio di Furia di quel Risvegliato e gli conferisce 50 Furia, generando copie temporanee di tutte le \"Abilità\" con costo di calcolo pari a 0.\n<RedQuality:Sigillo>: Dopo il primo Scoppio di Furia rilasciato ogni turno, sigilla gli altri Risvegliati."
  },
  RelicConfig_140280_Desc = {
    Text = "<OrangeQuality:Risveglio>: Dopo il primo Scoppio di Furia rilasciato ogni turno, resetta il tempo di ricarica dello Scoppio di Furia di quel Risvegliato e gli conferisce 50 Furia, generando copie temporanee di tutte le \"Abilità\" con costo di calcolo pari a 0.\n<RedQuality:Sigillo>: Dopo il primo Scoppio di Furia rilasciato ogni turno, sigilla gli altri Risvegliati."
  },
  RelicConfig_140280_Name = {
    Text = "<RedQuality:Pendolo Dimensione-Duello>"
  },
  RelicConfig_140281_BattleDesc = {
    Text = "<OrangeQuality:Eco>: All'inizio del turno, pesca le 3 carte comando con il costo di calcolo più alto dal mazzo di pesca. La prima carta comando giocata ogni turno ha effetto 2 volte.\n<RedQuality:Stordimento>: Dopo aver giocato una carta comando, scarta tutte le altre carte comando con costo di calcolo pari o superiore."
  },
  RelicConfig_140281_Desc = {
    Text = "<OrangeQuality:Eco>: All'inizio del turno, pesca le 3 carte comando con il costo di calcolo più alto dal mazzo di pesca. La prima carta comando giocata ogni turno ha effetto 2 volte.\n<RedQuality:Stordimento>: Dopo aver giocato una carta comando, scarta tutte le altre carte comando con costo di calcolo pari o superiore."
  },
  RelicConfig_140281_Name = {
    Text = "<RedQuality:Pendolo Dimensione-Confusione>"
  },
  RelicConfig_140282_BattleDesc = {
    Text = [[
<OrangeQuality:Potenza>: La <PowerIconKeywords:Forza> inflitta da tutti i Risvegliati aumenta del 50%. Ogni volta che si infligge 1 danno, si ottengono [Arg2] punti di <PowerIconKeywords:Forza> temporanea.
<RedQuality:Incorporeo>: All'inizio della battaglia, tutti i nemici ottengono 50 livelli di <ParcloseIconKeywords:Barriera>.]]
  },
  RelicConfig_140282_Desc = {
    Text = [[
<OrangeQuality:Potenza>: La <PowerIconKeywords:Forza> inflitta da tutti i Risvegliati aumenta del 50%. Ogni volta che si infligge 1 danno, si ottengono [Arg2] punti di <PowerIconKeywords:Forza> temporanea.
<RedQuality:Incorporeo>: All'inizio della battaglia, tutti i nemici ottengono 50 livelli di <ParcloseIconKeywords:Barriera>.]]
  },
  RelicConfig_140282_Name = {
    Text = "<RedQuality:Pendolo Dimensione-Agguato>"
  },
  RelicConfig_140840_BattleDesc = {
    Text = "Limite Massima della Mano +1. All'inizio della battaglia genera 1 carta \"<DerivativeCardKeywords_148:驭魇>\" e la inserisce nella Mano. Quando si gioca il \"Colpo Base\" di un Risvegliatore, il costo di Arithmetica di \"<DerivativeCardKeywords_148:驭魇>\" diminuisce di -1 e causa [Arg1] punti di Corrosione a tutti i nemici. Quando si gioca la \"DIF base\" di un Risvegliatore, si ottengono [Arg2] punti Potere e il Danno Finale e il Potere della prossima volta che si gioca \"<DerivativeCardKeywords_148:驭魇>\" aumentano del [Arg3]%."
  },
  RelicConfig_140840_Desc = {
    Text = "Limite Massima della Mano +1. All'inizio della battaglia genera 1 carta \"<DerivativeCardKeywords_148:驭魇>\" e la inserisce nella Mano. Quando si gioca il \"Colpo Base\" di un Risvegliatore, il costo di Arithmetica di \"<DerivativeCardKeywords_148:驭魇>\" diminuisce di -1 e causa [Arg1] punti di Corrosione a tutti i nemici. Quando si gioca la \"DIF base\" di un Risvegliatore, si ottengono [Arg2] punti Potere e il Danno Finale e il Potere della prossima volta che si gioca \"<DerivativeCardKeywords_148:驭魇>\" aumentano del [Arg3]%."
  },
  RelicConfig_140840_Name = {
    Text = "La Fatica Inutile"
  },
  RelicConfig_140840_StoryDesc = {
    Text = [[
Il Faticante teme il cambiamento, teme che le cose sfuggano al suo controllo, e nel profondo, con Isteria, teme la perdita.
 Soffia il fischio ancora e ancora, cercando di controllare tutto attraverso Il Fischio, ma non riesce a trattenere nulla.]]
  },
  RelicConfig_143665_BattleDesc = {
    Text = "Pontos guadagna [Arg1] Aliemus all'inizio del turno. Quando raccolto, genera 3 carte \"Gaunt\" Permanenti all'inizio della prossima battaglia. Pontos guadagna 3 Aliemus dopo aver giocato un \"Gaunt\"."
  },
  RelicConfig_143665_Desc = {
    Text = "Pontos guadagna [Arg1] Aliemus all'inizio del turno. Quando raccolto, genera 3 carte \"Gaunt\" Permanenti all'inizio della prossima battaglia. Pontos guadagna 3 Aliemus dopo aver giocato un \"Gaunt\"."
  },
  RelicConfig_143665_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Pontos>"
  },
  RelicConfig_145438_BattleDesc = {
    Text = "All'inizio del turno, ottieni [Arg1] Aliemus. Dopo aver usato \"Recisione di Mundus\", esegui Caccia: \"Lama Abissale\" all'inizio del turno successivo: Infliggi Danno pari al 400% dell'ATT di Lotan: Cetarchon a tutti i nemici. Questa Caccia beneficia del Bonus DAN di cui gode \"Recisione di Mundus\" tramite \"Grande Lama: Caduta della Balena\" e conta come un \"Colpo\"."
  },
  RelicConfig_145438_Desc = {
    Text = "All'inizio del turno, ottieni [Arg1] Aliemus. Dopo aver usato \"Recisione di Mundus\", esegui Caccia: \"Lama Abissale\" all'inizio del turno successivo: Infliggi Danno pari al 400% dell'ATT di Lotan: Cetarchon a tutti i nemici. Questa Caccia beneficia del Bonus DAN di cui gode \"Recisione di Mundus\" tramite \"Grande Lama: Caduta della Balena\" e conta come un \"Colpo\"."
  },
  RelicConfig_145438_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Lotan: Cetarchon>"
  },
  RelicConfig_146128_BattleDesc = {
    Text = "Limite Massima della Mano +1. All'Inizio del combattimento o dopo aver giocato \"<DerivativeCardKeywords_157:Osso della Spada>\", metti 1 \"<DerivativeCardKeywords_155:Osso della Follia>\" in Mano e Mischia 1 \"<DerivativeCardKeywords_156:Osso del Dolore>\" nel Mazzo di Pesca. Se in un turno vengono giocati sia \"<DerivativeCardKeywords_155:Osso della Follia>\" che \"<DerivativeCardKeywords_156:Osso del Dolore>\", combina le due carte in un \"<DerivativeCardKeywords_157:Osso della Spada>\" e mettilo in Mano."
  },
  RelicConfig_146128_Desc = {
    Text = "Limite Massima della Mano +1. All'Inizio del combattimento o dopo aver giocato \"<DerivativeCardKeywords_157:Osso della Spada>\", metti 1 \"<DerivativeCardKeywords_155:Osso della Follia>\" in Mano e Mischia 1 \"<DerivativeCardKeywords_156:Osso del Dolore>\" nel Mazzo di Pesca. Se in un turno vengono giocati sia \"<DerivativeCardKeywords_155:Osso della Follia>\" che \"<DerivativeCardKeywords_156:Osso del Dolore>\", combina le due carte in un \"<DerivativeCardKeywords_157:Osso della Spada>\" e mettilo in Mano."
  },
  RelicConfig_146128_Name = {
    Text = "Armatura di Osso di Balena"
  },
  RelicConfig_146128_StoryDesc = {
    Text = "Le ossa del Leviatano proteggono i suoi eletti, rendendoli invincibili e immortali."
  },
  RelicConfig_147547_BattleDesc = {
    Text = "A inizio turno, Casiah ottiene [Arg1] Aliemus. Pescare 1 carta conferisce a Casiah [Arg2] Aliemus. Quando Casiah scatena l'Esaltazione, tutti i nemici perdono [Arg3] FOR."
  },
  RelicConfig_147547_Desc = {
    Text = "A inizio turno, Casiah ottiene [Arg1] Aliemus. Pescare 1 carta conferisce a Casiah [Arg2] Aliemus. Quando Casiah scatena l'Esaltazione, tutti i nemici perdono [Arg3] FOR."
  },
  RelicConfig_147547_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Casiah>"
  },
  RelicConfig_147665_BattleDesc = {
    Text = "Il Limite di Arithmetica e il numero di carte pescate per turno +1. All'inizio del turno <FaxianKeywords:Scopri> 3 \"<Caroboo_Tips:Pistoles de Marie>\" e scegline una. Solo 1 è autentica: se scegli quella autentica, ottieni il suo effetto positivo e disperdi 1 Stato negativo casuale su di te; se scegli quella falsa, subisci il suo effetto negativo e la prossima volta che <FaxianKeywords:Scopri>, le opzioni autentiche +1 e gli effetti raddoppiano; si reimposta dopo aver scelto quella autentica."
  },
  RelicConfig_147665_Desc = {
    Text = "Il Limite di Arithmetica e il numero di carte pescate per turno +1. All'inizio del turno <FaxianKeywords:Scopri> 3 \"<Caroboo_Tips:Pistoles de Marie>\" e scegline una. Solo 1 è autentica: se scegli quella autentica, ottieni il suo effetto positivo e disperdi 1 Stato negativo casuale su di te; se scegli quella falsa, subisci il suo effetto negativo e la prossima volta che <FaxianKeywords:Scopri>, le opzioni autentiche +1 e gli effetti raddoppiano; si reimposta dopo aver scelto quella autentica."
  },
  RelicConfig_147665_Name = {
    Text = "Pistoles de Marie"
  },
  RelicConfig_147665_StoryDesc = {
    Text = "Dolce e prezioso... o forse no?"
  },
  RelicConfig_148525_BattleDesc = {
    Text = "All'inizio del turno, Giuramento · Ogier ottiene [Arg1] Aliemus e \"Ondata Oscura\" non riduce più il numero di pescate."
  },
  RelicConfig_148525_Desc = {
    Text = "All'inizio del turno, Giuramento · Ogier ottiene [Arg1] Aliemus e \"Ondata Oscura\" non riduce più il numero di pescate."
  },
  RelicConfig_148525_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale·Giuramento Oscuro·Ogier>"
  },
  RelicConfig_149665_BattleDesc = {
    Text = "Il terreno attuale conta come \"Campo di ghiaccio.\"\nIn Iperborea: Dopo la Fase di Pesca, applica 1 accumulo di <SlowIconKeywords:Stagnazione> e <RetainIconKeywords:Conservare> alle 2 Carte di comando non congelate con il Costo di Arithmetica più alto in mano. Quando una qualsiasi Carta di comando ha almeno 3 accumuli di <SlowIconKeywords:Stagnazione>, rimuovi la sua <SlowIconKeywords:Stagnazione> e <RetainIconKeywords:Conservare> (ottenuti in questa battaglia), Congelala e applica 25 accumuli di <TempPowerKeywords2:Potenziare>."
  },
  RelicConfig_149665_Desc = {
    Text = "Il terreno attuale conta come \"Campo di ghiaccio.\"\nIn Iperborea: Dopo la Fase di Pesca, applica 1 accumulo di <SlowIconKeywords:Stagnazione> e <RetainIconKeywords:Conservare> alle 2 Carte di comando non congelate con il Costo di Arithmetica più alto in mano. Quando una qualsiasi Carta di comando ha almeno 3 accumuli di <SlowIconKeywords:Stagnazione>, rimuovi la sua <SlowIconKeywords:Stagnazione> e <RetainIconKeywords:Conservare> (ottenuti in questa battaglia), Congelala e applica 25 accumuli di <TempPowerKeywords2:Potenziare>."
  },
  RelicConfig_149665_Name = {
    Text = "<OrangeQuality:Globo di Cristallo>"
  },
  RelicConfig_149665_StoryDesc = {
    Text = "Non porta il freddo.\nRicorda semplicemente alla terra che l'inverno non se n'è mai andato."
  },
  RelicConfig_20164_BattleDesc = {
    Text = "Per ogni istanza di danno inflitto, ottieni [Arg1] <PowerIconKeywords:FOR> Temporaneo, fino a 5 accumuli. Quando il limite di accumuli è raggiunto, ottieni [Arg1] <PowerIconKeywords:FOR>."
  },
  RelicConfig_20164_Desc = {
    Text = "Per ogni istanza di danno inflitto, ottieni [Arg1] <PowerIconKeywords:FOR> Temporaneo, fino a 5 accumuli. Quando il limite di accumuli è raggiunto, ottieni [Arg1] <PowerIconKeywords:FOR>."
  },
  RelicConfig_20164_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Insonne\">"
  },
  RelicConfig_20165_BattleDesc = {
    Text = "Risveglia tutti i Risvegliatori. Dopo aver giocato <ExaltIconKeywords:Risveglio>, ottieni casualmente 2 Carte di comando di quel Risvegliatore con \"Esaurimento\" e \"Fugace\"."
  },
  RelicConfig_20165_Desc = {
    Text = "Risveglia tutti i Risvegliatori. Dopo aver giocato <ExaltIconKeywords:Risveglio>, ottieni casualmente 2 Carte di comando di quel Risvegliatore con \"Esaurimento\" e \"Fugace\"."
  },
  RelicConfig_20165_Name = {
    Text = "<OrangeQuality:Oracolo Divino+>"
  },
  RelicConfig_20165_StoryDesc = {
    Text = "Egli disse: \"Non avere paura.\""
  },
  RelicConfig_20166_BattleDesc = {
    Text = "La <ProficientInRealmsIconKeywords:Padronanza del Reame> aumenta di 100. Ritorna la prima carta giocata ogni turno nella tua mano. All'inizio di un Turno Ultra, aumenta il Limite di Mano di 5 e Copia la tua mano."
  },
  RelicConfig_20166_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Padronanza del Reame> aumentata di 100. Rimetti in mano dalla Pila degli scarti la prima carta giocata ogni turno. All'inizio di un Turno Ultra, il limite di carte In Mano per quel turno aumenta di 5 e la tua mano viene duplicata; le copie ottengono <NothingnessIconKeywords:Effimero> e <DepleteIconKeywords:Consumo>."
  },
  RelicConfig_20166_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Furto di Sogni\">"
  },
  RelicConfig_20167_BattleDesc = {
    Text = "A fine turno, se rimane Arithmetica, pesca 2 carte extra il turno successivo; se rimangono carte in mano, ottieni 2 Arithmetica extra il turno successivo."
  },
  RelicConfig_20167_Desc = {
    Text = "A fine turno, se rimane Arithmetica, pesca 2 carte extra il turno successivo; se rimangono carte in mano, ottieni 2 Arithmetica extra il turno successivo."
  },
  RelicConfig_20167_Name = {
    Text = "<OrangeQuality:Disco Solare+>"
  },
  RelicConfig_20167_StoryDesc = {
    Text = "Indovina, è nero o bianco?"
  },
  RelicConfig_20168_BattleDesc = {
    Text = "Limite Tentacoli +2. Dopo aver rilasciato l'Esaltazione, Danno Tentacolo +[Arg1]. Se l'Esaltazione viene rilasciata 3 volte in un turno, attiva tutti i Tentacoli una volta."
  },
  RelicConfig_20168_Desc = {
    Text = "Limite Tentacoli +2. Dopo aver rilasciato l'Esaltazione, Danno Tentacolo +[Arg1]. Se l'Esaltazione viene rilasciata 3 volte in un turno, attiva tutti i Tentacoli una volta."
  },
  RelicConfig_20168_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Dormiveglia\">"
  },
  RelicConfig_20169_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Padronanza del Reame> +100. Per ogni carta giocata, <EmbryoFusionIconKeywords:Fusione Embrionale> +10; quando i Vita sono sotto il 25%, l'aumento diventa 20%. Questo effetto può attivarsi un massimo di 10 volte per turno."
  },
  RelicConfig_20169_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Padronanza del Reame> +100. Per ogni carta giocata, <EmbryoFusionIconKeywords:Fusione Embrionale> +10; quando i Vita sono sotto il 25%, l'aumento diventa 20%. Questo effetto può attivarsi un massimo di 10 volte per turno."
  },
  RelicConfig_20169_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Ondata\">"
  },
  RelicConfig_20170_BattleDesc = {
    Text = "A inizio battaglia, tutti i Risvegliati ottengono 50 Aliemus. Metti 2 copie di <DerivativeCardKeywords_1:\"Echi di Ombre Perdute\"> nella mano."
  },
  RelicConfig_20170_Desc = {
    Text = "A inizio battaglia, tutti i Risvegliati ottengono 50 Aliemus. Metti 2 copie di <DerivativeCardKeywords_1:\"Echi di Ombre Perdute\"> nella mano."
  },
  RelicConfig_20170_Name = {
    Text = "<OrangeQuality:Relè di Segnale+>"
  },
  RelicConfig_20170_StoryDesc = {
    Text = "Attendi o temi il momento in cui suonerà."
  },
  RelicConfig_20171_BattleDesc = {
    Text = "Quando raccolto, ottieni casualmente 1 Reliquia d'argento, 1 Reliquia d'oro e 1 Reliquia maledetta."
  },
  RelicConfig_20171_Desc = {
    Text = "Quando raccolto, ottieni casualmente 1 Reliquia d'argento, 1 Reliquia d'oro e 1 Reliquia maledetta."
  },
  RelicConfig_20171_Name = {
    Text = "<OrangeQuality:Visione Inversa+>"
  },
  RelicConfig_20171_StoryDesc = {
    Text = "Nella strana era, i fiori sono i principali spettatori dell'umanità.\nResta immobile; preferiscono le esibizioni silenziose."
  },
  RelicConfig_20172_BattleDesc = {
    Text = "Quando il numero di Carte di comando giocate in un turno raggiunge 3, ottieni 1 <DerivativeCardKeywords_4:\"Intuizione\">; a 6 carte, ottieni un'altra <DerivativeCardKeywords_4:\"Intuizione\">; e al raggiungimento di 10 carte, puoi selezionare 2 carte dal tuo mazzo da aggiungere alla tua mano all'inizio del turno successivo."
  },
  RelicConfig_20172_Desc = {
    Text = "Quando il numero di Carte di comando giocate in un turno raggiunge 3, ottieni 1 <DerivativeCardKeywords_4:\"Intuizione\">; a 6 carte, ottieni un'altra <DerivativeCardKeywords_4:\"Intuizione\">; e al raggiungimento di 10 carte, puoi selezionare 2 carte dal tuo mazzo da aggiungere alla tua mano all'inizio del turno successivo."
  },
  RelicConfig_20172_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Eco\">"
  },
  RelicConfig_20173_BattleDesc = {
    Text = "Infliggi il 50% di Danno in più ai nemici con debuff e ottieni 100 Aliemus alla loro eliminazione."
  },
  RelicConfig_20173_Desc = {
    Text = "Infliggi il 50% di Danno in più ai nemici con debuff e ottieni 100 Aliemus alla loro eliminazione."
  },
  RelicConfig_20173_Name = {
    Text = "<OrangeQuality:Bastone dell'Ierofante+>"
  },
  RelicConfig_20173_StoryDesc = {
    Text = "Pietà Insanzionata"
  },
  RelicConfig_20174_BattleDesc = {
    Text = "Al momento del ritiro, Amplificazione del Danno del Team x150%. All'inizio del turno, infliggi [Arg1] <FixedDamage:DAN Puro> a un nemico casuale. Per ogni Posse usata in questa battaglia, aumenta il DAN inflitto di [Arg2]. Questo bonus DAN beneficia del bonus di Amplificazione del Danno del Team."
  },
  RelicConfig_20174_Desc = {
    Text = "Al momento del ritiro, Amplificazione del Danno del Team x150%. All'inizio del turno, infliggi [Arg1] <FixedDamage:DAN Puro> a un nemico casuale. Per ogni Posse usata in questa battaglia, aumenta il DAN inflitto di [Arg2]. Questo bonus DAN beneficia del bonus di Amplificazione del Danno del Team."
  },
  RelicConfig_20174_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Oblio\">"
  },
  RelicConfig_20175_BattleDesc = {
    Text = "L'effetto di <WeaknessIconKeywords:Debolezza> è aumentato dell'8% e l'effetto di <VulnerabilityIconKeywords:Vulnerabile> è aumentato del 25%. Quando applichi <WeaknessIconKeywords:Debolezza> o <VulnerabilityIconKeywords:Vulnerabile>, rubi temporaneamente [Arg1] <PowerIconKeywords:FOR> al bersaglio."
  },
  RelicConfig_20175_Desc = {
    Text = "L'effetto di <WeaknessIconKeywords:Debolezza> è aumentato dell'8% e l'effetto di <VulnerabilityIconKeywords:Vulnerabile> è aumentato del 25%. Quando applichi <WeaknessIconKeywords:Debolezza> o <VulnerabilityIconKeywords:Vulnerabile>, rubi temporaneamente [Arg1] <PowerIconKeywords:FOR> al bersaglio."
  },
  RelicConfig_20175_Name = {
    Text = "<OrangeQuality:Foto Sbiadita+>"
  },
  RelicConfig_20175_StoryDesc = {
    Text = "La foto sfocata porta con sé una Memoria sfocata, o forse — è l'incompletezza della Memoria a far sbiadire la foto."
  },
  RelicConfig_20176_BattleDesc = {
    Text = "A inizio turno, ottieni 2 Arithmetica per ogni nemico. Quando un nemico viene ucciso da Danno attivo, infliggi il doppio del Danno in eccesso agli altri nemici come <BleedingIconKeywords:Salasso>."
  },
  RelicConfig_20176_Desc = {
    Text = "A inizio turno, ottieni 2 Arithmetica per ogni nemico. Quando un nemico viene ucciso da Danno attivo, infliggi il doppio del Danno in eccesso agli altri nemici come <BleedingIconKeywords:Salasso>."
  },
  RelicConfig_20176_Name = {
    Text = "<OrangeQuality:Canto della Plebaglia+>"
  },
  RelicConfig_20176_StoryDesc = {
    Text = "Progettato appositamente per tormentare le orecchie."
  },
  RelicConfig_20177_BattleDesc = {
    Text = "Raccogliere questo oggetto raddoppia la Resistenza alla Morte. Dopo aver inflitto Danno, applica anche <BleedingIconKeywords:Salasso> al bersaglio pari al 50% del Danno. Ogni volta che la Resistenza alla Morte si attiva, tutti i nemici attivano immediatamente 1 istanza di Salasso."
  },
  RelicConfig_20177_Desc = {
    Text = "Raccogliere questo oggetto raddoppia la Resistenza alla Morte. Dopo aver inflitto Danno, applica anche <BleedingIconKeywords:Salasso> al bersaglio pari al 50% del Danno. Ogni volta che la Resistenza alla Morte si attiva, tutti i nemici attivano immediatamente 1 istanza di Salasso."
  },
  RelicConfig_20177_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Rianimazione\">"
  },
  RelicConfig_20178_BattleDesc = {
    Text = "Ogni volta che infliggi 1 istanza di Danno attivo, ottieni 3 Aliemus e infliggi [Arg1] accumuli di <IntoxicationIconKeywords:Veleno> al bersaglio. Se il numero di attivazioni raggiunge 25 in questa battaglia, infliggi immediatamente <IntoxicationIconKeywords:Veleno> a tutti i bersagli nemici."
  },
  RelicConfig_20178_Desc = {
    Text = "Ogni volta che infliggi 1 istanza di Danno attivo, ottieni 3 Aliemus e infliggi [Arg1] accumuli di <IntoxicationIconKeywords:Veleno> al bersaglio. Se il numero di attivazioni raggiunge 25 in questa battaglia, infliggi immediatamente <IntoxicationIconKeywords:Veleno> a tutti i bersagli nemici."
  },
  RelicConfig_20178_Name = {
    Text = "<OrangeQuality:Telaio Dimenticato+>"
  },
  RelicConfig_20178_StoryDesc = {
    Text = "Una madre amorevole risana le ferite del cuore."
  },
  RelicConfig_21906_BattleDesc = {
    Text = "\"Colpo\" conferisce 3 Arithmetica e scarta 1 carta casuale; \"Difesa\" pesca 3 carte e rimuove 1 Arithmetica."
  },
  RelicConfig_21906_Desc = {
    Text = "\"Colpo\" conferisce 3 Arithmetica e scarta 1 carta casuale; \"Difesa\" pesca 3 carte e rimuove 1 Arithmetica."
  },
  RelicConfig_21906_Name = {
    Text = "<RedQuality:Disco Gioioso+>"
  },
  RelicConfig_21906_StoryDesc = {
    Text = "La registrazione dell'ultima esibizione del celebre violinista.\nDa allora, è in grado di evocare le fiamme."
  },
  RelicConfig_23688_BattleDesc = {
    Text = "Ogni volta che Divorare viene attivato, ottieni 30 <EmbryoFusionIconKeywords:Fusione Embrionale> e [Arg1] <PowerIconKeywords:FOR>. Se attivato una seconda volta nello stesso turno, ottieni 1 Arithmetica e peschi 1 carta. Se attivato una terza volta nello stesso turno, ottieni 2 Arithmetica e peschi 2 carte."
  },
  RelicConfig_23688_Desc = {
    Text = "Ogni volta che Divorare viene attivato, ottieni 30 <EmbryoFusionIconKeywords:Fusione Embrionale> e [Arg1] <PowerIconKeywords:FOR>. Se attivato una seconda volta nello stesso turno, ottieni 1 Arithmetica e peschi 1 carta. Se attivato una terza volta nello stesso turno, ottieni 2 Arithmetica e peschi 2 carte."
  },
  RelicConfig_23688_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Contraccolpo\">"
  },
  RelicConfig_23689_BattleDesc = {
    Text = "Raccogliere conferisce a tutti i Risvegliati 30 Aliemus. Ogni utilizzo di Esaltazione aumenta il Conteggio di 1. Dopo aver rilasciato il Seguito, ottieni [Arg1] Allerta temporanea, [Arg2] <PowerIconKeywords:FOR> Temporaneo, e tutti i Risvegliati ottengono 6 Aliemus, consumando tutto il Conteggio; ogni punto di Conteggio fa attivare l'effetto 1 volta aggiuntiva."
  },
  RelicConfig_23689_Desc = {
    Text = "Raccogliere conferisce a tutti i Risvegliati 30 Aliemus. Ogni utilizzo di Esaltazione aumenta il Conteggio di 1. Dopo aver rilasciato il Seguito, ottieni [Arg1] Allerta temporanea, [Arg2] <PowerIconKeywords:FOR> Temporaneo, e tutti i Risvegliati ottengono 6 Aliemus, consumando tutto il Conteggio; ogni punto di Conteggio fa attivare l'effetto 1 volta aggiuntiva."
  },
  RelicConfig_23689_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Accumulo\">"
  },
  RelicConfig_23690_BattleDesc = {
    Text = "Per ogni Arithmetica aggiuntiva o carta extra pescata, ruba [Arg1] <PowerIconKeywords:FOR> a tutti i nemici, ottieni il 4% di Tasso critico temporaneo, e l'effetto è raddoppiato nelle Battaglie Élite o Battaglia Boss. Dopo l'inizio di un Turno Ultra, ottieni [Arg2] <PowerIconKeywords:FOR> e aumenta il Danno Crit. del 15%."
  },
  RelicConfig_23690_Desc = {
    Text = "Per ogni Arithmetica aggiuntiva o carta extra pescata, ruba [Arg1] <PowerIconKeywords:FOR> a tutti i nemici, ottieni il 4% di Tasso critico temporaneo, e l'effetto è raddoppiato nelle Battaglie Élite o Battaglia Boss. Dopo l'inizio di un Turno Ultra, ottieni [Arg2] <PowerIconKeywords:FOR> e aumenta il Danno Crit. del 15%."
  },
  RelicConfig_23690_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Intervallo\">"
  },
  RelicConfig_23691_BattleDesc = {
    Text = "Ogni 5 istanze di Danno inflitto, ripristina [Arg1] HP. Per ogni HP perso, Danno del Tentacolo +[Arg2]. Se vengono persi più di [Arg3] HP, attiva tutti i Tentacoli una volta."
  },
  RelicConfig_23691_Desc = {
    Text = "Ripristina [Arg1] HP ogni 5 colpi subiti. Aumenta il Danno del Tentacolo di +[Arg2] per ogni HP perso. Se gli HP persi superano il 10% degli HP massimi, attiva tutti i Tentacoli una volta."
  },
  RelicConfig_23691_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Maree\">"
  },
  RelicConfig_35135_BattleDesc = {
    Text = "Per ogni istanza di danno inflitta, ottieni [Arg1] <PowerIconKeywords:FOR> temporanea e [Arg2] Danno tentacolo temporaneo, con un massimo di 12 attivazioni per turno. Se vengono inflitte 4 istanze di danno in un singolo turno, applica 1 accumulo di Vulnerabile a tutti i nemici e ottieni [Arg3] Scudo del Personaggio. Se vengono inflitte 8 istanze di danno nello stesso turno, applica 1 accumulo di Debolezza a tutti i nemici e ripristina [Arg3] PV."
  },
  RelicConfig_35135_Desc = {
    Text = "Per ogni istanza di danno inflitta, ottieni [Arg1] <PowerIconKeywords:FOR> temporanea e [Arg2] Danno tentacolo temporaneo, con un massimo di 12 attivazioni per turno. Se vengono inflitte 4 istanze di danno in un singolo turno, applica 1 accumulo di Vulnerabile a tutti i nemici e ottieni [Arg3] Scudo del Personaggio. Se vengono inflitte 8 istanze di danno nello stesso turno, applica 1 accumulo di Debolezza a tutti i nemici e ripristina [Arg3] PV."
  },
  RelicConfig_35135_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Trance\">"
  },
  RelicConfig_35136_BattleDesc = {
    Text = "Il Danno di \"Colpo\" e la generazione di Scudo del Personaggio di \"Difesa\" aumentano del 30%. Se giochi 4 o più carte \"Colpo\" e \"Difesa\" in un turno, peschi 2 carte e ottieni 1 Arithmetica all'inizio del turno successivo."
  },
  RelicConfig_35136_Desc = {
    Text = "Il Danno di \"Colpo\" e la generazione di Scudo del Personaggio di \"Difesa\" aumentano del 30%. Se giochi 4 o più carte \"Colpo\" e \"Difesa\" in un turno, peschi 2 carte e ottieni 1 Arithmetica all'inizio del turno successivo."
  },
  RelicConfig_35136_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Ostinato\">"
  },
  RelicConfig_35137_BattleDesc = {
    Text = "Ogni carta giocata conferisce [Arg1] <PowerIconKeywords:FOR> Temporaneo/a e recupera [Arg2] HP. Dopo aver inflitto Danno attivo, rimuovi [Arg2] <PowerIconKeywords:FOR> ottenuti da questa Reliquia. Il Risvegliato ottiene 30 Aliemus per ogni nemico ucciso."
  },
  RelicConfig_35137_Desc = {
    Text = "Ogni carta giocata conferisce [Arg1] <PowerIconKeywords:FOR> Temporaneo/a e recupera [Arg2] HP. Dopo aver inflitto Danno attivo, rimuovi [Arg2] <PowerIconKeywords:FOR> ottenuti da questa Reliquia. Il Risvegliato ottiene 30 Aliemus per ogni nemico ucciso."
  },
  RelicConfig_35137_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Carica\">"
  },
  RelicConfig_35138_BattleDesc = {
    Text = "Dopo aver rilasciato un'Esaltazione, applica [Arg1] Veleno a un nemico casuale. Per ogni Carta di comando giocata, ottieni [Arg2] Contatore Temporaneo. Alla fine di ogni 4 turni, infliggi Danno a tutti i nemici pari alla somma dei loro accumuli di Veleno e dei tuoi accumuli di Contatore."
  },
  RelicConfig_35138_Desc = {
    Text = "Dopo aver rilasciato un'Esaltazione, applica [Arg1] Veleno a un nemico casuale. Per ogni Carta di comando giocata, ottieni [Arg2] Contatore Temporaneo. Alla fine di ogni 4 turni, infliggi Danno a tutti i nemici pari alla somma dei loro accumuli di Veleno e dei tuoi accumuli di Contatore."
  },
  RelicConfig_35138_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Proliferazione\">"
  },
  RelicConfig_35139_BattleDesc = {
    Text = "Al momento della raccolta, aumenta l'Amplificazione del Danno della squadra del 30%. Ogni 4ª istanza di Danno inflitto sarà un Colpo Critico, e il Danno Crit. è aumentato del 50%. Se il colpo risulta in un'uccisione, ottieni 5 Sigillo Nero."
  },
  RelicConfig_35139_Desc = {
    Text = "Al momento della raccolta, aumenta l'Amplificazione del Danno della squadra del 30%. Ogni 4ª istanza di Danno inflitto sarà un Colpo Critico, e il Danno Crit. è aumentato del 50%. Se il colpo risulta in un'uccisione, ottieni 5 Sigillo Nero."
  },
  RelicConfig_35139_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Fine\">"
  },
  RelicConfig_36823_BattleDesc = {
    Text = "Dopo un'Esaltazione, peschi 1 carta. Per ogni carta scartata, tutti i Risvegliati ottengono 3 Aliemus, fino a 15 per turno."
  },
  RelicConfig_36823_Desc = {
    Text = "Dopo un'Esaltazione, peschi 1 carta. Per ogni carta scartata, tutti i Risvegliati ottengono 3 Aliemus, fino a 15 per turno."
  },
  RelicConfig_36823_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Reciprocità\">"
  },
  RelicConfig_36824_BattleDesc = {
    Text = "Pesca 1 carta ogni volta che viene spesa Arithmetica, fino a 5 volte per turno. Ottieni 2 Arithmetica ogni volta che il mazzo viene rimischiato."
  },
  RelicConfig_36824_Desc = {
    Text = "Pesca 1 carta ogni volta che viene spesa Arithmetica, fino a 5 volte per turno. Ottieni 2 Arithmetica ogni volta che il mazzo viene rimischiato."
  },
  RelicConfig_36824_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Insonne\">"
  },
  RelicConfig_39302_BattleDesc = {
    Text = "Mischia 1 <DerivativeCardKeywords_4:\"Intuizione\"> nel Mazzo di Pesca ogni 4 istanze di Danno inflitto, fino a 3 volte per turno. Dopo un'Esaltazione, gioca e consuma tutte le <DerivativeCardKeywords_4:\"Intuizione\"> nel Mazzo di Pesca."
  },
  RelicConfig_39302_Desc = {
    Text = "Mischia 1 <DerivativeCardKeywords_4:\"Intuizione\"> nel Mazzo di Pesca ogni 4 istanze di Danno inflitto, fino a 3 volte per turno. Dopo un'Esaltazione, gioca e consuma tutte le <DerivativeCardKeywords_4:\"Intuizione\"> nel Mazzo di Pesca."
  },
  RelicConfig_39302_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Illusione\">"
  },
  RelicConfig_39303_BattleDesc = {
    Text = "Quando l'Arithmetica corrente è dispari, ottieni [Arg2] Allerta temporanea aggiuntiva. Quando l'Arithmetica corrente è pari, ottieni [Arg1] <PowerIconKeywords:FOR> temporanea e [Arg3] Danno tentacolo temporaneo aggiuntivi. Ogni Reliquia dorata aumenta l'effetto di questa Reliquia del 50%, e ogni Reliquia maledetta lo aumenta dell'80%."
  },
  RelicConfig_39303_Desc = {
    Text = "Quando l'Arithmetica corrente è dispari, ottieni [Arg2] Allerta temporanea aggiuntiva. Quando l'Arithmetica corrente è pari, ottieni [Arg1] <PowerIconKeywords:FOR> temporanea e [Arg3] Danno tentacolo temporaneo aggiuntivi. Ogni Reliquia dorata aumenta l'effetto di questa Reliquia del 50%, e ogni Reliquia maledetta lo aumenta dell'80%."
  },
  RelicConfig_39303_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Risveglio dal Sogno\">"
  },
  RelicConfig_44192_BattleDesc = {
    Text = "Tutti i Risvegli ottengono 20 Aliemus a inizio turno. I PV massimi sono ridotti del 50% al momento della raccolta."
  },
  RelicConfig_44192_Desc = {
    Text = "Tutti i Risvegli ottengono 20 Aliemus a inizio turno. I PV massimi sono ridotti del 50% al momento della raccolta."
  },
  RelicConfig_44192_Name = {
    Text = "<RedQuality:Peccaminoso· Manifestazione dell'Incubo>"
  },
  RelicConfig_44192_StoryDesc = {
    Text = "L'indulgente sonno profondo è desiderio, che divora ogni cosa prima ancora che tu te ne renda conto."
  },
  RelicConfig_44300_BattleDesc = {
    Text = "Tutti i Risvegli ottengono 25 Aliemus a inizio turno. PV massimi x3 al momento della raccolta."
  },
  RelicConfig_44300_Desc = {
    Text = "Tutti i Risvegli ottengono 25 Aliemus a inizio turno. PV massimi x3 al momento della raccolta."
  },
  RelicConfig_44300_Name = {
    Text = "<OrangeQuality:Benedetto: Manifestazione dell'Incubo>"
  },
  RelicConfig_44300_StoryDesc = {
    Text = "Non temere, non esitare. Questo non è che Un Sogno Fugace; la luce del Padre Supremo risplende ancora su di te."
  },
  RelicConfig_44592_BattleDesc = {
    Text = "Dopo la battaglia, ottieni 100 Sigilli Neri e 2 Carte Sintomo."
  },
  RelicConfig_44592_Desc = {
    Text = "Dopo la battaglia, ottieni 100 Sigilli Neri e 2 Carte Sintomo."
  },
  RelicConfig_44592_Name = {
    Text = "<RedQuality:Peccaminoso· Impronta di Giada>"
  },
  RelicConfig_44592_StoryDesc = {
    Text = "Gli antichi peccati sono incisi qui."
  },
  RelicConfig_44593_BattleDesc = {
    Text = "Al momento della raccolta, si trasforma in 1 Reliquia Peccaminosa casuale (esclusa se stessa) e ottieni 75 Sigilli Neri."
  },
  RelicConfig_44593_Desc = {
    Text = "Al momento della raccolta, si trasforma in 1 Reliquia Peccaminosa casuale (esclusa se stessa) e ottieni 75 Sigilli Neri."
  },
  RelicConfig_44593_Name = {
    Text = "<RedQuality:Peccaminoso· Stele Maledetta>"
  },
  RelicConfig_44593_StoryDesc = {
    Text = "Ascolta, qualcuno chiama dall'interno."
  },
  RelicConfig_44594_BattleDesc = {
    Text = "Ogni 2 turni, raddoppia il Danno Attivo e da Tentacolo subito da tutti i nemici in quel turno. Tuttavia, dopo aver attivato Esaltazione in quel turno, sigilla tutti i Risvegliatori per 1 turno e renditi Vulnerabile."
  },
  RelicConfig_44594_Desc = {
    Text = "Ogni 2 turni, raddoppia il Danno Attivo e da Tentacolo subito da tutti i nemici in quel turno. Tuttavia, dopo aver attivato Esaltazione in quel turno, sigilla tutti i Risvegliatori per 1 turno e renditi Vulnerabile."
  },
  RelicConfig_44594_Name = {
    Text = "<RedQuality:Peccaminoso: Resti del Viandante>"
  },
  RelicConfig_44594_StoryDesc = {
    Text = "Una parte sacra.\nSeparata dal torso, è stata contaminata dal peccato."
  },
  RelicConfig_44597_BattleDesc = {
    Text = "Per ogni istanza di Danno attivo inflitta, applica [Arg1] accumulo/i di <BleedingIconKeywords:Salasso> a se stesso e [Arg2] accumulo/i di <BleedingIconKeywords:Salasso> al bersaglio."
  },
  RelicConfig_44597_Desc = {
    Text = "Per ogni istanza di Danno attivo inflitta, applica [Arg1] accumulo/i di <BleedingIconKeywords:Salasso> a se stesso e [Arg2] accumulo/i di <BleedingIconKeywords:Salasso> al bersaglio."
  },
  RelicConfig_44597_Name = {
    Text = "<RedQuality:Peccaminoso· Mente dello Sciame>"
  },
  RelicConfig_44597_StoryDesc = {
    Text = "Intrecciare, Simbiosi, Sciame; Paura, Creatura Sconosciuta, Controllo."
  },
  RelicConfig_44598_BattleDesc = {
    Text = "Dopo aver rilasciato l'Esaltazione, perdi il 12% degli HP attuali e ruba [Arg1] <PowerIconKeywords:FOR> Temporanea da tutti i nemici. Se c'è solo 1 nemico, ruba ulteriori [Arg2] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_44598_Desc = {
    Text = "Dopo aver rilasciato l'Esaltazione, perdi il 12% degli HP attuali e ruba [Arg1] <PowerIconKeywords:FOR> Temporanea da tutti i nemici. Se c'è solo 1 nemico, ruba ulteriori [Arg2] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_44598_Name = {
    Text = "<RedQuality:Peccaminoso· Uccello Rituale del Presagio>"
  },
  RelicConfig_44598_StoryDesc = {
    Text = "La creatura miserabile, uccisa dall'avidità, emette un grido lacerante dal suo petto avvizzito."
  },
  RelicConfig_44603_BattleDesc = {
    Text = "Aumenta il limite della mano di 5 e pesca 6 carte all'inizio della battaglia. A fine turno, scarta tutte le Carte Sintomo e le Carte di stato dalla tua mano, conserva le altre carte, ma pesca 2 carte in meno ogni turno."
  },
  RelicConfig_44603_Desc = {
    Text = "Aumenta il limite della mano di 5 e pesca 6 carte all'inizio della battaglia. A fine turno, scarta tutte le Carte Sintomo e le Carte di stato dalla tua mano, conserva le altre carte, ma pesca 2 carte in meno ogni turno."
  },
  RelicConfig_44603_Name = {
    Text = "<RedQuality:Peccaminoso· Incisione della Coscienza>"
  },
  RelicConfig_44603_StoryDesc = {
    Text = "Gli avidi trattano gli altri come oggetti, traendo piacere dalla sofferenza altrui."
  },
  RelicConfig_44608_BattleDesc = {
    Text = "Raccoglierla ti farà perdere permanentemente [Arg1] <PowerIconKeywords:FOR>. Ogni volta che infliggi Danno, cura [Arg2] HP, con un massimo di 6 attivazioni per turno."
  },
  RelicConfig_44608_Desc = {
    Text = "Raccoglierla ti farà perdere permanentemente [Arg1] <PowerIconKeywords:FOR>. Ogni volta che infliggi Danno, cura [Arg2] HP, con un massimo di 6 attivazioni per turno."
  },
  RelicConfig_44608_Name = {
    Text = "<RedQuality:Peccaminoso: Bacio di Lampreda>"
  },
  RelicConfig_44608_StoryDesc = {
    Text = "Il suo bacio ti farà sprofondare — anche se potresti essere tu a sprofondare."
  },
  RelicConfig_44609_BattleDesc = {
    Text = "L'Arithmetica massima aumenta di 3. Ogni volta che il mazzo viene rimescolato, aggiungi 2 <DerivativeCardKeywords_9:Barcollare> al Mazzo di Pesca."
  },
  RelicConfig_44609_Desc = {
    Text = "L'Arithmetica massima aumenta di 3. Ogni volta che il mazzo viene rimescolato, aggiungi 2 <DerivativeCardKeywords_9:Barcollare> al Mazzo di Pesca."
  },
  RelicConfig_44609_Name = {
    Text = "<RedQuality:Peccaminoso: Candela Nera>"
  },
  RelicConfig_44609_StoryDesc = {
    Text = "Brucia la sanità mentale, sprofonda nella follia."
  },
  RelicConfig_44610_BattleDesc = {
    Text = "Tasso di Crit. e Danno Crit. aumentati del 50%. A inizio turno, <FragileIconKeywords:Fragile> colpisce se stesso per 1 turno."
  },
  RelicConfig_44610_Desc = {
    Text = "Tasso di Crit. e Danno Crit. aumentati del 50%. A inizio turno, <FragileIconKeywords:Fragile> colpisce se stesso per 1 turno."
  },
  RelicConfig_44610_Name = {
    Text = "<RedQuality:Peccaminoso· Uncino Sinistro>"
  },
  RelicConfig_44610_StoryDesc = {
    Text = "Artigli contorti dal Desiderio."
  },
  RelicConfig_44654_BattleDesc = {
    Text = "Arithmetica massima +4. Ogni volta che il mazzo viene rimescolato, aggiungi 4 <DerivativeCardKeywords_4:\"Intuizione\"> al Mazzo di pesca."
  },
  RelicConfig_44654_Desc = {
    Text = "Arithmetica massima +4. Ogni volta che il mazzo viene rimescolato, aggiungi 4 <DerivativeCardKeywords_4:\"Intuizione\"> al Mazzo di pesca."
  },
  RelicConfig_44654_Name = {
    Text = "<OrangeQuality:Benedetto: Candela Nera>"
  },
  RelicConfig_44654_StoryDesc = {
    Text = "Desiderio ardente, ottieni la redenzione."
  },
  RelicConfig_44656_BattleDesc = {
    Text = "Capacità Reliquie +[Arg1], tentativi di Aggiornamento del \"D-segno\" +1. Dopo la battaglia, ottieni 125 Sigillo Nero. Al momento della raccolta, puoi scegliere di eliminare fino a 6 Carte sintomo."
  },
  RelicConfig_44656_Desc = {
    Text = "Capacità Reliquie +[Arg1], tentativi di Aggiornamento del \"D-segno\" +1. Dopo la battaglia, ottieni 125 Sigillo Nero. Al momento della raccolta, puoi scegliere di eliminare fino a 6 Carte sintomo."
  },
  RelicConfig_44656_Name = {
    Text = "<OrangeQuality:Benedetto: Impronta di Giada>"
  },
  RelicConfig_44656_StoryDesc = {
    Text = "La redenzione del Padre di Tutto ha cancellato il dolore."
  },
  RelicConfig_44658_BattleDesc = {
    Text = "Dopo aver rilasciato Esaltazione, ottieni [Arg1] FOR temporanea e ruba [Arg1] <PowerIconKeywords:FOR> Temporanea da tutti i nemici. Se c'è solo 1 nemico, ruba ulteriori [Arg2] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_44658_Desc = {
    Text = "Dopo aver rilasciato Esaltazione, ottieni [Arg1] FOR temporanea e ruba [Arg1] <PowerIconKeywords:FOR> Temporanea da tutti i nemici. Se c'è solo 1 nemico, ruba ulteriori [Arg2] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_44658_Name = {
    Text = "<OrangeQuality:Benedetto: Uccello Rituale del Presagio>"
  },
  RelicConfig_44658_StoryDesc = {
    Text = "La luce del perdono avvolge i resti dell'avidità, e gli uccelli morti intonano i loro canti finali."
  },
  RelicConfig_44659_BattleDesc = {
    Text = "Per ogni istanza di Danno attivo inflitto, ripristina [Arg1] PV e applica [Arg2] accumuli di <BleedingIconKeywords:Salasso> al bersaglio."
  },
  RelicConfig_44659_Desc = {
    Text = "Per ogni istanza di Danno attivo inflitto, ripristina [Arg1] PV e applica [Arg2] accumuli di <BleedingIconKeywords:Salasso> al bersaglio."
  },
  RelicConfig_44659_Name = {
    Text = "<OrangeQuality:Benedetto: Mente dello Sciame>"
  },
  RelicConfig_44659_StoryDesc = {
    Text = "Intrecciare, Simbiosi, Sciame; Unità, Coesistenza, Rifugio."
  },
  RelicConfig_44660_BattleDesc = {
    Text = "Aumenta il limite della mano di 5 e riempila fino al limite all'inizio della battaglia. Pesca 1 carta aggiuntiva all'inizio del turno e scarta tutte le Carte sintomo e le Carte di stato a fine turno, conservando le altre carte."
  },
  RelicConfig_44660_Desc = {
    Text = "Aumenta il limite della mano di 5 e riempila fino al limite all'inizio della battaglia. Pesca 1 carta aggiuntiva all'inizio del turno e scarta tutte le Carte sintomo e le Carte di stato a fine turno, conservando le altre carte."
  },
  RelicConfig_44660_Name = {
    Text = "<OrangeQuality:Benedetto: Incisione della Coscienza>"
  },
  RelicConfig_44660_StoryDesc = {
    Text = "Gli avidi incidono i propri errori nel cuore e si dedicano a espiare il loro passato."
  },
  RelicConfig_44662_BattleDesc = {
    Text = "Ogni 2 turni, raddoppia il Danno Attivo e da Tentacolo subito da tutti i nemici in quel turno. Per ogni Esaltazione utilizzata in quel turno, dissolvi casualmente 1 debuff."
  },
  RelicConfig_44662_Desc = {
    Text = "Ogni 2 turni, raddoppia il Danno Attivo e da Tentacolo subito da tutti i nemici in quel turno. Per ogni Esaltazione utilizzata in quel turno, dissolvi casualmente 1 debuff."
  },
  RelicConfig_44662_Name = {
    Text = "<OrangeQuality:Benedetto: Resti del Viandante>"
  },
  RelicConfig_44662_StoryDesc = {
    Text = [[
Un frammento sacro.
Sebbene si sia separato dal corpo, le sue impronte si sono propagate per il mondo.]]
  },
  RelicConfig_44663_BattleDesc = {
    Text = "Tasso Crit. aumentato del 50%, Danno Crit. aumentato del 100%."
  },
  RelicConfig_44663_Desc = {
    Text = "Tasso Crit. aumentato del 50%, Danno Crit. aumentato del 100%."
  },
  RelicConfig_44663_Name = {
    Text = "<OrangeQuality:Benedetto: Uncino Sinistro>"
  },
  RelicConfig_44663_StoryDesc = {
    Text = "Ogni desiderio è stato abbandonato."
  },
  RelicConfig_44664_BattleDesc = {
    Text = "Ottieni [Arg1] <PowerIconKeywords:FOR> Permanentemente dopo averla raccolta. Ogni volta che vengono inflitti danni, cura [Arg2] PV, con un massimo di 6 attivazioni per turno."
  },
  RelicConfig_44664_Desc = {
    Text = "Ottieni [Arg1] <PowerIconKeywords:FOR> Permanentemente dopo averla raccolta. Ogni volta che vengono inflitti danni, cura [Arg2] PV, con un massimo di 6 attivazioni per turno."
  },
  RelicConfig_44664_Name = {
    Text = "<OrangeQuality:Benedetto: Bacio di Lampreda>"
  },
  RelicConfig_44664_StoryDesc = {
    Text = "Rifiuta questo bacio di dannazione, poiché l'Abbraccio del Padre Supremo è più caldo di qualsiasi Oscurità."
  },
  RelicConfig_47444_BattleDesc = {
    Text = "\"Attacco\" e \"Difesa\" ottengono 50 Keyflare aggiuntivi. Ogni volta che giochi una carta con un Costo di Arithmetica pari o superiore a 2, pesca una carta con Costo di Arithmetica pari a 1 e riducine il costo a 0, fino a 3 volte per turno."
  },
  RelicConfig_47444_Desc = {
    Text = "\"Attacco\" e \"Difesa\" ottengono 50 Keyflare aggiuntivi. Ogni volta che giochi una carta con un Costo di Arithmetica pari o superiore a 2, pesca una carta con Costo di Arithmetica pari a 1 e riducine il costo a 0, fino a 3 volte per turno."
  },
  RelicConfig_47444_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Gemelli\">"
  },
  RelicConfig_50338_BattleDesc = {
    Text = "All'inizio della battaglia, mischia le <ExaltIconKeywords:Riscossa> di tutti i Risvegliati nel mazzo. A partire dal 6° turno, Thais fornirà supporto in combattimento ogni turno."
  },
  RelicConfig_50338_Desc = {
    Text = "All'inizio della battaglia, mischia le <ExaltIconKeywords:Riscossa> di tutti i Risvegliati nel mazzo. A partire dal 6° turno, Thais fornirà supporto in combattimento ogni turno."
  },
  RelicConfig_50338_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Incanto\">"
  },
  RelicConfig_50338_StoryDesc = {
    Text = "Egli disse: \"Non avere paura.\""
  },
  RelicConfig_50385_BattleDesc = {
    Text = "Al momento della raccolta, scegli una carta per ridurre permanentemente il suo Costo di Arithmetica a 1."
  },
  RelicConfig_50385_Desc = {
    Text = "Al momento della raccolta, scegli una carta per ridurre permanentemente il suo Costo di Arithmetica a 1."
  },
  RelicConfig_50385_Name = {
    Text = "<WhiteQuality:☆Pupilla Inaridita☆>"
  },
  RelicConfig_50385_StoryDesc = {
    Text = "Avendo perduto l'acqua, il bene più prezioso del deserto, i suoi occhi si sono inariditi."
  },
  RelicConfig_50487_BattleDesc = {
    Text = "All'inizio del primo turno di battaglia, aggiungi <DerivativeCardKeywords_46:Virus prionico> alla tua mano; al 3° turno, aggiungi <DerivativeCardKeywords_49:Attacco vorace> alla tua mano; dopo aver attivato la Resistenza alla Morte, aggiungi <DerivativeCardKeywords_52:Bozzolo della Rinascita> alla tua mano."
  },
  RelicConfig_50487_Desc = {
    Text = "All'inizio del primo turno di battaglia, aggiungi <DerivativeCardKeywords_46:Virus prionico> alla tua mano; al 3° turno, aggiungi <DerivativeCardKeywords_49:Attacco vorace> alla tua mano; dopo aver attivato la Resistenza alla Morte, aggiungi <DerivativeCardKeywords_52:Bozzolo della Rinascita> alla tua mano."
  },
  RelicConfig_50487_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Benedizione\">"
  },
  RelicConfig_50488_BattleDesc = {
    Text = "A fine turno: il Risvegliato con il minor numero di Aliemus ottiene 35 Aliemus. Se i PV rimanenti sono ≥50%, ottiene [Arg1] <PowerIconKeywords:FOR>. Se i PV rimanenti sono ＜50%, ripristina [Arg2] PV."
  },
  RelicConfig_50488_Desc = {
    Text = "A fine turno: il Risvegliato con il minor numero di Aliemus ottiene 35 Aliemus. Se i PV attuali sono pari o superiori al 50%, ottiene [Arg1] <PowerIconKeywords:FOR>. Se i PV attuali sono inferiori al 50%, ripristina [Arg2] PV."
  },
  RelicConfig_50488_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Equilibrio\">"
  },
  RelicConfig_50489_BattleDesc = {
    Text = "Il Tasso di Crit. e il Danno Crit. aumentano del 100%. Per ogni istanza di Danno inflitta, il Tasso di Crit. e il Danno Crit. di tutti i Risvegliati diminuiscono del 10%, fino a una riduzione massima del 50%. Per ogni istanza di Danno inflitta, il Danno da Veleno e da Contatore inflitto in questo turno aumenta del 10%, fino a un incremento massimo del 50%."
  },
  RelicConfig_50489_Desc = {
    Text = "Tasso Crit. e Danno Crit. +100%. Per ogni istanza di danno/danno da Tentacolo inflitta in questo turno, il Tasso Crit. e il Danno Crit. di tutti i Risvegliatori si riducono del 10%, fino al 50%. Danno da veleno e da contatore +10%, fino al 50%."
  },
  RelicConfig_50489_Name = {
    Text = "<OrangeQuality:Pendolo Crono\"Ondata\">"
  },
  RelicConfig_51686_BattleDesc = {
    Text = "Ogni volta che viene giocata una Carta di comando appartenente a un Risveglio diverso dall'ultimo giocato, quel Risveglio ottiene 3 Aliemus e accumula 1 accumulo di \"Vitalità\". Al raggiungimento di 10 accumuli, tutta la \"Vitalità\" viene azzerata e una Carta di comando casuale con \"Esaurimento\" e Costo di Arithmetica ridotto di 1 viene posta In Mano per ciascun Risveglio. Questo effetto può attivarsi un massimo di 1 volta per turno."
  },
  RelicConfig_51686_Desc = {
    Text = "Ogni volta che viene giocata una Carta di comando appartenente a un Risveglio diverso dall'ultimo giocato, quel Risveglio ottiene 3 Aliemus e accumula 1 accumulo di \"Vitalità\". Al raggiungimento di 10 accumuli, tutta la \"Vitalità\" viene azzerata e una Carta di comando casuale con \"Esaurimento\" e Costo di Arithmetica ridotto di 1 viene posta In Mano per ciascun Risveglio. Questo effetto può attivarsi un massimo di 1 volta per turno."
  },
  RelicConfig_51686_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Evoluzione\">"
  },
  RelicConfig_51687_BattleDesc = {
    Text = "Dopo aver giocato una Carta di comando che non sia \"Colpo\" o \"Difesa\", se la carta non è una carta Derivata, il Risvegliato corrispondente ottiene 15 Aliemus, attivandosi fino a 5 volte per turno. Alla prima attivazione di ogni turno, la carta giocata viene anche restituita alla tua mano."
  },
  RelicConfig_51687_Desc = {
    Text = "Dopo aver giocato una Carta di comando che non sia \"Attacco\" o \"Difesa\", se la carta non è una Carta Derivata, il Risvegliatore corrispondente ottiene 15 Aliemus, attivandosi fino a 5 volte per turno. Alla prima attivazione di ogni turno, la carta giocata viene anche restituita alla tua Mano."
  },
  RelicConfig_51687_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Proiezione\">"
  },
  RelicConfig_51688_BattleDesc = {
    Text = "Quando raccolto, aggiungi \"Conservare\" a tutte le Carte di comando. A fine turno, se il numero di carte In Mano è maggiore o uguale a 5, riduci il Costo di Arithmetica di 3 carte casuali in mano di 1; altrimenti, pesca 3 carte."
  },
  RelicConfig_51688_Desc = {
    Text = "Quando raccolto, aggiungi \"Conservare\" a tutte le Carte di comando. A fine turno, se il numero di carte In Mano è maggiore o uguale a 5, riduci il Costo di Arithmetica di 3 carte casuali in mano di 1; altrimenti, pesca 3 carte."
  },
  RelicConfig_51688_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Proliferazione\">"
  },
  RelicConfig_51689_BattleDesc = {
    Text = "All'inizio della battaglia, mischia 3 Carte sintomo casuali nel tuo mazzo. A inizio turno, pesca 1 carta. Giocare ogni Carta sintomo conferisce 2 Arithmetica. Scartare ogni Carta sintomo conferisce a tutti i Risvegliati 5 Aliemus, fino a 5 volte per turno."
  },
  RelicConfig_51689_Desc = {
    Text = "All'inizio della battaglia, mischia 3 Carte sintomo casuali nel tuo mazzo. A inizio turno, pesca 1 carta. Giocare ogni Carta sintomo conferisce 2 Arithmetica. Scartare ogni Carta sintomo conferisce a tutti i Risvegliati 5 Aliemus, fino a 5 volte per turno."
  },
  RelicConfig_51689_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Pestilenza\">"
  },
  RelicConfig_55847_BattleDesc = {
    Text = "Set standard di 7 Reliquie della Battaglia Simulata"
  },
  RelicConfig_55847_Desc = {
    Text = "Set standard di 7 Reliquie della Battaglia Simulata"
  },
  RelicConfig_55847_Name = {
    Text = "<RedQuality:☆Reliquia della Simulazione☆>"
  },
  RelicConfig_55847_StoryDesc = {
    Text = "Nella strana era, i fiori sono i principali spettatori dell'umanità.\nResta immobile; preferiscono le esibizioni silenziose."
  },
  RelicConfig_55874_BattleDesc = {
    Text = "Ottieni [Arg1] accumulo di \"Inchiostro\" dopo la battaglia. Quando \"Inchiostro\" raggiunge 2 accumuli, Esaurimento, poi inserisci casualmente 1 carta \"Immagine\" nel mazzo."
  },
  RelicConfig_55874_Desc = {
    Text = "Ottieni [Arg1] accumulo di \"Inchiostro\" dopo la battaglia. Quando \"Inchiostro\" raggiunge 2 accumuli, Esaurimento, poi inserisci casualmente 1 carta \"Immagine\" nel mazzo."
  },
  RelicConfig_55874_Name = {
    Text = "<OrangeQuality:Penna e Inchiostro di Horla>"
  },
  RelicConfig_55874_StoryDesc = {
    Text = "Gli antichi peccati sono incisi qui."
  },
  RelicConfig_56355_BattleDesc = {
    Text = "Limite di carte In Mano +2, pesca 1 carta a inizio turno. Dopo la battaglia, ottieni [Arg1] strato/i di \"Inchiostro\", e quando \"Inchiostro\" raggiunge 2 accumuli, verrà consumato per scegliere 1 \"Immagine\" da inserire nel tuo mazzo."
  },
  RelicConfig_56355_Desc = {
    Text = "Limite di carte In Mano +2, pesca 1 carta a inizio turno. Dopo la battaglia, ottieni [Arg1] strato/i di \"Inchiostro\", e quando \"Inchiostro\" raggiunge 2 accumuli, verrà consumato per scegliere 1 \"Immagine\" da inserire nel tuo mazzo."
  },
  RelicConfig_56355_Name = {
    Text = "<OrangeQuality:Penna e Inchiostro di Horla>"
  },
  RelicConfig_56355_StoryDesc = {
    Text = "Gli antichi peccati sono incisi qui."
  },
  RelicConfig_56356_BattleDesc = {
    Text = "Ottieni [Arg1] accumulo di \"Inchiostro\" dopo la battaglia. Quando \"Inchiostro\" raggiunge 2 accumuli, Esaurimento, poi scegli 1 carta \"Immagine\" da inserire nel mazzo."
  },
  RelicConfig_56356_Desc = {
    Text = "Ottieni [Arg1] accumulo di \"Inchiostro\" dopo la battaglia. Quando \"Inchiostro\" raggiunge 2 accumuli, Esaurimento, poi scegli 1 carta \"Immagine\" da inserire nel mazzo."
  },
  RelicConfig_56356_Name = {
    Text = "<OrangeQuality:Penna e Inchiostro di Horla>"
  },
  RelicConfig_56356_StoryDesc = {
    Text = "Gli antichi peccati sono incisi qui."
  },
  RelicConfig_57667_BattleDesc = {
    Text = "Inizia con 2 accumuli di Potere della Madre Divina. Dopo il terzo turno, all'inizio del turno, scegli se consumare il Potere della Madre Divina per effetti diversi o ripristinarlo. Se subisci danni fatali, risorgi e consumi tutti gli accumuli di Potere della Madre Divina: ogni accumulo ripristina il 10% dei PV. Questo effetto può attivarsi una sola volta."
  },
  RelicConfig_57667_Desc = {
    Text = "Inizia con 2 accumuli di Potere della Madre Divina. Dopo il terzo turno, all'inizio del turno, scegli se consumare il Potere della Madre Divina per effetti diversi o ripristinarlo. Se subisci danni fatali, risorgi e consumi tutti gli accumuli di Potere della Madre Divina: ogni accumulo ripristina il 10% dei PV. Questo effetto può attivarsi una sola volta."
  },
  RelicConfig_57667_Name = {
    Text = "<OrangeQuality:Protezione della Madre Divina>"
  },
  RelicConfig_57732_BattleDesc = {
    Text = "Il Tasso di Crit. di tutti i Risvegliati è aumentato del 15%. Il risultato finale degli effetti casuali di Ryker e dei dadi è aumentato di 1."
  },
  RelicConfig_57732_Desc = {
    Text = "Il Tasso di Crit. di tutti i Risvegliati è aumentato del 15%. Il risultato finale degli effetti casuali di Ryker e dei dadi è aumentato di 1."
  },
  RelicConfig_57732_Name = {
    Text = "<OrangeQuality:Impermeabile Fortunato su Misura>"
  },
  RelicConfig_57732_StoryDesc = {
    Text = "Erigerà una spessa Barriera per tenere lontani venti, piogge e sventure."
  },
  RelicConfig_57733_BattleDesc = {
    Text = "All'inizio del turno e quando viene attivato l'effetto casuale di Ryker o dei dadi, ottieni 100 Keyflare e il 4% di DAN da Crit., fino a un massimo del 50% di DAN da Crit. Rimosso alla fine della battaglia."
  },
  RelicConfig_57733_Desc = {
    Text = "All'inizio del turno e quando viene attivato l'effetto casuale di Ryker o dei dadi, ottieni 100 Keyflare e il 4% di DAN da Crit., fino a un massimo del 50% di DAN da Crit. Rimosso alla fine della battaglia."
  },
  RelicConfig_57733_Name = {
    Text = "<OrangeQuality:Bottone Bocca Pregiato>"
  },
  RelicConfig_57733_StoryDesc = {
    Text = "Il Bottone Boccalarga ama tutto ciò che è rotondo: la luna, le patatine e i bulbi oculari freschi.\nNelle notti di luna piena emette una nebbia nera, per ragioni ignote."
  },
  RelicConfig_57734_BattleDesc = {
    Text = "Ogni volta che rilasci la Squadra, aggiungi 1 \"Dado Ottaedrico Brillante\" alla mano."
  },
  RelicConfig_57734_Desc = {
    Text = "Ogni volta che rilasci la Squadra, aggiungi 1 \"Dado Ottaedrico Brillante\" alla mano."
  },
  RelicConfig_57734_Name = {
    Text = "<OrangeQuality:Dado Ottaedrico Brillante>"
  },
  RelicConfig_57734_StoryDesc = {
    Text = "Ciò che risplende non è solo la superficie, ma anche il cuore indomito.\nFissa lo Sguardo su di esso per più di cinque secondi e invocherai @2."
  },
  RelicConfig_57735_BattleDesc = {
    Text = "All'inizio del turno e quando viene attivato l'effetto casuale di Ryker o dei dadi, ottieni 50 Keyflare e il 2% di DAN da Crit., fino a un massimo del 30% di DAN da Crit. Rimosso alla fine della battaglia."
  },
  RelicConfig_57735_Desc = {
    Text = "All'inizio del turno e quando viene attivato l'effetto casuale di Ryker o dei dadi, ottieni 50 Keyflare e il 2% di DAN da Crit., fino a un massimo del 30% di DAN da Crit. Rimosso alla fine della battaglia."
  },
  RelicConfig_57735_Name = {
    Text = "<OrangeQuality:Bottone Boccalarga>"
  },
  RelicConfig_57735_StoryDesc = {
    Text = "Il Bottone Boccalarga ama tutto ciò che è rotondo: la luna, le patatine e i bulbi oculari freschi.\nNelle notti di luna piena emette una nebbia nera, per ragioni ignote."
  },
  RelicConfig_57736_BattleDesc = {
    Text = "Ogni volta che rilasci il Gruppo, metti 1 \"Dadi Ottaedrici\" in mano."
  },
  RelicConfig_57736_Desc = {
    Text = "Ogni volta che rilasci il Gruppo, metti 1 \"Dadi Ottaedrici\" in mano."
  },
  RelicConfig_57736_Name = {
    Text = "<OrangeQuality:Dadi Ottaedrici>"
  },
  RelicConfig_57736_StoryDesc = {
    Text = "Ciò che risplende non è solo la superficie, ma anche il cuore indomito.\nFissa lo Sguardo su di esso per più di cinque secondi e invocherai @2."
  },
  RelicConfig_57737_BattleDesc = {
    Text = "Il Tasso di Crit. di tutti i Risvegliati aumenta del 10%. Gli effetti casuali di Ryker e dei dadi non possono risultare nel valore più basso."
  },
  RelicConfig_57737_Desc = {
    Text = "Il Tasso di Crit. di tutti i Risvegliati aumenta del 10%. Gli effetti casuali di Ryker e dei dadi non possono risultare nel valore più basso."
  },
  RelicConfig_57737_Name = {
    Text = "<OrangeQuality:Impermeabile Fortunato>"
  },
  RelicConfig_57737_StoryDesc = {
    Text = "Erigerà una spessa Barriera per tenere lontani venti, piogge e sventure."
  },
  RelicConfig_57791_BattleDesc = {
    Text = "Capacità Reliquie +1. Nei primi cinque turni dall'inizio della battaglia, ottieni una Reliquia all'inizio del turno: \"Spilla di Rubino, Agata Filigranata, Segnale SOS, Uccello Rituale del Presagio, Pendolo Crono: Trance\"."
  },
  RelicConfig_57791_Desc = {
    Text = "Capacità Reliquie +1. Nei primi cinque turni dall'inizio della battaglia, ottieni una Reliquia all'inizio del turno: \"Spilla di Rubino, Agata Filigranata, Segnale SOS, Uccello Rituale del Presagio, Pendolo Crono: Trance\"."
  },
  RelicConfig_57791_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Tesoro del Relitto\">"
  },
  RelicConfig_57791_StoryDesc = {
    Text = "Si narra che Lemuria sprofondò in queste acque. Chi può resistere alla tentazione di esplorare i segreti dei tesori sommersi?"
  },
  RelicConfig_57792_BattleDesc = {
    Text = "Capacità Reliquie +1. Ottieni una reliquia all'inizio di ciascuno dei primi cinque turni in battaglia: \"Tridente Uncinato, Album di Francobolli Stranieri, Archivio Arcana, Incisione della Coscienza, Pendolo Crono: Accumulo\"."
  },
  RelicConfig_57792_Desc = {
    Text = "Capacità Reliquie +1. Ottieni una reliquia all'inizio di ciascuno dei primi cinque turni in battaglia: \"Tridente Uncinato, Album di Francobolli Stranieri, Archivio Arcana, Incisione della Coscienza, Pendolo Crono: Accumulo\"."
  },
  RelicConfig_57792_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Tesoro del Relitto\">"
  },
  RelicConfig_57792_StoryDesc = {
    Text = "Si narra che Lemuria sprofondò in queste acque. Chi può resistere alla tentazione di esplorare i segreti dei tesori sommersi?"
  },
  RelicConfig_57793_BattleDesc = {
    Text = "Capacità Reliquie +1. Nei primi cinque turni dall'inizio della battaglia, all'inizio del turno, ottieni una reliquia: \"Mandibola al Radio\", \"Unguento Sospetto\", \"Telaio Dimenticato\", \"Lingua Aliena\" e \"Pendolo Crono: Ondata\"."
  },
  RelicConfig_57793_Desc = {
    Text = "Capacità Reliquie +1. Nei primi cinque turni dall'inizio della battaglia, all'inizio del turno, ottieni una reliquia: \"Mandibola al Radio\", \"Unguento Sospetto\", \"Telaio Dimenticato\", \"Lingua Aliena\" e \"Pendolo Crono: Ondata\"."
  },
  RelicConfig_57793_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Tesoro del Relitto\">"
  },
  RelicConfig_57793_StoryDesc = {
    Text = "Si narra che Lemuria sprofondò in queste acque. Chi può resistere alla tentazione di esplorare i segreti dei tesori sommersi?"
  },
  RelicConfig_57794_BattleDesc = {
    Text = "Capacità Reliquie +1. Nei primi cinque turni dall'inizio della battaglia, all'inizio del turno, ottieni una reliquia, tra cui \"Gilet d'Ortica, Orologio del Defunto, Frammento dei Saggi, Arto Salvifico, Pendolo Crono: Proliferazione\"."
  },
  RelicConfig_57794_Desc = {
    Text = "Capacità Reliquie +1. Nei primi cinque turni dall'inizio della battaglia, all'inizio del turno, ottieni una reliquia, tra cui \"Gilet d'Ortica, Orologio del Defunto, Frammento dei Saggi, Arto Salvifico, Pendolo Crono: Proliferazione\"."
  },
  RelicConfig_57794_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Tesoro del Relitto\">"
  },
  RelicConfig_57794_StoryDesc = {
    Text = "Si narra che Lemuria sprofondò in queste acque. Chi può resistere alla tentazione di esplorare i segreti dei tesori sommersi?"
  },
  RelicConfig_57795_BattleDesc = {
    Text = "Capacità Reliquie +1. Nei primi cinque turni dall'inizio della battaglia, all'inizio del turno, otterrai una reliquia: \"Bisturi Arrugginito\", \"Pinza Emostatica\", \"Puzzle Antico\", \"Mente dello Sciame\" e \"Pendolo Crono: Gemelli\"."
  },
  RelicConfig_57795_Desc = {
    Text = "Capacità Reliquie +1. Nei primi cinque turni dall'inizio della battaglia, all'inizio del turno, otterrai una reliquia: \"Bisturi Arrugginito\", \"Pinza Emostatica\", \"Puzzle Antico\", \"Mente dello Sciame\" e \"Pendolo Crono: Gemelli\"."
  },
  RelicConfig_57795_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Tesoro del Relitto\">"
  },
  RelicConfig_57795_StoryDesc = {
    Text = "Si narra che Lemuria sprofondò in queste acque. Chi può resistere alla tentazione di esplorare i segreti dei tesori sommersi?"
  },
  RelicConfig_57796_BattleDesc = {
    Text = "Capacità Reliquie +1. Nei primi cinque turni dopo l'inizio della battaglia, ottieni una Reliquia a inizio turno, tra cui \"Dispositivo Cronometrico, Gemelli da Polso all'Alloro, Velo della Divinità Senza Nome, Manifestazione dell'Incubo, Pendolo Crono: Equilibrio\"."
  },
  RelicConfig_57796_Desc = {
    Text = "Capacità Reliquie +1. Nei primi cinque turni dopo l'inizio della battaglia, ottieni una Reliquia a inizio turno, tra cui \"Dispositivo Cronometrico, Gemelli da Polso all'Alloro, Velo della Divinità Senza Nome, Manifestazione dell'Incubo, Pendolo Crono: Equilibrio\"."
  },
  RelicConfig_57796_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Tesoro del Relitto\">"
  },
  RelicConfig_57796_StoryDesc = {
    Text = "Si narra che Lemuria sprofondò in queste acque. Chi può resistere alla tentazione di esplorare i segreti dei tesori sommersi?"
  },
  RelicConfig_57797_BattleDesc = {
    Text = "Capacità Reliquie +1. Nei primi cinque turni dopo l'inizio della battaglia, ottieni una reliquia a inizio turno, tra cui \"Portafoglio Nuovo di Zecca, Insegna Mythag, Infuso Stellare, Bacio della Lampreda, Pendolo Crono: Occhio\"."
  },
  RelicConfig_57797_Desc = {
    Text = "Capacità Reliquie +1. Nei primi cinque turni dopo l'inizio della battaglia, ottieni una reliquia a inizio turno, tra cui \"Portafoglio Nuovo di Zecca, Insegna Mythag, Infuso Stellare, Bacio della Lampreda, Pendolo Crono: Occhio\"."
  },
  RelicConfig_57797_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Tesoro del Relitto\">"
  },
  RelicConfig_57797_StoryDesc = {
    Text = "Si narra che Lemuria sprofondò in queste acque. Chi può resistere alla tentazione di esplorare i segreti dei tesori sommersi?"
  },
  RelicConfig_58872_BattleDesc = {
    Text = "All'inizio della battaglia, aumenta il Limite di Arithmetica di 1 e Ridesta tutti i Risvegliatori. Per i successivi 5 turni, a inizio turno, ottieni una Reliquia tra \"Bisturi Arrugginito, Asse Moderno, Casa Nostra, Uncino Sinistro, Pendolo Crono: Trance\"."
  },
  RelicConfig_58872_Desc = {
    Text = "All'inizio della battaglia, aumenta il Limite di Arithmetica di 1 e Ridesta tutti i Risvegliatori. Per i successivi 5 turni, a inizio turno, ottieni una Reliquia tra \"Bisturi Arrugginito, Asse Moderno, Casa Nostra, Uncino Sinistro, Pendolo Crono: Trance\"."
  },
  RelicConfig_58872_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Tesoro α\">"
  },
  RelicConfig_58873_BattleDesc = {
    Text = "All'inizio della battaglia, aumenta il Limite di Arithmetica di +1 e Ridesta tutti i Risvegliatori. Per i successivi 5 turni, a inizio turno, ottieni una Reliquia tra \"Inchiostro Dolciastro, Jukebox muto, Infuso Stellare, Cappello dell'Imbroglione, Pendolo Crono: Ondata\"."
  },
  RelicConfig_58873_Desc = {
    Text = "All'inizio della battaglia, aumenta il Limite di Arithmetica di +1 e Ridesta tutti i Risvegliatori. Per i successivi 5 turni, a inizio turno, ottieni una Reliquia tra \"Inchiostro Dolciastro, Jukebox muto, Infuso Stellare, Cappello dell'Imbroglione, Pendolo Crono: Ondata\"."
  },
  RelicConfig_58873_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Tesoro β\">"
  },
  RelicConfig_59118_BattleDesc = {
    Text = "A inizio turno, ottieni 1 \"Dadi Fortunati di Ryker\", aumentando il risultato del lancio di dado di +1. A inizio turno e dopo ogni lancio di dado, tutti i Risvegliatori ottengono il 4% di DAN da Crit., fino a un massimo del 100%."
  },
  RelicConfig_59118_Desc = {
    Text = "A inizio turno, ottieni 1 \"Dadi Fortunati di Ryker\", aumentando il risultato del lancio di dado di +1. A inizio turno e dopo ogni lancio di dado, tutti i Risvegliatori ottengono il 4% di DAN da Crit., fino a un massimo del 100%."
  },
  RelicConfig_59118_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Dono del Caos\">"
  },
  RelicConfig_59118_StoryDesc = {
    Text = "Gli antichi peccati sono incisi qui."
  },
  RelicConfig_59687_BattleDesc = {
    Text = "Set standard di 7 Reliquie della Battaglia Simulata"
  },
  RelicConfig_59687_Desc = {
    Text = "Set standard di 7 Reliquie della Battaglia Simulata"
  },
  RelicConfig_59687_Name = {
    Text = "<RedQuality:☆Reliquia della Simulazione☆>"
  },
  RelicConfig_59687_StoryDesc = {
    Text = "Nella strana era, i fiori sono i principali spettatori dell'umanità.\nResta immobile; preferiscono le esibizioni silenziose."
  },
  RelicConfig_60723_BattleDesc = {
    Text = "Arithmetica massima +1. Pesca una carta aggiuntiva a inizio turno e ottieni 1 \"Sinfonia dell'Armonia\". Se 3 Carte di comando con la stessa Arithmetica vengono giocate consecutivamente, tutti i Risvegliatori ottengono 20 Aliemus. Si azzera a inizio turno e dopo l'attivazione."
  },
  RelicConfig_60723_Desc = {
    Text = "Arithmetica massima +1. Pesca una carta aggiuntiva a inizio turno e ottieni 1 \"Sinfonia dell'Armonia\". Se 3 Carte di comando con la stessa Arithmetica vengono giocate consecutivamente, tutti i Risvegliatori ottengono 20 Aliemus. Si azzera a inizio turno e dopo l'attivazione."
  },
  RelicConfig_60723_Name = {
    Text = "<OrangeQuality:Bacchetta del Direttore>"
  },
  RelicConfig_60723_StoryDesc = {
    Text = [[
Una sottile bacchetta da direttore d'orchestra, eppure possiede una forza superiore a quella di un piede di porco.

 Dirige le note, dirige l'anima, dirige il fato.]]
  },
  RelicConfig_60724_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni l'Orazione \"Vulnerabile\" e l'Orazione \"Detonazione\" insieme alle rispettive versioni Avanzate, e scegli un'Orazione da collocare su una Carta."
  },
  RelicConfig_60724_Desc = {
    Text = "All'inizio della battaglia, ottieni l'Orazione \"Vulnerabile\" e l'Orazione \"Detonazione\" insieme alle rispettive versioni Avanzate, e scegli un'Orazione da collocare su una Carta."
  },
  RelicConfig_60724_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Messaggio del Preside\">"
  },
  RelicConfig_60724_StoryDesc = {
    Text = [[
Le parole del fondatore di Mythag risuonano nelle tue orecchie.

Possa la Chiave d'argento illuminare il tuo cammino, Custode di Mythag.]]
  },
  RelicConfig_60725_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni l'Orazione \"Aliemus\" e l'Orazione \"Catalizzatore\" insieme alle rispettive Orazioni Avanzate, e scegli un'Orazione per una carta."
  },
  RelicConfig_60725_Desc = {
    Text = "All'inizio della battaglia, ottieni l'Orazione \"Aliemus\" e l'Orazione \"Catalizzatore\" insieme alle rispettive Orazioni Avanzate, e scegli un'Orazione per una carta."
  },
  RelicConfig_60725_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Messaggio del Preside\">"
  },
  RelicConfig_60725_StoryDesc = {
    Text = [[
Le parole del fondatore di Mythag risuonano nelle tue orecchie.

Possa la Chiave d'argento illuminare il tuo cammino, Custode di Mythag.]]
  },
  RelicConfig_60726_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni l'Orazione \"Debolezza\" e l'Orazione \"Calcolo\" insieme alle rispettive Orazioni Avanzate, e scegli un'Orazione per una carta."
  },
  RelicConfig_60726_Desc = {
    Text = "All'inizio della battaglia, ottieni l'Orazione \"Debolezza\" e l'Orazione \"Calcolo\" insieme alle rispettive Orazioni Avanzate, e scegli un'Orazione per una carta."
  },
  RelicConfig_60726_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Messaggio del Preside\">"
  },
  RelicConfig_60726_StoryDesc = {
    Text = [[
Le parole del fondatore di Mythag risuonano nelle tue orecchie.

Possa la Chiave d'argento illuminare il tuo cammino, Custode di Mythag.]]
  },
  RelicConfig_60727_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni l'Orazione \"Bastion\" e l'Orazione \"Finezza\" insieme alle rispettive Orazioni Avanzate, e scegli un'Orazione su una Carta."
  },
  RelicConfig_60727_Desc = {
    Text = "All'inizio della battaglia, ottieni l'Orazione \"Bastion\" e l'Orazione \"Finezza\" insieme alle rispettive Orazioni Avanzate, e scegli un'Orazione su una Carta."
  },
  RelicConfig_60727_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Messaggio del Preside\">"
  },
  RelicConfig_60727_StoryDesc = {
    Text = [[
Le parole del fondatore di Mythag risuonano nelle tue orecchie.

Possa la Chiave d'argento illuminare il tuo cammino, Custode di Mythag.]]
  },
  RelicConfig_60728_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni l'Orazione \"Nascita\" e l'Orazione \"Eco\" insieme alle rispettive Orazioni Avanzate, e scegli un'Orazione su una carta."
  },
  RelicConfig_60728_Desc = {
    Text = "All'inizio della battaglia, ottieni l'Orazione \"Nascita\" e l'Orazione \"Eco\" insieme alle rispettive Orazioni Avanzate, e scegli un'Orazione su una carta."
  },
  RelicConfig_60728_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Messaggio del Preside\">"
  },
  RelicConfig_60728_StoryDesc = {
    Text = [[
Le parole del fondatore di Mythag risuonano nelle tue orecchie.

Possa la Chiave d'argento illuminare il tuo cammino, Custode di Mythag.]]
  },
  RelicConfig_60729_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni l'Orazione \"Finezza\" e l'Orazione \"Intuizione\" insieme alle rispettive Orazioni Avanzate, e scegli un'Orazione da collocare su una carta."
  },
  RelicConfig_60729_Desc = {
    Text = "All'inizio della battaglia, ottieni l'Orazione \"Finezza\" e l'Orazione \"Intuizione\" insieme alle rispettive Orazioni Avanzate, e scegli un'Orazione da collocare su una carta."
  },
  RelicConfig_60729_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Messaggio del Preside\">"
  },
  RelicConfig_60729_StoryDesc = {
    Text = [[
Le parole del fondatore di Mythag risuonano nelle tue orecchie.

Possa la Chiave d'argento illuminare il tuo cammino, Custode di Mythag.]]
  },
  RelicConfig_60730_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni l'Orazione \"Possanza\" e l'Orazione \"Prosciugamento\" insieme alle rispettive Orazioni Avanzate. Scegli un'Orazione su una carta."
  },
  RelicConfig_60730_Desc = {
    Text = "All'inizio della battaglia, ottieni l'Orazione \"Possanza\" e l'Orazione \"Prosciugamento\" insieme alle rispettive Orazioni Avanzate. Scegli un'Orazione su una carta."
  },
  RelicConfig_60730_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Messaggio del Preside\">"
  },
  RelicConfig_60730_StoryDesc = {
    Text = [[
Le parole del fondatore di Mythag risuonano nelle tue orecchie.

Possa la Chiave d'argento illuminare il tuo cammino, Custode di Mythag.]]
  },
  RelicConfig_60731_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni 2 Orazioni \"Ensemble\" e la loro Orazione Avanzata, e scegli un'Orazione per una carta."
  },
  RelicConfig_60731_Desc = {
    Text = "All'inizio della battaglia, ottieni 2 Orazioni \"Ensemble\" e la loro Orazione Avanzata, e scegli un'Orazione per una carta."
  },
  RelicConfig_60731_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Messaggio del Preside\">"
  },
  RelicConfig_60731_StoryDesc = {
    Text = [[
Le parole del fondatore di Mythag risuonano nelle tue orecchie.

Possa la Chiave d'argento illuminare il tuo cammino, Custode di Mythag.]]
  },
  RelicConfig_60732_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni l'Orazione \"Calcolo\" e l'Orazione \"Riflesso\" insieme alle rispettive Orazioni Avanzate, e scegli un'Orazione su una carta."
  },
  RelicConfig_60732_Desc = {
    Text = "All'inizio della battaglia, ottieni l'Orazione \"Calcolo\" e l'Orazione \"Riflesso\" insieme alle rispettive Orazioni Avanzate, e scegli un'Orazione su una carta."
  },
  RelicConfig_60732_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Messaggio del Preside\">"
  },
  RelicConfig_60732_StoryDesc = {
    Text = [[
Le parole del fondatore di Mythag risuonano nelle tue orecchie.

Possa la Chiave d'argento illuminare il tuo cammino, Custode di Mythag.]]
  },
  RelicConfig_65376_BattleDesc = {
    Text = "Inizia con [Arg1] membri della Squadra di Spedizione. All'inizio della battaglia, mischia 5 <DerivativeCardKeywords_73:Diffidenza> nel mazzo."
  },
  RelicConfig_65376_Desc = {
    Text = "Inizia con [Arg1] membri della Squadra di Spedizione. All'inizio della battaglia, mischia 5 <DerivativeCardKeywords_73:Diffidenza> nel mazzo."
  },
  RelicConfig_65376_Name = {
    Text = "<OrangeQuality:Squadra di Spedizione>"
  },
  RelicConfig_65376_StoryDesc = {
    Text = [[
Le parole del fondatore di Mythag risuonano nelle tue orecchie.

Possa la Chiave d'argento illuminare il tuo cammino, Custode di Mythag.]]
  },
  RelicConfig_65406_BattleDesc = {
    Text = "All'inizio del turno, ottieni [Arg1] <DerivativeCardKeywords_71:Splendore dell'Umanità>.\n<D05EX_Relic:Tutti i tuoi sforzi sono valsi la pena; hai salvato quasi l'intero team di ricerca, e i sopravvissuti ti sono sinceramente grati.>"
  },
  RelicConfig_65406_Desc = {
    Text = "All'inizio del turno, ottieni [Arg1] <DerivativeCardKeywords_71:Splendore dell'Umanità>.\n<D05EX_Relic:Tutti i tuoi sforzi sono valsi la pena; hai salvato quasi l'intero team di ricerca, e i sopravvissuti ti sono sinceramente grati.>"
  },
  RelicConfig_65406_Name = {
    Text = "<OrangeQuality:Medaglia di Soccorso: Platino>"
  },
  RelicConfig_65406_StoryDesc = {
    Text = "I tuoi sforzi sono valsi la pena; hai quasi salvato l'intera Squadra di Spedizione. I sopravvissuti ti sono profondamente grati."
  },
  RelicConfig_65407_BattleDesc = {
    Text = "All'inizio del turno, ottieni [Arg1] <DerivativeCardKeywords_72:\"Brillantezza dell'umanità\">.\n<D05EX_Relic:Hai creato un miracolo incredibile; tutti sono sopravvissuti al disastro, e sei acclamato come un grande eroe. La tua leggenda si diffonderà presto per tutta la montagna innevata.>"
  },
  RelicConfig_65407_Desc = {
    Text = "All'inizio del turno, ottieni [Arg1] <DerivativeCardKeywords_72:\"Brillantezza dell'umanità\">.\n<D05EX_Relic:Hai creato un miracolo incredibile; tutti sono sopravvissuti al disastro, e sei acclamato come un grande eroe. La tua leggenda si diffonderà presto per tutta la montagna innevata.>"
  },
  RelicConfig_65407_Name = {
    Text = "<OrangeQuality:Medaglia di Soccorso: Diamante>"
  },
  RelicConfig_65407_StoryDesc = {
    Text = "Hai compiuto un miracolo incredibile; tutti sono sopravvissuti al disastro. Sei un grande eroe, e la tua leggenda potrebbe presto diffondersi per tutta la Montagna Innevata."
  },
  RelicConfig_65408_BattleDesc = {
    Text = "All'inizio del turno, ottieni [Arg1] <DerivativeCardKeywords_68:\"Bagliore dell'Umanità\">. \n<D05EX_Relic:Per fuggire dalla montagna innevata, hai scelto una strategia che dava priorità all'efficienza e hai guardato le persone morire una dopo l'altra. Lo sguardo dei sopravvissuti verso di te conteneva più paura che gratitudine.>"
  },
  RelicConfig_65408_Desc = {
    Text = "All'inizio del turno, ottieni [Arg1] <DerivativeCardKeywords_68:\"Bagliore dell'Umanità\">. \n<D05EX_Relic:Per fuggire dalla montagna innevata, hai scelto una strategia che dava priorità all'efficienza e hai guardato le persone morire una dopo l'altra. Lo sguardo dei sopravvissuti verso di te conteneva più paura che gratitudine.>"
  },
  RelicConfig_65408_Name = {
    Text = "<OrangeQuality:Medaglia di Soccorso: Bronzo>"
  },
  RelicConfig_65408_StoryDesc = {
    Text = "Per lasciare la Montagna Innevata, hai adottato una strategia che privilegiava l'efficienza, osservando le persone cadere una dopo l'altra. I sopravvissuti ti guardavano con più paura che gratitudine."
  },
  RelicConfig_65409_BattleDesc = {
    Text = "All'inizio del turno, ottieni [Arg1] <DerivativeCardKeywords_69:\"Barlume di Umanità\">.\n<D05EX_Relic:Forse hai fatto del tuo meglio. Anche se metà delle persone è perita, almeno hai salvato l'altra metà. Dopotutto, il sacrificio è inevitabile.>"
  },
  RelicConfig_65409_Desc = {
    Text = "All'inizio del turno, ottieni [Arg1] <DerivativeCardKeywords_69:\"Barlume di Umanità\">.\n<D05EX_Relic:Forse hai fatto del tuo meglio. Anche se metà delle persone è perita, almeno hai salvato l'altra metà. Dopotutto, il sacrificio è inevitabile.>"
  },
  RelicConfig_65409_Name = {
    Text = "<OrangeQuality:Medaglia di Soccorso: Argento>"
  },
  RelicConfig_65409_StoryDesc = {
    Text = "Hai fatto del tuo meglio. Sebbene metà di loro sia perita, sei riuscito a salvare l'altra metà. Dopotutto, i sacrifici sono inevitabili."
  },
  RelicConfig_65410_BattleDesc = {
    Text = "All'inizio del turno, ottieni [Arg1] <DerivativeCardKeywords_70:\"Umanità\">.\n<D05EX_Relic:Hai salvato la maggior parte delle persone, riscrivendo i loro tragici destini. Hai fatto del tuo meglio, non è vero?>"
  },
  RelicConfig_65410_Desc = {
    Text = "All'inizio del turno, ottieni [Arg1] <DerivativeCardKeywords_70:\"Umanità\">.\n<D05EX_Relic:Hai salvato la maggior parte delle persone, riscrivendo i loro tragici destini. Hai fatto del tuo meglio, non è vero?>"
  },
  RelicConfig_65410_Name = {
    Text = "<OrangeQuality:Medaglia di Soccorso: Oro>"
  },
  RelicConfig_65410_StoryDesc = {
    Text = "Hai salvato la maggior parte delle persone e riscritto i loro tragici destini. Hai fatto del tuo meglio, non è vero?"
  },
  RelicConfig_65456_BattleDesc = {
    Text = "All'inizio della battaglia, mischia 3 \"Sintomi\" casuali. Quando giochi \"Sintomi\", ottieni [Arg1] FOR.\n<D05EX_Relic:Con il tuo aiuto, nessuno della Squadra di Spedizione è sopravvissuto, e tu hai ottenuto con freddezza il massimo beneficio per te stesso. Ma ne è valsa davvero la pena?>"
  },
  RelicConfig_65456_Desc = {
    Text = "All'inizio della battaglia, mischia 3 \"Sintomi\" casuali. Quando giochi \"Sintomi\", ottieni [Arg1] FOR.\n<D05EX_Relic:Con il tuo aiuto, nessuno della Squadra di Spedizione è sopravvissuto, e tu hai ottenuto con freddezza il massimo beneficio per te stesso. Ma ne è valsa davvero la pena?>"
  },
  RelicConfig_65456_Name = {
    Text = "<OrangeQuality:Insegna del Lupo Solitario>"
  },
  RelicConfig_65456_StoryDesc = {
    Text = "Con il tuo aiuto, nessuno della Squadra di Spedizione è sopravvissuto. Hai ottenuto il massimo vantaggio per te stesso, ma ne è valsa davvero la pena?"
  },
  RelicConfig_65569_BattleDesc = {
    Text = "All'inizio della battaglia, aumenta il Limite di Arithmetica di 1 e Ridesta tutti i Risvegliatori. Per i successivi 5 turni, ottieni una Reliquia a inizio turno: \"Relè di Segnale, La Sagra della Primavera, Bastone dell'Ierofante, Uccello Rituale del Presagio, Pendolo Crono: Proiezione\"."
  },
  RelicConfig_65569_Desc = {
    Text = "All'inizio della battaglia, aumenta il Limite di Arithmetica di 1 e Ridesta tutti i Risvegliatori. Per i successivi 5 turni, ottieni una Reliquia a inizio turno: \"Relè di Segnale, La Sagra della Primavera, Bastone dell'Ierofante, Uccello Rituale del Presagio, Pendolo Crono: Proiezione\"."
  },
  RelicConfig_65569_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Tesoro δ\">"
  },
  RelicConfig_65570_BattleDesc = {
    Text = "All'inizio della battaglia, aumenta il Limite di Arithmetica di +1 e Ridesta tutti i Risvegliatori. Per i successivi 5 turni, ottieni una Reliquia a inizio turno: \"Insegna Mythag, Valigetta del dottore, Batteria Prototipo, Incisione della Coscienza, Pendolo Crono: Evoluzione\"."
  },
  RelicConfig_65570_Desc = {
    Text = "All'inizio della battaglia, aumenta il Limite di Arithmetica di +1 e Ridesta tutti i Risvegliatori. Per i successivi 5 turni, ottieni una Reliquia a inizio turno: \"Insegna Mythag, Valigetta del dottore, Batteria Prototipo, Incisione della Coscienza, Pendolo Crono: Evoluzione\"."
  },
  RelicConfig_65570_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Tesoro γ\">"
  },
  RelicConfig_66515_BattleDesc = {
    Text = "All'inizio della battaglia, aumenta il Limite di Arithmetica di 1 e Ridesta tutti i Risvegliatori. Per i successivi 5 turni, ottieni una Reliquia a inizio turno: \"Gazzetta Mattutina di Putney, Principi dell'Estetica, Canto della Folla, Volto Infranto, Pendolo Crono: Reciprocità\"."
  },
  RelicConfig_66515_Desc = {
    Text = "All'inizio della battaglia, aumenta il Limite di Arithmetica di 1 e Ridesta tutti i Risvegliatori. Per i successivi 5 turni, ottieni una Reliquia a inizio turno: \"Gazzetta Mattutina di Putney, Principi dell'Estetica, Canto della Folla, Volto Infranto, Pendolo Crono: Reciprocità\"."
  },
  RelicConfig_66515_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Tesoro ε\">"
  },
  RelicConfig_66518_BattleDesc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_66518_Desc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_66518_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Desiderio β\">"
  },
  RelicConfig_66519_BattleDesc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_66519_Desc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_66519_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Desiderio α\">"
  },
  RelicConfig_67690_BattleDesc = {
    Text = "A inizio turno, tutti i Risvegliati ottengono 25 Aliemus. Quando raccolto, gli HP massimi diventano 1,5 volte."
  },
  RelicConfig_67690_Desc = {
    Text = "A inizio turno, tutti i Risvegliati ottengono 25 Aliemus. Quando raccolto, gli HP massimi diventano 1,5 volte."
  },
  RelicConfig_67690_Name = {
    Text = "<OrangeQuality:Benedetto: Manifestazione dell'Incubo β>"
  },
  RelicConfig_67690_StoryDesc = {
    Text = "Non temere, non esitare. Questo non è che Un Sogno Fugace; la luce del Padre Supremo risplende ancora su di te."
  },
  RelicConfig_67788_BattleDesc = {
    Text = "Quando raccolto, ottieni 3 Arithmetica."
  },
  RelicConfig_67788_Desc = {
    Text = "Quando raccolto, ottieni 3 Arithmetica."
  },
  RelicConfig_67788_Name = {
    Text = "<WhiteQuality:Specchio da Orologio da Tasca>"
  },
  RelicConfig_67788_StoryDesc = {
    Text = "Memorie solidificate nel passato, sepolte in profondità negli abissi neri."
  },
  RelicConfig_67789_BattleDesc = {
    Text = "Quando raccolto, colloca 1 <DerivativeCardKeywords_1:\"Echi di Ombre Perdute\"> in mano."
  },
  RelicConfig_67789_Desc = {
    Text = "Quando raccolto, colloca 1 <DerivativeCardKeywords_1:\"Echi di Ombre Perdute\"> in mano."
  },
  RelicConfig_67789_Name = {
    Text = "<WhiteQuality:Relè di Segnale>"
  },
  RelicConfig_67789_StoryDesc = {
    Text = "Attendi o temi il momento in cui suonerà."
  },
  RelicConfig_67790_BattleDesc = {
    Text = "Il Danno Crit. di tutti i \"Colpo\" è aumentato del 20%. Al momento della raccolta, aggiungi 1 <DerivativeCardKeywords_40:\"Bellezza Fugace\"> alla tua mano."
  },
  RelicConfig_67790_Desc = {
    Text = "Il Danno Crit. di tutti i \"Colpo\" è aumentato del 20%. Al momento della raccolta, aggiungi 1 <DerivativeCardKeywords_40:\"Bellezza Fugace\"> alla tua mano."
  },
  RelicConfig_67790_Name = {
    Text = "<WhiteQuality:Bellezza Fugace>"
  },
  RelicConfig_67790_StoryDesc = {
    Text = "Preserva per sempre la bellezza degli istanti fugaci."
  },
  RelicConfig_67791_BattleDesc = {
    Text = "Quando raccolto, infliggi 1 turno di <WeaknessIconKeywords:Debolezza> e <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici."
  },
  RelicConfig_67791_Desc = {
    Text = "Quando raccolto, infliggi 1 turno di <WeaknessIconKeywords:Debolezza> e <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici."
  },
  RelicConfig_67791_Name = {
    Text = "<WhiteQuality:Camicia di Forza Cangiante>"
  },
  RelicConfig_67791_StoryDesc = {
    Text = "Non solo il tempo può far sbiadire i tessuti, ma anche il terrore e il pain."
  },
  RelicConfig_67793_BattleDesc = {
    Text = "A inizio battaglia, tutti i Risvegliati ottengono 50 Aliemus. Metti 2 copie di <DerivativeCardKeywords_1:\"Echi di Ombre Perdute\"> nella mano."
  },
  RelicConfig_67793_Desc = {
    Text = "Quando raccolto, tutti i Risvegliati ottengono 50 Aliemus, e metti 2 <DerivativeCardKeywords_1:\"Echi di Ombre Perdute\"> nella mano."
  },
  RelicConfig_67793_Name = {
    Text = "<OrangeQuality:Relè di Segnale +β>"
  },
  RelicConfig_67793_StoryDesc = {
    Text = "Attendi o temi il momento in cui suonerà."
  },
  RelicConfig_67794_BattleDesc = {
    Text = "Aumenta il limite della mano di 5 e riempila fino al limite all'inizio della battaglia. Pesca 1 carta aggiuntiva all'inizio del turno e scarta tutte le Carte sintomo e le Carte di stato a fine turno, conservando le altre carte."
  },
  RelicConfig_67794_Desc = {
    Text = "Aumenta il limite della mano di 5 e riempila fino al limite all'inizio della battaglia. Pesca 1 carta aggiuntiva all'inizio del turno e scarta tutte le Carte sintomo e le Carte di stato a fine turno, conservando le altre carte."
  },
  RelicConfig_67794_Name = {
    Text = "<OrangeQuality:Benedetto: Incisione Mentale β>"
  },
  RelicConfig_67794_StoryDesc = {
    Text = "Gli avidi incidono i propri errori nel cuore e si dedicano a espiare il loro passato."
  },
  RelicConfig_67818_BattleDesc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_67818_Desc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_67818_Name = {
    Text = "<OrangeQuality:\"Portale di Tutti i Reami ε\">"
  },
  RelicConfig_67819_BattleDesc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_67819_Desc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_67819_Name = {
    Text = "<OrangeQuality:\"Portale di Tutti i Reami ζ\">"
  },
  RelicConfig_67820_BattleDesc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_67820_Desc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_67820_Name = {
    Text = "<OrangeQuality:\"Portale di Tutti i Reami θ\">"
  },
  RelicConfig_67821_BattleDesc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_67821_Desc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_67821_Name = {
    Text = "<OrangeQuality:\"Portale di Tutti i Reami γ\">"
  },
  RelicConfig_67822_BattleDesc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_67822_Desc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_67822_Name = {
    Text = "<OrangeQuality:\"Portale di Tutti i Reami α\">"
  },
  RelicConfig_67823_BattleDesc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_67823_Desc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_67823_Name = {
    Text = "<OrangeQuality:\"Portale di Tutti i Reamiη\">"
  },
  RelicConfig_67824_BattleDesc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_67824_Desc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_67824_Name = {
    Text = "<OrangeQuality:\"Portale di Tutti i Reamiδ\">"
  },
  RelicConfig_67825_BattleDesc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_67825_Desc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_67825_Name = {
    Text = "<OrangeQuality:\"Portale di Tutti i Reami β\">"
  },
  RelicConfig_67826_BattleDesc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_67826_Desc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_67826_Name = {
    Text = "<OrangeQuality:\"Portale di Tutti i Reami ι\">"
  },
  RelicConfig_68651_BattleDesc = {
    Text = "A inizio battaglia, Risveglia tutti i Risvegliatori, aggiungi <DerivativeCardKeywords_84:\"Crepuscolo: Scultura di Cera Incompiuta\"> alla mano, copiando tutte le carte nel Mazzo di Pesca. Pesca 5 carte aggiuntive ogni turno e ottieni 5 Arithmetica. Dopo aver giocato \"Attacco\" o \"Difesa\", ottieni [Arg1] Scudo."
  },
  RelicConfig_68651_Desc = {
    Text = "A inizio battaglia, Risveglia tutti i Risvegliatori, aggiungi <DerivativeCardKeywords_84:\"Crepuscolo: Scultura di Cera Incompiuta\"> alla mano, copiando tutte le carte nel Mazzo di Pesca. Pesca 5 carte aggiuntive ogni turno e ottieni 5 Arithmetica. Dopo aver giocato \"Attacco\" o \"Difesa\", ottieni [Arg1] Scudo."
  },
  RelicConfig_68651_Name = {
    Text = "<OrangeQuality:\"Nucleo d'Argento Puro: Paura\">"
  },
  RelicConfig_68652_BattleDesc = {
    Text = "All'inizio della battaglia, Risveglia tutti i Risvegliatori e colloca <DerivativeCardKeywords_85:\"Crepuscolo: Cuore Mutato\"> In Mano. All'inizio del turno, puoi scegliere di scartare un numero qualsiasi di carte In Mano e pescarne altrettante. Nei turni dispari, ottieni [Arg1] FOR temporanea e colloca <DerivativeCardKeywords_97:Volontà indomabile β> In Mano. Nei turni pari, ottieni [Arg2] Allerta temporanea e colloca <DerivativeCardKeywords_98:Nascondiβ> In Mano."
  },
  RelicConfig_68652_Desc = {
    Text = "All'inizio della battaglia, Risveglia tutti i Risvegliatori e colloca <DerivativeCardKeywords_85:\"Crepuscolo: Cuore Mutato\"> In Mano. All'inizio del turno, puoi scegliere di scartare un numero qualsiasi di carte In Mano e pescarne altrettante. Nei turni dispari, ottieni [Arg1] FOR temporanea e colloca <DerivativeCardKeywords_97:Volontà indomabile β> In Mano. Nei turni pari, ottieni [Arg2] Allerta temporanea e colloca <DerivativeCardKeywords_98:Nascondiβ> In Mano."
  },
  RelicConfig_68652_Name = {
    Text = "<OrangeQuality:\"Nucleo d'Argento Puro: Flagello\">"
  },
  RelicConfig_68653_BattleDesc = {
    Text = "A inizio battaglia, Risveglia tutti i Risvegliatori, aggiungi <DerivativeCardKeywords_83:\"Crepuscolo: Dono Innocente di Ritorno\"> alla mano. Tutti i Risvegliatori possono rilasciare 1 Esaltazione aggiuntiva per turno; dopo aver rilasciato Esaltazione, riduci la FOR del nemico di [Arg2]. A inizio turno, tutti i Risvegliatori ottengono [Arg1] Aliemus."
  },
  RelicConfig_68653_Desc = {
    Text = "A inizio battaglia, Risveglia tutti i Risvegliatori, aggiungi <DerivativeCardKeywords_83:\"Crepuscolo: Dono Innocente di Ritorno\"> alla mano. Tutti i Risvegliatori possono rilasciare 1 Esaltazione aggiuntiva per turno; dopo aver rilasciato Esaltazione, riduci la FOR del nemico di [Arg2]. A inizio turno, tutti i Risvegliatori ottengono [Arg1] Aliemus."
  },
  RelicConfig_68653_Name = {
    Text = "<OrangeQuality:\"Nucleo d'Argento Puro: Pianto\">"
  },
  RelicConfig_68654_BattleDesc = {
    Text = "All'inizio della battaglia, Risveglia tutti gli Awakener, colloca <DerivativeCardKeywords_88:\"Crepuscolo: Velo Utopico\"> nella mano, aumenta il limite di carte in mano della squadra di +2 e aumenta il limite di accumulo di Keyflare del +100%. Dopo aver liberato il Posse, il Danno Crit. e il Tasso critico temporaneo di tutti gli Awakener +[Arg1]%, ricevono uno Scudo pari al 20% dei loro PV massimi e pescano carte fino a raggiungere il limite della mano."
  },
  RelicConfig_68654_Desc = {
    Text = "All'inizio della battaglia, Risveglia tutti gli Awakener, colloca <DerivativeCardKeywords_88:\"Crepuscolo: Velo Utopico\"> nella mano, aumenta il limite di carte in mano della squadra di +2 e aumenta il limite di accumulo di Keyflare del +100%. Dopo aver liberato il Posse, il Danno Crit. e il Tasso critico temporaneo di tutti gli Awakener +[Arg1]%, ricevono uno Scudo pari al 20% dei loro PV massimi e pescano carte fino a raggiungere il limite della mano."
  },
  RelicConfig_68654_Name = {
    Text = "<OrangeQuality:\"Nucleo d'Argento Puro: Follia\">"
  },
  RelicConfig_68655_BattleDesc = {
    Text = "A inizio battaglia, Risveglia tutti i Risvegliatori, aggiungi <DerivativeCardKeywords_89:\"Crepuscolo: Seme dell'Abbondanza\"> alla mano. A fine turno, conserva l'Arithmetica rimanente e non scartare più le carte. Per ogni istanza di Danno attivo inflitta, ottieni [Arg1] FOR temporanea e [Arg2] Scudo."
  },
  RelicConfig_68655_Desc = {
    Text = "A inizio battaglia, Risveglia tutti i Risvegliatori, aggiungi <DerivativeCardKeywords_89:\"Crepuscolo: Seme dell'Abbondanza\"> alla mano. A fine turno, conserva l'Arithmetica rimanente e non scartare più le carte. Per ogni istanza di Danno attivo inflitta, ottieni [Arg1] FOR temporanea e [Arg2] Scudo."
  },
  RelicConfig_68655_Name = {
    Text = "<OrangeQuality:\"Nucleo d'Argento Puro: Nascita\">"
  },
  RelicConfig_68656_BattleDesc = {
    Text = "All'inizio della battaglia, Risveglia tutti i Risvegliati, colloca <DerivativeCardKeywords_86:\"Crepuscolo: Idromele al Miele\"> in mano e aumenta il Danno Crit. di tutti i Risvegliati di 1,5 volte. Alla fine del turno, i Risvegliati che non hanno rilasciato Esaltazione ottengono [Arg1] Aliemus. Se il numero di carte giocate è inferiore a [Arg2], pesca 2 carte il turno successivo e ottieni 2 Arithmetica."
  },
  RelicConfig_68656_Desc = {
    Text = "All'inizio della battaglia, Risveglia tutti i Risvegliati, colloca <DerivativeCardKeywords_86:\"Crepuscolo: Idromele al Miele\"> in mano e aumenta il Danno Crit. di tutti i Risvegliati di 1,5 volte. Alla fine del turno, i Risvegliati che non hanno rilasciato Esaltazione ottengono [Arg1] Aliemus. Se il numero di carte giocate è inferiore a [Arg2], pesca 2 carte il turno successivo e ottieni 2 Arithmetica."
  },
  RelicConfig_68656_Name = {
    Text = "<OrangeQuality:\"Nucleo d'Argento Puro: Inganno\">"
  },
  RelicConfig_68657_BattleDesc = {
    Text = "All'inizio della battaglia, Risveglia tutti i Risvegliatori, inserisci <DerivativeCardKeywords_87:\"Crepuscolo: Verdetto dell'Emissario\"> in mano e raddoppia l'Amplificazione del Danno del team. L'effetto Sintomo: Debolezza da te inflitto aumenta dal 25% al 50%. Alla fine di ogni turno, ottieni Scudo pari al [Arg1]% della Salute massima e infliggi <FixedDamage:DAN Puro> pari a [Arg2] x Scudo a tutti i nemici."
  },
  RelicConfig_68657_Desc = {
    Text = "All'inizio della battaglia, Risveglia tutti i Risvegliatori, inserisci <DerivativeCardKeywords_87:\"Crepuscolo: Verdetto dell'Emissario\"> in mano e raddoppia l'Amplificazione del Danno del team. L'effetto Sintomo: Debolezza da te inflitto aumenta dal 25% al 50%. Alla fine di ogni turno, ottieni Scudo pari al [Arg1]% della Salute massima e infliggi <FixedDamage:DAN Puro> pari a [Arg2] x Scudo a tutti i nemici."
  },
  RelicConfig_68657_Name = {
    Text = "<OrangeQuality:\"Nucleo d'Argento Puro: Eresia\">"
  },
  RelicConfig_68886_BattleDesc = {
    Text = "Il Danno, le Cure e lo Scudo di Tawil sono potenziati del 50%. A inizio battaglia, Tawil ottiene 120 Aliemus."
  },
  RelicConfig_68886_Desc = {
    Text = "Il Danno, lo Scudo e il Recupero PV di Tawil aumentano del 50%. A inizio combattimento, Tawil ottiene 120 Aliemus."
  },
  RelicConfig_68886_Name = {
    Text = "<OrangeQuality:Occhio Onnisciente>"
  },
  RelicConfig_68886_StoryDesc = {
    Text = "Uscendo dal Portale, Egli posa il piede sull'unico sentiero corretto."
  },
  RelicConfig_69319_BattleDesc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_69319_Desc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_69319_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Desiderio ε\">"
  },
  RelicConfig_69320_BattleDesc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_69320_Desc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_69320_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Desiderio γ\">"
  },
  RelicConfig_69321_BattleDesc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_69321_Desc = {
    Text = "All'inizio della battaglia, Limite di Arithmetica +1, Ridesta tutti i Risvegliatori. A inizio turno, Scopri casualmente una \"Reliquia\" o un \"Supporto\", fino a 5 volte."
  },
  RelicConfig_69321_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Desiderio δ\">"
  },
  RelicConfig_70042_BattleDesc = {
    Text = "A inizio turno, accumula 1 \"Energia Abissale\" e scegli \"Dormiveglia\" o \"Risveglio\". Dormiveglia: accumula inoltre 1 \"Energia Abissale\". Risveglio: consuma 1/5/10 \"Energia Abissale\" per ottenere l'assistenza di Tulu. Più \"Energia Abissale\" viene consumata, più potente sarà l'effetto dell'assistenza di Tulu."
  },
  RelicConfig_70042_Desc = {
    Text = "A inizio turno, accumula 1 \"Energia Abissale\" e scegli \"Dormiveglia\" o \"Risveglio\". Dormiveglia: accumula inoltre 1 \"Energia Abissale\". Risveglio: consuma 1/5/10 \"Energia Abissale\" per ottenere l'assistenza di Tulu. Più \"Energia Abissale\" viene consumata, più potente sarà l'effetto dell'assistenza di Tulu."
  },
  RelicConfig_70042_Name = {
    Text = "<OrangeQuality:Potere del Sovrano>"
  },
  RelicConfig_70084_BattleDesc = {
    Text = "A inizio battaglia, mischia tutti i \"Risveglio\" dei Risvegliatori nel Mazzo di Pesca."
  },
  RelicConfig_70084_Desc = {
    Text = "A inizio battaglia, mischia tutti i \"Risveglio\" dei Risvegliatori nel Mazzo di Pesca."
  },
  RelicConfig_70084_Name = {
    Text = "<OrangeQuality:Risveglio>"
  },
  RelicConfig_70700_BattleDesc = {
    Text = "Il DAN Base di tutti i Risvegliatori aumenta del [Arg1]%."
  },
  RelicConfig_70700_Desc = {
    Text = "Il DAN Base di tutti i Risvegliatori aumenta del [Arg1]%."
  },
  RelicConfig_70700_Name = {
    Text = "<WhiteQuality:Pipa Piangente>"
  },
  RelicConfig_70700_StoryDesc = {
    Text = "È il frutto dell'Odio o il risultato della vendetta?"
  },
  RelicConfig_70701_BattleDesc = {
    Text = "A inizio turno, tutti i Risvegliati ottengono [Arg1] Aliemus."
  },
  RelicConfig_70701_Desc = {
    Text = "A inizio turno, tutti i Risvegliati ottengono [Arg1] Aliemus."
  },
  RelicConfig_70701_Name = {
    Text = "<WhiteQuality:Batteria Prototipo>"
  },
  RelicConfig_70701_StoryDesc = {
    Text = "Speranza Portatile"
  },
  RelicConfig_70702_BattleDesc = {
    Text = "Dopo aver rilasciato \"Esaltazione\", ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_70702_Desc = {
    Text = "Dopo aver rilasciato \"Esaltazione\", ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_70702_Name = {
    Text = "<OrangeQuality:Serratura di ferro+>"
  },
  RelicConfig_70702_StoryDesc = {
    Text = "Un lucchetto spesso e robusto, difficile da aprire senza una chiave.\nNaturalmente, questo non è nulla per un maestro ladro"
  },
  RelicConfig_70703_BattleDesc = {
    Text = "\"Colpo\" infligge un'istanza aggiuntiva di danni pari al [Arg1]% dell'ATT del Risvegliato, attivabile fino a 3 volte per turno."
  },
  RelicConfig_70703_Desc = {
    Text = "\"Colpo\" infligge un'istanza aggiuntiva di danni pari al [Arg1]% dell'ATT del Risvegliato, attivabile fino a 3 volte per turno."
  },
  RelicConfig_70703_Name = {
    Text = "<WhiteQuality:Bisturi Arrugginito>"
  },
  RelicConfig_70703_StoryDesc = {
    Text = "Non adatto a tagliare tessuti vivi."
  },
  RelicConfig_70704_BattleDesc = {
    Text = "Usa Keyflare Risveglio per applicare [Arg1] <IntoxicationIconKeywords:Veleno> a tutti i nemici e ottieni [Arg2] Keyflare."
  },
  RelicConfig_70704_Desc = {
    Text = "Usa Keyflare Risveglio per applicare [Arg1] <IntoxicationIconKeywords:Veleno> a tutti i nemici e ottieni [Arg2] Keyflare."
  },
  RelicConfig_70704_Name = {
    Text = "<OrangeQuality:Unguento Sospetto+>"
  },
  RelicConfig_70704_StoryDesc = {
    Text = "Una sorta di unguento artigianale per ferite esterne. Non utilizzare senza la supervisione di un dottore."
  },
  RelicConfig_70705_BattleDesc = {
    Text = "\"Colpo\" applica <IntoxicationIconKeywords:Veleno> pari al [Arg1]% del DAN inflitto, con un massimo di [Arg2] per turno."
  },
  RelicConfig_70705_Desc = {
    Text = "\"Colpo\" applica <IntoxicationIconKeywords:Veleno> pari al [Arg1]% del DAN inflitto, con un massimo di [Arg2] per turno."
  },
  RelicConfig_70705_Name = {
    Text = "<OrangeQuality:Lingua Aliena+>"
  },
  RelicConfig_70705_StoryDesc = {
    Text = "Non è un demone, eppure trasmette davvero sussurri provenienti da oltre il regno dei mortali."
  },
  RelicConfig_70706_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:Fusione Embrionale> Guadagno automatico +[Arg1]%"
  },
  RelicConfig_70706_Desc = {
    Text = "<EmbryoFusionIconKeywords:Fusione Embrionale> Guadagno automatico +[Arg1]%"
  },
  RelicConfig_70706_Name = {
    Text = "<WhiteQuality:Referto della Pestilenza>"
  },
  RelicConfig_70706_StoryDesc = {
    Text = "Peste — una manifestazione inconscia e inquieta della natura."
  },
  RelicConfig_70707_BattleDesc = {
    Text = "Dopo aver usato Keyflare Risveglio, tutti i Risvegliati ottengono [Arg1] Aliemus e [Arg2] Keyflare."
  },
  RelicConfig_70707_Desc = {
    Text = "Dopo aver usato Keyflare Risveglio, tutti i Risvegliati ottengono [Arg1] Aliemus e [Arg2] Keyflare."
  },
  RelicConfig_70707_Name = {
    Text = "<OrangeQuality:Gemelli da Polso all'Alloro+>"
  },
  RelicConfig_70707_StoryDesc = {
    Text = [[
Gemelli da polso in argento incisi con motivi di foglie di osmanto.
Finemente lavorati e scintillanti, un tempo incarnavano l'amicizia di due fanciulli.]]
  },
  RelicConfig_70708_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni [Arg1] <ProficientInRealmsIconKeywords:Padronanza del Reame>. Tutti gli effetti di <IntoxicationIconKeywords:Veleno> dei Risvegliatori e delle Reliquie sono potenziati del +[Arg2]%."
  },
  RelicConfig_70708_Desc = {
    Text = "All'inizio della battaglia, ottieni [Arg1] <ProficientInRealmsIconKeywords:Padronanza del Reame>. Tutti gli effetti di <IntoxicationIconKeywords:Veleno> dei Risvegliatori e delle Reliquie sono potenziati del +[Arg2]%."
  },
  RelicConfig_70708_Name = {
    Text = "<OrangeQuality:Telaio Dimenticato+>"
  },
  RelicConfig_70708_StoryDesc = {
    Text = "Una madre amorevole risana le ferite del cuore."
  },
  RelicConfig_70709_BattleDesc = {
    Text = "Dopo essere entrati nel Turno Ultra, la prima Carta Comando Non-Derivata giocata si attiva [Arg1] volte aggiuntive."
  },
  RelicConfig_70709_Desc = {
    Text = "Dopo essere entrati nel Turno Ultra, la prima Carta Comando Non-Derivata giocata si attiva [Arg1] volte aggiuntive."
  },
  RelicConfig_70709_Name = {
    Text = "<WhiteQuality:Clessidra Luminosa>"
  },
  RelicConfig_70709_StoryDesc = {
    Text = "Una quantità misurabile di tempo."
  },
  RelicConfig_70711_BattleDesc = {
    Text = "Usa Keyflare Risveglio e ottieni [Arg1] <RetaliateIconKeywords:Contatore> e [Arg2] Keyflare."
  },
  RelicConfig_70711_Desc = {
    Text = "Usa Keyflare Risveglio e ottieni [Arg1] <RetaliateIconKeywords:Contatore> e [Arg2] Keyflare."
  },
  RelicConfig_70711_Name = {
    Text = "<OrangeQuality:Frammento dei Saggi+>"
  },
  RelicConfig_70711_StoryDesc = {
    Text = "\"Quanto sono sciocchi gli umani, che credono ciecamente solo perché qualcosa è antico.\""
  },
  RelicConfig_70712_BattleDesc = {
    Text = "Usa Keyflare Risveglio e ottieni [Arg1] <PowerIconKeywords:FOR> e [Arg2] Keyflare."
  },
  RelicConfig_70712_Desc = {
    Text = "Usa Keyflare Risveglio e ottieni [Arg1] <PowerIconKeywords:FOR> e [Arg2] Keyflare."
  },
  RelicConfig_70712_Name = {
    Text = "<WhiteQuality:La Nostra Casa>"
  },
  RelicConfig_70712_StoryDesc = {
    Text = "Erano insieme in passato, e saranno sempre insieme in futuro. Sono una famiglia unita e amorevole."
  },
  RelicConfig_70713_BattleDesc = {
    Text = "Alla perdita di PV, accumula Fornace Cremisi pari al [Arg1]% dei PV persi."
  },
  RelicConfig_70713_Desc = {
    Text = "Alla perdita di PV, accumula Fornace Cremisi pari al [Arg1]% dei PV persi."
  },
  RelicConfig_70713_Name = {
    Text = "<WhiteQuality:Sega Arrugginita>"
  },
  RelicConfig_70713_StoryDesc = {
    Text = "Il dottore anatomista trascorre la sua vita senza mai vedere una bella donna, solo sacchi d'ossa, nervi infiammati, muscoli e tessuti corrosi dalle malattie."
  },
  RelicConfig_70714_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni [Arg1] <ProficientInRealmsIconKeywords:Padronanza del Reame>. Il <RetaliateIconKeywords:Contatore> di tutti i Risvegliatori e delle Reliquie è potenziato del +[Arg2]%."
  },
  RelicConfig_70714_Desc = {
    Text = "All'inizio della battaglia, ottieni [Arg1] <ProficientInRealmsIconKeywords:Padronanza del Reame>. Il <RetaliateIconKeywords:Contatore> di tutti i Risvegliatori e delle Reliquie è potenziato del +[Arg2]%."
  },
  RelicConfig_70714_Name = {
    Text = "<WhiteQuality:Verità Senza Riserve>"
  },
  RelicConfig_70714_StoryDesc = {
    Text = "Trasmette innumerevoli Segreti, che siano pronunciati attivamente o passivamente."
  },
  RelicConfig_70715_BattleDesc = {
    Text = "Dopo aver usato Keyflare Risveglio, pesca [Arg1] carte e ottieni [Arg2] Keyflare."
  },
  RelicConfig_70715_Desc = {
    Text = "Dopo aver usato Keyflare Risveglio, pesca [Arg1] carte e ottieni [Arg2] Keyflare."
  },
  RelicConfig_70715_Name = {
    Text = "<OrangeQuality:Portafoglio Nuovo di Zecca+>"
  },
  RelicConfig_70715_StoryDesc = {
    Text = "Un portafoglio in pelle inciso con l'emblema dell'Università di Mythag.\nOra è vuoto, non contiene più nulla."
  },
  RelicConfig_70717_BattleDesc = {
    Text = "A inizio turno, pesca [Arg1] carte."
  },
  RelicConfig_70717_Desc = {
    Text = "A inizio turno, pesca [Arg1] carte."
  },
  RelicConfig_70717_Name = {
    Text = "<OrangeQuality:Bussola del Nord Vero+>"
  },
  RelicConfig_70717_StoryDesc = {
    Text = "L'indicazione non è una direzione, bensì un campo magnetico."
  },
  RelicConfig_70718_BattleDesc = {
    Text = "Dopo aver rilasciato \"Esaltazione,\" tutti i nemici subiscono [Arg1] <FixedDamage:DAN Puro> e attivano il [Arg2]% di <IntoxicationIconKeywords:Veleno>."
  },
  RelicConfig_70718_Desc = {
    Text = "Dopo aver rilasciato \"Esaltazione,\" tutti i nemici subiscono 1 istanza di <FixedDamage:DAN Puro> pari al [Arg2]% della Salute massima del team e attivano il [Arg2]% di <IntoxicationIconKeywords:Veleno>."
  },
  RelicConfig_70718_Name = {
    Text = "<WhiteQuality:Mandibola al Radio>"
  },
  RelicConfig_70718_StoryDesc = {
    Text = "Esposto nella sala privata di un collezionista.\nIl collezionista rimase ammaliato dalla sua splendida fluorescenza, ammirandolo giorno e notte, finché non avvizzì e divenne uno dei suoi simili."
  },
  RelicConfig_70719_BattleDesc = {
    Text = "A inizio turno, tutti i Risvegliati ottengono [Arg1] Aliemus."
  },
  RelicConfig_70719_Desc = {
    Text = "A inizio turno, tutti i Risvegliati ottengono [Arg1] Aliemus."
  },
  RelicConfig_70719_Name = {
    Text = "<OrangeQuality:Batteria Prototipo+>"
  },
  RelicConfig_70719_StoryDesc = {
    Text = "Speranza Portatile"
  },
  RelicConfig_70720_BattleDesc = {
    Text = "A inizio turno, se i PV sono inferiori al 25%, si ottiene [Arg1] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_70720_Desc = {
    Text = "A inizio turno, se i PV sono inferiori al 25%, si ottiene [Arg1] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_70720_Name = {
    Text = "<WhiteQuality:Onore Supremo>"
  },
  RelicConfig_70720_StoryDesc = {
    Text = "Un elegante e misterioso gatto nero a pelo corto, che si dice fosse venerato come divinità in un lontano regno desertico. Il nome di quella divinità è ormai perduto nel tempo.\nAdorato, venerato, dimenticato — forse questo è il destino di tutti gli dèi."
  },
  RelicConfig_70721_BattleDesc = {
    Text = "Dopo aver attivato \"Esaltazione\" 4 volte in un turno, ottieni [Arg1] Arithmetica. Tempo di ricarica di 3 turni."
  },
  RelicConfig_70721_Desc = {
    Text = "Dopo aver attivato \"Esaltazione\" 4 volte in un turno, ottieni [Arg1] Arithmetica. Tempo di ricarica di 3 turni."
  },
  RelicConfig_70721_Name = {
    Text = "<WhiteQuality:Motore Differenziale>"
  },
  RelicConfig_70721_StoryDesc = {
    Text = "\"Ha cambiato la storia.\""
  },
  RelicConfig_70722_BattleDesc = {
    Text = "Usa Keyflare Risveglio e ottieni [Arg1] <PowerIconKeywords:FOR> e [Arg2] Keyflare."
  },
  RelicConfig_70722_Desc = {
    Text = "Usa Keyflare Risveglio e ottieni [Arg1] <PowerIconKeywords:FOR> e [Arg2] Keyflare."
  },
  RelicConfig_70722_Name = {
    Text = "<OrangeQuality:La Nostra Casa+>"
  },
  RelicConfig_70722_StoryDesc = {
    Text = "Erano insieme in passato, e saranno sempre insieme in futuro. Sono una famiglia unita e amorevole."
  },
  RelicConfig_70723_BattleDesc = {
    Text = "Quando giochi 2 carte consecutive con Costo di Arithmetica superiore rispetto alla precedente, ottieni [Arg1] <RetaliateIconKeywords:Contatore>, fino a 3 volte per turno."
  },
  RelicConfig_70723_Desc = {
    Text = "Quando giochi 2 carte consecutive con Costo di Arithmetica superiore rispetto alla precedente, ottieni [Arg1] <RetaliateIconKeywords:Contatore>, fino a 3 volte per turno."
  },
  RelicConfig_70723_Name = {
    Text = "<OrangeQuality:Archivio Arcana+>"
  },
  RelicConfig_70723_StoryDesc = {
    Text = "Il flusso del fato."
  },
  RelicConfig_70724_BattleDesc = {
    Text = "Ottieni [Arg1] <PowerIconKeywords:FOR> a inizio battaglia."
  },
  RelicConfig_70724_Desc = {
    Text = "Ottieni [Arg1] <PowerIconKeywords:FOR> a inizio battaglia."
  },
  RelicConfig_70724_Name = {
    Text = "<OrangeQuality:Spilla di Rubino+>"
  },
  RelicConfig_70724_StoryDesc = {
    Text = "Un accenno di rosso vivo traspare."
  },
  RelicConfig_70725_BattleDesc = {
    Text = "All'inizio della battaglia, applica [Arg1] accumuli di <WeaknessIconKeywords:Debolezza> a tutti i nemici; l'effetto è raddoppiato nelle Battaglie Boss. Il DAN Base di tutti i Risvegliatori è potenziato del +[Arg2]%."
  },
  RelicConfig_70725_Desc = {
    Text = "All'inizio della battaglia, applica [Arg1] accumuli di <WeaknessIconKeywords:Debolezza> a tutti i nemici; l'effetto è raddoppiato nelle Battaglie Boss. Il DAN Base di tutti i Risvegliatori è potenziato del +[Arg2]%."
  },
  RelicConfig_70725_Name = {
    Text = "<OrangeQuality:Bambino Maligno+>"
  },
  RelicConfig_70725_StoryDesc = {
    Text = "Nato dal male puro, sebbene non fosse per sua volontà."
  },
  RelicConfig_70726_BattleDesc = {
    Text = "Ottieni [Arg1] Scudo del Personaggio dall'Annientamento, con un tempo di recupero di 3 turni."
  },
  RelicConfig_70726_Desc = {
    Text = "Ottieni [Arg1] Scudo del Personaggio dall'Annientamento, con un tempo di recupero di 3 turni."
  },
  RelicConfig_70726_Name = {
    Text = "<WhiteQuality:Orologio a Supercorde>"
  },
  RelicConfig_70726_StoryDesc = {
    Text = "\"Oh no, l'orologio da tasca si è fermato.\""
  },
  RelicConfig_70727_BattleDesc = {
    Text = "A fine turno, ripristina [Heal:Arg1] HP."
  },
  RelicConfig_70727_Desc = {
    Text = "A fine turno, ripristina [Heal:Arg1] HP."
  },
  RelicConfig_70727_Name = {
    Text = "<OrangeQuality:Sangue Benedetto+>"
  },
  RelicConfig_70727_StoryDesc = {
    Text = "È dolce e vellutato, con una fragranza di rose."
  },
  RelicConfig_70728_BattleDesc = {
    Text = "Passare alla postura Mare Tranquillo fa perdere a tutti i nemici [Arg1] <ExhaustionIconKeywords:FOR> Temporanea. Tempo di recupero di 3 turni."
  },
  RelicConfig_70728_Desc = {
    Text = "Passare alla postura Mare Tranquillo fa perdere a tutti i nemici [Arg1] <ExhaustionIconKeywords:FOR> Temporanea. Tempo di recupero di 3 turni."
  },
  RelicConfig_70728_Name = {
    Text = "<OrangeQuality:Appendice Senza Nome+>"
  },
  RelicConfig_70728_StoryDesc = {
    Text = "Attenta a non pungerti."
  },
  RelicConfig_70730_BattleDesc = {
    Text = "Ottieni [Arg1] <PowerIconKeywords:FOR> a inizio battaglia."
  },
  RelicConfig_70730_Desc = {
    Text = "Ottieni [Arg1] <PowerIconKeywords:FOR> a inizio battaglia."
  },
  RelicConfig_70730_Name = {
    Text = "<WhiteQuality:Spilla di Rubino>"
  },
  RelicConfig_70730_StoryDesc = {
    Text = "Un accenno di rosso vivo traspare."
  },
  RelicConfig_70731_BattleDesc = {
    Text = "Quando attaccato da un nemico, infliggi loro [Arg1] Danno Fisso. Questo DAN beneficia del bonus <RetaliateIconKeywords:Contrattacco> del [Arg2]%. Ogni nemico può attivare questo effetto fino a 1 volta per turno."
  },
  RelicConfig_70731_Desc = {
    Text = "Quando attaccato da un nemico, infliggi Danno Fisso pari al [Arg3]% della Salute massima del team. Questo DAN beneficia di un bonus <RetaliateIconKeywords:Contrattacco> del [Arg2]%. Ogni nemico può attivare questo effetto fino a 1 volta per turno."
  },
  RelicConfig_70731_Name = {
    Text = "<OrangeQuality:Pugnale Rituale+>"
  },
  RelicConfig_70731_StoryDesc = {
    Text = "Un pugnale dalla lama ricurva, comunemente usato nei riti sacrificali."
  },
  RelicConfig_70732_BattleDesc = {
    Text = "Dopo essere entrati nel Turno Ultra, la prima Carta Comando Non-Derivata giocata si attiva [Arg1] volte aggiuntive."
  },
  RelicConfig_70732_Desc = {
    Text = "Dopo essere entrati nel Turno Ultra, la prima Carta Comando Non-Derivata giocata si attiva [Arg1] volte aggiuntive."
  },
  RelicConfig_70732_Name = {
    Text = "<OrangeQuality:Clessidra Luminosa+>"
  },
  RelicConfig_70732_StoryDesc = {
    Text = "Una quantità misurabile di tempo."
  },
  RelicConfig_70733_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:Fusione Embrionale> Guadagno automatico +[Arg1]%"
  },
  RelicConfig_70733_Desc = {
    Text = "<EmbryoFusionIconKeywords:Fusione Embrionale> Guadagno automatico +[Arg1]%"
  },
  RelicConfig_70733_Name = {
    Text = "<OrangeQuality:Referto della Pestilenza+>"
  },
  RelicConfig_70733_StoryDesc = {
    Text = "Peste — una manifestazione inconscia e inquieta della natura."
  },
  RelicConfig_70734_BattleDesc = {
    Text = "Dopo aver usato Keyflare Risveglio, aumenta il DAN Base inflitto da tutti i Risvegliati del [Arg1]% e ottieni [Arg2] Keyflare."
  },
  RelicConfig_70734_Desc = {
    Text = "Dopo aver usato Keyflare Risveglio, aumenta il DAN Base inflitto da tutti i Risvegliati del [Arg1]% e ottieni [Arg2] Keyflare."
  },
  RelicConfig_70734_Name = {
    Text = "<WhiteQuality:Astrolabio Celeste>"
  },
  RelicConfig_70734_StoryDesc = {
    Text = "Le meraviglie dell'universo."
  },
  RelicConfig_70735_BattleDesc = {
    Text = "Quando giochi 2 carte consecutive con Costo di Arithmetica inferiore rispetto alla precedente, applica [Arg1] <IntoxicationIconKeywords:Veleno> a tutti i nemici, fino a 3 volte per turno."
  },
  RelicConfig_70735_Desc = {
    Text = "Quando giochi 2 carte consecutive con Costo di Arithmetica inferiore rispetto alla precedente, applica [Arg1] <IntoxicationIconKeywords:Veleno> a tutti i nemici, fino a 3 volte per turno."
  },
  RelicConfig_70735_Name = {
    Text = "<OrangeQuality:Reliquia Arcana+>"
  },
  RelicConfig_70735_StoryDesc = {
    Text = "La Fine del Fato"
  },
  RelicConfig_70736_BattleDesc = {
    Text = "Passare alla postura Mare Tranquillo fa perdere a tutti i nemici [Arg1] <ExhaustionIconKeywords:FOR> Temporanea. Tempo di recupero di 3 turni."
  },
  RelicConfig_70736_Desc = {
    Text = "Passare alla postura Mare Tranquillo fa perdere a tutti i nemici [Arg1] <ExhaustionIconKeywords:FOR> Temporanea. Tempo di recupero di 3 turni."
  },
  RelicConfig_70736_Name = {
    Text = "<WhiteQuality:Appendice Senza Nome>"
  },
  RelicConfig_70736_StoryDesc = {
    Text = "Attenta a non pungerti."
  },
  RelicConfig_70737_BattleDesc = {
    Text = "Dopo aver giocato una carta, se il numero di carte In Mano è minore o uguale a [Arg1], pesca [Arg2] carte. Questo effetto può attivarsi fino a [Arg3] volte per turno."
  },
  RelicConfig_70737_Desc = {
    Text = "Dopo aver giocato una carta, se il numero di carte In Mano è minore o uguale a [Arg1], pesca [Arg2] carte. Questo effetto può attivarsi fino a [Arg3] volte per turno."
  },
  RelicConfig_70737_Name = {
    Text = "<WhiteQuality:Guanti Arcani>"
  },
  RelicConfig_70737_StoryDesc = {
    Text = "\"Non temere, è solo un'illusione.\""
  },
  RelicConfig_70738_BattleDesc = {
    Text = "A fine turno, ripristina [Heal:Arg1] HP."
  },
  RelicConfig_70738_Desc = {
    Text = "A fine turno, ripristina [Heal:Arg1] HP."
  },
  RelicConfig_70738_Name = {
    Text = "<WhiteQuality:Sangue Benedetto>"
  },
  RelicConfig_70738_StoryDesc = {
    Text = "È dolce e vellutato, con una fragranza di rose."
  },
  RelicConfig_70739_BattleDesc = {
    Text = "Dopo aver usato Keyflare Risveglio, ottieni [Arg1] Scudo del Personaggio e [Arg2] Keyflare."
  },
  RelicConfig_70739_Desc = {
    Text = "Dopo aver usato Keyflare Risveglio, ottieni [Arg1] Scudo del Personaggio e [Arg2] Keyflare."
  },
  RelicConfig_70739_Name = {
    Text = "<WhiteQuality:Farfalla Conservata>"
  },
  RelicConfig_70739_StoryDesc = {
    Text = "Ancora oggi, qualcuno lo ama profondamente."
  },
  RelicConfig_70740_BattleDesc = {
    Text = "Dopo aver usato Keyflare Risveglio, aumenta il DAN Base inflitto da tutti i Risvegliati del [Arg1]% e ottieni [Arg2] Keyflare."
  },
  RelicConfig_70740_Desc = {
    Text = "Dopo aver usato Keyflare Risveglio, aumenta il DAN Base inflitto da tutti i Risvegliati del [Arg1]% e ottieni [Arg2] Keyflare."
  },
  RelicConfig_70740_Name = {
    Text = "<OrangeQuality:Astrolabio Celeste+>"
  },
  RelicConfig_70740_StoryDesc = {
    Text = "Le meraviglie dell'universo."
  },
  RelicConfig_70741_BattleDesc = {
    Text = "Arithmetica massima +[Arg1]."
  },
  RelicConfig_70741_Desc = {
    Text = "Arithmetica massima +[Arg1]."
  },
  RelicConfig_70741_Name = {
    Text = "<OrangeQuality:Iniezione di Vitalità+>"
  },
  RelicConfig_70741_StoryDesc = {
    Text = "Anche il fremito è una forma di vitalità."
  },
  RelicConfig_70742_BattleDesc = {
    Text = "A inizio battaglia, Limite Tentacoli +[Arg1], si ottengono [Arg2] Tentacoli."
  },
  RelicConfig_70742_Desc = {
    Text = "A inizio battaglia, Limite Tentacoli +[Arg1], si ottengono [Arg2] Tentacoli."
  },
  RelicConfig_70742_Name = {
    Text = "<WhiteQuality:Canto delle maree>"
  },
  RelicConfig_70742_StoryDesc = {
    Text = "Si dice che animali non commestibili come i buccini assorbano circa l'80% dei nutrienti dell'oceano"
  },
  RelicConfig_70743_BattleDesc = {
    Text = "Ogni turno, quando <DevouredIconKeywords:Divorare> si verifica per la prima volta, gli altri Risvegliati ottengono [Arg1] Aliemus."
  },
  RelicConfig_70743_Desc = {
    Text = "Ogni turno, quando <DevouredIconKeywords:Divorare> si verifica per la prima volta, gli altri Risvegliati ottengono [Arg1] Aliemus."
  },
  RelicConfig_70743_Name = {
    Text = "<WhiteQuality:Reverie dorata>"
  },
  RelicConfig_70743_StoryDesc = {
    Text = "Il giorno della trasformazione sarà la tua rovina."
  },
  RelicConfig_70744_BattleDesc = {
    Text = "Dopo aver giocato una Carta Comando Non-Derivata, mischia [Arg1] copie temporanee di quella carta con il Costo di Arithmetica ridotto di 2 nel Mazzo di Pesca. Recupero: 3 turni."
  },
  RelicConfig_70744_Desc = {
    Text = "Dopo aver giocato una Carta Comando Non-Derivata, mischia [Arg1] copie temporanee di quella carta con il Costo di Arithmetica ridotto di 2 nel Mazzo di Pesca. Recupero: 3 turni."
  },
  RelicConfig_70744_Name = {
    Text = "<OrangeQuality:Jukebox muto+>"
  },
  RelicConfig_70744_StoryDesc = {
    Text = "La sua voce svanì nel vento."
  },
  RelicConfig_70745_BattleDesc = {
    Text = "Ottieni [Arg1] <RetaliateIconKeywords:Contatore> a inizio battaglia. Gli effetti sono raddoppiati nelle Battaglia Boss."
  },
  RelicConfig_70745_Desc = {
    Text = "Ottieni [Arg1] <RetaliateIconKeywords:Contatore> a inizio battaglia. Gli effetti sono raddoppiati nelle Battaglia Boss."
  },
  RelicConfig_70745_Name = {
    Text = "<OrangeQuality:Gilet d'Ortica+>"
  },
  RelicConfig_70745_StoryDesc = {
    Text = "Impossibile identificare il liquido che è stato contaminato."
  },
  RelicConfig_70746_BattleDesc = {
    Text = "A inizio turno, se i PV sono inferiori al 25%, si ottiene [Arg1] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_70746_Desc = {
    Text = "A inizio turno, se i PV sono inferiori al 25%, si ottiene [Arg1] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_70746_Name = {
    Text = "<OrangeQuality:Onore Supremo+>"
  },
  RelicConfig_70746_StoryDesc = {
    Text = "Un elegante e misterioso gatto nero a pelo corto, che si dice fosse venerato come divinità in un lontano regno desertico. Il nome di quella divinità è ormai perduto nel tempo.\nAdorato, venerato, dimenticato — forse questo è il destino di tutti gli dèi."
  },
  RelicConfig_70747_BattleDesc = {
    Text = "Dopo aver giocato una carta, se il numero di carte In Mano è minore o uguale a [Arg1], pesca [Arg2] carte. Questo effetto può attivarsi fino a [Arg3] volte per turno."
  },
  RelicConfig_70747_Desc = {
    Text = "Dopo aver giocato una carta, se il numero di carte In Mano è minore o uguale a [Arg1], pesca [Arg2] carte. Questo effetto può attivarsi fino a [Arg3] volte per turno."
  },
  RelicConfig_70747_Name = {
    Text = "<OrangeQuality:Guanti Arcani+>"
  },
  RelicConfig_70747_StoryDesc = {
    Text = "\"Non temere, è solo un'illusione.\""
  },
  RelicConfig_70748_BattleDesc = {
    Text = "Dopo aver usato Keyflare Risveglio, ottieni [Arg1] Scudo del Personaggio e [Arg2] Keyflare."
  },
  RelicConfig_70748_Desc = {
    Text = "Dopo aver usato Keyflare Risveglio, ottieni [Arg1] Scudo del Personaggio e [Arg2] Keyflare."
  },
  RelicConfig_70748_Name = {
    Text = "<OrangeQuality:Farfalla Conservata+>"
  },
  RelicConfig_70748_StoryDesc = {
    Text = "Ancora oggi, qualcuno lo ama profondamente."
  },
  RelicConfig_70749_BattleDesc = {
    Text = "Ogni volta che una carta entra nello Spazio Ultra, se questa carta appartiene a un proprietario diverso rispetto alle altre carte nello Spazio Ultra, colloca [Arg1] carte <DerivativeCardKeywords_4:\"Intuizione\"> In Mano."
  },
  RelicConfig_70749_Desc = {
    Text = "Ogni volta che una carta entra nello Spazio Ultra, se questa carta appartiene a un proprietario diverso rispetto alle altre carte nello Spazio Ultra, colloca [Arg1] carte <DerivativeCardKeywords_4:\"Intuizione\"> In Mano."
  },
  RelicConfig_70749_Name = {
    Text = "<OrangeQuality:Artefatto di Alfonso+>"
  },
  RelicConfig_70749_StoryDesc = {
    Text = "A differenza dell'imprevedibile fato, le stelle seguono leggi proprie."
  },
  RelicConfig_70750_BattleDesc = {
    Text = "Quando giochi 2 carte consecutive con Costo di Arithmetica superiore rispetto alla precedente, ottieni [Arg1] <RetaliateIconKeywords:Contatore>, fino a 3 volte per turno."
  },
  RelicConfig_70750_Desc = {
    Text = "Quando giochi 2 carte consecutive con Costo di Arithmetica superiore rispetto alla precedente, ottieni [Arg1] <RetaliateIconKeywords:Contatore>, fino a 3 volte per turno."
  },
  RelicConfig_70750_Name = {
    Text = "<WhiteQuality:Archivio Arcana>"
  },
  RelicConfig_70750_StoryDesc = {
    Text = "Il flusso del fato."
  },
  RelicConfig_70751_BattleDesc = {
    Text = "Dopo aver usato Keyflare Risveglio, ottieni [Arg1] Arithmetica e [Arg2] Keyflare."
  },
  RelicConfig_70751_Desc = {
    Text = "Dopo aver usato Keyflare Risveglio, ottieni [Arg1] Arithmetica e [Arg2] Keyflare."
  },
  RelicConfig_70751_Name = {
    Text = "<WhiteQuality:Insegna Mythag>"
  },
  RelicConfig_70751_StoryDesc = {
    Text = "Distintivi distribuiti agli Investigatori dall'Università di Mythag. Non solo simboleggiano l'identità di chi li indossa, ma fungono anche da strumenti per la comunicazione a distanza."
  },
  RelicConfig_70752_BattleDesc = {
    Text = "Usa Keyflare Risveglio e ottieni [Arg1] <RetaliateIconKeywords:Contatore> e [Arg2] Keyflare."
  },
  RelicConfig_70752_Desc = {
    Text = "Usa Keyflare Risveglio e ottieni [Arg1] <RetaliateIconKeywords:Contatore> e [Arg2] Keyflare."
  },
  RelicConfig_70752_Name = {
    Text = "<WhiteQuality:Frammento dei Saggi>"
  },
  RelicConfig_70752_StoryDesc = {
    Text = "\"Quanto sono sciocchi gli umani, che credono ciecamente solo perché qualcosa è antico.\""
  },
  RelicConfig_70753_BattleDesc = {
    Text = "Dopo l'inizio della battaglia, applica [Arg1] accumuli di <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici, con effetto raddoppiato nelle Battaglie Boss. Il DAN Base di tutti i Risvegliati è +[Arg2]%."
  },
  RelicConfig_70753_Desc = {
    Text = "Dopo l'inizio della battaglia, applica [Arg1] accumuli di <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici, con effetto raddoppiato nelle Battaglie Boss. Il DAN Base di tutti i Risvegliati è +[Arg2]%."
  },
  RelicConfig_70753_Name = {
    Text = "<OrangeQuality:La Sagra della Primavera+>"
  },
  RelicConfig_70753_StoryDesc = {
    Text = "Tra le risa della notte, la sagoma della canoa scivola senza sforzo attraverso il lago."
  },
  RelicConfig_70754_BattleDesc = {
    Text = "Dopo aver utilizzato direttamente \"Embrione\" per la prima volta ogni turno, il Danno attivo infliggerà il [Arg1]% del Danno inflitto come <BleedingIconKeywords:Salasso> per il resto del turno."
  },
  RelicConfig_70754_Desc = {
    Text = "Dopo aver utilizzato direttamente \"Embrione\" per la prima volta ogni turno, il Danno attivo infliggerà il [Arg1]% del Danno inflitto come <BleedingIconKeywords:Salasso> per il resto del turno."
  },
  RelicConfig_70754_Name = {
    Text = "<WhiteQuality:Ciottolo Insanguinato Dipinto>"
  },
  RelicConfig_70754_StoryDesc = {
    Text = "Uno, Due, Tre, Quattro, Cinque."
  },
  RelicConfig_70755_BattleDesc = {
    Text = "Ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea ogni volta che vengono inflitti danni, fino a 15 volte per turno."
  },
  RelicConfig_70755_Desc = {
    Text = "Ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea ogni volta che vengono inflitti danni, fino a 15 volte per turno."
  },
  RelicConfig_70755_Name = {
    Text = "<OrangeQuality:Agata Filigranata+>"
  },
  RelicConfig_70755_StoryDesc = {
    Text = "Probabilmente sono solo comuni venature d'agata. Forse."
  },
  RelicConfig_70756_BattleDesc = {
    Text = "Dopo aver usato Keyflare Risveglio, ottieni [Arg1] Arithmetica e [Arg2] Keyflare."
  },
  RelicConfig_70756_Desc = {
    Text = "Dopo aver usato Keyflare Risveglio, ottieni [Arg1] Arithmetica e [Arg2] Keyflare."
  },
  RelicConfig_70756_Name = {
    Text = "<OrangeQuality:Insegna Mythag+>"
  },
  RelicConfig_70756_StoryDesc = {
    Text = "Distintivi distribuiti agli Investigatori dall'Università di Mythag. Non solo simboleggiano l'identità di chi li indossa, ma fungono anche da strumenti per la comunicazione a distanza."
  },
  RelicConfig_70757_BattleDesc = {
    Text = "Usa la postura Onde Furiose per attivare immediatamente tutti gli Attacchi del tentacolo sui nemici [Arg1] volte, con un tempo di recupero di 3 turni."
  },
  RelicConfig_70757_Desc = {
    Text = "Usa la postura Onde Furiose per attivare immediatamente tutti gli Attacchi del tentacolo sui nemici [Arg1] volte, con un tempo di recupero di 3 turni."
  },
  RelicConfig_70757_Name = {
    Text = "<WhiteQuality:Delizia Lemuriana>"
  },
  RelicConfig_70757_StoryDesc = {
    Text = "Il Signore del Riposo Eterno ti attende nei tuoi sogni."
  },
  RelicConfig_70758_BattleDesc = {
    Text = "Quando giochi 2 carte consecutive con Costo di Arithmetica inferiore rispetto alla precedente, applica [Arg1] <IntoxicationIconKeywords:Veleno> a tutti i nemici, fino a 3 volte per turno."
  },
  RelicConfig_70758_Desc = {
    Text = "Quando giochi 2 carte consecutive con Costo di Arithmetica inferiore rispetto alla precedente, applica [Arg1] <IntoxicationIconKeywords:Veleno> a tutti i nemici, fino a 3 volte per turno."
  },
  RelicConfig_70758_Name = {
    Text = "<WhiteQuality:Reliquia Arcana>"
  },
  RelicConfig_70758_StoryDesc = {
    Text = "La Fine del Fato"
  },
  RelicConfig_70759_BattleDesc = {
    Text = "All'inizio della battaglia, applica [Arg1] accumuli di <WeaknessIconKeywords:Debolezza> a tutti i nemici; l'effetto è raddoppiato nelle Battaglie Boss. Il DAN Base di tutti i Risvegliatori è potenziato del +[Arg2]%."
  },
  RelicConfig_70759_Desc = {
    Text = "All'inizio della battaglia, applica [Arg1] accumuli di <WeaknessIconKeywords:Debolezza> a tutti i nemici; l'effetto è raddoppiato nelle Battaglie Boss. Il DAN Base di tutti i Risvegliatori è potenziato del +[Arg2]%."
  },
  RelicConfig_70759_Name = {
    Text = "<WhiteQuality:Bambino Maligno>"
  },
  RelicConfig_70759_StoryDesc = {
    Text = "Nato dal male puro, sebbene non fosse per sua volontà."
  },
  RelicConfig_70760_BattleDesc = {
    Text = "All'inizio della battaglia, infliggi [Arg1] <IntoxicationIconKeywords:Veleno> a tutti i nemici; l'effetto è raddoppiato nelle Battaglie Boss."
  },
  RelicConfig_70760_Desc = {
    Text = "All'inizio della battaglia, infliggi [Arg1] <IntoxicationIconKeywords:Veleno> a tutti i nemici; l'effetto è raddoppiato nelle Battaglie Boss."
  },
  RelicConfig_70760_Name = {
    Text = "<WhiteQuality:Neurotossina>"
  },
  RelicConfig_70760_StoryDesc = {
    Text = "Estrarre, Raffinare."
  },
  RelicConfig_70761_BattleDesc = {
    Text = "Dopo l'inizio della battaglia, applica [Arg1] accumuli di <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici, con effetto raddoppiato nelle Battaglie Boss. Il DAN Base di tutti i Risvegliati è +[Arg2]%."
  },
  RelicConfig_70761_Desc = {
    Text = "Dopo l'inizio della battaglia, applica [Arg1] accumuli di <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici, con effetto raddoppiato nelle Battaglie Boss. Il DAN Base di tutti i Risvegliati è +[Arg2]%."
  },
  RelicConfig_70761_Name = {
    Text = "<WhiteQuality:La Sagra della Primavera>"
  },
  RelicConfig_70761_StoryDesc = {
    Text = "Tra le risa della notte, la sagoma della canoa scivola senza sforzo attraverso il lago."
  },
  RelicConfig_70762_BattleDesc = {
    Text = "Dopo aver attivato \"Esaltazione\" 4 volte in un turno, ottieni [Arg1] Arithmetica. Tempo di ricarica di 3 turni."
  },
  RelicConfig_70762_Desc = {
    Text = "Dopo aver attivato \"Esaltazione\" 4 volte in un turno, ottieni [Arg1] Arithmetica. Tempo di ricarica di 3 turni."
  },
  RelicConfig_70762_Name = {
    Text = "<OrangeQuality:Motore Differenziale+>"
  },
  RelicConfig_70762_StoryDesc = {
    Text = "\"Ha cambiato la storia.\""
  },
  RelicConfig_70763_BattleDesc = {
    Text = "Dopo aver rilasciato \"Esaltazione\", ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_70763_Desc = {
    Text = "Dopo aver rilasciato \"Esaltazione\", ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea."
  },
  RelicConfig_70763_Name = {
    Text = "<WhiteQuality:Serratura di Ferro>"
  },
  RelicConfig_70763_StoryDesc = {
    Text = "Un lucchetto spesso e robusto, difficile da aprire senza una chiave.\nNaturalmente, questo non è nulla per un maestro ladro"
  },
  RelicConfig_70764_BattleDesc = {
    Text = "Quando attaccato da un nemico, infliggi loro [Arg1] Danno Fisso. Questo DAN beneficia del bonus <RetaliateIconKeywords:Contrattacco> del [Arg2]%. Ogni nemico può attivare questo effetto fino a 1 volta per turno."
  },
  RelicConfig_70764_Desc = {
    Text = "Quando attaccato da un nemico, infliggi Danno Fisso pari al [Arg3]% della Salute massima del team. Questo DAN beneficia di un bonus <RetaliateIconKeywords:Contrattacco> del [Arg2]%. Ogni nemico può attivare questo effetto fino a 1 volta per turno."
  },
  RelicConfig_70764_Name = {
    Text = "<WhiteQuality:Pugnale Rituale>"
  },
  RelicConfig_70764_StoryDesc = {
    Text = "Un pugnale dalla lama ricurva, comunemente usato nei riti sacrificali."
  },
  RelicConfig_70765_BattleDesc = {
    Text = "Ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea ogni volta che vengono inflitti danni, fino a 15 volte per turno."
  },
  RelicConfig_70765_Desc = {
    Text = "Ottieni [Arg1] <PowerIconKeywords:FOR> Temporanea ogni volta che vengono inflitti danni, fino a 15 volte per turno."
  },
  RelicConfig_70765_Name = {
    Text = "<WhiteQuality:Agata Filigranata>"
  },
  RelicConfig_70765_StoryDesc = {
    Text = "Probabilmente sono solo comuni venature d'agata. Forse."
  },
  RelicConfig_70766_BattleDesc = {
    Text = "A inizio turno, se i PV sono inferiori al 25%, ottieni [Arg1] Scudo."
  },
  RelicConfig_70766_Desc = {
    Text = "A inizio turno, se i PV sono inferiori al 25%, ottieni [Arg1] Scudo."
  },
  RelicConfig_70766_Name = {
    Text = "<WhiteQuality:Mano Protettrice>"
  },
  RelicConfig_70766_StoryDesc = {
    Text = "La mano che prega, il pugno che resta irremovibile."
  },
  RelicConfig_70767_BattleDesc = {
    Text = "L'Annientamento concede [Arg1] Aliemus al Risvegliato con il minor Aliemus, con un tempo di recupero di 3 turni."
  },
  RelicConfig_70767_Desc = {
    Text = "L'Annientamento concede [Arg1] Aliemus al Risvegliato con il minor Aliemus, con un tempo di recupero di 3 turni."
  },
  RelicConfig_70767_Name = {
    Text = "<WhiteQuality:Scarabeo del Tempo>"
  },
  RelicConfig_70767_StoryDesc = {
    Text = "Un orologio da tasca rinvenuto sia in un negozio di orologi che in un museo entomologico.\nÈ stato inserito nella collezione dell'università sin dal Diluvio."
  },
  RelicConfig_70768_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni [Arg1] <ProficientInRealmsIconKeywords:Padronanza del Reame>. Il <RetaliateIconKeywords:Contatore> di tutti i Risvegliatori e delle Reliquie è potenziato del +[Arg2]%."
  },
  RelicConfig_70768_Desc = {
    Text = "All'inizio della battaglia, ottieni [Arg1] <ProficientInRealmsIconKeywords:Padronanza del Reame>. Il <RetaliateIconKeywords:Contatore> di tutti i Risvegliatori e delle Reliquie è potenziato del +[Arg2]%."
  },
  RelicConfig_70768_Name = {
    Text = "<OrangeQuality:Verità Senza Riserve+>"
  },
  RelicConfig_70768_StoryDesc = {
    Text = "Trasmette innumerevoli Segreti, che siano pronunciati attivamente o passivamente."
  },
  RelicConfig_70769_BattleDesc = {
    Text = "Dopo aver utilizzato direttamente \"Embrione\" per la prima volta ogni turno, il Danno attivo infliggerà il [Arg1]% del Danno inflitto come <BleedingIconKeywords:Salasso> per il resto del turno."
  },
  RelicConfig_70769_Desc = {
    Text = "Dopo aver utilizzato direttamente \"Embrione\" per la prima volta ogni turno, il Danno attivo infliggerà il [Arg1]% del Danno inflitto come <BleedingIconKeywords:Salasso> per il resto del turno."
  },
  RelicConfig_70769_Name = {
    Text = "<OrangeQuality:Ciottolo Insanguinato Dipinto+>"
  },
  RelicConfig_70769_StoryDesc = {
    Text = "Uno, Due, Tre, Quattro, Cinque."
  },
  RelicConfig_70770_BattleDesc = {
    Text = "A inizio turno, pesca [Arg1] carte."
  },
  RelicConfig_70770_Desc = {
    Text = "A inizio turno, pesca [Arg1] carte."
  },
  RelicConfig_70770_Name = {
    Text = "<WhiteQuality:Bussola del Nord Vero>"
  },
  RelicConfig_70770_StoryDesc = {
    Text = "L'indicazione non è una direzione, bensì un campo magnetico."
  },
  RelicConfig_70771_BattleDesc = {
    Text = "\"Colpo\" infligge inoltre altre 2 istanze di danni pari al [Arg1]% dell'ATT del Risvegliato, attivabile fino a 3 volte per turno."
  },
  RelicConfig_70771_Desc = {
    Text = "\"Colpo\" infligge inoltre altre 2 istanze di danni pari al [Arg1]% dell'ATT del Risvegliato, attivabile fino a 3 volte per turno."
  },
  RelicConfig_70771_Name = {
    Text = "<OrangeQuality:Bisturi Arrugginito+>"
  },
  RelicConfig_70771_StoryDesc = {
    Text = "Non adatto a tagliare tessuti vivi."
  },
  RelicConfig_70772_BattleDesc = {
    Text = "Dopo aver usato Keyflare Risveglio, pesca [Arg1] carte e ottieni [Arg2] Keyflare."
  },
  RelicConfig_70772_Desc = {
    Text = "Dopo aver usato Keyflare Risveglio, pesca [Arg1] carte e ottieni [Arg2] Keyflare."
  },
  RelicConfig_70772_Name = {
    Text = "<WhiteQuality:Portafoglio Nuovo di Zecca>"
  },
  RelicConfig_70772_StoryDesc = {
    Text = "Un portafoglio in pelle inciso con l'emblema dell'Università di Mythag.\nOra è vuoto, non contiene più nulla."
  },
  RelicConfig_70774_BattleDesc = {
    Text = "Aumenta il DAN dei primi cinque attacchi ogni turno del [Arg1]%."
  },
  RelicConfig_70774_Desc = {
    Text = "Aumenta il DAN dei primi cinque attacchi ogni turno del [Arg1]%."
  },
  RelicConfig_70774_Name = {
    Text = "<WhiteQuality:Correttore Visivo>"
  },
  RelicConfig_70774_StoryDesc = {
    Text = "Qualcuno un tempo scoprì la verità attraverso di esso."
  },
  RelicConfig_70776_BattleDesc = {
    Text = "Ottieni [Arg1] <RetaliateIconKeywords:Contatore> a inizio battaglia. Gli effetti sono raddoppiati nelle Battaglia Boss."
  },
  RelicConfig_70776_Desc = {
    Text = "Ottieni [Arg1] <RetaliateIconKeywords:Contatore> a inizio battaglia. Gli effetti sono raddoppiati nelle Battaglia Boss."
  },
  RelicConfig_70776_Name = {
    Text = "<WhiteQuality:Veste d'Ortica>"
  },
  RelicConfig_70776_StoryDesc = {
    Text = "Impossibile identificare il liquido che è stato contaminato."
  },
  RelicConfig_70777_BattleDesc = {
    Text = "Tutti i Risvegliatori ottengono [Arg1] Aliemus quando le Carte di comando di 4 Risvegliatori diversi vengono giocate consecutivamente nello stesso turno. Recupero: 3 turni."
  },
  RelicConfig_70777_Desc = {
    Text = "Tutti i Risvegliatori ottengono [Arg1] Aliemus quando le Carte di comando di 4 Risvegliatori diversi vengono giocate consecutivamente nello stesso turno. Recupero: 3 turni."
  },
  RelicConfig_70777_Name = {
    Text = "<WhiteQuality:Velo della Divinità Senza Nome>"
  },
  RelicConfig_70777_StoryDesc = {
    Text = "Non guardare direttamente gli dèi."
  },
  RelicConfig_70778_BattleDesc = {
    Text = "All'inizio della battaglia, infliggi [Arg1] <IntoxicationIconKeywords:Veleno> a tutti i nemici; l'effetto è raddoppiato nelle Battaglie Boss."
  },
  RelicConfig_70778_Desc = {
    Text = "All'inizio della battaglia, infliggi [Arg1] <IntoxicationIconKeywords:Veleno> a tutti i nemici; l'effetto è raddoppiato nelle Battaglie Boss."
  },
  RelicConfig_70778_Name = {
    Text = "<OrangeQuality:Neurotossina+>"
  },
  RelicConfig_70778_StoryDesc = {
    Text = "Estrarre, Raffinare."
  },
  RelicConfig_70779_BattleDesc = {
    Text = "Usa Keyflare Risveglio per applicare [Arg1] <IntoxicationIconKeywords:Veleno> a tutti i nemici e ottieni [Arg2] Keyflare."
  },
  RelicConfig_70779_Desc = {
    Text = "Usa Keyflare Risveglio per applicare [Arg1] <IntoxicationIconKeywords:Veleno> a tutti i nemici e ottieni [Arg2] Keyflare."
  },
  RelicConfig_70779_Name = {
    Text = "<WhiteQuality:Unguento Sospetto>"
  },
  RelicConfig_70779_StoryDesc = {
    Text = "Una sorta di unguento artigianale per ferite esterne. Non utilizzare senza la supervisione di un dottore."
  },
  RelicConfig_70780_BattleDesc = {
    Text = "\"Colpo\" applica <IntoxicationIconKeywords:Veleno> pari al [Arg1]% del DAN inflitto, con un massimo di [Arg2] per turno."
  },
  RelicConfig_70780_Desc = {
    Text = "\"Colpo\" applica <IntoxicationIconKeywords:Veleno> pari al [Arg1]% del DAN inflitto, con un massimo di [Arg2] per turno."
  },
  RelicConfig_70780_Name = {
    Text = "<WhiteQuality:Lingua Aliena>"
  },
  RelicConfig_70780_StoryDesc = {
    Text = "Non è un demone, eppure trasmette davvero sussurri provenienti da oltre il regno dei mortali."
  },
  RelicConfig_70781_BattleDesc = {
    Text = "A inizio turno, se i PV sono inferiori al 25%, ottieni [Arg1] Scudo."
  },
  RelicConfig_70781_Desc = {
    Text = "A inizio turno, se i PV sono inferiori al 25%, ottieni [Arg1] Scudo."
  },
  RelicConfig_70781_Name = {
    Text = "<OrangeQuality:Mano Protettrice+>"
  },
  RelicConfig_70781_StoryDesc = {
    Text = "La mano che prega, il pugno che resta irremovibile."
  },
  RelicConfig_70782_BattleDesc = {
    Text = "Alla perdita di PV, accumula Fornace Cremisi pari al [Arg1]% dei PV persi."
  },
  RelicConfig_70782_Desc = {
    Text = "Alla perdita di PV, accumula Fornace Cremisi pari al [Arg1]% dei PV persi."
  },
  RelicConfig_70782_Name = {
    Text = "<OrangeQuality:Sega Arrugginita+>"
  },
  RelicConfig_70782_StoryDesc = {
    Text = "Il dottore anatomista trascorre la sua vita senza mai vedere una bella donna, solo sacchi d'ossa, nervi infiammati, muscoli e tessuti corrosi dalle malattie."
  },
  RelicConfig_70783_BattleDesc = {
    Text = "Aumenta il DAN dei primi cinque attacchi ogni turno del [Arg1]%."
  },
  RelicConfig_70783_Desc = {
    Text = "Aumenta il DAN dei primi cinque attacchi ogni turno del [Arg1]%."
  },
  RelicConfig_70783_Name = {
    Text = "<OrangeQuality:Correttore Visivo+>"
  },
  RelicConfig_70783_StoryDesc = {
    Text = "Qualcuno un tempo scoprì la verità attraverso di esso."
  },
  RelicConfig_70784_BattleDesc = {
    Text = "Ogni volta che una carta entra nello Spazio Ultra, se questa carta appartiene a un proprietario diverso rispetto alle altre carte nello Spazio Ultra, colloca [Arg1] carte <DerivativeCardKeywords_4:\"Intuizione\"> In Mano."
  },
  RelicConfig_70784_Desc = {
    Text = "Ogni volta che una carta entra nello Spazio Ultra, se questa carta appartiene a un proprietario diverso rispetto alle altre carte nello Spazio Ultra, colloca [Arg1] carte <DerivativeCardKeywords_4:\"Intuizione\"> In Mano."
  },
  RelicConfig_70784_Name = {
    Text = "<WhiteQuality:Artefatto di Alfonso>"
  },
  RelicConfig_70784_StoryDesc = {
    Text = "A differenza dell'imprevedibile fato, le stelle seguono leggi proprie."
  },
  RelicConfig_70785_BattleDesc = {
    Text = "Tutti i Risvegliatori ottengono [Arg1] Aliemus quando le Carte di comando di 4 Risvegliatori diversi vengono giocate consecutivamente nello stesso turno. Recupero: 3 turni."
  },
  RelicConfig_70785_Desc = {
    Text = "Tutti i Risvegliatori ottengono [Arg1] Aliemus quando le Carte di comando di 4 Risvegliatori diversi vengono giocate consecutivamente nello stesso turno. Recupero: 3 turni."
  },
  RelicConfig_70785_Name = {
    Text = "<OrangeQuality:Velo della Divinità Senza Nome+>"
  },
  RelicConfig_70785_StoryDesc = {
    Text = "Non guardare direttamente gli dèi."
  },
  RelicConfig_70786_BattleDesc = {
    Text = "A fine turno, se ci si trova nella postura Maree crescenti, si ottiene [Arg1] <TentacleInjurieIconKeywords:Danno Tentacolo>, tempo di recupero di 3 turni."
  },
  RelicConfig_70786_Desc = {
    Text = "A fine turno, se ci si trova nella postura Maree crescenti, si ottiene [Arg1] <TentacleInjurieIconKeywords:Danno Tentacolo>, tempo di recupero di 3 turni."
  },
  RelicConfig_70786_Name = {
    Text = "<WhiteQuality:Verme Spargano>"
  },
  RelicConfig_70786_StoryDesc = {
    Text = "Finché il nostro cervello resta un mistero, non è poi così grave se è pieno di tentacoli."
  },
  RelicConfig_70787_BattleDesc = {
    Text = "Il DAN Base di tutti i Risvegliatori aumenta del [Arg1]%."
  },
  RelicConfig_70787_Desc = {
    Text = "Il DAN Base di tutti i Risvegliatori aumenta del [Arg1]%."
  },
  RelicConfig_70787_Name = {
    Text = "<OrangeQuality:Pipa Piangente+>"
  },
  RelicConfig_70787_StoryDesc = {
    Text = "È il frutto dell'Odio o il risultato della vendetta?"
  },
  RelicConfig_70788_BattleDesc = {
    Text = "Dopo aver usato Keyflare Risveglio, tutti i Risvegliati ottengono [Arg1] Aliemus e [Arg2] Keyflare."
  },
  RelicConfig_70788_Desc = {
    Text = "Dopo aver usato Keyflare Risveglio, tutti i Risvegliati ottengono [Arg1] Aliemus e [Arg2] Keyflare."
  },
  RelicConfig_70788_Name = {
    Text = "<WhiteQuality:Gemelli da Polso all'Alloro>"
  },
  RelicConfig_70788_StoryDesc = {
    Text = [[
Gemelli da polso in argento incisi con motivi di foglie di osmanto.
Finemente lavorati e scintillanti, un tempo incarnavano l'amicizia di due fanciulli.]]
  },
  RelicConfig_70789_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni [Arg1] <ProficientInRealmsIconKeywords:Padronanza del Reame>. Tutti gli effetti di <IntoxicationIconKeywords:Veleno> dei Risvegliatori e delle Reliquie sono potenziati del +[Arg2]%."
  },
  RelicConfig_70789_Desc = {
    Text = "All'inizio della battaglia, ottieni [Arg1] <ProficientInRealmsIconKeywords:Padronanza del Reame>. Tutti gli effetti di <IntoxicationIconKeywords:Veleno> dei Risvegliatori e delle Reliquie sono potenziati del +[Arg2]%."
  },
  RelicConfig_70789_Name = {
    Text = "<WhiteQuality:Telaio Dimenticato>"
  },
  RelicConfig_70789_StoryDesc = {
    Text = "Una madre amorevole risana le ferite del cuore."
  },
  RelicConfig_70790_BattleDesc = {
    Text = "L'Annientamento concede [Arg1] Aliemus al Risvegliato con il minor Aliemus, con un tempo di recupero di 3 turni."
  },
  RelicConfig_70790_Desc = {
    Text = "L'Annientamento concede [Arg1] Aliemus al Risvegliato con il minor Aliemus, con un tempo di recupero di 3 turni."
  },
  RelicConfig_70790_Name = {
    Text = "<OrangeQuality:Scarabeo del Tempo+>"
  },
  RelicConfig_70790_StoryDesc = {
    Text = "Un orologio da tasca rinvenuto sia in un negozio di orologi che in un museo entomologico.\nÈ stato inserito nella collezione dell'università sin dal Diluvio."
  },
  RelicConfig_70791_BattleDesc = {
    Text = "A inizio battaglia, Limite Tentacoli +[Arg1], si ottengono [Arg2] Tentacoli."
  },
  RelicConfig_70791_Desc = {
    Text = "A inizio battaglia, Limite Tentacoli +[Arg1], si ottengono [Arg2] Tentacoli."
  },
  RelicConfig_70791_Name = {
    Text = "<OrangeQuality:Canto delle maree+>"
  },
  RelicConfig_70791_StoryDesc = {
    Text = "Si dice che animali non commestibili come i buccini assorbano circa l'80% dei nutrienti dell'oceano"
  },
  RelicConfig_70792_BattleDesc = {
    Text = "A fine turno, se ci si trova nella postura Maree crescenti, si ottiene [Arg1] <TentacleInjurieIconKeywords:Danno Tentacolo>, tempo di recupero di 3 turni."
  },
  RelicConfig_70792_Desc = {
    Text = "A fine turno, se ci si trova nella postura Maree crescenti, si ottiene [Arg1] <TentacleInjurieIconKeywords:Danno Tentacolo>, tempo di recupero di 3 turni."
  },
  RelicConfig_70792_Name = {
    Text = "<OrangeQuality:Verme Spargano+>"
  },
  RelicConfig_70792_StoryDesc = {
    Text = "Finché il nostro cervello resta un mistero, non è poi così grave se è pieno di tentacoli."
  },
  RelicConfig_70793_BattleDesc = {
    Text = "Ogni turno, quando <DevouredIconKeywords:Divorare> si verifica per la prima volta, gli altri Risvegliati ottengono [Arg1] Aliemus."
  },
  RelicConfig_70793_Desc = {
    Text = "Ogni turno, quando <DevouredIconKeywords:Divorare> si verifica per la prima volta, gli altri Risvegliati ottengono [Arg1] Aliemus."
  },
  RelicConfig_70793_Name = {
    Text = "<OrangeQuality:Reverie dorata+>"
  },
  RelicConfig_70793_StoryDesc = {
    Text = "Il giorno della trasformazione sarà la tua rovina."
  },
  RelicConfig_70794_BattleDesc = {
    Text = "Ottieni [Arg1] Scudo del Personaggio dall'Annientamento, con un tempo di recupero di 3 turni."
  },
  RelicConfig_70794_Desc = {
    Text = "Ottieni [Arg1] Scudo del Personaggio dall'Annientamento, con un tempo di recupero di 3 turni."
  },
  RelicConfig_70794_Name = {
    Text = "<OrangeQuality:Orologio a Supercorde+>"
  },
  RelicConfig_70794_StoryDesc = {
    Text = "\"Oh no, l'orologio da tasca si è fermato.\""
  },
  RelicConfig_70795_BattleDesc = {
    Text = "Dopo aver giocato una Carta Comando Non-Derivata, mischia [Arg1] copie temporanee di quella carta con il Costo di Arithmetica ridotto di 2 nel Mazzo di Pesca. Recupero: 3 turni."
  },
  RelicConfig_70795_Desc = {
    Text = "Dopo aver giocato una Carta Comando Non-Derivata, mischia [Arg1] copie temporanee di quella carta con il Costo di Arithmetica ridotto di 2 nel Mazzo di Pesca. Recupero: 3 turni."
  },
  RelicConfig_70795_Name = {
    Text = "<WhiteQuality:Jukebox muto>"
  },
  RelicConfig_70795_StoryDesc = {
    Text = "La sua voce svanì nel vento."
  },
  RelicConfig_70796_BattleDesc = {
    Text = "Dopo aver rilasciato \"Esaltazione,\" tutti i nemici subiscono [Arg1] <FixedDamage:DAN Puro> e attivano il [Arg2]% di <IntoxicationIconKeywords:Veleno>."
  },
  RelicConfig_70796_Desc = {
    Text = "Dopo aver rilasciato \"Esaltazione,\" tutti i nemici subiscono 1 istanza di <FixedDamage:DAN Puro> pari al [Arg2]% della Salute massima del team e attivano il [Arg2]% di <IntoxicationIconKeywords:Veleno>."
  },
  RelicConfig_70796_Name = {
    Text = "<OrangeQuality:Mandibola al Radio+>"
  },
  RelicConfig_70796_StoryDesc = {
    Text = "Esposto nella sala privata di un collezionista.\nIl collezionista rimase ammaliato dalla sua splendida fluorescenza, ammirandolo giorno e notte, finché non avvizzì e divenne uno dei suoi simili."
  },
  RelicConfig_70797_BattleDesc = {
    Text = "Arithmetica massima +[Arg1]."
  },
  RelicConfig_70797_Desc = {
    Text = "Arithmetica massima +[Arg1]."
  },
  RelicConfig_70797_Name = {
    Text = "<WhiteQuality:Iniezione di Vitalità>"
  },
  RelicConfig_70797_StoryDesc = {
    Text = "Anche il fremito è una forma di vitalità."
  },
  RelicConfig_70798_BattleDesc = {
    Text = "Usa la postura Onde Furiose per attivare immediatamente tutti gli Attacchi del tentacolo sui nemici [Arg1] volte, con un tempo di recupero di 3 turni."
  },
  RelicConfig_70798_Desc = {
    Text = "Usa la postura Onde Furiose per attivare immediatamente tutti gli Attacchi del tentacolo sui nemici [Arg1] volte, con un tempo di recupero di 3 turni."
  },
  RelicConfig_70798_Name = {
    Text = "<OrangeQuality:Delizia Lemuriana+>"
  },
  RelicConfig_70798_StoryDesc = {
    Text = "Il Signore del Riposo Eterno ti attende nei tuoi sogni."
  },
  RelicConfig_70799_BattleDesc = {
    Text = "Quando \"Difesa\" viene giocata, ottieni [Arg1] <RetaliateIconKeywords:Contatore> Temporaneo, si attiva fino a 3 volte per turno."
  },
  RelicConfig_70799_Desc = {
    Text = "Quando \"Difesa\" viene giocata, ottieni [Arg1] <RetaliateIconKeywords:Contatore> Temporaneo, si attiva fino a 3 volte per turno."
  },
  RelicConfig_70799_Name = {
    Text = "<OrangeQuality:Orologio del Defunto+>"
  },
  RelicConfig_70799_StoryDesc = {
    Text = "Portando con sé memorie e pianto, in cammino verso l'ignoto."
  },
  RelicConfig_70800_BattleDesc = {
    Text = "Quando \"Difesa\" viene giocata, ottieni [Arg1] <RetaliateIconKeywords:Contatore> Temporaneo, si attiva fino a 3 volte per turno."
  },
  RelicConfig_70800_Desc = {
    Text = "Quando \"Difesa\" viene giocata, ottieni [Arg1] <RetaliateIconKeywords:Contatore> Temporaneo, si attiva fino a 3 volte per turno."
  },
  RelicConfig_70800_Name = {
    Text = "<WhiteQuality:Orologio del Defunto>"
  },
  RelicConfig_70800_StoryDesc = {
    Text = "Portando con sé memorie e pianto, in cammino verso l'ignoto."
  },
  RelicConfig_70986_BattleDesc = {
    Text = "All'inizio della battaglia, aumenta il Limite di Arithmetica di 1 e Ridesta tutti i Risvegliatori. All'inizio dei turni dispari, scegli 1 Reliquia tra 2 da ottenere, per 5 turni dispari."
  },
  RelicConfig_70986_Desc = {
    Text = "All'inizio della battaglia, aumenta il Limite di Arithmetica di 1 e Ridesta tutti i Risvegliatori. All'inizio dei turni dispari, scegli 1 Reliquia tra 2 da ottenere, per 5 turni dispari."
  },
  RelicConfig_70986_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Desiderio η\">"
  },
  RelicConfig_70987_BattleDesc = {
    Text = "All'inizio della battaglia, aumenta il Limite di Arithmetica di 1 e Ridesta tutti i Risvegliatori. All'inizio dei turni dispari, scegli 1 Reliquia tra 2 da ottenere, per 5 turni dispari."
  },
  RelicConfig_70987_Desc = {
    Text = "All'inizio della battaglia, aumenta il Limite di Arithmetica di 1 e Ridesta tutti i Risvegliatori. All'inizio dei turni dispari, scegli 1 Reliquia tra 2 da ottenere, per 5 turni dispari."
  },
  RelicConfig_70987_Name = {
    Text = "<OrangeQuality:Pendolo Crono \"Desiderio ζ\">"
  },
  RelicConfig_71195_BattleDesc = {
    Text = "A inizio turno, Ramona: Logorata dal Tempo ottiene [Arg1] Aliemus. La prima volta che \"Ciclo\" si attiva ogni turno, ottieni [Arg2] Keyflare e [Arg3] accumuli di \"Negentropia\"."
  },
  RelicConfig_71195_Desc = {
    Text = "A inizio turno, Ramona: Logorata dal Tempo ottiene [Arg1] Aliemus. La prima volta che \"Ciclo\" si attiva ogni turno, ottieni [Arg2] Keyflare e [Arg3] accumuli di \"Negentropia\"."
  },
  RelicConfig_71195_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Ramona: Logorata dal Tempo>"
  },
  RelicConfig_71196_BattleDesc = {
    Text = "A inizio turno, Lotan ottiene [Arg1] Aliemus. Dopo la prima giocata della \"Difesa\" di Lotan ogni turno, aggiungi In Mano [Arg2] copie aggiuntive di \"Lama della Sfida\" con Esaurimento e Fugace."
  },
  RelicConfig_71196_Desc = {
    Text = "A inizio turno, Lotan ottiene [Arg1] Aliemus. Dopo la prima giocata della \"Difesa\" di Lotan ogni turno, aggiungi In Mano [Arg2] copie aggiuntive di \"Lama della Sfida\" con Esaurimento e Fugace."
  },
  RelicConfig_71196_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Lotan>"
  },
  RelicConfig_71197_BattleDesc = {
    Text = "A inizio turno, Ramona ottiene [Arg1] Aliemus. Ogni [Arg2]ª Carta di comando giocata da Ramona, quella Carta di comando si attiva 1 volta aggiuntiva e ottiene [Arg3] Keyflare."
  },
  RelicConfig_71197_Desc = {
    Text = "A inizio turno, Ramona ottiene [Arg1] Aliemus. Ogni [Arg2]ª Carta di comando giocata da Ramona, quella Carta di comando si attiva 1 volta aggiuntiva e ottiene [Arg3] Keyflare."
  },
  RelicConfig_71197_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Ramona>"
  },
  RelicConfig_71230_BattleDesc = {
    Text = "All'inizio del turno Leigh ottiene [Arg1] Aliemus. Ogni volta che perde Vita, ottiene [Arg2] punti Potere, accumulabile al massimo [Arg3] volte per battaglia. Dopo [Arg3] accumuli, il costo di Arithmetica base di \"Dolore e Piacere\" si riduce di 2 e il numero di colpi aumenta di 1."
  },
  RelicConfig_71230_Desc = {
    Text = "All'inizio del turno Leigh ottiene [Arg1] Aliemus. Ogni volta che perde Vita, ottiene [Arg2] punti Potere, accumulabile al massimo [Arg3] volte per battaglia. Dopo [Arg3] accumuli, il costo di Arithmetica base di \"Dolore e Piacere\" si riduce di 2 e il numero di colpi aumenta di 1."
  },
  RelicConfig_71230_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Leigh>"
  },
  RelicConfig_71231_BattleDesc = {
    Text = "All'inizio del turno, Aurita ottiene [Arg1] Aliemus. Il conteggio di DAN di \"Divisione Ghiandolare\" aumenta di [Arg2] e, dopo aver giocato una carta \"Difesa\" di Aurita, 1 \"Divisione Ghiandolare\" viene aggiunta alla mano."
  },
  RelicConfig_71231_Desc = {
    Text = "All'inizio del turno, Aurita ottiene [Arg1] Aliemus. Il conteggio di DAN di \"Divisione Ghiandolare\" aumenta di [Arg2] e, dopo aver giocato una carta \"Difesa\" di Aurita, 1 \"Divisione Ghiandolare\" viene aggiunta alla mano."
  },
  RelicConfig_71231_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Aurita>"
  },
  RelicConfig_71232_BattleDesc = {
    Text = "A inizio turno, Tinct ottiene [Arg1] Aliemus. Dopo aver attivato un Salto con la Carta di comando di Tinct, la restituisce in mano e ne riduce il Costo di Arithmetica di 1 prima di giocarla. Questo effetto può verificarsi un massimo di [Arg2] volte per turno."
  },
  RelicConfig_71232_Desc = {
    Text = "A inizio turno, Tinct ottiene [Arg1] Aliemus. Dopo aver attivato un Salto con la Carta di comando di Tinct, la restituisce in mano e ne riduce il Costo di Arithmetica di 1 prima di giocarla. Questo effetto può verificarsi un massimo di [Arg2] volte per turno."
  },
  RelicConfig_71232_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Tinct>"
  },
  RelicConfig_71233_BattleDesc = {
    Text = "A inizio turno, Nautila ottiene [Arg1] Aliemus. Dopo aver usato l'\"Esaltazione\" di Nautila, ottieni Contatore e Scudo Ritardato pari al [Arg2]% dello Scudo attuale, attivabile al massimo una volta per turno."
  },
  RelicConfig_71233_Desc = {
    Text = "All'inizio del turno, Nautila ottiene [Arg1] Aliemus. Dopo aver usato l'\"Esaltazione\" di Nautila, ottieni Contrattacco e Scudo Ritardato pari al [Arg2]% dello Scudo attuale, attivandosi al massimo una volta per turno."
  },
  RelicConfig_71233_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Nautila>"
  },
  RelicConfig_71234_BattleDesc = {
    Text = "A inizio turno, Doll: Inferno ottiene [Arg1] Aliemus. Dopo che Doll: Inferno attiva Esaltazione, per ogni [Arg2] Aliemus consumati, gli altri Risvegliati ottengono 1 Aliemus."
  },
  RelicConfig_71234_Desc = {
    Text = "All'inizio del turno, Doll: Inferno ottiene [Arg1] Aliemus. Dopo che Doll: Inferno scatena l'Esaltazione, per ogni [Arg2] Aliemus consumati, gli altri Risvegliatori ottengono 1 punto di Aliemus."
  },
  RelicConfig_71234_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Doll: Inferno>"
  },
  RelicConfig_71235_BattleDesc = {
    Text = "All'inizio del turno, Helot ottiene [Arg1] Aliemus. Ogni volta che una carta viene scartata, Helot ottiene [Arg2] Aliemus."
  },
  RelicConfig_71235_Desc = {
    Text = "All'inizio del turno, Helot ottiene [Arg1] Aliemus. Ogni volta che una carta viene scartata, Helot ottiene [Arg2] Aliemus."
  },
  RelicConfig_71235_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Helot>"
  },
  RelicConfig_71236_BattleDesc = {
    Text = "A inizio turno, Daffodil ottiene [Arg1] Aliemus e 1 carta \"Intuizione\". La Forza ottenuta da \"Maree Eterogenee\" aumenta del [Arg2]%, e ogni carta giocata la incrementa permanentemente di un ulteriore [Arg3]% per questa esplorazione, fino a [Arg4]%."
  },
  RelicConfig_71236_Desc = {
    Text = "A inizio turno, Daffodil ottiene [Arg1] Aliemus e 1 carta \"Intuizione\". La Forza ottenuta da \"Maree Eterogenee\" aumenta del [Arg2]%, e ogni carta giocata la incrementa permanentemente di un ulteriore [Arg3]% per questa esplorazione, fino a [Arg4]%."
  },
  RelicConfig_71236_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Daffodil>"
  },
  RelicConfig_71237_BattleDesc = {
    Text = "A inizio turno, Wanda ottiene [Arg1] Aliemus e [Arg2] accumuli di \"Esca Onirica\". Se questo è un Turno Ultra, aggiunge inoltre 1 \"Catene di Aghi Spinali\" Temporanea e 1 \"Custode degli Smarriti\" in mano, e fa sì che la prossima Carta di comando di Wanda abbia effetto 2 volte."
  },
  RelicConfig_71237_Desc = {
    Text = "A inizio turno, Wanda ottiene [Arg1] Aliemus e [Arg2] accumuli di \"Esca Onirica\". Se questo è un Turno Ultra, aggiunge inoltre 1 \"Catene di Aghi Spinali\" Temporanea e 1 \"Custode degli Smarriti\" in mano, e fa sì che la prossima Carta di comando di Wanda abbia effetto 2 volte."
  },
  RelicConfig_71237_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Wanda>"
  },
  RelicConfig_71238_BattleDesc = {
    Text = "All'inizio del turno, Agrippa ottiene [Arg1] Aliemus. \"Elemosina riluttante\" riduce anche il Costo di Arithmetica di Agrippa di [Arg2] per questo turno, con effetto massimo di una volta per turno."
  },
  RelicConfig_71238_Desc = {
    Text = "All'inizio del turno, Agrippa ottiene [Arg1] Aliemus. \"Elemosina riluttante\" riduce anche il Costo di Arithmetica di Agrippa di [Arg2] per questo turno, con effetto massimo di una volta per turno."
  },
  RelicConfig_71238_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Agrippa>"
  },
  RelicConfig_71239_BattleDesc = {
    Text = "A inizio turno, \"24\" ottiene [Arg1] Aliemus. Se \"24\" è nello stato \"Personalità Depressa\" a inizio turno, ottiene [Arg2] Aliemus aggiuntivi; se è nello stato \"Personalità Maniacale\", il Tasso critico temporaneo e il Danno critico temporaneo di \"24\" sono +[Arg2]%."
  },
  RelicConfig_71239_Desc = {
    Text = "A inizio turno, \"24\" ottiene [Arg1] Aliemus. Se \"24\" è nello stato \"Personalità Depressa\" a inizio turno, ottiene [Arg2] Aliemus aggiuntivi; se è nello stato \"Personalità Maniacale\", il Tasso critico temporaneo e il Danno critico temporaneo di \"24\" sono +[Arg2]%."
  },
  RelicConfig_71239_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: \"24\">"
  },
  RelicConfig_71240_BattleDesc = {
    Text = "A inizio turno, Liz ottiene [Arg1] Aliemus. Le carte scartate da \"Danza verso la distruzione\" hanno effetto 1 volta aggiuntiva, con un tempo di recupero di 3 turni."
  },
  RelicConfig_71240_Desc = {
    Text = "A inizio turno, Liz ottiene [Arg1] Aliemus. Le carte scartate da \"Danza verso la distruzione\" hanno effetto 1 volta aggiuntiva, con un tempo di recupero di 3 turni."
  },
  RelicConfig_71240_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Liz>"
  },
  RelicConfig_71241_BattleDesc = {
    Text = "All'inizio del turno, Helot: Catena ottiene [Arg1] Aliemus. Il Danno attivo di Helot: Catena aggiunge [Arg2]% di Sanguinamento e uccidere un nemico infligge agli altri nemici Sanguinamento pari al danno in eccesso."
  },
  RelicConfig_71241_Desc = {
    Text = "All'inizio del turno, Helot-catena ottiene [Arg1] Aliemus. Il Danno attivo di Helot-catena aggiunge [Arg2]% di Sanguinamento, e uccidere un nemico causa Sanguinamento pari al Danno in eccesso agli altri nemici."
  },
  RelicConfig_71241_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Helot: Catena>"
  },
  RelicConfig_71242_BattleDesc = {
    Text = "A inizio turno, Celeste ottiene [Arg1] Aliemus. Prima della fine del turno, per ogni Carta di comando di Celeste In Mano, 1 Tentacolo attacca un nemico e ripristina [Heal:Arg2] PV."
  },
  RelicConfig_71242_Desc = {
    Text = "A inizio turno, Celeste ottiene [Arg1] Aliemus. Prima della fine del turno, per ogni Carta di comando di Celeste In Mano, 1 Tentacolo attacca un nemico e ripristina [Heal:Arg2] PV."
  },
  RelicConfig_71242_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Celeste>"
  },
  RelicConfig_71243_BattleDesc = {
    Text = "A inizio turno, Casiah ottiene [Arg1] Aliemus. Pescare 1 carta conferisce a Casiah [Arg2] Aliemus. Quando Casiah scatena l'Esaltazione, tutti i nemici perdono [Arg3] FOR."
  },
  RelicConfig_71243_Desc = {
    Text = "A inizio turno, Casiah ottiene [Arg1] Aliemus. Pescare 1 carta conferisce a Casiah [Arg2] Aliemus. Quando Casiah scatena l'Esaltazione, tutti i nemici perdono [Arg3] FOR."
  },
  RelicConfig_71243_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Casiah>"
  },
  RelicConfig_71244_BattleDesc = {
    Text = "A inizio turno, Sorel ottiene [Arg1] Aliemus. Per ogni istanza di Danno inflitta da Sorel, Fusione Embrionale +[Arg2], fino a [Arg3] <plural value=\"[Arg3]\" singular=\"volta\" plural=\"volte\"> per turno. Dopo essersi attivato 10 volte, il Danno Finale di Sorel in questa battaglia +[Arg4]%."
  },
  RelicConfig_71244_Desc = {
    Text = "A inizio turno, Sorel ottiene [Arg1] Aliemus. Per ogni istanza di Danno inflitta da Sorel, Fusione Embrionale +[Arg2], fino a [Arg3] <plural value=\"[Arg3]\" singular=\"volta\" plural=\"volte\"> per turno. Dopo essersi attivato 10 volte, il Danno Finale di Sorel in questa battaglia +[Arg4]%."
  },
  RelicConfig_71244_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Sorel>"
  },
  RelicConfig_71245_BattleDesc = {
    Text = "All'inizio del turno, Ogier ottiene [Arg1] Aliemus. Dopo la prima volta che Ogier gioca \"Lancia Perforante\" o \"Colpo\" in ogni turno, lo Scudo e la FOR generati da Ogier in quel turno aumentano del +[Arg2]%."
  },
  RelicConfig_71245_Desc = {
    Text = "All'inizio del turno, Ogier ottiene [Arg1] Aliemus. Dopo la prima volta che Ogier gioca \"Lancia Perforante\" o \"Colpo\" in ogni turno, lo Scudo e la FOR generati da Ogier in quel turno aumentano del +[Arg2]%."
  },
  RelicConfig_71245_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Ogier>"
  },
  RelicConfig_71246_BattleDesc = {
    Text = "All'inizio del turno, Alva ottiene [Arg1] Aliemus. Entro 1 turno, dopo aver giocato la [Arg2]ª carta \"Difesa\", colloca una \"Lama di Precisione\" consumata in mano; dopo aver giocato la [Arg3]ª carta \"Attacco\", colloca una \"Postura di combattimento\" consumata in mano."
  },
  RelicConfig_71246_Desc = {
    Text = "All'inizio del turno, Alva ottiene [Arg1] Aliemus. Entro 1 turno, dopo aver giocato la [Arg2]ª carta \"Difesa\", colloca una \"Lama di Precisione\" consumata in mano; dopo aver giocato la [Arg3]ª carta \"Attacco\", colloca una \"Postura di combattimento\" consumata in mano."
  },
  RelicConfig_71246_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Alva>"
  },
  RelicConfig_71247_BattleDesc = {
    Text = "A inizio turno, Jenkin ottiene [Arg1] Aliemus, con Danno Finale +[Arg2]%. Il DAN Base e la crescita del danno di \"Prendilo! Brown!\" sono +[Arg3]%."
  },
  RelicConfig_71247_Desc = {
    Text = "A inizio turno, Jenkin ottiene [Arg1] Aliemus, con Danno Finale +[Arg2]%. Il DAN Base e la crescita del danno di \"Prendilo! Brown!\" sono +[Arg3]%."
  },
  RelicConfig_71247_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Jenkin>"
  },
  RelicConfig_71248_BattleDesc = {
    Text = "A inizio turno, Doll ottiene [Arg1] Aliemus. Dopo l'inizio della battaglia, imposta il Costo di Arithmetica di \"Scambio Equivalente\" di Doll a 0. Dopo averla giocata, pesca [Arg2] carte aggiuntive nel turno successivo."
  },
  RelicConfig_71248_Desc = {
    Text = "A inizio turno, Doll ottiene [Arg1] Aliemus. Dopo l'inizio della battaglia, imposta il Costo di Arithmetica di \"Scambio Equivalente\" di Doll a 0. Dopo averla giocata, pesca [Arg2] carte aggiuntive nel turno successivo."
  },
  RelicConfig_71248_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Doll>"
  },
  RelicConfig_71249_BattleDesc = {
    Text = "A inizio turno, Ryker ottiene [Arg1] Aliemus. Il risultato del primo lancio di dadi di ogni turno è sempre 6."
  },
  RelicConfig_71249_Desc = {
    Text = "A inizio turno, Ryker ottiene [Arg1] Aliemus. Il risultato del primo lancio di dadi di ogni turno è sempre 6."
  },
  RelicConfig_71249_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Ryker>"
  },
  RelicConfig_71250_BattleDesc = {
    Text = "All'inizio del turno, Miryam ottiene [Arg1] Aliemus e colloca 1 \"Sacramento\" in mano."
  },
  RelicConfig_71250_Desc = {
    Text = "All'inizio del turno, Miryam ottiene [Arg1] Aliemus e colloca 1 \"Sacramento\" in mano."
  },
  RelicConfig_71250_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Miryam>"
  },
  RelicConfig_71251_BattleDesc = {
    Text = "A inizio turno, Winkle ottiene [Arg1] Aliemus. Ogni volta che un altro Risvegliatore scatena l'Esaltazione, Winkle ottiene [Arg2] Aliemus e il Costo di Arithmetica di \"Psiche Riforgiata\" In Mano si riduce di [Arg3]."
  },
  RelicConfig_71251_Desc = {
    Text = "A inizio turno, Winkle ottiene [Arg1] Aliemus. Ogni volta che un altro Risvegliatore scatena l'Esaltazione, Winkle ottiene [Arg2] Aliemus e il Costo di Arithmetica di \"Psiche Riforgiata\" In Mano si riduce di [Arg3]."
  },
  RelicConfig_71251_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Winkle>"
  },
  RelicConfig_71252_BattleDesc = {
    Text = "All'inizio del turno, Tulu ottiene [Arg1] Aliemus. Aliemus base di Tulu -[Arg2], e dopo aver rilasciato l'Esaltazione, genera istantaneamente [Arg3] Tentacoli Temporanei."
  },
  RelicConfig_71252_Desc = {
    Text = "All'inizio del turno, Tulu ottiene [Arg1] Aliemus. Aliemus base di Tulu -[Arg2], e dopo aver rilasciato l'Esaltazione, genera istantaneamente [Arg3] Tentacoli Temporanei."
  },
  RelicConfig_71252_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Tulu>"
  },
  RelicConfig_71253_BattleDesc = {
    Text = "A inizio turno, Faint ottiene [Arg1] Aliemus. Generazione di Scudo, Contatore e Recupero PV di Faint +[Arg2]%. Ogni volta che la Resistenza alla Morte si attiva, questo effetto aumenta del [Arg3]% per l'esplorazione in corso, fino a [Arg4] volte."
  },
  RelicConfig_71253_Desc = {
    Text = "A inizio turno, Faint ottiene [Arg1] Aliemus. Generazione di Scudo, Contatore e Recupero PV di Faint +[Arg2]%. Ogni volta che la Resistenza alla Morte si attiva, questo effetto aumenta del [Arg3]% per l'esplorazione in corso, fino a [Arg4] volte."
  },
  RelicConfig_71253_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Faint>"
  },
  RelicConfig_71254_BattleDesc = {
    Text = "A inizio turno, Tawil ottiene [Arg1] Aliemus. Se [Arg2] Carte di comando di Tawil vengono giocate in un turno, aggiungi 1 <DerivativeCardKeywords_67:<DerivativeCardKeywords_67:\"Aurora della Chiave d'Argento\">> alla mano. Recupero: [Arg3] turni."
  },
  RelicConfig_71254_Desc = {
    Text = "A inizio turno, Tawil ottiene [Arg1] Aliemus. Se [Arg2] Carte di comando di Tawil vengono giocate in un turno, aggiungi 1 <DerivativeCardKeywords_67:<DerivativeCardKeywords_67:\"Aurora della Chiave d'Argento\">> alla mano. Recupero: [Arg3] turni."
  },
  RelicConfig_71254_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Tawil>"
  },
  RelicConfig_71255_BattleDesc = {
    Text = "All'inizio del turno Hameln ottiene [Arg1] Aliemus. Il costo di Arithmetica base della \"Ouverture dell'Anima\" si riduce di [Arg2] e il numero di colpi base aumenta di [Arg3]."
  },
  RelicConfig_71255_Desc = {
    Text = "All'inizio del turno Hameln ottiene [Arg1] Aliemus. Il costo di Arithmetica base della \"Ouverture dell'Anima\" si riduce di [Arg2] e il numero di colpi base aumenta di [Arg3]."
  },
  RelicConfig_71255_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Hameln>"
  },
  RelicConfig_71256_BattleDesc = {
    Text = "A inizio turno, Horla ottiene [Arg1] Aliemus. A inizio battaglia, ottiene [Arg2] accumuli di \"Metafora\" per tutte le emozioni, aumentando l'effetto di \"Metafora\" del 50%."
  },
  RelicConfig_71256_Desc = {
    Text = "A inizio turno, Horla ottiene [Arg1] Aliemus. A inizio battaglia, ottiene [Arg2] accumuli di \"Metafora\" per tutte le emozioni, aumentando l'effetto di \"Metafora\" del 50%."
  },
  RelicConfig_71256_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Horla>"
  },
  RelicConfig_71257_BattleDesc = {
    Text = "All'inizio del turno, Murphy ottiene [Arg1] Aliemus. \"Attacco\" e \"Difesa\" di Murphy possono convertire il [Arg2]% del \"Sacrificio\" in Danno tentacolo temporaneo, ma può attivarsi solo una volta per turno."
  },
  RelicConfig_71257_Desc = {
    Text = "All'inizio del turno, Murphy ottiene [Arg1] Aliemus. \"Attacco\" e \"Difesa\" di Murphy possono convertire il [Arg2]% del \"Sacrificio\" in Danno tentacolo temporaneo, ma può attivarsi solo una volta per turno."
  },
  RelicConfig_71257_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Murphy>"
  },
  RelicConfig_71258_BattleDesc = {
    Text = "All'inizio del turno, Uvhash ottiene [Arg1] Aliemus. Aliemus base di Uvhash -[Arg2], ulteriormente ridotti di 5 ogni volta che rilascia l'Esaltazione. Può rilasciare l'Esaltazione [Arg3] volte per turno."
  },
  RelicConfig_71258_Desc = {
    Text = "All'inizio del turno, Uvhash ottiene [Arg1] Aliemus. Aliemus base di Uvhash -[Arg2], ulteriormente ridotti di 5 ogni volta che rilascia l'Esaltazione. Può rilasciare l'Esaltazione [Arg3] volte per turno."
  },
  RelicConfig_71258_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Uvhash>"
  },
  RelicConfig_71259_BattleDesc = {
    Text = "A inizio turno, Aigis ottiene [Arg1] Aliemus. Quando Aigis infligge DAN ai nemici con Vulnerabile, ruba anche [Arg2] FOR temporanea, fino a [Arg3] volte per turno."
  },
  RelicConfig_71259_Desc = {
    Text = "A inizio turno, Aigis ottiene [Arg1] Aliemus. Quando Aigis infligge DAN ai nemici con Vulnerabile, ruba anche [Arg2] FOR temporanea, fino a [Arg3] volte per turno."
  },
  RelicConfig_71259_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Aigis>"
  },
  RelicConfig_71260_BattleDesc = {
    Text = "All'inizio del turno, Thais ottiene [Arg1] Aliemus. Dopo aver giocato [Arg2] Carte di comando in 1 turno, Thais ottiene un \"Rampollo della Purezza\" e [Arg3] FOR temporanea, con un tempo di recupero di [Arg4] turni."
  },
  RelicConfig_71260_Desc = {
    Text = "All'inizio del turno, Thais ottiene [Arg1] Aliemus. Dopo aver giocato [Arg2] Carte di comando in 1 turno, Thais ottiene un \"Rampollo della Purezza\" e [Arg3] FOR temporanea, con un tempo di recupero di [Arg4] turni."
  },
  RelicConfig_71260_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Thais>"
  },
  RelicConfig_71261_BattleDesc = {
    Text = "All'inizio del turno, Faros ottiene [Arg1] Aliemus. Ogni 2 istanze di DAN da Tentacolo inflitte, la generazione di Veleno e Scudo di Faros in questa battaglia +[Arg2]%, fino a un massimo del 50%."
  },
  RelicConfig_71261_Desc = {
    Text = "All'inizio del turno, Faros ottiene [Arg1] Aliemus. Ogni 2 istanze di DAN da Tentacolo inflitte, la generazione di Veleno e Scudo di Faros in questa battaglia +[Arg2]%, fino a un massimo del 50%."
  },
  RelicConfig_71261_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Faros>"
  },
  RelicConfig_71262_BattleDesc = {
    Text = "All'inizio del turno, Pandia ottiene [Arg1] Aliemus. Dopo che Pandia esegue un'Esaltazione, ottiene Contatore Permanente equivalente al [Arg2]% del suo Contatore Temporaneo."
  },
  RelicConfig_71262_Desc = {
    Text = "All'inizio del turno, Pandia ottiene [Arg1] Aliemus. Dopo che Pandia esegue un'Esaltazione, ottiene Contatore Permanente equivalente al [Arg2]% del suo Contatore Temporaneo."
  },
  RelicConfig_71262_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Pandia>"
  },
  RelicConfig_71263_BattleDesc = {
    Text = "All'inizio del turno, Lily ottiene [Arg1] Aliemus. Il limite di Resistenza di Lily aumenta del 100% e, quando rilascia \"Fiore Immortale sulla Melma\" o \"Colpo di Protezione\", Lily ripristina PV pari all'8% delle cariche di \"Resistenza\"."
  },
  RelicConfig_71263_Desc = {
    Text = "All'inizio del turno, Lily ottiene [Arg1] Aliemus. Il limite di Resistenza di Lily aumenta del 100% e, quando rilascia \"Fiore Immortale sulla Melma\" o \"Colpo di Protezione\", Lily ripristina PV pari all'8% delle cariche di \"Resistenza\"."
  },
  RelicConfig_71263_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Lily>"
  },
  RelicConfig_71264_BattleDesc = {
    Text = "All'inizio del turno, Karen ottiene [Arg1] Aliemus. Giocare \"Fedeltà Silenziosa\" restituisce il doppio dell'Arithmetica consumata, con un tempo di ricarica di [Arg2] turni."
  },
  RelicConfig_71264_Desc = {
    Text = "All'inizio del turno, Karen ottiene [Arg1] Aliemus. Giocare \"Fedeltà Silenziosa\" restituisce il doppio dell'Arithmetica consumata, con un tempo di ricarica di [Arg2] turni."
  },
  RelicConfig_71264_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Karen>"
  },
  RelicConfig_71265_BattleDesc = {
    Text = "All'inizio del turno, Salvador ottiene [Arg1] Aliemus. Ogni volta che accumula Fornace Cremisi, ottiene anche FOR pari al [Arg2]% della quantità accumulata. \"Attacco\" e \"Fine della Sofferenza\" di Salvador godono inoltre di un bonus di FOR di [Arg3]x."
  },
  RelicConfig_71265_Desc = {
    Text = "All'inizio del turno, Salvador ottiene [Arg1] Aliemus. Ogni volta che accumula Fornace Cremisi, ottiene anche FOR pari al [Arg2]% della quantità accumulata. \"Attacco\" e \"Fine della Sofferenza\" di Salvador godono inoltre di un bonus di FOR di [Arg3]x."
  },
  RelicConfig_71265_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Salvador>"
  },
  RelicConfig_71266_BattleDesc = {
    Text = "All'inizio del turno, Caecus ottiene [Arg1] Aliemus. Quando Caecus ottiene uno scudo, recupera il [Arg2]% dell'ammontare dello Scudo come PV."
  },
  RelicConfig_71266_Desc = {
    Text = "All'inizio del turno, Caecus ottiene [Arg1] Aliemus. Quando Caecus ottiene uno scudo, recupera il [Arg2]% dell'ammontare dello Scudo come PV."
  },
  RelicConfig_71266_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Caecus>"
  },
  RelicConfig_71267_BattleDesc = {
    Text = "A inizio turno, Nymphaea ottiene [Arg1] Aliemus. Dopo aver giocato l'\"Attacco\" di Nymphaea, il Veleno inflitto da \"Nymphaea\" in questa battaglia aumenta del [Arg2]%. Dopo aver giocato la \"Difesa\" di Nymphaea, infligge il [Arg3]% di Veleno a tutti i nemici. Ogni effetto può attivarsi al massimo una volta per turno."
  },
  RelicConfig_71267_Desc = {
    Text = "A inizio turno, Nymphaea ottiene [Arg1] Aliemus. Dopo aver giocato l'\"Attacco\" di Nymphaea, il Veleno inflitto da \"Nymphaea\" in questa battaglia aumenta del [Arg2]%. Dopo aver giocato la \"Difesa\" di Nymphaea, infligge il [Arg3]% di Veleno a tutti i nemici. Ogni effetto può attivarsi al massimo una volta per turno."
  },
  RelicConfig_71267_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Nymphaea>"
  },
  RelicConfig_71268_BattleDesc = {
    Text = "A inizio turno, Erica ottiene [Arg1] Aliemus. Dopo aver giocato [Arg2] Carte di comando in 1 turno, Erica ottiene 2 Arithmetica e raddoppia il bonus di FOR e Allerta per \"Esplosione Elettromagnetica\" in questa battaglia."
  },
  RelicConfig_71268_Desc = {
    Text = "A inizio turno, Erica ottiene [Arg1] Aliemus. Dopo aver giocato [Arg2] Carte di comando in 1 turno, Erica ottiene 2 Arithmetica e raddoppia il bonus di FOR e Allerta per \"Esplosione Elettromagnetica\" in questa battaglia."
  },
  RelicConfig_71268_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Erica>"
  },
  RelicConfig_71269_BattleDesc = {
    Text = "All'inizio del turno, Golia ottiene [Arg1] Aliemus. Se Golia infligge danni [Arg2] volte in 1 turno, i danni inflitti da Golia in questa battaglia godono di un bonus di FOR aggiuntivo di 1x, con un tempo di recupero di 3 turni."
  },
  RelicConfig_71269_Desc = {
    Text = "All'inizio del turno, Golia ottiene [Arg1] Aliemus. Se Golia infligge danni [Arg2] volte in 1 turno, i danni inflitti da Golia in questa battaglia godono di un bonus di FOR aggiuntivo di 1x, con un tempo di recupero di 3 turni."
  },
  RelicConfig_71269_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Golia>"
  },
  RelicConfig_71270_BattleDesc = {
    Text = "All'inizio del turno, Sanga ottiene [Arg1] Aliemus. All'inizio della battaglia, conferisce a tutte le Carte di comando di Sanga Conservare, Preparazione 1, e ottiene [Arg2] Scudo."
  },
  RelicConfig_71270_Desc = {
    Text = "All'inizio del turno, Sanga ottiene [Arg1] Aliemus. All'inizio della battaglia, conferisce a tutte le Carte di comando di Sanga Conservare, Preparazione 1, e ottiene [Arg2] Scudo."
  },
  RelicConfig_71270_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Sanga>"
  },
  RelicConfig_71662_BattleDesc = {
    Text = "A inizio dei turni pari, aggiungi 1 <DerivativeCardKeywords_105:Volta d'Argento Infinita> alla mano."
  },
  RelicConfig_71662_Desc = {
    Text = "A inizio dei turni pari, aggiungi 1 <DerivativeCardKeywords_105:Volta d'Argento Infinita> alla mano."
  },
  RelicConfig_71662_Name = {
    Text = "<OrangeQuality:Tesoro del Gatto>"
  },
  RelicConfig_72226_BattleDesc = {
    Text = "Limite mano +1. All'inizio del turno, se non è stata condotta alcuna Ricerca, scegli una Ricerca non tentata. Al completamento, ottieni il risultato di Ricerca corrispondente di Doll: Inferno. Dopo aver completato 3 Ricerche, metti \"Fine dell'Illusione\" in mano; questa Reliquia diventa inattiva."
  },
  RelicConfig_72226_Desc = {
    Text = "Limite mano +1. All'inizio del turno, se non è stata condotta alcuna Ricerca, scegli una Ricerca non tentata. Al completamento, ottieni il risultato di Ricerca corrispondente di Doll: Inferno. Dopo aver completato 3 Ricerche, metti \"Fine dell'Illusione\" in mano; questa Reliquia diventa inattiva."
  },
  RelicConfig_72226_Name = {
    Text = "Manoscritto di Ricerca della Fine Ultima"
  },
  RelicConfig_74832_BattleDesc = {
    Text = "Limite della mano +1. Crea un \"Commercio Proibito\" personalizzato all'inizio della battaglia. Gioca \"Commercio Proibito\" per crearne un altro al tuo prossimo turno.\n\"Commercio Proibito\" ha Costo di Arithmetica 4, Conservare, Preparazione ed Esaurimento, e possiede 3 effetti personalizzati. Giocare Carte di comando \"Attacco\", \"Difesa\" o \"Abilità\" potenzierà rispettivamente il 1°, 2° o 3° effetto."
  },
  RelicConfig_74832_Desc = {
    Text = "Limite della mano +1. Crea un \"Commercio Proibito\" personalizzato all'inizio della battaglia. Gioca \"Commercio Proibito\" per crearne un altro al tuo prossimo turno.\n\"Commercio Proibito\" ha Costo di Arithmetica 4, Conservare, Preparazione ed Esaurimento, e possiede 3 effetti personalizzati. Giocare Carte di comando \"Attacco\", \"Difesa\" o \"Abilità\" potenzierà rispettivamente il 1°, 2° o 3° effetto."
  },
  RelicConfig_74832_Name = {
    Text = "Invito del Mutaforma"
  },
  RelicConfig_74832_StoryDesc = {
    Text = "Le parole sulla lettera continuavano a mutare, trasformandosi sempre in un Desiderio irresistibile."
  },
  RelicConfig_78664_BattleDesc = {
    Text = "Quando giochi 4 Carte di comando di Risvegliatori diversi in un singolo turno, aumenta il Danno Finale inflitto da tutti i Risvegliatori in questo turno del [Arg1]% e perdi [Arg2] Aliemus. Questo effetto può essere attivato solo una volta per turno."
  },
  RelicConfig_78664_Desc = {
    Text = "Quando giochi 4 Carte di comando di Risvegliatori diversi in un singolo turno, aumenta il Danno Finale inflitto da tutti i Risvegliatori in questo turno del [Arg1]% e perdi [Arg2] Aliemus. Questo effetto può essere attivato solo una volta per turno."
  },
  RelicConfig_78664_Name = {
    Text = "<RedQuality:Uncino Sinistro>"
  },
  RelicConfig_78664_StoryDesc = {
    Text = "Specie difficili da identificare."
  },
  RelicConfig_78665_BattleDesc = {
    Text = "A inizio turno, pesca [Arg1] carte in meno. Ottieni 1 Arithmetica per ogni carta giocata con costo >= [Arg2] Arithmetica, fino a [Arg3] volte per turno."
  },
  RelicConfig_78665_Desc = {
    Text = "A inizio turno, pesca [Arg1] carte in meno. Ottieni 1 Arithmetica per ogni carta giocata con costo >= [Arg2] Arithmetica, fino a [Arg3] volte per turno."
  },
  RelicConfig_78665_Name = {
    Text = "<RedQuality:Campana del Lamento>"
  },
  RelicConfig_78665_StoryDesc = {
    Text = [[
Din, din, il bimbo piange;
Din, din, il bimbo grida.
Din, din, il bimbo si lamenta;
Din, din, ha fame, lo sai.]]
  },
  RelicConfig_78666_BattleDesc = {
    Text = "A inizio turno, ottieni [Arg1] Contatore. Dopo aver usato l'Esaltazione [Arg2] volte in un turno, rimuovi il [Arg3]% del Contatore Permanente e ottieni il [Arg4]% della quantità rimossa come Contatore Temporaneo. Tempo di ricarica: [Arg5] turni."
  },
  RelicConfig_78666_Desc = {
    Text = "A inizio turno, ottieni [Arg1] Contatore. Dopo aver usato l'Esaltazione [Arg2] volte in un turno, rimuovi il [Arg3]% del Contatore Permanente e ottieni il [Arg4]% della quantità rimossa come Contatore Temporaneo. Tempo di ricarica: [Arg5] turni."
  },
  RelicConfig_78666_Name = {
    Text = "<RedQuality:Resti del Viandante>"
  },
  RelicConfig_78666_StoryDesc = {
    Text = [[
Un frammento sacro.
Sebbene si sia separato dal corpo, le sue impronte si sono propagate per il mondo.]]
  },
  RelicConfig_78667_BattleDesc = {
    Text = "Dopo la fase di pescata, pesca [Arg1] carte aggiuntive e scegli [Arg2] carte dalla tua mano da scartare."
  },
  RelicConfig_78667_Desc = {
    Text = "Dopo la fase di pescata, pesca [Arg1] carte aggiuntive e scegli [Arg2] carte dalla tua mano da scartare."
  },
  RelicConfig_78667_Name = {
    Text = "<RedQuality:Cappello del Truffatore>"
  },
  RelicConfig_78667_StoryDesc = {
    Text = "Benvenuto al Circo delle Meraviglie di Miss Casiah! Attenzione, non toccare gli oggetti magici. Se vieni morso, potrebbe andare male.\nL'ultima volta che ha assaggiato il sangue, l'esito fu terribile.\n\nIl cilindro ammiccò, come pronto a emergere."
  },
  RelicConfig_78668_BattleDesc = {
    Text = "Dopo aver usato il Risveglio della Chiave d'Argento, scegli [Arg1] Carta Comando Non Derivata corrispondente a quel Risvegliatore nella tua mano. Esaurisci quella carta per collocare [Arg2] Copie Base di essa rispettivamente nel Mazzo di Pesca, nella mano e nella Pila degli scarti."
  },
  RelicConfig_78668_Desc = {
    Text = "Dopo aver usato il Risveglio della Chiave d'Argento, scegli [Arg1] Carta Comando Non Derivata corrispondente a quel Risvegliatore nella tua mano. Esaurisci quella carta per collocare [Arg2] Copie Base di essa rispettivamente nel Mazzo di Pesca, nella mano e nella Pila degli scarti."
  },
  RelicConfig_78668_Name = {
    Text = "<RedQuality:Impronta di Giada>"
  },
  RelicConfig_78668_StoryDesc = {
    Text = "Questa impronta sopporta i millenni senza decomposizione."
  },
  RelicConfig_78669_BattleDesc = {
    Text = "Ottieni [Arg1] Forza all'inizio della battaglia. All'inizio del turno, per ogni [Arg2] FRZ Permanente, ottieni [Arg3] FOR temporanea, fino a un massimo di [Arg4] FOR temporanea, e perdi metà della FOR temporanea ottenuta da quella Reliquia alla fine del turno."
  },
  RelicConfig_78669_Desc = {
    Text = "Ottieni [Arg1] Forza all'inizio della battaglia. All'inizio del turno, per ogni [Arg2] FRZ Permanente, ottieni [Arg3] FOR temporanea, fino a un massimo di [Arg4] FOR temporanea, e perdi metà della FOR temporanea ottenuta da quella Reliquia alla fine del turno."
  },
  RelicConfig_78669_Name = {
    Text = "<RedQuality:Uccello Rituale del Presagio>"
  },
  RelicConfig_78669_StoryDesc = {
    Text = "Il cadavere rinsecchito emise uno stridio."
  },
  RelicConfig_78670_BattleDesc = {
    Text = "Aumenta il DAN Base di tutti i Risvegliati del [Arg1]%. Ogni volta che il mazzo viene rimescolato, viene concesso un ulteriore [Arg2]%, ma una carta \"Barcollamento\" viene aggiunta alla tua mano. L'aumento massimo è del [Arg3]%."
  },
  RelicConfig_78670_Desc = {
    Text = "Aumenta il DAN Base di tutti i Risvegliati del [Arg1]%. Ogni volta che il mazzo viene rimescolato, viene concesso un ulteriore [Arg2]%, ma una carta \"Barcollamento\" viene aggiunta alla tua mano. L'aumento massimo è del [Arg3]%."
  },
  RelicConfig_78670_Name = {
    Text = "<RedQuality:Candela nera>"
  },
  RelicConfig_78670_StoryDesc = {
    Text = "Brucia nella lucidità, sprofonda nell'illusione."
  },
  RelicConfig_78671_BattleDesc = {
    Text = "A inizio turno, Fusione Embrionale +[Arg1]. Le carte \"Embrione\" verranno scartate a fine turno."
  },
  RelicConfig_78671_Desc = {
    Text = "A inizio turno, Fusione Embrionale +[Arg1]. Le carte \"Embrione\" verranno scartate a fine turno."
  },
  RelicConfig_78671_Name = {
    Text = "<RedQuality:Cordone Strisciante>"
  },
  RelicConfig_78671_StoryDesc = {
    Text = "Avvinghiarsi al collo."
  },
  RelicConfig_78672_BattleDesc = {
    Text = "A inizio turno, ottieni [Arg1] FOR per ogni spazio vacante nello Spazio Ultra, ma subisci [Arg2] cariche di Veleno."
  },
  RelicConfig_78672_Desc = {
    Text = "A inizio turno, ottieni [Arg1] FOR per ogni spazio vacante nello Spazio Ultra, ma subisci [Arg2] cariche di Veleno."
  },
  RelicConfig_78672_Name = {
    Text = "<RedQuality:Mente dello Sciame>"
  },
  RelicConfig_78672_StoryDesc = {
    Text = "Intrecciare, Simbiosi, Sciame; Paura, Creatura Sconosciuta, Controllo."
  },
  RelicConfig_78673_BattleDesc = {
    Text = "Dopo aver usato il Risveglio Keyflare, consuma [Arg1] Keyflare aggiuntivi, riducendo il consumo di Arithmetica della carta Risveglio ricevuta a 0. Al momento di giocarla, il Risvegliato corrispondente ottiene [Arg2] Aliemus aggiuntivi."
  },
  RelicConfig_78673_Desc = {
    Text = "Dopo aver usato il Risveglio Keyflare, consuma [Arg1] Keyflare aggiuntivi, riducendo il consumo di Arithmetica della carta Risveglio ricevuta a 0. Al momento di giocarla, il Risvegliato corrispondente ottiene [Arg2] Aliemus aggiuntivi."
  },
  RelicConfig_78673_Name = {
    Text = "<RedQuality:Incisione della Coscienza>"
  },
  RelicConfig_78673_StoryDesc = {
    Text = "L'antica tribù credeva che incidere simboli speciali sui teschi dei defunti potesse trattenerne le anime per una compagnia eterna."
  },
  RelicConfig_78674_BattleDesc = {
    Text = "A inizio battaglia, infliggi [Arg1] Veleno a tutti i nemici. A inizio turno, rimuovi il [Arg2]% del Veleno del nemico e applica il [Arg3]% della quantità rimossa come Salasso."
  },
  RelicConfig_78674_Desc = {
    Text = "A inizio battaglia, infliggi [Arg1] Veleno a tutti i nemici. A inizio turno, rimuovi il [Arg2]% del Veleno del nemico e applica il [Arg3]% della quantità rimossa come Salasso."
  },
  RelicConfig_78674_Name = {
    Text = "<RedQuality:Arto Salvifico>"
  },
  RelicConfig_78674_StoryDesc = {
    Text = [[
Una parte sacra.
Anche quando separata dal corpo, se ne percepisce ancora il calore.]]
  },
  RelicConfig_78675_BattleDesc = {
    Text = "A inizio turno, se ci sono più di [Arg1] Tentacoli Permanenti, perdi [Arg2] Tentacoli per ottenere [Arg3] Tentacoli Temporanei. Altrimenti, ottieni [Arg4] Tentacoli Permanenti."
  },
  RelicConfig_78675_Desc = {
    Text = "A inizio turno, se ci sono più di [Arg1] Tentacoli Permanenti, perdi [Arg2] Tentacoli per ottenere [Arg3] Tentacoli Temporanei. Altrimenti, ottieni [Arg4] Tentacoli Permanenti."
  },
  RelicConfig_78675_Name = {
    Text = "<RedQuality:Agonia Sacra>"
  },
  RelicConfig_78675_StoryDesc = {
    Text = "Abbraccia l'agonia."
  },
  RelicConfig_79408_BattleDesc = {
    Text = "Limite carte in mano +2, pesca +2. \"Memoria Lucida\" inizia a 5 accumuli. Giocare carte contrassegnate modifica la \"Memoria Lucida\". Quando la \"Memoria Lucida\" è inferiore a 5, ogni riduzione di 1 aumenta il Danno Finale del 10% e riduce lo Scudo del Personaggio e il Recupero PV del 5%; quando è superiore a 5, ogni aumento di 1 potenzia lo Scudo del Personaggio e la Guarigione del 5% e riduce il Danno Finale del 10%."
  },
  RelicConfig_79408_Desc = {
    Text = "Limite carte in mano +2, pesca +2. \"Memoria Lucida\" inizia a 5 accumuli. Giocare carte contrassegnate modifica la \"Memoria Lucida\". Quando la \"Memoria Lucida\" è inferiore a 5, ogni riduzione di 1 aumenta il Danno Finale del 10% e riduce lo Scudo del Personaggio e il Recupero PV del 5%; quando è superiore a 5, ogni aumento di 1 potenzia lo Scudo del Personaggio e la Guarigione del 5% e riduce il Danno Finale del 10%."
  },
  RelicConfig_79408_Name = {
    Text = "\"Memoria\" e \"Sogno\""
  },
  RelicConfig_79408_StoryDesc = {
    Text = [[
"Vieni, ascoltami."
"Lascia che trasformi i tuoi ricordi e i tuoi sogni."
"In un dessert incredibilmente delizioso."]]
  },
  RelicConfig_80340_BattleDesc = {
    Text = "A inizio turno, Clementine ottiene [Arg1] Aliemus. Il numero di volte in cui le Carte di comando di Clementine infliggono DAN, generano Scudo, recuperano PV, ottengono Aliemus e ottengono Keyflare aumenta di 1."
  },
  RelicConfig_80340_Desc = {
    Text = "A inizio turno, Clementine ottiene [Arg1] Aliemus. Il numero di volte in cui le Carte di comando di Clementine infliggono DAN, generano Scudo, recuperano PV, ottengono Aliemus e ottengono Keyflare aumenta di 1."
  },
  RelicConfig_80340_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Clementine>"
  },
  RelicConfig_83509_BattleDesc = {
    Text = "All'inizio dell'esplorazione, Capacità Reliquie +1, e il Risveglio \"Aequor\" ottiene la propria \"Immagine Dimensionale\". Per ogni Risveglio \"Aequor\" nella squadra, Capacità Reliquie +1."
  },
  RelicConfig_83509_Desc = {
    Text = "All'inizio dell'esplorazione, Capacità Reliquie +1, e il Risveglio \"Aequor\" ottiene la propria \"Immagine Dimensionale\". Per ogni Risveglio \"Aequor\" nella squadra, Capacità Reliquie +1."
  },
  RelicConfig_83509_Name = {
    Text = "<OrangeQuality:\"Anello di Aequor\">"
  },
  RelicConfig_83509_StoryDesc = {
    Text = "I dormienti nell'oceano abissale cominciano a mostrare al mondo l'Autorità dimenticata."
  },
  RelicConfig_83510_BattleDesc = {
    Text = "All'inizio dell'esplorazione, Capacità Reliquie +1, e il Risveglio \"Caro\" ottiene la propria \"Immagine Dimensionale\". Per ogni Risveglio \"Caro\" nella squadra, Capacità Reliquie +1."
  },
  RelicConfig_83510_Desc = {
    Text = "All'inizio dell'esplorazione, Capacità Reliquie +1, e il Risveglio \"Caro\" ottiene la propria \"Immagine Dimensionale\". Per ogni Risveglio \"Caro\" nella squadra, Capacità Reliquie +1."
  },
  RelicConfig_83510_Name = {
    Text = "<OrangeQuality:\"Anello di Caro\">"
  },
  RelicConfig_83510_StoryDesc = {
    Text = "Dalla sofferenza indomita, l'Ascensione è stata raggiunta."
  },
  RelicConfig_83511_BattleDesc = {
    Text = "All'inizio dell'esplorazione, Capacità Reliquie +1, e il Risveglio \"Ultra\" ottiene la propria \"Immagine Dimensionale\". Per ogni Risveglio \"Ultra\" nella squadra, Capacità Reliquie +1."
  },
  RelicConfig_83511_Desc = {
    Text = "All'inizio dell'esplorazione, Capacità Reliquie +1, e il Risveglio \"Ultra\" ottiene la propria \"Immagine Dimensionale\". Per ogni Risveglio \"Ultra\" nella squadra, Capacità Reliquie +1."
  },
  RelicConfig_83511_Name = {
    Text = "<OrangeQuality:\"Anello Ultra\">"
  },
  RelicConfig_83511_StoryDesc = {
    Text = "Infinite dimensioni sovrapposte: in questo istante, \"Io\" sono infinitamente completo."
  },
  RelicConfig_83512_BattleDesc = {
    Text = "A inizio esplorazione, Capacità Reliquie +1 e il Risvegliatore \"Caos\" ottiene la sua \"Immagine Dimensionale\". Per ogni Risvegliatore \"Caos\" nella squadra, Capacità Reliquie +1."
  },
  RelicConfig_83512_Desc = {
    Text = "A inizio esplorazione, Capacità Reliquie +1 e il Risvegliatore \"Caos\" ottiene la sua \"Immagine Dimensionale\". Per ogni Risvegliatore \"Caos\" nella squadra, Capacità Reliquie +1."
  },
  RelicConfig_83512_Name = {
    Text = "<OrangeQuality:\"Anello del Caos\">"
  },
  RelicConfig_83512_StoryDesc = {
    Text = "Il Caos è senza forma, il Caos è intangibile; il Caos si è fuso in ogni cosa."
  },
  RelicConfig_83606_BattleDesc = {
    Text = "Limite carte in mano +1. All'inizio del turno, se \"La Scelta del Navigatore\" non è in mano, collocala lì.\nOgni volta che il Leader perde il 10% dei propri PV massimi iniziali, ottieni 1 accumulo di \"Spiega le Vele\", fino a 10 accumuli. \"Spiega le Vele\" potenzia gli effetti di \"Archor Off\".\nOgni volta che perdi il 10% dei tuoi PV massimi iniziali, ottieni 1 accumulo di \"Ormeggio\", fino a 10 accumuli. \"Ormeggio\" potenzia gli effetti di \"Riposo in Porto\"."
  },
  RelicConfig_83606_Desc = {
    Text = "Limite carte in mano +1. All'inizio del turno, se \"La Scelta del Navigatore\" non è in mano, collocala lì.\nOgni volta che il Leader perde il 10% dei propri PV massimi iniziali, ottieni 1 accumulo di \"Spiega le Vele\", fino a 10 accumuli. \"Spiega le Vele\" potenzia gli effetti di \"Archor Off\".\nOgni volta che perdi il 10% dei tuoi PV massimi iniziali, ottieni 1 accumulo di \"Ormeggio\", fino a 10 accumuli. \"Ormeggio\" potenzia gli effetti di \"Riposo in Porto\"."
  },
  RelicConfig_83606_Name = {
    Text = "Guida di Erasmo"
  },
  RelicConfig_83606_StoryDesc = {
    Text = "Il bagliore dei lampi guiderà la direzione da seguire."
  },
  RelicConfig_84112_BattleDesc = {
    Text = "All'inizio del turno, Agrippa ottiene [Arg1] Aliemus. \"Elemosina riluttante\" riduce anche il Costo di Arithmetica di Agrippa di [Arg2] per questo turno, con effetto massimo di una volta per turno."
  },
  RelicConfig_84112_Desc = {
    Text = "All'inizio del turno, Agrippa ottiene [Arg1] Aliemus. \"Elemosina riluttante\" riduce anche il Costo di Arithmetica di Agrippa di [Arg2] per questo turno, con effetto massimo di una volta per turno."
  },
  RelicConfig_84112_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Agrippa>"
  },
  RelicConfig_84113_BattleDesc = {
    Text = "All'inizio del turno, Caraboo ottiene [Arg1] Aliemus. Le carte \"Benedizione\" di Caraboo offrono 1 opzione in più quando vengono <FaxianKeywords:Scoperte>. L'Esaltazione di Caraboo infligge accumuli di Corrosione pari alla quantità di DMG inflitto."
  },
  RelicConfig_84113_Desc = {
    Text = "All'inizio del turno, Caraboo ottiene [Arg1] Aliemus. Le carte \"Benedizione\" di Caraboo offrono 1 opzione in più quando vengono <FaxianKeywords:Scoperte>. L'Esaltazione di Caraboo infligge accumuli di Corrosione pari alla quantità di DMG inflitto."
  },
  RelicConfig_84113_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Caraboo>"
  },
  RelicConfig_84114_BattleDesc = {
    Text = "A inizio turno, Pickman ottiene [Arg1] Aliemus. Per ogni accumulo di \"Creatività\" ottenuto, riduce casualmente di 1 il Costo di Arithmetica di 1 carta In Mano per questo turno. Quando Pickman consuma \"Creatività\", tutti i Risvegliatori ottengono inoltre [Arg2] Aliemus."
  },
  RelicConfig_84114_Desc = {
    Text = "A inizio turno, Pickman ottiene [Arg1] Aliemus. Per ogni accumulo di \"Creatività\" ottenuto, riduce casualmente di 1 il Costo di Arithmetica di 1 carta In Mano per questo turno. Quando Pickman consuma \"Creatività\", tutti i Risvegliatori ottengono inoltre [Arg2] Aliemus."
  },
  RelicConfig_84114_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Pickman>"
  },
  RelicConfig_84116_BattleDesc = {
    Text = "A inizio turno, Erica ottiene [Arg1] Aliemus. Dopo aver giocato [Arg2] Carte di comando in 1 turno, Erica ottiene 2 Arithmetica e raddoppia il bonus di FOR e Allerta per \"Esplosione Elettromagnetica\" in questa battaglia."
  },
  RelicConfig_84116_Desc = {
    Text = "A inizio turno, Erica ottiene [Arg1] Aliemus. Dopo aver giocato [Arg2] Carte di comando in 1 turno, Erica ottiene 2 Arithmetica e raddoppia il bonus di FOR e Allerta per \"Esplosione Elettromagnetica\" in questa battaglia."
  },
  RelicConfig_84116_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Erica>"
  },
  RelicConfig_84117_BattleDesc = {
    Text = "All'inizio del turno, Murphy: Falsonata ottiene [Arg1] Aliemus. \"Valzer di Lemuria\" si attiva 3 volte ogni 3ª giocata."
  },
  RelicConfig_84117_Desc = {
    Text = "All'inizio del turno, Murphy: Falsonata ottiene [Arg1] Aliemus. \"Valzer di Lemuria\" si attiva 3 volte ogni 3ª giocata."
  },
  RelicConfig_84117_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Murphy: Falsonata>"
  },
  RelicConfig_84118_BattleDesc = {
    Text = "A inizio turno, Casiah ottiene [Arg1] Aliemus. Pescare 1 carta conferisce a Casiah [Arg2] Aliemus. Quando Casiah scatena l'Esaltazione, tutti i nemici perdono [Arg3] FOR."
  },
  RelicConfig_84118_Desc = {
    Text = "A inizio turno, Casiah ottiene [Arg1] Aliemus. Pescare 1 carta conferisce a Casiah [Arg2] Aliemus. Quando Casiah scatena l'Esaltazione, tutti i nemici perdono [Arg3] FOR."
  },
  RelicConfig_84118_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Casiah>"
  },
  RelicConfig_84119_BattleDesc = {
    Text = "All'inizio del turno, Murphy ottiene [Arg1] Aliemus. \"Attacco\" e \"Difesa\" di Murphy possono convertire il [Arg2]% del \"Sacrificio\" in Danno tentacolo temporaneo, ma può attivarsi solo una volta per turno."
  },
  RelicConfig_84119_Desc = {
    Text = "All'inizio del turno, Murphy ottiene [Arg1] Aliemus. \"Attacco\" e \"Difesa\" di Murphy possono convertire il [Arg2]% del \"Sacrificio\" in Danno tentacolo temporaneo, ma può attivarsi solo una volta per turno."
  },
  RelicConfig_84119_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Murphy>"
  },
  RelicConfig_84121_BattleDesc = {
    Text = "All'Inizio del turno, Arachne ottiene [Arg1] Aliemus. \"Colpo\" e \"Difesa\" scatenano immediatamente 1 Inseguimento \"Matassa Infinita\", con un massimo di 1 attivazione ciascuno per turno."
  },
  RelicConfig_84121_Desc = {
    Text = "All'Inizio del turno, Arachne ottiene [Arg1] Aliemus. \"Colpo\" e \"Difesa\" scatenano immediatamente 1 Inseguimento \"Matassa Infinita\", con un massimo di 1 attivazione ciascuno per turno."
  },
  RelicConfig_84121_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Jenkin>"
  },
  RelicConfig_84122_BattleDesc = {
    Text = "All'inizio del turno, Tulu ottiene [Arg1] Aliemus. Il Consumo Aliemus di Tulu è ridotto di [Arg2] e, dopo aver rilasciato Esaltazione, genera istantaneamente [Arg3] Tentacoli temporanei."
  },
  RelicConfig_84122_Desc = {
    Text = "All'inizio del turno, Tulu ottiene [Arg1] Aliemus. Il Consumo Aliemus di Tulu è ridotto di [Arg2] e, dopo aver rilasciato Esaltazione, genera istantaneamente [Arg3] Tentacoli temporanei."
  },
  RelicConfig_84122_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Tulu>"
  },
  RelicConfig_84123_BattleDesc = {
    Text = "All'inizio del turno, Pollux ottiene [Arg1] Aliemus. All'inizio della battaglia, ottieni 1 \"Sacro Cuore\". Quando esaurito al suo 3° utilizzo, \"Sacro Cuore\" infligge Vulnerabile a tutti i nemici e infligge danno due volte."
  },
  RelicConfig_84123_Desc = {
    Text = "All'inizio del turno, Pollux ottiene [Arg1] Aliemus. All'inizio della battaglia, ottieni 1 \"Sacro Cuore\". Quando esaurito al suo 3° utilizzo, \"Sacro Cuore\" infligge Vulnerabile a tutti i nemici e infligge danno due volte."
  },
  RelicConfig_84123_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Pollux>"
  },
  RelicConfig_84124_BattleDesc = {
    Text = "All'inizio del turno, Hameln ottiene [Arg1] Aliemus. Il Costo di Arithmetica di \"Ouverture dell'Anima\" è ridotto di [Arg2] e il conteggio di DAN Base è +[Arg3]."
  },
  RelicConfig_84124_Desc = {
    Text = "All'inizio del turno, Hameln ottiene [Arg1] Aliemus. Il Costo di Arithmetica di \"Ouverture dell'Anima\" è ridotto di [Arg2] e il conteggio di DAN Base è +[Arg3]."
  },
  RelicConfig_84124_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Hameln>"
  },
  RelicConfig_84125_BattleDesc = {
    Text = "All'inizio del turno, Kathigu-Ra ottiene [Arg1] Aliemus. Dopo aver accumulato 10 cariche di \"Fiamma\", pesca immediatamente 1 Carta di comando di Kathigu-Ra e le conferisce 3 cariche di \"Fiamma\". Questo effetto non accumulerà cariche per il resto del turno."
  },
  RelicConfig_84125_Desc = {
    Text = "All'inizio del turno, Kathigu-Ra ottiene [Arg1] Aliemus. Dopo aver accumulato 10 cariche di \"Fiamma\", pesca immediatamente 1 Carta di comando di Kathigu-Ra e le conferisce 3 cariche di \"Fiamma\". Questo effetto non accumulerà cariche per il resto del turno."
  },
  RelicConfig_84125_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Kathigu-Ra>"
  },
  RelicConfig_84126_BattleDesc = {
    Text = "A inizio turno, Castor ottiene [Arg1] Aliemus. A inizio battaglia, aggiunge 2 \"Piuma d'Onice\" in mano. Ottieni [Arg2] FOR temporanea dopo aver giocato \"Piuma d'Onice\" per la prima volta ogni turno."
  },
  RelicConfig_84126_Desc = {
    Text = "A inizio turno, Castor ottiene [Arg1] Aliemus. A inizio battaglia, aggiunge 2 \"Piuma d'Onice\" in mano. Ottieni [Arg2] FOR temporanea dopo aver giocato \"Piuma d'Onice\" per la prima volta ogni turno."
  },
  RelicConfig_84126_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Castor>"
  },
  RelicConfig_84127_BattleDesc = {
    Text = "All'inizio del turno, Corposant ottiene [Arg1] Aliemus e ottiene 1 Tentacolo temporaneo. Ogni volta che si attiva la Resistenza alla morte, Corposant ottiene [Arg2] Aliemus e aggiunge alla mano 1 \"Castigo del Fulmine\" con Costo di Arithmetica pari a 0 ed Esaurimento."
  },
  RelicConfig_84127_Desc = {
    Text = "All'inizio del turno, Corposant ottiene [Arg1] Aliemus e ottiene 1 Tentacolo temporaneo. Ogni volta che si attiva la Resistenza alla morte, Corposant ottiene [Arg2] Aliemus e aggiunge alla mano 1 \"Castigo del Fulmine\" con Costo di Arithmetica pari a 0 ed Esaurimento."
  },
  RelicConfig_84127_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Corposant>"
  },
  RelicConfig_89252_BattleDesc = {
    Text = "Limite di Arithmetica aumentato di 1, pesca 1 carta extra per turno e, all'inizio della battaglia, ottieni [Arg1] accumuli di \"Gabbia del Fato\".\nOgni accumulo di \"Gabbia del Fato\" riduce l'Aliemus di tutti i Risvegliati del [Arg2]%, e con ogni rilascio di Esaltazione, riduci di 1 accumulo di \"Gabbia del Fato\". Dopo la rimozione di tutte le \"Gabbie del Fato\", tutti i Risvegliati ottengono [Arg3] Aliemus e acquisiscono \"Cuore Indomito\": Aliemus di tutti i Risvegliati +[Arg4]%, e l'Esaltazione può essere rilasciata due volte per turno."
  },
  RelicConfig_89252_Desc = {
    Text = "Limite di Arithmetica aumentato di 1, pesca 1 carta extra per turno e, all'inizio della battaglia, ottieni [Arg1] accumuli di \"Gabbia del Fato\".\nOgni accumulo di \"Gabbia del Fato\" riduce l'Aliemus di tutti i Risvegliati del [Arg2]%, e con ogni rilascio di Esaltazione, riduci di 1 accumulo di \"Gabbia del Fato\". Dopo la rimozione di tutte le \"Gabbie del Fato\", tutti i Risvegliati ottengono [Arg3] Aliemus e acquisiscono \"Cuore Indomito\": Aliemus di tutti i Risvegliati +[Arg4]%, e l'Esaltazione può essere rilasciata due volte per turno."
  },
  RelicConfig_89252_Name = {
    Text = "Piuma Maledetta"
  },
  RelicConfig_89252_StoryDesc = {
    Text = "Ora, questa piuma non può più librarsi nel cielo."
  },
  RelicConfig_89645_BattleDesc = {
    Text = [[
Limite mano +2, dopo l'Esaltazione, il Danno Finale Temporaneo aumenta del 10%.
Dopo che la carta entra nello Spazio Ultra, 1 "Embrione" in mano si trasforma in "Rampollo della Purezza".
Ogni volta che 1 "Embrione" viene generato, il Costo di Arithmetica di una carta casuale nello Spazio Ultra diminuisce di 1.]]
  },
  RelicConfig_89645_Desc = {
    Text = [[
Limite mano +2, dopo l'Esaltazione, il Danno Finale Temporaneo aumenta del 10%.
Dopo che la carta entra nello Spazio Ultra, 1 "Embrione" in mano si trasforma in "Rampollo della Purezza".
Ogni volta che 1 "Embrione" viene generato, il Costo di Arithmetica di una carta casuale nello Spazio Ultra diminuisce di 1.]]
  },
  RelicConfig_89645_Name = {
    Text = "Siero Ipercorda di Putrefazione Ematica"
  },
  RelicConfig_89646_BattleDesc = {
    Text = [[
Ottieni 250 Keyflare a inizio turno.
Dopo aver usato Risveglio Keyflare, colloca 1 <DerivativeCardKeywords_129:"Bagliore della Chiave d'Argento"> nella mano.
Scoperta di 1 carta Supporto Risvegliatore a inizio turno.]]
  },
  RelicConfig_89646_Desc = {
    Text = [[
Ottieni 250 Keyflare a inizio turno.
Dopo aver usato Risveglio Keyflare, colloca 1 <DerivativeCardKeywords_129:"Bagliore della Chiave d'Argento"> nella mano.
Scoperta di 1 carta Supporto Risvegliatore a inizio turno.]]
  },
  RelicConfig_89646_Name = {
    Text = "Reagente di Evoluzione Unificata"
  },
  RelicConfig_89647_BattleDesc = {
    Text = [[
La prima Carta di comando di ogni turno si attiva 1 volta aggiuntiva.
Genera 1 Tentacolo quando si verifica un Annientamento.
Dopo aver cambiato la posizione del Tentacolo in "Onde Furiose", l'effetto Balzo della prossima Carta di comando si attiva automaticamente e colloca le sue 2 Copie Base nello Spazio Ultra, con un Tempo di Ricarica di 3 turni.]]
  },
  RelicConfig_89647_Desc = {
    Text = [[
La prima Carta di comando di ogni turno si attiva 1 volta aggiuntiva.
Genera 1 Tentacolo quando si verifica un Annientamento.
Dopo aver cambiato la posizione del Tentacolo in "Onde Furiose", l'effetto Balzo della prossima Carta di comando si attiva automaticamente e colloca le sue 2 Copie Base nello Spazio Ultra, con un Tempo di Ricarica di 3 turni.]]
  },
  RelicConfig_89647_Name = {
    Text = "Elisir Abissale dell'Ipercorda"
  },
  RelicConfig_89648_BattleDesc = {
    Text = "Padronanza del Reame aumentata di 200 punti.\nQuando si consuma Fornace Cremisi, aumenta il danno del Tentacolo del 15% della quantità consumata.\nAccumula [Arg3] Fornace Cremisi ogni volta che un Tentacolo attacca."
  },
  RelicConfig_89648_Desc = {
    Text = "Padronanza del Reame aumentata di 200 punti.\nQuando si consuma Fornace Cremisi, aumenta il danno del Tentacolo del 15% della quantità consumata.\nAccumula [Arg3] Fornace Cremisi ogni volta che un Tentacolo attacca."
  },
  RelicConfig_89648_Name = {
    Text = "Siero dell'Abisso di Sangue Marcio"
  },
  RelicConfig_91096_BattleDesc = {
    Text = "All'inizio del turno, entrambe le parti ottengono un accumulo di <Kuangre:Fervore>. Ogni accumulo di <Kuangre:Fervore> fa sì che il Danno attivo e i Danni da tentacolo inflitti causino <BleedingIconKeywords:Sanguinamento> pari al 10% del Danno inflitto. \nPer ogni 20% di Vita del Boss ridotti, tutti i Risvegliatori ottengono 10 Aliemus. \nAll'inizio della battaglia, mischia <DerivativeCardKeywords_108:\"Ispirazione della Prole\"> e <DerivativeCardKeywords_109:\"Protezione della Prole\"> nel Mazzo di Pesca."
  },
  RelicConfig_91096_Desc = {
    Text = "All'inizio del turno, entrambe le parti ottengono un accumulo di <Kuangre:Fervore>. Ogni accumulo di <Kuangre:Fervore> fa sì che il Danno attivo e i Danni da tentacolo inflitti causino <BleedingIconKeywords:Sanguinamento> pari al 10% del Danno inflitto. \nPer ogni 20% di Vita del Boss ridotti, tutti i Risvegliatori ottengono 10 Aliemus. \nAll'inizio della battaglia, mischia <DerivativeCardKeywords_108:\"Ispirazione della Prole\"> e <DerivativeCardKeywords_109:\"Protezione della Prole\"> nel Mazzo di Pesca."
  },
  RelicConfig_91096_Name = {
    Text = "Uovo Pallido"
  },
  RelicConfig_91096_StoryDesc = {
    Text = [[
Pulsa quando il pallido infante sta per nascere.
Attenzione, stanno arrivando.]]
  },
  RelicConfig_94695_BattleDesc = {
    Text = "Dopo che un Risvegliato viene ucciso, gli altri alleati ottengono [Arg1] <StrongEffectKeywords:Amplificazione>. Questo effetto può essere attivato solo una volta per Risvegliato."
  },
  RelicConfig_94695_Desc = {
    Text = "Dopo che un Risvegliato viene ucciso, gli altri alleati ottengono [Arg1] <StrongEffectKeywords:Amplificazione>. Questo effetto può essere attivato solo una volta per Risvegliato."
  },
  RelicConfig_94695_Name = {
    Text = "<OrangeQuality:Brace della Stella Nera>"
  },
  RelicConfig_94696_BattleDesc = {
    Text = "Dopo l'inizio della battaglia, aggiungi [Arg1] <PVPDerivativeCardKeywords_21:Abbraccio Corrosivo> alla mano."
  },
  RelicConfig_94696_Desc = {
    Text = "Dopo l'inizio della battaglia, aggiungi [Arg1] <PVPDerivativeCardKeywords_21:Abbraccio Corrosivo> alla mano."
  },
  RelicConfig_94696_Name = {
    Text = "<OrangeQuality:Iniezione di Vitalità>"
  },
  RelicConfig_94697_BattleDesc = {
    Text = "A fine turno, scarta tutta la tua mano e pesca lo stesso numero di carte."
  },
  RelicConfig_94697_Desc = {
    Text = "A fine turno, scarta tutta la tua mano e pesca lo stesso numero di carte."
  },
  RelicConfig_94697_Name = {
    Text = "<OrangeQuality:Campanella Ammaliatrice>"
  },
  RelicConfig_94698_BattleDesc = {
    Text = "Dopo l'inizio della battaglia, inserisci [Arg1] <PVPDerivativeCardKeywords_22:Colpisci per Ultimo, Colpisci Meglio> e <PVPDerivativeCardKeywords_23:Voci nella Tua Testa> nel Mazzo di Pesca."
  },
  RelicConfig_94698_Desc = {
    Text = "Dopo l'inizio della battaglia, inserisci [Arg1] <PVPDerivativeCardKeywords_22:Colpisci per Ultimo, Colpisci Meglio> e <PVPDerivativeCardKeywords_23:Voci nella Tua Testa> nel Mazzo di Pesca."
  },
  RelicConfig_94698_Name = {
    Text = "<OrangeQuality:Artefatto di Alfonso>"
  },
  RelicConfig_95975_BattleDesc = {
    Text = "Limite mano +1.\nAll'inizio del turno, se non è presente <DerivativeCardKeywords_111:\"Divorare Anime\">, mettilo in mano. Se \"Sazietà\" raggiunge 10, verrà trasformato in <DerivativeCardKeywords_112:\"Risonanza della Memoria\">."
  },
  RelicConfig_95975_Desc = {
    Text = "Limite mano +1.\nAll'inizio del turno, se non è presente \"Divorare Anime\", mettilo in mano. Se \"Sazietà\" raggiunge 10, verrà trasformato in \"Risonanza della Memoria\"."
  },
  RelicConfig_95975_Name = {
    Text = "Calice d'Ossa"
  },
  RelicConfig_95975_StoryDesc = {
    Text = "\"La Luna di Sangue sorge, i cadaveri alzeranno i calici e berranno insieme.\""
  },
  RelicConfig_95976_BattleDesc = {
    Text = "A inizio turno, Doresain ottiene [Arg1] Aliemus e [Arg2] punti di FOR. Quando Doresain consuma una \"Carcassa\", ottiene Forza Temporanea pari al 20% della sua FRZ Permanente."
  },
  RelicConfig_95976_Desc = {
    Text = "A inizio turno, Doresain ottiene [Arg1] Aliemus e [Arg2] punti di FOR. Quando Doresain consuma una \"Carcassa\", ottiene Forza Temporanea pari al 20% della sua FRZ Permanente."
  },
  RelicConfig_95976_Name = {
    Text = "<OrangeQuality:Immagine Dimensionale: Doresain>"
  },
  RelicConfig_96652_BattleDesc = {
    Text = "All'inizio del turno, applica <BurningKeywords2:Bruciatura> a 1 Carta di comando in mano e ottieni 1 accumulo di <Heat:Fiamma Oscura>. Quando <Heat:Fiamma Oscura> raggiunge 3 accumuli, metti 1 <Overload:Combustione Infinita> in mano."
  },
  RelicConfig_96652_Desc = {
    Text = "All'inizio del turno, applica <BurningKeywords2:Bruciatura> a 1 Carta di comando in mano e ottieni 1 accumulo di <Heat:Fiamma Oscura>. Quando <Heat:Fiamma Oscura> raggiunge 3 accumuli, metti 1 <Overload:Combustione Infinita> in mano."
  },
  RelicConfig_96652_Name = {
    Text = "Fiamma Oscura"
  },
  RelicConfig_96652_StoryDesc = {
    Text = "Le fiamme nerissime eseguiranno la sua volontà, riducendo tutto in cenere."
  },
  RelicConfig_97344_BattleDesc = {
    Text = "Pesca 2 carte e ottieni [Arg1] Keyflare quando perdi l'ultima carta in mano. Danno del Tentacolo +[Arg2] ogni volta che il mazzo viene rimescolato."
  },
  RelicConfig_97344_Desc = {
    Text = "Pesca 2 carte e ottieni [Arg1] Keyflare quando perdi l'ultima carta in mano. Danno del Tentacolo +[Arg2] ogni volta che il mazzo viene rimescolato."
  },
  RelicConfig_97344_Name = {
    Text = "Coppa del Campione di Mythag"
  },
  RelicConfig_97344_StoryDesc = {
    Text = "Oggi dimenticheremo il terrore, dimenticheremo il dolore, e ci godremo il carnevale."
  },
  RelicConfig_97345_BattleDesc = {
    Text = "Ogni 3 Carte di comando giocate, ottieni 1 Arithmetica e pesca 1 carta. Ogni istanza di Danno attivo aumenta il Danno Finale Temporaneo del 2%, fino a un massimo del 50%."
  },
  RelicConfig_97345_Desc = {
    Text = "Ogni 3 Carte di comando giocate, ottieni 1 Arithmetica e pesca 1 carta. Ogni istanza di Danno attivo aumenta il Danno Finale Temporaneo del 2%, fino a un massimo del 50%."
  },
  RelicConfig_97345_Name = {
    Text = "Coppa del Campione di Mythag"
  },
  RelicConfig_97345_StoryDesc = {
    Text = "Oggi dimenticheremo il terrore, dimenticheremo il dolore, e ci godremo il carnevale."
  },
  RelicConfig_97346_BattleDesc = {
    Text = "Tasso di Crit. di tutti i Risvegliatori +30%. All'inizio dei turni dispari, tutti i nemici perdono il 25% dei loro PV attuali. Quando la percentuale di PV della tua squadra è inferiore a quella del nemico, Danno Finale +50%; quando la percentuale di PV della tua squadra è superiore a quella del nemico, ottieni 35 Aliemus dopo aver usato Esaltazione."
  },
  RelicConfig_97346_Desc = {
    Text = "Tasso di Crit. di tutti i Risvegliatori +30%. All'inizio dei turni dispari, tutti i nemici perdono il 25% dei loro PV attuali. Quando la percentuale di PV della tua squadra è inferiore a quella del nemico, Danno Finale +50%; quando la percentuale di PV della tua squadra è superiore a quella del nemico, ottieni 35 Aliemus dopo aver usato Esaltazione."
  },
  RelicConfig_97346_Name = {
    Text = "Coppa del Campione di Mythag"
  },
  RelicConfig_97346_StoryDesc = {
    Text = "Oggi dimenticheremo il terrore, dimenticheremo il dolore, e ci godremo il carnevale."
  },
  RelicConfig_97347_BattleDesc = {
    Text = "L'Arithmetica massima aumenta di 2. L'Arithmetica non consumata può essere conservata fino al turno successivo. Se vengono conservate più di 2 Arithmetica, tutti i Risvegliatori ottengono 20 Aliemus all'inizio del turno successivo; se vengono conservate più di 4 Arithmetica, il danno base inflitto nel turno successivo aumenta del 100%."
  },
  RelicConfig_97347_Desc = {
    Text = "L'Arithmetica massima aumenta di 2. L'Arithmetica non consumata può essere conservata fino al turno successivo. Se vengono conservate più di 2 Arithmetica, tutti i Risvegliatori ottengono 20 Aliemus all'inizio del turno successivo; se vengono conservate più di 4 Arithmetica, il danno base inflitto nel turno successivo aumenta del 100%."
  },
  RelicConfig_97347_Name = {
    Text = "Coppa del Campione di Mythag"
  },
  RelicConfig_97347_StoryDesc = {
    Text = "Oggi dimenticheremo il terrore, dimenticheremo il dolore, e ci godremo il carnevale."
  },
  RelicConfig_98274_BattleDesc = {
    Text = [[
Limite Mano +1. Ottieni "<DerivativeCardKeywords_116:Tavolozza>" a inizio battaglia. 
A ogni inizio turno, ottieni 1 "<PrimaryColor:Colore>" e applica casualmente "<ColorInkKeywords:Sovraverniciatura>" a 2 Carte di comando. Giocare una carta "<ColorInkKeywords:Sovraverniciatura>" garantisce 1 "<PrimaryColor:Colore>" in sequenza. 
I "<PrimaryColor:Colore>" giocati verranno registrati sulla "<DerivativeCardKeywords_116:Tavolozza>". Se ci sono 2 "<PrimaryColor:Colore>" diversi registrati sulla "<DerivativeCardKeywords_116:Tavolozza>," fornisce potenziamenti continui. 
Se ci sono 3 "<PrimaryColor:Colore>" diversi registrati sulla "<DerivativeCardKeywords_116:Tavolozza>," infligge immediatamente danni pari al 5% della Salute massima a tutti i nemici e svuota la "<DerivativeCardKeywords_116:Tavolozza>".]]
  },
  RelicConfig_98274_Desc = {
    Text = [[
Limite Mano +1. Ottieni "<DerivativeCardKeywords_116:Tavolozza>" a inizio battaglia. 
A ogni inizio turno, ottieni 1 "<PrimaryColor:Colore>" e applica casualmente "<ColorInkKeywords:Sovraverniciatura>" a 2 Carte di comando. Giocare una carta "<ColorInkKeywords:Sovraverniciatura>" garantisce 1 "<PrimaryColor:Colore>" in sequenza. 
I "<PrimaryColor:Colore>" giocati verranno registrati sulla "<DerivativeCardKeywords_116:Tavolozza>". Se ci sono 2 "<PrimaryColor:Colore>" diversi registrati sulla "<DerivativeCardKeywords_116:Tavolozza>," fornisce potenziamenti continui. 
Se ci sono 3 "<PrimaryColor:Colore>" diversi registrati sulla "<DerivativeCardKeywords_116:Tavolozza>," infligge immediatamente danni pari al 5% della Salute massima a tutti i nemici e svuota la "<DerivativeCardKeywords_116:Tavolozza>".]]
  },
  RelicConfig_98274_Name = {
    Text = "Tavolozza Distorta"
  },
  RelicConfig_98274_StoryDesc = {
    Text = "Nella visuale, assisteremo alla nascita dell'\"arte\"."
  },
  RelicConfig_98367_BattleDesc = {
    Text = "Gli effetti base di tutti i Risvegliatori per la Guarigione dei PV e lo Scudo del Personaggio sono aumentati del [Arg1]%."
  },
  RelicConfig_98367_Desc = {
    Text = "Gli effetti base di tutti i Risvegliatori per la Guarigione dei PV e lo Scudo del Personaggio sono aumentati del [Arg1]%."
  },
  RelicConfig_98367_Name = {
    Text = "<WhiteQuality:Spoglia del serpente>"
  },
  RelicConfig_98367_StoryDesc = {
    Text = "Rinascita dalla Terra attraverso l'automutilazione"
  },
  RelicConfig_98368_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni [Arg1]% di Amplificazione del Danno. Per ogni Carta di comando giocata da un Risveglio diverso, ottieni un ulteriore [Arg1]% di Amplificazione del Danno Temporanea."
  },
  RelicConfig_98368_Desc = {
    Text = "All'inizio della battaglia, ottieni [Arg1]% di Amplificazione del Danno. Per ogni Carta di comando giocata da un Risveglio diverso, ottieni un ulteriore [Arg1]% di Amplificazione del Danno Temporanea."
  },
  RelicConfig_98368_Name = {
    Text = "<OrangeQuality:Caleidoscopio+>"
  },
  RelicConfig_98368_StoryDesc = {
    Text = "Ciò che pensi e vedi non sono che illusioni."
  },
  RelicConfig_98369_BattleDesc = {
    Text = "Dopo aver usato Keyflare Risveglio, concedi Conservare e Preparazione alle [Arg1] carte con l'Arithmetica più alta nella tua mano prima della prossima giocata, e ottieni [Arg2] punti di Keyflare."
  },
  RelicConfig_98369_Desc = {
    Text = "Dopo aver usato Keyflare Risveglio, concedi Conservare e Preparazione alle [Arg1] carte con l'Arithmetica più alta nella tua mano prima della prossima giocata, e ottieni [Arg2] punti di Keyflare."
  },
  RelicConfig_98369_Name = {
    Text = "<WhiteQuality:Album di Francobolli Stranieri>"
  },
  RelicConfig_98369_StoryDesc = {
    Text = "Nostalgia quantificata."
  },
  RelicConfig_98370_BattleDesc = {
    Text = "All'inizio della battaglia, applica [Arg1] Debolezza e Vulnerabile a tutti i nemici. Questo effetto viene attivato anche dopo \"Annientamento\", ma ha un tempo di ricarica di 3 turni."
  },
  RelicConfig_98370_Desc = {
    Text = "La battaglia inizia infliggendo [Arg1] cariche di <WeaknessIconKeywords:Debolezza> e <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici. Questo effetto si attiva anche dopo l'\"Annientamento\", ma ha un tempo di ricarica di 3 turni."
  },
  RelicConfig_98370_Name = {
    Text = "<WhiteQuality:Deflettore spaziale>"
  },
  RelicConfig_98370_StoryDesc = {
    Text = "Lanciati nel vuoto."
  },
  RelicConfig_98371_BattleDesc = {
    Text = "Prima della fine del turno, ogni Risvegliatore a cui appartiene una Carta di comando In Mano ottiene [Arg1] Aliemus."
  },
  RelicConfig_98371_Desc = {
    Text = "Prima della fine del turno, ogni Risvegliatore a cui appartiene una Carta di comando In Mano ottiene [Arg1] Aliemus."
  },
  RelicConfig_98371_Name = {
    Text = "<WhiteQuality:Bilancia squilibrata>"
  },
  RelicConfig_98371_StoryDesc = {
    Text = "Non simboleggia più la giustizia."
  },
  RelicConfig_98372_BattleDesc = {
    Text = "A fine round, se il Keyflare è pieno, consuma [Arg1] Keyflare per aggiungere un <DerivativeCardKeywords_129:\"Bagliore della Chiave d'Argento\"> alla tua mano."
  },
  RelicConfig_98372_Desc = {
    Text = "A fine round, se il Keyflare è pieno, consuma [Arg1] Keyflare per aggiungere un <DerivativeCardKeywords_129:\"Bagliore della Chiave d'Argento\"> alla tua mano."
  },
  RelicConfig_98372_Name = {
    Text = "<WhiteQuality:Nel crepuscolo>"
  },
  RelicConfig_98372_StoryDesc = {
    Text = "Facciamoci una foto insieme! Prova la sensazione del vero dolore."
  },
  RelicConfig_98373_BattleDesc = {
    Text = "Ottieni [Arg1] Keyflare quando \"Esaltazione\" viene rilasciata."
  },
  RelicConfig_98373_Desc = {
    Text = "Ottieni [Arg1] Keyflare quando \"Esaltazione\" viene rilasciata."
  },
  RelicConfig_98373_Name = {
    Text = "<OrangeQuality:Bellezza Fugace+>"
  },
  RelicConfig_98373_StoryDesc = {
    Text = "Preserva per sempre la bellezza degli istanti fugaci."
  },
  RelicConfig_98374_BattleDesc = {
    Text = "Dopo il primo \"Posse\" di ogni turno, applica [Arg1] Veleno a tutti i nemici e ottieni [Arg2] Contatore."
  },
  RelicConfig_98374_Desc = {
    Text = "Dopo la prima \"Compagnia\" di ogni round, applica [Arg1] cariche di <IntoxicationIconKeywords:Veleno> a tutti i nemici e ottieni [Arg2] cariche di <RetaliateIconKeywords:Contatore>."
  },
  RelicConfig_98374_Name = {
    Text = "<OrangeQuality:Lampada del Profeta+>"
  },
  RelicConfig_98374_StoryDesc = {
    Text = "Esaudisci il tuo desiderio."
  },
  RelicConfig_98375_BattleDesc = {
    Text = "A fine round, se il Keyflare è pieno, consuma [Arg1] Keyflare per aggiungere un <DerivativeCardKeywords_67:\"Aurora della Chiave d'Argento\"> alla tua mano."
  },
  RelicConfig_98375_Desc = {
    Text = "A fine round, se il Keyflare è pieno, consuma [Arg1] Keyflare per aggiungere un <DerivativeCardKeywords_67:\"Aurora della Chiave d'Argento\"> alla tua mano."
  },
  RelicConfig_98375_Name = {
    Text = "<OrangeQuality:Nel crepuscolo+>"
  },
  RelicConfig_98375_StoryDesc = {
    Text = "Facciamoci una foto insieme! Prova la sensazione del vero dolore."
  },
  RelicConfig_98376_BattleDesc = {
    Text = "Gli effetti base di tutti i Risvegliatori per la Guarigione dei PV e lo Scudo del Personaggio sono aumentati del [Arg1]%."
  },
  RelicConfig_98376_Desc = {
    Text = "Gli effetti base di tutti i Risvegliatori per la Guarigione dei PV e lo Scudo del Personaggio sono aumentati del [Arg1]%."
  },
  RelicConfig_98376_Name = {
    Text = "<OrangeQuality:Spoglia del serpente+>"
  },
  RelicConfig_98376_StoryDesc = {
    Text = "Rinascita dalla Terra attraverso l'automutilazione"
  },
  RelicConfig_98377_BattleDesc = {
    Text = "Ogni volta che una carta entra nello Spazio Ultra, pesca [Arg1] Carte di comando appartenenti al proprietario di questa carta dal Mazzo di Pesca. Se non è possibile pescare, ottieni una quantità equivalente di Arithmetica. Questo effetto può attivarsi al massimo 2 volte per turno."
  },
  RelicConfig_98377_Desc = {
    Text = "Ogni volta che una carta entra nello Spazio Ultra, pesca [Arg1] Carte di comando appartenenti al proprietario di questa carta dal Mazzo di Pesca. Se non è possibile pescare, ottieni una quantità equivalente di Arithmetica. Questo effetto può attivarsi al massimo 2 volte per turno."
  },
  RelicConfig_98377_Name = {
    Text = "<WhiteQuality:Prisma Trigonale>"
  },
  RelicConfig_98377_StoryDesc = {
    Text = "\"La luce è composta di sette colori.\""
  },
  RelicConfig_98378_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni [Arg1]% Amplificazione del Danno. Dopo aver subito danni, ottieni [Arg2] Contatore, fino a 3 attivazioni per turno."
  },
  RelicConfig_98378_Desc = {
    Text = "Ottieni [Arg1]% Amplificazione del Danno all'inizio della battaglia. Dopo aver subito danni, ottieni [Arg2] <RetaliateIconKeywords:Contatore>, attivabile un massimo di 3 volte per turno."
  },
  RelicConfig_98378_Name = {
    Text = "<OrangeQuality:Uscita di Sicurezza+>"
  },
  RelicConfig_98378_StoryDesc = {
    Text = "A quanto pare, nemmeno lui è riuscito a uscirne."
  },
  RelicConfig_98379_BattleDesc = {
    Text = "Dopo aver inflitto Danno attivo o danno da Tentacolo, aumenta il danno da Tentacolo subito dal bersaglio del [Arg1]% per il resto del turno. Può attivarsi fino a 20 volte per turno."
  },
  RelicConfig_98379_Desc = {
    Text = "Dopo aver inflitto Danno attivo o danno da Tentacolo, aumenta il danno da Tentacolo subito dal bersaglio del [Arg1]% per il resto del turno. Può attivarsi fino a 20 volte per turno."
  },
  RelicConfig_98379_Name = {
    Text = "<WhiteQuality:Elmo da sommozzatore>"
  },
  RelicConfig_98379_StoryDesc = {
    Text = "I sogni sono le stelle e il mare!"
  },
  RelicConfig_98380_BattleDesc = {
    Text = "All'inizio della Battaglia e dopo aver attivato la Resistenza alla Morte, ottieni [Arg1] Keyflare."
  },
  RelicConfig_98380_Desc = {
    Text = "All'inizio della Battaglia e dopo aver attivato la Resistenza alla Morte, ottieni [Arg1] Keyflare."
  },
  RelicConfig_98380_Name = {
    Text = "<WhiteQuality:Reliquia del Passato>"
  },
  RelicConfig_98380_StoryDesc = {
    Text = "Un'offerta presentata un tempo."
  },
  RelicConfig_98381_BattleDesc = {
    Text = "Ripristina [Heal:Arg1] PV e conferisce [Arg2] Keyflare dopo aver usato Keyflare Rouse."
  },
  RelicConfig_98381_Desc = {
    Text = "Ripristina [Heal:Arg1] PV e conferisce [Arg2] Keyflare dopo aver usato Keyflare Rouse."
  },
  RelicConfig_98381_Name = {
    Text = "<WhiteQuality:Parasole del Viaggiatore>"
  },
  RelicConfig_98381_StoryDesc = {
    Text = "Fioritura nella Terra Senza Luce"
  },
  RelicConfig_98382_BattleDesc = {
    Text = "Dopo l'inizio della battaglia, ottieni [Arg1] <ProficientInRealmsIconKeywords:Padronanza del Reame>. All'inizio dei turni dispari, pesca [Arg2] carte. All'inizio dei turni pari, ottieni [Arg2] Arithmetica."
  },
  RelicConfig_98382_Desc = {
    Text = "Dopo l'inizio della battaglia, ottieni [Arg1] <ProficientInRealmsIconKeywords:Padronanza del Reame>. All'inizio dei turni dispari, pesca [Arg2] carte. All'inizio dei turni pari, ottieni [Arg2] Arithmetica."
  },
  RelicConfig_98382_Name = {
    Text = "<OrangeQuality:Disco Solare+>"
  },
  RelicConfig_98382_StoryDesc = {
    Text = "Indovina, è nero o bianco?"
  },
  RelicConfig_98383_BattleDesc = {
    Text = "La prima attivazione di \"Posse\" ogni turno innesca tutti gli Attacchi del tentacolo [Arg1] volte contro i nemici, infliggendo il 50% di Danno."
  },
  RelicConfig_98383_Desc = {
    Text = "La prima attivazione di \"Posse\" ogni turno innesca tutti gli Attacchi del tentacolo [Arg1] volte contro i nemici, infliggendo il 50% di Danno."
  },
  RelicConfig_98383_Name = {
    Text = "<OrangeQuality:Lumachina Gialla+>"
  },
  RelicConfig_98383_StoryDesc = {
    Text = "Questa piccola Lumachina Gialla proviene da nobili origini, con un lignaggio Primordiale perfetto e impeccabile."
  },
  RelicConfig_98384_BattleDesc = {
    Text = "Tutti i Risvegliati infliggono DAN Base aumentato del [Arg1]%. Prima di scatenare l'Esaltazione, aumenta temporaneamente il DAN Base inflitto dal Risvegliato che scatena l'Esaltazione del [Arg2]%."
  },
  RelicConfig_98384_Desc = {
    Text = "Tutti i Risvegliati infliggono DAN Base aumentato del [Arg1]%. Prima di scatenare l'Esaltazione, aumenta temporaneamente il DAN Base inflitto dal Risvegliato che scatena l'Esaltazione del [Arg2]%."
  },
  RelicConfig_98384_Name = {
    Text = "<WhiteQuality:Sangue dei Dimenticati>"
  },
  RelicConfig_98384_StoryDesc = {
    Text = "Si scioglie gradualmente."
  },
  RelicConfig_98385_BattleDesc = {
    Text = "Dopo il primo \"Posse\" di ogni turno, applica [Arg1] Veleno a tutti i nemici e ottieni [Arg2] Contatore."
  },
  RelicConfig_98385_Desc = {
    Text = "Dopo la prima \"Compagnia\" di ogni round, applica [Arg1] cariche di <IntoxicationIconKeywords:Veleno> a tutti i nemici e ottieni [Arg2] cariche di <RetaliateIconKeywords:Contatore>."
  },
  RelicConfig_98385_Name = {
    Text = "<WhiteQuality:Lampada del Profeta>"
  },
  RelicConfig_98385_StoryDesc = {
    Text = "Esaudisci il tuo desiderio."
  },
  RelicConfig_98386_BattleDesc = {
    Text = "All'inizio del turno, se i PV sono inferiori al 50%, Amplificazione del Danno Temporanea +[Arg1]%. Se i PV sono inferiori al 25%, pesca [Arg2] carte aggiuntive e ottieni [Arg2] Arithmetica."
  },
  RelicConfig_98386_Desc = {
    Text = "All'inizio del turno, se i PV sono inferiori al 50%, Amplificazione del Danno Temporanea +[Arg1]%. Se i PV sono inferiori al 25%, pesca [Arg2] carte aggiuntive e ottieni [Arg2] Arithmetica."
  },
  RelicConfig_98386_Name = {
    Text = "<WhiteQuality:Valigetta del dottore>"
  },
  RelicConfig_98386_StoryDesc = {
    Text = "Una valigetta che simboleggia l'identità di un dottore, molto pesante.\nAprirla non garantisce che appartenga a un vero dottore."
  },
  RelicConfig_98387_BattleDesc = {
    Text = "All'inizio della battaglia, applica [Arg1] Debolezza e Vulnerabile a tutti i nemici. Questo effetto viene attivato anche dopo \"Annientamento\", ma ha un tempo di ricarica di 3 turni."
  },
  RelicConfig_98387_Desc = {
    Text = "La battaglia inizia infliggendo [Arg1] cariche di <WeaknessIconKeywords:Debolezza> e <VulnerabilityIconKeywords:Vulnerabile> a tutti i nemici. Questo effetto si attiva anche dopo l'\"Annientamento\", ma ha un tempo di ricarica di 3 turni."
  },
  RelicConfig_98387_Name = {
    Text = "<OrangeQuality:Deflettore spaziale+>"
  },
  RelicConfig_98387_StoryDesc = {
    Text = "Lanciati nel vuoto."
  },
  RelicConfig_98388_BattleDesc = {
    Text = "All'inizio della Battaglia e dopo aver attivato la Resistenza alla Morte, ottieni [Arg1] Keyflare."
  },
  RelicConfig_98388_Desc = {
    Text = "All'inizio della Battaglia e dopo aver attivato la Resistenza alla Morte, ottieni [Arg1] Keyflare."
  },
  RelicConfig_98388_Name = {
    Text = "<OrangeQuality:Reliquia del Passato+>"
  },
  RelicConfig_98388_StoryDesc = {
    Text = "Un'offerta presentata un tempo."
  },
  RelicConfig_98389_BattleDesc = {
    Text = "Dopo l'inizio della battaglia, ottieni [Arg1] <ProficientInRealmsIconKeywords:Padronanza del Reame>. All'inizio dei turni dispari, pesca [Arg2] carte. All'inizio dei turni pari, ottieni [Arg2] Arithmetica."
  },
  RelicConfig_98389_Desc = {
    Text = "Dopo l'inizio della battaglia, ottieni [Arg1] <ProficientInRealmsIconKeywords:Padronanza del Reame>. All'inizio dei turni dispari, pesca [Arg2] carte. All'inizio dei turni pari, ottieni [Arg2] Arithmetica."
  },
  RelicConfig_98389_Name = {
    Text = "<WhiteQuality:Disco Solare>"
  },
  RelicConfig_98389_StoryDesc = {
    Text = "Indovina, è nero o bianco?"
  },
  RelicConfig_98390_BattleDesc = {
    Text = "Ottieni [Arg1] FOR temporanea ogni volta che peschi o scarti una carta, fino a un massimo di 15 volte per turno."
  },
  RelicConfig_98390_Desc = {
    Text = "Pescare o scartare una carta conferisce [Arg1] <PowerIconKeywords:FOR temporanea>, attivabile un massimo di 15 volte per turno."
  },
  RelicConfig_98390_Name = {
    Text = "<WhiteQuality:Preludio Silente>"
  },
  RelicConfig_98390_StoryDesc = {
    Text = "Il violino del celebre violinista Eric Eckstein.\nOra non può più essere suonato."
  },
  RelicConfig_98391_BattleDesc = {
    Text = "La prima \"Compagnia\" di ogni turno concede un aumento del [Arg2]% all'Amplificazione del Danno Temporanea, con l'effetto che scala al diminuire dei PV."
  },
  RelicConfig_98391_Desc = {
    Text = "Il primo \"Posse\" di ogni turno conferisce Amplificazione del Danno Temporanea +[Arg1]%, con effetti più potenti a PV più bassi."
  },
  RelicConfig_98391_Name = {
    Text = "<WhiteQuality:Elisir di Harford>"
  },
  RelicConfig_98391_StoryDesc = {
    Text = [[
Medicina dalla composizione sconosciuta.
Si dice che il rinomato violinista Eric ne sia particolarmente ghiotto.]]
  },
  RelicConfig_98392_BattleDesc = {
    Text = "La prima \"Compagnia\" di ogni turno concede un aumento del [Arg2]% all'Amplificazione del Danno Temporanea, con l'effetto che scala al diminuire dei PV."
  },
  RelicConfig_98392_Desc = {
    Text = "Il primo \"Posse\" di ogni turno conferisce Amplificazione del Danno Temporanea +[Arg1]%, con effetti più potenti a PV più bassi."
  },
  RelicConfig_98392_Name = {
    Text = "<OrangeQuality:Elisir di Harford+>"
  },
  RelicConfig_98392_StoryDesc = {
    Text = [[
Medicina dalla composizione sconosciuta.
Si dice che il rinomato violinista Eric ne sia particolarmente ghiotto.]]
  },
  RelicConfig_98393_BattleDesc = {
    Text = "Tutti i Risvegliati ottengono [Arg1] Keyflare dalla loro prima \"Carta di comando\" di ogni turno."
  },
  RelicConfig_98393_Desc = {
    Text = "Tutti i Risvegliati ottengono [Arg1] Keyflare dalla loro prima \"Carta di comando\" di ogni turno."
  },
  RelicConfig_98393_Name = {
    Text = "<WhiteQuality:Lingua d'Argento>"
  },
  RelicConfig_98393_StoryDesc = {
    Text = "Non solo i mercanti sono eloquenti, ma anche i devoti."
  },
  RelicConfig_98394_BattleDesc = {
    Text = "Il primo \"Posse\" di ogni turno rimborsa il [Arg1]% del Keyflare consumato."
  },
  RelicConfig_98394_Desc = {
    Text = "Il primo \"Posse\" di ogni turno rimborsa il [Arg1]% del Keyflare consumato."
  },
  RelicConfig_98394_Name = {
    Text = "<WhiteQuality:Zampa di Coniglio Fortunata>"
  },
  RelicConfig_98394_StoryDesc = {
    Text = "Non così fortunato per il coniglio."
  },
  RelicConfig_98395_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni [Arg1]% Amplificazione del Danno. Dopo aver inflitto Danno attivo, infliggi [Arg2] Veleno a tutti i nemici, fino a 5 attivazioni per turno."
  },
  RelicConfig_98395_Desc = {
    Text = "Ottieni [Arg1]% Amplificazione del Danno all'inizio della battaglia. Infliggi Danno attivo e applica [Arg2] <IntoxicationIconKeywords:Veleno> a tutti i nemici, attivabile fino a 5 volte per round."
  },
  RelicConfig_98395_Name = {
    Text = "<OrangeQuality:Bastone dell'Ierofante+>"
  },
  RelicConfig_98395_StoryDesc = {
    Text = "Pietà Insanzionata"
  },
  RelicConfig_98396_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni [Arg1]% di Amplificazione del Danno. Per ogni Carta di comando giocata da un Risveglio diverso, ottieni un ulteriore [Arg1]% di Amplificazione del Danno Temporanea."
  },
  RelicConfig_98396_Desc = {
    Text = "All'inizio della battaglia, ottieni [Arg1]% di Amplificazione del Danno. Per ogni Carta di comando giocata da un Risveglio diverso, ottieni un ulteriore [Arg1]% di Amplificazione del Danno Temporanea."
  },
  RelicConfig_98396_Name = {
    Text = "<WhiteQuality:Caleidoscopio>"
  },
  RelicConfig_98396_StoryDesc = {
    Text = "Ciò che pensi e vedi non sono che illusioni."
  },
  RelicConfig_98397_BattleDesc = {
    Text = "Dopo aver rilasciato il secondo \"Posse\" di ogni turno, ottieni [Arg1] Keyflare e tutti i Risvegliatori ottengono [Arg2] Aliemus."
  },
  RelicConfig_98397_Desc = {
    Text = "Dopo aver rilasciato il secondo \"Posse\" di ogni turno, ottieni [Arg1] Keyflare e tutti i Risvegliatori ottengono [Arg2] Aliemus."
  },
  RelicConfig_98397_Name = {
    Text = "<OrangeQuality:Dispositivo Cronometrico+>"
  },
  RelicConfig_98397_StoryDesc = {
    Text = "Una delle invenzioni più sinistre nella storia dell'umanità."
  },
  RelicConfig_98398_BattleDesc = {
    Text = "All'inizio della battaglia, tutti i nemici perdono [Arg1] <ExhaustionIconKeywords:Forza> Temporanea. Utilizzare \"Fornace Cremisi\" attiverà anch'esso questo effetto, con un tempo di recupero di 3 turni."
  },
  RelicConfig_98398_Desc = {
    Text = "All'inizio della battaglia, tutti i nemici perdono [Arg1] <ExhaustionIconKeywords:Forza> Temporanea. Utilizzare \"Fornace Cremisi\" attiverà anch'esso questo effetto, con un tempo di recupero di 3 turni."
  },
  RelicConfig_98398_Name = {
    Text = "<OrangeQuality:Mano Fantasma+>"
  },
  RelicConfig_98398_StoryDesc = {
    Text = "Lo strumento perfetto per uccidere, saccheggiare e graffiare."
  },
  RelicConfig_98399_BattleDesc = {
    Text = "Dopo aver rilasciato il secondo \"Posse\" di ogni turno, ottieni [Arg1] Keyflare e tutti i Risvegliatori ottengono [Arg2] Aliemus."
  },
  RelicConfig_98399_Desc = {
    Text = "Dopo aver rilasciato il secondo \"Posse\" di ogni turno, ottieni [Arg1] Keyflare e tutti i Risvegliatori ottengono [Arg2] Aliemus."
  },
  RelicConfig_98399_Name = {
    Text = "<WhiteQuality:Dispositivo Cronometrico>"
  },
  RelicConfig_98399_StoryDesc = {
    Text = "Una delle invenzioni più sinistre nella storia dell'umanità."
  },
  RelicConfig_98400_BattleDesc = {
    Text = "Ottieni [Arg1] FOR temporanea ogni volta che peschi o scarti una carta, fino a un massimo di 15 volte per turno."
  },
  RelicConfig_98400_Desc = {
    Text = "Pescare o scartare una carta conferisce [Arg1] <PowerIconKeywords:FOR temporanea>, attivabile un massimo di 15 volte per turno."
  },
  RelicConfig_98400_Name = {
    Text = "<OrangeQuality:Preludio Silente+>"
  },
  RelicConfig_98400_StoryDesc = {
    Text = "Il violino del celebre violinista Eric Eckstein.\nOra non può più essere suonato."
  },
  RelicConfig_98401_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni [Arg1]% di Amplificazione del Danno. Ottieni [Arg2] Arithmetica dopo aver ottenuto Contatore per la prima volta in ogni turno."
  },
  RelicConfig_98401_Desc = {
    Text = "All'inizio della Battaglia, ottieni [Arg1]% di Amplificazione del Danno, e ottieni [Arg2] Arithmetica dopo aver ricevuto <RetaliateIconKeywords:Contatore> per la prima volta in ogni turno."
  },
  RelicConfig_98401_Name = {
    Text = "<OrangeQuality:Gazzetta Mattutina di Putney+>"
  },
  RelicConfig_98401_StoryDesc = {
    Text = "Il tuo più premuroso compagno da toilette."
  },
  RelicConfig_98402_BattleDesc = {
    Text = "Dopo aver inflitto Danno attivo o danno da Tentacolo, aumenta il danno da Tentacolo subito dal bersaglio del [Arg1]% per il resto del turno. Può attivarsi fino a 20 volte per turno."
  },
  RelicConfig_98402_Desc = {
    Text = "Dopo aver inflitto Danno attivo o danno da Tentacolo, aumenta il danno da Tentacolo subito dal bersaglio del [Arg1]% per il resto del turno. Può attivarsi fino a 20 volte per turno."
  },
  RelicConfig_98402_Name = {
    Text = "<OrangeQuality:Elmo da sommozzatore+>"
  },
  RelicConfig_98402_StoryDesc = {
    Text = "I sogni sono le stelle e il mare!"
  },
  RelicConfig_98403_BattleDesc = {
    Text = "Ottieni [Arg1] FOR all'inizio della battaglia. Ottieni [Arg2] FOR temporanea ogni volta che viene giocata una carta \"Esaurimento\", fino a 10 attivazioni per turno."
  },
  RelicConfig_98403_Desc = {
    Text = "Ottieni [Arg1] <PowerIconKeywords:FOR> all'inizio della battaglia. Ogni volta che giochi una carta con \"Esaurimento\", ottieni [Arg2] <PowerIconKeywords:FOR> temporanea, attivabile fino a 10 volte per turno."
  },
  RelicConfig_98403_Name = {
    Text = "<OrangeQuality:Piccolo Carillon+>"
  },
  RelicConfig_98403_StoryDesc = {
    Text = "La magione di Dexter custodisce molte collezioni. Prima di rompersi, il piccolo carillon era il giocattolo preferito della signorina Dexter.\nCol passare del tempo, quando la signorina Dexter lo ritrovò, i suoi ingranaggi erano allentati, la melodia stonata, ma continuava ancora a girare."
  },
  RelicConfig_98404_BattleDesc = {
    Text = "Ottieni [Arg1] Keyflare quando \"Esaltazione\" viene rilasciata."
  },
  RelicConfig_98404_Desc = {
    Text = "Ottieni [Arg1] Keyflare quando \"Esaltazione\" viene rilasciata."
  },
  RelicConfig_98404_Name = {
    Text = "<WhiteQuality:Bellezza Fugace>"
  },
  RelicConfig_98404_StoryDesc = {
    Text = "Preserva per sempre la bellezza degli istanti fugaci."
  },
  RelicConfig_98405_BattleDesc = {
    Text = "Tutti i Risvegliati ottengono [Arg1] Keyflare dalla loro prima \"Carta di comando\" di ogni turno."
  },
  RelicConfig_98405_Desc = {
    Text = "Tutti i Risvegliati ottengono [Arg1] Keyflare dalla loro prima \"Carta di comando\" di ogni turno."
  },
  RelicConfig_98405_Name = {
    Text = "<OrangeQuality:Lingua d'Argento+>"
  },
  RelicConfig_98405_StoryDesc = {
    Text = "Non solo i mercanti sono eloquenti, ma anche i devoti."
  },
  RelicConfig_98406_BattleDesc = {
    Text = "Ogni volta che viene generato 1 \"Embrione\", ottieni [Arg1] Fornace Cremisi, fino a 3 volte per turno."
  },
  RelicConfig_98406_Desc = {
    Text = "Ogni volta che viene generato 1 \"Embrione\", ottieni [Arg1] Fornace Cremisi, fino a 3 volte per turno."
  },
  RelicConfig_98406_Name = {
    Text = "<OrangeQuality:Caro Tesoro+>"
  },
  RelicConfig_98406_StoryDesc = {
    Text = "Il falegname costruì per sua moglie un burattino incredibilmente realistico, che avrebbe preso il posto del figlio, riposando nel suo grembo."
  },
  RelicConfig_98407_BattleDesc = {
    Text = "Il primo \"Posse\" di ogni turno rimborsa il [Arg1]% del Keyflare consumato."
  },
  RelicConfig_98407_Desc = {
    Text = "Il primo \"Posse\" di ogni turno rimborsa il [Arg1]% del Keyflare consumato."
  },
  RelicConfig_98407_Name = {
    Text = "<OrangeQuality:Zampa di Coniglio Fortunata+>"
  },
  RelicConfig_98407_StoryDesc = {
    Text = "Non così fortunato per il coniglio."
  },
  RelicConfig_98408_BattleDesc = {
    Text = "All'inizio del turno, tutti i Risvegliati il cui Aliemus è insufficiente per scatenare l'Esaltazione ottengono [Arg1] Aliemus."
  },
  RelicConfig_98408_Desc = {
    Text = "All'inizio del turno, tutti i Risvegliati il cui Aliemus è insufficiente per scatenare l'Esaltazione ottengono [Arg1] Aliemus."
  },
  RelicConfig_98408_Name = {
    Text = "<WhiteQuality:Momento Sorpresa>"
  },
  RelicConfig_98408_StoryDesc = {
    Text = "Goditi il divertimento, ma non mangiarlo."
  },
  RelicConfig_98409_BattleDesc = {
    Text = "All'inizio della battaglia, tutti i nemici perdono [Arg1] <ExhaustionIconKeywords:Forza> Temporanea. Utilizzare \"Fornace Cremisi\" attiverà anch'esso questo effetto, con un tempo di recupero di 3 turni."
  },
  RelicConfig_98409_Desc = {
    Text = "All'inizio della battaglia, tutti i nemici perdono [Arg1] <ExhaustionIconKeywords:Forza> Temporanea. Utilizzare \"Fornace Cremisi\" attiverà anch'esso questo effetto, con un tempo di recupero di 3 turni."
  },
  RelicConfig_98409_Name = {
    Text = "<WhiteQuality:Mano Fantasma>"
  },
  RelicConfig_98409_StoryDesc = {
    Text = "Lo strumento perfetto per uccidere, saccheggiare e graffiare."
  },
  RelicConfig_98410_BattleDesc = {
    Text = "Ogni volta che viene generato 1 \"Embrione\", ottieni [Arg1] Fornace Cremisi, fino a 3 volte per turno."
  },
  RelicConfig_98410_Desc = {
    Text = "Ogni volta che viene generato 1 \"Embrione\", ottieni [Arg1] Fornace Cremisi, fino a 3 volte per turno."
  },
  RelicConfig_98410_Name = {
    Text = "<WhiteQuality:Caro Tesoro>"
  },
  RelicConfig_98410_StoryDesc = {
    Text = "Il falegname costruì per sua moglie un burattino incredibilmente realistico, che avrebbe preso il posto del figlio, riposando nel suo grembo."
  },
  RelicConfig_98411_BattleDesc = {
    Text = "All'inizio del turno, se il Keyflare è superiore a [Arg1], consuma [Arg1] Keyflare per mettere 1 <DerivativeCardKeywords_115:\"Av. Intuizione\"> nella tua mano."
  },
  RelicConfig_98411_Desc = {
    Text = "All'inizio del turno, se il Keyflare è superiore a [Arg1], consuma [Arg1] Keyflare per mettere 1 <DerivativeCardKeywords_115:\"Av. Intuizione\"> nella tua mano."
  },
  RelicConfig_98411_Name = {
    Text = "<RedQuality:Manifestazione dell'Incubo>"
  },
  RelicConfig_98411_StoryDesc = {
    Text = "Attento, un sonno profondo e indulgente divorerà ogni cosa senza che tu te ne accorga."
  },
  RelicConfig_98412_BattleDesc = {
    Text = "Dopo ogni 5 utilizzi di \"Esaltazione\", la successiva [Arg1] Carta Comando Non-Derivata ha effetto 1 volta aggiuntiva."
  },
  RelicConfig_98412_Desc = {
    Text = "Dopo ogni 5 utilizzi di \"Esaltazione\", la successiva [Arg1] Carta Comando Non-Derivata ha effetto 1 volta aggiuntiva."
  },
  RelicConfig_98412_Name = {
    Text = "<OrangeQuality:Birra Stellare+>"
  },
  RelicConfig_98412_StoryDesc = {
    Text = "Vagando tra le stelle."
  },
  RelicConfig_98413_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni [Arg1]% Amplificazione del Danno. Dopo aver subito danni, ottieni [Arg2] Contatore, fino a 3 attivazioni per turno."
  },
  RelicConfig_98413_Desc = {
    Text = "Ottieni [Arg1]% Amplificazione del Danno all'inizio della battaglia. Dopo aver subito danni, ottieni [Arg2] <RetaliateIconKeywords:Contatore>, attivabile un massimo di 3 volte per turno."
  },
  RelicConfig_98413_Name = {
    Text = "<WhiteQuality:Uscita di Sicurezza>"
  },
  RelicConfig_98413_StoryDesc = {
    Text = "A quanto pare, nemmeno lui è riuscito a uscirne."
  },
  RelicConfig_98414_BattleDesc = {
    Text = "Tutti i Risvegliati infliggono DAN Base aumentato del [Arg1]%. Prima di scatenare l'Esaltazione, aumenta temporaneamente il DAN Base inflitto dal Risvegliato che scatena l'Esaltazione del [Arg2]%."
  },
  RelicConfig_98414_Desc = {
    Text = "Tutti i Risvegliati infliggono DAN Base aumentato del [Arg1]%. Prima di scatenare l'Esaltazione, aumenta temporaneamente il DAN Base inflitto dal Risvegliato che scatena l'Esaltazione del [Arg2]%."
  },
  RelicConfig_98414_Name = {
    Text = "<OrangeQuality:Sangue dei Dimenticati+>"
  },
  RelicConfig_98414_StoryDesc = {
    Text = "Si scioglie gradualmente."
  },
  RelicConfig_98415_BattleDesc = {
    Text = "Ripristina [Heal:Arg1] PV e conferisce [Arg2] Keyflare dopo aver usato Keyflare Rouse."
  },
  RelicConfig_98415_Desc = {
    Text = "Ripristina [Heal:Arg1] PV e conferisce [Arg2] Keyflare dopo aver usato Keyflare Rouse."
  },
  RelicConfig_98415_Name = {
    Text = "<OrangeQuality:Parasole del Viaggiatore+>"
  },
  RelicConfig_98415_StoryDesc = {
    Text = "Fioritura nella Terra Senza Luce"
  },
  RelicConfig_98416_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni [Arg1]% di Amplificazione del Danno. Ottieni [Arg2] Arithmetica dopo aver ottenuto Contatore per la prima volta in ogni turno."
  },
  RelicConfig_98416_Desc = {
    Text = "All'inizio della Battaglia, ottieni [Arg1]% di Amplificazione del Danno, e ottieni [Arg2] Arithmetica dopo aver ricevuto <RetaliateIconKeywords:Contatore> per la prima volta in ogni turno."
  },
  RelicConfig_98416_Name = {
    Text = "<WhiteQuality:Gazzetta Mattutina di Putney>"
  },
  RelicConfig_98416_StoryDesc = {
    Text = "Il tuo più premuroso compagno da toilette."
  },
  RelicConfig_98417_BattleDesc = {
    Text = "All'inizio del turno, tutti i Risvegliati il cui Aliemus è insufficiente per scatenare l'Esaltazione ottengono [Arg1] Aliemus."
  },
  RelicConfig_98417_Desc = {
    Text = "All'inizio del turno, tutti i Risvegliati il cui Aliemus è insufficiente per scatenare l'Esaltazione ottengono [Arg1] Aliemus."
  },
  RelicConfig_98417_Name = {
    Text = "<OrangeQuality:Momento Sorpresa+>"
  },
  RelicConfig_98417_StoryDesc = {
    Text = "Goditi il divertimento, ma non mangiarlo."
  },
  RelicConfig_98418_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni [Arg1]% di Amplificazione del Danno. Dopo la prima applicazione di Veleno in ogni turno, pesca [Arg2] carte."
  },
  RelicConfig_98418_Desc = {
    Text = "All'inizio della battaglia, ottieni [Arg1]% di Amplificazione del Danno. Dopo aver applicato <IntoxicationIconKeywords:Veleno> per la prima volta in ogni turno, pesca [Arg2] carte."
  },
  RelicConfig_98418_Name = {
    Text = "<OrangeQuality:Papiro di Rhind+>"
  },
  RelicConfig_98418_StoryDesc = {
    Text = "Ecco la domanda: 10 monaci si dividono 6 pagnotte. Quanto riceve ciascun monaco?"
  },
  RelicConfig_98419_BattleDesc = {
    Text = "Dopo ogni 5 utilizzi di \"Esaltazione\", la successiva [Arg1] Carta Comando Non-Derivata ha effetto 1 volta aggiuntiva."
  },
  RelicConfig_98419_Desc = {
    Text = "Dopo ogni 5 utilizzi di \"Esaltazione\", la successiva [Arg1] Carta Comando Non-Derivata ha effetto 1 volta aggiuntiva."
  },
  RelicConfig_98419_Name = {
    Text = "<WhiteQuality:Birra Stellare>"
  },
  RelicConfig_98419_StoryDesc = {
    Text = "Vagando tra le stelle."
  },
  RelicConfig_98420_BattleDesc = {
    Text = "Ogni volta che una carta entra nello Spazio Ultra, pesca [Arg1] Carte di comando appartenenti al proprietario di questa carta dal Mazzo di Pesca. Se non è possibile pescare, ottieni una quantità equivalente di Arithmetica. Questo effetto può attivarsi al massimo 2 volte per turno."
  },
  RelicConfig_98420_Desc = {
    Text = "Ogni volta che una carta entra nello Spazio Ultra, pesca [Arg1] Carte di comando appartenenti al proprietario di questa carta dal Mazzo di Pesca. Se non è possibile pescare, ottieni una quantità equivalente di Arithmetica. Questo effetto può attivarsi al massimo 2 volte per turno."
  },
  RelicConfig_98420_Name = {
    Text = "<OrangeQuality:Prisma Trigonale+>"
  },
  RelicConfig_98420_StoryDesc = {
    Text = "\"La luce è composta di sette colori.\""
  },
  RelicConfig_98421_BattleDesc = {
    Text = "Dopo aver usato Keyflare Risveglio, concedi Conservare e Preparazione alle [Arg1] carte con l'Arithmetica più alta nella tua mano prima della prossima giocata, e ottieni [Arg2] punti di Keyflare."
  },
  RelicConfig_98421_Desc = {
    Text = "Dopo aver usato Keyflare Risveglio, concedi Conservare e Preparazione alle [Arg1] carte con l'Arithmetica più alta nella tua mano prima della prossima giocata, e ottieni [Arg2] punti di Keyflare."
  },
  RelicConfig_98421_Name = {
    Text = "<OrangeQuality:Album di Francobolli Stranieri+>"
  },
  RelicConfig_98421_StoryDesc = {
    Text = "Nostalgia quantificata."
  },
  RelicConfig_98422_BattleDesc = {
    Text = "Prima della fine del turno, ogni Risvegliatore a cui appartiene una Carta di comando In Mano ottiene [Arg1] Aliemus."
  },
  RelicConfig_98422_Desc = {
    Text = "Prima della fine del turno, ogni Risvegliatore a cui appartiene una Carta di comando In Mano ottiene [Arg1] Aliemus."
  },
  RelicConfig_98422_Name = {
    Text = "<OrangeQuality:Bilancia squilibrata+>"
  },
  RelicConfig_98422_StoryDesc = {
    Text = "Non simboleggia più la giustizia."
  },
  RelicConfig_98423_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni [Arg1]% Amplificazione del Danno. Dopo aver inflitto Danno attivo, infliggi [Arg2] Veleno a tutti i nemici, fino a 5 attivazioni per turno."
  },
  RelicConfig_98423_Desc = {
    Text = "Ottieni [Arg1]% Amplificazione del Danno all'inizio della battaglia. Infliggi Danno attivo e applica [Arg2] <IntoxicationIconKeywords:Veleno> a tutti i nemici, attivabile fino a 5 volte per round."
  },
  RelicConfig_98423_Name = {
    Text = "<WhiteQuality:Bastone dell'Ierofante>"
  },
  RelicConfig_98423_StoryDesc = {
    Text = "Pietà Insanzionata"
  },
  RelicConfig_98424_BattleDesc = {
    Text = "All'inizio della battaglia, ottieni [Arg1]% di Amplificazione del Danno. Dopo la prima applicazione di Veleno in ogni turno, pesca [Arg2] carte."
  },
  RelicConfig_98424_Desc = {
    Text = "All'inizio della battaglia, ottieni [Arg1]% di Amplificazione del Danno. Dopo aver applicato <IntoxicationIconKeywords:Veleno> per la prima volta in ogni turno, pesca [Arg2] carte."
  },
  RelicConfig_98424_Name = {
    Text = "<WhiteQuality:Papiro di Rhind>"
  },
  RelicConfig_98424_StoryDesc = {
    Text = "Ecco la domanda: 10 monaci si dividono 6 pagnotte. Quanto riceve ciascun monaco?"
  },
  RelicConfig_98425_BattleDesc = {
    Text = "Ottieni [Arg1] FOR all'inizio della battaglia. Ottieni [Arg2] FOR temporanea ogni volta che viene giocata una carta \"Esaurimento\", fino a 10 attivazioni per turno."
  },
  RelicConfig_98425_Desc = {
    Text = "Ottieni [Arg1] <PowerIconKeywords:FOR> all'inizio della battaglia. Ogni volta che giochi una carta con \"Esaurimento\", ottieni [Arg2] <PowerIconKeywords:FOR> temporanea, attivabile fino a 10 volte per turno."
  },
  RelicConfig_98425_Name = {
    Text = "<WhiteQuality:Piccolo Carillon>"
  },
  RelicConfig_98425_StoryDesc = {
    Text = "La magione di Dexter custodisce molte collezioni. Prima di rompersi, il piccolo carillon era il giocattolo preferito della signorina Dexter.\nCol passare del tempo, quando la signorina Dexter lo ritrovò, i suoi ingranaggi erano allentati, la melodia stonata, ma continuava ancora a girare."
  },
  RelicConfig_98426_BattleDesc = {
    Text = "La prima attivazione di \"Posse\" ogni turno innesca tutti gli Attacchi del tentacolo [Arg1] volte contro i nemici, infliggendo il 50% di Danno."
  },
  RelicConfig_98426_Desc = {
    Text = "La prima attivazione di \"Posse\" ogni turno innesca tutti gli Attacchi del tentacolo [Arg1] volte contro i nemici, infliggendo il 50% di Danno."
  },
  RelicConfig_98426_Name = {
    Text = "<WhiteQuality:Lumachina Gialla>"
  },
  RelicConfig_98426_StoryDesc = {
    Text = "Questa piccola Lumachina Gialla proviene da nobili origini, con un lignaggio Primordiale perfetto e impeccabile."
  },
  RelicConfig_98427_BattleDesc = {
    Text = "All'inizio del turno, se i PV sono inferiori al 50%, Amplificazione del Danno Temporanea +[Arg1]%. Se i PV sono inferiori al 25%, pesca [Arg2] carte aggiuntive e ottieni [Arg2] Arithmetica."
  },
  RelicConfig_98427_Desc = {
    Text = "All'inizio del turno, se i PV sono inferiori al 50%, Amplificazione del Danno Temporanea +[Arg1]%. Se i PV sono inferiori al 25%, pesca [Arg2] carte aggiuntive e ottieni [Arg2] Arithmetica."
  },
  RelicConfig_98427_Name = {
    Text = "<OrangeQuality:Valigetta del dottore+>"
  },
  RelicConfig_98427_StoryDesc = {
    Text = "Una valigetta che simboleggia l'identità di un dottore, molto pesante.\nAprirla non garantisce che appartenga a un vero dottore."
  },
  RelicConfig_98891_BattleDesc = {
    Text = [[
Dopo l'inizio della battaglia, ottieni 5 accumuli di "<LostWay:Smarrito>", e riduci di 1 accumulo ogni 3 Carte di comando giocate.
Dopo che tutti gli accumuli di "<LostWay:Smarrito>" sono stati rimossi, tutti i Risvegliati ottengono 100 Aliemus. Ogni 3 carte giocate, ripristina [Arg1] PV e applica <Corrosion:Corrosione> pari all'1% dei PV massimi del nemico al nemico in prima fila.]]
  },
  RelicConfig_98891_Desc = {
    Text = [[
Dopo l'inizio della battaglia, ottieni 5 accumuli di "<LostWay:Smarrito>", e riduci di 1 accumulo ogni 3 Carte di comando giocate.
Dopo che tutti gli accumuli di "<LostWay:Smarrito>" sono stati rimossi, tutti i Risvegliati ottengono 100 Aliemus. Ogni 3 carte giocate, ripristina [Arg1] PV e applica <Corrosion:Corrosione> pari all'1% dei PV massimi del nemico al nemico in prima fila.]]
  },
  RelicConfig_98891_Name = {
    Text = "Lampada della Salvezza"
  },
  RelicConfig_98891_StoryDesc = {
    Text = "Per quanto l'esperienza sia fioca, la lanterna della salvezza tornerà infine a risplendere nel cuore della morte."
  }
})
return Text_RelicConfig
