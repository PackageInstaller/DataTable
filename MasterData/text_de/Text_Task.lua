__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Task = readonly({
  Task_100331_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_100331_Name = {Text = "1 Sieg"},
  Task_100332_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_100332_Name = {Text = "10 Siege"},
  Task_100333_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_100333_Name = {Text = "6 Siege"},
  Task_100334_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_100334_Name = {Text = "3 Siege"},
  Task_100523_Desc = {
    Text = "Vollende das Wandern “Verzerrte Weltzeichnung“"
  },
  Task_100523_Name = {
    Text = "Rhapsodie der Gegenwart"
  },
  Task_100576_Desc = {
    Text = "Für jede 1 Runde Kampf sinkt die Untersuchungsbewertung um 20 Punkte."
  },
  Task_100576_Name = {
    Text = "Zeitstrahl Sanduhr<size=20><color=#747474>Bei jeder Erfahrung von 1 Runde Kampf sinkt die Untersuchungsbewertung um 20 Punkte</color></size>"
  },
  Task_10143_Desc = {
    Text = "Klare innerhalb von 72 insgesamt Runden"
  },
  Task_10143_Name = {
    Text = "Klare innerhalb von 72 insgesamt Runden"
  },
  Task_10144_Desc = {
    Text = "Räume aus innerhalb von 79 Runden"
  },
  Task_10144_Name = {
    Text = "Räume aus innerhalb von 79 Runden"
  },
  Task_10145_Desc = {
    Text = "Vollständig das Level innerhalb von 40 Schritten."
  },
  Task_10145_Name = {
    Text = "Strategische Planung"
  },
  Task_10146_Desc = {
    Text = "Habe nicht mehr als 1 Symptom bei Abschluss"
  },
  Task_10146_Name = {Text = "Refreshing"},
  Task_10147_Desc = {
    Text = "Habe nicht mehr als 1 Symptom bei Abschluss"
  },
  Task_10147_Name = {Text = "Refreshing"},
  Task_10148_Desc = {
    Text = "Räume aus innerhalb von 31 Runden"
  },
  Task_10148_Name = {
    Text = "Räume aus innerhalb von 31 Runden"
  },
  Task_10149_Desc = {
    Text = "Vollständig innerhalb von 40 Runden"
  },
  Task_10149_Name = {
    Text = "Vollständig innerhalb von 40 Runden"
  },
  Task_10150_Desc = {
    Text = "Räume aus innerhalb von 47 Runden"
  },
  Task_10150_Name = {
    Text = "Räume aus innerhalb von 47 Runden"
  },
  Task_10151_Desc = {
    Text = "Räume aus innerhalb von insgesamt 58 Runden"
  },
  Task_10151_Name = {
    Text = "Räume aus innerhalb von insgesamt 58 Runden"
  },
  Task_10152_Desc = {
    Text = "Räume aus innerhalb von 65 Runden"
  },
  Task_10152_Name = {
    Text = "Räume aus innerhalb von 65 Runden"
  },
  Task_10153_Desc = {
    Text = "Eliminiere Auflösungsmonster"
  },
  Task_10153_Name = {Text = "Ziel"},
  Task_10154_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10154_Name = {
    Text = "Perfekter Pass"
  },
  Task_10155_Desc = {
    Text = "Clear die Stufe innerhalb von 18 Zügen."
  },
  Task_10155_Name = {
    Text = "Strategische Planung"
  },
  Task_10156_Desc = {
    Text = "Habe nicht mehr als 3 Symptome bei Abschluss"
  },
  Task_10156_Name = {Text = "Refreshing"},
  Task_10157_Desc = {
    Text = "Habe mindestens 100 Schwarze Siegel bei Abschluss."
  },
  Task_10157_Name = {
    Text = "Für später speichern"
  },
  Task_10158_Desc = {
    Text = "Vollständig die Etappe mit mindestens 2 Chaos-Erweckern"
  },
  Task_10158_Name = {
    Text = "Aufstieg im Chaos"
  },
  Task_10159_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 8 Zügen"
  },
  Task_10159_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10160_Desc = {
    Text = "Habe mindestens 2 Relikte bei Abschluss"
  },
  Task_10160_Name = {
    Text = "Macht der Relikte"
  },
  Task_10161_Desc = {
    Text = "Vollständig die Etappe mit mindestens 2 Chaos-Erweckern"
  },
  Task_10161_Name = {
    Text = "Aufstieg im Chaos"
  },
  Task_10162_Desc = {
    Text = "Wecke alle Erwachten nach Abschluss"
  },
  Task_10162_Name = {
    Text = "Endgültige Ankunft"
  },
  Task_10163_Desc = {
    Text = "Habe mindestens 4 Relikte bei Abschluss"
  },
  Task_10163_Name = {
    Text = "Macht der Relikte"
  },
  Task_10164_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10164_Name = {
    Text = "Vollständig das Level"
  },
  Task_10165_Desc = {
    Text = "Erreiche Affinitätsstufe 5 mit 8 Erwachenden"
  },
  Task_10165_Name = {
    Text = "Perfekter Partner IV"
  },
  Task_10166_Desc = {
    Text = "Erreiche Affinitätsstufe 3 mit 12 Erwachenden"
  },
  Task_10166_Name = {
    Text = "Perfekter Partner V"
  },
  Task_10167_Desc = {
    Text = "Vollständig innerhalb von 45 Zügen"
  },
  Task_10167_Name = {
    Text = "Strategische Planung"
  },
  Task_10168_Desc = {
    Text = "Räume aus innerhalb von 17 Runden"
  },
  Task_10168_Name = {
    Text = "Räume aus innerhalb von 17 Runden"
  },
  Task_10169_Desc = {
    Text = "Hat 20 Wachende"
  },
  Task_10169_Name = {
    Text = "Seite an Seite kämpfen II"
  },
  Task_10170_Desc = {
    Text = "Hat 30 Wachende"
  },
  Task_10170_Name = {
    Text = "Kämpfe Seite an Seite III"
  },
  Task_10171_Desc = {
    Text = "Führe die Erwachungszeremonie 300 Mal durch"
  },
  Task_10171_Name = {
    Text = "Genius Hüter IV"
  },
  Task_10172_Desc = {
    Text = "Hat 10 Wachende"
  },
  Task_10172_Name = {
    Text = "Gemeinsam kämpfen"
  },
  Task_10173_Desc = {
    Text = "Erreiche Affinitätsstufe 5 mit 4 Erwachenden"
  },
  Task_10173_Name = {
    Text = "Perfekte Partner II"
  },
  Task_10174_Desc = {
    Text = "Geldbeutel abrufen"
  },
  Task_10174_Name = {Text = "Ziel"},
  Task_10175_Desc = {
    Text = "Hat 40 Wachende"
  },
  Task_10175_Name = {
    Text = "Kollaborativer Kampf IV"
  },
  Task_10176_Desc = {
    Text = "Erreiche Affinitätslevel 3 mit 4 Erweckten Körpern"
  },
  Task_10176_Name = {
    Text = "Perfekte Partner"
  },
  Task_10177_Desc = {
    Text = "Vervollständige 400 Durchläufe der Ruinen von Ponape"
  },
  Task_10177_Name = {
    Text = "Segnung von Ponape IV"
  },
  Task_10178_Desc = {
    Text = "Vollständig 600 Durchläufe der Bonapé Ruinen"
  },
  Task_10178_Name = {
    Text = "Segnung von Ponape V"
  },
  Task_10179_Desc = {
    Text = "Vervollständige 50 Wurmlochs-Durchläufe"
  },
  Task_10179_Name = {
    Text = "Wurmwächter"
  },
  Task_10180_Desc = {
    Text = "Vollständig 100 Durchläufe des Wurmlochs"
  },
  Task_10180_Name = {
    Text = "Wurm-Dompteur II"
  },
  Task_10181_Desc = {
    Text = "Vervollständige 200 Durchläufe des Wurmlochs"
  },
  Task_10181_Name = {
    Text = "Wurm-Dompteur III"
  },
  Task_10182_Desc = {
    Text = "Vervollständige 400 Durchläufe des Wurmlochs"
  },
  Task_10182_Name = {
    Text = "Wurm-Wächter IV"
  },
  Task_10183_Desc = {
    Text = "Vollständig 600 Durchläufe des Wurm-Nests"
  },
  Task_10183_Name = {
    Text = "Wurmzüchter V"
  },
  Task_10184_Desc = {
    Text = "Klare die transzendente Existenz einmal"
  },
  Task_10184_Name = {
    Text = "Bei verborgener Geburt"
  },
  Task_10185_Desc = {
    Text = "Vollständig 10 transzendente Existenzen"
  },
  Task_10185_Name = {
    Text = "Die Geburt der Geheimnisse II"
  },
  Task_10186_Desc = {
    Text = "Vollständig 25 Durchläufe der Transzendentalen Existenz"
  },
  Task_10186_Name = {
    Text = "Die Geburt der Geheimhaltung III"
  },
  Task_10187_Desc = {
    Text = "Vollständige Ermittlung Ereignis Kapitel 3 \"Achte auf die Hunde\""
  },
  Task_10187_Name = {
    Text = "Sterngeborenes Sprössling"
  },
  Task_10188_Desc = {
    Text = "Vollständig die Herausforderung in bis zu 6 Kämpfen."
  },
  Task_10188_Name = {
    Text = "Präziser Schlag"
  },
  Task_10189_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_10189_Name = {
    Text = "Sicherheit zuerst"
  },
  Task_10190_Desc = {
    Text = "Habe nicht mehr als 1 Symptom bei Abschluss"
  },
  Task_10190_Name = {Text = "Refreshing"},
  Task_10191_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10191_Name = {
    Text = "Perfekter Pass"
  },
  Task_10192_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10192_Name = {
    Text = "Perfekter Pass"
  },
  Task_10193_Desc = {
    Text = "Finde Jenki"
  },
  Task_10193_Name = {Text = "Ziel"},
  Task_10194_Desc = {
    Text = "Clearing Elixier Temperierung Schwierigkeit I"
  },
  Task_10194_Name = {Text = "Quest 3"},
  Task_10195_Desc = {
    Text = "Vollständig 2 Aufgaben"
  },
  Task_10195_Name = {Text = "Quest 2"},
  Task_10196_Desc = {
    Text = "Erwachen insgesamt 40 Mal"
  },
  Task_10196_Name = {Text = "Aufgabe 1"},
  Task_10197_Desc = {
    Text = "Upgrade Kapitel 1 Resonanz 5 Mal"
  },
  Task_10197_Name = {Text = "Quest 5"},
  Task_10198_Desc = {
    Text = "4 Erwecker erreichen Level 10"
  },
  Task_10198_Name = {Text = "Mission 4"},
  Task_10199_Desc = {
    Text = "Vollständig die Etappe mit mindestens 2 Chaos-Erweckern"
  },
  Task_10199_Name = {
    Text = "Aufstieg im Chaos"
  },
  Task_10200_Desc = {
    Text = "Habe nicht mehr als 1 Symptom bei Abschluss"
  },
  Task_10200_Name = {Text = "Refreshing"},
  Task_10201_Desc = {
    Text = "Flucht aus dem Kraftraum"
  },
  Task_10201_Name = {Text = "Ziel"},
  Task_10202_Desc = {
    Text = "Habe mindestens 8 Orison-Karten bei Abschluss"
  },
  Task_10202_Name = {
    Text = "Kraft der Orison"
  },
  Task_10203_Desc = {
    Text = "Vollständig die Etappe mit mindestens 2 Chaos-Erweckern"
  },
  Task_10203_Name = {
    Text = "Aufstieg im Chaos"
  },
  Task_10204_Desc = {
    Text = "Gehe zur Ermittlungsstelle"
  },
  Task_10204_Name = {Text = "Ziel"},
  Task_10205_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 8 Zügen"
  },
  Task_10205_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10206_Desc = {
    Text = "Vollständig die Etappe mit mindestens 2 Chaos-Erweckern"
  },
  Task_10206_Name = {
    Text = "Aufstieg im Chaos"
  },
  Task_10207_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_10207_Name = {
    Text = "Sicherheit zuerst"
  },
  Task_10208_Desc = {
    Text = "Vollständig das Level innerhalb von 35 Schritten"
  },
  Task_10208_Name = {
    Text = "Strategische Planung"
  },
  Task_10209_Desc = {
    Text = "Habe mindestens 4 Relikte bei Abschluss"
  },
  Task_10209_Name = {
    Text = "Macht der Relikte"
  },
  Task_10210_Desc = {
    Text = "Erschöpfen Sie 180 Menophin"
  },
  Task_10210_Name = {
    Text = "Verbraucht Ausdauer"
  },
  Task_10211_Desc = {
    Text = "Beseitige die Kinder, die den Weg blockieren"
  },
  Task_10211_Name = {Text = "Ziel"},
  Task_10212_Desc = {
    Text = "Vollständig alle Aufgaben innerhalb der Phase, um Belohnungen zu erhalten"
  },
  Task_10212_Name = {Text = "Phase eins"},
  Task_10213_Desc = {
    Text = "Daffodil über Dimensionen verfolgen"
  },
  Task_10213_Name = {Text = "Ziel"},
  Task_10215_Desc = {
    Text = "Gewinne die finale Schlacht innerhalb von 6 Zügen"
  },
  Task_10215_Name = {
    Text = "Gewinne die finale Schlacht innerhalb von 6 Zügen"
  },
  Task_10216_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10216_Name = {
    Text = "Vollständig das Level"
  },
  Task_10217_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 15 Zügen mit Stress unter 500."
  },
  Task_10217_Name = {
    Text = "Gewinne die Endschlacht innerhalb von 15 Zügen mit Stress unter 500."
  },
  Task_10218_Desc = {
    Text = "Hat 4 Wachende des Grades 20 Caro"
  },
  Task_10218_Name = {
    Text = "Meister von Caro II"
  },
  Task_10219_Desc = {
    Text = "Folge Murphy"
  },
  Task_10219_Name = {Text = "Ziel"},
  Task_10220_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10220_Name = {
    Text = "Vollständig das Level"
  },
  Task_10221_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10221_Name = {
    Text = "Vollständig das Level"
  },
  Task_10222_Desc = {
    Text = "Spiele insgesamt 50 Karten"
  },
  Task_10223_Desc = {
    Text = "Suche nach Hinweisen für den Schädeljäger"
  },
  Task_10223_Name = {Text = "Ziel"},
  Task_10224_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10224_Name = {
    Text = "Vollständig das Level"
  },
  Task_10226_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10226_Name = {
    Text = "Vollständig das Level"
  },
  Task_10228_Desc = {
    Text = "Auf der Suche nach dem Kapitän"
  },
  Task_10228_Name = {Text = "Ziel"},
  Task_10229_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10229_Name = {
    Text = "Vollständig das Level"
  },
  Task_10230_Desc = {
    Text = "Jagden Sie den \"Höllenhund\""
  },
  Task_10230_Name = {Text = "Ziel"},
  Task_10231_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10231_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10232_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10232_Name = {
    Text = "Vollständig das Level"
  },
  Task_10233_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10233_Name = {
    Text = "Vollständig das Level"
  },
  Task_10234_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10234_Name = {
    Text = "Vollständig das Level"
  },
  Task_10235_Desc = {
    Text = "Ermittle 60 Abyssal-Nachbilder"
  },
  Task_10235_Name = {
    Text = "Ruinen von Aequor III"
  },
  Task_10236_Desc = {
    Text = "Ermittle 30 Abyssal-Nachbilder"
  },
  Task_10236_Name = {
    Text = "Ruinen von Aequor II"
  },
  Task_10237_Desc = {
    Text = "Ermittle 120 Düster-Nachbilder"
  },
  Task_10237_Name = {
    Text = "Chaos-Ruinen IV"
  },
  Task_10238_Desc = {
    Text = "Ermittle das Düster-Nachbild 60 Mal"
  },
  Task_10238_Name = {
    Text = "Chaos-Ruinen III"
  },
  Task_10239_Desc = {
    Text = "Ermittle 15 Abyssal-Nachbilder"
  },
  Task_10239_Name = {
    Text = "Ruinen von Aequor"
  },
  Task_10240_Desc = {
    Text = "Ermittle 240 Düster-Nachbilder"
  },
  Task_10240_Name = {
    Text = "Chaos-Ruinen V"
  },
  Task_10241_Desc = {
    Text = "Vollständig 600 Elixier-Extraktionen"
  },
  Task_10241_Name = {
    Text = "Meister Modulator V"
  },
  Task_10242_Desc = {
    Text = "Vollständig 400 Trankverfeinerungen"
  },
  Task_10242_Name = {
    Text = "Meister Modulator IV"
  },
  Task_10243_Desc = {
    Text = "Ermittle 30 Düster-Nachbilder"
  },
  Task_10243_Name = {
    Text = "Chaos-Ruinen II"
  },
  Task_10244_Desc = {
    Text = "Ermittle 15 Düster-Nachbilder"
  },
  Task_10244_Name = {
    Text = "Ruinen des Chaos"
  },
  Task_10245_Desc = {
    Text = "Schütze Jenkin"
  },
  Task_10245_Name = {Text = "Ziel"},
  Task_10246_Desc = {
    Text = "Wahnsinn Mann Halting Mutationen"
  },
  Task_10246_Name = {Text = "Ziel"},
  Task_10247_Desc = {
    Text = "Vollständig alle Aufgaben innerhalb der Phase, um Belohnungen zu erhalten"
  },
  Task_10247_Name = {Text = "Stufe Drei"},
  Task_10248_Desc = {
    Text = "Finde ein Werkzeug, um die Falltür aufzubrechen"
  },
  Task_10248_Name = {Text = "Ziel"},
  Task_10249_Desc = {
    Text = "Flucht vor Gefahr"
  },
  Task_10249_Name = {Text = "Ziel"},
  Task_10250_Desc = {
    Text = "Vollständig mindestens 2 verschiedene Ereignis-Knoten bis zum Ende des Levels."
  },
  Task_10250_Name = {
    Text = "Knoten auslösen"
  },
  Task_10251_Desc = {
    Text = "Vollständig das Level, ohne das Camp zur HP-Wiederherstellung zu nutzen."
  },
  Task_10251_Name = {
    Text = "Spezielle Wege"
  },
  Task_10252_Desc = {
    Text = "Behalte mindestens 50% HP nach Abschluss des Finalen Kampfes."
  },
  Task_10252_Name = {
    Text = "Endkampf hp"
  },
  Task_10253_Desc = {
    Text = "Klare das Spiel mit mindestens 2 Symptomkarten"
  },
  Task_10253_Name = {Text = "Deckbau"},
  Task_10254_Desc = {
    Text = "Vollständig mit maximal 2 Symptom-Karten"
  },
  Task_10254_Name = {Text = "Deckbau"},
  Task_10255_Desc = {
    Text = "Räume aus mit mindestens 30 Schritten"
  },
  Task_10255_Name = {Text = "Wegplanung"},
  Task_10256_Desc = {
    Text = "Vollständig innerhalb von <25 Schritten>"
  },
  Task_10256_Name = {Text = "Wegplanung"},
  Task_10258_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10258_Name = {
    Text = "Vollständig das Level"
  },
  Task_10259_Desc = {
    Text = "Anzahl der Male, dass ein Zustand durch Befehl entfernt wurde (z.B. erfolgreich zweimal den Schwäche-Effekt aufgehoben)"
  },
  Task_10259_Name = {
    Text = "Kampfeffekt"
  },
  Task_10260_Desc = {
    Text = "Anzahl der Male, dass ein Zustand hinzugefügt wurde (z.B. erfolgreich einmal einen Schwäche-Effekt hinzugefügt)"
  },
  Task_10260_Name = {
    Text = "Kampfeffekt"
  },
  Task_10265_Desc = {
    Text = "Besiege den Schädeljäger"
  },
  Task_10265_Name = {Text = "Ziel"},
  Task_10266_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_10266_Name = {
    Text = "Sicherheit zuerst"
  },
  Task_10267_Desc = {
    Text = "Vollständig die Etappe in bis zu 3 Kämpfen."
  },
  Task_10267_Name = {
    Text = "Präziser Schlag"
  },
  Task_10268_Desc = {
    Text = "Haben Sie mindestens 50 schwarze Siegel bei Abschluss?"
  },
  Task_10268_Name = {
    Text = "Für später speichern"
  },
  Task_10269_Desc = {
    Text = "Habe nicht mehr als 1 Symptom bei Abschluss"
  },
  Task_10269_Name = {Text = "Refreshing"},
  Task_10270_Desc = {
    Text = "Habe mindestens 8 Orison-Karten bei Abschluss"
  },
  Task_10270_Name = {
    Text = "Kraft der Orison"
  },
  Task_10271_Desc = {
    Text = "Vollständig das Level innerhalb von 28 Zügen"
  },
  Task_10271_Name = {
    Text = "Strategische Planung"
  },
  Task_10272_Desc = {
    Text = "Clear das Spiel mit insgesamt 4 oder weniger Exaltierten in allen Kämpfen."
  },
  Task_10272_Name = {
    Text = "Ruhig und elegant"
  },
  Task_10273_Desc = {
    Text = "Wecke alle Erwachten nach Abschluss"
  },
  Task_10273_Name = {
    Text = "Endgültige Ankunft"
  },
  Task_10274_Desc = {
    Text = "Habe mindestens 4 Relikte bei Abschluss"
  },
  Task_10274_Name = {
    Text = "Macht der Relikte"
  },
  Task_10275_Desc = {
    Text = "Räume aus innerhalb von 73 Runden"
  },
  Task_10275_Name = {
    Text = "Räume aus innerhalb von 73 Runden"
  },
  Task_10276_Desc = {
    Text = "Betritt die Schiffskajüte"
  },
  Task_10276_Name = {Text = "Ziel"},
  Task_10277_CompleteCondDesc = {
    Text = "Gesamtzuweisungsniveau>={s1}"
  },
  Task_10277_Desc = {
    Text = [[
Im Bibliothek zu sitzen bringt dir keine weiteren Erwacher.
Geh hinaus, bewege deine Beine und suche nach dieser eins-in-zehntausend Chance in der Natur.]]
  },
  Task_10277_Name = {
    Text = "Mission: Mithril-Spur"
  },
  Task_10278_Desc = {
    Text = "Habe nicht mehr als 1 Symptom bei Abschluss"
  },
  Task_10278_Name = {Text = "Refreshing"},
  Task_10279_Desc = {
    Text = "Vollständig innerhalb von 45 Zügen"
  },
  Task_10279_Name = {
    Text = "Strategische Planung"
  },
  Task_10280_Desc = {
    Text = "Vollständig das Level innerhalb von 30 Schritten"
  },
  Task_10280_Name = {
    Text = "Strategische Planung"
  },
  Task_10281_Desc = {
    Text = "Bilde einen Ultra-Realm-Erwecker auf Stufe 2"
  },
  Task_10281_Name = {
    Text = "Ultra Meisterschaft II"
  },
  Task_10282_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_10282_Name = {
    Text = "Sicherheit zuerst"
  },
  Task_10283_Desc = {
    Text = "Vollständig alle Aufgaben innerhalb der Phase, um Belohnungen zu erhalten"
  },
  Task_10283_Name = {
    Text = "Stufe Fünf"
  },
  Task_10284_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 17 Zügen"
  },
  Task_10284_Name = {
    Text = "Gewinne die Endschlacht innerhalb von 17 Zügen"
  },
  Task_10285_Desc = {
    Text = "Verbrauche 10000000 Goldene Rose"
  },
  Task_10285_Name = {
    Text = "Verschwender V"
  },
  Task_10287_Desc = {
    Text = "Verbrauche 5000000 Goldene Rose"
  },
  Task_10287_Name = {
    Text = "Verschwender IV"
  },
  Task_10288_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 15 Zügen"
  },
  Task_10288_Name = {
    Text = "Gewinne die Endschlacht innerhalb von 15 Zügen"
  },
  Task_10289_Desc = {
    Text = "Vollständig die Etappe in bis zu 5 Kämpfen."
  },
  Task_10289_Name = {
    Text = "Präziser Schlag"
  },
  Task_10290_Desc = {
    Text = "Suche den Klang in der Ecke"
  },
  Task_10290_Name = {Text = "Ziel"},
  Task_10292_Desc = {
    Text = "Kumulativer Login für 90 Tage"
  },
  Task_10292_Name = {
    Text = "Durchhaltevermögen"
  },
  Task_10293_Desc = {
    Text = "Insgesamt für 60 Tage eingeloggt"
  },
  Task_10293_Name = {Text = "Jenseits"},
  Task_10294_Desc = {
    Text = "Vollständig die Etappe mit mindestens 2 Chaos-Erweckern"
  },
  Task_10294_Name = {
    Text = "Aufstieg im Chaos"
  },
  Task_10295_Desc = {
    Text = "Flucht aus den Verstrickungen der geheimnisvollen Frau"
  },
  Task_10295_Name = {Text = "Ziel"},
  Task_10297_Desc = {
    Text = "Vollständig die Etappe mit mindestens 2 Chaos-Erweckern"
  },
  Task_10297_Name = {
    Text = "Aufstieg im Chaos"
  },
  Task_10298_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10298_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10301_Desc = {
    Text = "Höllenhund eliminieren"
  },
  Task_10301_Name = {Text = "Ziel"},
  Task_10302_CompleteCondDesc = {
    Text = "Gesamtzuweisungsniveau>={s1}"
  },
  Task_10302_Desc = {
    Text = "Chaos ist das Gesetz der Natur; Ordnung ist eine menschliche Illusion."
  },
  Task_10302_Name = {
    Text = "Forschung: Blasser Gesang"
  },
  Task_10302_UnlockCondDesc = {
    Text = "Hüter freigeschaltet auf Level 25"
  },
  Task_10303_Desc = {
    Text = "Hüter erreicht Level 35"
  },
  Task_10303_Name = {
    Text = "Hüter Prüfung IV"
  },
  Task_10305_Desc = {
    Text = "Erreiche Affinitätslevel 3 mit 8 Erweckten Wesen"
  },
  Task_10305_Name = {
    Text = "Perfekte Partner III"
  },
  Task_10307_Desc = {
    Text = "Clear Chaos Bereich Riss I"
  },
  Task_10307_Name = {Text = "Quest 5"},
  Task_10308_Desc = {
    Text = "Vollständig jeden Residual Image Test einmal"
  },
  Task_10308_Name = {Text = "Mission 4"},
  Task_10309_Desc = {
    Text = "Clearing Goldticket Suchschwierigkeit I"
  },
  Task_10309_Name = {Text = "Quest 3"},
  Task_10310_Desc = {
    Text = "Erhebe 4 Erwacher auf Level 20"
  },
  Task_10310_Name = {Text = "Quest 2"},
  Task_10311_Desc = {
    Text = "Vollständig \"Phantasmatische Tauchfahrt\" einmal"
  },
  Task_10311_Name = {Text = "Aufgabe 1"},
  Task_10313_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_10313_Name = {
    Text = "Sicherheit zuerst"
  },
  Task_10314_Desc = {
    Text = "Vollständig das Level innerhalb von 30 Schritten"
  },
  Task_10314_Name = {
    Text = "Strategische Planung"
  },
  Task_10315_Desc = {
    Text = "Wecke alle Erwachten nach Abschluss"
  },
  Task_10315_Name = {
    Text = "Endgültige Ankunft"
  },
  Task_10316_Desc = {
    Text = "Vollständig die Etappe mit mindestens 2 Chaos-Erweckern"
  },
  Task_10316_Name = {
    Text = "Aufstieg im Chaos"
  },
  Task_10317_Desc = {
    Text = "Habe nicht mehr als 3 Symptome bei Abschluss"
  },
  Task_10317_Name = {Text = "Refreshing"},
  Task_10318_Desc = {
    Text = "Habe mindestens 3 Relikte bei Abschluss"
  },
  Task_10318_Name = {
    Text = "Macht der Relikte"
  },
  Task_10319_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 8 Zügen"
  },
  Task_10319_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10320_CompleteCondDesc = {
    Text = "Gesamtzuweisungsniveau>={s1}"
  },
  Task_10320_Desc = {
    Text = "Nicht alles, was glänzt, ist Gold, aber es ist sicherlich wertvoll.\nDer Legende nach wurde Mythag von einer abgeschiedenen Gruppe von Alchemisten gegründet, deren Ambitionen weit über bloße Transmutation hinausgingen."
  },
  Task_10320_Name = {
    Text = "Forschung: Formel-Kodex"
  },
  Task_10321_Desc = {
    Text = "Vollständig das Level innerhalb von 33 Schritten"
  },
  Task_10321_Name = {
    Text = "Strategische Planung"
  },
  Task_10322_Desc = {
    Text = "Habe mindestens 5 Relikte bei Abschluss"
  },
  Task_10322_Name = {
    Text = "Macht der Relikte"
  },
  Task_10323_CompleteCondDesc = {
    Text = "Gesamtzuweisungsniveau>={s1}"
  },
  Task_10323_Desc = {
    Text = "Streng genommen sind Erwachte auch eine Form der Silberchip-Technologie.\nDu musst dein Bestes tun, um sicherzustellen, dass sie nicht zurückfallen."
  },
  Task_10323_Name = {
    Text = "Forschung: Braurezept"
  },
  Task_10324_Desc = {
    Text = "Besiege das deformierte Monster im Büro des Dekans"
  },
  Task_10324_Name = {Text = "Ziel"},
  Task_10325_Desc = {
    Text = "Habe mindestens 2 Relikte bei Abschluss"
  },
  Task_10325_Name = {
    Text = "Macht der Relikte"
  },
  Task_10326_Desc = {
    Text = "Habe mindestens 5 Orison-Karten bei Abschluss"
  },
  Task_10326_Name = {
    Text = "Kraft der Orison"
  },
  Task_10327_Desc = {
    Text = "Habe nicht mehr als 2 Symptome bei Abschluss"
  },
  Task_10327_Name = {Text = "Refreshing"},
  Task_10328_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10328_Name = {
    Text = "Vollständig das Level"
  },
  Task_10329_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10329_Name = {
    Text = "Vollständig das Level"
  },
  Task_10330_Desc = {
    Text = "Vollständig das Level innerhalb von 30 Schritten"
  },
  Task_10330_Name = {
    Text = "Strategische Planung"
  },
  Task_10331_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10331_Name = {
    Text = "Vollständig das Level"
  },
  Task_10332_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_10332_Name = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_10333_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10333_Name = {
    Text = "Vollständig das Level"
  },
  Task_10334_Desc = {
    Text = "Upgrade Erweckerfähigkeiten 3 Mal"
  },
  Task_10334_Name = {
    Text = "Arena-Enthusiast (Inaktiv)"
  },
  Task_10335_Desc = {
    Text = "Vollständig das lichtlose Reich VIII (Unvollendet)"
  },
  Task_10336_Desc = {
    Text = "Die Geheimnisse des Asyls aufdecken"
  },
  Task_10336_Name = {Text = "Ziel"},
  Task_10337_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10337_Name = {
    Text = "Perfekter Pass"
  },
  Task_10338_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10338_Name = {
    Text = "Perfekter Pass"
  },
  Task_10339_Desc = {
    Text = "Gewinne die finale Schlacht innerhalb von 7 Zügen"
  },
  Task_10339_Name = {
    Text = "Gewinne die finale Schlacht innerhalb von 7 Zügen"
  },
  Task_10340_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10340_Name = {
    Text = "Perfekter Pass"
  },
  Task_10341_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10341_Name = {
    Text = "Perfekter Pass"
  },
  Task_10342_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10342_Name = {
    Text = "Perfekter Pass"
  },
  Task_10343_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10343_Name = {
    Text = "Perfekter Pass"
  },
  Task_10344_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10344_Name = {
    Text = "Perfekter Pass"
  },
  Task_10345_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10345_Name = {
    Text = "Perfekter Pass"
  },
  Task_10346_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10346_Name = {
    Text = "Perfekter Pass"
  },
  Task_10347_Desc = {
    Text = "Bilde einen Ultra-Realm-Erwecker auf Stufe 3"
  },
  Task_10347_Name = {
    Text = "Ultra Meisterschaft III"
  },
  Task_10348_Desc = {
    Text = "Bilde einen Caro Reich Erwecker auf Stufe 3"
  },
  Task_10348_Name = {
    Text = "Caro Meisterschaft III"
  },
  Task_10349_Desc = {
    Text = "Bilde einen Tiefsee-Realm-Erwecker auf Stufe 3"
  },
  Task_10349_Name = {
    Text = "Aequor-Meisterschaft III"
  },
  Task_10350_Desc = {
    Text = "Bilde 1 Chaos Reich Erwecker auf Stufe 3"
  },
  Task_10350_Name = {
    Text = "Chaos-Meisterschaft III"
  },
  Task_10351_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10351_Name = {
    Text = "Vollständig das Level"
  },
  Task_10352_Desc = {
    Text = "Besitze 4 Level 40 Caro Erwachte"
  },
  Task_10352_Name = {
    Text = "Meister von Caro IV"
  },
  Task_10353_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10353_Name = {
    Text = "Vollständig das Level"
  },
  Task_10354_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10354_Name = {
    Text = "Vollständig das Level"
  },
  Task_10355_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10355_Name = {
    Text = "Vollständig das Level"
  },
  Task_10356_Desc = {
    Text = "Hol Aigis ein"
  },
  Task_10356_Name = {Text = "Ziel"},
  Task_10357_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10357_Name = {
    Text = "Vollständig das Level"
  },
  Task_10358_Desc = {
    Text = "Gewinne die finale Schlacht innerhalb von 3 Zügen"
  },
  Task_10358_Name = {
    Text = "Gewinne die finale Schlacht innerhalb von 3 Zügen"
  },
  Task_10359_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10359_Name = {
    Text = "Vollständig das Level"
  },
  Task_10360_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10360_Name = {
    Text = "Vollständig das Level"
  },
  Task_10361_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10361_Name = {
    Text = "Vollständig das Level"
  },
  Task_10362_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10362_Name = {
    Text = "Vollständig das Level"
  },
  Task_10363_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10363_Name = {
    Text = "Vollständig das Level"
  },
  Task_10364_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10364_Name = {
    Text = "Vollständig das Level"
  },
  Task_10365_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10365_Name = {
    Text = "Vollständig das Level"
  },
  Task_10366_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10366_Name = {
    Text = "Vollständig das Level"
  },
  Task_10367_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10367_Name = {
    Text = "Vollständig das Level"
  },
  Task_10368_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10368_Name = {
    Text = "Vollständig das Level"
  },
  Task_10369_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10369_Name = {
    Text = "Vollständig das Level"
  },
  Task_10370_Desc = {
    Text = "Finde 10 Extraktionspunkte im Hauptgeschichten Kapitel 2 \"@1@2\""
  },
  Task_10370_Desc2 = {
    Text = "Finde 10 Extraktionspunkte im Hauptgeschichten Kapitel 2 \"Im Namen der Wachsskulptur\""
  },
  Task_10370_Name2 = {
    Text = "Flüsternde Schatten II"
  },
  Task_10371_Desc = {
    Text = "Finde 9 Extraktionspunkte im Hauptgeschichten Kapitel 3 \"@1@2\""
  },
  Task_10371_Desc2 = {
    Text = "Finde 9 Extraktionspunkte in der Hauptgeschichte Kapitel 3 \"Achte auf die Hunde\""
  },
  Task_10371_Name2 = {
    Text = "Flüstern des Verborgenen III"
  },
  Task_10372_Desc = {
    Text = "Vollständig 336 Aufgabeneinheiten"
  },
  Task_10372_Name = {
    Text = "Sonderoperation V"
  },
  Task_10373_Desc = {
    Text = "Finde 8 Entnahmepunkte in der Hauptgeschichte Kapitel 1 \"Östliches Geheimnis\""
  },
  Task_10373_Name = {
    Text = "Verborgenes Flüstern"
  },
  Task_10374_Desc = {
    Text = "Vollständig 84 Aufgaben"
  },
  Task_10374_Name = {
    Text = "Sonderoperation III"
  },
  Task_10375_Desc = {
    Text = "Vollständig 168 Aufgaben"
  },
  Task_10375_Name = {
    Text = "Sonderoperation IV"
  },
  Task_10376_Desc = {
    Text = "Vollständig 12 Aufgaben"
  },
  Task_10376_Name = {
    Text = "Sonderoperation"
  },
  Task_10377_Desc = {
    Text = "Vollständig 36 Aufgaben"
  },
  Task_10377_Name = {
    Text = "Sonderoperation II"
  },
  Task_10378_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10378_Name = {
    Text = "Vollständig das Level"
  },
  Task_10379_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10379_Name = {
    Text = "Vollständig das Level"
  },
  Task_10380_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10380_Name = {
    Text = "Vollständig das Level"
  },
  Task_10381_Desc = {
    Text = "Finde 12 Extraktionspunkte im Hauptgeschichten Kapitel 4 \"@1@2\""
  },
  Task_10381_Desc2 = {
    Text = "Finde 12 Extraktionspunkte im Kapitel 4 \"In der Stille\" der Hauptgeschichte."
  },
  Task_10381_Name2 = {
    Text = "Flüstern des Verborgenen IV"
  },
  Task_10382_Desc = {
    Text = "Besitze vier Level 60 Tiefsee Erwecker"
  },
  Task_10382_Name = {
    Text = "Tiefsee Lord VI"
  },
  Task_10384_Desc = {
    Text = "Sammeln Sie mindestens 1000 Schild in einem Zug während des Finalen Kampfes."
  },
  Task_10384_Name = {
    Text = "Übermäßige Verteidigung"
  },
  Task_10385_Desc = {
    Text = "Durch den Durchgang des Bewusstseins und folge Francis"
  },
  Task_10385_Name = {Text = "Ziel"},
  Task_10387_Desc = {
    Text = "Eliminiere die Auflösungs-Mutanten"
  },
  Task_10387_Name = {Text = "Ziel"},
  Task_10388_Desc = {
    Text = "Führe Sarah in den Keller"
  },
  Task_10388_Name = {Text = "Ziel"},
  Task_10390_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10390_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10391_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10391_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10392_Desc = {
    Text = "Flucht aus dem dimensionalen Raum und \"seinem\" Blick"
  },
  Task_10392_Name = {Text = "Ziel"},
  Task_10394_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10394_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10395_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10395_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10396_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10396_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10397_Desc = {
    Text = "Erwecke die benommene Lily"
  },
  Task_10397_Name = {Text = "Ziel"},
  Task_10404_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10404_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10405_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10405_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10406_Desc = {
    Text = "Vollständig die Etappe mit mindestens 2 Chaos-Erweckern"
  },
  Task_10406_Name = {
    Text = "Aufstieg im Chaos"
  },
  Task_10407_Desc = {
    Text = "Durch die dunkle U-Bahn"
  },
  Task_10407_Name = {Text = "Ziel"},
  Task_10409_Desc = {
    Text = "Flucht aus dem Asylum"
  },
  Task_10409_Name = {Text = "Ziel"},
  Task_10413_Desc = {
    Text = "Habe mindestens 4 Relikte bei Abschluss"
  },
  Task_10413_Name = {
    Text = "Macht der Relikte"
  },
  Task_10419_Desc = {
    Text = "Hol Pandia ein"
  },
  Task_10419_Name = {Text = "Ziel"},
  Task_10420_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"In Stille\" auf harter Schwierigkeit"
  },
  Task_10420_Name = {
    Text = "Mama, ich habe keine Schmerzen·Hart"
  },
  Task_10421_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 15 Zügen"
  },
  Task_10421_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10422_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 8 Zügen"
  },
  Task_10422_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10423_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 8 Zügen"
  },
  Task_10423_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10424_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_10424_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10425_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_10425_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10426_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_10426_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10427_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_10427_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10428_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_10428_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10429_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_10429_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10430_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_10430_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10431_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_10431_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10432_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_10432_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10433_Desc = {
    Text = "Vollständig die Herausforderung in bis zu 6 Kämpfen."
  },
  Task_10433_Name = {
    Text = "Präziser Schlag"
  },
  Task_10434_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_10434_Name = {
    Text = "Sicherheit zuerst"
  },
  Task_10435_Desc = {
    Text = "Habe nicht mehr als 1 Symptom bei Abschluss"
  },
  Task_10435_Name = {Text = "Refreshing"},
  Task_10436_Desc = {
    Text = "Hör auf den Forscher"
  },
  Task_10436_Name = {Text = "Ziel"},
  Task_10437_Desc = {
    Text = "Den Keller betreten"
  },
  Task_10437_Name = {Text = "Ziel"},
  Task_10438_Desc = {
    Text = "Vollständig innerhalb von 24 Runden"
  },
  Task_10438_Name = {
    Text = "Vollständig innerhalb von 24 Runden"
  },
  Task_10439_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_10439_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10440_Desc = {
    Text = "Vollständig die Etappe mit mindestens 2 Chaos-Erweckern"
  },
  Task_10440_Name = {
    Text = "Aufstieg im Chaos"
  },
  Task_10441_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10441_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10442_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10442_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10443_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10443_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10444_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10444_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10445_Desc = {
    Text = "Kumulative Ausgaben von 1000 das schwarze Siegel"
  },
  Task_10445_Name = {
    Text = "Schwarzer Beschwörung III"
  },
  Task_10446_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10446_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10447_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10447_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10448_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10448_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10449_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10449_Name = {
    Text = "Vollständig das Level"
  },
  Task_10450_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10450_Name = {
    Text = "Vollständig das Level"
  },
  Task_10451_Desc = {
    Text = "Vollständig 600 Tabu Kodizes"
  },
  Task_10451_Name = {
    Text = "Bündnis-Graveur V"
  },
  Task_10452_Desc = {
    Text = "Vervollständige 400 Tabu-Codizes"
  },
  Task_10452_Name = {
    Text = "Bündnis-Graveur IV"
  },
  Task_10453_Desc = {
    Text = "Vervollständige 200 Tabu-Codizes"
  },
  Task_10453_Name = {
    Text = "Bündnis-Graveur III"
  },
  Task_10454_Desc = {
    Text = "Aktiviere den Effekt des 6-Teile Bündnisses"
  },
  Task_10454_Name = {Text = "Mission 4"},
  Task_10455_Desc = {
    Text = "Vervollständige 50 Tabu-Codizes"
  },
  Task_10455_Name = {
    Text = "Bundesgraveur"
  },
  Task_10456_Desc = {
    Text = "Vervollständige 50 Transzendenten Existenzen"
  },
  Task_10456_Name = {
    Text = "Über die Geburt der Geheimnisse IV"
  },
  Task_10457_Desc = {
    Text = "Finde Lotan"
  },
  Task_10457_Name = {Text = "Ziel"},
  Task_10458_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10458_Name = {
    Text = "Vollständig das Level"
  },
  Task_10459_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10459_Name = {
    Text = "Vollständig das Level"
  },
  Task_10460_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10460_Name = {
    Text = "Vollständig das Level"
  },
  Task_10461_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10461_Name = {
    Text = "Vollständig das Level"
  },
  Task_10462_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10462_Name = {
    Text = "Vollständig das Level"
  },
  Task_10463_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10463_Name = {
    Text = "Vollständig das Level"
  },
  Task_10464_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10464_Name = {
    Text = "Vollständig das Level"
  },
  Task_10465_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10465_Name = {
    Text = "Vollständig das Level"
  },
  Task_10466_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10466_Name = {
    Text = "Vollständig das Level"
  },
  Task_10467_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10467_Name = {
    Text = "Vollständig das Level"
  },
  Task_10468_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10468_Name = {
    Text = "Vollständig das Level"
  },
  Task_10469_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10469_Name = {
    Text = "Vollständig das Level"
  },
  Task_10470_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10470_Name = {
    Text = "Vollständig das Level"
  },
  Task_10471_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10471_Name = {
    Text = "Vollständig das Level"
  },
  Task_10472_Desc = {
    Text = "Vollständig das Hauptuntersuchungskapitel 2: \"Im Namen der Wachskulpturen\""
  },
  Task_10473_CompleteCondDesc = {
    Text = "Gesamtzuweisungsniveau>={s1}"
  },
  Task_10473_Desc = {
    Text = [[
Sie winden sich in unbemerkter Angst.
Unwissend, lichtlos, namenlos.]]
  },
  Task_10473_Name = {
    Text = "Forschung: Scharlachrote Reim"
  },
  Task_10473_UnlockCondDesc = {
    Text = "Hüter freigeschaltet auf Level 25"
  },
  Task_10474_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10474_Name = {
    Text = "Vollständig das Level"
  },
  Task_10475_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10475_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10476_Desc = {
    Text = "Vervollständige 400 Goldticket-Suchen"
  },
  Task_10476_Name = {
    Text = "Prospektor IV"
  },
  Task_10477_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_10477_Name = {
    Text = "Sicherheit zuerst"
  },
  Task_10478_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10478_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10479_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen."
  },
  Task_10479_Name = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen."
  },
  Task_10480_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10480_Name = {
    Text = "Vollständig das Level"
  },
  Task_10481_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10481_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10482_Desc = {
    Text = "Schließen Sie die Hauptuntersuchung Kapitel 4 \"In Stille\" ab"
  },
  Task_10483_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10483_Name = {
    Text = "Vollständig das Level"
  },
  Task_10484_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10484_Name = {
    Text = "Vollständig das Level"
  },
  Task_10485_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10485_Name = {
    Text = "Vollständig das Level"
  },
  Task_10486_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10486_Name = {
    Text = "Vollständig das Level"
  },
  Task_10487_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10487_Name = {
    Text = "Vollständig das Level"
  },
  Task_10488_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10488_Name = {
    Text = "Vollständig das Level"
  },
  Task_10489_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10489_Name = {
    Text = "Vollständig das Level"
  },
  Task_10490_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10490_Name = {
    Text = "Vollständig das Level"
  },
  Task_10492_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10492_Name = {
    Text = "Vollständig das Level"
  },
  Task_10493_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10493_Name = {
    Text = "Vollständig das Level"
  },
  Task_10494_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10494_Name = {
    Text = "Vollständig das Level"
  },
  Task_10495_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10495_Name = {
    Text = "Vollständig das Level"
  },
  Task_10496_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10496_Name = {
    Text = "Vollständig das Level"
  },
  Task_10497_Desc = {
    Text = "Vervollständige 30 phantasmatische Tauchgänge"
  },
  Task_10497_Name = {
    Text = "Tiefer Taucher III"
  },
  Task_10498_Desc = {
    Text = "Vervollständige 60 phantasmatische Tauchgänge"
  },
  Task_10498_Name = {
    Text = "Abgründiger Taucher IV"
  },
  Task_10499_Desc = {
    Text = "Vollständig 1 phantasmales Eintauchen"
  },
  Task_10499_Name = {
    Text = "Tiefseetaucher"
  },
  Task_10500_Desc = {
    Text = "Vervollständige 15 phantasmatischen Tauchgängen"
  },
  Task_10500_Name = {
    Text = "Tiefer Taucher II"
  },
  Task_10501_Desc = {
    Text = "Handel 800 Schaden"
  },
  Task_10501_Name = {
    Text = "Starker Schaden III"
  },
  Task_10502_Desc = {
    Text = "Verursache 1000 Schaden"
  },
  Task_10502_Name = {
    Text = "Starker Schaden IV"
  },
  Task_10503_Desc = {
    Text = "Handel 200 Schaden"
  },
  Task_10503_Name = {
    Text = "Starker Schaden"
  },
  Task_10504_Desc = {
    Text = "Handel 400 Schaden"
  },
  Task_10504_Name = {
    Text = "Starker Schaden II"
  },
  Task_10505_Desc = {
    Text = "Füge 5000 Schaden hinzu"
  },
  Task_10505_Name = {
    Text = "Fataler Schaden V"
  },
  Task_10506_Desc = {
    Text = "Füge dem Feind 500 Stacks Gift zu"
  },
  Task_10506_Name = {
    Text = "Toxicologist"
  },
  Task_10507_Desc = {
    Text = "Stoppe Aigis"
  },
  Task_10507_Name = {Text = "Ziel"},
  Task_10510_Desc = {
    Text = "Verursache 1000 oder mehr Schaden in einer einzelnen Runde während bestimmter Elitekämpfe (X)."
  },
  Task_10510_Name = {
    Text = "Schauerkarneval"
  },
  Task_10511_Desc = {
    Text = "Verwende Exalt 5 Mal in einer einzigen Runde in einem speziellen Kampftyp X"
  },
  Task_10511_Name = {
    Text = "Kettenrausch"
  },
  Task_10512_Desc = {
    Text = "Verwenden Sie die Lagerheilungsfunktion ≤1 Mal während des Durchspiels."
  },
  Task_10512_Name = {
    Text = "Sicheres Haus"
  },
  Task_10513_Desc = {
    Text = "Beim Abschluss eines Levels muss die Erkundungsrate der Karte des Camps größer oder gleich 80 % sein."
  },
  Task_10513_Name = {
    Text = "Augenöffner"
  },
  Task_10514_Desc = {
    Text = "Die Anzahl der Typ X Karten ist kleiner oder gleich 3 beim Abschluss des Levels."
  },
  Task_10514_Name = {
    Text = "Grenze des Immunsystems"
  },
  Task_10515_Desc = {
    Text = "Wenn die Anzahl der Typ-X-Karten beim Aufräumen größer oder gleich 3 ist"
  },
  Task_10515_Name = {
    Text = "Kritischer Zustand"
  },
  Task_10516_Desc = {
    Text = "Hast ≥3 spezifische Typ X Relikte (X Gold)"
  },
  Task_10516_Name = {
    Text = "Goldgräber"
  },
  Task_10517_Desc = {
    Text = "Hast du ≥2 Arten von Orison nach Abschluss (Inspiration und Fortgeschrittene Inspiration gelten als dasselbe)"
  },
  Task_10517_Name = {
    Text = "Orison-Sammler"
  },
  Task_10518_Desc = {
    Text = "Wecke mindestens 2 Erwachte nach Abschluss"
  },
  Task_10518_Name = {
    Text = "Wach auf, wach auf"
  },
  Task_10519_Desc = {
    Text = "Vollständig die Etappe mit mindestens 2 Chaos-Erweckern"
  },
  Task_10519_Name = {
    Text = "Aufstieg im Chaos"
  },
  Task_10520_Desc = {
    Text = "Wehre die angreifenden Gläubigen des Tempellichts ab"
  },
  Task_10520_Name = {Text = "Ziel"},
  Task_10521_Desc = {
    Text = "Zeit gewinnen für das Zeichnen des magischen Kreises"
  },
  Task_10521_Name = {Text = "Ziel"},
  Task_10523_Desc = {
    Text = "Upgrade jede Awakener-Fähigkeit auf Level 3"
  },
  Task_10523_Name = {Text = "Quest 2"},
  Task_10524_Desc = {
    Text = "Vollständige Hauptermittlung Ereignis · Hart 1-8"
  },
  Task_10524_Name = {Text = "Quest 3"},
  Task_10525_Desc = {
    Text = "Erhebe 4 Erwacher auf Level 40"
  },
  Task_10525_Name = {Text = "Aufgabe 1"},
  Task_10526_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10526_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10527_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10527_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10528_Desc = {
    Text = "Vollständig 100 Elixier-Verfeinerungen"
  },
  Task_10528_Name = {
    Text = "Genius Apotheker II"
  },
  Task_10529_Desc = {
    Text = "Clear Chaos Bereich Riss VI"
  },
  Task_10529_Name = {Text = "Quest 5"},
  Task_10530_Desc = {
    Text = "Finaler Kampf gegen Helot"
  },
  Task_10530_Name = {Text = "Ziel"},
  Task_10531_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10531_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10532_Desc = {
    Text = "Vervollständige 200 Goldticket-Suchen"
  },
  Task_10532_Name = {
    Text = "Goldgräber III"
  },
  Task_10533_Desc = {
    Text = "Unterstütze Puppe beim Abwehren der Tempellichtgläubigen"
  },
  Task_10533_Name = {Text = "Ziel"},
  Task_10534_Desc = {
    Text = "Vervollständige 50 Goldticket-Suchen"
  },
  Task_10534_Name = {
    Text = "Goldgräber"
  },
  Task_10535_Desc = {
    Text = "Vollständig 100 Goldvoucher-Ermittlungen"
  },
  Task_10535_Name = {
    Text = "Goldsucher II"
  },
  Task_10536_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10536_Name = {
    Text = "Vollständig das Level"
  },
  Task_10537_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10537_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10538_CompleteCondDesc = {
    Text = "Gesamtzuweisungsniveau>={s1}"
  },
  Task_10538_Desc = {
    Text = "Manchmal ist der Drang zu zerstören der Drang zu erschaffen.\nNimm deinen Pinsel; Kunst benötigt keine Vorbereitung."
  },
  Task_10538_Name = {
    Text = "Mission: Dadaismus"
  },
  Task_10538_UnlockCondDesc = {
    Text = "Freigeschaltet nach Abschluss des Ermittlungsereignisses 1-13"
  },
  Task_10539_Desc = {
    Text = "Vollständig alle Aufgaben innerhalb der Phase, um Belohnungen zu erhalten"
  },
  Task_10539_Name = {Text = "Phase Zwei"},
  Task_10540_Desc = {
    Text = "Vollständig Ermittlung Hauptmission Kapitel 1 \"Östliches Geheimnis\" im Schwierigkeitsgrad Hart"
  },
  Task_10544_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10544_Name = {
    Text = "Perfekter Pass"
  },
  Task_10545_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10545_Name = {
    Text = "Perfekter Pass"
  },
  Task_10546_Desc = {
    Text = "Kumulativer Login für 2 Tage"
  },
  Task_10546_Name = {
    Text = "Hallo, Hüter"
  },
  Task_10547_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10547_Name = {
    Text = "Perfekter Pass"
  },
  Task_10548_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10548_Name = {
    Text = "Perfekter Pass"
  },
  Task_10549_Desc = {
    Text = "Clear Chaos Bereich Riss I"
  },
  Task_10550_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10550_Name = {
    Text = "Perfekter Pass"
  },
  Task_10552_Desc = {
    Text = "Habe mindestens 2 Relikte bei Abschluss"
  },
  Task_10552_Name = {
    Text = "Macht der Relikte"
  },
  Task_10553_Desc = {
    Text = "Habe mindestens 5 Orison-Karten bei Abschluss"
  },
  Task_10553_Name = {
    Text = "Kraft der Orison"
  },
  Task_10554_Desc = {
    Text = "Habe nicht mehr als 2 Symptome bei Abschluss"
  },
  Task_10554_Name = {Text = "Refreshing"},
  Task_10555_Desc = {
    Text = "Vollständig alle Aufgaben in diesem Kapitel, um Belohnungen zu erhalten."
  },
  Task_10555_Name = {
    Text = "Reich Meisterschaft III"
  },
  Task_10556_Desc = {
    Text = "Vollständig das Level innerhalb von 33 Schritten"
  },
  Task_10556_Name = {
    Text = "Strategische Planung"
  },
  Task_10557_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10557_Name = {
    Text = "Perfekter Pass"
  },
  Task_10558_Desc = {
    Text = "Vollständig die Etappe in bis zu 5 Kämpfen."
  },
  Task_10558_Name = {
    Text = "Präziser Schlag"
  },
  Task_10565_CompleteCondDesc = {
    Text = "Gesamtzuweisungsniveau>={s1}"
  },
  Task_10565_Desc = {
    Text = [[
Seine Instinkte, Vernunft und Herz sind in einer kleinen Glasflasche versiegelt.
Die Welt ist ihm nicht mehr wichtig.]]
  },
  Task_10565_Name = {
    Text = "Mission: Dissoziation"
  },
  Task_10565_UnlockCondDesc = {
    Text = "Freigeschaltet nach Abschluss des Ermittlungsereignisses 1-13"
  },
  Task_10571_Desc = {
    Text = "Führe die Erwachungszeremonie 150 Mal durch"
  },
  Task_10571_Name = {
    Text = "Hüter der Genialität III"
  },
  Task_10572_Desc = {
    Text = "Führe die Erwachungszeremonie 100 Mal durch"
  },
  Task_10572_Name = {
    Text = "Hüter der Genialität II"
  },
  Task_10575_Desc = {
    Text = "Bilde einen Caro Reich Erwecker auf Stufe 5"
  },
  Task_10575_Name = {
    Text = "Caro Meisterschaft V"
  },
  Task_10576_Desc = {
    Text = "Bilde einen Tiefsee-Realm-Erwecker auf Stufe 5"
  },
  Task_10576_Name = {
    Text = "Aequor-Meisterschaft V"
  },
  Task_10577_Desc = {
    Text = "Führe die Erwachungszeremonie 50 Mal durch"
  },
  Task_10577_Name = {
    Text = "Genie-Hüter"
  },
  Task_10578_Desc = {
    Text = "Bilde einen Ultra-Realm-Erwecker auf Stufe 5"
  },
  Task_10578_Name = {
    Text = "Ultra Meisterschaft V"
  },
  Task_10579_Desc = {
    Text = "Hat 12 Stufe 9 Bündnisse"
  },
  Task_10579_Name = {
    Text = "Bündnis-Sammler II"
  },
  Task_10580_Desc = {
    Text = "Besitze 6 Level 6 Bündnisse"
  },
  Task_10580_Name = {
    Text = "Bundes-Sammler"
  },
  Task_10581_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10581_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10582_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10582_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10583_Desc = {
    Text = "Verfolge die Überreste von Franciss Spur"
  },
  Task_10583_Name = {Text = "Ziel"},
  Task_10584_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10584_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10585_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10585_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10586_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10586_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10587_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10587_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10588_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10588_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10589_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10589_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10590_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10590_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10591_Desc = {
    Text = "Habe nicht mehr als 3 Symptome bei Abschluss"
  },
  Task_10591_Name = {Text = "Refreshing"},
  Task_10592_Desc = {
    Text = "Re-enter Lai-Asyl"
  },
  Task_10592_Name = {Text = "Ziel"},
  Task_10593_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 15 Zügen"
  },
  Task_10593_Name = {
    Text = "Gewinne die Endschlacht innerhalb von 15 Zügen"
  },
  Task_10595_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10595_Name = {
    Text = "Perfekter Pass"
  },
  Task_10596_Desc = {
    Text = "Flucht aus dem Schneefeld"
  },
  Task_10596_Name = {Text = "Ziel"},
  Task_10597_Desc = {
    Text = "Führen Sie 3 Aufträge aus"
  },
  Task_10597_Name = {
    Text = "Delegation durchführen"
  },
  Task_10598_Desc = {
    Text = "Räume aus innerhalb von 38 Runden"
  },
  Task_10598_Name = {
    Text = "Räume aus innerhalb von 38 Runden"
  },
  Task_10599_Desc = {
    Text = "Verbrauche 2500000 Goldene Rose"
  },
  Task_10599_Name = {
    Text = "Verschwender III"
  },
  Task_10600_Desc = {
    Text = "Logge dich ins Spiel ein"
  },
  Task_10600_Name = {
    Text = "Logge dich ins Spiel ein"
  },
  Task_10601_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10601_Name = {
    Text = "Perfekter Pass"
  },
  Task_10602_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10602_Name = {
    Text = "Vollständig das Level"
  },
  Task_10603_Desc = {
    Text = "Wecke alle Erwachten nach Abschluss"
  },
  Task_10603_Name = {
    Text = "Endgültige Ankunft"
  },
  Task_10604_Desc = {
    Text = "Habe mindestens 4 Relikte bei Abschluss"
  },
  Task_10604_Name = {
    Text = "Macht der Relikte"
  },
  Task_10605_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10605_Name = {
    Text = "Vollständig das Level"
  },
  Task_10606_Desc = {
    Text = "Habe nicht mehr als 1 Symptom bei Abschluss"
  },
  Task_10606_Name = {Text = "Refreshing"},
  Task_10607_Desc = {
    Text = "Habe mindestens 8 Orison-Karten bei Abschluss"
  },
  Task_10607_Name = {
    Text = "Kraft der Orison"
  },
  Task_10608_Desc = {
    Text = "Hüter erreicht Level 25"
  },
  Task_10608_Name = {
    Text = "Hüter Prüfung III"
  },
  Task_10609_Desc = {
    Text = "Clear das Spiel mit insgesamt 4 oder weniger Exaltierten in allen Kämpfen."
  },
  Task_10609_Name = {
    Text = "Ruhig und elegant"
  },
  Task_10610_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10610_Name = {
    Text = "Perfekter Pass"
  },
  Task_10611_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_10611_Name = {
    Text = "Sicherheit zuerst"
  },
  Task_10612_Desc = {
    Text = "Vollständig die Etappe in bis zu 3 Kämpfen."
  },
  Task_10612_Name = {
    Text = "Präziser Schlag"
  },
  Task_10613_Desc = {
    Text = "Haben Sie mindestens 50 schwarze Siegel bei Abschluss?"
  },
  Task_10613_Name = {
    Text = "Für später speichern"
  },
  Task_10614_Desc = {
    Text = "Erreiche Affinitätsstufe 3 mit 16 Erwachenden"
  },
  Task_10614_Name = {
    Text = "Perfekter Partner VII"
  },
  Task_10616_Desc = {
    Text = "Besitze vier Level 40 Tiefsee Erwecker"
  },
  Task_10616_Name = {
    Text = "Tiefsee Lord IV"
  },
  Task_10618_Desc = {
    Text = "Räume aus innerhalb von 48 Zügen"
  },
  Task_10618_Name = {
    Text = "Räume aus innerhalb von 48 Zügen"
  },
  Task_10619_Desc = {
    Text = "Räume aus innerhalb von 53 Runden"
  },
  Task_10619_Name = {
    Text = "Räume aus innerhalb von 53 Runden"
  },
  Task_10620_Desc = {
    Text = "Ermittle 30 Dimensionale Nachbilder"
  },
  Task_10620_Name = {
    Text = "Ultra Ruinen II"
  },
  Task_10621_Desc = {
    Text = "Ermittle 60 Dimensionale Nachbilder"
  },
  Task_10621_Name = {
    Text = "Ultra Ruinen III"
  },
  Task_10622_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10622_Name = {
    Text = "Perfekter Pass"
  },
  Task_10623_Desc = {
    Text = "Ermittle 15 Dimensionale Nachbilder"
  },
  Task_10623_Name = {
    Text = "Ruinen von Ultra"
  },
  Task_10624_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10624_Name = {
    Text = "Perfekter Pass"
  },
  Task_10625_Desc = {
    Text = "Ermittle 120 Fälle von strukturellen Nachbildern"
  },
  Task_10625_Name = {
    Text = "Ruinen von Caro IV"
  },
  Task_10626_Desc = {
    Text = "Ermittle 15 Fälle von organischen Nachbildern"
  },
  Task_10626_Name = {
    Text = "Ruinen von Caro"
  },
  Task_10627_Desc = {
    Text = "Ermittle 30 Fälle von strukturellen Nachbildern"
  },
  Task_10627_Name = {
    Text = "Ruinen von Caro II"
  },
  Task_10628_Desc = {
    Text = "Vollständig die Herausforderung in bis zu 6 Kämpfen."
  },
  Task_10628_Name = {
    Text = "Präziser Schlag"
  },
  Task_10629_Desc = {
    Text = "Ermittle 240 Abyssal-Nachbilder"
  },
  Task_10629_Name = {
    Text = "Aequor Ruinen V"
  },
  Task_10630_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10630_Name = {
    Text = "Perfekter Pass"
  },
  Task_10631_Desc = {
    Text = "Im Spezifischen Kampf X (Normal) töte 3 oder mehr Monster in einem einzigen Zug."
  },
  Task_10631_Name = {Text = "Jagdzeit"},
  Task_10632_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10632_Name = {
    Text = "Perfekter Pass"
  },
  Task_10633_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10633_Name = {
    Text = "Perfekter Pass"
  },
  Task_10634_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10634_Name = {
    Text = "Perfekter Pass"
  },
  Task_10635_Desc = {
    Text = "Habe mindestens 5 Relikte bei Abschluss"
  },
  Task_10635_Name = {
    Text = "Macht der Relikte"
  },
  Task_10636_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10636_Name = {
    Text = "Perfekter Pass"
  },
  Task_10637_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10637_Name = {
    Text = "Perfekter Pass"
  },
  Task_10638_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10638_Name = {
    Text = "Perfekter Pass"
  },
  Task_10639_Desc = {
    Text = "Vollständig alle Aufgaben innerhalb der Phase, um Belohnungen zu erhalten"
  },
  Task_10639_Name = {Text = "Phase vier"},
  Task_10640_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10640_Name = {
    Text = "Perfekter Pass"
  },
  Task_10641_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10641_Name = {
    Text = "Perfekter Pass"
  },
  Task_10642_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10642_Name = {
    Text = "Perfekter Pass"
  },
  Task_10643_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10643_Name = {
    Text = "Perfekter Pass"
  },
  Task_10644_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10644_Name = {
    Text = "Perfekter Pass"
  },
  Task_10645_Desc = {
    Text = "Bilde einen Ultra-Realm-Erwecker auf Stufe 1"
  },
  Task_10645_Name = {
    Text = "Ultra Meisterschaft I"
  },
  Task_10646_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10646_Name = {
    Text = "Vollständig das Level"
  },
  Task_10647_Desc = {
    Text = "Bilde 1 Chaos Reich Erwecker auf Stufe 1"
  },
  Task_10647_Name = {
    Text = "Chaos-Meisterschaft I"
  },
  Task_10648_Desc = {
    Text = "Bilde einen Caro Reich Erwecker auf Stufe 1"
  },
  Task_10648_Name = {
    Text = "Caro Meisterschaft I"
  },
  Task_10649_Desc = {
    Text = "Bilde einen Tiefsee Reich Erwecker auf Stufe 1"
  },
  Task_10649_Name = {
    Text = "Aequor-Meisterschaft I"
  },
  Task_10650_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_10650_Name = {
    Text = "Sicherheit zuerst"
  },
  Task_10651_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10651_Name = {
    Text = "Vollständig das Level"
  },
  Task_10652_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"@1@2\""
  },
  Task_10652_Desc2 = {
    Text = "Vollständig Ermittlungen Ereignis \"Im Namen der Wachs-Skulptur\""
  },
  Task_10652_Name2 = {
    Text = "Rätsel im Wachs"
  },
  Task_10653_Desc = {
    Text = "3 Mal in der Ermittlungsveranstaltung \"Östliches Geheimnis\" resonieren"
  },
  Task_10653_Name = {
    Text = "Echoklang der Dankbarkeit"
  },
  Task_10654_Desc = {
    Text = "Kumulative Anmeldung für 30 Tage"
  },
  Task_10654_Name = {
    Text = "Der Aktivist"
  },
  Task_10656_Desc = {
    Text = "Vollständig das lichtlose Reich VII (Unvollendet)"
  },
  Task_10656_Name = {
    Text = "Der Bildhauer"
  },
  Task_10658_Desc = {
    Text = "Jedes Spiel: 30 Punkte"
  },
  Task_10658_Name = {
    Text = "Sieg im Kampf <size=20><color=#747474>30 Punkte pro Match</color></size>"
  },
  Task_10660_Desc = {Text = "Quietschen"},
  Task_10660_Name = {Text = "Quietschen"},
  Task_10661_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10661_Name = {
    Text = "Vollständig das Level"
  },
  Task_10663_Desc = {
    Text = "7-tägiger kumulativer Login"
  },
  Task_10663_Name = {
    Text = "Frühaufsteher"
  },
  Task_10664_Desc = {
    Text = "Vollständig das Level in unter 50 Zügen"
  },
  Task_10664_Name = {
    Text = "Strategische Planung"
  },
  Task_10665_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_10665_Name = {
    Text = "Sicherheit zuerst"
  },
  Task_10666_Desc = {
    Text = "Vollständig die Etappe in bis zu 7 Kämpfen."
  },
  Task_10666_Name = {
    Text = "Präziser Schlag"
  },
  Task_10667_Desc = {
    Text = "Upgrade 4 Erwecker auf Level 60"
  },
  Task_10667_Name = {Text = "Aufgabe 1"},
  Task_10668_Desc = {
    Text = "Vollständig 20 Offensive Operationen/Defensive Übungen/Kooperative Missionen"
  },
  Task_10668_Name = {
    Text = "Fähigkeitsmaterialbuch (Inaktiv)"
  },
  Task_10669_Desc = {
    Text = "Vollständig die Hauptuntersuchungsphase 10 Mal"
  },
  Task_10669_Name = {
    Text = "Hauptquestbuch (Inaktiv)"
  },
  Task_10670_Desc = {
    Text = "Clear Caro Sümpfe Riss I"
  },
  Task_10671_Desc = {
    Text = "Austausch 3 Mal mit Goldener Rose im Laden"
  },
  Task_10671_Name = {Text = "Goldkauf"},
  Task_10672_Desc = {
    Text = "Wie deine Alumni 10 Mal"
  },
  Task_10672_Name = {
    Text = "Freundliches Like"
  },
  Task_10673_Desc = {
    Text = "Vollständige Transzendente Existenz einmal"
  },
  Task_10673_Name = {
    Text = "Wöchentlicher Boss"
  },
  Task_10674_Desc = {
    Text = "Nehmen Sie an der Traphase 3 Mal teil"
  },
  Task_10674_Name = {Text = "PVP Kampf"},
  Task_10675_Desc = {
    Text = "Schließen Sie die wöchentlichen Prüfungen ab"
  },
  Task_10675_Name = {
    Text = "Wöchentliche Prüfungen"
  },
  Task_10676_Desc = {
    Text = "Verwende Unterstützung 3 Mal"
  },
  Task_10676_Name = {
    Text = "Freund Unterstützung"
  },
  Task_10677_Desc = {
    Text = "Diese Woche haben die angesammelten Punkte für Phantasmagorischer Tauchgang 1800 erreicht."
  },
  Task_10677_Name = {
    Text = "Traumtauchen"
  },
  Task_10678_Desc = {
    Text = "Gewinne 3 Punkte für jedes verbleibende Schwarze Sigil nach Abschluss, bis zu einem Maximum von 600 Punkten."
  },
  Task_10678_Name = {
    Text = "Das Schwarze Sigil <size=20><color=#747474>Jedes verbleibende Schwarze Sigil erzielt am Ende des Laufs 3 Punkte, maximal 600 Punkte</color></size>"
  },
  Task_10679_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 15 Zügen"
  },
  Task_10679_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10680_CompleteCondDesc = {
    Text = "Gesamtzuweisungsniveau>={s1}"
  },
  Task_10680_Desc = {
    Text = "Dimensionen, Raum, Quanten... Vielleicht wirst du nie die tiefgründigen Bedeutungen hinter diesen Worten verstehen. \nSo wie du die meisten Dinge, die in dieser Welt geschehen, nicht verstehen kannst."
  },
  Task_10680_Name = {
    Text = "Forschung: Violetter Gesang"
  },
  Task_10680_UnlockCondDesc = {
    Text = "Hüter freigeschaltet auf Level 25"
  },
  Task_10681_Desc = {
    Text = "Räume aus mit Leben nicht unter 80%"
  },
  Task_10681_Name = {
    Text = "Sicherheit zuerst"
  },
  Task_10682_Desc = {
    Text = "Gewinne die finale Schlacht innerhalb von 25 Zügen"
  },
  Task_10682_Name = {
    Text = "Gewinne die finale Schlacht innerhalb von 25 Zügen"
  },
  Task_10683_Desc = {
    Text = "Bilde 1 Chaos Reich Erwecker auf Stufe 2"
  },
  Task_10683_Name = {
    Text = "Meisterschaft des Chaos II"
  },
  Task_10684_Desc = {
    Text = "In der Untersuchung Veranstaltung \"@1@2\" 8 Mal resoniert"
  },
  Task_10684_Desc2 = {
    Text = "In der Untersuchung \"Achtung vor Hunden\" 8 Mal resoniere"
  },
  Task_10684_Name2 = {
    Text = "Echo der Widerstandskraft III"
  },
  Task_10685_Desc = {
    Text = "Vollständig die Etappe mit mindestens 2 Chaos-Erweckern"
  },
  Task_10685_Name = {
    Text = "Aufstieg im Chaos"
  },
  Task_10686_Desc = {
    Text = "Habe mindestens 3 Relikte bei Abschluss"
  },
  Task_10686_Name = {
    Text = "Macht der Relikte"
  },
  Task_10687_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_10687_Name = {
    Text = "Sicherheit zuerst"
  },
  Task_10688_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_10688_Name = {
    Text = "Sicherheit zuerst"
  },
  Task_10689_Desc = {
    Text = "Vollständig das Level innerhalb von 30 Schritten"
  },
  Task_10689_Name = {
    Text = "Strategische Planung"
  },
  Task_10690_Desc = {
    Text = "Wecke alle Erwachten nach Abschluss"
  },
  Task_10690_Name = {
    Text = "Endgültige Ankunft"
  },
  Task_10691_Desc = {
    Text = "Vollständig die Etappe mit mindestens 2 Chaos-Erweckern"
  },
  Task_10691_Name = {
    Text = "Aufstieg im Chaos"
  },
  Task_10692_Desc = {
    Text = "Vollständig die Etappe mit mindestens 2 Chaos-Erweckern"
  },
  Task_10692_Name = {
    Text = "Aufstieg im Chaos"
  },
  Task_10693_Desc = {
    Text = "Die Quelle der Anomalie eliminieren"
  },
  Task_10693_Name = {Text = "Ziel"},
  Task_10694_Desc = {
    Text = "Wehre die angreifenden Gläubigen des Tempellichts ab"
  },
  Task_10694_Name = {Text = "Ziel"},
  Task_10695_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10695_Name = {
    Text = "Perfekter Pass"
  },
  Task_10696_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10696_Name = {
    Text = "Perfekter Pass"
  },
  Task_10698_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10698_Name = {
    Text = "Perfekter Pass"
  },
  Task_10706_Desc = {
    Text = "Bündnis einmal stärken (Unvollständig)"
  },
  Task_10706_Name = {
    Text = "Zubehör Stärkung (Deaktiviert)"
  },
  Task_10707_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_10707_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10708_Desc = {
    Text = "Vollständig das Level innerhalb von 35 Schritten"
  },
  Task_10708_Name = {
    Text = "Strategische Planung"
  },
  Task_10710_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_10710_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10713_Desc = {
    Text = "Bilde einen Chaos Reich Erwecker auf Stufe 5"
  },
  Task_10713_Name = {
    Text = "Chaos-Meisterschaft V"
  },
  Task_10714_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10714_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10715_Desc = {
    Text = "Die Belagerung brechen"
  },
  Task_10715_Name = {Text = "Ziel"},
  Task_10716_Desc = {
    Text = "Hüter erreicht Level 5"
  },
  Task_10716_Name = {
    Text = "Hüter Prüfung I"
  },
  Task_10717_Desc = {
    Text = "Sammeln Sie mindestens 1500 Schild in einem Zug während des Finalen Kampfes."
  },
  Task_10717_Name = {
    Text = "Übermäßige Verteidigung"
  },
  Task_10720_Desc = {
    Text = "Clear Chaos-Riss VII"
  },
  Task_10720_Name = {Text = "Quest 5"},
  Task_10721_Desc = {
    Text = "Stärke beliebige 6 Bündnisse auf Stufe 12"
  },
  Task_10721_Name = {Text = "Mission 4"},
  Task_10722_Desc = {
    Text = "Habe mindestens 8 Orison-Karten bei Abschluss"
  },
  Task_10722_Name = {
    Text = "Kraft der Orison"
  },
  Task_10723_Desc = {
    Text = "Clear das Spiel mit insgesamt 4 oder weniger Exaltierten in allen Kämpfen."
  },
  Task_10723_Name = {
    Text = "Ruhig und elegant"
  },
  Task_10724_Desc = {
    Text = "Upgrade jede Awakener-Fähigkeit auf Level 4"
  },
  Task_10724_Name = {Text = "Aufgabe 1"},
  Task_10725_Desc = {
    Text = "Sammeln Sie mindestens 2000 Schild in einem Zug während des Finalen Kampfes."
  },
  Task_10725_Name = {
    Text = "Übermäßige Verteidigung"
  },
  Task_10727_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10727_Name = {
    Text = "Perfekter Pass"
  },
  Task_10728_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10728_Name = {
    Text = "Perfekter Pass"
  },
  Task_10729_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10729_Name = {
    Text = "Perfekter Pass"
  },
  Task_10733_CompleteCondDesc = {
    Text = "Gesamtzuweisungsniveau>={s1}"
  },
  Task_10733_Desc = {
    Text = "Das ist die Sprache, in der Gott das Universum schreibt.\nWenn du ihr zuhörst, hörst du die Unendlichkeit."
  },
  Task_10733_Name = {
    Text = "Mission: verblasste Epoche"
  },
  Task_10733_UnlockCondDesc = {
    Text = "Freigeschaltet nach Abschluss des Ermittlungsereignisses 1-13"
  },
  Task_10734_Desc = {
    Text = "Vervollständige 600 Goldschein-Suchen"
  },
  Task_10734_Name = {
    Text = "Goldgräber V"
  },
  Task_10735_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10735_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10736_CompleteCondDesc = {
    Text = "Gesamtzuweisungsniveau>={s1}"
  },
  Task_10736_Desc = {
    Text = "Streng genommen sind Erwachte auch eine Form der Silberchip-Technologie.\nDu musst dein Bestes tun, um sicherzustellen, dass sie nicht zurückfallen."
  },
  Task_10736_Name = {
    Text = "Forschung: Braurezept"
  },
  Task_10737_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10737_Name = {
    Text = "Perfekter Pass"
  },
  Task_10738_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10738_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10739_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10739_Name = {
    Text = "Perfekter Pass"
  },
  Task_10740_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10740_Name = {
    Text = "Perfekter Pass"
  },
  Task_10741_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_10741_Name = {
    Text = "Sicherheit zuerst"
  },
  Task_10742_Desc = {
    Text = "Habe mindestens 2 Relikte bei Abschluss"
  },
  Task_10742_Name = {
    Text = "Macht der Relikte"
  },
  Task_10743_Desc = {
    Text = "Vollständig die Etappe mit mindestens 2 Chaos-Erweckern"
  },
  Task_10743_Name = {
    Text = "Aufstieg im Chaos"
  },
  Task_10744_Desc = {
    Text = "Vollständig die Etappe in bis zu 5 Kämpfen."
  },
  Task_10744_Name = {
    Text = "Präziser Schlag"
  },
  Task_10745_Desc = {
    Text = "Habe nicht mehr als 3 Symptome bei Abschluss"
  },
  Task_10745_Name = {Text = "Refreshing"},
  Task_10746_Desc = {
    Text = "Habe mindestens 100 Schwarze Siegel bei Abschluss."
  },
  Task_10746_Name = {
    Text = "Für später speichern"
  },
  Task_10747_Desc = {
    Text = "Vollständig die Etappe mit mindestens 2 Chaos-Erweckern"
  },
  Task_10747_Name = {
    Text = "Aufstieg im Chaos"
  },
  Task_10748_Desc = {
    Text = "Wecke alle Erwachten nach Abschluss"
  },
  Task_10748_Name = {
    Text = "Endgültige Ankunft"
  },
  Task_10749_Desc = {
    Text = "Habe mindestens 4 Relikte bei Abschluss"
  },
  Task_10749_Name = {
    Text = "Macht der Relikte"
  },
  Task_10750_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10750_Name = {
    Text = "Vollständig das Level"
  },
  Task_10751_Desc = {
    Text = "Klare innerhalb von 88 Runden"
  },
  Task_10751_Name = {
    Text = "Klare innerhalb von 88 Runden"
  },
  Task_10752_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10752_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10753_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 3 Mal Resonanz erzeugt"
  },
  Task_10753_Desc2 = {
    Text = "In der Untersuchung \"Im Namen der Wachs-Skulptur\" 3 Mal resoniere"
  },
  Task_10753_Name2 = {
    Text = "Echos der Krämpfe"
  },
  Task_10754_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 6 Mal Resonanz erzeugt"
  },
  Task_10754_Desc2 = {
    Text = "In der Untersuchung \"Im Namen der Wachs-Skulptur\" 6 Mal resoniere"
  },
  Task_10754_Name2 = {
    Text = "Echo der Krämpfe II"
  },
  Task_10755_Desc = {
    Text = "In der Untersuchung Veranstaltung \"@1@2\" 8 Mal resoniert"
  },
  Task_10755_Desc2 = {
    Text = "In der Untersuchung \"Im Namen der Wachs-Skulptur\" 8 Mal resoniere"
  },
  Task_10755_Name2 = {
    Text = "Konvulsives Echo III"
  },
  Task_10756_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 3 Mal Resonanz erzeugt"
  },
  Task_10756_Desc2 = {
    Text = "In der Untersuchung \"Achtung vor Hunden\" 3 Mal resoniere"
  },
  Task_10756_Name2 = {
    Text = "Echo der Nachsicht"
  },
  Task_10757_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 6 Mal Resonanz erzeugt"
  },
  Task_10757_Desc2 = {
    Text = "In der Untersuchung \"Achtung vor Hunden\" 6 Mal resoniere"
  },
  Task_10757_Name2 = {
    Text = "Echo der Ausdauer II"
  },
  Task_10758_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_10758_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10759_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 10 Mal Resonanz erzeugt"
  },
  Task_10759_Desc2 = {
    Text = "10 Mal in der Ermittlungsveranstaltung „Achtung, Hunde“ resonieren"
  },
  Task_10759_Name2 = {
    Text = "Echos der Resilienz IV"
  },
  Task_10760_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 3 Mal Resonanz erzeugt"
  },
  Task_10760_Desc2 = {
    Text = "In der Untersuchung Veranstaltung \"In der Stille\" 3 Mal resoniert"
  },
  Task_10760_Name2 = {
    Text = "Echo des Schmerzes"
  },
  Task_10761_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 6 Mal Resonanz erzeugt"
  },
  Task_10761_Desc2 = {
    Text = "In der Untersuchung Veranstaltung \"In der Stille\" 6 Mal resoniert"
  },
  Task_10761_Name2 = {
    Text = "Echo des Schmerzes II"
  },
  Task_10762_Desc = {
    Text = "In der Untersuchung Veranstaltung \"@1@2\" 8 Mal resoniert"
  },
  Task_10762_Desc2 = {
    Text = "In der Untersuchung Veranstaltung \"In der Stille\" 8 Mal resoniert"
  },
  Task_10762_Name2 = {
    Text = "Echo der Qual III"
  },
  Task_10763_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_10763_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10764_Desc = {
    Text = "Vollständig \"Aequor\" einmal"
  },
  Task_10764_Name = {
    Text = "Turmauffahrt - Aequor"
  },
  Task_10765_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 15 Zügen"
  },
  Task_10765_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10766_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10766_Name = {
    Text = "Vollständig das Level"
  },
  Task_10767_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10767_Name = {
    Text = "Vollständig das Level"
  },
  Task_10768_Desc = {
    Text = "Besitze vier Level 10 Ultra Erwecker"
  },
  Task_10768_Name = {
    Text = "Herr der Ultra"
  },
  Task_10769_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_10769_Name = {
    Text = "Sicherheit zuerst"
  },
  Task_10770_Desc = {
    Text = "Vollständig alle Aufgaben in diesem Kapitel, um Belohnungen zu erhalten."
  },
  Task_10770_Name = {
    Text = "Reich Meisterschaft V"
  },
  Task_10771_Desc = {
    Text = "Klare das Reich des Chaos einmal"
  },
  Task_10771_Name = {
    Text = "Turmauffahrt - Chaos"
  },
  Task_10772_Desc = {
    Text = "Vollständig die Ultra-Dimension Reise einmal"
  },
  Task_10772_Name = {
    Text = "Turmauffahrt - Ultra"
  },
  Task_10773_Desc = {
    Text = "Klare den Caro-Sumpf einmal"
  },
  Task_10773_Name = {
    Text = "Turmauffahrt - Caro"
  },
  Task_10774_Desc = {
    Text = "Clear die regionale D-Effekt-Zone einmal (Trainingspunkte erreichen 30)"
  },
  Task_10774_Name = {
    Text = "Fusionskatastrophe Sperrzone"
  },
  Task_10775_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10775_Name = {
    Text = "Perfekter Pass"
  },
  Task_10776_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10776_Name = {
    Text = "Perfekter Pass"
  },
  Task_10777_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10777_Name = {
    Text = "Perfekter Pass"
  },
  Task_10778_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10778_Name = {
    Text = "Perfekter Pass"
  },
  Task_10779_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10779_Name = {
    Text = "Perfekter Pass"
  },
  Task_10780_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10780_Name = {
    Text = "Perfekter Pass"
  },
  Task_10781_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10781_Name = {
    Text = "Perfekter Pass"
  },
  Task_10782_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10782_Name = {
    Text = "Perfekter Pass"
  },
  Task_10783_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10783_Name = {
    Text = "Perfekter Pass"
  },
  Task_10784_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10784_Name = {
    Text = "Perfekter Pass"
  },
  Task_10785_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10785_Name = {
    Text = "Perfekter Pass"
  },
  Task_10786_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10786_Name = {
    Text = "Perfekter Pass"
  },
  Task_10787_CompleteCondDesc = {
    Text = "Gesamtzuweisungsniveau>={s1}"
  },
  Task_10787_Desc = {
    Text = "Nicht alles, was glänzt, ist Gold, aber es ist sicherlich wertvoll.\nDer Legende nach wurde Mythag von einer abgeschiedenen Gruppe von Alchemisten gegründet, deren Ambitionen weit über bloße Transmutation hinausgingen."
  },
  Task_10787_Name = {
    Text = "Forschung: Formel-Kodex"
  },
  Task_10789_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10789_Name = {
    Text = "Perfekter Pass"
  },
  Task_10790_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10790_Name = {
    Text = "Perfekter Pass"
  },
  Task_10791_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10791_Name = {
    Text = "Perfekter Pass"
  },
  Task_10792_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10792_Name = {
    Text = "Perfekter Pass"
  },
  Task_10793_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10793_Name = {
    Text = "Perfekter Pass"
  },
  Task_10794_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10794_Name = {
    Text = "Perfekter Pass"
  },
  Task_10795_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10795_Name = {
    Text = "Perfekter Pass"
  },
  Task_10796_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10796_Name = {
    Text = "Perfekter Pass"
  },
  Task_10797_Desc = {
    Text = "Vollständig die Etappe mit mindestens 2 Chaos-Erweckern"
  },
  Task_10797_Name = {
    Text = "Aufstieg im Chaos"
  },
  Task_10798_Desc = {
    Text = "Füge dem Feind 2000 Schichten Gift hinzu"
  },
  Task_10798_Name = {
    Text = "Toxikologie-Experte III"
  },
  Task_10799_Desc = {
    Text = "Wendet 1000 Stapel Gift auf den Feind an"
  },
  Task_10799_Name = {
    Text = "Toxikologie-Experte II"
  },
  Task_10800_Desc = {
    Text = "Zähle 4 Feinde und sichere den Sieg"
  },
  Task_10800_Name = {
    Text = "Rechtfertigte Verteidigung"
  },
  Task_10801_Desc = {
    Text = "Füge dem Feind 5000 Schichten Gift hinzu"
  },
  Task_10801_Name = {
    Text = "Toxikologe IV"
  },
  Task_10802_Desc = {
    Text = "Beim Betreten des Dungeons müssen sich 30 Karten im Deck befinden."
  },
  Task_10802_Name = {
    Text = "Kartensammler"
  },
  Task_10803_Desc = {
    Text = "Besiege 6 Feinde mit kritischem Schaden und sichere den Sieg."
  },
  Task_10803_Name = {
    Text = "Plötzliche Brutalität"
  },
  Task_10804_Desc = {
    Text = "Wegwerfe 30 Karten während eines Kampfes und erreiche den Sieg."
  },
  Task_10804_Name = {
    Text = "Äußerste Arroganz"
  },
  Task_10805_Desc = {
    Text = "Habe 8 Symptomkarten in deinem Deck beim Räumen eines Dungeons."
  },
  Task_10805_Name = {
    Text = "Vom Schicksal verflucht"
  },
  Task_10806_Desc = {
    Text = "Verbrauchen Sie in einer Runde 10 Arithmetica und erzielen Sie den Sieg."
  },
  Task_10806_Name = {
    Text = "Fehlerlose Strategie"
  },
  Task_10807_Desc = {
    Text = "Habe 7 Relikte beim Räumen eines Dungeons"
  },
  Task_10807_Name = {
    Text = "Relikt-Sammler"
  },
  Task_10808_Desc = {
    Text = "Upgrade jede Awakener-Fähigkeit auf Level 5"
  },
  Task_10808_Name = {Text = "Quest 2"},
  Task_10809_Desc = {
    Text = "Bilde einen Chaos Reich Erwecker auf Stufe 4"
  },
  Task_10809_Name = {
    Text = "Chaos-Meisterschaft IV"
  },
  Task_10810_Desc = {
    Text = "Vollständig 10 Bündnis-Transkripte"
  },
  Task_10810_Name = {Text = "Mission 4"},
  Task_10811_Desc = {
    Text = "Clear Chaos-Riss VIII"
  },
  Task_10811_Name = {Text = "Quest 5"},
  Task_10812_Desc = {
    Text = "Bilde einen Ultra-Realm-Erwecker auf Stufe 4"
  },
  Task_10812_Name = {
    Text = "Ultra Meisterschaft IV"
  },
  Task_10814_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10814_Name = {
    Text = "Vollständig das Level"
  },
  Task_10815_Desc = {
    Text = "Habe bis zu 6 Orison-Karten bei Abschluss"
  },
  Task_10815_Name = {
    Text = "Orison unterdrücken"
  },
  Task_10817_Desc = {
    Text = "Vollständig 50 Trankverfeinerungen"
  },
  Task_10817_Name = {
    Text = "Genialer Pharmakologe"
  },
  Task_10818_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10818_Name = {
    Text = "Perfekter Pass"
  },
  Task_10819_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10819_Name = {
    Text = "Perfekter Pass"
  },
  Task_10820_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10820_Name = {
    Text = "Perfekter Pass"
  },
  Task_10821_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10821_Name = {
    Text = "Perfekter Pass"
  },
  Task_10822_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10822_Name = {
    Text = "Perfekter Pass"
  },
  Task_10823_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10823_Name = {
    Text = "Perfekter Pass"
  },
  Task_10824_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10824_Name = {
    Text = "Perfekter Pass"
  },
  Task_10825_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10825_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10826_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10826_Name = {
    Text = "Vollständig das Level"
  },
  Task_10827_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10827_Name = {
    Text = "Perfekter Pass"
  },
  Task_10828_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_10828_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10830_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10830_Name = {
    Text = "Perfekter Pass"
  },
  Task_10831_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10831_Name = {
    Text = "Perfekter Pass"
  },
  Task_10832_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10832_Name = {
    Text = "Vollständig das Level"
  },
  Task_10833_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10833_Name = {
    Text = "Vollständig das Level"
  },
  Task_10834_Desc = {
    Text = "Habe mindestens 10 Orison-Karten bei Abschluss."
  },
  Task_10834_Name = {
    Text = "Kraft der Orison"
  },
  Task_10835_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10835_Name = {
    Text = "Vollständig das Level"
  },
  Task_10836_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 20 Zügen"
  },
  Task_10836_Name = {
    Text = "Gewinne die Endschlacht innerhalb von 20 Zügen"
  },
  Task_10839_Desc = {
    Text = "Vollständig das Level in unter 50 Zügen"
  },
  Task_10839_Name = {
    Text = "Strategische Planung"
  },
  Task_10840_Desc = {
    Text = "Räume aus innerhalb von insgesamt 43 Runden"
  },
  Task_10840_Name = {
    Text = "Räume aus innerhalb von insgesamt 43 Runden"
  },
  Task_10842_Desc = {
    Text = "Vollständig Ermittlung Ereignis \"Vorsicht vor Hunden\" im Schwierigkeitsgrad Hart"
  },
  Task_10842_Name = {
    Text = "Der Bildhauer"
  },
  Task_10844_Desc = {
    Text = "Bilde einen Tiefsee-Realm-Erwecker auf Stufe 2"
  },
  Task_10844_Name = {
    Text = "Aequor-Meisterschaft II"
  },
  Task_10845_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10845_Name = {
    Text = "Vollständig das Level"
  },
  Task_10848_Desc = {
    Text = "Vollständig das Level innerhalb von 24 Schritten"
  },
  Task_10848_Name = {
    Text = "Strategische Planung"
  },
  Task_10852_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10852_Name = {
    Text = "Perfekter Pass"
  },
  Task_10853_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10853_Name = {
    Text = "Vollständig das Level"
  },
  Task_10854_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10854_Name = {
    Text = "Vollständig das Level"
  },
  Task_10855_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10855_Name = {
    Text = "Vollständig das Level"
  },
  Task_10857_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10857_Name = {
    Text = "Vollständig das Level"
  },
  Task_10858_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10858_Name = {
    Text = "Vollständig das Level"
  },
  Task_10859_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10859_Name = {
    Text = "Vollständig das Level"
  },
  Task_10860_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10860_Name = {
    Text = "Vollständig das Level"
  },
  Task_10861_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10861_Name = {
    Text = "Vollständig das Level"
  },
  Task_10862_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10862_Name = {
    Text = "Vollständig das Level"
  },
  Task_10863_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10863_Name = {
    Text = "Vollständig das Level"
  },
  Task_10864_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10864_Name = {
    Text = "Vollständig das Level"
  },
  Task_10865_Desc = {
    Text = "100 Wachzeremonien abgeschlossen"
  },
  Task_10865_Name = {
    Text = "Ziehen Sie Karten"
  },
  Task_10866_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10866_Name = {
    Text = "Vollständig das Level"
  },
  Task_10867_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10867_Name = {
    Text = "Vollständig das Level"
  },
  Task_10868_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10868_Name = {
    Text = "Vollständig das Level"
  },
  Task_10869_Desc = {
    Text = "Clear das Spiel mit insgesamt 4 oder weniger Exaltierten in allen Kämpfen."
  },
  Task_10869_Name = {
    Text = "Ruhig und elegant"
  },
  Task_10870_Desc = {
    Text = "Upgrade Erweckerfähigkeiten 100 Mal"
  },
  Task_10870_Name = {
    Text = "Fähigkeit Meisterschaft IV"
  },
  Task_10871_Desc = {
    Text = "Upgrade Erweckerfähigkeiten 200 Mal"
  },
  Task_10871_Name = {
    Text = "Kunstverfeinerung V"
  },
  Task_10872_Desc = {
    Text = "Besitze vier Level 60 Ultra Erwecker"
  },
  Task_10872_Name = {
    Text = "Ultra Herr VI"
  },
  Task_10873_Desc = {
    Text = "Upgrade Erweckerfähigkeiten 10 Mal"
  },
  Task_10873_Name = {
    Text = "Fähigkeitsschärfung"
  },
  Task_10874_Desc = {
    Text = "Upgrade Erweckerfähigkeiten 20 Mal"
  },
  Task_10874_Name = {
    Text = "Fähigkeit Meisterschaft II"
  },
  Task_10875_Desc = {
    Text = "Upgrade Erweckerfähigkeiten 50 Mal"
  },
  Task_10875_Name = {
    Text = "Fähigkeit Meisterschaft III"
  },
  Task_10876_Desc = {
    Text = "Besitze vier Level 20 Ultra Erwecker"
  },
  Task_10876_Name = {
    Text = "Ultra-Meister II"
  },
  Task_10877_Desc = {
    Text = "Besitze vier Level 30 Ultra Erwecker"
  },
  Task_10877_Name = {
    Text = "Ultra-Dimension III"
  },
  Task_10878_Desc = {
    Text = "Besitze vier Level 40 Ultra Erwecker"
  },
  Task_10878_Name = {
    Text = "Ultra-Dimension Herr IV"
  },
  Task_10879_Desc = {
    Text = "Besitze vier Level 50 Ultra Erwecker"
  },
  Task_10879_Name = {
    Text = "Ultra-Dimension Herr V"
  },
  Task_10880_Desc = {
    Text = "Vollständige Hauptermittlung Ereignis · Hart 2-11"
  },
  Task_10880_Name = {Text = "Quest 3"},
  Task_10881_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_10881_Name = {
    Text = "Sicherheit zuerst"
  },
  Task_10882_Desc = {
    Text = "Vollständig das Level innerhalb von 35 Schritten"
  },
  Task_10882_Name = {
    Text = "Strategische Planung"
  },
  Task_10883_Desc = {
    Text = "Vollständig alle Aufgaben in diesem Kapitel, um Belohnungen zu erhalten."
  },
  Task_10883_Name = {
    Text = "Reich Meisterschaft II"
  },
  Task_10884_Desc = {
    Text = "Habe mindestens 8 Orison-Karten bei Abschluss"
  },
  Task_10884_Name = {
    Text = "Kraft der Orison"
  },
  Task_10885_Desc = {
    Text = "Vollständig die Etappe mit mindestens 2 Chaos-Erweckern"
  },
  Task_10885_Name = {
    Text = "Aufstieg im Chaos"
  },
  Task_10886_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_10886_Name = {
    Text = "Sicherheit zuerst"
  },
  Task_10887_Desc = {
    Text = "Gewinne die erste Schlacht, besiege diese Kinder und fordere deine Besitztümer zurück."
  },
  Task_10887_Name = {
    Text = "Erster Sieg im Kampf"
  },
  Task_10888_Desc = {
    Text = "Vollständig das Level innerhalb von 40 Schritten."
  },
  Task_10888_Name = {
    Text = "Strategische Planung"
  },
  Task_10889_Desc = {
    Text = "Habe bis zu 6 Orison-Karten bei Abschluss"
  },
  Task_10889_Name = {
    Text = "Orison unterdrücken"
  },
  Task_10890_Desc = {
    Text = "Habe mindestens 10 Orison-Karten bei Abschluss."
  },
  Task_10890_Name = {
    Text = "Kraft der Orison"
  },
  Task_10892_Desc = {
    Text = "Vollständig das Level innerhalb von 28 Zügen"
  },
  Task_10892_Name = {
    Text = "Strategische Planung"
  },
  Task_10893_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10893_Name = {
    Text = "Vollständig das Level"
  },
  Task_10894_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10894_Name = {
    Text = "Vollständig das Level"
  },
  Task_10895_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10895_Name = {
    Text = "Vollständig das Level"
  },
  Task_10896_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10896_Name = {
    Text = "Vollständig das Level"
  },
  Task_10897_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10897_Name = {
    Text = "Vollständig das Level"
  },
  Task_10898_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10898_Name = {
    Text = "Vollständig das Level"
  },
  Task_10899_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10899_Name = {
    Text = "Vollständig das Level"
  },
  Task_10900_Desc = {
    Text = "Für jedes 1% Widerstand gegen den Tod, der am Ende des Levels verbleibt, verdienst du 1 Punkt, bis maximal 600 Punkte."
  },
  Task_10900_Name = {
    Text = "Mühelos <size=20><color=#747474>Verdiene 1 Punkt für jeden verbleibenden 1 % Widerstand am Ende, bis zu einem Maximum von 600 Punkten</color></size>"
  },
  Task_10901_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10901_Name = {
    Text = "Vollständig das Level"
  },
  Task_10902_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10902_Name = {
    Text = "Vollständig das Level"
  },
  Task_10904_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 8 Zügen"
  },
  Task_10904_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10905_Desc = {
    Text = "Kampf mit der unterirdischen Wachs-Skulptur"
  },
  Task_10905_Name = {Text = "Ziel"},
  Task_10906_Desc = {
    Text = "Habe nicht mehr als 3 Symptome bei Abschluss"
  },
  Task_10906_Name = {Text = "Refreshing"},
  Task_10907_Desc = {
    Text = "Vollständig die Etappe in bis zu 7 Kämpfen."
  },
  Task_10907_Name = {
    Text = "Präziser Schlag"
  },
  Task_10908_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10908_Name = {
    Text = "Perfekter Pass"
  },
  Task_10909_Desc = {
    Text = "Hüter erreicht Level 15"
  },
  Task_10909_Name = {
    Text = "Hüter Prüfung II"
  },
  Task_10910_Desc = {
    Text = "Resonieren Sie 8 Mal im Untersuchungsereignis \"Ostgeheimnis\""
  },
  Task_10910_Name = {
    Text = "Echo der Dankbarkeit III"
  },
  Task_10911_Desc = {
    Text = "In der Untersuchung \"Ostnebel\" 6 Mal resoniere"
  },
  Task_10911_Name = {
    Text = "Echo der Dankbarkeit II"
  },
  Task_10912_Desc = {
    Text = "Bilde einen Caro Reich Erwecker auf Stufe 2"
  },
  Task_10912_Name = {
    Text = "Caro Meisterschaft II"
  },
  Task_10913_Desc = {
    Text = "Squeak, squeak...!!"
  },
  Task_10913_Name = {Text = "Quietschen"},
  Task_10914_Desc = {
    Text = "Fortfahren zum Büro des Bibliothekars"
  },
  Task_10914_Name = {Text = "Ziel"},
  Task_10915_Desc = {
    Text = "Erreiche Affinitätsstufe 5 mit 12 Erwachenden"
  },
  Task_10915_Name = {
    Text = "Perfekter Partner VI"
  },
  Task_10916_Desc = {
    Text = "Vollständig Ermittlungen Ereignis \"Ostgeheimnis\""
  },
  Task_10916_Name = {Text = "Goldfolie"},
  Task_10917_Desc = {
    Text = "Erreiche Affinitätsstufe 5 mit 16 Erwachenden"
  },
  Task_10917_Name = {
    Text = "Perfekter Partner VIII"
  },
  Task_10918_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"@1@2\""
  },
  Task_10918_Desc2 = {
    Text = "Vollständig Ermittlungen Ereignis \"Achte auf die Hunde\""
  },
  Task_10918_Name2 = {
    Text = "Das Auge jenseits der Dimensionen"
  },
  Task_10919_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10919_Name = {
    Text = "Vollständig das Level"
  },
  Task_10920_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10920_Name = {
    Text = "Vollständig das Level"
  },
  Task_10921_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10921_Name = {
    Text = "Vollständig das Level"
  },
  Task_10922_Desc = {
    Text = "Vervollständige 200 Durchläufe der Ruinen von Bonape"
  },
  Task_10922_Name = {
    Text = "Segnung von Ponape III"
  },
  Task_10923_Desc = {
    Text = "Vollständig 100 Durchläufe der Ruinen von Ponape"
  },
  Task_10923_Name = {
    Text = "Segnung von Bonape II"
  },
  Task_10924_Desc = {
    Text = "Vervollständige 400 Chaos-Cluster"
  },
  Task_10924_Name = {
    Text = "Cluster-Theoretiker IV"
  },
  Task_10925_Desc = {
    Text = "Vervollständige 200 Chaos-Cluster"
  },
  Task_10925_Name = {
    Text = "Cluster-Enthusiast III"
  },
  Task_10926_Desc = {
    Text = "Vervollständige 50 Durchläufe der Ruinen von Ponape"
  },
  Task_10926_Name = {
    Text = "Pohnpei Segen"
  },
  Task_10927_Desc = {
    Text = "Vervollständige 600 Chaos-Cluster"
  },
  Task_10927_Name = {
    Text = "Cluster-Theoretiker V"
  },
  Task_10928_Desc = {
    Text = "Ermittle 240 Dimensionale Nachbilder"
  },
  Task_10928_Name = {
    Text = "Ultra Ruinen V"
  },
  Task_10929_Desc = {
    Text = "Ermittle 120 Dimensionale Nachbilder"
  },
  Task_10929_Name = {
    Text = "Ultra Ruinen IV"
  },
  Task_10931_Desc = {
    Text = "Vervollständige 50 Chaos-Cluster"
  },
  Task_10931_Name = {
    Text = "Cluster-Theoretiker"
  },
  Task_10932_Desc = {
    Text = "Kumulative Ausgaben von 2500 das schwarze Siegel"
  },
  Task_10932_Name = {
    Text = "Schwarze Beschwörung IV"
  },
  Task_10933_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10933_Name = {
    Text = "Perfekter Pass"
  },
  Task_10934_CompleteCondDesc = {
    Text = "Gesamtzuweisungsniveau>={s1}"
  },
  Task_10934_Desc = {
    Text = "Alles Leben kehrt letztendlich zurück zum Meer.\nWie der unaufhörliche Fluss der Zeit, markiert es den Anfang des Endes."
  },
  Task_10934_Name = {
    Text = "Forschung: Azurblauer Klagelaut"
  },
  Task_10934_UnlockCondDesc = {
    Text = "Hüter freigeschaltet auf Level 25"
  },
  Task_10935_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10935_Name = {
    Text = "Perfekter Pass"
  },
  Task_10936_Desc = {
    Text = "Jede Runde: 60 Punkte"
  },
  Task_10936_Name = {
    Text = "Besiege Eliten <size=20><color=#747474>60 Punkte pro Spiel</color></size>"
  },
  Task_10938_Desc = {
    Text = "Hat 18 Stufe 12 Bündnisse"
  },
  Task_10938_Name = {
    Text = "Bündnis-Sammler III"
  },
  Task_10941_Desc = {
    Text = "Wenn kein Erwacher mehr als 1 Karte beim Abschluss hat, erhalte 100 Punkte."
  },
  Task_10941_Name = {
    Text = "Ignoriert <size=20><color=#747474>Vollständig mit nicht mehr als 1 Karte pro Erwacher</color></size>"
  },
  Task_10944_Desc = {
    Text = "Besitze vier Level 20 Aequor Wachmacher"
  },
  Task_10944_Name = {
    Text = "Tiefsee Lord II"
  },
  Task_10946_Desc = {
    Text = "Upgrade 4 Erwecker auf Level 50"
  },
  Task_10946_Name = {Text = "Quest 2"},
  Task_10947_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10947_Name = {
    Text = "Ziel 1: Kopie wartet auf Verpackung"
  },
  Task_10948_Desc = {
    Text = "Untersuche das Asyl"
  },
  Task_10948_Name = {Text = "Ziel"},
  Task_10949_Desc = {
    Text = "Habe nicht mehr als 1 Symptom bei Abschluss"
  },
  Task_10949_Name = {Text = "Refreshing"},
  Task_10951_Desc = {
    Text = "Gewinne 1 Punkt für jede 1 % verbleibendes Leben am Ende des Levels, bis zu einem Maximum von 100 Punkten."
  },
  Task_10951_Name = {
    Text = "Verbleibendes Leben <size=20><color=#747474>1 Punkt pro 1% übrig gebliebenem Leben am Ende, bis zu 100 Punkte</color></size>"
  },
  Task_10953_Desc = {
    Text = "Vollständig das Hauptuntersuchungskapitel 2 \"Im Namen der Wachskulpturen\" auf harter Schwierigkeit"
  },
  Task_10954_Desc = {
    Text = "\"Beruhige\" die wütenden Kinder"
  },
  Task_10954_Name = {Text = "Ziel"},
  Task_10955_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10955_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10956_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_10956_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10957_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_10957_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10958_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10958_Name = {
    Text = "Vollständig das Level"
  },
  Task_10959_Desc = {
    Text = "Vollständig das lichtlose Reich III (Unvollendet)"
  },
  Task_10962_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10962_Name = {
    Text = "Vollständig das Level"
  },
  Task_10963_Desc = {
    Text = "Vollständig das Level innerhalb von 35 Schritten"
  },
  Task_10963_Name = {
    Text = "Strategische Planung"
  },
  Task_10964_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10964_Name = {
    Text = "Ziel-Hinweis: max 8 Zeichen"
  },
  Task_10965_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 15 Zügen"
  },
  Task_10965_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10966_Desc = {
    Text = "Vollständig das Level innerhalb von 40 Schritten."
  },
  Task_10966_Name = {
    Text = "Strategische Planung"
  },
  Task_10969_Desc = {
    Text = "Räume aus mit Leben nicht unter 80%"
  },
  Task_10969_Name = {
    Text = "Sicherheit zuerst"
  },
  Task_10970_Desc = {
    Text = "Bilde einen Tiefsee-Realm-Erwecker auf Stufe 4"
  },
  Task_10970_Name = {
    Text = "Aequor-Meisterschaft IV"
  },
  Task_10971_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 8 Zügen"
  },
  Task_10971_Name = {
    Text = "Schnelle Lösung"
  },
  Task_10972_Desc = {
    Text = "Bilde einen Caro Reich Erwecker auf Stufe 4"
  },
  Task_10972_Name = {
    Text = "Caro Meisterschaft IV"
  },
  Task_10973_Desc = {
    Text = "Vollständig die Etappe in bis zu 7 Kämpfen."
  },
  Task_10973_Name = {
    Text = "Präziser Schlag"
  },
  Task_10974_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10974_Name = {
    Text = "Perfekter Pass"
  },
  Task_10975_CompleteCondDesc = {
    Text = "Gesamtzuweisungsniveau>={s1}"
  },
  Task_10975_Desc = {
    Text = "\"Es wird dein Herz neu schreiben.\"\n\"Ist das so? Dann muss es voller Löcher sein.\""
  },
  Task_10975_Name = {
    Text = "Mission: Bildtherapie"
  },
  Task_10975_UnlockCondDesc = {
    Text = "Freigeschaltet nach Abschluss des Ermittlungsereignisses 1-13"
  },
  Task_10976_Desc = {
    Text = "Vollständige Hauptermittlung Ereignis · Hart 4-12"
  },
  Task_10976_Name = {Text = "Quest 3"},
  Task_10977_Desc = {
    Text = "Räume aus innerhalb von 26 Runden"
  },
  Task_10977_Name = {
    Text = "Räume aus innerhalb von 26 Runden"
  },
  Task_10981_Desc = {
    Text = "Gewinne die finale Schlacht innerhalb von 5 Zügen"
  },
  Task_10981_Name = {
    Text = "Gewinne die finale Schlacht innerhalb von 5 Zügen"
  },
  Task_10982_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10982_Name = {
    Text = "Perfekter Pass"
  },
  Task_10983_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10983_Name = {
    Text = "Perfekter Pass"
  },
  Task_10984_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10984_Name = {
    Text = "Perfekter Pass"
  },
  Task_10985_Desc = {
    Text = "Ermittle 60 Fälle von strukturellen Nachbildern"
  },
  Task_10985_Name = {
    Text = "Ruinen von Caro III"
  },
  Task_10986_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10986_Name = {
    Text = "Perfekter Pass"
  },
  Task_10987_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_10987_Name = {
    Text = "Perfekter Pass"
  },
  Task_10988_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10988_Name = {
    Text = "Vollständig das Level"
  },
  Task_10989_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10989_Name = {
    Text = "Vollständig das Level"
  },
  Task_10991_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10991_Name = {
    Text = "Vollständig das Level"
  },
  Task_10992_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10992_Name = {
    Text = "Vollständig das Level"
  },
  Task_10993_Desc = {
    Text = "Achte auf das, was im Dunkeln lauert"
  },
  Task_10993_Name = {Text = "Ziel"},
  Task_10994_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10994_Name = {
    Text = "Vollständig das Level"
  },
  Task_10995_Desc = {
    Text = "Stufe geräumt"
  },
  Task_10995_Name = {
    Text = "Vollständig das Level"
  },
  Task_10997_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_10997_Name = {
    Text = "Sicherheit zuerst"
  },
  Task_10998_Desc = {
    Text = "Vollständig die Etappe in bis zu 7 Kämpfen."
  },
  Task_10998_Name = {
    Text = "Präziser Schlag"
  },
  Task_10999_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 7 Zügen"
  },
  Task_10999_Name = {
    Text = "Schnelle Lösung"
  },
  Task_11003_Desc = {
    Text = "Habe nicht mehr als 1 Symptom bei Abschluss"
  },
  Task_11003_Name = {Text = "Refreshing"},
  Task_11004_Desc = {
    Text = "Unterstütze Lotan bei der Verfolgung von Feinde"
  },
  Task_11004_Name = {Text = "Ziel"},
  Task_11005_Desc = {
    Text = "Ermittle 120 Abyssal-Nachbilder"
  },
  Task_11005_Name = {
    Text = "Aequor Ruinen IV"
  },
  Task_11006_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_11006_Name = {
    Text = "Perfekter Pass"
  },
  Task_11007_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"@1@2\""
  },
  Task_11007_Desc2 = {
    Text = "Schließen Sie das Ermittlungsereignis \"In Stille\" ab"
  },
  Task_11007_Name2 = {
    Text = "Mama, ich fühle keinen Schmerz"
  },
  Task_11008_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_11008_Name = {
    Text = "Perfekter Pass"
  },
  Task_11009_Desc = {
    Text = "Stufe geräumt"
  },
  Task_11009_Name = {
    Text = "Vollständig das Level"
  },
  Task_11010_Desc = {
    Text = "Kumulative Ausgaben von 5000 das schwarze Siegel"
  },
  Task_11010_Name = {
    Text = "Schwarzer Beschwörung V"
  },
  Task_11011_Desc = {
    Text = "Wenn der verbleibende HP-Prozentsatz beim Aufräumen ≥ 80 beträgt"
  },
  Task_11011_Name = {
    Text = "Kinderspiel"
  },
  Task_11012_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_11012_Name = {
    Text = "Schnelle Lösung"
  },
  Task_11013_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_11013_Name = {
    Text = "Perfekter Pass"
  },
  Task_11014_Desc = {
    Text = "Stärke das Bündnis 3 Mal"
  },
  Task_11014_Name = {
    Text = "Zeitprüfung 2 (Inaktiv)"
  },
  Task_11015_Desc = {
    Text = "Upgrade den Awakener 3 Mal"
  },
  Task_11015_Name = {
    Text = "Zeitprüfung 1 (Inaktiv)"
  },
  Task_11016_Desc = {
    Text = "In spezifischem Kampf X (Elite), erhole ≥ 20 Stapel des Gift-Status (Y)."
  },
  Task_11016_Name = {
    Text = "Suchtpotenzielle Dosis"
  },
  Task_11017_Desc = {
    Text = "Sammeln Sie mindestens 1500 Schild in einem Zug während des Finalen Kampfes."
  },
  Task_11017_Name = {
    Text = "Übermäßige Verteidigung"
  },
  Task_11018_Desc = {
    Text = "Sammeln Sie den Verbrauch von 500 Schwarzen Sigillen"
  },
  Task_11018_Name = {
    Text = "Schwarzer Beschwörung II"
  },
  Task_11019_Desc = {
    Text = "Besitze vier Level 30 Tiefsee Erwecker"
  },
  Task_11019_Name = {
    Text = "Tiefsee Lord III"
  },
  Task_11020_Desc = {
    Text = "Stufe geräumt"
  },
  Task_11020_Name = {
    Text = "Vollständig das Level"
  },
  Task_11021_Desc = {
    Text = "Besitze vier Level 50 Tiefsee Erwecker"
  },
  Task_11021_Name = {
    Text = "Tiefsee Lord V"
  },
  Task_11022_Desc = {
    Text = "Stufe geräumt"
  },
  Task_11022_Name = {
    Text = "Vollständig das Level"
  },
  Task_11023_Desc = {
    Text = "Besitze 4 Level 50 Caro Erwachte"
  },
  Task_11023_Name = {
    Text = "Meister von Caro V"
  },
  Task_11024_Desc = {
    Text = "Sammeln Sie den Verbrauch von 250 Schwarzen Sigillen"
  },
  Task_11024_Name = {
    Text = "Schwarze Beschwörung"
  },
  Task_11025_Desc = {
    Text = "Besitze vier Level 10 Aequor Wachmacher"
  },
  Task_11025_Name = {
    Text = "Herr des Aequor"
  },
  Task_11026_Desc = {
    Text = "Besitze 4 Level 60 Caro Erwachte"
  },
  Task_11026_Name = {
    Text = "Meister von Caro VI"
  },
  Task_11027_Desc = {
    Text = "In spezifischem Kampf X, spiele 20 oder mehr Karten in einem Zug"
  },
  Task_11027_Name = {
    Text = "Kartmeister"
  },
  Task_11029_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 10 Mal Resonanz erzeugt"
  },
  Task_11029_Desc2 = {
    Text = "Resonieren Sie 10 Mal im Untersuchungsereignis \"In Silence\""
  },
  Task_11029_Name2 = {
    Text = "Echos des Schmerzes IV"
  },
  Task_11030_Desc = {
    Text = "Habe mindestens 8 Orison-Karten bei Abschluss"
  },
  Task_11030_Name = {
    Text = "Kraft der Orison"
  },
  Task_11031_Desc = {
    Text = "Stufe geräumt"
  },
  Task_11031_Name = {
    Text = "Vollständig das Level"
  },
  Task_11032_Desc = {
    Text = "In spezifischem Kampf X, ziehe 5 oder mehr Karten in einem Zug"
  },
  Task_11032_Name = {Text = "Zufall"},
  Task_11033_Desc = {
    Text = "Vollständig Ermittlung Ereignis \"Im Namen der Wachskulptur\" im Schwierigkeitsgrad Hart"
  },
  Task_11033_Name = {
    Text = "Mystery in Wachs·Hart"
  },
  Task_11034_Desc = {
    Text = "Narzisse zurückdrängen"
  },
  Task_11034_Name = {Text = "Ziel"},
  Task_11035_Desc = {
    Text = "In spezifischem Kampf X, akkumulieren einen Schildwert von ≥ 200 (X Elite Kampf)"
  },
  Task_11035_Name = {
    Text = "Unbreakable"
  },
  Task_11036_Desc = {
    Text = "Vollständig die Ermittlungsepisode \"Ostgeheimnis\" auf harter Schwierigkeit"
  },
  Task_11036_Name = {
    Text = "Ostnebel·Hart"
  },
  Task_11038_Desc = {
    Text = "Aktiviere den Tod-Widerstand nicht mehr als einmal nach Abschluss."
  },
  Task_11038_Name = {
    Text = "Keine Zeit zu sterben"
  },
  Task_11041_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 8 Zügen"
  },
  Task_11041_Name = {
    Text = "Schnelle Lösung"
  },
  Task_11042_Desc = {
    Text = "Finde Celeste"
  },
  Task_11042_Name = {Text = "Ziel"},
  Task_11043_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_11043_Name = {
    Text = "Perfekter Pass"
  },
  Task_11044_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_11044_Name = {
    Text = "Perfekter Pass"
  },
  Task_11045_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_11045_Name = {
    Text = "Perfekter Pass"
  },
  Task_11046_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_11046_Name = {
    Text = "Perfekter Pass"
  },
  Task_11047_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_11047_Name = {
    Text = "Perfekter Pass"
  },
  Task_11048_Desc = {
    Text = "Vervollständige 100 Tabu-Codizes"
  },
  Task_11048_Name = {
    Text = "Bündnis-Graveur II"
  },
  Task_11050_Desc = {
    Text = "Stufe geräumt"
  },
  Task_11050_Name = {
    Text = "Vollständig das Level"
  },
  Task_11052_Desc = {
    Text = "Ermittle 240 Fälle von strukturellen Nachbildern"
  },
  Task_11052_Name = {
    Text = "Ruinen von Caro V"
  },
  Task_11053_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 18 Zügen"
  },
  Task_11053_Name = {
    Text = "Gewinne die Endschlacht innerhalb von 18 Zügen"
  },
  Task_11054_Desc = {
    Text = "Besucht Harriet's Hütte"
  },
  Task_11054_Name = {Text = "Ziel"},
  Task_11057_Desc = {
    Text = "Vollständig das Level innerhalb von 40 Schritten."
  },
  Task_11057_Name = {
    Text = "Strategische Planung"
  },
  Task_11058_Desc = {
    Text = "Habe nicht mehr als 1 Symptom bei Abschluss"
  },
  Task_11058_Name = {Text = "Refreshing"},
  Task_11059_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_11059_Name = {
    Text = "Schnelle Lösung"
  },
  Task_11060_Desc = {
    Text = "Vollständig 100 Chaos Cluster"
  },
  Task_11060_Name = {
    Text = "Cluster-Theoretiker II"
  },
  Task_11061_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_11061_Name = {
    Text = "Schnelle Lösung"
  },
  Task_11062_Desc = {
    Text = "Hol Murphy ein"
  },
  Task_11062_Name = {Text = "Ziel"},
  Task_11063_Desc = {
    Text = "Finde die Quelle des Geräusches"
  },
  Task_11063_Name = {Text = "Ziel"},
  Task_11064_Desc = {
    Text = "Vielen Dank."
  },
  Task_11064_Name = {Text = "Danke"},
  Task_11065_Desc = {
    Text = "Wehre Harriet ab"
  },
  Task_11065_Name = {Text = "Ziel"},
  Task_11066_Desc = {
    Text = "Vergiss mich nicht, okay?"
  },
  Task_11066_Name = {
    Text = "Vergiss mich nicht, okay?"
  },
  Task_11067_Desc = {
    Text = "Danke euch allen..."
  },
  Task_11067_Name = {
    Text = "Danke euch allen..."
  },
  Task_11068_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 15 Zügen"
  },
  Task_11068_Name = {
    Text = "Schnelle Lösung"
  },
  Task_11069_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_11069_Name = {
    Text = "Perfekter Pass"
  },
  Task_11070_Desc = {
    Text = "Räume aus innerhalb von 16 Gesamt-Runden"
  },
  Task_11070_Name = {
    Text = "Räume aus innerhalb von 16 Gesamt-Runden"
  },
  Task_11071_Desc = {
    Text = "Räume aus innerhalb von 21 Gesamt-Runden"
  },
  Task_11071_Name = {
    Text = "Räume aus innerhalb von 21 Gesamt-Runden"
  },
  Task_11072_Desc = {
    Text = "Räume aus innerhalb von insgesamt 11 Runden"
  },
  Task_11072_Name = {
    Text = "Räume aus innerhalb von insgesamt 11 Runden"
  },
  Task_11073_Desc = {
    Text = "Stufe geräumt"
  },
  Task_11073_Name = {
    Text = "Vollständig das Level"
  },
  Task_11074_Desc = {
    Text = "Stufe geräumt"
  },
  Task_11074_Name = {
    Text = "Vollständig das Level"
  },
  Task_11075_Desc = {
    Text = "Stufe geräumt"
  },
  Task_11075_Name = {
    Text = "Vollständig das Level"
  },
  Task_11076_Desc = {
    Text = "Räume aus innerhalb von 31 Runden"
  },
  Task_11076_Name = {
    Text = "Räume aus innerhalb von 31 Runden"
  },
  Task_11077_Desc = {
    Text = "Besitze vier Level 50 Chaos Erwecker"
  },
  Task_11077_Name = {
    Text = "Herr des Chaos V"
  },
  Task_11078_Desc = {
    Text = "Besitze vier Level 40 Chaos Erwecker"
  },
  Task_11078_Name = {
    Text = "Herr des Chaos IV"
  },
  Task_11079_Desc = {
    Text = "Hat 4 Wachende des Grades 10 Caro"
  },
  Task_11079_Name = {
    Text = "Herr von Caro"
  },
  Task_11080_Desc = {
    Text = "Besitze vier Level 60 Chaos Erwecker"
  },
  Task_11080_Name = {
    Text = "Lord des Chaos VI"
  },
  Task_11081_Desc = {
    Text = "Besitze vier Level 10 Chaos Erwecker"
  },
  Task_11081_Name = {
    Text = "Herr des Chaos"
  },
  Task_11082_Desc = {
    Text = "Besitze vier Level 30 Chaos Erwecker"
  },
  Task_11082_Name = {
    Text = "Herr des Chaos III"
  },
  Task_11083_Desc = {
    Text = "Besitze vier Level 20 Chaos Erwecker"
  },
  Task_11083_Name = {
    Text = "Herr des Chaos II"
  },
  Task_11084_Desc = {
    Text = "Aktiviere den Tod-Widerstand 4 Mal in einem Kampf und erziele in dieser Runde den Sieg."
  },
  Task_11084_Name = {
    Text = "Kampf auf Leben und Tod"
  },
  Task_11085_Desc = {
    Text = "Greife den Feind 15 Mal mit Tentakelangriff in einer Runde an und erreiche den Sieg in diesem Kampf."
  },
  Task_11085_Name = {
    Text = "Meister von Lemuria"
  },
  Task_11086_Desc = {
    Text = "Löse 5 Sprünge während einer Ultra-Drehung aus und erreiche den Sieg."
  },
  Task_11086_Name = {
    Text = "Dimensionsspringer"
  },
  Task_11087_Desc = {
    Text = "Verschlinge 5 Embryonen und erreiche einen Sieg in einer Runde."
  },
  Task_11087_Name = {Text = "Ravenous"},
  Task_11088_Desc = {
    Text = "Gewinne, indem du 15 Karten in einem einzigen Zug spielst"
  },
  Task_11088_Name = {
    Text = "Ich bin dran!"
  },
  Task_11089_Desc = {
    Text = "Spiele 6 Symptom-Karten in einem Zug und gewinne"
  },
  Task_11089_Name = {
    Text = "Kritischer Patient"
  },
  Task_11090_Desc = {
    Text = "Spiele 10 Schlagkarten in einem Zug und erreiche den Sieg."
  },
  Task_11090_Name = {
    Text = "Endloser Schlag"
  },
  Task_11091_Desc = {
    Text = "Gewinne die Schlacht mit insgesamt 8 oder weniger Karten in der Hand, im Ablagestapel und im Nachziehstapel zusammen."
  },
  Task_11091_Name = {
    Text = "Leere Taschen"
  },
  Task_11092_Desc = {
    Text = "Verfolgung \"24\""
  },
  Task_11092_Name = {Text = "Ziel"},
  Task_11094_Desc = {
    Text = "Vollständig Ermittlung Ereignis \"Vorsicht vor Hunden\" im Schwierigkeitsgrad Hart"
  },
  Task_11094_Name = {
    Text = "Auge über Dimensionen · Hart"
  },
  Task_11095_Desc = {
    Text = "Verbrauche 500000 Goldene Rose"
  },
  Task_11095_Name = {
    Text = "Spendthrift"
  },
  Task_11096_Desc = {
    Text = "Verbrauche 1000000 Goldene Rose"
  },
  Task_11096_Name = {
    Text = "Verschwender II"
  },
  Task_11097_Desc = {
    Text = "Sieg im Bosskampf, wodurch 1200 Punkte verdient werden."
  },
  Task_11097_Name = {
    Text = "Besiege den Boss <size=20><color=#747474>Besiege den Bosskampf, um 1200 Punkte zu verdienen</color></size>"
  },
  Task_11098_Desc = {
    Text = "Gewinne die finale Schlacht innerhalb von 9 Zügen"
  },
  Task_11098_Name = {
    Text = "Gewinne die finale Schlacht innerhalb von 9 Zügen"
  },
  Task_11099_Desc = {
    Text = "Rückkehr zum Meister"
  },
  Task_11099_Name = {Text = "Ziel"},
  Task_11100_Desc = {
    Text = "Untersuche die Quelle des Geräuschs"
  },
  Task_11100_Name = {Text = "Ziel"},
  Task_11101_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 8 Zügen"
  },
  Task_11101_Name = {
    Text = "Schnelle Lösung"
  },
  Task_11102_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_11102_Name = {
    Text = "Perfekter Pass"
  },
  Task_11103_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_11103_Name = {
    Text = "Perfekter Pass"
  },
  Task_11104_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 15 Zügen"
  },
  Task_11104_Name = {
    Text = "Schnelle Lösung"
  },
  Task_11105_Desc = {
    Text = "Stufe geräumt"
  },
  Task_11105_Name = {
    Text = "Vollständig das Level"
  },
  Task_11106_Desc = {
    Text = "Besitze 4 Level 30 Caro Erwachte"
  },
  Task_11106_Name = {
    Text = "Meister von Caro III"
  },
  Task_11107_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_11107_Name = {
    Text = "Perfekter Pass"
  },
  Task_11108_Desc = {
    Text = "Finde die Wachsskulptur \"Frühling\""
  },
  Task_11108_Name = {Text = "Ziel"},
  Task_11109_Desc = {
    Text = "Überquere das Deck"
  },
  Task_11109_Name = {Text = "Ziel"},
  Task_11111_Desc = {
    Text = "Stufe geräumt"
  },
  Task_11111_Name = {
    Text = "Vollständig das Level"
  },
  Task_11112_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_11112_Name = {
    Text = "Schnelle Lösung"
  },
  Task_11113_Desc = {
    Text = "Hol den Schädeljäger ein"
  },
  Task_11113_Name = {Text = "Ziel"},
  Task_11114_Desc = {
    Text = "Gewinne die finale Schlacht innerhalb von 8 Zügen"
  },
  Task_11114_Name = {
    Text = "Gewinne die finale Schlacht innerhalb von 8 Zügen"
  },
  Task_11115_Desc = {
    Text = "Räume aus innerhalb von insgesamt 58 Runden"
  },
  Task_11115_Name = {
    Text = "Räume aus innerhalb von insgesamt 58 Runden"
  },
  Task_11116_Desc = {
    Text = "Schließen Sie eine tägliche Aufgabe ab"
  },
  Task_11116_Name = {
    Text = "Tägliche Herausforderungen"
  },
  Task_11117_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_11117_Name = {
    Text = "Perfekter Pass"
  },
  Task_11118_Desc = {
    Text = "Stufe geräumt"
  },
  Task_11118_Name = {
    Text = "Vollständig das Level"
  },
  Task_11119_Desc = {
    Text = "Eliminiere den aufgelösten Körper"
  },
  Task_11119_Name = {Text = "Ziel"},
  Task_11120_Desc = {
    Text = "Stufe geräumt"
  },
  Task_11120_Name = {
    Text = "Vollständig das Level"
  },
  Task_11121_Desc = {
    Text = "Steige ins Rettungsboot"
  },
  Task_11121_Name = {Text = "Ziel"},
  Task_11122_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_11122_Name = {
    Text = "Schnelle Lösung"
  },
  Task_11123_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_11123_Name = {
    Text = "Schnelle Lösung"
  },
  Task_11124_Desc = {
    Text = "Stufe geräumt"
  },
  Task_11124_Name = {
    Text = "Vollständig das Level"
  },
  Task_11125_Desc = {
    Text = "Vollständig alle Aufgaben in diesem Kapitel, um Belohnungen zu erhalten."
  },
  Task_11125_Name = {
    Text = "Reich Meisterschaft IV"
  },
  Task_11126_Desc = {
    Text = "Vollständig 200 Elixier-Verfeinerungen"
  },
  Task_11126_Name = {
    Text = "Meister Modulator III"
  },
  Task_11128_Desc = {
    Text = "Nutze nicht die Notfall-Gnosis zum Reinigen"
  },
  Task_11128_Name = {
    Text = "Ein-Leben-clear  <size=20><color=#747474>Ohne Nutzung der Notfall-Gnosis beenden</color></size>"
  },
  Task_11129_Desc = {
    Text = "Kehren Sie zur Theke zurück und finden Sie Pandia."
  },
  Task_11129_Name = {Text = "Ziel"},
  Task_11130_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_11130_Name = {
    Text = "Perfekter Pass"
  },
  Task_11135_Desc = {
    Text = "Entkomme von Miryam"
  },
  Task_11135_Name = {Text = "Ziel"},
  Task_11136_Desc = {
    Text = "Insgesamt 6 mal die Fähigkeiten des Erwachers verbessert"
  },
  Task_11136_Name = {Text = "Mission 4"},
  Task_11137_Desc = {
    Text = "Vollständig 1 transzendente Existenz"
  },
  Task_11137_Name = {Text = "Quest 5"},
  Task_11138_Desc = {
    Text = "Führe einmal eine Materialsynthese in der Alchemie durch."
  },
  Task_11138_Name = {Text = "Aufgabe 1"},
  Task_11139_Desc = {
    Text = "Upgrade 4 Erwecker auf Level 30"
  },
  Task_11139_Name = {Text = "Quest 2"},
  Task_11140_Desc = {
    Text = "Clear Chaos-Riss IV"
  },
  Task_11140_Name = {Text = "Quest 3"},
  Task_11141_Desc = {
    Text = "Räume aus innerhalb von 39 Runden"
  },
  Task_11141_Name = {
    Text = "Räume aus innerhalb von 39 Runden"
  },
  Task_11142_Desc = {
    Text = "Räume aus innerhalb von 33 Runden"
  },
  Task_11142_Name = {
    Text = "Räume aus innerhalb von 33 Runden"
  },
  Task_11143_Desc = {
    Text = "Räume aus innerhalb von 54 Gesamt-Runden"
  },
  Task_11143_Name = {
    Text = "Räume aus innerhalb von 54 Gesamt-Runden"
  },
  Task_11144_Desc = {
    Text = "Räume aus innerhalb von 48 Zügen"
  },
  Task_11144_Name = {
    Text = "Räume aus innerhalb von 48 Zügen"
  },
  Task_11145_Desc = {
    Text = "Räume aus innerhalb von 14 Gesamt-Runden"
  },
  Task_11145_Name = {
    Text = "Räume aus innerhalb von 14 Gesamt-Runden"
  },
  Task_11146_Desc = {
    Text = "Vollständig das Level in unter 50 Zügen"
  },
  Task_11146_Name = {
    Text = "Strategische Planung"
  },
  Task_11147_Desc = {
    Text = "Räume aus innerhalb von 26 Runden"
  },
  Task_11147_Name = {
    Text = "Räume aus innerhalb von 26 Runden"
  },
  Task_11148_Desc = {
    Text = "Klare innerhalb von 20 Runden"
  },
  Task_11148_Name = {
    Text = "Klare innerhalb von 20 Runden"
  },
  Task_11149_Desc = {
    Text = "Stufe geräumt"
  },
  Task_11149_Name = {
    Text = "Vollständig das Level"
  },
  Task_11150_Desc = {
    Text = "Räume aus innerhalb von 66 Runden"
  },
  Task_11150_Name = {
    Text = "Räume aus innerhalb von 66 Runden"
  },
  Task_11151_Desc = {
    Text = "Vollständig innerhalb von 60 Runden"
  },
  Task_11151_Name = {
    Text = "Vollständig innerhalb von 60 Runden"
  },
  Task_11152_Desc = {
    Text = "Vollständig alle Aufgaben innerhalb der Phase, um Belohnungen zu erhalten"
  },
  Task_11152_Name = {
    Text = "Stufe Sechs"
  },
  Task_11153_Desc = {
    Text = "Vollständig alle Aufgaben in diesem Kapitel, um Belohnungen zu erhalten."
  },
  Task_11153_Name = {
    Text = "Reich Meisterschaft I"
  },
  Task_11154_Desc = {
    Text = "Stufe geräumt"
  },
  Task_11154_Name = {
    Text = "Vollständig das Level"
  },
  Task_11155_Desc = {
    Text = "Habe nicht mehr als 3 Symptome bei Abschluss"
  },
  Task_11155_Name = {Text = "Refreshing"},
  Task_11156_Desc = {
    Text = "Vollständig Kapitel 1 der Hauptermittlung \"Ost Geheimnis\""
  },
  Task_11157_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_11157_Name = {
    Text = "Perfekter Pass"
  },
  Task_116471_Desc = {
    Text = "Mit einem Aequor-Reich-Erwecker zweimal im “Verschmelzendes Schmerzblut“ gewinnen"
  },
  Task_116472_Desc = {
    Text = "Abschluss von “Die Erhebung des Windes“ in beliebigem Modus"
  },
  Task_116473_Desc = {
    Text = "Verschmelzendes Schmerzblut·Abschluss"
  },
  Task_116474_Desc = {
    Text = "Abschluss “Zwillingsflügel“ im Wahnsinnsmodus"
  },
  Task_116475_Desc = {
    Text = "Abschluss “Abenteuermärchen“ beliebiger Schwierigkeitsgrad"
  },
  Task_116476_Desc = {
    Text = "Abgeschlossen der Abweichenden Traumwelt “Jenseits des Horizonts·unter“"
  },
  Task_116477_Desc = {
    Text = "Mit einem Ultra-Reich-Erwecker im “Verschmelzendes Schmerzblut“ einmal gewinnen"
  },
  Task_116478_Desc = {
    Text = "Abschluss von “Vergessensgift“ in beliebigem Modus"
  },
  Task_116479_Desc = {
    Text = "Abschluss “Naive Zeit“ beliebiger Schwierigkeitsgrad"
  },
  Task_116480_Desc = {
    Text = "Mit einem Chaos-Reich-Erwecker zweimal im “Verschmelzendes Schmerzblut“ gewinnen"
  },
  Task_116481_Desc = {
    Text = "Alle Erfolge von “Verschmelzendes Schmerzblut·Abschluss“ abschließen"
  },
  Task_116482_Desc = {
    Text = "Abschluss von “Naive Zeit“ im Wahnsinnsmodus"
  },
  Task_116483_Desc = {
    Text = "Abgeschlossen “Stille Erwachen“ beliebiger Schwierigkeitsgrad"
  },
  Task_116484_Desc = {
    Text = "Abschluss “Altes Konto“ beliebiger Schwierigkeitsgrad"
  },
  Task_116485_Desc = {
    Text = "Abschluss “Altes Konto“ beliebiger Schwierigkeitsgrad"
  },
  Task_116486_Desc = {
    Text = "Verschmelzendes Schmerzblut·Wahnsinn"
  },
  Task_116487_Desc = {
    Text = "Mit einem Aequor-Reich Erwecker einmal im “Verschmelzendes Schmerzblut“ gewinnen"
  },
  Task_116488_Desc = {
    Text = "Verschmelzendes Schmerzblut·Reich"
  },
  Task_116489_Desc = {
    Text = "Abschluss “Zwillingsflügel“ beliebiger Schwierigkeitsgrad"
  },
  Task_116490_Desc = {
    Text = "Abschluss von “Vergessensgift“ in beliebigem Modus"
  },
  Task_116491_Desc = {
    Text = "Abgeschlossen “Abenteuermärchen“ im Wahnsinnsmodus"
  },
  Task_116492_Desc = {
    Text = "Abschluss “Altes Konto“ Wahnsinn-Schwierigkeitsgrad"
  },
  Task_116493_Desc = {
    Text = "Abgeschlossen von “Die Erhebung des Windes“ in beliebiger Schwierigkeit"
  },
  Task_116494_Desc = {
    Text = "Abschluss von “Stille Erwachen“ im Wahnsinnsmodus"
  },
  Task_116495_Desc = {
    Text = "Abschluss “Abenteuermärchen“ beliebiger Schwierigkeitsgrad"
  },
  Task_116496_Desc = {
    Text = "Abschluss “Naive Zeit“ beliebiger Schwierigkeitsgrad"
  },
  Task_116497_Desc = {
    Text = "Abschluss von “Vergessensgift“ im Wahnsinnsmodus"
  },
  Task_116498_Desc = {
    Text = "Mit einem Fleisch-Reich-Erwecker zweimal im “Verschmelzendes Schmerzblut“ gewinnen"
  },
  Task_116499_Desc = {
    Text = "Abschluss von “Die Erhebung des Windes“ im Wahnsinnsmodus"
  },
  Task_116500_Desc = {
    Text = "Mit einem Fleisch-Reich-Erwecker im “Verschmelzendes Schmerzblut“ einmal gewinnen"
  },
  Task_116501_Desc = {
    Text = "Abschluss “Zwillingsflügel“ beliebiger Schwierigkeitsgrad"
  },
  Task_116502_Desc = {
    Text = "Abschluss von “Stille Erwachen“ in beliebigem Schwierigkeitsgrad"
  },
  Task_116503_Desc = {
    Text = "Mit einem Ultra-Reich-Erwecker zweimal im “Verschmelzendes Schmerzblut“ gewinnen"
  },
  Task_116504_Desc = {
    Text = "Mit einem Chaos-Reich-Erwecker im “Verschmelzendes Schmerzblut“ einmal gewinnen"
  },
  Task_116767_Desc = {
    Text = "1x Pollux-Demo-Level abschließen"
  },
  Task_116768_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_116769_Desc = {
    Text = "1 Mal Transzendente Existenz abschließen"
  },
  Task_116770_Desc = {
    Text = "1 Mal Transzendente Existenz abschließen"
  },
  Task_116771_Desc = {
    Text = "Vollständig 20 Aufgaben"
  },
  Task_116772_Desc = {
    Text = "Katastrophentrainingswert 100 in der Schmelzkatastrophen-Zone erreicht"
  },
  Task_116773_Desc = {
    Text = "20 Aufträge abgeschlossen"
  },
  Task_116774_Desc = {
    Text = "Vollständig 20 Aufgaben"
  },
  Task_116775_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_116776_Desc = {
    Text = "20 Aufträge abgeschlossen"
  },
  Task_116777_Desc = {
    Text = "3-mal tägliches Training abschließen"
  },
  Task_116778_Desc = {
    Text = "3-mal tägliches Training abschließen"
  },
  Task_116779_Desc = {
    Text = "30 Mal erwachen"
  },
  Task_116780_Desc = {
    Text = "Katastrophentrainingswert 100 in der Schmelzkatastrophen-Zone erreicht"
  },
  Task_116781_Desc = {
    Text = "30 Mal erwachen"
  },
  Task_116782_Desc = {
    Text = "1x Pollux-Demo-Level abschließen"
  },
  Task_116793_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_116793_Name = {Text = "3 Siege"},
  Task_116794_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_116794_Name = {Text = "1 Sieg"},
  Task_116795_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_116795_Name = {Text = "6 Siege"},
  Task_116796_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_116796_Name = {Text = "10 Siege"},
  Task_116809_Desc = {
    Text = "Vollende die Abweichende Traumwelt “Leb wohl, Niemandsland“"
  },
  Task_116809_Name = {
    Text = "Nachklang eines schönen Traums"
  },
  Task_116810_Desc = {
    Text = "Abgeschlossen die Abweichende Traumwelt “Leb wohl, Niemandsland“ in schwierigem Schwierigkeitsgrad"
  },
  Task_116810_Name = {
    Text = "Nachklang des schönen Traums · Schwierig"
  },
  Task_116820_Name = {
    Text = "Besiege BOSS 3 N-mal"
  },
  Task_116821_Name = {
    Text = "Besiege BOSS 6 N-mal"
  },
  Task_116822_Name = {
    Text = "Besiege alle Bosse"
  },
  Task_116823_Name = {
    Text = "Besiege BOSS 5 Mal"
  },
  Task_116824_Name = {
    Text = "Besiege BOSS 1 N-mal"
  },
  Task_116825_Name = {
    Text = "Besiege BOSS 4 N-mal"
  },
  Task_116826_Name = {
    Text = "Besiege BOSS 7 N-mal"
  },
  Task_116827_Name = {
    Text = "Besiege BOSS 2 N-mal"
  },
  Task_116884_Desc = {
    Text = "Kumulativer Login: 11 Tage"
  },
  Task_116885_Desc = {
    Text = "Kumulativer Login: 13 Tage"
  },
  Task_116886_Desc = {
    Text = "Logge dich insgesamt 7 Tage lang ein"
  },
  Task_116887_Desc = {
    Text = "Insgesamt 9 Tage eingeloggt"
  },
  Task_116888_Desc = {
    Text = "Logge dich insgesamt 10 Tage lang ein"
  },
  Task_116890_Desc = {
    Text = "Logge dich insgesamt 8 Tage lang ein"
  },
  Task_116891_Desc = {
    Text = "Insgesamt 16 Tage eingeloggt"
  },
  Task_116892_Desc = {
    Text = "Logge dich insgesamt 15 Tage lang ein"
  },
  Task_116894_Desc = {
    Text = "Logge dich insgesamt 4 Tage lang ein"
  },
  Task_116895_Desc = {
    Text = "Logge dich an insgesamt 5 aufeinander folgenden Tagen ein"
  },
  Task_116896_Desc = {
    Text = "Logge dich an insgesamt 3 aufeinander folgenden Tagen ein"
  },
  Task_116897_Desc = {
    Text = "Kumulativer Login für 6 Tage"
  },
  Task_116899_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_116900_Desc = {
    Text = "14-tägliche kumulierte Anmeldung"
  },
  Task_116901_Desc = {
    Text = "Logge dich insgesamt 2 Tage lang ein"
  },
  Task_116903_Desc = {
    Text = "Kumulativer Login: 12 Tage"
  },
  Task_117156_Desc = {
    Text = "Verwende den Erwecker im Tiefseereich, um einmal in \"Stadt im See\" zu gewinnen"
  },
  Task_117157_Desc = {
    Text = "Verwenden des Caro Reich Erwächters, um einmal in \"City in the Lake\" zu gewinne"
  },
  Task_117158_Desc = {
    Text = "Verwende den Ultra Reich Erwachter, um einmal in \"Stadt im See\" zu gewinne"
  },
  Task_117159_Desc = {
    Text = "Verwenden Sie den Chaos-Reich-Erwacher, um einmal in \"Stadt im See\" zu gewinnen."
  },
  Task_117304_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_117304_Name = {Text = "1 Sieg"},
  Task_117305_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_117305_Name = {Text = "6 Siege"},
  Task_117306_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_117306_Name = {Text = "3 Siege"},
  Task_117307_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_117307_Name = {Text = "10 Siege"},
  Task_117487_Desc = {
    Text = "Abgeschlossen die Abweichende Traumwelt “Auf Wiedersehen, Nimmerland“ in hartem Schwierigkeitsgrad"
  },
  Task_117487_Name = {
    Text = "Nie aufgeben · Schwierig"
  },
  Task_117488_Desc = {
    Text = "Vollende die Abweichende Traumwelt “Leb wohl, Niemandsland“"
  },
  Task_117488_Name = {
    Text = "Niemals aufgeben"
  },
  Task_117489_Desc = {
    Text = "Vollende “Jenseits des Horizonts·unter“ in der Abweichenden Traumwelt"
  },
  Task_117489_Name = {
    Text = "Über dem blauen Himmel"
  },
  Task_118481_Desc = {
    Text = "Nimm Murphy mit"
  },
  Task_118481_Name = {Text = "Ziel"},
  Task_118482_Desc = {
    Text = "Dringender Einsatz zur Rettung von Murphy am Zeremonieort"
  },
  Task_118482_Name = {Text = "Ziel"},
  Task_118483_Desc = {
    Text = "Wiederbetreten des Paradieses"
  },
  Task_118483_Name = {Text = "Ziel"},
  Task_118484_Desc = {
    Text = "Lüfte den Schleier des Traums"
  },
  Task_118484_Name = {Text = "Ziel"},
  Task_118485_Desc = {
    Text = "Beobachtung des Lotsenrituals"
  },
  Task_118485_Name = {Text = "Ziel"},
  Task_118486_Desc = {
    Text = "Begrüßung des fliegenden Fisches am Himmel"
  },
  Task_118486_Name = {Text = "Ziel"},
  Task_118487_Desc = {
    Text = "Vertreibe den verfolgenden Seefahrer"
  },
  Task_118487_Name = {Text = "Ziel"},
  Task_118488_Desc = {
    Text = "Am Ende des Weges ankommen"
  },
  Task_118488_Name = {Text = "Ziel"},
  Task_118489_Desc = {
    Text = "Zerstöre“Ego“"
  },
  Task_118489_Name = {Text = "Ziel"},
  Task_118490_Desc = {
    Text = "Murphy aus dem Chaos retten"
  },
  Task_118490_Name = {Text = "Ziel"},
  Task_118787_Desc = {
    Text = "Chor der Heiligen Frucht"
  },
  Task_118791_Desc = {
    Text = "Schwarze Kette"
  },
  Task_118796_Desc = {
    Text = "Wüstendenkmal"
  },
  Task_118799_Desc = {
    Text = "Dunkles Meerboot"
  },
  Task_118809_Desc = {
    Text = "Wüstenwand"
  },
  Task_118821_Desc = {
    Text = "Wachsfiguren-Geheimnis"
  },
  Task_118826_Desc = {
    Text = "Chaotische Überreste"
  },
  Task_118835_Desc = {
    Text = "Abgründige Überreste"
  },
  Task_118837_Desc = {
    Text = "Wahnsinniges Wachsmuseum"
  },
  Task_118842_Desc = {
    Text = "Rosenskript-Jagd"
  },
  Task_118845_Desc = {Text = "Sturmmeer"},
  Task_118852_Desc = {
    Text = "Organische Überreste"
  },
  Task_118856_Desc = {
    Text = "Verwirrtes Anomalietown"
  },
  Task_118860_Desc = {
    Text = "Puppentränen"
  },
  Task_118871_Desc = {
    Text = "Schwarzschild-Kehle"
  },
  Task_118873_Desc = {Text = "Wurmhöhle"},
  Task_118877_Desc = {
    Text = "Trankanrührung"
  },
  Task_118879_Desc = {
    Text = "Chaos-Cluster"
  },
  Task_118881_Desc = {
    Text = "Urtümliche Spalte"
  },
  Task_118892_Desc = {
    Text = "Frommheitsgriff"
  },
  Task_118907_Desc = {
    Text = "Ruinen von Pohnpei"
  },
  Task_118913_Desc = {
    Text = "Schatten jenseits der Grenze"
  },
  Task_118915_Desc = {
    Text = "Schwarze Flut"
  },
  Task_118917_Desc = {
    Text = "Kosmische Überreste"
  },
  Task_118918_Desc = {
    Text = "Chaosgebirge"
  },
  Task_118922_Desc = {Text = "Nebelstadt"},
  Task_118979_Desc = {
    Text = "Gegner trifft auf Gegner·Wahlmodus"
  },
  Task_118980_Desc = {
    Text = "Erreiche 20 Siege ohne den Erwecker mit“<color=#ae6abb>Luminis</color>“zu verwenden"
  },
  Task_118981_Desc = {
    Text = "Klicke im Kampf auf das Avatar, um 3 Gegnern den Ausdruck “Hallo“ oder “Hi“ zu senden."
  },
  Task_118982_Desc = {
    Text = "Im Vorgruppierungsmodus wurden 500 Punkte erreicht"
  },
  Task_118983_Desc = {
    Text = "Erziele 20 Siege ohne den Erwecker “<color=#76bf9d>Segen</color>“ zu verwenden"
  },
  Task_118984_Desc = {
    Text = "Im Wahlmodus wurden 1000 Punkte erreicht"
  },
  Task_118985_Desc = {
    Text = "Im Wahlmodus wurden 2500 Punkte erreicht"
  },
  Task_118986_Desc = {
    Text = "Alle Erfolge von “Phasenaufklärung“ abschließen"
  },
  Task_118987_Desc = {
    Text = "20 Siege mit einem Erwecker ohne Verwendung von“<color=#6a97c2>Wächter</color>“erzielen"
  },
  Task_118988_Desc = {
    Text = "Phasenaufklärung"
  },
  Task_118989_Desc = {
    Text = "Nehme an einem Phasenduell mit bis zu 16 Kampf-Emoticons gleichzeitig teil"
  },
  Task_118990_Desc = {
    Text = "Nach dem Phasenduell wird die Aufstellung des Gegners kopiert"
  },
  Task_118991_Desc = {
    Text = "Nehmen Sie 1 Mal am “Wahlmodus“ teil"
  },
  Task_118992_Desc = {
    Text = "Im Vorgruppierungsmodus wurden 2000 Punkte erreicht"
  },
  Task_118993_Desc = {
    Text = "Im Wahlmodus wurden 2000 Punkte erreicht"
  },
  Task_118994_Desc = {
    Text = "Im Wahlmodus wurden 500 Punkte erreicht"
  },
  Task_118995_Desc = {
    Text = "Nach dem Kampf im Phasenduell mit dem Gegner “noch eine Runde spielen“"
  },
  Task_118996_Desc = {
    Text = "Im Vorgruppierungsmodus wurden 1000 Punkte erreicht"
  },
  Task_118997_Desc = {
    Text = "Erziele 20 Siege ohne den Erwecker “<color=#c26669>Konflikt</color>“ zu verwenden"
  },
  Task_118998_Desc = {
    Text = "Likes der Kartenkommentare in der “Sammlung“"
  },
  Task_118999_Desc = {
    Text = "Teste den Erwecker im “Sammlung“ unter “Erweckungskörper-Test“ und besiege 1 “vertraute schwarze Katze“."
  },
  Task_119000_Desc = {
    Text = "Im Vorgruppierungsmodus wurden 3000 Punkte erreicht"
  },
  Task_119001_Desc = {
    Text = "Nehmen Sie 1 Mal am “Vorgruppierungsmodus“ teil"
  },
  Task_119002_Desc = {
    Text = "Im Vorgruppierungsmodus wurde eine Punktzahl von 1500 erreicht"
  },
  Task_119003_Desc = {
    Text = "Im Wahlmodus wurden 3000 Punkte erreicht"
  },
  Task_119004_Desc = {
    Text = "Im Wahlmodus wurde eine Punktzahl von 1500 erreicht"
  },
  Task_119005_Desc = {
    Text = "Gegner·Vorgruppe"
  },
  Task_119006_Desc = {
    Text = "Sieh dir die “Wiedergabe“ des Phasenduells im “Schutzherr Archiv“ unter “Kampfnachrichten“ an."
  },
  Task_119007_Desc = {
    Text = "Nehme 1 Mal an einem “Passwortkampf“ teil"
  },
  Task_119008_Desc = {
    Text = "Im Vorgruppierungsmodus wurden 2500 Punkte erreicht"
  },
  Task_119009_Desc = {
    Text = "20 Siege ohne Verwendung des “<color=#c3aa64>Unheilvollen Stern</color>“ Erweckers"
  },
  Task_119010_Desc = {
    Text = "Einblick in die Phänomene"
  },
  Task_119193_Desc = {
    Text = "Kumulative Extraktion von 68000 Quellflüssigkeit"
  },
  Task_119201_Desc = {
    Text = "Kumulative Extraktion von 54000 Quellflüssigkeit"
  },
  Task_119212_Desc = {
    Text = "Kumulative Extraktion von 42000 Silberprimus"
  },
  Task_119216_Desc = {
    Text = "Kumulative Extraktion von 48000 Quellflüssigkeit"
  },
  Task_119217_Desc = {
    Text = "Kumulative Extraktion von 36000 Quellflüssigkeit"
  },
  Task_119695_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_119696_Desc = {
    Text = "Abgeschlossen Vergessenes Kapitel 4 “Im Stillen“"
  },
  Task_119697_Desc = {
    Text = "Abgeschlossen: Sternekapitel Kapitel 4 “Paradies“"
  },
  Task_119698_Desc = {
    Text = "Insgesamt 200 Mal Posse verwendet"
  },
  Task_119699_Desc = {
    Text = "Abgeschlossen Vergessenes Kapitel 7 “Yuhé“"
  },
  Task_120441_Desc = {
    Text = "Abgeschlossen “Ermittlungsoperation“ Kapitel 7"
  },
  Task_120500_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_120501_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_120502_Desc = {
    Text = "Bei der Untersuchung des Ereignisses “@1@2“ entstand 2-mal Resonanz"
  },
  Task_120502_Desc2 = {
    Text = "Bei der Ermittlung des Ereignisses “Paradies“ wurde 2 Mal Resonanz erzeugt"
  },
  Task_120502_Name2 = {
    Text = "Echo der Wahnvorstellungen"
  },
  Task_120503_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"@1@2\""
  },
  Task_120503_Desc2 = {
    Text = "Abschluss des Untersuchungsereignisses “Paradies“"
  },
  Task_120503_Name2 = {
    Text = "Zerfall des Paradieses"
  },
  Task_120504_Desc = {
    Text = "Abgeschlossen: Sternenkapitel 4, 4-6"
  },
  Task_120505_Desc = {
    Text = "Abschluss des Ermittlungsereignisses “Paradies“ in hartem Schwierigkeitsgrad"
  },
  Task_120505_Name = {
    Text = "Zerfall des Paradieses · Schwierig"
  },
  Task_120506_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 6 Mal Resonanz erzeugt"
  },
  Task_120506_Desc2 = {
    Text = "Bei der Ermittlung des Ereignisses“Paradies“ wurde 6 Mal Resonanz erzeugt"
  },
  Task_120506_Name2 = {
    Text = "Echo der Wahnvorstellungen III"
  },
  Task_120507_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_120508_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_120509_Desc = {
    Text = "Abgeschlossen: Sternekapitel, Kapitel 4 “Paradies“ auf schwerem Schwierigkeitsgrad"
  },
  Task_120510_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_120511_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_120512_Desc = {
    Text = "Abgeschlossen: Sternenkapitel Kapitel 4, 4-6"
  },
  Task_120514_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_120515_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_120516_Desc = {
    Text = "Abgeschlossen: Sternenkapitel, Kapitel 4, 4-5 auf schwerem Schwierigkeitsgrad"
  },
  Task_120517_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_120518_Desc = {
    Text = "Abgeschlossen: Sternenkapitel Kapitel 4, 4-5 auf schwerem Schwierigkeitsgrad"
  },
  Task_120519_Desc = {
    Text = "Abgeschlossen: Sternekapitel Kapitel 4 “Paradies“"
  },
  Task_120520_Desc = {
    Text = "In der Untersuchung Veranstaltung \"@1@2\" 7 Mal resoniert"
  },
  Task_120520_Desc2 = {
    Text = "Bei der Ermittlung des Ereignisses“Paradies“ wurde 7 Mal Resonanz erzeugt"
  },
  Task_120520_Name2 = {
    Text = "Echo der Wahnvorstellungen IV"
  },
  Task_120521_Desc = {
    Text = "Abgeschlossen: Sternenkapitel, Kapitel 4 “Paradies“ auf schwerem Schwierigkeitsgrad"
  },
  Task_120522_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_120523_Desc = {
    Text = "Bei der Untersuchung des Ereignisses “@1@2“ entstand 4-mal Resonanz"
  },
  Task_120523_Desc2 = {
    Text = "Bei der Untersuchung des Ermittlungsereignisses “Paradies“ entstand 4-mal Resonanz"
  },
  Task_120523_Name2 = {
    Text = "Echo der Wahnvorstellungen II"
  },
  Task_120524_Desc = {
    Text = "Abgeschlossen: Sternekapitel Kapitel 4 “Paradies“"
  },
  Task_120535_Desc = {
    Text = "Abgeschlossen Vergessenes Kapitel 4 “In der Stille“"
  },
  Task_120536_Desc = {
    Text = "Abgeschlossen Vergessenes Kapitel 7 “Yuhé“"
  },
  Task_120537_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_120538_Desc = {
    Text = "Abgeschlossen: Sternekapitel Kapitel 4 “Paradies“"
  },
  Task_120549_Desc = {
    Text = "Kämpfe bis zum Ende 100 Mal, ohne im Phasenduell aufzugeben"
  },
  Task_120850_Desc = {
    Text = "Nur einmal mit einem Fleisch-Reich-Erwecker den “Traumtauchen“ abschließen"
  },
  Task_120851_Desc = {
    Text = "Einmal den “Traumtauchen“ mit einem Chaos-Reich und einem Ultra-Reich Erwecker abschließen"
  },
  Task_120852_Desc = {
    Text = "Nur mit einem Chaos-Reich-Erwecker einmal den “Traumtauchen“ abschließen"
  },
  Task_120855_Desc = {
    Text = "“Traumtauchen“ Höchstpunktzahl erreicht 1000"
  },
  Task_120856_Desc = {
    Text = "Einmal den “Traumtauchen“ mit einem Chaos-Reich und einem Fleisch-Reich-Erwecker abschließen"
  },
  Task_120857_Desc = {
    Text = "Nur den Chaoswachkörper verwenden, um 5-mal den phantasmalen Sturzflug der Schwierigkeit VI oder höher abzuschließen."
  },
  Task_120862_Desc = {
    Text = "Nur mit Fleisch-Erwachungskörper 5-mal den “Traumtauchen“ in Schwierigkeit VI oder höher abschließen."
  },
  Task_120863_Desc = {
    Text = "Verwenden Sie Chaos und Tiefseewachkörper, um 5-mal phantasmalen Sturzflug in Schwierigkeitsgrad VI oder höher abzuschließen."
  },
  Task_120864_Desc = {
    Text = "Nutze Chaos und hyperdimensionale Erwecker, um 5-mal Traumtauchen in Schwierigkeitsgrad VI oder höher abzuschließen."
  },
  Task_120865_Desc = {
    Text = "Einmal mit einem Aequor-Reich und einem Ultra-Reich Erwecker den “Traumtauchen“ abschließen"
  },
  Task_120867_Desc = {
    Text = "Verwende Aequor und Fleisch-Erwachungskörper, um 5-mal den phantasmalen Sturzflug in Schwierigkeit VI oder höher abzuschließen."
  },
  Task_120868_Desc = {
    Text = "Unter dem Albtraum"
  },
  Task_120869_Desc = {
    Text = "Nur den hyperdimensionalen Erwachungsbody verwenden, um 5-mal den “Traumtauchen“ in Schwierigkeitsgrad VI oder höher abzuschließen."
  },
  Task_120870_Desc = {
    Text = "Verwenden Sie Chaos und Fleisch-Erwachungskörper, um 5-mal den phantasmalen Sturzflug der Schwierigkeit VI oder höher abzuschließen."
  },
  Task_120871_Desc = {
    Text = "“Traumtauchen“höchste Punktzahl erreicht 7000"
  },
  Task_120872_Desc = {
    Text = "Nur einmal mit einem Aequor-Reich Erwecker den “Traumtauchen“ abschließen"
  },
  Task_120873_Desc = {
    Text = "Nur mit Tiefseewachkörper 5-mal den “Traumtauchen“ in Schwierigkeit VI oder höher abschließen"
  },
  Task_120876_Desc = {
    Text = "Grenzmeerfahrt"
  },
  Task_120878_Desc = {
    Text = "“Traumtauchen“höchste Punktzahl erreicht 6000"
  },
  Task_120879_Desc = {
    Text = "Verwende Aequor und hyperdimensionalen Erwachungsbody, um 5-mal den phantasmalen Sturzflug in Schwierigkeitsgrad VI oder höher abzuschließen."
  },
  Task_120880_Desc = {
    Text = "Einmal die Wiederholung im “Traumtauchen“-“Rangliste“ ansehen"
  },
  Task_120882_Desc = {
    Text = "Nur einmal mit einem Ultra-Reich Erwecker den “Traumtauchen“ abschließen"
  },
  Task_120883_Desc = {
    Text = "Einmal mit einem Chaos-Reich und einem Aequor-Reich Erwecker den “Traumtauchen“ abschließen"
  },
  Task_120884_Desc = {
    Text = "Verwenden Sie Fleisch und hyperdimensionalen Erwachungsbody, um 5-mal den Traumtauchen der Schwierigkeit VI oder höher abzuschließen."
  },
  Task_120885_Desc = {
    Text = "Eintreten in das Traummeer"
  },
  Task_120889_Desc = {
    Text = "“Traumtauchen“höchste Punktzahl erreicht 5000"
  },
  Task_120890_Desc = {
    Text = "Vollständig \"Phantasmatische Tauchfahrt\" einmal"
  },
  Task_120891_Desc = {
    Text = "Kopiere 1-mal die Aufstellung im “Traumtauchen“ unter “Rangliste“"
  },
  Task_120892_Desc = {
    Text = "“Traumtauchen“höchste Punktzahl erreicht 2000"
  },
  Task_120894_Desc = {
    Text = "“Traumtauchen“ Höchstpunktzahl erreicht 4000"
  },
  Task_120895_Desc = {
    Text = "“Traumtauchen“höchste Punktzahl erreicht 3000"
  },
  Task_120966_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_120966_Name = {Text = "3 Siege"},
  Task_120967_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_120967_Name = {Text = "6 Siege"},
  Task_120968_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_120968_Name = {Text = "10 Siege"},
  Task_120969_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_120969_Name = {Text = "1 Sieg"},
  Task_120994_Desc = {
    Text = "Vernichte alle Kopien von “Wiederkampf Ursprünglich·Disonante Ouvertüre“"
  },
  Task_120994_Name = {
    Text = "Besiege BOSS1"
  },
  Task_120995_Desc = {
    Text = "Vernichte alle Duplikate von “Wiederkampf Ursprünglich·Verkehrter Klang“"
  },
  Task_120995_Name = {
    Text = "Besiege BOSS4"
  },
  Task_120996_Name = {
    Text = "Weltboss-Aktivität beendet"
  },
  Task_120997_Desc = {
    Text = "Vernichte alle Kopien von “Wiederkampf Ursprünglich·Ewiger Schlaf“"
  },
  Task_120997_Name = {
    Text = "Besiege Boss 7"
  },
  Task_120998_Desc = {
    Text = "Vernichte alle Kopien von “Wiederkampf Ursprünglich·Stille Rhythmus“"
  },
  Task_120998_Name = {
    Text = "Besiege Boss 3"
  },
  Task_120999_Desc = {
    Text = "Vernichte alle Duplikate von“Wiederkampf Ursprünglich·Häresie Klang“"
  },
  Task_120999_Name = {
    Text = "Besiege BOSS 5"
  },
  Task_121000_Desc = {
    Text = "Vernichte alle Duplikate von “Wiederkampf Ursprünglich · Wahnsinn Schlusskapitel“"
  },
  Task_121000_Name = {
    Text = "Besiege Boss 6"
  },
  Task_121001_Desc = {
    Text = "Vernichte alle Duplikate von “Wiederkampf Ursprünglich·Nichtsordentliches Vorspiel“"
  },
  Task_121001_Name = {
    Text = "Besiege BOSS2"
  },
  Task_121033_Desc = {
    Text = "Insgesamt 30× geweckt"
  },
  Task_121035_Desc = {
    Text = "Vollständig 20 Aufgaben"
  },
  Task_121040_Desc = {
    Text = "20 Aufträge abgeschlossen"
  },
  Task_121041_Desc = {
    Text = "Vollständig 20 Aufgaben"
  },
  Task_121042_Desc = {
    Text = "3-mal tägliches Training abschließen"
  },
  Task_121044_Desc = {
    Text = "1 Mal Transzendente Existenz abschließen"
  },
  Task_121045_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_121046_Desc = {
    Text = "1 Mal das Probespiel-Level von Mouchette abschließen"
  },
  Task_121047_Desc = {
    Text = "Insgesamt 30× geweckt"
  },
  Task_121050_Desc = {
    Text = "3-mal tägliches Training abschließen"
  },
  Task_121051_Desc = {
    Text = "Katastrophentrainingswert 100 in der Schmelzkatastrophen-Zone erreicht"
  },
  Task_121053_Desc = {
    Text = "Katastrophentrainingswert 100 in der Schmelzkatastrophen-Zone erreicht"
  },
  Task_121054_Desc = {
    Text = "20 Aufträge abgeschlossen"
  },
  Task_121058_Desc = {
    Text = "1 Mal Transzendente Existenz abschließen"
  },
  Task_121061_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_121062_Desc = {
    Text = "Abgeschlossen 1 Mal das Mouchette-Demo-Level"
  },
  Task_121206_Desc = {
    Text = "Kumulative Extraktion von 76000 Quellflüssigkeit"
  },
  Task_121207_Desc = {
    Text = "Kumulative Extraktion von 84000 Quellflüssigkeit"
  },
  Task_121208_Desc = {
    Text = "Kumulative Extraktion von 92000 Quellflüssigkeit"
  },
  Task_121233_Desc = {
    Text = "Drei Sterne Bewertung in “Frommheitsgriff IV“ erhalten"
  },
  Task_121234_Desc = {
    Text = "Drei Sterne Bewertung in “Wachsfiguren-Geheimnis II“ erhalten"
  },
  Task_121235_Desc = {
    Text = "Drei Sterne Bewertung in “Organisches Residuum III“ erhalten"
  },
  Task_121236_Desc = {
    Text = "Drei Sterne in “Puppentränen V“ erhalten"
  },
  Task_121237_Desc = {
    Text = "Drei Sterne Bewertung in “Wachsfiguren-GeheimnisⅢ“ erreichen"
  },
  Task_121238_Desc = {
    Text = "In der “Goldschein-SucheⅠ“ drei Sterne erreichen"
  },
  Task_121239_Desc = {
    Text = "Drei-Sterne-Bewertung in “Schatten jenseits der GrenzeⅣ“ erhalten"
  },
  Task_121240_Desc = {
    Text = "In “Chaos-Schwarm IV“ eine Drei-Sterne-Bewertung erhalten"
  },
  Task_121241_Desc = {
    Text = "Drei-Sterne-Bewertung in “Chor der Heiligen Frucht II“ erhalten"
  },
  Task_121242_Desc = {
    Text = "Drei Sterne Bewertung in“Dunkles MeerbootⅢ“erhalten"
  },
  Task_121243_Desc = {
    Text = "Drei Sterne Bewertung in “Schwarze Kette III“ erhalten"
  },
  Task_121244_Desc = {
    Text = "In “Meerestiefenresiduum V“ drei Sterne erhalten"
  },
  Task_121245_Desc = {
    Text = "Drei Sterne in “Dimensionsresiduum I“ erreichen"
  },
  Task_121246_Desc = {
    Text = "Drei Sterne Bewertung in “Chaosgebirge II“ erreichen"
  },
  Task_121247_Desc = {
    Text = "Drei Sterne Bewertung in“Nebelstadt II“erhalten"
  },
  Task_121248_Desc = {
    Text = "Drei-Sterne-Bewertung in “Ruinen von Ponape II“ erhalten"
  },
  Task_121249_Desc = {
    Text = "Drei Sterne Bewertung in “Organisches Residuum II“ erhalten"
  },
  Task_121250_Desc = {
    Text = "Drei Sterne Bewertung in “Chaosgebirge I“ erhalten"
  },
  Task_121251_Desc = {
    Text = "Drei Sterne in“Dimensionsresiduum II“erhalten"
  },
  Task_121252_Desc = {
    Text = "Drei Sterne in “trübes Nachbild IV“ erhalten"
  },
  Task_121253_Desc = {
    Text = "Drei Sterne Bewertung in “Wahnsinniges WachsmuseumⅡ“ erhalten"
  },
  Task_121254_Desc = {
    Text = "Drei Sterne Bewertung in “Frommheitsgriff I“ erhalten"
  },
  Task_121255_Desc = {
    Text = "Erhalte eine Drei-Sterne-Bewertung im “Schwarm des Chaos I“"
  },
  Task_121256_Desc = {
    Text = "Drei Sterne Bewertung in “Wachsfiguren-Geheimnis IV“ erhalten"
  },
  Task_121257_Desc = {
    Text = "Drei Sterne Bewertung in“Wurmnest I“erhalten"
  },
  Task_121258_Desc = {
    Text = "In der “Wüstenwand I“ drei Sterne erreichen"
  },
  Task_121259_Desc = {
    Text = "Drei-Sterne-Bewertung in “Puppentränen II“ erhalten"
  },
  Task_121260_Desc = {
    Text = "Erhalte drei Sterne in “FrommheitsgriffⅢ“"
  },
  Task_121261_Desc = {
    Text = "Drei-Sterne-Bewertung in“Schatten jenseits der GrenzeⅢ“erhalten"
  },
  Task_121262_Desc = {
    Text = "Drei Sterne in “Wüstendenkmal III“ erhalten"
  },
  Task_121263_Desc = {
    Text = "Drei-Sterne-Bewertung in “Chaos-Schwarm II“ erreichen"
  },
  Task_121264_Desc = {
    Text = "Drei Sterne Bewertung in “Verwirrte StadtⅠ“ erhalten"
  },
  Task_121265_Desc = {
    Text = "Drei Sterne Bewertung in“Meerestiefenresiduum I“erhalten"
  },
  Task_121266_Desc = {
    Text = "Drei Sterne Bewertung in“WüstendenkmalⅠ“erhalten"
  },
  Task_121267_Desc = {
    Text = "Drei Sterne Bewertung in “Wahnsinniges WachsmuseumⅢ“ erhalten"
  },
  Task_121268_Desc = {
    Text = "Drei Sterne Bewertung in“MeerestiefenresiduumⅣ“erhalten"
  },
  Task_121269_Desc = {
    Text = "Drei Sterne Bewertung in “Schwarzschild-Raumzeit IV“ erhalten"
  },
  Task_121270_Desc = {
    Text = "Drei Sterne Bewertung in“DimensionsresiduumⅢ“erhalten"
  },
  Task_121271_Desc = {
    Text = "Drei Sterne Bewertung in der “Goldschein-SucheⅣ“ erhalten"
  },
  Task_121272_Desc = {
    Text = "Drei-Sterne-Bewertung in“Meerestiefen-Phantom III“erhalten"
  },
  Task_121273_Desc = {
    Text = "Drei-Sterne-Bewertung in der “Präparatveredelung I“ erhalten"
  },
  Task_121274_Desc = {
    Text = "Drei Sterne in “Wachsfiguren-Geheimnis V“ erreichen"
  },
  Task_121275_Desc = {
    Text = "Drei Sterne Bewertung in“Wüstendenkmal II“erhalten"
  },
  Task_121276_Desc = {
    Text = "Drei Sterne Bewertung in “Wahnsinniges WachsmuseumⅠ“ erhalten"
  },
  Task_121277_Desc = {
    Text = "Drei Sterne Bewertung in “Chaosgebirge III“ erhalten"
  },
  Task_121278_Desc = {
    Text = "Drei Sterne Bewertung in“PräparatveredelungⅣ“erhalten"
  },
  Task_121279_Desc = {
    Text = "In “Puppentränen III“ drei Sterne erreichen"
  },
  Task_121280_Desc = {
    Text = "Drei Sterne Bewertung in “Organisches Residuum V“ erhalten"
  },
  Task_121281_Desc = {
    Text = "Drei Sterne Bewertung in “Dunkles Meerboot I“ erhalten"
  },
  Task_121282_Desc = {
    Text = "Drei Sterne in “Schwarze Flut II“ erreichen"
  },
  Task_121283_Desc = {
    Text = "In “trübes Nachbild III“ drei Sterne erreichen"
  },
  Task_121284_Desc = {
    Text = "Drei Sterne in “Frommheitsgriff II“ erreichen"
  },
  Task_121285_Desc = {
    Text = "Drei Sterne Bewertung in “Sturmmeer I“ erreichen"
  },
  Task_121286_Desc = {
    Text = "Drei Sterne Bewertung in “Wachsfiguren-Geheimnis I“ erreichen"
  },
  Task_121287_Desc = {
    Text = "Drei-Sterne-Bewertung in “Ruinen von Ponape III“ erhalten"
  },
  Task_121288_Desc = {
    Text = "Drei-Sterne-Bewertung in “Chor der Heiligen Frucht III“ erhalten"
  },
  Task_121289_Desc = {
    Text = "Drei Sterne in “Organisches Residuum IV“ erreichen"
  },
  Task_121290_Desc = {
    Text = "Drei Sterne Bewertung in “Organische Überreste I“ erhalten"
  },
  Task_121291_Desc = {
    Text = "Drei Sterne Bewertung in“Schatten des ÄußerenⅡ“erhalten"
  },
  Task_121292_Desc = {
    Text = "Drei-Sterne-Bewertung in “Chor der Heiligen Frucht I“ erhalten"
  },
  Task_121293_Desc = {
    Text = "Drei Sterne Bewertung in “Schwarzschlund III“ erhalten"
  },
  Task_121294_Desc = {
    Text = "Drei Sterne in “Schatten jenseits der GrenzeⅠ“ erhalten"
  },
  Task_121295_Desc = {
    Text = "Drei Sterne Bewertung in der “Goldschein-SucheⅡ“ erhalten"
  },
  Task_121296_Desc = {
    Text = "Drei Sterne Bewertung in “Präparatveredelung V“ erhalten"
  },
  Task_121297_Desc = {
    Text = "Drei Sterne Bewertung in“Verwirrte StadtⅡ“erhalten"
  },
  Task_121298_Desc = {
    Text = "Drei Sterne Bewertung in“PräparatveredelungⅡ“erhalten"
  },
  Task_121299_Desc = {
    Text = "Drei Sterne in “Schwarzschlund II“ erreichen"
  },
  Task_121300_Desc = {
    Text = "Drei Sterne in der “Goldschein-SucheⅤ“ erreichen"
  },
  Task_121301_Desc = {
    Text = "Drei Sterne Bewertung in“NebelstadtⅢ“erhalten"
  },
  Task_121302_Desc = {
    Text = "Drei Sterne in der “Präparatveredelung III“ erhalten"
  },
  Task_121303_Desc = {
    Text = "Drei-Sterne-Bewertung in “Ruinen von Ponape IV“ erhalten"
  },
  Task_121304_Desc = {
    Text = "In “Chaos-Schwarm III“ drei Sterne erreichen"
  },
  Task_121305_Desc = {
    Text = "Drei Sterne Bewertung in“Nebelstadt I“erhalten"
  },
  Task_121306_Desc = {
    Text = "Drei Sterne Bewertung in “Wurmnest III“ erhalten"
  },
  Task_121307_Desc = {
    Text = "Drei Sterne in “Meerestiefen-Phantom II“ erreichen"
  },
  Task_121308_Desc = {
    Text = "Drei Sterne Bewertung in “Wurmnest IV“ erhalten"
  },
  Task_121309_Desc = {
    Text = "Drei-Sterne-Bewertung in “Ruinen von Ponape I“ erhalten"
  },
  Task_121310_Desc = {
    Text = "Drei Sterne in “trübes Nachbild II“ erreichen"
  },
  Task_121311_Desc = {
    Text = "Drei Sterne in “Dimensionsresiduum V“ erhalten"
  },
  Task_121312_Desc = {
    Text = "Drei Sterne Bewertung im “Wurmnest II“ erhalten"
  },
  Task_121313_Desc = {
    Text = "In “Schwarze Kette II“ drei Sterne erreichen"
  },
  Task_121314_Desc = {
    Text = "Drei-Sterne-Bewertung in “Dimensionsresiduum IV“ erhalten"
  },
  Task_121315_Desc = {
    Text = "Erreiche eine Drei-Sterne-Bewertung in “trübes Nachbild V“"
  },
  Task_121316_Desc = {
    Text = "Drei Sterne Bewertung in “Schwarze Kette IV“ erhalten"
  },
  Task_121317_Desc = {
    Text = "Drei Sterne Bewertung in “Schwarze Kette I“ erhalten"
  },
  Task_121318_Desc = {
    Text = "Drei Sterne Bewertung in“Verwirrtes AnomalietownⅢ“erhalten"
  },
  Task_121319_Desc = {
    Text = "Drei-Sterne-Bewertung in “Puppentränen I“ erhalten"
  },
  Task_121320_Desc = {
    Text = "Drei Sterne Bewertung in“Dunkles Meerboot II“erhalten"
  },
  Task_121321_Desc = {
    Text = "Drei Sterne Bewertung in der “Goldgutschein-SucheⅢ“ erreichen"
  },
  Task_121322_Desc = {
    Text = "Drei-Sterne-Bewertung in “Schwarze Kette V“ erhalten"
  },
  Task_121323_Desc = {
    Text = "Drei-Sterne-Bewertung in “Puppentränen IV“ erhalten"
  },
  Task_121324_Desc = {
    Text = "In der “Schwarze Pfütze der Gezeiten I“ drei Sterne erreichen"
  },
  Task_121325_Desc = {
    Text = "In “trübes Nachbild I“ drei Sterne erreichen"
  },
  Task_121326_Desc = {
    Text = "Drei Sterne Bewertung in “Schwarzschlund I“ erhalten"
  },
  Task_121327_Desc = {
    Text = "Drei Sterne Bewertung in “Ursprüngliche Risse I“ erhalten"
  },
  Task_121331_Desc = {
    Text = "Vollende alle Aufgaben von “Erster Schritt ins Traummeer“"
  },
  Task_121332_Desc = {
    Text = "Einmal den “Traumtauchen“ mit einem Aequor-Reich und einem Fleisch-Reich-Erwecker abschließen"
  },
  Task_121333_Desc = {
    Text = "Einmal den “Traumtauchen“ mit einem Fleisch-Reich und einem Ultra-Reich-Erwecker abschließen"
  },
  Task_121834_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_121834_Name = {
    Text = "Perfekter Pass"
  },
  Task_121835_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_121835_Name = {
    Text = "Perfekter Pass"
  },
  Task_121836_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_121836_Name = {
    Text = "Perfekter Pass"
  },
  Task_121837_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_121837_Name = {
    Text = "Perfekter Pass"
  },
  Task_121838_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_121838_Name = {
    Text = "Perfekter Pass"
  },
  Task_121839_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_121839_Name = {
    Text = "Perfekter Pass"
  },
  Task_121840_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_121840_Name = {
    Text = "Perfekter Pass"
  },
  Task_121841_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_121841_Name = {
    Text = "Perfekter Pass"
  },
  Task_121842_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_121842_Name = {
    Text = "Perfekter Pass"
  },
  Task_121843_Desc = {
    Text = "Erleide alle heiligen Flüche und besiege die “Paradiesprojektion“ in 15 Runden."
  },
  Task_121843_Name = {
    Text = "Zerfall des Paradieses·Verstecken"
  },
  Task_121844_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_121844_Name = {
    Text = "Perfekter Pass"
  },
  Task_121897_Desc = {
    Text = "Für jede verbleibende Runde erhält man zusätzlich 20 Punkte. (Verbleibende Runden: {s1})"
  },
  Task_121897_Name = {
    Text = "Zeitstrahl Sanduhr<size=20><color=#747474>Startrunde 50, für jede verbleibende Runde zusätzlich 20 Punkte erhalten.</color></size>"
  },
  Task_122110_Desc = {
    Text = "Erster täglicher Spielbesuch erhält 500 Punkte."
  },
  Task_122110_Name = {
    Text = "Traumvorreiter<size=20><color=#747474>Erhalte 500 Punkte für das erste Spielen täglich</color></size>"
  },
  Task_122197_Desc = {
    Text = "Verwende einen beliebigen Chaos-Erwecker, um einmal im \"Das verlorene Selbst\" zu gewinnen"
  },
  Task_122198_Desc = {
    Text = "Schließe \"Befehlen Sie die Gliedmaßen\" im Wahnsinnsmodus ab"
  },
  Task_122199_Desc = {
    Text = "Schließe \"Zersplittertes Herz\" im Wahnsinnsmodus ab"
  },
  Task_122200_Desc = {
    Text = "Beende \"Appendektomie\" in beliebigem Schwierigkeitsgrad"
  },
  Task_122201_Desc = {
    Text = "Schließe \"Kontrollsprache\" in beliebigem Modus ab"
  },
  Task_122202_Desc = {
    Text = "Schließe \"Instinktiv denken\" in beliebigem Modus ab"
  },
  Task_122203_Desc = {
    Text = "Schließe \"Befreiung des wahren Selbst\" im Wahnsinnsmodus ab"
  },
  Task_122204_Desc = {
    Text = "Schließe \"Blindfolded\" im Wahnsinnsmodus ab"
  },
  Task_122205_Desc = {
    Text = "Schalte \"Zerbrich das Herz\" auf beliebigem Schwierigkeitsgrad frei"
  },
  Task_122206_Desc = {
    Text = "Schließe \"Kontrollsprache\" in beliebigem Modus ab"
  },
  Task_122207_Desc = {
    Text = "Schließe \"Appendektomie\" im Wahnsinnsmodus ab"
  },
  Task_122208_Desc = {
    Text = "Schließe \"Instinktiv denken\" in beliebigem Modus ab"
  },
  Task_122209_Desc = {
    Text = "Verwende den Ultra-Realm-Erwecker, um einmal in \"Verlorenes Selbst\" zu gewinnen"
  },
  Task_122210_Desc = {
    Text = "„Herrschaft über Gliedmaßen“ auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_122211_Desc = {
    Text = "Schließe \"Das wahre Selbst entfesseln\" in beliebigem Modus ab"
  },
  Task_122212_Desc = {
    Text = "Klarer multidimensionaler Link \"Die Taufe von Silber und Blut\""
  },
  Task_122213_Desc = {
    Text = "Vollständige alle Erfolge von \"Verlorenes Selbst: Bereinigt\""
  },
  Task_122214_Desc = {
    Text = "Schließe \"Verschleiere die Augen\" in beliebigem Modus ab"
  },
  Task_122215_Desc = {
    Text = "Verlorenes Selbst: Reich"
  },
  Task_122216_Desc = {
    Text = "Schließe \"Instinktiv denken\" im Wahnsinnsmodus ab"
  },
  Task_122217_Desc = {
    Text = "„Herrschaft über Gliedmaßen“ auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_122218_Desc = {
    Text = "Schließe \"Das wahre Selbst entfesseln\" in beliebigem Modus ab"
  },
  Task_122219_Desc = {
    Text = "Verlorenes Selbst: Bereinigt"
  },
  Task_122220_Desc = {
    Text = "Verwende einen beliebigen Caro-Erwecker, um zweimal im \"Das verlorene Selbst\" zu gewinnen"
  },
  Task_122221_Desc = {
    Text = "Verlorenes Selbst: Wahnsinn"
  },
  Task_122222_Desc = {
    Text = "Schließe \"Verschleiere die Augen\" in beliebigem Modus ab"
  },
  Task_122223_Desc = {
    Text = "Schließe \"Kontrollsprache\" im Wahnsinnsmodus ab"
  },
  Task_122224_Desc = {
    Text = "Beende \"Appendektomie\" in beliebigem Schwierigkeitsgrad"
  },
  Task_122225_Desc = {
    Text = "Verwende einen beliebigen Aequor-Erwecker, um einmal im \"Das verlorene Selbst\" zu gewinnen"
  },
  Task_122226_Desc = {
    Text = "Verwende einen beliebigen Aequor-Erwecker, um zweimal im \"Verlorenes Selbst\" zu gewinnen"
  },
  Task_122227_Desc = {
    Text = "Verwende einen beliebigen Caro-Erwecker, um einmal in \"Das verlorene Selbst\" zu gewinnen"
  },
  Task_122228_Desc = {
    Text = "Schalte \"Zerbrich das Herz\" auf beliebigem Schwierigkeitsgrad frei"
  },
  Task_122229_Desc = {
    Text = "Verwende den Ultra-Realm-Erwecker, um zweimal in \"Verlorenes Selbst\" zu gewinnen"
  },
  Task_122230_Desc = {
    Text = "Verwende einen beliebigen Chaos-Erwecker, um zweimal in \"Das verlorene Selbst\" zu gewinnen"
  },
  Task_122411_Desc = {
    Text = "+250/500/750/1000 Punkte für 1/2/3/4 eingesetzte Verstärkung Erwecker. (Aktuell: {s1})"
  },
  Task_122411_Name = {
    Text = "Abyss Ruf<size=20><color=#747474>Wenn du 1/2/3/4 dieser Woche Verstärkung Erwecker im Kampf einsetzt, erhältst du 250/500/750/1000 Punkte</color></size>"
  },
  Task_122584_Name = {
    Text = "Besiege alle Bosse"
  },
  Task_122704_Desc = {
    Text = "Mouchette hat die Synchro-Rate von Stufe 10 erreicht"
  },
  Task_122808_Desc = {
    Text = "Erhalte Mouchette bei der Erleuchtung 6"
  },
  Task_122808_Name = {
    Text = "Erhalte Mouchette bei der Erleuchtung 6"
  },
  Task_122808_UnlockCondDesc = {
    Text = "Aktivität @Erweckungswesen Mouchette Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_122809_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_122812_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_122816_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_122819_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_122824_Desc = {
    Text = "Erwirb Mouchette bei Erleuchtung 2"
  },
  Task_122824_Name = {
    Text = "Erwirb Mouchette bei Erleuchtung 2"
  },
  Task_122824_UnlockCondDesc = {
    Text = "Aktivität @Erweckungswesen Mouchette Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_122828_Desc = {
    Text = "Abgeschlossen “Ermittlungseinsatz - Vergessenes Kapitel - Kapitel 3“ im schwierigen Modus"
  },
  Task_122829_Desc = {
    Text = "Abgeschlossen “Ermittlungseinsatz - Vergessenes Kapitel - Kapitel 1“ im schwierigen Modus"
  },
  Task_122830_Desc = {
    Text = "Abgeschlossen “Ermittlungseinsatz - Vergessenes Kapitel - Kapitel 6“ in schwieriger Schwierigkeit"
  },
  Task_122831_Desc = {
    Text = "Abgeschlossen “Ermittlungseinsatz - Vergessenes Kapitel - Kapitel 7“ in schwierigem Modus"
  },
  Task_122832_Desc = {
    Text = "Abgeschlossen “Ermittlungseinsatz - Vergessenes Kapitel - Kapitel 4“ im schwierigen Modus"
  },
  Task_122833_Desc = {
    Text = "Abgeschlossen “Ermittlungseinsatz - Vergessenes Kapitel - Kapitel 2“ im schwierigen Modus"
  },
  Task_122834_Desc = {
    Text = "Abgeschlossen “Ermittlungseinsatz - Vergessenes Kapitel - Kapitel 5“ im schwierigen Modus"
  },
  Task_123135_Desc = {
    Text = "Mit einem Chaos-Reich-Erwecker im “Hexenladen“ zweimal gewinnen"
  },
  Task_123136_Desc = {
    Text = "Mit einem Aequor-Reich-Erwecker im “Hexenladen“ zweimal gewinnen"
  },
  Task_123137_Desc = {
    Text = "Mit einem Fleisch-Reich-Erwecker im “Hexenladen“ einmal gewinnen"
  },
  Task_123138_Desc = {
    Text = "Mit einem Ultra-Reich-Erwecker im “Hexenladen“ einmal gewinnen"
  },
  Task_123139_Desc = {
    Text = "Mit einem Chaos-Reich-Erwecker im “Hexenladen“ einmal gewinnen"
  },
  Task_123140_Desc = {
    Text = "Mit einem Fleisch-Reich-Erwecker im “Hexenladen“ zweimal gewinnen"
  },
  Task_123141_Desc = {
    Text = "Hexenladen·Reich"
  },
  Task_123142_Desc = {
    Text = "Mit einem Aequor-Reich Erwecker einmal im “Hexenladen“ gewinnen"
  },
  Task_123143_Desc = {
    Text = "Mit einem Ultra-Reich-Erwecker im “Hexenladen“ zweimal gewinnen"
  },
  Task_123288_Desc = {
    Text = "Verwenden Sie den Ultra Reich Erwecker, um 2 Mal im „Tiefseeblick\" zu gewinnen"
  },
  Task_123289_Desc = {
    Text = "Verwenden Sie den Aequor-Reich Erwecker, um 2 Mal im „Tiefseeblick\" zu gewinnen"
  },
  Task_123290_Desc = {
    Text = "Verwende den Fleisch-Reich-Erwecker, um 2 Mal im „Tiefseeblick\" zu gewinnen"
  },
  Task_123291_Desc = {
    Text = "Nutze den Chaos-Reich-Erwecker, um in „Tiefseeblick\" 2 Mal zu gewinnen"
  },
  Task_123324_Desc = {
    Text = "Vollständig 20 Aufgaben"
  },
  Task_123325_Desc = {
    Text = "Vollständig 20 Aufgaben"
  },
  Task_123326_Desc = {
    Text = "20 Aufträge abgeschlossen"
  },
  Task_123327_Desc = {
    Text = "1 Mal Transzendente Existenz abschließen"
  },
  Task_123328_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_123329_Desc = {
    Text = "20 Aufträge abgeschlossen"
  },
  Task_123330_Desc = {
    Text = "Abgeschlossen 1 Mal Tais Demo Level"
  },
  Task_123331_Desc = {
    Text = "3-mal tägliches Training abschließen"
  },
  Task_123332_Desc = {
    Text = "Insgesamt 30× geweckt"
  },
  Task_123333_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_123334_Desc = {
    Text = "Abgeschlossen 1 Mal Tais Demo Level"
  },
  Task_123335_Desc = {
    Text = "Katastrophentrainingswert 100 in der Schmelzkatastrophen-Zone erreicht"
  },
  Task_123336_Desc = {
    Text = "Katastrophentrainingswert 100 in der Schmelzkatastrophen-Zone erreicht"
  },
  Task_123337_Desc = {
    Text = "3-mal tägliches Training abschließen"
  },
  Task_123338_Desc = {
    Text = "1 Mal Transzendente Existenz abschließen"
  },
  Task_123339_Desc = {
    Text = "30 Mal kumulativ erweckt"
  },
  Task_123488_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_123488_Name = {Text = "3 Siege"},
  Task_123489_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_123489_Name = {Text = "6 Siege"},
  Task_123490_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_123490_Name = {Text = "10 Siege"},
  Task_123491_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_123491_Name = {Text = "1 Sieg"},
  Task_123726_Name = {
    Text = "Neu abschlossene Nebenschauplätze von Mouchette - Normal Schwierigkeitsgrad 6"
  },
  Task_123878_Desc = {
    Text = "Mit einem Chaos-Reich-Erwecker 2 Mal in „Wildes Streben\" gewinnen"
  },
  Task_123883_Desc = {
    Text = "Mit einem Ultra Reich Erwecker 2 Mal in „Wildes Streben\" gewinnen"
  },
  Task_123885_Desc = {
    Text = "Mit einem Aequor-Reich Erwecker 2 Mal in „Wildes Streben\" gewinnen"
  },
  Task_123887_Desc = {
    Text = "Mit einem Fleisch-Reich-Erwecker 2 Mal in „Wildes Streben\" gewinnen"
  },
  Task_124214_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_124214_Name = {Text = "3 Siege"},
  Task_124215_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_124215_Name = {Text = "10 Siege"},
  Task_124216_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_124216_Name = {Text = "1 Sieg"},
  Task_124217_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_124217_Name = {Text = "6 Siege"},
  Task_124797_Desc = {
    Text = "Abgeschlossen der multidimensionalen Verbindung“Ich bin dran“"
  },
  Task_124797_Name = {
    Text = "Kosmische Umkehr"
  },
  Task_124798_Desc = {
    Text = "Komplette Multiversenverbindung \"Taufe von Silber und Blut\" Hart"
  },
  Task_124798_Name = {
    Text = "Die Zukunft wird kommen: Schwer"
  },
  Task_124799_Desc = {
    Text = "Komplette multidimensionale Verbindung \"Die Taufe von Silber und Blut\""
  },
  Task_124799_Name = {
    Text = "Die Zukunft wird kommen"
  },
  Task_124835_Desc = {
    Text = "Abschluss „Ermittlung - Verblasste Erbschaft - Kapitel 1“"
  },
  Task_125386_Desc = {
    Text = "Schließe \"Auferstehung des Leichnams\" in beliebigem Modus ab"
  },
  Task_125387_Desc = {
    Text = "Schließe \"Schatten hinter\" in beliebigem Modus ab"
  },
  Task_125388_Desc = {
    Text = "Schließe \"Saugung\" in beliebigem Modus ab"
  },
  Task_125389_Desc = {
    Text = "Schließe \"Die Spur des Geruchs\" im Wahnsinnsmodus ab"
  },
  Task_125390_Desc = {
    Text = "Schließe \"Ordnung der schwellenden Gnade\" in beliebigem Modus ab"
  },
  Task_125391_Desc = {
    Text = "Verwende einen beliebigen Caro-Erwecker, um einmal in \"Obsidian-Matriarchin\" zu gewinnen"
  },
  Task_125392_Desc = {
    Text = "Abschluss des Wanderns „Nachtgespräch unter dem Fächer\""
  },
  Task_125392_Name = {
    Text = "Schlaf, Baby, schlaf"
  },
  Task_125393_Desc = {
    Text = "Schließe \"Die Spur des Duftes\" in beliebigem Modus ab"
  },
  Task_125394_Desc = {
    Text = "Schließe \"Ungerechter Tod\" im Wahnsinnsmodus ab"
  },
  Task_125395_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_125396_Desc = {
    Text = "Verwende einen beliebigen Chaos-Erwecker, um zweimal in \"Obsidian-Matriarchin\" zu gewinnen"
  },
  Task_125397_Desc = {
    Text = "Schließe \"Von Groll gebunden\" im Wahnsinnsmodus ab"
  },
  Task_125398_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_125399_Desc = {
    Text = "Schließe \"Ungerechter Tod\" in beliebigem Modus ab"
  },
  Task_125400_Desc = {
    Text = "Verwende einen beliebigen Chaos-Erwecker, um einmal in \"Obsidian-Matriarchin\" zu gewinnen"
  },
  Task_125401_Desc = {
    Text = "Obsidian-Matriarch: Klare"
  },
  Task_125402_Desc = {
    Text = "Schließe \"Saugung\" in beliebigem Modus ab"
  },
  Task_125403_Desc = {
    Text = "Schließe \"Schatten hinter\" in beliebigem Modus ab"
  },
  Task_125404_Desc = {
    Text = "Schließe \"Euphorie\" im Wahnsinnsmodus ab"
  },
  Task_125406_Desc = {
    Text = "Verwende einen beliebigen Aequor-Erwecker, um einmal in \"Obsidian-Matriarchin\" zu gewinnen"
  },
  Task_125407_Desc = {
    Text = "Schließe \"Euphorie\" in beliebigem Modus ab"
  },
  Task_125409_Desc = {
    Text = "Schließe \"Euphorie\" in beliebigem Modus ab"
  },
  Task_125410_Desc = {
    Text = "Verwende einen beliebigen Caro-Erwecker, um zweimal in \"Obsidian-Matriarchin\" zu gewinnen"
  },
  Task_125411_Desc = {
    Text = "Verwende einen beliebigen Aequor-Erwecker, um zweimal in \"Obsidian-Matriarchin\" zu gewinnen"
  },
  Task_125412_Desc = {
    Text = "Schließe \"Saugkraft\" im Wahnsinnsmodus ab"
  },
  Task_125413_Desc = {
    Text = "Löschen Sie \"Psyche Deepdive: Flüstern hinter dem Ventilator\""
  },
  Task_125414_Desc = {
    Text = "Schließe \"Seidene Falle\" in beliebigem Schwierigkeitsgrad ab"
  },
  Task_125415_Desc = {
    Text = "Xus Affinität erreicht Level 10"
  },
  Task_125416_Desc = {
    Text = "Verwende einen beliebigen Ultra-Erwecker, um zweimal in \"Obsidian-Matriarchin\" zu gewinnen"
  },
  Task_125417_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_125418_Desc = {
    Text = "Erleuchte 2 bei Erhalt von Xu"
  },
  Task_125418_Name = {
    Text = "Erleuchte 2 bei Erhalt von Xu"
  },
  Task_125418_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Xu Erleuchten Paket 2 Aktivität"
  },
  Task_125419_Desc = {
    Text = "Schließe \"Durch Groll gebunden\" in beliebigem Modus ab"
  },
  Task_125420_Desc = {
    Text = "Obsidianmatriarchin: Reich"
  },
  Task_125421_Desc = {
    Text = "Schließe \"Schatten hinter\" im Wahnsinnsmodus ab"
  },
  Task_125422_Desc = {
    Text = "Schließe \"Durch Groll gebunden\" in beliebigem Modus ab"
  },
  Task_125423_Desc = {
    Text = "Verwende einen beliebigen Ultra-Erwecker, um einmal in \"Obsidian-Matriarchin\" zu gewinnen"
  },
  Task_125424_Desc = {
    Text = "Schließe \"Die Spur des Duftes\" in beliebigem Modus ab"
  },
  Task_125425_Desc = {
    Text = "Schließe \"Ordnung der Schwellenden Gnade\" im Wahnsinnsmodus ab"
  },
  Task_125426_Desc = {
    Text = "Erleuchte 6 bei Erhalt von Xu"
  },
  Task_125426_Name = {
    Text = "Erleuchte 6 bei Erhalt von Xu"
  },
  Task_125426_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Xu Erleuchten Paket 2 Aktivität"
  },
  Task_125427_Desc = {
    Text = "Schließe \"Seidene Falle\" in beliebigem Schwierigkeitsgrad ab"
  },
  Task_125428_Desc = {
    Text = "Vollständige alle Erfolge von \"Obsidian-Matriarchin: Bereinigt\""
  },
  Task_125429_Desc = {
    Text = "Schließe \"Auferstehung des Leichnams\" in beliebigem Modus ab"
  },
  Task_125430_Desc = {
    Text = "Schließe \"Seidene Falle\" im Wahnsinnsmodus ab"
  },
  Task_125431_Desc = {
    Text = "Schließe \"Ordnung der schwellenden Gnade\" in beliebigem Modus ab"
  },
  Task_125432_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_125433_Desc = {
    Text = "Schließe \"Ungerechter Tod\" in beliebigem Modus ab"
  },
  Task_125434_Desc = {
    Text = "Obsidian-Matriarch: Wahnsinn"
  },
  Task_125435_Desc = {
    Text = "Schließe \"Leichnam-Aufstieg\" im Wahnsinnsmodus ab"
  },
  Task_125500_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_125500_Name = {Text = "6 Siege"},
  Task_125501_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_125501_Name = {Text = "10 Siege"},
  Task_125502_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_125502_Name = {Text = "1 Sieg"},
  Task_125503_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_125503_Name = {Text = "3 Siege"},
  Task_125686_Desc = {
    Text = "Flucht vor der Verfolgung"
  },
  Task_125686_Name = {Text = "Ziel"},
  Task_125687_Desc = {
    Text = "Aus dem Hinterhalt überleben"
  },
  Task_125687_Name = {Text = "Ziel"},
  Task_125688_Desc = {
    Text = "Liz' Körper zurückerobern"
  },
  Task_125688_Name = {Text = "Ziel"},
  Task_125689_Desc = {
    Text = "Entkommen aus Arachne's Falle"
  },
  Task_125689_Name = {Text = "Ziel"},
  Task_125690_Desc = {
    Text = "Versiegelung der drei Plasmide aufheben"
  },
  Task_125690_Name = {Text = "Ziel"},
  Task_125691_Desc = {
    Text = "Gegner im Wirtshaus bekämpfen"
  },
  Task_125691_Name = {Text = "Ziel"},
  Task_125692_Desc = {
    Text = "Zerstöre die Mutanten"
  },
  Task_125692_Name = {Text = "Ziel"},
  Task_125693_Desc = {
    Text = "Rette die „Güte\""
  },
  Task_125693_Name = {Text = "Ziel"},
  Task_125694_Desc = {
    Text = "Sorel schützen"
  },
  Task_125694_Name = {Text = "Ziel"},
  Task_125695_Desc = {
    Text = "Rache für die „Erinnerung\""
  },
  Task_125695_Name = {Text = "Ziel"},
  Task_125845_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_125845_Name = {
    Text = "Perfekter Pass"
  },
  Task_125846_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_125846_Name = {
    Text = "Perfekter Pass"
  },
  Task_125847_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_125847_Name = {
    Text = "Perfekter Pass"
  },
  Task_125848_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_125848_Name = {
    Text = "Perfekter Pass"
  },
  Task_125849_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_125849_Name = {
    Text = "Perfekter Pass"
  },
  Task_125850_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_125850_Name = {
    Text = "Perfekter Pass"
  },
  Task_125851_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_125851_Name = {
    Text = "Perfekter Pass"
  },
  Task_125852_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_125852_Name = {
    Text = "Perfekter Pass"
  },
  Task_125853_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_125853_Name = {
    Text = "Perfekter Pass"
  },
  Task_125854_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_125854_Name = {
    Text = "Perfekter Pass"
  },
  Task_126276_Desc = {
    Text = "Schließe „Bitte keine Spoiler\" im Wahnsinnsmodus ab"
  },
  Task_126277_Desc = {
    Text = "Bühne der Puppe·Wahnsinn"
  },
  Task_126279_Desc = {
    Text = "Gewinne mit Tiefseewachkörpern einmal in „Bühne der Puppe\""
  },
  Task_126280_Desc = {
    Text = "Bühne der Puppe·Abschluss"
  },
  Task_126281_Desc = {
    Text = "Schließe „Verbrennung\" auf einem beliebigen Schwierigkeitsgrad ab"
  },
  Task_126282_Desc = {
    Text = "Schließe „Bitte keine Spoiler\" auf einem beliebigen Schwierigkeitsgrad ab"
  },
  Task_126285_Desc = {
    Text = "Schließe „Eintritt\" auf einem beliebigen Schwierigkeitsgrad ab"
  },
  Task_126286_Desc = {
    Text = "Schließe „Umkehren, umkehren\" auf einem beliebigen Schwierigkeitsgrad ab"
  },
  Task_126288_Desc = {
    Text = "Schließe „Waffe an der Wand\" auf einem beliebigen Schwierigkeitsgrad ab"
  },
  Task_126290_Desc = {
    Text = "Schließe „Verbrennung\" im Wahnsinnsmodus ab"
  },
  Task_126292_Desc = {
    Text = "Schließe „Waffe an der Wand\" im Wahnsinnsmodus ab"
  },
  Task_126293_Desc = {
    Text = "Schließe „Verbrennung\" auf einem beliebigen Schwierigkeitsgrad ab"
  },
  Task_126294_Desc = {
    Text = "Schließe alle Errungenschaften von „Bühne der Puppe·Abschluss\" ab"
  },
  Task_126295_Desc = {
    Text = "Gewinne mit Hyperdimensionalen Erwachungsbodys einmal in „Bühne der Puppe\""
  },
  Task_126296_Desc = {
    Text = "Schließe „Umkehren, umkehren\" im Wahnsinnsmodus ab"
  },
  Task_126297_Desc = {
    Text = "Schließe „Eintritt\" im Wahnsinnsmodus ab"
  },
  Task_126298_Desc = {
    Text = "Bühne der Puppe: Reich"
  },
  Task_126299_Desc = {
    Text = "Gewinne mit Tiefseewachkörpern zweimal in „Bühne der Puppe\""
  },
  Task_126302_Desc = {
    Text = "Gewinne mit Chaoswachkörpern zweimal in „Bühne der Puppe\""
  },
  Task_126303_Desc = {
    Text = "Schließe „Eintritt\" auf einem beliebigen Schwierigkeitsgrad ab"
  },
  Task_126304_Desc = {
    Text = "Gewinne mit Fleisch-Erwachungskörpern zweimal in „Bühne der Puppe\""
  },
  Task_126305_Desc = {
    Text = "Schließe „Bitte keine Spoiler\" auf einem beliebigen Schwierigkeitsgrad ab"
  },
  Task_126307_Desc = {
    Text = "Schließe „Waffe an der Wand\" auf einem beliebigen Schwierigkeitsgrad ab"
  },
  Task_126309_Desc = {
    Text = "Gewinne mit Fleisch-Erwachungskörpern einmal in „Bühne der Puppe\""
  },
  Task_126311_Desc = {
    Text = "Gewinne mit Hyperdimensionalen Erwachungsbodys zweimal in „Bühne der Puppe\""
  },
  Task_126312_Desc = {
    Text = "Gewinne mit Chaoswachkörpern einmal in „Bühne der Puppe\""
  },
  Task_126313_Desc = {
    Text = "Schließe „Umkehren, umkehren\" auf einem beliebigen Schwierigkeitsgrad ab"
  },
  Task_126385_Desc = {
    Text = "Abgeschlossen Sternekapitel Kapitel 5 „Schicksalsweber-Theater\" Schwierigkeit"
  },
  Task_126386_Desc = {
    Text = "Abgeschlossen Sternekapitel Kapitel 5 „Schicksalsweber-Theater\" Schwierigkeit"
  },
  Task_126387_Desc = {
    Text = "Schließe Sternekapitel 5–7 ab"
  },
  Task_126388_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_126390_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_126391_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_126392_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_126393_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_126394_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_126395_Desc = {
    Text = "Abgeschlossen Sternekapitel Kapitel 5 „Schicksalsweber-Theater\""
  },
  Task_126396_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_126397_Desc = {
    Text = "Schließe Sternekapitel 5–6 ab: Schwierig"
  },
  Task_126398_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_126399_Desc = {
    Text = "Schließe Sternekapitel 5–6 ab: Schwierig"
  },
  Task_126400_Desc = {
    Text = "Schließe Sternekapitel 5–7 ab"
  },
  Task_126401_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_126402_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_126403_Desc = {
    Text = "Abgeschlossen Sternekapitel Kapitel 5 „Schicksalsweber-Theater\""
  },
  Task_126493_Desc = {
    Text = "Panlong Monologe VII"
  },
  Task_126494_Desc = {
    Text = "Panlong Monologe: Zeitlich begrenzte Exklusivität"
  },
  Task_126495_Desc = {
    Text = "Panlong Monologe V"
  },
  Task_126496_Desc = {
    Text = "Panlong Monologe I"
  },
  Task_126497_Desc = {
    Text = "Panlong Monologe VI"
  },
  Task_126498_Desc = {
    Text = "Panlong Monologe III"
  },
  Task_126499_Desc = {
    Text = "Panlong Monologe IV"
  },
  Task_126500_Desc = {
    Text = "Panlong Monologe: Kostenlos"
  },
  Task_126501_Desc = {
    Text = "Panlong Monologe II"
  },
  Task_127071_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_127071_Name = {Text = "10 Siege"},
  Task_127072_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_127072_Name = {Text = "3 Siege"},
  Task_127073_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_127073_Name = {Text = "6 Siege"},
  Task_127074_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_127074_Name = {Text = "1 Sieg"},
  Task_127094_Desc = {
    Text = "Aurita Erleuchtung erreicht Psyche Surge 12"
  },
  Task_127095_Desc = {
    Text = "Genesis Ramona Erleuchtung erreicht Psyche Surge 12"
  },
  Task_127096_Desc = {
    Text = "Ramona Erleuchtung erreicht Psyche-Ansturm 12"
  },
  Task_127097_Desc = {
    Text = "Aigis Erleuchtung erreicht Psyche-Anstieg 12"
  },
  Task_127098_Desc = {
    Text = "Lotan Erleuchtung erreicht Psyche-Anstieg 12"
  },
  Task_127099_Desc = {
    Text = "Erica erleuchtet erreicht Psyche-Anstieg 12"
  },
  Task_127100_Desc = {
    Text = "Puppe Erleuchtung erreicht Psyche Aufschwung 12"
  },
  Task_127101_Desc = {
    Text = "Ogier Erleuchtung erreicht Psyche-Anstieg 12"
  },
  Task_129511_Desc = {
    Text = "Beseitige jede Schwierigkeit auf Schwierig- oder Wahnsinnsmodus mit einem Team, das aus 3 Fleisch- und 1 Ultra-Erwecker besteht"
  },
  Task_129512_Desc = {
    Text = "Nutzen Sie ein Team, das aus 3 Chaos und 1 hyperdimensionalem Erwecker besteht, um den Schwierigkeitsgrad oder den Wahnsinnsmodus abzuschließen"
  },
  Task_129513_Desc = {
    Text = "Spur der Schienenlänge·Schwierig"
  },
  Task_129513_Name = {
    Text = "Spur der Schienenlänge·Schwierig"
  },
  Task_129514_Desc = {
    Text = "Schließe die dritte Stufe des Wahnsinns-Schwierigkeitsgrads ab"
  },
  Task_129515_Desc = {
    Text = "Abgeschlossen mit einem Team, das aus 1 Fleisch und 3 hyperdimensionalen Erweckern besteht, im schwierigen oder im Wahnsinnsmodus"
  },
  Task_129516_Desc = {
    Text = "Phase 3: Besiege „Schmelzen · Dor\" auf beliebiger Schwierigkeit"
  },
  Task_129517_Desc = {
    Text = "Phase 3: Besiege „Paradies-Schleier\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_129518_Desc = {
    Text = "Vollende alle Aufgaben von „Spur der Schienenlänge: Schwierig\""
  },
  Task_129519_Desc = {
    Text = "Verwenden Sie ein Team aus 4 hyperdimensionalen Erwachungsbody, um jede Schwierigkeit abzuschließen"
  },
  Task_129520_Desc = {
    Text = "Schließe die zweite Stufe des Schwierigkeitsgrads Normal ab"
  },
  Task_129521_Desc = {
    Text = "Phase 2: Besiege Hydra in beliebigem Schwierigkeitsgrad"
  },
  Task_129522_Desc = {
    Text = "Verwenden Sie ein Team, das aus 4 Fleisch-Erwachungskörpern besteht, um jeden Schwierigkeitsgrad abzuschließen"
  },
  Task_129523_Desc = {
    Text = "Verwenden Sie ein Team, das aus 2 Fleisch-Erweckern und 2 ultra Erweckern besteht, um ein beliebiges Schwierigkeitslevel abzuschließen"
  },
  Task_129524_Desc = {
    Text = "Verwenden Sie ein Team aus 3 Aequor und 1 Fleisch-Erwachungskörper, um im Schwierigkeitsgrad oder im Wahnsinnsmodus abzuschließen"
  },
  Task_129525_Desc = {
    Text = "Schließe die erste Stufe des Schwierigkeitsgrads Normal ab"
  },
  Task_129526_Desc = {
    Text = "Verwenden Sie ein Team, das aus 2 Chaos und 2 Fleisch-Erwachungskörper besteht, um einen beliebigen Schwierigkeitsgrad abzuschließen"
  },
  Task_129527_Desc = {
    Text = "Beseitige jede Schwierigkeit auf Schwierig- oder Wahnsinnsmodus mit einem Team, das aus 3 Chaos- und 1 Fleisch-Erwecker besteht"
  },
  Task_129528_Desc = {
    Text = "Alle Aufgaben von “Unterwegs Erinnerungen festhalten·Freude Korridor“ abschließen"
  },
  Task_129529_Desc = {
    Text = "Schließe die dritte Stufe des Schwierigkeitsgrads Normal ab"
  },
  Task_129530_Desc = {
    Text = "Verwenden Sie ein Team, das aus 3 Chaos und 1 Tiefseewachkörper besteht, um den Schwierigkeitsgrad oder den Wahnsinnsmodus abzuschließen"
  },
  Task_129531_Desc = {
    Text = "Phase 1: Besiege „▼Ah▼▼ya\" in beliebigem Schwierigkeitsgrad"
  },
  Task_129532_Desc = {
    Text = "Schließe die zweite Stufe des Schwierigkeitsgrads Schwierig ab"
  },
  Task_129533_Desc = {
    Text = "Schließe die erste Stufe des Wahnsinns-Schwierigkeitsgrads ab"
  },
  Task_129534_Desc = {
    Text = "Unterwegs Erinnerungen festhalten·Echos der Vergangenheit"
  },
  Task_129534_Name = {
    Text = "Unterwegs Erinnerungen festhalten·Echos der Vergangenheit"
  },
  Task_129535_Desc = {
    Text = "Phase 3: Besiege „ Marionette der faulen Flut \" auf beliebigem Schwierigkeitsgrad"
  },
  Task_129536_Desc = {
    Text = "Unterwegs Erinnerungen festhalten·Freude Korridor"
  },
  Task_129536_Name = {
    Text = "Unterwegs Erinnerungen festhalten·Freudiger Korridor"
  },
  Task_129537_Desc = {
    Text = "Phase 3: Besiege „Ultra @2 Chrysalis\" auf beliebiger Schwierigkeit"
  },
  Task_129538_Desc = {
    Text = "Abschließen jeder Schwierigkeit mit einem Team, das aus 2 Aequor- und 2 Fleisch-Erweckern besteht"
  },
  Task_129539_Desc = {
    Text = "Phase 2: Besiege „Fruchtbarkeitsmutterbaum\" in beliebiger Schwierigkeit"
  },
  Task_129540_Desc = {
    Text = "Phase 1: Besiege „Heulsuse Joe▼\" in beliebigem Modus"
  },
  Task_129541_Desc = {
    Text = "Verwenden Sie ein Team, das aus 2 Chaos und 2 Tiefseewachkörpern besteht, um beliebige Schwierigkeitsgrade abzuschließen"
  },
  Task_129542_Desc = {
    Text = "Schließe die dritte Stufe des Schwierigkeitsgrads Schwierig ab"
  },
  Task_129543_Desc = {
    Text = "Phase 1: Besiege „reparieren▼▼\" in beliebigem Schwierigkeitsgrad"
  },
  Task_129544_Desc = {
    Text = "Beseitige jede Schwierigkeit auf Schwierig- oder Wahnsinnsmodus mit einem Team, das aus 3 Aequor- und 1 Hyperdimensionaler Erwachungsbody besteht"
  },
  Task_129545_Desc = {
    Text = "Abschluss der zweiten Stufe im Wahnsinnsmodus"
  },
  Task_129546_Desc = {
    Text = "Phase 1: Besiege „Dimensionsschiffender Hund\" in beliebiger Schwierigkeit"
  },
  Task_129547_Desc = {
    Text = "Phase 2: Besiege Zwielichtkonflikt in beliebigem Schwierigkeitsgrad"
  },
  Task_129548_Desc = {
    Text = "Beseitige jede Schwierigkeit auf Schwierig- oder Wahnsinnsmodus mit einem Team, das aus 1 Aequor und 3 Fleisch-Erwachungskörpern besteht"
  },
  Task_129549_Desc = {
    Text = "Verwenden Sie ein Team, das aus 2 Chaos und 2 hyperdimensionalen Erwachungsbody besteht, um einen beliebigen Schwierigkeitsgrad abzuschließen"
  },
  Task_129550_Desc = {
    Text = "Schließe die erste Stufe des Schwierigkeitsgrads Schwierig ab"
  },
  Task_129551_Desc = {
    Text = "Alle Aufgaben von „Spur der Schienenlänge · Normal\" abschließen"
  },
  Task_129552_Desc = {
    Text = "Verwende ein Team, das aus 2 Aequor- und 2 Ultra-Erweckern besteht, um jede Schwierigkeit abzuschließen"
  },
  Task_129553_Desc = {
    Text = "Spur der Schienenlänge · Normal"
  },
  Task_129553_Name = {
    Text = "Spur der Schienenlänge · Normal"
  },
  Task_129554_Desc = {
    Text = "Beseitige jede Schwierigkeit auf Schwierig- oder Wahnsinnsmodus mit einem Team, das aus 1 Chaos- und 3 Fleisch-Erweckern besteht"
  },
  Task_129555_Desc = {
    Text = "Verwenden Sie ein Team, das aus 1 Chaos und 3 hyperdimensionalen Erweckungskörpern besteht, um den Schwierigkeitsgrad oder den Wahnsinnsmodus abzuschließen"
  },
  Task_129556_Desc = {
    Text = "Verwende ein Team aus 4 Tiefseewachkörpern, um ein beliebiges Schwierigkeitsniveau abzuschließen"
  },
  Task_129557_Desc = {
    Text = "Nutzen Sie ein Team, das aus 1 Chaos und 3 Tiefseewachkörpern besteht, um den Schwierigkeitsgrad oder den Wahnsinnsmodus abzuschließen"
  },
  Task_129558_Desc = {
    Text = "Verwenden Sie ein Team, das aus 1 Aequor und 3 hyperdimensionalen Erweckungsleibern besteht, um den Schwierigkeitsgrad oder den Wahnsinnsmodus abzuschließen"
  },
  Task_129559_Desc = {
    Text = "Verwenden Sie ein Team aus 4 Chaoswachkörpern, um eine beliebige Schwierigkeit abzuschließen"
  },
  Task_129560_Desc = {
    Text = "Alle Aufgaben von “Unterwegs Erinnerungen festhalten·Vergangene Erinnerungen“ abschließen"
  },
  Task_129561_Desc = {
    Text = "Phase 2: Besiege „ Heiliges Kind \" in beliebigem Modus"
  },
  Task_129895_Desc = {
    Text = "Abschluss des Sondereinsatzprotokolls „Der Zug zum Qisui-Festival\""
  },
  Task_129895_Name = {
    Text = "Im Knallen der Feuerwerkskörper wird ein Jahr verabschiedet"
  },
  Task_130180_Desc = {
    Text = "Abgeschlossen Multidimensionale Verbindung „vergessene Liebe Samen\""
  },
  Task_130181_Desc = {
    Text = "Abgeschlossen „Schlummertrunk\" im Wahnsinnsmodus"
  },
  Task_130182_Desc = {
    Text = "Abgeschlossen „Esstisch\" in beliebigem Schwierigkeitsgrad"
  },
  Task_130183_Desc = {
    Text = "Gewinne zweimal mit Tiefseewachkörpern in „Umgekehrtes Neugeboren\""
  },
  Task_130184_Desc = {
    Text = "Gewinne einmal mit Fleisch-Erwachungskörpern in „Umgekehrtes Neugeboren\""
  },
  Task_130185_Desc = {
    Text = "Abgeschlossen „In der Schule\" in beliebigem Schwierigkeitsgrad"
  },
  Task_130186_Desc = {
    Text = "Schließe „Krankenhaus\" auf einem beliebigen Schwierigkeitsgrad ab"
  },
  Task_130187_Desc = {
    Text = "Abgeschlossen „Schlummertrunk\" in beliebigem Schwierigkeitsgrad"
  },
  Task_130188_Desc = {
    Text = "Schließe „Krankenhaus\" im Wahnsinnsmodus ab"
  },
  Task_130189_Desc = {
    Text = "Gewinne einmal mit Chaoswachkörpern in „Umgekehrtes Neugeboren\""
  },
  Task_130190_Desc = {
    Text = "Gewinne zweimal mit Fleisch-Erwachungskörpern in „Umgekehrtes Neugeboren\""
  },
  Task_130191_Desc = {
    Text = "Abgeschlossen „Der Brunnen\" im Wahnsinnsmodus"
  },
  Task_130192_Desc = {
    Text = "Gewinne zweimal mit Hyperdimensionaler Erwachungsbodys in „Umgekehrtes Neugeboren\""
  },
  Task_130193_Desc = {
    Text = "Abgeschlossen „In der Schule\" im Wahnsinnsmodus"
  },
  Task_130194_Desc = {
    Text = "Abgeschlossen „Esstisch\" in beliebigem Schwierigkeitsgrad"
  },
  Task_130195_Desc = {
    Text = "Schließe „Unser Zuhause\" auf einem beliebigen Schwierigkeitsgrad ab"
  },
  Task_130196_Desc = {
    Text = "Abgeschlossen „Schlummertrunk\" in beliebigem Schwierigkeitsgrad"
  },
  Task_130197_Desc = {
    Text = "Abgeschlossen „Neurotrauma\" in beliebigem Schwierigkeitsgrad"
  },
  Task_130198_Desc = {
    Text = "Gewinne einmal mit Tiefseewachkörpern in „Umgekehrtes Neugeboren\""
  },
  Task_130199_Desc = {
    Text = "Abgeschlossen „Neurotrauma\" in beliebigem Schwierigkeitsgrad"
  },
  Task_130200_Desc = {
    Text = "Abgeschlossen „Der Brunnen\" in beliebigem Schwierigkeitsgrad"
  },
  Task_130201_Desc = {
    Text = "Schließe „Unser Zuhause\" auf einem beliebigen Schwierigkeitsgrad ab"
  },
  Task_130202_Desc = {
    Text = "Abgeschlossen „In der Schule\" in beliebigem Schwierigkeitsgrad"
  },
  Task_130203_Desc = {
    Text = "Schließe „Krankenhaus\" auf einem beliebigen Schwierigkeitsgrad ab"
  },
  Task_130204_Desc = {
    Text = "Abgeschlossen „Der Brunnen\" in beliebigem Schwierigkeitsgrad"
  },
  Task_130205_Desc = {
    Text = "Umgekehrtes Neugeboren·Wahnsinn"
  },
  Task_130206_Desc = {
    Text = "Schließe „Unser Zuhause\" im Wahnsinnsmodus ab"
  },
  Task_130207_Desc = {
    Text = "Abgeschlossen „Neurotrauma\" im Wahnsinnsmodus"
  },
  Task_130208_Desc = {
    Text = "Umgekehrtes Neugeboren: Reich"
  },
  Task_130209_Desc = {
    Text = "Schließe alle Erfolge von „Umgekehrtes Neugeboren·Abschluss\" ab"
  },
  Task_130210_Desc = {
    Text = "Umgekehrtes Neugeboren·Abschluss"
  },
  Task_130211_Desc = {
    Text = "Gewinne einmal mit Hyperdimensionaler Erwachungsbodys in „Umgekehrtes Neugeboren\""
  },
  Task_130212_Desc = {
    Text = "Abgeschlossen „Esstisch\" im Wahnsinnsmodus"
  },
  Task_130213_Desc = {
    Text = "Gewinne zweimal mit Chaoswachkörpern in „Umgekehrtes Neugeboren\""
  },
  Task_130412_Desc = {
    Text = "Erwirb Ursprung Ogier bei Erleuchtung 2"
  },
  Task_130412_Name = {
    Text = "Erwirb Ursprung Ogier bei Erleuchtung 2"
  },
  Task_130412_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Ursprung Ogier Erleuchten Paket 2 Aktivität"
  },
  Task_130413_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_130414_Desc = {
    Text = "Erhalte Saya bei der Erleuchtung 2"
  },
  Task_130414_Name = {
    Text = "Erhalte Saya bei der Erleuchtung 2"
  },
  Task_130414_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Sha Ye Erleuchten Paket 2 Aktivität"
  },
  Task_130416_Desc = {
    Text = "Erwirb Shaye bei Erwachen 6"
  },
  Task_130416_Name = {
    Text = "Erwirb Shaye bei Erwachen 6"
  },
  Task_130416_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Sha Ye Erleuchten Paket 2 Aktivität"
  },
  Task_130417_Desc = {
    Text = "Erwirb Satogua bei Erwachen 2"
  },
  Task_130417_Name = {
    Text = "Erwirb Satogua bei Erwachen 2"
  },
  Task_130417_UnlockCondDesc = {
    Text = "Aktivität @Erweckungswesen Satogua Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_130418_Desc = {
    Text = "Erwirb Satogua bei Erleuchtung 6"
  },
  Task_130418_Name = {
    Text = "Erwirb Satogua bei Erleuchtung 6"
  },
  Task_130418_UnlockCondDesc = {
    Text = "Aktivität @Erweckungswesen Satogua Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_130420_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_130421_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_130424_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_130425_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_130427_Desc = {
    Text = "Erwirb Ursprung Ogier bei Erwachen 6"
  },
  Task_130427_Name = {
    Text = "Erwirb Ursprung Ogier bei Erwachen 6"
  },
  Task_130427_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Ursprung Ogier Erleuchten Paket 2 Aktivität"
  },
  Task_130429_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_130440_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_130441_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_130442_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_130446_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_130447_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_130448_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_130459_Desc = {
    Text = "Ursprung Ogier hat die Affinität von Stufe 10 erreicht"
  },
  Task_130460_Desc = {
    Text = "Satogua hat die Synchro-Rate von Stufe 10 erreicht"
  },
  Task_130461_Desc = {
    Text = "Saya erreicht die Affinität Stufe 10"
  },
  Task_130555_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_130555_Name = {Text = "3 Siege"},
  Task_130556_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_130556_Name = {Text = "10 Siege"},
  Task_130557_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_130557_Name = {Text = "1 Sieg"},
  Task_130558_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_130558_Name = {Text = "6 Siege"},
  Task_130950_Desc = {
    Text = "Abschluss von „Großer Strudel\" im Wahnsinnsmodus"
  },
  Task_130951_Desc = {
    Text = "Abschluss von „Gewöhnlicher Tag\" im Wahnsinnsmodus"
  },
  Task_130952_Desc = {
    Text = "Abschluss von „Donnernder Sturm\" in beliebigem Modus"
  },
  Task_130953_Desc = {
    Text = "Abschluss „Gefährten entdecken\" Wahnsinn-Schwierigkeitsgrad"
  },
  Task_130954_Desc = {
    Text = "Mosk und Meer·Reich"
  },
  Task_130956_Desc = {
    Text = "Alle Erfolge von „Mosk und Meer·Abschluss\" abschließen"
  },
  Task_130957_Desc = {
    Text = "Abschluss „Großer Strudel\" beliebiger Schwierigkeitsgrad"
  },
  Task_130958_Desc = {
    Text = "Erwirb Mosk bei Erleuchtung 6"
  },
  Task_130958_Name = {
    Text = "Erwirb Mosk bei Erleuchtung 6"
  },
  Task_130958_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Mosk Erwachen Paket 2 Aktivität"
  },
  Task_130959_Desc = {
    Text = "Abschluss „Großer Strudel\" beliebiger Schwierigkeitsgrad"
  },
  Task_130960_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_130961_Desc = {
    Text = "Mosk und Meer·Abschluss"
  },
  Task_130962_Desc = {
    Text = "Abschluss von „Rückkehrweg\" in beliebigem Modus"
  },
  Task_130963_Desc = {
    Text = "Abgeschlossen Bewusstseinsdrift„Sucht\""
  },
  Task_130964_Desc = {
    Text = "Mit einem Chaos-Reich-Erwecker im „Mosk und Meer\" 2-mal gewinnen"
  },
  Task_130965_Desc = {
    Text = "Abschluss von „Ein gewöhnlicher Tag\" in beliebiger Schwierigkeit"
  },
  Task_130966_Desc = {
    Text = "Abschluss von „Zeit des Aussegelns\" in beliebigem Modus"
  },
  Task_130967_Desc = {
    Text = "Abschluss von „Rückkehrweg\" in beliebigem Modus"
  },
  Task_130968_Desc = {
    Text = "Abschluss „Gefährten entdecken\" in beliebiger Schwierigkeit"
  },
  Task_130970_Desc = {
    Text = "Erwirb Mosk bei Erweckung 2"
  },
  Task_130970_Name = {
    Text = "Erwirb Mosk bei Erweckung 2"
  },
  Task_130970_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Mosk Erwachen Paket 2 Aktivität"
  },
  Task_130971_Desc = {
    Text = "Mit einem Fleisch-Reich-Erwecker einmal im „Mosk und Meer\" gewinnen"
  },
  Task_130972_Desc = {
    Text = "Abschluss von „Donnernder Sturm\" in beliebigem Modus"
  },
  Task_130973_Desc = {
    Text = "Abgeschlossen „Schatz der Drift\" im Wahnsinnsmodus"
  },
  Task_130974_Desc = {
    Text = "Abschluss von „Ausfahrt\" im Wahnsinnsmodus"
  },
  Task_130975_Desc = {
    Text = "Mosk hat die Synchro-Rate von Stufe 10 erreicht"
  },
  Task_130976_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_130977_Desc = {
    Text = "Abschluss „Gefährten entdecken\" in beliebiger Schwierigkeit"
  },
  Task_130978_Desc = {
    Text = "Mit einem Aequor-Reich Erwecker in der „Mosk und Meer\" einmal gewinnen"
  },
  Task_130979_Desc = {
    Text = "Abschluss von „Donnernde Gewitter\" im Wahnsinnsmodus"
  },
  Task_130980_Desc = {
    Text = "Mit einem Chaos-Reich-Erwecker im „Mosk und Meer\" einmal gewinnen"
  },
  Task_130981_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_130982_Desc = {
    Text = "Abgeschlossen von „Rückkehrweg\" im Wahnsinnsmodus"
  },
  Task_130983_Desc = {
    Text = "Mit einem Ultra Reich Erwecker im „Mosk und Meer\" 2-mal gewinnen"
  },
  Task_130984_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_130985_Desc = {
    Text = "Abschluss von „Zeit des Aussegelns\" in beliebigem Modus"
  },
  Task_130986_Desc = {
    Text = "Zweimal mit einem Aequor-Reich Erwecker im „Mosk und Meer\" gewinnen"
  },
  Task_130987_Desc = {
    Text = "Mit einem Fleisch-Reich-Erwecker im „Mosk und Meer\" 2-mal gewinnen"
  },
  Task_130988_Desc = {
    Text = "Abschluss „Schatz der Drift\" beliebiger Schwierigkeitsgrad"
  },
  Task_130989_Desc = {
    Text = "Mit einem Ultra-Reich Erwecker einmal im „Mosk und Meer\" gewinnen"
  },
  Task_130990_Desc = {
    Text = "Abschluss von „Ein gewöhnlicher Tag\" in beliebiger Schwierigkeit"
  },
  Task_130991_Desc = {
    Text = "Abschluss „Schatz der Drift\" beliebiger Schwierigkeitsgrad"
  },
  Task_130992_Desc = {
    Text = "Mosk und Meer·Wahnsinn"
  },
  Task_131106_Desc = {
    Text = "Nefraea stoppen"
  },
  Task_131106_Name = {Text = "Ziel"},
  Task_131172_Desc = {
    Text = "Konjugierte Schicksalswege · Zeitlich begrenzt exklusiv"
  },
  Task_131371_Desc = {
    Text = "Regionaler D-Effekt Spezialtraining erreicht 100"
  },
  Task_131372_Desc = {
    Text = "30 Mal erwachen"
  },
  Task_131373_Desc = {
    Text = "30 Mal erwachen"
  },
  Task_131374_Desc = {
    Text = "3-mal tägliches Training abschließen"
  },
  Task_131375_Desc = {
    Text = "Schließe alle wöchentlichen Prüfungsaufgaben für 1 Woche ab"
  },
  Task_131376_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_131377_Desc = {
    Text = "Vollständig 20 Aufgaben"
  },
  Task_131378_Desc = {
    Text = "Schließe alle wöchentlichen Prüfungsaufgaben für 1 Woche ab"
  },
  Task_131379_Desc = {
    Text = "Regionaler D-Effekt Spezialtraining erreicht 100"
  },
  Task_131380_Desc = {
    Text = "Vollständig 20 Aufgaben"
  },
  Task_131381_Desc = {
    Text = "1 Mal Transzendente Existenz abschließen"
  },
  Task_131382_Desc = {
    Text = "3-mal tägliches Training abschließen"
  },
  Task_131383_Desc = {
    Text = "1 Mal Transzendente Existenz abschließen"
  },
  Task_131384_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_131385_Desc = {
    Text = "1x Ryker-Demo-Level abschließen"
  },
  Task_131386_Desc = {
    Text = "1x Ryker-Demo-Level abschließen"
  },
  Task_131450_Desc = {
    Text = "Besiege 60 Erwecker im Phasenduell"
  },
  Task_131451_Desc = {
    Text = "Besiege 36 Erwecker im Phasenduell"
  },
  Task_131452_Desc = {
    Text = "Im Vorgruppierungsmodus 10 Siege errungen"
  },
  Task_131453_Desc = {
    Text = "Spiele 740 Karten im Phasenduell"
  },
  Task_131454_Desc = {
    Text = "Verherrlichung in Phasenduell 108 Mal freigeben"
  },
  Task_131455_Desc = {
    Text = "Im Phasenduell 192 Mal Exaltieren freigeben"
  },
  Task_131456_Desc = {
    Text = "In Phasenduell 60 Mal Verherrlichung freigeben"
  },
  Task_131457_Desc = {
    Text = "Besiege 111 Erwecker im Phasenduell"
  },
  Task_131458_Desc = {
    Text = "Karten 300 Mal im Phasenduell ausspielen"
  },
  Task_131459_Desc = {
    Text = "480 Karten im Phasenduell ausspielen"
  },
  Task_131460_Desc = {
    Text = "Spiele 320 Karten im Phasenduell aus"
  },
  Task_131461_Desc = {
    Text = "Besiege 6 Erwecker im Phasenduell"
  },
  Task_131462_Desc = {
    Text = "Besiege 129 Erweckte im Phasenduell"
  },
  Task_131463_Desc = {
    Text = "In einem Phasenduell 102 Mal Verherrlichung freigeben"
  },
  Task_131464_Desc = {
    Text = "Spiele 100 Karten im Phasenduell"
  },
  Task_131465_Desc = {
    Text = "66 Mal Verherrlichung im Phasenduell freigeben"
  },
  Task_131466_Desc = {
    Text = "Besiege 12 Erwecker im Phasenduell"
  },
  Task_131467_Desc = {
    Text = "Erzielen Sie insgesamt 45 Siege im Phasenduell"
  },
  Task_131468_Desc = {
    Text = "In Phasenduell 54 Mal Verherrlichung freigeben"
  },
  Task_131469_Desc = {
    Text = "Im Phasenduell 240 Mal Verherrlichung freigeben"
  },
  Task_131470_Desc = {
    Text = "Besiege 99 Erwecker im Phasenduell"
  },
  Task_131471_Desc = {
    Text = "Besiege 87 Erweckte im Phasenduell"
  },
  Task_131472_Desc = {
    Text = "Im Wahlmodus, noch eine Runde spielen und 1 Gegner besiegen"
  },
  Task_131473_Desc = {
    Text = "Besiege 30 Erwecker im Phasenduell"
  },
  Task_131474_Desc = {
    Text = "Im Vorgruppierungsmodus 1 Mal zwei aufeinanderfolgende Siege"
  },
  Task_131475_Desc = {
    Text = "Im Wahlmodus 2 Siege erzielen"
  },
  Task_131476_Desc = {
    Text = "Im Phasenduell 156 Mal Verherrlichung freigeben"
  },
  Task_131477_Desc = {
    Text = "Im Wahlmodus 6 Siege erzielen"
  },
  Task_131478_Desc = {
    Text = "Spiele 160 Karten im Phasenduell aus"
  },
  Task_131479_Desc = {
    Text = "Besiege 135 Erwecker im Phasenduell"
  },
  Task_131480_Desc = {
    Text = "880 Karten im Phasenduell ausspielen"
  },
  Task_131481_Desc = {
    Text = "Verherrlichung 132 Mal im Phasenduell freigeben"
  },
  Task_131482_Desc = {
    Text = "Im Phasenduell 204 Mal die Verherrlichung freigeben"
  },
  Task_131483_Desc = {
    Text = "Im Vorgruppierungsmodus 4 Siege erzielt"
  },
  Task_131484_Desc = {
    Text = "Im Phasenduell 144 Mal Verherrlichung freigeben"
  },
  Task_131485_Desc = {
    Text = "Spiele 240 Karten im Phasenduell aus"
  },
  Task_131486_Desc = {
    Text = "940 Karten im Phasenduell ausspielen"
  },
  Task_131487_Desc = {
    Text = "Im Phasenduell 210 Mal Verherrlichung freigeben"
  },
  Task_131488_Desc = {
    Text = "Im Phasenduell 174 Mal Exaltieren freigeben"
  },
  Task_131489_Desc = {
    Text = "Besiege 54 Erwecker im Phasenduell"
  },
  Task_131490_Desc = {
    Text = "Besiege 21 Erwecker im Phasenduell"
  },
  Task_131491_Desc = {
    Text = "Spiele 180 Karten im Phasenduell"
  },
  Task_131492_Desc = {
    Text = "Verdienstprüfung"
  },
  Task_131493_Desc = {
    Text = "Spiele 400 Karten im Phasenduell"
  },
  Task_131494_Desc = {
    Text = "Besiege 57 Erwecker im Phasenduell"
  },
  Task_131495_Desc = {
    Text = "Im Wahlmodus 8 Siege errungen"
  },
  Task_131496_Desc = {
    Text = "Besiege 81 Erwecker im Phasenduell"
  },
  Task_131497_Desc = {
    Text = "Besiege 93 Erwecker im Phasenduell"
  },
  Task_131498_Desc = {
    Text = "Besiege 120 Erwecker im Phasenduell"
  },
  Task_131499_Desc = {
    Text = "In einem Phasenduell 30 Mal Wahnsinn auslösen"
  },
  Task_131500_Desc = {
    Text = "Spiele 220 Karten im Phasenduell aus"
  },
  Task_131501_Desc = {
    Text = "Im Phasenduell 264 Mal die Verherrlichung freigeben"
  },
  Task_131502_Desc = {
    Text = "Besiege 102 Erwecker im Phasenduell"
  },
  Task_131503_Desc = {
    Text = "Spiele 140 Karten im Phasenduell"
  },
  Task_131504_Desc = {
    Text = "Im Phasenduell Verherrlichung 96 Mal freigeben"
  },
  Task_131505_Desc = {
    Text = "Im Vorgruppierungsmodus, spielen Sie eine weitere Runde und besiegen Sie 1 Mal den Gegner"
  },
  Task_131506_Desc = {
    Text = "In einem Phasenduell 78 Mal Verherrlichung freisetzen"
  },
  Task_131507_Desc = {
    Text = "Spiele 1000 Karten im Phasenduell"
  },
  Task_131508_Desc = {
    Text = "Verherrlichung in einem Phasenduell 90 Mal freigeben"
  },
  Task_131509_Desc = {
    Text = "Besiege 132 Erwecker im Phasenduell"
  },
  Task_131510_Desc = {
    Text = "Besiege 126 Erwecker im Phasenduell"
  },
  Task_131511_Desc = {
    Text = "Besiege 9 Erwecker im Phasenduell"
  },
  Task_131512_Desc = {
    Text = "Im Phasenduell 168 Mal Exaltieren freigeben"
  },
  Task_131513_Desc = {
    Text = "Im Phasenduell 162 Mal Verherrlichung freigeben"
  },
  Task_131514_Desc = {
    Text = "Verherrlichung 222 Mal im Phasenduell freigeben"
  },
  Task_131515_Desc = {
    Text = "Schwellenprüfung"
  },
  Task_131516_Desc = {
    Text = "Spiele 380 Karten im Phasenduell"
  },
  Task_131517_Desc = {
    Text = "660 Mal Karten im Phasenduell ausspielen"
  },
  Task_131518_Desc = {
    Text = "Verherrlichung in einem Phasenduell 114 Mal freigeben"
  },
  Task_131519_Desc = {
    Text = "Im Phasenduell 120 Mal Verherrlichung freigeben"
  },
  Task_131520_Desc = {
    Text = "Besiege 144 Erwecker im Phasenduell"
  },
  Task_131521_Desc = {
    Text = "Besiege 24 Erwecker im Phasenduell"
  },
  Task_131522_Desc = {
    Text = "Besiege 42 Erwecker im Phasenduell"
  },
  Task_131523_Desc = {
    Text = "Spiele 460 Karten im Phasenduell aus"
  },
  Task_131524_Desc = {
    Text = "Im Phasenduell 180 Mal Verherrlichung freigeben"
  },
  Task_131525_Desc = {
    Text = "Spiele 520 Karten im Phasenduell aus"
  },
  Task_131526_Desc = {
    Text = "840 Karten im Phasenduell ausspielen"
  },
  Task_131527_Desc = {
    Text = "Besiege 69 Erwecker im Phasenduell"
  },
  Task_131528_Desc = {
    Text = "Spiele 720 Karten im Phasenduell aus"
  },
  Task_131529_Desc = {
    Text = "Besiege 33 Erwecker im Phasenduell"
  },
  Task_131530_Desc = {
    Text = "Besiege 39 Erwecker im Phasenduell"
  },
  Task_131531_Desc = {
    Text = "Spiele 860 Karten im Phasenduell aus"
  },
  Task_131532_Desc = {
    Text = "Spiele 560 Karten im Phasenduell aus"
  },
  Task_131533_Desc = {
    Text = "600 Karten im Phasenduell ausspielen"
  },
  Task_131534_Desc = {
    Text = "Klicke im Phasenduell auf das Avatar, um 3 Gegnern beliebige Emojis zu senden"
  },
  Task_131535_Desc = {
    Text = "Besiege 66 Erwecker im Phasenduell"
  },
  Task_131536_Desc = {
    Text = "Spiele 200 Karten im Phasenduell aus"
  },
  Task_131537_Desc = {
    Text = "Im Wahlmodus 1 Sieg erzielen"
  },
  Task_131538_Desc = {
    Text = "Im Phasenduell 234 Mal Verherrlichung freigeben"
  },
  Task_131539_Desc = {
    Text = "820 Karten im Phasenduell ausspielen"
  },
  Task_131540_Desc = {
    Text = "Im Phasenduell 18 Mal Verherrlichung freigeben"
  },
  Task_131541_Desc = {
    Text = "Besiege 63 Erwecker im Phasenduell"
  },
  Task_131542_Desc = {
    Text = "In einem Phasenduell 258 Mal Exaltieren freigeben"
  },
  Task_131543_Desc = {
    Text = "Lobe den Gegner nach dem Ende des Phasenduells 1 Mal"
  },
  Task_131544_Desc = {
    Text = "Erziele insgesamt 25 Siege im Phasenduell"
  },
  Task_131545_Desc = {
    Text = "Besiege 27 Erwecker im Phasenduell"
  },
  Task_131546_Desc = {
    Text = "Besiege 18 Erwecker in einem Phasenduell"
  },
  Task_131547_Desc = {
    Text = "Besiege 150 Erwecker im Phasenduell"
  },
  Task_131548_Desc = {
    Text = "Im Phasenduell 48 Mal Exaltieren freigeben"
  },
  Task_131549_Desc = {
    Text = "Lege 20 Karten im Phasenduell ab"
  },
  Task_131550_Desc = {
    Text = "Im Phasenduell 36 Mal Verherrlichung freisetzen"
  },
  Task_131551_Desc = {
    Text = "Besiege 15 Erwecker im Phasenduell"
  },
  Task_131552_Desc = {
    Text = "Besiege 84 Erwecker im Phasenduell"
  },
  Task_131553_Desc = {
    Text = "280 Karten im Phasenduell ausspielen"
  },
  Task_131554_Desc = {
    Text = "In einem Phasenduell 72 Mal Verherrlichung freisetzen"
  },
  Task_131555_Desc = {
    Text = "Besiege 108 Erwecker im Phasenduell"
  },
  Task_131556_Desc = {
    Text = "Im Phasenduell 246 Mal die Verherrlichung freigeben"
  },
  Task_131557_Desc = {
    Text = "700 Karten im Phasenduell ausspielen"
  },
  Task_131558_Desc = {
    Text = "Gewinne insgesamt 35 Partien im Phasenduell"
  },
  Task_131559_Desc = {
    Text = "Erziele insgesamt 50 Siege im Phasenduell"
  },
  Task_131560_Desc = {
    Text = "Besiege 3 Erwecker im Phasenduell"
  },
  Task_131561_Desc = {
    Text = "Besiege 75 Erwecker im Phasenduell"
  },
  Task_131562_Desc = {
    Text = "Besiege 51 Erwecker im Phasenduell"
  },
  Task_131563_Desc = {
    Text = "Lege 120 Mal im Phasenduell Karten aus"
  },
  Task_131564_Desc = {
    Text = "Besiege 78 Erwecker im Phasenduell"
  },
  Task_131565_Desc = {
    Text = "Besiege 138 Erwecker im Phasenduell"
  },
  Task_131566_Desc = {
    Text = "Besiege 90 Erweckte im Phasenduell"
  },
  Task_131567_Desc = {
    Text = "Geheimnisprobe"
  },
  Task_131568_Desc = {
    Text = "Im Vorgruppierungsmodus 6 Siege erzielen"
  },
  Task_131569_Desc = {
    Text = "Im Vorgruppierungsmodus 8 Siege erringen"
  },
  Task_131570_Desc = {
    Text = "Besiege 117 Erwecker im Phasenduell"
  },
  Task_131571_Desc = {
    Text = "Erziele insgesamt 40 Siege im Phasenduell"
  },
  Task_131572_Desc = {
    Text = "Im Phasenduell 126 Mal Wahn freigeben"
  },
  Task_131573_Desc = {
    Text = "Spiele 760 Karten im Phasenduell aus"
  },
  Task_131574_Desc = {
    Text = "Verherrlichung im Phasenduell 270 Mal freigeben"
  },
  Task_131575_Desc = {
    Text = "Im Vorgruppierungsmodus 1 Sieg errungen"
  },
  Task_131576_Desc = {
    Text = "In einem Phasenduell 84 Mal Exaltieren freisetzen"
  },
  Task_131577_Desc = {
    Text = "Im Phasenduell 294 Mal Verherrlichung freigeben"
  },
  Task_131578_Desc = {
    Text = "Erziele insgesamt 30 Siege im Phasenduell"
  },
  Task_131579_Desc = {
    Text = "Spiele 960 Karten im Phasenduell aus"
  },
  Task_131580_Desc = {
    Text = "Spiele 260 Karten im Phasenduell aus"
  },
  Task_131581_Desc = {
    Text = "In einem Phasenduell 42 Mal Exaltieren freigeben"
  },
  Task_131582_Desc = {
    Text = "Besiege 96 Erwecker im Phasenduell"
  },
  Task_131583_Desc = {
    Text = "Im Phasenduell 228 Mal Exaltieren freisetzen"
  },
  Task_131584_Desc = {
    Text = "Spiele 40 Karten im Phasenduell"
  },
  Task_131585_Desc = {
    Text = "800 Karten im Phasenduell ausspielen"
  },
  Task_131586_Desc = {
    Text = "580 Karten im Phasenduell ausspielen"
  },
  Task_131587_Desc = {
    Text = "In Phasenduell 150 Mal Verherrlichung freigeben"
  },
  Task_131588_Desc = {
    Text = "Besiege 114 Erwecker im Phasenduell"
  },
  Task_131589_Desc = {
    Text = "Spiele 780 Karten im Phasenduell aus"
  },
  Task_131590_Desc = {
    Text = "In Phasenduell 24 Mal Verherrlichung freigeben"
  },
  Task_131591_Desc = {
    Text = "Verherrlichung im Phasenduell 216 Mal freigeben"
  },
  Task_131592_Desc = {
    Text = "Im Phasenduell 276 Mal Verherrlichung freigeben"
  },
  Task_131593_Desc = {
    Text = "Spiele 500 Karten im Phasenduell aus"
  },
  Task_131594_Desc = {
    Text = "Besiege 147 Erweckte im Phasenduell"
  },
  Task_131595_Desc = {
    Text = "Im Vorgruppierungsmodus 2 Siege errungen"
  },
  Task_131596_Desc = {
    Text = "Besiege 72 Erwecker im Phasenduell"
  },
  Task_131597_Desc = {
    Text = "Spiele 640 Karten im Phasenduell aus"
  },
  Task_131598_Desc = {
    Text = "Besiege 105 Erwecker im Phasenduell"
  },
  Task_131599_Desc = {
    Text = "Im Phasenduell 300 Mal Verherrlichung freigeben"
  },
  Task_131600_Desc = {
    Text = "Besiege 48 Erwecker im Phasenduell"
  },
  Task_131601_Desc = {
    Text = "920 Karten im Phasenduell ausspielen"
  },
  Task_131602_Desc = {
    Text = "Spiele 60 Karten im Phasenduell"
  },
  Task_131603_Desc = {
    Text = "Spiele 360 Karten im Phasenduell aus"
  },
  Task_131604_Desc = {
    Text = "Im Phasenduell 282 Mal Exaltieren freisetzen"
  },
  Task_131605_Desc = {
    Text = "Spiele 440 Karten im Phasenduell aus"
  },
  Task_131606_Desc = {
    Text = "Besiege 123 Erwecker im Phasenduell"
  },
  Task_131607_Desc = {
    Text = "Im Phasenduell 198 Mal Verherrlichung freigeben"
  },
  Task_131608_Desc = {
    Text = "Spiele 680 Karten im Phasenduell aus"
  },
  Task_131609_Desc = {
    Text = "Besiege 45 Erwecker im Phasenduell"
  },
  Task_131610_Desc = {
    Text = "Im Wahlmodus zwei aufeinanderfolgende Siege 2 Mal"
  },
  Task_131611_Desc = {
    Text = "Im Phasenduell 186 Mal Exaltieren freigeben"
  },
  Task_131612_Desc = {
    Text = "Im Phasenduell 6 Mal Aliemus freigeben"
  },
  Task_131613_Desc = {
    Text = "620 Karten im Phasenduell ausspielen"
  },
  Task_131614_Desc = {
    Text = "Im Wahlmodus 1 Mal zwei Siege in Folge"
  },
  Task_131615_Desc = {
    Text = "900 Karten im Phasenduell ausspielen"
  },
  Task_131616_Desc = {
    Text = "Im Phasenduell Wahnsinnsausbruch 252 Mal freisetzen"
  },
  Task_131617_Desc = {
    Text = "Spiele 980 Karten im Phasenduell"
  },
  Task_131618_Desc = {
    Text = "Besiege 141 Erwecker im Phasenduell"
  },
  Task_131619_Desc = {
    Text = "Im Phasenduell 288 Mal Exaltieren freigeben"
  },
  Task_131620_Desc = {
    Text = "Spiele 420 Karten im Phasenduell aus"
  },
  Task_131621_Desc = {
    Text = "Im Wahlmodus 10 Siege erzielen"
  },
  Task_131622_Desc = {
    Text = "Spiele 340 Karten im Phasenduell aus"
  },
  Task_131623_Desc = {
    Text = "Im Wahlmodus 4 Siege errungen"
  },
  Task_131624_Desc = {
    Text = "Spiele 80 Karten im Phasenduell"
  },
  Task_131625_Desc = {
    Text = "Im Vorgruppierungsmodus zwei aufeinanderfolgende Siege in 2 Mal"
  },
  Task_131626_Desc = {
    Text = "Spiele 540 Karten im Phasenduell aus"
  },
  Task_131627_Desc = {
    Text = "Verherrlichung im Phasenduell 138 Mal freigeben"
  },
  Task_131628_Desc = {
    Text = "In Phasenduell 12 Mal Verherrlichung freigeben"
  },
  Task_131768_Desc = {
    Text = "Abgeschlossen Bewusstseinsdrift„Sucht\""
  },
  Task_131768_Name = {Text = "Quiek!"},
  Task_131801_Name = {
    Text = "Die Replik der Runde umkehren Aktivität ist beendet"
  },
  Task_131891_Desc = {
    Text = "ewige Erinnerung: Limitiert Exklusiv"
  },
  Task_131892_Desc = {
    Text = "ewige Erinnerung V"
  },
  Task_131893_Desc = {
    Text = "ewige Erinnerung VII"
  },
  Task_131894_Desc = {
    Text = "ewige Erinnerung II"
  },
  Task_131895_Desc = {
    Text = "ewige Erinnerung I"
  },
  Task_131896_Desc = {
    Text = "ewige Erinnerung: Kostenlos"
  },
  Task_131897_Desc = {
    Text = "ewige Erinnerung III"
  },
  Task_131898_Desc = {
    Text = "ewige Erinnerung IV"
  },
  Task_131899_Desc = {
    Text = "ewige Erinnerung VI"
  },
  Task_132335_Desc = {
    Text = "Abgeschlossen Bewusstseinsdrift „Kronungstag\""
  },
  Task_132454_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_132454_Name = {Text = "10 Siege"},
  Task_132455_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_132455_Name = {Text = "3 Siege"},
  Task_132456_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_132456_Name = {Text = "6 Siege"},
  Task_132457_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_132457_Name = {Text = "1 Sieg"},
  Task_132689_Desc = {
    Text = "Anmelden mit PC-Gerät"
  },
  Task_132690_Desc = {
    Text = "Extrahiere einmal Silberkernquellflüssigkeit über das Mobilgerät"
  },
  Task_132691_Desc = {
    Text = "Extrahiere einmal Silberkernquellflüssigkeit über den PC"
  },
  Task_132692_Desc = {
    Text = "Anmelden mit mobilen Geräten"
  },
  Task_132874_Desc = {
    Text = "Besiege einen Anführer in Phase 3"
  },
  Task_132875_Desc = {
    Text = "Gewinne 5-mal"
  },
  Task_132876_Desc = {
    Text = "Gewinne 5-mal"
  },
  Task_132877_Desc = {
    Text = "Schließe P-Dive 3-mal ab"
  },
  Task_132909_Desc = {
    Text = "Abgeschlossen 1 Mal die Arachne-Testlevel"
  },
  Task_132910_Desc = {
    Text = "Schließe 15 Sendungen ab"
  },
  Task_132911_Desc = {
    Text = "Schließe eine beliebige Saisonquest ab"
  },
  Task_132912_Desc = {
    Text = "Spiele insgesamt 300 Karten aus"
  },
  Task_132913_Desc = {
    Text = "Schließe eine beliebige Saisonquest ab"
  },
  Task_132914_Desc = {
    Text = "30 Mal erwachen"
  },
  Task_132915_Desc = {
    Text = "Regionaler D-Effekt Spezialtraining erreicht 100"
  },
  Task_132916_Desc = {
    Text = "Abgeschlossen 1 Mal die Arachne-Testlevel"
  },
  Task_132917_Desc = {
    Text = "Schließe 15 Sendungen ab"
  },
  Task_132918_Desc = {
    Text = "Gesamte Anmeldung 1 Tag"
  },
  Task_132919_Desc = {
    Text = "Regionaler D-Effekt Spezialtraining erreicht 100"
  },
  Task_132920_Desc = {
    Text = "Wöchentliche Aktivität erreicht 1000"
  },
  Task_132921_Desc = {
    Text = "Wöchentliche Aktivität erreicht 1000"
  },
  Task_132922_Desc = {
    Text = "Spiele insgesamt 300 Karten aus"
  },
  Task_132923_Desc = {
    Text = "Gesamte Anmeldung 1 Tag"
  },
  Task_132924_Desc = {
    Text = "30 Mal erwachen"
  },
  Task_132928_Desc = {
    Text = "Alle oben genannten Aufgaben ausführen"
  },
  Task_132929_Desc = {
    Text = "Verbrauche Menophin 1800 Punkte"
  },
  Task_132930_Desc = {
    Text = "Schließe alle wöchentlichen Prüfungsaufgaben für 1 Woche ab"
  },
  Task_132931_Desc = {
    Text = "Gesamte Anmeldung 1 Tag"
  },
  Task_132932_Desc = {
    Text = "Vollständig 20 Aufgaben"
  },
  Task_132933_Desc = {
    Text = "Fusionskatastrophe Sperrzone Trainingspunkte erreicht 100"
  },
  Task_133297_Desc = {
    Text = "Schließe die Abweichende Traumwelt „Küchen erobern\" ab"
  },
  Task_133297_Name = {
    Text = "Freut euch! Tobt! Weint!"
  },
  Task_133302_Desc = {
    Text = "Raffinierte Aktiv-Ionen erreichen 1000"
  },
  Task_133303_Desc = {
    Text = "Verwende Unterstützung 3 Mal"
  },
  Task_133304_Desc = {
    Text = "Raffinierte Aktiv-Ionen erreichen 1000"
  },
  Task_133305_Desc = {
    Text = "Spiele insgesamt 300 Karten aus"
  },
  Task_133306_Desc = {
    Text = "Regionaler D-Effekt Spezialtraining erreicht 100"
  },
  Task_133307_Desc = {
    Text = "Regionaler D-Effekt Spezialtraining erreicht 100"
  },
  Task_133308_Desc = {
    Text = "Spiele insgesamt 300 Karten aus"
  },
  Task_133309_Desc = {
    Text = "30 Mal erwachen"
  },
  Task_133310_Desc = {
    Text = "Gesamte Anmeldung 1 Tag"
  },
  Task_133311_Desc = {
    Text = "Schließe eine beliebige Saisonmission ab"
  },
  Task_133312_Desc = {
    Text = "30 Mal erwachen"
  },
  Task_133313_Desc = {
    Text = "Schließe 15 Sendungen ab"
  },
  Task_133314_Desc = {
    Text = "Schließe eine beliebige Saisonmission ab"
  },
  Task_133315_Desc = {
    Text = "Verwende Unterstützung 3 Mal"
  },
  Task_133316_Desc = {
    Text = "Gesamte Anmeldung 1 Tag"
  },
  Task_133317_Desc = {
    Text = "Schließe 15 Sendungen ab"
  },
  Task_133940_Desc = {
    Text = "Gib einem Alumnus einmal ein Lob"
  },
  Task_133940_Name = {
    Text = "Freundliches Like"
  },
  Task_133941_Desc = {
    Text = "Erschöpfen Sie 180 Menophin"
  },
  Task_133941_Name = {
    Text = "Verbraucht Ausdauer"
  },
  Task_133943_Desc = {
    Text = "Spiele 50 Karten aus"
  },
  Task_133943_Name = {
    Text = "Tägliche Probe"
  },
  Task_133944_Desc = {
    Text = "Führen Sie 3 Aufträge aus"
  },
  Task_133944_Name = {
    Text = "Delegation durchführen"
  },
  Task_133945_Desc = {
    Text = "Schließe 50 Bündnis Transkriptionen ab"
  },
  Task_133945_Name = {
    Text = "Bündnis Transkription"
  },
  Task_133946_Desc = {
    Text = "Vollständige Transzendente Existenz einmal"
  },
  Task_133946_Name = {
    Text = "Wöchentlicher Boss"
  },
  Task_133947_Desc = {
    Text = "Führe 20 Erweckungszeremonien durch"
  },
  Task_133947_Name = {
    Text = "Ziehen Sie Karten"
  },
  Task_133948_Desc = {
    Text = "Verbrauche 1500 Menophin"
  },
  Task_133948_Name = {
    Text = "Verbraucht Ausdauer"
  },
  Task_133949_Desc = {
    Text = "Verbrauche 1.000.000 Rosenskript"
  },
  Task_133949_Name = {
    Text = "Spendthrift"
  },
  Task_134074_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"@1@2\""
  },
  Task_134074_Desc2 = {
    Text = "Abschluss des Ermittlungsereignisses „Schicksalsweber-Theater\""
  },
  Task_134074_Name2 = {
    Text = "Der schicksalhafte Protagonist"
  },
  Task_134075_Desc = {
    Text = "Abschluss des Ermittlungsereignisses „Schicksalsweber-Theater\" im Schwierigkeitsgrad"
  },
  Task_134075_Name = {
    Text = "Der schicksalhafte Protagonist · Schwer"
  },
  Task_134095_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 3 Mal Resonanz erzeugt"
  },
  Task_134095_Desc2 = {
    Text = "Resonanz 3 Mal im Ermittlungsereignis „Schicksalsweber-Theater\""
  },
  Task_134095_Name2 = {
    Text = "Echo der Fügsamkeit"
  },
  Task_134096_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 10 Mal Resonanz erzeugt"
  },
  Task_134096_Desc2 = {
    Text = "Resonanz 10 Mal im Ermittlungsereignis „Schicksalsweber-Theater\""
  },
  Task_134096_Name2 = {
    Text = "Echo der Fügsamkeit IV"
  },
  Task_134097_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 9 Mal Resonanz erzeugt"
  },
  Task_134097_Desc2 = {
    Text = "Resonanz 9 Mal im Ermittlungsereignis „Schicksalsweber-Theater\""
  },
  Task_134097_Name2 = {
    Text = "Echo der Fügsamkeit III"
  },
  Task_134098_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 6 Mal Resonanz erzeugt"
  },
  Task_134098_Desc2 = {
    Text = "Resonanz 6 Mal im Ermittlungsereignis „Schicksalsweber-Theater\""
  },
  Task_134098_Name2 = {
    Text = "Echo der Fügsamkeit II"
  },
  Task_134099_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_134099_Name = {
    Text = "Perfekter Pass"
  },
  Task_134121_Desc = {
    Text = "Caraboo erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134122_Desc = {
    Text = "Caecus erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134123_Desc = {
    Text = "Faros erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134124_Desc = {
    Text = "Mouchette erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134125_Desc = {
    Text = "Shaye erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134126_Desc = {
    Text = "Satogua erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134127_Desc = {
    Text = "Thais erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134128_Desc = {
    Text = "Schlafender Herr von Ursprung erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134129_Desc = {
    Text = "Helot erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134130_Desc = {
    Text = "Tawil erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134131_Desc = {
    Text = "Pollux erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134132_Desc = {
    Text = "24 erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134134_Desc = {
    Text = "Uvhash erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134135_Desc = {
    Text = "Murphy: Wahngeboren erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134136_Desc = {
    Text = "Doll: Inferno erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134137_Desc = {
    Text = "Pickman erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134138_Desc = {
    Text = "Pandia erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134140_Desc = {
    Text = "Horla erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134141_Desc = {
    Text = "Xu erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134142_Desc = {
    Text = "Tinct erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134143_Desc = {
    Text = "Katyusha erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134144_Desc = {
    Text = "Leigh erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134145_Desc = {
    Text = "Murphy erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134146_Desc = {
    Text = "Doresain erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134148_Desc = {
    Text = "Corposant erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134149_Desc = {
    Text = "Lily erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134150_Desc = {
    Text = "Helot: Kette erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134151_Desc = {
    Text = "Winkle erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134152_Desc = {
    Text = "Hameln erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134153_Desc = {
    Text = "Ryker erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134154_Desc = {
    Text = "Sanga erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134155_Desc = {
    Text = "Casiah erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134156_Desc = {
    Text = "Castor erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134157_Desc = {
    Text = "Mosk erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134158_Desc = {
    Text = "Faint erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134159_Desc = {
    Text = "Nautila erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134160_Desc = {
    Text = "Agrippa erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134161_Desc = {
    Text = "Jenkin erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134162_Desc = {
    Text = "Salvador erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134163_Desc = {
    Text = "Arachne erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134164_Desc = {
    Text = "Daffodil erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134165_Desc = {
    Text = "Celeste erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134166_Desc = {
    Text = "Sorel erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134167_Desc = {
    Text = "Goliath erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134168_Desc = {
    Text = "Tulu erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134169_Desc = {
    Text = "Clementine erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134170_Desc = {
    Text = "Karen erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134171_Desc = {
    Text = "Nymphaea erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134172_Desc = {
    Text = "Wanda erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134173_Desc = {
    Text = "Liz erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134174_Desc = {
    Text = "Alva erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134175_Desc = {
    Text = "Miryam erreicht Persönlichkeitsvertiefung 12"
  },
  Task_134394_Desc = {
    Text = "Kumulativer Login für 6 Tage"
  },
  Task_134395_Desc = {
    Text = "Logge dich insgesamt 10 Tage lang ein"
  },
  Task_134396_Desc = {
    Text = "Insgesamt 16 Tage eingeloggt"
  },
  Task_134397_Desc = {
    Text = "Logge dich insgesamt 7 Tage lang ein"
  },
  Task_134398_Desc = {
    Text = "Logge dich insgesamt 15 Tage lang ein"
  },
  Task_134399_Desc = {
    Text = "Insgesamt 9 Tage eingeloggt"
  },
  Task_134400_Desc = {
    Text = "Logge dich insgesamt 4 Tage lang ein"
  },
  Task_134401_Desc = {
    Text = "14-tägliche kumulierte Anmeldung"
  },
  Task_134402_Desc = {
    Text = "Logge dich an insgesamt 5 aufeinander folgenden Tagen ein"
  },
  Task_134403_Desc = {
    Text = "Kumulativer Login: 11 Tage"
  },
  Task_134404_Desc = {
    Text = "Kumulativer Login: 13 Tage"
  },
  Task_134405_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_134406_Desc = {
    Text = "Logge dich insgesamt 2 Tage lang ein"
  },
  Task_134407_Desc = {
    Text = "Logge dich an insgesamt 3 aufeinander folgenden Tagen ein"
  },
  Task_134408_Desc = {
    Text = "Logge dich insgesamt 8 Tage lang ein"
  },
  Task_134409_Desc = {
    Text = "Kumulativer Login: 12 Tage"
  },
  Task_135038_Desc = {
    Text = "Logge dich ins Spiel ein"
  },
  Task_135038_Name = {
    Text = "Logge dich ins Spiel ein"
  },
  Task_137649_Desc = {
    Text = "Spiele in dieser Saison 150 Karten aus"
  },
  Task_137650_Desc = {
    Text = "Spiele in dieser Saison 150 Karten aus"
  },
  Task_138583_Desc = {
    Text = "30 Mal erwachen"
  },
  Task_138584_Desc = {
    Text = "Schließe eine beliebige Saisonmission ab"
  },
  Task_138585_Desc = {
    Text = "Spiele insgesamt 300 Karten aus"
  },
  Task_138586_Desc = {
    Text = "Verwende Unterstützung 3 Mal"
  },
  Task_138587_Desc = {
    Text = "Regionaler D-Effekt Spezialtraining erreicht 100"
  },
  Task_138588_Desc = {
    Text = "Gesamte Anmeldung 1 Tag"
  },
  Task_138589_Desc = {
    Text = "30 Mal erwachen"
  },
  Task_138590_Desc = {
    Text = "Schließe 15 Sendungen ab"
  },
  Task_138591_Desc = {
    Text = "Spiele insgesamt 300 Karten aus"
  },
  Task_138592_Desc = {
    Text = "Verwende Unterstützung 3 Mal"
  },
  Task_138593_Desc = {
    Text = "Raffinierte Aktiv-Ionen erreichen 1000"
  },
  Task_138594_Desc = {
    Text = "Raffinierte Aktiv-Ionen erreichen 1000"
  },
  Task_138595_Desc = {
    Text = "Gesamte Anmeldung 1 Tag"
  },
  Task_138596_Desc = {
    Text = "Schließe eine beliebige Saisonmission ab"
  },
  Task_138597_Desc = {
    Text = "Schließe 15 Sendungen ab"
  },
  Task_138598_Desc = {
    Text = "Regionaler D-Effekt Spezialtraining erreicht 100"
  },
  Task_138762_Desc = {
    Text = "Besiege nach dem Erleiden von „Elegie jenseits des Schicksals\" die „Netz der Verratenen\" Nevreya."
  },
  Task_138762_Name = {
    Text = "Schicksalhafter Hauptdarsteller · Verborgen"
  },
  Task_139118_Desc = {
    Text = "Schließe „Multidimensionale Verbindung – vergessene Liebe Samen\" ab"
  },
  Task_139119_Desc = {
    Text = "Alle oben genannten Aufgaben ausführen"
  },
  Task_139121_Desc = {
    Text = "Führe 1000 Erweckungen durch"
  },
  Task_139123_Desc = {
    Text = "Führe 250 Erweckungen durch"
  },
  Task_139124_Desc = {
    Text = "Melde dich 1 Tag lang an"
  },
  Task_139125_Desc = {
    Text = "Schließe „Ermittlungseinsatz – Vergessenes Kapitel – Kapitel 4\" im normalen Modus ab"
  },
  Task_139126_Desc = {
    Text = "Führe 500 Erweckungen durch"
  },
  Task_139127_Desc = {
    Text = "Führe 100 Erweckungen durch"
  },
  Task_139600_Desc = {
    Text = "Insgesamt 1000000 Mal fangen"
  },
  Task_139614_Desc = {
    Text = "Insgesamt 500000 Mal fangen"
  },
  Task_139618_Desc = {
    Text = "Insgesamt 50-mal einfangen"
  },
  Task_139619_Desc = {
    Text = "Insgesamt 1000000 Mal fangen"
  },
  Task_139626_Desc = {
    Text = "Insgesamt 300000 Mal fangen"
  },
  Task_139629_Desc = {
    Text = "Insgesamt 700000 Mal fangen"
  },
  Task_139646_Desc = {
    Text = "Campus-Fangprotokoll"
  },
  Task_139649_Desc = {
    Text = "Insgesamt 100000 Mal fangen"
  },
  Task_139651_Desc = {
    Text = "Persönliches Fangprotokoll"
  },
  Task_139652_Desc = {
    Text = "Insgesamt 100-mal einfangen"
  },
  Task_140087_Desc = {
    Text = "„Größte Katze\" 1-mal abschließen"
  },
  Task_140088_Desc = {
    Text = "Schließe „Schwarzer Goldrausch\" 1 Mal ab"
  },
  Task_140089_Desc = {
    Text = "„Widerstand gegen die Festnahme\" 10-mal abschließen"
  },
  Task_140090_Desc = {
    Text = "„Holt sie rein!\" 5-mal abschließen"
  },
  Task_140091_Desc = {
    Text = "„Rückkehr mit voller Ladung\" 5-mal abschließen"
  },
  Task_140092_Desc = {
    Text = "„Widerstand gegen die Festnahme\" 1-mal abschließen"
  },
  Task_140093_Desc = {
    Text = "„Größte Katze\" 10-mal abschließen"
  },
  Task_140094_Desc = {
    Text = "„Erster Eimer Silber\" 5-mal abschließen"
  },
  Task_140095_Desc = {
    Text = "„Schwarzer Goldrausch\" 10 Mal abschließen"
  },
  Task_140096_Desc = {
    Text = "„Erster Eimer Silber\" 1-mal abschließen"
  },
  Task_140097_Desc = {
    Text = "„Rückkehr mit voller Ladung\" 10-mal abschließen"
  },
  Task_140098_Desc = {
    Text = "„Widerstand gegen die Festnahme\" 5-mal abschließen"
  },
  Task_140099_Desc = {
    Text = "„Größte Katze\" 5-mal abschließen"
  },
  Task_140100_Desc = {
    Text = "„Rückkehr mit voller Ladung\" 1-mal abschließen"
  },
  Task_140101_Desc = {
    Text = "„Holt sie rein!\" 10-mal abschließen"
  },
  Task_140102_Desc = {
    Text = "„Noch einmal\" 1-mal abschließen"
  },
  Task_140103_Desc = {
    Text = "„Noch einmal\" 10-mal abschließen"
  },
  Task_140104_Desc = {
    Text = "„Erster Eimer Silber\" 10-mal abschließen"
  },
  Task_140105_Desc = {
    Text = "„Holt sie rein!\" 1-mal abschließen"
  },
  Task_140106_Desc = {
    Text = "Schließe „Schwarzer Goldrausch\" 10 Mal ab"
  },
  Task_140107_Desc = {
    Text = "„Noch einmal\" 5-mal abschließen"
  },
  Task_140114_Desc = {
    Text = "Schließe „Multidimensionale Verbindung – vergessene Liebe Samen\" ab"
  },
  Task_140115_Desc = {
    Text = "Alle oben genannten Aufgaben ausführen"
  },
  Task_140116_Desc = {
    Text = "Melde dich 1 Tag lang an"
  },
  Task_140117_Desc = {
    Text = "Schließe „Ermittlungseinsatz – Vergessenes Kapitel – Kapitel 4\" im normalen Modus ab"
  },
  Task_140189_Desc = {
    Text = "Kumulative Extraktion von 5000 Silberprimus"
  },
  Task_140190_Desc = {
    Text = "Kumulative Extraktion von 20000 Silberprimus"
  },
  Task_140191_Desc = {
    Text = "10000 Silber Prime ansammeln"
  },
  Task_140192_Desc = {
    Text = "30000 Silber Prime ansammeln"
  },
  Task_140306_Desc = {
    Text = "Multiversen-Link „vergessene Liebe Samen\" Abgeschlossen: Schwierig"
  },
  Task_140306_Name = {
    Text = "Heimkehr des Wanderers · Schwierig"
  },
  Task_140307_Desc = {
    Text = "Multiversen-Link „vergessene Liebe Samen\" Abgeschlossen"
  },
  Task_140307_Name = {
    Text = "Heimkehr des Wanderers"
  },
  Task_140463_Desc = {
    Text = "Spiele insgesamt 200 Karten aus"
  },
  Task_140464_Desc = {
    Text = "Vollständig 20 Aufgaben"
  },
  Task_140465_Desc = {
    Text = "Gesamte Anmeldung 1 Tag"
  },
  Task_140466_Desc = {
    Text = "Raffinierte Aktiv-Ionen erreichen 1000"
  },
  Task_140467_Desc = {
    Text = "Alle oben genannten Aufgaben ausführen"
  },
  Task_140468_Desc = {
    Text = "Schließe eine beliebige Saisonmission ab"
  },
  Task_141311_Desc = {
    Text = "Bewusstseinsdrift „Ebwynnos Evermore\" abgeschlossen"
  },
  Task_141312_Desc = {
    Text = "Erreiche Synchro-Rate Stufe 10 mit Pontos"
  },
  Task_141313_Desc = {
    Text = "Mit einem Ultra Reich Erwecker in „Die Jagd des Hohen Hauses\" 1 Mal gewonnen"
  },
  Task_141314_Desc = {
    Text = "„Dunkler Wald\" im Wahnsinnsmodus abgeschlossen"
  },
  Task_141315_Desc = {
    Text = "„Met und Myrrhe\" in beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141316_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_141317_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_141318_Desc = {
    Text = "„Selbstgespräch\" in beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141319_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_141320_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_141321_Desc = {
    Text = "Mit einem Fleisch-Reich-Erwecker in „Die Jagd des Hohen Hauses\" 2 Mal gewonnen"
  },
  Task_141322_Desc = {
    Text = "Mit einem Chaos-Reich-Erwecker in „Die Jagd des Hohen Hauses\" 2 Mal gewonnen"
  },
  Task_141323_Desc = {
    Text = "Mit einem Aequor-Reich Erwecker in „Die Jagd des Hohen Hauses\" 1 Mal gewonnen"
  },
  Task_141324_Desc = {
    Text = "Die Jagd des Hohen Hauses·Reich"
  },
  Task_141325_Desc = {
    Text = "„Die Pfeife\" im Wahnsinnsmodus abgeschlossen"
  },
  Task_141326_Desc = {
    Text = "„Spiel des Raubtiers\" in beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141327_Desc = {
    Text = "„Met und Myrrhe\" in beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141328_Desc = {
    Text = "„Dunkler Wald\" in beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141329_Desc = {
    Text = "Die Jagd des Hohen Hauses·Wahnsinn"
  },
  Task_141330_Desc = {
    Text = "„Dualismus\" im Wahnsinnsmodus abgeschlossen"
  },
  Task_141331_Desc = {
    Text = "„Dunkler Wald\" in beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141332_Desc = {
    Text = "„Met und Myrrhe\" im Wahnsinnsmodus abgeschlossen"
  },
  Task_141333_Desc = {
    Text = "„Selbstgespräch\" im Wahnsinnsmodus abgeschlossen"
  },
  Task_141335_Desc = {
    Text = "„Rippe und Knorpel\" in beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141336_Desc = {
    Text = "„Dualismus\" in beliebigem Schwierigkeitsgrad abgeschlossen"
  },
  Task_141337_Desc = {
    Text = "Alle Erfolge von „Die Jagd des Hohen Hauses·Abschluss\" abgeschlossen"
  },
  Task_141338_Desc = {
    Text = "Erwachen 6 beim Erhalten von Pontos"
  },
  Task_141338_Name = {
    Text = "Erwachen 6 beim Erhalten von Pontos"
  },
  Task_141338_UnlockCondDesc = {
    Text = "Aktivität@Erwecker Pontos Erwachenspaket 2 Aktivität"
  },
  Task_141339_Desc = {
    Text = "„Rippe und Knorpel\" in beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141340_Desc = {
    Text = "„Dualismus\" in beliebigem Schwierigkeitsgrad abgeschlossen"
  },
  Task_141341_Desc = {
    Text = "Die Jagd des Hohen Hauses·Abschluss"
  },
  Task_141342_Desc = {
    Text = "Mit einem Aequor-Reich Erwecker in „Die Jagd des Hohen Hauses\" 2 Mal gewonnen"
  },
  Task_141343_Desc = {
    Text = "„Die Pfeife\" in beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141344_Desc = {
    Text = "„Selbstgespräch\" in beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141345_Desc = {
    Text = "Mit einem Ultra Reich Erwecker in „Die Jagd des Hohen Hauses\" 2 Mal gewonnen"
  },
  Task_141346_Desc = {
    Text = "Mit einem Chaos-Reich-Erwecker in „Die Jagd des Hohen Hauses\" 1 Mal gewonnen"
  },
  Task_141347_Desc = {
    Text = "„Spiel des Raubtiers\" im Wahnsinnsmodus abgeschlossen"
  },
  Task_141348_Desc = {
    Text = "„Die Pfeife\" in beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141349_Desc = {
    Text = "Mit einem Fleisch-Reich-Erwecker in „Die Jagd des Hohen Hauses\" 1 Mal gewonnen"
  },
  Task_141350_Desc = {
    Text = "Erreiche Persönlichkeitsvertiefung 12 mit Pontos"
  },
  Task_141351_Desc = {
    Text = "Erwachen 2 beim Erhalten von Pontos"
  },
  Task_141351_Name = {
    Text = "Erwachen 2 beim Erhalten von Pontos"
  },
  Task_141351_UnlockCondDesc = {
    Text = "Aktivität@Erwecker Pontos Erwachenspaket 2 Aktivität"
  },
  Task_141352_Desc = {
    Text = "„Spiel des Raubtiers\" in beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141353_Desc = {
    Text = "„Rippe und Knorpel\" im Wahnsinnsmodus abgeschlossen"
  },
  Task_141511_Desc = {
    Text = "Spiele insgesamt 300 Karten aus"
  },
  Task_141512_Desc = {
    Text = "Schließe eine beliebige Saisonmission ab"
  },
  Task_141513_Desc = {
    Text = "Verwende Unterstützung 3 Mal"
  },
  Task_141514_Desc = {
    Text = "Schließe 15 Sendungen ab"
  },
  Task_141515_Desc = {
    Text = "Gesamte Anmeldung 1 Tag"
  },
  Task_141516_Desc = {
    Text = "Gesamte Anmeldung 1 Tag"
  },
  Task_141517_Desc = {
    Text = "30 Mal erwachen"
  },
  Task_141518_Desc = {
    Text = "Schließe eine beliebige Saisonmission ab"
  },
  Task_141519_Desc = {
    Text = "Verwende Unterstützung 3 Mal"
  },
  Task_141520_Desc = {
    Text = "Raffinierte Aktiv-Ionen erreichen 1000"
  },
  Task_141521_Desc = {
    Text = "Regionaler D-Effekt Spezialtraining erreicht 100"
  },
  Task_141522_Desc = {
    Text = "Spiele insgesamt 300 Karten aus"
  },
  Task_141523_Desc = {
    Text = "Regionaler D-Effekt Spezialtraining erreicht 100"
  },
  Task_141524_Desc = {
    Text = "30 Mal erwachen"
  },
  Task_141525_Desc = {
    Text = "Raffinierte Aktiv-Ionen erreichen 1000"
  },
  Task_141526_Desc = {
    Text = "Schließe 15 Sendungen ab"
  },
  Task_141799_Desc = {
    Text = "Mit Tiefseewachkörpern zweimal in „Umapatis Schätze“ gewinnen"
  },
  Task_141800_Desc = {
    Text = "Gewinne mit Ultra Reich Erweckern zweimal in „Umapatis Schätze“"
  },
  Task_141801_Desc = {
    Text = "„Faden“ auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141802_Desc = {
    Text = "Mit Fleisch-Erwachungskörpern zweimal in „Umapatis Schätze“ gewinnen"
  },
  Task_141803_Desc = {
    Text = "Alle Erfolge von „Umapatis Schätze: Abschluss“ abschließen"
  },
  Task_141804_Desc = {
    Text = "Mit Chaoswachkörpern einmal in „Umapatis Schätze“ gewinnen"
  },
  Task_141805_Desc = {
    Text = "„Apfel“ auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141806_Desc = {
    Text = "Jede Schwierigkeit von \"Spiegel\" beseitigen"
  },
  Task_141807_Desc = {
    Text = "„Schlüssel“ auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141808_Desc = {
    Text = "Vollständig \"Spiegel\" im Wahnsinn-Schwierigkeitsgrad"
  },
  Task_141809_Desc = {
    Text = "Schließe „Krone“ im Wahnsinnsmodus ab"
  },
  Task_141810_Desc = {
    Text = "„Feder“ auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141811_Desc = {
    Text = "„Auge“ auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141812_Desc = {
    Text = "Schließe „Faden“ im Wahnsinnsmodus ab"
  },
  Task_141813_Desc = {
    Text = "Schließe „Apfel“ im Wahnsinnsmodus ab"
  },
  Task_141814_Desc = {
    Text = "„Krone“ auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141815_Desc = {
    Text = "Mit Fleisch-Erwachungskörpern einmal in „Umapatis Schätze“ gewinnen"
  },
  Task_141816_Desc = {
    Text = "Jede Schwierigkeit von \"Spiegel\" beseitigen"
  },
  Task_141817_Desc = {
    Text = "Schließe „Feder“ im Wahnsinnsmodus ab"
  },
  Task_141818_Desc = {
    Text = "„Feder“ auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141819_Desc = {
    Text = "Umapatis Schätze·Wahnsinn"
  },
  Task_141820_Desc = {
    Text = "Umapatis Schätze: Reich"
  },
  Task_141821_Desc = {
    Text = "„Auge“ auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141822_Desc = {
    Text = "„Faden“ auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141823_Desc = {
    Text = "„Schlüssel“ auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141824_Desc = {
    Text = "Umapatis Schätze·Abschluss"
  },
  Task_141825_Desc = {
    Text = "„Apfel“ auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141826_Desc = {
    Text = "Mit Hyperdimensionalen Erwachungsbodys einmal in „Umapatis Schätze“ gewinnen"
  },
  Task_141827_Desc = {
    Text = "Mit Tiefseewachkörpern einmal in „Umapatis Schätze“ gewinnen"
  },
  Task_141828_Desc = {
    Text = "Schließe „Augen“ im Wahnsinnsmodus ab"
  },
  Task_141829_Desc = {
    Text = "Mit Chaoswachkörpern zweimal in „Umapatis Schätze“ gewinnen"
  },
  Task_141830_Desc = {
    Text = "Schließe „Schlüssel“ im Wahnsinnsmodus ab"
  },
  Task_141831_Desc = {
    Text = "„Krone“ auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_141899_Desc = {
    Text = "Handynummer oder E-Mail-Adresse im „Benutzercenter – Profil vervollständigen\" verknüpfen"
  },
  Task_143320_Desc = {
    Text = "Schließe die Bewusstseinsdrift „Ebwynnos Evermore\" auf Schwierig ab"
  },
  Task_143320_Name = {
    Text = "Eine kühle Sommernacht · Schwierig"
  },
  Task_143321_Desc = {
    Text = "Schließe die Bewusstseinsdrift „Ebwynnos Evermore\" ab"
  },
  Task_143321_Name = {
    Text = "Eine kühle Sommernacht"
  },
  Task_143588_Desc = {
    Text = "Bleib in seiner Umarmung..."
  },
  Task_143588_Name = {
    Text = "Bleib in seiner Umarmung..."
  },
  Task_143589_Desc = {Text = "Bleib ..."},
  Task_143589_Name = {Text = "Bleib ..."},
  Task_143590_Desc = {
    Text = "In Ebwynnos bleiben"
  },
  Task_143590_Name = {
    Text = "In Ebwynnos bleiben"
  },
  Task_144311_Desc = {
    Text = "Verdiene 250/500/750/1000 Punkte, wenn 1/2/3/4 wöchentlich verstärkte Erwecker eingesetzt werden. (Aktuell: {s1})"
  },
  Task_144311_Name = {
    Text = "Ruf der Tiefe<size=20><color=#747474>Beim Einsatz von 1/2/3/4 verstärkten Erweckern im Kampf erhältst du 250 / 500 / 750 / 1000 Punkte </color></size>"
  },
  Task_144312_Desc = {
    Text = "Abgeschlossen Bewusstseinsdrift“Temporärer Text“"
  },
  Task_144313_Desc = {
    Text = "Umgekehrtes Neugeboren·Abschluss"
  },
  Task_144314_Desc = {
    Text = "Abgeschlossen „Neurotrauma\" im Wahnsinnsmodus"
  },
  Task_144315_Desc = {
    Text = "Gewinne einmal mit Tiefseewachkörpern in „Umgekehrtes Neugeboren\""
  },
  Task_144316_Desc = {
    Text = "Abgeschlossen „Schlummertrunk\" im Wahnsinnsmodus"
  },
  Task_144317_Desc = {
    Text = "Abgeschlossen „Schlummertrunk\" in beliebigem Schwierigkeitsgrad"
  },
  Task_144318_Desc = {
    Text = "Umgekehrtes Neugeboren: Reich"
  },
  Task_144319_Desc = {
    Text = "Schließe „Krankenhaus\" auf einem beliebigen Schwierigkeitsgrad ab"
  },
  Task_144320_Desc = {
    Text = "Gewinne zweimal mit Tiefseewachkörpern in „Umgekehrtes Neugeboren\""
  },
  Task_144321_Desc = {
    Text = "Abgeschlossen „Esstisch\" in beliebigem Schwierigkeitsgrad"
  },
  Task_144322_Desc = {
    Text = "Abgeschlossen „Esstisch\" im Wahnsinnsmodus"
  },
  Task_144323_Desc = {
    Text = "Schließe „Unser Zuhause\" auf einem beliebigen Schwierigkeitsgrad ab"
  },
  Task_144324_Desc = {
    Text = "Gewinne einmal mit Hyperdimensionaler Erwachungsbodys in „Umgekehrtes Neugeboren\""
  },
  Task_144325_Desc = {
    Text = "Abgeschlossen „Der Brunnen\" in beliebigem Schwierigkeitsgrad"
  },
  Task_144326_Desc = {
    Text = "Schließe „Unser Zuhause\" auf einem beliebigen Schwierigkeitsgrad ab"
  },
  Task_144327_Desc = {
    Text = "Gewinne zweimal mit Chaoswachkörpern in „Umgekehrtes Neugeboren\""
  },
  Task_144328_Desc = {
    Text = "Schließe „Krankenhaus\" auf einem beliebigen Schwierigkeitsgrad ab"
  },
  Task_144329_Desc = {
    Text = "Abgeschlossen „Der Brunnen\" in beliebigem Schwierigkeitsgrad"
  },
  Task_144330_Desc = {
    Text = "Abgeschlossen „In der Schule\" in beliebigem Schwierigkeitsgrad"
  },
  Task_144331_Desc = {
    Text = "Abgeschlossen „Neurotrauma\" in beliebigem Schwierigkeitsgrad"
  },
  Task_144332_Desc = {
    Text = "Schließe alle Erfolge von „Umgekehrtes Neugeboren·Abschluss\" ab"
  },
  Task_144333_Desc = {
    Text = "Abgeschlossen „Esstisch\" in beliebigem Schwierigkeitsgrad"
  },
  Task_144334_Desc = {
    Text = "Abgeschlossen „In der Schule\" im Wahnsinnsmodus"
  },
  Task_144335_Desc = {
    Text = "Schließe „Unser Zuhause\" im Wahnsinnsmodus ab"
  },
  Task_144336_Desc = {
    Text = "Gewinne einmal mit Fleisch-Erwachungskörpern in „Umgekehrtes Neugeboren\""
  },
  Task_144337_Desc = {
    Text = "Abgeschlossen „Neurotrauma\" in beliebigem Schwierigkeitsgrad"
  },
  Task_144338_Desc = {
    Text = "Abgeschlossen „In der Schule\" in beliebigem Schwierigkeitsgrad"
  },
  Task_144339_Desc = {
    Text = "Abgeschlossen „Schlummertrunk\" in beliebigem Schwierigkeitsgrad"
  },
  Task_144340_Desc = {
    Text = "Gewinne zweimal mit Fleisch-Erwachungskörpern in „Umgekehrtes Neugeboren\""
  },
  Task_144341_Desc = {
    Text = "Gewinne einmal mit Chaoswachkörpern in „Umgekehrtes Neugeboren\""
  },
  Task_144342_Desc = {
    Text = "Gewinne zweimal mit Hyperdimensionaler Erwachungsbodys in „Umgekehrtes Neugeboren\""
  },
  Task_144343_Desc = {
    Text = "Umgekehrtes Neugeboren·Wahnsinn"
  },
  Task_144344_Desc = {
    Text = "Abgeschlossen „Der Brunnen\" im Wahnsinnsmodus"
  },
  Task_144345_Desc = {
    Text = "Schließe „Krankenhaus\" im Wahnsinnsmodus ab"
  },
  Task_144360_Desc = {
    Text = "Spiele insgesamt 300 Karten aus"
  },
  Task_144361_Desc = {
    Text = "Schließe eine beliebige Saisonmission ab"
  },
  Task_144362_Desc = {
    Text = "Regionaler D-Effekt Spezialtraining erreicht 100"
  },
  Task_144363_Desc = {
    Text = "Schließe 15 Sendungen ab"
  },
  Task_144364_Desc = {
    Text = "Raffinierte Aktiv-Ionen erreichen 1000"
  },
  Task_144365_Desc = {
    Text = "30 Mal erwachen"
  },
  Task_144366_Desc = {
    Text = "Regionaler D-Effekt Spezialtraining erreicht 100"
  },
  Task_144367_Desc = {
    Text = "Gesamte Anmeldung 1 Tag"
  },
  Task_144368_Desc = {
    Text = "Schließe eine beliebige Saisonmission ab"
  },
  Task_144369_Desc = {
    Text = "Schließe 15 Sendungen ab"
  },
  Task_144370_Desc = {
    Text = "Spiele insgesamt 300 Karten aus"
  },
  Task_144371_Desc = {
    Text = "Raffinierte Aktiv-Ionen erreichen 1000"
  },
  Task_144372_Desc = {
    Text = "30 Mal erwachen"
  },
  Task_144373_Desc = {
    Text = "Verwende Unterstützung 3 Mal"
  },
  Task_144374_Desc = {
    Text = "Verwende Unterstützung 3 Mal"
  },
  Task_144375_Desc = {
    Text = "Gesamte Anmeldung 1 Tag"
  },
  Task_145388_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_145389_Desc = {
    Text = "Gewinne mit Tiefseewachkörpern zweimal in „Gier und Blutdurst\""
  },
  Task_145390_Desc = {
    Text = "„Das Opfer\" auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_145392_Desc = {
    Text = "Gier und Blutdurst·Abschluss"
  },
  Task_145393_Desc = {
    Text = "Schließe „Halle des Gemetzels\" im Wahnsinnsmodus ab"
  },
  Task_145394_Desc = {
    Text = "Schließe „Krone der Begierde\" in einem beliebigen Schwierigkeitsgrad ab"
  },
  Task_145395_Desc = {
    Text = "Schließe die Bewusstseinsdrift „Bis der Himmel des Wals fällt\" ab"
  },
  Task_145396_Desc = {
    Text = "Erwachen 6 beim Erhalten von Lotan: Cetarchon"
  },
  Task_145396_Name = {
    Text = "Erwachen 6 beim Erhalten von Lotan: Cetarchon"
  },
  Task_145396_UnlockCondDesc = {
    Text = "Event @ Erweckter Körper Lotan: Cetarchon Erweckungs-Paket 2 Event"
  },
  Task_145397_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_145398_Desc = {
    Text = "Lotan: Cetarchons Synchro-Rate erreicht Level 10"
  },
  Task_145399_Desc = {
    Text = "Gier und Blutdurst: Reich"
  },
  Task_145400_Desc = {
    Text = "„Eingesperrte Bestie\" auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_145401_Desc = {
    Text = "„Halle des Gemetzels\" auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_145402_Desc = {
    Text = "„Eingesperrte Bestie\" auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_145403_Desc = {
    Text = "Schließe „Käfigbestie\" im Wahnsinnsmodus ab"
  },
  Task_145404_Desc = {
    Text = "Gewinne mit hyperdimensionalen Erwachungsbodys einmal in „Gier und Blutdurst\""
  },
  Task_145405_Desc = {
    Text = "Gewinne mit Chaoswachkörpern zweimal in „Gier und Blutdurst\""
  },
  Task_145406_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_145408_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_145409_Desc = {
    Text = "Schließe „Krone der Begierde\" in einem beliebigen Schwierigkeitsgrad ab"
  },
  Task_145410_Desc = {
    Text = "Schließe alle Erfolge von „Gier und Blutdurst·Abschluss\" ab"
  },
  Task_145411_Desc = {
    Text = "Gewinne mit Fleisch-Erwachungskörpern einmal in „Gier und Blutdurst\""
  },
  Task_145412_Desc = {
    Text = "Gewinne mit Fleisch-Erwachungskörpern zweimal in „Gier und Blutdurst\""
  },
  Task_145413_Desc = {
    Text = "„Das Opfer\" auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_145414_Desc = {
    Text = "Erwachen 2 beim Erhalten von Lotan: Cetarchon"
  },
  Task_145414_Name = {
    Text = "Erwachen 2 beim Erhalten von Lotan: Cetarchon"
  },
  Task_145414_UnlockCondDesc = {
    Text = "Event @ Erweckter Körper Lotan: Cetarchon Erweckungs-Paket 2 Event"
  },
  Task_145415_Desc = {
    Text = "Gewinne mit Chaoswachkörpern einmal in „Gier und Blutdurst\""
  },
  Task_145416_Desc = {
    Text = "Gewinne mit hyperdimensionalen Erwachungsbodys zweimal in „Gier und Blutdurst\""
  },
  Task_145417_Desc = {
    Text = "Schließe „Das Opfer\" im Wahnsinnsmodus ab"
  },
  Task_145418_Desc = {
    Text = "Gier und Blutdurst·Wahnsinn"
  },
  Task_145419_Desc = {
    Text = "Schließe „Der leere Spiegel\" im Wahnsinnsmodus ab"
  },
  Task_145420_Desc = {
    Text = "„Der leere Spiegel\" auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_145421_Desc = {
    Text = "Schließe „Krone der Begierde\" im Wahnsinnsmodus ab"
  },
  Task_145423_Desc = {
    Text = "Gewinne mit Tiefseewachkörpern einmal in „Gier und Blutdurst\""
  },
  Task_145424_Desc = {
    Text = "„Der leere Spiegel\" auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_145425_Desc = {
    Text = "Lotan: Cetarchon erreicht Persönlichkeitsvertiefung 12"
  },
  Task_145426_Desc = {
    Text = "„Halle des Gemetzels\" auf beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_145479_Desc = {
    Text = "Schließe die Bewusstseinsdrift „Bis der Cetus fällt\" ab"
  },
  Task_145479_Name = {
    Text = "Ich bin der Sturm"
  },
  Task_145576_Desc = {
    Text = "Vorübergehender Text · Zeitlich begrenzte Exklusivität"
  },
  Task_145578_Desc = {
    Text = "Tausend Wünsche: Begrenzt Exklusiv"
  },
  Task_146542_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_146543_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_146544_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_146545_Desc = {
    Text = "Sternekapitel Kapitel 6-8 abgeschlossen"
  },
  Task_146546_Desc = {
    Text = "Sternekapitel Kapitel 6 „Wenn der Berg speist“·Schwierig abgeschlossen"
  },
  Task_146547_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_146548_Desc = {
    Text = "Sternekapitel Kapitel 6 „Wenn der Berg speist“·Schwierig abgeschlossen"
  },
  Task_146549_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_146550_Desc = {
    Text = "Sternekapitel Kapitel 6-8 abgeschlossen"
  },
  Task_146552_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_146553_Desc = {
    Text = "Sternekapitel Kapitel 6 „Wenn der Berg speist“ abgeschlossen"
  },
  Task_146554_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_146555_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_146556_Desc = {
    Text = "Sternekapitel Kapitel 6 6-5 Schwierig Abgeschlossen"
  },
  Task_146557_Desc = {
    Text = "Sternekapitel Kapitel 6 6-5 Schwierig Abgeschlossen"
  },
  Task_146558_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_146559_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_146560_Desc = {
    Text = "Sternekapitel Kapitel 6 „Wenn der Berg speist“ abgeschlossen"
  },
  Task_146801_Desc = {
    Text = "Einsatz des Tiefseereich Erwachers gewann 1 Mal in \"Vorübergehender Text\""
  },
  Task_146802_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_146803_Desc = {
    Text = "Vollständig den \"Temporären Text\" auf Wahnsinn-Schwierigkeit"
  },
  Task_146804_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_146805_Desc = {
    Text = "Einsatz des Caro-Reich Erwachers gewann 2 Mal in \"Vorübergehender Text\""
  },
  Task_146806_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_146807_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_146808_Desc = {
    Text = "Abgeschlossen Bewusstseinsdrift „Fünf-Tage-Gespräch“"
  },
  Task_146809_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_146810_Desc = {
    Text = "Einsatz des Tiefseereich Erwachers gewann 2 Mal in \"Vorübergehender Text\""
  },
  Task_146811_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_146812_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_146813_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_146814_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_146815_Desc = {
    Text = "Einsatz des Chaos-Reich Erwachers gewann 1 Mal in \"Vorübergehender Text\""
  },
  Task_146816_Desc = {
    Text = "Einsatz des Ultra-Reich Erwachers gewann 1 Mal in \"Vorübergehender Text\""
  },
  Task_146817_Desc = {
    Text = "Temporärer Text · Abschluss"
  },
  Task_146818_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_146819_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_146820_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_146821_Desc = {
    Text = "Vollständig den \"Temporären Text\" auf Wahnsinn-Schwierigkeit"
  },
  Task_146822_Desc = {
    Text = "Vollständig den \"Temporären Text\" auf Wahnsinn-Schwierigkeit"
  },
  Task_146823_Desc = {
    Text = "Temporärer Text · Reich"
  },
  Task_146824_Desc = {
    Text = "Vollständig den \"Temporären Text\" auf Wahnsinn-Schwierigkeit"
  },
  Task_146825_Desc = {
    Text = "Vollständig den \"Temporären Text\" auf Wahnsinn-Schwierigkeit"
  },
  Task_146826_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_146827_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_146828_Desc = {
    Text = "Vollständig den \"Temporären Text\" auf Wahnsinn-Schwierigkeit"
  },
  Task_146829_Desc = {
    Text = "Einsatz des Chaos-Reich Erwachers gewann 2 Mal in \"Vorübergehender Text\""
  },
  Task_146830_Desc = {
    Text = "Vollständig den \"Temporären Text\" auf Wahnsinn-Schwierigkeit"
  },
  Task_146831_Desc = {
    Text = "Einsatz des Ultra-Reich Erwachers gewann 2 Mal in \"Vorübergehender Text\""
  },
  Task_146832_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_146833_Desc = {
    Text = "Einsatz des Caro-Reich Erwachers gewann 1 Mal in \"Vorübergehender Text\""
  },
  Task_146834_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_146835_Desc = {
    Text = "Temporärer Text·Wahnsinn"
  },
  Task_146836_Desc = {
    Text = "Vollständig alle Erfolge von \"Temporärer Text · Klärung\""
  },
  Task_146837_Desc = {
    Text = "Vollständig den \"Temporären Text\" auf Wahnsinn-Schwierigkeit"
  },
  Task_146838_Desc = {
    Text = "Vollständig den \"Temporären Text\" auf Wahnsinn-Schwierigkeit"
  },
  Task_146839_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_146840_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_147442_Desc = {
    Text = "Einsatz des Caro-Reich Erwachers gewann 2 Mal in \"Vorübergehender Text\""
  },
  Task_147443_Desc = {
    Text = "Synchro-Rate von Tinct: Vespera erreicht Level 10"
  },
  Task_147444_Desc = {
    Text = "Einsatz des Tiefseereich Erwachers gewann 1 Mal in \"Vorübergehender Text\""
  },
  Task_147450_Desc = {
    Text = "Abgeschlossen Bewusstseinsdrift“Temporärer Text“"
  },
  Task_147451_Desc = {
    Text = "Einsatz des Ultra-Reich Erwachers gewann 1 Mal in \"Vorübergehender Text\""
  },
  Task_147452_Desc = {
    Text = "Einsatz des Chaos-Reich Erwachers gewann 1 Mal in \"Vorübergehender Text\""
  },
  Task_147453_Desc = {
    Text = "Einsatz des Tiefseereich Erwachers gewann 2 Mal in \"Vorübergehender Text\""
  },
  Task_147454_Desc = {
    Text = "Einsatz des Caro-Reich Erwachers gewann 1 Mal in \"Vorübergehender Text\""
  },
  Task_147456_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_147458_Desc = {
    Text = "Erwachen 2 beim Erhalten von Tinct: Vespera"
  },
  Task_147458_Name = {
    Text = "Erwachen 2 beim Erhalten von Tinct: Vespera"
  },
  Task_147458_UnlockCondDesc = {
    Text = "Aktivität@Erwecker Tinct: Vespera Erweckungspaket 2 Aktivität"
  },
  Task_147461_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_147464_Desc = {
    Text = "Schließe das Wandern „Vorübergehender Text“ ab"
  },
  Task_147464_Name = {
    Text = "Temporärer Text"
  },
  Task_147465_Desc = {
    Text = "Erwachen 6 beim Erhalten von Tinct: Vespera"
  },
  Task_147465_Name = {
    Text = "Erwachen 6 beim Erhalten von Tinct: Vespera"
  },
  Task_147465_UnlockCondDesc = {
    Text = "Aktivität@Erwecker Tinct: Vespera Erweckungspaket 2 Aktivität"
  },
  Task_147471_Desc = {
    Text = "Tinct: Vespera erreicht Persönlichkeitsvertiefung 12"
  },
  Task_147472_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_147474_Desc = {
    Text = "Einsatz des Chaos-Reich Erwachers gewann 2 Mal in \"Vorübergehender Text\""
  },
  Task_147475_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_147476_Desc = {
    Text = "Vollständig alle Erfolge von \"Temporärer Text · Klärung\""
  },
  Task_147478_Desc = {
    Text = "Bewusstseinsdrift „Vorübergehender Text“ auf Schwierig-Schwierigkeitsgrad abschließen"
  },
  Task_147478_Name = {
    Text = "Temporärer Text·Hart"
  },
  Task_147483_Desc = {
    Text = "Einsatz des Ultra-Reich Erwachers gewann 2 Mal in \"Vorübergehender Text\""
  },
  Task_147552_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_147553_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_147554_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_147555_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_147556_Desc = {
    Text = "Vollständig den \"Temporären Text\" auf Wahnsinn-Schwierigkeit"
  },
  Task_147557_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_147558_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_147559_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_147560_Desc = {
    Text = "Vollständig den \"Temporären Text\" auf Wahnsinn-Schwierigkeit"
  },
  Task_147561_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_147562_Desc = {
    Text = "Vollständig den \"Temporären Text\" auf Wahnsinn-Schwierigkeit"
  },
  Task_147563_Desc = {
    Text = "Temporärer Text·Wahnsinn"
  },
  Task_147564_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_147565_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_147566_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_147567_Desc = {
    Text = "Vollständig den \"Temporären Text\" auf Wahnsinn-Schwierigkeit"
  },
  Task_147568_Desc = {
    Text = "Vollständig den \"Temporären Text\" auf Wahnsinn-Schwierigkeit"
  },
  Task_147569_Desc = {
    Text = "Temporärer Text · Reich"
  },
  Task_147570_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_147571_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_147572_Desc = {
    Text = "Vollständig den \"Temporären Text\" auf Wahnsinn-Schwierigkeit"
  },
  Task_147573_Desc = {
    Text = "Vollständig den \"Temporären Text\" auf Wahnsinn-Schwierigkeit"
  },
  Task_147574_Desc = {
    Text = "Temporärer Text · Abschluss"
  },
  Task_147575_Desc = {
    Text = "Vollständig \"Temporärer Text\" bei beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_147676_Desc = {
    Text = "Spielerlevel erreicht Level 2"
  },
  Task_147676_Name = {
    Text = "(Verpackung ausstehend)"
  },
  Task_147677_Desc = {
    Text = "1 Erwecker auf Level 10 besitzen"
  },
  Task_147677_Name = {
    Text = "(Verpackung ausstehend)"
  },
  Task_147678_Desc = {
    Text = "Ermittlungsereignis „Einschulungstag“ abschließen"
  },
  Task_147678_Name = {
    Text = "(Verpackung ausstehend)"
  },
  Task_147679_Desc = {
    Text = "5 Erwecker besitzen"
  },
  Task_147679_Name = {
    Text = "(Verpackung ausstehend)"
  },
  Task_147894_Desc = {
    Text = "Temporärer Text"
  },
  Task_147894_Name = {Text = "Ziel"},
  Task_147895_Desc = {
    Text = "Schließe die Haupthandlung „Wenn der Berg speist“ im Schwierig-Modus ab"
  },
  Task_147895_Name = {
    Text = "Ruhe auf 8.840 Metern: Schwierig"
  },
  Task_147896_Desc = {
    Text = "Temporärer Text"
  },
  Task_147896_Name = {Text = "Ziel"},
  Task_147897_Desc = {
    Text = "Temporärer Text"
  },
  Task_147897_Name = {Text = "Ziel"},
  Task_147898_Desc = {
    Text = "Temporärer Text"
  },
  Task_147898_Name = {Text = "Ziel"},
  Task_147899_Desc = {
    Text = "Temporärer Text"
  },
  Task_147899_Name = {Text = "Ziel"},
  Task_147900_Desc = {
    Text = "Temporärer Text"
  },
  Task_147900_Name = {Text = "Ziel"},
  Task_147901_Desc = {
    Text = "Temporärer Text"
  },
  Task_147901_Name = {Text = "Ziel"},
  Task_147902_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 9 Mal Resonanz erzeugt"
  },
  Task_147902_Desc2 = {
    Text = "Resoniere 9 Mal in der Haupthandlung „Wenn der Berg speist“"
  },
  Task_147902_Name2 = {
    Text = "Siebenfältiger Ritus der Arglosen IV"
  },
  Task_147903_Desc = {
    Text = "Temporärer Text"
  },
  Task_147903_Name = {Text = "Ziel"},
  Task_147904_Desc = {
    Text = "Temporärer Text"
  },
  Task_147904_Name = {Text = "Ziel"},
  Task_147905_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 3 Mal Resonanz erzeugt"
  },
  Task_147905_Desc2 = {
    Text = "Resoniere 3 Mal in der Haupthandlung „Wenn der Berg speist“"
  },
  Task_147905_Name2 = {
    Text = "Siebenfältiger Ritus der Arglosen"
  },
  Task_147906_Desc = {
    Text = "In der Untersuchung Veranstaltung \"@1@2\" 7 Mal resoniert"
  },
  Task_147906_Desc2 = {
    Text = "9-mal in der Handlung „Wenn der Berg speist“ resonieren"
  },
  Task_147906_Name2 = {
    Text = "Siebenfältiger Ritus der Arglosen III"
  },
  Task_147907_Desc = {
    Text = "5-mal im Ermittlungsereignis „@1@2“ resonieren"
  },
  Task_147907_Desc2 = {
    Text = "6-mal in der Handlung „Wenn der Berg speist“ resonieren"
  },
  Task_147907_Name2 = {
    Text = "Siebenfältiger Ritus der Arglosen II"
  },
  Task_147908_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"@1@2\""
  },
  Task_147908_Desc2 = {
    Text = "Schließe die Haupthandlung „Wenn der Berg speist“ ab"
  },
  Task_147908_Name2 = {
    Text = "Ruhe auf 8.840 Metern"
  },
  Task_147909_Desc = {
    Text = "Temporärer Text"
  },
  Task_147909_Name = {Text = "Ziel"},
  Task_147910_Desc = {
    Text = "Temporärer Text"
  },
  Task_147910_Name = {Text = "Ziel"},
  Task_148121_Desc = {
    Text = "Schließe 15 Sendungen ab"
  },
  Task_148122_Desc = {
    Text = "Regionaler D-Effekt Spezialtraining erreicht 100"
  },
  Task_148123_Desc = {
    Text = "Gesamte Anmeldung 1 Tag"
  },
  Task_148124_Desc = {
    Text = "30 Mal erwachen"
  },
  Task_148125_Desc = {
    Text = "Gesamte Anmeldung 1 Tag"
  },
  Task_148126_Desc = {
    Text = "Schließe eine beliebige Saisonmission ab"
  },
  Task_148127_Desc = {
    Text = "Schließe eine beliebige Saisonmission ab"
  },
  Task_148128_Desc = {
    Text = "Regionaler D-Effekt Spezialtraining erreicht 100"
  },
  Task_148129_Desc = {
    Text = "30 Mal erwachen"
  },
  Task_148130_Desc = {
    Text = "Schließe 15 Sendungen ab"
  },
  Task_148131_Desc = {
    Text = "Verwende Unterstützung 3 Mal"
  },
  Task_148132_Desc = {
    Text = "Raffinierte Aktiv-Ionen erreichen 1000"
  },
  Task_148133_Desc = {
    Text = "Verwende Unterstützung 3 Mal"
  },
  Task_148134_Desc = {
    Text = "Spiele insgesamt 300 Karten aus"
  },
  Task_148135_Desc = {
    Text = "Raffinierte Aktiv-Ionen erreichen 1000"
  },
  Task_148136_Desc = {
    Text = "Spiele insgesamt 300 Karten aus"
  },
  Task_148489_Desc = {
    Text = "Schließe Bewusstseinsdrift „Fünf-Tage-Gespräch“ ab"
  },
  Task_148489_Name = {
    Text = "Triumph der Heimatlosen"
  },
  Task_148490_Desc = {
    Text = "Schließe Bewusstseinsdrift „Fünf-Tage-Gespräch“ im Schwierig-Modus ab"
  },
  Task_148490_Name = {
    Text = "Triumph der Heimatlosen·Schwierig"
  },
  Task_149335_Desc = {
    Text = "Drachentöter"
  },
  Task_149335_Name = {Text = "Ziel"},
  Task_149989_Desc = {
    Text = "Sternekapitel 6-1 abgeschlossen"
  },
  Task_149990_Desc = {
    Text = "Ursprung Ogier erreicht Persönlichkeitsvertiefung 12"
  },
  Task_19734_Desc = {
    Text = "Vollständige Ultra-Reise Riss VI"
  },
  Task_19735_Desc = {
    Text = "Clear Caro-Sumpf · Riss VIII"
  },
  Task_19736_Desc = {
    Text = "Clear Ultra-Reise · Riss IV"
  },
  Task_19737_Desc = {
    Text = "Clear Caro-Sumpf · Riss II"
  },
  Task_19738_Desc = {
    Text = "Clear Ultra-Reise · Riss II"
  },
  Task_19739_Desc = {
    Text = "Caro-Riss VI abschließen"
  },
  Task_19740_Desc = {
    Text = "Setze Fallen und führe \"Jagd\" aus"
  },
  Task_19740_Name = {Text = "Ziel"},
  Task_19741_Desc = {
    Text = "Clear Ultra-Reise: Riss VIII"
  },
  Task_19742_Desc = {
    Text = "Vollständig Aequor: Riss II"
  },
  Task_19743_Desc = {
    Text = "Clear Chaos-Bereich·Riss II"
  },
  Task_19744_Desc = {
    Text = "Vollständig Aequor: Riss VI"
  },
  Task_19745_Desc = {
    Text = "Clear Chaos-Bereich·Riss IV"
  },
  Task_19746_Desc = {
    Text = "Vollständig Aequor: Riss IV"
  },
  Task_19747_Desc = {
    Text = "Clear Chaos-Bereich · Riss VI"
  },
  Task_19748_Desc = {
    Text = "Clear Chaos-Bereich · Riss VIII"
  },
  Task_19749_Desc = {
    Text = "Vollständig Aequor: Riss VIII"
  },
  Task_19750_Desc = {
    Text = "Setze Fallen und führe \"Jagd\" aus"
  },
  Task_19750_Name = {Text = "Ziel"},
  Task_19751_Desc = {
    Text = "Unterstütze Lotan bei der Verfolgung von Feinde"
  },
  Task_19751_Name = {Text = "Ziel"},
  Task_19752_Desc = {
    Text = "Caro-Riss IV abschließen"
  },
  Task_20972_Desc = {
    Text = "Clear Ultra Reise Riss I"
  },
  Task_20973_Desc = {
    Text = "Vollständig Aequor: Riss I"
  },
  Task_20990_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_20990_Name = {
    Text = "Schnelle Lösung"
  },
  Task_20991_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_20991_Name = {
    Text = "Perfekter Pass"
  },
  Task_20992_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_20992_Name = {
    Text = "Perfekter Pass"
  },
  Task_20993_Desc = {
    Text = "Im finalen Kampf aktiviere Exalt mindestens 4 Mal in einem Zug."
  },
  Task_20993_Name = {
    Text = "Tödliche Magie"
  },
  Task_20994_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_20994_Name = {
    Text = "Perfekter Pass"
  },
  Task_20995_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_20995_Name = {
    Text = "Perfekter Pass"
  },
  Task_20996_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_20996_Name = {
    Text = "Elegant und präzise"
  },
  Task_20997_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_20997_Name = {
    Text = "Schnelle Lösung"
  },
  Task_20998_Desc = {
    Text = "Ziehe mindestens 5 zusätzliche Karten in einem Zug während des Endkampfes"
  },
  Task_20998_Name = {Text = "Draw!"},
  Task_20999_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_20999_Name = {
    Text = "Perfekter Pass"
  },
  Task_21000_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21000_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21001_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21001_Name = {
    Text = "Perfekter Pass"
  },
  Task_21002_Desc = {
    Text = "Wecke alle Erwachten nach Abschluss"
  },
  Task_21002_Name = {
    Text = "Unendliche Umarmung"
  },
  Task_21003_Desc = {
    Text = "Erhalte mindestens 4 verschiedene Arten von Orisons"
  },
  Task_21003_Name = {Text = "Seelenmark"},
  Task_21004_Desc = {
    Text = "Füge in einer Runde während eines Elite-Kampfes mindestens 240 Schadenspunkte zu."
  },
  Task_21004_Name = {
    Text = "Volltreffer"
  },
  Task_21005_Desc = {
    Text = "Keine Lebenswiederherstellung von der Verbindung nach Abschluss"
  },
  Task_21005_Name = {
    Text = "Die Ungeweckten"
  },
  Task_21006_Desc = {
    Text = "Habe nicht mehr als 3 Symptomkarten bei Abschluss"
  },
  Task_21006_Name = {
    Text = "Energiesparmodus"
  },
  Task_21007_Desc = {
    Text = "Trage mindestens 1 verfluchtes Relikt bei Abschluss."
  },
  Task_21007_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21008_Desc = {
    Text = "Habe nicht mehr als 1 Symptomkarte bei Abschluss"
  },
  Task_21008_Name = {
    Text = "Energiesparmodus"
  },
  Task_21009_Desc = {
    Text = "Spiele mindestens 4 Karten in einem Zug während des Finalen Kampfes"
  },
  Task_21009_Name = {
    Text = "Ich bin dran!"
  },
  Task_21010_Desc = {
    Text = "Erkundungsfortschritt erreicht 100%"
  },
  Task_21010_Name = {
    Text = "Überblicke das Nebelreich"
  },
  Task_21011_Desc = {
    Text = "Trage mindestens 5 Relikte bei Abschluss"
  },
  Task_21011_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21012_Desc = {
    Text = "Trage mindestens 5 Relikte bei Abschluss"
  },
  Task_21012_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21013_Desc = {
    Text = "Trage mindestens 5 Relikte bei Abschluss"
  },
  Task_21013_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21014_Desc = {
    Text = "In einem Zug des finalen Kampfes staple einen Schild in Höhe von mindestens 50% der maximalen Gesundheit."
  },
  Task_21014_Name = {Text = "Ironclad"},
  Task_21015_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21015_Name = {
    Text = "Perfekter Pass"
  },
  Task_21016_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_21016_Name = {
    Text = "Elegant und präzise"
  },
  Task_21017_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21017_Name = {
    Text = "Perfekter Pass"
  },
  Task_21018_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_21018_Name = {
    Text = "Elegant und präzise"
  },
  Task_21019_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_21019_Name = {
    Text = "Elegant und präzise"
  },
  Task_21020_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21020_Name = {
    Text = "Perfekter Pass"
  },
  Task_21021_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 15 Zügen"
  },
  Task_21021_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21022_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21022_Name = {
    Text = "Perfekter Pass"
  },
  Task_21023_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_21023_Name = {
    Text = "Energiesparmodus"
  },
  Task_21024_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21024_Name = {
    Text = "Perfekter Pass"
  },
  Task_21025_Desc = {
    Text = "Im finalen Kampf aktiviere Exalt mindestens 4 Mal in einem Zug."
  },
  Task_21025_Name = {
    Text = "Tödliche Magie"
  },
  Task_21026_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21026_Name = {
    Text = "Perfekter Pass"
  },
  Task_21027_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21027_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21028_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 15 Zügen"
  },
  Task_21028_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21029_Desc = {
    Text = "Spiele mindestens 6 Karten in einem Zug während des Finalen Kampfes"
  },
  Task_21029_Name = {
    Text = "Ich bin dran!"
  },
  Task_21030_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21030_Name = {
    Text = "Perfekter Pass"
  },
  Task_21032_Desc = {
    Text = "Im Finalkampf in einer Runde mindestens 40000 Punkte Schaden verursachen"
  },
  Task_21032_Name = {
    Text = "Volltreffer"
  },
  Task_21033_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21033_Name = {
    Text = "Perfekter Pass"
  },
  Task_21034_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21034_Name = {
    Text = "Perfekter Pass"
  },
  Task_21035_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_21035_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21036_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21036_Name = {
    Text = "Perfekter Pass"
  },
  Task_21037_Desc = {
    Text = "Habe nicht mehr als 1 Symptomkarte bei Abschluss"
  },
  Task_21037_Name = {
    Text = "Energiesparmodus"
  },
  Task_21038_Desc = {
    Text = "Spiele mindestens 4 Karten in einem Zug während des Finalen Kampfes"
  },
  Task_21038_Name = {
    Text = "Ich bin dran!"
  },
  Task_21039_Desc = {
    Text = "Erkundungsfortschritt erreicht 100%"
  },
  Task_21039_Name = {
    Text = "Überblicke das Nebelreich"
  },
  Task_21040_Desc = {
    Text = "Trage mindestens 5 Relikte bei Abschluss"
  },
  Task_21040_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21041_Desc = {
    Text = "Trage mindestens 5 Relikte bei Abschluss"
  },
  Task_21041_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21042_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_21042_Name = {
    Text = "Elegant und präzise"
  },
  Task_21043_Desc = {
    Text = "In einem Zug des finalen Kampfes staple einen Schild in Höhe von mindestens 50% der maximalen Gesundheit."
  },
  Task_21043_Name = {Text = "Ironclad"},
  Task_21044_Desc = {
    Text = "Erhalte mindestens 4 verschiedene Arten von Orisons"
  },
  Task_21044_Name = {Text = "Seelenmark"},
  Task_21045_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_21045_Name = {
    Text = "Elegant und präzise"
  },
  Task_21046_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21046_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21047_Desc = {
    Text = "Im finalen Kampf aktiviere Exalt mindestens 4 Mal in einem Zug."
  },
  Task_21047_Name = {
    Text = "Tödliche Magie"
  },
  Task_21048_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21048_Name = {
    Text = "Perfekter Pass"
  },
  Task_21049_Desc = {
    Text = "Habe nicht mehr als 1 Symptomkarte bei Abschluss"
  },
  Task_21049_Name = {
    Text = "Energiesparmodus"
  },
  Task_21050_Desc = {
    Text = "Wecke alle Erwachten nach Abschluss"
  },
  Task_21050_Name = {
    Text = "Unendliche Umarmung"
  },
  Task_21051_Desc = {
    Text = "Trage mindestens 2 Relikte bei Abschluss"
  },
  Task_21051_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21052_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21052_Name = {
    Text = "Perfekter Pass"
  },
  Task_21053_Desc = {
    Text = "Erhalte mindestens 4 verschiedene Arten von Orisons"
  },
  Task_21053_Name = {Text = "Seelenmark"},
  Task_21054_Desc = {
    Text = "Erhalte mindestens 4 verschiedene Arten von Orisons"
  },
  Task_21054_Name = {Text = "Seelenmark"},
  Task_21055_Desc = {
    Text = "Füge in einer Runde während eines Elite-Kampfes mindestens 980 Schadenspunkte zu."
  },
  Task_21055_Name = {
    Text = "Volltreffer"
  },
  Task_21056_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_21056_Name = {
    Text = "Elegant und präzise"
  },
  Task_21057_Desc = {
    Text = "Habe nicht mehr als 3 Symptomkarten bei Abschluss"
  },
  Task_21057_Name = {
    Text = "Energiesparmodus"
  },
  Task_21058_Desc = {
    Text = "Trage mindestens 1 verfluchtes Relikt bei Abschluss."
  },
  Task_21058_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21059_Desc = {
    Text = "Erkundungsfortschritt erreicht 100%"
  },
  Task_21059_Name = {
    Text = "Überblicke das Nebelreich"
  },
  Task_21060_Desc = {
    Text = "Verwende Exalt mindestens 3 Mal in einer einzigen Runde während eines Elitekampfes."
  },
  Task_21060_Name = {
    Text = "Tödliche Magie"
  },
  Task_21061_Desc = {
    Text = "Ziehe mindestens 5 zusätzliche Karten in einem Zug während des Endkampfes"
  },
  Task_21061_Name = {Text = "Draw!"},
  Task_21062_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_21062_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21063_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21063_Name = {
    Text = "Perfekter Pass"
  },
  Task_21064_Desc = {
    Text = "Trage mindestens 2 Relikte bei Abschluss"
  },
  Task_21064_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21065_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_21065_Name = {
    Text = "Energiesparmodus"
  },
  Task_21066_Desc = {
    Text = "Erhalte mindestens 3 Arten von Orisonen"
  },
  Task_21066_Name = {Text = "Seelenmark"},
  Task_21067_Desc = {
    Text = "Wecke mindestens 2 Erwachte nach Abschluss"
  },
  Task_21067_Name = {
    Text = "Unendliche Umarmung"
  },
  Task_21068_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_21068_Name = {
    Text = "Elegant und präzise"
  },
  Task_21069_Desc = {
    Text = "Trage mindestens 1 verfluchtes Relikt bei Abschluss."
  },
  Task_21069_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21070_Desc = {
    Text = "Spiele mindestens 4 Karten in einem Zug während des Finalen Kampfes"
  },
  Task_21070_Name = {
    Text = "Ich bin dran!"
  },
  Task_21071_Desc = {
    Text = "Im finalen Kampf aktiviere Exalt mindestens 3 Mal in einem Zug."
  },
  Task_21071_Name = {
    Text = "Tödliche Magie"
  },
  Task_21072_Desc = {
    Text = "Habe nicht mehr als 3 Symptomkarten bei Abschluss"
  },
  Task_21072_Name = {
    Text = "Energiesparmodus"
  },
  Task_21073_Desc = {
    Text = "Habe nicht mehr als 1 Symptomkarte bei Abschluss"
  },
  Task_21073_Name = {
    Text = "Energiesparmodus"
  },
  Task_21074_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21074_Name = {
    Text = "Perfekter Pass"
  },
  Task_21075_Desc = {
    Text = "Besitze 4 verschiedene Arten von Orison"
  },
  Task_21075_Name = {Text = "Seelenmark"},
  Task_21076_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21076_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21077_Desc = {
    Text = "Spiele mindestens 5 Karten in einem Zug während des Finalen Kampfes."
  },
  Task_21077_Name = {
    Text = "Ich bin dran!"
  },
  Task_21078_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21078_Name = {
    Text = "Perfekter Pass"
  },
  Task_21079_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21079_Name = {
    Text = "Perfekter Pass"
  },
  Task_21080_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21080_Name = {
    Text = "Perfekter Pass"
  },
  Task_21081_Desc = {
    Text = "Füge 350 Schaden in einer Runde während des Endkampfes zu."
  },
  Task_21081_Name = {
    Text = "Volltreffer"
  },
  Task_21082_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21082_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21083_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21083_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21084_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21084_Name = {
    Text = "Perfekter Pass"
  },
  Task_21085_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21085_Name = {
    Text = "Perfekter Pass"
  },
  Task_21086_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_21086_Name = {
    Text = "Energiesparmodus"
  },
  Task_21087_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21087_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21088_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21088_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21089_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21089_Name = {
    Text = "Perfekter Pass"
  },
  Task_21090_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21090_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21091_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21091_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21092_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21092_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21093_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21093_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21094_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21094_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21095_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_21095_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21096_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_21096_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21097_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_21097_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21098_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_21098_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21099_Desc = {
    Text = "Trage mindestens 1 verfluchtes Relikt bei Abschluss."
  },
  Task_21099_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21100_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_21100_Name = {
    Text = "Elegant und präzise"
  },
  Task_21101_Desc = {
    Text = "Besiege mindestens 2 Monster in einer Runde eines beliebigen Kampfes"
  },
  Task_21101_Name = {
    Text = "Wurzel und Stamm"
  },
  Task_21102_Desc = {
    Text = "Trage mindestens 8 Relikte bei Abschluss."
  },
  Task_21102_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21103_Desc = {
    Text = "Habe nicht mehr als 1 Symptomkarte bei Abschluss"
  },
  Task_21103_Name = {
    Text = "Energiesparmodus"
  },
  Task_21104_Desc = {
    Text = "Spiele mindestens 5 Karten in einem Zug während des Finalen Kampfes."
  },
  Task_21104_Name = {
    Text = "Ich bin dran!"
  },
  Task_21105_Desc = {
    Text = "Füge in einer Runde während des Finalen Kampfes mindestens 300 Schadenspunkte zu"
  },
  Task_21105_Name = {
    Text = "Volltreffer"
  },
  Task_21106_Desc = {
    Text = "Ziehe mindestens 3 zusätzliche Karten in einem Zug während des Endkampfes"
  },
  Task_21106_Name = {Text = "Draw!"},
  Task_21107_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21107_Name = {
    Text = "Perfekter Pass"
  },
  Task_21108_Desc = {
    Text = "Im Finalkampf in einer Runde mindestens 96000 Punkte Schaden verursachen"
  },
  Task_21108_Name = {
    Text = "Volltreffer"
  },
  Task_21110_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_21110_Name = {
    Text = "Energiesparmodus"
  },
  Task_21111_Desc = {
    Text = "Habe nicht mehr als 1 Symptomkarte bei Abschluss"
  },
  Task_21111_Name = {
    Text = "Energiesparmodus"
  },
  Task_21112_Desc = {
    Text = "Besiege mindestens 2 Monster in einer Runde eines beliebigen Kampfes"
  },
  Task_21112_Name = {
    Text = "Wurzel und Stamm"
  },
  Task_21113_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21113_Name = {
    Text = "Perfekter Pass"
  },
  Task_21114_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21114_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21115_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_21115_Name = {
    Text = "Energiesparmodus"
  },
  Task_21116_Desc = {
    Text = "Räume aus mit Leben nicht unter 80%"
  },
  Task_21116_Name = {
    Text = "Elegant und präzise"
  },
  Task_21117_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21117_Name = {
    Text = "Perfekter Pass"
  },
  Task_21118_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_21118_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21119_Desc = {
    Text = "Habe nicht mehr als 1 Symptomkarte bei Abschluss"
  },
  Task_21119_Name = {
    Text = "Energiesparmodus"
  },
  Task_21120_Desc = {
    Text = "Besiege mindestens 2 Monster in einer Runde eines beliebigen Kampfes"
  },
  Task_21120_Name = {
    Text = "Wurzel und Stamm"
  },
  Task_21121_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_21121_Name = {
    Text = "Energiesparmodus"
  },
  Task_21122_Desc = {
    Text = "Füge in einer Runde während eines Elite-Kampfes mindestens 1600 Schadenspunkte zu."
  },
  Task_21122_Name = {
    Text = "Volltreffer"
  },
  Task_21123_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21123_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21124_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21124_Name = {
    Text = "Perfekter Pass"
  },
  Task_21125_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21125_Name = {
    Text = "Perfekter Pass"
  },
  Task_21126_Desc = {
    Text = "Verwende Exalt mindestens 3 Mal in einer einzigen Runde während eines Elitekampfes."
  },
  Task_21126_Name = {
    Text = "Tödliche Magie"
  },
  Task_21127_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_21127_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21128_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21128_Name = {
    Text = "Perfekter Pass"
  },
  Task_21129_Desc = {
    Text = "Habe nicht mehr als 1 Symptomkarte bei Abschluss"
  },
  Task_21129_Name = {
    Text = "Energiesparmodus"
  },
  Task_21130_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21130_Name = {
    Text = "Perfekter Pass"
  },
  Task_21131_Desc = {
    Text = "Wecke alle Erwachten nach Abschluss"
  },
  Task_21131_Name = {
    Text = "Unendliche Umarmung"
  },
  Task_21132_Desc = {
    Text = "Füge in einer Runde während des Finalen Kampfes mindestens 6000 Schadenspunkte zu"
  },
  Task_21132_Name = {
    Text = "Volltreffer"
  },
  Task_21133_Desc = {
    Text = "Ziehe mindestens 5 zusätzliche Karten in einem Zug während des Endkampfes"
  },
  Task_21133_Name = {Text = "Draw!"},
  Task_21134_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21134_Name = {
    Text = "Perfekter Pass"
  },
  Task_21135_Desc = {
    Text = "Ziehe mindestens 4 zusätzliche Karten in einem Zug während des Endkampfes"
  },
  Task_21135_Name = {Text = "Draw!"},
  Task_21136_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 15 Zügen"
  },
  Task_21136_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21137_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_21137_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21138_Desc = {
    Text = "Füge in einer Runde während eines Elite-Kampfes mindestens 1800 Schadenspunkte zu."
  },
  Task_21138_Name = {
    Text = "Volltreffer"
  },
  Task_21139_Desc = {
    Text = "Trage mindestens 1 verfluchtes Relikt bei Abschluss."
  },
  Task_21139_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21140_Desc = {
    Text = "Spiele mindestens 5 Karten in einem Zug während des Finalen Kampfes."
  },
  Task_21140_Name = {
    Text = "Ich bin dran!"
  },
  Task_21141_Desc = {
    Text = "In einem Zug des finalen Kampfes staple einen Schild in Höhe von mindestens 65% der maximalen Gesundheit."
  },
  Task_21141_Name = {Text = "Ironclad"},
  Task_21142_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_21142_Name = {
    Text = "Energiesparmodus"
  },
  Task_21143_Desc = {
    Text = "Erhalte mindestens 4 verschiedene Arten von Orisons"
  },
  Task_21143_Name = {Text = "Seelenmark"},
  Task_21144_Desc = {
    Text = "Trage mindestens 2 Relikte bei Abschluss"
  },
  Task_21144_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21145_Desc = {
    Text = "Verwende Verbindung zur Lebenswiederherstellung nicht mehr als 1 Mal."
  },
  Task_21145_Name = {
    Text = "Die Ungeweckten"
  },
  Task_21146_Desc = {
    Text = "Trage mindestens 1 verfluchtes Relikt bei Abschluss."
  },
  Task_21146_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21147_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_21147_Name = {
    Text = "Energiesparmodus"
  },
  Task_21148_Desc = {
    Text = "Füge in einer Runde während eines Elite-Kampfes mindestens 500 Schadenspunkte zu."
  },
  Task_21148_Name = {
    Text = "Volltreffer"
  },
  Task_21149_Desc = {
    Text = "Besiege mindestens 2 Monster in einer Runde eines beliebigen Kampfes"
  },
  Task_21149_Name = {
    Text = "Wurzel und Stamm"
  },
  Task_21150_Desc = {
    Text = "Wecke mindestens 3 Erwachte"
  },
  Task_21150_Name = {
    Text = "Unendliche Umarmung"
  },
  Task_21151_Desc = {
    Text = "Erhalte mindestens 4 verschiedene Arten von Orisons"
  },
  Task_21151_Name = {Text = "Seelenmark"},
  Task_21152_Desc = {
    Text = "Erkundungsfortschritt erreicht 100%"
  },
  Task_21152_Name = {
    Text = "Überblicke das Nebelreich"
  },
  Task_21153_Desc = {
    Text = "Im finalen Kampf aktiviere Exalt mindestens 4 Mal in einem Zug."
  },
  Task_21153_Name = {
    Text = "Tödliche Magie"
  },
  Task_21154_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_21154_Name = {
    Text = "Energiesparmodus"
  },
  Task_21155_Desc = {
    Text = "In einem Zug des finalen Kampfes staple einen Schild in Höhe von mindestens 60% der maximalen Gesundheit."
  },
  Task_21155_Name = {Text = "Ironclad"},
  Task_21156_Desc = {
    Text = "Trage mindestens 8 Relikte bei Abschluss."
  },
  Task_21156_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21157_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_21157_Name = {
    Text = "Elegant und präzise"
  },
  Task_21158_Desc = {
    Text = "Ziehe mindestens 4 zusätzliche Karten in einem Zug während des Endkampfes"
  },
  Task_21158_Name = {Text = "Draw!"},
  Task_21159_Desc = {
    Text = "Im Finalkampf in einer Runde mindestens 5200 Punkte Schaden verursachen"
  },
  Task_21159_Name = {
    Text = "Volltreffer"
  },
  Task_21160_Desc = {
    Text = "Ziehe mindestens 3 zusätzliche Karten in einem Zug während des Endkampfes"
  },
  Task_21160_Name = {Text = "Draw!"},
  Task_21161_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21161_Name = {
    Text = "Perfekter Pass"
  },
  Task_21162_Desc = {
    Text = "In einem Zug des finalen Kampfes staple einen Schild in Höhe von mindestens 65% der maximalen Gesundheit."
  },
  Task_21162_Name = {Text = "Ironclad"},
  Task_21163_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_21163_Name = {
    Text = "Energiesparmodus"
  },
  Task_21164_Desc = {
    Text = "Trage mindestens 1 verfluchtes Relikt bei Abschluss."
  },
  Task_21164_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21165_Desc = {
    Text = "Spiele mindestens 4 Karten in einem Zug während des Finalen Kampfes"
  },
  Task_21165_Name = {
    Text = "Ich bin dran!"
  },
  Task_21166_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21166_Name = {
    Text = "Perfekter Pass"
  },
  Task_21167_Desc = {
    Text = "Besitze 4 verschiedene Arten von Orison"
  },
  Task_21167_Name = {Text = "Seelenmark"},
  Task_21168_Desc = {
    Text = "Verursache 120 Schaden in einer Runde während des Finalkampfs"
  },
  Task_21168_Name = {
    Text = "Volltreffer"
  },
  Task_21169_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_21169_Name = {
    Text = "Elegant und präzise"
  },
  Task_21170_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_21170_Name = {
    Text = "Elegant und präzise"
  },
  Task_21171_Desc = {
    Text = "Besiege mindestens 2 Monster in einer Runde eines beliebigen Kampfes"
  },
  Task_21171_Name = {
    Text = "Wurzel und Stamm"
  },
  Task_21172_Desc = {
    Text = "Ziehe mindestens 3 zusätzliche Karten in einem Zug während des Endkampfes"
  },
  Task_21172_Name = {Text = "Draw!"},
  Task_21173_Desc = {
    Text = "Wecke mindestens 3 Erwachte"
  },
  Task_21173_Name = {
    Text = "Unendliche Umarmung"
  },
  Task_21174_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_21174_Name = {
    Text = "Elegant und präzise"
  },
  Task_21176_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21176_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21177_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21177_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21178_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_21178_Name = {
    Text = "Energiesparmodus"
  },
  Task_21179_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21179_Name = {
    Text = "Perfekter Pass"
  },
  Task_21180_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21180_Name = {
    Text = "Perfekter Pass"
  },
  Task_21181_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21181_Name = {
    Text = "Perfekter Pass"
  },
  Task_21182_Desc = {
    Text = "Habe nicht mehr als 1 Symptomkarte bei Abschluss"
  },
  Task_21182_Name = {
    Text = "Energiesparmodus"
  },
  Task_21183_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_21183_Name = {
    Text = "Energiesparmodus"
  },
  Task_21184_Desc = {
    Text = "Erkundungsfortschritt erreicht 100%"
  },
  Task_21184_Name = {
    Text = "Überblicke das Nebelreich"
  },
  Task_21185_Desc = {
    Text = "Füge in einer Runde während des Finalen Kampfes mindestens 1000 Schadenspunkte zu"
  },
  Task_21185_Name = {
    Text = "Volltreffer"
  },
  Task_21186_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21186_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21187_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_21187_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21188_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_21188_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21189_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21189_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21190_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21190_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21191_Desc = {
    Text = "Habe nicht mehr als 1 Symptomkarte bei Abschluss"
  },
  Task_21191_Name = {
    Text = "Energiesparmodus"
  },
  Task_21192_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_21192_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21193_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_21193_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21194_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_21194_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21195_Desc = {
    Text = "Im Finalkampf in einer Runde mindestens 7300 Punkte Schaden verursachen"
  },
  Task_21195_Name = {
    Text = "Volltreffer"
  },
  Task_21196_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_21196_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21197_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_21197_Name = {
    Text = "Elegant und präzise"
  },
  Task_21198_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21198_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21199_Desc = {
    Text = "Spiele mindestens 4 Karten in einem Zug während des Finalen Kampfes"
  },
  Task_21199_Name = {
    Text = "Ich bin dran!"
  },
  Task_21200_Desc = {
    Text = "Habe nicht mehr als 3 Symptomkarten bei Abschluss"
  },
  Task_21200_Name = {
    Text = "Energiesparmodus"
  },
  Task_21201_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21201_Name = {
    Text = "Perfekter Pass"
  },
  Task_21202_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21202_Name = {
    Text = "Perfekter Pass"
  },
  Task_21203_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21203_Name = {
    Text = "Perfekter Pass"
  },
  Task_21204_Desc = {
    Text = "Trage mindestens 2 Relikte bei Abschluss"
  },
  Task_21204_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21205_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_21205_Name = {
    Text = "Energiesparmodus"
  },
  Task_21206_Desc = {
    Text = "Erhalte mindestens 3 Arten von Orisonen"
  },
  Task_21206_Name = {Text = "Seelenmark"},
  Task_21207_Desc = {
    Text = "Wecke mindestens 2 Erwachte nach Abschluss"
  },
  Task_21207_Name = {
    Text = "Unendliche Umarmung"
  },
  Task_21208_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_21208_Name = {
    Text = "Elegant und präzise"
  },
  Task_21209_Desc = {
    Text = "Trage mindestens 1 verfluchtes Relikt bei Abschluss."
  },
  Task_21209_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21210_Desc = {
    Text = "Spiele mindestens 4 Karten in einem Zug während des Finalen Kampfes"
  },
  Task_21210_Name = {
    Text = "Ich bin dran!"
  },
  Task_21211_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21211_Name = {
    Text = "Perfekter Pass"
  },
  Task_21212_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21212_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21213_Desc = {
    Text = "Füge in einer Runde während des Finalen Kampfes mindestens 2500 Schadenspunkte zu"
  },
  Task_21213_Name = {
    Text = "Volltreffer"
  },
  Task_21214_Desc = {
    Text = "Ziehe mindestens 5 zusätzliche Karten in einem Zug während des Endkampfes"
  },
  Task_21214_Name = {Text = "Draw!"},
  Task_21215_Desc = {
    Text = "Spiele mindestens 6 Karten in einem Zug während des Finalen Kampfes"
  },
  Task_21215_Name = {
    Text = "Ich bin dran!"
  },
  Task_21216_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_21216_Name = {
    Text = "Elegant und präzise"
  },
  Task_21217_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_21217_Name = {
    Text = "Elegant und präzise"
  },
  Task_21218_Desc = {
    Text = "Wecke alle Erwachten nach Abschluss"
  },
  Task_21218_Name = {
    Text = "Unendliche Umarmung"
  },
  Task_21219_Desc = {
    Text = "Ziehe mindestens 3 zusätzliche Karten in einem Zug während des Endkampfes"
  },
  Task_21219_Name = {Text = "Draw!"},
  Task_21220_Desc = {
    Text = "Wecke mindestens 3 Erwachte"
  },
  Task_21220_Name = {
    Text = "Unendliche Umarmung"
  },
  Task_21221_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_21221_Name = {
    Text = "Elegant und präzise"
  },
  Task_21222_Desc = {
    Text = "Trage mindestens 1 verfluchtes Relikt bei Abschluss."
  },
  Task_21222_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21223_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21223_Name = {
    Text = "Perfekter Pass"
  },
  Task_21224_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21224_Name = {
    Text = "Perfekter Pass"
  },
  Task_21225_Desc = {
    Text = "Besiege mindestens 2 Monster in einer Runde eines beliebigen Kampfes"
  },
  Task_21225_Name = {
    Text = "Wurzel und Stamm"
  },
  Task_21226_Desc = {
    Text = "Trage mindestens 2 Relikte bei Abschluss"
  },
  Task_21226_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21227_Desc = {
    Text = "Erhalte mindestens 4 verschiedene Arten von Orisons"
  },
  Task_21227_Name = {Text = "Seelenmark"},
  Task_21228_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21228_Name = {
    Text = "Perfekter Pass"
  },
  Task_21229_Desc = {
    Text = "Keine Lebenswiederherstellung von der Verbindung nach Abschluss"
  },
  Task_21229_Name = {
    Text = "Die Ungeweckten"
  },
  Task_21230_Desc = {
    Text = "Erkundungsfortschritt erreicht 100%"
  },
  Task_21230_Name = {
    Text = "Überblicke das Nebelreich"
  },
  Task_21231_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21231_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21232_Desc = {
    Text = "Verwende Verbindung zur Lebenswiederherstellung nicht mehr als 1 Mal."
  },
  Task_21232_Name = {
    Text = "Die Ungeweckten"
  },
  Task_21233_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21233_Name = {
    Text = "Perfekter Pass"
  },
  Task_21234_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21234_Name = {
    Text = "Perfekter Pass"
  },
  Task_21235_Desc = {
    Text = "Ziehe mindestens 4 zusätzliche Karten in einem Zug während des Endkampfes"
  },
  Task_21235_Name = {Text = "Draw!"},
  Task_21236_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21236_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21237_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21237_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21238_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21238_Name = {
    Text = "Perfekter Pass"
  },
  Task_21239_Desc = {
    Text = "Im finalen Kampf aktiviere Exalt mindestens 3 Mal in einem Zug."
  },
  Task_21239_Name = {
    Text = "Tödliche Magie"
  },
  Task_21240_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21240_Name = {
    Text = "Perfekter Pass"
  },
  Task_21241_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21241_Name = {
    Text = "Perfekter Pass"
  },
  Task_21242_Desc = {
    Text = "Räume aus mit Leben nicht unter 80%"
  },
  Task_21242_Name = {
    Text = "Elegant und präzise"
  },
  Task_21243_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21243_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21244_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21244_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21245_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21245_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21246_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21246_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21247_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21247_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21248_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21248_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21249_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21249_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21250_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 15 Zügen"
  },
  Task_21250_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21251_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21251_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21252_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21252_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21253_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21253_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21254_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_21254_Name = {
    Text = "Elegant und präzise"
  },
  Task_21255_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21255_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21256_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21256_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21257_Desc = {
    Text = "Füge in einer Runde während eines Elite-Kampfes mindestens 6000 Schadenspunkte zu."
  },
  Task_21257_Name = {
    Text = "Volltreffer"
  },
  Task_21258_Desc = {
    Text = "Trage mindestens 1 verfluchtes Relikt bei Abschluss."
  },
  Task_21258_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21259_Desc = {
    Text = "Spiele mindestens 5 Karten in einem Zug während des Finalen Kampfes."
  },
  Task_21259_Name = {
    Text = "Ich bin dran!"
  },
  Task_21260_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21260_Name = {
    Text = "Perfekter Pass"
  },
  Task_21261_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21261_Name = {
    Text = "Perfekter Pass"
  },
  Task_21262_Desc = {
    Text = "Erhalte mindestens 4 verschiedene Arten von Orisons"
  },
  Task_21262_Name = {Text = "Seelenmark"},
  Task_21263_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21263_Name = {
    Text = "Perfekter Pass"
  },
  Task_21264_Desc = {
    Text = "Trage mindestens 2 Relikte bei Abschluss"
  },
  Task_21264_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21265_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21265_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21266_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21266_Name = {
    Text = "Perfekter Pass"
  },
  Task_21267_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21267_Name = {
    Text = "Perfekter Pass"
  },
  Task_21268_Desc = {
    Text = "Wecke mindestens 3 Erwachte"
  },
  Task_21268_Name = {
    Text = "Unendliche Umarmung"
  },
  Task_21269_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21269_Name = {
    Text = "Perfekter Pass"
  },
  Task_21270_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21270_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21271_Desc = {
    Text = "Trage mindestens 5 Relikte bei Abschluss"
  },
  Task_21271_Name = {
    Text = "Geheimes Versteck"
  },
  Task_21272_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21272_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21273_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_21273_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21274_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21274_Name = {
    Text = "Perfekter Pass"
  },
  Task_21275_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_21275_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21276_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21276_Name = {
    Text = "Perfekter Pass"
  },
  Task_21277_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21277_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21278_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21278_Name = {
    Text = "Perfekter Pass"
  },
  Task_21279_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21279_Name = {
    Text = "Perfekter Pass"
  },
  Task_21280_Desc = {
    Text = "Wecke alle Erwachten nach Abschluss"
  },
  Task_21280_Name = {
    Text = "Unendliche Umarmung"
  },
  Task_21281_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_21281_Name = {
    Text = "Energiesparmodus"
  },
  Task_21282_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21282_Name = {
    Text = "Perfekter Pass"
  },
  Task_21283_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21283_Name = {
    Text = "Perfekter Pass"
  },
  Task_21284_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21284_Name = {
    Text = "Perfekter Pass"
  },
  Task_21285_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21285_Name = {
    Text = "Perfekter Pass"
  },
  Task_21286_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21286_Name = {
    Text = "Perfekter Pass"
  },
  Task_21287_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21287_Name = {
    Text = "Perfekter Pass"
  },
  Task_21288_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21288_Name = {
    Text = "Perfekter Pass"
  },
  Task_21289_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21289_Name = {
    Text = "Perfekter Pass"
  },
  Task_21290_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21290_Name = {
    Text = "Perfekter Pass"
  },
  Task_21291_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21291_Name = {
    Text = "Perfekter Pass"
  },
  Task_21292_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21292_Name = {
    Text = "Perfekter Pass"
  },
  Task_21293_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 15 Zügen"
  },
  Task_21293_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21294_Desc = {
    Text = "In einem Zug des finalen Kampfes staple einen Schild in Höhe von mindestens 60% der maximalen Gesundheit."
  },
  Task_21294_Name = {Text = "Ironclad"},
  Task_21295_Desc = {
    Text = "Wecke alle Erwachten nach Abschluss"
  },
  Task_21295_Name = {
    Text = "Unendliche Umarmung"
  },
  Task_21296_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_21296_Name = {
    Text = "Elegant und präzise"
  },
  Task_21297_Desc = {
    Text = "Ziehe mindestens 4 zusätzliche Karten in einem Zug während des Endkampfes"
  },
  Task_21297_Name = {Text = "Draw!"},
  Task_21298_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_21298_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21299_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 15 Zügen"
  },
  Task_21299_Name = {
    Text = "Schnelle Lösung"
  },
  Task_21300_Desc = {
    Text = "Squeak, squeak...!!"
  },
  Task_21300_Name = {Text = "Quietschen"},
  Task_21301_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_21301_Name = {
    Text = "Perfekter Pass"
  },
  Task_21401_Desc = {
    Text = "Spiele 50 Karte"
  },
  Task_21401_Name = {
    Text = "Tägliche Probe"
  },
  Task_21794_Desc = {
    Text = "Logge dich an insgesamt 3 aufeinander folgenden Tagen ein"
  },
  Task_21795_Desc = {
    Text = "Logge dich insgesamt 7 Tage lang ein"
  },
  Task_21821_Desc = {
    Text = "Startpunkt: 40 Punkte. Nach 3 Runden abziehen 5 Punkte pro Runde."
  },
  Task_21821_Name = {
    Text = "Elite-Runden  <size=20><color=#747474>Beginnen Sie mit 40 Punkten, verlieren Sie ab der 3. Runde 5 Punkte pro Runde</color></size>"
  },
  Task_21822_Desc = {
    Text = "Startpunkt: 40 Punkte. Für jeden Schritt über 40 Schritte werden 2 Punkte abgezogen."
  },
  Task_21822_Name = {
    Text = "Gesamt Schritte <size=20><color=#747474>Beginne mit 40 Punkten, jeder Schritt über 40 zieht 2 Punkte ab</color></size>"
  },
  Task_21823_Desc = {
    Text = "Beginne mit 600 Punkten, verliere 60 Punkte pro Runde nach 12 Runden."
  },
  Task_21823_Name = {
    Text = "Finalkampf-Runden <size=20><color=#747474>Beginnt bei 600 Punkten, Abzug von 60 Punkten pro Runde nach 12 Runden</color></size>"
  },
  Task_21824_Desc = {
    Text = "Ursprüngliche Punktzahl von 30 pro Spiel, nach 2 Runden 3 Punkte pro Runde abziehen."
  },
  Task_21824_Name = {
    Text = "Kampf Runden <size=20><color=#747474>Beginnt mit 30 Punkten pro Match, verliert nach 2 Runden 3 Punkte pro Runde</color></size>"
  },
  Task_21907_Desc = {
    Text = "Insgesamt 50 Mal erwachen"
  },
  Task_21908_Desc = {
    Text = "Sammeln Sie 300 Erwachungen"
  },
  Task_21914_Desc = {
    Text = "Erreiche Ermittlungslevel 40"
  },
  Task_21915_Desc = {
    Text = "Vollständig \"Ermittlungsoperation\" Kapitel 1"
  },
  Task_21916_Desc = {
    Text = "Erreiche Ermittlung Level 30"
  },
  Task_21917_Desc = {
    Text = "Ermittlungsstufe erreicht Stufe 20"
  },
  Task_21918_Desc = {
    Text = "Erreiche Ermittlung Level 50"
  },
  Task_22347_Desc = {
    Text = "Besiege Uvhash"
  },
  Task_22347_Name = {Text = "Ziel"},
  Task_22348_Desc = {
    Text = "Augustus der Impulsregler"
  },
  Task_22348_Name = {Text = "Ziel"},
  Task_22349_Desc = {
    Text = "Bewache die Prinzessi"
  },
  Task_22349_Name = {Text = "Ziel"},
  Task_22350_Desc = {
    Text = "Stoppe August"
  },
  Task_22350_Name = {Text = "Ziel"},
  Task_22351_Desc = {
    Text = "Finde Agrippa"
  },
  Task_22351_Name = {Text = "Ziel"},
  Task_22352_Desc = {
    Text = "Weiche dem Sandsturm aus"
  },
  Task_22352_Name = {Text = "Ziel"},
  Task_22353_Desc = {
    Text = "Schützen Sie Erica"
  },
  Task_22353_Name = {Text = "Ziel"},
  Task_22354_Desc = {
    Text = "Finde Erica"
  },
  Task_22354_Name = {Text = "Ziel"},
  Task_22355_Desc = {
    Text = "Folge Uvhash"
  },
  Task_22355_Name = {Text = "Ziel"},
  Task_22356_Desc = {
    Text = "Die wütenden Sklaven zurückdrängen"
  },
  Task_22356_Name = {Text = "Ziel"},
  Task_22358_Desc = {
    Text = "Gewährt ein Schild, das 50% der maximalen Gesundheit entspricht"
  },
  Task_22358_Name = {
    Text = "Lebensschutz II"
  },
  Task_22359_Desc = {
    Text = "Gewährt ein Schild, das 30% der maximalen Gesundheit entspricht"
  },
  Task_22359_Name = {
    Text = "Lebenswächter I"
  },
  Task_22380_Desc = {
    Text = "Finde 10 Extraktionspunkte im Hauptgeschichten Kapitel 5 \"@1@2\""
  },
  Task_22380_Desc2 = {
    Text = "Finde 10 Entnahmepunkte in der Hauptgeschichte Kapitel 5 \"Sturmauge\""
  },
  Task_22380_Name2 = {
    Text = "Flüstern in den Schatten V"
  },
  Task_22381_Desc = {
    Text = "Vervollständige 600 Schwarzschild-Hälsen"
  },
  Task_22381_Name = {
    Text = "Verzerrter Horizont V"
  },
  Task_22382_Desc = {
    Text = "Vervollständige 100 Schwarzschild-Hälsen"
  },
  Task_22382_Name = {
    Text = "Verzerrte Sicht II"
  },
  Task_22383_Desc = {
    Text = "Vervollständige 50 Durchläufe von Schwarzschild-Hälsen"
  },
  Task_22383_Name = {
    Text = "Verzerrte Sicht"
  },
  Task_22384_Desc = {
    Text = "Vervollständige 400 Durchläufe von Schwarzschild-Hälsen"
  },
  Task_22384_Name = {
    Text = "Verzerrte Sicht IV"
  },
  Task_22385_Desc = {
    Text = "Vervollständige 200 Schwarzschild-Hälse"
  },
  Task_22385_Name = {
    Text = "Verzerrte Sicht III"
  },
  Task_22387_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"@1@2\""
  },
  Task_22387_Desc2 = {
    Text = "Vollständig Ermittlungen Ereignis \"Sturmauge\""
  },
  Task_22387_Name2 = {
    Text = "Das verlorene Dreieck"
  },
  Task_22388_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 3 Mal Resonanz erzeugt"
  },
  Task_22388_Desc2 = {
    Text = "Im Ermittlungsereignis \"Sturmauge\" 3 Mal Resonanz erreichen"
  },
  Task_22388_Name2 = {
    Text = "Echos der Verzweiflung"
  },
  Task_22389_Desc = {
    Text = "Vollständig Ermittlung Ereignis \"Sturmauge\" im Schwierigkeitsgrad Hart"
  },
  Task_22389_Name = {
    Text = "Verlorenes Dreieck·Hart"
  },
  Task_22390_Desc = {
    Text = "In der Untersuchung Veranstaltung \"@1@2\" 7 Mal resoniert"
  },
  Task_22390_Desc2 = {
    Text = "Im Ermittlungsereignis \"Sturmauge\" 7 Mal Resonanz erreichen"
  },
  Task_22390_Name2 = {
    Text = "Echo der Hoffnungslosigkeit III"
  },
  Task_22391_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 6 Mal Resonanz erzeugt"
  },
  Task_22391_Desc2 = {
    Text = "Im Ermittlungsereignis \"Sturmauge\" 6 Mal Resonanz erreichen"
  },
  Task_22391_Name2 = {
    Text = "Echo der Hoffnungslosigkeit II"
  },
  Task_22392_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 10 Mal Resonanz erzeugt"
  },
  Task_22392_Desc2 = {
    Text = "Resonieren Sie 10 Mal im Untersuchungsereignis \"Storm Eye\""
  },
  Task_22392_Name2 = {
    Text = "Echos der Hoffnungslosigkeit IV"
  },
  Task_23613_Desc = {
    Text = "Finde Gänseblümchen"
  },
  Task_23613_Name = {Text = "Ziel"},
  Task_23614_Desc = {
    Text = "Gehe zum Kaufhaus"
  },
  Task_23614_Name = {Text = "Ziel"},
  Task_23615_Desc = {
    Text = "Schießen abgeschlossen"
  },
  Task_23615_Name = {Text = "Ziel"},
  Task_23616_Desc = {
    Text = "Rückkehr zum Veranstaltungsbereich"
  },
  Task_23616_Name = {Text = "Ziel"},
  Task_23617_Desc = {
    Text = "Beginne Schießen"
  },
  Task_23617_Name = {Text = "Ziel"},
  Task_23618_Desc = {
    Text = "Materialien sammeln"
  },
  Task_23618_Name = {Text = "Ziel"},
  Task_23619_Desc = {
    Text = "Wehre die Feinde ab"
  },
  Task_23619_Name = {Text = "Ziel"},
  Task_23620_Desc = {
    Text = "Das Sanatorium besuchen"
  },
  Task_23620_Name = {Text = "Ziel"},
  Task_23646_Desc = {
    Text = "Sammeln Sie 1000 Erwachungen"
  },
  Task_23708_Desc = {
    Text = "Ziehe in einem Zug während des letzten Kampfes 5 zusätzliche Karten und erhalte 100 Punkte."
  },
  Task_23708_Name = {
    Text = "Ziehe erneut, ziehe erneut <size=20><color=#747474>Ziehe 5 zusätzliche Karten pro Zug während des Endkampfes</color></size>"
  },
  Task_23709_Desc = {
    Text = "5 goldene Relikte erhalten und 100 Punkte verdienen."
  },
  Task_23709_Name = {
    Text = "Strahlendes Gold <size=20><color=#747474>Erhalte 5 Gold Relikte</color></size>"
  },
  Task_23710_Desc = {
    Text = "2 verfluchte Relikte erhalten und 100 Punkte verdienen."
  },
  Task_23710_Name = {
    Text = "Geheime Vorratskammer <size=20><color=#747474>Gewinne 2 verfluchte Relikte</color></size>"
  },
  Task_23711_Desc = {
    Text = "Spiele 7 Karten in einem Zug während des Finalen Kampfes, um 100 Punkte zu erhalten."
  },
  Task_23711_Name = {
    Text = "Mein Zug <size=20><color=#747474>Karte 7 in einer Runde des Finalen Kampfes spielen</color></size>"
  },
  Task_23712_Desc = {
    Text = "Wecke 4 Erwachte und erhalte 100 Punkte."
  },
  Task_23712_Name = {
    Text = "Erwachungsmoment <size=20><color=#747474>Erwecke 4 erweckte Wesen</color></size>"
  },
  Task_23713_Desc = {
    Text = "Gewinne 3 zusätzliche Arithmetica in einer Runde während des Finalen Kampfes und erhalte 100 Punkte."
  },
  Task_23713_Name = {
    Text = "Strategisches Genie <size=20><color=#747474>Gewinne 3 Arithmetica in einer Runde des finalen Kampfes</color></size>"
  },
  Task_23714_Desc = {
    Text = "Im finalen Kampf benutze Exalt mindestens 3 Mal in einem Zug, um 100 Punkte zu erhalten."
  },
  Task_23714_Name = {
    Text = "Fatale Magie <size=20><color=#747474>Verwende Exalt mindestens 3 Mal in einer einzigen Runde während des finalen Kampfes</color></size>"
  },
  Task_23715_Desc = {
    Text = "Gewinne 11 Orisonen und erhalte 100 Punkte."
  },
  Task_23715_Name = {
    Text = "Orison Macht <size=20><color=#747474>11 Orisons erhalten</color></size>"
  },
  Task_23716_Desc = {
    Text = "In einem Zug des finalen Kampfes füge Schaden in Höhe von 50% der maximalen Gesundheit des Bosses zu und erhalte 100 Punkte."
  },
  Task_23716_Name = {
    Text = "Ankunft des Unrats <size=20><color=#747474>Fügen Sie im letzten Kampf in einer Runde mehr als 50 % der maximalen Gesundheit des Bosses Schaden zu</color></size>"
  },
  Task_23717_Desc = {
    Text = "9 verschiedene Orisonen erhalten und 100 Punkte verdienen."
  },
  Task_23717_Name = {
    Text = "Orison Sammlung <size=20><color=#747474>9 verschiedene Orisons erhalten</color></size>"
  },
  Task_23718_Desc = {
    Text = "In einem Zug des finalen Kampfes erhalte einen Schild in Höhe von 80% der maximalen Gesundheit und erhalte 100 Punkte."
  },
  Task_23718_Name = {
    Text = "Stahlkörper <size=20><color=#747474>Erhalte einen Schild, der 80% der maximalen Gesundheit in einer Runde während des Finales entspricht</color></size>"
  },
  Task_23719_Desc = {
    Text = "Habe nicht weniger als 4 Symptomkarten und erziele 100 Punkte bei Abschluss."
  },
  Task_23719_Name = {
    Text = "Terminalerkrankung <size=20><color=#747474>Haben Sie mindestens 4 Symptomkarten bei Abschluss</color></size>"
  },
  Task_23720_Desc = {
    Text = "Im finalen Kampf benutze Exalt in jedem Zug, um 100 Punkte zu gewinnen."
  },
  Task_23720_Name = {
    Text = "Horrorshow <size=20><color=#747474>Finalkampf: verwendet exalt jede Runde</color></size>"
  },
  Task_23721_Desc = {
    Text = "7 Relikte erhalten und 100 Punkte verdienen."
  },
  Task_23721_Name = {
    Text = "Vollständige Ladung <size=20><color=#747474>Erhielte 7 Relikte</color></size>"
  },
  Task_23722_Desc = {
    Text = "Besiege 4 Feinde in einer Runde eines beliebigen Kampfes und verdiene 100 Punkte."
  },
  Task_23722_Name = {
    Text = "Unverzeihlich <size=20><color=#747474>Besiege 4 Feinde in einem einzigen Kampfzug</color></size>"
  },
  Task_23789_Desc = {
    Text = "Logge dich insgesamt 30 Tage lang ein"
  },
  Task_23868_Desc = {
    Text = "Gewinne 5 Traphase Kämpfe"
  },
  Task_23868_Name = {
    Text = "Wöchentliche Belohnungen"
  },
  Task_23869_Desc = {
    Text = "Erreiche den Rang Senior I in der Traphase"
  },
  Task_23873_Desc = {
    Text = "In einem Zug des finalen Kampfes füge Schaden in Höhe von 30% der maximalen Gesundheit des Bosses zu und erhalte 100 Punkte."
  },
  Task_23873_Name = {
    Text = "Ankunft des Unrats <size=20><color=#747474>Fügen Sie im letzten Kampf in einer Runde mehr als 30 % der maximalen Gesundheit des Bosses Schaden zu</color></size>"
  },
  Task_23874_Desc = {
    Text = "5 goldene oder verfluchte Relikte erhalten und 100 Punkte verdienen."
  },
  Task_23874_Name = {
    Text = "Gut und Böse<size=20><color=#747474>Erwerbe 5 Gold- oder verfluchte Relikte, erhalte 100 Punkte</color></size>"
  },
  Task_23875_Desc = {
    Text = "8 verschiedene Orisonen erhalten und 100 Punkte verdienen."
  },
  Task_23875_Name = {
    Text = "Orison Sammlung <size=20><color=#747474>8 verschiedene Orisons sammeln</color></size>"
  },
  Task_23876_Desc = {
    Text = "Gewinne 10 Orisonen und erhalte 100 Punkte."
  },
  Task_23876_Name = {
    Text = "Orison Macht <size=20><color=#747474>10 Orisons erhalten</color></size>"
  },
  Task_23877_Desc = {
    Text = "Im finalen Kampf benutze Exalt mindestens 4 Mal in einem Zug, um 100 Punkte zu erhalten"
  },
  Task_23877_Name = {
    Text = "Fatale Magie <size=20><color=#747474>Verwende Exalt mindestens 4 Mal in einer einzigen Runde während des finalen Kampfes</color></size>"
  },
  Task_23878_Desc = {
    Text = "Besiege 3 Feinde in einer Runde eines beliebigen Kampfes, um 100 Punkte zu verdienen."
  },
  Task_23878_Name = {
    Text = "Unverzeihlich <size=20><color=#747474>Eliminiere 3 Feinde in einem Zug in jedem Kampf</color></size>"
  },
  Task_23879_Desc = {
    Text = "8 Relikte erhalten und 100 Punkte verdienen."
  },
  Task_23879_Name = {
    Text = "Vollständige Ladung <size=20><color=#747474>Erhielte 8 Relikte</color></size>"
  },
  Task_23885_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_23886_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_23887_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_23888_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_23889_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_23890_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_23891_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_23892_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_23893_Desc = {
    Text = "Vollständig \"Blasse Nachkommenschaft\" im Normalmodus während des Wandernden."
  },
  Task_23893_Name = {
    Text = "Abschlussbelohnung"
  },
  Task_23894_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_23895_Desc = {
    Text = "Vollständig Aufgabenaufzeichnung \"Schatten in der regnerischen Stadt\" Normalmodus"
  },
  Task_23895_Name = {
    Text = "Abschlussbelohnung"
  },
  Task_23896_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_24139_Desc = {
    Text = "Trage mindestens 5 Relikte bei Abschluss"
  },
  Task_24139_Name = {
    Text = "Geheimes Versteck"
  },
  Task_24140_Desc = {
    Text = "Spiele mindestens 6 Karten in einem Zug während des Finalen Kampfes"
  },
  Task_24140_Name = {
    Text = "Ich bin dran!"
  },
  Task_24141_Desc = {
    Text = "Trage mindestens 5 Relikte bei Abschluss"
  },
  Task_24141_Name = {
    Text = "Geheimes Versteck"
  },
  Task_24142_Desc = {
    Text = "Spiele mindestens 6 Karten in einem Zug während des Finalen Kampfes"
  },
  Task_24142_Name = {
    Text = "Ich bin dran!"
  },
  Task_24177_Desc = {
    Text = "Flucht aus dem Kraftraum"
  },
  Task_24177_Name = {Text = "Ziel"},
  Task_24403_Desc = {
    Text = "Verfolge die verdächtige Kutsche"
  },
  Task_24403_Name = {Text = "Ziel"},
  Task_24404_Desc = {
    Text = "Vermeide den Blick von \"N\""
  },
  Task_24404_Name = {Text = "Ziel"},
  Task_24405_Desc = {
    Text = "Suche nach „Rose Name“-Einladung"
  },
  Task_24405_Name = {Text = "Ziel"},
  Task_24406_Desc = {
    Text = "Betritt den künstlichen Bereich, kehre zum Tag des Vorfalls zurück."
  },
  Task_24406_Name = {Text = "Ziel"},
  Task_24407_Desc = {
    Text = "Fange den Verdächtigen Mann"
  },
  Task_24407_Name = {Text = "Ziel"},
  Task_24408_Desc = {
    Text = "Hol Maid Karen ein"
  },
  Task_24408_Name = {Text = "Ziel"},
  Task_24409_Desc = {
    Text = "Wehre die Angriffe des geheimnisvollen schwarzen Schattens ab"
  },
  Task_24409_Name = {Text = "Ziel"},
  Task_24410_Desc = {
    Text = "Schütze dich vor dem Angriff der Maskierten Schatten"
  },
  Task_24410_Name = {Text = "Ziel"},
  Task_24411_Desc = {
    Text = "Fange Mr. Lambert"
  },
  Task_24411_Name = {Text = "Ziel"},
  Task_24412_Desc = {
    Text = "Wehre Auflösungsmonster ab"
  },
  Task_24412_Name = {Text = "Ziel"},
  Task_24457_Desc = {
    Text = "Im finalen Kampf benutze Exalt mindestens 3/4 Mal in einem Zug, um 50/100 Punkte zu erhalten."
  },
  Task_24457_Name = {
    Text = "Fatale Magie<size=20><color=#747474>Verwende Exalt mindestens 3 Mal in einer Runde des finalen Kampfes</color></size>"
  },
  Task_24458_Desc = {
    Text = "7/9/11 Orisonen erhalten und 30/60/100 Punkte verdienen."
  },
  Task_24458_Name = {
    Text = "Orison Macht<size=20><color=#747474>7 Orisons erhalten</color></size>"
  },
  Task_24459_Desc = {
    Text = "4/5/6 goldene Relikte erhalten und 30/60/100 Punkte verdienen."
  },
  Task_24459_Name = {
    Text = "Strahlendes Gold<size=20><color=#747474>Erhalte 5 Gold Relikte</color></size>"
  },
  Task_24460_Desc = {
    Text = "4/5/6 goldene Relikte erhalten und 30/60/100 Punkte verdienen."
  },
  Task_24460_Name = {
    Text = "Strahlendes Gold<size=20><color=#747474>Erhalte 4 Gold Relikte</color></size>"
  },
  Task_24461_Desc = {
    Text = "4/5/6 goldene oder verfluchte Relikte erhalten und 30/60/100 Punkte verdienen."
  },
  Task_24461_Name = {
    Text = "Gut und Böse<size=20><color=#747474>Erwerbe 6 Gold- oder verfluchte Relikte</color></size>"
  },
  Task_24462_Desc = {
    Text = "4/5/6 goldene oder verfluchte Relikte erhalten und 30/60/100 Punkte verdienen."
  },
  Task_24462_Name = {
    Text = "Gut und Böse<size=20><color=#747474>Erwerbe 4 Gold- oder verfluchte Relikte</color></size>"
  },
  Task_24463_Desc = {
    Text = "4/5/6 goldene oder verfluchte Relikte erhalten und 30/60/100 Punkte verdienen."
  },
  Task_24463_Name = {
    Text = "Gut und Böse<size=20><color=#747474>Erwerbe 5 Gold- oder verfluchte Relikte</color></size>"
  },
  Task_24464_Desc = {
    Text = "7/9/11 Orisonen erhalten und 30/60/100 Punkte verdienen."
  },
  Task_24464_Name = {
    Text = "Orison Macht<size=20><color=#747474>9 Orisons erwerben</color></size>"
  },
  Task_24465_Desc = {
    Text = "Wecke 3/4 Erwachte, erhalte 50/100 Punkte."
  },
  Task_24465_Name = {
    Text = "Wecke Moment<size=20><color=#747474>Wecke 3 Erwachte</color></size>"
  },
  Task_24466_Desc = {
    Text = "Spiele 5/7/9 Karten in einem Zug während des Finalen Kampfes und erhalte 30/60/100 Punkte."
  },
  Task_24466_Name = {
    Text = "Mein Zug <size=20><color=#747474>Karte 9 in einer Runde des Finalen Kampfes spielen</color></size>"
  },
  Task_24467_Desc = {
    Text = "Wecke 3/4 Erwachte, erhalte 50/100 Punkte."
  },
  Task_24467_Name = {
    Text = "Wecke Moment<size=20><color=#747474>Wecke 4 Erwachte</color></size>"
  },
  Task_24468_Desc = {
    Text = "Im finalen Kampf benutze Exalt mindestens 3/4 Mal in einem Zug, um 50/100 Punkte zu erhalten."
  },
  Task_24468_Name = {
    Text = "Fatale Magie<size=20><color=#747474>Verwende Exalt mindestens 4 Mal in einer Runde des finalen Kampfes</color></size>"
  },
  Task_24469_Desc = {
    Text = "Gewinne 2/3/4 zusätzliche Arithmetica in einer Runde während des Endkampfes und erhalte 30/60/100 Punkte."
  },
  Task_24469_Name = {
    Text = "Strategisches Genie <size=20><color=#747474>Gewinne 2 Arithmetica in einer Runde des finalen Kampfes</color></size>"
  },
  Task_24470_Desc = {
    Text = "Gewinne 2/3/4 zusätzliche Arithmetica in einer Runde während des Endkampfes und erhalte 30/60/100 Punkte."
  },
  Task_24470_Name = {
    Text = "Strategisches Genie <size=20><color=#747474>Gewinne zusätzlich 3 Arithmetica in einem Zug des finalen Kampfes</color></size>"
  },
  Task_24471_Desc = {
    Text = "Habe mindestens 3/4 Symptomkarten und erziele 50/100 Punkte."
  },
  Task_24471_Name = {
    Text = "Terminalerkrankung <size=20><color=#747474>Haben Sie mindestens 3 Symptomkarten bei Abschluss</color></size>"
  },
  Task_24472_Desc = {
    Text = "Habe mindestens 3/4 Symptomkarten und erziele 50/100 Punkte."
  },
  Task_24472_Name = {
    Text = "Terminalerkrankung <size=20><color=#747474>Haben Sie mindestens 4 Symptomkarten beim Abschluss</color></size>"
  },
  Task_24473_Desc = {
    Text = "Gewinne 2/3/4 zusätzliche Arithmetica in einer Runde während des Endkampfes und erhalte 30/60/100 Punkte."
  },
  Task_24473_Name = {
    Text = "Mastermind<size=20><color=#747474>Erhalte 4 Arithmetica pro Zug im letzten Kampf</color></size>"
  },
  Task_24474_Desc = {
    Text = "Habe nicht mehr als 2/1 Karten für einen Erwachten, Punktzahl 50/100."
  },
  Task_24474_Name = {
    Text = "Ignoriert <size=20><color=#747474>Vollständig mit nicht mehr als 2 Karten für alle Erwacher</color></size>"
  },
  Task_24475_Desc = {
    Text = "Im finalen Kampf benutze Exalt für 3/4/5 aufeinanderfolgende Züge, um 30/60/100 Punkte zu gewinnen."
  },
  Task_24475_Name = {
    Text = "Horrorshow <size=20><color=#747474>Finalkampf: verwendet exalt für 5 aufeinanderfolgende Runden</color></size>"
  },
  Task_24476_Desc = {
    Text = "Habe nicht mehr als 2/1 Karten für einen Erwachten, Punktzahl 50/100."
  },
  Task_24476_Name = {
    Text = "Ignoriert <size=20><color=#747474>Vollständig mit nicht mehr als 1 Karte für alle Erwacher</color></size>"
  },
  Task_24477_Desc = {
    Text = "Im finalen Kampf benutze Exalt für 3/4/5 aufeinanderfolgende Züge, um 30/60/100 Punkte zu gewinnen."
  },
  Task_24477_Name = {
    Text = "Horrorshow <size=20><color=#747474>Finalkampf: verwendet exalt für 4 aufeinanderfolgende Runden</color></size>"
  },
  Task_24478_Desc = {
    Text = "6/7/8 Relikte erhalten und 30/60/100 Punkte verdienen."
  },
  Task_24478_Name = {
    Text = "Vollständige Ladung <size=20><color=#747474>Erhielte 7 Relikte</color></size>"
  },
  Task_24479_Desc = {
    Text = "6/7/8 Relikte erhalten und 30/60/100 Punkte verdienen."
  },
  Task_24479_Name = {
    Text = "Vollständige Ladung <size=20><color=#747474>Erhielte 6 Relikte</color></size>"
  },
  Task_24480_Desc = {
    Text = "In einem Zug des finalen Kampfes erhalte einen Schild in Höhe von 25%/50%/75% der maximalen Gesundheit und erhalte 30/60/100 Punkte."
  },
  Task_24480_Name = {
    Text = "Stahlkörper<size=20><color=#747474>Erhalte einen Schild, der 25% der maximalen Gesundheit in einer Runde während des Finales entspricht</color></size>"
  },
  Task_24481_Desc = {
    Text = "In einem Zug des finalen Kampfes füge Schaden in Höhe von 20%/30%/40% der maximalen Gesundheit des Bosses zu und erhalte 30/60/100 Punkte."
  },
  Task_24481_Name = {
    Text = "Ankunft des Unrats <size=20><color=#747474>Fügen Sie im letzten Kampf in einer Runde mehr als 30 % der maximalen Gesundheit des Bosses Schaden zu</color></size>"
  },
  Task_24482_Desc = {
    Text = "6/7/8 Relikte erhalten und 30/60/100 Punkte verdienen."
  },
  Task_24482_Name = {
    Text = "Vollständige Ladung <size=20><color=#747474>Erhielte 8 Relikte</color></size>"
  },
  Task_24483_Desc = {
    Text = "5/7/9 verschiedene Orisonen erhalten und 30/60/100 Punkte verdienen."
  },
  Task_24483_Name = {
    Text = "Orison Sammlung<size=20><color=#747474>9 verschiedene Orisons erhalten</color></size>"
  },
  Task_24484_Desc = {
    Text = "5/7/9 verschiedene Orisonen erhalten und 30/60/100 Punkte verdienen."
  },
  Task_24484_Name = {
    Text = "Orison Sammlung<size=20><color=#747474>5 verschiedene Orisons erhalten</color></size>"
  },
  Task_24485_Desc = {
    Text = "5/7/9 verschiedene Orisonen erhalten und 30/60/100 Punkte verdienen."
  },
  Task_24485_Name = {
    Text = "Orison Sammlung<size=20><color=#747474>7 verschiedene Orisons sammeln</color></size>"
  },
  Task_24486_Desc = {
    Text = "4/5/6 goldene Relikte erhalten und 30/60/100 Punkte verdienen."
  },
  Task_24486_Name = {
    Text = "Strahlendes Gold<size=20><color=#747474>Erhalte 6 Gold Relikte</color></size>"
  },
  Task_24487_Desc = {
    Text = "Im finalen Kampf benutze Exalt für 3/4/5 aufeinanderfolgende Züge, um 30/60/100 Punkte zu gewinnen."
  },
  Task_24487_Name = {
    Text = "Horrorshow <size=20><color=#747474>Finalkampf: verwendet exalt für 3 aufeinanderfolgende Runden</color></size>"
  },
  Task_24488_Desc = {
    Text = "2/3 verfluchte Relikte erhalten und 50/100 Punkte verdienen."
  },
  Task_24488_Name = {
    Text = "Geheimes Versteck<size=20><color=#747474>Erhalte 3 verfluchte Relikte</color></size>"
  },
  Task_24489_Desc = {
    Text = "2/3 verfluchte Relikte erhalten und 50/100 Punkte verdienen."
  },
  Task_24489_Name = {
    Text = "Geheime Vorratskammer<size=20><color=#747474>Gewinne 2 verfluchte Relikte</color></size>"
  },
  Task_24490_Desc = {
    Text = "In einem Zug des finalen Kampfes erhalte einen Schild in Höhe von 25%/50%/75% der maximalen Gesundheit und erhalte 30/60/100 Punkte."
  },
  Task_24490_Name = {
    Text = "Stahlkörper<size=20><color=#747474>Erhalte einen Schild, der 50% der maximalen Gesundheit in einer Runde während des Finales entspricht</color></size>"
  },
  Task_24491_Desc = {
    Text = "Spiele 5/7/9 Karten in einem Zug während des Finalen Kampfes und erhalte 30/60/100 Punkte."
  },
  Task_24491_Name = {
    Text = "Mein Zug <size=20><color=#747474>7 Karten in einer Runde während des Finalen Kampfes spielen</color></size>"
  },
  Task_24492_Desc = {
    Text = "7/9/11 Orisonen erhalten und 30/60/100 Punkte verdienen."
  },
  Task_24492_Name = {
    Text = "Orison Macht<size=20><color=#747474>11 Orisons erhalten</color></size>"
  },
  Task_24493_Desc = {
    Text = "Spiele 5/7/9 Karten in einem Zug während des Finalen Kampfes und erhalte 30/60/100 Punkte."
  },
  Task_24493_Name = {
    Text = "Mein Zug <size=20><color=#747474>Spiele 5 Karten in einer Runde des Finalen Kampfes</color></size>"
  },
  Task_24494_Desc = {
    Text = "In einem Zug des finalen Kampfes füge Schaden in Höhe von 20%/30%/40% der maximalen Gesundheit des Bosses zu und erhalte 30/60/100 Punkte."
  },
  Task_24494_Name = {
    Text = "Ankunft des Unrats <size=20><color=#747474>Fügen Sie im letzten Kampf in einer Runde mehr als 40 % der maximalen Gesundheit des Bosses Schaden zu</color></size>"
  },
  Task_24495_Desc = {
    Text = "In einem Zug des finalen Kampfes erhalte einen Schild in Höhe von 25%/50%/75% der maximalen Gesundheit und erhalte 30/60/100 Punkte."
  },
  Task_24495_Name = {
    Text = "Stahlkörper<size=20><color=#747474>Erhalte einen Schild, der 75% der maximalen Gesundheit in einer Runde während des Finales entspricht</color></size>"
  },
  Task_24496_Desc = {
    Text = "In einem Zug des finalen Kampfes füge Schaden in Höhe von 20%/30%/40% der maximalen Gesundheit des Bosses zu und erhalte 30/60/100 Punkte."
  },
  Task_24496_Name = {
    Text = "Ankunft des Unrats <size=20><color=#747474>Fügen Sie im letzten Kampf in einer Runde mehr als 20 % der maximalen Gesundheit des Bosses Schaden zu</color></size>"
  },
  Task_24497_Desc = {
    Text = "Besiege 3/4 Feinde in einer Runde eines beliebigen Kampfes, um 50/100 Punkte zu verdienen."
  },
  Task_24497_Name = {
    Text = "Unverzeihlich <size=20><color=#747474>Eliminiere 4 Feinde in einem einzigen Kampfzug</color></size>"
  },
  Task_24498_Desc = {
    Text = "Ziehe in einem Zug während des letzten Kampfes 4/5/6 zusätzliche Karten und erhalte 30/60/100 Punkte."
  },
  Task_24498_Name = {
    Text = "Wieder ziehen, Wieder ziehen <size=20><color=#747474>Ziehe 5 zusätzliche Karten in einem Zug während des letzten Kampfes</color></size>"
  },
  Task_24499_Desc = {
    Text = "Ziehe in einem Zug während des letzten Kampfes 4/5/6 zusätzliche Karten und erhalte 30/60/100 Punkte."
  },
  Task_24499_Name = {
    Text = "Ziehe erneut, ziehe erneut <size=20><color=#747474>Ziehe 4 zusätzliche Karten pro Zug während des Endkampfes</color></size>"
  },
  Task_24500_Desc = {
    Text = "Besiege 3/4 Feinde in einer Runde eines beliebigen Kampfes, um 50/100 Punkte zu verdienen."
  },
  Task_24500_Name = {
    Text = "Unverzeihlich <size=20><color=#747474>Besiege 3 Feinde in einem einzigen Kampfzug</color></size>"
  },
  Task_24501_Desc = {
    Text = "Ziehe in einem Zug während des letzten Kampfes 4/5/6 zusätzliche Karten und erhalte 30/60/100 Punkte."
  },
  Task_24501_Name = {
    Text = "Ziehe erneut, ziehe erneut <size=20><color=#747474>Ziehe 6 zusätzliche Karten während der letzten Kampf-Runde</color></size>"
  },
  Task_24534_Desc = {
    Text = "Hol Ramona ein"
  },
  Task_24534_Name = {Text = "Ziel"},
  Task_25013_Desc = {
    Text = "Schließen Sie den speziellen Bericht \"Ode an die Rose\" im normalen Modus ab"
  },
  Task_25013_Name = {
    Text = "Abschlussbelohnung"
  },
  Task_25014_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_25015_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_25016_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_25017_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_25018_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_25019_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_25020_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_25021_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_25022_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_25023_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_25024_Desc = {
    Text = "Vollständig \"Einen Schritt entfernt\" im Normalmodus im Wandern"
  },
  Task_25024_Name = {
    Text = "Abschlussbelohnung"
  },
  Task_25164_Desc = {
    Text = "Folge Ramona"
  },
  Task_25164_Name = {Text = "Ziel"},
  Task_25167_Desc = {
    Text = "Das geheimnisvolle Herrenhaus betreten"
  },
  Task_25167_Name = {Text = "Ziel"},
  Task_25168_Desc = {
    Text = "Rückkehr zur Box von Lady Sorel"
  },
  Task_25168_Name = {Text = "Ziel"},
  Task_34729_Desc = {
    Text = "Skript Geheimnis·Ultra"
  },
  Task_34731_Desc = {
    Text = "Skript Geheimnis·Chaos"
  },
  Task_34734_Desc = {
    Text = "Sondereinsatzdokument"
  },
  Task_34737_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_34740_Desc = {
    Text = "Skript Geheimnis·Aequor"
  },
  Task_34741_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_34742_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_34743_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_34744_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_34745_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_34746_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_34748_Desc = {
    Text = "Skript Geheimnis·Caro"
  },
  Task_34750_Desc = {
    Text = "Wird nach dem Abschluss aller Aufgaben im \"Sonderoperationsprotokoll\" freigeschaltet"
  },
  Task_34942_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Szenario-Rätsel“ insgesamt 25 Schlüsselbefehle verwenden"
  },
  Task_34943_Desc = {
    Text = "Sammeln Sie 50 \"Embryo\"-Karten in \"Script Mystery\"."
  },
  Task_34944_Desc = {
    Text = "Sammeln Sie 10 Ultra-Runden in \"Script Mystery\""
  },
  Task_34945_Desc = {
    Text = "Sammle 250 Tentakelangriffe in \"Drehbuch-Rätsel\""
  },
  Task_34946_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Szenario-Rätsel“ 1 Mal gewinnen"
  },
  Task_34947_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker im “Schriftmysterium“ 1 Mal gewinnen"
  },
  Task_34948_Desc = {
    Text = "Sammle 100 Tentakelangriffe in \"Drehbuch-Rätsel\""
  },
  Task_34949_Desc = {
    Text = "Sammeln Sie 5 Ultra-Runden in \"Script Mystery\""
  },
  Task_34950_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Szenario-Rätsel“ 1 Mal gewinnen"
  },
  Task_34951_Desc = {
    Text = "Sammle 15 \"Embryo\"-Karten in \"Drehbuch-Rätsel\""
  },
  Task_34952_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Schriftmysterium“ insgesamt 10 Schlüsselbefehle verwenden"
  },
  Task_34953_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im \"Szenario-Rätsel\" 1 Mal gewinnen"
  },
  Task_35262_Desc = {
    Text = "Wird nach dem Abschluss aller Bereichen Aufgaben von \"Drehbuch-Mysterium\" freigeschaltet"
  },
  Task_35263_Desc = {
    Text = "Schlusskapitel"
  },
  Task_35808_Desc = {
    Text = "Kumulative Ausgaben von 500 Millionen Goldene Rose"
  },
  Task_35808_Name = {
    Text = "Spendthrift"
  },
  Task_36141_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 6 Mal Resonanz erzeugt"
  },
  Task_36141_Desc2 = {
    Text = "Resonieren Sie 6 Mal im Ermittlungsereignis \"Twisted Stars\""
  },
  Task_36141_Name2 = {
    Text = "Echo der Begierde II"
  },
  Task_36142_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"@1@2\""
  },
  Task_36142_Desc2 = {
    Text = "Vollständig das Ermittlungsereignis \"Verdrehte Sterne\""
  },
  Task_36142_Name2 = {
    Text = "Den Ruf leugnen"
  },
  Task_36143_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 3 Mal Resonanz erzeugt"
  },
  Task_36143_Desc2 = {
    Text = "3 Mal in der Ermittlungsveranstaltung \"Verdrehte Sterne\" resonieren"
  },
  Task_36143_Name2 = {
    Text = "Echos des Verlangens"
  },
  Task_36144_Desc = {
    Text = "Vollständig die Ermittlungsepisode \"Verdrehte Sterne\" auf harter Schwierigkeit"
  },
  Task_36144_Name = {
    Text = "Anruf ablehnen·Hart"
  },
  Task_36145_Desc = {
    Text = "In der Untersuchung Veranstaltung \"@1@2\" 8 Mal resoniert"
  },
  Task_36145_Desc2 = {
    Text = "Resonieren Sie 8 Mal im Ermittlungsereignis \"Twisted Stars\""
  },
  Task_36145_Name2 = {
    Text = "Echo der Begierde III"
  },
  Task_36155_Desc = {
    Text = "Schütze den Kapitän, während er steuert"
  },
  Task_36155_Name = {Text = "Ziel"},
  Task_36156_Desc = {
    Text = "Den Macht-Raum betreten"
  },
  Task_36156_Name = {Text = "Ziel"},
  Task_36157_Desc = {
    Text = "Finde Gefährte"
  },
  Task_36157_Name = {Text = "Ziel"},
  Task_36158_Desc = {
    Text = "Widerstehen Sie dem Angriff des Seefahrers"
  },
  Task_36158_Name = {Text = "Ziel"},
  Task_36159_Desc = {
    Text = "Nähere dich dem \"Heiligen Kind\""
  },
  Task_36159_Name = {Text = "Ziel"},
  Task_36160_Desc = {
    Text = "Angriff Widerstehen"
  },
  Task_36160_Name = {Text = "Ziel"},
  Task_36161_Desc = {
    Text = "Rückkehr zum Cockpit"
  },
  Task_36161_Name = {Text = "Ziel"},
  Task_36162_Desc = {
    Text = "Wehre die Feinde ab"
  },
  Task_36162_Name = {Text = "Ziel"},
  Task_36163_Desc = {
    Text = "Kopf zum Cockpit"
  },
  Task_36163_Name = {Text = "Ziel"},
  Task_36164_Desc = {
    Text = "Gehe zum Kraftraum"
  },
  Task_36164_Name = {Text = "Ziel"},
  Task_36169_Desc = {
    Text = "Gehe zum Platz"
  },
  Task_36169_Name = {Text = "Ziel"},
  Task_36316_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_36316_Name = {
    Text = "Energiesparmodus"
  },
  Task_36317_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_36317_Name = {
    Text = "Energiesparmodus"
  },
  Task_36359_Desc = {
    Text = "Finde 10 Extraktionspunkte im Hauptgeschichten Kapitel 6 \"@1@2\""
  },
  Task_36359_Desc2 = {
    Text = "Finde 10 Extraktionspunkte in Kapitel 6 der Hauptgeschichte, \"Verdrehte Sterne\"."
  },
  Task_36359_Name2 = {
    Text = "Flüstern des Verborgenen VI"
  },
  Task_36622_Desc = {
    Text = "Der Dorfbewohner, der die Mutation kontrolliert"
  },
  Task_36622_Name = {Text = "Ziel"},
  Task_36623_Desc = {
    Text = "Kopf zu Wandas Kammer"
  },
  Task_36623_Name = {Text = "Ziel"},
  Task_36624_Desc = {
    Text = "D-Slime-Monster zurückdrängen"
  },
  Task_36624_Name = {Text = "Ziel"},
  Task_36842_Desc = {
    Text = "Vollständig \"Alles wie gewohnt\" im normalen Modus in Der Wanderer"
  },
  Task_36842_Name = {
    Text = "Abschlussbelohnung"
  },
  Task_36864_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_36872_Desc = {
    Text = "Jede Verwendung der Notfall-Gnosis reduziert die Ermittlungspunktzahl um 30 %."
  },
  Task_36872_Name = {
    Text = "Mentale Überlastung  <size=20><color=#747474>Jede Verwendung von Notfall-Gnosis verringert den Ermittlungspunktestand um 30%.</color></size>"
  },
  Task_38749_Desc = {
    Text = "Erschöpfen Sie 180 Menophin"
  },
  Task_38750_Desc = {
    Text = "Verwende Unterstützung 3 Mal"
  },
  Task_38751_Desc = {
    Text = "Wie deine Alumni 10 Mal"
  },
  Task_38752_Desc = {
    Text = "Schließen Sie die wöchentlichen Prüfungen ab"
  },
  Task_38753_Desc = {
    Text = "Führen Sie 3 Aufträge aus"
  },
  Task_38754_Desc = {
    Text = "Vollständige alle Ausbildungsmissionen"
  },
  Task_38755_Desc = {
    Text = "Erziele 1 Sieg im Phantasmagorischen Tauchgang"
  },
  Task_38814_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker einmal in der “Stadt im See“ gewinnen"
  },
  Task_38815_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker 5-mal in der „Stadt im See“ gewinnen"
  },
  Task_38816_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker dreimal im „Stadt im See“ gewinnen"
  },
  Task_38817_Desc = {
    Text = "Stadt im See·Caro"
  },
  Task_38818_Desc = {
    Text = "Jede Reminiszenz in \"Offenbarung\" beseitigen"
  },
  Task_38819_Desc = {
    Text = "\"A Segment of Memory\" in jeder Erinnerung erfolgreich abschließen"
  },
  Task_38820_Desc = {
    Text = "5-mal mit einem Überdimensionalen Grenzgebiet-Erwecker in der “Stadt im See“ gewinnen"
  },
  Task_38821_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker 3-mal in der „Stadt im See“ gewinnen"
  },
  Task_38822_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker einmal im „Stadt im See“ gewinnen."
  },
  Task_38823_Desc = {
    Text = "Stadt im See·Aequor"
  },
  Task_38824_Desc = {
    Text = "\"Kleine Canna\" in jeder Erinnerung abschließen"
  },
  Task_38825_Desc = {
    Text = "Vollständig eine beliebige Erinnerung an \"Der Brunnen\""
  },
  Task_38826_Desc = {
    Text = "Bewusstseinsdrift"
  },
  Task_38827_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker dreimal im “Stadt im See“ gewinnen"
  },
  Task_38828_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker in der “Stadt im See“ 5 Siege erringen"
  },
  Task_38829_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker einmal in der „Stadt im See“ gewinnen."
  },
  Task_38830_Desc = {
    Text = "Clear jede Reminiszenz in \"Mirage\""
  },
  Task_38831_Desc = {
    Text = "Stadt im See·Chaos"
  },
  Task_38832_Desc = {
    Text = "Vollständig \"Realität\" in jeder Erinnerung"
  },
  Task_38833_Desc = {
    Text = "Stadt im See · Erinnerung"
  },
  Task_38834_Desc = {
    Text = "Vollständig \"Stadt des Goldes\" in jeder Erinnerung"
  },
  Task_38835_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker einmal in der “Stadt im See“ gewinnen"
  },
  Task_38836_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker in der “Stadt im See“ 5-mal gewinnen"
  },
  Task_38837_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker dreimal im „Stadt im See“ gewinnen"
  },
  Task_38838_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_38839_Desc = {
    Text = "City im See·Ultra"
  },
  Task_38840_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_39279_Desc = {
    Text = "Jede Nutzung eines Notfallwissenskörpers senkt die Untersuchungsbewertung um 20%"
  },
  Task_39279_Name = {
    Text = "Mirage Rescue<size=20><color=#747474>Jede Verwendung der Notfall-Gnosis reduziert den Ermittlungspunktestand um 20 %.</color></size>"
  },
  Task_40465_Desc = {
    Text = "Aktiviere den Tod-Widerstand 1/2/3 Mal oder mehr, um 100/300/500 Punkte zu erhalten."
  },
  Task_40465_Name = {
    Text = "Am Rande von Leben und Tod<size=20><color=#747474>Auslöse 1 Widerstand gegen den Tod</color></size>"
  },
  Task_40466_Desc = {
    Text = "Aktiviere den Tod-Widerstand 1/2/3 Mal oder mehr, um 100/300/500 Punkte zu erhalten."
  },
  Task_40466_Name = {
    Text = "Rand des Lebens und des Todes<size=20><color=#747474>Widerstand 3+ Mal auslösen</color></size>"
  },
  Task_40467_Desc = {
    Text = "Aktiviere den Tod-Widerstand 1/2/3 Mal oder mehr, um 100/300/500 Punkte zu erhalten."
  },
  Task_40467_Name = {
    Text = "Rand des Lebens und des Todes<size=20><color=#747474>Auslösungen des Todeswiderstands 2 Mal</color></size>"
  },
  Task_40468_Desc = {
    Text = "Besitzt 5/6/7/8 Schöpfungen, erhalte 250/500/750/1000 Punkte."
  },
  Task_40468_Name = {
    Text = "Realitätssammlung<size=20><color=#747474>Besitzt 5 Schöpfungen</color></size>"
  },
  Task_40469_Desc = {
    Text = "Besitzt 5/6/7/8 Schöpfungen, erhalte 250/500/750/1000 Punkte."
  },
  Task_40469_Name = {
    Text = "Realitätskollektion<size=20><color=#747474>Besitze 7 Relikte</color></size>"
  },
  Task_40470_Desc = {
    Text = "Besitze 5/6/7/8 Schöpfungen, erhalte 250/500/750/1000 Punkte."
  },
  Task_40470_Name = {
    Text = "Realitätskollektion<size=20><color=#747474>Besitze 6 Relikte</color></size>"
  },
  Task_40471_Desc = {
    Text = [[
Finale Schlacht innerhalb von 11/10/9/8 Runden gewinnen, 250/500/750/1000
/1000 Punkte erhalten.]]
  },
  Task_40471_Name = {
    Text = "Schnelle Traumjagd<size=20><color=#747474>Besiege den Boss in 8 Runden</color></size>"
  },
  Task_40472_Desc = {
    Text = [[
Finale Schlacht innerhalb von 11/10/9/8 Runden gewinnen, 250/500/750/1000
/1000 Punkte erhalten.]]
  },
  Task_40472_Name = {
    Text = "Schnelle Traumjagd<size=20><color=#747474>Besiege den Boss in 8 Runden</color></size>"
  },
  Task_40473_Desc = {
    Text = [[
Finale Schlacht innerhalb von 11/10/9/8 Runden gewinnen, 250/500/750/1000
/1000 Punkte erhalten.]]
  },
  Task_40473_Name = {
    Text = "Schnelle Traumverfolgung<size=20><color=#747474>Besiege den Boss in 9 Runden</color></size>"
  },
  Task_40474_Desc = {
    Text = [[
Finale Schlacht innerhalb von 11/10/9/8 Runden gewinnen, 250/500/750/1000
/1000 Punkte erhalten.]]
  },
  Task_40474_Name = {
    Text = "Schneller Traumangriff<size=20><color=#747474>Besiege den Boss in 10 Runden</color></size>"
  },
  Task_40475_Desc = {
    Text = [[
Finale Schlacht in 11/10/9/8 Runden gewinnen, 250/500/750/1000
/1000 Punkte erhalten.]]
  },
  Task_40475_Name = {
    Text = "Stiller Sprint<size=20><color=#747474>Den Boss innerhalb von 11 Runden besiegen</color></size>"
  },
  Task_40476_Desc = {
    Text = "Gewinne die Endschlacht und verdiene 1000 Punkte."
  },
  Task_40476_Name = {
    Text = "Sieg im Finalen Traum Denkmal<size=20><color=#747474>Sieg im Bosskampf</color></size>"
  },
  Task_41334_Desc = {
    Text = "Wehre den Boss{s1} ab"
  },
  Task_41334_Name = {Text = "Ziel"},
  Task_41367_Desc = {
    Text = "Vollständiges Kapitel 3 der \"Ermittlungsoperation\""
  },
  Task_41368_Desc = {
    Text = "Vollständiges Kapitel 5 der \"Ermittlungsoperation\""
  },
  Task_41369_Desc = {
    Text = "Vollständiges Kapitel 4 der \"Ermittlungsoperation\""
  },
  Task_41370_Desc = {
    Text = "Vollständiges Kapitel 2 der \"Ermittlungsoperation\""
  },
  Task_41371_Desc = {
    Text = "Erstes Mal 325 Trainingspunkte erreicht"
  },
  Task_41372_Desc = {
    Text = "Der Sondertrainingswert erreicht erstmals 350"
  },
  Task_41373_Desc = {
    Text = "Der Sondertrainingswert erreicht erstmals 225"
  },
  Task_41374_Desc = {
    Text = "Erstes Mal 300 Trainingspunkte erreicht"
  },
  Task_41375_Desc = {
    Text = "Trainingspunkte erreichen zum ersten Mal 100"
  },
  Task_41376_Desc = {
    Text = "Erstes Mal 150 Trainingspunkte erreicht"
  },
  Task_41377_Desc = {
    Text = "Erste Mal 50 Trainingspunkte erreicht"
  },
  Task_41380_Desc = {
    Text = "Vollständig alle oben genannten Erinnerungsaufgaben"
  },
  Task_43476_Desc = {
    Text = "Hüter erreicht Level 55"
  },
  Task_43476_Name = {
    Text = "Hüter Prüfung IV"
  },
  Task_43477_Desc = {
    Text = "Hüter erreicht Level 45"
  },
  Task_43477_Name = {
    Text = "Hüter Prüfung III"
  },
  Task_43514_Desc = {
    Text = "Wehre Glen und seine Gruppe ab"
  },
  Task_43514_Name = {Text = "Ziel"},
  Task_43561_Desc = {
    Text = "Vollständige Ermittlung Hauptmission Kapitel 6 \"Verdrehte Sterne\""
  },
  Task_43562_Desc = {
    Text = "Vollständige Ermittlung Hauptverlauf Kapitel 5 \"Augen des Sturms\""
  },
  Task_43563_Desc = {
    Text = "Vollständige Ermittlung Hauptverlauf Kapitel 3 \"Achte auf die Hunde\""
  },
  Task_43564_Desc = {
    Text = "Vollständig Ermittlung Hauptmission Kapitel 6 \"Verdrehte Sterne\" im Schwierigkeitsgrad Hart"
  },
  Task_43565_Desc = {
    Text = "Vollständig das Hauptuntersuchungskapitel 4 \"In Stille\" auf harter Schwierigkeit"
  },
  Task_43566_Desc = {
    Text = "Vollständig Ermittlung Hauptgeschichte Kapitel 3 \"Vorsicht vor Hunden\" im Schwierigkeitsgrad Hart"
  },
  Task_43567_Desc = {
    Text = "Vollständig Ermittlung Hauptgeschichte Kapitel 5 \"Sturmauge\" im Schwierigkeitsgrad Hart"
  },
  Task_43568_Desc = {
    Text = "Schließen Sie die Hauptuntersuchung Kapitel 4 \"In Stille\" ab"
  },
  Task_43822_Desc = {
    Text = "Besitze einen Erwachten auf Level 80"
  },
  Task_43822_Name = {
    Text = "„Kraft der Transzendenz\"I"
  },
  Task_43824_Desc = {
    Text = "Einmaliger Schaden erreicht 250000"
  },
  Task_43824_Name = {
    Text = "Der unerträgliche Schmerz des Lebens IV"
  },
  Task_43825_Desc = {
    Text = "Einmaliger Schaden erreicht 500000"
  },
  Task_43825_Name = {
    Text = "Der unerträgliche Schmerz des Lebens V"
  },
  Task_43826_Desc = {
    Text = "Einmaliger Schaden erreicht 50000"
  },
  Task_43826_Name = {
    Text = "Der unerträgliche Schmerz des Lebens II"
  },
  Task_43827_Desc = {
    Text = "Einmaliger Schaden erreicht 100000"
  },
  Task_43827_Name = {
    Text = "Der unerträgliche Schmerz des Lebens III"
  },
  Task_43828_Desc = {
    Text = "Habe 3 Erwachte auf Stufe 80"
  },
  Task_43828_Name = {
    Text = "\"Macht Jenseits\" III"
  },
  Task_43829_Desc = {
    Text = "Habe 2 Erwachte auf Stufe 80"
  },
  Task_43829_Name = {
    Text = "\"Macht Jenseits\" II"
  },
  Task_43831_Desc = {
    Text = "Füge dem Feind 10000 Schichten Gift hinzu"
  },
  Task_43831_Name = {
    Text = "Gift der Realität I"
  },
  Task_43832_Desc = {
    Text = "Vervollständige \"Wunsch des Ritters\" in The Wandering"
  },
  Task_43832_Name = {
    Text = "Tausendundeine Nacht"
  },
  Task_43833_Desc = {
    Text = "Schließe \"Brennendes Bankett\" in Der Wandering ab"
  },
  Task_43833_Name = {
    Text = "Nichts Neues unter dem Mond"
  },
  Task_43834_Desc = {
    Text = "Vollständig den Sonderbericht \"Ode an die Rose\" im Schwierigkeitsgrad Hart abschließen"
  },
  Task_43834_Name = {
    Text = "Rote Rose wird nicht schweigen · Hart"
  },
  Task_43835_Desc = {
    Text = "Vollständig den Sonderbericht \"Magie der Geschichten\" im Schwierigkeitsgrad Hart abschließen"
  },
  Task_43835_Name = {
    Text = "Einfaches Kindheit · Hart"
  },
  Task_43836_Desc = {
    Text = "Schließen Sie den speziellen Bericht \"Magie der Geschichten\" ab"
  },
  Task_43836_Name = {
    Text = "Eine gewöhnliche Kindheit"
  },
  Task_43837_Desc = {
    Text = "Vollständig den Sonderbericht \"Schatten der Reganstadt\" im Schwierigkeitsgrad Hart abschließen"
  },
  Task_43837_Name = {
    Text = "Hexe der Ära · Hart"
  },
  Task_43838_Desc = {
    Text = "Vollständig den Sonderbericht \"Schatten der Reganstadt\" abschließen"
  },
  Task_43838_Name = {
    Text = "Hexe einer Ära"
  },
  Task_43839_Desc = {
    Text = "Schließen Sie den speziellen Bericht \"Ode an die Rose\" ab"
  },
  Task_43839_Name = {
    Text = "Rote Rosen bleiben nie still"
  },
  Task_43840_Desc = {
    Text = "2000 Kämpfe in der Traphase"
  },
  Task_43840_Name = {
    Text = "Phasenüberlappung V"
  },
  Task_43843_Desc = {
    Text = "Ein SSR Rad des Schicksals demontieren"
  },
  Task_43843_Name = {
    Text = "Weltliche Besitztümer"
  },
  Task_43844_Desc = {
    Text = "Rad des Schicksals 700-mal gestapelt"
  },
  Task_43844_Name = {
    Text = "Zukunft der Quantenverschränkung I"
  },
  Task_43845_Desc = {
    Text = "Upgrade Erweckerfähigkeiten 1.000 Mal"
  },
  Task_43845_Name = {
    Text = "„Meister der Waffen\"VIII"
  },
  Task_43846_Desc = {
    Text = "Upgrade Erwecker-Fähigkeit 1100 Mal"
  },
  Task_43846_Name = {
    Text = "„Meister der Waffen\"IX"
  },
  Task_43847_Desc = {
    Text = "Upgrade Erweckerfähigkeiten 1.200 Mal"
  },
  Task_43847_Name = {
    Text = "„Meister der Waffen\"X"
  },
  Task_43849_Desc = {
    Text = "Zerleg 100 Räder des Schicksals"
  },
  Task_43849_Name = {
    Text = "Wertvolle Neugier"
  },
  Task_43850_Desc = {
    Text = "Zerleg 200 Räder des Schicksals"
  },
  Task_43850_Name = {
    Text = "Freude der Zerteilung"
  },
  Task_43851_Desc = {
    Text = "Zerleg 300 Räder des Schicksals"
  },
  Task_43851_Name = {
    Text = "Das Universum in einer Nussschale"
  },
  Task_43863_Desc = {
    Text = "Kämpfe 1000 Mal in Traphase"
  },
  Task_43863_Name = {
    Text = "Phase Überlappung IV"
  },
  Task_43864_Desc = {
    Text = "500 Kämpfe in der Traphase"
  },
  Task_43864_Name = {
    Text = "Phasenüberlappung III"
  },
  Task_43866_Desc = {
    Text = "Vollständig 100 phantasmale Eintauchungen"
  },
  Task_43866_Name = {
    Text = "Flaches Abenteuer"
  },
  Task_43867_Desc = {
    Text = "250 Kämpfe in der Traphase"
  },
  Task_43867_Name = {
    Text = "Phase Überlappung II"
  },
  Task_43868_Desc = {
    Text = "100 Kämpfe in der Traphase"
  },
  Task_43868_Name = {
    Text = "Phase Überlappung I"
  },
  Task_43869_Desc = {
    Text = "Erreiche Affinitätslevel 10 mit 40 Erweckten"
  },
  Task_43869_Name = {
    Text = "Meine kostbaren Flügel"
  },
  Task_43873_Desc = {
    Text = "Rad des Schicksals 600-mal gestapelt"
  },
  Task_43873_Name = {
    Text = "Verflochtenes Schicksal VI"
  },
  Task_43874_Desc = {
    Text = "Rad des Schicksals 500-mal gestapelt"
  },
  Task_43874_Name = {
    Text = "Verflochtenes Schicksal V"
  },
  Task_43875_Desc = {
    Text = "Rad des Schicksals 400-mal gestapelt"
  },
  Task_43875_Name = {
    Text = "Verflochtene Schicksale IV"
  },
  Task_43876_Desc = {
    Text = "Rad des Schicksals 300-mal gestapelt"
  },
  Task_43876_Name = {
    Text = "Verflochtenes Schicksal III"
  },
  Task_43877_Desc = {
    Text = "Rad des Schicksals 200-mal gestapelt"
  },
  Task_43877_Name = {
    Text = "Verflochtenes Schicksal II"
  },
  Task_43878_Desc = {
    Text = "Rad des Schicksals 100-mal gestapelt"
  },
  Task_43878_Name = {
    Text = "Verflochtenes Schicksal I"
  },
  Task_43880_Desc = {
    Text = "Erwecker-Aktivierung: Erleuchte 600 Mal"
  },
  Task_43880_Name = {
    Text = "Ruf aus der Ferne"
  },
  Task_43881_Desc = {
    Text = "Erwecker-Aktivierung: Erleuchte 500 Mal"
  },
  Task_43881_Name = {
    Text = "Fusion von Geist und Fleisch IV"
  },
  Task_43882_Desc = {
    Text = "Erwecker-Aktivierung: Erleuchte 400 Mal"
  },
  Task_43882_Name = {
    Text = "Fusion von Geist und Fleisch III"
  },
  Task_43883_Desc = {
    Text = "Vollständig \"Eine Melodie formen\" in harter Schwierigkeit in Der Wanderer"
  },
  Task_43883_Name = {
    Text = "Alephs Geheimnis·Hart"
  },
  Task_43884_Desc = {
    Text = "Vollständig \"Blut und Sand\" im harten Schwierigkeitsgrad im Wandernden"
  },
  Task_43884_Name = {
    Text = "Märchen des Biests·Hart"
  },
  Task_43885_Desc = {
    Text = "Vollständig \"Einen Schritt entfernt\" in Der Wanderer"
  },
  Task_43885_Name = {
    Text = "Der Botschafter des Kreislaufs"
  },
  Task_43886_Desc = {
    Text = "Schließe \"Alles wie gewohnt\" im Wandern ab"
  },
  Task_43886_Name = {
    Text = "Die unsichtbare Stadt"
  },
  Task_43887_Desc = {
    Text = "Vollständig \"Wunsch des Ritters\" in harter Schwierigkeit in Der Wanderer"
  },
  Task_43887_Name = {
    Text = "Tausendundeine Nacht · Hart"
  },
  Task_43888_Desc = {
    Text = "Schließe \"Brennendes Bankett\" auf Hart-Schwierigkeitsgrad in Der Wandering ab"
  },
  Task_43888_Name = {
    Text = "Nichts Neues unter dem Mond · Hart"
  },
  Task_43889_Desc = {
    Text = "Vollständig \"Lied formen\" im Wandern"
  },
  Task_43889_Name = {
    Text = "Geheimnis von Aleph"
  },
  Task_43890_Desc = {
    Text = "Schließe \"Blut und Sand\" in Der Wandering ab"
  },
  Task_43890_Name = {
    Text = "So sprach das Tier"
  },
  Task_43891_Desc = {
    Text = "Vollständig \"Verdrehter Kern\" im Wandern"
  },
  Task_43891_Name = {
    Text = "Träumen mechanische Puppen?"
  },
  Task_43892_Desc = {
    Text = "Vollständig \"Blasse Nachkommen\" in Der Wanderer"
  },
  Task_43892_Name = {
    Text = "Mein Demian"
  },
  Task_43893_Desc = {
    Text = "Füge dem Feind 25000 Schichten Gift hinzu"
  },
  Task_43893_Name = {
    Text = "Gift der Realität II"
  },
  Task_43896_Desc = {
    Text = "Vollständig \"Einen Schritt entfernt\" in harter Schwierigkeit in Der Wanderer"
  },
  Task_43896_Name = {
    Text = "Kreis-Bote·Hart"
  },
  Task_43897_Desc = {
    Text = "10000 Wachrituale durchführen"
  },
  Task_43897_Name = {
    Text = "Gnosis Sänger"
  },
  Task_43898_Desc = {
    Text = "Vollständig \"Verdrehter Kern\" im harten Schwierigkeitsgrad im Wandernden"
  },
  Task_43898_Name = {
    Text = "Träumen Androiden·Hart"
  },
  Task_43899_Desc = {
    Text = "Kumulative Ausgaben von 100000 das schwarze Siegel"
  },
  Task_43899_Name = {
    Text = "Willkommen zu \"Licht\"IV"
  },
  Task_43900_Desc = {
    Text = "Kumulative Ausgaben von 50000 das schwarze Siegel"
  },
  Task_43900_Name = {
    Text = "Willkommen zu \"Light\" III"
  },
  Task_43901_Desc = {
    Text = "Kumulative Ausgaben von 25000 das schwarze Siegel"
  },
  Task_43901_Name = {
    Text = "Willkommen „Licht\" II"
  },
  Task_43902_Desc = {
    Text = "Kumulative Ausgaben von 10000 das schwarze Siegel"
  },
  Task_43902_Name = {
    Text = "Willkommen \"Licht\" I"
  },
  Task_43903_Desc = {
    Text = "Besitze 100 Level 12 Bündnisse"
  },
  Task_43903_Name = {
    Text = "Tabu Wächter III"
  },
  Task_43904_Desc = {
    Text = "Besitze 150 Bündnisse auf Stufe 12"
  },
  Task_43904_Name = {
    Text = "Tabu Wächter IV"
  },
  Task_43905_Desc = {
    Text = "Besitze 25 Bündnisse auf Stufe 12"
  },
  Task_43905_Name = {
    Text = "Tabu Wächter I"
  },
  Task_43906_Desc = {
    Text = "Besitze 50 Level 12 Bündnisse"
  },
  Task_43906_Name = {
    Text = "Tabu Wächter II"
  },
  Task_43907_Desc = {
    Text = "2500 Wachrituale durchführen"
  },
  Task_43907_Name = {
    Text = "Seelen Sänger II"
  },
  Task_43908_Desc = {
    Text = "5000 Wachrituale durchführen"
  },
  Task_43908_Name = {
    Text = "Seelen Sänger III"
  },
  Task_43909_Desc = {
    Text = "Führe die Erwachungszeremonie 500 Mal durch"
  },
  Task_43909_Name = {
    Text = "Genius Bewahrer V"
  },
  Task_43910_Desc = {
    Text = "1000 Wachrituale durchführen"
  },
  Task_43910_Name = {
    Text = "Seelen Gesang I"
  },
  Task_43911_Desc = {
    Text = "Vollständig \"Blasse Nachkommenschaft\" im harten Schwierigkeitsgrad im Wandernden"
  },
  Task_43911_Name = {
    Text = "Mein Demian – Hart"
  },
  Task_43916_Desc = {
    Text = "Ändere dein Avatar mehr als 3 Mal an einem Tag"
  },
  Task_43916_Name = {
    Text = "Maskierter Maskenball"
  },
  Task_43917_Desc = {
    Text = "Sprich 100 Mal im Wohnheim mit dem Erwacher"
  },
  Task_43917_Name = {
    Text = "Das ist alles für heute"
  },
  Task_43918_Desc = {
    Text = "Vervollständige 250 Bündnis-Transkriptionen"
  },
  Task_43918_Name = {
    Text = "Etwas fühlt sich seltsam an"
  },
  Task_43919_Desc = {
    Text = "Vollständig 100 Bündnis-Transkripte"
  },
  Task_43919_Name = {
    Text = "Endlose Inspiration"
  },
  Task_43921_Desc = {
    Text = "Vervollständige 500 Bündnis-Transkriptionen"
  },
  Task_43921_Name = {
    Text = "Eine weitere Überarbeitung"
  },
  Task_43923_Desc = {
    Text = "Handel 10000 Schaden"
  },
  Task_43923_Name = {
    Text = "Der unerträgliche Schmerz des Lebens I"
  },
  Task_43928_Desc = {
    Text = "Erreiche Affinitätslevel 10 mit 30 Erweckten"
  },
  Task_43928_Name = {
    Text = "Anatomie der 'Liebe'"
  },
  Task_43930_Desc = {
    Text = "Erreiche Affinitätslevel 10 mit 16 Erweckten"
  },
  Task_43930_Name = {
    Text = "Herz-zu-Seele-Gespräch"
  },
  Task_43932_Desc = {
    Text = "Erreiche Affinitätslevel 10 mit 20 Erweckten Körpern"
  },
  Task_43932_Name = {
    Text = "Seelenleser"
  },
  Task_43934_Desc = {
    Text = "Unlock Ramonas Genesis-Form"
  },
  Task_43934_Name = {
    Text = "Neben dem Mädchen"
  },
  Task_43936_Desc = {
    Text = "Erreiche Affinitätslevel 10 mit 12 Erweckten"
  },
  Task_43936_Name = {
    Text = "Die Seele erwecken"
  },
  Task_43937_Desc = {
    Text = "Kumulativer Login: 300 Tage"
  },
  Task_43937_Name = {
    Text = "Ein standhafter Wille"
  },
  Task_43938_Desc = {
    Text = "Kumulativer Login für 365 Tage"
  },
  Task_43938_Name = {
    Text = "Eine sternenklare Nacht"
  },
  Task_43943_Desc = {
    Text = "Kumulative Anmeldung für 120 Tage"
  },
  Task_43943_Name = {
    Text = "Ein gewöhnlicher Morgen"
  },
  Task_43944_Desc = {
    Text = "Kumulative Anmeldung für 150 Tage"
  },
  Task_43944_Name = {
    Text = "Ein schwarzer Kaffee"
  },
  Task_43945_Desc = {
    Text = "Insgesamt für 180 Tage eingeloggt"
  },
  Task_43945_Name = {
    Text = "Ein einfaches Gespräch"
  },
  Task_43946_Desc = {
    Text = "Kumulativer Login für 240 Tage"
  },
  Task_43946_Name = {
    Text = "Ein brennendes Herz"
  },
  Task_43948_Desc = {
    Text = "Erhalte 30 verschiedene Räder des Schicksals"
  },
  Task_43948_Name = {
    Text = "Meister der Ungewissheit"
  },
  Task_43949_Desc = {
    Text = "Erhalte 20 verschiedene Räder des Schicksals"
  },
  Task_43949_Name = {
    Text = "Schüler des Schicksals II"
  },
  Task_43950_Desc = {
    Text = "Erhalte 10 verschiedene Räder des Schicksals"
  },
  Task_43950_Name = {
    Text = "Schicksalsakolyt I"
  },
  Task_43953_Desc = {
    Text = "Erhalte 40 verschiedene Räder des Schicksals"
  },
  Task_43953_Name = {
    Text = "Schicksalsweber"
  },
  Task_43957_Desc = {
    Text = "Verwende Unterstützung einmal"
  },
  Task_43957_Name = {
    Text = "Freunde in Not"
  },
  Task_43958_Desc = {
    Text = "Profilnachricht bearbeiten"
  },
  Task_43958_Name = {
    Text = "Hallo, Welt!"
  },
  Task_43959_Desc = {
    Text = "Erhalte 1000 Likes"
  },
  Task_43959_Name = {
    Text = "Wenn Lob anklopft"
  },
  Task_43961_Desc = {
    Text = "Wie 100 Mal"
  },
  Task_43961_Name = {
    Text = "Kleiner Schritt nach außen"
  },
  Task_43962_Desc = {Text = "Wie 50 Mal"},
  Task_43962_Name = {
    Text = "Bescheidener Versuch"
  },
  Task_43964_Desc = {
    Text = "Folgen Sie 100 herausragenden Alumni"
  },
  Task_43964_Name = {
    Text = "Wenn die Sterne sich ausrichten"
  },
  Task_43965_Desc = {
    Text = "Folgen Sie 1 Alumni"
  },
  Task_43965_Name = {
    Text = "Wie heißt du?"
  },
  Task_43966_Desc = {
    Text = "Insgesamt 500 Tage angemeldet"
  },
  Task_43966_Name = {
    Text = "Die Sonne geht über Kadath auf"
  },
  Task_43967_Desc = {
    Text = "Aktiviere Erwacher Erleuchten 60 Mal"
  },
  Task_43967_Name = {
    Text = "Treffen der Seelen und Herzen V"
  },
  Task_43968_Desc = {
    Text = "Aktiviere Erwacher Erleuchten 100 Mal"
  },
  Task_43968_Name = {
    Text = "Warten im Schatten"
  },
  Task_43969_Desc = {
    Text = "Aktiviere den Erwacher 30 Mal mit Erleuchte"
  },
  Task_43969_Name = {
    Text = "Begegnung von Geist und Herz III"
  },
  Task_43970_Desc = {
    Text = "Erwecker Aktivierung: Erleuchten 45 Mal"
  },
  Task_43970_Name = {
    Text = "Das Treffen von Geist und Herz IV"
  },
  Task_43972_Desc = {
    Text = "Aktiviere den Erwacher 15 Mal mit Erleuchte"
  },
  Task_43972_Name = {
    Text = "Begegnung von Geist und Herz II"
  },
  Task_43973_Desc = {
    Text = "Habe 4 Erwachte auf Stufe 80"
  },
  Task_43973_Name = {
    Text = "\"Macht Jenseits\" IV"
  },
  Task_43975_Desc = {
    Text = "Erwecker-Aktivierung: Erleuchte 200 Mal"
  },
  Task_43975_Name = {
    Text = "Fusion von Geist und Fleisch I"
  },
  Task_43976_Desc = {
    Text = "Erwecker Aktivierung: Erleuchten 300 Mal"
  },
  Task_43976_Name = {
    Text = "Fusion von Geist und Fleisch II"
  },
  Task_44231_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker im Sanktuariumsweg 1 Mal gewinnen"
  },
  Task_44232_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker dreimal auf dem «Sanktuariumsweg» gewinnen"
  },
  Task_44233_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker 2 Mal im “Sanktuariumsweg“ gewinnen"
  },
  Task_44234_Desc = {
    Text = "Schließe \"Wettbewerb\" auf beliebiger Schwierigkeit ab"
  },
  Task_44235_Desc = {
    Text = "Schließe \"Paranoia\" auf beliebiger Schwierigkeit ab"
  },
  Task_44236_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im Sanktuariumsweg 1 Mal gewinnen"
  },
  Task_44237_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Sanktuariumsweg“ dreimal gewinnen"
  },
  Task_44238_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im Sanktuariumsweg zweimal gewinnen"
  },
  Task_44239_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Sanktuariumsweg“ einmal gewinnen"
  },
  Task_44240_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Sanktuariumsweg“ dreimal gewinnen"
  },
  Task_44241_Desc = {
    Text = "Kaufe 150 Mal im \"Big John's Magischer Verkauf\""
  },
  Task_44242_Desc = {
    Text = "Kaufe 200 Mal im \"Big John's Magischer Verkauf\""
  },
  Task_44243_Desc = {
    Text = "Kaufe 100 Mal in \"Big John's Magischer Verkauf\""
  },
  Task_44244_Desc = {
    Text = "Kaufe 200 Mal in \"Frau Grays Laden\""
  },
  Task_44245_Desc = {
    Text = "150 Mal im „Laden der Mrs. Gray“ einkaufen"
  },
  Task_44246_Desc = {
    Text = "Mache 100 Käufe in \"Frau Grays Laden\""
  },
  Task_44247_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Sanktuarium-Weg“ dreimal gewinnen"
  },
  Task_44248_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Sanktuarium-Weg“ 2 Mal gewinnen"
  },
  Task_44249_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Sanktuarium-Weg“ einmal gewinnen"
  },
  Task_44250_Desc = {
    Text = "Jede Schwierigkeit in \"Reue\" beseitigen"
  },
  Task_44251_Desc = {
    Text = "Bazar der Kirche"
  },
  Task_44252_Desc = {
    Text = "\"Kaufe 100 Mal im 'Schmiedeverkauf'\""
  },
  Task_44253_Desc = {
    Text = "\"Kaufe 200 Mal im 'Schmiedeverkauf'\""
  },
  Task_44254_Desc = {
    Text = "\"Kaufe 150 Mal im 'Schmiedeverkauf'\""
  },
  Task_44255_Desc = {
    Text = "Weg der Kirche · Aequor"
  },
  Task_44256_Desc = {
    Text = "Weg der Kirche · Ultra"
  },
  Task_44257_Desc = {
    Text = "Weg der Kirche · Chaos"
  },
  Task_44258_Desc = {
    Text = "Vollständig jede Schwierigkeit von \"Einforderung\""
  },
  Task_44259_Desc = {
    Text = "Unlocks after completing all levels of \"Pfad der Kirche\" on any difficulty"
  },
  Task_44260_Desc = {
    Text = "\"Accusation\" auf jeder Schwierigkeit erfolgreich abschließen"
  },
  Task_44261_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im Sanktuariumsweg zweimal gewinnen"
  },
  Task_44262_Desc = {
    Text = "Weg der Kirche · Caro"
  },
  Task_44263_Desc = {
    Text = "Weg der Kirche · Wachstum"
  },
  Task_44264_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_44567_Desc = {
    Text = "Stoppe Sofia"
  },
  Task_44567_Name = {Text = "Ziel"},
  Task_45665_Desc = {
    Text = "Vollständig \"Der Wandernde: Gefallene der Riesen\" im Normalmodus"
  },
  Task_45665_Name = {
    Text = "Abschlussbelohnung"
  },
  Task_45666_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_46575_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker “Unbewusstes Gedächtnis“ in beliebigem Modus abschließen"
  },
  Task_46576_Desc = {
    Text = "Jede Schwierigkeit von \"Spiegel\" beseitigen"
  },
  Task_46577_Desc = {
    Text = "Schließe “Reptiliengehirn“ mit einem Erwecker des Fleisch-Reichs auf beliebiger Schwierigkeit ab"
  },
  Task_46578_Desc = {
    Text = "Erinnerungscode: Caro"
  },
  Task_46579_Desc = {
    Text = "Clear \"Reptilienhirn\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_46580_Desc = {
    Text = "Mit einem Fleisch-Reich-Erwecker “Unbewusstes Gedächtnis“ in beliebigem Modus abschließen"
  },
  Task_46581_Desc = {
    Text = "Erinnerungscode: Aequor"
  },
  Task_46582_Desc = {
    Text = "Clear \"Unbewusste Erinnerung\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_46583_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker “Vergessenskurve“ in beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_46584_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker das “Spiegel“-Szenario in beliebigem Modus abschließen"
  },
  Task_46585_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker das “Amygdala“-Szenario in beliebiger Schwierigkeit abschließen"
  },
  Task_46586_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker das “Reptiliengehirn“ in beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_46587_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker das “Unbewusste Gedächtnis“ in beliebigem Schwierigkeitsgrad erfolgreich abschließen"
  },
  Task_46588_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker “Spiegel“ in beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_46589_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker “Vergessenskurve“ in beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_46590_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker “Unbewusstes Gedächtnis“ in beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_46591_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker “Reptiliengehirn“ in einem beliebigen Modus erfolgreich abschließen"
  },
  Task_46592_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker das “Amygdala“-Szenario in beliebigem Modus abschließen"
  },
  Task_46593_Desc = {
    Text = "Wird nach dem Abschluss aller Stufen von \"Erinnerungscodierung\" auf beliebigem Schwierigkeitsgrad freigeschaltet."
  },
  Task_46594_Desc = {
    Text = "Jede Schwierigkeit von \"Vergessenheitskurve\" beseitigen"
  },
  Task_46595_Desc = {
    Text = "Erinnerungsencoding·Chaos"
  },
  Task_46596_Desc = {
    Text = "Jede Schwierigkeit von \"Amygdala\" beseitigen"
  },
  Task_46597_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker “Vergessenskurve“ in beliebigem Modus abschließen"
  },
  Task_46598_Desc = {
    Text = "Mit einem überdimensionalen Grenzgebiet-Erwecker das „Spiegel“-Szenario in beliebigem Modus abschließen"
  },
  Task_46599_Desc = {
    Text = "Mit einem Fleisch-Reich-Erwecker die „Vergessenskurve“ in einem beliebigen Modus abschließen"
  },
  Task_46600_Desc = {
    Text = "Mit einem Blutfleisch-Reich Erwecker „Spiegel“ in beliebigem Modus abschließen"
  },
  Task_46601_Desc = {
    Text = "Mit einem Fleisch-Reich-Erwecker “Amygdala“ in beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_46602_Desc = {
    Text = "Erinnerungsencoding·Emerge"
  },
  Task_46603_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker “Amygdala“ in beliebigem Schwierigkeitsgrad abschließen"
  },
  Task_46604_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker “Reptiliengehirn“ in beliebigem Modus abschließen"
  },
  Task_46605_Desc = {
    Text = "Erinnerungscode: Ultra"
  },
  Task_46624_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_46798_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46798_Name = {Text = "200 Punkte"},
  Task_46799_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46799_Name = {Text = "450 Punkte"},
  Task_46806_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46806_Name = {Text = "50 Punkte"},
  Task_46807_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46807_Name = {Text = "100 Punkte"},
  Task_46808_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46808_Name = {Text = "150 Punkte"},
  Task_46809_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46809_Name = {
    Text = "1500 Punkte"
  },
  Task_46810_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46810_Name = {Text = "250 Punkte"},
  Task_46811_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46811_Name = {Text = "300 Punkte"},
  Task_46812_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46812_Name = {Text = "350 Punkte"},
  Task_46821_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_46821_Name = {Text = "6 Siege"},
  Task_46822_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_46822_Name = {Text = "3 Siege"},
  Task_46823_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_46823_Name = {Text = "1 Sieg"},
  Task_46826_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46826_Name = {
    Text = "1450 Punkte"
  },
  Task_46827_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46827_Name = {
    Text = "1400 Punkte"
  },
  Task_46828_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46828_Name = {
    Text = "1350 Punkte"
  },
  Task_46829_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46829_Name = {
    Text = "1300 Punkte"
  },
  Task_46830_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46830_Name = {
    Text = "1250 Punkte"
  },
  Task_46831_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46831_Name = {
    Text = "1200 Punkte"
  },
  Task_46832_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46832_Name = {
    Text = "1150 Punkte"
  },
  Task_46833_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46833_Name = {
    Text = "1100 Punkte"
  },
  Task_46834_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46834_Name = {
    Text = "1050 Punkte"
  },
  Task_46835_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46835_Name = {
    Text = "1000 Punkte"
  },
  Task_46836_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46836_Name = {Text = "600 Punkte"},
  Task_46837_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46837_Name = {Text = "650 Punkte"},
  Task_46838_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46838_Name = {Text = "500 Punkte"},
  Task_46839_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46839_Name = {Text = "550 Punkte"},
  Task_46840_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46840_Name = {Text = "800 Punkte"},
  Task_46841_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46841_Name = {Text = "850 Punkte"},
  Task_46842_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46842_Name = {Text = "700 Punkte"},
  Task_46843_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46843_Name = {Text = "750 Punkte"},
  Task_46844_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46844_Name = {Text = "900 Punkte"},
  Task_46845_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46845_Name = {Text = "950 Punkte"},
  Task_46846_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_46846_Name = {Text = "10 Siege"},
  Task_46847_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_46847_Name = {Text = "400 Punkte"},
  Task_46850_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_46850_Name = {Text = "10 Siege"},
  Task_46852_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_46852_Name = {Text = "3 Siege"},
  Task_46853_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_46853_Name = {Text = "6 Siege"},
  Task_46854_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_46854_Name = {Text = "1 Sieg"},
  Task_47794_Desc = {
    Text = "Vollständig alle Risse im Reich VII im lichtlosen Reich"
  },
  Task_47795_Desc = {
    Text = "Vollständig alle Reich Risse I im Lichtlosen Reich"
  },
  Task_47796_Desc = {
    Text = "Vollständig alle Reich Risse III im Lichtlosen Reich"
  },
  Task_47797_Desc = {
    Text = "Vollständig alle Reich Risse V im Lichtlosen Reich"
  },
  Task_47799_Desc = {
    Text = "Vollständig alle Reich Risse IV im Lichtlosen Reich"
  },
  Task_47800_Desc = {
    Text = "Vollständig alle Reich Risse VI im Lichtlosen Reich"
  },
  Task_47801_Desc = {
    Text = "Vollständig alle Risse im Reich VIII im lichtlosen Reich"
  },
  Task_47802_Desc = {
    Text = "Vollständig alle Reich Risse II im Lichtlosen Reich"
  },
  Task_48166_Desc = {
    Text = "Wehre Rogers und andere ab"
  },
  Task_48166_Name = {Text = "Ziel"},
  Task_48167_Desc = {
    Text = "Besiege Shadow \"24\""
  },
  Task_48167_Name = {Text = "Ziel"},
  Task_48733_CompleteCondDesc = {
    Text = "Gesamtzuweisungsniveau>={s1}"
  },
  Task_48733_Desc = {
    Text = "Aus den Ruinen der zusammengebrochenen Kirche und zerbrochenen Reliquien erhebt das Museum seine Schätze, und du erhebst deine.\nJeder nimmt, was er braucht."
  },
  Task_48733_Name = {
    Text = "Mission: Pantheismus"
  },
  Task_48733_UnlockCondDesc = {
    Text = "Hüter freigeschaltet auf Level 40."
  },
  Task_48734_CompleteCondDesc = {
    Text = "Gesamtzuweisungsniveau>={s1}"
  },
  Task_48734_Desc = {
    Text = [[
Vergiss deine Wahrnehmungen, vergiss deinen Zweck.
Was ist die Wahrheit? Sie werden es dir sagen.]]
  },
  Task_48734_Name = {
    Text = "Mission: a priori"
  },
  Task_48734_UnlockCondDesc = {
    Text = "Hüter freigeschaltet auf Level 30"
  },
  Task_48735_CompleteCondDesc = {
    Text = "Gesamtzuweisungsniveau>={s1}"
  },
  Task_48735_Desc = {
    Text = "Geographie ist eine Lüge, die von den Mächtigen erzählt wird.\nHüten Sie sich vor diesen Höhenlinien."
  },
  Task_48735_Name = {
    Text = "Mission: Recon-Pläne"
  },
  Task_48735_UnlockCondDesc = {
    Text = "Hüter freigeschaltet auf Level 20"
  },
  Task_48736_CompleteCondDesc = {
    Text = "Gesamtzuweisungsniveau>={s1}"
  },
  Task_48736_Desc = {
    Text = "Erhalte zwei unzuverlässige Versprechen und einen unvergesslichen Traum."
  },
  Task_48736_Name = {
    Text = "Mission: Phantomreich"
  },
  Task_48736_UnlockCondDesc = {
    Text = "Hüter freigeschaltet auf Level 50"
  },
  Task_48775_Desc = {
    Text = "Lilys Affinität hat Level 10 erreicht."
  },
  Task_48776_Desc = {
    Text = "Auritas Affinität hat Level 10 erreicht"
  },
  Task_48777_Desc = {
    Text = "Ohnmacht- Affinität erreicht Level 10"
  },
  Task_48778_Desc = {
    Text = "Wandas Affinität hat Level 10 erreicht."
  },
  Task_48779_Desc = {
    Text = "Jenkins Affinität hat Level 10 erreicht."
  },
  Task_48780_Desc = {
    Text = "Ogier Affinitätsstufe 10"
  },
  Task_48781_Desc = {
    Text = "Liz's Affinität erreicht Level 10"
  },
  Task_48782_Desc = {
    Text = "Die Affinität zur Narzisse hat Level 10 erreicht."
  },
  Task_48783_Desc = {
    Text = "Dolls Affinität erreicht Level 10"
  },
  Task_48784_Desc = {
    Text = "Celeste Affinität erreicht Stufe 10"
  },
  Task_48785_Desc = {
    Text = "Aigis hat Affinitätslevel 10 erreicht."
  },
  Task_48786_Desc = {
    Text = "Murphys Affinität hat Stufe 10 erreicht."
  },
  Task_48787_Desc = {
    Text = "Sangas Affinität hat Level 10 erreicht."
  },
  Task_48788_Desc = {
    Text = "Uvhashs Affinität hat Level 10 erreicht."
  },
  Task_48789_Desc = {
    Text = "Nautila Affinität hat Level 10 erreicht"
  },
  Task_48790_Desc = {
    Text = "\"24\" Affinität erreicht Level 10"
  },
  Task_48791_Desc = {
    Text = "Agrippas Affinität hat Stufe 10 erreicht."
  },
  Task_48792_Desc = {
    Text = "Faros Affinitätslevel 10"
  },
  Task_48793_Desc = {
    Text = "Winkles Affinität erreicht Level 10"
  },
  Task_48794_Desc = {
    Text = "Salvadors Affinität hat Level 10 erreicht."
  },
  Task_48795_Desc = {
    Text = "Helot Affinität hat Level 10 erreicht."
  },
  Task_48796_Desc = {
    Text = "Ericas Affinität hat Stufe 10 erreicht."
  },
  Task_48797_Desc = {
    Text = "Ramonas Affinität hat Level 10 erreicht."
  },
  Task_48798_Desc = {
    Text = "Sorels Affinität hat Stufe 10 erreicht."
  },
  Task_48799_Desc = {
    Text = "Thais' Affinität erreicht Level 10"
  },
  Task_48800_Desc = {
    Text = "Goliath's Affinität hat Level 10 erreicht."
  },
  Task_48801_Desc = {
    Text = "Leighs Affinität hat Level 10 erreicht."
  },
  Task_48802_Desc = {
    Text = "Alvas Affinität hat Level 10 erreicht."
  },
  Task_48803_Desc = {
    Text = "Caecus Affinitätslevel 10"
  },
  Task_48804_Desc = {
    Text = "Tulus Affinität erreicht Level 10"
  },
  Task_48805_Desc = {
    Text = "Casiahs Affinität erreicht Level 10"
  },
  Task_48806_Desc = {
    Text = "Karen Affinität hat Stufe 10 erreicht."
  },
  Task_48807_Desc = {
    Text = "Pandias Affinitätslevel hat 10 erreicht."
  },
  Task_48808_Desc = {
    Text = "Tinktur Affinität erreicht Stufe 10"
  },
  Task_48809_Desc = {
    Text = "Nymphaea Affinität hat Level 10 erreicht."
  },
  Task_48810_Desc = {
    Text = "Die Lotan-Affinität hat Level 10 erreicht"
  },
  Task_48829_Desc = {
    Text = "Kumulativer Login: 11 Tage"
  },
  Task_48830_Desc = {
    Text = "14-tägliche kumulierte Anmeldung"
  },
  Task_48831_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_48832_Desc = {
    Text = "Insgesamt 16 Tage eingeloggt"
  },
  Task_48833_Desc = {
    Text = "Kumulativer Login: 12 Tage"
  },
  Task_48834_Desc = {
    Text = "Kumulativer Login: 13 Tage"
  },
  Task_48835_Desc = {
    Text = "Logge dich insgesamt 10 Tage lang ein"
  },
  Task_48836_Desc = {
    Text = "Logge dich an insgesamt 5 aufeinander folgenden Tagen ein"
  },
  Task_48837_Desc = {
    Text = "Kumulativer Login für 6 Tage"
  },
  Task_48838_Desc = {
    Text = "Logge dich insgesamt 7 Tage lang ein"
  },
  Task_48839_Desc = {
    Text = "Logge dich insgesamt 2 Tage lang ein"
  },
  Task_48840_Desc = {
    Text = "Logge dich an insgesamt 3 aufeinander folgenden Tagen ein"
  },
  Task_48841_Desc = {
    Text = "Logge dich insgesamt 8 Tage lang ein"
  },
  Task_48842_Desc = {
    Text = "Insgesamt 9 Tage eingeloggt"
  },
  Task_48843_Desc = {
    Text = "Logge dich insgesamt 15 Tage lang ein"
  },
  Task_48844_Desc = {
    Text = "Logge dich insgesamt 4 Tage lang ein"
  },
  Task_49241_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_49241_Name = {Text = "1 Sieg"},
  Task_49242_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_49242_Name = {Text = "3 Siege"},
  Task_49243_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_49243_Name = {Text = "6 Siege"},
  Task_49244_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_49244_Name = {Text = "10 Siege"},
  Task_49245_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_49245_Name = {Text = "10 Siege"},
  Task_49246_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_49246_Name = {Text = "1 Sieg"},
  Task_49247_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_49247_Name = {Text = "6 Siege"},
  Task_49248_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_49248_Name = {Text = "3 Siege"},
  Task_49262_Desc = {
    Text = "Gewinne die finale Schlacht innerhalb von 30 Zügen"
  },
  Task_49262_Name = {
    Text = "Gewinne die finale Schlacht innerhalb von 30 Zügen"
  },
  Task_49380_Desc = {
    Text = "Clear \"Regeneration Flower\" auf jedem Schwierigkeitsgrad"
  },
  Task_49381_Desc = {
    Text = "Chaotisches Verlangen·Wiederauferstehung"
  },
  Task_49382_Desc = {
    Text = "Vollende alle Erfolge von „chaotisches Verlangen“"
  },
  Task_49383_Desc = {
    Text = "Chaotischer Wunsch·Gereinigt"
  },
  Task_49384_Desc = {
    Text = "Schließe \"Multiple Embryos\" auf beliebiger Schwierigkeit ab"
  },
  Task_49385_Desc = {
    Text = "Schließe \"Gefallene Früchte\" auf beliebiger Schwierigkeitsstufe ab"
  },
  Task_49386_Desc = {
    Text = "Reproduziere 30 Mal in \"Chaotisches Verlangen\""
  },
  Task_49387_Desc = {
    Text = "Vollständig jede Schwierigkeit von \"Nektar-Drüse\""
  },
  Task_49388_Desc = {
    Text = "Reproduziere 10 Mal in \"Chaotisches Verlangen\""
  },
  Task_49389_Desc = {
    Text = "Clear \"Junge Wurzel\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_49390_Desc = {
    Text = "Clear \"Sprouting\" auf jedem Schwierigkeitsgrad"
  },
  Task_49391_Desc = {
    Text = "Reproduziere 20 Mal in \"Chaotisches Verlangen\""
  },
  Task_49392_Desc = {
    Text = "Reproduziere 50 Mal in \"Chaotisches Verlangen\""
  },
  Task_49393_Desc = {
    Text = "Erstelle 40 Mal in \"Chaotischem Verlangen\""
  },
  Task_49394_Desc = {
    Text = "Schließe \"Blüte\" auf beliebiger Schwierigkeitsstufe ab"
  },
  Task_49395_Desc = {
    Text = "Schließe \"Embryo Perle\" auf beliebiger Schwierigkeitsstufe ab"
  },
  Task_49396_Desc = {
    Text = "Jede Schwierigkeit von \"Bestäubung\" beseitigen"
  },
  Task_49397_Desc = {
    Text = "Clear \"Jahresring\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_49769_Desc = {
    Text = "In einem Zug des finalen Kampfes staple einen Schild in Höhe von mindestens 50% der maximalen Gesundheit."
  },
  Task_49769_Name = {Text = "Ironclad"},
  Task_49770_Desc = {
    Text = "Füge in einer Runde während eines Elite-Kampfes mindestens 3000 Schadenspunkte zu."
  },
  Task_49770_Name = {
    Text = "Volltreffer"
  },
  Task_49771_Desc = {
    Text = "Besiege mindestens 2 Monster in einer Runde eines beliebigen Kampfes"
  },
  Task_49771_Name = {
    Text = "Wurzel und Stamm"
  },
  Task_49772_Desc = {
    Text = "Trage mindestens 1 verfluchtes Relikt bei Abschluss."
  },
  Task_49772_Name = {
    Text = "Geheimes Versteck"
  },
  Task_49773_Desc = {
    Text = "Erhalte mindestens 4 verschiedene Arten von Orisons"
  },
  Task_49773_Name = {Text = "Seelenmark"},
  Task_49774_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_49774_Name = {
    Text = "Elegant und präzise"
  },
  Task_49775_Desc = {
    Text = "Spiele mindestens 7 Karten in einem Zug während des Finalen Kampfes"
  },
  Task_49775_Name = {
    Text = "Ich bin dran!"
  },
  Task_49776_Desc = {
    Text = "Wecke alle Erwachten nach Abschluss"
  },
  Task_49776_Name = {
    Text = "Unendliche Umarmung"
  },
  Task_49777_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_49777_Name = {
    Text = "Energiesparmodus"
  },
  Task_49778_Desc = {
    Text = "Besiege mindestens 2 Monster in einer Runde eines beliebigen Kampfes"
  },
  Task_49778_Name = {
    Text = "Wurzel und Stamm"
  },
  Task_49779_Desc = {
    Text = "Trage mindestens 1 verfluchtes Relikt bei Abschluss."
  },
  Task_49779_Name = {
    Text = "Geheimes Versteck"
  },
  Task_49780_Desc = {
    Text = "Erhalte mindestens 4 verschiedene Arten von Orisons"
  },
  Task_49780_Name = {Text = "Seelenmark"},
  Task_49781_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_49781_Name = {
    Text = "Elegant und präzise"
  },
  Task_49782_Desc = {
    Text = "Spiele mindestens 7 Karten in einem Zug während des Finalen Kampfes"
  },
  Task_49782_Name = {
    Text = "Ich bin dran!"
  },
  Task_49783_Desc = {
    Text = "Wecke alle Erwachten nach Abschluss"
  },
  Task_49783_Name = {
    Text = "Unendliche Umarmung"
  },
  Task_49784_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_49784_Name = {
    Text = "Energiesparmodus"
  },
  Task_49785_Desc = {
    Text = "In einem Zug des finalen Kampfes staple einen Schild in Höhe von mindestens 50% der maximalen Gesundheit."
  },
  Task_49785_Name = {Text = "Ironclad"},
  Task_49786_Desc = {
    Text = "Füge in einer Runde während eines Elite-Kampfes mindestens 4500 Schadenspunkte zu."
  },
  Task_49786_Name = {
    Text = "Volltreffer"
  },
  Task_49787_Desc = {
    Text = "In einer Runde im Elite-Kampf mindestens 7300 Schaden verursachen"
  },
  Task_49787_Name = {
    Text = "Volltreffer"
  },
  Task_49788_Desc = {
    Text = "Erhalte mindestens 6 verschiedene Arten von Orisons"
  },
  Task_49788_Name = {Text = "Seelenmark"},
  Task_49789_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_49789_Name = {
    Text = "Elegant und präzise"
  },
  Task_49790_Desc = {
    Text = "Trage mindestens 7 Relikte bei Abschluss"
  },
  Task_49790_Name = {
    Text = "Geheimes Versteck"
  },
  Task_49791_Desc = {
    Text = "Keine Lebenswiederherstellung von der Verbindung nach Abschluss"
  },
  Task_49791_Name = {
    Text = "Die Ungeweckten"
  },
  Task_49792_Desc = {
    Text = "In einer Runde im Elite-Kampf mindestens 9000 Schaden verursachen"
  },
  Task_49792_Name = {
    Text = "Volltreffer"
  },
  Task_49793_Desc = {
    Text = "Erhalte mindestens 6 verschiedene Arten von Orisons"
  },
  Task_49793_Name = {Text = "Seelenmark"},
  Task_49794_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_49794_Name = {
    Text = "Elegant und präzise"
  },
  Task_49795_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_49795_Name = {
    Text = "Schnelle Lösung"
  },
  Task_49796_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_49796_Name = {
    Text = "Schnelle Lösung"
  },
  Task_49797_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_49797_Name = {
    Text = "Schnelle Lösung"
  },
  Task_49798_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_49798_Name = {
    Text = "Schnelle Lösung"
  },
  Task_49799_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_49799_Name = {
    Text = "Schnelle Lösung"
  },
  Task_49800_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_49800_Name = {
    Text = "Schnelle Lösung"
  },
  Task_49801_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_49801_Name = {
    Text = "Schnelle Lösung"
  },
  Task_49802_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_49802_Name = {
    Text = "Schnelle Lösung"
  },
  Task_49803_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_49803_Name = {
    Text = "Schnelle Lösung"
  },
  Task_49804_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_49804_Name = {
    Text = "Perfekter Pass"
  },
  Task_49805_Desc = {
    Text = "Trage mindestens 7 Relikte bei Abschluss"
  },
  Task_49805_Name = {
    Text = "Geheimes Versteck"
  },
  Task_49806_Desc = {
    Text = "Keine Lebenswiederherstellung von der Verbindung nach Abschluss"
  },
  Task_49806_Name = {
    Text = "Die Ungeweckten"
  },
  Task_49807_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_49807_Name = {
    Text = "Perfekter Pass"
  },
  Task_49808_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_49808_Name = {
    Text = "Perfekter Pass"
  },
  Task_49809_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_49809_Name = {
    Text = "Perfekter Pass"
  },
  Task_49810_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_49810_Name = {
    Text = "Perfekter Pass"
  },
  Task_49811_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_49811_Name = {
    Text = "Perfekter Pass"
  },
  Task_49812_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_49812_Name = {
    Text = "Perfekter Pass"
  },
  Task_49813_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_49813_Name = {
    Text = "Perfekter Pass"
  },
  Task_49814_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_49814_Name = {
    Text = "Perfekter Pass"
  },
  Task_49815_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_49815_Name = {
    Text = "Perfekter Pass"
  },
  Task_49816_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_49816_Name = {
    Text = "Perfekter Pass"
  },
  Task_49817_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_49817_Name = {
    Text = "Energiesparmodus"
  },
  Task_49818_Desc = {
    Text = "Töte mindestens 4 Monster in einem einzigen Zug während des Finalen Kampfes."
  },
  Task_49818_Name = {
    Text = "Wurzel und Stamm"
  },
  Task_49819_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_49819_Name = {
    Text = "Energiesparmodus"
  },
  Task_49820_Desc = {
    Text = "Töte mindestens 4 Monster in einem einzigen Zug während des Finalen Kampfes."
  },
  Task_49820_Name = {
    Text = "Wurzel und Stamm"
  },
  Task_49821_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 18 Zügen"
  },
  Task_49821_Name = {
    Text = "Schnelle Lösung"
  },
  Task_49822_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_49822_Name = {
    Text = "Schnelle Lösung"
  },
  Task_49823_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_49823_Name = {
    Text = "Schnelle Lösung"
  },
  Task_49824_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_49824_Name = {
    Text = "Perfekter Pass"
  },
  Task_49852_Desc = {
    Text = "Nubia: Räumt das Bedrohungslager auf"
  },
  Task_49852_Name = {Text = "Ziel"},
  Task_49853_Desc = {
    Text = "Bewege dich durch die Sturmwand"
  },
  Task_49853_Name = {Text = "Ziel"},
  Task_49854_Desc = {
    Text = "Entführe einen Aran-Soldaten, um den Standort des Skeletts zu finden."
  },
  Task_49854_Name = {Text = "Ziel"},
  Task_49855_Desc = {
    Text = "Finde Wasserquelle"
  },
  Task_49855_Name = {Text = "Ziel"},
  Task_49856_Desc = {
    Text = "Besiege Casiah und hole das Skelett zurück."
  },
  Task_49856_Name = {Text = "Ziel"},
  Task_49857_Desc = {
    Text = "Kämpfe an der Seite von Thais"
  },
  Task_49857_Name = {Text = "Ziel"},
  Task_49858_Desc = {
    Text = "Entkomme Casiahs Griff"
  },
  Task_49858_Name = {Text = "Ziel"},
  Task_49859_Desc = {
    Text = "Stoppe das Ritual zur Wiederbelebung des Mutterbaums"
  },
  Task_49859_Name = {Text = "Ziel"},
  Task_49860_Desc = {
    Text = "Tauche ein in das Meer des Bewusstseins des Mutterbaums"
  },
  Task_49860_Name = {Text = "Ziel"},
  Task_49861_Desc = {
    Text = "Hilf den Aram, die Nubier abzuträngen"
  },
  Task_49861_Name = {Text = "Ziel"},
  Task_49862_Desc = {
    Text = "Suche nach dem Skelett des Mutterbaums"
  },
  Task_49862_Name = {Text = "Ziel"},
  Task_49863_Desc = {
    Text = "Besiege den Mutterbaum"
  },
  Task_49863_Name = {Text = "Ziel"},
  Task_49879_Desc = {
    Text = "Ramona: Verwitterte Affinitätsstufe 10 wurde erreicht"
  },
  Task_50033_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 6 Mal Resonanz erzeugt"
  },
  Task_50033_Desc2 = {
    Text = "In der Untersuchung Veranstaltung \"Fluss des Verlangens\" 6 Mal resoniert"
  },
  Task_50033_Name2 = {
    Text = "Echo der Besessenheit II"
  },
  Task_50034_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 9 Mal Resonanz erzeugt"
  },
  Task_50034_Desc2 = {
    Text = "In der Untersuchung \"Fluss des Verlangens\" 9 Mal resoniere"
  },
  Task_50034_Name2 = {
    Text = "Echo der Besessenheit III"
  },
  Task_50035_Desc = {
    Text = "Finde 12 Extraktionspunkte im Hauptgeschichten Kapitel 7 \"@1@2\""
  },
  Task_50035_Desc2 = {
    Text = "Finde 12 Extraktionspunkte im Kapitel 7 \"Fluss des Verlangens\" der Hauptgeschichte."
  },
  Task_50035_Name2 = {
    Text = "Flüstern der Heimlichkeit VII"
  },
  Task_50036_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 3 Mal Resonanz erzeugt"
  },
  Task_50036_Desc2 = {
    Text = "In der Untersuchung Veranstaltung \"Fluss des Verlangens\" 3 Mal resoniert"
  },
  Task_50036_Name2 = {
    Text = "Echos der Täuschung"
  },
  Task_50037_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"@1@2\""
  },
  Task_50037_Desc2 = {
    Text = "Vollständig Ermittlung Ereignis \"Fluss des Verlangens\""
  },
  Task_50037_Name2 = {
    Text = "Wenn der heilige Baum brennt"
  },
  Task_50038_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"Verlangen-Fluss\" auf harter Schwierigkeit"
  },
  Task_50038_Name = {
    Text = "Wenn der Heilige Baum brennt · Hart"
  },
  Task_50039_Desc = {
    Text = "Resonieren Sie 11 Mal im Untersuchungsereignis \"@1@2\""
  },
  Task_50039_Desc2 = {
    Text = "Resonieren Sie 11 Mal im Untersuchungsereignis \"River of Desire\""
  },
  Task_50039_Name2 = {
    Text = "Echo der Besessenheit IV"
  },
  Task_51106_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Szenario-Rätsel“ 2-mal gewinnen"
  },
  Task_51107_Desc = {
    Text = "Alle Aufgaben von „Szenario-Fehlvorstellung: Durchspielen“ abschließen"
  },
  Task_51108_Desc = {
    Text = "Clear \"Plot Twist\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_51109_Desc = {
    Text = "Sondereinsatzdokument"
  },
  Task_51109_Name = {
    Text = "[Verworfen]"
  },
  Task_51110_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Szenario-Rätsel“ einmal gewinnen"
  },
  Task_51111_Desc = {
    Text = "Skript Geheimnis·Reich"
  },
  Task_51112_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Szenario-Rätsel“ 1 Mal gewinnen"
  },
  Task_51113_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker im “Schriftmysterium“ 2-mal gewinnen"
  },
  Task_51114_Desc = {
    Text = "Cleare \"Katharsis\" bei beliebiger Schwierigkeit"
  },
  Task_51115_Desc = {
    Text = "Chaos-Reich-Erwecker im „Schriftmysterium“ 2-mal gewinnen"
  },
  Task_51116_Desc = {
    Text = "Schließe \"Maskierte Komödie\" auf beliebiger Schwierigkeit ab"
  },
  Task_51117_Desc = {
    Text = "Clear \"Trinity\" auf jedem Schwierigkeitsgrad"
  },
  Task_51118_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker im “Schriftmysterium“ 1 Mal gewinnen"
  },
  Task_51119_Desc = {
    Text = "\"Arc Theory\" auf jeder Schwierigkeit erfolgreich abschließen"
  },
  Task_51120_Desc = {
    Text = "Schließe \"Dramatiker-Pyramide\" auf beliebiger Schwierigkeit ab"
  },
  Task_51121_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Schriftmysterium“ einmal gewinnen"
  },
  Task_51122_Desc = {
    Text = "Clear \"Die vierte Wand des Dramas\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_51123_Desc = {
    Text = "Vollständig \"Strangeness Effekt\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_51124_Desc = {
    Text = "Drehbuch-Mysterium·Abschluss"
  },
  Task_51125_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker zweimal im „Schriftmysterium“ gewinnen"
  },
  Task_51126_Desc = {
    Text = "Vollständig \"Ruhiger Moment\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_51140_Desc = {
    Text = "Abschluss von Spezialeinsatzprotokoll „Magie der Geschichte“"
  },
  Task_51141_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_51141_Name = {
    Text = "[Verworfen]"
  },
  Task_51142_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_51142_Name = {
    Text = "[Verworfen]"
  },
  Task_51143_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_51143_Name = {
    Text = "[Verworfen]"
  },
  Task_51144_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_51144_Name = {
    Text = "[Verworfen]"
  },
  Task_51145_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_51145_Name = {
    Text = "[Verworfen]"
  },
  Task_51146_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_51146_Name = {
    Text = "[Verworfen]"
  },
  Task_52280_Desc = {
    Text = "„Erins Altar“ Opfere 100 Opfer für Belohnungen"
  },
  Task_52281_Desc = {
    Text = "„Erins Altar“ Opfere 200 Opfer für Belohnungen"
  },
  Task_52282_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Opfer des Abgrunds“ 2 Mal gewinnen"
  },
  Task_52283_Desc = {
    Text = "Abgrund Opfer: Vollständig"
  },
  Task_52284_Desc = {
    Text = "Vollständig \"Zeuge\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_52285_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Opfer des Abgrunds“ einmal gewinnen"
  },
  Task_52286_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Opfer des Abgrunds“ 2-mal gewinnen"
  },
  Task_52287_Desc = {
    Text = "Vollständig jede Schwierigkeit von \"Überzeugung\""
  },
  Task_52288_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Opfer des Abgrunds“ einmal gewinnen"
  },
  Task_52289_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker einmal im „Opfer des Abgrunds“ gewinnen"
  },
  Task_52290_Desc = {
    Text = "Abgrund Opfer·Reich"
  },
  Task_52291_Desc = {
    Text = "Vollständig \"Entweihung\" in der Traumlandschaft"
  },
  Task_52292_Desc = {
    Text = "\"Blutaltar\" bietet 100 Belohnungen für Opfer"
  },
  Task_52293_Desc = {
    Text = "\"Blutaltar\" Opfergaben opfern, um 200 Belohnungen zu erhalte"
  },
  Task_52294_Desc = {
    Text = "\"Seelenaltar\" Biete 200 Opfer für Belohnungen a"
  },
  Task_52295_Desc = {
    Text = "\"Seelenaltar\" Biete 100 Opfer für Belohnungen a"
  },
  Task_52296_Desc = {
    Text = "Vollständig \"Zweifel\" auf beliebiger Schwierigkeit"
  },
  Task_52297_Desc = {
    Text = "Clear \"Zittern\" auf jedem Schwierigkeitsgrad"
  },
  Task_52298_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Opfer des Abgrunds“ zweimal gewinnen"
  },
  Task_52299_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker im “Opfer des Abgrunds“ 1 Mal gewinnen"
  },
  Task_52300_Desc = {
    Text = "Schließe \"Ankunft\" auf beliebiger Schwierigkeitsstufe ab"
  },
  Task_52301_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker im “Opfer des Abgrunds“ 2 Mal gewinnen"
  },
  Task_52302_Desc = {
    Text = "Antwort des Abgrunds"
  },
  Task_52303_Desc = {
    Text = "Unlocks after completing all tasks of \"Abgrund Opfer · Clearance\" and \"Antwort aus dem Abgrund\""
  },
  Task_53694_Desc = {
    Text = "Raffinierte Aktiv-Ionen erreichen 1000"
  },
  Task_53695_Desc = {
    Text = "Vollständig 20 Aufgaben"
  },
  Task_53696_Desc = {
    Text = "Tag 1 der Schulregistrierung"
  },
  Task_53697_Desc = {
    Text = "Mit einem Chaos-Reich-Erwecker 3 Siege erringen"
  },
  Task_53698_Desc = {
    Text = "Wie 10 andere Personen im Alumni-Verein"
  },
  Task_53699_Desc = {
    Text = "Tag 6 der Rückkehr zur Schulregistrierung"
  },
  Task_53700_Desc = {
    Text = "Tag 5 der Rückkehr zur Schulregistrierung"
  },
  Task_53701_Desc = {Text = "Tag 4"},
  Task_53702_Desc = {Text = "Tag 2"},
  Task_53703_Desc = {Text = "Tag 3"},
  Task_53704_Desc = {Text = "Tag 1"},
  Task_53705_Desc = {
    Text = "Mit einem überdimensionalen Grenzgebiet-Erwecker 3 Siege erringen"
  },
  Task_53706_Desc = {
    Text = "Tag 4 der Rückkehr zur Schulregistrierung"
  },
  Task_53707_Desc = {
    Text = "Erwirke 3 Siege mit einem Fleisch-Reich-Erwecker"
  },
  Task_53708_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker drei Siege erringen"
  },
  Task_53709_Desc = {
    Text = "Tag 2 der Schulregistrierung"
  },
  Task_53710_Desc = {
    Text = "Vollständig eine beliebige Erwecker-Kultivierung"
  },
  Task_53711_Desc = {
    Text = "Sammeln Sie 50.000 Goldene Rosen Tickets"
  },
  Task_53712_Desc = {
    Text = "Verbrauche 1500 Menophin"
  },
  Task_53713_Desc = {
    Text = "Verdiene 500 Raffinierte Aktiv-Ionen"
  },
  Task_53714_Desc = {
    Text = "Sammeln Sie 500.000 Goldene Rosen Tickets"
  },
  Task_53715_Desc = {
    Text = "Führe insgesamt 20 Erwachungszeremonien in einer beliebigen Wach-Aktivität durch"
  },
  Task_53716_Desc = {
    Text = "Vollständig das lichtlose Reich oder Transzendenz einmal."
  },
  Task_53717_Desc = {
    Text = "Unterstütze mit einem Alumni-Erwacher 10 Mal"
  },
  Task_53718_Desc = {
    Text = "Tag 3 der Rückkehr zur Schulregistrierung"
  },
  Task_53719_Desc = {
    Text = "Verwende einen Alumni-Erwecker zur Unterstützung"
  },
  Task_53720_Desc = {
    Text = "Austausch 3 Mal mit Goldcoupon im Laden"
  },
  Task_53721_Desc = {
    Text = "Verbrauche 180 Menophin"
  },
  Task_53722_Desc = {
    Text = "Führen Sie 3 Aufträge aus"
  },
  Task_53723_Desc = {
    Text = "Tag 7 der Rückkehr zur Schulregistrierung"
  },
  Task_53724_Desc = {
    Text = "Verdiene 1000 Minimalistisch Aktiv-Ionen"
  },
  Task_53725_Desc = {
    Text = "Vollständig 1 Erwachen Prüfungsstufe"
  },
  Task_53726_Desc = {
    Text = "Führe 1 Erwachen durch"
  },
  Task_53982_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Rosen-Erinnerung“ einmal gewinnen"
  },
  Task_53983_Desc = {
    Text = "Schließe \"Puppen-Spiel\" auf beliebiger Schwierigkeit ab"
  },
  Task_53984_Desc = {
    Text = "Schließe \"Blick\" auf beliebiger Schwierigkeitsstufe ab"
  },
  Task_53985_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker zweimal im „Rosen-Erinnerung“ gewinnen"
  },
  Task_53986_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker einmal im „Rosen-Erinnerung“ gewinnen"
  },
  Task_53987_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Rosen-Erinnerung“ 2-mal gewinnen"
  },
  Task_53988_Desc = {
    Text = "Rosenerinnerungen·Reich"
  },
  Task_53989_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Rosen-Erinnerung“ einmal gewinnen"
  },
  Task_53990_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Rosen-Erinnerung“ zweimal gewinnen"
  },
  Task_53991_Desc = {
    Text = "Unlocks after completing all tasks of \"Erinnerungen an Rosen · Clearance\""
  },
  Task_53992_Desc = {
    Text = "Clear \"Unvollendetes Skript\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_53993_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker im “Rosen-Erinnerung“ 1 Mal gewinnen"
  },
  Task_53994_Desc = {
    Text = "Vollständig \"Rosenecke\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_53995_Desc = {
    Text = "Rose Erinnerungen·Vollständigung"
  },
  Task_53996_Desc = {
    Text = "2 Mal mit einem Überdimensionales Grenzgebiet-Erwecker im “Rosen-Erinnerung“ gewinnen"
  },
  Task_53997_Desc = {
    Text = "Vollständig \"Onkel Lange Beine\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_53998_Desc = {
    Text = "Vollständig \"Geschenk\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_53999_Desc = {
    Text = "Schließe \"Finale\" auf beliebiger Schwierigkeitsstufe ab"
  },
  Task_54000_Desc = {
    Text = "Schließe \"Fische unter dem Kessel\" auf beliebiger Schwierigkeitsstufe ab"
  },
  Task_54001_Desc = {
    Text = "Schließe \"Gesicht\" auf beliebiger Schwierigkeitsstufe ab"
  },
  Task_54542_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_54542_Name = {Text = "1 Sieg"},
  Task_54543_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_54543_Name = {Text = "6 Siege"},
  Task_54544_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_54544_Name = {Text = "3 Siege"},
  Task_54545_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_54545_Name = {Text = "10 Siege"},
  Task_54546_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_54546_Name = {Text = "1 Sieg"},
  Task_54547_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_54547_Name = {Text = "10 Siege"},
  Task_54548_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_54548_Name = {Text = "10 Siege"},
  Task_54549_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_54549_Name = {Text = "6 Siege"},
  Task_54550_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_54550_Name = {Text = "1 Sieg"},
  Task_54551_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_54551_Name = {Text = "3 Siege"},
  Task_54552_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_54552_Name = {Text = "6 Siege"},
  Task_54553_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_54553_Name = {Text = "3 Siege"},
  Task_54554_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_54554_Name = {Text = "6 Siege"},
  Task_54555_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_54555_Name = {Text = "1 Sieg"},
  Task_54556_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_54556_Name = {Text = "10 Siege"},
  Task_54557_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_54557_Name = {Text = "3 Siege"},
  Task_54585_Desc = {
    Text = "1000 Silber Prime ansammeln"
  },
  Task_54586_Desc = {
    Text = "3000 Silber Prime ansammeln"
  },
  Task_54587_Desc = {
    Text = "6000 Silberne Prime sammeln"
  },
  Task_54588_Desc = {
    Text = "10000 Silber Prime ansammeln"
  },
  Task_54589_Desc = {
    Text = "30000 Silber Prime ansammeln"
  },
  Task_54590_Desc = {
    Text = "60000 Silberne Prime sammeln"
  },
  Task_54591_Desc = {
    Text = "100000 Silber Prime ansammeln"
  },
  Task_55092_Desc = {
    Text = "Vollständig alle Aufgaben in diesem Kapitel, um Belohnungen zu erhalten."
  },
  Task_55092_Name = {
    Text = "Reich Meisterschaft VII"
  },
  Task_55093_Desc = {
    Text = "Vollständig alle Aufgaben in diesem Kapitel, um Belohnungen zu erhalten."
  },
  Task_55093_Name = {
    Text = "Reich Meisterschaft VI"
  },
  Task_55094_Desc = {
    Text = "Erhöhe 3 Caro-Charaktere auf Level 60"
  },
  Task_55094_Name = {
    Text = "Reich Meisterschaft VII"
  },
  Task_55095_Desc = {
    Text = "Erhebe drei Aequor-Charaktere auf Stufe 60."
  },
  Task_55095_Name = {
    Text = "Reich Meisterschaft VII"
  },
  Task_55096_Desc = {
    Text = "Erhöhe 3 Chaos-Charaktere auf Stufe 60"
  },
  Task_55096_Name = {
    Text = "Reich Meisterschaft VII"
  },
  Task_55097_Desc = {
    Text = "Vollständig alle Aufgaben in diesem Kapitel, um Belohnungen zu erhalten."
  },
  Task_55097_Name = {
    Text = "Reich Meisterschaft VIII"
  },
  Task_55098_Desc = {
    Text = "Erhöhe 3 Ultra-Charaktere auf Stufe 60"
  },
  Task_55098_Name = {
    Text = "Reich Meisterschaft VII"
  },
  Task_55099_Desc = {
    Text = "Erhöhe 1 Ultra-Charakter auf Level 60"
  },
  Task_55099_Name = {
    Text = "Reich Meisterschaft VI"
  },
  Task_55100_Desc = {
    Text = "Erhöhe einen Chaos-Charakter auf Level 60"
  },
  Task_55100_Name = {
    Text = "Reich Meisterschaft VI"
  },
  Task_55101_Desc = {
    Text = "Erhöhe einen Aequor-Charakter auf Level 60"
  },
  Task_55101_Name = {
    Text = "Reich Meisterschaft VI"
  },
  Task_55102_Desc = {
    Text = "Erhöhe einen Caro-Charakter auf Level 60."
  },
  Task_55102_Name = {
    Text = "Reich Meisterschaft VI"
  },
  Task_55103_Desc = {
    Text = "Erhebe 6 Ultra-Charaktere auf Stufe 60"
  },
  Task_55103_Name = {
    Text = "Reich Meisterschaft VIII"
  },
  Task_55104_Desc = {
    Text = "Erhöhe sechs Aequor-Charaktere auf Level 60."
  },
  Task_55104_Name = {
    Text = "Reich Meisterschaft VIII"
  },
  Task_55105_Desc = {
    Text = "Erhebe sechs Caro-Charaktere auf Stufe 60."
  },
  Task_55105_Name = {
    Text = "Reich Meisterschaft VIII"
  },
  Task_55106_Desc = {
    Text = "Erhebe sechs Chaos-Charaktere auf Stufe 60"
  },
  Task_55106_Name = {
    Text = "Reich Meisterschaft VIII"
  },
  Task_55177_Desc = {
    Text = "Alle Aufgaben in „Garten der Erinnerungen·Abschluss\" abschließen"
  },
  Task_55178_Desc = {
    Text = "Garten Erinnerungen·Reich"
  },
  Task_55179_Desc = {
    Text = "Kolettes Blumenhaus"
  },
  Task_55180_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Garten der Erinnerungen“ zweimal gewinnen"
  },
  Task_55181_Desc = {
    Text = "Clear \"Königreich in Miniatur\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_55182_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Garten der Erinnerungen“ einmal gewinnen"
  },
  Task_55183_Desc = {
    Text = "Garten Erinnerungen·Vervollständigung"
  },
  Task_55184_Desc = {
    Text = "Vollständig \"Das Gedicht der Blüte\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_55185_Desc = {
    Text = "Im \"Rosengarten\" Gedichte tauschen, um 100 Antworten zu erhalten"
  },
  Task_55186_Desc = {
    Text = "Im \"Rosengarten\" Gedichte tauschen, um 200 Antworten zu erhalten"
  },
  Task_55187_Desc = {
    Text = "\"Ashes\" auf jeder Schwierigkeit erfolgreich abschließen"
  },
  Task_55188_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Garten der Erinnerungen“ 2-mal gewinnen"
  },
  Task_55189_Desc = {
    Text = "Im \"Platycodon Flower Garden\" tauschen Sie Poesie aus, um 200 Antworten zu erhalten"
  },
  Task_55190_Desc = {
    Text = "Im \"Platycodon Flower Garden\" tauschen Sie Gedichte aus, um 100 Antworten zu erhalten"
  },
  Task_55191_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Garten der Erinnerungen“ einmal gewinnen"
  },
  Task_55192_Desc = {
    Text = "Vollständig den speziellen Operationsbericht \"Wohnstätte der Rose\"."
  },
  Task_55193_Desc = {
    Text = "Clear \"Händchenhalten\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_55194_Desc = {
    Text = "Vollständig \"Die erste Rose\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_55195_Desc = {
    Text = "Du kannst 200 Belohnungen erhalten, indem du Poesie im \"Irisgarten\" tauschst."
  },
  Task_55196_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker im “Garten der Erinnerungen“ einmal gewinnen"
  },
  Task_55197_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker im “Garten der Erinnerungen“ 2-mal gewinnen"
  },
  Task_55198_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im „Garten der Erinnerungen“ 2-mal gewinnen"
  },
  Task_55199_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im „Garten der Erinnerungen“ 1 Mal gewinnen"
  },
  Task_55200_Desc = {
    Text = "Erhalte 100 Rückgaben durch den Austausch von Poesie im \"Irisgarten\"."
  },
  Task_55426_Desc = {
    Text = "Besiege Colette"
  },
  Task_55426_Name = {Text = "Ziel"},
  Task_55852_Desc = {
    Text = "Hege 1 Erwachter auf Stufe 70"
  },
  Task_55852_Name = {Text = "Quest 2"},
  Task_55853_Desc = {
    Text = "Vollständige Operation·Normalmodus Kapitel 7"
  },
  Task_55853_Name = {Text = "Quest 3"},
  Task_55854_Desc = {
    Text = "Hege 4 Erwachter auf Stufe 62"
  },
  Task_55854_Name = {Text = "Aufgabe 1"},
  Task_55855_Desc = {
    Text = "Jeder Erwachte erreicht Erleuchtungsstufe 4: Persönlichkeitsvertiefung"
  },
  Task_55855_Name = {Text = "Mission 4"},
  Task_55856_Desc = {
    Text = "Regionaler D-Effekt Trainingslevel erreicht 150"
  },
  Task_55856_Name = {Text = "Quest 5"},
  Task_55857_Desc = {
    Text = "Vollständig alle Aufgaben innerhalb der Phase, um Belohnungen zu erhalten"
  },
  Task_55857_Name = {Text = "Stufe Acht"},
  Task_55858_Desc = {
    Text = "Vollständig alle Aufgaben innerhalb der Phase, um Belohnungen zu erhalten"
  },
  Task_55858_Name = {
    Text = "Stufe Sieben"
  },
  Task_55859_Desc = {
    Text = "Hege 1 Erwachter auf Stufe 62"
  },
  Task_55859_Name = {Text = "Quest 2"},
  Task_55860_Desc = {
    Text = "Vollständige Operation·Normalmodus Kapitel 6"
  },
  Task_55860_Name = {Text = "Quest 3"},
  Task_55861_Desc = {
    Text = "Hege eine beliebige Erwachter Fähigkeit auf Stufe 6"
  },
  Task_55861_Name = {Text = "Aufgabe 1"},
  Task_55862_Desc = {
    Text = "Aktiviere einmal ein Erwacher Geschenk"
  },
  Task_55862_Name = {Text = "Mission 4"},
  Task_55863_Desc = {
    Text = "Regionaler D-Effekt Trainingswert erreicht 50"
  },
  Task_55863_Name = {Text = "Quest 5"},
  Task_56002_Desc = {
    Text = "Vollständig \"Gefallene der Riesen\" in harter Schwierigkeit in Der Wanderer"
  },
  Task_56002_Name = {
    Text = "Unübertroffene Tapferkeit·Hart"
  },
  Task_56003_Desc = {
    Text = "Vollständig \"Alles wie gewohnt\" auf harter Schwierigkeit in Der Wanderer"
  },
  Task_56003_Name = {
    Text = "Unsichtbare Städte·Hart"
  },
  Task_56004_Desc = {
    Text = "Vollständig \"Gefallene der Riesen\" in Der Wanderer"
  },
  Task_56004_Name = {
    Text = "Unvergleichliche Wildheit"
  },
  Task_56005_Desc = {
    Text = "Vollständig den Sonderbericht \"Ruhige Spaltung\" im Schwierigkeitsgrad Hart abschließen"
  },
  Task_56005_Name = {
    Text = "Kehre zur Quelle des Flusses zurück · Hart"
  },
  Task_56006_Desc = {
    Text = "Vollständig den Sonderbericht \"Farbe des Blutes\" im Schwierigkeitsgrad Hart abschließen"
  },
  Task_56006_Name = {
    Text = "Ewige Wohltätigkeit·Hart"
  },
  Task_56007_Desc = {
    Text = "Abschließen Sie den besonderen Aufzeichnung \"Ruhige Spaltung\""
  },
  Task_56007_Name = {
    Text = "Rückkehr zur Quelle des Flusses"
  },
  Task_56008_Desc = {
    Text = "Schließen Sie den speziellen Bericht \"Farbe des Blutes\" ab"
  },
  Task_56008_Name = {
    Text = "Ewige Barmherzigkeit"
  },
  Task_56009_Desc = {
    Text = "Schließen Sie die \"Entweihung\" im Traumland ab"
  },
  Task_56009_Name = {
    Text = "Verdrehter Fanatismus"
  },
  Task_56103_Desc = {
    Text = "Füge dem Feind 50000 Schichten Gift hinzu"
  },
  Task_56103_Name = {
    Text = "Gift der Realität III"
  },
  Task_56104_Desc = {
    Text = "Füge dem Feind 100000 Schichten Gift hinzu"
  },
  Task_56104_Name = {
    Text = "Gift der Realität IV"
  },
  Task_56106_Desc = {
    Text = "Habe 6 Erwachte auf Stufe 80"
  },
  Task_56106_Name = {
    Text = "„Kraft der Transzendenz\"V"
  },
  Task_56107_Desc = {
    Text = "Vollständige die Traumlandschaft „Jenseits des Horizonts: Oben“"
  },
  Task_56107_Name = {Text = "Absturz"},
  Task_56108_Desc = {
    Text = "Vervollständige 200 phantasmatische Tauchgänge"
  },
  Task_56108_Name = {
    Text = "Traumherzreise"
  },
  Task_56109_Desc = {
    Text = "Vervollständige 300 phantasmatische Tauchgänge"
  },
  Task_56109_Name = {
    Text = "Traumwanderer"
  },
  Task_56110_Desc = {
    Text = "Vervollständige 500 phantasmatische Tauchgänge"
  },
  Task_56110_Name = {Text = "Traumweber"},
  Task_56111_Desc = {
    Text = "Habe 8 Erwachte auf Stufe 80"
  },
  Task_56111_Name = {
    Text = "„Kraft der Transzendenz\"VI"
  },
  Task_56112_Desc = {
    Text = "Besitze 10 Level 80 Erwachte"
  },
  Task_56112_Name = {
    Text = "„Kraft der Transzendenz\"VII"
  },
  Task_56113_Desc = {
    Text = "Erreiche Affinitätslevel 10 mit 8 Erweckten"
  },
  Task_56113_Name = {
    Text = "Keine Fremden mehr"
  },
  Task_56115_Desc = {
    Text = "Materialien 11111 Mal synthetisieren"
  },
  Task_56115_Name = {
    Text = "Mythags Rennkessel"
  },
  Task_56116_Desc = {
    Text = "Besitze 200 Bündnisse auf Stufe 12"
  },
  Task_56116_Name = {
    Text = "Tabu Wächter IV"
  },
  Task_56117_Desc = {
    Text = "Erreiche Affinitätslevel 10 mit 4 Erweckten Körpern"
  },
  Task_56117_Name = {
    Text = "Perfektes Duo IX"
  },
  Task_56118_Desc = {
    Text = "Upgrade Erweckerfähigkeiten 400 Mal"
  },
  Task_56118_Name = {
    Text = "\"Meisterschaft aller Waffen\" II"
  },
  Task_56120_Desc = {
    Text = "Habe 30 Erwachte auf Stufe 80"
  },
  Task_56120_Name = {
    Text = "Kriegserklärung gegen Illusion III"
  },
  Task_56121_Desc = {
    Text = "Habe 25 Erwachte auf Stufe 80"
  },
  Task_56121_Name = {
    Text = "Kriegserklärung gegen Illusion II"
  },
  Task_56122_Desc = {
    Text = "Besitze 20 Level 80 Erwachte"
  },
  Task_56122_Name = {
    Text = "Kriegserklärung gegen Illusion I"
  },
  Task_56123_Desc = {
    Text = "Besitze 15 Level 80 Erwachte"
  },
  Task_56123_Name = {
    Text = "„Kraft der Transzendenz\"VIII"
  },
  Task_56126_Desc = {
    Text = "Besitze 40 Level 80 Erwachte"
  },
  Task_56126_Name = {
    Text = "Kriegserklärung gegen Illusion V"
  },
  Task_56127_Desc = {
    Text = "Besitze 35 Level 80 Erwachte"
  },
  Task_56127_Name = {
    Text = "Kriegserklärung gegen Illusion IV"
  },
  Task_56128_Desc = {
    Text = "Kumulative Ausgaben von 250000 das schwarze Siegel"
  },
  Task_56128_Name = {
    Text = "Willkommen \"Licht\" V"
  },
  Task_56129_Desc = {
    Text = "Kumulative Ausgaben von 1000000 das schwarze Siegel"
  },
  Task_56129_Name = {
    Text = "Willkommen \"Licht\" VII"
  },
  Task_56130_Desc = {
    Text = "Kumulative Ausgaben von 500000 das schwarze Siegel"
  },
  Task_56130_Name = {
    Text = "Willkommen \"Licht\" VI"
  },
  Task_56131_Desc = {
    Text = "Upgrade Erweckerfähigkeiten 800 Mal"
  },
  Task_56131_Name = {
    Text = "\"Meister aller Waffen\"VI"
  },
  Task_56132_Desc = {
    Text = "Upgrade Erweckerfähigkeiten 700 Mal"
  },
  Task_56132_Name = {
    Text = "\"Meister aller Waffen\"V"
  },
  Task_56133_Desc = {
    Text = "Upgrade Erweckerfähigkeiten 600 Mal"
  },
  Task_56133_Name = {
    Text = "\"Meisterschaft aller Waffen\" IV"
  },
  Task_56134_Desc = {
    Text = "Upgrade Erweckerfähigkeiten 500 Mal"
  },
  Task_56134_Name = {
    Text = "\"Meisterschaft aller Waffen\" III"
  },
  Task_56135_Desc = {
    Text = "Vollende 5000 Transkriptionen des Bündnisses"
  },
  Task_56135_Name = {
    Text = "Farbenfrohes Schwarz"
  },
  Task_56136_Desc = {
    Text = "Vollende 2500 Transkriptionen des Bündnisses"
  },
  Task_56136_Name = {
    Text = "Launisches Herz"
  },
  Task_56137_Desc = {
    Text = "Vollende 1000 Transkriptionen des Bündnisses"
  },
  Task_56137_Name = {
    Text = "Zurück zur Auswahl"
  },
  Task_56138_Desc = {
    Text = "Upgrade Erweckerfähigkeiten 900 Mal"
  },
  Task_56138_Name = {
    Text = "„Meister der Waffen\"VII"
  },
  Task_56140_Desc = {
    Text = "Vollende 10000 Transkriptionen des Bündnisses"
  },
  Task_56140_Name = {
    Text = "Dämon-Client"
  },
  Task_56156_Desc = {
    Text = "Rad des Schicksals 800-mal gestapelt"
  },
  Task_56156_Name = {
    Text = "Die Zukunft der Quantenverschränkung II"
  },
  Task_56157_Desc = {
    Text = "Rad des Schicksals 900-mal gestapelt"
  },
  Task_56157_Name = {
    Text = "Zukunft der Quantenverschränkung III"
  },
  Task_56161_Desc = {
    Text = "Horlas Affinität erreicht Stufe 10"
  },
  Task_56162_Desc = {
    Text = "Miryams Affinität erreicht Level 10"
  },
  Task_56177_Desc = {
    Text = "Erhalte 80 verschiedene Räder des Schicksals"
  },
  Task_56177_Name = {
    Text = "Schicksalsweber"
  },
  Task_56178_Desc = {
    Text = "Erhalte 70 verschiedene Räder des Schicksals"
  },
  Task_56178_Name = {
    Text = "Meister der Ungewissheit"
  },
  Task_56179_Desc = {
    Text = "Upgrade Erweckerfähigkeiten 300 Mal"
  },
  Task_56179_Name = {
    Text = "\"Meisterschaft aller Waffen\" I"
  },
  Task_56180_Desc = {
    Text = "Rad des Schicksals 1100-mal gestapelt"
  },
  Task_56180_Name = {
    Text = "Die Zukunft der Quantenverschränkung V"
  },
  Task_56181_Desc = {
    Text = "Rad des Schicksals 1200-mal gestapelt"
  },
  Task_56181_Name = {
    Text = "Zukunft der Quantenverschränkung VI"
  },
  Task_56182_Desc = {Text = "1000 Likes"},
  Task_56182_Name = {
    Text = "Sozialer Bandit"
  },
  Task_56184_Desc = {Text = "250 Likes"},
  Task_56184_Name = {
    Text = "Großer Schritt nach vorne"
  },
  Task_56185_Desc = {Text = "500 Likes"},
  Task_56185_Name = {
    Text = "Ein großer Schritt zur Welt"
  },
  Task_56186_Desc = {
    Text = "Zerleg 2000 Räder des Schicksals"
  },
  Task_56186_Name = {
    Text = "Herr des Schicksals"
  },
  Task_56187_Desc = {
    Text = "Zerleg 1000 Räder des Schicksals"
  },
  Task_56187_Name = {
    Text = "Greife das Schicksal am Hals"
  },
  Task_56188_Desc = {
    Text = "Erhalte 60 verschiedene Räder des Schicksals"
  },
  Task_56188_Name = {
    Text = "Schüler des Schicksals II"
  },
  Task_56189_Desc = {
    Text = "Erhalte 50 verschiedene Räder des Schicksals"
  },
  Task_56189_Name = {
    Text = "Schicksalsakolyt I"
  },
  Task_56191_Desc = {
    Text = "Rad des Schicksals 1000-mal gestapelt"
  },
  Task_56191_Name = {
    Text = "Die Zukunft der Quantenverschränkung IV"
  },
  Task_56192_Desc = {
    Text = "Zerleg 500 Räder des Schicksals"
  },
  Task_56192_Name = {
    Text = "Das Schicksal herausfordern"
  },
  Task_56349_Desc = {
    Text = "Besiege den Boss \"Aigis\"."
  },
  Task_56349_Name = {Text = "Ziel"},
  Task_56350_Desc = {
    Text = "Besiege den Boss \"Narzisse\"."
  },
  Task_56350_Name = {Text = "Ziel"},
  Task_56351_Desc = {
    Text = "Besiege den Boss \"Leigh\"."
  },
  Task_56351_Name = {Text = "Ziel"},
  Task_56352_Desc = {
    Text = "Besiege den Boss \"Horla.\""
  },
  Task_56352_Name = {Text = "Ziel"},
  Task_56353_Desc = {
    Text = "Besiege den Boss \"24\"."
  },
  Task_56353_Name = {Text = "Ziel"},
  Task_56412_Desc = {
    Text = "Vervollständige \"Seine Ankunft\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_56413_Desc = {
    Text = "Vervollständige \"Henker\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_56414_Desc = {
    Text = "Dunkelheitsleib · Gereinigt"
  },
  Task_56415_Desc = {
    Text = "Vollständig \"Shroud\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_56416_Desc = {
    Text = "Dunkelheitsleib · Reich"
  },
  Task_56417_Desc = {
    Text = "Vervollständige \"Dormanz\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_56420_Desc = {
    Text = "Clear \"Schlachtlamm\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_56421_Desc = {
    Text = "Clear \"Zeit-Raum-Schlund\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_56422_Desc = {
    Text = "Vollständig \"Gelber Stern\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_57121_Desc = {
    Text = "Clear \"Schlachtlamm\" auf Schwierigkeitsgrad Wahnsi"
  },
  Task_57122_Desc = {
    Text = "Vollständig \"Henker\" auf Wahnsinn-Schwierigkeit"
  },
  Task_57123_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Dunkle Gebärmutter“ 2-mal gewinnen"
  },
  Task_57124_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker 2-mal im “Dunkle Gebärmutter“ gewinnen"
  },
  Task_57125_Desc = {
    Text = "Vollständig \"Seine Ankunft\" auf Wahnsinn-Schwierigkeit"
  },
  Task_57126_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker in der “Dunklen Gebärmutter“ 1 Mal gewinnen"
  },
  Task_57127_Desc = {
    Text = "Die \"Zeit-Raum-Kluft\" auf Wahnsinn-Schwierigkeit beseitigen"
  },
  Task_57128_Desc = {
    Text = "Vollständig \"Gelber Stern\" auf Wahnsinn-Schwierigkeit"
  },
  Task_57129_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Dunkle Gebärmutter“ einmal gewinnen"
  },
  Task_57130_Desc = {
    Text = "Vollständig \"Winterschlaf\" im Wahnsinn-Schwierigkeitsgrad"
  },
  Task_57131_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker zweimal im „Dunkle Gebärmutter“ gewinnen"
  },
  Task_57132_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker einmal in der „Dunklen Gebärmutter“ gewinnen"
  },
  Task_57133_Desc = {
    Text = "Vollständige alle Aufgaben in \"Dunkler Uterus · Klärung\" und \"Dunkler Uterus · Reich\""
  },
  Task_57134_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker 2-mal in der „Dunklen Gebärmutter“ gewinnen"
  },
  Task_57135_Desc = {
    Text = "Vollständig \"Schleier\" im Wahnsinn-Schwierigkeitsgrad"
  },
  Task_57136_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker einmal im „Dunkle Gebärmutter“ gewinnen"
  },
  Task_57137_Desc = {
    Text = "Dunkelheitsleib · Wahnsinn"
  },
  Task_57369_Desc = {
    Text = "Schließe \"Zweigträger\" auf irgendeinem Schwierigkeitsgrad ab"
  },
  Task_57370_Desc = {
    Text = "Mondlicht-Märchen·Wahnsinn"
  },
  Task_57371_Desc = {
    Text = "Vollständig \"Geheimnis des geheimen Raums\" auf beliebiger Schwierigkeit"
  },
  Task_57372_Desc = {
    Text = "Mondlicht-Märchen·Vollendung"
  },
  Task_57373_Desc = {
    Text = "Schließe \"Zweigansammlung\" auf Wahnsinn-Schwierigkeitsgrad ab"
  },
  Task_57374_Desc = {
    Text = "Vollständig \"Kopflose Leiche\" auf beliebiger Schwierigkeit"
  },
  Task_57375_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Mondnächtliche Legenden“ zweimal gewinnen"
  },
  Task_57376_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Mondnächtliche Legenden“ zweimal gewinnen"
  },
  Task_57377_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Mondnächtliche Legenden“ einmal gewinnen"
  },
  Task_57378_Desc = {
    Text = "Clear \"Unerwarteter Besucher\" auf Schwierigkeitsgrad Wahnsi"
  },
  Task_57379_Desc = {
    Text = "Die \"Köpflosen Leiche\" auf Wahnsinn-Schwierigkeit beseitigen"
  },
  Task_57380_Desc = {
    Text = "Unlocks after completing all tasks of \"Mondschein-Geschichten · Clearance\""
  },
  Task_57381_Desc = {
    Text = "Clear \"Raumflucht-Dilemma\" auf Schwierigkeitsgrad Wahnsi"
  },
  Task_57382_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker im “Mondnächtliche Legenden“ einmal gewinnen"
  },
  Task_57383_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker zweimal im „Mondnächtlichen Legenden“-Modus gewinnen"
  },
  Task_57384_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im \"Mondnächtliche Legenden\"-Modus 1x gewinnen"
  },
  Task_57385_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Mondnächtliche Legenden“ zweimal gewinnen"
  },
  Task_57386_Desc = {
    Text = "Vollständig \"Glückliche Bürger\" auf beliebiger Schwierigkeit"
  },
  Task_57387_Desc = {
    Text = "Clear \"Aussage aus Abwesenheit\" auf Schwierigkeitsgrad Wahnsi"
  },
  Task_57388_Desc = {
    Text = "Vollständig \"Freund der Detektive\" auf beliebiger Schwierigkeit"
  },
  Task_57389_Desc = {
    Text = "Vollständig \"Unerwarteter Besucher\" auf beliebiger Schwierigkeit"
  },
  Task_57390_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Mondnächtliche Legenden“ einmal gewinnen"
  },
  Task_57391_Desc = {
    Text = "Mondlicht-Märchen·Reich"
  },
  Task_57392_Desc = {
    Text = "Clear \"Detektivs Freund\" auf Schwierigkeitsgrad Wahnsi"
  },
  Task_57393_Desc = {
    Text = "Schließe \"Abwesendes Alibi\" auf irgendeinem Schwierigkeitsgrad ab"
  },
  Task_57394_Desc = {
    Text = "Clear \"Glücklicher Bürger\" auf Schwierigkeitsgrad Wahnsi"
  },
  Task_57404_Desc = {
    Text = "Vollständig \"Epilog\" auf beliebiger Schwierigkeit"
  },
  Task_57405_Desc = {
    Text = "Vollständig \"Umkehrtrick\" auf beliebiger Schwierigkeit"
  },
  Task_57406_Desc = {
    Text = "Clear \"Epilog\" auf Schwierigkeitsgrad Wahnsi"
  },
  Task_57407_Desc = {
    Text = "Vollständig \"Umkehrtrick\" auf Wahnsinn-Schwierigkeit"
  },
  Task_57409_Desc = {
    Text = "Vollständig Spezialaufzeichnung \"Frohes Jagen!\""
  },
  Task_57570_Desc = {
    Text = "Vollständig \"Umkehrtrick\" auf beliebiger Schwierigkeit"
  },
  Task_57571_Desc = {
    Text = "Vollständig \"Freund der Detektive\" auf beliebiger Schwierigkeit"
  },
  Task_57572_Desc = {
    Text = "Vollständig \"Kopflose Leiche\" auf beliebiger Schwierigkeit"
  },
  Task_57573_Desc = {
    Text = "Clear \"Schlachtlamm\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_57574_Desc = {
    Text = "Schließe \"Abwesendes Alibi\" auf irgendeinem Schwierigkeitsgrad ab"
  },
  Task_57575_Desc = {
    Text = "Vollständig \"Gelber Stern\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_57576_Desc = {
    Text = "Vervollständige \"Seine Ankunft\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_57577_Desc = {
    Text = "Vervollständige \"Henker\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_57578_Desc = {
    Text = "Vollständig \"Epilog\" auf beliebiger Schwierigkeit"
  },
  Task_57579_Desc = {
    Text = "Vollständig \"Shroud\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_57580_Desc = {
    Text = "Vollständig \"Unerwarteter Besucher\" auf beliebiger Schwierigkeit"
  },
  Task_57581_Desc = {
    Text = "Vervollständige \"Dormanz\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_57582_Desc = {
    Text = "Clear \"Zeit-Raum-Schlund\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_57583_Desc = {
    Text = "Schließe \"Zweigträger\" auf irgendeinem Schwierigkeitsgrad ab"
  },
  Task_57584_Desc = {
    Text = "Vollständig \"Glückliche Bürger\" auf beliebiger Schwierigkeit"
  },
  Task_57585_Desc = {
    Text = "Vollständig \"Geheimnis des geheimen Raums\" auf beliebiger Schwierigkeit"
  },
  Task_58104_Desc = {
    Text = "Jede Schwierigkeit in \"Reue\" beseitigen"
  },
  Task_58107_Desc = {
    Text = "\"Accusation\" auf jeder Schwierigkeit erfolgreich abschließen"
  },
  Task_58109_Desc = {
    Text = "Schließe \"Paranoia\" auf Wahnsinn-Schwierigkeit ab"
  },
  Task_58110_Desc = {
    Text = "Schließe \"Wettbewerb\" auf beliebiger Schwierigkeit ab"
  },
  Task_58111_Desc = {
    Text = "Schließe \"Wettbewerb\" auf beliebiger Schwierigkeit ab"
  },
  Task_58112_Desc = {
    Text = "Jede Schwierigkeit in \"Reue\" beseitigen"
  },
  Task_58113_Desc = {
    Text = "Schließe \"Paranoia\" auf beliebiger Schwierigkeit ab"
  },
  Task_58114_Desc = {
    Text = "Clear \"Beichte\" auf Schwierigkeitsgrad Wahnsi"
  },
  Task_58115_Desc = {
    Text = "Vollständig jede Schwierigkeit von \"Einforderung\""
  },
  Task_58118_Desc = {
    Text = "\"Accusation\" auf Wahnsinns-Schwierigkeit erfolgreich abschließen"
  },
  Task_58119_Desc = {
    Text = "Vollständig \"Anspruch\" im Wahnsinn-Schwierigkeitsgrad"
  },
  Task_58120_Desc = {
    Text = "Unlocks after completing all levels of \"Pfad der Kirche\" on any difficulty"
  },
  Task_58122_Desc = {
    Text = "\"Accusation\" auf jeder Schwierigkeit erfolgreich abschließen"
  },
  Task_58123_Desc = {
    Text = "Bazar der Kirche"
  },
  Task_58124_Desc = {
    Text = "Schließe \"Paranoia\" auf beliebiger Schwierigkeit ab"
  },
  Task_58126_Desc = {
    Text = "Vollständig jede Schwierigkeit von \"Einforderung\""
  },
  Task_58128_Desc = {
    Text = "Weg der Kirche · Wahnsinn"
  },
  Task_58130_Desc = {
    Text = "Weg der Kirche · Wachstum"
  },
  Task_58131_Desc = {
    Text = "Schließe \"Wettbewerb\" auf Wahnsinn-Schwierigkeit ab"
  },
  Task_58132_Desc = {
    Text = "Kaufe 100 Mal in \"Big John's Magischer Verkauf\""
  },
  Task_58133_Desc = {
    Text = "Kaufe 200 Mal im \"Big John's Magischer Verkauf\""
  },
  Task_58134_Desc = {
    Text = "Mache 100 Käufe in \"Frau Grays Laden\""
  },
  Task_58135_Desc = {
    Text = "Kaufe 200 Mal in \"Frau Grays Laden\""
  },
  Task_58136_Desc = {
    Text = "\"Kaufe 200 Mal im 'Schmiedeverkauf'\""
  },
  Task_58137_Desc = {
    Text = "\"Kaufe 100 Mal im 'Schmiedeverkauf'\""
  },
  Task_58138_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"{s1}\""
  },
  Task_58500_Desc = {
    Text = "Brüllender Klang·Vollständig"
  },
  Task_58501_Desc = {
    Text = "Vollständig \"Orchestrierung\" im Wahnsinn-Schwierigkeitsgrad"
  },
  Task_58502_Desc = {
    Text = "Clear \"Prelude\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_58503_Desc = {
    Text = "Schließe \"Kleiner Walzer\" auf beliebiger Schwierigkeit ab"
  },
  Task_58504_Desc = {
    Text = "Schließe \"Echo\" auf beliebiger Schwierigkeit ab"
  },
  Task_58505_Desc = {
    Text = "Schließe \"Finale\" auf beliebiger Schwierigkeitsstufe ab"
  },
  Task_58506_Desc = {
    Text = "Clear \"Largo\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_58507_Desc = {
    Text = "Den \"Allegretto\" auf Wahnsinn-Schwierigkeit beseitigen"
  },
  Task_58508_Desc = {
    Text = "Clear \"Menuett\" auf Schwierigkeitsgrad Wahnsi"
  },
  Task_58509_Desc = {
    Text = "Schließe \"Echo\" auf beliebiger Schwierigkeit ab"
  },
  Task_58510_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Donnernder Klang“ einmal gewinnen"
  },
  Task_58511_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Donnernder Klang“ zweimal gewinnen"
  },
  Task_58512_Desc = {
    Text = "Vollständig \"Der verlorene Traumführer\" in jedem Schwierigkeitsgrad"
  },
  Task_58513_Desc = {
    Text = "Brüllendes Geräusch·Reich"
  },
  Task_58514_Desc = {
    Text = "Schließe \"Echo\" auf Wahnsinn-Schwierigkeit ab"
  },
  Task_58515_Desc = {
    Text = "Schließe \"Kleiner Walzer\" auf beliebiger Schwierigkeit ab"
  },
  Task_58516_Desc = {
    Text = "Brüllender Klang·Wahnsinn"
  },
  Task_58517_Desc = {
    Text = "\"Allegretto\" auf jeder Schwierigkeit erfolgreich abschließen"
  },
  Task_58518_Desc = {
    Text = "Clear \"Prelude\" auf Schwierigkeitsgrad Wahnsi"
  },
  Task_58519_Desc = {
    Text = "Vollständig \"Orchestrierung\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_58520_Desc = {
    Text = "„Largo“ auf Schwierigkeitsgrad Wahnsinn abschließen"
  },
  Task_58521_Desc = {
    Text = "Clear \"Largo\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_58522_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Donnernde Klänge“ zweimal gewinnen"
  },
  Task_58523_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im „Donnernden Klang“ einmal gewinnen"
  },
  Task_58524_Desc = {
    Text = "Clear \"Vorhang Fall\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_58525_Desc = {
    Text = "Vollständig \"Finale\" auf Wahnsinn-Schwierigkeit"
  },
  Task_58526_Desc = {
    Text = "Vollständig \"Irreführender Traum\" im Wahnsinn-Schwierigkeitsgrad"
  },
  Task_58527_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker im “Donnernder Klang“ 2 Mal gewinnen"
  },
  Task_58528_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker im “Donnernder Klang“ 1 Mal gewinnen"
  },
  Task_58529_Desc = {
    Text = "\"Allegretto\" auf jeder Schwierigkeit erfolgreich abschließen"
  },
  Task_58530_Desc = {
    Text = "Vollständig alle Aufgaben in \"Tosender Klang·Klar\""
  },
  Task_58531_Desc = {
    Text = "Clear \"Prelude\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_58532_Desc = {
    Text = "Clear \"Vorhang Fall\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_58533_Desc = {
    Text = "Vollständig \"Orchestrierung\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_58534_Desc = {
    Text = "Vollständig \"Der verlorene Traumführer\" in jedem Schwierigkeitsgrad"
  },
  Task_58535_Desc = {
    Text = "Schließe \"Finale\" auf beliebiger Schwierigkeitsstufe ab"
  },
  Task_58536_Desc = {
    Text = "Clear \"Vorhang Fall\" auf Schwierigkeitsgrad Wahnsi"
  },
  Task_58537_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Donnernder Klang“ einmal gewinnen"
  },
  Task_58538_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Donnernden Klang“ 2-mal gewinnen"
  },
  Task_58989_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_58989_Name = {
    Text = "Schnelle Lösung"
  },
  Task_58990_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_58990_Name = {
    Text = "Schnelle Lösung"
  },
  Task_58991_Desc = {
    Text = "Ziehe mindestens 5 zusätzliche Karten in einem Zug während des Endkampfes"
  },
  Task_58991_Name = {Text = "Draw!"},
  Task_58992_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_58992_Name = {
    Text = "Energiesparmodus"
  },
  Task_58993_Desc = {
    Text = "Erhalte mindestens 4 verschiedene Arten von Orisons"
  },
  Task_58993_Name = {Text = "Seelenmark"},
  Task_58994_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_58994_Name = {
    Text = "Schnelle Lösung"
  },
  Task_58995_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_58995_Name = {
    Text = "Schnelle Lösung"
  },
  Task_58996_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_58996_Name = {
    Text = "Schnelle Lösung"
  },
  Task_58997_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_58997_Name = {
    Text = "Schnelle Lösung"
  },
  Task_58998_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_58998_Name = {
    Text = "Schnelle Lösung"
  },
  Task_58999_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_58999_Name = {
    Text = "Schnelle Lösung"
  },
  Task_59000_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_59000_Name = {
    Text = "Schnelle Lösung"
  },
  Task_59001_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_59001_Name = {
    Text = "Perfekter Pass"
  },
  Task_59002_Desc = {
    Text = "Habe nicht mehr als 3 Symptomkarten bei Abschluss"
  },
  Task_59002_Name = {
    Text = "Energiesparmodus"
  },
  Task_59003_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_59003_Name = {
    Text = "Energiesparmodus"
  },
  Task_59004_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_59004_Name = {
    Text = "Perfekter Pass"
  },
  Task_59005_Desc = {
    Text = "Trage mindestens 8 Relikte bei Abschluss."
  },
  Task_59005_Name = {
    Text = "Geheimes Versteck"
  },
  Task_59006_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_59006_Name = {
    Text = "Perfekter Pass"
  },
  Task_59007_Desc = {
    Text = "Trage mindestens 1 verfluchtes Relikt bei Abschluss."
  },
  Task_59007_Name = {
    Text = "Geheimes Versteck"
  },
  Task_59008_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_59008_Name = {
    Text = "Perfekter Pass"
  },
  Task_59009_Desc = {
    Text = "Spiele mindestens 6 Karten in einem Zug während des Finalen Kampfes"
  },
  Task_59009_Name = {
    Text = "Ich bin dran!"
  },
  Task_59010_Desc = {
    Text = "In einem Zug des finalen Kampfes staple einen Schild in Höhe von mindestens 65% der maximalen Gesundheit."
  },
  Task_59010_Name = {Text = "Ironclad"},
  Task_59011_Desc = {
    Text = "Spiele mindestens 6 Karten in einem Zug während des Finalen Kampfes"
  },
  Task_59011_Name = {
    Text = "Ich bin dran!"
  },
  Task_59012_Desc = {
    Text = "In einem Zug des finalen Kampfes staple einen Schild in Höhe von mindestens 65% der maximalen Gesundheit."
  },
  Task_59012_Name = {Text = "Ironclad"},
  Task_59013_Desc = {
    Text = "Ziehe mindestens 5 zusätzliche Karten in einem Zug während des Endkampfes"
  },
  Task_59013_Name = {Text = "Draw!"},
  Task_59014_Desc = {
    Text = "Im Finalkampf in einer Runde mindestens 20000 Punkte Schaden verursachen"
  },
  Task_59014_Name = {
    Text = "Volltreffer"
  },
  Task_59015_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_59015_Name = {
    Text = "Elegant und präzise"
  },
  Task_59016_Desc = {
    Text = "Erhalte mindestens 4 verschiedene Arten von Orisons"
  },
  Task_59016_Name = {Text = "Seelenmark"},
  Task_59017_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_59017_Name = {
    Text = "Elegant und präzise"
  },
  Task_59018_Desc = {
    Text = "Trage mindestens 1 verfluchtes Relikt bei Abschluss."
  },
  Task_59018_Name = {
    Text = "Geheimes Versteck"
  },
  Task_59019_Desc = {
    Text = "Wecke alle Erwachten nach Abschluss"
  },
  Task_59019_Name = {
    Text = "Unendliche Umarmung"
  },
  Task_59020_Desc = {
    Text = "Trage mindestens 2 Relikte bei Abschluss"
  },
  Task_59020_Name = {
    Text = "Geheimes Versteck"
  },
  Task_59021_Desc = {
    Text = "Trage mindestens 1 verfluchtes Relikt bei Abschluss."
  },
  Task_59021_Name = {
    Text = "Geheimes Versteck"
  },
  Task_59022_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_59022_Name = {
    Text = "Energiesparmodus"
  },
  Task_59023_Desc = {
    Text = "Ziehe mindestens 4 zusätzliche Karten in einem Zug während des Endkampfes"
  },
  Task_59023_Name = {Text = "Draw!"},
  Task_59024_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_59024_Name = {
    Text = "Perfekter Pass"
  },
  Task_59025_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_59025_Name = {
    Text = "Perfekter Pass"
  },
  Task_59026_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_59026_Name = {
    Text = "Perfekter Pass"
  },
  Task_59027_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_59027_Name = {
    Text = "Perfekter Pass"
  },
  Task_59028_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_59028_Name = {
    Text = "Perfekter Pass"
  },
  Task_59029_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_59029_Name = {
    Text = "Perfekter Pass"
  },
  Task_59030_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_59030_Name = {
    Text = "Perfekter Pass"
  },
  Task_59031_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_59031_Name = {
    Text = "Perfekter Pass"
  },
  Task_59032_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_59032_Name = {
    Text = "Perfekter Pass"
  },
  Task_59033_Desc = {
    Text = "Wecke alle Erwachten nach Abschluss"
  },
  Task_59033_Name = {
    Text = "Unendliche Umarmung"
  },
  Task_59034_Desc = {
    Text = "Trage mindestens 2 Relikte bei Abschluss"
  },
  Task_59034_Name = {
    Text = "Geheimes Versteck"
  },
  Task_59035_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_59035_Name = {
    Text = "Schnelle Lösung"
  },
  Task_59036_Desc = {
    Text = "Trage mindestens 1 verfluchtes Relikt bei Abschluss."
  },
  Task_59036_Name = {
    Text = "Geheimes Versteck"
  },
  Task_59037_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 18 Zügen"
  },
  Task_59037_Name = {
    Text = "Schnelle Lösung"
  },
  Task_59038_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 12 Zügen"
  },
  Task_59038_Name = {
    Text = "Schnelle Lösung"
  },
  Task_59039_Desc = {
    Text = "In einem Zug des finalen Kampfes staple einen Schild in Höhe von mindestens 60% der maximalen Gesundheit."
  },
  Task_59039_Name = {Text = "Ironclad"},
  Task_59040_Desc = {
    Text = "Spiele mindestens 5 Karten in einem Zug während des Finalen Kampfes."
  },
  Task_59040_Name = {
    Text = "Ich bin dran!"
  },
  Task_59041_Desc = {
    Text = "In einem Zug des finalen Kampfes staple einen Schild in Höhe von mindestens 60% der maximalen Gesundheit."
  },
  Task_59041_Name = {Text = "Ironclad"},
  Task_59042_Desc = {
    Text = "Habe nicht mehr als 3 Symptomkarten bei Abschluss"
  },
  Task_59042_Name = {
    Text = "Energiesparmodus"
  },
  Task_59043_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_59043_Name = {
    Text = "Elegant und präzise"
  },
  Task_59044_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 18 Zügen"
  },
  Task_59044_Name = {
    Text = "Schnelle Lösung"
  },
  Task_59045_Desc = {
    Text = "Ziehe mindestens 4 zusätzliche Karten in einem Zug während des Endkampfes"
  },
  Task_59045_Name = {Text = "Draw!"},
  Task_59046_Desc = {
    Text = "Trage mindestens 8 Relikte bei Abschluss."
  },
  Task_59046_Name = {
    Text = "Geheimes Versteck"
  },
  Task_59047_Desc = {
    Text = "Spiele mindestens 5 Karten in einem Zug während des Finalen Kampfes."
  },
  Task_59047_Name = {
    Text = "Ich bin dran!"
  },
  Task_59048_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_59048_Name = {
    Text = "Elegant und präzise"
  },
  Task_59438_Desc = {
    Text = "Rykers Affinität hat Level 10 erreicht."
  },
  Task_60163_Desc = {
    Text = "Vollständig das Level"
  },
  Task_60163_Name = {
    Text = "Vollständig das Level"
  },
  Task_60163_UnlockCondDesc = {
    Text = "Wird nach dem Abschluss von Stufe 8-9 freigeschaltet"
  },
  Task_60164_Desc = {
    Text = "Vollständig das Level"
  },
  Task_60164_Name = {
    Text = "Vollständig das Level"
  },
  Task_60164_UnlockCondDesc = {
    Text = "Wird nach dem Abschluss von Stufe 8-11 freigeschaltet"
  },
  Task_60165_Desc = {
    Text = "Vollständig das Level"
  },
  Task_60165_Name = {
    Text = "Vollständig das Level"
  },
  Task_60165_UnlockCondDesc = {
    Text = "Wird nach dem Abschluss von Stufe 8-10 freigeschaltet"
  },
  Task_60443_Desc = {
    Text = "Schließen Sie die Hauptuntersuchung Kapitel 4 \"In Stille\" ab"
  },
  Task_60444_Desc = {
    Text = "Erstes Mal 150 Trainingspunkte erreicht"
  },
  Task_60445_Desc = {
    Text = "Erstes Mal 325 Trainingspunkte erreicht"
  },
  Task_60446_Desc = {
    Text = "Erste Mal 50 Trainingspunkte erreicht"
  },
  Task_60447_Desc = {
    Text = "Trainingspunkte erreichen zum ersten Mal 100"
  },
  Task_60448_Desc = {
    Text = "Vollständig das Hauptuntersuchungskapitel 4 \"In Stille\" auf harter Schwierigkeit"
  },
  Task_60449_Desc = {
    Text = "Erstes Mal 300 Trainingspunkte erreicht"
  },
  Task_60450_Desc = {
    Text = "Vollständig das Hauptuntersuchungskapitel 2: \"Im Namen der Wachskulpturen\""
  },
  Task_60451_Desc = {
    Text = "Vollständig Ermittlung Hauptgeschichte Kapitel 5 \"Sturmauge\" im Schwierigkeitsgrad Hart"
  },
  Task_60452_Desc = {
    Text = "Der Sondertrainingswert erreicht erstmals 225"
  },
  Task_60453_Desc = {
    Text = "Vollständig Kapitel 1 der Hauptermittlung \"Ost Geheimnis\""
  },
  Task_60454_Desc = {
    Text = "Vollständig Ermittlung Hauptmission Kapitel 6 \"Verdrehte Sterne\" im Schwierigkeitsgrad Hart"
  },
  Task_60455_Desc = {
    Text = "Vollständig das Hauptuntersuchungskapitel 2 \"Im Namen der Wachskulpturen\" auf harter Schwierigkeit"
  },
  Task_60456_Desc = {
    Text = "Vollständige Ermittlung Hauptverlauf Kapitel 5 \"Augen des Sturms\""
  },
  Task_60457_Desc = {
    Text = "Vollständig Ermittlung Hauptgeschichte Kapitel 3 \"Vorsicht vor Hunden\" im Schwierigkeitsgrad Hart"
  },
  Task_60458_Desc = {
    Text = "Vollständig Ermittlung Hauptmission Kapitel 1 \"Östliches Geheimnis\" im Schwierigkeitsgrad Hart"
  },
  Task_60459_Desc = {
    Text = "Vollständige Ermittlung Hauptverlauf Kapitel 3 \"Achte auf die Hunde\""
  },
  Task_60460_Desc = {
    Text = "Vollständige Ermittlung Hauptmission Kapitel 6 \"Verdrehte Sterne\""
  },
  Task_60461_Desc = {
    Text = "Der Sondertrainingswert erreicht erstmals 350"
  },
  Task_60601_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60602_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60603_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60604_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60606_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60607_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60608_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60609_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60610_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60611_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60612_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60613_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60614_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60615_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60616_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60617_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60618_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60619_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60620_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60622_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60623_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60624_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60625_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60626_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60627_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60628_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60629_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60630_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60631_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60633_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60634_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60635_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60636_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60637_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60638_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60639_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60640_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60641_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60642_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60643_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60644_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60645_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60646_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60647_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60648_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60649_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60650_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60651_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60653_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60654_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60655_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60656_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60657_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60658_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60659_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60660_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60661_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60663_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60664_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60665_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60666_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60667_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60668_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60669_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60670_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60671_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60672_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60673_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60674_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60675_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60676_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60677_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60678_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60680_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60681_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60682_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60683_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60684_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60685_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60686_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60687_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60688_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60689_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60690_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60691_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60692_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60694_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60696_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60697_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60699_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60742_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60743_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60747_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60748_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60749_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60750_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60751_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60752_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60754_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60755_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60757_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60758_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60759_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60760_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60761_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60763_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60765_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60766_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60768_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60769_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60770_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60772_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60773_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60774_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60777_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60778_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60779_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60780_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60781_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60782_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60783_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60784_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60785_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60787_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60788_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60789_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60790_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60793_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60795_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60796_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60797_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60798_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60799_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60800_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60801_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60803_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60804_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60805_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_60829_Desc = {
    Text = "Hameln's Affinität erreicht Level 10"
  },
  Task_61103_Desc = {
    Text = "Erhalte Genesis-Puppe"
  },
  Task_61103_Name = {
    Text = "Erhalte Genesis-Puppe"
  },
  Task_61104_Desc = {
    Text = "Erhalte Genesis-Helot"
  },
  Task_61104_Name = {
    Text = "Erhalte Genesis-Helot"
  },
  Task_61105_Desc = {
    Text = "Lily erhalten"
  },
  Task_61105_Name = {
    Text = "Lily erhalten"
  },
  Task_61106_Desc = {
    Text = "Horla erhalten"
  },
  Task_61106_Name = {
    Text = "Horla erhalten"
  },
  Task_61107_Desc = {
    Text = "Miryam erhalten"
  },
  Task_61107_Name = {
    Text = "Miryam erhalten"
  },
  Task_61108_Desc = {
    Text = "Ryker erhalten"
  },
  Task_61108_Name = {
    Text = "Ryker erhalten"
  },
  Task_61109_Desc = {
    Text = "Sorel erhalten"
  },
  Task_61109_Name = {
    Text = "Sorel erhalten"
  },
  Task_61110_Desc = {
    Text = "Salvador erhalten"
  },
  Task_61110_Name = {
    Text = "Salvador erhalten"
  },
  Task_61111_Desc = {
    Text = "Wanda erhalten"
  },
  Task_61111_Name = {
    Text = "Wanda erhalten"
  },
  Task_61112_Desc = {
    Text = "Tulu erhalten"
  },
  Task_61112_Name = {
    Text = "Tulu erhalten"
  },
  Task_61113_Desc = {
    Text = "Erhöhe \"24\""
  },
  Task_61113_Name = {
    Text = "Erhöhe \"24\""
  },
  Task_61114_Desc = {
    Text = "Tawil erhalten"
  },
  Task_61114_Name = {
    Text = "Tawil erhalten"
  },
  Task_61115_Desc = {
    Text = "Thais erhalten"
  },
  Task_61115_Name = {
    Text = "Thais erhalten"
  },
  Task_61116_Desc = {
    Text = "Hameln erhalten"
  },
  Task_61116_Name = {
    Text = "Hameln erhalten"
  },
  Task_61117_Desc = {
    Text = "Narzisse erhalten"
  },
  Task_61117_Name = {
    Text = "Narzisse erhalten"
  },
  Task_61118_Desc = {
    Text = "Murphy erhalten"
  },
  Task_61118_Name = {
    Text = "Murphy erhalten"
  },
  Task_61157_Desc = {
    Text = "Vollständig Ermittlung Kapitel 8 \"Letzte Symphonie\" im Schwierigkeitsgrad Hart"
  },
  Task_61158_Desc = {
    Text = "Vollständig Ermittlungen Kapitel 7 \"Fluss des Verlangens\""
  },
  Task_61159_Desc = {
    Text = "Vollständig Ermittlung Kapitel 7 \"Fluss des Verlangens\" im Schwierigkeitsgrad Hart"
  },
  Task_61160_Desc = {
    Text = "Vollständig Ermittlung Kapitel 8 \"Letzte Symphonie\" im Schwierigkeitsgrad Hart"
  },
  Task_61161_Desc = {
    Text = "Vollständig Ermittlungen Kapitel 8 \"Finale Symphonie\""
  },
  Task_61162_Desc = {
    Text = "Vollständig Ermittlung Kapitel 7 \"Fluss des Verlangens\" im Schwierigkeitsgrad Hart"
  },
  Task_61163_Desc = {
    Text = "Vollständig Ermittlungen Kapitel 7 \"Fluss des Verlangens\""
  },
  Task_61164_Desc = {
    Text = "Vollständig Ermittlungen Kapitel 8 \"Finale Symphonie\""
  },
  Task_61186_Desc = {
    Text = "Cleare \"Ein Segment der Erinnerung\" bei beliebiger Schwierigkeit"
  },
  Task_61187_Desc = {
    Text = "Vervollständige \"Stadt aus Gold\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_61188_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker in der “Stadt im See“ 1 Mal gewinnen"
  },
  Task_61189_Desc = {
    Text = "Alle Aufgaben von „Stadt im See·Abschluss\" abgeschlossen"
  },
  Task_61190_Desc = {
    Text = "Clear \"Offenbarung\" auf jedem Schwierigkeitsgrad"
  },
  Task_61191_Desc = {
    Text = "Vollständig \"Realität\" auf Wahnsinn-Schwierigkeit"
  },
  Task_61192_Desc = {
    Text = "Schließe \"Stadt aus Gold\" auf Wahnsinn-Schwierigkeitsgrad ab"
  },
  Task_61193_Desc = {
    Text = "Clear \"Fata Morgana\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_61194_Desc = {
    Text = "Stadt im See: Vollständig"
  },
  Task_61195_Desc = {
    Text = "Vollständig \"Realität\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_61196_Desc = {
    Text = "Clear \"Kleine Canna\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_61197_Desc = {
    Text = "Clear \"Fata Morgana\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_61198_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker einmal im „Stadt im See“ gewinnen."
  },
  Task_61199_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker in der “Stadt im See“ 1 Mal gewinnen"
  },
  Task_61200_Desc = {
    Text = "„Fata Morgana“ auf Schwierigkeitsgrad Wahnsinn abschließen"
  },
  Task_61201_Desc = {
    Text = "Stadt im See·Reich"
  },
  Task_61202_Desc = {
    Text = "Vervollständige \"Stadt aus Gold\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_61203_Desc = {
    Text = "Clear \"Offenbarung\" auf jedem Schwierigkeitsgrad"
  },
  Task_61204_Desc = {
    Text = "Clear \"Brunnen\" auf jedem Schwierigkeitsgrad"
  },
  Task_61205_Desc = {
    Text = "Cleare \"Ein Segment der Erinnerung\" bei beliebiger Schwierigkeit"
  },
  Task_61206_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker einmal im „Stadt im See“ gewinnen"
  },
  Task_61207_Desc = {
    Text = "Clear \"Kleine Canna\" auf Schwierigkeitsgrad Wahnsi"
  },
  Task_61208_Desc = {
    Text = "Clear \"Offenbarung\" auf Schwierigkeitsgrad Wahnsi"
  },
  Task_61209_Desc = {
    Text = "Clear \"Brunnen\" auf jedem Schwierigkeitsgrad"
  },
  Task_61210_Desc = {
    Text = "Clear \"Kleine Canna\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_61211_Desc = {
    Text = "City im See·Wahnsinn"
  },
  Task_61212_Desc = {
    Text = "Vollständig \"Realität\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_61213_Desc = {
    Text = "\"A Segment of Memory\" auf Wahnsinns-Schwierigkeit erfolgreich abschließen"
  },
  Task_61214_Desc = {
    Text = "Clear \"Brunnen\" auf Schwierigkeitsgrad Wahnsi"
  },
  Task_61215_Desc = {
    Text = "Vervollständige \"Brennendes Festmahl\" in The Wandering"
  },
  Task_61375_Desc = {
    Text = "Kumulativer Login: 12 Tage"
  },
  Task_61376_Desc = {
    Text = "Logge dich an insgesamt 3 aufeinander folgenden Tagen ein"
  },
  Task_61377_Desc = {
    Text = "Insgesamt 9 Tage eingeloggt"
  },
  Task_61378_Desc = {
    Text = "Kumulativer Login: 11 Tage"
  },
  Task_61379_Desc = {
    Text = "Logge dich insgesamt 10 Tage lang ein"
  },
  Task_61380_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_61381_Desc = {
    Text = "Logge dich insgesamt 4 Tage lang ein"
  },
  Task_61382_Desc = {
    Text = "Logge dich insgesamt 15 Tage lang ein"
  },
  Task_61383_Desc = {
    Text = "14-tägliche kumulierte Anmeldung"
  },
  Task_61384_Desc = {
    Text = "Logge dich an insgesamt 5 aufeinander folgenden Tagen ein"
  },
  Task_61385_Desc = {
    Text = "Logge dich insgesamt 8 Tage lang ein"
  },
  Task_61386_Desc = {
    Text = "Logge dich insgesamt 2 Tage lang ein"
  },
  Task_61387_Desc = {
    Text = "Kumulativer Login: 13 Tage"
  },
  Task_61388_Desc = {
    Text = "Kumulativer Login für 6 Tage"
  },
  Task_61389_Desc = {
    Text = "Insgesamt 16 Tage eingeloggt"
  },
  Task_61390_Desc = {
    Text = "Logge dich insgesamt 7 Tage lang ein"
  },
  Task_61394_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61395_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61396_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61397_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61398_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61399_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61400_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61401_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61402_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61403_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61404_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61405_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61407_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61408_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61409_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61410_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61411_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61412_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61413_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61414_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61415_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61416_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61417_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61418_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61419_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61420_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61421_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61422_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61425_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61426_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61427_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61428_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61430_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61431_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61432_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61433_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61434_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61435_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61436_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61438_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61439_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61440_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61441_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61442_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61443_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61444_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61445_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61446_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61447_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61448_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61449_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61450_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61451_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61452_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61453_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61455_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61456_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61457_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61458_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61459_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61460_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61461_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61462_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61463_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61464_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61465_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61466_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61468_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61469_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61470_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61471_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61472_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61473_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61474_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61475_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61476_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61477_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61478_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61479_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61481_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61519_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61520_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61521_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61522_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61523_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61524_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61525_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61526_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61527_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61528_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61616_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61617_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61620_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61621_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61622_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61623_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61626_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61627_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61628_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61629_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61631_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61633_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61634_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61636_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61637_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61639_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61640_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61642_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61643_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61644_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61645_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61648_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61649_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61650_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61652_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61653_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61654_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61655_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61657_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61659_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61660_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61661_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61662_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61665_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61666_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61668_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61669_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61671_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61672_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61673_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61675_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61676_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61678_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61679_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61681_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61682_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61684_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61685_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61687_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61688_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61690_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61691_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61693_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61694_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61696_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61697_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61699_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61700_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61701_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61702_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61704_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61705_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61706_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61707_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61709_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61710_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61712_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61713_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61716_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61717_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61719_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61720_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61722_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61723_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61725_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61726_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61727_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61729_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61731_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61733_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61734_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61735_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61736_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61739_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61740_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61743_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61744_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61748_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61749_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61750_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61751_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61753_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61754_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61756_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61757_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61758_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61759_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61762_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61763_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61765_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61766_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61767_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61769_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61770_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61771_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61772_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61774_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61777_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61778_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61781_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61782_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61783_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61784_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61785_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61788_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61789_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61791_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61792_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61794_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61795_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61796_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61797_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61798_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61801_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61802_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61804_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61805_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61807_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61808_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61810_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61811_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61814_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61815_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61816_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61817_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61819_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61820_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61821_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61824_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_61825_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_62002_Desc = {
    Text = "Vollständig \"Bergsicht\" auf Wahnsinn-Schwierigkeit"
  },
  Task_62003_Desc = {
    Text = "Schließe \"Boden brechen\" auf beliebiger Schwierigkeitsstufe ab"
  },
  Task_62004_Desc = {
    Text = "Tierische Ambitionen·Reich"
  },
  Task_62005_Desc = {
    Text = "Schließe \"Kaltes Nacht\" auf beliebiger Schwierigkeit ab"
  },
  Task_62006_Desc = {
    Text = "Austausch von Blütenknospen für 200 Belohnungen in \"Ambition des Verschlingens\""
  },
  Task_62007_Desc = {
    Text = "Austausch von Blütenknospen für 100 Belohnungen in \"Ambition des Verschlingens\""
  },
  Task_62008_Desc = {
    Text = "Cleare \"Kaltes Nacht\" Wahnsinn-Schwierigkeit"
  },
  Task_62009_Desc = {
    Text = "Schließe \"Kaltes Nacht\" auf beliebiger Schwierigkeit ab"
  },
  Task_62010_Desc = {
    Text = "Vollständig \"Bergsicht\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_62011_Desc = {
    Text = "\"Beast Fight\" auf jeder Schwierigkeit erfolgreich abschließen"
  },
  Task_62012_Desc = {
    Text = "Vollständig \"Bergsicht\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_62013_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker im “Tierischer Ehrgeiz“ einmal gewinnen"
  },
  Task_62014_Desc = {
    Text = "Riesenmaul des Berges"
  },
  Task_62015_Desc = {
    Text = "Schließe \"Bodenbrechen\" auf Wahnsinn-Schwierigkeitsgrad ab"
  },
  Task_62016_Desc = {
    Text = "Tierische Ambition·Wahnsinn"
  },
  Task_62017_Desc = {
    Text = "Clear \"Rückkehr\" auf Schwierigkeitsgrad Wahnsi"
  },
  Task_62018_Desc = {
    Text = "Tierische Ambitionen: Vollständig"
  },
  Task_62019_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im „Tierischer Ehrgeiz“ 1 Mal gewinnen"
  },
  Task_62020_Desc = {
    Text = "Du kannst 100 Belohnungen erhalten, indem du Knospen in \"Wiederauferstehung Hoffnung\" eintauschst"
  },
  Task_62021_Desc = {
    Text = "Austausch von Blütenknospen für 200 Belohnungen in \"Geist der Vergeltung\""
  },
  Task_62022_Desc = {
    Text = "Austausch von Blütenknospen für 100 Belohnungen in \"Geist der Vergeltung\""
  },
  Task_62023_Desc = {
    Text = "Alle Aufgaben von “Bestie des Herzens · Komplett durchgespielt“ abschließen"
  },
  Task_62024_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im Modus „Tierischer Ehrgeiz“ einmal gewinnen"
  },
  Task_62025_Desc = {
    Text = "Du kannst 200 Belohnungen erhalten, indem du Knospen in \"Wiederauferstehung Hoffnung\" eintauschst."
  },
  Task_62026_Desc = {
    Text = "Clear \"Rückkehr\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_62027_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Tierischer Ehrgeiz“ einmal gewinnen"
  },
  Task_62028_Desc = {
    Text = "\"Beast Fight\" auf jeder Schwierigkeit erfolgreich abschließen"
  },
  Task_62029_Desc = {
    Text = "Den \"Tierkampf\" auf Wahnsinn-Schwierigkeit beseitigen"
  },
  Task_62030_Desc = {
    Text = "Clear \"Rückkehr\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_62031_Desc = {
    Text = "Schließe \"Boden brechen\" auf beliebiger Schwierigkeitsstufe ab"
  },
  Task_62092_Desc = {
    Text = "Vollständig den speziellen Operationsbericht \"Rückkehr von Elworth\"."
  },
  Task_62207_Desc = {
    Text = "Helot: Catena Affinität hat Level 10 erreicht."
  },
  Task_62209_Desc = {
    Text = "Entkomme vom Schneeberg"
  },
  Task_62209_Name = {Text = "Ziel"},
  Task_62231_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Ryker"
  },
  Task_62231_Name = {
    Text = "Erleuchten 6 beim Erhalten von Ryker"
  },
  Task_62231_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Ryker Erleuchtung Paket 2 Ereignis"
  },
  Task_62232_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Jenkin"
  },
  Task_62232_Name = {
    Text = "Erleuchten 2 beim Erhalten von Jenkin"
  },
  Task_62232_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Jenkin Erleuchten Paket 1 Ereignis"
  },
  Task_62233_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Jenkin"
  },
  Task_62233_Name = {
    Text = "Erleuchten 6 beim Erhalten von Jenkin"
  },
  Task_62233_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Jenkin Erleuchtungspaket 2 Ereignis"
  },
  Task_62234_Desc = {
    Text = "Erleuchte 2 beim Erhalt von Hameln"
  },
  Task_62234_Name = {
    Text = "Erleuchte 2 beim Erhalt von Hameln"
  },
  Task_62234_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Hameln Erleuchtungspaket 1 Ereignis"
  },
  Task_62235_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Wanda"
  },
  Task_62235_Name = {
    Text = "Erleuchten 2 beim Erhalten von Wanda"
  },
  Task_62235_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Wanda Erleuchtung Paket 1 Ereignis"
  },
  Task_62236_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Nymphaea"
  },
  Task_62236_Name = {
    Text = "Erleuchten 6 beim Erhalten von Nymphaea"
  },
  Task_62236_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Nymphaea Erleuchtung Paket 2 Ereignis"
  },
  Task_62237_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Horla"
  },
  Task_62237_Name = {
    Text = "Erleuchten 2 beim Erhalten von Horla"
  },
  Task_62237_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Horla Erleuchten Paket 1 Ereignis"
  },
  Task_62238_Desc = {
    Text = "Erleuchten 6 beim Erwerb von Wanda"
  },
  Task_62238_Name = {
    Text = "Erleuchten 6 beim Erwerb von Wanda"
  },
  Task_62238_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Wanda Erleuchtung Paket 2 Ereignis"
  },
  Task_62239_Desc = {
    Text = "Erleuchte 2 beim Erhalt von Casiah"
  },
  Task_62239_Name = {
    Text = "Erleuchte 2 beim Erhalt von Casiah"
  },
  Task_62239_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Casiah Erleuchten Geschenkpaket 1 Ereignis"
  },
  Task_62240_Desc = {
    Text = "Erleuchte 2 beim Erhalt von Faros"
  },
  Task_62240_Name = {
    Text = "Erleuchte 2 beim Erhalt von Faros"
  },
  Task_62240_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Faros Erleuchtungspaket 1 Ereignis"
  },
  Task_62241_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Hameln"
  },
  Task_62241_Name = {
    Text = "Erleuchten 6 beim Erhalten von Hameln"
  },
  Task_62241_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Hameln Erleuchtungspaket 2 Ereignis"
  },
  Task_62242_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Tinktur"
  },
  Task_62242_Name = {
    Text = "Erleuchten 6 beim Erhalten von Tinktur"
  },
  Task_62242_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Tinktur Erleuchten Paket 2 Ereignis"
  },
  Task_62243_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Goliath"
  },
  Task_62243_Name = {
    Text = "Erleuchten 6 beim Erhalten von Goliath"
  },
  Task_62243_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Goliath Erleuchten Paket 2 Ereignis"
  },
  Task_62244_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Tinktur"
  },
  Task_62244_Name = {
    Text = "Erleuchten 2 beim Erhalten von Tinktur"
  },
  Task_62244_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Tinktur Erleuchten Paket 1 Ereignis"
  },
  Task_62245_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Leigh"
  },
  Task_62245_Name = {
    Text = "Erleuchten 6 beim Erhalten von Leigh"
  },
  Task_62245_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Leigh Erleuchten Paket 2 Ereignis"
  },
  Task_62246_Desc = {
    Text = "Erleuchten 6 beim Erwerb von Tulu"
  },
  Task_62246_Name = {
    Text = "Erleuchten 6 beim Erwerb von Tulu"
  },
  Task_62246_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Tulu Erleuchten Paket 2 Ereignis"
  },
  Task_62247_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Uvhash"
  },
  Task_62247_Name = {
    Text = "Erleuchten 2 beim Erhalten von Uvhash"
  },
  Task_62247_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Uvhash Erleuchtung Paket 1 Ereignis"
  },
  Task_62248_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Tulu"
  },
  Task_62248_Name = {
    Text = "Erleuchten 2 beim Erhalten von Tulu"
  },
  Task_62248_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Tulu Erleuchtung Paket 1 Ereignis"
  },
  Task_62249_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Lily"
  },
  Task_62249_Name = {
    Text = "Erleuchten 6 beim Erhalten von Lily"
  },
  Task_62249_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Lily Erleuchtungspaket 2 Ereignis"
  },
  Task_62250_Desc = {
    Text = "Erleuchte 2 beim Erhalt von Ohnmacht"
  },
  Task_62250_Name = {
    Text = "Erleuchte 2 beim Erhalt von Ohnmacht"
  },
  Task_62250_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Ohnmacht Erleuchtungspaket 1 Ereignis"
  },
  Task_62251_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Narzisse"
  },
  Task_62251_Name = {
    Text = "Erleuchten 6 beim Erhalten von Narzisse"
  },
  Task_62251_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Narzisse Erleuchten Paket 2 Ereignis"
  },
  Task_62252_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Agrippa"
  },
  Task_62252_Name = {
    Text = "Erleuchten 6 beim Erhalten von Agrippa"
  },
  Task_62252_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Agrippa Erleuchten Paket 2 Ereignis"
  },
  Task_62253_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Pandia"
  },
  Task_62253_Name = {
    Text = "Erleuchten 2 beim Erhalten von Pandia"
  },
  Task_62253_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Pandia Erleuchtung Paket 1 Ereignis"
  },
  Task_62254_Desc = {
    Text = "Erleuchte 2 beim Erhalt von Narzisse"
  },
  Task_62254_Name = {
    Text = "Erleuchte 2 beim Erhalt von Narzisse"
  },
  Task_62254_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Narzisse Erleuchtungspaket 1 Ereignis"
  },
  Task_62255_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Sorel"
  },
  Task_62255_Name = {
    Text = "Erleuchten 2 beim Erhalten von Sorel"
  },
  Task_62255_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Sorel Erleuchten Paket 1 Ereignis"
  },
  Task_62256_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Pandia"
  },
  Task_62256_Name = {
    Text = "Erleuchten 6 beim Erhalten von Pandia"
  },
  Task_62256_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Pandia Erleuchtung Paket 2 Ereignis"
  },
  Task_62257_Desc = {
    Text = "Erleuchten 6 beim Erhalten von \"24\""
  },
  Task_62257_Name = {
    Text = "Erleuchten 6 beim Erhalten von \"24\""
  },
  Task_62257_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher \"24\" Erleuchten Geschenkpaket 2 Ereignis"
  },
  Task_62258_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Liz"
  },
  Task_62258_Name = {
    Text = "Erleuchten 2 beim Erhalten von Liz"
  },
  Task_62258_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Liz Erleuchten Paket 1 Ereignis"
  },
  Task_62259_Desc = {
    Text = "Erleuchten 2 beim Erhalten von \"24\""
  },
  Task_62259_Name = {
    Text = "Erleuchten 2 beim Erhalten von \"24\""
  },
  Task_62259_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher \"24\" Erleuchten Geschenkpaket 1 Ereignis"
  },
  Task_62260_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Liz"
  },
  Task_62260_Name = {
    Text = "Erleuchten 6 beim Erhalten von Liz"
  },
  Task_62260_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Liz Erleuchten Paket 2 Ereignis"
  },
  Task_62261_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Helot"
  },
  Task_62261_Name = {
    Text = "Erleuchten 2 beim Erhalten von Helot"
  },
  Task_62261_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Helot Erleuchtungspaket 1 Ereignis"
  },
  Task_62262_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Salvador"
  },
  Task_62262_Name = {
    Text = "Erleuchten 2 beim Erhalten von Salvador"
  },
  Task_62262_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Salvador Erleuchten Paket 1 Ereignis"
  },
  Task_62263_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Helot"
  },
  Task_62263_Name = {
    Text = "Erleuchten 6 beim Erhalten von Helot"
  },
  Task_62263_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Helot Erleuchtungspaket 2 Ereignis"
  },
  Task_62264_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Salvador"
  },
  Task_62264_Name = {
    Text = "Erleuchten 6 beim Erhalten von Salvador"
  },
  Task_62264_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Salvador Erleuchten Paket 2 Ereignis"
  },
  Task_62265_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Nymphaea"
  },
  Task_62265_Name = {
    Text = "Erleuchten 2 beim Erhalten von Nymphaea"
  },
  Task_62265_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Nymphaea Erleuchtung Paket 1 Ereignis"
  },
  Task_62266_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Murphy"
  },
  Task_62266_Name = {
    Text = "Erleuchten 2 beim Erhalten von Murphy"
  },
  Task_62266_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Murphy Erleuchten Paket 1 Ereignis"
  },
  Task_62267_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Ryker"
  },
  Task_62267_Name = {
    Text = "Erleuchten 2 beim Erhalten von Ryker"
  },
  Task_62267_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Ryker Erleuchtung Paket 1 Ereignis"
  },
  Task_62268_Desc = {
    Text = "Erleuchten 6 beim Erwerb von Tawil"
  },
  Task_62268_Name = {
    Text = "Erleuchten 6 beim Erwerb von Tawil"
  },
  Task_62268_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Tawil Erleuchten Paket 2 Ereignis"
  },
  Task_62269_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Faros"
  },
  Task_62269_Name = {
    Text = "Erleuchten 6 beim Erhalten von Faros"
  },
  Task_62269_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Faros Erleuchtungspaket 2 Ereignis"
  },
  Task_62270_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Tawil"
  },
  Task_62270_Name = {
    Text = "Erleuchten 2 beim Erhalten von Tawil"
  },
  Task_62270_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Tawil Erleuchtung Paket 1 Ereignis"
  },
  Task_62271_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Ohnmacht"
  },
  Task_62271_Name = {
    Text = "Erleuchten 6 beim Erhalten von Ohnmacht"
  },
  Task_62271_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Ohnmacht Erleuchtungspaket 2 Ereignis"
  },
  Task_62272_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Sorel"
  },
  Task_62272_Name = {
    Text = "Erleuchten 6 beim Erhalten von Sorel"
  },
  Task_62272_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Sorel Erleuchten Paket 2 Ereignis"
  },
  Task_62273_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Sanga"
  },
  Task_62273_Name = {
    Text = "Erleuchten 2 beim Erhalten von Sanga"
  },
  Task_62273_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Sanga Erleuchtung Paket 1 Ereignis"
  },
  Task_62274_Desc = {
    Text = "Erleuchte 2 beim Erwerb von Goliath"
  },
  Task_62274_Name = {
    Text = "Erleuchte 2 beim Erwerb von Goliath"
  },
  Task_62274_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Goliath Erleuchten Paket 1 Ereignis"
  },
  Task_62275_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Miryam"
  },
  Task_62275_Name = {
    Text = "Erleuchten 2 beim Erhalten von Miryam"
  },
  Task_62275_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Miryam Erleuchten Paket 1 Ereignis"
  },
  Task_62276_Desc = {
    Text = "Erleuchten 6 beim Erwerb von Zwinker"
  },
  Task_62276_Name = {
    Text = "Erleuchten 6 beim Erwerb von Zwinker"
  },
  Task_62276_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Zwinkern Erleuchten Paket 2 Ereignis"
  },
  Task_62277_Desc = {
    Text = "Erleuchte 2 beim Erhalt von Caecus"
  },
  Task_62277_Name = {
    Text = "Erleuchte 2 beim Erhalt von Caecus"
  },
  Task_62277_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Caecus Erleuchten Geschenkpaket 1 Ereignis"
  },
  Task_62278_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Miryam"
  },
  Task_62278_Name = {
    Text = "Erleuchten 6 beim Erhalten von Miryam"
  },
  Task_62278_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Miryam Erleuchten Paket 2 Ereignis"
  },
  Task_62279_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Zwinkern"
  },
  Task_62279_Name = {
    Text = "Erleuchten 2 beim Erhalten von Zwinkern"
  },
  Task_62279_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Zwinkern Erleuchten Paket 1 Ereignis"
  },
  Task_62280_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Caecus"
  },
  Task_62280_Name = {
    Text = "Erleuchten 6 beim Erhalten von Caecus"
  },
  Task_62280_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Caecus Erleuchten Geschenkpaket 2 Ereignis"
  },
  Task_62281_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Nautila"
  },
  Task_62281_Name = {
    Text = "Erleuchten 2 beim Erhalten von Nautila"
  },
  Task_62281_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Nautila Erleuchtung Paket 1 Ereignis"
  },
  Task_62282_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Leigh"
  },
  Task_62282_Name = {
    Text = "Erleuchten 2 beim Erhalten von Leigh"
  },
  Task_62282_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Leigh Erleuchten Paket 1 Ereignis"
  },
  Task_62283_Desc = {
    Text = "Erleuchte 2 beim Erhalt von Celeste"
  },
  Task_62283_Name = {
    Text = "Erleuchte 2 beim Erhalt von Celeste"
  },
  Task_62283_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Celeste Erleuchten Paket 1 Ereignis"
  },
  Task_62284_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Karen"
  },
  Task_62284_Name = {
    Text = "Erleuchten 2 beim Erhalten von Karen"
  },
  Task_62284_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Karen Erleuchten Paket 1 Ereignis"
  },
  Task_62285_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Sanga"
  },
  Task_62285_Name = {
    Text = "Erleuchten 6 beim Erhalten von Sanga"
  },
  Task_62285_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Sanga Erleuchtung Paket 2 Ereignis"
  },
  Task_62286_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Celeste"
  },
  Task_62286_Name = {
    Text = "Erleuchten 6 beim Erhalten von Celeste"
  },
  Task_62286_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Celeste Erleuchten Paket 2 Ereignis"
  },
  Task_62287_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Karen"
  },
  Task_62287_Name = {
    Text = "Erleuchten 6 beim Erhalten von Karen"
  },
  Task_62287_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Karen Erleuchtungspaket 2 Ereignis"
  },
  Task_62288_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Nautila"
  },
  Task_62288_Name = {
    Text = "Erleuchten 6 beim Erhalten von Nautila"
  },
  Task_62288_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Nautila Erleuchtung Paket 2 Ereignis"
  },
  Task_62289_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Murphy"
  },
  Task_62289_Name = {
    Text = "Erleuchten 6 beim Erhalten von Murphy"
  },
  Task_62289_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Murphy Erleuchtung Paket 2 Ereignis"
  },
  Task_62290_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Horla"
  },
  Task_62290_Name = {
    Text = "Erleuchten 6 beim Erhalten von Horla"
  },
  Task_62290_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Horla Erleuchten Paket 2 Ereignis"
  },
  Task_62291_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Thais"
  },
  Task_62291_Name = {
    Text = "Erleuchten 2 beim Erhalten von Thais"
  },
  Task_62291_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Thais Erleuchtung Paket 1 Ereignis"
  },
  Task_62292_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Alva"
  },
  Task_62292_Name = {
    Text = "Erleuchten 6 beim Erhalten von Alva"
  },
  Task_62292_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Alva Erleuchtungspaket 2 Ereignis"
  },
  Task_62293_Desc = {
    Text = "Erleuchte 2 beim Erhalt von Agrippa"
  },
  Task_62293_Name = {
    Text = "Erleuchte 2 beim Erhalt von Agrippa"
  },
  Task_62293_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Agrippa Erleuchten Paket 1 Ereignis"
  },
  Task_62294_Desc = {
    Text = "Erleuchten 2 beim Erhalten von Lily"
  },
  Task_62294_Name = {
    Text = "Erleuchten 2 beim Erhalten von Lily"
  },
  Task_62294_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Lily Erleuchten Paket 1 Ereignis"
  },
  Task_62295_Desc = {
    Text = "Erleuchten 6 beim Erwerb von Thais"
  },
  Task_62295_Name = {
    Text = "Erleuchten 6 beim Erwerb von Thais"
  },
  Task_62295_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Thais Erleuchtung Paket 2 Ereignis"
  },
  Task_62296_Desc = {
    Text = "Erleuchte 2 beim Erhalt von Alva"
  },
  Task_62296_Name = {
    Text = "Erleuchte 2 beim Erhalt von Alva"
  },
  Task_62296_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Alva Erleuchtungspaket 1 Ereignis"
  },
  Task_62297_Desc = {
    Text = "Erleuchten 6 beim Erwerb von Uvhash"
  },
  Task_62297_Name = {
    Text = "Erleuchten 6 beim Erwerb von Uvhash"
  },
  Task_62297_UnlockCondDesc = {
    Text = "Ereignis @ Erwachter Uvhash Erleuchtung Paket 2 Ereignis"
  },
  Task_62298_Desc = {
    Text = "Beim Erwerb von Genesis-Helot, Erleuchte 2"
  },
  Task_62298_Name = {
    Text = "Beim Erwerb von Genesis-Helot, Erleuchte 2"
  },
  Task_62298_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Genesis Helot Erleuchten Paket 1 Ereignis"
  },
  Task_62299_Desc = {
    Text = "Beim Erwerb von Genesis-Helot, Erleuchte 6"
  },
  Task_62299_Name = {
    Text = "Beim Erwerb von Genesis-Helot, Erleuchte 6"
  },
  Task_62299_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Genesis Helot Erleuchten Paket 2 Ereignis"
  },
  Task_62300_Desc = {
    Text = "Erleuchten 6 beim Erhalten von Casiah"
  },
  Task_62300_Name = {
    Text = "Erleuchten 6 beim Erhalten von Casiah"
  },
  Task_62300_UnlockCondDesc = {
    Text = "Ereignis @ Erwacher Casiah Erleuchtungspaket 2 Ereignis"
  },
  Task_62320_Desc = {
    Text = "Vollständig den Sonderbericht \"Rückkehrer von Elworth\" im Schwierigkeitsgrad Hart abschließen"
  },
  Task_62320_Name = {
    Text = "Leben, den Berg durchbrechen·Hart"
  },
  Task_62321_Desc = {
    Text = "Vollständig Ermittlung Ereignis \"Letzte Symphonie\" im Schwierigkeitsgrad Hart"
  },
  Task_62321_Name = {
    Text = "Kampf im Namen der Erinnerung - Hart"
  },
  Task_62322_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"@1@2\""
  },
  Task_62322_Desc2 = {
    Text = "Vollständig Ermittlungen Ereignis \"Finale Symphonie\""
  },
  Task_62322_Name2 = {
    Text = "Kampf um die Erinnerung"
  },
  Task_62323_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 3 Mal Resonanz erzeugt"
  },
  Task_62323_Desc2 = {
    Text = "3 Mal in der Ermittlungsveranstaltung \"Finale Symphonie\" resonieren"
  },
  Task_62323_Name2 = {
    Text = "Echoklang der Resilienz"
  },
  Task_62324_Desc = {
    Text = "Schließen Sie den speziellen Bericht \"Frohes Jagen!\" ab"
  },
  Task_62324_Name = {
    Text = "Schicksals grausamer Scherz"
  },
  Task_62325_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 9 Mal Resonanz erzeugt"
  },
  Task_62325_Desc2 = {
    Text = "Resonieren Sie 9 Mal im Ermittlungsereignis \"Final Symphony\""
  },
  Task_62325_Name2 = {
    Text = "Hartnäckigkeitsresonanz III"
  },
  Task_62326_Desc = {
    Text = "Finde 10 Extraktionspunkte im Hauptquest Kapitel 8 \"@1@2\""
  },
  Task_62326_Desc2 = {
    Text = "Finde 10 Entnahmepunkte in der Hauptgeschichte Kapitel 8 \"Finale Symphonie\""
  },
  Task_62326_Name2 = {
    Text = "Flüsternde Schatten VIII"
  },
  Task_62327_Desc = {
    Text = "Abschließen Sie den besonderen Aufzeichnung \"Rückkehrer von Elworth\""
  },
  Task_62327_Name = {
    Text = "Leben bricht durch den Berg"
  },
  Task_62328_Desc = {
    Text = "Vollständig den Sonderbericht \"Frohes Jagen!\" im Schwierigkeitsgrad Hart abschließen"
  },
  Task_62328_Name = {
    Text = "Verspottung des Schicksals·Hart"
  },
  Task_62329_Desc = {
    Text = "Abschließen Sie den besonderen Aufzeichnung \"Lebensraum der Rose\""
  },
  Task_62329_Name = {
    Text = "Duft von Blumen und Poesie"
  },
  Task_62330_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 6 Mal Resonanz erzeugt"
  },
  Task_62330_Desc2 = {
    Text = "Resonieren Sie 6 Mal im Ermittlungsereignis \"Final Symphony\""
  },
  Task_62330_Name2 = {
    Text = "Resonanz der Hartnäckigkeit II"
  },
  Task_62331_Desc = {
    Text = "Resonieren Sie 13 Mal im Untersuchungsereignis \"@1@2\""
  },
  Task_62331_Desc2 = {
    Text = "13 Mal in der Ermittlungsveranstaltung \"Finale Symphonie\" resonieren"
  },
  Task_62331_Name2 = {
    Text = "Hartnäckigkeitsresonanz IV"
  },
  Task_62332_Desc = {
    Text = "Vollständig den Sonderbericht \"Lebensraum der Rose\" im Schwierigkeitsgrad Hart abschließen"
  },
  Task_62332_Name = {
    Text = "Duft der Blumen und Poesie·Hart"
  },
  Task_62346_Desc = {
    Text = "Besiege \"Die Theorie der vollständigen Vergessenheit\", ohne auf Ramonas Hilfe angewiesen zu sein."
  },
  Task_62346_Name = {
    Text = "Einsame höchste Majestät"
  },
  Task_62371_Desc = {
    Text = "Besiege mit Ramonas Unterstützung „vergessene Anfänge\""
  },
  Task_62371_Name = {
    Text = "Halte meine Hand, Hüter"
  },
  Task_65510_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_65511_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_65512_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_65513_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_65514_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_65515_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_65516_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_65517_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_65518_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_65519_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_65722_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Speicher-Encoding“ einmal gewinnen"
  },
  Task_65723_Desc = {
    Text = "Jede Schwierigkeit von \"Spiegel\" beseitigen"
  },
  Task_65724_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker im Speicher-Encoding 1 Mal gewinnen"
  },
  Task_65725_Desc = {
    Text = "Erinnerungscodierung·Vollständig"
  },
  Task_65726_Desc = {
    Text = "Erinnerungscode: Reich"
  },
  Task_65727_Desc = {
    Text = "Die \"Amygdala\" auf Wahnsinn-Schwierigkeit beseitigen"
  },
  Task_65728_Desc = {
    Text = "Vollständig \"Kurve des Vergessens\" auf Wahnsinn-Schwierigkeit"
  },
  Task_65729_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Speicher-Encoding“ einmal gewinnen"
  },
  Task_65730_Desc = {
    Text = "Jede Schwierigkeit von \"Amygdala\" beseitigen"
  },
  Task_65731_Desc = {
    Text = "Jede Schwierigkeit von \"Amygdala\" beseitigen"
  },
  Task_65732_Desc = {
    Text = "Jede Schwierigkeit von \"Spiegel\" beseitigen"
  },
  Task_65733_Desc = {
    Text = "Jede Schwierigkeit von \"Vergessenheitskurve\" beseitigen"
  },
  Task_65734_Desc = {
    Text = "Clear \"Reptilienhirn\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_65735_Desc = {
    Text = "Unlocks after completing all tasks of \"Erinnerungsenkodierung · Clearance\""
  },
  Task_65736_Desc = {
    Text = "Jede Schwierigkeit von \"Vergessenheitskurve\" beseitigen"
  },
  Task_65737_Desc = {
    Text = "Clear \"Unbewusste Erinnerung\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_65738_Desc = {
    Text = "Vollständig \"Spiegel\" im Wahnsinn-Schwierigkeitsgrad"
  },
  Task_65739_Desc = {
    Text = "Erinnerungscode: Wahnsinn"
  },
  Task_65740_Desc = {
    Text = "Clear \"Unbewusste Erinnerung\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_65741_Desc = {
    Text = "Vollständig den speziellen Operationsbericht \"Friedliche Spaltung\"."
  },
  Task_65742_Desc = {
    Text = "Clear \"Unbewusste Erinnerung\" auf Schwierigkeitsgrad Wahnsi"
  },
  Task_65743_Desc = {
    Text = "Clear \"Reptilienhirn\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_65744_Desc = {
    Text = "Clear \"Reptilienhirn\" auf Schwierigkeitsgrad Wahnsi"
  },
  Task_65745_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Speicher-Encoding“ einmal gewinnen"
  },
  Task_66015_Desc = {
    Text = "Tawils Affinität erreicht Level 10"
  },
  Task_66213_Desc = {
    Text = "Geburt des Gottesreichs · Wahnsinn"
  },
  Task_66214_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker im “Göttliches Reich - Geburt“ 1 Mal gewinnen"
  },
  Task_66215_Desc = {
    Text = "Vollständig \"Zeuge\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_66216_Desc = {
    Text = "Clear \"Zittern\" im Wahnsinns-Schwierigkeitsgrad"
  },
  Task_66217_Desc = {
    Text = "Schließe \"Ankunft\" auf beliebiger Schwierigkeitsstufe ab"
  },
  Task_66218_Desc = {
    Text = "Vollständig \"Glaube\" im Wahnsinn-Schwierigkeitsgrad"
  },
  Task_66219_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Göttliches Reich“ einmal gewinnen"
  },
  Task_66220_Desc = {
    Text = "Vollständig jede Schwierigkeit von \"Überzeugung\""
  },
  Task_66221_Desc = {
    Text = "Vollständig \"Zeuge\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_66224_Desc = {
    Text = "Vollständig \"Zweifel\" auf beliebiger Schwierigkeit"
  },
  Task_66227_Desc = {
    Text = "Vollständig \"Entweihung\" in der Traumlandschaft"
  },
  Task_66228_Desc = {
    Text = "Alle Aufgaben von “Göttliches Reich betreten – Durchspielmodus“ abschließen"
  },
  Task_66229_Desc = {
    Text = "Vollständig \"Zeuge\" auf Wahnsinn-Schwierigkeit"
  },
  Task_66230_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Göttliches Reich - Geburt“ 1 Mal gewinnen"
  },
  Task_66231_Desc = {
    Text = "Vollständig \"Ankunft\" im Wahnsinn-Schwierigkeitsgrad"
  },
  Task_66232_Desc = {
    Text = "Die Geburt des Gottesreichs · Reich"
  },
  Task_66233_Desc = {
    Text = "Clear \"Zittern\" auf jedem Schwierigkeitsgrad"
  },
  Task_66235_Desc = {
    Text = "Vollständig \"Fragen\" auf Wahnsinn-Schwierigkeit"
  },
  Task_66236_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Göttliches Reich - Geburt“ 1 Mal gewinnen"
  },
  Task_66237_Desc = {
    Text = "Schließe \"Ankunft\" auf beliebiger Schwierigkeitsstufe ab"
  },
  Task_66238_Desc = {
    Text = "Clear \"Zittern\" auf jedem Schwierigkeitsgrad"
  },
  Task_66240_Desc = {
    Text = "Geburt des Gottesreichs · Klar"
  },
  Task_66241_Desc = {
    Text = "Vollständig jede Schwierigkeit von \"Überzeugung\""
  },
  Task_66242_Desc = {
    Text = "Vollständig \"Zweifel\" auf beliebiger Schwierigkeit"
  },
  Task_66243_Desc = {
    Text = "Antwort des Abgrunds"
  },
  Task_66335_Desc = {
    Text = "Entkomme der Verfolgung des Ausschusses"
  },
  Task_66335_Name = {Text = "Ziel"},
  Task_66336_Desc = {
    Text = "Halt den Cynocephalus davon ab, Bericht zu erstatte"
  },
  Task_66336_Name = {Text = "Ziel"},
  Task_66337_Desc = {
    Text = "Durch die Blockade des Ausschusses brechen"
  },
  Task_66337_Name = {Text = "Ziel"},
  Task_66338_Desc = {
    Text = "Besiege Thais"
  },
  Task_66338_Name = {Text = "Ziel"},
  Task_66339_Desc = {Text = "Besiege N"},
  Task_66339_Name = {Text = "Ziel"},
  Task_66340_Desc = {
    Text = "Stoppe die Invasion des Ausschusses"
  },
  Task_66340_Name = {Text = "Ziel"},
  Task_66341_Desc = {
    Text = "Zerstöre die Zwillingsgötter-Statuen"
  },
  Task_66341_Name = {Text = "Ziel"},
  Task_66342_Desc = {
    Text = "Hameln Widerstehen"
  },
  Task_66342_Name = {Text = "Ziel"},
  Task_66343_Desc = {
    Text = "Finde Tawil"
  },
  Task_66343_Name = {Text = "Ziel"},
  Task_66344_Desc = {
    Text = "Stoppe Juliette"
  },
  Task_66344_Name = {Text = "Ziel"},
  Task_66422_Name = {
    Text = "Besiege BOSS 1 N-mal"
  },
  Task_66423_Name = {
    Text = "Besiege BOSS 2 N-mal"
  },
  Task_66424_Name = {
    Text = "Besiege BOSS 3 N-mal"
  },
  Task_66425_Name = {
    Text = "Besiege BOSS 4 N-mal"
  },
  Task_66426_Name = {
    Text = "Besiege BOSS 5 Mal"
  },
  Task_66428_Name = {
    Text = "Besiege alle Bosse"
  },
  Task_66580_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_66580_Name = {
    Text = "Perfekter Pass"
  },
  Task_66581_Desc = {
    Text = "Trage mindestens 8 Relikte bei Abschluss."
  },
  Task_66581_Name = {
    Text = "Geheimes Versteck"
  },
  Task_66582_Desc = {
    Text = "Finalkampf nicht länger als 25 Runden gewinnen"
  },
  Task_66582_Name = {
    Text = "Schnelle Lösung"
  },
  Task_66583_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_66583_Name = {
    Text = "Elegant und präzise"
  },
  Task_66584_Desc = {
    Text = "Trage mindestens 8 Relikte bei Abschluss."
  },
  Task_66584_Name = {
    Text = "Geheimes Versteck"
  },
  Task_66585_Desc = {
    Text = "Im Finalkampf in einer Runde mindestens 200000 Punkte Schaden verursachen"
  },
  Task_66585_Name = {
    Text = "Volltreffer"
  },
  Task_66724_Desc = {
    Text = "Schließe \"Abreise\" auf Wahnsinn-Schwierigkeit ab"
  },
  Task_66725_Desc = {
    Text = "Vollständig \"Die Tür der Welten\" auf Wahnsinn-Schwierigkeit"
  },
  Task_66726_Desc = {
    Text = "Vollständig \"Die Tür des Wissens und Handelns\" auf Wahnsinn-Schwierigkeit"
  },
  Task_66727_Desc = {
    Text = "Vollständig \"Die Tür der Extreme\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_66728_Desc = {
    Text = "Clear das \"Tor der Wahrheit\" auf Wahn-Schwierigkeit"
  },
  Task_66729_Desc = {
    Text = "Räume das \"Tor der Vereinigung\" auf beliebiger Schwierigkeit frei"
  },
  Task_66730_Desc = {
    Text = "Schließe \"Abreise\" auf beliebiger Schwierigkeit ab"
  },
  Task_66731_Desc = {
    Text = "Clear \"Das Tor von Wahrheit oder Falschheit\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_66732_Desc = {
    Text = "Vollständig \"Hinter der Tür\" auf Wahnsinn-Schwierigkeit"
  },
  Task_66733_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im“Letzter Test“1x gewinnen"
  },
  Task_66734_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker im “Letzter Test“ 2-mal gewinnen"
  },
  Task_66735_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im“Letzter Test“2-mal gewinnen"
  },
  Task_66736_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker im “Letzter Test“ 1 Mal gewinnen"
  },
  Task_66737_Desc = {
    Text = "Clear \"Das Tor von Wahrheit oder Falschheit\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_66738_Desc = {
    Text = "Vollständig \"Die Tür des Wissens und Handelns\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_66739_Desc = {
    Text = "Finaler Test·Wahnsinn"
  },
  Task_66740_Desc = {
    Text = "Vollständig \"Die Tür des Wissens und Handelns\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_66741_Desc = {
    Text = "Vollständig \"Die Tür der Welten\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_66742_Desc = {
    Text = "Vollständig \"Die Tür der Extreme\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_66743_Desc = {
    Text = "Vollständig \"Tür\" auf beliebiger Schwierigkeit"
  },
  Task_66744_Desc = {
    Text = "Letzte Prüfung: Abschluss"
  },
  Task_66745_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Letzter Test“ zweimal gewinnen"
  },
  Task_66746_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Letzter Test“ einmal gewinnen"
  },
  Task_66747_Desc = {
    Text = "Das \"Tor zur Rationalität\" auf Wahnsinn-Schwierigkeit beseitigen"
  },
  Task_66748_Desc = {
    Text = "Das \"Tor zur Einigung\" auf Wahnsinn-Schwierigkeit beseitigen"
  },
  Task_66749_Desc = {
    Text = "Schließe \"Abreise\" auf beliebiger Schwierigkeit ab"
  },
  Task_66750_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im“Letzter Test“zweimal gewinnen"
  },
  Task_66751_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im“Letzter Test“ 1× gewinnen"
  },
  Task_66752_Desc = {
    Text = "Vollständig \"Tür\" auf beliebiger Schwierigkeit"
  },
  Task_66753_Desc = {
    Text = "Clear das \"Tor der Natur\" auf jedem Schwierigkeitsgrad"
  },
  Task_66754_Desc = {
    Text = "Das \"Tor zur Natur\" auf Wahnsinn-Schwierigkeit beseitigen"
  },
  Task_66755_Desc = {
    Text = "Vollständig \"Die Tür der Extreme\" auf Wahnsinn-Schwierigkeit"
  },
  Task_66756_Desc = {
    Text = "Finaler Test·Reich"
  },
  Task_66757_Desc = {
    Text = "Wird nach dem Abschluss aller Aufgaben in \"Letzter Test · Räumung\" freigeschaltet"
  },
  Task_66758_Desc = {
    Text = "Clear das \"Tor der Rationalität\" auf jedem Schwierigkeitsgrad"
  },
  Task_66759_Desc = {
    Text = "Clear das \"Tor der Natur\" auf jedem Schwierigkeitsgrad"
  },
  Task_66760_Desc = {
    Text = "Vollständig \"Die Tür der Welten\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_66761_Desc = {
    Text = "Clear das \"Tor der Rationalität\" auf jedem Schwierigkeitsgrad"
  },
  Task_66762_Desc = {
    Text = "Räume das \"Tor der Vereinigung\" auf beliebiger Schwierigkeit frei"
  },
  Task_67066_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_67067_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_67068_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_67069_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_67070_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_67071_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_67072_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_67073_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_67075_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_67076_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_67113_Desc = {
    Text = "Finde 2 Ausscheidungspunkte in der Schlussfolgerung der Hauptgeschichte „@1@2“"
  },
  Task_67113_Desc2 = {
    Text = "2 Ablagerungspunkte im Schlusskapitel “Langer Traum endet“ gefunden"
  },
  Task_67113_Name2 = {
    Text = "Versteckte Flüstereien IX"
  },
  Task_67114_Desc = {
    Text = "Vollständig Ermittlung Ereignis \"Wenn der lange Traum endet\" im Schwierigkeitsgrad Hart"
  },
  Task_67114_Name = {
    Text = "Bis zum Tod·Hart ansehen"
  },
  Task_67115_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"@1@2\""
  },
  Task_67115_Desc2 = {
    Text = "Vollständig Ermittlungen Ereignis \"Wenn der Lange Traum endet\""
  },
  Task_67115_Name2 = {
    Text = "Bis zum Tod anschauen"
  },
  Task_67116_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 3 Mal Resonanz erzeugt"
  },
  Task_67116_Desc2 = {
    Text = "In der Untersuchung Veranstaltung \"Ende des langen Traums\" 3 Mal resoniert"
  },
  Task_67116_Name2 = {
    Text = "Echos der Extremität"
  },
  Task_67125_Name = {
    Text = "Besiege BOSS 6 N-mal"
  },
  Task_67126_Name = {
    Text = "Besiege BOSS 7 N-mal"
  },
  Task_67408_Desc = {
    Text = "Blockiere Tohuwabohu, schließe die Tür"
  },
  Task_67408_Name = {Text = "Ziel"},
  Task_67409_Desc = {
    Text = "Finde den Maulwurf innerhalb von Mythag"
  },
  Task_67409_Name = {Text = "Ziel"},
  Task_67410_Desc = {
    Text = "Blockieren Tohuwabohu"
  },
  Task_67410_Name = {Text = "Ziel"},
  Task_67411_Desc = {
    Text = "Abschied von den Erwachten"
  },
  Task_67411_Name = {Text = "Ziel"},
  Task_67827_Desc = {
    Text = "Unterwerfen... unterwerfen dem ewigen Wahrheit des Chaos..."
  },
  Task_67827_Name = {
    Text = "Unterwerfen... unterwerfen dem ewigen Wahrheit des Chaos..."
  },
  Task_67828_Desc = {
    Text = "Sein Wahnwitz, jenseits des Widerstands."
  },
  Task_67828_Name = {
    Text = "Sein Wahnwitz, jenseits des Widerstands."
  },
  Task_67829_Desc = {
    Text = "Seine Majestät, nicht direkt angesehen werden."
  },
  Task_67829_Name = {
    Text = "Seine Majestät, nicht direkt angesehen werden."
  },
  Task_67919_Desc = {
    Text = "Zerstöre alle Klone von “Sona-Nyl: Auge des Wahnsinns“ und entsperre"
  },
  Task_67919_Name = {
    Text = "Besiege Boss 6"
  },
  Task_67920_Desc = {
    Text = "Zerstöre alle Klone im “Wachsfigurenkabinett – Der Anblick des Grauens“ und entsperre"
  },
  Task_67920_Name = {
    Text = "Besiege BOSS2"
  },
  Task_67921_Desc = {
    Text = "Zerstöre alle Klone von “Pflegeheim – Trügerliches Auge“ und entsperre"
  },
  Task_67921_Name = {
    Text = "Besiege BOSS4"
  },
  Task_67922_Desc = {
    Text = "Vernichte alle Duplikate von “Brillpert, der Verderbte Glaube“, um die Freischaltung zu erhalten"
  },
  Task_67922_Name = {
    Text = "Besiege BOSS 5"
  },
  Task_67923_Desc = {
    Text = "Zerstöre alle Klone von “Almosenhaus des weinenden Blicks“, um es freizuschalten"
  },
  Task_67923_Name = {
    Text = "Besiege BOSS1"
  },
  Task_67924_Desc = {
    Text = "Vernichte alle Duplikate von “Lemvashi, der Anblick der Geburt“, um die Freischaltung zu aktivieren"
  },
  Task_67924_Name = {
    Text = "Besiege Boss 7"
  },
  Task_67925_Desc = {
    Text = "Vernichte alle Kopien von „Lai, der Stich des Knochens“ zur Freischaltung"
  },
  Task_67925_Name = {
    Text = "Besiege Boss 3"
  },
  Task_67926_Name = {
    Text = "Fünf Uraugen-Kopien aller Tötungs-Confirmed"
  },
  Task_67927_Name = {
    Text = "Zwei Kopien des «Ursprünglichen Anblicks» wurden getötet"
  },
  Task_67928_Name = {
    Text = "Vier Kopien aller «Ursprünglicher Anblick»-Einheiten wurden getötet"
  },
  Task_67929_Name = {
    Text = "Sechs Uraugen-Kopien aller Feinde wurden getötet"
  },
  Task_67930_Name = {
    Text = "Alle Avatare der Urvision wurden besiegt"
  },
  Task_67931_Name = {
    Text = "Sieben Urauge-Kopien wurden vollständig eliminiert"
  },
  Task_67932_Name = {
    Text = "Drei Uraugen-Kopien aller Tötungs-Confirmed!"
  },
  Task_68342_Desc = {
    Text = "Transzendenz der Sterne III"
  },
  Task_68343_Desc = {
    Text = "Transzendenz der Sterne V"
  },
  Task_68344_Desc = {
    Text = "Transzendenz der Sterne VII"
  },
  Task_68345_Desc = {
    Text = "Transzendenz der Sterne II"
  },
  Task_68346_Desc = {
    Text = "Transzendenz der Sterne IV"
  },
  Task_68347_Desc = {
    Text = "Kraft der Transzendenz: Sterne I"
  },
  Task_68348_Desc = {
    Text = "Transzendenz der Sterne VI"
  },
  Task_68365_Desc = {
    Text = "Über die Sterne hinaus · Kostenlos"
  },
  Task_68377_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_68378_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_68379_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_68380_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_68382_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_68383_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_68384_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_68385_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_68386_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_68387_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_68388_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_68389_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_68390_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_68391_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_68392_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_68393_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_68394_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_68395_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_68396_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_68397_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_68418_Name = {
    Text = "Weltboss-Aktivität beendet"
  },
  Task_68492_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Tiefseeblick“ einmal gewinnen"
  },
  Task_68493_Desc = {
    Text = "Abschluss von „Auge der Götter“ im Wahnsinnsmodus"
  },
  Task_68494_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker einmal im „Tiefseeblick“ gewinnen"
  },
  Task_68495_Desc = {
    Text = "Abschluss von „Herrliche Fantasie“ in beliebiger Schwierigkeit"
  },
  Task_68496_Desc = {
    Text = "Abschluss „Herrliche Fantasie“ – Wahnsinnsmodus"
  },
  Task_68497_Desc = {
    Text = "Abschluss von „Zerfall der Menschlichkeit“ in einem beliebigen Modus"
  },
  Task_68498_Desc = {
    Text = "Abschluss von „Zerfall der Menschlichkeit“ im Wahnsinnsmodus"
  },
  Task_68499_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Tiefseeblick“ einmal gewinnen"
  },
  Task_68500_Desc = {
    Text = "Abschluss von „Auge der Götter“ in beliebigem Modus"
  },
  Task_68501_Desc = {
    Text = "Abschluss von „Zusammenbruch der Menschlichkeit“ in einem beliebigen Modus"
  },
  Task_68502_Desc = {
    Text = "Abschluss „Heimweh“ beliebiger Schwierigkeitsgrad"
  },
  Task_68503_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Tiefseeblick“ einmal gewinnen"
  },
  Task_68504_Desc = {
    Text = "Tiefseeblick · Wahnsinn"
  },
  Task_68505_Desc = {
    Text = "Abschluss von „Herrliche Fantasie“ in beliebiger Schwierigkeit"
  },
  Task_68506_Desc = {
    Text = "Abschluss von “Reich des Verfalls“ in beliebigem Modus"
  },
  Task_68507_Desc = {
    Text = "Aequor-Blick·Abschluss"
  },
  Task_68508_Desc = {
    Text = "Abschluss „Heimweh“ beliebiger Schwierigkeitsgrad"
  },
  Task_68509_Desc = {
    Text = "Abschluss von „Heimweh“ im Wahnsinnsmodus"
  },
  Task_68510_Desc = {
    Text = "Abschließen von “Reich des Verfalls“ in beliebigem Schwierigkeitsgrad"
  },
  Task_68511_Desc = {
    Text = "Abschluss von „Reich des Verfalls“ im Wahnsinnsmodus"
  },
  Task_68512_Desc = {
    Text = "Tiefseeblick·Grenzgebiet"
  },
  Task_68513_Desc = {
    Text = "Alle Aufgaben von „Tiefseeblick·Abschluss\" abschließen"
  },
  Task_68514_Desc = {
    Text = "Abschluss von „Auge der Götter“ in beliebigem Modus"
  },
  Task_68860_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_68860_Name = {Text = "1 Sieg"},
  Task_68861_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_68861_Name = {Text = "6 Siege"},
  Task_68862_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_68862_Name = {Text = "3 Siege"},
  Task_68863_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_68863_Name = {Text = "10 Siege"},
  Task_68864_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_68864_Name = {Text = "3 Siege"},
  Task_68865_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_68865_Name = {Text = "6 Siege"},
  Task_68866_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_68866_Name = {Text = "1 Sieg"},
  Task_68867_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_68867_Name = {Text = "10 Siege"},
  Task_69819_Desc = {
    Text = "Im Finalkampf in 35 Runden gewinnen"
  },
  Task_69819_Name = {
    Text = "Im Finalkampf innerhalb von 35 Runden gewinnen"
  },
  Task_70112_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im «Chaos der Begierde» einmal gewinnen"
  },
  Task_70113_Desc = {
    Text = "Abschluss „Jahresringe“ Wahnsinn-Schwierigkeitsgrad"
  },
  Task_70114_Desc = {
    Text = "Mit einem Erwecker des Tiefsee-Grenzgebiets im „Chaos der Begierde“ 2-mal gewinnen"
  },
  Task_70115_Desc = {
    Text = "Clear \"Junge Wurzel\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_70116_Desc = {
    Text = "Jede Schwierigkeit von \"Bestäubung\" beseitigen"
  },
  Task_70117_Desc = {
    Text = "Abschluss „Keim“ Wahnsinn-Schwierigkeitsgrad"
  },
  Task_70118_Desc = {
    Text = "Clear \"Sprouting\" auf jedem Schwierigkeitsgrad"
  },
  Task_70119_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker einmal im „Chaos der Begierde“ gewinnen."
  },
  Task_70120_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker im «Chaos der Begierde» 2-mal gewinnen"
  },
  Task_70121_Desc = {
    Text = "Chaotisches Verlangen · Wahnsinn"
  },
  Task_70122_Desc = {
    Text = "Abschluss von „Fallobst“ im Wahnsinnsmodus"
  },
  Task_70123_Desc = {
    Text = "Chaotisches Verlangen·Reich"
  },
  Task_70124_Desc = {
    Text = "Abschluss von „Bestäubung“ im Wahnsinnsmodus"
  },
  Task_70125_Desc = {
    Text = "Abschluss von „Kelchblatt“ im Wahnsinnsmodus"
  },
  Task_70126_Desc = {
    Text = "Clear \"Regeneration Flower\" auf jedem Schwierigkeitsgrad"
  },
  Task_70127_Desc = {
    Text = "Abschluss von „Wiedergeburt“ im Wahnsinnsmodus"
  },
  Task_70128_Desc = {
    Text = "Abschluss von „Keimung“ im Wahnsinnsmodus"
  },
  Task_70129_Desc = {
    Text = "Vollständig jede Schwierigkeit von \"Nektar-Drüse\""
  },
  Task_70130_Desc = {
    Text = "Clear \"Jahresring\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_70131_Desc = {
    Text = "Schließe \"Embryo Perle\" auf beliebiger Schwierigkeitsstufe ab"
  },
  Task_70132_Desc = {
    Text = "Schließe \"Gefallene Früchte\" auf beliebiger Schwierigkeitsstufe ab"
  },
  Task_70133_Desc = {
    Text = "通关“胚珠“癫狂难度"
  },
  Task_70134_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Chaos der Begierde“ zweimal gewinnen"
  },
  Task_70135_Desc = {
    Text = "Schließe \"Blüte\" auf beliebiger Schwierigkeitsstufe ab"
  },
  Task_70136_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Chaos der Begierde“ einmal gewinnen"
  },
  Task_70137_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im „Chaos der Begierde“ 2-mal gewinnen"
  },
  Task_70138_Desc = {
    Text = "Abschluss von „Polyembryonie“ im Wahnsinn-Schwierigkeitsgrad"
  },
  Task_70139_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im „Chaos der Begierde“ 1x gewinnen"
  },
  Task_70140_Desc = {
    Text = "Schließe \"Multiple Embryos\" auf beliebiger Schwierigkeit ab"
  },
  Task_70141_Desc = {
    Text = "Abschluss von „Nektardrüse“ im Wahnsinnsmodus"
  },
  Task_70307_Desc = {
    Text = "Im Finalkampf in 40 Runden gewinnen"
  },
  Task_70307_Name = {
    Text = "Im Finalkampf innerhalb von 40 Runden gewinnen"
  },
  Task_70446_Name = {
    Text = "Neu abgeschlossen 8-8"
  },
  Task_70447_Name = {
    Text = "Neu abgeschlossenes Level 8-4"
  },
  Task_70448_Name = {
    Text = "Neu abgeschlossene Nebenmissionen - Normal 12"
  },
  Task_70449_Name = {
    Text = "Neu abgeschlossene Nebenmissionen von Erica - Normal 3"
  },
  Task_70450_Name = {
    Text = "Neu abgeschlossen 3-14"
  },
  Task_70451_Name = {
    Text = "Neu abgeschlossene Nebenschauplätze - Normal 4"
  },
  Task_70452_Name = {
    Text = "Neu abgeschlossene Nebenschauplätze von Orla – Normal 9"
  },
  Task_70453_Name = {
    Text = "Neu abgeschlossene Nebenschauplätze von Ogil - Normal 4"
  },
  Task_70454_Name = {
    Text = "Neu abgeschlossen 2-16"
  },
  Task_70455_Name = {
    Text = "Neu abgeschlossen 2-15"
  },
  Task_70456_Name = {
    Text = "Neu abgeschlossene Nebenschauplätze von Orta - Normal 3"
  },
  Task_70457_Name = {
    Text = "Neu abgeschlossene Nebenmissionen - Normal 10"
  },
  Task_70458_Name = {
    Text = "Neu abgeschlossene Nebenmissionen - Normal 10"
  },
  Task_70459_Name = {
    Text = "Neu abgeschlossene Nebenschauplätze von Agrippa - Normal 5"
  },
  Task_70460_Name = {
    Text = "Neu abgeschlossenes Level 6-8"
  },
  Task_70461_Name = {
    Text = "Neu durchspielen 8-14"
  },
  Task_70462_Name = {
    Text = "Neu abgeschlossene Nebenschauplätze von Sorel - Normal 13"
  },
  Task_70463_Name = {
    Text = "Miryams Nebenschauplätze erneut abgeschlossen - Normal 15"
  },
  Task_70464_Name = {
    Text = "Neu abgeschlossen 8-7"
  },
  Task_70465_Name = {
    Text = "Neu abgeschlossen - Kapitel 7-2"
  },
  Task_70466_Name = {
    Text = "Kapitel 7-3 erneut abschließen"
  },
  Task_70467_Name = {
    Text = "Neu abgeschlossen 7-1"
  },
  Task_70468_Name = {
    Text = "Lilys Nebenschauplätze erneut abgeschlossen - Normal 7"
  },
  Task_70469_Name = {
    Text = "Neu abgeschlossene Nebenschauplätze von Benxi Ramona - Normal 4"
  },
  Task_70470_Name = {
    Text = "Neu abgeschlossen 1-8"
  },
  Task_70471_Name = {
    Text = "Neu abgeschlossene Nebenschauplätze von Benxi Luo - Normal 9"
  },
  Task_70472_Name = {
    Text = "Neu abgeschlossene Untersuchung 4-16"
  },
  Task_70473_Name = {
    Text = "Neu abgeschlossen 1-14"
  },
  Task_70474_Name = {
    Text = "Neu abgeschlossen 4-13"
  },
  Task_70475_Name = {
    Text = "Neu abgeschlossen 1-15"
  },
  Task_70476_Name = {
    Text = "Neu abgeschlossen 9-13"
  },
  Task_70477_Name = {
    Text = "Neu abgeschlossen 3-2"
  },
  Task_70478_Name = {
    Text = "Neu abgeschlossen 3-3"
  },
  Task_70479_Name = {
    Text = "Neu abgeschlossene Nebenmissionen - Normal 4"
  },
  Task_70480_Name = {
    Text = "Neu abgeschlossen 6-15"
  },
  Task_70481_Name = {
    Text = "Neu abgeschlossene Nebenmissionen von Golia - Normal 3"
  },
  Task_70482_Name = {
    Text = "5-12 erneut durchspielen"
  },
  Task_70483_Name = {
    Text = "Neu abgeschlossene Mission 6-10"
  },
  Task_70484_Name = {
    Text = "Neu abgeschlossene Nebenmissionen - Normal 9"
  },
  Task_70485_Name = {
    Text = "Wiederholter Abschluss des Nebenschauplatzes \"Vanda\" - Normal 4"
  },
  Task_70941_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_70941_Name = {
    Text = "Schnelle Lösung"
  },
  Task_70942_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_70942_Name = {
    Text = "Elegant und präzise"
  },
  Task_70943_Desc = {
    Text = "Ziehe mindestens 5 zusätzliche Karten in einem Zug während des Endkampfes"
  },
  Task_70943_Name = {Text = "Draw!"},
  Task_70944_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_70944_Name = {
    Text = "Energiesparmodus"
  },
  Task_70945_Desc = {
    Text = "Erhalte mindestens 1 Orison"
  },
  Task_70945_Name = {Text = "Seelenmark"},
  Task_70946_Desc = {
    Text = "Räume aus mit Leben nicht unter 50%"
  },
  Task_70946_Name = {
    Text = "Elegant und präzise"
  },
  Task_70947_Desc = {
    Text = "Abschluss mit mindestens 1 goldenen Schöpfung"
  },
  Task_70947_Name = {
    Text = "Geheimes Versteck"
  },
  Task_70948_Desc = {
    Text = "Habe nicht mehr als 2 Symptomkarten bei Abschluss"
  },
  Task_70948_Name = {
    Text = "Energiesparmodus"
  },
  Task_70949_Desc = {
    Text = "Trage mindestens 2 Relikte bei Abschluss"
  },
  Task_70949_Name = {
    Text = "Geheimes Versteck"
  },
  Task_70950_Desc = {
    Text = "Abschluss mit mindestens 1 goldenen Schöpfung"
  },
  Task_70950_Name = {
    Text = "Geheimes Versteck"
  },
  Task_70951_Desc = {
    Text = "Spiele mindestens 5 Karten in einem Zug während des Finalen Kampfes."
  },
  Task_70951_Name = {
    Text = "Ich bin dran!"
  },
  Task_70952_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_70952_Name = {
    Text = "Schnelle Lösung"
  },
  Task_70953_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_70953_Name = {
    Text = "Schnelle Lösung"
  },
  Task_70954_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_70954_Name = {
    Text = "Schnelle Lösung"
  },
  Task_70955_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_70955_Name = {
    Text = "Schnelle Lösung"
  },
  Task_70956_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_70956_Name = {
    Text = "Schnelle Lösung"
  },
  Task_70957_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_70957_Name = {
    Text = "Schnelle Lösung"
  },
  Task_70958_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_70958_Name = {
    Text = "Schnelle Lösung"
  },
  Task_70959_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_70959_Name = {
    Text = "Schnelle Lösung"
  },
  Task_70960_Desc = {
    Text = "Gewinne die Endschlacht innerhalb von 10 Zügen"
  },
  Task_70960_Name = {
    Text = "Schnelle Lösung"
  },
  Task_71343_Desc = {
    Text = "Abschluss von „Katastrophe“ im Wahnsinnsmodus"
  },
  Task_71344_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Tor der Leere“ einmal gewinnen"
  },
  Task_71345_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker zweimal im „Tor der Leere“ gewinnen"
  },
  Task_71346_Desc = {
    Text = "Absolvieren von „Glänzende Vernichtung“ im beliebigen Modus"
  },
  Task_71347_Desc = {
    Text = "Abschluss von „Katastrophe“ in beliebigem Modus"
  },
  Task_71348_Desc = {
    Text = "Abschluss von „Chaosprognose“ in einem beliebigen Modus"
  },
  Task_71349_Desc = {
    Text = "Tor des Nichts·Grenzgebiet"
  },
  Task_71350_Desc = {
    Text = "Abschluss von „Puppenhaus“ in beliebigem Modus"
  },
  Task_71351_Desc = {
    Text = "Abschluss von „Stern“ im Wahnsinnsmodus"
  },
  Task_71352_Desc = {
    Text = "Abschluss von „Katastrophe“ in beliebigem Modus"
  },
  Task_71353_Desc = {
    Text = "Abschluss von “Glänzende Vernichtung“ in beliebigem Schwierigkeitsgrad"
  },
  Task_71354_Desc = {
    Text = "Abschließen des “Tanzfest“-Modus in beliebiger Schwierigkeit"
  },
  Task_71355_Desc = {
    Text = "Tor des Nichts · Wahnsinn"
  },
  Task_71356_Desc = {
    Text = "Abschluss von „Puppenspiel-Linie“ in beliebigem Modus"
  },
  Task_71357_Desc = {
    Text = "Abschluss von “Wahrheitsgift“ in beliebigem Schwierigkeitsgrad"
  },
  Task_71358_Desc = {
    Text = "Abschluss von „Puppenspiel-Linie“ im Wahnsinnsmodus"
  },
  Task_71359_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker zweimal im „Tor der Leere“ gewinnen"
  },
  Task_71360_Desc = {
    Text = "Abschluss von „Chaosprognose“ im beliebigen Modus"
  },
  Task_71361_Desc = {
    Text = "Abschluss „Einladung“ Wahnsinn-Schwierigkeitsgrad"
  },
  Task_71362_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker im “Tor der Leere“ 2-mal gewinnen"
  },
  Task_71363_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker im “Tor der Leere“ 1 Mal gewinnen"
  },
  Task_71364_Desc = {
    Text = "Nichtstor·Abschluss"
  },
  Task_71365_Desc = {
    Text = "Alle Erfolge von „Nichtigkeits-Tor: Durchgespielt“ abschließen"
  },
  Task_71366_Desc = {
    Text = "Abschließen von “Glänzende Vernichtung“ im Wahnsinnsmodus"
  },
  Task_71367_Desc = {
    Text = "Abschluss „Wahrheitsgift“ Wahnsinn-Modus"
  },
  Task_71368_Desc = {
    Text = "Abschluss von „Puppenspiel-Linie“ in beliebigem Modus"
  },
  Task_71369_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Tor der Leere“ einmal gewinnen"
  },
  Task_71370_Desc = {
    Text = "Durchspielen von “Puppenhaus“ im Wahnsinnsmodus"
  },
  Task_71373_Desc = {
    Text = "Abschluss von „Stern“ in beliebigem Modus"
  },
  Task_71374_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Tor der Leere“ zweimal gewinnen"
  },
  Task_71375_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Tor der Leere“ einmal gewinnen"
  },
  Task_71376_Desc = {
    Text = "Abschließen des “Tanzfest“-Modus in beliebiger Schwierigkeit"
  },
  Task_71377_Desc = {
    Text = "Beliebigen Schwierigkeitsgrad von „Puppenhaus“ abschließen"
  },
  Task_71378_Desc = {
    Text = "Abschluss von „Sterne“ in beliebigem Modus"
  },
  Task_71379_Desc = {
    Text = "Abschluss „Einladung“ beliebiger Schwierigkeitsgrad"
  },
  Task_71380_Desc = {
    Text = "Abschluss von „Chaosprognose“ im Wahnsinnsmodus"
  },
  Task_71381_Desc = {
    Text = "Abschluss von “Tanzveranstaltung“ im Wahnsinnsmodus"
  },
  Task_71382_Desc = {
    Text = "Abschließen von „Wahrheitsgift“ in beliebiger Schwierigkeit"
  },
  Task_71385_Desc = {
    Text = "Abschluss von „Einladung“ in beliebigem Modus"
  },
  Task_71757_Desc = {
    Text = "Abschließen der „Komödie der Masken“ im Wahnsinnsmodus"
  },
  Task_71758_Desc = {
    Text = "Clear \"Plot Twist\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_71759_Desc = {
    Text = "Abschließen der „Stillen Phase“ im Wahnsinnsmodus"
  },
  Task_71760_Desc = {
    Text = "Vollständig \"Ruhiger Moment\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_71761_Desc = {
    Text = "Absolvieren von „Katharsis“ im Wahnsinnsmodus"
  },
  Task_71762_Desc = {
    Text = "\"Arc Theory\" auf jeder Schwierigkeit erfolgreich abschließen"
  },
  Task_71763_Desc = {
    Text = "Abschluss von „Episodenrotation“ im Wahnsinnsmodus"
  },
  Task_71764_Desc = {
    Text = "Abschluss von „Fremdheitseffekt“ im Wahnsinnsmodus"
  },
  Task_71765_Desc = {
    Text = "Abschluss der „Einheit“-Mission im Wahnsinn-Schwierigkeitsgrad"
  },
  Task_71766_Desc = {
    Text = "Clear \"Trinity\" auf jedem Schwierigkeitsgrad"
  },
  Task_71767_Desc = {
    Text = "Cleare \"Katharsis\" bei beliebiger Schwierigkeit"
  },
  Task_71768_Desc = {
    Text = "Schließe \"Maskierte Komödie\" auf beliebiger Schwierigkeit ab"
  },
  Task_71769_Desc = {
    Text = "Abschluss von „Die vierte Wand des Theaters“ im Wahnsinnsmodus"
  },
  Task_71770_Desc = {
    Text = "Clear \"Die vierte Wand des Dramas\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_71771_Desc = {
    Text = "Vollständig \"Strangeness Effekt\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_71772_Desc = {
    Text = "Absolviere “Arkustheorie“ im Wahnsinnsmodus"
  },
  Task_71773_Desc = {
    Text = "Absolvieren von „Dramaturgische Pyramide“ im Wahnsinnsmodus"
  },
  Task_71774_Desc = {
    Text = "Schließe \"Dramatiker-Pyramide\" auf beliebiger Schwierigkeit ab"
  },
  Task_71775_Desc = {
    Text = "Schriftmysterium·Wahnsinn"
  },
  Task_71795_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_71795_Name = {
    Text = "2800 Punkte"
  },
  Task_71796_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_71796_Name = {
    Text = "2700 Punkte"
  },
  Task_71797_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_71797_Name = {
    Text = "2900 Punkte"
  },
  Task_71798_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_71798_Name = {
    Text = "2600 Punkte"
  },
  Task_71799_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_71799_Name = {
    Text = "2300 Punkte"
  },
  Task_71800_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_71800_Name = {
    Text = "2400 Punkte"
  },
  Task_71801_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_71801_Name = {
    Text = "2500 Punkte"
  },
  Task_71802_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_71802_Name = {
    Text = "1900 Punkte"
  },
  Task_71803_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_71803_Name = {
    Text = "2000 Punkte"
  },
  Task_71804_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_71804_Name = {
    Text = "2100 Punkte"
  },
  Task_71805_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_71805_Name = {
    Text = "2200 Punkte"
  },
  Task_71806_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_71806_Name = {
    Text = "3000 Punkte"
  },
  Task_71807_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_71807_Name = {
    Text = "1600 Punkte"
  },
  Task_71808_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_71808_Name = {
    Text = "1700 Punkte"
  },
  Task_71809_Desc = {
    Text = "Höchste Punktzahl erreicht"
  },
  Task_71809_Name = {
    Text = "1800 Punkte"
  },
  Task_71819_Desc = {
    Text = "Schließe \"Finale\" auf beliebiger Schwierigkeitsstufe ab"
  },
  Task_71820_Desc = {
    Text = "Schließe \"Gesicht\" auf beliebiger Schwierigkeitsstufe ab"
  },
  Task_71821_Desc = {
    Text = "Vollständig \"Onkel Lange Beine\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_71822_Desc = {
    Text = "Schließe \"Blick\" auf beliebiger Schwierigkeitsstufe ab"
  },
  Task_71823_Desc = {
    Text = "Schließe \"Puppen-Spiel\" auf beliebiger Schwierigkeit ab"
  },
  Task_71824_Desc = {
    Text = "Clear \"Unvollendetes Skript\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_71825_Desc = {
    Text = "Vollständig \"Rosenecke\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_71826_Desc = {
    Text = "Schließe \"Fische unter dem Kessel\" auf beliebiger Schwierigkeitsstufe ab"
  },
  Task_71827_Desc = {
    Text = "Vollständig \"Geschenk\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_71867_Desc = {
    Text = "Besitze 5/6/7/8 Artefakte, erhalte 250/500/750/1000 Punkte."
  },
  Task_71867_Name = {
    Text = "Realitätskollektion<size=20><color=#747474>Besitze 8 Relikte</color></size>"
  },
  Task_71868_Desc = {
    Text = "Bei jedem Gebrauch von 1 Mal Muskelgedächtnis sinkt die Untersuchungsbewertung um 20 %."
  },
  Task_71868_Name = {
    Text = "Somnambulist<size=20><color=#747474>Bei jedem Gebrauch von Muskelgedächtnis sinkt die Untersuchungsbewertung um 20 %</color></size>"
  },
  Task_71934_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71935_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71936_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71937_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71939_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71940_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71941_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71942_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71943_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71944_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71945_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71946_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71947_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71948_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71949_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71950_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71952_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71953_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71954_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71955_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71977_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71978_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71980_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_71981_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_72038_Name = {
    Text = "图鲁支线关卡重新通关 - 普通 4"
  },
  Task_72039_Desc = {
    Text = "Abschluss von „Blick“ im Wahnsinnsmodus"
  },
  Task_72040_Desc = {
    Text = "Durchspielen von “Fisch im leeren Topf“ im Wahnsinnsmodus"
  },
  Task_72041_Desc = {
    Text = "Absolvieren von „Puppenspiel“ im Wahnsinnsmodus"
  },
  Task_72042_Desc = {
    Text = "Abschluss von „Geschenk“ im Wahnsinnsmodus"
  },
  Task_72043_Desc = {
    Text = "Abschluss von Spezialeinsatzprotokoll „Erinnerungen der Rose“"
  },
  Task_72044_Desc = {
    Text = "Abschließen von “Onkel Langbein“ im Wahnsinnsmodus"
  },
  Task_72045_Desc = {
    Text = "Abschluss von „Unvollendetes Drehbuch“ im Wahnsinnsmodus"
  },
  Task_72046_Desc = {
    Text = "Abschluss von „Rosenwinkel“ im Wahnsinnsmodus"
  },
  Task_72047_Desc = {
    Text = "Abschluss von „Gesicht“ im Wahnsinnsmodus"
  },
  Task_72048_Desc = {
    Text = "Vollständig \"Finale\" auf Wahnsinn-Schwierigkeit"
  },
  Task_72049_Desc = {
    Text = "Erinnerungen der Rose · Wahnsinn"
  },
  Task_72245_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72245_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72386_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72386_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72387_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72387_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72389_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72389_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72390_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72390_UnlockCondDesc = {
    Text = "Nachdem “Runde umkehren: Der Moment des umkehrbaren Universums“ abgeschlossen ist, wird diese Funktion freigeschaltet. Möchtest du zu “Runde umkehren“ wechseln?"
  },
  Task_72391_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72391_UnlockCondDesc = {
    Text = "Nach Abschluss von “Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu “Runde umkehren“ gehen?"
  },
  Task_72392_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72392_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72393_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72393_UnlockCondDesc = {
    Text = "Nachdem du “Runde umkehren: Der Moment des umkehrbaren Universums“ abgeschlossen hast, wird diese Funktion freigeschaltet. Möchtest du zu “Runde umkehren“ wechseln?"
  },
  Task_72394_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72394_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72395_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72395_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72396_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72396_UnlockCondDesc = {
    Text = "Nach Abschluss von “Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu “Runde umkehren“ gehen?"
  },
  Task_72416_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72416_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72420_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72420_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72540_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72540_UnlockCondDesc = {
    Text = "Nachdem du “Runde umkehren: Der Moment des umkehrbaren Universums“ abgeschlossen hast, wird diese Funktion freigeschaltet. Möchtest du zu “Runde umkehren“ wechseln?"
  },
  Task_72541_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72541_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72542_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72542_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72545_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72545_UnlockCondDesc = {
    Text = "Nach Abschluss von “Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu “Runde umkehren“ gehen?"
  },
  Task_72546_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72546_UnlockCondDesc = {
    Text = "Nach Abschluss von “Runde umkehren: Der Moment der umkehrbaren Welt“ freigeschaltet. Möchtest du zu “Runde umkehren“ gehen?"
  },
  Task_72547_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72547_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72548_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72548_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72549_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72549_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72632_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72632_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72652_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72652_UnlockCondDesc = {
    Text = "Nach Abschluss von “Runde umkehren: Der Gast aus einer anderen Welt“ freigeschaltet. Möchtest du zu “Runde umkehren“ gehen?"
  },
  Task_72677_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72677_UnlockCondDesc = {
    Text = "Nach Abschluss von “Runde umkehren: Der Gast aus einer anderen Welt“ freigeschaltet. Möchtest du zu “Runde umkehren“ gehen?"
  },
  Task_72678_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72678_UnlockCondDesc = {
    Text = "Nach Abschluss von “Runde umkehren: Der Gast aus einer anderen Welt“ freigeschaltet. Möchtest du zu “Runde umkehren“ gehen?"
  },
  Task_72679_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72679_UnlockCondDesc = {
    Text = "Nach Abschluss von “Runde umkehren: Der Gast aus einer anderen Welt“ freigeschaltet. Möchtest du zu “Runde umkehren“ gehen?"
  },
  Task_72681_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72681_UnlockCondDesc = {
    Text = "Nach Abschluss von “Runde umkehren: Der Gast aus einer anderen Welt“ freigeschaltet. Möchtest du zu “Runde umkehren“ gehen?"
  },
  Task_72682_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72682_UnlockCondDesc = {
    Text = "Nach Abschluss von “Runde umkehren: Der Gast aus einer anderen Welt“ freigeschaltet. Möchtest du zu “Runde umkehren“ gehen?"
  },
  Task_72683_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72683_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Gast aus einer anderen Welt“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72684_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72684_UnlockCondDesc = {
    Text = "Nach Abschluss von “Runde umkehren: Der Gast aus einer anderen Welt“ freigeschaltet. Möchtest du zu “Runde umkehren“ gehen?"
  },
  Task_72685_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72685_UnlockCondDesc = {
    Text = "Nach Abschluss von “Runde umkehren: Der Gast aus einer anderen Welt“ freigeschaltet. Möchtest du zu “Runde umkehren“ gehen?"
  },
  Task_72700_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72700_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72701_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72701_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72703_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72703_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72704_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72704_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72705_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72705_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72706_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72706_UnlockCondDesc = {
    Text = "Nach Abschluss von “Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu “Runde umkehren“ gehen?"
  },
  Task_72707_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72707_UnlockCondDesc = {
    Text = "Nach Abschluss von “Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu “Runde umkehren“ gehen?"
  },
  Task_72709_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72709_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72773_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72773_UnlockCondDesc = {
    Text = "Nach Abschluss von “Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu “Runde umkehren“ gehen?"
  },
  Task_72790_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72790_UnlockCondDesc = {
    Text = "Nach Abschluss von “Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu “Runde umkehren“ gehen?"
  },
  Task_72798_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72798_UnlockCondDesc = {
    Text = "Nach Abschluss von “Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu “Runde umkehren“ gehen?"
  },
  Task_72799_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72799_UnlockCondDesc = {
    Text = "Nach Abschluss von “Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu “Runde umkehren“ gehen?"
  },
  Task_72800_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72800_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72801_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72801_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72802_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72802_UnlockCondDesc = {
    Text = "Nach Abschluss von „Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu „Runde umkehren“ gehen?"
  },
  Task_72803_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72803_UnlockCondDesc = {
    Text = "Nach Abschluss von “Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu “Runde umkehren“ gehen?"
  },
  Task_72805_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72805_UnlockCondDesc = {
    Text = "Nach Abschluss von “Runde umkehren: Der Moment des umkehrbaren Ereignisses“ freigeschaltet. Möchtest du zu “Runde umkehren“ gehen?"
  },
  Task_72806_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72806_UnlockCondDesc = {
    Text = "Nach Abschluss von “Runde umkehren: Der Moment des umkehrbaren Universums“ freigeschaltet. Möchtest du zu “Runde umkehren“ gehen?"
  },
  Task_72807_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_72807_UnlockCondDesc = {
    Text = "Nachdem du “Runde umkehren: Der Moment des umgekehrten Universums“ abgeschlossen hast, wird diese Funktion freigeschaltet. Möchtest du zu “Runde umkehren“ wechseln?"
  },
  Task_72957_Desc = {
    Text = "Verwende „Schmerz überschreiten“, um 3 Siege zu erringen"
  },
  Task_72958_Desc = {
    Text = "Verwende “Missgestalteter Rückenschlag“, um einen Sieg zu erzielen"
  },
  Task_72959_Desc = {
    Text = "Verwende “Kernschmelze“, um 3 Siege zu erzielen"
  },
  Task_72961_Desc = {
    Text = "Verwende “35-mm-Magie“, um 1x zu gewinnen"
  },
  Task_72963_Desc = {
    Text = "Verwende das “Gebot der Königin“, um 3 Siege zu erringen"
  },
  Task_72965_Desc = {
    Text = "Verwende das “Auge der millionenfachen Gunst“, um einen Sieg zu erringen"
  },
  Task_72968_Desc = {
    Text = "Verwende „Auftreten“, um 1 Sieg zu erringen"
  },
  Task_72973_Desc = {
    Text = "Verwende “Lily“, um einen Sieg zu erringen"
  },
  Task_72975_Desc = {
    Text = "Verwende “Brüllendes Blut und Sand“, um 3 Siege zu erringen"
  },
  Task_72976_Desc = {
    Text = "Verwende “Kostbarste Sammlung“, um 3 Siege zu erringen"
  },
  Task_72977_Desc = {
    Text = "Verwende das “verborgene Rad“, um 3 Siege zu erringen"
  },
  Task_72978_Desc = {
    Text = "Verwende “Information ist Leben“, um 3 Siege zu erringen"
  },
  Task_72980_Desc = {
    Text = "Verwende „Liz“, um 1 Sieg zu erzielen"
  },
  Task_72982_Desc = {
    Text = "Verwende “Jenseits des Todes“, um 3 Siege zu erringen"
  },
  Task_72983_Desc = {
    Text = "Verwende “Blick über den See“, um einen Sieg zu erringen"
  },
  Task_72986_Desc = {
    Text = "Verwende “Riesenschwert“, um einen Sieg zu erringen"
  },
  Task_72989_Desc = {
    Text = "Verwende «Ogier», um 3 Siege zu erringen"
  },
  Task_72990_Desc = {
    Text = "Verwende “Schluckendes Wiegenlied“, um einen Sieg zu erringen"
  },
  Task_72992_Desc = {
    Text = "Verwende “Kipppunkt“, um einen Sieg zu erringen"
  },
  Task_72993_Desc = {
    Text = "Verwende “Brief an einen engen Freund“, um 1x zu gewinnen"
  },
  Task_72994_Desc = {
    Text = "Verwende “Vergängliche Ewigkeit“, um einen Sieg zu erringen"
  },
  Task_72995_Desc = {
    Text = "Verwende “Tod der Korallenfrau“, um einen Sieg zu erringen"
  },
  Task_72997_Desc = {
    Text = "Verwende „Oreta“, um 3x zu gewinnen"
  },
  Task_72999_Desc = {
    Text = "Verwende „Sieg der Rose“, um 3 Siege zu erringen."
  },
  Task_73001_Desc = {
    Text = "Erziele mithilfe von “Gunst“ 1 Sieg"
  },
  Task_73003_Desc = {
    Text = "Verwende den “Blick von Isarau“, um 3 Siege zu erringen"
  },
  Task_73004_Desc = {
    Text = "Verwende den “Herrenstab“, um einen Sieg zu erringen"
  },
  Task_73006_Desc = {
    Text = "Verwende “Glückliche Zeit“, um 3 Siege zu erringen"
  },
  Task_73007_Desc = {
    Text = "Verwende “Agrippa“, um 3 Siege zu erringen"
  },
  Task_73009_Desc = {
    Text = "Verwende “Bis der Schneeberg schmilzt“, um einen Sieg zu erringen"
  },
  Task_73011_Desc = {
    Text = "Verwende “Herzbarriere“, um einen Sieg zu erringen"
  },
  Task_73012_Desc = {
    Text = "Verwende «Miryam», um 3 Siege zu erringen."
  },
  Task_73014_Desc = {
    Text = "Verwende “Hamlin“, um 1 Mal zu gewinnen"
  },
  Task_73015_Desc = {
    Text = "Verwende “Meerestraum“, um 3 Siege zu erzielen"
  },
  Task_73016_Desc = {
    Text = "Verwende «Delirium», um einen Sieg zu erringen"
  },
  Task_73018_Desc = {
    Text = "Verwende “Frohes Zaubertheater“, um einen Sieg zu erringen"
  },
  Task_73019_Desc = {
    Text = "Verwende “Gereift“, um einen Sieg zu erringen"
  },
  Task_73021_Desc = {
    Text = "Verwende “reines Silber der ursprünglichen Absicht“, um einen Sieg zu erringen"
  },
  Task_73022_Desc = {
    Text = "Verwende „Puppe“, um 1x zu gewinnen"
  },
  Task_73025_Desc = {
    Text = "Verwende “Gemurmel“, um 1 Sieg zu erzielen"
  },
  Task_73026_Desc = {
    Text = "Verwende “Aktiv“, um 1 Sieg zu erzielen"
  },
  Task_73028_Desc = {
    Text = "Verwende “Daphdel“, um 1x zu gewinnen"
  },
  Task_73030_Desc = {
    Text = "Verwende «Winkel», um 3x zu gewinnen"
  },
  Task_73033_Desc = {
    Text = "Verwende “Versinken in Scharlach“, um einen Sieg zu erringen"
  },
  Task_73037_Desc = {
    Text = "Verwende “Tag der befreiten Ketten“, um 3 Siege zu erringen"
  },
  Task_73039_Desc = {
    Text = "Verwende “Winternachtserinnerung“, um einen Sieg zu erringen"
  },
  Task_73041_Desc = {
    Text = "Verwende “verborgene Geburt“, um einen Sieg zu erringen"
  },
  Task_73044_Desc = {
    Text = "Verwende “Ryker“, um 3 Siege zu erzielen"
  },
  Task_73045_Desc = {
    Text = "1 Sieg mit „Schmelzende Blüte“ erzielen"
  },
  Task_73047_Desc = {
    Text = "Verwende «Fient», um einen Sieg zu erringen."
  },
  Task_73048_Desc = {
    Text = "Verwende “Thais“, um 3 Siege zu erringen"
  },
  Task_73050_Desc = {
    Text = "Verwende “Aigis“, um dreimal zu siegen"
  },
  Task_73051_Desc = {
    Text = "Verwende „Oreta“, um einen Sieg zu erringen."
  },
  Task_73052_Desc = {
    Text = "Verwende “Sanga“, um 1 Sieg zu erzielen"
  },
  Task_73053_Desc = {
    Text = "Verwende „Murphy“, um 1x zu gewinnen"
  },
  Task_73054_Desc = {
    Text = "Verwende “Tawil“, um 3 Siege zu erzielen"
  },
  Task_73055_Desc = {
    Text = "Verwende “Puppe“, um 3x zu gewinnen"
  },
  Task_73056_Desc = {
    Text = "Verwende „Salvador“, um 1x zu gewinnen"
  },
  Task_73057_Desc = {
    Text = "Verwende das “einzigartige Saatgut“, um 3-mal zu siegen"
  },
  Task_73059_Desc = {
    Text = "Verwende “Entschlossenheit der Schellfischs“, um 3 Siege zu erringen"
  },
  Task_73061_Desc = {
    Text = "Verwende “Schneiden und Schaden“, um 3 Siege zu erringen"
  },
  Task_73063_Desc = {
    Text = "Verwende “Barmherzige Ernährung“, um einen Sieg zu erringen"
  },
  Task_73064_Desc = {
    Text = "Verwende “Strafe“, um 3 Siege zu erzielen"
  },
  Task_73066_Desc = {
    Text = "Verwende “Glücksrad“, um 3 Siege zu erringen"
  },
  Task_73067_Desc = {
    Text = "Verwende “Pandia“, um einen Sieg zu erringen"
  },
  Task_73068_Desc = {
    Text = "Verwende “Alle ihre Teile“, um einen Sieg zu erringen"
  },
  Task_73070_Desc = {
    Text = "Verwende “Raubtier des Riesen“, um dreimal zu siegen"
  },
  Task_73073_Desc = {
    Text = "Verwende “Ramona“, um 3 Siege zu erringen"
  },
  Task_73074_Desc = {
    Text = "Verwende „Zeilenende des Gedichts“, um 1 Sieg zu erzielen"
  },
  Task_73075_Desc = {
    Text = "Verwende “Blasser Abkömmling“, um 3 Siege zu erringen"
  },
  Task_73077_Desc = {
    Text = "Verwende “Wanda“, um einen Sieg zu erringen"
  },
  Task_73081_Desc = {
    Text = "Verwende “fromme Macht“, um einen Sieg zu erringen"
  },
  Task_73082_Desc = {
    Text = "Verwende “Speicherspirale“, um einen Sieg zu erringen"
  },
  Task_73083_Desc = {
    Text = "Verwende das “Zeitkreis-Chronometer“, um 3 Siege zu erzielen"
  },
  Task_73085_Desc = {
    Text = "Verwende “Orla“, um einen Sieg zu erringen"
  },
  Task_73086_Desc = {
    Text = "Verwende “Moment der Begegnung“, um einen Sieg zu erringen"
  },
  Task_73087_Desc = {
    Text = "Verwende “Stilles Gelage“, um 3 Siege zu erringen"
  },
  Task_73088_Desc = {
    Text = "Verwende “Im Regensturm“, um einen Sieg zu erringen"
  },
  Task_73089_Desc = {
    Text = "Verwende „Lotan“, um einen Sieg zu erzielen"
  },
  Task_73090_Desc = {
    Text = "Verwende “Blutiges Gelage“, um einen Sieg zu erringen"
  },
  Task_73095_Desc = {
    Text = "Verwende „Karen“, um einen Sieg zu erzielen"
  },
  Task_73097_Desc = {
    Text = "Verwende “Wogende Begierde“, um einen Sieg zu erringen"
  },
  Task_73098_Desc = {
    Text = "Verwende “Casja“, um 1 Mal zu gewinnen"
  },
  Task_73099_Desc = {
    Text = "Verwende “Mittsommernachtstraum“, um einen Sieg zu erringen"
  },
  Task_73100_Desc = {
    Text = "Verwende “Sorel“, um 3 Siege zu erzielen"
  },
  Task_73102_Desc = {
    Text = "Verwende “Hymne des Götterkönigs“, um einen Sieg zu erringen"
  },
  Task_73105_Desc = {
    Text = "Verwende “Ungleicher Austausch“, um 3 Siege zu erringen"
  },
  Task_73107_Desc = {
    Text = "Verwende “Herz des Ritters“, um einen Sieg zu erringen"
  },
  Task_73109_Desc = {
    Text = "Verwende “Fluchfessel“, um 3 Siege zu erringen"
  },
  Task_73110_Desc = {
    Text = "Verwende “Salvador“, um 3 Siege zu erringen"
  },
  Task_73111_Desc = {
    Text = "Verwende “Sternentier“, um 3 Siege zu erringen"
  },
  Task_73117_Desc = {
    Text = "Verwende „Kuss des Verderbens“, um einen Sieg zu erringen"
  },
  Task_73118_Desc = {
    Text = "Verwende „Oretas Schatz“, um 1 Sieg zu erringen"
  },
  Task_73120_Desc = {
    Text = "Verwende “Fabel vom Taotie», um einen Sieg zu erringen"
  },
  Task_73122_Desc = {
    Text = "Verwende „Ringfahrt – Ramona“, um 3 Siege zu erringen"
  },
  Task_73123_Desc = {
    Text = "Verwende “letzter Schwur“, um einen Sieg zu erringen"
  },
  Task_73124_Desc = {
    Text = "Verwende “Verbannung“, um 3 Siege zu erringen"
  },
  Task_73126_Desc = {
    Text = "Verwende “Gunst“, um einen Sieg zu erzielen"
  },
  Task_73128_Desc = {
    Text = "Verwende “Gier“, um dreimal zu siegen"
  },
  Task_73129_Desc = {
    Text = "Verwende „Caecus“, um 1x zu gewinnen"
  },
  Task_73130_Desc = {
    Text = "Verwende “Tor der Wahrheit“, um 3 Siege zu erzielen"
  },
  Task_73131_Desc = {
    Text = "Verwende “Im Namen der Rose“, um 1 Mal zu gewinnen"
  },
  Task_73134_Desc = {
    Text = "Verwende «Erica», um 3 Siege zu erringen"
  },
  Task_73136_Desc = {
    Text = "Verwende “Zergliederung des Todes“, um 3 Siege zu erringen"
  },
  Task_73138_Desc = {
    Text = "Verwende “Tinkter“, um 3-mal zu siegen"
  },
  Task_73139_Desc = {
    Text = "Verwende „flüchtige Ewigkeit“, um 3 Siege zu erringen"
  },
  Task_73140_Desc = {
    Text = "Verwende «Pflichtbewusstsein», um 3 Siege zu erringen"
  },
  Task_73141_Desc = {
    Text = "Verwende “Erkenntnis“, um 1 Sieg zu erzielen"
  },
  Task_73144_Desc = {
    Text = "Verwende das “Riesenschwert“, um 3 Siege zu erringen"
  },
  Task_73147_Desc = {
    Text = "Verwende “unaufhörliches Konzert“, um 3 Siege zu erringen"
  },
  Task_73148_Desc = {
    Text = "Verwende “Schlaf unter dem Gletscher“, um 3 Siege zu erringen"
  },
  Task_73150_Desc = {
    Text = "Verwende “Lily“, um 3 Siege zu erzielen"
  },
  Task_73151_Desc = {
    Text = "Verwende “Rosen-Sieg“, um einen Sieg zu erringen"
  },
  Task_73152_Desc = {
    Text = "Verwende “Grauer Nebel – Wahres Antlitz“, um 3 Siege zu erringen"
  },
  Task_73153_Desc = {
    Text = "Verwende “Tulu“, um einen Sieg zu erringen"
  },
  Task_73154_Desc = {
    Text = "Gewinne 1-mal mit “Hoffnung“"
  },
  Task_73156_Desc = {
    Text = "Verwende „Leigh“, um 3 Siege zu erzielen"
  },
  Task_73157_Desc = {
    Text = "Verwende “Bevorzugung“, um 3 Siege zu erzielen"
  },
  Task_73161_Desc = {
    Text = "Verwende “Ningphia“, um 3 Siege zu erringen"
  },
  Task_73162_Desc = {
    Text = "Verwende “Wahnsinn“, um 3 Siege zu erzielen"
  },
  Task_73165_Desc = {
    Text = "Verwende “Nicht-Ort“, um 1 Sieg zu erringen"
  },
  Task_73166_Desc = {
    Text = "Verwende «Falo», um 3 Siege zu erringen"
  },
  Task_73167_Desc = {
    Text = "Gewinne 1x mit “Helot“"
  },
  Task_73170_Desc = {
    Text = "Verwende “Tulu“, um 3 Siege zu erringen"
  },
  Task_73172_Desc = {
    Text = "Verwende “Saugen“, um 3-mal zu siegen"
  },
  Task_73173_Desc = {
    Text = "Verwende “Segel des Ruders“, um einen Sieg zu erringen"
  },
  Task_73174_Desc = {
    Text = "Verwende “Moment der Begegnung“, um 3 Siege zu erringen"
  },
  Task_73176_Desc = {
    Text = "Verwende “Celest“, um einen Sieg zu erringen"
  },
  Task_73177_Desc = {
    Text = "Verwende “Shan“, um 3 Siege zu erzielen"
  },
  Task_73178_Desc = {
    Text = "Verwende “Einsicht“, um einen Sieg zu erringen"
  },
  Task_73180_Desc = {
    Text = "Verwende “Ewiges Requiem“, um 3 Siege zu erringen"
  },
  Task_73181_Desc = {
    Text = "Verwende “Unlösbare Berechnung“, um 3 Siege zu erringen"
  },
  Task_73182_Desc = {
    Text = "Verwende “Agrippa“, um 1 Mal zu gewinnen"
  },
  Task_73183_Desc = {
    Text = "Verwende “Gefesseltes Lied“, um 3 Siege zu erringen"
  },
  Task_73185_Desc = {
    Text = "Verwende “Polarnacht und Morgenröte“, um 3 Siege zu erringen"
  },
  Task_73186_Desc = {
    Text = "Verwende “Konzentrierter Geist“, um einen Sieg zu erzielen"
  },
  Task_73189_Desc = {
    Text = "Verwende „Menschliche Marionette, die ins Nichts fällt“, um 3 Siege zu erzielen."
  },
  Task_73192_Desc = {
    Text = "Verwende „Im Schatten der Nacht“, um einen Sieg zu erringen"
  },
  Task_73193_Desc = {
    Text = "Verwende «Gedächtnissyndrom», um einen Sieg zu erringen"
  },
  Task_73197_Desc = {
    Text = "Verwende “Vergessene Hand“, um 3 Siege zu erzielen"
  },
  Task_73200_Desc = {
    Text = "Verwende “Abenteuerlicher Proviant“, um einen Sieg zu erringen"
  },
  Task_73204_Desc = {
    Text = "Verwende “Blutkette · Helot“, um 3 Siege zu erringen"
  },
  Task_73206_Desc = {
    Text = "Verwende “Schluckendes Wiegenlied“, um 3 Siege zu erringen"
  },
  Task_73208_Desc = {
    Text = "Erziele 3 Siege mit “Schmelzende Blüte: Dohl“"
  },
  Task_73209_Desc = {
    Text = "Verwende “Tod der Korallenfrau“, um 3 Siege zu erringen"
  },
  Task_73210_Desc = {
    Text = "Verwende “Ogier“, um 1 Mal zu siegen"
  },
  Task_73212_Desc = {
    Text = "Verwende “milde Pflege“, um 3 Siege zu erringen"
  },
  Task_73213_Desc = {
    Text = "Verwende “Kipppunkt“, um 3 Siege zu erringen"
  },
  Task_73214_Desc = {
    Text = "Verwende “Brief an einen engen Freund“, um 3 Siege zu erzielen"
  },
  Task_73216_Desc = {
    Text = "Verwende „Versinken in Scharlach“, um 3 Siege zu erringen."
  },
  Task_73217_Desc = {
    Text = "Verwende “Schnitt und Schaden“, um einen Sieg zu erringen"
  },
  Task_73218_Desc = {
    Text = "Verwende “Graues Nebel wahres Antlitz“, um 1x zu gewinnen"
  },
  Task_73219_Desc = {
    Text = "Verwende “Stimme im Kopf“, um 3 Siege zu erringen"
  },
  Task_73220_Desc = {
    Text = "Verwende den “Herrenstab“, um 3 Siege zu erringen"
  },
  Task_73222_Desc = {
    Text = "Verwende “Vergessene Hand“, um einen Sieg zu erringen"
  },
  Task_73223_Desc = {
    Text = "Verwende “Jenkin“, um 3 Siege zu erringen"
  },
  Task_73224_Desc = {
    Text = "Verwende “Miryam“, um einen Sieg zu erringen"
  },
  Task_73225_Desc = {
    Text = "Verwende “Glückliche Zeit“, um einen Sieg zu erringen"
  },
  Task_73227_Desc = {
    Text = "Verwende “verlorener Pfad“, um einen Sieg zu erringen"
  },
  Task_73228_Desc = {
    Text = "Verwende «Alva», um 1x zu gewinnen"
  },
  Task_73229_Desc = {
    Text = "Verwende das “Götterspruch-Tablett“, um 1 Sieg zu erringen"
  },
  Task_73232_Desc = {
    Text = "Verwende „Emergenz“, um 3 Siege zu erzielen"
  },
  Task_73233_Desc = {
    Text = "Verwende “Yuwhasi“, um dreimal zu siegen"
  },
  Task_73235_Desc = {
    Text = "Verwende “35mm-Magie“, um 3 Siege zu erringen"
  },
  Task_73236_Desc = {
    Text = "Verwende “Verfallsgabe“, um einen Sieg zu erringen"
  },
  Task_73237_Desc = {
    Text = "Verwende “Gier“, um einen Sieg zu erringen"
  },
  Task_73241_Desc = {
    Text = "Verwende “Nicht-Ort“, um 3 Siege zu erringen"
  },
  Task_73243_Desc = {
    Text = "Verwende “Liz“, um 3 Siege zu erzielen"
  },
  Task_73246_Desc = {
    Text = "Verwende das “verborgene Rad“, um einen Sieg zu erringen"
  },
  Task_73249_Desc = {
    Text = "Verwende “Stimme im Kopf“, um einen Sieg zu erringen"
  },
  Task_73250_Desc = {
    Text = "Verwende “24“, um einen Sieg zu erringen"
  },
  Task_73253_Desc = {
    Text = "Verwende “standhafte Willenskraft“, um 3 Siege zu erringen"
  },
  Task_73254_Desc = {
    Text = "Verwende “Missgestalteter Rückenschlag“, um 3 Siege zu erringen"
  },
  Task_73257_Desc = {
    Text = "Verwende “Thais“, um einen Sieg zu erringen"
  },
  Task_73259_Desc = {
    Text = "Verwende “Fient“, um 3 Siege zu erringen"
  },
  Task_73260_Desc = {
    Text = "Verwende “Tawil“, um einen Sieg zu erringen"
  },
  Task_73262_Desc = {
    Text = "Verwende “Aigis“, um einen Sieg zu erringen"
  },
  Task_73266_Desc = {
    Text = "Verwende “Entschlossenheit der Schellfischs“, um einen Sieg zu erringen"
  },
  Task_73267_Desc = {
    Text = "Verwende „Lotan“, um 3x zu gewinnen"
  },
  Task_73268_Desc = {
    Text = "Verwende das “einzigartige Saatgut“, um einen Sieg zu erringen"
  },
  Task_73269_Desc = {
    Text = "Verwende “Strafe“, um 1x zu gewinnen"
  },
  Task_73270_Desc = {
    Text = "Verwende “Schmerzende Flosse“, um einen Sieg zu erringen"
  },
  Task_73271_Desc = {
    Text = "Verwende «Mittsommernachtstraum», um 3 Siege zu erringen"
  },
  Task_73278_Desc = {
    Text = "Verwende “Raubtier des Riesen“, um einen Sieg zu erringen"
  },
  Task_73279_Desc = {
    Text = "Verwende «Erica», um einen Sieg zu erringen"
  },
  Task_73280_Desc = {
    Text = "Verwende “Verbannung“, um 1 Sieg zu erzielen"
  },
  Task_73281_Desc = {
    Text = "Verwende „Meerestraum“, um 1 Mal zu gewinnen"
  },
  Task_73282_Desc = {
    Text = "Verwende “Bis der Schneeberg schmilzt“, um 3 Siege zu erringen"
  },
  Task_73284_Desc = {
    Text = "Verwende “Glücksrad“, um 1 Sieg zu erzielen"
  },
  Task_73285_Desc = {
    Text = "Verwende “Tor der Wahrheit“, um einen Sieg zu erringen"
  },
  Task_73286_Desc = {
    Text = "Verwende “Ramona“, um einen Sieg zu erringen"
  },
  Task_73287_Desc = {
    Text = "Verwende “Pandia“, um 3 Siege zu erringen"
  },
  Task_73288_Desc = {
    Text = "Verwende „Im Namen der Rose“, um 3 Siege zu erringen"
  },
  Task_73289_Desc = {
    Text = "Verwende “Alle ihre Teile“, um 3 Siege zu erringen"
  },
  Task_73290_Desc = {
    Text = "Verwende “Wanda“, um 3 Siege zu erzielen"
  },
  Task_73292_Desc = {
    Text = "Verwende „Zeilenende des Gedichts“, um 3 Siege zu erringen"
  },
  Task_73293_Desc = {
    Text = "Verwende “Blasser Abkömmling“, um einen Sieg zu erringen"
  },
  Task_73294_Desc = {
    Text = "Verwende “Tinkter“, um einen Sieg zu erringen"
  },
  Task_73296_Desc = {
    Text = "Verwende “Kernschmelze“, um einen Sieg zu erzielen"
  },
  Task_73297_Desc = {
    Text = "Verwende «Wunderherabkunft», um 1x zu gewinnen"
  },
  Task_73298_Desc = {
    Text = "Verwende “Brüllendes Blut und Sand“, um einen Sieg zu erringen"
  },
  Task_73299_Desc = {
    Text = "Verwende «Jenkins», um 1x zu gewinnen"
  },
  Task_73302_Desc = {
    Text = "Verwende “Gemurmel“, um 3 Siege zu erzielen"
  },
  Task_73303_Desc = {
    Text = "Verwende “Königliche Gebote“, um einen Sieg zu erringen"
  },
  Task_73305_Desc = {
    Text = "Verwende „Gereift“, um 3 Siege zu erzielen"
  },
  Task_73306_Desc = {
    Text = "Verwende „Schmerz übertreten“ um 1 Sieg zu erringen"
  },
  Task_73309_Desc = {
    Text = "Verwende “Stilles Gelage“, um einen Sieg zu erringen"
  },
  Task_73311_Desc = {
    Text = "Verwende “verlorener Pfad“, um 3 Siege zu erringen"
  },
  Task_73312_Desc = {
    Text = "Verwende “Golia“, um 3 Siege zu erzielen"
  },
  Task_73313_Desc = {
    Text = "Verwende “Fabel vom Taotie“, um 3 Siege zu erringen"
  },
  Task_73314_Desc = {
    Text = "Verwende “Zwinkern“, um 1 Sieg zu erringen"
  },
  Task_73315_Desc = {
    Text = "Verwende das “Auge der millionenfachen Gunst“, um 3 Siege zu erringen"
  },
  Task_73316_Desc = {
    Text = "Verwende “Daphnir“, um 3 Siege zu erringen"
  },
  Task_73317_Desc = {
    Text = "Verwende “Information ist Leben“, um 1 Mal zu gewinnen"
  },
  Task_73318_Desc = {
    Text = "Verwende “Ryker“, um einen Sieg zu erringen"
  },
  Task_73321_Desc = {
    Text = "Verwende «Orla», um 3 Siege zu erringen"
  },
  Task_73322_Desc = {
    Text = "Verwende “Kostbarste Sammlung“, um einen Sieg zu erringen"
  },
  Task_73323_Desc = {
    Text = "Verwende „Nautila“, um 3 Siege zu erzielen"
  },
  Task_73324_Desc = {
    Text = "Verwende “Blick über den See“, um 3 Siege zu erringen"
  },
  Task_73325_Desc = {
    Text = "Verwende „Jenseits des Todes“, um einen Sieg zu erringen"
  },
  Task_73326_Desc = {
    Text = "Verwende “Winternachtserinnerung“, um 3 Siege zu erzielen"
  },
  Task_73327_Desc = {
    Text = "Verwende “Abenteuerlicher Proviant“, um 3 Siege zu erringen"
  },
  Task_73328_Desc = {
    Text = "Verwende «Golia», um 1x zu gewinnen"
  },
  Task_73330_Desc = {
    Text = "Verwende “Fluchfessel“, um einen Sieg zu erringen"
  },
  Task_73333_Desc = {
    Text = "Verwende “unlösbare Berechnung“, um einen Sieg zu erzielen"
  },
  Task_73334_Desc = {
    Text = "Verwende “Sternentier“, um einen Sieg zu erringen"
  },
  Task_73335_Desc = {
    Text = "Verwende „Wunderherabkunft“, um 3 Siege zu erringen"
  },
  Task_73338_Desc = {
    Text = "Verwende „Menschliche Marionette, die ins Nichts fällt“, um 1 Sieg zu erzielen."
  },
  Task_73341_Desc = {
    Text = "Verwende «Murphy», um 3 Siege zu erzielen"
  },
  Task_73343_Desc = {
    Text = "Verwende „Polarnacht und Morgenröte“, um einen Sieg zu erringen"
  },
  Task_73345_Desc = {
    Text = "Verwende den “Blick von Isarau“, um einen Sieg zu erringen"
  },
  Task_73346_Desc = {
    Text = "Verwende “Fokus-Geist“, um 3 Siege zu erringen"
  },
  Task_73349_Desc = {
    Text = "Verwende “Knochenfressende Umarmung“, um 3 Siege zu erringen"
  },
  Task_73352_Desc = {
    Text = "Verwende „Im Schatten der Nacht“, um 3 Siege zu erringen"
  },
  Task_73353_Desc = {
    Text = "Verwende “Gunst“, um 3 Siege zu erzielen"
  },
  Task_73354_Desc = {
    Text = "Verwende „Nautila“, um einen Sieg zu erringen"
  },
  Task_73355_Desc = {
    Text = "Verwende “Ringfahrt · Ramona“, um einen Sieg zu erringen"
  },
  Task_73356_Desc = {
    Text = "Verwende „Oretas Schatz“, um 3 Siege zu erringen"
  },
  Task_73357_Desc = {
    Text = "Verwende “letzter Schwur“, um 3 Siege zu erringen"
  },
  Task_73359_Desc = {
    Text = "Verwende “Caecus“, um 3 Siege zu erringen"
  },
  Task_73360_Desc = {
    Text = "Verwende „Anatomie des Todes“, um einen Sieg zu erringen."
  },
  Task_73362_Desc = {
    Text = "Verwende “Glück-Zaubershow“, um 3 Siege zu erringen"
  },
  Task_73363_Desc = {
    Text = "Verwende “Ningphia“, um einen Sieg zu erringen"
  },
  Task_73366_Desc = {
    Text = "Verwende das “Zeitkreis-Chronometer“, um einen Sieg zu erringen"
  },
  Task_73369_Desc = {
    Text = "Verwende «Delirium», um 3 Siege zu erringen"
  },
  Task_73370_Desc = {
    Text = "Verwende „Hamlin“, um 3 Siege zu erzielen"
  },
  Task_73372_Desc = {
    Text = "Verwende “reines Silber der ursprünglichen Absicht“, um 3 Siege zu erringen"
  },
  Task_73374_Desc = {
    Text = "Verwende „Karen“, um 3 Siege zu erzielen"
  },
  Task_73377_Desc = {
    Text = "Verwende “Ungleicher Austausch“, um einen Sieg zu erzielen"
  },
  Task_73379_Desc = {
    Text = "Verwende “Sorel“, um einen Sieg zu erringen"
  },
  Task_73380_Desc = {
    Text = "Verwende “Casja“, um 3 Siege zu erzielen"
  },
  Task_73382_Desc = {
    Text = "Verwende “Tag der befreiten Ketten“, um einen Sieg zu erringen"
  },
  Task_73387_Desc = {
    Text = "Verwende “verborgene Geburt“, um 3 Siege zu erringen"
  },
  Task_73388_Desc = {
    Text = "Verwende “Herzbarriere“, um dreimal zu siegen"
  },
  Task_73390_Desc = {
    Text = "Verwende “Schmerzende Flosse“, um 3 Siege zu erringen"
  },
  Task_73392_Desc = {
    Text = "Verwende “Yuwhasi“, um einen Sieg zu erringen"
  },
  Task_73394_Desc = {
    Text = "Verwende “fromme Macht“, um dreimal zu siegen"
  },
  Task_73395_Desc = {
    Text = "Verwende “Blutkette · Helot“, um einen Sieg zu erringen"
  },
  Task_73396_Desc = {
    Text = "Verwende das “Götterspruch-Tablett“, um 3 Siege zu erringen"
  },
  Task_73400_Desc = {
    Text = "Verwende “Ewiges Requiem“, um einen Sieg zu erringen"
  },
  Task_73404_Desc = {
    Text = "Verwende “Menschen im Spiegel“, um einen Sieg zu erringen"
  },
  Task_73405_Desc = {
    Text = "Verwende “Im Regensturm“, um 3 Siege zu erringen"
  },
  Task_73407_Desc = {
    Text = "Verwende “Verfallsgabe“, um 3 Siege zu erringen"
  },
  Task_73409_Desc = {
    Text = "Verwende “Celest“, um 3 Siege zu erringen"
  },
  Task_73410_Desc = {
    Text = "Verwende «Einsicht», um 3 Siege zu erringen"
  },
  Task_73413_Desc = {
    Text = "Verwende “Gefesseltes Lied“, um einen Sieg zu erringen"
  },
  Task_73417_Desc = {
    Text = "Verwende “Gedächtnissyndrom“, um 3 Siege zu erzielen"
  },
  Task_73418_Desc = {
    Text = "Verwende “Menschen im Spiegel“, um 3 Siege zu erringen"
  },
  Task_73422_Desc = {
    Text = "Verwende “24“, um 3 Siege zu erringen"
  },
  Task_73425_Desc = {
    Text = "Verwende “standhafte Willenskraft“, um einen Sieg zu erringen"
  },
  Task_73426_Desc = {
    Text = "Verwende “Alva“, um 3 Siege zu erringen"
  },
  Task_73427_Desc = {
    Text = "Verwende «Wahnsinn», um 1 Sieg zu erringen"
  },
  Task_73430_Desc = {
    Text = "Verwende “Aktiv“, um 3 Siege zu erzielen"
  },
  Task_73431_Desc = {
    Text = "Verwende “unaufhörliches Konzert“, um 1 Sieg zu erringen"
  },
  Task_73432_Desc = {
    Text = "Verwende “Pflichtbewusstsein“, um einen Sieg zu erringen"
  },
  Task_73433_Desc = {
    Text = "Verwende “Mingwu“, um 3 Siege zu erzielen"
  },
  Task_73435_Desc = {
    Text = "Verwende “Speicherspirale“, um 3 Siege zu erringen"
  },
  Task_73437_Desc = {
    Text = "Gewinne 3 Siege mit “Hoffnung“"
  },
  Task_73440_Desc = {
    Text = "Verwende “Schlaf unter dem Gletscher“, um einen Sieg zu erringen"
  },
  Task_73442_Desc = {
    Text = "Verwende “Blutiges Gelage“, um 3 Siege zu erringen"
  },
  Task_73444_Desc = {
    Text = "Verwende “Wogende Begierde“, um dreimal zu siegen"
  },
  Task_73445_Desc = {
    Text = "Verwende „Leigh“, um einen Sieg zu erringen"
  },
  Task_73451_Desc = {
    Text = "Verwende “Helot“, um 3 Siege zu erzielen"
  },
  Task_73453_Desc = {
    Text = "Verwende “Segel des Ruders“, um 3 Siege zu erringen"
  },
  Task_73456_Desc = {
    Text = "Verwende “Faloce“, um einen Sieg zu erringen"
  },
  Task_73457_Desc = {
    Text = "Verwende “Herz des Ritters“, um 3 Siege zu erringen"
  },
  Task_73459_Desc = {
    Text = "Verwende “Hymne des Götterkönigs“, um 3 Siege zu erringen"
  },
  Task_73462_Desc = {
    Text = "Verwende “Saugen“, um 1-mal zu gewinnen"
  },
  Task_73584_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_73584_Name = {Text = "10 Siege"},
  Task_73585_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_73585_Name = {Text = "1 Sieg"},
  Task_73586_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_73586_Name = {Text = "6 Siege"},
  Task_73587_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_73587_Name = {Text = "3 Siege"},
  Task_73588_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_73588_UnlockCondDesc = {
    Text = "Entsperren nach dem Abschluss von \"Umkehrung: Der Moment des Umkehrens des Omniversums,\" möchtest du zu \"Umkehrung\" fortfahren?"
  },
  Task_73589_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_73589_UnlockCondDesc = {
    Text = "Entsperren nach dem Abschluss von \"Umkehrung: Der Moment des Umkehrens des Omniversums,\" möchtest du zu \"Umkehrung\" fortfahren?"
  },
  Task_73590_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_73590_UnlockCondDesc = {
    Text = "Entsperren nach dem Abschluss von \"Umkehrung: Der Moment des Umkehrens des Omniversums,\" möchtest du zu \"Umkehrung\" fortfahren?"
  },
  Task_73591_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_73591_UnlockCondDesc = {
    Text = "Entsperren nach dem Abschluss von \"Umkehrung: Der Moment des Umkehrens des Omniversums,\" möchtest du zu \"Umkehrung\" fortfahren?"
  },
  Task_73592_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_73592_UnlockCondDesc = {
    Text = "Entsperren nach dem Abschluss von \"Umkehrung: Der Moment des Umkehrens des Omniversums,\" möchtest du zu \"Umkehrung\" fortfahren?"
  },
  Task_73593_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_73593_UnlockCondDesc = {
    Text = "Entsperren nach dem Abschluss von \"Umkehrung: Der Moment des Umkehrens des Omniversums,\" möchtest du zu \"Umkehrung\" fortfahren?"
  },
  Task_73594_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_73594_UnlockCondDesc = {
    Text = "Entsperren nach dem Abschluss von \"Umkehrung: Der Moment des Umkehrens des Omniversums,\" möchtest du zu \"Umkehrung\" fortfahren?"
  },
  Task_73595_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_73595_UnlockCondDesc = {
    Text = "Entsperren nach dem Abschluss von \"Umkehrung: Der Moment des Umkehrens des Omniversums,\" möchtest du zu \"Umkehrung\" fortfahren?"
  },
  Task_73596_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_73596_UnlockCondDesc = {
    Text = "Entsperren nach dem Abschluss von \"Umkehrung: Der Moment des Umkehrens des Omniversums,\" möchtest du zu \"Umkehrung\" fortfahren?"
  },
  Task_73597_Desc = {
    Text = "Magische Eichel erreicht"
  },
  Task_73597_UnlockCondDesc = {
    Text = "Entsperren nach dem Abschluss von \"Umkehrung: Der Moment des Umkehrens des Omniversums,\" möchtest du zu \"Umkehrung\" fortfahren?"
  },
  Task_73672_Desc = {
    Text = "Erwirb die Urtöchterin bei Erleuchtung 2"
  },
  Task_73672_Name = {
    Text = "Erwirb Ursängerin bei Erleuchtung Stufe 2"
  },
  Task_73672_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Genesis Dore Erleuchten Paket 1 Aktivität"
  },
  Task_73673_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_73674_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_73676_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_73677_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_73679_Desc = {
    Text = "Erwirb die Ursängerin der Blüten bei Erleuchtung 6"
  },
  Task_73679_Name = {
    Text = "Erwirb die Urtulpe bei Erleuchtungsstufe 6"
  },
  Task_73679_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Genesis Dore Erleuchten Paket 2 Aktivität"
  },
  Task_73686_Desc = {
    Text = "Schmelze · Doll erreicht den 10. Grad der Affinität"
  },
  Task_73880_Desc = {
    Text = "Dem Schmelzen·Puppe folgen, um die „Antwort“ zu bestätigen"
  },
  Task_73880_Name = {Text = "Ziel"},
  Task_73881_Desc = {
    Text = "Gegen die entfremdete Sarah vorgehen"
  },
  Task_73881_Name = {Text = "Ziel"},
  Task_73882_Desc = {
    Text = "Zerstöre B-68 „Schmelzen·Puppe“"
  },
  Task_73882_Name = {Text = "Ziel"},
  Task_73883_Desc = {
    Text = "Erkundung der Dimensionswelt vor dir"
  },
  Task_73883_Name = {Text = "Ziel"},
  Task_73884_Desc = {
    Text = "Jenkins beruhigen"
  },
  Task_73884_Name = {Text = "Ziel"},
  Task_73885_Desc = {
    Text = "Fessel Schmelzen·Puppe"
  },
  Task_73885_Name = {Text = "Ziel"},
  Task_73886_Desc = {
    Text = "Wache den Glockenturm"
  },
  Task_73886_Name = {Text = "Ziel"},
  Task_73887_Desc = {
    Text = "Mutanten im Flur des Waisenhauses eliminieren"
  },
  Task_73887_Name = {Text = "Ziel"},
  Task_73888_Desc = {
    Text = "Von Juliette geretteter Salvador"
  },
  Task_73888_Name = {Text = "Ziel"},
  Task_73889_Desc = {
    Text = "Den Weg zur Kirche der ewigen Segnungen ebnen"
  },
  Task_73889_Name = {Text = "Ziel"},
  Task_74202_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_74203_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_74204_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_74205_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_74206_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_74207_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_74208_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_74210_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_74211_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_74212_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_74222_Desc = {
    Text = "Abgeschlossen das Wandern „Tag der Krönung“"
  },
  Task_74222_Name = {
    Text = "Ewige Königsmacht"
  },
  Task_74223_Desc = {
    Text = "Abschluss des Untersuchungsereignisses “Wiederkehr in die Nebelstadt“ in schwerem Schwierigkeitsgrad"
  },
  Task_74223_Name = {
    Text = "<Yellow:Verirr nicht in der grauen Nacht> · Hart"
  },
  Task_74224_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 10 Mal Resonanz erzeugt"
  },
  Task_74224_Desc2 = {
    Text = "Bei der Untersuchung des Ereignisses „Wiederkehr zur Nebelstadt“ entstand 10-mal Resonanz"
  },
  Task_74224_Name2 = {
    Text = "Leerecho IV"
  },
  Task_74225_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"@1@2\""
  },
  Task_74225_Desc2 = {
    Text = "Abschluss des Untersuchungsereignisses „Wiederkehr zur Nebelstadt“"
  },
  Task_74225_Name2 = {
    Text = "<Yellow:Verirr dich nicht in der grauen Nacht>"
  },
  Task_74226_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 3 Mal Resonanz erzeugt"
  },
  Task_74226_Desc2 = {
    Text = "Bei der Untersuchung des Ereignisses „Wiederkehr zur Nebelstadt“ entstand 3-malige Resonanz"
  },
  Task_74226_Name2 = {
    Text = "Echo der Leere"
  },
  Task_74227_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 6 Mal Resonanz erzeugt"
  },
  Task_74227_Desc2 = {
    Text = "Bei der Untersuchung des Ereignisses „Wiederkehr zur Nebelstadt“ entstand 6-mal Resonanz."
  },
  Task_74227_Name2 = {
    Text = "Echo der Leere II"
  },
  Task_74228_Desc = {
    Text = "In der Untersuchung Veranstaltung \"@1@2\" 8 Mal resoniert"
  },
  Task_74228_Desc2 = {
    Text = "Bei der Untersuchung des Ereignisses „Wiederkehr zur Nebelstadt“ entstand 8-mal Resonanz."
  },
  Task_74228_Name2 = {
    Text = "Echo der Leere III"
  },
  Task_74235_Desc = {Text = "Liz finden"},
  Task_74235_Name = {Text = "Ziel"},
  Task_74295_Desc = {
    Text = "Das Wandern „Leidenschaft kehrt zurück“ abgeschlossen"
  },
  Task_74295_Name = {
    Text = "Blauflammenwirbeln"
  },
  Task_74296_Desc = {
    Text = "Das Wandern „Leidenschaft kehrt zurück“ im schweren Schwierigkeitsgrad abgeschlossen"
  },
  Task_74296_Name = {
    Text = "Blauer Flammenwirbel · Hart"
  },
  Task_74332_Name = {
    Text = "Die Aktivierung von „Runde umkehren“ ist beendet"
  },
  Task_74333_Desc = {
    Text = "Zweiten Akt der Rundenumkehr-Geschichte durchspielen"
  },
  Task_74333_UnlockCondDesc = {
    Text = "Erhalte die «Ungerade Runde Belohnung: 1200 Punkte erreichen», um sie freizuschalten"
  },
  Task_74334_Desc = {
    Text = "Umkehrung der Prolog-Handlung in einer Runde abschließen"
  },
  Task_74335_Desc = {
    Text = "Drittes Kapitel der Handlungsrunde umkehren abgeschlossen"
  },
  Task_74335_UnlockCondDesc = {
    Text = "Erhalte die «Belohnung in ungeraden Runden: 2400 Punkte erreichen» zum Entsperren"
  },
  Task_74342_Desc = {
    Text = "25 Karten mit einer Verteidigungsrolle ausspielen"
  },
  Task_74343_Desc = {
    Text = "25 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74344_Desc = {
    Text = "Mit gesegneten Charakteren 25 Karten ausspielen"
  },
  Task_74345_Desc = {
    Text = "25 Karten mit einem Geist-Charakter ausspielen"
  },
  Task_74346_Desc = {
    Text = "25 Karten mit einem Kampfcharakter ausspielen"
  },
  Task_74375_Desc = {
    Text = "1750 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74376_Desc = {
    Text = "Mit gesegneten Charakteren 400 Karten ausspielen"
  },
  Task_74377_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1225 Karten spielen"
  },
  Task_74378_Desc = {
    Text = "1125 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74379_Desc = {
    Text = "775 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74380_Desc = {
    Text = "Mit gesegneten Charakteren 1.775 Karten spielen"
  },
  Task_74381_Desc = {
    Text = "775 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74382_Desc = {
    Text = "Mit einem Charakter des Intelligenz-Typs 700 Karten ausspielen"
  },
  Task_74383_Desc = {
    Text = "1875 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74384_Desc = {
    Text = "Mit gesegneten Charakteren 825 Karten ausspielen"
  },
  Task_74385_Desc = {
    Text = "1800 Karten mit einem Kampfcharakter spielen"
  },
  Task_74386_Desc = {
    Text = "1200 Karten mit einem kämpferischen Charakter ausspielen"
  },
  Task_74387_Desc = {
    Text = "Mit gesegneten Charakteren 775 Karten ausspielen"
  },
  Task_74388_Desc = {
    Text = "Mit einem Intelligenz-Charakter 525 Karten ausspielen"
  },
  Task_74389_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1600 Karten spielen"
  },
  Task_74390_Desc = {
    Text = "Mit gesegneten Charakteren 675 Karten spielen"
  },
  Task_74391_Desc = {
    Text = "1975 Karten mit einem kämpferischen Charakter ausspielen"
  },
  Task_74392_Desc = {
    Text = "1525 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74393_Desc = {
    Text = "1325 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74394_Desc = {
    Text = "1.550 Karten mit einem Charakter des Bösen Sterns spielen"
  },
  Task_74395_Desc = {
    Text = "Mit gesegneten Charakteren 1.125 Karten ausspielen"
  },
  Task_74396_Desc = {
    Text = "125 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74397_Desc = {
    Text = "1.600 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74398_Desc = {
    Text = "Mit gesegneten Charakteren 650 Karten ausspielen"
  },
  Task_74399_Desc = {
    Text = "325 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74400_Desc = {
    Text = "Mit gesegneten Charakteren 1.325 Karten spielen"
  },
  Task_74401_Desc = {
    Text = "Mit gesegneten Charakteren 150 Karten ausspielen"
  },
  Task_74402_Desc = {
    Text = "50 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74403_Desc = {
    Text = "Mit gesegneten Charakteren 2.000 Karten ausspielen"
  },
  Task_74404_Desc = {
    Text = "850 Karten mit einem Charakter des Kampf-Typs ausspielen"
  },
  Task_74405_Desc = {
    Text = "Mit gesegneten Charakteren 1.150 Karten ausspielen"
  },
  Task_74406_Desc = {
    Text = "150 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74407_Desc = {
    Text = "Mit einem Verteidigungscharakter 550 Karten ausspielen"
  },
  Task_74408_Desc = {
    Text = "800 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74409_Desc = {
    Text = "100 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74410_Desc = {
    Text = "1600 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74411_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1300 Karten spielen"
  },
  Task_74412_Desc = {
    Text = "Mit gesegneten Charakteren 1.850 Karten spielen"
  },
  Task_74413_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1525 Karten spielen"
  },
  Task_74414_Desc = {
    Text = "1425 Karten mit einem Defensiv-Charakter ausspielen"
  },
  Task_74415_Desc = {
    Text = "1275 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74416_Desc = {
    Text = "Mit einem Charakter des Wissens 925 Karten ausspielen"
  },
  Task_74417_Desc = {
    Text = "800 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74418_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1625 Karten spielen"
  },
  Task_74419_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1775 Karten spielen"
  },
  Task_74420_Desc = {
    Text = "Mit gesegneten Charakteren 1.100 Karten ausspielen"
  },
  Task_74421_Desc = {
    Text = "100 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74422_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1750 Karten spielen"
  },
  Task_74423_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1125 Karten spielen"
  },
  Task_74424_Desc = {
    Text = "Mit einem Charakter des Intelligenz-Typs 750 Karten spielen"
  },
  Task_74425_Desc = {
    Text = "1725 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74426_Desc = {
    Text = "1150 Karten mit einem kämpferischen Charakter ausspielen"
  },
  Task_74427_Desc = {
    Text = "175 Karten mit einem Charakter des Verstandes-Typs ausspielen"
  },
  Task_74428_Desc = {
    Text = "1625 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74429_Desc = {
    Text = "Mit Charakteren mit Segen 425 Karten ausspielen"
  },
  Task_74430_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1700 Karten spielen"
  },
  Task_74431_Desc = {
    Text = "1325 Karten mit einem kämpferischen Charakter ausspielen"
  },
  Task_74432_Desc = {
    Text = "Mit gesegneten Charakteren 1.225 Karten spielen"
  },
  Task_74433_Desc = {
    Text = "225 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74434_Desc = {
    Text = "1875 Karten mit einem Kampfcharakter ausspielen"
  },
  Task_74435_Desc = {
    Text = "Mit einem Charakter des Intelligenz-Typs 725 Karten ausspielen"
  },
  Task_74436_Desc = {
    Text = "Mit einem Charakter des Verstandes 325 Karten ausspielen"
  },
  Task_74437_Desc = {
    Text = "Mit einem Charakter des Typs Intelligenz 1350 Karten spielen"
  },
  Task_74438_Desc = {
    Text = "1725 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74439_Desc = {
    Text = "1375 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74440_Desc = {
    Text = "925 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74441_Desc = {
    Text = "1.950 Karten mit einem Charakter des Bösen Sterns spielen"
  },
  Task_74442_Desc = {
    Text = "450 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74443_Desc = {
    Text = "175 Karten mit einer Verteidigungsrolle ausspielen"
  },
  Task_74444_Desc = {
    Text = "1100 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74445_Desc = {
    Text = "450 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74446_Desc = {
    Text = "1225 Karten mit einem kämpferischen Charakter ausspielen"
  },
  Task_74447_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1475 Karten spielen"
  },
  Task_74448_Desc = {
    Text = "1250 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74449_Desc = {
    Text = "Mit einem Intelligenz-Charakter 100 Karten ausspielen"
  },
  Task_74450_Desc = {
    Text = "975 Karten mit einem Kampf-Charakter spielen"
  },
  Task_74451_Desc = {
    Text = "Mit gesegneten Charakteren 800 Karten ausspielen"
  },
  Task_74452_Desc = {
    Text = "1875 Karten mit einem Charakter des Bösen Sterns spielen"
  },
  Task_74453_Desc = {
    Text = "900 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74454_Desc = {
    Text = "1950 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74455_Desc = {
    Text = "1000 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74456_Desc = {
    Text = "1925 Karten mit einem Kampfcharakter ausspielen"
  },
  Task_74457_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1825 Karten spielen"
  },
  Task_74458_Desc = {
    Text = "1725 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74459_Desc = {
    Text = "1.500 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74460_Desc = {
    Text = "1375 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74461_Desc = {
    Text = "350 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74462_Desc = {
    Text = "1975 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74463_Desc = {
    Text = "625 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74464_Desc = {
    Text = "Mit einem Verteidigungscharakter 500 Karten ausspielen"
  },
  Task_74465_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1200 Karten ausspielen"
  },
  Task_74466_Desc = {
    Text = "Mit einem Charakter des Typs Intelligenz 775 Karten ausspielen"
  },
  Task_74467_Desc = {
    Text = "Mit einem Intelligenz-Charakter 975 Karten spielen"
  },
  Task_74468_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1550 Karten spielen"
  },
  Task_74469_Desc = {
    Text = "Mit einem Intelligenz-Charakter 2000 Karten spielen"
  },
  Task_74470_Desc = {
    Text = "1.050 Karten mit einem Charakter des Bösen Sterns spielen"
  },
  Task_74471_Desc = {
    Text = "1700 Karten mit einem Defensiv-Charakter ausspielen"
  },
  Task_74472_Desc = {
    Text = "1500 Karten mit einem Kampfcharakter ausspielen"
  },
  Task_74473_Desc = {
    Text = "Mit gesegneten Charakteren 75 Karten ausspielen"
  },
  Task_74474_Desc = {
    Text = "Mit gesegneten Charakteren 550 Karten ausspielen"
  },
  Task_74475_Desc = {
    Text = "Mit einem Intelligenz-Charakter 150 Karten ausspielen"
  },
  Task_74476_Desc = {
    Text = "1575 Karten mit einem kämpferischen Charakter ausspielen"
  },
  Task_74477_Desc = {
    Text = "Mit einem Intelligenz-Charakter 425 Karten ausspielen"
  },
  Task_74478_Desc = {
    Text = "950 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74479_Desc = {
    Text = "700 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74480_Desc = {
    Text = "1175 Karten mit einem kämpferischen Charakter spielen"
  },
  Task_74481_Desc = {
    Text = "700 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74482_Desc = {
    Text = "Mit gesegneten Charakteren 1.275 Karten ausspielen"
  },
  Task_74483_Desc = {
    Text = "Mit einem Charakter des Wissens 625 Karten ausspielen"
  },
  Task_74484_Desc = {
    Text = "275 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74485_Desc = {
    Text = "1575 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74486_Desc = {
    Text = "1400 Karten mit einem Defensiv-Charakter ausspielen"
  },
  Task_74487_Desc = {
    Text = "1675 Karten mit einem Kampfcharakter ausspielen"
  },
  Task_74488_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1075 Karten spielen"
  },
  Task_74489_Desc = {
    Text = "325 Karten mit einer Verteidigungsrolle spielen"
  },
  Task_74490_Desc = {
    Text = "Mit gesegneten Charakteren 1.025 Karten spielen"
  },
  Task_74491_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1025 Karten spielen"
  },
  Task_74492_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1050 Karten spielen"
  },
  Task_74493_Desc = {
    Text = "600 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74494_Desc = {
    Text = "Mit einem Charakter mit hohem Intellekt 1900 Karten spielen"
  },
  Task_74495_Desc = {
    Text = "125 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74496_Desc = {
    Text = "Mit einem Charakter des Intelligenz-Typs 200 Karten ausspielen"
  },
  Task_74497_Desc = {
    Text = "Mit gesegneten Charakteren 1.575 Karten spielen"
  },
  Task_74498_Desc = {
    Text = "575 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74499_Desc = {
    Text = "800 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74500_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1275 Karten ausspielen"
  },
  Task_74501_Desc = {
    Text = "1625 Karten mit einem Defensiv-Charakter ausspielen"
  },
  Task_74502_Desc = {
    Text = "Mit gesegneten Charakteren 1.900 Karten spielen"
  },
  Task_74503_Desc = {
    Text = "1100 Karten mit einem Kampfcharakter ausspielen"
  },
  Task_74504_Desc = {
    Text = "150 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74505_Desc = {
    Text = "Mit gesegneten Charakteren 50 Karten ausspielen"
  },
  Task_74506_Desc = {
    Text = "1025 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74507_Desc = {
    Text = "1900 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74508_Desc = {
    Text = "675 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74509_Desc = {
    Text = "1925 Karten mit einem Defensiv-Charakter ausspielen"
  },
  Task_74510_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1850 Karten spielen"
  },
  Task_74511_Desc = {
    Text = "1.250 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74512_Desc = {
    Text = "1950 Karten mit einem kämpferischen Charakter ausspielen"
  },
  Task_74513_Desc = {
    Text = "550 Karten mit einem kämpferischen Charakter spielen"
  },
  Task_74514_Desc = {
    Text = "250 Karten mit einem Charakter des Kampf-Typs ausspielen"
  },
  Task_74515_Desc = {
    Text = "1525 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74516_Desc = {
    Text = "75 Karten mit Verteidigungscharakteren ausspielen"
  },
  Task_74517_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1150 Karten spielen"
  },
  Task_74518_Desc = {
    Text = "825 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74519_Desc = {
    Text = "Mit einem Verteidiger-Charakter 50 Karten ausspielen"
  },
  Task_74520_Desc = {
    Text = "1.200 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74521_Desc = {
    Text = "1600 Karten mit einem kämpferischen Charakter ausspielen"
  },
  Task_74522_Desc = {
    Text = "1125 Karten mit einem Kampf-Charakter spielen"
  },
  Task_74523_Desc = {
    Text = "1425 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74524_Desc = {
    Text = "225 Karten mit einem Kampf-Charakter spielen"
  },
  Task_74525_Desc = {
    Text = "Mit einem Charakter des Intelligenz-Typs 375 Karten ausspielen"
  },
  Task_74526_Desc = {
    Text = "1475 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74527_Desc = {
    Text = "100 Karten mit einem Schutz-Charakter ausspielen"
  },
  Task_74528_Desc = {
    Text = "375 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74529_Desc = {
    Text = "1850 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74530_Desc = {
    Text = "350 Karten mit einem Charakter des Kampf-Typs ausspielen"
  },
  Task_74531_Desc = {
    Text = "Mit gesegneten Charakteren 1.675 Karten ausspielen"
  },
  Task_74532_Desc = {
    Text = "675 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74533_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1650 Karten spielen"
  },
  Task_74534_Desc = {
    Text = "75 Karten mit einem Intellekt-Charakter ausspielen"
  },
  Task_74535_Desc = {
    Text = "50 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74536_Desc = {
    Text = "875 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74537_Desc = {
    Text = "1650 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74538_Desc = {
    Text = "Mit gesegneten Charakteren 250 Karten ausspielen"
  },
  Task_74539_Desc = {
    Text = "Mit gesegneten Charakteren 100 Karten ausspielen"
  },
  Task_74540_Desc = {
    Text = "Mit gesegneten Charakteren 1.075 Karten spielen"
  },
  Task_74541_Desc = {
    Text = "1.750 Karten mit einem Charakter des Bösen Sterns spielen"
  },
  Task_74542_Desc = {
    Text = "750 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74543_Desc = {
    Text = "Mit einem Intelligenz-Charakter 550 Karten ausspielen"
  },
  Task_74544_Desc = {
    Text = "1450 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74545_Desc = {
    Text = "725 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74546_Desc = {
    Text = "Mit einem Intelligenz-Charakter 600 Karten ausspielen"
  },
  Task_74547_Desc = {
    Text = "Mit gesegneten Charakteren 700 Karten ausspielen"
  },
  Task_74548_Desc = {
    Text = "1550 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74549_Desc = {
    Text = "Mit gesegneten Charakteren 850 Karten spielen"
  },
  Task_74550_Desc = {
    Text = "1.450 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74551_Desc = {
    Text = "1625 Karten mit einem kämpferischen Charakter ausspielen"
  },
  Task_74552_Desc = {
    Text = "200 Karten mit einem Kampfcharakter ausspielen"
  },
  Task_74553_Desc = {
    Text = "Mit gesegneten Charakteren 1.525 Karten spielen"
  },
  Task_74554_Desc = {
    Text = "525 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74555_Desc = {
    Text = "Mit gesegneten Charakteren 325 Karten spielen"
  },
  Task_74556_Desc = {
    Text = "1525 Karten mit einem kämpferischen Charakter ausspielen"
  },
  Task_74557_Desc = {
    Text = "375 Karten mit einem Charakter des Bösen Sterns spielen"
  },
  Task_74558_Desc = {
    Text = "Mit gesegneten Charakteren 1.375 Karten spielen"
  },
  Task_74559_Desc = {
    Text = "Mit gesegneten Charakteren 300 Karten ausspielen"
  },
  Task_74560_Desc = {
    Text = "Mit gesegneten Charakteren 225 Karten spielen"
  },
  Task_74561_Desc = {
    Text = "1850 Karten mit einem kämpferischen Charakter ausspielen"
  },
  Task_74562_Desc = {
    Text = "475 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74563_Desc = {
    Text = "Mit gesegneten Charakteren 600 Karten ausspielen"
  },
  Task_74564_Desc = {
    Text = "1375 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74565_Desc = {
    Text = "1450 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74566_Desc = {
    Text = "300 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74567_Desc = {
    Text = "Mit einem Intelligenz-Charakter 950 Karten spielen"
  },
  Task_74568_Desc = {
    Text = "1200 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74569_Desc = {
    Text = "1025 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74570_Desc = {
    Text = "Mit gesegneten Charakteren 950 Karten spielen"
  },
  Task_74571_Desc = {
    Text = "1350 Karten mit einem kämpferischen Charakter ausspielen"
  },
  Task_74572_Desc = {
    Text = "525 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74573_Desc = {
    Text = "125 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74574_Desc = {
    Text = "Mit gesegneten Charakteren 475 Karten spielen"
  },
  Task_74575_Desc = {
    Text = "Mit einem Intelligenz-Charakter 350 Karten ausspielen"
  },
  Task_74576_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1175 Karten spielen"
  },
  Task_74577_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1250 Karten spielen"
  },
  Task_74578_Desc = {
    Text = "775 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74579_Desc = {
    Text = "400 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74580_Desc = {
    Text = "825 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74581_Desc = {
    Text = "Mit einem Intelligenz-Charakter 650 Karten ausspielen"
  },
  Task_74582_Desc = {
    Text = "1575 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74583_Desc = {
    Text = "Mit gesegneten Charakteren 350 Karten ausspielen"
  },
  Task_74584_Desc = {
    Text = "1400 Karten mit einem Kampfcharakter ausspielen"
  },
  Task_74585_Desc = {
    Text = "275 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74586_Desc = {
    Text = "1.500 Karten mit gesegneten Charakteren ausspielen"
  },
  Task_74587_Desc = {
    Text = "500 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74588_Desc = {
    Text = "1075 Karten mit einem kämpferischen Charakter ausspielen"
  },
  Task_74589_Desc = {
    Text = "Mit gesegneten Charakteren 625 Karten spielen"
  },
  Task_74590_Desc = {
    Text = "575 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74591_Desc = {
    Text = "850 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74592_Desc = {
    Text = "650 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74593_Desc = {
    Text = "Mit gesegneten Charakteren 575 Karten ausspielen"
  },
  Task_74594_Desc = {
    Text = "Mit gesegneten Charakteren 375 Karten ausspielen"
  },
  Task_74595_Desc = {
    Text = "225 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74596_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1875 Karten spielen"
  },
  Task_74597_Desc = {
    Text = "1075 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74598_Desc = {
    Text = "1825 Karten mit einem kämpferischen Charakter ausspielen"
  },
  Task_74599_Desc = {
    Text = "1.700 Karten mit einem Charakter des Bösen Sterns spielen"
  },
  Task_74600_Desc = {
    Text = "150 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74601_Desc = {
    Text = "1750 Karten mit einem Defensiv-Charakter ausspielen"
  },
  Task_74602_Desc = {
    Text = "1975 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74603_Desc = {
    Text = "750 Karten mit einem Charakter des Bösen Sterns spielen"
  },
  Task_74604_Desc = {
    Text = "Mit gesegneten Charakteren 1.750 Karten spielen"
  },
  Task_74605_Desc = {
    Text = "1150 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74606_Desc = {
    Text = "1.475 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74607_Desc = {
    Text = "875 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74608_Desc = {
    Text = "725 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74609_Desc = {
    Text = "Mit gesegneten Charakteren 1.725 Karten spielen"
  },
  Task_74610_Desc = {
    Text = "1.800 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74611_Desc = {
    Text = "Mit gesegneten Charakteren 1.050 Karten spielen"
  },
  Task_74612_Desc = {
    Text = "Mit gesegneten Charakteren 1925 Karten spielen"
  },
  Task_74613_Desc = {
    Text = "925 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74614_Desc = {
    Text = "250 Karten mit einem Geist-Charakter ausspielen"
  },
  Task_74615_Desc = {
    Text = "Mit einem Charakter mit hohem Intelligenz-Attribut 900 Karten ausspielen"
  },
  Task_74616_Desc = {
    Text = "350 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74617_Desc = {
    Text = "Mit gesegneten Charakteren 1.350 Karten ausspielen"
  },
  Task_74618_Desc = {
    Text = "Mit gesegneten Charakteren 125 Karten ausspielen"
  },
  Task_74619_Desc = {
    Text = "1775 Karten mit einem Charakter des Bösen Sterns spielen"
  },
  Task_74620_Desc = {
    Text = "1925 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74621_Desc = {
    Text = "1.900 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74622_Desc = {
    Text = "Mit einem Intelligenz-Charakter 875 Karten spielen"
  },
  Task_74623_Desc = {
    Text = "250 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74624_Desc = {
    Text = "900 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74625_Desc = {
    Text = "675 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74626_Desc = {
    Text = "1350 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74627_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1450 Karten spielen"
  },
  Task_74628_Desc = {
    Text = "875 Karten mit gesegneten Charakteren ausspielen"
  },
  Task_74629_Desc = {
    Text = "1550 Karten mit einem kämpferischen Charakter ausspielen"
  },
  Task_74630_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1000 Karten ausspielen"
  },
  Task_74631_Desc = {
    Text = "2.000 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74632_Desc = {
    Text = "Mit einem Intelligenz-Charakter 675 Karten ausspielen"
  },
  Task_74633_Desc = {
    Text = "1025 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74634_Desc = {
    Text = "1.300 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74635_Desc = {
    Text = "Mit einem Charakter mit hoher Intelligenz 1800 Karten spielen"
  },
  Task_74636_Desc = {
    Text = "1825 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74637_Desc = {
    Text = "1700 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74638_Desc = {
    Text = "1000 Karten mit einem kämpferischen Charakter ausspielen"
  },
  Task_74639_Desc = {
    Text = "Mit gesegneten Charakteren 275 Karten spielen"
  },
  Task_74640_Desc = {
    Text = "Mit einem Charakter mit hoher Intelligenz 1100 Karten spielen"
  },
  Task_74641_Desc = {
    Text = "Mit gesegneten Charakteren 1.800 Karten spielen"
  },
  Task_74642_Desc = {
    Text = "1475 Karten mit einem Kampfcharakter ausspielen"
  },
  Task_74643_Desc = {
    Text = "1225 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74644_Desc = {
    Text = "Mit gesegneten Charakteren 975 Karten spielen"
  },
  Task_74645_Desc = {
    Text = "400 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74646_Desc = {
    Text = "Mit einem Intelligenz-Charakter 800 Karten ausspielen"
  },
  Task_74647_Desc = {
    Text = "Mit einem Charakter des Typs Intelligenz 1925 Karten spielen"
  },
  Task_74648_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1375 Karten spielen"
  },
  Task_74649_Desc = {
    Text = "Mit einem Charakter des Geistes 400 Karten ausspielen"
  },
  Task_74650_Desc = {
    Text = "Mit gesegneten Charakteren 1.000 Karten ausspielen"
  },
  Task_74651_Desc = {
    Text = "700 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74652_Desc = {
    Text = "Mit gesegneten Charakteren 1.700 Karten ausspielen"
  },
  Task_74653_Desc = {
    Text = "1075 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74654_Desc = {
    Text = "1050 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74655_Desc = {
    Text = "175 Karten mit einem Charakter des Kampf-Typs ausspielen"
  },
  Task_74656_Desc = {
    Text = "Mit einem Intelligenz-Charakter 300 Karten ausspielen"
  },
  Task_74657_Desc = {
    Text = "1.000 Karten mit einem Charakter des Bösen Sterns spielen"
  },
  Task_74658_Desc = {
    Text = "Mit einem Geist-Charakter 825 Karten ausspielen"
  },
  Task_74659_Desc = {
    Text = "600 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74660_Desc = {
    Text = "725 Karten mit einem Schutz-Charakter ausspielen"
  },
  Task_74661_Desc = {
    Text = "750 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74662_Desc = {
    Text = "1675 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74663_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1500 Karten spielen"
  },
  Task_74664_Desc = {
    Text = "375 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74665_Desc = {
    Text = "1150 Karten mit einem Defensiv-Charakter ausspielen"
  },
  Task_74666_Desc = {
    Text = "Mit einem Intelligenz-Charakter 275 Karten spielen"
  },
  Task_74667_Desc = {
    Text = "Mit gesegneten Charakteren 900 Karten ausspielen"
  },
  Task_74668_Desc = {
    Text = "Mit einem Intelligenz-Charakter 475 Karten ausspielen"
  },
  Task_74669_Desc = {
    Text = "75 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74670_Desc = {
    Text = "Mit gesegneten Charakteren 175 Karten ausspielen"
  },
  Task_74671_Desc = {
    Text = "1775 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74672_Desc = {
    Text = "Mit einem Intelligenz-Charakter 575 Karten spielen"
  },
  Task_74673_Desc = {
    Text = "500 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74674_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1725 Karten spielen"
  },
  Task_74675_Desc = {
    Text = "950 Karten mit einem Kampf-Charakter spielen"
  },
  Task_74676_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1950 Karten spielen"
  },
  Task_74677_Desc = {
    Text = "1500 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74678_Desc = {
    Text = "Mit gesegneten Charakteren 1.975 Karten spielen"
  },
  Task_74679_Desc = {
    Text = "975 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74680_Desc = {
    Text = "Mit einem Charakter mit hoher Intelligenz 1325 Karten spielen"
  },
  Task_74681_Desc = {
    Text = "1775 Karten mit einem kämpferischen Charakter ausspielen"
  },
  Task_74682_Desc = {
    Text = "125 Karten mit einem Geist-Charakter ausspielen"
  },
  Task_74683_Desc = {
    Text = "Mit gesegneten Charakteren 1.550 Karten spielen"
  },
  Task_74684_Desc = {
    Text = "2000 Karten mit einem Kampfcharakter spielen"
  },
  Task_74685_Desc = {
    Text = "1275 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74686_Desc = {
    Text = "Mit gesegneten Charakteren 525 Karten ausspielen"
  },
  Task_74687_Desc = {
    Text = "550 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74688_Desc = {
    Text = "650 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74689_Desc = {
    Text = "875 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74690_Desc = {
    Text = "Mit gesegneten Charakteren 1.875 Karten spielen"
  },
  Task_74691_Desc = {
    Text = "1300 Karten mit einem Defensiv-Charakter ausspielen"
  },
  Task_74692_Desc = {
    Text = "1.100 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74693_Desc = {
    Text = "2000 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74694_Desc = {
    Text = "1.850 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74695_Desc = {
    Text = "75 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74696_Desc = {
    Text = "625 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74697_Desc = {
    Text = "1425 Karten mit einem Kampfcharakter ausspielen"
  },
  Task_74698_Desc = {
    Text = "1800 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74699_Desc = {
    Text = "225 Karten mit einem Intellekt-Charakter spielen"
  },
  Task_74700_Desc = {
    Text = "Mit gesegneten Charakteren 725 Karten ausspielen"
  },
  Task_74701_Desc = {
    Text = "1175 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74702_Desc = {
    Text = "Mit einem Intelligenz-Charakter 450 Karten ausspielen"
  },
  Task_74703_Desc = {
    Text = "575 Karten mit Verteidigungsrollen ausspielen"
  },
  Task_74704_Desc = {
    Text = "Mit gesegneten Charakteren 1.625 Karten spielen"
  },
  Task_74705_Desc = {
    Text = "625 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74706_Desc = {
    Text = "1.350 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74707_Desc = {
    Text = "Mit gesegneten Charakteren 1.650 Karten spielen"
  },
  Task_74708_Desc = {
    Text = "650 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74709_Desc = {
    Text = "200 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74710_Desc = {
    Text = "1125 Karten mit einem Defensiv-Charakter ausspielen"
  },
  Task_74711_Desc = {
    Text = "50 Karten mit einem Intellekt-Charakter ausspielen"
  },
  Task_74712_Desc = {
    Text = "450 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74713_Desc = {
    Text = "Mit gesegneten Charakteren 1.250 Karten spielen"
  },
  Task_74714_Desc = {
    Text = "250 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74715_Desc = {
    Text = "Mit gesegneten Charakteren 1.450 Karten spielen"
  },
  Task_74716_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1675 Karten spielen"
  },
  Task_74717_Desc = {
    Text = "900 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74718_Desc = {
    Text = "Mit einem Charakter des Intelligenz-Typs 500 Karten ausspielen"
  },
  Task_74719_Desc = {
    Text = "1325 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74720_Desc = {
    Text = "425 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74721_Desc = {
    Text = "Mit gesegneten Charakteren 1.425 Karten spielen"
  },
  Task_74722_Desc = {
    Text = "1300 Karten mit einem Kampfcharakter spielen"
  },
  Task_74723_Desc = {
    Text = "925 Karten mit Segensrollen ausspielen"
  },
  Task_74724_Desc = {
    Text = "Mit gesegneten Charaktern 1.825 Karten spielen"
  },
  Task_74725_Desc = {
    Text = "Mit gesegneten Charakteren 1.175 Karten ausspielen"
  },
  Task_74726_Desc = {
    Text = "175 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74727_Desc = {
    Text = "Mit gesegneten Charakteren 750 Karten spielen"
  },
  Task_74728_Desc = {
    Text = "850 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74729_Desc = {
    Text = "1650 Karten mit einem Kampfcharakter ausspielen"
  },
  Task_74730_Desc = {
    Text = "1275 Karten mit einem Kampf-Charakter spielen"
  },
  Task_74731_Desc = {
    Text = "1175 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74732_Desc = {
    Text = "Mit einem Charakter des Typs „Intelligenz“ 1975 Karten spielen"
  },
  Task_74733_Desc = {
    Text = "275 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74734_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1425 Karten spielen"
  },
  Task_74735_Desc = {
    Text = "1900 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74736_Desc = {
    Text = "Mit gesegneten Charakteren 1.600 Karten ausspielen"
  },
  Task_74737_Desc = {
    Text = "Mit einem Charakter des Bösen Sterns 600 Karten ausspielen"
  },
  Task_74738_Desc = {
    Text = "1050 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74739_Desc = {
    Text = "1.400 Karten mit einem Charakter des Bösen Sterns spielen"
  },
  Task_74740_Desc = {
    Text = "Mit gesegneten Charakteren 200 Karten ausspielen"
  },
  Task_74741_Desc = {
    Text = "Mit gesegneten Charakteren 500 Karten ausspielen"
  },
  Task_74742_Desc = {
    Text = "1225 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74743_Desc = {
    Text = "525 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74744_Desc = {
    Text = "400 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74745_Desc = {
    Text = "Mit gesegneten Charakteren 1.400 Karten ausspielen"
  },
  Task_74746_Desc = {
    Text = "425 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_74747_Desc = {
    Text = "475 Karten mit einem Kampf-Charakter spielen"
  },
  Task_74748_Desc = {
    Text = "475 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74749_Desc = {
    Text = "Mit gesegneten Charakteren 1.475 Karten spielen"
  },
  Task_74750_Desc = {
    Text = "300 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74751_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1575 Karten spielen"
  },
  Task_74752_Desc = {
    Text = "1675 Karten mit einem Defensiv-Charakter ausspielen"
  },
  Task_74753_Desc = {
    Text = "975 Karten mit einem Defensiv-Charakter ausspielen"
  },
  Task_74754_Desc = {
    Text = "1250 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74755_Desc = {
    Text = "Mit einem Intelligenz-Charakter 850 Karten spielen"
  },
  Task_74756_Desc = {
    Text = "Mit gesegneten Charakteren 1.200 Karten ausspielen"
  },
  Task_74757_Desc = {
    Text = "1.650 Karten mit einem Charakter des Bösen Sterns spielen"
  },
  Task_74758_Desc = {
    Text = "200 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74759_Desc = {
    Text = "Mit gesegneten Charakteren 1.950 Karten ausspielen"
  },
  Task_74760_Desc = {
    Text = "950 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74761_Desc = {
    Text = "Mit gesegneten Charakteren 450 Karten ausspielen"
  },
  Task_74762_Desc = {
    Text = "Mit einem Intelligenz-Charakter 1400 Karten spielen"
  },
  Task_74763_Desc = {
    Text = "325 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74764_Desc = {
    Text = "925 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74765_Desc = {
    Text = "1825 Karten mit einem Charakter des Bösen Sterns spielen"
  },
  Task_74766_Desc = {
    Text = "300 Karten mit einem Charakter des Bösen Sterns ausspielen"
  },
  Task_74767_Desc = {
    Text = "Mit gesegneten Charakteren 1.300 Karten spielen"
  },
  Task_74768_Desc = {
    Text = "425 Karten mit einem Kampf-Charakter ausspielen"
  },
  Task_74769_Desc = {
    Text = "825 Karten mit einem Verteidigungs-Charakter ausspielen"
  },
  Task_75738_Desc = {
    Text = "Vollständig \"Kopflose Leiche\" auf beliebiger Schwierigkeit"
  },
  Task_75739_Desc = {
    Text = "Abschluss von „Gehöre dem Meer aus Asche“ in einem beliebigen Modus"
  },
  Task_75740_Desc = {
    Text = "Abschließen des «Sumpfgeists» im beliebigen Schwierigkeitsgrad"
  },
  Task_75741_Desc = {
    Text = "Abschluss von „Regennachtjagd“ in beliebigem Modus"
  },
  Task_75742_Desc = {
    Text = "Abschließen von „Es und sie“ im beliebigen Modus"
  },
  Task_76237_Desc = {
    Text = "Abschließen des Sternenkapitels - Kapitel 1, 1-5 auf schwerem Schwierigkeitsgrad"
  },
  Task_76238_Desc = {
    Text = "Schlusskapitel “Langer Traum endet“ abgeschlossen"
  },
  Task_76239_Desc = {
    Text = "Abgeschlossen: Sternenkapitel Kapitel 1, 1-6"
  },
  Task_76240_Desc = {
    Text = "Abschluss des finalen Kapitels 9-3 in hartem Schwierigkeitsgrad"
  },
  Task_76241_Desc = {
    Text = "Abschluss des letzten Kapitels „Langer Traum endet“ im schweren Schwierigkeitsgrad"
  },
  Task_76242_Desc = {
    Text = "Abschluss des Schlusskapitels „Langer Traum endet“"
  },
  Task_76243_Desc = {
    Text = "Abschließen des Sternenkapitels Kapitel 1 „Rückkehr in die Nebelstadt“ im schweren Schwierigkeitsgrad"
  },
  Task_76244_Desc = {
    Text = "Durchspielen des Sternenkapitels Kapitel 1 „Rückkehr in die Nebelstadt“ im schweren Schwierigkeitsgrad"
  },
  Task_76245_Desc = {
    Text = "Abschluss des Schlusskapitels 9-4"
  },
  Task_76246_Desc = {
    Text = "Sternenkapitel - Kapitel 1, Mission 1-6 abgeschlossen"
  },
  Task_76247_Desc = {
    Text = "Durchqueren des Sternenkapitels Kapitel 1 „Rückkehr in die Nebelstadt“"
  },
  Task_76248_Desc = {
    Text = "Abschluss des Sternenkapitels – Kapitel 1, 1-5 im Schwierigkeitsgrad „Schwer“"
  },
  Task_76249_Desc = {
    Text = "Abschluss des letzten Kapitels „Langer Traum endet“ im schweren Schwierigkeitsgrad"
  },
  Task_76250_Desc = {
    Text = "Abschluss des finalen Kapitels 9-3 in hartem Schwierigkeitsgrad"
  },
  Task_76251_Desc = {
    Text = "Abschluss des Schlusskapitels 9-4"
  },
  Task_76252_Desc = {
    Text = "Durchqueren des Sternenkapitels Kapitel 1 “Wiederkehr in die Nebelstadt“"
  },
  Task_76339_Desc = {
    Text = "Abschließen von „Gehöre dem Meer aus Asche“ in einem beliebigen Modus"
  },
  Task_76340_Desc = {
    Text = "Hexenladen·Wahnsinn"
  },
  Task_76341_Desc = {
    Text = "Abschließen von “Regennachtjagd“ im Wahnsinnsmodus"
  },
  Task_76342_Desc = {
    Text = "Abschluss von „Sumpfgeist“ im Wahnsinnsmodus"
  },
  Task_76343_Desc = {
    Text = "Abschließen von “Es und sie“ im beliebigen Modus"
  },
  Task_76344_Desc = {
    Text = "Hexen-Schatzkammer"
  },
  Task_76345_Desc = {
    Text = "Im “Prächtischer Schatz“-Austausch 300 Gegenstände erhalten"
  },
  Task_76346_Desc = {
    Text = "150 Gegenstände im „Prächtischer Schatz“-Austausch erhalten"
  },
  Task_76347_Desc = {
    Text = "Die \"Köpflosen Leiche\" auf Wahnsinn-Schwierigkeit beseitigen"
  },
  Task_76348_Desc = {
    Text = "Abschluss von „Regennachtjagd“ in beliebigem Modus"
  },
  Task_76349_Desc = {
    Text = "Abschließen von „Es und sie“ im Wahnsinnsmodus"
  },
  Task_76350_Desc = {
    Text = "Abschluss von „Zum Meer der Asche zurückkehren“ im Wahnsinnsmodus"
  },
  Task_76351_Desc = {
    Text = "Erhalte 150 Gegenstände im “Besondere Sammlungsstücke“-Austausch"
  },
  Task_76352_Desc = {
    Text = "Abschluss von Spezialeinsatzprotokoll „Schatten des Regenstädtchens“"
  },
  Task_76353_Desc = {
    Text = "Alle Aufgaben von „Hexenläden – Durchgang“ abschließen"
  },
  Task_76354_Desc = {
    Text = "Im „Besondere Sammlungsstücke“-Austausch 300 Gegenstände erhalten"
  },
  Task_76355_Desc = {
    Text = "Beliebigen Schwierigkeitsgrad von „Sumpfgeist“ abschließen"
  },
  Task_76356_Desc = {
    Text = "300 Gegenstände im „Sorge lösendes Produkt“-Austausch erhalten"
  },
  Task_76357_Desc = {
    Text = "150 Gegenstände im „Sorge lösendes Produkt“-Austausch erhalten"
  },
  Task_76358_Desc = {
    Text = "Hexenladen·Abschluss"
  },
  Task_76359_Desc = {
    Text = "Vollständig \"Kopflose Leiche\" auf beliebiger Schwierigkeit"
  },
  Task_77674_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_77674_Name = {Text = "10 Siege"},
  Task_77675_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_77675_Name = {Text = "1 Sieg"},
  Task_77676_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_77676_Name = {Text = "3 Siege"},
  Task_77677_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_77677_Name = {Text = "6 Siege"},
  Task_78106_Desc = {
    Text = "Verwende “Ringfahrt · Ramona“, um 6 Siege zu erringen"
  },
  Task_78107_Desc = {
    Text = "Verwende den “Blick von Isarau“, um 6 Siege zu erringen"
  },
  Task_78108_Desc = {
    Text = "Verwende “standhafte Willenskraft“, um 6 Siege zu erringen"
  },
  Task_78109_Desc = {
    Text = "Verwende “Erica“, um 10 Siege zu erringen"
  },
  Task_78112_Desc = {
    Text = "Verwende “Lily“, um 6 Siege zu erzielen"
  },
  Task_78113_Desc = {
    Text = "Verwende “Mittsommernachtstraum“, um 6 Siege zu erringen"
  },
  Task_78114_Desc = {
    Text = "Verwende “Alle ihre Teile“, um 6 Siege zu erringen"
  },
  Task_78115_Desc = {
    Text = "Verwende „Blutkette · Helot“ um 10 Siege zu erringen"
  },
  Task_78116_Desc = {
    Text = "Verwende “Ryker“, um 10 Siege zu erringen"
  },
  Task_78117_Desc = {
    Text = "Verwende “Ramona“, um 10 Siege zu erringen"
  },
  Task_78118_Desc = {
    Text = "Verwende “Ningphia“, um 6 Siege zu erringen"
  },
  Task_78119_Desc = {
    Text = "Verwende “Im Namen der Rose“, um 6 Siege zu erringen"
  },
  Task_78120_Desc = {
    Text = "Verwende “Agrippa“, um 6 Siege zu erringen"
  },
  Task_78122_Desc = {
    Text = "Verwende «Miryam», um 6 Siege zu erzielen"
  },
  Task_78123_Desc = {
    Text = "Verwende “Liz“, um 6 Siege zu erzielen"
  },
  Task_78124_Desc = {
    Text = "Verwende “Verbannung“, um 6 Siege zu erzielen"
  },
  Task_78125_Desc = {
    Text = "Verwende “Gnade“, um 6 Siege zu erzielen"
  },
  Task_78126_Desc = {
    Text = "Verwende “Menschen im Spiegel“, um 6 Siege zu erringen"
  },
  Task_78127_Desc = {
    Text = "Verwende „Tag der befreiten Ketten“, um 6 Siege zu erringen"
  },
  Task_78128_Desc = {
    Text = "Verwende “verlorener Pfad“, um 6 Siege zu erringen"
  },
  Task_78129_Desc = {
    Text = "Verwende „Tinkter“, um 6 Siege zu erzielen"
  },
  Task_78130_Desc = {
    Text = "Verwende “Moment der Begegnung“, um 6 Siege zu erringen"
  },
  Task_78131_Desc = {
    Text = "Verwende “Pandia“, um 6 Siege zu erringen"
  },
  Task_78132_Desc = {
    Text = "Verwende “Salvador“, um 10 Siege zu erringen"
  },
  Task_78133_Desc = {
    Text = "Verwende “Meerestraum“, um 6 Siege zu erringen"
  },
  Task_78134_Desc = {
    Text = "Verwende “Tor der Wahrheit“, um 6 Siege zu erringen"
  },
  Task_78135_Desc = {
    Text = "Verwende „Raserei“, um 6 Siege zu erzielen"
  },
  Task_78137_Desc = {
    Text = "Verwende “Schmerzende Flosse“, um 6 Siege zu erringen"
  },
  Task_78138_Desc = {
    Text = "Verwende „Helot“, um 10 Siege zu erringen."
  },
  Task_78139_Desc = {Text = "Erwecker"},
  Task_78140_Desc = {
    Text = "Verwende “24“, um 6 Siege zu erzielen"
  },
  Task_78141_Desc = {
    Text = "Verwende «Casja», um 6 Siege zu erzielen"
  },
  Task_78142_Desc = {
    Text = "Verwende “Tawil“, um 6 Siege zu erzielen"
  },
  Task_78143_Desc = {
    Text = "Verwende «Golia», um 6 Siege zu erringen"
  },
  Task_78144_Desc = {
    Text = "Verwende “24“, um 10 Siege zu erringen"
  },
  Task_78145_Desc = {
    Text = "Verwende das “Götterspruch-Tablett“, um 6 Siege zu erringen"
  },
  Task_78146_Desc = {
    Text = "Verwende “ewiges Requiem“, um 6 Siege zu erringen"
  },
  Task_78147_Desc = {
    Text = "Verwende “Bestrafung“, um 6 Siege zu erringen"
  },
  Task_78148_Desc = {
    Text = "Verwende “Wunderherabkunft“, um 6 Siege zu erringen"
  },
  Task_78149_Desc = {
    Text = "Verwende “Zeilenende des Gedichts“, um 6 Siege zu erringen"
  },
  Task_78150_Desc = {
    Text = "Verwende “Menschenpuppe, die ins Nichts fällt“, um 6 Siege zu erzielen"
  },
  Task_78151_Desc = {
    Text = "Verwende “Stilles Gelage“, um 6 Siege zu erringen"
  },
  Task_78152_Desc = {
    Text = "Verwende “fromme Kraft“, um 6 Siege zu erzielen"
  },
  Task_78153_Desc = {
    Text = "Verwende “Tulu“, um 10 Siege zu erzielen"
  },
  Task_78154_Desc = {
    Text = "Verwende “Entschlossenheit des Schellfischs“, um 6 Siege zu erzielen"
  },
  Task_78155_Desc = {
    Text = "Verwende “Gier“, um 6 Siege zu erringen"
  },
  Task_78159_Desc = {
    Text = "Erziele mit “Mingwu“ 6 Siege"
  },
  Task_78160_Desc = {
    Text = "Verwende “Grauer Nebel – Wahres Antlitz“, um 6 Siege zu erringen"
  },
  Task_78161_Desc = {
    Text = "Verwende “Blutiges Gelage“, um 6 Siege zu erzielen"
  },
  Task_78162_Desc = {
    Text = "Verwende “Zwinkern“, um 6 Siege zu erzielen"
  },
  Task_78163_Desc = {
    Text = "Verwende “Auge der millionenfachen Gunst“, um 6 Siege zu erringen"
  },
  Task_78164_Desc = {
    Text = "Verwende “Gemurmel“, um 6 Siege zu erringen"
  },
  Task_78166_Desc = {
    Text = "Verwende “Puppe“, um 6 Siege zu erzielen"
  },
  Task_78168_Desc = {
    Text = "Verwende “Agrippa“, um 10 Siege zu erringen"
  },
  Task_78169_Desc = {
    Text = "Verwende „Lotan“, um 10 Siege zu erzielen"
  },
  Task_78170_Desc = {
    Text = "Verwende «Golia», um 10 Siege zu erringen"
  },
  Task_78171_Desc = {
    Text = "Verwende „Versinken in Scharlach“, um 6 Siege zu erringen"
  },
  Task_78172_Desc = {
    Text = "Verwende “Pandia“, um 10 Siege zu erringen"
  },
  Task_78173_Desc = {
    Text = "Verwende die «Fabel vom Taotie», um 6 Siege zu erringen"
  },
  Task_78174_Desc = {
    Text = "Verwende “Glücksrad“, um 6 Siege zu erringen"
  },
  Task_78175_Desc = {
    Text = "Verwende „Schnitt und Schaden“, um 6 Siege zu erringen."
  },
  Task_78176_Desc = {
    Text = "Verwende “Hymne des Götterkönigs“, um 6 Siege zu erringen"
  },
  Task_78177_Desc = {
    Text = "Mit “Schmelzende Blüte“ 10 Siege erringen"
  },
  Task_78178_Desc = {
    Text = "Verwende “Leigh“, um 6 Siege zu erzielen"
  },
  Task_78179_Desc = {Text = "Schicksrad"},
  Task_78180_Desc = {
    Text = "Verwende “Helot“, um 6 Siege zu erringen"
  },
  Task_78181_Desc = {
    Text = "Verwende “Winternachtserinnerung“, um 6 Siege zu erringen"
  },
  Task_78182_Desc = {
    Text = "Verwende “Raubtier des Riesen“, um 6-mal zu siegen"
  },
  Task_78183_Desc = {
    Text = "Verwende “Daphdelle“, um 10 Siege zu erringen"
  },
  Task_78184_Desc = {
    Text = "Verwende “Segel des Kurswechsels“, um 6 Siege zu erringen"
  },
  Task_78185_Desc = {
    Text = "Verwende “Ryker“, um 6 Siege zu erzielen"
  },
  Task_78186_Desc = {
    Text = "Verwende «Fient», um 6 Siege zu erringen"
  },
  Task_78187_Desc = {
    Text = "Verwende “Vergessene Hand“, um 6 Siege zu erringen"
  },
  Task_78188_Desc = {
    Text = "Verwende «Thais», um 6 Siege zu erringen"
  },
  Task_78189_Desc = {
    Text = "Verwende “Ningphia“, um 10-mal zu siegen"
  },
  Task_78190_Desc = {
    Text = "Verwende “Wanda“, um 6-mal zu siegen"
  },
  Task_78192_Desc = {
    Text = "Verwende “Nodira“, um 6 Siege zu erringen"
  },
  Task_78193_Desc = {
    Text = "Verwende “Aigis“, um 6 Siege zu erringen"
  },
  Task_78194_Desc = {
    Text = "Verwende “Unmögliche Berechnung“, um 6 Siege zu erzielen"
  },
  Task_78196_Desc = {
    Text = "Verwende das “Königinnen-Gebot“, um 6 Siege zu erringen"
  },
  Task_78197_Desc = {
    Text = "Verwende “Oreta“, um 6 Siege zu erringen"
  },
  Task_78198_Desc = {
    Text = "Verwende “Ringfahrt · Ramona“, um 10 Siege zu erringen"
  },
  Task_78199_Desc = {
    Text = "Verwende “Im Schatten der Nacht“, um 6 Siege zu erringen"
  },
  Task_78200_Desc = {
    Text = "Verwende “Blutkette · Heilote“, um 6 Siege zu erringen"
  },
  Task_78201_Desc = {
    Text = "Verwende „Schmerzgrenze“, um 6 Siege zu erringen"
  },
  Task_78202_Desc = {
    Text = "Verwende “Riesenschwert“, um 6 Siege zu erringen"
  },
  Task_78203_Desc = {
    Text = "Verwende „Alva“, um 10 Siege zu erringen"
  },
  Task_78204_Desc = {
    Text = "Verwende “Kipppunkt“, um 6 Siege zu erringen"
  },
  Task_78205_Desc = {
    Text = "Verwende “Tod der Korallenfrau“, um 6 Siege zu erringen"
  },
  Task_78206_Desc = {
    Text = "Verwende das „einzigartige Saatgut“, um 6 Siege zu erringen"
  },
  Task_78208_Desc = {
    Text = "Verwende “Schluckendes Wiegenlied“, um 6 Siege zu erringen"
  },
  Task_78209_Desc = {
    Text = "Verwende „Brief an einen engen Freund“, um 6 Siege zu erringen"
  },
  Task_78210_Desc = {
    Text = "Verwende “Konzentrierter Geist“, um 6 Siege zu erzielen"
  },
  Task_78212_Desc = {
    Text = "Verwende „Gedächtnissyndrom“, um 6 Siege zu erzielen"
  },
  Task_78213_Desc = {
    Text = "Verwende „Daphdelle“, um 6 Siege zu erringen"
  },
  Task_78214_Desc = {
    Text = "Verwende „Bis der Schneeberg schmilzt“, um 6 Siege zu erringen"
  },
  Task_78216_Desc = {
    Text = "Verwende „Hoffnung“, um 6 Siege zu erringen"
  },
  Task_78217_Desc = {
    Text = "Verwende “Polarnacht und Morgenröte“, um 6 Siege zu erringen"
  },
  Task_78218_Desc = {
    Text = "Verwende “Murphy“, um 10 Siege zu erzielen"
  },
  Task_78219_Desc = {
    Text = "Verwende “Ungleichen Austausch“, um 6 Siege zu erzielen"
  },
  Task_78220_Desc = {
    Text = "Verwende “Oretas Schatz“, um 6 Siege zu erringen"
  },
  Task_78221_Desc = {
    Text = "Verwende “Egis“, um 10 Siege zu erringen"
  },
  Task_78223_Desc = {
    Text = "Verwende den “Herrenstab“, um 6 Siege zu erringen"
  },
  Task_78224_Desc = {
    Text = "Verwende “Wogende Begierde“, um 6 Siege zu erringen"
  },
  Task_78225_Desc = {
    Text = "Verwende “Yuwhasi“, um 6 Siege zu erringen"
  },
  Task_78226_Desc = {
    Text = "Verwende “Miryam“, um 10 Siege zu erringen"
  },
  Task_78227_Desc = {
    Text = "Verwende „Ramona“, um 6 Siege zu erzielen"
  },
  Task_78228_Desc = {
    Text = "Verwende “Herz des Ritters“, um 6 Siege zu erringen"
  },
  Task_78229_Desc = {
    Text = "6 Siege mit “Schmelzende Blüte“ erringen"
  },
  Task_78230_Desc = {
    Text = "Verwende “Kostbarste Sammlung“, um 6 Siege zu erringen"
  },
  Task_78231_Desc = {
    Text = "Verwende “Abenteuerlicher Proviant“, um 6 Siege zu erringen"
  },
  Task_78232_Desc = {
    Text = "Verwende “Muzus Segen“, um 6 Siege zu erzielen"
  },
  Task_78233_Desc = {
    Text = "Verwende «Alva», um 6 Siege zu erringen"
  },
  Task_78234_Desc = {
    Text = "Verwende “letzter Schwur“, um 6 Siege zu erzielen"
  },
  Task_78235_Desc = {
    Text = "Verwende „Orla“, um 6 Siege zu erringen."
  },
  Task_78236_Desc = {
    Text = "Verwende “Im Regensturm“, um 6 Siege zu erringen"
  },
  Task_78237_Desc = {
    Text = "Verwende “Puppe“, um 10 Siege zu erzielen"
  },
  Task_78238_Desc = {
    Text = "Verwende “Jenseits des Todes“, um 6 Siege zu erringen"
  },
  Task_78239_Desc = {
    Text = "Verwende “Sternentier“, um 6 Siege zu erringen"
  },
  Task_78240_Desc = {
    Text = "Verwende “Brüllendes Blut und Sand“, um 6 Siege zu erringen"
  },
  Task_78241_Desc = {
    Text = "Verwende “Blick über den See“, um 6 Siege zu erzielen"
  },
  Task_78242_Desc = {
    Text = "Verwende “Jenkin“, um 10 Siege zu erringen"
  },
  Task_78243_Desc = {Text = "Posse"},
  Task_78244_Desc = {
    Text = "Verwende “Blasser Abkömmling“, um 6 Siege zu erringen"
  },
  Task_78245_Desc = {
    Text = "Verwende „Caecus“, um 6 Siege zu erringen"
  },
  Task_78246_Desc = {
    Text = "Verwende „Hamlin“, um 6 Siege zu erringen"
  },
  Task_78247_Desc = {
    Text = "Verwende „Orla“, um 10 Siege zu erringen."
  },
  Task_78248_Desc = {
    Text = "Verwende “Kernschmelze“, um 6 Siege zu erringen"
  },
  Task_78249_Desc = {
    Text = "Verwende «Delirium», um 6 Siege zu erringen"
  },
  Task_78250_Desc = {
    Text = "Verwende “verborgene Geburt“, um 6 Siege zu erzielen"
  },
  Task_78251_Desc = {
    Text = "Verwende „Oreta“, um 10 Siege zu erringen"
  },
  Task_78252_Desc = {
    Text = "Verwende “Murphy“, um 6 Siege zu erzielen"
  },
  Task_78253_Desc = {
    Text = "Verwende “reines Silber der ursprünglichen Absicht“, um 6 Siege zu erringen"
  },
  Task_78254_Desc = {
    Text = "Verwende “Tulu“, um 6 Siege zu erzielen"
  },
  Task_78255_Desc = {
    Text = "Verwende „Shan“, um 6 Siege zu erringen"
  },
  Task_78256_Desc = {
    Text = "Verwende “Jenkin“, um 6 Siege zu erzielen"
  },
  Task_78257_Desc = {
    Text = "Verwende «Winkler», um 10 Siege zu erringen"
  },
  Task_78258_Desc = {
    Text = "Verwende “Wanda“, um 10 Siege zu erzielen"
  },
  Task_78261_Desc = {
    Text = "Verwende das “Zeitkreis-Chronometer“, um 6 Siege zu erringen"
  },
  Task_78262_Desc = {
    Text = "Verwende “Sieg der Rose“, um 6-mal zu siegen"
  },
  Task_78263_Desc = {
    Text = "Verwende «Ogier», um 10 Siege zu erringen"
  },
  Task_78264_Desc = {
    Text = "Verwende “Farrow“, um 6 Siege zu erringen"
  },
  Task_78265_Desc = {
    Text = "Verwende “Fient“, um 10 Siege zu erzielen"
  },
  Task_78266_Desc = {
    Text = "Verwende “Hamlin“, um 10 Siege zu erzielen"
  },
  Task_78267_Desc = {
    Text = "Verwende “Barmherzige Ernährung“, um 6 Siege zu erringen"
  },
  Task_78269_Desc = {
    Text = "Verwende “Anatomie des Todes“, um 6-mal zu siegen"
  },
  Task_78270_Desc = {
    Text = "Verwende “Gereift“, um 6 Siege zu erzielen"
  },
  Task_78272_Desc = {
    Text = "Verwende “Information ist Leben“, um 6 Siege zu erringen"
  },
  Task_78273_Desc = {
    Text = "Verwende “Knochenfressende Umarmung“, um 6 Siege zu erringen"
  },
  Task_78274_Desc = {
    Text = "Verwende „Sanga“, um 10 Siege zu erringen"
  },
  Task_78275_Desc = {
    Text = "Verwende „Schlaf unter dem Gletscher“, um 6 Siege zu erringen"
  },
  Task_78276_Desc = {
    Text = "Verwende “Erica“, um 6 Siege zu erzielen"
  },
  Task_78277_Desc = {
    Text = "Verwende das “verborgene Rad“, um 6 Siege zu erringen"
  },
  Task_78278_Desc = {
    Text = "Verwende “35-mm-Magie“, um 6 Siege zu erzielen"
  },
  Task_78279_Desc = {
    Text = "Verwende “Stimme im Kopf“, um 6 Siege zu erringen"
  },
  Task_78280_Desc = {
    Text = "Verwende “Glückliche Zeit“, um 6 Siege zu erringen"
  },
  Task_78281_Desc = {
    Text = "Verwende “Karen“, um 10 Siege zu erzielen"
  },
  Task_78282_Desc = {
    Text = "Verwende “Tawil“, um 10 Siege zu erringen"
  },
  Task_78283_Desc = {
    Text = "Verwende “Ujuhashi“, um 10 Siege zu erringen"
  },
  Task_78284_Desc = {
    Text = "Verwende “Liz“, um 10 Siege zu erzielen"
  },
  Task_78286_Desc = {
    Text = "Verwende “Herzbarriere“, um 6 Siege zu erringen"
  },
  Task_78287_Desc = {
    Text = "Verwende “Casja“, um 10 Siege zu erringen"
  },
  Task_78288_Desc = {
    Text = "Verwende “Missgestalteter Rückenschlag“, um 6 Siege zu erringen"
  },
  Task_78289_Desc = {
    Text = "Verwende “unaufhörliches Konzert“, um 6 Siege zu erringen"
  },
  Task_78290_Desc = {
    Text = "Verwende “Fluchfessel“, um 6 Siege zu erringen"
  },
  Task_78291_Desc = {
    Text = "Verwende «Celest», um 10 Siege zu erringen"
  },
  Task_78292_Desc = {
    Text = "Verwende „Nicht-Ort“, um 6 Siege zu erringen"
  },
  Task_78294_Desc = {
    Text = "Verwende “Tinkter“, um 10 Siege zu erzielen"
  },
  Task_78295_Desc = {
    Text = "Verwende „Farrow“, um 10 Siege zu erringen."
  },
  Task_78296_Desc = {
    Text = "Verwende “Lily“, um 10 Siege zu erringen"
  },
  Task_78297_Desc = {
    Text = "Verwende „flüchtige Ewigkeit“, um 6 Siege zu erringen"
  },
  Task_78298_Desc = {
    Text = "Erziele 6 Siege mit “Aktiv“"
  },
  Task_78299_Desc = {
    Text = "Verwende “Nautila“, um 10 Siege zu erringen"
  },
  Task_78301_Desc = {
    Text = "Verwende “Salvador“, um 6 Siege zu erzielen"
  },
  Task_78303_Desc = {
    Text = "Verwende “Saugen“, um 6 Siege zu erringen"
  },
  Task_78304_Desc = {
    Text = "Verwende “Kaiques“, um 10 Siege zu erringen"
  },
  Task_78305_Desc = {
    Text = "Verwende «Ogier», um 6 Siege zu erringen"
  },
  Task_78306_Desc = {
    Text = "Verwende „Pflichtbewusstsein“, um 6 Siege zu erringen"
  },
  Task_78307_Desc = {
    Text = "Verwende «Sorel», um 10 Siege zu erringen"
  },
  Task_78308_Desc = {
    Text = "Verwende “Frohes Zaubertheater“, um 6 Siege zu erringen"
  },
  Task_78309_Desc = {
    Text = "Verwende “Einsicht“, um 6 Siege zu erringen"
  },
  Task_78310_Desc = {
    Text = "Verwende “Celest“, um 6 Siege zu erzielen"
  },
  Task_78313_Desc = {
    Text = "Verwende „Emergenz“, um 6 Siege zu erzielen"
  },
  Task_78314_Desc = {
    Text = "Verwende “Leah“, um 10 Siege zu erzielen"
  },
  Task_78315_Desc = {
    Text = "Verwende “Gefesseltes Lied“, um 6 Siege zu erringen"
  },
  Task_78316_Desc = {
    Text = "Verwende “Sorel“, um 6 Siege zu erringen"
  },
  Task_78317_Desc = {
    Text = "Verwende „Karen“, um 6 Siege zu erzielen"
  },
  Task_78318_Desc = {
    Text = "Karte spielen"
  },
  Task_78319_Desc = {
    Text = "Verwende „Lotan“, um 6 Siege zu erringen"
  },
  Task_78320_Desc = {
    Text = "Verwende “Verfallsgabe“, um 6 Siege zu erringen"
  },
  Task_78321_Desc = {
    Text = "Verwende “Thais“, um 10 Siege zu erringen"
  },
  Task_78322_Desc = {
    Text = "Verwende “Speicherspirale“, um 6 Siege zu erringen"
  },
  Task_78326_Desc = {
    Text = "Kadigura hat die Affinität von Level 10 erreicht"
  },
  Task_78327_Desc = {
    Text = "Alfogem hat die Affinität Stufe 10 erreicht"
  },
  Task_78328_Desc = {
    Text = "Pollux erreicht den Affinitätsgrad 10"
  },
  Task_78329_Desc = {
    Text = "Geier erreicht den Affinitätsgrad 10"
  },
  Task_78332_Desc = {
    Text = "Lantigos hat die Affinität von Level 10 erreicht"
  },
  Task_78333_Desc = {
    Text = "Carabos erreicht die Affinitätsstufe 10"
  },
  Task_78334_Desc = {
    Text = "Kepsant hat die Affinität Stufe 10 erreicht"
  },
  Task_78336_Desc = {
    Text = "Arachne-Synchro-Rate erreicht Stufe 10"
  },
  Task_78338_Desc = {
    Text = "Schwarzer Pharao: Affinität Stufe 10 erreicht"
  },
  Task_78339_Desc = {
    Text = "Shatak-Vogel erreicht die Affinität Stufe 10"
  },
  Task_78340_Desc = {
    Text = "Pikmann hat die Affinität von Level 10 erreicht"
  },
  Task_78341_Desc = {
    Text = "Clementine hat die Affinität von Stufe 10 erreicht"
  },
  Task_78342_Desc = {
    Text = "Castor erreicht die Affinität von Stufe 10"
  },
  Task_78366_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78367_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78368_Desc = {
    Text = "Erwirb den Shatan-Vogel bei Erleuchtungsstufe 6"
  },
  Task_78368_Name = {
    Text = "Erwirb den Shatan-Vogel bei Erleuchtung 6"
  },
  Task_78368_UnlockCondDesc = {
    Text = "Aktivität @Erweckungswesen Shatan-Vogel Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_78369_Desc = {
    Text = "Erhalte Kätigula bei der Erleuchtung 6"
  },
  Task_78369_Name = {
    Text = "Erhalte Kätigula bei Erleuchtung 6"
  },
  Task_78369_UnlockCondDesc = {
    Text = "Aktivität @Erweckungswesen Katigora Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_78370_Desc = {
    Text = "Erwirb den Shatan-Vogel bei Erleuchtung 2"
  },
  Task_78370_Name = {
    Text = "Erwirb einen Shatan-Vogel bei Erleuchtung Stufe 2"
  },
  Task_78370_UnlockCondDesc = {
    Text = "Aktivität @Erweckungswesen Shantak-Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_78371_Desc = {
    Text = "Erwirb Kätigula bei Erleuchtung 2"
  },
  Task_78371_Name = {
    Text = "Erwirb Kätigula bei Erleuchtung 2"
  },
  Task_78371_UnlockCondDesc = {
    Text = "Aktivität @Erweckungswesen Katigora Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_78372_Desc = {
    Text = "Erwirb Pollux bei Erleuchtung 2"
  },
  Task_78372_Name = {
    Text = "Erwirb Pollux bei Erleuchtung 2"
  },
  Task_78372_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Pollux Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_78373_Desc = {
    Text = "Erwirb Pollux bei Erleuchtung 6"
  },
  Task_78373_Name = {
    Text = "Erhalte Pollux bei Erleuchtung 6"
  },
  Task_78373_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Pollux Erleuchten Paket 2 Aktivität"
  },
  Task_78375_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78379_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78380_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78382_Desc = {
    Text = "Erwachen 6 beim Erwerb von Arachne"
  },
  Task_78382_Name = {
    Text = "Erwachen 6 beim Erwerb von Arachne"
  },
  Task_78382_UnlockCondDesc = {
    Text = "Aktivität@ErweckerArachneErwachenGeschenkpaket2Aktivität"
  },
  Task_78383_Desc = {
    Text = "Erwachen 2 beim Erhalten von Arachne"
  },
  Task_78383_Name = {
    Text = "Erwachen 2 beim Erhalten von Arachne"
  },
  Task_78383_UnlockCondDesc = {
    Text = "Aktivität@ErweckerArachneErwachenGeschenkpaket2Aktivität"
  },
  Task_78384_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78385_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78390_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78391_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78394_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78395_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78396_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78397_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78400_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78401_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78402_Desc = {
    Text = "Erwirb Pickman bei Erleuchtung 6"
  },
  Task_78402_Name = {
    Text = "Erwirb Pickman bei Erleuchtung 6"
  },
  Task_78402_UnlockCondDesc = {
    Text = "Aktivität @Erweckungswesen Pickman Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_78403_Desc = {
    Text = "Erwirb Pickman bei Erleuchtung 2"
  },
  Task_78403_Name = {
    Text = "Erhalte Pickman bei der Erleuchtung 2"
  },
  Task_78403_UnlockCondDesc = {
    Text = "Aktivität @Erweckungswesen Pickman Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_78404_Desc = {
    Text = "Erwirb Castor bei Erleuchtung Stufe 2"
  },
  Task_78404_Name = {
    Text = "Erwirb Castor bei Erleuchtung Stufe 2"
  },
  Task_78404_UnlockCondDesc = {
    Text = "Aktivität @Erweckungswesen Kastor Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_78405_Desc = {
    Text = "Erwirb Castor bei Erleuchtungsstufe 6"
  },
  Task_78405_Name = {
    Text = "Erwirb Castor bei Erleuchtungsstufe 6"
  },
  Task_78405_UnlockCondDesc = {
    Text = "Aktivität @Erweckungswesen Kastor Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_78409_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78415_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78416_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78418_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78419_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78421_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78423_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78424_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78426_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78429_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78430_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78431_Desc = {
    Text = "Erhalte Carab bei Erleuchtung 2"
  },
  Task_78431_Name = {
    Text = "Erhalte Carab bei Erleuchtung 2"
  },
  Task_78431_UnlockCondDesc = {
    Text = "Aktivität @Erweckungswesen Karabu Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_78432_Desc = {
    Text = "Erwirb Carab bei Erleuchtung 6"
  },
  Task_78432_Name = {
    Text = "Erhalte Carab bei Erleuchtung 6"
  },
  Task_78432_UnlockCondDesc = {
    Text = "Aktivität @Erweckungswesen Karabu Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_78435_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78436_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78437_Desc = {
    Text = "Erwirb Aforgamon bei Erleuchtung Stufe 2"
  },
  Task_78437_Name = {
    Text = "Erhalte Aforgamon bei Erleuchtung Stufe 2"
  },
  Task_78437_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Avfagomon Erleuchten Paket 2 Aktivität"
  },
  Task_78438_Desc = {
    Text = "Erwirb Clementine bei Erleuchtung Stufe 2"
  },
  Task_78438_Name = {
    Text = "Erwirb Clementine bei Erleuchtung Stufe 2"
  },
  Task_78438_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Clementine Erleuchten Paket 2 Aktivität"
  },
  Task_78440_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78441_Desc = {
    Text = "Erwirb Clementine bei Erleuchtungsstufe 6"
  },
  Task_78441_Name = {
    Text = "Erwirb Clementine bei Erleuchtungsstufe 6"
  },
  Task_78441_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Clementine Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_78446_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78447_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78449_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78450_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78451_Desc = {
    Text = "Erhalte Schwarzer Pharao bei Erleuchtung 2"
  },
  Task_78451_Name = {
    Text = "Erhalte Schwarzer Pharao bei Erleuchtung 2"
  },
  Task_78451_UnlockCondDesc = {
    Text = "Aktivität @Erweckungswesen Schwarzer Pharao Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_78453_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78458_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78459_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78460_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78466_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78468_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78470_Desc = {
    Text = "Erwirb den Schwarzen Pharao bei Erleuchtung 6"
  },
  Task_78470_Name = {
    Text = "Erwirb den Schwarzen Pharao bei Erleuchtung 6"
  },
  Task_78470_UnlockCondDesc = {
    Text = "Aktivität @Erweckungswesen Schwarzer Pharao Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_78476_Desc = {
    Text = "Erwirb Lantios bei Erleuchtungsstufe 6"
  },
  Task_78476_Name = {
    Text = "Erwirb Lantios bei Erleuchtungsstufe 6"
  },
  Task_78476_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Lantigos Erleuchten Paket 2 Aktivität"
  },
  Task_78477_Desc = {
    Text = "Erwirb Lantigus bei Erleuchtungsstufe 2"
  },
  Task_78477_Name = {
    Text = "Erwirb Lantios bei Erleuchtungsstufe 2"
  },
  Task_78477_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Lantigos Erleuchten Paket 2 Aktivität"
  },
  Task_78481_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78483_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78484_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78485_Desc = {
    Text = "Erwirb Geier bei Erleuchtung 2"
  },
  Task_78485_Name = {
    Text = "Erhalte Geier bei Erleuchtung 2"
  },
  Task_78485_UnlockCondDesc = {
    Text = "Aktivität @Erweckungswesen Geier Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_78486_Desc = {
    Text = "Erhalte Geier bei Erleuchtung 6"
  },
  Task_78486_Name = {
    Text = "Erwirb Geier bei Erleuchtung 6"
  },
  Task_78486_UnlockCondDesc = {
    Text = "Aktivität @Erweckungswesen Geier Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_78487_Desc = {
    Text = "Erhalte Aforgamon bei Erleuchtungsstufe 6"
  },
  Task_78487_Name = {
    Text = "Erhalte Aforgamon bei Erleuchtung 6"
  },
  Task_78487_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Aforgamon Erleuchten Paket 2 Aktivität"
  },
  Task_78488_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78489_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78492_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78493_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78495_Desc = {
    Text = "Erwirb die Kupferspange bei Erleuchtungsstufe 6"
  },
  Task_78495_Name = {
    Text = "Erwirb die Kupferspange bei Erleuchtungsstufe 6"
  },
  Task_78495_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Kupfersang Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_78496_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78497_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78499_Desc = {
    Text = "Erwirb Kupferspange bei Erleuchtung Stufe 2"
  },
  Task_78499_UnlockCondDesc = {
    Text = "Aktivität @Erweckungswesen Kupfersang Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_78573_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78574_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78576_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78577_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78599_Desc = {
    Text = "Im Finalkampf innerhalb von 13 Runden gewinnen"
  },
  Task_78599_Name = {
    Text = "Im Finalkampf innerhalb von 13 Runden gewinnen"
  },
  Task_78600_Desc = {
    Text = "Im Finalkampf innerhalb von 14 Runden gewinnen"
  },
  Task_78600_Name = {
    Text = "Im Finalkampf innerhalb von 14 Runden gewinnen"
  },
  Task_78718_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Speicher-Encoding“ zweimal gewinnen"
  },
  Task_78719_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Speicher-Encoding“ zweimal gewinnen"
  },
  Task_78720_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Speicher-Encoding“ zweimal gewinnen"
  },
  Task_78721_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker im “Speicher-Encoding“ zweimal gewinnen"
  },
  Task_78723_Desc = {
    Text = "Dunkle Flüsterinsekten II"
  },
  Task_78724_Desc = {
    Text = "Dunkles Summen der Gezeiten I"
  },
  Task_78725_Desc = {
    Text = "Dunkle Flüsterkäfer VII"
  },
  Task_78726_Desc = {
    Text = "Dunkle Flüsterkäfer V"
  },
  Task_78727_Desc = {
    Text = "Düstere Welle des Insektenzwitscherns · Erstes Mal kostenlos"
  },
  Task_78728_Desc = {
    Text = "Dunkle Flüsterinsekten VI"
  },
  Task_78729_Desc = {
    Text = "Dunkle Flüsterinsekten III"
  },
  Task_78730_Desc = {
    Text = "Dunkle Flüsterinsekten IV"
  },
  Task_78740_Desc = {
    Text = "Erwirb „Genesis, Herr des Schlafes“ bei Erleuchtung Stufe 6"
  },
  Task_78740_Name = {
    Text = "Erwirb 'Genesis, Herr des Schlafes' bei Erleuchtung 6"
  },
  Task_78740_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Genesis Schlafender Tyrann Erleuchten Paket 2 Aktivität"
  },
  Task_78741_Desc = {
    Text = "Genesis, Herr des Schlafes, erreicht Affinitätsstufe 10"
  },
  Task_78742_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78743_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78745_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78746_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78748_Desc = {
    Text = "Erwirb 'Genesis, Herr des Schlafes' bei Erleuchtung 2"
  },
  Task_78748_Name = {
    Text = "Erwirb 'Genesis, Herr des Schlafes' bei Erleuchtung 2"
  },
  Task_78748_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Genesis Schlafender Tyrann Erleuchten Paket 2 Aktivität"
  },
  Task_78763_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78764_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78766_Desc = {
    Text = "Erwirb die Genesis-Tiefseedame bei Erleuchtungsstufe 2"
  },
  Task_78766_Name = {
    Text = "Erwirb die Genesis-Tiefseedame bei Erleuchtungsstufe 2"
  },
  Task_78766_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Genesis Tiefsee-Dame Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_78767_Desc = {
    Text = "Erwirb die Genesis-Tiefseedame bei Erleuchtungsstufe 6"
  },
  Task_78767_Name = {
    Text = "Erwirb die Genesis-Tiefseedame bei Erleuchtungsstufe 6"
  },
  Task_78767_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Genesis Tiefsee-Schönheit Erleuchten Paket 2 Aktivität"
  },
  Task_78768_Desc = {
    Text = "Ursängerin der Tiefsee erreicht Affinität Stufe 10"
  },
  Task_78769_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_78770_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_79259_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_79259_Name = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_79283_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_79283_Name = {
    Text = "Perfekter Pass"
  },
  Task_79284_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_79284_Name = {
    Text = "Perfekter Pass"
  },
  Task_79285_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_79285_Name = {
    Text = "Perfekter Pass"
  },
  Task_79286_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_79286_Name = {
    Text = "Perfekter Pass"
  },
  Task_79287_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_79287_Name = {
    Text = "Perfekter Pass"
  },
  Task_79288_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_79288_Name = {
    Text = "Perfekter Pass"
  },
  Task_79289_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_79289_Name = {
    Text = "Perfekter Pass"
  },
  Task_79290_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_79290_Name = {
    Text = "Perfekter Pass"
  },
  Task_79291_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_79291_Name = {
    Text = "Perfekter Pass"
  },
  Task_79292_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_79292_Name = {
    Text = "Perfekter Pass"
  },
  Task_79304_Desc = {
    Text = "Verwende “Reines Weiß beim ersten Treffen“, um einen Sieg zu erringen"
  },
  Task_79305_Desc = {
    Text = "Verwende “Untergang der Sonne“, um 1x zu gewinnen"
  },
  Task_79306_Desc = {
    Text = "Verwende “Nichtigkeitspest“, um einen Sieg zu erringen"
  },
  Task_79307_Desc = {
    Text = "Verwende „Dreht euch, dreht euch“, um 6 Siege zu erzielen"
  },
  Task_79308_Desc = {
    Text = "Verwende “Rattens Weisheit“, um einen Sieg zu erringen"
  },
  Task_79309_Desc = {
    Text = "Verwende “Reines Weiß beim ersten Treffen“, um 3 Siege zu erringen"
  },
  Task_79310_Desc = {
    Text = "Verwende “heißer Abschiedskuss“, um 6 Siege zu erringen"
  },
  Task_79311_Desc = {
    Text = "Verwende “Sonnenuntergang“, um 3 Siege zu erringen"
  },
  Task_79312_Desc = {
    Text = "Verwende “Hirtenstab“, um dreimal zu siegen"
  },
  Task_79313_Desc = {
    Text = "Verwende “Unsterbliches Begräbnis“, um einen Sieg zu erringen"
  },
  Task_79314_Desc = {
    Text = "Verwende “Rattens Weisheit“, um dreimal zu siegen"
  },
  Task_79315_Desc = {
    Text = "Verwende “Erwachen der Berge“, um 3 Siege zu erringen"
  },
  Task_79316_Desc = {
    Text = "Verwende “Kleiner Wunsch“, um 3 Siege zu erringen"
  },
  Task_79317_Desc = {
    Text = "Verwende “Seelenentstehung“, um einen Sieg zu erringen"
  },
  Task_79318_Desc = {
    Text = "Verwende “Tiefseeruf“, um 6 Siege zu erringen"
  },
  Task_79319_Desc = {
    Text = "Verwende “Verrottetes Festmahl“, um 6 Siege zu erringen"
  },
  Task_79320_Desc = {
    Text = "Verwende „Sternenschutz“, um 3 Siege zu erringen"
  },
  Task_79321_Desc = {
    Text = "Verwende “Verrottetes Festmahl“, um 3 Siege zu erringen"
  },
  Task_79322_Desc = {
    Text = "Verwende “Die Antwort der Tür“, um einen Sieg zu erzielen"
  },
  Task_79323_Desc = {
    Text = "Verwende “Hirtenstab“, um 6 Siege zu erzielen"
  },
  Task_79324_Desc = {
    Text = "Verwende “Tiefseeruf“, um einen Sieg zu erringen"
  },
  Task_79325_Desc = {
    Text = "Verwende “Tiefseeruf“, um 3 Siege zu erringen"
  },
  Task_79326_Desc = {
    Text = "Verwende “Nichtigkeitspest“, um 3 Siege zu erringen"
  },
  Task_79327_Desc = {
    Text = "Verwende “Ode an den Frühling“, um 6 Siege zu erringen"
  },
  Task_79328_Desc = {
    Text = "Verwende “Ein Schuss“, um 1x zu gewinnen"
  },
  Task_79329_Desc = {
    Text = "Verwende “Unvergängliches Begräbnis“, um 3 Siege zu erringen"
  },
  Task_79330_Desc = {
    Text = "Verwende “Tür der Taverne“, um einen Sieg zu erzielen"
  },
  Task_79331_Desc = {
    Text = "Verwende “ewige Besessenheit“, um 3 Siege zu erringen"
  },
  Task_79332_Desc = {
    Text = "Verwende “Kleiner Wunsch“, um einen Sieg zu erringen"
  },
  Task_79333_Desc = {
    Text = "Verwende „Die Antwort der Tür“, um 6 Siege zu erringen"
  },
  Task_79334_Desc = {
    Text = "Verwende “Thron aus blauem Stein“, um 6 Siege zu erringen"
  },
  Task_79335_Desc = {
    Text = "Verwende “Sternenschutz“, um einen Sieg zu erringen"
  },
  Task_79336_Desc = {
    Text = "Verwende “Erwachen der Berge“, um 6 Siege zu erringen"
  },
  Task_79337_Desc = {
    Text = "Verwende “Sonnenuntergang“, um 6 Siege zu erlangen"
  },
  Task_79338_Desc = {
    Text = "Verwende „Akt des Frühlings“, um 6 Siege zu erringen"
  },
  Task_79339_Desc = {
    Text = "Verwende “Rattens Weisheit“, um 6 Siege zu erringen"
  },
  Task_79340_Desc = {
    Text = "Verwende “Völlerei“, um 6-mal zu siegen"
  },
  Task_79341_Desc = {
    Text = "Verwende “Unsterbliches Begräbnis“, um 6 Siege zu erringen"
  },
  Task_79342_Desc = {
    Text = "Verwende “Meeresopfer“, um 6 Siege zu erringen"
  },
  Task_79343_Desc = {
    Text = "Verwende “Injizierter Schutz“, um einen Sieg zu erringen"
  },
  Task_79344_Desc = {
    Text = "Verwende “Injizierter Schutz“, um 3 Siege zu erringen"
  },
  Task_79345_Desc = {
    Text = "Verwende “Tür zur Taverne“, um 3 Siege zu erringen"
  },
  Task_79346_Desc = {
    Text = "Verwende „Blumen und Gedichte der Vergangenheit“, um 3 Siege zu erringen"
  },
  Task_79347_Desc = {
    Text = "Verwende “Dreht euch, dreht euch“, um 1x zu gewinnen"
  },
  Task_79348_Desc = {
    Text = "Verwende “Hexenhut mit breiter Krempe“, um 6 Siege zu erringen"
  },
  Task_79349_Desc = {
    Text = "Verwende “Tür der rückwärts führenden Wege“, um 3 Siege zu erzielen"
  },
  Task_79350_Desc = {
    Text = "Verwende den “4. Satz“, um 6 Siege zu erringen"
  },
  Task_79351_Desc = {
    Text = "Verwende den „Blauen Thron“, um einen Sieg zu erringen."
  },
  Task_79352_Desc = {
    Text = "Verwende den “4. Satz“, um einen Sieg zu erringen"
  },
  Task_79353_Desc = {
    Text = "Verwende “Tür zur Taverne“, um 6 Siege zu erzielen"
  },
  Task_79354_Desc = {
    Text = "Verwende “Nichtigkeitspest“, um 6 Siege zu erringen"
  },
  Task_79355_Desc = {
    Text = "Verwende “Ein Schuss“, um 6 Siege zu erringen"
  },
  Task_79356_Desc = {
    Text = "Verwende “Hexenhut mit breiter Krempe“, um einen Sieg zu erringen"
  },
  Task_79357_Desc = {
    Text = "Verwende „Dreht euch, dreht euch“, um 3 Siege zu erringen"
  },
  Task_79358_Desc = {
    Text = "Verwende “Verrottetes Festmahl“, um einen Sieg zu erringen"
  },
  Task_79359_Desc = {
    Text = "Verwende “Thron aus grünem Stein“, um 3 Siege zu erringen"
  },
  Task_79360_Desc = {
    Text = "Verwende “Glühender Abschiedskuss“, um 3 Siege zu erringen"
  },
  Task_79361_Desc = {
    Text = "Verwende “Seelenentstehung“, um 3 Siege zu erringen"
  },
  Task_79362_Desc = {
    Text = "Verwende “ewige Besessenheit“, um einen Sieg zu erringen"
  },
  Task_79363_Desc = {
    Text = "Verwende “Tür des rückwärts Überschreitens“, um einen Sieg zu erringen"
  },
  Task_79364_Desc = {
    Text = "Verwende “Heißer Abschiedskuss“, um 1x zu gewinnen"
  },
  Task_79365_Desc = {
    Text = "Verwende “Blumen und Gedichte der Vergangenheit“, um 6 Siege zu erringen"
  },
  Task_79366_Desc = {
    Text = "Verwende “Sternenschutz“, um 6-mal zu siegen"
  },
  Task_79367_Desc = {
    Text = "Verwende “Ode an den Frühling“, um einen Sieg zu erringen"
  },
  Task_79368_Desc = {
    Text = "Verwende „Erwachen der Berge“, um 1 Sieg zu erringen"
  },
  Task_79369_Desc = {
    Text = "Verwende “Akut-Frühling“, um 3 Siege zu erringen"
  },
  Task_79370_Desc = {
    Text = "Verwende “Injizierter Schutz“, um 6 Siege zu erringen"
  },
  Task_79371_Desc = {
    Text = "Verwende “Hexenhut mit breiter Krempe“, um 3 Siege zu erringen"
  },
  Task_79372_Desc = {
    Text = "Verwende “Meeresgabe“, um 3 Siege zu erringen"
  },
  Task_79373_Desc = {
    Text = "Verwende “Tür der Rückkehr“, um 6 Siege zu erringen"
  },
  Task_79374_Desc = {
    Text = "Verwende “Reines Weiß beim ersten Treffen“, um 6 Siege zu erringen"
  },
  Task_79375_Desc = {
    Text = "Verwende “Kleiner Wunsch“, um 6 Siege zu erzielen"
  },
  Task_79376_Desc = {
    Text = "Verwende “Völlerei“, um 3 Siege zu erringen"
  },
  Task_79377_Desc = {
    Text = "Verwende “Meeresritual“, um 1x zu gewinnen"
  },
  Task_79378_Desc = {
    Text = "Verwende den “4. Satz“, um 3 Siege zu erzielen"
  },
  Task_79379_Desc = {
    Text = "Verwende “Völlerei“, um 1 Sieg zu erringen"
  },
  Task_79380_Desc = {
    Text = "Verwende “Die Antwort der Tür“, um 3 Siege zu erringen"
  },
  Task_79381_Desc = {
    Text = "Verwende “Blumen und Gedichte der Vergangenheit“, um einen Sieg zu erringen"
  },
  Task_79382_Desc = {
    Text = "Verwende den “Hirtenstab“, um einen Sieg zu erringen"
  },
  Task_79383_Desc = {
    Text = "Verwende “Ein Schuss“, um dreimal zu siegen"
  },
  Task_79384_Desc = {
    Text = "Verwende „Seelenentstehung“, um 6 Siege zu erzielen"
  },
  Task_79385_Desc = {
    Text = "Verwende “Akt des Frühlings“, um einen Sieg zu erringen"
  },
  Task_79386_Desc = {
    Text = "Verwende “ewige Besessenheit“, um 6 Siege zu erringen"
  },
  Task_79387_Desc = {
    Text = "Verwende “Ode an den Frühling“, um 3 Siege zu erringen"
  },
  Task_79483_Desc = {
    Text = "Angstheilung·Grenzgebiet"
  },
  Task_79484_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Heilende Angst“ 2 Mal gewinnen"
  },
  Task_79485_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Heilende Angst“ einmal gewinnen"
  },
  Task_79486_Desc = {
    Text = "Abschließen der „Speicherklinik“ im beliebigen Modus"
  },
  Task_79487_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker im “Heilende Angst“ 2-mal gewinnen"
  },
  Task_79488_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker einmal im „Heilende Angst“ gewinnen"
  },
  Task_79489_Desc = {
    Text = "Abschluss „Neubeginn“ Wahnsinn-Schwierigkeitsgrad"
  },
  Task_79490_Desc = {
    Text = "Angstheilung · Abschluss"
  },
  Task_79491_Desc = {
    Text = "Abschließen von “Feuermotte“ im beliebigen Modus"
  },
  Task_79492_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Heilende Angst“ einmal gewinnen"
  },
  Task_79493_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Heilende Angst“ zweimal gewinnen"
  },
  Task_79494_Desc = {
    Text = "Abschluss von „Neubeginn“ in beliebigem Modus"
  },
  Task_79495_Desc = {
    Text = "Durchspielen der „Brennenden Welt“ im Wahnsinnsmodus"
  },
  Task_79496_Desc = {
    Text = "Abschluss von „Traumverletzung“ im Wahnsinnsmodus"
  },
  Task_79497_Desc = {
    Text = "Abschließen der «Speicherklinik» in beliebiger Schwierigkeit"
  },
  Task_79498_Desc = {
    Text = "Abschluss von “Feuermotte“ in beliebigem Schwierigkeitsgrad"
  },
  Task_79499_Desc = {
    Text = "Abschluss von „Brennende Welt“ im beliebigen Schwierigkeitsgrad"
  },
  Task_79500_Desc = {
    Text = "Angstheilung·Wahnsinn"
  },
  Task_79501_Desc = {
    Text = "Abschluss von “Brennende Welt“ in beliebigem Modus"
  },
  Task_79502_Desc = {
    Text = "Abschluss von „Traumverletzung“ in beliebigem Modus"
  },
  Task_79503_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im Modus „Heilende Angst“ einmal gewinnen"
  },
  Task_79504_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im Modus „Heilende Angst“ zweimal gewinnen"
  },
  Task_79505_Desc = {
    Text = "Abschluss von „Neubeginn“ in beliebigem Modus"
  },
  Task_79506_Desc = {
    Text = "Abschluss von „Feuermotte“ im Wahnsinnsmodus"
  },
  Task_79507_Desc = {
    Text = "Alle Aufgaben von „Angstheilung – Abschluss“ abschließen"
  },
  Task_79508_Desc = {
    Text = "Abschluss von „Traumverletzung“ in beliebigem Modus"
  },
  Task_79509_Desc = {
    Text = "Abschluss der „Speicher-Klinik“ auf Wahnsinn-Schwierigkeit"
  },
  Task_79747_Desc = {
    Text = "Erhalte Clementine"
  },
  Task_79747_Name = {
    Text = "Erhalte Clementine"
  },
  Task_80218_Desc = {
    Text = "Besiege die Dorfbewohner, die im Weg stehen"
  },
  Task_80218_Name = {Text = "Ziel"},
  Task_80219_Desc = {
    Text = "Das Lebensritual verhindern"
  },
  Task_80219_Name = {Text = "Ziel"},
  Task_80220_Desc = {
    Text = "Universum @2 Projektion zerstören"
  },
  Task_80220_Name = {Text = "Ziel"},
  Task_80221_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_80221_Name = {
    Text = "Perfekter Pass"
  },
  Task_80222_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_80222_Name = {
    Text = "Perfekter Pass"
  },
  Task_80223_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_80223_Name = {
    Text = "Perfekter Pass"
  },
  Task_80224_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_80224_Name = {
    Text = "Perfekter Pass"
  },
  Task_80225_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_80225_Name = {
    Text = "Perfekter Pass"
  },
  Task_80226_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_80226_Name = {
    Text = "Perfekter Pass"
  },
  Task_80227_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_80227_Name = {
    Text = "Perfekter Pass"
  },
  Task_80228_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_80228_Name = {
    Text = "Perfekter Pass"
  },
  Task_80229_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_80229_Name = {
    Text = "Perfekter Pass"
  },
  Task_80230_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_80230_Name = {
    Text = "Perfekter Pass"
  },
  Task_80231_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_80231_Name = {
    Text = "Perfekter Pass"
  },
  Task_80232_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_80232_Name = {
    Text = "Perfekter Pass"
  },
  Task_80233_Desc = {
    Text = "Bestätige „Ramona“"
  },
  Task_80233_Name = {Text = "Ziel"},
  Task_80234_Desc = {
    Text = "Der Patrouille entkommen"
  },
  Task_80234_Name = {Text = "Ziel"},
  Task_80235_Desc = {
    Text = "Loswerden von “Clementine“"
  },
  Task_80235_Name = {Text = "Ziel"},
  Task_80236_Desc = {
    Text = "Zum Behandlungsraum von Clementine gehen"
  },
  Task_80236_Name = {Text = "Ziel"},
  Task_80237_Desc = {Text = "Nach Hause"},
  Task_80237_Name = {Text = "Ziel"},
  Task_80238_Desc = {
    Text = "Herberts „Eindämmung“ verhindern"
  },
  Task_80238_Name = {Text = "Ziel"},
  Task_80239_Desc = {
    Text = "Doktor entkommen"
  },
  Task_80239_Name = {Text = "Ziel"},
  Task_80240_Desc = {
    Text = "In Albinos Speicher eintauchen"
  },
  Task_80240_Name = {Text = "Ziel"},
  Task_80241_Desc = {
    Text = "Wutentbrannte Patienten unterdrücken"
  },
  Task_80241_Name = {Text = "Ziel"},
  Task_80286_Desc = {
    Text = "Abgeschlossen: Sternenkapitel Kapitel 2 Mission 2-9"
  },
  Task_80287_Desc = {
    Text = "Abschließen des Sternenkapitels, Kapitel 2-6, auf schwerem Schwierigkeitsgrad"
  },
  Task_80288_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"@1@2\""
  },
  Task_80288_Desc2 = {
    Text = "Abschluss des Untersuchungsereignisses „Verwandlung“"
  },
  Task_80288_Name2 = {
    Text = "Höre das Brummen des Universums"
  },
  Task_80289_Desc = {
    Text = "Abgeschlossen das Untersuchungsereignis „Verwandlung“ in hartem Schwierigkeitsgrad"
  },
  Task_80289_Name = {
    Text = "Höre das Summen des Universums·hart"
  },
  Task_80290_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_80291_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_80292_Desc = {
    Text = "Abgeschlossen: Sternenkapitel Kapitel 2 „Verwandlung“"
  },
  Task_80293_Desc = {
    Text = "Abschließen von Kapitel 2 „Verwandlung“ des Sternenkapitels im Schwierigkeitsgrad „Schwer“"
  },
  Task_80294_Desc = {
    Text = "Abschluss des Sternenkapitels, Kapitel 2, 2-6, Schwierigkeitsgrad: Schwer"
  },
  Task_80295_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 9 Mal Resonanz erzeugt"
  },
  Task_80295_Desc2 = {
    Text = "Bei der Untersuchung des Ereignisses «Verwandlung» entstand 9-mal Resonanz"
  },
  Task_80295_Name2 = {
    Text = "Echo der Evolution III"
  },
  Task_80296_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 6 Mal Resonanz erzeugt"
  },
  Task_80296_Desc2 = {
    Text = "Bei der Untersuchung des Ereignisses «Verwandlung» entstand 6-mal Resonanz"
  },
  Task_80296_Name2 = {
    Text = "Echo der Evolution II"
  },
  Task_80297_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 3 Mal Resonanz erzeugt"
  },
  Task_80297_Desc2 = {
    Text = "Bei der Ermittlung des Ereignisses“Verwandlung“ wurde 3 Mal Resonanz erzeugt"
  },
  Task_80297_Name2 = {
    Text = "Echo der Veränderung"
  },
  Task_80298_Desc = {
    Text = "Abgeschlossen: Sternenkapitel Kapitel 2, 2-9"
  },
  Task_80299_Desc = {
    Text = "Resonieren Sie 11 Mal im Untersuchungsereignis \"@1@2\""
  },
  Task_80299_Desc2 = {
    Text = "Bei der Untersuchung des Ereignisses „Verwandlung“ entstand 11-mal Resonanz"
  },
  Task_80299_Name2 = {
    Text = "Echo der Umwandlung IV"
  },
  Task_80300_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_80301_Desc = {
    Text = "Abgeschlossen: Sternenkapitel Kapitel 2 „Verwandlung“"
  },
  Task_80302_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_80303_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_80304_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_80305_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_80306_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_80307_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_80309_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_80310_Desc = {
    Text = "Abschließen des Sternenkapitels Kapitel 2 „Verwandlung“ im Schwierigkeitsgrad „Schwer“"
  },
  Task_80419_Name = {
    Text = "Sternenkapitel 2_18 erneut abgeschlossen"
  },
  Task_80433_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_80433_Name = {Text = "10 Siege"},
  Task_80434_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_80434_Name = {Text = "6 Siege"},
  Task_80435_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_80435_Name = {Text = "3 Siege"},
  Task_80436_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_80436_Name = {Text = "1 Sieg"},
  Task_80993_Desc = {
    Text = "Reinigungswerkzeug erreicht"
  },
  Task_80994_Desc = {
    Text = "3 beliebige Aufgaben abschließen"
  },
  Task_80994_Name = {
    Text = "Heute Aufräumen abgeschlossen!"
  },
  Task_80995_Desc = {
    Text = "Aktivitätsbelohnung"
  },
  Task_80996_Desc = {
    Text = "Reinigungswerkzeug erreicht"
  },
  Task_80997_Desc = {
    Text = "Verbrauche 100.000 Goldene Rosen"
  },
  Task_80997_Name = {
    Text = "Rucksack organisieren"
  },
  Task_80998_Desc = {
    Text = "Reinigungswerkzeug erreicht"
  },
  Task_80999_Desc = {
    Text = "Reinigungswerkzeug erreicht"
  },
  Task_81000_Desc = {
    Text = "Kumulativer Login für 6 Tage"
  },
  Task_81001_Desc = {
    Text = "Einmaliger Abschluss einer beliebigen Ermittlungsoperation"
  },
  Task_81001_Name = {
    Text = "Erinnerungsstaub entfernen"
  },
  Task_81002_Desc = {
    Text = "Logge dich an insgesamt 3 aufeinander folgenden Tagen ein"
  },
  Task_81003_Desc = {
    Text = "Reinigungswerkzeug erreicht"
  },
  Task_81004_Desc = {
    Text = "Reinigungswerkzeug erreicht"
  },
  Task_81005_Desc = {
    Text = "Reinigungswerkzeug erreicht"
  },
  Task_81006_Desc = {
    Text = "Event-Aufgabe"
  },
  Task_81007_Desc = {
    Text = "Schließe 1 Traphase ab"
  },
  Task_81007_Name = {
    Text = "Dimensionsdesinfektion"
  },
  Task_81008_Desc = {
    Text = "Logge dich an insgesamt 5 aufeinander folgenden Tagen ein"
  },
  Task_81009_Desc = {
    Text = "Logge dich insgesamt 7 Tage lang ein"
  },
  Task_81010_Desc = {
    Text = "Reinigungswerkzeug erreicht"
  },
  Task_81011_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_81012_Desc = {
    Text = "Logge dich insgesamt 4 Tage lang ein"
  },
  Task_81013_Desc = {
    Text = "Logge dich insgesamt 2 Tage lang ein"
  },
  Task_81014_Desc = {
    Text = "Reinigungswerkzeug erreicht"
  },
  Task_81015_Desc = {
    Text = "Reinigungswerkzeug erreicht"
  },
  Task_81016_Desc = {
    Text = "In den Schmelzruinen 180 Menophin verbrauchen"
  },
  Task_81016_Name = {
    Text = "Erosionsreinigung"
  },
  Task_81017_Desc = {
    Text = "7 Tage anmelden"
  },
  Task_81018_Desc = {
    Text = "Einmal den phantasmalen Sturzflug durchspielen"
  },
  Task_81018_Name = {
    Text = "Traumentlüftung"
  },
  Task_81083_Desc = {
    Text = "Tiefseefahrt des Wahnsinns"
  },
  Task_81084_Desc = {
    Text = "Abschluss von “Finale Elegie“ in einem beliebigen Modus"
  },
  Task_81085_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Tiefsee-Expeditionsirren“ 2-mal gewinnen"
  },
  Task_81086_Desc = {
    Text = "Abschluss von „Abgenutzter Kompass“ in einem beliebigen Modus"
  },
  Task_81087_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Labyrinth der Tiefen“ einmal gewinnen"
  },
  Task_81088_Desc = {
    Text = "Abschluss von „Finale Elegie“ in jedem Schwierigkeitsgrad"
  },
  Task_81089_Desc = {
    Text = "Absolvieren von “Navigatorenhandbuch“ im Wahnsinnsmodus"
  },
  Task_81090_Desc = {
    Text = "Abschluss von „Führen-Licht“ im Wahnsinnsmodus"
  },
  Task_81091_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker im „Labyrinth der Tiefen“ 2-mal gewinnen"
  },
  Task_81092_Desc = {
    Text = "Abschließen von “Altmodischer Sextant“ im Wahnsinnsmodus"
  },
  Task_81093_Desc = {
    Text = "Abschließen des Bewusstseins-Tauchgangs „Letzte Navigation“"
  },
  Task_81094_Desc = {
    Text = "Absolvierung von „Abgenutzter Kompass“ im Wahnsinnsmodus"
  },
  Task_81095_Desc = {
    Text = "Abschließen von „Führen-Licht“ in beliebiger Schwierigkeit"
  },
  Task_81096_Desc = {
    Text = "Abschließen des “Abgenutzten Kompasses“ in beliebiger Schwierigkeit"
  },
  Task_81097_Desc = {
    Text = "Alle Erfolge von “Tiefseereise: Durchspielzeit“ abschließen"
  },
  Task_81098_Desc = {
    Text = "Abschließen von „Führen-Licht“ in beliebiger Schwierigkeit"
  },
  Task_81099_Desc = {
    Text = "Abschließen der „Sternenbahn“ im Wahnsinnsmodus"
  },
  Task_81100_Desc = {
    Text = "Abschluss von “Sternenbahn“ in beliebigem Schwierigkeitsgrad"
  },
  Task_81101_Desc = {
    Text = "Abschluss von „Signalflaggenalphabet“ in beliebigem Modus"
  },
  Task_81102_Desc = {
    Text = "Abschluss von “Signalflaggenalphabet“ in einem beliebigen Modus"
  },
  Task_81103_Desc = {
    Text = "Abschluss von „Altmodischer Sextant“ in beliebigem Modus"
  },
  Task_81104_Desc = {
    Text = "Abschließen der „Alten Seekarte“ in beliebiger Schwierigkeit"
  },
  Task_81105_Desc = {
    Text = "Abschluss von „Signalflaggenalphabet“ im Wahnsinnsmodus"
  },
  Task_81106_Desc = {
    Text = "Abschluss von “Navigatorenhandbuch“ in beliebigem Modus"
  },
  Task_81107_Desc = {
    Text = "Abschließen des “Navigatorenhandbuchs“ in beliebiger Schwierigkeit"
  },
  Task_81108_Desc = {
    Text = "Abschluss der “Fleckigen Sternenscheibe“ in beliebiger Schwierigkeit"
  },
  Task_81109_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker einmal im „Labyrinth der Tiefen“ gewinnen."
  },
  Task_81110_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker im „Labyrinth der Tiefen“ 1 Mal gewinnen"
  },
  Task_81111_Desc = {
    Text = "Abschluss der „Finalen Elegie“ – Wahnsinn-Stufe"
  },
  Task_81112_Desc = {
    Text = "Tiefsee-Expedition·Abschließen"
  },
  Task_81113_Desc = {
    Text = "Absolvieren von „Sternenpfad“ im beliebigen Modus"
  },
  Task_81114_Desc = {
    Text = "Abschließen der „Alten Seekarte“ in beliebiger Schwierigkeit"
  },
  Task_81115_Desc = {
    Text = "Abschluss von „Alte Seekarte“ im Wahnsinnsmodus"
  },
  Task_81116_Desc = {
    Text = "Absolvieren von „Fleckige Sternenscheibe“ im Wahnsinnsmodus"
  },
  Task_81117_Desc = {
    Text = "Abschluss von “Altmodischer Sextant“ in beliebigem Modus"
  },
  Task_81118_Desc = {
    Text = "Abschluss von “Fleckige Sternenscheibe“ in beliebigem Schwierigkeitsgrad"
  },
  Task_81119_Desc = {
    Text = "Tiefenmeer-Irrfahrt·Reich"
  },
  Task_81120_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im „Labyrinth der Tiefen“ 2-mal gewinnen"
  },
  Task_81121_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Tiefsee-Meeresstrudel“ 2-mal gewinnen"
  },
  Task_81122_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im „Labyrinth der Tiefen“ 1 Mal gewinnen"
  },
  Task_81481_Desc = {
    Text = "Besiege die «Universum-@2-Projektion», ohne die Hilfe von «Ringfahrt · Ramona» in Anspruch zu nehmen."
  },
  Task_81481_Name = {
    Text = "Höre das Brummen des Universums · Verstecken"
  },
  Task_81772_Name = {
    Text = "Besiege BOSS 1 N-mal"
  },
  Task_81773_Name = {
    Text = "Besiege BOSS 7 N-mal"
  },
  Task_81774_Name = {
    Text = "Besiege alle Bosse"
  },
  Task_81775_Name = {
    Text = "Besiege BOSS 3 N-mal"
  },
  Task_81776_Name = {
    Text = "Besiege BOSS 2 N-mal"
  },
  Task_81777_Name = {
    Text = "Besiege BOSS 6 N-mal"
  },
  Task_81778_Name = {
    Text = "Besiege BOSS 4 N-mal"
  },
  Task_81779_Name = {
    Text = "Besiege BOSS 5 Mal"
  },
  Task_84111_Name = {
    Text = "Neu abgeschlossene Nebenmissionen von Kupferspange - Normal 4"
  },
  Task_84143_Desc = {
    Text = "Kumulativer Login für 2 Tage"
  },
  Task_84144_Desc = {
    Text = "Gesamte Anmeldung 3 Tage"
  },
  Task_84145_Desc = {
    Text = "Kumulativer Login für 2 Tage"
  },
  Task_84146_Desc = {
    Text = "Gesamte Anmeldung 5 Tage"
  },
  Task_84147_Desc = {
    Text = "Gesamte Anmeldung 8 Tage"
  },
  Task_84148_Desc = {
    Text = "Kumulativer Login für 2 Tage"
  },
  Task_84149_Desc = {
    Text = "Gesamte Anmeldung 5 Tage"
  },
  Task_84150_Desc = {
    Text = "Gesamte Anmeldung 10 Tage"
  },
  Task_84151_Desc = {
    Text = "Gesamte Anmeldung 5 Tage"
  },
  Task_84152_Desc = {
    Text = "Gesamte Anmeldung 10 Tage"
  },
  Task_84153_Desc = {
    Text = "Gesamte Anmeldung 4 Tage"
  },
  Task_84154_Desc = {
    Text = "Gesamte Anmeldung 9 Tage"
  },
  Task_84155_Desc = {
    Text = "Gesamte Anmeldung 3 Tage"
  },
  Task_84156_Desc = {
    Text = "Gesamte Anmeldung 6 Tage"
  },
  Task_84157_Desc = {
    Text = "Kumulativer Login für 2 Tage"
  },
  Task_84158_Desc = {
    Text = "Gesamte Anmeldung 4 Tage"
  },
  Task_84159_Desc = {
    Text = "Gesamte Anmeldung 3 Tage"
  },
  Task_84160_Desc = {
    Text = "Gesamte Anmeldung 1 Tag"
  },
  Task_84161_Desc = {
    Text = "7-tägiger kumulativer Login"
  },
  Task_84162_Desc = {
    Text = "Gesamte Anmeldung 5 Tage"
  },
  Task_84163_Desc = {
    Text = "Gesamte Anmeldung 1 Tag"
  },
  Task_84164_Desc = {
    Text = "Gesamte Anmeldung 1 Tag"
  },
  Task_84165_Desc = {
    Text = "Gesamte Anmeldung 8 Tage"
  },
  Task_84166_Desc = {
    Text = "7-tägiger kumulativer Login"
  },
  Task_84167_Desc = {
    Text = "Gesamte Anmeldung 4 Tage"
  },
  Task_84168_Desc = {
    Text = "Gesamte Anmeldung 6 Tage"
  },
  Task_84169_Desc = {
    Text = "Gesamte Anmeldung 4 Tage"
  },
  Task_84170_Desc = {
    Text = "Gesamte Anmeldung 9 Tage"
  },
  Task_84171_Desc = {
    Text = "Gesamte Anmeldung 1 Tag"
  },
  Task_84172_Desc = {
    Text = "3 Tage lang täglich angemeldet"
  },
  Task_84323_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_84323_Name = {Text = "3 Siege"},
  Task_84324_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_84324_Name = {Text = "6 Siege"},
  Task_84325_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_84325_Name = {Text = "1 Sieg"},
  Task_84326_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_84326_Name = {Text = "10 Siege"},
  Task_84349_Desc = {
    Text = "Schließe das Bewusstseinswandern \"Die letzte Navigation\" ab"
  },
  Task_84349_Name = {
    Text = "Sterne und die Führung des Abgrunds"
  },
  Task_88945_Desc = {
    Text = "Abschluss von „Käfig sprengen“ in einem beliebigen Modus"
  },
  Task_88946_Desc = {
    Text = "Abschluss der Traumlandschaft “Jenseits des Horizonts, Teil 1“"
  },
  Task_88947_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im“Himmelsstürmer“ zweimal gewinnen"
  },
  Task_88948_Desc = {
    Text = "Abschluss von „Einsame Reise“ in jedem Modus"
  },
  Task_88949_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Himmelsstürmer“ einmal gewinnen"
  },
  Task_88950_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Himmelsstürmer“ einmal gewinnen"
  },
  Task_88951_Desc = {
    Text = "Abschluss von „Bote der Kerze“ in beliebigem Modus"
  },
  Task_88952_Desc = {
    Text = "Abschließen von „Käfig sprengen“ im Wahnsinnsmodus"
  },
  Task_88953_Desc = {
    Text = "Abschließen von „Käfig sprengen“ im beliebigen Schwierigkeitsgrad"
  },
  Task_88954_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker im „Himmelsstürmer“ 1 Mal gewinnen"
  },
  Task_88955_Desc = {
    Text = "Abschluss von „Freiheit und Tod“ im Wahnsinnsmodus"
  },
  Task_88956_Desc = {
    Text = "Abschluss von “Einsame Reise“ in beliebigem Modus"
  },
  Task_88957_Desc = {
    Text = "Himmelsflug·Wahnsinn"
  },
  Task_88958_Desc = {
    Text = "Abschluss von „Freiheit und Tod“ in einem beliebigen Modus"
  },
  Task_88959_Desc = {
    Text = "Abschluss von „Freiheit und Tod“ in einem beliebigen Modus"
  },
  Task_88960_Desc = {
    Text = "Abschließen von „Endloser Sand“ im beliebigen Modus"
  },
  Task_88961_Desc = {
    Text = "Alle Erfolge von „Himmelsflug – Durchgang“ abschließen"
  },
  Task_88962_Desc = {
    Text = "Abschluss von „Bote der Kerze“ in beliebigem Modus"
  },
  Task_88963_Desc = {
    Text = "Abschluss von „Endloser Sand“ – Wahnsinns-Schwierigkeitsgrad"
  },
  Task_88964_Desc = {
    Text = "Abschluss von „Narren“ im Wahnsinnsmodus"
  },
  Task_88965_Desc = {
    Text = "Abschluss von „Traum der vergangenen Nacht“ im Wahnsinnsmodus"
  },
  Task_88966_Desc = {
    Text = "Absolvieren von „Einsame Reise“ im Wahnsinnsmodus"
  },
  Task_88967_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im „Himmelsstürmer“ 2 Mal gewinnen"
  },
  Task_88968_Desc = {
    Text = "Abschluss von „Traum von gestern“ in beliebigem Modus"
  },
  Task_88969_Desc = {
    Text = "Himmelsflug·Grenzgebiet"
  },
  Task_88970_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Himmelsstürmer“ zweimal gewinnen"
  },
  Task_88971_Desc = {
    Text = "Himmelsflug · Abschluss"
  },
  Task_88972_Desc = {
    Text = "Abschluss von „Endloser Sand“ in beliebigem Modus"
  },
  Task_88973_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Himmelsstürmer“ einmal gewinnen"
  },
  Task_88974_Desc = {
    Text = "Abschluss „Narren“ beliebiger Schwierigkeitsgrad"
  },
  Task_88975_Desc = {
    Text = "Abschluss von „Bote der Kerze“ im Wahnsinnsmodus"
  },
  Task_88976_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker im “Himmelsstürmer“ 2 Mal gewinnen"
  },
  Task_88977_Desc = {
    Text = "Abschluss von „Traum von gestern“ in beliebigem Modus"
  },
  Task_88978_Desc = {
    Text = "Abschluss „Narren“ beliebiger Schwierigkeitsgrad"
  },
  Task_89577_Desc = {
    Text = "Kumulativer Login: 12 Tage"
  },
  Task_89578_Desc = {
    Text = "Logge dich insgesamt 15 Tage lang ein"
  },
  Task_89579_Desc = {
    Text = "Logge dich insgesamt 2 Tage lang ein"
  },
  Task_89580_Desc = {
    Text = "Logge dich insgesamt 10 Tage lang ein"
  },
  Task_89581_Desc = {
    Text = "Kumulativer Login: 11 Tage"
  },
  Task_89582_Desc = {
    Text = "Logge dich an insgesamt 3 aufeinander folgenden Tagen ein"
  },
  Task_89583_Desc = {
    Text = "Kumulativer Login für 6 Tage"
  },
  Task_89584_Desc = {
    Text = "Insgesamt 16 Tage eingeloggt"
  },
  Task_89585_Desc = {
    Text = "Logge dich insgesamt 4 Tage lang ein"
  },
  Task_89586_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_89587_Desc = {
    Text = "Logge dich insgesamt 7 Tage lang ein"
  },
  Task_89588_Desc = {
    Text = "14-tägliche kumulierte Anmeldung"
  },
  Task_89589_Desc = {
    Text = "Logge dich insgesamt 8 Tage lang ein"
  },
  Task_89590_Desc = {
    Text = "Logge dich an insgesamt 5 aufeinander folgenden Tagen ein"
  },
  Task_89591_Desc = {
    Text = "Kumulativer Login: 13 Tage"
  },
  Task_89592_Desc = {
    Text = "Insgesamt 9 Tage eingeloggt"
  },
  Task_89844_Desc = {
    Text = "Erste Schicksalsbahn-Bindungserweckung({s1}/1)"
  },
  Task_89844_Name = {
    Text = "Aufgabe abschließen und Phantasma-Robe-Zeichnungs-Gutschein erhalten"
  },
  Task_89845_Desc = {
    Text = "7-Tage-Anmeldung ({s1}/7)"
  },
  Task_89845_Name = {
    Text = "Aufgabe abschließen und Phantasma-Robe-Zeichnungs-Gutschein erhalten"
  },
  Task_89846_Desc = {
    Text = "Fremdartige Gezeitencluster zurückgeschlagen ({s1}/30)"
  },
  Task_89846_Name = {
    Text = "Aufgabe abschließen und Phantasma-Robe-Zeichnungs-Gutschein erhalten"
  },
  Task_90036_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_90036_Name = {Text = "6 Siege"},
  Task_90037_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_90037_Name = {Text = "3 Siege"},
  Task_90038_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_90038_Name = {Text = "10 Siege"},
  Task_90039_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_90039_Name = {Text = "1 Sieg"},
  Task_90495_Desc = {
    Text = "Schließe Praktischer Unterricht·Chaos-Gedanken ab"
  },
  Task_90495_Name = {
    Text = "Chaos Offenbarung"
  },
  Task_90866_Desc = {
    Text = "Vorübergehender Text I"
  },
  Task_90867_Desc = {
    Text = "Tausend Wünsche I"
  },
  Task_90868_Desc = {
    Text = "Vorübergehender Text · Frei"
  },
  Task_90869_Desc = {
    Text = "Schädelhofklage VII"
  },
  Task_90870_Desc = {
    Text = "Vorübergehender Text IV"
  },
  Task_90871_Desc = {
    Text = "Konjugierte Schicksale III"
  },
  Task_90872_Desc = {
    Text = "Schädelhofklage I"
  },
  Task_90873_Desc = {
    Text = "Tausend Wünsche V"
  },
  Task_90874_Desc = {
    Text = "Vorübergehender Text VI"
  },
  Task_90875_Desc = {
    Text = "Vorübergehender Text I"
  },
  Task_90876_Desc = {
    Text = "Vorübergehender Text · Kostenlos"
  },
  Task_90877_Desc = {
    Text = "Gartenklage des Schädelhofs · Kostenlos"
  },
  Task_90878_Desc = {
    Text = "Gartenklage VI"
  },
  Task_90879_Desc = {
    Text = "Tausend Wünsche IV"
  },
  Task_90880_Desc = {
    Text = "Tausend Wünsche: Kostenlos"
  },
  Task_90881_Desc = {
    Text = "Schädelhofklage III"
  },
  Task_90882_Desc = {
    Text = "Konjugierte SchicksaleII"
  },
  Task_90883_Desc = {
    Text = "Vorübergehender Text V"
  },
  Task_90884_Desc = {
    Text = "Schädelhofklage V"
  },
  Task_90885_Desc = {
    Text = "Vorübergehender Text VI"
  },
  Task_90886_Desc = {
    Text = "Vorübergehender Text VII"
  },
  Task_90887_Desc = {
    Text = "Konjugierter Lebensweg VI"
  },
  Task_90888_Desc = {
    Text = "Konjugierte Schicksale IV"
  },
  Task_90889_Desc = {
    Text = "Klage im Schädelhof IV"
  },
  Task_90890_Desc = {
    Text = "Konjugierter Lebensweg V"
  },
  Task_90891_Desc = {
    Text = "Konjugierte Schicksalswege I"
  },
  Task_90892_Desc = {
    Text = "Tausend Wünsche III"
  },
  Task_90893_Desc = {
    Text = "Vorübergehender Text II"
  },
  Task_90894_Desc = {
    Text = "Vorübergehender Text III"
  },
  Task_90895_Desc = {
    Text = "Konjugierter Lebensweg VII"
  },
  Task_90896_Desc = {
    Text = "Schädelhofklage II"
  },
  Task_90897_Desc = {
    Text = "Vorübergehender Text VII"
  },
  Task_90898_Desc = {
    Text = "Vorübergehender Text V"
  },
  Task_90899_Desc = {
    Text = "Vorübergehender Text IV"
  },
  Task_90900_Desc = {
    Text = "Tausend Wünsche VI"
  },
  Task_90901_Desc = {
    Text = "Konjugierter Lebensweg·Kostenlos"
  },
  Task_90902_Desc = {
    Text = "Tausend Wünsche II"
  },
  Task_90903_Desc = {
    Text = "Vorübergehender Text III"
  },
  Task_90904_Desc = {
    Text = "Tausend Wünsche VII"
  },
  Task_90905_Desc = {
    Text = "Vorübergehender Text II"
  },
  Task_91028_Desc = {
    Text = "Abschließen von „Kriegerkranz“ im Wahnsinnsmodus"
  },
  Task_91029_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Heiliger Jäger“ 1 Mal gewinnen"
  },
  Task_91030_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Heilige Jäger“ einmal gewinnen"
  },
  Task_91031_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker einmal im „Heilige Jagd“ gewinnen"
  },
  Task_91032_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Heilige Jäger“ zweimal gewinnen"
  },
  Task_91033_Desc = {
    Text = "Heilige Jagd·Abschluss"
  },
  Task_91034_Desc = {
    Text = "Abschließen des Modus „Furchteinflößender Jäger“ in beliebiger Schwierigkeit"
  },
  Task_91035_Desc = {
    Text = "Heilige Jagd·Wahnsinn"
  },
  Task_91036_Desc = {
    Text = "Beliebigen Schwierigkeitsgrad von „Signalhorn der Expedition“ abschließen"
  },
  Task_91037_Desc = {
    Text = "Abschließen von „Gemeinsame Weisheit“ in beliebiger Schwierigkeit"
  },
  Task_91038_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Heiliger Jäger“ 2 Mal gewinnen"
  },
  Task_91039_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker im “Heilige Jäger“ 2 Mal gewinnen"
  },
  Task_91040_Desc = {
    Text = "Durchspielen der Traumlandschaft „Küchenabenteuer“"
  },
  Task_91041_Desc = {
    Text = "Abschluss von „Kriegerkranz“ auf beliebiger Schwierigkeitsstufe"
  },
  Task_91042_Desc = {
    Text = "Beliebiger Schwierigkeitsgrad von „Kriegerkranz“ abgeschlossen"
  },
  Task_91043_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Heilige Jagd“ einmal gewinnen"
  },
  Task_91044_Desc = {
    Text = "Abschluss von „Ruhmreiche Rückkehr“ in beliebiger Schwierigkeit"
  },
  Task_91045_Desc = {
    Text = "Abschließen von “Furchteinflößender Jäger“ im beliebigen Modus"
  },
  Task_91046_Desc = {
    Text = "Abschluss von „Gemeinsame Weisheit“ im Wahnsinnsmodus"
  },
  Task_91047_Desc = {
    Text = "Abschluss von „Signalhorn der Expedition“ in beliebigem Schwierigkeitsgrad"
  },
  Task_91048_Desc = {
    Text = "Abschluss von „Gemeinsame Weisheit“ in jedem Schwierigkeitsgrad"
  },
  Task_91049_Desc = {
    Text = "Absolvieren von „Ruhmreiche Rückkehr“ in beliebiger Schwierigkeit"
  },
  Task_91050_Desc = {
    Text = "Alle Erfolge von “Heilige Jagd·Durchspiel“ abschließen"
  },
  Task_91051_Desc = {
    Text = "Abschließen von “Signalhorn der Expedition“ im Wahnsinnsmodus"
  },
  Task_91052_Desc = {
    Text = "Abschließen von „Ruhmreiche Rückkehr“ im Wahnsinnsmodus"
  },
  Task_91053_Desc = {
    Text = "Heilige Jagd·Reich"
  },
  Task_91054_Desc = {
    Text = "Abschließen von “Furchtloser Jäger“ im Wahnsinnsmodus"
  },
  Task_91055_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Heilige Jäger“ zweimal gewinnen"
  },
  Task_91129_Desc = {
    Text = "Stufe 20 erreicht"
  },
  Task_91131_Desc = {
    Text = "Stufe 5 erreicht"
  },
  Task_91149_Desc = {
    Text = "Stufe erreicht Level 15"
  },
  Task_91154_Desc = {
    Text = "Stufe 10 erreicht"
  },
  Task_91332_Desc = {
    Text = "Besiege Durschein"
  },
  Task_91332_Name = {Text = "Ziel"},
  Task_91333_Desc = {
    Text = "Besiege die Eindringlinge"
  },
  Task_91333_Name = {Text = "Ziel"},
  Task_91334_Desc = {
    Text = "Besiege die „Korrosionspuppe“ und schütze die Stadt der Knochen"
  },
  Task_91334_Name = {Text = "Ziel"},
  Task_91335_Desc = {
    Text = "Besiege den Seefahrer"
  },
  Task_91335_Name = {Text = "Ziel"},
  Task_91336_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_91336_Name = {
    Text = "Perfekter Pass"
  },
  Task_91337_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_91337_Name = {
    Text = "Perfekter Pass"
  },
  Task_91338_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_91338_Name = {
    Text = "Perfekter Pass"
  },
  Task_91339_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_91339_Name = {
    Text = "Perfekter Pass"
  },
  Task_91340_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_91340_Name = {
    Text = "Perfekter Pass"
  },
  Task_91341_Desc = {
    Text = "Zerstöre Pickmans «Werk»"
  },
  Task_91341_Name = {Text = "Ziel"},
  Task_91342_Desc = {
    Text = "Besiege die Feinde und betrete die Stadt des Ghul-Königs"
  },
  Task_91342_Name = {Text = "Ziel"},
  Task_91343_Desc = {
    Text = "Von Ghulen entkommen"
  },
  Task_91343_Name = {Text = "Ziel"},
  Task_91344_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_91344_Name = {
    Text = "Perfekter Pass"
  },
  Task_91345_Desc = {
    Text = "Besiege den Auflöser"
  },
  Task_91345_Name = {Text = "Ziel"},
  Task_91346_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_91346_Name = {
    Text = "Perfekter Pass"
  },
  Task_91347_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_91347_Name = {
    Text = "Perfekter Pass"
  },
  Task_91348_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_91348_Name = {
    Text = "Perfekter Pass"
  },
  Task_91349_Desc = {
    Text = "Goliath vertreiben und den magischen Kreis zerstören"
  },
  Task_91349_Name = {Text = "Ziel"},
  Task_91350_Desc = {
    Text = "Vollständig ohne das Auslösen von Notfall-Gnosis"
  },
  Task_91350_Name = {
    Text = "Perfekter Pass"
  },
  Task_91351_Desc = {
    Text = "Besiege Butler Frank"
  },
  Task_91351_Name = {Text = "Ziel"},
  Task_91357_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_91358_Desc = {
    Text = "Abgeschlossen: Sternenkapitel, Kapitel 3, 3-5"
  },
  Task_91359_Desc = {
    Text = "Vollständig das Ermittlungsereignis \"@1@2\""
  },
  Task_91359_Desc2 = {
    Text = "Abschluss des Untersuchungsereignisses „Vollschmaus“"
  },
  Task_91359_Name2 = {
    Text = "Gemeinsames Mahl von Knochen und Seele"
  },
  Task_91360_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_91361_Desc = {
    Text = "Abschluss des Sternenkapitels, Kapitel 3, 3-5, Schwierigkeitsgrad: Schwer"
  },
  Task_91362_Desc = {
    Text = "Abschließen des Sternenkapitels Kapitel 3 „Vollkost“ im schweren Schwierigkeitsgrad"
  },
  Task_91363_Desc = {
    Text = "Abschluss des Untersuchungsereignisses „Vollschmaus“ in hartem Schwierigkeitsgrad"
  },
  Task_91363_Name = {
    Text = "Gemeinsames Mahl aus Knochen und Geist · Schwierigkeitsgrad"
  },
  Task_91364_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_91365_Desc = {
    Text = "Abgeschlossen: Sternenkapitel Kapitel 3 „Sättigendes Mahl“"
  },
  Task_91366_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_91367_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_91368_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_91370_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_91371_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_91372_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_91373_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_91379_Desc = {
    Text = "Durchspielung des Sternenkapitels Kapitel 3, Abschnitt 2-5 im Schwierigkeitsgrad „Schwer“"
  },
  Task_91380_Desc = {
    Text = "Abgeschlossen: Sternenkapitel 3, 2-5"
  },
  Task_91381_Desc = {
    Text = "Durchspielung des Sternenkapitels Kapitel 3 „Sättigung“ im schweren Schwierigkeitsgrad"
  },
  Task_91382_Desc = {
    Text = "Abgeschlossen: Sternenkapitel Kapitel 3 “Sättigendes Mahl“"
  },
  Task_91436_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_91436_Name = {Text = "1 Sieg"},
  Task_91437_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_91437_Name = {Text = "3 Siege"},
  Task_91438_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_91438_Name = {Text = "6 Siege"},
  Task_91439_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_91439_Name = {Text = "10 Siege"},
  Task_91720_Desc = {
    Text = "7-Tage-Anmeldung ({s1}/7)"
  },
  Task_91720_Name = {
    Text = "Aufgabe abschließen und Phantasma-Robe-Zeichnungs-Gutschein erhalten"
  },
  Task_91721_Desc = {
    Text = "Alle Wahnsinnsmodi abschließen ({s1}/5)"
  },
  Task_91721_Name = {
    Text = "Aufgabe abschließen und Phantasma-Robe-Zeichnungs-Gutschein erhalten"
  },
  Task_91786_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Göttliches Reich - Geburt“ 2-mal gewinnen"
  },
  Task_91787_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Göttliches Reich - Geburt“ 2 Mal gewinnen"
  },
  Task_91788_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Göttliches-Reichs-Geburtsereignis“ 2-mal gewinnen"
  },
  Task_91789_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker im “Göttliches Reich - Geburt“ 2-mal gewinnen"
  },
  Task_94489_Desc = {
    Text = "Erhöhe 6 Chaos-Charaktere auf Level 80"
  },
  Task_94489_Name = {
    Text = "ReichsbeherrschungⅩ"
  },
  Task_94490_Desc = {
    Text = "Erhöhe 6 Tiefsee-Charaktere auf Level 70"
  },
  Task_94490_Name = {
    Text = "ReichsbeherrschungⅨ"
  },
  Task_94491_Desc = {
    Text = "Erhöhe 6 Hyperraum-Charaktere auf Level 70"
  },
  Task_94491_Name = {
    Text = "ReichsbeherrschungⅨ"
  },
  Task_94492_Desc = {
    Text = "Erhöhe 6 Fleisch-Charaktere auf Level 80"
  },
  Task_94492_Name = {
    Text = "ReichsbeherrschungⅩ"
  },
  Task_94493_Desc = {
    Text = "Erhöhe 6 Tiefsee-Charaktere auf Level 80"
  },
  Task_94493_Name = {
    Text = "ReichsbeherrschungⅩ"
  },
  Task_94494_Desc = {
    Text = "Erhöhe 6 Fleisch-Charaktere auf Level 70"
  },
  Task_94494_Name = {
    Text = "ReichsbeherrschungⅨ"
  },
  Task_94495_Desc = {
    Text = "Erhöhe 6 Chaos-Charaktere auf Level 70"
  },
  Task_94495_Name = {
    Text = "ReichsbeherrschungⅨ"
  },
  Task_94496_Desc = {
    Text = "Erhöhe 6 Hyperraum-Charaktere auf Level 80"
  },
  Task_94496_Name = {
    Text = "ReichsbeherrschungⅩ"
  },
  Task_94497_Desc = {
    Text = "Vollständig alle Aufgaben in diesem Kapitel, um Belohnungen zu erhalten."
  },
  Task_94497_Name = {
    Text = "ReichsbeherrschungⅩ"
  },
  Task_94498_Desc = {
    Text = "Vollständig alle Aufgaben in diesem Kapitel, um Belohnungen zu erhalten."
  },
  Task_94498_Name = {
    Text = "ReichsbeherrschungⅨ"
  },
  Task_94613_Desc = {
    Text = "Praktischer Unterricht abgeschlossen · Ultra-Geheimgang"
  },
  Task_94613_Name = {
    Text = "Das Ultra-Reich"
  },
  Task_94614_Desc = {
    Text = "Praktischer Unterricht abgeschlossen · Fleisch-Kolonie"
  },
  Task_94614_Name = {
    Text = "Ausbreitung des Fleisches"
  },
  Task_94615_Desc = {
    Text = "Praktischer Unterricht Abgeschlossen: Aequor Tendrils"
  },
  Task_94615_Name = {
    Text = "Berührung des Aequor"
  },
  Task_94699_Desc = {
    Text = "Schädelhofklage · Exklusives zeitlich begrenztes Angebot"
  },
  Task_94861_Desc = {
    Text = "1.800 Menophin-Punkte verbrauchen"
  },
  Task_94863_Desc = {
    Text = "Kumulativ 100 Mal erwacht"
  },
  Task_94865_Desc = {
    Text = "Verwende Unterstützung 3 Mal"
  },
  Task_94867_Desc = {
    Text = "Katastrophentrainingswert in der Schmelzkatastrophen-Zone erreicht 100"
  },
  Task_94871_Desc = {
    Text = "Schließe das Kätigula-Testlevel 1-mal ab"
  },
  Task_94874_Desc = {
    Text = "2 wöchentliche Prüfungen abschließen"
  },
  Task_94876_Desc = {
    Text = "1.800 Menophin-Punkte verbrauchen"
  },
  Task_94877_Desc = {
    Text = "Vollständig 20 Aufgaben"
  },
  Task_94882_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_94885_Desc = {
    Text = "2 Wochen wöchentliche Prüfungen abschließen"
  },
  Task_94886_Desc = {
    Text = "Schließe den Probier-Checkpunkt von Kätigula 1-mal ab"
  },
  Task_94888_Desc = {
    Text = "Verwende Unterstützung 3 Mal"
  },
  Task_94891_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_94895_Desc = {
    Text = "Katastrophentrainingswert 100 erreicht"
  },
  Task_94898_Desc = {
    Text = "Kumulativ 100 Mal erwacht"
  },
  Task_94901_Desc = {
    Text = "Vollständig 20 Aufgaben"
  },
  Task_95192_Desc = {
    Text = "Abschluss von „Sonne der Erdoberfläche“ im Wahnsinnsmodus"
  },
  Task_95193_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker zweimal im „Aschentöter-Jagd“ gewinnen"
  },
  Task_95194_Desc = {
    Text = "Abschließen der „Stillen Welt“ im beliebigen Modus"
  },
  Task_95195_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Aschentöter-Jagd“ 1 Mal gewinnen"
  },
  Task_95196_Desc = {
    Text = "Das Bewusstsein durchwandern „Unvergänglicher Polartag“ abgeschlossen"
  },
  Task_95197_Desc = {
    Text = "Vertragsziel auf beliebiger Schwierigkeit abschließen"
  },
  Task_95198_Desc = {
    Text = "Durchspielen von “Stille Welt“ im Wahnsinnsmodus"
  },
  Task_95199_Desc = {
    Text = "Abschluss von „Vertragsziel“ im beliebigen Modus"
  },
  Task_95200_Desc = {
    Text = "Abschluss von „Sonne der Erdoberfläche“ in einem beliebigen Modus"
  },
  Task_95201_Desc = {
    Text = "Abschluss von „Glühendes Urteil“ in beliebigem Modus"
  },
  Task_95202_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Aschentöter-Jagd“ 1 Mal gewinnen"
  },
  Task_95203_Desc = {
    Text = "Abschluss von „Uralter Schwur“ in beliebigem Modus"
  },
  Task_95204_Desc = {
    Text = "Absolvieren von “Glühendes Urteil“ in beliebiger Schwierigkeit"
  },
  Task_95205_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker einmal im „Aschentöter-Jagd“ gewinnen"
  },
  Task_95206_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker zweimal im „Aschentöter-Jagd“ gewinnen"
  },
  Task_95207_Desc = {
    Text = "Absolvieren von „Licht der Zerstörung“ in beliebiger Schwierigkeit"
  },
  Task_95208_Desc = {
    Text = "Abschluss von „Sonne der Erdoberfläche“ in einem beliebigen Modus"
  },
  Task_95209_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker einmal im „Aschentöter-Jagd“-Modus gewinnen"
  },
  Task_95210_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker zweimal im „Aschentöter-Jagd“ gewinnen"
  },
  Task_95211_Desc = {
    Text = "Absolviere “Glühendes Urteil“ im Wahnsinnsmodus"
  },
  Task_95212_Desc = {
    Text = "Aschevernichtungsjagd·Wahnsinn"
  },
  Task_95213_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Aschentöter-Jagd“ 2 Mal gewinnen"
  },
  Task_95214_Desc = {
    Text = "Abschluss von „Vertragsziel“ im Wahnsinnsmodus"
  },
  Task_95215_Desc = {
    Text = "Abschluss von “Stille Welt“ in beliebigem Schwierigkeitsgrad"
  },
  Task_95216_Desc = {
    Text = "Absolvieren von “Licht der Zerstörung“ in beliebiger Schwierigkeit"
  },
  Task_95217_Desc = {
    Text = "Aschevernichtungsjagd·Reich"
  },
  Task_95218_Desc = {
    Text = "Abschluss von „Hölle – Gesang“ im beliebigen Schwierigkeitsgrad"
  },
  Task_95219_Desc = {
    Text = "Abschließen von „Uralter Schwur“ in beliebiger Schwierigkeit"
  },
  Task_95220_Desc = {
    Text = "Abschließen von „Uralter Schwur“ im Wahnsinnsmodus"
  },
  Task_95221_Desc = {
    Text = "Abschluss von „Licht der Vernichtung“ im Wahnsinnsmodus"
  },
  Task_95222_Desc = {
    Text = "Abschließen des “Höllengesangs“ in beliebiger Schwierigkeit"
  },
  Task_95223_Desc = {
    Text = "Alle Erfolge von „Aschevernichtungsjagd – Abschluss“ abschließen"
  },
  Task_95224_Desc = {
    Text = "Abschluss von „Hölle-Gesang“ im Wahnsinnsmodus"
  },
  Task_95225_Desc = {
    Text = "Aschevernichtungsjagd · Abschließen"
  },
  Task_95470_Desc = {Text = "Besiege N"},
  Task_95470_Name = {Text = "Ziel"},
  Task_95520_Desc = {
    Text = "Kumulative Extraktion von 16000 Silberprimus"
  },
  Task_95521_Desc = {
    Text = "Kumulative Extraktion von 25000 Silberprimus"
  },
  Task_95522_Desc = {
    Text = "Kumulative Extraktion von 13000 Silberprimus"
  },
  Task_95523_Desc = {
    Text = "Kumulative Extraktion von 8000 Silberprimus"
  },
  Task_95524_Desc = {
    Text = "Kumulative Extraktion von 2000 Silberprimus"
  },
  Task_95525_Desc = {
    Text = "Kumulative Extraktion von 20000 Silberprimus"
  },
  Task_95526_Desc = {
    Text = "Kumulative Extraktion von 4000 Silberprimus"
  },
  Task_95527_Desc = {
    Text = "Kumulative Extraktion von 5000 Silberprimus"
  },
  Task_95532_Desc = {
    Text = "Gartengeschichten·Wahnsinn"
  },
  Task_95533_Desc = {
    Text = "Abschluss von „Asche“ im Wahnsinnsmodus"
  },
  Task_95534_Desc = {
    Text = "Abschließen von „Kleines Königreich“ im Wahnsinnsmodus"
  },
  Task_95535_Desc = {
    Text = "Abschluss von “Die erste Rose“ im Wahnsinnsmodus"
  },
  Task_95536_Desc = {
    Text = "Abschluss von „Hand in Hand“ im Wahnsinnsmodus"
  },
  Task_95537_Desc = {
    Text = "Abschluss von „Blühendes Gedicht“ im Wahnsinnsmodus"
  },
  Task_95543_Desc = {
    Text = "Vollständig \"Die erste Rose\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_95544_Desc = {
    Text = "Clear \"Händchenhalten\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_95545_Desc = {
    Text = "Vollständig \"Das Gedicht der Blüte\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_95546_Desc = {
    Text = "\"Ashes\" auf jeder Schwierigkeit erfolgreich abschließen"
  },
  Task_95547_Desc = {
    Text = "Clear \"Königreich in Miniatur\" auf beliebigem Schwierigkeitsgrad"
  },
  Task_95830_Desc = {
    Text = "Verzehrendes Seelenmahl·Reich"
  },
  Task_95831_Desc = {
    Text = "Absolvieren von „Todesflamme“ im Wahnsinnsmodus"
  },
  Task_95832_Desc = {
    Text = "Abschluss von \"Humus-Parfümierung\" in beliebigem Modus"
  },
  Task_95833_Desc = {
    Text = "Abschluss von „Humus-Parfümierung“ im Wahnsinnsmodus"
  },
  Task_95834_Desc = {
    Text = "Abschließen von „Sarg öffnen“ im beliebigen Modus"
  },
  Task_95835_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Seelenfresser-Mahl“ 2-mal gewinnen"
  },
  Task_95836_Desc = {
    Text = "Erwirb Dureisen bei Erleuchtung Stufe 2"
  },
  Task_95836_Name = {
    Text = "Erwirb Durexain bei Erleuchtung Stufe 2"
  },
  Task_95836_UnlockCondDesc = {
    Text = "Aktivität @Erwecker Dulsay Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_95837_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_95838_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_95839_Desc = {
    Text = "Abschluss von „Sarg öffnen“ in beliebigem Modus"
  },
  Task_95840_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Seelenfresser-Mahl“ 1 Mal gewinnen"
  },
  Task_95841_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Seelenfresser-Mahl“ 1-mal gewinnen"
  },
  Task_95842_Desc = {
    Text = "Abschluss von „Knochenfleisch-Trennung“ im Wahnsinnsmodus"
  },
  Task_95843_Desc = {
    Text = "Abschließen des “Heiligtumsmahls“ im Wahnsinnsmodus"
  },
  Task_95844_Desc = {
    Text = "Abschließen von „Geisterflamme“ im beliebigen Schwierigkeitsgrad"
  },
  Task_95845_Desc = {
    Text = "Abschluss von „Geisterflamme“ in beliebigem Schwierigkeitsgrad"
  },
  Task_95846_Desc = {
    Text = "Durschein erreicht die Affinität Stufe 10"
  },
  Task_95847_Desc = {
    Text = "Verzehrende Seele Mahl·Durchgang"
  },
  Task_95848_Desc = {
    Text = "Alle Aufgaben von „Verzehrende Seele: Mahl – Durchgang“ abschließen"
  },
  Task_95849_Desc = {
    Text = "Abschließen von „Sarg öffnen“ im Wahnsinnsmodus"
  },
  Task_95850_Desc = {
    Text = "Erwirb Durexain bei Erleuchtungsstufe 6"
  },
  Task_95850_Name = {
    Text = "Erwirb Durexain bei Erleuchtungsstufe 6"
  },
  Task_95850_UnlockCondDesc = {
    Text = "Aktivität @Erweckungswesen Durschein Erleuchtungs-Geschenkpaket 2 Aktivität"
  },
  Task_95853_Desc = {
    Text = "Abschluss von „Knochen-Mark-Trennung“ im beliebigen Modus"
  },
  Task_95854_Desc = {
    Text = "Verzehrendes Mahl des Wahnsinns"
  },
  Task_95855_Desc = {
    Text = "Abschließen der “Heiligen Schreinfeier“ in beliebiger Schwierigkeit"
  },
  Task_95856_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Seelenfresser-Mahl“ 1 Mal gewinnen"
  },
  Task_95857_Desc = {
    Text = "Abschließen der „Humus-Parfümierung“ in beliebiger Schwierigkeit"
  },
  Task_95858_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker im “Seelenfresser-Mahl“ 1× gewinnen"
  },
  Task_95860_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker im “Seelenfresser Mahl“ 2-mal gewinnen"
  },
  Task_95861_Desc = {
    Text = "Abschluss von „Knochenmark-Trennung“ in beliebigem Schwierigkeitsgrad"
  },
  Task_95862_Desc = {
    Text = "Zweimal mit einem Tiefsee-Grenzgebiet-Erwecker im “Seelenfresser-Mahl“ gewinnen"
  },
  Task_95863_Desc = {
    Text = "Abschluss von „Heiligtumsmahl“ in beliebiger Schwierigkeit"
  },
  Task_95864_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker zweimal im „Seelenfresser-Mahl“ gewinnen"
  },
  Task_95865_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_95866_UnlockCondDesc = {
    Text = "Bitte fordere das vorherige Geschenkpaket an."
  },
  Task_96333_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_96333_Name = {Text = "10 Siege"},
  Task_96334_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_96334_Name = {Text = "3 Siege"},
  Task_96335_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_96335_Name = {Text = "6 Siege"},
  Task_96336_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_96336_Name = {Text = "1 Sieg"},
  Task_96618_Desc = {
    Text = "Austausch 3 Mal mit Goldcoupon im Laden"
  },
  Task_96619_Desc = {
    Text = "Vollständig 20 Aufgaben"
  },
  Task_96620_Desc = {
    Text = "Katastrophentrainingswert 100 in der Schmelzkatastrophen-Zone erreicht"
  },
  Task_96621_Desc = {
    Text = "Schließe die „24“ Chaos-Prüfung 1 Mal ab"
  },
  Task_96622_Desc = {
    Text = "Schließe alle wöchentlichen Prüfungsaufgaben für 2 Wochen ab"
  },
  Task_96623_Desc = {
    Text = "1 Mal Transzendente Existenz abschließen"
  },
  Task_96624_Desc = {
    Text = "Logge dich insgesamt 15 Tage lang ein"
  },
  Task_96625_Desc = {
    Text = "Vollständig 20 Aufgaben"
  },
  Task_96626_Desc = {
    Text = "Katastrophentrainingswert 100 in der Schmelzkatastrophen-Zone erreicht"
  },
  Task_96627_Desc = {
    Text = "1 Mal Transzendente Existenz abschließen"
  },
  Task_96628_Desc = {
    Text = "Verbrauche 1800 Menophin-Punkte"
  },
  Task_96629_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_96630_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_96631_Desc = {
    Text = "Austausch 3 Mal mit Goldcoupon im Laden"
  },
  Task_96632_Desc = {
    Text = "Verbrauche 1800 Menophin-Punkte"
  },
  Task_96633_Desc = {
    Text = "Schließe die „24“ Chaos-Prüfung 1 Mal ab"
  },
  Task_96840_Desc = {
    Text = "Traumlandschaft-Karte·Abschluss"
  },
  Task_96841_Desc = {
    Text = "Abschluss von “Hölle – Wandel“ in beliebigem Modus"
  },
  Task_96842_Desc = {
    Text = "Abschluss von “Stier-Wahnsinnstanz“ in beliebiger Schwierigkeit"
  },
  Task_96843_Desc = {
    Text = "Abschluss von “Seelenlinie“ in beliebigem Modus"
  },
  Task_96844_Desc = {
    Text = "Abschluss von “Karnevalsstillstand“ im Wahnsinnsmodus"
  },
  Task_96845_Desc = {
    Text = "Abschluss von “Goldener Stier Tanz“ im Wahnsinnsmodus"
  },
  Task_96846_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker im “Fremde Welt - Schriftrolle“ 2-mal gewinnen"
  },
  Task_96847_Desc = {
    Text = "Abschluss “Inspirationseinfluss“ beliebiger Schwierigkeitsgrad"
  },
  Task_96848_Desc = {
    Text = "Abschluss von “Blutige Ausbreitung“ im Wahnsinnsmodus"
  },
  Task_96849_Desc = {
    Text = "Abschluss von “Blutrote Ausbreitung“ in beliebigem Modus"
  },
  Task_96850_Desc = {
    Text = "Abschluss von “Stier-Wahnsinnstanz“ in beliebigem Schwierigkeitsgrad"
  },
  Task_96851_Desc = {
    Text = "Abschluss von “Blutige Ausbreitung“ in beliebigem Modus"
  },
  Task_96852_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Fremde Welten - Schriftrolle“ zweimal gewinnen"
  },
  Task_96853_Desc = {
    Text = "Alle Erfolge von “Fremde Welt: Durchspielen“ abschließen"
  },
  Task_96854_Desc = {
    Text = "Abschluss von “Seelenlinie“ in beliebigem Modus"
  },
  Task_96855_Desc = {
    Text = "Abschluss von “Tanzfest“ in beliebiger Schwierigkeit"
  },
  Task_96856_Desc = {
    Text = "Traumlandschaft-Karte·Reich"
  },
  Task_96857_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Fremde-Welt-Rolle“ zweimal gewinnen"
  },
  Task_96858_Desc = {
    Text = "Abschluss von “Seelenlinie: Verwüstung“ im Wahnsinnsmodus"
  },
  Task_96859_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Fremde Welt-Rolle“ einmal gewinnen"
  },
  Task_96860_Desc = {
    Text = "Abschluss von “Hölle – Veränderung“ in beliebigem Schwierigkeitsgrad"
  },
  Task_96861_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Fremde Weltrolle“ einmal gewinnen"
  },
  Task_96862_Desc = {
    Text = "Das Wandern im Spiel “Verzerrte Weltzeichnung“ abschließen"
  },
  Task_96863_Desc = {
    Text = "Abschluss “Albtraumhaufen“ beliebiger Schwierigkeitsgrad"
  },
  Task_96864_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Weltenscroll“ einmal gewinnen"
  },
  Task_96865_Desc = {
    Text = "Abschluss von “Inspiration Infektion“ im Wahnsinnsmodus"
  },
  Task_96866_Desc = {
    Text = "Abschluss von “Albtraumhaufen“ in beliebigem Modus"
  },
  Task_96867_Desc = {
    Text = "Traumlandschaft-Karte · Wahnsinn"
  },
  Task_96868_Desc = {
    Text = "Abschluss von “Tanzfest“ in beliebigem Modus"
  },
  Task_96869_Desc = {
    Text = "Abschluss “Inspiration Infektion“ beliebiger Schwierigkeitsgrad"
  },
  Task_96870_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Fremde Welt - Schriftrolle“ 2-mal gewinnen"
  },
  Task_96871_Desc = {
    Text = "Abschluss von “Hölle-Veränderung“ im Wahnsinnsmodus"
  },
  Task_96872_Desc = {
    Text = "Abschluss von “Albtraumstapel“ im Wahnsinnsmodus"
  },
  Task_96873_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker im “Fremde Welt - Rollbild“ 1 Mal gewinnen"
  },
  Task_97192_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_97193_Desc = {
    Text = "Vollständig 20 Aufgaben"
  },
  Task_97194_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_97195_Desc = {
    Text = "1x Durschein-Demo-Level durchspielen"
  },
  Task_97196_Desc = {
    Text = "2 wöchentliche Prüfungen abschließen"
  },
  Task_97197_Desc = {
    Text = "Katastrophentrainingswert 100 in der Schmelzkatastrophen-Zone erreicht"
  },
  Task_97198_Desc = {
    Text = "Verbrauche 1800 Menophin-Punkte"
  },
  Task_97199_Desc = {
    Text = "1 Mal Transzendente Existenz abschließen"
  },
  Task_97200_Desc = {
    Text = "1 Mal Transzendente Existenz abschließen"
  },
  Task_97201_Desc = {
    Text = "1.800 Menophin-Punkte verbrauchen"
  },
  Task_97202_Desc = {
    Text = "3-mal tägliches Training abschließen"
  },
  Task_97203_Desc = {
    Text = "1x Durschein-Demo-Level abschließen"
  },
  Task_97243_Desc = {
    Text = "Vollständig 20 Aufgaben"
  },
  Task_97244_Desc = {
    Text = "2 Wochen lang wöchentliche Prüfungen abschließen"
  },
  Task_97245_Desc = {
    Text = "Katastrophentrainingswert 100 in der Schmelzkatastrophen-Zone erreicht"
  },
  Task_97246_Desc = {
    Text = "3-mal tägliches Training abschließen"
  },
  Task_97309_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 6 Mal Resonanz erzeugt"
  },
  Task_97309_Desc2 = {
    Text = "Bei der Ermittlung des Ereignisses“Sättigungsopfer“ wurde 6 Mal Resonanz erzeugt"
  },
  Task_97309_Name2 = {
    Text = "Völlerei-Echo III"
  },
  Task_97310_Desc = {
    Text = "Bei der Ermittlung des Ereignisses„@1@2\" wurde 9 Mal Resonanz erzeugt"
  },
  Task_97310_Desc2 = {
    Text = "Bei der Ermittlung des Ereignisses“Sättigungsessen“ wurde 9 Mal Resonanz erzeugt"
  },
  Task_97310_Name2 = {
    Text = "Echo der Völlerei IV"
  },
  Task_97311_Desc = {
    Text = "Bei der Untersuchung des Ereignisses “@1@2“ entstand 2-mal Resonanz"
  },
  Task_97311_Desc2 = {
    Text = "Bei der Ermittlung des Ereignisses „Vollschmaus“ wurde 2 Mal Resonanz erzeugt"
  },
  Task_97311_Name2 = {
    Text = "Echo der Völlerei"
  },
  Task_97312_Desc = {
    Text = "Bei der Untersuchung des Ereignisses “@1@2“ entstand 4-mal Resonanz"
  },
  Task_97312_Desc2 = {
    Text = "Bei der Untersuchung des Ereignisses „Vollschmaus“ entstand 4-mal Resonanz"
  },
  Task_97312_Name2 = {
    Text = "Völlerei-Echo II"
  },
  Task_97322_Desc = {
    Text = "Besiege die „Korrosionspuppe“, während du das Schutzgewebe des Träumenden Ozeans perfekt bewahrst."
  },
  Task_97322_Name = {
    Text = "Ein Versprechen, eine Wache - Verstecken"
  },
  Task_97673_Desc = {
    Text = "Abschluss von “Vorübergehender Text“ im Wahnsinnsmodus"
  },
  Task_97674_Desc = {
    Text = "Abschluss von „Vorübergehender Text“ im Wahnsinnsmodus"
  },
  Task_97675_Desc = {
    Text = "Abschluss von „Vorübergehender Text“ in beliebiger Schwierigkeit"
  },
  Task_97676_Desc = {
    Text = "Vorübergehender Text · Durchgang"
  },
  Task_97677_Desc = {
    Text = "Abschluss von “Vorübergehender Text“ in beliebiger Schwierigkeit"
  },
  Task_97678_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Temporärer Text“ einmal gewinnen"
  },
  Task_97679_Desc = {
    Text = "Alle Erfolge von „Vorübergehender Text · Abschlossen“ abschließen"
  },
  Task_97680_Desc = {
    Text = "Abschließen von „Vorübergehender Text“ im Wahnsinnsmodus"
  },
  Task_97681_Desc = {
    Text = "Abschluss „Vorübergehender Text“ – Wahnsinn-Modus"
  },
  Task_97682_Desc = {
    Text = "Abschließen von „Vorübergehender Text“ in beliebiger Schwierigkeit"
  },
  Task_97683_Desc = {
    Text = "Abschließen von „Vorübergehender Text“ in beliebiger Schwierigkeit"
  },
  Task_97684_Desc = {
    Text = "Beliebige Schwierigkeit von „Vorübergehender Text“ abschließen"
  },
  Task_97685_Desc = {
    Text = "Abschluss «Vorübergehender Text» Wahnsinn-Schwierigkeitsgrad"
  },
  Task_97686_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker im “Temporärer Text“ einmal gewinnen"
  },
  Task_97687_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Temporärer Text“ einmal gewinnen"
  },
  Task_97688_Desc = {
    Text = "Absolvieren von „Vorübergehender Text“ im Wahnsinnsmodus"
  },
  Task_97689_Desc = {
    Text = "Absolvieren von „Vorübergehender Text“ in beliebiger Schwierigkeit"
  },
  Task_97690_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker im “Temporärer Text“ zweimal gewinnen"
  },
  Task_97691_Desc = {
    Text = "Abschließen von “Vorübergehender Text“ in beliebiger Schwierigkeit"
  },
  Task_97692_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im „Temporärer Text“ 1 Mal gewinnen"
  },
  Task_97693_Desc = {
    Text = "Beliebige Schwierigkeit von “Vorübergehender Text“ abschließen"
  },
  Task_97694_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Temporärer Text“ zweimal gewinnen"
  },
  Task_97695_Desc = {
    Text = "Abschluss von “Vorübergehender Text“ in beliebiger Schwierigkeit"
  },
  Task_97696_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im „Temporärer Text“ 2-mal gewinnen"
  },
  Task_97697_Desc = {
    Text = "Abschluss des „Vorübergehenden Textes“ im Wahnsinn-Schwierigkeitsgrad"
  },
  Task_97698_Desc = {
    Text = "Vorübergehender Text · Wahnsinn"
  },
  Task_97699_Desc = {
    Text = "Abschließen von „Vorübergehender Text“ in beliebiger Schwierigkeit"
  },
  Task_97700_Desc = {
    Text = "Vorübergehender Text · Bereich"
  },
  Task_97701_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Temporärer Text“ zweimal gewinnen"
  },
  Task_97702_Desc = {
    Text = "Beliebige Schwierigkeit von “Vorübergehender Text“ abschließen"
  },
  Task_97703_Desc = {
    Text = "Abschluss von „Vorübergehender Text“ in beliebiger Schwierigkeit"
  },
  Task_97704_Desc = {
    Text = "Beliebige Schwierigkeit von „Vorübergehender Text“ abschließen"
  },
  Task_97705_Desc = {
    Text = "Abschluss von “Vorübergehender Text“ in beliebiger Schwierigkeit"
  },
  Task_97855_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Neue Dinge im Sonnenlicht“ einmal gewinnen"
  },
  Task_97856_Desc = {
    Text = "Kumulativer Login für 6 Tage"
  },
  Task_97857_Desc = {
    Text = "Logge dich insgesamt 4 Tage lang ein"
  },
  Task_97858_Desc = {
    Text = "Abschluss von “Poesie Garten“ im Wahnsinnsmodus"
  },
  Task_97859_Desc = {
    Text = "Abschluss der Traumlandschaft “Leb wohl, Niemandsland“"
  },
  Task_97860_Desc = {
    Text = "Logge dich an insgesamt 3 aufeinander folgenden Tagen ein"
  },
  Task_97861_Desc = {
    Text = "Alle Erfolge von “Neue Dinge unter der Sonne – Durchspielen“ abschließen"
  },
  Task_97862_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Neue Dinge im Sonnenlicht“ zweimal gewinnen"
  },
  Task_97863_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Neue Dinge im Sonnenlicht“ 1 Mal gewinnen"
  },
  Task_97864_Desc = {
    Text = "Abschluss von “Wiedersehen am alten Ort“ im Wahnsinnsmodus"
  },
  Task_97865_Desc = {
    Text = "Neuigkeiten im Sonnenlicht·Abschluss"
  },
  Task_97866_Desc = {
    Text = "Neues unter der Sonne·Reich"
  },
  Task_97867_Desc = {
    Text = "Abschluss “Perfekte Märchen“ Wahnsinn-Schwierigkeitsgrad"
  },
  Task_97868_Desc = {
    Text = "Abschluss “Poesie Garten“ beliebiger Schwierigkeitsgrad"
  },
  Task_97869_Desc = {
    Text = "Mit einem Überdimensionalen Grenzgebiet-Erwecker im “Neue Dinge unter Sonnenlicht“ einmal gewinnen"
  },
  Task_97870_Desc = {
    Text = "Abschluss von “Traum der Maschinen“ in beliebigem Modus"
  },
  Task_97871_Desc = {
    Text = "Abschluss von “Konfrontation mit der Dunkelheit“ im Wahnsinnsmodus"
  },
  Task_97872_Desc = {
    Text = "Abschluss von “Konfrontation mit der Dunkelheit“ in beliebigem Modus"
  },
  Task_97873_Desc = {
    Text = "Abschluss von “Perfekte Märchen“ in beliebiger Schwierigkeit"
  },
  Task_97874_Desc = {
    Text = "Mit einem Fleisch-Grenzgebiet-Erwecker im “Neues unter Sonnenlicht“ zweimal gewinnen"
  },
  Task_97875_Desc = {
    Text = "Logge dich an insgesamt 5 aufeinander folgenden Tagen ein"
  },
  Task_97876_Desc = {
    Text = "Abschluss “Wiederbesuch“ beliebiger Schwierigkeitsgrad"
  },
  Task_97877_Desc = {
    Text = "Logge dich insgesamt 7 Tage lang ein"
  },
  Task_97878_Desc = {
    Text = "Abschluss von “Mechanischer Traum“ im Wahnsinnsmodus"
  },
  Task_97879_Desc = {
    Text = "Abschluss von “Konfrontation mit der Dunkelheit“ in beliebigem Modus"
  },
  Task_97880_Desc = {
    Text = "Logge dich insgesamt 2 Tage lang ein"
  },
  Task_97881_Desc = {
    Text = "Abschluss von “Perfekte Märchen“ in beliebiger Schwierigkeit"
  },
  Task_97882_Desc = {
    Text = "Abschluss von “Traum der Maschinen“ in beliebigem Modus"
  },
  Task_97883_Desc = {
    Text = "Mit einem Chaos-Grenzgebiet-Erwecker im “Neue Dinge im Sonnenlicht“ einmal gewinnen"
  },
  Task_97884_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_97885_Desc = {
    Text = "Neuigkeiten im Sonnenlicht·Wahnsinn"
  },
  Task_97886_Desc = {
    Text = "7 Tage anmelden"
  },
  Task_97887_Desc = {
    Text = "Mit einem Überdimensionales Grenzgebiet-Erwecker im “Neue Dinge unter der Sonne“ 2-mal gewinnen"
  },
  Task_97888_Desc = {
    Text = "Abschluss “Wiedersehen an vertrauter Stätte“ beliebiger Schwierigkeitsgrad"
  },
  Task_97889_Desc = {
    Text = "Mit einem Tiefsee-Grenzgebiet-Erwecker im “Neuigkeiten unter Sonnenlicht“ 2-mal gewinnen"
  },
  Task_97890_Desc = {
    Text = "Abschluss “Poetischer Garten“ beliebiger Schwierigkeitsgrad"
  },
  Task_97952_Desc = {
    Text = "Insgesamt 100-mal geweckt"
  },
  Task_97953_Desc = {
    Text = "20 Aufträge abgeschlossen"
  },
  Task_97954_Desc = {
    Text = "Insgesamt 100-mal geweckt"
  },
  Task_97955_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_97956_Desc = {
    Text = "1 Mal Transzendente Existenz abschließen"
  },
  Task_97957_Desc = {
    Text = "3-mal tägliches Training abschließen"
  },
  Task_97958_Desc = {
    Text = "20 Aufträge abgeschlossen"
  },
  Task_97959_Desc = {
    Text = "Vollständig 20 Aufgaben"
  },
  Task_97960_Desc = {
    Text = "3-mal tägliches Training abschließen"
  },
  Task_97961_Desc = {
    Text = "Kumulative Ausgaben von 500 000 Goldene Rose"
  },
  Task_97962_Desc = {
    Text = "Vollständig 20 Aufgaben"
  },
  Task_97963_Desc = {
    Text = "2 Wochen lang wöchentliche Prüfungen abschließen"
  },
  Task_97964_Desc = {
    Text = "2 wöchentliche Prüfungen abschließen"
  },
  Task_97965_Desc = {
    Text = "Kumulative Ausgaben von 500.000 Goldene Rose"
  },
  Task_97966_Desc = {
    Text = "1 Mal Transzendente Existenz abschließen"
  },
  Task_97967_Desc = {
    Text = "Kumulative Anmeldung für 1 Tag"
  },
  Task_98151_Desc = {
    Text = "Vorübergehender Text · Zeitlich begrenzt exklusiv"
  },
  Task_98347_Desc = {
    Text = "Erziele 10 Siege in dieser Saiso"
  },
  Task_98347_Name = {Text = "10 Siege"},
  Task_98348_Desc = {
    Text = "Erziele insgesamt 3 Siege in dieser Saiso"
  },
  Task_98348_Name = {Text = "3 Siege"},
  Task_98349_Desc = {
    Text = "Erziele insgesamt 6 Siege in dieser Saiso"
  },
  Task_98349_Name = {Text = "6 Siege"},
  Task_98350_Desc = {
    Text = "Erziele 1 Sieg in dieser Saiso"
  },
  Task_98350_Name = {Text = "1 Sieg"},
  Task_98505_Desc = {
    Text = "Abschluss des Wanderns „Unvergänglicher Polartag““"
  },
  Task_98505_Name = {
    Text = "Tag des zerbrochenen Glücks"
  },
  Task_98700_Desc = {
    Text = "Logge dich insgesamt 15 Tage lang ein"
  },
  Task_98701_Desc = {
    Text = "Schließe alle wöchentlichen Prüfungsaufgaben für 2 Wochen ab"
  }
})
return Text_Task
