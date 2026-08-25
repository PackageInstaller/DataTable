__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TipsType = readonly({
  TipsType_100001_Desc = {
    Text = "Nach dem Wechsel der Auflösung muss der Client neu gestartet werden, bestätigen?"
  },
  TipsType_100001_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_100001_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_100001_Title = {
    Text = "Auflösungswechsel bestätigen"
  },
  TipsType_100002_Desc = {
    Text = "Warten auf {s1}, um eine Rematch-Einladung anzunehmen"
  },
  TipsType_100002_RightBtnDesc = {Text = "Abbrechen"},
  TipsType_100002_Title = {
    Text = "Noch eine Runde"
  },
  TipsType_100003_Desc = {
    Text = "{s1} lädt dich zu einem weiteren Spiel ein"
  },
  TipsType_100003_LeftBtnDesc = {Text = "Ablehnen"},
  TipsType_100003_RightBtnDesc = {
    Text = "Akzeptieren"
  },
  TipsType_100003_Title = {
    Text = "Noch eine Runde"
  },
  TipsType_100004_Desc = {
    Text = "Aktuelles Schlafsaal-Hintergrund"
  },
  TipsType_100005_Desc = {
    Text = "Traphase Spielmodus ist nicht freigeschaltet"
  },
  TipsType_100006_Desc = {
    Text = "Der Phasenkampf-Mechanismus ist beim Gegner nicht aktiviert"
  },
  TipsType_100007_Desc = {
    Text = "Nur durch gegenseitiges Folgen kann ein Freundschaftsspiel gestartet werden"
  },
  TipsType_100008_Desc = {
    Text = "Gegner ist offline"
  },
  TipsType_100009_Desc = {
    Text = "Gegner ist auf Erkundung"
  },
  TipsType_100010_Desc = {
    Text = "Freundschaftsspiel-Wartezeit abgelaufen"
  },
  TipsType_100011_Desc = {
    Text = "Du hast das Freundschaftsspiel abgesagt"
  },
  TipsType_100012_Desc = {
    Text = "Freundschaftsspiel-Einladung abgelehnt"
  },
  TipsType_100012_LeftBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_100012_Title = {Text = "Hinweis"},
  TipsType_100013_Desc = {
    Text = "Gegner ist offline"
  },
  TipsType_100014_Desc = {
    Text = "Gegner ist in einem anderen Modus"
  },
  TipsType_100015_Desc = {
    Text = "Einladungen zu häufig, in {s1} Sekunden erneut versuchen"
  },
  TipsType_100016_Desc = {
    Text = "Gegner hat Freundschaftsspiel abgebrochen"
  },
  TipsType_100016_LeftBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_100016_Title = {Text = "Hinweis"},
  TipsType_100017_Desc = {
    Text = "Dieser Spieler spielt gerade ein Freundschaftsspiel"
  },
  TipsType_100017_LeftBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_100017_Title = {Text = "Hinweis"},
  TipsType_100018_Desc = {
    Text = "Dieses Team enthält Karten mit zeitlich begrenzter Nutzung. Die Verwendung dieser Karten erfordert die Freischaltung der aktuellen Kernaufgabe. Ich freue mich darauf, wieder mit dir zu kämpfen!\nMöchtest du die Kernaufgabe freischalten?"
  },
  TipsType_100018_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_100018_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_100018_Title = {
    Text = "Kern-Thema ist abgelaufen"
  },
  TipsType_10001_Desc = {
    Text = "Operation erfolgreich"
  },
  TipsType_100020_Desc = {
    Text = "Der Kampf ist noch im Gange. Möchtest du den vorherigen Kampf fortsetzen?"
  },
  TipsType_100020_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_100020_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_100020_Title = {Text = "Hinweis"},
  TipsType_10002_Desc = {
    Text = "Konfigurationsfehler"
  },
  TipsType_10003_Desc = {
    Text = "Client-Datenfehler"
  },
  TipsType_10004_Desc = {
    Text = "Server nicht gestartet"
  },
  TipsType_10005_Desc = {
    Text = "Charakterdatenfehler"
  },
  TipsType_10006_Desc = {
    Text = "Keine Erwachensdaten gefunden"
  },
  TipsType_10007_Desc = {
    Text = "Erwachte hat das höchste Level erreicht"
  },
  TipsType_10008_Desc = {
    Text = "Nicht genügend Themeneinheiten"
  },
  TipsType_10009_Desc = {
    Text = "Wachkörper hat nicht das höchste Niveau erreicht und kann nicht erleuchtet werden"
  },
  TipsType_100100_Desc = {
    Text = "Eine neue Version ist verfügbar. Falls das Update nicht automatisch startet, versuche bitte, Steam neu zu starten, um nach Updates zu suchen."
  },
  TipsType_100100_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_100100_Title = {
    Text = "Update-Hinweis"
  },
  TipsType_10010_Desc = {
    Text = "Erfolgreich erleuchtet"
  },
  TipsType_10011_Desc = {
    Text = "Kein Charakter erstellt"
  },
  TipsType_10012_Desc = {
    Text = "Charakter bereits vorhanden"
  },
  TipsType_10013_Desc = {
    Text = "Charaktername doppelt"
  },
  TipsType_10014_Desc = {
    Text = "Fehler im Geheimnisbereich"
  },
  TipsType_10015_Desc = {
    Text = "Unmöglich, den Bereich des Bereichs zu lokalisieren"
  },
  TipsType_10016_Desc = {
    Text = "Aktuelle Ausdauer zu niedrig"
  },
  TipsType_10017_Desc = {
    Text = "{s1} bis {s2} freischaltbar"
  },
  TipsType_10018_Desc = {
    Text = "Nach dem einmaligen Erreichen der zweiten Schicht dieses Bereichs kann eine schnelle Untersuchung durchgeführt werden"
  },
  TipsType_10019_Desc = {
    Text = "Ereignis abgeschlossen"
  },
  TipsType_10020_Desc = {
    Text = "Ereignis Konfigurationstabelle Typfehler"
  },
  TipsType_10021_Desc = {
    Text = "Ereignis existiert nicht"
  },
  TipsType_10022_Desc = {
    Text = "Nicht genug schwarzer Stempel, um zu kaufen"
  },
  TipsType_10023_Desc = {
    Text = "Diese Karte kann nicht verstärkt werden"
  },
  TipsType_10024_Desc = {
    Text = "Diese Karte hat das Limit der Verstärkung erreicht"
  },
  TipsType_10025_Desc = {
    Text = "Der Händler verkauft diesen Artikel nicht"
  },
  TipsType_10026_Desc = {
    Text = "Keine Belohnung"
  },
  TipsType_10027_Desc = {
    Text = "Belohnung abgeholt"
  },
  TipsType_10028_Desc = {
    Text = "Ereignisdaten Fehler"
  },
  TipsType_10029_Desc = {
    Text = "Artikel gekauft"
  },
  TipsType_10030_Desc = {
    Text = "Nicht genug Energie für Portal, benötigt {s1} Energie"
  },
  TipsType_10031_Desc = {
    Text = "Keine Dialogereignisse gefunden"
  },
  TipsType_10032_Desc = {
    Text = "Ereignis Auswahlbefehlskartenanzahl unzureichend"
  },
  TipsType_10033_Desc = {
    Text = "Ereignis Auswahlbefehlskartenanzahl zu hoch"
  },
  TipsType_10034_Desc = {
    Text = "Ereignis Auswahlbefehlskarte existiert nicht"
  },
  TipsType_10035_Desc = {
    Text = "Ereignis Zufallspool keine Daten"
  },
  TipsType_10036_Desc = {
    Text = "Der Händler verkauft diesen Artikel nicht"
  },
  TipsType_10037_Desc = {
    Text = "Ereignis Auswahlobjektanzahl unzureichend"
  },
  TipsType_10038_Desc = {
    Text = "Ereignis Auswahlobjektanzahl zu hoch"
  },
  TipsType_10039_Desc = {
    Text = "Ereignis Auswahlobjekt existiert nicht"
  },
  TipsType_10040_Desc = {
    Text = "Kein Ereignisknoten gefunden"
  },
  TipsType_10041_Desc = {
    Text = "Die Anzahl der Händleraktualisierungen ist erschöpft"
  },
  TipsType_10042_Desc = {
    Text = "Kampfdrops Befehlskarten-Update-Limit erreicht"
  },
  TipsType_10043_Desc = {
    Text = "Kampfdrops Schöpfungs-Update-Limit erreicht"
  },
  TipsType_10044_Desc = {
    Text = "Funktion des Verbindungspunktes wurde gesperrt"
  },
  TipsType_10045_Desc = {
    Text = "Ereignisbereich stimmt nicht überein! Aktueller Bereich: {s1}, Ereigniskonfigurationsbereich: {s2}"
  },
  TipsType_10046_Desc = {
    Text = "Ereignis-Shop Kartenlöschungen aufgebraucht"
  },
  TipsType_10047_Desc = {
    Text = "Keine Aufgabendaten gefunden"
  },
  TipsType_10048_Desc = {
    Text = "Modul eingereicht, keine erneute Einreichung nötig"
  },
  TipsType_10049_Desc = {
    Text = "Themen im Modul noch nicht abgeschlossen, Einreichung nicht möglich"
  },
  TipsType_10050_Desc = {
    Text = "Kein Aufgabenmodul gefunden"
  },
  TipsType_10051_Desc = {
    Text = "Keine Level-Daten"
  },
  TipsType_10052_Desc = {
    Text = "Es gibt kein Thema, das zu diesem Bereich passt"
  },
  TipsType_10053_Desc = {
    Text = "Nicht genug Credits, keine Belohnung"
  },
  TipsType_10054_Desc = {
    Text = "Credits-Belohnung noch nicht abholbar"
  },
  TipsType_10055_Desc = {
    Text = "Teilaufgaben nicht gefunden"
  },
  TipsType_10056_Desc = {
    Text = "Teilaufgaben der Aufgabe abgeschlossen"
  },
  TipsType_10057_Desc = {
    Text = "Teilaufgaben der Aufgabe nicht abgeschlossen"
  },
  TipsType_10058_Desc = {
    Text = "NPC wurde ausgelöst"
  },
  TipsType_10059_Desc = {
    Text = "NPC-Datenfehler"
  },
  TipsType_10060_Desc = {
    Text = "NPC existiert nicht"
  },
  TipsType_10061_Desc = {
    Text = "Im Bereich nicht entdeckt"
  },
  TipsType_10062_Desc = {
    Text = "Keine Resonanzdaten gefunden"
  },
  TipsType_10063_Desc = {
    Text = "Maximales Resonanz-Level erreicht"
  },
  TipsType_10064_Desc = {
    Text = "Keine Resonanzstufendaten gefunden"
  },
  TipsType_10065_Desc = {
    Text = "Keine Neustarts"
  },
  TipsType_10066_Desc = {
    Text = "Resonanzaktivierungskriterien nicht erfüllt"
  },
  TipsType_10067_Desc = {
    Text = "Nicht genug Resonanz-Partikel"
  },
  TipsType_10068_Desc = {
    Text = "Erleuchten abgeschlossen, kann nicht erneut erleuchtet werden"
  },
  TipsType_10069_Desc = {
    Text = "Nicht genügend Materialien für das Erleuchten"
  },
  TipsType_10070_Desc = {
    Text = "Materialien für das Upgrade des erweckten Körpers unzureichend"
  },
  TipsType_10071_Desc = {
    Text = "Goldscheine für das Upgrade des erweckten Körpers unzureichend"
  },
  TipsType_10072_Desc = {
    Text = "Goldscheine für das Upgrade des erweckten Körpers unzureichend"
  },
  TipsType_10073_Desc = {
    Text = "Keine Erwecker-Fähigkeit"
  },
  TipsType_10074_Desc = {
    Text = "Noch keine Erwecker-Fähigkeit freigeschaltet"
  },
  TipsType_10075_Desc = {
    Text = "Nicht genug „Silber\" für Erweckung."
  },
  TipsType_10076_Desc = {
    Text = "Nicht genug Gegenstände"
  },
  TipsType_10077_Desc = {
    Text = "Heute wurde das Kauf-Limit erreicht"
  },
  TipsType_10078_Desc = {
    Text = "Gegenstand nicht nutzbar"
  },
  TipsType_10079_Desc = {
    Text = "Falsche Anzahl an Gegenständen verwendet"
  },
  TipsType_10080_Desc = {
    Text = "Fähigkeit hat maximale Stufe erreicht"
  },
  TipsType_10081_Desc = {
    Text = "Materialmangel, Upgrade nicht möglich"
  },
  TipsType_10082_Desc = {
    Text = "Nicht genug Währung, um aufzurüsten"
  },
  TipsType_10083_Desc = {
    Text = "Wachkörper Verbindungsrate hat das höchste Niveau erreicht"
  },
  TipsType_10084_Desc = {
    Text = "Dieser Erwachte hat nicht genug Seelenenergie"
  },
  TipsType_10085_Desc = {
    Text = "Upgrade-Pfad ohne Charakter-ID"
  },
  TipsType_10086_Desc = {
    Text = "Spezielle Karteninformationen nicht gefunden"
  },
  TipsType_10087_Desc = {
    Text = "Exklusive Karte nicht freigeschaltet"
  },
  TipsType_10088_Desc = {
    Text = "UUID der speziellen Karte nicht gefunden"
  },
  TipsType_10089_Desc = {
    Text = "Kapitelbelohnung nicht erreicht"
  },
  TipsType_10090_Desc = {
    Text = "Kapitelbelohnung erhalten"
  },
  TipsType_10091_Desc = {
    Text = "Gewählte Storyline nicht freigeschaltet"
  },
  TipsType_10092_Desc = {
    Text = "Gewählter Dungeon nicht freigeschaltet"
  },
  TipsType_10093_Desc = {
    Text = "Dungeon-Bereich noch nicht freigeschaltet"
  },
  TipsType_10094_Desc = {
    Text = "Handlungsstrang-Raid noch nicht freigeschaltet"
  },
  TipsType_10095_Desc = {
    Text = "Keine Handlungsstränge für Dungeon-Herausforderungen gefunden"
  },
  TipsType_10096_Desc = {
    Text = "Keine Handlungsstränge für Dungeon-Herausforderungen gefunden"
  },
  TipsType_10097_Desc = {
    Text = "Herausforderung abgeschlossen, Belohnung nicht erneut verfügbar"
  },
  TipsType_10098_Desc = {
    Text = "Herausforderung nicht abgeschlossen, Belohnung nicht verfügbar"
  },
  TipsType_10099_Desc = {
    Text = "Gebäude existiert nicht"
  },
  TipsType_10100_Desc = {
    Text = "Gebäude hat das maximale Level erreicht"
  },
  TipsType_10101_Desc = {
    Text = "Bedingungen für Upgrade/Bau unzureichend"
  },
  TipsType_10102_Desc = {
    Text = "Gebäude existiert bereits, kann nicht erneut gebaut werden"
  },
  TipsType_10103_Desc = {
    Text = "Nicht genügend Gegenstände für das Upgrade/Bau"
  },
  TipsType_10104_Desc = {
    Text = "Position bereits von einem Erwachten belegt, kann nicht betreten werden"
  },
  TipsType_10105_Desc = {
    Text = "Nicht genügend andere Objekte für die Synthese von Gegenständen"
  },
  TipsType_10106_Desc = {
    Text = "Nicht genügend Währung für die Synthese von Gegenständen"
  },
  TipsType_10107_Desc = {
    Text = "Synthesegegenstand nicht freigeschaltet"
  },
  TipsType_10108_Desc = {
    Text = "Verbindung zum Server fehlgeschlagen, bitte überprüfen Sie das Netzwerk und versuchen Sie es erneut"
  },
  TipsType_10109_Desc = {
    Text = "Lagerfunktion wurde gewählt, kann nicht erneut gewählt werden"
  },
  TipsType_10110_Desc = {
    Text = "Lagerfunktion hat keine Nutzungen mehr"
  },
  TipsType_10111_Desc = {
    Text = "Exklusive Karte nicht aufgewertet, Wechsel nicht möglich"
  },
  TipsType_10112_Desc = {
    Text = "Exklusive Karte unverändert, Wechsel nicht möglich"
  },
  TipsType_10113_Desc = {
    Text = "Exklusive Karte wechseln fehlgeschlagen"
  },
  TipsType_10114_Desc = {
    Text = "Erhalte Erweckungseinheit{s1}"
  },
  TipsType_10115_Desc = {
    Text = "Erneut {s1} erhalten, umgewandelt in {s2}{s3}"
  },
  TipsType_10116_Desc = {
    Text = "{s1} Token überschritten, umgewandelt in {s2}{s3}"
  },
  TipsType_10117_Desc = {
    Text = "Log erfolgreich hochgeladen"
  },
  TipsType_10118_Desc = {
    Text = "Befehl nicht übereinstimmend, wartet auf Befehl {s1}, eingegeben {s2}"
  },
  TipsType_10119_Desc = {
    Text = "Karte verloren:{s1}; uid:{s2}"
  },
  TipsType_10120_Desc = {
    Text = "Nicht freigeben"
  },
  TipsType_10121_Desc = {
    Text = "Keine Fähigkeit"
  },
  TipsType_10122_Desc = {
    Text = "Fähigkeit in Abklingzeit"
  },
  TipsType_10123_Desc = {
    Text = "Fähigkeitsanzahl erschöpft"
  },
  TipsType_10124_Desc = {
    Text = "Überprüfen Sie, ob die Upgrade-Reihenfolge des Gebäudes Tid {s1} zyklisch ist"
  },
  TipsType_10125_Desc = {
    Text = "Überprüfen Sie, ob das Gebäude Tid {s1} keine zugehörige Konfiguration hat"
  },
  TipsType_10126_Desc = {
    Text = "Das Gebäude Tid {s1} sollte das tatsächliche Level {s2} haben, konfiguriert ist es auf {s3}"
  },
  TipsType_10127_Desc = {
    Text = "Gebäudetyp-Konfiguration nicht gefunden"
  },
  TipsType_10128_Desc = {
    Text = "Gebäude-Konfiguration nicht gefunden oder kein Gebäudetyp"
  },
  TipsType_10129_Desc = {
    Text = "Diese Storyline-Aufgabe ist noch nicht verfügbar"
  },
  TipsType_10130_Desc = {
    Text = "Erfolgreich entfernt"
  },
  TipsType_10131_Desc = {
    Text = "Erfolg, „Menophin\" × {s1} erhalten."
  },
  TipsType_10132_Desc = {
    Text = "Reparatur abgeschlossen"
  },
  TipsType_10133_Desc = {
    Text = "GM fügte Gegenstand hinzu, entsprechend dem Gegenstandsnamen[\"..arg1..\"] wurde kein passender Gegenstand gefunden"
  },
  TipsType_10134_Desc = {
    Text = "Ereignis[\"..arg1..\"]existiert nicht"
  },
  TipsType_10135_Desc = {
    Text = "Aktuell: Drücke {s1}"
  },
  TipsType_10136_Desc = {
    Text = "Fähigkeitsaufstieg erfolgreich"
  },
  TipsType_10137_Desc = {
    Text = "Generierung erfolgreich"
  },
  TipsType_10138_Desc = {
    Text = "Serverzeit erfolgreich geändert"
  },
  TipsType_10139_Desc = {
    Text = "Serverzeit ändern fehlgeschlagen"
  },
  TipsType_10140_Desc = {
    Text = "Gesamtzahl der Gebäude: 17\nIn dieser temporären Version sind nur einige Gebäude verfügbar"
  },
  TipsType_10141_Desc = {
    Text = "Gebäudefreischaltkriterien nicht erfüllt"
  },
  TipsType_10142_Desc = {
    Text = "Gebäude:{s1} Konfigurationsoberfläche existiert nicht {s2}"
  },
  TipsType_10143_Desc = {
    Text = "Diese Syntheseformel ist noch nicht freigeschaltet"
  },
  TipsType_10144_Desc = {
    Text = "Materialmangel"
  },
  TipsType_10145_Desc = {
    Text = "Synthese erfolgreich"
  },
  TipsType_10146_Desc = {
    Text = "Upgrade erfolgreich"
  },
  TipsType_10147_Desc = {
    Text = "Das Monsterfeld ist leer, kein Kampf möglich"
  },
  TipsType_10148_Desc = {
    Text = "„Menophin\"-Wiederherstellung"
  },
  TipsType_10149_Desc = {
    Text = "Die eingegebene Charakter-ID ist doppelt, Kampf nicht möglich"
  },
  TipsType_10150_Desc = {
    Text = "Die eingegebene ID {s1} existiert nicht, Kampf nicht möglich"
  },
  TipsType_10151_Desc = {
    Text = "Das Monster hat keine entsprechende Aktion"
  },
  TipsType_10152_Desc = {
    Text = "Noch nicht verfügbar"
  },
  TipsType_10153_Desc = {
    Text = "Keine Karten im aktuellen Deck"
  },
  TipsType_10154_Desc = {
    Text = "Andere Karten aktiv, keine Spielzüge möglich"
  },
  TipsType_10155_Desc = {
    Text = "Nicht in der Hand, kann nicht gespielt werden"
  },
  TipsType_10156_Desc = {
    Text = "Diese Karte kann nicht gespielt werden"
  },
  TipsType_10157_Desc = {
    Text = "Diese Karte hat keine Fähigkeiten zugewiesen"
  },
  TipsType_10158_Desc = {
    Text = "Diese Karte kann nicht gespielt werden"
  },
  TipsType_10159_Desc = {
    Text = "Unzureichende Rechenleistung"
  },
  TipsType_10160_Desc = {
    Text = "Kein passender Erwachter auf dem Feld"
  },
  TipsType_10161_Desc = {
    Text = "Nicht genug verbleibende Versuche"
  },
  TipsType_10162_Desc = {
    Text = "Verwende Erkundungsfähigkeit"
  },
  TipsType_10163_Desc = {
    Text = "%d Befehlskarten ausgewählt"
  },
  TipsType_10164_Desc = {
    Text = "Maximale Anzahl erreicht"
  },
  TipsType_10165_Desc = {
    Text = "Nicht ausgewählt"
  },
  TipsType_10166_Desc = {
    Text = "Diese Karte kann nicht mit Arithmetica ausgespielt werden"
  },
  TipsType_10167_Desc = {
    Text = "Verbrauchssumme überschritten"
  },
  TipsType_10168_Desc = {
    Text = "{s1} Karten ausgewählt"
  },
  TipsType_10169_Desc = {
    Text = "Maximale Tentakelanzahl erreicht"
  },
  TipsType_10170_Desc = {
    Text = "Erfolgreich entfernt"
  },
  TipsType_10171_Desc = {
    Text = "Stärkung erfolgreich"
  },
  TipsType_10172_Desc = {
    Text = "Veränderung erfolgreich"
  },
  TipsType_10173_Desc = {
    Text = "Bereits in die Zwischenablage kopiert"
  },
  TipsType_10174_Desc = {
    Text = "Befehlskarte erfolgreich erhalten"
  },
  TipsType_10175_Desc = {
    Text = "Entfernungsversuche erschöpft"
  },
  TipsType_10176_Desc = {
    Text = "Stärkungen aufgebraucht"
  },
  TipsType_10177_Desc = {
    Text = "Veränderungsversuche erschöpft"
  },
  TipsType_10178_Desc = {
    Text = "Kopieranzahl erschöpft"
  },
  TipsType_10179_Desc = {
    Text = "Wähle Befehlskarten-Limit erreicht"
  },
  TipsType_10180_Desc = {
    Text = "Befehlskarte nicht ausgewählt"
  },
  TipsType_10181_Desc = {
    Text = "Shop noch nicht geöffnet, bitte warten"
  },
  TipsType_10182_Desc = {Text = "Demnächst"},
  TipsType_10183_Desc = {
    Text = "Aufgabenziel zu weit entfernt, keine Ortung möglich"
  },
  TipsType_10184_Desc = {
    Text = "Zielbereich verfehlt, nicht ausführbar"
  },
  TipsType_10185_Desc = {
    Text = "Dieses Thema noch nicht freigeschaltet"
  },
  TipsType_10186_Desc = {
    Text = "Erkunden Sie den Bereich, um mehr Ermittlungen freizuschalten"
  },
  TipsType_10187_Desc = {
    Text = "Abschluss der Voraufgabe, um mehr Untersuchungen freizuschalten"
  },
  TipsType_10188_Desc = {
    Text = "Erfolgreich eingereicht, Thema-Punkte +{s1}"
  },
  TipsType_10189_Desc = {
    Text = "Keine Aufgaben zum Einreichen"
  },
  TipsType_10190_Desc = {
    Text = "Noch nicht geöffnet, bitte auf die Öffnungszeiten des Dungeons achten"
  },
  TipsType_10191_Desc = {
    Text = "Freischaltbedingungen für diese Stufe noch nicht erfüllt"
  },
  TipsType_10192_Desc = {
    Text = "{s1} darf nicht leer sein"
  },
  TipsType_10193_Desc = {
    Text = "{s1} und {s2} dürfen nicht leer sein"
  },
  TipsType_10194_Desc = {
    Text = "Keine Aktualisierungen mehr möglich"
  },
  TipsType_10195_Desc = {
    Text = "Zugriff noch nicht freigeschaltet"
  },
  TipsType_10196_Desc = {
    Text = "Zugriff nicht während der Öffnungszeiten"
  },
  TipsType_10197_Desc = {
    Text = "Bitte wählen Sie die Schöpfung, die geändert werden soll"
  },
  TipsType_10198_Desc = {
    Text = "Erfolgreich entfernt"
  },
  TipsType_10199_Desc = {
    Text = "Entfernungsversuche erschöpft"
  },
  TipsType_10200_Desc = {
    Text = "Veränderungsversuche erschöpft"
  },
  TipsType_10201_Desc = {
    Text = "Bitte wählen Sie die Schöpfung, die entfernt werden soll"
  },
  TipsType_10202_Desc = {
    Text = "Menge erreicht das Limit"
  },
  TipsType_10203_Desc = {
    Text = "Bitte wählen Sie mindestens {s1} Schöpfungen"
  },
  TipsType_10204_Desc = {
    Text = "Keine Wechselmöglichkeiten mehr, Wechsel nicht möglich"
  },
  TipsType_10205_Desc = {
    Text = "Alle exklusiven Karten sind auf Maximalstufe"
  },
  TipsType_10206_Desc = {
    Text = "Ablehnungsgrad 0, kann nicht weiter gesenkt werden"
  },
  TipsType_10207_Desc = {
    Text = "Noch nicht verfügbar"
  },
  TipsType_10208_Desc = {
    Text = "Unzureichender Anker gegen den Wahnsinn, Verstärkung kann nicht durchgeführt werden"
  },
  TipsType_10209_Desc = {
    Text = "Erforderlich: {s1} erreicht Stufe {s2}, um das Erleuchten auszuführen"
  },
  TipsType_10210_Desc = {
    Text = "\"{s1}\" ist unzureichend"
  },
  TipsType_10211_Desc = {
    Text = "Noch nicht im Besitz von „{s1}\""
  },
  TipsType_10212_Desc = {
    Text = "Maximallevel erreicht"
  },
  TipsType_10213_Desc = {
    Text = "Bitte wähle zuerst das Material"
  },
  TipsType_10214_Desc = {
    Text = "\"{s1}\" ist unzureichend"
  },
  TipsType_10215_Desc = {
    Text = "Upgrade erfolgreich"
  },
  TipsType_10216_Desc = {
    Text = "Gnosis-Elixier wurde erhöht"
  },
  TipsType_10217_Desc = {
    Text = "Erleuchtungsobergrenze erreicht"
  },
  TipsType_10218_Desc = {
    Text = "Upgrade fehlgeschlagen"
  },
  TipsType_10219_Desc = {
    Text = "Nicht genügend Gegenstände, um aufzurüsten"
  },
  TipsType_10221_Desc = {
    Text = "Fähigkeitsaufstieg erfolgreich"
  },
  TipsType_10222_Desc = {
    Text = "Nicht genug schwarzer Stempel, um zu kaufen"
  },
  TipsType_10223_Desc = {
    Text = "Ausverkauft"
  },
  TipsType_10224_Desc = {
    Text = "Nicht genug schwarzer Stempel, um die Befehlskarte zu entfernen"
  },
  TipsType_10225_Desc = {
    Text = "Entferne {s1} Befehlskarten"
  },
  TipsType_10226_Desc = {
    Text = "Diese Richtung ist momentan nicht geöffnet und kann nicht verstärkt werden"
  },
  TipsType_10227_Desc = {
    Text = "In dieser Richtung wurde das Limit erreicht"
  },
  TipsType_10228_Desc = {
    Text = "Bitte wählt zunächst die Richtung, in die die spezielle Karte gestärkt werden soll"
  },
  TipsType_10229_Desc = {
    Text = "Unzureichender Anker gegen den Wahnsinn, Verstärkung kann nicht durchgeführt werden"
  },
  TipsType_10230_Desc = {
    Text = "Noch keine Erweckten in diesem Bereich, Auswahl nicht möglich"
  },
  TipsType_10231_Desc = {
    Text = "Ein Team erstellen"
  },
  TipsType_10232_Desc = {
    Text = "Teamname darf {s1} chinesische Zeichen nicht überschreiten"
  },
  TipsType_10233_Desc = {
    Text = "Teamname darf nicht leer sein"
  },
  TipsType_10234_Desc = {
    Text = "Erfolgreich eingetauscht"
  },
  TipsType_10235_Desc = {
    Text = "Kein „Silber\" mehr übrig"
  },
  TipsType_10236_Desc = {
    Text = "Nicht weiter reduzieren"
  },
  TipsType_10237_Desc = {
    Text = "{s1} ist noch nicht verfügbar, bitte warten"
  },
  TipsType_10238_Desc = {
    Text = "Beschwörung noch nicht verfügbar, bitte warten"
  },
  TipsType_10239_Desc = {
    Text = "Campus-Karte noch nicht verfügbar"
  },
  TipsType_10240_Desc = {
    Text = "Aufgabenlevel{s1} freigeschaltet"
  },
  TipsType_10241_Desc = {
    Text = "Keine passenden Karten"
  },
  TipsType_10242_Desc = {
    Text = "Alle Domänenkarten wurden aufgewertet"
  },
  TipsType_10243_Desc = {
    Text = "Keine Befehlskarte zum Aufrüsten"
  },
  TipsType_10244_Desc = {
    Text = "Neuer Teleportpunkt entdeckt! Kann zu {s1} reisen"
  },
  TipsType_10245_Desc = {
    Text = "Dieses Artefakt bereits erhalten, kann nicht erneut erhalten werden"
  },
  TipsType_10246_Desc = {
    Text = "Wiederherstellung erfolgreich"
  },
  TipsType_10247_Desc = {
    Text = "Erfolgreich entfernt"
  },
  TipsType_10248_Desc = {
    Text = "Rucksackmenü öffnen"
  },
  TipsType_10249_Desc = {
    Text = "Es wurde erkannt, dass Sie zuletzt abnormal offline waren, Ihr „Menophin\" und die Ihnen zustehenden Materialien wurden zurückgegeben. Sie können Ihren Rucksack öffnen, um nachzusehen."
  },
  TipsType_10250_Desc = {
    Text = "AVG-Version bietet nur einige Gebäude, hier sind es insgesamt 17"
  },
  TipsType_10251_Desc = {
    Text = "AVG-Version bietet nur einige Gebäude, hier sind es insgesamt 17"
  },
  TipsType_10252_Desc = {
    Text = "AVG-Version bietet nur einige Gebäude, hier sind es insgesamt 17"
  },
  TipsType_10253_Desc = {
    Text = "AVG-Version bietet nur einige Gebäude, hier sind es insgesamt 17"
  },
  TipsType_10254_Desc = {
    Text = "AVG-Version bietet nur einige Gebäude, hier sind es insgesamt 17"
  },
  TipsType_10255_Desc = {
    Text = "AVG-Version bietet nur einige Gebäude, hier sind es insgesamt 17"
  },
  TipsType_10256_Desc = {
    Text = "AVG-Version bietet nur einige Gebäude, hier sind es insgesamt 17"
  },
  TipsType_10257_Desc = {
    Text = "AVG-Version bietet nur einige Gebäude, hier sind es insgesamt 17"
  },
  TipsType_10258_Desc = {
    Text = "AVG-Version bietet nur einige Gebäude, hier sind es insgesamt 17"
  },
  TipsType_10259_Desc = {
    Text = "AVG-Version bietet nur einige Gebäude, hier sind es insgesamt 17"
  },
  TipsType_10260_Desc = {
    Text = "AVG-Version bietet nur einige Gebäude, hier sind es insgesamt 17"
  },
  TipsType_10261_Desc = {
    Text = "AVG-Version bietet nur einige Gebäude, hier sind es insgesamt 17"
  },
  TipsType_10262_Desc = {
    Text = "AVG-Version bietet nur einige Gebäude, hier sind es insgesamt 17"
  },
  TipsType_10263_Desc = {
    Text = "AVG-Version bietet nur einige Gebäude, hier sind es insgesamt 17"
  },
  TipsType_10264_Desc = {
    Text = "AVG-Version bietet nur einige Gebäude, hier sind es insgesamt 17"
  },
  TipsType_10265_Desc = {
    Text = "AVG-Version bietet nur einige Gebäude, hier sind es insgesamt 17"
  },
  TipsType_10266_Desc = {
    Text = "AVG-Version bietet nur einige Gebäude, hier sind es insgesamt 17"
  },
  TipsType_10267_Desc = {
    Text = "Bedingungen für die Nutzung nicht erfüllt"
  },
  TipsType_10268_Desc = {
    Text = "Schnellermittlung bei Stufe 2 freigeschaltet"
  },
  TipsType_10269_Desc = {
    Text = "Verbindung unterbrochen"
  },
  TipsType_10270_Desc = {
    Text = "Die Verbindung zum Server wurde unterbrochen, die Anmeldeseite wird später wieder angezeigt"
  },
  TipsType_10271_Desc = {
    Text = "Bestätigen"
  },
  TipsType_10272_Desc = {
    Text = "Server noch nicht verfügbar, bitte später erneut versuchen"
  },
  TipsType_10273_Desc = {
    Text = "Operation erfolgreich"
  },
  TipsType_10274_Desc = {
    Text = "Kein passender Bereich gefunden"
  },
  TipsType_10275_Desc = {
    Text = "Bereichsereignis abgeschlossen"
  },
  TipsType_10276_Desc = {
    Text = "Fehler bei der Eingabe des Bereichsereignistypus"
  },
  TipsType_10277_Desc = {
    Text = "Bereichsereignis existiert nicht"
  },
  TipsType_10278_Desc = {
    Text = "Nicht genug schwarzer Stempel, um zu kaufen"
  },
  TipsType_10279_Desc = {
    Text = "Diese Karte kann nicht verstärkt werden"
  },
  TipsType_10280_Desc = {
    Text = "Diese Karte hat das Limit der Verstärkung erreicht"
  },
  TipsType_10281_Desc = {
    Text = "Der Händler verkauft diesen Artikel nicht"
  },
  TipsType_10282_Desc = {
    Text = "Keine Belohnung"
  },
  TipsType_10283_Desc = {
    Text = "Belohnung abgeholt"
  },
  TipsType_10284_Desc = {
    Text = "Konfigurationsfehler"
  },
  TipsType_10285_Desc = {
    Text = "Ereignisdaten Fehler"
  },
  TipsType_10286_Desc = {
    Text = "Artikel gekauft"
  },
  TipsType_10287_Desc = {
    Text = "Keine Aufgabendaten gefunden"
  },
  TipsType_10288_Desc = {
    Text = "Modul eingereicht, keine erneute Einreichung nötig"
  },
  TipsType_10289_Desc = {
    Text = "Themen im Modul noch nicht abgeschlossen, Einreichung nicht möglich"
  },
  TipsType_10290_Desc = {
    Text = "Keine Module für die Aufgabe"
  },
  TipsType_10291_Desc = {
    Text = "Keine Level-Daten"
  },
  TipsType_10292_Desc = {
    Text = "Client-Datenfehler"
  },
  TipsType_10293_Desc = {
    Text = "Dienst nicht gestartet"
  },
  TipsType_10294_Desc = {
    Text = "Charakterdatenfehler"
  },
  TipsType_10295_Desc = {
    Text = "Keine Charaktere vorhanden, Erstellen erforderlich"
  },
  TipsType_10296_Desc = {
    Text = "Charakter existiert bereits, keine Neuerstellung nötig"
  },
  TipsType_10297_Desc = {
    Text = "Charaktername doppelt"
  },
  TipsType_10298_Desc = {
    Text = "Bereich Fehler"
  },
  TipsType_10299_Desc = {
    Text = "Diese Handlungslinie ist noch nicht freigeschaltet, kann nicht betreten werden"
  },
  TipsType_10300_Desc = {
    Text = "Hier kannst du die Geländeeffekte und Monsterinformationen einsehen"
  },
  TipsType_10301_Desc = {
    Text = "{s1} erreicht {s2} und schaltet {s3} frei"
  },
  TipsType_10302_Desc = {
    Text = "{s1} erreicht {s2} und schaltet {s3} frei"
  },
  TipsType_10303_Desc = {
    Text = "Gebäudefreischaltkriterien nicht erfüllt"
  },
  TipsType_10304_Desc = {
    Text = "Gebäude-Upgradekriterien nicht erfüllt"
  },
  TipsType_10305_Desc = {
    Text = "Nicht genug Baumaterialien für Gebäude-Upgrade"
  },
  TipsType_10306_Desc = {
    Text = "Aufgabenbelohnung verfügbar"
  },
  TipsType_10307_Desc = {
    Text = "（Leben wird um <Negative:10%%> reduziert）"
  },
  TipsType_10308_Desc = {
    Text = "Erhält am Rundenende Schild in Höhe der aktuellen Schutzstapel. Bei jedem erlittenen Schaden verringert sich der Schutz um <BuffTip:1> Schichten"
  },
  TipsType_10309_Desc = {
    Text = "Mehrfachschutz"
  },
  TipsType_10310_Desc = {
    Text = "Kondition unter Warnwert, Untersuchungsrisiko erhöht"
  },
  TipsType_10311_Desc = {
    Text = "Kondition unter Warnwert, Untersuchungsrisiko extrem hoch, willst du trotzdem fortfahren?"
  },
  TipsType_10312_Desc = {
    Text = "Die aktuelle Gesundheit ist zu niedrig, um in den Bereich einzutreten"
  },
  TipsType_10313_Desc = {
    Text = "Bitte wählen Sie eine exklusive Karte desselben Levels zum Wechseln"
  },
  TipsType_10314_Desc = {
    Text = "Wachkörper erleuchtet auf Stufe 2, dann wird diese Richtung freigeschaltet"
  },
  TipsType_10315_Desc = {
    Text = "Wachkörper erleuchtet auf Stufe 3, dann wird diese Richtung freigeschaltet"
  },
  TipsType_10316_Desc = {Text = "Aktuell"},
  TipsType_10317_Desc = {
    Text = "Alle Erwachten haben keine Fähigkeiten freigeschaltet, keine Aufladung möglich"
  },
  TipsType_10318_Desc = {
    Text = "Die Energie aller Erweckerfähigkeiten ist voll"
  },
  TipsType_10319_Desc = {
    Text = "Bereits verwendet"
  },
  TipsType_10320_Desc = {
    Text = "Nicht genug schwarzer Stempel"
  },
  TipsType_10321_Desc = {
    Text = "Nicht genug schwarzer Stempel"
  },
  TipsType_10322_Desc = {
    Text = "Nicht genug schwarzer Stempel"
  },
  TipsType_10323_Desc = {
    Text = "Keine doppelten Schöpfungen erhaltbar"
  },
  TipsType_10324_Desc = {
    Text = "Nicht genug Aktualisierungen"
  },
  TipsType_10325_Desc = {
    Text = "Wird uns {s1} Schaden zufügen"
  },
  TipsType_10326_Desc = {Text = "ANG"},
  TipsType_10327_Desc = {
    Text = "Hier wird eine Vorschau der Level-Karte angezeigt, damit die Spieler ihre Strategie im Voraus planen können"
  },
  TipsType_10328_Desc = {
    Text = "Du hast 10 Minuten gebraucht, um ein Level in dem täglichen Dungeon zu meistern, und hast dabei ein einzigartiges Spielerlebnis erhalten, welches dein Verständnis des Genres vertieft hat"
  },
  TipsType_10329_Desc = {
    Text = "Derzeit liegt die Lebensobergrenze unter 50% der maximalen Gesundheit, bitte achten Sie auf Ihre Sicherheit"
  },
  TipsType_10330_Desc = {
    Text = "Energie, die das Erwachen aufrechterhält. Schaden verringert das Leben, bei null Leben ist die Untersuchung gescheitert"
  },
  TipsType_10331_Desc = {
    Text = "Erwachte ANGsstärke. Je stärker die Kraft, desto mehr Schaden verursacht die Befehlskarte"
  },
  TipsType_10332_Desc = {
    Text = "Eine Demonstration der VERTsfähigkeiten des Wachkörpers. Je höher die Alarmstufe, desto mehr Schild erhält man bei der Nutzung der Befehlskarte"
  },
  TipsType_10333_Desc = {
    Text = "Klicke irgendwo, um fortzufahren"
  },
  TipsType_10334_Desc = {
    Text = "Aufgabenuntersuchung nicht abgeschlossen"
  },
  TipsType_10335_Desc = {
    Text = "Ermittlungsbewertung"
  },
  TipsType_10336_Desc = {
    Text = "Verleihe einer exklusiven Karte den Geist der Offenbarung"
  },
  TipsType_10337_Desc = {
    Text = "Wähle die Verstärkungsrichtung für die spezialisierte Karte"
  },
  TipsType_10338_Desc = {
    Text = "Die Hauptstadtkarte ist noch nicht verfügbar, bitte warten Sie"
  },
  TipsType_10339_Desc = {
    Text = "{s1}{s2} Wert"
  },
  TipsType_10340_Desc = {
    Text = "{s1} Basisdeck-Stufe erhöht"
  },
  TipsType_10341_Desc = {
    Text = "<Positive:Zuneigung:>"
  },
  TipsType_10342_Desc = {
    Text = "Zeigt die emotionale Bindung zu den Erwachten. Höhere Zuneigung ermöglicht tiefere Einblicke in die Erwachten"
  },
  TipsType_10343_Desc = {
    Text = "<Positive:Aktuelles Level:>{s1}"
  },
  TipsType_10344_Desc = {
    Text = "<Positive:Basis-Deck:>"
  },
  TipsType_10345_Desc = {
    Text = "Startdeck beim Betreten des Dungeons in diesem Gebiet"
  },
  TipsType_10346_Desc = {
    Text = "<Positive:Höchstes Deck-Level:>{s1} Level"
  },
  TipsType_10347_Desc = {
    Text = "<Positive:Deck-Level:>"
  },
  TipsType_10348_Desc = {
    Text = "Dieses Gebiet kann aufgerüstet werden, wenn eine bestimmte Anzahl Erwachter eine bestimmte Sympathiestufe erreicht"
  },
  TipsType_10349_Desc = {
    Text = "<Positive:Upgrade-Inhalt:>"
  },
  TipsType_10350_Desc = {
    Text = "Jedes Level-Up erhöht den Basiswert einer Befehlskarte"
  },
  TipsType_10351_Desc = {
    Text = "{s1} Zuneigung erhöht"
  },
  TipsType_10352_Desc = {
    Text = "Im Schweigen des Bereichs"
  },
  TipsType_10353_Desc = {
    Text = "Der Bereich stößt Eindringlinge zurück"
  },
  TipsType_10354_Desc = {
    Text = "Der Bereichsabwehrwert nimmt zu"
  },
  TipsType_10355_Desc = {
    Text = "Ablehnungsgrad erreicht {s1}, der Geheimgang beobachtet dich"
  },
  TipsType_10356_Desc = {
    Text = "Erleuchten 1"
  },
  TipsType_10357_Desc = {
    Text = "Fähigkeit verstehen"
  },
  TipsType_10358_Desc = {
    Text = "Maximale Anzahl gleichzeitig existierender Tentakel"
  },
  TipsType_10359_Desc = {
    Text = "Die Stärke des Tentakelangriffs. Je stärker die Tentakelkraft, desto höher der Schaden, der beim Auslösen der Tentakel dem Feind zugefügt wird."
  },
  TipsType_10360_Desc = {
    Text = "Befehlskarte nicht ausgewählt"
  },
  TipsType_10361_Desc = {
    Text = "Veränderung erfolgreich"
  },
  TipsType_10362_Desc = {
    Text = "Befehlskarte nicht ausgewählt"
  },
  TipsType_10363_Desc = {
    Text = "Kopieren erfolgreich"
  },
  TipsType_10364_Desc = {
    Text = "{s1} Befehlskarten ausgewählt"
  },
  TipsType_10365_Desc = {
    Text = "Befehlskarte nicht ausgewählt"
  },
  TipsType_10366_Desc = {
    Text = "Befehlskarte nicht ausgewählt"
  },
  TipsType_10367_Desc = {
    Text = "Upgrade erfolgreich"
  },
  TipsType_10368_Desc = {
    Text = "Schöpfungsrucksack-Interface in Entwicklung, bitte warten"
  },
  TipsType_10369_Desc = {
    Text = "Bitte wählen Sie die Schöpfung, die geändert werden soll"
  },
  TipsType_10370_Desc = {
    Text = "Version aktualisieren, bitte das Installationspaket neu herunterladen"
  },
  TipsType_10371_Desc = {
    Text = "Fortschrittseffekt"
  },
  TipsType_10372_Desc = {
    Text = "Bereichsinformationen"
  },
  TipsType_10373_Desc = {
    Text = "Jede gespielte Schadenskarte lässt die Tentakel zufälligen Feinden {s1} Schaden zufügen"
  },
  TipsType_10374_Desc = {
    Text = "Keine offenen Themen"
  },
  TipsType_10375_Desc = {
    Text = "Keine archivierten Themen"
  },
  TipsType_10376_Desc = {
    Text = "Diese Untersuchung hat das Thema nicht abgeschlossen"
  },
  TipsType_10377_Desc = {
    Text = "Kein Rückschritt möglich"
  },
  TipsType_10378_Desc = {
    Text = "(Die folgenden Themen wurden automatisch archiviert)"
  },
  TipsType_10379_Desc = {
    Text = "Zielaufgabe abgeschlossen"
  },
  TipsType_10380_Desc = {
    Text = "Sie haben diesen Gegenstand nicht"
  },
  TipsType_10381_Desc = {
    Text = "Falscher Indexwert"
  },
  TipsType_10382_Desc = {
    Text = "Nicht freigeschaltet"
  },
  TipsType_10383_Desc = {
    Text = "Exklusive Karte aufgewertet, keine Versuche mehr"
  },
  TipsType_10384_Desc = {
    Text = "1 Artefakt-Slot freigeschaltet!"
  },
  TipsType_10385_Desc = {
    Text = "Verbindungsrate erhöht"
  },
  TipsType_10386_Desc = {
    Text = "Keine Slot-Informationen"
  },
  TipsType_10387_Desc = {
    Text = "Nicht genug Währung"
  },
  TipsType_10388_Desc = {
    Text = "Maximales Level erreicht"
  },
  TipsType_10389_Desc = {
    Text = "In Entwicklung, bitte warten"
  },
  TipsType_10390_Desc = {
    Text = "Keine manuellen Upgrade-Slots mehr"
  },
  TipsType_10391_Desc = {
    Text = "Nach dem Entsiegeln im Laden oder Lager nutzbar"
  },
  TipsType_10392_Desc = {
    Text = "In diesem Kampf {s1} Ausdauer abgezogen"
  },
  TipsType_10393_Desc = {
    Text = "Erwachte Energie voll, kann nicht weiter erhöht werden"
  },
  TipsType_10394_Desc = {
    Text = "Energie aller Erwachten vollständig erhöht"
  },
  TipsType_10395_Desc = {
    Text = "Erfordert „Auge“ zum Entsperren"
  },
  TipsType_10396_Desc = {
    Text = "Erfolgreich geprägt"
  },
  TipsType_10397_Desc = {
    Text = "Bereits aufgestellt {s1} Erwachte, das Team wird die {s2} Domänen-Eigenschaft tragen"
  },
  TipsType_10398_Desc = {
    Text = "Das Team wird neutral und trägt keine Bereichseigenschaften"
  },
  TipsType_10399_Desc = {
    Text = "Das Mikrozirkulationssystem wird im Kapitel 4 freigeschaltet"
  },
  TipsType_10400_Desc = {
    Text = "Maximal {s1} Schöpfungen übernehmen, bitte Anzahl der ausgewählten Schöpfungen reduzieren"
  },
  TipsType_10401_Desc = {
    Text = "Nicht ausgewählte Schöpfungen können nicht vererbt werden"
  },
  TipsType_10405_Desc = {
    Text = "Erhalte {s1}"
  },
  TipsType_10406_Desc = {
    Text = "Maximale Anzahl der Weckkörper im Einsatz erreicht"
  },
  TipsType_10407_Desc = {
    Text = "Dieser Goldturm ist nicht herausforderbar"
  },
  TipsType_10408_Desc = {
    Text = "Dieser Goldturm ist nicht freigeschaltet- bitte schließe das angegebene Dungeon ab"
  },
  TipsType_10409_Desc = {
    Text = "Bitte wählen Sie den Erweckten für den Einsatz"
  },
  TipsType_10410_Desc = {
    Text = "Wachkörper arbeitet fleißig an seiner Aufgabenerfüllung, komm später zurück, um ihn abzuholen"
  },
  TipsType_10411_Desc = {
    Text = "{s1} Goldene Rose erhalten"
  },
  TipsType_10412_Desc = {
    Text = "Zeitbelohnung muss sich mit der Zeit ansammeln"
  },
  TipsType_10413_Desc = {
    Text = "„Silber\" unzureichend"
  },
  TipsType_10414_Desc = {
    Text = "Keine Herausforderungen"
  },
  TipsType_10415_Desc = {
    Text = "Herausforderung in Abkühlung"
  },
  TipsType_10416_Desc = {
    Text = "Keine Herausforderer"
  },
  TipsType_10417_Desc = {
    Text = "Bitte wählen Sie den Erweckten für den Einsatz"
  },
  TipsType_10418_Desc = {
    Text = "Zu wenig Gnosis-Elixier, um das Level weiter zu steigern"
  },
  TipsType_10419_Desc = {
    Text = "Maximales Level erreicht"
  },
  TipsType_10420_Desc = {
    Text = "Erwachte noch nicht freigeschaltet"
  },
  TipsType_10421_Desc = {
    Text = "Sammlung erfolgreich aufgehoben"
  },
  TipsType_10422_Desc = {
    Text = "Nicht genug Käufe für Handlungsstrang-Herausforderung"
  },
  TipsType_10423_Desc = {
    Text = "Nicht genug Sterne im Handlungsstrang, um zu raiden"
  },
  TipsType_10424_Desc = {
    Text = "Fehler bei der Teamzusammenstellung für die Untersuchung"
  },
  TipsType_10425_Desc = {
    Text = "„Silber\" unzureichend"
  },
  TipsType_10426_Desc = {
    Text = "Heute wurde das Kauf-Limit für Belege erreicht"
  },
  TipsType_10427_Desc = {
    Text = "Nach dem Durchspielen des geheimen Welt wird freigeschaltet"
  },
  TipsType_10428_Desc = {
    Text = "Erfolgreich {s1} Zertifikate erhalten"
  },
  TipsType_10429_Desc = {
    Text = "Erfolgreich {s1} Herausforderungsversuche erhalten"
  },
  TipsType_10430_Desc = {
    Text = "Abschluss Untersuchung 4-6 freigeschaltet"
  },
  TipsType_10431_Desc = {
    Text = "Unzureichende Beweise"
  },
  TipsType_10432_Desc = {
    Text = "Unzureichende Kaufanzahl"
  },
  TipsType_10433_Desc = {
    Text = "Erleuchten Level hat das Limit erreicht"
  },
  TipsType_10434_Desc = {
    Text = "\"{s1}\" ist unzureichend"
  },
  TipsType_10435_Desc = {
    Text = "Kein Verkauf dieses Artikels"
  },
  TipsType_10436_Desc = {
    Text = "Kein Geschäftstyp"
  },
  TipsType_10437_Desc = {
    Text = "Das verkaufte Produkt ist nicht mehr auf Lager"
  },
  TipsType_10438_Desc = {
    Text = "Keine Geschäftsdaten"
  },
  TipsType_10439_Desc = {
    Text = "Keine Erfrischungen"
  },
  TipsType_10440_Desc = {
    Text = "Die heutige Kaufgrenze für „Menophin\" wurde erreicht."
  },
  TipsType_10441_Desc = {
    Text = "Nicht genug Erwachte Fragmente"
  },
  TipsType_10442_Desc = {
    Text = "Erleuchten-Punkte aktiviert"
  },
  TipsType_10443_Desc = {
    Text = "Der vorgeplante Erleuchtungspunkt ist nicht aktiviert"
  },
  TipsType_10444_Desc = {
    Text = "Erfolg, „Menophin\" × {s1} gekauft."
  },
  TipsType_10445_Desc = {
    Text = "Menophin hat das Maximum erreicht"
  },
  TipsType_10446_Desc = {
    Text = "Freigeschaltet nach Abschluss von Untersuchung 1-12"
  },
  TipsType_10447_Desc = {
    Text = "Freigeschaltet nach Abschluss von Prolog"
  },
  TipsType_10448_Desc = {
    Text = "Freigeschaltet nach Abschluss von Prolog"
  },
  TipsType_10449_Desc = {
    Text = "Freigeschaltet nach Abschluss von Untersuchung 2-4"
  },
  TipsType_10450_Desc = {
    Text = "Diese Fertigkeitsstufe ist am Limit"
  },
  TipsType_10451_Desc = {
    Text = "Wachaufkörpergrad nicht ausreichend"
  },
  TipsType_10452_Desc = {
    Text = "Fähigkeitsaufstiegsmaterialien unzureichend"
  },
  TipsType_10453_Desc = {
    Text = "Freigeschaltet nach Abschluss von Untersuchung 3-15"
  },
  TipsType_10454_Desc = {
    Text = "Freigeschaltet nach Abschluss von Untersuchung 3-7"
  },
  TipsType_10455_Desc = {
    Text = "Fähigkeitsaufstieg nicht erreicht"
  },
  TipsType_10456_Desc = {
    Text = "In der Testversion ist jede Aufladung nur einmal möglich"
  },
  TipsType_10457_Desc = {
    Text = "Die Ursprungsherabkunft dieses Erweckers ist im Cooldown, lasse es in der nächsten Runde los"
  },
  TipsType_10458_Desc = {
    Text = "Keine solche Konfiguration in der Aufladetabelle"
  },
  TipsType_10459_Desc = {
    Text = "Bereits kostenlos aufgeladen, kann nicht erneut aufgeladen werden"
  },
  TipsType_10460_Desc = {
    Text = "Resonanz aktiviert, keine erneute Aktivierung erforderlich"
  },
  TipsType_10461_Desc = {
    Text = "Der Preis von Gegenstand{s1} hat sich geändert, bitte überprüfen"
  },
  TipsType_10462_Desc = {
    Text = "Unzureichende goldene Rose"
  },
  TipsType_10463_Desc = {
    Text = "Nicht genügend Übungsabzeichen"
  },
  TipsType_10464_Desc = {
    Text = "Abschluss Untersuchung 3-4 freigeschaltet"
  },
  TipsType_10465_Desc = {
    Text = "Abschluss Untersuchung 2-16 freigeschaltet"
  },
  TipsType_10466_Desc = {
    Text = "Abschluss Untersuchung 3-16 freigeschaltet"
  },
  TipsType_10467_Desc = {
    Text = "Abschluss Untersuchung 4-12 freigeschaltet"
  },
  TipsType_10468_Desc = {
    Text = "Abschluss Untersuchung 5-12 freigeschaltet"
  },
  TipsType_10469_Desc = {
    Text = "Abschluss Untersuchung 6-12 freigeschaltet"
  },
  TipsType_10470_Desc = {
    Text = "Abschluss Untersuchung 1-7 freigeschaltet"
  },
  TipsType_10471_Desc = {
    Text = "Ausrüstung erfolgreich"
  },
  TipsType_10472_Desc = {
    Text = "Erfolgreich abgenommen"
  },
  TipsType_10473_Desc = {
    Text = "Maximallevel erreicht"
  },
  TipsType_10474_Desc = {
    Text = "Unzureichende goldene Rose"
  },
  TipsType_10475_Desc = {
    Text = "Bitte wählen Sie Materialien"
  },
  TipsType_10476_Desc = {
    Text = "Wird gesperrt geschützt, bitte zuerst entsperren"
  },
  TipsType_10477_Desc = {
    Text = "Level nicht verfügbar"
  },
  TipsType_10478_Desc = {
    Text = "Außerhalb des Kampfes nicht verfügbar"
  },
  TipsType_10479_Desc = {
    Text = "Ablagestapel ist leer"
  },
  TipsType_10480_Desc = {
    Text = "RPG-Kampfanpassung, derzeit direkter Sieg"
  },
  TipsType_10482_Desc = {
    Text = "Schicksalsrad gesperrt"
  },
  TipsType_10483_Desc = {
    Text = "Schicksalsrad nicht gefunden"
  },
  TipsType_10484_Desc = {
    Text = "Schicksalsrad hat das maximale Level erreicht"
  },
  TipsType_10485_Desc = {
    Text = "Schicksalsrad ausgerüstet"
  },
  TipsType_10486_Desc = {
    Text = "Schicksalsrad nicht passend"
  },
  TipsType_10487_Desc = {
    Text = "Schicksalsrad nicht gesperrt"
  },
  TipsType_10488_Desc = {
    Text = "Befindet sich in der „Teamaufstellung“, „Unterstützung“, „Bündniskonzept“, das Bündnis darf nicht aufgelöst werden"
  },
  TipsType_10489_Desc = {
    Text = "Der Rad des Schicksals, das sich in der „Teamaufstellung“ und „Hilfe“ befindet, kann nicht zerlegt werden"
  },
  TipsType_10490_Desc = {
    Text = "Wahnsinnswert unzureichend, Wahnsinnsexplosion kann nicht ausgelöst werden"
  },
  TipsType_10491_Desc = {
    Text = "Bitte hole zuerst das vorherige Paket"
  },
  TipsType_10492_Desc = {
    Text = "Der aktuelle Bund ist gesperrt, Entsperren, um als Material verbraucht zu werden"
  },
  TipsType_10493_Desc = {
    Text = "Das aktuelle Schicksalsrad ist gesperrt, entsperren um als Materialverbrauch zu dienen"
  },
  TipsType_10494_Desc = {
    Text = "Abschluss Untersuchung 1-7 freigeschaltet"
  },
  TipsType_10495_Desc = {
    Text = "Abschluss Untersuchung 1-13 freigeschaltet"
  },
  TipsType_10496_Desc = {
    Text = "Der aktuelleBundeslevel hat das Maximum erreicht"
  },
  TipsType_10497_Desc = {
    Text = "Laden zurückgesetzt"
  },
  TipsType_10498_Desc = {
    Text = "Erfolgreich gewechselt"
  },
  TipsType_10499_Desc = {
    Text = "Erfolgreich gesammelt"
  },
  TipsType_10500_Desc = {
    Text = "Stapel erfolgreich"
  },
  TipsType_10501_Desc = {
    Text = "Herausforderung nicht freigeschaltet"
  },
  TipsType_10502_Desc = {
    Text = "Aktueller Erwachter hat bereits in einer anderen Stufe von {s1} gekämpft, kann nicht erneut eingesetzt werden"
  },
  TipsType_10503_Desc = {
    Text = "Weniger als 4 Weckkörper im Einsatz, Herausforderung nicht möglich"
  },
  TipsType_10504_Desc = {
    Text = "Abschluss Untersuchung 3-7 freigeschaltet"
  },
  TipsType_10505_Desc = {
    Text = "Stufe 1 mit drei Sternen freischalten"
  },
  TipsType_10506_Desc = {
    Text = "Stufe 2 mit drei Sternen freischalten"
  },
  TipsType_10507_Desc = {
    Text = "Stufe 3 mit drei Sternen freischalten"
  },
  TipsType_10508_Desc = {
    Text = "Stufe 4 mit drei Sternen freischalten"
  },
  TipsType_10509_Desc = {
    Text = "Stufe 5 mit drei Sternen freischalten"
  },
  TipsType_10510_Desc = {
    Text = "Stufe 6 mit drei Sternen freischalten"
  },
  TipsType_10511_Desc = {
    Text = "Stufe 7 mit drei Sternen freischalten"
  },
  TipsType_10512_Desc = {
    Text = "Stufe 8 mit drei Sternen freischalten"
  },
  TipsType_10513_Desc = {
    Text = "Bitte wähle das Bündnis, das du stärken möchtest"
  },
  TipsType_10514_Desc = {Text = "Abgeholt"},
  TipsType_10515_Desc = {
    Text = "Abschluss Untersuchung 2-14 freigeschaltet"
  },
  TipsType_10516_Desc = {
    Text = "Abschluss Untersuchung 4-7 freigeschaltet"
  },
  TipsType_10517_Desc = {
    Text = "Abschluss Untersuchung 4-7 freigeschaltet"
  },
  TipsType_10518_Desc = {
    Text = "Teamaufstellung gespeichert"
  },
  TipsType_10519_Desc = {
    Text = "Berühren Sie den leuchtenden Bereich, um sich zu bewegen"
  },
  TipsType_10520_Desc = {
    Text = "Teamname darf nur chinesische, englische Zeichen oder Zahlen enthalten"
  },
  TipsType_10521_Desc = {
    Text = "Teamname darf nicht länger als 8 Zeichen sein"
  },
  TipsType_10522_Desc = {
    Text = "Zu wenig erwachte Einheiten im Team, mindestens {s1} erforderlich für Untersuchung"
  },
  TipsType_10523_Desc = {
    Text = "Erwecker haben bereits an Kämpfen in anderen Bereichen dieses Levels des Lichtlosen Reiches teilgenommen."
  },
  TipsType_10524_Desc = {
    Text = "Im Team befinden sich bereits Erwachte von zwei Grenzgebieten, daher können keine weiteren Erwachten anderer Grenzgebiete ausgewählt werden."
  },
  TipsType_10525_Desc = {
    Text = "Bitte wählen Sie einen Erweckten"
  },
  TipsType_10526_Desc = {
    Text = "Keine weiteren Erwachten wählbar"
  },
  TipsType_10527_Desc = {
    Text = "Achtung aufgepasst: In phantasmalen Sturzflügen, werden die Erwecker-Stufen und Fähigkeitsstufen auf Stufe 1 gesetzt"
  },
  TipsType_10528_Desc = {
    Text = "Teamname darf nicht leer sein"
  },
  TipsType_10529_Desc = {
    Text = "Erschöpfte erwachte Einheiten im Team, Kampf nicht möglich"
  },
  TipsType_10530_Desc = {
    Text = "Alle Anhänge im Postfach wurden abgeholt"
  },
  TipsType_10531_Desc = {
    Text = "Freischaltung nach Abschluss des Prologs"
  },
  TipsType_10532_Desc = {
    Text = "Rucksack voll, nicht alles abgeholt, Rucksack leeren und weiter abholen"
  },
  TipsType_10533_Desc = {
    Text = "Rucksack voll, Belohnung wird per Post gesendet"
  },
  TipsType_10534_Desc = {
    Text = "Der Rucksack ist voll, die Vorräte wurden nicht vollständig abgeholt und müssen nach der Rucksackreinigung fortgesetzt werden"
  },
  TipsType_10535_Desc = {
    Text = "Keine Anhänge zum Abholen"
  },
  TipsType_10536_Desc = {
    Text = "Bitte tausche zuerst Schöpfungen"
  },
  TipsType_10537_Desc = {
    Text = "Freigeschaltet nach Abschluss von Untersuchung 2-4"
  },
  TipsType_10538_Desc = {
    Text = "Freigeschaltet nach Abschluss von Untersuchung 1-12"
  },
  TipsType_10539_Desc = {
    Text = "Freigeschaltet nach Abschluss von Untersuchung 1-12"
  },
  TipsType_10540_Desc = {
    Text = "Freigeschaltet nach Abschluss von Untersuchung 1-12"
  },
  TipsType_10541_Desc = {
    Text = "Stufe 9 mit drei Sternen freischalten"
  },
  TipsType_10542_Desc = {
    Text = "Stufe 10 mit drei Sternen freischalten"
  },
  TipsType_10543_Desc = {
    Text = "Stufe 11 mit drei Sternen freischalten"
  },
  TipsType_10544_Desc = {
    Text = "Stufe 12 mit drei Sternen freischalten"
  },
  TipsType_10545_Desc = {
    Text = "Stufe 13 mit drei Sternen freischalten"
  },
  TipsType_10546_Desc = {
    Text = "Stufe 14 mit drei Sternen freischalten"
  },
  TipsType_10547_Desc = {
    Text = "Diese Funktion wird bald entfernt"
  },
  TipsType_10548_Desc = {
    Text = "Freigeschaltet nach Abschluss von Untersuchung 1-7"
  },
  TipsType_10549_Desc = {
    Text = "Schöpfungslimit erreicht, keine weiteren Schöpfungen möglich"
  },
  TipsType_10550_Desc = {
    Text = "{s1} Link abgeschlossen, du kannst sie jetzt befehligen!"
  },
  TipsType_10551_Desc = {
    Text = "{s1}s Level und Skill-Level übersteigen das von Gnosis-Verstärker bereitgestellte Level und kann nicht verwendet werden"
  },
  TipsType_10552_Desc = {
    Text = "Wachkörperniveau und Fähigkeitslevel haben die von Gnosis-Verstärkern bereitgestellten Stufen überschritten, daher nicht nutzbar"
  },
  TipsType_10553_Desc = {Text = "Demnächst"},
  TipsType_10554_Desc = {
    Text = "Nach Abschluss des vorherigen Levels freigeschaltet"
  },
  TipsType_10555_Desc = {
    Text = "Der zerbrechliche Pfad ist nicht umkehrbar"
  },
  TipsType_10556_Desc = {
    Text = "Noch nicht verfügbar, bitte warten"
  },
  TipsType_10557_Desc = {
    Text = "Artefakt bereits vorhanden, kann nicht erneut erhalten werden"
  },
  TipsType_10558_Desc = {
    Text = "Wird den Inhalt der System-Zwischenablage erhalten und <Positive:[einfügen]>.\nBestätigen?"
  },
  TipsType_10558_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_10558_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10558_Title = {
    Text = "Einfügen aktivieren"
  },
  TipsType_10559_Desc = {
    Text = "Bilden Material nicht ausreichend"
  },
  TipsType_10560_Desc = {
    Text = "Bereits im Ausgangszustand"
  },
  TipsType_10561_Desc = {
    Text = "Unzureichende goldene Rose"
  },
  TipsType_10562_Desc = {
    Text = "Nicht aufgewertet"
  },
  TipsType_10563_Desc = {
    Text = "Resonanz erfolgreich zurückgesetzt"
  },
  TipsType_10564_Desc = {
    Text = "Ermittlungsstufe {s1} erreicht, freigeschaltet"
  },
  TipsType_10565_Desc = {
    Text = "Versiegelter Wahnsinn kann nicht freigesetzt werden"
  },
  TipsType_1056601_Desc = {
    Text = "SilberkernKommunikation fehlerhaft, bitte Netzwerk überprüfen und erneut versuchen ({s1})"
  },
  TipsType_10566_Desc = {
    Text = "SilberkernKommunikation fehlerhaft, bitte später erneut versuchen ({s1})"
  },
  TipsType_10567_Desc = {
    Text = "Fehler beim Abrufen der Serverinformationen! {s1}"
  },
  TipsType_10568_Desc = {
    Text = "Bitte wähle zuerst den Server"
  },
  TipsType_10569_Desc = {
    Text = "Nicht freigeschaltet"
  },
  TipsType_10570_Desc = {
    Text = "Bitte geben Sie Ihr Konto ein"
  },
  TipsType_10571_Desc = {
    Text = "Nicht genug Resonanz-Aktivierungsmaterial"
  },
  TipsType_10572_Desc = {
    Text = "Vorheriger Resonanzpunkt nicht aktualisiert"
  },
  TipsType_10573_Desc = {
    Text = "Maximallevel erreicht"
  },
  TipsType_10574_Desc = {
    Text = "Upgrade erfolgreich"
  },
  TipsType_10575_Desc = {
    Text = "Dieser Erwachte kann nicht gewechselt werden"
  },
  TipsType_10576_Desc = {
    Text = "Dieser Platz ist nicht verfügbar"
  },
  TipsType_10577_Desc = {
    Text = "Nicht genug Erwachte, Herausforderung nicht möglich"
  },
  TipsType_10578_Desc = {
    Text = "Nächste Stufe noch nicht freigeschaltet"
  },
  TipsType_10579_Desc = {
    Text = "Letztes Level erreicht"
  },
  TipsType_10580_Desc = {
    Text = "Aktuelles Erfahrungsmaximum erreicht, kann nicht hinzugefügt werden"
  },
  TipsType_10581_Desc = {
    Text = "Schicksalsrad-Slot voll, kann nicht hinzugefügt werden"
  },
  TipsType_10582_Desc = {
    Text = "Keine Materialien zum schnellen Einfügen"
  },
  TipsType_10583_Desc = {
    Text = "Bitte legen Sie das Material in den Schicksalskreis"
  },
  TipsType_10584_Desc = {
    Text = "Kein Schicksalsrad zum Ausrüsten"
  },
  TipsType_10585_Desc = {
    Text = "Freigeschaltet nach Abschluss von Untersuchung 2-8"
  },
  TipsType_10586_Desc = {
    Text = "Freigeschaltet nach Abschluss von Untersuchung 2-14"
  },
  TipsType_10587_Desc = {
    Text = "Freigeschaltet nach Abschluss von Untersuchung 3-16"
  },
  TipsType_10588_Desc = {
    Text = "Freigeschaltet nach Abschluss von Untersuchung 4-12"
  },
  TipsType_10589_Desc = {
    Text = "Freigeschaltet nach Abschluss von Untersuchung 5-12"
  },
  TipsType_10590_Desc = {
    Text = "Freigeschaltet nach Abschluss von Untersuchung 6-12"
  },
  TipsType_10591_Desc = {
    Text = "Freigeschaltet nach Abschluss von Untersuchung 2-12"
  },
  TipsType_10592_Desc = {
    Text = "Dieser Benutzer wurde gesperrt, bei Fragen bitte den Kundendienst kontaktieren"
  },
  TipsType_10593_Desc = {
    Text = "Anmeldung abgelaufen, bitte erneut anmelden"
  },
  TipsType_10594_Desc = {
    Text = "Derzeit ist das Menophin unzureichend"
  },
  TipsType_10595_Desc = {
    Text = "Möchtest du „{s1}“ aktivieren?"
  },
  TipsType_10595_Title = {
    Text = "Talent aktivieren"
  },
  TipsType_10596_Desc = {
    Text = "Erwachte noch nicht erhalten"
  },
  TipsType_10597_Desc = {
    Text = "Kein Schicksalsrad zum Verstärken"
  },
  TipsType_10598_Desc = {
    Text = "Dieses Konto wurde wegen Verstoßes gegen die Vorschriften bis {s1} gesperrt, bei Fragen bitte den Kundendienst kontaktieren"
  },
  TipsType_10599_Desc = {
    Text = "Abschluss Untersuchung 2-15 freigeschaltet"
  },
  TipsType_10600_Desc = {
    Text = "Maximallevel erreicht, kann nicht weiter hinzugefügt werden"
  },
  TipsType_10601_Desc = {
    Text = "Nach Abschluss der Untersuchung 1-7 das Wachstumsprotokoll des Geheimnishüters freischalten"
  },
  TipsType_10602_Desc = {
    Text = "Nach Abschluss der Untersuchung 1-7 die Grenzbeherrschungsaufgabe freischalten"
  },
  TipsType_10603_Desc = {
    Text = "Material nicht ausgewählt"
  },
  TipsType_10604_Desc = {
    Text = "Lange Inaktivität, automatischer Verlassen des Dungeons"
  },
  TipsType_10605_Desc = {
    Text = "Fragebogen abgeschlossen, danke für Ihre Unterstützung!"
  },
  TipsType_10606_Desc = {
    Text = "Nicht genügend Materialien zur Aktivierung"
  },
  TipsType_10607_Desc = {
    Text = "Wöchentliche Belohnungen aufgebraucht, keine Belohnung nach der Herausforderung. Trotzdem herausfordern?"
  },
  TipsType_10607_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_10607_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10607_Title = {
    Text = "Herausforderungshinweis"
  },
  TipsType_10608_Desc = {
    Text = "Campus in Wartung, bitte warten"
  },
  TipsType_10609_Desc = {
    Text = "Erfolgreich {s1} in dein Zimmer eingeladen"
  },
  TipsType_10610_Desc = {
    Text = "{s1} ist bereits in deinem Wohnheim"
  },
  TipsType_10611_Desc = {
    Text = "Aktuell kein WLAN, mobile Daten verwenden?"
  },
  TipsType_10611_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_10611_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10611_Title = {
    Text = "Download-Bestätigung"
  },
  TipsType_10612_Desc = {
    Text = "Alle Karten sind bereits geprägt"
  },
  TipsType_10613_Desc = {
    Text = "Netzwerkfehler, bitte warten"
  },
  TipsType_10614_Desc = {
    Text = "Herausforderung nicht freigeschaltet"
  },
  TipsType_10615_Desc = {
    Text = "Abkühlung, nächste Runde freigeben"
  },
  TipsType_10616_Desc = {
    Text = "Im Zustand Auswahl, erst nach Auswahl freigeben"
  },
  TipsType_10617_Desc = {
    Text = "Im Versiegelten Zustand kann keine Verherrlichung eingesetzt werden."
  },
  TipsType_10618_Desc = {
    Text = "Durchschnittslevel des Teams {s1} unter empfohlenem Level {s2}, große Herausforderungen möglich. Bestätigen?"
  },
  TipsType_10618_LeftBtnDesc = {
    Text = "Zum Aufstieg"
  },
  TipsType_10618_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10618_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_10619_Desc = {
    Text = "Ermittlungsstufe {s1} erforderlich"
  },
  TipsType_10620_Desc = {
    Text = "Schlechte Netzwerkverbindung, bitte überprüfen Sie die Steam-Verbindung oder starten Sie Steam neu und versuchen Sie es erneut"
  },
  TipsType_10621_Desc = {
    Text = "Möchtest du <WeaponEffect_Num:{s1}> als deinen Namen verwenden?"
  },
  TipsType_10621_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_10621_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10621_Title = {
    Text = "Gravur bestätigt"
  },
  TipsType_10622_Desc = {
    Text = "Gravur in Abkühlung, erneut gravierbar in {s1} Stunden {s2} Minuten"
  },
  TipsType_10623_Desc = {
    Text = "Erfolgreich eingraviert"
  },
  TipsType_10624_Desc = {
    Text = "Name darf nur chinesische, englische Buchstaben und Zahlen enthalten"
  },
  TipsType_10625_Desc = {
    Text = "Diese Karte wird bald abgeworfen"
  },
  TipsType_10626_Desc = {
    Text = [[
Bitte aktiviere die folgenden Optionen in Steam:
[Steam-Einstellungen - Im Spiel - Steam-Overlay im Spiel aktivieren]
und starte das Spiel neu]]
  },
  TipsType_10626_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10626_Title = {Text = "Hinweis"},
  TipsType_10628_Desc = {
    Text = "Neuer Name darf nicht mit dem aktuellen übereinstimmen"
  },
  TipsType_10629_Desc = {
    Text = "Bitte geben Sie {s1}~{s2} Zeichen ein"
  },
  TipsType_10630_Desc = {
    Text = "{s1} kann nach Erreichen von drei Sternen wiederholt werden"
  },
  TipsType_10631_Desc = {
    Text = "Ihr Konto wurde aufgrund eines Verstoßes gegen die Vorschriften vorübergehend gesperrt."
  },
  TipsType_10631_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10631_Title = {Text = "Hinweis"},
  TipsType_10632_Desc = {
    Text = "Nach Abschluss der Herausforderung kann heute reproduziert werden"
  },
  TipsType_10633_Desc = {
    Text = "Diese Zersetzung verbraucht die folgenden Ressourcen, <Blue:Die Zersetzung kann nicht wiederhergestellt werden>, bestätigen Sie die Zersetzung?"
  },
  TipsType_10633_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_10633_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10633_Title = {
    Text = "Zerlegung bestätigen"
  },
  TipsType_10634_Desc = {
    Text = "Verbleibende Tage für die aktuelle Monatskarte überschreiten {s1} Tage, keine Ansammlung möglich."
  },
  TipsType_10635_Desc = {
    Text = "Nicht genügend Silberkernquellflüssigkeit vorhanden, möchten Sie zum Silberkernquellflüssigkeit-Extrahieren gehen?"
  },
  TipsType_10635_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_10635_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10635_Title = {
    Text = "Nicht genug Silberprimus"
  },
  TipsType_10636_Desc = {
    Text = "Keine freien Schicksalsräder"
  },
  TipsType_10637_Desc = {
    Text = "Derzeit gibt es keine ungenutzten Bunde"
  },
  TipsType_10638_Desc = {
    Text = "Derzeit befinden sich keine verfügbaren Bund-Positionen, bitten entfernen Sie die Bunde und versuchen Sie es erneut"
  },
  TipsType_10640_Desc = {
    Text = "Bestätigen, alle Bündnisse des Erweckers abzulegen?"
  },
  TipsType_10640_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_10640_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10640_Title = {Text = "Hinweis"},
  TipsType_10641_Desc = {
    Text = "Nach dem Wechsel der Sprache muss der Client neu gestartet werden, bestätigen?"
  },
  TipsType_10641_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_10641_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10641_Title = {
    Text = "Sprache wechseln bestätigen"
  },
  TipsType_10642_Desc = {
    Text = "Spielerlevel zu niedrig"
  },
  TipsType_10643_Desc = {
    Text = "Betritt korrodierte Bereiche, Lebenspunkte -{s1}"
  },
  TipsType_10644_Desc = {
    Text = "Schlüsselbefehl ausgewählt"
  },
  TipsType_10645_Desc = {
    Text = "Schlüsselbefehl nicht erhalten"
  },
  TipsType_10646_Desc = {
    Text = "\"{s1}\" ist unzureichend"
  },
  TipsType_10647_Desc = {
    Text = "Die Untersuchung des Ereignisses hat noch nicht begonnen, {s1}"
  },
  TipsType_10648_Desc = {
    Text = "Kreis-Riss wurde aktualisiert"
  },
  TipsType_10649_Desc = {
    Text = "Die aktuelle Anzahl der Entsendungen hat das Limit erreicht"
  },
  TipsType_10650_Desc = {
    Text = "Derzeit gibt es keine freigeschalteten SSR-Charaktere"
  },
  TipsType_10651_Desc = {
    Text = "Eine bestimmte Anzahl an gesammelten Objekten muss erreicht werden, um sie nutzen zu können"
  },
  TipsType_10652_Desc = {
    Text = "Derzeit gibt es keine unbeschafften Profilbilder und Kampfausdrücke"
  },
  TipsType_10701_Desc = {
    Text = "Schicksalsrad ausgerüstet, bitte entfernen und erneut versuchen"
  },
  TipsType_10702_Desc = {
    Text = "Wenn die zusätzliche Stapelung des SSR-Schicksalsrads 12 erreicht, können zwei SSR-Schicksalsräder gleichzeitig ausgerüstet werden"
  },
  TipsType_10703_Desc = {
    Text = "Erwecker hat bereits dasselbe Schicksalsrad ausgerüstet, kann nicht erneut ausgerüstet werden."
  },
  TipsType_10704_Desc = {
    Text = "Das Bündnis-Level hat das Maximallevel erreicht"
  },
  TipsType_10705_Desc = {
    Text = "Materialien-Limit erreicht"
  },
  TipsType_10706_Desc = {
    Text = "Maximal zwei Nebenattribute sperrbar"
  },
  TipsType_10707_Desc = {
    Text = "Unzureichende Transkriptionsmaterialien"
  },
  TipsType_10708_Desc = {
    Text = "Wachaufkörper steigern, um die Stufe {s1} freizuschalten"
  },
  TipsType_10709_Desc = {
    Text = "\"{s1}\" ist unzureichend"
  },
  TipsType_10710_Desc = {
    Text = "Bereits ausverkauft"
  },
  TipsType_10711_Desc = {
    Text = "Dieses Produkt ist nicht freigeschaltet"
  },
  TipsType_10712_Desc = {
    Text = "Materialien voll"
  },
  TipsType_10713_Desc = {
    Text = "Schicksalsrad-Stapel am Limit"
  },
  TipsType_10714_Desc = {
    Text = "Bedingungen für das Ereignis nicht erfüllt, Auswahl nicht möglich"
  },
  TipsType_10715_Desc = {
    Text = "Bitte installieren Sie die entsprechende App, bevor Sie teilen"
  },
  TipsType_10716_Desc = {
    Text = "Keine weiteren Schicksalsräder wählbar"
  },
  TipsType_10717_Desc = {
    Text = "Keine weiteren Schlüsselwörter wählbar"
  },
  TipsType_10718_Desc = {
    Text = "Aktivierung erfolgreich"
  },
  TipsType_10719_Desc = {
    Text = "Unzureichende Tausendgesichter-Stempel. Sie können Materialien in den „Austauschhändler-Einstellungen„ automatisch umwandeln"
  },
  TipsType_10720_Desc = {
    Text = "Bereits auf 1-fache Geschwindigkeit umgeschaltet"
  },
  TipsType_10721_Desc = {
    Text = "Bereits auf 2-fache Geschwindigkeit umgeschaltet"
  },
  TipsType_10722_Desc = {
    Text = "Der Eingang zum Campus ist überlastet, bitte versuchen Sie es später erneut"
  },
  TipsType_10723_Desc = {
    Text = "Speichern erfolgreich"
  },
  TipsType_10724_Desc = {
    Text = "Speichern fehlgeschlagen, Albumzugriff nicht aktiviert oder Speicherplatz knapp"
  },
  TipsType_10725_Desc = {
    Text = "Materialien unzureichend"
  },
  TipsType_10726_Desc = {
    Text = "Bitte wählen Sie eine Karte"
  },
  TipsType_10727_Desc = {
    Text = "Dieser Erwachte ist deaktiviert"
  },
  TipsType_10728_Desc = {
    Text = "Die Genesis Form kann nicht entsandt werden, bitte wählen Sie erneut"
  },
  TipsType_10736_Desc = {
    Text = "Menophin ist ausreichend, keine Auffüllung nötig."
  },
  TipsType_10737_Desc = {
    Text = "Neue Spielversion erkannt, bitte Spiel neu starten, um Updates zu installieren"
  },
  TipsType_10738_Desc = {
    Text = "Keine zu lesenden Anleitungen"
  },
  TipsType_10739_Desc = {
    Text = "{s1} hat bereits in {s2} gekämpft, kann nicht erneut antreten"
  },
  TipsType_10740_Desc = {
    Text = "Untersuchungslevel {s1} unter empfohlenem Level {s2}, große Herausforderungen möglich. Bestätigen?"
  },
  TipsType_10740_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_10740_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10740_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_10741_Desc = {
    Text = "Durchschnittslevel des Teams {s1} und Geheimnisträger-Untersuchungslevel {s2} unter empfohlenem Level, sehr große Herausforderungen möglich. Bestätigen?"
  },
  TipsType_10741_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_10741_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10741_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_10742_Desc = {
    Text = "Gleiche Schicksalsräder im Team, Effekt kann nicht mehrfach wirken, derzeit besteht bei <Blue:{s1}> eine Situation, in der das Schicksalsrad nicht aktiv ist. Es wird empfohlen, dass der Schutzherr die Schicksalsräder neu anpasst, bevor die Untersuchung fortgesetzt wird.\nMöchten Sie dennoch die Untersuchung durchführen?"
  },
  TipsType_10742_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_10742_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10742_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_10743_Desc = {
    Text = "Keine verbleibenden Unterstützungsversuche in der Schmelzkatastrophen-Zone"
  },
  TipsType_10744_Desc = {
    Text = "Beobachtungsgrenze erreicht"
  },
  TipsType_10745_Desc = {
    Text = "Geburtsdatum ist falsch, kann nicht eingestellt werden"
  },
  TipsType_10746_Desc = {
    Text = "Bereits in die Zwischenablage kopiert"
  },
  TipsType_10747_Desc = {
    Text = "Gefällt mir erfolgreich"
  },
  TipsType_10748_Desc = {
    Text = "{s1} ist bereits ein Unterstützungs-Erwachter"
  },
  TipsType_10749_Desc = {
    Text = "Kampfunterstützung Erwachter darf nicht leer sein"
  },
  TipsType_10750_Desc = {
    Text = "Heute hast du diesen Geheimnishüter bereits geliked"
  },
  TipsType_10751_Desc = {
    Text = "Maximal 4 Erwachte anzeigbar"
  },
  TipsType_10752_Desc = {
    Text = "Grenzgebiet nicht geeignet, kann nicht eingesetzt werden"
  },
  TipsType_10753_Desc = {
    Text = "{s1} ist bereits im Einsatz, kann nicht erneut gewählt werden"
  },
  TipsType_10754_Desc = {
    Text = "{s1} wurde zurückgesetzt"
  },
  TipsType_10755_Desc = {
    Text = "Freischaltung erfolgreich"
  },
  TipsType_10756_Desc = {
    Text = "Derzeit sind keine Stapelmaterialien verfügbar"
  },
  TipsType_10757_Desc = {
    Text = "{s1} hat die Herausforderung in dieser Aktivität am heutigen Tag bereits absolviert und kann nicht erneut eingesetzt werden."
  },
  TipsType_10758_Desc = {
    Text = "Teamdomäne erfüllt die Anforderungen nicht"
  },
  TipsType_10761_Desc = {
    Text = "Der Genesis Erwecker kann nicht gleichzeitig mit seiner normalen Form kämpfen"
  },
  TipsType_10762_Desc = {
    Text = "Der Genesis Erwecker kann nicht gleichzeitig mit seiner normalen Form angezeigt werden"
  },
  TipsType_10799_Desc = {
    Text = "Der aktuelle <Blue:{s1}> Bündnis 6-teilige Set-Effekt ist aufgrund der Einschränkung <Blue:Team Unique> nicht aktiv. Es wird empfohlen, dass der Schutzherr das Bündnis neu anpasst, bevor eine Untersuchung durchgeführt wird. \n Möchtest du trotzdem untersuchen?"
  },
  TipsType_10799_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_10799_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10799_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_10801_Desc = {
    Text = "Die Anzahl der Bündnis-Projekte hat das Limit erreicht"
  },
  TipsType_10802_Desc = {
    Text = "{s1} wird in anderen Bündnissen verwendet und kann nicht gespeichert werden"
  },
  TipsType_10803_Desc = {
    Text = "Der Name des Bündnis-Projekts darf nicht leer sein"
  },
  TipsType_10804_Desc = {
    Text = "Ungültige Zeichen enthalten, bitte erneut eingeben"
  },
  TipsType_10805_Desc = {
    Text = "Bereits gespeichert"
  },
  TipsType_10806_Desc = {
    Text = "Das aktuelle Bündnis wurde in {s1} angewendet"
  },
  TipsType_10807_Desc = {
    Text = "Ausgerüstet"
  },
  TipsType_10808_Desc = {
    Text = "Bereits abgenommen"
  },
  TipsType_10809_Desc = {
    Text = "Team im Einsatz"
  },
  TipsType_10810_Desc = {
    Text = "Das Bündnis-Projekt darf nicht leer sein"
  },
  TipsType_10811_Desc = {
    Text = "Plan bereits ausgerüstet"
  },
  TipsType_10812_Desc = {
    Text = "Ausgerüstet"
  },
  TipsType_10813_Desc = {
    Text = "Möchtest du den Plan [{s1}] löschen?"
  },
  TipsType_10813_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_10813_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10814_Desc = {
    Text = "Für diese Untersuchung eingesetzte Erwachte erfüllen nicht die Teamanforderungen"
  },
  TipsType_10815_Desc = {
    Text = "Aktueller Erwachter ist speziell für die Handlung entworfen, Details nicht einsehbar"
  },
  TipsType_10816_Desc = {
    Text = "Unzureichende Agentenbeweise"
  },
  TipsType_10817_Desc = {
    Text = "Keine Abrechnungsdaten, bitte „Herausfordern“ und nach 9:00 Uhr am nächsten Tag abrechnen"
  },
  TipsType_10818_Desc = {
    Text = "Heute wurde die Vertretung abgeschlossen, keine Wiederholung möglich"
  },
  TipsType_10821_Desc = {
    Text = "Derzeit sind keine Materialien verfügbar, bitte kommen Sie später wieder"
  },
  TipsType_10822_Desc = {
    Text = "Event beendet"
  },
  TipsType_10823_Desc = {
    Text = "Die speziellen Samen können erst nach dem Ausverkauf nachbestellt werden"
  },
  TipsType_10824_Desc = {
    Text = "Nachschub aufgebraucht, keine weiteren Vorräte verfügbar"
  },
  TipsType_10825_Desc = {
    Text = "\"{s1}\" ist unzureichend"
  },
  TipsType_10826_Desc = {
    Text = "Die speziellen Samen sind ausverkauft, Sie können die Aussaat zur Rücksetzung wählen"
  },
  TipsType_10827_Desc = {
    Text = "Die speziellen Samen wurden zurückgesetzt"
  },
  TipsType_10828_Desc = {
    Text = "Alle Gegenstände wurden getauscht, bitte wählen Sie zurücksetzen"
  },
  TipsType_10829_Desc = {
    Text = "Erfolgreich zurückgesetzt"
  },
  TipsType_10830_Desc = {
    Text = "Unspielbare erwachte Einheiten im Team, Untersuchung nicht möglich"
  },
  TipsType_10831_Desc = {
    Text = "Gleiche Schicksalsräder im Team, Zugang zur Katastrophenzone nicht möglich"
  },
  TipsType_10832_Desc = {
    Text = "Team ohne Schlüsselbefehl, kann nicht untersuchen"
  },
  TipsType_10833_Desc = {
    Text = "Nicht ausrüstbare Schicksalsräder im Team, Untersuchung nicht möglich"
  },
  TipsType_10834_Desc = {
    Text = "Kann keine Schicksalsräder für Unterstützungscharaktere ausrüsten"
  },
  TipsType_10835_Desc = {
    Text = "Es ist nicht erlaubt, den Wecker mit einem Bündnis für den Kampf auszurüsten"
  },
  TipsType_10836_Desc = {
    Text = "Es ist nicht erlaubt, den Wecker mit einem Schicksalsrad für die Handlung auszustatten"
  },
  TipsType_10837_Desc = {
    Text = "Es ist nicht erlaubt, den Wecker mit einem Bündnis für die Handlung auszustatten"
  },
  TipsType_10838_Desc = {
    Text = "Maximale Anzahl an Ausdrücken im Ausdrucksplan erreicht"
  },
  TipsType_10839_Desc = {
    Text = "Ausdruck verwendet, klicke auf den Ausdruck im Ausdrucksplan, um ihn zu entfernen"
  },
  TipsType_10840_Desc = {
    Text = "Ausdruck zu schnell gesendet"
  },
  TipsType_10841_Desc = {
    Text = "Ausdrucksplan darf nicht leer sein"
  },
  TipsType_10842_Desc = {
    Text = "Ausdrucksplan aktualisiert"
  },
  TipsType_10843_Desc = {
    Text = "Dieser Eintrag ist noch nicht freigeschaltet"
  },
  TipsType_10844_Desc = {
    Text = "Nicht freigeschaltet"
  },
  TipsType_10850_Desc = {
    Text = "Nicht ausrüstbare Schlüsselbefehle im Team, Untersuchung nicht möglich"
  },
  TipsType_10901_Desc = {Text = "Lähmung"},
  TipsType_10902_Desc = {
    Text = "Ohnmächtig"
  },
  TipsType_10903_Desc = {
    Text = "Noch nicht im Besitz von:{s1}"
  },
  TipsType_10904_Desc = {
    Text = "Durchführung des Kapitels im „Normal“-Modus, um den „Erinnerung“-Modus für die Handlung freizuschalten"
  },
  TipsType_10905_Desc = {
    Text = "Vollende „Ermittlungsoperation“ 1-15·Normal, um die „Erinnerung“ Szenario anzuschauen"
  },
  TipsType_10906_Desc = {
    Text = "\"Reality Verge\" ist unzureichend"
  },
  TipsType_10907_Desc = {
    Text = "Freigeschaltet"
  },
  TipsType_10908_Desc = {
    Text = "{s1} hat das vollständige Erwachen erreicht. Weitere Gewinne werden in <TipsHighlightText:„Seelenrückspulsplitter ×2> umgewandelt. Erweckung bestätigen?"
  },
  TipsType_10908_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_10908_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10908_Title = {
    Text = "Erweckungsbestätigung"
  },
  TipsType_10909_Desc = {
    Text = "{s1} wurde erweckt. Weitere Gewinne werden in <TipsHighlightText:Fragment: {s2}*1> und <TipsHighlightText:Wurzeleinlagerung*50> umgewandelt. Erweckung bestätigen?"
  },
  TipsType_10909_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_10909_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10909_Title = {
    Text = "Erweckungsbestätigung"
  },
  TipsType_10910_Desc = {
    Text = "Möchtest du <TipsHighlightText:{s1}> erwecken?"
  },
  TipsType_10910_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_10910_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10910_Title = {
    Text = "Erweckungsbestätigung"
  },
  TipsType_10911_Desc = {
    Text = "Nicht genug Platz"
  },
  TipsType_10912_Desc = {
    Text = "Im Hyperdimensionalen Raum gibt es keine Befehlskarten, nicht nutzbar"
  },
  TipsType_10913_Desc = {
    Text = "In dieser Runde nicht erneut verwendbar"
  },
  TipsType_10914_Desc = {
    Text = "Möchtest du <TipsHighlightText:{s1}> auswählen?"
  },
  TipsType_10914_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_10914_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10914_Title = {
    Text = "Wähle bestätigen"
  },
  TipsType_10915_Desc = {
    Text = "Die Freischaltung der Teams muss in der richtigen Reihenfolge erfolgen. Überspringen Sie keine nicht freigeschalteten Teams."
  },
  TipsType_10916_Desc = {
    Text = "Möchtest du <Blue: {s1} × {s2}> ausgeben, um es freizuschalten?"
  },
  TipsType_10916_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_10916_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10916_Title = {
    Text = "Bestätigung freischalten"
  },
  TipsType_10917_Desc = {
    Text = "Freischaltung erfolgreich {s1}"
  },
  TipsType_10918_Desc = {
    Text = "Freischaltung erfolgreich {s1}, alle Charaktere sind nun freigeschaltet"
  },
  TipsType_10919_Desc = {
    Text = "Nach [{s1}:{s2}] freigeschaltet – möchtest du zu [{s1}] gehen?"
  },
  TipsType_10919_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_10919_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10919_Title = {
    Text = "Noch nicht freigeschaltet"
  },
  TipsType_10920_Desc = {
    Text = "Sammle „magische Eicheln\" × {s1} während der zeitbegrenzten Aktion „Phasenumschaltung\", um sie freizuschalten. Möchtest du zur Aktion „Phasenumschaltung\" gehen?"
  },
  TipsType_10920_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_10920_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_10920_Title = {
    Text = "Noch nicht freigeschaltet"
  },
  TipsType_10921_Desc = {
    Text = "Zwei Schicksalsräder mit demselben Hauptattribut können nicht gleichzeitig ausgerüstet werden"
  },
  TipsType_20001_Desc = {
    Text = "Aktiviere die doppelte Bestätigung"
  },
  TipsType_20001_LeftBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20001_Title = {Text = "Titel"},
  TipsType_20002_Desc = {
    Text = "Ohne zweite Bestätigung"
  },
  TipsType_20002_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20002_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20002_Title = {Text = "Titel"},
  TipsType_20003_Desc = {
    Text = "Ihr Konto wurde auf einem anderen Gerät angemeldet"
  },
  TipsType_20003_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20003_Title = {
    Text = "Verbindungsabbruch"
  },
  TipsType_20004_Desc = {
    Text = "Die Verbindung zum Server wurde getrennt, bitte erneut anmelden"
  },
  TipsType_20004_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20004_Title = {
    Text = "Verbindungsabbruch"
  },
  TipsType_20005_Desc = {
    Text = "Synchronisation fehlgeschlagen, erneut versuchen?"
  },
  TipsType_20005_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20005_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20005_Title = {
    Text = "Synchronisation fehlgeschlagen"
  },
  TipsType_20006_Desc = {
    Text = "Synchronisation verloren, kehrt später zum Login-Bildschirm zurück"
  },
  TipsType_20006_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20006_Title = {
    Text = "Synchronisation fehlgeschlagen"
  },
  TipsType_20007_Desc = {
    Text = "Synchronisation verloren, kehrt später zum Login-Bildschirm zurück"
  },
  TipsType_20007_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20007_Title = {
    Text = "Synchronisation fehlgeschlagen"
  },
  TipsType_20008_Desc = {
    Text = "Diese Untersuchung verbraucht <Positive:{s1}> Ausdauer, Untersuchung beenden?"
  },
  TipsType_20008_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20008_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20008_Title = {
    Text = "Erkundung beenden"
  },
  TipsType_20009_Desc = {
    Text = "Das Aktualisieren wird die Gebete und Relikte aktualisieren, die Erweckung des Wachrüstlings und die Anzahl der verkauften Befehlskarten werden nicht zurückgesetzt. Möchten Sie das bestätigen?"
  },
  TipsType_20009_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20009_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20009_Title = {
    Text = "Aktualisieren bestätigen"
  },
  TipsType_20010_Desc = {
    Text = "Nicht genügend Erwachensformen in diesem Bereich, Team trotzdem erstellen?"
  },
  TipsType_20010_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20010_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20011_Desc = {
    Text = "Kein Erwecker gewählt, Teamaufstellung wird nicht beibehalten"
  },
  TipsType_20011_LeftBtnDesc = {
    Text = "Verlassen bestätigen"
  },
  TipsType_20011_RightBtnDesc = {
    Text = "Weiter Teamaufstellung"
  },
  TipsType_20012_Desc = {
    Text = "Erweckter nicht ausgewählt"
  },
  TipsType_20012_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20013_Desc = {
    Text = "Das Team hat noch freie Plätze, Abreise bestätigen?"
  },
  TipsType_20013_LeftBtnDesc = {Text = "Zurück"},
  TipsType_20013_RightBtnDesc = {Text = "Aufbruch"},
  TipsType_20014_Desc = {
    Text = "Teamanzahl erreicht Limit"
  },
  TipsType_20014_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20015_Desc = {
    Text = "Möchtest du dieses Team löschen?"
  },
  TipsType_20015_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20015_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20016_Desc = {
    Text = "{s1} nach Abschluss freigeschaltet"
  },
  TipsType_20016_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20017_Desc = {
    Text = "Hier können Karten- und Monsterinformationen eingesehen werden, derzeit nicht verfügbar"
  },
  TipsType_20017_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20018_Desc = {
    Text = "Freischaltbedingungen für diese Stufe noch nicht erfüllt"
  },
  TipsType_20018_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20018_Title = {
    Text = "Schnelle Erkundung"
  },
  TipsType_20019_Desc = {
    Text = "„Silber\" reicht nicht aus. Möchtest du zum Shop gehen und kaufen?"
  },
  TipsType_20019_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20019_RightBtnDesc = {Text = "Gehe zu"},
  TipsType_20020_Desc = {
    Text = "Dieser Schwierigkeitsgrad wird nach Abschluss von Fortschritt {s1} freigeschaltet"
  },
  TipsType_20020_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20021_Desc = {
    Text = "{s1} schaltet nach Abschluss des normalen Modus das fortgeschrittene Training frei"
  },
  TipsType_20021_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20022_Desc = {
    Text = "„Silber\" reicht nicht aus. Möchtest du kaufen?"
  },
  TipsType_20022_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20022_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20022_Title = {
    Text = "Silberkernmangel"
  },
  TipsType_20023_Desc = {
    Text = "Dieses Upgrade überschreitet {s1} Erfahrungspunkte (nicht erstattbar), und der Charakter kann nach Erreichen des Level-Limits keine Erfahrung mehr sammeln. Fortfahren?"
  },
  TipsType_20023_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20023_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20024_Desc = {
    Text = "Unvollständiges Team, kann den Dungeon nicht betreten"
  },
  TipsType_20024_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20026_Desc = {
    Text = "Möchtest du aufladen?"
  },
  TipsType_20026_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20026_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20027_Desc = {
    Text = "Möchtest du das Leben wiederherstellen?"
  },
  TipsType_20027_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20027_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20028_Desc = {
    Text = "Schließen dieses Fensters wird das Aufheben von [{s1}] abbrechen, wirklich abbrechen?"
  },
  TipsType_20028_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20028_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20029_Desc = {
    Text = "Schließen dieses Fensters wird das Ereignis überspringen (Schöpfung wird nicht entfernt), wirklich bestätigen?"
  },
  TipsType_20029_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20029_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20030_Desc = {
    Text = "Markierte Schöpfungen werden nicht mitgeführt, Vererbung aufgeben?"
  },
  TipsType_20030_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20030_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20031_Desc = {
    Text = "Möchtest du den Kampf verlassen?"
  },
  TipsType_20031_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20031_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20032_Desc = {
    Text = "Aktuelle Stufe nicht freigeschaltet, zur Freischaltung die Untersuchungsstufe abschließen?"
  },
  TipsType_20032_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20032_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20032_Title = {
    Text = "Noch nicht freigeschaltet"
  },
  TipsType_20033_Desc = {
    Text = "Nicht genug Versuche. 500 Silber zum Zurücksetzen verwenden?"
  },
  TipsType_20033_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20033_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20034_Desc = {
    Text = "Die aktuelle Herausforderung ist in Abklingzeit. Möchtest du „Silber\" × 50 zum Zurücksetzen verwenden?"
  },
  TipsType_20034_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20034_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20035_Desc = {
    Text = "Empfohlenes Level ist {s1}, das aktuelle Durchschnittslevel des Teams ist {s2}. Die Untersuchung wird auf Hindernisse stoßen. Fortfahren?"
  },
  TipsType_20035_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20035_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20035_Title = {
    Text = "Kampfkraft unzureichend"
  },
  TipsType_20036_Desc = {
    Text = "Eingestellte Durchläufe {s1}, aber nur {s2} Energie pro Belohnung. Bestätigen?"
  },
  TipsType_20036_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20036_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20036_Title = {
    Text = "Herausforderung bestätigen"
  },
  TipsType_20037_Desc = {
    Text = "Die Stärkungsmaterialien enthalten hochwertige Materialien, möchtest du die Stärkung bestätigen?"
  },
  TipsType_20037_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20037_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20037_Title = {
    Text = "Stärkung bestätigen"
  },
  TipsType_20038_Desc = {
    Text = "Diese Ausrüstung ist gesperrt. Möchten Sie die Sperre aufheben?"
  },
  TipsType_20038_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20038_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20039_Desc = {
    Text = "Nach der Bestätigung wird diese Untersuchung fehlschlagen und keine weiteren Belohnungen erhalten. Möchtest du die Untersuchung beenden?"
  },
  TipsType_20039_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20039_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20039_Title = {
    Text = "Ermittlung beenden"
  },
  TipsType_20040_Desc = {
    Text = "<WeaponEffect_Num:Das aktive Beenden wird {s1} Menophin verbrauchen.> Die Ermittlung wird fehlschlagen, und keine nachfolgenden Untersuchungsbelohnungen können erhalten werden. Trotzdem fortfahren?"
  },
  TipsType_20040_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20040_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20040_Title = {
    Text = "Ermittlung beenden"
  },
  TipsType_20041_BottomDesc = {
    Text = "Aktuell besitzt du folgende Zeitkompressionsgenehmigung: {s1}"
  },
  TipsType_20041_Desc = {
    Text = "Möchtest du {s1} Zeitkompressionsgenehmigungen verwenden, um zu beschleunigen?"
  },
  TipsType_20041_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20041_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20041_Title = {
    Text = "Beschleunigung bestätigen"
  },
  TipsType_20042_Desc = {
    Text = "RPG-Kampfanpassung, derzeit direkter Sieg"
  },
  TipsType_20042_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20042_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20043_Desc = {
    Text = "Möchtest du {s1} Silberkerne ausgeben, um die aktuelle Aufgabe zu aktualisieren?"
  },
  TipsType_20043_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20043_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20043_Title = {
    Text = "Aufgabe aktualisieren"
  },
  TipsType_20044_BottomDesc = {
    Text = "Verbraucht: {s1} Forschungsgenehmigung"
  },
  TipsType_20044_Desc = {
    Text = "Möchtest du {s1} erforschen?\nForschungseffekt: {s2}"
  },
  TipsType_20044_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20044_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20044_Title = {
    Text = "Forschung bestätigt"
  },
  TipsType_20045_BottomDesc = {
    Text = "Forschung abbrechen, Fortschritt nicht speichern"
  },
  TipsType_20045_Desc = {
    Text = "Möchtest du die Forschung von {s1} abbrechen? (Die gesamte Forschungserlaubnis wird zurückerstattet)"
  },
  TipsType_20045_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20045_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20045_Title = {
    Text = "Forschung abgebrochen"
  },
  TipsType_20046_Desc = {
    Text = "Möchtest du {s1} „Silber\" ausgeben, um zu beschleunigen?"
  },
  TipsType_20046_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20046_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20046_Title = {
    Text = "Beschleunigung bestätigen"
  },
  TipsType_20047_Desc = {
    Text = "Es fehlen {s1} <Blue:„{s2}\">, möchtest du <Blue:„Silber\"×{s3}> ausgeben, um sie zu kaufen?"
  },
  TipsType_20047_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20047_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20047_Title = {
    Text = "Kauf bestätigen"
  },
  TipsType_20048_Desc = {
    Text = "Es fehlen {s1} <Blue:„{s2}\">, möchtest du <Blue:„Silber\"×{s3}> ausgeben, um sie zu kaufen?"
  },
  TipsType_20048_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20048_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20048_Title = {
    Text = "Kauf bestätigen"
  },
  TipsType_20049_Desc = {
    Text = "<Blue:„{s1}\"> ist von <Blue:„{s2}\"> ausgerüstet. Wirklich wechseln?"
  },
  TipsType_20049_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20049_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20049_Title = {
    Text = "Wechselhinweis"
  },
  TipsType_20050_Desc = {
    Text = "Verbraucht das bereits gestapelte Schicksalsrad, bestätigen?"
  },
  TipsType_20050_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20050_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20050_Title = {
    Text = "Stapel-Hinweis"
  },
  TipsType_20051_Desc = {
    Text = "Aktuelle Stapelstufe überschreitet das Limit des Schicksalsrads, überschüssige Stufen werden zurückerstattet. Bestätigen?"
  },
  TipsType_20051_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20051_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20051_Title = {
    Text = "Stapel-Hinweis"
  },
  TipsType_20052_Desc = {
    Text = "Empfohlenes Level ist {s1}, das aktuelle Durchschnittslevel des Teams ist {s2}. Die Untersuchung wird auf erhebliche Hindernisse stoßen. Fortfahren?"
  },
  TipsType_20052_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20052_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20052_Title = {
    Text = "Kampfkraft unzureichend"
  },
  TipsType_20053_Desc = {
    Text = "Empfohlenes Level ist {s1}, das aktuelle Durchschnittslevel des Teams ist {s2}. Die Untersuchung wird auf große Hindernisse stoßen. Fortfahren?"
  },
  TipsType_20053_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20053_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20053_Title = {
    Text = "Kampfkraft unzureichend"
  },
  TipsType_20054_Desc = {
    Text = "Alle Belohnungen erhalten, keine weiteren Belohnungen. Bestätigen?"
  },
  TipsType_20054_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20054_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20054_Title = {
    Text = "Herausforderung bestätigen"
  },
  TipsType_20055_Desc = {
    Text = "Nach dem Zurücksetzen wird der aktuelle Fortschritt der Stufe auf 0 Sterne zurückgesetzt, und die Kampfaufzeichnungen des Erweckers werden synchron gelöscht. Möchten Sie das Zurücksetzen bestätigen?"
  },
  TipsType_20055_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20055_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20055_Title = {
    Text = "Bestätigung des Zurücksetzens"
  },
  TipsType_20056_Desc = {
    Text = "Nach erfolgreichem Abschluss der Herausforderung können die vier Erwecker der aktuellen Teamaufstellung nicht mehr an anderen Kapiteln von {s1} teilnehmen. Bestätigen Sie die Herausforderung?"
  },
  TipsType_20056_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20056_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20056_Title = {
    Text = "Herausforderung bestätigen"
  },
  TipsType_20057_Desc = {
    Text = "Teamzusammensetzung widerspricht Akademiehandbuch, trotzdem herausfordern?"
  },
  TipsType_20057_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20057_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20057_Title = {
    Text = "Teamaufstellung bestätigen"
  },
  TipsType_20058_Desc = {
    Text = "Der aktuelle Level wurde erfolgreich herausgefordert, um erneut herauszufordern, muss der aktuelle Levelfortschritt auf 0 Sterne zurückgesetzt werden, und die Aufzeichnungen des Erweckers werden ebenfalls zurückgesetzt, möchtest du die Rückstellung bestätigen?"
  },
  TipsType_20058_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20058_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20058_Title = {
    Text = "Bestätigung des Zurücksetzens"
  },
  TipsType_20059_Desc = {
    Text = "Team hat weniger als vier Erwachte, Kampf nicht möglich"
  },
  TipsType_20059_Title = {
    Text = "Teamaufstellung speichern"
  },
  TipsType_20060_BottomDesc = {
    Text = "Nach der Bestätigung ist eine erneute Aktivierung nicht mehr möglich."
  },
  TipsType_20060_Desc = {
    Text = "Möchtest du das aktuelle Erweckungsergebnis auswählen (alle erweckten Einheiten und Ausrüstungen werden erhalten)?"
  },
  TipsType_20060_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20060_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20060_Title = {
    Text = "Auswahl bestätigen"
  },
  TipsType_20061_BottomDesc = {
    Text = "Aktueller Silberkern: {s1}"
  },
  TipsType_20061_Desc = {
    Text = "Möchtest du {s1} „Silber\" ausgeben, um erneut zu erwecken?\nDas aktuelle Ziehungsergebnis wird nicht beibehalten."
  },
  TipsType_20061_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20061_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20061_Title = {
    Text = "Wiedererweckung"
  },
  TipsType_20062_Desc = {
    Text = "Möchtest du wirklich alle gelesenen Nachrichten löschen?\nNachrichten mit nicht abgeholten Anhängen werden nicht gelöscht"
  },
  TipsType_20062_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20062_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20062_Title = {
    Text = "Gelesenes löschen"
  },
  TipsType_20063_Desc = {
    Text = "Löschen bestätigen?"
  },
  TipsType_20063_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20063_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20063_Title = {
    Text = "Aktuelle Nachricht löschen"
  },
  TipsType_20064_Desc = {
    Text = "Nach dem Löschen eines Briefs aus der Schatzkiste kann er nicht wiederhergestellt werden.\nMöchtest du diesen Brief löschen?"
  },
  TipsType_20064_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20064_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20064_Title = {
    Text = "Gespeicherte Nachricht löschen"
  },
  TipsType_20065_Desc = {
    Text = "Bestätigen Sie den Verbrauch von <Blue:{s1}>, um <Blue:{s2}> zu synthetisieren?"
  },
  TipsType_20065_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20065_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20065_Title = {
    Text = "Synthesebestätigung"
  },
  TipsType_20066_Desc = {
    Text = "Möchtest du <Blue:{s1}> zerlegen und {s2} erhalten?"
  },
  TipsType_20066_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20066_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20066_Title = {
    Text = "Zerlegung bestätigen"
  },
  TipsType_20067_Desc = {
    Text = "Bestätigen Sie den Verbrauch von <Blue:{s1}> SSR-Rangbündnissen, um <Blue:{s2}> von <Blue:{s3}> erneut zu drucken?"
  },
  TipsType_20067_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20067_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20067_Title = {
    Text = "Neudruck bestätigen"
  },
  TipsType_20068_Desc = {
    Text = "Alle Erwachten verlieren endgültig ihre Kampffähigkeit\n\nEinziger Geheimnisträger\nWas wirst du als Nächstes tun?"
  },
  TipsType_20068_LeftBtnDesc = {
    Text = "Wiederkampf"
  },
  TipsType_20068_RightBtnDesc = {
    Text = "Vorübergehend zurückziehen"
  },
  TipsType_20068_Title = {
    Text = "Ermittlung fehlgeschlagen"
  },
  TipsType_20069_Desc = {
    Text = "Ausgewählter Erwachter hat vollen Wahnsinn, trotzdem wählen?"
  },
  TipsType_20069_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20069_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20069_Title = {
    Text = "Auswahl bestätigen"
  },
  TipsType_20070_Desc = {
    Text = "Möchten Sie {s1} benutzen?\nErwecker mit erhöhtem Level und Fähigkeiten werden die aufgerüsteten Materialien nicht zurückerhalten"
  },
  TipsType_20070_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20070_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20070_Title = {
    Text = "Verstärkung bestätigt"
  },
  TipsType_20071_Desc = {
    Text = "Aufgrund der Ermittlungsebenen des Hüters wird das Niveau des Erweckers auf {s1} erhöht, und die fehlenden Aufrüstmaterialien werden nicht zurückerstattet. Sind Sie sicher, dass Sie aufsteigen möchten?"
  },
  TipsType_20071_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20071_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20071_Title = {
    Text = "Verstärkung bestätigt"
  },
  TipsType_20072_Desc = {
    Text = "Möchten Sie alle Szenen dieses Abschnitts überspringen?\nHinweis: Sie können später erneut in dieses Level eintreten, um die Szenen anzusehen"
  },
  TipsType_20072_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20072_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20072_Title = {
    Text = "Szene überspringen"
  },
  TipsType_20073_Desc = {
    Text = "Bestätigen Sie die Zerschlagung von {s1} und den Erhalt von {s2}?\n(Das aktuelle Bündnis wurde verstärkt; die Zerschlagung gibt die verstärkten Ressourcen nicht zurück.)"
  },
  TipsType_20073_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20073_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20073_Title = {
    Text = "Zerlegung bestätigen"
  },
  TipsType_20074_Desc = {
    Text = "Möchtest du {s1} zerlegen und {s2} erhalten?\n(Derzeitige Schicksalsrad-Seltenheit ist hoch)"
  },
  TipsType_20074_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20074_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20074_Title = {
    Text = "Zerlegung bestätigen"
  },
  TipsType_20075_BottomDesc = {
    Text = "Verbraucht: {s1} Forschungsgenehmigung"
  },
  TipsType_20075_Desc = {
    Text = "Möchten Sie die Forschung an {s1} starten?\nProduktionseffizienz: {s2} Goldene Rose/alle 6 Stunden\n      ——>{s3} Goldene Rose/alle 6 Stunden"
  },
  TipsType_20075_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20075_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20075_Title = {
    Text = "Forschung bestätigt"
  },
  TipsType_20076_BottomDesc = {
    Text = "Verbraucht: {s1} Forschungsgenehmigung"
  },
  TipsType_20076_Desc = {
    Text = "Möchten Sie die Forschung an {s1} starten?\nProduktionseffizienz: {s2} Gnosis-Elixiere/alle 6 Stunden\n      ——>{s3} Gnosis-Elixiere/alle 6 Stunden"
  },
  TipsType_20076_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20076_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20076_Title = {
    Text = "Forschung bestätigt"
  },
  TipsType_20077_BottomDesc = {
    Text = "Verbraucht: {s1} Forschungsgenehmigung"
  },
  TipsType_20077_Desc = {
    Text = "Möchten Sie die Forschung an {s1} starten?\nProduktionseffizienz: {s2} Bündnisrückstände/alle 6 Stunden\n      ——>{s3} Bündnisrückstände/alle 6 Stunden"
  },
  TipsType_20077_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20077_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20077_Title = {
    Text = "Forschung bestätigt"
  },
  TipsType_20078_Desc = {
    Text = "Möchten Sie alle Szenen dieses Abschnitts überspringen?\nHinweis: Sie können später erneut in dieses Level eintreten, um die Szenen anzusehen"
  },
  TipsType_20078_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20078_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20078_Title = {
    Text = "Szene überspringen"
  },
  TipsType_20079_Desc = {
    Text = "Der Silberschlüssel spürt eine tödliche Gefahr, möchtest du den Notfall-Geistkörper aktivieren?\n(Wiederbelebung verbraucht 1 Notfall-Geistkörper, der Notfall-Geistkörper wird täglich um 9 Uhr automatisch einmal aufgefüllt, verbleibende Anzahl: {s1}/{s2})"
  },
  TipsType_20079_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20079_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20079_Title = {
    Text = "Wiederbelebung Bestätigung"
  },
  TipsType_20080_Desc = {
    Text = "Der Silberschlüssel spürt eine tödliche Gefahr, möchtest du den Notfall-Geistkörper aktivieren?\n(Wiederbelebung verbraucht 1 Notfall-Geistkörper, der Notfall-Geistkörper wird täglich um 9 Uhr automatisch einmal aufgefüllt, verbleibende Anzahl: {s1}/{s2})"
  },
  TipsType_20080_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20080_Title = {
    Text = "Wiederbelebung Bestätigung"
  },
  TipsType_20081_Desc = {
    Text = "Spielinitialisierung fehlgeschlagen. {s1}"
  },
  TipsType_20081_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20081_Title = {
    Text = "Anmeldefehlerhinweis"
  },
  TipsType_20082_Desc = {
    Text = "Möchtest du <Blue:„Silber\" × {s1} > ausgeben, um <Blue: {s2} > Stufen zu kaufen?"
  },
  TipsType_20082_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20082_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20082_Title = {
    Text = "Level erhöhen"
  },
  TipsType_20083_Desc = {
    Text = "Verbrauche das Rad des Schicksals {s1}, zum Stärken bestätigen?"
  },
  TipsType_20083_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20083_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20083_Title = {
    Text = "Verbrauchsbestätigung"
  },
  TipsType_20084_Desc = {
    Text = "Durchschnittliches Teamlevel unter dem empfohlenen Level, Attribute der Erwachten werden geschwächt. Trotzdem untersuchen?"
  },
  TipsType_20084_LeftBtnDesc = {
    Text = "Zum Aufstieg"
  },
  TipsType_20084_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20084_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20085_Desc = {
    Text = "Spiel beenden bestätigen"
  },
  TipsType_20085_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20085_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20085_Title = {
    Text = "Spiel beenden"
  },
  TipsType_20086_Desc = {
    Text = "Serverwartung"
  },
  TipsType_20086_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20086_Title = {
    Text = "Verbindungsabbruch"
  },
  TipsType_20087_Desc = {
    Text = "Möchtest du <TipsHighlightText:{s1} × {s2}> ausgeben, um <TipsHighlightText:{s3}> freizuschalten?"
  },
  TipsType_20087_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20087_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20087_Title = {
    Text = "Bestätigung aktivieren"
  },
  TipsType_20088_Desc = {
    Text = "Nach der Entnahme wird „Menophin\" überlaufen, der Teil, der {s1} übersteigt, kann nicht gewonnen werden.\nMöchtest du weiterhin entnehmen?"
  },
  TipsType_20088_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20088_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20088_Title = {
    Text = "Menophin überläuft"
  },
  TipsType_20089_Desc = {
    Text = "Verbrauch <Blue:{s1}> Rosenskripte zum Aktualisieren des Bestands\nVerbleibende Aktualisierungsversuche: <Blue:{s2}>\nJe mehr Aktualisierungen, desto mehr Rosenskripte werden benötigt."
  },
  TipsType_20089_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20089_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20089_Title = {
    Text = "Bestand aktualisieren"
  },
  TipsType_20090_Desc = {
    Text = "Maximale Anzahl an Schicksalsrädern erreicht. Bereinigen Sie die Schicksalsräder, bevor Sie eine Erweckung durchführen können. Fortfahren?\n\n<color=#ADC0CB>*SR/R-Rang-Schicksalsräder können in den „Einstellungen“ für die automatische Zersetzung festgelegt werden</color>"
  },
  TipsType_20090_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20090_RightBtnDesc = {
    Text = "Zur Reinigung"
  },
  TipsType_20090_Title = {
    Text = "Hinweis aufräumen"
  },
  TipsType_20091_Desc = {
    Text = "Die Anzahl des Bündnisses hat das Limit erreicht; es muss gereinigt werden, bevor eine Untersuchung durchgeführt werden kann. Möchtest du weiterfahren?"
  },
  TipsType_20091_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20091_RightBtnDesc = {
    Text = "Zur Reinigung"
  },
  TipsType_20091_Title = {
    Text = "Hinweis aufräumen"
  },
  TipsType_20092_Desc = {
    Text = "Möchtest du alle Ausrüstungen der aktuellen Einheit entfernen?"
  },
  TipsType_20092_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20092_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20092_Title = {
    Text = "Bestätigung des Abnehmens"
  },
  TipsType_20093_Desc = {
    Text = "Verbrauche Bündnis zur Aufwertung, bestätigen?"
  },
  TipsType_20093_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20093_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20093_Title = {
    Text = "Upgrade-Bestätigung"
  },
  TipsType_20094_Desc = {
    Text = "Gute Attribute in den ursprünglichen Nebenattributen werden nicht gespeichert. Ersetzen bestätigen?"
  },
  TipsType_20094_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20094_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20094_Title = {
    Text = "Bestätigung des Wechsels"
  },
  TipsType_20095_Desc = {
    Text = "Gute Nebenattribute vorhanden, Fortsetzen wird nicht gespeichert. Bestätigen?"
  },
  TipsType_20095_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20095_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20095_Title = {
    Text = "Transkriptionsbestätigung"
  },
  TipsType_20096_Desc = {
    Text = "Nach dem Upgrade dieses Bündnisses wird das Leveloberlimit überschritten, und nach der Überschreitung werden die Transkriptionsmaterialien zurückgegeben. Bestätigen?"
  },
  TipsType_20096_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20096_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20096_Title = {
    Text = "Upgrade-Bestätigung"
  },
  TipsType_20097_Desc = {
    Text = "Dieser Erweckte Körper hat das vollständige Erwachen erreicht.\nNach der Auswahl erhältst du nur noch „Seelenrückspulfragment\" ×1"
  },
  TipsType_20097_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20097_RightBtnDesc = {Text = "Weiter"},
  TipsType_20097_Title = {
    Text = "Auswahl bestätigen"
  },
  TipsType_20098_Desc = {
    Text = "Dieser Artikel kann mit <Blue:{s1}> Silberzertifikaten gekauft werden"
  },
  TipsType_20098_LeftBtnDesc = {Text = "Barzahlung"},
  TipsType_20098_RightBtnDesc = {
    Text = "Belegzahlung"
  },
  TipsType_20098_Title = {
    Text = "Abrechnungsart wählen"
  },
  TipsType_20099_Desc = {
    Text = "Möchtest du das Spiel beenden?"
  },
  TipsType_20099_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20099_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20099_Title = {Text = "Hinweis"},
  TipsType_20100_Desc = {
    Text = "Neue Spielversion erkannt, bitte Spiel neu starten, um Ressourcen zu aktualisieren"
  },
  TipsType_20100_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20100_Title = {
    Text = "Update-Hinweis"
  },
  TipsType_20101_Desc = {
    Text = "Diese Untersuchung ist abgeschlossen, erneut untersuchen und die Handlung überspringen?"
  },
  TipsType_20101_LeftBtnDesc = {
    Text = "Szene überspringen"
  },
  TipsType_20101_RightBtnDesc = {
    Text = "Handlung beibehalten"
  },
  TipsType_20101_Title = {
    Text = "Handlungsbestätigung"
  },
  TipsType_20102_Desc = {
    Text = "Möchtest du {s1} nicht mehr folgen?"
  },
  TipsType_20102_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20102_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20102_Title = {Text = "Entfolgen"},
  TipsType_20103_Desc = {
    Text = "Event-Zeitraum<WeaponEffect_Num:Kostenlos>freischalten, freischalten?"
  },
  TipsType_20103_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20103_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20103_Title = {
    Text = "Aktivitätsleistungen"
  },
  TipsType_20105_Desc = {
    Text = "Um das beste Handlungserlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_20105_LeftBtnDesc = {Text = "Beenden"},
  TipsType_20105_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_20105_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20106_Desc = {
    Text = "<Blue:„Silberkernquellflüssigkeit\" × {s1} > ausgeben, um zu kaufen?"
  },
  TipsType_20106_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20106_RightBtnDesc = {Text = "Kaufen"},
  TipsType_20106_Title = {
    Text = "Kauf bestätigen"
  },
  TipsType_20107_Desc = {
    Text = "Bist du sicher, dass du <Blue:{s1}> auswählen möchtest?"
  },
  TipsType_20107_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20107_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20107_Title = {
    Text = "Wähle Bestätigung"
  },
  TipsType_20108_Desc = {
    Text = "Diese Stapelung verbraucht das seltene Element „Schleifenmeister“ \n Möchten Sie fortfahren?"
  },
  TipsType_20108_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20108_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20108_Title = {
    Text = "Verbrauchsbestätigung"
  },
  TipsType_20109_Desc = {
    Text = "Möchten Sie diesen Kampf wirklich neu starten?"
  },
  TipsType_20109_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20109_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20109_Title = {
    Text = "Wiederkampf"
  },
  TipsType_20110_Desc = {
    Text = "Bestätigen Sie den {s1}.{s2}. als Ihren Geburtstag?\nNach der Bestätigung kann er nicht mehr geändert werden"
  },
  TipsType_20110_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20110_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20110_Title = {
    Text = "Geburtstagsbestätigung"
  },
  TipsType_20111_Desc = {
    Text = "Um das beste erzählerische Erlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_20111_LeftBtnDesc = {Text = "Beenden"},
  TipsType_20111_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_20111_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20112_Desc = {
    Text = "Um das beste Handlungserlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_20112_LeftBtnDesc = {Text = "Beenden"},
  TipsType_20112_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_20112_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20113_Desc = {
    Text = "Möchtest du alle erhaltenen Lehrinhalte als gelesen markieren und die Belohnungen abholen? (Neue Wächter sollten die Lehrinhalte sorgfältig lesen~)"
  },
  TipsType_20113_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20113_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20113_Title = {
    Text = "Ein-Klick-Lesebestätigung"
  },
  TipsType_20114_Desc = {
    Text = "Bestätigen Sie die Auswahl von <WeaponEffect_Num:{s1}> für den Rückblick?\nDieser Vorgang kann nicht rückgängig gemacht werden, bitte sorgfältig bestätigen"
  },
  TipsType_20114_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20114_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20114_Title = {
    Text = "Rückverfolgungsauswahl"
  },
  TipsType_201151_Desc = {
    Text = "Der aktuelle Erwachungskörper verfügt über keine Aktivierung und benötigt daher keine Aktivierungsrückspulung"
  },
  TipsType_20115_Desc = {
    Text = "Aktueller Erwachter wurde nicht entwickelt, keine Rückverfolgung erforderlich"
  },
  TipsType_20116_Desc = {
    Text = "<WeaponEffect_Num:{s1}>Rückverfolgung aktiviert.\nSofort zur Rückverfolgung gehen?"
  },
  TipsType_20116_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20116_RightBtnDesc = {Text = "Gehe zu"},
  TipsType_20116_Title = {
    Text = "Erfolgreich aktiviert"
  },
  TipsType_20117_Desc = {
    Text = "Der Status der Verbesserung, des Aufstiegs, der Fähigkeit, des Talents und der Wissensvertiefung des Erwachenskörpers wird zurückgesetzt, und die entsprechenden Kosten werden erstattet. \nMöchten Sie wirklich die “Entwicklungs-Rückspulung“ für <WeaponEffect_Num:{s1}> durchführen?\n\n?"
  },
  TipsType_20117_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20117_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20117_Title = {
    Text = "Entwicklungsrücksetzung"
  },
  TipsType_20118_Desc = {
    Text = "Die Erleuchtungsstufen des Erweckers werden zurückgesetzt und die Erleuchtungskosten zurückgegeben.\nMöchten Sie <WeaponEffect_Num:{s1}> zur Erleuchtung zurückverfolgen?"
  },
  TipsType_20118_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20118_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20118_Title = {
    Text = "Erleuchtungsrücksetzung"
  },
  TipsType_20119_Desc = {
    Text = "Der Status des Erweckers bezüglich Aufstieg, Aufwertung, Fähigkeiten, Erwachen, Talenten und Gnostischem Fortschritt wird zurückgesetzt, und die entsprechenden Kosten werden erstattet. \n Der Erwecker wird zur schwarzen Pfütze zurückgebracht. \n Möchten Sie <WeaponEffect_Num:{s1}> zur schwarzen Pfütze zurückgeben?"
  },
  TipsType_20119_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20119_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20119_Title = {
    Text = "Genesis-Rückkehr"
  },
  TipsType_20120_Desc = {
    Text = "Spezialerweckung nicht rückgabefähig"
  },
  TipsType_20121_Desc = {
    Text = "Wird den Zustand des Schicksalsrads zurücksetzen und alle verbrauchten Stapel zurückgeben.\nBestätigen Sie die Rücksetzung für <WeaponEffect_Num:{s1}>?"
  },
  TipsType_20121_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20121_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20121_Title = {
    Text = "Stapel-Rückverfolgung"
  },
  TipsType_20122_Desc = {
    Text = "Die Stapelstatus des Rad des Schicksals werden zurückgesetzt, alle Stapelkosten zurückgegeben, und das Rad wird zur schwarzen Pfütze zurückgebracht.\nMöchten Sie <WeaponEffect_Num:{s1}> zur schwarzen Pfütze zurückgeben?"
  },
  TipsType_20122_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20122_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20122_Title = {
    Text = "Genesis-Rückkehr"
  },
  TipsType_20123_Desc = {
    Text = "Nach Abschluss der Herausforderung können die Erweckungskörper, Schicksalsräder und Schlüssel im Team nicht in anderen Katastrophenzonen eingesetzt werden. Bestätigen?"
  },
  TipsType_20123_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20123_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20123_Title = {
    Text = "Herausforderung bestätigen"
  },
  TipsType_20124_Desc = {
    Text = "Nach dem Zurücksetzen können die Erwachten, Schicksalsräder und Schlüsselbefehle des aktuellen Erkundungsteams erneut eingesetzt werden, aber die durch das Level erhaltenen Trainingspunkte werden abgezogen (Belohnungsstatus bleibt unverändert). Zurücksetzen bestätigen?"
  },
  TipsType_20124_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20124_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20124_Title = {
    Text = "Bestätigung des Zurücksetzens"
  },
  TipsType_20125_Desc = {
    Text = "Aktuelle Stapelstufe des Schicksalsrads ist 0, keine Rückverfolgung erforderlich"
  },
  TipsType_20126_Desc = {
    Text = "Der aktuelle Erwecker wird gerade entsandt, bitte rufe ihn zurück, bevor du zurückverfolgst oder zurückgibst"
  },
  TipsType_20127_Desc = {
    Text = "Schicksalsrad gesperrt, vor der Rückgabe entsperren"
  },
  TipsType_20128_Desc = {
    Text = "{s1} ist abgeschlossen, Rücksetzung erforderlich für neuen Versuch. Bestätigen?\n(Nach der Rücksetzung können Erwachter, Schicksalsrad und Schlüsselbefehl erneut eingesetzt werden, aber erhaltene Trainingspunkte werden abgezogen.)"
  },
  TipsType_20128_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20128_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20128_Title = {
    Text = "Bestätigung des Zurücksetzens"
  },
  TipsType_20129_Desc = {
    Text = "Um das beste Handlungserlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_20129_LeftBtnDesc = {Text = "Beenden"},
  TipsType_20129_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_20129_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20130_Desc = {
    Text = "Um das beste Handlungserlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_20130_LeftBtnDesc = {Text = "Beenden"},
  TipsType_20130_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_20130_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20131_Desc = {
    Text = "Um das beste Handlungserlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_20131_LeftBtnDesc = {Text = "Beenden"},
  TipsType_20131_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_20131_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20132_Desc = {
    Text = "Sind die <TipsHighlightText:Bündnis-Reste> ausreichend, so priorisiere die Nutzung der Reste.\nSind die Reste unzureichend, wird automatisch <TipsHighlightText:“{s1}“> zur Auffüllung der Reste verbraucht"
  },
  TipsType_20132_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20132_RightBtnDesc = {
    Text = "Immer noch auswählen"
  },
  TipsType_20132_Title = {
    Text = "Automatische Ergänzung"
  },
  TipsType_20133_Desc = {
    Text = "Möchtest du <TipsHighlightText:„{s1}“> vertiefen?"
  },
  TipsType_20133_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20133_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20133_Title = {
    Text = "Gnostischer Fortschritt"
  },
  TipsType_20134_Desc = {
    Text = "Um das beste Handlungserlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungslevel abzuschließen."
  },
  TipsType_20134_LeftBtnDesc = {Text = "Beenden"},
  TipsType_20134_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_20134_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20137_Desc = {
    Text = "Möchtest du den Verbrauch von <Blue:\"{s1}\"×{s2}> bestätigen, um diesen Titel freizuschalten?"
  },
  TipsType_20137_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20137_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20137_Title = {
    Text = "Bestätigung freischalten"
  },
  TipsType_20138_Desc = {
    Text = "Event-Zeitraum <Blue:Kostenlos> freischalten, freischalten?"
  },
  TipsType_20138_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20138_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20138_Title = {
    Text = "Bestätigung freischalten"
  },
  TipsType_20139_Desc = {
    Text = "Möchtest du wirklich <Blue:\"{s1}\"×{s3}> ausgeben, um <Blue:\"{s2}\"> freizuschalten?"
  },
  TipsType_20139_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20139_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20139_Title = {
    Text = "Bestätigung freischalten"
  },
  TipsType_20140_Desc = {
    Text = "<Blue:\"{s1}\">Sie haben das maximale Limit erreicht. Das Beantragen von mehr wird keine zusätzlichen Gegenstände gewähren. Möchten Sie fortfahren?"
  },
  TipsType_20140_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20140_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20140_Title = {
    Text = "Abholbestätigung"
  },
  TipsType_20141_Desc = {
    Text = "Möchten Sie 30% der maximalen Gesundheit({s1}) opfern, um den Kampf zu überspringen und den Gegner sofort zu besiegen?\n\nAktuelle Gesundheit:{s2}"
  },
  TipsType_20141_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20141_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20141_Title = {
    Text = "Muskelgedächtnis"
  },
  TipsType_20142_Desc = {
    Text = "Möchtest du <color=#BB646D> {s1} </color> Lebenspunkte verlieren und {s2} schwarze Siegel erhalten?"
  },
  TipsType_20142_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20142_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20142_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20145_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20145_Title = {
    Text = "Anmeldebelohnung"
  },
  TipsType_20151_Desc = {
    Text = "Nach dem Zurücksetzen wird die verbleibende Menge der “Spezialgegenstände“ auf das Maximum zurückgesetzt, bestätigen?"
  },
  TipsType_20151_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20151_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20151_Title = {
    Text = "Bestätigung des Zurücksetzens"
  },
  TipsType_20152_Desc = {
    Text = "{s1} unzureichend, möchten Sie die Rosenblume *{s2} verwenden, um dies auszugleichen?"
  },
  TipsType_20152_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20152_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20152_Title = {
    Text = "Aktivierungsbestätigung"
  },
  TipsType_20153_Desc = {
    Text = "Nach dem Zurücksetzen werden die verbleibenden Mengen von „Spezialgegenständen“ und „Normalgegenständen“ auf das Maximum zurückgesetzt. \nAb dem {s1}. Mal wird „Spezialgegenstand“ nicht mehr zurückgesetzt. \nBestätigen?"
  },
  TipsType_20153_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20153_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20153_Title = {
    Text = "Bestätigung des Zurücksetzens"
  },
  TipsType_20154_Desc = {
    Text = "Nach dem Zurücksetzen wird die verbleibende Menge von „Spezialgegenständen“ und „Normalgegenständen“ auf das Maximum zurückgesetzt.\nAb dem 3. Mal werden „Spezialgegenstände“ nicht mehr zurückgesetzt.\n <Blue:Derzeit gibt es noch „Normalgegenstände“>, bestätigen?"
  },
  TipsType_20154_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20154_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20154_Title = {
    Text = "Bestätigung des Zurücksetzens"
  },
  TipsType_20155_Desc = {
    Text = "Stapelmaterialien enthalten gesperrte Lebensräder, Verbrauch bestätigen?"
  },
  TipsType_20155_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20155_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20155_Title = {
    Text = "Stapel-Bestätigung"
  },
  TipsType_20156_Desc = {
    Text = "Möchten Sie bestätigen, dass Sie <TipsHighlightText:Realitätsanfang*1> zum Entsperren verbrauchen?\n(Während des Verlangenswelle-Events wird die Anzahl der Realitätsanfänge, die zum Entsperren benötigt werden, von {s1} auf {s2} reduziert.)"
  },
  TipsType_20156_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20156_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20156_Title = {
    Text = "Bestätigung freischalten"
  },
  TipsType_20157_Desc = {
    Text = "Möchten Sie bestätigen, dass Sie <TipsHighlightText:Realitätsanfang*{s1}> zum Entsperren verbrauchen?"
  },
  TipsType_20157_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20157_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20157_Title = {
    Text = "Bestätigung freischalten"
  },
  TipsType_20158_Desc = {
    Text = "Aktuelle Stufe abgelaufen, keine Belohnung nach Abschluss. Möchtest du trotzdem beenden?"
  },
  TipsType_20158_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20158_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20158_Title = {
    Text = "Beenden bestätigen"
  },
  TipsType_20159_Desc = {
    Text = "<TipsHighlightText:„{s1}\"> hat das Limit um <TipsHighlightText: {s2}> überschritten, jedes wurde in <Blue:„Einladung des Formlosen\" × 1> umgewandelt"
  },
  TipsType_20159_Title = {
    Text = "Konvertierungshinweis"
  },
  TipsType_20160_Desc = {
    Text = "Sie haben <TipsHighlightText:“{s1}“> freigeschaltet.\nDie kostenlosen Freischaltvorteile dieser Aktion bieten Ihnen folgende Belohnung."
  },
  TipsType_20160_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20160_Title = {
    Text = "Kompensationshinweis"
  },
  TipsType_20161_Desc = {
    Text = "<TipsHighlightText:„{s1}“> überschritten, <TipsHighlightText: {s2}> Stück, jedes wurde in <Blue:„Rosenskript“× 5000> umgewandelt"
  },
  TipsType_20161_Title = {
    Text = "Konvertierungshinweis"
  },
  TipsType_20162_Desc = {
    Text = "Der Status der Verbesserung, des Aufstiegs, der Fähigkeit, des Talents und der Wissensvertiefung des Erwachenskörpers wird zurückgesetzt, und die entsprechenden Kosten werden erstattet. \nMöchten Sie wirklich die “Entwicklungs-Rückspulung“ für <WeaponEffect_Num:{s1}> durchführen?\n\n?"
  },
  TipsType_20162_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20162_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20162_Title = {
    Text = "Entwicklungsrücksetzung"
  },
  TipsType_20163_Desc = {
    Text = "Der Status des Erwachungskörpers wird zurückgesetzt und die entsprechenden Kosten erstattet. \nMöchten Sie wirklich die „Entwicklungs-Rückspulung“ für <WeaponEffect_Num:{s1}> durchführen?"
  },
  TipsType_20163_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20163_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20163_Title = {
    Text = "Erleuchtungsrücksetzung"
  },
  TipsType_20164_Desc = {
    Text = "Der Status der Verbesserung, des Aufstiegs, der Fähigkeiten, des Talents, der Erweckung und des Gnostischen Fortschritts des Erwachungskörpers wird zurückgesetzt, und die entsprechenden Kosten werden erstattet. \n Außerdem wird der Erwachungskörper zur schwarzen Pfütze zurückgebracht. \n Möchten Sie <WeaponEffect_Num:{s1}> zur schwarzen Pfütze zurückgeben?"
  },
  TipsType_20164_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20164_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20164_Title = {
    Text = "Genesis-Rückkehr"
  },
  TipsType_20165_Desc = {
    Text = "<WeaponEffect_Num:{s1}> gehört zu einem speziellen Erwachungskörper und kann nur für die Rückverfolgung von Aufstieg, Verbesserung, Fähigkeiten, Talenten und Gnostischem Fortschritt verwendet werden. <Red: Geistige Entwicklung kann nicht zurückverfolgt werden> Möchten Sie <WeaponEffect_Num:{s1}> zur Rückverfolgung aktivieren? \n Dieser Vorgang kann nicht rückgängig gemacht werden, bitte sorgfältig bestätigen"
  },
  TipsType_20165_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20165_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20165_Title = {
    Text = "Rückverfolgungsauswahl"
  },
  TipsType_20166_Desc = {
    Text = "Spezieller Erwachungskörper kann nicht für eine Geisterwiederherstellung verwendet werden"
  },
  TipsType_20167_Desc = {
    Text = "Diese Rückspulung hat bereits “Entwicklungs-Rückspulung“ verwendet. Bitte führen Sie “Entwicklungs-Rückspulung“ beim nächsten Rückspulungsstart durch."
  },
  TipsType_20168_Desc = {
    Text = "Diese Rückspulung hat bereits “Erleuchten-Rückspulung“ verwendet. Bitte führen Sie “Erleuchten-Rückspulung“ erst bei der nächsten Rückspulung durch."
  },
  TipsType_20169_BottomDesc = {
    Text = "<Blue:Beachten: Diese Aktivität kann nach der Auswahl nicht mehr geändert werden!>"
  },
  TipsType_20169_Desc = {
    Text = "Möchten Sie wirklich den Erwachenskörper <OrangeQuality:“{s1}“> und das empfohlene Schicksalsrad <OrangeQuality:“{s2}“> als Ziel des UP-Events dieser Runde auswählen?"
  },
  TipsType_20169_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20169_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20169_Title = {
    Text = "Auswahl bestätigen"
  },
  TipsType_20170_Desc = {
    Text = "Tägliches Herausforderungslimit erreicht. Bitte versuche es morgen erneut!"
  },
  TipsType_20171_Desc = {
    Text = "Jetzt kannst du zum „Phantasmagorischen Tauchgang“ gehen!"
  },
  TipsType_20173_Desc = {
    Text = "Jetzt kannst du dich in die „Traphase“ begeben!"
  },
  TipsType_20174_Desc = {
    Text = "Jetzt kannst du “Ermittlungsaktion – Schwierig“ betreten!"
  },
  TipsType_20175_Desc = {
    Text = "Jetzt kannst du dich dem «transzendenten Sein» nähern!"
  },
  TipsType_20176_Desc = {
    Text = "Jetzt kannst du das “Sperrgebiet der Katastrophenverschmelzung“ betreten!"
  },
  TipsType_20177_Desc = {
    Text = "Jetzt kannst du dich dem “Frenzy der Fortpflanzung“ anschließen!"
  },
  TipsType_20178_Desc = {
    Text = "Jetzt kannst du das “zweite Schicksalsrad“ ausrüsten!"
  },
  TipsType_20179_Desc = {
    Text = "\"Chaos-Cluster\" ist freigeschaltet!"
  },
  TipsType_20180_Desc = {
    Text = "Jetzt kannst du das “Tabu-Kompendium“ betreten!"
  },
  TipsType_20181_Desc = {
    Text = "Jetzt kannst du das “Geheime Upgrade“ durchführen!"
  },
  TipsType_20182_Desc = {
    Text = "Jetzt kannst du dich zum «geheimen Transkript» begeben!"
  },
  TipsType_20183_Desc = {
    Text = "Die aktuelle Aktion ist abgeschlossen"
  },
  TipsType_20184_Desc = {
    Text = "„Notizen\" ist freigeschaltet!"
  },
  TipsType_20185_Desc = {
    Text = "Möchten Sie alle Szenen dieses Abschnitts überspringen?"
  },
  TipsType_20185_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20185_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20185_Title = {
    Text = "Szene überspringen"
  },
  TipsType_20186_Desc = {
    Text = "Es werden die erforderlichen Daten für das Spiel heruntergeladen. \nWeiter? \n\n*Es wird empfohlen, die Daten im WLAN-Netzwerk herunterzuladen."
  },
  TipsType_20186_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20186_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20187_Desc = {
    Text = "Ressourcen wurden heruntergeladen"
  },
  TipsType_20187_LeftBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20188_Desc = {
    Text = "Speicherplatz nicht ausreichend. Mindestens {s1} Speicherplatz muss reserviert werden, andernfalls kann es zum Verlust von Ressourcen während der Laufzeit kommen. Fortsetzen des Downloads?"
  },
  TipsType_20188_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20188_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20189_Desc = {
    Text = "Ressourcen-Download fehlgeschlagen, erneut versuchen?"
  },
  TipsType_20189_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20189_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20190_Desc = {
    Text = "<TipsHighlightText:{s1}> überschritten, <TipsHighlightText: {s2} > Stück, jedes wurde in <Blue:{s3}>"
  },
  TipsType_20190_Title = {
    Text = "Konvertierungshinweis"
  },
  TipsType_20191_Desc = {
    Text = "Jetzt kannst du zum “Event“ gehen!"
  },
  TipsType_20192_Desc = {
    Text = "Es werden die erforderlichen Daten für die nachfolgenden Inhalte des Prologs heruntergeladen.\nRessourcengröße: {s1}\nWeiter?\n\n*Es wird empfohlen, die Daten im WLAN-Netzwerk herunterzuladen."
  },
  TipsType_20192_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20192_RightBtnDesc = {
    Text = "Herunterladen"
  },
  TipsType_20193_Desc = {
    Text = "Jetzt kannst du dich zum “Einsatz“ begeben!"
  },
  TipsType_20194_Desc = {
    Text = "Jetzt kannst du zur “Silberkern-Kommunikation“ gehen!"
  },
  TipsType_20195_Desc = {
    Text = "„Themenprotokoll\" ist jetzt verfügbar!"
  },
  TipsType_20196_Desc = {
    Text = "Du kannst nun in das \"Lichtlose Reich\" eintreten!"
  },
  TipsType_20197_Desc = {
    Text = "Maximale Anzahl an Weckvorgängen erreicht. Bitte begib dich zur Aufgabenbelohnung!"
  },
  TipsType_20198_Desc = {
    Text = "Aufgabe noch nicht abgeschlossen. Bitte schließen Sie die Aufgabe ab, bevor Sie die Belohnung abholen!"
  },
  TipsType_20199_Desc = {
    Text = "Nach dem Abholen wird der Agentenbeweis das Limit überschreiten,\nder überschüssige Teil wird nicht erhalten.\nMöchten Sie fortfahren?"
  },
  TipsType_20199_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20199_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20199_Title = {
    Text = "Abholbestätigung"
  },
  TipsType_20200_Desc = {
    Text = "Bestätigen Sie den Verbrauch von <Blue:Agentenbeweis*1>, um die tägliche Aufgabe sofort abzuschließen?"
  },
  TipsType_20200_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20200_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20200_Title = {
    Text = "Stellvertreter-Bestätigung"
  },
  TipsType_20201_Desc = {
    Text = "Die folgenden Bündnisse werden eingekleidet. Soll eine Ersetzung vorgenommen werden?"
  },
  TipsType_20201_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20201_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20201_Title = {
    Text = "Bestätigung des Wechsels"
  },
  TipsType_20202_Desc = {
    Text = "Plan auf {s1} angewendet, Plan [{s2}] löschen?"
  },
  TipsType_20202_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20202_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20202_Title = {
    Text = "Löschbestätigung"
  },
  TipsType_20203_Desc = {
    Text = "Gleiche Schicksalsräder im Team, Effekt kann nicht mehrfach wirken, {s1} bereits ausgerüstet, trotzdem ausrüsten?"
  },
  TipsType_20203_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20203_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20203_Title = {
    Text = "Ausrüstung bestätigen"
  },
  TipsType_20204_Desc = {
    Text = "Das aktuelle Bündnis wurde in {s1} verwendet, nach dem Zerlegen wird es aus diesem Plan entfernt, möchtest du dies bestätigen?"
  },
  TipsType_20204_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20204_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20204_Title = {
    Text = "Löschbestätigung"
  },
  TipsType_20205_Desc = {
    Text = "Das aktuelle Bündnis wurde in der Aufstellung {s1} verwendet, nach dem Zerlegen wird dieses Bündnis entfernt, möchtest du dies bestätigen?"
  },
  TipsType_20205_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20205_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20205_Title = {
    Text = "Löschbestätigung"
  },
  TipsType_20206_Desc = {
    Text = "Das aktuelle Schicksalsrad wurde bereits in der Aufstellung {s1} verwendet, nach dem Zerlegen wird dieses Schicksalsrad von der Aufstellung entfernt, möchtest du dies bestätigen?"
  },
  TipsType_20206_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20206_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20206_Title = {
    Text = "Löschbestätigung"
  },
  TipsType_20207_Desc = {
    Text = "Plan nicht gespeichert, Änderungen gehen verloren. Bestätigen?"
  },
  TipsType_20207_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20207_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20207_Title = {
    Text = "Speicherbestätigung"
  },
  TipsType_20208_Desc = {
    Text = "Die Aufgabenbelohnung wurde bereits abgeholt. Schauen Sie sich andere Aufgaben an!"
  },
  TipsType_20209_Desc = {
    Text = "Aufgabe ist abgelaufen"
  },
  TipsType_20210_Desc = {
    Text = "Um das beste Handlungserlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_20210_LeftBtnDesc = {Text = "Beenden"},
  TipsType_20210_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_20210_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20211_Desc = {
    Text = "{s1} Tage {s2} Stunden bis zur Öffnung"
  },
  TipsType_20212_Desc = {
    Text = "{s1} Stunden {s2} Minuten bis zur Öffnung"
  },
  TipsType_20213_Desc = {
    Text = "<WeaponEffect_Num:{s1}>Hat die überschrittene Kausalität in der Formation ausgelöst. Jede Rückverfolgung führt zur Deaktivierung der überschrittenen Kausalität und wird automatisch aus der Formation entfernt. Möchten Sie wirklich <WeaponEffect_Num:{s1}> zur Rückverfolgung aktivieren? \nDieser Vorgang kann nicht rückgängig gemacht werden, bitte sorgfältig bestätigen"
  },
  TipsType_20213_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20213_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20213_Title = {
    Text = "Rückverfolgungsauswahl"
  },
  TipsType_20214_Desc = {
    Text = "Wird den Zustand des Schicksalsrads zurücksetzen und alle verbrauchten Stapel zurückgeben. \n<WeaponEffect_Num:{s1}> hat die Übergrenze der Kausalität in der Formation ausgelöst, nach der Rückverfolgung wird es automatisch aus der Formation entfernt. \nMöchten Sie wirklich die Rückverfolgung für <WeaponEffect_Num:{s1}> durchführen?"
  },
  TipsType_20214_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20214_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20214_Title = {
    Text = "Stapel-Rückverfolgung"
  },
  TipsType_20215_Desc = {
    Text = "Die Stapelposition des Schicksalsrads wird zurückgesetzt, alle Stapelkosten werden zurückgegeben und das Rad wird zur Genesis-Rückkehr zurückgebracht.\n<WeaponEffect_Num:{s1}> hat in der Formation ein Überlimit verursacht, nach der Rückgabe wird es automatisch aus der Formation entfernt.\nMöchten Sie <WeaponEffect_Num:{s1}> zur Genesis-Rückkehr zurückgeben?"
  },
  TipsType_20215_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20215_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20215_Title = {
    Text = "Genesis-Rückkehr"
  },
  TipsType_20216_Desc = {
    Text = "Möchtest du <Blue:{s1} × {s2}> ausgeben, um zu kaufen?"
  },
  TipsType_20216_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20216_RightBtnDesc = {Text = "Kaufen"},
  TipsType_20216_Title = {
    Text = "Kauf bestätigen"
  },
  TipsType_20217_Desc = {
    Text = "{s1} wird nach {s2} aktiviert."
  },
  TipsType_20218_Desc = {
    Text = "Die vorab ausgewählten Erwachten dieser Untersuchung können nicht ausgetauscht werden, sondern nur durch entsprechende Erwachte ersetzt werden."
  },
  TipsType_20219_Desc = {
    Text = "Es ist bereits ein identischer Erweckter im Einsatz, eine erneute Auswahl ist nicht möglich."
  },
  TipsType_20220_Desc = {
    Text = "Es wurde festgestellt, dass aktuell kein WLAN verwendet wird. Das Herunterladen verbraucht daher mehr mobile Daten. Möchten Sie den Download dennoch starten?\nRessourcengröße: {s1}\nWeiter fortfahren?"
  },
  TipsType_20220_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20220_RightBtnDesc = {
    Text = "Herunterladen"
  },
  TipsType_20221_Desc = {
    Text = "Ressourcen wurden heruntergeladen"
  },
  TipsType_20221_LeftBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20222_Desc = {
    Text = "Speicherplatz nicht ausreichend. Mindestens {s1} Speicherplatz muss reserviert werden, andernfalls kann es zum Verlust von Ressourcen während der Laufzeit kommen. Fortsetzen des Downloads?"
  },
  TipsType_20222_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20222_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20223_Desc = {
    Text = "Ressourcen-Download fehlgeschlagen, erneut versuchen?"
  },
  TipsType_20223_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20223_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20224_Desc = {
    Text = "Es werden die erforderlichen Daten für die nachfolgenden Inhalte des Prologs heruntergeladen.\nRessourcengröße: {s1}\nWeiter?\n\n*Es wird empfohlen, die Daten im WLAN-Netzwerk herunterzuladen."
  },
  TipsType_20224_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20224_RightBtnDesc = {
    Text = "Herunterladen"
  },
  TipsType_20225_Desc = {
    Text = "{s1} ist abgeschlossen. Zusätzliche Herausforderung starten?\nBei zusätzlichen Herausforderungen können {s2} Trainingspunkte erhalten werden."
  },
  TipsType_20225_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20225_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20225_Title = {
    Text = "Zusätzliche Herausforderung"
  },
  TipsType_20226_Desc = {
    Text = "Nach dem Zurücksetzen können die Erwachten, Schlüsselbefehle und Schicksalsräder des Teams erneut eingesetzt werden, aber die durch den zusätzlichen Durchgang der Stufe erhaltenen Trainingspunkte werden abgezogen (Belohnungsstatus bleibt unverändert). Zurücksetzen bestätigen?"
  },
  TipsType_20226_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20226_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20226_Title = {
    Text = "Bestätigung des Zurücksetzens"
  },
  TipsType_20227_Desc = {
    Text = "Nach dem Zurücksetzen können die Erwachten, Schlüsselbefehle und Schicksalsräder des aktuellen Erkundungsteams erneut eingesetzt werden, und das zusätzliche Herausforderungs-Team ersetzt das aktuelle Erkundungsteam. Allerdings werden die durch den zusätzlichen Durchgang der Stufe erhaltenen Trainingspunkte abgezogen (Belohnungsstatus bleibt unverändert). Möchten Sie das Zurücksetzen bestätigen?"
  },
  TipsType_20227_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20227_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20227_Title = {
    Text = "Bestätigung des Zurücksetzens"
  },
  TipsType_20228_Desc = {
    Text = "Nach unten scrollen, um weitere Ankündigungen zu sehen"
  },
  TipsType_20229_Desc = {
    Text = "“<Blue:{s1}>“ hat das maximale Stapel-Level erreicht\nMöchten Sie den Kauf fortsetzen?"
  },
  TipsType_20229_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20229_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20229_Title = {
    Text = "Kauf bestätigen"
  },
  TipsType_20230_Desc = {
    Text = "Um das beste Handlungserlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_20230_LeftBtnDesc = {Text = "Beenden"},
  TipsType_20230_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_20230_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20231_Desc = {
    Text = "Um das beste Handlungserlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_20231_LeftBtnDesc = {Text = "Beenden"},
  TipsType_20231_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_20231_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20232_Desc = {
    Text = "Um das beste Handlungserlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_20232_LeftBtnDesc = {Text = "Beenden"},
  TipsType_20232_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_20232_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20233_Desc = {
    Text = "Es fehlen benötigte Materialien. Sollen die folgenden Materialien verbraucht werden, um den Mangel zu decken?"
  },
  TipsType_20233_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20233_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20233_Title = {
    Text = "Ergänzung bestätigen"
  },
  TipsType_20234_Desc = {
    Text = "In diesem Level können ausschließlich zugewiesene Schlüsselbefehle ausgerüstet werden. Ein Austausch ist nicht möglich."
  },
  TipsType_20235_Desc = {
    Text = "Um das beste Handlungserlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_20235_LeftBtnDesc = {Text = "Beenden"},
  TipsType_20235_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_20235_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20236_Desc = {
    Text = "Um das beste erzählerische Erlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_20236_LeftBtnDesc = {Text = "Beenden"},
  TipsType_20236_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_20236_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20237_Desc = {
    Text = "Um das beste Handlungserlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_20237_LeftBtnDesc = {Text = "Beenden"},
  TipsType_20237_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_20237_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20238_Desc = {
    Text = "Um das beste erzählerische Erlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_20238_LeftBtnDesc = {Text = "Beenden"},
  TipsType_20238_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_20238_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20239_Desc = {
    Text = "Um das beste erzählerische Erlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_20239_LeftBtnDesc = {Text = "Beenden"},
  TipsType_20239_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_20239_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20240_Desc = {
    Text = "Reparatur abgeschlossen, bitte das Spiel neu starten"
  },
  TipsType_20240_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20240_Title = {Text = "Hinweis"},
  TipsType_20241_Desc = {
    Text = "Es werden noch {s1} “<Blue:{s2}>“ benötigt, um das maximale Stapel-Level zu erreichen.\nMöchten Sie den Kauf fortsetzen?"
  },
  TipsType_20241_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20241_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20241_Title = {
    Text = "Kauf bestätigen"
  },
  TipsType_20250_Desc = {
    Text = "Um das beste erzählerische Erlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_20250_LeftBtnDesc = {Text = "Beenden"},
  TipsType_20250_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_20250_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20251_Desc = {
    Text = "Um das beste erzählerische Erlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_20251_LeftBtnDesc = {Text = "Beenden"},
  TipsType_20251_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_20251_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20252_Desc = {
    Text = "Um das beste Handlungserlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_20252_LeftBtnDesc = {Text = "Beenden"},
  TipsType_20252_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_20252_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20259_Desc = {
    Text = "Einstellung für den Austausch wurde gespeichert, falls nicht genügend „Siegel der tausend Gesichter“ vorhanden sind"
  },
  TipsType_20300_Desc = {
    Text = "{s1} Erwachen lokalisiert, kann nicht im selben Team verwendet werden"
  },
  TipsType_20301_Desc = {
    Text = "Jetzt kannst du dich zur “täglichen Aufgabe“ begeben!"
  },
  TipsType_20351_Desc = {
    Text = "{s1} nicht ausreichend, {s2}{s3} verwenden, um {s4}{s5} einzutauschen"
  },
  TipsType_20351_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20351_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20351_Title = {
    Text = "{s1} unzureichend"
  },
  TipsType_20352_Desc = {
    Text = "Sie werden nun mit der anderen Partei verbunden. Nach der Bindung ist eine Entbindung nicht mehr möglich. Wollen Sie die Bindung wirklich fortsetzen?"
  },
  TipsType_20352_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20352_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20352_Title = {
    Text = "Einladung bestätigen"
  },
  TipsType_20353_Desc = {
    Text = "Einladungscode wurde in die Zwischenablage kopiert."
  },
  TipsType_20354_Desc = {
    Text = "Sie sind bereits die einladende Partei des anderen."
  },
  TipsType_20355_Desc = {
    Text = "Du kannst deinen eigenen Einladungscode nicht eingeben. Versuche, den Einladungscode eines anderen Geheimnishüters zu erhalten."
  },
  TipsType_20356_Desc = {
    Text = "Nochmal spielen, um die Prolog-Handlung und das Tutorial erneut zu erleben! \nBei der erneuten Wiedergabe sind alle Belohnungen nur zu Demonstrationszwecken und können nicht tatsächlich erhalten werden. \nBestätigen?"
  },
  TipsType_20356_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20356_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20356_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_20357_Desc = {
    Text = "Möchtest du diesem {s1} Geheimnisträger nicht mehr folgen?"
  },
  TipsType_20357_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20357_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20357_Title = {Text = "Entfolgen"},
  TipsType_20358_Desc = {
    Text = "Es gibt nicht bestätigte Entfolgen. Wenn Sie gehen, werden keine Änderungen gespeichert. Möchten Sie wirklich gehen?"
  },
  TipsType_20358_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20358_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20358_Title = {
    Text = "Beenden bestätigen"
  },
  TipsType_20400_Desc = {
    Text = "<WeaponEffect_Num:“{s1}“> nicht ausreichend, möchten Sie zum Austausch gehen?"
  },
  TipsType_20400_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_20400_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_20400_Title = {
    Text = "Nicht genügend Glücksgegenstände"
  },
  TipsType_300001_Desc = {
    Text = "“Silberglanz-Erwachen“bietet nur eine kostenlose Erweckungschance. Möchtest du sie wirklich nutzen?"
  },
  TipsType_300001_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_300001_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_300001_Title = {
    Text = "Erweckungsbestätigung"
  },
  TipsType_300002_Desc = {
    Text = "Möchtest du das Ergebnis dieser Erwachung bestätigen? Bei Bestätigung verbraucht dieses Erwachen einen kostenlosen 5-fachen Ziehungsversuch."
  },
  TipsType_300002_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_300002_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_300002_Title = {
    Text = "Erweckungsbestätigung"
  },
  TipsType_30001_Desc = {
    Text = "Seitliche Hinweise ohne Symbol"
  },
  TipsType_30003_Desc = {
    Text = "{s1} freigeschaltet"
  },
  TipsType_30004_Desc = {
    Text = "{s1} Fortgeschrittener Modus freigeschaltet"
  },
  TipsType_30005_Desc = {
    Text = "{s1} (hart) entsperrt"
  },
  TipsType_31000_Desc = {
    Text = "Möchten Sie dieses Geburtsdatum wirklich zur Verifikation verwenden? Das Geburtsdatum kann nach der Festlegung nicht mehr geändert werden!"
  },
  TipsType_31000_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_31000_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_31000_Title = {
    Text = "Altersverifikation"
  },
  TipsType_31001_Desc = {
    Text = "Diesen Monat wurden bereits <Blue:{s1}> Yuan aufgeladen. Das Limit beträgt <Blue:{s2}> Yuan. Bitte versuchen Sie es nächsten Monat erneut oder wählen Sie eine niedrigere Aufladestufe."
  },
  TipsType_31002_Desc = {
    Text = "Bitte schließen Sie zunächst die Altersverifikation ab"
  },
  TipsType_31003_Desc = {
    Text = "Der Silberschlüssel spürt eine tödliche Gefahr, möchtest du den Notfall-Gnosis-Körper aktivieren?\n(Wiederbelebung verbraucht 1 Notfall-Gnosis-Körper, der Notfall-Gnosis-Körper wird täglich um 9 Uhr automatisch einmal aufgefüllt, verbleibende Anzahl: {s1})\n<Blue:(Erste Wiederbelebung verbraucht keinen Notfall-Gnosis-Körper)>"
  },
  TipsType_31003_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_31003_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_31003_Title = {
    Text = "Wiederbelebung Bestätigung"
  },
  TipsType_31004_Desc = {
    Text = "Der Silberschlüssel spürt eine tödliche Gefahr, möchtest du den Notfall-Gnosis-Körper aktivieren?\n(Wiederbelebung verbraucht 1 Notfall-Gnosis-Körper, der Notfall-Gnosis-Körper wird täglich um 9 Uhr automatisch einmal aufgefüllt, verbleibende Anzahl: {s1})\n<Blue:(Erste Wiederbelebung verbraucht keinen Notfall-Gnosis-Körper)>"
  },
  TipsType_31004_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_31004_Title = {
    Text = "Wiederbelebung Bestätigung"
  },
  TipsType_40001_Desc = {
    Text = "Wenn das Leben auf 0 sinkt, wird die Untersuchung zwangsweise beendet."
  },
  TipsType_40001_Title = {Text = "LP"},
  TipsType_40002_Desc = {
    Text = "Die Bewegung auf der Karte und die Untersuchung von Ereignissen erzeugen geistigen Druck, der sich zu Symptomen bei den Hütern kumulieren kann. \n Bei jeder Bewegung um ein Feld erhöht sich der Druck um 10 Punkte. Bei jedem Erreichen von 100 Punkten erhält man 1 Symptom. \n Wenn der Druck 500 erreicht, werden bei jeder Bewegung um ein Feld 10% LP abgezogen."
  },
  TipsType_40002_Title = {Text = "Stress"},
  TipsType_40003_Desc = {
    Text = "Je höher das Einsatzlevel, desto schwieriger die Aufgaben, auch die durch den Einsatz erhaltenen Belohnungen steigen entsprechend"
  },
  TipsType_40003_Title = {
    Text = "Einsatzlevel"
  },
  TipsType_40004_Desc = {
    Text = "Die temporäre Kopie der ersten Befehlskarte, die jeder Runde gespielt wird, gelangt in den Hyperraum. \n Wenn der Hyperraum sein Limit erreicht, erhalte eine zusätzliche Hyperdimensionale Runde und behalte das Schild. \n Effekt der Reichsbeherrschung: Zu Beginn der Runde besteht die Möglichkeit, 1 “Einblick“ auf die Hand zu bekommen."
  },
  TipsType_40004_Title = {Text = "Hyperraum"},
  TipsType_40005_Desc = {
    Text = "Der Geheimnisträger kann durch Untersuchungen, Zwischenspiele und andere Herausforderungen sein Level erhöhen. Mehr Spielmodi werden nach und nach freigeschaltet, wenn der Geheimnisträger aufsteigt"
  },
  TipsType_40005_Title = {Text = "Level"},
  TipsType_40006_Desc = {
    Text = "Das Ausspielen von Befehlskarten erfordert die Ausgaben von Arithmetica. Am Ende der Runde werden keine verbleibenden Arithmetica behalten, zu Beginn der Runde wird die Arithmetica auf das Limit wiederhergestellt."
  },
  TipsType_40006_Title = {
    Text = "Arithmetica"
  },
  TipsType_40007_Desc = {
    Text = "Der Silberschlüssel nimmt eine Spur besonderer Energie wahr; auf der Karte könnten wertvolle Materialien verborgen sein"
  },
  TipsType_40007_Title = {
    Text = "Versteckte Materialien"
  },
  TipsType_40008_Desc = {
    Text = "Kann bei tödlicher Gefahr im Kampf aktiviert werden, verbraucht 1 Marke pro Aktivierung, stellt Leben und Wahnsinn des Hüters auf Maximum wieder her, erhält täglich um 9 Uhr 1 Marke"
  },
  TipsType_40008_Title = {
    Text = "Notfall-Gnosis-Körper"
  },
  TipsType_40009_Desc = {
    Text = "Das Ausspielen von Befehlskarten erfordert die Ausgaben von Arithmetica. Am Ende der Runde werden keine verbleibenden Arithmetica behalten, zu Beginn der Runde erhöht sich das Arithmetica-Limit um 1 und die Arithmetica wird auf das Limit wiederhergestellt. Aktuell ist die {s1}. Runde"
  },
  TipsType_40009_Title = {
    Text = "Arithmetica"
  },
  TipsType_AbyssChallengeResetTips_Desc = {
    Text = "Die Fusion des Unglücks-Sperrzone wurde zurückgesetzt. Die laufende Herausforderung wird sofort beendet."
  },
  TipsType_AbyssChallengeResetTips_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_AbyssChallengeResetTips_Title = {Text = "Hinweis"},
  TipsType_AbyssChallengeRevivalTips_Desc = {
    Text = "Silberschlüssel spürt eine tödliche Gefahr. Notfall-Gnosis-Körper aktivieren?\n(Wiederbelebung verbraucht 1 Notfall-Gnosis-Körper. Du erhältst täglich 1 um 9 Uhr.)"
  },
  TipsType_AbyssChallengeRevivalTips_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_AbyssChallengeRevivalTips_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_AbyssChallengeRevivalTips_Title = {
    Text = "Wiederbelebung Bestätigung"
  },
  TipsType_AcceptConfirm_Desc = {
    Text = "Möchtest du die Einladung von <Blue:{s1}> zu <Blue:{s2}> annehmen?"
  },
  TipsType_AcceptConfirm_LeftBtnDesc = {Text = "Ablehnen"},
  TipsType_AcceptConfirm_RightBtnDesc = {
    Text = "Akzeptieren"
  },
  TipsType_AcceptConfirm_Title = {
    Text = "Passwortkampf"
  },
  TipsType_ActivitySignRewardTaskNotCompleteTips_Desc = {
    Text = "Erfülle die entsprechenden Aufgaben, um die Erweckung durchzuführen"
  },
  TipsType_AlreadyIsBackgroundMusicTips_Desc = {
    Text = "Aktuelle Hintergrundmusik"
  },
  TipsType_AwakerAutoInsertCoinNotEnoughTips_Desc = {
    Text = "„Rosenskript\" reicht nicht aus, um die aktuell vorhandenen „Gnosis-Elixiere\" vollständig zu verwenden. Bitte ergänze „Rosenskript\" und versuche es erneut."
  },
  TipsType_AwakerNotOpenTips_Desc = {
    Text = "Erwecker ist noch nicht verfügbar. Bleib gespannt!"
  },
  TipsType_AwakerRandomChestConfirm_Desc = {
    Text = "<Blue:{s1}> verwenden, um 1 <Blue:zufälligen> Erweckten Körper zu erhalten?"
  },
  TipsType_AwakerRandomChestConfirm_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_AwakerRandomChestConfirm_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_AwakerRandomChestConfirm_Title = {
    Text = "Verwendungsbestätigung"
  },
  TipsType_BattleCreateFail_Desc = {
    Text = "Kampferstellung fehlgeschlagen"
  },
  TipsType_BattlePassAllCompleteTips_Desc = {
    Text = "Das aktuelle Archive wurde vollständig abgeschlossen."
  },
  TipsType_BestExperienceTips_Chapter3_Desc = {
    Text = "Um das beste Handlungserlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungslevels abzuschließen."
  },
  TipsType_BestExperienceTips_Chapter3_LeftBtnDesc = {Text = "Beenden"},
  TipsType_BestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_BestExperienceTips_Chapter3_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_BestExperienceTips_Chapter7_Desc = {
    Text = "Um das beste erzählerische Erlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_BestExperienceTips_Chapter7_LeftBtnDesc = {Text = "Beenden"},
  TipsType_BestExperienceTips_Chapter7_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_BestExperienceTips_Chapter7_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_BestExperienceTips_Chapter8_Desc = {
    Text = "Um das beste erzählerische Erlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_BestExperienceTips_Chapter8_LeftBtnDesc = {Text = "Beenden"},
  TipsType_BestExperienceTips_Chapter8_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_BestExperienceTips_Chapter8_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_BestExperienceTips_ChapterS2_Desc = {
    Text = "Um das beste erzählerische Erlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_BestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "Beenden"},
  TipsType_BestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_BestExperienceTips_ChapterS2_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_BestExperienceTips_ChapterS3_Desc = {
    Text = "Um das beste erzählerische Erlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungsstufen abzuschließen."
  },
  TipsType_BestExperienceTips_ChapterS3_LeftBtnDesc = {Text = "Beenden"},
  TipsType_BestExperienceTips_ChapterS3_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_BestExperienceTips_ChapterS3_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_BestExperienceTips_ChapterS4_Desc = {
    Text = "Um das beste Handlungserlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungslevels abzuschließen."
  },
  TipsType_BestExperienceTips_ChapterS4_LeftBtnDesc = {Text = "Beenden"},
  TipsType_BestExperienceTips_ChapterS4_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_BestExperienceTips_ChapterS4_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_BestExperienceTips_ChapterS5_Desc = {
    Text = "Um das beste Handlungserlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungslevels abzuschließen."
  },
  TipsType_BestExperienceTips_ChapterS5_LeftBtnDesc = {Text = "Beenden"},
  TipsType_BestExperienceTips_ChapterS5_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_BestExperienceTips_ChapterS5_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Desc = {
    Text = "Um das beste Handlungserlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungslevels abzuschließen."
  },
  TipsType_BestExperienceTips_MainStoryS1_6_LeftBtnDesc = {Text = "Beenden"},
  TipsType_BestExperienceTips_MainStoryS1_6_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_BestExperienceTips_MainStoryS1_6_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Desc = {
    Text = "Um das beste Handlungserlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungslevel abzuschließen."
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_LeftBtnDesc = {Text = "Beenden"},
  TipsType_BestExperienceTips_TwoAnniversarySubStage_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_BestExperienceTips_TwoAnniversarySubStage_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_CancelCollectAwakerTips_Desc = {
    Text = "Sammlung aufgehoben"
  },
  TipsType_CoinBulkBuyConfirm_Desc = {
    Text = "Möchtest du „Rosengoldgutschein“ × {s1} verbrauchen, um den Kauf durchzuführen?"
  },
  TipsType_CoinBulkBuyConfirm_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_CoinBulkBuyConfirm_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_CoinBulkBuyConfirm_Title = {
    Text = "Kauf bestätigen"
  },
  TipsType_CollectAwakerTips_Desc = {
    Text = "Erfolgreich gesammelt"
  },
  TipsType_CommonUseBattleHelpLimitTips_Desc = {
    Text = "Häufig verwendete Unterstützung Schutzherren hat das Maximum erreicht, bitte passen Sie die Liste der häufig verwendeten Unterstützung an"
  },
  TipsType_DiskIsFullOrViolation_Desc = {
    Text = "Dateien konnten nicht geladen werden. Bitte überprüfe deinen Speicherplatz."
  },
  TipsType_DiskIsFullOrViolation_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_DiskSpaceNotEnough_Desc = {
    Text = "Speicherplatz nicht ausreichend. Möchten Sie den Download dennoch versuchen?"
  },
  TipsType_DiskSpaceNotEnough_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_DiskSpaceNotEnough_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_DoubleExBPBuyConfirm_Desc = {
    Text = "Möchten Sie <Blue:„Quellflüssigkeit“× {s1} > ausgeben, um zu kaufen?\n <color=#ACBFCA>Diese Ausgabe bietet spezielle Themen, mit einem reduzierten Preis für Kernthemen</color>"
  },
  TipsType_DoubleExBPBuyConfirm_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_DoubleExBPBuyConfirm_RightBtnDesc = {Text = "Kaufen"},
  TipsType_DoubleExBPBuyConfirm_Title = {
    Text = "Kauf bestätigen"
  },
  TipsType_EnterSix_DigitPasswordTips_Desc = {
    Text = "Bitte geben Sie einen 6-stelligen Phasenwert ein"
  },
  TipsType_FilterMaxAwakerCountTips_Desc = {
    Text = "Wähle bis zu {s1} Erwecker zum Filtern aus"
  },
  TipsType_FollowBackConfirm_Desc = {
    Text = "Möchten Sie die <color=#5EF2FF>{s1}</color> Anhänger auf der aktuellen Seite folgen? \n\n<color=#96947F>Derzeit verfolgt </color>{s2}<color=#A0A0A0>/{s3}\nNach Erreichen des Limits können Sie nicht mehr folgen</color>"
  },
  TipsType_FollowBackConfirm_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_FollowBackConfirm_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_FollowBackConfirm_Title = {
    Text = "Bestätigung der Rückantwort"
  },
  TipsType_FrenziedOmenUpgradeConfirm_Desc = {
    Text = "Dieser Vorgang verbraucht eine große Menge an Ressourcen und eignet sich für den Fall, dass die Fähigkeiten des Erweckers bis an ihre Grenzen ausgebaut werden sollen. Möchtest du „Wahnsinnsomen\" wirklich verbessern?"
  },
  TipsType_FrenziedOmenUpgradeConfirm_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_FrenziedOmenUpgradeConfirm_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_FrenziedOmenUpgradeConfirm_Title = {
    Text = "Stärkung bestätigen"
  },
  TipsType_GnosticPotentialUpgradeConfirm_Desc = {
    Text = "Dieser Vorgang verbraucht eine große Menge an Ressourcen und eignet sich für den Fall, dass die Fähigkeiten des Erweckers bis an ihre Grenzen ausgebaut werden sollen. Möchtest du „Gnostisches Potenzial\" wirklich verbessern?"
  },
  TipsType_GnosticPotentialUpgradeConfirm_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_GnosticPotentialUpgradeConfirm_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_GnosticPotentialUpgradeConfirm_Title = {
    Text = "Stärkung bestätigen"
  },
  TipsType_InCharging_Desc = {
    Text = [[
Bestellung wird bearbeitet, bitte nicht erneut bezahlen. 
Wenn die Zahlung abgeschlossen ist, warten Sie bitte geduldig auf die Belohnungen des Systems. 
Wenn die Zahlung nicht abgeschlossen ist, versuchen Sie, das Spiel neu zu starten und es erneut zu versuchen. 
Bei Fragen wenden Sie sich bitte an den Kundenservice.]]
  },
  TipsType_InCharging_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_InCharging_Title = {Text = "Hinweis"},
  TipsType_KeyShortNameDownLoadTips_Desc = {
    Text = "Textkennungsressourcen werden heruntergeladen, bitte versuchen Sie es in einer Weile erneut"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_Desc = {
    Text = "Dieser Erweckte Körper hat das maximale Erwachen erreicht.\nNach der Auswahl erhältst du nur noch „Seelenrückspulsplitter\" ×2"
  },
  TipsType_LimitAwakerEnlightenmentOverflowTips_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_RightBtnDesc = {Text = "Weiter"},
  TipsType_LimitAwakerEnlightenmentOverflowTips_Title = {
    Text = "Auswahl bestätigen"
  },
  TipsType_MainResetBG_Desc = {
    Text = "Soll der Hintergrund des Schlafsaals <Blue:“Bildschirm“> und <Blue:“Musik“> auf die Standardeinstellungen zurückgesetzt werden?"
  },
  TipsType_MainResetBG_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_MainResetBG_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_MainResetBG_Title = {
    Text = "Wiederherstellen der Standardeinstellungen"
  },
  TipsType_MultiSelectBox_FixItemTips_Desc = {
    Text = "Festes Element erhalten, kann nicht geändert werden"
  },
  TipsType_MultiSelectBox_SelectTips_Desc = {
    Text = "Bitte schließen Sie die Auswahl aller selbstgewählten Gegenstände ab, bevor Sie mit dem Kauf fortfahren"
  },
  TipsType_OppositeSideCancelMatchTips_Desc = {
    Text = "Gegner hat das Match abgebrochen"
  },
  TipsType_OppositeSideRejectTips_Desc = {
    Text = "Gegner hat die Einladung von <Blue:{s1}> abgelehnt, bitte wählen Sie den Modus erneut aus"
  },
  TipsType_PVEExceedMaxRoundsTips_Desc = {
    Text = [[
Die maximale Rundenanzahl des Kampfes wurde erreicht

Einziger Schutzherr
Wie wirst du dich nun entscheiden?]]
  },
  TipsType_PVEExceedMaxRoundsTips_LeftBtnDesc = {
    Text = "Wiederkampf"
  },
  TipsType_PVEExceedMaxRoundsTips_RightBtnDesc = {
    Text = "Vorübergehend zurückziehen"
  },
  TipsType_PVEExceedMaxRoundsTips_Title = {
    Text = "Ermittlung fehlgeschlagen"
  },
  TipsType_PVEReplayErrorTips_Desc = {
    Text = "Fehler beim Abrufen der Kampfaufzeichnung, bitte versuchen Sie es später erneut"
  },
  TipsType_PVEReplayMaxRounds_Desc = {
    Text = [[
Die Wiedergabe hat das Maximum von 25 Runden erreicht, 
 Wiedergabe beendet.]]
  },
  TipsType_PVEReplayMaxRounds_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_PVEReplayMaxRounds_Title = {
    Text = "Bestätigen beenden"
  },
  TipsType_PVEReplayNoDataTips_Desc = {
    Text = "Keine Aufzeichnungen zu Ermittlungseinsätzen"
  },
  TipsType_PVEReplayRepeatClickTips_Desc = {
    Text = "Lade den Kampf-Wiedergabe, bitte keine wiederholten Aktionen durchführen"
  },
  TipsType_PVEReplaySpecialTeamAssignTips_Desc = {
    Text = "Derzeit wird die Kampfaufzeichnung für spezielle Formationen nicht unterstützt, bitte warten Sie"
  },
  TipsType_PVEReplayTimeoutTips_Desc = {
    Text = "Zeitüberschreitung beim Abrufen der Kampf-Wiederholung"
  },
  TipsType_PVEReplayUnableOperateTips_Desc = {
    Text = "Im Kampf-Playback können keine Aktionen durchgeführt werden"
  },
  TipsType_PVETeamShareCodeCopyTips_Desc = {
    Text = "Bereits in die Zwischenablage kopiert"
  },
  TipsType_PVETeamShareCodeError_Desc = {
    Text = "Konnte nicht korrekt erkennen, dass sich im Zwischenspeicher <color=#5EF2FF>Ermittlungseinsatz</color> Formation befindet"
  },
  TipsType_PVETeamShareCodeSaveTips_Desc = {
    Text = "Möchten Sie die Teamkonfiguration, die dem entsprechenden Teamcode zugeordnet ist, speichern?\nDie Teile, die nicht in Besitz sind, werden leer bleiben."
  },
  TipsType_PVETeamShareCodeSaveTips_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_PVETeamShareCodeSaveTips_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_PVETeamShareCodeSaveTips_Title = {
    Text = "Speicherbestätigung"
  },
  TipsType_PVETeamShareCodeSpecialTeamAssignTips_Desc = {
    Text = "Dieses Team enthält vorab festgelegte Erwecker, kann den Formation-Code nicht kopieren oder importieren"
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_Desc = {
    Text = "Das Duell hat das Rundenlimit erreicht. Die angreifende Seite konnte das Duell nicht beenden und wird als Verlierer gewertet."
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_PVPExceedMaxRoundsTips_Loser_Title = {
    Text = "Duell beendet"
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_Desc = {
    Text = "Das Duell hat das Rundenlimit erreicht. Die nachziehende Seite hat erfolgreich bis zum Ende durchgehalten und wird als Sieger gewertet."
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_PVPExceedMaxRoundsTips_Winner_Title = {
    Text = "Duell beendet"
  },
  TipsType_PVPSurrenderConfirm_Desc = {
    Text = "Gibst du auf?"
  },
  TipsType_PVPSurrenderConfirm_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_PVPSurrenderConfirm_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_PVPSurrenderConfirm_Title = {
    Text = "Surrender-Bestätigung"
  },
  TipsType_PVPTeamShareCodeError_Desc = {
    Text = "Konnte nicht korrekt erkennen, dass sich im Clipboard <color=#5EF2FF>Phasenduell</color> Formation befindet"
  },
  TipsType_PVP_PasswordBattle_BlockTips_Desc = {
    Text = "Soll dieser Geheimnisträger blockiert werden?"
  },
  TipsType_PVP_PasswordBattle_BlockTips_LeftBtnDesc = {Text = "Ablehnen"},
  TipsType_PVP_PasswordBattle_BlockTips_RightBtnDesc = {
    Text = "Akzeptieren"
  },
  TipsType_PVP_PasswordBattle_BlockTips_Title = {Text = "Blockieren"},
  TipsType_PVP_PasswordBattle_GameStartedTips_Desc = {
    Text = "Der Passwortkampf hat begonnen"
  },
  TipsType_PVP_PasswordBattle_OthersEnterTips_Desc = {
    Text = "Ein neuer Schutzherr ist in diesen geheimen Pakt eingetreten"
  },
  TipsType_PVP_PasswordBattle_QueueTips_Desc = {
    Text = "Die Verabredungen sind voll, wir stehen in der Warteschlange..."
  },
  TipsType_PVP_PasswordBattle_QuitTips_Desc = {
    Text = "Möchtest du diese geheime Vereinbarung verlassen?"
  },
  TipsType_PVP_PasswordBattle_QuitTips_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_PVP_PasswordBattle_QuitTips_RightBtnDesc = {Text = "Beenden"},
  TipsType_PVP_PasswordBattle_QuitTips_Title = {
    Text = "Beenden bestätigen"
  },
  TipsType_PVP_PasswordBattle_RejectedTips_Desc = {
    Text = "Gegner hat das geheime Abkommen mit Ihnen abgelehnt"
  },
  TipsType_PassportHoistTips1_Desc = {
    Text = "„Einfaches Aktivion\"\n·Nach dem Freischalten werden die in der „Täglichen Probe\" gesammelten kumulativen Belohnungen für „Einfaches Aktivion\" während dieser Kursperiode – „Realitätsanfang\", „Unbefleckter Kern\", „Erfahrung\" und „Silberkern\" – auf das 3-Fache erhöht. Nach dem Kauf des „Kernthemas\" werden die zusätzlichen Multiplikatoranteile der bereits erhaltenen kumulativen Belohnungen für „Einfaches Aktivion\" dieser Periode nachträglich ausgezahlt."
  },
  TipsType_PassportHoistTips2_Desc = {
    Text = "“Zeitliche Rückkehr“\n·Kann in Kämpfen zu bereits erlebten Runden zurückkehren. \n·Kann zu einer beliebigen Runde der letzten 25 Runden im Kampf zurückkehren. \n·Nach einer erneuten Herausforderung kann die Rückkehr-Funktion weiterhin verwendet werden, um zu vorherigen Runden zurückzukehren."
  },
  TipsType_PassportHoistTips3_Desc = {
    Text = "“Phasenduell“\n·Nach der Freischaltung können während der Dauer des aktuellen Themas alle Karten des “Phasenduells“ verwendet werden."
  },
  TipsType_Password_CopiedTips_Desc = {
    Text = "Der Phasenwert wurde in die Zwischenablage kopiert"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_Desc = {
    Text = "Möchtest du <Blue:„Quellflüssigkeit\" × {s1} >verbrauchen, um zu kaufen?\n\n<size=30><color=#ACBFCA>Beim Verbrauch von „Quellflüssigkeit\" wird zuerst die geschenkte „Quellflüssigkeit\" abgezogen.\n(Extrahiert: {s2}, „Geschenkt\": {s3})</color></size>"
  },
  TipsType_PayMoneyBuyConfirmDescDetail_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_PayMoneyBuyConfirmDescDetail_RightBtnDesc = {Text = "Kaufen"},
  TipsType_PayMoneyBuyConfirmDescDetail_Title = {
    Text = "Kauf bestätigen"
  },
  TipsType_PublishEmptyCommentTips_Desc = {
    Text = "Der Kommentarinhalt darf nicht leer sein"
  },
  TipsType_PvpCollectionCommentDeleteTips_Desc = {
    Text = "Kommentar löschen?"
  },
  TipsType_PvpCollectionCommentDeleteTips_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_PvpCollectionCommentDeleteTips_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_PvpCollectionCommentDeleteTips_Title = {
    Text = "Löschbestätigung"
  },
  TipsType_PvpHideCommentConfirm_Desc = {
    Text = "Möchten Sie alle Kommentare ausblenden?"
  },
  TipsType_PvpHideCommentConfirm_LeftBtnDesc = {Text = "Nein"},
  TipsType_PvpHideCommentConfirm_RightBtnDesc = {Text = "Ja"},
  TipsType_PvpHideCommentConfirm_Title = {Text = "Verstecken"},
  TipsType_PvpMatchingInterruptTips_Desc = {
    Text = "Netzwerkfehler erkannt, Matchmaking unterbrochen."
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Desc = {
    Text = "Noch im Kampf – möchtest du den vorherigen Kampf fortsetzen? \n Die Saison „Rasender Freudenzug“ wurde aktualisiert. Wenn du die Herausforderung fortsetzt, kannst du die neuesten Saisonaufgaben abschließen, aber du kannst nicht in die „Gästeliste“ eintreten."
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_RailWayContinueReconnectSeasonSwitchTips_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_RailWayContinueReconnectSeasonSwitchTips_Title = {Text = "Hinweis"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Desc = {
    Text = "Der letzte Herausforderungsfortschritt war {s1} – Phase {s2} – Kampf {s3}, erhaltene „Gästepunkte“ × {s4}\nDie Saison wurde aktualisiert. Wenn du die Herausforderung fortsetzt, kannst du die neuesten Saisonaufgaben abschließen, aber du kannst nicht in die „Gästeliste“ eintreten. Möchtest du die Herausforderung fortsetzen?"
  },
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_RailWayContinueSaveStageSeasonSwitchTips_Title = {
    Text = "Herausforderung fortsetzen"
  },
  TipsType_RailWayContinueSaveStage_Desc = {
    Text = "Fortschritt fortsetzen: {s1} – Phase {s2} – Kampf {s3}.\nVerdiente VIP-Punkte: {s4}.\nMöchtest du die Herausforderung fortsetzen?"
  },
  TipsType_RailWayContinueSaveStage_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_RailWayContinueSaveStage_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_RailWayContinueSaveStage_Title = {
    Text = "Herausforderung fortsetzen"
  },
  TipsType_RailWayHaveSaveStage_Desc = {
    Text = "Sie müssen die letzte gespeicherte Herausforderung beenden, bevor Sie eine neue Herausforderung starten können"
  },
  TipsType_RailWaySaveAndExitInBattleTips_Desc = {
    Text = "Möchtest du die Herausforderung wirklich beenden?\nDer Fortschritt dieser Herausforderung wird gespeichert, und beim nächsten Mal wird die Herausforderung mit dem aktuellen Fortschritt fortgesetzt und dieser Kampf wird neu gestartet."
  },
  TipsType_RailWaySaveAndExitInBattleTips_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_RailWaySaveAndExitInBattleTips_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_RailWaySaveAndExitInBattleTips_Title = {
    Text = "Speichern und Beenden"
  },
  TipsType_RailWaySaveAndExitTips_Desc = {
    Text = "Bist du dir sicher, dass du die Herausforderung beenden möchtest?\nDer Fortschritt dieser Herausforderung wird gespeichert, und du wirst beim nächsten Mal mit dem aktuellen Fortschritt fortfahren."
  },
  TipsType_RailWaySaveAndExitTips_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_RailWaySaveAndExitTips_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_RailWaySaveAndExitTips_Title = {
    Text = "Speichern und Beenden"
  },
  TipsType_RailWaySeasonSwitchTips_Desc = {
    Text = "Die Saison wurde aktualisiert. Wenn du die Herausforderung fortsetzt, kannst du die neuesten Saisonaufgaben abschließen, aber du kannst nicht in die „Gästeliste“ eintreten."
  },
  TipsType_ReplayNullTips_Desc = {
    Text = "Die Wiedergabeinformationen dürfen nicht leer sein"
  },
  TipsType_SchoolConflictTips_Desc = {
    Text = "Realm-Konflikt. Bitte die Aufstellung anpassen."
  },
  TipsType_SelectedAwakensAndCardsExceedLimit_Desc = {
    Text = "Die ausgewählte Anzahl wurde überschritten"
  },
  TipsType_ServerRankDataLoading_Desc = {
    Text = "Die Ranglistendaten wurden noch nicht vollständig geladen. Bitte öffne die Seite später erneut."
  },
  TipsType_ServerRankDataLoading_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_ServerRankDataLoading_Title = {
    Text = "Server-Ranglisten-Daten werden initialisiert"
  },
  TipsType_ShopBulkBuyConfirm_Desc = {
    Text = "<Blue:{s1}> {s2} werden verwendet, um <Blue:{s3}> {s4} einzutauschen. Einlösung bestätigen?"
  },
  TipsType_ShopBulkBuyConfirm_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_ShopBulkBuyConfirm_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_ShopBulkBuyConfirm_Title = {
    Text = "Erlösungsbestätigung"
  },
  TipsType_SocialRecordHideTips_Desc = {
    Text = "Kampfaufzeichnungen sind verborgen"
  },
  TipsType_SteamOverlayEnabledTips_Desc = {
    Text = "Bitte aktiviere „Steam-Overlay im Spiel aktivieren\" unter Steam „Einstellungen – Im Spiel\" sowie in den „Eigenschaften – Allgemein\" dieses Spiels, starte das Spiel danach neu und versuche es erneut."
  },
  TipsType_SteamOverlayEnabledTips_LeftBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_SteamOverlayEnabledTips_Title = {Text = "Hinweis"},
  TipsType_SteamRestartTips_Desc = {
    Text = "Steam-Autorisierungsfehler. Bitte starte den Steam-Client neu und versuche es erneut."
  },
  TipsType_SteamRestartTips_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_SteamRestartTips_Title = {
    Text = "Anmeldefehler"
  },
  TipsType_SubBestExperienceTips_Chapter3_Desc = {
    Text = "Um das beste Handlungserlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungslevels abzuschließen."
  },
  TipsType_SubBestExperienceTips_Chapter3_LeftBtnDesc = {Text = "Beenden"},
  TipsType_SubBestExperienceTips_Chapter3_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_SubBestExperienceTips_Chapter3_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_SubBestExperienceTips_Chapter5_Desc = {
    Text = "Um das beste Handlungserlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungslevels abzuschließen."
  },
  TipsType_SubBestExperienceTips_Chapter5_LeftBtnDesc = {Text = "Beenden"},
  TipsType_SubBestExperienceTips_Chapter5_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_SubBestExperienceTips_Chapter5_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Desc = {
    Text = "Um das beste Handlungserlebnis sicherzustellen, wird empfohlen, die folgenden Untersuchungslevels abzuschließen."
  },
  TipsType_SubBestExperienceTips_ChapterS2_LeftBtnDesc = {Text = "Beenden"},
  TipsType_SubBestExperienceTips_ChapterS2_RightBtnDesc = {
    Text = "Immer noch untersuchen"
  },
  TipsType_SubBestExperienceTips_ChapterS2_Title = {
    Text = "Ermittlung bestätigen"
  },
  TipsType_SummonFailureTips_Desc = {
    Text = "Die Materialkosten für die Erweckung haben sich geändert, bitte versuche eine erneute Erweckung"
  },
  TipsType_SummonPriorityNotEnoughTips_Desc = {
    Text = "Es fehlen {s1} <Blue:„{s2}“>. Stattdessen <Blue:{s4} × {s3} > verbrauchen?"
  },
  TipsType_SummonPriorityNotEnoughTips_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_SummonPriorityNotEnoughTips_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_SummonPriorityNotEnoughTips_Title = {
    Text = "Erlösungsbestätigung"
  },
  TipsType_SummonType_14SelectConfirm_BottomDesc = {
    Text = "<Blue:Beachten: Diese Aktivität kann nach der Auswahl nicht mehr geändert werden!>"
  },
  TipsType_SummonType_14SelectConfirm_Desc = {
    Text = "Möchten Sie wirklich den Erwachenskörper <OrangeQuality:„{s1}“.„{s2}“.„{s3}“.„{s4}“> als Ziel des UP-Events dieser Runde auswählen?"
  },
  TipsType_SummonType_14SelectConfirm_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_SummonType_14SelectConfirm_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_SummonType_14SelectConfirm_Title = {
    Text = "Auswahl bestätigen"
  },
  TipsType_SummonType_14SelectLimitTips_BottomDesc = {
    Text = "<Blue:Beachten: Diese Aktivität kann nach der Auswahl nicht mehr geändert werden!>"
  },
  TipsType_SummonType_14SelectLimitTips_Desc = {
    Text = "Mengenlimit erreicht"
  },
  TipsType_SummonType_17IncompleteSelectionTips_Desc = {
    Text = "Bitte alle Auswahltypen abschließen, bevor du es erneut versuchst"
  },
  TipsType_SummonType_17SelectConfirm_Desc = {
    Text = "Auswahl des festgelegten Erweckers wirklich abschließen?\nNach der Bestätigung kann die Auswahl in diesem Zeitraum nicht mehr geändert werden."
  },
  TipsType_SummonType_17SelectConfirm_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_SummonType_17SelectConfirm_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_SummonType_17SelectConfirm_Title = {
    Text = "Auswahl bestätigen"
  },
  TipsType_SupportListLatestTips_Desc = {
    Text = "Bereits auf dem neuesten Zustand – folge mehr Kommilitonen, um mehr Kampfunterstützungs-Optionen zu erhalten!"
  },
  TipsType_TrinketAutoRefineExitTips_Desc = {
    Text = "Auto-Transkription läuft, Aktion nicht verfügbar."
  },
  TipsType_TrinketAutoRefineTips_BottomDesc = {
    Text = "(Auto-Transkription stoppt, wenn ein freigeschalteter Wert 8 erreicht.)"
  },
  TipsType_TrinketAutoRefineTips_Desc = {
    Text = [[
Bis zu {s1} Mal transkribieren
Bis zu verbrauchen]]
  },
  TipsType_TrinketAutoRefineTips_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_TrinketAutoRefineTips_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_TrinketAutoRefineTips_Title = {
    Text = "Auto-Transkription bestätigen"
  },
  TipsType_TrinketBagFullTips_Desc = {
    Text = "Bündnis-Rucksack ist voll"
  },
  TipsType_TrinketBatchUnbindTips_Desc = {
    Text = "Alle Bündnisse lösen?"
  },
  TipsType_TrinketBatchUnbindTips_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_TrinketBatchUnbindTips_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_TrinketBatchUnbindTips_Title = {
    Text = "Lösen bestätigen"
  },
  TipsType_TrinketBindSaveTips_Desc = {
    Text = "Es gibt gebundene Bündnisse, kann nicht als Plan gespeichert werden!"
  },
  TipsType_TrinketBindTips_Desc = {
    Text = "Möchtest du das folgende Bündnis verbinden? Bündnisse, die von anderen Erweckern ausgerüstet sind oder in Formationen/Plänen/Unterstützung vorhanden sind, werden automatisch abgelegt."
  },
  TipsType_TrinketBindTips_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_TrinketBindTips_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_TrinketBindTips_Title = {
    Text = "Bindungsänderung bestätigen"
  },
  TipsType_TrinketChangeBindTips_Desc = {
    Text = "Bindungsänderung bestätigen?"
  },
  TipsType_TrinketChangeBindTips_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_TrinketChangeBindTips_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_TrinketChangeBindTips_Title = {
    Text = "Bindungsänderung bestätigen"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_Desc = {
    Text = "Alle Bündnis-Sets lösen?\n\n<color=#9BA3A2><size=30>+12 Bündnisteile enthalten.</size></color>"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_TrinketHighLevelBatchUnbindTips_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_TrinketHighLevelBatchUnbindTips_Title = {
    Text = "Lösen bestätigen"
  },
  TipsType_TrinketHighLevelChangeBindTips_Desc = {
    Text = "Änderung bestätigen?\n\n<color=#9BA3A2><size=30>+12 Bündnisteile enthalten.</size></color>"
  },
  TipsType_TrinketHighLevelChangeBindTips_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_TrinketHighLevelChangeBindTips_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_TrinketHighLevelChangeBindTips_Title = {
    Text = "Bindungsänderung bestätigen"
  },
  TipsType_TrinketHighLevelUnbindTips_Desc = {
    Text = "Dieses Bündnis-Set lösen?\n\n<color=#9BA3A2><size=30>+12 Bündnisteile enthalten.</size></color>"
  },
  TipsType_TrinketHighLevelUnbindTips_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_TrinketHighLevelUnbindTips_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_TrinketHighLevelUnbindTips_Title = {
    Text = "Lösen bestätigen"
  },
  TipsType_TrinketUnbindTips_Desc = {
    Text = "Dieses Bündnis wirklich lösen?"
  },
  TipsType_TrinketUnbindTips_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_TrinketUnbindTips_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_TrinketUnbindTips_Title = {
    Text = "Lösen bestätigen"
  },
  TipsType_TryAgainLaterTips_Desc = {
    Text = "Dieser Phasenwert wird gerade verwendet, bitte versuchen Sie es später erneut"
  },
  TipsType_WaitOppositeSideAccept_Desc = {
    Text = [[
Warten
{s1}
auf die Annahme der Einladung von <Blue:{s2}>]]
  },
  TipsType_WaitOppositeSideAccept_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_WaitOppositeSideAccept_Title = {
    Text = "Passwortkampf"
  },
  TipsType_WaitOthersEnter_Desc = {
    Text = "Warten auf die Eingabe anderer Schutzherren\n <Blue:{s1}>\nÜbereinstimmung des geheimen Pakts"
  },
  TipsType_WaitOthersEnter_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_WaitOthersEnter_RightBtnDesc = {
    Text = "Kopie Phasenwert"
  },
  TipsType_WaitOthersEnter_Title = {
    Text = "Passwortkampf"
  },
  TipsType_WeaponRandomChestConfirm_Desc = {
    Text = "<Blue:{s1}> verwenden, um 1 <Blue:zufälliges> Schicksrad zu erhalten?"
  },
  TipsType_WeaponRandomChestConfirm_LeftBtnDesc = {Text = "Abbrechen"},
  TipsType_WeaponRandomChestConfirm_RightBtnDesc = {
    Text = "Bestätigen"
  },
  TipsType_WeaponRandomChestConfirm_Title = {
    Text = "Verwendungsbestätigung"
  },
  TipsType_WeekChallengeSweepTips_Desc = {
    Text = "Wöchentliche Belohnungen aufgebraucht, keine Reproduktion möglich."
  }
})
return Text_TipsType
