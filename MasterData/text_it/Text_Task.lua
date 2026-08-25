__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Task = readonly({
  Task_100331_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_100331_Name = {Text = "1 vittoria"},
  Task_100332_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_100332_Name = {
    Text = "10 vittorie"
  },
  Task_100333_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_100333_Name = {Text = "6 vittorie"},
  Task_100334_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_100334_Name = {Text = "3 vittorie"},
  Task_100523_Desc = {
    Text = "Completa l'Immersione Psichica \"Dipinto del Mondo Distorto\""
  },
  Task_100523_Name = {
    Text = "Rapsodia di Questo Mondo"
  },
  Task_100576_Desc = {
    Text = "-20 punti per ogni turno impiegato"
  },
  Task_100576_Name = {
    Text = "Clessidra del Tempo<size=20><color=#747474>-20 punti per ogni turno impiegato</color></size>"
  },
  Task_10143_Desc = {
    Text = "Completamento entro 72 turni"
  },
  Task_10143_Name = {
    Text = "Completamento entro 72 turni"
  },
  Task_10144_Desc = {
    Text = "Completamento entro 79 turni"
  },
  Task_10144_Name = {
    Text = "Completamento entro 79 turni"
  },
  Task_10145_Desc = {
    Text = "Completa il livello entro 40 passi."
  },
  Task_10145_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_10146_Desc = {
    Text = "Non avere più di 1 Sintomo al completamento"
  },
  Task_10146_Name = {
    Text = "Mente Limpida"
  },
  Task_10147_Desc = {
    Text = "Non avere più di 1 Sintomo al completamento"
  },
  Task_10147_Name = {
    Text = "Mente Limpida"
  },
  Task_10148_Desc = {
    Text = "Completamento entro 31 turni"
  },
  Task_10148_Name = {
    Text = "Completamento entro 31 turni"
  },
  Task_10149_Desc = {
    Text = "Completamento entro 40 turni"
  },
  Task_10149_Name = {
    Text = "Completamento entro 40 turni"
  },
  Task_10150_Desc = {
    Text = "Completamento entro 47 turni"
  },
  Task_10150_Name = {
    Text = "Completamento entro 47 turni"
  },
  Task_10151_Desc = {
    Text = "Completamento entro 58 turni"
  },
  Task_10151_Name = {
    Text = "Completamento entro 58 turni"
  },
  Task_10152_Desc = {
    Text = "Completamento entro 65 turni"
  },
  Task_10152_Name = {
    Text = "Completamento entro 65 turni"
  },
  Task_10153_Desc = {
    Text = "Elimina i Mostri della Dissoluzione"
  },
  Task_10153_Name = {Text = "Bersaglio"},
  Task_10154_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10154_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10155_Desc = {
    Text = "Supera il livello entro 18 mosse."
  },
  Task_10155_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_10156_Desc = {
    Text = "Non avere più di 3 Sintomi al completamento"
  },
  Task_10156_Name = {
    Text = "Mente Limpida"
  },
  Task_10157_Desc = {
    Text = "Possiedi almeno 100 Sigilli Neri al completamento."
  },
  Task_10157_Name = {
    Text = "Per la Prossima Volta"
  },
  Task_10158_Desc = {
    Text = "Completare il livello con almeno 2 Risvegliatori del Caos"
  },
  Task_10158_Name = {
    Text = "Ascesa nel Caos"
  },
  Task_10159_Desc = {
    Text = "Vinci la Battaglia finale entro 8 turni"
  },
  Task_10159_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10160_Desc = {
    Text = "Possiedi almeno 2 Reliquie al Completamento"
  },
  Task_10160_Name = {
    Text = "Potere delle Reliquie"
  },
  Task_10161_Desc = {
    Text = "Completare il livello con almeno 2 Risvegliatori del Caos"
  },
  Task_10161_Name = {
    Text = "Ascesa nel Caos"
  },
  Task_10162_Desc = {
    Text = "Risveglia tutti i Risvegliatori al completamento"
  },
  Task_10162_Name = {
    Text = "Discesa finale"
  },
  Task_10163_Desc = {
    Text = "Possiedi almeno 4 Reliquie al completamento"
  },
  Task_10163_Name = {
    Text = "Potere delle Reliquie"
  },
  Task_10164_Desc = {
    Text = "Livello completato"
  },
  Task_10164_Name = {
    Text = "Completa il livello"
  },
  Task_10165_Desc = {
    Text = "Raggiungi il Livello di Affinità 5 con 8 Risvegliati"
  },
  Task_10165_Name = {
    Text = "Partner Affiatati IV"
  },
  Task_10166_Desc = {
    Text = "Raggiungi il Livello di Affinità 3 con 12 Risvegliati"
  },
  Task_10166_Name = {
    Text = "Partner Affiatati V"
  },
  Task_10167_Desc = {
    Text = "Completa entro 45 mosse"
  },
  Task_10167_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_10168_Desc = {
    Text = "Completamento entro 17 turni"
  },
  Task_10168_Name = {
    Text = "Completamento entro 17 turni"
  },
  Task_10169_Desc = {
    Text = "Possiedi 20 Risvegliati"
  },
  Task_10169_Name = {
    Text = "Combattere Insieme II"
  },
  Task_10170_Desc = {
    Text = "Possiedi 30 Risvegliati"
  },
  Task_10170_Name = {
    Text = "Combattere Insieme III"
  },
  Task_10171_Desc = {
    Text = "Esegui la Cerimonia di risveglio 300 volte"
  },
  Task_10171_Name = {
    Text = "Custode del genio IV"
  },
  Task_10172_Desc = {
    Text = "Possiedi 10 Risvegliati"
  },
  Task_10172_Name = {
    Text = "Combattere fianco a fianco"
  },
  Task_10173_Desc = {
    Text = "Raggiungi il Livello di Affinità 5 con 4 Risvegliati"
  },
  Task_10173_Name = {
    Text = "Partner Affiatati II"
  },
  Task_10174_Desc = {
    Text = "Recupera il portafoglio"
  },
  Task_10174_Name = {Text = "Bersaglio"},
  Task_10175_Desc = {
    Text = "Possiedi 40 Risvegliati"
  },
  Task_10175_Name = {
    Text = "Combattere Insieme IV"
  },
  Task_10176_Desc = {
    Text = "Raggiungi il Livello di Affinità 3 con 4 Risvegliati"
  },
  Task_10176_Name = {
    Text = "Partner Affiatati"
  },
  Task_10177_Desc = {
    Text = "Completa 400 corse nelle Rovine di Ponape"
  },
  Task_10177_Name = {
    Text = "Benedizione di Pohnpei IV"
  },
  Task_10178_Desc = {
    Text = "Completa 600 corse nelle Rovine di Ponape"
  },
  Task_10178_Name = {
    Text = "Benedizione di Pohnpei V"
  },
  Task_10179_Desc = {
    Text = "Completa 50 Tane dei Vermi"
  },
  Task_10179_Name = {
    Text = "Custode dei Vermi"
  },
  Task_10180_Desc = {
    Text = "Completa 100 corse nella Tana dei Vermi"
  },
  Task_10180_Name = {
    Text = "Custode dei Vermi II"
  },
  Task_10181_Desc = {
    Text = "Completa 200 corse nella Tana dei Vermi"
  },
  Task_10181_Name = {
    Text = "Custode dei Vermi III"
  },
  Task_10182_Desc = {
    Text = "Completa 400 corse nella Tana dei Vermi"
  },
  Task_10182_Name = {
    Text = "Custode dei Vermi IV"
  },
  Task_10183_Desc = {
    Text = "Completa 600 corse nella Tana dei Vermi"
  },
  Task_10183_Name = {
    Text = "Custode dei Vermi V"
  },
  Task_10184_Desc = {
    Text = "Completa il Dominio Arcano 1 volta"
  },
  Task_10184_Name = {
    Text = "Sulla Nascita Occulta"
  },
  Task_10185_Desc = {
    Text = "Completa il Dominio Arcano 10 volte"
  },
  Task_10185_Name = {
    Text = "Sulla Nascita Occulta II"
  },
  Task_10186_Desc = {
    Text = "Completa il Dominio Arcano 25 volte"
  },
  Task_10186_Name = {
    Text = "Sulla Nascita Occulta III"
  },
  Task_10187_Desc = {
    Text = "Completa Evento d'Indagine Capitolo 3 \"Attenti ai segugi\""
  },
  Task_10187_Name = {
    Text = "Germoglio Stellare"
  },
  Task_10188_Desc = {
    Text = "Completa la sfida in massimo 6 battaglie."
  },
  Task_10188_Name = {
    Text = "Colpo Preciso"
  },
  Task_10189_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_10189_Name = {
    Text = "La Sicurezza Prima di Tutto"
  },
  Task_10190_Desc = {
    Text = "Non avere più di 1 Sintomo al completamento"
  },
  Task_10190_Name = {
    Text = "Mente Limpida"
  },
  Task_10191_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10191_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10192_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10192_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10193_Desc = {
    Text = "Trova Jenkin"
  },
  Task_10193_Name = {Text = "Bersaglio"},
  Task_10194_Desc = {
    Text = "Completa Tempra dell'Elisir I"
  },
  Task_10194_Name = {Text = "Compito 3"},
  Task_10195_Desc = {
    Text = "Completa 2 Incarichi"
  },
  Task_10195_Name = {Text = "Compito 2"},
  Task_10196_Desc = {
    Text = "Effettua 40 Risvegli"
  },
  Task_10196_Name = {Text = "Compito 1"},
  Task_10197_Desc = {
    Text = "Potenzia la Risonanza del Capitolo 1 5 volte"
  },
  Task_10197_Name = {Text = "Compito 5"},
  Task_10198_Desc = {
    Text = "Porta 4 Risvegliatori al Liv. 10"
  },
  Task_10198_Name = {Text = "Compito 4"},
  Task_10199_Desc = {
    Text = "Completare il livello con almeno 2 Risvegliatori del Caos"
  },
  Task_10199_Name = {
    Text = "Ascesa nel Caos"
  },
  Task_10200_Desc = {
    Text = "Non avere più di 1 Sintomo al completamento"
  },
  Task_10200_Name = {
    Text = "Mente Limpida"
  },
  Task_10201_Desc = {
    Text = "Fuggi dalla sala macchine"
  },
  Task_10201_Name = {Text = "Bersaglio"},
  Task_10202_Desc = {
    Text = "Possiedi almeno 8 Carte Orazione al completamento"
  },
  Task_10202_Name = {
    Text = "Potere dell'Orazione"
  },
  Task_10203_Desc = {
    Text = "Completare il livello con almeno 2 Risvegliatori del Caos"
  },
  Task_10203_Name = {
    Text = "Ascesa nel Caos"
  },
  Task_10204_Desc = {
    Text = "Procedere verso il sito d'indagine"
  },
  Task_10204_Name = {Text = "Bersaglio"},
  Task_10205_Desc = {
    Text = "Vinci la Battaglia finale entro 8 turni"
  },
  Task_10205_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10206_Desc = {
    Text = "Completare il livello con almeno 2 Risvegliatori del Caos"
  },
  Task_10206_Name = {
    Text = "Ascesa nel Caos"
  },
  Task_10207_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_10207_Name = {
    Text = "La Sicurezza Prima di Tutto"
  },
  Task_10208_Desc = {
    Text = "Completa il livello entro 35 passi"
  },
  Task_10208_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_10209_Desc = {
    Text = "Possiedi almeno 4 Reliquie al completamento"
  },
  Task_10209_Name = {
    Text = "Potere delle Reliquie"
  },
  Task_10210_Desc = {
    Text = "Consuma 180 Menofina"
  },
  Task_10210_Name = {
    Text = "Consuma Menofina"
  },
  Task_10211_Desc = {
    Text = "Liberati dei fanciulli che bloccano il sentiero"
  },
  Task_10211_Name = {Text = "Bersaglio"},
  Task_10212_Desc = {
    Text = "Completa tutti i compiti per riscuotere le ricompense"
  },
  Task_10212_Name = {Text = "Fase I"},
  Task_10213_Desc = {
    Text = "Insegui Daffodil attraverso le dimensioni"
  },
  Task_10213_Name = {Text = "Bersaglio"},
  Task_10215_Desc = {
    Text = "Vinci la Battaglia finale entro 6 turni"
  },
  Task_10215_Name = {
    Text = "Vinci la Battaglia finale entro 6 turni"
  },
  Task_10216_Desc = {
    Text = "Livello completato"
  },
  Task_10216_Name = {
    Text = "Completa il livello"
  },
  Task_10217_Desc = {
    Text = "Vinci la Battaglia finale entro 15 turni con lo Stress inferiore a 500."
  },
  Task_10217_Name = {
    Text = "Vinci la Battaglia finale entro 15 turni con lo Stress inferiore a 500."
  },
  Task_10218_Desc = {
    Text = "Possiedi 4 Risvegliatori di Caro di Livello 20"
  },
  Task_10218_Name = {
    Text = "Signore della Caro II"
  },
  Task_10219_Desc = {
    Text = "Segui Murphy"
  },
  Task_10219_Name = {Text = "Bersaglio"},
  Task_10220_Desc = {
    Text = "Livello completato"
  },
  Task_10220_Name = {
    Text = "Completa il livello"
  },
  Task_10221_Desc = {
    Text = "Livello completato"
  },
  Task_10221_Name = {
    Text = "Completa il livello"
  },
  Task_10222_Desc = {
    Text = "Gioca 50 Carte"
  },
  Task_10223_Desc = {
    Text = "Cercare indizi sul Cacciatore di Teschi"
  },
  Task_10223_Name = {Text = "Bersaglio"},
  Task_10224_Desc = {
    Text = "Livello completato"
  },
  Task_10224_Name = {
    Text = "Completa il livello"
  },
  Task_10226_Desc = {
    Text = "Livello completato"
  },
  Task_10226_Name = {
    Text = "Completa il livello"
  },
  Task_10228_Desc = {
    Text = "Alla ricerca del capitano"
  },
  Task_10228_Name = {Text = "Bersaglio"},
  Task_10229_Desc = {
    Text = "Livello completato"
  },
  Task_10229_Name = {
    Text = "Completa il livello"
  },
  Task_10230_Desc = {
    Text = "Insegui il \"Segugio infernale\""
  },
  Task_10230_Name = {Text = "Bersaglio"},
  Task_10231_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10231_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10232_Desc = {
    Text = "Livello completato"
  },
  Task_10232_Name = {
    Text = "Completa il livello"
  },
  Task_10233_Desc = {
    Text = "Livello completato"
  },
  Task_10233_Name = {
    Text = "Completa il livello"
  },
  Task_10234_Desc = {
    Text = "Livello completato"
  },
  Task_10234_Name = {
    Text = "Completa il livello"
  },
  Task_10235_Desc = {
    Text = "Indaga 60 postimmagini abissali"
  },
  Task_10235_Name = {
    Text = "Rovine di Aequor III"
  },
  Task_10236_Desc = {
    Text = "Indaga 30 postimmagini abissali"
  },
  Task_10236_Name = {
    Text = "Rovine di Aequor II"
  },
  Task_10237_Desc = {
    Text = "Indaga 120 postimmagini torbide"
  },
  Task_10237_Name = {
    Text = "Rovine del Caos IV"
  },
  Task_10238_Desc = {
    Text = "Indaga 60 postimmagini torbide"
  },
  Task_10238_Name = {
    Text = "Rovine del Caos III"
  },
  Task_10239_Desc = {
    Text = "Indaga 15 postimmagini abissali"
  },
  Task_10239_Name = {
    Text = "Rovine di Aequor"
  },
  Task_10240_Desc = {
    Text = "Indaga 240 postimmagini torbide"
  },
  Task_10240_Name = {
    Text = "Rovine del Caos V"
  },
  Task_10241_Desc = {
    Text = "Completa 600 estrazioni di elisir"
  },
  Task_10241_Name = {
    Text = "Farmacologa geniale V"
  },
  Task_10242_Desc = {
    Text = "Completa 400 raffinazioni di pozioni"
  },
  Task_10242_Name = {
    Text = "Farmacologa geniale IV"
  },
  Task_10243_Desc = {
    Text = "Indaga 30 postimmagini torbide"
  },
  Task_10243_Name = {
    Text = "Rovine del Caos II"
  },
  Task_10244_Desc = {
    Text = "Indaga 15 postimmagini torbide"
  },
  Task_10244_Name = {
    Text = "Rovine del Caos"
  },
  Task_10245_Desc = {
    Text = "Proteggi Jenkin"
  },
  Task_10245_Name = {Text = "Bersaglio"},
  Task_10246_Desc = {
    Text = "Ferma il folle aberrato"
  },
  Task_10246_Name = {Text = "Bersaglio"},
  Task_10247_Desc = {
    Text = "Completa tutti i compiti per riscuotere le ricompense"
  },
  Task_10247_Name = {Text = "Fase III"},
  Task_10248_Desc = {
    Text = "Trova un attrezzo per forzare la botola"
  },
  Task_10248_Name = {Text = "Bersaglio"},
  Task_10249_Desc = {
    Text = "Fuggi dal pericolo"
  },
  Task_10249_Name = {Text = "Bersaglio"},
  Task_10250_Desc = {
    Text = "Completare almeno 2 nodi evento diversi entro la fine del livello."
  },
  Task_10250_Name = {
    Text = "Attivazione Nodo"
  },
  Task_10251_Desc = {
    Text = "Completare il livello senza usare l'accampamento per ripristinare i PV."
  },
  Task_10251_Name = {
    Text = "Sfide Speciali"
  },
  Task_10252_Desc = {
    Text = "Conservare almeno il 50% dei PV al completamento della Battaglia finale."
  },
  Task_10252_Name = {
    Text = "PV battaglia finale"
  },
  Task_10253_Desc = {
    Text = "Completa il gioco con almeno 2 Carte Sintomo"
  },
  Task_10253_Name = {
    Text = "Costruzione del Mazzo"
  },
  Task_10254_Desc = {
    Text = "Completa con un massimo di 2 Carte sintomo"
  },
  Task_10254_Name = {
    Text = "Costruzione del Mazzo"
  },
  Task_10255_Desc = {
    Text = "Completa con almeno 30 passi"
  },
  Task_10255_Name = {
    Text = "Pianificazione del Percorso"
  },
  Task_10256_Desc = {
    Text = "Completa entro <25 passi>"
  },
  Task_10256_Name = {
    Text = "Pianificazione del Percorso"
  },
  Task_10258_Desc = {
    Text = "Livello completato"
  },
  Task_10258_Name = {
    Text = "Completa il livello"
  },
  Task_10259_Desc = {
    Text = "Numero di volte in cui uno stato è stato rimosso tramite comando (ad es., effetto Debolezza dissolto con successo due volte)"
  },
  Task_10259_Name = {
    Text = "Effetto di Battaglia"
  },
  Task_10260_Desc = {
    Text = "Numero di volte in cui uno stato è stato aggiunto (ad es., effetto Debolezza aggiunto con successo una volta)"
  },
  Task_10260_Name = {
    Text = "Effetto di Battaglia"
  },
  Task_10265_Desc = {
    Text = "Sconfiggere il Cacciatore di Teschi"
  },
  Task_10265_Name = {Text = "Bersaglio"},
  Task_10266_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_10266_Name = {
    Text = "La Sicurezza Prima di Tutto"
  },
  Task_10267_Desc = {
    Text = "Completa il livello in massimo 3 battaglie."
  },
  Task_10267_Name = {
    Text = "Colpo Preciso"
  },
  Task_10268_Desc = {
    Text = "Possiedi almeno 50 Sigilli Neri al completamento"
  },
  Task_10268_Name = {
    Text = "Per la Prossima Volta"
  },
  Task_10269_Desc = {
    Text = "Non avere più di 1 Sintomo al completamento"
  },
  Task_10269_Name = {
    Text = "Mente Limpida"
  },
  Task_10270_Desc = {
    Text = "Possiedi almeno 8 Carte Orazione al completamento"
  },
  Task_10270_Name = {
    Text = "Potere dell'Orazione"
  },
  Task_10271_Desc = {
    Text = "Completa il livello entro 28 mosse"
  },
  Task_10271_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_10272_Desc = {
    Text = "Completamento del gioco con un totale di 4 o meno Esaltazioni in tutte le Battaglie."
  },
  Task_10272_Name = {
    Text = "Calma ed Eleganza"
  },
  Task_10273_Desc = {
    Text = "Risveglia tutti i Risvegliatori al completamento"
  },
  Task_10273_Name = {
    Text = "Discesa finale"
  },
  Task_10274_Desc = {
    Text = "Possiedi almeno 4 Reliquie al completamento"
  },
  Task_10274_Name = {
    Text = "Potere delle Reliquie"
  },
  Task_10275_Desc = {
    Text = "Completamento entro 73 turni"
  },
  Task_10275_Name = {
    Text = "Completamento entro 73 turni"
  },
  Task_10276_Desc = {
    Text = "Entra nella cabina della nave"
  },
  Task_10276_Name = {Text = "Bersaglio"},
  Task_10277_CompleteCondDesc = {
    Text = "Livello Totale>={s1}"
  },
  Task_10277_Desc = {
    Text = "Stare seduti in biblioteca non ti procurerà altri Risvegliatori.\nEsci, muovi le gambe e cerca quella possibilità su diecimila nella natura."
  },
  Task_10277_Name = {
    Text = "Missione: Traccia di Mithril"
  },
  Task_10278_Desc = {
    Text = "Non avere più di 1 Sintomo al completamento"
  },
  Task_10278_Name = {
    Text = "Mente Limpida"
  },
  Task_10279_Desc = {
    Text = "Completa entro 45 mosse"
  },
  Task_10279_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_10280_Desc = {
    Text = "Completa il livello entro 30 passi"
  },
  Task_10280_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_10281_Desc = {
    Text = "Eleva 1 Risvegliato del Reame Ultra al Grado 2"
  },
  Task_10281_Name = {
    Text = "Maestria Ultra II"
  },
  Task_10282_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_10282_Name = {
    Text = "La Sicurezza Prima di Tutto"
  },
  Task_10283_Desc = {
    Text = "Completa tutti i compiti per riscuotere le ricompense"
  },
  Task_10283_Name = {Text = "Fase V"},
  Task_10284_Desc = {
    Text = "Vinci la Battaglia finale entro 17 turni"
  },
  Task_10284_Name = {
    Text = "Vinci la Battaglia finale entro 17 turni"
  },
  Task_10285_Desc = {
    Text = "Consuma 10000000 Certificati Rosa"
  },
  Task_10285_Name = {
    Text = "Spendaccione V"
  },
  Task_10287_Desc = {
    Text = "Consuma 5000000 Certificati Rosa"
  },
  Task_10287_Name = {
    Text = "Spendaccione IV"
  },
  Task_10288_Desc = {
    Text = "Vinci la Battaglia finale entro 15 turni"
  },
  Task_10288_Name = {
    Text = "Vinci la Battaglia finale entro 15 turni"
  },
  Task_10289_Desc = {
    Text = "Completa il livello in massimo 5 battaglie."
  },
  Task_10289_Name = {
    Text = "Colpo Preciso"
  },
  Task_10290_Desc = {
    Text = "Alla Ricerca del Suono nell'Angolo"
  },
  Task_10290_Name = {Text = "Bersaglio"},
  Task_10292_Desc = {
    Text = "Accesso cumulativo per 90 giorni"
  },
  Task_10292_Name = {
    Text = "Perseveranza"
  },
  Task_10293_Desc = {
    Text = "Accedi per un totale di 60 giorni"
  },
  Task_10293_Name = {
    Text = "Dall'Aldilà"
  },
  Task_10294_Desc = {
    Text = "Completare il livello con almeno 2 Risvegliatori del Caos"
  },
  Task_10294_Name = {
    Text = "Ascesa nel Caos"
  },
  Task_10295_Desc = {
    Text = "Liberati della donna misteriosa"
  },
  Task_10295_Name = {Text = "Bersaglio"},
  Task_10297_Desc = {
    Text = "Completare il livello con almeno 2 Risvegliatori del Caos"
  },
  Task_10297_Name = {
    Text = "Ascesa nel Caos"
  },
  Task_10298_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10298_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10301_Desc = {
    Text = "Elimina il Segugio infernale"
  },
  Task_10301_Name = {Text = "Bersaglio"},
  Task_10302_CompleteCondDesc = {
    Text = "Livello Totale>={s1}"
  },
  Task_10302_Desc = {
    Text = "Il Caos è la legge della natura; l'ordine è un Delirio umano."
  },
  Task_10302_Name = {
    Text = "Ricerca: Pale Hymn"
  },
  Task_10302_UnlockCondDesc = {
    Text = "Si sblocca al Livello Custode 25"
  },
  Task_10303_Desc = {
    Text = "Custode Liv. 35"
  },
  Task_10303_Name = {
    Text = "Prova del Custode IV"
  },
  Task_10305_Desc = {
    Text = "Raggiungi il Livello di Affinità 3 con 8 Risvegliati"
  },
  Task_10305_Name = {
    Text = "Partner Affiatati III"
  },
  Task_10307_Desc = {
    Text = "Completamento Fessura del Caos I"
  },
  Task_10307_Name = {Text = "Compito 5"},
  Task_10308_Desc = {
    Text = "Completa una qualsiasi Sfida Residuo"
  },
  Task_10308_Name = {Text = "Compito 4"},
  Task_10309_Desc = {
    Text = "Completa Caccia ai buoni rosa I"
  },
  Task_10309_Name = {Text = "Compito 3"},
  Task_10310_Desc = {
    Text = "Porta 4 Risvegliatori al Lv. 20"
  },
  Task_10310_Name = {Text = "Compito 2"},
  Task_10311_Desc = {
    Text = "Completa un'\"Immersione Fantasmatica\""
  },
  Task_10311_Name = {Text = "Compito 1"},
  Task_10313_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_10313_Name = {
    Text = "La Sicurezza Prima di Tutto"
  },
  Task_10314_Desc = {
    Text = "Completa il livello entro 30 passi"
  },
  Task_10314_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_10315_Desc = {
    Text = "Risveglia tutti i Risvegliatori al completamento"
  },
  Task_10315_Name = {
    Text = "Discesa finale"
  },
  Task_10316_Desc = {
    Text = "Completare il livello con almeno 2 Risvegliatori del Caos"
  },
  Task_10316_Name = {
    Text = "Ascesa nel Caos"
  },
  Task_10317_Desc = {
    Text = "Non avere più di 3 Sintomi al completamento"
  },
  Task_10317_Name = {
    Text = "Mente Limpida"
  },
  Task_10318_Desc = {
    Text = "Possiedi almeno 3 Reliquie al completamento"
  },
  Task_10318_Name = {
    Text = "Potere delle Reliquie"
  },
  Task_10319_Desc = {
    Text = "Vinci la Battaglia finale entro 8 turni"
  },
  Task_10319_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10320_CompleteCondDesc = {
    Text = "Livello Totale>={s1}"
  },
  Task_10320_Desc = {
    Text = "Non è tutto Oro quel che luccica, ma ha certamente valore. \nLa leggenda narra che Mythag fu fondato da un gruppo isolato di alchimisti le cui ambizioni andavano ben oltre la mera trasmutazione."
  },
  Task_10320_Name = {
    Text = "Ricerca: Formulae Codex"
  },
  Task_10321_Desc = {
    Text = "Completa il livello entro 33 passi"
  },
  Task_10321_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_10322_Desc = {
    Text = "Possiedi almeno 5 Reliquie al completamento"
  },
  Task_10322_Name = {
    Text = "Potere delle Reliquie"
  },
  Task_10323_CompleteCondDesc = {
    Text = "Livello Totale>={s1}"
  },
  Task_10323_Desc = {
    Text = [[
A rigor di termini, anche i Risvegliatori sono una forma di Tecnologia di chip d'argento.
Devi fare del tuo meglio per assicurarti che non restino indietro.]]
  },
  Task_10323_Name = {
    Text = "Ricerca: Brewscript"
  },
  Task_10324_Desc = {
    Text = "Sconfiggi il mostro deforme nell'ufficio del direttore"
  },
  Task_10324_Name = {Text = "Bersaglio"},
  Task_10325_Desc = {
    Text = "Possiedi almeno 2 Reliquie al Completamento"
  },
  Task_10325_Name = {
    Text = "Potere delle Reliquie"
  },
  Task_10326_Desc = {
    Text = "Possiedi almeno 5 Carte Orazione al Completamento"
  },
  Task_10326_Name = {
    Text = "Potere dell'Orazione"
  },
  Task_10327_Desc = {
    Text = "Non avere più di 2 Sintomi al Completamento"
  },
  Task_10327_Name = {
    Text = "Mente Limpida"
  },
  Task_10328_Desc = {
    Text = "Livello completato"
  },
  Task_10328_Name = {
    Text = "Completa il livello"
  },
  Task_10329_Desc = {
    Text = "Livello completato"
  },
  Task_10329_Name = {
    Text = "Completa il livello"
  },
  Task_10330_Desc = {
    Text = "Completa il livello entro 30 passi"
  },
  Task_10330_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_10331_Desc = {
    Text = "Livello completato"
  },
  Task_10331_Name = {
    Text = "Completa il livello"
  },
  Task_10332_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_10332_Name = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_10333_Desc = {
    Text = "Livello completato"
  },
  Task_10333_Name = {
    Text = "Completa il livello"
  },
  Task_10334_Desc = {
    Text = "Potenziamento dell'Abilità del Risvegliatore 3 volte"
  },
  Task_10334_Name = {
    Text = "Appassionato dell'Arena (Inattivo)"
  },
  Task_10335_Desc = {
    Text = "Completa il Reame Senza Luce VIII (Incompiuto)"
  },
  Task_10336_Desc = {
    Text = "Svela i segreti del manicomio"
  },
  Task_10336_Name = {Text = "Bersaglio"},
  Task_10337_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10337_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10338_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10338_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10339_Desc = {
    Text = "Vinci la Battaglia finale entro 7 turni"
  },
  Task_10339_Name = {
    Text = "Vinci la Battaglia finale entro 7 turni"
  },
  Task_10340_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10340_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10341_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10341_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10342_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10342_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10343_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10343_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10344_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10344_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10345_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10345_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10346_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10346_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10347_Desc = {
    Text = "Eleva 1 Risvegliato del Reame Ultra al Grado 3"
  },
  Task_10347_Name = {
    Text = "Maestria Ultra III"
  },
  Task_10348_Desc = {
    Text = "Eleva 1 Risvegliato del Reame Caro al Grado 3"
  },
  Task_10348_Name = {
    Text = "Maestria della Caro III"
  },
  Task_10349_Desc = {
    Text = "Eleva 1 Risvegliato del Reame Aequor al Grado 3"
  },
  Task_10349_Name = {
    Text = "Maestria di Aequor III"
  },
  Task_10350_Desc = {
    Text = "Edificare 1 Risvegliato del Reame del Caos al Grado 3"
  },
  Task_10350_Name = {
    Text = "Padronanza del Caos III"
  },
  Task_10351_Desc = {
    Text = "Livello completato"
  },
  Task_10351_Name = {
    Text = "Completa il livello"
  },
  Task_10352_Desc = {
    Text = "Possiedi 4 Risvegliatori di Caro di Livello 40"
  },
  Task_10352_Name = {
    Text = "Signore della Caro IV"
  },
  Task_10353_Desc = {
    Text = "Livello completato"
  },
  Task_10353_Name = {
    Text = "Completa il livello"
  },
  Task_10354_Desc = {
    Text = "Livello completato"
  },
  Task_10354_Name = {
    Text = "Completa il livello"
  },
  Task_10355_Desc = {
    Text = "Livello completato"
  },
  Task_10355_Name = {
    Text = "Completa il livello"
  },
  Task_10356_Desc = {
    Text = "Raggiungi Aigis"
  },
  Task_10356_Name = {Text = "Bersaglio"},
  Task_10357_Desc = {
    Text = "Livello completato"
  },
  Task_10357_Name = {
    Text = "Completa il livello"
  },
  Task_10358_Desc = {
    Text = "Vinci la Battaglia finale entro 3 turni"
  },
  Task_10358_Name = {
    Text = "Vinci la Battaglia finale entro 3 turni"
  },
  Task_10359_Desc = {
    Text = "Livello completato"
  },
  Task_10359_Name = {
    Text = "Completa il livello"
  },
  Task_10360_Desc = {
    Text = "Livello completato"
  },
  Task_10360_Name = {
    Text = "Completa il livello"
  },
  Task_10361_Desc = {
    Text = "Livello completato"
  },
  Task_10361_Name = {
    Text = "Completa il livello"
  },
  Task_10362_Desc = {
    Text = "Livello completato"
  },
  Task_10362_Name = {
    Text = "Completa il livello"
  },
  Task_10363_Desc = {
    Text = "Livello completato"
  },
  Task_10363_Name = {
    Text = "Completa il livello"
  },
  Task_10364_Desc = {
    Text = "Livello completato"
  },
  Task_10364_Name = {
    Text = "Completa il livello"
  },
  Task_10365_Desc = {
    Text = "Livello completato"
  },
  Task_10365_Name = {
    Text = "Completa il livello"
  },
  Task_10366_Desc = {
    Text = "Livello completato"
  },
  Task_10366_Name = {
    Text = "Completa il livello"
  },
  Task_10367_Desc = {
    Text = "Livello completato"
  },
  Task_10367_Name = {
    Text = "Completa il livello"
  },
  Task_10368_Desc = {
    Text = "Livello completato"
  },
  Task_10368_Name = {
    Text = "Completa il livello"
  },
  Task_10369_Desc = {
    Text = "Livello completato"
  },
  Task_10369_Name = {
    Text = "Completa il livello"
  },
  Task_10370_Desc = {
    Text = "Trova 10 Punti di Estrazione nel Capitolo 2 della storia principale \"@1@2\""
  },
  Task_10370_Desc2 = {
    Text = "Trova 10 Punti di Estrazione nel Capitolo 2 della storia principale \"Eredità di Cera\""
  },
  Task_10370_Name2 = {
    Text = "Sussurro celato II"
  },
  Task_10371_Desc = {
    Text = "Trova 9 Punti di Estrazione nel Capitolo 3 della storia principale \"@1@2\""
  },
  Task_10371_Desc2 = {
    Text = "Trova 9 Punti di Estrazione nel Capitolo 3 della storia principale \"Attenti ai Segugi\""
  },
  Task_10371_Name2 = {
    Text = "Sussurro celato III"
  },
  Task_10372_Desc = {
    Text = "Completa 336 Incarichi"
  },
  Task_10372_Name = {
    Text = "Operazione speciale V"
  },
  Task_10373_Desc = {
    Text = "Trova 8 Punti di Estrazione nella trama principale Capitolo 1 \"L'Enigma del Distretto Est\""
  },
  Task_10373_Name = {
    Text = "Sussurro celato"
  },
  Task_10374_Desc = {
    Text = "Completa 84 Incarichi"
  },
  Task_10374_Name = {
    Text = "Operazione speciale III"
  },
  Task_10375_Desc = {
    Text = "Completa 168 Incarichi"
  },
  Task_10375_Name = {
    Text = "Operazione speciale IV"
  },
  Task_10376_Desc = {
    Text = "Completa 12 Incarichi"
  },
  Task_10376_Name = {
    Text = "Operazione speciale"
  },
  Task_10377_Desc = {
    Text = "Completa 36 Incarichi"
  },
  Task_10377_Name = {
    Text = "Operazione speciale II"
  },
  Task_10378_Desc = {
    Text = "Livello completato"
  },
  Task_10378_Name = {
    Text = "Completa il livello"
  },
  Task_10379_Desc = {
    Text = "Livello completato"
  },
  Task_10379_Name = {
    Text = "Completa il livello"
  },
  Task_10380_Desc = {
    Text = "Livello completato"
  },
  Task_10380_Name = {
    Text = "Completa il livello"
  },
  Task_10381_Desc = {
    Text = "Trova 12 Punti di Estrazione nel Capitolo 4 della storia principale \"@1@2\""
  },
  Task_10381_Desc2 = {
    Text = "Trova 12 Punti di Estrazione nel Capitolo 4 \"Nel Silenzio\" della storia principale."
  },
  Task_10381_Name2 = {
    Text = "Sussurro celato IV"
  },
  Task_10382_Desc = {
    Text = "Possiedi quattro Risvegliatori di Aequor di livello 60"
  },
  Task_10382_Name = {
    Text = "Signore di Aequor VI"
  },
  Task_10384_Desc = {
    Text = "Accumulare almeno 1000 punti Scudo del Personaggio in un turno durante la Battaglia finale."
  },
  Task_10384_Name = {
    Text = "Difesa Eccessiva"
  },
  Task_10385_Desc = {
    Text = "Attraversa il Passaggio della coscienza e traccia Francis"
  },
  Task_10385_Name = {Text = "Bersaglio"},
  Task_10387_Desc = {
    Text = "Elimina il Mutante da Dissoluzione"
  },
  Task_10387_Name = {Text = "Bersaglio"},
  Task_10388_Desc = {
    Text = "Conduci Sarah al seminterrato"
  },
  Task_10388_Name = {Text = "Bersaglio"},
  Task_10390_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10390_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10391_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10391_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10392_Desc = {
    Text = "Fuggi dallo spazio dimensionale e dallo sguardo di \"Lui\""
  },
  Task_10392_Name = {Text = "Bersaglio"},
  Task_10394_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10394_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10395_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10395_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10396_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10396_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10397_Desc = {
    Text = "Risveglia Lily dal suo stordimento"
  },
  Task_10397_Name = {Text = "Bersaglio"},
  Task_10404_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10404_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10405_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10405_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10406_Desc = {
    Text = "Completare il livello con almeno 2 Risvegliatori del Caos"
  },
  Task_10406_Name = {
    Text = "Ascesa nel Caos"
  },
  Task_10407_Desc = {
    Text = "Attraversa la metropolitana oscura"
  },
  Task_10407_Name = {Text = "Bersaglio"},
  Task_10409_Desc = {
    Text = "Fuggi dal manicomio"
  },
  Task_10409_Name = {Text = "Bersaglio"},
  Task_10413_Desc = {
    Text = "Possiedi almeno 4 Reliquie al completamento"
  },
  Task_10413_Name = {
    Text = "Potere delle Reliquie"
  },
  Task_10419_Desc = {
    Text = "Raggiungi Pandia"
  },
  Task_10419_Name = {Text = "Bersaglio"},
  Task_10420_Desc = {
    Text = "Completa l'Evento d'Indagine \"Nel Silenzio\" in modalità Difficile"
  },
  Task_10420_Name = {
    Text = "Mamma, Non Mi Fa Male: Hard"
  },
  Task_10421_Desc = {
    Text = "Vinci la Battaglia finale entro 15 turni"
  },
  Task_10421_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10422_Desc = {
    Text = "Vinci la Battaglia finale entro 8 turni"
  },
  Task_10422_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10423_Desc = {
    Text = "Vinci la Battaglia finale entro 8 turni"
  },
  Task_10423_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10424_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_10424_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10425_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_10425_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10426_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_10426_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10427_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_10427_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10428_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_10428_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10429_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_10429_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10430_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_10430_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10431_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_10431_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10432_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_10432_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10433_Desc = {
    Text = "Completa la sfida in massimo 6 battaglie."
  },
  Task_10433_Name = {
    Text = "Colpo Preciso"
  },
  Task_10434_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_10434_Name = {
    Text = "La Sicurezza Prima di Tutto"
  },
  Task_10435_Desc = {
    Text = "Non avere più di 1 Sintomo al completamento"
  },
  Task_10435_Name = {
    Text = "Mente Limpida"
  },
  Task_10436_Desc = {
    Text = "Ferma il ricercatore"
  },
  Task_10436_Name = {Text = "Bersaglio"},
  Task_10437_Desc = {
    Text = "Entra nel seminterrato"
  },
  Task_10437_Name = {Text = "Bersaglio"},
  Task_10438_Desc = {
    Text = "Completamento entro 24 turni"
  },
  Task_10438_Name = {
    Text = "Completamento entro 24 turni"
  },
  Task_10439_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_10439_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10440_Desc = {
    Text = "Completare il livello con almeno 2 Risvegliatori del Caos"
  },
  Task_10440_Name = {
    Text = "Ascesa nel Caos"
  },
  Task_10441_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10441_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10442_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10442_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10443_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10443_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10444_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10444_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10445_Desc = {
    Text = "Accumula il consumo di 1000 Sigilli Neri"
  },
  Task_10445_Name = {
    Text = "Evocazione Nera III"
  },
  Task_10446_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10446_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10447_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10447_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10448_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10448_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10449_Desc = {
    Text = "Livello completato"
  },
  Task_10449_Name = {
    Text = "Completa il livello"
  },
  Task_10450_Desc = {
    Text = "Livello completato"
  },
  Task_10450_Name = {
    Text = "Completa il livello"
  },
  Task_10451_Desc = {
    Text = "Completa 600 Codici Tabù"
  },
  Task_10451_Name = {
    Text = "Incisore del Patto V"
  },
  Task_10452_Desc = {
    Text = "Completa 400 Codici Tabù"
  },
  Task_10452_Name = {
    Text = "Incisore del Patto IV"
  },
  Task_10453_Desc = {
    Text = "Completa 200 Codici Tabù"
  },
  Task_10453_Name = {
    Text = "Incisore del Patto III"
  },
  Task_10454_Desc = {
    Text = "Attiva l'effetto 6 pezzi del Patto"
  },
  Task_10454_Name = {Text = "Compito 4"},
  Task_10455_Desc = {
    Text = "Completa 50 Codici Tabù"
  },
  Task_10455_Name = {
    Text = "Incisore del Patto"
  },
  Task_10456_Desc = {
    Text = "Completa il Dominio Arcano 50 volte"
  },
  Task_10456_Name = {
    Text = "Sulla Nascita Occulta IV"
  },
  Task_10457_Desc = {
    Text = "Trova Lotan"
  },
  Task_10457_Name = {Text = "Bersaglio"},
  Task_10458_Desc = {
    Text = "Livello completato"
  },
  Task_10458_Name = {
    Text = "Completa il livello"
  },
  Task_10459_Desc = {
    Text = "Livello completato"
  },
  Task_10459_Name = {
    Text = "Completa il livello"
  },
  Task_10460_Desc = {
    Text = "Livello completato"
  },
  Task_10460_Name = {
    Text = "Completa il livello"
  },
  Task_10461_Desc = {
    Text = "Livello completato"
  },
  Task_10461_Name = {
    Text = "Completa il livello"
  },
  Task_10462_Desc = {
    Text = "Livello completato"
  },
  Task_10462_Name = {
    Text = "Completa il livello"
  },
  Task_10463_Desc = {
    Text = "Livello completato"
  },
  Task_10463_Name = {
    Text = "Completa il livello"
  },
  Task_10464_Desc = {
    Text = "Livello completato"
  },
  Task_10464_Name = {
    Text = "Completa il livello"
  },
  Task_10465_Desc = {
    Text = "Livello completato"
  },
  Task_10465_Name = {
    Text = "Completa il livello"
  },
  Task_10466_Desc = {
    Text = "Livello completato"
  },
  Task_10466_Name = {
    Text = "Completa il livello"
  },
  Task_10467_Desc = {
    Text = "Livello completato"
  },
  Task_10467_Name = {
    Text = "Completa il livello"
  },
  Task_10468_Desc = {
    Text = "Livello completato"
  },
  Task_10468_Name = {
    Text = "Completa il livello"
  },
  Task_10469_Desc = {
    Text = "Livello completato"
  },
  Task_10469_Name = {
    Text = "Completa il livello"
  },
  Task_10470_Desc = {
    Text = "Livello completato"
  },
  Task_10470_Name = {
    Text = "Completa il livello"
  },
  Task_10471_Desc = {
    Text = "Livello completato"
  },
  Task_10471_Name = {
    Text = "Completa il livello"
  },
  Task_10472_Desc = {
    Text = "Completa il Capitolo 2 della Storia principale \"Eredità di Cera\""
  },
  Task_10473_CompleteCondDesc = {
    Text = "Livello Totale>={s1}"
  },
  Task_10473_Desc = {
    Text = [[
Si contorcono in una paura che nessuno nota.
Ignoranti, privi di luce, privi di nome.]]
  },
  Task_10473_Name = {
    Text = "Ricerca: Scarlet Rhyme"
  },
  Task_10473_UnlockCondDesc = {
    Text = "Si sblocca al Livello Custode 25"
  },
  Task_10474_Desc = {
    Text = "Livello completato"
  },
  Task_10474_Name = {
    Text = "Completa il livello"
  },
  Task_10475_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10475_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10476_Desc = {
    Text = "Completa 400 ricerche con Biglietti d'Oro"
  },
  Task_10476_Name = {
    Text = "Cercatore d'Oro IV"
  },
  Task_10477_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_10477_Name = {
    Text = "La Sicurezza Prima di Tutto"
  },
  Task_10478_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10478_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10479_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni."
  },
  Task_10479_Name = {
    Text = "Vinci la Battaglia finale entro 10 turni."
  },
  Task_10480_Desc = {
    Text = "Livello completato"
  },
  Task_10480_Name = {
    Text = "Completa il livello"
  },
  Task_10481_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10481_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10482_Desc = {
    Text = "Completa il Capitolo 4 della Storia principale \"Dove regna il silenzio\""
  },
  Task_10483_Desc = {
    Text = "Livello completato"
  },
  Task_10483_Name = {
    Text = "Completa il livello"
  },
  Task_10484_Desc = {
    Text = "Livello completato"
  },
  Task_10484_Name = {
    Text = "Completa il livello"
  },
  Task_10485_Desc = {
    Text = "Livello completato"
  },
  Task_10485_Name = {
    Text = "Completa il livello"
  },
  Task_10486_Desc = {
    Text = "Livello completato"
  },
  Task_10486_Name = {
    Text = "Completa il livello"
  },
  Task_10487_Desc = {
    Text = "Livello completato"
  },
  Task_10487_Name = {
    Text = "Completa il livello"
  },
  Task_10488_Desc = {
    Text = "Livello completato"
  },
  Task_10488_Name = {
    Text = "Completa il livello"
  },
  Task_10489_Desc = {
    Text = "Livello completato"
  },
  Task_10489_Name = {
    Text = "Completa il livello"
  },
  Task_10490_Desc = {
    Text = "Livello completato"
  },
  Task_10490_Name = {
    Text = "Completa il livello"
  },
  Task_10492_Desc = {
    Text = "Livello completato"
  },
  Task_10492_Name = {
    Text = "Completa il livello"
  },
  Task_10493_Desc = {
    Text = "Livello completato"
  },
  Task_10493_Name = {
    Text = "Completa il livello"
  },
  Task_10494_Desc = {
    Text = "Livello completato"
  },
  Task_10494_Name = {
    Text = "Completa il livello"
  },
  Task_10495_Desc = {
    Text = "Livello completato"
  },
  Task_10495_Name = {
    Text = "Completa il livello"
  },
  Task_10496_Desc = {
    Text = "Livello completato"
  },
  Task_10496_Name = {
    Text = "Completa il livello"
  },
  Task_10497_Desc = {
    Text = "Completa 30 Immersioni Fantasmatiche"
  },
  Task_10497_Name = {
    Text = "Sommozzatore Profondo III"
  },
  Task_10498_Desc = {
    Text = "Completa 60 Immersioni Fantasmatiche"
  },
  Task_10498_Name = {
    Text = "Sommozzatore Profondo IV"
  },
  Task_10499_Desc = {
    Text = "Completa 1 Immersione Fantasmatica"
  },
  Task_10499_Name = {
    Text = "Sommozzatore Profondo"
  },
  Task_10500_Desc = {
    Text = "Completa 15 Immersioni Fantasmatiche"
  },
  Task_10500_Name = {
    Text = "Sommozzatore Profondo II"
  },
  Task_10501_Desc = {
    Text = "Infliggi 800 danni"
  },
  Task_10501_Name = {
    Text = "Amplificazione del Danno III"
  },
  Task_10502_Desc = {
    Text = "Infliggi 1000 Danni"
  },
  Task_10502_Name = {
    Text = "Amplificazione del Danno IV"
  },
  Task_10503_Desc = {
    Text = "Infliggi 200 danni"
  },
  Task_10503_Name = {
    Text = "Amplificazione del Danno"
  },
  Task_10504_Desc = {
    Text = "Infliggi 400 danni"
  },
  Task_10504_Name = {
    Text = "Amplificazione del Danno II"
  },
  Task_10505_Desc = {
    Text = "Infliggi 5000 Danni"
  },
  Task_10505_Name = {
    Text = "DAN Fatale V"
  },
  Task_10506_Desc = {
    Text = "Infliggi 500 accumuli di Veleno al nemico"
  },
  Task_10506_Name = {
    Text = "Tossicologo"
  },
  Task_10507_Desc = {
    Text = "Ferma Aigis"
  },
  Task_10507_Name = {Text = "Bersaglio"},
  Task_10510_Desc = {
    Text = "Infliggi 1000 o più punti di Danno in un singolo turno durante battaglie Élite specifiche (X)."
  },
  Task_10510_Name = {
    Text = "Carnevale del Brivido"
  },
  Task_10511_Desc = {
    Text = "Utilizza Esaltazione 5 volte in un singolo turno in una Battaglia specifica di tipo X."
  },
  Task_10511_Name = {
    Text = "Frenesia a Catena"
  },
  Task_10512_Desc = {
    Text = "Utilizza la funzione di recupero dell'accampamento ≤1 volta durante la partita."
  },
  Task_10512_Name = {
    Text = "Rifugio Sicuro"
  },
  Task_10513_Desc = {
    Text = "Al Completamento del Livello, il tasso di esplorazione della mappa dell'accampamento deve essere maggiore o uguale all'80%."
  },
  Task_10513_Name = {
    Text = "Rivelazione stupefacente"
  },
  Task_10514_Desc = {
    Text = "Il numero di Carte di Tipo X è minore o uguale a 3 al Completamento del Livello."
  },
  Task_10514_Name = {
    Text = "Frontiera dell'Immunità"
  },
  Task_10515_Desc = {
    Text = "Al Completamento, il numero di Carte di Tipo X è maggiore o uguale a 3."
  },
  Task_10515_Name = {
    Text = "Condizioni Critiche"
  },
  Task_10516_Desc = {
    Text = "Avere ≥3 Reliquie di tipo specifico X (X Oro)"
  },
  Task_10516_Name = {
    Text = "Cercatore d'Oro"
  },
  Task_10517_Desc = {
    Text = "Al Completamento, possiedi ≥2 tipi di Orazione (Ispirazione e Ispirazione avanzata sono considerati lo stesso tipo)."
  },
  Task_10517_Name = {
    Text = "Collezionista di Orazioni"
  },
  Task_10518_Desc = {
    Text = "Risvegliare almeno 2 Risvegliatori al completamento"
  },
  Task_10518_Name = {
    Text = "Ora del Risveglio"
  },
  Task_10519_Desc = {
    Text = "Completare il livello con almeno 2 Risvegliatori del Caos"
  },
  Task_10519_Name = {
    Text = "Ascesa nel Caos"
  },
  Task_10520_Desc = {
    Text = "Respingi i Devoti del Portatore di Luce all'attacco"
  },
  Task_10520_Name = {Text = "Bersaglio"},
  Task_10521_Desc = {
    Text = "Guadagna tempo per tracciare il cerchio magico"
  },
  Task_10521_Name = {Text = "Bersaglio"},
  Task_10523_Desc = {
    Text = "Potenzia una qualsiasi Abilità di un Risvegliatore al Lv. 3"
  },
  Task_10523_Name = {Text = "Compito 2"},
  Task_10524_Desc = {
    Text = "Completamento Storia Principale: Difficile 1-8"
  },
  Task_10524_Name = {Text = "Compito 3"},
  Task_10525_Desc = {
    Text = "Porta 4 Risvegliatori al Lv. 40"
  },
  Task_10525_Name = {Text = "Compito 1"},
  Task_10526_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10526_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10527_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10527_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10528_Desc = {
    Text = "Completa 100 raffinazioni di elisir"
  },
  Task_10528_Name = {
    Text = "Farmacologa geniale II"
  },
  Task_10529_Desc = {
    Text = "Supera Dominio del Caos: Fessura VI"
  },
  Task_10529_Name = {Text = "Compito 5"},
  Task_10530_Desc = {
    Text = "Battaglia finale con Helot"
  },
  Task_10530_Name = {Text = "Bersaglio"},
  Task_10531_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10531_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10532_Desc = {
    Text = "Completa 200 Ricerche con Biglietto d'Oro"
  },
  Task_10532_Name = {
    Text = "Cercatore d'Oro III"
  },
  Task_10533_Desc = {
    Text = "Assisti Doll nel respingere i Devoti del Portatore di Luce"
  },
  Task_10533_Name = {Text = "Bersaglio"},
  Task_10534_Desc = {
    Text = "Completa 50 Ricerche con Biglietto d'Oro"
  },
  Task_10534_Name = {
    Text = "Cercatore d'Oro"
  },
  Task_10535_Desc = {
    Text = "Completa 100 Indagini con Voucher d'Oro"
  },
  Task_10535_Name = {
    Text = "Cercatore d'Oro II"
  },
  Task_10536_Desc = {
    Text = "Livello completato"
  },
  Task_10536_Name = {
    Text = "Completa il livello"
  },
  Task_10537_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10537_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10538_CompleteCondDesc = {
    Text = "Livello Totale>={s1}"
  },
  Task_10538_Desc = {
    Text = "A volte, l'impulso di Distruggere è l'impulso di creare.\nImpugna il pennello; l'arte non richiede preparazione."
  },
  Task_10538_Name = {
    Text = "Missione: Dadaismo"
  },
  Task_10538_UnlockCondDesc = {
    Text = "Si sblocca al completamento della Storia principale 1-13"
  },
  Task_10539_Desc = {
    Text = "Completa tutti i compiti per riscuotere le ricompense"
  },
  Task_10539_Name = {Text = "Fase II"},
  Task_10540_Desc = {
    Text = "Completamento Storia Principale Capitolo 1 \"L'enigma del Distretto Est\": Modalità Difficile"
  },
  Task_10544_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10544_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10545_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10545_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10546_Desc = {
    Text = "Accesso cumulativo per 2 giorni"
  },
  Task_10546_Name = {
    Text = "Ciao, Custode"
  },
  Task_10547_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10547_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10548_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10548_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10549_Desc = {
    Text = "Completamento Fessura del Caos I"
  },
  Task_10550_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10550_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10552_Desc = {
    Text = "Possiedi almeno 2 Reliquie al Completamento"
  },
  Task_10552_Name = {
    Text = "Potere delle Reliquie"
  },
  Task_10553_Desc = {
    Text = "Possiedi almeno 5 Carte Orazione al Completamento"
  },
  Task_10553_Name = {
    Text = "Potere dell'Orazione"
  },
  Task_10554_Desc = {
    Text = "Non avere più di 2 Sintomi al Completamento"
  },
  Task_10554_Name = {
    Text = "Mente Limpida"
  },
  Task_10555_Desc = {
    Text = "Completa tutte le missioni di questo capitolo per ottenere le ricompense."
  },
  Task_10555_Name = {
    Text = "Padronanza del Reame III"
  },
  Task_10556_Desc = {
    Text = "Completa il livello entro 33 passi"
  },
  Task_10556_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_10557_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10557_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10558_Desc = {
    Text = "Completa il livello in massimo 5 battaglie."
  },
  Task_10558_Name = {
    Text = "Colpo Preciso"
  },
  Task_10565_CompleteCondDesc = {
    Text = "Livello Totale>={s1}"
  },
  Task_10565_Desc = {
    Text = "I suoi istinti, la ragione e il cuore sono sigillati in una piccola bottiglia di vetro.\nIl mondo non è più affar suo."
  },
  Task_10565_Name = {
    Text = "Missione: Dissociazione"
  },
  Task_10565_UnlockCondDesc = {
    Text = "Si sblocca al completamento della Storia principale 1-13"
  },
  Task_10571_Desc = {
    Text = "Esegui la Cerimonia di risveglio 150 volte"
  },
  Task_10571_Name = {
    Text = "Custode del genio III"
  },
  Task_10572_Desc = {
    Text = "Esegui la Cerimonia di risveglio 100 volte"
  },
  Task_10572_Name = {
    Text = "Custode del genio II"
  },
  Task_10575_Desc = {
    Text = "Edificare 1 Risvegliato del Reame di Caro al Grado 5"
  },
  Task_10575_Name = {
    Text = "Maestria della Caro V"
  },
  Task_10576_Desc = {
    Text = "Edificare 1 Risvegliato del Reame di Aequor al Grado 5"
  },
  Task_10576_Name = {
    Text = "Maestria di Aequor V"
  },
  Task_10577_Desc = {
    Text = "Esegui la Cerimonia di risveglio 50 volte"
  },
  Task_10577_Name = {
    Text = "Custode del genio"
  },
  Task_10578_Desc = {
    Text = "Edificare 1 Risvegliato del Reame Ultra al Grado 5"
  },
  Task_10578_Name = {
    Text = "Maestria Ultra V"
  },
  Task_10579_Desc = {
    Text = "Possiedi 12 Patti di Livello 9"
  },
  Task_10579_Name = {
    Text = "Collezionista di Patti II"
  },
  Task_10580_Desc = {
    Text = "Possiedi 6 Patti di Livello 6"
  },
  Task_10580_Name = {
    Text = "Collezionista di Patti"
  },
  Task_10581_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10581_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10582_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10582_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10583_Desc = {
    Text = "Segui le tracce residue di Francis"
  },
  Task_10583_Name = {Text = "Bersaglio"},
  Task_10584_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10584_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10585_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10585_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10586_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10586_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10587_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10587_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10588_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10588_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10589_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10589_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10590_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10590_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10591_Desc = {
    Text = "Non avere più di 3 Sintomi al completamento"
  },
  Task_10591_Name = {
    Text = "Mente Limpida"
  },
  Task_10592_Desc = {
    Text = "Rientra al Sanatorio Rye"
  },
  Task_10592_Name = {Text = "Bersaglio"},
  Task_10593_Desc = {
    Text = "Vinci la Battaglia finale entro 15 turni"
  },
  Task_10593_Name = {
    Text = "Vinci la Battaglia finale entro 15 turni"
  },
  Task_10595_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10595_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10596_Desc = {
    Text = "Fuggi dal campo di neve"
  },
  Task_10596_Name = {Text = "Bersaglio"},
  Task_10597_Desc = {
    Text = "Esegui 3 Incarichi"
  },
  Task_10597_Name = {
    Text = "Completa gli Incarichi"
  },
  Task_10598_Desc = {
    Text = "Completamento entro 38 turni"
  },
  Task_10598_Name = {
    Text = "Completamento entro 38 turni"
  },
  Task_10599_Desc = {
    Text = "Consuma 2500000 Certificati Rosa"
  },
  Task_10599_Name = {
    Text = "Spendaccione III"
  },
  Task_10600_Desc = {
    Text = "Accedi al gioco"
  },
  Task_10600_Name = {
    Text = "Accedi al gioco"
  },
  Task_10601_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10601_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10602_Desc = {
    Text = "Livello completato"
  },
  Task_10602_Name = {
    Text = "Completa il livello"
  },
  Task_10603_Desc = {
    Text = "Risveglia tutti i Risvegliatori al completamento"
  },
  Task_10603_Name = {
    Text = "Discesa finale"
  },
  Task_10604_Desc = {
    Text = "Possiedi almeno 4 Reliquie al completamento"
  },
  Task_10604_Name = {
    Text = "Potere delle Reliquie"
  },
  Task_10605_Desc = {
    Text = "Livello completato"
  },
  Task_10605_Name = {
    Text = "Completa il livello"
  },
  Task_10606_Desc = {
    Text = "Non avere più di 1 Sintomo al completamento"
  },
  Task_10606_Name = {
    Text = "Mente Limpida"
  },
  Task_10607_Desc = {
    Text = "Possiedi almeno 8 Carte Orazione al completamento"
  },
  Task_10607_Name = {
    Text = "Potere dell'Orazione"
  },
  Task_10608_Desc = {
    Text = "Custode Liv. 25"
  },
  Task_10608_Name = {
    Text = "Prova del Custode III"
  },
  Task_10609_Desc = {
    Text = "Completamento del gioco con un totale di 4 o meno Esaltazioni in tutte le Battaglie."
  },
  Task_10609_Name = {
    Text = "Calma ed Eleganza"
  },
  Task_10610_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10610_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10611_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_10611_Name = {
    Text = "La Sicurezza Prima di Tutto"
  },
  Task_10612_Desc = {
    Text = "Completa il livello in massimo 3 battaglie."
  },
  Task_10612_Name = {
    Text = "Colpo Preciso"
  },
  Task_10613_Desc = {
    Text = "Possiedi almeno 50 Sigilli Neri al completamento"
  },
  Task_10613_Name = {
    Text = "Per la Prossima Volta"
  },
  Task_10614_Desc = {
    Text = "Raggiungi il Livello di Affinità 3 con 16 Risvegliati"
  },
  Task_10614_Name = {
    Text = "Partner Affiatati VII"
  },
  Task_10616_Desc = {
    Text = "Possiedi quattro Risvegliatori di Aequor di livello 40"
  },
  Task_10616_Name = {
    Text = "Signore di Aequor IV"
  },
  Task_10618_Desc = {
    Text = "Completamento entro 48 turni"
  },
  Task_10618_Name = {
    Text = "Completamento entro 48 turni"
  },
  Task_10619_Desc = {
    Text = "Completamento entro 53 turni"
  },
  Task_10619_Name = {
    Text = "Completamento entro 53 turni"
  },
  Task_10620_Desc = {
    Text = "Indaga 30 Residui Dimensionali"
  },
  Task_10620_Name = {
    Text = "Rovine dell'Ultra II"
  },
  Task_10621_Desc = {
    Text = "Indaga 60 Residui Dimensionali"
  },
  Task_10621_Name = {
    Text = "Rovine dell'Ultra III"
  },
  Task_10622_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10622_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10623_Desc = {
    Text = "Indaga 15 Residui Dimensionali"
  },
  Task_10623_Name = {
    Text = "Rovine dell'Ultra"
  },
  Task_10624_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10624_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10625_Desc = {
    Text = "Indaga 120 casi di immagini residue strutturali"
  },
  Task_10625_Name = {
    Text = "Rovine della Caro IV"
  },
  Task_10626_Desc = {
    Text = "Indaga 15 postimmagini organiche"
  },
  Task_10626_Name = {
    Text = "Rovine della Caro"
  },
  Task_10627_Desc = {
    Text = "Indaga 30 casi di immagini residue strutturali"
  },
  Task_10627_Name = {
    Text = "Rovine della Caro II"
  },
  Task_10628_Desc = {
    Text = "Completa la sfida in massimo 6 battaglie."
  },
  Task_10628_Name = {
    Text = "Colpo Preciso"
  },
  Task_10629_Desc = {
    Text = "Indaga 240 postimmagini abissali"
  },
  Task_10629_Name = {
    Text = "Rovine di Aequor V"
  },
  Task_10630_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10630_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10631_Desc = {
    Text = "Nella Battaglia specifica X (Normale), uccidi 3 o più mostri in un singolo turno."
  },
  Task_10631_Name = {
    Text = "Ora della Caccia"
  },
  Task_10632_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10632_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10633_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10633_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10634_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10634_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10635_Desc = {
    Text = "Possiedi almeno 5 Reliquie al completamento"
  },
  Task_10635_Name = {
    Text = "Potere delle Reliquie"
  },
  Task_10636_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10636_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10637_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10637_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10638_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10638_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10639_Desc = {
    Text = "Completa tutti i compiti per riscuotere le ricompense"
  },
  Task_10639_Name = {Text = "Fase IV"},
  Task_10640_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10640_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10641_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10641_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10642_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10642_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10643_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10643_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10644_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10644_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10645_Desc = {
    Text = "Edificare 1 Risvegliato del Reame Ultra al Grado 1"
  },
  Task_10645_Name = {
    Text = "Maestria Ultra I"
  },
  Task_10646_Desc = {
    Text = "Livello completato"
  },
  Task_10646_Name = {
    Text = "Completa il livello"
  },
  Task_10647_Desc = {
    Text = "Edificare 1 Risvegliato del Reame del Caos al Grado 1"
  },
  Task_10647_Name = {
    Text = "Padronanza del Caos I"
  },
  Task_10648_Desc = {
    Text = "Edificare 1 Risvegliato del Reame di Caro al Grado 1"
  },
  Task_10648_Name = {
    Text = "Maestria della Caro I"
  },
  Task_10649_Desc = {
    Text = "Edificare 1 Risvegliato del Reame di Aequor al Grado 1"
  },
  Task_10649_Name = {
    Text = "Maestria di Aequor I"
  },
  Task_10650_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_10650_Name = {
    Text = "La Sicurezza Prima di Tutto"
  },
  Task_10651_Desc = {
    Text = "Livello completato"
  },
  Task_10651_Name = {
    Text = "Completa il livello"
  },
  Task_10652_Desc = {
    Text = "Completa l'evento d'indagine \"@1@2\""
  },
  Task_10652_Desc2 = {
    Text = "Completa l'Evento d'Indagine \"Eredità di Cera\""
  },
  Task_10652_Name2 = {
    Text = "Enigmi nella Cera"
  },
  Task_10653_Desc = {
    Text = "Risuona 3 volte nell'Evento d'Indagine \"L'Enigma del Distretto Est\""
  },
  Task_10653_Name = {
    Text = "Eco di Gratitudine"
  },
  Task_10654_Desc = {
    Text = "Accesso cumulativo per 30 giorni"
  },
  Task_10654_Name = {
    Text = "L'attivista"
  },
  Task_10656_Desc = {
    Text = "Completa il Reame Senza Luce VII (Incompiuto)"
  },
  Task_10656_Name = {
    Text = "La Scultrice"
  },
  Task_10658_Desc = {
    Text = "30 pti per battaglia"
  },
  Task_10658_Name = {
    Text = "Battaglia Vinta <size=20><color=#747474>30 punti per battaglia</color></size>"
  },
  Task_10660_Desc = {Text = "Squeak"},
  Task_10660_Name = {Text = "Squeak"},
  Task_10661_Desc = {
    Text = "Livello completato"
  },
  Task_10661_Name = {
    Text = "Completa il livello"
  },
  Task_10663_Desc = {
    Text = "Accesso × 7 giorni"
  },
  Task_10663_Name = {
    Text = "Il Mattiniero"
  },
  Task_10664_Desc = {
    Text = "Completa il livello in meno di 50 mosse"
  },
  Task_10664_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_10665_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_10665_Name = {
    Text = "La Sicurezza Prima di Tutto"
  },
  Task_10666_Desc = {
    Text = "Completa il livello in massimo 7 battaglie."
  },
  Task_10666_Name = {
    Text = "Colpo Preciso"
  },
  Task_10667_Desc = {
    Text = "Porta 4 Risvegliatori al Lv. 60"
  },
  Task_10667_Name = {Text = "Compito 1"},
  Task_10668_Desc = {
    Text = "Completa 20 Operazioni Offensive/Esercitazioni Difensive/Missioni Cooperative"
  },
  Task_10668_Name = {
    Text = "Libro materiali Abilità (Inattivo)"
  },
  Task_10669_Desc = {
    Text = "Completa l'Indagine della Storia principale 10 volte"
  },
  Task_10669_Name = {
    Text = "Libro Storia principale (Inattivo)"
  },
  Task_10670_Desc = {
    Text = "Completamento Fessura di Caro I"
  },
  Task_10671_Desc = {
    Text = "Acquista con i Certificati Rosa nel Negozio 3 volte"
  },
  Task_10671_Name = {
    Text = "Acquisto Oro"
  },
  Task_10672_Desc = {
    Text = "Metti \"mi piace\" ai tuoi Alumni 10 volte"
  },
  Task_10672_Name = {
    Text = "Metti \"mi piace\" ai tuoi amici"
  },
  Task_10673_Desc = {
    Text = "Completa il Dominio Arcano 1 volta"
  },
  Task_10673_Name = {
    Text = "Boss settimanale"
  },
  Task_10674_Desc = {
    Text = "Partecipa a Traphase 3 volte"
  },
  Task_10674_Name = {
    Text = "Battaglia PVP"
  },
  Task_10675_Desc = {
    Text = "Completa la Prova Settimanale"
  },
  Task_10675_Name = {Text = "Prove"},
  Task_10676_Desc = {
    Text = "Usa Supporto 3 volte"
  },
  Task_10676_Name = {
    Text = "Supporto amici"
  },
  Task_10677_Desc = {
    Text = "Raggiungi un punteggio totale di 1800 nell'Immersione Fantasma questa settimana."
  },
  Task_10677_Name = {
    Text = "Immersione Fantasmatica"
  },
  Task_10678_Desc = {
    Text = "3 pti per Sigillo Nero (max 600)"
  },
  Task_10678_Name = {
    Text = "Sigillo Nero <size=20><color=#747474>3 punti per Sigillo, max 600</color></size>"
  },
  Task_10679_Desc = {
    Text = "Vinci la Battaglia finale entro 15 turni"
  },
  Task_10679_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10680_CompleteCondDesc = {
    Text = "Livello Totale>={s1}"
  },
  Task_10680_Desc = {
    Text = "Dimensioni, spazio, quanti... Forse non sarai mai in grado di comprendere i significati profondi celati dietro queste parole. \nCosì come non puoi comprendere la maggior parte delle cose che accadono in questo mondo."
  },
  Task_10680_Name = {
    Text = "Ricerca: Violet Chant"
  },
  Task_10680_UnlockCondDesc = {
    Text = "Si sblocca al Livello Custode 25"
  },
  Task_10681_Desc = {
    Text = "Supera con Vita non inferiore all'80%"
  },
  Task_10681_Name = {
    Text = "La Sicurezza Prima di Tutto"
  },
  Task_10682_Desc = {
    Text = "Vinci la battaglia finale entro 25 turni"
  },
  Task_10682_Name = {
    Text = "Vinci la battaglia finale entro 25 turni"
  },
  Task_10683_Desc = {
    Text = "Edificare 1 Risvegliato del Reame del Caos al Grado 2"
  },
  Task_10683_Name = {
    Text = "Padronanza del Caos II"
  },
  Task_10684_Desc = {
    Text = "Risuona 8 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_10684_Desc2 = {
    Text = "Esegui la Risonanza 8 volte nell'Evento d'Indagine \"Attenti ai Segugi\"."
  },
  Task_10684_Name2 = {
    Text = "Eco di Resilienza III"
  },
  Task_10685_Desc = {
    Text = "Completare il livello con almeno 2 Risvegliatori del Caos"
  },
  Task_10685_Name = {
    Text = "Ascesa nel Caos"
  },
  Task_10686_Desc = {
    Text = "Possiedi almeno 3 Reliquie al completamento"
  },
  Task_10686_Name = {
    Text = "Potere delle Reliquie"
  },
  Task_10687_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_10687_Name = {
    Text = "La Sicurezza Prima di Tutto"
  },
  Task_10688_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_10688_Name = {
    Text = "La Sicurezza Prima di Tutto"
  },
  Task_10689_Desc = {
    Text = "Completa il livello entro 30 passi"
  },
  Task_10689_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_10690_Desc = {
    Text = "Risveglia tutti i Risvegliatori al completamento"
  },
  Task_10690_Name = {
    Text = "Discesa finale"
  },
  Task_10691_Desc = {
    Text = "Completare il livello con almeno 2 Risvegliatori del Caos"
  },
  Task_10691_Name = {
    Text = "Ascesa nel Caos"
  },
  Task_10692_Desc = {
    Text = "Completare il livello con almeno 2 Risvegliatori del Caos"
  },
  Task_10692_Name = {
    Text = "Ascesa nel Caos"
  },
  Task_10693_Desc = {
    Text = "Elimina la Fonte dell'Anomalia"
  },
  Task_10693_Name = {Text = "Bersaglio"},
  Task_10694_Desc = {
    Text = "Respingi i Devoti del Portatore di Luce all'attacco"
  },
  Task_10694_Name = {Text = "Bersaglio"},
  Task_10695_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10695_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10696_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10696_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10698_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10698_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10706_Desc = {
    Text = "Potenziare il Patto una volta (Incompleto)"
  },
  Task_10706_Name = {
    Text = "Potenziamento accessori (Inattivo)"
  },
  Task_10707_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_10707_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10708_Desc = {
    Text = "Completa il livello entro 35 passi"
  },
  Task_10708_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_10710_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_10710_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10713_Desc = {
    Text = "Edificare 1 Risvegliato del Reame del Caos al Grado 5"
  },
  Task_10713_Name = {
    Text = "Padronanza del Caos V"
  },
  Task_10714_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10714_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10715_Desc = {
    Text = "Spezza l'assedio"
  },
  Task_10715_Name = {Text = "Bersaglio"},
  Task_10716_Desc = {
    Text = "Custode Liv. 5"
  },
  Task_10716_Name = {
    Text = "Prova del Custode I"
  },
  Task_10717_Desc = {
    Text = "Accumulare almeno 1500 punti Scudo del Personaggio in un turno durante la Battaglia finale."
  },
  Task_10717_Name = {
    Text = "Difesa Eccessiva"
  },
  Task_10720_Desc = {
    Text = "Completa Dominio del Caos: Fessura VII"
  },
  Task_10720_Name = {Text = "Compito 5"},
  Task_10721_Desc = {
    Text = "Potenzia 6 Patti qualsiasi al Lv. 12"
  },
  Task_10721_Name = {Text = "Compito 4"},
  Task_10722_Desc = {
    Text = "Possiedi almeno 8 Carte Orazione al completamento"
  },
  Task_10722_Name = {
    Text = "Potere dell'Orazione"
  },
  Task_10723_Desc = {
    Text = "Completamento del gioco con un totale di 4 o meno Esaltazioni in tutte le Battaglie."
  },
  Task_10723_Name = {
    Text = "Calma ed Eleganza"
  },
  Task_10724_Desc = {
    Text = "Potenzia una qualsiasi Abilità di un Risvegliatore al Lv. 4"
  },
  Task_10724_Name = {Text = "Compito 1"},
  Task_10725_Desc = {
    Text = "Accumulare almeno 2000 punti Scudo del Personaggio in un turno durante la Battaglia finale."
  },
  Task_10725_Name = {
    Text = "Difesa Eccessiva"
  },
  Task_10727_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10727_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10728_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10728_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10729_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10729_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10733_CompleteCondDesc = {
    Text = "Livello Totale>={s1}"
  },
  Task_10733_Desc = {
    Text = "Quella è la lingua in cui Dio scrive l'universo.\nQuando la ascolti, stai ascoltando l'infinito."
  },
  Task_10733_Name = {
    Text = "Missione: Epoca Sbiadita"
  },
  Task_10733_UnlockCondDesc = {
    Text = "Si sblocca al completamento della Storia principale 1-13"
  },
  Task_10734_Desc = {
    Text = "Completa 600 ricerche con Voucher d'Oro"
  },
  Task_10734_Name = {
    Text = "Cercatore d'Oro V"
  },
  Task_10735_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10735_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10736_CompleteCondDesc = {
    Text = "Livello Totale>={s1}"
  },
  Task_10736_Desc = {
    Text = [[
A rigor di termini, anche i Risvegliatori sono una forma di Tecnologia di chip d'argento.
Devi fare del tuo meglio per assicurarti che non restino indietro.]]
  },
  Task_10736_Name = {
    Text = "Ricerca: Brewscript"
  },
  Task_10737_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10737_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10738_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10738_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10739_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10739_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10740_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10740_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10741_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_10741_Name = {
    Text = "La Sicurezza Prima di Tutto"
  },
  Task_10742_Desc = {
    Text = "Possiedi almeno 2 Reliquie al Completamento"
  },
  Task_10742_Name = {
    Text = "Potere delle Reliquie"
  },
  Task_10743_Desc = {
    Text = "Completare il livello con almeno 2 Risvegliatori del Caos"
  },
  Task_10743_Name = {
    Text = "Ascesa nel Caos"
  },
  Task_10744_Desc = {
    Text = "Completa il livello in massimo 5 battaglie."
  },
  Task_10744_Name = {
    Text = "Colpo Preciso"
  },
  Task_10745_Desc = {
    Text = "Non avere più di 3 Sintomi al completamento"
  },
  Task_10745_Name = {
    Text = "Mente Limpida"
  },
  Task_10746_Desc = {
    Text = "Possiedi almeno 100 Sigilli Neri al completamento."
  },
  Task_10746_Name = {
    Text = "Per la Prossima Volta"
  },
  Task_10747_Desc = {
    Text = "Completare il livello con almeno 2 Risvegliatori del Caos"
  },
  Task_10747_Name = {
    Text = "Ascesa nel Caos"
  },
  Task_10748_Desc = {
    Text = "Risveglia tutti i Risvegliatori al completamento"
  },
  Task_10748_Name = {
    Text = "Discesa finale"
  },
  Task_10749_Desc = {
    Text = "Possiedi almeno 4 Reliquie al completamento"
  },
  Task_10749_Name = {
    Text = "Potere delle Reliquie"
  },
  Task_10750_Desc = {
    Text = "Livello completato"
  },
  Task_10750_Name = {
    Text = "Completa il livello"
  },
  Task_10751_Desc = {
    Text = "Completamento entro 88 turni"
  },
  Task_10751_Name = {
    Text = "Completamento entro 88 turni"
  },
  Task_10752_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10752_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10753_Desc = {
    Text = "Risuona 3 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_10753_Desc2 = {
    Text = "Esegui la Risonanza 3 volte nell'Evento d'Indagine \"Eredità di Cera\""
  },
  Task_10753_Name2 = {
    Text = "Eco di Convulsione"
  },
  Task_10754_Desc = {
    Text = "Risuona 6 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_10754_Desc2 = {
    Text = "Esegui la Risonanza 6 volte nell'Evento d'Indagine \"Eredità di Cera\""
  },
  Task_10754_Name2 = {
    Text = "Eco di Convulsione II"
  },
  Task_10755_Desc = {
    Text = "Risuona 8 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_10755_Desc2 = {
    Text = "Esegui la Risonanza 8 volte nell'Evento d'Indagine \"Eredità di Cera\""
  },
  Task_10755_Name2 = {
    Text = "Eco di Convulsione III"
  },
  Task_10756_Desc = {
    Text = "Risuona 3 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_10756_Desc2 = {
    Text = "Esegui la Risonanza 3 volte nell'Evento d'Indagine \"Attenti ai Segugi\""
  },
  Task_10756_Name2 = {
    Text = "Eco della Sopportazione"
  },
  Task_10757_Desc = {
    Text = "Risuona 6 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_10757_Desc2 = {
    Text = "Esegui la Risonanza 6 volte nell'Evento d'Indagine \"Attenti ai Segugi\""
  },
  Task_10757_Name2 = {
    Text = "Eco della Sopportazione II"
  },
  Task_10758_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_10758_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10759_Desc = {
    Text = "Risuona 10 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_10759_Desc2 = {
    Text = "Esegui la Risonanza 10 volte nell'Evento d'Indagine \"Attenti ai Segugi\""
  },
  Task_10759_Name2 = {
    Text = "Eco di Resilienza IV"
  },
  Task_10760_Desc = {
    Text = "Risuona 3 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_10760_Desc2 = {
    Text = "Esegui la Risonanza 3 volte nell'Evento d'Indagine \"In Silenzio\""
  },
  Task_10760_Name2 = {
    Text = "Eco d'Agonia"
  },
  Task_10761_Desc = {
    Text = "Risuona 6 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_10761_Desc2 = {
    Text = "Ottieni 6 Risonanze nell'Evento d'Indagine \"Nel Silenzio\""
  },
  Task_10761_Name2 = {
    Text = "Eco d'Agonia II"
  },
  Task_10762_Desc = {
    Text = "Risuona 8 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_10762_Desc2 = {
    Text = "Ottieni 8 Risonanze nell'Evento d'Indagine \"Nel Silenzio\""
  },
  Task_10762_Name2 = {
    Text = "Eco d'Agonia III"
  },
  Task_10763_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_10763_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10764_Desc = {
    Text = "Completamento dell'Eredità di Aequor una volta"
  },
  Task_10764_Name = {
    Text = "Scalata della Torre: Aequor"
  },
  Task_10765_Desc = {
    Text = "Vinci la Battaglia finale entro 15 turni"
  },
  Task_10765_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10766_Desc = {
    Text = "Livello completato"
  },
  Task_10766_Name = {
    Text = "Completa il livello"
  },
  Task_10767_Desc = {
    Text = "Livello completato"
  },
  Task_10767_Name = {
    Text = "Completa il livello"
  },
  Task_10768_Desc = {
    Text = "Possiedi quattro Risvegliatori del Reame Ultra di Livello 10"
  },
  Task_10768_Name = {
    Text = "Signore dell'Ultra"
  },
  Task_10769_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_10769_Name = {
    Text = "La Sicurezza Prima di Tutto"
  },
  Task_10770_Desc = {
    Text = "Completa tutte le missioni di questo capitolo per ottenere le ricompense."
  },
  Task_10770_Name = {
    Text = "Padronanza del Reame V"
  },
  Task_10771_Desc = {
    Text = "Completamento del Dominio del Caos una volta"
  },
  Task_10771_Name = {
    Text = "Scalata della Torre: Caos"
  },
  Task_10772_Desc = {
    Text = "Completamento del Viaggio Ultra una volta"
  },
  Task_10772_Name = {
    Text = "Scalata della Torre: Ultra"
  },
  Task_10773_Desc = {
    Text = "Completamento della Palude di Caro una volta"
  },
  Task_10773_Name = {
    Text = "Scalata della Torre: Caro"
  },
  Task_10774_Desc = {
    Text = "Completa la Zona D-Effetto Regionale una volta (30 Punti Addestramento)"
  },
  Task_10774_Name = {
    Text = "Zona D-Effetto"
  },
  Task_10775_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10775_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10776_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10776_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10777_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10777_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10778_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10778_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10779_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10779_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10780_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10780_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10781_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10781_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10782_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10782_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10783_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10783_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10784_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10784_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10785_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10785_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10786_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10786_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10787_CompleteCondDesc = {
    Text = "Livello Totale>={s1}"
  },
  Task_10787_Desc = {
    Text = "Non è tutto Oro quel che luccica, ma ha certamente valore. \nLa leggenda narra che Mythag fu fondato da un gruppo isolato di alchimisti le cui ambizioni andavano ben oltre la mera trasmutazione."
  },
  Task_10787_Name = {
    Text = "Ricerca: Formulae Codex"
  },
  Task_10789_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10789_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10790_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10790_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10791_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10791_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10792_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10792_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10793_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10793_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10794_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10794_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10795_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10795_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10796_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10796_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10797_Desc = {
    Text = "Completare il livello con almeno 2 Risvegliatori del Caos"
  },
  Task_10797_Name = {
    Text = "Ascesa nel Caos"
  },
  Task_10798_Desc = {
    Text = "Infliggi 2000 accumuli di Veleno al nemico"
  },
  Task_10798_Name = {
    Text = "Tossicologo III"
  },
  Task_10799_Desc = {
    Text = "Applica 1000 accumuli di Veleno al nemico"
  },
  Task_10799_Name = {
    Text = "Tossicologo II"
  },
  Task_10800_Desc = {
    Text = "Contrattacca 4 nemici e ottieni la vittoria"
  },
  Task_10800_Name = {
    Text = "Difesa Legittima"
  },
  Task_10801_Desc = {
    Text = "Infliggi 5000 accumuli di Veleno al nemico"
  },
  Task_10801_Name = {
    Text = "Tossicologo IV"
  },
  Task_10802_Desc = {
    Text = "Al Completamento del dungeon, possiedi 30 carte nel mazzo."
  },
  Task_10802_Name = {
    Text = "Collezionista di Carte"
  },
  Task_10803_Desc = {
    Text = "Sconfiggi 6 nemici con Danno critico e ottieni la vittoria."
  },
  Task_10803_Name = {
    Text = "Brutalità Improvvisa"
  },
  Task_10804_Desc = {
    Text = "Scarta 30 carte durante una battaglia e ottieni la vittoria."
  },
  Task_10804_Name = {
    Text = "Arroganza Assoluta"
  },
  Task_10805_Desc = {
    Text = "Possiedi 8 Carte sintomo nel mazzo al completamento di un dungeon."
  },
  Task_10805_Name = {
    Text = "Perseguitato dalla Sorte"
  },
  Task_10806_Desc = {
    Text = "Consuma 10 Arithmetica in un singolo turno e ottieni la vittoria."
  },
  Task_10806_Name = {
    Text = "Strategia Impeccabile"
  },
  Task_10807_Desc = {
    Text = "Possiedi 7 Reliquie al completamento di un qualsiasi dungeon"
  },
  Task_10807_Name = {
    Text = "Collezionista di Reliquie"
  },
  Task_10808_Desc = {
    Text = "Potenzia una qualsiasi Abilità di un Risvegliatore al Lv. 5"
  },
  Task_10808_Name = {Text = "Compito 2"},
  Task_10809_Desc = {
    Text = "Edificare 1 Risvegliato del Reame del Caos al Grado 4"
  },
  Task_10809_Name = {
    Text = "Padronanza del Caos IV"
  },
  Task_10810_Desc = {
    Text = "Completa 10 Trascrizioni del Patto"
  },
  Task_10810_Name = {Text = "Compito 4"},
  Task_10811_Desc = {
    Text = "Supera Dominio del Caos: Fessura VIII"
  },
  Task_10811_Name = {Text = "Compito 5"},
  Task_10812_Desc = {
    Text = "Edificare 1 Risvegliato del Reame Ultra al Grado 4"
  },
  Task_10812_Name = {
    Text = "Maestria Ultra IV"
  },
  Task_10814_Desc = {
    Text = "Livello completato"
  },
  Task_10814_Name = {
    Text = "Completa il livello"
  },
  Task_10815_Desc = {
    Text = "Possiedi al massimo 6 Carte Orazione al completamento"
  },
  Task_10815_Name = {
    Text = "Soppressione dell'Orazione"
  },
  Task_10817_Desc = {
    Text = "Completa 50 raffinazioni di pozioni"
  },
  Task_10817_Name = {
    Text = "Farmacologa geniale"
  },
  Task_10818_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10818_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10819_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10819_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10820_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10820_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10821_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10821_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10822_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10822_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10823_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10823_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10824_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10824_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10825_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10825_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10826_Desc = {
    Text = "Livello completato"
  },
  Task_10826_Name = {
    Text = "Completa il livello"
  },
  Task_10827_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10827_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10828_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_10828_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10830_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10830_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10831_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10831_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10832_Desc = {
    Text = "Livello completato"
  },
  Task_10832_Name = {
    Text = "Completa il livello"
  },
  Task_10833_Desc = {
    Text = "Livello completato"
  },
  Task_10833_Name = {
    Text = "Completa il livello"
  },
  Task_10834_Desc = {
    Text = "Possiedi almeno 10 Carte Orazione al completamento."
  },
  Task_10834_Name = {
    Text = "Potere dell'Orazione"
  },
  Task_10835_Desc = {
    Text = "Livello completato"
  },
  Task_10835_Name = {
    Text = "Completa il livello"
  },
  Task_10836_Desc = {
    Text = "Vinci la Battaglia finale entro 20 turni"
  },
  Task_10836_Name = {
    Text = "Vinci la Battaglia finale entro 20 turni"
  },
  Task_10839_Desc = {
    Text = "Completa il livello in meno di 50 mosse"
  },
  Task_10839_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_10840_Desc = {
    Text = "Completamento entro 43 turni"
  },
  Task_10840_Name = {
    Text = "Completamento entro 43 turni"
  },
  Task_10842_Desc = {
    Text = "Completa l'Evento d'Indagine \"Attenti ai Segugi\" in difficoltà Difficile"
  },
  Task_10842_Name = {
    Text = "La Scultrice"
  },
  Task_10844_Desc = {
    Text = "Edificare 1 Risvegliato del Reame di Aequor al Grado 2"
  },
  Task_10844_Name = {
    Text = "Maestria di Aequor II"
  },
  Task_10845_Desc = {
    Text = "Livello completato"
  },
  Task_10845_Name = {
    Text = "Completa il livello"
  },
  Task_10848_Desc = {
    Text = "Completa il livello entro 24 passi"
  },
  Task_10848_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_10852_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10852_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10853_Desc = {
    Text = "Livello completato"
  },
  Task_10853_Name = {
    Text = "Completa il livello"
  },
  Task_10854_Desc = {
    Text = "Livello completato"
  },
  Task_10854_Name = {
    Text = "Completa il livello"
  },
  Task_10855_Desc = {
    Text = "Livello completato"
  },
  Task_10855_Name = {
    Text = "Completa il livello"
  },
  Task_10857_Desc = {
    Text = "Livello completato"
  },
  Task_10857_Name = {
    Text = "Completa il livello"
  },
  Task_10858_Desc = {
    Text = "Livello completato"
  },
  Task_10858_Name = {
    Text = "Completa il livello"
  },
  Task_10859_Desc = {
    Text = "Livello completato"
  },
  Task_10859_Name = {
    Text = "Completa il livello"
  },
  Task_10860_Desc = {
    Text = "Livello completato"
  },
  Task_10860_Name = {
    Text = "Completa il livello"
  },
  Task_10861_Desc = {
    Text = "Livello completato"
  },
  Task_10861_Name = {
    Text = "Completa il livello"
  },
  Task_10862_Desc = {
    Text = "Livello completato"
  },
  Task_10862_Name = {
    Text = "Completa il livello"
  },
  Task_10863_Desc = {
    Text = "Livello completato"
  },
  Task_10863_Name = {
    Text = "Completa il livello"
  },
  Task_10864_Desc = {
    Text = "Livello completato"
  },
  Task_10864_Name = {
    Text = "Completa il livello"
  },
  Task_10865_Desc = {
    Text = "Completate 100 Cerimonie di Risveglio"
  },
  Task_10865_Name = {
    Text = "Pesca Carte"
  },
  Task_10866_Desc = {
    Text = "Livello completato"
  },
  Task_10866_Name = {
    Text = "Completa il livello"
  },
  Task_10867_Desc = {
    Text = "Livello completato"
  },
  Task_10867_Name = {
    Text = "Completa il livello"
  },
  Task_10868_Desc = {
    Text = "Livello completato"
  },
  Task_10868_Name = {
    Text = "Completa il livello"
  },
  Task_10869_Desc = {
    Text = "Completamento del gioco con un totale di 4 o meno Esaltazioni in tutte le Battaglie."
  },
  Task_10869_Name = {
    Text = "Calma ed Eleganza"
  },
  Task_10870_Desc = {
    Text = "Potenzia le Abilità dei Risvegliati 100 volte"
  },
  Task_10870_Name = {
    Text = "Affinamento delle Arti IV"
  },
  Task_10871_Desc = {
    Text = "Potenzia le Abilità dei Risvegliati 200 volte"
  },
  Task_10871_Name = {
    Text = "Affinamento delle Arti V"
  },
  Task_10872_Desc = {
    Text = "Possiedi quattro Risvegliatori del Reame Ultra di Livello 60"
  },
  Task_10872_Name = {
    Text = "Signore dell'Ultra VI"
  },
  Task_10873_Desc = {
    Text = "Potenzia le Abilità dei Risvegliati 10 volte"
  },
  Task_10873_Name = {
    Text = "Affinamento delle Arti"
  },
  Task_10874_Desc = {
    Text = "Potenzia le Abilità dei Risvegliati 20 volte"
  },
  Task_10874_Name = {
    Text = "Affinamento delle Arti II"
  },
  Task_10875_Desc = {
    Text = "Potenzia le Abilità dei Risvegliati 50 volte"
  },
  Task_10875_Name = {
    Text = "Affinamento delle Arti III"
  },
  Task_10876_Desc = {
    Text = "Possiedi quattro Risvegliatori del Reame Ultra di Livello 20"
  },
  Task_10876_Name = {
    Text = "Signore dell'Ultra II"
  },
  Task_10877_Desc = {
    Text = "Possiedi quattro Risvegliatori del Reame Ultra di Livello 30"
  },
  Task_10877_Name = {
    Text = "Signore dell'Ultra III"
  },
  Task_10878_Desc = {
    Text = "Possiedi quattro Risvegliatori del Reame Ultra di Livello 40"
  },
  Task_10878_Name = {
    Text = "Signore dell'Ultra IV"
  },
  Task_10879_Desc = {
    Text = "Possiedi quattro Risvegliatori del Reame Ultra di Livello 50"
  },
  Task_10879_Name = {
    Text = "Signore dell'Ultra V"
  },
  Task_10880_Desc = {
    Text = "Completamento Storia Principale: Difficile 2-11"
  },
  Task_10880_Name = {Text = "Compito 3"},
  Task_10881_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_10881_Name = {
    Text = "La Sicurezza Prima di Tutto"
  },
  Task_10882_Desc = {
    Text = "Completa il livello entro 35 passi"
  },
  Task_10882_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_10883_Desc = {
    Text = "Completa tutte le missioni di questo capitolo per ottenere le ricompense."
  },
  Task_10883_Name = {
    Text = "Padronanza del Reame II"
  },
  Task_10884_Desc = {
    Text = "Possiedi almeno 8 Carte Orazione al completamento"
  },
  Task_10884_Name = {
    Text = "Potere dell'Orazione"
  },
  Task_10885_Desc = {
    Text = "Completare il livello con almeno 2 Risvegliatori del Caos"
  },
  Task_10885_Name = {
    Text = "Ascesa nel Caos"
  },
  Task_10886_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_10886_Name = {
    Text = "La Sicurezza Prima di Tutto"
  },
  Task_10887_Desc = {
    Text = "Vinci la prima battaglia, sconfiggi quei fanciulli e recupera i tuoi averi."
  },
  Task_10887_Name = {
    Text = "Prima Battaglia Vinta"
  },
  Task_10888_Desc = {
    Text = "Completa il livello entro 40 passi."
  },
  Task_10888_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_10889_Desc = {
    Text = "Possiedi al massimo 6 Carte Orazione al completamento"
  },
  Task_10889_Name = {
    Text = "Soppressione dell'Orazione"
  },
  Task_10890_Desc = {
    Text = "Possiedi almeno 10 Carte Orazione al completamento."
  },
  Task_10890_Name = {
    Text = "Potere dell'Orazione"
  },
  Task_10892_Desc = {
    Text = "Completa il livello entro 28 mosse"
  },
  Task_10892_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_10893_Desc = {
    Text = "Livello completato"
  },
  Task_10893_Name = {
    Text = "Completa il livello"
  },
  Task_10894_Desc = {
    Text = "Livello completato"
  },
  Task_10894_Name = {
    Text = "Completa il livello"
  },
  Task_10895_Desc = {
    Text = "Livello completato"
  },
  Task_10895_Name = {
    Text = "Completa il livello"
  },
  Task_10896_Desc = {
    Text = "Livello completato"
  },
  Task_10896_Name = {
    Text = "Completa il livello"
  },
  Task_10897_Desc = {
    Text = "Livello completato"
  },
  Task_10897_Name = {
    Text = "Completa il livello"
  },
  Task_10898_Desc = {
    Text = "Livello completato"
  },
  Task_10898_Name = {
    Text = "Completa il livello"
  },
  Task_10899_Desc = {
    Text = "Livello completato"
  },
  Task_10899_Name = {
    Text = "Completa il livello"
  },
  Task_10900_Desc = {
    Text = "1 pto per 1% Resistenza alla Morte residua (max 600)"
  },
  Task_10900_Name = {
    Text = "Combattente Esperto <size=20><color=#747474>1 punto per 1% Resistenza alla Morte, max 600</color></size>"
  },
  Task_10901_Desc = {
    Text = "Livello completato"
  },
  Task_10901_Name = {
    Text = "Completa il livello"
  },
  Task_10902_Desc = {
    Text = "Livello completato"
  },
  Task_10902_Name = {
    Text = "Completa il livello"
  },
  Task_10904_Desc = {
    Text = "Vinci la Battaglia finale entro 8 turni"
  },
  Task_10904_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10905_Desc = {
    Text = "Battaglia con la Scultura di Cera Sotterranea"
  },
  Task_10905_Name = {Text = "Bersaglio"},
  Task_10906_Desc = {
    Text = "Non avere più di 3 Sintomi al completamento"
  },
  Task_10906_Name = {
    Text = "Mente Limpida"
  },
  Task_10907_Desc = {
    Text = "Completa il livello in massimo 7 battaglie."
  },
  Task_10907_Name = {
    Text = "Colpo Preciso"
  },
  Task_10908_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10908_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10909_Desc = {
    Text = "Custode Liv. 15"
  },
  Task_10909_Name = {
    Text = "Prova del Custode II"
  },
  Task_10910_Desc = {
    Text = "Risuona 8 volte nell'Evento d'Indagine \"L'Enigma del Distretto Est\""
  },
  Task_10910_Name = {
    Text = "Eco di Gratitudine III"
  },
  Task_10911_Desc = {
    Text = "Risuona 6 volte nell'Evento d'Indagine \"L'Enigma del Distretto Est\""
  },
  Task_10911_Name = {
    Text = "Eco di Gratitudine II"
  },
  Task_10912_Desc = {
    Text = "Edificare 1 Risvegliato del Reame di Caro al Grado 2"
  },
  Task_10912_Name = {
    Text = "Maestria della Caro II"
  },
  Task_10913_Desc = {
    Text = "Squeak, squeak...!!"
  },
  Task_10913_Name = {Text = "Squeak"},
  Task_10914_Desc = {
    Text = "Prosegui verso l'ufficio del direttore"
  },
  Task_10914_Name = {Text = "Bersaglio"},
  Task_10915_Desc = {
    Text = "Raggiungi il Livello di Affinità 5 con 12 Risvegliati"
  },
  Task_10915_Name = {
    Text = "Partner Affiatati VI"
  },
  Task_10916_Desc = {
    Text = "Completa l'Evento d'Indagine \"L'Enigma del Distretto Est\""
  },
  Task_10916_Name = {
    Text = "Carta dorata"
  },
  Task_10917_Desc = {
    Text = "Raggiungi il Livello di Affinità 5 con 16 Risvegliati"
  },
  Task_10917_Name = {
    Text = "Partner Affiatati VIII"
  },
  Task_10918_Desc = {
    Text = "Completa l'evento d'indagine \"@1@2\""
  },
  Task_10918_Desc2 = {
    Text = "Completa l'Evento d'Indagine \"Attenti ai segugi\""
  },
  Task_10918_Name2 = {
    Text = "L'Occhio Oltre le Dimensioni"
  },
  Task_10919_Desc = {
    Text = "Livello completato"
  },
  Task_10919_Name = {
    Text = "Completa il livello"
  },
  Task_10920_Desc = {
    Text = "Livello completato"
  },
  Task_10920_Name = {
    Text = "Completa il livello"
  },
  Task_10921_Desc = {
    Text = "Livello completato"
  },
  Task_10921_Name = {
    Text = "Completa il livello"
  },
  Task_10922_Desc = {
    Text = "Completa 200 corse nelle Rovine di Ponape"
  },
  Task_10922_Name = {
    Text = "Benedizione di Pohnpei III"
  },
  Task_10923_Desc = {
    Text = "Completa 100 corse nelle Rovine di Ponape"
  },
  Task_10923_Name = {
    Text = "Benedizione di Pohnpei II"
  },
  Task_10924_Desc = {
    Text = "Completa 400 Ammassi del Caos"
  },
  Task_10924_Name = {
    Text = "Teorico degli Sciami IV"
  },
  Task_10925_Desc = {
    Text = "Completa 200 Ammassi del Caos"
  },
  Task_10925_Name = {
    Text = "Teorico degli Sciami III"
  },
  Task_10926_Desc = {
    Text = "Completa 50 corse nelle Rovine di Ponape"
  },
  Task_10926_Name = {
    Text = "Benedizione di Pohnpei"
  },
  Task_10927_Desc = {
    Text = "Completa 600 Ammassi del Caos"
  },
  Task_10927_Name = {
    Text = "Teorico degli Sciami V"
  },
  Task_10928_Desc = {
    Text = "Indaga 240 Residui Dimensionali"
  },
  Task_10928_Name = {
    Text = "Rovine dell'Ultra V"
  },
  Task_10929_Desc = {
    Text = "Indaga 120 Residui Dimensionali"
  },
  Task_10929_Name = {
    Text = "Rovine dell'Ultra IV"
  },
  Task_10931_Desc = {
    Text = "Completa 50 Ammassi del Caos"
  },
  Task_10931_Name = {
    Text = "Teorico degli Sciami"
  },
  Task_10932_Desc = {
    Text = "Accumula il consumo di 2500 Sigilli Neri"
  },
  Task_10932_Name = {
    Text = "Evocazione Nera IV"
  },
  Task_10933_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10933_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10934_CompleteCondDesc = {
    Text = "Livello Totale>={s1}"
  },
  Task_10934_Desc = {
    Text = [[
Ogni forma di vita alla fine ritorna al mare.
Come il flusso incessante del tempo, segna l'inizio della fine.]]
  },
  Task_10934_Name = {
    Text = "Ricerca: Azure Lament"
  },
  Task_10934_UnlockCondDesc = {
    Text = "Si sblocca al Livello Custode 25"
  },
  Task_10935_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10935_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10936_Desc = {
    Text = "60 pti per battaglia"
  },
  Task_10936_Name = {
    Text = "Sconfiggi l'Élite <size=20><color=#747474>60 punti per battaglia</color></size>"
  },
  Task_10938_Desc = {
    Text = "Possiedi 18 Patti di Livello 12"
  },
  Task_10938_Name = {
    Text = "Collezionista di Patti III"
  },
  Task_10941_Desc = {
    Text = "Carte Risvegliatore ≤1 al Completamento (+100 pti)"
  },
  Task_10941_Name = {
    Text = "Il Dimenticato <size=20><color=#747474>Carte Risveglio ≤1 al completamento</color></size>"
  },
  Task_10944_Desc = {
    Text = "Possiedi quattro Risvegliatori di Aequor di Livello 20"
  },
  Task_10944_Name = {
    Text = "Signore di Aequor II"
  },
  Task_10946_Desc = {
    Text = "Porta 4 Risvegliatori al Lv. 50"
  },
  Task_10946_Name = {Text = "Compito 2"},
  Task_10947_Desc = {
    Text = "Livello completato"
  },
  Task_10947_Name = {
    Text = "Obiettivo 1: Copia in Attesa di Imballaggio"
  },
  Task_10948_Desc = {
    Text = "Indaga sul manicomio"
  },
  Task_10948_Name = {Text = "Bersaglio"},
  Task_10949_Desc = {
    Text = "Non avere più di 1 Sintomo al completamento"
  },
  Task_10949_Name = {
    Text = "Mente Limpida"
  },
  Task_10951_Desc = {
    Text = "1 pto per 1% HP Residui (max 100)"
  },
  Task_10951_Name = {
    Text = "HP Residui <size=20><color=#747474>1 punto per 1% HP, max 100</color></size>"
  },
  Task_10953_Desc = {
    Text = "Completamento Storia Principale Capitolo 2 \"Eredità di Cera\": Modalità Difficile"
  },
  Task_10954_Desc = {
    Text = "Calma i fanciulli adirati"
  },
  Task_10954_Name = {Text = "Bersaglio"},
  Task_10955_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10955_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10956_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_10956_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10957_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_10957_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10958_Desc = {
    Text = "Livello completato"
  },
  Task_10958_Name = {
    Text = "Completa il livello"
  },
  Task_10959_Desc = {
    Text = "Completa il Reame Senza Luce III (Incompiuto)"
  },
  Task_10962_Desc = {
    Text = "Livello completato"
  },
  Task_10962_Name = {
    Text = "Completa il livello"
  },
  Task_10963_Desc = {
    Text = "Completa il livello entro 35 passi"
  },
  Task_10963_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_10964_Desc = {
    Text = "Livello completato"
  },
  Task_10964_Name = {
    Text = "Suggerimento bersaglio: max 8 caratteri"
  },
  Task_10965_Desc = {
    Text = "Vinci la Battaglia finale entro 15 turni"
  },
  Task_10965_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10966_Desc = {
    Text = "Completa il livello entro 40 passi."
  },
  Task_10966_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_10969_Desc = {
    Text = "Supera con Vita non inferiore all'80%"
  },
  Task_10969_Name = {
    Text = "La Sicurezza Prima di Tutto"
  },
  Task_10970_Desc = {
    Text = "Edificare 1 Risvegliato del Reame di Aequor al Grado 4"
  },
  Task_10970_Name = {
    Text = "Maestria di Aequor IV"
  },
  Task_10971_Desc = {
    Text = "Vinci la Battaglia finale entro 8 turni"
  },
  Task_10971_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_10972_Desc = {
    Text = "Edificare 1 Risvegliato del Reame di Caro al Grado 4"
  },
  Task_10972_Name = {
    Text = "Maestria della Caro IV"
  },
  Task_10973_Desc = {
    Text = "Completa il livello in massimo 7 battaglie."
  },
  Task_10973_Name = {
    Text = "Colpo Preciso"
  },
  Task_10974_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10974_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10975_CompleteCondDesc = {
    Text = "Livello Totale>={s1}"
  },
  Task_10975_Desc = {
    Text = "\"Riscriverà il tuo cuore.\"\n\"Davvero? Allora dev'essere già pieno di buchi.\""
  },
  Task_10975_Name = {
    Text = "Missione: Terapia per Immagini"
  },
  Task_10975_UnlockCondDesc = {
    Text = "Si sblocca al completamento della Storia principale 1-13"
  },
  Task_10976_Desc = {
    Text = "Completamento Storia Principale: Difficile 4-12"
  },
  Task_10976_Name = {Text = "Compito 3"},
  Task_10977_Desc = {
    Text = "Completamento entro 26 turni"
  },
  Task_10977_Name = {
    Text = "Completamento entro 26 turni"
  },
  Task_10981_Desc = {
    Text = "Vinci la Battaglia finale entro 5 turni"
  },
  Task_10981_Name = {
    Text = "Vinci la Battaglia finale entro 5 turni"
  },
  Task_10982_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10982_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10983_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10983_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10984_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10984_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10985_Desc = {
    Text = "Indaga 60 casi di immagini residue strutturali"
  },
  Task_10985_Name = {
    Text = "Rovine della Caro III"
  },
  Task_10986_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10986_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10987_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_10987_Name = {
    Text = "Superamento Perfetto"
  },
  Task_10988_Desc = {
    Text = "Livello completato"
  },
  Task_10988_Name = {
    Text = "Completa il livello"
  },
  Task_10989_Desc = {
    Text = "Livello completato"
  },
  Task_10989_Name = {
    Text = "Completa il livello"
  },
  Task_10991_Desc = {
    Text = "Livello completato"
  },
  Task_10991_Name = {
    Text = "Completa il livello"
  },
  Task_10992_Desc = {
    Text = "Livello completato"
  },
  Task_10992_Name = {
    Text = "Completa il livello"
  },
  Task_10993_Desc = {
    Text = "Guardati da ciò che si cela nell'oscurità"
  },
  Task_10993_Name = {Text = "Bersaglio"},
  Task_10994_Desc = {
    Text = "Livello completato"
  },
  Task_10994_Name = {
    Text = "Completa il livello"
  },
  Task_10995_Desc = {
    Text = "Livello completato"
  },
  Task_10995_Name = {
    Text = "Completa il livello"
  },
  Task_10997_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_10997_Name = {
    Text = "La Sicurezza Prima di Tutto"
  },
  Task_10998_Desc = {
    Text = "Completa il livello in massimo 7 battaglie."
  },
  Task_10998_Name = {
    Text = "Colpo Preciso"
  },
  Task_10999_Desc = {
    Text = "Vinci la Battaglia finale entro 7 turni"
  },
  Task_10999_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_11003_Desc = {
    Text = "Non avere più di 1 Sintomo al completamento"
  },
  Task_11003_Name = {
    Text = "Mente Limpida"
  },
  Task_11004_Desc = {
    Text = "Assisti Lotan nell'inseguimento dei nemici"
  },
  Task_11004_Name = {Text = "Bersaglio"},
  Task_11005_Desc = {
    Text = "Indaga 120 postimmagini abissali"
  },
  Task_11005_Name = {
    Text = "Rovine di Aequor IV"
  },
  Task_11006_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_11006_Name = {
    Text = "Superamento Perfetto"
  },
  Task_11007_Desc = {
    Text = "Completa l'evento d'indagine \"@1@2\""
  },
  Task_11007_Desc2 = {
    Text = "Completa l'Evento d'Indagine \"Nel Silenzio\""
  },
  Task_11007_Name2 = {
    Text = "Mamma, Non Mi Fa Male"
  },
  Task_11008_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_11008_Name = {
    Text = "Superamento Perfetto"
  },
  Task_11009_Desc = {
    Text = "Livello completato"
  },
  Task_11009_Name = {
    Text = "Completa il livello"
  },
  Task_11010_Desc = {
    Text = "Accumula il consumo di 5000 Sigilli Neri"
  },
  Task_11010_Name = {
    Text = "Evocazione Nera V"
  },
  Task_11011_Desc = {
    Text = "Quando la percentuale di HP rimanenti è ≥ 80 al momento del completamento"
  },
  Task_11011_Name = {
    Text = "Un Gioco da Ragazzi"
  },
  Task_11012_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_11012_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_11013_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_11013_Name = {
    Text = "Superamento Perfetto"
  },
  Task_11014_Desc = {
    Text = "Potenziare il Patto 3 volte"
  },
  Task_11014_Name = {
    Text = "Prova a tempo 2 (Inattivo)"
  },
  Task_11015_Desc = {
    Text = "Potenziamento del Risvegliatore 3 volte"
  },
  Task_11015_Name = {
    Text = "Prova a tempo 1 (Inattivo)"
  },
  Task_11016_Desc = {
    Text = "Nella Battaglia specifica X (Élite), accumula ≥ 20 accumuli dello stato Veleno (Y)."
  },
  Task_11016_Name = {
    Text = "Dose che Crea Dipendenza"
  },
  Task_11017_Desc = {
    Text = "Accumulare almeno 1500 punti Scudo del Personaggio in un turno durante la Battaglia finale."
  },
  Task_11017_Name = {
    Text = "Difesa Eccessiva"
  },
  Task_11018_Desc = {
    Text = "Accumula il consumo di 500 Sigilli Neri"
  },
  Task_11018_Name = {
    Text = "Evocazione Nera II"
  },
  Task_11019_Desc = {
    Text = "Possiedi quattro Risvegliatori di Aequor di Livello 30"
  },
  Task_11019_Name = {
    Text = "Signore di Aequor III"
  },
  Task_11020_Desc = {
    Text = "Livello completato"
  },
  Task_11020_Name = {
    Text = "Completa il livello"
  },
  Task_11021_Desc = {
    Text = "Possiedi quattro Risvegliatori di Aequor di livello 50"
  },
  Task_11021_Name = {
    Text = "Signore di Aequor V"
  },
  Task_11022_Desc = {
    Text = "Livello completato"
  },
  Task_11022_Name = {
    Text = "Completa il livello"
  },
  Task_11023_Desc = {
    Text = "Possiedi 4 Risvegliatori di Caro di Livello 50"
  },
  Task_11023_Name = {
    Text = "Signore della Caro V"
  },
  Task_11024_Desc = {
    Text = "Accumula il consumo di 250 Sigilli Neri"
  },
  Task_11024_Name = {
    Text = "Evocazione Nera"
  },
  Task_11025_Desc = {
    Text = "Possiedi quattro Risvegliatori di Aequor di Livello 10"
  },
  Task_11025_Name = {
    Text = "Signore di Aequor"
  },
  Task_11026_Desc = {
    Text = "Possiedi 4 Risvegliatori di Caro di Livello 60"
  },
  Task_11026_Name = {
    Text = "Signore della Caro VI"
  },
  Task_11027_Desc = {
    Text = "Nella Battaglia specifica X, gioca 20 o più Carte in un singolo turno."
  },
  Task_11027_Name = {
    Text = "Maestro delle Carte"
  },
  Task_11029_Desc = {
    Text = "Risuona 10 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_11029_Desc2 = {
    Text = "Ottieni 10 Risonanze nell'Evento d'Indagine \"Nel Silenzio\""
  },
  Task_11029_Name2 = {
    Text = "Eco d'Agonia IV"
  },
  Task_11030_Desc = {
    Text = "Possiedi almeno 8 Carte Orazione al completamento"
  },
  Task_11030_Name = {
    Text = "Potere dell'Orazione"
  },
  Task_11031_Desc = {
    Text = "Livello completato"
  },
  Task_11031_Name = {
    Text = "Completa il livello"
  },
  Task_11032_Desc = {
    Text = "Nella Battaglia specifica X, pesca 5 o più Carte in un singolo turno."
  },
  Task_11032_Name = {
    Text = "Serendipità"
  },
  Task_11033_Desc = {
    Text = "Completa l'Evento d'Indagine \"Eredità di Cera\" in difficoltà Difficile"
  },
  Task_11033_Name = {
    Text = "Enigmi nella Cera: Hard"
  },
  Task_11034_Desc = {
    Text = "Respingere Daffodil"
  },
  Task_11034_Name = {Text = "Bersaglio"},
  Task_11035_Desc = {
    Text = "Nella Battaglia specifica X, accumula un valore di Scudo del Personaggio ≥ 200 (Battaglia Élite X)."
  },
  Task_11035_Name = {
    Text = "Indistruttibile"
  },
  Task_11036_Desc = {
    Text = "Completa l'Evento d'Indagine \"L'Enigma del Distretto Est\" in difficoltà ardua"
  },
  Task_11036_Name = {
    Text = "Distretto Est Nebbia: Hard"
  },
  Task_11038_Desc = {
    Text = "Attiva la Resistenza alla morte non più di una volta al completamento."
  },
  Task_11038_Name = {
    Text = "Senza Tempo per Morire"
  },
  Task_11041_Desc = {
    Text = "Vinci la Battaglia finale entro 8 turni"
  },
  Task_11041_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_11042_Desc = {
    Text = "Trova Celeste"
  },
  Task_11042_Name = {Text = "Bersaglio"},
  Task_11043_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_11043_Name = {
    Text = "Superamento Perfetto"
  },
  Task_11044_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_11044_Name = {
    Text = "Superamento Perfetto"
  },
  Task_11045_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_11045_Name = {
    Text = "Superamento Perfetto"
  },
  Task_11046_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_11046_Name = {
    Text = "Superamento Perfetto"
  },
  Task_11047_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_11047_Name = {
    Text = "Superamento Perfetto"
  },
  Task_11048_Desc = {
    Text = "Completa 100 Codici Tabù"
  },
  Task_11048_Name = {
    Text = "Incisore del Patto II"
  },
  Task_11050_Desc = {
    Text = "Livello completato"
  },
  Task_11050_Name = {
    Text = "Completa il livello"
  },
  Task_11052_Desc = {
    Text = "Indaga 240 casi di immagini residue strutturali"
  },
  Task_11052_Name = {
    Text = "Rovine della Caro V"
  },
  Task_11053_Desc = {
    Text = "Vinci la Battaglia finale entro 18 turni"
  },
  Task_11053_Name = {
    Text = "Vinci la Battaglia finale entro 18 turni"
  },
  Task_11054_Desc = {
    Text = "Visitare la capanna di Harriet"
  },
  Task_11054_Name = {Text = "Bersaglio"},
  Task_11057_Desc = {
    Text = "Completa il livello entro 40 passi."
  },
  Task_11057_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_11058_Desc = {
    Text = "Non avere più di 1 Sintomo al completamento"
  },
  Task_11058_Name = {
    Text = "Mente Limpida"
  },
  Task_11059_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_11059_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_11060_Desc = {
    Text = "Completa 100 Ammassi del Caos"
  },
  Task_11060_Name = {
    Text = "Teorico degli Sciami II"
  },
  Task_11061_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_11061_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_11062_Desc = {
    Text = "Raggiungi Murphy"
  },
  Task_11062_Name = {Text = "Bersaglio"},
  Task_11063_Desc = {
    Text = "Trovare la fonte del suono"
  },
  Task_11063_Name = {Text = "Bersaglio"},
  Task_11064_Desc = {Text = "Grazie."},
  Task_11064_Name = {Text = "Grazie,"},
  Task_11065_Desc = {
    Text = "Respingere Harriet"
  },
  Task_11065_Name = {Text = "Bersaglio"},
  Task_11066_Desc = {
    Text = "Non dimenticarmi, d'accordo?"
  },
  Task_11066_Name = {
    Text = "Non dimenticarmi, d'accordo?"
  },
  Task_11067_Desc = {
    Text = "Grazie a tutti..."
  },
  Task_11067_Name = {
    Text = "Grazie a tutti..."
  },
  Task_11068_Desc = {
    Text = "Vinci la Battaglia finale entro 15 turni"
  },
  Task_11068_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_11069_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_11069_Name = {
    Text = "Superamento Perfetto"
  },
  Task_11070_Desc = {
    Text = "Completamento entro 16 turni"
  },
  Task_11070_Name = {
    Text = "Completamento entro 16 turni"
  },
  Task_11071_Desc = {
    Text = "Completamento entro 21 turni"
  },
  Task_11071_Name = {
    Text = "Completamento entro 21 turni"
  },
  Task_11072_Desc = {
    Text = "Completamento entro 11 turni"
  },
  Task_11072_Name = {
    Text = "Completamento entro 11 turni"
  },
  Task_11073_Desc = {
    Text = "Livello completato"
  },
  Task_11073_Name = {
    Text = "Completa il livello"
  },
  Task_11074_Desc = {
    Text = "Livello completato"
  },
  Task_11074_Name = {
    Text = "Completa il livello"
  },
  Task_11075_Desc = {
    Text = "Livello completato"
  },
  Task_11075_Name = {
    Text = "Completa il livello"
  },
  Task_11076_Desc = {
    Text = "Completamento entro 31 turni"
  },
  Task_11076_Name = {
    Text = "Completamento entro 31 turni"
  },
  Task_11077_Desc = {
    Text = "Possiedi quattro Risvegliatori del Caos di livello 50"
  },
  Task_11077_Name = {
    Text = "Signore del Caos V"
  },
  Task_11078_Desc = {
    Text = "Possiedi quattro Risvegliatori del Caos di Livello 40"
  },
  Task_11078_Name = {
    Text = "Signore del Caos IV"
  },
  Task_11079_Desc = {
    Text = "Possiedi 4 Risvegliatori di Caro di Livello 10"
  },
  Task_11079_Name = {
    Text = "Signore della Caro"
  },
  Task_11080_Desc = {
    Text = "Possiedi quattro Risvegliatori del Caos di livello 60"
  },
  Task_11080_Name = {
    Text = "Signore del Caos VI"
  },
  Task_11081_Desc = {
    Text = "Possiedi quattro Risvegliatori del Caos di livello 10"
  },
  Task_11081_Name = {
    Text = "Signore del Caos"
  },
  Task_11082_Desc = {
    Text = "Possiedi quattro Risvegliatori del Caos di Livello 30"
  },
  Task_11082_Name = {
    Text = "Signore del Caos III"
  },
  Task_11083_Desc = {
    Text = "Possiedi quattro Risvegliatori del Caos di livello 20"
  },
  Task_11083_Name = {
    Text = "Signore del Caos II"
  },
  Task_11084_Desc = {
    Text = "Attiva la Resistenza alla morte 4 volte in una battaglia e ottieni la vittoria in questo turno."
  },
  Task_11084_Name = {
    Text = "Lotta all'ultimo sangue"
  },
  Task_11085_Desc = {
    Text = "Attacca il nemico 15 volte con Predazione del tentacolo in un solo turno e ottieni la vittoria in questa partita."
  },
  Task_11085_Name = {
    Text = "Signore di Lemuria"
  },
  Task_11086_Desc = {
    Text = "Attiva 5 Salti durante un Turno Ultra e ottieni la vittoria."
  },
  Task_11086_Name = {
    Text = "Saltatore Dimensionale"
  },
  Task_11087_Desc = {
    Text = "Divora 5 Embrioni e ottieni la vittoria in un round."
  },
  Task_11087_Name = {Text = "Affamato"},
  Task_11088_Desc = {
    Text = "Vinci giocando 15 carte in un singolo turno"
  },
  Task_11088_Name = {
    Text = "Tocca a me!"
  },
  Task_11089_Desc = {
    Text = "Gioca 6 Carte sintomo in un turno e vinci"
  },
  Task_11089_Name = {
    Text = "Paziente critico"
  },
  Task_11090_Desc = {
    Text = "Gioca 10 carte Colpo in un singolo turno e ottieni la vittoria."
  },
  Task_11090_Name = {
    Text = "Colpo Infinito"
  },
  Task_11091_Desc = {
    Text = "Vinci la battaglia con un totale di 8 o meno carte tra quelle In Mano, nella Pila degli scarti e nel Mazzo di Pesca."
  },
  Task_11091_Name = {
    Text = "Tasche Vuote"
  },
  Task_11092_Desc = {
    Text = "Caccia \"24\""
  },
  Task_11092_Name = {Text = "Bersaglio"},
  Task_11094_Desc = {
    Text = "Completa l'Evento d'Indagine \"Attenti ai Segugi\" in difficoltà Difficile"
  },
  Task_11094_Name = {
    Text = "L'Occhio Oltre le Dimensioni: Hard"
  },
  Task_11095_Desc = {
    Text = "Consuma 500000 Certificati Rosa"
  },
  Task_11095_Name = {
    Text = "Spendaccione"
  },
  Task_11096_Desc = {
    Text = "Consuma 1000000 Certificati Rosa"
  },
  Task_11096_Name = {
    Text = "Spendaccione II"
  },
  Task_11097_Desc = {
    Text = "Vittoria sul Boss: 1200 pti"
  },
  Task_11097_Name = {
    Text = "Sconfiggi il Boss <size=20><color=#747474>Vittoria sul Boss: 1200 punti</color></size>"
  },
  Task_11098_Desc = {
    Text = "Vinci la Battaglia finale entro 9 turni"
  },
  Task_11098_Name = {
    Text = "Vinci la Battaglia finale entro 9 turni"
  },
  Task_11099_Desc = {
    Text = "Torna dal padrone"
  },
  Task_11099_Name = {Text = "Bersaglio"},
  Task_11100_Desc = {
    Text = "Indaga sulla fonte del suono"
  },
  Task_11100_Name = {Text = "Bersaglio"},
  Task_11101_Desc = {
    Text = "Vinci la Battaglia finale entro 8 turni"
  },
  Task_11101_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_11102_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_11102_Name = {
    Text = "Superamento Perfetto"
  },
  Task_11103_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_11103_Name = {
    Text = "Superamento Perfetto"
  },
  Task_11104_Desc = {
    Text = "Vinci la Battaglia finale entro 15 turni"
  },
  Task_11104_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_11105_Desc = {
    Text = "Livello completato"
  },
  Task_11105_Name = {
    Text = "Completa il livello"
  },
  Task_11106_Desc = {
    Text = "Possiedi 4 Risvegliatori di Caro di Livello 30"
  },
  Task_11106_Name = {
    Text = "Signore della Caro III"
  },
  Task_11107_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_11107_Name = {
    Text = "Superamento Perfetto"
  },
  Task_11108_Desc = {
    Text = "Trova la Scultura di Cera \"Primavera\""
  },
  Task_11108_Name = {Text = "Bersaglio"},
  Task_11109_Desc = {
    Text = "Attraversa il ponte"
  },
  Task_11109_Name = {Text = "Bersaglio"},
  Task_11111_Desc = {
    Text = "Livello completato"
  },
  Task_11111_Name = {
    Text = "Completa il livello"
  },
  Task_11112_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_11112_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_11113_Desc = {
    Text = "Raggiungere il Cacciatore di Teschi"
  },
  Task_11113_Name = {Text = "Bersaglio"},
  Task_11114_Desc = {
    Text = "Vinci la Battaglia finale entro 8 turni"
  },
  Task_11114_Name = {
    Text = "Vinci la Battaglia finale entro 8 turni"
  },
  Task_11115_Desc = {
    Text = "Completamento entro 58 turni"
  },
  Task_11115_Name = {
    Text = "Completamento entro 58 turni"
  },
  Task_11116_Desc = {
    Text = "Completa una Missione Quotidiana"
  },
  Task_11116_Name = {
    Text = "Sfida Giornaliera"
  },
  Task_11117_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_11117_Name = {
    Text = "Superamento Perfetto"
  },
  Task_11118_Desc = {
    Text = "Livello completato"
  },
  Task_11118_Name = {
    Text = "Completa il livello"
  },
  Task_11119_Desc = {
    Text = "Elimina l'Entità Dissolta"
  },
  Task_11119_Name = {Text = "Bersaglio"},
  Task_11120_Desc = {
    Text = "Livello completato"
  },
  Task_11120_Name = {
    Text = "Completa il livello"
  },
  Task_11121_Desc = {
    Text = "Sali sulla scialuppa di salvataggio"
  },
  Task_11121_Name = {Text = "Bersaglio"},
  Task_11122_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_11122_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_11123_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_11123_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_11124_Desc = {
    Text = "Livello completato"
  },
  Task_11124_Name = {
    Text = "Completa il livello"
  },
  Task_11125_Desc = {
    Text = "Completa tutte le missioni di questo capitolo per ottenere le ricompense."
  },
  Task_11125_Name = {
    Text = "Padronanza del Reame IV"
  },
  Task_11126_Desc = {
    Text = "Completa 200 raffinazioni di elisir"
  },
  Task_11126_Name = {
    Text = "Farmacologa geniale III"
  },
  Task_11128_Desc = {
    Text = "Completato senza Corpo di Gnosi d'Emergenza"
  },
  Task_11128_Name = {
    Text = "Senza resurrezione <size=20><color=#747474>Completa senza Corpo di Gnosi d'Emergenza</color></size>"
  },
  Task_11129_Desc = {
    Text = "Torna alla reception e trova Pandia"
  },
  Task_11129_Name = {Text = "Bersaglio"},
  Task_11130_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_11130_Name = {
    Text = "Superamento Perfetto"
  },
  Task_11135_Desc = {
    Text = "Fuggi da Miryam"
  },
  Task_11135_Name = {Text = "Bersaglio"},
  Task_11136_Desc = {
    Text = "Potenzia le Abilità dei Risvegliatori 6 volte"
  },
  Task_11136_Name = {Text = "Compito 4"},
  Task_11137_Desc = {
    Text = "Completa il Dominio Arcano una volta"
  },
  Task_11137_Name = {Text = "Compito 5"},
  Task_11138_Desc = {
    Text = "Sintetizza materiali una volta"
  },
  Task_11138_Name = {Text = "Compito 1"},
  Task_11139_Desc = {
    Text = "Porta 4 Risvegliatori al Lv. 30"
  },
  Task_11139_Name = {Text = "Compito 2"},
  Task_11140_Desc = {
    Text = "Supera Dominio del Caos: Fessura IV"
  },
  Task_11140_Name = {Text = "Compito 3"},
  Task_11141_Desc = {
    Text = "Completamento entro 39 turni"
  },
  Task_11141_Name = {
    Text = "Completamento entro 39 turni"
  },
  Task_11142_Desc = {
    Text = "Completamento entro 33 turni"
  },
  Task_11142_Name = {
    Text = "Completamento entro 33 turni"
  },
  Task_11143_Desc = {
    Text = "Completamento entro 54 turni"
  },
  Task_11143_Name = {
    Text = "Completamento entro 54 turni"
  },
  Task_11144_Desc = {
    Text = "Completamento entro 48 turni"
  },
  Task_11144_Name = {
    Text = "Completamento entro 48 turni"
  },
  Task_11145_Desc = {
    Text = "Completamento entro 14 turni"
  },
  Task_11145_Name = {
    Text = "Completamento entro 14 turni"
  },
  Task_11146_Desc = {
    Text = "Completa il livello in meno di 50 mosse"
  },
  Task_11146_Name = {
    Text = "Pianificazione Strategica"
  },
  Task_11147_Desc = {
    Text = "Completamento entro 26 turni"
  },
  Task_11147_Name = {
    Text = "Completamento entro 26 turni"
  },
  Task_11148_Desc = {
    Text = "Completamento entro 20 turni"
  },
  Task_11148_Name = {
    Text = "Completamento entro 20 turni"
  },
  Task_11149_Desc = {
    Text = "Livello completato"
  },
  Task_11149_Name = {
    Text = "Completa il livello"
  },
  Task_11150_Desc = {
    Text = "Completamento entro 66 turni"
  },
  Task_11150_Name = {
    Text = "Completamento entro 66 turni"
  },
  Task_11151_Desc = {
    Text = "Completamento entro 60 turni"
  },
  Task_11151_Name = {
    Text = "Completamento entro 60 turni"
  },
  Task_11152_Desc = {
    Text = "Completa tutti i compiti per riscuotere le ricompense"
  },
  Task_11152_Name = {Text = "Fase VI"},
  Task_11153_Desc = {
    Text = "Completa tutte le missioni di questo capitolo per ottenere le ricompense."
  },
  Task_11153_Name = {
    Text = "Padronanza del Reame I"
  },
  Task_11154_Desc = {
    Text = "Livello completato"
  },
  Task_11154_Name = {
    Text = "Completa il livello"
  },
  Task_11155_Desc = {
    Text = "Non avere più di 3 Sintomi al completamento"
  },
  Task_11155_Name = {
    Text = "Mente Limpida"
  },
  Task_11156_Desc = {
    Text = "Completamento Storia Principale Capitolo 1 \"L'enigma del Distretto Est\""
  },
  Task_11157_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_11157_Name = {
    Text = "Superamento Perfetto"
  },
  Task_116471_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame di Aequor per vincere due volte in \"Sangue Amaro Condiviso\""
  },
  Task_116472_Desc = {
    Text = "Completamento di \"Sollevato dal Vento\" a qualsiasi difficoltà"
  },
  Task_116473_Desc = {
    Text = "Sangue Amaro Condiviso: Completato"
  },
  Task_116474_Desc = {
    Text = "Completamento di \"Ali Gemelle\" a Difficoltà Follia"
  },
  Task_116475_Desc = {
    Text = "Completa \"Fiaba dell'Avventuriero\" a qualsiasi difficoltà"
  },
  Task_116476_Desc = {
    Text = "Completamento del Paesaggio Onirico \"Oltre i cieli: Parte II\""
  },
  Task_116477_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere una volta in \"Sangue Amaro Condiviso\""
  },
  Task_116478_Desc = {
    Text = "Completa \"Veleno dell'Oblio\" a qualsiasi difficoltà"
  },
  Task_116479_Desc = {
    Text = "Completa \"L'età dell'innocenza\" a qualsiasi difficoltà"
  },
  Task_116480_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame del Caos per vincere due volte in \"Sangue Amaro Condiviso\""
  },
  Task_116481_Desc = {
    Text = "Completa tutti gli obiettivi in \"Sangue Amaro Condiviso: Completato\""
  },
  Task_116482_Desc = {
    Text = "Completamento de \"L'età dell'innocenza\" a Difficoltà Follia"
  },
  Task_116483_Desc = {
    Text = "Completa \"Risveglio Silenzioso\" a qualsiasi difficoltà"
  },
  Task_116484_Desc = {
    Text = "Completa \"Il Vecchio Registro\" a qualsiasi difficoltà"
  },
  Task_116485_Desc = {
    Text = "Completa \"Il Vecchio Registro\" a qualsiasi difficoltà"
  },
  Task_116486_Desc = {
    Text = "Sangue Amaro Condiviso: Follia"
  },
  Task_116487_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame di Aequor per vincere una volta in \"Sangue Amaro Condiviso\""
  },
  Task_116488_Desc = {
    Text = "Sangue Amaro Condiviso: Reame"
  },
  Task_116489_Desc = {
    Text = "Completamento di \"Ali Gemelle\" a qualsiasi difficoltà"
  },
  Task_116490_Desc = {
    Text = "Completa \"Veleno dell'Oblio\" a qualsiasi difficoltà"
  },
  Task_116491_Desc = {
    Text = "Completamento di \"Fiaba dell'Avventuriero\" a Difficoltà Follia"
  },
  Task_116492_Desc = {
    Text = "Completamento de \"Il Vecchio Registro\" a Difficoltà Follia"
  },
  Task_116493_Desc = {
    Text = "Completamento di \"Sollevato dal Vento\" a qualsiasi difficoltà"
  },
  Task_116494_Desc = {
    Text = "Completamento di \"Risveglio Silenzioso\" a Difficoltà Follia"
  },
  Task_116495_Desc = {
    Text = "Completa \"Fiaba dell'Avventuriero\" a qualsiasi difficoltà"
  },
  Task_116496_Desc = {
    Text = "Completa \"L'età dell'innocenza\" a qualsiasi difficoltà"
  },
  Task_116497_Desc = {
    Text = "Completamento di \"Veleno dell'Oblio\" a Difficoltà Follia"
  },
  Task_116498_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Caro per vincere due volte in \"Sangue Amaro Condiviso\""
  },
  Task_116499_Desc = {
    Text = "Completamento di \"Sollevato dal Vento\" a Difficoltà Follia"
  },
  Task_116500_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Caro per vincere una volta in \"Sangue Amaro Condiviso\""
  },
  Task_116501_Desc = {
    Text = "Completamento di \"Ali Gemelle\" a qualsiasi difficoltà"
  },
  Task_116502_Desc = {
    Text = "Completa \"Risveglio Silenzioso\" a qualsiasi difficoltà"
  },
  Task_116503_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere due volte in \"Sangue Amaro Condiviso\""
  },
  Task_116504_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame del Caos per vincere una volta in \"Sangue Amaro Condiviso\""
  },
  Task_116767_Desc = {
    Text = "Completa la Prova di Pollux 1 volta"
  },
  Task_116768_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_116769_Desc = {
    Text = "Supera il Dominio Arcano una volta"
  },
  Task_116770_Desc = {
    Text = "Supera il Dominio Arcano una volta"
  },
  Task_116771_Desc = {
    Text = "Completa 20 Incarichi"
  },
  Task_116772_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_116773_Desc = {
    Text = "Completa 4 Missioni Quotidiane"
  },
  Task_116774_Desc = {
    Text = "Completa 20 Incarichi"
  },
  Task_116775_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_116776_Desc = {
    Text = "Completa 4 Missioni Quotidiane"
  },
  Task_116777_Desc = {
    Text = "Consuma 1500 Menofina"
  },
  Task_116778_Desc = {
    Text = "Consuma 1500 Menofina"
  },
  Task_116779_Desc = {
    Text = "Risveglio 30 volte"
  },
  Task_116780_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_116781_Desc = {
    Text = "Risveglio 30 volte"
  },
  Task_116782_Desc = {
    Text = "Completa la Prova di Pollux 1 volta"
  },
  Task_116793_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_116793_Name = {Text = "3 vittorie"},
  Task_116794_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_116794_Name = {Text = "1 vittoria"},
  Task_116795_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_116795_Name = {Text = "6 vittorie"},
  Task_116796_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_116796_Name = {
    Text = "10 vittorie"
  },
  Task_116809_Desc = {
    Text = "Completa il Paesaggio Onirico \"Arrivederci, Terra di Mai\""
  },
  Task_116809_Name = {
    Text = "Frammenti di un Sogno"
  },
  Task_116810_Desc = {
    Text = "Completa il Paesaggio Onirico \"Arrivederci, Terra di Mai\" a difficoltà ardua"
  },
  Task_116810_Name = {
    Text = "Frammenti di un Sogno: Difficile"
  },
  Task_116820_Name = {
    Text = "Sconfiggi il BOSS 3N volte"
  },
  Task_116821_Name = {
    Text = "Sconfiggi il BOSS 6N volte"
  },
  Task_116822_Name = {
    Text = "Uccidere tutti i BOSS"
  },
  Task_116823_Name = {
    Text = "Sconfiggi il BOSS 5N volte"
  },
  Task_116824_Name = {
    Text = "Sconfiggi il BOSS 1N volte"
  },
  Task_116825_Name = {
    Text = "Sconfiggi il BOSS 4N volte"
  },
  Task_116826_Name = {
    Text = "Sconfiggi il BOSS 7N volte"
  },
  Task_116827_Name = {
    Text = "Sconfiggi il BOSS 2N volte"
  },
  Task_116884_Desc = {
    Text = "Accesso: 11 giorni"
  },
  Task_116885_Desc = {
    Text = "Accesso: 13 giorni"
  },
  Task_116886_Desc = {
    Text = "Accedi per un totale di 7 giorni"
  },
  Task_116887_Desc = {
    Text = "Accesso: 9 giorni"
  },
  Task_116888_Desc = {
    Text = "Accedi per un totale di 10 giorni"
  },
  Task_116890_Desc = {
    Text = "Accedi per un totale di 8 giorni"
  },
  Task_116891_Desc = {
    Text = "Accesso: 16 giorni"
  },
  Task_116892_Desc = {
    Text = "Accedi per un totale di 15 giorni"
  },
  Task_116894_Desc = {
    Text = "Accedi per un totale di 4 giorni"
  },
  Task_116895_Desc = {
    Text = "Accedi per 5 giorni cumulativi"
  },
  Task_116896_Desc = {
    Text = "Accedi per 3 giorni cumulativi"
  },
  Task_116897_Desc = {
    Text = "Accesso cumulativo per 6 giorni"
  },
  Task_116899_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_116900_Desc = {
    Text = "Accesso: 14 giorni"
  },
  Task_116901_Desc = {
    Text = "Accedi per un totale di 2 giorni"
  },
  Task_116903_Desc = {
    Text = "Accesso: 12 giorni"
  },
  Task_117156_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere una volta in \"Città nel Lago\""
  },
  Task_117157_Desc = {
    Text = "Vinci una volta nella \"Città nel Lago\" usando un qualsiasi Risvegliatore di Caro"
  },
  Task_117158_Desc = {
    Text = "Vinci una volta nella \"Città nel Lago\" usando un qualsiasi Risvegliatore del Reame Ultra"
  },
  Task_117159_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere una volta in \"Città nel Lago\""
  },
  Task_117304_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_117304_Name = {Text = "1 vittoria"},
  Task_117305_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_117305_Name = {Text = "6 vittorie"},
  Task_117306_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_117306_Name = {Text = "3 vittorie"},
  Task_117307_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_117307_Name = {
    Text = "10 vittorie"
  },
  Task_117487_Desc = {
    Text = "Completa il Paesaggio Onirico \"Arrivederci, Terra di Mai\" in difficoltà ardua"
  },
  Task_117487_Name = {
    Text = "Mai dire mai: Difficile"
  },
  Task_117488_Desc = {
    Text = "Completa il Paesaggio Onirico \"Arrivederci, Terra di Mai\""
  },
  Task_117488_Name = {
    Text = "Mai dire mai"
  },
  Task_117489_Desc = {
    Text = "Completa il Paesaggio Onirico \"Oltre i cieli: Parte II\""
  },
  Task_117489_Name = {
    Text = "Sopra il cielo azzurro"
  },
  Task_118481_Desc = {
    Text = "Salva Murphy"
  },
  Task_118481_Name = {Text = "Bersaglio"},
  Task_118482_Desc = {
    Text = "Irrompi nella scena del rito per salvare Murphy"
  },
  Task_118482_Name = {Text = "Bersaglio"},
  Task_118483_Desc = {
    Text = "Rientra nel \"Paradise\""
  },
  Task_118483_Name = {Text = "Bersaglio"},
  Task_118484_Desc = {
    Text = "Solleva il velo dei sogni"
  },
  Task_118484_Name = {Text = "Bersaglio"},
  Task_118485_Desc = {
    Text = "Osserva il Rito della Navigazione"
  },
  Task_118485_Name = {Text = "Bersaglio"},
  Task_118486_Desc = {
    Text = "Contrasta gli sciami di pesci"
  },
  Task_118486_Name = {Text = "Bersaglio"},
  Task_118487_Desc = {
    Text = "Respingi i Navigatori all'inseguimento"
  },
  Task_118487_Name = {Text = "Bersaglio"},
  Task_118488_Desc = {
    Text = "Raggiungi la fine del sentiero"
  },
  Task_118488_Name = {Text = "Bersaglio"},
  Task_118489_Desc = {
    Text = "Elimina il \"Sé\""
  },
  Task_118489_Name = {Text = "Bersaglio"},
  Task_118490_Desc = {
    Text = "Salva Murphy nel mezzo del caos"
  },
  Task_118490_Name = {Text = "Bersaglio"},
  Task_118787_Desc = {
    Text = "Inno del Grembo"
  },
  Task_118791_Desc = {
    Text = "Catena dell'oscurità"
  },
  Task_118796_Desc = {
    Text = "Reliquie della Sabbia"
  },
  Task_118799_Desc = {
    Text = "Nave del Mare Oscuro"
  },
  Task_118809_Desc = {
    Text = "Muro di Sabbie Desertiche"
  },
  Task_118821_Desc = {
    Text = "Segreti Scolpiti"
  },
  Task_118826_Desc = {
    Text = "Residuo Caotico"
  },
  Task_118835_Desc = {
    Text = "Residuo abissale"
  },
  Task_118837_Desc = {
    Text = "Museo delle Cere Frenetico"
  },
  Task_118842_Desc = {
    Text = "Caccia ai buoni rosa"
  },
  Task_118845_Desc = {
    Text = "Mare Esterno alla Tempesta"
  },
  Task_118852_Desc = {
    Text = "Residuo Organico"
  },
  Task_118856_Desc = {
    Text = "Città della Follia"
  },
  Task_118860_Desc = {
    Text = "Lacrime della Bambola"
  },
  Task_118871_Desc = {
    Text = "Gola di Schwarzschild"
  },
  Task_118873_Desc = {
    Text = "La Tana del Verme"
  },
  Task_118877_Desc = {
    Text = "Tempra delle Pozioni"
  },
  Task_118879_Desc = {
    Text = "Ammasso del Caos"
  },
  Task_118881_Desc = {
    Text = "Fessura Primordiale"
  },
  Task_118892_Desc = {
    Text = "Presa della Pietà"
  },
  Task_118907_Desc = {
    Text = "Rovine di Pohnpei"
  },
  Task_118913_Desc = {
    Text = "Ombra dall'Oltre"
  },
  Task_118915_Desc = {
    Text = "Maree della Pozza Nera"
  },
  Task_118917_Desc = {
    Text = "Residuo Cosmico"
  },
  Task_118918_Desc = {
    Text = "Montagne distorte"
  },
  Task_118922_Desc = {
    Text = "Città della grande nebbia"
  },
  Task_118979_Desc = {
    Text = "Imprese Modalità Selezione a Turno"
  },
  Task_118980_Desc = {
    Text = "Vinci 20 volte senza utilizzare Risvegliatori \"<color=#ae6abb>Luminis</color>\""
  },
  Task_118981_Desc = {
    Text = "Invia \"Ciao\" o \"Salve\" a 3 rivali durante la battaglia"
  },
  Task_118982_Desc = {
    Text = "Raggiungi 500 punti nella Modalità Selezione Libera"
  },
  Task_118983_Desc = {
    Text = "Vinci 20 volte senza utilizzare Risvegliatori \"<color=#76bf9d>Benedizione</color>\""
  },
  Task_118984_Desc = {
    Text = "Raggiungi 1000 punti nella Modalità Selezione a Turno"
  },
  Task_118985_Desc = {
    Text = "Raggiungi 2500 punti nella Modalità Selezione a Turno"
  },
  Task_118986_Desc = {
    Text = "Completa tutti i traguardi di \"Per Iniziare\""
  },
  Task_118987_Desc = {
    Text = "Vinci 20 volte senza utilizzare Risvegliatori \"<color=#6a97c2>Guardiano</color>\""
  },
  Task_118988_Desc = {
    Text = "Per iniziare"
  },
  Task_118989_Desc = {
    Text = "Equipaggia 16 emote contemporaneamente in \"Emote di Sfida\" per partecipare alle battaglie Traphase"
  },
  Task_118990_Desc = {
    Text = "Copia la formazione del rivale al termine della battaglia Traphase"
  },
  Task_118991_Desc = {
    Text = "Partecipa una volta alla \"Modalità Selezione a Turno\""
  },
  Task_118992_Desc = {
    Text = "Raggiungi 2000 punti nella Modalità Selezione Libera"
  },
  Task_118993_Desc = {
    Text = "Raggiungi 2000 punti nella Modalità Selezione a Turno"
  },
  Task_118994_Desc = {
    Text = "Raggiungi 500 punti nella Modalità Selezione a Turno"
  },
  Task_118995_Desc = {
    Text = "Scegli \"Ancora un round\" dopo la battaglia Traphase con il Rivale."
  },
  Task_118996_Desc = {
    Text = "Raggiungi 1000 punti nella Modalità Selezione Libera"
  },
  Task_118997_Desc = {
    Text = "Vinci 20 volte senza utilizzare Risvegliatori \"<color=#c26669>Nato in Guerra</color>\""
  },
  Task_118998_Desc = {
    Text = "Metti \"Mi piace\" ai commenti delle carte in \"Collezione\""
  },
  Task_118999_Desc = {
    Text = "Prova i Risvegliatori tramite \"Livello di Prova del Risvegliatore\" in \"Collezione\" e sconfiggi 1 \"Gatto Nero Familiare\""
  },
  Task_119000_Desc = {
    Text = "Raggiungi 3000 punti nella Modalità Selezione Libera"
  },
  Task_119001_Desc = {
    Text = "Partecipa una volta alla \"Modalità Selezione Libera\""
  },
  Task_119002_Desc = {
    Text = "Raggiungi 1500 punti nella Modalità Selezione Libera"
  },
  Task_119003_Desc = {
    Text = "Raggiungi 3000 punti nella Modalità Selezione a Turno"
  },
  Task_119004_Desc = {
    Text = "Raggiungi 1500 punti nella Modalità Selezione a Turno"
  },
  Task_119005_Desc = {
    Text = "Imprese Modalità Selezione Libera"
  },
  Task_119006_Desc = {
    Text = "Guarda una volta il Replay di Traphase nel Profilo Custode - Registri di Battaglia"
  },
  Task_119007_Desc = {
    Text = "Partecipa una volta alla \"Modalità Password\""
  },
  Task_119008_Desc = {
    Text = "Raggiungi 2500 punti nella Modalità Selezione Libera"
  },
  Task_119009_Desc = {
    Text = "Vinci 20 volte senza utilizzare Risvegliatori \"<color=#c3aa64>Malphas</color>\""
  },
  Task_119010_Desc = {
    Text = "Maestro di Traphase"
  },
  Task_119193_Desc = {
    Text = "Estrai 68000 Essenza di Silver Core"
  },
  Task_119201_Desc = {
    Text = "Estrai 54000 Essenza di Silver Core"
  },
  Task_119212_Desc = {
    Text = "Estrai 42000 Essenza di Silver Core"
  },
  Task_119216_Desc = {
    Text = "Estrai 48000 Essenza di Silver Core"
  },
  Task_119217_Desc = {
    Text = "Estrai 36000 Essenza di Silver Core"
  },
  Task_119695_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_119696_Desc = {
    Text = "Completa il Capitolo dell'Oblio Capitolo 4 \"Dove regna il silenzio\""
  },
  Task_119697_Desc = {
    Text = "Completa il Capitolo 4 del Capitolo Astrale \"Paradise.\""
  },
  Task_119698_Desc = {
    Text = "Usa l'Abilità di posse 200 volte"
  },
  Task_119699_Desc = {
    Text = "Completamento Capitolo dell'Oblio Capitolo 7 \"Flusso del Desiderio\""
  },
  Task_120441_Desc = {
    Text = "Completa il Capitolo 7 dell'Indagine"
  },
  Task_120500_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_120501_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_120502_Desc = {
    Text = "\"Ottieni 2 Risonanze nell'Evento d'Indagine \"@1@2\".\""
  },
  Task_120502_Desc2 = {
    Text = "Ottieni 2 Risonanze nell'Evento d'Indagine \"Paradise\""
  },
  Task_120502_Name2 = {
    Text = "Eco del Delirio"
  },
  Task_120503_Desc = {
    Text = "Completa l'evento d'indagine \"@1@2\""
  },
  Task_120503_Desc2 = {
    Text = "Completa l'Evento d'Indagine \"Paradise\""
  },
  Task_120503_Name2 = {
    Text = "Paradiso Perduto"
  },
  Task_120504_Desc = {
    Text = "Completa il Capitolo 4 del Capitolo Astrale a difficoltà 4-6"
  },
  Task_120505_Desc = {
    Text = "Completa l'Evento d'Indagine \"Paradise\" a difficoltà Difficile"
  },
  Task_120505_Name = {
    Text = "Paradiso Perduto: Difficile"
  },
  Task_120506_Desc = {
    Text = "Risuona 6 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_120506_Desc2 = {
    Text = "Ottieni 6 Risonanze nell'Evento d'Indagine \"Paradise\""
  },
  Task_120506_Name2 = {
    Text = "Eco del Delirio III"
  },
  Task_120507_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_120508_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_120509_Desc = {
    Text = "Completa il Capitolo 4 del Capitolo Astrale \"Paradise\" a difficoltà difficile"
  },
  Task_120510_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_120511_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_120512_Desc = {
    Text = "Completa il Capitolo 4 del Capitolo Astrale a difficoltà 4-6"
  },
  Task_120514_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_120515_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_120516_Desc = {
    Text = "Completa il Capitolo 4 del Capitolo Astrale a difficoltà 4-5 (difficile)"
  },
  Task_120517_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_120518_Desc = {
    Text = "Completa il Capitolo 4 del Capitolo Astrale a difficoltà 4-5 (difficile)"
  },
  Task_120519_Desc = {
    Text = "Completa il Capitolo 4 del Capitolo Astrale \"Paradise.\""
  },
  Task_120520_Desc = {
    Text = "Risuona 7 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_120520_Desc2 = {
    Text = "Ottieni 7 Risonanze nell'Evento d'Indagine \"Paradise\""
  },
  Task_120520_Name2 = {
    Text = "Eco del Delirio IV"
  },
  Task_120521_Desc = {
    Text = "Completa il Capitolo 4 del Capitolo Astrale \"Paradise\" a difficoltà difficile"
  },
  Task_120522_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_120523_Desc = {
    Text = "\"Ottieni 4 Risonanze nell'Evento d'Indagine \"@1@2\".\""
  },
  Task_120523_Desc2 = {
    Text = "Ottieni 4 Risonanze nell'Evento d'Indagine \"Paradise\""
  },
  Task_120523_Name2 = {
    Text = "Eco del Delirio II"
  },
  Task_120524_Desc = {
    Text = "Completa il Capitolo 4 del Capitolo Astrale \"Paradise.\""
  },
  Task_120535_Desc = {
    Text = "Completa il Capitolo dell'Oblio Capitolo 4 \"Dove regna il silenzio\""
  },
  Task_120536_Desc = {
    Text = "Completamento Capitolo dell'Oblio Capitolo 7 \"Flusso del Desiderio\""
  },
  Task_120537_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_120538_Desc = {
    Text = "Completa il Capitolo 4 del Capitolo Astrale \"Paradise.\""
  },
  Task_120549_Desc = {
    Text = "Combatti 100 partite in Traphase senza arrenderti"
  },
  Task_120850_Desc = {
    Text = "Completa 1 \"Immersione Fantasmatica\" utilizzando solo Risvegliatori di Caro"
  },
  Task_120851_Desc = {
    Text = "Completa 1 \"Immersione Fantasmatica\" usando Risvegliatori Chaos e del Reame Ultra"
  },
  Task_120852_Desc = {
    Text = "Completa 1 \"Immersione Fantasmatica\" utilizzando solo Risvegliatori del Caos"
  },
  Task_120855_Desc = {
    Text = "Punteggio massimo nell'Immersione Fantasmatica: 1000"
  },
  Task_120856_Desc = {
    Text = "Completa 1 \"Immersione Fantasmatica\" usando Risvegliatori Chaos e Caro"
  },
  Task_120857_Desc = {
    Text = "Completa 5 volte a Difficoltà VI o superiore usando solo Risvegliatori del Caos"
  },
  Task_120862_Desc = {
    Text = "Completa 5 volte a Difficoltà VI o superiore usando solo Risvegliatori di Caro"
  },
  Task_120863_Desc = {
    Text = "Completa 5 volte a Difficoltà VI o superiore usando Risvegliatori del Caos e di Aequor"
  },
  Task_120864_Desc = {
    Text = "Completa 5 volte a Difficoltà VI o superiore usando Risvegliatori del Caos e del Reame Ultra"
  },
  Task_120865_Desc = {
    Text = "Completa 1 \"Immersione Fantasmatica\" usando Risvegliatori Aequor e del Reame Ultra"
  },
  Task_120867_Desc = {
    Text = "Completa 5 volte a Difficoltà VI o superiore utilizzando Risvegliatori di Aequor e di Caro"
  },
  Task_120868_Desc = {
    Text = "Immersione nell'Incubo"
  },
  Task_120869_Desc = {
    Text = "Completa 5 volte a Difficoltà VI o superiore usando solo Risvegliatori del Reame Ultra"
  },
  Task_120870_Desc = {
    Text = "Completa 5 volte a Difficoltà VI o superiore usando Risvegliatori del Caos e di Caro"
  },
  Task_120871_Desc = {
    Text = "Punteggio massimo raggiunto in Immersione Fantasmatica: 7000"
  },
  Task_120872_Desc = {
    Text = "Completa 1 \"Immersione Fantasmatica\" utilizzando solo Risvegliatori di Aequor"
  },
  Task_120873_Desc = {
    Text = "Completa 5 volte a Difficoltà VI o superiore usando solo Risvegliatori di Aequor"
  },
  Task_120876_Desc = {
    Text = "Viaggiatore del Reame"
  },
  Task_120878_Desc = {
    Text = "Punteggio massimo raggiunto in Immersione Fantasmatica: 6000"
  },
  Task_120879_Desc = {
    Text = "Completa 5 volte a Difficoltà VI o superiore usando Risvegliatori di Aequor e del Reame Ultra"
  },
  Task_120880_Desc = {
    Text = "Guarda una replica nella \"Classifica\" in \"Immersione Fantasmatica\""
  },
  Task_120882_Desc = {
    Text = "Completa 1 \"Immersione Fantasmatica\" utilizzando solo Risvegliatori del Reame Ultra"
  },
  Task_120883_Desc = {
    Text = "Completa 1 \"Immersione Fantasmatica\" utilizzando Risvegliatori del Caos e di Aequor"
  },
  Task_120884_Desc = {
    Text = "Completa 5 volte a Difficoltà VI o superiore utilizzando Risvegliatori di Caro e del Reame Ultra"
  },
  Task_120885_Desc = {
    Text = "Iniziato del Sogno"
  },
  Task_120889_Desc = {
    Text = "Punteggio massimo raggiunto in Immersione Fantasmatica: 5000"
  },
  Task_120890_Desc = {
    Text = "Completa un'\"Immersione Fantasmatica\""
  },
  Task_120891_Desc = {
    Text = "Copia la formazione una volta nella \"Classifica\" in \"Immersione Fantasmatica\""
  },
  Task_120892_Desc = {
    Text = "Punteggio massimo nell'Immersione Fantasmatica: 2000"
  },
  Task_120894_Desc = {
    Text = "Punteggio massimo nell'Immersione Fantasmatica: 4000"
  },
  Task_120895_Desc = {
    Text = "Punteggio massimo nell'Immersione Fantasmatica: 3000"
  },
  Task_120966_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_120966_Name = {Text = "3 vittorie"},
  Task_120967_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_120967_Name = {Text = "6 vittorie"},
  Task_120968_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_120968_Name = {
    Text = "10 vittorie"
  },
  Task_120969_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_120969_Name = {Text = "1 vittoria"},
  Task_120994_Desc = {
    Text = "Elimina tutti gli Avatar in Ouverture dissonante"
  },
  Task_120994_Name = {
    Text = "Uccidere il BOSS1"
  },
  Task_120995_Desc = {
    Text = "Elimina tutti gli Avatar in Armonia Invertita"
  },
  Task_120995_Name = {
    Text = "Uccidere il BOSS 4"
  },
  Task_120996_Name = {
    Text = "L'evento Boss Mondiale è terminato"
  },
  Task_120997_Desc = {
    Text = "Elimina tutti gli Avatar in Riposo Eterno"
  },
  Task_120997_Name = {
    Text = "Uccidere il BOSS 7"
  },
  Task_120998_Desc = {
    Text = "Elimina tutti gli Avatar in Ritmo Silente"
  },
  Task_120998_Name = {
    Text = "Uccidere il BOSS 3"
  },
  Task_120999_Desc = {
    Text = "Elimina tutti gli Avatar in Risonanza dell'Eresia"
  },
  Task_120999_Name = {
    Text = "Uccidere il BOSS 5"
  },
  Task_121000_Desc = {
    Text = "Elimina tutti gli Avatar in Finale della Follia"
  },
  Task_121000_Name = {
    Text = "Uccidere il BOSS 6"
  },
  Task_121001_Desc = {
    Text = "Elimina tutti gli Avatar in Preludio annullato"
  },
  Task_121001_Name = {
    Text = "Uccidere il BOSS2"
  },
  Task_121033_Desc = {
    Text = "Risveglio 30 volte"
  },
  Task_121035_Desc = {
    Text = "Completa 20 Incarichi"
  },
  Task_121040_Desc = {
    Text = "Completa 4 Missioni Quotidiane"
  },
  Task_121041_Desc = {
    Text = "Completa 20 Incarichi"
  },
  Task_121042_Desc = {
    Text = "Consuma 1500 Menofina"
  },
  Task_121044_Desc = {
    Text = "Supera il Dominio Arcano una volta"
  },
  Task_121045_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_121046_Desc = {
    Text = "Completa la Prova di Mouchette una volta"
  },
  Task_121047_Desc = {
    Text = "Risveglio 30 volte"
  },
  Task_121050_Desc = {
    Text = "Consuma 1500 Menofina"
  },
  Task_121051_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_121053_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_121054_Desc = {
    Text = "Completa 4 Missioni Quotidiane"
  },
  Task_121058_Desc = {
    Text = "Supera il Dominio Arcano una volta"
  },
  Task_121061_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_121062_Desc = {
    Text = "Completa la Prova di Mouchette una volta"
  },
  Task_121206_Desc = {
    Text = "Estrai 76000 Essenza di Silver Core"
  },
  Task_121207_Desc = {
    Text = "Estrai 84000 Essenza di Silver Core"
  },
  Task_121208_Desc = {
    Text = "Estrai 92000 Essenza di Silver Core"
  },
  Task_121233_Desc = {
    Text = "Ottieni tre stelle in \"Presa della Pietà IV\""
  },
  Task_121234_Desc = {
    Text = "Ottieni tre stelle in \"Segreti Scolpiti II\""
  },
  Task_121235_Desc = {
    Text = "Ottieni tre stelle in \"Residuo Organico III\""
  },
  Task_121236_Desc = {
    Text = "Ottieni tre stelle in \"Lacrime della Bambola V\""
  },
  Task_121237_Desc = {
    Text = "Ottieni tre stelle in \"Segreti Scolpiti III\""
  },
  Task_121238_Desc = {
    Text = "Ottieni tre stelle in \"Caccia ai buoni rosa I\""
  },
  Task_121239_Desc = {
    Text = "Ottieni tre stelle in \"Ombra dall'Oltre IV\""
  },
  Task_121240_Desc = {
    Text = "Ottieni tre stelle in \"Ammasso del Caos IV\""
  },
  Task_121241_Desc = {
    Text = "Ottieni tre stelle in \"Inno del Grembo II\""
  },
  Task_121242_Desc = {
    Text = "Ottieni tre stelle in \"Nave del Mare Oscuro III\""
  },
  Task_121243_Desc = {
    Text = "Ottieni tre stelle in \"Catena dell'oscurità III\""
  },
  Task_121244_Desc = {
    Text = "Ottieni tre stelle in \"Residuo abissale V\""
  },
  Task_121245_Desc = {
    Text = "Ottieni tre stelle in \"Residuo Cosmico I\""
  },
  Task_121246_Desc = {
    Text = "Ottieni tre stelle in \"Montagne distorte II\""
  },
  Task_121247_Desc = {
    Text = "Ottieni tre stelle in \"Città della grande nebbia II\""
  },
  Task_121248_Desc = {
    Text = "Ottieni tre stelle in \"Rovine di Pohnpei II\""
  },
  Task_121249_Desc = {
    Text = "Ottieni tre stelle in \"Residuo Organico II\""
  },
  Task_121250_Desc = {
    Text = "Ottieni tre stelle in \"Montagne distorte I\""
  },
  Task_121251_Desc = {
    Text = "Ottieni tre stelle in \"Residuo Cosmico II\""
  },
  Task_121252_Desc = {
    Text = "Ottieni tre stelle in \"Residuo Caotico IV\""
  },
  Task_121253_Desc = {
    Text = "Ottieni tre stelle in \"Museo delle Cere Frenetico II\""
  },
  Task_121254_Desc = {
    Text = "Ottieni tre stelle in \"Presa della Pietà I\""
  },
  Task_121255_Desc = {
    Text = "Ottieni tre stelle in \"Ammasso del Caos I\""
  },
  Task_121256_Desc = {
    Text = "Ottieni tre stelle in \"Segreti Scolpiti IV\""
  },
  Task_121257_Desc = {
    Text = "Ottieni tre stelle in \"Tana dei Vermi I\""
  },
  Task_121258_Desc = {
    Text = "Ottieni tre stelle in \"Muro di Sabbie Desertiche I\""
  },
  Task_121259_Desc = {
    Text = "Ottieni tre stelle in \"Lacrime della Bambola II\""
  },
  Task_121260_Desc = {
    Text = "Ottieni tre stelle in \"Presa della Pietà III\""
  },
  Task_121261_Desc = {
    Text = "Ottieni tre stelle in \"Ombra dall'Oltre III\""
  },
  Task_121262_Desc = {
    Text = "Ottieni tre stelle in \"Reliquie della Sabbia III\""
  },
  Task_121263_Desc = {
    Text = "Ottieni tre stelle in \"Ammasso del Caos II\""
  },
  Task_121264_Desc = {
    Text = "Ottieni tre stelle in \"Città della Follia I\""
  },
  Task_121265_Desc = {
    Text = "Ottieni tre stelle in \"Residuo abissale I\""
  },
  Task_121266_Desc = {
    Text = "Ottieni tre stelle in \"Reliquie della Sabbia I\""
  },
  Task_121267_Desc = {
    Text = "Ottieni tre stelle in \"Museo delle Cere Frenetico III\""
  },
  Task_121268_Desc = {
    Text = "Ottieni tre stelle in \"Residuo abissale IV\""
  },
  Task_121269_Desc = {
    Text = "Ottieni tre stelle in \"Gola di Schwarzschild IV\""
  },
  Task_121270_Desc = {
    Text = "Ottieni tre stelle in \"Residuo Cosmico III\""
  },
  Task_121271_Desc = {
    Text = "Ottieni tre stelle in \"Caccia ai buoni rosa IV\""
  },
  Task_121272_Desc = {
    Text = "Ottieni tre stelle in \"Residuo abissale III\""
  },
  Task_121273_Desc = {
    Text = "Ottieni tre stelle in \"Tempra delle Pozioni I\""
  },
  Task_121274_Desc = {
    Text = "Ottieni tre stelle in \"Segreti Scolpiti V\""
  },
  Task_121275_Desc = {
    Text = "Ottieni tre stelle in \"Reliquie della Sabbia II\""
  },
  Task_121276_Desc = {
    Text = "Ottieni tre stelle in \"Museo delle Cere Frenetico I\""
  },
  Task_121277_Desc = {
    Text = "Ottieni tre stelle in \"Montagne distorte III\""
  },
  Task_121278_Desc = {
    Text = "Ottieni tre stelle in \"Tempra delle Pozioni IV\""
  },
  Task_121279_Desc = {
    Text = "Ottieni tre stelle in \"Lacrime della Bambola III\""
  },
  Task_121280_Desc = {
    Text = "Ottieni tre stelle in \"Residuo Organico V\""
  },
  Task_121281_Desc = {
    Text = "Ottieni tre stelle in \"Nave del Mare Oscuro I\""
  },
  Task_121282_Desc = {
    Text = "Ottieni tre stelle in \"Maree della Pozza Nera II\""
  },
  Task_121283_Desc = {
    Text = "Ottieni tre stelle in \"Residuo Caotico III\""
  },
  Task_121284_Desc = {
    Text = "Ottieni tre stelle in \"Presa della Pietà II\""
  },
  Task_121285_Desc = {
    Text = "Ottieni tre stelle in \"Mare Esterno alla Tempesta I\""
  },
  Task_121286_Desc = {
    Text = "Ottieni tre stelle in \"Segreti Scolpiti I\""
  },
  Task_121287_Desc = {
    Text = "Ottieni tre stelle in \"Rovine di Pohnpei III\""
  },
  Task_121288_Desc = {
    Text = "Ottieni tre stelle in \"Inno del Grembo III\""
  },
  Task_121289_Desc = {
    Text = "Ottieni tre stelle in \"Residuo Organico IV\""
  },
  Task_121290_Desc = {
    Text = "Ottieni tre stelle in \"Residuo Organico I\""
  },
  Task_121291_Desc = {
    Text = "Ottieni tre stelle in \"Ombra dall'Oltre II\""
  },
  Task_121292_Desc = {
    Text = "Ottieni tre stelle in \"Inno del Grembo I\""
  },
  Task_121293_Desc = {
    Text = "Ottieni tre stelle in \"Gola di Schwarzschild III\""
  },
  Task_121294_Desc = {
    Text = "Ottieni tre stelle in \"Ombra dall'Oltre I\""
  },
  Task_121295_Desc = {
    Text = "Ottieni tre stelle in \"Caccia ai buoni rosa II\""
  },
  Task_121296_Desc = {
    Text = "Ottieni tre stelle in \"Tempra delle Pozioni V\""
  },
  Task_121297_Desc = {
    Text = "Ottieni tre stelle in \"Città della Follia II\""
  },
  Task_121298_Desc = {
    Text = "Ottieni tre stelle in \"Tempra delle Pozioni II\""
  },
  Task_121299_Desc = {
    Text = "Ottieni tre stelle in \"Gola di Schwarzschild II\""
  },
  Task_121300_Desc = {
    Text = "Ottieni tre stelle in \"Caccia ai buoni rosa V\""
  },
  Task_121301_Desc = {
    Text = "Ottieni tre stelle in \"Città della grande nebbia III\""
  },
  Task_121302_Desc = {
    Text = "Ottieni tre stelle in \"Tempra delle Pozioni III\""
  },
  Task_121303_Desc = {
    Text = "Ottieni tre stelle in \"Rovine di Pohnpei IV\""
  },
  Task_121304_Desc = {
    Text = "Ottieni tre stelle in \"Ammasso del Caos III\""
  },
  Task_121305_Desc = {
    Text = "Ottieni tre stelle in \"Città della grande nebbia I\""
  },
  Task_121306_Desc = {
    Text = "Ottieni tre stelle in \"Tana dei Vermi III\""
  },
  Task_121307_Desc = {
    Text = "Ottieni tre stelle in \"Residuo abissale II\""
  },
  Task_121308_Desc = {
    Text = "Ottieni tre stelle in \"Tana dei Vermi IV\""
  },
  Task_121309_Desc = {
    Text = "Ottieni tre stelle in \"Rovine di Pohnpei I\""
  },
  Task_121310_Desc = {
    Text = "Ottieni tre stelle in \"Residuo Caotico II\""
  },
  Task_121311_Desc = {
    Text = "Ottieni tre stelle in \"Residuo Cosmico V\""
  },
  Task_121312_Desc = {
    Text = "Ottieni tre stelle in \"Tana dei Vermi II\""
  },
  Task_121313_Desc = {
    Text = "Ottieni tre stelle nella \"Catena dell'oscurità II\""
  },
  Task_121314_Desc = {
    Text = "Ottieni tre stelle nel \"Residuo Cosmico IV\""
  },
  Task_121315_Desc = {
    Text = "Ottieni tre stelle nel \"Residuo Caotico V\""
  },
  Task_121316_Desc = {
    Text = "Ottieni tre stelle nella \"Catena dell'oscurità IV\""
  },
  Task_121317_Desc = {
    Text = "Ottieni tre stelle nella \"Catena dell'oscurità I\""
  },
  Task_121318_Desc = {
    Text = "Ottieni tre stelle nella \"Città della Follia III\""
  },
  Task_121319_Desc = {
    Text = "Ottieni tre stelle nelle \"Lacrime della Bambola I\""
  },
  Task_121320_Desc = {
    Text = "Ottieni tre stelle in \"Nave del Mare Oscuro II\""
  },
  Task_121321_Desc = {
    Text = "Ottieni tre stelle in \"Caccia ai buoni rosa III\""
  },
  Task_121322_Desc = {
    Text = "Ottieni tre stelle nella \"Catena dell'oscurità V\""
  },
  Task_121323_Desc = {
    Text = "Ottieni tre stelle nelle \"Lacrime della Bambola IV\""
  },
  Task_121324_Desc = {
    Text = "Ottieni tre stelle in \"Maree della Pozza Nera I\""
  },
  Task_121325_Desc = {
    Text = "Ottieni tre stelle nel \"Residuo Caotico I\""
  },
  Task_121326_Desc = {
    Text = "Ottieni tre stelle in \"Gola di Schwarzschild I\""
  },
  Task_121327_Desc = {
    Text = "Ottieni tre stelle nella \"Fessura Primordiale I\""
  },
  Task_121331_Desc = {
    Text = "Completa tutti i compiti in \"Iniziato del Sogno\""
  },
  Task_121332_Desc = {
    Text = "Completa 1 \"Immersione Fantasmatica\" usando Risvegliatori Aequor e di Caro"
  },
  Task_121333_Desc = {
    Text = "Completa 1 \"Immersione Fantasmatica\" usando Risvegliatori di Caro e del Reame Ultra"
  },
  Task_121834_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_121834_Name = {
    Text = "Superamento Perfetto"
  },
  Task_121835_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_121835_Name = {
    Text = "Superamento Perfetto"
  },
  Task_121836_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_121836_Name = {
    Text = "Superamento Perfetto"
  },
  Task_121837_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_121837_Name = {
    Text = "Superamento Perfetto"
  },
  Task_121838_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_121838_Name = {
    Text = "Superamento Perfetto"
  },
  Task_121839_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_121839_Name = {
    Text = "Superamento Perfetto"
  },
  Task_121840_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_121840_Name = {
    Text = "Superamento Perfetto"
  },
  Task_121841_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_121841_Name = {
    Text = "Superamento Perfetto"
  },
  Task_121842_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_121842_Name = {
    Text = "Superamento Perfetto"
  },
  Task_121843_Desc = {
    Text = "Sopporta tutte le Maledizioni e sconfiggi il \"Velo del Paradiso\" entro 15 turni."
  },
  Task_121843_Name = {
    Text = "Paradiso Perduto: Nascosto"
  },
  Task_121844_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_121844_Name = {
    Text = "Superamento Perfetto"
  },
  Task_121897_Desc = {
    Text = "Turni iniziali: 50. +20 pti per ogni turno rimanente. (Turni rimanenti: {s1})"
  },
  Task_121897_Name = {
    Text = "Clessidra del Tempo<size=20><color=#747474>Turni rimanenti iniziali: 50. Ottieni +20 punti per ogni turno rimanente.</color></size>"
  },
  Task_122110_Desc = {
    Text = "Ottieni 500 punti completando la P-Dive al primo tentativo ogni giorno."
  },
  Task_122110_Name = {
    Text = "Pioniere<size=20><color=#747474>Ottieni 500 punti completando la P-Dive al primo tentativo ogni giorno.</color></size>"
  },
  Task_122197_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere una volta ne \"L'Io Perduto\""
  },
  Task_122198_Desc = {
    Text = "Completa \"Dominio degli arti\" a Difficoltà Follia"
  },
  Task_122199_Desc = {
    Text = "Completa \"Spezzare il Cuore\" a Difficoltà Follia"
  },
  Task_122200_Desc = {
    Text = "Completa \"Escissione dell'Appendice\" a qualsiasi difficoltà"
  },
  Task_122201_Desc = {
    Text = "Completa \"Discorso di controllo\" a qualsiasi difficoltà"
  },
  Task_122202_Desc = {
    Text = "Completa \"Pensiero Istintivo\" a qualsiasi difficoltà"
  },
  Task_122203_Desc = {
    Text = "Completa \"Liberazione del Vero Sé\" a Difficoltà Follia"
  },
  Task_122204_Desc = {
    Text = "Completa \"Velare gli Occhi\" a Difficoltà Follia"
  },
  Task_122205_Desc = {
    Text = "Completa \"Spezzare il Cuore\" a qualsiasi difficoltà"
  },
  Task_122206_Desc = {
    Text = "Completa \"Discorso di controllo\" a qualsiasi difficoltà"
  },
  Task_122207_Desc = {
    Text = "Completa \"Escissione dell'Appendice\" a Difficoltà Follia"
  },
  Task_122208_Desc = {
    Text = "Completa \"Pensiero Istintivo\" a qualsiasi difficoltà"
  },
  Task_122209_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere una volta ne \"L'Io Perduto\""
  },
  Task_122210_Desc = {
    Text = "Completa \"Dominio degli arti\" a qualsiasi difficoltà"
  },
  Task_122211_Desc = {
    Text = "Completa \"Liberazione del Vero Sé\" a qualsiasi difficoltà"
  },
  Task_122212_Desc = {
    Text = "Completa il Collegamento Multiversale \"Battesimo d'Argento e Sangue\""
  },
  Task_122213_Desc = {
    Text = "Completa tutti gli obiettivi de \"L'Io Perduto: Completato\""
  },
  Task_122214_Desc = {
    Text = "Completa \"Velare gli Occhi\" a qualsiasi difficoltà"
  },
  Task_122215_Desc = {
    Text = "L'Io Perduto: Reame"
  },
  Task_122216_Desc = {
    Text = "Completa \"Pensiero Istintivo\" a Difficoltà Follia"
  },
  Task_122217_Desc = {
    Text = "Completa \"Dominio degli arti\" a qualsiasi difficoltà"
  },
  Task_122218_Desc = {
    Text = "Completa \"Liberazione del Vero Sé\" a qualsiasi difficoltà"
  },
  Task_122219_Desc = {
    Text = "L'Io Perduto: Completato"
  },
  Task_122220_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per vincere due volte ne \"L'Io Perduto\""
  },
  Task_122221_Desc = {
    Text = "L'Io Perduto: Follia"
  },
  Task_122222_Desc = {
    Text = "Completa \"Velare gli Occhi\" a qualsiasi difficoltà"
  },
  Task_122223_Desc = {
    Text = "Completa \"Discorso di controllo\" a Difficoltà Follia"
  },
  Task_122224_Desc = {
    Text = "Completa \"Escissione dell'Appendice\" a qualsiasi difficoltà"
  },
  Task_122225_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere una volta ne \"L'Io Perduto\""
  },
  Task_122226_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere due volte ne \"L'Io Perduto\""
  },
  Task_122227_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per vincere una volta ne \"L'Io Perduto\""
  },
  Task_122228_Desc = {
    Text = "Completa \"Spezzare il Cuore\" a qualsiasi difficoltà"
  },
  Task_122229_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere due volte ne \"L'Io Perduto\""
  },
  Task_122230_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere due volte ne \"L'Io Perduto\""
  },
  Task_122411_Desc = {
    Text = "+250/500/750/1000 punti per 1/2/3/4 Risvegliatori Potenziati schierati. (Attualmente: {s1})"
  },
  Task_122411_Name = {
    Text = "Richiamo dell'Abisso<size=20><color=#747474>Quando si schierano 1/2/3/4 Risvegliatori Potenziati, si ottengono 250 / 500 / 750 / 1000 punti</color></size>"
  },
  Task_122584_Name = {
    Text = "Uccidere tutti i BOSS"
  },
  Task_122704_Desc = {
    Text = "L'Affinità di Mouchette raggiunge il Livello 10"
  },
  Task_122808_Desc = {
    Text = "Illuminare 6 all'ottenimento di Mouchette"
  },
  Task_122808_Name = {
    Text = "Illuminare 6 all'ottenimento di Mouchette"
  },
  Task_122808_UnlockCondDesc = {
    Text = "Evento @ Evento Pacchetto Illuminare 2 del Risvegliatore Mouchette"
  },
  Task_122809_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_122812_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_122816_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_122819_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_122824_Desc = {
    Text = "Illuminare 2 all'ottenimento di Mouchette"
  },
  Task_122824_Name = {
    Text = "Illuminare 2 all'ottenimento di Mouchette"
  },
  Task_122824_UnlockCondDesc = {
    Text = "Evento @ Evento Pacchetto Illuminare 2 del Risvegliatore Mouchette"
  },
  Task_122828_Desc = {
    Text = "Completamento Capitolo dell'Oblio Cap. 3 in modalità Difficile"
  },
  Task_122829_Desc = {
    Text = "Completamento Capitolo dell'Oblio Cap. 1 in modalità Difficile"
  },
  Task_122830_Desc = {
    Text = "Completamento Capitolo dell'Oblio Cap. 6 in modalità Difficile"
  },
  Task_122831_Desc = {
    Text = "Completamento Capitolo dell'Oblio Cap. 7 in modalità Difficile"
  },
  Task_122832_Desc = {
    Text = "Completamento Capitolo dell'Oblio Cap. 4 in modalità Difficile"
  },
  Task_122833_Desc = {
    Text = "Completamento Capitolo dell'Oblio Cap. 2 in modalità Difficile"
  },
  Task_122834_Desc = {
    Text = "Completamento Capitolo dell'Oblio Cap. 5 in modalità Difficile"
  },
  Task_123135_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere due volte nella \"Bottega della Strega\""
  },
  Task_123136_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere due volte nella \"Bottega della Strega\""
  },
  Task_123137_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per vincere una volta nella \"Bottega della Strega\""
  },
  Task_123138_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere una volta nella \"Bottega della Strega\""
  },
  Task_123139_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere una volta nella \"Bottega della Strega\""
  },
  Task_123140_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per vincere due volte nella \"Bottega della Strega\""
  },
  Task_123141_Desc = {
    Text = "Bottega della Strega: Reame"
  },
  Task_123142_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere una volta nella \"Bottega della Strega\""
  },
  Task_123143_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere due volte nella \"Bottega della Strega\""
  },
  Task_123288_Desc = {
    Text = "Usa un Risvegliatore del Reame Ultra per vincere 2 volte in \"Sguardo del Mare Profondo\""
  },
  Task_123289_Desc = {
    Text = "Usa un Risvegliatore di Aequor per vincere 2 volte in \"Sguardo del Mare Profondo\""
  },
  Task_123290_Desc = {
    Text = "Usa il Risvegliatore di Caro per vincere 2 volte in \"Sguardo del Mare Profondo\""
  },
  Task_123291_Desc = {
    Text = "Usa un Risvegliatore del Caos per vincere 2 volte in \"Sguardo del Mare Profondo\""
  },
  Task_123324_Desc = {
    Text = "Completa 20 Incarichi"
  },
  Task_123325_Desc = {
    Text = "Completa 20 Incarichi"
  },
  Task_123326_Desc = {
    Text = "Completa 4 Missioni Quotidiane"
  },
  Task_123327_Desc = {
    Text = "Supera il Dominio Arcano una volta"
  },
  Task_123328_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_123329_Desc = {
    Text = "Completa 4 Missioni Quotidiane"
  },
  Task_123330_Desc = {
    Text = "Completa la Prova di Thais una volta"
  },
  Task_123331_Desc = {
    Text = "Consuma 1500 Menofina"
  },
  Task_123332_Desc = {
    Text = "Risveglio 30 volte"
  },
  Task_123333_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_123334_Desc = {
    Text = "Completa la Prova di Thais una volta"
  },
  Task_123335_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_123336_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_123337_Desc = {
    Text = "Consuma 1500 Menofina"
  },
  Task_123338_Desc = {
    Text = "Supera il Dominio Arcano una volta"
  },
  Task_123339_Desc = {
    Text = "Risveglio 30 volte"
  },
  Task_123488_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_123488_Name = {Text = "3 vittorie"},
  Task_123489_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_123489_Name = {Text = "6 vittorie"},
  Task_123490_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_123490_Name = {
    Text = "10 vittorie"
  },
  Task_123491_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_123491_Name = {Text = "1 vittoria"},
  Task_123726_Name = {
    Text = "Completa nuovamente la Fase 6 del Collegamento Multiversale di Mouchette in Modalità Normale"
  },
  Task_123878_Desc = {
    Text = "Vinci 2 volte in \"Ambizione Bestiale\" usando un Risvegliatore del Chaos"
  },
  Task_123883_Desc = {
    Text = "Vinci 2 volte in \"Ambizione Bestiale\" usando un Risvegliatore Ultra"
  },
  Task_123885_Desc = {
    Text = "Vinci 2 volte in \"Ambizione Bestiale\" usando un Risvegliatore di Aequor"
  },
  Task_123887_Desc = {
    Text = "Vinci 2 volte in \"Ambizione Bestiale\" usando un Risvegliatore Caro"
  },
  Task_124214_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_124214_Name = {Text = "3 vittorie"},
  Task_124215_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_124215_Name = {
    Text = "10 vittorie"
  },
  Task_124216_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_124216_Name = {Text = "1 vittoria"},
  Task_124217_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_124217_Name = {Text = "6 vittorie"},
  Task_124797_Desc = {
    Text = "Completa il Collegamento Multiversale \"Il Mio Turno\""
  },
  Task_124797_Name = {
    Text = "Inversione del Cosmo"
  },
  Task_124798_Desc = {
    Text = "Completa il Collegamento Multiversale \"Battesimo d'Argento e Sangue\" Difficile"
  },
  Task_124798_Name = {
    Text = "Il Futuro Verrà: Difficile"
  },
  Task_124799_Desc = {
    Text = "Completa il Collegamento Multiversale \"Battesimo d'Argento e Sangue\""
  },
  Task_124799_Name = {
    Text = "Il Futuro Verrà"
  },
  Task_124835_Desc = {
    Text = "Completa Capitolo dell'Oblio Capitolo 1"
  },
  Task_125386_Desc = {
    Text = "Completa \"Ascensione del Cadavere\" a qualsiasi difficoltà"
  },
  Task_125387_Desc = {
    Text = "Completa \"Ombra alle Spalle\" a qualsiasi difficoltà"
  },
  Task_125388_Desc = {
    Text = "Completa \"Suzione\" a qualsiasi difficoltà"
  },
  Task_125389_Desc = {
    Text = "Completamento di \"Seguendo la traccia\" a Difficoltà Follia"
  },
  Task_125390_Desc = {
    Text = "Completamento di \"Grazia crescente\" a qualsiasi difficoltà"
  },
  Task_125391_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per vincere una volta in \"Matriarca d'Ossidiana\""
  },
  Task_125392_Desc = {
    Text = "Completa l'Immersione nella Psiche: \"Sussurri dietro il ventaglio\""
  },
  Task_125392_Name = {
    Text = "Ninna nanna, piccino"
  },
  Task_125393_Desc = {
    Text = "Completa \"Seguendo la Traccia\" a qualsiasi difficoltà"
  },
  Task_125394_Desc = {
    Text = "Completamento di \"Morte ingiusta\" a Difficoltà Follia"
  },
  Task_125395_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_125396_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere due volte in \"Matriarca d'Ossidiana\""
  },
  Task_125397_Desc = {
    Text = "Completamento di \"Legati dal rancore\" a Difficoltà Follia"
  },
  Task_125398_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_125399_Desc = {
    Text = "Completa \"Morte Ingiusta\" a qualsiasi difficoltà"
  },
  Task_125400_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere una volta in \"Matriarca d'Ossidiana\""
  },
  Task_125401_Desc = {
    Text = "Matriarca d'Ossidiana: Completato"
  },
  Task_125402_Desc = {
    Text = "Completa \"Suzione\" a qualsiasi difficoltà"
  },
  Task_125403_Desc = {
    Text = "Completa \"Ombra alle Spalle\" a qualsiasi difficoltà"
  },
  Task_125404_Desc = {
    Text = "Completamento di \"Euforia\" a Difficoltà Follia"
  },
  Task_125406_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere una volta in \"Matriarca d'Ossidiana\""
  },
  Task_125407_Desc = {
    Text = "Completa \"Euforia\" a qualsiasi difficoltà"
  },
  Task_125409_Desc = {
    Text = "Completa \"Euforia\" a qualsiasi difficoltà"
  },
  Task_125410_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per vincere due volte in \"Matriarca d'Ossidiana\""
  },
  Task_125411_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere due volte in \"Matriarca d'Ossidiana\""
  },
  Task_125412_Desc = {
    Text = "Completamento di \"Suzione\" a Difficoltà Follia"
  },
  Task_125413_Desc = {
    Text = "Completamento di \"Psico-immersione: Sussurri dietro il ventaglio\""
  },
  Task_125414_Desc = {
    Text = "Completamento di \"Trappola di seta\" a qualsiasi difficoltà"
  },
  Task_125415_Desc = {
    Text = "L'Affinità di Xu raggiunge il Livello 10"
  },
  Task_125416_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere due volte in \"Matriarca d'Ossidiana\""
  },
  Task_125417_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_125418_Desc = {
    Text = "Illuminare 2 all'ottenimento di Xu"
  },
  Task_125418_Name = {
    Text = "Illuminare 2 all'ottenimento di Xu"
  },
  Task_125418_UnlockCondDesc = {
    Text = "Evento @ Evento Pacchetto Illuminare 2 del Risvegliatore Xu"
  },
  Task_125419_Desc = {
    Text = "Completa \"Legati dal Rancore\" a qualsiasi difficoltà"
  },
  Task_125420_Desc = {
    Text = "Matriarca d'Ossidiana: Reame"
  },
  Task_125421_Desc = {
    Text = "Completamento di \"Ombra alle spalle\" a Difficoltà Follia"
  },
  Task_125422_Desc = {
    Text = "Completa \"Legati dal Rancore\" a qualsiasi difficoltà"
  },
  Task_125423_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere una volta in \"Matriarca d'Ossidiana\""
  },
  Task_125424_Desc = {
    Text = "Completa \"Seguendo la Traccia\" a qualsiasi difficoltà"
  },
  Task_125425_Desc = {
    Text = "Completamento di \"Grazia crescente\" a Difficoltà Follia"
  },
  Task_125426_Desc = {
    Text = "Illuminare 6 all'ottenimento di Xu"
  },
  Task_125426_Name = {
    Text = "Illuminare 6 all'ottenimento di Xu"
  },
  Task_125426_UnlockCondDesc = {
    Text = "Evento @ Evento Pacchetto Illuminare 2 del Risvegliatore Xu"
  },
  Task_125427_Desc = {
    Text = "Completamento di \"Trappola di seta\" a qualsiasi difficoltà"
  },
  Task_125428_Desc = {
    Text = "Completa tutti gli obiettivi in \"Matriarca d'Ossidiana: Completato\""
  },
  Task_125429_Desc = {
    Text = "Completa \"Ascensione del Cadavere\" a qualsiasi difficoltà"
  },
  Task_125430_Desc = {
    Text = "Completamento di \"Trappola di seta\" a Difficoltà Follia"
  },
  Task_125431_Desc = {
    Text = "Completamento di \"Grazia crescente\" a qualsiasi difficoltà"
  },
  Task_125432_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_125433_Desc = {
    Text = "Completa \"Morte Ingiusta\" a qualsiasi difficoltà"
  },
  Task_125434_Desc = {
    Text = "Matriarca d'Ossidiana: Follia"
  },
  Task_125435_Desc = {
    Text = "Completamento di \"Ascensione del cadavere\" a Difficoltà Follia"
  },
  Task_125500_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_125500_Name = {Text = "6 vittorie"},
  Task_125501_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_125501_Name = {
    Text = "10 vittorie"
  },
  Task_125502_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_125502_Name = {Text = "1 vittoria"},
  Task_125503_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_125503_Name = {Text = "3 vittorie"},
  Task_125686_Desc = {
    Text = "Fuggire dall'Inseguimento"
  },
  Task_125686_Name = {Text = "Bersaglio"},
  Task_125687_Desc = {
    Text = "Sopravvivere all'Imboscata"
  },
  Task_125687_Name = {Text = "Bersaglio"},
  Task_125688_Desc = {
    Text = "Recuperare il corpo di Liz"
  },
  Task_125688_Name = {Text = "Bersaglio"},
  Task_125689_Desc = {
    Text = "Fuggire dalla trappola di Arachne"
  },
  Task_125689_Name = {Text = "Bersaglio"},
  Task_125690_Desc = {
    Text = "Dissuggellare i tre Eoni"
  },
  Task_125690_Name = {Text = "Bersaglio"},
  Task_125691_Desc = {
    Text = "Affrontare i nemici nella taverna"
  },
  Task_125691_Name = {Text = "Bersaglio"},
  Task_125692_Desc = {
    Text = "Eliminare i Mutanti"
  },
  Task_125692_Name = {Text = "Bersaglio"},
  Task_125693_Desc = {
    Text = "Salvare il \"Gentile\""
  },
  Task_125693_Name = {Text = "Bersaglio"},
  Task_125694_Desc = {
    Text = "Proteggere Sorel"
  },
  Task_125694_Name = {Text = "Bersaglio"},
  Task_125695_Desc = {
    Text = "Vendicare \"Memoria\""
  },
  Task_125695_Name = {Text = "Bersaglio"},
  Task_125845_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_125845_Name = {
    Text = "Superamento Perfetto"
  },
  Task_125846_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_125846_Name = {
    Text = "Superamento Perfetto"
  },
  Task_125847_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_125847_Name = {
    Text = "Superamento Perfetto"
  },
  Task_125848_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_125848_Name = {
    Text = "Superamento Perfetto"
  },
  Task_125849_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_125849_Name = {
    Text = "Superamento Perfetto"
  },
  Task_125850_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_125850_Name = {
    Text = "Superamento Perfetto"
  },
  Task_125851_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_125851_Name = {
    Text = "Superamento Perfetto"
  },
  Task_125852_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_125852_Name = {
    Text = "Superamento Perfetto"
  },
  Task_125853_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_125853_Name = {
    Text = "Superamento Perfetto"
  },
  Task_125854_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_125854_Name = {
    Text = "Superamento Perfetto"
  },
  Task_126276_Desc = {
    Text = "Supera \"Niente spoiler\" a difficoltà Follia"
  },
  Task_126277_Desc = {
    Text = "Il Palcoscenico del Burattino: Follia"
  },
  Task_126279_Desc = {
    Text = "Con Risvegliatori Aequor, vinci una volta ne \"Il Palcoscenico del Burattino\""
  },
  Task_126280_Desc = {
    Text = "Il Palcoscenico del Burattino: Completamento"
  },
  Task_126281_Desc = {
    Text = "Supera \"Incendio\" a qualsiasi difficoltà"
  },
  Task_126282_Desc = {
    Text = "Supera \"Niente spoiler\" a qualsiasi difficoltà"
  },
  Task_126285_Desc = {
    Text = "Supera \"Ingresso\" a qualsiasi difficoltà"
  },
  Task_126286_Desc = {
    Text = "Supera \"Colpi di scena\" a qualsiasi difficoltà"
  },
  Task_126288_Desc = {
    Text = "Supera \"Pistola sul muro\" a qualsiasi difficoltà"
  },
  Task_126290_Desc = {
    Text = "Supera \"Incendio\" a difficoltà Follia"
  },
  Task_126292_Desc = {
    Text = "Supera \"Pistola sul muro\" a difficoltà Follia"
  },
  Task_126293_Desc = {
    Text = "Supera \"Incendio\" a qualsiasi difficoltà"
  },
  Task_126294_Desc = {
    Text = "Completa tutti gli obiettivi de \"Il Palcoscenico del Burattino: Completamento\""
  },
  Task_126295_Desc = {
    Text = "Con Risvegliatori Ultra, vinci una volta ne \"Il Palcoscenico del Burattino\""
  },
  Task_126296_Desc = {
    Text = "Supera \"Colpi di scena\" a difficoltà Follia"
  },
  Task_126297_Desc = {
    Text = "Supera \"Ingresso\" a difficoltà Follia"
  },
  Task_126298_Desc = {
    Text = "Il Palcoscenico del Burattino: Reame"
  },
  Task_126299_Desc = {
    Text = "Con Risvegliatori Aequor, vinci due volte ne \"Il Palcoscenico del Burattino\""
  },
  Task_126302_Desc = {
    Text = "Con Risvegliatori del Caos, vinci due volte ne \"Il Palcoscenico del Burattino\""
  },
  Task_126303_Desc = {
    Text = "Supera \"Ingresso\" a qualsiasi difficoltà"
  },
  Task_126304_Desc = {
    Text = "Con Risvegliatori Caro, vinci due volte ne \"Il Palcoscenico del Burattino\""
  },
  Task_126305_Desc = {
    Text = "Supera \"Niente spoiler\" a qualsiasi difficoltà"
  },
  Task_126307_Desc = {
    Text = "Supera \"Pistola sul muro\" a qualsiasi difficoltà"
  },
  Task_126309_Desc = {
    Text = "Con Risvegliatori Caro, vinci una volta ne \"Il Palcoscenico del Burattino\""
  },
  Task_126311_Desc = {
    Text = "Con Risvegliatori Ultra, vinci due volte ne \"Il Palcoscenico del Burattino\""
  },
  Task_126312_Desc = {
    Text = "Con Risvegliatori del Caos, vinci una volta ne \"Il Palcoscenico del Burattino\""
  },
  Task_126313_Desc = {
    Text = "Supera \"Colpi di scena\" a qualsiasi difficoltà"
  },
  Task_126385_Desc = {
    Text = "Supera il Capitolo 5 \"Fated Theater\" di Astral Reign: Difficile"
  },
  Task_126386_Desc = {
    Text = "Supera il Capitolo 5 \"Fated Theater\" di Astral Reign: Difficile"
  },
  Task_126387_Desc = {
    Text = "Supera il Capitolo 5-7 di Astral Reign"
  },
  Task_126388_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_126390_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_126391_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_126392_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_126393_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_126394_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_126395_Desc = {
    Text = "Supera il Capitolo 5 \"Fated Theater\" di Astral Reign"
  },
  Task_126396_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_126397_Desc = {
    Text = "Supera il Capitolo 5-6 di Astral Reign: Difficile"
  },
  Task_126398_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_126399_Desc = {
    Text = "Supera il Capitolo 5-6 di Astral Reign: Difficile"
  },
  Task_126400_Desc = {
    Text = "Supera il Capitolo 5-7 di Astral Reign"
  },
  Task_126401_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_126402_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_126403_Desc = {
    Text = "Supera il Capitolo 5 \"Fated Theater\" di Astral Reign"
  },
  Task_126493_Desc = {
    Text = "Soliloqui di Panlong VII"
  },
  Task_126494_Desc = {
    Text = "Soliloqui di Panlong: Esclusiva a tempo limitato"
  },
  Task_126495_Desc = {
    Text = "Soliloqui di Panlong V"
  },
  Task_126496_Desc = {
    Text = "Soliloqui di Panlong I"
  },
  Task_126497_Desc = {
    Text = "Soliloqui di Panlong VI"
  },
  Task_126498_Desc = {
    Text = "Soliloqui di Panlong III"
  },
  Task_126499_Desc = {
    Text = "Soliloqui di Panlong IV"
  },
  Task_126500_Desc = {
    Text = "Soliloqui di Panlong: Gratuito"
  },
  Task_126501_Desc = {
    Text = "Soliloqui di Panlong II"
  },
  Task_127071_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_127071_Name = {
    Text = "10 vittorie"
  },
  Task_127072_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_127072_Name = {Text = "3 vittorie"},
  Task_127073_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_127073_Name = {Text = "6 vittorie"},
  Task_127074_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_127074_Name = {Text = "1 vittoria"},
  Task_127094_Desc = {
    Text = "Aurita raggiunge Impulso della Psiche 12"
  },
  Task_127095_Desc = {
    Text = "Ramona: Consunta dal Tempo raggiunge Impulso della Psiche 12"
  },
  Task_127096_Desc = {
    Text = "Ramona raggiunge Impulso della Psiche 12"
  },
  Task_127097_Desc = {
    Text = "Aigis raggiunge Impulso della Psiche 12"
  },
  Task_127098_Desc = {
    Text = "Lotan raggiunge Impulso della Psiche 12"
  },
  Task_127099_Desc = {
    Text = "Erica raggiunge Impulso della Psiche 12"
  },
  Task_127100_Desc = {
    Text = "Doll raggiunge Impulso della Psiche 12"
  },
  Task_127101_Desc = {
    Text = "Ogier raggiunge Impulso della Psiche 12"
  },
  Task_129511_Desc = {
    Text = "Completa Difficile/Follia con una squadra di 3 Caro e 1 Ultra"
  },
  Task_129512_Desc = {
    Text = "Completa Difficile/Follia con una squadra di 3 Chaos e 1 Ultra"
  },
  Task_129513_Desc = {
    Text = "Tracciare Tracce: Difficile"
  },
  Task_129513_Name = {
    Text = "Tracciare Tracce: Difficile"
  },
  Task_129514_Desc = {
    Text = "Completamento Fase 3: Follia"
  },
  Task_129515_Desc = {
    Text = "Completamento Difficile/Follia con un team di 1 Caro e 3 Ultra"
  },
  Task_129516_Desc = {
    Text = "Fase 3: Sconfiggi \"Doll: Inferno\" a qualsiasi difficoltà"
  },
  Task_129517_Desc = {
    Text = "Fase 3: Sconfiggi \"Velo del Paradiso\" a qualsiasi difficoltà"
  },
  Task_129518_Desc = {
    Text = "Completa tutti i compiti in \"Tracciare Tracce: Difficile\""
  },
  Task_129519_Desc = {
    Text = "Completa qualsiasi difficoltà con una squadra di 4 Ultra"
  },
  Task_129520_Desc = {
    Text = "Completamento Fase 2: Normale"
  },
  Task_129521_Desc = {
    Text = "Fase 2: Sconfiggi \"Hydra\" a qualsiasi difficoltà"
  },
  Task_129522_Desc = {
    Text = "Completa qualsiasi difficoltà con una squadra di 4 Caro"
  },
  Task_129523_Desc = {
    Text = "Completamento a qualsiasi difficoltà con un team di 2 Caro e 2 Ultra"
  },
  Task_129524_Desc = {
    Text = "Completa Difficile/Follia con una squadra di 3 Aequor e 1 Caro"
  },
  Task_129525_Desc = {
    Text = "Completamento Fase 1: Normale"
  },
  Task_129526_Desc = {
    Text = "Completamento a qualsiasi difficoltà con un team di 2 Caos e 2 Caro"
  },
  Task_129527_Desc = {
    Text = "Completa Difficile/Follia con una squadra di 3 Chaos e 1 Caro"
  },
  Task_129528_Desc = {
    Text = "Completa tutti i compiti in \"Fotogrammi del Viaggio: Scorribanda\""
  },
  Task_129529_Desc = {
    Text = "Completamento Fase 3: Normale"
  },
  Task_129530_Desc = {
    Text = "Completa Difficile/Follia con una squadra di 3 Chaos e 1 Aequor"
  },
  Task_129531_Desc = {
    Text = "Fase 1: Sconfiggi \"▼A▼▼ya\" a qualsiasi difficoltà"
  },
  Task_129532_Desc = {
    Text = "Completamento Fase 2: Difficile"
  },
  Task_129533_Desc = {
    Text = "Completamento Fase 1: Follia"
  },
  Task_129534_Desc = {
    Text = "Fotogrammi del Viaggio: Echi"
  },
  Task_129534_Name = {
    Text = "Fotogrammi del Viaggio: Echi"
  },
  Task_129535_Desc = {
    Text = "Fase 3: Sconfiggi \"Marionetta della Putrescenza\" a qualsiasi difficoltà"
  },
  Task_129536_Desc = {
    Text = "Fotogrammi del Viaggio: Scorribanda"
  },
  Task_129536_Name = {
    Text = "Fotogrammi del Viaggio: Scorribanda"
  },
  Task_129537_Desc = {
    Text = "Fase 3: Sconfiggi \"Crisalide Ultra @2\" a qualsiasi difficoltà"
  },
  Task_129538_Desc = {
    Text = "Completamento a qualsiasi difficoltà con un team di 2 Aequor e 2 Caro"
  },
  Task_129539_Desc = {
    Text = "Fase 2: Sconfiggi \"Albero Madre della Fertilità\" a qualsiasi difficoltà"
  },
  Task_129540_Desc = {
    Text = "Fase 1: Sconfiggi \"Piagnucolone Geor▼\" a qualsiasi difficoltà"
  },
  Task_129541_Desc = {
    Text = "Completamento a qualsiasi difficoltà con un team di 2 Caos e 2 Aequor"
  },
  Task_129542_Desc = {
    Text = "Completamento Fase 3: Difficile"
  },
  Task_129543_Desc = {
    Text = "Fase 1: Sconfiggi \"Shoggo▼▼\" a qualsiasi difficoltà"
  },
  Task_129544_Desc = {
    Text = "Completa Difficile/Follia con una squadra di 3 Aequor e 1 Ultra"
  },
  Task_129545_Desc = {
    Text = "Completamento Fase 2: Follia"
  },
  Task_129546_Desc = {
    Text = "Fase 1: Sconfiggi i \"Segugi Dimensionali\" a qualsiasi difficoltà"
  },
  Task_129547_Desc = {
    Text = "Fase 2: Sconfiggi \"Contraddizione Gemella\" a qualsiasi difficoltà"
  },
  Task_129548_Desc = {
    Text = "Completamento Difficile/Follia con un team di 1 Aequor e 3 Caro"
  },
  Task_129549_Desc = {
    Text = "Completamento a qualsiasi difficoltà con un team di 2 Caos e 2 Ultra"
  },
  Task_129550_Desc = {
    Text = "Completamento Fase 1: Difficile"
  },
  Task_129551_Desc = {
    Text = "Completa tutti i compiti in \"Tracciare Tracce: Normale\""
  },
  Task_129552_Desc = {
    Text = "Completamento a qualsiasi difficoltà con un team di 2 Aequor e 2 Ultra"
  },
  Task_129553_Desc = {
    Text = "Tracciare Tracce: Normale"
  },
  Task_129553_Name = {
    Text = "Tracciare Tracce: Normale"
  },
  Task_129554_Desc = {
    Text = "Completamento Difficile/Follia con un team di 1 Caos e 3 Caro"
  },
  Task_129555_Desc = {
    Text = "Completamento Difficile/Follia con un team di 1 Caos e 3 Ultra"
  },
  Task_129556_Desc = {
    Text = "Completa qualsiasi difficoltà con una squadra di 4 Aequor"
  },
  Task_129557_Desc = {
    Text = "Completamento Difficile/Follia con un team di 1 Caos e 3 Aequor"
  },
  Task_129558_Desc = {
    Text = "Completamento Difficile/Follia con un team di 1 Aequor e 3 Ultra"
  },
  Task_129559_Desc = {
    Text = "Completa qualsiasi difficoltà con una squadra di 4 Caos"
  },
  Task_129560_Desc = {
    Text = "Completa tutti i compiti in \"Fotogrammi del Viaggio: Scorribanda\""
  },
  Task_129561_Desc = {
    Text = "Fase 2: Sconfiggi \"Feto Divino\" a qualsiasi difficoltà"
  },
  Task_129895_Desc = {
    Text = "Completa il Registro Operazioni Speciali \"Espresso del Festival di Primavera\""
  },
  Task_129895_Name = {
    Text = "Vigilia di Capodanno"
  },
  Task_130180_Desc = {
    Text = "Azzera Collegamento Multiverso \"Semi d'amore dimenticati\""
  },
  Task_130181_Desc = {
    Text = "Azzera \"Bicchiere della Staffa\" in Difficoltà Follia"
  },
  Task_130182_Desc = {
    Text = "Azzera \"Tavolo da Pranzo\" in qualsiasi difficoltà"
  },
  Task_130183_Desc = {
    Text = "Con i Risvegliatori di Aequor, vinci due volte in \"rinascita sottosopra\""
  },
  Task_130184_Desc = {
    Text = "Con i Risvegliatori di Caro, vinci una volta in \"rinascita sottosopra\""
  },
  Task_130185_Desc = {
    Text = "Azzera \"A Scuola\" in qualsiasi difficoltà"
  },
  Task_130186_Desc = {
    Text = "Azzera \"L'Ospedale\" a qualsiasi difficoltà"
  },
  Task_130187_Desc = {
    Text = "Azzera \"Bicchiere della Staffa\" in qualsiasi difficoltà"
  },
  Task_130188_Desc = {
    Text = "Completa \"L'Ospedale\" a Difficoltà Follia"
  },
  Task_130189_Desc = {
    Text = "Con i Risvegliatori del Caos, vinci una volta in \"rinascita sottosopra\""
  },
  Task_130190_Desc = {
    Text = "Con i Risvegliatori di Caro, vinci due volte in \"rinascita sottosopra\""
  },
  Task_130191_Desc = {
    Text = "Azzera \"Il Pozzo\" in Difficoltà Follia"
  },
  Task_130192_Desc = {
    Text = "Con i Risvegliatori Ultra, vinci due volte in \"rinascita sottosopra\""
  },
  Task_130193_Desc = {
    Text = "Azzera \"A Scuola\" in Difficoltà Follia"
  },
  Task_130194_Desc = {
    Text = "Azzera \"Tavolo da Pranzo\" in qualsiasi difficoltà"
  },
  Task_130195_Desc = {
    Text = "Azzera \"Casa Nostra\" a qualsiasi difficoltà"
  },
  Task_130196_Desc = {
    Text = "Azzera \"Bicchiere della Staffa\" in qualsiasi difficoltà"
  },
  Task_130197_Desc = {
    Text = "Azzera \"Neurotrauma\" in qualsiasi difficoltà"
  },
  Task_130198_Desc = {
    Text = "Con i Risvegliatori di Aequor, vinci una volta in \"rinascita sottosopra\""
  },
  Task_130199_Desc = {
    Text = "Azzera \"Neurotrauma\" in qualsiasi difficoltà"
  },
  Task_130200_Desc = {
    Text = "Azzera \"Il Pozzo\" in qualsiasi difficoltà"
  },
  Task_130201_Desc = {
    Text = "Azzera \"Casa Nostra\" a qualsiasi difficoltà"
  },
  Task_130202_Desc = {
    Text = "Azzera \"A Scuola\" in qualsiasi difficoltà"
  },
  Task_130203_Desc = {
    Text = "Azzera \"L'Ospedale\" a qualsiasi difficoltà"
  },
  Task_130204_Desc = {
    Text = "Azzera \"Il Pozzo\" in qualsiasi difficoltà"
  },
  Task_130205_Desc = {
    Text = "rinascita sottosopra: Follia"
  },
  Task_130206_Desc = {
    Text = "Completa \"Casa Nostra\" a Difficoltà Follia"
  },
  Task_130207_Desc = {
    Text = "Azzera \"Neurotrauma\" in Difficoltà Follia"
  },
  Task_130208_Desc = {
    Text = "rinascita sottosopra: Reame"
  },
  Task_130209_Desc = {
    Text = "Completa tutti gli obiettivi di \"rinascita sottosopra: Completato\""
  },
  Task_130210_Desc = {
    Text = "rinascita sottosopra: Completato"
  },
  Task_130211_Desc = {
    Text = "Con i Risvegliatori Ultra, vinci una volta in \"rinascita sottosopra\""
  },
  Task_130212_Desc = {
    Text = "Azzera \"Tavolo da Pranzo\" in Difficoltà Follia"
  },
  Task_130213_Desc = {
    Text = "Con i Risvegliatori del Caos, vinci due volte in \"rinascita sottosopra\""
  },
  Task_130412_Desc = {
    Text = "Illuminare 2 all'ottenimento di Genesi: Ogier"
  },
  Task_130412_Name = {
    Text = "Illuminare 2 all'ottenimento di Genesi: Ogier"
  },
  Task_130412_UnlockCondDesc = {
    Text = "Evento @ Evento Pacchetto Illuminare 2 del Risvegliatore Genesi Ogier"
  },
  Task_130413_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_130414_Desc = {
    Text = "Illuminare 2 all'ottenimento di Shaye"
  },
  Task_130414_Name = {
    Text = "Illuminare 2 all'ottenimento di Shaye"
  },
  Task_130414_UnlockCondDesc = {
    Text = "Evento @ Evento Pacchetto Illuminare 2 del Risvegliatore Shaye"
  },
  Task_130416_Desc = {
    Text = "Illuminare 6 all'ottenimento di Saya"
  },
  Task_130416_Name = {
    Text = "Illuminare 6 all'ottenimento di Saya"
  },
  Task_130416_UnlockCondDesc = {
    Text = "Evento @ Evento Pacchetto Illuminare 2 del Risvegliatore Shaye"
  },
  Task_130417_Desc = {
    Text = "Illuminare 2 all'ottenimento di Satogua"
  },
  Task_130417_Name = {
    Text = "Illuminare 2 all'ottenimento di Satogua"
  },
  Task_130417_UnlockCondDesc = {
    Text = "Evento @ Evento Pacchetto Illuminare 2 del Risvegliatore Satogua"
  },
  Task_130418_Desc = {
    Text = "Illuminare 6 all'ottenimento di Satogua"
  },
  Task_130418_Name = {
    Text = "Illuminare 6 all'ottenimento di Satogua"
  },
  Task_130418_UnlockCondDesc = {
    Text = "Evento @ Evento Pacchetto Illuminare 2 del Risvegliatore Satogua"
  },
  Task_130420_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_130421_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_130424_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_130425_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_130427_Desc = {
    Text = "Illuminare 6 all'ottenimento di Oberon: Falsonata"
  },
  Task_130427_Name = {
    Text = "Illuminare 6 all'ottenimento di Oberon: Falsonata"
  },
  Task_130427_UnlockCondDesc = {
    Text = "Evento @ Evento Pacchetto Illuminare 2 del Risvegliatore Genesi Ogier"
  },
  Task_130429_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_130440_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_130441_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_130442_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_130446_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_130447_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_130448_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_130459_Desc = {
    Text = "L'Affinità di Ogier Genesi raggiunge il Livello 10"
  },
  Task_130460_Desc = {
    Text = "L'Affinità di Tsathoggua raggiunge il Livello 10"
  },
  Task_130461_Desc = {
    Text = "L'Affinità di Shaye raggiunge il Livello 10"
  },
  Task_130555_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_130555_Name = {Text = "3 vittorie"},
  Task_130556_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_130556_Name = {
    Text = "10 vittorie"
  },
  Task_130557_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_130557_Name = {Text = "1 vittoria"},
  Task_130558_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_130558_Name = {Text = "6 vittorie"},
  Task_130950_Desc = {
    Text = "Completa \"IL GRANDE MAELSTROM!\" in Difficoltà Follia"
  },
  Task_130951_Desc = {
    Text = "Completamento di \"Giorni ordinari\" a Difficoltà Follia"
  },
  Task_130952_Desc = {
    Text = "Completa \"Tempesta Tonante\" a qualsiasi difficoltà"
  },
  Task_130953_Desc = {
    Text = "Completamento di \"Nuovi compagni\" a Difficoltà Follia"
  },
  Task_130954_Desc = {
    Text = "Vortice e il Mare: Reame"
  },
  Task_130956_Desc = {
    Text = "Completa tutti gli obiettivi di \"Vortice e il Mare: Completato\""
  },
  Task_130957_Desc = {
    Text = "Completa \"IL GRANDE MAELSTROM!\" a qualsiasi difficoltà"
  },
  Task_130958_Desc = {
    Text = "Illuminare 6 all'ottenimento di Mosk"
  },
  Task_130958_Name = {
    Text = "Illuminare 6 all'ottenimento di Mosk"
  },
  Task_130958_UnlockCondDesc = {
    Text = "Evento @ Evento Pacchetto Illuminare 2 del Risvegliatore Mosk"
  },
  Task_130959_Desc = {
    Text = "Completa \"IL GRANDE MAELSTROM!\" a qualsiasi difficoltà"
  },
  Task_130960_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_130961_Desc = {
    Text = "Vortice e il Mare: Completato"
  },
  Task_130962_Desc = {
    Text = "Completamento di \"Ritorno a casa\" a qualsiasi difficoltà"
  },
  Task_130963_Desc = {
    Text = "Completamento Psico-immersione \"La riva perduta\""
  },
  Task_130964_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere due volte in \"Vortice e il Mare\""
  },
  Task_130965_Desc = {
    Text = "Completa \"Giorni Ordinari\" a qualsiasi difficoltà"
  },
  Task_130966_Desc = {
    Text = "Completa \"È Ora di Salpare\" a qualsiasi difficoltà"
  },
  Task_130967_Desc = {
    Text = "Completamento di \"Ritorno a casa\" a qualsiasi difficoltà"
  },
  Task_130968_Desc = {
    Text = "Completa \"Nuovi Compagni\" a qualsiasi difficoltà"
  },
  Task_130970_Desc = {
    Text = "Illuminare 2 all'ottenimento di Mosk"
  },
  Task_130970_Name = {
    Text = "Illuminare 2 all'ottenimento di Mosk"
  },
  Task_130970_UnlockCondDesc = {
    Text = "Evento @ Evento Pacchetto Illuminare 2 del Risvegliatore Mosk"
  },
  Task_130971_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per vincere una volta in \"Vortice e il Mare\""
  },
  Task_130972_Desc = {
    Text = "Completa \"Tempesta Tonante\" a qualsiasi difficoltà"
  },
  Task_130973_Desc = {
    Text = "Completamento di \"Tesori alla deriva\" a Difficoltà Follia"
  },
  Task_130974_Desc = {
    Text = "Completamento di \"È ora di salpare\" a Difficoltà Follia"
  },
  Task_130975_Desc = {
    Text = "L'Affinità di Vortice raggiunge il Livello 10"
  },
  Task_130976_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_130977_Desc = {
    Text = "Completa \"Nuovi Compagni\" a qualsiasi difficoltà"
  },
  Task_130978_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere una volta in \"Vortice e il Mare\""
  },
  Task_130979_Desc = {
    Text = "Completamento di \"Tempesta fragorosa\" a Difficoltà Follia"
  },
  Task_130980_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere una volta in \"Vortice e il Mare\""
  },
  Task_130981_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_130982_Desc = {
    Text = "Completamento di \"Ritorno a casa\" a Difficoltà Follia"
  },
  Task_130983_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere due volte in \"Vortice e il Mare\""
  },
  Task_130984_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_130985_Desc = {
    Text = "Completa \"È Ora di Salpare\" a qualsiasi difficoltà"
  },
  Task_130986_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere due volte in \"Vortice e il Mare\""
  },
  Task_130987_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per vincere due volte in \"Vortice e il Mare\""
  },
  Task_130988_Desc = {
    Text = "Completa \"Tesori alla Deriva\" a qualsiasi difficoltà"
  },
  Task_130989_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere una volta in \"Vortice e il Mare\""
  },
  Task_130990_Desc = {
    Text = "Completa \"Giorni Ordinari\" a qualsiasi difficoltà"
  },
  Task_130991_Desc = {
    Text = "Completa \"Tesori alla Deriva\" a qualsiasi difficoltà"
  },
  Task_130992_Desc = {
    Text = "Vortice e il Mare: Follia"
  },
  Task_131106_Desc = {
    Text = "Fermare Nefrea"
  },
  Task_131106_Name = {Text = "Bersaglio"},
  Task_131172_Desc = {
    Text = "Fati Coniugati: Esclusiva a tempo limitato"
  },
  Task_131371_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_131372_Desc = {
    Text = "Risveglio 30 volte"
  },
  Task_131373_Desc = {
    Text = "Risveglio 30 volte"
  },
  Task_131374_Desc = {
    Text = "Consuma 1500 Menofina"
  },
  Task_131375_Desc = {
    Text = "Completare tutti i compiti delle Prove settimanali in 1 settimana"
  },
  Task_131376_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_131377_Desc = {
    Text = "Completa 20 Incarichi"
  },
  Task_131378_Desc = {
    Text = "Completare tutti i compiti delle Prove settimanali in 1 settimana"
  },
  Task_131379_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_131380_Desc = {
    Text = "Completa 20 Incarichi"
  },
  Task_131381_Desc = {
    Text = "Supera il Dominio Arcano una volta"
  },
  Task_131382_Desc = {
    Text = "Consuma 1500 Menofina"
  },
  Task_131383_Desc = {
    Text = "Supera il Dominio Arcano una volta"
  },
  Task_131384_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_131385_Desc = {
    Text = "Completamento della Prova di Ryker 1 volta"
  },
  Task_131386_Desc = {
    Text = "Completamento della Prova di Ryker 1 volta"
  },
  Task_131450_Desc = {
    Text = "Sconfiggi 60 Risvegliati in Traphase"
  },
  Task_131451_Desc = {
    Text = "Sconfiggi 36 Risvegliati in Traphase"
  },
  Task_131452_Desc = {
    Text = "Vinci 10 volte in Modalità Selezione Libera"
  },
  Task_131453_Desc = {
    Text = "Gioca 740 carte in Traphase"
  },
  Task_131454_Desc = {
    Text = "Usa Esaltazione 108 volte in Traphase"
  },
  Task_131455_Desc = {
    Text = "Usa Esaltazione 192 volte in Traphase"
  },
  Task_131456_Desc = {
    Text = "Usa Esaltazione 60 volte in Traphase"
  },
  Task_131457_Desc = {
    Text = "Sconfiggi 111 Risvegliati in Traphase"
  },
  Task_131458_Desc = {
    Text = "Gioca 300 carte in Traphase"
  },
  Task_131459_Desc = {
    Text = "Gioca 480 carte in Traphase"
  },
  Task_131460_Desc = {
    Text = "Gioca 320 carte in Traphase"
  },
  Task_131461_Desc = {
    Text = "Sconfiggi 6 Risvegliati in Traphase"
  },
  Task_131462_Desc = {
    Text = "Sconfiggi 129 Risvegliati in Traphase"
  },
  Task_131463_Desc = {
    Text = "Usa Esaltazione 102 volte in Traphase"
  },
  Task_131464_Desc = {
    Text = "Gioca 100 carte in Traphase"
  },
  Task_131465_Desc = {
    Text = "Usa Esaltazione 66 volte in Traphase"
  },
  Task_131466_Desc = {
    Text = "Sconfiggi 12 Risvegliati in Traphase"
  },
  Task_131467_Desc = {
    Text = "Vinci un totale cumulativo di 45 partite in Traphase"
  },
  Task_131468_Desc = {
    Text = "Usa Esaltazione 54 volte in Traphase"
  },
  Task_131469_Desc = {
    Text = "Usa Esaltazione 240 volte in Traphase"
  },
  Task_131470_Desc = {
    Text = "Sconfiggi 99 Risvegliati in Traphase"
  },
  Task_131471_Desc = {
    Text = "Sconfiggi 87 Risvegliati in Traphase"
  },
  Task_131472_Desc = {
    Text = "In Modalità Selezione a Turno, gioca un'Altra Partita e sconfiggi il tuo Rivale 1 volta"
  },
  Task_131473_Desc = {
    Text = "Sconfiggi 30 Risvegliati in Traphase"
  },
  Task_131474_Desc = {
    Text = "In Modalità Selezione Libera, ottieni una Serie Vincente di 2 vittorie una volta"
  },
  Task_131475_Desc = {
    Text = "In Modalità Selezione a Turno, ottieni 2 vittorie"
  },
  Task_131476_Desc = {
    Text = "Usa Esaltazione 156 volte in Traphase"
  },
  Task_131477_Desc = {
    Text = "In Modalità Selezione a Turno, ottieni 6 vittorie"
  },
  Task_131478_Desc = {
    Text = "Gioca 160 carte in Traphase"
  },
  Task_131479_Desc = {
    Text = "Sconfiggi 135 Risvegliati in Traphase"
  },
  Task_131480_Desc = {
    Text = "Gioca 880 carte in Traphase"
  },
  Task_131481_Desc = {
    Text = "Usa Esaltazione 132 volte in Traphase"
  },
  Task_131482_Desc = {
    Text = "Usa Esaltazione 204 volte in Traphase"
  },
  Task_131483_Desc = {
    Text = "Vinci 4 volte in Modalità Selezione Libera"
  },
  Task_131484_Desc = {
    Text = "Usa Esaltazione 144 volte in Traphase"
  },
  Task_131485_Desc = {
    Text = "Gioca 240 carte in Traphase"
  },
  Task_131486_Desc = {
    Text = "Gioca 940 carte in Traphase"
  },
  Task_131487_Desc = {
    Text = "Usa Esaltazione 210 volte in Traphase"
  },
  Task_131488_Desc = {
    Text = "Usa Esaltazione 174 volte in Traphase"
  },
  Task_131489_Desc = {
    Text = "Sconfiggi 54 Risvegliati in Traphase"
  },
  Task_131490_Desc = {
    Text = "Sconfiggi 21 Risvegliati in Traphase"
  },
  Task_131491_Desc = {
    Text = "Gioca 180 carte in Traphase"
  },
  Task_131492_Desc = {
    Text = "Prova della Classifica"
  },
  Task_131493_Desc = {
    Text = "Gioca 400 carte in Traphase"
  },
  Task_131494_Desc = {
    Text = "Sconfiggi 57 Risvegliati in Traphase"
  },
  Task_131495_Desc = {
    Text = "In Modalità Selezione a Turno, ottieni 8 vittorie"
  },
  Task_131496_Desc = {
    Text = "Sconfiggi 81 Risvegliati in Traphase"
  },
  Task_131497_Desc = {
    Text = "Sconfiggi 93 Risvegliati in Traphase"
  },
  Task_131498_Desc = {
    Text = "Sconfiggi 120 Risvegliati in Traphase"
  },
  Task_131499_Desc = {
    Text = "Usa Esaltazione 30 volte in Traphase"
  },
  Task_131500_Desc = {
    Text = "Gioca 220 carte in Traphase"
  },
  Task_131501_Desc = {
    Text = "Usa Esaltazione 264 volte in Traphase"
  },
  Task_131502_Desc = {
    Text = "Sconfiggi 102 Risvegliati in Traphase"
  },
  Task_131503_Desc = {
    Text = "Gioca 140 carte in Traphase"
  },
  Task_131504_Desc = {
    Text = "Usa Esaltazione 96 volte in Traphase"
  },
  Task_131505_Desc = {
    Text = "In Modalità Selezione Libera, gioca un'Altra Partita e sconfiggi il tuo Rivale 1 volta"
  },
  Task_131506_Desc = {
    Text = "Usa Esaltazione 78 volte in Traphase"
  },
  Task_131507_Desc = {
    Text = "Gioca 1000 carte in Traphase"
  },
  Task_131508_Desc = {
    Text = "Usa Esaltazione 90 volte in Traphase"
  },
  Task_131509_Desc = {
    Text = "Sconfiggi 132 Risvegliati in Traphase"
  },
  Task_131510_Desc = {
    Text = "Sconfiggi 126 Risvegliati in Traphase"
  },
  Task_131511_Desc = {
    Text = "Sconfiggi 9 Risvegliati in Traphase"
  },
  Task_131512_Desc = {
    Text = "Usa Esaltazione 168 volte in Traphase"
  },
  Task_131513_Desc = {
    Text = "Usa Esaltazione 162 volte in Traphase"
  },
  Task_131514_Desc = {
    Text = "Usa Esaltazione 222 volte in Traphase"
  },
  Task_131515_Desc = {
    Text = "Prova della Soglia"
  },
  Task_131516_Desc = {
    Text = "Gioca 380 carte in Traphase"
  },
  Task_131517_Desc = {
    Text = "Gioca 660 carte in Traphase"
  },
  Task_131518_Desc = {
    Text = "Usa Esaltazione 114 volte in Traphase"
  },
  Task_131519_Desc = {
    Text = "Usa Esaltazione 120 volte in Traphase"
  },
  Task_131520_Desc = {
    Text = "Sconfiggi 144 Risvegliati in Traphase"
  },
  Task_131521_Desc = {
    Text = "Sconfiggi 24 Risvegliati in Traphase"
  },
  Task_131522_Desc = {
    Text = "Sconfiggi 42 Risvegliati in Traphase"
  },
  Task_131523_Desc = {
    Text = "Gioca 460 carte in Traphase"
  },
  Task_131524_Desc = {
    Text = "Usa Esaltazione 180 volte in Traphase"
  },
  Task_131525_Desc = {
    Text = "Gioca 520 carte in Traphase"
  },
  Task_131526_Desc = {
    Text = "Gioca 840 carte in Traphase"
  },
  Task_131527_Desc = {
    Text = "Sconfiggi 69 Risvegliati in Traphase"
  },
  Task_131528_Desc = {
    Text = "Gioca 720 carte in Traphase"
  },
  Task_131529_Desc = {
    Text = "Sconfiggi 33 Risvegliati in Traphase"
  },
  Task_131530_Desc = {
    Text = "Sconfiggi 39 Risvegliati in Traphase"
  },
  Task_131531_Desc = {
    Text = "Gioca 860 carte in Traphase"
  },
  Task_131532_Desc = {
    Text = "Gioca 560 carte in Traphase"
  },
  Task_131533_Desc = {
    Text = "Gioca 600 carte in Traphase"
  },
  Task_131534_Desc = {
    Text = "Invia un'emoticon a 3 avversari in Traphase"
  },
  Task_131535_Desc = {
    Text = "Sconfiggi 66 Risvegliati in Traphase"
  },
  Task_131536_Desc = {
    Text = "Gioca 200 carte in Traphase"
  },
  Task_131537_Desc = {
    Text = "In Modalità Selezione a Turno, ottieni 1 vittoria"
  },
  Task_131538_Desc = {
    Text = "Usa Esaltazione 234 volte in Traphase"
  },
  Task_131539_Desc = {
    Text = "Gioca 820 carte in Traphase"
  },
  Task_131540_Desc = {
    Text = "Usa Esaltazione 18 volte in Traphase"
  },
  Task_131541_Desc = {
    Text = "Sconfiggi 63 Risvegliati in Traphase"
  },
  Task_131542_Desc = {
    Text = "Usa Esaltazione 258 volte in Traphase"
  },
  Task_131543_Desc = {
    Text = "Elogia l'avversario 1 volta dopo una battaglia Traphase"
  },
  Task_131544_Desc = {
    Text = "Accumula 25 vittorie in Traphase"
  },
  Task_131545_Desc = {
    Text = "Sconfiggi 27 Risvegliati in Traphase"
  },
  Task_131546_Desc = {
    Text = "Sconfiggi 18 Risvegliati in Traphase"
  },
  Task_131547_Desc = {
    Text = "Sconfiggi 150 Risvegliati in Traphase"
  },
  Task_131548_Desc = {
    Text = "Usa Esaltazione 48 volte in Traphase"
  },
  Task_131549_Desc = {
    Text = "Gioca 20 carte in Traphase"
  },
  Task_131550_Desc = {
    Text = "Usa Esaltazione 36 volte in Traphase"
  },
  Task_131551_Desc = {
    Text = "Sconfiggi 15 Risvegliati in Traphase"
  },
  Task_131552_Desc = {
    Text = "Sconfiggi 84 Risvegliati in Traphase"
  },
  Task_131553_Desc = {
    Text = "Gioca 280 carte in Traphase"
  },
  Task_131554_Desc = {
    Text = "Usa Esaltazione 72 volte in Traphase"
  },
  Task_131555_Desc = {
    Text = "Sconfiggi 108 Risvegliati in Traphase"
  },
  Task_131556_Desc = {
    Text = "Usa Esaltazione 246 volte in Traphase"
  },
  Task_131557_Desc = {
    Text = "Gioca 700 carte in Traphase"
  },
  Task_131558_Desc = {
    Text = "Vinci un totale cumulativo di 35 partite in Traphase"
  },
  Task_131559_Desc = {
    Text = "Vinci un totale cumulativo di 50 partite in Traphase"
  },
  Task_131560_Desc = {
    Text = "Sconfiggi 3 Risvegliati in Traphase"
  },
  Task_131561_Desc = {
    Text = "Sconfiggi 75 Risvegliati in Traphase"
  },
  Task_131562_Desc = {
    Text = "Sconfiggi 51 Risvegliati in Traphase"
  },
  Task_131563_Desc = {
    Text = "Gioca 120 carte in Traphase"
  },
  Task_131564_Desc = {
    Text = "Sconfiggi 78 Risvegliati in Traphase"
  },
  Task_131565_Desc = {
    Text = "Sconfiggi 138 Risvegliati in Traphase"
  },
  Task_131566_Desc = {
    Text = "Sconfiggi 90 Risvegliati in Traphase"
  },
  Task_131567_Desc = {
    Text = "Prova Arcana"
  },
  Task_131568_Desc = {
    Text = "Vinci 6 volte in Modalità Selezione Libera"
  },
  Task_131569_Desc = {
    Text = "Vinci 8 volte in Modalità Selezione Libera"
  },
  Task_131570_Desc = {
    Text = "Sconfiggi 117 Risvegliati in Traphase"
  },
  Task_131571_Desc = {
    Text = "Vinci un totale cumulativo di 40 partite in Traphase"
  },
  Task_131572_Desc = {
    Text = "Usa Esaltazione 126 volte in Traphase"
  },
  Task_131573_Desc = {
    Text = "Gioca 760 carte in Traphase"
  },
  Task_131574_Desc = {
    Text = "Usa Esaltazione 270 volte in Traphase"
  },
  Task_131575_Desc = {
    Text = "In Modalità Selezione Libera, ottieni 1 vittoria"
  },
  Task_131576_Desc = {
    Text = "Usa Esaltazione 84 volte in Traphase"
  },
  Task_131577_Desc = {
    Text = "Usa Esaltazione 294 volte in Traphase"
  },
  Task_131578_Desc = {
    Text = "Vinci un totale cumulativo di 30 partite in Traphase"
  },
  Task_131579_Desc = {
    Text = "Gioca 960 carte in Traphase"
  },
  Task_131580_Desc = {
    Text = "Gioca 260 carte in Traphase"
  },
  Task_131581_Desc = {
    Text = "Usa Esaltazione 42 volte in Traphase"
  },
  Task_131582_Desc = {
    Text = "Sconfiggi 96 Risvegliati in Traphase"
  },
  Task_131583_Desc = {
    Text = "Usa Esaltazione 228 volte in Traphase"
  },
  Task_131584_Desc = {
    Text = "Gioca 40 carte in Traphase"
  },
  Task_131585_Desc = {
    Text = "Gioca 800 carte in Traphase"
  },
  Task_131586_Desc = {
    Text = "Gioca 580 carte in Traphase"
  },
  Task_131587_Desc = {
    Text = "Usa Esaltazione 150 volte in Traphase"
  },
  Task_131588_Desc = {
    Text = "Sconfiggi 114 Risvegliati in Traphase"
  },
  Task_131589_Desc = {
    Text = "Gioca 780 carte in Traphase"
  },
  Task_131590_Desc = {
    Text = "Usa Esaltazione 24 volte in Traphase"
  },
  Task_131591_Desc = {
    Text = "Usa Esaltazione 216 volte in Traphase"
  },
  Task_131592_Desc = {
    Text = "Usa Esaltazione 276 volte in Traphase"
  },
  Task_131593_Desc = {
    Text = "Gioca 500 carte in Traphase"
  },
  Task_131594_Desc = {
    Text = "Sconfiggi 147 Risvegliati in Traphase"
  },
  Task_131595_Desc = {
    Text = "Vinci 2 volte in Modalità Selezione Libera"
  },
  Task_131596_Desc = {
    Text = "Sconfiggi 72 Risvegliati in Traphase"
  },
  Task_131597_Desc = {
    Text = "Gioca 640 carte in Traphase"
  },
  Task_131598_Desc = {
    Text = "Sconfiggi 105 Risvegliati in Traphase"
  },
  Task_131599_Desc = {
    Text = "Usa Esaltazione 300 volte in Traphase"
  },
  Task_131600_Desc = {
    Text = "Sconfiggi 48 Risvegliati in Traphase"
  },
  Task_131601_Desc = {
    Text = "Gioca 920 carte in Traphase"
  },
  Task_131602_Desc = {
    Text = "Gioca 60 carte in Traphase"
  },
  Task_131603_Desc = {
    Text = "Gioca 360 carte in Traphase"
  },
  Task_131604_Desc = {
    Text = "Usa Esaltazione 282 volte in Traphase"
  },
  Task_131605_Desc = {
    Text = "Gioca 440 carte in Traphase"
  },
  Task_131606_Desc = {
    Text = "Sconfiggi 123 Risvegliati in Traphase"
  },
  Task_131607_Desc = {
    Text = "Usa Esaltazione 198 volte in Traphase"
  },
  Task_131608_Desc = {
    Text = "Gioca 680 carte in Traphase"
  },
  Task_131609_Desc = {
    Text = "Sconfiggi 45 Risvegliati in Traphase"
  },
  Task_131610_Desc = {
    Text = "In Modalità Selezione a Turno, ottieni una Serie Vincente di 2 vittorie due volte"
  },
  Task_131611_Desc = {
    Text = "Usa Esaltazione 186 volte in Traphase"
  },
  Task_131612_Desc = {
    Text = "Usa Esaltazione 6 volte in Traphase"
  },
  Task_131613_Desc = {
    Text = "Gioca 620 carte in Traphase"
  },
  Task_131614_Desc = {
    Text = "In Modalità Selezione a Turno, ottieni una Serie Vincente di 2 vittorie una volta"
  },
  Task_131615_Desc = {
    Text = "Gioca 900 carte in Traphase"
  },
  Task_131616_Desc = {
    Text = "Usa Esaltazione 252 volte in Traphase"
  },
  Task_131617_Desc = {
    Text = "Gioca 980 carte in Traphase"
  },
  Task_131618_Desc = {
    Text = "Sconfiggi 141 Risvegliati in Traphase"
  },
  Task_131619_Desc = {
    Text = "Usa Esaltazione 288 volte in Traphase"
  },
  Task_131620_Desc = {
    Text = "Gioca 420 carte in Traphase"
  },
  Task_131621_Desc = {
    Text = "In Modalità Selezione a Turno, ottieni 10 vittorie"
  },
  Task_131622_Desc = {
    Text = "Gioca 340 carte in Traphase"
  },
  Task_131623_Desc = {
    Text = "In Modalità Selezione a Turno, ottieni 4 vittorie"
  },
  Task_131624_Desc = {
    Text = "Gioca 80 carte in Traphase"
  },
  Task_131625_Desc = {
    Text = "In Modalità Selezione Libera, ottieni una Serie Vincente di 2 vittorie due volte"
  },
  Task_131626_Desc = {
    Text = "Gioca 540 carte in Traphase"
  },
  Task_131627_Desc = {
    Text = "Usa Esaltazione 138 volte in Traphase"
  },
  Task_131628_Desc = {
    Text = "Usa Esaltazione 12 volte in Traphase"
  },
  Task_131768_Desc = {
    Text = "Completamento Psico-immersione \"La riva perduta\""
  },
  Task_131768_Name = {Text = "Cip!"},
  Task_131801_Name = {
    Text = "L'evento replica de Il Mio Turno è terminato"
  },
  Task_131891_Desc = {
    Text = "memoria eterna: Esclusiva Limitato"
  },
  Task_131892_Desc = {
    Text = "memoria eterna V"
  },
  Task_131893_Desc = {
    Text = "memoria eterna VII"
  },
  Task_131894_Desc = {
    Text = "memoria eterna II"
  },
  Task_131895_Desc = {
    Text = "memoria eterna I"
  },
  Task_131896_Desc = {
    Text = "memoria eterna: Gratis"
  },
  Task_131897_Desc = {
    Text = "memoria eterna III"
  },
  Task_131898_Desc = {
    Text = "memoria eterna IV"
  },
  Task_131899_Desc = {
    Text = "memoria eterna VI"
  },
  Task_132335_Desc = {
    Text = "Completamento Psyche Deepdive \"Giorno dell'Incoronazione\""
  },
  Task_132454_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_132454_Name = {
    Text = "10 vittorie"
  },
  Task_132455_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_132455_Name = {Text = "3 vittorie"},
  Task_132456_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_132456_Name = {Text = "6 vittorie"},
  Task_132457_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_132457_Name = {Text = "1 vittoria"},
  Task_132689_Desc = {
    Text = "Accedi da PC"
  },
  Task_132690_Desc = {
    Text = "Estrai Argento primordiale una volta tramite Mobile"
  },
  Task_132691_Desc = {
    Text = "Estrai Argento primordiale una volta tramite PC"
  },
  Task_132692_Desc = {
    Text = "Accedi da dispositivo mobile"
  },
  Task_132874_Desc = {
    Text = "Sconfiggi un Boss di Fase 3"
  },
  Task_132875_Desc = {
    Text = "Vinci 5 volte"
  },
  Task_132876_Desc = {
    Text = "Vinci 5 volte"
  },
  Task_132877_Desc = {
    Text = "Supera L'errante 3 volte"
  },
  Task_132909_Desc = {
    Text = "Supera la Prova di Arachne una volta"
  },
  Task_132910_Desc = {
    Text = "Completa 15 Incarichi"
  },
  Task_132911_Desc = {
    Text = "Completa una qualsiasi Missione stagionale"
  },
  Task_132912_Desc = {
    Text = "Gioca un totale di 300 carte"
  },
  Task_132913_Desc = {
    Text = "Completa una qualsiasi Missione stagionale"
  },
  Task_132914_Desc = {
    Text = "Risveglio 30 volte"
  },
  Task_132915_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_132916_Desc = {
    Text = "Supera la Prova di Arachne una volta"
  },
  Task_132917_Desc = {
    Text = "Completa 15 Incarichi"
  },
  Task_132918_Desc = {
    Text = "Accesso × 1 giorno"
  },
  Task_132919_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_132920_Desc = {
    Text = "L'Attività settimanale raggiunge 1000"
  },
  Task_132921_Desc = {
    Text = "L'Attività settimanale raggiunge 1000"
  },
  Task_132922_Desc = {
    Text = "Gioca un totale di 300 carte"
  },
  Task_132923_Desc = {
    Text = "Accesso × 1 giorno"
  },
  Task_132924_Desc = {
    Text = "Risveglio 30 volte"
  },
  Task_132928_Desc = {
    Text = "Completa tutte le missioni sopra indicate"
  },
  Task_132929_Desc = {
    Text = "Consuma 1800 Menofina"
  },
  Task_132930_Desc = {
    Text = "Completa tutte le Prove settimanali per 1 settimana"
  },
  Task_132931_Desc = {
    Text = "Accedi per 1 giorno"
  },
  Task_132932_Desc = {
    Text = "Completa 20 Incarichi"
  },
  Task_132933_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_133297_Desc = {
    Text = "Supera il Paesaggio Onirico \"Dominio Culinario\""
  },
  Task_133297_Name = {
    Text = "Gioisci! Infuriati! Piangi!"
  },
  Task_133302_Desc = {
    Text = "Gli Ioni attivi raffinati raggiungono 1000"
  },
  Task_133303_Desc = {
    Text = "Usa Supporto 3 volte"
  },
  Task_133304_Desc = {
    Text = "Gli Ioni attivi raffinati raggiungono 1000"
  },
  Task_133305_Desc = {
    Text = "Gioca un totale di 300 carte"
  },
  Task_133306_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_133307_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_133308_Desc = {
    Text = "Gioca un totale di 300 carte"
  },
  Task_133309_Desc = {
    Text = "Risveglio 30 volte"
  },
  Task_133310_Desc = {
    Text = "Accesso × 1 giorno"
  },
  Task_133311_Desc = {
    Text = "Completa una qualsiasi Missione stagionale"
  },
  Task_133312_Desc = {
    Text = "Risveglio 30 volte"
  },
  Task_133313_Desc = {
    Text = "Completa 15 Incarichi"
  },
  Task_133314_Desc = {
    Text = "Completa una qualsiasi Missione stagionale"
  },
  Task_133315_Desc = {
    Text = "Usa Supporto 3 volte"
  },
  Task_133316_Desc = {
    Text = "Accesso × 1 giorno"
  },
  Task_133317_Desc = {
    Text = "Completa 15 Incarichi"
  },
  Task_133940_Desc = {
    Text = "Metti Mi piace a un Alumnus una volta"
  },
  Task_133940_Name = {
    Text = "Metti \"mi piace\" ai tuoi amici"
  },
  Task_133941_Desc = {
    Text = "Consuma 180 Menofina"
  },
  Task_133941_Name = {
    Text = "Consuma Menofina"
  },
  Task_133943_Desc = {
    Text = "Gioca 50 carte"
  },
  Task_133943_Name = {
    Text = "Missione Quotidiana"
  },
  Task_133944_Desc = {
    Text = "Esegui 3 Incarichi"
  },
  Task_133944_Name = {
    Text = "Completa gli Incarichi"
  },
  Task_133945_Desc = {
    Text = "Completa 50 Trascrizioni del Patto"
  },
  Task_133945_Name = {
    Text = "Trascrizione del Patto"
  },
  Task_133946_Desc = {
    Text = "Completa il Dominio Arcano 1 volta"
  },
  Task_133946_Name = {
    Text = "Boss settimanale"
  },
  Task_133947_Desc = {
    Text = "Esegui 20 Cerimonie di Risveglio"
  },
  Task_133947_Name = {
    Text = "Pesca Carte"
  },
  Task_133948_Desc = {
    Text = "Consuma 1500 Menofina"
  },
  Task_133948_Name = {
    Text = "Consuma Menofina"
  },
  Task_133949_Desc = {
    Text = "Consuma 1.000.000 di Rosa dorata"
  },
  Task_133949_Name = {
    Text = "Spendaccione"
  },
  Task_134074_Desc = {
    Text = "Completa l'evento d'indagine \"@1@2\""
  },
  Task_134074_Desc2 = {
    Text = "Completa la Storia principale \"Fated Theater\""
  },
  Task_134074_Name2 = {
    Text = "Il Protagonista del Destino"
  },
  Task_134075_Desc = {
    Text = "Completa la Storia principale \"Fated Theater\" in Modalità Difficile"
  },
  Task_134075_Name = {
    Text = "Il Protagonista del Destino - Difficile"
  },
  Task_134095_Desc = {
    Text = "Risuona 3 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_134095_Desc2 = {
    Text = "Risuona 3 volte nella Storia principale \"Teatro del destino\""
  },
  Task_134095_Name2 = {
    Text = "Eco dell'Obbedienza"
  },
  Task_134096_Desc = {
    Text = "Risuona 10 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_134096_Desc2 = {
    Text = "Risuona 10 volte nella Storia principale \"Teatro del destino\""
  },
  Task_134096_Name2 = {
    Text = "Eco dell'Obbedienza IV"
  },
  Task_134097_Desc = {
    Text = "Risuona 9 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_134097_Desc2 = {
    Text = "Risuona 9 volte nella Storia principale \"Teatro del destino\""
  },
  Task_134097_Name2 = {
    Text = "Eco dell'Obbedienza III"
  },
  Task_134098_Desc = {
    Text = "Risuona 6 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_134098_Desc2 = {
    Text = "Risuona 6 volte nella Storia principale \"Fated Theater\""
  },
  Task_134098_Name2 = {
    Text = "Eco dell'Obbedienza II"
  },
  Task_134099_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_134099_Name = {
    Text = "Superamento Perfetto"
  },
  Task_134121_Desc = {
    Text = "Caraboo raggiunge Ondata Psichica 12"
  },
  Task_134122_Desc = {
    Text = "Caecus raggiunge Ondata Psichica 12"
  },
  Task_134123_Desc = {
    Text = "Faros raggiunge Ondata Psichica 12"
  },
  Task_134124_Desc = {
    Text = "Mouchette raggiunge Ondata Psichica 12"
  },
  Task_134125_Desc = {
    Text = "Saya raggiunge Ondata Psichica 12"
  },
  Task_134126_Desc = {
    Text = "Tsathoggua raggiunge Ondata Psichica 12"
  },
  Task_134127_Desc = {
    Text = "Thais raggiunge Ondata Psichica 12"
  },
  Task_134128_Desc = {
    Text = "Tulu: Sovrano raggiunge Ondata Psichica 12"
  },
  Task_134129_Desc = {
    Text = "Helot raggiunge Ondata Psichica 12"
  },
  Task_134130_Desc = {
    Text = "Tawil raggiunge Ondata Psichica 12"
  },
  Task_134131_Desc = {
    Text = "Pollux raggiunge Ondata Psichica 12"
  },
  Task_134132_Desc = {
    Text = "24 raggiunge Ondata Psichica 12"
  },
  Task_134134_Desc = {
    Text = "Uvhash raggiunge Ondata Psichica 12"
  },
  Task_134135_Desc = {
    Text = "Murphy: Falsonata raggiunge Ondata Psichica 12"
  },
  Task_134136_Desc = {
    Text = "Doll: Inferno raggiunge Ondata Psichica 12"
  },
  Task_134137_Desc = {
    Text = "Pickman raggiunge Ondata Psichica 12"
  },
  Task_134138_Desc = {
    Text = "Pandia raggiunge Ondata Psichica 12"
  },
  Task_134140_Desc = {
    Text = "Horla raggiunge Ondata Psichica 12"
  },
  Task_134141_Desc = {
    Text = "Xu raggiunge Ondata Psichica 12"
  },
  Task_134142_Desc = {
    Text = "Tintura raggiunge Ondata Psichica 12"
  },
  Task_134143_Desc = {
    Text = "Kathigu-Ra raggiunge Ondata Psichica 12"
  },
  Task_134144_Desc = {
    Text = "Leigh raggiunge Ondata Psichica 12"
  },
  Task_134145_Desc = {
    Text = "Murphy raggiunge Ondata Psichica 12"
  },
  Task_134146_Desc = {
    Text = "Doresain raggiunge Ondata Psichica 12"
  },
  Task_134148_Desc = {
    Text = "Corposant raggiunge Ondata Psichica 12"
  },
  Task_134149_Desc = {
    Text = "Lily raggiunge Ondata Psichica 12"
  },
  Task_134150_Desc = {
    Text = "Helot-catena raggiunge Ondata Psichica 12"
  },
  Task_134151_Desc = {
    Text = "Winkle raggiunge Ondata Psichica 12"
  },
  Task_134152_Desc = {
    Text = "Hameln raggiunge Ondata Psichica 12"
  },
  Task_134153_Desc = {
    Text = "Ryker raggiunge Ondata Psichica 12"
  },
  Task_134154_Desc = {
    Text = "Sanga raggiunge Ondata Psichica 12"
  },
  Task_134155_Desc = {
    Text = "Casiah raggiunge Ondata Psichica 12"
  },
  Task_134156_Desc = {
    Text = "Castor raggiunge Ondata Psichica 12"
  },
  Task_134157_Desc = {
    Text = "Vortice raggiunge Ondata Psichica 12"
  },
  Task_134158_Desc = {
    Text = "Faint raggiunge Ondata Psichica 12"
  },
  Task_134159_Desc = {
    Text = "Nautila raggiunge Ondata Psichica 12"
  },
  Task_134160_Desc = {
    Text = "Agrippa raggiunge Ondata Psichica 12"
  },
  Task_134161_Desc = {
    Text = "Jenkin raggiunge Ondata Psichica 12"
  },
  Task_134162_Desc = {
    Text = "Salvador raggiunge Ondata Psichica 12"
  },
  Task_134163_Desc = {
    Text = "Arachne raggiunge Ondata Psichica 12"
  },
  Task_134164_Desc = {
    Text = "Daffodil raggiunge Ondata Psichica 12"
  },
  Task_134165_Desc = {
    Text = "Celeste raggiunge Ondata Psichica 12"
  },
  Task_134166_Desc = {
    Text = "Sorel raggiunge Ondata Psichica 12"
  },
  Task_134167_Desc = {
    Text = "Golia raggiunge Ondata Psichica 12"
  },
  Task_134168_Desc = {
    Text = "Tulu raggiunge Ondata Psichica 12"
  },
  Task_134169_Desc = {
    Text = "Clementine raggiunge Ondata Psichica 12"
  },
  Task_134170_Desc = {
    Text = "Karen raggiunge Ondata Psichica 12"
  },
  Task_134171_Desc = {
    Text = "Nymphaea raggiunge Ondata Psichica 12"
  },
  Task_134172_Desc = {
    Text = "Wanda raggiunge Ondata Psichica 12"
  },
  Task_134173_Desc = {
    Text = "Liz raggiunge Ondata Psichica 12"
  },
  Task_134174_Desc = {
    Text = "Alva raggiunge Ondata Psichica 12"
  },
  Task_134175_Desc = {
    Text = "Miryam raggiunge Ondata Psichica 12"
  },
  Task_134394_Desc = {
    Text = "Accesso cumulativo per 6 giorni"
  },
  Task_134395_Desc = {
    Text = "Accedi per un totale di 10 giorni"
  },
  Task_134396_Desc = {
    Text = "Accesso: 16 giorni"
  },
  Task_134397_Desc = {
    Text = "Accedi per un totale di 7 giorni"
  },
  Task_134398_Desc = {
    Text = "Accedi per un totale di 15 giorni"
  },
  Task_134399_Desc = {
    Text = "Accesso: 9 giorni"
  },
  Task_134400_Desc = {
    Text = "Accedi per un totale di 4 giorni"
  },
  Task_134401_Desc = {
    Text = "Accesso: 14 giorni"
  },
  Task_134402_Desc = {
    Text = "Accedi per 5 giorni cumulativi"
  },
  Task_134403_Desc = {
    Text = "Accesso: 11 giorni"
  },
  Task_134404_Desc = {
    Text = "Accesso: 13 giorni"
  },
  Task_134405_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_134406_Desc = {
    Text = "Accedi per un totale di 2 giorni"
  },
  Task_134407_Desc = {
    Text = "Accedi per 3 giorni cumulativi"
  },
  Task_134408_Desc = {
    Text = "Accedi per un totale di 8 giorni"
  },
  Task_134409_Desc = {
    Text = "Accesso: 12 giorni"
  },
  Task_135038_Desc = {
    Text = "Accedi al gioco"
  },
  Task_135038_Name = {
    Text = "Accedi al gioco"
  },
  Task_137649_Desc = {
    Text = "Gioca 150 carte in questa stagione"
  },
  Task_137650_Desc = {
    Text = "Gioca 150 carte in questa stagione"
  },
  Task_138583_Desc = {
    Text = "Risveglio 30 volte"
  },
  Task_138584_Desc = {
    Text = "Completa una qualsiasi Missione stagionale"
  },
  Task_138585_Desc = {
    Text = "Gioca un totale di 300 carte"
  },
  Task_138586_Desc = {
    Text = "Usa Supporto 3 volte"
  },
  Task_138587_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_138588_Desc = {
    Text = "Accesso × 1 giorno"
  },
  Task_138589_Desc = {
    Text = "Risveglio 30 volte"
  },
  Task_138590_Desc = {
    Text = "Completa 15 Incarichi"
  },
  Task_138591_Desc = {
    Text = "Gioca un totale di 300 carte"
  },
  Task_138592_Desc = {
    Text = "Usa Supporto 3 volte"
  },
  Task_138593_Desc = {
    Text = "Gli Ioni attivi raffinati raggiungono 1000"
  },
  Task_138594_Desc = {
    Text = "Gli Ioni attivi raffinati raggiungono 1000"
  },
  Task_138595_Desc = {
    Text = "Accesso × 1 giorno"
  },
  Task_138596_Desc = {
    Text = "Completa una qualsiasi Missione stagionale"
  },
  Task_138597_Desc = {
    Text = "Completa 15 Incarichi"
  },
  Task_138598_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_138762_Desc = {
    Text = "Dopo aver subito \"Elegia che trascende il destino\", sconfiggi \"Rete del tradimento\" Nefrea."
  },
  Task_138762_Name = {
    Text = "Protagonista del destino·Nascosto"
  },
  Task_139118_Desc = {
    Text = "Completa \"Collegamento Multiverso - Semi d'amore dimenticati\""
  },
  Task_139119_Desc = {
    Text = "Completa tutte le missioni sopra indicate"
  },
  Task_139121_Desc = {
    Text = "Risveglio 1000 volte"
  },
  Task_139123_Desc = {
    Text = "Effettua il Risveglio 250 volte"
  },
  Task_139124_Desc = {
    Text = "Accedi per 1 giorno"
  },
  Task_139125_Desc = {
    Text = "Azzera \"Operazione d'indagine - Eredità Sbiadita - Capitolo 4\" Modalità Normale"
  },
  Task_139126_Desc = {
    Text = "Effettua il Risveglio 500 volte"
  },
  Task_139127_Desc = {
    Text = "Effettua il Risveglio 100 volte"
  },
  Task_139600_Desc = {
    Text = "Cattura 1000000 volte in totale"
  },
  Task_139614_Desc = {
    Text = "Cattura 500000 volte in totale"
  },
  Task_139618_Desc = {
    Text = "Cattura 50 volte in totale"
  },
  Task_139619_Desc = {
    Text = "Cattura 1000000 volte in totale"
  },
  Task_139626_Desc = {
    Text = "Cattura 300000 volte in totale"
  },
  Task_139629_Desc = {
    Text = "Cattura 700000 volte in totale"
  },
  Task_139646_Desc = {
    Text = "Registro Catture Campus"
  },
  Task_139649_Desc = {
    Text = "Cattura 100000 volte in totale"
  },
  Task_139651_Desc = {
    Text = "Registro Catture Personale"
  },
  Task_139652_Desc = {
    Text = "Cattura 100 volte in totale"
  },
  Task_140087_Desc = {
    Text = "Azzera \"Il Gatto più Grande\" 1 volta"
  },
  Task_140088_Desc = {
    Text = "Completa \"Corsa all'Oro Nero\" 1 volta"
  },
  Task_140089_Desc = {
    Text = "Azzera \"Resistenza all'Arresto\" 10 volte"
  },
  Task_140090_Desc = {
    Text = "Azzera \"Tirateli Dentro!\" 5 volte"
  },
  Task_140091_Desc = {
    Text = "Azzera \"Rientro a pieno carico\" 5 volte"
  },
  Task_140092_Desc = {
    Text = "Azzera \"Resistenza all'Arresto\" 1 volta"
  },
  Task_140093_Desc = {
    Text = "Azzera \"Il Gatto più Grande\" 10 volte"
  },
  Task_140094_Desc = {
    Text = "Azzera \"Primo Secchio d'Argento\" 5 volte"
  },
  Task_140095_Desc = {
    Text = "Completa \"Corsa all'Oro Nero\" 5 volte"
  },
  Task_140096_Desc = {
    Text = "Azzera \"Primo Secchio d'Argento\" 1 volta"
  },
  Task_140097_Desc = {
    Text = "Azzera \"Rientro a pieno carico\" 10 volte"
  },
  Task_140098_Desc = {
    Text = "Azzera \"Resistenza all'Arresto\" 5 volte"
  },
  Task_140099_Desc = {
    Text = "Azzera \"Il Gatto più Grande\" 5 volte"
  },
  Task_140100_Desc = {
    Text = "Azzera \"Rientro a pieno carico\" 1 volta"
  },
  Task_140101_Desc = {
    Text = "Azzera \"Tirateli Dentro!\" 10 volte"
  },
  Task_140102_Desc = {
    Text = "Azzera \"farlo di nuovo\" 1 volta"
  },
  Task_140103_Desc = {
    Text = "Azzera \"farlo di nuovo\" 10 volte"
  },
  Task_140104_Desc = {
    Text = "Azzera \"Primo Secchio d'Argento\" 10 volte"
  },
  Task_140105_Desc = {
    Text = "Azzera \"Tirateli Dentro!\" 1 volta"
  },
  Task_140106_Desc = {
    Text = "Azzera \"Corsa all'Oro Nero\" 10 volte"
  },
  Task_140107_Desc = {
    Text = "Azzera \"farlo di nuovo\" 5 volte"
  },
  Task_140114_Desc = {
    Text = "Completa \"Collegamento Multiverso - Semi d'amore dimenticati\""
  },
  Task_140115_Desc = {
    Text = "Completa tutte le missioni sopra indicate"
  },
  Task_140116_Desc = {
    Text = "Accedi per 1 giorno"
  },
  Task_140117_Desc = {
    Text = "Azzera \"Operazione d'indagine - Eredità Sbiadita - Capitolo 4\" Modalità Normale"
  },
  Task_140189_Desc = {
    Text = "Estrai 5000 Essenza di Silver Core"
  },
  Task_140190_Desc = {
    Text = "Estrai 20000 Essenza di Silver Core"
  },
  Task_140191_Desc = {
    Text = "Estrai 10000 Essenza di Silver Core"
  },
  Task_140192_Desc = {
    Text = "Estrai 30000 Essenza di Silver Core"
  },
  Task_140306_Desc = {
    Text = "Azzera Collegamento Multiverso \"Semi d'amore dimenticati\" a difficoltà Difficile"
  },
  Task_140306_Name = {
    Text = "La Meta del Vagabondo · Difficile"
  },
  Task_140307_Desc = {
    Text = "Azzera Collegamento Multiverso \"Semi d'amore dimenticati\""
  },
  Task_140307_Name = {
    Text = "La Meta del Vagabondo"
  },
  Task_140463_Desc = {
    Text = "Gioca un totale di 200 carte"
  },
  Task_140464_Desc = {
    Text = "Completa 20 Incarichi"
  },
  Task_140465_Desc = {
    Text = "Accedi per 1 giorno"
  },
  Task_140466_Desc = {
    Text = "Gli Ioni attivi raffinati raggiungono 1000"
  },
  Task_140467_Desc = {
    Text = "Completa tutte le missioni sopra indicate"
  },
  Task_140468_Desc = {
    Text = "Completa una qualsiasi Missione stagionale"
  },
  Task_141311_Desc = {
    Text = "Azzera L'errante \"Ebwynnos Evermore\""
  },
  Task_141312_Desc = {
    Text = "Raggiungi il livello 10 di Affinità con Pontos"
  },
  Task_141313_Desc = {
    Text = "Vinci 1 volta in \"La Caccia all'Alta Casa\" usando un Risvegliatore Ultra"
  },
  Task_141314_Desc = {
    Text = "Azzera \"Foresta Oscura\" in Difficoltà Follia"
  },
  Task_141315_Desc = {
    Text = "Azzera \"Idromele e Mirra\" a qualsiasi difficoltà"
  },
  Task_141316_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_141317_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_141318_Desc = {
    Text = "Azzera \"Soliloquio\" a qualsiasi difficoltà"
  },
  Task_141319_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_141320_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_141321_Desc = {
    Text = "Vinci 2 volte in \"La Caccia all'Alta Casa\" usando un Risvegliatore Caro"
  },
  Task_141322_Desc = {
    Text = "Vinci 2 volte in \"La Caccia all'Alta Casa\" usando un Risvegliatore del Chaos"
  },
  Task_141323_Desc = {
    Text = "Vinci 1 volta in \"La Caccia all'Alta Casa\" usando un Risvegliatore di Aequor"
  },
  Task_141324_Desc = {
    Text = "La Caccia all'Alta Casa·Reame"
  },
  Task_141325_Desc = {
    Text = "Azzera \"Il Fischio\" in Difficoltà Follia"
  },
  Task_141326_Desc = {
    Text = "Azzera \"Il Gioco del Predatore\" a qualsiasi difficoltà"
  },
  Task_141327_Desc = {
    Text = "Azzera \"Idromele e Mirra\" a qualsiasi difficoltà"
  },
  Task_141328_Desc = {
    Text = "Azzera \"Foresta Oscura\" a qualsiasi difficoltà"
  },
  Task_141329_Desc = {
    Text = "La Caccia all'Alta Casa: Follia"
  },
  Task_141330_Desc = {
    Text = "Azzera \"Dualismo\" in Difficoltà Follia"
  },
  Task_141331_Desc = {
    Text = "Azzera \"Foresta Oscura\" a qualsiasi difficoltà"
  },
  Task_141332_Desc = {
    Text = "Azzera \"Idromele e Mirra\" in Difficoltà Follia"
  },
  Task_141333_Desc = {
    Text = "Azzera \"Soliloquio\" in Difficoltà Follia"
  },
  Task_141335_Desc = {
    Text = "Azzera \"Costola e Cartilagine\" a qualsiasi difficoltà"
  },
  Task_141336_Desc = {
    Text = "Azzera \"Dualismo\" in qualsiasi difficoltà"
  },
  Task_141337_Desc = {
    Text = "Completa tutti gli Obiettivi di \"La Caccia all'Alta Casa: Completato\""
  },
  Task_141338_Desc = {
    Text = "Illuminare 6 all'ottenimento di Pontos"
  },
  Task_141338_Name = {
    Text = "Illuminare 6 all'ottenimento di Pontos"
  },
  Task_141338_UnlockCondDesc = {
    Text = "Evento@Pacchetto Illuminare 2 Risvegliatore Pontos Evento"
  },
  Task_141339_Desc = {
    Text = "Azzera \"Costola e Cartilagine\" a qualsiasi difficoltà"
  },
  Task_141340_Desc = {
    Text = "Azzera \"Dualismo\" in qualsiasi difficoltà"
  },
  Task_141341_Desc = {
    Text = "La Caccia all'Alta Casa: Completato"
  },
  Task_141342_Desc = {
    Text = "Vinci 2 volte in \"La Caccia all'Alta Casa\" usando un Risvegliatore di Aequor"
  },
  Task_141343_Desc = {
    Text = "Azzera \"Il Fischio\" a qualsiasi difficoltà"
  },
  Task_141344_Desc = {
    Text = "Azzera \"Soliloquio\" a qualsiasi difficoltà"
  },
  Task_141345_Desc = {
    Text = "Vinci 2 volte in \"La Caccia all'Alta Casa\" usando un Risvegliatore Ultra"
  },
  Task_141346_Desc = {
    Text = "Vinci 1 volta in \"La Caccia all'Alta Casa\" usando un Risvegliatore del Chaos"
  },
  Task_141347_Desc = {
    Text = "Azzera \"Il Gioco del Predatore\" in Difficoltà Follia"
  },
  Task_141348_Desc = {
    Text = "Azzera \"Il Fischio\" a qualsiasi difficoltà"
  },
  Task_141349_Desc = {
    Text = "Vinci 1 volta in \"La Caccia all'Alta Casa\" usando un Risvegliatore Caro"
  },
  Task_141350_Desc = {
    Text = "Raggiungi l'Ondata Psichica 12 con Pontos"
  },
  Task_141351_Desc = {
    Text = "Illuminare 2 all'ottenimento di Pontos"
  },
  Task_141351_Name = {
    Text = "Illuminare 2 all'ottenimento di Pontos"
  },
  Task_141351_UnlockCondDesc = {
    Text = "Evento@Pacchetto Illuminare 2 Risvegliatore Pontos Evento"
  },
  Task_141352_Desc = {
    Text = "Azzera \"Il Gioco del Predatore\" a qualsiasi difficoltà"
  },
  Task_141353_Desc = {
    Text = "Azzera \"Costola e Cartilagine\" in Difficoltà Follia"
  },
  Task_141511_Desc = {
    Text = "Gioca un totale di 300 carte"
  },
  Task_141512_Desc = {
    Text = "Completa una qualsiasi Missione stagionale"
  },
  Task_141513_Desc = {
    Text = "Usa Supporto 3 volte"
  },
  Task_141514_Desc = {
    Text = "Completa 15 Incarichi"
  },
  Task_141515_Desc = {
    Text = "Accesso × 1 giorno"
  },
  Task_141516_Desc = {
    Text = "Accesso × 1 giorno"
  },
  Task_141517_Desc = {
    Text = "Risveglio 30 volte"
  },
  Task_141518_Desc = {
    Text = "Completa una qualsiasi Missione stagionale"
  },
  Task_141519_Desc = {
    Text = "Usa Supporto 3 volte"
  },
  Task_141520_Desc = {
    Text = "Gli Ioni attivi raffinati raggiungono 1000"
  },
  Task_141521_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_141522_Desc = {
    Text = "Gioca un totale di 300 carte"
  },
  Task_141523_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_141524_Desc = {
    Text = "Risveglio 30 volte"
  },
  Task_141525_Desc = {
    Text = "Gli Ioni attivi raffinati raggiungono 1000"
  },
  Task_141526_Desc = {
    Text = "Completa 15 Incarichi"
  },
  Task_141799_Desc = {
    Text = "Con i Risvegliatori di Aequor, vinci due volte nei \"Tesori di Umapati\""
  },
  Task_141800_Desc = {
    Text = "Con i Risvegliatori Ultra, vinci due volte in \"Tesori di Umapati\""
  },
  Task_141801_Desc = {
    Text = "Azzera \"Filo\" a qualsiasi difficoltà"
  },
  Task_141802_Desc = {
    Text = "Con i Risvegliatori di Caro, vinci due volte nei \"Tesori di Umapati\""
  },
  Task_141803_Desc = {
    Text = "Completa tutti i traguardi di \"Tesori di Umapati: Completato\""
  },
  Task_141804_Desc = {
    Text = "Con i Risvegliatori del Chaos, vinci una volta nei \"Tesori di Umapati\""
  },
  Task_141805_Desc = {
    Text = "Azzera \"Mela\" a qualsiasi difficoltà"
  },
  Task_141806_Desc = {
    Text = "Completa \"Sguardo dello Specchio\" a qualsiasi difficoltà"
  },
  Task_141807_Desc = {
    Text = "Azzera \"Chiave\" a qualsiasi difficoltà"
  },
  Task_141808_Desc = {
    Text = "Completa \"Sguardo dello Specchio\" a Difficoltà Follia"
  },
  Task_141809_Desc = {
    Text = "Azzera \"Corona\" in Difficoltà Follia"
  },
  Task_141810_Desc = {
    Text = "Azzera \"Piuma\" a qualsiasi difficoltà"
  },
  Task_141811_Desc = {
    Text = "Azzera \"Occhio\" a qualsiasi difficoltà"
  },
  Task_141812_Desc = {
    Text = "Azzera \"Filo\" in Difficoltà Follia"
  },
  Task_141813_Desc = {
    Text = "Azzera \"Mela\" in Difficoltà Follia"
  },
  Task_141814_Desc = {
    Text = "Azzera \"Corona\" a qualsiasi difficoltà"
  },
  Task_141815_Desc = {
    Text = "Con i Risvegliatori di Caro, vinci una volta nei \"Tesori di Umapati\""
  },
  Task_141816_Desc = {
    Text = "Completa \"Sguardo dello Specchio\" a qualsiasi difficoltà"
  },
  Task_141817_Desc = {
    Text = "Azzera \"Piuma\" in Difficoltà Follia"
  },
  Task_141818_Desc = {
    Text = "Azzera \"Piuma\" a qualsiasi difficoltà"
  },
  Task_141819_Desc = {
    Text = "Tesori di Umapati: Follia"
  },
  Task_141820_Desc = {
    Text = "Tesori di Umapati: Reame"
  },
  Task_141821_Desc = {
    Text = "Azzera \"Occhio\" a qualsiasi difficoltà"
  },
  Task_141822_Desc = {
    Text = "Azzera \"Filo\" a qualsiasi difficoltà"
  },
  Task_141823_Desc = {
    Text = "Azzera \"Chiave\" a qualsiasi difficoltà"
  },
  Task_141824_Desc = {
    Text = "Tesori di Umapati: Completato"
  },
  Task_141825_Desc = {
    Text = "Azzera \"Mela\" a qualsiasi difficoltà"
  },
  Task_141826_Desc = {
    Text = "Con i Risvegliatori Ultra, vinci una volta nei \"Tesori di Umapati\""
  },
  Task_141827_Desc = {
    Text = "Con i Risvegliatori di Aequor, vinci una volta nei \"Tesori di Umapati\""
  },
  Task_141828_Desc = {
    Text = "Azzera \"Occhio\" in Difficoltà Follia"
  },
  Task_141829_Desc = {
    Text = "Con i Risvegliatori del Chaos, vinci due volte nei \"Tesori di Umapati\""
  },
  Task_141830_Desc = {
    Text = "Azzera \"Chiave\" in Difficoltà Follia"
  },
  Task_141831_Desc = {
    Text = "Azzera \"Corona\" a qualsiasi difficoltà"
  },
  Task_141899_Desc = {
    Text = "Collega il numero di telefono o l'e-mail in \"Centro utente - Completa il profilo\""
  },
  Task_143320_Desc = {
    Text = "Completa L'errante \"Ebwynnos Evermore\" in modalità Difficile"
  },
  Task_143320_Name = {
    Text = "Una fresca notte d'estate · Difficile"
  },
  Task_143321_Desc = {
    Text = "Completa L'errante \"Ebwynnos Evermore\""
  },
  Task_143321_Name = {
    Text = "Una fresca notte d'estate"
  },
  Task_143588_Desc = {
    Text = "Restare nel suo abbraccio..."
  },
  Task_143588_Name = {
    Text = "Restare nel suo abbraccio..."
  },
  Task_143589_Desc = {Text = "Restare…"},
  Task_143589_Name = {Text = "Restare…"},
  Task_143590_Desc = {
    Text = "Restare a Ebwynnos"
  },
  Task_143590_Name = {
    Text = "Restare a Ebwynnos"
  },
  Task_144311_Desc = {
    Text = "Ottieni 250/500/750/1000 pt quando vengono schierati 1/2/3/4 Risvegliatori potenziati settimanali. (Attualmente: {s1})"
  },
  Task_144311_Name = {
    Text = "Richiamo dell'Abisso<size=20><color=#747474>Quando si schierano 1/2/3/4 Risvegliatori Potenziati, si ottengono 250 / 500 / 750 / 1000 punti </color></size>"
  },
  Task_144312_Desc = {
    Text = "Supera L'errante \"Testo Temporaneo\""
  },
  Task_144313_Desc = {
    Text = "rinascita sottosopra: Completato"
  },
  Task_144314_Desc = {
    Text = "Azzera \"Neurotrauma\" in Difficoltà Follia"
  },
  Task_144315_Desc = {
    Text = "Con i Risvegliatori di Aequor, vinci una volta in \"rinascita sottosopra\""
  },
  Task_144316_Desc = {
    Text = "Azzera \"Bicchiere della Staffa\" in Difficoltà Follia"
  },
  Task_144317_Desc = {
    Text = "Azzera \"Bicchiere della Staffa\" in qualsiasi difficoltà"
  },
  Task_144318_Desc = {
    Text = "rinascita sottosopra: Reame"
  },
  Task_144319_Desc = {
    Text = "Azzera \"L'Ospedale\" a qualsiasi difficoltà"
  },
  Task_144320_Desc = {
    Text = "Con i Risvegliatori di Aequor, vinci due volte in \"rinascita sottosopra\""
  },
  Task_144321_Desc = {
    Text = "Azzera \"Tavolo da Pranzo\" in qualsiasi difficoltà"
  },
  Task_144322_Desc = {
    Text = "Azzera \"Tavolo da Pranzo\" in Difficoltà Follia"
  },
  Task_144323_Desc = {
    Text = "Azzera \"Casa Nostra\" a qualsiasi difficoltà"
  },
  Task_144324_Desc = {
    Text = "Con i Risvegliatori Ultra, vinci una volta in \"rinascita sottosopra\""
  },
  Task_144325_Desc = {
    Text = "Azzera \"Il Pozzo\" in qualsiasi difficoltà"
  },
  Task_144326_Desc = {
    Text = "Azzera \"Casa Nostra\" a qualsiasi difficoltà"
  },
  Task_144327_Desc = {
    Text = "Con i Risvegliatori del Caos, vinci due volte in \"rinascita sottosopra\""
  },
  Task_144328_Desc = {
    Text = "Azzera \"L'Ospedale\" a qualsiasi difficoltà"
  },
  Task_144329_Desc = {
    Text = "Azzera \"Il Pozzo\" in qualsiasi difficoltà"
  },
  Task_144330_Desc = {
    Text = "Azzera \"A Scuola\" in qualsiasi difficoltà"
  },
  Task_144331_Desc = {
    Text = "Azzera \"Neurotrauma\" in qualsiasi difficoltà"
  },
  Task_144332_Desc = {
    Text = "Completa tutti gli obiettivi di \"rinascita sottosopra: Completato\""
  },
  Task_144333_Desc = {
    Text = "Azzera \"Tavolo da Pranzo\" in qualsiasi difficoltà"
  },
  Task_144334_Desc = {
    Text = "Azzera \"A Scuola\" in Difficoltà Follia"
  },
  Task_144335_Desc = {
    Text = "Completa \"Casa Nostra\" a Difficoltà Follia"
  },
  Task_144336_Desc = {
    Text = "Con i Risvegliatori di Caro, vinci una volta in \"rinascita sottosopra\""
  },
  Task_144337_Desc = {
    Text = "Azzera \"Neurotrauma\" in qualsiasi difficoltà"
  },
  Task_144338_Desc = {
    Text = "Azzera \"A Scuola\" in qualsiasi difficoltà"
  },
  Task_144339_Desc = {
    Text = "Azzera \"Bicchiere della Staffa\" in qualsiasi difficoltà"
  },
  Task_144340_Desc = {
    Text = "Con i Risvegliatori di Caro, vinci due volte in \"rinascita sottosopra\""
  },
  Task_144341_Desc = {
    Text = "Con i Risvegliatori del Caos, vinci una volta in \"rinascita sottosopra\""
  },
  Task_144342_Desc = {
    Text = "Con i Risvegliatori Ultra, vinci due volte in \"rinascita sottosopra\""
  },
  Task_144343_Desc = {
    Text = "rinascita sottosopra: Follia"
  },
  Task_144344_Desc = {
    Text = "Azzera \"Il Pozzo\" in Difficoltà Follia"
  },
  Task_144345_Desc = {
    Text = "Completa \"L'Ospedale\" a Difficoltà Follia"
  },
  Task_144360_Desc = {
    Text = "Gioca un totale di 300 carte"
  },
  Task_144361_Desc = {
    Text = "Completa una qualsiasi Missione stagionale"
  },
  Task_144362_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_144363_Desc = {
    Text = "Completa 15 Incarichi"
  },
  Task_144364_Desc = {
    Text = "Gli Ioni attivi raffinati raggiungono 1000"
  },
  Task_144365_Desc = {
    Text = "Risveglio 30 volte"
  },
  Task_144366_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_144367_Desc = {
    Text = "Accesso × 1 giorno"
  },
  Task_144368_Desc = {
    Text = "Completa una qualsiasi Missione stagionale"
  },
  Task_144369_Desc = {
    Text = "Completa 15 Incarichi"
  },
  Task_144370_Desc = {
    Text = "Gioca un totale di 300 carte"
  },
  Task_144371_Desc = {
    Text = "Gli Ioni attivi raffinati raggiungono 1000"
  },
  Task_144372_Desc = {
    Text = "Risveglio 30 volte"
  },
  Task_144373_Desc = {
    Text = "Usa Supporto 3 volte"
  },
  Task_144374_Desc = {
    Text = "Usa Supporto 3 volte"
  },
  Task_144375_Desc = {
    Text = "Accesso × 1 giorno"
  },
  Task_145388_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_145389_Desc = {
    Text = "Con i Risvegliatori di Aequor, vinci due volte in \"Avidità e Sete di Sangue\""
  },
  Task_145390_Desc = {
    Text = "Completa \"L'Offerta\" a qualsiasi difficoltà"
  },
  Task_145392_Desc = {
    Text = "Avidità e Sete di Sangue: Completato"
  },
  Task_145393_Desc = {
    Text = "Azzera \"Sala del Massacro\" in Difficoltà Follia"
  },
  Task_145394_Desc = {
    Text = "Azzera \"Corona del Desiderio\" in qualsiasi difficoltà"
  },
  Task_145395_Desc = {
    Text = "Completa L'errante \"Until the Whale Sky Falls\""
  },
  Task_145396_Desc = {
    Text = "Illuminare 6 dopo aver ottenuto Lotan: Cetarchon"
  },
  Task_145396_Name = {
    Text = "Illuminare 6 dopo aver ottenuto Lotan: Cetarchon"
  },
  Task_145396_UnlockCondDesc = {
    Text = "Evento @ Risvegliatore Lotan: Cetarchon Pacchetto Illuminazione 2 Evento"
  },
  Task_145397_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_145398_Desc = {
    Text = "L'Affinità di Lotan: Cetarchon raggiunge il Livello 10"
  },
  Task_145399_Desc = {
    Text = "Avidità e Sete di Sangue: Reame"
  },
  Task_145400_Desc = {
    Text = "Completa \"Bestia in Gabbia\" a qualsiasi difficoltà"
  },
  Task_145401_Desc = {
    Text = "Completa \"Sala del Massacro\" a qualsiasi difficoltà"
  },
  Task_145402_Desc = {
    Text = "Completa \"Bestia in Gabbia\" a qualsiasi difficoltà"
  },
  Task_145403_Desc = {
    Text = "Azzera \"Bestia in Gabbia\" in Difficoltà Follia"
  },
  Task_145404_Desc = {
    Text = "Con i Risvegliatori Ultra, vinci una volta in \"Avidità e Sete di Sangue\""
  },
  Task_145405_Desc = {
    Text = "Con i Risvegliatori del Chaos, vinci due volte in \"Avidità e Sete di Sangue\""
  },
  Task_145406_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_145408_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_145409_Desc = {
    Text = "Azzera \"Corona del Desiderio\" in qualsiasi difficoltà"
  },
  Task_145410_Desc = {
    Text = "Completa tutti i risultati di \"Avidità e Sete di Sangue: Completato\""
  },
  Task_145411_Desc = {
    Text = "Con i Risvegliatori di Caro, vinci una volta in \"Avidità e Sete di Sangue\""
  },
  Task_145412_Desc = {
    Text = "Con i Risvegliatori di Caro, vinci due volte in \"Avidità e Sete di Sangue\""
  },
  Task_145413_Desc = {
    Text = "Completa \"L'Offerta\" a qualsiasi difficoltà"
  },
  Task_145414_Desc = {
    Text = "Illuminare 2 dopo aver ottenuto Lotan: Cetarchon"
  },
  Task_145414_Name = {
    Text = "Illuminare 2 dopo aver ottenuto Lotan: Cetarchon"
  },
  Task_145414_UnlockCondDesc = {
    Text = "Evento @ Risvegliatore Lotan: Cetarchon Pacchetto Illuminazione 2 Evento"
  },
  Task_145415_Desc = {
    Text = "Con i Risvegliatori del Chaos, vinci una volta in \"Avidità e Sete di Sangue\""
  },
  Task_145416_Desc = {
    Text = "Con i Risvegliatori Ultra, vinci due volte in \"Avidità e Sete di Sangue\""
  },
  Task_145417_Desc = {
    Text = "Azzera \"L'Offerta\" in Difficoltà Follia"
  },
  Task_145418_Desc = {
    Text = "Avidità e Sete di Sangue: Follia"
  },
  Task_145419_Desc = {
    Text = "Azzera \"Lo Specchio Vuoto\" in Difficoltà Follia"
  },
  Task_145420_Desc = {
    Text = "Completa \"Lo Specchio Vuoto\" a qualsiasi difficoltà"
  },
  Task_145421_Desc = {
    Text = "Azzera \"Corona del Desiderio\" in Difficoltà Follia"
  },
  Task_145423_Desc = {
    Text = "Con i Risvegliatori di Aequor, vinci una volta in \"Avidità e Sete di Sangue\""
  },
  Task_145424_Desc = {
    Text = "Completa \"Lo Specchio Vuoto\" a qualsiasi difficoltà"
  },
  Task_145425_Desc = {
    Text = "Lotan: Cetarchon raggiunge l'Ondata Psichica 12"
  },
  Task_145426_Desc = {
    Text = "Completa \"Sala del Massacro\" a qualsiasi difficoltà"
  },
  Task_145479_Desc = {
    Text = "Completa L'errante \"Finché il Ceto Non Cade\""
  },
  Task_145479_Name = {
    Text = "Io Sono la Tempesta"
  },
  Task_145576_Desc = {
    Text = "Testo Temporaneo · Esclusiva a tempo limitato"
  },
  Task_145578_Desc = {
    Text = "Arte dei Mille Desideri: Esclusiva Limitata"
  },
  Task_146542_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_146543_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_146544_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_146545_Desc = {
    Text = "Azzera il Capitolo 6-8 del Regno Astrale"
  },
  Task_146546_Desc = {
    Text = "Azzera il Capitolo 6 del Regno Astrale \"Quando la Montagna Banchetta\": Difficile"
  },
  Task_146547_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_146548_Desc = {
    Text = "Azzera il Capitolo 6 del Regno Astrale \"Quando la Montagna Banchetta\": Difficile"
  },
  Task_146549_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_146550_Desc = {
    Text = "Azzera il Capitolo 6-8 del Regno Astrale"
  },
  Task_146552_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_146553_Desc = {
    Text = "Azzera il Capitolo 6 del Regno Astrale \"Quando la Montagna Banchetta\""
  },
  Task_146554_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_146555_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_146556_Desc = {
    Text = "Azzera il Capitolo 6 6-5 del Regno Astrale in difficoltà Difficile"
  },
  Task_146557_Desc = {
    Text = "Azzera il Capitolo 6 6-5 del Regno Astrale in difficoltà Difficile"
  },
  Task_146558_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_146559_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_146560_Desc = {
    Text = "Azzera il Capitolo 6 del Regno Astrale \"Quando la Montagna Banchetta\""
  },
  Task_146801_Desc = {
    Text = "Usa un Risvegliatore del Mare Profondo e vinci una volta in \"Testo Temporaneo\""
  },
  Task_146802_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_146803_Desc = {
    Text = "Completa \"Testo Temporaneo\" a difficoltà Follia"
  },
  Task_146804_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_146805_Desc = {
    Text = "Usa un qualsiasi Risvegliatore Caro e vinci due volte in \"Testo Temporaneo\""
  },
  Task_146806_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_146807_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_146808_Desc = {
    Text = "Azzera L'errante \"Cinque giorni di racconti\""
  },
  Task_146809_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_146810_Desc = {
    Text = "Usa un Risvegliatore del Mare Profondo e vinci due volte in \"Testo Temporaneo\""
  },
  Task_146811_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_146812_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_146813_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_146814_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_146815_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos e vinci una volta in \"Testo Temporaneo\""
  },
  Task_146816_Desc = {
    Text = "Usa un qualsiasi Risvegliatore Ultra e vinci una volta in \"Testo Temporaneo\""
  },
  Task_146817_Desc = {
    Text = "Testo Temporaneo · Completamento"
  },
  Task_146818_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_146819_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_146820_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_146821_Desc = {
    Text = "Completa \"Testo Temporaneo\" a difficoltà Follia"
  },
  Task_146822_Desc = {
    Text = "Completa \"Testo Temporaneo\" a difficoltà Follia"
  },
  Task_146823_Desc = {
    Text = "Testo Temporaneo · Reame"
  },
  Task_146824_Desc = {
    Text = "Completa \"Testo Temporaneo\" a difficoltà Follia"
  },
  Task_146825_Desc = {
    Text = "Completa \"Testo Temporaneo\" a difficoltà Follia"
  },
  Task_146826_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_146827_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_146828_Desc = {
    Text = "Completa \"Testo Temporaneo\" a difficoltà Follia"
  },
  Task_146829_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos e vinci due volte in \"Testo Temporaneo\""
  },
  Task_146830_Desc = {
    Text = "Completa \"Testo Temporaneo\" a difficoltà Follia"
  },
  Task_146831_Desc = {
    Text = "Usa un qualsiasi Risvegliatore Ultra e vinci due volte in \"Testo Temporaneo\""
  },
  Task_146832_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_146833_Desc = {
    Text = "Usa un qualsiasi Risvegliatore Caro e vinci una volta in \"Testo Temporaneo\""
  },
  Task_146834_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_146835_Desc = {
    Text = "Testo Temporaneo·Follia"
  },
  Task_146836_Desc = {
    Text = "Completa tutti gli obiettivi di \"Testo Temporaneo · Completamento\""
  },
  Task_146837_Desc = {
    Text = "Completa \"Testo Temporaneo\" a difficoltà Follia"
  },
  Task_146838_Desc = {
    Text = "Completa \"Testo Temporaneo\" a difficoltà Follia"
  },
  Task_146839_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_146840_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_147442_Desc = {
    Text = "Usa un qualsiasi Risvegliatore Caro e vinci due volte in \"Testo Temporaneo\""
  },
  Task_147443_Desc = {
    Text = "L'Affinità di Tinct: Vespera raggiunge il Livello 10"
  },
  Task_147444_Desc = {
    Text = "Usa un Risvegliatore del Mare Profondo e vinci una volta in \"Testo Temporaneo\""
  },
  Task_147450_Desc = {
    Text = "Supera L'errante \"Testo Temporaneo\""
  },
  Task_147451_Desc = {
    Text = "Usa un qualsiasi Risvegliatore Ultra e vinci una volta in \"Testo Temporaneo\""
  },
  Task_147452_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos e vinci una volta in \"Testo Temporaneo\""
  },
  Task_147453_Desc = {
    Text = "Usa un Risvegliatore del Mare Profondo e vinci due volte in \"Testo Temporaneo\""
  },
  Task_147454_Desc = {
    Text = "Usa un qualsiasi Risvegliatore Caro e vinci una volta in \"Testo Temporaneo\""
  },
  Task_147456_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_147458_Desc = {
    Text = "Illuminare 2 all'ottenimento di Tinct: Vespera"
  },
  Task_147458_Name = {
    Text = "Illuminare 2 all'ottenimento di Tinct: Vespera"
  },
  Task_147458_UnlockCondDesc = {
    Text = "Attività@Pacchetto Illuminare 2 per il Risvegliatore Tinct: Vespera Attività"
  },
  Task_147461_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_147464_Desc = {
    Text = "Completa il vagabondaggio \"Testo Temporaneo\""
  },
  Task_147464_Name = {
    Text = "Statistica principale scelta casualmente tra Tasso Crit., Danno Crit., Livello di Ricarica della Chiave d'Argento o Livello Ricarica Aliemus."
  },
  Task_147465_Desc = {
    Text = "Illuminare 6 all'ottenimento di Tinct: Vespera"
  },
  Task_147465_Name = {
    Text = "Illuminare 6 all'ottenimento di Tinct: Vespera"
  },
  Task_147465_UnlockCondDesc = {
    Text = "Attività@Pacchetto Illuminare 2 per il Risvegliatore Tinct: Vespera Attività"
  },
  Task_147471_Desc = {
    Text = "Tinct: Vespera raggiunge Approfondire Personalità 12"
  },
  Task_147472_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_147474_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos e vinci due volte in \"Testo Temporaneo\""
  },
  Task_147475_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_147476_Desc = {
    Text = "Completa tutti gli obiettivi di \"Testo Temporaneo · Completamento\""
  },
  Task_147478_Desc = {
    Text = "Completa L'errante \"Testo Temporaneo\" in difficoltà Difficile"
  },
  Task_147478_Name = {
    Text = "Testo Temporaneo·Difficile"
  },
  Task_147483_Desc = {
    Text = "Usa un qualsiasi Risvegliatore Ultra e vinci due volte in \"Testo Temporaneo\""
  },
  Task_147552_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_147553_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_147554_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_147555_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_147556_Desc = {
    Text = "Completa \"Testo Temporaneo\" a difficoltà Follia"
  },
  Task_147557_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_147558_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_147559_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_147560_Desc = {
    Text = "Completa \"Testo Temporaneo\" a difficoltà Follia"
  },
  Task_147561_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_147562_Desc = {
    Text = "Completa \"Testo Temporaneo\" a difficoltà Follia"
  },
  Task_147563_Desc = {
    Text = "Testo Temporaneo·Follia"
  },
  Task_147564_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_147565_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_147566_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_147567_Desc = {
    Text = "Completa \"Testo Temporaneo\" a difficoltà Follia"
  },
  Task_147568_Desc = {
    Text = "Completa \"Testo Temporaneo\" a difficoltà Follia"
  },
  Task_147569_Desc = {
    Text = "Testo Temporaneo · Reame"
  },
  Task_147570_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_147571_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_147572_Desc = {
    Text = "Completa \"Testo Temporaneo\" a difficoltà Follia"
  },
  Task_147573_Desc = {
    Text = "Completa \"Testo Temporaneo\" a difficoltà Follia"
  },
  Task_147574_Desc = {
    Text = "Testo Temporaneo · Completamento"
  },
  Task_147575_Desc = {
    Text = "Completa \"Testo Temporaneo\" a qualsiasi difficoltà"
  },
  Task_147676_Desc = {
    Text = "Il Livello del giocatore raggiunge il Livello 2"
  },
  Task_147676_Name = {
    Text = "(Da confezionare)"
  },
  Task_147677_Desc = {
    Text = "Possiedi 1 Risvegliatore di Livello 10"
  },
  Task_147677_Name = {
    Text = "(Da confezionare)"
  },
  Task_147678_Desc = {
    Text = "Completa l'Evento d'Indagine \"Giorno d'iscrizione\""
  },
  Task_147678_Name = {
    Text = "(Da confezionare)"
  },
  Task_147679_Desc = {
    Text = "Possiedi 5 Risvegliatori"
  },
  Task_147679_Name = {
    Text = "(Da confezionare)"
  },
  Task_147894_Desc = {
    Text = "Statistica principale scelta casualmente tra Tasso Crit., Danno Crit., Livello di Ricarica della Chiave d'Argento o Livello Ricarica Aliemus."
  },
  Task_147894_Name = {Text = "Bersaglio"},
  Task_147895_Desc = {
    Text = "Completa la Storia Principale \"Quando la Montagna Banchetta\" in Modalità Difficile"
  },
  Task_147895_Name = {
    Text = "Riposo a 8.840 Metri: Difficile"
  },
  Task_147896_Desc = {
    Text = "Statistica principale scelta casualmente tra Tasso Crit., Danno Crit., Livello di Ricarica della Chiave d'Argento o Livello Ricarica Aliemus."
  },
  Task_147896_Name = {Text = "Bersaglio"},
  Task_147897_Desc = {
    Text = "Statistica principale scelta casualmente tra Tasso Crit., Danno Crit., Livello di Ricarica della Chiave d'Argento o Livello Ricarica Aliemus."
  },
  Task_147897_Name = {Text = "Bersaglio"},
  Task_147898_Desc = {
    Text = "Statistica principale scelta casualmente tra Tasso Crit., Danno Crit., Livello di Ricarica della Chiave d'Argento o Livello Ricarica Aliemus."
  },
  Task_147898_Name = {Text = "Bersaglio"},
  Task_147899_Desc = {
    Text = "Statistica principale scelta casualmente tra Tasso Crit., Danno Crit., Livello di Ricarica della Chiave d'Argento o Livello Ricarica Aliemus."
  },
  Task_147899_Name = {Text = "Bersaglio"},
  Task_147900_Desc = {
    Text = "Statistica principale scelta casualmente tra Tasso Crit., Danno Crit., Livello di Ricarica della Chiave d'Argento o Livello Ricarica Aliemus."
  },
  Task_147900_Name = {Text = "Bersaglio"},
  Task_147901_Desc = {
    Text = "Statistica principale scelta casualmente tra Tasso Crit., Danno Crit., Livello di Ricarica della Chiave d'Argento o Livello Ricarica Aliemus."
  },
  Task_147901_Name = {Text = "Bersaglio"},
  Task_147902_Desc = {
    Text = "Risuona 9 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_147902_Desc2 = {
    Text = "Risuona 9 volte nella Storia Principale \"Quando la Montagna Banchetta\""
  },
  Task_147902_Name2 = {
    Text = "Rito Settuplice degli Ingenui IV"
  },
  Task_147903_Desc = {
    Text = "Statistica principale scelta casualmente tra Tasso Crit., Danno Crit., Livello di Ricarica della Chiave d'Argento o Livello Ricarica Aliemus."
  },
  Task_147903_Name = {Text = "Bersaglio"},
  Task_147904_Desc = {
    Text = "Statistica principale scelta casualmente tra Tasso Crit., Danno Crit., Livello di Ricarica della Chiave d'Argento o Livello Ricarica Aliemus."
  },
  Task_147904_Name = {Text = "Bersaglio"},
  Task_147905_Desc = {
    Text = "Risuona 3 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_147905_Desc2 = {
    Text = "Risuona 3 volte nella Storia Principale \"Quando la Montagna Banchetta\""
  },
  Task_147905_Name2 = {
    Text = "Rito Settuplice degli Ingenui"
  },
  Task_147906_Desc = {
    Text = "Risuona 7 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_147906_Desc2 = {
    Text = "Risuona 9 volte nella Storia Principale \"Quando la Montagna Banchetta\""
  },
  Task_147906_Name2 = {
    Text = "Rito Settuplice degli Ingenui III"
  },
  Task_147907_Desc = {
    Text = "Risuona 5 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_147907_Desc2 = {
    Text = "Risuona 6 volte nella Storia Principale \"Quando la Montagna Banchetta\""
  },
  Task_147907_Name2 = {
    Text = "Rito Settuplice degli Ingenui II"
  },
  Task_147908_Desc = {
    Text = "Completa l'evento d'indagine \"@1@2\""
  },
  Task_147908_Desc2 = {
    Text = "Completa la Storia Principale \"Quando la Montagna Banchetta\""
  },
  Task_147908_Name2 = {
    Text = "Riposo a 8.840 Metri"
  },
  Task_147909_Desc = {
    Text = "Statistica principale scelta casualmente tra Tasso Crit., Danno Crit., Livello di Ricarica della Chiave d'Argento o Livello Ricarica Aliemus."
  },
  Task_147909_Name = {Text = "Bersaglio"},
  Task_147910_Desc = {
    Text = "Statistica principale scelta casualmente tra Tasso Crit., Danno Crit., Livello di Ricarica della Chiave d'Argento o Livello Ricarica Aliemus."
  },
  Task_147910_Name = {Text = "Bersaglio"},
  Task_148121_Desc = {
    Text = "Completa 15 Incarichi"
  },
  Task_148122_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_148123_Desc = {
    Text = "Accesso × 1 giorno"
  },
  Task_148124_Desc = {
    Text = "Risveglio 30 volte"
  },
  Task_148125_Desc = {
    Text = "Accesso × 1 giorno"
  },
  Task_148126_Desc = {
    Text = "Completa una qualsiasi Missione stagionale"
  },
  Task_148127_Desc = {
    Text = "Completa una qualsiasi Missione stagionale"
  },
  Task_148128_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_148129_Desc = {
    Text = "Risveglio 30 volte"
  },
  Task_148130_Desc = {
    Text = "Completa 15 Incarichi"
  },
  Task_148131_Desc = {
    Text = "Usa Supporto 3 volte"
  },
  Task_148132_Desc = {
    Text = "Gli Ioni attivi raffinati raggiungono 1000"
  },
  Task_148133_Desc = {
    Text = "Usa Supporto 3 volte"
  },
  Task_148134_Desc = {
    Text = "Gioca un totale di 300 carte"
  },
  Task_148135_Desc = {
    Text = "Gli Ioni attivi raffinati raggiungono 1000"
  },
  Task_148136_Desc = {
    Text = "Gioca un totale di 300 carte"
  },
  Task_148489_Desc = {
    Text = "Completa L'errante \"Cinque giorni di racconti\""
  },
  Task_148489_Name = {
    Text = "Il trionfo di chi ha perso la patria"
  },
  Task_148490_Desc = {
    Text = "Completa L'errante \"Cinque giorni di racconti\" in modalità Difficile"
  },
  Task_148490_Name = {
    Text = "Il trionfo di chi ha perso la patria·Difficile"
  },
  Task_149335_Desc = {
    Text = "Uccidi il drago"
  },
  Task_149335_Name = {Text = "Bersaglio"},
  Task_149989_Desc = {
    Text = "Azzera Regno Astrale 6-1"
  },
  Task_149990_Desc = {
    Text = "Raggiungi Approfondire della personalità 12 con Genesi Ogier"
  },
  Task_19734_Desc = {
    Text = "Completamento Fessura del Viaggio Ultra VI"
  },
  Task_19735_Desc = {
    Text = "Supera Palude di Caro: Fessura VIII"
  },
  Task_19736_Desc = {
    Text = "Supera Viaggio Ultra: Fessura IV"
  },
  Task_19737_Desc = {
    Text = "Supera Palude di Caro: Fessura II"
  },
  Task_19738_Desc = {
    Text = "Supera Viaggio Ultra: Fessura II"
  },
  Task_19739_Desc = {
    Text = "Completamento Palude di Caro: Intervallo VI"
  },
  Task_19740_Desc = {
    Text = "Prepara le trappole ed esegui la \"Caccia\""
  },
  Task_19740_Name = {Text = "Bersaglio"},
  Task_19741_Desc = {
    Text = "Completamento Viaggio Ultra: Fessura VIII"
  },
  Task_19742_Desc = {
    Text = "Completamento Eredità di Aequor: Intervallo II"
  },
  Task_19743_Desc = {
    Text = "Supera Dominio del Caos: Fessura II"
  },
  Task_19744_Desc = {
    Text = "Completamento Eredità di Aequor: Intervallo VI"
  },
  Task_19745_Desc = {
    Text = "Supera Dominio del Caos: Fessura IV"
  },
  Task_19746_Desc = {
    Text = "Completamento Eredità di Aequor: Intervallo IV"
  },
  Task_19747_Desc = {
    Text = "Supera Dominio del Caos: Fessura VI"
  },
  Task_19748_Desc = {
    Text = "Supera Dominio del Caos: Fessura VIII"
  },
  Task_19749_Desc = {
    Text = "Completamento Eredità di Aequor: Intervallo VIII"
  },
  Task_19750_Desc = {
    Text = "Prepara le trappole ed esegui la \"Caccia\""
  },
  Task_19750_Name = {Text = "Bersaglio"},
  Task_19751_Desc = {
    Text = "Assisti Lotan nell'inseguimento dei nemici"
  },
  Task_19751_Name = {Text = "Bersaglio"},
  Task_19752_Desc = {
    Text = "Completamento Palude di Caro: Intervallo IV"
  },
  Task_20972_Desc = {
    Text = "Completamento Fessura Ultra I"
  },
  Task_20973_Desc = {
    Text = "Completamento Fessura di Aequor I"
  },
  Task_20990_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_20990_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_20991_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_20991_Name = {
    Text = "Superamento Perfetto"
  },
  Task_20992_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_20992_Name = {
    Text = "Superamento Perfetto"
  },
  Task_20993_Desc = {
    Text = "Nella Battaglia finale, attiva l'Esaltazione almeno 4 volte in un turno."
  },
  Task_20993_Name = {
    Text = "Magia letale"
  },
  Task_20994_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_20994_Name = {
    Text = "Superamento Perfetto"
  },
  Task_20995_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_20995_Name = {
    Text = "Superamento Perfetto"
  },
  Task_20996_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_20996_Name = {
    Text = "Elegante e Preciso"
  },
  Task_20997_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_20997_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_20998_Desc = {
    Text = "Pesca almeno 5 Carte aggiuntive in un turno durante la Battaglia finale."
  },
  Task_20998_Name = {Text = "Pesca!"},
  Task_20999_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_20999_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21000_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21000_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21001_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21001_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21002_Desc = {
    Text = "Risveglia tutti i Risvegliatori al completamento"
  },
  Task_21002_Name = {
    Text = "Abbraccio Infinito"
  },
  Task_21003_Desc = {
    Text = "Ottenere almeno 4 tipi diversi di Orazioni"
  },
  Task_21003_Name = {
    Text = "Marchio dell'Anima"
  },
  Task_21004_Desc = {
    Text = "Infliggere almeno 240 punti di Danno in un turno durante una battaglia élite."
  },
  Task_21004_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_21005_Desc = {
    Text = "Nessun recupero vita dalla Giunzione al completamento"
  },
  Task_21005_Name = {
    Text = "Il Senza Fiamma"
  },
  Task_21006_Desc = {
    Text = "Non avere più di 3 Carte sintomo al completamento"
  },
  Task_21006_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21007_Desc = {
    Text = "Portare almeno 1 Reliquia maledetta al completamento."
  },
  Task_21007_Name = {
    Text = "Scorta segreta"
  },
  Task_21008_Desc = {
    Text = "Non avere più di 1 Carta sintomo al completamento"
  },
  Task_21008_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21009_Desc = {
    Text = "Giocare almeno 4 Carte in un turno durante la Battaglia finale"
  },
  Task_21009_Name = {
    Text = "Tocca a me!"
  },
  Task_21010_Desc = {
    Text = "Il progresso dell'esplorazione raggiunge il 100%"
  },
  Task_21010_Name = {
    Text = "Contemplare il Regno di Nebbia"
  },
  Task_21011_Desc = {
    Text = "Portare almeno 5 Reliquie al completamento"
  },
  Task_21011_Name = {
    Text = "Scorta segreta"
  },
  Task_21012_Desc = {
    Text = "Portare almeno 5 Reliquie al completamento"
  },
  Task_21012_Name = {
    Text = "Scorta segreta"
  },
  Task_21013_Desc = {
    Text = "Portare almeno 5 Reliquie al completamento"
  },
  Task_21013_Name = {
    Text = "Scorta segreta"
  },
  Task_21014_Desc = {
    Text = "In un turno della Battaglia finale, accumulare uno Scudo del Personaggio pari ad almeno il 50% della Salute massima."
  },
  Task_21014_Name = {
    Text = "Corpo d'Acciaio"
  },
  Task_21015_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21015_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21016_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_21016_Name = {
    Text = "Elegante e Preciso"
  },
  Task_21017_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21017_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21018_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_21018_Name = {
    Text = "Elegante e Preciso"
  },
  Task_21019_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_21019_Name = {
    Text = "Elegante e Preciso"
  },
  Task_21020_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21020_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21021_Desc = {
    Text = "Vinci la Battaglia finale entro 15 turni"
  },
  Task_21021_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21022_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21022_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21023_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_21023_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21024_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21024_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21025_Desc = {
    Text = "Nella Battaglia finale, attiva l'Esaltazione almeno 4 volte in un turno."
  },
  Task_21025_Name = {
    Text = "Magia letale"
  },
  Task_21026_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21026_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21027_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21027_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21028_Desc = {
    Text = "Vinci la Battaglia finale entro 15 turni"
  },
  Task_21028_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21029_Desc = {
    Text = "Gioca almeno 6 Carte in un turno durante la Battaglia finale."
  },
  Task_21029_Name = {
    Text = "Tocca a me!"
  },
  Task_21030_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21030_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21032_Desc = {
    Text = "Infliggi almeno 40000 punti di Danno in un turno durante la Battaglia finale."
  },
  Task_21032_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_21033_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21033_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21034_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21034_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21035_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_21035_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21036_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21036_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21037_Desc = {
    Text = "Non avere più di 1 Carta sintomo al completamento"
  },
  Task_21037_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21038_Desc = {
    Text = "Giocare almeno 4 Carte in un turno durante la Battaglia finale"
  },
  Task_21038_Name = {
    Text = "Tocca a me!"
  },
  Task_21039_Desc = {
    Text = "Il progresso dell'esplorazione raggiunge il 100%"
  },
  Task_21039_Name = {
    Text = "Contemplare il Regno di Nebbia"
  },
  Task_21040_Desc = {
    Text = "Portare almeno 5 Reliquie al completamento"
  },
  Task_21040_Name = {
    Text = "Scorta segreta"
  },
  Task_21041_Desc = {
    Text = "Portare almeno 5 Reliquie al completamento"
  },
  Task_21041_Name = {
    Text = "Scorta segreta"
  },
  Task_21042_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_21042_Name = {
    Text = "Elegante e Preciso"
  },
  Task_21043_Desc = {
    Text = "In un turno della Battaglia finale, accumulare uno Scudo del Personaggio pari ad almeno il 50% della Salute massima."
  },
  Task_21043_Name = {
    Text = "Corpo d'Acciaio"
  },
  Task_21044_Desc = {
    Text = "Ottenere almeno 4 tipi diversi di Orazioni"
  },
  Task_21044_Name = {
    Text = "Marchio dell'Anima"
  },
  Task_21045_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_21045_Name = {
    Text = "Elegante e Preciso"
  },
  Task_21046_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21046_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21047_Desc = {
    Text = "Nella Battaglia finale, attiva l'Esaltazione almeno 4 volte in un turno."
  },
  Task_21047_Name = {
    Text = "Magia letale"
  },
  Task_21048_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21048_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21049_Desc = {
    Text = "Non avere più di 1 Carta sintomo al completamento"
  },
  Task_21049_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21050_Desc = {
    Text = "Risveglia tutti i Risvegliatori al completamento"
  },
  Task_21050_Name = {
    Text = "Abbraccio Infinito"
  },
  Task_21051_Desc = {
    Text = "Possiedi almeno 2 Reliquie al completamento"
  },
  Task_21051_Name = {
    Text = "Scorta segreta"
  },
  Task_21052_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21052_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21053_Desc = {
    Text = "Ottenere almeno 4 tipi diversi di Orazioni"
  },
  Task_21053_Name = {
    Text = "Marchio dell'Anima"
  },
  Task_21054_Desc = {
    Text = "Ottenere almeno 4 tipi diversi di Orazioni"
  },
  Task_21054_Name = {
    Text = "Marchio dell'Anima"
  },
  Task_21055_Desc = {
    Text = "Infliggi almeno 980 punti di Danno in un singolo turno durante una battaglia Élite."
  },
  Task_21055_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_21056_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_21056_Name = {
    Text = "Elegante e Preciso"
  },
  Task_21057_Desc = {
    Text = "Non avere più di 3 Carte sintomo al completamento"
  },
  Task_21057_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21058_Desc = {
    Text = "Portare almeno 1 Reliquia maledetta al completamento."
  },
  Task_21058_Name = {
    Text = "Scorta segreta"
  },
  Task_21059_Desc = {
    Text = "Il progresso dell'esplorazione raggiunge il 100%"
  },
  Task_21059_Name = {
    Text = "Contemplare il Regno di Nebbia"
  },
  Task_21060_Desc = {
    Text = "Usare Esaltazione almeno 3 volte in un singolo turno durante una battaglia élite."
  },
  Task_21060_Name = {
    Text = "Magia letale"
  },
  Task_21061_Desc = {
    Text = "Pesca almeno 5 Carte aggiuntive in un turno durante la Battaglia finale."
  },
  Task_21061_Name = {Text = "Pesca!"},
  Task_21062_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_21062_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21063_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21063_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21064_Desc = {
    Text = "Possiedi almeno 2 Reliquie al completamento"
  },
  Task_21064_Name = {
    Text = "Scorta segreta"
  },
  Task_21065_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_21065_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21066_Desc = {
    Text = "Ottieni almeno 3 tipi di Orazione"
  },
  Task_21066_Name = {
    Text = "Marchio dell'Anima"
  },
  Task_21067_Desc = {
    Text = "Risvegliare almeno 2 Risvegliatori al completamento"
  },
  Task_21067_Name = {
    Text = "Abbraccio Infinito"
  },
  Task_21068_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_21068_Name = {
    Text = "Elegante e Preciso"
  },
  Task_21069_Desc = {
    Text = "Portare almeno 1 Reliquia maledetta al completamento."
  },
  Task_21069_Name = {
    Text = "Scorta segreta"
  },
  Task_21070_Desc = {
    Text = "Giocare almeno 4 Carte in un turno durante la Battaglia finale"
  },
  Task_21070_Name = {
    Text = "Tocca a me!"
  },
  Task_21071_Desc = {
    Text = "Nella Battaglia finale, attiva l'Esaltazione almeno 3 volte in un turno."
  },
  Task_21071_Name = {
    Text = "Magia letale"
  },
  Task_21072_Desc = {
    Text = "Non avere più di 3 Carte sintomo al completamento"
  },
  Task_21072_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21073_Desc = {
    Text = "Non avere più di 1 Carta sintomo al completamento"
  },
  Task_21073_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21074_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21074_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21075_Desc = {
    Text = "Possedere 4 tipi diversi di Orazione"
  },
  Task_21075_Name = {
    Text = "Marchio dell'Anima"
  },
  Task_21076_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21076_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21077_Desc = {
    Text = "Gioca almeno 5 Carte in un turno durante la Battaglia finale."
  },
  Task_21077_Name = {
    Text = "Tocca a me!"
  },
  Task_21078_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21078_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21079_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21079_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21080_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21080_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21081_Desc = {
    Text = "Infliggi 350 punti di Danno in un turno durante la Battaglia finale."
  },
  Task_21081_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_21082_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21082_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21083_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21083_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21084_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21084_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21085_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21085_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21086_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_21086_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21087_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21087_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21088_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21088_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21089_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21089_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21090_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21090_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21091_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21091_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21092_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21092_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21093_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21093_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21094_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21094_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21095_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_21095_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21096_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_21096_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21097_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_21097_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21098_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_21098_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21099_Desc = {
    Text = "Portare almeno 1 Reliquia maledetta al completamento."
  },
  Task_21099_Name = {
    Text = "Scorta segreta"
  },
  Task_21100_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_21100_Name = {
    Text = "Elegante e Preciso"
  },
  Task_21101_Desc = {
    Text = "Sconfiggere almeno 2 mostri in un round di una qualsiasi battaglia"
  },
  Task_21101_Name = {
    Text = "Sradicare e Recidere"
  },
  Task_21102_Desc = {
    Text = "Portare almeno 8 Reliquie al completamento."
  },
  Task_21102_Name = {
    Text = "Scorta segreta"
  },
  Task_21103_Desc = {
    Text = "Non avere più di 1 Carta sintomo al completamento"
  },
  Task_21103_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21104_Desc = {
    Text = "Gioca almeno 5 Carte in un turno durante la Battaglia finale."
  },
  Task_21104_Name = {
    Text = "Tocca a me!"
  },
  Task_21105_Desc = {
    Text = "Infliggi almeno 300 punti di Danno in un turno durante la Battaglia finale."
  },
  Task_21105_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_21106_Desc = {
    Text = "Pescare almeno 3 carte aggiuntive in un turno durante la Battaglia finale"
  },
  Task_21106_Name = {Text = "Pesca!"},
  Task_21107_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21107_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21108_Desc = {
    Text = "Infliggi almeno 96000 punti di Danno in un singolo turno durante la Battaglia finale."
  },
  Task_21108_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_21110_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_21110_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21111_Desc = {
    Text = "Non avere più di 1 Carta sintomo al completamento"
  },
  Task_21111_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21112_Desc = {
    Text = "Sconfiggere almeno 2 mostri in un round di una qualsiasi battaglia"
  },
  Task_21112_Name = {
    Text = "Sradicare e Recidere"
  },
  Task_21113_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21113_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21114_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21114_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21115_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_21115_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21116_Desc = {
    Text = "Supera con Vita non inferiore all'80%"
  },
  Task_21116_Name = {
    Text = "Elegante e Preciso"
  },
  Task_21117_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21117_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21118_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_21118_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21119_Desc = {
    Text = "Non avere più di 1 Carta sintomo al completamento"
  },
  Task_21119_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21120_Desc = {
    Text = "Sconfiggere almeno 2 mostri in un round di una qualsiasi battaglia"
  },
  Task_21120_Name = {
    Text = "Sradicare e Recidere"
  },
  Task_21121_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_21121_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21122_Desc = {
    Text = "Infliggi almeno 1600 punti di Danno in un singolo turno durante una battaglia Élite."
  },
  Task_21122_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_21123_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21123_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21124_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21124_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21125_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21125_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21126_Desc = {
    Text = "Usare Esaltazione almeno 3 volte in un singolo turno durante una battaglia élite."
  },
  Task_21126_Name = {
    Text = "Magia letale"
  },
  Task_21127_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_21127_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21128_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21128_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21129_Desc = {
    Text = "Non avere più di 1 Carta sintomo al completamento"
  },
  Task_21129_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21130_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21130_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21131_Desc = {
    Text = "Risveglia tutti i Risvegliatori al completamento"
  },
  Task_21131_Name = {
    Text = "Abbraccio Infinito"
  },
  Task_21132_Desc = {
    Text = "Infliggi almeno 6000 punti di Danno in un singolo turno durante la Battaglia finale."
  },
  Task_21132_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_21133_Desc = {
    Text = "Pesca almeno 5 Carte aggiuntive in un turno durante la Battaglia finale."
  },
  Task_21133_Name = {Text = "Pesca!"},
  Task_21134_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21134_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21135_Desc = {
    Text = "Pescare almeno 4 carte aggiuntive in un turno durante la Battaglia finale"
  },
  Task_21135_Name = {Text = "Pesca!"},
  Task_21136_Desc = {
    Text = "Vinci la Battaglia finale entro 15 turni"
  },
  Task_21136_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21137_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_21137_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21138_Desc = {
    Text = "Infliggi almeno 1800 punti di Danno in un turno durante una battaglia Élite."
  },
  Task_21138_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_21139_Desc = {
    Text = "Portare almeno 1 Reliquia maledetta al completamento."
  },
  Task_21139_Name = {
    Text = "Scorta segreta"
  },
  Task_21140_Desc = {
    Text = "Gioca almeno 5 Carte in un turno durante la Battaglia finale."
  },
  Task_21140_Name = {
    Text = "Tocca a me!"
  },
  Task_21141_Desc = {
    Text = "In un turno della Battaglia finale, accumula uno Scudo del Personaggio pari ad almeno il 65% della Salute massima."
  },
  Task_21141_Name = {
    Text = "Corpo d'Acciaio"
  },
  Task_21142_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_21142_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21143_Desc = {
    Text = "Ottenere almeno 4 tipi diversi di Orazioni"
  },
  Task_21143_Name = {
    Text = "Marchio dell'Anima"
  },
  Task_21144_Desc = {
    Text = "Possiedi almeno 2 Reliquie al completamento"
  },
  Task_21144_Name = {
    Text = "Scorta segreta"
  },
  Task_21145_Desc = {
    Text = "Usare la Giunzione per il recupero vita non più di 1 volta."
  },
  Task_21145_Name = {
    Text = "Il Senza Fiamma"
  },
  Task_21146_Desc = {
    Text = "Portare almeno 1 Reliquia maledetta al completamento."
  },
  Task_21146_Name = {
    Text = "Scorta segreta"
  },
  Task_21147_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_21147_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21148_Desc = {
    Text = "Infliggi almeno 500 punti di Danno in un turno durante una battaglia Élite."
  },
  Task_21148_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_21149_Desc = {
    Text = "Sconfiggere almeno 2 mostri in un round di una qualsiasi battaglia"
  },
  Task_21149_Name = {
    Text = "Sradicare e Recidere"
  },
  Task_21150_Desc = {
    Text = "Risvegliare almeno 3 Risvegliatori"
  },
  Task_21150_Name = {
    Text = "Abbraccio Infinito"
  },
  Task_21151_Desc = {
    Text = "Ottenere almeno 4 tipi diversi di Orazioni"
  },
  Task_21151_Name = {
    Text = "Marchio dell'Anima"
  },
  Task_21152_Desc = {
    Text = "Il progresso dell'esplorazione raggiunge il 100%"
  },
  Task_21152_Name = {
    Text = "Contemplare il Regno di Nebbia"
  },
  Task_21153_Desc = {
    Text = "Nella Battaglia finale, attiva l'Esaltazione almeno 4 volte in un turno."
  },
  Task_21153_Name = {
    Text = "Magia letale"
  },
  Task_21154_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_21154_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21155_Desc = {
    Text = "In un turno della Battaglia finale, accumula uno Scudo del Personaggio pari ad almeno il 60% della Salute massima."
  },
  Task_21155_Name = {
    Text = "Corpo d'Acciaio"
  },
  Task_21156_Desc = {
    Text = "Portare almeno 8 Reliquie al completamento."
  },
  Task_21156_Name = {
    Text = "Scorta segreta"
  },
  Task_21157_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_21157_Name = {
    Text = "Elegante e Preciso"
  },
  Task_21158_Desc = {
    Text = "Pescare almeno 4 carte aggiuntive in un turno durante la Battaglia finale"
  },
  Task_21158_Name = {Text = "Pesca!"},
  Task_21159_Desc = {
    Text = "Infliggi almeno 5200 punti di Danno in un singolo turno durante la Battaglia finale."
  },
  Task_21159_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_21160_Desc = {
    Text = "Pescare almeno 3 carte aggiuntive in un turno durante la Battaglia finale"
  },
  Task_21160_Name = {Text = "Pesca!"},
  Task_21161_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21161_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21162_Desc = {
    Text = "In un turno della Battaglia finale, accumula uno Scudo del Personaggio pari ad almeno il 65% della Salute massima."
  },
  Task_21162_Name = {
    Text = "Corpo d'Acciaio"
  },
  Task_21163_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_21163_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21164_Desc = {
    Text = "Portare almeno 1 Reliquia maledetta al completamento."
  },
  Task_21164_Name = {
    Text = "Scorta segreta"
  },
  Task_21165_Desc = {
    Text = "Giocare almeno 4 Carte in un turno durante la Battaglia finale"
  },
  Task_21165_Name = {
    Text = "Tocca a me!"
  },
  Task_21166_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21166_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21167_Desc = {
    Text = "Possedere 4 tipi diversi di Orazione"
  },
  Task_21167_Name = {
    Text = "Marchio dell'Anima"
  },
  Task_21168_Desc = {
    Text = "Infliggere 120 punti di Danno in un turno durante la Battaglia finale"
  },
  Task_21168_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_21169_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_21169_Name = {
    Text = "Elegante e Preciso"
  },
  Task_21170_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_21170_Name = {
    Text = "Elegante e Preciso"
  },
  Task_21171_Desc = {
    Text = "Sconfiggere almeno 2 mostri in un round di una qualsiasi battaglia"
  },
  Task_21171_Name = {
    Text = "Sradicare e Recidere"
  },
  Task_21172_Desc = {
    Text = "Pescare almeno 3 carte aggiuntive in un turno durante la Battaglia finale"
  },
  Task_21172_Name = {Text = "Pesca!"},
  Task_21173_Desc = {
    Text = "Risvegliare almeno 3 Risvegliatori"
  },
  Task_21173_Name = {
    Text = "Abbraccio Infinito"
  },
  Task_21174_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_21174_Name = {
    Text = "Elegante e Preciso"
  },
  Task_21176_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21176_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21177_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21177_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21178_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_21178_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21179_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21179_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21180_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21180_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21181_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21181_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21182_Desc = {
    Text = "Non avere più di 1 Carta sintomo al completamento"
  },
  Task_21182_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21183_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_21183_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21184_Desc = {
    Text = "Il progresso dell'esplorazione raggiunge il 100%"
  },
  Task_21184_Name = {
    Text = "Contemplare il Regno di Nebbia"
  },
  Task_21185_Desc = {
    Text = "Infliggi almeno 1000 punti di Danno in un turno durante la Battaglia finale."
  },
  Task_21185_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_21186_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21186_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21187_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_21187_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21188_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_21188_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21189_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21189_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21190_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21190_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21191_Desc = {
    Text = "Non avere più di 1 Carta sintomo al completamento"
  },
  Task_21191_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21192_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_21192_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21193_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_21193_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21194_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_21194_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21195_Desc = {
    Text = "Infliggi almeno 7300 punti di Danno in un singolo turno durante la Battaglia finale."
  },
  Task_21195_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_21196_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_21196_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21197_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_21197_Name = {
    Text = "Elegante e Preciso"
  },
  Task_21198_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21198_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21199_Desc = {
    Text = "Giocare almeno 4 Carte in un turno durante la Battaglia finale"
  },
  Task_21199_Name = {
    Text = "Tocca a me!"
  },
  Task_21200_Desc = {
    Text = "Non avere più di 3 Carte sintomo al completamento"
  },
  Task_21200_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21201_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21201_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21202_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21202_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21203_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21203_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21204_Desc = {
    Text = "Possiedi almeno 2 Reliquie al completamento"
  },
  Task_21204_Name = {
    Text = "Scorta segreta"
  },
  Task_21205_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_21205_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21206_Desc = {
    Text = "Ottieni almeno 3 tipi di Orazione"
  },
  Task_21206_Name = {
    Text = "Marchio dell'Anima"
  },
  Task_21207_Desc = {
    Text = "Risvegliare almeno 2 Risvegliatori al completamento"
  },
  Task_21207_Name = {
    Text = "Abbraccio Infinito"
  },
  Task_21208_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_21208_Name = {
    Text = "Elegante e Preciso"
  },
  Task_21209_Desc = {
    Text = "Portare almeno 1 Reliquia maledetta al completamento."
  },
  Task_21209_Name = {
    Text = "Scorta segreta"
  },
  Task_21210_Desc = {
    Text = "Giocare almeno 4 Carte in un turno durante la Battaglia finale"
  },
  Task_21210_Name = {
    Text = "Tocca a me!"
  },
  Task_21211_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21211_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21212_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21212_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21213_Desc = {
    Text = "Infliggi almeno 2500 punti di Danno in un turno durante la Battaglia finale."
  },
  Task_21213_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_21214_Desc = {
    Text = "Pesca almeno 5 Carte aggiuntive in un turno durante la Battaglia finale."
  },
  Task_21214_Name = {Text = "Pesca!"},
  Task_21215_Desc = {
    Text = "Gioca almeno 6 Carte in un turno durante la Battaglia finale."
  },
  Task_21215_Name = {
    Text = "Tocca a me!"
  },
  Task_21216_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_21216_Name = {
    Text = "Elegante e Preciso"
  },
  Task_21217_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_21217_Name = {
    Text = "Elegante e Preciso"
  },
  Task_21218_Desc = {
    Text = "Risveglia tutti i Risvegliatori al completamento"
  },
  Task_21218_Name = {
    Text = "Abbraccio Infinito"
  },
  Task_21219_Desc = {
    Text = "Pescare almeno 3 carte aggiuntive in un turno durante la Battaglia finale"
  },
  Task_21219_Name = {Text = "Pesca!"},
  Task_21220_Desc = {
    Text = "Risvegliare almeno 3 Risvegliatori"
  },
  Task_21220_Name = {
    Text = "Abbraccio Infinito"
  },
  Task_21221_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_21221_Name = {
    Text = "Elegante e Preciso"
  },
  Task_21222_Desc = {
    Text = "Portare almeno 1 Reliquia maledetta al completamento."
  },
  Task_21222_Name = {
    Text = "Scorta segreta"
  },
  Task_21223_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21223_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21224_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21224_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21225_Desc = {
    Text = "Sconfiggere almeno 2 mostri in un round di una qualsiasi battaglia"
  },
  Task_21225_Name = {
    Text = "Sradicare e Recidere"
  },
  Task_21226_Desc = {
    Text = "Possiedi almeno 2 Reliquie al completamento"
  },
  Task_21226_Name = {
    Text = "Scorta segreta"
  },
  Task_21227_Desc = {
    Text = "Ottenere almeno 4 tipi diversi di Orazioni"
  },
  Task_21227_Name = {
    Text = "Marchio dell'Anima"
  },
  Task_21228_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21228_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21229_Desc = {
    Text = "Nessun recupero vita dalla Giunzione al completamento"
  },
  Task_21229_Name = {
    Text = "Il Senza Fiamma"
  },
  Task_21230_Desc = {
    Text = "Il progresso dell'esplorazione raggiunge il 100%"
  },
  Task_21230_Name = {
    Text = "Contemplare il Regno di Nebbia"
  },
  Task_21231_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21231_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21232_Desc = {
    Text = "Usare la Giunzione per il recupero vita non più di 1 volta."
  },
  Task_21232_Name = {
    Text = "Il Senza Fiamma"
  },
  Task_21233_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21233_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21234_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21234_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21235_Desc = {
    Text = "Pescare almeno 4 carte aggiuntive in un turno durante la Battaglia finale"
  },
  Task_21235_Name = {Text = "Pesca!"},
  Task_21236_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21236_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21237_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21237_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21238_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21238_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21239_Desc = {
    Text = "Nella Battaglia finale, attiva l'Esaltazione almeno 3 volte in un turno."
  },
  Task_21239_Name = {
    Text = "Magia letale"
  },
  Task_21240_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21240_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21241_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21241_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21242_Desc = {
    Text = "Supera con Vita non inferiore all'80%"
  },
  Task_21242_Name = {
    Text = "Elegante e Preciso"
  },
  Task_21243_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21243_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21244_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21244_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21245_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21245_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21246_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21246_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21247_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21247_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21248_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21248_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21249_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21249_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21250_Desc = {
    Text = "Vinci la Battaglia finale entro 15 turni"
  },
  Task_21250_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21251_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21251_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21252_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21252_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21253_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21253_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21254_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_21254_Name = {
    Text = "Elegante e Preciso"
  },
  Task_21255_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21255_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21256_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21256_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21257_Desc = {
    Text = "Infliggi almeno 6000 punti di Danno in un singolo turno durante una battaglia Élite."
  },
  Task_21257_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_21258_Desc = {
    Text = "Portare almeno 1 Reliquia maledetta al completamento."
  },
  Task_21258_Name = {
    Text = "Scorta segreta"
  },
  Task_21259_Desc = {
    Text = "Gioca almeno 5 Carte in un turno durante la Battaglia finale."
  },
  Task_21259_Name = {
    Text = "Tocca a me!"
  },
  Task_21260_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21260_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21261_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21261_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21262_Desc = {
    Text = "Ottenere almeno 4 tipi diversi di Orazioni"
  },
  Task_21262_Name = {
    Text = "Marchio dell'Anima"
  },
  Task_21263_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21263_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21264_Desc = {
    Text = "Possiedi almeno 2 Reliquie al completamento"
  },
  Task_21264_Name = {
    Text = "Scorta segreta"
  },
  Task_21265_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21265_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21266_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21266_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21267_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21267_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21268_Desc = {
    Text = "Risvegliare almeno 3 Risvegliatori"
  },
  Task_21268_Name = {
    Text = "Abbraccio Infinito"
  },
  Task_21269_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21269_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21270_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21270_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21271_Desc = {
    Text = "Portare almeno 5 Reliquie al completamento"
  },
  Task_21271_Name = {
    Text = "Scorta segreta"
  },
  Task_21272_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21272_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21273_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_21273_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21274_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21274_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21275_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_21275_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21276_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21276_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21277_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21277_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21278_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21278_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21279_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21279_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21280_Desc = {
    Text = "Risveglia tutti i Risvegliatori al completamento"
  },
  Task_21280_Name = {
    Text = "Abbraccio Infinito"
  },
  Task_21281_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_21281_Name = {
    Text = "Risparmio Energetico"
  },
  Task_21282_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21282_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21283_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21283_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21284_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21284_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21285_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21285_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21286_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21286_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21287_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21287_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21288_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21288_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21289_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21289_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21290_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21290_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21291_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21291_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21292_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21292_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21293_Desc = {
    Text = "Vinci la Battaglia finale entro 15 turni"
  },
  Task_21293_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21294_Desc = {
    Text = "In un turno della Battaglia finale, accumula uno Scudo del Personaggio pari ad almeno il 60% della Salute massima."
  },
  Task_21294_Name = {
    Text = "Corpo d'Acciaio"
  },
  Task_21295_Desc = {
    Text = "Risveglia tutti i Risvegliatori al completamento"
  },
  Task_21295_Name = {
    Text = "Abbraccio Infinito"
  },
  Task_21296_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_21296_Name = {
    Text = "Elegante e Preciso"
  },
  Task_21297_Desc = {
    Text = "Pescare almeno 4 carte aggiuntive in un turno durante la Battaglia finale"
  },
  Task_21297_Name = {Text = "Pesca!"},
  Task_21298_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_21298_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21299_Desc = {
    Text = "Vinci la Battaglia finale entro 15 turni"
  },
  Task_21299_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_21300_Desc = {
    Text = "Squeak, squeak...!!"
  },
  Task_21300_Name = {Text = "Squeak"},
  Task_21301_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_21301_Name = {
    Text = "Superamento Perfetto"
  },
  Task_21401_Desc = {
    Text = "Gioca 50 Carte"
  },
  Task_21401_Name = {
    Text = "Missione Quotidiana"
  },
  Task_21794_Desc = {
    Text = "Accedi per 3 giorni cumulativi"
  },
  Task_21795_Desc = {
    Text = "Accedi per un totale di 7 giorni"
  },
  Task_21821_Desc = {
    Text = "Inizio: 40 pti, -5 per turno dopo il 3°"
  },
  Task_21821_Name = {
    Text = "Turni Élite <size=20><color=#747474>40 punti, -5 per turno dopo il 3°</color></size>"
  },
  Task_21822_Desc = {
    Text = "Inizio: 40 pti, -2 per passo oltre 40"
  },
  Task_21822_Name = {
    Text = "Passi Totali <size=20><color=#747474>40 punti, -2 per passo oltre 40</color></size>"
  },
  Task_21823_Desc = {
    Text = "Inizio: 600 pti, -60 per turno dopo il 12°"
  },
  Task_21823_Name = {
    Text = "Turni del Boss <size=20><color=#747474>600 punti, -60 per turno dopo il 12°</color></size>"
  },
  Task_21824_Desc = {
    Text = "Inizio: 30 pti, -3 per turno dopo il 2°"
  },
  Task_21824_Name = {
    Text = "Turni Totali <size=20><color=#747474>30 punti, -3 per turno dopo il 2°</color></size>"
  },
  Task_21907_Desc = {
    Text = "Risveglio 50 volte"
  },
  Task_21908_Desc = {
    Text = "Risveglio 300 volte"
  },
  Task_21914_Desc = {
    Text = "Raggiungi il Livello Custode 40"
  },
  Task_21915_Desc = {
    Text = "Completa \"Indagine\": Capitolo 1"
  },
  Task_21916_Desc = {
    Text = "Raggiungi il Livello Custode 30"
  },
  Task_21917_Desc = {
    Text = "Raggiungi il Livello Custode 20"
  },
  Task_21918_Desc = {
    Text = "Raggiungi il Livello Custode 50"
  },
  Task_22347_Desc = {
    Text = "Sconfiggi Uvhash"
  },
  Task_22347_Name = {Text = "Bersaglio"},
  Task_22348_Desc = {
    Text = "Augustus il Regolatore d'Impulsi"
  },
  Task_22348_Name = {Text = "Bersaglio"},
  Task_22349_Desc = {
    Text = "Proteggi la Principessa"
  },
  Task_22349_Name = {Text = "Bersaglio"},
  Task_22350_Desc = {
    Text = "Ferma August"
  },
  Task_22350_Name = {Text = "Bersaglio"},
  Task_22351_Desc = {
    Text = "Trova Agrippa"
  },
  Task_22351_Name = {Text = "Bersaglio"},
  Task_22352_Desc = {
    Text = "Schiva la tempesta di sabbia"
  },
  Task_22352_Name = {Text = "Bersaglio"},
  Task_22353_Desc = {
    Text = "Proteggi Erica"
  },
  Task_22353_Name = {Text = "Bersaglio"},
  Task_22354_Desc = {
    Text = "Trova Erica"
  },
  Task_22354_Name = {Text = "Bersaglio"},
  Task_22355_Desc = {
    Text = "Segui Uvhash"
  },
  Task_22355_Name = {Text = "Bersaglio"},
  Task_22356_Desc = {
    Text = "Respingi gli schiavi inferociti"
  },
  Task_22356_Name = {Text = "Bersaglio"},
  Task_22358_Desc = {
    Text = "Conferisce uno scudo pari al 50% della salute massima"
  },
  Task_22358_Name = {
    Text = "Protezione Vitale II"
  },
  Task_22359_Desc = {
    Text = "Conferisce uno scudo pari al 30% della salute massima"
  },
  Task_22359_Name = {
    Text = "Protezione Vitale I"
  },
  Task_22380_Desc = {
    Text = "Trova 10 Punti di Estrazione nel Capitolo 5 della storia principale \"@1@2\""
  },
  Task_22380_Desc2 = {
    Text = "Trova 10 Punti di Estrazione nel Capitolo 5 della storia principale \"Occhio del Ciclone\""
  },
  Task_22380_Name2 = {
    Text = "Sussurro celato V"
  },
  Task_22381_Desc = {
    Text = "Completa 600 Gole di Schwarzschild"
  },
  Task_22381_Name = {
    Text = "Visione Distorta V"
  },
  Task_22382_Desc = {
    Text = "Completa 100 Gole di Schwarzschild"
  },
  Task_22382_Name = {
    Text = "Visione Distorta II"
  },
  Task_22383_Desc = {
    Text = "Completa 50 corse nella Gola di Schwarzschild"
  },
  Task_22383_Name = {
    Text = "Visione Distorta"
  },
  Task_22384_Desc = {
    Text = "Completa 400 corse nella Gola di Schwarzschild"
  },
  Task_22384_Name = {
    Text = "Visione Distorta IV"
  },
  Task_22385_Desc = {
    Text = "Completa 200 Gole di Schwarzschild"
  },
  Task_22385_Name = {
    Text = "Visione Distorta III"
  },
  Task_22387_Desc = {
    Text = "Completa l'evento d'indagine \"@1@2\""
  },
  Task_22387_Desc2 = {
    Text = "Completa l'Evento d'Indagine \"Occhio del Ciclone\""
  },
  Task_22387_Name2 = {
    Text = "Il Triangolo Perduto"
  },
  Task_22388_Desc = {
    Text = "Risuona 3 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_22388_Desc2 = {
    Text = "Nell'Evento d'Indagine \"Occhio del Ciclone\", ottieni 3 Risonanze"
  },
  Task_22388_Name2 = {
    Text = "Eco della Disperazione"
  },
  Task_22389_Desc = {
    Text = "Completa l'Evento d'Indagine \"Occhio del Ciclone\" in modalità Difficile"
  },
  Task_22389_Name = {
    Text = "Il Triangolo Perduto: Hard"
  },
  Task_22390_Desc = {
    Text = "Risuona 7 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_22390_Desc2 = {
    Text = "Nell'Evento d'Indagine \"Occhio del Ciclone\", ottieni 7 Risonanze"
  },
  Task_22390_Name2 = {
    Text = "Eco della Disperazione III"
  },
  Task_22391_Desc = {
    Text = "Risuona 6 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_22391_Desc2 = {
    Text = "Nell'Evento d'Indagine \"Occhio del Ciclone\", ottieni 6 Risonanze"
  },
  Task_22391_Name2 = {
    Text = "Eco della Disperazione II"
  },
  Task_22392_Desc = {
    Text = "Risuona 10 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_22392_Desc2 = {
    Text = "Ottieni 10 Risonanze nell'Evento d'Indagine \"Occhio del Ciclone\""
  },
  Task_22392_Name2 = {
    Text = "Eco della Disperazione IV"
  },
  Task_23613_Desc = {
    Text = "Trovare Daffodil"
  },
  Task_23613_Name = {Text = "Bersaglio"},
  Task_23614_Desc = {
    Text = "Andare al grande magazzino"
  },
  Task_23614_Name = {Text = "Bersaglio"},
  Task_23615_Desc = {
    Text = "Riprese completate"
  },
  Task_23615_Name = {Text = "Bersaglio"},
  Task_23616_Desc = {
    Text = "Ritorna all'area dell'evento"
  },
  Task_23616_Name = {Text = "Bersaglio"},
  Task_23617_Desc = {
    Text = "Inizia le riprese"
  },
  Task_23617_Name = {Text = "Bersaglio"},
  Task_23618_Desc = {
    Text = "Raccolta materiali"
  },
  Task_23618_Name = {Text = "Bersaglio"},
  Task_23619_Desc = {
    Text = "Respingi i nemici"
  },
  Task_23619_Name = {Text = "Bersaglio"},
  Task_23620_Desc = {
    Text = "Visita al Sanatorio"
  },
  Task_23620_Name = {Text = "Bersaglio"},
  Task_23646_Desc = {
    Text = "Risveglio 1000 volte"
  },
  Task_23708_Desc = {
    Text = "Finale: Pesca +5 carte (+100 pti)"
  },
  Task_23708_Name = {
    Text = "Ancora Carte! <size=20><color=#747474>Finale: Mazzo di Pesca +5 carte</color></size>"
  },
  Task_23709_Desc = {
    Text = "Ottieni 5 Reliquie dorate (+100 pti)"
  },
  Task_23709_Name = {
    Text = "Bagliore dorato <size=20><color=#747474>Ottieni 5 Reliquie dorate</color></size>"
  },
  Task_23710_Desc = {
    Text = "Ottieni 2 Reliquie maledette (+100 pti)"
  },
  Task_23710_Name = {
    Text = "Potere Pericoloso <size=20><color=#747474>Ottieni 2 Reliquie Maledette</color></size>"
  },
  Task_23711_Desc = {
    Text = "Finale: Gioca 7 carte in 1 turno (+100 pti)"
  },
  Task_23711_Name = {
    Text = "Il Mio Turno! <size=20><color=#747474>Finale: Gioca 7 Carte in 1 Turno</color></size>"
  },
  Task_23712_Desc = {
    Text = "Risveglio di 4 Risvegliatori (+100 pti)"
  },
  Task_23712_Name = {
    Text = "Ora del Risveglio <size=20><color=#747474>Risveglia 4 Risvegliatori</color></size>"
  },
  Task_23713_Desc = {
    Text = "Finale: +3 Arithmetica/turno (+100 pti)"
  },
  Task_23713_Name = {
    Text = "Calcolo Prodigioso <size=20><color=#747474>Finale: +3 Arithmetica/turno</color></size>"
  },
  Task_23714_Desc = {
    Text = "Finale: Esaltazione 3+ volte in 1 turno (+100 pti)"
  },
  Task_23714_Name = {
    Text = "Magia letale <size=20><color=#747474>Usa Esaltazione 3+ volte in 1 turno</color></size>"
  },
  Task_23715_Desc = {
    Text = "Ottieni 11 Orazioni (+100 pti)"
  },
  Task_23715_Name = {
    Text = "Potere dell'Orazione <size=20><color=#747474>Ottieni 11 Orazioni</color></size>"
  },
  Task_23716_Desc = {
    Text = "Finale: Infliggi il 50% dei PV del Boss in 1 turno (+100 pti)"
  },
  Task_23716_Name = {
    Text = "Impurità dell'Avvento <size=20><color=#747474>Infliggi >50% HP del Boss in 1 turno</color></size>"
  },
  Task_23717_Desc = {
    Text = "Ottieni 9 Orazioni uniche (+100 pti)"
  },
  Task_23717_Name = {
    Text = "Collezionista di Orazioni <size=20><color=#747474>Ottieni 9 Orazioni uniche</color></size>"
  },
  Task_23718_Desc = {
    Text = "Finale: Scudo del Personaggio = 80% PV max (+100 pti)"
  },
  Task_23718_Name = {
    Text = "Bastion di Ferro <size=20><color=#747474>Finale: Scudo del Personaggio = 80% HP Max</color></size>"
  },
  Task_23719_Desc = {
    Text = "4+ Carte sintomo al Completamento (+100 pti)"
  },
  Task_23719_Name = {
    Text = "Male Incurabile <size=20><color=#747474>4+ Carte Sintomo al Completamento</color></size>"
  },
  Task_23720_Desc = {
    Text = "Finale: Esaltazione ogni turno (+100 pti)"
  },
  Task_23720_Name = {
    Text = "Spettacolo terrificante <size=20><color=#747474>Esalta ogni turno della Battaglia finale</color></size>"
  },
  Task_23721_Desc = {
    Text = "Ottieni 7 Reliquie (+100 pti)"
  },
  Task_23721_Name = {
    Text = "Bottino abbondante <size=20><color=#747474>Ottieni 7 Reliquie</color></size>"
  },
  Task_23722_Desc = {
    Text = "Uccidi 4 in un turno (+100 pti)"
  },
  Task_23722_Name = {
    Text = "Imperdonabile! <size=20><color=#747474>Elimina 4 nemici in un round</color></size>"
  },
  Task_23789_Desc = {
    Text = "Accedi per un totale di 30 giorni"
  },
  Task_23868_Desc = {
    Text = "Vinci 5 partite Traphase"
  },
  Task_23868_Name = {
    Text = "Ricompense Settimanali"
  },
  Task_23869_Desc = {
    Text = "Raggiungi il grado Senior I in Traphase"
  },
  Task_23873_Desc = {
    Text = "Finale: Infliggi il 30% dei PV del Boss in 1 turno (+100 pti)"
  },
  Task_23873_Name = {
    Text = "Impurità dell'Avvento <size=20><color=#747474>Infliggi >30% HP del Boss in 1 turno</color></size>"
  },
  Task_23874_Desc = {
    Text = "Ottieni 5 Reliquie dorate/maledette (+100 pti)"
  },
  Task_23874_Name = {
    Text = "Li Voglio Tutti <size=20><color=#747474>Ottieni 5 Oro/Maledetti: 100 pti</color></size>"
  },
  Task_23875_Desc = {
    Text = "Ottieni 8 Orazioni uniche (+100 pti)"
  },
  Task_23875_Name = {
    Text = "Collezionista di Orazioni <size=20><color=#747474>Ottieni 8 Orazioni uniche</color></size>"
  },
  Task_23876_Desc = {
    Text = "Ottieni 10 Orazioni (+100 pti)"
  },
  Task_23876_Name = {
    Text = "Potere dell'Orazione <size=20><color=#747474>Ottieni 10 Orazioni</color></size>"
  },
  Task_23877_Desc = {
    Text = "Finale: Esaltazione 4+ volte in 1 turno (+100 pti)"
  },
  Task_23877_Name = {
    Text = "Magia letale <size=20><color=#747474>Usa Esaltazione 4+ volte in 1 turno</color></size>"
  },
  Task_23878_Desc = {
    Text = "Uccidi 3 in un turno (+100 pti)"
  },
  Task_23878_Name = {
    Text = "Imperdonabile! <size=20><color=#747474>Uccidi 3 nemici in un turno</color></size>"
  },
  Task_23879_Desc = {
    Text = "Ottieni 8 Reliquie (+100 pti)"
  },
  Task_23879_Name = {
    Text = "Bottino abbondante <size=20><color=#747474>Ottieni 8 Reliquie</color></size>"
  },
  Task_23885_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_23886_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_23887_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_23888_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_23889_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_23890_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_23891_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_23892_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_23893_Desc = {
    Text = "Completa l'Immersione Psichica \"Discendente Pallido\" in Modalità Normale"
  },
  Task_23893_Name = {
    Text = "Ricompensa Completamento"
  },
  Task_23894_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_23895_Desc = {
    Text = "Completa il Registro Operazioni Speciali \"Fantasma della Città Piovosa\" in Modalità Normale"
  },
  Task_23895_Name = {
    Text = "Ricompensa Completamento"
  },
  Task_23896_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_24139_Desc = {
    Text = "Portare almeno 5 Reliquie al completamento"
  },
  Task_24139_Name = {
    Text = "Scorta segreta"
  },
  Task_24140_Desc = {
    Text = "Gioca almeno 6 Carte in un turno durante la Battaglia finale."
  },
  Task_24140_Name = {
    Text = "Tocca a me!"
  },
  Task_24141_Desc = {
    Text = "Portare almeno 5 Reliquie al completamento"
  },
  Task_24141_Name = {
    Text = "Scorta segreta"
  },
  Task_24142_Desc = {
    Text = "Gioca almeno 6 Carte in un turno durante la Battaglia finale."
  },
  Task_24142_Name = {
    Text = "Tocca a me!"
  },
  Task_24177_Desc = {
    Text = "Fuggi dalla sala macchine"
  },
  Task_24177_Name = {Text = "Bersaglio"},
  Task_24403_Desc = {
    Text = "Insegui la carrozza sospetta"
  },
  Task_24403_Name = {Text = "Bersaglio"},
  Task_24404_Desc = {
    Text = "Evita lo sguardo di \"N\""
  },
  Task_24404_Name = {Text = "Bersaglio"},
  Task_24405_Desc = {
    Text = "Cerca l'invito per \"Nome di rosa\""
  },
  Task_24405_Name = {Text = "Bersaglio"},
  Task_24406_Desc = {
    Text = "Entra nel Dominio Artificiale, ritorna al giorno dell'incidente."
  },
  Task_24406_Name = {Text = "Bersaglio"},
  Task_24407_Desc = {
    Text = "Cattura l'Uomo Sospetto"
  },
  Task_24407_Name = {Text = "Bersaglio"},
  Task_24408_Desc = {
    Text = "Raggiungi la cameriera Karen"
  },
  Task_24408_Name = {Text = "Bersaglio"},
  Task_24409_Desc = {
    Text = "Difenditi dagli attacchi della misteriosa Ombra nera"
  },
  Task_24409_Name = {Text = "Bersaglio"},
  Task_24410_Desc = {
    Text = "Difenditi dall'attacco delle Ombre Mascherate"
  },
  Task_24410_Name = {Text = "Bersaglio"},
  Task_24411_Desc = {
    Text = "Cattura il Signor Lambert"
  },
  Task_24411_Name = {Text = "Bersaglio"},
  Task_24412_Desc = {
    Text = "Respingi i mostri della Dissoluzione"
  },
  Task_24412_Name = {Text = "Bersaglio"},
  Task_24457_Desc = {
    Text = "Finale: Esaltazione 3/4+ volte in 1 turno (+50/+100 pti)"
  },
  Task_24457_Name = {
    Text = "Magia letale <size=20><color=#747474>Usa Esaltazione 3+ volte in 1 turno</color></size>"
  },
  Task_24458_Desc = {
    Text = "Ottieni 7/9/11 Orazioni (+30/+60/+100 pti)"
  },
  Task_24458_Name = {
    Text = "Potere dell'Orazione <size=20><color=#747474>Ottieni 7 Orazioni</color></size>"
  },
  Task_24459_Desc = {
    Text = "Ottieni 4/5/6 Reliquie dorate (+30/+60/+100 pti)"
  },
  Task_24459_Name = {
    Text = "Bagliore dorato <size=20><color=#747474>Ottieni 5 Reliquie dorate</color></size>"
  },
  Task_24460_Desc = {
    Text = "Ottieni 4/5/6 Reliquie dorate (+30/+60/+100 pti)"
  },
  Task_24460_Name = {
    Text = "Bagliore dorato <size=20><color=#747474>Ottieni 4 Reliquie dorate</color></size>"
  },
  Task_24461_Desc = {
    Text = "Ottieni 4/5/6 Reliquie dorate/maledette (+30/+60/+100 pti)"
  },
  Task_24461_Name = {
    Text = "Li Voglio Tutti <size=20><color=#747474>Ottieni 6 Reliquie Oro/Maledette</color></size>"
  },
  Task_24462_Desc = {
    Text = "Ottieni 4/5/6 Reliquie dorate/maledette (+30/+60/+100 pti)"
  },
  Task_24462_Name = {
    Text = "Li Voglio Tutti <size=20><color=#747474>Ottieni 4 Reliquie Oro/Maledette</color></size>"
  },
  Task_24463_Desc = {
    Text = "Ottieni 4/5/6 Reliquie dorate/maledette (+30/+60/+100 pti)"
  },
  Task_24463_Name = {
    Text = "Li Voglio Tutti <size=20><color=#747474>Ottieni 5 Reliquie Oro/Maledette</color></size>"
  },
  Task_24464_Desc = {
    Text = "Ottieni 7/9/11 Orazioni (+30/+60/+100 pti)"
  },
  Task_24464_Name = {
    Text = "Potere dell'Orazione <size=20><color=#747474>Ottieni 9 Orazioni</color></size>"
  },
  Task_24465_Desc = {
    Text = "Risveglio di 3/4 Risvegliatori (+50/+100 pti)"
  },
  Task_24465_Name = {
    Text = "Ora del Risveglio <size=20><color=#747474>Risveglia 3 Risvegliatori</color></size>"
  },
  Task_24466_Desc = {
    Text = "Finale: Gioca 5/7/9 carte (+30/+60/+100 pti)"
  },
  Task_24466_Name = {
    Text = "Il Mio Turno! <size=20><color=#747474>Finale: Gioca 9 Carte in 1 Turno</color></size>"
  },
  Task_24467_Desc = {
    Text = "Risveglio di 3/4 Risvegliatori (+50/+100 pti)"
  },
  Task_24467_Name = {
    Text = "Ora del Risveglio <size=20><color=#747474>Risveglia 4 Risvegliatori</color></size>"
  },
  Task_24468_Desc = {
    Text = "Finale: Esaltazione 3/4+ volte in 1 turno (+50/+100 pti)"
  },
  Task_24468_Name = {
    Text = "Magia letale <size=20><color=#747474>Usa Esaltazione 4+ volte in 1 turno</color></size>"
  },
  Task_24469_Desc = {
    Text = "Finale: +2/+3/+4 Arithmetica/turno (+30/+60/+100 pti)"
  },
  Task_24469_Name = {
    Text = "Calcolo Prodigioso <size=20><color=#747474>Finale: +2 Arithmetica/turno</color></size>"
  },
  Task_24470_Desc = {
    Text = "Finale: +2/+3/+4 Arithmetica/turno (+30/+60/+100 pti)"
  },
  Task_24470_Name = {
    Text = "Calcolo Prodigioso <size=20><color=#747474>Finale: +3 Arithmetica/turno</color></size>"
  },
  Task_24471_Desc = {
    Text = "Completamento con 3/4 Carte sintomo (+50/+100 pti)"
  },
  Task_24471_Name = {
    Text = "Male Incurabile <size=20><color=#747474>3+ Carte Sintomo al Completamento</color></size>"
  },
  Task_24472_Desc = {
    Text = "Completamento con 3/4 Carte sintomo (+50/+100 pti)"
  },
  Task_24472_Name = {
    Text = "Male Incurabile <size=20><color=#747474>4+ Carte Sintomo al Completamento</color></size>"
  },
  Task_24473_Desc = {
    Text = "Finale: +2/+3/+4 Arithmetica/turno (+30/+60/+100 pti)"
  },
  Task_24473_Name = {
    Text = "Calcolo Prodigioso <size=20><color=#747474>Finale: +4 Arithmetica/turno</color></size>"
  },
  Task_24474_Desc = {
    Text = "Carte in Mano di un Risvegliatore ≤2/1 (+50/+100 pti)"
  },
  Task_24474_Name = {
    Text = "<Il Dimenticato> <size=20><color=#747474>Carte Risveglio ≤2 al completamento</color></size>"
  },
  Task_24475_Desc = {
    Text = "Finale: Usa Esaltazione per 3/4/5+ turni consecutivi (+30/+60/+100 pti)"
  },
  Task_24475_Name = {
    Text = "Spettacolo terrificante <size=20><color=#747474>Esaltazione per 5+ turni nel Finale</color></size>"
  },
  Task_24476_Desc = {
    Text = "Carte in Mano di un Risvegliatore ≤2/1 (+50/+100 pti)"
  },
  Task_24476_Name = {
    Text = "<Il Dimenticato> <size=20><color=#747474>Carte Risveglio ≤1 al completamento</color></size>"
  },
  Task_24477_Desc = {
    Text = "Finale: Usa Esaltazione per 3/4/5+ turni consecutivi (+30/+60/+100 pti)"
  },
  Task_24477_Name = {
    Text = "Spettacolo terrificante <size=20><color=#747474>Esaltazione per 4+ turni nel Finale</color></size>"
  },
  Task_24478_Desc = {
    Text = "Ottieni 6/7/8 Reliquie (+30/+60/+100 pti)"
  },
  Task_24478_Name = {
    Text = "Bottino abbondante <size=20><color=#747474>Ottieni 7 Reliquie</color></size>"
  },
  Task_24479_Desc = {
    Text = "Ottieni 6/7/8 Reliquie (+30/+60/+100 pti)"
  },
  Task_24479_Name = {
    Text = "Bottino abbondante <size=20><color=#747474>Ottieni 6 Reliquie</color></size>"
  },
  Task_24480_Desc = {
    Text = "Finale: Scudo del Personaggio = 25%/50%/75% PV (+30/+60/+100 pti)"
  },
  Task_24480_Name = {
    Text = "Bastion di Ferro <size=20><color=#747474>Finale: Scudo del Personaggio = 25% PV max/turno</color></size>"
  },
  Task_24481_Desc = {
    Text = "Finale: Infliggi 20%/30%/40% HP del Boss (+30/+60/+100 pti)"
  },
  Task_24481_Name = {
    Text = "Impurità dell'Avvento <size=20><color=#747474>Infliggi >30% HP del Boss in 1 turno</color></size>"
  },
  Task_24482_Desc = {
    Text = "Ottieni 6/7/8 Reliquie (+30/+60/+100 pti)"
  },
  Task_24482_Name = {
    Text = "Bottino abbondante <size=20><color=#747474>Ottieni 8 Reliquie</color></size>"
  },
  Task_24483_Desc = {
    Text = "Ottieni 5/7/9 Orazioni uniche (+30/+60/+100 pti)"
  },
  Task_24483_Name = {
    Text = "Collezionista di Orazioni <size=20><color=#747474>Ottieni 9 Orazioni uniche</color></size>"
  },
  Task_24484_Desc = {
    Text = "Ottieni 5/7/9 Orazioni uniche (+30/+60/+100 pti)"
  },
  Task_24484_Name = {
    Text = "Collezionista di Orazioni <size=20><color=#747474>Ottieni 5 Orazioni uniche</color></size>"
  },
  Task_24485_Desc = {
    Text = "Ottieni 5/7/9 Orazioni uniche (+30/+60/+100 pti)"
  },
  Task_24485_Name = {
    Text = "Collezionista di Orazioni <size=20><color=#747474>Ottieni 7 Orazioni uniche</color></size>"
  },
  Task_24486_Desc = {
    Text = "Ottieni 4/5/6 Reliquie dorate (+30/+60/+100 pti)"
  },
  Task_24486_Name = {
    Text = "Bagliore dorato <size=20><color=#747474>Ottieni 6 Reliquie dorate</color></size>"
  },
  Task_24487_Desc = {
    Text = "Finale: Usa Esaltazione per 3/4/5+ turni consecutivi (+30/+60/+100 pti)"
  },
  Task_24487_Name = {
    Text = "Spettacolo terrificante <size=20><color=#747474>Esaltazione per 3+ turni nel Finale</color></size>"
  },
  Task_24488_Desc = {
    Text = "Ottieni 2/3 Reliquie maledette (+50/+100 pti)"
  },
  Task_24488_Name = {
    Text = "Potere Pericoloso <size=20><color=#747474>Ottieni 3 Reliquie Maledette</color></size>"
  },
  Task_24489_Desc = {
    Text = "Ottieni 2/3 Reliquie maledette (+50/+100 pti)"
  },
  Task_24489_Name = {
    Text = "Potere Pericoloso <size=20><color=#747474>Ottieni 2 Reliquie Maledette</color></size>"
  },
  Task_24490_Desc = {
    Text = "Finale: Scudo del Personaggio = 25%/50%/75% PV (+30/+60/+100 pti)"
  },
  Task_24490_Name = {
    Text = "Bastion di Ferro <size=20><color=#747474>Finale: Scudo del Personaggio = 50% PV max</color></size>"
  },
  Task_24491_Desc = {
    Text = "Finale: Gioca 5/7/9 carte (+30/+60/+100 pti)"
  },
  Task_24491_Name = {
    Text = "Il Mio Turno! <size=20><color=#747474>Finale: Gioca 7 Carte in 1 Turno</color></size>"
  },
  Task_24492_Desc = {
    Text = "Ottieni 7/9/11 Orazioni (+30/+60/+100 pti)"
  },
  Task_24492_Name = {
    Text = "Potere dell'Orazione <size=20><color=#747474>Ottieni 11 Orazioni</color></size>"
  },
  Task_24493_Desc = {
    Text = "Finale: Gioca 5/7/9 carte (+30/+60/+100 pti)"
  },
  Task_24493_Name = {
    Text = "Il Mio Turno! <size=20><color=#747474>Finale: Gioca 5 Carte in 1 Turno</color></size>"
  },
  Task_24494_Desc = {
    Text = "Finale: Infliggi 20%/30%/40% HP del Boss (+30/+60/+100 pti)"
  },
  Task_24494_Name = {
    Text = "Impurità dell'Avvento <size=20><color=#747474>Infliggi >40% HP del Boss in 1 turno</color></size>"
  },
  Task_24495_Desc = {
    Text = "Finale: Scudo del Personaggio = 25%/50%/75% PV (+30/+60/+100 pti)"
  },
  Task_24495_Name = {
    Text = "Bastion di Ferro <size=20><color=#747474>Finale: Scudo del Personaggio = 75% PV max</color></size>"
  },
  Task_24496_Desc = {
    Text = "Finale: Infliggi 20%/30%/40% HP del Boss (+30/+60/+100 pti)"
  },
  Task_24496_Name = {
    Text = "Impurità dell'Avvento <size=20><color=#747474>Infliggi >20% HP del Boss in 1 turno</color></size>"
  },
  Task_24497_Desc = {
    Text = "Uccidi 3/4 in un turno (+50/+100 pti)"
  },
  Task_24497_Name = {
    Text = "Imperdonabile! <size=20><color=#747474>Uccidi 4 nemici in un turno</color></size>"
  },
  Task_24498_Desc = {
    Text = "Finale: Pesca +4/+5/+6 carte (+30/+60/+100 pti)"
  },
  Task_24498_Name = {
    Text = "Ancora Carte! <size=20><color=#747474>Finale: Mazzo di Pesca +5 carte</color></size>"
  },
  Task_24499_Desc = {
    Text = "Finale: Pesca +4/+5/+6 carte (+30/+60/+100 pti)"
  },
  Task_24499_Name = {
    Text = "Ancora Carte! <size=20><color=#747474>Finale: Pesca +4 carte</color></size>"
  },
  Task_24500_Desc = {
    Text = "Uccidi 3/4 in un turno (+50/+100 pti)"
  },
  Task_24500_Name = {
    Text = "Imperdonabile! <size=20><color=#747474>Uccidi 3 nemici in un turno</color></size>"
  },
  Task_24501_Desc = {
    Text = "Finale: Pesca +4/+5/+6 carte (+30/+60/+100 pti)"
  },
  Task_24501_Name = {
    Text = "Ancora Carte! <size=20><color=#747474>Finale: Mazzo di Pesca +6 carte</color></size>"
  },
  Task_24534_Desc = {
    Text = "Raggiungi Ramona"
  },
  Task_24534_Name = {Text = "Bersaglio"},
  Task_25013_Desc = {
    Text = "Completa il Registro Operazioni Speciali \"Tributo alla Rosa\" in Modalità Normale"
  },
  Task_25013_Name = {
    Text = "Ricompensa Completamento"
  },
  Task_25014_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_25015_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_25016_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_25017_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_25018_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_25019_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_25020_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_25021_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_25022_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_25023_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_25024_Desc = {
    Text = "Completa l'Immersione Psichica \"A un passo\" in Modalità Normale"
  },
  Task_25024_Name = {
    Text = "Ricompensa Completamento"
  },
  Task_25164_Desc = {
    Text = "Segui Ramona"
  },
  Task_25164_Name = {Text = "Bersaglio"},
  Task_25167_Desc = {
    Text = "Entra nella Magione Misteriosa"
  },
  Task_25167_Name = {Text = "Bersaglio"},
  Task_25168_Desc = {
    Text = "Ritorna al palco di Lady Sorel"
  },
  Task_25168_Name = {Text = "Bersaglio"},
  Task_34729_Desc = {
    Text = "Mistero Ordito: Ultra"
  },
  Task_34731_Desc = {
    Text = "Mistero Ordito: Caos"
  },
  Task_34734_Desc = {
    Text = "Registro Operazioni Speciali"
  },
  Task_34737_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_34740_Desc = {
    Text = "Mistero Ordito: Aequor"
  },
  Task_34741_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_34742_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_34743_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_34744_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_34745_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_34746_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_34748_Desc = {
    Text = "Mistero Ordito: Caro"
  },
  Task_34750_Desc = {
    Text = "Completa tutte le missioni in \"Registro Operazioni Speciali\""
  },
  Task_34942_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per accumulare 25 utilizzi di Posse in \"Mistero Ordito\""
  },
  Task_34943_Desc = {
    Text = "Accumula 50 carte \"Embrione\" in \"Mistero Ordito\""
  },
  Task_34944_Desc = {
    Text = "Accumula 10 Turni Ultra in \"Mistero Ordito\""
  },
  Task_34945_Desc = {
    Text = "Accumula 250 Attacchi del Tentacolo in \"Mistero Ordito\""
  },
  Task_34946_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per vincere una volta in \"Mistero Ordito\""
  },
  Task_34947_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere una volta in \"Mistero Ordito\""
  },
  Task_34948_Desc = {
    Text = "Accumula 100 Attacchi del Tentacolo in \"Mistero Ordito\""
  },
  Task_34949_Desc = {
    Text = "Accumula 5 Turni Ultra in \"Mistero Ordito\""
  },
  Task_34950_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere una volta in \"Mistero Ordito\""
  },
  Task_34951_Desc = {
    Text = "Accumula 15 carte \"Embrione\" in \"Mistero Ordito\""
  },
  Task_34952_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per accumulare 10 utilizzi di Posse in \"Mistero Ordito\""
  },
  Task_34953_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere una volta in \"Mistero Ordito\""
  },
  Task_35262_Desc = {
    Text = "Completa tutte le missioni Reame in \"Mistero Ordito\""
  },
  Task_35263_Desc = {
    Text = "Capitolo Finale"
  },
  Task_35808_Desc = {
    Text = "Consuma 500 milioni di Certificati Rosa"
  },
  Task_35808_Name = {
    Text = "Spendaccione"
  },
  Task_36141_Desc = {
    Text = "Risuona 6 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_36141_Desc2 = {
    Text = "Risuona 6 volte nell'Evento d'Indagine \"Stelle distorte\""
  },
  Task_36141_Name2 = {
    Text = "Eco del Desiderio II"
  },
  Task_36142_Desc = {
    Text = "Completa l'evento d'indagine \"@1@2\""
  },
  Task_36142_Desc2 = {
    Text = "Completa l'Evento d'Indagine \"Stelle distorte\""
  },
  Task_36142_Name2 = {
    Text = "Rifiuto della Chiamata"
  },
  Task_36143_Desc = {
    Text = "Risuona 3 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_36143_Desc2 = {
    Text = "Risuona 3 volte nell'Evento d'Indagine \"Stelle distorte\""
  },
  Task_36143_Name2 = {
    Text = "Eco del Desiderio"
  },
  Task_36144_Desc = {
    Text = "Completa l'Evento d'Indagine \"Stelle distorte\" a difficoltà Difficile"
  },
  Task_36144_Name = {
    Text = "Rifiuto della Chiamata: Hard"
  },
  Task_36145_Desc = {
    Text = "Risuona 8 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_36145_Desc2 = {
    Text = "Risuona 8 volte nell'Evento d'Indagine \"Stelle distorte\""
  },
  Task_36145_Name2 = {
    Text = "Eco del Desiderio III"
  },
  Task_36155_Desc = {
    Text = "Proteggi il capitano mentre è alla guida"
  },
  Task_36155_Name = {Text = "Bersaglio"},
  Task_36156_Desc = {
    Text = "Entra nella sala macchine"
  },
  Task_36156_Name = {Text = "Bersaglio"},
  Task_36157_Desc = {
    Text = "Trova i compagni"
  },
  Task_36157_Name = {Text = "Bersaglio"},
  Task_36158_Desc = {
    Text = "Resisti all'assalto del Navigatore"
  },
  Task_36158_Name = {Text = "Bersaglio"},
  Task_36159_Desc = {
    Text = "Avvicinati al \"Sacro Infante\""
  },
  Task_36159_Name = {Text = "Bersaglio"},
  Task_36160_Desc = {
    Text = "Resisti all'Attacco"
  },
  Task_36160_Name = {Text = "Bersaglio"},
  Task_36161_Desc = {
    Text = "Ritorno alla cabina di pilotaggio"
  },
  Task_36161_Name = {Text = "Bersaglio"},
  Task_36162_Desc = {
    Text = "Respingi i nemici"
  },
  Task_36162_Name = {Text = "Bersaglio"},
  Task_36163_Desc = {
    Text = "Dirigiti verso la cabina di pilotaggio"
  },
  Task_36163_Name = {Text = "Bersaglio"},
  Task_36164_Desc = {
    Text = "Prosegui verso la sala macchine"
  },
  Task_36164_Name = {Text = "Bersaglio"},
  Task_36169_Desc = {
    Text = "Vai alla piazza"
  },
  Task_36169_Name = {Text = "Bersaglio"},
  Task_36316_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_36316_Name = {
    Text = "Risparmio Energetico"
  },
  Task_36317_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_36317_Name = {
    Text = "Risparmio Energetico"
  },
  Task_36359_Desc = {
    Text = "Trova 10 Punti di Estrazione nel Capitolo 6 della storia principale \"@1@2\""
  },
  Task_36359_Desc2 = {
    Text = "Trova 10 Punti di Estrazione nel Capitolo 6 della storia principale, \"Stelle distorte\"."
  },
  Task_36359_Name2 = {
    Text = "Sussurro celato VI"
  },
  Task_36622_Desc = {
    Text = "L'Abitante del villaggio che controlla la Mutazione"
  },
  Task_36622_Name = {Text = "Bersaglio"},
  Task_36623_Desc = {
    Text = "Dirigiti alla Camera di Wanda"
  },
  Task_36623_Name = {Text = "Bersaglio"},
  Task_36624_Desc = {
    Text = "Respingi i Mostri di D-melma"
  },
  Task_36624_Name = {Text = "Bersaglio"},
  Task_36842_Desc = {
    Text = "Completa l'Immersione Psichica \"Eadem Omnia\" in Modalità Normale"
  },
  Task_36842_Name = {
    Text = "Ricompensa Completamento"
  },
  Task_36864_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_36872_Desc = {
    Text = "-30% punteggio per Corpo di Gnosi d'Emergenza"
  },
  Task_36872_Name = {
    Text = "Gnosi Esaurita <size=20><color=#747474>-30% Punteggio per Corpo di Gnosi d'Emergenza</color></size>"
  },
  Task_38749_Desc = {
    Text = "Consuma 180 Menofina"
  },
  Task_38750_Desc = {
    Text = "Usa Supporto 3 volte"
  },
  Task_38751_Desc = {
    Text = "Metti \"mi piace\" ai tuoi Alumni 10 volte"
  },
  Task_38752_Desc = {
    Text = "Completa la Prova Settimanale"
  },
  Task_38753_Desc = {
    Text = "Esegui 3 Incarichi"
  },
  Task_38754_Desc = {
    Text = "Completa tutti i Compiti di Addestramento"
  },
  Task_38755_Desc = {
    Text = "Vinci 1 volta nell'Immersione Fantasmatica"
  },
  Task_38814_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere una volta in \"Città nel Lago\""
  },
  Task_38815_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere 5 volte in \"Città nel Lago\""
  },
  Task_38816_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere 3 volte in \"Città nel Lago\""
  },
  Task_38817_Desc = {
    Text = "Città nel Lago: Caro"
  },
  Task_38818_Desc = {
    Text = "Completa una qualsiasi Rimembranza ne \"L'Apocalisse\""
  },
  Task_38819_Desc = {
    Text = "Completa una qualsiasi Rimembranza in \"Ricordo fugace\""
  },
  Task_38820_Desc = {
    Text = "Vinci 5 volte nella \"Città nel Lago\" usando un qualsiasi Risvegliatore del Reame Ultra"
  },
  Task_38821_Desc = {
    Text = "Vinci 3 volte nella \"Città nel Lago\" usando un qualsiasi Risvegliatore del Reame Ultra"
  },
  Task_38822_Desc = {
    Text = "Vinci una volta nella \"Città nel Lago\" usando un qualsiasi Risvegliatore del Reame Ultra"
  },
  Task_38823_Desc = {
    Text = "Città nel Lago: Aequor"
  },
  Task_38824_Desc = {
    Text = "Completa una qualsiasi Rimembranza in \"Fiore di Fresia\""
  },
  Task_38825_Desc = {
    Text = "Completa una qualsiasi Rimembranza in \"Pozzo profondo\""
  },
  Task_38826_Desc = {
    Text = "Immersione nella Psiche"
  },
  Task_38827_Desc = {
    Text = "Vinci 3 volte nella \"Città nel Lago\" usando un qualsiasi Risvegliatore di Aequor"
  },
  Task_38828_Desc = {
    Text = "Vinci 5 volte nella \"Città nel Lago\" usando un qualsiasi Risvegliatore di Aequor"
  },
  Task_38829_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere una volta in \"Città nel Lago\""
  },
  Task_38830_Desc = {
    Text = "Completa una qualsiasi Rimembranza in \"Miraggio\""
  },
  Task_38831_Desc = {
    Text = "Città nel Lago: Caos"
  },
  Task_38832_Desc = {
    Text = "Completa una qualsiasi Rimembranza in \"Verità Nascosta\""
  },
  Task_38833_Desc = {
    Text = "Città nel Lago: Rimembranza"
  },
  Task_38834_Desc = {
    Text = "Completa una qualsiasi Rimembranza in \"Città d'Oro\""
  },
  Task_38835_Desc = {
    Text = "Vinci una volta nella \"Città nel Lago\" usando un qualsiasi Risvegliatore di Caro"
  },
  Task_38836_Desc = {
    Text = "Vinci 5 volte nella \"Città nel Lago\" usando un qualsiasi Risvegliatore di Caro"
  },
  Task_38837_Desc = {
    Text = "Vinci 3 volte nella \"Città nel Lago\" usando un qualsiasi Risvegliatore di Caro"
  },
  Task_38838_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_38839_Desc = {
    Text = "Città nel Lago: Ultra"
  },
  Task_38840_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_39279_Desc = {
    Text = "-20% pti per Corpo di Gnosi d'Emergenza (Volte utilizzato: {s1})"
  },
  Task_39279_Name = {
    Text = "Soccorso nel Miraggio <size=20><color=#747474>-20% per Corpo di Gnosi d'Emergenza</color></size>"
  },
  Task_40465_Desc = {
    Text = "Attiva <Guaiwusiwangdikang:Resistenza alla Morte> 1/2/3+ volte (+100/+300/+500 pti)"
  },
  Task_40465_Name = {
    Text = "Non Oggi! <size=20><color=#747474>Attiva Resistenza alla Morte 1x</color></size>"
  },
  Task_40466_Desc = {
    Text = "Attiva <Guaiwusiwangdikang:Resistenza alla Morte> 1/2/3+ volte (+100/+300/+500 pti)"
  },
  Task_40466_Name = {
    Text = "Non Oggi! <size=20><color=#747474>Attiva Resistenza alla Morte 3+x</color></size>"
  },
  Task_40467_Desc = {
    Text = "Attiva <Guaiwusiwangdikang:Resistenza alla Morte> 1/2/3+ volte (+100/+300/+500 pti)"
  },
  Task_40467_Name = {
    Text = "Non Oggi! <size=20><color=#747474>Attiva Resistenza alla Morte 2x</color></size>"
  },
  Task_40468_Desc = {
    Text = "Possiedi 5/6/7/8 Reliquie (+250/+500/+750/+1000 pti)"
  },
  Task_40468_Name = {
    Text = "Collezionista di Reliquie <size=20><color=#747474>Possiedi 5 Reliquie</color></size>"
  },
  Task_40469_Desc = {
    Text = "Possiedi 5/6/7/8 Reliquie (+250/+500/+750/+1000 pti)"
  },
  Task_40469_Name = {
    Text = "Collezionista di Reliquie <size=20><color=#747474>Possiedi 7 Reliquie</color></size>"
  },
  Task_40470_Desc = {
    Text = "Possiedi 5/6/7/8 Reliquie (+250/+500/+750/+1000 pti)"
  },
  Task_40470_Name = {
    Text = "Collezionista di Reliquie <size=20><color=#747474>Possiedi 6 Reliquie</color></size>"
  },
  Task_40471_Desc = {
    Text = "Vinci in ≤11/10/9/8 turni (+250/+500/+750/+1000 pti)"
  },
  Task_40471_Name = {
    Text = "Vittoria Fulminea <size=20><color=#747474>Sconfiggi il Boss in ≤8 turni</color></size>"
  },
  Task_40472_Desc = {
    Text = "Vinci in ≤11/10/9/8 turni (+250/+500/+750/+1000 pti)"
  },
  Task_40472_Name = {
    Text = "Vittoria Fulminea <size=20><color=#747474>Sconfiggi il Boss in ≤8 turni</color></size>"
  },
  Task_40473_Desc = {
    Text = "Vinci in ≤11/10/9/8 turni (+250/+500/+750/+1000 pti)"
  },
  Task_40473_Name = {
    Text = "Vittoria Fulminea <size=20><color=#747474>Sconfiggi il Boss in ≤9 turni</color></size>"
  },
  Task_40474_Desc = {
    Text = "Vinci in ≤11/10/9/8 turni (+250/+500/+750/+1000 pti)"
  },
  Task_40474_Name = {
    Text = "Vittoria Fulminea <size=20><color=#747474>Sconfiggi il Boss in ≤10 turni</color></size>"
  },
  Task_40475_Desc = {
    Text = "Vinci in ≤11/10/9/8 turni (+250/+500/+750/+1000 pti)"
  },
  Task_40475_Name = {
    Text = "Vittoria Fulminea <size=20><color=#747474>Sconfiggi il Boss in ≤11 turni</color></size>"
  },
  Task_40476_Desc = {
    Text = "Vittoria sul Boss: 1000 pti"
  },
  Task_40476_Name = {
    Text = "Vincitore Finale <size=20><color=#747474>Vittoria sul Boss</color></size>"
  },
  Task_41334_Desc = {
    Text = "Sconfiggi {s1}"
  },
  Task_41334_Name = {Text = "Bersaglio"},
  Task_41367_Desc = {
    Text = "Completamento Storia principale Capitolo 3"
  },
  Task_41368_Desc = {
    Text = "Completamento Storia principale Capitolo 5"
  },
  Task_41369_Desc = {
    Text = "Completamento Storia principale Capitolo 4"
  },
  Task_41370_Desc = {
    Text = "Completamento Storia principale Capitolo 2"
  },
  Task_41371_Desc = {
    Text = "Raggiungi 325 Punti Addestramento per la prima volta"
  },
  Task_41372_Desc = {
    Text = "Raggiungi 350 Punti Addestramento per la prima volta"
  },
  Task_41373_Desc = {
    Text = "Raggiungi 225 Punti Addestramento per la prima volta"
  },
  Task_41374_Desc = {
    Text = "Raggiungi 300 Punti Addestramento per la prima volta"
  },
  Task_41375_Desc = {
    Text = "Raggiungi 100 Punti Addestramento per la prima volta"
  },
  Task_41376_Desc = {
    Text = "Raggiungi 150 Punti Addestramento per la prima volta"
  },
  Task_41377_Desc = {
    Text = "Raggiungi 50 Punti Addestramento per la prima volta"
  },
  Task_41380_Desc = {
    Text = "Completa tutte le missioni di Rimembranza sopra elencate"
  },
  Task_43476_Desc = {
    Text = "Custode Liv. 55"
  },
  Task_43476_Name = {
    Text = "Prova del Custode IV"
  },
  Task_43477_Desc = {
    Text = "Custode Liv. 45"
  },
  Task_43477_Name = {
    Text = "Prova del Custode III"
  },
  Task_43514_Desc = {
    Text = "Respingi Glen e il suo gruppo"
  },
  Task_43514_Name = {Text = "Bersaglio"},
  Task_43561_Desc = {
    Text = "Completa il Capitolo 6 della Storia principale \"Stelle distorte\""
  },
  Task_43562_Desc = {
    Text = "Completa il Capitolo 5 della Storia principale \"Occhio del Ciclone\""
  },
  Task_43563_Desc = {
    Text = "Completa il Capitolo 3 della Storia principale \"Attenti ai segugi\""
  },
  Task_43564_Desc = {
    Text = "Completamento Storia Principale Capitolo 6 \"Stelle distorte\": Modalità Difficile"
  },
  Task_43565_Desc = {
    Text = "Completamento Storia Principale Capitolo 4 \"Dove regna il silenzio\": Modalità Difficile"
  },
  Task_43566_Desc = {
    Text = "Completamento Storia Principale Capitolo 3 \"Attenti ai segugi\": Modalità Difficile"
  },
  Task_43567_Desc = {
    Text = "Completa il Capitolo 5 della Storia principale \"Occhio del Ciclone\": Modalità Difficile"
  },
  Task_43568_Desc = {
    Text = "Completa il Capitolo 4 della Storia principale \"Dove regna il silenzio\""
  },
  Task_43822_Desc = {
    Text = "Possiedi un Risvegliato a livello 80"
  },
  Task_43822_Name = {
    Text = "\"Potere Trascendente\" I"
  },
  Task_43824_Desc = {
    Text = "Infliggi 250000 danni con un singolo colpo"
  },
  Task_43824_Name = {
    Text = "Dolore Insopportabile IV"
  },
  Task_43825_Desc = {
    Text = "Infliggi 500000 danni con un singolo colpo"
  },
  Task_43825_Name = {
    Text = "Dolore Insopportabile V"
  },
  Task_43826_Desc = {
    Text = "Infliggi 50000 danni con un singolo colpo"
  },
  Task_43826_Name = {
    Text = "Dolore Insopportabile II"
  },
  Task_43827_Desc = {
    Text = "Infliggi 100000 danni con un singolo colpo"
  },
  Task_43827_Name = {
    Text = "Dolore Insopportabile III"
  },
  Task_43828_Desc = {
    Text = "Possiedi 3 Risvegliati a Livello 80"
  },
  Task_43828_Name = {
    Text = "\"Potere Trascendente\"III"
  },
  Task_43829_Desc = {
    Text = "Possiedi 2 Risvegliati a Livello 80"
  },
  Task_43829_Name = {
    Text = "\"Potere Trascendente\" II"
  },
  Task_43831_Desc = {
    Text = "Applica 10000 accumuli di Veleno al nemico"
  },
  Task_43831_Name = {
    Text = "Veleno della Realtà I"
  },
  Task_43832_Desc = {
    Text = "Completa l'Immersione Psichica \"Il Desiderio del Cavaliere\""
  },
  Task_43832_Name = {Text = "1001 Notti"},
  Task_43833_Desc = {
    Text = "Completa l'Immersione Psichica \"Banchetto di Fiamme\""
  },
  Task_43833_Name = {
    Text = "Nulla di nuovo sotto la luna"
  },
  Task_43834_Desc = {
    Text = "Completa il registro speciale \"Ode alla Rosa\" a difficoltà Difficile"
  },
  Task_43834_Name = {
    Text = "Le Rose Rosse Non Tacciono Mai: Hard"
  },
  Task_43835_Desc = {
    Text = "Completa il registro speciale \"Magia delle Storie\" a difficoltà Difficile"
  },
  Task_43835_Name = {
    Text = "Semplice Infanzia: Hard"
  },
  Task_43836_Desc = {
    Text = "Completa il registro speciale \"Magia delle Storie\""
  },
  Task_43836_Name = {
    Text = "Un'Infanzia Ordinaria"
  },
  Task_43837_Desc = {
    Text = "Completa il registro speciale \"L'Ombra della Città della Pioggia\" a difficoltà Difficile"
  },
  Task_43837_Name = {
    Text = "La Strega delle Ere: Hard"
  },
  Task_43838_Desc = {
    Text = "Completa il registro speciale \"Ombra della Città della Pioggia\""
  },
  Task_43838_Name = {
    Text = "Strega di un'Era"
  },
  Task_43839_Desc = {
    Text = "Completa il registro speciale \"Ode alla Rosa\""
  },
  Task_43839_Name = {
    Text = "Le Rose Rosse Non Tacciono Mai"
  },
  Task_43840_Desc = {
    Text = "Combatti 2000 volte in Traphase"
  },
  Task_43840_Name = {
    Text = "Sovrapposizione di Fase V"
  },
  Task_43843_Desc = {
    Text = "Smantella una Ruota del destino SSR"
  },
  Task_43843_Name = {
    Text = "Beni Terreni"
  },
  Task_43844_Desc = {
    Text = "Ruota del destino accumulata 700 volte"
  },
  Task_43844_Name = {
    Text = "Futuro a intreccio quantistico I"
  },
  Task_43845_Desc = {
    Text = "Potenzia le Abilità dei Risvegliati 1000 volte"
  },
  Task_43845_Name = {
    Text = "\"Maestria delle Armi\" VII"
  },
  Task_43846_Desc = {
    Text = "Potenzia le Abilità dei Risvegliati 1100 volte"
  },
  Task_43846_Name = {
    Text = "\"Maestria delle Armi\" VIII"
  },
  Task_43847_Desc = {
    Text = "Potenzia le Abilità dei Risvegliati 1200 volte"
  },
  Task_43847_Name = {
    Text = "\"Maestria delle Armi\" IX"
  },
  Task_43849_Desc = {
    Text = "Smantella 100 Ruote del destino"
  },
  Task_43849_Name = {
    Text = "Preziosa Curiosità"
  },
  Task_43850_Desc = {
    Text = "Smantella 200 Ruote del destino"
  },
  Task_43850_Name = {
    Text = "La gioia dello smembramento"
  },
  Task_43851_Desc = {
    Text = "Smantella 300 Ruote del destino"
  },
  Task_43851_Name = {
    Text = "L'Universo in un Guscio di Noce"
  },
  Task_43863_Desc = {
    Text = "Combatti 1000 volte in Traphase"
  },
  Task_43863_Name = {
    Text = "Sovrapposizione di Fase IV"
  },
  Task_43864_Desc = {
    Text = "Combatti 500 volte in Traphase"
  },
  Task_43864_Name = {
    Text = "Sovrapposizione di Fase III"
  },
  Task_43866_Desc = {
    Text = "Completa 100 Immersioni Fantasmatiche"
  },
  Task_43866_Name = {
    Text = "Avventura Superficiale"
  },
  Task_43867_Desc = {
    Text = "Combatti 250 volte in Traphase"
  },
  Task_43867_Name = {
    Text = "Sovrapposizione di Fase II"
  },
  Task_43868_Desc = {
    Text = "Combatti 100 volte in Traphase"
  },
  Task_43868_Name = {
    Text = "Sovrapposizione di Fase I"
  },
  Task_43869_Desc = {
    Text = "Raggiungi il Livello di Affinità 10 con 40 Risvegliatori"
  },
  Task_43869_Name = {
    Text = "Siete tutti le mie ali"
  },
  Task_43873_Desc = {
    Text = "Ruota del destino accumulata 600 volte"
  },
  Task_43873_Name = {
    Text = "Destini Intrecciati VI"
  },
  Task_43874_Desc = {
    Text = "Ruota del destino accumulata 500 volte"
  },
  Task_43874_Name = {
    Text = "Destini Intrecciati V"
  },
  Task_43875_Desc = {
    Text = "Ruota del destino accumulata 400 volte"
  },
  Task_43875_Name = {
    Text = "Destini Intrecciati IV"
  },
  Task_43876_Desc = {
    Text = "Ruota del destino accumulata 300 volte"
  },
  Task_43876_Name = {
    Text = "Destini Intrecciati III"
  },
  Task_43877_Desc = {
    Text = "Ruota del destino accumulata 200 volte"
  },
  Task_43877_Name = {
    Text = "Destini Intrecciati II"
  },
  Task_43878_Desc = {
    Text = "Ruota del destino accumulata 100 volte"
  },
  Task_43878_Name = {
    Text = "Destini Intrecciati I"
  },
  Task_43880_Desc = {
    Text = "Illumina i Risvegliati 600 volte"
  },
  Task_43880_Name = {
    Text = "Richiamo dall'Ignoto"
  },
  Task_43881_Desc = {
    Text = "Illumina i Risvegliati 500 volte"
  },
  Task_43881_Name = {
    Text = "Fusione di Carne e Anima IV"
  },
  Task_43882_Desc = {
    Text = "Illumina i Risvegliati 400 volte"
  },
  Task_43882_Name = {
    Text = "Fusione di Carne e Anima III"
  },
  Task_43883_Desc = {
    Text = "Completa l'Immersione Psichica \"Scultura Melodica\" in difficoltà Difficile"
  },
  Task_43883_Name = {
    Text = "Segreto di Aleph: Hard"
  },
  Task_43884_Desc = {
    Text = "Completa l'Immersione Psichica \"Sangue e Sabbia\" a difficoltà ardua"
  },
  Task_43884_Name = {
    Text = "Così parlò la Bestia: Hard"
  },
  Task_43885_Desc = {
    Text = "Completa l'Immersione Psichica \"A un passo\""
  },
  Task_43885_Name = {
    Text = "Messaggero del Circuito"
  },
  Task_43886_Desc = {
    Text = "Completa l'Immersione Psichica \"Eadem Omnia\""
  },
  Task_43886_Name = {
    Text = "La Città Invisibile"
  },
  Task_43887_Desc = {
    Text = "Completa l'Immersione Psichica \"Il Desiderio del Cavaliere\" in difficoltà Difficile"
  },
  Task_43887_Name = {
    Text = "Le Mille e Una Notte: Hard"
  },
  Task_43888_Desc = {
    Text = "Completa l'Immersione Psichica \"Banchetto di Fiamme\" in difficoltà Difficile"
  },
  Task_43888_Name = {
    Text = "Nulla di nuovo sotto la luna: Hard"
  },
  Task_43889_Desc = {
    Text = "Completa l'Immersione Psichica \"Scultura Melodica\""
  },
  Task_43889_Name = {
    Text = "Segreto di Aleph"
  },
  Task_43890_Desc = {
    Text = "Completa l'Immersione Psichica \"Sangue e Sabbia\""
  },
  Task_43890_Name = {
    Text = "Così parlò la Bestia"
  },
  Task_43891_Desc = {
    Text = "Completa l'Immersione Psichica \"Nucleo Distorto\""
  },
  Task_43891_Name = {
    Text = "Le Bambole Meccaniche Sognano?"
  },
  Task_43892_Desc = {
    Text = "Completa l'Immersione Psichica \"Discendente Pallido\""
  },
  Task_43892_Name = {
    Text = "Il Mio Demian"
  },
  Task_43893_Desc = {
    Text = "Infliggi 25000 accumuli di Veleno al nemico"
  },
  Task_43893_Name = {
    Text = "Veleno della Realtà II"
  },
  Task_43896_Desc = {
    Text = "Completa l'Immersione Psichica \"A un passo\" a difficoltà ardua"
  },
  Task_43896_Name = {
    Text = "Messaggero del Circuito: Hard"
  },
  Task_43897_Desc = {
    Text = "Esegui la Cerimonia di risveglio 10000 volte"
  },
  Task_43897_Name = {
    Text = "Cantore della Gnosi"
  },
  Task_43898_Desc = {
    Text = "Completa l'Immersione Psichica \"Nucleo Distorto\" a difficoltà ardua"
  },
  Task_43898_Name = {
    Text = "Le Bambole Meccaniche Sognano?: Hard"
  },
  Task_43899_Desc = {
    Text = "Accumula il consumo di 100000 Sigilli Neri"
  },
  Task_43899_Name = {
    Text = "Benve\"nuuuuu\"ti IV"
  },
  Task_43900_Desc = {
    Text = "Accumula il consumo di 50000 Sigilli Neri"
  },
  Task_43900_Name = {
    Text = "Benve\"nuuuuu\"ti III"
  },
  Task_43901_Desc = {
    Text = "Accumula il consumo di 25000 Sigilli Neri"
  },
  Task_43901_Name = {
    Text = "Benve\"nuuuuu\"ti II"
  },
  Task_43902_Desc = {
    Text = "Accumula il consumo di 10000 Sigilli Neri"
  },
  Task_43902_Name = {
    Text = "Benve\"nuuuuu\"ti I"
  },
  Task_43903_Desc = {
    Text = "Possiedi 100 Patti di Livello 12"
  },
  Task_43903_Name = {
    Text = "Guardiano del Tabù III"
  },
  Task_43904_Desc = {
    Text = "Possiedi 150 Patti di Livello 12"
  },
  Task_43904_Name = {
    Text = "Guardiano del Tabù IV"
  },
  Task_43905_Desc = {
    Text = "Possiedi 25 Patti di Livello 12"
  },
  Task_43905_Name = {
    Text = "Guardiano del Tabù I"
  },
  Task_43906_Desc = {
    Text = "Possiedi 50 Patti di Livello 12"
  },
  Task_43906_Name = {
    Text = "Guardiano del Tabù II"
  },
  Task_43907_Desc = {
    Text = "Esegui la Cerimonia di risveglio 2500 volte"
  },
  Task_43907_Name = {
    Text = "Cantore dell'Anima II"
  },
  Task_43908_Desc = {
    Text = "Esegui la Cerimonia di risveglio 5000 volte"
  },
  Task_43908_Name = {
    Text = "Cantore dell'Anima III"
  },
  Task_43909_Desc = {
    Text = "Esegui la Cerimonia di risveglio 500 volte"
  },
  Task_43909_Name = {
    Text = "Custode del genio V"
  },
  Task_43910_Desc = {
    Text = "Esegui la Cerimonia di risveglio 1000 volte"
  },
  Task_43910_Name = {
    Text = "Cantore dell'Anima I"
  },
  Task_43911_Desc = {
    Text = "Completa l'Immersione Psichica \"Discendente Pallido\" a difficoltà ardua"
  },
  Task_43911_Name = {
    Text = "Il Mio Demian: Difficile"
  },
  Task_43916_Desc = {
    Text = "Cambia il tuo avatar più di 3 volte in un giorno"
  },
  Task_43916_Name = {
    Text = "Maestro del Travestimento"
  },
  Task_43917_Desc = {
    Text = "Parla con il Risvegliatore 100 volte nel dormitorio"
  },
  Task_43917_Name = {
    Text = "Per Oggi è Tutto"
  },
  Task_43918_Desc = {
    Text = "Completa 250 Trascrizioni del Patto"
  },
  Task_43918_Name = {
    Text = "Qualcosa non Quadra"
  },
  Task_43919_Desc = {
    Text = "Completa 100 Trascrizioni del Patto"
  },
  Task_43919_Name = {
    Text = "Ispirazione Inesauribile"
  },
  Task_43921_Desc = {
    Text = "Completa 500 Trascrizioni del Patto"
  },
  Task_43921_Name = {
    Text = "Un'Altra Revisione"
  },
  Task_43923_Desc = {
    Text = "Infliggi 10000 danni"
  },
  Task_43923_Name = {
    Text = "Dolore Insopportabile I"
  },
  Task_43928_Desc = {
    Text = "Raggiungi il Livello di Affinità 10 con 30 Risvegliatori"
  },
  Task_43928_Name = {
    Text = "Anatomia dell'\"Amore\""
  },
  Task_43930_Desc = {
    Text = "Raggiungi il Livello di Affinità 10 con 16 Risvegliatori"
  },
  Task_43930_Name = {
    Text = "Dialogo tra Cuore e Anima"
  },
  Task_43932_Desc = {
    Text = "Raggiungi il Livello di Affinità 10 con 20 Risvegliati"
  },
  Task_43932_Name = {
    Text = "Lettore dell'anima"
  },
  Task_43934_Desc = {
    Text = "Sblocca la Forma Genesi di Ramona"
  },
  Task_43934_Name = {
    Text = "Al fianco della fanciulla"
  },
  Task_43936_Desc = {
    Text = "Raggiungi il Livello di Affinità 10 con 12 Risvegliatori"
  },
  Task_43936_Name = {
    Text = "Risveglio dell'Anima"
  },
  Task_43937_Desc = {
    Text = "Accesso cumulativo: 300 giorni"
  },
  Task_43937_Name = {
    Text = "Una volontà irremovibile"
  },
  Task_43938_Desc = {
    Text = "Accesso cumulativo per 365 giorni"
  },
  Task_43938_Name = {
    Text = "Una notte di stelle scintillanti"
  },
  Task_43943_Desc = {
    Text = "Accesso cumulativo per 120 giorni"
  },
  Task_43943_Name = {
    Text = "Un mattino ordinario"
  },
  Task_43944_Desc = {
    Text = "Accesso cumulativo per 150 giorni"
  },
  Task_43944_Name = {
    Text = "Un caffè semplice"
  },
  Task_43945_Desc = {
    Text = "Accedi per un totale di 180 giorni"
  },
  Task_43945_Name = {
    Text = "Una semplice conversazione"
  },
  Task_43946_Desc = {
    Text = "Accesso cumulativo per 240 giorni"
  },
  Task_43946_Name = {
    Text = "Un cuore ardente"
  },
  Task_43948_Desc = {
    Text = "Ottieni 30 Ruote del Destino diverse"
  },
  Task_43948_Name = {
    Text = "Signore dell'Incertezza"
  },
  Task_43949_Desc = {
    Text = "Ottieni 20 Ruote del Destino diverse"
  },
  Task_43949_Name = {
    Text = "Apprendista del Destino II"
  },
  Task_43950_Desc = {
    Text = "Ottieni 10 Ruote del Destino diverse"
  },
  Task_43950_Name = {
    Text = "Apprendista del Destino I"
  },
  Task_43953_Desc = {
    Text = "Ottieni 40 Ruote del Destino diverse"
  },
  Task_43953_Name = {
    Text = "Tessitore di Destini"
  },
  Task_43957_Desc = {
    Text = "Usa il Supporto una volta"
  },
  Task_43957_Name = {
    Text = "Amici nel Bisogno"
  },
  Task_43958_Desc = {
    Text = "Modifica il messaggio del profilo"
  },
  Task_43958_Name = {
    Text = "Ciao, Mondo!"
  },
  Task_43959_Desc = {
    Text = "Ricevi 1000 \"Mi piace\""
  },
  Task_43959_Name = {
    Text = "Quando la Lode Bussa"
  },
  Task_43961_Desc = {
    Text = "Metti \"Mi piace\" 100 volte"
  },
  Task_43961_Name = {
    Text = "Un Piccolo Passo Fuori di Sé"
  },
  Task_43962_Desc = {
    Text = "Metti \"Mi piace\" 50 volte"
  },
  Task_43962_Name = {
    Text = "Modesto Tentativo"
  },
  Task_43964_Desc = {
    Text = "Segui 100 Alumni eccezionali"
  },
  Task_43964_Name = {
    Text = "Quando le Stelle Brillano"
  },
  Task_43965_Desc = {
    Text = "Segui 1 alumnus"
  },
  Task_43965_Name = {
    Text = "Come ti chiami?"
  },
  Task_43966_Desc = {
    Text = "Totale di 500 giorni di accesso"
  },
  Task_43966_Name = {
    Text = "Il Sole Sorge su Kadath"
  },
  Task_43967_Desc = {
    Text = "Illumina i Risvegliati 60 volte"
  },
  Task_43967_Name = {
    Text = "Incontro tra Anima e Cuore V"
  },
  Task_43968_Desc = {
    Text = "Illumina i Risvegliati 100 volte"
  },
  Task_43968_Name = {
    Text = "Attesa nell'Ombra"
  },
  Task_43969_Desc = {
    Text = "Illumina i Risvegliati 30 volte"
  },
  Task_43969_Name = {
    Text = "Incontro tra Anima e Cuore III"
  },
  Task_43970_Desc = {
    Text = "Illumina i Risvegliati 45 volte"
  },
  Task_43970_Name = {
    Text = "Incontro tra Anima e Cuore IV"
  },
  Task_43972_Desc = {
    Text = "Illumina i Risvegliati 15 volte"
  },
  Task_43972_Name = {
    Text = "Incontro tra Anima e Cuore II"
  },
  Task_43973_Desc = {
    Text = "Possiedi 4 Risvegliati a Livello 80"
  },
  Task_43973_Name = {
    Text = "\"Potere Trascendente\"IV"
  },
  Task_43975_Desc = {
    Text = "Illumina i Risvegliati 200 volte"
  },
  Task_43975_Name = {
    Text = "Fusione di Carne e Anima I"
  },
  Task_43976_Desc = {
    Text = "Illumina i Risvegliati 300 volte"
  },
  Task_43976_Name = {
    Text = "Fusione di Carne e Anima II"
  },
  Task_44231_Desc = {
    Text = "Vinci una volta nel \"Sentiero della Chiesa\" usando un qualsiasi Risvegliatore del Reame Ultra"
  },
  Task_44232_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere 3 volte nel \"Sentiero della Chiesa\""
  },
  Task_44233_Desc = {
    Text = "Vinci due volte nel \"Sentiero della Chiesa\" usando un qualsiasi Risvegliatore del Reame Ultra"
  },
  Task_44234_Desc = {
    Text = "Supera \"Lotta Interiore\" a qualsiasi difficoltà"
  },
  Task_44235_Desc = {
    Text = "Supera \"Morsa della Paranoia\" a qualsiasi difficoltà"
  },
  Task_44236_Desc = {
    Text = "Vinci una volta nel \"Sentiero della Chiesa\" usando un qualsiasi Risvegliatore di Aequor"
  },
  Task_44237_Desc = {
    Text = "Vinci 3 volte nel \"Sentiero della Chiesa\" usando un qualsiasi Risvegliatore del Caos"
  },
  Task_44238_Desc = {
    Text = "Vinci due volte nel \"Sentiero della Chiesa\" usando un qualsiasi Risvegliatore del Caos"
  },
  Task_44239_Desc = {
    Text = "Vinci una volta nel \"Sentiero della Chiesa\" usando un qualsiasi Risvegliatore del Caos"
  },
  Task_44240_Desc = {
    Text = "Vinci tre volte nel \"Sentiero della Chiesa\" usando un qualsiasi Risvegliatore di Aequor"
  },
  Task_44241_Desc = {
    Text = "Acquista 150 volte ne \"Il bazar magico di Big John\""
  },
  Task_44242_Desc = {
    Text = "Acquista 200 volte ne \"Il bazar magico di Big John\""
  },
  Task_44243_Desc = {
    Text = "Acquista 100 volte ne \"Il bazar magico di Big John\""
  },
  Task_44244_Desc = {
    Text = "Effettua 200 acquisti ne \"Il Negozio della Sig.ra Gray\""
  },
  Task_44245_Desc = {
    Text = "Effettua 150 acquisti ne \"Il Negozio della Sig.ra Gray\""
  },
  Task_44246_Desc = {
    Text = "Effettua 100 acquisti ne \"Il Negozio della Sig.ra Gray\""
  },
  Task_44247_Desc = {
    Text = "Vinci 3 volte nel \"Sentiero della Chiesa\" usando un qualsiasi Risvegliatore di Caro"
  },
  Task_44248_Desc = {
    Text = "Vinci due volte nel \"Sentiero della Chiesa\" usando un qualsiasi Risvegliatore di Caro"
  },
  Task_44249_Desc = {
    Text = "Vinci una volta nel \"Sentiero della Chiesa\" usando un qualsiasi Risvegliatore di Caro"
  },
  Task_44250_Desc = {
    Text = "Supera \"Penitenza\" a qualsiasi difficoltà"
  },
  Task_44251_Desc = {
    Text = "Bazar di beneficenza della Chiesa"
  },
  Task_44252_Desc = {
    Text = "Acquista 100 volte nella \"Vendita Speciale di Smith\""
  },
  Task_44253_Desc = {
    Text = "Acquista 200 volte nella \"Vendita Speciale di Smith\""
  },
  Task_44254_Desc = {
    Text = "Acquista 150 volte nella \"Vendita Speciale di Smith\""
  },
  Task_44255_Desc = {
    Text = "Via Sacrosanta: Aequor"
  },
  Task_44256_Desc = {
    Text = "Via Sacrosanta: Ultra"
  },
  Task_44257_Desc = {
    Text = "Via Sacrosanta: Caos"
  },
  Task_44258_Desc = {
    Text = "Supera \"Supplica Inascoltata\" a qualsiasi difficoltà"
  },
  Task_44259_Desc = {
    Text = "Completa tutti i livelli della \"Via Sacrosanta\" a qualsiasi difficoltà"
  },
  Task_44260_Desc = {
    Text = "Supera \"Rimprovero Silenzioso\" a qualsiasi difficoltà"
  },
  Task_44261_Desc = {
    Text = "Vinci due volte nel \"Sentiero della Chiesa\" usando un qualsiasi Risvegliatore di Aequor"
  },
  Task_44262_Desc = {
    Text = "Via Sacrosanta: Caro"
  },
  Task_44263_Desc = {
    Text = "Via Sacrosanta: Rigoglio"
  },
  Task_44264_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_44567_Desc = {
    Text = "Ferma Sofia"
  },
  Task_44567_Name = {Text = "Bersaglio"},
  Task_45665_Desc = {
    Text = "Completa l'Immersione Psichica \"La Caduta di un Gigante\" in Modalità Normale"
  },
  Task_45665_Name = {
    Text = "Ricompensa Completamento"
  },
  Task_45666_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_46575_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per completare \"Ricordo Evanescente\" a qualsiasi difficoltà"
  },
  Task_46576_Desc = {
    Text = "Completa \"Sguardo dello Specchio\" a qualsiasi difficoltà"
  },
  Task_46577_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per completare \"Psiche del Rettile\" a qualsiasi difficoltà"
  },
  Task_46578_Desc = {
    Text = "Codice della Memoria: Caro"
  },
  Task_46579_Desc = {
    Text = "Completa \"Psiche del Rettile\" a qualsiasi difficoltà"
  },
  Task_46580_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per completare \"Ricordo Evanescente\" a qualsiasi difficoltà"
  },
  Task_46581_Desc = {
    Text = "Codice della Memoria: Aequor"
  },
  Task_46582_Desc = {
    Text = "Completa \"Ricordo Evanescente\" a qualsiasi difficoltà"
  },
  Task_46583_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per completare \"Curva dell'Oblio\" a qualsiasi difficoltà"
  },
  Task_46584_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per completare \"Sguardo dello Specchio\" a qualsiasi difficoltà"
  },
  Task_46585_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per completare \"Richiamo dell'Amigdala\" a qualsiasi difficoltà"
  },
  Task_46586_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per completare \"Psiche del Rettile\" a qualsiasi difficoltà"
  },
  Task_46587_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per completare \"Ricordo Evanescente\" a qualsiasi difficoltà"
  },
  Task_46588_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per completare \"Sguardo dello Specchio\" a qualsiasi difficoltà"
  },
  Task_46589_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per completare \"Curva dell'Oblio\" a qualsiasi difficoltà"
  },
  Task_46590_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per completare \"Ricordo Evanescente\" a qualsiasi difficoltà"
  },
  Task_46591_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per completare \"Psiche del Rettile\" a qualsiasi difficoltà"
  },
  Task_46592_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per completare \"Richiamo dell'Amigdala\" a qualsiasi difficoltà"
  },
  Task_46593_Desc = {
    Text = "Completa tutti i livelli di \"Codice della Memoria\" a qualsiasi difficoltà"
  },
  Task_46594_Desc = {
    Text = "Completa \"Curva dell'Oblio\" a qualsiasi difficoltà"
  },
  Task_46595_Desc = {
    Text = "Codice della Memoria: Caos"
  },
  Task_46596_Desc = {
    Text = "Completa \"Richiamo dell'Amigdala\" a qualsiasi difficoltà"
  },
  Task_46597_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per completare \"Curva dell'Oblio\" a qualsiasi difficoltà"
  },
  Task_46598_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per completare \"Sguardo dello Specchio\" a qualsiasi difficoltà"
  },
  Task_46599_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per completare \"Curva dell'Oblio\" a qualsiasi difficoltà"
  },
  Task_46600_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per completare \"Sguardo dello Specchio\" a qualsiasi difficoltà"
  },
  Task_46601_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per completare \"Richiamo dell'Amigdala\" a qualsiasi difficoltà"
  },
  Task_46602_Desc = {
    Text = "Codice della Memoria: Emersione"
  },
  Task_46603_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per completare \"Richiamo dell'Amigdala\" a qualsiasi difficoltà"
  },
  Task_46604_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per completare \"Psiche del Rettile\" a qualsiasi difficoltà"
  },
  Task_46605_Desc = {
    Text = "Codice della Memoria: Ultra"
  },
  Task_46624_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_46798_Desc = {
    Text = "Record più Alto"
  },
  Task_46798_Name = {Text = "200 punti"},
  Task_46799_Desc = {
    Text = "Record più Alto"
  },
  Task_46799_Name = {Text = "450 punti"},
  Task_46806_Desc = {
    Text = "Record più Alto"
  },
  Task_46806_Name = {Text = "50 punti"},
  Task_46807_Desc = {
    Text = "Record più Alto"
  },
  Task_46807_Name = {Text = "100 punti"},
  Task_46808_Desc = {
    Text = "Record più Alto"
  },
  Task_46808_Name = {Text = "150 punti"},
  Task_46809_Desc = {
    Text = "Record più Alto"
  },
  Task_46809_Name = {Text = "1500 punti"},
  Task_46810_Desc = {
    Text = "Record più Alto"
  },
  Task_46810_Name = {Text = "250 punti"},
  Task_46811_Desc = {
    Text = "Record più Alto"
  },
  Task_46811_Name = {Text = "300 punti"},
  Task_46812_Desc = {
    Text = "Record più Alto"
  },
  Task_46812_Name = {Text = "350 punti"},
  Task_46821_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_46821_Name = {Text = "6 vittorie"},
  Task_46822_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_46822_Name = {Text = "3 vittorie"},
  Task_46823_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_46823_Name = {Text = "1 vittoria"},
  Task_46826_Desc = {
    Text = "Record più Alto"
  },
  Task_46826_Name = {Text = "1450 punti"},
  Task_46827_Desc = {
    Text = "Record più Alto"
  },
  Task_46827_Name = {Text = "1400 punti"},
  Task_46828_Desc = {
    Text = "Record più Alto"
  },
  Task_46828_Name = {Text = "1350 punti"},
  Task_46829_Desc = {
    Text = "Record più Alto"
  },
  Task_46829_Name = {Text = "1300 punti"},
  Task_46830_Desc = {
    Text = "Record più Alto"
  },
  Task_46830_Name = {Text = "1250 punti"},
  Task_46831_Desc = {
    Text = "Record più Alto"
  },
  Task_46831_Name = {Text = "1200 punti"},
  Task_46832_Desc = {
    Text = "Record più Alto"
  },
  Task_46832_Name = {Text = "1150 punti"},
  Task_46833_Desc = {
    Text = "Record più Alto"
  },
  Task_46833_Name = {Text = "1100 punti"},
  Task_46834_Desc = {
    Text = "Record più Alto"
  },
  Task_46834_Name = {Text = "1050 punti"},
  Task_46835_Desc = {
    Text = "Record più Alto"
  },
  Task_46835_Name = {Text = "1000 punti"},
  Task_46836_Desc = {
    Text = "Record più Alto"
  },
  Task_46836_Name = {Text = "600 punti"},
  Task_46837_Desc = {
    Text = "Record più Alto"
  },
  Task_46837_Name = {Text = "650 punti"},
  Task_46838_Desc = {
    Text = "Record più Alto"
  },
  Task_46838_Name = {Text = "500 punti"},
  Task_46839_Desc = {
    Text = "Record più Alto"
  },
  Task_46839_Name = {Text = "550 punti"},
  Task_46840_Desc = {
    Text = "Record più Alto"
  },
  Task_46840_Name = {Text = "800 punti"},
  Task_46841_Desc = {
    Text = "Record più Alto"
  },
  Task_46841_Name = {Text = "850 punti"},
  Task_46842_Desc = {
    Text = "Record più Alto"
  },
  Task_46842_Name = {Text = "700 punti"},
  Task_46843_Desc = {
    Text = "Record più Alto"
  },
  Task_46843_Name = {Text = "750 punti"},
  Task_46844_Desc = {
    Text = "Record più Alto"
  },
  Task_46844_Name = {Text = "900 punti"},
  Task_46845_Desc = {
    Text = "Record più Alto"
  },
  Task_46845_Name = {Text = "950 punti"},
  Task_46846_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_46846_Name = {
    Text = "10 vittorie"
  },
  Task_46847_Desc = {
    Text = "Record più Alto"
  },
  Task_46847_Name = {Text = "400 punti"},
  Task_46850_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_46850_Name = {
    Text = "10 vittorie"
  },
  Task_46852_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_46852_Name = {Text = "3 vittorie"},
  Task_46853_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_46853_Name = {Text = "6 vittorie"},
  Task_46854_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_46854_Name = {Text = "1 vittoria"},
  Task_47794_Desc = {
    Text = "Completamento di tutte le Fessure del Reame Oscuro VII"
  },
  Task_47795_Desc = {
    Text = "Completamento di tutte le Fessure del Reame Oscuro I"
  },
  Task_47796_Desc = {
    Text = "Completamento di tutte le Fessure del Reame Oscuro III"
  },
  Task_47797_Desc = {
    Text = "Completamento di tutte le Fessure del Reame Oscuro V"
  },
  Task_47799_Desc = {
    Text = "Completamento di tutte le Fessure del Reame Oscuro IV"
  },
  Task_47800_Desc = {
    Text = "Completamento di tutte le Fessure del Reame Oscuro VI"
  },
  Task_47801_Desc = {
    Text = "Completamento di tutte le Fessure del Reame Oscuro VIII"
  },
  Task_47802_Desc = {
    Text = "Completamento di tutte le Fessure del Reame Oscuro II"
  },
  Task_48166_Desc = {
    Text = "Respingi Rogers e gli altri"
  },
  Task_48166_Name = {Text = "Bersaglio"},
  Task_48167_Desc = {
    Text = "Sconfiggi Ombra \"24\""
  },
  Task_48167_Name = {Text = "Bersaglio"},
  Task_48733_CompleteCondDesc = {
    Text = "Livello Totale>={s1}"
  },
  Task_48733_Desc = {
    Text = "Dalle rovine della Chiesa crollata e delle reliquie infrante, il museo reclama i suoi tesori, e tu reclami i tuoi.\nCiascuno prende ciò di cui ha bisogno."
  },
  Task_48733_Name = {
    Text = "Missione: Panteismo"
  },
  Task_48733_UnlockCondDesc = {
    Text = "Si sblocca al Livello Custode 40."
  },
  Task_48734_CompleteCondDesc = {
    Text = "Livello Totale>={s1}"
  },
  Task_48734_Desc = {
    Text = "Dimentica le tue percezioni, dimentica il tuo scopo.\nCos'è La Verità? Saranno loro a dirtelo."
  },
  Task_48734_Name = {
    Text = "Missione: A Priori"
  },
  Task_48734_UnlockCondDesc = {
    Text = "Si sblocca al Livello Custode 30"
  },
  Task_48735_CompleteCondDesc = {
    Text = "Livello Totale>={s1}"
  },
  Task_48735_Desc = {
    Text = "La geografia è una menzogna raccontata da chi detiene il Potere.\nDiffida di quelle curve di livello."
  },
  Task_48735_Name = {
    Text = "Missione: Piani di Ricognizione"
  },
  Task_48735_UnlockCondDesc = {
    Text = "Si sblocca al Livello Custode 20"
  },
  Task_48736_CompleteCondDesc = {
    Text = "Livello Totale>={s1}"
  },
  Task_48736_Desc = {
    Text = "Ricevi due promesse inaffidabili e un Sogno indimenticabile."
  },
  Task_48736_Name = {
    Text = "Missione: Regno Fantasma"
  },
  Task_48736_UnlockCondDesc = {
    Text = "Si sblocca al Livello Custode 50"
  },
  Task_48775_Desc = {
    Text = "L'Affinità di Lily raggiunge il Livello 10"
  },
  Task_48776_Desc = {
    Text = "L'Affinità di Aurita raggiunge il Livello 10"
  },
  Task_48777_Desc = {
    Text = "L'Affinità di Faint raggiunge il Livello 10"
  },
  Task_48778_Desc = {
    Text = "L'Affinità di Wanda raggiunge il Livello 10"
  },
  Task_48779_Desc = {
    Text = "L'Affinità di Jenkin raggiunge il Livello 10"
  },
  Task_48780_Desc = {
    Text = "L'Affinità di Ogier raggiunge il Livello 10"
  },
  Task_48781_Desc = {
    Text = "L'Affinità di Liz raggiunge il Livello 10"
  },
  Task_48782_Desc = {
    Text = "L'Affinità di Daffodil raggiunge il Livello 10"
  },
  Task_48783_Desc = {
    Text = "L'Affinità di Doll raggiunge il Livello 10"
  },
  Task_48784_Desc = {
    Text = "L'Affinità di Celeste raggiunge il Livello 10"
  },
  Task_48785_Desc = {
    Text = "L'Affinità di Aigis raggiunge il Livello 10"
  },
  Task_48786_Desc = {
    Text = "L'Affinità di Murphy raggiunge il Livello 10"
  },
  Task_48787_Desc = {
    Text = "L'Affinità di Sanga raggiunge il Livello 10"
  },
  Task_48788_Desc = {
    Text = "L'Affinità di Uvhash raggiunge il Livello 10"
  },
  Task_48789_Desc = {
    Text = "L'Affinità di Nautila raggiunge il Livello 10"
  },
  Task_48790_Desc = {
    Text = "L'Affinità di \"24\" raggiunge il Livello 10"
  },
  Task_48791_Desc = {
    Text = "L'Affinità di Agrippa raggiunge il Livello 10"
  },
  Task_48792_Desc = {
    Text = "L'Affinità di Faros raggiunge il Livello 10"
  },
  Task_48793_Desc = {
    Text = "L'Affinità di Winkle raggiunge il Livello 10"
  },
  Task_48794_Desc = {
    Text = "L'Affinità di Salvador raggiunge il Livello 10"
  },
  Task_48795_Desc = {
    Text = "L'Affinità di Helot raggiunge il Livello 10"
  },
  Task_48796_Desc = {
    Text = "L'Affinità di Erica raggiunge il Livello 10"
  },
  Task_48797_Desc = {
    Text = "L'Affinità di Ramona raggiunge il Livello 10"
  },
  Task_48798_Desc = {
    Text = "L'Affinità di Sorel raggiunge il Livello 10"
  },
  Task_48799_Desc = {
    Text = "L'Affinità di Thais raggiunge il Livello 10"
  },
  Task_48800_Desc = {
    Text = "L'Affinità di Golia raggiunge il Livello 10"
  },
  Task_48801_Desc = {
    Text = "L'Affinità di Leigh raggiunge il Livello 10"
  },
  Task_48802_Desc = {
    Text = "L'Affinità di Alva raggiunge il Livello 10"
  },
  Task_48803_Desc = {
    Text = "L'Affinità di Caecus raggiunge il Livello 10"
  },
  Task_48804_Desc = {
    Text = "L'Affinità di Tulu raggiunge il Livello 10"
  },
  Task_48805_Desc = {
    Text = "L'Affinità di Casiah raggiunge il Livello 10"
  },
  Task_48806_Desc = {
    Text = "L'Affinità di Karen raggiunge il Livello 10"
  },
  Task_48807_Desc = {
    Text = "L'Affinità di Pandia raggiunge il Livello 10"
  },
  Task_48808_Desc = {
    Text = "L'Affinità di Tintura raggiunge il Livello 10"
  },
  Task_48809_Desc = {
    Text = "L'Affinità di Nymphaea raggiunge il Livello 10"
  },
  Task_48810_Desc = {
    Text = "L'Affinità di Lotan raggiunge il Livello 10"
  },
  Task_48829_Desc = {
    Text = "Accesso: 11 giorni"
  },
  Task_48830_Desc = {
    Text = "Accesso: 14 giorni"
  },
  Task_48831_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_48832_Desc = {
    Text = "Accesso: 16 giorni"
  },
  Task_48833_Desc = {
    Text = "Accesso: 12 giorni"
  },
  Task_48834_Desc = {
    Text = "Accesso: 13 giorni"
  },
  Task_48835_Desc = {
    Text = "Accedi per un totale di 10 giorni"
  },
  Task_48836_Desc = {
    Text = "Accedi per 5 giorni cumulativi"
  },
  Task_48837_Desc = {
    Text = "Accesso cumulativo per 6 giorni"
  },
  Task_48838_Desc = {
    Text = "Accedi per un totale di 7 giorni"
  },
  Task_48839_Desc = {
    Text = "Accedi per un totale di 2 giorni"
  },
  Task_48840_Desc = {
    Text = "Accedi per 3 giorni cumulativi"
  },
  Task_48841_Desc = {
    Text = "Accedi per un totale di 8 giorni"
  },
  Task_48842_Desc = {
    Text = "Accesso: 9 giorni"
  },
  Task_48843_Desc = {
    Text = "Accedi per un totale di 15 giorni"
  },
  Task_48844_Desc = {
    Text = "Accedi per un totale di 4 giorni"
  },
  Task_49241_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_49241_Name = {Text = "1 vittoria"},
  Task_49242_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_49242_Name = {Text = "3 vittorie"},
  Task_49243_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_49243_Name = {Text = "6 vittorie"},
  Task_49244_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_49244_Name = {
    Text = "10 vittorie"
  },
  Task_49245_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_49245_Name = {
    Text = "10 vittorie"
  },
  Task_49246_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_49246_Name = {Text = "1 vittoria"},
  Task_49247_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_49247_Name = {Text = "6 vittorie"},
  Task_49248_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_49248_Name = {Text = "3 vittorie"},
  Task_49262_Desc = {
    Text = "Vinci la Battaglia finale entro 30 turni"
  },
  Task_49262_Name = {
    Text = "Vinci la Battaglia finale entro 30 turni"
  },
  Task_49380_Desc = {
    Text = "Completa \"Fiore della Rinascita\" a qualsiasi difficoltà"
  },
  Task_49381_Desc = {
    Text = "Desiderio Caotico: Ricostituzione"
  },
  Task_49382_Desc = {
    Text = "Completa tutti gli obiettivi di \"Desiderio Caotico: Completato\""
  },
  Task_49383_Desc = {
    Text = "Desiderio Caotico: Completato"
  },
  Task_49384_Desc = {
    Text = "Completa \"Dono del Seme\" a qualsiasi difficoltà"
  },
  Task_49385_Desc = {
    Text = "Completa \"Frutti Caduti\" a qualsiasi difficoltà"
  },
  Task_49386_Desc = {
    Text = "Effettua 30 Ricostituzioni in \"Desiderio Caotico\""
  },
  Task_49387_Desc = {
    Text = "Completa \"Bagliore del Nettare\" a qualsiasi difficoltà"
  },
  Task_49388_Desc = {
    Text = "Effettua 10 Ricostituzioni in \"Desiderio Caotico\""
  },
  Task_49389_Desc = {
    Text = "Completa \"Radici Nascenti\" a qualsiasi difficoltà"
  },
  Task_49390_Desc = {
    Text = "Completa \"Speranza Germogliante\" a qualsiasi difficoltà"
  },
  Task_49391_Desc = {
    Text = "Effettua 20 Ricostituzioni in \"Desiderio Caotico\""
  },
  Task_49392_Desc = {
    Text = "Effettua 50 Ricostituzioni in \"Desiderio Caotico\""
  },
  Task_49393_Desc = {
    Text = "Effettua 40 Ricostituzioni in \"Desiderio Caotico\""
  },
  Task_49394_Desc = {
    Text = "Completa \"Abbraccio del Calice\" a qualsiasi difficoltà"
  },
  Task_49395_Desc = {
    Text = "Completa \"Scintilla dell'Ovulo\" a qualsiasi difficoltà"
  },
  Task_49396_Desc = {
    Text = "Completa \"Danza del polline\" a qualsiasi difficoltà"
  },
  Task_49397_Desc = {
    Text = "Completa \"Anelli di Crescita\" a qualsiasi difficoltà"
  },
  Task_49769_Desc = {
    Text = "In un turno della Battaglia finale, accumulare uno Scudo del Personaggio pari ad almeno il 50% della Salute massima."
  },
  Task_49769_Name = {
    Text = "Corpo d'Acciaio"
  },
  Task_49770_Desc = {
    Text = "Infliggi almeno 3000 punti di Danno in un turno durante una battaglia Élite."
  },
  Task_49770_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_49771_Desc = {
    Text = "Sconfiggere almeno 2 mostri in un round di una qualsiasi battaglia"
  },
  Task_49771_Name = {
    Text = "Sradicare e Recidere"
  },
  Task_49772_Desc = {
    Text = "Portare almeno 1 Reliquia maledetta al completamento."
  },
  Task_49772_Name = {
    Text = "Scorta segreta"
  },
  Task_49773_Desc = {
    Text = "Ottenere almeno 4 tipi diversi di Orazioni"
  },
  Task_49773_Name = {
    Text = "Marchio dell'Anima"
  },
  Task_49774_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_49774_Name = {
    Text = "Elegante e Preciso"
  },
  Task_49775_Desc = {
    Text = "Gioca almeno 7 Carte in un turno durante la Battaglia finale."
  },
  Task_49775_Name = {
    Text = "Tocca a me!"
  },
  Task_49776_Desc = {
    Text = "Risveglia tutti i Risvegliatori al completamento"
  },
  Task_49776_Name = {
    Text = "Abbraccio Infinito"
  },
  Task_49777_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_49777_Name = {
    Text = "Risparmio Energetico"
  },
  Task_49778_Desc = {
    Text = "Sconfiggere almeno 2 mostri in un round di una qualsiasi battaglia"
  },
  Task_49778_Name = {
    Text = "Sradicare e Recidere"
  },
  Task_49779_Desc = {
    Text = "Portare almeno 1 Reliquia maledetta al completamento."
  },
  Task_49779_Name = {
    Text = "Scorta segreta"
  },
  Task_49780_Desc = {
    Text = "Ottenere almeno 4 tipi diversi di Orazioni"
  },
  Task_49780_Name = {
    Text = "Marchio dell'Anima"
  },
  Task_49781_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_49781_Name = {
    Text = "Elegante e Preciso"
  },
  Task_49782_Desc = {
    Text = "Gioca almeno 7 Carte in un turno durante la Battaglia finale."
  },
  Task_49782_Name = {
    Text = "Tocca a me!"
  },
  Task_49783_Desc = {
    Text = "Risveglia tutti i Risvegliatori al completamento"
  },
  Task_49783_Name = {
    Text = "Abbraccio Infinito"
  },
  Task_49784_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_49784_Name = {
    Text = "Risparmio Energetico"
  },
  Task_49785_Desc = {
    Text = "In un turno della Battaglia finale, accumulare uno Scudo del Personaggio pari ad almeno il 50% della Salute massima."
  },
  Task_49785_Name = {
    Text = "Corpo d'Acciaio"
  },
  Task_49786_Desc = {
    Text = "Infliggi almeno 4500 punti di Danno in un singolo turno durante una battaglia Élite."
  },
  Task_49786_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_49787_Desc = {
    Text = "Infliggi almeno 7300 punti di Danno in un turno durante una battaglia Élite."
  },
  Task_49787_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_49788_Desc = {
    Text = "Ottenere almeno 6 tipi diversi di Orazioni"
  },
  Task_49788_Name = {
    Text = "Marchio dell'Anima"
  },
  Task_49789_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_49789_Name = {
    Text = "Elegante e Preciso"
  },
  Task_49790_Desc = {
    Text = "Portare almeno 7 Reliquie al completamento"
  },
  Task_49790_Name = {
    Text = "Scorta segreta"
  },
  Task_49791_Desc = {
    Text = "Nessun recupero vita dalla Giunzione al completamento"
  },
  Task_49791_Name = {
    Text = "Il Senza Fiamma"
  },
  Task_49792_Desc = {
    Text = "Infliggi almeno 9000 punti di Danno in un singolo turno durante una battaglia Élite."
  },
  Task_49792_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_49793_Desc = {
    Text = "Ottenere almeno 6 tipi diversi di Orazioni"
  },
  Task_49793_Name = {
    Text = "Marchio dell'Anima"
  },
  Task_49794_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_49794_Name = {
    Text = "Elegante e Preciso"
  },
  Task_49795_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_49795_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_49796_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_49796_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_49797_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_49797_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_49798_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_49798_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_49799_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_49799_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_49800_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_49800_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_49801_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_49801_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_49802_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_49802_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_49803_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_49803_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_49804_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_49804_Name = {
    Text = "Superamento Perfetto"
  },
  Task_49805_Desc = {
    Text = "Portare almeno 7 Reliquie al completamento"
  },
  Task_49805_Name = {
    Text = "Scorta segreta"
  },
  Task_49806_Desc = {
    Text = "Nessun recupero vita dalla Giunzione al completamento"
  },
  Task_49806_Name = {
    Text = "Il Senza Fiamma"
  },
  Task_49807_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_49807_Name = {
    Text = "Superamento Perfetto"
  },
  Task_49808_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_49808_Name = {
    Text = "Superamento Perfetto"
  },
  Task_49809_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_49809_Name = {
    Text = "Superamento Perfetto"
  },
  Task_49810_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_49810_Name = {
    Text = "Superamento Perfetto"
  },
  Task_49811_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_49811_Name = {
    Text = "Superamento Perfetto"
  },
  Task_49812_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_49812_Name = {
    Text = "Superamento Perfetto"
  },
  Task_49813_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_49813_Name = {
    Text = "Superamento Perfetto"
  },
  Task_49814_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_49814_Name = {
    Text = "Superamento Perfetto"
  },
  Task_49815_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_49815_Name = {
    Text = "Superamento Perfetto"
  },
  Task_49816_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_49816_Name = {
    Text = "Superamento Perfetto"
  },
  Task_49817_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_49817_Name = {
    Text = "Risparmio Energetico"
  },
  Task_49818_Desc = {
    Text = "Uccidi almeno 4 Mostri in un singolo turno durante la Battaglia finale."
  },
  Task_49818_Name = {
    Text = "Sradicare e Recidere"
  },
  Task_49819_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_49819_Name = {
    Text = "Risparmio Energetico"
  },
  Task_49820_Desc = {
    Text = "Uccidi almeno 4 Mostri in un singolo turno durante la Battaglia finale."
  },
  Task_49820_Name = {
    Text = "Sradicare e Recidere"
  },
  Task_49821_Desc = {
    Text = "Vinci la Battaglia finale entro 18 turni"
  },
  Task_49821_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_49822_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_49822_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_49823_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_49823_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_49824_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_49824_Name = {
    Text = "Superamento Perfetto"
  },
  Task_49852_Desc = {
    Text = "Nubia: Completato l'Accampamento della Minaccia"
  },
  Task_49852_Name = {Text = "Bersaglio"},
  Task_49853_Desc = {
    Text = "Attraversare il Muro della Tempesta"
  },
  Task_49853_Name = {Text = "Bersaglio"},
  Task_49854_Desc = {
    Text = "Rapire i Soldati di Aram per trovare le Spoglie"
  },
  Task_49854_Name = {Text = "Bersaglio"},
  Task_49855_Desc = {
    Text = "Trova la Sorgente d'Acqua"
  },
  Task_49855_Name = {Text = "Bersaglio"},
  Task_49856_Desc = {
    Text = "Sconfiggi Casiah e recupera lo Scheletro."
  },
  Task_49856_Name = {Text = "Bersaglio"},
  Task_49857_Desc = {
    Text = "Combatti al fianco di Thais"
  },
  Task_49857_Name = {Text = "Bersaglio"},
  Task_49858_Desc = {
    Text = "Sfuggire alla presa di Casiah"
  },
  Task_49858_Name = {Text = "Bersaglio"},
  Task_49859_Desc = {
    Text = "Fermare il Rito di Resurrezione dell'Albero Madre"
  },
  Task_49859_Name = {Text = "Bersaglio"},
  Task_49860_Desc = {
    Text = "Immergiti nel Mare di Coscienza dell'Albero Madre"
  },
  Task_49860_Name = {Text = "Bersaglio"},
  Task_49861_Desc = {
    Text = "Aiuta gli Aram a scacciare i Nubiani"
  },
  Task_49861_Name = {Text = "Bersaglio"},
  Task_49862_Desc = {
    Text = "Cerca lo Scheletro dell'Albero Madre"
  },
  Task_49862_Name = {Text = "Bersaglio"},
  Task_49863_Desc = {
    Text = "Sconfiggere l'Albero Madre"
  },
  Task_49863_Name = {Text = "Bersaglio"},
  Task_49879_Desc = {
    Text = "L'Affinità di Ramona: Timeworn raggiunge il Livello 10"
  },
  Task_50033_Desc = {
    Text = "Risuona 6 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_50033_Desc2 = {
    Text = "Risuona 6 volte nell'Evento d'Indagine \"Fiume del Desiderio\""
  },
  Task_50033_Name2 = {
    Text = "Eco del Delirio II"
  },
  Task_50034_Desc = {
    Text = "Risuona 9 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_50034_Desc2 = {
    Text = "Risuona 9 volte nell'Evento d'Indagine \"Fiume del Desiderio\""
  },
  Task_50034_Name2 = {
    Text = "Eco del Delirio III"
  },
  Task_50035_Desc = {
    Text = "Trova 12 Punti di Estrazione nel Capitolo 7 della storia principale \"@1@2\""
  },
  Task_50035_Desc2 = {
    Text = "Trova 12 Punti di Estrazione nel Capitolo 7 \"Fiume del Desiderio\" della storia principale."
  },
  Task_50035_Name2 = {
    Text = "Sussurro celato VII"
  },
  Task_50036_Desc = {
    Text = "Risuona 3 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_50036_Desc2 = {
    Text = "Risuona 3 volte nell'Evento d'Indagine \"Fiume del Desiderio\""
  },
  Task_50036_Name2 = {
    Text = "Eco del Delirio"
  },
  Task_50037_Desc = {
    Text = "Completa l'evento d'indagine \"@1@2\""
  },
  Task_50037_Desc2 = {
    Text = "Completa l'Evento d'Indagine \"Fiume del Desiderio\""
  },
  Task_50037_Name2 = {
    Text = "Quando l'Albero Sacro Brucia"
  },
  Task_50038_Desc = {
    Text = "Completa l'Evento d'Indagine \"Fiume del Desiderio\" a difficoltà Difficile"
  },
  Task_50038_Name = {
    Text = "Quando l'Albero Sacro Brucia: Hard"
  },
  Task_50039_Desc = {
    Text = "Ottieni 11 Risonanze nell'Evento d'Indagine \"@1@2\""
  },
  Task_50039_Desc2 = {
    Text = "Ottieni 11 Risonanze nell'Evento d'Indagine \"Fiume del Desiderio\""
  },
  Task_50039_Name2 = {
    Text = "Eco del Delirio IV"
  },
  Task_51106_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere due volte in \"Mistero Ordito\""
  },
  Task_51107_Desc = {
    Text = "Completa tutte le missioni in \"Mistero Ordito: Completamento\""
  },
  Task_51108_Desc = {
    Text = "Completamento di \"Rotazione della Trama\" a qualsiasi difficoltà"
  },
  Task_51109_Desc = {
    Text = "Registro Operazioni Speciali"
  },
  Task_51109_Name = {
    Text = "[Discarded]"
  },
  Task_51110_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere una volta in \"Mistero Ordito\""
  },
  Task_51111_Desc = {
    Text = "Mistero Ordito: Reame"
  },
  Task_51112_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere una volta in \"Mistero Ordito\""
  },
  Task_51113_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere due volte in \"Mistero Ordito\""
  },
  Task_51114_Desc = {
    Text = "Completamento di \"Catarsi\" a qualsiasi difficoltà"
  },
  Task_51115_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere due volte in \"Mistero Ordito\""
  },
  Task_51116_Desc = {
    Text = "Completamento di \"Farsa Mascherata\" a qualsiasi difficoltà"
  },
  Task_51117_Desc = {
    Text = "Completamento di \"Unità Classiche\" a qualsiasi difficoltà"
  },
  Task_51118_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere una volta in \"Mistero Ordito\""
  },
  Task_51119_Desc = {
    Text = "Completamento di \"Teorema dell'Arco\" a qualsiasi difficoltà"
  },
  Task_51120_Desc = {
    Text = "Completamento di \"Apice del Dramma\" a qualsiasi difficoltà"
  },
  Task_51121_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per vincere una volta in \"Mistero Ordito\""
  },
  Task_51122_Desc = {
    Text = "Completamento di \"La Quarta Parete\" a qualsiasi difficoltà"
  },
  Task_51123_Desc = {
    Text = "Completamento di \"Effetto di Straniamento\" a qualsiasi difficoltà"
  },
  Task_51124_Desc = {
    Text = "Mistero Ordito: Completamento"
  },
  Task_51125_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per vincere due volte in \"Mistero Ordito\""
  },
  Task_51126_Desc = {
    Text = "Completamento di \"Istante di Quiete\" a qualsiasi difficoltà"
  },
  Task_51140_Desc = {
    Text = "Completamento del Registro Operazioni Speciali \"La Magia delle Storie\""
  },
  Task_51141_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_51141_Name = {
    Text = "[Discarded]"
  },
  Task_51142_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_51142_Name = {
    Text = "[Discarded]"
  },
  Task_51143_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_51143_Name = {
    Text = "[Discarded]"
  },
  Task_51144_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_51144_Name = {
    Text = "[Discarded]"
  },
  Task_51145_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_51145_Name = {
    Text = "[Discarded]"
  },
  Task_51146_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_51146_Name = {
    Text = "[Discarded]"
  },
  Task_52280_Desc = {
    Text = "Effettua un Sacrificio all'\"Altare delle Lacrime\" 100 volte"
  },
  Task_52281_Desc = {
    Text = "Effettua un Sacrificio all'\"Altare delle Lacrime\" 200 volte"
  },
  Task_52282_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame del Caos per vincere due volte in \"Sacrificio abissale\""
  },
  Task_52283_Desc = {
    Text = "Sacrificio abissale: Completato"
  },
  Task_52284_Desc = {
    Text = "Completa \"Testimone Silenzioso\" a qualsiasi difficoltà"
  },
  Task_52285_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame di Aequor per vincere una volta in \"Sacrificio abissale\""
  },
  Task_52286_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame di Aequor per vincere due volte in \"Sacrificio abissale\""
  },
  Task_52287_Desc = {
    Text = "Completa \"Cuore Devoto\" a qualsiasi difficoltà"
  },
  Task_52288_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame del Caos per vincere una volta in \"Sacrificio abissale\""
  },
  Task_52289_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame di Caro per vincere una volta in \"Sacrificio abissale\""
  },
  Task_52290_Desc = {
    Text = "Sacrificio abissale: Reame"
  },
  Task_52291_Desc = {
    Text = "Completa il Paesaggio Onirico \"Profanazione\""
  },
  Task_52292_Desc = {
    Text = "Effettua un Sacrificio all'\"Altare del Sangue\" 100 volte"
  },
  Task_52293_Desc = {
    Text = "Effettua un Sacrificio all'\"Altare del Sangue\" 200 volte"
  },
  Task_52294_Desc = {
    Text = "Effettua un Sacrificio all'\"Altare delle Anime\" 200 volte"
  },
  Task_52295_Desc = {
    Text = "Effettua un Sacrificio all'\"Altare delle Anime\" 100 volte"
  },
  Task_52296_Desc = {
    Text = "Completa \"Dubbio Eterno\" a qualsiasi difficoltà"
  },
  Task_52297_Desc = {
    Text = "Completa \"Tremore\" a qualsiasi difficoltà"
  },
  Task_52298_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame di Caro per vincere due volte in \"Sacrificio abissale\""
  },
  Task_52299_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere una volta in \"Sacrificio abissale\""
  },
  Task_52300_Desc = {
    Text = "Completa \"L'Avvento\" a qualsiasi difficoltà"
  },
  Task_52301_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere due volte in \"Sacrificio abissale\""
  },
  Task_52302_Desc = {
    Text = "Risposta dell'Abisso"
  },
  Task_52303_Desc = {
    Text = "Completa tutte le missioni in \"Sacrificio abissale: Completato\" e \"Risposta dell'Abisso\""
  },
  Task_53694_Desc = {
    Text = "Gli Ioni attivi raffinati raggiungono 1000"
  },
  Task_53695_Desc = {
    Text = "Completa 20 Incarichi"
  },
  Task_53696_Desc = {
    Text = "Giorno del Rientro 1"
  },
  Task_53697_Desc = {
    Text = "Vinci 3 volte con il Risvegliatore del Caos"
  },
  Task_53698_Desc = {
    Text = "Metti Mi piace a 10 altri Custodi"
  },
  Task_53699_Desc = {
    Text = "Giorno del Rientro 6"
  },
  Task_53700_Desc = {
    Text = "Giorno del Rientro 5"
  },
  Task_53701_Desc = {Text = "Giorno 4"},
  Task_53702_Desc = {Text = "Giorno 2"},
  Task_53703_Desc = {Text = "Giorno 3"},
  Task_53704_Desc = {Text = "Giorno 1"},
  Task_53705_Desc = {
    Text = "Vinci 3 volte con il Risvegliatore del Reame Ultra"
  },
  Task_53706_Desc = {
    Text = "Giorno del Rientro 4"
  },
  Task_53707_Desc = {
    Text = "Vinci 3 volte con il Risvegliatore di Caro"
  },
  Task_53708_Desc = {
    Text = "Vinci 3 volte con il Risvegliatore di Aequor"
  },
  Task_53709_Desc = {
    Text = "Giorno del Rientro 2"
  },
  Task_53710_Desc = {
    Text = "Potenzia un Risvegliatore una volta"
  },
  Task_53711_Desc = {
    Text = "Consuma 50000 Scrip di Rosa"
  },
  Task_53712_Desc = {
    Text = "Consuma 1500 Menofina"
  },
  Task_53713_Desc = {
    Text = "Ottieni 500 Ioni attivi raffinati"
  },
  Task_53714_Desc = {
    Text = "Consuma 500.000 Certificati Rosa"
  },
  Task_53715_Desc = {
    Text = "Esegui 20 Risvegli"
  },
  Task_53716_Desc = {
    Text = "Completamento del Reame Senza Luce o del Dominio Arcano una volta"
  },
  Task_53717_Desc = {
    Text = "Usa Risvegliatori di supporto 10 volte"
  },
  Task_53718_Desc = {
    Text = "Giorno del Rientro 3"
  },
  Task_53719_Desc = {
    Text = "Usa i Risvegliatori di Supporto una volta"
  },
  Task_53720_Desc = {
    Text = "Acquista con Certificati Rosa 3 volte"
  },
  Task_53721_Desc = {
    Text = "Consuma 180 Menofina"
  },
  Task_53722_Desc = {
    Text = "Esegui 3 Incarichi"
  },
  Task_53723_Desc = {
    Text = "Giorno del Rientro 7"
  },
  Task_53724_Desc = {
    Text = "Ottieni 1000 Ioni attivi base"
  },
  Task_53725_Desc = {
    Text = "Completa 1 Livello di Prova del Risvegliatore"
  },
  Task_53726_Desc = {
    Text = "Esegui 1 Risveglio"
  },
  Task_53982_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere una volta in \"Memorie di Rosa\""
  },
  Task_53983_Desc = {
    Text = "Completamento di \"Gioco del Burattino\" a qualsiasi difficoltà"
  },
  Task_53984_Desc = {
    Text = "Completamento di \"Lo Sguardo\" a qualsiasi difficoltà"
  },
  Task_53985_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per vincere due volte in \"Memorie di Rosa\""
  },
  Task_53986_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per vincere una volta in \"Memorie di Rosa\""
  },
  Task_53987_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere due volte in \"Memorie di Rosa\""
  },
  Task_53988_Desc = {
    Text = "Memorie di Rosa: Reame"
  },
  Task_53989_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere una volta in \"Memorie di Rosa\""
  },
  Task_53990_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere due volte in \"Memorie di Rosa\""
  },
  Task_53991_Desc = {
    Text = "Si sblocca dopo aver completato tutte le missioni di \"Memorie di Rosa: Completamento\""
  },
  Task_53992_Desc = {
    Text = "Completamento di \"Copione Incompiuto\" a qualsiasi difficoltà"
  },
  Task_53993_Desc = {
    Text = "Vinci una volta in \"Memorie della Rosa\" usando un qualsiasi Risvegliatore del Reame Ultra"
  },
  Task_53994_Desc = {
    Text = "Completamento di \"Angolo delle Rose\" a qualsiasi difficoltà"
  },
  Task_53995_Desc = {
    Text = "Memorie di Rosa: Completamento"
  },
  Task_53996_Desc = {
    Text = "Vinci due volte in \"Memorie della Rosa\" usando un qualsiasi Risvegliatore del Reame Ultra"
  },
  Task_53997_Desc = {
    Text = "Completamento di \"Papà Gambalunga\" a qualsiasi difficoltà"
  },
  Task_53998_Desc = {
    Text = "Completamento di \"Un Dono\" a qualsiasi difficoltà"
  },
  Task_53999_Desc = {
    Text = "Completamento di \"Fine Ultima\" a qualsiasi difficoltà"
  },
  Task_54000_Desc = {
    Text = "Completamento di \"Pesci sul fondo del calderone\" a qualsiasi difficoltà"
  },
  Task_54001_Desc = {
    Text = "Completamento di \"Il Volto\" a qualsiasi difficoltà"
  },
  Task_54542_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_54542_Name = {Text = "1 vittoria"},
  Task_54543_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_54543_Name = {Text = "6 vittorie"},
  Task_54544_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_54544_Name = {Text = "3 vittorie"},
  Task_54545_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_54545_Name = {
    Text = "10 vittorie"
  },
  Task_54546_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_54546_Name = {Text = "1 vittoria"},
  Task_54547_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_54547_Name = {
    Text = "10 vittorie"
  },
  Task_54548_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_54548_Name = {
    Text = "10 vittorie"
  },
  Task_54549_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_54549_Name = {Text = "6 vittorie"},
  Task_54550_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_54550_Name = {Text = "1 vittoria"},
  Task_54551_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_54551_Name = {Text = "3 vittorie"},
  Task_54552_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_54552_Name = {Text = "6 vittorie"},
  Task_54553_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_54553_Name = {Text = "3 vittorie"},
  Task_54554_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_54554_Name = {Text = "6 vittorie"},
  Task_54555_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_54555_Name = {Text = "1 vittoria"},
  Task_54556_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_54556_Name = {
    Text = "10 vittorie"
  },
  Task_54557_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_54557_Name = {Text = "3 vittorie"},
  Task_54585_Desc = {
    Text = "Estrai 1000 Essenza di Silver Core"
  },
  Task_54586_Desc = {
    Text = "Estrai 3000 Essenza di Silver Core"
  },
  Task_54587_Desc = {
    Text = "Estrai 6000 Essenza di Silver Core"
  },
  Task_54588_Desc = {
    Text = "Estrai 10000 Essenza di Silver Core"
  },
  Task_54589_Desc = {
    Text = "Estrai 30000 Essenza di Silver Core"
  },
  Task_54590_Desc = {
    Text = "Estrai 60000 Essenza di Silver Core"
  },
  Task_54591_Desc = {
    Text = "Estrai 100000 Essenza di Silver Core"
  },
  Task_55092_Desc = {
    Text = "Completa tutte le missioni di questo capitolo per ottenere le ricompense."
  },
  Task_55092_Name = {
    Text = "Padronanza del Reame VII"
  },
  Task_55093_Desc = {
    Text = "Completa tutte le missioni di questo capitolo per ottenere le ricompense."
  },
  Task_55093_Name = {
    Text = "Padronanza del Reame VI"
  },
  Task_55094_Desc = {
    Text = "Porta 3 personaggi Caro al Livello 60"
  },
  Task_55094_Name = {
    Text = "Padronanza del Reame VII"
  },
  Task_55095_Desc = {
    Text = "Porta 3 personaggi Aequor al Livello 60"
  },
  Task_55095_Name = {
    Text = "Padronanza del Reame VII"
  },
  Task_55096_Desc = {
    Text = "Porta 3 personaggi Caos al Livello 60"
  },
  Task_55096_Name = {
    Text = "Padronanza del Reame VII"
  },
  Task_55097_Desc = {
    Text = "Completa tutte le missioni di questo capitolo per ottenere le ricompense."
  },
  Task_55097_Name = {
    Text = "Padronanza del Reame VIII"
  },
  Task_55098_Desc = {
    Text = "Porta 3 personaggi Ultra al Livello 60"
  },
  Task_55098_Name = {
    Text = "Padronanza del Reame VII"
  },
  Task_55099_Desc = {
    Text = "Porta 1 personaggio Ultra al Livello 60"
  },
  Task_55099_Name = {
    Text = "Padronanza del Reame VI"
  },
  Task_55100_Desc = {
    Text = "Porta 1 personaggio Caos al Livello 60"
  },
  Task_55100_Name = {
    Text = "Padronanza del Reame VI"
  },
  Task_55101_Desc = {
    Text = "Porta 1 personaggio Aequor al Livello 60"
  },
  Task_55101_Name = {
    Text = "Padronanza del Reame VI"
  },
  Task_55102_Desc = {
    Text = "Porta 1 personaggio Caro al Livello 60"
  },
  Task_55102_Name = {
    Text = "Padronanza del Reame VI"
  },
  Task_55103_Desc = {
    Text = "Porta 6 personaggi Ultra al Livello 60"
  },
  Task_55103_Name = {
    Text = "Padronanza del Reame VIII"
  },
  Task_55104_Desc = {
    Text = "Porta 6 personaggi Aequor al Livello 60"
  },
  Task_55104_Name = {
    Text = "Padronanza del Reame VIII"
  },
  Task_55105_Desc = {
    Text = "Porta 6 personaggi Caro al Livello 60"
  },
  Task_55105_Name = {
    Text = "Padronanza del Reame VIII"
  },
  Task_55106_Desc = {
    Text = "Porta 6 personaggi Caos al Livello 60"
  },
  Task_55106_Name = {
    Text = "Padronanza del Reame VIII"
  },
  Task_55177_Desc = {
    Text = "Completa tutti i compiti in \"Giardino dei Ricordi: Completato\""
  },
  Task_55178_Desc = {
    Text = "Giardino dei Ricordi: Reame"
  },
  Task_55179_Desc = {
    Text = "La Serra di Colette"
  },
  Task_55180_Desc = {
    Text = "Vinci 2 volte nel \"Giardino dei Ricordi\" usando il Risveglio del Reame del Caos"
  },
  Task_55181_Desc = {
    Text = "Completa \"Regno Minuscolo\" a qualsiasi difficoltà"
  },
  Task_55182_Desc = {
    Text = "Vinci 1 volta nel \"Giardino dei Ricordi\" usando il Risveglio del Reame del Caos"
  },
  Task_55183_Desc = {
    Text = "Giardino dei Ricordi: Completato"
  },
  Task_55184_Desc = {
    Text = "Completa \"Versi in Fiamme\" a qualsiasi difficoltà"
  },
  Task_55185_Desc = {
    Text = "Effettua 100 scambi nel \"Giardino di rose\""
  },
  Task_55186_Desc = {
    Text = "Effettua 200 scambi nel \"Giardino di rose\""
  },
  Task_55187_Desc = {
    Text = "Completa \"Ceneri Residue\" a qualsiasi difficoltà"
  },
  Task_55188_Desc = {
    Text = "Usa il Risveglio del Reame di Caro per vincere due volte nei \"Giardini del Passato\"."
  },
  Task_55189_Desc = {
    Text = "Effettua 200 scambi nel \"Giardino delle campanule\""
  },
  Task_55190_Desc = {
    Text = "Effettua 100 scambi nel \"Giardino delle campanule\""
  },
  Task_55191_Desc = {
    Text = "Vinci 1 volta nel \"Giardino dei Ricordi\" usando il Risveglio del Reame di Caro"
  },
  Task_55192_Desc = {
    Text = "Completa il Registro Operazioni Speciali \"Dimora della Rosa\""
  },
  Task_55193_Desc = {
    Text = "Completa \"Mani Intrecciate\" a qualsiasi difficoltà"
  },
  Task_55194_Desc = {
    Text = "Completa \"Prima Fioritura\" a qualsiasi difficoltà"
  },
  Task_55195_Desc = {
    Text = "Effettua 200 scambi nel \"Giardino degli iris\""
  },
  Task_55196_Desc = {
    Text = "Usa il Risveglio del Reame Ultra per vincere una volta nei \"Giardini del Passato\""
  },
  Task_55197_Desc = {
    Text = "Usa il Risveglio del Reame Ultra per vincere due volte nella \"Rimembranza del Giardino\"."
  },
  Task_55198_Desc = {
    Text = "Vinci 2 volte nel \"Giardino dei Ricordi\" usando il Risveglio del Reame di Aequor"
  },
  Task_55199_Desc = {
    Text = "Vinci 1 volta nel \"Giardino dei Ricordi\" usando il Risveglio del Reame di Aequor"
  },
  Task_55200_Desc = {
    Text = "Effettua 100 scambi nel \"Giardino degli iris\""
  },
  Task_55426_Desc = {
    Text = "Sconfiggi Colette"
  },
  Task_55426_Name = {Text = "Bersaglio"},
  Task_55852_Desc = {
    Text = "Porta 1 Risvegliatore al Lv. 70"
  },
  Task_55852_Name = {Text = "Compito 2"},
  Task_55853_Desc = {
    Text = "Completa il Capitolo 7 della Storia Principale: Normale"
  },
  Task_55853_Name = {Text = "Compito 3"},
  Task_55854_Desc = {
    Text = "Porta 4 Risvegliatori al Lv. 62"
  },
  Task_55854_Name = {Text = "Compito 1"},
  Task_55855_Desc = {
    Text = "Illumina un qualsiasi Risvegliatore a Impulso della Psiche 4"
  },
  Task_55855_Name = {Text = "Compito 4"},
  Task_55856_Desc = {
    Text = "Ottieni 150 Punti Addestramento nella Zona D-Effetto"
  },
  Task_55856_Name = {Text = "Compito 5"},
  Task_55857_Desc = {
    Text = "Completa tutti i compiti per riscuotere le ricompense"
  },
  Task_55857_Name = {Text = "Fase VIII"},
  Task_55858_Desc = {
    Text = "Completa tutti i compiti per riscuotere le ricompense"
  },
  Task_55858_Name = {Text = "Fase VII"},
  Task_55859_Desc = {
    Text = "Porta 1 Risvegliatore al Lv. 62"
  },
  Task_55859_Name = {Text = "Compito 2"},
  Task_55860_Desc = {
    Text = "Completa il Capitolo 6 della Storia Principale: Normale"
  },
  Task_55860_Name = {Text = "Compito 3"},
  Task_55861_Desc = {
    Text = "Potenzia una qualsiasi Abilità di un Risvegliatore al Lv. 6"
  },
  Task_55861_Name = {Text = "Compito 1"},
  Task_55862_Desc = {
    Text = "Attiva il Talento di un qualsiasi Risvegliatore una volta"
  },
  Task_55862_Name = {Text = "Compito 4"},
  Task_55863_Desc = {
    Text = "Ottieni 50 Punti Addestramento nella Zona D-Effetto"
  },
  Task_55863_Name = {Text = "Compito 5"},
  Task_56002_Desc = {
    Text = "Completa l'Immersione Psichica \"La Caduta di un Gigante\" a difficoltà ardua"
  },
  Task_56002_Name = {
    Text = "Ferocia Impareggiabile: Hard"
  },
  Task_56003_Desc = {
    Text = "Completa l'Immersione Psichica \"Eadem Omnia\" a difficoltà ardua"
  },
  Task_56003_Name = {
    Text = "La Città Invisibile: Hard"
  },
  Task_56004_Desc = {
    Text = "Completa l'Immersione Psichica \"La Caduta di un Gigante\""
  },
  Task_56004_Name = {
    Text = "Ferocia Impareggiabile"
  },
  Task_56005_Desc = {
    Text = "Completa il record speciale \"Scissione Tranquilla\" in difficoltà Difficile"
  },
  Task_56005_Name = {
    Text = "Ritorno alla Sorgente del Fiume: Hard"
  },
  Task_56006_Desc = {
    Text = "Completa il registro speciale \"Colore del Sangue\" a difficoltà Difficile"
  },
  Task_56006_Name = {
    Text = "Clemenza Eterna: Hard"
  },
  Task_56007_Desc = {
    Text = "Completa il registro speciale \"Scissione Tranquilla\""
  },
  Task_56007_Name = {
    Text = "Ritorno alla Sorgente del Fiume"
  },
  Task_56008_Desc = {
    Text = "Completa il registro speciale \"Colore del Sangue\""
  },
  Task_56008_Name = {
    Text = "Clemenza Eterna"
  },
  Task_56009_Desc = {
    Text = "Completa la \"Profanazione\" nel Paesaggio Onirico"
  },
  Task_56009_Name = {
    Text = "Fanatismo Distorto"
  },
  Task_56103_Desc = {
    Text = "Infliggi 50000 accumuli di Veleno al nemico"
  },
  Task_56103_Name = {
    Text = "Veleno della Realtà III"
  },
  Task_56104_Desc = {
    Text = "Applica 100000 accumuli di Veleno al nemico"
  },
  Task_56104_Name = {
    Text = "Veleno della Realtà IV"
  },
  Task_56106_Desc = {
    Text = "Possiedi 6 Risvegliati a Livello 80"
  },
  Task_56106_Name = {
    Text = "\"Potere Trascendente\" V"
  },
  Task_56107_Desc = {
    Text = "Completa il Paesaggio Onirico \"Oltre l'Orizzonte: Parte Superiore\""
  },
  Task_56107_Name = {Text = "La Discesa"},
  Task_56108_Desc = {
    Text = "Completa 200 Immersioni Fantasmatiche"
  },
  Task_56108_Name = {
    Text = "Viaggio nel Cuore del Sogno"
  },
  Task_56109_Desc = {
    Text = "Completa 300 Immersioni Fantasmatiche"
  },
  Task_56109_Name = {
    Text = "Camminatore dei Sogni"
  },
  Task_56110_Desc = {
    Text = "Completa 500 Immersioni Fantasmatiche"
  },
  Task_56110_Name = {
    Text = "Tessitore di sogni"
  },
  Task_56111_Desc = {
    Text = "Possiedi 8 Risvegliati a Livello 80"
  },
  Task_56111_Name = {
    Text = "\"Potere Trascendente\"VI"
  },
  Task_56112_Desc = {
    Text = "Possiedi 10 Risvegliati a Livello 80"
  },
  Task_56112_Name = {
    Text = "\"Potere Trascendente\" VII"
  },
  Task_56113_Desc = {
    Text = "Raggiungi il Livello di Affinità 10 con 8 Risvegliatori"
  },
  Task_56113_Name = {
    Text = "Incontrarsi come Vecchi Amici"
  },
  Task_56115_Desc = {
    Text = "Sintetizza materiali 11111 volte"
  },
  Task_56115_Name = {
    Text = "Il Crogiolo in Corsa di Mythag"
  },
  Task_56116_Desc = {
    Text = "Possiedi 200 Patti di Livello 12"
  },
  Task_56116_Name = {
    Text = "Guardiano del Tabù IV"
  },
  Task_56117_Desc = {
    Text = "Raggiungi il Livello di Affinità 10 con 4 Risvegliati"
  },
  Task_56117_Name = {
    Text = "Partner Affiatati IX"
  },
  Task_56118_Desc = {
    Text = "Potenzia le Abilità dei Risvegliati 400 volte"
  },
  Task_56118_Name = {
    Text = "\"Maestria delle Armi\" I"
  },
  Task_56120_Desc = {
    Text = "Possiedi 30 Risvegliati a Livello 80"
  },
  Task_56120_Name = {
    Text = "Sfida al Nulla III"
  },
  Task_56121_Desc = {
    Text = "Possiedi 25 Risvegliati a Livello 80"
  },
  Task_56121_Name = {
    Text = "Sfida al Nulla II"
  },
  Task_56122_Desc = {
    Text = "Possiedi 20 Risvegliati a Livello 80"
  },
  Task_56122_Name = {
    Text = "Sfida al Nulla I"
  },
  Task_56123_Desc = {
    Text = "Possiedi 15 Risvegliati a Livello 80"
  },
  Task_56123_Name = {
    Text = "\"Potere Trascendente\" VIII"
  },
  Task_56126_Desc = {
    Text = "Possiedi 40 Risvegliati a Livello 80"
  },
  Task_56126_Name = {
    Text = "Sfida al Nulla V"
  },
  Task_56127_Desc = {
    Text = "Possiedi 35 Risvegliati a Livello 80"
  },
  Task_56127_Name = {
    Text = "Sfida al Nulla IV"
  },
  Task_56128_Desc = {
    Text = "Accumula il consumo di 250000 Sigilli Neri"
  },
  Task_56128_Name = {
    Text = "Benve\"nuuuuu\"ti V"
  },
  Task_56129_Desc = {
    Text = "Accumula il consumo di 1000000 di Sigilli Neri"
  },
  Task_56129_Name = {
    Text = "Benve\"nuuuuu\"ti VII"
  },
  Task_56130_Desc = {
    Text = "Accumula il consumo di 500000 Sigilli Neri"
  },
  Task_56130_Name = {
    Text = "Benve\"nuuuuu\"ti VI"
  },
  Task_56131_Desc = {
    Text = "Potenzia le Abilità dei Risvegliati 800 volte"
  },
  Task_56131_Name = {
    Text = "\"Maestria delle Armi\" V"
  },
  Task_56132_Desc = {
    Text = "Potenzia le Abilità dei Risvegliati 700 volte"
  },
  Task_56132_Name = {
    Text = "\"Maestria delle Armi\" IV"
  },
  Task_56133_Desc = {
    Text = "Potenzia le Abilità dei Risvegliati 600 volte"
  },
  Task_56133_Name = {
    Text = "\"Maestria delle Armi\" III"
  },
  Task_56134_Desc = {
    Text = "Potenzia le Abilità dei Risvegliati 500 volte"
  },
  Task_56134_Name = {
    Text = "\"Maestria delle Armi\" II"
  },
  Task_56135_Desc = {
    Text = "Completa 5000 Trascrizioni del Patto"
  },
  Task_56135_Name = {
    Text = "Nero multicolore"
  },
  Task_56136_Desc = {
    Text = "Completa 2500 Trascrizioni del Patto"
  },
  Task_56136_Name = {
    Text = "Cuore Volubile"
  },
  Task_56137_Desc = {
    Text = "Completa 1000 Trascrizioni del Patto"
  },
  Task_56137_Name = {
    Text = "Torniamo alla Bozza!"
  },
  Task_56138_Desc = {
    Text = "Potenzia le Abilità dei Risvegliati 900 volte"
  },
  Task_56138_Name = {
    Text = "\"Maestria delle Armi\" VI"
  },
  Task_56140_Desc = {
    Text = "Completa 10000 Trascrizioni di Patti"
  },
  Task_56140_Name = {
    Text = "Cliente Demoniaco"
  },
  Task_56156_Desc = {
    Text = "Ruota del destino accumulata 800 volte"
  },
  Task_56156_Name = {
    Text = "Futuro a intreccio quantistico II"
  },
  Task_56157_Desc = {
    Text = "Ruota del destino accumulata 900 volte"
  },
  Task_56157_Name = {
    Text = "Futuro a intreccio quantistico III"
  },
  Task_56161_Desc = {
    Text = "L'Affinità di Horla raggiunge il Livello 10"
  },
  Task_56162_Desc = {
    Text = "L'Affinità di Miryam raggiunge il Livello 10"
  },
  Task_56177_Desc = {
    Text = "Ottieni 80 Ruote del Destino diverse"
  },
  Task_56177_Name = {
    Text = "Tessitore di Destini"
  },
  Task_56178_Desc = {
    Text = "Ottieni 70 Ruote del Destino diverse"
  },
  Task_56178_Name = {
    Text = "Signore dell'Incertezza"
  },
  Task_56179_Desc = {
    Text = "Potenzia le Abilità dei Risvegliati 300 volte"
  },
  Task_56179_Name = {
    Text = "\"Maestria delle Armi\" I"
  },
  Task_56180_Desc = {
    Text = "Ruota del destino accumulata 1100 volte"
  },
  Task_56180_Name = {
    Text = "Futuro a intreccio quantistico V"
  },
  Task_56181_Desc = {
    Text = "Ruota del destino accumulata 1200 volte"
  },
  Task_56181_Name = {
    Text = "Futuro a intreccio quantistico VI"
  },
  Task_56182_Desc = {
    Text = "1000 \"Mi piace\""
  },
  Task_56182_Name = {
    Text = "Bandito Sociale"
  },
  Task_56184_Desc = {
    Text = "250 \"Mi piace\""
  },
  Task_56184_Name = {
    Text = "Un Grande Passo Avanti"
  },
  Task_56185_Desc = {
    Text = "500 \"Mi piace\""
  },
  Task_56185_Name = {
    Text = "Un Grande Passo Verso il Mondo"
  },
  Task_56186_Desc = {
    Text = "Smantella 2000 Ruote del destino"
  },
  Task_56186_Name = {
    Text = "Padrone del Destino"
  },
  Task_56187_Desc = {
    Text = "Smantella 1000 Ruote del destino"
  },
  Task_56187_Name = {
    Text = "Afferrare la Gola del Destino"
  },
  Task_56188_Desc = {
    Text = "Ottieni 60 Ruote del Destino diverse"
  },
  Task_56188_Name = {
    Text = "Apprendista del Destino II"
  },
  Task_56189_Desc = {
    Text = "Ottieni 50 Ruote del Destino diverse"
  },
  Task_56189_Name = {
    Text = "Apprendista del Destino I"
  },
  Task_56191_Desc = {
    Text = "Ruota del destino accumulata 1000 volte"
  },
  Task_56191_Name = {
    Text = "Futuro a intreccio quantistico IV"
  },
  Task_56192_Desc = {
    Text = "Smantella 500 Ruote del destino"
  },
  Task_56192_Name = {
    Text = "Sfidare il Destino"
  },
  Task_56349_Desc = {
    Text = "Sconfiggi il boss \"Aigis\"."
  },
  Task_56349_Name = {Text = "Bersaglio"},
  Task_56350_Desc = {
    Text = "Sconfiggi il boss \"Daffodil\"."
  },
  Task_56350_Name = {Text = "Bersaglio"},
  Task_56351_Desc = {
    Text = "Sconfiggi il boss \"Leigh\"."
  },
  Task_56351_Name = {Text = "Bersaglio"},
  Task_56352_Desc = {
    Text = "Sconfiggi il boss \"Horla\"."
  },
  Task_56352_Name = {Text = "Bersaglio"},
  Task_56353_Desc = {
    Text = "Sconfiggi il boss \"\"24\"\"."
  },
  Task_56353_Name = {Text = "Bersaglio"},
  Task_56412_Desc = {
    Text = "Completa \"La Sua Discesa\" a qualsiasi difficoltà"
  },
  Task_56413_Desc = {
    Text = "Completa \"Lama del Boia\" a qualsiasi difficoltà"
  },
  Task_56414_Desc = {
    Text = "Utero Oscuro: Completamento"
  },
  Task_56415_Desc = {
    Text = "Completa \"Velo del Sudario\" a qualsiasi difficoltà"
  },
  Task_56416_Desc = {
    Text = "Utero Oscuro: Reame"
  },
  Task_56417_Desc = {
    Text = "Completa \"Dormienza\" a qualsiasi difficoltà"
  },
  Task_56420_Desc = {
    Text = "Completa \"Sacrificio dell'Agnello\" a qualsiasi difficoltà"
  },
  Task_56421_Desc = {
    Text = "Completa \"Frattura del Tempo\" a qualsiasi difficoltà"
  },
  Task_56422_Desc = {
    Text = "Completa \"Stella Gialla\" a qualsiasi difficoltà"
  },
  Task_57121_Desc = {
    Text = "Completa \"Sacrificio dell'Agnello\" a Difficoltà Follia"
  },
  Task_57122_Desc = {
    Text = "Completa \"Lama del Boia\" a Difficoltà Follia"
  },
  Task_57123_Desc = {
    Text = "Vinci due volte in \"Utero Oscuro\" usando un qualsiasi Risvegliatore di Aequor"
  },
  Task_57124_Desc = {
    Text = "Vinci due volte in \"Utero Oscuro\" usando un qualsiasi Risvegliatore del Reame Ultra"
  },
  Task_57125_Desc = {
    Text = "Completa \"La Sua Discesa\" a Difficoltà Follia"
  },
  Task_57126_Desc = {
    Text = "Vinci una volta in \"Utero Oscuro\" usando un qualsiasi Risvegliatore di Aequor"
  },
  Task_57127_Desc = {
    Text = "Completa \"Frattura del Tempo\" a Difficoltà Follia"
  },
  Task_57128_Desc = {
    Text = "Completa \"Stella Gialla\" a Difficoltà Follia"
  },
  Task_57129_Desc = {
    Text = "Vinci una volta in \"Utero Oscuro\" usando un qualsiasi Risvegliatore del Caos"
  },
  Task_57130_Desc = {
    Text = "Completa \"Dormienza\" a Difficoltà Follia"
  },
  Task_57131_Desc = {
    Text = "Vinci due volte in \"Utero Oscuro\" usando un qualsiasi Risvegliatore del Caos"
  },
  Task_57132_Desc = {
    Text = "Vinci una volta in \"Utero Oscuro\" usando un qualsiasi Risvegliatore di Caro"
  },
  Task_57133_Desc = {
    Text = "Completa tutte le missioni in \"Utero Oscuro: Completamento\" e \"Utero Oscuro: Reame\""
  },
  Task_57134_Desc = {
    Text = "Vinci due volte in \"Utero Oscuro\" usando un qualsiasi Risvegliatore di Caro"
  },
  Task_57135_Desc = {
    Text = "Completa \"Velo del Sudario\" a Difficoltà Follia"
  },
  Task_57136_Desc = {
    Text = "Vinci una volta in \"Utero Oscuro\" usando un qualsiasi Risvegliatore del Reame Ultra"
  },
  Task_57137_Desc = {
    Text = "Utero Oscuro: Follia"
  },
  Task_57369_Desc = {
    Text = "Completa \"Un Ramoscello\" a qualsiasi difficoltà"
  },
  Task_57370_Desc = {
    Text = "Racconti al chiaro di luna: Follia"
  },
  Task_57371_Desc = {
    Text = "Completa \"Enigma della Stanza Segreta\" a qualsiasi difficoltà"
  },
  Task_57372_Desc = {
    Text = "Racconti al chiaro di luna: Completato"
  },
  Task_57373_Desc = {
    Text = "Completa \"Un Ramoscello\" a Difficoltà Follia"
  },
  Task_57374_Desc = {
    Text = "Completa \"Enigma Senza Testa\" a qualsiasi difficoltà"
  },
  Task_57375_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame del Caos per vincere due volte in \"Racconti al chiaro di luna\""
  },
  Task_57376_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Caro per vincere due volte in \"Racconti al chiaro di luna\""
  },
  Task_57377_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Caro per vincere una volta in \"Racconti al chiaro di luna\""
  },
  Task_57378_Desc = {
    Text = "Completa \"Ospite Inatteso\" a Difficoltà Follia"
  },
  Task_57379_Desc = {
    Text = "Completa \"Enigma Senza Testa\" a Difficoltà Follia"
  },
  Task_57380_Desc = {
    Text = "Completa tutte le missioni in \"Racconti al chiaro di luna: Completato\""
  },
  Task_57381_Desc = {
    Text = "Completa \"Enigma della Stanza Segreta\" a Difficoltà Follia"
  },
  Task_57382_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere una volta in \"Racconti al chiaro di luna\""
  },
  Task_57383_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere due volte in \"Racconti al chiaro di luna\""
  },
  Task_57384_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Aequor per vincere una volta in \"Racconti al chiaro di luna\""
  },
  Task_57385_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Aequor per vincere due volte in \"Racconti al chiaro di luna\""
  },
  Task_57386_Desc = {
    Text = "Completa \"Nessuno Fortunato\" a qualsiasi difficoltà"
  },
  Task_57387_Desc = {
    Text = "Completa \"Confessione dell'Alibi\" a Difficoltà Follia"
  },
  Task_57388_Desc = {
    Text = "Completa \"Alleato del detective\" a qualsiasi difficoltà"
  },
  Task_57389_Desc = {
    Text = "Completa \"Ospite Inatteso\" a qualsiasi difficoltà"
  },
  Task_57390_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame del Caos per vincere una volta in \"Racconti al chiaro di luna\""
  },
  Task_57391_Desc = {
    Text = "Racconti al chiaro di luna: Reame"
  },
  Task_57392_Desc = {
    Text = "Completa \"Alleato del detective\" a Difficoltà Follia"
  },
  Task_57393_Desc = {
    Text = "Completa \"Confessione dell'Alibi\" a qualsiasi difficoltà"
  },
  Task_57394_Desc = {
    Text = "Completa \"Nessuno Fortunato\" a Difficoltà Follia"
  },
  Task_57404_Desc = {
    Text = "Completa l'\"Epilogo\" a qualsiasi difficoltà"
  },
  Task_57405_Desc = {
    Text = "Completa \"Stratagemma Rovesciato\" a qualsiasi difficoltà"
  },
  Task_57406_Desc = {
    Text = "Completa l'\"Epilogo\" a Difficoltà Follia"
  },
  Task_57407_Desc = {
    Text = "Completa \"Stratagemma Rovesciato\" a Difficoltà Follia"
  },
  Task_57409_Desc = {
    Text = "Registro Operazioni Speciali \"Buona Caccia!\""
  },
  Task_57570_Desc = {
    Text = "Completa \"Stratagemma Rovesciato\" a qualsiasi difficoltà"
  },
  Task_57571_Desc = {
    Text = "Completa \"Alleato del detective\" a qualsiasi difficoltà"
  },
  Task_57572_Desc = {
    Text = "Completa \"Enigma Senza Testa\" a qualsiasi difficoltà"
  },
  Task_57573_Desc = {
    Text = "Completa \"Sacrificio dell'Agnello\" a qualsiasi difficoltà"
  },
  Task_57574_Desc = {
    Text = "Completa \"Confessione dell'Alibi\" a qualsiasi difficoltà"
  },
  Task_57575_Desc = {
    Text = "Completa \"Stella Gialla\" a qualsiasi difficoltà"
  },
  Task_57576_Desc = {
    Text = "Completa \"La Sua Discesa\" a qualsiasi difficoltà"
  },
  Task_57577_Desc = {
    Text = "Completa \"Lama del Boia\" a qualsiasi difficoltà"
  },
  Task_57578_Desc = {
    Text = "Completa l'\"Epilogo\" a qualsiasi difficoltà"
  },
  Task_57579_Desc = {
    Text = "Completa \"Velo del Sudario\" a qualsiasi difficoltà"
  },
  Task_57580_Desc = {
    Text = "Completa \"Ospite Inatteso\" a qualsiasi difficoltà"
  },
  Task_57581_Desc = {
    Text = "Completa \"Dormienza\" a qualsiasi difficoltà"
  },
  Task_57582_Desc = {
    Text = "Completa \"Frattura del Tempo\" a qualsiasi difficoltà"
  },
  Task_57583_Desc = {
    Text = "Completa \"Un Ramoscello\" a qualsiasi difficoltà"
  },
  Task_57584_Desc = {
    Text = "Completa \"Nessuno Fortunato\" a qualsiasi difficoltà"
  },
  Task_57585_Desc = {
    Text = "Completa \"Enigma della Stanza Segreta\" a qualsiasi difficoltà"
  },
  Task_58104_Desc = {
    Text = "Supera \"Penitenza\" a qualsiasi difficoltà"
  },
  Task_58107_Desc = {
    Text = "Supera \"Rimprovero Silenzioso\" a qualsiasi difficoltà"
  },
  Task_58109_Desc = {
    Text = "Completa \"Morsa della Paranoia\" a Difficoltà Follia"
  },
  Task_58110_Desc = {
    Text = "Supera \"Lotta Interiore\" a qualsiasi difficoltà"
  },
  Task_58111_Desc = {
    Text = "Supera \"Lotta Interiore\" a qualsiasi difficoltà"
  },
  Task_58112_Desc = {
    Text = "Supera \"Penitenza\" a qualsiasi difficoltà"
  },
  Task_58113_Desc = {
    Text = "Supera \"Morsa della Paranoia\" a qualsiasi difficoltà"
  },
  Task_58114_Desc = {
    Text = "Completa \"Penitenza\" a Difficoltà Follia"
  },
  Task_58115_Desc = {
    Text = "Supera \"Supplica Inascoltata\" a qualsiasi difficoltà"
  },
  Task_58118_Desc = {
    Text = "Completa \"Rimprovero Silenzioso\" a Difficoltà Follia"
  },
  Task_58119_Desc = {
    Text = "Completa \"Supplica Inascoltata\" a Difficoltà Follia"
  },
  Task_58120_Desc = {
    Text = "Completa tutti i livelli della \"Via Sacrosanta\" a qualsiasi difficoltà"
  },
  Task_58122_Desc = {
    Text = "Supera \"Rimprovero Silenzioso\" a qualsiasi difficoltà"
  },
  Task_58123_Desc = {
    Text = "Bazar di beneficenza della Chiesa"
  },
  Task_58124_Desc = {
    Text = "Supera \"Morsa della Paranoia\" a qualsiasi difficoltà"
  },
  Task_58126_Desc = {
    Text = "Supera \"Supplica Inascoltata\" a qualsiasi difficoltà"
  },
  Task_58128_Desc = {
    Text = "Via Sacrosanta: Follia"
  },
  Task_58130_Desc = {
    Text = "Via Sacrosanta: Rigoglio"
  },
  Task_58131_Desc = {
    Text = "Completa \"Lotta Interiore\" a Difficoltà Follia"
  },
  Task_58132_Desc = {
    Text = "Acquista 100 volte ne \"Il bazar magico di Big John\""
  },
  Task_58133_Desc = {
    Text = "Acquista 200 volte ne \"Il bazar magico di Big John\""
  },
  Task_58134_Desc = {
    Text = "Effettua 100 acquisti ne \"Il Negozio della Sig.ra Gray\""
  },
  Task_58135_Desc = {
    Text = "Effettua 200 acquisti ne \"Il Negozio della Sig.ra Gray\""
  },
  Task_58136_Desc = {
    Text = "Acquista 200 volte nella \"Vendita Speciale di Smith\""
  },
  Task_58137_Desc = {
    Text = "Acquista 100 volte nella \"Vendita Speciale di Smith\""
  },
  Task_58138_Desc = {
    Text = "Completa l'Evento d'Indagine \"{s1}\""
  },
  Task_58500_Desc = {
    Text = "Rombo delle Macchine: Completamento"
  },
  Task_58501_Desc = {
    Text = "Completa \"Grande Orchestrazione\" a Difficoltà Follia"
  },
  Task_58502_Desc = {
    Text = "Completa \"Ouverture\" a qualsiasi difficoltà"
  },
  Task_58503_Desc = {
    Text = "Completa \"Minuetto\" a qualsiasi difficoltà"
  },
  Task_58504_Desc = {
    Text = "Completa \"Echi\" a qualsiasi difficoltà"
  },
  Task_58505_Desc = {
    Text = "Completamento di \"Fine Ultima\" a qualsiasi difficoltà"
  },
  Task_58506_Desc = {
    Text = "Completa \"Adagio\" a qualsiasi difficoltà"
  },
  Task_58507_Desc = {
    Text = "Completa \"Allegro\" a Difficoltà Follia"
  },
  Task_58508_Desc = {
    Text = "Completa \"Minuetto\" a Difficoltà Follia"
  },
  Task_58509_Desc = {
    Text = "Completa \"Echi\" a qualsiasi difficoltà"
  },
  Task_58510_Desc = {
    Text = "Vinci una volta in \"Rombo delle Macchine\" usando un qualsiasi Risvegliatore del Caos"
  },
  Task_58511_Desc = {
    Text = "Vinci due volte in \"Rombo delle Macchine\" usando un qualsiasi Risvegliatore del Caos"
  },
  Task_58512_Desc = {
    Text = "Completa \"Guida del Sogno Perduto\" a qualsiasi difficoltà"
  },
  Task_58513_Desc = {
    Text = "Rombo delle Macchine: Reame"
  },
  Task_58514_Desc = {
    Text = "Completa \"Echi\" a Difficoltà Follia"
  },
  Task_58515_Desc = {
    Text = "Completa \"Minuetto\" a qualsiasi difficoltà"
  },
  Task_58516_Desc = {
    Text = "Rombo delle Macchine: Follia"
  },
  Task_58517_Desc = {
    Text = "Completa \"Allegro\" a qualsiasi difficoltà"
  },
  Task_58518_Desc = {
    Text = "Completa \"Ouverture\" a Difficoltà Follia"
  },
  Task_58519_Desc = {
    Text = "Completa \"Grande Orchestrazione\" a qualsiasi difficoltà"
  },
  Task_58520_Desc = {
    Text = "Completa \"Adagio\" a Difficoltà Follia"
  },
  Task_58521_Desc = {
    Text = "Completa \"Adagio\" a qualsiasi difficoltà"
  },
  Task_58522_Desc = {
    Text = "Vinci due volte in \"Rombo delle Macchine\" usando un qualsiasi Risvegliatore di Aequor"
  },
  Task_58523_Desc = {
    Text = "Vinci una volta in \"Rombo delle Macchine\" usando un qualsiasi Risvegliatore di Aequor"
  },
  Task_58524_Desc = {
    Text = "Completa \"Cala il Sipario\" a qualsiasi difficoltà"
  },
  Task_58525_Desc = {
    Text = "Completamento di \"Fine Ultima\" a Difficoltà Follia"
  },
  Task_58526_Desc = {
    Text = "Completa \"Guida del Sogno Perduto\" a Difficoltà Follia"
  },
  Task_58527_Desc = {
    Text = "Vinci due volte in \"Rombo delle Macchine\" usando un qualsiasi Risvegliatore del Reame Ultra"
  },
  Task_58528_Desc = {
    Text = "Vinci una volta in \"Rombo delle Macchine\" usando un qualsiasi Risvegliatore del Reame Ultra"
  },
  Task_58529_Desc = {
    Text = "Completa \"Allegro\" a qualsiasi difficoltà"
  },
  Task_58530_Desc = {
    Text = "Completa tutte le missioni in \"Rombo delle Macchine: Completamento\""
  },
  Task_58531_Desc = {
    Text = "Completa \"Ouverture\" a qualsiasi difficoltà"
  },
  Task_58532_Desc = {
    Text = "Completa \"Cala il Sipario\" a qualsiasi difficoltà"
  },
  Task_58533_Desc = {
    Text = "Completa \"Grande Orchestrazione\" a qualsiasi difficoltà"
  },
  Task_58534_Desc = {
    Text = "Completa \"Guida del Sogno Perduto\" a qualsiasi difficoltà"
  },
  Task_58535_Desc = {
    Text = "Completamento di \"Fine Ultima\" a qualsiasi difficoltà"
  },
  Task_58536_Desc = {
    Text = "Completa \"Cala il Sipario\" a Difficoltà Follia"
  },
  Task_58537_Desc = {
    Text = "Vinci una volta in \"Rombo delle Macchine\" usando un qualsiasi Risvegliatore di Caro"
  },
  Task_58538_Desc = {
    Text = "Vinci due volte in \"Rombo delle Macchine\" usando un qualsiasi Risvegliatore di Caro"
  },
  Task_58989_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_58989_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_58990_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_58990_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_58991_Desc = {
    Text = "Pesca almeno 5 Carte aggiuntive in un turno durante la Battaglia finale."
  },
  Task_58991_Name = {Text = "Pesca!"},
  Task_58992_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_58992_Name = {
    Text = "Risparmio Energetico"
  },
  Task_58993_Desc = {
    Text = "Ottenere almeno 4 tipi diversi di Orazioni"
  },
  Task_58993_Name = {
    Text = "Marchio dell'Anima"
  },
  Task_58994_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_58994_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_58995_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_58995_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_58996_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_58996_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_58997_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_58997_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_58998_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_58998_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_58999_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_58999_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_59000_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_59000_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_59001_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_59001_Name = {
    Text = "Superamento Perfetto"
  },
  Task_59002_Desc = {
    Text = "Non avere più di 3 Carte sintomo al completamento"
  },
  Task_59002_Name = {
    Text = "Risparmio Energetico"
  },
  Task_59003_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_59003_Name = {
    Text = "Risparmio Energetico"
  },
  Task_59004_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_59004_Name = {
    Text = "Superamento Perfetto"
  },
  Task_59005_Desc = {
    Text = "Portare almeno 8 Reliquie al completamento."
  },
  Task_59005_Name = {
    Text = "Scorta segreta"
  },
  Task_59006_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_59006_Name = {
    Text = "Superamento Perfetto"
  },
  Task_59007_Desc = {
    Text = "Portare almeno 1 Reliquia maledetta al completamento."
  },
  Task_59007_Name = {
    Text = "Scorta segreta"
  },
  Task_59008_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_59008_Name = {
    Text = "Superamento Perfetto"
  },
  Task_59009_Desc = {
    Text = "Gioca almeno 6 Carte in un turno durante la Battaglia finale."
  },
  Task_59009_Name = {
    Text = "Tocca a me!"
  },
  Task_59010_Desc = {
    Text = "In un turno della Battaglia finale, accumula uno Scudo del Personaggio pari ad almeno il 65% della Salute massima."
  },
  Task_59010_Name = {
    Text = "Corpo d'Acciaio"
  },
  Task_59011_Desc = {
    Text = "Gioca almeno 6 Carte in un turno durante la Battaglia finale."
  },
  Task_59011_Name = {
    Text = "Tocca a me!"
  },
  Task_59012_Desc = {
    Text = "In un turno della Battaglia finale, accumula uno Scudo del Personaggio pari ad almeno il 65% della Salute massima."
  },
  Task_59012_Name = {
    Text = "Corpo d'Acciaio"
  },
  Task_59013_Desc = {
    Text = "Pesca almeno 5 Carte aggiuntive in un turno durante la Battaglia finale."
  },
  Task_59013_Name = {Text = "Pesca!"},
  Task_59014_Desc = {
    Text = "Infliggi almeno 20000 punti di Danno in un singolo turno durante la Battaglia finale."
  },
  Task_59014_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_59015_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_59015_Name = {
    Text = "Elegante e Preciso"
  },
  Task_59016_Desc = {
    Text = "Ottenere almeno 4 tipi diversi di Orazioni"
  },
  Task_59016_Name = {
    Text = "Marchio dell'Anima"
  },
  Task_59017_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_59017_Name = {
    Text = "Elegante e Preciso"
  },
  Task_59018_Desc = {
    Text = "Portare almeno 1 Reliquia maledetta al completamento."
  },
  Task_59018_Name = {
    Text = "Scorta segreta"
  },
  Task_59019_Desc = {
    Text = "Risveglia tutti i Risvegliatori al completamento"
  },
  Task_59019_Name = {
    Text = "Abbraccio Infinito"
  },
  Task_59020_Desc = {
    Text = "Possiedi almeno 2 Reliquie al completamento"
  },
  Task_59020_Name = {
    Text = "Scorta segreta"
  },
  Task_59021_Desc = {
    Text = "Portare almeno 1 Reliquia maledetta al completamento."
  },
  Task_59021_Name = {
    Text = "Scorta segreta"
  },
  Task_59022_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_59022_Name = {
    Text = "Risparmio Energetico"
  },
  Task_59023_Desc = {
    Text = "Pescare almeno 4 carte aggiuntive in un turno durante la Battaglia finale"
  },
  Task_59023_Name = {Text = "Pesca!"},
  Task_59024_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_59024_Name = {
    Text = "Superamento Perfetto"
  },
  Task_59025_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_59025_Name = {
    Text = "Superamento Perfetto"
  },
  Task_59026_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_59026_Name = {
    Text = "Superamento Perfetto"
  },
  Task_59027_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_59027_Name = {
    Text = "Superamento Perfetto"
  },
  Task_59028_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_59028_Name = {
    Text = "Superamento Perfetto"
  },
  Task_59029_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_59029_Name = {
    Text = "Superamento Perfetto"
  },
  Task_59030_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_59030_Name = {
    Text = "Superamento Perfetto"
  },
  Task_59031_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_59031_Name = {
    Text = "Superamento Perfetto"
  },
  Task_59032_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_59032_Name = {
    Text = "Superamento Perfetto"
  },
  Task_59033_Desc = {
    Text = "Risveglia tutti i Risvegliatori al completamento"
  },
  Task_59033_Name = {
    Text = "Abbraccio Infinito"
  },
  Task_59034_Desc = {
    Text = "Possiedi almeno 2 Reliquie al completamento"
  },
  Task_59034_Name = {
    Text = "Scorta segreta"
  },
  Task_59035_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_59035_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_59036_Desc = {
    Text = "Portare almeno 1 Reliquia maledetta al completamento."
  },
  Task_59036_Name = {
    Text = "Scorta segreta"
  },
  Task_59037_Desc = {
    Text = "Vinci la Battaglia finale entro 18 turni"
  },
  Task_59037_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_59038_Desc = {
    Text = "Vinci la Battaglia finale entro 12 turni"
  },
  Task_59038_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_59039_Desc = {
    Text = "In un turno della Battaglia finale, accumula uno Scudo del Personaggio pari ad almeno il 60% della Salute massima."
  },
  Task_59039_Name = {
    Text = "Corpo d'Acciaio"
  },
  Task_59040_Desc = {
    Text = "Gioca almeno 5 Carte in un turno durante la Battaglia finale."
  },
  Task_59040_Name = {
    Text = "Tocca a me!"
  },
  Task_59041_Desc = {
    Text = "In un turno della Battaglia finale, accumula uno Scudo del Personaggio pari ad almeno il 60% della Salute massima."
  },
  Task_59041_Name = {
    Text = "Corpo d'Acciaio"
  },
  Task_59042_Desc = {
    Text = "Non avere più di 3 Carte sintomo al completamento"
  },
  Task_59042_Name = {
    Text = "Risparmio Energetico"
  },
  Task_59043_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_59043_Name = {
    Text = "Elegante e Preciso"
  },
  Task_59044_Desc = {
    Text = "Vinci la Battaglia finale entro 18 turni"
  },
  Task_59044_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_59045_Desc = {
    Text = "Pescare almeno 4 carte aggiuntive in un turno durante la Battaglia finale"
  },
  Task_59045_Name = {Text = "Pesca!"},
  Task_59046_Desc = {
    Text = "Portare almeno 8 Reliquie al completamento."
  },
  Task_59046_Name = {
    Text = "Scorta segreta"
  },
  Task_59047_Desc = {
    Text = "Gioca almeno 5 Carte in un turno durante la Battaglia finale."
  },
  Task_59047_Name = {
    Text = "Tocca a me!"
  },
  Task_59048_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_59048_Name = {
    Text = "Elegante e Preciso"
  },
  Task_59438_Desc = {
    Text = "L'Affinità di Ryker raggiunge il Livello 10"
  },
  Task_60163_Desc = {
    Text = "Completa il livello"
  },
  Task_60163_Name = {
    Text = "Completa il livello"
  },
  Task_60163_UnlockCondDesc = {
    Text = "Si sblocca dopo il completamento di 8-9"
  },
  Task_60164_Desc = {
    Text = "Completa il livello"
  },
  Task_60164_Name = {
    Text = "Completa il livello"
  },
  Task_60164_UnlockCondDesc = {
    Text = "Si sblocca dopo il completamento di 8-11"
  },
  Task_60165_Desc = {
    Text = "Completa il livello"
  },
  Task_60165_Name = {
    Text = "Completa il livello"
  },
  Task_60165_UnlockCondDesc = {
    Text = "Si sblocca dopo il completamento di 8-10"
  },
  Task_60443_Desc = {
    Text = "Completa il Capitolo 4 della Storia principale \"Dove regna il silenzio\""
  },
  Task_60444_Desc = {
    Text = "Raggiungi 150 Punti Addestramento per la prima volta"
  },
  Task_60445_Desc = {
    Text = "Raggiungi 325 Punti Addestramento per la prima volta"
  },
  Task_60446_Desc = {
    Text = "Raggiungi 50 Punti Addestramento per la prima volta"
  },
  Task_60447_Desc = {
    Text = "Raggiungi 100 Punti Addestramento per la prima volta"
  },
  Task_60448_Desc = {
    Text = "Completamento Storia Principale Capitolo 4 \"Dove regna il silenzio\": Modalità Difficile"
  },
  Task_60449_Desc = {
    Text = "Raggiungi 300 Punti Addestramento per la prima volta"
  },
  Task_60450_Desc = {
    Text = "Completa il Capitolo 2 della Storia principale \"Eredità di Cera\""
  },
  Task_60451_Desc = {
    Text = "Completa il Capitolo 5 della Storia principale \"Occhio del Ciclone\": Modalità Difficile"
  },
  Task_60452_Desc = {
    Text = "Raggiungi 225 Punti Addestramento per la prima volta"
  },
  Task_60453_Desc = {
    Text = "Completamento Storia Principale Capitolo 1 \"L'enigma del Distretto Est\""
  },
  Task_60454_Desc = {
    Text = "Completamento Storia Principale Capitolo 6 \"Stelle distorte\": Modalità Difficile"
  },
  Task_60455_Desc = {
    Text = "Completamento Storia Principale Capitolo 2 \"Eredità di Cera\": Modalità Difficile"
  },
  Task_60456_Desc = {
    Text = "Completa il Capitolo 5 della Storia principale \"Occhio del Ciclone\""
  },
  Task_60457_Desc = {
    Text = "Completamento Storia Principale Capitolo 3 \"Attenti ai segugi\": Modalità Difficile"
  },
  Task_60458_Desc = {
    Text = "Completamento Storia Principale Capitolo 1 \"L'enigma del Distretto Est\": Modalità Difficile"
  },
  Task_60459_Desc = {
    Text = "Completa il Capitolo 3 della Storia principale \"Attenti ai segugi\""
  },
  Task_60460_Desc = {
    Text = "Completa il Capitolo 6 della Storia principale \"Stelle distorte\""
  },
  Task_60461_Desc = {
    Text = "Raggiungi 350 Punti Addestramento per la prima volta"
  },
  Task_60601_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60602_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60603_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60604_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60606_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60607_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60608_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60609_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60610_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60611_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60612_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60613_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60614_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60615_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60616_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60617_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60618_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60619_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60620_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60622_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60623_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60624_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60625_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60626_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60627_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60628_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60629_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60630_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60631_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60633_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60634_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60635_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60636_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60637_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60638_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60639_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60640_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60641_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60642_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60643_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60644_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60645_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60646_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60647_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60648_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60649_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60650_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60651_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60653_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60654_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60655_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60656_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60657_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60658_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60659_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60660_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60661_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60663_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60664_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60665_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60666_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60667_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60668_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60669_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60670_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60671_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60672_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60673_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60674_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60675_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60676_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60677_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60678_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60680_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60681_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60682_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60683_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60684_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60685_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60686_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60687_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60688_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60689_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60690_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60691_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60692_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60694_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60696_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60697_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60699_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60742_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60743_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60747_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60748_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60749_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60750_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60751_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60752_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60754_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60755_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60757_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60758_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60759_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60760_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60761_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60763_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60765_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60766_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60768_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60769_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60770_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60772_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60773_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60774_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60777_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60778_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60779_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60780_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60781_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60782_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60783_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60784_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60785_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60787_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60788_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60789_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60790_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60793_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60795_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60796_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60797_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60798_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60799_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60800_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60801_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60803_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60804_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60805_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_60829_Desc = {
    Text = "L'Affinità di Hameln raggiunge il Livello 10"
  },
  Task_61103_Desc = {
    Text = "Ottieni Bambola della Genesi"
  },
  Task_61103_Name = {
    Text = "Ottieni Bambola della Genesi"
  },
  Task_61104_Desc = {
    Text = "Ottieni Genesi Helot"
  },
  Task_61104_Name = {
    Text = "Ottieni Genesi Helot"
  },
  Task_61105_Desc = {
    Text = "Ottieni Lily"
  },
  Task_61105_Name = {
    Text = "Ottieni Lily"
  },
  Task_61106_Desc = {
    Text = "Ottieni Horla"
  },
  Task_61106_Name = {
    Text = "Ottieni Horla"
  },
  Task_61107_Desc = {
    Text = "Ottieni Miryam"
  },
  Task_61107_Name = {
    Text = "Ottieni Miryam"
  },
  Task_61108_Desc = {
    Text = "Ottieni Ryker"
  },
  Task_61108_Name = {
    Text = "Ottieni Ryker"
  },
  Task_61109_Desc = {
    Text = "Ottieni Sorel"
  },
  Task_61109_Name = {
    Text = "Ottieni Sorel"
  },
  Task_61110_Desc = {
    Text = "Ottieni Salvador"
  },
  Task_61110_Name = {
    Text = "Ottieni Salvador"
  },
  Task_61111_Desc = {
    Text = "Ottieni Wanda"
  },
  Task_61111_Name = {
    Text = "Ottieni Wanda"
  },
  Task_61112_Desc = {
    Text = "Ottieni Tulu"
  },
  Task_61112_Name = {
    Text = "Ottieni Tulu"
  },
  Task_61113_Desc = {
    Text = "Ottieni \"24\""
  },
  Task_61113_Name = {
    Text = "Ottieni \"24\""
  },
  Task_61114_Desc = {
    Text = "Ottieni Tawil"
  },
  Task_61114_Name = {
    Text = "Ottieni Tawil"
  },
  Task_61115_Desc = {
    Text = "Ottieni Thais"
  },
  Task_61115_Name = {
    Text = "Ottieni Thais"
  },
  Task_61116_Desc = {
    Text = "Ottieni Hameln"
  },
  Task_61116_Name = {
    Text = "Ottieni Hameln"
  },
  Task_61117_Desc = {
    Text = "Ottieni Daffodil"
  },
  Task_61117_Name = {
    Text = "Ottieni Daffodil"
  },
  Task_61118_Desc = {
    Text = "Ottieni Murphy"
  },
  Task_61118_Name = {
    Text = "Ottieni Murphy"
  },
  Task_61157_Desc = {
    Text = "Completamento Storia Principale Capitolo 8 \"Ultima sinfonia\": Modalità Difficile"
  },
  Task_61158_Desc = {
    Text = "Completa il Capitolo 7 della Storia principale \"Flusso del Desiderio\""
  },
  Task_61159_Desc = {
    Text = "Completamento Storia Principale Capitolo 7 \"Flusso del Desiderio\": Modalità Difficile"
  },
  Task_61160_Desc = {
    Text = "Completamento Storia Principale Capitolo 8 \"Ultima sinfonia\": Modalità Difficile"
  },
  Task_61161_Desc = {
    Text = "Completa il Capitolo 8 della Storia principale \"Ultima sinfonia\""
  },
  Task_61162_Desc = {
    Text = "Completamento Storia Principale Capitolo 7 \"Flusso del Desiderio\": Modalità Difficile"
  },
  Task_61163_Desc = {
    Text = "Completa il Capitolo 7 della Storia principale \"Flusso del Desiderio\""
  },
  Task_61164_Desc = {
    Text = "Completa il Capitolo 8 della Storia principale \"Ultima sinfonia\""
  },
  Task_61186_Desc = {
    Text = "Completa \"Ricordo fugace\" a qualsiasi difficoltà"
  },
  Task_61187_Desc = {
    Text = "Completa \"Città d'Oro\" a qualsiasi difficoltà"
  },
  Task_61188_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere una volta in \"Città nel Lago\""
  },
  Task_61189_Desc = {
    Text = "Si sblocca dopo aver completato tutte le missioni in \"Città nel Lago: Completato\""
  },
  Task_61190_Desc = {
    Text = "Completa \"L'Apocalisse\" a qualsiasi difficoltà"
  },
  Task_61191_Desc = {
    Text = "Completa \"Verità Nascosta\" a Difficoltà Follia"
  },
  Task_61192_Desc = {
    Text = "Completa \"Città d'Oro\" a Difficoltà Follia"
  },
  Task_61193_Desc = {
    Text = "Completa \"Miraggio\" a qualsiasi difficoltà"
  },
  Task_61194_Desc = {
    Text = "Città nel Lago: Completato"
  },
  Task_61195_Desc = {
    Text = "Completa \"Verità Nascosta\" a qualsiasi difficoltà"
  },
  Task_61196_Desc = {
    Text = "Completa \"Fiore di Fresia\" a qualsiasi difficoltà"
  },
  Task_61197_Desc = {
    Text = "Completa \"Miraggio\" a qualsiasi difficoltà"
  },
  Task_61198_Desc = {
    Text = "Vinci una volta nella \"Città nel Lago\" usando un qualsiasi Risvegliatore del Reame Ultra"
  },
  Task_61199_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere una volta in \"Città nel Lago\""
  },
  Task_61200_Desc = {
    Text = "Completa \"Miraggio\" a Difficoltà Follia"
  },
  Task_61201_Desc = {
    Text = "Città nel Lago: Reame"
  },
  Task_61202_Desc = {
    Text = "Completa \"Città d'Oro\" a qualsiasi difficoltà"
  },
  Task_61203_Desc = {
    Text = "Completa \"L'Apocalisse\" a qualsiasi difficoltà"
  },
  Task_61204_Desc = {
    Text = "Completa \"Pozzo profondo\" a qualsiasi difficoltà"
  },
  Task_61205_Desc = {
    Text = "Completa \"Ricordo fugace\" a qualsiasi difficoltà"
  },
  Task_61206_Desc = {
    Text = "Vinci una volta nella \"Città nel Lago\" usando un qualsiasi Risvegliatore di Caro"
  },
  Task_61207_Desc = {
    Text = "Completa \"Fiore di Fresia\" a Difficoltà Follia"
  },
  Task_61208_Desc = {
    Text = "Completa \"L'Apocalisse\" a Difficoltà Follia"
  },
  Task_61209_Desc = {
    Text = "Completa \"Pozzo profondo\" a qualsiasi difficoltà"
  },
  Task_61210_Desc = {
    Text = "Completa \"Fiore di Fresia\" a qualsiasi difficoltà"
  },
  Task_61211_Desc = {
    Text = "Città nel Lago: Follia"
  },
  Task_61212_Desc = {
    Text = "Completa \"Verità Nascosta\" a qualsiasi difficoltà"
  },
  Task_61213_Desc = {
    Text = "Completa \"Ricordo fugace\" a Difficoltà Follia"
  },
  Task_61214_Desc = {
    Text = "Completa \"Pozzo profondo\" a Difficoltà Follia"
  },
  Task_61215_Desc = {
    Text = "Completamento Psico-immersione \"Banchetto di Fiamme\""
  },
  Task_61375_Desc = {
    Text = "Accesso: 12 giorni"
  },
  Task_61376_Desc = {
    Text = "Accedi per 3 giorni cumulativi"
  },
  Task_61377_Desc = {
    Text = "Accesso: 9 giorni"
  },
  Task_61378_Desc = {
    Text = "Accesso: 11 giorni"
  },
  Task_61379_Desc = {
    Text = "Accedi per un totale di 10 giorni"
  },
  Task_61380_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_61381_Desc = {
    Text = "Accedi per un totale di 4 giorni"
  },
  Task_61382_Desc = {
    Text = "Accedi per un totale di 15 giorni"
  },
  Task_61383_Desc = {
    Text = "Accesso: 14 giorni"
  },
  Task_61384_Desc = {
    Text = "Accedi per 5 giorni cumulativi"
  },
  Task_61385_Desc = {
    Text = "Accedi per un totale di 8 giorni"
  },
  Task_61386_Desc = {
    Text = "Accedi per un totale di 2 giorni"
  },
  Task_61387_Desc = {
    Text = "Accesso: 13 giorni"
  },
  Task_61388_Desc = {
    Text = "Accesso cumulativo per 6 giorni"
  },
  Task_61389_Desc = {
    Text = "Accesso: 16 giorni"
  },
  Task_61390_Desc = {
    Text = "Accedi per un totale di 7 giorni"
  },
  Task_61394_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61395_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61396_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61397_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61398_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61399_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61400_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61401_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61402_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61403_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61404_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61405_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61407_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61408_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61409_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61410_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61411_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61412_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61413_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61414_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61415_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61416_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61417_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61418_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61419_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61420_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61421_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61422_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61425_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61426_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61427_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61428_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61430_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61431_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61432_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61433_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61434_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61435_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61436_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61438_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61439_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61440_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61441_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61442_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61443_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61444_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61445_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61446_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61447_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61448_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61449_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61450_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61451_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61452_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61453_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61455_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61456_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61457_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61458_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61459_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61460_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61461_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61462_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61463_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61464_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61465_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61466_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61468_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61469_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61470_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61471_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61472_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61473_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61474_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61475_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61476_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61477_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61478_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61479_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61481_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61519_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61520_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61521_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61522_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61523_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61524_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61525_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61526_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61527_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61528_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61616_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61617_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61620_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61621_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61622_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61623_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61626_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61627_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61628_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61629_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61631_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61633_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61634_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61636_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61637_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61639_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61640_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61642_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61643_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61644_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61645_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61648_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61649_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61650_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61652_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61653_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61654_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61655_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61657_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61659_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61660_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61661_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61662_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61665_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61666_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61668_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61669_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61671_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61672_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61673_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61675_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61676_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61678_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61679_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61681_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61682_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61684_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61685_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61687_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61688_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61690_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61691_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61693_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61694_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61696_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61697_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61699_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61700_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61701_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61702_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61704_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61705_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61706_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61707_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61709_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61710_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61712_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61713_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61716_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61717_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61719_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61720_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61722_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61723_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61725_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61726_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61727_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61729_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61731_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61733_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61734_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61735_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61736_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61739_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61740_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61743_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61744_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61748_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61749_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61750_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61751_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61753_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61754_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61756_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61757_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61758_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61759_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61762_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61763_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61765_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61766_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61767_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61769_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61770_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61771_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61772_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61774_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61777_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61778_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61781_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61782_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61783_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61784_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61785_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61788_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61789_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61791_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61792_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61794_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61795_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61796_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61797_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61798_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61801_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61802_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61804_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61805_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61807_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61808_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61810_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61811_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61814_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61815_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61816_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61817_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61819_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61820_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61821_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61824_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_61825_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_62002_Desc = {
    Text = "Completa \"Vista della Montagna\" a Difficoltà Follia"
  },
  Task_62003_Desc = {
    Text = "Completa \"Terra Spezzata\" a qualsiasi difficoltà"
  },
  Task_62004_Desc = {
    Text = "Ambizione bestiale: Reame"
  },
  Task_62005_Desc = {
    Text = "Completa \"Oblio Gelido\" a qualsiasi difficoltà"
  },
  Task_62006_Desc = {
    Text = "Scambia boccioli in \"Ambizione Insaziabile\" per ottenere 200 ricompense"
  },
  Task_62007_Desc = {
    Text = "Scambia boccioli in \"Ambizione Insaziabile\" per ottenere 100 ricompense"
  },
  Task_62008_Desc = {
    Text = "Completa \"Oblio Gelido\" a Difficoltà Follia"
  },
  Task_62009_Desc = {
    Text = "Completa \"Oblio Gelido\" a qualsiasi difficoltà"
  },
  Task_62010_Desc = {
    Text = "Completa \"Vista della Montagna\" a qualsiasi difficoltà"
  },
  Task_62011_Desc = {
    Text = "Completa \"Furia della Bestia\" a qualsiasi difficoltà"
  },
  Task_62012_Desc = {
    Text = "Completa \"Vista della Montagna\" a qualsiasi difficoltà"
  },
  Task_62013_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere una volta in \"Ambizione bestiale\""
  },
  Task_62014_Desc = {
    Text = "Fauci della Montagna"
  },
  Task_62015_Desc = {
    Text = "Completa \"Terra Spezzata\" a Difficoltà Follia"
  },
  Task_62016_Desc = {
    Text = "Ambizione bestiale: Follia"
  },
  Task_62017_Desc = {
    Text = "Completa \"Ritorno\" a Difficoltà Follia"
  },
  Task_62018_Desc = {
    Text = "Ambizione bestiale: Completata"
  },
  Task_62019_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere una volta in \"Ambizione bestiale\""
  },
  Task_62020_Desc = {
    Text = "Scambia boccioli in \"Speranza di resurrezione\" per ottenere 100 ricompense"
  },
  Task_62021_Desc = {
    Text = "Scambia boccioli in \"Furia della Vendetta\" per ottenere 200 ricompense"
  },
  Task_62022_Desc = {
    Text = "Scambia boccioli in \"Furia della Vendetta\" per ottenere 100 ricompense"
  },
  Task_62023_Desc = {
    Text = "Completa tutte le missioni in \"Ambizione bestiale: Completamento\""
  },
  Task_62024_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere una volta in \"Ambizione bestiale\""
  },
  Task_62025_Desc = {
    Text = "Scambia boccioli in \"Speranza di resurrezione\" per ottenere 200 ricompense"
  },
  Task_62026_Desc = {
    Text = "Completa \"Ritorno\" a qualsiasi difficoltà"
  },
  Task_62027_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per vincere una volta in \"Ambizione bestiale\""
  },
  Task_62028_Desc = {
    Text = "Completa \"Furia della Bestia\" a qualsiasi difficoltà"
  },
  Task_62029_Desc = {
    Text = "Completa \"Furia della Bestia\" a Difficoltà Follia"
  },
  Task_62030_Desc = {
    Text = "Completa \"Ritorno\" a qualsiasi difficoltà"
  },
  Task_62031_Desc = {
    Text = "Completa \"Terra Spezzata\" a qualsiasi difficoltà"
  },
  Task_62092_Desc = {
    Text = "Completa il Registro Operazioni Speciali \"Il Ritornante di Elworth\""
  },
  Task_62207_Desc = {
    Text = "L'Affinità di Helot: Catena raggiunge il Livello 10"
  },
  Task_62209_Desc = {
    Text = "Fuga dalla Montagna Innevata"
  },
  Task_62209_Name = {Text = "Bersaglio"},
  Task_62231_Desc = {
    Text = "Illuminare 6 all'ottenimento di Ryker"
  },
  Task_62231_Name = {
    Text = "Illuminare 6 all'ottenimento di Ryker"
  },
  Task_62231_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 2 del Risveglio di Ryker Evento"
  },
  Task_62232_Desc = {
    Text = "Illuminare 2 all'ottenimento di Jenkin"
  },
  Task_62232_Name = {
    Text = "Illuminare 2 all'ottenimento di Jenkin"
  },
  Task_62232_UnlockCondDesc = {
    Text = "Evento @ Evento Pack Illuminare 1 del Risveglio Jenkin"
  },
  Task_62233_Desc = {
    Text = "Illuminare 6 all'ottenimento di Jenkin"
  },
  Task_62233_Name = {
    Text = "Illuminare 6 all'ottenimento di Jenkin"
  },
  Task_62233_UnlockCondDesc = {
    Text = "Evento @Risveglio Jenkin Pacco Dono Illuminare 2 Evento"
  },
  Task_62234_Desc = {
    Text = "Illuminare 2 all'ottenimento di Hameln"
  },
  Task_62234_Name = {
    Text = "Illuminare 2 all'ottenimento di Hameln"
  },
  Task_62234_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 1 Risvegliatore Hameln Evento"
  },
  Task_62235_Desc = {
    Text = "Illuminare 2 all'ottenimento di Wanda"
  },
  Task_62235_Name = {
    Text = "Illuminare 2 all'ottenimento di Wanda"
  },
  Task_62235_UnlockCondDesc = {
    Text = "Evento @ Evento Pack Illuminare 1 del Risveglio Wanda"
  },
  Task_62236_Desc = {
    Text = "Illuminare 6 all'ottenimento di Nymphaea"
  },
  Task_62236_Name = {
    Text = "Illuminare 6 all'ottenimento di Nymphaea"
  },
  Task_62236_UnlockCondDesc = {
    Text = "Evento @Risveglio Nymphaea Pacco Dono Illuminare 2 Evento"
  },
  Task_62237_Desc = {
    Text = "Illuminare 2 all'ottenimento di Horla"
  },
  Task_62237_Name = {
    Text = "Illuminare 2 all'ottenimento di Horla"
  },
  Task_62237_UnlockCondDesc = {
    Text = "Evento @ Evento Pack Illuminare 1 del Risveglio Horla"
  },
  Task_62238_Desc = {
    Text = "Illuminare 6 all'ottenimento di Wanda"
  },
  Task_62238_Name = {
    Text = "Illuminare 6 all'ottenimento di Wanda"
  },
  Task_62238_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 2 del Risveglio di Wanda Evento"
  },
  Task_62239_Desc = {
    Text = "Illuminare 2 all'ottenimento di Casiah"
  },
  Task_62239_Name = {
    Text = "Illuminare 2 all'ottenimento di Casiah"
  },
  Task_62239_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Dono Illuminazione 1 Risvegliatore Casiah Evento"
  },
  Task_62240_Desc = {
    Text = "Illuminare 2 all'ottenimento di Faros"
  },
  Task_62240_Name = {
    Text = "Illuminare 2 all'ottenimento di Faros"
  },
  Task_62240_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 1 del Risveglio di Faros Evento"
  },
  Task_62241_Desc = {
    Text = "Illuminare 6 all'ottenimento di Hameln"
  },
  Task_62241_Name = {
    Text = "Illuminare 6 all'ottenimento di Hameln"
  },
  Task_62241_UnlockCondDesc = {
    Text = "Evento @ Evento Pack Illuminare 2 Risvegliatore Hameln"
  },
  Task_62242_Desc = {
    Text = "Illuminare 6 all'ottenimento di Tintura"
  },
  Task_62242_Name = {
    Text = "Illuminare 6 all'ottenimento di Tintura"
  },
  Task_62242_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 2 del Risveglio di Tintura Evento"
  },
  Task_62243_Desc = {
    Text = "Illuminare 6 all'ottenimento di Golia"
  },
  Task_62243_Name = {
    Text = "Illuminare 6 all'ottenimento di Golia"
  },
  Task_62243_UnlockCondDesc = {
    Text = "Evento @Risveglio Golia Pacchetto Illuminare 2 Evento"
  },
  Task_62244_Desc = {
    Text = "Illuminare 2 all'ottenimento di Tintura"
  },
  Task_62244_Name = {
    Text = "Illuminare 2 all'ottenimento di Tintura"
  },
  Task_62244_UnlockCondDesc = {
    Text = "Evento @ Evento Pack Illuminare 1 del Risveglio Tintura"
  },
  Task_62245_Desc = {
    Text = "Illuminare 6 all'ottenimento di Leigh"
  },
  Task_62245_Name = {
    Text = "Illuminare 6 all'ottenimento di Leigh"
  },
  Task_62245_UnlockCondDesc = {
    Text = "Evento @Risveglio Leigh Pacchetto Illuminare 2 Evento"
  },
  Task_62246_Desc = {
    Text = "Illuminare 6 all'ottenimento di Tulu"
  },
  Task_62246_Name = {
    Text = "Illuminare 6 all'ottenimento di Tulu"
  },
  Task_62246_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 2 del Risveglio di Tulu Evento"
  },
  Task_62247_Desc = {
    Text = "Illuminare 2 all'ottenimento di Uvhash"
  },
  Task_62247_Name = {
    Text = "Illuminare 2 all'ottenimento di Uvhash"
  },
  Task_62247_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 1 Risvegliatore Uvhash Evento"
  },
  Task_62248_Desc = {
    Text = "Illuminare 2 all'ottenimento di Tulu"
  },
  Task_62248_Name = {
    Text = "Illuminare 2 all'ottenimento di Tulu"
  },
  Task_62248_UnlockCondDesc = {
    Text = "Evento @ Evento Pack Illuminare 1 del Risveglio Tulu"
  },
  Task_62249_Desc = {
    Text = "Illuminare 6 all'ottenimento di Lily"
  },
  Task_62249_Name = {
    Text = "Illuminare 6 all'ottenimento di Lily"
  },
  Task_62249_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 2 del Risveglio di Lily Evento"
  },
  Task_62250_Desc = {
    Text = "Illuminare 2 all'ottenimento di Faint"
  },
  Task_62250_Name = {
    Text = "Illuminare 2 all'ottenimento di Faint"
  },
  Task_62250_UnlockCondDesc = {
    Text = "Evento @ Evento Pack Illuminare 1 del Risveglio Faint"
  },
  Task_62251_Desc = {
    Text = "Illuminare 6 all'ottenimento di Daffodil"
  },
  Task_62251_Name = {
    Text = "Illuminare 6 all'ottenimento di Daffodil"
  },
  Task_62251_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 2 del Risveglio di Daffodil Evento"
  },
  Task_62252_Desc = {
    Text = "Illuminare 6 all'ottenimento di Agrippa"
  },
  Task_62252_Name = {
    Text = "Illuminare 6 all'ottenimento di Agrippa"
  },
  Task_62252_UnlockCondDesc = {
    Text = "Evento @Risveglio Agrippa Pacchetto Illuminare 2 Evento"
  },
  Task_62253_Desc = {
    Text = "Illuminare 2 all'ottenimento di Pandia"
  },
  Task_62253_Name = {
    Text = "Illuminare 2 all'ottenimento di Pandia"
  },
  Task_62253_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 1 Risvegliatore Pandia Evento"
  },
  Task_62254_Desc = {
    Text = "Illuminare 2 all'ottenimento di Daffodil"
  },
  Task_62254_Name = {
    Text = "Illuminare 2 all'ottenimento di Daffodil"
  },
  Task_62254_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 1 Risvegliatore Daffodil Evento"
  },
  Task_62255_Desc = {
    Text = "Illuminare 2 all'ottenimento di Sorel"
  },
  Task_62255_Name = {
    Text = "Illuminare 2 all'ottenimento di Sorel"
  },
  Task_62255_UnlockCondDesc = {
    Text = "Evento @ Evento Pack Illuminare 1 del Risveglio Sorel"
  },
  Task_62256_Desc = {
    Text = "Illuminare 6 all'ottenimento di Pandia"
  },
  Task_62256_Name = {
    Text = "Illuminare 6 all'ottenimento di Pandia"
  },
  Task_62256_UnlockCondDesc = {
    Text = "Evento @Risveglio Pandia Pacco Dono Illuminare 2 Evento"
  },
  Task_62257_Desc = {
    Text = "Illuminare 6 all'ottenimento di \"24\""
  },
  Task_62257_Name = {
    Text = "Illuminare 6 all'ottenimento di \"24\""
  },
  Task_62257_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Dono Illuminazione 2 del Risveglio di \"24\" Evento"
  },
  Task_62258_Desc = {
    Text = "Illuminare 2 all'ottenimento di Liz"
  },
  Task_62258_Name = {
    Text = "Illuminare 2 all'ottenimento di Liz"
  },
  Task_62258_UnlockCondDesc = {
    Text = "Evento @ Evento Pack Illuminare 1 del Risveglio Liz"
  },
  Task_62259_Desc = {
    Text = "Illuminare 2 all'ottenimento di \"24\""
  },
  Task_62259_Name = {
    Text = "Illuminare 2 all'ottenimento di \"24\""
  },
  Task_62259_UnlockCondDesc = {
    Text = "Evento @ Evento Pack Dono Illuminare 1 del Risveglio \"24\""
  },
  Task_62260_Desc = {
    Text = "Illuminare 6 all'ottenimento di Liz"
  },
  Task_62260_Name = {
    Text = "Illuminare 6 all'ottenimento di Liz"
  },
  Task_62260_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 2 del Risveglio di Liz Evento"
  },
  Task_62261_Desc = {
    Text = "Illuminare 2 all'ottenimento di Helot"
  },
  Task_62261_Name = {
    Text = "Illuminare 2 all'ottenimento di Helot"
  },
  Task_62261_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 1 del Risveglio di Helot Evento"
  },
  Task_62262_Desc = {
    Text = "Illuminare 2 all'ottenimento di Salvador"
  },
  Task_62262_Name = {
    Text = "Illuminare 2 all'ottenimento di Salvador"
  },
  Task_62262_UnlockCondDesc = {
    Text = "Evento @ Evento Pack Illuminare 1 del Risveglio Salvador"
  },
  Task_62263_Desc = {
    Text = "Illuminare 6 all'ottenimento di Helot"
  },
  Task_62263_Name = {
    Text = "Illuminare 6 all'ottenimento di Helot"
  },
  Task_62263_UnlockCondDesc = {
    Text = "Evento @Risveglio Helot Pacchetto Illuminazione 2 Evento"
  },
  Task_62264_Desc = {
    Text = "Illuminare 6 all'ottenimento di Salvador"
  },
  Task_62264_Name = {
    Text = "Illuminare 6 all'ottenimento di Salvador"
  },
  Task_62264_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 2 del Risveglio di Salvador Evento"
  },
  Task_62265_Desc = {
    Text = "Illuminare 2 all'ottenimento di Nymphaea"
  },
  Task_62265_Name = {
    Text = "Illuminare 2 all'ottenimento di Nymphaea"
  },
  Task_62265_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 1 Risvegliatore Nymphaea Evento"
  },
  Task_62266_Desc = {
    Text = "Illuminare 2 all'ottenimento di Murphy"
  },
  Task_62266_Name = {
    Text = "Illuminare 2 all'ottenimento di Murphy"
  },
  Task_62266_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 1 Risvegliatore Murphy Evento"
  },
  Task_62267_Desc = {
    Text = "Illuminare 2 all'ottenimento di Ryker"
  },
  Task_62267_Name = {
    Text = "Illuminare 2 all'ottenimento di Ryker"
  },
  Task_62267_UnlockCondDesc = {
    Text = "Evento @ Evento Pack Illuminare 1 del Risveglio Ryker"
  },
  Task_62268_Desc = {
    Text = "Illuminare 6 all'ottenimento di Tawil"
  },
  Task_62268_Name = {
    Text = "Illuminare 6 all'ottenimento di Tawil"
  },
  Task_62268_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 2 del Risveglio di Tawil Evento"
  },
  Task_62269_Desc = {
    Text = "Illuminare 6 all'ottenimento di Faros"
  },
  Task_62269_Name = {
    Text = "Illuminare 6 all'ottenimento di Faros"
  },
  Task_62269_UnlockCondDesc = {
    Text = "Evento @Risveglio Faros Pacchetto Illuminazione 2 Evento"
  },
  Task_62270_Desc = {
    Text = "Illuminare 2 all'ottenimento di Tawil"
  },
  Task_62270_Name = {
    Text = "Illuminare 2 all'ottenimento di Tawil"
  },
  Task_62270_UnlockCondDesc = {
    Text = "Evento @ Evento Pack Illuminare 1 del Risveglio Tawil"
  },
  Task_62271_Desc = {
    Text = "Illuminare 6 all'ottenimento di Faint"
  },
  Task_62271_Name = {
    Text = "Illuminare 6 all'ottenimento di Faint"
  },
  Task_62271_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 2 del Risveglio di Faint Evento"
  },
  Task_62272_Desc = {
    Text = "Illuminare 6 all'ottenimento di Sorel"
  },
  Task_62272_Name = {
    Text = "Illuminare 6 all'ottenimento di Sorel"
  },
  Task_62272_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 2 del Risveglio di Sorel Evento"
  },
  Task_62273_Desc = {
    Text = "Illuminare 2 all'ottenimento di Sanga"
  },
  Task_62273_Name = {
    Text = "Illuminare 2 all'ottenimento di Sanga"
  },
  Task_62273_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 1 del Risveglio di Sanga Evento"
  },
  Task_62274_Desc = {
    Text = "Illuminare 2 all'ottenimento di Golia"
  },
  Task_62274_Name = {
    Text = "Illuminare 2 all'ottenimento di Golia"
  },
  Task_62274_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 1 del Risveglio di Golia Evento"
  },
  Task_62275_Desc = {
    Text = "Illuminare 2 all'ottenimento di Miryam"
  },
  Task_62275_Name = {
    Text = "Illuminare 2 all'ottenimento di Miryam"
  },
  Task_62275_UnlockCondDesc = {
    Text = "Evento @ Evento Pack Illuminare 1 del Risveglio Miryam"
  },
  Task_62276_Desc = {
    Text = "Illuminare 6 all'ottenimento di Winkle"
  },
  Task_62276_Name = {
    Text = "Illuminare 6 all'ottenimento di Winkle"
  },
  Task_62276_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 2 del Risveglio di Winkle Evento"
  },
  Task_62277_Desc = {
    Text = "Illuminare 2 all'ottenimento di Caecus"
  },
  Task_62277_Name = {
    Text = "Illuminare 2 all'ottenimento di Caecus"
  },
  Task_62277_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Dono Illuminazione 1 Risvegliatore Caecus Evento"
  },
  Task_62278_Desc = {
    Text = "Illuminare 6 all'ottenimento di Miryam"
  },
  Task_62278_Name = {
    Text = "Illuminare 6 all'ottenimento di Miryam"
  },
  Task_62278_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 2 del Risveglio di Miryam Evento"
  },
  Task_62279_Desc = {
    Text = "Illuminare 2 all'ottenimento di Winkle"
  },
  Task_62279_Name = {
    Text = "Illuminare 2 all'ottenimento di Winkle"
  },
  Task_62279_UnlockCondDesc = {
    Text = "Evento @ Evento Pack Illuminare 1 del Risveglio Winkle"
  },
  Task_62280_Desc = {
    Text = "Illuminare 6 all'ottenimento di Caecus"
  },
  Task_62280_Name = {
    Text = "Illuminare 6 all'ottenimento di Caecus"
  },
  Task_62280_UnlockCondDesc = {
    Text = "Evento @Risveglio Caecus Pacco Dono Illuminare 2 Evento"
  },
  Task_62281_Desc = {
    Text = "Illuminare 2 all'ottenimento di Nautila"
  },
  Task_62281_Name = {
    Text = "Illuminare 2 all'ottenimento di Nautila"
  },
  Task_62281_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 1 Risvegliatore Nautila Evento"
  },
  Task_62282_Desc = {
    Text = "Illuminare 2 all'ottenimento di Leigh"
  },
  Task_62282_Name = {
    Text = "Illuminare 2 all'ottenimento di Leigh"
  },
  Task_62282_UnlockCondDesc = {
    Text = "Evento @ Evento Pack Illuminare 1 del Risveglio Leigh"
  },
  Task_62283_Desc = {
    Text = "Illuminare 2 all'ottenimento di Celeste"
  },
  Task_62283_Name = {
    Text = "Illuminare 2 all'ottenimento di Celeste"
  },
  Task_62283_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 1 del Risveglio di Celeste Evento"
  },
  Task_62284_Desc = {
    Text = "Illuminare 2 all'ottenimento di Karen"
  },
  Task_62284_Name = {
    Text = "Illuminare 2 all'ottenimento di Karen"
  },
  Task_62284_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 1 del Risveglio di Karen Evento"
  },
  Task_62285_Desc = {
    Text = "Illuminare 6 all'ottenimento di Sanga"
  },
  Task_62285_Name = {
    Text = "Illuminare 6 all'ottenimento di Sanga"
  },
  Task_62285_UnlockCondDesc = {
    Text = "Evento @Risveglio Sanga Pacchetto Illuminazione 2 Evento"
  },
  Task_62286_Desc = {
    Text = "Illuminare 6 all'ottenimento di Celeste"
  },
  Task_62286_Name = {
    Text = "Illuminare 6 all'ottenimento di Celeste"
  },
  Task_62286_UnlockCondDesc = {
    Text = "Evento @Risveglio Celeste Pacchetto Illuminare 2 Evento"
  },
  Task_62287_Desc = {
    Text = "Illuminare 6 all'ottenimento di Karen"
  },
  Task_62287_Name = {
    Text = "Illuminare 6 all'ottenimento di Karen"
  },
  Task_62287_UnlockCondDesc = {
    Text = "Evento @Risveglio Karen Pacchetto Illuminazione 2 Evento"
  },
  Task_62288_Desc = {
    Text = "Illuminare 6 all'ottenimento di Nautila"
  },
  Task_62288_Name = {
    Text = "Illuminare 6 all'ottenimento di Nautila"
  },
  Task_62288_UnlockCondDesc = {
    Text = "Evento @Risveglio Nautila Pacco Dono Illuminare 2 Evento"
  },
  Task_62289_Desc = {
    Text = "Illuminare 6 all'ottenimento di Murphy"
  },
  Task_62289_Name = {
    Text = "Illuminare 6 all'ottenimento di Murphy"
  },
  Task_62289_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 2 del Risveglio di Murphy Evento"
  },
  Task_62290_Desc = {
    Text = "Illuminare 6 all'ottenimento di Horla"
  },
  Task_62290_Name = {
    Text = "Illuminare 6 all'ottenimento di Horla"
  },
  Task_62290_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 2 del Risveglio di Horla Evento"
  },
  Task_62291_Desc = {
    Text = "Illuminare 2 all'ottenimento di Thais"
  },
  Task_62291_Name = {
    Text = "Illuminare 2 all'ottenimento di Thais"
  },
  Task_62291_UnlockCondDesc = {
    Text = "Evento @ Evento Pack Illuminare 1 del Risveglio Thais"
  },
  Task_62292_Desc = {
    Text = "Illuminare 6 all'ottenimento di Alva"
  },
  Task_62292_Name = {
    Text = "Illuminare 6 all'ottenimento di Alva"
  },
  Task_62292_UnlockCondDesc = {
    Text = "Evento @Risveglio Alva Pacchetto Illuminazione 2 Evento"
  },
  Task_62293_Desc = {
    Text = "Illuminare 2 all'ottenimento di Agrippa"
  },
  Task_62293_Name = {
    Text = "Illuminare 2 all'ottenimento di Agrippa"
  },
  Task_62293_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 1 del Risveglio di Agrippa Evento"
  },
  Task_62294_Desc = {
    Text = "Illuminare 2 all'ottenimento di Lily"
  },
  Task_62294_Name = {
    Text = "Illuminare 2 all'ottenimento di Lily"
  },
  Task_62294_UnlockCondDesc = {
    Text = "Evento @ Evento Pack Illuminare 1 del Risveglio Lily"
  },
  Task_62295_Desc = {
    Text = "Illuminare 6 all'ottenimento di Thais"
  },
  Task_62295_Name = {
    Text = "Illuminare 6 all'ottenimento di Thais"
  },
  Task_62295_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 2 del Risveglio di Thais Evento"
  },
  Task_62296_Desc = {
    Text = "Illuminare 2 all'ottenimento di Alva"
  },
  Task_62296_Name = {
    Text = "Illuminare 2 all'ottenimento di Alva"
  },
  Task_62296_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 1 del Risveglio di Alva Evento"
  },
  Task_62297_Desc = {
    Text = "Illuminare 6 all'ottenimento di Uvhash"
  },
  Task_62297_Name = {
    Text = "Illuminare 6 all'ottenimento di Uvhash"
  },
  Task_62297_UnlockCondDesc = {
    Text = "Evento @Risveglio Uvhash Pacco Dono Illuminare 2 Evento"
  },
  Task_62298_Desc = {
    Text = "All'ottenimento di Genesi Helot, Illuminare 2"
  },
  Task_62298_Name = {
    Text = "All'ottenimento di Genesi Helot, Illuminare 2"
  },
  Task_62298_UnlockCondDesc = {
    Text = "Evento @ Pacchetto Illuminazione 1 Risvegliatore Genesi Helot Evento"
  },
  Task_62299_Desc = {
    Text = "All'ottenimento di Genesi Helot, Illuminare 6"
  },
  Task_62299_Name = {
    Text = "All'ottenimento di Genesi Helot, Illuminare 6"
  },
  Task_62299_UnlockCondDesc = {
    Text = "Evento @ Evento Pack Illuminare 2 Risvegliatore Genesi Helot"
  },
  Task_62300_Desc = {
    Text = "Illuminare 6 all'ottenimento di Casiah"
  },
  Task_62300_Name = {
    Text = "Illuminare 6 all'ottenimento di Casiah"
  },
  Task_62300_UnlockCondDesc = {
    Text = "Evento @ Evento Pack Illuminare 2 Risvegliatore Casiah"
  },
  Task_62320_Desc = {
    Text = "Completa il record speciale \"Il Reduce di Elworth\" in difficoltà Difficile"
  },
  Task_62320_Name = {
    Text = "Vita, Oltre la Montagna: Hard"
  },
  Task_62321_Desc = {
    Text = "Completa la Storia Principale \"L'Ultima Sinfonia\" in difficoltà difficile"
  },
  Task_62321_Name = {
    Text = "Battaglia, in Nome del Ricordo: Difficile"
  },
  Task_62322_Desc = {
    Text = "Completa l'evento d'indagine \"@1@2\""
  },
  Task_62322_Desc2 = {
    Text = "Completa la Storia Principale \"Ultima Sinfonia\""
  },
  Task_62322_Name2 = {
    Text = "Battaglia, in Nome del Ricordo"
  },
  Task_62323_Desc = {
    Text = "Risuona 3 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_62323_Desc2 = {
    Text = "Entra in Risonanza 3 volte nella Storia Principale \"L'Ultima Sinfonia\""
  },
  Task_62323_Name2 = {
    Text = "Eco di Resilienza"
  },
  Task_62324_Desc = {
    Text = "Completa il registro speciale \"Buona Caccia!\""
  },
  Task_62324_Name = {
    Text = "Crudele Beffa del Destino"
  },
  Task_62325_Desc = {
    Text = "Risuona 9 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_62325_Desc2 = {
    Text = "Entra in Risonanza 9 volte nella Storia Principale \"L'Ultima Sinfonia\""
  },
  Task_62325_Name2 = {
    Text = "Eco di Resilienza III"
  },
  Task_62326_Desc = {
    Text = "Trova 10 Punti di Estrazione nel Capitolo 8 della Missione principale \"@1@2\""
  },
  Task_62326_Desc2 = {
    Text = "Trova 10 Punti di Estrazione nel Capitolo 8 della Storia Principale \"L'Ultima Sinfonia\""
  },
  Task_62326_Name2 = {
    Text = "Sussurro celato VIII"
  },
  Task_62327_Desc = {
    Text = "Completa il registro speciale \"Il Reduce di Elworth\""
  },
  Task_62327_Name = {
    Text = "La Vita Squarcia la Montagna"
  },
  Task_62328_Desc = {
    Text = "Completa il record speciale \"Buona Caccia!\" in difficoltà Difficile"
  },
  Task_62328_Name = {
    Text = "Crudele Beffa del Destino: Hard"
  },
  Task_62329_Desc = {
    Text = "Completa il registro speciale \"Habitat della Rosa\""
  },
  Task_62329_Name = {
    Text = "Fragranza di Fiori e Poesia"
  },
  Task_62330_Desc = {
    Text = "Risuona 6 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_62330_Desc2 = {
    Text = "Entra in Risonanza 6 volte nella Storia Principale \"L'Ultima Sinfonia\""
  },
  Task_62330_Name2 = {
    Text = "Eco di Resilienza II"
  },
  Task_62331_Desc = {
    Text = "Ottieni 13 Risonanze nell'Evento d'Indagine \"@1@2\""
  },
  Task_62331_Desc2 = {
    Text = "Entra in Risonanza 13 volte nella Storia Principale \"L'Ultima Sinfonia\""
  },
  Task_62331_Name2 = {
    Text = "Eco di Resilienza IV"
  },
  Task_62332_Desc = {
    Text = "Completa il record speciale \"L'Habitat di Rosa\" in difficoltà Difficile"
  },
  Task_62332_Name = {
    Text = "Fragranza di Fiori e Poesia: Hard"
  },
  Task_62346_Desc = {
    Text = "Sconfiggi \"La Teoria dell'Oblio Completo\" senza ricorrere all'assistenza di Ramona."
  },
  Task_62346_Name = {
    Text = "Suprema Maestà Solitaria"
  },
  Task_62371_Desc = {
    Text = "Con l'assistenza di Ramona, sconfiggi \"L'inizio dimenticato\""
  },
  Task_62371_Name = {
    Text = "Stringi la mia mano, Custode"
  },
  Task_65510_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_65511_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_65512_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_65513_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_65514_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_65515_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_65516_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_65517_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_65518_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_65519_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_65722_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per vincere una volta in \"Codice della Memoria\""
  },
  Task_65723_Desc = {
    Text = "Completa \"Sguardo dello Specchio\" a qualsiasi difficoltà"
  },
  Task_65724_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere una volta in \"Codice della Memoria\""
  },
  Task_65725_Desc = {
    Text = "Codice della Memoria: Completamento"
  },
  Task_65726_Desc = {
    Text = "Codice della Memoria: Reame"
  },
  Task_65727_Desc = {
    Text = "Completa \"Richiamo dell'Amigdala\" a Difficoltà Follia"
  },
  Task_65728_Desc = {
    Text = "Completa \"Curva dell'Oblio\" a Difficoltà Follia"
  },
  Task_65729_Desc = {
    Text = "Vinci una volta in \"Codice della Memoria\" usando un qualsiasi Risvegliatore del Caos"
  },
  Task_65730_Desc = {
    Text = "Completa \"Richiamo dell'Amigdala\" a qualsiasi difficoltà"
  },
  Task_65731_Desc = {
    Text = "Completa \"Richiamo dell'Amigdala\" a qualsiasi difficoltà"
  },
  Task_65732_Desc = {
    Text = "Completa \"Sguardo dello Specchio\" a qualsiasi difficoltà"
  },
  Task_65733_Desc = {
    Text = "Completa \"Curva dell'Oblio\" a qualsiasi difficoltà"
  },
  Task_65734_Desc = {
    Text = "Completa \"Psiche del Rettile\" a qualsiasi difficoltà"
  },
  Task_65735_Desc = {
    Text = "Si sblocca dopo aver completato tutte le missioni di \"Codice della Memoria: Completato\""
  },
  Task_65736_Desc = {
    Text = "Completa \"Curva dell'Oblio\" a qualsiasi difficoltà"
  },
  Task_65737_Desc = {
    Text = "Completa \"Ricordo Evanescente\" a qualsiasi difficoltà"
  },
  Task_65738_Desc = {
    Text = "Completa \"Sguardo dello Specchio\" a Difficoltà Follia"
  },
  Task_65739_Desc = {
    Text = "Codice della Memoria: Follia"
  },
  Task_65740_Desc = {
    Text = "Completa \"Ricordo Evanescente\" a qualsiasi difficoltà"
  },
  Task_65741_Desc = {
    Text = "Completa il Registro Operazioni Speciali \"Fissione Serena\""
  },
  Task_65742_Desc = {
    Text = "Completa \"Ricordo Evanescente\" a Difficoltà Follia"
  },
  Task_65743_Desc = {
    Text = "Completa \"Psiche del Rettile\" a qualsiasi difficoltà"
  },
  Task_65744_Desc = {
    Text = "Completa \"Psiche del Rettile\" a Difficoltà Follia"
  },
  Task_65745_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere una volta in \"Codice della Memoria\""
  },
  Task_66015_Desc = {
    Text = "L'Affinità di Tawil raggiunge il Livello 10"
  },
  Task_66213_Desc = {
    Text = "Natività del Regno Divino: Follia"
  },
  Task_66214_Desc = {
    Text = "Usa un qualsiasi Risvegliato del Reame Ultra per vincere una volta in \"Natività del Regno Divino\""
  },
  Task_66215_Desc = {
    Text = "Completa \"Testimone Silenzioso\" a qualsiasi difficoltà"
  },
  Task_66216_Desc = {
    Text = "Completa \"Tremore\" a Difficoltà Follia"
  },
  Task_66217_Desc = {
    Text = "Completa \"L'Avvento\" a qualsiasi difficoltà"
  },
  Task_66218_Desc = {
    Text = "Completa \"Cuore Devoto\" a Difficoltà Follia"
  },
  Task_66219_Desc = {
    Text = "Usa un qualsiasi Risvegliato del Reame del Caos per vincere una volta in \"Natività del Regno Divino\""
  },
  Task_66220_Desc = {
    Text = "Completa \"Cuore Devoto\" a qualsiasi difficoltà"
  },
  Task_66221_Desc = {
    Text = "Completa \"Testimone Silenzioso\" a qualsiasi difficoltà"
  },
  Task_66224_Desc = {
    Text = "Completa \"Dubbio Eterno\" a qualsiasi difficoltà"
  },
  Task_66227_Desc = {
    Text = "Completa il Paesaggio Onirico \"Profanazione\""
  },
  Task_66228_Desc = {
    Text = "Completa tutti gli incarichi in \"Natività del Regno Divino: Completato\""
  },
  Task_66229_Desc = {
    Text = "Completa \"Testimone Silenzioso\" a Difficoltà Follia"
  },
  Task_66230_Desc = {
    Text = "Usa un qualsiasi Risvegliato del Reame Aequor per vincere una volta in \"Natività del Regno Divino\""
  },
  Task_66231_Desc = {
    Text = "Completa \"L'Avvento\" a Difficoltà Follia"
  },
  Task_66232_Desc = {
    Text = "Natività del Regno Divino: Reame"
  },
  Task_66233_Desc = {
    Text = "Completa \"Tremore\" a qualsiasi difficoltà"
  },
  Task_66235_Desc = {
    Text = "Completa \"Dubbio Eterno\" a Difficoltà Follia"
  },
  Task_66236_Desc = {
    Text = "Usa un qualsiasi Risvegliato del Reame Caro per vincere una volta in \"Natività del Regno Divino\""
  },
  Task_66237_Desc = {
    Text = "Completa \"L'Avvento\" a qualsiasi difficoltà"
  },
  Task_66238_Desc = {
    Text = "Completa \"Tremore\" a qualsiasi difficoltà"
  },
  Task_66240_Desc = {
    Text = "Natività del Regno Divino: Completato"
  },
  Task_66241_Desc = {
    Text = "Completa \"Cuore Devoto\" a qualsiasi difficoltà"
  },
  Task_66242_Desc = {
    Text = "Completa \"Dubbio Eterno\" a qualsiasi difficoltà"
  },
  Task_66243_Desc = {
    Text = "Risposta dell'Abisso"
  },
  Task_66335_Desc = {
    Text = "Fuggi dalla Caccia del Comitato"
  },
  Task_66335_Name = {Text = "Bersaglio"},
  Task_66336_Desc = {
    Text = "Impedisci al segugio dal volto umano di fare rapporto"
  },
  Task_66336_Name = {Text = "Bersaglio"},
  Task_66337_Desc = {
    Text = "Sfonda il blocco del Comitato"
  },
  Task_66337_Name = {Text = "Bersaglio"},
  Task_66338_Desc = {
    Text = "Sconfiggere Thais"
  },
  Task_66338_Name = {Text = "Bersaglio"},
  Task_66339_Desc = {
    Text = "Sconfiggere N"
  },
  Task_66339_Name = {Text = "Bersaglio"},
  Task_66340_Desc = {
    Text = "Ferma l'invasione del Comitato"
  },
  Task_66340_Name = {Text = "Bersaglio"},
  Task_66341_Desc = {
    Text = "Distruggi le Statue Gemelle"
  },
  Task_66341_Name = {Text = "Bersaglio"},
  Task_66342_Desc = {
    Text = "Resistere a Hameln"
  },
  Task_66342_Name = {Text = "Bersaglio"},
  Task_66343_Desc = {
    Text = "Trovare Tawil"
  },
  Task_66343_Name = {Text = "Bersaglio"},
  Task_66344_Desc = {
    Text = "Fermare Juliette"
  },
  Task_66344_Name = {Text = "Bersaglio"},
  Task_66422_Name = {
    Text = "Sconfiggi il BOSS 1N volte"
  },
  Task_66423_Name = {
    Text = "Sconfiggi il BOSS 2N volte"
  },
  Task_66424_Name = {
    Text = "Sconfiggi il BOSS 3N volte"
  },
  Task_66425_Name = {
    Text = "Sconfiggi il BOSS 4N volte"
  },
  Task_66426_Name = {
    Text = "Sconfiggi il BOSS 5N volte"
  },
  Task_66428_Name = {
    Text = "Uccidere tutti i BOSS"
  },
  Task_66580_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_66580_Name = {
    Text = "Superamento Perfetto"
  },
  Task_66581_Desc = {
    Text = "Portare almeno 8 Reliquie al completamento."
  },
  Task_66581_Name = {
    Text = "Scorta segreta"
  },
  Task_66582_Desc = {
    Text = "Vinci la battaglia finale entro 25 turni"
  },
  Task_66582_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_66583_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_66583_Name = {
    Text = "Elegante e Preciso"
  },
  Task_66584_Desc = {
    Text = "Portare almeno 8 Reliquie al completamento."
  },
  Task_66584_Name = {
    Text = "Scorta segreta"
  },
  Task_66585_Desc = {
    Text = "Nella Battaglia finale, infliggi almeno 200000 punti di Danno in un singolo turno."
  },
  Task_66585_Name = {
    Text = "Colpo con Tutta la Forza"
  },
  Task_66724_Desc = {
    Text = "Completamento di \"Inizio del Viaggio\" a Difficoltà Follia"
  },
  Task_66725_Desc = {
    Text = "Completamento di \"Porta dei Mondi\" a Difficoltà Follia"
  },
  Task_66726_Desc = {
    Text = "Completamento di \"Porta della Conoscenza\" a Difficoltà Follia"
  },
  Task_66727_Desc = {
    Text = "Completamento di \"Porta degli estremi\" a qualsiasi difficoltà"
  },
  Task_66728_Desc = {
    Text = "Completamento di \"Porta del Vero e del Falso\" in Difficoltà Follia"
  },
  Task_66729_Desc = {
    Text = "Completamento di \"Porta dell'Unità\" a qualsiasi difficoltà"
  },
  Task_66730_Desc = {
    Text = "Completa \"Inizio del Viaggio\" a qualsiasi difficoltà"
  },
  Task_66731_Desc = {
    Text = "Completa \"Porta del Vero e del Falso\" a qualsiasi difficoltà"
  },
  Task_66732_Desc = {
    Text = "Completamento di \"Oltre la Porta\" a Difficoltà Follia"
  },
  Task_66733_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere due volte in \"Test finale\""
  },
  Task_66734_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere due volte in \"Test finale\""
  },
  Task_66735_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere due volte in \"Test finale\""
  },
  Task_66736_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere una volta in \"Test finale\""
  },
  Task_66737_Desc = {
    Text = "Completa \"Porta del Vero e del Falso\" a qualsiasi difficoltà"
  },
  Task_66738_Desc = {
    Text = "Completa \"Porta della Conoscenza\" a qualsiasi difficoltà"
  },
  Task_66739_Desc = {
    Text = "Test finale: Follia"
  },
  Task_66740_Desc = {
    Text = "Completa \"Porta della Conoscenza\" a qualsiasi difficoltà"
  },
  Task_66741_Desc = {
    Text = "Completamento di \"Porta dei Mondi\" a qualsiasi difficoltà"
  },
  Task_66742_Desc = {
    Text = "Completamento di \"Porta degli estremi\" a qualsiasi difficoltà"
  },
  Task_66743_Desc = {
    Text = "Completamento di \"Oltre la Porta\" a qualsiasi difficoltà"
  },
  Task_66744_Desc = {
    Text = "Test finale: Completato"
  },
  Task_66745_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per vincere due volte in \"Test finale\""
  },
  Task_66746_Desc = {
    Text = "Vinci una volta nel \"Test finale\" usando un qualsiasi Risvegliatore di Caro"
  },
  Task_66747_Desc = {
    Text = "Completamento di \"Porta della ragione\" a Difficoltà Follia"
  },
  Task_66748_Desc = {
    Text = "Completamento di \"Porta dell'Unità\" a Difficoltà Follia"
  },
  Task_66749_Desc = {
    Text = "Completa \"Inizio del Viaggio\" a qualsiasi difficoltà"
  },
  Task_66750_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere due volte in \"Test finale\""
  },
  Task_66751_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere una volta in \"Test finale\""
  },
  Task_66752_Desc = {
    Text = "Completamento di \"Oltre la Porta\" a qualsiasi difficoltà"
  },
  Task_66753_Desc = {
    Text = "Completa \"Porta dell'Essenza\" a qualsiasi difficoltà"
  },
  Task_66754_Desc = {
    Text = "Completamento di \"Porta dell'Essenza\" a Difficoltà Follia"
  },
  Task_66755_Desc = {
    Text = "Completamento di \"Porta degli estremi\" a Difficoltà Follia"
  },
  Task_66756_Desc = {
    Text = "Test finale: Reame"
  },
  Task_66757_Desc = {
    Text = "Si sblocca dopo aver completato tutte le missioni in \"Test finale: Completato\""
  },
  Task_66758_Desc = {
    Text = "Completa \"Porta della ragione\" a qualsiasi difficoltà"
  },
  Task_66759_Desc = {
    Text = "Completa \"Porta dell'Essenza\" a qualsiasi difficoltà"
  },
  Task_66760_Desc = {
    Text = "Completamento di \"Porta dei Mondi\" a qualsiasi difficoltà"
  },
  Task_66761_Desc = {
    Text = "Completa \"Porta della ragione\" a qualsiasi difficoltà"
  },
  Task_66762_Desc = {
    Text = "Completamento di \"Porta dell'Unità\" a qualsiasi difficoltà"
  },
  Task_67066_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_67067_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_67068_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_67069_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_67070_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_67071_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_67072_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_67073_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_67075_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_67076_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_67113_Desc = {
    Text = "Trova 2 Punti di Estrazione nella Fine Ultima della storia principale \"@1@2\""
  },
  Task_67113_Desc2 = {
    Text = "Individua 2 Punti di Estrazione nella Fine Ultima della Storia principale \"Fine di un Lungo Sogno\""
  },
  Task_67113_Name2 = {
    Text = "Sussurro celato IX"
  },
  Task_67114_Desc = {
    Text = "Completa la Storia principale \"Fine di un Lungo Sogno\" a difficoltà ardua"
  },
  Task_67114_Name = {
    Text = "Vegliare, fino alla Morte: Hard"
  },
  Task_67115_Desc = {
    Text = "Completa l'evento d'indagine \"@1@2\""
  },
  Task_67115_Desc2 = {
    Text = "Completa la Storia Principale \"Fine di un Lungo Sogno\""
  },
  Task_67115_Name2 = {
    Text = "Vegliare, fino alla Morte"
  },
  Task_67116_Desc = {
    Text = "Risuona 3 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_67116_Desc2 = {
    Text = "Effettua la Risonanza 3 volte nella Storia principale \"Fine di un Lungo Sogno\""
  },
  Task_67116_Name2 = {
    Text = "Eco degli estremi"
  },
  Task_67125_Name = {
    Text = "Sconfiggi il BOSS 6N volte"
  },
  Task_67126_Name = {
    Text = "Sconfiggi il BOSS 7N volte"
  },
  Task_67408_Desc = {
    Text = "Fermare il Tohuwabohu, chiudere il Portale"
  },
  Task_67408_Name = {Text = "Bersaglio"},
  Task_67409_Desc = {
    Text = "Trovare la talpa all'interno di Mythag"
  },
  Task_67409_Name = {Text = "Bersaglio"},
  Task_67410_Desc = {
    Text = "Fermare il Tohuwabohu"
  },
  Task_67410_Name = {Text = "Bersaglio"},
  Task_67411_Desc = {
    Text = "Addio ai Risvegliati"
  },
  Task_67411_Name = {Text = "Bersaglio"},
  Task_67827_Desc = {
    Text = "Sottomettiti... all'eterna verità del caos..."
  },
  Task_67827_Name = {
    Text = "Sottomettiti... all'eterna verità del caos..."
  },
  Task_67828_Desc = {
    Text = "La sua Follia supera la tua Resistenza."
  },
  Task_67828_Name = {
    Text = "La sua Follia supera la tua Resistenza."
  },
  Task_67829_Desc = {
    Text = "La sua maestosità proibisce uno Sguardo diretto."
  },
  Task_67829_Name = {
    Text = "La sua maestosità proibisce uno Sguardo diretto."
  },
  Task_67919_Desc = {
    Text = "Sconfiggi tutti i cloni in \"Sona-Nyl: Visione di Follia\" per sbloccare."
  },
  Task_67919_Name = {
    Text = "Uccidere il BOSS 6"
  },
  Task_67920_Desc = {
    Text = "Sconfiggi tutti i cloni di \"Museo delle Cere: Visione della Paura\" per sbloccare"
  },
  Task_67920_Name = {
    Text = "Uccidere il BOSS2"
  },
  Task_67921_Desc = {
    Text = "Sconfiggi tutti i cloni di \"Sanatorio: Visione dell'Enigma\" per sbloccare"
  },
  Task_67921_Name = {
    Text = "Uccidere il BOSS 4"
  },
  Task_67922_Desc = {
    Text = "Elimina tutti i cloni di \"Brilport, Visuale del Malvagio\" per sbloccare"
  },
  Task_67922_Name = {
    Text = "Uccidere il BOSS 5"
  },
  Task_67923_Desc = {
    Text = "Sconfiggi tutti i cloni di \"Ospizio dei Poveri: Visione del Lamento\" per sbloccare"
  },
  Task_67923_Name = {
    Text = "Uccidere il BOSS1"
  },
  Task_67924_Desc = {
    Text = "Elimina tutti i cloni di \"Remouahe: Visuale della Nascita\" per sbloccare"
  },
  Task_67924_Name = {
    Text = "Uccidere il BOSS 7"
  },
  Task_67925_Desc = {
    Text = "Sconfiggi tutti i cloni di \"Rai: Visuale dell'Osso Perforante\" per sbloccare"
  },
  Task_67925_Name = {
    Text = "Uccidere il BOSS 3"
  },
  Task_67926_Name = {
    Text = "Sconfiggi tutti i cloni di 5 Visuali Primordiali"
  },
  Task_67927_Name = {
    Text = "Sconfiggi tutti i cloni di 2 Visuali Primordiali"
  },
  Task_67928_Name = {
    Text = "Sconfiggi tutti i cloni di 4 Visuali Primordiali"
  },
  Task_67929_Name = {
    Text = "Sconfiggi tutti i cloni di 6 Visuali Primordiali"
  },
  Task_67930_Name = {
    Text = "Tutti gli avatar della Visione Primordiale sono stati sconfitti"
  },
  Task_67931_Name = {
    Text = "Sconfiggi tutti i cloni di 7 Visuali Primordiali"
  },
  Task_67932_Name = {
    Text = "Sconfiggi tutti i cloni di 3 Visuali Primordiali"
  },
  Task_68342_Desc = {
    Text = "Oltre le Stelle III"
  },
  Task_68343_Desc = {
    Text = "Oltre le Stelle V"
  },
  Task_68344_Desc = {
    Text = "Oltre le Stelle VII"
  },
  Task_68345_Desc = {
    Text = "Oltre le Stelle II"
  },
  Task_68346_Desc = {
    Text = "Oltre le Stelle IV"
  },
  Task_68347_Desc = {
    Text = "Oltre le Stelle I"
  },
  Task_68348_Desc = {
    Text = "Oltre le Stelle VI"
  },
  Task_68365_Desc = {
    Text = "Oltre le Stelle: Libero"
  },
  Task_68377_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_68378_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_68379_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_68380_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_68382_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_68383_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_68384_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_68385_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_68386_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_68387_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_68388_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_68389_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_68390_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_68391_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_68392_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_68393_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_68394_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_68395_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_68396_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_68397_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_68418_Name = {
    Text = "L'evento Boss Mondiale è terminato"
  },
  Task_68492_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere una volta in \"Sguardo del Mare Profondo\""
  },
  Task_68493_Desc = {
    Text = "Completamento di \"Occhio Divino\" a Difficoltà Follia"
  },
  Task_68494_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere una volta in \"Sguardo del Mare Profondo\""
  },
  Task_68495_Desc = {
    Text = "Completamento di \"Piacevole Fantasia\" a qualsiasi difficoltà"
  },
  Task_68496_Desc = {
    Text = "Completamento di \"Piacevole Fantasia\" a Difficoltà Follia"
  },
  Task_68497_Desc = {
    Text = "Completamento di \"Fine dell'Umanità\" a qualsiasi difficoltà"
  },
  Task_68498_Desc = {
    Text = "Completamento di \"Fine dell'Umanità\" a Difficoltà Follia"
  },
  Task_68499_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per vincere una volta in \"Sguardo del Mare Profondo\""
  },
  Task_68500_Desc = {
    Text = "Completamento di \"Occhio Divino\" a qualsiasi difficoltà"
  },
  Task_68501_Desc = {
    Text = "Completamento di \"Fine dell'Umanità\" a qualsiasi difficoltà"
  },
  Task_68502_Desc = {
    Text = "Completamento di \"Nostalgia\" a qualsiasi difficoltà"
  },
  Task_68503_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere una volta in \"Sguardo del Mare Profondo\""
  },
  Task_68504_Desc = {
    Text = "Sguardo del Mare Profondo: Follia"
  },
  Task_68505_Desc = {
    Text = "Completamento di \"Piacevole Fantasia\" a qualsiasi difficoltà"
  },
  Task_68506_Desc = {
    Text = "Completamento di \"Regno in Declino\" a qualsiasi difficoltà"
  },
  Task_68507_Desc = {
    Text = "Sguardo del Mare Profondo: Completamento"
  },
  Task_68508_Desc = {
    Text = "Completamento di \"Nostalgia\" a qualsiasi difficoltà"
  },
  Task_68509_Desc = {
    Text = "Completamento di \"Nostalgia\" a Difficoltà Follia"
  },
  Task_68510_Desc = {
    Text = "Completamento di \"Regno in Declino\" a qualsiasi difficoltà"
  },
  Task_68511_Desc = {
    Text = "Completamento di \"Regno in Declino\" a Difficoltà Follia"
  },
  Task_68512_Desc = {
    Text = "Sguardo del Mare Profondo: Reame"
  },
  Task_68513_Desc = {
    Text = "Completa tutte le missioni in \"Sguardo del Mare Profondo: Completato\""
  },
  Task_68514_Desc = {
    Text = "Completamento di \"Occhio Divino\" a qualsiasi difficoltà"
  },
  Task_68860_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_68860_Name = {Text = "1 vittoria"},
  Task_68861_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_68861_Name = {Text = "6 vittorie"},
  Task_68862_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_68862_Name = {Text = "3 vittorie"},
  Task_68863_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_68863_Name = {
    Text = "10 vittorie"
  },
  Task_68864_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_68864_Name = {Text = "3 vittorie"},
  Task_68865_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_68865_Name = {Text = "6 vittorie"},
  Task_68866_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_68866_Name = {Text = "1 vittoria"},
  Task_68867_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_68867_Name = {
    Text = "10 vittorie"
  },
  Task_69819_Desc = {
    Text = "Vinci la Battaglia finale entro 35 turni"
  },
  Task_69819_Name = {
    Text = "Vinci la Battaglia finale entro 35 turni"
  },
  Task_70112_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere una volta in \"Desiderio Caotico\""
  },
  Task_70113_Desc = {
    Text = "Completa \"Anelli di Crescita\" a Difficoltà Follia"
  },
  Task_70114_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere due volte in \"Desiderio Caotico\""
  },
  Task_70115_Desc = {
    Text = "Completa \"Radici Nascenti\" a qualsiasi difficoltà"
  },
  Task_70116_Desc = {
    Text = "Completa \"Danza del polline\" a qualsiasi difficoltà"
  },
  Task_70117_Desc = {
    Text = "Completa \"Radici Nascenti\" a Difficoltà Follia"
  },
  Task_70118_Desc = {
    Text = "Completa \"Speranza Germogliante\" a qualsiasi difficoltà"
  },
  Task_70119_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere una volta in \"Desiderio Caotico\""
  },
  Task_70120_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere due volte in \"Desiderio Caotico\""
  },
  Task_70121_Desc = {
    Text = "Desiderio Caotico: Follia"
  },
  Task_70122_Desc = {
    Text = "Completa \"Frutti Caduti\" a Difficoltà Follia"
  },
  Task_70123_Desc = {
    Text = "Desiderio Caotico: Reame"
  },
  Task_70124_Desc = {
    Text = "Completa \"Danza del polline\" a Difficoltà Follia"
  },
  Task_70125_Desc = {
    Text = "Completa \"Abbraccio del Calice\" a Difficoltà Follia"
  },
  Task_70126_Desc = {
    Text = "Completa \"Fiore della Rinascita\" a qualsiasi difficoltà"
  },
  Task_70127_Desc = {
    Text = "Completa \"Fiore della Rinascita\" a Difficoltà Follia"
  },
  Task_70128_Desc = {
    Text = "Completa \"Speranza Germogliante\" a Difficoltà Follia"
  },
  Task_70129_Desc = {
    Text = "Completa \"Bagliore del Nettare\" a qualsiasi difficoltà"
  },
  Task_70130_Desc = {
    Text = "Completa \"Anelli di Crescita\" a qualsiasi difficoltà"
  },
  Task_70131_Desc = {
    Text = "Completa \"Scintilla dell'Ovulo\" a qualsiasi difficoltà"
  },
  Task_70132_Desc = {
    Text = "Completa \"Frutti Caduti\" a qualsiasi difficoltà"
  },
  Task_70133_Desc = {
    Text = "Completa \"Scintilla dell'Ovulo\" a Difficoltà Follia"
  },
  Task_70134_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere due volte in \"Desiderio Caotico\""
  },
  Task_70135_Desc = {
    Text = "Completa \"Abbraccio del Calice\" a qualsiasi difficoltà"
  },
  Task_70136_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere una volta in \"Desiderio Caotico\""
  },
  Task_70137_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per vincere due volte in \"Desiderio Caotico\""
  },
  Task_70138_Desc = {
    Text = "Completa \"Dono del Seme\" a Difficoltà Follia"
  },
  Task_70139_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per vincere una volta in \"Desiderio Caotico\""
  },
  Task_70140_Desc = {
    Text = "Completa \"Dono del Seme\" a qualsiasi difficoltà"
  },
  Task_70141_Desc = {
    Text = "Completa \"Bagliore del Nettare\" a Difficoltà Follia"
  },
  Task_70307_Desc = {
    Text = "Vinci la Battaglia finale entro 40 turni"
  },
  Task_70307_Name = {
    Text = "Vinci la Battaglia finale entro 40 turni"
  },
  Task_70446_Name = {
    Text = "Riattraversamento 8-8"
  },
  Task_70447_Name = {
    Text = "Riattraversamento 8-4"
  },
  Task_70448_Name = {
    Text = "Riattraversamento Missione secondaria di Ryker Normale 12"
  },
  Task_70449_Name = {
    Text = "Riattraversamento Missione secondaria di Erica Normale 3"
  },
  Task_70450_Name = {
    Text = "Riattraversamento 3-14"
  },
  Task_70451_Name = {
    Text = "Riattraversamento Missione secondaria di Sanga Normale 4"
  },
  Task_70452_Name = {
    Text = "Riattraversamento Missione secondaria di Horla Normale 9"
  },
  Task_70453_Name = {
    Text = "Riattraversamento Missione secondaria di Ogier Normale 4"
  },
  Task_70454_Name = {
    Text = "Riattraversamento 2-16"
  },
  Task_70455_Name = {
    Text = "Riattraversamento 2-15"
  },
  Task_70456_Name = {
    Text = "Riattraversamento Missione secondaria di Aurita Normale 3"
  },
  Task_70457_Name = {
    Text = "Riattraversamento Missione secondaria di \"24\" Normale 10"
  },
  Task_70458_Name = {
    Text = "Riattraversamento Missione secondaria di Daffodil Normale 10"
  },
  Task_70459_Name = {
    Text = "Riattraversamento Missione secondaria di Agrippa Normale 5"
  },
  Task_70460_Name = {
    Text = "Riattraversamento 6-8"
  },
  Task_70461_Name = {
    Text = "Riattraversamento 8-14"
  },
  Task_70462_Name = {
    Text = "Riattraversamento Missione secondaria di Sorel Normale 13"
  },
  Task_70463_Name = {
    Text = "Riattraversamento Missione secondaria di Miryam Normale 15"
  },
  Task_70464_Name = {
    Text = "Riattraversamento 8-7"
  },
  Task_70465_Name = {
    Text = "Riattraversamento 7-2"
  },
  Task_70466_Name = {
    Text = "Riattraversamento 7-3"
  },
  Task_70467_Name = {
    Text = "Riattraversamento 7-1"
  },
  Task_70468_Name = {
    Text = "Riattraversamento Missione secondaria di Lily Normale 7"
  },
  Task_70469_Name = {
    Text = "Riattraversamento Missione secondaria di Genesi Ramona Normale 4"
  },
  Task_70470_Name = {
    Text = "Riattraversamento 1-8"
  },
  Task_70471_Name = {
    Text = "Riattraversamento Missione secondaria di Genesi Helot Normale 9"
  },
  Task_70472_Name = {
    Text = "Riattraversamento 4-16"
  },
  Task_70473_Name = {
    Text = "Riattraversamento 1-14"
  },
  Task_70474_Name = {
    Text = "Riattraversamento 4-13"
  },
  Task_70475_Name = {
    Text = "Riattraversamento 1-15"
  },
  Task_70476_Name = {
    Text = "Riattraversamento 9-13"
  },
  Task_70477_Name = {
    Text = "Riattraversamento 3-2"
  },
  Task_70478_Name = {
    Text = "Riattraversamento 3-3"
  },
  Task_70479_Name = {
    Text = "Riattraversamento Missione secondaria di Uvhash Normale 4"
  },
  Task_70480_Name = {
    Text = "Riattraversamento 6-15"
  },
  Task_70481_Name = {
    Text = "Riattraversamento Missione secondaria di Golia Normale 3"
  },
  Task_70482_Name = {
    Text = "Riattraversamento 5-12"
  },
  Task_70483_Name = {
    Text = "Riattraversamento 6-10"
  },
  Task_70484_Name = {
    Text = "Riattraversamento Missione secondaria di Salvador Normale 9"
  },
  Task_70485_Name = {
    Text = "Riattraversamento Missione secondaria di Wanda Normale 4"
  },
  Task_70941_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_70941_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_70942_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_70942_Name = {
    Text = "Elegante e Preciso"
  },
  Task_70943_Desc = {
    Text = "Pesca almeno 5 Carte aggiuntive in un turno durante la Battaglia finale."
  },
  Task_70943_Name = {Text = "Pesca!"},
  Task_70944_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_70944_Name = {
    Text = "Risparmio Energetico"
  },
  Task_70945_Desc = {
    Text = "Ottenere almeno un'Orazione"
  },
  Task_70945_Name = {
    Text = "Marchio dell'Anima"
  },
  Task_70946_Desc = {
    Text = "Completa con Vita non inferiore al 50%"
  },
  Task_70946_Name = {
    Text = "Elegante e Preciso"
  },
  Task_70947_Desc = {
    Text = "Completa il Livello portando con te almeno 1 Reliquia d'oro."
  },
  Task_70947_Name = {
    Text = "Scorta segreta"
  },
  Task_70948_Desc = {
    Text = "Non avere più di 2 Carte sintomo al completamento"
  },
  Task_70948_Name = {
    Text = "Risparmio Energetico"
  },
  Task_70949_Desc = {
    Text = "Possiedi almeno 2 Reliquie al completamento"
  },
  Task_70949_Name = {
    Text = "Scorta segreta"
  },
  Task_70950_Desc = {
    Text = "Completa il Livello portando con te almeno 1 Reliquia d'oro."
  },
  Task_70950_Name = {
    Text = "Scorta segreta"
  },
  Task_70951_Desc = {
    Text = "Gioca almeno 5 Carte in un turno durante la Battaglia finale."
  },
  Task_70951_Name = {
    Text = "Tocca a me!"
  },
  Task_70952_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_70952_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_70953_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_70953_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_70954_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_70954_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_70955_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_70955_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_70956_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_70956_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_70957_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_70957_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_70958_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_70958_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_70959_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_70959_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_70960_Desc = {
    Text = "Vinci la Battaglia finale entro 10 turni"
  },
  Task_70960_Name = {
    Text = "Risoluzione Rapida"
  },
  Task_71343_Desc = {
    Text = "Completamento di \"Calamità Frenetica\" a Difficoltà Follia"
  },
  Task_71344_Desc = {
    Text = "Vinci una volta in \"Porta dell'Oblio\" utilizzando un qualsiasi Risvegliatore del Reame del Caos"
  },
  Task_71345_Desc = {
    Text = "Vinci due volte in \"Porta dell'Oblio\" utilizzando un qualsiasi Risvegliatore del Reame del Caos"
  },
  Task_71346_Desc = {
    Text = "Completamento di \"Caduta radiosa\" a qualsiasi difficoltà"
  },
  Task_71347_Desc = {
    Text = "Completamento di \"Calamità Frenetica\" a qualsiasi difficoltà"
  },
  Task_71348_Desc = {
    Text = "Completamento di \"Oracolo del Caos\" a qualsiasi difficoltà"
  },
  Task_71349_Desc = {
    Text = "Porta dell'Oblio: Reame"
  },
  Task_71350_Desc = {
    Text = "Completamento di \"Dimora delle Bambole\" a qualsiasi difficoltà"
  },
  Task_71351_Desc = {
    Text = "Completamento di \"Stelle\" a Difficoltà Follia"
  },
  Task_71352_Desc = {
    Text = "Completamento di \"Calamità Frenetica\" a qualsiasi difficoltà"
  },
  Task_71353_Desc = {
    Text = "Completamento di \"Caduta radiosa\" a qualsiasi difficoltà"
  },
  Task_71354_Desc = {
    Text = "Completamento di \"Ballo di Carnevale\" a qualsiasi difficoltà"
  },
  Task_71355_Desc = {
    Text = "Porta dell'Oblio: Follia"
  },
  Task_71356_Desc = {
    Text = "Completamento di \"Fili del Destino\" a qualsiasi difficoltà"
  },
  Task_71357_Desc = {
    Text = "Completamento di \"Veleno Autentico\" a qualsiasi difficoltà"
  },
  Task_71358_Desc = {
    Text = "Completamento di \"Fili del Destino\" a Difficoltà Follia"
  },
  Task_71359_Desc = {
    Text = "Vinci due volte in \"Porta dell'Oblio\" utilizzando un qualsiasi Risvegliatore del Reame di Caro"
  },
  Task_71360_Desc = {
    Text = "Completamento di \"Oracolo del Caos\" a qualsiasi difficoltà"
  },
  Task_71361_Desc = {
    Text = "Completamento di \"L'Invito\" a Difficoltà Follia"
  },
  Task_71362_Desc = {
    Text = "Usa un qualsiasi Risveglio del Reame Ultra per vincere due volte nella \"Porta dell'Oblio\""
  },
  Task_71363_Desc = {
    Text = "Usa un qualsiasi Risveglio del Reame Ultra per vincere una volta nella \"Porta dell'Oblio\""
  },
  Task_71364_Desc = {
    Text = "Porta dell'Oblio: Completamento"
  },
  Task_71365_Desc = {
    Text = "Completa tutti gli obiettivi in \"Porta dell'Oblio: Completato\""
  },
  Task_71366_Desc = {
    Text = "Completamento di \"Caduta radiosa\" a Difficoltà Follia"
  },
  Task_71367_Desc = {
    Text = "Completamento di \"Veleno Autentico\" a Difficoltà Follia"
  },
  Task_71368_Desc = {
    Text = "Completamento di \"Fili del Destino\" a qualsiasi difficoltà"
  },
  Task_71369_Desc = {
    Text = "Vinci una volta in \"Porta dell'Oblio\" utilizzando un qualsiasi Risvegliatore del Reame di Caro"
  },
  Task_71370_Desc = {
    Text = "Completamento di \"Dimora delle Bambole\" a Difficoltà Follia"
  },
  Task_71373_Desc = {
    Text = "Completamento di \"Stelle\" a qualsiasi difficoltà"
  },
  Task_71374_Desc = {
    Text = "Vinci due volte in \"Porta dell'Oblio\" utilizzando un qualsiasi Risvegliatore del Reame di Aequor"
  },
  Task_71375_Desc = {
    Text = "Vinci una volta in \"Porta dell'Oblio\" utilizzando un qualsiasi Risvegliatore del Reame di Aequor"
  },
  Task_71376_Desc = {
    Text = "Completamento di \"Ballo di Carnevale\" a qualsiasi difficoltà"
  },
  Task_71377_Desc = {
    Text = "Completamento di \"Dimora delle Bambole\" a qualsiasi difficoltà"
  },
  Task_71378_Desc = {
    Text = "Completamento di \"Stelle\" a qualsiasi difficoltà"
  },
  Task_71379_Desc = {
    Text = "Completamento di \"L'Invito\" a qualsiasi difficoltà"
  },
  Task_71380_Desc = {
    Text = "Completamento di \"Oracolo del Caos\" a Difficoltà Follia"
  },
  Task_71381_Desc = {
    Text = "Completamento di \"Ballo di Carnevale\" a Difficoltà Follia"
  },
  Task_71382_Desc = {
    Text = "Completamento di \"Veleno Autentico\" a qualsiasi difficoltà"
  },
  Task_71385_Desc = {
    Text = "Completamento di \"L'Invito\" a qualsiasi difficoltà"
  },
  Task_71757_Desc = {
    Text = "Completamento di \"Farsa Mascherata\" a Difficoltà Follia"
  },
  Task_71758_Desc = {
    Text = "Completamento di \"Rotazione della Trama\" a qualsiasi difficoltà"
  },
  Task_71759_Desc = {
    Text = "Completamento di \"Istante di Quiete\" a Difficoltà Follia"
  },
  Task_71760_Desc = {
    Text = "Completamento di \"Istante di Quiete\" a qualsiasi difficoltà"
  },
  Task_71761_Desc = {
    Text = "Completamento di \"Catarsi\" a Difficoltà Follia"
  },
  Task_71762_Desc = {
    Text = "Completamento di \"Teorema dell'Arco\" a qualsiasi difficoltà"
  },
  Task_71763_Desc = {
    Text = "Completamento di \"Rotazione della Trama\" a Difficoltà Follia"
  },
  Task_71764_Desc = {
    Text = "Completamento di \"Effetto di Straniamento\" a Difficoltà Follia"
  },
  Task_71765_Desc = {
    Text = "Completamento di \"Unità Classiche\" a Difficoltà Follia"
  },
  Task_71766_Desc = {
    Text = "Completamento di \"Unità Classiche\" a qualsiasi difficoltà"
  },
  Task_71767_Desc = {
    Text = "Completamento di \"Catarsi\" a qualsiasi difficoltà"
  },
  Task_71768_Desc = {
    Text = "Completamento di \"Farsa Mascherata\" a qualsiasi difficoltà"
  },
  Task_71769_Desc = {
    Text = "Completamento di \"La Quarta Parete\" a Difficoltà Follia"
  },
  Task_71770_Desc = {
    Text = "Completamento di \"La Quarta Parete\" a qualsiasi difficoltà"
  },
  Task_71771_Desc = {
    Text = "Completamento di \"Effetto di Straniamento\" a qualsiasi difficoltà"
  },
  Task_71772_Desc = {
    Text = "Completamento di \"Teorema dell'Arco\" a Difficoltà Follia"
  },
  Task_71773_Desc = {
    Text = "Completamento di \"Apice del Dramma\" a Difficoltà Follia"
  },
  Task_71774_Desc = {
    Text = "Completamento di \"Apice del Dramma\" a qualsiasi difficoltà"
  },
  Task_71775_Desc = {
    Text = "Mistero Ordito: Follia"
  },
  Task_71795_Desc = {
    Text = "Record più Alto"
  },
  Task_71795_Name = {Text = "2800 Punti"},
  Task_71796_Desc = {
    Text = "Record più Alto"
  },
  Task_71796_Name = {Text = "2700 Punti"},
  Task_71797_Desc = {
    Text = "Record più Alto"
  },
  Task_71797_Name = {Text = "2900 Punti"},
  Task_71798_Desc = {
    Text = "Record più Alto"
  },
  Task_71798_Name = {Text = "2600 Punti"},
  Task_71799_Desc = {
    Text = "Record più Alto"
  },
  Task_71799_Name = {Text = "2300 Punti"},
  Task_71800_Desc = {
    Text = "Record più Alto"
  },
  Task_71800_Name = {Text = "2400 Punti"},
  Task_71801_Desc = {
    Text = "Record più Alto"
  },
  Task_71801_Name = {Text = "2500 Punti"},
  Task_71802_Desc = {
    Text = "Record più Alto"
  },
  Task_71802_Name = {Text = "1900 punti"},
  Task_71803_Desc = {
    Text = "Record più Alto"
  },
  Task_71803_Name = {Text = "2000 Punti"},
  Task_71804_Desc = {
    Text = "Record più Alto"
  },
  Task_71804_Name = {Text = "2100 Punti"},
  Task_71805_Desc = {
    Text = "Record più Alto"
  },
  Task_71805_Name = {Text = "2200 Punti"},
  Task_71806_Desc = {
    Text = "Record più Alto"
  },
  Task_71806_Name = {Text = "3000 Punti"},
  Task_71807_Desc = {
    Text = "Record più Alto"
  },
  Task_71807_Name = {Text = "1600 punti"},
  Task_71808_Desc = {
    Text = "Record più Alto"
  },
  Task_71808_Name = {Text = "1700 punti"},
  Task_71809_Desc = {
    Text = "Record più Alto"
  },
  Task_71809_Name = {Text = "1800 punti"},
  Task_71819_Desc = {
    Text = "Completamento di \"Fine Ultima\" a qualsiasi difficoltà"
  },
  Task_71820_Desc = {
    Text = "Completamento di \"Il Volto\" a qualsiasi difficoltà"
  },
  Task_71821_Desc = {
    Text = "Completamento di \"Papà Gambalunga\" a qualsiasi difficoltà"
  },
  Task_71822_Desc = {
    Text = "Completamento di \"Lo Sguardo\" a qualsiasi difficoltà"
  },
  Task_71823_Desc = {
    Text = "Completamento di \"Gioco del Burattino\" a qualsiasi difficoltà"
  },
  Task_71824_Desc = {
    Text = "Completamento di \"Copione Incompiuto\" a qualsiasi difficoltà"
  },
  Task_71825_Desc = {
    Text = "Completamento di \"Angolo delle Rose\" a qualsiasi difficoltà"
  },
  Task_71826_Desc = {
    Text = "Completamento di \"Pesci sul fondo del calderone\" a qualsiasi difficoltà"
  },
  Task_71827_Desc = {
    Text = "Completamento di \"Un Dono\" a qualsiasi difficoltà"
  },
  Task_71867_Desc = {
    Text = "Possiedi 5/6/7/8 Reliquie (+250/+500/+750/+1000 pti)"
  },
  Task_71867_Name = {
    Text = "Collezionista di Reliquie <size=20><color=#747474>Possiedi 8 Reliquie</color></size>"
  },
  Task_71868_Desc = {
    Text = "-20% pti per Memoria Muscolare"
  },
  Task_71868_Name = {
    Text = "Camminatore dei Sogni <size=20><color=#747474>-20% per Memoria Muscolare</color></size>"
  },
  Task_71934_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71935_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71936_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71937_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71939_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71940_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71941_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71942_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71943_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71944_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71945_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71946_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71947_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71948_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71949_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71950_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71952_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71953_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71954_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71955_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71977_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71978_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71980_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_71981_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_72038_Name = {
    Text = "Riattraversamento Missione secondaria di Tulu Normale 4"
  },
  Task_72039_Desc = {
    Text = "Completamento di \"Sguardo\" a Difficoltà Follia"
  },
  Task_72040_Desc = {
    Text = "Completamento di \"Pesci sul fondo del calderone\" a Difficoltà Follia"
  },
  Task_72041_Desc = {
    Text = "Completamento di \"Gioco del Burattino\" a Difficoltà Follia"
  },
  Task_72042_Desc = {
    Text = "Completamento di \"Un Dono\" a Difficoltà Follia"
  },
  Task_72043_Desc = {
    Text = "Completamento del Registro Operazioni Speciali \"Memorie di Rosa\""
  },
  Task_72044_Desc = {
    Text = "Completamento di \"Papà Gambalunga\" a Difficoltà Follia"
  },
  Task_72045_Desc = {
    Text = "Completamento di \"Copione Incompiuto\" a Difficoltà Follia"
  },
  Task_72046_Desc = {
    Text = "Completamento di \"Angolo delle Rose\" a Difficoltà Follia"
  },
  Task_72047_Desc = {
    Text = "Completamento di \"Il Volto\" a Difficoltà Follia"
  },
  Task_72048_Desc = {
    Text = "Completamento di \"Fine Ultima\" a Difficoltà Follia"
  },
  Task_72049_Desc = {
    Text = "Memorie di Rosa: Follia"
  },
  Task_72245_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72245_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72386_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72386_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72387_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72387_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72389_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72389_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72390_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72390_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72391_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72391_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72392_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72392_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72393_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72393_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72394_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72394_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72395_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72395_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72396_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72396_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72416_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72416_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72420_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72420_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72540_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72540_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72541_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72541_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72542_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72542_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72545_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72545_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72546_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72546_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72547_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72547_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72548_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72548_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72549_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72549_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72632_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72632_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72652_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72652_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: Un Ospite da un Altro Mondo\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72677_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72677_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: Un Ospite da un Altro Mondo\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72678_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72678_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: Un Ospite da un Altro Mondo\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72679_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72679_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: Un Ospite da un Altro Mondo\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72681_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72681_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: Un Ospite da un Altro Mondo\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72682_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72682_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: Un Ospite da un Altro Mondo\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72683_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72683_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: Un Ospite da un Altro Mondo\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72684_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72684_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: Un Ospite da un Altro Mondo\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72685_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72685_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: Un Ospite da un Altro Mondo\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72700_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72700_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72701_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72701_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72703_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72703_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72704_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72704_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72705_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72705_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72706_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72706_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72707_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72707_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72709_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72709_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72773_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72773_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72790_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72790_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72798_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72798_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72799_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72799_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72800_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72800_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72801_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72801_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72802_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72802_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72803_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72803_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72805_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72805_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72806_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72806_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72807_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_72807_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_72957_Desc = {
    Text = "Ottieni 3 vittorie usando \"Grazia Attraverso il Dolore\""
  },
  Task_72958_Desc = {
    Text = "Usa \"Divoramento Aberrante\" per ottenere 1 vittoria"
  },
  Task_72959_Desc = {
    Text = "Usa \"Fusione del Nucleo\" per ottenere 3 vittorie"
  },
  Task_72961_Desc = {
    Text = "Usa \"Magia del 35mm\" per ottenere 1 vittoria"
  },
  Task_72963_Desc = {
    Text = "Ottieni 3 vittorie usando \"Editto della Regina\""
  },
  Task_72965_Desc = {
    Text = "Ottieni 1 vittoria usando \"Milioni di sguardi amorevoli\""
  },
  Task_72968_Desc = {
    Text = "Ottieni 1 vittoria usando \"Emersione\""
  },
  Task_72973_Desc = {
    Text = "Ottieni 1 vittoria con \"Lily\""
  },
  Task_72975_Desc = {
    Text = "Usa \"Sangue e Sabbia Ruggenti\" per ottenere 3 vittorie"
  },
  Task_72976_Desc = {
    Text = "Ottieni 3 vittorie usando \"Rarità Preziosa\""
  },
  Task_72977_Desc = {
    Text = "Ottieni 3 vittorie usando \"Ruota Invisibile\""
  },
  Task_72978_Desc = {
    Text = "Usa \"I dati sono vita\" per ottenere 3 vittorie"
  },
  Task_72980_Desc = {
    Text = "Ottieni 1 vittoria con \"Liz\""
  },
  Task_72982_Desc = {
    Text = "Usa \"Oltre la Morte\" per ottenere 3 vittorie"
  },
  Task_72983_Desc = {
    Text = "Ottieni 1 vittoria usando \"Sguardo sul Lago\""
  },
  Task_72986_Desc = {
    Text = "Ottieni 1 vittoria usando \"Lama del Titano\""
  },
  Task_72989_Desc = {
    Text = "Usa \"Ogier\" per ottenere 3 vittorie"
  },
  Task_72990_Desc = {
    Text = "Usa \"Ninnananna Divorata\" per ottenere 1 vittoria"
  },
  Task_72992_Desc = {
    Text = "Usa \"Punto critico\" per ottenere 1 vittoria"
  },
  Task_72993_Desc = {
    Text = "Usa \"Al Mio Caro Amico\" per ottenere 1 vittoria"
  },
  Task_72994_Desc = {
    Text = "Ottieni 1 vittoria usando \"Eternità Effimera\""
  },
  Task_72995_Desc = {
    Text = "Ottieni 1 vittoria usando \"Morte della Sig.ra Coral\""
  },
  Task_72997_Desc = {
    Text = "Ottieni 3 vittorie con \"Aurita\""
  },
  Task_72999_Desc = {
    Text = "Ottieni 3 vittorie usando \"Vittoria delle Rose\""
  },
  Task_73001_Desc = {
    Text = "Ottieni 1 vittoria usando \"Favore\""
  },
  Task_73003_Desc = {
    Text = "Usa \"Lo Sguardo di Isarawu\" per ottenere 3 vittorie"
  },
  Task_73004_Desc = {
    Text = "Usa \"Bastone del Nobile\" per ottenere 1 vittoria"
  },
  Task_73006_Desc = {
    Text = "Ottieni 3 vittorie usando \"Ora della Fortuna\""
  },
  Task_73007_Desc = {
    Text = "Ottieni 3 vittorie con \"Agrippa\""
  },
  Task_73009_Desc = {
    Text = "Ottieni 1 vittoria usando \"Quando la Neve si Scioglie\""
  },
  Task_73011_Desc = {
    Text = "Usa \"Barriera Mentale\" per ottenere 1 vittoria"
  },
  Task_73012_Desc = {
    Text = "Ottieni 3 vittorie con \"Miryam\""
  },
  Task_73014_Desc = {
    Text = "Ottieni 1 vittoria con \"Hameln\""
  },
  Task_73015_Desc = {
    Text = "Ottieni 3 vittorie usando \"Sogno del mare\""
  },
  Task_73016_Desc = {
    Text = "Ottieni 1 vittoria usando \"Delirium\""
  },
  Task_73018_Desc = {
    Text = "Ottieni 1 vittoria usando \"Spettacolo di magia felice\""
  },
  Task_73019_Desc = {
    Text = "Ottieni 1 vittoria usando \"Maturità\""
  },
  Task_73021_Desc = {
    Text = "Usa \"Cuore d'Argento Puro\" per ottenere 1 vittoria"
  },
  Task_73022_Desc = {
    Text = "Ottieni 1 vittoria con \"Doll\""
  },
  Task_73025_Desc = {
    Text = "Ottieni 1 vittoria usando \"Sussurro\""
  },
  Task_73026_Desc = {
    Text = "Ottieni 1 vittoria usando \"Vitalità\""
  },
  Task_73028_Desc = {
    Text = "Ottieni 1 vittoria con \"Daffodil\""
  },
  Task_73030_Desc = {
    Text = "Ottieni 3 vittorie con \"Winkle\""
  },
  Task_73033_Desc = {
    Text = "Usa \"Annegare nel Cremisi\" per ottenere 1 vittoria"
  },
  Task_73037_Desc = {
    Text = "Usa \"Catene Infrante\" per ottenere 3 vittorie"
  },
  Task_73039_Desc = {
    Text = "Usa \"Requiem dell'Inverno\" per ottenere 1 vittoria"
  },
  Task_73041_Desc = {
    Text = "Ottieni 1 vittoria usando \"Nascita Celata\""
  },
  Task_73044_Desc = {
    Text = "Ottieni 3 vittorie con \"Ryker\""
  },
  Task_73045_Desc = {
    Text = "Usa \"Doll: Inferno\" per ottenere 1 vittoria"
  },
  Task_73047_Desc = {
    Text = "Ottieni 1 vittoria con \"Faint\""
  },
  Task_73048_Desc = {
    Text = "Ottieni 3 vittorie con \"Thais\""
  },
  Task_73050_Desc = {
    Text = "Ottieni 3 vittorie con \"Aigis\""
  },
  Task_73051_Desc = {
    Text = "Ottieni 1 vittoria con \"Aurita\""
  },
  Task_73052_Desc = {
    Text = "Ottieni 1 vittoria con \"Sanga\""
  },
  Task_73053_Desc = {
    Text = "Ottieni 1 vittoria con \"Murphy\""
  },
  Task_73054_Desc = {
    Text = "Ottieni 3 vittorie con \"Tawil\""
  },
  Task_73055_Desc = {
    Text = "Ottieni 3 vittorie con \"Doll\""
  },
  Task_73056_Desc = {
    Text = "Ottieni 1 vittoria con \"Salvador\""
  },
  Task_73057_Desc = {
    Text = "Ottieni 3 vittorie usando \"Il Seme Solitario\""
  },
  Task_73059_Desc = {
    Text = "Ottieni 3 vittorie usando \"Determinazione del Merluzzo Argenteo\""
  },
  Task_73061_Desc = {
    Text = "Ottieni 3 vittorie usando \"Recidere e Sfregiare\""
  },
  Task_73063_Desc = {
    Text = "Usa \"Nutrimento Misericordioso\" per ottenere 1 vittoria"
  },
  Task_73064_Desc = {
    Text = "Ottieni 3 vittorie usando \"Punizione\""
  },
  Task_73066_Desc = {
    Text = "Ottieni 3 vittorie usando \"Roulette del Destino\""
  },
  Task_73067_Desc = {
    Text = "Ottieni 1 vittoria con \"Pandia\""
  },
  Task_73068_Desc = {
    Text = "Ottieni 1 vittoria usando \"Tutto di Lei\""
  },
  Task_73070_Desc = {
    Text = "Ottieni 3 vittorie usando \"Regno del Gigante\""
  },
  Task_73073_Desc = {
    Text = "Usa \"Ramona\" per ottenere 3 vittorie"
  },
  Task_73074_Desc = {
    Text = "Ottieni 1 vittoria usando \"L'Ultimo Verso\""
  },
  Task_73075_Desc = {
    Text = "Usa \"Discendente Pallido\" per ottenere 3 vittorie"
  },
  Task_73077_Desc = {
    Text = "Ottieni 1 vittoria con \"Wanda\""
  },
  Task_73081_Desc = {
    Text = "Ottieni 1 vittoria usando \"Potere dei devoti\""
  },
  Task_73082_Desc = {
    Text = "Usa \"Spirale della Memoria\" per ottenere 1 vittoria"
  },
  Task_73083_Desc = {
    Text = "Usa \"Orologio del tempo riavvolto\" per ottenere 3 vittorie"
  },
  Task_73085_Desc = {
    Text = "Ottieni 1 vittoria con \"Horla\""
  },
  Task_73086_Desc = {
    Text = "Usa \"Momento della Riunione\" per ottenere 1 vittoria"
  },
  Task_73087_Desc = {
    Text = "Usa \"Banchetto Silenzioso\" per ottenere 3 vittorie"
  },
  Task_73088_Desc = {
    Text = "Ottieni 1 vittoria usando \"Nel cuore del diluvio\""
  },
  Task_73089_Desc = {
    Text = "Usa \"Lotan\" per ottenere 1 vittoria"
  },
  Task_73090_Desc = {
    Text = "Usa \"Festino di Sangue\" per ottenere 1 vittoria"
  },
  Task_73095_Desc = {
    Text = "Ottieni 1 vittoria con \"Karen\""
  },
  Task_73097_Desc = {
    Text = "Usa \"Alla deriva nel Desiderio\" per ottenere 1 vittoria"
  },
  Task_73098_Desc = {
    Text = "Ottieni 1 vittoria con \"Casiah\""
  },
  Task_73099_Desc = {
    Text = "Ottieni 1 vittoria usando \"Visione di Mezza Estate\""
  },
  Task_73100_Desc = {
    Text = "Ottieni 3 vittorie con \"Sorel\""
  },
  Task_73102_Desc = {
    Text = "Usa \"Inno al Sovrano\" per ottenere 1 vittoria"
  },
  Task_73105_Desc = {
    Text = "Ottieni 3 vittorie usando \"Scambio Ineguale\""
  },
  Task_73107_Desc = {
    Text = "Usa \"Voto del Cavaliere\" per ottenere 1 vittoria"
  },
  Task_73109_Desc = {
    Text = "Ottieni 3 vittorie usando \"Vincolo Maledetto\""
  },
  Task_73110_Desc = {
    Text = "Ottieni 3 vittorie con \"Salvador\""
  },
  Task_73111_Desc = {
    Text = "Usa \"Bestia Celeste\" per ottenere 3 vittorie"
  },
  Task_73117_Desc = {
    Text = "Ottieni 1 vittoria usando \"Abbraccio Corrosivo\""
  },
  Task_73118_Desc = {
    Text = "Ottieni 1 vittoria usando \"Il Tesoro di Aurita\""
  },
  Task_73120_Desc = {
    Text = "Usa \"La Favola del Divoratore\" per ottenere 1 vittoria"
  },
  Task_73122_Desc = {
    Text = "Usa \"Ramona: Timeworn\" per ottenere 3 vittorie"
  },
  Task_73123_Desc = {
    Text = "Ottieni 1 vittoria usando \"L'ultimo voto\""
  },
  Task_73124_Desc = {
    Text = "Ottieni 3 vittorie usando \"Esilio\""
  },
  Task_73126_Desc = {
    Text = "Ottieni 1 vittoria usando \"Benedizione\""
  },
  Task_73128_Desc = {
    Text = "Ottieni 3 vittorie usando \"Bramosia\""
  },
  Task_73129_Desc = {
    Text = "Ottieni 1 vittoria con \"Caecus\""
  },
  Task_73130_Desc = {
    Text = "Ottieni 3 vittorie usando \"Portale della Verità\""
  },
  Task_73131_Desc = {
    Text = "Usa \"In Nome della Rosa\" per ottenere 1 vittoria"
  },
  Task_73134_Desc = {
    Text = "Ottieni 3 vittorie con \"Erica\""
  },
  Task_73136_Desc = {
    Text = "Ottieni 3 vittorie usando \"Analisi della Morte\""
  },
  Task_73138_Desc = {
    Text = "Ottieni 3 vittorie con \"Tintura\""
  },
  Task_73139_Desc = {
    Text = "Ottieni 3 vittorie usando \"Eternità Effimera\""
  },
  Task_73140_Desc = {
    Text = "Ottieni 3 vittorie usando \"Gravità del Dovere\""
  },
  Task_73141_Desc = {
    Text = "Ottieni 1 vittoria usando \"Epifania\""
  },
  Task_73144_Desc = {
    Text = "Ottieni 3 vittorie usando \"Lama del Titano\""
  },
  Task_73147_Desc = {
    Text = "Ottieni 3 vittorie usando \"Esecuzione Senza Fine\""
  },
  Task_73148_Desc = {
    Text = "Ottieni 3 vittorie usando \"Sonno Sotto il Ghiacciaio\""
  },
  Task_73150_Desc = {
    Text = "Ottieni 3 vittorie con \"Lily\""
  },
  Task_73151_Desc = {
    Text = "Ottieni 1 vittoria usando \"Vittoria delle Rose\""
  },
  Task_73152_Desc = {
    Text = "Usa \"Verità Dietro la Nebbia Grigia\" per ottenere 3 vittorie"
  },
  Task_73153_Desc = {
    Text = "Ottieni 1 vittoria con \"Tulu\""
  },
  Task_73154_Desc = {
    Text = "Ottieni 1 vittoria usando \"Speranza\""
  },
  Task_73156_Desc = {
    Text = "Ottieni 3 vittorie con \"Leigh\""
  },
  Task_73157_Desc = {
    Text = "Ottieni 3 vittorie usando \"Favore\""
  },
  Task_73161_Desc = {
    Text = "Ottieni 3 vittorie con \"Nymphaea\""
  },
  Task_73162_Desc = {
    Text = "Ottieni 3 vittorie usando \"Frenesia\""
  },
  Task_73165_Desc = {
    Text = "Ottieni 1 vittoria usando \"La Terra dell'Inesistenza\""
  },
  Task_73166_Desc = {
    Text = "Ottieni 3 vittorie con \"Faros\""
  },
  Task_73167_Desc = {
    Text = "Ottieni 1 vittoria con \"Helot\""
  },
  Task_73170_Desc = {
    Text = "Ottieni 3 vittorie con \"Tulu\""
  },
  Task_73172_Desc = {
    Text = "Ottieni 3 vittorie usando \"Suzione\""
  },
  Task_73173_Desc = {
    Text = "Ottieni 1 vittoria usando \"Vela della Provvidenza\""
  },
  Task_73174_Desc = {
    Text = "Usa \"Momento della Riunione\" per ottenere 3 vittorie"
  },
  Task_73176_Desc = {
    Text = "Ottieni 1 vittoria con \"Celeste\""
  },
  Task_73177_Desc = {
    Text = "Ottieni 3 vittorie con \"Sanga\""
  },
  Task_73178_Desc = {
    Text = "Ottieni 1 vittoria usando \"Intuizione\""
  },
  Task_73180_Desc = {
    Text = "Ottieni 3 vittorie usando \"Requiem Eterno\""
  },
  Task_73181_Desc = {
    Text = "Usa \"Fattore Incalcolabile\" per ottenere 3 vittorie"
  },
  Task_73182_Desc = {
    Text = "Ottieni 1 vittoria con \"Agrippa\""
  },
  Task_73183_Desc = {
    Text = "Ottieni 3 vittorie usando \"Canto del Prigioniero\""
  },
  Task_73185_Desc = {
    Text = "Usa \"Crepuscolo e Alba\" per ottenere 3 vittorie"
  },
  Task_73186_Desc = {
    Text = "Ottieni 1 vittoria usando \"Concentrazione Elevata\""
  },
  Task_73189_Desc = {
    Text = "Ottieni 3 vittorie usando \"Marionetta dell'Oblio\""
  },
  Task_73192_Desc = {
    Text = "Ottieni 1 vittoria usando \"Celato nella Notte\""
  },
  Task_73193_Desc = {
    Text = "Usa \"Sindrome della Memoria\" per ottenere 1 vittoria"
  },
  Task_73197_Desc = {
    Text = "Usa \"Mano dell'Oblio\" per ottenere 3 vittorie"
  },
  Task_73200_Desc = {
    Text = "Ottieni 1 vittoria usando \"Zaino dell'Avventuriero\""
  },
  Task_73204_Desc = {
    Text = "Ottieni 3 vittorie con \"Helot: Catena\""
  },
  Task_73206_Desc = {
    Text = "Usa \"Ninnananna Divorata\" per ottenere 3 vittorie"
  },
  Task_73208_Desc = {
    Text = "Usa \"Doll: Inferno\" per ottenere 3 vittorie"
  },
  Task_73209_Desc = {
    Text = "Ottieni 3 vittorie usando \"Morte della Sig.ra Coral\""
  },
  Task_73210_Desc = {
    Text = "Usa \"Ogier\" per ottenere 1 vittoria"
  },
  Task_73212_Desc = {
    Text = "Usa \"Nutrimento Misericordioso\" per ottenere 3 vittorie"
  },
  Task_73213_Desc = {
    Text = "Usa \"Punto critico\" per ottenere 3 vittorie"
  },
  Task_73214_Desc = {
    Text = "Usa \"Al Mio Caro Amico\" per ottenere 3 vittorie"
  },
  Task_73216_Desc = {
    Text = "Usa \"Annegare nel Cremisi\" per ottenere 3 vittorie"
  },
  Task_73217_Desc = {
    Text = "Ottieni 1 vittoria usando \"Recidere e Sfregiare\""
  },
  Task_73218_Desc = {
    Text = "Ottieni 1 vittoria usando \"Verità Dietro la Nebbia Grigia\""
  },
  Task_73219_Desc = {
    Text = "Ottieni 3 vittorie con \"Voci nella Tua Testa\""
  },
  Task_73220_Desc = {
    Text = "Usa \"Bastone del Nobile\" per ottenere 3 vittorie"
  },
  Task_73222_Desc = {
    Text = "Usa \"Mano dell'Oblio\" per ottenere 1 vittoria"
  },
  Task_73223_Desc = {
    Text = "Ottieni 3 vittorie con \"Jenkin\""
  },
  Task_73224_Desc = {
    Text = "Ottieni 1 vittoria con \"Miryam\""
  },
  Task_73225_Desc = {
    Text = "Ottieni 1 vittoria usando \"Ora della Fortuna\""
  },
  Task_73227_Desc = {
    Text = "Usa \"Sentiero Abbandonato\" per ottenere 1 vittoria"
  },
  Task_73228_Desc = {
    Text = "Ottieni 1 vittoria con \"Alva\""
  },
  Task_73229_Desc = {
    Text = "Usa \"Tavoletta delle Scritture Divine\" per ottenere 1 vittoria"
  },
  Task_73232_Desc = {
    Text = "Ottieni 3 vittorie usando \"Emersione\""
  },
  Task_73233_Desc = {
    Text = "Ottieni 3 vittorie con \"Uvhash\""
  },
  Task_73235_Desc = {
    Text = "Usa \"Magia del 35mm\" per ottenere 3 vittorie"
  },
  Task_73236_Desc = {
    Text = "Usa \"Dono della Decomposizione\" per ottenere 1 vittoria"
  },
  Task_73237_Desc = {
    Text = "Ottieni 1 vittoria usando \"Bramosia\""
  },
  Task_73241_Desc = {
    Text = "Ottieni 3 vittorie usando \"La Terra dell'Inesistenza\""
  },
  Task_73243_Desc = {
    Text = "Ottieni 3 vittorie con \"Liz\""
  },
  Task_73246_Desc = {
    Text = "Ottieni 1 vittoria usando \"Ruota Invisibile\""
  },
  Task_73249_Desc = {
    Text = "Ottieni 1 vittoria con \"Voci nella Tua Testa\""
  },
  Task_73250_Desc = {
    Text = "Ottieni 1 vittoria con \"24\""
  },
  Task_73253_Desc = {
    Text = "Usa \"Volontà Indomita\" per ottenere 3 vittorie"
  },
  Task_73254_Desc = {
    Text = "Usa \"Divoramento Aberrante\" per ottenere 3 vittorie"
  },
  Task_73257_Desc = {
    Text = "Ottieni 1 vittoria con \"Thais\""
  },
  Task_73259_Desc = {
    Text = "Ottieni 3 vittorie con \"Faint\""
  },
  Task_73260_Desc = {
    Text = "Ottieni 1 vittoria con \"Tawil\""
  },
  Task_73262_Desc = {
    Text = "Ottieni 1 vittoria con \"Aigis\""
  },
  Task_73266_Desc = {
    Text = "Ottieni 1 vittoria usando \"Determinazione del Merluzzo Argenteo\""
  },
  Task_73267_Desc = {
    Text = "Usa \"Lotan\" per ottenere 3 vittorie"
  },
  Task_73268_Desc = {
    Text = "Ottieni 1 vittoria usando \"Il Seme Solitario\""
  },
  Task_73269_Desc = {
    Text = "Ottieni 1 vittoria usando \"Punizione\""
  },
  Task_73270_Desc = {
    Text = "Ottieni 1 vittoria usando \"Pinna del Pianto\""
  },
  Task_73271_Desc = {
    Text = "Ottieni 3 vittorie usando \"Visione di Mezza Estate\""
  },
  Task_73278_Desc = {
    Text = "Ottieni 1 vittoria usando \"Regno del Gigante\""
  },
  Task_73279_Desc = {
    Text = "Ottieni 1 vittoria con \"Erica\""
  },
  Task_73280_Desc = {
    Text = "Ottieni 1 vittoria usando \"Esilio\""
  },
  Task_73281_Desc = {
    Text = "Ottieni 1 vittoria usando \"Sogno del mare\""
  },
  Task_73282_Desc = {
    Text = "Ottieni 3 vittorie usando \"Quando la Neve si Scioglie\""
  },
  Task_73284_Desc = {
    Text = "Ottieni 1 vittoria usando \"Roulette del Destino\""
  },
  Task_73285_Desc = {
    Text = "Ottieni 1 vittoria usando \"Portale della Verità\""
  },
  Task_73286_Desc = {
    Text = "Usa \"Ramona\" per ottenere 1 vittoria"
  },
  Task_73287_Desc = {
    Text = "Ottieni 3 vittorie con \"Pandia\""
  },
  Task_73288_Desc = {
    Text = "Usa \"In Nome della Rosa\" per ottenere 3 vittorie"
  },
  Task_73289_Desc = {
    Text = "Ottieni 3 vittorie usando \"Tutto di Lei\""
  },
  Task_73290_Desc = {
    Text = "Ottieni 3 vittorie con \"Wanda\""
  },
  Task_73292_Desc = {
    Text = "Ottieni 3 vittorie usando \"L'Ultimo Verso\""
  },
  Task_73293_Desc = {
    Text = "Usa \"Discendente Pallido\" per ottenere 1 vittoria"
  },
  Task_73294_Desc = {
    Text = "Ottieni 1 vittoria con \"Tintura\""
  },
  Task_73296_Desc = {
    Text = "Usa \"Fusione del Nucleo\" per ottenere 1 vittoria"
  },
  Task_73297_Desc = {
    Text = "Ottieni 1 vittoria usando \"Alba del Miracolo\""
  },
  Task_73298_Desc = {
    Text = "Ottieni 1 vittoria usando \"Sangue e Sabbia Ruggenti\""
  },
  Task_73299_Desc = {
    Text = "Ottieni 1 vittoria con \"Jenkin\""
  },
  Task_73302_Desc = {
    Text = "Ottieni 3 vittorie usando \"Sussurro\""
  },
  Task_73303_Desc = {
    Text = "Ottieni 1 vittoria usando \"Editto della Regina\""
  },
  Task_73305_Desc = {
    Text = "Ottieni 3 vittorie usando \"Maturità\""
  },
  Task_73306_Desc = {
    Text = "Ottieni 1 vittoria usando \"Grazia Attraverso il Dolore\""
  },
  Task_73309_Desc = {
    Text = "Usa \"Banchetto Silenzioso\" per ottenere 1 vittoria"
  },
  Task_73311_Desc = {
    Text = "Usa \"Sentiero Abbandonato\" per ottenere 3 vittorie"
  },
  Task_73312_Desc = {
    Text = "Ottieni 3 vittorie con \"Golia\""
  },
  Task_73313_Desc = {
    Text = "Usa \"La Favola del Divoratore\" per ottenere 3 vittorie"
  },
  Task_73314_Desc = {
    Text = "Ottieni 1 vittoria con \"Winkle\""
  },
  Task_73315_Desc = {
    Text = "Ottieni 3 vittorie usando \"Milioni di sguardi amorevoli\""
  },
  Task_73316_Desc = {
    Text = "Ottieni 3 vittorie con \"Daffodil\""
  },
  Task_73317_Desc = {
    Text = "Usa \"I dati sono vita\" per ottenere 1 vittoria"
  },
  Task_73318_Desc = {
    Text = "Ottieni 1 vittoria con \"Ryker\""
  },
  Task_73321_Desc = {
    Text = "Ottieni 3 vittorie con \"Horla\""
  },
  Task_73322_Desc = {
    Text = "Ottieni 1 vittoria usando \"Rarità Preziosa\""
  },
  Task_73323_Desc = {
    Text = "Ottieni 3 vittorie con \"Nautila\""
  },
  Task_73324_Desc = {
    Text = "Ottieni 3 vittorie usando \"Sguardo sul Lago\""
  },
  Task_73325_Desc = {
    Text = "Usa \"Oltre la Morte\" per ottenere 1 vittoria"
  },
  Task_73326_Desc = {
    Text = "Usa \"Requiem dell'Inverno\" per ottenere 3 vittorie"
  },
  Task_73327_Desc = {
    Text = "Ottieni 3 vittorie usando \"Zaino dell'Avventuriero\""
  },
  Task_73328_Desc = {
    Text = "Ottieni 1 vittoria con \"Golia\""
  },
  Task_73330_Desc = {
    Text = "Ottieni 1 vittoria usando \"Vincolo Maledetto\""
  },
  Task_73333_Desc = {
    Text = "Usa \"Fattore Incalcolabile\" per ottenere 1 vittoria"
  },
  Task_73334_Desc = {
    Text = "Usa \"Bestia Celeste\" per ottenere 1 vittoria"
  },
  Task_73335_Desc = {
    Text = "Ottieni 3 vittorie usando \"Alba del Miracolo\""
  },
  Task_73338_Desc = {
    Text = "Ottieni 1 vittoria usando \"Marionetta dell'Oblio\""
  },
  Task_73341_Desc = {
    Text = "Ottieni 3 vittorie con \"Murphy\""
  },
  Task_73343_Desc = {
    Text = "Usa \"Crepuscolo e Alba\" per ottenere 1 vittoria"
  },
  Task_73345_Desc = {
    Text = "Usa \"Lo Sguardo di Isarawu\" per ottenere 1 vittoria"
  },
  Task_73346_Desc = {
    Text = "Ottieni 3 vittorie usando \"Concentrazione Elevata\""
  },
  Task_73349_Desc = {
    Text = "Usa \"Abbraccio Corrosivo\" per ottenere 3 vittorie"
  },
  Task_73352_Desc = {
    Text = "Ottieni 3 vittorie usando \"Celato nella Notte\""
  },
  Task_73353_Desc = {
    Text = "Ottieni 3 vittorie usando \"Benedizione\""
  },
  Task_73354_Desc = {
    Text = "Ottieni 1 vittoria con \"Nautila\""
  },
  Task_73355_Desc = {
    Text = "Usa \"Ramona: Timeworn\" per ottenere 1 vittoria"
  },
  Task_73356_Desc = {
    Text = "Ottieni 3 vittorie usando \"Il Tesoro di Aurita\""
  },
  Task_73357_Desc = {
    Text = "Ottieni 3 vittorie usando \"L'ultimo voto\""
  },
  Task_73359_Desc = {
    Text = "Ottieni 3 vittorie con \"Caecus\""
  },
  Task_73360_Desc = {
    Text = "Ottieni 1 vittoria usando \"Analisi della Morte\""
  },
  Task_73362_Desc = {
    Text = "Ottieni 3 vittorie usando \"Spettacolo di magia felice\""
  },
  Task_73363_Desc = {
    Text = "Ottieni 1 vittoria con \"Nymphaea\""
  },
  Task_73366_Desc = {
    Text = "Usa \"Orologio del tempo riavvolto\" per ottenere 1 vittoria"
  },
  Task_73369_Desc = {
    Text = "Ottieni 3 vittorie usando \"Delirium\""
  },
  Task_73370_Desc = {
    Text = "Ottieni 3 vittorie con \"Hameln\""
  },
  Task_73372_Desc = {
    Text = "Usa \"Cuore d'Argento Puro\" per ottenere 3 vittorie"
  },
  Task_73374_Desc = {
    Text = "Ottieni 3 vittorie con \"Karen\""
  },
  Task_73377_Desc = {
    Text = "Ottieni 1 vittoria usando \"Scambio Ineguale\""
  },
  Task_73379_Desc = {
    Text = "Ottieni 1 vittoria con \"Sorel\""
  },
  Task_73380_Desc = {
    Text = "Ottieni 3 vittorie con \"Casiah\""
  },
  Task_73382_Desc = {
    Text = "Usa \"Catene Infrante\" per ottenere 1 vittoria"
  },
  Task_73387_Desc = {
    Text = "Ottieni 3 vittorie usando \"Nascita Celata\""
  },
  Task_73388_Desc = {
    Text = "Usa \"Barriera Mentale\" per ottenere 3 vittorie"
  },
  Task_73390_Desc = {
    Text = "Ottieni 3 vittorie usando \"Pinna del Pianto\""
  },
  Task_73392_Desc = {
    Text = "Ottieni 1 vittoria con \"Uvhash\""
  },
  Task_73394_Desc = {
    Text = "Ottieni 3 vittorie usando \"Potere dei devoti\""
  },
  Task_73395_Desc = {
    Text = "Ottieni 1 vittoria con \"Helot: Catena\""
  },
  Task_73396_Desc = {
    Text = "Usa \"Tavoletta delle Scritture Divine\" per ottenere 3 vittorie"
  },
  Task_73400_Desc = {
    Text = "Ottieni 1 vittoria usando \"Requiem Eterno\""
  },
  Task_73404_Desc = {
    Text = "Usa \"Uomo nello specchio\" per ottenere 1 vittoria"
  },
  Task_73405_Desc = {
    Text = "Ottieni 3 vittorie usando \"Nel cuore del diluvio\""
  },
  Task_73407_Desc = {
    Text = "Usa \"Dono della Decomposizione\" per ottenere 3 vittorie"
  },
  Task_73409_Desc = {
    Text = "Ottieni 3 vittorie con \"Celeste\""
  },
  Task_73410_Desc = {
    Text = "Ottieni 3 vittorie usando \"Intuizione\""
  },
  Task_73413_Desc = {
    Text = "Ottieni 1 vittoria usando \"Canto del Prigioniero\""
  },
  Task_73417_Desc = {
    Text = "Usa \"Sindrome della Memoria\" per ottenere 3 vittorie"
  },
  Task_73418_Desc = {
    Text = "Usa \"Uomo nello specchio\" per ottenere 3 vittorie"
  },
  Task_73422_Desc = {
    Text = "Ottieni 3 vittorie con \"24\""
  },
  Task_73425_Desc = {
    Text = "Usa \"Volontà Indomita\" per ottenere 1 vittoria"
  },
  Task_73426_Desc = {
    Text = "Ottieni 3 vittorie con \"Alva\""
  },
  Task_73427_Desc = {
    Text = "Ottieni 1 vittoria usando \"Frenesia\""
  },
  Task_73430_Desc = {
    Text = "Ottieni 3 vittorie usando \"Vitalità\""
  },
  Task_73431_Desc = {
    Text = "Ottieni 1 vittoria usando \"Esecuzione Senza Fine\""
  },
  Task_73432_Desc = {
    Text = "Ottieni 1 vittoria usando \"Gravità del Dovere\""
  },
  Task_73433_Desc = {
    Text = "Ottieni 3 vittorie usando \"Epifania\""
  },
  Task_73435_Desc = {
    Text = "Ottieni 3 vittorie usando \"Spirale della Memoria\""
  },
  Task_73437_Desc = {
    Text = "Ottieni 3 vittorie usando \"Speranza\""
  },
  Task_73440_Desc = {
    Text = "Ottieni 1 vittoria usando \"Sonno Sotto il Ghiacciaio\""
  },
  Task_73442_Desc = {
    Text = "Usa \"Festino di Sangue\" per ottenere 3 vittorie"
  },
  Task_73444_Desc = {
    Text = "Usa \"Alla deriva nel Desiderio\" per ottenere 3 vittorie"
  },
  Task_73445_Desc = {
    Text = "Ottieni 1 vittoria con \"Leigh\""
  },
  Task_73451_Desc = {
    Text = "Ottieni 3 vittorie con \"Helot\""
  },
  Task_73453_Desc = {
    Text = "Ottieni 3 vittorie usando \"Vela della Provvidenza\""
  },
  Task_73456_Desc = {
    Text = "Ottieni 1 vittoria con \"Faros\""
  },
  Task_73457_Desc = {
    Text = "Usa \"Voto del Cavaliere\" per ottenere 3 vittorie"
  },
  Task_73459_Desc = {
    Text = "Ottieni 3 vittorie usando \"Inno al Sovrano\""
  },
  Task_73462_Desc = {
    Text = "Ottieni 1 vittoria usando \"Suzione\""
  },
  Task_73584_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_73584_Name = {
    Text = "10 vittorie"
  },
  Task_73585_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_73585_Name = {Text = "1 vittoria"},
  Task_73586_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_73586_Name = {Text = "6 vittorie"},
  Task_73587_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_73587_Name = {Text = "3 vittorie"},
  Task_73588_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_73588_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_73589_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_73589_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_73590_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_73590_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_73591_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_73591_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_73592_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_73592_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_73593_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_73593_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_73594_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_73594_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_73595_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_73595_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_73596_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_73596_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_73597_Desc = {
    Text = "La Ghianda Magica raggiunge"
  },
  Task_73597_UnlockCondDesc = {
    Text = "Sbloccato dopo aver completato \"Turno d'Inversione: L'Istante dell'Inversione dell'Omniverso\", desideri procedere con \"Turno d'Inversione\"?"
  },
  Task_73672_Desc = {
    Text = "Ottieni Illuminare 2 per Doll Genesi"
  },
  Task_73672_Name = {
    Text = "Ottieni Illuminare 2 per Doll Genesi"
  },
  Task_73672_UnlockCondDesc = {
    Text = "Evento @Pacchetto Dono Illuminazione 1 Risvegliatore Genesi Doll Evento"
  },
  Task_73673_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_73674_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_73676_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_73677_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_73679_Desc = {
    Text = "Ottenere Genesi Doll Illuminare 6"
  },
  Task_73679_Name = {
    Text = "Ottenere Genesi Doll Illuminare 6"
  },
  Task_73679_UnlockCondDesc = {
    Text = "Evento @ Evento Pack Dono Illuminare 2 Risvegliatore Genesi Doll"
  },
  Task_73686_Desc = {
    Text = "L'Affinità di Doll: Inferno raggiunge il Livello 10"
  },
  Task_73880_Desc = {
    Text = "Segui Doll: Inferno per confermare la \"risposta\""
  },
  Task_73880_Name = {Text = "Bersaglio"},
  Task_73881_Desc = {
    Text = "Soppressione di Sarah mutata"
  },
  Task_73881_Name = {Text = "Bersaglio"},
  Task_73882_Desc = {
    Text = "Sconfiggi B-68"
  },
  Task_73882_Name = {Text = "Bersaglio"},
  Task_73883_Desc = {
    Text = "Esplorare il mondo dimensionale davanti a te"
  },
  Task_73883_Name = {Text = "Bersaglio"},
  Task_73884_Desc = {
    Text = "Calma Jenkin"
  },
  Task_73884_Name = {Text = "Bersaglio"},
  Task_73885_Desc = {
    Text = "Associa Doll: Inferno"
  },
  Task_73885_Name = {Text = "Bersaglio"},
  Task_73886_Desc = {
    Text = "Difendi la torre dell'orologio"
  },
  Task_73886_Name = {Text = "Bersaglio"},
  Task_73887_Desc = {
    Text = "Elimina i mutanti nel corridoio dell'Ospizio dei Poveri"
  },
  Task_73887_Name = {Text = "Bersaglio"},
  Task_73888_Desc = {
    Text = "Salvare Salvador da Juliette"
  },
  Task_73888_Name = {Text = "Bersaglio"},
  Task_73889_Desc = {
    Text = "Apri un varco verso la Grande Cattedrale della Redenzione"
  },
  Task_73889_Name = {Text = "Bersaglio"},
  Task_74202_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_74203_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_74204_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_74205_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_74206_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_74207_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_74208_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_74210_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_74211_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_74212_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_74222_Desc = {
    Text = "Completa l'Immersione Psichica \"Giorno dell'Incoronazione\""
  },
  Task_74222_Name = {
    Text = "Sovranità Eterna"
  },
  Task_74223_Desc = {
    Text = "Completa la Storia Principale \"Ritorno alla Grande Nebbia\" in modalità difficile"
  },
  Task_74223_Name = {
    Text = "Resisti alla Notte Grigia: Difficile"
  },
  Task_74224_Desc = {
    Text = "Risuona 10 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_74224_Desc2 = {
    Text = "Risonanza effettuata 10 volte nella Storia Principale \"Ritorno alla Grande Nebbia\"."
  },
  Task_74224_Name2 = {
    Text = "Eco del vuoto IV"
  },
  Task_74225_Desc = {
    Text = "Completa l'evento d'indagine \"@1@2\""
  },
  Task_74225_Desc2 = {
    Text = "Completa la Storia principale \"Ritorno alla Grande Nebbia\""
  },
  Task_74225_Name2 = {
    Text = "Resisti alla Notte Grigia"
  },
  Task_74226_Desc = {
    Text = "Risuona 3 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_74226_Desc2 = {
    Text = "Risonanza effettuata 3 volte nella Storia Principale \"Ritorno alla Grande Nebbia\"."
  },
  Task_74226_Name2 = {
    Text = "Eco del vuoto"
  },
  Task_74227_Desc = {
    Text = "Risuona 6 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_74227_Desc2 = {
    Text = "Risonanza effettuata 6 volte nella Storia Principale \"Ritorno alla Grande Nebbia\"."
  },
  Task_74227_Name2 = {
    Text = "Eco del vuoto II"
  },
  Task_74228_Desc = {
    Text = "Risuona 8 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_74228_Desc2 = {
    Text = "Risonanza effettuata 8 volte nella Storia Principale \"Ritorno alla Grande Nebbia\"."
  },
  Task_74228_Name2 = {
    Text = "Eco del vuoto III"
  },
  Task_74235_Desc = {Text = "Trova Liz"},
  Task_74235_Name = {Text = "Bersaglio"},
  Task_74295_Desc = {
    Text = "Completa l'Immersione Psichica \"Passione in Polvere\""
  },
  Task_74295_Name = {
    Text = "Danza delle Fiamme Smeraldo"
  },
  Task_74296_Desc = {
    Text = "Completa l'Immersione Psichica \"Passione in Polvere\" a difficoltà ardua"
  },
  Task_74296_Name = {
    Text = "Danza delle Fiamme Smeraldo: Hard"
  },
  Task_74332_Name = {
    Text = "L'evento Il Mio Turno è terminato"
  },
  Task_74333_Desc = {
    Text = "Capitolo Due della Narrazione del Turno d'Inversione Completato"
  },
  Task_74333_UnlockCondDesc = {
    Text = "Sblocca dopo aver raccolto \"Meraviglie del Turno: il punteggio raggiunge 1200\""
  },
  Task_74334_Desc = {
    Text = "Prologo del Round di Inversione completato"
  },
  Task_74335_Desc = {
    Text = "Capitolo Tre della Narrazione del Turno d'Inversione Completato"
  },
  Task_74335_UnlockCondDesc = {
    Text = "Sblocca dopo aver raccolto \"Meraviglie del Turno: il punteggio raggiunge 2400\""
  },
  Task_74342_Desc = {
    Text = "Gioca 25 Carte con personaggi Guardiano"
  },
  Task_74343_Desc = {
    Text = "Gioca 25 Carte con personaggi Malphas"
  },
  Task_74344_Desc = {
    Text = "Gioca 25 Carte con personaggi Benedizione"
  },
  Task_74345_Desc = {
    Text = "Gioca 25 Carte con personaggi Luminis"
  },
  Task_74346_Desc = {
    Text = "Gioca 25 Carte con personaggi Nato in Guerra"
  },
  Task_74375_Desc = {
    Text = "Gioca 1750 Carte con personaggi Nato in Guerra"
  },
  Task_74376_Desc = {
    Text = "Gioca 400 Carte con personaggi Benedizione"
  },
  Task_74377_Desc = {
    Text = "Gioca 1225 Carte con personaggi Luminis"
  },
  Task_74378_Desc = {
    Text = "Gioca 1125 Carte con personaggi Malphas"
  },
  Task_74379_Desc = {
    Text = "Gioca 775 Carte con personaggi Malphas"
  },
  Task_74380_Desc = {
    Text = "Gioca 1775 Carte con personaggi Benedizione"
  },
  Task_74381_Desc = {
    Text = "Gioca 775 Carte con personaggi Nato in Guerra"
  },
  Task_74382_Desc = {
    Text = "Gioca 700 Carte con personaggi Luminis"
  },
  Task_74383_Desc = {
    Text = "Gioca 1875 Carte con personaggi Guardiano"
  },
  Task_74384_Desc = {
    Text = "Gioca 825 Carte con personaggi Benedizione"
  },
  Task_74385_Desc = {
    Text = "Gioca 1800 Carte con personaggi Nato in Guerra"
  },
  Task_74386_Desc = {
    Text = "Gioca 1200 Carte con personaggi Nato in Guerra"
  },
  Task_74387_Desc = {
    Text = "Gioca 775 Carte con personaggi Benedizione"
  },
  Task_74388_Desc = {
    Text = "Gioca 525 Carte con personaggi Luminis"
  },
  Task_74389_Desc = {
    Text = "Gioca 1600 Carte con personaggi Luminis"
  },
  Task_74390_Desc = {
    Text = "Gioca 675 Carte con personaggi Benedizione"
  },
  Task_74391_Desc = {
    Text = "Gioca 1975 Carte con personaggi Nato in Guerra"
  },
  Task_74392_Desc = {
    Text = "Gioca 1525 Carte con personaggi Guardiano"
  },
  Task_74393_Desc = {
    Text = "Gioca 1325 Carte con personaggi Malphas"
  },
  Task_74394_Desc = {
    Text = "Gioca 1550 Carte con personaggi Malphas"
  },
  Task_74395_Desc = {
    Text = "Gioca 1125 Carte con personaggi Benedizione"
  },
  Task_74396_Desc = {
    Text = "Gioca 125 Carte con personaggi Malphas"
  },
  Task_74397_Desc = {
    Text = "Gioca 1600 Carte con personaggi Malphas"
  },
  Task_74398_Desc = {
    Text = "Gioca 650 Carte con personaggi Benedizione"
  },
  Task_74399_Desc = {
    Text = "Gioca 325 Carte con personaggi Malphas"
  },
  Task_74400_Desc = {
    Text = "Gioca 1325 Carte con personaggi Benedizione"
  },
  Task_74401_Desc = {
    Text = "Gioca 150 Carte con personaggi Benedizione"
  },
  Task_74402_Desc = {
    Text = "Gioca 50 Carte con personaggi Malphas"
  },
  Task_74403_Desc = {
    Text = "Gioca 2000 Carte con personaggi Benedizione"
  },
  Task_74404_Desc = {
    Text = "Gioca 850 Carte con personaggi Nato in Guerra"
  },
  Task_74405_Desc = {
    Text = "Gioca 1150 Carte con personaggi Benedizione"
  },
  Task_74406_Desc = {
    Text = "Gioca 150 Carte con personaggi Malphas"
  },
  Task_74407_Desc = {
    Text = "Gioca 550 Carte con personaggi Guardiano"
  },
  Task_74408_Desc = {
    Text = "Gioca 800 Carte con personaggi Malphas"
  },
  Task_74409_Desc = {
    Text = "Gioca 100 Carte con personaggi Nato in Guerra"
  },
  Task_74410_Desc = {
    Text = "Gioca 1600 Carte con personaggi Guardiano"
  },
  Task_74411_Desc = {
    Text = "Gioca 1300 Carte con personaggi Luminis"
  },
  Task_74412_Desc = {
    Text = "Gioca 1850 Carte con personaggi Benedizione"
  },
  Task_74413_Desc = {
    Text = "Gioca 1525 Carte con personaggi Luminis"
  },
  Task_74414_Desc = {
    Text = "Gioca 1425 Carte con personaggi Guardiano"
  },
  Task_74415_Desc = {
    Text = "Gioca 1275 Carte con personaggi Guardiano"
  },
  Task_74416_Desc = {
    Text = "Gioca 925 Carte con personaggi Luminis"
  },
  Task_74417_Desc = {
    Text = "Gioca 800 Carte con personaggi Guardiano"
  },
  Task_74418_Desc = {
    Text = "Gioca 1625 Carte con personaggi Luminis"
  },
  Task_74419_Desc = {
    Text = "Gioca 1775 Carte con personaggi Luminis"
  },
  Task_74420_Desc = {
    Text = "Gioca 1100 Carte con personaggi Benedizione"
  },
  Task_74421_Desc = {
    Text = "Gioca 100 Carte con personaggi Malphas"
  },
  Task_74422_Desc = {
    Text = "Gioca 1750 Carte con personaggi Luminis"
  },
  Task_74423_Desc = {
    Text = "Gioca 1125 Carte con personaggi Luminis"
  },
  Task_74424_Desc = {
    Text = "Gioca 750 Carte con personaggi Luminis"
  },
  Task_74425_Desc = {
    Text = "Gioca 1725 Carte con personaggi Malphas"
  },
  Task_74426_Desc = {
    Text = "Gioca 1150 Carte con personaggi Nato in Guerra"
  },
  Task_74427_Desc = {
    Text = "Gioca 175 Carte con personaggi Luminis"
  },
  Task_74428_Desc = {
    Text = "Gioca 1625 Carte con personaggi Malphas"
  },
  Task_74429_Desc = {
    Text = "Gioca 425 Carte con personaggi Benedizione"
  },
  Task_74430_Desc = {
    Text = "Gioca 1700 Carte con personaggi Luminis"
  },
  Task_74431_Desc = {
    Text = "Gioca 1325 Carte con personaggi Nato in Guerra"
  },
  Task_74432_Desc = {
    Text = "Gioca 1225 Carte con personaggi Benedizione"
  },
  Task_74433_Desc = {
    Text = "Gioca 225 Carte con personaggi Malphas"
  },
  Task_74434_Desc = {
    Text = "Gioca 1875 Carte con personaggi Nato in Guerra"
  },
  Task_74435_Desc = {
    Text = "Gioca 725 Carte con personaggi Luminis"
  },
  Task_74436_Desc = {
    Text = "Gioca 325 Carte con personaggi Luminis"
  },
  Task_74437_Desc = {
    Text = "Gioca 1350 Carte con personaggi Luminis"
  },
  Task_74438_Desc = {
    Text = "Gioca 1725 Carte con personaggi Guardiano"
  },
  Task_74439_Desc = {
    Text = "Gioca 1375 Carte con personaggi Nato in Guerra"
  },
  Task_74440_Desc = {
    Text = "Gioca 925 Carte con personaggi Guardiano"
  },
  Task_74441_Desc = {
    Text = "Gioca 1950 Carte con personaggi Malphas"
  },
  Task_74442_Desc = {
    Text = "Gioca 450 Carte con personaggi Nato in Guerra"
  },
  Task_74443_Desc = {
    Text = "Gioca 175 Carte con personaggi Guardiano"
  },
  Task_74444_Desc = {
    Text = "Gioca 1100 Carte con personaggi Guardiano"
  },
  Task_74445_Desc = {
    Text = "Gioca 450 Carte con personaggi Guardiano"
  },
  Task_74446_Desc = {
    Text = "Gioca 1225 Carte con personaggi Nato in Guerra"
  },
  Task_74447_Desc = {
    Text = "Gioca 1475 Carte con personaggi Luminis"
  },
  Task_74448_Desc = {
    Text = "Gioca 1250 Carte con personaggi Guardiano"
  },
  Task_74449_Desc = {
    Text = "Gioca 100 Carte con personaggi Luminis"
  },
  Task_74450_Desc = {
    Text = "Gioca 975 Carte con personaggi Nato in Guerra"
  },
  Task_74451_Desc = {
    Text = "Gioca 800 Carte con personaggi Benedizione"
  },
  Task_74452_Desc = {
    Text = "Gioca 1875 Carte con personaggi Malphas"
  },
  Task_74453_Desc = {
    Text = "Gioca 900 Carte con personaggi Nato in Guerra"
  },
  Task_74454_Desc = {
    Text = "Gioca 1950 Carte con personaggi Guardiano"
  },
  Task_74455_Desc = {
    Text = "Gioca 1000 Carte con personaggi Guardiano"
  },
  Task_74456_Desc = {
    Text = "Gioca 1925 Carte con personaggi Nato in Guerra"
  },
  Task_74457_Desc = {
    Text = "Gioca 1825 Carte con personaggi Luminis"
  },
  Task_74458_Desc = {
    Text = "Gioca 1725 Carte con personaggi Nato in Guerra"
  },
  Task_74459_Desc = {
    Text = "Gioca 1500 Carte con personaggi Malphas"
  },
  Task_74460_Desc = {
    Text = "Gioca 1375 Carte con personaggi Malphas"
  },
  Task_74461_Desc = {
    Text = "Gioca 350 Carte con personaggi Guardiano"
  },
  Task_74462_Desc = {
    Text = "Gioca 1975 Carte con personaggi Malphas"
  },
  Task_74463_Desc = {
    Text = "Gioca 625 Carte con personaggi Guardiano"
  },
  Task_74464_Desc = {
    Text = "Gioca 500 Carte con personaggi Guardiano"
  },
  Task_74465_Desc = {
    Text = "Gioca 1200 Carte con personaggi Luminis"
  },
  Task_74466_Desc = {
    Text = "Gioca 775 Carte con personaggi Luminis"
  },
  Task_74467_Desc = {
    Text = "Gioca 975 Carte con personaggi Luminis"
  },
  Task_74468_Desc = {
    Text = "Gioca 1550 Carte con personaggi Luminis"
  },
  Task_74469_Desc = {
    Text = "Gioca 2000 Carte con personaggi Luminis"
  },
  Task_74470_Desc = {
    Text = "Gioca 1050 Carte con personaggi Malphas"
  },
  Task_74471_Desc = {
    Text = "Gioca 1700 Carte con personaggi Guardiano"
  },
  Task_74472_Desc = {
    Text = "Gioca 1500 Carte con personaggi Nato in Guerra"
  },
  Task_74473_Desc = {
    Text = "Gioca 75 Carte con personaggi Benedizione"
  },
  Task_74474_Desc = {
    Text = "Gioca 550 Carte con personaggi Benedizione"
  },
  Task_74475_Desc = {
    Text = "Gioca 150 Carte con personaggi Luminis"
  },
  Task_74476_Desc = {
    Text = "Gioca 1575 Carte con personaggi Nato in Guerra"
  },
  Task_74477_Desc = {
    Text = "Gioca 425 Carte con personaggi Luminis"
  },
  Task_74478_Desc = {
    Text = "Gioca 950 Carte con personaggi Guardiano"
  },
  Task_74479_Desc = {
    Text = "Gioca 700 Carte con personaggi Guardiano"
  },
  Task_74480_Desc = {
    Text = "Gioca 1175 Carte con personaggi Nato in Guerra"
  },
  Task_74481_Desc = {
    Text = "Gioca 700 Carte con personaggi Nato in Guerra"
  },
  Task_74482_Desc = {
    Text = "Gioca 1275 Carte con personaggi Benedizione"
  },
  Task_74483_Desc = {
    Text = "Gioca 625 Carte con personaggi Luminis"
  },
  Task_74484_Desc = {
    Text = "Gioca 275 Carte con personaggi Malphas"
  },
  Task_74485_Desc = {
    Text = "Gioca 1575 Carte con personaggi Guardiano"
  },
  Task_74486_Desc = {
    Text = "Gioca 1400 Carte con personaggi Guardiano"
  },
  Task_74487_Desc = {
    Text = "Gioca 1675 Carte con personaggi Nato in Guerra"
  },
  Task_74488_Desc = {
    Text = "Gioca 1075 Carte con personaggi Luminis"
  },
  Task_74489_Desc = {
    Text = "Gioca 325 Carte con personaggi Guardiano"
  },
  Task_74490_Desc = {
    Text = "Gioca 1025 Carte con personaggi Benedizione"
  },
  Task_74491_Desc = {
    Text = "Gioca 1025 Carte con personaggi Luminis"
  },
  Task_74492_Desc = {
    Text = "Gioca 1050 Carte con personaggi Luminis"
  },
  Task_74493_Desc = {
    Text = "Gioca 600 Carte con personaggi Guardiano"
  },
  Task_74494_Desc = {
    Text = "Gioca 1900 Carte con personaggi Luminis"
  },
  Task_74495_Desc = {
    Text = "Gioca 125 Carte con personaggi Guardiano"
  },
  Task_74496_Desc = {
    Text = "Gioca 200 Carte con personaggi Luminis"
  },
  Task_74497_Desc = {
    Text = "Gioca 1575 Carte con personaggi Benedizione"
  },
  Task_74498_Desc = {
    Text = "Gioca 575 Carte con personaggi Malphas"
  },
  Task_74499_Desc = {
    Text = "Gioca 800 Carte con personaggi Nato in Guerra"
  },
  Task_74500_Desc = {
    Text = "Gioca 1275 Carte con personaggi Luminis"
  },
  Task_74501_Desc = {
    Text = "Gioca 1625 Carte con personaggi Guardiano"
  },
  Task_74502_Desc = {
    Text = "Gioca 1900 Carte con personaggi Benedizione"
  },
  Task_74503_Desc = {
    Text = "Gioca 1100 Carte con personaggi Nato in Guerra"
  },
  Task_74504_Desc = {
    Text = "Gioca 150 Carte con personaggi Nato in Guerra"
  },
  Task_74505_Desc = {
    Text = "Gioca 50 Carte con personaggi Benedizione"
  },
  Task_74506_Desc = {
    Text = "Gioca 1025 Carte con personaggi Nato in Guerra"
  },
  Task_74507_Desc = {
    Text = "Gioca 1900 Carte con personaggi Nato in Guerra"
  },
  Task_74508_Desc = {
    Text = "Gioca 675 Carte con personaggi Nato in Guerra"
  },
  Task_74509_Desc = {
    Text = "Gioca 1925 Carte con personaggi Guardiano"
  },
  Task_74510_Desc = {
    Text = "Gioca 1850 Carte con personaggi Luminis"
  },
  Task_74511_Desc = {
    Text = "Gioca 1250 Carte con personaggi Malphas"
  },
  Task_74512_Desc = {
    Text = "Gioca 1950 Carte con personaggi Nato in Guerra"
  },
  Task_74513_Desc = {
    Text = "Gioca 550 Carte con personaggi Nato in Guerra"
  },
  Task_74514_Desc = {
    Text = "Gioca 250 Carte con personaggi Nato in Guerra"
  },
  Task_74515_Desc = {
    Text = "Gioca 1525 Carte con personaggi Malphas"
  },
  Task_74516_Desc = {
    Text = "Gioca 75 Carte con personaggi Guardiano"
  },
  Task_74517_Desc = {
    Text = "Gioca 1150 Carte con personaggi Luminis"
  },
  Task_74518_Desc = {
    Text = "Gioca 825 Carte con personaggi Malphas"
  },
  Task_74519_Desc = {
    Text = "Gioca 50 Carte con personaggi Guardiano"
  },
  Task_74520_Desc = {
    Text = "Gioca 1200 Carte con personaggi Malphas"
  },
  Task_74521_Desc = {
    Text = "Gioca 1600 Carte con personaggi Nato in Guerra"
  },
  Task_74522_Desc = {
    Text = "Gioca 1125 Carte con personaggi Nato in Guerra"
  },
  Task_74523_Desc = {
    Text = "Gioca 1425 Carte con personaggi Malphas"
  },
  Task_74524_Desc = {
    Text = "Gioca 225 Carte con personaggi Nato in Guerra"
  },
  Task_74525_Desc = {
    Text = "Gioca 375 Carte con personaggi Luminis"
  },
  Task_74526_Desc = {
    Text = "Gioca 1475 Carte con personaggi Guardiano"
  },
  Task_74527_Desc = {
    Text = "Gioca 100 Carte con personaggi Guardiano"
  },
  Task_74528_Desc = {
    Text = "Gioca 375 Carte con personaggi Nato in Guerra"
  },
  Task_74529_Desc = {
    Text = "Gioca 1850 Carte con personaggi Guardiano"
  },
  Task_74530_Desc = {
    Text = "Gioca 350 Carte con personaggi Nato in Guerra"
  },
  Task_74531_Desc = {
    Text = "Gioca 1675 Carte con personaggi Benedizione"
  },
  Task_74532_Desc = {
    Text = "Gioca 675 Carte con personaggi Malphas"
  },
  Task_74533_Desc = {
    Text = "Gioca 1650 Carte con personaggi Luminis"
  },
  Task_74534_Desc = {
    Text = "Gioca 75 Carte con personaggi Luminis"
  },
  Task_74535_Desc = {
    Text = "Gioca 50 Carte con personaggi Nato in Guerra"
  },
  Task_74536_Desc = {
    Text = "Gioca 875 Carte con personaggi Nato in Guerra"
  },
  Task_74537_Desc = {
    Text = "Gioca 1650 Carte con personaggi Guardiano"
  },
  Task_74538_Desc = {
    Text = "Gioca 250 Carte con personaggi Benedizione"
  },
  Task_74539_Desc = {
    Text = "Gioca 100 Carte con personaggi Benedizione"
  },
  Task_74540_Desc = {
    Text = "Gioca 1075 Carte con personaggi Benedizione"
  },
  Task_74541_Desc = {
    Text = "Gioca 1750 Carte con personaggi Malphas"
  },
  Task_74542_Desc = {
    Text = "Gioca 750 Carte con personaggi Nato in Guerra"
  },
  Task_74543_Desc = {
    Text = "Gioca 550 Carte con personaggi Luminis"
  },
  Task_74544_Desc = {
    Text = "Gioca 1450 Carte con personaggi Nato in Guerra"
  },
  Task_74545_Desc = {
    Text = "Gioca 725 Carte con personaggi Nato in Guerra"
  },
  Task_74546_Desc = {
    Text = "Gioca 600 Carte con personaggi Luminis"
  },
  Task_74547_Desc = {
    Text = "Gioca 700 Carte con personaggi Benedizione"
  },
  Task_74548_Desc = {
    Text = "Gioca 1550 Carte con personaggi Guardiano"
  },
  Task_74549_Desc = {
    Text = "Gioca 850 Carte con personaggi Benedizione"
  },
  Task_74550_Desc = {
    Text = "Gioca 1450 Carte con personaggi Malphas"
  },
  Task_74551_Desc = {
    Text = "Gioca 1625 Carte con personaggi Nato in Guerra"
  },
  Task_74552_Desc = {
    Text = "Gioca 200 Carte con personaggi Nato in Guerra"
  },
  Task_74553_Desc = {
    Text = "Gioca 1525 Carte con personaggi Benedizione"
  },
  Task_74554_Desc = {
    Text = "Gioca 525 Carte con personaggi Malphas"
  },
  Task_74555_Desc = {
    Text = "Gioca 325 Carte con personaggi Benedizione"
  },
  Task_74556_Desc = {
    Text = "Gioca 1525 Carte con personaggi Nato in Guerra"
  },
  Task_74557_Desc = {
    Text = "Gioca 375 Carte con personaggi Malphas"
  },
  Task_74558_Desc = {
    Text = "Gioca 1375 Carte con personaggi Benedizione"
  },
  Task_74559_Desc = {
    Text = "Gioca 300 Carte con personaggi Benedizione"
  },
  Task_74560_Desc = {
    Text = "Gioca 225 Carte con personaggi Benedizione"
  },
  Task_74561_Desc = {
    Text = "Gioca 1850 Carte con personaggi Nato in Guerra"
  },
  Task_74562_Desc = {
    Text = "Gioca 475 Carte con personaggi Guardiano"
  },
  Task_74563_Desc = {
    Text = "Gioca 600 Carte con personaggi Benedizione"
  },
  Task_74564_Desc = {
    Text = "Gioca 1375 Carte con personaggi Guardiano"
  },
  Task_74565_Desc = {
    Text = "Gioca 1450 Carte con personaggi Guardiano"
  },
  Task_74566_Desc = {
    Text = "Gioca 300 Carte con personaggi Guardiano"
  },
  Task_74567_Desc = {
    Text = "Gioca 950 Carte con personaggi Luminis"
  },
  Task_74568_Desc = {
    Text = "Gioca 1200 Carte con personaggi Guardiano"
  },
  Task_74569_Desc = {
    Text = "Gioca 1025 Carte con personaggi Malphas"
  },
  Task_74570_Desc = {
    Text = "Gioca 950 Carte con personaggi Benedizione"
  },
  Task_74571_Desc = {
    Text = "Gioca 1350 Carte con personaggi Nato in Guerra"
  },
  Task_74572_Desc = {
    Text = "Gioca 525 Carte con personaggi Guardiano"
  },
  Task_74573_Desc = {
    Text = "Gioca 125 Carte con personaggi Nato in Guerra"
  },
  Task_74574_Desc = {
    Text = "Gioca 475 Carte con personaggi Benedizione"
  },
  Task_74575_Desc = {
    Text = "Gioca 350 Carte con personaggi Luminis"
  },
  Task_74576_Desc = {
    Text = "Gioca 1175 Carte con personaggi Luminis"
  },
  Task_74577_Desc = {
    Text = "Gioca 1250 Carte con personaggi Luminis"
  },
  Task_74578_Desc = {
    Text = "Gioca 775 Carte con personaggi Guardiano"
  },
  Task_74579_Desc = {
    Text = "Gioca 400 Carte con personaggi Guardiano"
  },
  Task_74580_Desc = {
    Text = "Gioca 825 Carte con personaggi Nato in Guerra"
  },
  Task_74581_Desc = {
    Text = "Gioca 650 Carte con personaggi Luminis"
  },
  Task_74582_Desc = {
    Text = "Gioca 1575 Carte con personaggi Malphas"
  },
  Task_74583_Desc = {
    Text = "Gioca 350 Carte con personaggi Benedizione"
  },
  Task_74584_Desc = {
    Text = "Gioca 1400 Carte con personaggi Nato in Guerra"
  },
  Task_74585_Desc = {
    Text = "Gioca 275 Carte con personaggi Guardiano"
  },
  Task_74586_Desc = {
    Text = "Gioca 1500 Carte con personaggi Benedizione"
  },
  Task_74587_Desc = {
    Text = "Gioca 500 Carte con personaggi Malphas"
  },
  Task_74588_Desc = {
    Text = "Gioca 1075 Carte con personaggi Nato in Guerra"
  },
  Task_74589_Desc = {
    Text = "Gioca 625 Carte con personaggi Benedizione"
  },
  Task_74590_Desc = {
    Text = "Gioca 575 Carte con personaggi Nato in Guerra"
  },
  Task_74591_Desc = {
    Text = "Gioca 850 Carte con personaggi Malphas"
  },
  Task_74592_Desc = {
    Text = "Gioca 650 Carte con personaggi Guardiano"
  },
  Task_74593_Desc = {
    Text = "Gioca 575 Carte con personaggi Benedizione"
  },
  Task_74594_Desc = {
    Text = "Gioca 375 Carte con personaggi Benedizione"
  },
  Task_74595_Desc = {
    Text = "Gioca 225 Carte con personaggi Guardiano"
  },
  Task_74596_Desc = {
    Text = "Gioca 1875 Carte con personaggi Luminis"
  },
  Task_74597_Desc = {
    Text = "Gioca 1075 Carte con personaggi Guardiano"
  },
  Task_74598_Desc = {
    Text = "Gioca 1825 Carte con personaggi Nato in Guerra"
  },
  Task_74599_Desc = {
    Text = "Gioca 1700 Carte con personaggi Malphas"
  },
  Task_74600_Desc = {
    Text = "Gioca 150 Carte con personaggi Guardiano"
  },
  Task_74601_Desc = {
    Text = "Gioca 1750 Carte con personaggi Guardiano"
  },
  Task_74602_Desc = {
    Text = "Gioca 1975 Carte con personaggi Guardiano"
  },
  Task_74603_Desc = {
    Text = "Gioca 750 Carte con personaggi Malphas"
  },
  Task_74604_Desc = {
    Text = "Gioca 1750 Carte con personaggi Benedizione"
  },
  Task_74605_Desc = {
    Text = "Gioca 1150 Carte con personaggi Malphas"
  },
  Task_74606_Desc = {
    Text = "Gioca 1475 Carte con personaggi Malphas"
  },
  Task_74607_Desc = {
    Text = "Gioca 875 Carte con personaggi Guardiano"
  },
  Task_74608_Desc = {
    Text = "Gioca 725 Carte con personaggi Malphas"
  },
  Task_74609_Desc = {
    Text = "Gioca 1725 Carte con personaggi Benedizione"
  },
  Task_74610_Desc = {
    Text = "Gioca 1800 Carte con personaggi Malphas"
  },
  Task_74611_Desc = {
    Text = "Gioca 1050 Carte con personaggi Benedizione"
  },
  Task_74612_Desc = {
    Text = "Gioca 1925 Carte con personaggi Benedizione"
  },
  Task_74613_Desc = {
    Text = "Gioca 925 Carte con personaggi Malphas"
  },
  Task_74614_Desc = {
    Text = "Gioca 250 Carte con personaggi Luminis"
  },
  Task_74615_Desc = {
    Text = "Gioca 900 Carte con personaggi Luminis"
  },
  Task_74616_Desc = {
    Text = "Gioca 350 Carte con personaggi Malphas"
  },
  Task_74617_Desc = {
    Text = "Gioca 1350 Carte con personaggi Benedizione"
  },
  Task_74618_Desc = {
    Text = "Gioca 125 Carte con personaggi Benedizione"
  },
  Task_74619_Desc = {
    Text = "Gioca 1775 Carte con personaggi Malphas"
  },
  Task_74620_Desc = {
    Text = "Gioca 1925 Carte con personaggi Malphas"
  },
  Task_74621_Desc = {
    Text = "Gioca 1900 Carte con personaggi Malphas"
  },
  Task_74622_Desc = {
    Text = "Gioca 875 Carte con personaggi Luminis"
  },
  Task_74623_Desc = {
    Text = "Gioca 250 Carte con personaggi Guardiano"
  },
  Task_74624_Desc = {
    Text = "Gioca 900 Carte con personaggi Guardiano"
  },
  Task_74625_Desc = {
    Text = "Gioca 675 Carte con personaggi Guardiano"
  },
  Task_74626_Desc = {
    Text = "Gioca 1350 Carte con personaggi Guardiano"
  },
  Task_74627_Desc = {
    Text = "Gioca 1450 Carte con personaggi Luminis"
  },
  Task_74628_Desc = {
    Text = "Gioca 875 Carte con personaggi Benedizione"
  },
  Task_74629_Desc = {
    Text = "Gioca 1550 Carte con personaggi Nato in Guerra"
  },
  Task_74630_Desc = {
    Text = "Gioca 1000 Carte con personaggi Luminis"
  },
  Task_74631_Desc = {
    Text = "Gioca 2000 Carte con personaggi Malphas"
  },
  Task_74632_Desc = {
    Text = "Gioca 675 Carte con personaggi Luminis"
  },
  Task_74633_Desc = {
    Text = "Gioca 1025 Carte con personaggi Guardiano"
  },
  Task_74634_Desc = {
    Text = "Gioca 1300 Carte con personaggi Malphas"
  },
  Task_74635_Desc = {
    Text = "Gioca 1800 Carte con personaggi Luminis"
  },
  Task_74636_Desc = {
    Text = "Gioca 1825 Carte con personaggi Guardiano"
  },
  Task_74637_Desc = {
    Text = "Gioca 1700 Carte con personaggi Nato in Guerra"
  },
  Task_74638_Desc = {
    Text = "Gioca 1000 Carte con personaggi Nato in Guerra"
  },
  Task_74639_Desc = {
    Text = "Gioca 275 Carte con personaggi Benedizione"
  },
  Task_74640_Desc = {
    Text = "Gioca 1100 Carte con personaggi Luminis"
  },
  Task_74641_Desc = {
    Text = "Gioca 1800 Carte con personaggi Benedizione"
  },
  Task_74642_Desc = {
    Text = "Gioca 1475 Carte con personaggi Nato in Guerra"
  },
  Task_74643_Desc = {
    Text = "Gioca 1225 Carte con personaggi Malphas"
  },
  Task_74644_Desc = {
    Text = "Gioca 975 Carte con personaggi Benedizione"
  },
  Task_74645_Desc = {
    Text = "Gioca 400 Carte con personaggi Nato in Guerra"
  },
  Task_74646_Desc = {
    Text = "Gioca 800 Carte con personaggi Luminis"
  },
  Task_74647_Desc = {
    Text = "Gioca 1925 Carte con personaggi Luminis"
  },
  Task_74648_Desc = {
    Text = "Gioca 1375 Carte con personaggi Luminis"
  },
  Task_74649_Desc = {
    Text = "Gioca 400 Carte con personaggi Luminis"
  },
  Task_74650_Desc = {
    Text = "Gioca 1000 Carte con personaggi Benedizione"
  },
  Task_74651_Desc = {
    Text = "Gioca 700 Carte con personaggi Malphas"
  },
  Task_74652_Desc = {
    Text = "Gioca 1700 Carte con personaggi Benedizione"
  },
  Task_74653_Desc = {
    Text = "Gioca 1075 Carte con personaggi Malphas"
  },
  Task_74654_Desc = {
    Text = "Gioca 1050 Carte con personaggi Nato in Guerra"
  },
  Task_74655_Desc = {
    Text = "Gioca 175 Carte con personaggi Nato in Guerra"
  },
  Task_74656_Desc = {
    Text = "Gioca 300 Carte con personaggi Luminis"
  },
  Task_74657_Desc = {
    Text = "Gioca 1000 Carte con personaggi Malphas"
  },
  Task_74658_Desc = {
    Text = "Gioca 825 Carte con personaggi Luminis"
  },
  Task_74659_Desc = {
    Text = "Gioca 600 Carte con personaggi Nato in Guerra"
  },
  Task_74660_Desc = {
    Text = "Gioca 725 Carte con personaggi Guardiano"
  },
  Task_74661_Desc = {
    Text = "Gioca 750 Carte con personaggi Guardiano"
  },
  Task_74662_Desc = {
    Text = "Gioca 1675 Carte con personaggi Malphas"
  },
  Task_74663_Desc = {
    Text = "Gioca 1500 Carte con personaggi Luminis"
  },
  Task_74664_Desc = {
    Text = "Gioca 375 Carte con personaggi Guardiano"
  },
  Task_74665_Desc = {
    Text = "Gioca 1150 Carte con personaggi Guardiano"
  },
  Task_74666_Desc = {
    Text = "Gioca 275 Carte con personaggi Luminis"
  },
  Task_74667_Desc = {
    Text = "Gioca 900 Carte con personaggi Benedizione"
  },
  Task_74668_Desc = {
    Text = "Gioca 475 Carte con personaggi Luminis"
  },
  Task_74669_Desc = {
    Text = "Gioca 75 Carte con personaggi Malphas"
  },
  Task_74670_Desc = {
    Text = "Gioca 175 Carte con personaggi Benedizione"
  },
  Task_74671_Desc = {
    Text = "Gioca 1775 Carte con personaggi Guardiano"
  },
  Task_74672_Desc = {
    Text = "Gioca 575 Carte con personaggi Luminis"
  },
  Task_74673_Desc = {
    Text = "Gioca 500 Carte con personaggi Nato in Guerra"
  },
  Task_74674_Desc = {
    Text = "Gioca 1725 Carte con personaggi Luminis"
  },
  Task_74675_Desc = {
    Text = "Gioca 950 Carte con personaggi Nato in Guerra"
  },
  Task_74676_Desc = {
    Text = "Gioca 1950 Carte con personaggi Luminis"
  },
  Task_74677_Desc = {
    Text = "Gioca 1500 Carte con personaggi Guardiano"
  },
  Task_74678_Desc = {
    Text = "Gioca 1975 Carte con personaggi Benedizione"
  },
  Task_74679_Desc = {
    Text = "Gioca 975 Carte con personaggi Malphas"
  },
  Task_74680_Desc = {
    Text = "Gioca 1325 Carte con personaggi Luminis"
  },
  Task_74681_Desc = {
    Text = "Gioca 1775 Carte con personaggi Nato in Guerra"
  },
  Task_74682_Desc = {
    Text = "Gioca 125 Carte con personaggi Luminis"
  },
  Task_74683_Desc = {
    Text = "Gioca 1550 Carte con personaggi Benedizione"
  },
  Task_74684_Desc = {
    Text = "Gioca 2000 Carte con personaggi Nato in Guerra"
  },
  Task_74685_Desc = {
    Text = "Gioca 1275 Carte con personaggi Malphas"
  },
  Task_74686_Desc = {
    Text = "Gioca 525 Carte con personaggi Benedizione"
  },
  Task_74687_Desc = {
    Text = "Gioca 550 Carte con personaggi Malphas"
  },
  Task_74688_Desc = {
    Text = "Gioca 650 Carte con personaggi Nato in Guerra"
  },
  Task_74689_Desc = {
    Text = "Gioca 875 Carte con personaggi Malphas"
  },
  Task_74690_Desc = {
    Text = "Gioca 1875 Carte con personaggi Benedizione"
  },
  Task_74691_Desc = {
    Text = "Gioca 1300 Carte con personaggi Guardiano"
  },
  Task_74692_Desc = {
    Text = "Gioca 1100 Carte con personaggi Malphas"
  },
  Task_74693_Desc = {
    Text = "Gioca 2000 Carte con personaggi Guardiano"
  },
  Task_74694_Desc = {
    Text = "Gioca 1850 Carte con personaggi Malphas"
  },
  Task_74695_Desc = {
    Text = "Gioca 75 Carte con personaggi Nato in Guerra"
  },
  Task_74696_Desc = {
    Text = "Gioca 625 Carte con personaggi Nato in Guerra"
  },
  Task_74697_Desc = {
    Text = "Gioca 1425 Carte con personaggi Nato in Guerra"
  },
  Task_74698_Desc = {
    Text = "Gioca 1800 Carte con personaggi Guardiano"
  },
  Task_74699_Desc = {
    Text = "Gioca 225 Carte con personaggi Luminis"
  },
  Task_74700_Desc = {
    Text = "Gioca 725 Carte con personaggi Benedizione"
  },
  Task_74701_Desc = {
    Text = "Gioca 1175 Carte con personaggi Guardiano"
  },
  Task_74702_Desc = {
    Text = "Gioca 450 Carte con personaggi Luminis"
  },
  Task_74703_Desc = {
    Text = "Gioca 575 Carte con personaggi Guardiano"
  },
  Task_74704_Desc = {
    Text = "Gioca 1625 Carte con personaggi Benedizione"
  },
  Task_74705_Desc = {
    Text = "Gioca 625 Carte con personaggi Malphas"
  },
  Task_74706_Desc = {
    Text = "Gioca 1350 Carte con personaggi Malphas"
  },
  Task_74707_Desc = {
    Text = "Gioca 1650 Carte con personaggi Benedizione"
  },
  Task_74708_Desc = {
    Text = "Gioca 650 Carte con personaggi Malphas"
  },
  Task_74709_Desc = {
    Text = "Gioca 200 Carte con personaggi Guardiano"
  },
  Task_74710_Desc = {
    Text = "Gioca 1125 Carte con personaggi Guardiano"
  },
  Task_74711_Desc = {
    Text = "Gioca 50 Carte con personaggi Luminis"
  },
  Task_74712_Desc = {
    Text = "Gioca 450 Carte con personaggi Malphas"
  },
  Task_74713_Desc = {
    Text = "Gioca 1250 Carte con personaggi Benedizione"
  },
  Task_74714_Desc = {
    Text = "Gioca 250 Carte con personaggi Malphas"
  },
  Task_74715_Desc = {
    Text = "Gioca 1450 Carte con personaggi Benedizione"
  },
  Task_74716_Desc = {
    Text = "Gioca 1675 Carte con personaggi Luminis"
  },
  Task_74717_Desc = {
    Text = "Gioca 900 Carte con personaggi Malphas"
  },
  Task_74718_Desc = {
    Text = "Gioca 500 Carte con personaggi Luminis"
  },
  Task_74719_Desc = {
    Text = "Gioca 1325 Carte con personaggi Guardiano"
  },
  Task_74720_Desc = {
    Text = "Gioca 425 Carte con personaggi Malphas"
  },
  Task_74721_Desc = {
    Text = "Gioca 1425 Carte con personaggi Benedizione"
  },
  Task_74722_Desc = {
    Text = "Gioca 1300 Carte con personaggi Nato in Guerra"
  },
  Task_74723_Desc = {
    Text = "Gioca 925 Carte con personaggi Benedizione"
  },
  Task_74724_Desc = {
    Text = "Gioca 1825 Carte con personaggi Benedizione"
  },
  Task_74725_Desc = {
    Text = "Gioca 1175 Carte con personaggi Benedizione"
  },
  Task_74726_Desc = {
    Text = "Gioca 175 Carte con personaggi Malphas"
  },
  Task_74727_Desc = {
    Text = "Gioca 750 Carte con personaggi Benedizione"
  },
  Task_74728_Desc = {
    Text = "Gioca 850 Carte con personaggi Guardiano"
  },
  Task_74729_Desc = {
    Text = "Gioca 1650 Carte con personaggi Nato in Guerra"
  },
  Task_74730_Desc = {
    Text = "Gioca 1275 Carte con personaggi Nato in Guerra"
  },
  Task_74731_Desc = {
    Text = "Gioca 1175 Carte con personaggi Malphas"
  },
  Task_74732_Desc = {
    Text = "Gioca 1975 Carte con personaggi Luminis"
  },
  Task_74733_Desc = {
    Text = "Gioca 275 Carte con personaggi Nato in Guerra"
  },
  Task_74734_Desc = {
    Text = "Gioca 1425 Carte con personaggi Luminis"
  },
  Task_74735_Desc = {
    Text = "Gioca 1900 Carte con personaggi Guardiano"
  },
  Task_74736_Desc = {
    Text = "Gioca 1600 Carte con personaggi Benedizione"
  },
  Task_74737_Desc = {
    Text = "Gioca 600 Carte con personaggi Malphas"
  },
  Task_74738_Desc = {
    Text = "Gioca 1050 Carte con personaggi Guardiano"
  },
  Task_74739_Desc = {
    Text = "Gioca 1400 Carte con personaggi Malphas"
  },
  Task_74740_Desc = {
    Text = "Gioca 200 Carte con personaggi Benedizione"
  },
  Task_74741_Desc = {
    Text = "Gioca 500 Carte con personaggi Benedizione"
  },
  Task_74742_Desc = {
    Text = "Gioca 1225 Carte con personaggi Guardiano"
  },
  Task_74743_Desc = {
    Text = "Gioca 525 Carte con personaggi Nato in Guerra"
  },
  Task_74744_Desc = {
    Text = "Gioca 400 Carte con personaggi Malphas"
  },
  Task_74745_Desc = {
    Text = "Gioca 1400 Carte con personaggi Benedizione"
  },
  Task_74746_Desc = {
    Text = "Gioca 425 Carte con personaggi Guardiano"
  },
  Task_74747_Desc = {
    Text = "Gioca 475 Carte con personaggi Nato in Guerra"
  },
  Task_74748_Desc = {
    Text = "Gioca 475 Carte con personaggi Malphas"
  },
  Task_74749_Desc = {
    Text = "Gioca 1475 Carte con personaggi Benedizione"
  },
  Task_74750_Desc = {
    Text = "Gioca 300 Carte con personaggi Nato in Guerra"
  },
  Task_74751_Desc = {
    Text = "Gioca 1575 Carte con personaggi Luminis"
  },
  Task_74752_Desc = {
    Text = "Gioca 1675 Carte con personaggi Guardiano"
  },
  Task_74753_Desc = {
    Text = "Gioca 975 Carte con personaggi Guardiano"
  },
  Task_74754_Desc = {
    Text = "Gioca 1250 Carte con personaggi Nato in Guerra"
  },
  Task_74755_Desc = {
    Text = "Gioca 850 Carte con personaggi Luminis"
  },
  Task_74756_Desc = {
    Text = "Gioca 1200 Carte con personaggi Benedizione"
  },
  Task_74757_Desc = {
    Text = "Gioca 1650 Carte con personaggi Malphas"
  },
  Task_74758_Desc = {
    Text = "Gioca 200 Carte con personaggi Malphas"
  },
  Task_74759_Desc = {
    Text = "Gioca 1950 Carte con personaggi Benedizione"
  },
  Task_74760_Desc = {
    Text = "Gioca 950 Carte con personaggi Malphas"
  },
  Task_74761_Desc = {
    Text = "Gioca 450 Carte con personaggi Benedizione"
  },
  Task_74762_Desc = {
    Text = "Gioca 1400 Carte con personaggi Luminis"
  },
  Task_74763_Desc = {
    Text = "Gioca 325 Carte con personaggi Nato in Guerra"
  },
  Task_74764_Desc = {
    Text = "Gioca 925 Carte con personaggi Nato in Guerra"
  },
  Task_74765_Desc = {
    Text = "Gioca 1825 Carte con personaggi Malphas"
  },
  Task_74766_Desc = {
    Text = "Gioca 300 Carte con personaggi Malphas"
  },
  Task_74767_Desc = {
    Text = "Gioca 1300 Carte con personaggi Benedizione"
  },
  Task_74768_Desc = {
    Text = "Gioca 425 Carte con personaggi Nato in Guerra"
  },
  Task_74769_Desc = {
    Text = "Gioca 825 Carte con personaggi Guardiano"
  },
  Task_75738_Desc = {
    Text = "Completa \"Enigma Senza Testa\" a qualsiasi difficoltà"
  },
  Task_75739_Desc = {
    Text = "Completa \"Verso il Mare di Cenere\" a qualsiasi difficoltà"
  },
  Task_75740_Desc = {
    Text = "Completa \"Terrore della palude\" a qualsiasi difficoltà"
  },
  Task_75741_Desc = {
    Text = "Completa \"Caccia nella Notte Piovosa\" a qualsiasi difficoltà"
  },
  Task_75742_Desc = {
    Text = "Completa \"Lei e Quello\" a qualsiasi difficoltà"
  },
  Task_76237_Desc = {
    Text = "Completa il Capitolo Astrale 1-5 in Modalità Difficile"
  },
  Task_76238_Desc = {
    Text = "Completamento Capitolo Finale: \"Fine di un Lungo Sogno\""
  },
  Task_76239_Desc = {
    Text = "Completa il Capitolo Astrale 1-6"
  },
  Task_76240_Desc = {
    Text = "Completamento Capitolo Finale, Livello 9-3 in difficoltà Difficile"
  },
  Task_76241_Desc = {
    Text = "Completa il Capitolo Finale: \"Fine di un Lungo Sogno\" in difficoltà ardua"
  },
  Task_76242_Desc = {
    Text = "Completamento Capitolo Finale: \"Fine di un Lungo Sogno\""
  },
  Task_76243_Desc = {
    Text = "Completa il Capitolo Astrale Capitolo 1 \"Ritorno alla Grande Nebbia\""
  },
  Task_76244_Desc = {
    Text = "Completa il Capitolo Astrale Capitolo 1 \"Ritorno alla Grande Nebbia\""
  },
  Task_76245_Desc = {
    Text = "Completamento Capitolo Finale, Livello 9-4"
  },
  Task_76246_Desc = {
    Text = "Completa il Capitolo Astrale 1-6"
  },
  Task_76247_Desc = {
    Text = "Completa il Capitolo Astrale Capitolo 1 \"Ritorno alla Grande Nebbia\""
  },
  Task_76248_Desc = {
    Text = "Completa il Capitolo Astrale 1-5 in Modalità Difficile"
  },
  Task_76249_Desc = {
    Text = "Completa il Capitolo Finale: \"Fine di un Lungo Sogno\" in difficoltà ardua"
  },
  Task_76250_Desc = {
    Text = "Completamento Capitolo Finale, Livello 9-3 in difficoltà Difficile"
  },
  Task_76251_Desc = {
    Text = "Completamento Capitolo Finale, Livello 9-4"
  },
  Task_76252_Desc = {
    Text = "Completa il Capitolo Astrale Capitolo 1 \"Ritorno alla Grande Nebbia\""
  },
  Task_76339_Desc = {
    Text = "Completa \"Verso il Mare di Cenere\" a qualsiasi difficoltà"
  },
  Task_76340_Desc = {
    Text = "Bottega della Strega: Follia"
  },
  Task_76341_Desc = {
    Text = "Completa \"Caccia nella Notte Piovosa\" a Difficoltà Follia"
  },
  Task_76342_Desc = {
    Text = "Completa \"Terrore della palude\" a Difficoltà Follia"
  },
  Task_76343_Desc = {
    Text = "Completa \"Lei e Quello\" a qualsiasi difficoltà"
  },
  Task_76344_Desc = {
    Text = "Forziere della Strega"
  },
  Task_76345_Desc = {
    Text = "Scambia 300 oggetti presso \"Segreti splendenti\""
  },
  Task_76346_Desc = {
    Text = "Scambia 150 oggetti presso \"Segreti splendenti\""
  },
  Task_76347_Desc = {
    Text = "Completa \"Enigma Senza Testa\" a Difficoltà Follia"
  },
  Task_76348_Desc = {
    Text = "Completa \"Caccia nella Notte Piovosa\" a qualsiasi difficoltà"
  },
  Task_76349_Desc = {
    Text = "Completa \"Lei e Quello\" a Difficoltà Follia"
  },
  Task_76350_Desc = {
    Text = "Completa \"Verso il Mare di Cenere\" a Difficoltà Follia"
  },
  Task_76351_Desc = {
    Text = "Scambia 150 oggetti in \"Curiosità preziose\""
  },
  Task_76352_Desc = {
    Text = "Completa il Registro Operazioni Speciali \"Fantasma della Città Piovosa\""
  },
  Task_76353_Desc = {
    Text = "Completa tutte le missioni in \"Bottega della Strega: Completato\""
  },
  Task_76354_Desc = {
    Text = "Scambia 300 oggetti in \"Curiosità preziose\""
  },
  Task_76355_Desc = {
    Text = "Completa \"Terrore della palude\" a qualsiasi difficoltà"
  },
  Task_76356_Desc = {
    Text = "Scambia 300 oggetti presso \"Tesori Scacciapensieri\""
  },
  Task_76357_Desc = {
    Text = "Scambia 150 oggetti presso \"Tesori Scacciapensieri\""
  },
  Task_76358_Desc = {
    Text = "Bottega della Strega: Clear"
  },
  Task_76359_Desc = {
    Text = "Completa \"Enigma Senza Testa\" a qualsiasi difficoltà"
  },
  Task_77674_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_77674_Name = {
    Text = "10 vittorie"
  },
  Task_77675_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_77675_Name = {Text = "1 vittoria"},
  Task_77676_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_77676_Name = {Text = "3 vittorie"},
  Task_77677_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_77677_Name = {Text = "6 vittorie"},
  Task_78106_Desc = {
    Text = "Usa \"Ramona: Timeworn\" per ottenere 6 vittorie"
  },
  Task_78107_Desc = {
    Text = "Usa \"Lo Sguardo di Isarawu\" per ottenere 6 vittorie"
  },
  Task_78108_Desc = {
    Text = "Usa \"Volontà Indomita\" per ottenere 6 vittorie"
  },
  Task_78109_Desc = {
    Text = "Ottieni 10 vittorie con \"Erica\""
  },
  Task_78112_Desc = {
    Text = "Ottieni 6 vittorie con \"Lily\""
  },
  Task_78113_Desc = {
    Text = "Ottieni 6 vittorie usando \"Visione di Mezza Estate\""
  },
  Task_78114_Desc = {
    Text = "Ottieni 6 vittorie usando \"Tutto di Lei\""
  },
  Task_78115_Desc = {
    Text = "Ottieni 10 vittorie con \"Helot: Catena\""
  },
  Task_78116_Desc = {
    Text = "Ottieni 10 vittorie con \"Ryker\""
  },
  Task_78117_Desc = {
    Text = "Usa \"Ramona\" per ottenere 10 vittorie"
  },
  Task_78118_Desc = {
    Text = "Ottieni 6 vittorie con \"Nymphaea\""
  },
  Task_78119_Desc = {
    Text = "Usa \"In Nome della Rosa\" per ottenere 6 vittorie"
  },
  Task_78120_Desc = {
    Text = "Ottieni 6 vittorie con \"Agrippa\""
  },
  Task_78122_Desc = {
    Text = "Ottieni 6 vittorie con \"Miryam\""
  },
  Task_78123_Desc = {
    Text = "Ottieni 6 vittorie con \"Liz\""
  },
  Task_78124_Desc = {
    Text = "Ottieni 6 vittorie usando \"Esilio\""
  },
  Task_78125_Desc = {
    Text = "Ottieni 6 vittorie usando \"Favore\""
  },
  Task_78126_Desc = {
    Text = "Usa \"Uomo nello specchio\" per ottenere 6 vittorie"
  },
  Task_78127_Desc = {
    Text = "Usa \"Catene Infrante\" per ottenere 6 vittorie"
  },
  Task_78128_Desc = {
    Text = "Usa \"Sentiero Abbandonato\" per ottenere 6 vittorie"
  },
  Task_78129_Desc = {
    Text = "Ottieni 6 vittorie con \"Tintura\""
  },
  Task_78130_Desc = {
    Text = "Usa \"Momento della Riunione\" per ottenere 6 vittorie"
  },
  Task_78131_Desc = {
    Text = "Ottieni 6 vittorie con \"Pandia\""
  },
  Task_78132_Desc = {
    Text = "Ottieni 10 vittorie con \"Salvador\""
  },
  Task_78133_Desc = {
    Text = "Ottieni 6 vittorie usando \"Sogno del mare\""
  },
  Task_78134_Desc = {
    Text = "Ottieni 6 vittorie usando \"Portale della Verità\""
  },
  Task_78135_Desc = {
    Text = "Ottieni 6 vittorie usando \"Frenesia\""
  },
  Task_78137_Desc = {
    Text = "Ottieni 6 vittorie usando \"Pinna del Pianto\""
  },
  Task_78138_Desc = {
    Text = "Ottieni 10 vittorie con \"Helot\""
  },
  Task_78139_Desc = {
    Text = "Risvegliatore"
  },
  Task_78140_Desc = {
    Text = "Ottieni 6 vittorie con \"24\""
  },
  Task_78141_Desc = {
    Text = "Ottieni 6 vittorie con \"Casiah\""
  },
  Task_78142_Desc = {
    Text = "Ottieni 6 vittorie con \"Tawil\""
  },
  Task_78143_Desc = {
    Text = "Ottieni 6 vittorie con \"Golia\""
  },
  Task_78144_Desc = {
    Text = "Ottieni 10 vittorie con \"24\""
  },
  Task_78145_Desc = {
    Text = "Usa \"Tavoletta delle Scritture Divine\" per ottenere 6 vittorie"
  },
  Task_78146_Desc = {
    Text = "Ottieni 6 vittorie usando \"Requiem Eterno\""
  },
  Task_78147_Desc = {
    Text = "Ottieni 6 vittorie usando \"Punizione\""
  },
  Task_78148_Desc = {
    Text = "Ottieni 6 vittorie usando \"Alba del Miracolo\""
  },
  Task_78149_Desc = {
    Text = "Ottieni 6 vittorie usando \"L'Ultimo Verso\""
  },
  Task_78150_Desc = {
    Text = "Ottieni 6 vittorie usando \"Marionetta dell'Oblio\""
  },
  Task_78151_Desc = {
    Text = "Usa \"Banchetto Silenzioso\" per ottenere 6 vittorie"
  },
  Task_78152_Desc = {
    Text = "Ottieni 6 vittorie usando \"Potere dei devoti\""
  },
  Task_78153_Desc = {
    Text = "Ottieni 10 vittorie con \"Tulu\""
  },
  Task_78154_Desc = {
    Text = "Ottieni 6 vittorie usando \"Determinazione del Merluzzo Argenteo\""
  },
  Task_78155_Desc = {
    Text = "Ottieni 6 vittorie usando \"Bramosia\""
  },
  Task_78159_Desc = {
    Text = "Ottieni 6 vittorie usando \"Epifania\""
  },
  Task_78160_Desc = {
    Text = "Usa \"Verità Dietro la Nebbia Grigia\" per ottenere 6 vittorie"
  },
  Task_78161_Desc = {
    Text = "Usa \"Festino di Sangue\" per ottenere 6 vittorie"
  },
  Task_78162_Desc = {
    Text = "Ottieni 6 vittorie con \"Winkle\""
  },
  Task_78163_Desc = {
    Text = "Ottieni 6 vittorie usando \"Milioni di sguardi amorevoli\""
  },
  Task_78164_Desc = {
    Text = "Ottieni 6 vittorie usando \"Sussurro\""
  },
  Task_78166_Desc = {
    Text = "Ottieni 6 vittorie con \"Doll\""
  },
  Task_78168_Desc = {
    Text = "Ottieni 10 vittorie con \"Agrippa\""
  },
  Task_78169_Desc = {
    Text = "Ottieni 10 vittorie con \"Lotan\""
  },
  Task_78170_Desc = {
    Text = "Ottieni 10 vittorie con \"Golia\""
  },
  Task_78171_Desc = {
    Text = "Usa \"Annegare nel Cremisi\" per ottenere 6 vittorie"
  },
  Task_78172_Desc = {
    Text = "Ottieni 10 vittorie con \"Pandia\""
  },
  Task_78173_Desc = {
    Text = "Usa \"La Favola del Divoratore\" per ottenere 6 vittorie"
  },
  Task_78174_Desc = {
    Text = "Ottieni 6 vittorie usando \"Roulette del Destino\""
  },
  Task_78175_Desc = {
    Text = "Ottieni 6 vittorie usando \"Recidere e Sfregiare\""
  },
  Task_78176_Desc = {
    Text = "Ottieni 6 vittorie usando \"Inno al Sovrano\""
  },
  Task_78177_Desc = {
    Text = "Usa \"Doll: Inferno\" per ottenere 10 vittorie"
  },
  Task_78178_Desc = {
    Text = "Ottieni 6 vittorie con \"Leigh\""
  },
  Task_78179_Desc = {
    Text = "Ruota del destino"
  },
  Task_78180_Desc = {
    Text = "Ottieni 6 vittorie con \"Helot\""
  },
  Task_78181_Desc = {
    Text = "Usa \"Requiem dell'Inverno\" per ottenere 6 vittorie"
  },
  Task_78182_Desc = {
    Text = "Ottieni 6 vittorie usando \"Regno del Gigante\""
  },
  Task_78183_Desc = {
    Text = "Ottieni 10 vittorie con \"Daffodil\""
  },
  Task_78184_Desc = {
    Text = "Ottieni 6 vittorie usando \"Vela della Provvidenza\""
  },
  Task_78185_Desc = {
    Text = "Ottieni 6 vittorie con \"Ryker\""
  },
  Task_78186_Desc = {
    Text = "Ottieni 6 vittorie con \"Faint\""
  },
  Task_78187_Desc = {
    Text = "Usa \"Mano dell'Oblio\" per ottenere 6 vittorie"
  },
  Task_78188_Desc = {
    Text = "Ottieni 6 vittorie con \"Thais\""
  },
  Task_78189_Desc = {
    Text = "Ottieni 10 vittorie con \"Nymphaea\""
  },
  Task_78190_Desc = {
    Text = "Ottieni 6 vittorie con \"Wanda\""
  },
  Task_78192_Desc = {
    Text = "Ottieni 6 vittorie con \"Nautila\""
  },
  Task_78193_Desc = {
    Text = "Ottieni 6 vittorie con \"Aigis\""
  },
  Task_78194_Desc = {
    Text = "Ottieni 6 vittorie usando \"Fattore incalcolabile\""
  },
  Task_78196_Desc = {
    Text = "Ottieni 6 vittorie usando \"Editto della Regina\""
  },
  Task_78197_Desc = {
    Text = "Ottieni 6 vittorie con \"Aurita\""
  },
  Task_78198_Desc = {
    Text = "Usa \"Ramona: Timeworn\" per ottenere 10 vittorie"
  },
  Task_78199_Desc = {
    Text = "Ottieni 6 vittorie usando \"Celato nella Notte\""
  },
  Task_78200_Desc = {
    Text = "Ottieni 6 vittorie con \"Helot: Catena\""
  },
  Task_78201_Desc = {
    Text = "Ottieni 6 vittorie usando \"Grazia Attraverso il Dolore\""
  },
  Task_78202_Desc = {
    Text = "Ottieni 6 vittorie usando \"Lama del Titano\""
  },
  Task_78203_Desc = {
    Text = "Ottieni 10 vittorie con \"Alva\""
  },
  Task_78204_Desc = {
    Text = "Usa \"Punto critico\" per ottenere 6 vittorie"
  },
  Task_78205_Desc = {
    Text = "Ottieni 6 vittorie usando \"Morte della Sig.ra Coral\""
  },
  Task_78206_Desc = {
    Text = "Ottieni 6 vittorie usando \"Il Seme Solitario\""
  },
  Task_78208_Desc = {
    Text = "Usa \"Ninnananna Divorata\" per ottenere 6 vittorie"
  },
  Task_78209_Desc = {
    Text = "Usa \"Al Mio Caro Amico\" per ottenere 6 vittorie"
  },
  Task_78210_Desc = {
    Text = "Ottieni 6 vittorie usando \"Concentrazione Elevata\""
  },
  Task_78212_Desc = {
    Text = "Usa \"Sindrome della Memoria\" per ottenere 6 vittorie"
  },
  Task_78213_Desc = {
    Text = "Ottieni 6 vittorie con \"Daffodil\""
  },
  Task_78214_Desc = {
    Text = "Ottieni 6 vittorie usando \"Quando la Neve si Scioglie\""
  },
  Task_78216_Desc = {
    Text = "Ottieni 6 vittorie usando \"Speranza\""
  },
  Task_78217_Desc = {
    Text = "Usa \"Crepuscolo e Alba\" per ottenere 6 vittorie"
  },
  Task_78218_Desc = {
    Text = "Ottieni 10 vittorie con \"Murphy\""
  },
  Task_78219_Desc = {
    Text = "Ottieni 6 vittorie usando \"Scambio Ineguale\""
  },
  Task_78220_Desc = {
    Text = "Ottieni 6 vittorie usando \"Il Tesoro di Aurita\""
  },
  Task_78221_Desc = {
    Text = "Ottieni 10 vittorie con \"Aigis\""
  },
  Task_78223_Desc = {
    Text = "Usa \"Bastone del Nobile\" per ottenere 6 vittorie"
  },
  Task_78224_Desc = {
    Text = "Usa \"Alla deriva nel Desiderio\" per ottenere 6 vittorie"
  },
  Task_78225_Desc = {
    Text = "Ottieni 6 vittorie con \"Uvhash\""
  },
  Task_78226_Desc = {
    Text = "Ottieni 10 vittorie con \"Miryam\""
  },
  Task_78227_Desc = {
    Text = "Usa \"Ramona\" per ottenere 6 vittorie"
  },
  Task_78228_Desc = {
    Text = "Usa \"Voto del Cavaliere\" per ottenere 6 vittorie"
  },
  Task_78229_Desc = {
    Text = "Usa \"Doll: Inferno\" per ottenere 6 vittorie"
  },
  Task_78230_Desc = {
    Text = "Ottieni 6 vittorie usando \"Rarità Preziosa\""
  },
  Task_78231_Desc = {
    Text = "Ottieni 6 vittorie usando \"Zaino dell'Avventuriero\""
  },
  Task_78232_Desc = {
    Text = "Ottieni 6 vittorie usando \"Benedizione\""
  },
  Task_78233_Desc = {
    Text = "Ottieni 6 vittorie con \"Alva\""
  },
  Task_78234_Desc = {
    Text = "Ottieni 6 vittorie usando \"L'ultimo voto\""
  },
  Task_78235_Desc = {
    Text = "Ottieni 6 vittorie con \"Horla\""
  },
  Task_78236_Desc = {
    Text = "Ottieni 6 vittorie usando \"Nel cuore del diluvio\""
  },
  Task_78237_Desc = {
    Text = "Ottieni 10 vittorie con \"Doll\""
  },
  Task_78238_Desc = {
    Text = "Usa \"Oltre la Morte\" per ottenere 6 vittorie"
  },
  Task_78239_Desc = {
    Text = "Usa \"Bestia Celeste\" per ottenere 6 vittorie"
  },
  Task_78240_Desc = {
    Text = "Usa \"Sangue e Sabbia Ruggenti\" per ottenere 6 vittorie"
  },
  Task_78241_Desc = {
    Text = "Ottieni 6 vittorie usando \"Sguardo sul Lago\""
  },
  Task_78242_Desc = {
    Text = "Ottieni 10 vittorie con \"Jenkin\""
  },
  Task_78243_Desc = {Text = "Posse"},
  Task_78244_Desc = {
    Text = "Usa \"Discendente Pallido\" per ottenere 6 vittorie"
  },
  Task_78245_Desc = {
    Text = "Ottieni 6 vittorie con \"Caecus\""
  },
  Task_78246_Desc = {
    Text = "Ottieni 6 vittorie con \"Hameln\""
  },
  Task_78247_Desc = {
    Text = "Ottieni 10 vittorie con \"Horla\""
  },
  Task_78248_Desc = {
    Text = "Usa \"Fusione del Nucleo\" per ottenere 6 vittorie"
  },
  Task_78249_Desc = {
    Text = "Ottieni 6 vittorie usando \"Delirium\""
  },
  Task_78250_Desc = {
    Text = "Usa \"Nascita Celata\" per ottenere 6 vittorie"
  },
  Task_78251_Desc = {
    Text = "Ottieni 10 vittorie con \"Aurita\""
  },
  Task_78252_Desc = {
    Text = "Ottieni 6 vittorie con \"Murphy\""
  },
  Task_78253_Desc = {
    Text = "Usa \"Cuore d'Argento Puro\" per ottenere 6 vittorie"
  },
  Task_78254_Desc = {
    Text = "Ottieni 6 vittorie con \"Tulu\""
  },
  Task_78255_Desc = {
    Text = "Ottieni 6 vittorie con \"Sanga\""
  },
  Task_78256_Desc = {
    Text = "Ottieni 6 vittorie con \"Jenkin\""
  },
  Task_78257_Desc = {
    Text = "Ottieni 10 vittorie con \"Winkle\""
  },
  Task_78258_Desc = {
    Text = "Ottieni 10 vittorie con \"Wanda\""
  },
  Task_78261_Desc = {
    Text = "Usa \"Orologio del tempo riavvolto\" per ottenere 6 vittorie"
  },
  Task_78262_Desc = {
    Text = "Ottieni 6 vittorie usando \"Vittoria delle Rose\""
  },
  Task_78263_Desc = {
    Text = "Usa \"Ogier\" per ottenere 10 vittorie"
  },
  Task_78264_Desc = {
    Text = "Ottieni 6 vittorie con \"Faros\""
  },
  Task_78265_Desc = {
    Text = "Ottieni 10 vittorie con \"Faint\""
  },
  Task_78266_Desc = {
    Text = "Ottieni 10 vittorie con \"Hameln\""
  },
  Task_78267_Desc = {
    Text = "Usa \"Nutrimento Misericordioso\" per ottenere 6 vittorie"
  },
  Task_78269_Desc = {
    Text = "Ottieni 6 vittorie usando \"Analisi della Morte\""
  },
  Task_78270_Desc = {
    Text = "Ottieni 6 vittorie usando \"Maturità\""
  },
  Task_78272_Desc = {
    Text = "Usa \"I dati sono vita\" per ottenere 6 vittorie"
  },
  Task_78273_Desc = {
    Text = "Usa \"Abbraccio Corrosivo\" per ottenere 6 vittorie"
  },
  Task_78274_Desc = {
    Text = "Ottieni 10 vittorie con \"Sanga\""
  },
  Task_78275_Desc = {
    Text = "Ottieni 6 vittorie usando \"Sonno Sotto il Ghiacciaio\""
  },
  Task_78276_Desc = {
    Text = "Ottieni 6 vittorie con \"Erica\""
  },
  Task_78277_Desc = {
    Text = "Ottieni 6 vittorie usando \"Ruota Invisibile\""
  },
  Task_78278_Desc = {
    Text = "Usa \"Magia del 35mm\" per ottenere 6 vittorie"
  },
  Task_78279_Desc = {
    Text = "Ottieni 6 vittorie con \"Voci nella Tua Testa\""
  },
  Task_78280_Desc = {
    Text = "Ottieni 6 vittorie usando \"Ora della Fortuna\""
  },
  Task_78281_Desc = {
    Text = "Ottieni 10 vittorie con \"Karen\""
  },
  Task_78282_Desc = {
    Text = "Ottieni 10 vittorie con \"Tawil\""
  },
  Task_78283_Desc = {
    Text = "Ottieni 10 vittorie con \"Uvhash\""
  },
  Task_78284_Desc = {
    Text = "Ottieni 10 vittorie con \"Liz\""
  },
  Task_78286_Desc = {
    Text = "Usa \"Barriera Mentale\" per ottenere 6 vittorie"
  },
  Task_78287_Desc = {
    Text = "Ottieni 10 vittorie con \"Casiah\""
  },
  Task_78288_Desc = {
    Text = "Usa \"Divoramento Aberrante\" per ottenere 6 vittorie"
  },
  Task_78289_Desc = {
    Text = "Ottieni 6 vittorie usando \"Esecuzione Senza Fine\""
  },
  Task_78290_Desc = {
    Text = "Ottieni 6 vittorie usando \"Vincolo Maledetto\""
  },
  Task_78291_Desc = {
    Text = "Ottieni 10 vittorie con \"Celeste\""
  },
  Task_78292_Desc = {
    Text = "Ottieni 6 vittorie usando \"La Terra dell'Inesistenza\""
  },
  Task_78294_Desc = {
    Text = "Ottieni 10 vittorie con \"Tintura\""
  },
  Task_78295_Desc = {
    Text = "Ottieni 10 vittorie con \"Faros\""
  },
  Task_78296_Desc = {
    Text = "Ottieni 10 vittorie con \"Lily\""
  },
  Task_78297_Desc = {
    Text = "Ottieni 6 vittorie usando \"Eternità Effimera\""
  },
  Task_78298_Desc = {
    Text = "Ottieni 6 vittorie usando \"Vitalità\""
  },
  Task_78299_Desc = {
    Text = "Ottieni 10 vittorie con \"Nautila\""
  },
  Task_78301_Desc = {
    Text = "Ottieni 6 vittorie con \"Salvador\""
  },
  Task_78303_Desc = {
    Text = "Ottieni 6 vittorie usando \"Suzione\""
  },
  Task_78304_Desc = {
    Text = "Ottieni 10 vittorie con \"Caecus\""
  },
  Task_78305_Desc = {
    Text = "Usa \"Ogier\" per ottenere 6 vittorie"
  },
  Task_78306_Desc = {
    Text = "Ottieni 6 vittorie usando \"Gravità del Dovere\""
  },
  Task_78307_Desc = {
    Text = "Ottieni 10 vittorie con \"Sorel\""
  },
  Task_78308_Desc = {
    Text = "Ottieni 6 vittorie usando \"Spettacolo di magia felice\""
  },
  Task_78309_Desc = {
    Text = "Ottieni 6 vittorie usando \"Intuizione\""
  },
  Task_78310_Desc = {
    Text = "Ottieni 6 vittorie con \"Celeste\""
  },
  Task_78313_Desc = {
    Text = "Ottieni 6 vittorie usando \"Emersione\""
  },
  Task_78314_Desc = {
    Text = "Ottieni 10 vittorie con \"Leigh\""
  },
  Task_78315_Desc = {
    Text = "Ottieni 6 vittorie usando \"Canto del Prigioniero\""
  },
  Task_78316_Desc = {
    Text = "Ottieni 6 vittorie con \"Sorel\""
  },
  Task_78317_Desc = {
    Text = "Ottieni 6 vittorie con \"Karen\""
  },
  Task_78318_Desc = {
    Text = "Gioca una carta"
  },
  Task_78319_Desc = {
    Text = "Usa \"Lotan\" per ottenere 6 vittorie"
  },
  Task_78320_Desc = {
    Text = "Usa \"Dono della Decomposizione\" per ottenere 6 vittorie"
  },
  Task_78321_Desc = {
    Text = "Ottieni 10 vittorie con \"Thais\""
  },
  Task_78322_Desc = {
    Text = "Ottieni 6 vittorie usando \"Spirale della Memoria\""
  },
  Task_78326_Desc = {
    Text = "L'Affinità di Kathigu-Ra raggiunge il Livello 10"
  },
  Task_78327_Desc = {
    Text = "L'Affinità di Aforgomon raggiunge il Livello 10"
  },
  Task_78328_Desc = {
    Text = "L'Affinità di Pollux raggiunge il Livello 10"
  },
  Task_78329_Desc = {
    Text = "L'Affinità di Avvoltoio raggiunge il Livello 10"
  },
  Task_78332_Desc = {
    Text = "L'Affinità di Rhan-Tegoth raggiunge il Livello 10"
  },
  Task_78333_Desc = {
    Text = "L'Affinità di Caraboo raggiunge il Livello 10"
  },
  Task_78334_Desc = {
    Text = "L'Affinità di Corposant raggiunge il livello 10"
  },
  Task_78336_Desc = {
    Text = "L'Affinità di Arachne raggiunge il Livello 10"
  },
  Task_78338_Desc = {
    Text = "L'Affinità di Nephren-Ka raggiunge il Livello 10"
  },
  Task_78339_Desc = {
    Text = "L'Affinità di Shantak raggiunge il Livello 10"
  },
  Task_78340_Desc = {
    Text = "L'Affinità di Pickman raggiunge il Livello 10"
  },
  Task_78341_Desc = {
    Text = "L'Affinità di Clementine raggiunge il Livello 10"
  },
  Task_78342_Desc = {
    Text = "L'Affinità di Castor raggiunge il Livello 10"
  },
  Task_78366_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78367_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78368_Desc = {
    Text = "Illuminare 6 all'acquisizione di Uccello Shattak"
  },
  Task_78368_Name = {
    Text = "Illuminare 6 all'acquisizione di Uccello Shattak"
  },
  Task_78368_UnlockCondDesc = {
    Text = "Evento @Risveglio Uccello Chatarak Pacco Dono Illuminare 2 Evento"
  },
  Task_78369_Desc = {
    Text = "Ottenuta Illuminazione 6 per Kathigu-Ra"
  },
  Task_78369_Name = {
    Text = "Ottenuta Illuminazione 6 per Kathigu-Ra"
  },
  Task_78369_UnlockCondDesc = {
    Text = "Evento @Pacchetto Dono Illuminazione 2 Risvegliatore Kathigu-Ra Evento"
  },
  Task_78370_Desc = {
    Text = "Illuminare 2 all'acquisizione di Uccello Shattak"
  },
  Task_78370_Name = {
    Text = "Illuminare 2 all'acquisizione di Uccello Shattak"
  },
  Task_78370_UnlockCondDesc = {
    Text = "Evento @Risveglio Uccello Chatarak Pacco Dono Illuminare 2 Evento"
  },
  Task_78371_Desc = {
    Text = "Ricevuta Illuminazione 2 per Kathigu-Ra"
  },
  Task_78371_Name = {
    Text = "Ricevuta Illuminazione 2 per Kathigu-Ra"
  },
  Task_78371_UnlockCondDesc = {
    Text = "Evento @Pacchetto Dono Illuminazione 2 Risvegliatore Kathigu-Ra Evento"
  },
  Task_78372_Desc = {
    Text = "Illuminare 2 all'acquisizione di Pollux"
  },
  Task_78372_Name = {
    Text = "Illuminare 2 all'acquisizione di Pollux"
  },
  Task_78372_UnlockCondDesc = {
    Text = "Evento @Risveglio Polyclus Pacco Dono Illuminare 2 Evento"
  },
  Task_78373_Desc = {
    Text = "Illuminare 6 all'acquisizione di Pollux"
  },
  Task_78373_Name = {
    Text = "Illuminare 6 all'acquisizione di Pollux"
  },
  Task_78373_UnlockCondDesc = {
    Text = "Evento @Risveglio Polyclus Pacco Dono Illuminare 2 Evento"
  },
  Task_78375_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78379_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78380_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78382_Desc = {
    Text = "Ottenuto Arachne a Illuminare 6"
  },
  Task_78382_Name = {
    Text = "Ottenuto Arachne a Illuminare 6"
  },
  Task_78382_UnlockCondDesc = {
    Text = "Evento @Risveglio Arachne Pacco Dono Illuminare 2 Evento"
  },
  Task_78383_Desc = {
    Text = "Ottenuta Arachne a Illuminare 2"
  },
  Task_78383_Name = {
    Text = "Ottenuta Arachne a Illuminare 2"
  },
  Task_78383_UnlockCondDesc = {
    Text = "Evento @Risveglio Arachne Pacco Dono Illuminare 2 Evento"
  },
  Task_78384_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78385_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78390_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78391_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78394_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78395_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78396_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78397_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78400_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78401_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78402_Desc = {
    Text = "Ottenuto Illuminare 6 all'acquisizione di Pikema"
  },
  Task_78402_Name = {
    Text = "Ottenuto Illuminare 6 all'acquisizione di Pikema"
  },
  Task_78402_UnlockCondDesc = {
    Text = "Evento @Pacchetto Dono Illuminazione 2 Risvegliatore Pikeman Evento"
  },
  Task_78403_Desc = {
    Text = "Ottenuta Illuminare 2 all'acquisizione di Pikema"
  },
  Task_78403_Name = {
    Text = "Ottenuta Illuminare 2 all'acquisizione di Pikema"
  },
  Task_78403_UnlockCondDesc = {
    Text = "Evento @Pacchetto Dono Illuminazione 2 Risvegliatore Pikeman Evento"
  },
  Task_78404_Desc = {
    Text = "Ricevuta Illuminazione 2 per Castor"
  },
  Task_78404_Name = {
    Text = "Ricevuta Illuminazione 2 per Castor"
  },
  Task_78404_UnlockCondDesc = {
    Text = "Evento @Pacchetto Dono Illuminazione 2 Risvegliatore Castor Evento"
  },
  Task_78405_Desc = {
    Text = "Ottenuta Illuminazione 6 per Castor"
  },
  Task_78405_Name = {
    Text = "Ottenuta Illuminazione 6 per Castor"
  },
  Task_78405_UnlockCondDesc = {
    Text = "Evento @Pacchetto Dono Illuminazione 2 Risvegliatore Castor Evento"
  },
  Task_78409_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78415_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78416_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78418_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78419_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78421_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78423_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78424_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78426_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78429_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78430_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78431_Desc = {
    Text = "Ricevuta Illuminazione 2 per Calab"
  },
  Task_78431_Name = {
    Text = "Ricevuta Illuminazione 2 per Calab"
  },
  Task_78431_UnlockCondDesc = {
    Text = "Evento @Risveglio Kalab Pacchetto Dono Illuminare 2 Evento"
  },
  Task_78432_Desc = {
    Text = "Ottenuta Illuminazione 6 per Calab"
  },
  Task_78432_Name = {
    Text = "Ottenuta Illuminazione 6 per Calab"
  },
  Task_78432_UnlockCondDesc = {
    Text = "Evento @Risveglio Kalab Pacchetto Dono Illuminare 2 Evento"
  },
  Task_78435_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78436_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78437_Desc = {
    Text = "Ricevuta Illuminazione 2 per Avagomont"
  },
  Task_78437_Name = {
    Text = "Ricevuta Illuminazione 2 per Avagomont"
  },
  Task_78437_UnlockCondDesc = {
    Text = "Evento @Risveglio Avragon Pacco Dono Illuminare 2 Evento"
  },
  Task_78438_Desc = {
    Text = "Ricevuta Illuminazione 2 per Clementine"
  },
  Task_78438_Name = {
    Text = "Ricevuta Illuminazione 2 per Clementine"
  },
  Task_78438_UnlockCondDesc = {
    Text = "Evento @Pacchetto Dono Illuminazione 2 Risvegliatore Clementine Evento"
  },
  Task_78440_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78441_Desc = {
    Text = "Ricevuta Illuminazione 6 per Clementine"
  },
  Task_78441_Name = {
    Text = "Ricevuta Illuminazione 6 per Clementine"
  },
  Task_78441_UnlockCondDesc = {
    Text = "Evento @Pacchetto Dono Illuminazione 2 Risvegliatore Clementine Evento"
  },
  Task_78446_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78447_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78449_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78450_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78451_Desc = {
    Text = "Ottenuto Faraone Nero a Illuminare 2"
  },
  Task_78451_Name = {
    Text = "Ottenuto Faraone Nero a Illuminare 2"
  },
  Task_78451_UnlockCondDesc = {
    Text = "Evento @Risveglio Faraone Nero Pacco Dono Illuminare 2 Evento"
  },
  Task_78453_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78458_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78459_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78460_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78466_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78468_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78470_Desc = {
    Text = "Ottenuto Faraone Nero a Illuminare 6"
  },
  Task_78470_Name = {
    Text = "Ottenuto Faraone Nero a Illuminare 6"
  },
  Task_78470_UnlockCondDesc = {
    Text = "Evento @Risveglio Faraone Nero Pacco Dono Illuminare 2 Evento"
  },
  Task_78476_Desc = {
    Text = "Ottenuta Illuminazione 6 per Lantigos"
  },
  Task_78476_Name = {
    Text = "Ottenuta Illuminazione 6 per Lantigos"
  },
  Task_78476_UnlockCondDesc = {
    Text = "Evento @Risveglio Lantigos Pacco Dono Illuminare 2 Evento"
  },
  Task_78477_Desc = {
    Text = "Ricevuta Illuminazione 2 per Lantigos"
  },
  Task_78477_Name = {
    Text = "Ricevuta Illuminazione 2 per Lantigos"
  },
  Task_78477_UnlockCondDesc = {
    Text = "Evento @Risveglio Lantigos Pacco Dono Illuminare 2 Evento"
  },
  Task_78481_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78483_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78484_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78485_Desc = {
    Text = "Ottenuta Illuminare 2 all'acquisizione di Avvoltoio"
  },
  Task_78485_Name = {
    Text = "Ottenuta Illuminare 2 all'acquisizione di Avvoltoio"
  },
  Task_78485_UnlockCondDesc = {
    Text = "Evento @Risveglio Avvoltoio Pacco Dono Illuminare 2 Evento"
  },
  Task_78486_Desc = {
    Text = "Ottenuto Illuminare 6 all'acquisizione di Avvoltoio"
  },
  Task_78486_Name = {
    Text = "Ottenuto Illuminare 6 all'acquisizione di Avvoltoio"
  },
  Task_78486_UnlockCondDesc = {
    Text = "Evento @Risveglio Avvoltoio Pacco Dono Illuminare 2 Evento"
  },
  Task_78487_Desc = {
    Text = "Ottenuta Illuminazione 6 per Avagomont"
  },
  Task_78487_Name = {
    Text = "Ottenuta Illuminazione 6 per Avagomont"
  },
  Task_78487_UnlockCondDesc = {
    Text = "Evento @Risveglio Avragon Pacco Dono Illuminare 2 Evento"
  },
  Task_78488_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78489_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78492_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78493_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78495_Desc = {
    Text = "Illuminare 6 ricevuto per Corposant"
  },
  Task_78495_Name = {
    Text = "Illuminare 6 ricevuto per Corposant"
  },
  Task_78495_UnlockCondDesc = {
    Text = "Evento @Pacchetto Dono Illuminazione 2 Risvegliatore Coper Sanga Evento"
  },
  Task_78496_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78497_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78499_Desc = {
    Text = "Illuminare 2 ricevuto per Corposant"
  },
  Task_78499_Name = {
    Text = "Illuminare 2 ricevuto per Corposant"
  },
  Task_78499_UnlockCondDesc = {
    Text = "Evento @Pacchetto Dono Illuminazione 2 Risvegliatore Coper Sanga Evento"
  },
  Task_78573_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78574_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78576_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78577_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78599_Desc = {
    Text = "Vinci la Battaglia finale entro 13 turni."
  },
  Task_78599_Name = {
    Text = "Vinci la Battaglia finale entro 13 turni."
  },
  Task_78600_Desc = {
    Text = "Vinci la Battaglia finale entro 14 turni"
  },
  Task_78600_Name = {
    Text = "Vinci la Battaglia finale entro 14 turni"
  },
  Task_78718_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Caro per vincere due volte in \"Codice della Memoria\""
  },
  Task_78719_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Caos per vincere due volte in \"Codice della Memoria\""
  },
  Task_78720_Desc = {
    Text = "Usa un qualsiasi Risvegliatore di Aequor per vincere due volte in \"Codice della Memoria\""
  },
  Task_78721_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere due volte in \"Codice della Memoria\""
  },
  Task_78723_Desc = {
    Text = "Canti degli Insettoidi II"
  },
  Task_78724_Desc = {
    Text = "Canti degli Insettoidi I"
  },
  Task_78725_Desc = {
    Text = "Canti degli Insettoidi VII"
  },
  Task_78726_Desc = {
    Text = "Canti degli Insettoidi V"
  },
  Task_78727_Desc = {
    Text = "Canti degli Insettoidi: Libero"
  },
  Task_78728_Desc = {
    Text = "Canti degli Insettoidi VI"
  },
  Task_78729_Desc = {
    Text = "Canti degli Insettoidi III"
  },
  Task_78730_Desc = {
    Text = "Canti degli Insettoidi IV"
  },
  Task_78740_Desc = {
    Text = "Illuminare 6 all'acquisizione di Genesi Maestro del Sonno"
  },
  Task_78740_Name = {
    Text = "Illuminare 6 all'acquisizione di Genesi Maestro del Sonno"
  },
  Task_78740_UnlockCondDesc = {
    Text = "Evento @Risveglio Genesi Signore del Dormiveglia Pacco Dono Illuminare 2 Evento"
  },
  Task_78741_Desc = {
    Text = "L'Affinità di Tulu: Re Divino raggiunge il Livello 10"
  },
  Task_78742_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78743_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78745_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78746_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78748_Desc = {
    Text = "Illuminare 2 all'acquisizione di Maestro del Sonno Genesi"
  },
  Task_78748_Name = {
    Text = "Illuminare 2 all'acquisizione di Maestro del Sonno Genesi"
  },
  Task_78748_UnlockCondDesc = {
    Text = "Evento @Risveglio Genesi Signore del Dormiveglia Pacco Dono Illuminare 2 Evento"
  },
  Task_78763_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78764_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78766_Desc = {
    Text = "Illuminare 2 all'acquisizione di Signora del Mare profondo Genesi"
  },
  Task_78766_Name = {
    Text = "Illuminare 2 all'acquisizione di Signora del Mare profondo Genesi"
  },
  Task_78766_UnlockCondDesc = {
    Text = "Evento @Risveglio Genesi Signora del Mare Profondo Pacco Dono Illuminare 2 Evento"
  },
  Task_78767_Desc = {
    Text = "Illuminare 6 all'acquisizione di Genesi Dama del Mare profondo"
  },
  Task_78767_Name = {
    Text = "Illuminare 6 all'acquisizione di Genesi Dama del Mare profondo"
  },
  Task_78767_UnlockCondDesc = {
    Text = "Evento @Risveglio Genesi Signora del Mare Profondo Pacco Dono Illuminare 2 Evento"
  },
  Task_78768_Desc = {
    Text = "L'Affinità di Murphy: Falsonata raggiunge il Livello 10"
  },
  Task_78769_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_78770_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_79259_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_79259_Name = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_79283_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_79283_Name = {
    Text = "Superamento Perfetto"
  },
  Task_79284_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_79284_Name = {
    Text = "Superamento Perfetto"
  },
  Task_79285_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_79285_Name = {
    Text = "Superamento Perfetto"
  },
  Task_79286_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_79286_Name = {
    Text = "Superamento Perfetto"
  },
  Task_79287_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_79287_Name = {
    Text = "Superamento Perfetto"
  },
  Task_79288_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_79288_Name = {
    Text = "Superamento Perfetto"
  },
  Task_79289_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_79289_Name = {
    Text = "Superamento Perfetto"
  },
  Task_79290_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_79290_Name = {
    Text = "Superamento Perfetto"
  },
  Task_79291_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_79291_Name = {
    Text = "Superamento Perfetto"
  },
  Task_79292_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_79292_Name = {
    Text = "Superamento Perfetto"
  },
  Task_79304_Desc = {
    Text = "Usa \"Incontro in Bianco Puro\" per ottenere 1 vittoria"
  },
  Task_79305_Desc = {
    Text = "Usa \"Tramonto Astrale\" per ottenere 1 vittoria"
  },
  Task_79306_Desc = {
    Text = "Ottieni 1 vittoria usando \"Piaga delle Illusioni\""
  },
  Task_79307_Desc = {
    Text = "Ottieni 6 vittorie usando \"Fouetté\""
  },
  Task_79308_Desc = {
    Text = "Ottieni 1 vittoria usando \"La Saggezza di un Topo\""
  },
  Task_79309_Desc = {
    Text = "Usa \"Incontro in Bianco Puro\" per ottenere 3 vittorie"
  },
  Task_79310_Desc = {
    Text = "Usa \"Bacio d'Addio\" per ottenere 6 vittorie"
  },
  Task_79311_Desc = {
    Text = "Usa \"Tramonto Astrale\" per ottenere 3 vittorie"
  },
  Task_79312_Desc = {
    Text = "Ottieni 3 vittorie usando \"Bastone del Pastore\""
  },
  Task_79313_Desc = {
    Text = "Ottieni 1 vittoria usando \"Funus Aeternum\""
  },
  Task_79314_Desc = {
    Text = "Ottieni 3 vittorie usando \"La Saggezza di un Topo\""
  },
  Task_79315_Desc = {
    Text = "Ottieni 3 vittorie usando \"La Risolutezza delle Montagne\""
  },
  Task_79316_Desc = {
    Text = "Ottieni 3 vittorie usando \"Piccolo Desiderio\""
  },
  Task_79317_Desc = {
    Text = "Usa \"Nascita di un'anima\" per ottenere 1 vittoria"
  },
  Task_79318_Desc = {
    Text = "Usa \"Chiamata del Mare Profondo\" per ottenere 6 vittorie"
  },
  Task_79319_Desc = {
    Text = "Ottieni 6 vittorie usando \"Banchetto della Decomposizione\""
  },
  Task_79320_Desc = {
    Text = "Ottieni 3 vittorie usando \"Benedizione delle Stelle\""
  },
  Task_79321_Desc = {
    Text = "Ottieni 3 vittorie usando \"Banchetto della Decomposizione\""
  },
  Task_79322_Desc = {
    Text = "Ottieni 1 vittoria usando \"La risposta della Porta\""
  },
  Task_79323_Desc = {
    Text = "Ottieni 6 vittorie usando \"Bastone del Pastore\""
  },
  Task_79324_Desc = {
    Text = "Usa \"Chiamata del Mare Profondo\" per ottenere 1 vittoria"
  },
  Task_79325_Desc = {
    Text = "Usa \"Chiamata del Mare Profondo\" per ottenere 3 vittorie"
  },
  Task_79326_Desc = {
    Text = "Ottieni 3 vittorie usando \"Piaga delle Illusioni\""
  },
  Task_79327_Desc = {
    Text = "Ottieni 6 vittorie usando \"Verso di Primavera\""
  },
  Task_79328_Desc = {
    Text = "Ottieni 1 vittoria usando \"Il grido di un'arma\""
  },
  Task_79329_Desc = {
    Text = "Ottieni 3 vittorie usando \"Funus Aeternum\""
  },
  Task_79330_Desc = {
    Text = "Ottieni 1 vittoria usando \"Porta della Taverna\""
  },
  Task_79331_Desc = {
    Text = "Ottieni 3 vittorie usando \"Ossessione Eterna\""
  },
  Task_79332_Desc = {
    Text = "Ottieni 1 vittoria usando \"Piccolo Desiderio\""
  },
  Task_79333_Desc = {
    Text = "Ottieni 6 vittorie usando \"La risposta della Porta\""
  },
  Task_79334_Desc = {
    Text = "Ottieni 6 vittorie usando \"Trono di Pietra Azzurra\""
  },
  Task_79335_Desc = {
    Text = "Ottieni 1 vittoria usando \"Benedizione delle Stelle\""
  },
  Task_79336_Desc = {
    Text = "Ottieni 6 vittorie usando \"La Risolutezza delle Montagne\""
  },
  Task_79337_Desc = {
    Text = "Usa \"Tramonto Astrale\" per ottenere 6 vittorie"
  },
  Task_79338_Desc = {
    Text = "Ottieni 6 vittorie usando \"Primavera a Yakutsk\""
  },
  Task_79339_Desc = {
    Text = "Ottieni 6 vittorie usando \"La Saggezza di un Topo\""
  },
  Task_79340_Desc = {
    Text = "Ottieni 6 vittorie usando \"Gola\""
  },
  Task_79341_Desc = {
    Text = "Ottieni 6 vittorie usando \"Funus Aeternum\""
  },
  Task_79342_Desc = {
    Text = "Ottieni 6 vittorie usando \"Cerimonia del mare\""
  },
  Task_79343_Desc = {
    Text = "Ottieni 1 vittoria usando \"Iniezione protettiva\""
  },
  Task_79344_Desc = {
    Text = "Ottieni 3 vittorie usando \"Iniezione protettiva\""
  },
  Task_79345_Desc = {
    Text = "Ottieni 3 vittorie usando \"Porta della Taverna\""
  },
  Task_79346_Desc = {
    Text = "Ottieni 3 vittorie usando \"Fiori e Poesie d'un Tempo\""
  },
  Task_79347_Desc = {
    Text = "Ottieni 1 vittoria usando \"Fouetté\""
  },
  Task_79348_Desc = {
    Text = "Usa \"Cappello a Tesa Larga della Strega\" per ottenere 6 vittorie"
  },
  Task_79349_Desc = {
    Text = "Usa \"Porta della Retrospezione\" per ottenere 3 vittorie"
  },
  Task_79350_Desc = {
    Text = "Ottieni 6 vittorie usando \"Sinfonia Quarta\""
  },
  Task_79351_Desc = {
    Text = "Ottieni 1 vittoria usando \"Trono di Pietra Azzurra\""
  },
  Task_79352_Desc = {
    Text = "Ottieni 1 vittoria usando \"Sinfonia Quarta\""
  },
  Task_79353_Desc = {
    Text = "Ottieni 6 vittorie usando \"Porta della Taverna\""
  },
  Task_79354_Desc = {
    Text = "Ottieni 6 vittorie usando \"Piaga delle Illusioni\""
  },
  Task_79355_Desc = {
    Text = "Ottieni 6 vittorie usando \"Il grido di un'arma\""
  },
  Task_79356_Desc = {
    Text = "Ottieni 1 vittoria usando \"Cappello a Tesa Larga della Strega\""
  },
  Task_79357_Desc = {
    Text = "Ottieni 3 vittorie usando \"Fouetté\""
  },
  Task_79358_Desc = {
    Text = "Ottieni 1 vittoria usando \"Banchetto della Decomposizione\""
  },
  Task_79359_Desc = {
    Text = "Ottieni 3 vittorie usando \"Trono di Pietra Azzurra\""
  },
  Task_79360_Desc = {
    Text = "Usa \"Bacio d'Addio\" per ottenere 3 vittorie"
  },
  Task_79361_Desc = {
    Text = "Usa \"Nascita di un'anima\" per ottenere 3 vittorie"
  },
  Task_79362_Desc = {
    Text = "Ottieni 1 vittoria usando \"Ossessione Eterna\""
  },
  Task_79363_Desc = {
    Text = "Usa \"Porta della Retrospezione\" per ottenere 1 vittoria"
  },
  Task_79364_Desc = {
    Text = "Usa \"Bacio d'Addio\" per ottenere 1 vittoria"
  },
  Task_79365_Desc = {
    Text = "Ottieni 6 vittorie usando \"Fiori e Poesie d'un Tempo\""
  },
  Task_79366_Desc = {
    Text = "Ottieni 6 vittorie usando \"Benedizione delle Stelle\""
  },
  Task_79367_Desc = {
    Text = "Ottieni 1 vittoria usando \"Verso di Primavera\""
  },
  Task_79368_Desc = {
    Text = "Ottieni 1 vittoria usando \"La Risolutezza delle Montagne\""
  },
  Task_79369_Desc = {
    Text = "Ottieni 3 vittorie usando \"Primavera a Yakutsk\""
  },
  Task_79370_Desc = {
    Text = "Ottieni 6 vittorie usando \"Iniezione protettiva\""
  },
  Task_79371_Desc = {
    Text = "Ottieni 3 vittorie usando \"Cappello a Tesa Larga della Strega\""
  },
  Task_79372_Desc = {
    Text = "Ottieni 3 vittorie usando \"Cerimonia del mare\""
  },
  Task_79373_Desc = {
    Text = "Usa \"Porta della Retrospezione\" per ottenere 6 vittorie"
  },
  Task_79374_Desc = {
    Text = "Usa \"Incontro in Bianco Puro\" per ottenere 6 vittorie"
  },
  Task_79375_Desc = {
    Text = "Ottieni 6 vittorie usando \"Piccolo Desiderio\""
  },
  Task_79376_Desc = {
    Text = "Ottieni 3 vittorie usando \"Gola\""
  },
  Task_79377_Desc = {
    Text = "Ottieni 1 vittoria usando \"Cerimonia del mare\""
  },
  Task_79378_Desc = {
    Text = "Ottieni 3 vittorie usando \"Sinfonia Quarta\""
  },
  Task_79379_Desc = {
    Text = "Ottieni 1 vittoria usando \"Gola\""
  },
  Task_79380_Desc = {
    Text = "Ottieni 3 vittorie usando \"La risposta della Porta\""
  },
  Task_79381_Desc = {
    Text = "Usa \"Fiori e Poesie d'un Tempo\" per ottenere 1 vittoria"
  },
  Task_79382_Desc = {
    Text = "Ottieni 1 vittoria usando \"Bastone del Pastore\""
  },
  Task_79383_Desc = {
    Text = "Ottieni 3 vittorie usando \"Il grido di un'arma\""
  },
  Task_79384_Desc = {
    Text = "Usa \"Nascita di un'anima\" per ottenere 6 vittorie"
  },
  Task_79385_Desc = {
    Text = "Ottieni 1 vittoria usando \"Primavera a Yakutsk\""
  },
  Task_79386_Desc = {
    Text = "Ottieni 6 vittorie usando \"Ossessione Eterna\""
  },
  Task_79387_Desc = {
    Text = "Ottieni 3 vittorie usando \"Verso di Primavera\""
  },
  Task_79483_Desc = {
    Text = "Guarigione dal Terrore: Reame"
  },
  Task_79484_Desc = {
    Text = "Vinci 2 volte in \"Guarigione del Terrore\" usando un Risvegliatore del Reame di Aequor"
  },
  Task_79485_Desc = {
    Text = "Vinci 1 volta in \"Guarigione del Terrore\" usando un Risvegliatore del Reame di Aequor"
  },
  Task_79486_Desc = {
    Text = "Completa \"Clinica della Memoria\" a qualsiasi difficoltà"
  },
  Task_79487_Desc = {
    Text = "Vinci 2 volte in \"Guarigione del Terrore\" usando un Risvegliatore del Reame Ultra"
  },
  Task_79488_Desc = {
    Text = "Vinci 1 volta in \"Guarigione del Terrore\" usando un Risvegliatore del Reame Ultra"
  },
  Task_79489_Desc = {
    Text = "Completamento di \"Rinascita dalla Terra\" a Difficoltà Follia"
  },
  Task_79490_Desc = {
    Text = "Guarigione dal Terrore: Completamento"
  },
  Task_79491_Desc = {
    Text = "Completamento di \"Falena alla Fiamma\" a qualsiasi difficoltà"
  },
  Task_79492_Desc = {
    Text = "Vinci 1 volta in \"Guarigione del Terrore\" usando un Risvegliatore del Reame di Caro"
  },
  Task_79493_Desc = {
    Text = "Vinci 2 volte in \"Guarigione del Terrore\" usando un Risvegliatore del Reame di Caro"
  },
  Task_79494_Desc = {
    Text = "Completamento di \"Rinascita dalla Terra\" a qualsiasi difficoltà"
  },
  Task_79495_Desc = {
    Text = "Completamento di \"Mondo in Fiamme\" a Difficoltà Follia"
  },
  Task_79496_Desc = {
    Text = "Completa \"Tempo dell'Invasione del Sogno\" a Difficoltà Follia"
  },
  Task_79497_Desc = {
    Text = "Completa \"Clinica della Memoria\" a qualsiasi difficoltà"
  },
  Task_79498_Desc = {
    Text = "Completamento di \"Falena alla Fiamma\" a qualsiasi difficoltà"
  },
  Task_79499_Desc = {
    Text = "Completa \"Mondo in Fiamme\" a qualsiasi difficoltà"
  },
  Task_79500_Desc = {
    Text = "Guarigione dal Terrore: Follia"
  },
  Task_79501_Desc = {
    Text = "Completa \"Mondo in Fiamme\" a qualsiasi difficoltà"
  },
  Task_79502_Desc = {
    Text = "Completa \"Tempo dell'Invasione Onirica\" a qualsiasi difficoltà"
  },
  Task_79503_Desc = {
    Text = "Vinci 1 volta in \"Guarigione del Terrore\" usando un Risvegliatore del Reame del Caos"
  },
  Task_79504_Desc = {
    Text = "Vinci 2 volte in \"Guarigione del Terrore\" usando un Risvegliatore del Reame del Caos"
  },
  Task_79505_Desc = {
    Text = "Completamento di \"Rinascita dalla Terra\" a qualsiasi difficoltà"
  },
  Task_79506_Desc = {
    Text = "Completamento di \"Falena alla Fiamma\" a Difficoltà Follia"
  },
  Task_79507_Desc = {
    Text = "Completa tutti i compiti in \"Guarigione dal Terrore: Completamento\""
  },
  Task_79508_Desc = {
    Text = "Completa \"Tempo dell'Invasione Onirica\" a qualsiasi difficoltà"
  },
  Task_79509_Desc = {
    Text = "Completamento di \"Clinica della Memoria\" a Difficoltà Follia"
  },
  Task_79747_Desc = {
    Text = "Ottieni Clementine"
  },
  Task_79747_Name = {
    Text = "Ottieni Clementine"
  },
  Task_80218_Desc = {
    Text = "Sconfiggere i \"cittadini\" che bloccano il cammino"
  },
  Task_80218_Name = {Text = "Bersaglio"},
  Task_80219_Desc = {
    Text = "Impedire il \"Rito della Vita\""
  },
  Task_80219_Name = {Text = "Bersaglio"},
  Task_80220_Desc = {
    Text = "Sconfiggere la proiezione dell'universo @2"
  },
  Task_80220_Name = {Text = "Bersaglio"},
  Task_80221_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_80221_Name = {
    Text = "Superamento Perfetto"
  },
  Task_80222_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_80222_Name = {
    Text = "Superamento Perfetto"
  },
  Task_80223_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_80223_Name = {
    Text = "Superamento Perfetto"
  },
  Task_80224_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_80224_Name = {
    Text = "Superamento Perfetto"
  },
  Task_80225_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_80225_Name = {
    Text = "Superamento Perfetto"
  },
  Task_80226_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_80226_Name = {
    Text = "Superamento Perfetto"
  },
  Task_80227_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_80227_Name = {
    Text = "Superamento Perfetto"
  },
  Task_80228_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_80228_Name = {
    Text = "Superamento Perfetto"
  },
  Task_80229_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_80229_Name = {
    Text = "Superamento Perfetto"
  },
  Task_80230_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_80230_Name = {
    Text = "Superamento Perfetto"
  },
  Task_80231_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_80231_Name = {
    Text = "Superamento Perfetto"
  },
  Task_80232_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_80232_Name = {
    Text = "Superamento Perfetto"
  },
  Task_80233_Desc = {
    Text = "Confermare \"Ramona\""
  },
  Task_80233_Name = {Text = "Bersaglio"},
  Task_80234_Desc = {
    Text = "Evitare di essere catturati dalla pattuglia"
  },
  Task_80234_Name = {Text = "Bersaglio"},
  Task_80235_Desc = {
    Text = "Liberarsi de Le\"Clementine\""
  },
  Task_80235_Name = {Text = "Bersaglio"},
  Task_80236_Desc = {
    Text = "Procedere verso la sala di trattamento di Clementine"
  },
  Task_80236_Name = {Text = "Bersaglio"},
  Task_80237_Desc = {
    Text = "Tornare a casa"
  },
  Task_80237_Name = {Text = "Bersaglio"},
  Task_80238_Desc = {
    Text = "Impedire il \"Contenimento\" di Herbert"
  },
  Task_80238_Name = {Text = "Bersaglio"},
  Task_80239_Desc = {
    Text = "Fuggire dalla caccia del Dottore"
  },
  Task_80239_Name = {Text = "Bersaglio"},
  Task_80240_Desc = {
    Text = "Nel profondo della memoria di Albino"
  },
  Task_80240_Name = {Text = "Bersaglio"},
  Task_80241_Desc = {
    Text = "Soppressione del paziente impazzito"
  },
  Task_80241_Name = {Text = "Bersaglio"},
  Task_80286_Desc = {
    Text = "Completa il Capitolo Astrale 2-9"
  },
  Task_80287_Desc = {
    Text = "Completa il Capitolo Astrale 2-6 in Modalità Difficile"
  },
  Task_80288_Desc = {
    Text = "Completa l'evento d'indagine \"@1@2\""
  },
  Task_80288_Desc2 = {
    Text = "Completa l'evento d'indagine \"Metamorfosi\""
  },
  Task_80288_Name2 = {
    Text = "Ascoltando il Ronzio Cosmico"
  },
  Task_80289_Desc = {
    Text = "Completa l'Evento d'Indagine \"Metamorfosi\" a difficoltà Difficile"
  },
  Task_80289_Name = {
    Text = "Ascoltando il Ronzio Cosmico: Hard"
  },
  Task_80290_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_80291_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_80292_Desc = {
    Text = "Completa il Capitolo Astrale 2 \"Metamorfosi\""
  },
  Task_80293_Desc = {
    Text = "Completa il Capitolo Astrale Capitolo 2 \"Metamorfosi\" Modalità Difficile"
  },
  Task_80294_Desc = {
    Text = "Completa il Capitolo Astrale 2-6 in Modalità Difficile"
  },
  Task_80295_Desc = {
    Text = "Risuona 9 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_80295_Desc2 = {
    Text = "Ottieni 9 Risonanze nell'Evento d'Indagine \"Metamorfosi\""
  },
  Task_80295_Name2 = {
    Text = "Eco della Metamorfosi III"
  },
  Task_80296_Desc = {
    Text = "Risuona 6 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_80296_Desc2 = {
    Text = "Ottieni 6 Risonanze nell'Evento d'Indagine \"Trasformazione\""
  },
  Task_80296_Name2 = {
    Text = "Eco della Metamorfosi II"
  },
  Task_80297_Desc = {
    Text = "Risuona 3 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_80297_Desc2 = {
    Text = "Ottieni 3 Risonanze nell'Evento d'Indagine \"Trasformazione\""
  },
  Task_80297_Name2 = {
    Text = "Eco della Metamorfosi"
  },
  Task_80298_Desc = {
    Text = "Completa il Capitolo Astrale 2-9"
  },
  Task_80299_Desc = {
    Text = "Ottieni 11 Risonanze nell'Evento d'Indagine \"@1@2\""
  },
  Task_80299_Desc2 = {
    Text = "Ottieni 11 Risonanze nell'Evento d'Indagine \"Metamorfosi\""
  },
  Task_80299_Name2 = {
    Text = "Eco della Metamorfosi IV"
  },
  Task_80300_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_80301_Desc = {
    Text = "Completa il Capitolo Astrale 2 \"Metamorfosi\""
  },
  Task_80302_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_80303_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_80304_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_80305_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_80306_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_80307_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_80309_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_80310_Desc = {
    Text = "Completa il Capitolo Astrale Capitolo 2 \"Metamorfosi\" Modalità Difficile"
  },
  Task_80419_Name = {
    Text = "Completa il Capitolo Astrale 2-18"
  },
  Task_80433_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_80433_Name = {
    Text = "10 vittorie"
  },
  Task_80434_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_80434_Name = {Text = "6 vittorie"},
  Task_80435_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_80435_Name = {Text = "3 vittorie"},
  Task_80436_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_80436_Name = {Text = "1 vittoria"},
  Task_80993_Desc = {
    Text = "Strumento di Pulizia Ottenuto"
  },
  Task_80994_Desc = {
    Text = "Completa 3 missioni qualsiasi"
  },
  Task_80994_Name = {
    Text = "Pulizie Completate per Oggi!"
  },
  Task_80995_Desc = {
    Text = "Ricompense Evento"
  },
  Task_80996_Desc = {
    Text = "Strumento di Pulizia Ottenuto"
  },
  Task_80997_Desc = {
    Text = "Consuma 100000 Certificati Rosa"
  },
  Task_80997_Name = {
    Text = "Organizzazione Zaino"
  },
  Task_80998_Desc = {
    Text = "Strumento di Pulizia Ottenuto"
  },
  Task_80999_Desc = {
    Text = "Strumento di Pulizia Ottenuto"
  },
  Task_81000_Desc = {
    Text = "Accesso cumulativo per 6 giorni"
  },
  Task_81001_Desc = {
    Text = "Completa una qualsiasi operazione di indagine 1 volta"
  },
  Task_81001_Name = {
    Text = "Spolverare i Ricordi"
  },
  Task_81002_Desc = {
    Text = "Accedi per 3 giorni cumulativi"
  },
  Task_81003_Desc = {
    Text = "Strumento di Pulizia Ottenuto"
  },
  Task_81004_Desc = {
    Text = "Strumento di Pulizia Ottenuto"
  },
  Task_81005_Desc = {
    Text = "Strumento di Pulizia Ottenuto"
  },
  Task_81006_Desc = {
    Text = "Missioni Evento"
  },
  Task_81007_Desc = {
    Text = "Completata 1 battaglia Traphase"
  },
  Task_81007_Name = {
    Text = "Disinfezione Dimensionale"
  },
  Task_81008_Desc = {
    Text = "Accedi per 5 giorni cumulativi"
  },
  Task_81009_Desc = {
    Text = "Accedi per un totale di 7 giorni"
  },
  Task_81010_Desc = {
    Text = "Strumento di Pulizia Ottenuto"
  },
  Task_81011_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_81012_Desc = {
    Text = "Accedi per un totale di 4 giorni"
  },
  Task_81013_Desc = {
    Text = "Accedi per un totale di 2 giorni"
  },
  Task_81014_Desc = {
    Text = "Strumento di Pulizia Ottenuto"
  },
  Task_81015_Desc = {
    Text = "Strumento di Pulizia Ottenuto"
  },
  Task_81016_Desc = {
    Text = "Consuma 180 Menofina nella terra della dissoluzione"
  },
  Task_81016_Name = {
    Text = "Pulizia della Dissoluzione"
  },
  Task_81017_Desc = {
    Text = "7 giorni di accesso"
  },
  Task_81018_Desc = {
    Text = "Completata un'Immersione Fantasmatica"
  },
  Task_81018_Name = {
    Text = "Ventilazione Onirica"
  },
  Task_81083_Desc = {
    Text = "Perduti nel Mare Profondo: Follia"
  },
  Task_81084_Desc = {
    Text = "Completamento di \"Elegia finale\" a qualsiasi difficoltà"
  },
  Task_81085_Desc = {
    Text = "Usa un Risvegliatore di Aequor per vincere 2 volte in \"Odissea del Mare Profondo\""
  },
  Task_81086_Desc = {
    Text = "Completamento di \"Bussola Vecchia\" a qualsiasi difficoltà"
  },
  Task_81087_Desc = {
    Text = "Usa un Risvegliatore di Aequor per vincere 1 volta in \"Odissea del Mare Profondo\""
  },
  Task_81088_Desc = {
    Text = "Completamento di \"Elegia finale\" a qualsiasi difficoltà"
  },
  Task_81089_Desc = {
    Text = "Completamento di \"Manuale del Navigatore\" a Difficoltà Follia"
  },
  Task_81090_Desc = {
    Text = "Completamento di \"Luce del Navigatore\" a Difficoltà Follia"
  },
  Task_81091_Desc = {
    Text = "Usa un Risvegliatore del Reame Ultra per vincere 2 volte in \"Odissea del Mare Profondo\""
  },
  Task_81092_Desc = {
    Text = "Completamento di \"Vecchio Sestante\" a Difficoltà Follia"
  },
  Task_81093_Desc = {
    Text = "Completa l'Immersione Psichica \"Ultima Navigazione\""
  },
  Task_81094_Desc = {
    Text = "Completamento di \"Bussola Vecchia\" a Difficoltà Follia"
  },
  Task_81095_Desc = {
    Text = "Completamento di \"Luce del Navigatore\" a qualsiasi difficoltà"
  },
  Task_81096_Desc = {
    Text = "Completamento di \"Bussola Vecchia\" a qualsiasi difficoltà"
  },
  Task_81097_Desc = {
    Text = "Completa tutti i traguardi di \"Perduti nel Mare Profondo: Completato\""
  },
  Task_81098_Desc = {
    Text = "Completamento di \"Luce del Navigatore\" a qualsiasi difficoltà"
  },
  Task_81099_Desc = {
    Text = "Completa \"Traiettoria di Luce Stellare\" a Difficoltà Follia"
  },
  Task_81100_Desc = {
    Text = "Completamento di \"Traiettoria Stellare\" a qualsiasi difficoltà"
  },
  Task_81101_Desc = {
    Text = "Completamento di \"Bandiere di Segnalazione\" a qualsiasi difficoltà"
  },
  Task_81102_Desc = {
    Text = "Completamento di \"Bandiere di Segnalazione\" a qualsiasi difficoltà"
  },
  Task_81103_Desc = {
    Text = "Completamento di \"Vecchio Sestante\" a qualsiasi difficoltà"
  },
  Task_81104_Desc = {
    Text = "Completamento di \"Antica Carta Nautica\" a qualsiasi difficoltà"
  },
  Task_81105_Desc = {
    Text = "Completamento di \"Bandiere di Segnalazione\" a Difficoltà Follia"
  },
  Task_81106_Desc = {
    Text = "Completamento di \"Manuale del Navigatore\" a qualsiasi difficoltà"
  },
  Task_81107_Desc = {
    Text = "Completamento di \"Manuale del Navigatore\" a qualsiasi difficoltà"
  },
  Task_81108_Desc = {
    Text = "Completamento di \"Carta Stellare Rattoppata\" a qualsiasi difficoltà"
  },
  Task_81109_Desc = {
    Text = "Usa un Risvegliatore di Caro per vincere 1 volta in \"Odissea del Mare Profondo\""
  },
  Task_81110_Desc = {
    Text = "Usa un Risvegliatore del Reame Ultra per vincere 1 volta in \"Odissea del Mare Profondo\""
  },
  Task_81111_Desc = {
    Text = "Completamento di \"Elegia finale\" a Difficoltà Follia"
  },
  Task_81112_Desc = {
    Text = "Perduti nel Mare Profondo: Clear"
  },
  Task_81113_Desc = {
    Text = "Completamento di \"Traiettoria Stellare\" a qualsiasi difficoltà"
  },
  Task_81114_Desc = {
    Text = "Completamento di \"Antica Carta Nautica\" a qualsiasi difficoltà"
  },
  Task_81115_Desc = {
    Text = "Completamento di \"Antica Carta Nautica\" a Difficoltà Follia"
  },
  Task_81116_Desc = {
    Text = "Completa \"Carta Stellare Frammentaria\" a Difficoltà Follia"
  },
  Task_81117_Desc = {
    Text = "Completamento di \"Vecchio Sestante\" a qualsiasi difficoltà"
  },
  Task_81118_Desc = {
    Text = "Completamento di \"Carta Stellare Rattoppata\" a qualsiasi difficoltà"
  },
  Task_81119_Desc = {
    Text = "Perduti nel Mare Profondo: Realm"
  },
  Task_81120_Desc = {
    Text = "Usa un Risvegliatore del Caos per vincere 2 volte in \"Odissea del Mare Profondo\""
  },
  Task_81121_Desc = {
    Text = "Usa un Risvegliatore di Caro per vincere 2 volte in \"Odissea del Mare Profondo\""
  },
  Task_81122_Desc = {
    Text = "Usa un Risvegliatore del Caos per vincere 1 volta in \"Odissea del Mare Profondo\""
  },
  Task_81481_Desc = {
    Text = "Sconfiggi \"Cosmos @2 Proiezione\" senza ricorrere all'assistenza di Ramona: Consunta dal Tempo."
  },
  Task_81481_Name = {
    Text = "Ascoltando il Ronzio Cosmico: Nascosto"
  },
  Task_81772_Name = {
    Text = "Sconfiggi il BOSS 1N volte"
  },
  Task_81773_Name = {
    Text = "Sconfiggi il BOSS 7N volte"
  },
  Task_81774_Name = {
    Text = "Uccidere tutti i BOSS"
  },
  Task_81775_Name = {
    Text = "Sconfiggi il BOSS 3N volte"
  },
  Task_81776_Name = {
    Text = "Sconfiggi il BOSS 2N volte"
  },
  Task_81777_Name = {
    Text = "Sconfiggi il BOSS 6N volte"
  },
  Task_81778_Name = {
    Text = "Sconfiggi il BOSS 4N volte"
  },
  Task_81779_Name = {
    Text = "Sconfiggi il BOSS 5N volte"
  },
  Task_84111_Name = {
    Text = "Supera di nuovo il Livello Normale 4 della missione secondaria di Corposant"
  },
  Task_84143_Desc = {
    Text = "Accesso cumulativo per 2 giorni"
  },
  Task_84144_Desc = {
    Text = "Accesso × 3 giorni"
  },
  Task_84145_Desc = {
    Text = "Accesso cumulativo per 2 giorni"
  },
  Task_84146_Desc = {
    Text = "Accesso × 5 giorni"
  },
  Task_84147_Desc = {
    Text = "Accesso × 8 giorni"
  },
  Task_84148_Desc = {
    Text = "Accesso cumulativo per 2 giorni"
  },
  Task_84149_Desc = {
    Text = "Accesso × 5 giorni"
  },
  Task_84150_Desc = {
    Text = "Accesso × 10 giorni"
  },
  Task_84151_Desc = {
    Text = "Accesso × 5 giorni"
  },
  Task_84152_Desc = {
    Text = "Accesso × 10 giorni"
  },
  Task_84153_Desc = {
    Text = "Accesso × 4 giorni"
  },
  Task_84154_Desc = {
    Text = "Accesso × 9 giorni"
  },
  Task_84155_Desc = {
    Text = "Accesso × 3 giorni"
  },
  Task_84156_Desc = {
    Text = "Accesso × 6 giorni"
  },
  Task_84157_Desc = {
    Text = "Accesso cumulativo per 2 giorni"
  },
  Task_84158_Desc = {
    Text = "Accesso × 4 giorni"
  },
  Task_84159_Desc = {
    Text = "Accesso × 3 giorni"
  },
  Task_84160_Desc = {
    Text = "Accesso × 1 giorno"
  },
  Task_84161_Desc = {
    Text = "Accesso × 7 giorni"
  },
  Task_84162_Desc = {
    Text = "Accesso × 5 giorni"
  },
  Task_84163_Desc = {
    Text = "Accesso × 1 giorno"
  },
  Task_84164_Desc = {
    Text = "Accesso × 1 giorno"
  },
  Task_84165_Desc = {
    Text = "Accesso × 8 giorni"
  },
  Task_84166_Desc = {
    Text = "Accesso × 7 giorni"
  },
  Task_84167_Desc = {
    Text = "Accesso × 4 giorni"
  },
  Task_84168_Desc = {
    Text = "Accesso × 6 giorni"
  },
  Task_84169_Desc = {
    Text = "Accesso × 4 giorni"
  },
  Task_84170_Desc = {
    Text = "Accesso × 9 giorni"
  },
  Task_84171_Desc = {
    Text = "Accesso × 1 giorno"
  },
  Task_84172_Desc = {
    Text = "Accesso × 3 giorni"
  },
  Task_84323_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_84323_Name = {Text = "3 vittorie"},
  Task_84324_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_84324_Name = {Text = "6 vittorie"},
  Task_84325_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_84325_Name = {Text = "1 vittoria"},
  Task_84326_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_84326_Name = {
    Text = "10 vittorie"
  },
  Task_84349_Desc = {
    Text = "Completa la peregrinazione della coscienza \"L'Ultima Navigazione\""
  },
  Task_84349_Name = {
    Text = "Guida delle Stelle e dell'Abisso"
  },
  Task_88945_Desc = {
    Text = "Completa \"Catene Infrante\" a qualsiasi difficoltà"
  },
  Task_88946_Desc = {
    Text = "Completa Paesaggio Onirico \"Oltre i cieli: Parte I\""
  },
  Task_88947_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame del Caos per vincere due volte in \"Spirito Celeste\""
  },
  Task_88948_Desc = {
    Text = "Completa \"Viaggio della Solitudine\" a qualsiasi difficoltà"
  },
  Task_88949_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Aequor per vincere una volta in \"Spirito Celeste\""
  },
  Task_88950_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame del Caos per vincere una volta in \"Spirito Celeste\""
  },
  Task_88951_Desc = {
    Text = "Completa \"Portatore di Candela\" a qualsiasi difficoltà"
  },
  Task_88952_Desc = {
    Text = "Completa \"Catene Infrante\" a Difficoltà Follia"
  },
  Task_88953_Desc = {
    Text = "Completa \"Catene Infrante\" a qualsiasi difficoltà"
  },
  Task_88954_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere una volta in \"Spirito Celeste\""
  },
  Task_88955_Desc = {
    Text = "Completa \"Libertà e morte\" a Difficoltà Follia"
  },
  Task_88956_Desc = {
    Text = "Completa \"Viaggio della Solitudine\" a qualsiasi difficoltà"
  },
  Task_88957_Desc = {
    Text = "Spirito Celeste: Follia"
  },
  Task_88958_Desc = {
    Text = "Completa \"Libertà e morte\" a qualsiasi difficoltà"
  },
  Task_88959_Desc = {
    Text = "Completa \"Libertà e morte\" a qualsiasi difficoltà"
  },
  Task_88960_Desc = {
    Text = "Completa \"Sabbia Infinita\" a qualsiasi difficoltà"
  },
  Task_88961_Desc = {
    Text = "Completa tutti gli obiettivi in \"Spirito Celeste: Completato\""
  },
  Task_88962_Desc = {
    Text = "Completa \"Portatore di Candela\" a qualsiasi difficoltà"
  },
  Task_88963_Desc = {
    Text = "Completa \"Sabbia Infinita\" a Difficoltà Follia"
  },
  Task_88964_Desc = {
    Text = "Completa \"Il Folle\" a Difficoltà Follia"
  },
  Task_88965_Desc = {
    Text = "Completa \"Sogni di Ieri\" a Difficoltà Follia"
  },
  Task_88966_Desc = {
    Text = "Completa \"Viaggio della Solitudine\" a Difficoltà Follia"
  },
  Task_88967_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Caro per vincere due volte in \"Spirito Celeste\""
  },
  Task_88968_Desc = {
    Text = "Completa \"Sogni di Ieri\" a qualsiasi difficoltà"
  },
  Task_88969_Desc = {
    Text = "Spirito Celeste: Reame"
  },
  Task_88970_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Aequor per vincere due volte in \"Spirito Celeste\""
  },
  Task_88971_Desc = {
    Text = "Spirito Celeste: Completato"
  },
  Task_88972_Desc = {
    Text = "Completa \"Sabbia Infinita\" a qualsiasi difficoltà"
  },
  Task_88973_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Caro per vincere una volta in \"Spirito Celeste\""
  },
  Task_88974_Desc = {
    Text = "Completa \"Il Folle\" a qualsiasi difficoltà"
  },
  Task_88975_Desc = {
    Text = "Completa \"Portatore di Candela\" a Difficoltà Follia"
  },
  Task_88976_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere due volte in \"Spirito Celeste\""
  },
  Task_88977_Desc = {
    Text = "Completa \"Sogni di Ieri\" a qualsiasi difficoltà"
  },
  Task_88978_Desc = {
    Text = "Completa \"Il Folle\" a qualsiasi difficoltà"
  },
  Task_89577_Desc = {
    Text = "Accesso: 12 giorni"
  },
  Task_89578_Desc = {
    Text = "Accedi per un totale di 15 giorni"
  },
  Task_89579_Desc = {
    Text = "Accedi per un totale di 2 giorni"
  },
  Task_89580_Desc = {
    Text = "Accedi per un totale di 10 giorni"
  },
  Task_89581_Desc = {
    Text = "Accesso: 11 giorni"
  },
  Task_89582_Desc = {
    Text = "Accedi per 3 giorni cumulativi"
  },
  Task_89583_Desc = {
    Text = "Accesso cumulativo per 6 giorni"
  },
  Task_89584_Desc = {
    Text = "Accesso: 16 giorni"
  },
  Task_89585_Desc = {
    Text = "Accedi per un totale di 4 giorni"
  },
  Task_89586_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_89587_Desc = {
    Text = "Accedi per un totale di 7 giorni"
  },
  Task_89588_Desc = {
    Text = "Accesso: 14 giorni"
  },
  Task_89589_Desc = {
    Text = "Accedi per un totale di 8 giorni"
  },
  Task_89590_Desc = {
    Text = "Accedi per 5 giorni cumulativi"
  },
  Task_89591_Desc = {
    Text = "Accesso: 13 giorni"
  },
  Task_89592_Desc = {
    Text = "Accesso: 9 giorni"
  },
  Task_89844_Desc = {
    Text = "Esegui un Risveglio 5× ne Il Non Dimenticato ({s1}/1)"
  },
  Task_89844_Name = {
    Text = "Ottieni un Voucher Costume!"
  },
  Task_89845_Desc = {
    Text = "Accesso 7 giorni ({s1}/7)"
  },
  Task_89845_Name = {
    Text = "Ottieni un Voucher Costume!"
  },
  Task_89846_Desc = {
    Text = "Respingi il Branco della Marea Desolata ({s1}/30)"
  },
  Task_89846_Name = {
    Text = "Ottieni un Voucher Costume!"
  },
  Task_90036_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_90036_Name = {Text = "6 vittorie"},
  Task_90037_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_90037_Name = {Text = "3 vittorie"},
  Task_90038_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_90038_Name = {
    Text = "10 vittorie"
  },
  Task_90039_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_90039_Name = {Text = "1 vittoria"},
  Task_90495_Desc = {
    Text = "Azzera Insegnamento pratico·Pensieri del Caos"
  },
  Task_90495_Name = {
    Text = "Ideazione del Caos"
  },
  Task_90866_Desc = {
    Text = "Gestazione dell'Abisso I"
  },
  Task_90867_Desc = {
    Text = "Arte dei Mille Desideri I"
  },
  Task_90868_Desc = {
    Text = "Testo Temporaneo: Gratuito"
  },
  Task_90869_Desc = {
    Text = "Antifona dell'Ossario VII"
  },
  Task_90870_Desc = {
    Text = "Testo Temporaneo IV"
  },
  Task_90871_Desc = {
    Text = "Fati Coniugati III"
  },
  Task_90872_Desc = {
    Text = "Antifona dell'Ossario I"
  },
  Task_90873_Desc = {
    Text = "Arte dei Mille Desideri V"
  },
  Task_90874_Desc = {
    Text = "Gestazione dell'Abisso VI"
  },
  Task_90875_Desc = {
    Text = "Testo Temporaneo I"
  },
  Task_90876_Desc = {
    Text = "Gestazione dell'Abisso: Gratuita"
  },
  Task_90877_Desc = {
    Text = "Antifona dell'Ossario: Gratuito"
  },
  Task_90878_Desc = {
    Text = "Antifona dell'Ossario VI"
  },
  Task_90879_Desc = {
    Text = "Arte dei Mille Desideri IV"
  },
  Task_90880_Desc = {
    Text = "Arte dei Mille Desideri: Gratuita"
  },
  Task_90881_Desc = {
    Text = "Antifona dell'Ossario III"
  },
  Task_90882_Desc = {
    Text = "Fati Coniugati II"
  },
  Task_90883_Desc = {
    Text = "Testo Temporaneo V"
  },
  Task_90884_Desc = {
    Text = "Antifona dell'Ossario V"
  },
  Task_90885_Desc = {
    Text = "Testo Temporaneo VI"
  },
  Task_90886_Desc = {
    Text = "Testo Temporaneo VII"
  },
  Task_90887_Desc = {
    Text = "Fati Coniugati VI"
  },
  Task_90888_Desc = {
    Text = "Fati Coniugati IV"
  },
  Task_90889_Desc = {
    Text = "Antifona dell'Ossario IV"
  },
  Task_90890_Desc = {
    Text = "Fati Coniugati V"
  },
  Task_90891_Desc = {
    Text = "Fati Coniugati I"
  },
  Task_90892_Desc = {
    Text = "Arte dei Mille Desideri III"
  },
  Task_90893_Desc = {
    Text = "Gestazione dell'Abisso II"
  },
  Task_90894_Desc = {
    Text = "Testo Temporaneo III"
  },
  Task_90895_Desc = {
    Text = "Fati Coniugati VII"
  },
  Task_90896_Desc = {
    Text = "Antifona dell'Ossario II"
  },
  Task_90897_Desc = {
    Text = "Gestazione dell'Abisso VII"
  },
  Task_90898_Desc = {
    Text = "Gestazione dell'Abisso V"
  },
  Task_90899_Desc = {
    Text = "Gestazione dell'Abisso IV"
  },
  Task_90900_Desc = {
    Text = "Arte dei Mille Desideri VI"
  },
  Task_90901_Desc = {
    Text = "Fati Coniugati: Gratuito"
  },
  Task_90902_Desc = {
    Text = "Arte dei Mille Desideri II"
  },
  Task_90903_Desc = {
    Text = "Gestazione dell'Abisso III"
  },
  Task_90904_Desc = {
    Text = "Arte dei Mille Desideri VII"
  },
  Task_90905_Desc = {
    Text = "Testo Temporaneo II"
  },
  Task_91028_Desc = {
    Text = "Completa \"Corona del Campione\" a Difficoltà Follia"
  },
  Task_91029_Desc = {
    Text = "Usa un qualsiasi Risvegliato del Reame del Caos per vincere una volta in \"Predazione Sacra\""
  },
  Task_91030_Desc = {
    Text = "Usa un qualsiasi Risvegliato del Reame Caro per vincere una volta in \"Predazione Sacra\""
  },
  Task_91031_Desc = {
    Text = "Usa un qualsiasi Risvegliato del Reame Ultra per vincere una volta in \"Predazione Sacra\""
  },
  Task_91032_Desc = {
    Text = "Usa un qualsiasi Risvegliato del Reame Caro per vincere due volte in \"Predazione Sacra\""
  },
  Task_91033_Desc = {
    Text = "Predazione Sacra: Completato"
  },
  Task_91034_Desc = {
    Text = "Completa \"Cacciatore Feroce\" a qualsiasi difficoltà"
  },
  Task_91035_Desc = {
    Text = "Predazione Sacra: Follia"
  },
  Task_91036_Desc = {
    Text = "Completa \"Corno dell'Esodo\" a qualsiasi difficoltà"
  },
  Task_91037_Desc = {
    Text = "Completa \"Ingegno Collettivo\" a qualsiasi difficoltà"
  },
  Task_91038_Desc = {
    Text = "Usa un qualsiasi Risvegliato del Reame Aequor per vincere due volte in \"Predazione Sacra\""
  },
  Task_91039_Desc = {
    Text = "Usa un qualsiasi Risvegliato del Reame Ultra per vincere due volte in \"Predazione Sacra\""
  },
  Task_91040_Desc = {
    Text = "Completa Paesaggio Onirico: Dominio Culinario"
  },
  Task_91041_Desc = {
    Text = "Completa \"Corona del Campione\" a qualsiasi difficoltà"
  },
  Task_91042_Desc = {
    Text = "Completa \"Corona del Campione\" a qualsiasi difficoltà"
  },
  Task_91043_Desc = {
    Text = "Usa un qualsiasi Risvegliato del Reame Aequor per vincere una volta in \"Predazione Sacra\""
  },
  Task_91044_Desc = {
    Text = "Completa \"Gloria Trionfale\" a qualsiasi difficoltà"
  },
  Task_91045_Desc = {
    Text = "Completa \"Cacciatore Feroce\" a qualsiasi difficoltà"
  },
  Task_91046_Desc = {
    Text = "Completa \"Ingegno Collettivo\" a Difficoltà Follia"
  },
  Task_91047_Desc = {
    Text = "Completa \"Corno dell'Esodo\" a qualsiasi difficoltà"
  },
  Task_91048_Desc = {
    Text = "Completa \"Ingegno Collettivo\" a qualsiasi difficoltà"
  },
  Task_91049_Desc = {
    Text = "Completa \"Gloria Trionfale\" a qualsiasi difficoltà"
  },
  Task_91050_Desc = {
    Text = "Completa tutti gli obiettivi in \"Predazione Sacra: Completato\""
  },
  Task_91051_Desc = {
    Text = "Completa \"Corno dell'Esodo\" a Difficoltà Follia"
  },
  Task_91052_Desc = {
    Text = "Completa \"Gloria Trionfale\" a Difficoltà Follia"
  },
  Task_91053_Desc = {
    Text = "Predazione Sacra: Reame"
  },
  Task_91054_Desc = {
    Text = "Completa \"Cacciatore Feroce\" a Difficoltà Follia"
  },
  Task_91055_Desc = {
    Text = "Usa un qualsiasi Risvegliato del Reame del Caos per vincere due volte in \"Predazione Sacra\""
  },
  Task_91129_Desc = {
    Text = "Il Livello raggiunge 20"
  },
  Task_91131_Desc = {
    Text = "Il Livello raggiunge 5"
  },
  Task_91149_Desc = {
    Text = "Il Livello raggiunge 15"
  },
  Task_91154_Desc = {
    Text = "Il Livello raggiunge 10"
  },
  Task_91332_Desc = {
    Text = "Sconfiggi Doresain"
  },
  Task_91332_Name = {Text = "Bersaglio"},
  Task_91333_Desc = {
    Text = "Sconfiggere gli invasori"
  },
  Task_91333_Name = {Text = "Bersaglio"},
  Task_91334_Desc = {
    Text = "Sconfiggi la \"Marionetta della Putrescenza\" e proteggi Necrovia"
  },
  Task_91334_Name = {Text = "Bersaglio"},
  Task_91335_Desc = {
    Text = "Sconfiggere il Navigatore"
  },
  Task_91335_Name = {Text = "Bersaglio"},
  Task_91336_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_91336_Name = {
    Text = "Superamento Perfetto"
  },
  Task_91337_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_91337_Name = {
    Text = "Superamento Perfetto"
  },
  Task_91338_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_91338_Name = {
    Text = "Superamento Perfetto"
  },
  Task_91339_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_91339_Name = {
    Text = "Superamento Perfetto"
  },
  Task_91340_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_91340_Name = {
    Text = "Superamento Perfetto"
  },
  Task_91341_Desc = {
    Text = "Distruggere l'\"Opera\" di Pickman"
  },
  Task_91341_Name = {Text = "Bersaglio"},
  Task_91342_Desc = {
    Text = "Sconfiggere il nemico ed entrare nella Città del Re dei Ghoul"
  },
  Task_91342_Name = {Text = "Bersaglio"},
  Task_91343_Desc = {
    Text = "Liberarsi dalla caccia del ghoul"
  },
  Task_91343_Name = {Text = "Bersaglio"},
  Task_91344_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_91344_Name = {
    Text = "Superamento Perfetto"
  },
  Task_91345_Desc = {
    Text = "Sconfiggi i Dissoluti"
  },
  Task_91345_Name = {Text = "Bersaglio"},
  Task_91346_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_91346_Name = {
    Text = "Superamento Perfetto"
  },
  Task_91347_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_91347_Name = {
    Text = "Superamento Perfetto"
  },
  Task_91348_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_91348_Name = {
    Text = "Superamento Perfetto"
  },
  Task_91349_Desc = {
    Text = "Respingere Golia e distruggere il Cerchio magico"
  },
  Task_91349_Name = {Text = "Bersaglio"},
  Task_91350_Desc = {
    Text = "Completa senza attivare il Corpo di Gnosi d'Emergenza"
  },
  Task_91350_Name = {
    Text = "Superamento Perfetto"
  },
  Task_91351_Desc = {
    Text = "Sconfiggere il Maggiordomo Fran"
  },
  Task_91351_Name = {Text = "Bersaglio"},
  Task_91357_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_91358_Desc = {
    Text = "Completamento Capitolo Astrale 3-5"
  },
  Task_91359_Desc = {
    Text = "Completa l'evento d'indagine \"@1@2\""
  },
  Task_91359_Desc2 = {
    Text = "Indagine Completa: \"Gala dell'Ossario\""
  },
  Task_91359_Name2 = {
    Text = "Banchetto d'Ossa e Spirito"
  },
  Task_91360_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_91361_Desc = {
    Text = "Completa il Capitolo Astrale Capitolo 3, Livello 3-5 in difficoltà ardua"
  },
  Task_91362_Desc = {
    Text = "Completa il Capitolo Astrale Capitolo 3: \"Gala dell'Ossario\" in difficoltà ardua"
  },
  Task_91363_Desc = {
    Text = "Completa l'Evento d'Indagine \"Sazietà\" a difficoltà Difficile"
  },
  Task_91363_Name = {
    Text = "Banchetto d'Ossa e Spirito: Difficile"
  },
  Task_91364_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_91365_Desc = {
    Text = "Completamento Capitolo Astrale Capitolo 3: \"Gala dell'Ossario\""
  },
  Task_91366_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_91367_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_91368_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_91370_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_91371_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_91372_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_91373_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_91379_Desc = {
    Text = "Completamento Capitolo Astrale Capitolo 3, Livello 2-5 a difficoltà Difficile"
  },
  Task_91380_Desc = {
    Text = "Completamento Capitolo Astrale Capitolo 3, Livello 2-5"
  },
  Task_91381_Desc = {
    Text = "Completa il Capitolo Astrale Capitolo 3: \"Gala dell'Ossario\" in difficoltà ardua"
  },
  Task_91382_Desc = {
    Text = "Completamento Capitolo Astrale Capitolo 3: \"Gala dell'Ossario\""
  },
  Task_91436_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_91436_Name = {Text = "1 vittoria"},
  Task_91437_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_91437_Name = {Text = "3 vittorie"},
  Task_91438_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_91438_Name = {Text = "6 vittorie"},
  Task_91439_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_91439_Name = {
    Text = "10 vittorie"
  },
  Task_91720_Desc = {
    Text = "Accesso 7 giorni ({s1}/7)"
  },
  Task_91720_Name = {
    Text = "Ottieni un Voucher Costume!"
  },
  Task_91721_Desc = {
    Text = "Completa tutti gli stadi a Difficoltà Follia ({s1}/5)"
  },
  Task_91721_Name = {
    Text = "Ottieni un Voucher Costume!"
  },
  Task_91786_Desc = {
    Text = "Usa un qualsiasi Risvegliato del Reame Caro per vincere due volte in \"Natività del Regno Divino\""
  },
  Task_91787_Desc = {
    Text = "Usa un qualsiasi Risvegliato del Reame del Caos per vincere due volte in \"Natività del Regno Divino\""
  },
  Task_91788_Desc = {
    Text = "Usa un qualsiasi Risvegliato del Reame Aequor per vincere due volte in \"Natività del Regno Divino\""
  },
  Task_91789_Desc = {
    Text = "Usa un qualsiasi Risvegliato del Reame Ultra per vincere due volte in \"Natività del Regno Divino\""
  },
  Task_94489_Desc = {
    Text = "Porta 6 personaggi Caos al Livello 80"
  },
  Task_94489_Name = {
    Text = "Padronanza del Reame X"
  },
  Task_94490_Desc = {
    Text = "Porta 6 personaggi Aequor al Livello 70"
  },
  Task_94490_Name = {
    Text = "Padronanza del Reame IX"
  },
  Task_94491_Desc = {
    Text = "Porta 6 personaggi Ultra al Livello 70"
  },
  Task_94491_Name = {
    Text = "Padronanza del Reame IX"
  },
  Task_94492_Desc = {
    Text = "Porta 6 personaggi Caro al Livello 80"
  },
  Task_94492_Name = {
    Text = "Padronanza del Reame X"
  },
  Task_94493_Desc = {
    Text = "Porta 6 personaggi Aequor al Livello 80"
  },
  Task_94493_Name = {
    Text = "Padronanza del Reame X"
  },
  Task_94494_Desc = {
    Text = "Porta 6 personaggi Caro al Livello 70"
  },
  Task_94494_Name = {
    Text = "Padronanza del Reame IX"
  },
  Task_94495_Desc = {
    Text = "Porta 6 personaggi Caos al Livello 70"
  },
  Task_94495_Name = {
    Text = "Padronanza del Reame IX"
  },
  Task_94496_Desc = {
    Text = "Porta 6 personaggi Ultra al Livello 80"
  },
  Task_94496_Name = {
    Text = "Padronanza del Reame X"
  },
  Task_94497_Desc = {
    Text = "Completa tutte le missioni di questo capitolo per ottenere le ricompense."
  },
  Task_94497_Name = {
    Text = "Padronanza del Reame X"
  },
  Task_94498_Desc = {
    Text = "Completa tutte le missioni di questo capitolo per ottenere le ricompense."
  },
  Task_94498_Name = {
    Text = "Padronanza del Reame IX"
  },
  Task_94613_Desc = {
    Text = "Azzera Insegnamento pratico · Dominio Ultra"
  },
  Task_94613_Name = {
    Text = "Il Reame Ultra"
  },
  Task_94614_Desc = {
    Text = "Azzera Insegnamento pratico · Colonia di Caro"
  },
  Task_94614_Name = {
    Text = "Propagazione di Caro"
  },
  Task_94615_Desc = {
    Text = "Azzera Insegnamento pratico·Tocco di Aequor"
  },
  Task_94615_Name = {
    Text = "Tocco di Aequor"
  },
  Task_94699_Desc = {
    Text = "Antifona dell'Ossario: Esclusiva a tempo limitato"
  },
  Task_94861_Desc = {
    Text = "Consuma 1800 Menofina"
  },
  Task_94863_Desc = {
    Text = "Risvegli cumulativi: 100 volte"
  },
  Task_94865_Desc = {
    Text = "Usa Supporto 3 volte"
  },
  Task_94867_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_94871_Desc = {
    Text = "Completa la Prova di Kathigu-Ra una volta"
  },
  Task_94874_Desc = {
    Text = "Completa 2 settimane di Prova Settimanale"
  },
  Task_94876_Desc = {
    Text = "Consuma 1800 Menofina"
  },
  Task_94877_Desc = {
    Text = "Completa 20 Incarichi"
  },
  Task_94882_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_94885_Desc = {
    Text = "Completa 2 settimane di Prova Settimanale"
  },
  Task_94886_Desc = {
    Text = "Completa la Prova di Kathigu-Ra una volta"
  },
  Task_94888_Desc = {
    Text = "Usa Supporto 3 volte"
  },
  Task_94891_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_94895_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_94898_Desc = {
    Text = "Risvegli cumulativi: 100 volte"
  },
  Task_94901_Desc = {
    Text = "Completa 20 Incarichi"
  },
  Task_95192_Desc = {
    Text = "Completa \"Il Sole sulla Terra\" a Difficoltà Follia"
  },
  Task_95193_Desc = {
    Text = "Vinci due volte nella \"Caccia dei Carbonizzati\" usando un Risvegliatore di Caro"
  },
  Task_95194_Desc = {
    Text = "Completa \"Rovine Silenziose\" a qualsiasi difficoltà"
  },
  Task_95195_Desc = {
    Text = "Vinci una volta nella \"Caccia dei Carbonizzati\" usando un Risvegliatore del Caos"
  },
  Task_95196_Desc = {
    Text = "Completa l'Immersione Psichica \"Giorno eterno immortale\""
  },
  Task_95197_Desc = {
    Text = "Completa \"Nucleo del Patto\" a qualsiasi difficoltà"
  },
  Task_95198_Desc = {
    Text = "Completa \"Rovine Silenziose\" a Difficoltà Follia"
  },
  Task_95199_Desc = {
    Text = "Completa \"Nucleo del Patto\" a qualsiasi difficoltà"
  },
  Task_95200_Desc = {
    Text = "Completa \"Il Sole sulla Terra\" a qualsiasi difficoltà"
  },
  Task_95201_Desc = {
    Text = "Completa \"Verdetto Ardente\" a qualsiasi difficoltà"
  },
  Task_95202_Desc = {
    Text = "Vinci una volta nella \"Caccia dei Carbonizzati\" usando un Risvegliatore di Aequor"
  },
  Task_95203_Desc = {
    Text = "Completa \"Giuramento primordiale\" a qualsiasi difficoltà"
  },
  Task_95204_Desc = {
    Text = "Completa \"Verdetto Ardente\" a qualsiasi difficoltà"
  },
  Task_95205_Desc = {
    Text = "Vinci una volta nella \"Caccia dei Carbonizzati\" usando un Risvegliatore del Reame Ultra"
  },
  Task_95206_Desc = {
    Text = "Vinci due volte nella \"Caccia dei Carbonizzati\" usando un Risvegliatore del Caos"
  },
  Task_95207_Desc = {
    Text = "Completa \"Rogo Divoratore\" a qualsiasi difficoltà"
  },
  Task_95208_Desc = {
    Text = "Completa \"Il Sole sulla Terra\" a qualsiasi difficoltà"
  },
  Task_95209_Desc = {
    Text = "Vinci una volta nella \"Caccia dei Carbonizzati\" usando un Risvegliatore di Caro"
  },
  Task_95210_Desc = {
    Text = "Vinci due volte nella \"Caccia dei Carbonizzati\" usando un Risvegliatore del Reame Ultra"
  },
  Task_95211_Desc = {
    Text = "Completa \"Verdetto Ardente\" a Difficoltà Follia"
  },
  Task_95212_Desc = {
    Text = "Caccia dei Carbonizzati: Follia"
  },
  Task_95213_Desc = {
    Text = "Vinci due volte nella \"Caccia dei Carbonizzati\" usando un Risvegliatore di Aequor"
  },
  Task_95214_Desc = {
    Text = "Completa \"Nucleo del Patto\" a Difficoltà Follia"
  },
  Task_95215_Desc = {
    Text = "Completa \"Rovine Silenziose\" a qualsiasi difficoltà"
  },
  Task_95216_Desc = {
    Text = "Completa \"Rogo Divoratore\" a qualsiasi difficoltà"
  },
  Task_95217_Desc = {
    Text = "Caccia dei Carbonizzati: Reame"
  },
  Task_95218_Desc = {
    Text = "Completa \"Inno delle Ceneri\" a qualsiasi difficoltà"
  },
  Task_95219_Desc = {
    Text = "Completa \"Giuramento primordiale\" a qualsiasi difficoltà"
  },
  Task_95220_Desc = {
    Text = "Completa \"Giuramento primordiale\" a Difficoltà Follia"
  },
  Task_95221_Desc = {
    Text = "Completa \"Rogo Divoratore\" a Difficoltà Follia"
  },
  Task_95222_Desc = {
    Text = "Completa \"Inno delle Ceneri\" a qualsiasi difficoltà"
  },
  Task_95223_Desc = {
    Text = "Completa tutti gli obiettivi in \"Caccia dei Carbonizzati: Completato\""
  },
  Task_95224_Desc = {
    Text = "Completa \"Inno delle Ceneri\" a Difficoltà Follia"
  },
  Task_95225_Desc = {
    Text = "Caccia dei Carbonizzati: Completato"
  },
  Task_95470_Desc = {
    Text = "Sconfiggere N"
  },
  Task_95470_Name = {Text = "Bersaglio"},
  Task_95520_Desc = {
    Text = "Estrai 16000 Essenza di Silver Core"
  },
  Task_95521_Desc = {
    Text = "Estrai 25000 Essenza di Silver Core"
  },
  Task_95522_Desc = {
    Text = "Estrai 13000 Essenza di Silver Core"
  },
  Task_95523_Desc = {
    Text = "Estrai 8000 Essenza di Silver Core"
  },
  Task_95524_Desc = {
    Text = "Estrai 2000 Essenza di Silver Core"
  },
  Task_95525_Desc = {
    Text = "Estrai 20000 Essenza di Silver Core"
  },
  Task_95526_Desc = {
    Text = "Estrai 4000 Essenza di Silver Core"
  },
  Task_95527_Desc = {
    Text = "Estrai 5000 Essenza di Silver Core"
  },
  Task_95532_Desc = {
    Text = "Giardino dei Ricordi: Follia"
  },
  Task_95533_Desc = {
    Text = "Completa \"Ceneri Residue\" a Difficoltà Follia"
  },
  Task_95534_Desc = {
    Text = "Completa \"Regno Minuscolo\" a Difficoltà Follia"
  },
  Task_95535_Desc = {
    Text = "Completa \"Prima Fioritura\" a Difficoltà Follia"
  },
  Task_95536_Desc = {
    Text = "Completa \"Mani Intrecciate\" a Difficoltà Follia"
  },
  Task_95537_Desc = {
    Text = "Completa \"Versi in Fiamme\" a Difficoltà Follia"
  },
  Task_95543_Desc = {
    Text = "Completa \"Prima Fioritura\" a qualsiasi difficoltà"
  },
  Task_95544_Desc = {
    Text = "Completa \"Mani Intrecciate\" a qualsiasi difficoltà"
  },
  Task_95545_Desc = {
    Text = "Completa \"Versi in Fiamme\" a qualsiasi difficoltà"
  },
  Task_95546_Desc = {
    Text = "Completa \"Ceneri Residue\" a qualsiasi difficoltà"
  },
  Task_95547_Desc = {
    Text = "Completa \"Regno Minuscolo\" a qualsiasi difficoltà"
  },
  Task_95830_Desc = {
    Text = "Soulsfeast: Reame"
  },
  Task_95831_Desc = {
    Text = "Completa \"Tormento di Fiamma Spettrale\" a Difficoltà Follia"
  },
  Task_95832_Desc = {
    Text = "Completa \"Profumeria d'Humus\" a qualsiasi difficoltà"
  },
  Task_95833_Desc = {
    Text = "Completa \"Profumeria d'Humus\" a Difficoltà Follia"
  },
  Task_95834_Desc = {
    Text = "Completa \"Rito della Bara Sommersa\" a qualsiasi difficoltà"
  },
  Task_95835_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame di Caro per vincere due volte in \"Soulsfeast\""
  },
  Task_95836_Desc = {
    Text = "Attiva Illuminare 2 quando ottieni Doresain"
  },
  Task_95836_Name = {
    Text = "Attiva Illuminare 2 quando ottieni Doresain"
  },
  Task_95836_UnlockCondDesc = {
    Text = "Evento @Pacchetto Dono Illuminazione 2 Risvegliatore Dulethain Evento"
  },
  Task_95837_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_95838_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_95839_Desc = {
    Text = "Completa \"Rito della Bara Sommersa\" a qualsiasi difficoltà"
  },
  Task_95840_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame del Caos per vincere una volta in \"Soulsfeast\""
  },
  Task_95841_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame di Caro per vincere una volta in \"Soulsfeast\""
  },
  Task_95842_Desc = {
    Text = "Completa \"Separazione del Midollo\" a Difficoltà Follia"
  },
  Task_95843_Desc = {
    Text = "Completa \"Banchetto del Reliquiario\" a Difficoltà Follia"
  },
  Task_95844_Desc = {
    Text = "Completa \"Tormento di Fiamma Spettrale\" a qualsiasi difficoltà"
  },
  Task_95845_Desc = {
    Text = "Completa \"Tormento di Fiamma Spettrale\" a qualsiasi difficoltà"
  },
  Task_95846_Desc = {
    Text = "L'Affinità di Doresain raggiunge il Liv. 10"
  },
  Task_95847_Desc = {
    Text = "Soulsfeast: Completamento"
  },
  Task_95848_Desc = {
    Text = "Completa tutti i compiti in \"Soulsfeast: Completamento\""
  },
  Task_95849_Desc = {
    Text = "Completa \"Rito della Bara Sommersa\" a Difficoltà Follia"
  },
  Task_95850_Desc = {
    Text = "Attiva Illuminare 6 quando ottieni Doresain"
  },
  Task_95850_Name = {
    Text = "Attiva Illuminare 6 quando ottieni Doresain"
  },
  Task_95850_UnlockCondDesc = {
    Text = "Evento @Pacchetto Dono Illuminazione 2 Risvegliatore Dulethain Evento"
  },
  Task_95853_Desc = {
    Text = "Completa \"Separazione del Midollo\" a qualsiasi difficoltà"
  },
  Task_95854_Desc = {
    Text = "Soulsfeast: Follia"
  },
  Task_95855_Desc = {
    Text = "Completa \"Banchetto del Reliquiario\" a qualsiasi difficoltà"
  },
  Task_95856_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame di Aequor per vincere una volta in \"Soulsfeast\""
  },
  Task_95857_Desc = {
    Text = "Completa \"Profumeria d'Humus\" a qualsiasi difficoltà"
  },
  Task_95858_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere una volta in \"Soulsfeast\""
  },
  Task_95860_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere due volte in \"Soulsfeast\""
  },
  Task_95861_Desc = {
    Text = "Completa \"Separazione del Midollo\" a qualsiasi difficoltà"
  },
  Task_95862_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame di Aequor per vincere due volte in \"Soulsfeast\""
  },
  Task_95863_Desc = {
    Text = "Completa \"Banchetto del Reliquiario\" a qualsiasi difficoltà"
  },
  Task_95864_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame del Caos per vincere due volte in \"Soulsfeast\""
  },
  Task_95865_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_95866_UnlockCondDesc = {
    Text = "Riscatta il pacchetto regalo precedente."
  },
  Task_96333_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_96333_Name = {
    Text = "10 vittorie"
  },
  Task_96334_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_96334_Name = {Text = "3 vittorie"},
  Task_96335_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_96335_Name = {Text = "6 vittorie"},
  Task_96336_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_96336_Name = {Text = "1 vittoria"},
  Task_96618_Desc = {
    Text = "Acquista con Certificati Rosa 3 volte"
  },
  Task_96619_Desc = {
    Text = "Completa 20 Incarichi"
  },
  Task_96620_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_96621_Desc = {
    Text = "Supera la \"24\"Prova una volta"
  },
  Task_96622_Desc = {
    Text = "Completa 2 Prove Settimanali"
  },
  Task_96623_Desc = {
    Text = "Supera il Dominio Arcano una volta"
  },
  Task_96624_Desc = {
    Text = "Accedi per un totale di 15 giorni"
  },
  Task_96625_Desc = {
    Text = "Completa 20 Incarichi"
  },
  Task_96626_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_96627_Desc = {
    Text = "Supera il Dominio Arcano una volta"
  },
  Task_96628_Desc = {
    Text = "Consuma 1800 Menofina"
  },
  Task_96629_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_96630_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_96631_Desc = {
    Text = "Acquista con Certificati Rosa 3 volte"
  },
  Task_96632_Desc = {
    Text = "Consuma 1800 Menofina"
  },
  Task_96633_Desc = {
    Text = "Supera la \"24\"Prova una volta"
  },
  Task_96840_Desc = {
    Text = "Schizzo Bizzarro: Completato"
  },
  Task_96841_Desc = {
    Text = "Completamento di \"Rivoluzione all'Inferno\" a qualsiasi Difficoltà"
  },
  Task_96842_Desc = {
    Text = "Completa \"Danza folle del Toro\" a Difficoltà Follia"
  },
  Task_96843_Desc = {
    Text = "Completa \"Spettro del Filo\" a qualsiasi difficoltà"
  },
  Task_96844_Desc = {
    Text = "Completa \"Fermo del Carnevale\" a Difficoltà Follia"
  },
  Task_96845_Desc = {
    Text = "Completa \"Danza folle del Toro\" a Difficoltà Follia"
  },
  Task_96846_Desc = {
    Text = "Usa un qualsiasi Risveglio del Reame Ultra per vincere due volte in \"Schizzo Bizzarro\""
  },
  Task_96847_Desc = {
    Text = "Completa \"Invasione d'Ispirazione\" a qualsiasi difficoltà"
  },
  Task_96848_Desc = {
    Text = "Completa \"Diffusione Sanguigna\" a Difficoltà Follia"
  },
  Task_96849_Desc = {
    Text = "Completamento di \"Diffusione Sanguigna\" a qualsiasi Difficoltà"
  },
  Task_96850_Desc = {
    Text = "Completa \"Danza folle del Toro\" a Difficoltà Follia"
  },
  Task_96851_Desc = {
    Text = "Completamento di \"Diffusione Sanguigna\" a qualsiasi Difficoltà"
  },
  Task_96852_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame del Caos per vincere due volte in \"Schizzo Bizzarro\""
  },
  Task_96853_Desc = {
    Text = "Completa tutti gli obiettivi di \"Schizzo Bizzarro: Completato\""
  },
  Task_96854_Desc = {
    Text = "Completa \"Spettro del Filo\" a qualsiasi difficoltà"
  },
  Task_96855_Desc = {
    Text = "Completa \"Fermo del Carnevale\" a qualsiasi difficoltà"
  },
  Task_96856_Desc = {
    Text = "Schizzo Bizzarro: Reame"
  },
  Task_96857_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Aequor per vincere due volte in \"Schizzo Bizzarro\""
  },
  Task_96858_Desc = {
    Text = "Completa \"Spettro del Filo\" a Difficoltà Follia"
  },
  Task_96859_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Caro per vincere una volta in \"Schizzo Bizzarro\""
  },
  Task_96860_Desc = {
    Text = "Completamento di \"Rivoluzione all'Inferno\" a qualsiasi Difficoltà"
  },
  Task_96861_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame del Caos per vincere una volta in \"Schizzo Bizzarro\""
  },
  Task_96862_Desc = {
    Text = "Completa l'Immersione Psichica \"Dipinto del Mondo Distorto\""
  },
  Task_96863_Desc = {
    Text = "Completamento di \"Cumulo di Incubi\" a qualsiasi Difficoltà"
  },
  Task_96864_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Aequor per vincere una volta in \"Schizzo Bizzarro\""
  },
  Task_96865_Desc = {
    Text = "Completamento di \"Invasione d'Ispirazione\" in Difficoltà Follia"
  },
  Task_96866_Desc = {
    Text = "Completamento di \"Cumulo di Incubi\" a qualsiasi Difficoltà"
  },
  Task_96867_Desc = {
    Text = "Schizzo Bizzarro: Follia"
  },
  Task_96868_Desc = {
    Text = "Completa \"Fermo del Carnevale\" a qualsiasi difficoltà"
  },
  Task_96869_Desc = {
    Text = "Completa \"Invasione d'Ispirazione\" a qualsiasi difficoltà"
  },
  Task_96870_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Caro per vincere due volte in \"Schizzo Bizzarro\""
  },
  Task_96871_Desc = {
    Text = "Completa \"Rivoluzione all'Inferno\" a Difficoltà Follia"
  },
  Task_96872_Desc = {
    Text = "Completa \"Cumulo di Incubi\" a Difficoltà Follia"
  },
  Task_96873_Desc = {
    Text = "Usa un qualsiasi Risveglio del Reame Ultra per vincere una volta in \"Schizzo Bizzarro\""
  },
  Task_97192_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_97193_Desc = {
    Text = "Completa 20 Incarichi"
  },
  Task_97194_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_97195_Desc = {
    Text = "Completa la Prova di Doresain 1 volta"
  },
  Task_97196_Desc = {
    Text = "Completa 2 settimane di Prova Settimanale"
  },
  Task_97197_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_97198_Desc = {
    Text = "Consuma 1800 Menofina"
  },
  Task_97199_Desc = {
    Text = "Supera il Dominio Arcano una volta"
  },
  Task_97200_Desc = {
    Text = "Supera il Dominio Arcano una volta"
  },
  Task_97201_Desc = {
    Text = "Consuma 1800 Menofina"
  },
  Task_97202_Desc = {
    Text = "Completa la Missione Quotidiana 3 volte"
  },
  Task_97203_Desc = {
    Text = "Completa la Prova di Doresain 1 volta"
  },
  Task_97243_Desc = {
    Text = "Completa 20 Incarichi"
  },
  Task_97244_Desc = {
    Text = "Completa 2 settimane di Prova Settimanale"
  },
  Task_97245_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_97246_Desc = {
    Text = "Completa la Missione Quotidiana 3 volte"
  },
  Task_97309_Desc = {
    Text = "Risuona 6 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_97309_Desc2 = {
    Text = "Ottieni 6 Risonanze nell'Evento d'Indagine \"Ingozzamento\""
  },
  Task_97309_Name2 = {
    Text = "Eco della Gola III"
  },
  Task_97310_Desc = {
    Text = "Risuona 9 volte nell'Evento d'Indagine \"@1@2\""
  },
  Task_97310_Desc2 = {
    Text = "\"Ottieni 9 Risonanze nell'Evento d'Indagine \"Festino\".\""
  },
  Task_97310_Name2 = {
    Text = "Eco della Gola IV"
  },
  Task_97311_Desc = {
    Text = "\"Ottieni 2 Risonanze nell'Evento d'Indagine \"@1@2\".\""
  },
  Task_97311_Desc2 = {
    Text = "\"Ottieni 2 Risonanze nell'Evento d'Indagine \"Festino\".\""
  },
  Task_97311_Name2 = {
    Text = "Eco della Gola"
  },
  Task_97312_Desc = {
    Text = "\"Ottieni 4 Risonanze nell'Evento d'Indagine \"@1@2\".\""
  },
  Task_97312_Desc2 = {
    Text = "\"Ottieni 4 Risonanze nell'Evento d'Indagine \"Festino\".\""
  },
  Task_97312_Name2 = {
    Text = "Eco della Gola II"
  },
  Task_97322_Desc = {
    Text = "Sconfiggi \"La Marionetta della Marea Corrotta\" parando perfettamente il Velo del Sogno dell'Abisso."
  },
  Task_97322_Name = {
    Text = "Una promessa, una veglia: Nascosto"
  },
  Task_97673_Desc = {
    Text = "Completa \"Il Quinto Giorno\" a Difficoltà Follia"
  },
  Task_97674_Desc = {
    Text = "Completa \"Il Primo Giorno\" a Difficoltà Follia"
  },
  Task_97675_Desc = {
    Text = "Completa \"Il Secondo Giorno\" a qualsiasi difficoltà"
  },
  Task_97676_Desc = {
    Text = "Teofania: Completato"
  },
  Task_97677_Desc = {
    Text = "Completa \"Il Settimo Giorno\" a qualsiasi difficoltà"
  },
  Task_97678_Desc = {
    Text = "Il Risvegliatore nel Reame del Caos vince 1 volta nella \"Settimana della Teofania\""
  },
  Task_97679_Desc = {
    Text = "Completa tutti gli obiettivi di \"Teofania: Completato\""
  },
  Task_97680_Desc = {
    Text = "Completa \"Il Secondo Giorno\" a Difficoltà Follia"
  },
  Task_97681_Desc = {
    Text = "Completa \"Il Settimo Giorno\" a Difficoltà Follia"
  },
  Task_97682_Desc = {
    Text = "Completa \"Il Settimo Giorno\" a qualsiasi difficoltà"
  },
  Task_97683_Desc = {
    Text = "Completa \"Il Sesto Giorno\" a qualsiasi difficoltà"
  },
  Task_97684_Desc = {
    Text = "Completa \"Il Primo Giorno\" a qualsiasi difficoltà"
  },
  Task_97685_Desc = {
    Text = "Completa \"Il Terzo Giorno\" a Difficoltà Follia"
  },
  Task_97686_Desc = {
    Text = "Il Risvegliatore nel Reame Ultra vince 1 volta nella \"Settimana della Teofania\""
  },
  Task_97687_Desc = {
    Text = "Il Risvegliatore nel Reame di Caro vince 1 volta nella \"Settimana della Teofania\""
  },
  Task_97688_Desc = {
    Text = "Completa \"Il Quarto Giorno\" a Difficoltà Follia"
  },
  Task_97689_Desc = {
    Text = "Completa \"Il Primo Giorno\" a qualsiasi difficoltà"
  },
  Task_97690_Desc = {
    Text = "Il Risvegliatore nel Reame Ultra vince 2 volte nella \"Settimana della Teofania\""
  },
  Task_97691_Desc = {
    Text = "Completa \"Il Quarto Giorno\" a qualsiasi difficoltà"
  },
  Task_97692_Desc = {
    Text = "Il Risvegliatore nel Reame di Aequor vince 1 volta nella \"Settimana della Teofania\""
  },
  Task_97693_Desc = {
    Text = "Completa \"Il Terzo Giorno\" a qualsiasi difficoltà"
  },
  Task_97694_Desc = {
    Text = "Il Risvegliatore nel Reame del Caos vince 2 volte nella \"Settimana della Teofania\""
  },
  Task_97695_Desc = {
    Text = "Completa \"Il Sesto Giorno\" a qualsiasi difficoltà"
  },
  Task_97696_Desc = {
    Text = "Il Risvegliatore nel Reame di Caro vince 2 volte nella \"Settimana della Teofania\""
  },
  Task_97697_Desc = {
    Text = "Completa \"Il Sesto Giorno\" a Difficoltà Follia"
  },
  Task_97698_Desc = {
    Text = "Teofania: Follia"
  },
  Task_97699_Desc = {
    Text = "Completa \"Il Quarto Giorno\" a qualsiasi difficoltà"
  },
  Task_97700_Desc = {
    Text = "Teofania: Reame"
  },
  Task_97701_Desc = {
    Text = "Il Risvegliatore nel Reame di Aequor vince 2 volte nella \"Settimana della Teofania\""
  },
  Task_97702_Desc = {
    Text = "Completa \"Il Secondo Giorno\" a qualsiasi difficoltà"
  },
  Task_97703_Desc = {
    Text = "Completa \"Il Terzo Giorno\" a qualsiasi difficoltà"
  },
  Task_97704_Desc = {
    Text = "Completa \"Il Quinto Giorno\" a qualsiasi difficoltà"
  },
  Task_97705_Desc = {
    Text = "Completa \"Il Quinto Giorno\" a qualsiasi difficoltà"
  },
  Task_97855_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame di Caro per vincere una volta in \"Novità sotto il Sole\""
  },
  Task_97856_Desc = {
    Text = "Accesso cumulativo per 6 giorni"
  },
  Task_97857_Desc = {
    Text = "Accedi per un totale di 4 giorni"
  },
  Task_97858_Desc = {
    Text = "Completa \"Giardino di Poesie\" a Difficoltà Follia"
  },
  Task_97859_Desc = {
    Text = "Completa il Paesaggio Onirico \"Arrivederci, Terra di Mai\""
  },
  Task_97860_Desc = {
    Text = "Accedi per 3 giorni cumulativi"
  },
  Task_97861_Desc = {
    Text = "Completa tutti gli obiettivi in \"Novità sotto il Sole: Completato\""
  },
  Task_97862_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame del Caos per vincere due volte in \"Novità sotto il Sole\""
  },
  Task_97863_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame di Aequor per vincere una volta in \"Novità sotto il Sole\""
  },
  Task_97864_Desc = {
    Text = "Completa \"Ritorno ai Vecchi Luoghi\" a Difficoltà Follia"
  },
  Task_97865_Desc = {
    Text = "Novità sotto il Sole: Completato"
  },
  Task_97866_Desc = {
    Text = "Novità sotto il Sole: Reame"
  },
  Task_97867_Desc = {
    Text = "Completa \"Fiaba Perfetta\" a Difficoltà Follia"
  },
  Task_97868_Desc = {
    Text = "Completa \"Giardino di Poesie\" a qualsiasi difficoltà"
  },
  Task_97869_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere una volta in \"Novità sotto il Sole\""
  },
  Task_97870_Desc = {
    Text = "Completa \"Sogno di una Macchina\" a qualsiasi difficoltà"
  },
  Task_97871_Desc = {
    Text = "Completa \"Affrontare il Sole Nero\" a Difficoltà Follia"
  },
  Task_97872_Desc = {
    Text = "Completa \"Affrontare il Sole Nero\" a qualsiasi difficoltà"
  },
  Task_97873_Desc = {
    Text = "Completa \"Fiaba Perfetta\" a qualsiasi difficoltà"
  },
  Task_97874_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame di Caro per vincere due volte in \"Novità sotto il Sole\""
  },
  Task_97875_Desc = {
    Text = "Accedi per 5 giorni cumulativi"
  },
  Task_97876_Desc = {
    Text = "Completa \"Ritorno ai Vecchi Luoghi\" a qualsiasi difficoltà"
  },
  Task_97877_Desc = {
    Text = "Accedi per un totale di 7 giorni"
  },
  Task_97878_Desc = {
    Text = "Completa \"Sogno di una Macchina\" a Difficoltà Follia"
  },
  Task_97879_Desc = {
    Text = "Completa \"Affrontare il Sole Nero\" a qualsiasi difficoltà"
  },
  Task_97880_Desc = {
    Text = "Accedi per un totale di 2 giorni"
  },
  Task_97881_Desc = {
    Text = "Completa \"Fiaba Perfetta\" a qualsiasi difficoltà"
  },
  Task_97882_Desc = {
    Text = "Completa \"Sogno di una Macchina\" a qualsiasi difficoltà"
  },
  Task_97883_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame del Caos per vincere una volta in \"Novità sotto il Sole\""
  },
  Task_97884_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_97885_Desc = {
    Text = "Novità sotto il Sole: Follia"
  },
  Task_97886_Desc = {
    Text = "7 giorni di accesso"
  },
  Task_97887_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame Ultra per vincere due volte in \"Novità sotto il Sole\""
  },
  Task_97888_Desc = {
    Text = "Completa \"Ritorno ai Vecchi Luoghi\" a qualsiasi difficoltà"
  },
  Task_97889_Desc = {
    Text = "Usa un qualsiasi Risvegliatore del Reame di Aequor per vincere due volte in \"Novità sotto il Sole\""
  },
  Task_97890_Desc = {
    Text = "Completa \"Giardino di Poesie\" a qualsiasi difficoltà"
  },
  Task_97952_Desc = {
    Text = "Completa il Paesaggio Onirico \"Arrivederci, Terra di Mai\""
  },
  Task_97953_Desc = {
    Text = "Completa 4 Missioni Quotidiane"
  },
  Task_97954_Desc = {
    Text = "Completa il Paesaggio Onirico \"Arrivederci, Terra di Mai\""
  },
  Task_97955_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_97956_Desc = {
    Text = "Supera il Dominio Arcano una volta"
  },
  Task_97957_Desc = {
    Text = "Consuma 1500 Menofina"
  },
  Task_97958_Desc = {
    Text = "Completa 4 Missioni Quotidiane"
  },
  Task_97959_Desc = {
    Text = "Completa 20 Incarichi"
  },
  Task_97960_Desc = {
    Text = "Consuma 1500 Menofina"
  },
  Task_97961_Desc = {
    Text = "Accumula 100000 Certificati Rosa"
  },
  Task_97962_Desc = {
    Text = "Completa 20 Incarichi"
  },
  Task_97963_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_97964_Desc = {
    Text = "I Punti Addestramento della Zona D-Effetto raggiungono 100"
  },
  Task_97965_Desc = {
    Text = "Accumula 100000 Certificati Rosa"
  },
  Task_97966_Desc = {
    Text = "Supera il Dominio Arcano una volta"
  },
  Task_97967_Desc = {
    Text = "Accesso cumulativo per 1 giorno"
  },
  Task_98151_Desc = {
    Text = "Gestazione dell'Abisso: Esclusiva a tempo limitato"
  },
  Task_98347_Desc = {
    Text = "Ottieni 10 vittorie in questa stagione"
  },
  Task_98347_Name = {
    Text = "10 vittorie"
  },
  Task_98348_Desc = {
    Text = "Ottieni un totale di 3 vittorie in questa stagione"
  },
  Task_98348_Name = {Text = "3 vittorie"},
  Task_98349_Desc = {
    Text = "Ottieni un totale di 6 vittorie in questa stagione"
  },
  Task_98349_Name = {Text = "6 vittorie"},
  Task_98350_Desc = {
    Text = "Ottieni 1 vittoria in questa stagione"
  },
  Task_98350_Name = {Text = "1 vittoria"},
  Task_98505_Desc = {
    Text = "Completa l'Immersione Psichica \"Giorno eterno immortale\""
  },
  Task_98505_Name = {
    Text = "L'Idolo Senza Volto si Infrange"
  },
  Task_98700_Desc = {
    Text = "Accedi per un totale di 15 giorni"
  },
  Task_98701_Desc = {
    Text = "Completa 2 Prove Settimanali"
  }
})
return Text_Task
