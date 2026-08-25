__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Tutorial = readonly({
  Tutorial_120371_Desc_1 = {
    Text = "Es ist möglich, in den Kämpfen zu den erlebten Runden zurückzukehren, wobei man zu einer beliebigen der letzten 25 Runden zurückkehren kann."
  },
  Tutorial_120371_Title_1 = {
    Text = "Zeitliche Rückkehr"
  },
  Tutorial_124999_Desc_1 = {
    Text = "Im <TutorialHighlight:Traphase-Draft Pick> Modus klickst du auf „Start Matching“ in der rechten unteren Ecke der Benutzeroberfläche, um ins Matchmaking einzutreten, ohne ein Team vorab zusammenzustellen."
  },
  Tutorial_124999_Desc_2 = {
    Text = "Bevor das Match beginnt, wird ein zufälliges <TutorialHighlight:Relikt> ausgewählt, um den kommenden Kampf zu beeinflussen. Die Spieler wählen dann abwechselnd Erwecker, Räder des Schicksals und Besitztümer aus einem begrenzten Pool aus, um ihre Aufstellungen zu erstellen. Um deine Strategie anzupassen, klicke auf zwei Erwecker, um ihre Positionen zu tauschen (nummeriert 1–4, von vorne nach hinten)."
  },
  Tutorial_124999_Desc_3 = {
    Text = "Um deine Aufstellung anzupassen, klicke auf zwei Erwecker, um ihre Positionen (nummeriert 1–4, von vorne nach hinten) zu tauschen."
  },
  Tutorial_124999_Title_1 = {
    Text = "Draft-Auswahl Aufstellung"
  },
  Tutorial_126878_Desc_1 = {
    Text = "Wenn der Psyche-Anstieg bestimmter Erwecker +12 erreicht, erhalten sie automatisch den Effekt „Absolute Axiom“, der für jeden Erwecker unterschiedlich ist."
  },
  Tutorial_126878_Desc_2 = {
    Text = "Nachdem du das \"Absolute Axiom\" des Erweckers freigeschaltet hast, erhältst du eine exklusive Nachricht vom Erwecker. Vergiss nicht, sie dir anzusehen!"
  },
  Tutorial_126878_Title_1 = {
    Text = "Letzte Regel"
  },
  Tutorial_126878_Title_2 = {
    Text = "Exklusive Nachricht"
  },
  Tutorial_148475_Desc_1 = {
    Text = "Sobald die Synchro-Rate eines Erweckers <TutorialHighlight:Lv20> erreicht, erhältst du eine exklusive <TutorialHighlight:Scintilla>."
  },
  Tutorial_148475_Desc_2 = {
    Text = "Die <TutorialHighlight:Scintilla> ist der Beweis der Heiligen Vereinigung zwischen dir und deinem Erwecker."
  },
  Tutorial_148475_Desc_3 = {
    Text = "Ab sofort werden die Befehlskarten dieses Erweckers im Kampf besonders dargestellt und können bei sozialen Anlässen anderen Schutzherren gezeigt werden."
  },
  Tutorial_148475_Title_1 = {
    Text = "Heilige Vereinigung"
  },
  Tutorial_17805_Desc_1 = {
    Text = "Klicke auf den Feind, um alle seine Zustände zu sehen. <TutorialHighlight:Warnung> Zustände erfordern besondere Aufmerksamkeit, da sie die speziellen Mechanismen des Feindes darstellen. Die meisten Fehlschläge bei Ermittlungen resultieren aus der Nichtbeachtung dieser Mechanismen"
  },
  Tutorial_17805_Title_1 = {
    Text = "Feindstatus"
  },
  Tutorial_17806_Desc_1 = {
    Text = "Nachdem du die Gegner besiegt hast, kannst du <TutorialHighlight:Gebet> auswählen oder <TutorialHighlight:Fusionsnarbe> verwenden, um <TutorialHighlight:Schwarzes Mal> auszugeben und zu kaufen. <TutorialHighlight:Gebet> ermöglicht es einer bestimmten Karte, verschiedene zusätzliche Effekte zu erhalten. Jede bestimmte Karte kann maximal <TutorialHighlight:1> Mal geprägt werden. Priorisiere das Prägen von Befehlskarten, die häufiger gespielt werden, um die Vorteile des Gebets zu erhöhen."
  },
  Tutorial_17806_Title_1 = {Text = "Gebet"},
  Tutorial_17807_Desc_1 = {
    Text = "Verschiedene Attribute für den Erwecker bereitstellen, und wenn sie ein <TutorialHighlight:Set> bilden, gibt es zusätzliche Effekte. Es gibt insgesamt 6 Teile, und die <TutorialHighlight:Hauptattribute> unterscheiden sich je nach Teil. Krit. Rate und Krit. Schaden erscheinen an den Teilen I, II und III; Wutregenerations-Level und Silberner Schlüssel Aufladelevel erscheinen an den Teilen I, IV und V; Reichsbeherrschung und Siegelertrag erscheinen an den Teilen II, IV und VI; Schadenamplifikation und Todwiderstand erscheinen an den Teilen III, V und VI."
  },
  Tutorial_17807_Title_1 = {Text = "Bündnis"},
  Tutorial_17808_Desc_1 = {
    Text = "Im Gameplay von <TutorialHighlight:Phantasmal Dive> tritt jede Herausforderungsstufe zufällig in eine Karte ein. Bei erfolgreicher Herausforderung erhältst du entsprechende Punkte basierend auf der Schwierigkeit der Stufe, den verbesserten Erweckern und den Punktesammelobjekten innerhalb der Stufe. Verschiedene anfängliche Relikte und verbesserte Erwecker sind für wöchentliche Herausforderungen verfügbar."
  },
  Tutorial_17808_Desc_2 = {
    Text = "Traumtauchen aktualisiert seine Saison in der Regel alle 28 Tage. Ein einmaliges Abschließen des Traumtauchens während einer Saison ermöglicht die Teilnahme am <TutorialHighlight:Saisonranking>. Am Ende der Saison werden die Rankings finalisiert und Rangbelohnungen per Postfach versendet."
  },
  Tutorial_17808_Desc_3 = {
    Text = "\"Deep Dive Aufzeichnungen\" haben mehrere Ziele, und entsprechende Belohnungen können nach Abschluss erhalten werden. Jedes Mal, wenn du ein Ziel der \"Deep Dive Aufzeichnung\" abschließt oder eine Deep Dive Herausforderung gewinnst, erhältst du <TutorialHighlight:Deep Dive EXP>. Wenn die Deep Dive EXP einen bestimmten Wert erreicht, wird <TutorialHighlight:Deep Dive Level> erhöht, was dir ermöglicht, reichhaltige Belohnungen zu erhalten. Du kannst die \"Deep Dive Aufzeichnungen\" und das \"Deep Dive Level\" in der unteren linken Ecke der Benutzeroberfläche überprüfen."
  },
  Tutorial_17808_Title_1 = {
    Text = "Traumtauchen"
  },
  Tutorial_17809_Desc_1 = {
    Text = "Durch Ereignisse und D-Markierungen kann <TutorialHighlight:Relikt> erlangt werden, <TutorialHighlight:Relikt> kann die Kampffähigkeiten unserer Truppe verstärken. Ausgezeichnete Hüter können oft je nach Bedarf der Truppe ein passenderes <TutorialHighlight:Relikt> auswählen"
  },
  Tutorial_17809_Title_1 = {Text = "Relikt"},
  Tutorial_17810_Desc_1 = {
    Text = "Vertreibt Nebel, Kartensicht + <TutorialHighlight:2> Felder, bessere Routenplanung möglich"
  },
  Tutorial_17810_Title_1 = {
    Text = "Suchscheinwerfer"
  },
  Tutorial_17811_Desc_1 = {
    Text = "Ein Ziel im <TutorialHighlight:Vergiftet>-Zustand erleidet am Ende der Runde Schaden in Höhe der <TutorialHighlight:Vergiftet>-Stapel. <TutorialHighlight:Vergiftet>-Schaden <TutorialHighlight:kann nicht kritisch treffen>"
  },
  Tutorial_17811_Title_1 = {Text = "Gift"},
  Tutorial_17812_Desc_1 = {
    Text = "Ziele im Zustand <TutorialHighlight:Verwundbarkeit> erleiden 50% mehr Schaden, 1 Schicht <TutorialHighlight:Verwundbarkeit> wird am Ende der Runde entfernt. Nutze die Gelegenheit, wenn der Feind <TutorialHighlight:Verwundbarkeit> hat, um mehr Schaden zu verursachen"
  },
  Tutorial_17812_Title_1 = {Text = "Verwundbar"},
  Tutorial_17813_Desc_1 = {
    Text = "Nach dem Abschluss der Stufen in \"Auflösungsruinen\", \"Verbotener Pakt\" und \"Arkane Herrschaft\" können diese Stufen sowie Stufen mit niedrigerer Schwierigkeit <TutorialHighlight:Reproduziert> werden. Verdiene schnell Stufenbelohnungen durch <TutorialHighlight:Reproduktion>."
  },
  Tutorial_17813_Title_1 = {
    Text = "Reproduktion"
  },
  Tutorial_17814_Desc_1 = {
    Text = "<TutorialHighlight:Schild> kann Schaden anstelle von Leben übernehmen, am Ende der Runde werden <TutorialHighlight:automatisch entfernt> alle Schilde, die Obergrenze der Schilde entspricht der <TutorialHighlight:maximalen Lebenspunkte> des Teams. Versuche, <TutorialHighlight:das Schild dem Gesamtschaden aller Feinde in dieser Runde anzupassen>, um mit minimalen Kosten den Sieg im Kampf zu erzielen."
  },
  Tutorial_17814_Title_1 = {Text = "Schild"},
  Tutorial_17815_Desc_1 = {
    Text = "Wiederholtes Erhalten des Erweckers wandelt ihn in <TutorialHighlight:Fragment> um. Der Verbrauch von <TutorialHighlight:Fragment> erhöht die Erleuchtungsstufe des Erweckers und kann den Fähigkeiten des Erweckers zusätzliche spezielle Fähigkeiten verleihen. Wenn die Erleuchtungsstufe des Erweckers maximal erreicht ist und du die entsprechenden Fragmente erhältst, werden sie in <TutorialHighlight:Seelenrückverfolgungssplitter> umgewandelt."
  },
  Tutorial_17815_Title_1 = {Text = "Fragment"},
  Tutorial_17816_Desc_1 = {
    Text = "Die Arithmetica ist <TutorialHighlight: für das gesamte Team geteilt>, das Ausspielen von Karten erfordert den <TutorialHighlight: Verbrauch von Arithmetica>. Die Arithmetica wird zu Beginn der Runde <TutorialHighlight: automatisch auf das Limit wiederhergestellt> und nach dem Ende der Runde <TutorialHighlight: automatisch geleert>. Um die Effizienz der Arithmetica-Nutzung zu steigern, bitte versuche, <TutorialHighlight: alle Arithmetica zu verbrauchen, bevor du die Runde beendest>."
  },
  Tutorial_17816_Title_1 = {
    Text = "Arithmetica"
  },
  Tutorial_17817_Desc_1 = {
    Text = "Besiege die Gegner im <TutorialHighlight:Transzendentes Wesen>, um fortgeschrittene <TutorialHighlight:Material für Fähigkeits-Upgrade> zu erhalten. Jede Woche kann eine Belohnung erhalten werden. Verschiedene Materialien können auch im <TutorialHighlight:Schmelzraum> synthetisiert und ausgetauscht werden."
  },
  Tutorial_17817_Title_1 = {
    Text = "Transzendentes Wesen"
  },
  Tutorial_17818_Desc_1 = {
    Text = "Erhalte nach dem Erwerb die Möglichkeit, <TutorialHighlight:im Inventar zu verwenden>, um die Stufen des Erweckers und der Fähigkeiten schnell gemäß den Vorgaben zu erhöhen"
  },
  Tutorial_17818_Title_1 = {
    Text = "Geistesverstärker"
  },
  Tutorial_17819_Desc_1 = {
    Text = "Wenn der Wahnsinn des Erweckers <TutorialHighlight:100> erreicht, kann <TutorialHighlight:Wahnsinn-Explosion> freigesetzt werden. Die Wahnsinn-Explosionseffekte sind unterschiedlich, daher sollten sie klug genutzt werden, um <TutorialHighlight: geeignete Anpassungen> zu erzielen"
  },
  Tutorial_17819_Title_1 = {
    Text = "Verherrlichung"
  },
  Tutorial_17820_Desc_1 = {
    Text = "Ziele im Zustand <TutorialHighlight:Zerbrechlich> erleiden 25% weniger Schild, 1 Schicht <TutorialHighlight:Zerbrechlich> wird am Ende der Runde automatisch entfernt. Wenn unser Team im Zustand <TutorialHighlight:Zerbrechlich> ist, denke daran, vor der VERT eine Möglichkeit zu finden, den Zustand <TutorialHighlight:Zerbrechlich> zu entfernen, oder ändere die Strategie und greife in dieser Runde mit voller Kraft an."
  },
  Tutorial_17820_Title_1 = {
    Text = "Zerbrechlich"
  },
  Tutorial_17821_Desc_1 = {
    Text = "Rüste den Erwachten mit <TutorialHighlight:Schicksalsrad> aus, um seine Attribute zu verbessern und spezielle Fähigkeiten zu erhalten"
  },
  Tutorial_17821_Title_1 = {Text = "Schicksrad"},
  Tutorial_17822_Desc_1 = {
    Text = "Ein Ziel im <TutorialHighlight:Bluten>-Zustand erleidet am Ende der Runde Schaden in Höhe der <TutorialHighlight:Bluten>-Stapel und <TutorialHighlight: entferne Bluten Zustand>.\nBeim <TutorialHighlight:LP-Wiederherstellung> entferne die doppelte Menge an <TutorialHighlight:Wiederherstellung>. Der Bluten-Schaden <TutorialHighlight:kann nicht kritisch treffen>."
  },
  Tutorial_17822_Title_1 = {Text = "Bluten"},
  Tutorial_17823_Desc_1 = {
    Text = "Chaoswachkörper können <TutorialHighlight: Bereichsgrenze durchbrechen> und mit Erweckten anderer Bereiche eine Formation bilden, was zu unterschiedlichen symbiotischen Effekten führt. Wenn in einem Team Chaoswachkörper vorhanden sind, erhält man zusätzlich 100% Todwiderstand."
  },
  Tutorial_17823_Desc_2 = {
    Text = "Im Vergleich zu Teams aus anderen Bereichen erhalten Chaosbereich-Teams schneller s-Energie. Bei der zweiten Freisetzung des Bande können sie aus allen Banden auswählen, und die gewählte Bande wird zweimal aktiviert. Daher sind Chaosbereich-Teams stärker auf die Zusammenarbeit zwischen den Banden angewiesen. Die Wahl der richtigen Bande kann die Stärke des Chaosbereich-Teams erheblich steigern!"
  },
  Tutorial_17823_Title_1 = {Text = "Chaos"},
  Tutorial_17824_Desc_1 = {
    Text = "Für jeden Punkt <TutorialHighlight:Alarm> erhältst du bei jedem Schild, das du erhältst, zusätzlich 1 Punkt Schild"
  },
  Tutorial_17824_Title_1 = {Text = "Wachsam"},
  Tutorial_17825_Desc_1 = {
    Text = "Nach Erstabschluss einer Ermittlung erhält man <TutorialHighlight: Resonanzaktivierungsmaterial>, das zur Aktivierung mächtiger <TutorialHighlight: Resonanz> verwendet werden kann, welche in allen Kapiteln dieser Episode wirksam ist"
  },
  Tutorial_17825_Title_1 = {Text = "Resonanz"},
  Tutorial_17826_Desc_1 = {
    Text = "Wenn sich unser Team im <TutorialHighlight:Wutversiegelung>-Status befindet, kann kein Wutausbruch ausgelöst werden. Bevor der Gegner <TutorialHighlight:Wutversiegelung> verursacht, kann ein Wutausbruch genutzt werden, um die Wut nicht zu verschwenden."
  },
  Tutorial_17826_Title_1 = {
    Text = "Wutversiegelung"
  },
  Tutorial_17827_Desc_1 = {
    Text = "Der Verbrauch von <TutorialHighlight:Geisterwissenextrakt> kann das Level des Erweckers erhöhen, nach dem Aufstieg des Erweckers werden die Attribute verbessert. Nach Erreichen der maximalen Stufe ist es notwendig, zuerst einen Aufstieg durchzuführen, um die Levelobergrenze des Erweckers zu erhöhen."
  },
  Tutorial_17827_Title_1 = {
    Text = "Geisterwissenextrakt"
  },
  Tutorial_17828_Desc_1 = {
    Text = "<TutorialHighlight:Stärke>Jeder Punkt weniger verringert den <TutorialHighlight:aktiven Schaden> um 1 Punkt"
  },
  Tutorial_17828_Title_1 = {Text = "STR▼"},
  Tutorial_17829_Desc_1 = {
    Text = "Vor jedem Schaden, immun gegen Schaden und entferne 1 Schicht <TutorialHighlight:Barriere>. Je höher der Schaden, desto höher der Nutzen der <TutorialHighlight:Barriere>"
  },
  Tutorial_17829_Title_1 = {Text = "Schild"},
  Tutorial_17830_Desc_1 = {
    Text = "Ein Ziel im <TutorialHighlight:Schwäche>-Zustand erleidet 25% weniger Schaden, 1 Schicht <TutorialHighlight:Schwäche> wird am Ende der Runde automatisch entfernt. Wenn unser Team im <TutorialHighlight:Schwäche>-Zustand ist, denke daran, vor dem ANG Wege zu finden, den <TutorialHighlight:Schwäche>-Zustand zu entfernen, oder ändere die Strategie und konzentriere dich in dieser Runde voll auf die VERT."
  },
  Tutorial_17830_Title_1 = {Text = "Schwäche"},
  Tutorial_17831_Desc_1 = {
    Text = "Besiege die Gegner in der <TutorialHighlight:Verbotenen Aufzeichnung>, um die Fähigkeit des Erweckers mit dem <TutorialHighlight:Bündnis> zu verbessern. Jedes abgeschlossene Hauptkapitel schaltet neue <TutorialHighlight:Verbotene Aufzeichnung>-Level frei. Bündnisse können auch im Geschäft eingetauscht werden."
  },
  Tutorial_17831_Title_1 = {
    Text = "Verbotene Aufzeichnung"
  },
  Tutorial_17832_Desc_1 = {
    Text = "Die temporäre Kopie der ersten <TutorialHighlight:Befehlskarte>, die das Hyperteam in jeder Runde spielt, gelangt in den <TutorialHighlight:Hyperraum> und löst einen mächtigen Sprungeffekt aus. Wenn der Hyperraum sein Limit erreicht, erhältst du eine zusätzliche <TutorialHighlight:Ultra-Runde>, <TutorialHighlight:In der Ultra-Runde können alle Sprungeffekte ausgelöst werden>. Der grundlegende Geheimtipp für das Spielen des Hyperteams: Plane sorgfältig die erste Karte, die du in jeder Runde spielst."
  },
  Tutorial_17832_Title_1 = {Text = "Ultra"},
  Tutorial_17833_Desc_1 = {
    Text = "Wenn die Lebenspunkte unseres Teams erschöpft sind, kann der <TutorialHighlight:Notfall-Gnosis-Körper> aktiviert werden, um alle Zustände wiederherzustellen. Der Notfall-Gnosis-Körper wird täglich automatisch um <TutorialHighlight:1> aufgefüllt, mit einem Maximum von <TutorialHighlight:5>. Setze den Notfall-Gnosis-Körper sinnvoll in <TutorialHighlight:hochschwierigen Kämpfen> ein und verschwende ihn nicht leichtfertig."
  },
  Tutorial_17833_Title_1 = {
    Text = "Notfall-Gnosis-Körper"
  },
  Tutorial_17834_Desc_1 = {
    Text = "Durchsuche sorgfältig die leicht leuchtenden Stellen auf der Karte, vielleicht findest du etwas Überraschendes"
  },
  Tutorial_17834_Title_1 = {
    Text = "Ausgangspunkt"
  },
  Tutorial_17835_Desc_1 = {
    Text = "Repräsentiert den gesamten Schaden aller Feinde in dieser Runde. Ein einfacher und praktischer Geheimhaltungstipp: <TutorialHighlight:Versuche, das Schild dem Gesamtschaden der Feinde anzupassen>"
  },
  Tutorial_17835_Title_1 = {
    Text = "Gesamtschaden des Feindes"
  },
  Tutorial_17837_Desc_1 = {
    Text = "Wenn die <TutorialHighlight:Embryofusion> des Fleisch-Teams ihr Limit erreicht, erhält man 1 <TutorialHighlight:„Embryo\">. Das Freigeben von Verherrlichung verbraucht <TutorialHighlight:„Embryo\"> und löst einen starken <TutorialHighlight:Verschlingen>-Effekt aus. Daher sollte die Verherrlichung möglichst freigegeben werden, wenn sich ein <TutorialHighlight:„Embryo\"> auf der Hand befindet; ansonsten kann das Fleisch-Team sein volles Potenzial nicht ausschöpfen."
  },
  Tutorial_17837_Desc_2 = {
    Text = "Am Ende jedes Kampfes wird eine Rückgewinnungsmenge von 5% des maximalen Lebens in den Blutroten Ofen angesammelt. Wenn ungenutzte <TutorialHighlight:“Embryo“> vorhanden sind, wird jeder Embryo ebenfalls 5% des maximalen Lebens in den Ofen ansammeln. Der Blutrote Ofen kann verwendet werden, um das Leben unseres Teams wiederherzustellen. Pro Runde kann der Ofen einmal in Leben umgewandelt werden. Der Schutzherr muss den Einsatzzeitpunkt des Blutroten Ofens sinnvoll planen, um den Kampfverlauf zu ändern."
  },
  Tutorial_17837_Title_1 = {Text = "Fleisch"},
  Tutorial_17838_Desc_1 = {
    Text = "An der Kontaktstelle kannst du wählen, ob du 50% des verlorenen Lebens unseres Teams wiederherstellen oder einen Erwecker bestimmen möchtest. Wenn das Leben unseres Teams niedrig ist, wird empfohlen, das Leben wiederherzustellen, andernfalls wird empfohlen, einen Erwecker zu erwecken."
  },
  Tutorial_17838_Title_1 = {
    Text = "Kontaktstelle"
  },
  Tutorial_17839_Desc_1 = {
    Text = "Ein Ort, um schwarze Siegel zu verbrauchen und unser Team zu verstärken, bietet normalerweise 1 Reihe Gebete, 1 Reihe silberne Relikte und 1 Reihe goldene Relikte an. Wenn hier keine benötigten Gegenstände vorhanden sind, kann man oben rechts auf <TutorialHighlight: Aktualisieren> klicken, die Fusionsnarbe wird neue Gegenstände bereitstellen."
  },
  Tutorial_17839_Title_1 = {
    Text = "Fusionsnarbe"
  },
  Tutorial_17840_Desc_1 = {
    Text = "Erzwungener Durchgang durch <TutorialHighlight:Illusion> wird eine „Symptom“-Infektion verursachen"
  },
  Tutorial_17840_Title_1 = {Text = "Illusion"},
  Tutorial_17841_Desc_1 = {
    Text = "Mit Befehlskarten erhältst du <TutorialHighlight:Wahnsinn>, je höher das Fähigkeitslevel, desto mehr Wahnsinn"
  },
  Tutorial_17841_Title_1 = {Text = "Aliemus"},
  Tutorial_17842_Desc_1 = {
    Text = "Gegner zu besiegen und Ereignisse zu untersuchen, kann <TutorialHighlight: das schwarze Siegel> einbringen. Die <TutorialHighlight: das schwarze Siegel> Rückfallattribute des Erweckers können die Anzahl der erhaltenen Siegel erhöhen"
  },
  Tutorial_17842_Desc_2 = {
    Text = "In der D-Marke kann man <TutorialHighlight: das schwarze Siegel> ausgeben, um Kleriker und Relikte zu kaufen, es kann auch verwendet werden, um den Awakener zu wecken. Vor dem Finalkampf versuche, all deine schwarzen Siegel auszugeben, um unser Team zu stärken"
  },
  Tutorial_17842_Title_1 = {
    Text = "Schwarzes Mal"
  },
  Tutorial_17843_Desc_1 = {
    Text = "Beim ANG erleidet der Angreifer Schaden, der der Anzahl der <TutorialHighlight: Gegenangriff> Schichten entspricht. Der <TutorialHighlight: Gegenangriff> Schaden kann <TutorialHighlight: nicht kritisch getroffen werden>"
  },
  Tutorial_17843_Title_1 = {
    Text = "Gegenangriff"
  },
  Tutorial_17844_Desc_1 = {
    Text = "Für jeden Punkt <TutorialHighlight:Stärke>, füge bei aktivem Schaden 1 zusätzlichen Schaden zu"
  },
  Tutorial_17844_Title_1 = {Text = "Stärke"},
  Tutorial_17845_Desc_1 = {
    Text = "Einsatz erwecken, um die Forschungsmission abzuschließen, nach Abschluss können entsprechende Belohnungen erhalten werden. Die Gesamtstufe der erweckten Einheiten<TutorialHighlight:Gesamtlevel> je höher, desto reichhaltiger die Belohnungen, maximal 240 Gesamtlevel"
  },
  Tutorial_17845_Title_1 = {Text = "Senden"},
  Tutorial_17847_Desc_1 = {
    Text = "Beim erlittenen tödlichen Schaden gibt es <TutorialHighlight: eine Chance, die dem Todwiderstand entspricht>, diesen Schaden zu immunisieren und 1 Lebenspunkt zu behalten, <TutorialHighlight: nach erfolgreichem Auslösen wird der Todwiderstand halbiert>. Der Todwiderstand des Teams entspricht der Summe aller Erwecker-Todwiderstände. Die Erhöhung des Team-Todwiderstands trägt zur Erhöhung der Fehlertoleranz im Kampf bei."
  },
  Tutorial_17847_Title_1 = {
    Text = "Todwiderstand"
  },
  Tutorial_17848_Desc_1 = {
    Text = "Beim Beginn des Kampfes im Tiefsee-Team wird 1 <TutorialHighlight:Tentakel> erzeugt, der am Rundenende den vorderen Feind angreift. Die aktuelle Tentakelschaden und die Anzahl der ANGe können durch die Formel unter dem Tentakel-Symbol nachvollzogen werden. Einige Erwecker können die Tentakelanzahl und den Tentakelschaden erhöhen und am Rundenende erheblichen Schaden verursachen."
  },
  Tutorial_17848_Title_1 = {Text = "Aequor"},
  Tutorial_17850_Desc_1 = {
    Text = "Das Ausspielen von Handkarten erfordert die Ausgaben von Arithmetica, am Ende der Runde gelangen alle Handkarten in <TutorialHighlight:Ablagestapel>. Eine sinnvolle Planung der <TutorialHighlight:Spielreihenfolge> wird der Schlüssel zum Kampfsieg sein"
  },
  Tutorial_17850_Title_1 = {Text = "Hand"},
  Tutorial_17851_Desc_1 = {
    Text = "Repräsentiert die Aktion, die der Feind in der nächsten Runde ausführen wird. Die Nutzung von <TutorialHighlight:Absichten> zur Entscheidungsfindung in dieser Runde ist der Kern des Kampfes"
  },
  Tutorial_17851_Title_1 = {
    Text = "Absicht des Feindes"
  },
  Tutorial_17852_Desc_1 = {
    Text = "<TutorialHighlight:Fähigkeitsaufwertung> verbessert die Eigenschaften des Erweckungskörpers und verstärkt die Effekte der Befehlskarten. Im Fähigkeiten-Interface des Erweckungskörpers kann man durch Klicken auf „Nächste Stufe“ die Effekte nach der Aufwertung vorab ansehen."
  },
  Tutorial_17852_Desc_2 = {
    Text = "Verschiedene Awakenings aus unterschiedlichen Domänen benötigen unterschiedliches <TutorialHighlight:Material für Fähigkeits-Upgrade>."
  },
  Tutorial_17852_Title_1 = {
    Text = "Fähigkeit stärken"
  },
  Tutorial_20768_Desc_1 = {
    Text = "Wenn ein Erweckter Körper Arithmetica verbraucht, erhält er <TutorialHighlight:Keyflare>. Das Attribut <TutorialHighlight:Keyflare-Regeneration> erhöht die Menge an erhaltenem <TutorialHighlight:Keyflare>."
  },
  Tutorial_20768_Title_1 = {Text = "Keyflare"},
  Tutorial_20769_Desc_1 = {
    Text = "<TutorialHighlight:verrostete Tür> wird wichtige Untersuchungspfade blockieren, versuche, in der Karte nach einem Objekt namens <TutorialHighlight:verrosteter Schlüssel> zu suchen, das zum Öffnen der <TutorialHighlight:verrosteten Tür> verwendet werden kann"
  },
  Tutorial_20769_Title_1 = {
    Text = "Rostige Tür"
  },
  Tutorial_20770_Desc_1 = {
    Text = "<TutorialHighlight:verrosteter Schlüssel> kann die <TutorialHighlight:verrostete Tür> öffnen, die deinen Fortschritt blockiert"
  },
  Tutorial_20770_Title_1 = {
    Text = "Rostiger Schlüssel"
  },
  Tutorial_20771_Desc_1 = {
    Text = "<TutorialHighlight:Lichtloses Reich> enthält eine Reihe von Leveln in vier Reichen. Nach dem Abschluss erhältst du Belohnungen wie Silber und Gnosis-Elixiere. Wenn die kumulierten Sternebewertungen die angegebenen Anforderungen erreichen, erhältst du zusätzlich Silber und Reine Kerne als Belohnungen!"
  },
  Tutorial_20771_Desc_2 = {
    Text = "Die Riss-Level in verschiedenen Reich werden Anforderungen an die Wecker im Ermittlungsteam stellen, nur <TutorialHighlight:erfüllende Mannschaften> können die Untersuchung durchführen"
  },
  Tutorial_20771_Title_1 = {
    Text = "Lichtloses Reich"
  },
  Tutorial_20772_Desc_1 = {
    Text = "Wenn die s-Energie <TutorialHighlight:1000> erreicht, kann das mitgeführte <TutorialHighlight:Posse> freigegeben werden. In jeder Runde können 2 Posse freigegeben werden, jedoch wird beim zweiten Freigeben ein Posse aus 3 zufälligen Posse ausgewählt, und der ausgewählte Posse kann in dieser Erkundung nicht erneut gewählt werden. Wählen Sie beim Formieren des Teams geeignete Posse aus, um den Erkundungsprozess reibungsloser zu gestalten."
  },
  Tutorial_20772_Title_1 = {Text = "Posse"},
  Tutorial_20773_Desc_1 = {
    Text = "Durch das Stapeln von identischen <TutorialHighlight:Schicksalsrad> kannst du die Eigenschaften und speziellen Fähigkeiten des Schicksalsrads verbessern. Bei 1 bis 3 Stapelungen wird der Effekt des Schicksalsrads verstärkt; bei 4 bis 15 Stapelungen werden die Eigenschaften des Schicksalsrads verbessert. Du kannst auf der Stapeloberfläche die Schaltfläche „Nächstes Level\" klicken, um die Änderungen nach dem Stapeln vorzuschauen."
  },
  Tutorial_20773_Title_1 = {
    Text = "Schicksalsrad-Stapel"
  },
  Tutorial_22247_Desc_1 = {
    Text = "<TutorialHighlight:Bündnis-Aufstieg> kann die Attributstärke des Bündnisses erhöhen, bis zu einem Maximum von Stufe 12. Die Zerschlagung des Bündnisses kann die entsprechenden Remnants einbringen, und durch Materialaustausch in den Ressourcen kann man <TutorialHighlight:Tausendgesichter-Stempel> erhalten. Für den Aufstieg des Bündnisses ist der Verbrauch von <TutorialHighlight:Tausendgesichter-Stempel> erforderlich, und die Zerschlagung eines bereits aufgestiegenen Bündnisses gibt auch den Verbrauch von <TutorialHighlight:Tausendgesichter-Stempel> zurück."
  },
  Tutorial_22247_Title_1 = {
    Text = "Bündnis Upgrade"
  },
  Tutorial_22248_Desc_1 = {
    Text = "Durch die Transkription kann <TutorialHighlight:Bündnis> zufällige Arten und Intensitäten von Attributen erhalten, die Nebenattributwerte sind unabhängig von den Körperteilen und können aus 8 Arten bestehen: kritischer Rate, kritischer Schaden, Wutregenerations-Level, Silberner Schlüssel Aufladelevel, Reichsbeherrschung, Siegelertrag, Schadenamplifikation, Todwiderstand. Bei der Transkription, wenn du ein bestimmtes Attribut beibehalten möchtest, kannst du <TutorialHighlight:Sperren> wählen, das gesperrte Attribut wird während der Transkription nicht verändert."
  },
  Tutorial_22248_Title_1 = {
    Text = "Bündnis Transkription"
  },
  Tutorial_23466_Desc_1 = {
    Text = "Mit dem Anstieg des Levels des Schutzherrn erhöht sich auch die <TutorialHighlight: Stärke von Relikten und Gebeten>, und die <TutorialHighlight: der Einfluss jeder Konstitution auf die Lebenspunkte des Teams> des Erweckers wird ebenfalls steigen. Durch Ermittlungseinsätze und Zwischenspiele kann eine große Menge an Schutzmeister-Erfahrung gesammelt werden. Für jeden Verbrauch von 1 Punkt Energie erhält man 1 Punkt Schutzmeister-Erfahrung."
  },
  Tutorial_23466_Title_1 = {
    Text = "Geheimnisträger-Level"
  },
  Tutorial_47538_Desc_1 = {
    Text = "Die Fusionskatastrophe Sperrzone ist ein herausforderndes Spielsystem. Der Schutzherr muss flexibel mehrere Herausforderungsgruppen kombinieren, um möglichst viele Trainingspunkte zu sammeln und somit mehr Belohnungen zu erhalten. Bei hoher Alarmstufe werden nicht nur die feindlichen Einheiten stärker, sondern es treten auch verschiedene negative Effekte auf."
  },
  Tutorial_47538_Desc_2 = {
    Text = "In der Fusionskatastrophe Sperrzone gibt es einzigartige Einschränkungsregeln: Der gleiche Erwecker und Schlüsselbefehl sowie Schicksalsräder mit demselben Namen können nicht erneut eingesetzt werden. Der Schutzherr kann basierend auf dem ursprünglichen Relikt, Monster und empfohlenem Level flexibel das Team für diese Herausforderung auswählen und die Strategie des Tian Ji-Pferderennens anwenden, um möglichst viele Trainingspunkte zu erzielen. Erwecker, die durch die <TutorialHighlight:Unterstützung> aufgestellt werden, sind von dieser Einschränkung nicht betroffen."
  },
  Tutorial_47538_Title_1 = {
    Text = "Fusionskatastrophe Sperrzone"
  },
  Tutorial_54390_Desc_1 = {
    Text = "Im <TutorialHighlight:Traphase>-Modus werden die Statuswerte der Erwecker beider Seiten im Kampfbereich unter deren Leben und Aelius angezeigt, und ihr Effekt kann durch Klicken aufgerufen werden"
  },
  Tutorial_54390_Desc_2 = {
    Text = "Folgende gehören zu den <TutorialHighlight:positiven Zuständen> (zum Anzeigen der Details klicken): <TauntKeywords:Verspotten>, <PVPPowerIconKeywords:Stärke>, <EnergyStorageKeywords:Aufladen>, <PVPProtectiveKeywords:Barriere>, <PVPRetaliateIconKeywords:Gegenangriff>, <ReinforceKeywords:Festung>, <StrengthenKeywords:Verstärkung>."
  },
  Tutorial_54390_Desc_3 = {
    Text = "Die folgenden gehören zu <TutorialHighlight:negative Zustände> (klicken Sie hier für Details): <PVPEntanglementKeywords:Umschlingen>, <PVPVulnerabilityIconKeywords:Verwundbar>, <PVPSlowKeywords:Stagnierung>, <ComaKeywords:Versteinern>, <DisarmKeywords:Lähmung>, <PVPMethysisKeywords:Gift>, <PVPEmptinessKeywords:Leere>, <PVPBleedingKeywords:Bluten>, <PVPSeriousInjuryKeywords:Verderben>, <ComaKeywords:Ohnmächtig>."
  },
  Tutorial_54390_Title_1 = {Text = "Zustand"},
  Tutorial_54391_Desc_1 = {
    Text = "Im <TutorialHighlight:Phasenduell> Modus haben einige Erwecker Karten mit unterschiedlichen <TutorialHighlight:Affix>-Effekten, die im <TutorialHighlight:Sammlung> System eingesehen oder durch langes Drücken der Karten im Kampf angezeigt werden können. Zu den Affixen gehören (klicken Sie hier für Details): <PVPPenetrateKeywords:Durchstechen>, <PrepareKeywords:Vorbereiten>, <PVPResurrectionKeywords:Wiederbelebung>, <PVPHoldingKeywords:In Hand>, <PhantomKeywords:Phantom>, <PVPRaidKeywords:Hinterhalt>."
  },
  Tutorial_54391_Title_1 = {Text = "Affix"},
  Tutorial_54392_Desc_1 = {
    Text = "Im <TutorialHighlight:Phasenduell> Modus werden die Rangpunkte mit dem Ende und Beginn der Saison zurückgesetzt. Informationen wie der Name und die Dauer der Saison können auf der rechten Seite des Bildschirms eingesehen werden. Bei der Rücksetzung der Punkte werden die Punkte der letzten Saison, die 1.000 übersteigen, für die Spieler halbiert."
  },
  Tutorial_54392_Desc_2 = {
    Text = "Während jeder Saison gibt es <TutorialHighlight:Saison-Quests>. Schließe Saison-Quests ab, um großzügige Belohnungen zu erhalten. Saison-Quests werden zurückgesetzt, wenn die Saison aktualisiert wird."
  },
  Tutorial_54392_Title_1 = {Text = "Saison"},
  Tutorial_54393_Desc_1 = {
    Text = "Im <TutorialHighlight:Phasenduell> Modus, wenn der Erwecker stirbt, werden die Karten in der Hand, die zu diesem Erwecker gehören, zu <TutorialHighlight:Illusion>. Wenn man <TutorialHighlight:Schicksalsrad> einem verstorbenen Erwecker anlegt, erhält man ebenfalls 1 Illusion und die verbrauchten Arithmetica werden zurückerstattet. Illusionen können auch durch die Effekte bestimmter Schicksalsräder in <TutorialHighlight:Kleiner Wunsch> synthetisiert werden."
  },
  Tutorial_54393_Title_1 = {Text = "Illusion"},
  Tutorial_54394_Desc_1 = {
    Text = "Im <TutorialHighlight:Phasenduell> Modus haben beide Seiten in der ersten Runde jeweils 3 Punkte <TutorialHighlight:Arithmetica> und Obergrenze, und der Nachziehende erhält eine <TutorialHighlight:Schlag zuletzt, schlag am besten> Karte als Entschädigung. Danach erhöht sich die Obergrenze der Arithmetica und die Antwortmenge zu Beginn jeder Runde um 1 Punkt bis zu 10 Punkten. Neben dem automatischen Wachstum gibt es auch andere Möglichkeiten, die Obergrenze der Arithmetica zu erhöhen oder zu senken. Wenn die Obergrenze von 10 Punkten erreicht ist, wird jeder zusätzliche Punkt, der über das Limit hinausgeht, durch das Ziehen von 1 Karte ersetzt."
  },
  Tutorial_54394_Title_1 = {
    Text = "Arithmetica"
  },
  Tutorial_54395_Desc_1 = {
    Text = "Im <TutorialHighlight:Phasenduell>-Modus hat jeder Erwecker auch <TutorialHighlight:Aliemus> und <TutorialHighlight:Verherrlichung>. Wahnsinn kann durch den Einsatz von <TutorialHighlight:Schlag>-Karten oder bestimmten <TutorialHighlight:Fähigkeits>-Karten erhalten werden. Auch beim Erleiden von Schaden und Verlust von LP wird Wahnsinn gewonnen (für jeden Verlust von 2% LP oder gleichwertigem Schild erhält man 1 Punkt Wahnsinn). Wenn der Wahnsinn 100 erreicht, klicke auf den entsprechenden Erwecker, um die Verherrlichung auszuwählen."
  },
  Tutorial_54395_Title_1 = {Text = "Aliemus"},
  Tutorial_54396_Desc_1 = {
    Text = "Im <TutorialHighlight:Traphase>-Modus kannst du durch das Abschließen bestimmter Ziele in den \"Spielaufzeichnungen\" während des Matchmakings entsprechende Belohnungen beanspruchen. Diese Belohnung ist eine einmalige Belohnung, die sich nicht mit der Saison zurücksetzt und über die \"Spielaufzeichnungen\" in der unteren linken Ecke der Benutzeroberfläche angezeigt werden kann."
  },
  Tutorial_54396_Title_1 = {
    Text = "Schachrekord"
  },
  Tutorial_54397_Desc_1 = {
    Text = "Im <TutorialHighlight:Traphase> Modus kann man im linken „Sammlung“ Tab des Bildschirms alle Informationen über Erwecker, Rad des Schicksals und Bande durchsehen"
  },
  Tutorial_54397_Title_1 = {Text = "Sammlung"},
  Tutorial_54398_Desc_1 = {
    Text = "Im <TutorialHighlight:Traphase> Modus hat jeder Erwecker 2 Karten <TutorialHighlight:ANG> und 3 Karten <TutorialHighlight:Fähigkeit>. Normalerweise haben verschiedene Fähigkeit-Karten unterschiedliche Arithmetica Verbrauch"
  },
  Tutorial_54398_Title_1 = {Text = "Fähigkeit"},
  Tutorial_54399_Desc_1 = {
    Text = "Im <TutorialHighlight:Phasenduell> Modus beträgt die automatische Anzahl der zu ziehenden Karten pro Runde ebenfalls 5, und die standardmäßige <TutorialHighlight:Maximale Handgröße> beträgt 10. In der rechten unteren Ecke des Kampfbildschirms kann man die aktuelle Anzahl der eigenen Handkarten sowie die maximale Handgröße sehen, während man in der oberen rechten Ecke die Situation des Gegners einsehen kann. Es gibt verschiedene Möglichkeiten, um die Anzahl der zu ziehenden Karten pro Runde und die maximale Handgröße zu verändern."
  },
  Tutorial_54399_Title_1 = {Text = "Hand"},
  Tutorial_54400_Desc_1 = {
    Text = "Im <TutorialHighlight:Phasenduell> Modus haben verschiedene Erwecker unterschiedliche <TutorialHighlight:Positionierungen>, insgesamt 5. Diese sind <TutorialHighlight:Wächter>, <TutorialHighlight:Kampf>, <TutorialHighlight:Luminis>, <TutorialHighlight:Unheilvoller Stern> und <TutorialHighlight:Segen>. Bei der <TutorialHighlight:Formation> müssen 4 Erwecker mit unterschiedlichen Positionierungen ausgewählt werden, um ein Team zu bilden."
  },
  Tutorial_54400_Title_1 = {Text = "Standort"},
  Tutorial_54401_Desc_1 = {
    Text = "Im <TutorialHighlight:Traphase-All Pick> Modus gelangt man durch Klicken auf „Start Matching“ in der rechten unteren Ecke des Bildschirms in die Aufstellungsoberfläche. Man kann auch sein Team im <TutorialHighlight:All Pick Lineup> auf der linken Seite der Oberfläche vorab zusammenstellen."
  },
  Tutorial_54401_Desc_2 = {
    Text = "Mehrere Teamaufstellungen können gespeichert werden, der Name kann oben links bearbeitet werden. Jedes Team besteht aus 4 Erwachten, 4 Schicksalsrädern und 2 Schlüsselbefehlen"
  },
  Tutorial_54401_Title_1 = {Text = "Formation"},
  Tutorial_54705_Desc_1 = {
    Text = "Im <TutorialHighlight:Traphase> Modus kann man auf sein <TutorialHighlight:Avatar> klicken und den gewünschten <TutorialHighlight:Duell-Ausdruck> auswählen, um dem Gegner seine Absichten mitzuteilen!"
  },
  Tutorial_54705_Title_1 = {Text = "Emoji"},
  Tutorial_54706_Desc_1 = {
    Text = "<TutorialHighlight:Traphase> ist ein Zwei-Spieler-Du-Battle-Spiel, bei dem beide Seiten ihre eigenen vorgefertigten Teams zu <TutorialHighlight:match ebenso> verwenden, während der Verbindung vergleichbare Gegner matched werden"
  },
  Tutorial_54706_Desc_2 = {
    Text = "Verdiene <TutorialHighlight:Alle Auswahl-EXP> und <TutorialHighlight:Draft Pick EXP> durch Kämpfe. Basierend auf der gesammelten Erfahrung kannst du <TutorialHighlight:einmalige Belohnungen> in <TutorialHighlight:Alle Auswahlstufen> und <TutorialHighlight:Draft Pick Stufen> freischalten!"
  },
  Tutorial_54706_Desc_3 = {
    Text = "Jede Woche erhältst du basierend auf der Punktzahl-Rangliste einen <TutorialHighlight:Titel> und am nächsten Tag <TutorialHighlight:Rosenskript>.\nWenn du sowohl am „Phasenduell\" als auch am „Traumtauchen\" teilgenommen hast, wird die Abrechnung des Rosenskripts auf Grundlage der <TutorialHighlight:höheren> Belohnung aus diesen beiden Spielmodi erfolgen."
  },
  Tutorial_54706_Title_1 = {
    Text = "Einführung in das Duell"
  },
  Tutorial_74798_Desc_1 = {
    Text = "In verschiedenen Levels gibt es unterschiedliche <TutorialHighlight:Level-Kapitel>-Umgebungen, die die allgemeinen Regeln und Schöpfungseffekte stark verändern. Details dazu findest du in den jeweiligen Level-Oberflächen, indem du die entsprechenden Registerkarten anklickst."
  },
  Tutorial_74798_Title_1 = {
    Text = "Abschnitt des Levels"
  },
  Tutorial_81370_Desc_1 = {
    Text = "<TutorialHighlight:Wachkörper-Retrospektive> kann die verschiedenen Entwicklungsressourcen des Wachkörpers erstatten."
  },
  Tutorial_81370_Desc_2 = {
    Text = "<TutorialHighlight:Zucht-Rückverfolgung> setzt das Erwachende Wesen auf Stufe 1 zurück und entfernt Aufstiege, Fähigkeiten und den Status der vertieften Erkenntnis. Alle verbrauchten Materialien und Goldmarken werden vollständig erstattet."
  },
  Tutorial_81370_Desc_3 = {
    Text = "<TutorialHighlight:Geistige Rückverfolgung> setzt den Erwachungsstatus des Erwachungskörpers vollständig zurück und entfernt auch die durch die Erweckung erreichte Stufengrenze. Alle verbrauchten Materialien werden zurückerstattet."
  },
  Tutorial_81370_Desc_4 = {
    Text = "<TutorialHighlight:Schwarzer Pool zurückgeben> enthält den Effekt “Entwicklungs-Rückkehr“ und setzt zusätzlich den Wachkörper selbst auf den Zustand zurück, als er noch nicht freigeschaltet war."
  },
  Tutorial_81370_Title_1 = {
    Text = "Erwachte Rückschau"
  },
  Tutorial_81371_Desc_1 = {
    Text = "<TutorialHighlight:Erwachener Körper-Upgrade> ist eine der effektivsten Möglichkeiten, die Eigenschaften des Erwachten Körpers zu verbessern. Der Verbrauch von <TutorialHighlight:Geistessubstanz> kann das Erwachenen-Körper-Level erhöhen."
  },
  Tutorial_81371_Desc_2 = {
    Text = "Nachdem der Erweckungskörper das maximale Level erreicht hat, ist es notwendig, die Obergrenze durch <TutorialHighlight:Aufstieg> zu erhöhen. Für Erweckungskörper unterschiedlicher Domänen werden unterschiedliche <TutorialHighlight:Aufstiegsmaterialien> benötigt."
  },
  Tutorial_81371_Title_1 = {
    Text = "Erweckter Körper Upgrade"
  },
  Tutorial_81372_Desc_1 = {
    Text = "<TutorialHighlight:Erweckungsaktivierung> kann die Effekte der Befehlskarten des Erweckers erheblich verbessern. Erleuchtungsstufe 7 schaltet <TutorialHighlight:Übertriebene Verherrlichung> frei, wodurch der Erwecker bei der Verherrlichung zusätzliche Effekte erhält. Erleuchtungsstufen 11 und 15 erhöhen die maximale Stufe des Erweckers um 5"
  },
  Tutorial_81372_Title_1 = {
    Text = "Erleuchten aktiviert"
  }
})
return Text_Tutorial
