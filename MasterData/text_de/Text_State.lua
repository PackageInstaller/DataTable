__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_State = readonly({
  State_100291_Desc = {
    Text = "Alle Erwachten erzeugen 50% mehr Wahnsinn."
  },
  State_100291_Name = {
    Text = "Entblößung"
  },
  State_100292_Name = {
    Text = "Rundenbeginn"
  },
  State_100293_Desc = {
    Text = "Alle Erwachten haben 50% weniger Wahnsinn, am Ende der Runde erhalten sie 1 Schicht “<DarkEgo:Dunkle Seite des Selbst>“: Zu Beginn der Runde erhalten alle Erwachten 3 Wahnsinn."
  },
  State_100293_Name = {
    Text = "Persönlichkeitsschatten"
  },
  State_100295_Name = {
    Text = "Schaden Überwachung"
  },
  State_100296_Desc = {
    Text = "Für jede Schicht erhalten alle Erwachten zu Beginn der Runde <Energy:3> Wahnsinn."
  },
  State_100296_Name = {
    Text = "Selbstdunkelheit"
  },
  State_100297_Desc = {
    Text = "Am Ende der Runde erhältst du einen Schild, der 20% der maximalen Gesundheit entspricht."
  },
  State_100297_Name = {
    Text = "Seelenbarriere"
  },
  State_100298_Desc = {
    Text = "Zu Beginn der Runde verliere 10% deines aktuellen Lebens und erhalte [DescArg1] Stärke."
  },
  State_100298_Name = {
    Text = "Barrierenzerfall"
  },
  State_100299_Desc = {
    Text = "Exalt Count"
  },
  State_100299_Name = {
    Text = "Exalt Count"
  },
  State_100302_Name = {
    Text = "Exaltieren hören"
  },
  State_100307_Desc = {
    Text = "Team-Unique: Nach der Freisetzung von Wut-Exaltation erhält der Ausrüster 1 Stapel “Co-Creation“. In dieser Runde kann die nächste Wahnexplosion anderer Erwachter “Co-Creation“ verbrauchen, um die kritische Trefferchance dieser Wahnexplosion um <WeaponEffect_Num:[StateArg1]%> zu erhöhen und dem Erwecker, der “Co-Creation“ verbraucht, <WeaponEffect_Num:[StateArg1]%> Wahnsinn basierend auf der Wiederherstellung des Ausrüsters zu gewähren."
  },
  State_100307_WeaponDesc = {
    Text = "Nach dem Einsatz von Wut-Exaltation erhält der Ausrüster 1 Stapel “Co-Creation“. In dieser Runde kann die nächste Wahnexplosion anderer Erwachter “Co-Creation“ verbrauchen, um die kritische Trefferchance dieser Wahnexplosion um <WeaponEffect_Num:[StateArg1]%> zu erhöhen und dem Erwecker, der “Co-Creation“ verbraucht, <WeaponEffect_Num:[DescArg1]> Punkte Wahnsinn zu gewähren."
  },
  State_100326_Desc = {
    Text = "Für jede Schicht erhalten alle Erwachten zu Beginn der Runde <Energy:3> Wahnsinn."
  },
  State_100326_Name = {
    Text = "<DarkEgo:Selbst dunkle Seite>"
  },
  State_100327_Desc = {
    Text = "Am Ende der Runde erhältst du einen Schild, der 20% der maximalen Gesundheit entspricht."
  },
  State_100327_Name = {
    Text = "<MindWall:Seelenbarriere>"
  },
  State_100328_Desc = {
    Text = "Alle Erwachten erzeugen 50 % mehr Wahnsinn."
  },
  State_100328_Name = {
    Text = "<TrueConfess:Offenbarung>"
  },
  State_100329_Desc = {
    Text = "Alle Erwachten haben 50% weniger Wahnsinn, am Ende der Runde erhalten sie 1 Schicht “<DarkEgo:Dunkle Seite des Selbst>“: Zu Beginn der Runde erhalten alle Erwachten 3 Wahnsinn."
  },
  State_100329_Name = {
    Text = "<ShadowSelf:Persönlichkeits Schatten>"
  },
  State_100330_Desc = {
    Text = "Zu Beginn der Runde verliere 10% deines aktuellen Lebens und erhalte [DescArg1] Punkte <PowerIconKeywords:Stärke>."
  },
  State_100330_Name = {
    Text = "<BarrierCrash:Barrierenzerfall>"
  },
  State_100395_Name = {
    Text = "Erschaffenes Blut der Gnade+"
  },
  State_100396_Name = {
    Text = "Erschaffenes Blut der Gnade"
  },
  State_100527_Desc = {
    Text = "Wenn Pickman den Effekt “Entdecken“ auslöst, füge zusätzlich die Option “Inspiration entfesseln!“ hinzu: Verbrauche 1 Schicht “Wahnsinn“, wähle alle Effekte und erhalte 1 Schicht “Kreativität“."
  },
  State_100527_Name = {Text = "Rhapsodie"},
  State_100541_Desc = {
    Text = "Wenn du aktuell 10 Schichten “Kreativität“ hast, verbraucht Pickman nach der Auslösung der Wahnsinnsexplosion alle “Kreativität“, erhält 1 Schicht Wahnsinn und lässt alle Erwachten 15 Punkte Wahnsinn erhalten. Die Obergrenze für Kreativität beträgt 10 Schichten und kann in den nächsten Kampf übertragen werden."
  },
  State_100541_Name = {
    Text = "<Chuangyi:Kreativität>"
  },
  State_100542_Desc = {
    Text = "Wenn Pickman den Effekt “Entdecken“ auslöst, füge zusätzlich die Option “Inspiration entfesseln!“ hinzu: Verbrauche 1 Schicht “Wahnsinn“, wähle alle “Entdecken“-Effekte und erhalte 1 Schicht “Kreativität“."
  },
  State_100542_Name = {
    Text = "<Kuangxiang:Rhapsodie>"
  },
  State_100544_Name = {
    Text = "süße Schnecke"
  },
  State_100544_WeaponDesc = {
    Text = "Der Schild und die Lebensregeneration des Trägers werden um 6% erhöht. Wenn die Domänenbeherrschung des Trägers über 50 liegt, wird der Schild und die Lebensregeneration zusätzlich um 6% erhöht"
  },
  State_100545_Name = {
    Text = "süße Schnecke"
  },
  State_100545_WeaponDesc = {
    Text = "Der Schild und die Lebensregeneration des Trägers werden um 6% erhöht. Wenn die Domänenbeherrschung des Trägers über 50 liegt, wird der Schild und die Lebensregeneration zusätzlich um 6% erhöht"
  },
  State_100558_Desc = {
    Text = "In dieser Runde erhöht sich die kritische Trefferchance der nächsten Wahnexplosion anderer Erwachter um [StateArg1]%, nach Verwendung erhältst du [DescArg1] Punkte Wahnsinn."
  },
  State_100558_Name = {
    Text = "Co-Creation"
  },
  State_100559_Desc = {
    Text = "Enthält folgende “SternenArtikel Schöpfungen“: Böse Buben, Frühlingsfest, Schweres Schloss, Seidenachat, Blut der Gnade, Rostige Metallsäge, Goldenes Traumland, Blutiger Kieselstein."
  },
  State_100559_Name = {
    Text = "<Chuanggouzaowu:Konstruiertes Artefakt>"
  },
  State_100562_Desc = {
    Text = "Die nächste [Layer] Befehlskarten, die in dieser Runde gespielt werden, haben Arithmetica-Kosten -2."
  },
  State_100562_Name = {
    Text = "Wahrheit, ist auch Fantasie"
  },
  State_100564_Desc = {
    Text = "Enthält folgende “Orison“: Planung, Zauberhafte Hände, Wahnsinn, Katalysator, Rohheit, Eisenwand, Erschöpfung, Inspiration."
  },
  State_100564_Name = {
    Text = "<Chuanggoukeyin:Konstruiertes Siegel>"
  },
  State_100566_WeaponDesc = {
    Text = "Ändere die Arithmetica Kosten der Karte vor dem Spielen"
  },
  State_100617_Desc = {
    Text = "Am Ende der Runde, erhalte 1 Tentakel-Limit."
  },
  State_100617_Name = {
    Text = "Abgründige Besessenheit"
  },
  State_100619_Desc = {
    Text = "Wenn die Stärke verringert wird, wird nur 50% der Stärkeschichten reduziert"
  },
  State_100619_Name = {
    Text = "Erschöpfungswiderstand"
  },
  State_100621_Desc = {
    Text = "Jede Schicht verringert den Grundschaden des Spielers um 25% und kann die Richtung für das spätere Navigieren angeben."
  },
  State_100621_Name = {
    Text = "schwaches Kerzenlicht"
  },
  State_100623_Desc = {
    Text = "Jede Schicht verringert den Grundschaden des Spielers um 50 %. Nach aktivem oder Tentakelschaden wird der eigene [DescArg1] Giftwert verringert."
  },
  State_100623_Name = {
    Text = "Verirrtes Licht"
  },
  State_100639_Desc = {
    Text = "Verursachter Tentakelschaden vorübergehend um 50 % reduziert."
  },
  State_100639_Name = {
    Text = "Verlorene Stadt Lemuria"
  },
  State_100644_Desc = {
    Text = "Permanente Senkung der Zielstärke, erhalte entsprechend Stärke."
  },
  State_100644_Name = {
    Text = "<TouquKeywords: Permanente Stehlen>"
  },
  State_100647_Desc = {
    Text = "Immun gegen jeglichen Schaden."
  },
  State_100647_Name = {
    Text = "Immun gegen jeglichen Schaden."
  },
  State_100694_Desc = {
    Text = "Jede Schicht verringert den vom Spieler verursachten Grundschaden um 30 %. Nach dem Verursachen von aktivem oder Tentakelschaden wird das eigene Gift verringert."
  },
  State_100694_Name = {
    Text = "Verirrtes Licht"
  },
  State_116342_Desc = {
    Text = "Spiele eine <ErosionColorInkKeywords:Wahrnehmungsverzerrung>-Karte, um „Der Maler\" 1 Schicht <DecayDye:Phantasma-Farbe> zu gewähren."
  },
  State_116342_Name = {
    Text = "Fremdartige Farbpalette"
  },
  State_116406_Name = {
    Text = "Fortschritt"
  },
  State_116407_Name = {
    Text = "leerer Status"
  },
  State_116858_Desc = {
    Text = "Dieser Zustand verwendet den Verwundbarkeitsmultiplikator und gibt vor, ein unabhängiger Multiplikator zu sein.__“Nur für Entwicklungszwecke“"
  },
  State_116858_Name = {
    Text = "Wenn ein bestimmter Zustand vorhanden ist, wird der Schaden verdoppelt__“Nur für Entwicklungszwecke“"
  },
  State_116859_Desc = {
    Text = "Nach Beginn der nächsten Runde, erhalte Zögern."
  },
  State_116859_Name = {
    Text = "Verzögerung Zögern"
  },
  State_116958_Desc = {
    Text = "Nach dem Ausspielen der Karte erleidet man Schaden entsprechend der Schichten."
  },
  State_116958_Name = {
    Text = "<PVPCardLockColour:Kartenverschluss>"
  },
  State_117154_Desc = {
    Text = "Dieser Effekt wirkt nur einmal auf alle Erwecker im Team und kann nicht wiederholt ausgelöst werden."
  },
  State_117154_Name = {
    Text = "<TeamUnique: Team Unique>"
  },
  State_117212_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Vor „Fähigkeit\" und am Zugende wird dem Feind mit <HPAndShieldMax:höchstem Leben und Schild> <Damage:[Damage:StateArg1]> Stapel <PVPCorrosionKeywords:Sündenmal> auferlegt."
  },
  State_117212_Name = {Text = "Pollux"},
  State_117213_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Bei der “Fähigkeit“ und am Ende der Runde fügt dem Gegner mit dem höchsten Aliemus [StateArg1] <PVPfengsuoKeywords:Verherrlichungssperre> zu."
  },
  State_117213_Name = {
    Text = "Pollux SR (Vorübergehender Text)"
  },
  State_117346_Desc = {
    Text = "Pollux verursachter Schaden fügt [Layer]% Bluten hinzu."
  },
  State_117346_Name = {Text = "Sündenmal"},
  State_117355_Desc = {
    Text = "Die nächste von Pollux gespielte Befehlskarte wirkt 2 Mal."
  },
  State_117355_Name = {
    Text = "Göttliche Offenbarung des Neuen Bundes"
  },
  State_117357_Desc = {
    Text = "Team Unique: Nach dem Aktualisieren von “Fusionsnarbe“ und “Asche der Ruinen“ erhält der Ausrüster <WeaponEffect_Num:[StateArg1]> Punkte Aliemus."
  },
  State_117357_WeaponDesc = {
    Text = "“Fusionsnarbe“ und “Asche der Ruinen“ werden aktualisiert und geben dem Ausrüster <WeaponEffect_Num:[StateArg1]> Punkte Aliemus."
  },
  State_117358_Desc = {
    Text = "Jede Schicht fügt dem von Pollux verursachten Schaden 1 % Bluten hinzu."
  },
  State_117358_Name = {
    Text = "<ZuiyinKeywords:Sündenmal>"
  },
  State_117744_Desc = {
    Text = "<MaxHPKeywords:Max LP> –[Layer]. Beim Auslösen erleidet das Ziel [Layer] passiven Schaden, permanent. Beim Vertreiben wird das verlorene maximale Leben nicht zurückgegeben."
  },
  State_117744_Name = {Text = "Sündenmal"},
  State_117745_Desc = {
    Text = "Jede Stapelung reduziert die <MaxHPKeywords:Max LP> des Ziels. Beim Auslösen des Sündenmales erleidet das Ziel passiven Schaden entsprechend der Stapelungen. Beim Vertreiben wird das verlorene maximale Leben nicht zurückgegeben."
  },
  State_117745_Name = {
    Text = "<PVPCorrosionKeywords:Sündenmal>"
  },
  State_117755_Desc = {
    Text = "Vor Rundenende, keine Aktionen möglich"
  },
  State_117755_Name = {
    Text = "Ohnmächtig"
  },
  State_117756_Desc = {
    Text = "Vor Rundenende, keine Aktionen möglich"
  },
  State_117756_Name = {
    Text = "Ohnmächtig"
  },
  State_117776_Desc = {
    Text = "Innerhalb dieser Runde wird der endgültige Schaden und der Schild von [Layer] Befehlskarten um [StateArg1] % erhöht."
  },
  State_117776_Name = {
    Text = "Götterflamme"
  },
  State_117777_Desc = {
    Text = "Team Unique: Der Grundschaden und der kritische Schaden der Karten des Ausrüsters erhöhen sich um <WeaponEffect_Num:[StateArg1]%. Zu Beginn der Runde und nach dem Auslösen der Verherrlichung erhält der Ausrüster 1 Schicht Herzfeuer. Wenn der Ausrüster in dieser Runde eine Befehlskarte spielt, wird 1 Schicht “Herzfeuer“ verbraucht, was den Gesamtschaden und den Schild um <WeaponEffect_Num:[StateArg2]%> erhöht. In der Ultra-Runde wird stattdessen “Götterflamme“ erhalten, der Effekt wird verdoppelt."
  },
  State_117777_WeaponDesc = {
    Text = "Der Grundschaden und der kritische Schaden der Karten des Ausrüsters erhöhen sich um <WeaponEffect_Num:[StateArg1]%. Zu Beginn der Runde und nach dem Einsatz von Verherrlichung erhält der Ausrüster 1 Schicht Herzfeuer. Wenn der Ausrüster in dieser Runde eine Befehlskarte spielt, wird 1 Schicht “Herzfeuer“ verbraucht, wodurch der Gesamtschaden und der Schild um <WeaponEffect_Num:[StateArg2]%> erhöht werden. In der Ultra-Runde wird stattdessen “Götterflamme“ erhalten, und der Effekt wird verdoppelt."
  },
  State_117778_Desc = {
    Text = "In dieser Runde erhöht sich der Gesamtschaden und Schutzschild der [Layer] Befehlskarten um [StateArg1] %."
  },
  State_117778_Name = {Text = "Herzfeuer"},
  State_117779_Desc = {
    Text = "Team Unique: In der Ultra-Runde erhält der Ausrüster 3 Schichten “Herzfeuer“. Wenn der Ausrüster in dieser Runde eine Befehlskarte spielt, wird 1 Schicht verbraucht, wodurch der Gesamtschaden und der Schild um <WeaponEffect_Num:[StateArg1]%> erhöht werden."
  },
  State_117779_WeaponDesc = {
    Text = "Im Ultra-Runde erhält der Ausrüster 3 Schichten “Herzfeuer“. Wenn der Ausrüster in dieser Runde eine Befehlskarte spielt, wird 1 Schicht verbraucht, wodurch der Gesamtschaden und der Schild um <WeaponEffect_Num:[StateArg1]%> erhöht werden."
  },
  State_117851_Desc = {
    Text = "Pollux erhält für jede Befehlskarte zusätzlich 50% Effekt von “Qual Erlösung“, der [Layer] Runden anhält."
  },
  State_117851_Name = {
    Text = "Licht der weißen Nacht"
  },
  State_117853_Desc = {
    Text = "Pollux: Der Schaden der nächsten [Layer] Befehlskarten, die in dieser Runde gespielt werden, wird um [DescArg1] erhöht, der Schild um [DescArg2] erhöht, und erhält 10 Punkte Aliemus."
  },
  State_117853_Name = {
    Text = "Qual Erlösung"
  },
  State_117869_Desc = {
    Text = "Nach jeder Auslösung von Verherrlichung erhältst du 1 Schicht „Ruf“, jede Schicht Ruf gibt dir [DescArg1] Punkte Stärke, maximal 5 Schichten."
  },
  State_117869_Name = {
    Text = "Oberster Priester des Meeresreichs"
  },
  State_117870_Desc = {
    Text = "Nach dem Tod stellt der Töter 10% des verlorenen Lebens wieder her."
  },
  State_117870_Name = {
    Text = "Leckeres Sashimi"
  },
  State_117875_Desc = {
    Text = "Falls im hinteren Bereich Platz vorhanden ist, verliere 1 Schicht nach der Aktion und beschwöre 1 speziellen “Aequor-Fliegenden Fisch“."
  },
  State_117875_Name = {
    Text = "Vorbereiten, um “Aequor-Fliegender Fisch“ zu beschwören"
  },
  State_117876_Desc = {
    Text = "Schwäche-, Zerbrechlich- und Verderbenseffekte auf 50 % erhöht."
  },
  State_117876_Name = {
    Text = "Schwäche&Zerbrechlich&Schwere Verletzung Vertiefung"
  },
  State_117880_Desc = {
    Text = "In diesem Kampf wird der “Schwarm-Sprung“ zusätzlich 1 Mal ausgelöst."
  },
  State_117880_Name = {
    Text = "Fischschwarm springt zusätzlich ausgelöst"
  },
  State_117883_Desc = {
    Text = "Bei Erreichen von 5 Schichten werden alle Erwecker sofort versiegelt, und die Absicht wird geändert in: “Ruhm von Lemuria!+“."
  },
  State_117883_Name = {Text = "Ruf"},
  State_117885_Desc = {
    Text = "Beim Erleiden des Effekts der Machtminderung wird auch beim Anwender der gleiche Effekt der Machtminderung verursacht."
  },
  State_117885_Name = {
    Text = "Auge um Auge"
  },
  State_117889_Desc = {
    Text = "Beim Betreten des Kampfes erhöht sich das eigene maximale Leben um 10% und gewährt anderen Verbündeten [DescArg1] Punkte <PowerIconKeywords:Stärke>, wodurch die Lebenssteigerung und der Effekt der Kraftgewinnung für <FishLeapWords:Fischschwarm-Sprung> in diesem Kampf zusätzlich 1 Mal ausgelöst werden."
  },
  State_117889_Name = {
    Text = "Fischschwarm springt"
  },
  State_118112_Desc = {
    Text = "Der maximale einmalige Schaden beträgt [DescArg1] Punkte und wird entfernt, wenn die Gesundheit unter 50 % fällt."
  },
  State_118112_Name = {
    Text = "Schild der Tiefsee I"
  },
  State_118113_Desc = {
    Text = "Nach aktivem Schaden und Verlust von Leben erhältst du einen Schild, der 15% des verlorenen Lebens entspricht, und temporäre <AlertIconKeywords:Vorsicht>, die 5% des verlorenen Lebens beträgt."
  },
  State_118113_Name = {
    Text = "Weiche Körperkonstitution I"
  },
  State_118114_Desc = {
    Text = "Nach aktivem Schaden und Verlust von Leben erhältst du einen Schild, der 35% des verlorenen Lebens entspricht, und temporäre <AlertIconKeywords:Vorsicht>, die 10% des verlorenen Lebens beträgt."
  },
  State_118114_Name = {
    Text = "Weiche Körperkonstitution III"
  },
  State_118115_Desc = {
    Text = "Falls im vorderen Bereich Platz vorhanden ist, verliere 1 Schicht nach der Aktion und beschwöre 1 “Seefahrer-Klumpen“."
  },
  State_118115_Name = {
    Text = "Vorbereiten, um “Seefahrer-Klumpen“ zu beschwören"
  },
  State_118116_Desc = {
    Text = "Der maximale Einzel-Schaden beträgt [DescArg1] Punkte und wird entfernt, wenn die Gesundheit unter 50 % fällt."
  },
  State_118116_Name = {
    Text = "Schild der Tiefsee II"
  },
  State_118117_Desc = {
    Text = "Der maximale Einzel-Schaden beträgt [DescArg1] Punkte und wird entfernt, wenn die Gesundheit unter 50 % fällt."
  },
  State_118117_Name = {
    Text = "Schild der Tiefsee III"
  },
  State_118118_Desc = {
    Text = "Erhalte zu Beginn des Kampfes 1 Tentakel mit <TentacleInjurieIconKeywords:Tentakelschaden> für [TentaclePower:DescArg1]. Erhalte am Ende der Runde 1 Tentakel, maximal 5 Tentakel. Die Auswirkungen von Kraftreduzierungen werden um 50% verringert."
  },
  State_118118_Name = {
    Text = "Tentakelansammlung"
  },
  State_118119_Desc = {
    Text = "Nach aktivem Schaden und Verlust von Leben erhältst du einen Schild, der 25% des verlorenen Lebens entspricht, und temporäre <AlertIconKeywords:Vorsicht>, die 5% des verlorenen Lebens beträgt."
  },
  State_118119_Name = {
    Text = "Weiche Körperkonstitution II"
  },
  State_118319_Desc = {
    Text = "Der maximale einmalige Schaden beträgt [DescArg1] Punkte und wird entfernt, wenn die Gesundheit unter 50 % fällt."
  },
  State_118319_Name = {
    Text = "Schadenbeschränkung des Schildes der Tiefsee"
  },
  State_118320_Name = {
    Text = "Vorübergehende Beraubungswiderstandsanzahl"
  },
  State_118321_Name = {
    Text = "Beraubungswiderstandsanzahl"
  },
  State_118322_Name = {
    Text = "Vorbereitungsbeschwörungsmarke"
  },
  State_118323_Desc = {
    Text = "Fischschwarm springt wurde ausgelöst"
  },
  State_118323_Name = {
    Text = "Fischschwarm springt Eintrittsmarkierung"
  },
  State_118324_Desc = {
    Text = "Bei jedem verursachten Schaden, erzeuge 1 temporären Tentakel"
  },
  State_118324_Name = {
    Text = "Schlangenregensritual"
  },
  State_118325_Desc = {
    Text = "Beim Verursachen von unblockiertem Schaden, mische [DescArg1] Erstickungskarten oben in den Ziehstapel"
  },
  State_118325_Name = {
    Text = "Neuer Welt Schlangenmenschen zittern"
  },
  State_118656_Desc = {
    Text = "Beim Ausspielen der Karte erleide [StateArg1] Schaden und entferne 1 Schicht. Wenn die Schichten auf 0 sind, schlüpft ein schwächeres „Wesen des Meeres“. Wenn der parasitäre Zustand am Ende des Zuges noch besteht, schlüpft ein „Wesen des Meeres“ mit Leben entsprechend der Schichten"
  },
  State_118656_Name = {
    Text = "Mehrfach parasitiert"
  },
  State_118657_Desc = {
    Text = "Beim Ausspielen der Karte erleide [StateArg1] Schaden und entferne 1 Schicht. Wenn die Schichten auf 0 sind, schlüpft ein schwächeres „Wesen des Meeres“. Wenn der parasitäre Zustand am Ende des Zuges noch besteht, schlüpft ein „Wesen des Meeres“ mit Leben entsprechend der Schichten"
  },
  State_118657_Name = {
    Text = "Wieder parasitiert"
  },
  State_118659_Desc = {
    Text = "Beim Ausspielen der Karte erleide [StateArg1] Schaden und entferne 1 Schicht. Wenn die Schichten auf 0 sind, schlüpft ein schwächeres „Wesen des Meeres“. Wenn der parasitäre Zustand am Ende des Zuges noch besteht, schlüpft ein „Wesen des Meeres“ mit Leben entsprechend der Schichten"
  },
  State_118659_Name = {
    Text = "Parasitiert"
  },
  State_118663_Name = {
    Text = "Neuer Welt Schlangenmenschen Absicht Überwachung"
  },
  State_118669_Name = {
    Text = "Neuer Welt Schlangenmenschen Initialisierung"
  },
  State_118670_Desc = {
    Text = "Überprüfung auf Beraubungswiderstand"
  },
  State_118670_Name = {
    Text = "Beraubungswiderstandserkennung"
  },
  State_118671_Desc = {
    Text = "Überprüfung des Verhaltens von Spielern bei Erschöpfung"
  },
  State_118671_Name = {
    Text = "Beraubungswiderstandsüberwachung"
  },
  State_118672_Name = {
    Text = "Neuer Welt Schlangenmenschen Absicht Überwachung Abkühlung"
  },
  State_118741_Name = {
    Text = "Entferne vorübergehende Tentakel"
  },
  State_118743_Name = {
    Text = "Vorbereitungsbeschwörung vor der Position benötigt Beschwörungsmarke"
  },
  State_118759_Name = {
    Text = "Aktuelle Anzahl an permanenten Tentakeln des Monsters"
  },
  State_118760_Name = {
    Text = "Monster permanentes Tentakel-Limit"
  },
  State_118762_Name = {
    Text = "Erster Verfall Hinweis"
  },
  State_118763_Name = {
    Text = "Erster Hinweis für Neurotoxin-Durchblutung"
  },
  State_118764_Name = {
    Text = "Erster Fluch-Hauch Hinweis"
  },
  State_118766_Name = {
    Text = "Blauer-Ring-Oktopus-BOSS Absicht Überwachung"
  },
  State_118769_Name = {
    Text = "Hinweis für Silberkernlaterne"
  },
  State_118771_Name = {
    Text = "Erster Probe Hinweis"
  },
  State_118772_Name = {
    Text = "Erster Hinweis zum Schlangenriss"
  },
  State_118935_Name = {
    Text = "Monster Murphy Absicht Überwachung"
  },
  State_118938_Desc = {
    Text = "Zu Beginn der Runde wird der Schild nicht entfernt."
  },
  State_118938_Name = {
    Text = "Ins Leben gerufen"
  },
  State_118943_Desc = {
    Text = "Beim Verlust von Leben erhält man 50 % des verlorenen Lebens als Opferritual. Bei 0 Stapelungen wird die Anzahl der Tentakel vorübergehend um 1 reduziert und die Stapelungen zurückgesetzt."
  },
  State_118943_Name = {
    Text = "versteckter Aufstand"
  },
  State_118973_Name = {
    Text = "Versteckter Aufstand Verwaltung"
  },
  State_119051_Desc = {
    Text = "Am Ende der Runde ausgelöst, erleide entsprechenden passiven Schaden und entferne die Hälfte der Stapelungen, nicht zerstreutbar."
  },
  State_119051_Name = {
    Text = "<PVPSacrificeKeyWords:Opfer>"
  },
  State_119052_Desc = {
    Text = "Nach aktivem Schaden erhält man [Layer]% Schaden durch das Opferritual."
  },
  State_119052_Name = {
    Text = "Geburtsritual"
  },
  State_119053_Desc = {
    Text = "Am Ende der Runde wird ausgelöst, erleidet [Layer] passiven Schaden und entfernt die Hälfte der Stapelungen, nicht zerstreutbar."
  },
  State_119053_Name = {
    Text = "Opferritual"
  },
  State_119058_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Am Rundenende wird dem feindlichen Ziel mit den wenigsten Opferritualen [StateArg1] <PVPSacrificeKeyWords:Opferritual> auferlegt, [StateArg2] Mal wiederholt. Alle verbündeten Einheiten sind nicht mehr von Effekten betroffen, die die <PVPCapKeywords:Arithmetica-Grenze> verringern."
  },
  State_119058_Name = {
    Text = "Schlaf in der Dunkelheit"
  },
  State_119059_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nach “Verherrlichung“ erhalten alle feindlichen Einheiten, die in dieser Runde aktiven Schaden erlitten haben, einen Opferritual-Schaden von [StateArg1]%."
  },
  State_119059_Name = {
    Text = "Blauer-Ring-Gift"
  },
  State_119060_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>:“Schlag“Schaden erhöht um [StateArg1]%, nachdem ein beliebiger Verbündeter “Schlag“ spielt, ziehe [StateArg3] Karten, maximal [StateArg2] Mal pro Runde auslösbar (derzeit [DescArg1] Mal ausgelöst)."
  },
  State_119060_Name = {
    Text = "Massenmord bis zum Ende der Welt"
  },
  State_119061_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Alle Verbündeten erhalten einen “Schlag“-Schadenserhöhung von [StateArg1]% ."
  },
  State_119061_Name = {
    Text = "Licht des Verstandes"
  },
  State_119063_Desc = {
    Text = "Bei Erreichen von 5 Schichten wird die Absicht geändert in: “Ruhm von Lemuria!“."
  },
  State_119063_Name = {Text = "Ruf"},
  State_119075_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_119075_Name = {
    Text = "Nicht erweckt"
  },
  State_119076_Desc = {
    Text = "Falls im vorderen Bereich Platz vorhanden ist, verliere 1 Schicht nach der Aktion und beschwöre zufällig 1 “Lemuria Erwecker“."
  },
  State_119076_Name = {
    Text = "Vorbereiten Beschwörung“Lemuria Erwecker“"
  },
  State_119077_Desc = {
    Text = "“Ruf“erreicht 5 Schichten, versiegelt sofort alle Erwecker."
  },
  State_119077_Name = {
    Text = "Miriam Erwachen!"
  },
  State_119077_WeaponDesc = {
    Text = "Nach Beginn der nächsten Runde, erhalte Schild in Höhe des verlorenen Lebens der letzten Runde"
  },
  State_119080_Desc = {
    Text = "Beim Freigeben von “Chaosgedächtnis“ oder “Unvergessene Dämmerung“ wirkt der gewählte Schlüsselbefehl 1 zusätzliche Wirkung."
  },
  State_119080_Name = {
    Text = "aus dem Vergessen"
  },
  State_119082_Desc = {
    Text = "Jedes Mal, wenn ein Erweckter Körper die Verherrlichung freigibt, erhöht sich sein Basis-Aliemus um 10."
  },
  State_119082_Name = {
    Text = "Wahnsinnsschwund"
  },
  State_119083_Desc = {
    Text = "Wenn eine Befehlskarte aus dem Hyperraum gezogen wird, reduziert sich der Arithmetica-Kosten um 1."
  },
  State_119083_Name = {
    Text = "Ende der anderen Welt"
  },
  State_119084_Desc = {
    Text = "Jedes Mal, wenn Sie eine Posse entfesseln, erhöht sich das benötigte Keyflare um +100."
  },
  State_119084_Name = {
    Text = "Silberner Schlüsselschlag"
  },
  State_119085_Desc = {
    Text = "Nach Benutzung des Blutroten Ofens 1 Embryo in Nachkommen der Reinheit umwandeln, 3 Runden Abkühlzeit."
  },
  State_119085_Name = {
    Text = "Blutrot Zucht"
  },
  State_119086_Desc = {
    Text = "Zuchtkraft Abkühlung, verbleibende [Layer] Runden."
  },
  State_119086_Name = {
    Text = "Zuchtkraft - Abkühlung"
  },
  State_119104_Desc = {
    Text = "Zu Beginn der Runde erhältst du [DescArg1] Schichten Lebensschwelle"
  },
  State_119104_Name = {
    Text = "Schicksalsgrenze"
  },
  State_119105_Desc = {
    Text = "Nach dem Tod verliere alle “Lebensschwellen“. Jede Schicht regeneriert 1 % der maximalen Lebenspunkte und erhöht den Tentakelschaden um 1 %."
  },
  State_119105_Name = {Text = "Bündnis"},
  State_119106_Name = {
    Text = "Monster Dunwang Murphy Absicht Überwachung"
  },
  State_119107_Name = {
    Text = "Göttliches Reich Ordnung Verwaltung"
  },
  State_119108_Desc = {
    Text = "Beim Verlust von Leben erhält man für jede Schicht 1 % des verlorenen Lebens als Opferritual."
  },
  State_119108_Name = {
    Text = "Geburtsritual"
  },
  State_119109_Desc = {
    Text = "Beim Verlust von Leben erhält man 50 % des verlorenen Lebens als Opferritual. Bei 0 Schichten erhält man 1 Schicht “Lebensschwelle“ und setzt die Schichten zurück."
  },
  State_119109_Name = {
    Text = "Göttliches Reich Ordnung"
  },
  State_119132_Desc = {
    Text = "Innerhalb dieser Runde wird der Schaden durch den “Schlag“ um [Layer]% erhöht."
  },
  State_119132_Name = {
    Text = "Schlagverstärkung"
  },
  State_119134_Name = {
    Text = "Erster Hinweis des Schöpfers der Täuschung"
  },
  State_119359_Name = {
    Text = "Silberschlüssel-Zeremoniezähler"
  },
  State_119362_Name = {
    Text = "Ritual durchführen"
  },
  State_119363_Name = {
    Text = "Karten besitzen"
  },
  State_119364_Name = {
    Text = "Aliemusritualanzahl"
  },
  State_119365_Desc = {
    Text = "Alle Erwecker erhöhen die Lebensregeneration und den Schild um 40%."
  },
  State_119365_Name = {
    Text = "Gelassenheit"
  },
  State_119366_Desc = {
    Text = "Nach dem Abwerfen kehrt es auf die Hand zurück"
  },
  State_119366_Name = {
    Text = "Nach dem Abwerfen kehrt es auf die Hand zurück"
  },
  State_119367_Name = {
    Text = "Lebensritual Zählung"
  },
  State_119368_Desc = {
    Text = "Zu Beginn jeder Runde erhält man 500 Punkte Keyflare."
  },
  State_119368_Name = {
    Text = "Durchblick wie durch Feuer"
  },
  State_119369_Desc = {
    Text = "Alle Erwecker verursachen einen Anstieg des Aliemus um 50 %."
  },
  State_119369_Name = {
    Text = "Druckbefehl"
  },
  State_119370_Name = {Text = "Relikt"},
  State_119373_Name = {
    Text = "Feind wendet Opfer an"
  },
  State_119567_Name = {
    Text = "Zeremonie abschließen"
  },
  State_119568_Desc = {
    Text = "Erhöhter Schaden durch Treffer um [Layer] Punkte."
  },
  State_119568_Name = {
    Text = "Schlag vertiefen"
  },
  State_119583_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: “Schlag“ vor, “Fähigkeit“ vor, “Verherrlichung“ vorübergehend <StrongEffectKeywords:Amplifikation> +[StateArg1], jeder Effekt kann pro Runde nur einmal ausgelöst werden."
  },
  State_119583_Name = {
    Text = "Du und ich werden uns schließlich wiedersehen"
  },
  State_119588_Name = {Text = "Fleischcd"},
  State_119589_Name = {Text = "Ultra cd"},
  State_119590_Desc = {
    Text = "Team Unique: Nach dem Wechsel der Tentakelhaltung, der Verwendung von Blutroter Ofen oder dem Einsetzen von „Vernichtung“ wird die Befehlskarte des Ausrüsters ×1 gezogen; jeder Effekt hat eine Abklingzeit von 3 Runden. Nach der Erkundung erhalten alle Erwecker im Team +<WeaponEffect_Num:[StateArg1]%> Synchro-Rate."
  },
  State_119590_WeaponDesc = {
    Text = "Wechsel aktiv die Tentakelhaltung (aktuelle verbleibende Abklingzeit [DescArg1] Runden), benutze den Blutroten Ofen (aktuelle verbleibende Abklingzeit [DescArg2] Runden), nach dem Freigeben von “Vernichtung“ (aktuelle verbleibende Abklingzeit [DescArg3] Runden) ziehe 1 Befehlskarte des Ausrüsters, jeder Effekt hat eine Abklingzeit von 3 Runden. Nach Abschluss der Erkundung erhöht sich die Synchro-Rate aller Erwecker um <WeaponEffect_Num:[StateArg1]%>."
  },
  State_119591_Name = {Text = "Aequor cd"},
  State_119741_Desc = {
    Text = "Alle Erwecker erhalten den Stärke-Effekt um 50 % reduziert."
  },
  State_119741_Name = {
    Text = "Fluch: Rückgang"
  },
  State_119742_Desc = {
    Text = "Zu Beginn jeder Runde stelle 15% des verlorenen Lebens wieder her."
  },
  State_119742_Name = {
    Text = "Ikonen Segen: Ewiger Traum"
  },
  State_119743_Desc = {
    Text = "Alle Erwecker haben die Lebensregeneration um 50% verringert."
  },
  State_119743_Name = {Text = "Fluch: Tod"},
  State_119744_Desc = {
    Text = "“Heiligenbild Fluch: Zerstörung des Hasses“ ist 1 Runde lang inaktiv."
  },
  State_119744_Name = {
    Text = "Immun Heiligenbild Fluch: Zerstörung des Hasses"
  },
  State_119746_Name = {
    Text = "Dimensionsschloss verlorene Anzahl"
  },
  State_119747_Desc = {
    Text = "Erleidet keinen Schaden, hält 1 Runde an."
  },
  State_119747_Name = {
    Text = "Silberner Schlüssel, weise den Weg"
  },
  State_119748_Desc = {
    Text = "“Ikonischer Fluch: Trauer des Verfalls“ wird 1 Runde lang ungültig."
  },
  State_119748_Name = {
    Text = "Immuner ikonischer Fluch: Trauer des Verfalls"
  },
  State_119749_Desc = {
    Text = "Füge zu Beginn der Runde des Schutzherrn 1 Schicht <SlowIconKeywords:Stagnierung> zu den Karten in der Hand hinzu, die der Anzahl der Schichten von “<Abyssallock:Traumfesselung>“ entsprechen."
  },
  State_119749_Name = {
    Text = "Traumfesselung"
  },
  State_119750_Name = {
    Text = "Himmelsvorhang Absicht Überwachung"
  },
  State_119751_Name = {
    Text = "Reproduktionsfreigabe-Symbol des Vorhangs"
  },
  State_119752_Desc = {
    Text = "Zu Beginn jeder Runde erhält man 5% von Max LP als <PowerIconKeywords:Stärke>, temporäre Kritische Trefferquote +25%."
  },
  State_119752_Name = {
    Text = "Segen des Heiligen Bildes: Traum der Macht"
  },
  State_119753_Name = {
    Text = "Dunkle Tide der Tiefsee Zählung"
  },
  State_119754_Desc = {
    Text = "Alle Erwachten haben 50% weniger Wahnsinn, am Ende der Runde erhalten sie 1 Schicht “<DarkEgo:Dunkle Seite des Selbst>“: Zu Beginn der Runde erhalten alle Erwachten 3 Wahnsinn."
  },
  State_119754_Name = {
    Text = "Fluch: Torheit"
  },
  State_119755_Name = {
    Text = "Todeszählung"
  },
  State_119756_Desc = {
    Text = "“Götzenfluch: Seufzer der Torheit“ ist 1 Runde lang ungültig."
  },
  State_119756_Name = {
    Text = "Immuner Götzenfluch: Seufzer der Torheit"
  },
  State_119757_Desc = {
    Text = "Fügt zu den Karten in der Hand des Schutzherrn zu Beginn seiner Runde 1 Schicht <SlowIconKeywords:Stagnierung> hinzu, die der Anzahl der Schichten von <Abyssallock:Traumfesselung> entspricht. Jedes Mal, wenn der „Paradiesvorhang„ durch Aktiven Schaden zerstört wird, reduziert sich die Anzahl um 1 Schicht und der angreifende Erwecker wird für 1 Runde „vollständig versiegelt„."
  },
  State_119757_Name = {
    Text = "Traumfesselung"
  },
  State_119758_Desc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwecker 10 Aliemus."
  },
  State_119758_Name = {
    Text = "Segen des Heiligen: Traum des Wissens"
  },
  State_119760_Name = {
    Text = "Todesüberwachung"
  },
  State_119789_Desc = {
    Text = "Zu Beginn der Runde heile [Layer] LP."
  },
  State_119789_Name = {
    Text = "Blüte des Schlammes"
  },
  State_119837_Desc = {
    Text = "Ramona wirkt die nächste gespielte Befehlskarte in dieser Runde 2 Mal."
  },
  State_119837_Name = {
    Text = "Wieder Händchen halten"
  },
  State_119847_Desc = {
    Text = "Ändere die Arithmetica Kosten der Karte vor dem Spielen. __“Nur für Entwicklungszwecke“"
  },
  State_119847_Name = {
    Text = "Ändere die Arithmetica Kosten der Karte vor dem Spielen__“Nur für Entwicklungszwecke“"
  },
  State_119928_Desc = {
    Text = "Nach dem Ausspielen wirkt sie zusätzlich [StateArg1] Mal, <DepleteIconKeywords:Verbrauch>. <RippleKeywords:Nachbeben>: Ziehe 2 Karten."
  },
  State_119928_Name = {
    Text = "<Rune_20:Echos der tiefen See>"
  },
  State_119958_Desc = {
    Text = "Nach dem Tod sofort einen zufälligen “Fischschwarm“ beschwören, wodurch “Fischschwarm wandert“ um 1 Schicht verringert wird."
  },
  State_119958_Name = {
    Text = "Fischschwarm wandert"
  },
  State_119959_Desc = {
    Text = "Beschwöre sofort nach dem Tod einen zufälligen “Fötusgruppe“ und reduziere seine “Lebenskraft“ um 1 Schicht."
  },
  State_119959_Name = {
    Text = "Lebenskraft"
  },
  State_119960_Desc = {
    Text = "Verursachter Aktiver Schaden und Tentakelschaden –35%. Dieser Zustand wird aufgehoben, wenn die aktuellen LP über 50% liegen."
  },
  State_119960_Name = {
    Text = "<PurpleKeyWord:Verfall>"
  },
  State_120215_Desc = {
    Text = "Fügt zu den Karten in der Hand des Schutzherrn zu Beginn seiner Runde 1 Schicht <SlowIconKeywords:Stagnierung> hinzu, die der Anzahl der Schichten von <Abyssallock:Traumfesselung> entspricht. Jedes Mal, wenn der „Paradiesvorhang„ durch Aktiven Schaden zerstört wird, reduziert sich die Anzahl um 1 Schicht und der angreifende Erwecker wird für 1 Runde „vollständig versiegelt„."
  },
  State_120215_Name = {
    Text = "Dimensionsschloss"
  },
  State_120216_Desc = {
    Text = "Füge zu den Handkarten des Schutzherrn zu Beginn seiner Runde 1 Schicht <SlowIconKeywords:Stagnierung> hinzu, die der Anzahl der “<Abyssallock:Dimensionsschloss>“ Schichten entspricht."
  },
  State_120216_Name = {
    Text = "Dimensionsschloss"
  },
  State_120218_Name = {
    Text = "Rundenende wähle Murphy Unterstützung"
  },
  State_120222_Name = {
    Text = "Zu Rundenbeginn wähle umgekehrten Fluch"
  },
  State_120292_Name = {
    Text = "Nicht akzeptierter Schmerz"
  },
  State_120293_Desc = {
    Text = "Nach Rundenende +[Layer] Leben"
  },
  State_120293_Name = {
    Text = "Nicht akzeptierter Schmerz"
  },
  State_120312_Desc = {
    Text = "Nach dem Tod sofort einen zufälligen “Fischkönig“ beschwören und seine “Fischschwarm wandert“ um 1 Schicht verringern."
  },
  State_120312_Name = {
    Text = "Fischschwarm wandert"
  },
  State_120320_Desc = {
    Text = "Jede Ebene erhöht das nächste “Geburtsritual“, das von der “Prinzessin der Täuschung“ angewendet wird, um 20 %, maximal bis zu 5 Stapel. Nach Erreichen von 5 Stapeln wird die Schadenszahl der nächsten “Prinzessin der Täuschung“ verdoppelt."
  },
  State_120320_Name = {Text = "Bündnis"},
  State_120321_Desc = {
    Text = "Jede Stapelung fügt „Opferritual“-Stapelungen in Höhe von 1% des erlittenen Aktiven Schadens oder Tentakelschadens hinzu. Maximal 75 Stapelungen. Wird am Zugende entfernt."
  },
  State_120321_Name = {
    Text = "<DwmofeiKeywords:Geburtsritual>"
  },
  State_120322_Desc = {
    Text = "Team Unique: Maximale Handgröße +2, nicht stapelbar mit anderen Handgrößen, die durch das Schicksalsrad bereitgestellt werden. Der Ausrüster erhält durch die Keyflare-Regeneration, den Gesamtschaden der Verherrlichung und den Schutzschild erhöht <WeaponEffect_Num:[StateArg1]%. Beim Wechsel in die Haltung “Ruhiges Meer“ erhält der Ausrüster <WeaponEffect_Num:[StateArg2]> Punkte Aliemus, 3 Runden Abklingzeit. Beim Wechsel in die Haltung “Tobende Wellen“ wird allen Feinden <WeaponEffect_Num:[StateArg3]> Schichten <DwmofeiKeywords:Geburtsritual> auferlegt, 3 Runden Abklingzeit."
  },
  State_120322_WeaponDesc = {
    Text = "Maximale Handgröße +2, kann nicht mit anderen von Schicksalsrad bereitgestellten Handkartenlimits gestapelt werden. Der Ausrüster erhält eine Regeneration von Keyflare, der Gesamtschaden von Verherrlichung und der Schutzschild erhöht sich um <WeaponEffect_Num:[StateArg1]%. Beim Wechsel in die Haltung“Ruhiges Meer“ erhält der Ausrüster <WeaponEffect_Num:[StateArg2]> Wahnsinn, mit einer Abklingzeit von 3 Runden. Beim Wechsel in die Haltung“Tobende Wellen“ wird allen Feinden <WeaponEffect_Num:[StateArg3]> Schichten von <DwmofeiKeywords:Geburtsritual> auferlegt, mit einer Abklingzeit von 3 Runden."
  },
  State_120324_Desc = {
    Text = "Jede Stapel fügt „Opfergabe“-Stapel in Höhe von [Layer]% des erlittenen Aktiven Schadens oder Tentakelschadens hinzu. Stapelt bis zu 75. Wird am Rundenende entfernt."
  },
  State_120324_Name = {
    Text = "Geburtsritual"
  },
  State_120351_Desc = {
    Text = "Nach [Layer] Runden kann erneut in das“Göttliches Reich·Ruhiges Meer“wechseln."
  },
  State_120351_Name = {
    Text = "Göttliches Reich·Ruhiges Meer Abkühlung"
  },
  State_120354_Desc = {
    Text = "Nach [Layer] Runden kann erneut zu “Göttliches Reich·Tobende Wellen“ gewechselt werden."
  },
  State_120354_Name = {
    Text = "Göttliches Reich·Tobende Wellen Abkühlung"
  },
  State_120357_Name = {Text = "Tentakel"},
  State_120362_Desc = {
    Text = "Beim Erleiden von Schaden, der nicht von <SacrificeKeyWord:Opfer> stammt, erhält man 50 % des Schadens als <SacrificeKeyWord:Opfer>"
  },
  State_120362_Name = {
    Text = "Allgemeine Monsteropferverwaltung"
  },
  State_120363_Desc = {
    Text = "Nach Rundenende erleidet man [Layer] Schaden und reduziert die <SacrificeKeyWord:Opferritual> Stapelungen um 50 %."
  },
  State_120363_Name = {
    Text = "<BlueKeyWord:Opferung>"
  },
  State_120364_Desc = {
    Text = "Nach dem eigenen Tod “Seefahrer-Garde“ beschwören."
  },
  State_120364_Name = {
    Text = "Glaube bleibt bestehen"
  },
  State_120401_Desc = {
    Text = "Diese Karte hat Arithmetica-Kosten -[StateArg5], nach dem Ausspielen ziehe [StateArg4] Karten."
  },
  State_120401_Name = {
    Text = "<OrangeQuality:Mythag-Insignien>"
  },
  State_120450_Name = {
    Text = "Blaugering-Oktopus zeichnet Spielerleben auf"
  },
  State_120462_Desc = {
    Text = "Bleibt nach dem Kampf im Deck, wird aber nach dem Ausspielen oder Verbrauchen dauerhaft entfernt."
  },
  State_120462_Name = {
    Text = "<DestructionKeywords:Zerstören>"
  },
  State_120900_Name = {
    Text = "Vorbereiten Beschwören“Lemuria Erwecker“Zähler"
  },
  State_120907_Desc = {
    Text = "Wenn ein Tentakelangriff blockiert wird, fügt er [DescArg1] Schichten <IntoxicationIconKeywords:Gift> hinzu."
  },
  State_120907_Name = {
    Text = "Dunkle Strömung"
  },
  State_120908_Desc = {
    Text = "Bei einem Tentakelangriff, wenn er blockiert wird, wird die gleiche Anzahl von Schichten <IntoxicationIconKeywords:Gift> verursacht."
  },
  State_120908_Name = {
    Text = "Dunkle Strömung"
  },
  State_120910_Desc = {
    Text = "Die Arithmetica-Kosten dieser Karte erhöhen sich um +[StateArg5], nach dem Ausspielen ziehe [StateArg4] Karten."
  },
  State_120910_Name = {
    Text = "<OrangeQuality:Mythag-Insignien>"
  },
  State_120924_Desc = {
    Text = "Nach Beginn der nächsten Runde, erhalte Festung."
  },
  State_120924_Name = {
    Text = "Verzögerte Festung"
  },
  State_120929_Desc = {
    Text = "Die Karte erhält Behalten, entfernt jedoch die Verschmutzung beim Ausspielen und beschwört 1 “Tiefsee-Exkrezzenz“. Falls kein Platz zum Beschwören vorhanden ist, erhält sie 1 Schicht “Vorbereiten: Tiefsee-Exkrezzenz“."
  },
  State_120929_Name = {
    Text = "<SeastriderCurse:Seefahrer-Fluch>"
  },
  State_120930_Desc = {
    Text = "Falls ein Platz frei ist, verliere nach der Aktion 1 Schicht und beschwöre 1 “Tiefsee-Exkrezzenz“."
  },
  State_120930_Name = {
    Text = "Hilfevertrag: Tiefsee-Exkrezzenz"
  },
  State_120934_Desc = {
    Text = "Jedes Mal, wenn du Krit. Schaden erleidest, erhältst du 3% <Baojidikang:vorübergehenden Krit. Widerstand>. Zu Beginn jeder Runde werden 2 Karten mit „<SeastriderCurse:Seefahrerfluch>\" versehen."
  },
  State_120934_Name = {
    Text = "Tiefsee-Opferritual"
  },
  State_120941_Desc = {
    Text = "Verstärkt die Fähigkeiten des Feindes. Verliert eine Schicht bei Schaden"
  },
  State_120941_Name = {Text = "Blutsegen"},
  State_121006_Desc = {
    Text = "Team Unique: Der Ausrüster erhöht die durch die Keyflare-Regeneration und die Verherrlichung verursachten Gesamtschäden und den Schild um <WeaponEffect_Num:[StateArg1]%>."
  },
  State_121006_WeaponDesc = {
    Text = "Die Keyflare-Regeneration des Ausrüsters, der Gesamtschaden von Verherrlichung und das Schutzschild erhöhen sich um <WeaponEffect_Num:[StateArg1]%>."
  },
  State_121014_Name = {
    Text = "Schutz des heiligen Embryos"
  },
  State_121015_Desc = {
    Text = "Zu Beginn der Runde wird der Schild nicht entfernt. Bei vorhandenem Schild erhält man 50 Schichten <ReinforcePVEKeywords:Festung>, wenn der Schild zerbrochen wird, wird <ReinforcePVEKeywords:Festung> entfernt."
  },
  State_121015_Name = {
    Text = "Schutz des heiligen Embryos"
  },
  State_121151_Desc = {
    Text = "Die Karte erhält Behalten, entfernt jedoch die Kontamination beim Ausspielen und beschwört 1 “Tiefsee-Exkrezzenz“. Wenn kein Platz zum Beschwören vorhanden ist, erhält sie 1 Schicht “Vorbereiten: Tiefsee-Exkrezzenz“."
  },
  State_121151_Name = {
    Text = "<SeastriderCurse:Seefahrerfluch>"
  },
  State_121210_Name = {
    Text = "Gib allen Feinden negative <PVPWonderfulEffectKeywords:wunderbare Effekte>, wirkt 2 Mal"
  },
  State_121211_Name = {
    Text = "Ziehe 2 Karten, erhalte 2 Arithmetica"
  },
  State_121212_Name = {
    Text = "Gib allen Verbündeten positive <PVPWonderfulEffectKeywords:Wunderbare Wirkung>, wirkt 2 Mal"
  },
  State_121213_Desc = {
    Text = "Immun gegen jeglichen Schaden."
  },
  State_121213_Name = {
    Text = "Immun gegen jeglichen Schaden."
  },
  State_121231_Desc = {
    Text = "Jede Schicht erhöht die nächste Anwendung der \"Abgründigen Prinzessin\" des \"Opferrituals\" um 20%, bis zu 5 Schichten stapelbar, und wenn auf 5 Schichten gestapelt, wird die Schadenszahl der nächsten \"Abgründigen Prinzessin\" verdoppelt."
  },
  State_121231_Name = {
    Text = "<MingqiKeywords:Schicksalsvertrag>"
  },
  State_121365_Desc = {
    Text = "Zusätzlich [Layer]% Tentakelschaden erleiden."
  },
  State_121377_Name = {
    Text = "<RetainIconKeywords:Behalten>: Zu Beginn jeder Runde erhältst du 500 Punkte Keyflare"
  },
  State_121378_Name = {
    Text = "<RetainIconKeywords:Behalten>: Alle Erwecker erhöhen die Lebensregeneration und den Schild um 40%"
  },
  State_121380_Name = {
    Text = "<RetainIconKeywords:Behalten>: Alle Erwecker verursachen eine Erhöhung von 50% Aliemus"
  },
  State_121719_Name = {
    Text = "<RippleKeywords:Nachbeben>: Ziehe 1 Karte, erhalte [DescArg1] Punkte vorübergehende <PowerIconKeywords:Stärke>"
  },
  State_121734_Desc = {
    Text = "Jedes Mal, wenn du eine Befehlskarte spielst, lege eine Karte mit den niedrigsten Arithmetica-Kosten des Erweckers ab."
  },
  State_121734_Name = {
    Text = "Wahnsinnige Strömung"
  },
  State_121735_Desc = {
    Text = "Alle Befehlskarten erhöhen die Arithmetica-Kosten um 1. Alle 3 Runden wird am Ende der Runde 1 Karte “Schrittweise versteinern“ in die Hand gelegt."
  },
  State_121735_Name = {
    Text = "Wehklagender Strom"
  },
  State_121736_Desc = {
    Text = "Am Ende der Runde stelle 10% der verlorenen LP wieder her, entferne eigenen negativen Zustand und die positiven Zustände der Spieler."
  },
  State_121736_Name = {
    Text = "Strom der Ankunft"
  },
  State_121737_Desc = {
    Text = "Zu Beginn des Kampfes erhält man 15 Schichten “Temporäre Barriere“. Am Ende der Runde erhält man 15 Schichten “Temporäre Barriere“ und fügt 10 zufälligen Karten “Temporäre Auflösung“ hinzu."
  },
  State_121737_Name = {
    Text = "Eisige Strömung"
  },
  State_121738_Desc = {
    Text = "Der von Erweckern verursachte Stärke-Effekt wird um 75% verringert. Jedes Mal, wenn Leben verloren geht, erhält man [DescArg1] Punkte Schild und 1 Stapel vorübergehende Festung."
  },
  State_121738_Name = {
    Text = "Fluss des bösen Glaubens"
  },
  State_121739_Desc = {
    Text = "Das Wutlimit aller Erwecker erhöht sich um 50%. Am Ende jeder Runde werden allen Erweckern 10 Punkte Aliemus abgezogen und 3% Max LP wiederhergestellt."
  },
  State_121739_Name = {
    Text = "Fluss der Angst"
  },
  State_121740_Desc = {
    Text = "Zu Kampfbeginn und am Ende jeder Runde werden 2 Stapel temporärer <ResentChainsKeywords:Kette des Grolls> erhalten."
  },
  State_121740_Name = {Text = "Eerie Flow"},
  State_121797_Desc = {
    Text = "Alle verursachten Schäden, Heilungen und Schild-Effekte werden um 10% reduziert, maximal 2 Stapel, kann nicht vertrieben werden. Alle Betrunkenheit des Betroffenen wird entfernt, wenn der letzte Verursacher der Betrunkenheit stirbt."
  },
  State_121797_Name = {
    Text = "<PVPLostSoulKeyWords:Verzaubert>"
  },
  State_121798_Desc = {
    Text = "Verursachter Schaden, Heilung und Schild-Effekte werden um [DescArg1]% reduziert. Kann nicht vertrieben werden. Maximal 2 Stapelungen.\nNach dem Töten von <StatusApplier:> entfernt."
  },
  State_121798_Name = {Text = "Spellbound"},
  State_121799_Name = {
    Text = "Viertes Kapitel Lemuria Unterstützungskarte"
  },
  State_121850_Desc = {
    Text = "Tentakelschaden verringert 80%"
  },
  State_121850_Name = {
    Text = "Goliath: Unterstützung"
  },
  State_121863_Name = {
    Text = "<RippleKeywords:Nachbeben>: Ziehe 2 Karten"
  },
  State_121878_Name = {
    Text = "Erste Auswahl der Handlung für den Fluch umkehren"
  },
  State_122428_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_122428_Name = {
    Text = "Nicht erweckt"
  },
  State_122431_Desc = {
    Text = "Wenn Mouchette unblockierten Schaden verursacht, erhält sie 2 Stapel von <Monster_Fervor:Wahnsinn>."
  },
  State_122431_Name = {
    Text = "Nebelreich-Ruinen"
  },
  State_122441_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Bei der Ausrüstung erhältst du 3 Schichten <PVPReciprocalKeywords:Countdown-Moment>."
  },
  State_122441_Name = {
    Text = "Countdown-Moment"
  },
  State_122442_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Ausrüsten, um <Block:[Block:StateArg1]> Schild und <Energy:[Energy:StateArg1]> Aliemus zu erhalten. Am Ende des Zuges wird dieses Rad des Schicksals automatisch abgerüstet, wodurch der bei der nächsten Ausrüstung von „Kiste der Kindheit“ gewonnene Aliemus und Schild um [StateArg2] erhöht wird."
  },
  State_122442_Name = {
    Text = "Kinderspaß im Kasten"
  },
  State_122443_Desc = {
    Text = "Zu Rundenbeginn, Stapelanzahl - 1. Sobald die Stapel erschöpft sind, entferne Debuffs von dir selbst und erhalte 100 Aliemus, dann gewinne 3 Stapel Countdown zurück. Das Ändern des Rads des Schicksals entfernt den Countdown-Zustand."
  },
  State_122443_Name = {
    Text = "<PVPFlowerKeywords:Countdown-Moment>"
  },
  State_122596_Desc = {
    Text = "Karte kann nicht gespielt werden, kann nicht ausgelöst werden."
  },
  State_122596_Name = {
    Text = "<Seal1:Versiegelt>"
  },
  State_122636_Desc = {
    Text = "Der erste gespielte “Fähigkeit“-Schaden, Heilung und Schild erhöhen sich um [StateArg1]% pro Runde."
  },
  State_122636_Name = {
    Text = "Rubinbrosche"
  },
  State_122650_Desc = {
    Text = "Relikt <OrangeQuality:Magische Handschuhe> hat diese Karte hinzugefügt."
  },
  State_122650_Name = {
    Text = "Seltsame Karte"
  },
  State_122654_Name = {
    Text = "Zu Beginn jeder Runde und nach dem Ende einer Aktion wird versucht, die leere Spielerkarte zurückzusetzen. Wenn sie nicht leer ist, wird sie nicht zurückgesetzt.__“Nur für Entwicklungszwecke“"
  },
  State_122706_Name = {
    Text = "<CardKeyWord:Wiedersehen Wunsch>"
  },
  State_122707_Desc = {
    Text = "Behandle dies als die letzte gespielte „Fähigkeit\" dieser Runde. Arithmetica-Kosten –1."
  },
  State_122707_Name = {
    Text = "<CardKeyWord:Wiedersehen Wunsch>"
  },
  State_123109_Desc = {
    Text = "Team Unique: Beim ersten Kauf eines “Gebets“ in der “Fusionsnarbe“ oder beim ersten Kauf eines rabattierten Artikels in den “Asche der Ruinen“ besteht eine <WeaponEffect_Num:[StateArg1]%> Chance, dass die benötigten schwarzen Siegel auf 0 sinken, wirkt pro Erkundung maximal 1 Mal."
  },
  State_123109_WeaponDesc = {
    Text = "Beim erstmaligen Kauf von “Gebet“ in der “Fusionsnarbe“ oder beim erstmaligen Kauf von rabattierten Artikeln in der “Asche der Ruinen“ beträgt die erforderliche Anzahl an schwarzen Malen <WeaponEffect_Num:[StateArg1]%> die Wahrscheinlichkeit, dass sie auf 0 sinkt, und dieser Effekt kann pro Erkundung maximal einmal auftreten."
  },
  State_123177_Desc = {
    Text = "Zu Beginn des Zuges entfernen. Nachdem 10 Schichten erreicht wurden, handelt Mouchette sofort nach dem nächsten Ausspielen einer Karte, entfernt „vorübergehender Wahnsinn\" und fügt die Absicht „Menschenexplosion\" hinzu."
  },
  State_123177_Name = {
    Text = "Vorübergehender Wahnsinn"
  },
  State_123178_Desc = {
    Text = "<Guaiwusiwangdikang:Todwiderstand> der LP-Wiederherstellungseffekt wird auf das 5-Fache erhöht. Für jede vom Gegner gespielte Karte erhält man 1 Schicht <Monster_Fervor:vorübergehender Wahnsinn>."
  },
  State_123178_Name = {
    Text = "Morgenmuffel"
  },
  State_123243_Desc = {
    Text = "Beim Töten eines Gegners werden alle Stapelungen dieses Zustands entfernt. Erhalte für jede entfernte Stapelung die gleiche Menge Aliemus. Maximal 2 Stapelungen."
  },
  State_123243_Name = {Text = "Wirbel"},
  State_123246_Desc = {
    Text = "Beim Töten eines Feindes alle Stapelungen entfernen und eine gleiche Menge Aliemus erhalten. Maximal 2 Stapelungen."
  },
  State_123246_Name = {
    Text = "<PVPWaterPowerKeyWords:Wirbel>"
  },
  State_123294_Desc = {
    Text = "In dieser Runde wurden [DescArg1] Karten durch „Schlag“ gezogen."
  },
  State_123294_Name = {Text = "Slaughter"},
  State_123507_Desc = {
    Text = "Team Einzigartig: Zu Beginn der Erkundung füge 1 \"Countdown-Moment: 5\" dem Deck hinzu: Nach dem Spielen ziehe 1 Karte und mische das nächste \"Countdown-Moment\" in den Ablagestapel. \"<DestructionKeywords:Zerstören>\". \"Countdown-Moment: 0\": Ziehe 3 Karten, erhalte 3 Arithmetica und habe eine <WeaponEffect_Num:[StateArg1]%> Chance, \"Countdown-Moment: 5\" in den Ablagestapel zu mischen. Behalten. \"<DestructionKeywords:Zerstören>\"."
  },
  State_123507_WeaponDesc = {
    Text = "Zu Beginn der Erkundung füge 1 \"Countdown: 5\" dem Deck hinzu: Nach dem Spielen ziehe 1 Karte und mische das nächste \"Countdown\" in den Ablagestapel. \"<DestructionKeywords:Zerstören>\". \"Countdown: 0\": Ziehe 3 Karten, erhalte 3 Arithmetica und habe eine <WeaponEffect_Num:[StateArg1]%> Chance, \"Countdown: 5\" in den Ablagestapel zu mischen. Behalten. \"<DestructionKeywords:Zerstören>\"."
  },
  State_123520_Desc = {
    Text = "Team-Einzigartig: Nach der ersten Freisetzung der Posse in jeder Runde gibt es eine <WeaponEffect_Num:[StateArg1]>% Chance, 1 „Schlag“ des Trägers zu ziehen."
  },
  State_123520_WeaponDesc = {
    Text = "Nach der ersten Freisetzung der Posse in jeder Runde gibt es eine <WeaponEffect_Num:[StateArg1]>% Chance, 1 „Schlag“ des Trägers zu ziehen."
  },
  State_123521_Desc = {
    Text = "Team-Einzigartig: Der Basis-Schaden von Exalt und Verfolgung des Trägers +<WeaponEffect_Num:[StateArg1]%>. Nachdem in dieser Runde ein „Schlag“ eines Erweckers gespielt wurde, erhöht sich der „Schlag“-Schaden des Trägers vorübergehend um <WeaponEffect_Num:[StateArg2]%> des Angriffs des Trägers. Dieser Effekt kann bis zu 8 Mal pro Runde ausgelöst werden."
  },
  State_123521_WeaponDesc = {
    Text = "Der Schaden des Trägers für Erheben und Verfolgen beträgt +<WeaponEffect_Num:[StateArg1]%>. Nachdem in dieser Runde ein „Schlag“ eines Erweckers gespielt wurde, erhöht sich der Schaden des Trägers für „Schlag“ vorübergehend um +<WeaponEffect_Num:[DescArg2]>. Dieser Effekt kann bis zu 8 Mal pro Runde ausgelöst werden."
  },
  State_123810_Desc = {
    Text = "Ersetze die aktuelle Absicht des Feindes mit \"Kann nicht handeln\"."
  },
  State_123810_Name = {
    Text = "<HunmiKeywords:Ohnmächtig>"
  },
  State_123812_Desc = {
    Text = "Am Ende der Runde wird der Stromverbrauch reduziert."
  },
  State_123812_Name = {
    Text = "<PrepareKeywords:Vorbereiten>"
  },
  State_123994_Desc = {
    Text = "Kann keine Aktionen ausführen."
  },
  State_123994_Name = {
    Text = "Feiner Schlaf"
  },
  State_124010_Desc = {
    Text = "Nach Beginn der nächsten Runde, erhalte [Layer] Arithmetica."
  },
  State_124010_Name = {
    Text = "Verzögerte Arithmetica"
  },
  State_124024_Desc = {
    Text = "In dieser Runde wurden [Layer] „Schlag“-Karten gespielt, was „Dramatische Begegnung“ [DescArg1] Mal auslöst."
  },
  State_124024_Name = {
    Text = "Dramatische Begegnung"
  },
  State_124034_Desc = {
    Text = "Der „Schlag“-Schaden aller Erwecker wird um [StateArg1] für [Layer] Runden erhöht."
  },
  State_124034_Name = {
    Text = "Glänzender☆Wirbelsturm"
  },
  State_124037_Desc = {
    Text = "Mouchettes Anzahl der Schadensinstanzen +1, der „Schlag“-Schaden aller Erwecker erhöht sich um [StateArg1] und hält [Layer] Runden an."
  },
  State_124037_Name = {
    Text = "Glänzender☆Wirbelsturm"
  },
  State_124107_Desc = {
    Text = "Beim Tod des \"Sterngeborenen Sprosses\" wird man immun gegen allen Schaden und wird geweckt, wobei die maximale Gesundheit verdoppelt wird und die maximale Gesundheit entsprechend den verbleibenden Lebenspunkten erhöht wird. Nach dem Erwachen werden alle negativen Zustände beseitigt."
  },
  State_124107_Name = {
    Text = "Nicht erweckt"
  },
  State_124108_Name = {
    Text = "Stimmen aus dem Jenseits zählen"
  },
  State_124109_Desc = {
    Text = "Du erhältst einen zusätzlichen 5% <PowerIconKeywords:Stärke> Bonus von <RetaliateIconKeywords:Gegenschlag>. Nachdem du in einem einzigen Zug [DescArg1] HP verloren hast, tausche die Positionen mit dem \"Sänger\""
  },
  State_124109_Name = {
    Text = "Sekundäre Geburtsbinden"
  },
  State_124111_Desc = {
    Text = "Die Wiederherstellung der HP durch den Todeswiderstand wird auf 25% erhöht. Für jede vom Gegner gespielte Befehlskarte wird vorübergehend <TouquKeywords:Stehlen> [DescArg1] <PowerIconKeywords:STR>."
  },
  State_124111_Name = {
    Text = "Grenzenloses Sternenlicht"
  },
  State_124112_Desc = {
    Text = "Beim Tod des \"Sängers\" wird man immun gegen allen Schaden und wird geweckt, wobei die maximale Gesundheit verdoppelt wird und die maximale Gesundheit entsprechend dem verbleibenden Leben erhöht wird."
  },
  State_124112_Name = {
    Text = "Nicht erweckt"
  },
  State_124113_Desc = {
    Text = "Der Gegner wird am Ende seines Zuges seine Hand nicht abwerfen. Am Ende des Zuges füge nacheinander 2 Schichten <FragileIconKeywords: Zerbrechlich>, <WeaknessIconKeywords: Schwäche>, <HeavyInjuryKeywords: Blight> und <VulnerabilityIconKeywords: Verwundbar> hinzu."
  },
  State_124113_Name = {
    Text = "Stimmen aus dem Jenseits"
  },
  State_124115_Desc = {
    Text = "Die Effekte von <FragileIconKeywords:Zerbrechlich>, <HeavyInjuryKeywords:Verderben> und <WeaknessIconKeywords:Symptom: Schwäche> werden auf 50% erhöht. Nach dem Spielen von [DescArg1] weiteren <SlowIconKeywords:Stagnierung>-Karten die Position mit „Sternenspross“ tauschen."
  },
  State_124115_Name = {
    Text = "Planetenreisender"
  },
  State_124121_Name = {
    Text = "Anzahl der planetaren Reisenden"
  },
  State_124122_Name = {
    Text = "Planetarischer Reisender Spieler Zuhörer"
  },
  State_124190_Desc = {
    Text = "Du erhältst einen zusätzlichen 5% <PowerIconKeywords:Stärke> Bonus von <RetaliateIconKeywords:Gegenschlag>."
  },
  State_124190_Name = {
    Text = "Sekundäre Geburtsbinden"
  },
  State_124193_Name = {
    Text = "Widerstand gegen den Tod, Heilungsrückgewinnung auf 25% erhöht."
  },
  State_124198_Desc = {
    Text = "Die Effekte von zugefügtem <FragileIconKeywords:Zerbrechlich>, <HeavyInjuryKeywords:Verderben> und <WeaknessIconKeywords:Symptom: Schwäche> werden auf 50% erhöht."
  },
  State_124198_Name = {
    Text = "Planetenreisender"
  },
  State_124277_Desc = {
    Text = "Visualisierung von Zwischenwerten im Ausführungsprozess."
  },
  State_124277_Name = {
    Text = "Druckwert 2"
  },
  State_124278_Desc = {
    Text = "Visualisierung von Zwischenwerten im Ausführungsprozess."
  },
  State_124278_Name = {
    Text = "Druckwert 4"
  },
  State_124279_Desc = {
    Text = "Visualisierung von Zwischenwerten im Ausführungsprozess."
  },
  State_124279_Name = {
    Text = "Druckwert 5"
  },
  State_124280_Desc = {
    Text = "Visualisierung von Zwischenwerten im Ausführungsprozess."
  },
  State_124280_Name = {
    Text = "Druckwert 1"
  },
  State_124282_Desc = {
    Text = "Visualisierung von Zwischenwerten im Ausführungsprozess."
  },
  State_124282_Name = {
    Text = "Druckwert 7"
  },
  State_124283_Desc = {
    Text = "Visualisierung von Zwischenwerten im Ausführungsprozess."
  },
  State_124283_Name = {
    Text = "Druckwert 8"
  },
  State_124284_Desc = {
    Text = "Visualisierung von Zwischenwerten im Ausführungsprozess."
  },
  State_124284_Name = {
    Text = "Druckwert 9"
  },
  State_124285_Desc = {
    Text = "Visualisierung von Zwischenwerten im Ausführungsprozess."
  },
  State_124285_Name = {
    Text = "Druckwert 10"
  },
  State_124286_Desc = {
    Text = "Visualisierung von Zwischenwerten im Ausführungsprozess."
  },
  State_124286_Name = {
    Text = "Druckwert 6"
  },
  State_124287_Desc = {
    Text = "Visualisierung von Zwischenwerten im Ausführungsprozess."
  },
  State_124287_Name = {
    Text = "Druckwert 3"
  },
  State_124736_Desc = {
    Text = "Überprüfen Sie, ob Parameter 3 der BEAttachPostAction-Schnittstelle korrekt filtert oder den entsprechenden Auslöser aktiviert."
  },
  State_124736_Name = {
    Text = "Zuhörer-Test 1"
  },
  State_124747_Desc = {
    Text = "Überprüfen Sie, ob Parameter 3 der BEAttachPostAction-Schnittstelle korrekt filtert oder den entsprechenden Auslöser aktiviert."
  },
  State_124747_Name = {
    Text = "Zuhörer-Test 2"
  },
  State_124748_Desc = {
    Text = "Wenn der Feind <BurningKeywords:Brennen> Karten spielt, gewähre dir 1 Stapel <MonsterExFlameKeywords:Verbrennung>, reduziere aber vorübergehend [DescArg1] <PowerIconKeywords:STR>."
  },
  State_124748_Name = {
    Text = "Ewige Flamme"
  },
  State_124752_Desc = {
    Text = "Überprüfen Sie, ob Parameter 3 der BEAttachPostAction-Schnittstelle korrekt filtert oder den entsprechenden Auslöser aktiviert."
  },
  State_124752_Name = {
    Text = "Zuhörer-Test 3"
  },
  State_124753_Desc = {
    Text = "Überprüfen Sie, ob Parameter 3 der BEAttachPostAction-Schnittstelle korrekt filtert oder den entsprechenden Auslöser aktiviert."
  },
  State_124753_Name = {
    Text = "Zuhörer-Test 4"
  },
  State_124754_Desc = {
    Text = "Überprüfen Sie, ob Parameter 3 der BEAttachPostAction-Schnittstelle korrekt filtert oder den entsprechenden Auslöser aktiviert."
  },
  State_124754_Name = {
    Text = "Zuhörer-Test 5"
  },
  State_124765_Desc = {
    Text = "Kritische Rate erhöht um [Layer] %"
  },
  State_124765_Name = {Text = "Krit. Rate"},
  State_124766_Desc = {
    Text = "In diesem Kampf wird die kritische Rate um [Layer]% erhöht"
  },
  State_124766_Name = {Text = "Krit. Rate"},
  State_124766_WeaponDesc = {
    Text = "In diesem Kampf wird die kritische Rate um [Layer]% erhöht"
  },
  State_124767_Desc = {
    Text = "Kritischer Schaden +[Layer]%"
  },
  State_124767_Name = {
    Text = "Krit. Schaden"
  },
  State_124811_Desc = {
    Text = "Überprüfen Sie, ob Parameter 3 der BEAttachPostAction-Schnittstelle korrekt filtert oder den entsprechenden Auslöser aktiviert."
  },
  State_124811_Name = {
    Text = "Zuhörer-Test 8"
  },
  State_124812_Desc = {
    Text = "Überprüfen Sie, ob Parameter 3 der BEAttachPostAction-Schnittstelle korrekt filtert oder den entsprechenden Auslöser aktiviert."
  },
  State_124812_Name = {
    Text = "Zuhörer-Test 7"
  },
  State_124813_Desc = {
    Text = "Überprüfen Sie, ob Parameter 3 der BEAttachPostAction-Schnittstelle korrekt filtert oder den entsprechenden Auslöser aktiviert."
  },
  State_124813_Name = {
    Text = "Zuhörer-Test 6"
  },
  State_124826_Desc = {
    Text = "Überprüfen Sie, ob Parameter 3 der BEAttachPostAction-Schnittstelle korrekt filtert oder den entsprechenden Auslöser aktiviert."
  },
  State_124826_Name = {
    Text = "Zuhörer-Test 9"
  },
  State_124843_Desc = {
    Text = "Überprüfen Sie die Listener der Trigger BSTAfterAttachPostAction und BSTAfterDoActiveDamage.AttachPostAction"
  },
  State_124843_Name = {
    Text = "Zuhörer-Test 9"
  },
  State_124886_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Nachdem der Träger eine Fähigkeitskarte spielt, ziehe [StateArg1] Karten, wobei Karten von anderen Erweckern priorisiert werden. Der Effekt kann nur einmal pro Zug aktiviert werden."
  },
  State_124886_Name = {Text = "Glücksrad"},
  State_124887_Desc = {
    Text = "Die „Textil\"-Schadensanzahl dieses Erweckers erhöht sich um [Layer]."
  },
  State_124887_Name = {Text = "Textile"},
  State_124888_Desc = {
    Text = "Verwandelt sich nach dem Spielen in eine zufällige feindliche „Fähigkeit\" mit –1 Kosten."
  },
  State_124888_Name = {
    Text = "<CardKeyWord:Prophezeiung>"
  },
  State_124890_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Nach „Erheben“ lasse die nächste [StateArg1] gespielte „Fähigkeit“ 2 Mal aktivieren."
  },
  State_124890_Name = {
    Text = "Netz der Ewigen Weberkunst"
  },
  State_124892_Name = {
    Text = "<CardKeyWord:Prophezeiung>"
  },
  State_124916_Desc = {
    Text = "Am Ende der Runde werden alle Stapelungen entfernt und [DescArg1] passiver Schaden zugefügt. Nicht entfernbar."
  },
  State_124916_Name = {
    Text = "Der Tod des Schicksals"
  },
  State_124917_Desc = {
    Text = "Am Ende der Runde werden alle Stapelungen entfernt und passiver Schaden zugefügt. Nicht entfernbar."
  },
  State_124917_Name = {
    Text = "<PVPDestinedDeathKeyWords:Der Tod des Schicksals>"
  },
  State_124992_Desc = {
    Text = "Die nächsten [DescArg1] „Fähigkeit\"-Karten werden 1 zusätzliches Mal wirksam."
  },
  State_124992_Name = {
    Text = "Überschreiten"
  },
  State_124993_Desc = {
    Text = "Aktiver verursachter und erlittener tödlicher Schaden wird als gleiche Menge <PVPDestinedDeathKeyWords:Schicksalsomen> angewendet. Kann nicht aufgehoben werden."
  },
  State_124993_Name = {
    Text = "Moira, Wie Ich Es Verkünde"
  },
  State_124997_Desc = {
    Text = "Tödlicher aktiver Schaden, der verursacht oder erlitten wird, wird stattdessen in eine entsprechende Menge <PVPDestinedDeathKeyWords:Schicksalsomen> umgewandelt. Kann nicht vertrieben werden."
  },
  State_124997_Name = {
    Text = "<PVPEternalDimensionKeyWords:Moira, Wie Ich Es Verkünde>"
  },
  State_125002_Name = {
    Text = "Zustand@Allgemeiner Spieler Abwurfphase nach Schildwert Zuhörer"
  },
  State_125003_Name = {Text = "Schildwert"},
  State_125004_Name = {
    Text = "Zustand@Allgemeine Spieler Schildanzahl anwenden"
  },
  State_125472_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Nach „Wahnsinniger Ausbruch\" wird dem Feind mit <HPAndShieldMax:höchstem Leben und Schild> [StateArg1] Stapel <PVPLostSoulKeyWords:Taumel> auferlegt."
  },
  State_125472_Name = {
    Text = "Magnolienverlockung"
  },
  State_125486_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nach der „Verherrlichung\" eines anderen Verbündeten werden die Arithmetica-Kosten aller „Fähigkeiten\" des Ausrüsters in der Hand um [StateArg1] reduziert."
  },
  State_125486_Name = {
    Text = "Eitle Bedauern"
  },
  State_125925_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_125925_Name = {
    Text = "Nicht erweckt"
  },
  State_125926_Name = {
    Text = "Status@Monster Tawil Wechsel Absicht Spieler Zuhörer"
  },
  State_125927_Desc = {
    Text = "Nachdem [DescArg1] Befehlskarten ausgespielt wurden, wechsle die Absicht zu \"Sechs Flügel\"."
  },
  State_125927_Name = {
    Text = "Vier Flügel"
  },
  State_125928_Desc = {
    Text = "Nachdem eine Befehlskarte gespielt wurde, versiegle das Exalt des entsprechenden Erweckers und alle Befehlskarten für 2 Runden."
  },
  State_125928_Name = {
    Text = "Zahnräder der Zeit"
  },
  State_125929_Desc = {
    Text = "Nachdem du in einem einzigen Zug [DescArg1] DMG erlitten hast, erhalte 70 Stapel temporärer <ReinforceColour:Burg> und 1 Stapel von <ResentChainsKeywords:Ketten des Grolls>."
  },
  State_125929_Name = {
    Text = "Nicht existierende Existenz"
  },
  State_125933_Desc = {
    Text = "Nachdem [DescArg1] Befehlskarten ausgespielt wurden, wechsle die Absicht zu \"Vier Flügel\"."
  },
  State_125933_Name = {
    Text = "Zwillingsflügel"
  },
  State_125934_Desc = {
    Text = "Beim Verbrauch von Arithmetica wird die gewonnene Keyflare um 50% reduziert. Nachdem Tawil unblockierten Schaden verursacht, lege 1 Karte „<DerivativeCardKeywords_131:Zeitparadox EX>\" in die Hand."
  },
  State_125934_Name = {
    Text = "Das Silberschlüsseltor"
  },
  State_125935_Name = {Text = "Stille"},
  State_125935_WeaponDesc = {
    Text = "Beim Ziehen bist du für 1 Runde geschwächt. Nach der Benutzung werden alle Gegner für 1 Runde geschwächt. Nicht verkäuflich"
  },
  State_125937_Desc = {
    Text = "Nachdem eine Befehlskarte gespielt wurde, versiegle das Exalt des entsprechenden Erweckers und alle Befehlskarten für 2 Runden."
  },
  State_125937_Name = {
    Text = "Zahnräder der Zeit"
  },
  State_125964_Desc = {
    Text = "Beim Verbrauch von Arithmetica wird das erhaltene Keyflare um –50 % reduziert. Nachdem Tawil ungeblockten Schaden zugefügt hat, wird 1 „<DerivativeCardKeywords_131:Zeitparadox EX>\" auf die Hand gelegt."
  },
  State_125964_Name = {
    Text = "Das Silberschlüsseltor"
  },
  State_126010_Desc = {
    Text = "Team-Einzigartig: Die durch den Träger verursachten festen Vergiftungseffekte und Vergiftungseffekte werden um <WeaponEffect_Num:[StateArg1]%> erhöht, und die automatisch im Caro-Reich wiederhergestellte <EmbryoFusionIconKeywords:Embryo-Verschmelzung> wird um <WeaponEffect_Num:[StateArg2]%.> erhöht. Das erste Mal, wenn der Träger in jeder Runde „Resonanz“ auslöst, erhalten andere Erwecker <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_126010_WeaponDesc = {
    Text = "Der Ausrüster erhöht den festen Gift- und den Auslösungs-Effekt um <WeaponEffect_Num:[StateArg1] %>, die automatisch in der Fleischwelt regenerierte <EmbryoFusionIconKeywords:Embryofusion> erhöht sich um <WeaponEffect_Num:[StateArg2] %>. Wenn der Ausrüster in jeder Runde zum ersten Mal „Resonanz \" auslöst, erhalten andere Erwecker <WeaponEffect_Num:[StateArg3]> Punkte Aliemus."
  },
  State_126463_Name = {
    Text = "Status@Monster Liz Mottenfalle Feuer Schaden Überwachung"
  },
  State_126464_Desc = {
    Text = "Maximal 10 Schichten, jede Schicht erhöht den von Liz verursachten Schaden um [DescArg1] Punkte."
  },
  State_126464_Name = {
    Text = "<GreenWord:Smaragdgrüne Funken>"
  },
  State_126465_Name = {
    Text = "Monster Liz Absicht Überwachung"
  },
  State_126466_Desc = {
    Text = "Dein Gegner wird am Ende seines Zuges keine Karten abwerfen. Wenn du zur Absicht „Grüne Flammen“ wechselst und mindestens 6 Stapel von <MonsterLizVerdantSpark: Smaragdglut> hast, verbrauche 6 Stapel, um die Absicht auf „Tödliche Flammen“ aufzuwerten, die <Damage:[Damage:DescArg1]> Schaden [AttackTimes:DescArg2] Mal verursacht; wenn du mindestens 3 Stapel hast, verbrauche 3 Stapel, um die Absicht auf „Verderbte Flammen“ aufzuwerten, die <Damage:[Damage:DescArg3]> Schaden [AttackTimes:DescArg4] Mal verursacht."
  },
  State_126466_Name = {
    Text = "Unsterbliche Grünflamme"
  },
  State_126467_Desc = {
    Text = "Dieser Erwecker ist noch nicht geweckt... Sie werden geweckt, wenn sie kurz davor stehen, besiegt zu werden, stellen HP wieder her und kämpfen mit voller Kraft, wobei sie die Fähigkeit erhalten, negative Zustände für \"Tanz zur Zerstörung\" zu entfernen"
  },
  State_126467_Name = {
    Text = "Nicht erweckt"
  },
  State_126468_Name = {
    Text = "State@Monster Liz Smaragd Reflexionsverwaltung"
  },
  State_126469_Desc = {
    Text = "Für jede verlorene [DescArg1] HP erhalte [DescArg2] Stapel von <MonsterLizVerdantSpark:Smaragdenkohle>."
  },
  State_126469_Name = {
    Text = "Smaragdgrüne Reflexion"
  },
  State_126470_Name = {
    Text = "Zustand@Monster Liz Hinweisanzahl"
  },
  State_126479_Desc = {
    Text = "Maximal 10 Stapel, erhöht den von Liz verursachten Schaden."
  },
  State_126479_Name = {
    Text = "<GreenWord:Smaragdgrüne Funken>"
  },
  State_126540_Desc = {
    Text = "Wenn Xu \"Resonanz\" [Layer] Mal auslöst, wird der \"Resonanz\"-Effekt verdoppelt."
  },
  State_126540_Name = {
    Text = "Nebelschwur"
  },
  State_126568_Desc = {
    Text = "Jedes Mal, wenn ein Erwecker aktiven DMG verursacht, befehle 1 Tentakel, das Ziel anzugreifen und [Layer]% Tentakel-DMG zuzufügen."
  },
  State_126568_Name = {
    Text = "Trotzende Wellen"
  },
  State_126569_Desc = {
    Text = "Jeder aktive Schaden, den der Erwecker verursacht, befiehlt 1 Tentakel, das Ziel mit 50% Tentakelschaden anzugreifen."
  },
  State_126569_Name = {
    Text = "Trotzende Wellen"
  },
  State_126643_Desc = {
    Text = "Dieser Zustand MaxLayer=1. Quelle Erwecker: [DescArg1]"
  },
  State_126643_Name = {
    Text = "Limit Stufe 1"
  },
  State_126644_Desc = {
    Text = "Erhalte, entferne und füge den Zustand [Layer] Schichten wieder hinzu. \n Die maximale Anzahl der Schichten für den Zustand beträgt 1 Schicht."
  },
  State_126644_Name = {
    Text = "Durchbrechen der maximalen Stapelungen"
  },
  State_126645_Desc = {
    Text = "Ramonas Grundschaden erhöht sich um [DescArg1]%"
  },
  State_126645_Name = {
    Text = "Erhabenes Temperieren"
  },
  State_126651_Desc = {
    Text = "Der Zuhörer nach dem Freigeben der Verfolgung ist [Layer] Mal zufrieden gewesen."
  },
  State_126651_Name = {Text = "Theke"},
  State_126652_Desc = {
    Text = "Nachdem du es erhalten hast, zwinge die vorderen Feinde, eine verzögerte Aktion hinzuzufügen, indem sie ihre aktuelle Absicht ausspielen."
  },
  State_126652_Name = {
    Text = "Lass das Monster verfolgen"
  },
  State_126653_Desc = {
    Text = "Nachdem du es erhalten hast, zwinge den Erwecker in Position 1, eine verzögerte Aktion hinzuzufügen, um seine Schlagkarte auszuspielen."
  },
  State_126653_Name = {
    Text = "Lass den Erwecker verfolgen"
  },
  State_126654_Desc = {
    Text = "Wenn der benannte Zuhörer ausgelöst wird, drucke die Anzahl 1 Mal."
  },
  State_126654_Name = {
    Text = "Benannter Zuhörer"
  },
  State_126655_Desc = {
    Text = "Nachdem du es erhalten hast, zwinge den Schutzherrn, eine verzögerte Aktion hinzuzufügen und die Fähigkeit @Protagonist Skill@Stimmen in deinem Kopf zu spielen."
  },
  State_126655_Name = {
    Text = "Lass den Schutzherrn verfolgen"
  },
  State_126677_Desc = {
    Text = "In dieser Runde wirkt die nächste [Layer] \"Klinge der Herausforderung\" zweimal."
  },
  State_126677_Name = {
    Text = "Ursprünglicher Leviathan"
  },
  State_126678_WeaponDesc = {
    Text = "Alle Schadensinstanzen des Wal-Sprungs +1"
  },
  State_126714_Desc = {
    Text = "Aigis' nächste [Layer] \"Verteidigung\" tritt 3 Mal in Kraft."
  },
  State_126714_Name = {
    Text = "Kristallisierte Träne"
  },
  State_126714_WeaponDesc = {
    Text = "Alle Schadensinstanzen des Wal-Sprungs +1"
  },
  State_126715_WeaponDesc = {
    Text = "Alle Schadensinstanzen des Wal-Sprungs +1"
  },
  State_126776_Desc = {
    Text = "Für jeden Stapel erhöht sich der feste erlittene Gift-Schaden um 5%, der verursachte DMG verringert sich um [DescArg1]%, maximal bis zu [DescArg2] Stapeln."
  },
  State_126776_Name = {
    Text = "<WitherKeywords:Verzaubert>"
  },
  State_126783_Name = {
    Text = "Vorübergehend verworfen"
  },
  State_126784_Desc = {
    Text = "Erhöhe den festgelegten erlittenen Vergiftungseffekt um [DescArg1] %, reduziere den verursachten Schaden um [DescArg2] %, maximal [DescArg3] Schichten."
  },
  State_126784_Name = {Text = "Spellbound"},
  State_126785_Desc = {
    Text = "Wenn andere Erwecker X gespielte Befehlskarten angesammelt haben, lösen sich nach dem Spielen folgende Effekte aus. Setze deine Resonanzanzahl nach dem Spielen deiner eigenen Befehlskarten oder am Ende deiner Runde zurück."
  },
  State_126785_Name = {
    Text = "<ResonanceKeywords:Resonanz X>"
  },
  State_126789_Desc = {
    Text = "Fügt allen Feinden 2 Schichten <WitherKeywords:Verzaubert> zu."
  },
  State_126789_Name = {
    Text = "<WitherKeywords1:Verloben>"
  },
  State_126790_Desc = {
    Text = "Entferne alle <WitherKeywords:Betrunkenheit> der Feinde. Jeder entfernte Stapel verursacht [DescArg1]% des maximalen Lebens des Ziels als festgesetzten Schaden und löst 40% Gift aus."
  },
  State_126790_Name = {
    Text = "<WitherKeywords2:Fesseln>"
  },
  State_126803_Desc = {
    Text = "Die nächsten [DescArg1] Befehlskarten, die gespielt werden, werden 3 Runden in die Zukunft geschickt."
  },
  State_126803_Name = {
    Text = "Vorherbestimmtes Rad"
  },
  State_126893_Name = {
    Text = "Zustand@Schicksal Ultra Reiner Identifikator"
  },
  State_126895_Desc = {
    Text = "Gesamtschaden, fester <PowerIconKeywords:STR>- & <TentacleInjurieIconKeywords:Tentakelschaden>-Gewinn, festes <IntoxicationIconKeywords:Gift> & fester <RetaliateIconKeywords:Gegenangriff> dieser Karte jeweils +[DescArg1]%; Finaler fester Rollen-Schild, feste LP-Wiederherstellung und <ExhaustionIconKeywords:STR▼> dieser Karte jeweils +[DescArg2]%. Karten mit „Singularitätslaterne“ können keinen „Dimensionsgleiter“ auslösen."
  },
  State_126895_Name = {
    Text = "<SingularityKeywords:Singularitätslaterne [DescArg2]>"
  },
  State_126896_Name = {
    Text = "Zustand@Licht der Transzendenz Karte reduziert die Stapelungen der Arithmetica-Harmonie"
  },
  State_126900_Name = {
    Text = "Zustand@Schicksal Ultra Beruf Initialisierung 2"
  },
  State_126901_Name = {
    Text = "Zustand@Schicksal Ultra Beruf Initialisierung 1"
  },
  State_126903_Name = {
    Text = "Zustand@Hyperraum Quasar Markierung"
  },
  State_126927_Desc = {
    Text = "Team-Einzigartig: Die festen Vergiftungs- und Vergiftungswirkungsauslöser des Trägers werden um <WeaponEffect_Num:[StateArg1]%.> erhöht. Der Träger erhält <WeaponEffect_Num:[StateArg2]> Aliemus, wenn er „Resonanz“ in jeder Runde zum ersten Mal auslöst."
  },
  State_126927_WeaponDesc = {
    Text = "Die festen Vergiftungs- und Vergiftungswirkungsauslöser des Trägers werden um <WeaponEffect_Num:[StateArg1]%.> erhöht. Der Träger erhält <WeaponEffect_Num:[StateArg2]> Aliemus, wenn er in jeder Runde zum ersten Mal „Resonanz“ auslöst."
  },
  State_126990_Name = {
    Text = "<IntoxicationColour:Vergiftung>"
  },
  State_127108_Desc = {
    Text = "Fügt allen Feinden 5 Schichten <WitherKeywords:Spellbound> zu."
  },
  State_127108_Name = {
    Text = "<WitherKeywords3:Verloben>"
  },
  State_127109_Desc = {
    Text = "Entferne alle <WitherKeywords:Betrunkenheit> der Feinde. Für jeden entfernten Stapel sammele 20% KON des Blutroten Ofens, füge [DescArg1]% des maximalen LP des Ziels als festgesetzten Schaden zu und löse 40% Gift aus."
  },
  State_127109_Name = {
    Text = "<WitherKeywords4:Fesseln>"
  },
  State_127176_Desc = {
    Text = "Für jeden Stapel erhöht sich der feste erlittene Gift-Schaden um 5%, der verursachte DMG verringert sich um [DescArg1]%, maximal bis zu [DescArg2] Stapeln."
  },
  State_127176_Name = {
    Text = "<WitherKeywords0:Verzaubert>"
  },
  State_127264_Desc = {
    Text = "Beim Spielen dieser Karte erhält der \"Wahrnehmer\" 1 Stapel von <MonsterTimeBeacon:Schleife>. Wenn diese Karte verworfen wird, verliert der \"Wahrnehmer\" 1 Stapel von <MonsterTimeBeacon:Schleife>."
  },
  State_127264_Name = {
    Text = "<MonsterSightUnbound:Blick Ungebunden>"
  },
  State_127266_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_127266_Name = {
    Text = "Nicht erweckt"
  },
  State_127267_Desc = {
    Text = "Am Ende des Zuges, erhalte 1 Stapel von <MonsterTimeBeacon:Schleife>."
  },
  State_127267_Name = {
    Text = "Entropie rückgängig gemacht"
  },
  State_127271_Desc = {
    Text = "Nach der Freigabe der Posse erhält man 1 Stapel von <MonsterTimeBeacon:Schleife>."
  },
  State_127271_Name = {
    Text = "Mobius-Gefangener"
  },
  State_127272_Desc = {
    Text = "Maximal 3 Stapel. Wenn der „Wahrnehmende“ eine Absicht mit 3 Stapeln von <MonsterTimeBeacon:Schleife> freisetzt, wird der <MonsterTimeBeacon:Schleife>-Effekt ausgelöst, die <MonsterTimeBeacon:Schleife> wird gelöscht und negative Zustände entfernt."
  },
  State_127272_Name = {
    Text = "<WhiteWord:Schleife>"
  },
  State_127275_Desc = {
    Text = "Für jeden Stapel erhöht sich der feste erlittene Gift-Schaden um 5%, der verursachte DMG verringert sich um [DescArg1]%, maximal bis zu [DescArg2] Stapeln."
  },
  State_127275_Name = {
    Text = "<WitherKeywords:Verzaubert>"
  },
  State_127276_Desc = {
    Text = "Beim Spielen dieser Karte erhält der \"Wahrnehmer\" 1 Stapel von <MonsterTimeBeacon:Schleife>. Wenn diese Karte verworfen wird, verliert der \"Wahrnehmer\" 1 Stapel von <MonsterTimeBeacon:Schleife>."
  },
  State_127276_Name = {
    Text = "<MonsterSightUnbound:Blick Ungebunden>"
  },
  State_127312_Desc = {
    Text = "Wenn der Psyche-Ansturm des Erweckers +12 erreicht, wird das \"Absolute Axiom\" aktiviert, das einzigartige Effekte gewährt."
  },
  State_127312_Name = {
    Text = "<UltraPotencyKeywords:Letzte Regel>"
  },
  State_127705_Desc = {
    Text = "Die Karte wurde manipuliert! Erleidet beim Spielen [Layer] Schaden. Reduziert die <CardKeyWord:Sabotage>-Stapelungen um die Hälfte."
  },
  State_127705_Name = {
    Text = "<CardKeyWord:Untergrabung>"
  },
  State_127705_WeaponDesc = {
    Text = "Nach dem Ausspielen der Karte erleidet man [StateArg1] Schaden."
  },
  State_127708_Desc = {
    Text = "Nachdem der Gegner eine Nicht-Befehlskarte spielt, erhalten alle Verbündeten [DescArg1] <plural value=\"[DescArg1]\" singular=\"Stapelung\" plural=\"Stapelungen\"> <PowerIconKeywords:Stärke>. Wird unwirksam, nachdem Alte Glut gebrochen wird."
  },
  State_127708_Name = {
    Text = "Fäden des Chaos"
  },
  State_127709_Name = {
    Text = "Spielerstatus des Schwarzen Fadens"
  },
  State_127710_Name = {
    Text = "Auslöser des Schwarzen Fadens"
  },
  State_128026_Name = {
    Text = "Spielerstatus des Weißen Fadens"
  },
  State_128027_Desc = {
    Text = "Nachdem der Gegner eine Befehlskarte spielt, erhalten alle Verbündeten [DescArg1] Schichten vorübergehender <ReinforcePVEKeywords:Festung>. Die alten Glut werden nach dem Zerstören unwirksam."
  },
  State_128027_Name = {
    Text = "Fäden des Gesetzes"
  },
  State_128028_Desc = {
    Text = "Karte wurde manipuliert! Beim Spielen <FixedDamage:Reinen SCH> erleiden und dann die <BrokenCard:Sabotage>-Stapelungen halbieren."
  },
  State_128028_Name = {
    Text = "<CardKeyWord: heimliche Zerstörung>"
  },
  State_128028_WeaponDesc = {
    Text = "Nach dem Ausspielen der Karte erleidet man [StateArg1] Schaden."
  },
  State_128029_Name = {
    Text = "Auslöser des Weißen Fadens"
  },
  State_128067_Name = {
    Text = "Zustand@Kaltes Spinnenmädchen Glut Überwachung"
  },
  State_128069_Name = {
    Text = "Zustand@Kalte Spinnen-Zofe Umschlingen Treffererkennung"
  },
  State_128071_Name = {
    Text = "Zustand@Kalte Spinnenzofe Vorderposition benötigt Beschwörungsmarkierer"
  },
  State_128073_Desc = {
    Text = "Nach jeder Aktion erhältst du [DescArg1] Schichten <ParcloseIconKeywords:Schild> und [DescArg2] Schichten <Chapter5_Monster_Fervor1:Wahnsinn>."
  },
  State_128073_Name = {
    Text = "Wiege der Webmutter"
  },
  State_128082_Desc = {
    Text = "Nach dem Spielen erhält Hameln 3 Punkte Aelius"
  },
  State_128082_Name = {
    Text = "<XushiBKeywords:Kraftvolle Musik>"
  },
  State_128086_Desc = {
    Text = "Nachdem der Gegner eine Befehlskarte spielt, erhält man [DescArg1] <plural value=\"[DescArg1]\" singular=\"Stapelung\" plural=\"Stapelungen\"> von <Chapter5_Monster_Fervor1:Wahnsinn> und tauscht die Positionen mit einem Verbündeten in der hinteren Reihe, nachdem „Alte Glut\" aufgebraucht ist."
  },
  State_128086_Name = {
    Text = "Rad des Schicksals"
  },
  State_128087_Name = {
    Text = "Zustand@Kalte Spinnenzofe Weiße Wiedergeburt Auslöser Markierung"
  },
  State_128089_Name = {
    Text = "Auslöser des Weißen Zyklus"
  },
  State_128216_Name = {
    Text = "Spielerstatus des Weißen Zyklus"
  },
  State_128245_Desc = {
    Text = "Entferne zu Beginn des Zuges. Nachdem 10 Stapelungen erreicht wurden, handle sofort nach dem nächsten Ausspielen einer Karte, indem du <Chapter5_Monster_Fervor2:Wahnsinn> entfernst und die Absicht wechselst, <FragileIconKeywords:Zerbrechlich> zuzufügen und zufällig <BrokenCard:Sabotage> „Fäden des Zerfalls\" anzuheften."
  },
  State_128245_Name = {
    Text = "Vorübergehender Wahnsinn"
  },
  State_128246_Name = {
    Text = "Spielerstatus des Schwarzen Zyklus"
  },
  State_128247_Desc = {
    Text = "Beim Tod wiederbeleben, immun gegen Schaden und 100% LP haben. Die Absicht wechseln zu: „Schicksalswahn\": Erhalte nach jeder Aktion [DescArg1] Punkte <PowerIconKeywords:Stärke> und [DescArg2] Schichten <Chapter5_Monster_Fervor2:Wahnsinn>."
  },
  State_128247_Name = {Text = "Emergenz"},
  State_128248_Desc = {
    Text = "Zu Beginn des Zuges entfernen. Nachdem 10 Stapelungen erreicht wurden, handle sofort nach dem nächsten Ausspielen einer Karte, entferne <Chapter5_Monster_Fervor1:Wahnsinn> und wechsle die Absicht zu „Netz der Fesselung\", die <WeaknessIconKeywords:Symptom: Schwäche> zufügt und zufällig Befehlskarten versiegelt."
  },
  State_128248_Name = {
    Text = "Vorübergehender Wahnsinn"
  },
  State_128250_Name = {
    Text = "Auslöser des Schwarzen Kreislaufs"
  },
  State_128251_Desc = {
    Text = "Nachdem der Gegner eine Nicht-Befehlskarte spielt, erhält man [DescArg1] <plural value=\"[DescArg1]\" singular=\"Stapelung\" plural=\"Stapelungen\"> von <Chapter5_Monster_Fervor1:Wahnsinn>, und tausche die Positionen mit einem Verbündeten in der hinteren Reihe, nachdem „Alte Glut\" aufgebraucht ist."
  },
  State_128251_Name = {
    Text = "Rad des Abgrunds"
  },
  State_128253_Desc = {
    Text = "Beim Tod wiederbeleben, immun gegen Schaden und 100% LP haben. Die Absicht wechseln zu: „Schicksalswahn\": Erhalte nach jeder Aktion [DescArg1] Schichten <ParcloseIconKeywords:Schild> und [DescArg2] Schichten <Chapter5_Monster_Fervor1:Wahnsinn>."
  },
  State_128253_Name = {Text = "Emergenz"},
  State_128257_Desc = {
    Text = "Erhalte nach jeder Aktion [DescArg1] Punkte <PowerIconKeywords:Stärke> und [DescArg2] Schichten <Chapter5_Monster_Fervor2:Wahnsinn>."
  },
  State_128257_Name = {
    Text = "Flüstern der Webmutter"
  },
  State_128643_Name = {
    Text = "Zustand@Spieler Diese Runde gespielte Symptomenanzahl"
  },
  State_128644_Desc = {
    Text = "Entferne zu Beginn des Zuges. Nachdem 10 Stapel erreicht wurden, handle sofort nach dem Ausspielen der nächsten Karte, indem du <Chapter5_Monster_Fervor3:Wahnsinn> entfernst und die Absicht zufällig wechselst."
  },
  State_128644_Name = {
    Text = "Vorübergehender Wahnsinn"
  },
  State_128645_Desc = {
    Text = "Die Absicht wird zufällig aus vier Arten ausgewählt, darf sich jedoch nicht wiederholen. Nach der Freisetzung von Verherrlichung wechsle sofort die Absicht. Erhalte 1 Stapel von <Chapter5_Monster_Fervor3:Wahnsinn>, nachdem eine Befehlskarte gespielt wurde."
  },
  State_128645_Name = {
    Text = "Sinfonie der Gesetze"
  },
  State_128646_Name = {
    Text = "Zustand@verwirrtes Schicksal schwerer Schlag Ausspielen überprüfen"
  },
  State_128648_Desc = {
    Text = "Bis zum Beginn der nächsten Runde erhältst du jedes Mal, wenn du eine Befehlskarte spielst, [DescArg1] vorübergehende <PowerIconKeywords:Stärke>."
  },
  State_128648_Name = {
    Text = "Kokon der Wut"
  },
  State_128692_Desc = {
    Text = "Nach erlittenem aktivem Schaden oder Tentakelschaden wird eine entsprechende Menge an „Alte Glut\" entfernt und 300 % der entfernten Menge an Lebenspunkten verloren. Bei erlittenem anderen Schaden wird die Hälfte entfernt. Die Anzahl von „Alte Glut\" wird jede Runde zurückgesetzt."
  },
  State_128692_Name = {
    Text = "<AshesPastKeyWord:Alte Glut>"
  },
  State_128695_Name = {
    Text = "Zustand@Verwirrte Schicksalsabsicht Markierung"
  },
  State_129297_Desc = {
    Text = "Setze zu Beginn der nächsten [Layer] Kämpfe das Leben aller Feinde auf 1."
  },
  State_129297_Name = {
    Text = "Kleine“N“Unterstützung"
  },
  State_129569_Name = {
    Text = "Zustand@Verwirrtes Schicksal Freude Theater Auslöser Marker"
  },
  State_129570_Name = {
    Text = "Zustand@Fehlanordnung des Schicksals Schicksalsflüstern Auslöser Marker"
  },
  State_129571_Name = {
    Text = "Zustand@Derangiertes Schicksal Endlose Nichtigkeit Auslöser Marker"
  },
  State_129612_Desc = {
    Text = "Die Absicht wird zufällig aus vier Typen ausgewählt, darf sich jedoch nicht wiederholen. Wechsle die Absicht sofort nach der Freisetzung der Verherrlichung. Erhalte 1 Stapel <Chapter5_Monster_Fervor3:Wahnsinn>, nachdem eine Befehlskarte gespielt wurde."
  },
  State_129612_Name = {
    Text = "Sinfonie der Gesetze"
  },
  State_129625_Desc = {
    Text = "Die Absicht wird zufällig aus vier Typen ausgewählt, darf sich jedoch nicht wiederholen. Wechsle die Absicht sofort nach der Freisetzung eines Erhebens. Erhalte 1 Stapel von <Chapter5_Monster_Fervor3:Fervor>, nachdem eine Befehlskarte gespielt wurde. Erhalte 1 Stapel von \"Verzerrungsfusion\", jedes Mal wenn die Absicht gewechselt wird."
  },
  State_129625_Name = {
    Text = "Sinfonie der Gesetze"
  },
  State_129643_Desc = {
    Text = "Erhalte 1 Schicht jedes Mal, wenn die Absicht gewechselt wird. Bei 10 Schichten von „Entwirrtes Schicksal\" ändert sich die Absicht zur unveränderlichen „Rasende Emergenz\", die massiven Schaden verursacht und Debuffs zufügt."
  },
  State_129643_Name = {
    Text = "Verdrehte Schicksal"
  },
  State_129644_Name = {
    Text = "Verzerrte Fusionssperrabsichten"
  },
  State_129650_Desc = {
    Text = "Team Unique: Wenn der Ausrüster der Erwecker „Ramona: Zeitverwittert“ ist, wird die Synchro-Rate, die andere Erwecker beim Abschluss der Stufe erhalten, um +<WeaponEffect_Num:[StateArg1]%> erhöht, aber der Ausrüster erhält keine Synchro-Rate."
  },
  State_129650_WeaponDesc = {
    Text = "Wenn der Ausrüster der Erweckte Körper „Ramona: Zeitverwittert \" ist, erhalten beim Abschluss des Levels andere Erweckte Körper +<WeaponEffect_Num:[StateArg1] %> Synchro-Rate, aber der Ausrüster erhält keine Synchro-Rate."
  },
  State_129761_Desc = {
    Text = "Ändere den Rückgabewert der Schnittstelle für die Wachstumsstärke der Spieler im Spiel, jede Schicht erhöht um 1 %."
  },
  State_129761_Name = {
    Text = "Korrektur der Wachstumsintensität im Spiel"
  },
  State_129845_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_129845_Name = {
    Text = "Nicht erweckt"
  },
  State_129846_Name = {
    Text = "Raumwelle-Zähler"
  },
  State_129848_Desc = {
    Text = "Jedes Mal, wenn [DescArg1] Karten den Dimensionsriss verlassen, erhalten sie [DescArg2] Schichten <BrokenCard: heimliche Zerstörung>."
  },
  State_129848_Name = {
    Text = "Puppentheater Eröffnet"
  },
  State_129849_Desc = {
    Text = "Erzeuge Kopien der ersten Befehlskarte, die der Feind in jeder Runde spielt, und lege sie in den Dimensionsriss. Wenn die Karte in den Dimensionsriss gelangt, gewähre ihr <DepleteIconKeywords:Verbrauch>. Bei der ersten Freigabe der Posse in jeder Runde wird die ganz links stehende Karte herausgenommen und oben auf den Ziehstapel gelegt."
  },
  State_129849_Name = {
    Text = "Schicksalsweberei"
  },
  State_129850_Desc = {
    Text = "In jedem Dimensionsriss, in dem sich eine Befehlskarte befindet, verringert sich die maximale Handgröße des Spielers um 1. Wenn diese voll ist, wird beim nächsten Ausspielen einer Karte das „Netz der Ewigkeit\" sofort aktiviert, und nach der Aktion wird der Dimensionsriss geleert und die Absicht auf „Elegie Über Das Schicksal\" geändert."
  },
  State_129850_Name = {Text = "Raumwelle"},
  State_129854_Desc = {
    Text = "Für jede Befehlskarte im Dimensionsriss verringert sich die maximale Handgröße des Spielers um 1. Wenn diese bereits voll ist, führt „Das Netz Der Ewigkeit\" sofort eine Aktion aus, wenn die nächste Karte gespielt wird, und leert nach der Aktion den Dimensionsriss und ändert die Absicht in „Moira, Wie Ich Es Verkünde\"."
  },
  State_129854_Name = {Text = "Raumwelle"},
  State_129864_Desc = {
    Text = "Jedes Mal nach dem Ausspielen einer Karte 1 Schicht “Müdigkeit“ entfernen. Zu Beginn der Runde wird die Anzahl der Schichten “Müdigkeit“ auf 12 auffüllt."
  },
  State_129864_Name = {Text = "Zorn"},
  State_129865_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_129865_Name = {
    Text = "Nicht erweckt"
  },
  State_129872_Desc = {
    Text = "Vorübergehende Variable."
  },
  State_129872_Name = {Text = "Zähler1"},
  State_129873_Desc = {
    Text = "Erhalte den Zustand [Layer] Schichten _Zähler1_."
  },
  State_129873_Name = {
    Text = "Verpackungstest1"
  },
  State_129874_Desc = {
    Text = "Vorübergehende Variable."
  },
  State_129874_Name = {
    Text = "Verstärker 1"
  },
  State_130358_Desc = {
    Text = "Die nächste ausgespielte Befehlskarte wirkt zusätzlich 2 Mal."
  },
  State_130358_Name = {
    Text = "Fadenspielpuppe"
  },
  State_130387_Desc = {
    Text = "Nach dem Verbrauch von „Fadenpuppe\" wirkt die erste gespielte Befehlskarte in jeder folgenden Runde zusätzlich 2 Mal. Bei einem Anführer Kampf erhalten alle Erwecker 50 Punkte Aliemus und 1000 Punkte Keyflare."
  },
  State_130387_Name = {
    Text = "Begräbnis des Schicksals"
  },
  State_130388_Name = {
    Text = "<RetainIconKeywords:Behalten>: Erhalte [DescArg1] Silberschlüssel-Energie"
  },
  State_130389_Desc = {
    Text = "Nach dem Ausspielen erhalten alle Erwecker [DescArg1] Aliemus"
  },
  State_130389_Name = {
    Text = "Nach dem Ausspielen erhalten alle Erwecker [DescArg1] Aliemus"
  },
  State_130390_Desc = {
    Text = "Arithmetica-Grenze und maximale Handgröße erhöhen sich um 1."
  },
  State_130390_Name = {
    Text = "Überschüssige Profilierung"
  },
  State_130391_Desc = {
    Text = "Jedes Mal, wenn du eine „Symptomkarte\" spielst, sinken die Arithmetica-Kosten der „Marionette\" um 1."
  },
  State_130391_Name = {
    Text = "Nachklang der Unreinheit"
  },
  State_130490_Desc = {
    Text = "Der Schaden, Schild, Heilung, Stärke, Berauben, Tentakelschaden, fester Giftschaden und fester Gegenangriff dieser Karte erhöhen sich unabhängig um 1+[Layer]%."
  },
  State_130490_Name = {
    Text = "Singularitätslaterne α"
  },
  State_130498_Desc = {
    Text = "Die nächste ausgespielte Befehlskarte wirkt zusätzlich 2 Mal."
  },
  State_130498_Name = {
    Text = "Begräbnis des Schicksals"
  },
  State_130500_Desc = {
    Text = "Im Anführer Kampf beträgt der Todwiderstand +100%. Nach dem Auslösen des „Todwiderstands\" zwingt die „Marionette\" im nächsten Zug nicht mehr dazu, eine Befehlskarte zu spielen, sondern erlaubt die Auswahl einer Befehlskarte aus der Hand."
  },
  State_130500_Name = {
    Text = "Blick des Märtyrers"
  },
  State_130501_Desc = {
    Text = "Die nächste Befehlskarte hat Arithmetica-Kosten von 0."
  },
  State_130501_WeaponDesc = {
    Text = "Ändere die Arithmetica Kosten der Karte vor dem Spielen"
  },
  State_130512_Desc = {
    Text = "Die nächste ausgespielte Befehlskarte hat 2 zusätzliche Effekte und die Arithmetica-Kosten werden um 2 Punkte gesenkt."
  },
  State_130512_Name = {
    Text = "Fadenspielpuppe"
  },
  State_130517_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Beim Ausrüsten und zu Beginn der Runde wird zufällig einer der folgenden Effekte ausgelöst: Erhalte <Energy:[Energy:StateArg1]> Aliemus und <PVPSlowKeywords:Stagnierung> dich selbst; Erhalte <Energy:[Energy:StateArg3]> Aliemus; Erhalte <Energy:[Energy:StateArg4]> und [StateArg5] <PVPDerivativeCardKeywords_17:„Einblick\">."
  },
  State_130517_Name = {
    Text = "Weisheit des riskanten Spiels"
  },
  State_131046_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nach „Verherrlichung \" erhält man <Block:[Block:StateArg1]> Schild und <DelayKeywords:Latenz>: <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_131046_Name = {
    Text = "Fernes Eden"
  },
  State_131047_Desc = {
    Text = "Diese Runde wird die nächste [Layer]-Nutzung von Bande zweimal wirksam."
  },
  State_131047_Name = {
    Text = "Doppelte Schlüsselanweisung"
  },
  State_131048_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Nach dem ersten Ausspielen von „Fähigkeit\" pro Runde wird dem Feind mit <HPAndShieldMin:niedrigstem Leben und Schild> <Damage:[Damage:StateArg1]> Schaden zugefügt."
  },
  State_131048_Name = {
    Text = "Eingesperrter Wahnsinn"
  },
  State_131055_Desc = {
    Text = "Ziehe in jeder Runde -1 Karte. Die Schild- und Gesundheitsregeneration aller Erwecker wird um 20% erhöht."
  },
  State_131055_Name = {
    Text = "Haare kämmen"
  },
  State_131056_Desc = {
    Text = "Nach Verlust von Leben wird eine gleiche Menge an verzögertem Wahnsinn in Schild umgewandelt."
  },
  State_131056_Name = {
    Text = "Strudel-Schutz"
  },
  State_131058_Desc = {
    Text = "Die Grundwerte des Wahnsinns aller Erwecker erhöhen sich um 10 Punkte. Nach der Freigabe der Verherrlichung erhältst du 1 Punkt Arithmetica, und jeder Erwecker kann pro Runde nur einmal ausgelöst werden."
  },
  State_131058_Name = {
    Text = "Wange reiben"
  },
  State_131059_Name = {
    Text = "Mosk Ultimative Fähigkeit Aufstieg"
  },
  State_131061_Desc = {
    Text = "Silberschlüssel-Energiegrenze und Verbrauch von Schlüsseltoken Silberschlüssel-Energie +350. Der erste Schlüsseltoken wird in jeder Runde 2 Mal wirksam."
  },
  State_131061_Name = {
    Text = "Snacks füttern"
  },
  State_131064_Desc = {
    Text = "Erhalte 1 Macht nach der Freisetzung von Wahnexplosion, und jeder Erwecker kann es nur einmal pro Runde auslösen."
  },
  State_131064_Name = {
    Text = "Wange reiben"
  },
  State_131069_Desc = {
    Text = "Die Schildgeneration und Lebensregeneration aller Erwecker +20%."
  },
  State_131069_Name = {
    Text = "Haare kämmen"
  },
  State_131073_Desc = {
    Text = "Team Unique: Zu Beginn des Kampfes erhält man Wahnsinn in Höhe von <WeaponEffect_Num:[StateArg1] %> der Grundwut. Der endgültige Schaden der Verherrlichung des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg2] %> der Grundwut. Beim Wechsel in den Zustand „Tobende Wellen \" erhält man vorübergehend die Reichsbeherrschung in Höhe von <WeaponEffect_Num:[StateArg3] %>, mit einer Abklingzeit von 3 Runden."
  },
  State_131073_WeaponDesc = {
    Text = "Zu Beginn des Kampfes erhältst du [DescArg1] Punkte Aliemus. Der Gesamtschaden der Verherrlichung des Ausrüsters erhöht sich um [DescArg2] %. Beim Wechsel in den Zustand „Tobende Wellen \" erhältst du [DescArg3] Punkte vorübergehende Reichsbeherrschung, 3 Runden Abkühlung(verbleibend [DescArg4] Runden)."
  },
  State_131078_Desc = {
    Text = "Die erste Aktivierung der Posse wirkt in jeder Runde zweimal."
  },
  State_131078_Name = {
    Text = "Snacks füttern"
  },
  State_131118_Desc = {
    Text = "Jedes Mal, wenn du Schaden erleidest oder LP verlierst, kann der Wert 3 % der Max LP nicht überschreiten."
  },
  State_131118_Name = {
    Text = "Kokon des Schicksals"
  },
  State_131123_Desc = {
    Text = "Entferne zu Beginn des Zuges. Nachdem 10 Stapel erreicht wurden, handle sofort nach dem Ausspielen der nächsten Karte und wechsle zur nächsten Absicht, indem du <Chapter5_Monster_Fervor4:Wahnsinn> entfernst."
  },
  State_131123_Name = {
    Text = "Vorübergehender Wahnsinn"
  },
  State_131127_Desc = {
    Text = "Die Haltung, die vom Schicksal gefesselt ist. Für jede gespielte Befehlskarte des Gegners erhält man 1 Stapelung „vorübergehender Wahnsinn„."
  },
  State_131127_Name = {
    Text = "Schicksalsbändiger"
  },
  State_131134_Desc = {
    Text = "Nach dem Tod erhält Nefraea [DescArg1] <plural value=\"[DescArg1]\" singular=\"Stapelung\" plural=\"Stapelungen\"> vorübergehenden Wahnsinns, verliert aber 3% der Max LP."
  },
  State_131134_Name = {Text = "Unruhe"},
  State_131186_Desc = {
    Text = "1 zusätzliche Wirkung nach dem Spielen, aber erleidet [DescArg1] Schaden."
  },
  State_131186_Name = {
    Text = "<ExclamationPointColour:Schicksalsbruchstücke>"
  },
  State_131188_Desc = {
    Text = "Die gespielte „Fähigkeit\" betritt den „Dimensionsriss\" und fügt allen gleichnamigen Fähigkeiten „Schicksalsfragmente\" hinzu, die nach dem Verlassen des Dimensionsrisses entfernt werden. Wenn der Dimensionsriss voll ist, leert „Netz des Verrats\" Nefraea nach der Aktion den Dimensionsriss und verwandelt die nächste Absicht in eine mächtige Verherrlichung."
  },
  State_131188_Name = {
    Text = "Dimensionsriss"
  },
  State_131191_Name = {
    Text = "Kognitive Beeinträchtigung"
  },
  State_131242_Desc = {
    Text = "Der Schaden, Schild, Heilung, Stärke, Berauben, Tentakelschaden, fester Giftschaden und fester Gegenangriff dieser Karte erhöhen sich unabhängig um 1+[Layer]%."
  },
  State_131242_Name = {
    Text = "Singularitätslaterne β"
  },
  State_131258_Desc = {
    Text = "Die Fäden des Spinnrads drehen sich und zerreißen die Fäden eines fehlgeleiteten Schicksals. Entferne 1 Stapelung nach dem Einsetzen einer Posse oder dem Spielen einer „Schicksalsfragment\"-Karte. Wenn alle Stapelungen entfernt sind, entfesselt Arachne die Verfolgung: „Fäden an ihrem Platz\" und verursacht massiven Schaden. Nach 3 Auslösungen wird der „Kokon des Schicksals\" des Gegners vollständig zerschmettert!"
  },
  State_131258_Name = {
    Text = "Schicksalsstörung"
  },
  State_131261_Name = {
    Text = "Arachne-Theater"
  },
  State_131351_Desc = {
    Text = "Andere Erweckte geben 1 Schicht frei, nachdem sie die Verherrlichung verwendet haben, und Mosk setzt „Wirbel! Kugel!\" zur Verfolgung ein."
  },
  State_131351_Name = {
    Text = "Wirbel Laden"
  },
  State_131439_Desc = {
    Text = "Die nächste gespielte Befehlskarte wirkt zusätzlich 2 Mal und die Arithmetica-Kosten werden auf 0 gesenkt."
  },
  State_131439_Name = {
    Text = "Fadenspielpuppe"
  },
  State_131637_Desc = {
    Text = "Beschwört beim Tod einen zufälligen „Abgrundspinnenschwarm\" oder eine „Leng-Spinnenkolonie\" und reduziert dessen „Schwarmeffekt\" um 1 Stapel."
  },
  State_131637_Name = {
    Text = "Schwarmeffekt"
  },
  State_131638_Desc = {
    Text = "Beschwört beim Tod eine zufällige „Gebrochene Matriarchin\" oder „Seidengeist-Matriarchin\" und reduziert deren „Schwarmeffekt\" um 1 Stapel."
  },
  State_131638_Name = {
    Text = "Schwarmeffekt"
  },
  State_131645_Desc = {
    Text = "Team Unique: Beim Wechsel in die Haltung „Tobende Wellen \" erhalte temporäre Reichsbeherrschung in Höhe von <WeaponEffect_Num:[StateArg1] %> der aktuellen Reichsbeherrschung, 3 Runden Abkühlung."
  },
  State_131645_WeaponDesc = {
    Text = "Wechseln Sie in die Haltung „Tobende Wellen \", um [DescArg2] Punkte temporäre Reichsbeherrschung zu erhalten, 3 Runden Abkühlung(verbleibend: [DescArg1] Runden)."
  },
  State_131657_Desc = {
    Text = "Andere Erweckte geben 1 Schicht frei, nachdem sie die Verherrlichung verwendet haben, und Mosk setzt „Wirbel! Kugel!\" zur Verfolgung ein."
  },
  State_131657_Name = {
    Text = "<WhirlpoolKeywords:Wirbel laden>"
  },
  State_131660_Desc = {
    Text = "Jede Schicht erhöht die Wahnsinnsanforderung für die Freigabe von Verherrlichung um 1 Punkt."
  },
  State_131660_Name = {
    Text = "Wutverbrauch Festwertanpassung"
  },
  State_131675_Desc = {
    Text = "Diese Karte hat beim nächsten Spielen eine Wahrscheinlichkeit von [StateArg1]%, dass sie 1 zusätzliche Wirkung entfaltet."
  },
  State_131675_Name = {
    Text = "<CardKeyWord:Risikowette>"
  },
  State_131684_Desc = {
    Text = "In den nächsten [Layer] Malen wirkt „Wirbel! Strömung! Kugel!\" 2 Mal."
  },
  State_131684_Name = {
    Text = "Muskus! Groß! Boom! Explosion"
  },
  State_131749_Desc = {
    Text = "Team Unique: Nach Beginn der Erkundung wird 1 Karte „Weisheit des riskanten Spiels \" in den Ziehstapel gemischt. „Weisheit des riskanten Spiels\": verbrauche 1 Arithmetica. Mische alle Befehlskarten in deiner Hand zufällig in den Ziehstapel; die gemischten Befehlskarten haben beim nächsten Spielen eine Wahrscheinlichkeit von <WeaponEffect_Num:[StateArg1] %> für 1 zusätzliche Wirkung und für jede gemischte Befehlskarte erhalten alle Erwecker 2 Punkte Aliemus. <RetainIconKeywords: Behalten>. <DepleteIconKeywords: Verbrauch>. <GuyouKeywords: Inhärent>."
  },
  State_131749_WeaponDesc = {
    Text = "Nach Beginn der Erkundung wird 1 Karte „Weisheit des riskanten Spiels \" in den Ziehstapel gemischt. „Weisheit des riskanten Spiels\": verbrauche 1 Arithmetica. Mische alle Befehlskarten in deiner Hand zufällig in den Ziehstapel. Die gemischten Befehlskarten haben beim nächsten Ausspielen eine Wahrscheinlichkeit von <WeaponEffect_Num:[StateArg1] %> für 1 zusätzliche Wirkung und für jede gemischte Befehlskarte erhält jeder Erwecker 2 Punkte Aelius. <RetainIconKeywords:Behalten>. <DepleteIconKeywords:Verbrauch>. <GuyouKeywords:Inhärent>."
  },
  State_131769_Name = {
    Text = "Zustand@Zucht Fleisch Beruf Initialisierung 1"
  },
  State_131779_Desc = {
    Text = "Wird erst nach [Layer] Mal verwendet, in den Ablagestapel gelegt und die Anzahl zurückgesetzt, aber das „Gebet\" gilt nur beim ersten Gebrauch."
  },
  State_131779_Name = {
    Text = "Kann [Layer] Mal verwendet werden"
  },
  State_131789_Desc = {
    Text = "Alternativen. Füge 1 Karte mit tid = [Layer] deiner Hand hinzu."
  },
  State_131789_Name = {
    Text = "Bestimmte Karte hinzufügen"
  },
  State_131807_Name = {
    Text = "Zustand@Zucht Fleisch Perfektes Identifikator"
  },
  State_131824_Name = {
    Text = "Status@Monster Tawil Wechsel Absicht Spieler Zuhörer"
  },
  State_131846_Desc = {
    Text = "Beschwört beim Tod einen zufälligen „Abgrundspinnenschwarm\" oder eine „Leng-Spinnenkolonie\" und reduziert dessen „Schwarmeffekt\" um 1 Stapel."
  },
  State_131846_Name = {
    Text = "Schwarmeffekt"
  },
  State_131908_Desc = {
    Text = "Teilt die LP, den Rollen-Schild und Aliemus des Ziels, erzeugt jedoch keine Kampfstatistiken."
  },
  State_131908_Name = {
    Text = "Festmahl des Verfalls Sprungbrett"
  },
  State_131909_Desc = {
    Text = "Besitzen Sie diesen Zustand, können Sie Verherrlichung verwenden."
  },
  State_131909_Name = {
    Text = "Permanente Versiegelung"
  },
  State_132366_Desc = {
    Text = "Führt einen Nachfolgeangriff aus, nachdem andere Erweckte eine Angriffskarte eingesetzt haben."
  },
  State_132366_Name = {Text = "Verfolgung"},
  State_132465_Desc = {
    Text = "Schaden, Schild, Heilung, Stärke, Schwächung, Tentakelschaden, feste Vergiftung und fester Konter dieses Erweckungskörpers werden erhöht, unabhängig multipliziert mit 1+[Layer]%."
  },
  State_132465_Name = {
    Text = "Verstärktes Verschlingen α"
  },
  State_132469_Desc = {
    Text = "Schaden, Schild, Heilung, Stärke, Schwächung, Tentakelschaden, feste Vergiftung und fester Konter dieses Erweckungskörpers werden erhöht, unabhängig multipliziert mit 1+[Layer]%."
  },
  State_132469_Name = {
    Text = "Verstärktes Verschlingen β"
  },
  State_132539_Desc = {
    Text = "Sammlungstest-Artefakt"
  },
  State_132539_Name = {
    Text = "Sammlungstest-Artefakt"
  },
  State_132539_WeaponDesc = {Text = "Test"},
  State_132560_WeaponDesc = {
    Text = "Jedes Mal, wenn Smaragdfire [Damage:StateArg2] Schaden verursacht, erhältst du eine verbrauchte Karte [Grünflamme]"
  },
  State_132564_WeaponDesc = {
    Text = "Jedes Mal, wenn Smaragdfire [Damage:StateArg2] Schaden verursacht, erhältst du eine verbrauchte Karte [Grünflamme]"
  },
  State_132565_WeaponDesc = {
    Text = "Jedes Mal, wenn Smaragdfire [Damage:StateArg2] Schaden verursacht, erhältst du eine verbrauchte Karte [Grünflamme]"
  },
  State_132598_Desc = {
    Text = "Wenn in diesem Zug Tentakelschaden zugefügt wird, wird zusätzlich Gift in Höhe von [Layer] % des zugefügten Schadens zugefügt."
  },
  State_132598_Name = {
    Text = "Abgründige Besessenheit"
  },
  State_132609_Desc = {
    Text = "Wenn der Bildhauer einen Schild anlegt, erhöht sich der Tentakelschaden um [StateArg1]"
  },
  State_132609_Name = {
    Text = "Reich der Vergessenheit"
  },
  State_132609_WeaponDesc = {
    Text = "Wenn der Bildhauer einen Schild anlegt, erhöht sich der Tentakelschaden um [StateArg1]"
  },
  State_132669_Desc = {
    Text = "Schaden, Schild, Heilung, Stärke, Schwächung, Tentakelschaden, feste Vergiftung und fester Konter der Karten dieses Erweckungskörpers werden erhöht, unabhängig multipliziert mit 1+[Layer]%."
  },
  State_132669_Name = {
    Text = "Schicksals-Hyperdimension α"
  },
  State_132840_Name = {
    Text = "Der Persönlichkeitseffekt-Bonus der Befehlskarte von „24„ wird verdoppelt. Nachdem „24„ Verherrlichung entfesselt hat, läuft der verdoppelte Persönlichkeitsbonus-Effekt in diesem Zug ab"
  },
  State_132891_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Erhalte [StateArg1] <StrongEffectKeywords:Amplifikation> beim Ausrüsten. Nachdem andere Verbündete Verherrlichung einsetzen, gewähre ihnen <PVPOneMeetingKeywords:Ichigo Ichie>."
  },
  State_132891_Name = {
    Text = "Grübeleien unter Kirschblüten"
  },
  State_132892_Desc = {
    Text = "·Beim Erhalten werden die „Ichigo Ichie\"-Zustände anderer Verbündeter entfernt; erhalte Amplifikations-Effekte entsprechend der Anzahl der Verbündeten, die „Der Mythos unter den Kirschblüten\" ausgerüstet haben, maximal 3 Stapel.\n·Charaktere, die „Der Mythos unter den Kirschblüten\" ausgerüstet haben, können „Ichigo Ichie\" nicht erhalten."
  },
  State_132892_Name = {
    Text = "Ichigo Ichie"
  },
  State_133294_Name = {
    Text = "Blutrote Einladung"
  },
  State_133353_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nach dem Ausrüsten werden die Beschreibungen von „Schlag\", „Fähigkeit\" und „Verherrlichung\" des Ausrüsters unkenntlich, aber jede Instanz von Schaden, Rollen-Schild und LP-Wiederherstellung wird zufällig um [StateArg1] %～[StateArg2] % erhöht."
  },
  State_133353_Name = {
    Text = "Märchen im Schlamm"
  },
  State_133354_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Bleibt nach dem Tod des Schicksrads erhalten. Wenn der Ausrüster stirbt und nach den folgenden [Layer] Runden im Todeszustand, erhalten andere Verbündete <Heal:[Heal:StateArg1]> <PVPFeatheredSeedsKeyWords:Gynoecium> und LP."
  },
  State_133354_Name = {
    Text = "Möge sich die Welt in Duft verwandeln"
  },
  State_133369_Desc = {
    Text = "Die nächsten [DescArg1] Nicht-Tawil-Befehlskarten, die gespielt werden, wirken zweimal."
  },
  State_133369_Name = {
    Text = "Das Silberschlüsseltor"
  },
  State_133372_Desc = {
    Text = "Falls aktuell in einer Ultra-Runde, aktiviere den „Singularitäts-Verzerrung„-Effekt. „Singularitäts-Vernichtung„ garantiert ebenfalls die nächste „Singularitäts-Verzerrung„-Auslösung in dieser Runde."
  },
  State_133372_Name = {
    Text = "<SingularityKeywords:Singularitäts-Verzerrung>"
  },
  State_133391_Desc = {
    Text = "Wenn die LP des Ziels gleich oder unter der Anzahl der Stapelungen liegen, entferne alle Endgültiges Urteil und töte es sofort."
  },
  State_133391_Name = {
    Text = "<CutKeywords:Endgültiges Urteil>"
  },
  State_133395_Desc = {
    Text = "Die nächsten [Layer] <plural value=\"[Layer]\" singular=\"Befehlskarte\" plural=\"Befehlskarten\">, die gespielt werden, lösen „Dimensionsgleiter\" aus."
  },
  State_133395_Name = {
    Text = "Dimensionsgleiter"
  },
  State_133717_Desc = {
    Text = "Der aktuelle Besitzer ist [Layer], und alle aktuellen und zukünftigen Karten erhalten das entsprechende Attribut (Aktuell: Kartenversiegelung)."
  },
  State_133717_Name = {
    Text = "Kartenattribut-Verbreitung"
  },
  State_133774_Desc = {
    Text = "Jede Stapelung erhöht den Gesamtschaden dieser Karte, den festen <PowerIconKeywords:STR>- & <TentacleInjurieIconKeywords:Tentakelschaden>-Gewinn, das feste <IntoxicationIconKeywords:Gift> & den festen <RetaliateIconKeywords:Gegenangriff> um 2 % sowie den finalen festen Rollen-Schild, die feste LP-Wiederherstellung und <ExhaustionIconKeywords:STR▼> um 1 %. Diese Karte kann keinen <SingularityKeywords3:Dimensionsgleiter> auslösen."
  },
  State_133774_Name = {
    Text = "<SingularityKeywords1:Singularitätslaterne>"
  },
  State_133775_Desc = {
    Text = "Jede Stapelung erhöht den Gesamtschaden dieser Karte, den festen <PowerIconKeywords:STR>- & <TentacleInjurieIconKeywords:Tentakelschaden>-Gewinn, das feste <IntoxicationIconKeywords:Gift> & den festen <RetaliateIconKeywords:Gegenangriff> um 2 % sowie den finalen festen Rollen-Schild, die feste LP-Wiederherstellung und <ExhaustionIconKeywords:STR▼> um 1 %"
  },
  State_133775_Name = {
    Text = "<SingularityKeywords2:Singularitätsprisma>"
  },
  State_133961_Desc = {
    Text = "Team Unique: Nach Beginn der Erkundung wird 1 „Frühlingsbotschaft“ in das Deck gemischt: Arithmetica-Kosten 1, erhalte <WeaponEffect_Num:[StateArg1]> Keyflare, verwandelt sich nach dem Spielen dauerhaft in „Kirschblüten“: Arithmetica-Kosten 1, erhalte <WeaponEffect_Num:[StateArg2]> Keyflare, verwandelt sich nach dem Spielen dauerhaft in „Hanafubuki“: Arithmetica-Kosten 1, erhalte <WeaponEffect_Num:[StateArg3]> Keyflare, verwandelt sich nach dem Spielen dauerhaft in „Ichigo Ichie“: Arithmetica-Kosten 1, wähle 1 aus 3 zufälligen freigeschalteten Posse, um sie sofort einzusetzen und 2 Mal auszulösen, verwandelt sich nach dem Spielen dauerhaft in „Frühlingsbotschaft“. Alle diese Karten haben „Behalten“."
  },
  State_133961_WeaponDesc = {
    Text = "Nach Beginn der Erkundung wird 1 „Frühlingsbotschaft \" in das Deck gemischt: Arithmetica-Kosten 1, erhalte <WeaponEffect_Num:[StateArg1]> Keyflare, verwandelt sich nach dem Spielen dauerhaft in „Kirschblüten\": Arithmetica-Kosten 1, erhalte <WeaponEffect_Num:[StateArg2]> Keyflare, nach dem Spielen verwandelt es sich dauerhaft in „Hanafubuki \": Arithmetica-Kosten 1, erhalte <WeaponEffect_Num:[StateArg3]> Keyflare, verwandelt sich nach dem Spielen dauerhaft in „Ichigo Ichie\": Arithmetica-Kosten 1, wähle 1 aus 3 zufälligen freigeschalteten Posse, um sie sofort einzusetzen und 2 Mal auszulösen, verwandelt sich nach dem Spielen dauerhaft in „Frühlingsbotschaft \". Alle diese Karten haben „Behalten\"."
  },
  State_133994_Desc = {
    Text = "Gesamtschaden, fester <PowerIconKeywords:STR>- & <TentacleInjurieIconKeywords:Tentakelschaden>-Gewinn, festes <IntoxicationIconKeywords:Gift> & fester <RetaliateIconKeywords:Gegenangriff> aller Erwecker jeweils +[DescArg1]%; Finaler fester Rollen-Schild, feste LP-Wiederherstellung und <ExhaustionIconKeywords:STR▼> dieser Karte jeweils +[DescArg2]%"
  },
  State_133994_Name = {
    Text = "Singularitätsprisma"
  },
  State_133998_Desc = {
    Text = "Schaden, Schild und Stärkeänderungen dieser Karte werden um [DescArg2]% erhöht, der endgültige Effekt von Tentakelschaden, LP-Heilung, festem Gift und festem Konter wird um [DescArg1]% erhöht. Wird am Ende der Runde oder nach dem Spielen entfernt."
  },
  State_133998_Name = {
    Text = "<TempPowerKeywords1:Temporäre Verstärkung [DescArg1]>"
  },
  State_133999_Desc = {
    Text = "Jede Stapelung erhöht den Gesamtschaden dieser Karte, den festen <PowerIconKeywords:STR>- & <TentacleInjurieIconKeywords:Tentakelschaden>-Gewinn, das feste <IntoxicationIconKeywords:Gift> & den festen <RetaliateIconKeywords:Gegenangriff> um 2 % sowie den finalen festen Rollen-Schild, die feste LP-Wiederherstellung und <ExhaustionIconKeywords:STR▼> um 1 %. Wird beim Spielen oder am Ende des Zuges aufgehoben."
  },
  State_133999_Name = {
    Text = "<TempPowerKeywords:Temporäre Verstärkung>"
  },
  State_134100_Desc = {
    Text = "Wenn in diesem Kampf tödlicher Schaden erlitten wird, wiederbeleben, [Layer] LP wiederherstellen und allen Erweckten Körpern [StateArg1] Aliemus und [DescArg1] Temporären Tentakelschaden gewähren. Kann nicht aufgehoben werden."
  },
  State_134100_Name = {
    Text = "Unsterblicher Paradiesvogel"
  },
  State_134191_Desc = {
    Text = "Team Unique: Nach Beginn der Erkundung mische 1 „Private Mittagspause\" in den Ziehstapel. „Private Mittagspause\": verbraucht 1 Arithmetica. Temporärer Kritischer Schaden +<WeaponEffect_Num:[StateArg1]%>. <RetainIconKeywords:Behalten>. <DepleteIconKeywords:Verbrauch>."
  },
  State_134191_WeaponDesc = {
    Text = "Nach Beginn der Erkundung mische 1 „Private Mittagspause\" in den Ziehstapel. „Private Mittagspause\": verbraucht 1 Arithmetica. Temporärer Kritischer Schaden +<WeaponEffect_Num:[StateArg1]%>. <RetainIconKeywords:Behalten>. <DepleteIconKeywords:Verbrauch>."
  },
  State_134195_Desc = {
    Text = "Die Stapel von fester Vergiftung, festem Konter und festem Schicksalsurteil dieser Karte werden erhöht, unabhängig multipliziert mit 1+[Layer]%."
  },
  State_134195_Name = {
    Text = "Dreiphasenkraft α1"
  },
  State_134196_Desc = {
    Text = "Die Stapel von fester Vergiftung, festem Konter und festem Schicksalsurteil der Befehlskarten dieses Erweckungskörpers werden erhöht, unabhängig multipliziert mit 1+[StateArg1]%."
  },
  State_134196_Name = {
    Text = "Dreiphasenkraft β3"
  },
  State_134197_Desc = {
    Text = "Die Stapel von fester Vergiftung, festem Konter und festem Schicksalsurteil dieser Karte werden erhöht, unabhängig multipliziert mit 1+[StateArg1]%."
  },
  State_134197_Name = {
    Text = "Dreiphasenkraft β1"
  },
  State_134198_Desc = {
    Text = "Die Stapel von fester Vergiftung, festem Konter und festem Schicksalsurteil der Befehlskarten dieses Erweckungskörpers werden erhöht, unabhängig multipliziert mit 1+[Layer]%."
  },
  State_134198_Name = {
    Text = "Dreiphasenkraft α3"
  },
  State_134199_Desc = {
    Text = "Die Stapel von fester Vergiftung, festem Konter und festem Schicksalsurteil des Raserei-Ausbruchs dieses Erweckungskörpers werden erhöht, unabhängig multipliziert mit 1+[StateArg1]%."
  },
  State_134199_Name = {
    Text = "Dreiphasenkraft β2"
  },
  State_134200_Desc = {
    Text = "Die Stapel von fester Vergiftung, festem Konter und festem Schicksalsurteil des Raserei-Ausbruchs dieses Erweckungskörpers werden erhöht, unabhängig multipliziert mit 1+[Layer]%."
  },
  State_134200_Name = {
    Text = "Dreiphasenkraft α2"
  },
  State_134227_Desc = {
    Text = "Die Schicksals-Weberin zieht ihre Fäden. Maximal [DescArg1] Stapelungen, bleiben über Kämpfe hinweg bestehen und können durch Verherrlichung verbraucht werden, um Verfolgung: „Endlose Fäden„ auszulösen."
  },
  State_134227_Name = {
    Text = "<SilkKeywords:Weberin>"
  },
  State_134231_Desc = {
    Text = "Team Unique: Vom Ausrüster generiertes Rollen-Schild +<WeaponEffect_Num:[StateArg1] %>, und wenn der Ausrüster „Verfolgung \" einsetzt, Temporäre Amplifikation +<WeaponEffect_Num:[StateArg2] %>, bis zu 5-mal pro Runde. Immer wenn „Dimensionsgleiter\" ausgelöst wird, erhält der Ausrüster <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_134231_WeaponDesc = {
    Text = "Vom Ausrüster generiertes Rollen-Schild +<WeaponEffect_Num:[StateArg1] %>, und wenn der Ausrüster „Verfolgung \" einsetzt, Temporäre Amplifikation +<WeaponEffect_Num:[StateArg2] %>, bis zu 5-mal pro Runde. Immer wenn „Dimensionsgleiter\" ausgelöst wird, erhält der Ausrüster <WeaponEffect_Num:[StateArg3]> Aliemus."
  },
  State_134237_Desc = {
    Text = "Die Schicksalsweberin zieht ihre Fäden. Maximal [DescArg1] Stapelungen, über den Kampf hinweg vererbt, kann durch Verherrlichung zur Freigabe von Verfolgung: „<DerivativeCardKeywords_144:Endlose Fäden>„ verwendet werden."
  },
  State_134237_Name = {Text = "Weberin"},
  State_134240_Desc = {
    Text = "In den nächsten [Layer] „Ewiger Webstuhl\" werden zusätzliche „Leitende Fäden\" in den Ziehstapel und Ablagestapel gelegt."
  },
  State_134240_Name = {
    Text = "Schicksalsnetz"
  },
  State_134261_Desc = {
    Text = "Der Schaden der nächsten [Layer] Treffer wird verdoppelt."
  },
  State_134261_Name = {
    Text = "Private Mittagspause"
  },
  State_134262_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Nach einem „Wahnsinnsausbruch\" wird der nächste verursachte Schaden verdoppelt."
  },
  State_134262_Name = {
    Text = "Private Mittagspause"
  },
  State_134285_Desc = {
    Text = "Wenn die LP des Ziels gleich oder unter der Anzahl der Stapelungen liegen, entferne alle Endgültiges Urteil und töte es sofort."
  },
  State_134285_Name = {
    Text = "Schicksalsurteil"
  },
  State_134313_Desc = {
    Text = "Team Unique: Der Schutzschild des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>. Bei der Verfolgung des Ausrüsters + <WeaponEffect_Num:[StateArg2]%> vorübergehende Amplifikation, maximal 5 Mal pro Runde aktiv."
  },
  State_134313_WeaponDesc = {
    Text = "Vom Ausrüster generiertes Rollen-Schild +<WeaponEffect_Num:[StateArg1] %>, und wenn der Ausrüster „Verfolgung \" einsetzt, Temporäre Amplifikation +<WeaponEffect_Num:[StateArg2] %>, bis zu 5-mal pro Runde."
  },
  State_134384_Desc = {
    Text = "Die nächsten [Layer] <plural value=\"[Layer]\" singular=\"Befehlskarte\" plural=\"Befehlskarten\">, die gespielt werden, lösen „Dimensionsgleiter\" aus."
  },
  State_134384_Name = {
    Text = "Dimensionsgleiter"
  },
  State_134389_Desc = {
    Text = "Gesamtschaden, fester <PowerIconKeywords:STR>- & <TentacleInjurieIconKeywords:Tentakelschaden>-Gewinn, festes <IntoxicationIconKeywords:Gift> & fester <RetaliateIconKeywords:Gegenangriff> dieser Karte jeweils +[DescArg1]%; Finaler fester Rollen-Schild, feste LP-Wiederherstellung und <ExhaustionIconKeywords:STR▼> dieser Karte jeweils +[DescArg2]%. Karten mit „Singularitätslaterne“ können keinen „Dimensionsgleiter“ auslösen."
  },
  State_134389_Name = {
    Text = "<SingularityKeywords:Singularitätslaterne [DescArg2]>"
  },
  State_134391_Desc = {
    Text = "Jede Runde, nachdem die erste Befehlskarte gespielt wurde, wird dieser Effekt ausgelöst: Die Temporäre Basiskopie der gespielten Befehlskarte wird in den Hyperraum gelegt. Dieser Effekt kann nicht während Ultra-Runden ausgelöst werden."
  },
  State_134391_Name = {
    Text = "<SingularityKeywords3:Dimensions-Shuttle>"
  },
  State_135232_Name = {
    Text = "<SingularityKeywords:Singularitäts-Verzerrung>: Für den Rest dieses Zuges, wenn ein anderer Erwecker eine Befehlskarte spielt, verbrauche 1 <SilkKeywords:Weberin>, um Verfolgung auszulösen: <DerivativeCardKeywords_137:„Unendliche Fäden\">"
  },
  State_135233_Name = {
    Text = "<SingularityKeywords:Singularitäts-Verzerrung>: Für den Rest dieses Zuges, wenn ein anderer Erwecker eine Befehlskarte spielt, verbrauche 1 <SilkKeywords:Weberin>, um Verfolgung auszulösen: <DerivativeCardKeywords_137:„Unendliche Fäden\">"
  },
  State_135919_Name = {
    Text = "<SingularityKeywords:Singularitäts-Verzerrung>: Für den Rest dieses Zuges, wenn ein anderer Erwecker eine Befehlskarte spielt, verbrauche 1 <SilkKeywords:Weberin>, um Verfolgung auszulösen: <DerivativeCardKeywords_137:„Unendliche Fäden\">"
  },
  State_135920_Name = {
    Text = "<SingularityKeywords:Singularitäts-Verzerrung>: Für den Rest dieses Zuges, wenn ein anderer Erwecker eine Befehlskarte spielt, verbrauche 1 <SilkKeywords:Weberin>, um Verfolgung auszulösen: <DerivativeCardKeywords_137:„Unendliche Fäden\">"
  },
  State_135921_Desc = {
    Text = "Schaden des Erweckungskörpers um 25% erhöht"
  },
  State_135921_Name = {
    Text = "<CardKeyWord:Züchtige, um eine Blutschuld zu begleichen>"
  },
  State_138824_Desc = {
    Text = "Strahlendes Leben preist die Freiheit und singt Triumphlieder – kann durch Shayes Verherrlichung verbraucht werden, um deren Effekt zu verstärken. Dieser Zustand stapelt sich auf maximal 4 Lagen und bleibt nach dem Kampf erhalten."
  },
  State_138824_Name = {
    Text = "<KaiHuajishu1:Gynoecium>"
  },
  State_139039_Desc = {
    Text = "Der finale Effekt der nächsten Verherrlichung dieses Erweckers in dieser Runde – einschließlich Schaden, festes Schild, feste LP-Heilung, feste Stärke, STR▼, Tentakelschaden erhöht, festes Gift und fester Konter – wird um [Layer]% erhöht."
  },
  State_139039_Name = {
    Text = "<BreedingKeywords2:Ausbreitungsfiesta>"
  },
  State_139687_Desc = {
    Text = "Strahlendes Leben preist die Freiheit und singt Triumphlieder – kann durch Shayes Verherrlichung verbraucht werden, um deren Effekt zu verstärken. Dieser Zustand stapelt sich auf maximal 4 Lagen und bleibt nach dem Kampf erhalten."
  },
  State_139687_Name = {
    Text = "<KaiHuajishu:Gynoecium>"
  },
  State_139688_Desc = {
    Text = "Team Unique: Arithmetica-Grenze +1, Effekte desselben Typs können nicht gestapelt werden.\nFür je 10 Basis-Aliemus des Ausrüsters verursacht dieser +<WeaponEffect_Num:[StateArg1]%> <Corrosion:Korrosion>-Stapelungen und bewirkt +<WeaponEffect_Num:[Float:StateArg2]％> Embryofusion."
  },
  State_139688_WeaponDesc = {
    Text = "Arithmetica-Grenze +1, Effekte desselben Typs können nicht gestapelt werden.\nFür je 10 Basis-Aliemus des Ausrüsters verursacht dieser +<WeaponEffect_Num:[StateArg1]%> Feste <Corrosion:Korrosion>-Stapelungen und bewirkt +<WeaponEffect_Num:[Float:StateArg2]%> Embryofusion."
  },
  State_139689_Desc = {
    Text = "Team Unique: Nach dem Einsatz von „Blutroter Ofen“ erhält der Ausrüster Aliemus in Höhe von <WeaponEffect_Num:[StateArg1]%> des Basis-Aliemus. 3 Züge Abklingzeit."
  },
  State_139689_WeaponDesc = {
    Text = "Nach der Verwendung des „Blutroten Ofens \" erhält der Ausrüster <WeaponEffect_Num:[StateArg1] %> Basis-Aliemus als Aliemus, 3 Runden Abklingzeit."
  },
  State_139977_Desc = {
    Text = "Wenn du in diesem Zug „Schlag \" spielst, verursacht „Schlag\"+[DescArg1] % Schaden mit Durchstechen; andernfalls erhältst du am Zugende +[Layer] Barriere."
  },
  State_139977_Name = {
    Text = "Sternenbestie"
  },
  State_140063_Desc = {
    Text = "Dies ist eine „Schuldverschreibung“, die für die Ausleihe von Arithmetica in der nächsten Runde erstellt wurde und [Layer] Arithmetica nach Beginn der nächsten Runde abgezogen wird; nicht zerstreutbar."
  },
  State_140063_Name = {
    Text = "In den roten Zahlen"
  },
  State_140068_Desc = {
    Text = "Die nächste(n) [DescArg1] „Fähigkeit\"-Karte(n) koste(n) – [StateArg1] Arithmetica."
  },
  State_140068_Name = {
    Text = "Offenbarung"
  },
  State_140135_Desc = {
    Text = "Pro Stapel wird der finale Effekt der nächsten Verherrlichung dieses Erweckers in dieser Runde – einschließlich Schaden, festes Schild, feste LP-Heilung, feste Stärke, STR▼, Tentakelschaden erhöht, festes Gift und fester Konter – um 1% erhöht."
  },
  State_140135_Name = {
    Text = "<BreedingKeywords2:Ausbreitungsfiesta>"
  },
  State_140186_WeaponDesc = {
    Text = "Alle Schadensinstanzen des Wal-Sprungs +1"
  },
  State_140454_Desc = {
    Text = "Team-Einzigartig: Für jedes 1% Schwarzsiegel-Verlust des Trägers selbst, des Schicksalsrads und des Pakts werden nach Kampfende <WeaponEffect_Num:[StateArg1] %> der max. LP wiederhergestellt. Am Ende jeder Runde verringert sich dieser Wiederherstellungseffekt um 30%, wobei mehrere Instanzen unabhängig berechnet werden. Nach dem Einsetzen von „Wahrnehmung \" in den „Ascheruinen\" erfordert die Aktualisierung der aktuellen „Ascheruinen \" keinen Schwarzsiegel-Verbrauch."
  },
  State_140454_WeaponDesc = {
    Text = "Für jedes 1% Siegelertrag des Ausrüsters, seiner WoDs und Bündnisse werden nach Kampfende <WeaponEffect_Num:[DescArg2] %> der Max LP([DescArg1]) wiederhergestellt. Am Ende jeder Runde verringert sich dieser Wiederherstellungseffekt um 30%, und wird für jeden Kampf einzeln berechnet.\nNach dem Einsetzen von „Induktion \" in den „Asche der Ruinen\" sind Aktualisierungen in diesen „Asche der Ruinen \" kostenlos."
  },
  State_140456_WeaponDesc = {
    Text = "Nach dem Ausspielen wird sie dauerhaft entfernt"
  },
  State_140458_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Wenn du „Verherrlichung\" mit einem beliebigen Erwecker ausrüstest, erhältst du <Block:[Block:StateArg1]> Schild."
  },
  State_140458_Name = {
    Text = "Ex Stellaris"
  },
  State_140489_Desc = {
    Text = "Erhält eine entsprechende Menge an max. LP. Die Stapelanzahl kann die anfänglichen max. LP des Erwachten nicht überschreiten."
  },
  State_140489_Name = {Text = "Gynoecium"},
  State_140490_Desc = {
    Text = "Erhält eine entsprechende Menge an max. LP. Die Stapelanzahl kann die anfänglichen max. LP [DescArg1] dieses Erwachten nicht überschreiten."
  },
  State_140490_Name = {Text = "Gynoecium"},
  State_140495_Desc = {
    Text = "Die Arithmetica-Kosten der nächsten „Fähigkeit \" - [Layer]."
  },
  State_140495_Name = {
    Text = "Umschreiben"
  },
  State_140517_Desc = {
    Text = "Die Arithmetica-Kosten der nächsten „Fähigkeit\" – [DescArg1]."
  },
  State_140517_Name = {
    Text = "Umschreiben"
  },
  State_140547_Desc = {
    Text = "Dieser Effekt kann die Embryo-Fusion um maximal + 100 erhöhen und wird nicht durch Effekte zur Erhöhung der Embryo-Fusion verstärkt."
  },
  State_140547_Name = {
    Text = "Embryofusion Doppelt"
  },
  State_140645_Desc = {
    Text = "Wartemodus-Spezialeffekt"
  },
  State_140645_Name = {
    Text = "Wartemodus-Spezialeffekt"
  },
  State_140647_Name = {
    Text = "Kognitive Dissonanz-Abhörung ausgespielt"
  },
  State_140648_Name = {
    Text = "Spieler besitzt Kognitive Dissonanz-Zähler"
  },
  State_140650_Desc = {
    Text = "Die ersten 3 Mal pro Zug, wenn du eine Befehlskarte mit „Wahrnehmungsverzerrung\" spielst, erhält Shaye [Layer] Aliemus."
  },
  State_140650_Name = {
    Text = "Shaye Erwecken"
  },
  State_140651_Desc = {
    Text = "Wartemodus-Spezialeffekt"
  },
  State_140651_Name = {
    Text = "Wartemodus-Spezialeffekt"
  },
  State_140653_Desc = {
    Text = "Die Arithmetica-Kosten dieser Karte haben eine Chance von 10% auf -2, 25% auf -1, 30% unverändert, 25% auf +1 und 10% auf +2. Nach dem Spielen oder Ablegen wird dieser Zustand entfernt."
  },
  State_140653_Name = {
    Text = "<ExclamationPointColour:Farbe>"
  },
  State_140654_Desc = {
    Text = "Wartemodus-Spezialeffekt"
  },
  State_140654_Name = {
    Text = "Wartemodus-Spezialeffekt"
  },
  State_140655_Desc = {
    Text = "Diese Karte ist durch Auflösung verdeckt und ihr Text kann nicht eingesehen werden. Die Arithmetica-Kosten haben eine Chance von 10% auf -2, 25% auf -1, 30% unverändert, 25% auf +1 und 10% auf +2. Nach dem Spielen oder Ablegen wird dieser Zustand entfernt."
  },
  State_140655_Name = {
    Text = "<ErosionColorInkKeywords:Fusionsfarbe>"
  },
  State_140656_Desc = {
    Text = "Die Arithmetica-Kosten dieser Karte haben eine Chance von 10% auf -2, 25% auf -1, 30% unverändert, 25% auf +1 und 10% auf +2. Nach dem Spielen oder Ablegen wird dieser Zustand entfernt."
  },
  State_140656_Name = {
    Text = "<ColorInkKeywords:Farbe>"
  },
  State_140657_Desc = {
    Text = "Diese Karte ist durch Auflösung verdeckt und ihr Text kann nicht eingesehen werden. Die Arithmetica-Kosten haben eine Chance von 10% auf -2, 25% auf -1, 30% unverändert, 25% auf +1 und 10% auf +2. Nach dem Spielen oder Ablegen wird dieser Zustand entfernt."
  },
  State_140657_Name = {
    Text = "<ExclamationPointColour:Fusionsfarbe>"
  },
  State_140658_Name = {
    Text = "Spieler besitzt Kognitive Dissonanz-Abhörung"
  },
  State_140659_Desc = {
    Text = "Wartemodus-Spezialeffekt"
  },
  State_140659_Name = {
    Text = "Wartemodus-Spezialeffekt"
  },
  State_140662_Desc = {
    Text = "Zu Beginn jedes Zuges wird „Wahrnehmungsverzerrung\" zufällig auf 2 Befehlskarten angewendet, die keine „Wahrnehmungsverzerrung\" haben."
  },
  State_140662_Name = {
    Text = "Lebensformrekonstruktion"
  },
  State_140672_Desc = {
    Text = "Dieser Erwecker verfällt in Chaos, was den verursachten Schaden, die LP-Wiederherstellung und den Rollen-Schild um zufällige 15 %～35 % reduziert. Kann nicht aufgehoben werden."
  },
  State_140672_Name = {
    Text = "<PVPCognitiveDissonanceKeyWords:Wahrnehmungsverzerrung>"
  },
  State_140673_Desc = {
    Text = "Dieser Erwecker verfällt in Chaos, was den verursachten Schaden, die LP-Wiederherstellung und den Rollen-Schild um zufällige 15 %～35 % reduziert. Kann nicht aufgehoben werden."
  },
  State_140673_Name = {
    Text = "Wahrnehmungsverzerrung"
  },
  State_140683_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Beim Ausrüsten werden [StateArg1] <MaxHPKeywords:Max LP> erhalten, am Rundenende wird <Heal:[Heal:DescArg1]> LP wiederhergestellt. Die LP-Wiederherstellung steigt, je niedriger die LP des Ausrüsters sind, maximal um [StateArg3]%."
  },
  State_140683_Name = {
    Text = "Lily im Wunderland"
  },
  State_140724_Name = {Text = "Fressen"},
  State_140726_Desc = {
    Text = "Der Endeffekt von Schaden, Stärke, Tentakelschaden, festem Gift, festem Konter, Schild, Lebensregeneration und Stärkereduzierung dieser Karte wird um [DescArg1]% reduziert."
  },
  State_140726_Name = {
    Text = "<AdaptKeywords1:Anpassung [DescArg1]>"
  },
  State_140727_Desc = {
    Text = "Wenn Hunger 5 Stapel erreicht, werden nach Rundenende alle Hunger-Stapel verbraucht, die Absicht wechselt zu einem starken Angriff und es werden [DescArg1] Punkte Stärke gewonnen."
  },
  State_140727_Name = {Text = "Hunger"},
  State_140728_Desc = {
    Text = "Zu Beginn jeder Runde wird 1 Stapelung Hunger erhalten. Beim Verursachen von unblockiertem Schaden wird ein Schild in Höhe von 2% ([DescArg1]) der maximalen LP gewonnen. Die maximale Stapelanzahl von Anpassung erhöht sich auf 75."
  },
  State_140728_Name = {
    Text = "Futterschutz"
  },
  State_140730_Desc = {
    Text = "Nach dem Spielen einer Befehlskarte werden allen Karten des zugehörigen Erweckers an allen Orten 10 Stapelungen <AdaptKeywords:Anpassung> auferlegt, während die Karten anderer Erwecker 5 Stapelungen <AdaptKeywords:Anpassung> verlieren. Jede Stapelung <AdaptKeywords:Anpassung> reduziert den Endeffekt von Schaden, Stärke, Tentakelschaden, festem Gift, festem Konter, Schild, LP-Heilung und STR▼ der Karte um 1%, maximal [DescArg1] Stapelungen."
  },
  State_140730_Name = {Text = "Mimikry"},
  State_140838_Desc = {
    Text = "Der in dieser Runde verursachte Schaden wird um [Layer]% verringert."
  },
  State_140838_Name = {
    Text = "Sonnenverdeckende Schattenmauer"
  },
  State_140839_Desc = {
    Text = "Der Gesamtschaden aller Erwecker wird in dieser Runde um [Layer]% erhöht."
  },
  State_140839_Name = {
    Text = "Begleitende Jagdgefolgschaft"
  },
  State_140856_Desc = {
    Text = "Der Erwecker kann nicht handeln. Am Ende der Runde wird 1 Stapel Bewusstseinsstörung entfernt. Nachdem alle Stapel entfernt wurden, gilt die nächste Verherrlichung dieses Erweckers als Übererhöhung. Falls bereits eine Übererhöhung ausgelöst wurde, werden 100% Basis-Aliemus zurückerstattet."
  },
  State_140856_Name = {
    Text = "<Yishiganshe:Bewusstseinsinterferenz>"
  },
  State_140860_Desc = {
    Text = "Der Erwecker kann nicht handeln. Am Ende der Runde wird 1 Stapel Bewusstseinsstörung entfernt. Nachdem alle Stapel entfernt wurden, gilt die nächste Verherrlichung dieses Erweckers als Übererhöhung. Falls bereits eine Übererhöhung ausgelöst wurde, werden 100% Basis-Aliemus zurückerstattet."
  },
  State_140860_Name = {
    Text = "<Yishiganshe:Bewusstseinsinterferenz>"
  },
  State_140861_Desc = {
    Text = "Die nächste Verherrlichung gilt als Übererhöhung. Falls bereits eine Übererhöhung ausgelöst wurde, werden 100% Basis-Aliemus zurückerstattet."
  },
  State_140861_Name = {
    Text = "Lily im Wunderland"
  },
  State_140873_Desc = {
    Text = "Jede Stapelung reduziert den Endeffekt von Schaden, Stärke, Tentakelschaden, festem Gift, festem Konter, Schild, LP-Heilung und STR▼ dieser Karte um 1%, maximal [DescArg1] Stapelungen."
  },
  State_140873_Name = {
    Text = "<AdaptKeywords:Anpassung>"
  },
  State_140877_Name = {
    Text = "Zusätzlich [DescArg1] Mal wirksam"
  },
  State_141468_Desc = {
    Text = "Wenn Hunger 5 Stapel erreicht, werden nach Rundenende alle Hunger-Stapel verbraucht, die Absicht wird auf starken Angriff umgestellt und Stärke wird gewährt."
  },
  State_141468_Name = {
    Text = "<HungerKeywords:Hunger>"
  },
  State_141504_Desc = {
    Text = "Es können maximal 3 Trümmer angesammelt werden. Wird das Limit erreicht, kann die nächste „Nekrotische Gala\" sie verzehren und ihren Effekt verstärken. Die Trümmer werden in den nächsten Kampf übernommen."
  },
  State_141504_Name = {Text = "Trümmer"},
  State_141950_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Beim Ausrüsten und am Rundenende <PVPDiscoveryKeyWords:Entdecken> von [StateArg1] „Fähigkeit\"-Karten mit <PVPVoidKeywords:Nichtigkeit> und in die Hand legen."
  },
  State_141950_Name = {
    Text = "Aufstieg in den Abgrund"
  },
  State_141988_Desc = {
    Text = "Schaden, Schild und Heilung dieser Karte sowie aufgelegte Stärke, Berauben, Tentakelschaden, Gift, Konter, Endgültiges Urteil, festes Gift, fester Konter und festes Endgültiges Urteil werden um [Layer]% erhöht."
  },
  State_141988_Name = {
    Text = "Schillernde Karte"
  },
  State_141989_Desc = {
    Text = "Erstellt zufällige Karten."
  },
  State_141989_Name = {
    Text = "<CardKeyWord:Entdecken>"
  },
  State_141991_Desc = {
    Text = "Schaden, Schild und Heilung der Verherrlichung dieses Erweckers sowie aufgelegte Stärke, Berauben, Tentakelschaden, Gift, Konter, Endgültiges Urteil, festes Gift, fester Konter und festes Endgültiges Urteil werden um [Layer]% erhöht."
  },
  State_141991_Name = {
    Text = "Schillernde Verherrlichung"
  },
  State_141992_Desc = {
    Text = "Schaden, Schild und Heilung der Karten dieses Erweckers sowie aufgelegte Stärke, Berauben, Tentakelschaden, Gift, Konter, Endgültiges Urteil, festes Gift, fester Konter und festes Endgültiges Urteil werden um [Layer]% erhöht."
  },
  State_141992_Name = {
    Text = "Schillernde Karte"
  },
  State_141993_Desc = {
    Text = "Schaden, Schild und Heilung der Befehlskarten dieses Erweckers sowie aufgelegte Stärke, Berauben, Tentakelschaden, Gift, Konter, Endgültiges Urteil, festes Gift, fester Konter und festes Endgültiges Urteil werden um [Layer]% erhöht."
  },
  State_141993_Name = {
    Text = "Schillernde Befehlskarte"
  },
  State_141994_Desc = {
    Text = "Nach dem Spielen einer Karte, nach dem Auslösen einer Verherrlichung verursachter Schaden, Erhalten von Schild, Heilung, Anwenden von Stärke, Berauben, Tentakelschaden, Gift, Konter, Endgültiges Urteil, fixiertem Gift, fixiertem Konter, fixiertem Endgültigem Urteil."
  },
  State_141994_Name = {
    Text = "Schillernder Auslösebefehl"
  },
  State_142018_Desc = {
    Text = "Zu Beginn der Runde erhältst du 1 Schicht <Guaiwucanhai:Trümmer>"
  },
  State_142018_Name = {
    Text = "Blutrote Einladung"
  },
  State_142057_Desc = {
    Text = "Nach dem Einsatz einer Posse wird die eigene Absicht gewechselt. Nach Kampfbeginn wird das Keyflare-Regenerationslevel aller Erwecker um 25% erhöht."
  },
  State_142057_Name = {
    Text = "Offenbarung von Ursache und Wirkung"
  },
  State_142058_Desc = {
    Text = "Verursachter Grundschaden, Gift und Gegenangriff werden um [DescArg1]% verringert."
  },
  State_142058_Name = {
    Text = "Unreiner Flügel"
  },
  State_142060_Desc = {
    Text = "Jedes Mal, wenn der Feind eine Befehlskarte verwendet, erhält er selbst 1 Stapel vorübergehenden Wahnsinn. Erreicht der vorübergehende Wahnsinn 10 Stapel, handelt er nach dem nächsten Ausspielen einer Befehlskarte sofort und entfernt allen vorübergehenden Wahnsinn."
  },
  State_142060_Name = {Text = "Abyssecho"},
  State_142062_Desc = {
    Text = "Der Anfangseffekt von 0246 ist jedes Mal zufällig."
  },
  State_142062_Name = {
    Text = "Zufällige Absicht"
  },
  State_142063_Desc = {
    Text = "Während des eigenen Zuges wird erlittener Schaden um [DescArg1]% verringert."
  },
  State_142063_Name = {
    Text = "Heiliger Flügel"
  },
  State_142065_Desc = {
    Text = "Wird zu Beginn des Zuges entfernt. Erreicht 10 Stapel: Nach dem nächsten Ausspielen einer Befehlskarte handelt man sofort und entfernt allen vorübergehenden Wahnsinn."
  },
  State_142065_Name = {
    Text = "Vorübergehender Wahnsinn"
  },
  State_142066_Desc = {
    Text = "Schwäche-, Zerbrechlich- und Verderbenseffekte auf 50 % erhöht."
  },
  State_142066_Name = {
    Text = "Wesenseinblick"
  },
  State_142067_Desc = {
    Text = "Verursachter Stärke-, Gegenangriff- und Tentakelschaden wird um [DescArg1]% verringert."
  },
  State_142067_Name = {
    Text = "Verfluchter Flügel"
  },
  State_142072_Desc = {
    Text = "Jeder erlittene Schaden oder Verlust von LP darf 5% der maximalen Gesundheit nicht überschreiten."
  },
  State_142072_Name = {
    Text = "Schmerzschwelle"
  },
  State_142091_Desc = {
    Text = "Sechsflügel-Verdopplungszähler"
  },
  State_142091_Name = {
    Text = "Sechsflügel-Verdopplungszähler"
  },
  State_142092_Desc = {
    Text = "Das Keyflare-Regenerationslevel aller Erwecker wird um 25% erhöht."
  },
  State_142092_Name = {
    Text = "Offenbarung von Ursache und Wirkung"
  },
  State_142093_Desc = {
    Text = "Sechsflügel-Verdopplung Verbrauchsfortschritt: [DescArg1], aktuell benötigter Schadenswert: [DescArg2]."
  },
  State_142093_Name = {
    Text = "Sechsflügel-Verdopplung"
  },
  State_142095_Desc = {
    Text = "Sechsflügel-Verdopplungsmarkierung"
  },
  State_142095_Name = {
    Text = "Sechsflügel-Verdopplungsmarkierung"
  },
  State_142166_Desc = {
    Text = "Siehe die allgemeine Streiklogik für spezifische Effekte. __ \"Nur für Entwicklungszwecke\""
  },
  State_142213_Name = {
    Text = "Senke das Rechenleistungslimit"
  },
  State_142215_Desc = {
    Text = "Wenn das Ziel zu Beginn der nächsten Runde noch immer tot ist, wird es wiederbelebt und erhält [StateArg1] Schild. Kann nicht vertrieben werden."
  },
  State_142215_Name = {
    Text = "Ewige Besessenheit"
  },
  State_142228_Desc = {
    Text = "Diese Karte wurde vom Schicksrad „Aufstieg in den Abgrund\" erschaffen."
  },
  State_142228_Name = {
    Text = "Aufstieg in den Abgrund"
  },
  State_142229_Desc = {
    Text = "Team Unique: Nach Beginn der Erkundung wird 1 „Lily im Wunderland„-Karte dem Kartenstapel hinzugefügt. „Lily im Wunderland„: Verbrauche 2 Punkte Arithmetica, damit der Ausrüster <WeaponEffect_Num:[StateArg1]> Punkte Aliemus und 3 Stapelungen <Yishiganshe:„Bewusstseinsstörung\"> erhält. <RetainIconKeywords:Behalten>. <DepleteIconKeywords:Verbrauchen>."
  },
  State_142229_Name = {
    Text = "Lily im Wunderland"
  },
  State_142229_WeaponDesc = {
    Text = "Nach Beginn der Erkundung wird 1 „Lily im Wunderland„-Karte dem Kartenstapel hinzugefügt. „Lily im Wunderland„: Verbrauche 2 Punkte Arithmetica, damit der Ausrüster <WeaponEffect_Num:[StateArg1]> Punkte Aliemus und <Yishiganshe:„Bewusstseinsstörung\"> erhält. <RetainIconKeywords:Behalten>. <DepleteIconKeywords:Verbrauchen>."
  },
  State_142452_Desc = {
    Text = "Erlittene STR▼-Effekte werden um 50 % reduziert."
  },
  State_142452_Name = {
    Text = "Unsterbliche Existenz"
  },
  State_142663_Desc = {
    Text = "Zu Beginn der nächsten Runde erhältst du <DelayKeywords:Latenz>: [Layer] Aliemus."
  },
  State_142663_Name = {
    Text = "Verzögerter Verzögerter Wahnsinn"
  },
  State_142688_Desc = {
    Text = "Das ausgerüstete Schicksrad des Ziels wird deaktiviert. Kann nicht vertrieben werden."
  },
  State_142688_Name = {
    Text = "Super-Umschlingen"
  },
  State_142692_Desc = {
    Text = "Ein neuer kleiner Einfall ist gerade im Entstehen."
  },
  State_142692_Name = {
    Text = "Geistesblitz"
  },
  State_142715_Desc = {
    Text = "Der Schaden dieser „Fähigkeit \" wird um [DescArg1] % erhöht, für jeden Punkt Arithmetica, den diese Fähigkeit benötigt, erhöht sich der Schaden um [StateArg1] %."
  },
  State_142715_Name = {
    Text = "Bernsteinfarbener Tod"
  },
  State_142887_Desc = {
    Text = "Wenn das Ziel in dieser Runde erneut „Paralyse\" erleidet, werden alle seine „Schläge\" zu „Illusionen\", können nicht vertrieben werden und halten bis zum Ende der Runde an."
  },
  State_142887_Name = {
    Text = "Etwas gelähmt"
  },
  State_142954_Desc = {
    Text = "Die Arithmetica-Grenze beträgt mindestens 0 und wächst zu Beginn jeder Runde um 1, wenn sie unter 10 liegt. Sobald sie 10 erreicht hat, wird jede weitere Arithmetica-Grenze in das Ziehen einer entsprechenden Anzahl von Karten umgewandelt."
  },
  State_142954_Name = {
    Text = "Arithmetica-Grenze"
  },
  State_143002_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nicht konfiguriert"
  },
  State_143002_Name = {
    Text = "Sattogua SR (Vorübergehender Text)"
  },
  State_143004_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nicht konfiguriert"
  },
  State_143004_Name = {
    Text = "Satogua-Spezialwaffe (Temporärer Text)"
  },
  State_143005_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nicht konfiguriert"
  },
  State_143005_Name = {
    Text = "Lantigos SR (Vorübergehender Text)"
  },
  State_143006_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nicht konfiguriert"
  },
  State_143006_Name = {
    Text = "Schwarzer Pharao-Spezialwaffe (Temporärer Text)"
  },
  State_143007_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Wenn ausgerüstet und zu Rundenbeginn, wende [StateArg1] <plural value=\"[StateArg1]\" singular=\"Stapelung\" plural=\"Stapelungen\"> von <PVPCompassKeywords:Kompass auf den falschen Norden> auf einen zufälligen Feind an."
  },
  State_143007_Name = {
    Text = "Der irrende Kompass"
  },
  State_143008_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nicht konfiguriert"
  },
  State_143008_Name = {
    Text = "Shatak-Vogel-Spezialwaffe (Temporärer Text)"
  },
  State_143009_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nicht konfiguriert"
  },
  State_143009_Name = {
    Text = "Aphogmon-Spezialwaffe (Temporärer Text)"
  },
  State_143010_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Handlimit +[StateArg1], wenn der Ausrüster oder ein Verbündeter stirbt, verwandeln sich ihre Karten nicht mehr in <PVPDerivativeCardKeywords_2:„Traum\">, sondern in <PVPDerivativeCardKeywords_30:„Häschergaunt\">."
  },
  State_143010_Name = {
    Text = "Lebender Käfig"
  },
  State_143011_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nicht konfiguriert"
  },
  State_143011_Name = {
    Text = "Geier SR (Vorübergehender Text)"
  },
  State_143012_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nicht konfiguriert"
  },
  State_143012_Name = {
    Text = "Shatako-Vogel SR (Vorübergehender Text)"
  },
  State_143013_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nicht konfiguriert"
  },
  State_143013_Name = {
    Text = "Genesis-Ogier SR (Vorübergehender Text)"
  },
  State_143014_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Vor der „Verherrlichung\" verliert man 25% der aktuellen LP; nach der „Verherrlichung\" verursacht man [StateArg1] Schaden an allen Gegnern und absaugt die gleiche Menge LP."
  },
  State_143014_Name = {
    Text = "Honigsüße Täuschung"
  },
  State_143016_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nicht konfiguriert"
  },
  State_143016_Name = {
    Text = "Schwarzer Pharao SR (Vorübergehender Text)"
  },
  State_143017_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nicht konfiguriert"
  },
  State_143017_Name = {
    Text = "Lantigos-Spezialwaffe (Temporärer Text)"
  },
  State_143018_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nicht konfiguriert"
  },
  State_143018_Name = {
    Text = "Ursymbol Tulu SR (Vorübergehender Text)"
  },
  State_143019_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nach „Verherrlichung\" werden allen Feinden [StateArg1] Stapel <PVPBless:Segen> auferlegt."
  },
  State_143019_Name = {
    Text = "Die angenehme Wahrheit"
  },
  State_143020_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nicht konfiguriert"
  },
  State_143020_Name = {
    Text = "Ursprung Ogier-Exklusivwaffe (Temporärer Text)"
  },
  State_143022_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nicht konfiguriert"
  },
  State_143022_Name = {
    Text = "Geier-Spezialwaffe (Temporärer Text)"
  },
  State_143023_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nicht konfiguriert"
  },
  State_143023_Name = {
    Text = "Afumgon SR (Vorübergehender Text)"
  },
  State_143326_Desc = {
    Text = "Keyflare-Regeneration erhöht um [DescArg1]."
  },
  State_143326_Name = {
    Text = "Offenbarung von Ursache und Wirkung"
  },
  State_143331_Desc = {
    Text = "Bis zum Ende der nächsten Runde trägt <StatusApplier:> die Hälfte des Schadens. Dieser Zustand ist pro Team Unique, wird entfernt, wenn einer der beiden Gebundenen stirbt, und kann nicht vertrieben werden."
  },
  State_143331_Name = {
    Text = "Schaden tragen"
  },
  State_143333_Desc = {
    Text = "Vor Beginn der nächsten Runde trägt <StatusApplier:> die Hälfte des Schadens. Dieser Zustand ist pro Team Unique, wird entfernt, wenn einer der beiden Gebundenen stirbt, und kann nicht vertrieben werden."
  },
  State_143333_Name = {
    Text = "Schadensverschiebung"
  },
  State_143336_Desc = {
    Text = "Verleiht „Der Knechtgaunt\" 1 zusätzliche Wirkung. Beim Spielen von „Der Knechtgaunt\" wird 1 Stapel verbraucht. Maximum 9 Stapel, wird am Kampfende nicht entfernt."
  },
  State_143336_Name = {
    Text = "<BattueKeywords:Die Jagd>"
  },
  State_143340_Desc = {
    Text = "Verleiht „Der Knechtgaunt\" 1 zusätzliche Wirkung. Beim Spielen von „Der Knechtgaunt\" wird 1 Stapel verbraucht. Maximum 9 Stapel, wird am Kampfende nicht entfernt."
  },
  State_143340_Name = {
    Text = "<BattueKeywords:Die Jagd>"
  },
  State_143386_Desc = {
    Text = "Trägt die Hälfte des Schadens für <StatusApplier:>, kann nicht vertrieben werden."
  },
  State_143386_Name = {
    Text = "Schaden tragen"
  },
  State_143387_Desc = {
    Text = "<StatusApplier:> trägt die Hälfte des Schadens, kann nicht vertrieben werden."
  },
  State_143387_Name = {
    Text = "Schadensverschiebung"
  },
  State_143406_Name = {
    Text = "Diese Karte wirkt [DescArg1] Mal zusätzlich"
  },
  State_143408_Desc = {
    Text = "Wenn von einem Feind angegriffen, wechsle zum Aliemus des Angreifers."
  },
  State_143408_Name = {
    Text = "Der irrende Kompass"
  },
  State_143409_Desc = {
    Text = "Wenn von einem Feind angegriffen, wechsle zum Aliemus des Angreifers."
  },
  State_143409_Name = {
    Text = "<CardKeyWord:Der irrende Kompass>"
  },
  State_143419_Desc = {
    Text = "Diese Karte stammt aus <PVPDerivativeCardKeywords_31:„Auritas Schatz\">."
  },
  State_143419_Name = {
    Text = "Auritas Schatz"
  },
  State_143426_Desc = {
    Text = "Nach Rundenbeginn werden [Layer] Arithmetica abgezogen, kann nicht vertrieben werden."
  },
  State_143426_Name = {
    Text = "Verzögerte Arithmetica-Abzug"
  },
  State_143441_Desc = {
    Text = "Der in Runde [StateArg1] ausgewählte Erweckter Körper."
  },
  State_143441_Name = {
    Text = "Testmarkierung 1"
  },
  State_143442_Desc = {
    Text = "Der in Runde [StateArg1] ausgewählte Erweckter Körper."
  },
  State_143442_Name = {
    Text = "Testmarkierung 2"
  },
  State_143444_Desc = {
    Text = "Der in Runde [StateArg1] ausgewählte Erweckter Körper."
  },
  State_143444_Name = {
    Text = "Testmarkierung 4"
  },
  State_143445_Desc = {
    Text = "Der in Runde [StateArg1] ausgewählte Erweckter Körper."
  },
  State_143445_Name = {
    Text = "Testmarkierung 3"
  },
  State_143499_Name = {
    Text = "Immun gegen Aktiven Schaden__„Nur für Entwicklung\""
  },
  State_143500_Name = {
    Text = "Immun gegen Reinen Schaden__„Nur für Entwicklung\""
  },
  State_143541_Desc = {
    Text = "Der von allen Feinden in dieser Runde verursachte Schaden wird um [DescArg1]% reduziert, erhalte [DescArg2] Punkte Stärke."
  },
  State_143541_Name = {
    Text = "Eskortieren"
  },
  State_143542_Desc = {
    Text = "Temporär Gesamtschaden +[DescArg1]% und verursacht bei allen Feinden Korrosion in Höhe von [DescArg2]% der Max LP."
  },
  State_143542_Name = {Text = "Jagen"},
  State_143548_Desc = {
    Text = "Verursacht Schild und fügt Zustand hinzu, Monster, Zweig 1."
  },
  State_143548_Name = {
    Text = "Monster Schild-Umwandlung 1"
  },
  State_143549_Desc = {
    Text = "Verursacht Schild und fügt Zustand hinzu, Erweckter Körper, Zweig 2."
  },
  State_143549_Name = {
    Text = "Charakter Schild-Umwandlung 2"
  },
  State_143550_Desc = {
    Text = "Verursacht Schild und fügt Zustand hinzu, Erweckter Körper, Zweig 1."
  },
  State_143550_Name = {
    Text = "Charakter Schild-Umwandlung 1"
  },
  State_143551_Desc = {
    Text = "Verursacht Schild und fügt Zustand hinzu, Monster, Zweig 2."
  },
  State_143551_Name = {
    Text = "Monster Schild-Umwandlung 2"
  },
  State_143552_Desc = {
    Text = "Verursacht Schild und fügt Zustand hinzu, Spieler, Zweig 1."
  },
  State_143552_Name = {
    Text = "Spieler Schild-Umwandlung 1"
  },
  State_143553_Desc = {
    Text = "Verursacht Schild und fügt Zustand hinzu, Spieler, Zweig 2."
  },
  State_143553_Name = {
    Text = "Spieler Schild-Umwandlung 2"
  },
  State_143573_Desc = {
    Text = "Knechtgaunts sind Pontos-Buff-Karten, die „Plündergaunt\", „Plaggaunt\" und „Schlächtergaunt\" umfassen – insgesamt 3 Arten. Wenn beim Erzeugen eines permanenten „Knechtgaunt\" die Anzahl der permanenten „Knechtgaunt\" 6 überschreitet, wird ein zufälliger permanenter „Knechtgaunt\" zu einem „Zwiegeborene Gaunts\" aufgestiegen, der Arithmetica-Kosten +1 hat, aber 1 zusätzliche Wirkung erzielt. „Zwiegeborene Gaunts\" zählt im Deck als 2 „Knechtgaunts\". Wenn alle „Knechtgaunts\" bereits aufgestiegen sind, wird 1 „Fortg. Einblick\" mit <DestructionKeywords:Zerstören> auf die Hand gelegt."
  },
  State_143573_Name = {
    Text = "Der Knechtgaunt"
  },
  State_143578_Desc = {
    Text = "In dieser Runde: Immer wenn Aktiver Schaden erlitten wird, lege [Layer] <PVPDerivativeCardKeywords_30:„Thrall-Gaunt\">-Karten auf die Hand."
  },
  State_143578_Name = {
    Text = "Ritual des Herrn"
  },
  State_143595_Desc = {
    Text = "Diese Karte erhielt <PrepareKeywords:Vorbereiten> [StateArg1]."
  },
  State_143595_Name = {
    Text = "Tanz des schwarzen Schwans"
  },
  State_143597_Desc = {
    Text = "Team Unique: Der STR▼-Effekt des Ausrüsters wird um <WeaponEffect_Num:[StateArg1] %> erhöht. Beim Wechsel in die „Tobende Wellen \"-Haltung wird der temporäre Kritische Schaden erhöht, um einen Betrag gleich <WeaponEffect_Num:[StateArg1] %> des eigenen Basis-Kritischen Schadens, 3 Runden Abklingzeit."
  },
  State_143597_WeaponDesc = {
    Text = "Der STR▼-Effekt des Ausrüsters wird um <WeaponEffect_Num:[StateArg1] %> erhöht. Nach dem Wechsel in die „Tobende Wellen \"-Haltung wird der temporäre Kritische Schaden um <WeaponEffect_Num:[DescArg1] %> erhöht, 3 Runden Abklingzeit."
  },
  State_143598_Desc = {
    Text = "Team Unique: Der STR▼-Effekt des Ausrüsters wird um <WeaponEffect_Num:[StateArg1] %> erhöht. Für jeden getöteten Feind erhöht sich der am Ende der aktuellen Erkundungsrunde fest wiederhergestellte Aliemus des Ausrüsters um 2 Punkte, maximal <WeaponEffect_Num:[StateArg2]> Mal stapelbar. Nach dem Wechsel in die „Tobende Wellen \"-Haltung wird der temporäre Kritische Schaden erhöht, um einen Betrag gleich <WeaponEffect_Num:[StateArg1] %> des eigenen Basis-Kritischen Schadens, 3 Runden Abklingzeit."
  },
  State_143598_WeaponDesc = {
    Text = "Der STR▼-Effekt des Ausrüsters wird um <WeaponEffect_Num:[StateArg1] %> erhöht. Für jeden getöteten Feind erhöht sich der am Ende der aktuellen Erkundungsrunde fest wiederhergestellte Aliemus des Ausrüsters um 2 Punkte, maximal <WeaponEffect_Num:[StateArg2]> Mal stapelbar. Nach dem Wechsel in die „Tobende Wellen \"-Haltung wird der temporäre Kritische Schaden um <WeaponEffect_Num:[DescArg1] %> erhöht, 3 Runden Abklingzeit."
  },
  State_143683_Desc = {
    Text = "Die Verfolgung dieses Erweckers ist versiegelt und kann nicht verwendet werden. Nach [Layer] Runden wird die Versiegelung aufgehoben."
  },
  State_143683_Name = {
    Text = "<Seal1:Verfolgung Versiegelt>"
  },
  State_144381_Desc = {
    Text = "Kann keine Aktion ausführen, verbleibend [DescArg1] Runden."
  },
  State_144381_Name = {
    Text = "<Yishiganshe:Bewusstseinsinterferenz>"
  },
  State_144441_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Wenn ein Verbündeter stirbt, erhält man selbst <Energy:[Energy:StateArg1]> Aliemus. Wenn ein Verbündeter wiederbelebt wird, erhält er <Energy:[Energy:StateArg2]> Aliemus. Der Aliemus-Effekt wirkt nur, wenn das Ziel nicht voll an Aliemus ist. Verbleibende Wirkungen: [Layer] Mal. Nach Aufbrauchen der Anzahl wird dieses Schicksrad zerstört."
  },
  State_144441_Name = {
    Text = "Seelensynchronisation"
  },
  State_144494_Desc = {
    Text = "Es gibt 7 Arten von Effekten, darunter: 8 Karten ziehen, 6 Arithmetica erhalten, Keyflare erhalten, alle Erwecker erhalten festes Aliemus, STR erhalten, STR aller Gegner vorübergehend reduzieren, Schadenamplifikation vorübergehend erhöhen."
  },
  State_144494_Name = {
    Text = "<Blessing:Segen>"
  },
  State_144508_Desc = {
    Text = "„Preis“ gibt es in 3 Arten:\n\nVerpasste Chance: Verzögert den zugehörigen „Geschenk“-Effekt um 2 Runden.\nVergoldete Worte: Reduziert den zugehörigen „Geschenk“-Effekt um 50%.\nVerschleierte Bosheit: Fügt deinem Team 1 zufälligen negativen Effekt zu:\n<Italic:2 Runden Symptom: Schwäche; 2 Runden Zerbrechlich, 2 Runden Verderben; Gift-Stapelungen gleich 1% Max LP; 2 Stapelungen Leere; 1 Stapel Stagnierung auf 2 zufälligen Karten auf der Hand; oder erzeugt 2 vorübergehende Symptomkarten (die nicht zwischen Kämpfen erhalten bleiben) und legt sie oben auf den Ziehstapel.>"
  },
  State_144508_Name = {
    Text = "<BlessingNegativeEffect:Preis>"
  },
  State_144519_Desc = {
    Text = "Testprozesswert, wird nach Rundenbeginn oder nach dem Spielen einer Karte aktualisiert. Derzeit vorhandene Reichsgeister: [Layer]."
  },
  State_144519_Name = {
    Text = "Neuer Chaos-Reichsgeist"
  },
  State_145228_Name = {
    Text = "<WormGrowth:Mahl>"
  },
  State_145229_Desc = {
    Text = "Du bist Teil des Segens~! Kann von Caraboos Verherrlichung für einen Buff verbraucht werden, stapelt bis zu 5. Bleibt zwischen Kämpfen erhalten."
  },
  State_145229_Name = {
    Text = "<SacrificialMark:Opfer>"
  },
  State_145436_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: „Schlag\"-Schaden erhöht sich um [DescArg1]%, nach jedem „Schlag\" erhöht sich der Schaden zusätzlich um [StateArg2]%, bis maximal [StateArg3]%."
  },
  State_145436_Name = {
    Text = "Unsterbliche Hungerknochen"
  },
  State_145437_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Beim Ausrüsten erhält man [StateArg2] Stapelungen <EnergyStorageKeywords:Aufladen>, „Schlag\"-Schaden erhöht sich um [StateArg1]% und wird zu <PVPPunctureDamagewords:Durchstechschaden>."
  },
  State_145437_Name = {
    Text = "Himmlischer Untergang"
  },
  State_145456_Desc = {
    Text = "Bei der Zielauswahl werden Verspotten, Schleichen und Zielerfassung ignoriert. Wenn mehrere Ziele die gleiche Bedingung erfüllen, wird der vordere Erwecker bevorzugt."
  },
  State_145456_Name = {
    Text = "LP und Schild am niedrigsten"
  },
  State_145457_Desc = {
    Text = "Bei der Zielauswahl werden Verspotten, Schleichen und Zielerfassung ignoriert. Wenn mehrere Ziele die gleiche Bedingung erfüllen, wird der vordere Erwecker bevorzugt."
  },
  State_145457_Name = {
    Text = "LP und Schild am höchsten"
  },
  State_145495_Desc = {
    Text = "Diese Karte wird durch Doppelschuss gespielt."
  },
  State_145495_Name = {
    Text = "<CardKeyWord:Doppelschuss>"
  },
  State_145554_Desc = {
    Text = "Team Unique: Nach Beginn der Erkundung wird 1 <Falltospace1[StateArg3]:„Sterblicher Aufenthalt\"> in das Kartendeck gelegt. „Sterblicher Aufenthalt\": Verbraucht 0 Arithmetica. Verursacht an allen Gegnern feste <Corrosion:Korrosion> in Höhe von <WeaponEffect_Num:[StateArg1]%> der ANG des Ausrüsters sowie <WeaponEffect_Num:[Float:StateArg4]%> seiner Max LP, fügt den Befehlskarten aller anderen Erweckter Körper <ErosionColorInkKeywords:Wahrnehmungsverzerrung> hinzu und mischt 1 <Falltospace2[StateArg3]:„Aufstieg in den Abgrund\"> in den Ziehstapel. <RetainIconKeywords:Behalten>. <DepleteIconKeywords:Verbrauchen>."
  },
  State_145554_Name = {
    Text = "Aufstieg in den Abgrund"
  },
  State_145554_WeaponDesc = {
    Text = "Nach Beginn der Erkundung wird 1 <Falltospace1[StateArg3]:„Sterblicher Aufenthalt\"> in das Kartendeck gelegt. „Sterblicher Aufenthalt\": Verbraucht 0 Arithmetica. Verursacht an allen Gegnern feste <Corrosion:Korrosion> in Höhe von <WeaponEffect_Num:[StateArg1]%> der ANG des Ausrüsters sowie <WeaponEffect_Num:[Float:StateArg4]%> seiner Max LP, fügt den Befehlskarten aller anderen Erweckter Körper <ErosionColorInkKeywords:Wahrnehmungsverzerrung> hinzu und mischt 1 <Falltospace2[StateArg3]:„Aufstieg in den Abgrund\"> in den Ziehstapel. <RetainIconKeywords:Behalten>. <DepleteIconKeywords:Verbrauchen>"
  },
  State_145572_Desc = {
    Text = "Zu Beginn jeder Runde verursachen alle anderen Erweckten Körper <Damage:[Damage:Layer]> Durchstechschaden."
  },
  State_145572_Name = {
    Text = "Cetus-verschlingender Sturm"
  },
  State_145590_Desc = {
    Text = "Wenn eine identische Karte mit derselben Zugehörigkeit auf die Hand gelegt wird, wird der Fusion-Effekt ausgelöst und diese Karte verbraucht."
  },
  State_145590_Name = {
    Text = "<CardKeyWord:Fusion>"
  },
  State_145592_Desc = {
    Text = "Erfasst einen Feind und macht ihn zum bevorzugten Angriffsziel. Bei der Auswahl eines Einzelziels kann nur das erfasste Ziel gewählt werden. Ignoriert Verspotten und Verstecken."
  },
  State_145592_Name = {
    Text = "<CardKeyWord:Zielerfassung>"
  },
  State_145619_Name = {Text = "Verderben"},
  State_145620_Name = {Text = "Leere"},
  State_145621_Desc = {
    Text = "Der Effekt „Segen“ wird um 50 % reduziert."
  },
  State_145621_Name = {
    Text = "<Bleesing_Exaggerate:Übertreibung>"
  },
  State_145622_Name = {
    Text = "Stagnierung"
  },
  State_145623_Desc = {
    Text = "Fügt deinem Team 1 zufälligen negativen Effekt zu:\n<Italic:2 Runden Symptom: Schwäche; 2 Runden Zerbrechlich, 2 Runden Verderben; Gift-Stapelungen gleich 1% Max LP; 2 Stapelungen Leere; 1 Stapel Stagnierung auf 2 zufälligen Karten auf der Hand; oder erzeugt 2 vorübergehende Symptomkarten (die nicht zwischen Kämpfen erhalten bleiben) und legt sie oben auf den Ziehstapel.>"
  },
  State_145623_Name = {
    Text = "<Bleesing_Negative:Verschleierte Bosheit>"
  },
  State_145624_Name = {Text = "Schwäche"},
  State_145625_Name = {
    Text = "2 identische vorübergehende „Symptomkarten“"
  },
  State_145626_Name = {
    Text = "Zerbrechlich"
  },
  State_145627_Name = {Text = "Gift"},
  State_145628_Desc = {
    Text = "Erhält nach 2 Runden den Effekt „Segen“."
  },
  State_145628_Name = {
    Text = "<Bleesing_Delay:Verpasste Gelegenheit>"
  },
  State_145631_Desc = {
    Text = "„Schlag\"-Schaden erhöht sich um [StateArg1]% und wird zu <PVPPunctureDamagewords:Durchstechschaden>."
  },
  State_145631_Name = {
    Text = "Himmlischer Untergang"
  },
  State_145632_Desc = {
    Text = "Diese Karte stammt vom Schicksrad „Stunde des Glücks\"."
  },
  State_145632_Name = {
    Text = "Stunde des Glücks"
  },
  State_145638_Desc = {
    Text = "Die Arithmetica-Kosten dieser Karte erhöhen sich um [Layer]."
  },
  State_145638_Name = {
    Text = "Grausame Homage"
  },
  State_145642_Desc = {
    Text = "Nach 2 Runden erhalten alle Erwecker [StateArg1] Aliemus [Layer] Mal."
  },
  State_145642_Name = {
    Text = "Verzögerter Wahnsinn"
  },
  State_145644_Desc = {
    Text = "Nach 2 Runden <Posse:[StateArg1]> Keyflare erhalten [Layer] Mal."
  },
  State_145644_Name = {
    Text = "Latenz-Keyflare"
  },
  State_145645_Desc = {
    Text = "Nach 2 Runden vorübergehend allen Feinden [StateArg1] Punkte <ExhaustionIconKeywords:Stärke> reduzieren [Layer] Mal"
  },
  State_145645_Name = {
    Text = "Verzögerte Erschöpfung"
  },
  State_145646_Desc = {
    Text = "Nach 2 Runden [StateArg1] Arithmetica erhalten [Layer] Mal."
  },
  State_145646_Name = {
    Text = "Verzögerte Arithmetica"
  },
  State_145647_Desc = {
    Text = "Nach 2 Runden [StateArg1] Punkte <PowerIconKeywords:Stärke> erhalten [Layer] Mal."
  },
  State_145647_Name = {
    Text = "Latenz-Stärke"
  },
  State_145648_Desc = {
    Text = "Nach 2 Runden [StateArg1] Karten ziehen [Layer] Mal."
  },
  State_145648_Name = {
    Text = "Verzögerte Ziehung"
  },
  State_145649_Desc = {
    Text = "Nach 2 Runden vorübergehende Schadenamplifikation [StateArg1]% [Layer] Mal."
  },
  State_145649_Name = {
    Text = "Latenz vorübergehende Schadenamplifikation"
  },
  State_145652_Desc = {
    Text = "Die Arithmetica dieser Karte verringert sich um -[Layer]."
  },
  State_145652_Name = {
    Text = "Unerträgliche Freiheit"
  },
  State_145654_Desc = {
    Text = "Test. Nach dem Spielen oder nach dem Verlassen der Hand zerstören."
  },
  State_145654_Name = {
    Text = "Test. Augenblick"
  },
  State_145660_Desc = {
    Text = [=[
Eigene Seite
1.<AllyPosAwaker1Name:> [DescArg1]
2.<AllyPosAwaker2Name:> [DescArg2]
3.<AllyPosAwaker3Name:> [DescArg3]
4.<AllyPosAwaker4Name:> [DescArg4]
Gegner
1.<EnemyPosAwaker1Name:> [DescArg5]
2.<EnemyPosAwaker2Name:> [DescArg6]
3.<EnemyPosAwaker3Name:> [DescArg7]
4.<EnemyPosAwaker4Name:> [DescArg8]]=]
  },
  State_145660_Name = {
    Text = "LP-Veränderung nach Zurücksetzen"
  },
  State_145693_Desc = {
    Text = "Nach dem Ende der Runde reduziert sich die Arithmetica um -[Layer]; auch nach dem Abwerfen wird dieser Effekt ausgelöst"
  },
  State_145693_Name = {
    Text = "<PrepareKeypvewordscolour: Vorbereiten [Layer]>"
  },
  State_145693_WeaponDesc = {
    Text = "Karten werden nicht in der Ablagephase in den Ablagestapel gelegt, sondern bleiben im Handkartenbereich"
  },
  State_145694_Name = {
    Text = "Symbiose mit dem Schwarzen Sumpf"
  },
  State_145698_Desc = {
    Text = "Greift bevorzugt den per Zielerfassung gesperrten <StatusApplier:> an. Bei der Auswahl eines Einzelziels kann nur das gesperrte Ziel gewählt werden. Ignoriert Verspotten und Verborgenheit."
  },
  State_145698_Name = {
    Text = "Zielerfassung"
  },
  State_145699_Desc = {
    Text = "·Greift bevorzugt den erfassten <StatusApplier:> an. Bei der Auswahl eines Einzelziels kann nur das erfasste Ziel gewählt werden. Ignoriert Verspotten und Verstecken.\n·Nach dem eigenen Tod erhält <StatusApplier:> „<PVPDerivativeCardKeywords_32:Zum Kampf!>\"."
  },
  State_145699_Name = {
    Text = "Zielerfassung"
  },
  State_145709_Desc = {
    Text = "Jede Stapel erhöht die Max LP um 10% von Caraboos KON (max. 50 Stapelungen). Bei maximalen Stapelungen heilen überschüssige Stapelungen stattdessen um das 3-Fache dieses LP-Wertes. Pro Nicht-Boss-Kampf können bis zu 10 Stapelungen „Sattheit“ erhalten werden. „Sattheit“ bleibt zwischen Kämpfen erhalten."
  },
  State_145709_Name = {
    Text = "<WormGrowth:Mahl>"
  },
  State_145710_Desc = {
    Text = "Du bist Teil des Segens~! Kann von Caraboos Verherrlichung für einen Buff verbraucht werden, stapelt bis zu 5. Bleibt zwischen Kämpfen erhalten."
  },
  State_145710_Name = {
    Text = "<SacrificialMark:Opfer>"
  },
  State_145901_Desc = {
    Text = [=[
Unsere Seite
1.<AllyPosAwaker1Name:> [DescArg1]
2.<AllyPosAwaker2Name:> [DescArg2]
3.<AllyPosAwaker3Name:> [DescArg3]
4.<AllyPosAwaker4Name:> [DescArg4]]=]
  },
  State_145901_Name = {
    Text = "LP-Veränderung nach Zurücksetzen"
  },
  State_146041_Desc = {
    Text = "Dieser Erweckter Körper fühlt sich vom weltlichen Lärm losgelöst.\n·Bis zum Ende des Zuges können keine Aktionen ausgeführt werden, Schaden wird um 99% reduziert; besitzt das Ziel keinen Widerstand, erhält es Widerstand.\n·Nach Ende des Effekts verursacht er <Damage:[Layer]> passiven Schaden an allen verbündeten Einheiten.\n·Besitzt das Ziel beim Anwenden bereits Widerstand, endet die Täuschung sofort und der Schaden am Ziel wird verdoppelt."
  },
  State_146041_Name = {Text = "Täuschung"},
  State_146043_Desc = {
    Text = "Zu Beginn des nächsten Zuges werden [Layer] Aliemus abgezogen."
  },
  State_146043_Name = {
    Text = "Verzögerter Aliemus-Abzug"
  },
  State_146058_Desc = {
    Text = "Testprozesswert, wird nach Rundenbeginn oder nach dem Spielen einer Karte aktualisiert. Derzeit sollte der Angriffseffekt [Layer]% betragen."
  },
  State_146058_Name = {
    Text = "Posse-Angriffseffekt"
  },
  State_146059_Desc = {
    Text = "Testprozesswert, wird nach Rundenbeginn oder nach dem Spielen einer Karte aktualisiert. Derzeit sollte der Verteidigungseffekt [Layer]% betragen."
  },
  State_146059_Name = {
    Text = "Posse-Verteidigungseffekt"
  },
  State_146079_Desc = {
    Text = "Diese Karte kehrt nach dem Verlassen der Hand wieder in die Hand zurück."
  },
  State_146079_Name = {
    Text = "<Recycle:Rückkehr>"
  },
  State_146085_Desc = {
    Text = "Arithmetica der Karte vor dem Spielen in diesem Zug ändern"
  },
  State_146085_Name = {
    Text = "Arithmetica der Karte vor dem Spielen in diesem Zug ändern"
  },
  State_146085_WeaponDesc = {
    Text = "Ändere die Arithmetica Kosten der Karte vor dem Spielen"
  },
  State_146086_Desc = {
    Text = "Arithmetica der Karte vor dem Spielen in diesem Zug ändern"
  },
  State_146086_Name = {
    Text = "Arithmetica der Karte vor dem Spielen in diesem Zug ändern"
  },
  State_146086_WeaponDesc = {
    Text = "Ändere die Arithmetica Kosten der Karte vor dem Spielen"
  },
  State_146117_Desc = {
    Text = "Kann von „<DerivativeCardKeywords_157:Knochen des Schwertes>\" verbraucht werden, um einen Buff zu erhalten. Dieser Zustand kann bis zu 15 Stapel ansammeln."
  },
  State_146117_Name = {
    Text = "<Shimieluotanhuodong2:Kampfwille>"
  },
  State_146129_Desc = {
    Text = "Gesamtschaden aller Erweckter Körper +[Layer]%."
  },
  State_146129_Name = {
    Text = "Zorn des Leviathan"
  },
  State_146147_Desc = {
    Text = "Kann von „<DerivativeCardKeywords_157:Knochen des Schwertes>\" verbraucht werden, um einen Buff zu erhalten. Dieser Zustand kann bis zu 15 Stapel ansammeln."
  },
  State_146147_Name = {
    Text = "<Shimieluotanhuodong1:Kampfwille>"
  },
  State_146154_Desc = {
    Text = "Lässt diesen Erweckten Körper sich gut fühlen. Seine „Fähigkeit\" wird in „Segen?\" umgewandelt. Nach der Umwandlung werden entsprechend viele Stapelungen verbraucht."
  },
  State_146154_Name = {
    Text = "<PVPBlessColour:Segen>"
  },
  State_146155_Desc = {
    Text = "Dieser Erweckter Körper fühlt sich gut.\n·In den nächsten [Layer] „Fähigkeit\"-Karten werden zu „Segen?\"-Karten verändert; nach der Veränderung werden entsprechende Stapelungen verbraucht."
  },
  State_146155_Name = {Text = "Sege"},
  State_146155_WeaponDesc = {Text = "Nein"},
  State_146202_Desc = {
    Text = "Lässt diesen Erweckten Körper das Gefühl haben, dem weltlichen Lärm enthoben zu sein.\n·Bis zum Ende der Runde können keine Aktionen durchgeführt werden. Schaden wird um 99 % reduziert. Falls das Ziel keinen Widerstand hat, erhält es Widerstand.\n·Nach Ende des Effekts wird allen befreundeten Einheiten passiver Schaden in Höhe der entsprechenden Stapelungen zugefügt.\n·Falls das Ziel beim Anwenden bereits Widerstand besitzt, endet Täuschung sofort und der Schaden am Ziel wird verdoppelt."
  },
  State_146202_Name = {
    Text = "<CardKeyWord:Beschwatzen>"
  },
  State_146352_Desc = {
    Text = "Bei jedem erlittenen Schaden werden [StateArg1] Stapel <Shimieluotanhuodong1:Kampfwille> angesammelt"
  },
  State_146352_Name = {
    Text = "Kampferprobt"
  },
  State_146363_Desc = {
    Text = "Zu Beginn der nächsten Runde werden [Layer] LP entfernt. Beim Verlust von LP wird die Stapelanzahl dieses Zustands um den gleichen Betrag reduziert."
  },
  State_146363_Name = {
    Text = "Das, was keine Lüge ist"
  },
  State_146383_Desc = {
    Text = "Nach dem Hinzufügen eines Zustands und nach dem Spielen einer Karte wird der Silberner Schlüssel Aufladelevel jedes Erweckter Körpers aktualisiert und angezeigt."
  },
  State_146383_Name = {
    Text = "Effizienz-Eingang"
  },
  State_146384_Desc = {
    Text = "P1-Wert [StateArg1], P2-Wert [StateArg2], P3-Wert [StateArg3], P4-Wert [StateArg4]."
  },
  State_146384_Name = {
    Text = "Effizienz-Wert"
  },
  State_146385_Desc = {
    Text = "Nach dem Hinzufügen eines Zustands und nach dem Spielen einer Karte wird der Silberner Schlüssel Aufladelevel jedes Erweckter Körpers aktualisiert und angezeigt."
  },
  State_146385_Name = {
    Text = "Level-Eingang"
  },
  State_146386_Desc = {
    Text = "P1-Wert [StateArg1], P2-Wert [StateArg2], P3-Wert [StateArg3], P4-Wert [StateArg4]."
  },
  State_146386_Name = {Text = "Level-Wert"},
  State_146446_Desc = {
    Text = "VERT des Erweckten Körpers, \"P1\": [StateArg1], \"P2\": [StateArg2], \"P3\": [StateArg3], \"P4\": [StateArg4]."
  },
  State_146446_Name = {
    Text = "Verteidigungseigenschaftsliste"
  },
  State_146448_Desc = {
    Text = "ANG des Erweckten Körpers, P1: Kraft[StateArg1] Stärke[StateArg2], P2: Kraft[StateArg3] Stärke[StateArg4], P3: Kraft[StateArg5] Stärke[StateArg6], P4: Kraft[StateArg7] Stärke[StateArg8]."
  },
  State_146448_Name = {
    Text = "Angriffseigenschaftsliste"
  },
  State_146452_Desc = {
    Text = "Team Unique: Krit. Schaden des „Schlags“ des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>. Am Rundenende erhöht sich der Krit. Schaden der nächsten Verherrlichung des Ausrüsters um einen Prozentsatz, der <WeaponEffect_Num:[StateArg2]%> seines Basis-Aliemus entspricht. Bis zu 5 Mal stapelbar."
  },
  State_146452_WeaponDesc = {
    Text = "Krit. Schaden des „Schlags\" des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>. Am Ende des Zuges erhöht sich der Krit. Schaden der nächsten Verherrlichung des Ausrüsters um <WeaponEffect_Num:[DescArg1]%>, bis zu maximal 5 Stapelungen (aktuell [DescArg2]%)."
  },
  State_146456_Desc = {
    Text = "Team Unique: Krit. Schaden des „Schlags“ des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>."
  },
  State_146456_WeaponDesc = {
    Text = "Krit. Schaden des „Schlags\" des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>."
  },
  State_146534_Desc = {
    Text = "Nach Beginn des Levels werden die Container der einzelnen Mechanismen des Ursprünglichen Chaos dem Schutzherr hinzugefügt."
  },
  State_146534_Name = {
    Text = "Ursprüngliches Chaos-Initialisierung"
  },
  State_146535_Desc = {
    Text = "Attribut-Container."
  },
  State_146535_Name = {
    Text = "Ursprüngliches Chaos-Markierung"
  },
  State_146536_Desc = {
    Text = "Mechanismus-Container."
  },
  State_146536_Name = {
    Text = "Ursprüngliches Chaos-Mechanismus"
  },
  State_146644_Desc = {
    Text = "Erwecken erhält Vorbereiten 1; beim ersten Spielen einer Karte pro Runde wird die mitgeführte Posse automatisch eingesetzt."
  },
  State_146644_Name = {Text = "Urecho"},
  State_146645_Desc = {
    Text = "Im neuen Chaos-Reich wird die mitgeführte Posse automatisch freigegeben, wenn zum ersten Mal pro Runde Erwecken gespielt wird. Derzeit verfügbar."
  },
  State_146645_Name = {
    Text = "Verfügbare Markierung"
  },
  State_146646_Desc = {
    Text = "Das maximale Basis-Keyflare wird auf 2000 geändert. Die Regel zum Erhalten von Keyflare wird ersetzt durch: Wenn ein Erweckter Körper zum ersten Mal pro Runde eine Befehlskarte spielt, erhält er Keyflare in Höhe von 3× Keyflare-Regeneration + 100."
  },
  State_146646_Name = {
    Text = "Neue Chaos-Keyflare-Regel"
  },
  State_146651_Desc = {
    Text = "Erhöht das ANG-Attribut dieses Erweckten Körpers um [Layer]%."
  },
  State_146651_Name = {
    Text = "Chaos·Angriff"
  },
  State_146652_Desc = {
    Text = "Nur einmal nach Kampfbeginn wird die Keyflare-Regenerationseffizienz jedes Erweckten Körpers auf den Durchschnittswert der Silberner Schlüssel Aufladelevel aller Erweckten Körper geändert."
  },
  State_146652_Name = {
    Text = "Ursprüngliches Gleichgewicht"
  },
  State_146653_Desc = {
    Text = "Erhöht das VERT-Attribut dieses Erweckten Körpers um [Layer]%."
  },
  State_146653_Name = {
    Text = "Chaos·Verteidigung"
  },
  State_146663_Desc = {
    Text = "Der „Schlag\" der nächsten [Layer] Lotan: Cetarchon hat 1 zusätzliche Wirkung."
  },
  State_146663_Name = {
    Text = "Cetus-verschlingender Sturm"
  },
  State_147058_Name = {
    Text = "Schmuckstück Raum 36 Ring"
  },
  State_147079_Desc = {
    Text = "Diese Karte kann weder abgelegt noch verwandelt werden."
  },
  State_147079_Name = {
    Text = "<RetainIconKeywordsColour:Erzwungenes Behalten>"
  },
  State_147545_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nicht konfiguriert"
  },
  State_147545_Name = {
    Text = "Tinct: Vespera SR (vorübergehender Text)"
  },
  State_147546_Name = {Text = "Veraltet"},
  State_147546_WeaponDesc = {
    Text = "Stimmen aus dem Jenseits"
  },
  State_147584_Desc = {
    Text = "Der <Blessing:Segen>-Effekt der nächsten gespielten <DerivativeCardKeywords_152:„Feengabe“> wird um 50% erhöht"
  },
  State_147737_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Beim Ausrüsten erhält man [StateArg1] <MaxHPKeywords:Max LP>. Zu Rundenbeginn wird allen Gegnern <Damage:[Damage:StateArg2]> <PVPBleedingKeywords:Bluten>-Schaden zugefügt,"
  },
  State_147737_Name = {
    Text = "Dunkler als Dunkelheit"
  },
  State_147764_Name = {
    Text = "Zustand@Caraboo-Aktivität Falschauswahl-Zähler"
  },
  State_147765_Desc = {
    Text = "Zu Beginn des nächsten Zuges verlierst du 2 Arithmetica und ziehst 2 Karten weniger."
  },
  State_147765_Name = {
    Text = "Pistoles de Marie"
  },
  State_147768_Desc = {
    Text = "Zu Beginn des nächsten Zuges erhältst du [DescArg1] Fortg. Einblick."
  },
  State_147768_Name = {
    Text = "Pistoles de Marie Münzen"
  },
  State_147769_Desc = {
    Text = "„Mahl“ hat in diesem Kampf bereits [Layer] Stapel angesammelt."
  },
  State_147769_Name = {
    Text = "Stapellimit"
  },
  State_147772_Name = {
    Text = "Zustand@Caraboo-Aktivität fügt vorübergehendes Keyflare-Limit hinzu"
  },
  State_147773_Name = {
    Text = "Zustand@Caraboo-Aktivität fügt vorübergehendes Keyflare-Limit hinzu"
  },
  State_147774_Name = {
    Text = "Zustand@Caraboo-Aktivität fügt vorübergehendes Keyflare-Limit hinzu_normales Chaos"
  },
  State_147797_Desc = {
    Text = "Kann Aliemus, <PowerIconKeywords:Stärke>, LP, Keyflare und Arithmetica gewinnen oder verlieren sowie Karten ziehen."
  },
  State_147797_Name = {
    Text = "Pistoles de Marie"
  },
  State_147800_Desc = {
    Text = "Zu Beginn des nächsten Zuges verlierst du 2 Arithmetica und ziehst 2 Karten weniger."
  },
  State_147800_Name = {
    Text = "Pistoles de Marie"
  },
  State_147869_Name = {
    Text = "Ziehe [Layer] Karten"
  },
  State_147870_Name = {
    Text = "Verursacht [Layer] Runden Schwäche an allen Feinden"
  },
  State_147871_Name = {
    Text = "Erhalte [Energy:DescArg1] Wahnsinn"
  },
  State_147872_Name = {
    Text = "Verursacht [Layer] Runden Verwundbarkeit an allen Feinden"
  },
  State_147873_Name = {
    Text = "Erhalte [Layer] Arithmetica"
  },
  State_147874_Name = {
    Text = "Erhalte [Block:DescArg1] Schildpunkte"
  },
  State_147962_Desc = {
    Text = "Wenn der Spieler „<DerivativeCardKeywords_158:Sühne>“ spielt, werden nur 50 % der <MonsterSinMarkKeywords:Sündenmal>-Stapelungen aufgelöst, und für jede gespielte Befehlskarte erhält „Divus: Die Weiße Nacht“ 1 Stapelung <MonsterSinMarkKeywords:Sündenmal>."
  },
  State_147962_Name = {
    Text = "Weg zur Reinheit"
  },
  State_147967_Desc = {
    Text = "„Divus: Die weiße Nacht“ fügt dem verursachten Schaden [DescArg1]% <BleedingIconKeywords:Bluten> hinzu."
  },
  State_147967_Name = {Text = "Sündenmal"},
  State_147968_Desc = {
    Text = "Maximal 3 Lagen. Beim Wechsel zur Angriffsabsicht wird der von „Divus: Die weiße Nacht“ verursachte Schaden um 25% erhöht und 1 Lage verbraucht."
  },
  State_147968_Name = {
    Text = "Qual Erlösung"
  },
  State_147969_Desc = {
    Text = "Wenn „Divus: Die weiße Nacht“ die „Heiliges Herz“-Absicht hat, werden für jede gespielte Befehlskarte 2 Lagen <MonsterPolluxFever:Wahnsinn> angesammelt."
  },
  State_147969_Name = {
    Text = "Göttliche Offenbarung des Neuen Bundes"
  },
  State_147971_Desc = {
    Text = "Dieser Erwecker hat noch keine Erweckung erfahren... Wenn er kurz vor der Niederlage steht, werden LP wiederhergestellt und er erhält 1 Stapelung <InvincibleUntilRoused:Undurchdringliche Panzerung>. Nach der Erweckung wird <InvincibleUntilRoused:Undurchdringliche Panzerung> entfernt und er beginnt den Kampf in seiner wahren Form."
  },
  State_147971_Name = {
    Text = "Nicht erweckt"
  },
  State_147972_Desc = {
    Text = "Jede Lage lässt „Divus: Die weiße Nacht“ dem verursachten Schaden 1% <BleedingIconKeywords:Bluten> hinzufügen."
  },
  State_147972_Name = {
    Text = "<MonsterSinMarkKeywords:Sündenmal>"
  },
  State_147974_Desc = {
    Text = "Nach Rundenbeginn aufgelöst. Nach Erreichen von 10 Lagen wird nach dem nächsten Kartenspielen sofort gehandelt, Wahnsinn entfernt und die Absicht auf „Heiliges Herz“ umgestellt."
  },
  State_147974_Name = {
    Text = "Vorübergehender Wahnsinn"
  },
  State_147975_Desc = {
    Text = "Zu Kampfbeginn wird eine „<DerivativeCardKeywords_158:Sühne>“ auf die Hand gelegt. Nach dem Rundenende werden 5 Lagen <MonsterSinMarkKeywords:Sündenmal> erhalten."
  },
  State_147975_Name = {
    Text = "Lichtträger-Gottheit"
  },
  State_147993_Desc = {
    Text = "Maximal 3 Lagen. Beim Wechsel zur Angriffsabsicht wird der von „Divus: Die weiße Nacht“ verursachte Schaden um 25% erhöht und 1 Lage verbraucht."
  },
  State_147993_Name = {
    Text = "Qual Erlösung"
  },
  State_148020_Desc = {
    Text = "Immun gegen jeden Schaden und kann keine LP verlieren. Wird nach dem Erwecken entfernt."
  },
  State_148020_Name = {
    Text = "Silberkern-Verfestigung"
  },
  State_148021_Name = {
    Text = "Zustand@Monster allgemeine Wiederbelebung vor Erwecken Immun-Entfernung Markierung"
  },
  State_148073_Name = {
    Text = "Ziehe 1 Karte"
  },
  State_148074_Desc = {
    Text = "Karten werden nicht in der Ablagephase in den Ablagestapel gelegt, sondern bleiben im Handkartenbereich"
  },
  State_148074_Name = {
    Text = "<RetainIconKeywords:Behalten>"
  },
  State_148074_WeaponDesc = {
    Text = "Karten werden nicht in der Ablagephase in den Ablagestapel gelegt, sondern bleiben im Handkartenbereich"
  },
  State_148076_Name = {
    Text = "Weg zur Reinheit Kartenspiel-Überwachung"
  },
  State_148116_Desc = {
    Text = "Nach 1 Runde [StateArg1] Karte(n) ziehen [Layer] Mal."
  },
  State_148116_Name = {
    Text = "Verzögerte Ziehung1"
  },
  State_148381_Desc = {
    Text = "Bis zum Ende des Zuges fügt der eigene Schaden zusätzlich 100% <BleedingIconKeywords:Bluten> zu."
  },
  State_148381_Name = {
    Text = "Fesseln der Feindschaft"
  },
  State_148383_Desc = {
    Text = "Max. 3 Stapelungen. Wenn 3 Stapelungen „Endloses Töten“ gehalten werden, wechselt die Absicht beim nächsten Wechsel zu „Blutrote Fesseln“ stattdessen zu „Blutrünstiger Dreschflegel“ und „Endloses Töten“ wird geleert."
  },
  State_148383_Name = {
    Text = "„Groll“"
  },
  State_148385_Desc = {
    Text = "Immer wenn der Feind eine Befehlskarte spielt, werden 2 Lagen <MonsterB05EXFever:vorübergehender Wahnsinn> erhalten."
  },
  State_148385_Name = {
    Text = "Unregelmäßige Form"
  },
  State_148386_Desc = {
    Text = "Kann bis zum Ende des Zuges kein Schild erhalten."
  },
  State_148386_Name = {
    Text = "Blutige Fesseln"
  },
  State_148387_Desc = {
    Text = "Dieser Erwecker hat noch keine Erweckung erfahren... Wenn er kurz vor der Niederlage steht, werden LP wiederhergestellt und er erhält 1 Stapelung <InvincibleUntilRoused:Undurchdringliche Panzerung>. Nach der Erweckung wird <InvincibleUntilRoused:Undurchdringliche Panzerung> entfernt und er beginnt den Kampf in seiner wahren Form."
  },
  State_148387_Name = {
    Text = "Nicht erweckt"
  },
  State_148391_Desc = {
    Text = "Bis zum Ende des Zuges fügt der eigene Schaden zusätzlich 100% <BleedingIconKeywords:Bluten> zu."
  },
  State_148391_Name = {
    Text = "Blutige Fesseln"
  },
  State_148392_Desc = {
    Text = "Nach Rundenbeginn aufgelöst. Nach Erreichen von 10 Lagen wird nach dem nächsten Kartenspielen sofort gehandelt, Wahnsinn entfernt und die Absicht auf „Blutrote Fesseln“ umgestellt."
  },
  State_148392_Name = {
    Text = "Vorübergehender Wahnsinn"
  },
  State_148394_Desc = {
    Text = "Zu Beginn des Zuges wird 1 Stapelung <ResentChainsKeywords:Kette des Grolls> erhalten. Wenn die Intention zu „Blutrünstiger Dreschflegel“ wechselt, wird man bis nach Ende des gegnerischen Zuges gegen jeden Schaden und jeden LP-Verlust-Effekt Immun."
  },
  State_148394_Name = {
    Text = "Deklaration der Seelensammlerin"
  },
  State_148395_Desc = {
    Text = "Immun gegen jeden Schaden (einschließlich Durchstechschaden) und kann keine LP verlieren. Wird nach Ende des gegnerischen Zuges entfernt."
  },
  State_148395_Name = {
    Text = "Deklaration der Seelensammlerin – Blutrünstiger Dreschflegel"
  },
  State_148421_Desc = {
    Text = "Nach 1 Runde vorübergehend [StateArg1] Punkte <ExhaustionIconKeywords:Stärke> aller Feinde senken [Layer] Mal"
  },
  State_148421_Name = {
    Text = "Latenz Berauben 1"
  },
  State_148422_Desc = {
    Text = "Nach 1 Runde vorübergehende Schadenamplifikation [StateArg1]% [Layer] Mal."
  },
  State_148422_Name = {
    Text = "Verzögerte vorübergehende Schadenamplifikation1"
  },
  State_148423_Desc = {
    Text = "Nach 1 Runde <Posse:[StateArg1]> Keyflare erhalten [Layer] Mal."
  },
  State_148423_Name = {
    Text = "Latenz Keyflare 1"
  },
  State_148426_Desc = {
    Text = "Nach 1 Runde [StateArg1] Arithmetica erhalten [Layer] Mal."
  },
  State_148426_Name = {
    Text = "Latenz Arithmetica 1"
  },
  State_148427_Desc = {
    Text = "Nach 1 Runde erhalten alle Erwecker [StateArg1] Punkte Aliemus [Layer] Mal."
  },
  State_148427_Name = {
    Text = "Verzögerter Wahnsinn1"
  },
  State_148428_Desc = {
    Text = "Nach 1 Runde [StateArg1] Punkte <PowerIconKeywords:Stärke> erhalten [Layer] Mal."
  },
  State_148428_Name = {
    Text = "Latenz Stärke 1"
  },
  State_148511_Desc = {
    Text = "Team Unique: Nach Beginn der Erkundung wird 1 <Backupbody[StateArg3]:„Seelensynchronisation\"> zum Kartendeck hinzugefügt. „Seelensynchronisation“: Arithmetica-Kosten 0, nach dem Spielen erhält man 1 Arithmetica. <RetainIconKeywords:Behalten>: Sammelt eine feste LP-Heilungsmenge in Höhe von <WeaponEffect_Num:[StateArg1]%> der KON des Ausrüsters sowie <WeaponEffect_Num:[StateArg2]> feste Aliemus-Punkte in dieser Karte. Wurde diese Karte nicht zerstört, kann einmal der Tod verhindert werden und alle gesammelten LP-Heilungsmengen und Aliemus werden freigesetzt. Danach wird diese Karte <DestructionKeywords:zerstört>."
  },
  State_148511_Name = {
    Text = "Seelensynchronisation"
  },
  State_148511_WeaponDesc = {
    Text = "Nach Beginn der Erkundung wird 1 <Backupbody[StateArg3]:„Seelensynchronisation\"> zum Kartendeck hinzugefügt. „Seelensynchronisation“: Arithmetica-Kosten 0, nach dem Spielen erhält man 1 Arithmetica. <RetainIconKeywords:Behalten>: Sammelt eine feste LP-Heilungsmenge in Höhe von <WeaponEffect_Num:[StateArg1]%> der KON des Ausrüsters sowie <WeaponEffect_Num:[StateArg2]> feste Aliemus-Punkte in dieser Karte. Wurde diese Karte nicht zerstört, kann einmal der Tod verhindert werden und alle gesammelten LP-Heilungsmengen und Aliemus werden freigesetzt. Danach wird diese Karte <DestructionKeywords:zerstört>."
  },
  State_148513_Desc = {
    Text = "Der Gegner wird am Ende seines Zuges seine Hand nicht abwerfen. Am Ende des Zuges füge nacheinander 2 Schichten <FragileIconKeywords: Zerbrechlich>, <WeaknessIconKeywords: Schwäche>, <HeavyInjuryKeywords: Blight> und <VulnerabilityIconKeywords: Verwundbar> hinzu."
  },
  State_148513_Name = {
    Text = "Stimmen aus dem Jenseits"
  },
  State_148520_Desc = {
    Text = "Kann bis zum Ende des Zuges kein Schild erhalten."
  },
  State_148520_Name = {
    Text = "Fesseln der Feindschaft"
  },
  State_148522_Desc = {
    Text = "Team Unique: Schild und Stärke der „Verherrlichung“ des Ausrüsters erhöhen sich um <WeaponEffect_Num:[StateArg1]%>."
  },
  State_148524_Desc = {
    Text = "Team Unique: Schild und Stärke der „Verherrlichung“ des Ausrüsters erhöhen sich um <WeaponEffect_Num:[StateArg1]%>. Die Schild-Verstärkung der „Verteidigung“ des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg2]%>. Nach dem Spielen von „Verteidigung“ erhält der Ausrüster Stärke in Höhe von <WeaponEffect_Num:[StateArg3]%> seiner ANG."
  },
  State_148540_Desc = {
    Text = "Latenz[Layer]: Die Arithmetica-Kosten der [StateArg1] Befehlskarten mit der höchsten Arithmetica von <AwakerName:[DescArg1]> werden um [StateArg2] gesenkt."
  },
  State_148540_Name = {
    Text = "Spiegel der Voraussicht – Latenz[Layer]"
  },
  State_148541_Name = {
    Text = "Entferne den „Stagnierung“-Effekt von der Karte des ausgewählten Erweckers auf der Hand"
  },
  State_148544_Desc = {
    Text = "Latenz[Layer] : Beim nächsten Verherrlichung von <AwakerName:[DescArg1]> wird für jeden verbrauchten Punkt Aliemus [StateArg1] Punkte Keyflare gewonnen."
  },
  State_148544_Name = {
    Text = "Schlüssel der Goetia – Latenz[Layer]"
  },
  State_148547_Desc = {
    Text = "Die nächste Verherrlichung von <AwakerName:[DescArg1]> gilt als Übertriebene Verherrlichung. Falls sie bereits eine Übertriebene Verherrlichung ist, werden 100% Basis-Aliemus zurückerstattet."
  },
  State_148547_Name = {
    Text = "Ewigkeitskrone"
  },
  State_148548_Desc = {
    Text = "Behalten: Alle Erwecker erhalten 5 Aliemus."
  },
  State_148548_Name = {
    Text = "In Reflexion versunken"
  },
  State_148549_Name = {
    Text = "Alle „Vorbereiten“-Effekte auf der Hand auslösen"
  },
  State_148553_Desc = {
    Text = "Latenz[Layer]: Die nächsten [Layer] Befehlskarten, die <AwakerName:[DescArg1]> spielt, erhalten ein Schild in Höhe von [StateArg2]% der verlorenen LP."
  },
  State_148553_Name = {
    Text = "Frucht der Versuchung – Latenz[Layer]"
  },
  State_148554_Desc = {
    Text = "Der Schaden der Befehlskarten von <AwakerName:[DescArg1]> fügt [Layer]% Bluten hinzu."
  },
  State_148554_Name = {
    Text = "Auge des Verderbens"
  },
  State_148556_Desc = {
    Text = "Solange auf der Hand, verursachen alle Erwecker beim Austeilen von Aktivem Schaden zusätzlich 10% Bluten."
  },
  State_148556_Name = {
    Text = "Ein vorhergesagter Albtraum"
  },
  State_148557_Desc = {
    Text = "Die nächsten [Layer] Befehlskarten, die <AwakerName:[DescArg1]> spielt, erhalten ein Schild in Höhe von [StateArg1]% der verlorenen LP."
  },
  State_148557_Name = {
    Text = "Frucht der Versuchung"
  },
  State_148559_Desc = {
    Text = "Beim nächsten Verherrlichung von <AwakerName:[DescArg1]> wird für jeden verbrauchten Punkt Aliemus [Layer] Punkte Keyflare gewonnen."
  },
  State_148559_Name = {
    Text = "Schlüssel der Goetia"
  },
  State_148561_Desc = {
    Text = "Wenn diese Karte gespielt wird, wird zufällig einer der folgenden drei negativen Effekte ausgelöst: Effekt um 50% reduziert / Latenz 2 Runden bis zur Wirkung / zufällig 1 negativen Effekt erhalten."
  },
  State_148561_Name = {
    Text = "<ExclamationPointColour:Verdrehter Wunsch>"
  },
  State_148562_Name = {
    Text = "Der gewählte Erwecker erhält 10 Punkte Aliemus"
  },
  State_148563_Desc = {
    Text = "Latenz[Layer]: Der Schild und die LP-Heilungs-Verstärkung, die <AwakerName:[DescArg1]> bei der nächsten Verherrlichung erhält, werden um [StateArg1]% erhöht."
  },
  State_148563_Name = {
    Text = "Feder der Gerechtigkeit – Latenz[Layer]"
  },
  State_148566_Desc = {
    Text = "Der Schaden der nächsten Verherrlichung von <AwakerName:[DescArg1]> fügt [Layer]% Endgültiges Urteil hinzu."
  },
  State_148566_Name = {
    Text = "Faden des Schicksals"
  },
  State_148569_Desc = {
    Text = "Der Schild und die LP-Heilungs-Verstärkung, die <AwakerName:[DescArg1]> bei der nächsten Verherrlichung erhält, werden um [Layer]% erhöht."
  },
  State_148569_Name = {
    Text = "Feder der Gerechtigkeit"
  },
  State_148571_Desc = {
    Text = "Latenz[Layer] : Der Schaden der Befehlskarten von <AwakerName:[DescArg1]> fügt [StateArg1]% Bluten hinzu."
  },
  State_148571_Name = {
    Text = "Auge des Verderbens – Latenz[Layer]"
  },
  State_148574_Desc = {
    Text = "Latenz[Layer] : Der Schaden der nächsten Verherrlichung von <AwakerName:[DescArg1]> fügt [StateArg1]% Endgültiges Urteil hinzu."
  },
  State_148574_Name = {
    Text = "Faden des Schicksals – Latenz[Layer]"
  },
  State_148575_Name = {
    Text = "Der gewählte Erwecker erhält 20 Punkte Aliemus"
  },
  State_149089_Name = {
    Text = "Zustand@Laternen-Hund Kleines Fress-Aliemus-Kennzeichen"
  },
  State_149092_Desc = {
    Text = "Hat <Energy:[Energy:DescArg2]> Aliemus von „<AwakerName:[DescArg1]>“ verschluckt. Nach dem Tod wird es zurückgegeben."
  },
  State_149092_Name = {
    Text = "Verschlingen"
  },
  State_149094_Desc = {
    Text = "Team Unique: Der Basis-Schild, der durch die Verherrlichung des Ausrüsters erzeugt wird, +<WeaponEffect_Num:[StateArg1]%>. Nachdem der Ausrüster eine Befehlskarte gespielt hat, die ein Symptom: Schwäche verursacht, erhöht sich der Basis-Schild der nächsten Ausrüstungs-Befehlskarte um +<WeaknessIconKeywords:Schwäche>... Warte – der Basis-Schild der nächsten Ausrüstungs-Befehlskarte +<WeaponEffect_Num:[StateArg1]%>. Nicht stapelbar. Bei Verwendung von „Blutroter Ofen\" wird die Fähigkeitskarte des Ausrüsters mit den höchsten Arithmetica-Kosten gezogen, Embryofusion +<EmbryoFusionIconKeywords:Embryofusion>... +<WeaponEffect_Num:[StateArg1]%>, 3 Runden Abklingzeit."
  },
  State_149094_WeaponDesc = {
    Text = "Der Basis-Schild der Verherrlichung des Ausrüsters +<WeaponEffect_Num:[StateArg1]%>. Nachdem der Ausrüster eine Befehlskarte gespielt hat, die <WeaknessIconKeywords:Symptom: Schwäche> verursacht, erhöht sich der Befehlskarten-Basis-Schild des Ausrüsters um +<WeaponEffect_Num:[StateArg1]%>. Bei Verwendung von „Blutroter Ofen\" wird die Fähigkeitskarte des Ausrüsters mit den höchsten Arithmetica-Kosten gezogen, Embryofusion +<EmbryoFusionIconKeywords:><WeaponEffect_Num: [StateArg1]>, 3-Runden-Abklingzeit."
  },
  State_149122_Desc = {
    Text = "Beim Tod wird sofort 1 zufälliger „Laternen-Hund“ beschworen, dessen „Schwarmeffekt“ um 1 Stapelung reduziert ist."
  },
  State_149122_Name = {
    Text = "Schwarmeffekt"
  },
  State_149123_Desc = {
    Text = "Erlittener Schaden durch Verherrlichung wird um 50% reduziert."
  },
  State_149123_Name = {
    Text = "Schattenlaterne-Mod"
  },
  State_149124_Desc = {
    Text = "Erlittener Schaden durch Befehlskarten wird um 50% reduziert."
  },
  State_149124_Name = {
    Text = "Gletscherlaterne-Mod"
  },
  State_149125_Desc = {
    Text = "Hat die Befehlskarte von „<AwakerName:[DescArg1]>“ eingefroren. Nach dem Tod wird das Einfrieren dieses Erweckers aufgehoben."
  },
  State_149125_Name = {
    Text = "Verschlingen"
  },
  State_149126_Desc = {
    Text = "Beim Tod wird sofort 1 zufälliger „Laternen-Hund“ beschworen, dessen „Schwarmeffekt“ um 1 Stapelung reduziert ist."
  },
  State_149126_Name = {
    Text = "Schwarmeffekt"
  },
  State_149128_Name = {
    Text = "Zustand@Eis-Laternen-Hund Kleines Einfrieren-Karten-Kennzeichen"
  },
  State_149140_Desc = {
    Text = "Verstärkt die Fähigkeiten des Feindes. Verliert eine Schicht bei Schaden"
  },
  State_149140_Name = {Text = "Blutsegen"},
  State_149143_Desc = {
    Text = "Nach Ende der Ziehphase erhält man für je [DescArg1] <SlowIconKeywords:Stagnierung>-Befehlskarten in der gegnerischen Hand [DescArg2] Stapelungen <BloodOath_New:Blutsegen>. Nachdem man ungeblockten Schaden verursacht hat, werden zufällig [DescArg3] Befehlskarten in der Hand oder im Ziehstapel, die noch nicht von <SlowIconKeywords:Stagnierung> betroffen sind, mit [DescArg4] Stapelungen <SlowIconKeywords:Stagnierung> belegt."
  },
  State_149143_Name = {
    Text = "Gefrorenes Gelübde"
  },
  State_149162_Desc = {
    Text = "Beim Verursachen von ungebloctem Schaden wird Todwiderstand entfernt."
  },
  State_149162_Name = {
    Text = "Fernöstliche Hexenkunst"
  },
  State_149163_Desc = {
    Text = "Max LP werden um die entsprechende Anzahl an Stapelungen gesenkt. Nach dem Kampf wird der Wert halbiert."
  },
  State_149163_Name = {
    Text = "<BoneHitKeywords:Scathe>"
  },
  State_149164_Desc = {
    Text = "Beim Verursachen von Schaden wird Scathe angewendet."
  },
  State_149164_Name = {
    Text = "Durchdringende Kälte"
  },
  State_149167_Desc = {
    Text = "Max LP um [Layer] gesenkt, nach dem Kampf halbiert."
  },
  State_149167_Name = {
    Text = "<BoneHitKeywords:Scathe>"
  },
  State_149169_Desc = {
    Text = "Jede Stapel erhöht die Max LP um 10% von Caraboos KON (max. 50 Stapelungen). Bei maximalen Stapelungen heilen überschüssige Stapelungen stattdessen um das 3-Fache dieses LP-Wertes. Pro Nicht-Boss-Kampf können bis zu 10 Stapelungen „Sattheit“ erhalten werden. „Sattheit“ bleibt zwischen Kämpfen erhalten."
  },
  State_149169_Name = {
    Text = "<WormGrowth:Mahl>"
  },
  State_149172_Desc = {
    Text = "Team Unique: Nachdem der Ausrüster eine Befehlskarte spielt, die <WeaknessIconKeywords:Symptom: Schwäche> verursacht, erhöht sich der Basis-Schild der nächsten Ausrüstungs-Befehlskarte um +<WeaponEffect_Num:[StateArg1]%>. Kann nicht gestapelt werden."
  },
  State_149172_WeaponDesc = {
    Text = "Nachdem der Ausrüster eine Befehlskarte spielt, die <WeaknessIconKeywords:Symptom: Schwäche> verursacht, erhöht sich der Basis-Schild seiner nächsten Befehlskarte um +<WeaponEffect_Num:[StateArg1]%>."
  },
  State_149187_Desc = {
    Text = "Test | Überwacht den Erhalt von Festgesetztem Schaden und das Töten durch Festgesetzten Schaden, und gibt den Auslösewert sowie den Verknüpften aus."
  },
  State_149187_Name = {
    Text = "Test Festgesetzter Schaden"
  },
  State_149188_Desc = {
    Text = "Test｜Nach einem Töten durch Festgesetzten Schaden, Auslösewert 1, tatsächlicher Schaden beim Töten: [Layer]"
  },
  State_149188_Name = {
    Text = "Test Festtöten-Auslösewert 2"
  },
  State_149189_Desc = {
    Text = "Test | Nach dem Töten durch Festgesetzten Schaden, Verknüpfter 2, Quelle des Tötens: [Layer]"
  },
  State_149189_Name = {
    Text = "Test Festtöten-Verknüpfter 2"
  },
  State_149190_Desc = {
    Text = "Test｜Nach einem Töten durch Festgesetzten Schaden, Auslösewert 1, überschüssiger Schaden beim Töten: [Layer]"
  },
  State_149190_Name = {
    Text = "Test Festgesetztes Töten Auslösewert 3"
  },
  State_149191_Desc = {
    Text = "Test | Nach Erhalt von Festgesetztem Schaden, Auslösewert 1, Gesamtschaden: [Layer]"
  },
  State_149191_Name = {
    Text = "Test Festschaden-Auslösewert 1"
  },
  State_149192_Desc = {
    Text = "Test | Nach dem Töten durch Festgesetzten Schaden, Verknüpfter 1, Getöteter: [Layer]"
  },
  State_149192_Name = {
    Text = "Test Festtöten-Verknüpfter 1"
  },
  State_149193_Desc = {
    Text = "Test | Nach Erhalt von Festgesetztem Schaden, Verknüpfter 2, Getroffener: [Layer]"
  },
  State_149193_Name = {
    Text = "Test Festschaden-Verknüpfter 2"
  },
  State_149194_Desc = {
    Text = "Test | Nach Erhalt von Festgesetztem Schaden, Auslösewert 1, Gesamtschaden: [Layer]"
  },
  State_149194_Name = {
    Text = "Test Festschaden-Auslösewert 2"
  },
  State_149195_Desc = {
    Text = "Test | Nach dem Töten durch Festgesetzten Schaden, Auslösewert 1, Gesamtschaden beim Töten: [Layer]"
  },
  State_149195_Name = {
    Text = "Test Festtöten-Auslösewert 1"
  },
  State_149196_Desc = {
    Text = "Test | Nach Erhalt von Festgesetztem Schaden, Verknüpfter 1, Schadensquelle: [Layer]"
  },
  State_149196_Name = {
    Text = "Test Festschaden-Verknüpfter 1"
  },
  State_149227_Desc = {
    Text = "Am Rundenende verschwindet das Schild nicht. Bei vorhandenem Schild wird erlittener Verherrlichungs-SCH um 50% verstärkt, erlittener Schaden durch Befehlskarten um 50% gesenkt."
  },
  State_149227_Name = {
    Text = "Gletschermantel"
  },
  State_149228_Desc = {
    Text = "Beim Verursachen von Schaden wird Bluten angewendet."
  },
  State_149228_Name = {
    Text = "Blutiger Durchstoß"
  },
  State_149229_Desc = {
    Text = "Beim Erscheinen 25% Max LP verlieren, in ein „Frostschild“ im Wert von [DescArg1]% des verlorenen Wertes umwandeln."
  },
  State_149229_Name = {
    Text = "Frostschild-Umwandlung"
  },
  State_149230_Desc = {
    Text = "Erlittener Schaden durch Befehlskarten um 50% verstärkt, erlittener Verherrlichungs-SCH um 50% gesenkt."
  },
  State_149230_Name = {
    Text = "Zustand@Schattenhülle SCH-Verstärkung/-Senkung"
  },
  State_149232_Desc = {
    Text = "Am Rundenende verschwindet das Schild nicht. Bei vorhandenem Schild wird erlittener Schaden durch Befehlskarten um 50% verstärkt, erlittener Verherrlichungs-SCH um 50% gesenkt."
  },
  State_149232_Name = {
    Text = "Schattenhülle"
  },
  State_149233_Desc = {
    Text = "Erlittener Verherrlichungs-SCH um 50% verstärkt, erlittener Schaden durch Befehlskarten um 50% gesenkt."
  },
  State_149233_Name = {
    Text = "Zustand@Gletschermantel SCH-Verstärkung/-Senkung"
  },
  State_149234_Desc = {
    Text = "Beim Erscheinen 25% Max LP verlieren, in eine „Verfluchte Wacht“ im Wert von [DescArg1]% des verlorenen Wertes umwandeln."
  },
  State_149234_Name = {
    Text = "Verfluchte Wacht-Umwandlung"
  },
  State_149235_Desc = {
    Text = "Beim Verursachen von ungebloctem Schaden wird Todwiderstand entfernt."
  },
  State_149235_Name = {
    Text = "Laternen-Zauberei"
  },
  State_149250_Desc = {
    Text = "Erlittener Befehlskartenschaden +50%"
  },
  State_149250_Name = {
    Text = "Erlittener Befehlskartenschaden +50%"
  },
  State_149251_Desc = {
    Text = "Erlittener Befehlskartenschaden –50%"
  },
  State_149251_Name = {
    Text = "Erlittener Befehlskartenschaden –50%"
  },
  State_149252_Desc = {
    Text = "Erlittener Verherrlichungsschaden –50%"
  },
  State_149252_Name = {
    Text = "Erlittener Verherrlichungsschaden –50%"
  },
  State_149253_Desc = {
    Text = "Erlittener Verherrlichungsschaden +50%"
  },
  State_149253_Name = {
    Text = "Erlittener Verherrlichungsschaden +50%"
  },
  State_149265_Desc = {
    Text = "Nach dem Tod wird sofort ein zufälliger „Wendigo“ beschworen, dessen „Schwarmeffekt“ um 1 Stapel verringert wird."
  },
  State_149265_Name = {
    Text = "Schwarmeffekt"
  },
  State_149268_Desc = {
    Text = "Beim Verlust aller Schilde: Erhalte 75 Stapel vorübergehender Festung und entferne 1 Stapel „Blizzardhülle“, ersetze die Absicht durch einen starken Angriff, der <BoneHitKeywords:Scathe> verursacht."
  },
  State_149268_Name = {
    Text = "Blizzardhülle"
  },
  State_149269_Desc = {
    Text = "Beim Verlust aller Schilde: Erhalte 75 Stapel vorübergehender Festung und entferne 1 Stapel „Schattenhülle“, ersetze die Absicht durch einen starken Angriff, der Aliemus entzieht."
  },
  State_149269_Name = {
    Text = "Schattenhülle"
  },
  State_149270_Desc = {
    Text = "Nach dem Tod wird sofort ein zufälliger „Wendigo“ beschworen, dessen „Schwarmeffekt“ um 1 Stapel verringert wird."
  },
  State_149270_Name = {
    Text = "Schwarmeffekt"
  },
  State_149308_Name = {
    Text = "Zustand@Laternen-Beter Stagnierung-Stapelungen-Aufzeichnung"
  },
  State_149391_Desc = {
    Text = "Dieser Erwecker hat noch keine Erweckung erfahren... Wenn er kurz vor der Niederlage steht, werden LP wiederhergestellt und er erhält 1 Stapelung <InvincibleUntilRoused:Undurchdringliche Panzerung>. Nach der Erweckung wird <InvincibleUntilRoused:Undurchdringliche Panzerung> entfernt und er beginnt den Kampf in seiner wahren Form."
  },
  State_149391_Name = {
    Text = "Nicht erweckt"
  },
  State_149398_Desc = {
    Text = "Wenn „Schneewittchen die Fee“ die Absicht zu „Schneefluch“ wechselt, wird 1 Stapel verbraucht und die Absicht zu „Wundersamer Segen“ geändert."
  },
  State_149398_Name = {Text = "Mahl"},
  State_149399_Desc = {
    Text = "Nachdem „Schneewittchen die Fee“ „Makelloses Märchen“ einsetzt, sind die nächsten [DescArg1] Absichten „Schneefluch“. Jede Runde werden [DescArg2] zufällige <Blessing:Segen> mit [DescArg3] Stapeln <SlowIconKeywords:Stagnierung> in das Deck gemischt."
  },
  State_149399_Name = {
    Text = "Verführerische Honigsüße"
  },
  State_149418_Desc = {
    Text = "kann keinen Kritischen Treffer erzielen, gilt nicht als Grundschaden und wird nicht durch Gesamtschaden oder ähnliche Boni beeinflusst."
  },
  State_149418_Name = {
    Text = "<RealDamage:Fixschaden>"
  },
  State_149419_Name = {
    Text = "<Rune_6:Eiserne Mauer>"
  },
  State_149420_Name = {
    Text = "<Rune_3:Geschick>"
  },
  State_149421_Name = {
    Text = "<Rune_15:Explosion>"
  },
  State_149422_Name = {
    Text = "<Rune_4:Planung>"
  },
  State_149423_Name = {
    Text = "<Rune_11:Herrschaft>"
  },
  State_149424_Name = {
    Text = "<Rune_12:Blutrausch>"
  },
  State_149425_Name = {
    Text = "<Rune_1:Verwundbarkeit>"
  },
  State_149426_Name = {
    Text = "<Rune_14:Brutalität>"
  },
  State_149427_Name = {
    Text = "<Rune_2:Schwäche>"
  },
  State_149428_Name = {
    Text = "<Rune_9:Spieß>"
  },
  State_149429_Name = {
    Text = "<Rune_10:Gift>"
  },
  State_149430_Name = {
    Text = "<Rune_18:Erschöpfung>"
  },
  State_149576_Desc = {
    Text = "Wenn „Schneewittchen die Fee“ die Absicht zu „Schneefluch“ wechselt, wird 1 Stapel verbraucht und die Absicht zu „Wundersamer Segen“ geändert."
  },
  State_149576_Name = {Text = "Mahl"},
  State_149618_Desc = {
    Text = "Nach 2 Runden werden folgende Effekte ausgelöst:\nErhalte [DescArg1] Punkte Arithmetica. \nErhalte [DescArg2] Punkte Stärke. \nErhalte [DescArg3] Punkte Keyflare. \nErhalte [DescArg5] Punkte Aliemus. \n[DescArg6] Karte(n) ziehen.\nErhalte [DescArg7] Punkte vorübergehende Schadenamplifikation.\nAlle Feinde verlieren vorübergehend [DescArg4] Punkte Stärke."
  },
  State_149618_Name = {
    Text = "Verpasste Gelegenheit2"
  },
  State_149619_Desc = {
    Text = "Nach 1 Runde werden folgende Effekte ausgelöst:\nErhalte [DescArg1] Punkte Arithmetica. \nErhalte [DescArg2] Punkte Stärke. \nErhalte [DescArg3] Punkte Keyflare. \nErhalte [DescArg5] Punkte Aliemus. \n[DescArg6] Karte(n) ziehen.\nErhalte [DescArg7] Punkte vorübergehende Schadenamplifikation.\nAlle Feinde verlieren vorübergehend [DescArg4] Punkte Stärke."
  },
  State_149619_Name = {
    Text = "Verpasste Gelegenheit1"
  },
  State_149628_Desc = {
    Text = "Falls die feindliche Seite vor Rundenende mindestens 1000 Keyflare besitzt, Verschlingen von 1000 Keyflare."
  },
  State_149628_Name = {
    Text = "Keyflare opfern"
  },
  State_149629_Desc = {
    Text = "Falls der Erwecker mit dem höchsten Aliemus vor Rundenende mindestens 100 Punkte Aliemus besitzt, Verschlingen von 50 Punkten Aliemus."
  },
  State_149629_Name = {
    Text = "Aliemus opfern"
  },
  State_149630_Desc = {
    Text = "Falls die feindliche Seite vor Rundenende mindestens 1000 Keyflare besitzt, Verschlingen von 1000 Keyflare."
  },
  State_149630_Name = {
    Text = "Keyflare opfern"
  },
  State_149631_Desc = {
    Text = "Falls der Feind vor Rundenende mindestens 3 Punkte Arithmetica besitzt, werden 3 Punkte Arithmetica verschlungen."
  },
  State_149631_Name = {
    Text = "Arithmetica opfern"
  },
  State_149632_Desc = {
    Text = "Falls der Feind vor Rundenende mindestens 3 Punkte Arithmetica besitzt, werden 3 Punkte Arithmetica verschlungen."
  },
  State_149632_Name = {
    Text = "Arithmetica opfern"
  },
  State_149633_Desc = {
    Text = "Falls die feindliche Seite vor der Abwurfphase mindestens 4 Befehlskarten auf der Hand hat, Verschlingen von zufällig 2 Befehlskarten."
  },
  State_149633_Name = {
    Text = "Karten opfern"
  },
  State_149634_Desc = {
    Text = "Falls die feindliche Seite vor der Abwurfphase mindestens 4 Befehlskarten auf der Hand hat, Verschlingen von zufällig 2 Befehlskarten."
  },
  State_149634_Name = {
    Text = "Karten opfern"
  },
  State_149635_Desc = {
    Text = "Falls der Erwecker mit dem höchsten Aliemus vor Rundenende mindestens 100 Punkte Aliemus besitzt, Verschlingen von 50 Punkten Aliemus."
  },
  State_149635_Name = {
    Text = "Aliemus opfern"
  },
  State_149652_Desc = {
    Text = "Kann keinen Kritischen Treffer erzielen und gilt nicht als Schaden, der vom entsprechenden Erwecker ausgeteilt wird."
  },
  State_149652_Name = {
    Text = "<FixedDamage:Reiner SCH>"
  },
  State_149660_Desc = {
    Text = "Schaden, Schild und Stärkeänderungen dieser Karte werden um [DescArg2]% erhöht, der finale Effekt von Tentakelschaden, LP-Antworten, festem Gift und festem Gegenangriff wird um [DescArg1]% erhöht, wird nach dem Spielen entfernt."
  },
  State_149660_Name = {
    Text = "Verstärkung [DescArg1]"
  },
  State_149664_Desc = {
    Text = "Pro vorhandener Lage wird der Schaden dieser Karte, feste Stärke und SCH-Verstärkung durch Tentakelschaden, festes Gift sowie der finale Effekt von festem Gegenangriff um 2% erhöht; der finale Effekt von festem Schild, fester LP-Wiederherstellung und STR▼ wird um 1% erhöht, wird nach dem Spielen entfernt."
  },
  State_149664_Name = {
    Text = "Verstärkung"
  },
  State_149719_Name = {
    Text = "Immun gegen PVP Reiner SCH__„Nur für Entwicklung“"
  },
  State_149736_Desc = {
    Text = "Die nächsten [Layer] Befehlskarten von <AwakerName:[DescArg1]> erhalten einen um [StateArg1]% erhöhten Basis-Schild."
  },
  State_149736_Name = {
    Text = "Honigsüße Täuschung"
  },
  State_149744_Desc = {
    Text = "Der nächste gespielte Segen löst keinen negativen Effekt aus"
  },
  State_149744_Name = {
    Text = "Debuff-Immunität"
  },
  State_149772_Desc = {
    Text = "Jedes Mal, wenn Aktiver Schaden erlitten wird, verlieren alle Erwecker 3 Aliemus. Löst höchstens 5 Mal pro Runde aus. Entfernt den Zustand „Verfluchte Wacht“, nachdem das Schild gebrochen wurde."
  },
  State_149772_Name = {
    Text = "Verfluchte Wacht"
  },
  State_149773_Desc = {
    Text = "Jedes Mal, wenn Aktiver Schaden erlitten wird, wird 1 zufälligen Karte in der Hand 1 Stapelung vorübergehende „Stagnierung“ zugefügt. Löst höchstens 5 Mal pro Runde aus. Entfernt „Frostschild“, nachdem das Schild gebrochen wurde."
  },
  State_149773_Name = {
    Text = "Frostschild"
  },
  State_149782_Desc = {
    Text = "Erschöpfen: Nach dem Ziehen von Karten in der nächsten Runde 1 „Wandlungsfrucht“ in den Ziehstapel mischen."
  },
  State_149782_Name = {
    Text = "Wandlungsfrucht"
  },
  State_149787_Desc = {
    Text = "Pro Stapel erhöht sich der Gesamtschaden der Befehlskarten von Eidbrecher·Ogier um [DescArg2]%, die Anzahl der gezogenen Karten zu Rundenbeginn wird um 1 verringert, Krit. Schaden erhöht sich um [DescArg3]%, Maximum [DescArg1] Stapel, wird am Kampfende nicht entfernt."
  },
  State_149787_Name = {
    Text = "<KuangNu:Dunkle Strömung>"
  },
  State_149788_Desc = {
    Text = "Beim Spielen von Eidbrecher·Ogiers „Fähigkeit“ 1 Stapelung verbrauchen, um 1 „Verteidigungs“-Karte zu ziehen, die vor dem nächsten Spielen Behalten erhält. Maximal [DescArg1] Stapelungen. Wird am Ende des Kampfes nicht zurückgesetzt."
  },
  State_149788_Name = {
    Text = "<ShuZui:Selbstvorwurf>"
  },
  State_149789_Desc = {
    Text = "Pro Stapel erhöht sich der Gesamtschaden der Befehlskarten von Eidbrecher·Ogier um 33%, die Anzahl der gezogenen Karten zu Rundenbeginn wird um 1 verringert, Maximum [DescArg1] Stapel, wird am Kampfende nicht entfernt."
  },
  State_149789_Name = {
    Text = "<KuangNu:Dunkle Strömung>"
  },
  State_149790_Desc = {
    Text = "Pro Stapel erhöht sich der Gesamtschaden der Befehlskarten von Eidbrecher·Ogier um [DescArg2]%, die Anzahl der gezogenen Karten zu Rundenbeginn wird um 1 verringert, Maximum [DescArg1] Stapel, wird am Kampfende nicht entfernt."
  },
  State_149790_Name = {
    Text = "<KuangNu:Dunkle Strömung>"
  },
  State_149791_Desc = {
    Text = "Beim Spielen von Eidbrecher·Ogiers „Fähigkeit“ 1 Stapelung verbrauchen, um 1 „Verteidigungs“-Karte zu ziehen, die vor dem nächsten Spielen Behalten erhält. Maximal [DescArg1] Stapelungen. Wird am Ende des Kampfes nicht zurückgesetzt."
  },
  State_149791_Name = {
    Text = "<ShuZui:Selbstvorwurf>"
  },
  State_149814_Desc = {
    Text = "Temp. Schadenamplifikation +[Layer]."
  },
  State_149814_Name = {
    Text = "Vorübergehende Schadenamplifikation"
  },
  State_149819_Desc = {
    Text = "Immun gegen jeglichen Schaden"
  },
  State_149819_Name = {Text = "Immun"},
  State_149892_Desc = {
    Text = "Die nächsten [Layer] Befehlskarten von <AwakerName:[DescArg1]> erhalten einen um [StateArg1]% erhöhten Basis-Schild."
  },
  State_149892_Name = {
    Text = "Schöne Wahrheit"
  },
  State_149913_Name = {
    Text = "Zustand@Makrophagen-Wurm-Schatz Effekt_Tinct Beschädigt"
  },
  State_149914_Name = {
    Text = "State@Macrophage Worm Treasure Effect_William Damaged"
  },
  State_149915_Name = {
    Text = "State@Macrophage Worm Treasure Effect_William"
  },
  State_149916_Name = {
    Text = "State@Macrophage Worm Treasure Effect_Castor Damaged"
  },
  State_149917_Name = {
    Text = "Zustand@Makrophagen-Wurm-Schatz Effekt_Blutkette Helot Beschädigt"
  },
  State_149918_Name = {
    Text = "Zustand@Makrophagen-Wurm-Schatz Rundenstart-Test"
  },
  State_149919_Name = {
    Text = "Zustand@Makrophagen-Wurm-Schatz Effekt_Tinct"
  },
  State_149920_Name = {
    Text = "Zustand@Makrophagen-Wurm-Schatz Effekt_Arachne"
  },
  State_149921_Name = {
    Text = "Zustand@Makrophagen-Wurm-Schatz Effekt_Arachne Beschädigt"
  },
  State_149922_Name = {
    Text = "State@Macrophage Worm Treasure Effect_Castor"
  },
  State_149923_Name = {
    Text = "Zustand@Makrophagen-Wurm-Schatz Effekt_Blutkette Helot"
  },
  State_149930_Desc = {
    Text = "Pro Stapelung wird der Gesamtschaden der Befehlskarten von Eidbrecher·Ogier um 50% erhöht. Zu Beginn der Runde Ziehanzahl –1. Maximal [DescArg1] Stapelungen. Wird am Ende des Kampfes nicht zurückgesetzt."
  },
  State_149930_Name = {
    Text = "<KuangNu2:Dunkle Strömung>"
  },
  State_149931_Desc = {
    Text = "Es gibt 7 Arten von Effekten, darunter: STR erhalten, Blutroter Ofen-Antworten ansammeln, alle Erwecker erhalten Aliemus, Embryofusion-Verstärkung, Karten ziehen, Keyflare erhalten und vorübergehende Schadenamplifikation-Verstärkung."
  },
  State_149931_Name = {
    Text = "<Blessing:Segen>"
  },
  State_149933_Name = {
    Text = "State@Monster Caraboo Offering Bubble"
  },
  State_149934_Name = {
    Text = "State@Monster Caraboo Offering Bubble"
  },
  State_149939_Desc = {
    Text = "Kann bis zum Ende des Zuges kein Schild erhalten."
  },
  State_149939_Name = {
    Text = "Blutige Fesseln"
  },
  State_19507_Desc = {
    Text = "Der erlittene aktive Angriffsschaden vor Beginn der nächsten Runde erhöht sich um 25%, wird bei der Anwendung mit verstärkt ausgeglichen"
  },
  State_19507_Name = {
    Text = "<PVPVulnerabilityIconColour:Verwundbarkeit>"
  },
  State_19508_Desc = {
    Text = "Am Ende der Runde, wirf diese Karte ab"
  },
  State_19508_Name = {
    Text = "<PVPVoidKeyColour:Nichtigkeit>"
  },
  State_19509_Desc = {
    Text = "Temporäre Änderung der Kartenrechenleistung."
  },
  State_19509_Name = {
    Text = "Permanente Änderung der Karten-Rechenleistung"
  },
  State_19511_Desc = {
    Text = "Ersetze die Handkarten nach dem Tod durch Illusion"
  },
  State_19511_Name = {
    Text = "Todesschaden Handkartenwechsel Illusion Auslöser"
  },
  State_19513_Name = {
    Text = "Todeskampf anwenden"
  },
  State_19516_Name = {
    Text = "Temporäre Änderung der Kartenrechenleistung"
  },
  State_19517_Desc = {
    Text = "Erhalte 1 Punkt Aelius für jeden Verlust von 2% LP"
  },
  State_19517_Name = {
    Text = "Erhalte Wut bei Erhalt von Schaden"
  },
  State_19519_Desc = {
    Text = "Nach Verwendung von “Schlag“ werden alle Schichten verbraucht, jede Schicht erhöht den Schaden dieses “Schlags“ um 50%, maximal 10 Schichten stapelbar. (Aktuell erhöht um [DescArg1]% )"
  },
  State_19519_Name = {Text = "Aufladen"},
  State_19521_Desc = {
    Text = "Jede Schicht erhöht den Schaden im Kampf um 1, nicht entfernbar"
  },
  State_19521_Name = {
    Text = "<PowerColourKeywords:Kraft>"
  },
  State_19522_Name = {
    Text = "Temporäre Änderung der Kartenrechenleistung"
  },
  State_19523_Name = {
    Text = "Permanente Änderung der Karten-Rechenleistung"
  },
  State_19524_Desc = {
    Text = "Vor Beginn des nächsten Zuges füge bei jedem Angriff dem Angreifer [Layer] Schaden zu"
  },
  State_19524_Name = {
    Text = "Gegenangriff"
  },
  State_19525_Desc = {
    Text = "Vor Beginn der Runde, entferne den Erwachensschild"
  },
  State_19525_Name = {
    Text = "Vor Beginn der Runde, entferne den Rollen-Schild"
  },
  State_19527_Desc = {
    Text = "Jede Stapellung erhöht die Arithmetica-Kosten von „Fähigkeiten\" in dieser Runde um +1, maximal 3 Stapelungen. Nach dem Spielen wird die Stapelanzahl um 1 verringert, wenn sie größer als 1 ist."
  },
  State_19527_Name = {
    Text = "<SlowColour:Verlangsamung>"
  },
  State_19528_Desc = {
    Text = "Besitze Karten mit starkem Effekt"
  },
  State_19528_Name = {
    Text = "<SilverKeyColour:Schlüsselbefehl>"
  },
  State_19529_Desc = {
    Text = "Jedes Mal, wenn du eine andere Karte spielst, reduziere die Arithmetica-Kosten dieser Karte für das nächste Spielen um 1; nach dem Spielen dieser Karte kehrt sie in deine Hand zurück und ihre Arithmetica-Kosten erhöhen sich um 1, dann wird sie am Rundenende abgeworfen."
  },
  State_19529_Name = {
    Text = "<CardKeyWord:Trugbild>"
  },
  State_19530_Desc = {
    Text = "·Wird von Gegnern priorisiert angegriffen und Gegner können nur den provozierenden Erwecker als Einzelziel wählen.\n·Beim Erlangen von Spott werden der eigene Schleich und der Spott anderer Verbündeter entfernt, während der Schleich der Feinde entfernt wird."
  },
  State_19530_Name = {
    Text = "<TauntColour:Spott>"
  },
  State_19532_Desc = {
    Text = "Der Schaden, der vor dem Ende dieser Runde verursacht wird, wird um [DescArg1] % reduziert, bei der Anwendung wird er durch die Verstärkung aufgehoben"
  },
  State_19532_Name = {Text = "Schwäche"},
  State_19533_Desc = {
    Text = "Der Schaden, der vor dem Ende dieser Runde verursacht wird, wird um 50 % reduziert, bei der Anwendung wird er durch die Verstärkung aufgehoben"
  },
  State_19533_Name = {
    Text = "<WeaknessColour:Schwäche>"
  },
  State_19534_Desc = {
    Text = "Der erlittene aktive Angriffsschaden vor Beginn der nächsten Runde erhöht sich um [DescArg1] %, wird bei der Anwendung mit verstärkt ausgeglichen"
  },
  State_19534_Name = {Text = "Verwundbar"},
  State_19535_Desc = {
    Text = "·Wird von Gegnern priorisiert angegriffen und kann nur als Ziel gewählt werden, wenn der Gegner den provozierenden Erwecker auswählt.\n·Beim Erlangen von Spott wird der eigene Schleich und der Spott anderer Verbündeter entfernt, während der Schleich der Feinde entfernt wird."
  },
  State_19535_Name = {Text = "Verspotten"},
  State_19536_Desc = {
    Text = "Am Ende der Runde erhältst du 10 Aliemus"
  },
  State_19536_Name = {
    Text = "Wahnsinns-Auslöser am Rundenende erhalten"
  },
  State_19537_Desc = {
    Text = "Schaden bis Rundenende um [DescArg1]% erhöht, schwächt Schwäche ab"
  },
  State_19537_Name = {
    Text = "Verstärkung"
  },
  State_19538_Desc = {
    Text = "·Zu Beginn von Runde 8 und 9 je 1 Schicht\n·Jede Schicht Todeskampf reduziert Schild- und Lebensregeneration um 50%, stapelbare Barriere-Schichten -1\n·Todeskampf nicht entfernbar und auch für tote Erweckte wirksam"
  },
  State_19538_Name = {Text = "Deathmatch"},
  State_19540_Name = {
    Text = "Arithmetica-Grenze"
  },
  State_19541_Desc = {
    Text = "Vor Rundenende, keine Aktionen möglich"
  },
  State_19541_Name = {
    Text = "Ohnmächtig"
  },
  State_19544_Desc = {
    Text = "Nach Verwendung von “Schlag“ werden alle Schichten verbraucht, jede Schicht erhöht den Schaden dieses “Schlags“ um 50%, maximal 10 Schichten stapelbar."
  },
  State_19544_Name = {
    Text = "<EnergyStorageColour:Aufladung>"
  },
  State_19545_Name = {
    Text = "Diese Karte wird als “Schlag“ betrachtet."
  },
  State_19546_Desc = {
    Text = "Ändere die Arithmetica der Karte vor dem Spielen."
  },
  State_19546_Name = {
    Text = "Ändere die Arithmetica Kosten der Karte vor dem Spielen"
  },
  State_19547_Desc = {
    Text = "Am Ende der Runde erleidet das Ziel [Layer] passiven Schaden, dauerhaft"
  },
  State_19547_Name = {Text = "Gift"},
  State_19549_Desc = {
    Text = "Vor Beginn des nächsten Zuges wird der erlittene aktive ANGsschaden um 50 % reduziert, bei Anwendung mit Verwundbarkeit aufgehoben"
  },
  State_19549_Name = {
    Text = "<ReinforceColour:verstärkt>"
  },
  State_19552_Desc = {
    Text = "Derzeit haben Sie [Layer] Punkte Schild, der Schild wird nicht höher als die maximale Gesundheit, und hält 1 Runde"
  },
  State_19552_Name = {Text = "Schild"},
  State_19553_Desc = {
    Text = "Nach der Ziehphase erhältst du Schlag zuletzt, schlag am besten"
  },
  State_19553_Name = {
    Text = "Schlag zuletzt, schlag am besten-Trigger"
  },
  State_19554_Name = {
    Text = "leerer Status"
  },
  State_19555_Desc = {
    Text = "·Die Arithmetica-Kosten von „Fähigkeiten\" in dieser Runde +[Layer], maximal 3 Stapelungen.\n·Nach dem Spielen einer „Fähigkeit\" wird die Stapelanzahl um 1 verringert, wenn sie größer als 1 ist."
  },
  State_19555_Name = {
    Text = "Stagnierung"
  },
  State_19556_Desc = {
    Text = "Am Ende der Runde wird die Arithmetica-Kosten dieser Karte um -[Layer] reduziert."
  },
  State_19556_Name = {
    Text = "<PrepareKeywords:Vorbereitung [Layer]>"
  },
  State_19557_Desc = {
    Text = "Vor Beginn der nächsten Runde wird der erlittene aktive ANGsschaden um [DescArg1] % reduziert, bei Anwendung wird er durch Verwundbarkeit aufgehoben."
  },
  State_19557_Name = {Text = "Festung"},
  State_19558_Name = {
    Text = "Wiederbelebung Kartenstapel Zieh-Auslöser"
  },
  State_19560_Desc = {
    Text = "Vor dem Ende der Runde kann Exaltieren nicht verwendet werden"
  },
  State_19560_Name = {Text = "Versiegelt"},
  State_19561_Name = {
    Text = ",kann 3 Mal verwendet werden"
  },
  State_19990_Desc = {
    Text = "Nach Beginn der nächsten Runde, erhalte [Layer] Wahnsinn"
  },
  State_19990_Name = {
    Text = "Verzögerter Wahnsinn"
  },
  State_19992_Desc = {
    Text = "Vor Rundenende keine Aktionen möglich; beim Versteinerungsanwendung erhält das Ziel Widerstand. Bei Vorhandensein von Widerstand wird der Effekt bei erneutem Ohnmächtig- oder Versteinerungseffekt abgebrochen und der Schaden verdoppelt. Dieser Zustand kann nicht beseitigt werden."
  },
  State_19992_Name = {
    Text = "<ComaColour:ohnmächtig>"
  },
  State_19995_Desc = {
    Text = "Am Ende der Runde füge passiven Schaden entsprechend der Stapelungen zu, dauerhaft"
  },
  State_19995_Name = {
    Text = "<IntoxicationColour:Vergiftung>"
  },
  State_19996_Desc = {
    Text = "Schaden bis Rundenende um 25% erhöht, schwächt Schwäche ab"
  },
  State_19996_Name = {
    Text = "<StrengthenColour:Stärken>"
  },
  State_19998_Desc = {
    Text = "Vor Beginn des nächsten Zuges füge bei jedem Angriff dem Angreifer eine entsprechende Anzahl an Stapelungen passiven Schadens zu"
  },
  State_19998_Name = {
    Text = "<RetaliateColour:Theke>"
  },
  State_20012_Desc = {
    Text = "Für jeden verbleibenden Arithmetica ziehst du zu Beginn der nächsten Runde 1 Karte; für jede Karte in der Hand erhältst du zu Beginn der nächsten Runde 1 Arithmetica"
  },
  State_20012_Name = {
    Text = "Verfremdung Vorurteilskapitel"
  },
  State_20012_WeaponDesc = {
    Text = "Für jeden verbleibenden Arithmetica ziehst du zu Beginn der nächsten Runde 1 Karte; für jede Karte in der Hand erhältst du zu Beginn der nächsten Runde 1 Arithmetica"
  },
  State_20013_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Reichsbeherrschung> +100. Die erste Karte jeder Runde zurück auf die Hand legen. Zu Beginn der Hyperrunde: Handkartenlimit +5 und deine Handkarten kopieren"
  },
  State_20013_Name = {
    Text = "Zustand @ Chrono-Pendel Spiegel"
  },
  State_20014_Name = {
    Text = "Zeitpendel„verloren\""
  },
  State_20016_Name = {
    Text = "Magische Handschuhe der Schöpfung"
  },
  State_20017_Desc = {
    Text = "Der nächste Sprungeffekt wird garantiert ausgelöst"
  },
  State_20017_Name = {Text = "Sprung"},
  State_20021_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Reichsbeherrschung> +100. Die erste Karte jeder Runde zurück auf die Hand legen. Zu Beginn der Hyperrunde: Handkartenlimit +5 und deine Handkarten kopieren"
  },
  State_20021_Name = {
    Text = "Zustand @ Chrono-Pendel Spiegel"
  },
  State_20023_Desc = {
    Text = "Zu Beginn des Kampfes werden zwei Wahnsinnsaufladungen ins Deck gemischt"
  },
  State_20023_Name = {
    Text = "Chaos-Hybrid"
  },
  State_20023_WeaponDesc = {
    Text = "Zu Beginn des Kampfes werden zwei Wahnsinnsaufladungen ins Deck gemischt"
  },
  State_20024_Desc = {
    Text = "Nach jeder Auslösung von Aelius erhältst du eine Karte, die [Arg1] Punkte Gift anwendet, „Toxische Kontamination“. Am Ende der Runde können, wenn du in der Hand jeweils 3 „Toxische Kontamination“ hast, eine Karte, die Gift auslöst, „Toxische Ausbreitung“ kombiniert werden"
  },
  State_20024_Name = {
    Text = "Status@Schöpfung Mutation Fremde Zunge"
  },
  State_20026_Desc = {
    Text = "Karten werden nicht in der Ablagephase in den Ablagestapel gelegt, sondern bleiben im Handkartenbereich und lösen nachfolgende Effekte aus."
  },
  State_20026_Name = {
    Text = "<RetainIconKeywords:Behalten>"
  },
  State_20026_WeaponDesc = {
    Text = "Nach dem Ausspielen wird die Karte nicht in den Ablagestapel gelegt und kann in diesem Kampf nicht erneut verwendet werden"
  },
  State_20028_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Reichsbeherrschung> erhöht um 100. Für jede gespielte Karte Embryofusion +10. Wenn die LP unter 25% fallen, erhöht sich auf 20. Maximal 10 Mal pro Runde aktiv."
  },
  State_20028_Name = {
    Text = "Zustand @ Chrono-Pendel Erschöpfung"
  },
  State_20029_Desc = {
    Text = "Nach jeder Auslösung von Aelius erhältst du eine Karte, die [Arg1] Punkte Gift anwendet, „Toxische Kontamination“. Am Ende der Runde können, wenn du in der Hand jeweils 3 „Toxische Kontamination“ hast, eine Karte, die Gift auslöst, „Toxische Ausbreitung“ kombiniert werden"
  },
  State_20029_Name = {
    Text = "Status@Schöpfung Mutation Fremde Zunge"
  },
  State_20035_Name = {
    Text = "Zustand @ Chrono-Pendel nicht schlafend"
  },
  State_20038_Name = {
    Text = "Chaos-Symbiont"
  },
  State_20038_WeaponDesc = {
    Text = "Wenn das Team aus Chaos und anderen Klassen besteht, erhalten alle Erwachten zu Beginn der Runde 20 Wahnsinn"
  },
  State_20039_Desc = {
    Text = "Wenn die Karte in der Abwurfphase noch auf der Hand ist, wird sie verbraucht und erscheint in diesem Kampf nicht mehr"
  },
  State_20039_Name = {
    Text = "<NothingnessIconKeywords:Nichts>"
  },
  State_20039_WeaponDesc = {
    Text = "Nach dem Ausspielen wird die Karte nicht in den Ablagestapel gelegt und kann in diesem Kampf nicht erneut verwendet werden"
  },
  State_20040_Name = {
    Text = "Zustand @ Chrono-Pendel schlaflos Zählung"
  },
  State_20041_Desc = {
    Text = "Zu Rundenbeginn erhalten Sie 1 Arithmetica für jeden Gegner und ziehen 1 Karte. Wenn Sie einen Gegner mit Schaden töten, fügen Sie anderen Gegnern Bluten zu, das dem doppelten überschüssigen Schaden entspricht"
  },
  State_20041_Name = {
    Text = "Lied der mutierten Massen"
  },
  State_20042_Desc = {
    Text = "Verursacht 25% mehr Schaden an Feinden mit negativen Zuständen, der Mörder erhält 20 Wahnsinn"
  },
  State_20044_Desc = {
    Text = "Erhöht den Symptom: Schwäche-Effekt um 10%. Alle 3 Runden 1 Stapel Symptom: Schwäche auf alle Feinde"
  },
  State_20045_Desc = {
    Text = "Nach Beginn des nächsten Zuges wähle 3 Karten aus dem Deck und füge sie deiner Hand hinzu"
  },
  State_20045_Name = {
    Text = "Zeitpendel fliegt"
  },
  State_20306_Name = {
    Text = "Magische Handschuhe der Schöpfung"
  },
  State_20419_Desc = {
    Text = "Für jeden verursachten Schaden fügst du dem Ziel [Arg1] Schichten Gift hinzu. Wenn die Auslösungen in diesem Kampf 25 erreichen, wird sofort Gift auf alle Gegner aktiviert"
  },
  State_20425_Desc = {
    Text = "Zu Beginn der Runde, erhalte [Layer] temporäre <PowerIconKeywords:Kraft> und Schild"
  },
  State_20425_Name = {
    Text = "Durstiges Blutmonster"
  },
  State_20600_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Die ersten [StateArg2] „Fähigkeit\" jeder Runde verbrauchen [StateArg1] weniger Arithmetica."
  },
  State_20600_Name = {
    Text = "Offenbarung"
  },
  State_20601_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: \"Schlag\" Schaden erhöht um [StateArg1]%. Wenn angegriffen, erhalte [StateArg2] Schichten von <EnergyStorageKeywords:Aufladung>."
  },
  State_20601_Name = {Text = "Fresssucht"},
  State_20602_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: „Schlag“ wählt ein Ziel und verursacht [StateArg1] Schichten <PVPSlowKeywords:Verlangsamung>. Der Effekt verdoppelt sich beim ersten Ziel pro Runde."
  },
  State_20602_Name = {
    Text = "Vergessene Hand"
  },
  State_20603_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: “Verherrlichung“ gibt dir <Energy:[Energy:StateArg1]> Aliemus."
  },
  State_20603_Name = {
    Text = "Verstümmelungsrückprall"
  },
  State_20604_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: „Schlag“ heilt <Heal:[Heal:StateArg1]> Leben"
  },
  State_20604_Name = {Text = "Saugen"},
  State_20605_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>：“Exaltieren“ vertreibt alle negativen Zustände aller Verbündeten; die Grundkosten für diese Karte übersteigen nicht die Fähigkeitshöhe"
  },
  State_20605_Name = {
    Text = "Lordszepter"
  },
  State_20606_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: „Schlag“ gibt <Energy:[Energy:StateArg1]> Wahnsinn"
  },
  State_20606_Name = {Text = "Raserei"},
  State_20607_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: „Schlag\" greift den Feind mit <HPAndShieldMax:höchstem Leben und Schild> an und verursacht zusätzlich [StateArg1]% Schaden als <PVPBleedingKeywords:Blutung>."
  },
  State_20607_Name = {
    Text = "Durchtrennen und vernarben"
  },
  State_20608_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Erhalte <Energy:[Energy:StateArg1]> Wut beim Einsatz von „Fähigkeit“ und am Ende des Zuges."
  },
  State_20608_Name = {Text = "Flüstern"},
  State_20609_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Wahnsinn durch Lebensverlust verdoppelt"
  },
  State_20609_Name = {
    Text = "Traum vom Meer"
  },
  State_20610_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: „Schlag \"-Schaden erhöht [DescArg1] %, nach „Verherrlichung\" erhält man selbst <PVPPowerIconKeywords:Stärke>+ [StateArg2] und der „Schlag \"-Schaden erhöht sich zusätzlich um [StateArg3] %, maximal 100%."
  },
  State_20610_Name = {
    Text = "Himmlisches Biest"
  },
  State_20611_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>：“Fähigkeit“und am Rundenende heilt den Verbündeten mit dem meisten verlorenen Leben um <Heal:[Heal:StateArg1]> Leben"
  },
  State_20611_Name = {Text = "Hoffnung"},
  State_20612_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Am Ende der Runde, erhalte der Verbündete mit dem niedrigsten Wahnsinn <Energy:[Energy:StateArg1]> Wahnsinn und stelle dem Verbündeten mit dem meisten verlorenen Leben <Heal:[Heal:StateArg2]> Leben wieder her"
  },
  State_20612_Name = {
    Text = "Barmherzige Pflege"
  },
  State_20613_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Am Ende der Runde, erhalten andere Verbündete <Block:[Block:StateArg1]> Schild"
  },
  State_20613_Name = {
    Text = "Das Land der Nichtexistenz"
  },
  State_20614_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>：Am Ende der Runde [StateArg1] temporäre <PVPRetaliateIconKeywords:Revanche> erhalten"
  },
  State_20614_Name = {
    Text = "Kernschmelze"
  },
  State_20615_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: „Schlag“ fügt zusätzlich [StateArg1] Schaden zu, <PVPMethysisKeywords:Gift>."
  },
  State_20615_Name = {
    Text = "Bitterer Fluch"
  },
  State_20616_Desc = {
    Text = "<PVPWeaponKeywords:Wheel of Destiny>: Gewinnen Sie <Energy:[Energy:StateArg1]> Aelius am Ende der Runde."
  },
  State_20616_Name = {
    Text = "Frühling in Acushnet"
  },
  State_20617_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsring>: Am Rundenende erhältst <Block:[Block:StateArg1]> Schild"
  },
  State_20617_Name = {Text = "Exil"},
  State_20618_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Vor dem „Erheben“ müssen beide Seiten alle Handkarten abwerfen und die gleiche Anzahl abgeworfener Karten +1 ziehen."
  },
  State_20618_Name = {
    Text = "Fröhliche Zaubershow"
  },
  State_20619_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Bei der Ausrüstung erhält man <Energy:[Energy:StateArg1]> Aliemus. Wenn ein verbündeter Erwecker „Verherrlichung \" freisetzt, erhält man <DelayKeywords:Latenz>: <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_20619_Name = {
    Text = "Hymne des Herrschers"
  },
  State_20620_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Handkartenlimit +[StateArg2]. Am Rundenende erhältst du eine Kopie von [StateArg1] zufälligen „Fähigkeit“ aus deiner Hand."
  },
  State_20620_Name = {Text = "Treffpunkt"},
  State_20621_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Vor “Verherrlichung“ sich <StrengthenKeywords:Verstärkung> und <ReinforceKeywords:Festung>."
  },
  State_20621_Name = {
    Text = "Gnade durch Schmerz"
  },
  State_20622_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Am Rundenende erhältst du <Energy:[Energy:StateArg1]> Aliemus. Verbrauche alle verbleibenden Arithmetica und erhalte für je 1 verbrauchte Arithmetica [StateArg3] weitere Aliemus."
  },
  State_20622_Name = {
    Text = "Verborgene Geburt"
  },
  State_20623_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: “Verherrlichung“ zieht [StateArg1] Karten."
  },
  State_20623_Name = {Text = "Erscheinen"},
  State_20624_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Bei der „Verherrlichung„ ziehe [StateArg1] Karten und lege [StateArg2] Kopien davon in deine Hand."
  },
  State_20624_Name = {
    Text = "Stunde des Glücks"
  },
  State_20625_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: „Verherrlichung \" <DelayKeywords:Latenz>: Stelle allen Verbündeten <Heal:[Heal:StateArg1]> Leben wieder her."
  },
  State_20625_Name = {
    Text = "Die Geschichte des Vielfraßes"
  },
  State_20626_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>：“Schlag“Schaden erhöht um [StateArg1]%，und <ReinforceKeywords:verstärkt> sich selbst"
  },
  State_20626_Name = {
    Text = "Unnachgiebiger Wille"
  },
  State_20627_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsring>: Am Rundenende heilt alle Verbündeten um <Heal:[Heal:StateArg1]> Leben"
  },
  State_20627_Name = {Text = "Segen"},
  State_20628_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>:“Verherrlichung“ gibt anderen Verbündeten <Energy:[Energy:StateArg1]> Wahnsinn, der überschüssige Wahnsinn wird halbiert an den Ausrüster zurückgegeben."
  },
  State_20628_Name = {Text = "Pflicht"},
  State_20629_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Die Schadens-, Heilungs- und Schild-Effekte von „Erheben“ werden um [StateArg1]% erhöht."
  },
  State_20629_Name = {
    Text = "Im Namen der Rose"
  },
  State_20630_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsring>: Am Rundenende erhältst <Block:[Block:StateArg1]> Schild und <Energy:[Energy:StateArg2]> Wahnsinn"
  },
  State_20630_Name = {
    Text = "Requiem des Winters"
  },
  State_20631_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: „Schlag\" verursacht <PVPVulnerabilityIconKeywords:Verwundbar> beim Ziel. Erhältst [StateArg1] <EnergyStorageKeywords:Aufladen> bei Ausrüstung und am Ende deiner Runde."
  },
  State_20631_Name = {
    Text = "Kritischer Punkt"
  },
  State_20632_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Handkartenlimit +[StateArg1]"
  },
  State_20632_Name = {
    Text = "Erinnerungsspirale"
  },
  State_20633_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nach dem ersten aktiven Angriff eines Feindes pro Runde verursache [StateArg1] Schaden an ihm, <PVPEntanglementKeywords:Umschlingen>."
  },
  State_20633_Name = {
    Text = "Blasser Nachkomme"
  },
  State_20634_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Der durch “Schlag“, “Fähigkeit“ und “Exaltieren“ verursachte Schaden, die Heilung und der Schild erhöhen sich um [DescArg1]%, <PVPGrowthKeywords:Wachstum> um [StateArg2]%."
  },
  State_20634_Name = {Text = "Sonnenfall"},
  State_20635_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>：“Exaltieren“ lässt alle Verbündeten <StrengthenKeywords:Stärken> erhalten"
  },
  State_20635_Name = {
    Text = "Frommes Macht"
  },
  State_20636_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsring>: Am Rundenende erhältst eine Karte <PVPDerivativeCardKeywords_2: \"Illusion\">, für je zwei Karten <PVPDerivativeCardKeywords_2: \"Illusion\"> auf der Hand, werden sie zu einer Karte <PVPDerivativeCardKeywords_12: \"Kleiner Wunsch\"> verschmolzen"
  },
  State_20636_Name = {Text = "Reif"},
  State_20637_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>：Am Ende der Runde [StateArg1] Karten <PVPDerivativeCardKeywords_11:„Ungleicher Austausch“> in den Nachziehstapel mischen"
  },
  State_20637_Name = {
    Text = "Daten sind Leben"
  },
  State_20639_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Am Zugende fügt der Träger dem Feind mit <HPAndShieldMax:höchstem Leben und Schild> [StateArg1] Schaden zu und <PVPMethysisKeywords:vergiftet> ihn."
  },
  State_20639_Name = {
    Text = "Geschenk des Verfalls"
  },
  State_20640_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>：Bei Ausrüstung und zu Beginn der Runde, erleiden alle feindlichen Einheiten <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:Bluten> Schaden, und für jede Handkarte des Ziels erhöht sich der <PVPBleedingKeywords:Bluten> Schaden um +[StateArg2]"
  },
  State_20640_Name = {
    Text = "Blutiges Festmahl"
  },
  State_20641_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Nach dem Tod, anderen Verbündeten [StateArg1] Schichten <PVPProtectiveKeywords:Barriere> geben"
  },
  State_20641_Name = {
    Text = "Analyse des Todes"
  },
  State_20642_Desc = {
    Text = "<PVPHoldingKeywords:Halten>: Jedes Mal, wenn du eine Karte spielst, wird diese zur zufälligen „Rad des Schicksals“ und ihre Berechnungskosten werden um -1 verringert"
  },
  State_20642_Name = {
    Text = "Seele geboren"
  },
  State_20643_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nach „Verherrlichung\" erhält [StateArg1] Arithmetica, <DelayKeywords:Latenz>: Zieht [StateArg2] Arithmetica ab."
  },
  State_20643_Name = {Text = "Amnesie"},
  State_20644_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Bei der Ausrüstung erhältst du <Block:[Block:StateArg2]> Schild und <PVPEntanglementKeywords:Umschlingen>. Für jeden gefallenen Verbündeten erhöht sich <StrongEffectKeywords:Amplifikation> um [StateArg1]."
  },
  State_20644_Name = {
    Text = "Kostbare Sammlung"
  },
  State_20645_Name = {
    Text = "Abenteurerrucksack"
  },
  State_20646_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: “Schlag“ Schaden erhöht um [StateArg1]%, “Verherrlichung“ heilt <Heal:[Heal:StateArg2]> LP."
  },
  State_20646_Name = {
    Text = "Verschlungenes Wiegenlied"
  },
  State_20647_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: “Verherrlichung“ nimmt [StateArg1] <PVPDerivativeCardKeywords_11:“Ungleicher Austausch“> in die Hand."
  },
  State_20647_Name = {
    Text = "Inmitten des Regensturms"
  },
  State_20648_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Zu Beginn der Runde, erhalte positiven <PVPWonderfulEffectKeywords:Wundereffekt>, wenn der Gegner zum ersten Mal pro Runde „Schlüsselbefehl“ verwendet, füge [StateArg1] Karten „Prächtige Szenerie“ zur Hand hinzu"
  },
  State_20648_Name = {
    Text = "Stilles Festmahl"
  },
  State_20649_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Nach „Erheben“ kehre die zuletzt gespielte „Fähigkeit“ aus der vorherigen Runde in deine Hand zurück; ihre Arithmetica-Kosten -1. Wenn dieser Effekt mehrfach ausgelöst wird, wird weiter zurückverfolgt."
  },
  State_20649_Name = {
    Text = "Zeit zurückdrehen"
  },
  State_20650_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>：“Exaltieren“ vertreibt alle positiven Zustände aller Gegner; die Grundkosten für diese Karte übersteigen nicht die Fähigkeitshöhe"
  },
  State_20650_Name = {Text = "Delirium"},
  State_20651_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsring>: Am Rundenende zieht [StateArg1] Karten"
  },
  State_20651_Name = {Text = "Gier"},
  State_20652_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>:Nach Aktivierung von “Verherrlichung“ erleiden alle feindlichen Einheiten [StateArg1] <DisarmKeywords:Lähmung>."
  },
  State_20652_Name = {Text = "Bestrafung"},
  State_20653_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: „Schlag“ wählt Ziel und entzieht <Energy:[Energy:StateArg1]> Wahnsinn"
  },
  State_20653_Name = {
    Text = "Im Verlangen treiben"
  },
  State_20654_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Zu Beginn der Runde sich <PVPSeriousInjuryKeywords:Verderben> zufügen und <Damage:[Damage:StateArg1]> Stapel <PVPCorrosionKeywords:Sündenmal> erhalten. Am Ende der Runde sich <ReinforceKeywords:Festung> geben."
  },
  State_20654_Name = {
    Text = "Edikt der Königin"
  },
  State_20655_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>：Bei Ausrüstung werden [StateArg1] Karten „Schlag“ in den Ziehstapel gemischt, „Schlag“ kann ein Ziel wählen"
  },
  State_20655_Name = {Text = "Gunst"},
  State_20656_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Der durch “Fähigkeit“ verursachte Schaden, die Heilung und der Schild-Effekt erhöhen sich um [StateArg1]%. Falls nach der Verwendung der “Fähigkeit“ kein <PVPProtectiveKeywords:Barriere> vorhanden ist, erhält man 1 Schicht."
  },
  State_20656_Name = {
    Text = "Der letzte Vers"
  },
  State_20657_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>：Für jede Runde, in der der Gegner die [StateArg1]te „Fähigkeit“ ausspielt, wird eine Kopie mit -[StateArg2] Fähigkeitskosten in deine Hand gelegt"
  },
  State_20657_Name = {Text = "Einblick"},
  State_20658_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>：“Schlag“erhält [StateArg1] Arithmetica pro angegriffenem Ziel"
  },
  State_20658_Name = {
    Text = "Lied der Gebundenen"
  },
  State_20659_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Nach dem Tod, zu Beginn der nächsten Runde <PVPResurrectionKeywords:selbst wiederbeleben> und <Heal:[Heal:StateArg1]> Leben und <Block:[Block:StateArg2]> Schild erhalten und dieses „Schicksalsrad“ zerstören"
  },
  State_20659_Name = {Text = "Vitalität"},
  State_20660_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: “Verherrlichung“ lässt alle Verbündeten <Block:[Block:StateArg1]> Schild erhalten und dispelled die Hälfte <PVPBleedingKeywords:Bluten>."
  },
  State_20660_Name = {
    Text = "Herzbarriere"
  },
  State_20661_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>:Nach der “Verherrlichung“ erleiden alle feindlichen Einheiten <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:Bluten> Schaden."
  },
  State_20661_Name = {
    Text = "Verlassener Pfad"
  },
  State_20662_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Am Zugende verursacht jeder Punkt <PVPCapKeywords:maximaler Rechenkapazität> [StateArg1] <PVPBleedingKeywords:Blutung> beim Feind mit <HPAndShieldMin:niedrigstem Leben und Schild>, insgesamt <Damage:[Damage:DescArg1]> <PVPBleedingKeywords:Blutungs>schaden."
  },
  State_20662_Name = {
    Text = "In der Nacht lauernd"
  },
  State_20663_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>:“Exaltieren“ vertreibt negative Zustände und erhält [StateArg1] Schichten <EnergyStorageKeywords:Aufladen>."
  },
  State_20663_Name = {
    Text = "Fesseln losgekettet"
  },
  State_20664_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>：“Fähigkeit“<ReinforceKeywords:verstärkt> sich selbst"
  },
  State_20664_Name = {
    Text = "Ein Ritterschwur"
  },
  State_20665_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Wenn keine negativen Zustände zu entfernen sind, <Heal:[Heal:StateArg1]> Leben heilen. Am Rundenende, <DelayKeywords:Verzögerung>: negative Zustände entfernen"
  },
  State_20665_Name = {
    Text = "Segel der Vorhersehung"
  },
  State_20666_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Nach „Wahnsinniger Ausbruch\" erhält der Verbündete mit <HPAndShieldMin:niedrigstem Leben und Schild> [StateArg1] Stapel <PVPProtectiveKeywords:Barriere>."
  },
  State_20666_Name = {
    Text = "An den lieben Freund"
  },
  State_20667_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Die erste „Fähigkeit \", die der Ausrüster in jeder Runde spielt, verursacht +[StateArg1] % Schaden."
  },
  State_20667_Name = {
    Text = "Klinge des Riesen"
  },
  State_20668_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Wenn ein eigener Wachkörper stirbt, erleiden alle feindlichen Einheiten <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:Bluten> Schaden. Wenn der Ausrüster stirbt, zusätzlich <Damage:[Damage:StateArg2]> <PVPBleedingKeywords:Bluten> Schaden verursachen."
  },
  State_20668_Name = {
    Text = "Frau Corals Tod"
  },
  State_20669_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Wenn ausgerüstet und zu Beginn deines Zuges, wenn es keine <PVPProtectiveKeywords:Barriere> gibt, erhalte [StateArg1] Stapel von <PVPProtectiveKeywords:Barriere>; andernfalls verringere die Arithmetica-Kosten einer „Fähigkeit“ in deiner Hand mit den höchsten Arithmetica-Kosten um 1."
  },
  State_20669_Name = {
    Text = "Schrifttafel"
  },
  State_20670_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>：“Schlag“ verursacht <PVPSeriousInjuryKeywords:schwere Verletzung>, Schaden + [StateArg1]%, aber verliert die Hälfte des Schadens als Leben"
  },
  State_20670_Name = {
    Text = "Flosse der Trauer"
  },
  State_20671_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: “Verherrlichung“ heilt selbst <Heal:[Heal:StateArg1]> LP."
  },
  State_20671_Name = {
    Text = "Unsterblicher Aufstieg"
  },
  State_20672_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Am Rundenende werden die Arithmetica-Kosten der Handkarte mit den höchsten Arithmetica-Kosten um -[StateArg1] reduziert. <PrepareKeywords:Bereit>."
  },
  State_20672_Name = {
    Text = "Konzentration"
  },
  State_20673_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>:“Verherrlichung“ gibt dir <Block:[Block:StateArg1]> Schild und anderen Verbündeten <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_20673_Name = {
    Text = "Unberechenbarer Faktor"
  },
  State_20696_Name = {
    Text = "Status@FurchtVorRiesen"
  },
  State_20723_Desc = {
    Text = "Schadensbonus für Schlagkarten um [Layer]."
  },
  State_20723_Name = {
    Text = "Schaden von Schlagkarten erhöht"
  },
  State_20724_Desc = {
    Text = "Schaden der Schlagkarten um [Layer] reduziert."
  },
  State_20724_Name = {
    Text = "Schlagkarte Festgelegten Schaden reduzieren"
  },
  State_20749_Desc = {
    Text = "Allgemeiner Rückverfolgungszähler."
  },
  State_20758_Desc = {
    Text = "Nach Beginn der nächsten Runde, ziehe [Layer] Karten"
  },
  State_20758_Name = {
    Text = "Verzögerte Kartenziehung"
  },
  State_20766_Desc = {
    Text = "Der spezifische Effekt hängt von der allgemeinen Schlaglogik ab."
  },
  State_20802_Desc = {
    Text = "Diese Karte kann nicht ausgespielt werden."
  },
  State_20802_Name = {
    Text = "kann nicht ausführen"
  },
  State_20803_Desc = {
    Text = "Diese Karte hat bei der Verwendung anderer Karten -1 Arithmetica-Verbrauch. Nach der Verwendung wird sie zu einer anderen zufälligen Rad des Schicksals Karte"
  },
  State_20803_Name = {
    Text = "<CardKeyWord:Geburt einer Seele>"
  },
  State_20805_Desc = {
    Text = "Karten werden nicht in der Ablagephase in den Ablagestapel gelegt, sondern bleiben im Handkartenbereich"
  },
  State_20805_Name = {
    Text = "<RetainIconKeywords:Behalten>"
  },
  State_20806_Desc = {
    Text = "Nach dem Ausspielen wird nicht in den Ablagestapel gelegt, sondern aus dem Deck entfernt"
  },
  State_20806_Name = {
    Text = "<DepleteIconKeywords:Verbrauch>"
  },
  State_20820_Desc = {
    Text = "Nach Beginn der nächsten Runde, wiederbelebt und erhältst [Layer] Leben und [Layer] Schild"
  },
  State_20820_Name = {
    Text = "Verzögerte Wiederbelebung"
  },
  State_20851_Name = {
    Text = "Karte gewähren"
  },
  State_20981_Desc = {
    Text = "“„Sinnrot“ ist erwacht, der verursachte Schaden wird signifikant erhöht.“"
  },
  State_20981_Name = {
    Text = "Uuhaschi erwacht!"
  },
  State_20981_WeaponDesc = {
    Text = "Nach Beginn der nächsten Runde, erhalte Schild in Höhe des verlorenen Lebens der letzten Runde"
  },
  State_20982_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_20982_Name = {
    Text = "Nicht erweckt"
  },
  State_20988_Desc = {
    Text = "Anfangs Wahnsinn +80. Pro Runde 20 Wahnsinn"
  },
  State_20988_Name = {
    Text = "Davendale·Erste Begegnung"
  },
  State_20989_Desc = {
    Text = "Anfangs Aelius +80. Erhalte pro Runde 2 Punkte Arithmetica, 20 Punkte Aelius"
  },
  State_20989_Name = {
    Text = "Tulu · Erste Begegnung"
  },
  State_21306_Desc = {
    Text = "Pro Runde Kombos zurücksetzen"
  },
  State_21306_Name = {
    Text = "Kombo zurücksetzen"
  },
  State_21307_Desc = {
    Text = "Jede Schicht erhöht die ANGe um 1, verliert 1 Schicht bei Schaden, mindestens 1 Schicht, verliert alle am Rundenende"
  },
  State_21307_Name = {
    Text = "Kettenangriff"
  },
  State_21342_Desc = {
    Text = "Zu Beginn der nächsten Runde erhältst du [Layer] heilen"
  },
  State_21342_Name = {
    Text = "Verzögerte Heilung"
  },
  State_21345_Desc = {
    Text = "Vor Beginn des Götterabstieg-Rituals wird man nach dem Tod wiederbelebt, negative Zustände werden entfernt, man ist immun gegen Schaden und stellt 30% LP wieder her. Nach Beginn des Götterabstieg-Rituals wird man vollständig wiederbelebt, negative Zustände und Ritualbesessenheit werden entfernt und es werden zwei Clanmitglieder gerufen."
  },
  State_21345_Name = {
    Text = "Ritualbesessenheit"
  },
  State_21358_Desc = {
    Text = "Der Spieler hat kein Handkartenlimit."
  },
  State_21381_Name = {
    Text = "Versiegelungsanzahl zählen"
  },
  State_21385_Desc = {
    Text = "Beim Verlust von 1 Punkt Gesundheit reduziert sich die Anzahl um 1 Schicht. Wenn die Anzahl auf 0 sinkt, wandelt sich die Absicht in einen hohen Schadens-Wahnexplosion und hebt den Versteinerungseffekt auf"
  },
  State_21385_Name = {Text = "Blutwut"},
  State_21450_Desc = {
    Text = "Zu Beginn der nächsten Runde werden eigene negative Zustände entfernt."
  },
  State_21450_Name = {
    Text = "Verzögerte Reinigung"
  },
  State_21488_Desc = {
    Text = "Die spezifischen Effekte hängen von der allgemeinen Schlaglogik ab."
  },
  State_21492_Desc = {
    Text = "Schaden erhöht sich bei kritischen Treffern um 50%"
  },
  State_21492_Name = {
    Text = "<CardKeyWord:Kritischer Treffer>"
  },
  State_21546_Desc = {
    Text = "Nach Beginn der nächsten Runde, erhalte [Layer] Schild"
  },
  State_21546_Name = {
    Text = "Verzögerter Schild"
  },
  State_21547_Desc = {
    Text = "Zu Beginn der Runde behalte die Hälfte des Schildes"
  },
  State_21547_Name = {Text = "Festigkeit"},
  State_21548_Desc = {
    Text = "Zu Beginn der nächsten Runde erhältst du Stärkung"
  },
  State_21548_Name = {
    Text = "Verzögerte Verstärkung"
  },
  State_21580_Desc = {
    Text = "Der Schädeljäger verfolgt deine Spuren, jede gezogene Karte gibt ihm [StateArg1] temporäre Stärke"
  },
  State_21580_Name = {
    Text = "Nachspüren"
  },
  State_21587_Name = {
    Text = "In dieser Runde neues zufälliges Erweckten gefunden"
  },
  State_21590_Name = {
    Text = "Versuche, neue Erweckungskörper zu finden"
  },
  State_21601_Name = {
    Text = "Neuer Erwachungskörper gefunden"
  },
  State_21616_Desc = {
    Text = "Nach Nutzung des Wahnsinns Exaltieren alle Weckkörper für eine Runde versiegeln"
  },
  State_21616_Name = {
    Text = "Überreste des Pfadläufers"
  },
  State_21671_Name = {
    Text = "Verursacht Bereichsschaden"
  },
  State_21688_Name = {
    Text = ", kann 1 Mal verwendet werden"
  },
  State_21689_Name = {
    Text = ", kann 2 Mal verwendet werden"
  },
  State_21720_Desc = {
    Text = "Verursacht den gleichen Effekt an den Erwachten hinter dem Ziel. Wenn sich hinter dem Ziel keine Erwachten befinden, wirkt der Effekt nur auf das Ziel."
  },
  State_21720_Name = {
    Text = "<CardKeyWord:Durchdringen>"
  },
  State_21726_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Der Ausrüster zieht bei der ersten ausgespielten „Fähigkeit“ in jeder Runde eine Kopie mit einem Verbrauch von - [StateArg1] in den Ziehstapel"
  },
  State_21726_Name = {Text = "Fouetté"},
  State_21744_Name = {
    Text = "Versuche, neue Erweckungskörper zu finden"
  },
  State_21745_Name = {
    Text = "Neuer Erwachungskörper gefunden"
  },
  State_21746_Name = {
    Text = "In dieser Runde neues zufälliges Erweckten gefunden"
  },
  State_21747_Desc = {
    Text = "Es werden [Layer] Erwachte gejagt. Jedes Mal, wenn ein Erwachter eine Karte spielt, erhält der „Tobsüchtige Jäger“ 1 Jagdmarke"
  },
  State_21747_Name = {
    Text = "Jagdzeremonie"
  },
  State_21751_Desc = {
    Text = "Ziehe die Hälfte der Jagdmarken-Karten ([DescArg1]), +1 Jagdmarke für den „Berserker-Jäger“"
  },
  State_21751_Name = {
    Text = "<CardKeyWord:Gejagt>"
  },
  State_21754_Desc = {
    Text = "Nach dem Tod, zerstreue alle temporären Kräfte des „Rasenden Schädeljägers“ und halbiere seine „Jagdmarken“-Stufen"
  },
  State_21754_Name = {
    Text = "kurze Erleichterung"
  },
  State_21765_Desc = {
    Text = "·Du kannst einem verbündeten Erwecker das “Schicksalsrad“ anlegen, um die Effekte des “Schicksalsrads“ zu aktivieren. \n·Wenn du einem Erwecker das “Schicksalsrad“ erneut anlegst, wird das alte “Schicksalsrad“ zerstört und das neue “Schicksalsrad“ behalten. \n·Nach dem Tod des Erweckers wird das angelegte “Schicksalsrad“ zerstört. \n·Wenn du einem gestorbenen Erwecker das “Schicksalsrad“ anlegst, wird dieses “Schicksalsrad“ zerstört und du erhältst eine Illusion sowie die verbrauchte Arithmetica zurück."
  },
  State_21765_Name = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>"
  },
  State_21785_Name = {Text = "Kampfruf"},
  State_21787_Name = {
    Text = "Kampfruf hinzufügen"
  },
  State_21826_Name = {
    Text = "Anführer der Kinder, Eröffnungsrede"
  },
  State_21829_Name = {
    Text = "Todesröcheln-Effekt"
  },
  State_21838_Name = {
    Text = "Einführung am Anfang"
  },
  State_21843_Name = {
    Text = "Status am Anfang hinzufügen"
  },
  State_21895_Name = {
    Text = "Eröffnungsruf"
  },
  State_21905_Desc = {
    Text = "“Schaden“ erhält 2 Punkte Arithmetica, verworfen zufällig 1 Karte; „VERT“ zieht 2 Karten und verliert 1 Punkt Arithmetica"
  },
  State_21928_Name = {Text = "Hinweis"},
  State_22054_Name = {
    Text = "Eröffnungsruf"
  },
  State_22055_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_22055_Name = {
    Text = "Nicht erweckt"
  },
  State_22067_Desc = {
    Text = "Nach Rundenende greift 1 Tentakel [Layer] Mal an"
  },
  State_22067_Name = {
    Text = "Tentakelansammlung"
  },
  State_22074_Desc = {
    Text = "Überlebe die siebte Runde, um die Absicht in Starren zu ändern, ab der achten Runde in Entweihung"
  },
  State_22134_Desc = {
    Text = "Fügt dem Schild, den LP und der Barriere des Ziels gleichzeitig Schaden zu."
  },
  State_22134_Name = {
    Text = "<CardKeyWord:Stichschaden>"
  },
  State_22157_Desc = {
    Text = "Wenn das Leben unter 50% ([StateArg1]) fällt, teilt es sich in gleichwertige „Strömung“ und „Gezeiten“"
  },
  State_22157_Name = {Text = "Spalten"},
  State_22204_Desc = {
    Text = "Am Anfang der Runde erhältst du [Layer]% temporäre kritische Rate und temporären kritischen Schaden"
  },
  State_22204_Name = {
    Text = "Ferne Melodie"
  },
  State_22204_WeaponDesc = {
    Text = "Bis vor dem Beginn der nächsten Runde kein Leben verloren, kritische Rate in der nächsten Runde +[StateArg1]%"
  },
  State_22210_Desc = {
    Text = "Verbrauch der Rechenleistung + 100, keine Verwendung von Schlägen, kein Wahn erlangt"
  },
  State_22210_Name = {
    Text = "Superlangsam"
  },
  State_22238_Name = {
    Text = "Spieler-Duell"
  },
  State_22239_Name = {
    Text = "Verursacht Spieler-Duell"
  },
  State_22249_Desc = {
    Text = "Nach Beginn des nächsten Zuges ziehe [Layer] Karten weniger"
  },
  State_22249_Name = {
    Text = "Ungleicher Austausch"
  },
  State_22300_Desc = {
    Text = "Diese Schlagkarte kann nicht gespielt werden."
  },
  State_22300_Name = {
    Text = "Schlagkarte kann nicht ausgespielt werden"
  },
  State_22303_Desc = {
    Text = "Jedes Mal, wenn man Schaden erleidet, wird einer zufälligen Karte im Handkarten eine temporäre „Verzögerung“ hinzugefügt. Nach dem Brechen des Schilds wird der Zustand „Frostschild“ entfernt"
  },
  State_22303_Name = {
    Text = "Frostschild"
  },
  State_22324_Desc = {
    Text = "Für jede Schicht, erhöhe diesen Zug um 1 ANG"
  },
  State_22324_Name = {
    Text = "Wutwellen-Echo"
  },
  State_22325_Desc = {
    Text = "Nach jedem ANG, erhalte [StateArg1] temporäre Stärke"
  },
  State_22325_Name = {Text = "Riesenblut"},
  State_22326_Desc = {
    Text = "Du wurdest markiert! Das Ausspielen von „Seefahrer“ gewährt 1 Schicht temporären Wahnsinn und entfernt das brüllende Mark von dieser Befehlskarte"
  },
  State_22326_Name = {
    Text = "<CardKeyWord:brüllende Markierung>"
  },
  State_22328_Desc = {
    Text = "Für jede Verwendung einer Befehlskarte mit „brüllende Markierung“ wird die Anzahl der ANGe in dieser Runde um 1 erhöht"
  },
  State_22328_Name = {
    Text = "Wutwellen-Echo"
  },
  State_22334_Desc = {
    Text = "Für jede gespielte „Schlag“-Karte lege [StateArg1] „Wunden“ oben auf den Ziehstapel"
  },
  State_22334_Name = {Text = "Verletzung"},
  State_22404_Desc = {
    Text = "Schilde in diesem Kampf um [Layer] Punkte erhöht"
  },
  State_22404_Name = {Text = "Wachsam"},
  State_22405_Desc = {
    Text = "Schilde in diesem Kampf erhöht"
  },
  State_22405_Name = {
    Text = "<PVPAlertKeywords:Alarm>"
  },
  State_22702_Desc = {
    Text = "Die erste gespielte „Karte“ jeder Runde löst einen zusätzlichen Effekt aus"
  },
  State_22702_Name = {
    Text = "<CardKeyWord:Überfall>"
  },
  State_22706_Name = {Text = "Raidmarker"},
  State_22707_Desc = {
    Text = "Nach dem Ausspielen einer Karte in jeder Runde erhält der Spieler den Status Hinterhalt"
  },
  State_22707_Name = {
    Text = "Hinterhalt-Trigger"
  },
  State_22721_Name = {
    Text = "Zeitpendel„verloren\""
  },
  State_23405_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, die Kraft entsprechend der aktuellen Anzahl an Widerstandsschichten erhalten, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_23405_Name = {
    Text = "Nicht erweckt"
  },
  State_23406_Desc = {
    Text = "“Der „Abgrundwanderer“ erhält am Ende jeder Runde [StateArg1] Schichten Rückschlag.“"
  },
  State_23406_Name = {
    Text = "Kaikes Erwachen!"
  },
  State_23512_Name = {
    Text = "Gewähre Tausendgesichter-Illusion"
  },
  State_23514_Name = {
    Text = "Gewähre Tausendgesichter-Illusion"
  },
  State_23515_Name = {
    Text = "Gewähre Tausendgesichter-Illusion"
  },
  State_23516_Name = {
    Text = "Gewähre Tausendgesichter-Illusion"
  },
  State_23517_Name = {
    Text = "Gib dem Spieler BUFF"
  },
  State_23518_Desc = {
    Text = "Füge 2 Runden Verwundbarkeit hinzu / erhöhe 1 ANG / füge Machtminderung hinzu"
  },
  State_23518_Name = {
    Text = "<CardKeyWord:Absicht wählen>"
  },
  State_23519_Name = {Text = "Absicht 2b"},
  State_23520_Name = {Text = "Absicht 2c"},
  State_23521_Name = {
    Text = "Lege beim Abwerfen die Kosten ab, ziehe alle Erwecker [StateArg1] Wahnsinn ab und mische 5 “Symptome“ in den Kartenstapel des Spielers"
  },
  State_23522_Name = {
    Text = "Lege beim Abwerfen die Kosten ab, ziehe allen Erweckern [StateArg1] Aliemus ab"
  },
  State_23524_Name = {Text = "Absicht 3a"},
  State_23525_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_23525_Name = {
    Text = "Nicht erweckt"
  },
  State_23526_Name = {Text = "Absicht 2a"},
  State_23527_Name = {Text = "Absicht 3c"},
  State_23528_Name = {Text = "Absicht 3b"},
  State_23529_Desc = {
    Text = "Erhöht Stärke / Verursacht zusätzlichen Schaden / Erhält Schild"
  },
  State_23529_Name = {
    Text = "<CardKeyWord:Absicht wählen>"
  },
  State_23530_Desc = {
    Text = "Beim Einsatz von „tausend Fata Morgana“ sind zwei Absichtsauswahlen erforderlich. Wenn du aufgibst, verlieren alle Erwecker 20 Wut und 5 „Symptom“-Karten werden in den Ziehstapel des Spielers gemischt"
  },
  State_23530_Name = {
    Text = "Davendale Erwachen!"
  },
  State_23531_Name = {
    Text = "Gewähre Tausendgesichter-Illusion"
  },
  State_23532_Name = {
    Text = "Gewähre Tausendgesichter-Illusion"
  },
  State_23533_Desc = {
    Text = "Karten mit Symptomen waschen / Bluten anwenden / Wahnsinn senken"
  },
  State_23533_Name = {
    Text = "<CardKeyWord:Absicht wählen>"
  },
  State_23534_Name = {Text = "Absicht 1a"},
  State_23535_Name = {Text = "Absicht 1c"},
  State_23536_Name = {Text = "Absicht 1b"},
  State_23612_Desc = {
    Text = "Beim Verlust von 1 Punkt Gesundheit reduziert sich die Anzahl um 1 Schicht. Wenn die Anzahl auf 0 sinkt, wandelt sich die Absicht in einen hohen Schadens-Wahnexplosion und hebt den Versteinerungseffekt auf"
  },
  State_23612_Name = {
    Text = "Blutwut·Ende"
  },
  State_23687_Name = {
    Text = "Zeitpendel „Gezeiten\""
  },
  State_23726_Desc = {
    Text = "Vor dem nächsten Zug wird der Erwachte 1 Mal vor dem Tod bewahrt, maximal 1 Schicht"
  },
  State_23726_Name = {
    Text = "Todwiderstand"
  },
  State_23732_Desc = {
    Text = "Bis zum Beginn des nächsten Zuges erhältst du für jede erlittene Instanz von Aktivem Schaden [Layer] <plural value=\"[Layer]\" singular=\"Stapelung\" plural=\"Stapelungen\"> <PainWord:Ausdauer>."
  },
  State_23732_Name = {
    Text = "Verbotener Sumpf"
  },
  State_23736_Name = {
    Text = "Karten gezogen in dieser Runde"
  },
  State_23737_Name = {
    Text = "Ziehzahl-Aufzeichnung"
  },
  State_23741_Name = {
    Text = "Anwenden des Ziehens von Karten"
  },
  State_23744_Desc = {
    Text = "Wenn es keine \"Toten\" auf dem Feld gibt, beschwöre zu Beginn der Runde 1 \"Toten\", jedes Mal erhöht sich das Leben"
  },
  State_23744_Name = {
    Text = "Tote beschwören"
  },
  State_23747_Name = {
    Text = "Verstärkung LP"
  },
  State_23748_Name = {
    Text = "Beschwörungszähler"
  },
  State_23769_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_23769_Name = {
    Text = "Nicht erweckt"
  },
  State_23771_Desc = {
    Text = "“„Zauberer“ ist bereits erwacht, sei vorsichtig mit den Klonen, die sie mit „Phantasma“ erzeugt. Nach der Erweckung erhält Casiah nach jedem gespielten Karte eine Schicht „Phantasma“.“"
  },
  State_23771_Name = {
    Text = "Kassia erwacht!"
  },
  State_23771_WeaponDesc = {
    Text = "Nach Beginn der nächsten Runde, erhalte Schild in Höhe des verlorenen Lebens der letzten Runde"
  },
  State_23782_Desc = {
    Text = "Erhalte 10 Schichten Phantasma, leere die Schichten „Phantasma“ und beschwöre 1 Klon vorne, maximal 2 Klone. Der Klon trägt beim Beschwören 3 Schichten <ParcloseIconKeywords:Barriere>"
  },
  State_23782_Name = {Text = "Phantasma"},
  State_23786_Name = {
    Text = "Zustand @ Erwecker Casiah Telekinese"
  },
  State_23787_Name = {
    Text = "Zustand @ Erwecker Casiah @ Telekinese @ Ziehen reduzieren"
  },
  State_23788_Desc = {
    Text = "Zu Beginn der 3. Runde füge 1 Karte “Echo der Vergangenheit—Wirf alle Handkarten ab, setze aktuelles Leben und Schild auf den Stand am Ende der letzten Runde zurück. Behalte, verbrauche.“ deiner Hand hinzu"
  },
  State_23791_Name = {
    Text = "Eröffnungshinweis"
  },
  State_23823_Name = {Text = "Bombe 1"},
  State_23825_Name = {
    Text = "Zustand @ Erwecker Casiah @ zack"
  },
  State_23827_Desc = {
    Text = "Nach dem Ausspielen verliert ihr [DescArg1] Punkte maximale Gesundheit, der große Magier erhält in dieser Runde 1 Schicht „Selbstgefälligkeit“"
  },
  State_23827_Name = {
    Text = "<CardCheerKeywords:Jubel>"
  },
  State_23828_Desc = {
    Text = "Der große Zauberer genießt jetzt seine Aufführung sehr, bei jeder Stufe „Überheblichkeit“ wird die Wirkung seiner Fähigkeiten geschwächt und die Macht verringert [DescArg1], maximal 5 Stufen"
  },
  State_23828_Name = {
    Text = "zufrieden mit sich selbst"
  },
  State_23871_Desc = {
    Text = "Wenn die maximale Gesundheit erhöht wird, wird die aktuelle Gesundheit nicht gleichzeitig erhöht; wenn die maximale Gesundheit verringert wird und darüber hinausgehende aktuelle Gesundheit entfernt wird, beträgt die maximale Gesundheit mindestens 1"
  },
  State_23871_Name = {
    Text = "<MaxHPColour:Maximale Gesundheit>"
  },
  State_23934_Name = {
    Text = "Status@Telekinese Handkarten Überwachung"
  },
  State_23935_Name = {
    Text = "Zustand @ Erwecker Casiah @ Telekinese aktiviert"
  },
  State_2393_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_2393_Name = {
    Text = "Nicht erweckt"
  },
  State_2394_Name = {
    Text = "Purpurne Kraft, erleuchte Bonus"
  },
  State_2395_Name = {
    Text = "Schmuckstück Fest aus der Ferne"
  },
  State_2395_WeaponDesc = {
    Text = "“VERT“verursacht einen Schild, der um 30% erhöht ist. Wenn der schwarze Siegel des Ausrüstenden über 15% fällt, wird der durch „VERT“ verursachte Schild zusätzlich um 30% erhöht"
  },
  State_2396_Desc = {
    Text = "Kritischer Schaden +20%. Schaden gegen Gegner mit Schild ist garantiert kritisch"
  },
  State_2398_Desc = {
    Text = "Beim Erleiden von Schaden erhält man [Layer] Schild, der bei jedem Schaden zunimmt und am Ende der Runde wiederhergestellt wird"
  },
  State_2398_Name = {
    Text = "Dimensionsbarriere"
  },
  State_2398_WeaponDesc = {
    Text = "Aktiver Schaden erhöht sich um [Layer]. Bei jedem Schaden vergrößert sich die Erosionswunde, zu Beginn der Runde wiederhergestellt"
  },
  State_2399_Desc = {
    Text = "Nach der Lebensrückgewinnung erhalten alle Erwecker 3 Punkte Aelius. Nach jeder 5. Lebensrückgewinnung erhöht sich der Aelius-Schaden in diesem Kampf um [Arg1]"
  },
  State_2400_Desc = {
    Text = "Tentakelobergrenze erhöht sich um 1. Wenn die Gesundheit unter 50% liegt, erhöht sich der Tentakelschaden um [StateArg1] Punkte"
  },
  State_2400_Name = {
    Text = "Opfergaben der Schöpfung"
  },
  State_2400_WeaponDesc = {
    Text = "Tentakelobergrenze erhöht sich um 1. Wenn die Gesundheit unter 50% liegt, erhöht sich der Tentakelschaden um [StateArg1] Punkte"
  },
  State_2401_Desc = {
    Text = "Zu Beginn der Runde, füge die oberste Karte des Ablagestapels zur Hand hinzu"
  },
  State_2402_Desc = {
    Text = "Zu Beginn der Runde, erhalte für jede Karte im Hyperraum [Arg1] temporäre Kraft"
  },
  State_2403_Desc = {
    Text = "Schilde in diesem Kampf um [Layer] Punkte erhöht"
  },
  State_2403_Name = {Text = "Wachsam"},
  State_2403_WeaponDesc = {
    Text = "Schilde in diesem Kampf um [Layer] Punkte erhöht"
  },
  State_2404_Desc = {
    Text = "Beim Aufnehmen wird 1 Symptomkarte entfernt. Die Wahrscheinlichkeit für Glücksrelikte erhöht sich um 50 %"
  },
  State_2405_Desc = {
    Text = "Temporäre Änderung der Kartenrechenleistung"
  },
  State_2405_Name = {
    Text = "Temporäre Änderung der Kartenrechenleistung"
  },
  State_2405_WeaponDesc = {
    Text = "Temporäre Änderung der Kartenrechenleistung"
  },
  State_2406_Desc = {
    Text = "Wenn die letzte 1 Arithmetica aufgebraucht wird, gewinne 2 Arithmetica. Dies kann pro Runde maximal 2 Mal ausgelöst werden"
  },
  State_2407_Name = {
    Text = "Beobachtungswert"
  },
  State_2408_Name = {
    Text = "Seemannspfeife"
  },
  State_2409_Desc = {
    Text = "In dieser Runde reduziert sich die Rechenleistungskosten für das Ausspielen einer Karte um 1 für jede gespielte [Schlag]-Karte"
  },
  State_2409_Name = {
    Text = "Klinge des Trotzes"
  },
  State_2409_WeaponDesc = {
    Text = "In dieser Runde reduziert sich die Rechenleistungskosten für das Ausspielen einer Karte um 1 für jede gespielte [Schlag]-Karte"
  },
  State_2410_Desc = {
    Text = "Kann 1 Runde nicht agieren. Feindliche Wesen, die versteinert sind, können keinen weiteren Versteinerungseffekt erhalten"
  },
  State_2410_Name = {
    Text = "<PetrifactionIconKeywords: Versteinerung>"
  },
  State_2410_WeaponDesc = {
    Text = "Betäubt das Monster für eine Runde"
  },
  State_2411_Desc = {
    Text = "Am Ende der Runde wird auf das Team [Layer] Schichten Bluten angewendet"
  },
  State_2411_Name = {
    Text = "Blutlaterne"
  },
  State_2411_WeaponDesc = {
    Text = "Am Ende der Runde wird auf das Team [Layer] Schichten Bluten angewendet"
  },
  State_2412_Desc = {
    Text = "Der Schaden im nächsten Zug wird verdoppelt"
  },
  State_2412_Name = {
    Text = "Verzweifeltes Überleben"
  },
  State_2412_WeaponDesc = {
    Text = "Der Schaden im nächsten Zug wird verdoppelt"
  },
  State_2413_Desc = {
    Text = "Wahnsinn durch Schlag und VERT um [Layer] % reduziert."
  },
  State_2413_Name = {Text = "Leere"},
  State_2413_WeaponDesc = {
    Text = "Wahnsinn durch ANG und VERT [StateArg1] %"
  },
  State_2415_Desc = {
    Text = "Wenn du in der letzten Runde Schaden erlitten hast, erhältst du zu Beginn der Runde 1 Runde Immunität"
  },
  State_2415_Name = {Text = "Anpassung"},
  State_2415_WeaponDesc = {
    Text = "Wenn du in der letzten Runde Schaden erlitten hast, erhältst du zu Beginn der Runde 1 Runde Immunität"
  },
  State_2416_Desc = {
    Text = "Leben und Schaden seiner beschworenen Monster verdoppeln sich"
  },
  State_2416_Name = {
    Text = "“Wachswelt“"
  },
  State_2416_WeaponDesc = {
    Text = "Leben und Schaden seiner beschworenen Monster verdoppeln sich"
  },
  State_24174_Desc = {
    Text = "Dieser Erwachte wird nicht mehr durch Schaden unter 1 Leben fallen"
  },
  State_24174_Name = {
    Text = "Todimmunität"
  },
  State_2418_Desc = {
    Text = "[Exaltieren] verleiht 30 Wahnsinn"
  },
  State_2418_Name = {
    Text = "Schleier des Gottes der Verwandlung"
  },
  State_2418_WeaponDesc = {
    Text = "[Exaltieren] verleiht 30 Wahnsinn"
  },
  State_2419_Name = {
    Text = "Schöpfung Weißer Spiegel"
  },
  State_2420_Desc = {
    Text = "In dieser Runde reduziert sich die Rechenleistungskosten für das Ausspielen einer Karte um 1 für jede gespielte [VERT]-Karte"
  },
  State_2420_Name = {
    Text = "Präzisionshieb"
  },
  State_2420_WeaponDesc = {
    Text = "In dieser Runde reduziert sich die Rechenleistungskosten für das Ausspielen einer Karte um 1 für jede gespielte [VERT]-Karte"
  },
  State_24210_Desc = {
    Text = "In dieser Runde zielt der ANG der Tentakel des Gottkönigs auf alle Feinde"
  },
  State_24210_Name = {
    Text = "Göttliches Armglied - Schlüssel"
  },
  State_24211_Desc = {
    Text = "·Am Rundenende füge vorderen Feinden [DescArg4] Mal [DescArg2] Schaden zu, bei Tötung +[DescArg3] Schaden, max. 5x (aktuell [DescArg6]).\n·Jedes Mal, wenn ein Erwecker die Verherrlichung nutzt, verursacht er in dieser Runde einen zusätzlichen ANG.\n·Nach dem Schlüsselbefehl des Schutzherrn wird das ANGsziel für diese Runde auf alle Feinde geändert; im Anführer Kampf erhöht sich der Schaden durch “Göttliches Armglied“ zusätzlich um [DescArg5]."
  },
  State_24211_Name = {
    Text = "Göttliches Armglied"
  },
  State_24213_Name = {
    Text = "Wenn diese Karte in der Hand ist, erhält man am Ende der Runde 150 Punkte s-Energie"
  },
  State_24214_Desc = {
    Text = "·Rundenende, füge vorderen Feinden [DescArg2] Schaden zu"
  },
  State_24214_Name = {
    Text = "Göttliches Armglied"
  },
  State_24215_Desc = {
    Text = "·Rundenende, füge vorderen Feinden [DescArg2] Schaden zu, bei Tötung +[DescArg3] Schaden, max. 5x (aktuell [DescArg4])"
  },
  State_24215_Name = {
    Text = "Göttliches Armglied"
  },
  State_24217_Name = {
    Text = "Entfernt eigene <VulnerabilityIconKeywords:Verwundbarkeit>, <WeaknessIconKeywords:Schwäche> und <FragileIconKeywords:Zerbrechlichkeit> Zustände"
  },
  State_24220_Name = {
    Text = "Erhalte [DescArg1] Schildpunkte"
  },
  State_24222_Desc = {
    Text = "·Rundenende, füge vorderen Feinden [DescArg4] Mal [DescArg2] Schaden zu, bei Tötung +[DescArg3] Schaden, max. 5x (aktuell [DescArg5]).\n·Bei jeder Verwendung der Verherrlichung durch einen Erwecker, zusätzlich 1 ANG in dieser Runde ausführen.\n·Bei Schlüsselbefehl des Schutzherrn, ANGsziel für diese Runde auf alle Feinde ändern."
  },
  State_24222_Name = {
    Text = "Göttliches Armglied"
  },
  State_24223_Desc = {
    Text = "·Rundenende, füge vorderen Feinden [DescArg2] Schaden zu, bei Tötung +[DescArg3] Schaden, max. 5x (aktuell [DescArg4]).\n·Bei Schlüsselbefehl des Hüters, ANGsziel für diese Runde auf alle Feinde"
  },
  State_24223_Name = {
    Text = "Göttliches Armglied"
  },
  State_24224_Desc = {
    Text = "·Rundenende, füge vorderen Feinden [DescArg4] Mal [DescArg2] Schaden zu, bei Tötung +[DescArg3] Schaden, max. 5x (aktuell [DescArg5]).\n·Jedes Mal, wenn der Erwecker die Verherrlichung einsetzt, erfolgt ein zusätzlicher ANG in dieser Runde."
  },
  State_24224_Name = {
    Text = "Göttliches Armglied"
  },
  State_24226_Desc = {
    Text = "·Am Rundenende füge vorderen Feinden [DescArg4] Mal [DescArg2] Schaden zu; bei Tötung des Gegners erhöht sich der Schaden um [DescArg3], maximal 5 Mal (aktuell [DescArg6] Mal).\n·Jedes Mal, wenn ein Erwecker die Verherrlichung nutzt, erfolgt in dieser Runde ein zusätzlicher ANG. \n·Im Anführer Kampf, jedes Mal wenn der Schutzherr die Posse verwendet, erhöht sich der Schaden von “Göttliches Armglied“ um [DescArg5]."
  },
  State_24226_Name = {
    Text = "Göttliches Armglied"
  },
  State_24227_Desc = {
    Text = "·Am Rundenende füge vorderen Feinden [DescArg2] Schaden zu, bei Tötung +[DescArg3] Schaden, max. 5x (aktuell [DescArg5]).\n·Nach Verwendung des Schlüsselbefehls durch den Schutzherrn wird das ANGsziel für diese Runde auf alle Feinde geändert, im Bosskampf erhöht sich der Schaden durch “Göttliches Armglied“ zusätzlich um [DescArg4]."
  },
  State_24227_Name = {
    Text = "Göttliches Armglied"
  },
  State_2422_Desc = {
    Text = "Nach dem Ausspielen erhält man [StateArg1] Schild"
  },
  State_2422_Name = {
    Text = "<Rune_6:Eiserne Mauer>"
  },
  State_24245_Desc = {
    Text = "Am Ende der Runde belebst du alle “Hydra“-Clans wieder. Bei jedem Tod eines Clans verringere 1 Schicht; wenn die Stapelungen 0 erreichen, verwandelt sich die “Hydra“ in eine endgültige Kampfgestalt."
  },
  State_24245_Name = {
    Text = "Schlangenmanöver"
  },
  State_24247_Desc = {
    Text = "Schaden um 90 % reduziert. Wenn zu Beginn der Runde keine „Tausend Schlangen“-Schichten vorhanden sind, wird dieser Zustand entfernt"
  },
  State_24247_Name = {
    Text = "Schlangenbarriere"
  },
  State_2425_Desc = {
    Text = "Nach dem Ausspielen wird es verbraucht. Wenn es eine Befehlskarte ist, wird ihr Schaden und Schutz verdoppelt"
  },
  State_2425_Name = {
    Text = "<CardKeyWord:Auflösen>"
  },
  State_2426_Desc = {
    Text = "Die erste Karte, die du in jeder Runde spielst, hat 1 zusätzliche Wirkung, aber maximal 4 Karten können pro Runde gespielt werden."
  },
  State_2427_Name = {
    Text = "Status@TraumSilberschlüssel:BlutHerzZählen"
  },
  State_2428_Desc = {
    Text = "Die Anzahl der <ParcloseIconKeywords:Barrieren> der Blume des Bösen erhöht sich um [Layer] Schichten"
  },
  State_2428_Name = {
    Text = "Verfluchter Schild"
  },
  State_2428_WeaponDesc = {
    Text = "Die Anzahl der Barrieren der Blume des Bösen erhöht sich um [Layer] Schichten"
  },
  State_24292_Name = {
    Text = "Rückreihe nach vorne"
  },
  State_24293_Name = {
    Text = "Vorderreihe nach hinten verschieben"
  },
  State_2429_Desc = {
    Text = "Verursachter Gesamtschaden um [Layer] % reduziert"
  },
  State_2429_Name = {
    Text = "Temporäre Schadensreduzierung"
  },
  State_2429_WeaponDesc = {
    Text = "Verursachter Gesamtschaden um [Layer] % reduziert"
  },
  State_2430_Desc = {
    Text = "Zu Beginn des Kampfes erhalten alle Verbündeten 3 Schichten[Wachstumsrüstung]. Am Ende der Runde erleidet das eigene Team [Arg1] Schichten Bluten"
  },
  State_2430_Name = {
    Text = "“ Wachsadel “"
  },
  State_2430_WeaponDesc = {
    Text = "Zu Beginn des Kampfes erhalten alle Verbündeten 3 Schichten[Wachstumsrüstung]. Am Ende der Runde erleidet das eigene Team [Arg1] Schichten Bluten"
  },
  State_2431_Desc = {
    Text = "Team Unique: Die Schilde und die Lebensregeneration des Ausrüsters erhöhen sich um <WeaponEffect_Num:[StateArg1]%> seines KON. Der durch den Ausrüster verursachte Gegenangriff erhöht sich um <WeaponEffect_Num:[StateArg3]%>. Beim Ausspielen von “VERT“ erhält man außerdem einen Gegenangriff in Höhe von <WeaponEffect_Num:[StateArg4]%> der VERT des Ausrüsters. Nach Kampfbeginn erhältst du eine Stärke in Höhe von <WeaponEffect_Num:[StateArg2]%> seines KON. Wenn das aktuelle Reich “Aequor“ ist, erhältst du zusätzlich den gleichen Betrag an Tentakelschaden."
  },
  State_2431_WeaponDesc = {
    Text = "Der Ausrüster verursacht eine Erhöhung des Schildes und der Lebensregeneration um <WeaponEffect_Num:[DescArg1]> Punkte, die Gegenangriffe des Ausrüsters erhöhen sich um <WeaponEffect_Num:[StateArg3]%>. Beim Ausspielen der “VERT“ erhält man zusätzlich <WeaponEffect_Num:[Counterattack:DescArg3]> Schichten <RetaliateIconKeywords:Gegenangriff>. Nach Kampfbeginn erhält der Ausrüster <WeaponEffect_Num:[Power:DescArg2]> Punkte <PowerIconKeywords:Stärke>. Wenn das aktuelle Reich “Aequor“ ist, erhält man zusätzlich den gleichen Betrag an Tentakelschaden."
  },
  State_2432_Desc = {
    Text = "Erlittener Aktiver Schaden und Tentakelschaden +50%, am Zugende wird 1 Stapelung entfernt."
  },
  State_2432_Name = {
    Text = "<VulnerabilityIconKeywords:Verwundbarkeit>"
  },
  State_2432_WeaponDesc = {
    Text = "Erhöhter Gesamtschaden um 50 %"
  },
  State_2433_Desc = {
    Text = "Am Ende jeder Runde [Layer] Stärke erhalten"
  },
  State_2433_Name = {Text = "Wut"},
  State_2434_Name = {
    Text = "Schmuckstück Raum 36 Ring"
  },
  State_2434_WeaponDesc = {
    Text = "Wenn du die Karte des Ausrüsters ziehst, variiert seine Arithmetica zufällig zwischen 0 und 3"
  },
  State_2435_Desc = {
    Text = "Ereignis 19_2"
  },
  State_2435_Name = {
    Text = "Ereignis 19_2"
  },
  State_2435_WeaponDesc = {
    Text = "Ereignis 19_2"
  },
  State_2436_Desc = {
    Text = "Erhalte 50% weniger Kraft und Schild, für [Layer] Runden"
  },
  State_2436_Name = {
    Text = "Temporärer Fluch"
  },
  State_2436_WeaponDesc = {
    Text = "Vor Rundenende immun gegen positive Zustände"
  },
  State_2438_Desc = {
    Text = "Status@Schöpfung Silberne Differenzmaschine Zählung"
  },
  State_2438_Name = {
    Text = "Status@Schöpfung Silberne Differenzmaschine Zählung"
  },
  State_2438_WeaponDesc = {
    Text = "Status@Schöpfung Silberne Differenzmaschine Zählung"
  },
  State_2440_Name = {
    Text = "Ziehe 1 Karte"
  },
  State_2441_Name = {
    Text = "Erhalte 1 Punkt Arithmetica"
  },
  State_2442_Name = {
    Text = "Fügt allen Feinden 1 Schicht <VulnerabilityIconKeywords:Verwundbarkeit> zu"
  },
  State_2443_Name = {
    Text = "Fügt allen Feinden 1 Schicht <WeaknessIconKeywords:Schwäche> zu"
  },
  State_2444_Name = {
    Text = "Erhalte <Energy:[DescArg1]> Wahnsinn"
  },
  State_2445_Name = {
    Text = "Andere Erwachte erhalten <Energy:[DescArg1]> Wahnsinn"
  },
  State_2446_Name = {
    Text = "Füge 1 Karte <DerivativeCardKeywords_4:„Inspiration“> dem Ziehstapel hinzu"
  },
  State_2447_Desc = {
    Text = "Team Unique: Die Krit. Rate und der kritische Schaden der Befehlskarten des Ausrüsters sowie der durch die Befehlskarten verursachte Schild, die Lebensregeneration, der Aliemus und die Stärke erhöhen sich um <WeaponEffect_Num:[StateArg1]%. Wenn das aktuelle Reich “Ultra“ ist, erhältst du nach der Freigabe von “Vernichtung“ <WeaponEffect_Num:[StateArg2]> Punkte Keyflare. Nach dem Betreten der Ultra-Runde wird das nächste Posse in dieser Runde 2 Mal freigegeben."
  },
  State_2447_WeaponDesc = {
    Text = "Die kritische Rate und der kritische Schaden der Befehlskarten des Ausrüsters sowie der Schild, die Lebensregeneration, der Aliemus und die Stärke der Befehlskarten erhöhen sich um <WeaponEffect_Num:[StateArg1]%. Wenn das aktuelle Reich “Ultra“ ist, erhältst du nach der Freisetzung von “Vernichtung“ <WeaponEffect_Num:[StateArg2]> Punkte Keyflare. Nach Eintritt in die Ultra-Runde wird das nächste Posse in dieser Runde 2 Mal freigegeben."
  },
  State_2448_Desc = {
    Text = "Karten werden nicht in der Ablagephase in den Ablagestapel gelegt, sondern bleiben im Handkartenbereich"
  },
  State_2448_Name = {
    Text = "<CardKeyWord:Behalten>"
  },
  State_2449_Desc = {
    Text = "Nach tatsächlichem Schaden erhält man [Layer] Schild"
  },
  State_2449_Name = {Text = "Puffer"},
  State_2449_WeaponDesc = {
    Text = "Nach tatsächlichem Schaden erhält man [Layer] Schild"
  },
  State_2450_Desc = {
    Text = "“Schaden“ ist garantiert ein kritischer Treffer. Der kritische Schaden wird um 50% erhöht"
  },
  State_2451_Desc = {
    Text = "Am Ende der Runde, andere Verbündete erhalten [Layer] Stärke"
  },
  State_2451_Name = {
    Text = "Licht der Erleuchtung"
  },
  State_2452_Desc = {
    Text = "Nach dem Ausspielen erhält man [StateArg1] Kraft"
  },
  State_2452_Name = {
    Text = "<Rune_14_High:Hochbrutalität>"
  },
  State_2453_Name = {
    Text = "Schmuckstück Photosynthese-Ritual"
  },
  State_2453_WeaponDesc = {
    Text = "Nach Kampfbeginn erhalten alle Karten des Trägers Behalten"
  },
  State_2454_Desc = {
    Text = "Nach dem Ausspielen wird nicht in den Ablagestapel gelegt, sondern aus dem Deck entfernt"
  },
  State_2454_Name = {
    Text = "<DepleteIconKeywords:Verbrauch>"
  },
  State_2454_WeaponDesc = {
    Text = "Nach dem Ausspielen wird die Karte nicht in den Ablagestapel gelegt und kann in diesem Kampf nicht erneut verwendet werden"
  },
  State_24556_Name = {
    Text = "Status@GroßmagierHoudini@GlücklicherZuschauerApplausHinzufügen"
  },
  State_2455_Name = {
    Text = "Zustand @ Blauflammentänzerin erleuchten 7"
  },
  State_24560_Desc = {
    Text = "Immer wenn du den Schlüsselbefehl verwendest, erhöht sich die temporäre kritische Trefferquote und der temporäre kritische Schaden von Ramona um 25%"
  },
  State_24560_Name = {
    Text = "Kleinreisender"
  },
  State_24562_Desc = {
    Text = "Nach dem Ende der Runde erhalte 1 Schicht Negentropie"
  },
  State_24562_Name = {
    Text = "Penrose-Wanderer"
  },
  State_24564_Desc = {
    Text = "Jedes Mal, wenn 3 Schichten Negentropie vorhanden sind, verbraucht das Spielen von Ramonahs Befehlskarte alle Negentropie und löst einen zusätzlichen Effekt aus, maximal 3 Schichten"
  },
  State_24564_Name = {
    Text = "Negentropie"
  },
  State_2456_Name = {
    Text = "Zustand @ Blauflammentänzerin erleuchten 15"
  },
  State_2457_Name = {
    Text = "Ziehe 1 Karte"
  },
  State_24584_Name = {
    Text = "Status@N Klon@Flüstern1 Statuswechsel"
  },
  State_2458_Name = {
    Text = "Status@Schmuck Scharlachrote Umarmung Effekt Zählung"
  },
  State_24593_Desc = {
    Text = "Wenn die Schicht 0 erreicht, wird die Absicht in „Schwarze Beschwörung“ geändert, und am Ende der Runde wird 1 Schicht abgezogen, maximal 4 Schichten"
  },
  State_24593_Name = {Text = "Chaos"},
  State_24595_Desc = {
    Text = "Nach dem Tod wird „N“ um 1 Schicht „Chaos“ reduziert"
  },
  State_24595_Name = {
    Text = "Verbreitung"
  },
  State_24596_Desc = {
    Text = "Beschwöre „N“s Klone, für jede Schicht „Dunkelheit“ wird ein Klon beschworen"
  },
  State_24596_Name = {Text = "Dunkelheit"},
  State_2460_Desc = {
    Text = "Einzigartig im Team: Die Grundschäden, <IntoxicationIconKeywords:Gift> und <RetaliateIconKeywords:Gegenangriff> des Ausrüsters werden um <WeaponEffect_Num:[StateArg1]%> erhöht, die kritische Rate und der kritische Schaden erhöhen sich um <WeaponEffect_Num:[StateArg2]%"
  },
  State_2460_WeaponDesc = {
    Text = "Der Ausrüstende verursacht eine Erhöhung des Grundschadens, <IntoxicationIconKeywords:Vergiftung> und <RetaliateIconKeywords:Retaliation> um <WeaponEffect_Num:[StateArg1]%>, die kritische Rate und kritischen Schaden erhöhen sich um <WeaponEffect_Num:[StateArg2]%>"
  },
  State_2461_Desc = {
    Text = "Bei tödlichem Schaden in diesem Kampf wiederbeleben, [Layer] Lebenspunkte wiederherstellen und allen Erwachten [StateArg1] Wahnsinn gewähren, nicht vertreibbar."
  },
  State_2461_Name = {
    Text = "Unsterblicher Paradiesvogel"
  },
  State_2463_Desc = {
    Text = "Zu Beginn des Kampfes erhält Embryo-Fusion +20%. Für jeden Erwecker mit vollem Aelius erhöht sich die Embryo-Fusion um zusätzlich +20%"
  },
  State_24640_Desc = {
    Text = "Nach Kampfbeginn Embryofusion +[Blood:DescArg1]. Bei jeder Auslösung von Todwiderstand Embryofusion +[Blood:DescArg1]. Jedes Mal, wenn Sorel Schaden verursacht, erhöht sich der in dieser Runde verursachte Schaden um einen Betrag, der 4% der ANG entspricht."
  },
  State_24640_Name = {Text = "Perle"},
  State_2464_Desc = {
    Text = "Kartenrechenleistung erhöht"
  },
  State_2464_Name = {
    Text = "Permanenter Anstieg der Kartenrechenleistung"
  },
  State_2464_WeaponDesc = {
    Text = "Kartenrechenleistung erhöht"
  },
  State_24654_Desc = {
    Text = "Nachdem Narzisse den Feind auf jede Weise besiegt hat, wird die kritische Rate des Teams in diesem Level permanent um 5% erhöht, maximal fünfmal stapelbar. (Aktueller Stapel [DescArg1] Mal)"
  },
  State_24654_Name = {
    Text = "Gierige Graue Nebel"
  },
  State_2466_Desc = {
    Text = "Bis zum Beginn des nächsten Zuges greift der Tentakel für jede erlittene Schadensinstanz den Angreifer einmal mit einem Gegenangriff an. Temporärer Tentakelschaden +[Layer]."
  },
  State_2466_Name = {
    Text = "[Discarded] Blutlinie der Häresie"
  },
  State_24678_Name = {
    Text = "Status@N Klon@Flüstern2 Statuswechsel"
  },
  State_24679_Name = {
    Text = "Status@N Klon3@Flüstern6 Statuswechsel"
  },
  State_2467_Desc = {
    Text = "Zustand @ Prolog Offensivanalyse"
  },
  State_2467_Name = {
    Text = "Zustand @ Prolog Offensivanalyse"
  },
  State_2467_WeaponDesc = {
    Text = "Zustand @ Prolog Offensivanalyse"
  },
  State_24680_Name = {
    Text = "Status@N Klon2@Flüstern1 Statuswechsel"
  },
  State_24681_Name = {
    Text = "Status@N Klon@Flüstern6 Statuswechsel"
  },
  State_24682_Name = {
    Text = "Status@N Klon3@Flüstern3 Statuswechsel"
  },
  State_24683_Name = {
    Text = "Status@N Klon2@Flüstern2 Statuswechsel"
  },
  State_24684_Name = {
    Text = "Status@N Klon@Flüstern4 Statuswechsel"
  },
  State_24685_Name = {
    Text = "Status@N Klon@Flüstern5 Statuswechsel"
  },
  State_24686_Name = {
    Text = "Status@N Klon3@Flüstern5 Statuswechsel"
  },
  State_24687_Name = {
    Text = "Status@N Klon3@Flüstern2 Statuswechsel"
  },
  State_24688_Name = {
    Text = "Status@N Klon2@Flüstern6 Statuswechsel"
  },
  State_24689_Name = {
    Text = "Status@N Klon3@Flüstern4 Statuswechsel"
  },
  State_24690_Name = {
    Text = "Status@N Klon3@Flüstern1 Statuswechsel"
  },
  State_24691_Name = {
    Text = "Status@N Klon2@Flüstern4 Statuswechsel"
  },
  State_24692_Name = {
    Text = "Status@N Klon2@Flüstern3 Statuswechsel"
  },
  State_24693_Name = {
    Text = "Status@N Klon@Flüstern3 Statuswechsel"
  },
  State_24694_Name = {
    Text = "Status@N Klon2@Flüstern5 Statuswechsel"
  },
  State_2470_Desc = {
    Text = "Beim Aufheben wird permanent [Arg1] Punkte Alarm verloren, der verursachte aktive Schaden erhält zusätzlich einen Bonus von 1-facher Macht"
  },
  State_24719_Desc = {
    Text = "“@2“ ist in befreiter Form erschienen, Leben verdreifacht"
  },
  State_24719_Name = {
    Text = "Schicksalswiederbelebung"
  },
  State_24719_WeaponDesc = {
    Text = "Nach Beginn der nächsten Runde, erhalte Schild in Höhe des verlorenen Lebens der letzten Runde"
  },
  State_2471_Desc = {
    Text = "Zu Beginn der Runde verringert unser Team 1 Alarm"
  },
  State_2471_Name = {Text = "Verfall"},
  State_2471_WeaponDesc = {
    Text = "Zu Beginn der Runde verringert unser Team 1 Alarm"
  },
  State_24720_Desc = {
    Text = "Die Macht des unbekannten Wesens verweilt weiterhin unter der schwarzen Pfütze und wird kurz vor der Niederlage vollständig erwachen, das Leben wiedererlangen und im Geiste der Befreiung den Kampf beginnen"
  },
  State_24720_Name = {
    Text = "Ruhezustand"
  },
  State_2472_Desc = {
    Text = "Gleichzeitig Schaden an Schild und Leben verursachen und kann nicht immunisiert werden"
  },
  State_2472_Name = {
    Text = "<PunctureDamagewords:Stichschaden>"
  },
  State_2472_WeaponDesc = {
    Text = "Durchbohrungsschaden ignoriert Schilde und Schadensminderung, verursacht direkt Schaden"
  },
  State_24730_Desc = {
    Text = "Vorübergehende Erhöhung des Hyperraum, max. 10. Beim nächsten Eintritt in die Hyperraumrunde werden die Karten aus dem vorübergehenden Hyperraum in die Hand gelegt und der vorübergehende Hyperraum entfernt"
  },
  State_24730_Name = {
    Text = "<CardKeyWord:Temporärer Hyperraum>"
  },
  State_24737_Desc = {
    Text = "Zu Rundenbeginn verursachen Sie Bluten beim Gegner; jede Schicht Schicksal verursacht [StateArg1] Punkte Bluten"
  },
  State_24737_Name = {Text = "Schicksal"},
  State_24738_Desc = {
    Text = "Bei jeder 1 Schicht Schicksal wird [StateArg1] Punkte Blutung verursacht, für jede ausgespielte Karte wird 1 Schicht Schicksal verringert"
  },
  State_24738_Name = {Text = "Schicksal"},
  State_24739_Name = {Text = "Schicksal"},
  State_2473_Desc = {
    Text = "[VERT] verliert 1 Tentakel, stellt [StateArg1] Leben wieder her. [Schlag] verliert [StateArg2] Leben, erzeugt 1 Tentakel"
  },
  State_2473_Name = {
    Text = "Fleisch des Unsterblichen der Schöpfung"
  },
  State_2473_WeaponDesc = {
    Text = "[VERT] verliert 1 Tentakel, stellt [StateArg1] Leben wieder her. [Schlag] verliert [StateArg2] Leben, erzeugt 1 Tentakel"
  },
  State_2474_Desc = {
    Text = "Erhöht den ANG um [Layer]%"
  },
  State_2474_Name = {
    Text = "Allgemeiner ANGsprozentsatz erhöht"
  },
  State_2474_WeaponDesc = {
    Text = "Erhöht den ANG um [Layer]%"
  },
  State_2475_Desc = {
    Text = "Team-Einzigartig: Der aktive Schaden, der vom Träger verursacht wird, erhöht sich um <WeaponEffect_Num:[StateArg3]%.> Nach dem Ausspielen oder Abwerfen einer Befehlskarte des Trägers füge einem zufälligen Gegner <WeaponEffect_Num:[StateArg1]%> des ATK des Trägers als <IntoxicationIconKeywords:Gift> zu. Nach dem Ende der Ultra-Runde besteht eine <WeaponEffect_Num:[StateArg2]%> Chance, 100% Gift für alle Gegner auszulösen."
  },
  State_2475_WeaponDesc = {
    Text = "Der aktive Schaden des Ausrüsters erhöht sich um <WeaponEffect_Num:[DescArg2]> Punkte. Nach dem Spielen oder Abwerfen einer Befehlskarte des Ausrüsters wird einem zufälligen Feind <WeaponEffect_Num:[DescArg1]> Stapelungen <IntoxicationIconKeywords:Gift> zugefügt. Nach dem Ende der Ultra-Runde besteht eine Wahrscheinlichkeit von <WeaponEffect_Num:[StateArg2]>%, dass [DescArg3]% Gift auf alle Feinde ausgelöst wird."
  },
  State_2476_Name = {
    Text = "Zustand @ Genesis Wissender erleuchten 1"
  },
  State_2478_Desc = {
    Text = "Der Schild, den Nautilus gewährt, wird verdoppelt"
  },
  State_2478_Name = {
    Text = "Wartungsexperte"
  },
  State_2478_WeaponDesc = {
    Text = "Der Schild, den Nautilus gewährt, wird verdoppelt"
  },
  State_2479_Desc = {
    Text = "Jedes Mal, wenn Smaragdfire Schaden verursacht, +1 Stapel"
  },
  State_2479_Name = {
    Text = "Smaragdspiegel-Zählung"
  },
  State_2479_WeaponDesc = {
    Text = "Jedes Mal, wenn Smaragdfire Schaden verursacht, +1 Stapel"
  },
  State_2480_Desc = {
    Text = "Heile Lebenspunkte und erhalte [StateArg1] Theke. Für jede Karte, die der Abgrundbewohner zieht, heile 1 Lebenspunkt"
  },
  State_2480_Name = {
    Text = "Metamorphosierter Körper"
  },
  State_2481_Desc = {
    Text = "Status@PrologDeckReset0_2_3_1"
  },
  State_2481_Name = {
    Text = "Status@PrologDeckReset0_2_3_1"
  },
  State_2481_WeaponDesc = {
    Text = "Status@PrologDeckReset0_2_3_1"
  },
  State_2482_Desc = {
    Text = "Unter 50% Leben beschwört ein „Erosionsdreieck“ mit gleicher Lebensmenge"
  },
  State_2482_Name = {
    Text = "Beschwören"
  },
  State_2482_WeaponDesc = {
    Text = "Unter 50% Leben beschwört ein „Erosionsdreieck“ mit gleicher Lebensmenge"
  },
  State_2486_Desc = {
    Text = "Zu Rundenbeginn erhalten Sie 1 Arithmetica für jeden Gegner. Wenn Sie einen Gegner mit Schaden töten, fügen Sie anderen Gegnern Bluten zu, das dem überschüssigen Schaden entspricht"
  },
  State_24879_Desc = {
    Text = "Tausend Jahre vergehen, zehntausend Jahre vergehen, sie warten in den ewigen Ruinen auf Gunst. Nach dem Tod wird sofort eine Schicht „Chaos“ von „N“ entfernt und „N“ erhält [DescArg1] Schild und [DescArg2] Kraft"
  },
  State_24879_Name = {Text = "Wahnwesen"},
  State_2488_Desc = {
    Text = "Wenn du eine Buffkarte, Symptomkarte oder Zustandkarte spielst, erhält der Erwecker mit dem niedrigsten Aliemus 10 Aliemus."
  },
  State_2489_Desc = {
    Text = "Kritische Rate +10%. Nach dem ersten kritischen Treffer in jeder Runde erhöht sich die kritische Rate um 20%. Nach dem dritten kritischen Treffer in jeder Runde erhöht sich der kritische Schaden um 50%"
  },
  State_2490_Desc = {
    Text = "Jede Schicht erhöht die ANGe um 1, verliert 1 Schicht bei Schaden, verliert alle am Rundenende"
  },
  State_2490_Name = {Text = "Beten"},
  State_2491_Desc = {
    Text = "Erhalte gleichwertigen Schild bei Heilung"
  },
  State_2491_Name = {
    Text = "Temporäre Versteifung"
  },
  State_2492_Desc = {
    Text = "Pro Runde immun gegen den ersten aktiven Schaden"
  },
  State_2492_Name = {Text = "Festigkeit"},
  State_2492_WeaponDesc = {
    Text = "Pro Runde immun gegen den ersten aktiven Schaden"
  },
  State_2493_Desc = {
    Text = "Verringert den verursachten aktiven Schaden um [Layer]"
  },
  State_2493_Name = {Text = "STR▼"},
  State_2494_Desc = {
    Text = "Status@PrologWahnsinn0_1_4_1"
  },
  State_2494_Name = {
    Text = "Status@PrologWahnsinn0_1_4_1"
  },
  State_2494_WeaponDesc = {
    Text = "Status@PrologWahnsinn0_1_4_1"
  },
  State_2495_Desc = {
    Text = "Status@PrologWahnsinn0_1_4_2"
  },
  State_2495_Name = {
    Text = "Status@PrologWahnsinn0_1_4_2"
  },
  State_2495_WeaponDesc = {
    Text = "Status@PrologWahnsinn0_1_4_2"
  },
  State_24968_Desc = {
    Text = "Nach Kampfbeginn Embryofusion +[Blood:DescArg2]. Bei jeder Auslösung von Todwiderstand Embryofusion +[Blood:DescArg2]. Jedes Mal, wenn Sorel Schaden verursacht, erhöht sich der in dieser Runde verursachte Schaden um [DescArg1] Punkte."
  },
  State_24968_Name = {Text = "Perle"},
  State_2496_Desc = {
    Text = "Zu Beginn der Runde regenerierst du [Arg1] Leben. Wenn dein Leben unter 50% liegt, regenerierst du [Arg2] Leben"
  },
  State_2496_Name = {
    Text = "Gesegnetes Blut"
  },
  State_24976_Desc = {
    Text = "“Die „Eclipsed Maiden“ ist bereits erwacht, sei vorsichtig vor den Gefahren der speziellen Gerichte!“"
  },
  State_24976_Name = {
    Text = "Gallen erwacht!"
  },
  State_24976_WeaponDesc = {
    Text = "Nach Beginn der nächsten Runde, erhalte Schild in Höhe des verlorenen Lebens der letzten Runde"
  },
  State_24977_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_24977_Name = {
    Text = "Nicht erweckt"
  },
  State_2497_Desc = {
    Text = "Lily wird die erste Befehlskarte, die der Spieler in jeder Runde spielt, nachahmen. Wenn es eine Schlagkarte ist, erhöht sich die Anzahl der ANGe von Lily um 1. Wenn es eine VERTskarte ist, erhält Lily ein Schild in Höhe von 10% ihres Lebens. Bei anderen Befehlskarten weiß Lily nicht, was passiert, und wird zuerst eine Eiterbeule hier freigeben."
  },
  State_2497_Name = {
    Text = "Lili erwacht!"
  },
  State_2497_WeaponDesc = {
    Text = "Nach Beginn der nächsten Runde, erhalte Schild in Höhe des verlorenen Lebens der letzten Runde"
  },
  State_2498_Name = {
    Text = "Schmuckstück Verfluchter Hase"
  },
  State_2498_WeaponDesc = {
    Text = "Der Schild und die Lebensregeneration des Trägers werden um 6% erhöht. Wenn die Domänenbeherrschung des Trägers über 50 liegt, wird der Schild und die Lebensregeneration zusätzlich um 6% erhöht"
  },
  State_2499_Name = {
    Text = "Stagnierender Fluch"
  },
  State_2500_Desc = {
    Text = "Jedes Mal, wenn man tatsächlichen Schaden verursacht, fügt man Gift hinzu"
  },
  State_2500_Name = {Text = "Toxin"},
  State_2501_Desc = {
    Text = "Team Unique: Das Lebenslimit des Teams erhöht sich um 10%. Die Heilung und der Schild des Ausrüsters erhöhen sich um <WeaponEffect_Num:[StateArg3]%. Nach dem Ausspielen des “Schlags“ des Ausrüsters werden <WeaponEffect_Num:[StateArg1]%> der verlorenen Lebenspunkte wiederhergestellt. Nach dem Ausspielen der “VERT“ des Ausrüsters erhält man einen Schild in Höhe von <WeaponEffect_Num:[StateArg2]%> des aktuellen Lebens. Dieser Effekt kann pro Runde maximal einmal ausgelöst werden."
  },
  State_2501_Name = {
    Text = "Seele geboren"
  },
  State_2501_WeaponDesc = {
    Text = "Die maximale Lebensgrenze des Teams erhöht sich um 10%. Die Heilung und der Schild, die vom Ausrüster verursacht werden, erhöhen sich um <WeaponEffect_Num:[StateArg3]%. Nach dem Spielen des “Schlags“ des Ausrüsters wird [StateArg1]% (<WeaponEffect_Num:[Heal:DescArg1]>) des verlorenen Lebens wiederhergestellt. Nach dem Spielen der “VERT“ des Ausrüsters erhält man [StateArg1]% (<WeaponEffect_Num:[Block:DescArg2]>) Schild basierend auf dem aktuellen Leben. Dieser Effekt kann pro Runde maximal einmal ausgelöst werden."
  },
  State_2502_Desc = {
    Text = "Gesamter ausgeteilter Aktiver Schaden und Tentakelschaden –50%."
  },
  State_2502_Name = {
    Text = "Lähmende Schwäche"
  },
  State_2502_WeaponDesc = {
    Text = "Verringert den verursachten Gesamtschaden um 50 %"
  },
  State_2503_Desc = {
    Text = "Team Unique: Der Grundschaden der Karten des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%. Zu Rundenbeginn besteht eine <WeaponEffect_Num:[StateArg2]%> Chance, eine zufällige Karte des Ausrüsters mit zusätzlichen Kosten auf die Hand zu ziehen. Wenn das aktuelle Reich “Fleisch“ ist, erhöht sich die kritische Rate des nächsten “Schlag“-Kartenangriffs des Ausrüsters in dieser Runde um <WeaponEffect_Num:+[StateArg3]%."
  },
  State_2503_WeaponDesc = {
    Text = "Der Grundschaden der Karten des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%.> Zu Beginn der Runde besteht eine <WeaponEffect_Num:[StateArg2]%> Chance, eine zufällige Karte des Ausrüsters auf die Hand zu ziehen, die zusätzliche Kosten verursacht. Wenn das aktuelle Reich “Fleisch“ ist, erhöht sich die kritische Trefferquote des nächsten “Schlag“-Kartenangriffs des Ausrüsters in dieser Runde um <WeaponEffect_Num:+[StateArg3]%>."
  },
  State_2504_Desc = {
    Text = "“Schaden“ erhält 2 Punkte Arithmetica, verworfen zufällig 1 Karte; „VERT“ zieht 2 Karten und verliert 1 Punkt Arithmetica"
  },
  State_25056_Desc = {
    Text = "Jedes Mal, wenn Arithmetica erschöpft wird, erhält Karen [Layer] Punkte temporäre Macht"
  },
  State_25056_Name = {
    Text = "satt und zufrieden"
  },
  State_25057_Desc = {
    Text = "Jedes Mal, wenn Arithmetica erschöpft wird, erhält Karen [StateArg1] Punkte temporäre Macht, entferne 1 Schicht am Ende der Runde"
  },
  State_25057_Name = {
    Text = "satt und zufrieden"
  },
  State_2505_Name = {
    Text = "Schmuckstück Aprilhymne"
  },
  State_2505_WeaponDesc = {
    Text = "Nach Kampfbeginn, wenn der Träger Überdimensional-Klasse ist, +25% ANGskraft"
  },
  State_2507_Desc = {
    Text = "Beim Aufnehmen erhöht sich die maximale Gesundheit um 100 %, zu Beginn der Runde verliere [Arg1] Punkte Leben"
  },
  State_2509_Name = {
    Text = "Status@Allgemeine Domäne Meisterschaft"
  },
  State_2511_Desc = {
    Text = "Status@PrologSchlüsselEnergieLehre"
  },
  State_2511_Name = {
    Text = "Status@PrologSchlüsselEnergieLehre"
  },
  State_2511_WeaponDesc = {
    Text = "Status@PrologDeckReset0_1_2_2"
  },
  State_2512_Desc = {
    Text = "Wenn du eine Karte spielst, die 3 oder mehr Arithmetica kostet, ziehe 1 Karte und erhalte 1 Punkt Arithmetica"
  },
  State_2514_Desc = {
    Text = "Schilde in diesem Kampf um [Layer] Punkte verringert"
  },
  State_2514_Name = {
    Text = "Wachsamkeit verringert"
  },
  State_2514_WeaponDesc = {
    Text = "Schilde in diesem Kampf um [Layer] Punkte verringert"
  },
  State_2515_Desc = {
    Text = "[Schlag] fügt allen Feinden [StateArg1] Schichten Gift zu"
  },
  State_2515_Name = {
    Text = "Schöpfung Nervengift"
  },
  State_25163_Desc = {
    Text = "Er ist so schwer fassbar wie Nebel"
  },
  State_25163_Name = {
    Text = "Schatten der Vergangenheit"
  },
  State_25165_Desc = {
    Text = "Zusätzlicher Effekt, der ausschließlich für Ramonas Befehlskarte gilt. Wird aktiviert, sobald 3 Schichten Negentropie vorhanden sind. Der Zyklus wird in den nächsten Kampf übertragen."
  },
  State_25165_Name = {
    Text = "<TimeBeacon:Schleife>"
  },
  State_25166_Desc = {
    Text = "Jedes Mal, wenn 3 Schichten Negentropie vorhanden sind, verbraucht das Spielen von Ramonahs Befehlskarte alle Negentropie und löst einen zusätzlichen Effekt aus, maximal 3 Schichten"
  },
  State_25166_Name = {
    Text = "<TimeBeacon2:Negentropie>"
  },
  State_2516_Desc = {
    Text = "Nicht ausspielbar"
  },
  State_2516_Name = {
    Text = "kann nicht ausführen"
  },
  State_2516_WeaponDesc = {
    Text = "Karte kann nicht ausgespielt werden"
  },
  State_25179_Name = {
    Text = "Wahnsinnsurteil"
  },
  State_2517_Desc = {
    Text = "Nachdem unser Team die Wutexplosion freigesetzt hat, verliert es in dieser Runde die Macht. Einmal pro Runde"
  },
  State_2517_Name = {
    Text = "Furcht vor Wahn"
  },
  State_25181_Name = {
    Text = "Wiedergeburtserhaltungseffekt"
  },
  State_2518_Desc = {
    Text = "Status@PrologDeckReset0_1_1_3"
  },
  State_2518_Name = {
    Text = "Status@PrologDeckReset0_1_1_3"
  },
  State_2518_WeaponDesc = {
    Text = "Status@PrologDeckReset0_1_1_3"
  },
  State_25194_Desc = {
    Text = "Nach dem Tod erhält „N“ [DescArg1] Schild und [DescArg2] permanente Stärke"
  },
  State_2519_Desc = {
    Text = "Status@PrologDeckReset0_1_1_3"
  },
  State_2519_Name = {
    Text = "Status@PrologDeckReset0_1_1_3"
  },
  State_2519_WeaponDesc = {
    Text = "Status@PrologDeckReset0_1_1_3"
  },
  State_25204_Name = {
    Text = "Status@N Klon2@Absichtserkennung"
  },
  State_25205_Name = {
    Text = "Status@N Klon3@Absichtserkennung"
  },
  State_25206_Name = {
    Text = "Status@N@Klon von N hinzufügen"
  },
  State_25207_Name = {
    Text = "Status@N Klon@Absichtserkennung"
  },
  State_2520_Desc = {
    Text = "Status@PrologDeckReset0_1_1_2"
  },
  State_2520_Name = {
    Text = "Status@PrologDeckReset0_1_1_2"
  },
  State_2520_WeaponDesc = {
    Text = "Status@PrologDeckReset0_1_1_2"
  },
  State_2522_Desc = {
    Text = "Hilo ist erwacht, ihre ANGskraft und ihr Verlangen werden steigen"
  },
  State_2522_Name = {
    Text = "Sirohs Erwachen"
  },
  State_2523_Desc = {
    Text = "Zu Beginn ungerader Runden erhältst du innerhalb dieser Runde [Arg1] Macht. Zu Beginn gerader Runden erhältst du innerhalb dieser Runde [Arg2] Punkte Alarm"
  },
  State_2524_Desc = {
    Text = "Zu Beginn des Kampfes erhält man 1 Stärke"
  },
  State_2524_Name = {
    Text = "Ruhmreiche Taten"
  },
  State_2525_Desc = {
    Text = "ANGszahl -1, erhalte [Schicht] Stärke"
  },
  State_2525_Name = {Text = "Lust"},
  State_2527_Name = {
    Text = "Scharlachroter Stärkebonus"
  },
  State_2528_Desc = {
    Text = "Wenn du eine Karte spielst, die tatsächlich 3 Arithmetica kostet, ziehe 1 Karte und erhalte 2 Arithmetica"
  },
  State_2529_Desc = {
    Text = "Innerhalb dieser Runde erhöht sich der kritische Schaden um [Layer] %"
  },
  State_2529_Name = {
    Text = "Temporärer Kritischer Schaden"
  },
  State_2529_WeaponDesc = {
    Text = "Innerhalb dieser Runde erhöht sich der kritische Schaden um [Layer] %"
  },
  State_2531_Desc = {
    Text = "Jedes Mal, wenn Smaragdfire [Damage:StateArg2] Schaden verursacht, erhältst du eine verbrauchte Karte [Grünflamme]"
  },
  State_2531_Name = {
    Text = "Smaragdgrüne Reflexion"
  },
  State_2531_WeaponDesc = {
    Text = "Jedes Mal, wenn Smaragdfire [Damage:StateArg2] Schaden verursacht, erhältst du eine verbrauchte Karte [Grünflamme]"
  },
  State_2532_Name = {
    Text = "Schmuckstück Scharlachrote Angst"
  },
  State_2534_Desc = {
    Text = "Status@PrologDeckReset0_1_3_3"
  },
  State_2534_Name = {
    Text = "Status@PrologDeckReset0_1_3_3"
  },
  State_2534_WeaponDesc = {
    Text = "Status@PrologDeckReset0_1_3_3"
  },
  State_2535_Desc = {
    Text = "Status@PrologDeckReset0_1_3_2"
  },
  State_2535_Name = {
    Text = "Status@PrologDeckReset0_1_3_2"
  },
  State_2535_WeaponDesc = {
    Text = "Status@PrologDeckReset0_1_3_2"
  },
  State_2536_Name = {
    Text = "Zustand @ temporäre ANGskarte kritischer Schaden erhöht"
  },
  State_2537_Desc = {
    Text = "Wenn die Traumklinge ein Schild anlegt, erhalte [StateArg2] Punkte temporären Alarm"
  },
  State_2537_Name = {
    Text = "Schlachtfeld-Einblick"
  },
  State_2537_WeaponDesc = {
    Text = "Wenn die Traumklinge ein Schild anlegt, erhalte [StateArg2] Punkte temporären Alarm"
  },
  State_2538_Desc = {
    Text = "Nach Ausspielen [StateArg1] <RetaliateIconKeywords:Gegenangriff> erhalten, füge allen Gegnern [StateArg2]% echten Schaden durch <RetaliateIconKeywords:Gegenangriff> zu"
  },
  State_2538_Name = {
    Text = "<Rune_9_High:Fortgeschrittene Spieß>"
  },
  State_25391_Desc = {
    Text = "Eine Einheit im Team wurde als „Glücklicher Zuschauer“ ausgewählt, alle Karten dieser Einheit haben „Applaus“-Effekt"
  },
  State_25391_Name = {
    Text = "Glückliches Publikum"
  },
  State_25392_Desc = {
    Text = "Nach dem Ausspielen verliert ihr 2% der maximalen Gesundheit, der große Magier erhält in dieser Runde 1 Schicht „Selbstgefälligkeit“"
  },
  State_25392_Name = {
    Text = "<CardCheerKeywords:Jubel>"
  },
  State_25401_Desc = {
    Text = "Diese Karte erhöht das Handkartenlimit um +1, wenn sie in der Hand ist"
  },
  State_25401_Name = {
    Text = "Ignorieren Sie das Handkartenlimit"
  },
  State_25403_Desc = {
    Text = "Tentakelschaden um 50% reduziert, pro Treffer [Layer] Schildpunkte"
  },
  State_25403_Name = {
    Text = "Ruhiges Meer"
  },
  State_25405_Desc = {
    Text = "Diese Karte bleibt unter allen Umständen in der Hand"
  },
  State_25405_Name = {
    Text = "permanent beibehalten"
  },
  State_25406_Desc = {
    Text = "In dieser Runde keine Tentakel-Formwechsel"
  },
  State_25406_Name = {
    Text = "Tiefseewahnsinn·Beschränkt"
  },
  State_25407_Desc = {
    Text = "Tentakelschaden +25%, Anzahl der Tentakel -1 am Rundenende"
  },
  State_25407_Name = {
    Text = "Tiefseewahnsinn"
  },
  State_25415_Desc = {
    Text = "Nach Schlüsselbefehl [Layer] Punkte Schlüsselenergie erhalten"
  },
  State_25415_Name = {
    Text = "Chaotische temporäre Energie voll"
  },
  State_25417_Name = {Text = "Bombe3"},
  State_25418_Name = {Text = "Bombe 2"},
  State_2542_Name = {
    Text = "Zähler der Schöpfung Namenloses Glied"
  },
  State_2543_Name = {
    Text = "Status@Stufe2_14Kampf8Blase1"
  },
  State_2544_Desc = {
    Text = "Status@PrologMonsterPassiv"
  },
  State_2544_Name = {
    Text = "Status@PrologMonsterPassiv"
  },
  State_2544_WeaponDesc = {
    Text = "Status@PrologMonsterPassiv"
  },
  State_2545_Desc = {
    Text = "Zu Beginn des Kampfes erhält Embryo-Fusion +20%. Für jeden Erwecker mit vollem Aelius erhöht sich die Embryo-Fusion um zusätzlich +20%"
  },
  State_2547_Desc = {
    Text = "Zu Beginn der Runde füge einen „Dreizack“ mit [Arg1] Macht, den du in dieser Runde erhältst, zu deiner Hand hinzu. Nach der Freisetzung von Exaltieren erhöhe alle „Dreizack“ in deiner Hand um [Arg2] Macht"
  },
  State_2548_Desc = {
    Text = "Immun gegen einen Tod, nach Auslösung 50 Leben wiederherstellen und das Artefakt dauerhaft ungültig machen"
  },
  State_2548_Name = {
    Text = "Schöpfung Ersatzpuppe"
  },
  State_2548_WeaponDesc = {
    Text = "Immun gegen einen Tod, nach Auslösung 50 Leben wiederherstellen und das Artefakt dauerhaft ungültig machen"
  },
  State_2549_Desc = {
    Text = "Aktiven und Tentakelschaden senken"
  },
  State_2549_Name = {
    Text = "<ExhaustionIconKeywords:Erschöpfung>"
  },
  State_2549_WeaponDesc = {
    Text = "Jede Schicht Erschöpfung verringert den Schaden und Tentakelschaden um 1"
  },
  State_2550_Desc = {
    Text = "Beim Ziehen wird man 1 Runde lang verwundbar. Nach Gebrauch werden alle Feinde 1 Runde lang verwundbar. Nicht verkäuflich"
  },
  State_2550_Name = {
    Text = "Status Fluch Zusammenbruch"
  },
  State_2550_WeaponDesc = {
    Text = "Beim Ziehen wird man 1 Runde lang verwundbar. Nach Gebrauch werden alle Feinde 1 Runde lang verwundbar. Nicht verkäuflich"
  },
  State_2552_Desc = {
    Text = "Karten werden nicht in der Ablagephase in den Ablagestapel gelegt, sondern bleiben im Handkartenbereich"
  },
  State_2552_Name = {
    Text = "<RetainIconKeywords:Behalten>"
  },
  State_2552_WeaponDesc = {
    Text = "Karten werden nicht in der Ablagephase in den Ablagestapel gelegt, sondern bleiben im Handkartenbereich"
  },
  State_2553_Desc = {
    Text = "Zu Beginn der Runde erhalte 1 Punkt Arithmetica"
  },
  State_2553_Name = {
    Text = "Relikt Arkana Arithmetica"
  },
  State_2553_WeaponDesc = {
    Text = "Zu Beginn der Runde erhalte 1 Punkt Arithmetica"
  },
  State_2554_Name = {
    Text = "Putney-Morgenpost"
  },
  State_2556_Desc = {
    Text = "Nach Reduktion der Lebenspunkte erhältst du einen Schild, der dem reduzierten Wert von [Layer] % entspricht"
  },
  State_2556_Name = {
    Text = "Blutsschild"
  },
  State_2556_WeaponDesc = {
    Text = "Nach Reduktion der Lebenspunkte erhältst du einen Schild, der dem reduzierten Wert von [Layer] % entspricht"
  },
  State_2557_Desc = {
    Text = "Zu Beginn des nächsten Zuges erhalte [Layer] Schild"
  },
  State_2557_Name = {
    Text = "Schmerz- und Freuden-Schild"
  },
  State_2558_Desc = {
    Text = "Wenn das Leben unter 50% ([StateArg1]) fällt, wird es sich in zwei Wesen mit gleichmäßigem Leben „Interferenztyp Aufgelöster Körper“ teilen"
  },
  State_2558_Name = {Text = "Spalten"},
  State_2558_WeaponDesc = {
    Text = "Wenn das Leben unter 50% ([StateArg1]) fällt, wird es sich in zwei Wesen mit gleichmäßigem Leben „II-Typ Aufgelöster Körper“ teilen"
  },
  State_2559_Desc = {
    Text = "Nach jedem ANG, verliere [Layer] temporäre Stärke"
  },
  State_2559_Name = {
    Text = "Der Preis des Impulses"
  },
  State_2560_Desc = {
    Text = "Nach Beginn der nächsten Runde erhältst du [Layer] Schild"
  },
  State_2560_Name = {
    Text = "Opus der Isolation"
  },
  State_2560_WeaponDesc = {
    Text = "Nach Beginn der nächsten Runde erhältst du [Layer] Schild"
  },
  State_2561_Desc = {
    Text = "Melancholische Begabung"
  },
  State_2561_Name = {
    Text = "Melancholische Begabung"
  },
  State_2561_WeaponDesc = {
    Text = "Melancholische Begabung"
  },
  State_2562_Name = {
    Text = "Status@Kapitel 3 Resonanz 1 Markierung"
  },
  State_2563_Desc = {
    Text = "Jedes Mal, wenn die 10. Karte gespielt wird, erhöhe den Tentakelschaden um 2 und lasse alle Tentakel einmal angreifen"
  },
  State_2563_Name = {
    Text = "Relikt Dreizack"
  },
  State_2563_WeaponDesc = {
    Text = "Jedes Mal, wenn die 10. Karte gespielt wird, erhöhe den Tentakelschaden um 2 und lasse alle Tentakel einmal angreifen"
  },
  State_2564_Desc = {
    Text = "Erhalte [DescArg1]% weniger Schild"
  },
  State_2564_Name = {
    Text = "<FragileColour:Zerbrechlich>"
  },
  State_2564_WeaponDesc = {
    Text = "Erhalte 33% weniger Schild"
  },
  State_2565_Name = {
    Text = "Schmuckstück Scharlachrote Umarmung"
  },
  State_2565_WeaponDesc = {
    Text = "Wenn der Ausrüster Schaden verursacht, erhält er 20 Punkte Keyflare. Bei kritischem Schaden erhöht sich dies auf 50 Punkte Keyflare, maximal 3 Mal pro Runde."
  },
  State_2566_Desc = {
    Text = "Nach dem Erhalt von 3 Angriffen in einer Runde, erhalte 1 Stapel Temporärer Wahnsinn."
  },
  State_2566_Name = {
    Text = "süße Pein"
  },
  State_2567_Desc = {
    Text = "Hat [Layer] Schaden erhalten; nach 3 Malen erhält „Süße Bosheit\" für diese Runde 1 Stapel Wahnsinn."
  },
  State_2567_Name = {
    Text = "“Süße Pein“-Anzahl"
  },
  State_2567_WeaponDesc = {
    Text = "Bereits [Layer] Mal Schaden erlitten, nach 3 Mal erhält „Süßer Dämon“ in dieser Runde 1 Schicht Wahnsinn"
  },
  State_2569_Desc = {
    Text = "Der Effekt des Reichbonus wird auf 50% erhöht, zu Beginn der Stufe erhöht sich deine Reichsbeherrschung um 100"
  },
  State_2569_Name = {
    Text = "Status@TraumSilberschlüssel:AnpassungTrennung"
  },
  State_2570_Desc = {
    Text = "Nach dem Ausspielen ziehe [StateArg1] Karten"
  },
  State_2570_Name = {
    Text = "<Rune_3:Geschick>"
  },
  State_2571_Desc = {
    Text = "Wenn im Team ein Erwecker der Beruf[Chaos] vorhanden ist, erhöht sich die maximale Gesundheit (unvollständig), VERT und ANG des gesamten Teams um 50%"
  },
  State_2571_Name = {Text = "Chaosbonus"},
  State_2571_WeaponDesc = {
    Text = "Wenn im Team ein Erwecker der Beruf[Chaos] vorhanden ist, erhöht sich die maximale Gesundheit (unvollständig), VERT und ANG des gesamten Teams um 50%"
  },
  State_2572_Desc = {
    Text = "Nach Ausspielen <EmbryoFusionIconKeywords:Embryofusion> +[StateArg1]."
  },
  State_2572_Name = {
    Text = "<Rune_12:Blutrausch>"
  },
  State_2573_Desc = {
    Text = "Besitzt 5 Schichten [Zündschnur]. Nach dem Ausspielen einer Karte verringert sich die Schicht um 1. Bei 0 explodiert sie und verursacht 2,5-fachen Schaden"
  },
  State_2573_Name = {Text = "Granate"},
  State_2573_WeaponDesc = {
    Text = "Besitzt 5 Schichten [Zündschnur]. Nach dem Ausspielen einer Karte verringert sich die Schicht um 1. Bei 0 explodiert sie und verursacht 2,5-fachen Schaden"
  },
  State_2574_Desc = {
    Text = "Kritischer Schaden +50%. Wenn in einer Runde kein ANG erfolgt, ist der nächste ANG garantiert kritisch"
  },
  State_2574_Name = {
    Text = "Status@TraumSilberschlüssel:Tanz"
  },
  State_2575_Desc = {
    Text = "Team Unique: Zu Beginn des Kampfes erhöht sich die kritische Rate der Befehlskarten des Ausrüsters um [StateArg1]%, für jedes Relikt, das er besitzt. Nachdem der Ausrüster die Verherrlichung freigesetzt hat, wirft er einen vierseitigen Würfel und erhält <WeaponEffect_Num:[StateArg2]> mal die Augenzahl des Würfels an Wahnsinn und vorübergehend kritischen Schaden. Wenn er eine 4 oder höher würfelt, erhalten auch andere Erwecker die Hälfte."
  },
  State_2575_WeaponDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich die kritische Trefferchance der Befehlskarten des Ausrüsters um [StateArg1]%, für jedes Relikt, das er besitzt. Nachdem der Ausrüster die Wut-Verherrlichung freigibt, wirft er einen 4-seitigen Würfel und erhält <WeaponEffect_Num:[StateArg2]> mal die geworfene Augenzahl an Wahnsinn und temporärem kritischen Schaden. Wenn er 4 oder mehr würfelt, erhalten auch andere Erwecker die Hälfte."
  },
  State_2576_Desc = {
    Text = "Immer wenn eine Karte in den ultra-dimensionalen Raum gelangt, wird die Arithmetica-Kosten um -1 verringert"
  },
  State_2579_Desc = {
    Text = "Erhöht die Anzahl der ausgeteilten Aktiven SCH-Instanzen in dieser Runde um [Layer]."
  },
  State_2579_Name = {
    Text = "Temporärer Wahnsinn"
  },
  State_2580_Desc = {
    Text = "Jedes Mal, wenn eine Karte der Schädeljägerhexe in den ultra Raum eintritt oder ihn verlässt, erhältst du 1 Arithmetica"
  },
  State_2580_Name = {
    Text = "Dimensionale Projektion#"
  },
  State_2581_Desc = {
    Text = "Die Silber-Schlüsselaufladung aller Erwecker erhöht sich um 30. Nach dem Freisetzen der Bande mischen 3 Karten <DerivativeCardKeywords_4:„Inspiration“> in dein Deck"
  },
  State_2581_Name = {
    Text = "Zustand @ Chrono-Pendel Einsicht"
  },
  State_2582_Desc = {
    Text = "Der durch den Ausrüster verursachte Schaden, Schild und die Heilung erhöhen sich um [StateArg1]% (temporär)"
  },
  State_2582_Name = {
    Text = "Status@Prototyp Laserkanone Wahnsinn"
  },
  State_2583_Desc = {
    Text = "Bei jedem aktiven Schaden, füge dem Team eine Schicht Zähler hinzu"
  },
  State_2583_Name = {
    Text = "Zustand @ Rache-Riesenblatt Enthauptungsschaden Zählen"
  },
  State_2583_WeaponDesc = {
    Text = "Bei jedem aktiven Schaden, füge dem Team eine Schicht Zähler hinzu"
  },
  State_2584_Desc = {
    Text = "Jedes Mal, wenn das Deck neu gemischt wird, erhält man [Arg1] Stärke"
  },
  State_2586_Desc = {
    Text = "Erhalte 25% weniger Schild, entferne 1 Schicht am Ende der Runde"
  },
  State_2586_Name = {
    Text = "<FragileIconKeywords: Zerbrechlich>"
  },
  State_2586_WeaponDesc = {
    Text = "Erhalte 25% weniger Schild"
  },
  State_2587_Desc = {
    Text = "Wundschaden verdoppelt. Bei jedem tatsächlichen Schaden erhält man [Layer] Schildpunkte"
  },
  State_2587_Name = {
    Text = "“ Himmelsfresser Zahn “"
  },
  State_2587_WeaponDesc = {
    Text = "Wundschaden verdoppelt. Bei jedem tatsächlichen Schaden erhält man [Layer] Schildpunkte"
  },
  State_2588_Desc = {
    Text = "Erleidet am Rundenende [Layer] <FixedDamage:Reinen SCH> und entfernt diesen Zustand. Beim Wiederherstellen von LP werden Bluten-Stapelungen in doppelter Höhe des wiederhergestellten Betrags entfernt."
  },
  State_2588_Name = {
    Text = "Permanent <BleedingColour: Bluten>"
  },
  State_2588_WeaponDesc = {
    Text = "Nach dem Ende der Runde erleide [Layer] Punkte Schaden und entferne diesen Zustand; jede Heilung kann die Schichten halbieren"
  },
  State_2589_Name = {
    Text = "Schmuckstück Verdrehte Zwillinge Schwarz"
  },
  State_2589_WeaponDesc = {
    Text = "Füge zu Beginn einer ungeraden Runde dem Deck eine „Schlag“-Karte mit Nichtigkeit und Verbrauch hinzu"
  },
  State_2590_Desc = {
    Text = "Erhalte 10 schwarze Siegel beim Bewegen"
  },
  State_2590_Name = {
    Text = "unendlicher Beutel der Schöpfung"
  },
  State_2590_WeaponDesc = {
    Text = "Erhalte 10 schwarze Siegel beim Bewegen"
  },
  State_2592_Desc = {
    Text = "Pro verlorenen Lebenspunkt 1 Schicht entfernen, bei 0 Schichten [DescArg1] Schild erhalten"
  },
  State_2592_Name = {
    Text = "Dimensionsbarriere"
  },
  State_2593_Name = {
    Text = "Status@Hymne von Blut und Sand"
  },
  State_2594_Desc = {
    Text = "Beim Verursachen von tatsächlichem Schaden erhält man Schild"
  },
  State_2594_Name = {
    Text = "“ Himmelsfresser Zahn “"
  },
  State_2594_WeaponDesc = {
    Text = "Beim Verursachen von tatsächlichem Schaden erhält man Schild"
  },
  State_2595_Desc = {
    Text = "Für jeden verursachten Schaden erhältst du [StateArg2] Punkte temporäre Macht"
  },
  State_2595_Name = {
    Text = "Schwert der Königin der Weisen"
  },
  State_2597_Desc = {
    Text = "Zu Beginn der Runde erhältst du [Layer] Schildpunkte"
  },
  State_2597_Name = {
    Text = "Verzögerter Schild"
  },
  State_2597_WeaponDesc = {
    Text = "Zu Beginn der Runde erhältst du [Layer] Schildpunkte"
  },
  State_2600_Desc = {
    Text = "Jedes Mal, wenn du Leben verlierst, erhält der Erwachte mit dem wenigsten Wahnsinn 10 Wahnsinn. Bei 5 Mal Leben verlieren, erhalte 1 Schicht Barriere"
  },
  State_2600_Name = {
    Text = "Status@TraumSilberschlüssel:Analyse"
  },
  State_2601_Desc = {
    Text = "In geraden Runden 50% weniger Schaden, 33% mehr Schaden"
  },
  State_2601_Name = {
    Text = "veränderlich"
  },
  State_2601_WeaponDesc = {
    Text = "In geraden Runden 50% weniger Schaden, 33% mehr Schaden"
  },
  State_2602_Desc = {
    Text = "Du bist markiert! Nach dem Ausspielen erhält der Ewige Fanatiker [StateArg1] temporäre Stärke, und das Tiefseezeichen dieser Anweisung wird entfernt"
  },
  State_2602_Name = {
    Text = "<CardKeyWord:Tiefseezeichen>"
  },
  State_2602_WeaponDesc = {
    Text = "Nach dem Ausspielen der Karte erhält der Tiefseewächter-Elite [StateArg1] temporäre Stärke"
  },
  State_2603_Desc = {
    Text = "Wenn sich ein „Embryo“ auf der Hand befindet, verbrauche alle „Embryos“, jeder löst den Effekt einmal aus"
  },
  State_2603_Name = {
    Text = "<UnlimitedDevouredIconKeywords:Unendliches Verschlingen>"
  },
  State_2604_Desc = {
    Text = "Innerhalb dieser Runde erhöht sich die kritische Rate um [Layer] %"
  },
  State_2604_Name = {
    Text = "Temporäre Kritische Trefferquote"
  },
  State_2604_WeaponDesc = {
    Text = "Innerhalb dieser Runde erhöht sich die kritische Rate um [Layer] %"
  },
  State_2605_Desc = {
    Text = "Wenn das Leben unter 95% ([StateArg1]) fällt, teilt es sich in 2 gleichwertige „Experimentelle Werke“"
  },
  State_2605_Name = {Text = "Spalten"},
  State_2605_WeaponDesc = {
    Text = "Wenn das Leben unter 30% ([StateArg1]) fällt, wird es sich in drei Wesen mit gleichmäßigem Leben „II-Typ Aufgelöster Körper Wachsskulptur“ teilen"
  },
  State_2606_Desc = {
    Text = "Wenn das Leben unter 90% ([StateArg1]) fällt, teilt es sich in 2 gleichwertige „Experimentelle Werke“"
  },
  State_2606_Name = {Text = "Spalten"},
  State_2606_WeaponDesc = {
    Text = "Wenn das Leben unter 30% ([StateArg1]) fällt, wird es sich in drei Wesen mit gleichmäßigem Leben „II-Typ Aufgelöster Körper Wachsskulptur“ teilen"
  },
  State_2607_Desc = {
    Text = "Am Ende des Kampfes werden 5 Leben wiederhergestellt"
  },
  State_2607_Name = {
    Text = "Hochmonddienerin erleuchtet 3"
  },
  State_2607_WeaponDesc = {
    Text = "Am Ende des Kampfes werden 5 Leben wiederhergestellt"
  },
  State_2609_Desc = {
    Text = "Wenn das Leben unter 30% ([StateArg1]) fällt, teilt es sich in 2 gleichwertige „Experimentelle Werke“"
  },
  State_2609_Name = {Text = "Spalten"},
  State_2609_WeaponDesc = {
    Text = "Wenn das Leben unter 30% ([StateArg1]) fällt, wird es sich in drei Wesen mit gleichmäßigem Leben „II-Typ Aufgelöster Körper Wachsskulptur“ teilen"
  },
  State_2610_Desc = {
    Text = "Wenn das Leben unter 70% ([StateArg1]) fällt, teilt es sich in 2 gleichwertige „Experimentelle Werke“"
  },
  State_2610_Name = {Text = "Spalten"},
  State_2610_WeaponDesc = {
    Text = "Wenn das Leben unter 30% ([StateArg1]) fällt, wird es sich in drei Wesen mit gleichmäßigem Leben „II-Typ Aufgelöster Körper Wachsskulptur“ teilen"
  },
  State_2611_Desc = {
    Text = "Wenn das Leben unter 50% ([StateArg1]) fällt, teilt es sich in 2 gleichwertige „Experimentelle Werke“"
  },
  State_2611_Name = {Text = "Spalten"},
  State_2611_WeaponDesc = {
    Text = "Wenn das Leben unter 30% ([StateArg1]) fällt, wird es sich in drei Wesen mit gleichmäßigem Leben „II-Typ Aufgelöster Körper Wachsskulptur“ teilen"
  },
  State_2612_Desc = {
    Text = "Antike Imitation"
  },
  State_2612_Name = {
    Text = "Antike Imitation"
  },
  State_2612_WeaponDesc = {
    Text = "Antike Imitation"
  },
  State_2614_Desc = {
    Text = "Einzigartig im Team: Nach dem Ausspielen einer Befehlskarte des Ausrüsters, besteht eine <WeaponEffect_Num:[StateArg1]%> Chance, dass sie aus dem Ablagestapel zurück auf die Hand kommt. Dieser Effekt kann nur einmal pro Runde ausgelöst werden"
  },
  State_2614_WeaponDesc = {
    Text = "Nach dem Ausspielen einer Befehlskarte des Ausrüsters besteht eine <WeaponEffect_Num:[StateArg1]%> Chance, dass sie aus dem Ablagestapel zurück auf die Hand kommt. Dieser Effekt tritt pro Runde nur 1 Mal in Kraft"
  },
  State_2617_Desc = {
    Text = "Zu Beginn der nächsten Runde ziehst du zusätzlich [DescArg1] Karte(n)."
  },
  State_2617_Name = {
    Text = "Symptom: Aufgeregtheit"
  },
  State_2619_Desc = {
    Text = "Aktiver Schaden in diesem Kampf um [Layer] Punkte verringert"
  },
  State_2619_Name = {Text = "STR▼"},
  State_2619_WeaponDesc = {
    Text = "Schaden in diesem Kampf um [Layer] Punkte verringert"
  },
  State_2620_Desc = {
    Text = "Rostiges Weidenmesser der Schöpfung"
  },
  State_2620_Name = {
    Text = "Rostige Lanze"
  },
  State_2623_Desc = {
    Text = "Zu Rundenbeginn erhalten Sie 1 Arithmetica"
  },
  State_2624_Desc = {
    Text = "Nach dem Ausspielen verlieren alle Feinde [StateArg1] temporäre Kraft"
  },
  State_2624_Name = {
    Text = "<Rune_18:Erschöpfung>"
  },
  State_2625_Desc = {
    Text = "Dein Sprung-Effekt wird zweimal ausgelöst. Beim Eintritt in die Hyperdimensionale Runde erhalten alle Feinde 5 temporäre Stärke"
  },
  State_2625_Name = {
    Text = "Schöpfung Albtraumseelenlampe"
  },
  State_2626_Desc = {
    Text = "Obergrenze der Krakenarme um 1 verringert. Am Rundenende greifen alle Krakenarme einmal zusätzlich an"
  },
  State_2627_Name = {
    Text = "Erhalte [StateArg1] Schlüsselenergie"
  },
  State_2627_WeaponDesc = {
    Text = "Bei der „Unvollendeten Wachsfigur“ erhalten ausgewählte Karten Schlüsselenergie"
  },
  State_2628_Desc = {
    Text = "Die Karte, die am „Unvollendeten Wachsskulptur“ kopiert wurde, erhält das Orison Effekt"
  },
  State_2628_Name = {
    Text = "Status@Kapitel 2 Resonanz 3"
  },
  State_2628_WeaponDesc = {
    Text = "Die Karte, die am „Unvollendeten Wachsskulptur“ Punkt kopiert wurde, erhält das Orison Effekt"
  },
  State_2629_Desc = {
    Text = "Bei der „Unvollendeten Wachsfigur“ wird der Bereich der kopierbaren Karten erweitert"
  },
  State_2629_Name = {
    Text = "Status@Kapitel 2 Resonanz 2"
  },
  State_2629_WeaponDesc = {
    Text = "Bei der „Unvollendeten Wachsfigur“ erhalten kopierte Karten und ihre Originale den „Eigen“-Effekt"
  },
  State_2630_Desc = {
    Text = "Bei der „Unvollendeten Wachsfigur“ erhalten kopierte Karten und ihre Originale den „Behalten“-Effekt"
  },
  State_2630_Name = {
    Text = "Status@Kapitel 2 Resonanz 4"
  },
  State_2630_WeaponDesc = {
    Text = "Bei der „Unvollendeten Wachsfigur“ erhalten kopierte Karten und ihre Originale den „Behalten“-Effekt"
  },
  State_2631_Desc = {
    Text = "Bei der „Unvollendeten Wachsfigur“ wird eine zusätzliche Karte kopiert"
  },
  State_2631_Name = {
    Text = "Status@Kapitel 2 Resonanz 6"
  },
  State_2631_WeaponDesc = {
    Text = "Bei der „Unvollendeten Wachsfigur“ wird eine zusätzliche Karte kopiert"
  },
  State_2633_Desc = {
    Text = "Jedes Mal, wenn Aktiver Schaden erlitten wird, wird für [Layer] <plural value=\"[Layer]\" singular=\"Runde\" plural=\"Runden\"> 1 [Grüne Flammen] mit Erschöpfung auf die Hand genommen."
  },
  State_2633_Name = {
    Text = "Mottenfängerfeuer"
  },
  State_2633_WeaponDesc = {
    Text = "Vor dem nächsten Zug fügt man bei jedem ANG eine verbrauchte Karte [Grüne Flamme] zur Hand hinzu."
  },
  State_2634_Desc = {
    Text = "Beim Ausspielen der Karte erleide [StateArg1] Schaden und entferne 1 Schicht. Wenn die Schichten auf 0 sind, schlüpft ein schwächeres „Wesen des Meeres“. Wenn der parasitäre Zustand am Ende des Zuges noch besteht, schlüpft ein „Wesen des Meeres“ mit Leben entsprechend der Schichten"
  },
  State_2634_Name = {
    Text = "Parasitiert"
  },
  State_2635_Desc = {
    Text = "Zustand @ Prolog Offensivanalyse Kennzeichen"
  },
  State_2635_Name = {
    Text = "Zustand @ Prolog Offensivanalyse Kennzeichen"
  },
  State_2635_WeaponDesc = {
    Text = "Zustand @ Prolog Offensivanalyse Kennzeichen"
  },
  State_2636_Name = {
    Text = "Status@Kapitel 4 Resonanz@Nächste Runde Karten ziehen 1"
  },
  State_2637_Desc = {
    Text = "Zu Rundenbeginn erhalten Sie [StateArg1] Arithmetica"
  },
  State_2637_Name = {
    Text = "Schöpfung Aktivinjektor"
  },
  State_2637_WeaponDesc = {
    Text = "Zu Rundenbeginn erhalten Sie [StateArg1] Arithmetica"
  },
  State_2639_Desc = {
    Text = "Bei einem tödlichen Schaden im Kampf gibt es eine Chance, 1 Lebenspunkt zu behalten. Nach der Auslösung wird die Chance in dieser Ermittlung halbiert und der erhaltene Widerstand wird halbiert"
  },
  State_2639_Name = {
    Text = "<DeathResistanceIconKeywords: Todeswiderstand>"
  },
  State_2640_Name = {
    Text = "Allgemeine Wiederholung 1 Mal"
  },
  State_2645_Desc = {
    Text = "Status@PrologMonsterPassiv1"
  },
  State_2645_Name = {
    Text = "Status@PrologMonsterPassiv1"
  },
  State_2645_WeaponDesc = {
    Text = "Status@PrologMonsterPassiv1"
  },
  State_2646_Desc = {
    Text = "Status@PrologMonsterPassiv2"
  },
  State_2646_Name = {
    Text = "Status@PrologMonsterPassiv2"
  },
  State_2646_WeaponDesc = {
    Text = "Status@PrologMonsterPassiv2"
  },
  State_2647_Desc = {
    Text = "Status@PrologMonsterPassiv3"
  },
  State_2647_Name = {
    Text = "Status@PrologMonsterPassiv3"
  },
  State_2647_WeaponDesc = {
    Text = "Status@PrologMonsterPassiv3"
  },
  State_2648_Desc = {
    Text = "Status@PrologMonsterPassiv4"
  },
  State_2648_Name = {
    Text = "Status@PrologMonsterPassiv4"
  },
  State_2648_WeaponDesc = {
    Text = "Status@PrologMonsterPassiv4"
  },
  State_2649_Desc = {
    Text = "Status@PrologMonsterPassiv5"
  },
  State_2649_Name = {
    Text = "Status@PrologMonsterPassiv5"
  },
  State_2649_WeaponDesc = {
    Text = "Status@PrologMonsterPassiv5"
  },
  State_2650_Desc = {
    Text = "Status@PrologMonsterPassiv6"
  },
  State_2650_Name = {
    Text = "Status@PrologMonsterPassiv6"
  },
  State_2650_WeaponDesc = {
    Text = "Status@PrologMonsterPassiv6"
  },
  State_2651_Desc = {
    Text = "Status@PrologMonsterPassiv7"
  },
  State_2651_Name = {
    Text = "Status@PrologMonsterPassiv7"
  },
  State_2651_WeaponDesc = {
    Text = "Status@PrologMonsterPassiv7"
  },
  State_2652_Desc = {
    Text = "Status@PrologMonsterPassiv8"
  },
  State_2652_Name = {
    Text = "Status@PrologMonsterPassiv8"
  },
  State_2652_WeaponDesc = {
    Text = "Status@PrologMonsterPassiv8"
  },
  State_2653_Desc = {
    Text = "Status@PrologMonsterPassiv9"
  },
  State_2653_Name = {
    Text = "Status@PrologMonsterPassiv9"
  },
  State_2653_WeaponDesc = {
    Text = "Status@PrologMonsterPassiv9"
  },
  State_2655_Desc = {
    Text = "Beim Verursachen von ungeblocktem Schaden wird gleich viel Leben wiederhergestellt, beim Verursachen von Schaden entfernt"
  },
  State_2655_Name = {Text = "Blutsaugen"},
  State_2656_Desc = {
    Text = "Nach Beginn der nächsten Runde, sofort abhauen!!!!!!"
  },
  State_2656_Name = {Text = "Flucht"},
  State_2660_Desc = {
    Text = "Zu Beginn des Kampfes erhält man Stärke, aber erleidet 5 mehr Schaden"
  },
  State_2660_Name = {
    Text = "Rücken an Wasser"
  },
  State_2661_Desc = {
    Text = "Zu Beginn des Kampfes verlieren alle Feinde [Arg1] Punkte Kraft."
  },
  State_2662_Name = {
    Text = "Status@Kapitel 3 Testzustand"
  },
  State_2663_Desc = {
    Text = "Beim Ziehen bist du für 1 Runde geschwächt. Nach der Benutzung werden alle Gegner für 1 Runde geschwächt. Nicht verkäuflich"
  },
  State_2663_Name = {
    Text = "Status Fluch Schwäche"
  },
  State_2663_WeaponDesc = {
    Text = "Beim Ziehen bist du für 1 Runde geschwächt. Nach der Benutzung werden alle Gegner für 1 Runde geschwächt. Nicht verkäuflich"
  },
  State_2666_Name = {
    Text = "Kreisender Dolch kritische Rate"
  },
  State_2667_Desc = {
    Text = "Schadensbonus für ANGskarten um [Layer] %"
  },
  State_2667_Name = {
    Text = "Schadensbonus für ANGskarten"
  },
  State_2667_WeaponDesc = {
    Text = "Schadensbonus für ANGskarten um [Layer] %"
  },
  State_2668_Desc = {
    Text = "Erhöht den ANG um [Layer]%"
  },
  State_2668_Name = {
    Text = "Allgemeiner permanenter ANGsprozentsatz erhöht"
  },
  State_2668_WeaponDesc = {
    Text = "Erhöht den ANG um [Layer]%"
  },
  State_2669_Desc = {
    Text = "Kritischer Schaden in diesem Kampf um [Layer]% erhöht"
  },
  State_2669_Name = {
    Text = "Krit. Schaden"
  },
  State_2670_Desc = {
    Text = "Bei Schwäche erhältst du [Arg1] Schildpunkte; bei Verwundbarkeit [Arg2] Kraft. Wenn beide Effekte in einer Runde ausgelöst werden, erhältst du zusätzlich [Arg1] Schildpunkte und [Arg2] Kraft"
  },
  State_2670_Name = {
    Text = "Vergoldeter Rahmen"
  },
  State_2671_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_2671_Name = {
    Text = "Nicht erweckt"
  },
  State_2672_Desc = {
    Text = "Zu Beginn jeder Runde Schichten „Fessel“ auf das eigene Team anwenden"
  },
  State_2672_Name = {Text = "Fesselung"},
  State_2672_WeaponDesc = {
    Text = "Zu Beginn jeder Runde Schichten „Fessel“ auf das eigene Team anwenden"
  },
  State_2674_Desc = {
    Text = "Innerhalb dieser Runde erhöht sich die kritische Rate um [Layer] %"
  },
  State_2674_Name = {
    Text = "Temporäre Kritische Trefferquote"
  },
  State_2676_Name = {
    Text = "Schmuckstück Scharlachrote Angst"
  },
  State_2676_WeaponDesc = {
    Text = "Nach der Freisetzung des Bande erhält der Ausrüstende 15% temporäre kritische Rate. Wenn der aktuelle kritische Schaden des Ausrüstenden über 80% liegt, erhält er zusätzlich 15% temporäre kritische Rate"
  },
  State_2677_Desc = {
    Text = "In den ersten 3 Malen pro Runde wird der erlittene aktive/Tentakelschaden um 75% reduziert"
  },
  State_2677_Name = {
    Text = "“ Unsterbliche Überreste “"
  },
  State_2677_WeaponDesc = {
    Text = "In den ersten 3 Malen pro Runde wird der erlittene aktive/Tentakelschaden um 75% reduziert"
  },
  State_2679_Name = {
    Text = "Status@Kapitel 3 Resonanz 7 Markierung"
  },
  State_2680_Desc = {
    Text = "Kritische Rate erhöht um 20%. Wenn zu Beginn der Runde die Gesundheit unter 25% liegt, tritt in dieser Runde garantiert ein kritischer Treffer ein"
  },
  State_2681_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_2681_Name = {
    Text = "Nicht erweckt"
  },
  State_2682_Desc = {
    Text = "Schild und Heilungseffekte um 50% erhöhen"
  },
  State_2682_Name = {
    Text = "Bewahrer des entarteten Gartens"
  },
  State_2682_WeaponDesc = {
    Text = "Schild und Heilungseffekte um 50% erhöhen"
  },
  State_2683_Desc = {
    Text = "Ziehe Karten entsprechend der Zustandsstapel"
  },
  State_2683_Name = {Text = "Ziehen"},
  State_2684_Desc = {
    Text = "Team-Einzigartig: Der „Schlag“ des Trägers hat eine <WeaponEffect_Num:[StateArg1]%> Chance, 1 Arithmetica zu erhalten und 10% <IntoxicationIconKeywords:Gift> für alle Feinde auszulösen. Wenn das aktuelle Reich „Aequor“ ist, verursacht dieser Effekt, dass 1 Tentakel einmal angreift, wenn er ausgelöst wird. Dieser Effekt kann pro Runde nur einmal ausgelöst werden."
  },
  State_2684_WeaponDesc = {
    Text = "Der „Schlag“ des Trägers hat eine <WeaponEffect_Num:[StateArg1]%> Chance, 1 Arithmetica zu gewinnen und [DescArg1]% von <IntoxicationIconKeywords:Gift> für alle Feinde auszulösen. Wenn das aktuelle Reich „Aequor“ ist, verursacht dieser Effekt, dass 1 Tentakel einmal angreift, wenn er ausgelöst wird. Dieser Effekt kann pro Runde maximal 1 Mal ausgelöst werden."
  },
  State_2685_Desc = {
    Text = "Immun gegen Schwäche, Zerbrechlichkeit und Verwundbarkeit, am Rundenende 1 Schicht entfernt"
  },
  State_2685_Name = {
    Text = "<BlessingIconKeywords: Segen>"
  },
  State_2685_WeaponDesc = {
    Text = "In dieser Runde immun gegen negative Zustände"
  },
  State_2686_Desc = {
    Text = "Temporäre Karten im Kampf"
  },
  State_2686_Name = {
    Text = "<CardKeyWord:Zustandskarte>"
  },
  State_2687_Desc = {
    Text = "Innerhalb dieser Runde wird die kritische Rate um 100 % erhöht"
  },
  State_2687_Name = {
    Text = "Temporäre Kritischer Treffer"
  },
  State_2687_WeaponDesc = {
    Text = "Innerhalb dieser Runde wird die kritische Rate um 100 % erhöht"
  },
  State_2688_Desc = {
    Text = "Nach der 3. gespielten Karte jeder Runde lege 1 „Inspiration“ in den Ablagestapel. Nach der 6. gespielten Karte füge 1 „Inspiration“ aus dem Ablagestapel der Hand hinzu"
  },
  State_2689_Desc = {
    Text = "Zu Beginn der Runde ziehe 2 Karten. Erhöhe die Kapazität des Hyperdimensionalen Slots um 2"
  },
  State_2689_Name = {
    Text = "Hut des Schöpfungstricksters"
  },
  State_2689_WeaponDesc = {
    Text = "Zu Beginn der Runde ziehe 2 Karten. Erhöhe die Kapazität des Hyperdimensionalen Slots um 2"
  },
  State_2690_Desc = {
    Text = "Wenn der Tugendritter eine Karte spielt, erhält er [StateArg1] Stärke"
  },
  State_2690_Name = {
    Text = "Rittereifer"
  },
  State_2691_Desc = {
    Text = "Team Unique: Nach der Freisetzung der Verherrlichung erhält der Ausrüster <WeaponEffect_Num:[StateArg1]> Punkte Aliemus und <WeaponEffect_Num:[StateArg2]> Punkte Keyflare, und dieser Effekt wird einmal wiederholt für jede 4 Karten in der Hand. Wenn das aktuelle Reich “Ultra“ ist, erhält der Ausrüster, nachdem seine Karten in den Hyperraum eingetreten sind, vorübergehend Stärke in Höhe von <WeaponEffect_Num:[StateArg3]%] seiner ANGskraft, wobei dieser Effekt pro Runde maximal 2 Mal ausgelöst werden kann."
  },
  State_2691_WeaponDesc = {
    Text = "Nach dem Freisetzen von Verherrlichung erhält der Ausrüster <WeaponEffect_Num:[StateArg1]> Punkte Aliemus und <WeaponEffect_Num:[StateArg2]> Punkte Keyflare, wobei dieser Effekt alle 4 Karten einmal wiederholt wird. Wenn das aktuelle Reich “Ultra“ ist, erhält der Ausrüster nach dem Betreten des Hyperraums <WeaponEffect_Num:[Power:DescArg1]> Punkte vorübergehende Stärke, maximal 2 Mal pro Runde auslösbar."
  },
  State_2693_Desc = {
    Text = "Status@PrologWahnsinn0_1_2Effekt"
  },
  State_2693_Name = {
    Text = "Status@PrologWahnsinn0_1_2Effekt"
  },
  State_2693_WeaponDesc = {
    Text = "Status@PrologWahnsinn0_1_2Effekt"
  },
  State_2694_Desc = {
    Text = "Bei jeder Ausgabe von 1 schwarzen Siegel erhalten alle Erwecker 1 Punkt Aelius"
  },
  State_2694_Name = {
    Text = "Umkehrblume-Zustand der Schöpfung"
  },
  State_2694_WeaponDesc = {
    Text = "Bei jeder Ausgabe von 1 schwarzen Siegel erhalten alle Erwecker 1 Punkt Aelius"
  },
  State_2695_Desc = {
    Text = "Jedes Mal, wenn eine Erwachter-Karte in den Hyperraum geht, erhält der entsprechende Erwachte 15 Wahnsinn"
  },
  State_2696_Desc = {
    Text = "Status@PrologWahnsinn0_1_2Aktiv"
  },
  State_2696_Name = {
    Text = "Status@PrologWahnsinn0_1_2Aktiv"
  },
  State_2696_WeaponDesc = {
    Text = "Status@PrologWahnsinn0_1_2Aktiv"
  },
  State_2698_Name = {
    Text = "Erhält +1 Rechenleistung am Beginn der nächsten Runde"
  },
  State_2699_Name = {
    Text = "Am Beginn der nächsten Runde +2 Rechenleistung"
  },
  State_2701_Desc = {
    Text = "Tiefseedame erhöht [StateArg1] Tentakelschaden bei Schild"
  },
  State_2701_Name = {
    Text = "Ins Leben gerufen"
  },
  State_2701_WeaponDesc = {
    Text = "Tiefseedame erhöht [StateArg1] Tentakelschaden bei Schild"
  },
  State_2702_Desc = {
    Text = "Nach dem Aufheben erhält man 100% Todeswiderstand. Nach dem Auslösen des Todeswiderstands werden zu Beginn jeder Runde in diesem Kampf [Arg1] Lebenspunkte wiederhergestellt"
  },
  State_2702_Name = {
    Text = "Lebenshauch"
  },
  State_2703_Desc = {
    Text = "Die erste gespielte Wächterkarte jeder Runde wird temporär in den Dimensionsriss kopiert, um in gefährlichen Momenten zu schützen!"
  },
  State_2703_Name = {
    Text = "Dimensionsriss"
  },
  State_2705_Name = {
    Text = "Rache an dir"
  },
  State_2706_Desc = {
    Text = "Allmähliche Versteinerungserkennung"
  },
  State_2706_Name = {
    Text = "Allmähliche Versteinerungserkennung"
  },
  State_2706_WeaponDesc = {
    Text = "Allmähliche Versteinerungserkennung"
  },
  State_2707_Desc = {
    Text = "In dieser Runde greifen Tentakel alle Gegner an"
  },
  State_2707_Name = {
    Text = "Voller Tentakelangriff"
  },
  State_2707_WeaponDesc = {
    Text = "In dieser Runde greifen Tentakel alle Gegner an"
  },
  State_2708_Desc = {
    Text = "Tentakelobergrenze erhöht sich um 1. Wenn die Gesundheit unter 50% liegt, erhöht sich der Tentakelschaden um [StateArg1] Punkte"
  },
  State_2708_Name = {
    Text = "Mutierte Opfergaben der Vergangenheit"
  },
  State_2708_WeaponDesc = {
    Text = "Tentakelobergrenze erhöht sich um 1. Wenn die Gesundheit unter 50% liegt, erhöht sich der Tentakelschaden um [StateArg1] Punkte"
  },
  State_2709_Desc = {
    Text = "Rostiges Weidenmesser-Zähler der Schöpfung"
  },
  State_2710_Desc = {
    Text = "Imprägnierung"
  },
  State_2710_Name = {
    Text = "Imprägnierung"
  },
  State_2710_WeaponDesc = {
    Text = "Imprägnierung"
  },
  State_2711_Desc = {
    Text = "Temporäre Änderung der Kartenrechenleistung"
  },
  State_2711_Name = {
    Text = "Temporäre Änderung der Kartenrechenleistung"
  },
  State_2711_WeaponDesc = {
    Text = "Temporäre Änderung der Kartenrechenleistung"
  },
  State_2712_Desc = {
    Text = "Erhöhe den verursachten Schild"
  },
  State_2712_Name = {
    Text = "<AlertIconKeywords: Alarm>"
  },
  State_2712_WeaponDesc = {
    Text = "Erhalte mehr Schild"
  },
  State_2713_Desc = {
    Text = "Die Racheklinge erhält jede Runde Kraft"
  },
  State_2713_Name = {
    Text = "Racheblatt Erwachen"
  },
  State_2713_WeaponDesc = {
    Text = "Nach Beginn der nächsten Runde, erhalte Schild in Höhe des verlorenen Lebens der letzten Runde"
  },
  State_2715_Desc = {
    Text = "Schild in diesem Level um [Layer] Punkte erhöht"
  },
  State_2715_Name = {
    Text = "Dauernde Wachsamkeit"
  },
  State_2715_WeaponDesc = {
    Text = "Schild in diesem Level um [Layer] Punkte erhöht"
  },
  State_2718_Desc = {
    Text = "Die Gruppe ist einzigartig: Am Ende der Runde erhält der Ausrüster <WeaponEffect_Num:[StateArg1]> Punkte Wahnsinn und erhält s-Energie entsprechend seiner s-Energie"
  },
  State_2718_WeaponDesc = {
    Text = "Am Ende der Runde erhält der Ausrüster <WeaponEffect_Num:[StateArg1]> Punkte Wahnsinn und erhält die gleiche Menge an Silber-Energie, die der Silberschlüsselaufladung entspricht"
  },
  State_2720_Desc = {
    Text = "Beim Verursachen von tatsächlichem Schaden wird der Wahnsinn des erwachten Körpers mit dem höchsten Wahnsinn um 10 gesenkt"
  },
  State_2720_Name = {
    Text = "Nichtigkeit"
  },
  State_2720_WeaponDesc = {
    Text = "Beim Verursachen von tatsächlichem Schaden wird der Wahnsinn des erwachten Körpers mit dem höchsten Wahnsinn um 10 gesenkt"
  },
  State_2721_Name = {
    Text = "Status@Stufe2_9Kampf5Blase1"
  },
  State_2722_Desc = {
    Text = "Nach dem Spielen mische [StateArg1] „Inspiration“ in den Nachziehstapel. „Inspiration“: erhält 1 Arithmetica, ziehe 1 Karte, beibehalten, verbrauchen"
  },
  State_2722_Name = {
    Text = "<Rune_17_High:Hochinspiration>"
  },
  State_2723_Desc = {
    Text = "Nach dem Ausspielen werden alle Feinde [StateArg1] Runden verwundbar"
  },
  State_2723_Name = {
    Text = "<Rune_1_High:Fortgeschrittene Schwäche>"
  },
  State_2724_Desc = {
    Text = "ANGszahl +1"
  },
  State_2724_Name = {
    Text = "Gegenangriff des Traumkerns"
  },
  State_2726_Desc = {
    Text = "Nach dem Ausspielen allen Feinden [StateArg1] Schichten Gift hinzufügen, sodass alle Feinde [StateArg2]% Gift auslösen."
  },
  State_2726_Name = {
    Text = "<Rune_10_High:Hochgift>"
  },
  State_2727_Desc = {
    Text = "Bei bevorstehendem Tod, 1 Leben wiederherstellen und diesen Zustand entfernen"
  },
  State_2727_Name = {Text = "Wurzel"},
  State_2727_WeaponDesc = {
    Text = "Bei bevorstehendem Tod, 1 Leben wiederherstellen und diesen Zustand entfernen"
  },
  State_2728_Desc = {
    Text = "Zu Beginn der Runde erhalte für jeden anderen Verbündeten 1 Schicht <ParcloseIconKeywords:Barriere>"
  },
  State_2728_Name = {
    Text = "Verbindungsbarriere"
  },
  State_2728_WeaponDesc = {
    Text = "Zu Rundenbeginn erhalten Sie für jeden anderen Verbündeten 1 Schild in Höhe von [Layer] % der maximalen Gesundheit"
  },
  State_2729_Desc = {
    Text = "Beim Auslösen eine Karte des entsprechenden Erwachten ziehen"
  },
  State_2729_Name = {
    Text = "Veränderter Raumverzerrer-Kartenziehen"
  },
  State_2729_WeaponDesc = {
    Text = "Beim Auslösen eine Karte des entsprechenden Erwachten ziehen"
  },
  State_2730_Desc = {
    Text = "Nach dem Tod reduziert Hydra 1 Schicht „Tausend Schlangen Kontrolle“"
  },
  State_2730_Name = {Text = "Vassal"},
  State_2732_Desc = {
    Text = "Status@PrologWahnsinnInitialisierung0_2_3"
  },
  State_2732_Name = {
    Text = "Status@PrologWahnsinnInitialisierung0_2_3"
  },
  State_2732_WeaponDesc = {
    Text = "Status@PrologWahnsinnInitialisierung0_2_3"
  },
  State_2734_Name = {
    Text = "Zu Beginn der nächsten Runde +1 Karten ziehen"
  },
  State_2735_Desc = {
    Text = "Wenn diese Karte nach dem Spielen „Dimensionsgleiter\" auslöst oder sich gerade in einer Ultra-Runde befindet, wird der Folgeeffekt ausgelöst."
  },
  State_2735_Name = {
    Text = "<TransitionIconKeywords:Sprung>"
  },
  State_2735_WeaponDesc = {
    Text = "Wenn du dich in der Hyperraumrunde befindest, kann der Sprungeffekt ausgelöst werden"
  },
  State_2737_Desc = {
    Text = "Beim Zurücksetzen des Decks erhält das Team [Layer] Stärke"
  },
  State_2737_Name = {
    Text = "immer gefroren"
  },
  State_2738_Name = {
    Text = "Schwächungseffekt erhöht"
  },
  State_2740_Desc = {
    Text = "Die Karte, die am „Unvollendeten Wachsskulptur“ kopiert wurde, hat einen Arithmetica Verbrauch von -1, während eine symptom-Karte erhalten wird"
  },
  State_2740_Name = {
    Text = "Status@Kapitel 2 Resonanz 5_2"
  },
  State_2740_WeaponDesc = {
    Text = "Die Karte, die am „Unvollendeten Wachsskulptur“ Punkt kopiert wurde, hat einen Arithmetica Verbrauch von -1"
  },
  State_2741_Desc = {
    Text = "Die Karte, die am „Unvollendeten Wachsskulptur“ kopiert wurde, hat einen Arithmetica Verbrauch von -1, während eine symptom-Karte erhalten wird"
  },
  State_2741_Name = {
    Text = "Status@Kapitel 2 Resonanz 5_1"
  },
  State_2741_WeaponDesc = {
    Text = "Die Karte, die am „Unvollendeten Wachsskulptur“ Punkt kopiert wurde, hat einen Arithmetica Verbrauch von -1"
  },
  State_2742_Desc = {
    Text = "Bei jedem Schaden, den die Tick-Tack-Person verursacht, erhältst du [StateArg2] temporäre Macht; für jedes erhaltene Schild erhältst du [StateArg3] temporäre Alarmbereitschaft"
  },
  State_2742_Name = {
    Text = "Parameteranpassung"
  },
  State_2744_Desc = {
    Text = "Jedes Mal, wenn eine Erwachter-Karte in den Hyperraum geht, erhält sie 15 Wahnsinn"
  },
  State_2744_Name = {
    Text = "Sprunggerät der Schöpfung"
  },
  State_2744_WeaponDesc = {
    Text = "Jedes Mal, wenn eine Erwachter-Karte in den Hyperraum geht, erhält sie 15 Wahnsinn"
  },
  State_2746_Desc = {
    Text = "ANGszahl +1, verliere [Layer] Punkte Stärke"
  },
  State_2746_Name = {Text = "Unruhe"},
  State_2747_Desc = {
    Text = "Nach dem Ausspielen erhalten andere Erwachte [StateArg1] Wahnsinn"
  },
  State_2747_Name = {
    Text = "<Rune_16:Katalyse>"
  },
  State_2748_Desc = {
    Text = "Status@LaternenRitual"
  },
  State_2748_Name = {
    Text = "Status@LaternenRitual"
  },
  State_2748_WeaponDesc = {
    Text = "Status@LaternenRitual"
  },
  State_2749_Desc = {
    Text = "In dieser Runde nach Tentakelschaden, Ziel [Layer] Schichten Vergiftung"
  },
  State_2749_Name = {
    Text = "Tiefe Strömungen"
  },
  State_2750_Desc = {
    Text = "Sink mit mir ins Meer"
  },
  State_2750_Name = {
    Text = "Ningfia Erwachen"
  },
  State_2752_Desc = {
    Text = "Wenn die Lilie Schaden verursacht, erhält sie [StateArg2] Wahnsinn"
  },
  State_2752_Name = {
    Text = "Ertrinken in Trauer"
  },
  State_2752_WeaponDesc = {
    Text = "Wenn die Lilie Schaden verursacht, erhält sie [StateArg2] Wahnsinn"
  },
  State_2753_Desc = {
    Text = "Zu Rundenbeginn, wenn Ihr Leben über [Arg1] ist, verlieren Sie [Arg1] Lebenspunkte und erhalten in dieser Runde [Arg2] Punkte Stärke und [Arg3] Punkte Wachsamkeit."
  },
  State_2754_Name = {
    Text = "Zustand @ temporäre ANGskarte kritische Rate erhöht"
  },
  State_2757_Desc = {
    Text = "Zu Beginn der nächsten Runde erhältst du zusätzlich [DescArg1] Punkte Arithmetica."
  },
  State_2757_Name = {
    Text = "Symptom: Verdacht"
  },
  State_2758_Desc = {
    Text = "Alle deine Lebensregenerationseffekte werden um [Arg1] Punkte erhöht, überschüssige Heilung wird in einen Schild umgewandelt"
  },
  State_2758_Name = {
    Text = "Schmetterlingspräparat"
  },
  State_2760_Desc = {
    Text = "Jedes Mal, wenn ein Erwachter 1 Mal verschlingt, erhalten andere Erwachte 10 Wahnsinn"
  },
  State_2762_Desc = {
    Text = "Nach dem Ausspielen wirkt sie zusätzlich [StateArg1] Mal, erhaltet [StateArg2] Punkte das schwarze Siegel, Ermüden, Eigenschaft"
  },
  State_2762_Name = {
    Text = "<Rune_7_High:Hochecho>"
  },
  State_2762_WeaponDesc = {
    Text = "Nach dem Ausspielen tritt es [StateArg1] Mal zusätzlich in Kraft, Verbrauch"
  },
  State_2763_Desc = {
    Text = "Jedes Mal, wenn der schlafende Herr 1 Arithmetica verbraucht, erhöht sich der [StateArg1] Tentakelschaden"
  },
  State_2763_Name = {
    Text = "Unsterbliche Majestät"
  },
  State_2763_WeaponDesc = {
    Text = "Jedes Mal, wenn der schlafende Herr 1 Arithmetica verbraucht, erhöht sich der [StateArg1] Tentakelschaden"
  },
  State_2764_Desc = {
    Text = "Beim Verursachen von unblockiertem Schaden, füge [StateArg1] Schichten Bluten hinzu"
  },
  State_2764_Name = {
    Text = "Bösartige Blutentnahme"
  },
  State_2765_Name = {
    Text = "Zustand @ George @ heilt beim Tod"
  },
  State_2767_Name = {
    Text = "Zustand @ das schwarze Siegel und Silberschlüsselaufladung Effizienz"
  },
  State_2769_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_2769_Name = {
    Text = "Nicht erweckt"
  },
  State_2771_Desc = {
    Text = "Monstermacht"
  },
  State_2771_Name = {
    Text = "Monstermacht"
  },
  State_2772_Name = {
    Text = "Status@Stufe2_5Kampf3Blase1"
  },
  State_2773_Desc = {
    Text = "Zu Beginn des Kampfes erhältst du 1 „Schöner Moment - Tausche alle Erwachenskarten in deiner Hand gegen „Schlag“ bis zum Ende der Runde. Behalte, verbrauche.“"
  },
  State_2775_Desc = {
    Text = "Rückkehr zur Kartenzahl"
  },
  State_2775_Name = {
    Text = "Zurücksetzen der Ziehzahl"
  },
  State_2776_Name = {
    Text = "Stein-Augen Stillstand Fluch Verstärkung"
  },
  State_2777_Name = {
    Text = "Status@Kapitel 3 Leerzustand"
  },
  State_2778_Desc = {
    Text = "Zu Beginn des Kampfes erhältst du [Arg1] Schild. Nach 7 gespielten „VERT“ in diesem Kampf erhältst du sofort [Arg2] Schild"
  },
  State_2778_Name = {
    Text = "Putney-Morgenpost"
  },
  State_2779_Desc = {
    Text = "Wenn das Leben unter 50% ([StateArg1]) fällt, wird es sich in drei Wesen mit gleichmäßigem Leben „Interferenztyp Aufgelöster Körper“ teilen"
  },
  State_2779_Name = {Text = "Spalten"},
  State_2779_WeaponDesc = {
    Text = "Wenn das Leben unter 50% ([StateArg1]) fällt, wird es sich in zwei Wesen mit gleichmäßigem Leben „II-Typ Aufgelöster Körper“ teilen"
  },
  State_2780_Desc = {
    Text = "Nach dem Ausspielen erhaltet ihr [StateArg1] Punkte Arithmetica"
  },
  State_2780_Name = {
    Text = "<Rune_4:Planung>"
  },
  State_2781_Desc = {
    Text = "Jedes Mal, wenn [Layer] Karten gespielt werden, füge eine Schicht <ParcloseIconKeywords:Barriere> hinzu, wenn keine vorhanden ist"
  },
  State_2781_Name = {
    Text = "Ladungsschild"
  },
  State_2781_WeaponDesc = {
    Text = "Unser Team erfrischt bei jeder gespielten [Layer] Karten eine Schicht Barriere für das Monster"
  },
  State_2784_Desc = {
    Text = "Auch außerhalb der Hyperdimension kann pro Runde ein Sprungeffekt ausgelöst werden. Hyperdimensionale Kapazität um 2 erhöht"
  },
  State_2785_Desc = {
    Text = "Team Unique: Nach dem Ausspielen einer Karte erhält der Ausrüster 1 Punkt Aliemus. Zu Beginn des Kampfes erhält der Ausrüster <PowerIconKeywords:Stärke> entsprechend <WeaponEffect_Num:[StateArg1]%> seiner ANGskraft. Wenn das aktuelle Reich “Aequor“ ist, erhält er zusätzlich <WeaponEffect_Num:[StateArg2]> Punkte <CardKeyWord:Tentakelschaden>. Zu Beginn jeder weiteren Runde erhält der Ausrüster <PowerIconKeywords:Stärke> entsprechend <WeaponEffect_Num:[StateArg3]%> seiner ANGskraft. Wenn das aktuelle Reich “Aequor“ ist, erhält er zusätzlich <WeaponEffect_Num:[StateArg4]> Punkte <CardKeyWord:Tentakelschaden>."
  },
  State_2785_WeaponDesc = {
    Text = "Nachdem der Ausrüster eine Karte gespielt hat, erhält der Ausrüster 1 Punkt Wahnsinn. Beim Kampfbeginn erhält er <WeaponEffect_Num:[Power:DescArg1]> Punkte <PowerIconKeywords:Stärke>. Wenn das aktuelle Reich “Aequor“ ist, erhält er zusätzlich <WeaponEffect_Num:[DescArg2]> Punkte <CardKeyWord:Tentakelschaden>. Am Anfang jeder folgenden Runde erhält er <WeaponEffect_Num:[Power:DescArg3]> Punkte <PowerIconKeywords:Stärke>. Wenn das aktuelle Reich “Aequor“ ist, erhält er zusätzlich <WeaponEffect_Num:[DescArg4]> Punkte <CardKeyWord:Tentakelschaden>."
  },
  State_2786_Name = {
    Text = "Schöpfung Blutiger Kieselstein Zähler"
  },
  State_2787_Desc = {
    Text = "Heile Leben, mische 1 „Nihil-Ende“ in den Ablagestapel. Permanent, zerstören"
  },
  State_2787_Name = {
    Text = "<CardKeyWord:Wahrheitssuche>"
  },
  State_2787_WeaponDesc = {
    Text = "Heile Leben, mische 1 „Nihil-Ende“ in den Ablagestapel. Permanent, zerstören"
  },
  State_2788_Desc = {
    Text = "Zu Beginn der Runde ziehe [StateArg1] Karten"
  },
  State_2788_Name = {
    Text = "Schöpfung Prophetens Wunschlampe1"
  },
  State_2788_WeaponDesc = {
    Text = "Zu Beginn der Runde ziehe [StateArg1] Karten"
  },
  State_2789_Desc = {
    Text = "Die Karte wurde von Jenkin manipuliert! Beim Spielen werden [Layer] <FixedDamage:Reiner SCH> erlitten."
  },
  State_2789_Name = {
    Text = "<CardKeyWord:Nach dem Ausspielen [Layer] Schaden erleiden>"
  },
  State_2789_WeaponDesc = {
    Text = "Nach dem Ausspielen der Karte erleidet man [StateArg1] Schaden."
  },
  State_2790_Desc = {
    Text = "Nach Rundenende kann [StateArg1] Karten behalten"
  },
  State_2790_Name = {
    Text = "Schöpfung Prophetens Wunschlampe2"
  },
  State_2790_WeaponDesc = {
    Text = "Nach Rundenende kann [StateArg1] Karten behalten"
  },
  State_2792_Desc = {
    Text = "Zu Beginn des Kampfes erhalten alle Verbündeten 3 Schichten[Wachstumsrüstung]. Zu Beginn der Runde wird eine \"Anfälle\"-Karte in den Deckablage auf die eigene Seite gewaschen"
  },
  State_2792_Name = {
    Text = "“Dame aus Wachs“"
  },
  State_2792_WeaponDesc = {
    Text = "Zu Beginn des Kampfes erhalten alle Verbündeten 3 Schichten[Wachstumsrüstung]. Zu Beginn der Runde wird eine \"Anfälle\"-Karte in den Deckablage auf die eigene Seite gewaschen"
  },
  State_2793_Desc = {
    Text = "Status@Steinauge Todeskampf"
  },
  State_2793_Name = {
    Text = "Status@Steinauge Todeskampf"
  },
  State_2793_WeaponDesc = {
    Text = "Status@Steinauge Todeskampf"
  },
  State_2796_Desc = {
    Text = "Jedes Mal, wenn du Leben verlierst, füge allen Feinden [Arg1] Schichten Gift hinzu. Erhöhe den Giftwert pro Runde um [Arg2]"
  },
  State_2797_Desc = {
    Text = "Zu Beginn der Runde füge einen „Sonnenschirm“ mit [Arg1] Alarm, den du in dieser Runde erhältst, zu deiner Hand hinzu. Nachdem du 6 Karten gespielt hast, erhöhe alle „Sonnenschirm“ in deiner Hand um [Arg2] Alarm"
  },
  State_2798_Desc = {
    Text = "Der liebe Hauptpriester aktiviert einen Schild, der 1 zufällige Handkarte bis zur Spielausführung -1 an Arithmetica verbraucht"
  },
  State_2798_Name = {
    Text = "Väterliche Gnade"
  },
  State_2798_WeaponDesc = {
    Text = "Der liebe Hauptpriester aktiviert einen Schild, der 1 zufällige Handkarte bis zur Spielausführung -1 an Arithmetica verbraucht"
  },
  State_2799_Desc = {
    Text = "Wenn die Mondqualle Aktiven Schaden verursacht, werden [StateArg1] Tentakelangriffe auf das Ziel ausgelöst."
  },
  State_2799_Name = {
    Text = "Selbstvermehrung"
  },
  State_2799_WeaponDesc = {
    Text = "Wenn Mondlicht Schaden verursacht, greift [StateArg1] Tentakel das Ziel an"
  },
  State_2800_Desc = {
    Text = "Der durch den Ausrüster verursachte Schaden, Schild und die Heilung erhöhen sich um [StateArg1]% (temporär)"
  },
  State_2800_Name = {
    Text = "Status@Prototyp Messer Schaden"
  },
  State_2801_Desc = {
    Text = "Tatsächlicher Schaden erhöht die Tiefe der Erosion"
  },
  State_2801_Name = {
    Text = "Schaden erleiden erhöht die Tiefe der Erosion"
  },
  State_2801_WeaponDesc = {
    Text = "Tatsächlicher Schaden erhöht die Tiefe der Erosion"
  },
  State_2802_Desc = {
    Text = "Zu Beginn der Runde erhältst du temporäre Stärke"
  },
  State_2802_Name = {
    Text = "Temporäre Stärke erhöhen"
  },
  State_2804_Desc = {
    Text = "Der durch den Ausrüster verursachte Schaden, Schild und die Heilung erhöhen sich um [StateArg1]% (temporär)"
  },
  State_2804_Name = {
    Text = "Status@Prototyp Laserkanone Schaden"
  },
  State_2805_Desc = {
    Text = "Am Ende der Runde, andere Verbündete erhalten Stärke"
  },
  State_2805_Name = {
    Text = "Licht der Erleuchtung"
  },
  State_2807_Desc = {
    Text = "Zu Beginn der Runde füge einen „Sonnenschirm“ mit [Arg1] Alarm, den du in dieser Runde erhältst, zu deiner Hand hinzu. Nachdem du 6 Karten gespielt hast, erhöhe alle „Sonnenschirm“ in deiner Hand um [Arg2] Alarm"
  },
  State_2808_Desc = {
    Text = "Am Ende der Runde wird 1 Embryo-Fusionsgrad erzeugt; wenn sich ein Embryo im Handkarten befindet, erhält man 15 Gesundheit zurück"
  },
  State_2808_Name = {
    Text = "Anomales Hämostat"
  },
  State_2808_WeaponDesc = {
    Text = "Am Ende der Runde wird 1 Embryo-Fusionsgrad erzeugt; wenn sich ein Embryo im Handkarten befindet, erhält man 15 Gesundheit zurück"
  },
  State_2809_Desc = {
    Text = "Nach dem Aufheben verliert man dauerhaft [Arg1] Kraft. Bei jedem verursachten Schaden werden [Arg2] Lebenspunkte wiederhergestellt, maximal 6 Mal pro Runde"
  },
  State_2809_Name = {
    Text = "Kuss der Neunmäuler"
  },
  State_2810_Desc = {
    Text = "Am Ende der Runde erhält man [Layer] % maximalen Lebenspunkten zurück"
  },
  State_2810_Name = {
    Text = "Selbstheilung"
  },
  State_2810_WeaponDesc = {
    Text = "Am Ende der Monsterrunde, heile [Layer]% der maximalen LP"
  },
  State_2811_Desc = {
    Text = "Wenn du eine Symptom-Karte ziehst, erhältst du [Arg1] Punkte Macht. Für jedes verfluchte Orison oder verfluchte Relikt erhöhst du deine kritische Rate und deinen kritischen Schaden um 10%"
  },
  State_2812_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_2812_Name = {
    Text = "Nicht erweckt"
  },
  State_2813_Desc = {
    Text = "Zu Rundenbeginn verlieren Sie Arithmetica"
  },
  State_2813_Name = {
    Text = "Fehlkalkulation!"
  },
  State_2814_Desc = {
    Text = "Beim Kampfsieg werden die erhaltenen Orison zu mächtigen und gefährlichen Fluch-Orison"
  },
  State_2817_Desc = {
    Text = "Pro Schicht wird der erlittene Schaden um [StateArg1] reduziert, nach jedem kritischen Treffer 1 Schicht weniger"
  },
  State_2817_Name = {
    Text = "wachsame Rüstung"
  },
  State_2817_WeaponDesc = {
    Text = "Immun gegen anormale Zustände, nach einem kritischen Treffer entfernt"
  },
  State_2818_Desc = {
    Text = "In Korrosions-Triangel A und B aufteilen"
  },
  State_2818_Name = {Text = "Spalten"},
  State_2818_WeaponDesc = {
    Text = "In Korrosions-Triangel A und B aufteilen"
  },
  State_2820_Desc = {
    Text = "Nach dem Ausspielen erhaltet ihr [StateArg1] Punkte temporäre Stärke, die Karte erhält ebenfalls den Stärkebonus"
  },
  State_2820_Name = {
    Text = "<Rune_15:Explosion>"
  },
  State_2821_Name = {
    Text = "Temporäre Immunität gegen Verwundbarkeit"
  },
  State_2823_Desc = {
    Text = "Team Unique: Zu Kampfbeginn werden den vorderen Feinden 2 Stapel <VulnerabilityIconKeywords:Verwundbar> auferlegt. Zu Rundenbeginn verlieren Feinde im Verwundbar-Zustand temporäre <PowerIconKeywords:Stärke> in Höhe von <WeaponEffect_Num:[StateArg1] %> der ANG des Ausrüsters. Befindet sich das aktuelle Reich im „Caro \"-Bereich, erhöht sich nach dem Einsetzen der „Verherrlichung\" durch den Ausrüster die Embryofusion +<WeaponEffect_Num:[Blood:StateArg2]>."
  },
  State_2823_WeaponDesc = {
    Text = "Zu Kampfbeginn werden den vorderen Feinden 2 Stapel <VulnerabilityIconKeywords:Verwundbar> auferlegt. Zu Rundenbeginn verlieren Feinde im Verwundbar-Zustand <WeaponEffect_Num:[Power:DescArg1]> Punkte temporäre <PowerIconKeywords:Stärke>. Befindet sich das aktuelle Reich im „Caro \"-Bereich, erhöht sich nach dem Einsetzen der „Verherrlichung\" durch den Ausrüster die Embryofusion +<WeaponEffect_Num:[Blood:StateArg2]>."
  },
  State_2825_Desc = {
    Text = "Monster Überdimensional-Kartenplatzlimit"
  },
  State_2825_Name = {
    Text = "Monster Überdimensional-Kartenplatzlimit"
  },
  State_2825_WeaponDesc = {
    Text = "Monster Überdimensional-Kartenplatzlimit"
  },
  State_2826_Desc = {
    Text = "Wenn du zwei Karten mit niedrigerem Arithmetica-Verbrauch als die vorherige ausspielst, erhält der aktuelle Erwecker mit dem niedrigsten Aelius 50 Aelius"
  },
  State_2826_Name = {
    Text = "Arkane Relikte der Schöpfung"
  },
  State_2827_Desc = {
    Text = "Schadensanzahl und Schadenssteigerung"
  },
  State_2827_Name = {
    Text = "<CardKeyWord:Aufrüsten>"
  },
  State_2829_Desc = {
    Text = "Beim Verursachen von tatsächlichem Schaden erhält man [Layer] Kraft"
  },
  State_2829_Name = {
    Text = "“Verwirrte Persönlichkeit“"
  },
  State_2830_Desc = {
    Text = "Wenn im Team ein Erwecker der Beruf[Aequor] vorhanden ist, erhöht sich die maximale Gesundheit (unvollständig), VERT und ANG des gesamten Teams um 50%"
  },
  State_2830_Name = {
    Text = "Tiefseebonus"
  },
  State_2830_WeaponDesc = {
    Text = "Wenn im Team ein Erwecker der Beruf[Aequor] vorhanden ist, erhöht sich die maximale Gesundheit (unvollständig), VERT und ANG des gesamten Teams um 50%"
  },
  State_2832_Desc = {
    Text = "Der durch den Ausrüster verursachte Schaden, Schild und die Heilung erhöhen sich um [StateArg1]% (temporär)"
  },
  State_2832_Name = {
    Text = "Status@Prototyp Laserkanone Todeswiderstand"
  },
  State_2833_Desc = {
    Text = "Zu Rundenbeginn ziehen Sie 1 Karte. Jedes Mal, wenn Sie 1 Karte ziehen, ändert sich der Arithmetica-Verbrauch zufällig (0-4)"
  },
  State_2835_Desc = {
    Text = "Bei jedem Verschlingen stehle [Arg1] temporäre Kraft von allen Feinden"
  },
  State_2836_Name = {
    Text = "Status@Fluch Blindes Gehorsam"
  },
  State_2837_Name = {
    Text = "Status@Fluch Blindes Gehorsam"
  },
  State_2838_Name = {
    Text = "Status@Fluch Blindes Gehorsam"
  },
  State_2840_Desc = {
    Text = "Erleidet am Rundenende [Layer] <FixedDamage:Reinen SCH> und entfernt [DescArg1]% der Stapelungen. Beim Wiederherstellen von LP werden doppelt so viele Bluten-Stapelungen entfernt wie LP wiederhergestellt werden."
  },
  State_2840_Name = {
    Text = "<BleedingColour: Bluten>"
  },
  State_2840_WeaponDesc = {
    Text = "Nach dem Ende der Runde erleide [Layer] Punkte Schaden und entferne diesen Zustand; jede Heilung kann die Schichten halbieren"
  },
  State_2842_Desc = {
    Text = "Nach Ausspielen [StateArg1] <RetaliateIconKeywords:Gegenangriff> erhalten, füge allen Gegnern [StateArg2]% echten Schaden durch <RetaliateIconKeywords:Gegenangriff> zu"
  },
  State_2842_Name = {
    Text = "<Rune_9:Spieß>"
  },
  State_2843_Desc = {
    Text = "Unser Team erhält bei jeder gespielten Karte [StateArg1] Schichten Schild. Hält 1 Runde"
  },
  State_2843_Name = {
    Text = "Fliegender Federhimmel"
  },
  State_2843_WeaponDesc = {
    Text = "Unser Team erhält bei jeder gespielten Karte [StateArg1] Schichten Schild. Hält 1 Runde"
  },
  State_2844_Desc = {
    Text = "Pro Kampf beim ersten Lebensverlust 1 Schicht Barriere gegen Schaden erhalten"
  },
  State_2845_Name = {
    Text = "Schmuckstück Grabflüstern"
  },
  State_2845_WeaponDesc = {
    Text = "Zu Beginn des Levels wird der Todeswiderstand um 25% erhöht. Nach dem Auslösen des Todeswiderstands erhält der Ausrüster 50 Punkte Aelius"
  },
  State_2846_Desc = {
    Text = "Immun gegen einen Tod, nach Auslösung [Arg1] Leben wiederherstellen und das Artefakt dauerhaft ungültig machen"
  },
  State_2846_Name = {
    Text = "Ersatzpuppe"
  },
  State_2847_Desc = {
    Text = "Jeder gespielte Karte des gejagten Erwachten fügt eine Jagdmarke hinzu und zieht Karten in Höhe der Hälfte der Jagdmarken"
  },
  State_2847_Name = {
    Text = "Jagdzeremonie"
  },
  State_2849_Desc = {
    Text = "Jedes Mal, wenn du Leben verlierst, erhältst du [Arg1] Punkte Kraft, maximal 10 Mal. Bei voller Schicht regeneriere 25 % des verlorenen Lebens"
  },
  State_2849_Name = {
    Text = "Höchste Ehre"
  },
  State_2853_Desc = {
    Text = "Ruhe-Sessel-Zähler der Schöpfung"
  },
  State_2854_Desc = {
    Text = "Nach dem Tod keine Wahnsinnsenergie für Erwachensformen"
  },
  State_2854_Name = {Text = "egoistisch"},
  State_2854_WeaponDesc = {
    Text = "Nach dem Tod keine Wahnsinnsenergie für Erwachensformen"
  },
  State_2855_Desc = {
    Text = "Schadensbonus für Schlagkarten um [StateArg1] %, für [Layer] Runden."
  },
  State_2855_Name = {
    Text = "Kampf ums Überleben·Schlag"
  },
  State_2855_WeaponDesc = {
    Text = "In dieser Runde „Schlag“-Kartenschaden +[Layer] %"
  },
  State_2856_Desc = {
    Text = "Team Unique: Die von dem Ausrüster erzeugten Schilde erhöhen sich um <WeaponEffect_Num:[StateArg1]％>, und wenn Schilde erzeugt werden, erhält das gesamte Team <WeaponEffect_Num:[StateArg3]％> vorübergehende kritische Trefferquote und <WeaponEffect_Num:[StateArg4]%> Keyflare-Regeneration des Ausrüsters, maximal 2 Mal pro Runde. Wenn das aktuelle Reich “Aequor“ ist, erhält der Ausrüster für jeden Tentakelangriff 1 Punkt Aliemus, maximal <WeaponEffect_Num:[StateArg2]> Punkte pro Runde."
  },
  State_2856_WeaponDesc = {
    Text = "Der Schutzschild, den der Ausrüster verursacht, erhöht sich um <WeaponEffect_Num:[StateArg1]%>, und wenn ein Schutzschild verursacht wird, erhält das gesamte Team <WeaponEffect_Num:[StateArg3]%> temporäre kritische Trefferquote und <WeaponEffect_Num:[StateArg4]> Punkte Keyflare-Regeneration des Ausrüsters, maximal 2 Mal pro Runde. Wenn das aktuelle Reich “Aequor“ ist, erhält der Ausrüster für jeden Tentakelangriff 1 Punkt Aliemus, maximal <WeaponEffect_Num:[StateArg2]> Punkte pro Runde."
  },
  State_2857_Desc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwecker 10 Aelius. Die maximale Gesundheit reduziert sich um 50%"
  },
  State_2858_Name = {
    Text = "Beim Ausspielen erhält man zusätzlich zwei Schichten Barriere"
  },
  State_2859_Desc = {
    Text = "Zu Beginn des Kampfes bleibt diese Karte in der Hand"
  },
  State_2859_Name = {
    Text = "<CardKeyWord:Eigen>"
  },
  State_2860_Desc = {
    Text = "Beim Ziehen sinkt deine maximale Gesundheit um 10%. Nach der Benutzung erhöht sich der kritische Schaden aller Erwecker in dieser Runde um 100%. Nicht verkäuflich"
  },
  State_2860_Name = {
    Text = "Status Fluch Erosion"
  },
  State_2860_WeaponDesc = {
    Text = "Beim Ziehen sinkt deine maximale Gesundheit um 10%. Nach der Benutzung erhöht sich der kritische Schaden aller Erwecker in dieser Runde um 100%. Nicht verkäuflich"
  },
  State_2861_Name = {
    Text = "(Verbleibend: [Layer])"
  },
  State_2862_Desc = {
    Text = "Am Ende der Runde erleide zusätzlichen Vergiftungsschaden"
  },
  State_2862_Name = {
    Text = "Körperliche Schwäche"
  },
  State_2863_Desc = {
    Text = "Evolutionsstufe"
  },
  State_2863_Name = {
    Text = "Evolutionsstufe"
  },
  State_2863_WeaponDesc = {
    Text = "Evolutionsstufe"
  },
  State_2864_Desc = {
    Text = "“24“ hat sich bereits gewacht, nutze den letzten „Rette mich“ um eine Gelegenheit zu finden!"
  },
  State_2864_Name = {
    Text = "“24“ Erwachen!"
  },
  State_2864_WeaponDesc = {
    Text = "Nach Beginn der nächsten Runde, erhalte Schild in Höhe des verlorenen Lebens der letzten Runde"
  },
  State_2866_Desc = {
    Text = "Team Unique: Maximale Handgröße +2, am Ende der Runde erhältst du Keyflare in Höhe von <WeaponEffect_Num:[StateArg1] %> der Keyflare-Regeneration des Ausrüsters. Nach jeder Freisetzung der Posse erhalten alle Erwecker <WeaponEffect_Num:[StateArg2]> Punkte Aliemus, und wenn das aktuelle Reich „Fleisch \" ist, erhöht sich die Embryofusion um <WeaponEffect_Num:+[Blood:StateArg3] %>."
  },
  State_2866_WeaponDesc = {
    Text = "Maximale Handgröße +2. Am Rundenende erhält man <WeaponEffect_Num:[DescArg1]> Keyflare. Nach jeder ausgelösten Posse erhalten alle Erwecker <WeaponEffect_Num:[StateArg2]> Aliemus. Ist das aktuelle Reich „Fleisch \", erhöht sich die Embryofusion zusätzlich um <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_2868_Desc = {
    Text = "Am Ende der Runde erhalten alle Erwachten 2 Wahnsinn für jede ungespielte Karte in deiner Hand"
  },
  State_2871_Desc = {
    Text = "Unter 50%([StateArg1]) Leben beschwört ein „Erosionsdreieck“ mit gleicher Lebensmenge"
  },
  State_2871_Name = {
    Text = "Beschwören"
  },
  State_2871_WeaponDesc = {
    Text = "Unter 50%([StateArg1]) Leben beschwört ein „Erosionsdreieck“ mit gleicher Lebensmenge"
  },
  State_2874_Desc = {
    Text = "Der Erwachte wird vom Schädeljäger beobachtet, das Spielen seiner Karten zieht 2 zusätzliche Karten"
  },
  State_2875_Desc = {
    Text = "Nach Ausspielen <EmbryoFusionIconKeywords:Embryofusion> +[StateArg1]."
  },
  State_2875_Name = {
    Text = "<Rune_12_High:Hochblutrausch>"
  },
  State_2875_WeaponDesc = {
    Text = "Nach dem Spielen Embryofusion+ [Blood:StateArg1]."
  },
  State_2876_Desc = {
    Text = "Nach Kampfende zusätzliche 50 schwarze Siegel und 1 Symptomkarte erhalten"
  },
  State_2877_Desc = {
    Text = "Die Rote Dame erhält für jeden verursachten Schaden [StateArg2] temporäre Stärke"
  },
  State_2877_Name = {
    Text = "Privileg der Gastgeberin"
  },
  State_2878_Desc = {
    Text = "Schadensanzahl +1, aber Schaden um 25% reduziert"
  },
  State_2878_Name = {Text = "Raserei"},
  State_2878_WeaponDesc = {
    Text = "Schadensanzahl +1, aber Schaden um 25% reduziert"
  },
  State_2879_Name = {
    Text = "süße Schnecke"
  },
  State_2879_WeaponDesc = {
    Text = "Nach der Verwendung von „Vernichtung“, wenn man sich in dieser Runde im Zustand des „Ruhigen Meeres“ befindet, erhöhen sich die Schild- und Heilungseffekte des Ausrüsters in dieser Runde um 30 %."
  },
  State_2880_Name = {
    Text = "Zustand @ Apostel des Meeres erleuchten 7"
  },
  State_2881_Desc = {
    Text = "Jedes Mal, wenn 1 „Heilige Gabe“ in „Wahn“ umgewandelt wird, erhöht sich der Basis-Schaden von Miryam in diesem Kampf um 15%"
  },
  State_2881_Name = {
    Text = "Blasen der Illusion zerplatzen"
  },
  State_2883_Desc = {
    Text = "Team Unique: Nachdem der Ausrüster Aktiven Schaden verursacht, besteht eine Chance von <WeaponEffect_Num:[StateArg1]%>, 1 seiner Befehlskarten zu ziehen und deren Arithmetica-Kosten um 1 zu reduzieren. Dieser Effekt wird nur einmal pro Runde ausgelöst."
  },
  State_2883_WeaponDesc = {
    Text = "Nachdem der Ausrüster Aktiven Schaden verursacht, besteht eine Chance von <WeaponEffect_Num:[StateArg1]%>, 1 seiner Befehlskarten zu ziehen und deren Arithmetica-Kosten um 1 zu reduzieren. Dieser Effekt wird nur einmal pro Runde ausgelöst."
  },
  State_2884_Name = {
    Text = "Der verursachte Schaden ist <PunctureDamagewords:Durchdringungsschaden>. Reduziere den Arithmetica-Verbrauch der höchsten Karte in deiner Hand um 1"
  },
  State_2885_Name = {
    Text = "Status@RundenbeginnKartenZiehen+2"
  },
  State_2887_Desc = {
    Text = "Team-Unique: Nach der Freisetzung des Exaltieren erhöht sich der kritische Schaden des Trägers in dieser Runde um <WeaponEffect_Num:[StateArg1]>, und alle Karten des Trägers haben eine Chance von <WeaponEffect_Num:[StateArg2]%>, die Kosten in dieser Runde um 1 Punkt zu senken"
  },
  State_2887_WeaponDesc = {
    Text = "Nach dem Einsatz von Wut-Exaltation erhöht sich der kritische Schaden des Ausrüsters in dieser Runde um <WeaponEffect_Num:[StateArg1]%>, und alle Karten der Ausrüster in der Hand haben eine <WeaponEffect_Num:[StateArg2]%> Chance, in dieser Runde 1 Punkt Arithmetica zu sparen"
  },
  State_2888_Desc = {
    Text = "Wenn sich ein „Embryo“ auf der Hand befindet, verbrauche 1 Karte und löse den Effekt aus"
  },
  State_2888_Name = {
    Text = "<DevouredIconKeywords:Verschlungen>"
  },
  State_2888_WeaponDesc = {
    Text = "Verbrauche Embryo-Karten aus der Hand und aktiviere einen mächtigen Verschlingungseffekt"
  },
  State_2889_Name = {
    Text = "Wähle 1 Erwachten, erhalte <Energy:[DescArg1]> Wahnsinn"
  },
  State_2890_Desc = {
    Text = "Zu Beginn des Kampfes erleidet das Team 1 Schicht Verwundbarkeit"
  },
  State_2890_Name = {
    Text = "Rüstungsdurchdringung"
  },
  State_2890_WeaponDesc = {
    Text = "Zu Beginn des Kampfes erleidet das Team 1 Schicht Verwundbarkeit"
  },
  State_2891_Name = {
    Text = "Wut-Auftakt-Antworten-Steigerung"
  },
  State_2892_Desc = {
    Text = "Am Ende der Runde werden [Layer] Lebenspunkte wiederhergestellt."
  },
  State_2892_Name = {
    Text = "Verzögerte Lebensregeneration"
  },
  State_2892_WeaponDesc = {
    Text = "Bis zum Ende der Runde heilt jeder Kill [Layer] Lebenspunkte"
  },
  State_2897_Desc = {
    Text = "Beim Auslösen des Ursprungs wird die temporäre Macht des Feindes gesenkt"
  },
  State_2897_Name = {
    Text = "Furcht vor Wahn"
  },
  State_2899_Desc = {
    Text = "Wenn der Gegner 4 oder mehr Karten auf der Hand hat, erhältst du beim Erleiden von Schaden [StateArg1] Schildpunkte"
  },
  State_2899_Name = {Text = "Schlange"},
  State_2900_Desc = {
    Text = "Schaden in diesem Kampf um [Layer] Punkte erhöht"
  },
  State_2900_Name = {Text = "Stärke"},
  State_2900_WeaponDesc = {
    Text = "Schaden in diesem Kampf um [Layer] Punkte erhöht"
  },
  State_2901_Desc = {
    Text = "[Exaltieren] verleiht 20 Punkte Wahnsinn"
  },
  State_2901_Name = {
    Text = "Schöpfung Schleier des namenlosen Gottes"
  },
  State_2901_WeaponDesc = {
    Text = "[Exaltieren] verleiht 20 Punkte Wahnsinn"
  },
  State_2902_Desc = {
    Text = "Das Gehirn im Glas verdoppelt die Lebenspunkte"
  },
  State_2902_Name = {
    Text = "Losgelöstes Gewebe"
  },
  State_2902_WeaponDesc = {
    Text = "Das Gehirn im Glas verdoppelt die Lebenspunkte"
  },
  State_2903_Desc = {
    Text = "Der durch den Ausrüster verursachte Schaden, Schild und die Heilung erhöhen sich um [StateArg1]% (temporär)"
  },
  State_2903_Name = {
    Text = "Status@Prototyp Messer Kritisch"
  },
  State_2904_Desc = {
    Text = "Nach jedem tatsächlichen Schaden, erhalte 10 Schild"
  },
  State_2904_Name = {Text = "Puffer"},
  State_2904_WeaponDesc = {
    Text = "Nach jedem tatsächlichen Schaden, erhalte 10 Schild"
  },
  State_2905_Desc = {
    Text = "Team Unique: Der Schutzschild, der durch die “Verherrlichung“ des Ausrüsters verursacht wird, erhöht sich um <WeaponEffect_Num:[StateArg2]%. Nach der Freisetzung der “Verherrlichung“ erhält der Ausrüster vorübergehend <PowerIconKeywords:Stärke> in Höhe von <WeaponEffect_Num:[StateArg1]%> Stapelungen seiner VERT. Wenn unser Team im Zustand <FragileIconKeywords:Zerbrechlich> ist, wird der Effekt verdoppelt."
  },
  State_2905_WeaponDesc = {
    Text = "Der Schutzschild, der durch die “Verherrlichung“ des Ausrüsters verursacht wird, erhöht sich um <WeaponEffect_Num:[StateArg2]%. Nach der Freisetzung von “Verherrlichung“ erhält der Ausrüster [Power:DescArg1] Punkte vorübergehende <PowerIconKeywords:Stärke>. Wenn unser Team im Zustand <FragileIconKeywords:Zerbrechlich> ist, wird der Effekt verdoppelt."
  },
  State_2906_Desc = {
    Text = "Nach Verursachen von tatsächlichem Schaden wird die temporäre Kraft des Teams um [Layer] gesenkt"
  },
  State_2906_Name = {
    Text = "Lähmungsstoß"
  },
  State_2909_Desc = {
    Text = "Besitze [Layer] Punkte Wahnsinn. Wenn der Wahnsinn größer oder gleich 5 ist, wird die Absicht zu „Schmaus auf die Verdorbenen“, nach einer Verringerung des Wahnsinns wird sie wiederhergestellt"
  },
  State_2909_Name = {
    Text = "Status@Monster24Verdrehtes Leichenfest Zählung"
  },
  State_2909_WeaponDesc = {
    Text = "Besitze [Layer] Punkte Wahnsinn. Wenn der Wahnsinn größer oder gleich 5 ist, wird die Absicht zu „Schmaus auf die Verdorbenen“, nach einer Verringerung des Wahnsinns wird sie wiederhergestellt"
  },
  State_2910_Desc = {
    Text = "Team Unique: Zu Beginn der Erkundung wird eine „Einblick“-Karte und eine „Schlag“-Karte des Ausrüsters ins Deck gemischt. Der Grundschaden des „Schlags“ des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%, nach dem Ausspielen besteht eine <WeaponEffect_Num:[StateArg2]% Chance, eine Karte zu ziehen. Dieser Effekt kann pro Runde maximal einmal ausgelöst werden. Wenn das aktuelle Reich „Ultra“ ist und in einer Ultra-Runde, wird eine „Einblick“-Karte auf die Hand des Ausrüsters gelegt, dieser Effekt kann pro Runde maximal einmal ausgelöst werden."
  },
  State_2910_WeaponDesc = {
    Text = "Zu Beginn der Erkundung wird eine „Einblick“-Karte und eine „Schlag“-Karte des Ausrüsters ins Deck eingefügt. Der Grundschaden des „Schlags“ des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%, und nach dem Ausspielen besteht eine Wahrscheinlichkeit von <WeaponEffect_Num:[StateArg2]%, 1 Karte zu ziehen. Dieser Effekt kann pro Runde maximal einmal ausgelöst werden. Wenn das aktuelle Reich „Ultra“ ist und in einer Ultra-Runde, wird 1 „Einblick“ in die Hand des Ausrüsters gelegt, dieser Effekt kann pro Runde maximal einmal ausgelöst werden."
  },
  State_2911_Desc = {
    Text = "Status@Reine Fantasiewelt Modifikation Zählung"
  },
  State_2911_Name = {
    Text = "Status@Reine Fantasiewelt Zählung"
  },
  State_2911_WeaponDesc = {
    Text = "Status@Reine Fantasiewelt Modifikation Zählung"
  },
  State_2912_Desc = {
    Text = "Du wurdest markiert! Das Ausspielen von „Seefahrer“ gewährt [StateArg1] temporäre Stärke und entfernt das Tiefenmark von dieser Anweisung"
  },
  State_2912_Name = {
    Text = "<CardKeyWord:Tiefseezeichen>"
  },
  State_2912_WeaponDesc = {
    Text = "Nach dem Ausspielen der Karte erhält der Tiefseewächter [StateArg1] temporäre Stärke"
  },
  State_2913_Desc = {
    Text = "Zu Beginn des Kampfes 3 Runden lang selbst verletzlich"
  },
  State_2913_Name = {
    Text = "Schöpfung Seltsame Klaue2"
  },
  State_2913_WeaponDesc = {
    Text = "Zu Beginn des Kampfes 3 Runden lang selbst verletzlich"
  },
  State_2914_Desc = {
    Text = "Unter 50% Leben ändert sich die Absicht, ein „Erosionsdreieck“ mit gleicher Lebensmenge zu beschwören"
  },
  State_2914_Name = {Text = "Spaltung"},
  State_2914_WeaponDesc = {
    Text = "Unter 50% Leben ändert sich die Absicht, ein „Erosionsdreieck“ mit gleicher Lebensmenge zu beschwören"
  },
  State_2915_Desc = {
    Text = "Erhöht die Schadensanzahl von „Kette des Grolls“ um +[Layer] Mal"
  },
  State_2915_Name = {Text = "Hass"},
  State_2915_WeaponDesc = {
    Text = "Erhöht die Schadensanzahl von „Kette des Grolls“ um +[Layer] Mal"
  },
  State_2917_Desc = {
    Text = "Am Ende der Runde, für jede verbleibende Handkarte, erhält man zu Beginn der nächsten Runde 1 Punkt Arithmetica"
  },
  State_2917_Name = {
    Text = "Status@TraumSilberschlüssel:Berechnung"
  },
  State_2918_Desc = {
    Text = "Schaden um 99 % reduziert. Nach aktivem Schaden wird 1 Schicht entfernt, zu Beginn der Runde auf 3 Schichten wiederhergestellt"
  },
  State_2918_Name = {
    Text = "“ Unsterbliche Überreste “"
  },
  State_2918_WeaponDesc = {
    Text = "Schaden um 99 % reduziert. Nach aktivem Schaden wird 1 Schicht entfernt, zu Beginn der Runde auf 3 Schichten wiederhergestellt"
  },
  State_2919_Desc = {
    Text = "Status@Smaragdfeuer Smaragd Spiegelung Vorzeit"
  },
  State_2919_Name = {
    Text = "Status@Smaragdfeuer Smaragd Spiegelung Vorzeit"
  },
  State_2919_WeaponDesc = {
    Text = "Status@Smaragdfeuer Smaragd Spiegelung Vorzeit"
  },
  State_2922_Desc = {
    Text = "Bei der Erschöpfung von 1 Punkt Arithmetica erhält der entsprechende Erwecker 2 Punkte Aelius"
  },
  State_2923_Desc = {
    Text = "Am Ende der Runde, Stärke +[Layer]"
  },
  State_2923_Name = {
    Text = "Götterabstieg-Ritual"
  },
  State_2923_WeaponDesc = {
    Text = "Am Ende jeder Runde [Layer] Stärke erhalten"
  },
  State_2925_Desc = {
    Text = "Jedes Mal, wenn Smaragdfire Schaden verursacht, +1 Stapel"
  },
  State_2925_Name = {
    Text = "Smaragdspiegel-Zählung"
  },
  State_2925_WeaponDesc = {
    Text = "Jedes Mal, wenn Smaragdfire Schaden verursacht, +1 Stapel"
  },
  State_2927_Name = {
    Text = "Status@Fluch Delirium Veränderung"
  },
  State_2929_Desc = {
    Text = "Team Unique: Jedes Mal, wenn der Ausrüster 1 Mal Schaden verursacht, besteht eine Chance von <WeaponEffect_Num:[StateArg3] %>, dass der Ausrüster 2% temporären Krit. Schaden erhält. Nach der Verherrlichung des Ausrüsters wird 3 Mal aktiver Schaden in Höhe von <WeaponEffect_Num:[StateArg1] %> des ATK des Ausrüsters an zufällige Feinde verursacht. Ist das aktuelle Reich „Fleisch \", erhöht sich die Embryofusion um <WeaponEffect_Num:[Blood:StateArg2]> für jeden vom Ausrüster verschlungenen Embryo."
  },
  State_2929_WeaponDesc = {
    Text = "Jedes Mal, wenn der Ausrüster 1 Mal Schaden verursacht, besteht eine Chance von <WeaponEffect_Num:[StateArg3] %>, dass der Ausrüster 2% temporären Krit. Schaden erhält. Nach der Verherrlichung des Ausrüsters wird 3 Mal [DescArg1] aktiver Schaden an zufällige Feinde verursacht. Ist das aktuelle Reich „Fleisch \", erhöht sich die Embryofusion um <WeaponEffect_Num:+[Blood:StateArg2]> für jeden vom Ausrüster verschlungenen Embryo."
  },
  State_2930_Name = {
    Text = "Status@George@Kraft bei Tod"
  },
  State_2931_Desc = {
    Text = "Bei jedem Verschlingen stehle 4 temporäre Kraft von allen Feinden"
  },
  State_2931_Name = {
    Text = "Mutierte Seidenachat"
  },
  State_2933_Name = {
    Text = "Schmuckstück Verdrehte Zwillinge Weiß"
  },
  State_2933_WeaponDesc = {
    Text = "Nach Beginn einer geraden Runde wird eine Karte mit Nichtigkeit und erschöpfen der Ausrüstungsfähigkeiten \"VERT\" deiner Hand hinzugefügt"
  },
  State_2934_Desc = {
    Text = "Gesamter erlittener Aktiver Schaden und Tentakelschaden +[DescArg1]%."
  },
  State_2934_Name = {
    Text = "<VulnerabilityColour:Verwundbarkeit>"
  },
  State_2934_WeaponDesc = {
    Text = "Erhöhter Gesamtschaden um 50 %"
  },
  State_2937_Desc = {
    Text = "Nach jeder 3. Erhalt von Schild erhältst du gleichzeitig die gleiche Menge an Rückschlägen"
  },
  State_2938_Desc = {
    Text = "Zu Beginn der Runde ziehe 1 Karte, am Ende der Runde kannst du 1 Handkarte behalten"
  },
  State_2939_Name = {
    Text = "Immunität gegen Verletzlichkeit"
  },
  State_2940_Desc = {
    Text = "Die Regenerationswirkung erhöht"
  },
  State_2940_Name = {
    Text = "Stärker werden durch das abnorme Blut"
  },
  State_2941_Desc = {
    Text = "Nach dem Ausspielen allen Feinden [StateArg1] Schichten Gift hinzufügen und [StateArg2]% Gift auslösen."
  },
  State_2941_Name = {
    Text = "<Rune_10:Gift>"
  },
  State_2942_Desc = {
    Text = "Beim Ende der Runde stelle anderen Verbündeten [Layer]% Leben wieder her und entferne anhaltenden Schaden"
  },
  State_2942_Name = {
    Text = "Kampfrettung"
  },
  State_2946_Desc = {
    Text = "Wahnsinnige Kombos bieten extrem hohe Schilde"
  },
  State_2946_Name = {
    Text = "“Unbewegliche Festung“"
  },
  State_2946_WeaponDesc = {
    Text = "Wahnsinnige Kombos bieten extrem hohe Schilde"
  },
  State_2947_Name = {Text = "Lösung2"},
  State_2948_Desc = {
    Text = "Ändere die Arithmetica Kosten der Karte vor dem Spielen"
  },
  State_2948_Name = {
    Text = "Ändere die Arithmetica Kosten der Karte vor dem Spielen"
  },
  State_2948_WeaponDesc = {
    Text = "Ändere die Arithmetica Kosten der Karte vor dem Spielen"
  },
  State_2949_Name = {
    Text = "Eingestellte Prägung im Kampf des Schicksalsrades"
  },
  State_2951_Desc = {
    Text = "Ruhe-Sessel der Schöpfung"
  },
  State_2951_Name = {
    Text = "Gedämpfte Handschuhe"
  },
  State_2952_Desc = {
    Text = "Nach Rundenende +[Layer] Leben. Für je 5 verlorene Leben -1 Schicht"
  },
  State_2952_Name = {
    Text = "Regenerationskraft"
  },
  State_2954_Name = {
    Text = "Status@2-8Monster24@Hilf mir"
  },
  State_2955_Desc = {
    Text = "Alle Feinde verlieren Leben. Permanent, zerstören"
  },
  State_2955_Name = {
    Text = "<CardKeyWord:Nichtigkeitsende>"
  },
  State_2955_WeaponDesc = {
    Text = "Alle Feinde verlieren Leben. Permanent, zerstören"
  },
  State_2956_Desc = {
    Text = "Jeder erlittene Schaden gewährt allen Erwachten [StateArg1] Wahnsinn"
  },
  State_2956_Name = {
    Text = "Fantasiestrahl"
  },
  State_2956_WeaponDesc = {
    Text = "Jeder erlittene Schaden gewährt allen Erwachten [StateArg1] Wahnsinn"
  },
  State_2957_Desc = {
    Text = "Nach dem Tod, beschwöre vor Ort ein [Schmelzendes Dreieck] mit 1/3 der eigenen HP"
  },
  State_2957_Name = {Text = "Auflösung"},
  State_2957_WeaponDesc = {
    Text = "Nach dem Tod, beschwöre vor Ort ein [Schmelzendes Dreieck] mit 1/3 der eigenen HP"
  },
  State_2960_Desc = {
    Text = "In geraden Runden, wenn deine Arithmetica 0 ist, erhältst du 2 Arithmetica"
  },
  State_2960_Name = {
    Text = "Mutiertes altes Puzzle"
  },
  State_2960_WeaponDesc = {
    Text = "In geraden Runden, wenn deine Arithmetica 0 ist, erhältst du 2 Arithmetica"
  },
  State_2961_Desc = {
    Text = "Team Unique: Der vom Ausrüster verursachte <IntoxicationIconKeywords:Gift> erhöht sich um <WeaponEffect_Num:[StateArg1]%. Vor der Freisetzung von Verherrlichung wird allen Feinden Gift in Höhe von <WeaponEffect_Num:[StateArg2]%> des ANG des Ausrüsters zugefügt. Nach der Verwendung des Schlüsselbefehls erhält der Ausrüster <WeaponEffect_Num:[StateArg3]> Punkte Aliemus."
  },
  State_2961_WeaponDesc = {
    Text = "Der vom Ausrüster verursachte <IntoxicationIconKeywords:Gift> erhöht sich um <WeaponEffect_Num:[StateArg1]%>. Vor der Freisetzung von Verherrlichung wird allen Feinden <WeaponEffect_Num:[Poison:DescArg1]> Schichten Gift zugefügt. Nach der Verwendung des Schlüsselbefehls erhält der Ausrüster <WeaponEffect_Num:[StateArg3]> Punkte Aliemus."
  },
  State_2962_Desc = {
    Text = "Nach dem Ausspielen werden alle Feinde für [StateArg1] Runden geschwächt"
  },
  State_2962_Name = {
    Text = "<Rune_2:Schwäche>"
  },
  State_2965_Name = {
    Text = "Zustand @ konvexer Monddiener erleuchten 7"
  },
  State_2967_Desc = {
    Text = "Beim Einsetzen von Symptomkarten wechselt Pandias Zustand zwischen „Ruhelos“ und „Lust“. Ruhelos: Anzahl der Aktiven SCH-Instanzen +1, verringerte STR. Lust: Anzahl der Aktiven SCH-Instanzen –1, erhöhte STR."
  },
  State_2967_Name = {
    Text = "Pandia erwacht!"
  },
  State_2967_WeaponDesc = {
    Text = "Nach Beginn der nächsten Runde, erhalte Schild in Höhe des verlorenen Lebens der letzten Runde"
  },
  State_2968_Name = {
    Text = "Status@Stufe2_14Kampf8Blase4"
  },
  State_2969_Name = {
    Text = "Status@Stufe2_14Kampf8Blase5"
  },
  State_2970_Desc = {
    Text = "Urbachkinder"
  },
  State_2970_Name = {
    Text = "Urbachkinder"
  },
  State_2970_WeaponDesc = {
    Text = "Urbachkinder"
  },
  State_2971_Desc = {
    Text = "Status@PrologHalbesLebenVerlieren"
  },
  State_2971_Name = {
    Text = "Status@PrologHalbesLebenVerlieren"
  },
  State_2971_WeaponDesc = {
    Text = "Status@PrologHalbesLebenVerlieren"
  },
  State_2972_Name = {
    Text = "Status@Stufe2_14Kampf8Blase2"
  },
  State_2973_Name = {
    Text = "Status@Stufe2_14Kampf8Blase3"
  },
  State_2975_Desc = {
    Text = "Pro Kampf die ersten 5 Sprungeffekte 1 Mal zusätzlich auslösen"
  },
  State_2976_Desc = {
    Text = "Am Ende der Runde, wenn dein Schild 0 oder ein Vielfaches von 10 ist, erhalte [Arg1] Schild. Wenn dein Leben ein Vielfaches von 10 ist, erhalte [Arg2] Kraft"
  },
  State_2976_Name = {Text = "SOS-Signal"},
  State_2977_Desc = {
    Text = "In ungeraden Runden, wenn keine Karten vorhanden sind, ziehe 2 Karten"
  },
  State_2977_Name = {
    Text = "Mutiertes altes Puzzle"
  },
  State_2977_WeaponDesc = {
    Text = "In ungeraden Runden, wenn keine Karten vorhanden sind, ziehe 2 Karten"
  },
  State_2978_Desc = {
    Text = "Jeder erlittene Punkt Schaden reduziert eine Schicht. Bei 0 Schichten in den VERTsmodus wechseln"
  },
  State_2978_Name = {
    Text = "Kartenzähler"
  },
  State_2978_WeaponDesc = {
    Text = "Jeder erlittene Punkt Schaden reduziert eine Schicht. Bei 0 Schichten in den VERTsmodus wechseln"
  },
  State_2979_Desc = {
    Text = "Team Unique: Die Vergiftung und der Schild, die vom Ausrüster verursacht werden, erhöhen sich um <WeaponEffect_Num:[StateArg3]%. Die kritische Rate und der kritische Schaden des “Schlags“ des Ausrüsters erhöhen sich um <WeaponEffect_Num:[StateArg1]%, und man erhält einen Schild in Höhe von <WeaponEffect_Num:[StateArg2]%> der maximalen Lebenspunkte. Der Schild-Effekt kann pro Runde höchstens 1 Mal in Kraft treten."
  },
  State_2979_Name = {
    Text = "Gnade durch Schmerz"
  },
  State_2979_WeaponDesc = {
    Text = "Der Ausrüster verursacht eine Erhöhung von Gift und Schild um <WeaponEffect_Num:[StateArg3]%. Die kritische Trefferquote und der kritische Schaden des Ausrüsters bei “Schlag“ erhöhen sich um <WeaponEffect_Num:[StateArg1]%> und erhält einen Schild in Höhe von [StateArg2]% der maximalen Lebenspunkte ([DescArg1]), wobei der Schild-Effekt pro Runde maximal 1 Mal aktiv ist."
  },
  State_2983_Desc = {
    Text = "Wenn die Karte in der Abwurfphase noch auf der Hand ist, wird sie verbraucht und erscheint in diesem Kampf nicht mehr"
  },
  State_2983_Name = {
    Text = "<NothingnessIconKeywords:Nichts>"
  },
  State_2983_WeaponDesc = {
    Text = "Wenn in der Ablagephase noch auf der Hand, wird nicht in den Ablagestapel gelegt, sondern kann im laufenden Kampf nicht erneut verwendet werden"
  },
  State_2985_Desc = {
    Text = "Bis zum Ende der Runde heilt jeder verursachte Schaden [Layer] Lebenspunkte"
  },
  State_2985_Name = {Text = "Rohdiamant"},
  State_2985_WeaponDesc = {
    Text = "Bis zum Ende der Runde heilt jeder verursachte Schaden [Layer] Lebenspunkte"
  },
  State_2987_Desc = {
    Text = "Ereignis 19_1"
  },
  State_2987_Name = {
    Text = "Ereignis 19_1"
  },
  State_2987_WeaponDesc = {
    Text = "Ereignis 19_1"
  },
  State_2988_Desc = {
    Text = "Wenn Sie das Embryo verschlingen, geht es vom Ablagestapel zurück in den Handkartenstapel, die Arithmetica wird 0"
  },
  State_2988_Name = {
    Text = "Bösartiger Nachwuchs"
  },
  State_2988_WeaponDesc = {
    Text = "Wenn Sie das Embryo verschlingen, geht es vom Ablagestapel zurück in den Handkartenstapel, die Arithmetica wird 0"
  },
  State_2989_Desc = {
    Text = "Nach dem Ausspielen einer Erwachenskarte, mische eine temporäre Kopie dieser Karte mit reduzierten Kosten um 1 in dein Deck"
  },
  State_2990_Desc = {
    Text = "Nach dem Ausspielen verlieren alle Feinde [StateArg1] temporäre Kraft"
  },
  State_2990_Name = {
    Text = "<Rune_18_High:Hocherschöpfung>"
  },
  State_2992_Desc = {
    Text = "Nach dem Ziehen von „Leere“ wird der Wahnsinnszuwachs aller Erwachten in dieser Runde um 50% reduziert"
  },
  State_2992_Name = {Text = "Leere"},
  State_2992_WeaponDesc = {
    Text = "Nach dem Ziehen von „Leere“ wird der Wahnsinnszuwachs aller Erwachten in dieser Runde um 50% reduziert"
  },
  State_2993_Name = {
    Text = "Schöpfung Schlangenhaut Zähler"
  },
  State_2994_Desc = {
    Text = "Tentakelschaden erhöht bei Überladung um [StateArg1]"
  },
  State_2994_Name = {
    Text = "Kraft des Segens"
  },
  State_2994_WeaponDesc = {
    Text = "Tentakelschaden erhöht bei Überladung um [StateArg1]"
  },
  State_2996_Desc = {
    Text = "Nach dem Ausspielen greift ein Tentakel [StateArg1] Mal an"
  },
  State_2996_Name = {
    Text = "<Rune_11:Herrschaft>"
  },
  State_2997_Desc = {
    Text = "Pro Runde nach dem 3. Schaden [Arg1] Punkte Schild erhalten. Nach dem 6. Schaden [Arg2] Punkte Kraft erhalten"
  },
  State_2997_Name = {
    Text = "Sicheres Geleit"
  },
  State_3001_Desc = {
    Text = "Beim ANG erhöht sich der Wahnsinn um 2 Punkte"
  },
  State_3002_Desc = {
    Text = "Der durch den Ausrüster verursachte Schaden, Schild und die Heilung erhöhen sich um [StateArg1]% (temporär)"
  },
  State_3002_Name = {
    Text = "Status@Prototyp Laserkanone Glück"
  },
  State_3003_Desc = {
    Text = "Nach dem Ausspielen wird nicht in den Ablagestapel gelegt, sondern aus dem Deck entfernt"
  },
  State_3003_Name = {
    Text = "<DepleteIconKeywords:Verbrauch>"
  },
  State_3003_WeaponDesc = {
    Text = "Nach dem Ausspielen wird die Karte nicht in den Ablagestapel gelegt und kann in diesem Kampf nicht erneut verwendet werden"
  },
  State_3004_Desc = {
    Text = "[Layer] Immun gegen Vergiftung in dieser Runde"
  },
  State_3004_Name = {
    Text = "Immunität gegen Vergiftung"
  },
  State_3008_Desc = {
    Text = "Zu Beginn jeder Runde wird 1 Schicht Verzögerung auf die verbleibenden Karten des Ziegels hinzugefügt. Für Karten mit einem Rechenleistungsausstoß von mehr als 5 werden sie in Stein verwandelt"
  },
  State_3008_Name = {
    Text = "Aijis erwacht!"
  },
  State_3008_WeaponDesc = {
    Text = "Nach Beginn der nächsten Runde, erhalte Schild in Höhe des verlorenen Lebens der letzten Runde"
  },
  State_3011_Desc = {
    Text = "Team Unique: Die kritische Trefferquote und der kritische Schaden von Aelius' “Verherrlichung“ erhöhen sich um <WeaponEffect_Num:[StateArg2]%. Nach der Freisetzung von “Verherrlichung“ erhält der Ausrüster eine <PowerIconKeywords:Stärke> von <WeaponEffect_Num:[StateArg1]%> seiner KON. Wenn diese Verherrlichung den Effekt <CardKeyWord:Verschlingen> aktiviert, erhält er zusätzlich 1 Punkt <PowerIconKeywords:Stärke>."
  },
  State_3011_WeaponDesc = {
    Text = "Die kritische Trefferquote und der kritische Schaden von Aelius' “Verherrlichung“ erhöhen sich um <WeaponEffect_Num:[StateArg2]%. Nach der Freisetzung von “Verherrlichung“ erhält der Ausrüster <WeaponEffect_Num:[Power:DescArg1]> Punkte Stärke. Wenn diese Verherrlichung den Effekt <CardKeyWord:Verschlingen> aktiviert, erhält er zusätzlich 1 Punkt <PowerIconKeywords:Stärke>."
  },
  State_3012_Desc = {
    Text = "Unbrauchbarer Leerlaufzustand"
  },
  State_3012_Name = {
    Text = "Unbrauchbarer Leerlaufzustand"
  },
  State_3012_WeaponDesc = {
    Text = "Unbrauchbarer Leerlaufzustand"
  },
  State_3013_Desc = {
    Text = "Wenn der blutdürstige Patient die Embryo-Fusion verbessert, erhält er [StateArg1] Punkte Macht"
  },
  State_3013_Name = {Text = "Blutsauger"},
  State_3014_Desc = {
    Text = "Wenn der Gegner 4 oder mehr Karten auf der Hand hat, erhältst du beim Erleiden von Schaden [StateArg1] Schildpunkte"
  },
  State_3014_Name = {Text = "Schlange"},
  State_3015_Desc = {
    Text = "Status@Wachsrüstung Team"
  },
  State_3015_Name = {
    Text = "Status@Wachsrüstung Team"
  },
  State_3015_WeaponDesc = {
    Text = "Status@Wachsrüstung Team"
  },
  State_3016_Desc = {
    Text = "Beschworene Monster haben doppelte Lebenspunkte"
  },
  State_3016_Name = {
    Text = "“Überfluss der Reue“"
  },
  State_3016_WeaponDesc = {
    Text = "Beschworene Monster haben doppelte Lebenspunkte"
  },
  State_3017_Name = {
    Text = "Status@Fluch Delirium"
  },
  State_3018_Desc = {
    Text = "“Dimensionsschiffender Hund“ verliert bei jedem Verlust von 1 Lebenspunkt 1 Schicht. Bei 0 Schichten erhält er [StateArg1] Schild und erlangt [StateArg2] Schichten Dimensionsbarriere zurück."
  },
  State_3018_Name = {
    Text = "Dimensionsbarriere"
  },
  State_3019_Desc = {
    Text = "Für 10 schwarze Siegel kehre 1% Leben zurück"
  },
  State_3019_Name = {
    Text = "Umkehrwurzel-Zustand der Schöpfung"
  },
  State_3019_WeaponDesc = {
    Text = "Für 10 schwarze Siegel kehre 1% Leben zurück"
  },
  State_3020_Desc = {
    Text = "Wenn du in der letzten Runde Schaden erlitten hast, erhältst du zu Beginn der Runde 1 Runde Immunität"
  },
  State_3020_Name = {Text = "Anpassung"},
  State_3020_WeaponDesc = {
    Text = "Wenn du in der letzten Runde Schaden erlitten hast, erhältst du zu Beginn der Runde 1 Runde Immunität"
  },
  State_3021_Desc = {
    Text = "Zu Rundenbeginn erhalten Sie 1 Arithmetica"
  },
  State_3021_Name = {
    Text = "Zustand @ maximale Arithmetica -2"
  },
  State_3023_Desc = {
    Text = "Jedes Mal, wenn in dieser Runde Aktiver Schaden erlitten wird, wird der SCH-Quelle [Layer] <FixedDamage:Reiner SCH> zugefügt."
  },
  State_3023_Name = {
    Text = "Temporäre Theke"
  },
  State_3023_WeaponDesc = {
    Text = "Jedes Mal, wenn Aktiver Schaden erlitten wird, wird dem Angreifer [Layer] <FixedDamage:Reiner SCH> zugefügt."
  },
  State_3024_Desc = {
    Text = "Der durch den Ausrüster verursachte Schaden, Schild und die Heilung erhöhen sich um [StateArg1]% (temporär)"
  },
  State_3024_Name = {
    Text = "Status@Prototyp Messer Todeswiderstand"
  },
  State_3025_Desc = {
    Text = "Jedes Mal, wenn 1 Karte gespielt wird, erhöht sich die kritische Rate in dieser Runde um 10%"
  },
  State_3026_Desc = {
    Text = "Nach Beginn des Kampfes mischen Sie [StateArg1] temporäre Kopien in den Ziehstapel. Sowohl die ursprüngliche Karte als auch die Spiegelkarte erhalten behalten"
  },
  State_3026_Name = {
    Text = "<Rune_8_High:Hochspiegelbild>"
  },
  State_3026_WeaponDesc = {
    Text = "Nach Beginn des Kampfes mischen Sie [StateArg1] temporäre Kopien in den Ziehstapel"
  },
  State_3027_Desc = {
    Text = "Nach Kampfende zusätzliche 50 schwarze Siegel und 1 Symptomkarte erhalten"
  },
  State_3028_Name = {
    Text = "Zustand @ nach Rundenbeginn Arithmetica +2"
  },
  State_3029_Desc = {
    Text = "Jeder erlittene Punkt Schaden reduziert eine Schicht. Bei 0 Schichten in den VERTsmodus wechseln"
  },
  State_3029_Name = {
    Text = "Kartenzähler"
  },
  State_3029_WeaponDesc = {
    Text = "Jeder erlittene Punkt Schaden reduziert eine Schicht. Bei 0 Schichten in den VERTsmodus wechseln"
  },
  State_3033_Desc = {
    Text = "Jedes Mal, wenn 10 Karten gespielt werden, erhalte eine Schicht Barriere, die jeden Schaden abwehrt. Wenn du bereits eine Barriere hast, heile stattdessen [Arg1] Leben"
  },
  State_3034_Desc = {
    Text = "Einzigartig im Team: Für jede gespielte Karte des Ausrüsters erhältst du <WeaponEffect_Num:[StateArg1]> Silberschlüssel-Energie. Dieser Effekt kann pro Runde maximal 3 Mal eintreten"
  },
  State_3034_WeaponDesc = {
    Text = "Jedes Mal, wenn 1 Karte des Ausrüsters gespielt wird, erhältst du <WeaponEffect_Num:[StateArg1]> s-Energie. Dieser Effekt gilt maximal 3 Mal pro Runde"
  },
  State_3035_Desc = {
    Text = "Nach dem Ausspielen greift ein Tentakel [StateArg1] Mal an"
  },
  State_3035_Name = {
    Text = "<Rune_11_High:Hochherrschaft>"
  },
  State_3035_WeaponDesc = {
    Text = "Nach dem Ausspielen greift ein Tentakel alle Feinde [StateArg1] Mal an"
  },
  State_30364_Desc = {
    Text = "Diese Karte erhöht das Handkartenlimit um +1, wenn sie in der Hand ist"
  },
  State_30364_Name = {
    Text = "Ignorieren Sie das Handkartenlimit"
  },
  State_30369_Desc = {
    Text = "In dieser Runde Handkartenlimit +[Layer]"
  },
  State_30369_Name = {
    Text = "Maximale Handgröße"
  },
  State_3036_Desc = {
    Text = "Schwäche- und Verwundbarkeitseffekte von 33 % auf 50 % erhöht"
  },
  State_3036_Name = {
    Text = "“Nachhall der Stille“"
  },
  State_3036_WeaponDesc = {
    Text = "Schwäche- und Verwundbarkeitseffekte von 33 % auf 50 % erhöht"
  },
  State_3038_Desc = {
    Text = "Einzigartig für das Team: Nach dem Schlüsselbefehl erhält der Träger <WeaponEffect_Num:[StateArg1]> Wahnsinn"
  },
  State_3038_WeaponDesc = {
    Text = "Nach Schlüsselbefehl erhält der Träger <WeaponEffect_Num:[StateArg1]> Wahnsinn"
  },
  State_3040_Desc = {
    Text = "Zu Beginn jeder Runde [Layer] Schichten „Fessel“ auf das eigene Team anwenden"
  },
  State_3040_Name = {Text = "Fesselung"},
  State_3040_WeaponDesc = {
    Text = "Zu Beginn jeder Runde [Layer] Schichten „Fessel“ auf das eigene Team anwenden"
  },
  State_3041_Desc = {
    Text = "Dauerhaft im Deck behalten"
  },
  State_3041_Name = {
    Text = "<CardKeyWord:Symptom-Karte>"
  },
  State_3042_Desc = {
    Text = "Jedes Mal, wenn man Schaden verursacht, erhält man in dieser Runde [Arg1] Stärke, bis zu 3 Mal stapelbar. Bei voller Stapelung wird der Effekt verdoppelt"
  },
  State_3043_Desc = {
    Text = "In geraden Runden 50% weniger Schaden, 33% mehr Schaden"
  },
  State_3043_Name = {
    Text = "veränderlich"
  },
  State_3043_WeaponDesc = {
    Text = "In geraden Runden 50% weniger Schaden, 33% mehr Schaden"
  },
  State_3045_Desc = {
    Text = "Nachdem Aelius freigesetzt wurde, erhält der entsprechende Erwecker 20 Aelius"
  },
  State_3045_Name = {
    Text = "Schleier der namenlosen Gottheit"
  },
  State_3046_Desc = {
    Text = "Team Unique: Bei jedem Feindtod erhält man [StateArg1] schwarze Siegel. Wenn der Ausrüster einen Feind tötet, erhöht sich der kritische Schaden des Ausrüsters in diesem Level dauerhaft um <WeaponEffect_Num:[StateArg2]%>, maximal 5 Stapel. Jedes Mal, wenn der Ausrüster den Sprung-Effekt auslöst, erhöht sich der Gesamtschaden des Ausrüsters in dieser Runde um <WeaponEffect_Num:[StateArg3]%>, maximal 3 Stapel."
  },
  State_3046_WeaponDesc = {
    Text = "Bei jedem Feindtod erhältst du [StateArg1] schwarze Siegel. Wenn der Ausrüster einen Feind tötet, erhöht sich der kritische Schaden des Ausrüsters in diesem Kapitel dauerhaft um <WeaponEffect_Num:[StateArg2]%>, maximal 5 Stapel. Jedes Mal, wenn der Ausrüster einen Sprungeffekt auslöst, erhöht sich der Gesamtschaden, den der Ausrüster in dieser Runde verursacht, um <WeaponEffect_Num:[StateArg3]%>, maximal 3 Stapel."
  },
  State_3047_Desc = {
    Text = "Zu Beginn der Runde erhalte [Arg1] Schild, und erhöhe diesen Schildwert jede Runde um [Arg2]"
  },
  State_3047_Name = {
    Text = "Wächterhand"
  },
  State_3048_Desc = {
    Text = "Lotans Kampfwille kennt keine Pausen. Am Ende jeder Runde hebt Lotan 3 Schichten Schwäche und Verwundbarkeit auf"
  },
  State_3048_Name = {
    Text = "Lorath erwacht"
  },
  State_3049_Desc = {
    Text = "Erhöht die Schadensanzahl von Georges nächstem ANG um 1"
  },
  State_3049_Name = {Text = "Groll"},
  State_3049_WeaponDesc = {
    Text = "Erhöht die Schadensanzahl von Georges nächstem ANG um 1"
  },
  State_3050_Desc = {
    Text = "Zu Beginn des Kampfes wird 1 \"Anfälle\"-Karte in den Deckablage gewaschen"
  },
  State_3050_Name = {Text = "Schrecken"},
  State_3050_WeaponDesc = {
    Text = "Zu Beginn des Kampfes wird 1 \"Anfälle\"-Karte in den Deckablage gewaschen"
  },
  State_3051_Desc = {
    Text = "Beim Verursachen von unblockiertem Schaden, mische eine Schreikarte in den Ziehstapel"
  },
  State_3051_Name = {
    Text = "Wachsheiße Lust"
  },
  State_3051_WeaponDesc = {
    Text = "Beim Verursachen von echtem Schaden, mische eine Schreikarte in den Ziehstapel"
  },
  State_3054_Name = {
    Text = "Status@Fluch Schock"
  },
  State_3055_Desc = {
    Text = "Zu Beginn des Kampfes erleidet das Team 1 Schicht Verwundbarkeit"
  },
  State_3055_Name = {Text = "Durchgang"},
  State_3055_WeaponDesc = {
    Text = "Zu Beginn des Kampfes erleidet das Team 1 Schicht Verwundbarkeit"
  },
  State_3056_Desc = {
    Text = "Am Ende der Runde, entferne 1 Schicht Schwäche und Verwundbarkeit"
  },
  State_3056_Name = {Text = "Druck"},
  State_3058_Desc = {
    Text = "Für jedes Tentakel, erhalte am Rundenende [Arg1] Schild"
  },
  State_3058_Name = {
    Text = "Namenloser Fortsatz"
  },
  State_3060_Desc = {
    Text = "Nach Beginn der nächsten Runde, erhältst du [Layer] Schildpunkte"
  },
  State_3060_Name = {
    Text = "Wiederhergestelle Psyche"
  },
  State_3060_WeaponDesc = {
    Text = "Nach Beginn der nächsten Runde, ziehe [Layer] Karten"
  },
  State_3063_Desc = {
    Text = "Jedes Mal, wenn man tatsächlichen Schaden verursacht, fügt man [Layer] Gift hinzu"
  },
  State_3063_Name = {Text = "Toxin"},
  State_3064_Desc = {
    Text = "Vor dem Ausspielen der Karte erleide Schaden in Höhe der Schichten. Am Ende des Zuges entfernen"
  },
  State_3064_Name = {Text = "Fesselung"},
  State_3064_WeaponDesc = {
    Text = "Vor dem Ausspielen der Karte erleide Schaden in Höhe der Schichten. Am Ende des Zuges entfernen"
  },
  State_3065_Name = {
    Text = "Status@Schöpfung Vergangene Opfergabe 2"
  },
  State_3068_Desc = {
    Text = "Am Rundenende werden [Layer] <FixedDamage:Reiner SCH> erlitten."
  },
  State_3068_Name = {
    Text = "<IntoxicationColour:Vergiftung>"
  },
  State_3068_WeaponDesc = {
    Text = "Am Rundenende werden [Layer] <FixedDamage:Reiner SCH> erlitten."
  },
  State_3069_Name = {
    Text = "Schmuck Mechanische Gottheit"
  },
  State_3069_WeaponDesc = {
    Text = "Im ersten Zug jedes Kampfes erhält man 1 Punkt zusätzliche Arithmetica"
  },
  State_3070_Desc = {
    Text = "Einzigartig im Team: Der „Schlag“ des Ausrüsters verringert die temporäre <PowerIconKeywords:Kraft> des Zielgegners um <WeaponEffect_Num:[StateArg1]%> seines ANGs. Dieser Effekt kann dreimal pro Runde ausgelöst werden"
  },
  State_3070_WeaponDesc = {
    Text = "Die „Schläge“ des Ausrüstenden senken vorübergehend die <WeaponEffect_Num:[Power:DescArg1]> Punkte <PowerIconKeywords:Kraft> des Zielgegners. Dieser Effekt kann pro Runde bis zu 3 Mal ausgelöst werden"
  },
  State_3071_Desc = {
    Text = "Einzigartig im Team: Nach dem Ausspielen der „VERT“ des Ausrüsters, erhalte temporäre <PowerIconKeywords: Kraft> entsprechend <WeaponEffect_Num:[StateArg1]%> der ANGskraft des Ausrüsters"
  },
  State_3071_WeaponDesc = {
    Text = "Nach dem Ausspielen der „VERT“ des Ausrüsters erhält man <WeaponEffect_Num:[Power:DescArg1]> temporäre <PowerIconKeywords:Kraft>"
  },
  State_3072_Desc = {
    Text = "Einzigartig für das Team: Der Ausrüster erhält nach dem Töten eines Feindes <WeaponEffect_Num:[StateArg1]> Wahnsinn und 1% kritischen Schaden, wirksam während der gesamten Erkundung"
  },
  State_3072_WeaponDesc = {
    Text = "Nach dem Töten eines Feindes erhält der Ausrüstende <WeaponEffect_Num:[StateArg1]> Wahnsinn, erhält 1% kritischen Schaden, gültig für die gesamte Erkundung"
  },
  State_3073_Desc = {
    Text = "Team-Unique: Nach der Freisetzung des Exaltieren erhöht sich die kritische Rate aller Verbündeten in dieser Runde um <WeaponEffect_Num:[StateArg1]>"
  },
  State_3073_WeaponDesc = {
    Text = "Nach dem Einsatz von Wut-Exaltation erhöht sich die kritische Rate aller Verbündeten in dieser Runde um <WeaponEffect_Num:[StateArg1]%>"
  },
  State_3074_Desc = {
    Text = "Einzigartig in der Gruppe: Nach dem Ausspielen einer Symptomkarte erhält der Ausrüstende <WeaponEffect_Num:[StateArg1]> Punkte Aelius. Dieser Effekt kann maximal 2 Mal pro Runde aktiviert werden. Nach dem Ausspielen einer Befehlskarte erhält der Ausrüstende 1 Punkt Aelius"
  },
  State_3074_WeaponDesc = {
    Text = "Nachdem du eine Symptomkarte gespielt hast, erhält der Ausrüster <WeaponEffect_Num:[StateArg1]> Punkte Aelius. dieser Effekt kann bis zu 2 Mal pro Runde ausgelöst werden. Wenn der Ausrüster eine Befehlskarte spielt, erhält er 1 Punkt Aelius"
  },
  State_3075_Desc = {
    Text = "Team-Unique: Nach der Freisetzung des Exaltieren erhält der Träger einen Schild in Höhe von <WeaponEffect_Num:[StateArg1]%> seiner VERT"
  },
  State_3075_Name = {
    Text = "Herzbarriere"
  },
  State_3075_WeaponDesc = {
    Text = "Nach dem Einsatz von Wut-Exaltation erhält der Ausrüster <WeaponEffect_Num:[Block:DescArg1]> Punkte Schild"
  },
  State_3076_Desc = {
    Text = "Team Unique: Nachdem der Ausrüster Aktiven Schaden verursacht, erhöht sich seine Krit. Rate um + <WeaponEffect_Num:[StateArg1]%>. Nach einem kritischen Treffer wird die durch diesen Effekt gewonnene Krit. Rate zurückgesetzt."
  },
  State_3076_WeaponDesc = {
    Text = "Nachdem der Ausrüster Aktiven Schaden verursacht, erhöht sich seine Krit. Rate um + <WeaponEffect_Num:[StateArg1]%>. Nach einem kritischen Treffer wird die durch diesen Effekt gewonnene Krit. Rate zurückgesetzt."
  },
  State_3078_Desc = {
    Text = "In dieser Runde verursachter Schaden garantiert kritisch"
  },
  State_3078_Name = {
    Text = "Temporäre Kritischer Treffer"
  },
  State_3078_WeaponDesc = {
    Text = "Innerhalb dieser Runde wird die kritische Rate um 100 % erhöht"
  },
  State_3082_Desc = {
    Text = "Nach der Freisetzung von Exaltieren wird eine zufällige Karte, die dem entsprechenden Erwecker zugeordnet ist, in die Hand gelegt. Diese Karte erhält erschöpfen und Nichtsigkeit"
  },
  State_3082_Name = {Text = "Arztkoffer"},
  State_3084_Desc = {
    Text = "Nach dem Ausspielen werden [StateArg1] Kopien der Karte in den temporären <DimensionalSpaceIconKeywords:Dimensionsraum> gelegt"
  },
  State_3084_Name = {
    Text = "<Rune_13_High:Fortgeschrittene Teleportation>"
  },
  State_3084_WeaponDesc = {
    Text = "Nach dem Ausspielen wird sie verbraucht, aber [StateArg1] temporäre ursprüngliche Kopien werden in den Dimensionsraum gelegt"
  },
  State_3087_Desc = {
    Text = "Schadensbonus für ANGskarten um [Layer] %"
  },
  State_3087_Name = {
    Text = "Schadensbonus für ANGskarten"
  },
  State_3087_WeaponDesc = {
    Text = "Schadensbonus für ANGskarten um [Layer] %"
  },
  State_3088_Desc = {
    Text = "Aktiver Schaden erhöht sich um [Layer]. Bei jedem Schaden vergrößert sich die Erosionswunde, zu Beginn der Runde wiederhergestellt"
  },
  State_3088_Name = {
    Text = "Tiefenfusion"
  },
  State_3088_WeaponDesc = {
    Text = "Aktiver Schaden erhöht sich um [Layer]. Bei jedem Schaden vergrößert sich die Erosionswunde, zu Beginn der Runde wiederhergestellt"
  },
  State_3092_Name = {
    Text = "Wenn es ein Bosskampf ist, erhalten alle Erwecker 30 Aelius und befreien sich von dem versiegelten Zustand"
  },
  State_3093_Name = {
    Text = "Status@ZaubererImitationZählen"
  },
  State_3094_Desc = {
    Text = "Beim Ziehen wird man 1 Runde lang verwundbar. Nach Gebrauch werden alle Feinde 1 Runde lang verwundbar. Nicht verkäuflich"
  },
  State_3094_Name = {
    Text = "Status Fluch Zusammenbruch"
  },
  State_3094_WeaponDesc = {
    Text = "Beim Ziehen wird man 1 Runde lang verwundbar. Nach Gebrauch werden alle Feinde 1 Runde lang verwundbar. Nicht verkäuflich"
  },
  State_3095_Desc = {
    Text = "Schaden in diesem Level um [Layer] Punkte erhöht"
  },
  State_3095_Name = {
    Text = "Permanente STR"
  },
  State_3095_WeaponDesc = {
    Text = "Schaden in diesem Level um [Layer] Punkte erhöht"
  },
  State_3096_Desc = {
    Text = "Es gibt noch einen langen Weg, Lotan zu überzeugen"
  },
  State_3096_Name = {
    Text = "Lorath erwacht"
  },
  State_3098_Desc = {
    Text = "Beim Aufnehmen wähle 1 Karte, deren Rechenleistung dauerhaft auf 1 gesetzt wird"
  },
  State_3099_Desc = {
    Text = "Nach der Freisetzung von Exaltieren erhältst du in dieser Runde [Arg1] Macht"
  },
  State_3100_Desc = {
    Text = "Zu Beginn jeder Runde erhöht sich der Widerstand gegen den Tod um 10%. Wenn der Widerstand gegen den Tod über 100% liegt, erhält man zusätzlich 30 Punkte Reichsprofi"
  },
  State_3104_Desc = {
    Text = "In dieser Runde, bei jedem erlittenen aktiven Schaden, +1 „Süßer Dämon“-Schaden"
  },
  State_3104_Name = {
    Text = "Schmerzteilung"
  },
  State_3104_WeaponDesc = {
    Text = "In dieser Runde, bei jedem erlittenen aktiven Schaden, +1 „Süßer Dämon“-Schaden"
  },
  State_3106_Desc = {
    Text = "Wenn das Leben unter 50% ([StateArg1]) fällt, teilt es sich in 2 gleichwertige „Experimentelle Werke“"
  },
  State_3106_Name = {Text = "Spalten"},
  State_3106_WeaponDesc = {
    Text = "Wenn das Leben unter 50% ([StateArg1]) fällt, wird es sich in drei Wesen mit gleichmäßigem Leben „II-Typ Aufgelöster Körper Wachsskulptur“ teilen"
  },
  State_3108_Name = {
    Text = "Schmuckstück Ringgedicht"
  },
  State_3108_WeaponDesc = {
    Text = "Nach Beginn einer geraden Runde erhältst du 1 Arithmetica"
  },
  State_3109_Name = {
    Text = "Zustand @ Kapitel 4 Resonanz @ Arithmetica -1"
  },
  State_3109_WeaponDesc = {
    Text = "“Naive Rückgabe” Verbrauch der Rechenleistung reduziert um 1"
  },
  State_3110_Name = {
    Text = "Zustand @ Kapitel 4 Resonanz @ Arithmetica -1"
  },
  State_3110_WeaponDesc = {
    Text = "“Naive Rückgabe” Verbrauch der Rechenleistung reduziert um 1"
  },
  State_3111_Desc = {
    Text = "Nach Beginn der nächsten Runde, verwandle verbleibendes Schild in das Doppelte an Leben"
  },
  State_3111_Name = {
    Text = "Ewige Blume"
  },
  State_3112_Desc = {
    Text = "Team Unique: Der durch den Ausrüster verursachte Gift erhöht sich um <WeaponEffect_Num:[StateArg3]%. Nach der Freisetzung von Verherrlichung regeneriert der Ausrüster Lebenspunkte in Höhe von <WeaponEffect_Num:[StateArg1]%> seines KON. Für jeden verbleibenden Punkt Arithmetica regeneriert der Ausrüster zusätzlich <WeaponEffect_Num:[StateArg2]%> seines KON an Lebenspunkten."
  },
  State_3112_Name = {
    Text = "Stilles Festmahl"
  },
  State_3112_WeaponDesc = {
    Text = "Die Giftwirkung des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg3]%>. Nachdem der Ausrüster die Verherrlichung freigibt, regeneriert er <WeaponEffect_Num:[Heal:DescArg1]> LP und für jeden verbleibenden Punkt Arithmetica erhält er zusätzlich <WeaponEffect_Num:[Heal:DescArg2]> LP."
  },
  State_3113_Desc = {
    Text = "Status@PrologWahnsinn0_1_4"
  },
  State_3113_Name = {
    Text = "Status@PrologWahnsinn0_1_4"
  },
  State_3113_WeaponDesc = {
    Text = "Status@PrologWahnsinn0_1_4"
  },
  State_3114_Desc = {
    Text = "Status@PrologWahnsinn0_1_2"
  },
  State_3114_Name = {
    Text = "Status@PrologWahnsinn0_1_2"
  },
  State_3114_WeaponDesc = {
    Text = "Status@PrologWahnsinn0_1_2"
  },
  State_3115_Desc = {
    Text = "Status@PrologWahnsinn0_1_2"
  },
  State_3115_Name = {
    Text = "Status@PrologWahnsinn0_1_2"
  },
  State_3115_WeaponDesc = {
    Text = "Status@PrologWahnsinn0_1_2"
  },
  State_3116_Name = {
    Text = "Status@PrologWahnsinn0_1_1"
  },
  State_3117_Desc = {
    Text = "Team Unique: Der Grundschaden von “Schlag“ und “Verherrlichung“ des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>. Nachdem der Ausrüstende “Schlag“ gespielt hat, erhält der Ausrüstende 5% temporäre kritische Trefferquote, maximal 3 Mal pro Runde. Nach 3 Mal erhält er 15% temporären kritischen Schaden."
  },
  State_3117_WeaponDesc = {
    Text = "Der Grundschaden von “Schlag“ und “Verherrlichung“ des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>. Nachdem der Ausrüstende “Schlag“ gespielt hat, erhält der Ausrüstende 5% temporäre kritische Trefferquote, maximal 3 Mal pro Runde. Nach 3 Mal erhält er 15% temporären kritischen Schaden."
  },
  State_3118_Desc = {
    Text = "Zu Beginn der Runde [Layer]% der verlorenen HP wiederherstellen."
  },
  State_3118_Name = {
    Text = "Schutz der Leitsegel"
  },
  State_3120_Desc = {
    Text = "[VERT] erhält [Arg1] Schichten Theke"
  },
  State_3121_Desc = {
    Text = "Wenn die Absicht des Feindes nicht ANG ist, fügt nach aktivem oder Tentakelschaden ein Blutung hinzu, die der Hälfte des Schadensträgers entspricht"
  },
  State_3123_Desc = {
    Text = "Team Unique: Der Träger's <RetaliateIconKeywords:counter> wird um <WeaponEffect_Num:[StateArg3]%> erhöht. Für jeden erhaltenen Angriff erhält man temporäre <PowerIconKeywords:STR> in Höhe von <WeaponEffect_Num:[StateArg1]%> des ATK des Trägers. Nachdem der Träger Exalt verwendet, erhält man <RetaliateIconKeywords:counter> in Höhe von <WeaponEffect_Num:[StateArg2]%> des ATK des Trägers."
  },
  State_3123_WeaponDesc = {
    Text = "Der Ausrüster erhöht den Gegenangriff um <WeaponEffect_Num:[StateArg3]%. Bei jedem ANG erhält er <WeaponEffect_Num:[Power:DescArg1]> Punkte vorübergehende <PowerIconKeywords:Stärke>. Nach der Nutzung der Verherrlichung erhält der Ausrüster <WeaponEffect_Num:[Counterattack:DescArg2]> Punkte Gegenangriff."
  },
  State_3124_Desc = {
    Text = "Die schwarzen Siegel, die der glückliche Detektiv erhält, verdoppeln sich"
  },
  State_3124_Name = {
    Text = "Außergewöhnliches Glück"
  },
  State_3124_WeaponDesc = {
    Text = "Die schwarzen Siegel, die der glückliche Detektiv erhält, verdoppeln sich"
  },
  State_3127_Name = {
    Text = "Status@Stufe2_10Kampf3Blase1"
  },
  State_3128_Desc = {
    Text = "Alle Erwachten haben erhöhte Schild- und Heilungseffekte um [StateArg1]%"
  },
  State_3128_Name = {Text = "Wiege"},
  State_3129_Desc = {
    Text = "Bis zum Beginn der nächsten Runde löst jede erlittene Aktive SCH-Instanz [Layer] zusätzliche Gegenangriffe und Tentakel-Gegenangriffe aus, die 50% SCH verursachen."
  },
  State_3129_Name = {
    Text = "Schutzschuppen"
  },
  State_3130_Desc = {
    Text = "In dieser Runde verursachter Schaden +[Layer]"
  },
  State_3130_Name = {
    Text = "Temporäre STR"
  },
  State_3130_WeaponDesc = {
    Text = "In dieser Runde verursachter Schaden +[Layer]"
  },
  State_3135_Desc = {
    Text = "Pro Schicht erhöht sich die Anzahl der aktiven Schadensangriffe um 1."
  },
  State_3135_Name = {
    Text = "<MadnessIconKeywords:Wahnsinn>"
  },
  State_3136_Name = {Text = "Aliemus"},
  State_3137_Desc = {
    Text = "Zu Beginn des Kampfes erhält man 1 Tentakel, Tentakelschaden dauerhaft +[Arg1]"
  },
  State_3138_Name = {
    Text = "Schmuckstück Antinomie"
  },
  State_3138_WeaponDesc = {
    Text = "Nach der Nutzung der Wahnsinnsexplosion erhält das Team des Ausrüstenden 100% basierend auf seiner VERT <RetaliateIconKeywords:Theke>. Seine aktuelle <RetaliateIconKeywords:Theke> erhöht sich um 10%"
  },
  State_3139_Desc = {
    Text = "Nach dem Betreten der überdimensionalen Runde werden eigene Schwäche und Zerbrechlichkeit aufgehoben und alle Feinde für 2 Runden geschwächt und verwundbar gemacht"
  },
  State_3140_Desc = {
    Text = "Zu Beginn des Kampfes wird „Halluzination“ in den Hyperraum gelegt, bis dein Hyperraum 4 Karten erreicht"
  },
  State_3143_Desc = {
    Text = "Beim Verursachen von tatsächlichem Schaden verliert das Team [Layer] temporäre Kraft"
  },
  State_3143_Name = {Text = "Lähmung"},
  State_3144_Name = {
    Text = "Die Anzahl der \"Gift\" und \"Bluten\" Schichten in unserer Gruppe wurde halbiert"
  },
  State_3145_Desc = {
    Text = "In [Layer] Runden keine Karten spielbar"
  },
  State_3145_Name = {
    Text = "Karte kann nicht gespielt werden"
  },
  State_3146_Desc = {
    Text = "Wenn der Apostel des Meeres 1 Karte spielt, erzeugt er [StateArg1] temporäre Tentakel, die das Tentakellimit ignorieren"
  },
  State_3146_Name = {
    Text = "Stellvertretende Fähigkeit"
  },
  State_3146_WeaponDesc = {
    Text = "Wenn der Apostel des Meeres 1 Karte spielt, erzeugt er [StateArg1] temporäre Tentakel, die das Tentakellimit ignorieren"
  },
  State_3149_Desc = {
    Text = "Zu Beginn der nächsten Runde wird der gesamte erlittene Aktive Schaden und Tentakelschaden um +50% erhöht."
  },
  State_3149_Name = {Text = "Verwundbar"},
  State_3149_WeaponDesc = {
    Text = "Erhöhter Gesamtschaden um 50 %"
  },
  State_3150_Desc = {
    Text = "Nach dem Erhalt von 3 Angriffen in einer Runde, erhalte 1 Stapel Temporärer Wahnsinn."
  },
  State_3150_Name = {
    Text = "süße Pein"
  },
  State_3151_Desc = {
    Text = "Nach dem Aufheben erhält man dauerhaft [Arg1] Kraft"
  },
  State_3152_Name = {
    Text = "Status@Schmuck Re-Evolution"
  },
  State_3152_WeaponDesc = {
    Text = "Ausrüster: Am Rundenende 3 Wahnsinn. Bei Wahnsinnsaufladung > 10, zusätzlich 2 Wahnsinn"
  },
  State_3153_Name = {
    Text = "Status@Fluch Delirium Wiederherstellung"
  },
  State_3154_Name = {Text = "Krit. Rate"},
  State_3155_Desc = {
    Text = "Pro Runde 10% des verlorenen Lebens wiederherstellen"
  },
  State_3155_Name = {Text = "Heilung"},
  State_3155_WeaponDesc = {
    Text = "Pro Runde 10% des verlorenen Lebens wiederherstellen"
  },
  State_3156_Desc = {
    Text = "Der erste erlittene Schaden jeder Runde wird verfünffacht"
  },
  State_3156_Name = {Text = "Panik"},
  State_3160_Desc = {
    Text = "Zu Beginn der Runde füge einen „Sonnenschirm“ mit [Arg1] Alarm, den du in dieser Runde erhältst, zu deiner Hand hinzu. Nachdem du 6 Karten gespielt hast, erhöhe alle „Sonnenschirm“ in deiner Hand um [Arg2] Alarm"
  },
  State_3161_Desc = {
    Text = "Die Anzahl der gezogenen Karten des Gegners wird um [Layer] reduziert, aber alle Karten erhalten Behalt"
  },
  State_3161_WeaponDesc = {
    Text = "Die Anzahl der gezogenen Karten unseres Teams reduziert sich um [Layer], alle Karten erhalten Behalten"
  },
  State_3163_Desc = {
    Text = "Nach Auslösen des Todeswiderstands, [Layer] Leben wiederherstellen"
  },
  State_3163_Name = {
    Text = "Wiege der Sterne"
  },
  State_3163_WeaponDesc = {
    Text = "Nach Auslösen des Todeswiderstands, [Layer] Leben wiederherstellen"
  },
  State_3164_Name = {
    Text = "Kette des Grolls"
  },
  State_3165_Name = {
    Text = "Durchstreicher Erleuchten 3"
  },
  State_3166_Name = {
    Text = "Dieser Kampf wurde ausgelöst"
  },
  State_3168_Desc = {
    Text = "Zu Beginn der Runde füge allen Monstern einen ANGszähler hinzu"
  },
  State_3168_Name = {
    Text = "Zustand @ Rache-Riesenblatt Enthauptungsschaden"
  },
  State_3168_WeaponDesc = {
    Text = "Zu Beginn der Runde füge allen Monstern einen ANGszähler hinzu"
  },
  State_3170_Desc = {
    Text = "Fügt Impulskosten hinzu"
  },
  State_3170_Name = {
    Text = "Fügt Impulskosten hinzu"
  },
  State_3170_WeaponDesc = {
    Text = "Fügt Impulskosten hinzu"
  },
  State_3171_Name = {
    Text = "Status@Stufe2_1Kampf3Blase1"
  },
  State_3172_Desc = {
    Text = "Jedes Mal, wenn man Schaden verursacht, erhält man [StateArg1] temporäre Stärke, bis zu [StateArg2] Mal stapelbar. Bei voller Stapelung wird der Effekt verdoppelt"
  },
  State_3172_Name = {
    Text = "Schöpfung Blutiger Kieselstein"
  },
  State_3174_Desc = {
    Text = "Lebenslimit um 30% reduziert"
  },
  State_3174_Name = {
    Text = "Schöpfung Sextant2"
  },
  State_3174_WeaponDesc = {
    Text = "Lebenslimit um 30% reduziert"
  },
  State_3175_Desc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwachten 10 Wahnsinn"
  },
  State_3175_Name = {
    Text = "Schöpfung Sextant1"
  },
  State_3175_WeaponDesc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwachten 10 Wahnsinn"
  },
  State_3176_Desc = {
    Text = "Prolog Deck zurücksetzen 0_1_1_1"
  },
  State_3176_Name = {
    Text = "Prolog Deck zurücksetzen 0_1_1_1_2"
  },
  State_3176_WeaponDesc = {
    Text = "Prolog Deck zurücksetzen 0_1_1_1"
  },
  State_3177_Desc = {
    Text = "“Wachsamkeit“ bei 3 Stapeln Rückzug und Beschwörung einer „Ersatzwachsfigur“. Stapel werden zu Rundenbeginn geleert"
  },
  State_3177_Name = {
    Text = "Wachsamkeit"
  },
  State_3177_WeaponDesc = {
    Text = "“Wachsamkeit“ bei 3 Stapeln Rückzug und Beschwörung einer „Ersatzwachsfigur“. Stapel werden zu Rundenbeginn geleert"
  },
  State_3178_Desc = {
    Text = "Erhöhe den Rechenaufwand für die Karte"
  },
  State_3178_Name = {
    Text = "<SlowIconKeywords: Verlangsamung>"
  },
  State_3178_WeaponDesc = {
    Text = "Jede Schicht Verzögerung erhöht die Arithmetica-Kosten der Karte um 1 Punkt"
  },
  State_3179_Desc = {
    Text = "Zu Beginn des Kampfes erhältst du 20 Schild. Zu Beginn jeder Runde, wenn du Schild hast, erhöhen sich der Schild und die Heilung um 50%"
  },
  State_3179_Name = {
    Text = "Bewahrer des entarteten Gartens"
  },
  State_3179_WeaponDesc = {
    Text = "Zu Beginn des Kampfes erhältst du 20 Schild. Zu Beginn jeder Runde, wenn du Schild hast, erhöhen sich der Schild und die Heilung um 50%"
  },
  State_3180_Desc = {
    Text = "Kritische Rate erhöht um 25%. Nach einer Gesundheitswiederherstellung besteht die Chance, zusätzlich 1 Gesundheitswiederherstellung auszulösen, die Wahrscheinlichkeit entspricht der kritischen Rate des Wiederherstellers"
  },
  State_3180_Name = {
    Text = "Zustand @ Illusionssilberschlüssel: kritisches Heilen"
  },
  State_3181_Name = {Text = "Krit. Rate"},
  State_3183_Desc = {
    Text = "Innerhalb dieser Runde erhöht sich der kritische Schaden um [Layer] %"
  },
  State_3183_Name = {
    Text = "Temporärer Kritischer Schaden"
  },
  State_3185_Desc = {
    Text = "Erhöhe den Stress beim Bewegen"
  },
  State_3185_Name = {
    Text = "Schöpfung Bodensack2"
  },
  State_3185_WeaponDesc = {
    Text = "Erhöhe den Stress beim Bewegen"
  },
  State_3189_Name = {
    Text = "Monsterverzögerungskraft"
  },
  State_3190_Name = {
    Text = "Schöpfungsschlüssel"
  },
  State_3193_Desc = {
    Text = "Nach Beginn der nächsten Runde erhältst du [Layer] Schild"
  },
  State_3193_Name = {
    Text = "Die verlorene Kunst"
  },
  State_3193_WeaponDesc = {
    Text = "Nach Beginn der nächsten Runde erhältst du [Layer] Schild"
  },
  State_3196_Desc = {
    Text = "Nach dem Ausspielen erhaltet ihr [StateArg1] Punkte Arithmetica"
  },
  State_3196_Name = {
    Text = "<Rune_4_High:Hochplanung>"
  },
  State_3196_WeaponDesc = {
    Text = "Nach dem Ausspielen erhaltet ihr [StateArg1] Punkte Arithmetica"
  },
  State_3197_Desc = {
    Text = "“Schaden“ stellt [Arg1] Punkte Leben wieder her und halbiert die eigene Blutungs- und Vergiftungsstufen"
  },
  State_3197_Name = {
    Text = "Hämostatische Klemme"
  },
  State_3200_Desc = {
    Text = "Team Unique: Der Grundschaden und der Schild des Ausrüsters erhöhen sich um <WeaponEffect_Num:[StateArg1]%>. Zu Beginn der Erkundung wird eine “Schlag“- und eine “VERT“-Karte des Ausrüsters ins Deck gemischt. Nachdem der Ausrüster die “VERT“ ausgespielt hat, erhöht sich die kritische Rate und der kritische Schaden der nächsten “Schlag“-Karte des Ausrüsters um 15%. Nachdem der Ausrüster die “Schlag“ ausgespielt hat, erhöht sich der Schild der nächsten “VERT“-Karte des Ausrüsters um 15%, stapelbar bis zu 3 Mal."
  },
  State_3200_WeaponDesc = {
    Text = "Der Grundschaden und der Schild des Ausrüsters erhöhen sich um <WeaponEffect_Num:[StateArg1]%>. Zu Beginn der Erkundung wird eine “Schlag“- und eine “VERT“-Karte des Ausrüsters ins Deck gemischt. Nachdem der Ausrüstende “VERT“ gespielt hat, erhöht sich die kritische Trefferquote und der kritische Schaden der nächsten “Schlag“-Karte des Ausrüstenden um 15%. Nachdem der Ausrüstende “Schlag“ gespielt hat, erhöht sich der Schild der nächsten “VERT“-Karte des Ausrüstenden um 15%, kann bis zu 3 Mal gestapelt werden."
  },
  State_3201_Name = {
    Text = "Kette des Grolls"
  },
  State_3203_Desc = {
    Text = "Team Unique: Das vom Ausrüster erzeugte Schutzschild erhöht sich um <WeaponEffect_Num:[StateArg3] %>. Die „Verteidigung \" des Ausrüsters verursacht beim Feind mit den höchsten LP <IntoxicationIconKeywords:Gift> in Höhe von <WeaponEffect_Num:[StateArg1] %> der VERT des Ausrüsters. Befindet sich das aktuelle Reich im „Caro\"-Bereich, erhöht sich beim Anwenden von <IntoxicationIconKeywords:Gift> die <EmbryoFusionIconKeywords:Embryofusion> + <WeaponEffect_Num:[Blood:StateArg2]>; dieser Effekt kann maximal 3 Mal pro Runde ausgelöst werden."
  },
  State_3203_WeaponDesc = {
    Text = "Das vom Ausrüster erzeugte Schutzschild erhöht sich um <WeaponEffect_Num:[StateArg3] %>. Die „Verteidigung \" des Ausrüsters verursacht beim Feind mit den höchsten LP <WeaponEffect_Num:[Poison:DescArg1]> Stapel <IntoxicationIconKeywords:Gift>. Befindet sich das aktuelle Reich im „Caro\"-Bereich, erhöht sich beim Anwenden von <IntoxicationIconKeywords:Gift> die <EmbryoFusionIconKeywords:Embryofusion> +<WeaponEffect_Num:[Blood:StateArg2]>; dieser Effekt kann maximal 3 Mal pro Runde ausgelöst werden."
  },
  State_3204_Desc = {
    Text = "Beim Verursachen von echtem Schaden, mische [StateArg1] Wunden-Karten in den Ziehstapel"
  },
  State_3204_Name = {Text = "Risswunde"},
  State_3204_WeaponDesc = {
    Text = "Beim Ziehen bist du für 1 Runde geschwächt. Nach der Benutzung werden alle Gegner für 1 Runde geschwächt. Nicht verkäuflich"
  },
  State_3206_Desc = {
    Text = "Jedes Mal, wenn 1 Karte gespielt wird, erhöht sich die kritische Rate in dieser Runde um [StateArg1]%, maximal [StateArg2] Mal. Bei vollem Stapel wird der Effekt verdoppelt"
  },
  State_3206_Name = {
    Text = "Schöpfung Memphis Ritualspiegel"
  },
  State_3206_WeaponDesc = {
    Text = "Jedes Mal, wenn 1 Karte gespielt wird, erhöht sich die kritische Rate in dieser Runde um [StateArg1]%, maximal [StateArg2] Mal. Bei vollem Stapel wird der Effekt verdoppelt"
  },
  State_3207_Desc = {
    Text = "Pro verlorenen Lebenspunkt 1 Schicht entfernen, bei 0 Schichten [DescArg1] Schild erhalten"
  },
  State_3207_Name = {
    Text = "Dimensionsbarriere"
  },
  State_3208_Desc = {
    Text = "Versteinert, kann sich nicht bewegen, wird am Ende der Runde entfernt"
  },
  State_3208_Name = {
    Text = "<PetrifactionColour:Petrifizieren>"
  },
  State_3209_Name = {
    Text = "Schmuckstück Lebensentzug"
  },
  State_3209_WeaponDesc = {
    Text = "Nach Kampfbeginn, wenn der Träger Fleisch-Klasse ist, +25% ANGskraft"
  },
  State_3210_Name = {
    Text = "Zustand @ Rache-Riesenblatt erleuchten 1"
  },
  State_3211_Desc = {
    Text = "Handkartenlimit +2, am Ende des Zuges keine Handkarten abwerfen. Bei Lebensverlust zufällig 2 Handkarten abwerfen"
  },
  State_3212_Desc = {
    Text = "Ausgeteilter Aktiver Schaden und Tentakelschaden –25%, am Zugende wird 1 Stapelung entfernt."
  },
  State_3212_Name = {
    Text = "<WeaknessIconKeywords:Schwäche>"
  },
  State_3212_WeaponDesc = {
    Text = "Verringert den verursachten Gesamtschaden um 25 %"
  },
  State_3213_Desc = {
    Text = "Schild und Heilungseffekte um [Layer] % erhöhen"
  },
  State_3213_Name = {
    Text = "Temporäre starke Heilung und Schild"
  },
  State_3213_WeaponDesc = {
    Text = "Schild und Heilungseffekte um [Layer] % erhöhen"
  },
  State_3215_Name = {
    Text = "Zeitpendel „Versteckt\""
  },
  State_3216_Desc = {
    Text = "Nach Kampfende zusätzliche 100 schwarze Siegel erhalten, aber dafür eine Symptomkarte erhalten"
  },
  State_3216_Name = {
    Text = "Schöpfung Glücksring"
  },
  State_3216_WeaponDesc = {
    Text = "Nach Kampfende zusätzliche 100 schwarze Siegel erhalten, aber dafür eine Symptomkarte erhalten"
  },
  State_3220_Desc = {
    Text = "Nach der Freisetzung von Exaltieren ziehe 1 Karte. Wenn die Lebenspunkte unter 25% liegen, ziehe zusätzlich 1 Karte"
  },
  State_3223_Desc = {
    Text = "Schwächeeffekt um 10 % erhöht. Alle 3 Runden 1 Schicht Schwäche auf alle Feinde"
  },
  State_3224_Name = {
    Text = "Arithmetica der Schöpfungsarkana aufzeichnen"
  },
  State_3225_Name = {
    Text = "Schädelräuber"
  },
  State_3226_Desc = {
    Text = "Nach dem Ausspielen wird die Karte nicht in den Ablagestapel gelegt und kann in diesem Kampf nicht erneut verwendet werden"
  },
  State_3226_Name = {Text = "Verbrauch"},
  State_3226_WeaponDesc = {
    Text = "Nach dem Ausspielen wird die Karte nicht in den Ablagestapel gelegt und kann in diesem Kampf nicht erneut verwendet werden"
  },
  State_3227_Desc = {
    Text = "Alle Schöpfungspreise um 50% gesenkt"
  },
  State_3227_Name = {
    Text = "Handelsmedaille der Schöpfung"
  },
  State_3227_WeaponDesc = {
    Text = "Alle Schöpfungspreise um 50% gesenkt"
  },
  State_3228_Desc = {
    Text = "Zu Beginn der Runde, erhält der Wahnsinnsträger mit dem niedrigsten Wahnsinn 25 Wahnsinn"
  },
  State_3228_Name = {
    Text = "Arkane Raserei der Schöpfung"
  },
  State_3228_WeaponDesc = {
    Text = "Zu Beginn der Runde, erhält der Wahnsinnsträger mit dem niedrigsten Wahnsinn 25 Wahnsinn"
  },
  State_3229_Desc = {
    Text = "Prolog Deck zurücksetzen 0_1_1_1"
  },
  State_3229_Name = {
    Text = "Prolog Deck zurücksetzen 0_1_1_1"
  },
  State_3229_WeaponDesc = {
    Text = "Prolog Deck zurücksetzen 0_1_1_1"
  },
  State_3230_Name = {
    Text = "Zustand @ Allgemeine Verzögerung Arithmetica"
  },
  State_3232_Desc = {
    Text = "Status@MonsterHyperdimensionalerSlotTrigger"
  },
  State_3232_Name = {
    Text = "Status@MonsterHyperdimensionalerSlotTrigger"
  },
  State_3232_WeaponDesc = {
    Text = "Status@MonsterHyperdimensionalerSlotTrigger"
  },
  State_3234_Desc = {
    Text = "Zu Beginn des Kampfes erhält man 3 Stärke, aber erleidet 5 mehr Schaden."
  },
  State_3234_Name = {
    Text = "Rücken an Wasser"
  },
  State_3235_Desc = {
    Text = "Zu Beginn des Kampfes erhält man [Layer] Stärke, aber erleidet 5 mehr Schaden"
  },
  State_3235_Name = {
    Text = "Rücken an Wasser"
  },
  State_3236_Desc = {
    Text = "Nach dem Ausspielen erhalten andere Erwachte [StateArg1] Wahnsinn"
  },
  State_3236_Name = {
    Text = "<Rune_16_High:Hochkatalyse>"
  },
  State_3237_Desc = {
    Text = "Alle 3 Runden erhält man 3 Tentakel, die die Tentakelobergrenze ignorieren und am Ende der Runde entfernt werden"
  },
  State_3238_Desc = {
    Text = "Zu Beginn des Kampfes erhalten die Monster den Zustand „erhöhter Schaden“"
  },
  State_3238_Name = {
    Text = "Zu Beginn des Kampfes erhalten die Monster den Zustand „erhöhter Schaden“"
  },
  State_3238_WeaponDesc = {
    Text = "Zu Beginn des Kampfes erhalten die Monster den Zustand „erhöhter Schaden“"
  },
  State_3239_Desc = {
    Text = "Erhöht den ANG um [Layer] Punkte"
  },
  State_3239_Name = {
    Text = "Allgemeiner ANG erhöht"
  },
  State_3239_WeaponDesc = {
    Text = "Erhöht den ANG um [Layer] Punkte"
  },
  State_3242_Name = {
    Text = "2 <DerivativeCardKeywords_4:“Inspiration“> werden in den Ziehstapel gelegt"
  },
  State_3243_Desc = {
    Text = "Kartenrechenleistung erhöht"
  },
  State_3243_Name = {
    Text = "Kartenrechenleistung erhöht"
  },
  State_3243_WeaponDesc = {
    Text = "Kartenrechenleistung erhöht"
  },
  State_3244_Desc = {
    Text = "Beschworene Monster haben doppelte Lebenspunkte"
  },
  State_3244_Name = {
    Text = "“Überfluss der Reue“"
  },
  State_3244_WeaponDesc = {
    Text = "Beschworene Monster haben doppelte Lebenspunkte"
  },
  State_3245_Desc = {
    Text = "Zu Beginn des Kampfes sinkt die kritische Rate unseres Teams um 30%, die kritische Schaden erhöht sich um 30%"
  },
  State_3245_Name = {Text = "Inhibieren"},
  State_3245_WeaponDesc = {
    Text = "Zu Beginn des Kampfes sinkt die kritische Rate unseres Teams um 30%, die kritische Schaden erhöht sich um 30%"
  },
  State_3246_Desc = {
    Text = "Zu Beginn des Kampfes erhält das Leben gewöhnlicher Feinde eine Erhöhung um 30%, und nach dem Sieg im Kampf erhält man zusätzlich 25 schwarze Siegel"
  },
  State_3246_Name = {
    Text = "Schöpfung Zerrissene Kriegsflagge"
  },
  State_3246_WeaponDesc = {
    Text = "Zu Beginn des Kampfes erhält das Leben gewöhnlicher Feinde eine Erhöhung um 30%, und nach dem Sieg im Kampf erhält man zusätzlich 25 schwarze Siegel"
  },
  State_3247_Desc = {
    Text = "[Wahnsinnsexplosion]Reduziert die Arithmetica-Kosten aller Handkarten um -1"
  },
  State_3247_Name = {
    Text = "Licht der veränderten Zivilisation"
  },
  State_3247_WeaponDesc = {
    Text = "[Wahnsinnsexplosion]Reduziert die Arithmetica-Kosten aller Handkarten um -1"
  },
  State_3249_Desc = {
    Text = "Andere Verbündete erhalten 1 Stapel Wahnsinn, der beim Tod dieser Einheit entfernt wird."
  },
  State_3249_Name = {Text = "Unruhe"},
  State_3249_WeaponDesc = {
    Text = "Andere Verbündete erhalten 1 Schicht Wahnsinn, nach dem Tod aufgehoben"
  },
  State_3250_Desc = {
    Text = "Bleibt nach dem Kampf im Deck, wird aber nach dem Ausspielen oder Verbrauchen dauerhaft entfernt."
  },
  State_3250_Name = {
    Text = "<DestructionKeywords:Zerstören>"
  },
  State_3250_WeaponDesc = {
    Text = "Nach dem Ausspielen wird sie dauerhaft entfernt"
  },
  State_3251_Desc = {
    Text = "Beim Erleiden von Aktivem Schaden oder Tentakelschaden wird Immunität gegen SCH gewährt und 1 Stapel abgezogen. Wird zu Rundenbeginn entfernt."
  },
  State_3251_Name = {
    Text = "<ParcloseColour: Temporäre Barriere>"
  },
  State_3252_Desc = {
    Text = "Wenn der Schlammblüten-Schild angewendet wird, wird die maximale Gesundheit um [StateArg2] erhöht"
  },
  State_3252_Name = {
    Text = "Schleimkonvergenz"
  },
  State_3252_WeaponDesc = {
    Text = "Wenn der Schlammblüten-Schild angewendet wird, wird die maximale Gesundheit um [StateArg2] erhöht"
  },
  State_3253_Desc = {
    Text = "Erhalte [StateArg1] vorübergehende Alarm"
  },
  State_3253_Name = {
    Text = "<CardKeyWord:Mech-Waffe-Schild>"
  },
  State_3253_WeaponDesc = {
    Text = "Erhalte [StateArg1] vorübergehende Alarm"
  },
  State_3255_Name = {
    Text = "Gegenangriff"
  },
  State_3256_Name = {
    Text = "Status@Fluch Erregung"
  },
  State_3259_Desc = {
    Text = "Erhöht die Anzahl der ausgeteilten Aktiven SCH-Instanzen um [Layer]."
  },
  State_3259_Name = {
    Text = "<MadnessColour:Wahnsinn>"
  },
  State_3260_Desc = {
    Text = "Wenn der überdimensionale Raum sein Limit erreicht, erhältst du eine zusätzliche Runde, in der du keine Karten ziehst, sondern überdimensionale Raumsystemkarten in die Hand aufnimmst"
  },
  State_3260_Name = {
    Text = "<DimensionalSpaceIconKeywords:Dimensionale Raum>"
  },
  State_3260_WeaponDesc = {
    Text = "Wenn der Hyperdimensionale Raum voll ist, erhalte eine zusätzliche Hyperdimensionale Runde, alle Karten des Hyperdimensionalen Raums werden auf die Hand genommen"
  },
  State_3261_Desc = {
    Text = "Der Schaden seiner beschworenen Monster verdoppelt sich"
  },
  State_3261_Name = {
    Text = "“Wachsarmee“"
  },
  State_3261_WeaponDesc = {
    Text = "Der Schaden seiner beschworenen Monster verdoppelt sich"
  },
  State_3262_Desc = {
    Text = "Status@Wachsbeschichtung Team"
  },
  State_3262_Name = {
    Text = "Status@Wachsbeschichtung Team"
  },
  State_3262_WeaponDesc = {
    Text = "Status@Wachsbeschichtung Team"
  },
  State_3263_Name = {
    Text = "Status@Nautilus Schale Konter"
  },
  State_3264_Name = {
    Text = "Sicherer Treffer"
  },
  State_3265_Name = {
    Text = "Verwerfen und entfernen Sie es"
  },
  State_3266_Desc = {
    Text = "Stärkungssprung der Stadt der toten Träume"
  },
  State_3266_Name = {
    Text = "Status@Stärkungssprung der Nekropolis der Träume"
  },
  State_3267_Desc = {
    Text = "Zu Beginn des Kampfes erhält man 5 Schichten „Wachsrüstung“"
  },
  State_3267_Name = {
    Text = "“ Wachsadel “"
  },
  State_3267_WeaponDesc = {
    Text = "Zu Beginn des Kampfes erhält man 5 Schichten „Wachsrüstung“"
  },
  State_3268_Desc = {
    Text = "Zu Rundenbeginn ziehen Sie 1 Karte. Jedes Mal, wenn Sie 1 Karte ziehen, ändert sich der Arithmetica-Verbrauch zufällig (0-4)"
  },
  State_3268_Name = {
    Text = "Schöpfung Kaleidoskop"
  },
  State_3268_WeaponDesc = {
    Text = "Zu Rundenbeginn ziehen Sie 1 Karte. Jedes Mal, wenn Sie 1 Karte ziehen, ändert sich der Arithmetica-Verbrauch zufällig (0-4)"
  },
  State_3269_Desc = {
    Text = "Nach dem Erhalt des zweiten Schildes in jeder Runde erhält man [Arg1] Schichten Gegenschlag. Nach dem Erhalt des vierten Schildes in jeder Runde fügt man allen Feinden einmal Gegenschlag-Schaden zu"
  },
  State_3269_Name = {
    Text = "Entfesselte Wahrheit"
  },
  State_3270_Name = {
    Text = "Status@Kapitel 2 Resonanz Kopie"
  },
  State_3271_Desc = {
    Text = "[Schlag] fügt allen Feinden [Arg1] Schichten Gift zu"
  },
  State_3272_Desc = {
    Text = "Beim Verursachen von ungeblocktem Schaden wird das 3-fache des tatsächlichen Schadens als Leben wiederhergestellt, beim Verursachen von Schaden entfernt"
  },
  State_3272_Name = {Text = "Blutsaugen"},
  State_3273_Desc = {
    Text = "Team Unique: Nach dem Ausspielen einer Karte des Ausrüsters erhält man einen Schild in Höhe von <WeaponEffect_Num:[StateArg1]%> der VERT des Ausrüsters. Für jeden Tentakel erhöht sich der Schild um <WeaponEffect_Num:[StateArg2]%> der VERT des Ausrüsters. Dieser Effekt tritt pro Runde nur 1 Mal in Kraft."
  },
  State_3273_Name = {
    Text = "Frau Corals Tod"
  },
  State_3273_WeaponDesc = {
    Text = "Nach dem Ausspielen einer Karte des Ausrüsters erhält man <WeaponEffect_Num:[Block:DescArg1]> Schild, für jeden Tentakel erhöht sich das Schild um <WeaponEffect_Num:[DescArg2]>. Dieser Effekt tritt pro Runde nur 1 Mal in Kraft"
  },
  State_3274_Desc = {
    Text = "Bei jedem aktiven Schaden, füge dem Team eine Schicht Zähler hinzu"
  },
  State_3274_Name = {
    Text = "Zustand @ Rache-Riesenblatt Enthauptungsschaden Zählen für unser Team"
  },
  State_3274_WeaponDesc = {
    Text = "Bei jedem aktiven Schaden, füge dem Team eine Schicht Zähler hinzu"
  },
  State_3277_Desc = {
    Text = "Nach dem Ausspielen erhält der zugehörige Erwachte [StateArg1] Wahnsinn"
  },
  State_3277_Name = {
    Text = "<Rune_5:Raserei>"
  },
  State_3280_Name = {
    Text = "Vorherbestimmter Schlag"
  },
  State_3281_Desc = {
    Text = "Erhöhe den verursachten aktiven Schaden"
  },
  State_3281_Name = {
    Text = "<PowerIconKeywords: Stärke>"
  },
  State_3281_WeaponDesc = {
    Text = "Erhöht den verursachten Schaden"
  },
  State_3282_Desc = {
    Text = "Schadensanzahl und Schadenssteigerung"
  },
  State_3282_Name = {
    Text = "<CardKeyWord:Aufrüsten>"
  },
  State_3282_WeaponDesc = {
    Text = "Ein zusätzlicher Schaden"
  },
  State_3283_Desc = {
    Text = "Zu Beginn jeder Runde [StateArg1] Leben wiederherstellen. Wenn das Leben unter 50% liegt, [StateArg2] Leben wiederherstellen"
  },
  State_3283_Name = {
    Text = "Schöpfung Weihrauchpräparat"
  },
  State_3283_WeaponDesc = {
    Text = "Zu Beginn jeder Runde [StateArg1] Leben wiederherstellen. Wenn das Leben unter 50% liegt, [StateArg2] Leben wiederherstellen"
  },
  State_3287_Desc = {
    Text = "Zu Beginn des Kampfes werden 2 „Inspiration“ in dein Deck gemischt. Nach jedem Kampf verbessert sich dieses Artefakt, maximal 3 Mal"
  },
  State_3288_Desc = {
    Text = "Status@Leerzustand"
  },
  State_3288_Name = {
    Text = "Status@Leerzustand"
  },
  State_3288_WeaponDesc = {
    Text = "Status@Leerzustand"
  },
  State_3289_Desc = {
    Text = "Jeder erlittene Schaden verringert 1 Schicht. Wenn der Wert 0 erreicht, wird die Absicht durch die unsterbliche Blume ersetzt und eine defensivere Fähigkeitsgruppe verwendet"
  },
  State_3289_Name = {
    Text = "Ewige Blume"
  },
  State_3289_WeaponDesc = {
    Text = "Jeder erlittene Punkt Schaden reduziert eine Schicht. Bei 0 Schichten in den VERTsmodus wechseln"
  },
  State_3290_Desc = {
    Text = "Das Wesen, das einst als „Miryam“ bekannt war, war in extreme Paranoia und Verzweiflung versunken, zerschlug ihre letzte Besessenheit und beendete diesen Wahnsinn von Jahrtausenden"
  },
  State_3290_Name = {
    Text = "Besessenheit"
  },
  State_3291_Desc = {
    Text = "Beim Verursachen von tatsächlichem Schaden verliert das Team 3 temporäre Kraft"
  },
  State_3291_Name = {Text = "Lähmung"},
  State_3292_Desc = {
    Text = "Beim Freisetzen von Aelius, wenn ein Feind 1 Schaden verursachen will, wird er mit [Arg1] Schichten Gift belegt"
  },
  State_3293_Desc = {
    Text = "Schaden in diesem Level um [Layer] Punkte reduziert"
  },
  State_3293_Name = {Text = "STR▼"},
  State_3293_WeaponDesc = {
    Text = "Schaden und Tentakelschaden in diesem Level um [Layer] Punkte reduziert"
  },
  State_3294_Name = {
    Text = "Status@Fluch Misstrauen"
  },
  State_3296_Desc = {
    Text = "Beim Abwerfen oder Ausspielen entfernen"
  },
  State_3296_Name = {
    Text = "Beim Abwerfen oder Ausspielen entfernen"
  },
  State_3296_WeaponDesc = {
    Text = "Beim Ziehen bist du für 1 Runde geschwächt. Nach der Benutzung werden alle Gegner für 1 Runde geschwächt. Nicht verkäuflich"
  },
  State_3297_Desc = {
    Text = "Status@Dornenkönigin Morgenröte Form"
  },
  State_3297_Name = {
    Text = "Status@Dornenkönigin Morgenröte Form"
  },
  State_3297_WeaponDesc = {
    Text = "Status@Dornenkönigin Morgenröte Form"
  },
  State_3298_Desc = {
    Text = "In dieser Runde wird der nächste Sprungeffekt garantiert ausgelöst"
  },
  State_3298_Name = {
    Text = "Sprung wird immer ausgelöst"
  },
  State_3298_WeaponDesc = {
    Text = "In dieser Runde Sprungeffekt ohne Bedingungen"
  },
  State_3301_Name = {
    Text = "Sternenwein-Zählung"
  },
  State_3302_Desc = {
    Text = "Fügt Ewige Erstarrung hinzu"
  },
  State_3302_Name = {
    Text = "Fügt Ewige Erstarrung hinzu"
  },
  State_3302_WeaponDesc = {
    Text = "Fügt Ewige Erstarrung hinzu"
  },
  State_3304_Desc = {
    Text = "Der letzte gespielte Befehlskarte-Wächter erhält am Rundenende 15 Wahnsinn. Wenn du das „Mutterbild“ hast, erhalten andere Wächter 5 Wahnsinn"
  },
  State_3305_Desc = {
    Text = "Nach dem Spielen mische [StateArg1] „Inspiration“ in den Nachziehstapel. „Inspiration“: erhält 1 Arithmetica, ziehe 1 Karte, beibehalten, verbrauchen"
  },
  State_3305_Name = {
    Text = "<Rune_17:Inspiration>"
  },
  State_3307_Name = {
    Text = "(Verbleibend: [Layer])"
  },
  State_3308_Desc = {
    Text = "Zu Rundenbeginn, wenn die Anzahl der verbleibenden Handkarten aus der letzten Runde mehr als 2 ist, erhalten Sie 2 Arithmetica"
  },
  State_3309_Desc = {
    Text = "Der durch den Ausrüster verursachte Schaden, Schild und die Heilung erhöhen sich um [StateArg1]% (temporär)"
  },
  State_3309_Name = {
    Text = "Status@Prototyp Langschwert Todeswiderstand"
  },
  State_3310_Desc = {
    Text = "Wenn der Migrant ein Schild anlegt, erhält er [Energy:StateArg2] Wahnsinn"
  },
  State_3310_Name = {
    Text = "Selbstinhaftierung"
  },
  State_3310_WeaponDesc = {
    Text = "Wenn der Migrant ein Schild anlegt, erhält er [Energy:StateArg2] Wahnsinn"
  },
  State_3312_Desc = {
    Text = "Immer wenn du Gesundheit wiederherstellst, erhältst du [Arg1] Punkte Rückstoß, wenn die Gesundheit über 75% liegt, erhältst du zusätzlich [Arg2] Punkte Rückstoß"
  },
  State_3313_Desc = {
    Text = "Zu Beginn der Runde erhältst du [Arg1] Stärke für diese Runde, verlierst aber [Arg2] Stärke für jede gespielte Karte"
  },
  State_3314_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_3314_Name = {
    Text = "Nicht erweckt"
  },
  State_3315_Desc = {
    Text = "Nach der ersten gespielten Karte jeder Runde werden 2 zufällige Handkarten temporär in ihre Originalversion kopiert und am Rundenende wiederhergestellt"
  },
  State_3315_Name = {
    Text = "Schöpfung Verlockende Windglocke"
  },
  State_3316_Desc = {
    Text = "Am Ende der Runde bleibt der Schild erhalten"
  },
  State_3316_Name = {
    Text = "Schutzschild"
  },
  State_3316_WeaponDesc = {
    Text = "Am Ende der Runde bleibt der Schild erhalten"
  },
  State_3317_Desc = {
    Text = "Nach Rundenende -alle Schilde"
  },
  State_3317_Name = {
    Text = "Fesseln: Geburtvater"
  },
  State_3318_Name = {
    Text = "Status@Blutdurstiger Verführer Umarmung Verschlingungsmarkierung"
  },
  State_3323_Desc = {
    Text = "Der durch den Ausrüster verursachte Schaden, Schild und die Heilung erhöhen sich um [StateArg1]% (temporär)"
  },
  State_3323_Name = {
    Text = "Status@Prototyp Langschwert Wahnsinn"
  },
  State_3324_Desc = {
    Text = "Innerhalb dieser Runde erhöht sich der kritische Schaden um [Layer] %"
  },
  State_3324_Name = {
    Text = "Temporärer Kritischer Schaden"
  },
  State_3324_WeaponDesc = {
    Text = "Innerhalb dieser Runde erhöht sich der kritische Schaden um [Layer] %"
  },
  State_3325_Desc = {
    Text = "Bei jedem Zurücksetzen des Decks, füge 2 Karten „Dreizack“, die in dieser Runde [Arg1] Punkte Macht erhalten, und 1 Karte „Sonnenschirm“, die in dieser Runde [Arg2] Punkte Alarm erhalten hat, deiner Hand hinzu"
  },
  State_3326_Desc = {
    Text = "Pro Runde immun gegen den ersten aktiven Schaden"
  },
  State_3326_Name = {Text = "Festigkeit"},
  State_3326_WeaponDesc = {
    Text = "Pro Runde immun gegen den ersten aktiven Schaden"
  },
  State_3327_Desc = {
    Text = "Lebenspunkte des Monsters vor dem Tod"
  },
  State_3327_Name = {
    Text = "HP des Monsters vor dem Tod"
  },
  State_3327_WeaponDesc = {
    Text = "Lebenspunkte des Monsters vor dem Tod"
  },
  State_3328_Desc = {
    Text = "Bei tödlichem Schaden in diesem Kampf einmal wiederbeleben und [Layer] Lebenspunkte wiederherstellen, nicht vertreibbar."
  },
  State_3328_Name = {
    Text = "Unsterblicher Paradiesvogel"
  },
  State_3329_Desc = {
    Text = "Jedes Mal, wenn 5 Karten gespielt werden, erhalte eine Kopie der linken Karte in deiner Hand, aber mit Leere und Verbrauch"
  },
  State_3330_Desc = {
    Text = "Die Arithmetica der Karte verbraucht zusätzliche [Layer] Punkte. Nach dem Ausspielen der Karte wird dieser negative Effekt entfernt"
  },
  State_3330_Name = {
    Text = "<SlowColour:Verlangsamung [Layer]>"
  },
  State_3330_WeaponDesc = {
    Text = "Die Arithmetica der Karte verbraucht zusätzliche [Layer] Punkte"
  },
  State_3332_Desc = {
    Text = "Beim Erleiden von Aktivem Schaden oder Tentakelschaden wird der Schaden ignoriert und 1 Stapelung verloren."
  },
  State_3332_Name = {
    Text = "<ParcloseColour: Barriere>"
  },
  State_3335_Desc = {
    Text = "Zu Beginn des Kampfes erhalten alle Feinde 1 Schicht Verwundbarkeit. Der „Stagnationsfluch“ erhöht die Verwundbarkeitseffekte um 25%"
  },
  State_3335_Name = {
    Text = "Stein-Augen Erleuchtung 6"
  },
  State_3336_Name = {
    Text = "Zustand @ George @ heilt beim Tod"
  },
  State_3337_Name = {
    Text = "Zinnoberrote Zeremonie"
  },
  State_3339_Desc = {
    Text = "Erhöht den ANG um [Layer] Punkte"
  },
  State_3339_Name = {
    Text = "Vorübergehende ANGskraftsteigerung"
  },
  State_3339_WeaponDesc = {
    Text = "Erhöht den ANG um [Layer] Punkte"
  },
  State_3340_Desc = {
    Text = "Nach der Freisetzung von Exaltieren wird der Exaltieren-Schaden in diesem Kampf um [Arg1] erhöht, maximal 5 Mal stapelbar. Wenn das Maximum erreicht ist, erhält der Erwecker des Exaltierens 100 Wahnsinn"
  },
  State_3341_Desc = {
    Text = "Status@PrologDeckReset0_1_2_1"
  },
  State_3341_Name = {
    Text = "Status@PrologDeckReset0_1_2_1"
  },
  State_3341_WeaponDesc = {
    Text = "Status@PrologDeckReset0_1_2_1"
  },
  State_3342_Desc = {
    Text = "Status@PrologDeckReset0_1_2_2"
  },
  State_3342_Name = {
    Text = "Status@PrologDeckReset0_1_2_2"
  },
  State_3342_WeaponDesc = {
    Text = "Status@PrologDeckReset0_1_2_2"
  },
  State_3343_Desc = {
    Text = "Status@PrologDeckReset0_1_2_3"
  },
  State_3343_Name = {
    Text = "Status@PrologDeckReset0_1_2_3"
  },
  State_3343_WeaponDesc = {
    Text = "Status@PrologDeckReset0_1_2_3"
  },
  State_3344_Desc = {
    Text = "Status@PrologDeckReset0_1_2_4"
  },
  State_3344_Name = {
    Text = "Status@PrologDeckReset0_1_2_4"
  },
  State_3344_WeaponDesc = {
    Text = "Status@PrologDeckReset0_1_2_4"
  },
  State_3345_Desc = {
    Text = "Status@PrologDeckReset0_1_2_5"
  },
  State_3345_Name = {
    Text = "Status@PrologDeckReset0_1_2_5"
  },
  State_3345_WeaponDesc = {
    Text = "Status@PrologDeckReset0_1_2_5"
  },
  State_3346_Desc = {
    Text = "Status@PrologDeckReset0_1_2_5"
  },
  State_3346_Name = {
    Text = "Status@PrologDeckReset0_1_2_5"
  },
  State_3346_WeaponDesc = {
    Text = "Status@PrologDeckReset0_1_2_6"
  },
  State_3347_Desc = {
    Text = "Status@PrologDeckReset0_1_2_5"
  },
  State_3347_Name = {
    Text = "Status@PrologDeckReset0_1_2_5"
  },
  State_3347_WeaponDesc = {
    Text = "Status@PrologDeckReset0_1_2_7"
  },
  State_3348_Desc = {
    Text = "Nach dem Ausspielen ziehe [StateArg1] Karten"
  },
  State_3348_Name = {
    Text = "<Rune_3_High:Hochgeschick>"
  },
  State_3348_WeaponDesc = {
    Text = "Nach dem Ausspielen ziehe [StateArg1] Karten"
  },
  State_3350_Desc = {
    Text = "Nach dem Auslösen von „Wahnsinnsexplosion“ verliere 10% deines aktuellen Lebens und stehle [Arg1] Punkte Stärke von allen Feinden in dieser Runde"
  },
  State_3351_Name = {
    Text = "Status@NachDeckBeitritt"
  },
  State_3352_Name = {
    Text = "Schöpfung Sternenastrolabium1"
  },
  State_3354_Name = {
    Text = "Schöpfung Sternenastrolabium2"
  },
  State_3356_Name = {
    Text = "Runde beendet: Erstickungsvergiftung"
  },
  State_3357_Desc = {
    Text = "Nach Beginn der nächsten Runde, Tentakelschaden +[Layer]"
  },
  State_3357_Name = {
    Text = "Verzögerter Tentakelschaden"
  },
  State_3358_Desc = {
    Text = "Nach Beginn der nächsten Runde erhältst du [Layer] Schildpunkte"
  },
  State_3358_Name = {
    Text = "Verlorene Kunst - Schild"
  },
  State_3359_Desc = {
    Text = "Die dritte Karte, die du spielst, hat eine doppelte Wirkung"
  },
  State_3359_Name = {
    Text = "Schöpfung Sternenwein"
  },
  State_3359_WeaponDesc = {
    Text = "Die dritte Karte, die du spielst, hat eine doppelte Wirkung"
  },
  State_3360_Desc = {
    Text = "Status@PrologDeckReset0_1_4_1"
  },
  State_3360_Name = {
    Text = "Status@PrologDeckReset0_1_4_1"
  },
  State_3360_WeaponDesc = {
    Text = "Status@PrologDeckReset0_1_4_1"
  },
  State_3362_Desc = {
    Text = "Status@PrologDeckReset0_1_4_1"
  },
  State_3362_Name = {
    Text = "Status@PrologDeckReset0_1_4_1"
  },
  State_3362_WeaponDesc = {
    Text = "Status@PrologDeckReset0_1_4_1"
  },
  State_3364_Desc = {
    Text = "Beim Aufheben wählt man eine Karte und verleiht ihr zwei dreifach verstärkende Effekte. (Hinweis: Ähnlich wie tausend Fata Morgana Karten.)"
  },
  State_3365_Desc = {
    Text = "Status@PrologDeckReset0_1_4_1"
  },
  State_3365_Name = {
    Text = "Status@PrologDeckReset0_1_4_1"
  },
  State_3365_WeaponDesc = {
    Text = "Status@PrologDeckReset0_1_4_1"
  },
  State_3366_Desc = {
    Text = "Status@PrologDeckReset0_1_4_1"
  },
  State_3366_Name = {
    Text = "Status@PrologDeckReset0_1_4_1"
  },
  State_3366_WeaponDesc = {
    Text = "Status@PrologDeckReset0_1_4_1"
  },
  State_3368_Desc = {
    Text = "Wenn der Verbrauch an Rechenleistung vor der Ablagephase größer als 5 ist, wird es zu Stein"
  },
  State_3368_Name = {
    Text = "Versteinern"
  },
  State_3368_WeaponDesc = {
    Text = "Vor der Abwurfphase Handkarten in Steine verwandeln"
  },
  State_3369_Desc = {
    Text = "Alle deine Verschlingungseffekte werden zu unendlicher Verschlingung"
  },
  State_3369_Name = {
    Text = "Unendliches Verschlingen"
  },
  State_3369_WeaponDesc = {
    Text = "Alle deine Verschlingungseffekte werden zu unendlicher Verschlingung"
  },
  State_3370_Desc = {
    Text = "Schild in diesem Level um [Layer] Punkte reduziert"
  },
  State_3370_Name = {
    Text = "Permanente Wachsamkeitsverringerung"
  },
  State_3370_WeaponDesc = {
    Text = "Schild in diesem Level um [Layer] Punkte reduziert"
  },
  State_3372_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_3372_Name = {
    Text = "Nicht erweckt"
  },
  State_3373_Desc = {
    Text = "Beim Verursachen von echtem Schaden, mische [StateArg1] Wunden-Karten in den Ziehstapel"
  },
  State_3373_Name = {Text = "Erstickung"},
  State_3373_WeaponDesc = {
    Text = "Beim Ziehen bist du für 1 Runde geschwächt. Nach der Benutzung werden alle Gegner für 1 Runde geschwächt. Nicht verkäuflich"
  },
  State_3374_Desc = {
    Text = "Nach Rundenende +gleiche Anzahl an Stärke"
  },
  State_3374_Name = {Text = "Wut"},
  State_3376_Desc = {
    Text = "In diesem Kampf wird der durch Exaltieren verursachte Schaden um [Layer] Punkte erhöht"
  },
  State_3376_Name = {
    Text = "Wutanfall-Schaden erhöht"
  },
  State_3378_Desc = {
    Text = "Nach dem Auslösen von „Wahnsinnsexplosion“ wirkt die nächste ausgespielte Karte 2 Mal"
  },
  State_3378_Name = {
    Text = "Status@TraumSilberschlüssel:Explosion"
  },
  State_3379_Desc = {
    Text = "Unter 50% Leben wird der Kettenbrecher wütend"
  },
  State_3379_Name = {Text = "Rachezeit"},
  State_3379_WeaponDesc = {
    Text = "Unter 50% Leben wird der Kettenbrecher wütend"
  },
  State_3380_Desc = {
    Text = "Zu Beginn des Kampfes wird 1 \"Verwirrung\"-Karte in den Deckablage gewaschen"
  },
  State_3380_Name = {Text = "Verwirrung"},
  State_3380_WeaponDesc = {
    Text = "Zu Beginn des Kampfes wird 1 \"Verwirrung\"-Karte in den Deckablage gewaschen"
  },
  State_3381_Name = {
    Text = "Hyperdimensionaler Beruf Initialisierung"
  },
  State_3382_Desc = {
    Text = "Erhalte eine Aufgabe. Nach Abschluss der Aufgabe erhältst du eine Belohnung. [Ereignis-Platzhalter für die Aufgabe]"
  },
  State_3383_Name = {
    Text = "Hyperdimensionaler Beruf Initialisierung"
  },
  State_3385_Desc = {
    Text = "Aktiver und Tentakelschaden um 33 % reduziert"
  },
  State_3385_Name = {
    Text = "Spiegelschild"
  },
  State_3385_WeaponDesc = {
    Text = "Aktiver und Tentakelschaden um 33 % reduziert"
  },
  State_3386_Desc = {
    Text = "Der durch den Ausrüster verursachte Schaden, Schild und die Heilung erhöhen sich um [StateArg1]% (temporär)"
  },
  State_3386_Name = {
    Text = "Status@Prototyp Langschwert Kritisch"
  },
  State_3387_Name = {
    Text = "Status@Stufe2_3Kampf3Blase1"
  },
  State_3388_Desc = {
    Text = "Nach dem Ausspielen erhält man [StateArg1] Kraft"
  },
  State_3388_Name = {
    Text = "<Rune_14:Brutalität>"
  },
  State_3389_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_3389_Name = {
    Text = "Nicht erweckt"
  },
  State_3390_Desc = {
    Text = "Beim Kampfbeginn Schwäche und Verwundbarkeit für alle Gegner 1 Runde"
  },
  State_3392_Desc = {
    Text = "Nach dem Aufheben erhält man [Arg1] Stärke. Jedes Mal, wenn ein “Embryo“ fusioniert wird, erhält man in dieser Runde [Arg2] Punkte Stärke."
  },
  State_3393_Desc = {
    Text = "Zu Beginn jeder Runde +30% Embryo-Fusion. Alle deine Verschlingungseffekte werden zu unbegrenzter Verschlingung"
  },
  State_3394_Name = {
    Text = "Lege 1 Karte <DerivativeCardKeywords_4:„Inspiration“> in den Ziehstapel"
  },
  State_3395_Desc = {
    Text = "Einzigartig im Team: Der Grundschaden des “Schlags“ des Ausrüsters erhöht sich um 25%, der Grundschild der “VERT“ erhöht sich um 25%. Beim Ausspielen des “Schlags“ des Ausrüsters erhält man temporäre <PowerIconKeywords:Stärke> in Höhe von <WeaponEffect_Num:[StateArg1]%> der ANGskraft des Ausrüsters, beim Ausspielen der “VERT“ erhält man temporäre <AlertIconKeywords:Wachsam> in Höhe von <WeaponEffect_Num:[StateArg2]%> der VERTskraft des Ausrüsters. Wenn das aktuelle Gebiet “Ultra“ ist, erhält man beim Betreten der Ultra-Runde einmal temporäre <PowerIconKeywords:Stärke> und temporäre <AlertIconKeywords:Wachsam>."
  },
  State_3395_WeaponDesc = {
    Text = "Der Grundschaden von “Schlag“ des Ausrüsters erhöht sich um 25%, der Grundschild von “VERT“ erhöht sich um 25%. Beim Ausspielen von “Schlag“ des Ausrüsters erhält man <WeaponEffect_Num:[Power:DescArg1]> Punkte temporäre <PowerIconKeywords:Kraft>, beim Ausspielen von “VERT“ des Ausrüsters erhält man <WeaponEffect_Num:[DescArg2]> Punkte temporäre <AlertIconKeywords:Wachsam>. Wenn das aktuelle Reich “Ultra“ ist, erhält man beim Eintritt in die Ultra-Runde einmal temporäre <PowerIconKeywords:Kraft> und temporäre <AlertIconKeywords:Wachsam>."
  },
  State_3397_Desc = {
    Text = "Bei jeder 10. gespielten Karte, erhöhe [Arg1] Tentakelschaden und alle Tentakel greifen 1 Mal an"
  },
  State_3400_Desc = {
    Text = "Maximale Gesundheit von Elite- und Boss-Gegnern um 20% reduziert"
  },
  State_3401_Desc = {
    Text = "Nach dem Ausspielen wirkt sie zusätzlich [StateArg1] Mal, erhaltet [StateArg2] Punkte das schwarze Siegel, Ermüden, Eigenschaft"
  },
  State_3401_Name = {
    Text = "<Rune_7:Echo>"
  },
  State_3402_Desc = {
    Text = "“Eisenspitzhacke“ erhöht den Schadensschaden um [Layer] %.“"
  },
  State_3402_Name = {
    Text = "Schaden von Schwerem Schlag erhöht"
  },
  State_3402_WeaponDesc = {
    Text = "Eisenspitzhacke Lucens erhöht den Schadenswert um [Layer] %"
  },
  State_3403_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_3403_Name = {
    Text = "Nicht erweckt"
  },
  State_3405_Name = {
    Text = "Alle Feinde vorübergehend um [Power:StateArg1] Punkte <PowerIconKeywords:Kraft> senken, Schild und <PowerIconKeywords:Kraft> um 50% für 1 Runde reduzieren"
  },
  State_3406_Name = {
    Text = "Erhalte [StateArg1] Punkt<PowerIconKeywords:Kraft>"
  },
  State_3407_Name = {
    Text = "Wähle eine Karte aus dem Nachziehstapel und füge sie deiner Hand hinzu und reduziere ihren Arithmetica-Verbrauch um 1"
  },
  State_3408_Name = {
    Text = "Erhalte <Posse:[DescArg1]> Punkte Silberschlüssel-Energie. In diesem Kampf erhöht sich der Grundschaden von „Enthauptung“ und „Tausend Fata Morgana“ um 10%"
  },
  State_3409_Name = {
    Text = "Wähle 1 Erwachten, erhalte <Energy:[DescArg1]> Wahnsinn"
  },
  State_3410_Name = {
    Text = "Die Kritische Rate und kritischer Schaden dieser Karte erhöhen sich um 50% und verursachen durchdringenden Schaden"
  },
  State_3411_Name = {
    Text = "Immun gegen <FragileIconKeywords:Zerbrechlichkeit>, <WeaknessIconKeywords:Schwäche>, <VulnerabilityIconKeywords:Verwundbarkeit> für 1 Runde. Erhält <Block:[Block:StateArg1]> Schildpunkte"
  },
  State_3412_Desc = {
    Text = "Immun gegen negative Zustände, am Rundenende oder nach einem kritischen Treffer 1 Schicht entfernt"
  },
  State_3412_Name = {
    Text = "Wachsbeschichtung"
  },
  State_3412_WeaponDesc = {
    Text = "Pro Schicht wird der erlittene Schaden um 10% reduziert, nach jedem kritischen Treffer 1 Schicht weniger"
  },
  State_3415_Desc = {
    Text = "Beim Aufnehmen wähle 1 von 3 Korruptions-Relikten. Korruptions-Relikte sind mächtiger als gewöhnliche Relikte, verbrauchen aber Karten beim Ausspielen"
  },
  State_3415_Name = {
    Text = "Schöpfung Jadeabdruck"
  },
  State_3415_WeaponDesc = {
    Text = "Beim Aufnehmen wähle 1 von 3 Korruptions-Relikten. Korruptions-Relikte sind mächtiger als gewöhnliche Relikte, verbrauchen aber Karten beim Ausspielen"
  },
  State_3416_Desc = {
    Text = "Team Unique: Nach Kampfbeginn erhält man Gegenangriff in Höhe von <WeaponEffect_Num:[StateArg1] %> der VERT des Ausrüsters. Nach dem Auslösen von <DeathResistanceIconKeywords: Todwiderstand> erhält man bis zu insgesamt 2 Stapel „Wiege \": Das von allen Verbündeten erzeugte Schutzschild und die LP-Heilung erhöhen sich um <WeaponEffect_Num:[StateArg2] %>; am Rundenende wird 1 Stapel entfernt. Befindet sich das aktuelle Reich im „Caro\"-Bereich, erhöht sich nach dem Auslösen von <DeathResistanceIconKeywords: Todwiderstand> die Embryofusion <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_3416_WeaponDesc = {
    Text = "Nach Kampfbeginn erhält man <WeaponEffect_Num:[Counterattack:DescArg1]> Stapel Gegenangriff. Nach dem Auslösen von <DeathResistanceIconKeywords: Todwiderstand> erhält man bis zu insgesamt 2 Stapel „Wiege \": Das von allen Verbündeten erzeugte Schutzschild und die LP-Heilung erhöhen sich um <WeaponEffect_Num:[StateArg2] %>; am Rundenende wird 1 Stapel entfernt. Befindet sich das aktuelle Reich im „Caro\"-Bereich, erhöht sich nach dem Auslösen von <DeathResistanceIconKeywords: Todwiderstand> die Embryofusion <WeaponEffect_Num:+[Blood:StateArg3]>."
  },
  State_3418_Desc = {
    Text = "Nach Rundenende -temporäre Stärke"
  },
  State_3418_Name = {
    Text = "Verzögerte Erschöpfung"
  },
  State_3419_Desc = {
    Text = "Beim Aufnehmen werden 3 Karten mit fortgeschrittenen oder verfluchten Relikten angezeigt, wähle 1 und gewähre ihr das entsprechende Relikt"
  },
  State_3420_Desc = {
    Text = "Jede Aktion verursacht Bluten, das Heilen kann die Anzahl der Blutungsschichten halbieren"
  },
  State_3420_Name = {Text = "Blutspur"},
  State_3420_WeaponDesc = {
    Text = "Jede Aktion verursacht Bluten, das Heilen kann die Anzahl der Blutungsschichten halbieren"
  },
  State_3421_Desc = {
    Text = "Zu Beginn der Runde füge einen „Dreizack“ mit [Arg1] Macht, den du in dieser Runde erhältst, zu deiner Hand hinzu. Nach der Freisetzung von Exaltieren erhöhe alle „Dreizack“ in deiner Hand um [Arg2] Macht"
  },
  State_3422_Name = {
    Text = "Status@Schmuck Makellose Offenbarung"
  },
  State_3422_WeaponDesc = {
    Text = "Nach der Freisetzung des Bande wird [DescArg1] Leben wiederhergestellt. Wenn der Ausrüstende eine Silberschlüsselaufladungsstufe größer als 20 hat, wird zusätzlich [DescArg1] Leben wiederhergestellt. Gleiche Effekte können nicht wiederholt aktiviert werden"
  },
  State_3423_Desc = {
    Text = "Reichsbeherrschung 100, zusätzlicher Tentakelschaden"
  },
  State_3423_Name = {
    Text = "Status@TraumSilberschlüssel:Albtraum"
  },
  State_3424_Desc = {
    Text = "Zu Beginn der Runde, wenn im letzten Zug mehr als 3 Karten gespielt wurden, ziehe 2 Karten"
  },
  State_3425_Desc = {
    Text = "Wenn das Leben unter 50% ([StateArg1]) fällt, wird die Absicht zu „überlebendes Dilemma“ geändert: Zerreissfälle wie Zerbrechlichkeit, Schwäche und Gift werden entfernt, aber es werden 99 Schichten Schwäche und Zerbrechlichkeit dem Team zugefügt"
  },
  State_3425_Name = {Text = "Rachezeit"},
  State_3425_WeaponDesc = {
    Text = "Wenn das Leben unter 50% ([StateArg1]) fällt, wird die Absicht zu „überlebendes Dilemma“ geändert: Zerreissfälle wie Zerbrechlichkeit, Schwäche und Gift werden entfernt, aber es werden 99 Schichten Schwäche und Zerbrechlichkeit dem Team zugefügt"
  },
  State_3429_Desc = {
    Text = "Jede Aktion fügt Bluten hinzu, das Heilen kann die Blutenwirkung entfernen"
  },
  State_3429_Name = {
    Text = "Schwere Verletzung"
  },
  State_3429_WeaponDesc = {
    Text = "Jede Aktion fügt Bluten hinzu, das Heilen kann die Blutenwirkung entfernen"
  },
  State_3430_Desc = {
    Text = "Nach dem Freisetzen von Aelius erhältst du [Arg1] Punkte Theke. Wenn dies die 6. Auslösung im aktuellen Kampf ist, verdoppelt sich deine Theke"
  },
  State_3431_Name = {
    Text = "Immunität gegen Vergiftung"
  },
  State_3432_Desc = {
    Text = "Beim Abwerfen wird es verbraucht"
  },
  State_3432_Name = {
    Text = "Kartenentsorgungskosten"
  },
  State_3432_WeaponDesc = {
    Text = "Beim Ziehen bist du für 1 Runde geschwächt. Nach der Benutzung werden alle Gegner für 1 Runde geschwächt. Nicht verkäuflich"
  },
  State_3434_Name = {
    Text = "Status@Allgemeine Verwundbarkeit Modifikation"
  },
  State_3436_Desc = {
    Text = "Es werden [Layer] Erwachte gejagt"
  },
  State_3436_Name = {
    Text = "gejagt werden"
  },
  State_3437_Desc = {
    Text = "Zustand @ Monster Wal-Hüpfen Phantasma Planet Erster_Sprung_Chaosbestie"
  },
  State_3437_Name = {
    Text = "Zustand @ Monster Wal-Hüpfen Phantasma Planet Erster_Sprung_Chaosbestie"
  },
  State_3437_WeaponDesc = {
    Text = "Zustand @ Monster Wal-Hüpfen Phantasma Planet Erster_Sprung_Chaosbestie"
  },
  State_3438_Desc = {
    Text = "Erhalte [StateArg1] temporäre Stärke"
  },
  State_3438_Name = {
    Text = "<CardKeyWord:Mech-Waffe-Schwert>"
  },
  State_3439_Desc = {
    Text = "Beim Ende der Runde erhält Tulu 5 Punkte Wahnsinn"
  },
  State_3439_Name = {
    Text = "Sternenposition"
  },
  State_3440_Name = {
    Text = "Vergoldeter Führer"
  },
  State_3441_Desc = {
    Text = "Bei ungeraden Runden ziehst du 2 Karten, wenn du 0 Handkarten hast; bei geraden Runden erhältst du 2 Arithmetica, wenn du 0 Arithmetica hast"
  },
  State_3441_Name = {
    Text = "Mutiertes altes Puzzle"
  },
  State_3441_WeaponDesc = {
    Text = "Bei ungeraden Runden ziehst du 2 Karten, wenn du 0 Handkarten hast; bei geraden Runden erhältst du 2 Arithmetica, wenn du 0 Arithmetica hast"
  },
  State_3442_Desc = {
    Text = "Nach dem Aufheben verliert man dauerhaft [Arg1] Kraft. Bei jedem verursachten Schaden werden [Arg2] Lebenspunkte wiederhergestellt, maximal 6 Mal pro Runde"
  },
  State_3442_Name = {
    Text = "Kuss der Neunmäuler"
  },
  State_3444_Desc = {
    Text = "Zu Beginn der Runde ziehst du 1 Karte"
  },
  State_3445_Desc = {
    Text = "Erhöht die VERT um [Layer]%"
  },
  State_3445_Name = {
    Text = "Allgemeiner VERTsprozentsatz erhöht"
  },
  State_3445_WeaponDesc = {
    Text = "Erhöht die VERT um [Layer]%"
  },
  State_3446_Desc = {
    Text = "Besitzt 5 Schichten [Zündschnur]. Nach dem Ausspielen einer Karte verringert sich die Schicht um 1. Bei 0 explodiert sie und verursacht 2,5-fachen Schaden"
  },
  State_3446_Name = {Text = "Granate"},
  State_3446_WeaponDesc = {
    Text = "Besitzt 5 Schichten [Zündschnur]. Nach dem Ausspielen einer Karte verringert sich die Schicht um 1. Bei 0 explodiert sie und verursacht 2,5-fachen Schaden"
  },
  State_3447_Desc = {
    Text = "Besitzt 5 Schichten [Zündschnur]. Nach dem Ausspielen einer Karte verringert sich die Schicht um 1. Bei 0 explodiert sie und verursacht 2,5-fachen Schaden"
  },
  State_3447_Name = {Text = "Granate"},
  State_3447_WeaponDesc = {
    Text = "Besitzt 5 Schichten [Zündschnur]. Nach dem Ausspielen einer Karte verringert sich die Schicht um 1. Bei 0 explodiert sie und verursacht 2,5-fachen Schaden"
  },
  State_3448_Desc = {
    Text = "Nach jeder Runde aktiviere alle Tentakel"
  },
  State_3448_Name = {
    Text = "Automatische Tentakelaktivierung"
  },
  State_3448_WeaponDesc = {
    Text = "Nach jeder Runde aktiviere alle Tentakel"
  },
  State_3449_Desc = {
    Text = "Status@PrologWahnsinn0_1_1Aktiv"
  },
  State_3449_Name = {
    Text = "Status@PrologWahnsinn0_1_1Aktiv"
  },
  State_3449_WeaponDesc = {
    Text = "Status@PrologWahnsinn0_1_1Aktiv"
  },
  State_3450_Desc = {
    Text = "Beim Erleiden von Aktivem Schaden oder Tentakelschaden wird der Schaden ignoriert und 1 Stapelung entfernt."
  },
  State_3450_Name = {
    Text = "<ParcloseIconKeywords: Barriere>"
  },
  State_3450_WeaponDesc = {
    Text = "Erlittener Schaden –99%. Nach dem Erleiden von Schaden wird 1 Stapelung verloren."
  },
  State_3451_Desc = {
    Text = "Beim Tod erhalten alle Erwachten 10 Wahnsinn"
  },
  State_3451_Name = {
    Text = "Sterbende Silberschuppen"
  },
  State_3451_WeaponDesc = {
    Text = "Beim Tod erhalten alle Erwachten 10 Wahnsinn"
  },
  State_3452_Desc = {
    Text = "Bei jeder gespielten Karte, erleide [StateArg1] Schaden und entferne 1 Schicht. Wenn am Rundenende noch vorhanden, brüte ein „Meereswesen“ aus, erhöhe pro Schicht Leben um 10%"
  },
  State_3452_Name = {
    Text = "Abgrundessenz"
  },
  State_3453_Name = {
    Text = "Status@RacheKlingeKraftMultiplikator"
  },
  State_3455_Desc = {
    Text = "Status@PrologWahnsinnInitialisierung0_2_3Effekt"
  },
  State_3455_Name = {
    Text = "Status@PrologWahnsinnInitialisierung0_2_3Effekt"
  },
  State_3455_WeaponDesc = {
    Text = "Status@PrologWahnsinnInitialisierung0_2_3Effekt"
  },
  State_3456_Desc = {
    Text = "[VERT] erhält [StateArg1] Schichten Theke"
  },
  State_3456_Name = {
    Text = "Schöpfung Brennnesselweste"
  },
  State_3457_Name = {
    Text = "Immunität gegen Verwundbarkeit"
  },
  State_3458_Desc = {
    Text = "Nachdem du [ANG] und [VERT] gespielt hast, erhält der entsprechende Erwecker 35 Aelius. Aber ihre Arithmetica Kosten erhöhen sich um 1"
  },
  State_3459_Desc = {
    Text = "In diesem Kampf wird der durch Exaltieren verursachte Schaden um [Layer] Punkte erhöht"
  },
  State_3459_Name = {
    Text = "Wutanfall-Schaden erhöht"
  },
  State_3461_Desc = {
    Text = "Der fünfte Schaden, den du verursachst, ist immer ein kritischer Treffer"
  },
  State_3462_Name = {
    Text = "Status@RacheKlingeKraftMultiplikator3"
  },
  State_3463_Name = {
    Text = "Status@RacheKlingeKraftMultiplikator2"
  },
  State_3464_Desc = {
    Text = "Tentakel-Limit erhöht sich um 1. Wenn die Gesundheit unter 50% liegt, erhöht sich der Tentakelschaden um [Arg1]."
  },
  State_3465_Desc = {
    Text = "Diese Karte wird im Kampf mitgeführt, im Level wirksam"
  },
  State_3465_Name = {
    Text = "<CardKeyWord:Unendlich>"
  },
  State_3465_WeaponDesc = {
    Text = "Diese Karte kann im Kampf mitgeführt werden, im Level wirksam"
  },
  State_3466_Desc = {
    Text = "Beim Aufheben wählt man einen Erwecker und erweckt ihn, die Zugkosten seiner Erweckungskarte werden permanent um 1 gesenkt"
  },
  State_34671_Desc = {
    Text = "Nach dem Ausspielen kehrt es auf die Hand zurück"
  },
  State_34671_Name = {
    Text = "<CardKeyWord:Rückkehr>"
  },
  State_34685_Name = {
    Text = "Bombe 2 Spieler"
  },
  State_34689_Desc = {
    Text = "Bei jedem Verlust von 1 Punkt Leben erhält man 1 Schicht <PainWord:Geduld>, bis zu 100 % der maximalen Gesundheit. Die Geduld wird in den nächsten Kampf übernommen."
  },
  State_34689_Name = {
    Text = "<CardKeyWord:erdulden>"
  },
  State_3468_Desc = {
    Text = "Status@MinderwertigeRache"
  },
  State_3468_Name = {
    Text = "Status@MinderwertigeRache"
  },
  State_3468_WeaponDesc = {
    Text = "Status@MinderwertigeRache"
  },
  State_34691_Desc = {
    Text = "Beim Verlust von 1 Punkt LP erhält man 1 Stapelung <PainWord:Ausdauer>. Maximal [DescArg1] Stapelungen. Ausdauer wird in den nächsten Kampf übernommen."
  },
  State_34691_Name = {
    Text = "<CardKeyWord:erdulden>"
  },
  State_34696_Desc = {
    Text = "Diese Karte bleibt immer in der Hand und erhöht das Handkartenlimit um +1"
  },
  State_34696_Name = {
    Text = "Permanent beibehalten und Handkartenlimit ignorieren"
  },
  State_3469_Desc = {
    Text = "Gesamter ausgeteilter Aktiver Schaden und Tentakelschaden –[DescArg1]%."
  },
  State_3469_Name = {
    Text = "<WeaknessColour:Schwäche>"
  },
  State_3469_WeaponDesc = {
    Text = "Verursachter Gesamtschaden um [DescArg1] % reduziert"
  },
  State_3470_Desc = {
    Text = "Fügt allmähliche Versteinerungserkennung hinzu"
  },
  State_3470_Name = {
    Text = "Fügt allmähliche Versteinerungserkennung hinzu"
  },
  State_3470_WeaponDesc = {
    Text = "Fügt allmähliche Versteinerungserkennung hinzu"
  },
  State_3471_Desc = {
    Text = "Die [StateArg1] Karte, die du spielst, hat eine doppelte Wirkung"
  },
  State_3471_Name = {
    Text = "Sternenwein-Zählung"
  },
  State_3471_WeaponDesc = {
    Text = "Die [StateArg1] Karte, die du spielst, hat eine doppelte Wirkung"
  },
  State_3473_Desc = {
    Text = "Wenn das Leben unter 50% fällt, wird der „Laternen-Pastor“ um „Göttliches Herabkommen“ beten, um alle Gläubigen zu absorbieren und in Wut zu entflammen"
  },
  State_3473_Name = {
    Text = "Brand der Lunte"
  },
  State_3473_WeaponDesc = {
    Text = "Wenn das Leben unter 50% fällt, wird der „Laternen-Pastor“ um „Göttliches Herabkommen“ beten, um alle Gläubigen zu absorbieren und in Wut zu entflammen"
  },
  State_3475_Desc = {
    Text = "[ANG] und [VERT] Arithmetica Kosten +1"
  },
  State_3475_Name = {
    Text = "Fluchstein der Schöpfung"
  },
  State_3475_WeaponDesc = {
    Text = "[ANG] und [VERT] Arithmetica Kosten +1"
  },
  State_3476_Desc = {
    Text = "Immer wenn du Gesundheit verlierst, erhöht sich die Embryo-Fusion um 10%. Wenn die Gesundheit unter 50% sinkt, verdoppelt sich der Effekt"
  },
  State_3477_Desc = {
    Text = "Stellt beim Angriff [Layer] LP wieder her; wird betäubt und dieser Zustand wird entfernt, wenn der Schaden 15% der Max LP übersteigt"
  },
  State_3477_Name = {
    Text = "Obsidianschlund"
  },
  State_3478_Name = {
    Text = "Zustand @ Schmuck Standard Bündnis"
  },
  State_3479_Desc = {
    Text = "Bei jeder Ausgabe von 1 schwarzen Siegel erhalten alle Erwecker 1 Punkt Aelius"
  },
  State_3479_Name = {
    Text = "Schöpfungs-Gegenblüte"
  },
  State_3479_WeaponDesc = {
    Text = "Bei jeder Ausgabe von 1 schwarzen Siegel erhalten alle Erwecker 1 Punkt Aelius"
  },
  State_3480_Desc = {
    Text = "Bis zum Ende der Runde sinkt das Leben nicht auf 0"
  },
  State_3480_Name = {
    Text = "Das Perlen-Ei stirbt nicht"
  },
  State_3480_WeaponDesc = {
    Text = "Bis zum Ende der Runde sinkt das Leben nicht auf 0"
  },
  State_3481_Desc = {
    Text = "Zu Beginn des Levels verdoppeln sich deine Todeswiderstandrate und Glücks-Siegelrate"
  },
  State_3481_Name = {
    Text = "Status@TraumSilberschlüssel:DoppeltesGlück"
  },
  State_3482_Desc = {
    Text = "Verwundbarkeitseffekt um 25 % erhöht. Alle 3 Runden 1 Schicht Verwundbarkeit auf alle Feinde"
  },
  State_3483_Desc = {
    Text = "Jede Aktion fügt Bluten hinzu, das Heilen kann die Blutenwirkung entfernen"
  },
  State_3483_Name = {
    Text = "Schwere Verletzung"
  },
  State_3483_WeaponDesc = {
    Text = "Jede Aktion fügt Bluten hinzu, das Heilen kann die Blutenwirkung entfernen"
  },
  State_3484_Desc = {
    Text = "Beim Verursachen von tatsächlichem Schaden erhält man Kraft"
  },
  State_3484_Name = {
    Text = "“Verwirrte Persönlichkeit“"
  },
  State_3485_Desc = {
    Text = "Status@LaternenRitualAktiv"
  },
  State_3485_Name = {
    Text = "Status@LaternenRitualAktiv"
  },
  State_3485_WeaponDesc = {
    Text = "Status@LaternenRitualAktiv"
  },
  State_3486_Name = {
    Text = "Vorherbestimmter Schlag"
  },
  State_3488_Desc = {
    Text = "Beim Ausspielen der Karte erleide [StateArg1] Schaden und entferne 1 Schicht. Wenn die Schichten auf 0 sind, schlüpft ein schwächeres „Wesen des Meeres“. Wenn der parasitäre Zustand am Ende des Zuges noch besteht, schlüpft ein „Wesen des Meeres“ mit Leben entsprechend der Schichten"
  },
  State_3488_Name = {
    Text = "Mehrfach parasitiert"
  },
  State_3489_Name = {
    Text = "Am Ende der Runde, wenn in der Hand oder im <DimensionalSpaceIconKeywords:Dimensionsraum>, upgrade zu „Verfallenes grünes Feuer“"
  },
  State_3489_WeaponDesc = {
    Text = "Am Ende der Runde, wenn sich im Handkarten oder in der ultra Dimension, erhält man Verstärkungen"
  },
  State_3490_Desc = {
    Text = "Beim Ausspielen der Karte erleide [StateArg1] Schaden und entferne 1 Schicht. Wenn die Schichten auf 0 sind, schlüpft ein schwächeres „Wesen des Meeres“. Wenn der parasitäre Zustand am Ende des Zuges noch besteht, schlüpft ein „Wesen des Meeres“ mit Leben entsprechend der Schichten"
  },
  State_3490_Name = {
    Text = "Wieder parasitiert"
  },
  State_3492_Desc = {
    Text = "Jede gerade Runde reduziert die Kraft unseres Teams um [Layer]"
  },
  State_3492_Name = {Text = "Abwehr"},
  State_3495_Desc = {
    Text = "Jede Aktion fügt [Layer] Bluten hinzu"
  },
  State_3495_Name = {
    Text = "Schwere Verletzung"
  },
  State_3495_WeaponDesc = {
    Text = "Jede Aktion fügt [Layer] Bluten hinzu, das Heilen kann die Blutenwirkung entfernen"
  },
  State_34964_Desc = {
    Text = "Zu Beginn der Runde erhält man <PainWord:erdulden> in Höhe von 10 % der maximalen Gesundheit."
  },
  State_34964_Name = {
    Text = "Nie vergessen"
  },
  State_3496_Name = {
    Text = "Am Ende der Runde, wenn in der Hand oder im <DimensionalSpaceIconKeywords:Dimensionsraum>, upgrade zu „Todesgrünes Feuer“"
  },
  State_3496_WeaponDesc = {
    Text = "Am Ende der Runde, wenn sich im Handkarten oder in der ultra Dimension, erhält man Verstärkungen"
  },
  State_3497_Desc = {
    Text = "Wenn das Team aus Erwachten verschiedener Klassen besteht, erhöhen sich Teamgesundheit sowie ANG und VERT aller Erwachten um 200%"
  },
  State_3497_Name = {Text = "Mischbonus"},
  State_3497_WeaponDesc = {
    Text = "Wenn das Team aus Erwachten verschiedener Klassen besteht, erhöhen sich Teamgesundheit sowie ANG und VERT aller Erwachten um 200%"
  },
  State_3499_Desc = {
    Text = "Einzigartig im Team: Die von dem Ausrüster erzeugte Raserei erhöht sich um <WeaponEffect_Num:[StateArg1]%>. Nachdem der Ausrüster die Raserei freigesetzt hat, erhält er <WeaponEffect_Num:[StateArg2]> Punkte Silberenergie."
  },
  State_3499_WeaponDesc = {
    Text = "Die von dem Ausrüster erzeugte Wahnsinn erhöht sich um <WeaponEffect_Num:[StateArg1]%>. Nachdem der Ausrüster die Wahnsinn freigesetzt hat, erhält er <WeaponEffect_Num:[StateArg2]> Punkte s-Energie."
  },
  State_3502_Desc = {
    Text = "Der durch den Ausrüster verursachte Schaden, Schild und die Heilung erhöhen sich um [StateArg1]% (temporär)"
  },
  State_3502_Name = {
    Text = "Status@Prototyp Messer Wahnsinn"
  },
  State_3504_Desc = {
    Text = "Zu Beginn jeder Runde [StateArg1] Karten ziehen"
  },
  State_3504_Name = {
    Text = "Schöpfung Richtkompass"
  },
  State_3504_WeaponDesc = {
    Text = "Zu Beginn jeder Runde [StateArg1] Karten ziehen"
  },
  State_3507_Name = {
    Text = "Schmuckstück Organische Form"
  },
  State_3507_WeaponDesc = {
    Text = "Nach der Nutzung der Wahnsinnsexplosion werden die Schutzschilde und die Heilungskraft des Ausrüstenden in dieser Runde verdoppelt"
  },
  State_3508_Name = {
    Text = "Schmuckstück Mädchenkokon"
  },
  State_3508_WeaponDesc = {
    Text = "Nach Kampfbeginn, wenn der Träger Chaos-Klasse ist, +25% ANGskraft"
  },
  State_3510_Desc = {
    Text = "Erweckungskörper-Schild um [Layer] Punkte erhöht"
  },
  State_3510_Name = {
    Text = "<AlertColour: Alarm>"
  },
  State_3511_Desc = {
    Text = "Der durch den Ausrüster verursachte Schaden, Schild und die Heilung erhöhen sich um [StateArg1]% (temporär)"
  },
  State_3511_Name = {
    Text = "Status@Prototyp Langschwert Glück"
  },
  State_35120_Desc = {
    Text = "Für jede erlittene Instanz von Aktivem Schaden wird dem Angreifer [StateArg1] <plural value=\"[Poison:StateArg1]\" singular=\"Stapelung\" plural=\"Stapelungen\"> Gift zugefügt, für [Layer] <plural value=\"[Layer]\" singular=\"Runde\" plural=\"Runden\">."
  },
  State_35120_Name = {
    Text = "Unsterbliche Blume im Schleim"
  },
  State_3512_Name = {
    Text = "Temporäre Immunität verwundbar"
  },
  State_3514_Desc = {
    Text = "Am Zugende erleidet das Ziel <FixedDamage:Reinen SCH> in Höhe der Anzahl der Stapelungen und dieser Status wird entfernt."
  },
  State_3514_Name = {
    Text = "<BleedingIconKeywords: Bluten>"
  },
  State_3514_WeaponDesc = {
    Text = "Zu Beginn der Runde erleidest du Schaden"
  },
  State_35158_Name = {
    Text = "Zeitpendel „Trance\""
  },
  State_3515_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_3515_Name = {
    Text = "Nicht erweckt"
  },
  State_35161_Name = {
    Text = "Zeitpendel „Ersparnisse\""
  },
  State_3516_Name = {
    Text = "Status@Fluch Niedergeschlagenheit"
  },
  State_3518_Desc = {
    Text = "Für jede ausgespielte Karte erhält der Mystiker [StateArg2] temporäre Kraft"
  },
  State_3518_Name = {Text = "Erster Akt"},
  State_3519_Desc = {
    Text = "Auch außerhalb der Hyperdimension kann pro Runde ein Sprungeffekt ausgelöst werden"
  },
  State_3519_Name = {
    Text = "Raumverbieger"
  },
  State_3519_WeaponDesc = {
    Text = "Auch außerhalb der Hyperdimension kann pro Runde ein Sprungeffekt ausgelöst werden"
  },
  State_3520_Desc = {
    Text = "Zu Beginn des Kampfes wähle einen Erwachten und gib ihm 50 Wahnsinn"
  },
  State_35228_Name = {
    Text = "Zeitpendel „Ersparnisse\""
  },
  State_3522_Name = {
    Text = "Relikt Dreizack Zähler"
  },
  State_35238_Desc = {
    Text = "Einzigartig im Team: Schilde und Vergiftung des Ausrüsters erhöhen sich um <WeaponEffect_Num:[StateArg1]%>. Bei Auslösung des Todeswiderstands erhalten alle Erwachten <WeaponEffect_Num:[StateArg2]%> temporäre kritische Trefferquote und kritischen Schaden."
  },
  State_35238_WeaponDesc = {
    Text = "Der Ausrüstende verursacht eine Erhöhung des Schutzschilds und der Vergiftung um <WeaponEffect_Num:[StateArg1]%>. Jedes Mal, wenn der Todeswiderstand ausgelöst wird, erhalten alle Erwecker <WeaponEffect_Num:[StateArg2]%> temporäre kritische Rate und kritischen Schaden"
  },
  State_3523_Desc = {
    Text = "Nach dem Ausspielen werden alle Feinde für [StateArg1] Runden geschwächt"
  },
  State_3523_Name = {
    Text = "<Rune_2_High:Fortgeschrittene Schwäche>"
  },
  State_3524_Desc = {
    Text = "Erhöhter Schaden um [Layer] Punkte"
  },
  State_3524_Name = {
    Text = "Fusionswunde"
  },
  State_3524_WeaponDesc = {
    Text = "Erhöhter Schaden um [Layer] Punkte"
  },
  State_3525_Desc = {
    Text = "Unser Team erhält bei jeder gespielten Karte 2 Schichten [Fessel]"
  },
  State_3525_Name = {
    Text = "Ostbezirk-Spezialität"
  },
  State_3525_WeaponDesc = {
    Text = "Unser Team erhält bei jeder gespielten Karte 2 Schichten [Fessel]"
  },
  State_35264_Desc = {
    Text = "In dieser Runde erhält der „Zauberer“ für jede gespielte Karte 1 Schicht Phantasma"
  },
  State_35264_Name = {
    Text = "Formwechsel-Aufzeichnung"
  },
  State_35277_Name = {
    Text = "Casiahs magische Abwehr"
  },
  State_3527_Desc = {
    Text = "Der erste gespielte Befehlskarte-Wächter jeder Runde erhält am Rundenende 15 Wahnsinn. Wenn du „Hingabe“ hast, erhalten andere Wächter 5 Wahnsinn"
  },
  State_3528_Desc = {
    Text = "Der durch den Ausrüster verursachte Schaden, Schild und die Heilung erhöhen sich um [StateArg1]% (temporär)"
  },
  State_3528_Name = {
    Text = "Status@Prototyp Laserkanone Domäne"
  },
  State_3529_Desc = {
    Text = "Immun gegen jeglichen Schaden, nach Rundenbeginn entfernt"
  },
  State_3529_Name = {
    Text = "Schaden immun"
  },
  State_3530_Desc = {
    Text = "Zustand @ glücklicher Ermittler all-in Kennzeichen 8"
  },
  State_3530_Name = {
    Text = "Zustand @ glücklicher Ermittler all-in Kennzeichen 8"
  },
  State_3530_WeaponDesc = {
    Text = "Zustand @ glücklicher Ermittler all-in Kennzeichen 8"
  },
  State_3531_Desc = {
    Text = "Team Unique: Zu Beginn des Kampfes erhält der Ausrüster <WeaponEffect_Num:[StateArg1]> Wahnsinn. Jedes Mal, wenn andere Erwecker die Verherrlichung freisetzen, erhält der Ausrüster <WeaponEffect_Num:[StateArg2]> Wahnsinn. Wenn das aktuelle Reich “Aequor“ ist, erhält der Ausrüster nach der Freisetzung der Verherrlichung Tentakelschaden in Höhe von <WeaponEffect_Num:[StateArg3]%> seiner ANGskraft."
  },
  State_3531_WeaponDesc = {
    Text = "Beim Kampfbeginn erhält der Träger <WeaponEffect_Num:[StateArg1]> Aelius. Wenn andere Erwecker exaltieren, erhält der Träger <WeaponEffect_Num:[StateArg2]> Aelius. Wenn das aktuelle Reich „Aequor“ ist, nach Exaltieren des Trägers, Tentakelschaden <WeaponEffect_Num:+[DescArg1]>"
  },
  State_3532_Desc = {
    Text = "Zu Rundenbeginn erhalten Sie [StateArg1] Arithmetica"
  },
  State_3532_Name = {
    Text = "Schwarze Kerze der Schöpfung 1"
  },
  State_3533_Desc = {
    Text = "Muss in der Starthand erscheinen"
  },
  State_3533_Name = {
    Text = "<GuyouKeywords:Eigen>"
  },
  State_3533_WeaponDesc = {
    Text = "Zu Beginn des Kampfes bleibt diese Karte in der Hand"
  },
  State_3535_Desc = {
    Text = "Die Arithmetica der Karte verbraucht zusätzliche [Layer] Punkte. Dieser negative Effekt wird am Ende der Runde oder nach dem Ausspielen der Karte entfernt."
  },
  State_3535_Name = {
    Text = "<SlowColour:Vorübergehende Langsamkeit [Layer]>"
  },
  State_3535_WeaponDesc = {
    Text = "Die Arithmetica der Karte verbraucht zusätzliche [Layer] Punkte"
  },
  State_3536_Name = {
    Text = "In Bosskämpfen 3 Mal verwendbar"
  },
  State_3537_Desc = {
    Text = "Erhalte eine Gravur, wenn du \"Naives Geschenk\" erhältst"
  },
  State_3537_Name = {
    Text = "Status@Kapitel 1 Resonanz 4"
  },
  State_3537_WeaponDesc = {
    Text = "Erhalte eine Gravur, wenn du \"Naives Geschenk\" erhältst"
  },
  State_3538_Desc = {
    Text = "Verwende „Naives Geschenk“ zur Wahnsinnsregeneration"
  },
  State_3538_Name = {
    Text = "Status@Kapitel 1 Resonanz 1"
  },
  State_3538_WeaponDesc = {
    Text = "Verwende „Naives Geschenk“ zur Wahnsinnsregeneration"
  },
  State_3539_Desc = {
    Text = "“Naive Rückgabe” Verbrauch der Rechenleistung reduziert um 1"
  },
  State_3539_Name = {
    Text = "Status@Kapitel 1 Resonanz 3"
  },
  State_3539_WeaponDesc = {
    Text = "“Naive Rückgabe” Verbrauch der Rechenleistung reduziert um 1"
  },
  State_3540_Desc = {
    Text = "“Naives Geschenk” kann Ziel bestimmen"
  },
  State_3540_Name = {
    Text = "Status@Kapitel 1 Resonanz 2"
  },
  State_3540_WeaponDesc = {
    Text = "“Naives Geschenk” kann Ziel bestimmen"
  },
  State_3541_Desc = {
    Text = "Kum fiel in eure Falle"
  },
  State_3541_Name = {
    Text = "in der Falle sitzen"
  },
  State_3542_Desc = {
    Text = "Zu Beginn des Kampfes erhält man für jede 1 Orison im Deck [Arg1] Punkte Macht, für jede 1 Relikt wird [Arg2] Punkte Leben wiederhergestellt"
  },
  State_3542_Name = {
    Text = "☆Gildenmedaille☆"
  },
  State_3545_Name = {
    Text = "Unendliche Sternenpracht Widerstand"
  },
  State_3545_WeaponDesc = {
    Text = "Für jede ausgespielte Karte erhält man [StateArg1]% Widerstand gegen den Tod. Bei Erhalt des Todeswiderstands, erhält man [StateArg2] Leben zurück"
  },
  State_3546_Desc = {
    Text = "Unser Team erhält bei jeder gespielten Karte [Layer] Schichten [Fessel]"
  },
  State_3546_Name = {
    Text = "Ostbezirk-Spezialität"
  },
  State_3546_WeaponDesc = {
    Text = "Unser Team erhält bei jeder gespielten Karte [Layer] Schichten [Fessel]"
  },
  State_3547_Desc = {
    Text = "Unser Team erhält bei jeder gespielten Karte [Layer] Schichten [Fessel]"
  },
  State_3547_Name = {
    Text = "Ostbezirk-Spezialität"
  },
  State_3547_WeaponDesc = {
    Text = "Unser Team erhält bei jeder gespielten Karte [Layer] Schichten [Fessel]"
  },
  State_3548_Desc = {
    Text = "Beim Ziehen bist du für 1 Runde geschwächt. Nach der Benutzung werden alle Gegner für 1 Runde geschwächt. Nicht verkäuflich"
  },
  State_3548_Name = {
    Text = "Status Fluch Schwäche"
  },
  State_3548_WeaponDesc = {
    Text = "Beim Ziehen bist du für 1 Runde geschwächt. Nach der Benutzung werden alle Gegner für 1 Runde geschwächt. Nicht verkäuflich"
  },
  State_3549_Name = {
    Text = "Zustand Schmuck Steppenwolf"
  },
  State_3549_WeaponDesc = {
    Text = "Der Ausrüstende verursacht eine Erhöhung des Grundschadens um 10%. Wenn der Schaden des Ausrüstenden stark mehr als 20% beträgt, erhöht sich der Grundschaden zusätzlich um 10%"
  },
  State_35503_Name = {
    Text = "Zeitpendel „Ausbreitung\""
  },
  State_3551_Desc = {
    Text = "Zu Rundenbeginn, wenn die Anzahl der verbleibenden Handkarten aus der letzten Runde größer ist als [StateArg1], erhalten Sie [StateArg2] Punkte Arithmetica"
  },
  State_3551_Name = {
    Text = "Silberne Differenzmaschine der Schöpfung"
  },
  State_3551_WeaponDesc = {
    Text = "Zu Rundenbeginn, wenn die Anzahl der verbleibenden Handkarten aus der letzten Runde größer ist als [StateArg1], erhalten Sie [StateArg2] Punkte Arithmetica"
  },
  State_35539_Desc = {
    Text = "Schaden verdoppelt, dauert [Layer] Runden"
  },
  State_35539_Name = {
    Text = "Überreste des Pfadläufers"
  },
  State_3553_Desc = {
    Text = "Kritische Rate erhöht um 25%. Nach einer Gesundheitswiederherstellung besteht die Chance, zusätzlich 1 Gesundheitswiederherstellung auszulösen, die Wahrscheinlichkeit entspricht der kritischen Rate des Wiederherstellers"
  },
  State_3553_Name = {
    Text = "Zustand @ Illusionssilberschlüssel: kritisches Heilen"
  },
  State_3554_Desc = {
    Text = "Schild und Heilungseffekte um [Layer] % erhöhen"
  },
  State_3554_Name = {
    Text = "Schild und Heilung verstärkt"
  },
  State_3554_WeaponDesc = {
    Text = "Schild und Heilungseffekte um [Layer] % erhöhen"
  },
  State_3555_Desc = {
    Text = "Nach dem Aufheben erhält man 100% Todeswiderstand. Nach dem Auslösen des Todeswiderstands werden zu Beginn jeder Runde in diesem Kampf [Arg1] Lebenspunkte wiederhergestellt"
  },
  State_3555_Name = {
    Text = "Lebenshauch"
  },
  State_3556_Desc = {
    Text = "Beim Aufheben dieses Artefakts wählt man eine Karte und fügt eine Kopie davon dem Deck hinzu"
  },
  State_3558_Desc = {
    Text = "Zu Rundenbeginn, wenn das schwarze Siegel größer als 10 ist, verbrauchen Sie 10 schwarze Siegel, und der in dieser Runde verursachte Schaden wird verdoppelt"
  },
  State_3559_Desc = {
    Text = "Beim Verursachen von ungeblocktem Schaden wird 1 Schicht Zerbrechlich verursacht."
  },
  State_3559_Name = {Text = "Klauen"},
  State_3559_WeaponDesc = {
    Text = "Beim Verursachen von echtem Schaden, mische [StateArg1] Wunden-Karten in den Ziehstapel"
  },
  State_3561_Name = {
    Text = "Status@TraumSilberschlüssel:WilderSchlagZählen"
  },
  State_3562_Desc = {
    Text = "Nach dem Tod, Stärke anderer Verbündeter +[Layer]"
  },
  State_3562_Name = {
    Text = "Todessprache"
  },
  State_35635_Name = {
    Text = "Zustand @ Erwecker Casiah Telekinese erlaubt aktive Auslösung"
  },
  State_35636_Name = {
    Text = "Zustand @ Erwecker Casiah fügt Telekinese hinzu"
  },
  State_3563_Desc = {
    Text = "Beim Verursachen von unblockiertem Schaden, mische [StateArg1] Wunden-Karten in den Ziehstapel"
  },
  State_3563_Name = {Text = "Klinge"},
  State_3563_WeaponDesc = {
    Text = "Beim Verursachen von echtem Schaden, mische [StateArg1] Wunden-Karten in den Ziehstapel"
  },
  State_35645_Desc = {
    Text = "Die Anzahl der gezogenen Karten in dieser Runde reduziert sich um [Layer]"
  },
  State_35645_Name = {
    Text = "Ziehen verringern"
  },
  State_35646_Desc = {
    Text = "Die Anzahl der gezogenen Karten in dieser Runde reduziert sich um [Layer]"
  },
  State_35646_Name = {
    Text = "Ziehen verringern"
  },
  State_3564_Desc = {
    Text = "Nach dem Ausspielen erhaltet ihr [StateArg1] Punkte temporäre Stärke, die Karte erhält ebenfalls den Stärkebonus"
  },
  State_3564_Name = {
    Text = "<Rune_15_High:Hochexplosion>"
  },
  State_3565_Desc = {
    Text = "Wenn der Bildhauer einen Schild anlegt, erhöht sich der Tentakelschaden um [StateArg1]"
  },
  State_3565_Name = {
    Text = "Reich der Vergessenheit"
  },
  State_3565_WeaponDesc = {
    Text = "Wenn der Bildhauer einen Schild anlegt, erhöht sich der Tentakelschaden um [StateArg1]"
  },
  State_3566_Desc = {
    Text = "Zu Rundenbeginn erhalten Sie 3 temporäre Macht; die Wahnsinnsexplosion verdoppelt diese temporäre Macht, maximal 2 Mal stapelbar"
  },
  State_3566_Name = {
    Text = "Schöpfung Schlangenhaut"
  },
  State_3567_Desc = {
    Text = "Der durch den Ausrüster verursachte Schaden, Schild und die Heilung erhöhen sich um [StateArg1]% (temporär)"
  },
  State_3567_Name = {
    Text = "Status@Prototyp Laserkanone Kritisch"
  },
  State_35684_Desc = {
    Text = "Nachdem unser Team die Wutexplosion freigesetzt hat, verliert es in dieser Runde die Macht. Einmal pro Runde"
  },
  State_35684_Name = {
    Text = "Furcht vor Wahn"
  },
  State_35685_Desc = {
    Text = "Beim Auslösen des Ursprungs wird die temporäre Macht des Feindes gesenkt"
  },
  State_35685_Name = {
    Text = "Furcht vor Wahn"
  },
  State_3568_Desc = {
    Text = "Wenn Ramona Schaden verursacht, erhält sie [StateArg1] Punkte Arithmetica"
  },
  State_3568_Name = {
    Text = "Erste Doktrine"
  },
  State_3568_WeaponDesc = {
    Text = "Wenn Ramona Schaden verursacht, erhält sie [StateArg1] Punkte Arithmetica"
  },
  State_3570_Name = {
    Text = "Zu Beginn der nächsten Runde +2 Karten ziehen"
  },
  State_3571_Name = {
    Text = "Temporäre Immunität gegen Schwäche"
  },
  State_3572_Desc = {
    Text = "Der Schaden seiner beschworenen Monster verdoppelt sich"
  },
  State_3572_Name = {
    Text = "Befehlshaber"
  },
  State_3572_WeaponDesc = {
    Text = "Der Schaden seiner beschworenen Monster verdoppelt sich"
  },
  State_3573_Desc = {
    Text = "Der erste erlittene Schaden jeder Runde wird verfünffacht"
  },
  State_3573_Name = {Text = "Stolz"},
  State_3573_WeaponDesc = {
    Text = "Der erste erlittene Schaden jeder Runde wird verdoppelt"
  },
  State_3574_Desc = {
    Text = "Jedes Mal, wenn dieselbe Karte eines Erwachens nacheinander gespielt wird, erhält das Erwachen 10 Wahnsinn"
  },
  State_35768_Name = {
    Text = "Erhalte 300 Punkte s-Energie"
  },
  State_35769_Name = {
    Text = "Erhalte 1 Punkt Arithmetica"
  },
  State_35770_Name = {
    Text = "Vertreibe <IntoxicationIconKeywords:Vergiftung>, Versiegelung und <SlowIconKeywords:Verlangsamung> von dir selbst"
  },
  State_35771_Name = {
    Text = "Erhalte [DescArg1]% (<Block:[DescArg2]>) Schild von maximaler Gesundheit"
  },
  State_35772_Name = {
    Text = "In Bosskämpfen [StateArg1] Mal zusätzlich verwendbar"
  },
  State_35774_Desc = {
    Text = "Vor dem Tod einmal um die Hilfe von Celeste rufen, um alle Gesundheit, Wahnsinn und s-Energie wiederherzustellen"
  },
  State_35774_Name = {
    Text = "Utopischer Schleier"
  },
  State_3577_Name = {
    Text = "Steigerung der automatischen Wutregeneration"
  },
  State_35809_Desc = {
    Text = "Verursachter Schaden um [StateArg1] % reduziert, für [Layer] Runden."
  },
  State_35809_Name = {
    Text = "Erbe der Täuschung"
  },
  State_35809_WeaponDesc = {
    Text = "Status@Tiefsee-Dame Tee und Kuchen"
  },
  State_3580_Desc = {
    Text = "[Layer] Tentakelschaden in dieser Runde ist Pannenschaden"
  },
  State_3580_Name = {
    Text = "Durchstechen Tentakel"
  },
  State_35811_Desc = {
    Text = "Beim Erleiden von Aktivem Schaden oder Tentakelschaden wird die Hälfte des Schadens als <SacrificeKeyWord:Opfergabe> für [Layer] <plural value=\"[Layer]\" singular=\"Runde\" plural=\"Runden\"> gewährt."
  },
  State_35811_Name = {
    Text = "Erbe der Täuschung"
  },
  State_35819_Desc = {
    Text = "Am Ende der Runde erhält Murphy 5 Punkte Wahnsinn. Nach der Entfaltung des Bande wird 2% der maximalen Gesundheit entfernt <SacrificeKeyWord:Opfer>"
  },
  State_35819_Name = {
    Text = "Schwarzer Tee und Kuchen"
  },
  State_3581_Desc = {
    Text = "Status@Rote Dame Macht Tanz Zählung"
  },
  State_3581_Name = {
    Text = "Status@Rote Dame Macht Tanz Zählung"
  },
  State_3582_Desc = {
    Text = "Auch außerhalb der Hyperdimension kann pro Runde ein Sprungeffekt ausgelöst werden. Ziehe eine Karte des entsprechenden Erwachten"
  },
  State_3582_Name = {
    Text = "Veränderter Raumverzerrer"
  },
  State_3582_WeaponDesc = {
    Text = "Auch außerhalb der Hyperdimension kann pro Runde ein Sprungeffekt ausgelöst werden. Ziehe eine Karte des entsprechenden Erwachten"
  },
  State_3584_Desc = {
    Text = "Der durch den Ausrüster verursachte Schaden, Schild und die Heilung erhöhen sich um [StateArg1]% (temporär)"
  },
  State_3584_Name = {
    Text = "Status@Prototyp Messer Domäne"
  },
  State_35858_Desc = {
    Text = "Nach Rundenende +5 Wahnsinn für Murphy. Nach Schlüsselbefehl +Tentakelschaden von 3% Murphys ANG"
  },
  State_35858_Name = {
    Text = "Schwarzer Tee und Kuchen"
  },
  State_3585_Desc = {
    Text = "Wenn das Leben unter 50% ([StateArg1]) fällt, wird der „Laternen-Pastor“ um „Göttliches Herabkommen“ beten, um alle Gläubigen zu absorbieren und in Wut zu entflammen"
  },
  State_3585_Name = {
    Text = "Brand der Lunte"
  },
  State_3585_WeaponDesc = {
    Text = "Wenn das Leben unter 50% ([StateArg1]) fällt, wird der „Laternen-Pastor“ um „Göttliches Herabkommen“ beten, um alle Gläubigen zu absorbieren und in Wut zu entflammen"
  },
  State_3588_Name = {
    Text = "Arithmetica der Schöpfungsarkana Relikt"
  },
  State_3589_Desc = {
    Text = "Beim Erleiden von Aktivem Schaden oder Tentakelschaden wird der Schaden ignoriert und 1 Stapelung verloren."
  },
  State_3589_Name = {
    Text = "<ParcloseColour: Barriere>"
  },
  State_3591_Desc = {
    Text = "Team Unique: Der <RetaliateIconKeywords:Zähler> des Ausrüsters +<WeaponEffect_Num:[StateArg1]%>. „Verteidigung“ gewährt einen vorübergehenden Zähler in Höhe der VERT des Ausrüsters ×<WeaponEffect_Num:[StateArg2]%>. In Anführer Kämpfen wird dies zum 3-fachen des vorübergehenden Zählers. Nachdem Todwiderstand ausgelöst wird, wird [StateArg3]% <RetaliateIconKeywords:Zähler> gegen alle Feinde ausgelöst."
  },
  State_3591_Name = {
    Text = "In der Nacht lauernd"
  },
  State_3591_WeaponDesc = {
    Text = "<RetaliateIconKeywords:Zähler> des Ausrüsters +<WeaponEffect_Num:[StateArg1]%>. Nach dem Spielen der „Verteidigung“ des Ausrüsters werden <WeaponEffect_Num:[Counterattack:DescArg1]> Stapelungen vorübergehenden Zählers erhalten. In Anführer Kämpfen wird dies zum 3-fachen des vorübergehenden Zählers. Nachdem Todwiderstand ausgelöst wird, wird [StateArg3]% <RetaliateIconKeywords:Zähler> gegen alle Feinde ausgelöst."
  },
  State_3592_Desc = {
    Text = "Erhöhe den Schaden der Tentakeln"
  },
  State_3592_Name = {
    Text = "<TentacleInjurieIconKeywords:Tentakelschaden>"
  },
  State_3592_WeaponDesc = {
    Text = "Schaden durch Tentakel erhöht"
  },
  State_3593_Desc = {
    Text = "Team Unique: Der vom Ausrüster verursachte <IntoxicationIconKeywords:Gift> erhöht sich um <WeaponEffect_Num:[StateArg1]%. Der “Schlag“ fügt dem Zielgegner <WeaponEffect_Num:[StateArg2]%> des ANG als <IntoxicationIconKeywords:Gift> zu. Dieser Effekt kann pro Runde maximal 3 Mal aktiviert werden."
  },
  State_3593_WeaponDesc = {
    Text = "Der Ausrüstende verursacht eine Erhöhung des <IntoxicationIconKeywords:Gift> um <WeaponEffect_Num:[StateArg1]%>. “Schlag“ fügt dem Zielgegner <WeaponEffect_Num:[Poison:DescArg1]> Schichten <IntoxicationIconKeywords:Gift> hinzu. Dieser Effekt kann pro Runde maximal 3 Mal aktiviert werden."
  },
  State_3596_Name = {
    Text = "Residueller Silberkern"
  },
  State_35970_Desc = {
    Text = "Nach dem Tod, 1 Runde <VulnerabilityIconKeywords:Verwundbarkeit> auf Spieler"
  },
  State_35970_Name = {
    Text = "Frühsterblichkeit"
  },
  State_35971_Desc = {
    Text = "Beim Auftreten erhaltet ihr einen Schild, der 50% der maximalen Gesundheit entspricht"
  },
  State_35971_Name = {Text = "Eierschale"},
  State_3597_Name = {
    Text = "Residueller Silberkern"
  },
  State_3598_Name = {
    Text = "Residueller Silberkern"
  },
  State_3599_Desc = {
    Text = "Wenn du eine Karte spielst, die tatsächlich 4 oder mehr Arithmetica kostet, sinken die Arithmetica Kosten anderer Handkarten um 1"
  },
  State_36006_Desc = {
    Text = "Nach dem Tod erscheint “Sohn des Schlafes“ an der Stelle."
  },
  State_36006_Name = {Text = "Bossphase"},
  State_3600_Name = {
    Text = "Residueller Silberkern"
  },
  State_36013_Desc = {
    Text = "Dieser Zustand gilt auch als <SacrificeKeyWord:Opfer>, zu Beginn der nächsten Runde erhältst du [Layer] Schichten <SacrificeKeyWord:Opfer>"
  },
  State_36013_Name = {
    Text = "<BlueKeyWord:Verzögerte Opferung>"
  },
  State_36014_Desc = {
    Text = "Nach Rundenende erleidet [Layer] Schaden und -50% <SacrificeKeyWord:Opferung>-Schichten"
  },
  State_36014_Name = {
    Text = "<BlueKeyWord:Opferung>"
  },
  State_3601_Name = {
    Text = "Status@TraumSilberschlüssel:TanzZählen"
  },
  State_36022_Desc = {
    Text = "Beim Erleiden von Schaden, der nicht von <SacrificeKeyWord:Opfer> stammt, erhält man 50 % des Schadens als <SacrificeKeyWord:Opfer>"
  },
  State_36022_Name = {Text = "Besuchen"},
  State_36023_Desc = {
    Text = "Nach dem Tod, wenn andere Verbündete vorhanden sind, erscheint „Kind des Wassers“"
  },
  State_36023_Name = {Text = "Bossphase"},
  State_36024_Desc = {
    Text = "Nach dem Tod, wenn andere Verbündete vorhanden sind, erscheint „Kind des Traums“"
  },
  State_36024_Name = {Text = "Bossphase"},
  State_3603_Name = {
    Text = "In Bosskämpfen 2 Mal verwendbar, nach der ersten Verwendung zurück auf die Hand"
  },
  State_3604_Desc = {
    Text = "Wenn das Team aus Erwachten verschiedener Klassen besteht, erhöhen sich Teamgesundheit sowie ANG und VERT aller Erwachten um 200%"
  },
  State_3604_Name = {
    Text = "Status@Mischbonus"
  },
  State_3604_WeaponDesc = {
    Text = "Wenn das Team aus Erwachten verschiedener Klassen besteht, erhöhen sich Teamgesundheit sowie ANG und VERT aller Erwachten um 200%"
  },
  State_3607_Desc = {
    Text = "Nach dem Spielen erhält der Erwecker in diesem Kampf besondere Fähigkeitssteigerungen. Wiederholte Einsätze von Gnosis können nicht gestapelt werden."
  },
  State_3607_Name = {
    Text = "<ExaltIconKeywords:Gnosis wecken>"
  },
  State_3607_WeaponDesc = {
    Text = "Nach dem Einsatz von Gnosis-Erwecken erhält der Erwecker in diesem Kampf besondere Fähigkeitssteigerungen. Aber wiederholte Einsätze von Gnosis-Erwecken können nicht gestapelt werden"
  },
  State_3608_Name = {
    Text = "Alle Verbündeten erhalten [StateArg1] Wahnsinn"
  },
  State_36092_Desc = {
    Text = "Nach dem Tod, wenn andere Verbündete vorhanden sind, erscheint „Kind des Wassers“ an der Stelle"
  },
  State_36092_Name = {Text = "Bossphase"},
  State_36093_Desc = {
    Text = "Pro verlorenen Lebenspunkt 1 Schicht reduzieren. Bei 0 Schichten nach der Monster-Runde 1 \"Wasserkind\" beschwören und [DescArg1] Schichten \"Wasserwirt\" zurückerhalten, maximal 4 \"Wasserkinder\""
  },
  State_36093_Name = {
    Text = "Wasserträger"
  },
  State_36094_Desc = {
    Text = "Pro verlorenen Lebenspunkt 1 Schicht reduzieren. Bei 0 Schichten 1 \"Geistkind\" beschwören und [DescArg1] Schichten \"Korallenwirt\" zurückerhalten, maximal 4 \"Geistkinder\""
  },
  State_36094_Name = {
    Text = "Geisterwirt"
  },
  State_3609_Name = {
    Text = "Im Bosskampf darf es zweimal verwendet werden, und nach dem ersten Einsatz kehrt es in die Handkarten zurück, das neu gezogene Kartenelement hat in dieser Runde einen Arithmetica-Verbrauch von -1"
  },
  State_36111_Desc = {
    Text = "Nach dem Tod, füge 1 Karte „Korallenwucherung“ zur Hand des Spielers hinzu"
  },
  State_36111_Name = {
    Text = "Korallenhyperplasie"
  },
  State_3611_Desc = {
    Text = "Status@PrologMonsterPassiv12"
  },
  State_3611_Name = {
    Text = "Status@PrologMonsterPassiv12"
  },
  State_3611_WeaponDesc = {
    Text = "Status@PrologMonsterPassiv12"
  },
  State_36124_Desc = {
    Text = "Nach Rundenende erleidet [Layer] Schaden und reduziert 50% der „Opferung“-Schichten"
  },
  State_36124_Name = {
    Text = "<BlueKeyWord:Opferung>"
  },
  State_3612_Desc = {
    Text = "Status@PrologMonsterPassiv13"
  },
  State_3612_Name = {
    Text = "Status@PrologMonsterPassiv13"
  },
  State_3612_WeaponDesc = {
    Text = "Status@PrologMonsterPassiv13"
  },
  State_36136_Name = {
    Text = "Solange auf der Hand: Erleidet [StateArg1] <FixedDamage:Reinen SCH> für jede andere gespielte Karte."
  },
  State_3613_Desc = {
    Text = "Status@PrologMonsterPassiv10"
  },
  State_3613_Name = {
    Text = "Status@PrologMonsterPassiv10"
  },
  State_3613_WeaponDesc = {
    Text = "Status@PrologMonsterPassiv10"
  },
  State_3614_Desc = {
    Text = "Status@PrologMonsterPassiv11"
  },
  State_3614_Name = {
    Text = "Status@PrologMonsterPassiv11"
  },
  State_3614_WeaponDesc = {
    Text = "Status@PrologMonsterPassiv11"
  },
  State_36152_Desc = {
    Text = "Nach Rundenende erleidet Schaden in Höhe der Schichten, danach werden 50 % der <SacrificeKeyWord:Opfer>-Schichten entfernt. Das Opfer wird in den nächsten Kampf übernommen."
  },
  State_36152_Name = {
    Text = "<SacrificeKeyWord:Opfer>"
  },
  State_3615_Desc = {
    Text = "Status@PrologMonsterPassiv16"
  },
  State_3615_Name = {
    Text = "Status@PrologMonsterPassiv16"
  },
  State_3615_WeaponDesc = {
    Text = "Status@PrologMonsterPassiv16"
  },
  State_3616_Desc = {
    Text = "Status@PrologMonsterPassiv14"
  },
  State_3616_Name = {
    Text = "Status@PrologMonsterPassiv14"
  },
  State_3616_WeaponDesc = {
    Text = "Status@PrologMonsterPassiv14"
  },
  State_36173_Name = {
    Text = "In Bosskämpfen [DescArg1] Mal verwendbar"
  },
  State_36174_Name = {
    Text = "（Noch [Layer] Mal übrig）"
  },
  State_3617_Desc = {
    Text = "Status@PrologMonsterPassiv15"
  },
  State_3617_Name = {
    Text = "Status@PrologMonsterPassiv15"
  },
  State_3617_WeaponDesc = {
    Text = "Status@PrologMonsterPassiv15"
  },
  State_36182_Name = {
    Text = "Erhalte [DescArg1]% (<Block:[DescArg2]>) Schild von maximaler Gesundheit und heile die gleiche Menge an Leben, der Schild erhöht sich basierend auf dem verlorenen Leben"
  },
  State_3618_Desc = {
    Text = "Beim Erleiden von tatsächlichem Schaden erhält man einen Schild"
  },
  State_3618_Name = {Text = "Puffer"},
  State_3618_WeaponDesc = {
    Text = "Beim Erleiden von tatsächlichem Schaden erhält man einen Schild"
  },
  State_36196_Desc = {
    Text = "Lotans „Dieke“-Schaden erhöht sich um 30 %"
  },
  State_36196_Name = {
    Text = "Ungebundener Schwertwind"
  },
  State_3619_Desc = {
    Text = "Zustand @ Blauflammentänzerin Schlag VERT"
  },
  State_3619_Name = {
    Text = "Zustand @ Blauflammentänzerin Schlag VERT"
  },
  State_3619_WeaponDesc = {
    Text = "Zustand @ Blauflammentänzerin Schlag VERT"
  },
  State_3620_Desc = {
    Text = "Jedes Mal, wenn du eine Symptom-Karte erhältst, erhöht sich die maximale Gesundheit um [Arg1] Punkte"
  },
  State_3621_Desc = {
    Text = "Ursprünglicher Gläubiger zieht für jede gespielte Karte [StateArg1] Karten, löst bei allen Feinden 5% Gift aus"
  },
  State_3621_Name = {
    Text = "Abgründige Besessenheit"
  },
  State_3621_WeaponDesc = {
    Text = "Ursprünglicher Gläubiger zieht für jede gespielte Karte [StateArg1] Karten"
  },
  State_3622_Desc = {
    Text = "Stärke die Fähigkeiten von “Wütender Schädeljäger“ und “Die Toten“，erhalte zu Beginn jeder Runde [StateArg1] Punkte temporäre Macht, und erhöhe um [StateArg1] Punkte für jede Schicht “Jagdmarkierung“"
  },
  State_3622_Name = {
    Text = "Jagdzeichen"
  },
  State_36242_Desc = {
    Text = "Zu Beginn des Kampfes erhältst du [StateArg1] Schild. Nach Lebensverlust wird der „Heilige Säugling“ aufwachen und weinen"
  },
  State_36242_Name = {Text = "Tiefschlaf"},
  State_3624_Desc = {
    Text = "Zustand @ Wissender Offensivanalyse Machtminderung"
  },
  State_3624_Name = {
    Text = "Zustand @ Wissender Offensivanalyse Machtminderung"
  },
  State_3625_Desc = {
    Text = "Wenn du ein Schild hast, erhöht sich der verursachte Schaden um [Arg1]. Wenn dein Schild höher ist als dein aktuelles Leben, erhöht sich der Schaden zusätzlich um [Arg2]"
  },
  State_36263_Desc = {
    Text = "Wird nicht mehr verletzt, bereit, „Saat des Geborenen“ freizugeben"
  },
  State_36263_Name = {Text = "Immun"},
  State_3628_Name = {
    Text = "Status@NachAusspielenSchutzBrechen"
  },
  State_3629_Name = {
    Text = "Ziehe 2 Karten"
  },
  State_3630_Name = {
    Text = "Fügt allen Feinden 2 Schichten <VulnerabilityIconKeywords:Verwundbarkeit> zu"
  },
  State_36315_Desc = {
    Text = "Am Ende der Runde erhalte [Layer] Stärke"
  },
  State_36315_Name = {Text = "Mont"},
  State_3631_Name = {
    Text = "Erhalte 2 Punkte Arithmetica"
  },
  State_3632_Name = {
    Text = "Erhalte <Energy:[DescArg1]> Wahnsinn"
  },
  State_36332_Desc = {
    Text = "Zu Beginn jeder Runde wähle 1 Schicht Göttliche Macht oder verbrauche Göttliche Macht, um Murphys Hilfe zu erhalten"
  },
  State_36332_Name = {
    Text = "Göttliche Macht"
  },
  State_36334_Desc = {
    Text = "Erhalte am Rundenende 1 Tentakel"
  },
  State_36334_Name = {
    Text = "Schraubengrabenruf"
  },
  State_3633_Name = {
    Text = "Fügt allen Feinden 2 Schichten <WeaknessIconKeywords:Schwäche> zu"
  },
  State_36346_Desc = {
    Text = "Wenn das Leben auf 0 fällt, wird es auf 1 gesetzt, nimmt keinen Schaden mehr und bereitet die Freisetzung von „Geburtssamen“ vor"
  },
  State_36346_Name = {
    Text = "Sporenbildung"
  },
  State_3634_Name = {
    Text = "2 <DerivativeCardKeywords_4:“Inspiration“> werden in den Ziehstapel aufgenommen"
  },
  State_3635_Name = {
    Text = "Andere Erwachte erhalten <Energy:[DescArg1]> Wahnsinn"
  },
  State_36360_Desc = {
    Text = "Nach Beginn der Runde, [DescArg1]% Chance, 1 Tentakelansammlung zu erhalten, über 100% können mehrere Schichten erhalten werden"
  },
  State_36360_Name = {
    Text = "Rückkehrlinie"
  },
  State_36361_Desc = {
    Text = "Bei Betreten, andere Verbündete erhalten [Layer] Kraft"
  },
  State_36361_Name = {
    Text = "Göttliche Abweichung"
  },
  State_3636_Desc = {
    Text = "Status@Schöpfung Verführung Windspiel Aktivierung"
  },
  State_3636_Name = {
    Text = "Status@Schöpfung Verführung Windspiel Aktivierung"
  },
  State_3637_Desc = {
    Text = "Wenn dein Leben unter 25% fällt und du nicht tot bist, regenerierst du sofort [Arg1] Leben. Nach 3 Auslösungen dauerhaft deaktiviert"
  },
  State_3637_Name = {
    Text = "☆Notfallspeise☆"
  },
  State_3638_Desc = {
    Text = "Beim Erleiden von Aktivem Schaden oder Tentakelschaden wird der Schaden ignoriert und 1 Stapelung verloren."
  },
  State_3638_Name = {
    Text = "<ParcloseColour: Barriere>"
  },
  State_3638_WeaponDesc = {
    Text = "Erlittener Schaden –99%. Jedes Mal, wenn Schaden erlitten wird, wird 1 Stapelung verloren."
  },
  State_3639_Desc = {
    Text = "Wenn Ramona Schaden verursacht, erhält sie [StateArg1] Punkte Arithmetica"
  },
  State_3639_Name = {
    Text = "Dritte Philosophie"
  },
  State_3639_WeaponDesc = {
    Text = "Wenn Ramona Schaden verursacht, erhält sie [StateArg1] Punkte Arithmetica"
  },
  State_3641_Desc = {
    Text = "Wähle eine Karte am „Unvollendeten Wachsskulptur“, Arithmetica -1"
  },
  State_3641_Name = {
    Text = "Status@Kapitel 2 Resonanz Grundeffekt"
  },
  State_3641_WeaponDesc = {
    Text = "Bei der „Unvollendeten Wachsfigur“ wird das Level der kopierten Karten um 1 erhöht"
  },
  State_3642_Desc = {
    Text = "Immer wenn du Gesundheit verlierst, erhältst du [Arg1] Schichten Gegenschlag. Wenn es die dritte Auslösung innerhalb einer Runde ist, füge allen Feinden einmal Gegenschlag-Schaden zu"
  },
  State_3642_Name = {
    Text = "Chronos des Verstorbenen"
  },
  State_3646_Desc = {
    Text = "Wenn die Lebenspunkte nicht unter 1 fallen können, wird bei tödlichem Schaden die Absicht durch überlebendes Dilemma ersetzt. [überlebendes Dilemma]: Maximal 100% Lebenspunkte wiederherstellen, Kraft verdoppeln und nachfolgende Fähigkeiten stärken"
  },
  State_3646_Name = {
    Text = "Verzweifeltes Überleben"
  },
  State_3647_Name = {
    Text = "Arkane Aufzeichnungs-Zähler der Schöpfung"
  },
  State_3648_Desc = {
    Text = "Einzigartig für das Team: Lebensregeneration des Trägers erhöht sich um <WeaponEffect_Num:[StateArg2]%>. Zu Beginn jeder Runde erhält der Träger temporäre <PowerIconKeywords:Macht> und Schild entsprechend <WeaponEffect_Num:[StateArg1]%> des im letzten Zug verlorenen Lebens"
  },
  State_3648_WeaponDesc = {
    Text = "Der Effekt der Lebensregeneration des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg2]%>. Zu Beginn der Runde erhält der Ausrüster einen temporären <PowerIconKeywords:Macht> und Schild in Höhe von <WeaponEffect_Num:[StateArg1]%> des im letzten Zug verlorenen Lebens"
  },
  State_3649_Desc = {
    Text = "Wenn im Team ein Erwecker der Beruf[ultra] vorhanden ist, erhöht sich die maximale Gesundheit (unvollständig), VERT und ANG des gesamten Teams um 50%"
  },
  State_3649_Name = {
    Text = "Überdimensionaler Bonus"
  },
  State_3649_WeaponDesc = {
    Text = "Wenn im Team ein Erwecker der Beruf[ultra] vorhanden ist, erhöht sich die maximale Gesundheit (unvollständig), VERT und ANG des gesamten Teams um 50%"
  },
  State_3651_Desc = {
    Text = "Ändere die Arithmetica Kosten der Karte vor dem Spielen"
  },
  State_3651_Name = {
    Text = "Ändere die Arithmetica Kosten der Karte vor dem Spielen"
  },
  State_3651_WeaponDesc = {
    Text = "Ändere die Arithmetica Kosten der Karte vor dem Spielen"
  },
  State_3652_Desc = {
    Text = "Zu Beginn der Runde, wenn im letzten Zug mehr als [StateArg1] Karten gespielt wurden, ziehe [StateArg2] Karten"
  },
  State_3652_Name = {
    Text = "Magische Handschuhe der Schöpfung"
  },
  State_3652_WeaponDesc = {
    Text = "Zu Beginn der Runde, wenn im letzten Zug mehr als [StateArg1] Karten gespielt wurden, ziehe [StateArg2] Karten"
  },
  State_3653_Name = {
    Text = "Schöpfung Zerrissene Kriegsflagge2"
  },
  State_3654_Desc = {
    Text = "Am Anfang der Runde erhältst du [Layer]% temporäre kritische Rate"
  },
  State_3654_Name = {
    Text = "Ferne Melodie"
  },
  State_3654_WeaponDesc = {
    Text = "Bis vor dem Beginn der nächsten Runde kein Leben verloren, kritische Rate in der nächsten Runde +[StateArg1]%"
  },
  State_3656_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_3656_Name = {
    Text = "Nicht erweckt"
  },
  State_3658_Desc = {
    Text = "Beim Ausspielen der letzten Karte auf der Hand zieht man 2 Karten. Maximal 2 Mal pro Runde"
  },
  State_3659_Name = {
    Text = "Zustand @ ANGskarte kritische Rate kritischer Schaden erhöht"
  },
  State_36613_Name = {
    Text = "Status@Schmuck Mechanische Gottheit Zählung"
  },
  State_3661_Desc = {
    Text = "Tatsächlicher Schaden erhöht die Tiefe der Erosion"
  },
  State_3661_Name = {
    Text = "Schaden erleiden erhöht die Tiefe der Erosion"
  },
  State_3661_WeaponDesc = {
    Text = "Tatsächlicher Schaden erhöht die Tiefe der Erosion"
  },
  State_3662_Desc = {
    Text = "Kritischer Schaden in diesem Kampf um [Layer]% erhöht"
  },
  State_3662_Name = {
    Text = "Krit. Schaden"
  },
  State_3662_WeaponDesc = {
    Text = "Kritischer Schaden in diesem Kampf um [Layer]% erhöht"
  },
  State_36631_Desc = {
    Text = "Nach jeder Auslösung von Aelius erhältst du 1 Schicht „Nähren“, jede Schicht Nähren gibt dir [StateArg1] Punkte Macht, maximal 5 Schichten"
  },
  State_36631_Name = {
    Text = "Falsche Trägerin"
  },
  State_36635_Desc = {
    Text = "Nach jeder Auslösung von Aelius erhältst du 1 Schicht „Nähren“, jede Schicht Nähren gibt dir [StateArg1] Punkte Macht, maximal 5 Schichten"
  },
  State_36635_Name = {
    Text = "Die Endgültige Abstieg von Lemuria"
  },
  State_36636_Desc = {
    Text = "Bei 5 Stapeln wird „Glanz von Limoria!“ freigesetzt, verursacht hohen Schaden und ruft Verbündete"
  },
  State_36636_Name = {Text = "Geburt"},
  State_36637_Desc = {
    Text = "Bei 5 Stapeln wird „Für Limoria!“ freigesetzt, verursacht hohen Schaden und ruft Verbündete"
  },
  State_36637_Name = {Text = "Geburt"},
  State_3663_Desc = {
    Text = "Nach der ersten gespielten Karte jeder Runde füge 1 „Schlag“ des entsprechenden Wächters der Hand hinzu"
  },
  State_3664_Desc = {
    Text = "Nach dem Ausspielen erhält man 5 Wahnsinn"
  },
  State_3664_Name = {Text = "Gedenken"},
  State_3664_WeaponDesc = {
    Text = "Nach dem Ausspielen erhält man 5 Wahnsinn"
  },
  State_3665_Desc = {
    Text = "Wenn die Embryofusion 100% erreicht, wird eine „Embryo\"-Karte in die Hand aufgenommen."
  },
  State_3665_Name = {
    Text = "<EmbryoFusionIconKeywords:Embryo-Fusion>"
  },
  State_3666_Desc = {
    Text = "Kritische Rate erhöht um [Layer] %"
  },
  State_3666_Name = {Text = "Krit. Rate"},
  State_3666_WeaponDesc = {
    Text = "Kritische Rate erhöht um [Layer] %"
  },
  State_36670_Name = {
    Text = "Status@Schmuck Re-Evolution Zählung"
  },
  State_36670_WeaponDesc = {
    Text = "Ausrüster: Am Rundenende 3 Wahnsinn. Bei Wahnsinnsaufladung > 10, zusätzlich 2 Wahnsinn"
  },
  State_3667_Desc = {
    Text = "Team Unique: Der <RetaliateIconKeywords:Gegenangriff> des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg4]%. Nach dem Ausspielen einer Karte erhält der Ausrüster einen <RetaliateIconKeywords:Gegenangriff> in Höhe von <WeaponEffect_Num:[StateArg1]%> seiner VERT, maximal 2 Mal pro Runde. Wenn er in den Hyperraum eintritt, erhält der Ausrüster zusätzlich <WeaponEffect_Num:[StateArg2]> Punkte Aliemus. Nach der Freisetzung von Verherrlichung verlieren alle Feinde temporäre Stärke in Höhe von <WeaponEffect_Num:[StateArg3]%> seiner VERT."
  },
  State_3667_WeaponDesc = {
    Text = "Der Ausrüster erhöht den <RetaliateIconKeywords:Gegenangriff> um <WeaponEffect_Num:[StateArg4]%. Nach dem Ausspielen einer Karte erhält der Ausrüster <WeaponEffect_Num:[Counterattack:DescArg1]> Punkte <RetaliateIconKeywords:Gegenangriff>, was pro Runde bis zu 2 Mal ausgelöst werden kann. Wenn er den Hyperraum betritt, erhält der Ausrüster zusätzlich <WeaponEffect_Num:[StateArg2]> Punkte Aliemus. Nach der Freisetzung von Verherrlichung senken alle Feinde vorübergehend <WeaponEffect_Num:[Power:DescArg2]> Punkte Stärke."
  },
  State_3668_Desc = {
    Text = "Zustand @ entarteter Garten Hüter Kennzeichen"
  },
  State_3668_Name = {
    Text = "Zustand @ entarteter Garten Hüter Kennzeichen"
  },
  State_3668_WeaponDesc = {
    Text = "Zustand @ entarteter Garten Hüter Kennzeichen"
  },
  State_3669_Desc = {
    Text = "Immun gegen Symptom: Schwäche, Zerbrechlichkeit und Verwundbarkeit für [Layer] <plural value=\"[Layer]\" singular=\"Runde\" plural=\"Runden\">."
  },
  State_3669_Name = {
    Text = "<BlessingColour: Segen>"
  },
  State_3669_WeaponDesc = {
    Text = "[Layer] Immun gegen negative Zustände in dieser Runde"
  },
  State_36710_Name = {
    Text = "Tanz des Dreiviertelmondes"
  },
  State_3673_Desc = {
    Text = "Nach dem Aufheben wähle zwei Karten zum Entfernen und erhalte [StateArg1] Kraft"
  },
  State_3673_Name = {
    Text = "Schwarze Sternenasche der Schöpfung"
  },
  State_3674_Desc = {
    Text = "Am Ende der Runde, reduziere den Wahnsinn aller Erwachten um 10"
  },
  State_3674_Name = {
    Text = "Vernichtung"
  },
  State_3674_WeaponDesc = {
    Text = "Am Ende der Runde, reduziere den Wahnsinn aller Erwachten um 10"
  },
  State_3675_Name = {
    Text = "Ziehe verworfene Kartenanzahl + 1 Karte"
  },
  State_3676_Desc = {
    Text = "Während der Runde des Gegners, erhalte [Layer]% weniger Schaden"
  },
  State_3676_Name = {Text = "Wachsam"},
  State_3676_WeaponDesc = {
    Text = "Unser Team erhält in der Runde des Gegners [Layer] % Schadensreduktion"
  },
  State_3677_Desc = {
    Text = "Erhöht die VERT um [Layer]%"
  },
  State_3677_Name = {
    Text = "Temporärer VERTsprozentsatz erhöht"
  },
  State_3677_WeaponDesc = {
    Text = "Erhöht die VERT um [Layer]%"
  },
  State_36781_Desc = {
    Text = "Wenn die Stärke verringert wird, wird nur 50% der Stärkeschichten reduziert"
  },
  State_36781_Name = {
    Text = "Durstige Wille nach Bossphase"
  },
  State_3678_Name = {
    Text = "Status@Ereignisobjekt1"
  },
  State_36797_Desc = {
    Text = "In dieser Runde Tentakelschaden -[Layer]"
  },
  State_36797_Name = {
    Text = "Tentakelschaden verringert"
  },
  State_3679_Name = {
    Text = "Status@Ereignisobjekt2"
  },
  State_3680_Desc = {
    Text = "Für jeden verursachten Schaden fügst du dem Ziel [Arg1] Schichten Gift hinzu. Wenn die Auslösungen in diesem Kampf 25 erreichen, wird sofort Gift auf alle Gegner aktiviert"
  },
  State_3681_Desc = {
    Text = "Beim Austeilen von ungebloctem Schaden werden [DescArg1] Stapelungen <BrokenCard:Sabotage> auf 2 zufälligen „Befehlskarten“ hinterlassen."
  },
  State_3681_Name = {
    Text = "Jenkins erwacht!"
  },
  State_3681_WeaponDesc = {
    Text = "Nach Beginn der nächsten Runde, erhalte Schild in Höhe des verlorenen Lebens der letzten Runde"
  },
  State_3682_Desc = {
    Text = "Bei jedem 10% Lebensverlust erhalten alle Erwachten 10 Wahnsinn, nach dem Tod erhöht sich der Tentakelschaden"
  },
  State_3682_Name = {
    Text = "Tief vergrabener Silberkern"
  },
  State_3682_WeaponDesc = {
    Text = "Bei jedem 10% Lebensverlust erhalten alle Erwachten 10 Wahnsinn, nach dem Tod erhöht sich der Tentakelschaden"
  },
  State_3683_Desc = {
    Text = "Team Unique: Die Heilung, die durch die Befehlskarten des Ausrüsters verursacht wird, erhöht sich um <WeaponEffect_Num:[StateArg2]%. Vor der Freisetzung von “Verherrlichung“ erhalten andere Erwecker <WeaponEffect_Num:[StateArg1]> Punkte Aliemus. Wenn unser Team im Zustand <VulnerabilityIconKeywords:Verwundbar> ist, wird der Effekt verdoppelt."
  },
  State_3683_WeaponDesc = {
    Text = "Die Heilung, die durch die Befehlskarten des Ausrüsters verursacht wird, erhöht sich um <WeaponEffect_Num:[StateArg2]%. Vor der Freisetzung der Verherrlichung erhält jeder andere Erwecker <WeaponEffect_Num:[StateArg1]> Punkte Aliemus. Wenn unser Team im Zustand <VulnerabilityIconKeywords:Verwundbar> ist, wird der Effekt verdoppelt."
  },
  State_3684_Desc = {
    Text = "Jeder erlittene Schaden verringert 1 Schicht. Wenn der Wert 0 erreicht, wird die Absicht durch die unsterbliche Blume ersetzt und eine defensivere Fähigkeitsgruppe verwendet"
  },
  State_3684_Name = {
    Text = "Ewige Blume"
  },
  State_3684_WeaponDesc = {
    Text = "Jeder erlittene Punkt Schaden reduziert eine Schicht. Bei 0 Schichten in den VERTsmodus wechseln"
  },
  State_3685_Desc = {
    Text = "Beim Ziehen verlierst du 1 Arithmetica und ziehst 1 Karte"
  },
  State_3685_Name = {Text = "Verwirrung"},
  State_3685_WeaponDesc = {
    Text = "Beim Ziehen verlierst du 1 Arithmetica und ziehst 1 Karte"
  },
  State_3686_Desc = {
    Text = "Beim Ziehen verlierst du 1 Arithmetica und ziehst 1 Karte"
  },
  State_3686_Name = {
    Text = "Dimensionssiegel"
  },
  State_3686_WeaponDesc = {
    Text = "Beim Ziehen verlierst du 1 Arithmetica und ziehst 1 Karte"
  },
  State_36884_Desc = {
    Text = "Letztes Gelübde in diesem Kampf kann nicht mehr durch aktives Auslösen von Todeswiderstand Schilde erhalten"
  },
  State_36884_Name = {
    Text = "Der letzte Schwur"
  },
  State_3688_Desc = {
    Text = "Wenn du zwei Karten mit höherem Arithmetica-Verbrauch als die vorherige ausspielst, erhältst du 2 Arithmetica"
  },
  State_3688_Name = {
    Text = "Arkane Aufzeichnungen der Schöpfung"
  },
  State_3688_WeaponDesc = {
    Text = "Wenn du zwei Karten mit höherem Arithmetica-Verbrauch als die vorherige ausspielst, erhältst du 2 Arithmetica"
  },
  State_3689_Desc = {
    Text = "Zu Beginn der Runde erhöhe die Domänenbeherrschung um 30. Wenn du keinen negativen Zustand hast, erhöhe die Domänenbeherrschung um 100"
  },
  State_3692_Desc = {
    Text = "Besitzt mysteriöse Karten in tausend Formen. Wähle die, die du am meisten brauchst!"
  },
  State_3692_Name = {
    Text = "<CardKeyWord:tausend Fata Morgana>"
  },
  State_3692_WeaponDesc = {
    Text = "Besitzt mysteriöse Karten in tausend Formen. Wähle die, die du am meisten brauchst!"
  },
  State_3693_Desc = {
    Text = "Kritische Rate erhöht um 25%. Nach einer Gesundheitswiederherstellung besteht die Chance, zusätzlich 1 Gesundheitswiederherstellung auszulösen, die Wahrscheinlichkeit entspricht der kritischen Rate des Wiederherstellers"
  },
  State_3693_Name = {
    Text = "Zustand @ Illusionssilberschlüssel: kritisches Heilen"
  },
  State_3696_Desc = {
    Text = "Für jeden verursachten Schaden erhältst du in dieser Runde [Arg1] Punkte Alarm. Zu Beginn der Runde erhältst du 1 Punkt Macht für jede 3 Punkte verbleibenden Schilds"
  },
  State_3696_Name = {
    Text = "Zeitpendel „Versteckt\""
  },
  State_3697_Desc = {
    Text = "Zu Rundenbeginn ziehen Sie 1 Karte. Wenn Sie 2 Mal hintereinander eine Karte mit dem gleichen Arithmetica-Verbrauch wie die vorherige Karte spielen, ziehen Sie zusätzlich 1 Karte."
  },
  State_3698_Desc = {
    Text = "Nach dem Ausspielen werden [StateArg1] Kopien der Karte in den temporären <DimensionalSpaceIconKeywords:Dimensionsraum> gelegt"
  },
  State_3698_Name = {
    Text = "<Rune_13:Warp>"
  },
  State_3699_Name = {
    Text = "Residueller Silberkern"
  },
  State_3700_Desc = {
    Text = "Erhöht den ANG um [Layer]%"
  },
  State_3700_Name = {
    Text = "Vorübergehende prozentuale ANGskraftsteigerung"
  },
  State_3700_WeaponDesc = {
    Text = "Erhöht den ANG um [Layer]%"
  },
  State_3702_Desc = {
    Text = "Zustand @ Allgemein ändern maximale Gesundheit"
  },
  State_3702_Name = {
    Text = "Zustand @ Allgemein ändern maximale Gesundheit"
  },
  State_3702_WeaponDesc = {
    Text = "Zustand @ Allgemein ändern maximale Gesundheit"
  },
  State_3703_Name = {
    Text = "Status@Kapitel 4 Resonanz@Nächste Runde Karten ziehen 2"
  },
  State_3704_Desc = {
    Text = "Reichsbeherrschung um 30 erhöht. Wähle ein Relikt, um es durch ein zufälliges zu ersetzen"
  },
  State_3705_Name = {
    Text = "Marine Mond Erleuchten 3"
  },
  State_3707_Desc = {
    Text = "Nach Beginn des Kampfes mischen Sie [StateArg1] temporäre Kopien in den Ziehstapel. Sowohl die ursprüngliche Karte als auch die Spiegelkarte erhalten behalten"
  },
  State_3707_Name = {
    Text = "<Rune_8:Spiegelbild>"
  },
  State_3708_Desc = {
    Text = "Am Ende einer geraden Runde, für jede verbleibende Handkarte erhältst du zu Beginn der nächsten Runde 1 Arithmetica"
  },
  State_3708_Name = {
    Text = "Schöpfung Weisen Kapitel2"
  },
  State_3708_WeaponDesc = {
    Text = "Am Ende einer geraden Runde, für jede verbleibende Handkarte erhältst du zu Beginn der nächsten Runde 1 Arithmetica"
  },
  State_3709_Desc = {
    Text = "Bei ungeraden Runden zieht jede verbleibende Arithmetica eine Karte zu Beginn der nächsten Runde"
  },
  State_3709_Name = {
    Text = "Schöpfung Weisen Kapitel1"
  },
  State_3709_WeaponDesc = {
    Text = "Bei ungeraden Runden zieht jede verbleibende Arithmetica eine Karte zu Beginn der nächsten Runde"
  },
  State_3711_Desc = {
    Text = "Jede Aktion verursacht [Layer] Bluten"
  },
  State_3711_Name = {Text = "Blutspur"},
  State_3711_WeaponDesc = {
    Text = "Jede Aktion verursacht [Layer] Bluten, das Heilen kann die Anzahl der Blutungsschichten halbieren"
  },
  State_3712_Desc = {
    Text = "Nach dem Ausspielen der Karte wird sie verbraucht, Befehlskarten verursachen 3-fachen Schaden und Schutz für 1 Runde"
  },
  State_3712_Name = {Text = "Lösung"},
  State_3714_Desc = {
    Text = "Nach dem Ausspielen erhält man [StateArg1] Schild"
  },
  State_3714_Name = {
    Text = "<Rune_6:Eiserne Mauer>"
  },
  State_3716_Desc = {
    Text = "In diesem Kampf wird die kritische Rate um [Layer]% erhöht"
  },
  State_3716_Name = {Text = "Krit. Rate"},
  State_3719_Desc = {
    Text = "Für jede erlittene Instanz von Aktivem Schaden greift der Tentakel die Schadensquelle einmal mit einem Gegenangriff an, für [Layer] <plural value=\"[Layer]\" singular=\"Runde\" plural=\"Runden\">."
  },
  State_3719_Name = {
    Text = "Blutlinie der Ketzerei"
  },
  State_3720_Desc = {
    Text = "Erhöhe [Layer] VERT"
  },
  State_3720_Name = {
    Text = "Allgemeine VERT erhöht"
  },
  State_3720_WeaponDesc = {
    Text = "Erhöhe [Layer] VERT"
  },
  State_3721_Desc = {
    Text = "Nach dem Ausspielen wird nicht in den Ablagestapel gelegt, sondern aus dem Deck entfernt"
  },
  State_3721_Name = {Text = "Verbrauch"},
  State_3721_WeaponDesc = {
    Text = "Nach dem Ausspielen wird die Karte nicht in den Ablagestapel gelegt und kann in diesem Kampf nicht erneut verwendet werden"
  },
  State_3722_Desc = {
    Text = "Jedes Mal, wenn man Schaden verursacht, erhöht sich temporär der Tentakelschaden um [StateArg1], bis zu 5 Mal stapelbar. Bei voller Stapelung wird ein Tentakel erzeugt"
  },
  State_3722_Name = {
    Text = "Schöpfung Priesterstab"
  },
  State_3722_WeaponDesc = {
    Text = "Jedes Mal, wenn man Schaden verursacht, erhöht sich temporär der Tentakelschaden um [StateArg1], bis zu 5 Mal stapelbar. Bei voller Stapelung wird ein Tentakel erzeugt"
  },
  State_3723_Name = {
    Text = "Schwarzer Spiegel der Schöpfung"
  },
  State_3724_Desc = {
    Text = "Beim Aufnehmen verliere alle anderen Relikte und erhalte zufällig 2 goldene Relikte"
  },
  State_3726_Name = {
    Text = "Verdrehtes Leichenfest"
  },
  State_3728_Desc = {
    Text = "Zu Beginn des Kampfes erhält man eine [Schlag]"
  },
  State_3728_Name = {
    Text = "Wal-Beschwörung 1"
  },
  State_3728_WeaponDesc = {
    Text = "Zu Beginn des Kampfes erhält man eine [Schlag]"
  },
  State_3730_Desc = {
    Text = "Zustand @ Monster süßer Bösewicht honigfarbene Tragödie"
  },
  State_3730_Name = {
    Text = "Zustand @ Monster süßer Bösewicht honigfarbene Tragödie"
  },
  State_3730_WeaponDesc = {
    Text = "Zustand @ Monster süßer Bösewicht honigfarbene Tragödie"
  },
  State_3731_Desc = {
    Text = "Nach jedem Einkauf im Laden erhält das nächste Gefecht in jeder Runde 1 zusätzliches Karten ziehen und 1 Arithmetica"
  },
  State_3732_Desc = {
    Text = "Alle 3 Runden erhält man 3 temporäre Tentakel, die die Tentakelobergrenze ignorieren"
  },
  State_3732_Name = {
    Text = "Schöpfung Namenloses Glied"
  },
  State_3732_WeaponDesc = {
    Text = "Alle 3 Runden erhält man 3 temporäre Tentakel, die die Tentakelobergrenze ignorieren"
  },
  State_3733_Desc = {
    Text = "Bei ungeraden Runden wird die verbleibende Arithmetica in zusätzliche Karten für die nächste Runde umgewandelt; bei geraden Runden wird die verbleibende Handkarte in zusätzliche Arithmetica für die nächste Runde umgewandelt"
  },
  State_3735_Name = {
    Text = "Die „Gift“-Schichten unseres Teams werden halbiert"
  },
  State_3738_Desc = {
    Text = "Am Ende der Runde wird Embryo-Fusion um +15% erhöht. Wenn sich ein „Embryo“ im Handkarten befindet, erhält man [Arg1] Gesundheit zurück"
  },
  State_3738_Name = {
    Text = "Pestaufzeichnung"
  },
  State_3739_Name = {
    Text = "Schmuckstück Organische Form Effekt"
  },
  State_3739_WeaponDesc = {
    Text = "Nach der Nutzung der Wahnsinnsexplosion werden die Schutzschilde und die Heilungskraft des Ausrüstenden in dieser Runde verdoppelt"
  },
  State_3740_Name = {
    Text = "Zustand @ Süßer Dämon Kritische Trefferzählung"
  },
  State_3741_Desc = {
    Text = "Zu Beginn der 3. Runde füge 1 Karte “Echo der Vergangenheit—Wirf alle Handkarten ab, setze aktuelles Leben und Schild auf den Stand am Ende der letzten Runde zurück. Behalte, verbrauche.“ deiner Hand hinzu"
  },
  State_3742_Desc = {
    Text = "Nach dem Ausspielen werden alle Feinde [StateArg1] Runden verwundbar"
  },
  State_3742_Name = {
    Text = "<Rune_1:Verwundbarkeit>"
  },
  State_3743_Desc = {
    Text = "Die sechste Karte, die du spielst, hat eine doppelte Wirkung"
  },
  State_3743_Name = {
    Text = "Schöpfung Sternenwein"
  },
  State_3744_Name = {
    Text = "Schöpfung Memphis Ritualspiegel Zähler"
  },
  State_3747_Name = {
    Text = "Wähle eine Karte aus dem Nachziehstapel und füge sie deiner Hand hinzu"
  },
  State_3748_Name = {
    Text = "Die Kritische Rate des verursachten Schadens erhöht sich um [DescArg1] %, der kritische Schaden erhöht sich um [DescArg2] %"
  },
  State_3750_Name = {
    Text = "Temporäre kritische Rate +[DescArg1]%. In diesem Kampf erhöht sich der Grundschaden von “Schädelräuber“ und “Tausend-Fata Morgana“ um 5%."
  },
  State_3751_Name = {
    Text = "Erhalte [StateArg1] Punkt<PowerIconKeywords:Kraft>"
  },
  State_3752_Name = {
    Text = "Erhalte <Posse:[DescArg1]> Punkte Silberschlüssel-Energie. Erhalte <Block:[Block:StateArg1]> Punkte Schild"
  },
  State_3753_Desc = {
    Text = "Karten werden nicht in der Ablagephase in den Ablagestapel gelegt, sondern bleiben im Handkartenbereich"
  },
  State_3753_Name = {
    Text = "<RetainIconKeywords:Behalten>"
  },
  State_3753_WeaponDesc = {
    Text = "Karten werden nicht in der Ablagephase in den Ablagestapel gelegt, sondern bleiben im Handkartenbereich"
  },
  State_3754_Desc = {
    Text = "Beim Verursachen von aktivem Schaden erhöht sich der Tentakelschaden in dieser Runde um [Arg1], bis zu 3 Stapel. Bei vollem Stapel wird 1 Tentakel erzeugt, am Rundenende entfernt"
  },
  State_3755_Desc = {
    Text = "Team Unique: Die Schilde des Ausrüsters erhöhen sich um <WeaponEffect_Num:[StateArg1]%, die Lebensregeneration erhöht sich um <WeaponEffect_Num:[StateArg1]%. Am Ende der ungeraden Runde erhöht sich die kritische Rate des Ausrüsters um <WeaponEffect_Num:[StateArg2]%> und er erhält <WeaponEffect_Num:[StateArg3]> Punkte Aliemus; am Ende der geraden Runde erhöht sich der kritische Schaden des Ausrüsters um <WeaponEffect_Num:[StateArg2]%> und er erhält <WeaponEffect_Num:[StateArg4]> Punkte Keyflare. Wenn das aktuelle Reich “Fleisch“ ist, wird das Maximum des Blutroten Ofens um <WeaponEffect_Num:[StateArg5]%> erhöht."
  },
  State_3755_WeaponDesc = {
    Text = "Der Schutzschild des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>, die Lebensregeneration erhöht sich um <WeaponEffect_Num:[StateArg1]%. Am Ende der ungeraden Runden erhöht sich die kritische Rate des Ausrüsters um +<WeaponEffect_Num:[StateArg2]%> und er erhält <WeaponEffect_Num:[StateArg3]> Punkte Aliemus; am Ende der geraden Runden erhöht sich der kritische Schaden des Ausrüsters um +<WeaponEffect_Num:[StateArg2]%> und er erhält <WeaponEffect_Num:[StateArg4]> Punkte Keyflare. Wenn das aktuelle Reich “Fleisch“ ist, wird das maximale Ansammeln des Blutroten Ofens um <WeaponEffect_Num:[StateArg5]%> erhöht."
  },
  State_3757_Desc = {
    Text = "Unser Team erhält bei jeder gespielten Karte [StateArg1] Schichten Schild. Hält 1 Runde"
  },
  State_3757_Name = {
    Text = "Fliegender Federhimmel"
  },
  State_3757_WeaponDesc = {
    Text = "Unser Team erhält bei jeder gespielten Karte [StateArg1] Schichten Schild. Hält 1 Runde"
  },
  State_3759_Name = {
    Text = "Mechanische Bewaffnung 1"
  },
  State_3760_Desc = {
    Text = "Wenn du mindestens [StateArg1] das schwarze Siegel hast, verliert [Exaltieren] [StateArg1] das schwarze Siegel, verwundbar und schwächt alle Feinde um 1 Runde"
  },
  State_3760_Name = {
    Text = "Schöpfung Ritualvogel des Unheils"
  },
  State_3760_WeaponDesc = {
    Text = "Wenn du mindestens [StateArg1] das schwarze Siegel hast, verliert [Exaltieren] [StateArg1] das schwarze Siegel, verwundbar und schwächt alle Feinde um 1 Runde"
  },
  State_3761_Desc = {
    Text = "Jedes Mal, wenn unser Team eine Stolperkarte zieht, erhalte [Layer] Stärke"
  },
  State_3761_Name = {
    Text = "Laternenzeremonie"
  },
  State_3761_WeaponDesc = {
    Text = "Jedes Mal, wenn unser Team eine Stolperkarte zieht, erhalte [Layer] Stärke"
  },
  State_3763_Desc = {
    Text = "Für jeden verursachten Schaden erhöht sich der kritische Schaden in dieser Runde um [StateArg3]%"
  },
  State_3763_Name = {
    Text = "Kanal zusammenklappen"
  },
  State_3763_WeaponDesc = {
    Text = "Für jeden verursachten Schaden erhöht sich der kritische Schaden in dieser Runde um [StateArg3]%"
  },
  State_3764_Name = {
    Text = "Mechanische Bewaffnung 2"
  },
  State_3766_Name = {
    Text = "Multiplikator der scharlachroten Kraft hinzufügen"
  },
  State_3767_Desc = {
    Text = "Zu Beginn der Runde fügst du einem zufälligen Gegner [Arg1] Schaden zu. Nach 7 gespielten „Schlägen“ in diesem Kampf wird der Schaden zu [Arg2]"
  },
  State_3767_Name = {
    Text = "Antikes Rätsel"
  },
  State_3768_Desc = {
    Text = "Aktiver Schaden trifft immer kritisch, am Ende der Runde entfernt"
  },
  State_3768_Name = {Text = "Zögern"},
  State_3768_WeaponDesc = {
    Text = "Aktiver Schaden trifft immer kritisch, am Ende der Runde entfernt"
  },
  State_3770_Name = {
    Text = "Arkane Relikt-Zähler der Schöpfung"
  },
  State_3771_Desc = {
    Text = "Beim Kampfbeginn 3 Arithmetica erhalten"
  },
  State_3772_Desc = {
    Text = "Die Racheklinge erhält für jeden verursachten Schaden temporäre Kraft, die dem aktuellen Tentakelschaden entspricht"
  },
  State_3772_Name = {
    Text = "Präventive Rache"
  },
  State_3773_Desc = {
    Text = "Am Zugende erleidet das Ziel <FixedDamage:Reinen SCH> in Höhe der Anzahl der Stapelungen."
  },
  State_3773_Name = {
    Text = "<IntoxicationIconKeywords:Gift>"
  },
  State_3773_WeaponDesc = {
    Text = "Zu Beginn der Runde erleidest du Schaden"
  },
  State_3774_Desc = {
    Text = "Nach jeder Auslösung von Aelius erhältst du eine Karte, die [Arg1] Punkte Gift anwendet, „Toxische Kontamination“. Am Ende der Runde können, wenn du in der Hand jeweils 3 „Toxische Kontamination“ hast, eine Karte, die Gift auslöst, „Toxische Ausbreitung“ kombiniert werden"
  },
  State_3776_Desc = {
    Text = "Bei jedem aktiven Schaden, erhöhe eine Schicht „Wachsamkeit“. Bei 3 Schichten, weiche zurück"
  },
  State_3776_Name = {
    Text = "Feige Puppe"
  },
  State_3776_WeaponDesc = {
    Text = "Bei jedem aktiven Schaden, erhöhe eine Schicht „Wachsamkeit“. Bei 3 Schichten, weiche zurück"
  },
  State_3777_Desc = {
    Text = "Nach dem Ausspielen erhält der zugehörige Erwachte [StateArg1] Wahnsinn"
  },
  State_3777_Name = {
    Text = "<Rune_5_High:Hochraserei>"
  },
  State_3777_WeaponDesc = {
    Text = "Nach dem Ausspielen erhält der zugehörige Erwachte [StateArg1] Wahnsinn"
  },
  State_3778_Desc = {
    Text = "Verursacht 25% mehr Schaden an Feinden mit negativen Zuständen, der Mörder erhält 20 Wahnsinn"
  },
  State_3779_Desc = {
    Text = "Obergrenze der Krakenarme um 2 verringert. Am Rundenende greifen alle Krakenarme einmal zusätzlich an"
  },
  State_3779_Name = {
    Text = "Schöpfung Schmerzheilige Armbinde"
  },
  State_3779_WeaponDesc = {
    Text = "Obergrenze der Krakenarme um 2 verringert. Am Rundenende greifen alle Krakenarme einmal zusätzlich an"
  },
  State_3781_Desc = {
    Text = "Zu Beginn der Runde, belege die obersten 2 Karten des Decks mit „Stagnationsfluch“"
  },
  State_3781_Name = {
    Text = "“Tiefenfluchauge“"
  },
  State_3781_WeaponDesc = {
    Text = "Zu Beginn der Runde, belege die obersten 2 Karten des Decks mit „Stagnationsfluch“"
  },
  State_3782_Desc = {
    Text = "Team-Einzigartig: Zu Beginn der Erkundung wird eine „VERT“-Karte des Ausrüsters ins Deck gemischt. Der Schild der „VERT“ des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>"
  },
  State_3782_WeaponDesc = {
    Text = "Zu Beginn der Erkundung wird eine “VERT“-Karte des Ausrüsters ins Deck gemischt. Der Schild der “VERT“ des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>."
  },
  State_3783_Desc = {
    Text = "Einzigartig für das Team: Der Grundschaden von Exaltieren des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>, die Schild- und Heilungseffekte erhöhen sich um <WeaponEffect_Num:[StateArg2]%>"
  },
  State_3783_WeaponDesc = {
    Text = "Der Grundschaden von Aelius des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>, während der Schild und die Lebensregeneration um <WeaponEffect_Num:[StateArg2]%> erhöht werden"
  },
  State_3784_Desc = {
    Text = "Einzigartig im Team: Grundschaden der Befehlskarten des Ausrüsters erhöht um <WeaponEffect_Num:[StateArg1]%>, Schild und Lebensregeneration um <WeaponEffect_Num:[StateArg2]%>"
  },
  State_3784_WeaponDesc = {
    Text = "Ausrüster: Grundschaden der Befehlskarten erhöht um <WeaponEffect_Num:[StateArg1]%>, Schild und Lebensregeneration um <WeaponEffect_Num:[StateArg2]%>"
  },
  State_3786_Desc = {
    Text = "Du bist markiert! Nach dem Ausspielen erhalten alle Monster [StateArg1] temporäre Stärke, und das Tiefseezeichen dieser Anweisung wird entfernt"
  },
  State_3786_Name = {
    Text = "<CardKeyWord:Tiefseezeichen>"
  },
  State_3786_WeaponDesc = {
    Text = "Nach dem Ausspielen der Karte erhält der Tiefseewächter [StateArg1] temporäre Stärke"
  },
  State_3787_Desc = {
    Text = "Team-Unique: Nach der Freisetzung des Exaltieren erhält jeder Verbündete <WeaponEffect_Num:[StateArg1]> Aelius"
  },
  State_3787_WeaponDesc = {
    Text = "Nach dem Einsatz von Wut-Exaltation erhält jeder Verbündete <WeaponEffect_Num:[StateArg1]> Wut"
  },
  State_3788_Desc = {
    Text = "Team-Einzigartig: Zu Beginn der Erkundung wird eine „Schlag“-Karte des Ausrüsters ins Deck gemischt. Der Grundschaden des „Schlags“ des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>"
  },
  State_3788_WeaponDesc = {
    Text = "Zu Beginn der Erkundung füge eine „Schlag“-Karte des Ausrüsters ins Deck ein, der Grundschaden des „Schlags“ des Ausrüsters wird um <WeaponEffect_Num:[StateArg1]%> erhöht"
  },
  State_3790_Desc = {
    Text = "Status@Unbestimmte Substanz Zähler"
  },
  State_3790_Name = {
    Text = "Status@Unbestimmte Substanz Zähler"
  },
  State_3790_WeaponDesc = {
    Text = "Status@Unbestimmte Substanz Zähler"
  },
  State_3791_Desc = {
    Text = "Jedes Mal, wenn Schaden verursacht wird, erhalte [Arg1] Schild, maximal 5 Mal pro Runde. Bei voller Schicht lege eine \"Inspiration\" auf die Hand"
  },
  State_3792_Desc = {
    Text = "Nicht mehr von Versteinerung betroffen"
  },
  State_3792_Name = {
    Text = "Versteinerungsresistenz"
  },
  State_3792_WeaponDesc = {
    Text = "Nicht mehr versteinert, stattdessen dreifacher Schaden"
  },
  State_3793_Desc = {
    Text = "Kritischer Schaden in diesem Level um [Layer] % erhöht"
  },
  State_3793_Name = {
    Text = "Permanenter Kritischer Schaden"
  },
  State_3793_WeaponDesc = {
    Text = "Kritischer Schaden in diesem Level um [Layer] % erhöht"
  },
  State_3794_Desc = {
    Text = "Der durch den Ausrüster verursachte Schaden, Schild und die Heilung erhöhen sich um [StateArg1]% (temporär)"
  },
  State_3794_Name = {
    Text = "Status@Prototyp Langschwert Schaden"
  },
  State_3796_Desc = {
    Text = "Bei jedem 20% Lebensverlust erhalten alle Erwachten 10 Wahnsinn, nach dem Tod erhöht sich der Tentakelschaden"
  },
  State_3796_Name = {
    Text = "ausgefallene Silberpartikel"
  },
  State_3796_WeaponDesc = {
    Text = "Bei jedem 20% Lebensverlust erhalten alle Erwachten 10 Wahnsinn, nach dem Tod erhöht sich der Tentakelschaden"
  },
  State_3797_Desc = {
    Text = "Bei jedem Schaden, erhalte [StateArg1] temporäre Stärke, entfernt zu Rundenbeginn"
  },
  State_3797_Name = {
    Text = "Die Wut der Rattenhorde!"
  },
  State_37980_Desc = {
    Text = "Domänenbeherrschung in diesem Kampf um [Layer] Punkte erhöht."
  },
  State_37980_Name = {
    Text = "Reichsbeherrschung"
  },
  State_3798_Desc = {
    Text = "Nach Verursachen von tatsächlichem Schaden wird Leben wiederhergestellt"
  },
  State_3798_Name = {
    Text = "Vampirische Klinge"
  },
  State_3798_WeaponDesc = {
    Text = "Nach Verursachen von tatsächlichem Schaden wird Leben wiederhergestellt"
  },
  State_3799_Desc = {
    Text = "Wenn im Team ein Erwecker der Beruf[caro] vorhanden ist, erhöht sich die maximale Gesundheit (unvollständig), VERT und ANG des gesamten Teams um 50%"
  },
  State_3799_Name = {
    Text = "Fleisch- und Blutbonus"
  },
  State_3799_WeaponDesc = {
    Text = "Wenn im Team ein Erwecker der Beruf[caro] vorhanden ist, erhöht sich die maximale Gesundheit (unvollständig), VERT und ANG des gesamten Teams um 50%"
  },
  State_3800_Desc = {
    Text = "Verursacht Schaden an allen Feinden. <CardKeyWord:Stärke> entfaltet mehrfachen Effekt auf diesen Schaden."
  },
  State_3800_Name = {
    Text = "<CardKeyWord:Großschwerts Macht>"
  },
  State_3801_Desc = {
    Text = "Beim Verursachen von unblockiertem Schaden, füge [StateArg1] Schichten Bluten hinzu"
  },
  State_3801_Name = {Text = "Blutung"},
  State_3802_Desc = {
    Text = "In der Hand verwandelt sich jede verwendete Befehlskarte in eine Kopie mit einem Arithmetica-Wert von 0"
  },
  State_3802_Name = {
    Text = "<CardKeyWord:Heiliger Sohn>"
  },
  State_3802_WeaponDesc = {
    Text = "In der Hand verwandelt sich jede verwendete Karte in eine Kopie mit einem Arithmetica-Wert von 0."
  },
  State_3803_Desc = {
    Text = "Zu Beginn des Kampfes wird bei allen Karten mit einem Verbrauch von 1 dieser aktuellen Arithmetica der Schaden, der Schild und die Heilung in diesem Kampf um [Arg1] Punkte erhöht"
  },
  State_3804_Desc = {
    Text = "Veränderter Dreizack-Zähler"
  },
  State_3804_Name = {
    Text = "Veränderter Dreizack-Zähler"
  },
  State_3804_WeaponDesc = {
    Text = "Veränderter Dreizack-Zähler"
  },
  State_3807_Name = {
    Text = "Schmuckstück Heiltraum"
  },
  State_3807_WeaponDesc = {
    Text = "Nach Beginn des Kampfes wird zusätzlich das gesamte Karten-Set des Benutzers in den Ziehstapel gemischt"
  },
  State_3808_Desc = {
    Text = "Status@Allgemeine Änderung aktuelles Leben"
  },
  State_3808_Name = {
    Text = "Status@Allgemeine Änderung aktuelles Leben"
  },
  State_3808_WeaponDesc = {
    Text = "Status@Allgemeine Änderung aktuelles Leben"
  },
  State_3810_Desc = {
    Text = "Nach dem Tod, Stärke anderer Verbündeter +"
  },
  State_3810_Name = {
    Text = "Todessprache"
  },
  State_3811_Desc = {
    Text = "Status@PrologDeckReset0_1_4_1"
  },
  State_3811_Name = {
    Text = "Status@PrologDeckReset0_1_4_1"
  },
  State_3811_WeaponDesc = {
    Text = "Status@PrologDeckReset0_1_4_1"
  },
  State_3813_Name = {
    Text = "Immune gegen Schwäche"
  },
  State_3815_Desc = {
    Text = "Am Ende der Runde verringert sich die automatische Wahnsinnsregeneration um [Layer]"
  },
  State_3815_Name = {
    Text = "<EnergyColour:Leere>"
  },
  State_3815_WeaponDesc = {
    Text = "Wahnsinnsverbrauch reduziert um [Layer] %."
  },
  State_3817_Desc = {
    Text = "Zu Beginn der Runde, füge dem Gegner [DescArg1] Erschöpfung zu"
  },
  State_3817_Name = {Text = "Verstreut"},
  State_3817_WeaponDesc = {
    Text = "Zu Beginn der Runde, erhält das Team [DescArg1*Layer*0.01] Erschöpfung"
  },
  State_3818_Name = {
    Text = "Zustand @ Wissender erleuchten 1"
  },
  State_3819_Name = {
    Text = "Zerbrechender Seelenfänger erleuchten 1"
  },
  State_3819_WeaponDesc = {
    Text = "Antike Imitation"
  },
  State_3821_Desc = {
    Text = "Zu Beginn der Runde, erhalte einen Schild in Höhe der Hälfte des im letzten Zug verlorenen Lebens"
  },
  State_3821_Name = {
    Text = "Schmerz und Vergnügen"
  },
  State_3821_WeaponDesc = {
    Text = "Nach Beginn der nächsten Runde, erhalte Schild in Höhe des verlorenen Lebens der letzten Runde"
  },
  State_3824_Desc = {
    Text = "Team Unique: Der Grundschaden von Aelius' Verherrlichung erhöht sich um [StateArg1]%. Zu Beginn der Erkundung tritt der Ausrüster in den Gelehrten-Persona-Zustand ein. Nach der Freisetzung von Verherrlichung wechselt der Ausrüster zwischen der Gelehrten-Persona und der Narr-Persona. \nGelehrten-Persona: Am Ende der Runde erhält der Ausrüster <WeaponEffect_Num:[StateArg2]> Punkte Aliemus. \nNarr-Persona: Am Ende der Runde erhöht sich die kritische Rate und der kritische Schaden des Ausrüsters um <WeaponEffect_Num:+[StateArg3]%. ."
  },
  State_3824_WeaponDesc = {
    Text = "Der Grundschaden von Aelius' Wut-Exaltation erhöht sich um [StateArg1]%. Zu Beginn der Erkundung wechselt der Ausrüster in den Gelehrten-Persönlichkeitsmodus. Nach dem Einsatz von Wut-Exaltation wechselt der Ausrüster zwischen der Gelehrten-Persönlichkeit und der Joker-Persönlichkeit. \nGelehrten-Persönlichkeit: Am Ende der Runde erhält der Ausrüster <WeaponEffect_Num:[StateArg2]> Punkte Wahnsinn. \nJoker-Persönlichkeit: Am Ende der Runde erhöht sich die kritische Rate und der kritische Schaden des Ausrüsters um <WeaponEffect_Num:+[StateArg3]%>."
  },
  State_3825_Desc = {
    Text = "Beim Erleiden von Aktivem Schaden wird der Schadensquelle <FixedDamage:Reiner SCH> in Höhe der Anzahl der Stapelungen zugefügt."
  },
  State_3825_Name = {
    Text = "<RetaliateIconKeywords: Theke>"
  },
  State_3825_WeaponDesc = {
    Text = "Jedes Mal, wenn Aktiver Schaden erlitten wird, wird dem Angreifer <FixedDamage:Reiner SCH> zugefügt."
  },
  State_3826_Name = {
    Text = "Status@TraumSilberschlüssel:ExplosionZählen"
  },
  State_3827_Desc = {
    Text = "Einzigartig für das Team: Die Lebensrückgewinnung des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%. Nach der Freisetzung von Exaltieren wird zu Beginn der nächsten Runde <WeaponEffect_Num:[StateArg2]%> der verlorenen Lebenspunkte wiederhergestellt"
  },
  State_3827_WeaponDesc = {
    Text = "Die Lebensregeneration des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>. Nach dem Einsatz von Aelius wird zu Beginn der nächsten Runde <WeaponEffect_Num:[DescArg1]%> des verlorenen Lebens regeneriert"
  },
  State_3830_Name = {
    Text = "1 zusätzliche Wirkung"
  },
  State_3831_Name = {
    Text = "Umkehrwurzel der Schöpfung"
  },
  State_3834_Desc = {
    Text = "Das Gift der Labyrinth-Spinne verdoppelt sich"
  },
  State_3834_Name = {
    Text = "Pfad der Verlorenen"
  },
  State_3835_Desc = {
    Text = "Innerhalb dieser Runde erhöht sich der kritische Schaden um [Layer] %"
  },
  State_3835_Name = {
    Text = "Temporärer Kritischer Schaden"
  },
  State_3835_WeaponDesc = {
    Text = "Innerhalb dieser Runde erhöht sich der kritische Schaden um [Layer] %"
  },
  State_3836_Desc = {Text = "Test123"},
  State_3836_Name = {Text = "Test123"},
  State_3837_Desc = {
    Text = "Team Unique: Das vom Ausrüster erzeugte Aliemus +<WeaponEffect_Num:[StateArg1]%> und das vom Ausrüster verursachte <IntoxicationIconKeywords:Gift> +<WeaponEffect_Num:[StateArg2]%>.\nNachdem der Ausrüster Aktiven Schaden verursacht, erhalten alle Erwecker einen Temporären Kritischen Schaden in Höhe von <WeaponEffect_Num:[StateArg3]%> des Basis-Krit.-Schadens des Ausrüsters.\nWenn das Reich Aequor umfasst, erhöht sich das Tentakel-Limit um +1 und zu Kampfbeginn wird 1 Tentakel beschworen."
  },
  State_3837_WeaponDesc = {
    Text = "Das vom Ausrüster erzeugte Aliemus +<WeaponEffect_Num:[StateArg1]%> und das vom Ausrüster verursachte <IntoxicationIconKeywords:Gift> +<WeaponEffect_Num:[StateArg2]%>.\nNachdem der Ausrüster Aktiven Schaden verursacht, erhalten alle Erwecker Temporären Kritischen Schaden +<WeaponEffect_Num:[DescArg1]%>.\nWenn das Reich Aequor umfasst, erhöht sich das Tentakel-Limit um +1 und zu Kampfbeginn wird 1 Tentakel beschworen."
  },
  State_3839_Desc = {
    Text = "Zu Beginn des Kampfes erhält man für jede Symptome-Karte im Deck [Arg1] Punkte Macht. Alle Symptome-Karten erhalten Schwäche"
  },
  State_3840_Desc = {
    Text = "Für jedes Mal, wenn die Lebenspunkte fallen, erhältst du [StateArg1] Alarm"
  },
  State_3840_Name = {
    Text = "Wachsamkeit"
  },
  State_3842_Desc = {
    Text = "Gesamter ausgeteilter Aktiver Schaden und Tentakelschaden –[DescArg1]%."
  },
  State_3842_Name = {Text = "Schwäche"},
  State_3842_WeaponDesc = {
    Text = "Verursachter Gesamtschaden um [DescArg1] % reduziert"
  },
  State_3843_Desc = {
    Text = "Jede Aktion fügt [Layer] Bluten hinzu"
  },
  State_3843_Name = {
    Text = "Schwere Verletzung"
  },
  State_3843_WeaponDesc = {
    Text = "Jede Aktion fügt [Layer] Bluten hinzu, das Heilen kann die Blutenwirkung entfernen"
  },
  State_3844_Desc = {
    Text = "Alle Schadensinstanzen des Wal-Sprungs +1"
  },
  State_3844_Name = {
    Text = "Kampfeslust"
  },
  State_3844_WeaponDesc = {
    Text = "Alle Schadensinstanzen des Wal-Sprungs +1"
  },
  State_3845_Desc = {
    Text = "Kartenrechenleistung verringert"
  },
  State_3845_Name = {
    Text = "Kartenrechenleistung verringert"
  },
  State_3845_WeaponDesc = {
    Text = "Kartenrechenleistung verringert"
  },
  State_3846_Name = {
    Text = "Schöpfung Jadeabdruck"
  },
  State_3848_Desc = {
    Text = "In diesem Kampf wird der Exaltieren eines zufälligen Erweckers versiegelt und kann nicht verwendet werden"
  },
  State_3848_Name = {Text = "Versiegelt"},
  State_3850_Desc = {
    Text = "Bei jeder [StateArg1] gespielten Karte, erhöhe [StateArg2] Tentakelschaden und alle Tentakel greifen 1 Mal an"
  },
  State_3850_Name = {
    Text = "Verwandelte Harpune"
  },
  State_3850_WeaponDesc = {
    Text = "Bei jeder [StateArg1] gespielten Karte, erhöhe [StateArg2] Tentakelschaden und alle Tentakel greifen 1 Mal an"
  },
  State_3851_Name = {
    Text = "Schmuckstück Theaterkatze"
  },
  State_3851_WeaponDesc = {
    Text = "Der gesamte verursachte Schaden erhöht sich um 10 % der maximalen Gesundheit des Ausrüsters"
  },
  State_3852_Desc = {
    Text = "Bei Bissschaden erhöht sich die Anzahl[Layer]"
  },
  State_3852_Name = {
    Text = "Steigerndes Beißen"
  },
  State_3852_WeaponDesc = {
    Text = "Bei Bissschaden erhöht sich die Anzahl[Layer]"
  },
  State_3853_Desc = {
    Text = "Zu Rundenbeginn verwandeln Sie sich zufällig in eine Kopie einer Befehlskarte aus dem Nachziehstapel, deren Arithmetica-Verbrauch fest auf 3 gesetzt ist; am Rundenende wird sie zurückverwandelt"
  },
  State_3853_Name = {
    Text = "<CardKeyWord:Wahn>"
  },
  State_3853_WeaponDesc = {
    Text = "Karten werden nicht in der Ablagephase in den Ablagestapel gelegt, sondern bleiben im Handkartenbereich"
  },
  State_3854_Desc = {
    Text = "Ziehe 2 Karten, was die Aufmerksamkeit des Schädeljägers erregt"
  },
  State_3854_Name = {
    Text = "<CardKeyWord:Gejagt>"
  },
  State_3855_Name = {Text = "Stärke"},
  State_3856_Desc = {
    Text = "Status@PrologDeckReset0_1_3_1"
  },
  State_3856_Name = {
    Text = "Status@PrologDeckReset0_1_3_1"
  },
  State_3856_WeaponDesc = {
    Text = "Status@PrologDeckReset0_1_3_1"
  },
  State_3859_Desc = {
    Text = "Atem der Fülle verdoppelt den Wahnsinn"
  },
  State_3859_Name = {
    Text = "Ad Matrem Vocatus"
  },
  State_3859_WeaponDesc = {
    Text = "Atem der Fülle verdoppelt den Wahnsinn"
  },
  State_3860_Desc = {
    Text = "Der durch den Ausrüster verursachte Schaden, Schild und die Heilung erhöhen sich um [StateArg1]% (temporär)"
  },
  State_3860_Name = {
    Text = "Status@Prototyp Messer Glück"
  },
  State_3862_Name = {
    Text = "Status@Stufe2_15Kampf4Blase1"
  },
  State_3863_Desc = {
    Text = "Nach 3 Auslösungen von Exaltieren senken sich die Arithmetica-Kosten für alle Handkarten um 1"
  },
  State_3866_Desc = {
    Text = "In dieser Runde, Handkartenlimit +[Layer]"
  },
  State_3866_Name = {
    Text = "Handkartenlimit erhöht"
  },
  State_3867_Name = {
    Text = "Hyperdimensionaler Berufszähler"
  },
  State_3868_Desc = {
    Text = "In dieser Runde verursachter Schild +[Layer]"
  },
  State_3868_Name = {
    Text = "Temporäre Vorsicht"
  },
  State_3868_WeaponDesc = {
    Text = "In dieser Runde verursachter Schild +[Layer]"
  },
  State_3872_Desc = {
    Text = "Schaden erleiden hebt temporäre Stärke auf"
  },
  State_3872_Name = {Text = "Zögern"},
  State_38730_Desc = {
    Text = "Nach Beginn der Runde, [DescArg1]% Chance, 1 Tentakelansammlung zu erhalten, über 100% können mehrere Schichten erhalten werden"
  },
  State_38730_Name = {
    Text = "Rückkehrlinie"
  },
  State_38735_Desc = {
    Text = "Verursachter Aktiver Schaden –[StateArg1] %, die Anzahl der Angriffe wird verdoppelt, und dies hält für [Layer] <plural value=\"[Layer]\" singular=\"Runde\" plural=\"Runden\"> an."
  },
  State_38735_Name = {Text = "Gemurmel"},
  State_38738_Desc = {
    Text = "Begrenzung von 10 Schichten, kann in die nächste Runde kämpfen"
  },
  State_38738_Name = {
    Text = "Traumköder"
  },
  State_3873_Desc = {
    Text = "Domänenbeherrschung in diesem Kampf um [Layer] Punkte erhöht"
  },
  State_3873_Name = {
    Text = "Reichsbeherrschung"
  },
  State_3874_Name = {
    Text = "Status@Windspiel Karten Wiederherstellung"
  },
  State_3876_Desc = {
    Text = "Jede gerade Runde reduziert die Kraft unseres Teams"
  },
  State_3876_Name = {
    Text = "Todesloch der Träume"
  },
  State_3878_Desc = {
    Text = "Für je 2 verlorene Lebenspunkte, erhalte zu Beginn der nächsten Runde [Layer] Schild"
  },
  State_3878_Name = {
    Text = "Schmerz und Vergnügen"
  },
  State_3878_WeaponDesc = {
    Text = "Nach Beginn der nächsten Runde, erhalte Schild in Höhe des verlorenen Lebens der letzten Runde"
  },
  State_3879_Desc = {
    Text = "Beim Aufheben erhöht sich die maximale Gesundheit um [Arg1] Punkte. Wenn die Gesundheit beim Aufheben unter 25 % liegt, wird die Erhöhung der maximalen Gesundheit auf [Arg2] Punkte reduziert"
  },
  State_3881_Desc = {
    Text = "Status@MonsterGeorgeWachsFigurEssen"
  },
  State_3881_Name = {
    Text = "Status@MonsterGeorgeWachsFigurEssen"
  },
  State_3881_WeaponDesc = {
    Text = "Status@MonsterGeorgeWachsFigurEssen"
  },
  State_3882_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_3882_Name = {
    Text = "Nicht erweckt"
  },
  State_3883_Desc = {
    Text = "In diesem Level wird die kritische Rate um [Layer]% erhöht"
  },
  State_3883_Name = {
    Text = "Permanente Kritische Trefferquote"
  },
  State_3883_WeaponDesc = {
    Text = "In diesem Level wird die kritische Rate um [Layer]% erhöht"
  },
  State_3884_Desc = {
    Text = "Jede Runde zusätzlich einen Embryo-Fusionsgrad generieren. Alle deine Verschlingungseffekte werden zu unendlichen Verschlungen"
  },
  State_3884_Name = {
    Text = "Schöpfung Pulsierende Nabelschnur"
  },
  State_3884_WeaponDesc = {
    Text = "Jede Runde zusätzlich einen Embryo-Fusionsgrad generieren. Alle deine Verschlingungseffekte werden zu unendlichen Verschlungen"
  },
  State_3888_Desc = {
    Text = "Kann den Wahnsinn nicht freisetzen und entfernt 1 Schicht am Ende der Runde"
  },
  State_3888_Name = {
    Text = "<CardKeyWord:Versiegeln>"
  },
  State_3888_WeaponDesc = {
    Text = "Alle Erwecker können die Wutverzweiflung nicht nutzen"
  },
  State_3890_Name = {
    Text = "Ziehe [DescArg1] Karten mehr aus dem Ablagestapel"
  },
  State_3893_Desc = {
    Text = "Beim Verursachen von Schaden erhält man [Arg1] Schild. Beim Heilen erhält man [Arg2] temporäre Kraft"
  },
  State_3893_Name = {
    Text = "Unser Zuhause"
  },
  State_3894_Desc = {
    Text = "Vor der Abwurfphase Handkarten in Steine verwandeln"
  },
  State_3894_Name = {
    Text = "Versteinern"
  },
  State_3894_WeaponDesc = {
    Text = "Vor der Abwurfphase Handkarten in Steine verwandeln"
  },
  State_3895_Desc = {
    Text = "Innerhalb dieser Runde erhöht sich die kritische Rate um [Layer] %"
  },
  State_3895_Name = {
    Text = "Temporäre Kritische Trefferquote"
  },
  State_3895_WeaponDesc = {
    Text = "Innerhalb dieser Runde erhöht sich die kritische Rate um [Layer] %"
  },
  State_3898_Desc = {
    Text = "Nach Beginn der nächsten Runde, erhältst du [Layer] Schildpunkte"
  },
  State_3898_Name = {
    Text = "Schmerz- und Freuden-Schild"
  },
  State_3900_Name = {
    Text = "Karte ist versiegelt, kann nicht ausgespielt werden, wird beim Abwerfen entsiegelt"
  },
  State_3901_Name = {
    Text = "Schöpfung Priesterstab Zähler"
  },
  State_3902_Desc = {
    Text = "In dieser Runde verursachter aktiver Schaden -[Layer]"
  },
  State_3902_Name = {Text = "STR▼"},
  State_3902_WeaponDesc = {
    Text = "In dieser Runde verursachter Schaden -[Layer]"
  },
  State_3904_Desc = {
    Text = "Pro verlorenen Lebenspunkt 1 Schicht entfernen, bei 0 Schichten [StateArg1] Schild erhalten und [StateArg2] Schichten Blutbarriere zurückerhalten"
  },
  State_3904_Name = {
    Text = "Erwachen - Blutschild"
  },
  State_3905_Desc = {
    Text = "Jedes Mal, wenn Aktiver Schaden erlitten wird, wird der SCH-Quelle [Layer] <FixedDamage:Reiner SCH> zugefügt."
  },
  State_3905_Name = {
    Text = "Gegenangriff"
  },
  State_3905_WeaponDesc = {
    Text = "Jedes Mal, wenn Aktiver Schaden erlitten wird, wird dem Angreifer [Layer] <FixedDamage:Reiner SCH> zugefügt."
  },
  State_3906_Name = {
    Text = "Residueller Silberkern"
  },
  State_3907_Name = {
    Text = "Residueller Silberkern"
  },
  State_3908_Desc = {
    Text = "Wenn das Gehirn im Glas Wiederherstellung anwendet, ziehe [Arg2] Karten"
  },
  State_3908_Name = {
    Text = "Realität und Illusion"
  },
  State_3908_WeaponDesc = {
    Text = "Wenn das Gehirn im Glas Wiederherstellung anwendet, ziehe [Arg2] Karten"
  },
  State_3909_Name = {
    Text = "Residueller Silberkern"
  },
  State_3910_Name = {
    Text = "Residueller Silberkern"
  },
  State_3911_Name = {
    Text = "Residueller Silberkern"
  },
  State_3912_Name = {
    Text = "Residueller Silberkern"
  },
  State_3913_Desc = {
    Text = "Team-Einzigartig: Die Schildgenerierung des Trägers +<WeaponEffect_Num:[StateArg1]%>. Zu Rundenbeginn werden <WeaponEffect_Num:[StateArg2]%> der verbleibenden Schilde beibehalten, maximal bis zu <WeaponEffect_Num:[StateArg3]%> der maximalen HP."
  },
  State_3913_WeaponDesc = {
    Text = "Die Schildgenerierung des Trägers +<WeaponEffect_Num:[StateArg1]%>. Zu Rundenbeginn werden <WeaponEffect_Num:[StateArg2]%> der verbleibenden Schilde beibehalten, maximal bis zu <WeaponEffect_Num:[StateArg3]%> der maximalen Lebenspunkte."
  },
  State_3914_Desc = {
    Text = "Nach dem Auslösen der Wahnexplosion zum zweiten Mal pro Runde erhalten alle Erwecker 10 Punkte Wahn. Nach dem Auslösen der Wahnexplosion zum dritten Mal pro Runde wird die Wahn-Abklingzeit aller Erwecker zurückgesetzt und sie erhalten 10 Punkte Wahn"
  },
  State_3915_Name = {
    Text = "Residueller Silberkern"
  },
  State_3916_Name = {
    Text = "Residueller Silberkern"
  },
  State_3917_Desc = {
    Text = "Temporäre Stärke im nächsten Zug"
  },
  State_3917_Name = {Text = "Aufladen"},
  State_3918_Desc = {
    Text = "Zu Beginn jeder Runde den Zustand erhalten, dass der erste erlittene Schaden verdoppelt wird"
  },
  State_3918_Name = {Text = "Stolz"},
  State_3918_WeaponDesc = {
    Text = "Zu Beginn jeder Runde den Zustand erhalten, dass der erste erlittene Schaden verdoppelt wird"
  },
  State_3921_Desc = {
    Text = "In dieser Runde Karten bleiben in der Hand und gehen nicht auf den Ablagestapel"
  },
  State_3921_Name = {
    Text = "<RetainIconKeywords:Behalten>"
  },
  State_3921_WeaponDesc = {
    Text = "Karten werden nicht in der Ablagephase in den Ablagestapel gelegt, sondern bleiben im Handkartenbereich"
  },
  State_3923_Desc = {
    Text = "Kartenrechenleistung verringert"
  },
  State_3923_Name = {
    Text = "Permanente Reduktion der Rechenleistung von Karten"
  },
  State_3923_WeaponDesc = {
    Text = "Kartenrechenleistung verringert"
  },
  State_3925_Name = {
    Text = "Zustand @ Kapitel 4 Resonanz @ Unsere Truppenrunde Beginn Arithmetica 2"
  },
  State_3926_Desc = {
    Text = "“Verdrehte Leichenfeier“ erhöht Schaden um [Layer]"
  },
  State_3926_Name = {Text = "Verzerrung"},
  State_3926_WeaponDesc = {
    Text = "„Raserei“-Schaden erhöht"
  },
  State_3927_Desc = {
    Text = "Nach dem Ziehen von „Leere“ wird der Wahnsinnszuwachs aller Erwachten in dieser Runde um [Layer]% reduziert"
  },
  State_3927_Name = {Text = "Leere"},
  State_3927_WeaponDesc = {
    Text = "Nach dem Ziehen von „Leere“ wird der Wahnsinnszuwachs aller Erwachten in dieser Runde um [Layer]% reduziert"
  },
  State_3928_Desc = {
    Text = "Wenn der süße Dämon Schaden verursacht, erhält er [StateArg2] Gegenangriff."
  },
  State_3928_Name = {
    Text = "Geben und nehmen"
  },
  State_3929_Desc = {
    Text = "Erhalte 50% weniger Kraft und Schild, entferne 1 Schicht am Ende der Runde"
  },
  State_3929_Name = {
    Text = "<CardKeyWord:Fluch>"
  },
  State_3929_WeaponDesc = {
    Text = "In dieser Runde immun gegen positive Zustände"
  },
  State_3930_Name = {
    Text = "Zustand @ Kapitel 4 Resonanz @ Unsere Truppenrunde Beginn Arithmetica 1"
  },
  State_3931_Name = {
    Text = "Status@Hymne von Blut und Sand"
  },
  State_3932_Desc = {
    Text = "Verleiht der Karte Behalten, jede Schicht Stagnationsfluch erhöht die Kosten um 1, nach dem Ausspielen wird der Fluch entfernt"
  },
  State_3932_Name = {
    Text = "Erstarrungsfluch([Layer])"
  },
  State_3932_WeaponDesc = {
    Text = "Verleiht der Karte Behalten, jede Schicht Stagnationsfluch erhöht die Kosten um 1, nach dem Ausspielen wird der Fluch entfernt"
  },
  State_3933_Desc = {
    Text = "Erhöhe [Layer] VERT"
  },
  State_3933_Name = {
    Text = "Temporäre VERT erhöht"
  },
  State_3933_WeaponDesc = {
    Text = "Erhöhe [Layer] VERT"
  },
  State_3934_Desc = {
    Text = "Erhalte 50% weniger Schild"
  },
  State_3934_Name = {
    Text = "Vernichtungsverwundbarkeit"
  },
  State_3934_WeaponDesc = {
    Text = "Erhalte 50% weniger Schild"
  },
  State_3935_Desc = {
    Text = "Unser Team erhält bei jeder gespielten Karte eine Schicht „Beobachtung“, bei zehn Schichten erfolgt Betäubung"
  },
  State_3935_Name = {
    Text = "Beobachtung"
  },
  State_3936_Desc = {
    Text = "Der durch den Ausrüster verursachte Schaden, Schild und die Heilung erhöhen sich um [StateArg1]% (temporär)"
  },
  State_3936_Name = {
    Text = "Status@Prototyp Langschwert Domäne"
  },
  State_3937_Desc = {
    Text = "Wenn die Dornenkönigin eine Gegenwehr anwendet, erhält sie die Hälfte des Schildes der Gegenwehr"
  },
  State_3937_Name = {
    Text = "Wand der Leichen"
  },
  State_3938_Name = {
    Text = "Erstelle Wachsfigur"
  },
  State_3941_Desc = {
    Text = "Beim Verschlingen des Embryos, vom Ablagestapel zurück zum Handstapel"
  },
  State_3941_Name = {
    Text = "Farblose Spirale"
  },
  State_3941_WeaponDesc = {
    Text = "Beim Verschlingen des Embryos, vom Ablagestapel zurück zum Handstapel"
  },
  State_3942_Name = {
    Text = "Schmuck Rückkehrlinie"
  },
  State_3942_WeaponDesc = {
    Text = "Nach Kampfbeginn, wenn der Träger Tiefsee-Klasse ist, +25% ANGskraft"
  },
  State_3943_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_3943_Name = {
    Text = "Nicht erweckt"
  },
  State_3944_Desc = {
    Text = "Nach dem Ende der Runde erhalten alle Erwecker 5 Wahnsinn. Für jeden verbleibenden Punkt Arithmetica erhalten alle Erwecker zusätzlich 3 Wahnsinn"
  },
  State_3945_Desc = {
    Text = "Alle Schöpfungspreise um 50% gesenkt"
  },
  State_39547_Desc = {
    Text = "Nach Kampfende zusätzliche 5 schwarze Siegel erhalten, dieser Effekt wird durch schwarze Siegel-Drop erhöht. Nach Wanda's Kartenausspielung 1 Stapel Traumleiter erhalten, maximal 2 Mal pro Runde. Aktuell verbleibend [DescArg1] Mal"
  },
  State_39547_Name = {
    Text = "Pelz und Venus"
  },
  State_40483_Name = {
    Text = "Zerstörte Hellebarde"
  },
  State_40484_Desc = {
    Text = "Wenn Wandas Fähigkeit den Sprung-Effekt auslöst, verbrauche 5 Schichten, falls vorhanden, und erhalte einen zusätzlichen Effekt. Die Obergrenze von Traumführer beträgt 10 Schichten und wird in den nächsten Kampf übernommen."
  },
  State_40484_Name = {
    Text = "<PurpleKeyWord:Traumführung>"
  },
  State_41337_Desc = {
    Text = "Nach Rundenende +[Layer] Leben"
  },
  State_41337_Name = {
    Text = "Rosa Sieg-Antworten"
  },
  State_41340_Desc = {
    Text = "Einzigartig für das Team: Schilde und Theke des Trägers erhöhen sich um <WeaponEffect_Num:[StateArg1]%>. Bei ANG, gibt es eine <WeaponEffect_Num:[StateArg2]%> Chance, dass alle Erwecker 1 Punkt Aelius erhalten"
  },
  State_41340_WeaponDesc = {
    Text = "Der Ausrüster erhöht Schutzschild und Theke um <WeaponEffect_Num:[StateArg1]%>. Bei jedem ANG besteht eine <WeaponEffect_Num:[StateArg2]%> Chance, dass alle Erwecker 1 Punkt Wahnsinn erhalten."
  },
  State_41342_Name = {
    Text = "Veränderungseffekt"
  },
  State_41344_Name = {
    Text = "Veränderungseffekt"
  },
  State_41360_Desc = {
    Text = "Verbrauche 5 Schichten<DreamGuide:Traumführer>, Wanda erhält <Energy:[StateArg1]> Punkte Aelius, erhalte temporär <RetaliateIconKeywords:Gegenangriff> in Höhe von [StateArg2] % dauerhaften <RetaliateIconKeywords:Gegenangriff>"
  },
  State_41360_Name = {
    Text = "Schlummerzähler"
  },
  State_41361_Desc = {
    Text = "Verbrauche 10 Stapelungen <DreamGuide:Traumköder>, wodurch alle Feinde für 1 Runde in den „Murmeln“-Zustand versetzt werden: Verursachter Aktiver Schaden –[StateArg3] %, aber die Anzahl der Angriffe wird verdoppelt."
  },
  State_41361_Name = {
    Text = "Echos von Flüstern"
  },
  State_43818_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_43818_Name = {
    Text = "Nicht erweckt"
  },
  State_44398_Desc = {
    Text = "Nach der ersten gespielten Karte jeder Runde füge 1 „VERT“ des entsprechenden Wächters der Hand hinzu"
  },
  State_44484_Name = {
    Text = "Kann 3 Mal in Anführer-Kämpfen verwendet werden"
  },
  State_44485_Name = {
    Text = "(Verbleibend: [Layer])"
  },
  State_44491_Name = {
    Text = "Deaktiviere Effekt"
  },
  State_44562_Name = {
    Text = "Deaktiviere Effekt"
  },
  State_44575_Desc = {
    Text = "In dieser Runde verbleibender Schild bleibt bis zur nächsten Runde"
  },
  State_44575_Name = {
    Text = "Schutzschild beibehalten"
  },
  State_44653_Desc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwecker 20 Aelius. Beim Aufsammeln reduziert sich die maximale Gesundheit um 50%"
  },
  State_44665_Desc = {
    Text = "Innerhalb dieser Runde erhöht sich die Krit. Rate des “Schlag“ um [Layer] %."
  },
  State_44665_Name = {
    Text = "Schlag kritische Rate"
  },
  State_44667_Desc = {
    Text = "“Schlag“ erhält [DescArg1] Punkte Arithmetica. Wenn die aktuelle Haltung „Wogen“ ist, werden keine Arithmetica erhalten, sondern 1 Tentakel greift [DescArg2] Mal an"
  },
  State_44667_Name = {
    Text = "Herrschaft des Riesen"
  },
  State_44671_Desc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwecker 25 Aelius. Beim Aufsammeln wird die maximale Gesundheit auf das 3-fache erhöht"
  },
  State_44672_Name = {
    Text = "Gesegnet: Schwarmintelligenz"
  },
  State_44711_Desc = {
    Text = "Relikt-Obergrenze +5, [D-Marke] Erneuerung +1. Nach dem Kampf erhält man 125 das schwarze Siegel, beim Aufnehmen können bis zu 6 Symptom-Karten zum Löschen ausgewählt werden"
  },
  State_44713_Desc = {
    Text = "Nach Kampfende zusätzliche 100 schwarze Siegel und 2 Symptomkarten erhalten"
  },
  State_44730_Desc = {
    Text = "Zu Beginn der Runde wird <Heal:[Heal:StateArg1]> Punkte Rückgewinnung des purpurnen Ofens angesammelt"
  },
  State_44730_Name = {Text = "erlösen"},
  State_44731_Desc = {
    Text = "Mit Leiden leiden. Alle verbliebenen Heilungsmengen des Blutroten Ofens konsumieren, jeder konsumierte Punkt erhöht den Schaden um 3 (9 während eines Anführer Kampfes). Für jedes 1% Max LP des Blutroten Ofens, das konsumiert wird, erhöht sich der Gesamtschaden um [DescArg1]%."
  },
  State_44731_Name = {Text = "Befreiung"},
  State_44732_Desc = {
    Text = "Mit Blut retten. Nach verursachtem Schaden 10 % des aktuellen Lebens verlieren, um eine Rückmeldemenge des Purpurnen Ofens in Höhe des verlorenen Lebens zu sammeln"
  },
  State_44732_Name = {Text = "Hingabe"},
  State_44739_Desc = {
    Text = "Nach dem Aufheben verliert man dauerhaft [Arg1] Kraft. Bei jedem verursachten Schaden werden [Arg2] Lebenspunkte wiederhergestellt, maximal 6 Mal pro Runde"
  },
  State_44739_Name = {
    Text = "Sünden·Kuss der Neunmäuler"
  },
  State_44740_Name = {
    Text = "Gesegnet: Neunaugenkuss"
  },
  State_44741_Desc = {
    Text = "Nach dem Aufheben verliert man dauerhaft [Arg1] Kraft. Bei jedem verursachten Schaden werden [Arg2] Lebenspunkte wiederhergestellt, maximal 6 Mal pro Runde"
  },
  State_44741_Name = {
    Text = "Sünden·Kuss der Neunmäuler"
  },
  State_44742_Desc = {
    Text = "Nach dem Aufheben verliert man dauerhaft [Arg1] Kraft. Bei jedem verursachten Schaden werden [Arg2] Lebenspunkte wiederhergestellt, maximal 6 Mal pro Runde"
  },
  State_44742_Name = {
    Text = "Gesegnet: Neunaugenkuss"
  },
  State_44743_WeaponDesc = {
    Text = "Zu Beginn des Kampfes 3 Runden lang selbst verletzlich"
  },
  State_44744_WeaponDesc = {
    Text = "Zu Beginn des Kampfes 3 Runden lang selbst verletzlich"
  },
  State_44750_Desc = {
    Text = "Zu Rundenbeginn erhalten Sie [StateArg1] Arithmetica"
  },
  State_44750_Name = {
    Text = "Schwarze Kerze der Schöpfung 1"
  },
  State_44751_Desc = {
    Text = "Zu Rundenbeginn erhalten Sie [StateArg1] Arithmetica"
  },
  State_44751_Name = {
    Text = "Schwarze Kerze der Schöpfung 1"
  },
  State_44752_Desc = {
    Text = "Jedes Mal, wenn „Sophia“ 1 Lebenspunkt verliert, sinkt eine Schicht. Bei 0 Schichten wird die Absicht zu „Zahn um Zahn“ und erhält [StateArg2] Schild. Beim ersten Auslösen werden alle Schichten wiederhergestellt"
  },
  State_44752_Name = {
    Text = "Vergrabene Impuls"
  },
  State_44762_Desc = {
    Text = "Wenn du „VERT“ spielst, mische 1 Wundenkarte in den Nachziehstapel"
  },
  State_44762_Name = {Text = "Zerreißen"},
  State_44763_Desc = {
    Text = "Alle Erwecker haben kritischen Schadensbonus halbiert"
  },
  State_44763_Name = {
    Text = "<PurpleKeyWord: Blind>"
  },
  State_44764_Desc = {
    Text = "Wenn du „ANG“ spielst, mische 1 Wundenkarte in den Nachziehstapel"
  },
  State_44764_Name = {Text = "Verletzung"},
  State_44807_Desc = {
    Text = "Beim ersten drohenden Niederlage, Lebenspunkte wiederherstellen und Absicht in „Spiegelurteil“ ändern, um sich zu stärken. Beim zweiten drohenden Niederlage, Lebenspunkte wiederherstellen und Absicht in „Wahnsinnsbiss“ ändern, um extrem hohen Einzelschaden zu verursachen"
  },
  State_44807_Name = {
    Text = "Vergrabene Schlacht"
  },
  State_44819_Desc = {
    Text = "Wenn es keine <ParcloseIconKeywords:Schild> gibt, erhalte 1 Schicht temporäre <ParcloseIconKeywords:Schild>, andernfalls erhalte 10% Krit. Rate und Krit. Schaden."
  },
  State_44819_Name = {
    Text = "<CardKeyWord:Vatergott-Schutz>"
  },
  State_44828_Desc = {
    Text = "Team Unique: Am Rundenende erhält der Ausrüster [StateArg1] Aliemus. Beim Erleiden von Aktivem Schaden und Tentakelschaden erhält er zu Beginn der nächsten Runde ein Rollen-Schild in Höhe von <WeaponEffect_Num:[StateArg2]%> des Schadens. Wenn das aktuelle Reich Caro ist, erhält er stattdessen einen Blutroter Ofen in Höhe von <WeaponEffect_Num:[StateArg2]%> des Schadens."
  },
  State_44828_WeaponDesc = {
    Text = "Am Rundenende erhält der Ausrüster <WeaponEffect_Num:[StateArg1]> Aliemus. Beim Erleiden von Aktivem Schaden oder Tentakelschaden erhält er zu Beginn der nächsten Runde ein Rollen-Schild in Höhe von <WeaponEffect_Num:[Float:StateArg2]%> des Schadens. Wenn das aktuelle Reich Caro ist, erhält er stattdessen einen Blutroter Ofen in Höhe von <WeaponEffect_Num:[Float:StateArg2]%> des Schadens."
  },
  State_44889_Name = {
    Text = "Status@Hundegesicht-BOSS@Endspiegel1"
  },
  State_44890_Name = {
    Text = "Status@Hundegesicht-BOSS@Endspiegel2"
  },
  State_44891_Name = {
    Text = "Status@Hundegesicht-BOSS@Endspiegel3"
  },
  State_44903_Desc = {
    Text = "Beim Erleiden von Aktivem Schaden oder Tentakelschaden werden [StateArg1]% des SCH in den Wiederherstellungsbetrag für den Blutroter Ofen umgewandelt, für [Layer] <plural value=\"[Layer]\" singular=\"Runde\" plural=\"Runden\">."
  },
  State_44903_Name = {
    Text = "Segen des Schöpfers"
  },
  State_44909_Name = {
    Text = "verbrauchbar"
  },
  State_45018_Desc = {
    Text = "Vor Rundenende, keine „Schlag“-Karten spielbar"
  },
  State_45018_Name = {Text = "Lähmung"},
  State_45025_Desc = {
    Text = "Die spezifischen Effekte hängen von der allgemeinen Schlaglogik ab."
  },
  State_45029_Desc = {
    Text = "Der spezifische Effekt folgt der allgemeinen Schlaglogik."
  },
  State_45032_Desc = {
    Text = "Am Ende der nächsten Runde erleide [Layer] Schaden."
  },
  State_45032_Name = {Text = "Bluten"},
  State_45039_Desc = {
    Text = "Bis zum Beginn des nächsten Zuges wird beim Erleiden von Aktivem Schaden oder Tentakelschaden zu Beginn des nächsten Zuges ein Rollen-Schild in Höhe von [Layer]% des erlittenen Schadens gewährt."
  },
  State_45039_Name = {
    Text = "Wunderdämmerung"
  },
  State_45040_Desc = {
    Text = "Bis zum Beginn des nächsten Zuges wird beim Erleiden von Aktivem Schaden oder Tentakelschaden [Layer]% des Schadens als Heilung für den Blutroten Ofen angesammelt."
  },
  State_45040_Name = {
    Text = "Wunderdämmerung"
  },
  State_45049_Desc = {
    Text = "Negiert den Schaden des nächsten aktiven Angriffs (bis zu 3 Stapelungen). Jede Stapelungen von Deathmatch reduziert die maximalen Barriere-Stapelungen um 1, entfernt jedoch keine bereits erhaltenen Barrieren."
  },
  State_45049_Name = {Text = "Schild"},
  State_45050_Desc = {
    Text = "Negiert den Schaden des nächsten aktiven Angriffs (bis zu 3 Stapelungen). Jede Stapelungen von Deathmatch reduziert die maximalen Barriere-Stapelungen um 1, entfernt jedoch keine bereits erhaltenen Barrieren."
  },
  State_45050_Name = {
    Text = "<ReinforceColour:Barriere>"
  },
  State_45064_Name = {
    Text = "Zähler des stillen Festmahls__„Dev Only\""
  },
  State_45069_Desc = {
    Text = "Die genauen Effekte hängen von der allgemeinen Schlaglogik ab."
  },
  State_45072_Name = {
    Text = "Heiligungszähler"
  },
  State_45073_Desc = {
    Text = "Kartenrechenleistung verringert"
  },
  State_45076_Desc = {
    Text = "Löse die Schilde und verzögerten Heilungen des Ziels auf, bevor die Runde endet, wird die erhaltene Heilung und der Schild um 50% verringert"
  },
  State_45076_Name = {Text = "Verderben"},
  State_45137_Desc = {
    Text = "Nach Nutzung des Wahnsinns Exaltieren alle Weckkörper für eine Runde versiegeln und erhalten eine Runde verwundbar"
  },
  State_45137_Name = {
    Text = "Erbsünde: Der Weg des Knochens"
  },
  State_45139_Desc = {
    Text = "Nach Nutzung des Wahnsinns Exaltieren willkürlich einen negativen Zustand auflösen"
  },
  State_45139_Name = {
    Text = "Gesegnet: Überreste des Pfadläufers"
  },
  State_45148_Desc = {
    Text = "Alle Erwecker haben kritischen Schadensbonus halbiert"
  },
  State_45148_Name = {
    Text = "<PurpleKeyWord: Blind>"
  },
  State_45166_Desc = {
    Text = "Die Schicksalsräder der durch Umschlingen betroffenen Erwecker werden ungültig, am Ende der Runde wird 1 Schicht entfernt, maximal 3 Schichten stapelbar."
  },
  State_45166_Name = {
    Text = "Umschlingen"
  },
  State_45206_Desc = {
    Text = "Mit Glauben die Welt retten. Alle verbliebenen Rückmeldemengen des Purpurnen Ofens konsumieren, um einen Schild in Höhe von 150 % der Verbrauchsmenge zu erhalten, dieser Schild ist nicht von Schildbuffs oder -debuffs betroffen und ignoriert die Schildobergrenze"
  },
  State_45206_Name = {Text = "Erlösung"},
  State_45248_Name = {Text = "Zähler"},
  State_45328_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: “Verherrlichung“ gibt dir <TauntKeywords:Verspotten> und <Block:[Block:StateArg1]> Schild."
  },
  State_45328_Name = {Text = "35mm Magie"},
  State_45329_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: „Schlag“ wählt Ziel, schiebt vor „Schlag“ alle entfernenden positiven Zustände des Ziels zu den Erwachten dahinter."
  },
  State_45329_Name = {
    Text = "Der Ruf der Tiefe See"
  },
  State_45331_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Beim Ausrüsten und nach “Schlag“ werden die nicht abgeleiteten “Fähigkeiten“ des Ausrüsters in der Hand nacheinander in andere “Fähigkeiten“ des Ausrüsters umgewandelt [ShowIfState:, <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]."
  },
  State_45331_Name = {
    Text = "Blumen und Gedichte der Vergangenheit"
  },
  State_45332_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>：Bei jedem erlittenen Schaden + <Energy:[Energy:StateArg1]>Wahnsinn für andere Verbündete"
  },
  State_45332_Name = {
    Text = "Der Blick von Isarau"
  },
  State_45333_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Maximale Handgröße +[StateArg1], “Verherrlichung“ gibt dir <Energy:[Energy:StateArg2]> Aliemus."
  },
  State_45333_Name = {
    Text = "Glühender Abschiedskuss"
  },
  State_45334_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>：“Fähigkeit“nächster „Schlag“ in dieser Runde trifft zufälliges Ziel und zusätzlich [StateArg1] zufällige Ziele"
  },
  State_45334_Name = {
    Text = "Spiegelbild"
  },
  State_45345_Desc = {
    Text = "Zum Aufzeichnen der Nutzung von Stufe-1-Fertigkeiten"
  },
  State_45345_Name = {
    Text = "Geburtszeichen 1"
  },
  State_45346_Desc = {
    Text = "Zum Aufzeichnen der Nutzung von Stufe-2-Fertigkeiten"
  },
  State_45346_Name = {
    Text = "Geburtszeichen 2"
  },
  State_45354_Desc = {
    Text = "Diese Karte kann nicht ausgespielt werden."
  },
  State_45354_Name = {
    Text = "kann nicht ausführen"
  },
  State_45356_Desc = {
    Text = "Am Ende des Zuges verwandle dich in die zuletzt gespielte „Fähigkeit“-Karte und reduziere ihre Arithmetica-Kosten um 2. Nach dem Ausspielen wird „Entität des grauen Nebels“ in das Deck gemischt."
  },
  State_45356_Name = {
    Text = "<CardKeyWord:Nebelgestalt>"
  },
  State_45364_Desc = {
    Text = "Nach Beginn der nächsten Runde, erhält diese Erwachte [Layer] „Schlag“"
  },
  State_45364_Name = {
    Text = "Verzögerter Treffer"
  },
  State_45385_Desc = {
    Text = "Der gesamte in diesem Kampf verursachte Schaden wird um [Layer] Punkte verringert und kann nicht beseitigt werden, darunter [DescArg1] Ebenen temporärer Machtminderung, die am Ende der Runde entfernt werden"
  },
  State_45385_Name = {Text = "STR▼"},
  State_45387_Desc = {
    Text = "Alle verursachten DMG +[Layer] in diesem Kampf und kann nicht aufgehoben werden. [DescArg1] Stapel temporärer STR werden am Ende der Runde entfernt."
  },
  State_45387_Name = {Text = "Stärke"},
  State_45397_Desc = {
    Text = "Zu Beginn der Runde wird 1 Schicht Barriere in Stärke umgewandelt."
  },
  State_45397_Name = {
    Text = "Sieg der Rosen"
  },
  State_45403_Desc = {
    Text = "Nach Beginn der nächsten Runde, erhalte [Layer] Aufladung"
  },
  State_45403_Name = {
    Text = "Verzögerte Aufladung"
  },
  State_45407_Desc = {
    Text = "Erhaltener Wahnsinn und verzögerter Wahnsinn werden um 50 % reduziert, und der gesamte verzögerte Wahnsinn wird sofort entfernt."
  },
  State_45407_Name = {Text = "Leere"},
  State_45656_Desc = {
    Text = "Dritte Wiederbelebung des Mutterbaums, aktiviert Fortpflanzung 2 Fähigkeit"
  },
  State_45658_Desc = {
    Text = "Erste Wiederbelebung des Mutterbaums, aktiviert Fortpflanzungsfähigkeit"
  },
  State_45661_Desc = {
    Text = "Wenn das Leben auf 0 fällt, wird es auf 1 gesetzt, nimmt keinen Schaden mehr und bereitet die Freisetzung von „Mehrfachfusion“ vor"
  },
  State_45661_Name = {
    Text = "Multi-Fusion"
  },
  State_45715_Desc = {
    Text = "Erhalte temporäre Kraft in Höhe von [StateArg1]% Tentakelschaden"
  },
  State_45715_Name = {Text = "Usurpieren"},
  State_45716_Desc = {
    Text = "Erhalte vorübergehende Machtpunkte, die [StateArg1]% des Tentakelschadens entsprechen. Goliath erhält 25% vorübergehende kritische Rate"
  },
  State_45716_Name = {Text = "Usurpieren"},
  State_45717_Desc = {
    Text = "Erhöht den Grundschaden von „Großschwerts Macht“ und „Enthauptungsschaden“ um 25%. Goliath erhält <Energy:[Energy:StateArg2]> Punkte Aelius"
  },
  State_45717_Name = {
    Text = "Ruhezustand"
  },
  State_45718_Desc = {
    Text = "Erhöht den Grundschaden von „Großschwerts Macht“ und „Enthauptungsschaden“ um 25% in diesem Kampf"
  },
  State_45718_Name = {
    Text = "Ruhezustand"
  },
  State_46057_Name = {
    Text = "Arithmetica"
  },
  State_46079_Desc = {
    Text = "In dieser Runde, bei jedem erlittenen aktiven Schaden, heilt der verbündete mit dem meisten verlorenen Leben [Layer] Leben"
  },
  State_46079_Name = {
    Text = "Führung durch das Heilige Blut"
  },
  State_46119_Desc = {
    Text = "Bei der nächsten Attacke wird der Angreifer mit verflechten belegt"
  },
  State_46119_Name = {
    Text = "Labyrinthfalle"
  },
  State_46124_Desc = {
    Text = "Vor Rundenende, keine Aktionen möglich"
  },
  State_46124_Name = {
    Text = "Versteinern"
  },
  State_46138_Desc = {
    Text = "Wandle in die letzte gespielte „Fähigkeit“ des Gegners um, Kosten -1"
  },
  State_46138_Name = {
    Text = "<CardKeyWord:Sternen-Mimikry>"
  },
  State_46139_Desc = {
    Text = "Bei jedem erlittenen aktiven Schaden erhält man Aufladen und fügt dem Angreifer Stagnierung zu."
  },
  State_46139_Name = {
    Text = "Anomale Schwerkraft"
  },
  State_46155_Desc = {
    Text = "Nach der eigenen „Fähigkeit“ erhalte [StateArg1] Schichten Aufladung und verringere die Schichten um 1, am Ende der Runde verbrauche alle abnormen Blutpunkte und heile <Heal:[Heal:StateArg2]> Leben pro Schicht"
  },
  State_46155_Name = {
    Text = "Abnormes Blut"
  },
  State_46243_Name = {
    Text = "Einblick-Zähler__„Nur Entw.\""
  },
  State_46255_Desc = {
    Text = "Die genauen Effekte hängen von der allgemeinen Schlaglogik ab."
  },
  State_46256_Desc = {
    Text = "Die spezifischen Effekte sind im allgemeinen Schlag-Logik zu finden."
  },
  State_46322_Desc = {
    Text = "Zu Rundenbeginn erhalten Sie 30 Embryofusion."
  },
  State_46322_Name = {
    Text = "Uuhaschi Demo"
  },
  State_46323_Desc = {
    Text = "Nach Beginn des Hyperdimensionalen Zuges, erhalte 100 Wahnsinn, nach Beginn des Zuges erhalte 7 Stärke"
  },
  State_46323_Name = {
    Text = "Liz Testspiel"
  },
  State_46324_Desc = {
    Text = "Erhalte jede Runde 1 „Inspiration“"
  },
  State_46324_Name = {
    Text = "Jenkins Testspiel"
  },
  State_46329_Desc = {
    Text = "Nach Beginn des Kampfes erhältst du 600 Punkte s-Energie. Lotan erhält 50 Punkte Aelius und nach dem Auslösen von Aelius erhält Lotan zusätzlich 44 Punkte Aelius"
  },
  State_46329_Name = {
    Text = "Testspielbonus"
  },
  State_46330_Desc = {
    Text = "Zu Rundenbeginn erhalten Sie 30 Embryofusion, 10 Aliemus, [DescArg1] STR, und fügen 3 „Schlag\"-Karten zum Ziehstapel hinzu."
  },
  State_46330_Name = {
    Text = "Shiro Testspiel"
  },
  State_46333_Name = {
    Text = "Reya Testspiel"
  },
  State_46334_Desc = {
    Text = "Nach Beginn der 4. Runde, erhalte 100 Wahnsinn"
  },
  State_46334_Name = {
    Text = "Fallos Demo"
  },
  State_46336_Desc = {
    Text = "Zu Rundenbeginn erhalten Sie 30 Embryofusion und 10 Aliemus."
  },
  State_46336_Name = {
    Text = "Agrippa Demo"
  },
  State_46337_Desc = {
    Text = "Zu Beginn der Runde erhalte 10 Wahnsinn"
  },
  State_46337_Name = {
    Text = "Kaikes Demo"
  },
  State_46338_Desc = {
    Text = "Zu Rundenbeginn erhalten Sie 30 Embryofusion und 10 Aliemus."
  },
  State_46338_Name = {Text = "Feint Demo"},
  State_46427_Desc = {
    Text = "Der spezifische Effekt hängt von der allgemeinen Schlaglogik ab."
  },
  State_46428_Desc = {
    Text = "Die spezifische Wirkung hängt von der allgemeinen Schlaglogik ab."
  },
  State_46429_Desc = {
    Text = "Die genauen Effekte entnehmen Sie der allgemeinen Schlaglogik."
  },
  State_46441_Desc = {
    Text = "Immun gegen jeglichen Schaden, nach Rundenbeginn entfernt"
  },
  State_46441_Name = {
    Text = "Schaden immun"
  },
  State_46442_Name = {
    Text = "Karte darf den Schlagzieltyp nicht ändern"
  },
  State_46500_Desc = {
    Text = "Die genauen Effekte hängen von der allgemeinen Schlaglogik ab."
  },
  State_46505_Desc = {
    Text = "In dieser Runde erhältst du bei jedem erlittenen Aktiven Schaden [Layer] Aliemus."
  },
  State_46505_Name = {
    Text = "Schmerzumwandlung"
  },
  State_46508_Desc = {
    Text = "Bei Betäubung und Versteinerung erhältst du Widerstand; wird erneut betäubt oder versteinert, wird der Effekt abgebrochen und der Schaden verdoppelt. Dieser Zustand kann nicht beseitigt werden"
  },
  State_46508_Name = {Text = "Widerstand"},
  State_46511_Desc = {
    Text = "Der „Visagen-Overlay\"-Schaden dieses Erweckers erhöht sich um [Layer]."
  },
  State_46511_Name = {
    Text = "Visagen-Overlay"
  },
  State_46512_Desc = {
    Text = "Bis zum Ende der Runde, erleide pro ausgespielter Karte dieses Erweckungswesens [Layer] Schaden"
  },
  State_46512_Name = {
    Text = "Aktionssperre"
  },
  State_46513_Desc = {
    Text = "Verstärke das nächste Gedicht, um einen Zusatzeffekt zu erhalten, nicht entfernbar."
  },
  State_46513_Name = {
    Text = "Trauertinte"
  },
  State_46536_Desc = {
    Text = "Wenn Statusparameter 1 gleich 0 ist, ziehe Karten, andernfalls nur schwebender Text"
  },
  State_46536_Name = {Text = "Ziehen"},
  State_46538_Desc = {
    Text = "Zu Beginn der Erkundung erhalte [StateArg1] Punkte Wahnsinn"
  },
  State_46538_Name = {
    Text = "Wahnsinnsomen"
  },
  State_47072_Desc = {
    Text = "Innerhalb dieser Runde erhöht sich die kritische Rate des Schlag-Kartens um +[Layer] %"
  },
  State_47072_Name = {
    Text = "Kritischer Treffer"
  },
  State_47089_Name = {
    Text = "Teste Effekt"
  },
  State_47096_Desc = {
    Text = "Jedes Mal, wenn eine \"Inspiration\" gespielt wird, erhält Daffodil [StateArg1] Wahnsinn und [StateArg2] Stärke, maximal 5 Mal pro Runde. (Noch [DescArg1] Mal)"
  },
  State_47096_Name = {
    Text = "Protoplasmaablagerung"
  },
  State_47189_Name = {
    Text = "Wechsle zur Manischen Persönlichkeit. Caro·Deprimiert: <EmbryoFusionIconKeywords:Embryofusion> +[Blood:StateArg5], sammle [StateArg6] Punkte Blutroter Ofen-Heilung"
  },
  State_47192_Name = {
    Text = "deprimierte Persönlichkeit: Lässt auch andere Erwecker [DescArg1]-fachen Aliemus erhalten. Manische Persönlichkeit: Erhält zusätzlich [DescArg2]-fachen Aliemus"
  },
  State_47199_Name = {
    Text = "Wechsele zur depressiven Persönlichkeit. Fleisch·Manie: Schaden profitiert von [DescArg1]-fachem <PowerIconKeywords:Macht> Bonus und fügt dem Ziel 200% Schaden von <BleedingIconKeywords:Bluten> zu, erhalte [StateArg7] <PowerIconKeywords:Macht>"
  },
  State_47204_Name = {
    Text = "Wechseln zu manischer Persönlichkeit. Chaos·Depression: Erhalte <Posse:[StateArg1]> Punkte s-Energie, der nächste Schlüssel wirkt 2 Mal"
  },
  State_47206_Name = {
    Text = "Wechsel zu manischer Persönlichkeit. Tiefsee-Depression: <WeaknessIconKeywords:Schwäche> und <VulnerabilityIconKeywords:Verwundbarkeit> des Ziels für 2 Runden, erzeugt 1 Tentakel, <TentacleInjurieIconKeywords:Tentakelschaden>+ [TentaclePower:StateArg3]"
  },
  State_47209_Name = {
    Text = "Wechsle zur deprimierten Persönlichkeit. Ultra: Symptom: Wahnsinn: Erhalte 15 % des verursachten Schadens als <RetaliateIconKeywords:Zähler> und verursache dann einen gleich hohen Betrag an <FixedDamage:Reinem SCH> an anderen Feinden. Für jede in diesem Zug gespielte „Einblick“-Karte wird dieser Schaden für den Rest des Zuges um [StateArg9] erhöht, bis zu [StateArg10]"
  },
  State_47211_Name = {
    Text = "deprimierte Persönlichkeit: Reduziert die Arithmetica-Kosten der [DescArg1] Karten mit den höchsten Arithmetica-Kosten in der Hand um 1 Punkt und erhält temporäres <RetainIconKeywords:Behalten>. Manische Persönlichkeit: Verursacht zusätzlich [DescArg2] Schaden"
  },
  State_47212_Name = {
    Text = "Lässt „24“ zwischen depressiver und manischer Persönlichkeit wechseln und löst je nach aktueller Domäne und Persönlichkeit zusätzliche Effekte aus"
  },
  State_47216_Name = {
    Text = "Wechsle zu depressiv. Tiefsee-Manie：+ [StateArg4]% <TentacleInjurieIconKeywords:Tentakelschaden> und 30% Schaden <IntoxicationIconKeywords:Vergiftung> an alle Feinde"
  },
  State_47217_Name = {
    Text = "Wechsel zu depressiver Persönlichkeit. Chaos·Manie: Verursacht 3-mal Schaden, erhöht den gesamten Schaden von „24“ um [StateArg2] Punkte"
  },
  State_47218_Name = {
    Text = "Wechsel zu manischer Persönlichkeit. Hyperdimensionale Depression: Füge 2 \"Inspiration\" zu deiner Hand hinzu, reduziere das Ziel temporär um [Power:StateArg8] Punkte <PowerIconKeywords:Stärke>"
  },
  State_47222_Name = {
    Text = "deprimierte Persönlichkeit: Reduziert die Arithmetica-Kosten der [DescArg1] Karten mit den höchsten Arithmetica-Kosten in der Hand um 1 Punkt und erhält temporäres <RetainIconKeywords:Behalten>. <AwakerCard_24Lost:Manische Persönlichkeit: Verursacht zusätzlich [DescArg2] Schaden>"
  },
  State_47224_Name = {
    Text = "deprimierte Persönlichkeit: Lässt auch andere Erwecker [DescArg1]-fachen Aliemus erhalten. <AwakerCard_24Lost:Manische Persönlichkeit: Erhält zusätzlich [DescArg2]-fachen Aliemus>"
  },
  State_47228_Name = {
    Text = "<AwakerCard_24Lost:deprimierte Persönlichkeit: Lässt auch andere Erwecker [DescArg1]-fachen Aliemus erhalten.> Manische Persönlichkeit: Erhält zusätzlich [DescArg2]-fachen Aliemus"
  },
  State_47229_Name = {
    Text = "<AwakerCard_24Lost:deprimierte Persönlichkeit: Reduziert die Arithmetica-Kosten der [DescArg1] Karten mit den höchsten Arithmetica-Kosten in der Hand um 1 Punkt und erhält temporäres <RetainIconKeywords:Behalten>.> Manische Persönlichkeit: Verursacht zusätzlich [DescArg2] Schaden"
  },
  State_47451_Name = {
    Text = "Ryker Posse deaktiviert Schicksrad Effekt"
  },
  State_47485_Name = {
    Text = "deprimierte Persönlichkeit: Reduziert die Arithmetica-Kosten der [DescArg1] Karten mit den höchsten Arithmetica-Kosten in der Hand um 2 Punkte und erhält temporäres <RetainIconKeywords:Behalten>. Manische Persönlichkeit: Verursacht zusätzlich [DescArg2] Schaden"
  },
  State_47486_Name = {
    Text = "deprimierte Persönlichkeit: Reduziert die Arithmetica-Kosten der [DescArg1] Karten mit den höchsten Arithmetica-Kosten in der Hand um 2 Punkte und erhält temporäres <RetainIconKeywords:Behalten>. <AwakerCard_24Lost:Manische Persönlichkeit: Verursacht zusätzlich [DescArg2] Schaden>"
  },
  State_47488_Name = {
    Text = "deprimierte Persönlichkeit: Erhält zusätzlich <Energy: [DescArg1]> Punkte Aliemus. Manische Persönlichkeit: Erhält zusätzlich [DescArg2] Schild"
  },
  State_47489_Name = {
    Text = "<AwakerCard_24Lost:deprimierte Persönlichkeit: Reduziert die Arithmetica-Kosten der [DescArg1] Karten mit den höchsten Arithmetica-Kosten in der Hand um 2 Punkte und erhält temporäres <RetainIconKeywords:Behalten>.> Manische Persönlichkeit: Verursacht zusätzlich [DescArg2] Schaden"
  },
  State_47492_Name = {
    Text = "deprimierte Persönlichkeit: Erhält zusätzlich <Energy: [DescArg1]> Punkte Aliemus. <AwakerCard_24Lost:Manische Persönlichkeit: Verursacht zusätzlich [DescArg2] Schaden>"
  },
  State_47493_Name = {
    Text = "deprimierte Persönlichkeit: Erhält zusätzlich <Energy: [DescArg1]> Punkte Aliemus. Manische Persönlichkeit: Verursacht zusätzlich [DescArg2] Schaden"
  },
  State_47494_Name = {
    Text = "deprimierte Persönlichkeit: Lässt auch andere Erwecker [DescArg1]-fachen Aliemus erhalten, <WeaknessIconKeywords:Schwäche> für alle Feinde für [DescArg3] Runden. Manische Persönlichkeit: Erhält zusätzlich [DescArg2]-fachen Aliemus, <VulnerabilityIconKeywords:Verwundbar> für alle Feinde für [DescArg3] Runden"
  },
  State_47495_Name = {
    Text = "deprimierte Persönlichkeit: Lässt auch andere Erwecker [DescArg1]-fachen Aliemus erhalten, <WeaknessIconKeywords:Schwäche> für alle Feinde für [DescArg3] Runden. <AwakerCard_24Lost:Manische Persönlichkeit: Erhält zusätzlich [DescArg2]-fachen Aliemus, Verwundbar für alle Feinde für [DescArg3] Runden>"
  },
  State_47496_Name = {
    Text = "<AwakerCard_24Lost:deprimierte Persönlichkeit: Lässt auch andere Erwecker [DescArg1]-fachen Aliemus erhalten, Schwäche für alle Feinde für [DescArg3] Runden.> Manische Persönlichkeit: Erhält zusätzlich [DescArg2]-fachen Aliemus, <VulnerabilityIconKeywords:Verwundbar> für alle Feinde für [DescArg3] Runden"
  },
  State_47498_Name = {
    Text = "<AwakerCard_24Lost:deprimierte Persönlichkeit: Erhält zusätzlich [DescArg1] Punkte Aliemus.> Manische Persönlichkeit: Verursacht zusätzlich [DescArg2] Schaden"
  },
  State_47499_Name = {
    Text = "<AwakerCard_24Lost:deprimierte Persönlichkeit: Erhalte zusätzlich [DescArg1] Punkte Aliemus.>Manische Persönlichkeit: Erhalte zusätzlich [DescArg2] Schild"
  },
  State_47500_Name = {
    Text = "deprimierte Persönlichkeit: Erhält zusätzlich <Energy: [DescArg1] > Punkte Aliemus. <AwakerCard_24Lost:Manische Persönlichkeit: Erhält zusätzlich [DescArg2] Schild>"
  },
  State_47517_Desc = {
    Text = "<PVPWeaponKeywords:wheel of destiny>: Am Ende des Zuges, verworfen Sie [StateArg1] Karten von anderen Erweckern. Wenn das Verwerfen erfolgreich ist, ziehen Sie [StateArg2] Karten."
  },
  State_47517_Name = {
    Text = "Entschlossenheit des Silberkabeljaus"
  },
  State_47518_Name = {
    Text = "Silberkabeljaus Entschlossenheit Zähler__„Dev Only\""
  },
  State_47528_Desc = {
    Text = "In dieser Runde verursacht „Schlag \" +[DescArg1] % Schaden. <PVPPenetrateKeywords:Durchstechen>."
  },
  State_47528_Name = {
    Text = "Nachglühen"
  },
  State_47530_Desc = {
    Text = "Als die zuletzt gespielte „Fähigkeit“ in dieser Runde betrachtet"
  },
  State_47530_Name = {
    Text = "<CardKeyWord:Simulation>"
  },
  State_47557_Desc = {
    Text = "Team Unique: Der Ausrüster wechselt nach Beginn der Erkundung zur Silberkarpfen-Persona. Nach dem Einsatz von Verherrlichung wechselt er zwischen der Silberkarpfen- und der Katzen-Persona.\nSilberkarpfen: Erhält <WeaponEffect_Num:[StateArg1]> Keyflare nach dem Verursachen von Aktivem Schaden. Katze: Erhält einen Temporären Kritischen Schaden von <WeaponEffect_Num:+[StateArg2]%> nach dem Verursachen von Aktivem Schaden. Diese Effekte teilen sich maximal 5 Auslösungen pro Runde."
  },
  State_47557_WeaponDesc = {
    Text = "Der Ausrüster wechselt nach Beginn der Erkundung zur Silberkarpfen-Persona. Nach dem Einsatz von Verherrlichung wechselt er zwischen der Silberkarpfen- und der Katzen-Persona.\nSilberkarpfen: Erhält <WeaponEffect_Num:[StateArg1]> Keyflare nach dem Verursachen von Aktivem Schaden. Katze: Erhält einen Temporären Kritischen Schaden von <WeaponEffect_Num:+[StateArg2]%> nach dem Verursachen von Aktivem Schaden. Diese Effekte teilen sich maximal 5 Auslösungen pro Runde."
  },
  State_47822_Desc = {
    Text = "Wenn das Ziel in der nächsten Runde erneut „Paralyse\" erleidet, werden alle seine „Schläge\" zu „Illusionen\", können nicht vertrieben werden und halten bis zum Ende der nächsten Runde an."
  },
  State_47822_Name = {
    Text = "Etwas gelähmt"
  },
  State_47825_Desc = {
    Text = "Zu Beginn der Runde wird der entsprechende Fähigkeitseffekt ausgelöst."
  },
  State_47825_Name = {
    Text = "<CardKeyWord:Verzögerung>"
  },
  State_47826_Desc = {
    Text = "·Wenn das Ziel unter „Paralyse\" leidet, wird der Schaden verdoppelt, andernfalls kann sein „Schlag\" in dieser Runde nicht verwendet werden.\n·Befindet es sich 2 aufeinanderfolgende Runden unter „Paralyse\", werden alle seine „Schläge\" zu „Illusionen\"."
  },
  State_47826_Name = {
    Text = "<WeaknessColour:Paralyse>"
  },
  State_47827_Desc = {
    Text = "Jede Schicht verringert den Schaden im Kampf um 1, nicht entfernbar"
  },
  State_47827_Name = {
    Text = "<WeaknessColour:Machtminderung>"
  },
  State_47828_Desc = {
    Text = "Die Schicksalsräder der vom Umschlingen betroffenen Erwecker werden deaktiviert, am Ende der Runde wird 1 Schicht entfernt, maximal 3 Schichten stapelbar."
  },
  State_47828_Name = {
    Text = "<WeaknessColour:Verflechten>"
  },
  State_47830_Desc = {
    Text = "Löse die Schilde und verzögerten Heilungen des Ziels auf, bevor die Runde endet, wird die erhaltene Heilung und der Schild um 50% verringert"
  },
  State_47830_Name = {
    Text = "<PVPVulnerabilityIconColour:Schwere Verletzung>"
  },
  State_47831_Desc = {
    Text = "Vor Rundenende keine Aktionen möglich; beim Versteinerungsanwendung erhält das Ziel Widerstand. Bei Vorhandensein von Widerstand wird der Effekt bei erneutem Ohnmächtig- oder Versteinerungseffekt abgebrochen und der Schaden verdoppelt. Dieser Zustand kann nicht beseitigt werden."
  },
  State_47831_Name = {
    Text = "<ComaColour:Versteinerung>"
  },
  State_47832_Desc = {
    Text = "Einschließlich infizierte Maus, elektrische Maus, verlorene Maus"
  },
  State_47832_Name = {
    Text = "<CardKeyWord:Rattenkarte>"
  },
  State_47833_Desc = {
    Text = "Beinhaltet: Taubenschal, umgekehrte Split-Magiebox, Telepathiemikrofon"
  },
  State_47833_Name = {
    Text = "<CardKeyWord:Erstaunliche Magie>"
  },
  State_47841_Desc = {
    Text = "In diesem Kampf wird der Schlüsselbefehl [Layer] Mal zweimal wirksam"
  },
  State_47841_Name = {
    Text = "Doppelte Schlüsselanweisung"
  },
  State_47842_Desc = {
    Text = "Erhaltener Wahnsinn und verzögerter Wahnsinn werden um 50 % reduziert, und der gesamte verzögerte Wahnsinn wird sofort entfernt."
  },
  State_47842_Name = {
    Text = "<PVPEmptinessColour:Leere>"
  },
  State_47843_Desc = {
    Text = "Lass den Erwecker den Zustand des Todes verlassen und lege sein gesamtes Kartenset in den Ziehstapel"
  },
  State_47843_Name = {
    Text = "<PVPResurrectionColour:Wiederbelebung>"
  },
  State_47844_Desc = {
    Text = "Zufällig entsteht ein verwirrendes Effekt"
  },
  State_47844_Name = {
    Text = "<PVPWonderfulEffectKeywords:Wunderbarer Effekt>"
  },
  State_47845_Desc = {
    Text = "Karten erzeugen Wirkung, solange sie sich in den Handkarten befinden"
  },
  State_47845_Name = {
    Text = "<CardKeyWord:Halten>"
  },
  State_47873_Desc = {
    Text = "Am Ende der nächsten Runde, verursache Schaden in Höhe der Schichten"
  },
  State_47873_Name = {
    Text = "<PVPVulnerabilityIconColour:Bluten>"
  },
  State_47887_Name = {
    Text = "Erhalte unterschiedliche Effekte basierend auf der aktuellen Teamdomäne"
  },
  State_47888_Name = {
    Text = "Caro: „24\" pro verbrauchtem Punkt Arithmetica <EmbryoFusionIconKeywords:Embryofusion> +[Blood:DescArg1], erhält [StateArg3] Punkte <PowerIconKeywords:Stärke>, „24\" Verherrlichung genießt zusätzlich 300% Stärke-Bonus"
  },
  State_47889_Name = {
    Text = "Aequor: Der Schaden „24“ erhält einen [StateArg2]% <TentacleInjurieIconKeywords:Tentakelschaden>-Bonus und fügt <IntoxicationIconKeywords:Gift> in Höhe von 10% des verursachten Schadens zu. Das Exaltieren von „24“ kann [StateArg6]% <IntoxicationIconKeywords:Gift> bei Feinden auslösen."
  },
  State_47892_Name = {
    Text = "Chaos: Krit. Rate und Krit. Schaden von „24 \" +[StateArg4] %. Jedes Mal, wenn die Posse verwendet wird, erhöht sich der Gesamtschaden der Verherrlichung von „24\" um [StateArg1] %"
  },
  State_47894_Name = {
    Text = "Ultra: Der Schaden von „24“ erhält [StateArg5]% <RetaliateIconKeywords:Schaden> Bonus. Am Ende der Runde wird 1 „Inspiration“ in den Ablagestapel gemischt, Handkartenlimit +2"
  },
  State_48009_Desc = {
    Text = "Der erste gespielte Effekt jeder Runde wirkt [StateArg1] Mal zusätzlich"
  },
  State_48009_Name = {
    Text = "<Rune_19:Ensemble>"
  },
  State_48010_Desc = {
    Text = "Ensemble-Markierung"
  },
  State_48010_Name = {
    Text = "Ensemble-Markierung"
  },
  State_48011_Desc = {
    Text = "Der erste gespielte Effekt jeder Runde wirkt [StateArg1] Mal zusätzlich"
  },
  State_48011_Name = {
    Text = "<Rune_19_High:Hochensemble>"
  },
  State_48011_WeaponDesc = {
    Text = "Nach dem Ausspielen tritt es [StateArg1] Mal zusätzlich in Kraft, Verbrauch"
  },
  State_48012_Desc = {
    Text = "Lass die geprägte Karte beim ersten Ausspielen pro Runde 2 Mal aktiv werden"
  },
  State_48012_Name = {
    Text = "<CardKeyWord:Orison:Ensemble>"
  },
  State_48013_Desc = {
    Text = "Lass die geprägte Karte beim ersten Ausspielen pro Runde 3 Mal aktiv werden"
  },
  State_48013_Name = {
    Text = "<CardKeyWord:Orison:Fortgeschrittenes Ensemble>"
  },
  State_48019_Name = {
    Text = "<CardKeyWord:Simulation>"
  },
  State_48020_Name = {
    Text = "<CardKeyWord:Geburt einer Seele>"
  },
  State_48021_Name = {
    Text = "<CardKeyWord:Nebelgestalt>"
  },
  State_48078_Name = {
    Text = "<CardKeyWord:Sternen-Mimikry>"
  },
  State_48099_Desc = {
    Text = "Beim Ende der Runde erhält „24“ [DescArg1] Punkte Wahnsinn. Jedes Mal, wenn „24“ Exaltieren freisetzt, erhöht sich der in diesem Effekt erhaltene Wahnsinn um 1"
  },
  State_48099_Name = {
    Text = "Pavlovs Verhaltensforschung"
  },
  State_48099_WeaponDesc = {
    Text = "Ausrüster: Am Rundenende 3 Wahnsinn. Bei Wahnsinnsaufladung > 10, zusätzlich 2 Wahnsinn"
  },
  State_48100_Name = {
    Text = "Status@24Pawlow-Verhaltensforschung Zähler"
  },
  State_48100_WeaponDesc = {
    Text = "Ausrüster: Am Rundenende 3 Wahnsinn. Bei Wahnsinnsaufladung > 10, zusätzlich 2 Wahnsinn"
  },
  State_48107_Desc = {
    Text = "Die erste„Fähigkeit \", die der Ausrüster jede Runde spielt, verursacht +[StateArg1] % Schaden."
  },
  State_48107_Name = {
    Text = "Klinge des Riesen"
  },
  State_48108_Desc = {
    Text = "Nach dem ersten Einsatz eines \"Fähigkeit\" in jeder Runde wird eine Kopie mit -[StateArg1] Kosten in den Ziehstapel gemischt"
  },
  State_48108_Name = {Text = "Fouetté"},
  State_48110_Desc = {
    Text = "“Fähigkeit“nächster “Schlag“ in dieser Runde trifft zufälliges Ziel und zusätzlich [StateArg1] zufällige Ziele."
  },
  State_48110_Name = {
    Text = "Spiegelbild"
  },
  State_48140_Desc = {
    Text = "Zu Beginn der Erkundung wechselt „24“ in den Zustand der deprimierten Persönlichkeit.\n<School_1:Chaos: Depression>: Erhält <Posse:[StateArg1]> Keyflare, der nächste Schlüssel wirkt 2 Mal.\n<School_1:Chaos: Manie>: Verursacht 3-mal Schaden und erhöht den gesamten Schaden von „24“ um [StateArg2].\n<School_2:Aequor: Depression>: Fügt dem Ziel für 2 Runden <WeaknessIconKeywords:Symptom: Schwäche> und <VulnerabilityIconKeywords:Verwundbar> zu und erzeugt 1 Tentakel mit <TentacleInjurieIconKeywords:Tentakelschaden> +[StateArg3].\n<School_2:Aequor: Manie>: Dieser Schaden profitiert von [StateArg4]% <TentacleInjurieIconKeywords:Tentakelschaden> Bonus und fügt allen Feinden 30% Schaden als <IntoxicationIconKeywords:Gift> zu.\n<School_3:Caro: Depression>: <EmbryoFusionIconKeywords:Embryofusion> +[Blood:StateArg5], sammelt [StateArg6] Blutroter Ofen.\n<School_3:Caro: Manie>: Schaden profitiert von 6-fachem <PowerIconKeywords:STR> Bonus und fügt dem Ziel 200% Schaden als <BleedingIconKeywords:Bluten> zu, erhalte [StateArg7] <PowerIconKeywords:STR>.\n<School_4:Ultra: Depression>: Füge 2 „Einblick“-Karten zur Hand hinzu und reduziere das <PowerIconKeywords:STR> des Ziels vorübergehend um [StateArg8].\n<School_4:Ultra: Manie>: Erhalte <RetaliateIconKeywords:Gegenangriff> in Höhe von 15% des verursachten Schadens und füge dann anderen Feinden den gleichen Betrag als <RealDamage:Festgesetzter Schaden> zu. Für jede in dieser Runde gespielte „Einblick“-Karte erhöht sich dieser Schaden um [StateArg9], maximal um [StateArg10]."
  },
  State_48140_Name = {
    Text = "Grenzgebiet und Persönlichkeitseffekt"
  },
  State_48141_Desc = {
    Text = "<School_1:Chaos>: Kritische Rate und kritischer Schaden von „24„ +[StateArg4]%. Jedes Mal, wenn die Posse verwendet wird, erhöht sich der Gesamtschaden der Verherrlichung von „24„ um [StateArg1]%.\n<School_2:Aequor>: „24„ Schaden profitiert von [StateArg2]% <TentacleInjurieIconKeywords:Tentakelschaden> und verursacht 10% des Schadens als <IntoxicationIconKeywords:Gift>. Das Exaltieren von „24„ kann beim Feind 50% <IntoxicationIconKeywords:Gift> auslösen.\n<School_3:Fleisch>: „24„ erhält für jeden verbrauchten Punkt Arithmetica <EmbryoFusionIconKeywords:Embryofusion> +[Blood:5], und erhält [StateArg3] Punkte <PowerIconKeywords:Macht>. Ihre Verherrlichung profitiert von einem zusätzlichen 300% Macht-Bonus.\n<School_4:Ultra>: Der Schaden von „24„ erhält [StateArg5]% <RetaliateIconKeywords:Gegenangriff> Bonus. Am Ende der Runde wird 1 „Einblick„ in den Ablagestapel gemischt, Handkartenlimit +2."
  },
  State_48141_Name = {
    Text = "Reichseffekt"
  },
  State_48149_Name = {
    Text = "Karten-Spezialeffekt nicht verfügbar"
  },
  State_48176_Desc = {
    Text = "In dieser Testversion erhält man in jeder Runde 1 Punkt Arithmetica, wobei „24“ für jeden verbrauchten Punkt Arithmetica 30 Punkte silber Schlüssel-Energie erhält"
  },
  State_48176_Name = {
    Text = "“24“ Demo"
  },
  State_48198_Desc = {
    Text = "In dieser Demo, jede Runde eine \"Inspiration\" erhalten"
  },
  State_48198_Name = {
    Text = "“24“ Demo"
  },
  State_48199_Desc = {
    Text = "In dieser Testversion erhält man in jeder Runde 1 Punkt Arithmetica"
  },
  State_48199_Name = {
    Text = "“24“ Demo"
  },
  State_48589_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_48589_Name = {
    Text = "Nicht erweckt"
  },
  State_48607_Name = {
    Text = "Die ursprüngliche Arithmetica der allgemeinen Karte verringert sich"
  },
  State_48822_Desc = {
    Text = "Zu Beginn der Runde im Blutkörperbereich wird die erhaltene Embryo-Fusion um 50% erhöht"
  },
  State_48822_Name = {
    Text = "Lebenskraft"
  },
  State_48923_Desc = {
    Text = "Der Schatten „24“ ist erwacht! Nutze das letzte „Hilf mir“ und finde deine Gelegenheit!"
  },
  State_48923_Name = {
    Text = "Schatten “24“Erwachen!"
  },
  State_48923_WeaponDesc = {
    Text = "Nach Beginn der nächsten Runde, erhalte Schild in Höhe des verlorenen Lebens der letzten Runde"
  },
  State_49063_Desc = {
    Text = "Lotans „Dieke“-Schaden erhöht sich um 30 %"
  },
  State_49063_Name = {
    Text = "Erhöhter Kampfeswille"
  },
  State_49109_Desc = {
    Text = "Karte erhält <RetainIconKeywords:Behalten>, wenn sie am Ende des Zuges auf der Hand ist, erhält man 1 ursprüngliche Kopie dieser Befehlskarte mit <DepleteIconKeywords:Verbrauchen>."
  },
  State_49109_Name = {
    Text = "<Rune_20_High:Geburt>"
  },
  State_49109_WeaponDesc = {
    Text = "Nach dem Ausspielen tritt es [StateArg1] Mal zusätzlich in Kraft, Verbrauch"
  },
  State_49148_Desc = {
    Text = "Nach dem Tod wird 1 Karte mit einem Verbrauch von mehr als 0 mit “Mutation 1“ versehen. Mutation: Kartenstatus, bleibt auch nach dem Kampf bestehen. Jede Schicht reduziert den Arithmetica-Verbrauch um 1, aber nach dem Ausspielen fügt jede Schicht 1 zufällige Mutationskarte zu deiner Hand hinzu (Ignorieren Sie das Handkartenlimit) und entfernt alle Mutationen."
  },
  State_49148_Name = {
    Text = "Verstümmeltes Ei"
  },
  State_49149_Desc = {
    Text = "Jede Schicht reduziert die Arithmetica-Kosten der Karten um 1. Nach dem Ausspielen, für jede Schicht Anomalie wird eine zufällige Anomaliekarte auf deine Hand gelegt, dieser Zustand wird entfernt. Dieser Zustand bleibt nach dem Kampf bestehen"
  },
  State_49149_Name = {
    Text = "<ExclamationPointColour:Verzerrung [Layer]>"
  },
  State_49149_WeaponDesc = {
    Text = "Nach dem Ausspielen wird sie dauerhaft entfernt"
  },
  State_49207_Name = {
    Text = "erhalte 100 Schlüsselenergie"
  },
  State_49225_Desc = {
    Text = "Nach Rundenende greift 1 Tentakel [Layer] Mal an"
  },
  State_49225_Name = {
    Text = "<CardKeyWord:Tentakelversammlung>"
  },
  State_49226_Desc = {
    Text = "Am Ende der Runde löse für jede Karte auf der Hand 3 % Gift bei allen Feinden aus und erhalte 3 Punkte Wahnsinn."
  },
  State_49226_Name = {
    Text = "schwaches Kerzenlicht"
  },
  State_49260_Desc = {
    Text = "Nach Rundenende +7,5% der Konstitution als Leben"
  },
  State_49260_Name = {
    Text = "Nicht akzeptierter Schmerz"
  },
  State_49270_Desc = {
    Text = "Schadensbonus für ANGskarten um [Layer] %"
  },
  State_49270_Name = {
    Text = "Schadensbonus für ANGskarten"
  },
  State_49270_WeaponDesc = {
    Text = "Schadensbonus für ANGskarten um [Layer] %"
  },
  State_49278_Desc = {
    Text = "Am Ende der Runde, heile 5% des verlorenen Lebens. Wenn das Leben unter 50% ([StateArg1]) liegt, erhalte zusätzlich [StateArg2] Stärke"
  },
  State_49278_Name = {
    Text = "Scharlachroter Altar"
  },
  State_49430_Desc = {
    Text = "Schaden reduziert, jede Schicht reduziert um 1 %. Nach dem Tod eines anderen Verbündeten wird dieser Zustand entfernt"
  },
  State_49430_Name = {
    Text = "<AberrationColour:Verbergen>"
  },
  State_49500_Desc = {
    Text = "Jede Schicht erhöht die ANGe um 1, verliert 1 Schicht bei Schaden, verliert alle am Rundenende"
  },
  State_49500_Name = {Text = "Beten"},
  State_49524_Desc = {
    Text = "Am Ende der Runde erhält man Gesundheit zurück, die 5% der verlorenen Lebenspunkte entspricht. Jedes Mal, wenn der Spieler eine Zustandskarte oder Symptomkarte zieht, erhalten alle „Nubien“ [StateArg1] Punkte temporäre Macht"
  },
  State_49524_Name = {
    Text = "Blutiges Evangelium"
  },
  State_49526_Desc = {
    Text = "Nach dem Tod sofort auf [StateArg2] Lebenspunkte wiederherstellen und 1 Runde immun gegen Schaden sein, die Absicht wird zu „Verunreinigung verbreiten“"
  },
  State_49526_Name = {Text = "säen"},
  State_49542_Desc = {
    Text = "Einzigartig im Team: Nach Kampfbeginn, erhalte eine ANGskraft des Ausrüsters von <WeaponEffect_Num:[StateArg1]%>. Wenn das aktuelle Gebiet „Tiefsee“ ist, erhöht sich der Tentakelschaden des Ausrüsters um <WeaponEffect_Num:[StateArg2]%>"
  },
  State_49542_WeaponDesc = {
    Text = "Nach Kampfbeginn erhält der Träger <WeaponEffect_Num:[Power:DescArg1]> Punkte Kraft. Wenn das aktuelle Reich „Tiefsee“ ist, erhält er zusätzlich <WeaponEffect_Num:[DescArg2]> Punkte Tentakelschaden."
  },
  State_49546_Desc = {
    Text = "Erscheint immer mit 2 Elitewächtern. Nach seinem Tod sterben sie auch"
  },
  State_49546_Name = {Text = "Formation"},
  State_49547_Desc = {
    Text = "Nach dem Tod erhält der Kommandant der Arlan-Garde [StateArg1] Punkte Macht und ein Schild von 50% der maximalen Gesundheit"
  },
  State_49547_Name = {Text = "Loyalität"},
  State_49558_Desc = {
    Text = "Pro Runde [StateArg1] Stärke erhöhen"
  },
  State_49558_Name = {
    Text = "Sandes Gebet"
  },
  State_49582_Desc = {
    Text = "In diesem Kampf verbleibende Schilde pro Runde bleiben erhalten"
  },
  State_49582_Name = {
    Text = "Schild permanent beibehalten"
  },
  State_49583_Desc = {
    Text = "Am Ende der Runde erhält man [StateArg1] Punkte Schild, verstärkt durch Alarm"
  },
  State_49583_Name = {
    Text = "Schild von Aran"
  },
  State_49595_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_49595_Name = {
    Text = "Nicht erweckt"
  },
  State_49596_Desc = {
    Text = "“Die Traumklinge“ ist erwacht, sie wird mehr Schild und Macht erhalten"
  },
  State_49596_Name = {
    Text = "Elva erwacht!"
  },
  State_49596_WeaponDesc = {
    Text = "Nach Beginn der nächsten Runde, erhalte Schild in Höhe des verlorenen Lebens der letzten Runde"
  },
  State_49597_Name = {
    Text = "In dieser Runde bereits gelähmt"
  },
  State_49600_Desc = {
    Text = "Alle Feinde 2 Runden schwächen"
  },
  State_49600_Name = {
    Text = "Blut der Angst"
  },
  State_49601_Desc = {
    Text = "Alle Feinde 2 Runden verwundbar"
  },
  State_49601_Name = {
    Text = "Blut des Verfalls"
  },
  State_49602_Desc = {
    Text = "Alle Feinde 1 Runde verwundbar"
  },
  State_49602_Name = {
    Text = "Blut des Verfalls"
  },
  State_49603_Desc = {
    Text = "Embryofusion +[Blood:DescArg1]."
  },
  State_49603_Name = {
    Text = "Blut des Koitus"
  },
  State_49604_Desc = {
    Text = "Embryofusion +[Blood:DescArg1]."
  },
  State_49604_Name = {
    Text = "Blut des Koitus"
  },
  State_49605_Desc = {
    Text = "Alle Feinde 1 Runde schwächen"
  },
  State_49605_Name = {
    Text = "Blut der Angst"
  },
  State_49623_Desc = {
    Text = "Erhaltene Lebensregeneration um [DescArg1]% verringert. Entfernt 1 Stapel am Ende der Runde"
  },
  State_49623_Name = {
    Text = "<BaseDamageColour:Schwerer Schaden>"
  },
  State_49623_WeaponDesc = {
    Text = "Verursachter Gesamtschaden um [DescArg1] % reduziert"
  },
  State_49627_Desc = {
    Text = "Start mit 2 Schichten <ParcloseIconKeywords:Barriere>. Beim Tod erhalten alle „Nubia“ [StateArg1] Stärke"
  },
  State_49627_Name = {Text = "Blutstrom"},
  State_49628_Desc = {
    Text = "Beim Tod erhalten alle „Nubia“ [StateArg1] Stärke"
  },
  State_49628_Name = {
    Text = "Blutverbindung"
  },
  State_49638_Desc = {
    Text = "Erkennen, ob es sich um ein Monster der Schwarzziegen-Serie handelt"
  },
  State_49833_Desc = {
    Text = "Am Ende der Runde, füge allen Feinden 1 Runde „Blindheit“ zu. Wenn mein Schild gebrochen wird, wird „Blindheit“ aufgehoben"
  },
  State_49833_Name = {Text = "Sandwand"},
  State_49844_Desc = {
    Text = "Team Unique: Am Ende der Runde erhältst du <WeaponEffect_Num:[StateArg1]> Punkte Keyflare. Nach Auslösen des Todwiderstands erhältst du <WeaponEffect_Num:[StateArg2]> Punkte Keyflare. Nach Verwendung des Notfall-Gnosis-Körpers erhöht sich die Arithmetica-Grenze um 3, und die Anzahl der Ziehen pro Runde erhöht sich um 3."
  },
  State_49844_WeaponDesc = {
    Text = "Am Ende der Runde erhältst du <WeaponEffect_Num:[StateArg1]> Punkte s-Energie. Nach Auslösung des Todeswiderstands erhältst du <WeaponEffect_Num:[StateArg2]> Punkte s-Energie. Nach der Verwendung des Notfall-Gnosis-Körpers erhöht sich die Arithmetica-Grenze um 3, und die Anzahl der zu ziehenden Karten pro Runde erhöht sich um 3."
  },
  State_49877_Desc = {
    Text = "Verringere den Rechenaufwand für die Karte. Nach dem Ausspielen erhältst du bei jeder Schicht Verzerrung eine zufällige Verzerrungskarte und entfernst diesen Zustand. Dieser Zustand bleibt nach dem Kampf bestehen"
  },
  State_49877_Name = {
    Text = "<AberrationKeywords:Abweichung>"
  },
  State_49877_WeaponDesc = {
    Text = "Jede Schicht Verzögerung erhöht die Arithmetica-Kosten der Karte um 1 Punkt"
  },
  State_49954_Desc = {
    Text = "Alle Erwecker haben kritischen Schadensbonus halbiert"
  },
  State_49954_Name = {
    Text = "<BlindingKeywords: Blindheit>"
  },
  State_49954_WeaponDesc = {
    Text = "Jede Schicht Verzögerung erhöht die Arithmetica-Kosten der Karte um 1 Punkt"
  },
  State_49957_Desc = {
    Text = "Beim Erleiden von Aktivem Schaden werden die Verherrlichungs- und Befehlskarten des angreifenden Erweckers für 1 Zug versiegelt und 1 Stapel <ResentChainsKeywords:Kette des Grolls> entfernt. Wird am Zugende aufgehoben."
  },
  State_49957_Name = {
    Text = "<ResentChainsKeywords: Grollketten>"
  },
  State_49957_WeaponDesc = {
    Text = "Jede Schicht Verzögerung erhöht die Arithmetica-Kosten der Karte um 1 Punkt"
  },
  State_49958_Desc = {
    Text = "Beim Erleiden von Aktivem Schaden und Tentakelschaden werden die Verherrlichung und Befehlskarten des angreifenden Erweckers für 1 Runde versiegelt und 1 Stapel <ResentChainsKeywords:Kette des Grolls> wird entfernt."
  },
  State_49958_Name = {
    Text = "<ResentChainsKeywords1:Kette des Grolls>"
  },
  State_49959_Desc = {
    Text = "Zu Beginn jeder Runde 1 Schicht <ResentChainsKeywords:Grollketten> erhalten"
  },
  State_49959_Name = {
    Text = "Mehrdimensionales Schloss"
  },
  State_50010_Desc = {
    Text = "Lebensregeneration um 25 % reduziert. Am Ende der Runde wird 1 Schicht entfernt"
  },
  State_50010_Name = {
    Text = "<HeavyInjuryKeywords:Schwer verletzt>"
  },
  State_50021_Desc = {
    Text = "Team Unique: Nach der Verherrlichung des Ausrüsters erhält dieser <PowerIconKeywords:Stärke> in Höhe von <WeaponEffect_Num:[StateArg1] %> des ATK des Ausrüsters. Ist das aktuelle Reich „Fleisch \", erhöht sich die Embryofusion nach der Verherrlichung um <WeaponEffect_Num:+[Blood:StateArg2]>."
  },
  State_50021_WeaponDesc = {
    Text = "Nach der Verherrlichung des Ausrüsters erhält dieser <WeaponEffect_Num:[Power:DescArg1]> Punkte <PowerIconKeywords:Stärke>. Ist das aktuelle Reich „Fleisch \", erhöht sich die Embryofusion nach der Verherrlichung um <WeaponEffect_Num:+[Blood:StateArg2]>."
  },
  State_50302_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Widersteht einmal dem Tod und zerstört dieses „Schicksalsrad\", erhält [StateArg1] Schichten <PVPProtectiveKeywords:Barriere>, wenn der einzige überlebende Verbündete, erhält zu Beginn der nächsten Runde [StateArg2] zufällige „Posse\""
  },
  State_50302_Name = {
    Text = "Dämmerung und Morgengrauen"
  },
  State_50323_Desc = {
    Text = "Vor Beginn des nächsten Zuges erhalte [Layer] zufällige Schlüsselbefehle"
  },
  State_50323_Name = {
    Text = "Verzögerter Schlüsselbefehl"
  },
  State_50333_Desc = {
    Text = "Am Ende der Runde verringert sich die automatische Wahnsinnsregeneration"
  },
  State_50333_Name = {
    Text = "<EmptinessKeywords:Leere>"
  },
  State_50333_WeaponDesc = {
    Text = "Jede Schicht Verzögerung erhöht die Arithmetica-Kosten der Karte um 1 Punkt"
  },
  State_50352_Name = {Text = "Tais Demo"},
  State_50353_Name = {Text = "Tais Demo"},
  State_50358_Desc = {
    Text = "Schaden reduziert, jede Schicht reduziert um 1 %. Nach dem Tod eines anderen Verbündeten wird dieser Zustand entfernt"
  },
  State_50358_Name = {
    Text = "<ConcealmentKeywords:Verbergen>"
  },
  State_50375_Desc = {
    Text = "Diese Effekte umfassen: sich selbst 10 Punkte Wahnsinn erhalten, anderen Verbündeten 5 Punkte Wahnsinn gewähren, allen feindlichen Einheiten 1 Schicht Verwundbarkeit auferlegen, allen feindlichen Einheiten 1 Schicht Schwäche auferlegen, 1 Karte ziehen, 200 Punkte Silberschlüssel-Energie erhalten"
  },
  State_50375_Name = {
    Text = "<MysterybuffKeywords:Wunderbarer positiver Effekt>"
  },
  State_50389_Desc = {
    Text = "Zu Beginn der Runde lege einen „Rykers Glückswürfel“ auf deine Hand"
  },
  State_50389_Name = {
    Text = "Leks Unterstützung"
  },
  State_50390_Desc = {
    Text = "Zu Beginn der Runde, erhalte [StateArg1] Kraft"
  },
  State_50390_Name = {
    Text = "Hervorragender Veteran"
  },
  State_50491_Name = {
    Text = "Zeitpendel „Gleichgewicht\""
  },
  State_50735_Desc = {
    Text = "Beim ersten drohenden Niederlage, Lebenspunkte wiederherstellen und Absicht in „Zerreißende Trauer“ ändern, um extrem hohen Einzelschaden zu verursachen"
  },
  State_50735_Name = {
    Text = "Sinnlose Festigkeit"
  },
  State_50854_Desc = {
    Text = "Beim Kampfbeginn [StateArg1] <RetaliateIconKeywords:Gegenangriff> erhalten. Nach Rundenende [StateArg2] Schild erhalten, Schild wächst jede Runde um [StateArg3]"
  },
  State_50854_Name = {
    Text = "zähe Rinde"
  },
  State_50861_Desc = {
    Text = "Wird nicht mehr verletzt, bereit, „Mutter aller tausend Nachkommen“ freizugeben"
  },
  State_50861_Name = {Text = "Abgeleitet"},
  State_50862_Desc = {
    Text = "Wird nicht mehr verletzt, bereit, “Zucht“ freizugeben."
  },
  State_50862_Name = {Text = "Brüten"},
  State_50863_Desc = {
    Text = "Wird nicht mehr verletzt, bereit, „wilder Baumsaft“ freizugeben"
  },
  State_50863_Name = {Text = "Immun"},
  State_50864_Desc = {
    Text = "Wird nicht mehr verletzt, bereit, „Baumsaft“ freizugeben"
  },
  State_50864_Name = {Text = "Immun"},
  State_50891_Desc = {
    Text = "Wird nicht mehr verletzt, bereit, „mehrfache Fusion“ freizugeben"
  },
  State_50891_Name = {
    Text = "Verschlingen"
  },
  State_51016_Desc = {
    Text = "Vergiftungseffekt um 1000 % erhöht"
  },
  State_51016_Name = {
    Text = "verdorrtes Holz"
  },
  State_51017_Desc = {
    Text = "Vergiftungseffekt um 500 % erhöht"
  },
  State_51017_Name = {
    Text = "verdorrtes Holz"
  },
  State_51607_Desc = {
    Text = "Immun gegen jeglichen Schaden, nach Rundenbeginn entfernt"
  },
  State_51607_Name = {
    Text = "Schaden immun"
  },
  State_51695_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_51695_Name = {
    Text = "Nicht erweckt"
  },
  State_51696_Desc = {
    Text = "“„Der Apostel des Meeres“ ist erwacht und hat eine stärkere Abwehr gegen die Ausbrüche des Wahnsinns.“"
  },
  State_51696_Name = {
    Text = "Miriam Erwachen!"
  },
  State_51696_WeaponDesc = {
    Text = "Nach Beginn der nächsten Runde, erhalte Schild in Höhe des verlorenen Lebens der letzten Runde"
  },
  State_51739_Desc = {
    Text = "Am Ende der Runde wird zufällig 1 „Göttliches Reich Phantasma“ erhalten. Kann nicht vertrieben werden."
  },
  State_51739_Name = {
    Text = "Das Ende des Glaubens"
  },
  State_51740_Desc = {
    Text = "Zu Beginn des Kampfes erhältst du 1 „Wahn“"
  },
  State_51740_Name = {
    Text = "Unsterbliche Frömmigkeit"
  },
  State_51741_Desc = {
    Text = "Zu Beginn der Runde erhältst du [Layer] Schildpunkte, die nicht zerstreut werden können."
  },
  State_51741_Name = {
    Text = "Eiserne Entschlossenheit"
  },
  State_51742_Desc = {
    Text = "Zu Beginn der Runde erhältst du [Layer] Tentakelschaden und Stärke, nicht zerstreubar."
  },
  State_51742_Name = {
    Text = "Hingabe offenbaren"
  },
  State_51743_Desc = {
    Text = "In dieser Runde erhält jeder Tentakel bei jedem ANG die folgenden Effekte, abhängig von der Tentakelhaltung: Steigende Fluten: Alle Erwecker erhalten <Energy:[Energy:StateArg1]> Punkte Aliemus; Ruhiges Meer: Verursacht [StateArg2] Punkte <IntoxicationIconKeywords:Gift> bei allen Feinden; Tobende Wellen: vorübergehender <TentacleInjurieIconKeywords:Tentakelschaden> +[StateArg3]."
  },
  State_51743_Name = {
    Text = "Segen der Muttergöttin"
  },
  State_51745_Desc = {
    Text = "Wenn der Apostel des Meeres 1 Karte spielt, erzeugt er [StateArg1] temporäre Tentakel, die das Tentakellimit ignorieren"
  },
  State_51745_Name = {
    Text = "Stellvertretende Fähigkeit"
  },
  State_51745_WeaponDesc = {
    Text = "Wenn der Apostel des Meeres 1 Karte spielt, erzeugt er [StateArg1] temporäre Tentakel, die das Tentakellimit ignorieren"
  },
  State_51811_Name = {
    Text = "Heilungseffekt der Leitenden Segel"
  },
  State_51813_Desc = {
    Text = "Nach dem Ende der Runde reduziert sich die Arithmetica um -[Layer]; auch nach dem Abwerfen wird dieser Effekt ausgelöst"
  },
  State_51813_Name = {
    Text = "<PrepareKeypvewordscolour: Vorbereiten [Layer]>"
  },
  State_51820_Desc = {
    Text = "“„Geburt“ erhält einen zusätzlichen Effekt: Bei 5 Stapeln sofort einen „Wasserkind“ beschwören, maximal 2 „Wasserkinder“ gleichzeitig.“"
  },
  State_51820_Name = {
    Text = "Miriam Erwachen"
  },
  State_51822_Desc = {
    Text = "Nach jeder Auslösung von Aelius erhältst du 1 Schicht „Nähren“, jede Schicht Nähren gibt dir [StateArg1] Punkte Macht, maximal 5 Schichten"
  },
  State_51822_Name = {
    Text = "Die Endgültige Abstieg von Lemuria"
  },
  State_52068_Desc = {
    Text = "Wandle bis zu 3 “Sakramente“ in “Besessenheit“ um und erhalte je nach Anzahl der Umwandlungen unterschiedliche zusätzliche Effekte."
  },
  State_52068_Name = {
    Text = "<CardKeyWord:Ritual>"
  },
  State_52087_Desc = {
    Text = "“Unsterblicher Paradiesvogel“ kann nach [Layer] Runden wiederbelebt werden"
  },
  State_52087_Name = {
    Text = "Wiederbelebungs-Abklingzeit"
  },
  State_52116_Desc = {
    Text = "Vor dem Ende der Runde erleidet dieser Erwecker [Layer] Schaden, wenn er Exaltieren verwendet"
  },
  State_52116_Name = {
    Text = "Verherrlichungssperre"
  },
  State_52369_Desc = {
    Text = "Nachdem du [DescArg1] Symptomkarten gespielt hast, erhältst du die Unterstützungskarte „Königreich“ von Tulu: verursacht großen Schaden und macht das Ziel 1 Runde ohnmächtig"
  },
  State_52369_Name = {
    Text = "Göttliches Reich wird sicherlich wiederkommen"
  },
  State_53115_Desc = {
    Text = "Innerhalb dieser Runde wird der nächste „Ritual“-Effekt von Miryam um 50 % erhöht"
  },
  State_53115_Name = {
    Text = "Bete zum Abgrund"
  },
  State_53144_Desc = {
    Text = "Zu Beginn jeder Runde <Block:[Block:StateArg1]> Schildpunkte erhalten"
  },
  State_53144_Name = {
    Text = "<CardKeyWord:Selbsttreue>"
  },
  State_53145_Desc = {
    Text = "Zu Beginn jeder Runde <PowerIconKeywords:Kraft> und <TentacleInjurieIconKeywords:Tentakelschaden> +[StateArg2]"
  },
  State_53145_Name = {
    Text = "<CardKeyWord:Inspiration>"
  },
  State_53673_Desc = {
    Text = "Die Anzahl der Drüsenaufspaltungen kann bis zu 10 betragen"
  },
  State_53673_Name = {
    Text = "Drüsensektionslimit"
  },
  State_53674_Desc = {
    Text = "Handkartenlimit +2. Zu Beginn der Runde erhält Miryam 20 Punkte Wut"
  },
  State_53674_Name = {
    Text = "Miriam Playtest"
  },
  State_53755_Desc = {
    Text = "Die von allen Erweckern erzeugten <PowerIconKeywords: Macht>, <RetaliateIconKeywords: Theke>, <IntoxicationIconKeywords: Gift> wurden um [DescArg1]% erhöht. Die durch „Blühende Kapitel“ bereitgestellte <PowerIconKeywords: Macht> wurde erhöht"
  },
  State_53755_Name = {
    Text = "Klagepsalm·Furcht"
  },
  State_53756_Desc = {
    Text = "Die Wut, die alle Erwecker verursachen, erhöht sich um [DescArg1]%, die Arithmetica und die Befehlskarten können bis zur nächsten Runde behalten werden. „Fächerkapitel“ verursacht Wutsteigerung"
  },
  State_53756_Name = {
    Text = "Phantasmal Gedicht·Freude"
  },
  State_53758_Desc = {
    Text = "Der endgültige Schaden, den alle Erwecker verursachen, erhöht sich um [DescArg1]%, das „Fächerkapitel“ verstärkt die kritische Rate und den kritischen Schaden"
  },
  State_53758_Name = {
    Text = "Knurrpsalm·Wut"
  },
  State_53759_Desc = {
    Text = "Alle angewendeten Schilde und Lebensregeneration sowie die Senkung der <PowerIconKeywords:Stärke>-Effekte der Erwachten erhöhen sich um [DescArg1]%. „Kapitel der Blumenpracht“ erhöht die Regeneration"
  },
  State_53759_Name = {
    Text = "Trauergedicht·Trauer"
  },
  State_53772_Name = {
    Text = "Schmuckstück Antinomie"
  },
  State_53772_WeaponDesc = {
    Text = "Nach der Nutzung der Wahnsinnsexplosion erhält das Team des Ausrüstenden 100% basierend auf seiner VERT <RetaliateIconKeywords:Theke>. Seine aktuelle <RetaliateIconKeywords:Theke> erhöht sich um 10%"
  },
  State_53870_Name = {
    Text = "Schmuckstück Raum 36 Ring"
  },
  State_53870_WeaponDesc = {
    Text = "Wenn du die Karte des Ausrüsters ziehst, variiert seine Arithmetica zufällig zwischen 0 und 3"
  },
  State_53981_Name = {
    Text = "Traum von Schmuck und Schwarzsiegel-Korrektur"
  },
  State_53981_WeaponDesc = {
    Text = "Nach Beginn des Kampfes wird zusätzlich das gesamte Karten-Set des Benutzers in den Ziehstapel gemischt"
  },
  State_54002_Name = {
    Text = "Status@Schmuck Traum der Medizin Auswahlmarkierung"
  },
  State_54002_WeaponDesc = {
    Text = "Nach der Nutzung der Wahnsinnsexplosion erhält das Team des Ausrüstenden 100% basierend auf seiner VERT <RetaliateIconKeywords:Theke>. Seine aktuelle <RetaliateIconKeywords:Theke> erhöht sich um 10%"
  },
  State_54011_Name = {
    Text = "Status@Schmuck Traum der Medizin Kopie 1 Verfügbar"
  },
  State_54011_WeaponDesc = {
    Text = "Nach der Nutzung der Wahnsinnsexplosion erhält das Team des Ausrüstenden 100% basierend auf seiner VERT <RetaliateIconKeywords:Theke>. Seine aktuelle <RetaliateIconKeywords:Theke> erhöht sich um 10%"
  },
  State_54012_Name = {
    Text = "Status@Schmuck Traum der Medizin Kopie 2 Verfügbar"
  },
  State_54012_WeaponDesc = {
    Text = "Nach der Nutzung der Wahnsinnsexplosion erhält das Team des Ausrüstenden 100% basierend auf seiner VERT <RetaliateIconKeywords:Theke>. Seine aktuelle <RetaliateIconKeywords:Theke> erhöht sich um 10%"
  },
  State_54013_Desc = {
    Text = "In dieser Runde Bereichsbeherrschung +[Layer]"
  },
  State_54013_Name = {
    Text = "Temporäre Bereichsbeherrschung"
  },
  State_54014_Desc = {
    Text = "Reichsbeherrschung um [Layer] Punkte erhöht"
  },
  State_54014_Name = {
    Text = "Reichsbeherrschung"
  },
  State_54043_WeaponDesc = {
    Text = "Nach der Nutzung der Wahnsinnsexplosion werden die Schutzschilde und die Heilungskraft des Ausrüstenden in dieser Runde verdoppelt"
  },
  State_54044_Desc = {
    Text = "Verursacht doppelten Schaden und erhält zusätzlich 600% Keyflare entsprechend der Keyflare-Regeneration von Ramona: Zeitverwittert, wird jedoch nach dem Spielen <DepleteIconKeywords:erschöpft>."
  },
  State_54044_Name = {
    Text = "Ode an morgen"
  },
  State_54045_Desc = {
    Text = "Erhalte 3 Punkte Arithmetica"
  },
  State_54045_Name = {
    Text = "Wiedergeburtstribunal"
  },
  State_54046_Desc = {
    Text = "Zu Beginn der Runde heile [StateArg1] Lebenspunkte für [Layer] Runden"
  },
  State_54046_Name = {
    Text = "Vernunft, Wahrheit, und Realität"
  },
  State_54071_Desc = {
    Text = "Ogiers Anzahl der Aktiven SCH-Instanzen +1, hält [Layer] <plural value=\"[Layer]\" singular=\"Runde\" plural=\"Runden\"> an."
  },
  State_54071_Name = {
    Text = "Sieben Künste, Acht Tugenden"
  },
  State_54121_Desc = {
    Text = "In diesem Kampf erhöht sich der Grundschaden der “Chaosbestie“ um [Layer] %."
  },
  State_54121_Name = {
    Text = "Chaosbestie"
  },
  State_54138_Desc = {
    Text = "Sorel aktiviert [Layer] Befehlskarten 2 Mal"
  },
  State_54138_Name = {
    Text = "Karussel der Ambitionen"
  },
  State_54384_Desc = {
    Text = "Erhöhe die von Nymphaea verursachte <IntoxicationIconKeywords:Gift> um 50%, für [Layer] Runden"
  },
  State_54384_Name = {
    Text = "Passage des Egos"
  },
  State_54416_Desc = {
    Text = "Das Freischalten des Übersteigerter Wutanfall ermöglicht es, den Aliemus-Balken zweimal zu füllen. Wenn der Balken zum zweiten Mal voll ist, wird die Fähigkeit zum Übersteigerter Wutanfall aufgewertet, die zusätzliche starke Bonuseffekte hinzufügt. Wenn stattdessen eine normale Verherrlichung freigesetzt wird, werden zusätzlich 50% des überschüssigen Aliemus verbraucht."
  },
  State_54416_Name = {
    Text = "<OverLimitUtlSkillKeywords:Über-Erhöhung>"
  },
  State_54416_WeaponDesc = {
    Text = "Verbrauche Embryo-Karten aus der Hand und aktiviere einen mächtigen Verschlingungseffekt"
  },
  State_54561_Desc = {
    Text = "Einzigartig im Team: Der Schadenswert, den der Ausrüster verursacht, erhöht sich um <WeaponEffect_Num:[StateArg1]%> der ANGskraft des Ausrüsters. Wenn das aktuelle Reich “Fleisch“ ist, erhöht sich der Schadenswert, den der Ausrüster verursacht, zusätzlich um 3% der ANGskraft des Ausrüsters, wenn der Verschlingungseffekt ausgelöst wird."
  },
  State_54561_WeaponDesc = {
    Text = "Der vom Ausrüster verursachte Schaden erhöht sich um [DescArg1] Punkte. Wenn das aktuelle Reich „Fleisch“ ist und der Ausrüster den Verschlingungseffekt auslöst, erhöht sich der vom Ausrüster verursachte Schaden zusätzlich um [DescArg2] Punkte."
  },
  State_54568_Name = {
    Text = "bis zum Ende des Planeten"
  },
  State_54597_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nachdem ein gegnerischer Erweckter Körper gestorben ist, erhältst du [StateArg1] <StrongEffectKeywords:Amplifikation> und legst deren „Fähigkeit\" mit den höchsten Arithmetica-Kosten mit <PVPVoidKeywords:Nichtigkeit> in deine Hand."
  },
  State_54597_Name = {
    Text = "Millionen liebevolle Blicke"
  },
  State_54704_Desc = {
    Text = "“24“'s nächste Befehlskarte wird 3 Mal wirksam"
  },
  State_54704_Name = {
    Text = "Verdrehtes Leichenfest"
  },
  State_54798_Desc = {
    Text = "Alle von Erweckern verursachten Schutz und Lebensregeneration sowie die Effekte des verursachten <PowerIconKeywords:Macht> verringern sich um [StateArg1]%, die Regenerationswirkung des glänzenden Kapitels erhöht sich"
  },
  State_54798_Name = {Text = "“Ai“"},
  State_54799_Desc = {
    Text = "Alle von Erweckern verliehenen <PowerIconKeywords:Macht>, <RetaliateIconKeywords:Theke> und <IntoxicationIconKeywords:Gift> erhöhen sich um [StateArg1]%. Die <PowerIconKeywords:Macht> des glänzenden Kapitels erhöht sich"
  },
  State_54799_Name = {
    Text = "“Furcht“"
  },
  State_54800_Desc = {
    Text = "Der endgültige Schaden, der von allen Erweckern verursacht wird, erhöht sich um [StateArg1]%, die kritische Rate und der kritische Schaden des glänzenden Kapitels erhöhen sich"
  },
  State_54800_Name = {
    Text = "“ Wut “"
  },
  State_55108_Desc = {
    Text = "Zu Beginn der Runde wird „Grüne Flamme“ oder „Verderbte Grüne Flamme“ in deiner Hand zu „Tödliche Grüne Flamme“ aufgewertet, für [Layer] Runden"
  },
  State_55108_Name = {
    Text = "Todeszeichen erscheint"
  },
  State_55108_WeaponDesc = {
    Text = "Am Ende der Runde, wenn sich in der Hand oder im Hyperraum, erhält man Verstärkungen"
  },
  State_55113_Desc = {
    Text = "Ohrla erhält 10 Punkte Wahnsinn, nachdem sie die erste Gedichtkarte pro Runde ausspielt"
  },
  State_55113_Name = {
    Text = "Wiederbegegnung von Blume und Gedicht"
  },
  State_55465_Name = {
    Text = "Verbraucht [Layer] Schichten Metapher „Wut“, verursacht zusätzlichen Schaden [DescArg1] Mal"
  },
  State_55466_Name = {
    Text = "Verbraucht [Layer] Schichten Metapher „Trauer“, stellt <Heal:[Heal:DescArg1]> Leben wieder her"
  },
  State_55467_Name = {
    Text = "Verbraucht [Layer] Schichten Metapher „Furcht“, erhält zusätzlich [Power:DescArg1] <PowerIconKeywords:Kraft>"
  },
  State_55469_Name = {
    Text = "Verbraucht [Layer] Schichten Metapher „Freude“, erhält zusätzlich <Energy:[Energy:DescArg1]> Wahnsinn"
  },
  State_55470_Name = {
    Text = "Schädelräuber"
  },
  State_55485_Desc = {
    Text = "Die nächsten [Layer] Karten, die Casiah spielt, erhalten Macht in Höhe von 10% ihres ANG."
  },
  State_55485_Name = {
    Text = "Lass dich gehen und lache"
  },
  State_55486_Name = {
    Text = "Übererschöpfung in der Stadt der toten Träume befreit von den Träumenverbrauch"
  },
  State_55487_Desc = {
    Text = "Ericas „Schlag“ verursacht zusätzlich 2 Schadenspunkte, „VERT“ erhält 2 zusätzliche Schilde, die für [Layer] Runden anhalten"
  },
  State_55487_Name = {
    Text = "Mehrere Berechnungen"
  },
  State_55489_Name = {Text = "Zeitfalte"},
  State_55806_Name = {
    Text = "<PoetryKeywords:Opfergabe>: Gewähre allen feindlichen Einheiten einen negativen <PVPWonderfulEffectKeywords: wunderbarer Effekt> oder gewähre allen befreundeten Einheiten einen positiven <PVPWonderfulEffectKeywords: wunderbarer Effekt> oder ziehe 1 Karte und erhalte 1 Arithmetica"
  },
  State_55807_Name = {
    Text = "Ziehe 1 Karte, erhalte 1 Arithmetica"
  },
  State_55808_Name = {
    Text = "<PoetryKeywords:Opfergabe>: Gewähre allen befreundeten Einheiten einen positiven <PVPWonderfulEffectKeywords: wunderbarer Effekt> oder ziehe 1 Karte und erhalte 1 Arithmetica"
  },
  State_55809_Name = {
    Text = "Gib allen Feinden negative <PVPWonderfulEffectKeywords:wunderbare Effekte>"
  },
  State_55811_Desc = {
    Text = "Wähle eine der aufgeführten Optionen"
  },
  State_55811_Name = {
    Text = "<ComaColour:Wahl>"
  },
  State_55813_Name = {
    Text = "<PoetryKeywords:Opfergabe>: Gewähre allen feindlichen Einheiten einen negativen <PVPWonderfulEffectKeywords: wunderbarer Effekt> oder ziehe 1 Karte und erhalte 1 Arithmetica"
  },
  State_55814_Name = {
    Text = "<PoetryKeywords:Opfergabe>: Gewähre allen feindlichen Einheiten einen negativen <PVPWonderfulEffectKeywords: wunderbarer Effekt> oder gewähre allen befreundeten Einheiten einen positiven <PVPWonderfulEffectKeywords: wunderbarer Effekt>"
  },
  State_55816_Name = {
    Text = "Gib allen Verbündeten positive <PVPWonderfulEffectKeywords:wunderbare Effekte>"
  },
  State_55824_Desc = {
    Text = "Wähle eine der aufgeführten Optionen, entferne die gewählte Option und lege diese Karte in die Hand des Gegners, wenn noch Optionen übrig sind"
  },
  State_55824_Name = {
    Text = "<ComaColour:Opfergabe>"
  },
  State_55836_Desc = {
    Text = "Am Ende der Runde wird die Ausdauer der Horla-Befehlskarte in der Hand um -1 reduziert"
  },
  State_55836_Name = {
    Text = "Tinte zum Gedicht"
  },
  State_55839_Desc = {
    Text = "Beim Aufnehmen verliere alle anderen Relikte und erhalte zufällig 2 goldene Relikte"
  },
  State_55866_Desc = {
    Text = "Team Unique: Zu Beginn des Kampfes ziehen Sie 1 Befehlskarte des Ausrüsters, und es besteht eine <WeaponEffect_Num:[StateArg1]%> Chance, dass deren Arithmetica-Kosten um 1 reduziert wird. Jedes Mal, wenn der Todwiderstand ausgelöst wird, wird dieser Effekt erneut ausgelöst."
  },
  State_55866_WeaponDesc = {
    Text = "Zu Beginn des Kampfes ziehen Sie 1 Befehlskarte des Ausrüsters, und es besteht eine <WeaponEffect_Num:[StateArg1]%> Chance, dass deren Arithmetica-Verbrauch um 1 reduziert wird. Jedes Mal, wenn Widerstand gegen den Tod ausgelöst wird, wird dieser Effekt erneut ausgelöst."
  },
  State_55992_Desc = {
    Text = "Bei unzureichender Rechenleistung wird den Karten Verbrauch und Markierungen zugewiesen"
  },
  State_55992_Name = {Text = "Glut"},
  State_55993_Name = {
    Text = "Aschezeichen"
  },
  State_56018_Desc = {
    Text = "In diesem Kampf wird die maximale Gesundheit um [Layer]% erhöht"
  },
  State_56018_Name = {
    Text = "Musens Gnade - Schicksal"
  },
  State_56020_Desc = {
    Text = "Schaden in diesem Kampf um [Layer]% erhöht"
  },
  State_56020_Name = {
    Text = "Musens Gnade - Stärke"
  },
  State_56030_Desc = {
    Text = "Innerhalb dieser Runde werden die durch den Erwecker erzeugten Schilde und Heilungen um [Layer] % erhöht"
  },
  State_56030_Name = {Text = "Schnee"},
  State_56031_Desc = {
    Text = "In dieser Runde erhältst du für jeden verursachten Schaden vorübergehend eine erhöhte kritische Rate von +[Layer] %"
  },
  State_56031_Name = {
    Text = "Schmetterling"
  },
  State_56034_Desc = {
    Text = "Jede Art von “Metapher“ kann maximal 3 Schichten haben. Unterschiedliche “Metaphern“ verstärken die unterschiedlichen Effekte der Gedichte: \n<D06CardKeyWordnu:Knurrpsalm>: Verbrauche alle Metaphern “Wut“, jede Metapher verursacht zusätzlich 2-mal Schaden. \n<D06CardKeyWordai:Elegiepsalm>: Verbrauche alle Metaphern “Ai“, jede Metapher stellt zusätzlich LP wieder her. \n<D06CardKeyWordxi:Jubelliedpsalm>: Verbrauche alle Metaphern “Freude“, jede Metapher gewährt zusätzlich 10 Punkte Aelius. \n<D06CardKeyWordju:Klagepsalm>: Verbrauche alle Metaphern “Furcht“, jede Metapher gewährt zusätzlich <PowerIconKeywords:Stärke>."
  },
  State_56034_Name = {Text = "Metapher"},
  State_56208_Desc = {
    Text = "Klagelied des Regens: Stellt <Heal:[DescArg1]> LP wieder her.\nWindespsalm: Erhält [DescArg2] <PowerIconKeywords:Stärke>.\nBlumenhymne: Gewährt allen Erweckten Körpern <Energy:10> Aliemus.\nMondhymne: Krit. Rate +30% in dieser Runde."
  },
  State_56208_Name = {Text = "Dichtblatt"},
  State_56330_Desc = {
    Text = "Erhalte [DescArg1] Punkte Schild, wenn in dieser Runde 3 Mal Aelius ausgelöst wurde, wirkt diese Karte zusätzlich 1 Mal"
  },
  State_56330_Name = {
    Text = "Hochrangige Vorstellung"
  },
  State_56331_Desc = {
    Text = "Wählen Sie eine Befehlskarte aus dem Nachziehstapel und Ablagestapel, um sie in die Hand zu legen, und senken Sie ihren Arithmetica-Verbrauch um -2"
  },
  State_56331_Name = {
    Text = "Hochrangige Vorstellung"
  },
  State_56332_Desc = {
    Text = "Erhalte [DescArg1] Punkte temporäre <PowerIconKeywords:Macht>. Nach dem Ausspielen erhältst du für jeden verursachten Schaden in dieser Runde +3% kritische Rate"
  },
  State_56332_Name = {
    Text = "Hochrangige Vorstellung"
  },
  State_56333_Desc = {
    Text = "Stelle 10% des verlorenen Lebens wieder her. Wenn das aktuelle Leben unter 25% liegt, wirkt diese Karte zusätzlich einmal"
  },
  State_56333_Name = {
    Text = "Hochrangige Vorstellung"
  },
  State_56334_Desc = {
    Text = "Der nächste Schlüsselbefehl wird 2 Mal aktiviert"
  },
  State_56334_Name = {
    Text = "Hochrangige Vorstellung"
  },
  State_56335_Desc = {
    Text = "Verursacht <FixedDamage:Reinen SCH> in Höhe von 150% der Max LP, der einen 10×-<PowerIconKeywords:STR>-Bonus genießt."
  },
  State_56335_Name = {
    Text = "Hochrangige Vorstellung"
  },
  State_56336_Desc = {
    Text = "Ziehe 5 Karten"
  },
  State_56336_Name = {
    Text = "Hochrangige Vorstellung"
  },
  State_56337_Desc = {
    Text = "Erhalte [DescArg1] Punkte temporäre <AlertIconKeywords:Alarm>. Nach dem Ausspielen wird der in dieser Runde erzeugte Schild und die Heilung um [DescArg2]% erhöht"
  },
  State_56337_Name = {
    Text = "Hochrangige Vorstellung"
  },
  State_56338_Desc = {
    Text = "Erhalte 3 Punkte Arithmetica"
  },
  State_56338_Name = {
    Text = "Hochrangige Vorstellung"
  },
  State_56339_Desc = {
    Text = "Vertreibt zufälligen Debuff. Diese Karte wirkt 3 Mal zusätzlich, Verbrauch"
  },
  State_56339_Name = {
    Text = "Hochrangige Vorstellung"
  },
  State_56340_Desc = {
    Text = "Fügt allen Feinden 3 Runden <VulnerabilityIconKeywords:Verwundbarkeit> zu. Wenn ein Feind stirbt, lege diese Karte aus dem Deck auf die Hand"
  },
  State_56340_Name = {
    Text = "Hochrangige Vorstellung"
  },
  State_56341_Desc = {
    Text = "Reichsbeherrschung +25 Punkte, temporäre Reichsbeherrschung +125 Punkte"
  },
  State_56341_Name = {
    Text = "Hochrangige Vorstellung"
  },
  State_56342_Desc = {
    Text = "Alle Erwachten erhalten 15 Wahnsinn"
  },
  State_56342_Name = {
    Text = "Hochrangige Vorstellung"
  },
  State_56343_Desc = {
    Text = "Fügt allen Feinden 3 Runden <WeaknessIconKeywords:Schwäche> zu, lege eine Kopie dieser Karte in den Ablagestapel, füge <DepleteIconKeywords:Verbrauchen>, <NothingnessIconKeywords:Nichtigkeit> hinzu"
  },
  State_56343_Name = {
    Text = "Hochrangige Vorstellung"
  },
  State_56372_Desc = {
    Text = "Beim Tod entferne den letzten negativen Zustand des Spielers"
  },
  State_56372_Name = {
    Text = "Blume und Gedicht"
  },
  State_56400_Desc = {
    Text = "Nach “Schlag“ werden die eigenen “Fähigkeiten“ in der Hand nacheinander in andere “Fähigkeiten“ geändert [ShowIfState:, <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]."
  },
  State_56400_Name = {
    Text = "Blumen und Gedichte der Vergangenheit"
  },
  State_56402_Desc = {
    Text = "Besitze Metapher <D06CardKeyWordnu:“Wut“> [DescArg2] Schichten: Wenn “Knurrpsalm“ den Sprung auslöst, wird zusätzlicher Schaden verursacht. \n Besitze Metapher <D06CardKeyWordai:“Ai“> [DescArg3] Schichten: Wenn “Elegiepsalm“ den Sprung auslöst, wird zusätzlich LP wiederhergestellt. \n Besitze Metapher <D06CardKeyWordxi:“Freude“> [DescArg1] Schichten: Wenn “Jubelliedpsalm“ den Sprung auslöst, erhält der Erwecker zusätzlich Wahnsinn. \n Besitze Metapher <D06CardKeyWordju:“Furcht“> [DescArg4] Schichten: Wenn “Täuschung“ den Sprung auslöst, wird zusätzlich Stärke gewonnen."
  },
  State_56402_Name = {Text = "Metapher"},
  State_57166_Desc = {
    Text = "Schaden des Erweckungskörpers um 25% erhöht"
  },
  State_57170_Desc = {
    Text = "Handkartenlimit +2, am Ende des Zuges 1 Handkarte wählen, um sie zu behalten und ihre Arithmetica Kosten um -1 zu senken, für 3 Züge"
  },
  State_57170_Name = {
    Text = "Verirrtes Licht"
  },
  State_57316_Desc = {
    Text = "Zu Beginn jeder Runde wird 1 „Embryo\" in „Nachkomme der Reinheit\" umgewandelt. Falls kein „Embryo\" vorhanden ist, <EmbryoFusionIconKeywords:Embryofusion> +[Blood:DescArg1], nicht beeinflusst durch Effekte zur Erhöhung der Embryofusion. Aufrechterhalten für [Layer] Runden."
  },
  State_57316_Name = {
    Text = "Legacy der ewigen heiligen Reliquien"
  },
  State_57317_Desc = {
    Text = "Wenn sich dieses Schicksalsrad im Deck befindet, kannst du die bevorstehenden Änderungen deiner Fähigkeiten in der Hand sehen."
  },
  State_57317_Name = {
    Text = "<PVPFlowerKeywords:Blumen und Gedichte der Vergangenheit>"
  },
  State_57324_Desc = {
    Text = "Wenn dieser Erweckte „Blumen und Gedichte der Vergangenheit“ auslöst, verwandelt sich diese Karte in <CardKeyWord:<SkillName1:>>"
  },
  State_57324_Name = {
    Text = "Blumen und Gedichte der Vergangenheit"
  },
  State_57325_Desc = {
    Text = "Wenn dieser Erweckte „Blumen und Gedichte der Vergangenheit“ auslöst, verwandelt sich diese Karte in <CardKeyWord:<SkillName2:>>"
  },
  State_57325_Name = {
    Text = "Blumen und Gedichte der Vergangenheit"
  },
  State_57326_Desc = {
    Text = "Wenn dieser Erweckte „Blumen und Gedichte der Vergangenheit“ auslöst, verwandelt sich diese Karte in <CardKeyWord:<SkillName3:>>"
  },
  State_57326_Name = {
    Text = "Blumen und Gedichte der Vergangenheit"
  },
  State_57335_Name = {
    Text = "Diese Karte erhält zusätzlichen Schaden von [DescArg1] mal Stärke"
  },
  State_57356_Name = {
    Text = "Zustand @ Abgrundbewohner Theke Berechnung"
  },
  State_57368_Name = {
    Text = "Zustand @ Abgrundbekämpfer Rückschlagsprung"
  },
  State_57413_Name = {
    Text = "Jeder Schildpunkt erhöht den Schaden dieser Karte um [DescArg1]"
  },
  State_57417_Desc = {
    Text = "Jedes Mal, wenn der Todwiderstand ausgelöst wird, füge 100% festen Gegenangriff-Schaden zu. Jedes Mal, wenn der Todwiderstand während dieses Kampfes ausgelöst wird, erhöht sich der festgesetzte Schaden um 25%"
  },
  State_57417_Name = {
    Text = "Liebeswiege"
  },
  State_57566_Name = {
    Text = "Verzweifeltes Überleben"
  },
  State_57587_Desc = {
    Text = "Nach dem Ausspielen von „Drüsenaufspaltung“, ziehe 1 Karte, verbleibende [Layer] Male"
  },
  State_57587_Name = {
    Text = "Quallen, versammelt euch!"
  },
  State_57665_Name = {
    Text = "Schutz der göttlichen Mutter"
  },
  State_57728_Desc = {
    Text = "Uvhash erhöht die Schadensanzahl um 1"
  },
  State_57728_Name = {
    Text = "Geschenk der Blutwoge"
  },
  State_57751_Desc = {
    Text = "Team Unique: Die Schilde des Ausrüsters erhöhen sich um <WeaponEffect_Num:[StateArg1]%. Nach der Freisetzung des Bande erhalten alle Erwecker <WeaponEffect_Num:[StateArg2]%> temporäre kritische Trefferquote und kritischen Schaden, jedoch mit einem Opfer von 3% der maximalen Lebenspunkte. Wenn das aktuelle Reich “Aequor“ ist, erhöht sich der Tentakelschaden um <WeaponEffect_Num:[StateArg3]%> der ANGskraft des Ausrüsters nach der Freisetzung des Bande."
  },
  State_57751_WeaponDesc = {
    Text = "Der Ausrüster erhöht das Schutzschild um <WeaponEffect_Num:[StateArg1]%. Nach der Freisetzung des Bande erhalten alle Erwecker <WeaponEffect_Num:[StateArg2]%> temporäre kritische Trefferquote und kritischen Schaden, aber es werden [DescArg1] Punkte Opferritual hinzugefügt. Wenn das aktuelle Reich “Aequor“ ist, erhöht sich nach der Freisetzung des Bande der Tentakelschaden um [DescArg2] Punkte."
  },
  State_57753_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Erhalte [StateArg1] Stapel von <PVPSleepKeywords:Qualitätsnap>, wenn ausgerüstet."
  },
  State_57753_Name = {
    Text = "Schlaf unter dem Gletscher"
  },
  State_57766_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Nach dem ersten „Erheben“ in jedem Zug, erhalte temporäre <StrongEffectKeywords:Amplifikation> +[StateArg1]."
  },
  State_57766_Name = {Text = "Hirtenstab"},
  State_57767_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Am Ende der Runde wird <Energy:[Energy:StateArg1]> Wahnsinn abgezogen und in <PVPDerivativeCardKeywords_12:“Kleiner Wunsch“> umgewandelt. Falls die Umwandlung fehlschlägt, erhält man <Energy:[Energy:StateArg2]> Wahnsinn."
  },
  State_57767_Name = {
    Text = "Vorstellung, die nie aufhört"
  },
  State_57768_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Der Schaden von „Fähigkeit“ wird um [StateArg1]% erhöht. Nach „Erheben“ stelle [StateArg2]% der verlorenen HP wieder her."
  },
  State_57768_Name = {
    Text = "Bis der Schneeberg schmilzt"
  },
  State_57769_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Nachdem der Ausrüster eine Fähigkeitskarte gespielt hat, zieht er 1 Fähigkeitskarte, maximal 1-mal pro Runde wirksam."
  },
  State_57769_Name = {
    Text = "Tor der Wahrheit"
  },
  State_57770_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Schaden, Heilung und Schild-Effekt der „Fähigkeit \" erhöhen sich um [StateArg1] ~[StateArg2] %(aktuell [Layer] %), <PhantomKeywords:Phantasma>."
  },
  State_57770_Name = {
    Text = "Schicksalsroulette"
  },
  State_57814_Name = {
    Text = "Wenn dieses Zeichen vorhanden ist, bedeutet dies, dass das Schicksalsrad gewechselt wird. Einige Logik benötigt dieses Zeichen zur Identifizierung."
  },
  State_57817_Desc = {
    Text = "Kann nicht handeln. Am Ende der Runde Stapel - 1. Sobald die Stapel erschöpft sind, <StrongEffectKeywords:Amplifikation> +5. Kann nicht aufgelöst werden. Das Ändern des Rads des Schicksals entfernt den Zustand Qualitätsnap."
  },
  State_57817_Name = {
    Text = "Feiner Schlaf"
  },
  State_57854_Desc = {
    Text = "Zu Beginn der Runde [StateArg1] Schildpunkte und [StateArg2] Tentakelschaden erhalten, 2 temporäre Tentakel erzeugen, wirkt [Layer] Runden lang."
  },
  State_57854_Name = {
    Text = "Freier Schwur"
  },
  State_57854_WeaponDesc = {
    Text = "Status@Tiefsee-Dame Tee und Kuchen"
  },
  State_57864_Name = {
    Text = "Bonus der aktualisierten Stärke"
  },
  State_57942_Desc = {
    Text = "Fusionsgrad [Layer]%. Bei 100% zwingt der Feind in die nächste Phase und setzt stärkere Phasenfähigkeiten frei"
  },
  State_57942_Name = {
    Text = "Fusionsgrad"
  },
  State_57952_Desc = {
    Text = "Wenn die Stärke verringert wird, wird nur 50% der Stärkeschichten reduziert"
  },
  State_57952_Name = {
    Text = "Tiefer Tauchgang"
  },
  State_57953_Desc = {
    Text = "Am Ende der Runde, erzeuge 1 Tentakel. Entferne diesen Zustand nach dem Erwachen"
  },
  State_57953_Name = {Text = "Schlaf"},
  State_57955_Desc = {
    Text = "Der von Helot verursachte Schaden wird um [StateArg1]% erhöht und hält [Layer] Runden lang an."
  },
  State_57955_Name = {
    Text = "Kampf ums Überleben·Schaden"
  },
  State_57968_Desc = {
    Text = "Durch den Einfluss von Juliette erhöht sich die Zwillingsfusion um 10% nach jeder Runde und 1 Karte \"Verzerrung\" wird in den Nachziehstapel gemischt"
  },
  State_57968_Name = {
    Text = "“ Yuliettes Gesang “"
  },
  State_57970_Name = {
    Text = "Schutz der göttlichen Mutter"
  },
  State_57976_Desc = {
    Text = "„Sohn der Dunkelheit“ führt eine Erzwungene Fusion durch und verursacht festgesetzten Schaden an „Anfang des Vergessens“, der dem 3-fachen seines aktuellen Lebens entspricht"
  },
  State_57976_Name = {Text = "Opfergabe"},
  State_58051_Desc = {
    Text = "Kritischer Schaden +[Layer]%"
  },
  State_58051_Name = {
    Text = "Krit. Schaden"
  },
  State_58052_Desc = {
    Text = "Bei jedem Verbrauch von 1 Punkt des schwarzen Siegels während der Erkundung erhöht sich der Grundschaden von „All-In“ um 0,5 %. (Um [DescArg1]% erhöht)"
  },
  State_58052_Name = {
    Text = "sicherer Gewinn"
  },
  State_58061_Name = {
    Text = "Ehrlichkeit im Fund von Geld"
  },
  State_58063_Desc = {
    Text = "Schaden des Erweckungskörpers um 25 % erhöht, hält [Layer] Runden an."
  },
  State_58063_Name = {
    Text = "Ein Blick, der die Urzeiten übertrifft"
  },
  State_58144_Desc = {
    Text = "In diesem Level wird die kritische Rate um [Layer]% erhöht"
  },
  State_58144_Name = {
    Text = "Permanente Kritische Trefferquote"
  },
  State_58144_WeaponDesc = {
    Text = "In diesem Level wird die kritische Rate um [Layer]% erhöht"
  },
  State_58259_Desc = {
    Text = "Team Unique: Die kritische Rate des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%. Nach dem Töten eines Feindes erhält der Ausrüster <WeaponEffect_Num:[StateArg2]> Punkte Schwarzes Mal, maximal 3 Mal während der Erkundung. Nach 3 Auslösungen erhöht sich die kritische Rate des Ausrüsters in dieser Erkundung dauerhaft um <WeaponEffect_Num:[StateArg3]%."
  },
  State_58259_WeaponDesc = {
    Text = "Die kritische Trefferquote des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>. Nach dem Töten eines Feindes erhält der Ausrüster <WeaponEffect_Num:[StateArg2]> Punkte schwarzes Mal, maximal 3 Mal während der Erkundung ([DescArg1]/3). Nach 3 Mal erhöht sich die kritische Trefferquote des Ausrüsters dauerhaft um <WeaponEffect_Num:[StateArg3]%> in dieser Erkundung."
  },
  State_58297_Desc = {
    Text = "Ryker erhält [DescArg3] Schwarze Imprägnierung(en), wenn er einen Feind tötet, maximal 5 Mal pro Erkundung.([DescArg1] /5)\nDurch den Kampf erhält man 50/125/250 Schwarze Imprägnierungen, das Schöpfungslimit erhöht sich um 1. Am Ende des Kampfes wähle ein „Das Erbe des Chaos \" und füge es der Reliktliste hinzu.(Bereits erhalten: [DescArg2] Schwarze Imprägnierungen)"
  },
  State_58297_Name = {
    Text = "Gewinner nimmt alles"
  },
  State_58447_Desc = {
    Text = "Beinhaltet die folgenden drei Relikte: \n “Glücklicher Windmantel“: Alle Erwecker erhöhen die kritische Rate um 10%. Die zufälligen Ergebnisse von Ryker und den Würfeln zeigen keinen Minimalwert. \n <TentacleInjurieIconKeywords:Aufstieg>: Die kritische Rate wird auf 15% erhöht, wodurch der Maximalwert der zufälligen Ergebnisse um 1 erhöht wird. \n “Oktaederwürfel“: Jedes Mal, wenn ein Posse freigegeben wird, lege 1 “<C05_yansheng1:Oktaederwürfel>“ auf die Hand. \n <TentacleInjurieIconKeywords:Aufstieg>: Ändere es in, dass 1 “<C05_yansheng2:Glänzender Oktaederwürfel>“ auf die Hand gelegt wird. \n “Großer Mund Knopf“: Zu Beginn der Runde und beim Auslösen der zufälligen Effekte von Ryker oder den Würfeln erhältst du 50 Punkte s-Energie und 2% kritischen Schaden, maximal 30% kritischen Schaden. \n <TentacleInjurieIconKeywords:Aufstieg>: Ändere es in, dass du 100 Punkte s-Energie und 4% kritischen Schaden erhältst, maximal 50% kritischen Schaden."
  },
  State_58447_Name = {
    Text = "<CardKeyWord:Chaos-Erbe>"
  },
  State_58490_Desc = {
    Text = "Wenn alle Müdigkeit entfernt ist, werden alle Erwachenden und Karten versiegelt und die Absicht des \"Schlafenden Meisters\" wird zu \"Königliche Macht\" geändert"
  },
  State_58490_Name = {
    Text = "Schläfrigkeit"
  },
  State_58491_Desc = {
    Text = "Jedes Mal nach dem Ausspielen einer Karte 1 Schicht “Müdigkeit“ entfernen. Zu Beginn der Runde wird die Anzahl der Schichten “Müdigkeit“ auf 12 auffüllt."
  },
  State_58491_Name = {Text = "Zorn"},
  State_58492_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_58492_Name = {
    Text = "Nicht erweckt"
  },
  State_58493_Desc = {
    Text = "Jedes Mal nach dem Ausspielen einer Karte 1 Schicht “Müdigkeit“ entfernen. Zu Beginn der Runde wird die Anzahl der Schichten “Müdigkeit“ auf 12 auffüllt."
  },
  State_58493_Name = {Text = "Zorn"},
  State_58947_Desc = {
    Text = "In diesem Level wird die kritische Rate um [Layer]% erhöht"
  },
  State_59078_Name = {
    Text = ", kann 1 Mal verwendet werden"
  },
  State_59079_Name = {
    Text = ", kann 2 Mal verwendet werden"
  },
  State_59080_Name = {
    Text = ",kann 3 Mal verwendet werden"
  },
  State_59117_Desc = {
    Text = "Kritischer Schaden +[Layer]%"
  },
  State_59117_Name = {
    Text = "Krit. Schaden"
  },
  State_59160_Desc = {
    Text = "Erhöht den gesamten verursachten Schaden, die Heilung und den Rollen-Schild um 10 %, nicht entfernbar."
  },
  State_59160_Name = {
    Text = "<CardKeyWord:Stark>"
  },
  State_59161_Desc = {
    Text = "Erhöht den verursachten Schaden, die Heilung und den Rollen-Schild um [DescArg1] %. Nicht entfernbar."
  },
  State_59161_Name = {
    Text = "Amplifikation"
  },
  State_59169_Desc = {
    Text = "Die Grundkosten dieser Karte überschreiten nicht die Arithmetica-Grenze."
  },
  State_59169_Name = {
    Text = "Gleichgewicht"
  },
  State_59173_Name = {
    Text = "Wenn dieses Zeichen vorhanden ist, bedeutet dies, dass mehrere Schläge durchgeführt werden und mehrere Schläge nicht erneut ausgelöst werden."
  },
  State_59208_Desc = {
    Text = "Reduziert den gesamten verursachten Schaden, die Heilung und den Rollen-Schild um 10 %, nicht entfernbar."
  },
  State_59208_Name = {
    Text = "<WeaknessColour:Starker Verlust>"
  },
  State_59209_Desc = {
    Text = "Schaden, Heilung und Schild-Effekte werden um [DescArg1]% reduziert. Kann nicht beseitigt werden."
  },
  State_59209_Name = {
    Text = "Amplifikation▼"
  },
  State_59423_Desc = {
    Text = "Ryker erhält 5 Schwarze Imprägnierungen, wenn er einen Feind tötet. Für jede 1% des Siegelertrags erhöht sich die erhaltene Menge um 1%, maximal 5 Mal pro Erkundung. \nDurch den Kampf erhält man 50/125/250 Schwarze Imprägnierungen, das Schöpfungslimit erhöht sich um 1. Am Ende des Kampfes wähle ein „Das Erbe des Chaos\" und füge es der Reliktliste hinzu."
  },
  State_59423_Name = {
    Text = "Gewinner nimmt alles"
  },
  State_59424_Desc = {
    Text = "Bei jedem Verbrauch von 1 Punkt des schwarzen Siegels während der Erkundung erhöht sich der Grundschaden von „All-In“ um 0,5 %"
  },
  State_59424_Name = {
    Text = "sicherer Gewinn"
  },
  State_59439_Desc = {
    Text = "Dieser Zustand verwendet Verwundbarkeitsmultiplikatoren und tut so, als wäre es ein unabhängiger Multiplikator."
  },
  State_59439_Name = {
    Text = "Wenn ein bestimmter Zustand vorhanden ist, wird der erlittene Schaden verdoppelt"
  },
  State_59519_Name = {
    Text = "Wähle eine Befehlskarte aus dem Ablagestapel oder aus dem Nachziehstapel und füge sie deiner Hand hinzu, während ihr Arithmetica-Verbrauch auf 0 gesetzt wird"
  },
  State_59520_Desc = {
    Text = "Der Kostenverbrauch der Befehlskarte erhöht sich um +1. Ziehe 3 Karten, nachdem du sie gespielt hast, und reduziere ihre Kostenverbrauch auf den der Befehlskarte, die Siegel sind in diesem Kampf nicht wirksam"
  },
  State_59520_Name = {
    Text = "<WhiteQuality:Wissen>"
  },
  State_59521_Name = {
    Text = "Verliere 10% aktuelles Leben ([DescArg1])"
  },
  State_59522_Desc = {
    Text = "Nach dem Spielen lege nicht zugehörige Handkarten des Erweckers ab, um gleich viele zufällige Karten zu erhalten, die Prägung in diesem Kampf wird unwirksam"
  },
  State_59522_Name = {
    Text = "<WhiteQuality:Freude>"
  },
  State_59525_Name = {
    Text = "Die zugehörige Erwachte der Befehlskarte erhält 50 Wahnsinnspunkte"
  },
  State_59526_Desc = {
    Text = "Nach dem Spielen fülle die Handkarten mit einer ursprünglichen Kopie, die <NothingnessIconKeywords: Nichtigkeit> und <DepleteIconKeywords: Verbrauch> hat. Die Prägung in diesem Kampf wird unwirksam"
  },
  State_59526_Name = {
    Text = "<WhiteQuality:Fortpflanzung>"
  },
  State_59534_Name = {
    Text = "Wenn dieses Zeichen vorhanden ist, bedeutet es, dass diese Karte das Auslösen von Phantasma verbietet."
  },
  State_59560_Name = {
    Text = "Wähle eine Karte, die drei Grundmarkierungen erhalten hat, um sie in die Hand zu nehmen"
  },
  State_59671_Desc = {
    Text = "In dieser Runde verursachter Endschaden aller Erweckten +15 %"
  },
  State_59671_Name = {
    Text = "Überstringuhr"
  },
  State_59673_Name = {
    Text = "Winzige Spieluhr"
  },
  State_59678_Desc = {
    Text = "Beim Aufnehmen verliere alle anderen Relikte und erhalte zufällig 2 goldene Relikte"
  },
  State_59878_Desc = {
    Text = "Am Ende der Runde reduziere zusätzlich 1 Stapelung von „Chaos \" und erhalte [StateArg1] <PowerIconKeywords:Stärke>. Die LP der nachfolgend beschworenen Klone von „ N\" erhöhen sich um 200%, und nach dem Tod reduziert „ N \" nicht mehr die Stapelungen von „Chaos\" und erhält keine <PowerIconKeywords:Stärke> mehr."
  },
  State_59878_Name = {
    Text = "Chaos-Ankunft"
  },
  State_59991_Name = {
    Text = ", diese Karte kann beim Ausspielen maximal 5 Schichten <EnergyStorageKeywords:Aufladung> verbrauchen"
  },
  State_59993_Name = {
    Text = "Stelle 10% des verlorenen Lebens wieder her ([DescArg1])"
  },
  State_60000_Desc = {
    Text = "Beim Erleiden von Aktivem Schaden wird 1 Stapel vorübergehender <MadnessIconKeywords:Wahnsinn> erhalten."
  },
  State_60000_Name = {
    Text = "Wutakkumulation"
  },
  State_60028_Desc = {
    Text = "Zu Beginn des Zuges des Spielers wird zufällig eine seiner Handkarten die Rechenleistung in diesem Zug auf 3 ändern. Nach dem Tod verliert dieser Effekt seine Wirkung und reduziert die Rechenleistung aller Karten des Täters in diesem Zug um 1"
  },
  State_60028_Name = {Text = "Wahnkäfig"},
  State_60044_Name = {
    Text = "Verbraucht nach [Layer] Anwendungen"
  },
  State_60083_Desc = {
    Text = "In dieser Runde erlittener SCH –[Layer]%."
  },
  State_60083_Name = {
    Text = "<ReinforceColour:verstärkt>"
  },
  State_60083_WeaponDesc = {
    Text = "Verursachter Gesamtschaden um [DescArg1] % reduziert"
  },
  State_60085_Desc = {
    Text = "Zu Beginn des Kampfes und zu Beginn der Runde erhältst du temporär verstärkt. Je höher das Leben des Spielers ist, desto mehr Schichten erhältst du, maximal 50 Schichten"
  },
  State_60085_Name = {
    Text = "Ultimative Verpuppung"
  },
  State_60085_WeaponDesc = {
    Text = "Verursachter Gesamtschaden um [DescArg1] % reduziert"
  },
  State_60086_Desc = {
    Text = "Zu Beginn des Kampfes und zu Beginn der Runde erhältst du temporär verstärkt. Je höher das Leben des Spielers ist, desto mehr Schichten erhältst du, maximal 25 Schichten"
  },
  State_60086_Name = {Text = "Verpuppung"},
  State_60086_WeaponDesc = {
    Text = "Verursachter Gesamtschaden um [DescArg1] % reduziert"
  },
  State_60087_Desc = {
    Text = "Verwundbarkeitseffekt wird zu [Layer]% Lebensregeneration"
  },
  State_60087_Name = {
    Text = "<Rune_14_High:Verstärkte Verwundung>"
  },
  State_60087_WeaponDesc = {
    Text = "Verursachter Gesamtschaden um [DescArg1] % reduziert"
  },
  State_60088_Desc = {
    Text = "Jede Stapelung reduziert den erlittenen Schaden um 1%."
  },
  State_60088_Name = {
    Text = "<ReinforcePVEKeywords:verstärken>"
  },
  State_60088_WeaponDesc = {
    Text = "Erhalte 25% weniger Schild"
  },
  State_60089_Desc = {
    Text = "Erlittener SCH –[Layer]%."
  },
  State_60089_Name = {
    Text = "<ReinforceColour:verstärkt>"
  },
  State_60089_WeaponDesc = {
    Text = "Verursachter Gesamtschaden um [DescArg1] % reduziert"
  },
  State_60106_Desc = {
    Text = "Nach Rundenbeginn ändert sich der Arithmetica-Verbrauch einer zufälligen Handkarte auf 3 und wird am Rundenende wiederhergestellt"
  },
  State_60106_Name = {Text = "Wahnkäfig"},
  State_60112_Desc = {
    Text = "In dieser Runde erhält jede gespielte Befehlskarte alle Erweckten +1 Wahnsinn"
  },
  State_60112_Name = {Text = "Concerto"},
  State_60115_Desc = {
    Text = "Nach der Freisetzung von Exaltieren in dieser Runde wird die Twin-Fusion um 3% verringert"
  },
  State_60115_Name = {Text = "Requiem"},
  State_60118_Desc = {
    Text = "Der verursachte Schaden, die Vergiftung und der Konter in dieser Runde erhöhen sich um [Layer] %"
  },
  State_60118_Name = {Text = "Rhapsodie"},
  State_60128_Desc = {
    Text = "Ändere die Arithmetica Kosten der Karte vor dem Spielen"
  },
  State_60128_WeaponDesc = {
    Text = "Ändere die Arithmetica Kosten der Karte vor dem Spielen"
  },
  State_60129_Desc = {
    Text = "Du spielst die nächste [Layer]-Karte, nicht abgeleitete Befehlskarte, die Arithmetica-Kosten -2"
  },
  State_60129_Name = {
    Text = "Absteigende Tonleiter"
  },
  State_60130_Desc = {
    Text = "Du spielst die nächste [Layer]-Karte, nicht abgeleitete Befehlskarte, die Arithmetica-Kosten +2 hinzugefügt, wirkt 2 Mal"
  },
  State_60130_Name = {
    Text = "Aufsteigende Tonleiter"
  },
  State_60148_Desc = {
    Text = "Am Ende der Runde erhält man je nach Zustand unterschiedliche Effekte: Offen - erhalten 1 temporäre <MadnessIconKeywords:Wahnsinn> Schicht. Geschlossen - erhalten 50 temporäre <ReinforcePVEKeywords:verstärkt> Schichten"
  },
  State_60148_Name = {
    Text = "Parameteranpassung"
  },
  State_60150_Desc = {
    Text = "Bei jedem Schlüsselbefehl wechselt der Spieler sofort zwischen den Formen „Offen“ und „Zurückhaltend“. Beim Wechsel zu „Offen“ erhält er sofort [StateArg1] temporäre Kraft. Beim Wechsel zu „Zurückhaltend“ erhält er sofort [StateArg2] Schild"
  },
  State_60150_Name = {
    Text = "Funktionsinduktion"
  },
  State_60151_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_60151_Name = {
    Text = "Nicht erweckt"
  },
  State_60154_Desc = {
    Text = "Aktuell ist der Zustand – Zusammenziehen. Der mechanische Arm erhält einen Schild und Alarm, die Absicht wird auf VERT fokussiert"
  },
  State_60154_Name = {
    Text = "Widerrufen: Mecha"
  },
  State_60155_Desc = {
    Text = "Aktuell ist der Zustand – Ausbreiten. Der mechanische Arm wird Macht erlangen und die Absicht wird auf ANG fokussiert"
  },
  State_60155_Name = {
    Text = "Entfesseln: Mecha"
  },
  State_60167_Desc = {
    Text = "Ändere die Arithmetica Kosten der Karte vor dem Spielen"
  },
  State_60167_WeaponDesc = {
    Text = "Ändere die Arithmetica Kosten der Karte vor dem Spielen"
  },
  State_60184_Desc = {
    Text = "Jedes Mal, wenn eine Karte gespielt wird, ändert das \"Widersprüchliche Zwillinge\" seine Absicht"
  },
  State_60184_Name = {
    Text = "Widerspruch"
  },
  State_60187_Desc = {
    Text = "Schwäche, Verwundbarkeit und schwere Verletzungen, die dem Spieler zugefügt werden, sind jeweils 50%"
  },
  State_60187_Name = {
    Text = "Das Ende ist der Beginn"
  },
  State_60201_Name = {
    Text = "Monsterverzögerungskraft"
  },
  State_60263_Desc = {
    Text = "Schwächeeffekt wird zu [Layer]% Schild"
  },
  State_60263_Name = {
    Text = "<Rune_14_High:Verstärkte Schwäche>"
  },
  State_60264_Desc = {
    Text = "Die Bluten-Effekte werden am Ende der Runde nur um 50 % automatisch entfernt"
  },
  State_60264_Name = {
    Text = "<Rune_14_High: Hämolyse>"
  },
  State_60265_Desc = {
    Text = "Der Bluteffekt wird am Ende der Runde automatisch um 50 % entfernt"
  },
  State_60265_Name = {
    Text = "<BleedingColour: Hämolyse>"
  },
  State_60279_Name = {
    Text = "Diese Karte wird am Ende der Runde verbraucht"
  },
  State_60284_Desc = {
    Text = "Zu Beginn des Kampfes und zu Beginn der Runde erhältst du temporär verstärkt. Je niedriger das Leben des Spielers ist, desto mehr Schichten erhältst du, maximal 50 Schichten"
  },
  State_60284_Name = {
    Text = "Unbesiegbare Schwertformation"
  },
  State_60284_WeaponDesc = {
    Text = "Verursachter Gesamtschaden um [DescArg1] % reduziert"
  },
  State_60297_Desc = {
    Text = "“@2“ erscheint in befreiter Form, das Leben wird dreimal so viel. Jeder Zug stellt dem Hüter Fragen und erhält eine Karte „Antwortet Tawil“ in der Hand"
  },
  State_60297_Name = {
    Text = "Wahrheitsermittlung"
  },
  State_60297_WeaponDesc = {
    Text = "Nach Beginn der nächsten Runde, erhalte Schild in Höhe des verlorenen Lebens der letzten Runde"
  },
  State_60298_Desc = {
    Text = "Die Macht des unbekannten Wesens verweilt weiterhin unter der schwarzen Pfütze und wird kurz vor der Niederlage vollständig erwachen, das Leben wiedererlangen und im Geiste der Befreiung den Kampf beginnen"
  },
  State_60298_Name = {
    Text = "Ruhezustand"
  },
  State_60312_Desc = {
    Text = "Jede Runde, wenn insgesamt 10% Lebensschaden erlitten wird, erhält man [Layer] Schichten vorübergehende „Verstärkung“"
  },
  State_60312_Name = {
    Text = "Fusionsschild"
  },
  State_60315_Desc = {
    Text = "Nach der Freisetzung von Wahnsinn in dieser Runde wird 5% ( [DescArg1] ) verlorenes Leben wiederhergestellt"
  },
  State_60315_Name = {Text = "Requiem"},
  State_60336_Name = {
    Text = "Nach dem Ausspielen erhalte 1 Punkt Arithmetica und ziehe 1 Karte, jedoch wird diese Karte verbraucht"
  },
  State_60339_Name = {
    Text = "Nach dem Ausspielen erhalte 1 Rechenleistung und ziehe 1 Karte, jedoch wird diese Karte verbraucht"
  },
  State_60367_Desc = {
    Text = "Zu Beginn des Zuges des Spielers wird zufällig eine seiner Handkarten die Rechenleistung in diesem Zug auf 3 ändern. Nach dem Tod verliert dieser Effekt seine Wirkung und reduziert die Rechenleistung aller Karten des Täters in diesem Zug um 1"
  },
  State_60367_Name = {Text = "Wahnkäfig"},
  State_60386_Desc = {
    Text = "Die Effekte beinhalten: 150% Schaden durch Blutung, 75% Schaden durch Gift, 1 Schicht Schwäche auftragen, 1 Schicht Verwundbarkeit auftragen und vorübergehend [DescArg1] Punkte Macht verringern"
  },
  State_60386_Name = {
    Text = "<MysterydebuffKeywords:Wunderbarer negativer Effekt>"
  },
  State_60404_Desc = {
    Text = "Bei jedem erlittenen Schaden erhält man 2 Schichten vorübergehende Verstärkung"
  },
  State_60404_Name = {
    Text = "Endliche Verwandlung"
  },
  State_60408_Desc = {
    Text = "Jedes Mal, wenn das Leben auf 33% sinkt (noch [DescArg1] Punkte), erleide in dieser Runde keinen Schaden mehr und setze \"Geisterbiss\" frei"
  },
  State_60408_Name = {
    Text = "Geisterbiss"
  },
  State_60409_Desc = {
    Text = "Jedes Mal, wenn das Leben auf 66% sinkt (noch [DescArg1] Punkte), erleide in dieser Runde keinen Schaden mehr und setze \"Endverwandlung\" frei"
  },
  State_60409_Name = {Text = "Endspiegel"},
  State_60429_Name = {
    Text = "Zustand @ Erwecker Hameln @ ursprüngliche Melodie"
  },
  State_60430_Desc = {
    Text = "Wenn du eine Karte spielst, deren tatsächliche Arithmetica-Kosten mit der beabsichtigten Anzeige übereinstimmen, wird sie verbraucht und alle Feinde verlieren [DescArg1] Punkte temporäre STR."
  },
  State_60430_Name = {
    Text = "Notenkommando"
  },
  State_60431_Name = {
    Text = "Zustand @ Erwecker Hameln @ aufsteigender Klang"
  },
  State_60432_Name = {
    Text = "Zustand @ Erwecker Hameln @ Seelenpräludium"
  },
  State_60433_Name = {
    Text = "Zustand @ Erwecker Hameln @ absteigender Klang"
  },
  State_60434_Name = {
    Text = "Zustand @ Erwecker Hameln @ Erinnungsreigen"
  },
  State_60435_Name = {
    Text = "Zustand @ Erwecker Hameln @ Seelenpräludium Zählen"
  },
  State_60436_Desc = {
    Text = "Beim Verursachen von unblockiertem Schaden, mische [StateArg1] Wunden-Karten in den Ziehstapel"
  },
  State_60436_Name = {
    Text = "Seelen-Ouvertüre"
  },
  State_60438_Name = {
    Text = "Zustand @ Erwecker Hameln @ aufsteigender Klang hören"
  },
  State_60439_Name = {
    Text = "Zustand @ Erwecker Hameln @ absteigender Klang hören"
  },
  State_60440_Name = {
    Text = "Zustand @ Erwecker Hameln @ Seelenpräludium hören"
  },
  State_60441_Name = {
    Text = "Zustand @ Erwecker Hameln @ Erinnungsreigen hören"
  },
  State_60442_Name = {
    Text = "Zustand @ Erwecker Hameln @ ursprüngliche Melodie hören"
  },
  State_60486_Desc = {
    Text = "Zu Beginn des Kampfes wird der Wahnsinn aller Erwachten halbiert"
  },
  State_60486_Name = {
    Text = "Muttergöttin saugt"
  },
  State_60487_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, seine maximale Gesundheit um 200 % erhöhen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_60487_Name = {
    Text = "Nicht erweckt"
  },
  State_60490_Desc = {
    Text = "Nach dem Tod erhalten alle Erwachensformen 30 Wahnsinn"
  },
  State_60490_Name = {
    Text = "Wille zum Leben"
  },
  State_60491_Desc = {
    Text = "Alle Erwachten haben 50% weniger Wahnsinn, am Ende der Runde erhalten sie 1 Schicht “<DarkEgo:Dunkle Seite des Selbst>“: Zu Beginn der Runde erhalten alle Erwachten 3 Wahnsinn."
  },
  State_60491_Name = {
    Text = "Mutterbaumritual"
  },
  State_60493_Desc = {
    Text = "Für jede Akkumulation von [Layer] Lebenspunkten wird eine Mimese-Erwecker beschworen. Wenn die Anzahl der Mimese-Erwecker 2 erreicht, erhöht sich das maximal Leben aller Mimese-Erwecker um 50%"
  },
  State_60493_Name = {
    Text = "Mutter der Geburt"
  },
  State_60500_Desc = {
    Text = "Wenn ein simuliertes Erwecker vorhanden ist, erhält man 50 Schichten \"verbergen\""
  },
  State_60500_Name = {
    Text = "im Versteck im Wald"
  },
  State_60511_Desc = {
    Text = "Muss in der Starthand erscheinen"
  },
  State_60511_Name = {
    Text = "<GuyouKeywords:Eigen>"
  },
  State_60511_WeaponDesc = {
    Text = "Nach dem Ausspielen wird die Karte nicht in den Ablagestapel gelegt und kann in diesem Kampf nicht erneut verwendet werden"
  },
  State_60522_Desc = {
    Text = "Schwäche- und Verwundbarkeitseffekte auf 50 % erhöht"
  },
  State_60522_Name = {
    Text = "Zerstörung"
  },
  State_60523_Desc = {
    Text = "Jede Schicht erhöht die ANGe um 1, verliert 1 Schicht bei Schaden, verliert alle am Rundenende"
  },
  State_60523_Name = {Text = "Beten"},
  State_60524_Desc = {
    Text = "Zu Beginn des Kampfes und zu Beginn der Runde erhältst du [Layer] Schichten verstärkt, maximal 50 Schichten"
  },
  State_60524_Name = {Text = "Heiligung"},
  State_60524_WeaponDesc = {
    Text = "Verursachter Gesamtschaden um [DescArg1] % reduziert"
  },
  State_60527_Desc = {
    Text = "Nach dem Ausspielen wird es verbraucht, aber reduziert die temporäre Kraft des Feindes"
  },
  State_60527_Name = {
    Text = "<CardKeyWord:Melodie-Himmel>"
  },
  State_60543_Desc = {
    Text = "Am Ende der Runde erhalte 10 Schichten „Blutschwur“, „Blutschwur“ entfernt 1 Schicht bei Schaden"
  },
  State_60543_Name = {
    Text = "Lichtkernflamme"
  },
  State_60554_Name = {
    Text = "<HuihuanbKeywords:Echo-Ton>"
  },
  State_60558_Name = {
    Text = "<HuihuanbKeywords:Echo-Ton>"
  },
  State_60562_Desc = {
    Text = "Nach dem Ausspielen wirkt sie 2 Mal und wird zu „Ladende Melodie“"
  },
  State_60562_Name = {
    Text = "<HuihuanaKeywords:Echo-Ton>"
  },
  State_60564_Desc = {
    Text = "Beim ersten drohenden Niederlage, LP-Wiederherstellung und Absicht in “Endgültige Evolution“ ändern, um Stärke und Festung zu erhalten. Beim zweiten drohenden Niederlage, LP-Wiederherstellung und Absicht in “Gespenstischer Biss“ ändern, um extrem hohen Einzelschaden zu verursachen."
  },
  State_60564_Name = {
    Text = "Schatten-Dämon"
  },
  State_60567_Desc = {
    Text = "Nach dem Spielen erhält Hameln 3 Punkte Aelius"
  },
  State_60567_Name = {
    Text = "<XushiAKeywords:Kraftvolle Musik>"
  },
  State_60568_Name = {
    Text = "<XushiAKeywords:Kraftvolle Musik>"
  },
  State_60569_Name = {
    Text = "<XushiBKeywords:Kraftvolle Musik>"
  },
  State_60570_Desc = {
    Text = "Nach dem Spielen erhält Hameln 3 Punkte Aelius"
  },
  State_60570_Name = {
    Text = "<XushiBKeywords:Kraftvolle Musik>"
  },
  State_60571_Name = {
    Text = "<HuihuanaKeywords:Echo-Ton>"
  },
  State_60576_Desc = {
    Text = "Zu Beginn des Zuges des Spielers wird zufällig eine seiner Handkarten die Rechenleistung in diesem Zug auf 3 ändern. Nach dem Tod verliert dieser Effekt seine Wirkung und reduziert die Rechenleistung aller Karten des Täters in diesem Zug um 1"
  },
  State_60576_Name = {Text = "Wahnkäfig"},
  State_60578_Desc = {
    Text = "Beim erlittenen tödlichen Schaden wird 50% des Lebens wiederhergestellt, für 1 Runde wird der Schaden immun, die Absicht wird zu \"Schlüpfen\" umgewandelt"
  },
  State_60578_Name = {
    Text = "Puppenbrechen"
  },
  State_60592_Desc = {
    Text = "Zu Beginn der Erkundung wird 1 „Silberschlüssel-Morgendämmerung“ mit <DestructionKeywords:Zerstören> zum Deck hinzugefügt.\nImmer wenn die Posse entfesselt wird, erhöht sich der Krit. Schaden des Ausrüsters um +<WeaponEffect_Num:[StateArg1]%>.\nImmer wenn der Ausrüster Aktiven Schaden verursacht, erhöht sich seine Krit. Rate in dieser Runde um +<WeaponEffect_Num:[StateArg3]%> und du erhältst Keyflare in Höhe von <WeaponEffect_Num:[StateArg2]%> seiner Keyflare-Regeneration, bis zu 5 Mal pro Runde."
  },
  State_60592_WeaponDesc = {
    Text = "Zu Beginn der Erkundung wird 1 „Silberschlüssel-Morgendämmerung“ mit <DestructionKeywords:Zerstören> zum Deck hinzugefügt.\nImmer wenn die Posse entfesselt wird, erhöht sich der Krit. Schaden des Ausrüsters um +<WeaponEffect_Num:[StateArg1]%>.\nImmer wenn der Ausrüster Aktiven Schaden verursacht, erhöht sich seine vorübergehende Krit. Rate um +<WeaponEffect_Num:[StateArg3]%> und du erhältst <WeaponEffect_Num:[DescArg1]> Keyflare, bis zu 5 Mal pro Runde."
  },
  State_60594_Desc = {
    Text = "Team Unique: Am Ende der Runde erhält der Ausrüster 5 Punkte Aliemus. Nachdem der Ausrüster Verherrlichung freisetzt, erhöht sich die kritische Rate, der kritische Schaden, das Schild und die LP-Wiederherstellung der nächsten Befehlskarte des Ausrüsters in dieser Runde um <WeaponEffect_Num:[StateArg1]%>."
  },
  State_60594_WeaponDesc = {
    Text = "Nach dem Ende der Runde erhält der Ausrüster 5 Punkte Wahnsinn. Nachdem der Ausrüster Exaltieren freisetzt, erhöht sich die kritische Rate, der kritische Schaden, das Schild und die Lebensregeneration der nächsten Befehlskarte des Ausrüsters in dieser Runde um <WeaponEffect_Num:[StateArg1]%>"
  },
  State_60898_Desc = {
    Text = "Beim Erleiden von Aktivem Schaden und Tentakelschaden werden die Verherrlichung und Befehlskarten des angreifenden Erweckers für 1 Runde versiegelt und 1 Stapel <ResentChainsKeywords:Kette des Grolls> wird entfernt."
  },
  State_60898_Name = {
    Text = "<ResentChainsKeywords1:Kette des Grolls>"
  },
  State_60925_Desc = {
    Text = "Am Ende der Runde, heile 5% des verlorenen Lebens. Bei Ziehen einer Symptom- oder Zustandskarte erhalten alle Verbündeten [Layer] Stärke"
  },
  State_60925_Name = {
    Text = "Blutlaterne"
  },
  State_60926_Desc = {
    Text = "Am Ende der Runde, wenn das Leben unter 50% liegt, erhalte [Layer] Stärke und [StateArg1] Schicht Barriere"
  },
  State_60926_Name = {
    Text = "Laternenheiligtum"
  },
  State_60953_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: \"Wahnsinns-Exaltation\" fügt allen feindlichen Zielen [StateArg1] Schichten von <PVPSlowKeywords:Langsam> hinzu, bevor sie geworfen werden."
  },
  State_60953_Name = {
    Text = "Ewiges Requiem"
  },
  State_60962_Desc = {
    Text = "In diesem Kampf wird die maximale Gesundheit um [Layer]% erhöht"
  },
  State_60962_Name = {
    Text = "Lebenspunkte erhöhen"
  },
  State_60964_Desc = {
    Text = "Schaden in diesem Kampf um [Layer]% erhöht"
  },
  State_60964_Name = {
    Text = "Schaden erhöht"
  },
  State_61038_Name = {
    Text = "Hameln Demo"
  },
  State_61050_Desc = {
    Text = "Aktiviert den Effekt “Ton“ oder spielt die “Symphonie der Harmonie“ aus, erhält Hameln 1% Krit. Rate und Krit. Schaden (derzeit erhalten: [DescArg1]%). Dieser Effekt erhöht sich nach 10 Auslösungen um 1 für “Seelen-Ouvertüre“ und “Urakkord“ in diesem Kampf, maximal um 2."
  },
  State_61050_Name = {
    Text = "Mondscheingebaren"
  },
  State_61051_Desc = {
    Text = "Aktiviert den Effekt “Ton“ oder spielt die “Symphonie der Harmonie“ aus, erhält Hameln 1% kritische Trefferquote und kritischen Schaden. Dieser Effekt erhöht sich nach 10 Auslösungen um 1 für die Schadensintervalle der “Seelen-Ouvertüre“ und “Urakkord“ in diesem Kampf, maximal um 2."
  },
  State_61051_Name = {
    Text = "Mondscheingebaren"
  },
  State_61056_Desc = {
    Text = "Erste Runde erhält 100 temporäre Kraftpunkte"
  },
  State_61056_Name = {Text = "Wut"},
  State_61084_Desc = {
    Text = "Die nächsten [Layer] Karten, die in dieser Runde gespielt werden: Wenn der Arithmetica-Verbrauch 3 oder mehr beträgt, erhältst du 2 Arithmetica, andernfalls ziehst du 2 Karten."
  },
  State_61084_Name = {
    Text = "Vierte Symphonie"
  },
  State_61085_Desc = {
    Text = "Verbrauch der Rechenleistung - 2, wirkt 2 Mal nach Ausspielen, ändere zu „Kraftvolle Musik“"
  },
  State_61085_Name = {
    Text = "<HuihuanbKeywords:Echo-Ton>"
  },
  State_61089_Desc = {
    Text = "Die nächste ausgespielte Befehlskarte wirkt 2 Mal"
  },
  State_61089_Name = {
    Text = "Dirigierstock"
  },
  State_61145_Name = {
    Text = "<BleedingColour: Bluten>"
  },
  State_61174_Desc = {
    Text = "Kein Schild erhaltbar"
  },
  State_61174_Name = {
    Text = "Überbleibsel zur Bestattung"
  },
  State_61180_Desc = {
    Text = "Der Grundschaden von Blutkette · Helot erhöht sich in diesem Kampf um [DescArg1] %."
  },
  State_61180_Name = {Text = "Racheblatt"},
  State_61185_Desc = {
    Text = "Verstärkt die Fähigkeiten des Feindes. Verliert eine Schicht bei Schaden"
  },
  State_61185_Name = {Text = "Blutsegen"},
  State_62213_Desc = {
    Text = "Ändert den Schwächeeffekt, sodass der ausgeteilte Aktive Schaden und Tentakelschaden um [Layer]% reduziert wird."
  },
  State_62213_Name = {
    Text = "<Rune_14_High:Schwäche vertiefen>"
  },
  State_62309_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Bei der Ausrüstung erhältst du [StateArg1] <StrongEffectKeywords: stark>. Jedes Mal, wenn du Lebenspunkte verlierst, falls deine aktuellen Lebenspunkte unter [StateArg2]% fallen, erhältst du <ReinforceKeywords: verstärkt> und <StrengthenKeywords: Verstärkung>."
  },
  State_62309_Name = {
    Text = "Ertrinken in Blutrot"
  },
  State_62317_Desc = {
    Text = "Immun gegen jeglichen Schaden, nach Rundenbeginn entfernt"
  },
  State_62317_Name = {
    Text = "Vollständig immun gegen Schaden"
  },
  State_62336_Desc = {
    Text = "Ziehe 1 Karte und friere zufällig 1 Befehlskarte aus der Hand ein, nachdem du 3 Karten gespielt hast (noch [Layer] Karten)"
  },
  State_62336_Name = {
    Text = "Lindwurms Kälte"
  },
  State_62337_Desc = {
    Text = "Ziehe 1 Karte und friere zufällig 1 Befehlskarte aus der Hand ein, nachdem du 3 Karten gespielt hast (noch [Layer] Karten)"
  },
  State_62337_Name = {
    Text = "Lindwurms Kälte"
  },
  State_62338_Desc = {
    Text = "Diese Karte kann nicht ausgespielt werden, wird am Ende der Runde nicht verworfen und verleiht dem entsprechenden Erwecker 5 Punkte Wahnsinn. Nach dem Einsatz von Wahnsinnsursprung wird die Einfrierung aufgehoben"
  },
  State_62338_Name = {
    Text = "<CardKeyWord:Einfrieren>"
  },
  State_65332_Desc = {
    Text = "Nach dem Tod erhalten alle Erwachensformen 30 Wahnsinn"
  },
  State_65332_Name = {Text = "Schmelzen"},
  State_65342_Desc = {
    Text = "Nach der Niederlage wird die Person wiederbelebt und erhält zusätzlich 100 % maximale Gesundheit und aktiviert „Frostige Kälte“"
  },
  State_65342_Name = {Text = "Stille"},
  State_65346_Desc = {
    Text = "Nach dem Tod, friere 2 Befehlskarten aus dem Handstapel ein."
  },
  State_65346_Name = {Text = "Frostfall"},
  State_65358_Desc = {
    Text = "Team Unique: Der Grundschaden, den der Ausrüster verursacht, erhöht sich um <WeaponEffect_Num:[StateArg1]%>. Vor der Freisetzung von Verherrlichung erhöht sich die temporäre Handgröße um +1, und der Ausrüster zieht eine Befehlskarte. Wenn das aktuelle Reich “Fleisch“ ist, erhöht sich der temporäre kritische Schaden des Ausrüsters beim Auslösen von Verschlingen um <WeaponEffect_Num:[StateArg1]%, und dieser Effekt kann pro Runde nur einmal aktiviert werden."
  },
  State_65358_WeaponDesc = {
    Text = "Der Grundschaden des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]>. Vor der Freisetzung der Verherrlichung erhöht sich die temporäre Handgröße um 1, und der Ausrüster zieht 1 Befehlskarte. Wenn das aktuelle Reich “Fleisch“ ist, erhöht sich der temporäre kritische Schaden des Ausrüsters um <WeaponEffect_Num:[StateArg1]>, wenn er den Verschlingungseffekt auslöst, maximal einmal pro Runde."
  },
  State_65360_Desc = {
    Text = "Team Unique: Der Grundschaden des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>. Zu Beginn des Kampfes erhält der Ausrüster 25 Schichten “Schnee“. Nachdem der Ausrüster eine Karte spielt, erhält er 2 Punkte Aliemus und entfernt 1 Schicht. Nachdem “Schnee“ vollständig entfernt wurde, erhält der Ausrüster <WeaponEffect_Num:[StateArg2]%> kritische Rate."
  },
  State_65360_WeaponDesc = {
    Text = "Der Grundschaden des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>. Zu Beginn des Kampfes erhält der Ausrüster 25 Schichten “Schnee“. Nachdem der Ausrüster eine Karte gespielt hat, erhält er 2 Punkte Aliemus und entfernt 1 Schicht. Wenn “Schnee“ vollständig entfernt ist, erhält der Ausrüster <WeaponEffect_Num:[StateArg2]%> kritische Trefferquote (aktuell verbleibende [DescArg1] Schichten Schnee)."
  },
  State_65362_Desc = {
    Text = "Nach dem Empfang von [StateArg1] aktiven Schäden (verbleibend [Layer] Mal), friere zufällig 1 Befehlskarte in deiner Hand ein"
  },
  State_65362_Name = {
    Text = "Frostwiederkehr"
  },
  State_65463_Name = {
    Text = "Erhalte 5 Punkte das schwarze Siegel"
  },
  State_65490_Desc = {
    Text = "Am Ende der Runde erhältst du [StateArg1] Schicht Frostschild und [StateArg2] Stärke."
  },
  State_65490_Name = {
    Text = "Absoluter Nullpunkt"
  },
  State_65497_Name = {
    Text = "Blutkette · Shiro Testspiel"
  },
  State_65553_Desc = {
    Text = "Am Ende der Runde, erhalte Kraft basierend auf der Anzahl der verbleibenden Karten in der Hand, [Layer] Punkte pro Karte"
  },
  State_65553_Name = {
    Text = "Eisige Schneide"
  },
  State_65557_Desc = {
    Text = "Nach erlittenem tödlichen Schaden werden alle Lebenspunkte wiederhergestellt, die Intention wird in “Weltraumblick EX“ gewandelt, 80 Schichten vorübergehende Festung erhalten und alle negativen Zustände von dir selbst sowie positive Zustände des Spielers werden entfernt. Am Ende der Runde entfernt sich selbst 20 Schichten Verstärkung."
  },
  State_65557_Name = {
    Text = "Urgotisches Chaos"
  },
  State_65558_Desc = {
    Text = "Nach erlittenem kritischen Schaden wird die Absicht in “Weltraumblick“ gewandelt und 80 Schichten vorübergehende Festung erhalten, alle Lebenspunkte werden wiederhergestellt, kann [DescArg1]-mal ausgelöst werden. Nach Erschöpfung der Auslösungen bleibt bei erlittenem tödlichen Schaden 1 Lebenspunkt erhalten, die Absicht wird in “Augen der unendlichen Welten“ geändert. Am Ende der Runde entfernt sich selbst 20 Schichten Festung."
  },
  State_65558_Name = {
    Text = "Sternenstaub"
  },
  State_65559_Desc = {
    Text = "Nach dem Tod aller erscheint Tohuwabohu erneut."
  },
  State_65559_Name = {
    Text = "Urweltsplitter"
  },
  State_65564_Name = {
    Text = "\n<D05EX_Relic: Die Zweifel der Mitglieder der Expedition an Helot nehmen ständig zu, Sie müssen eine Wahl treffen, bevor der Feind näher kommt, um das verwirrte Team zu beruhigen>"
  },
  State_65565_Name = {
    Text = [[

<D05EX_Relic:Ignoriere das Misstrauen der Teilnehmer und gehe weiter>]]
  },
  State_65566_Name = {
    Text = "\n<D05EX_Relic:Erkläre die Situation den Expeditionsteilnehmern>"
  },
  State_65567_Name = {
    Text = "\n<D05EX_Relic: Fesseln Sie Helot, um die Teammitglieder weiter zu schützen>"
  },
  State_65568_Name = {
    Text = "\n<D05EX_Relic: Einschränkung des Heloten und volle Kraftschutz der Teammitglieder mithilfe der Energie des Erweckers>"
  },
  State_65585_Desc = {
    Text = "Nach dem Ausspielen kehrt diese Karte auf die Hand zurück. Das Orison ist bis zum Rundenende deaktiviert."
  },
  State_65585_Name = {
    Text = "<CardKeyWord:Echo>"
  },
  State_66305_Desc = {
    Text = "Am Rundenende wird 1 Stapel temporärer <ResentChainsKeywords:Kette des Grolls> erhalten."
  },
  State_66305_Name = {
    Text = "Das zeitlose Schloss"
  },
  State_66306_Desc = {
    Text = "Beim Erleiden von Aktivem Schaden und Tentakelschaden werden die Verherrlichung und Befehlskarten des angreifenden Erweckers für 1 Runde versiegelt und 1 Stapel <ResentChainsKeywords:Kette des Grolls> wird entfernt."
  },
  State_66306_Name = {
    Text = "<ResentChainsKeywords1:Kette des Grolls>"
  },
  State_66308_Desc = {
    Text = "Nach erlittenem kritischen Schaden wird das Leben auf 1 Punkt gesperrt."
  },
  State_66308_Name = {
    Text = "Urgotisches Chaos"
  },
  State_66311_Desc = {
    Text = "Die Erinnerungen an die Erwecker strömen aus den Rändern deines Geistes und verwurzeln und wachsen in deinem Kopf. Egal, wie oft du sie durchtrennst, egal wie oft die Auflösung sie umwirft, sie sind nie verschwunden"
  },
  State_66311_Name = {
    Text = "Zersplitterte Erinnerungen"
  },
  State_66313_Desc = {
    Text = "Jedes Mal, wenn eine Befehlskarte ausgespielt wird, eine Karte dieses Erweckers mit dem niedrigsten Arithmetica-Verbrauch abwerfen."
  },
  State_66313_Name = {
    Text = "Überwille Druck"
  },
  State_66314_Desc = {
    Text = "Immun gegen jeglichen Schaden."
  },
  State_66314_Name = {
    Text = "Vollständig immun gegen Schaden"
  },
  State_66317_Desc = {
    Text = "Die Erinnerungen an die Erwecker strömen aus den Rändern deines Geistes und verwurzeln und wachsen in deinem Kopf. Egal, wie oft du sie durchtrennst, egal wie oft die Auflösung sie umwirft, sie sind nie verschwunden. Zu Beginn jeder Runde erhältst du 1 Punkt Arithmetica-Grenze und 2 Punkte Maximale Handgröße."
  },
  State_66317_Name = {
    Text = "Erinnerungssplitter"
  },
  State_66325_Desc = {
    Text = "Die Erinnerungen an die Erwecker strömen aus den Rändern deines Geistes und verwurzeln und wachsen in deinem Kopf. Egal, wie oft du sie durchtrennst, egal wie oft die Auflösung sie umwirft, sie sind nie verschwunden. Zu Beginn jeder Runde erhöhe die Arithmetica-Grenze um 1 und die maximale Handgröße um 2."
  },
  State_66325_Name = {
    Text = "Erinnerungssplitter"
  },
  State_66358_Desc = {
    Text = "Beim ersten Auslösen des Todeswiderstands während der Erkundung, füge eine „<DerivativeCardKeywords_39:Echo der Vergangenheit>“ in deine Hand"
  },
  State_66358_Name = {
    Text = "Nicht existierende Existenz"
  },
  State_66359_Desc = {
    Text = "Zufällig mehrere Optionen generieren, aus denen gewählt werden kann."
  },
  State_66359_Name = {
    Text = "<FaxianKeywords:Entdecken>"
  },
  State_66360_Desc = {
    Text = "In diesem Kampf wird die kritische Rate um [Layer]% erhöht"
  },
  State_66360_Name = {Text = "Krit. Rate"},
  State_66362_Desc = {
    Text = "Kritischer Schaden in diesem Kampf um [Layer]% erhöht"
  },
  State_66362_Name = {
    Text = "Krit. Schaden"
  },
  State_66409_Name = {
    Text = "Urteil des Vollstreckers"
  },
  State_66410_Desc = {
    Text = "Die nächsten [DescArg1] Befehlskarten von Tawil, die ausgespielt werden, wirken 2 Mal."
  },
  State_66410_Name = {
    Text = "Omnifex-Konvergenz"
  },
  State_66414_Desc = {
    Text = "In der Hand, wenn die oberste Karte des Ziehstapels eine Befehlskarte ist, verwandelt sie sich in eine Kopie"
  },
  State_66414_Name = {
    Text = "Allwissende Wahrheit"
  },
  State_66454_Desc = {
    Text = "Fähigkeitskarte Arithmetica Verbrauch verringern „verbergen“ Stapel bis zu 5 Stapel, nach erlittenem Schaden oder ausgespielter Fähigkeit 1 Stapel entfernen"
  },
  State_66454_Name = {Text = "Verbergen"},
  State_66456_Desc = {
    Text = "Fähigkeitskarte Arithmetica Verbrauch verringern „verbergen“ Stapel bis zu 5 Stapel, nach erlittenem Schaden oder ausgespielter Fähigkeit 1 Stapel entfernen"
  },
  State_66456_Name = {
    Text = "<YinniColour: verbergen>"
  },
  State_66465_Desc = {
    Text = "Nach Nutzung des Wahnsinns Exaltieren erlebe den entsprechenden Schaden gemäß der Schichtanzahl"
  },
  State_66465_Name = {
    Text = "<PVPfengsuoColour:Eruption Blockade>"
  },
  State_66522_Desc = {
    Text = "Jede 8. gespielte Karte wirkt doppelt"
  },
  State_66522_Name = {
    Text = "Hervorragendes Gebräu"
  },
  State_66553_Desc = {
    Text = "Nachdem du „ANG“ und „VERT“ gespielt hast, erhält der entsprechende Erwecker 35 Aelius. Aber ihre Arithmetica Kosten erhöhen sich um 1"
  },
  State_66553_Name = {
    Text = "Zerstörte Visage"
  },
  State_66554_Desc = {
    Text = "Beim Aufheben wird 1 <DerivativeCardKeywords_1:„Echo der Schatten“> auf die Hand gelegt"
  },
  State_66554_Name = {
    Text = "Kommunikationsgerät"
  },
  State_66555_Desc = {
    Text = "Maximale Arithmetica erhöht sich um 1"
  },
  State_66555_Name = {
    Text = "Vitaliätsspritze"
  },
  State_66556_Desc = {
    Text = "Jedes Mal, wenn dieselbe Karte eines Erwachens nacheinander gespielt wird, erhält das Erwachen 8 Wahnsinn"
  },
  State_66556_Name = {
    Text = "Chronometrisches Gerät"
  },
  State_66557_Desc = {
    Text = "Immer wenn du Leben verlierst, erhältst du [DescArg1] <PowerIconKeywords:Stärke> (max. 10 Mal pro Kampf). Bei voller Stapelung, heilen 25% des verlorenen Lebens"
  },
  State_66557_Name = {
    Text = "Höchste Ehre"
  },
  State_66558_Desc = {
    Text = "Alle 3 Runden füge allen Feinden 1 Schicht <WeaknessIconKeywords:Schwäche> hinzu. Bei Schaden gegen <WeaknessIconKeywords:Schwäche>-Feinde erhalte [DescArg1] temporäre <PowerIconKeywords:Stärke> (max. 3 Mal pro Runde)"
  },
  State_66558_Name = {
    Text = "Bösartiges Kind"
  },
  State_66559_Desc = {
    Text = "Wenn du eine Karte spielst, die 3 oder mehr Arithmetica kostet, ziehe 1 Karte und erhalte 1 Punkt Arithmetica"
  },
  State_66559_Name = {
    Text = "Schönheit im Verlust"
  },
  State_66560_Desc = {
    Text = "“Schaden“ erhält 2 Punkte Arithmetica, verworfen zufällig 1 Karte; „VERT“ zieht 2 Karten und verliert 1 Punkt Arithmetica. Maximal 3 mal pro Runde aktiv"
  },
  State_66560_Name = {
    Text = "Fröhliche Schallplatte"
  },
  State_66561_Desc = {
    Text = "Alle 3 Runden füge allen Feinden 1 Schicht <VulnerabilityIconKeywords:Verwundbarkeit> hinzu. Bei Schaden gegen <VulnerabilityIconKeywords:Verwundbarkeit>-Feinde verlieren diese [DescArg1] temporären <PowerIconKeywords:Stärke> (max. 3 Mal pro Runde)"
  },
  State_66561_Name = {
    Text = "Frühlinszeremonie"
  },
  State_66562_Desc = {
    Text = "Alle 4 Züge wird der erlittene Schaden aller Gegner in dieser Runde verdoppelt, aber nach der Freisetzung von Aelius in dieser Runde, werden alle Erwecker 1 Runde versiegelt"
  },
  State_66562_Name = {
    Text = "Überreste des Pfadläufers"
  },
  State_66563_Desc = {
    Text = "Zu Beginn der Runde, wenn im letzten Zug mehr als 3 Karten gespielt wurden, ziehe 2 Karten"
  },
  State_66563_Name = {
    Text = "Brandneue Geldbörse"
  },
  State_66564_Desc = {
    Text = "Beim Aufheben erhält man 3 Punkte Zugkraft"
  },
  State_66564_Name = {Text = "Spiegeluhr"},
  State_66565_Desc = {
    Text = "Beim Aufheben wird auf alle Feinde für 1 Runde <WeaknessIconKeywords:Schwäche> und <VulnerabilityIconKeywords:verwundbar> angewendet"
  },
  State_66565_Name = {
    Text = "Farbwechselnde Restraint-Kombi"
  },
  State_66566_Desc = {
    Text = "Zu Beginn jeder Runde erhöht sich <DeathResistanceIconKeywords:Todwiderstand> um 10% (In diesem Level wird der erhaltene Todwiderstand bei jeder Auslösung um die Hälfte reduziert). Wenn der <DeathResistanceIconKeywords:Todwiderstand> über 100% liegt, erhöht sich <ProficientInRealmsIconKeywords:Reichsbeherrschung> um 100."
  },
  State_66566_Name = {
    Text = "Träne der Sirene"
  },
  State_66703_Desc = {
    Text = "Team Unique: Die Obergrenze der Silberschlüsselansammlung erhöht sich um 100%. Maximale Handgröße +2, kann nicht mit der von anderen Schicksalsrädern bereitgestellten Handgrößenerhöhung gestapelt werden. Die Keyflare-Regeneration des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%. Nach dem Spielen einer Karte des Ausrüsters erhöht sich in dieser Runde die Krit. Rate und der Krit. Schaden, die verursachten Schilde, Aliemus und Stärke des Ausrüsters um <WeaponEffect_Num:[StateArg2]%>, bis zu 5 Mal stapelbar."
  },
  State_66703_WeaponDesc = {
    Text = "Die Obergrenze der Silberschlüsselansammlung erhöht sich um 100%. Maximale Handgröße +2, kann nicht mit anderen durch das Schicksalsrad bereitgestellten maximalen Handgrößen gestapelt werden. Die Silberschlüsselaufladung des Ausrüsters erhöht sich um <WeaponEffect_Num:[DescArg2]>. Nachdem der Ausrüster eine Karte gespielt hat, erhöhen sich die kritische Rate und der kritische Schaden der Befehlskarten des Ausrüsters in dieser Runde sowie der verursachte Schild, Wahnsinn und Stärke um <WeaponEffect_Num:[StateArg2]%>, maximal 5 Stapel (aktuell [DescArg1] Stapel)."
  },
  State_66722_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Wenn ausgerüstet und zu Rundenbeginn, wenn es keine <PVPProtectiveKeywords:Barriere> gibt, erhalte [StateArg1] Stapel von <PVPProtectiveKeywords:Barriere>; andernfalls erhalte <StrengthenKeywords:Verbessern>."
  },
  State_66722_Name = {
    Text = "Unsichtbares Rad"
  },
  State_66872_Desc = {
    Text = "Der durch Tawil verursachte Schaden, Schild und Heilung erhöhen sich vorübergehend um [StateArg1] % und halten [Layer] Runden an."
  },
  State_66872_Name = {
    Text = "Unendliche Milliarden von Strahlendheit"
  },
  State_66884_Desc = {
    Text = "Am Ende der Runde werden die Arithmetica-Kosten gesenkt, und wird verworfen, wird dieser Effekt ebenfalls ausgelöst"
  },
  State_66884_Name = {
    Text = "<PrepareKeypvewords: Vorbereiten 1>"
  },
  State_66888_Desc = {
    Text = "Team Unique: Nach der Freigabe des Posse erhält der Ausrüster <WeaponEffect_Num:[StateArg1]%> <PowerIconKeywords:Stärke> und einen Schild in Höhe von <WeaponEffect_Num:[StateArg2]%> seiner VERT. Nach dem Einsatz des Notfall-Gnosis-Körpers erhält jeder Erwecker am Rundenende <WeaponEffect_Num:[StateArg3]> Punkte Aliemus."
  },
  State_66888_Name = {Text = "Silberherz"},
  State_66888_WeaponDesc = {
    Text = "Nach Freigabe des Schlüsselbefehls erhältst du <WeaponEffect_Num:[Power:DescArg1]> Punkte <PowerIconKeywords:Stärke> und <WeaponEffect_Num:[Block:DescArg2]> Punkte Schild. Nach Verwendung des Notfall-Gnosis-Körpers erhalten am Ende der Runde alle Erwecker <WeaponEffect_Num:[StateArg3]> Punkte Aliemus."
  },
  State_66893_Desc = {
    Text = "Einzigartig im Team: Nach Beginn des Kampfes erhältst du s-Energie in Höhe von <WeaponEffect_Num:[StateArg1]%> der Silberschlüsselaufladung des Ausrüsters. Nach der ersten Freisetzung des Bande in jedem Kampf wird dieser Effekt einmal wiederholt."
  },
  State_66893_WeaponDesc = {
    Text = "Nach Beginn des Kampfes erhältst du <WeaponEffect_Num:[DescArg1]> Punkte s-Energie. Nach der ersten Freisetzung des Schlüssels in jedem Kampf wird dieser Effekt einmal wiederholt"
  },
  State_66896_WeaponDesc = {
    Text = "Ändere die Arithmetica Kosten der Karte vor dem Spielen"
  },
  State_66900_Desc = {
    Text = "Dieser Karten-Schaden, Heilung und Schild erhöhen sich um [StateArg1]%"
  },
  State_66900_Name = {Text = "Silberherz"},
  State_66901_Desc = {
    Text = "Schaden, Heilung und Schild-Effekte um [DescArg1] % erhöht, wirkt 1 Runde lang"
  },
  State_66901_Name = {
    Text = "Temporäre stark"
  },
  State_66902_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nach dem Tod eines anderen verbündeten Erweckers erhalte <Block:[Block:StateArg1]> Schild und lege dessen „Fähigkeit \" mit den niedrigsten Arithmetica-Kosten in die Hand."
  },
  State_66902_Name = {Text = "Silberherz"},
  State_66971_Desc = {
    Text = "Wenn das Leben auf 0 sinkt, wird es auf 1 Punkt umgewandelt und erleidet keinen Schaden mehr"
  },
  State_66971_Name = {
    Text = "Welttrennung"
  },
  State_67234_Desc = {
    Text = "Am Ende der Runde beschwöre einen „Klon von Gehirn im Glas,\" der [Layer] <plural value=\"[Layer]\" singular=\" Runde \" plural=\" Runden \"> dauert."
  },
  State_67234_Name = {Text = "Trennung"},
  State_67235_Desc = {
    Text = "Beim Tod alle Leben wiederherstellen, Lebensobergrenze +100%, „Seelenplage“ auslösen"
  },
  State_67235_Name = {
    Text = "Nicht erweckt"
  },
  State_67237_Desc = {
    Text = "Bei Erreichen von 10 Schichten ändert sich die Absicht in „Nihil-Ende“: Setze das Lebenslimit des Gegners auf 1"
  },
  State_67237_Name = {Text = "Ende"},
  State_67238_Desc = {
    Text = "Am Ende der Runde erhält man eine Schicht \"Ende\". Nach dem erlittenen tödlichen Schaden wird dieser Zustand entfernt und liefert 1 Runde lang Immunität gegen Schaden, heilt 15% Leben und erhält 10 Schichten \"Ende\""
  },
  State_67238_Name = {
    Text = "Seelenfäule"
  },
  State_67240_Desc = {
    Text = "“Wissende“erhält 25 Schichten temporäre <ReinforcePVEKeywords:Stärkung> und [Power:StateArg1] Punkte temporäre <PowerIconKeywords:Macht> , Zustand entfernen"
  },
  State_67240_Name = {
    Text = "<TuiyanColour:Lehre>"
  },
  State_67241_Desc = {
    Text = "Beim Tod alle Leben wiederherstellen, Lebensobergrenze +100%, „Ritterliche Leidenschaft“ auslösen"
  },
  State_67241_Name = {
    Text = "Nicht erweckt"
  },
  State_67242_Desc = {
    Text = "Beim Tod alle Leben wiederherstellen, Lebensobergrenze +100%, “Seelenfleisch@1 Punkt“ freigeben."
  },
  State_67242_Name = {
    Text = "Nicht erweckt"
  },
  State_67243_Desc = {
    Text = "Am Ende der Runde beschwöre einen \"Gehirn im Fass\"-Klone. Wenn der \"Gehirn im Fass\"-Klone \"Trennung der Essenz\" auslöst, stiehlt er zusätzlich 5% deiner Stärke."
  },
  State_67243_Name = {
    Text = "@1gelöstes Gewebe"
  },
  State_67245_Desc = {
    Text = "Am Ende der Runde erhält man [StateArg1] Punkte <PowerIconKeywords: Macht>"
  },
  State_67245_Name = {
    Text = "Rittereifer"
  },
  State_67246_Desc = {
    Text = "Beim ersten Zerbrechen des Schildes in jeder Runde verliert man 25 % der maximalen LP, erhält [Power:DescArg1] Punkte <PowerIconKeywords: Temporäre STR> und [Layer] Schichten vorübergehende Festung. Zu Beginn der nächsten Runde erhält man <Block:[Block:DescArg2]> Schichten Schild und erhält für jede Auslösung des “Ritterschaftlichen Credos“ zusätzlich 1 Mal Schild."
  },
  State_67246_Name = {
    Text = "Ritterschaftliches Credo"
  },
  State_67247_Desc = {
    Text = "Am Ende jeder Runde werden Feinde rekruitiert, wobei maximal 2 Feinde gleichzeitig existieren. Nach dem Tod eines Feindes, verliert der „verfaulte Kopf“ 5% maximale Gesundheit"
  },
  State_67247_Name = {Text = "Abgrundtor"},
  State_67252_Desc = {
    Text = "Beim erlittenen tödlichen Schaden wird man selbst an die Hinterreihe versetzt und behält 1 Lebenspunkt, danach kann keiner mehr Schaden erleiden, <PowerIconKeywords: Macht> erhöht [DescArg1]. Selbstzerstörung entfaltet diesen Effekt nicht"
  },
  State_67252_Name = {
    Text = "Geisterstofftrennung"
  },
  State_67253_Desc = {
    Text = "Nachdem du [Layer] Karten gespielt hast, erscheint vorne 1 „Gehirn im Glas-Klon“, maximal 3 Klone gleichzeitig"
  },
  State_67253_Name = {
    Text = "Gehirn im Tank"
  },
  State_67255_Desc = {
    Text = "Beim Tod alle Leben wiederherstellen, Lebensobergrenze +100%, „erste Philosophie“ auslösen"
  },
  State_67255_Name = {
    Text = "Nicht erweckt"
  },
  State_67256_Desc = {
    Text = "Nach der Ziehphase zeigt das Spiel zufällig drei Befehlskarten aus deiner Hand an, wähle eine, um den „Echos“-Orison zu verleihen und lege die anderen ab"
  },
  State_67256_Name = {
    Text = "Erste Doktrine"
  },
  State_67257_Desc = {
    Text = "Nach der ersten Freisetzung des Schlüsselbefehls jeder Runde erhalten alle Erwecker 10 Aelius, die Freisetzung des Schlüsselbefehls erhöht jedoch den Verbrauch dauerhaft um 10 %"
  },
  State_67257_Name = {
    Text = "Allmählich brechender Link"
  },
  State_67258_Desc = {
    Text = "Beim Kampfbeginn <Block:[Block:DescArg1]> Schild erhalten. Am Ende der Runde bleibt das Schild bestehen"
  },
  State_67258_Name = {
    Text = "Ritterwille"
  },
  State_67347_Desc = {
    Text = "In der Hand, wenn die oberste Karte des Ziehstapels eine Befehlskarte ist, verwandelt sie sich in eine Kopie mit einem Arithmetica-Verbrauch von -1"
  },
  State_67347_Name = {
    Text = "Allwissende Wahrheit"
  },
  State_67353_Desc = {
    Text = "Nach dem Tod verliert das „verfaulte Gehirn“ 5% der maximalen Gesundheit"
  },
  State_67353_Name = {Text = "Schmelzen"},
  State_67358_Desc = {
    Text = "Jedes Mal, wenn ein Spieler 1 Punkt Arithmetica verbraucht, erhält sofort <Block:[Block:StateArg1]> Punkte Schild und 3 Schichten temporäre Verstärkung"
  },
  State_67358_Name = {
    Text = "Instabile Barriere"
  },
  State_67414_Desc = {
    Text = "Unanschaubare Augen. Unwiderruflicher Hauch. Die Teile, die alles erreichen, sind nur Teile. Nun, empfange das vorbestimmte Ende der Zerstörung"
  },
  State_67414_Name = {
    Text = "Gegenüber tausend Ursprüngen treten"
  },
  State_67418_Desc = {
    Text = "Nach dem Spielen lege nicht zugehörige Handkarten des Erweckers ab, um gleich viele mächtige zufällige Karten zu erhalten, die Prägung in diesem Kampf wird unwirksam"
  },
  State_67418_Name = {
    Text = "<WhiteQuality:hohe Freude Prinzip>"
  },
  State_67419_Desc = {
    Text = "Nach dem Spielen fülle die Handkarten mit einer ursprünglichen Kopie, die <NothingnessIconKeywords: Nichtigkeit> und <DepleteIconKeywords: Verbrauch> hat, ihre Arithmetica Kosten um -1 senke. Die Prägung in diesem Kampf wird unwirksam"
  },
  State_67419_Name = {
    Text = "<WhiteQuality:hohe Zucht Prinzip>"
  },
  State_67420_Desc = {
    Text = "Verbrauch von Orison-Karten-Arithmetica +1. Nach dem Ausspielen ziehe 5 Karten, senke ihren Verbrauch auf das Niveau der Orison-Karte, diese bleibt im aktuellen Kampf wirkungslos"
  },
  State_67420_Name = {
    Text = "<WhiteQuality:Wissen>"
  },
  State_67598_Desc = {
    Text = "Nach der Freisetzung von Exaltieren wird eine zufällige Karte, die dem entsprechenden Erwecker zugeordnet ist, in die Hand gelegt. Diese Karte erhält <DepleteIconKeywords:erschöpfen> und <NothingnessIconKeywords:Nichtsigkeit>. Nach dem Kampf werden [DescArg1] Lebenspunkte wiederhergestellt"
  },
  State_67598_Name = {Text = "Arztkoffer"},
  State_67599_Desc = {
    Text = "Wenn eine Befehlskarte gespielt wird, die nicht „Schlag\" oder „VERT\" ist, erhält der entsprechende Erwecker 15 Aliemus, maximal 5 Mal pro Runde. Beim ersten Auslösen in jeder Runde wird die gespielte Karte auch zurück in die Hand genommen."
  },
  State_67599_Name = {
    Text = "Zeitpendel·Projektil"
  },
  State_67600_Desc = {
    Text = "Maximale Arithmetica erhöht sich um 4. Jedes Mal, wenn das Kartenstapel zurückgesetzt wird, füge 4 Karten <DerivativeCardKeywords_4:„Inspiration“> dem Ziehstapel hinzu"
  },
  State_67600_Name = {
    Text = "gesegnet·Schwarze Kerze"
  },
  State_67602_Name = {Text = "Veraltet"},
  State_67603_Desc = {
    Text = "Verursacht 20% mehr Schaden an Feinden mit negativen Zuständen, der Mörder erhält 20 Wahnsinn"
  },
  State_67603_Name = {
    Text = "Hierophantenstab"
  },
  State_67604_Desc = {
    Text = "Jede gespielte Befehlskarte, die einem anderen Erwecker als der vorherigen zugeordnet ist, gewährt dem entsprechenden Erwecker 3 Punkte Aliemus und sammelt 1 Schicht “Vitalität“. Wenn 10 Schichten gesammelt werden, werden alle “Vitalität“ zurückgesetzt und es werden jeweils eine zufällige Befehlskarte mit Arithmetica-Kosten -1 und dem Attribut “Verbrauch“ in die Hand aller Erwecker gelegt, maximal 1-mal pro Runde wirksam."
  },
  State_67604_Name = {
    Text = "Zeitpendel·Entwicklung"
  },
  State_67605_Desc = {
    Text = "Wenn du ein Schild hast, bietet dieses Relikt [DescArg1] Punkte temporäre <PowerIconKeywords:Macht>. Wenn dein Schild höher als dein aktuelles Leben ist, bietet es zusätzlich [DescArg2] Punkte temporäre <PowerIconKeywords:Macht>"
  },
  State_67605_Name = {
    Text = "Taubenfederfächer"
  },
  State_67606_Desc = {
    Text = "Zu Beginn jeder Runde erhält man für jeden Gegner 1 Arithmetica. Wenn man einen Gegner mit aktivem Schaden tötet, erleidet ein anderer Gegner die gleiche Menge an übermäßigem Schaden durch <BleedingIconKeywords:Bluten>"
  },
  State_67606_Name = {Text = "Mob-Lied"},
  State_67607_Desc = {
    Text = "Nach 5 Auslösungen von Exaltieren erhält der Erwecker, der Exaltieren ausgelöst hat, 100 Aelius"
  },
  State_67607_Name = {
    Text = "Winzige Wiege"
  },
  State_67608_Name = {Text = "Veraltet"},
  State_67609_Desc = {
    Text = "Nach dem Auslösen von „Wahnsinnsexplosion“ verliere 8% deines aktuellen Lebens und stehle [DescArg1] Punkte temporäre<PowerIconKeywords:Stärke> von allen Feinden. Wenn nur 1 Feind vorhanden ist, zusätzlich [DescArg2] Punkte temporäre<PowerIconKeywords:Stärke>"
  },
  State_67609_Name = {
    Text = "Omen-Ritualvogel"
  },
  State_67611_Desc = {
    Text = "Alle 2 Züge wird der erlittene Schaden aller Gegner verdoppelt, und in dieser Runde, für jede einmalige Freisetzung von Aelius, wird 1 negative Zustand zufällig aufgelöst"
  },
  State_67611_Name = {
    Text = "Gesegnet: Überreste des Pfadläufers"
  },
  State_67612_Desc = {
    Text = "Der kritische Schaden aller „Schläge“ wird um 20% erhöht. Beim Aufheben erhältst du eine Karte <DerivativeCardKeywords_40: „Wunderschöne Momente“>"
  },
  State_67612_Name = {
    Text = "schöne Momente β"
  },
  State_67614_Desc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwecker 25 Aelius. Beim Aufsammeln wird die maximale Gesundheit auf das 1,5-fache erhöht"
  },
  State_67614_Name = {
    Text = "Gesegnet: Albtraummanifest β"
  },
  State_67615_Desc = {
    Text = "Jedes Mal, wenn die 6. Befehlskarte gespielt wird, kehrt sie aus dem Ablagestapel auf die Hand zurück"
  },
  State_67615_Name = {
    Text = "In der Dämmerung"
  },
  State_67616_Name = {Text = "Veraltet"},
  State_67618_Desc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwecker 25 Aelius. Beim Aufsammeln wird die maximale Gesundheit auf das 1,5-fache erhöht"
  },
  State_67619_Desc = {
    Text = "Handkartenlimit erhöht um 5. Beim Aufheben, Handkarten auf das Limit auffüllen. Am Zuganfang zusätzlich 1 Karte ziehen, am Ende des Zuges alle Symptomkarten und Zustandskarten ablegen, andere Karten behalten."
  },
  State_67619_Name = {
    Text = "Gesegnet: Gedankengravur β"
  },
  State_67620_Desc = {
    Text = "Nach der 3. gespielten Karte jeder Runde lege 1 <DerivativeCardKeywords_4:„Inspiration“> in den Ablagestapel. Nach der 6. gespielten Karte füge 1 <DerivativeCardKeywords_4:„Inspiration“> aus dem Ablagestapel der Hand hinzu"
  },
  State_67620_Name = {
    Text = "Licht der Zivilisation"
  },
  State_67621_Desc = {
    Text = "Nach dem Freisetzen von Aelius erhältst du [DescArg1] Punkte temporäre Macht und stiehlst [DescArg1] Punkte temporäre<PowerIconKeywords:Macht> von allen Feinden. Wenn nur ein Feind vorhanden ist, stiehl zusätzlich [DescArg2] Punkte temporäre<PowerIconKeywords:Macht>"
  },
  State_67621_Name = {
    Text = "Gesegnet: Omen-Ritualvogel"
  },
  State_67622_Desc = {
    Text = "Wenn die letzte 1 Arithmetica aufgebraucht wird, gewinne 2 Arithmetica. Dies kann pro Runde maximal 2 Mal ausgelöst werden"
  },
  State_67622_Name = {
    Text = "Differenzialmotor"
  },
  State_67623_Desc = {
    Text = "Beim Aufnehmen wird dauerhaft [DescArg1] <PowerIconKeywords:Macht> erhalten. Jedes Mal, wenn Schaden verursacht wird, wird [DescArg2] Punkte Gesundheit zurückgewonnen, höchstens 6 Mal pro Runde"
  },
  State_67623_Name = {
    Text = "Gesegnet: Neunaugenkuss"
  },
  State_67624_Name = {Text = "Veraltet"},
  State_67625_Desc = {
    Text = "Nachdem in jeder Runde die erste Befehlskarte in den Ablagestapel gelegt wurde, wird die Arithmetica-Kosten für diese Karte um 1 reduziert und eine temporäre Kopie in den Ziehstapel gemischt"
  },
  State_67625_Name = {
    Text = "Stumme Jukebox"
  },
  State_67626_Desc = {
    Text = "Maximale Arithmetica erhöht sich um 1. Wenn du 2 Mal hintereinander Karten spielst, die eine höhere Arithmetica-Kosten haben als die vorhergehende, erhältst du 1 Arithmetica"
  },
  State_67626_Name = {
    Text = "Arcana-Archiv"
  },
  State_67628_Name = {Text = "Veraltet"},
  State_67630_Name = {Text = "Veraltet"},
  State_67631_Desc = {
    Text = "Maximale Arithmetica erhöht sich um 2. Jedes Mal, wenn das Kartenstapel zurückgesetzt wird, füge 1 Karte <DerivativeCardKeywords_9:„Stolpern“> dem Ziehstapel hinzu"
  },
  State_67631_Name = {
    Text = "Schwarze Kerze"
  },
  State_67632_Name = {Text = "Veraltet"},
  State_67634_Desc = {
    Text = "Am Ende der Runde erhalten alle Erwachten 2 Wahnsinn für jede ungespielte Karte in deiner Hand"
  },
  State_67634_Name = {
    Text = "Schiefe Waage"
  },
  State_67635_Desc = {
    Text = "Beim Aufheben erhalten alle Erwecker 50 Punkte Aelius, und 2 <DerivativeCardKeywords_1:„Echo der Schatten“> werden in den Nachziehstapel gemischt"
  },
  State_67635_Name = {
    Text = "Kommunikationsgerät +β"
  },
  State_67636_Desc = {
    Text = "Kritischer Schaden +15%. Schaden gegen Gegner mit Schild ist garantiert kritisch"
  },
  State_67636_Name = {
    Text = "Prinzipien der Ästhetik"
  },
  State_67637_Desc = {
    Text = "Zu Rundenbeginn ziehen Sie 2 Karten und erhalten 2 Punkte Arithmetica. Jedes Mal, wenn Sie eine Befehlskarte oder Gnosis aufwecken, ändert sich deren Arithmetica-Verbrauch zufällig (0-4)"
  },
  State_67637_Name = {
    Text = "Tricksterhut"
  },
  State_67638_Desc = {
    Text = "Schaden gegen Feinde im negativen Zustand um 50% erhöht, 100 Wahnsinn nach dem Töten eines Feindes erhalten"
  },
  State_67638_Name = {
    Text = "Priesterstab+"
  },
  State_67639_Desc = {
    Text = "Kritische Rate erhöht um 50%, kritischer Schaden erhöht um 100%"
  },
  State_67639_Name = {
    Text = "Gesegnet: Unheimlicher Haken"
  },
  State_67640_Desc = {
    Text = "Kritische Rate und kritischer Schaden erhöhen sich um 100%. Für jede verursachte Schaden/ Tentakelschaden in dieser Runde: Alle Erwecker haben einen kritischen Treffs- und kritischen Schaden von 10% weniger, maximal 50%. Verursachtes Gift und Gegenangriff werden um 10% erhöht, maximal 50%"
  },
  State_67640_Name = {
    Text = "Zeitpendel·Shift Surge"
  },
  State_67641_Desc = {
    Text = "Nach dem Freisetzen von Aelius erhältst du [DescArg1] Punkte temporäre<PowerIconKeywords:Macht>"
  },
  State_67641_Name = {
    Text = "Eisenschloss"
  },
  State_67643_Desc = {
    Text = "Bei aktiven Schaden erhältst du [DescArg1] Punkte Schild. Wenn du Leben zurückgewinnst, erhältst du [DescArg2] Punkte temporäre <PowerIconKeywords:Macht>"
  },
  State_67643_Name = {
    Text = "Unser Zuhause"
  },
  State_67645_Desc = {
    Text = "Kritische Rate +10%. Nach dem ersten kritischen Treffer in jeder Runde erhöht sich die kritische Rate um 20%. Nach dem dritten kritischen Treffer in jeder Runde erhöht sich der kritische Schaden um 50%"
  },
  State_67645_Name = {
    Text = "Festliche Segnung"
  },
  State_67646_Desc = {
    Text = "Bei ungeraden Runden, wenn es verbleibende Arithmetica gibt, ziehst du 2 zusätzliche Karten in der nächsten Runde; bei geraden Runden, wenn es verbleibende Handkarten gibt, erhältst du 2 zusätzliche Arithmetica in der nächsten Runde"
  },
  State_67646_Name = {
    Text = "Sonnenscheibe"
  },
  State_67647_Desc = {
    Text = "Jede fünfte gespielte Befehlskarte bringt zwei Effekte und wird danach wieder auf die eigene Hand zurückgegeben"
  },
  State_67647_Name = {
    Text = "Sternenwein+"
  },
  State_67649_Desc = {
    Text = "Verstecke die Absichten der Monster. Erhalte 1 Punkt Rechenleistung pro Runde, ziehe 1 Karte"
  },
  State_67649_Name = {
    Text = "Fesselnder Glockenschlag"
  },
  State_67650_Desc = {
    Text = "“Schaden“ und „VERT“ erhalten zusätzlich 50 Silberschlüssel-Energie. Jedes Mal, wenn du eine Karte mit 2 oder mehr Arithmetica verbrauchst, ziehe eine Karte mit 1 Arithmetica-Kosten und mache diese zu 0. Maximal 3 mal pro Runde"
  },
  State_67650_Name = {
    Text = "Zeitpendel·Zwillinge"
  },
  State_67651_Desc = {
    Text = "Nach dem Aufheben wird die Beherrschung der Gruppenregion auf 150% des ursprünglichen Werts erhöht. Nach dem Ausspielen der fünften Befehlskarte in jeder Runde erhalten alle Erwachten 20 Wahnsinn"
  },
  State_67651_Name = {
    Text = "Zeitpendel·Unrein"
  },
  State_67653_Desc = {
    Text = "Nach dem Auslösen der Wahnexplosion zweimal pro Runde erhalten alle Erwecker 8 Punkte Wahn, nach dreimaligem Auslösen erhalten alle Erwecker weitere 8 Punkte Wahn"
  },
  State_67653_Name = {
    Text = "Verlassenes Blut"
  },
  State_67654_Name = {
    Text = "Zusätzlich [DescArg1] Mal wirksam"
  },
  State_67656_Desc = {
    Text = "Kritische Rate erhöht um 50%, <FragileIconKeywords:zerbrechlich> für 3 Runden"
  },
  State_67656_Name = {
    Text = "Unheimlicher Haken"
  },
  State_67657_Desc = {
    Text = "Zu Rundenbeginn ziehen Sie 1 Karte. Wenn Sie 2 Mal hintereinander eine Karte mit dem gleichen Arithmetica-Verbrauch wie die vorherige Karte spielen, ziehen Sie zusätzlich 1 Karte, maximal 3 Mal pro Runde"
  },
  State_67657_Name = {
    Text = "Gnosis-Gerät"
  },
  State_67658_Desc = {
    Text = "Wenn du eine Karte spielst, die tatsächlich 3 Arithmetica kostet, ziehe 1 Karte und erhalte 2 Arithmetica; wenn du eine Karte spielst, die tatsächlich 4 oder mehr Arithmetica kostet, sinken die Arithmetica Kosten anderer Handkarten um 1"
  },
  State_67658_Name = {
    Text = "Zeitpendel·Auge"
  },
  State_67659_Desc = {
    Text = "Zu Beginn jeder Runde erhält man für jeden Gegner 2 Arithmetica. Wenn man einen Gegner mit aktivem Schaden tötet, erleidet ein anderer Gegner doppelten übermäßigen Schaden durch <BleedingIconKeywords:Bluten>"
  },
  State_67659_Name = {
    Text = "Lied der Meute+"
  },
  State_67660_Desc = {
    Text = "Nach jeder 3. Ausspielung von „Schlag“ erleidest du [DescArg1] Schadenspunkte an allen feindlichen Zielen, und der entsprechende Erwecker erhält 15 Punkte Aelius"
  },
  State_67660_Name = {
    Text = "Rostige Lanze"
  },
  State_67661_Desc = {
    Text = "Jedes Mal, wenn Arithmetica erschöpft wird, ziehe 1 Karte, maximal 5 Mal pro Runde. Jedes Mal, wenn das Deck zurückgesetzt wird, erhalte 2 Punkte Arithmetica"
  },
  State_67661_Name = {
    Text = "Zeitpendel·Schlaflosigkeit"
  },
  State_67662_Desc = {
    Text = "Jedes Mal, wenn du eine Nicht-Erwachter-Karte spielst, erhält der Erwachte mit dem wenigsten Wahnsinn 10 Wahnsinn"
  },
  State_67662_Name = {
    Text = "Fremdes Stempelalbum"
  },
  State_67665_Desc = {
    Text = "Max Arithmetica erhöht sich um 2. Nachdem du “Schlag“ oder “VERT“ gespielt hast, erhält der entsprechende Erwecker 5 Punkte Aliemus. Nach der Freigabe der Verherrlichung erhältst du 1 “Schlag“ mit einem Verbrauch von Nichtigkeit für den entsprechenden Erwecker, nach der Freigabe der Posse erhältst du zufällig 1 “VERT“ mit einem Verbrauch von Nichtigkeit."
  },
  State_67665_Name = {
    Text = "Zeitpendel·Flügel"
  },
  State_67666_Desc = {
    Text = "Jedes Mal, wenn du Schaden verursachst, gewinnst du [DescArg1] Punkte temporäre <PowerIconKeywords:Macht>, maximal 3 Mal stapelbar. Wenn die Anzahl der Schichten maximal ist, wird der Effekt verdoppelt"
  },
  State_67666_Name = {
    Text = "Filigraner Achat"
  },
  State_67667_Desc = {
    Text = "Nach dem Ende der Runde erhalten alle Erwecker 5 Wahnsinn. Für jeden verbleibenden Punkt Arithmetica erhalten alle Erwecker zusätzlich 3 Wahnsinn"
  },
  State_67667_Name = {
    Text = "Protobatterie"
  },
  State_67668_Desc = {
    Text = "Der kritische Schaden erhöht sich um 15%. Die kritische Rate für \"Schlag\" erhöht sich um 40%"
  },
  State_67668_Name = {
    Text = "Elfenbeinfarbener Rabenschnabel"
  },
  State_67669_Name = {Text = "Veraltet"},
  State_67670_Desc = {
    Text = "Nach der Freisetzung von Exaltieren ziehe 1 Karte. Wenn die Lebenspunkte unter 25% liegen, ziehe zusätzlich 1 Karte"
  },
  State_67670_Name = {Text = "Wissensrad"},
  State_67671_Desc = {
    Text = "Für jeden verursachten aktiven Schaden regenerierst du [DescArg1] Leben und fügst dem beschädigten Ziel [DescArg2] Schichten <BleedingIconKeywords:Bluten> hinzu"
  },
  State_67671_Name = {
    Text = "Gesegnet: Schwarmintelligenz"
  },
  State_67672_Desc = {
    Text = "Der Effekt von <WeaknessIconKeywords:Schwäche> erhöht sich um 8 %, der Effekt von <VulnerabilityIconKeywords:verwundbar> um 25 %. Beim Anwenden von <WeaknessIconKeywords:Schwäche> oder <VulnerabilityIconKeywords:verwundbar> temporär [DescArg1] Punkte <PowerIconKeywords:Macht> stehlen"
  },
  State_67672_Name = {
    Text = "Verblasste Fotografie+"
  },
  State_67673_Desc = {
    Text = "Zu Beginn der Runde ziehst du 1 Karte"
  },
  State_67673_Name = {
    Text = "Richtiger Nordkompass"
  },
  State_67674_Desc = {
    Text = "Für jede ausgespielte Befehlskarte erhält man [DescArg2]% <DeathResistanceIconKeywords:Todwiderstand> (jeder ausgelöste Todwiderstand in diesem Level halbiert den erhaltenen Todwiderstand). Wenn dein <DeathResistanceIconKeywords:Todwiderstand> 100% oder mehr beträgt, erhältst du stattdessen [DescArg1] Punkte vorübergehende <PowerIconKeywords:Stärke>."
  },
  State_67674_Name = {
    Text = "Schlangenhülle"
  },
  State_67675_Desc = {
    Text = "Am Ende der Runde, gibt es überschüssige Arithmetica, zieht man in der nächsten Runde zusätzlich 2 Karten; wenn übrig gebliebene Handkarten, erhält man in der nächsten Runde zusätzlich 2 Arithmetica"
  },
  State_67675_Name = {
    Text = "Tag und Nacht Rad+"
  },
  State_67677_Desc = {
    Text = "Wenn du <WeaknessIconKeywords:Schwäche> verursachst, erhältst du [DescArg1] Schildpunkte; bei <VulnerabilityIconKeywords:Verwundbarkeit> erhältst du [DescArg2] Punkte temporäre <PowerIconKeywords:Kraft>. Wenn beide Effekte in einer Runde ausgelöst werden, erhältst du zusätzlich [DescArg1] Schildpunkte und [DescArg2] Punkte temporäre <PowerIconKeywords:Kraft>."
  },
  State_67677_Name = {
    Text = "Vergoldeter Rahmen"
  },
  State_67703_Desc = {
    Text = "Zu Rundenbeginn, wenn die Anzahl der verbleibenden Handkarten aus der letzten Runde mehr als 3 ist, erhalten Sie 2 Arithmetica"
  },
  State_67703_Name = {
    Text = "Mythag-Insignien"
  },
  State_67704_Desc = {
    Text = "Nachdem Aelius freigesetzt wurde, erhalten die entsprechenden Erwecker 10 Aelius und [DescArg1] Punkte Schild"
  },
  State_67704_Name = {
    Text = "Schleier der namenlosen Gottheit"
  },
  State_67796_Name = {
    Text = "<TongxiaoKeywords:Allwissenheit>：Nach Ausführung wird zurückgesetzt, erhalte <Energy:[StateArg1]> Aelius Punkte"
  },
  State_67841_WeaponDesc = {
    Text = "Ändere die Arithmetica Kosten der Karte vor dem Spielen"
  },
  State_67844_Desc = {
    Text = "Nach erlittenem tödlichem Schaden alle Leben wiederherstellen, kann @1 Mal ausgelöst werden, derzeit wurde [DescArg1] Mal ausgelöst"
  },
  State_67844_Name = {
    Text = "Urgotisches Chaos"
  },
  State_67866_Name = {
    Text = "<BleedingColour: Bluten>"
  },
  State_68298_Desc = {
    Text = "Nach erlittenem kritischen Schaden wird die Intention in „Tiefraumfokus“ gewandelt und 80 Schichten vorübergehende Verstärkung erhalten, alle Lebenspunkte werden wiederhergestellt, kann [DescArg1]-mal ausgelöst werden. Am Ende der Runde entfernt sich selbst 20 Schichten Verstärkung."
  },
  State_68298_Name = {
    Text = "Sternenstaub"
  },
  State_68554_Desc = {
    Text = "Nach erlittenem kritischen Schaden alle Lebenspunkte wiederherstellen. Der Status wird entfernt, sobald alle anderen Feinde besiegt sind. Kann @1-mal ausgelöst werden, derzeit wurde [DescArg1]-mal ausgelöst."
  },
  State_68554_Name = {
    Text = "Urgotisches Chaosfragment"
  },
  State_68621_Desc = {
    Text = "Zu Kampfbeginn und am Ende jeder Runde werden 2 Stapel temporärer <ResentChainsKeywords:Kette des Grolls> erhalten."
  },
  State_68621_Name = {Text = "Eerie Flow"},
  State_68622_Desc = {
    Text = "Die angewendeten Kraft-Effekte der Erwachten werden um 75 % reduziert. Immer wenn Leben verloren geht, erhält man [DescArg1] Schildpunkte und 1 Schicht temporärer Stabilisierung."
  },
  State_68622_Name = {
    Text = "Fluss des bösen Glaubens"
  },
  State_68623_Desc = {
    Text = "Jedes Mal, wenn eine Befehlskarte ausgespielt wird, eine Karte dieses Erweckers mit dem niedrigsten Arithmetica-Verbrauch abwerfen."
  },
  State_68623_Name = {
    Text = "Wahnsinnige Strömung"
  },
  State_68624_Desc = {
    Text = "Am Ende der Runde werden 10 % des verlorenen Lebens wiederhergestellt, negative Zustände sowie Spieler-positiv Zustände werden entfernt."
  },
  State_68624_Name = {
    Text = "Strom der Ankunft"
  },
  State_68626_Desc = {
    Text = "Der Basis-Aliemus aller Erwecker erhöht sich um +50%. Am Ende jeder Runde werden allen Erweckern 10 Aliemus abgezogen und dafür 3% ihrer Max LP wiederhergestellt."
  },
  State_68626_Name = {
    Text = "Fluss der Angst"
  },
  State_68627_Desc = {
    Text = "Zu Beginn des Kampfes erhältst du 15 Schichten „temporäre Barriere“. Am Ende der Runde erhältst du 15 Schichten „temporäre Barriere“ und 10 zufällige Karten erhalten „temporäre Auflösung“."
  },
  State_68627_Name = {
    Text = "Eisige Strömung"
  },
  State_68632_Desc = {
    Text = "Alle Befehlskarten verbrauchen 1 Arithmetica mehr. Alle 3 Runden wird am Rundenende 1 Karte „Allmähliche Versteinerung“ auf die Hand genommen."
  },
  State_68632_Name = {
    Text = "Wehklagender Strom"
  },
  State_68635_Name = {
    Text = "Reiner Silberkern· Angst"
  },
  State_68637_Desc = {
    Text = "Wenn du Leben verlierst, werden entsprechende Schichten reduziert. Bei 0 Schichten erhält der Spieler 2 temporäre Barrieren. Du erhältst [DescArg1] Schichten Schild und [DescArg2] Schichten temporäre Verstärkung und bekommst [DescArg3] Schichten Dimensionsbarriere zurück."
  },
  State_68637_Name = {
    Text = "Dimensionsbarriere"
  },
  State_68638_Name = {
    Text = "Reiner Silberkern· Häresie"
  },
  State_68646_Desc = {
    Text = "Grundschaden und Schild erhöhen sich um 200 %, nach dem Ausspielen wird es jedoch verbraucht."
  },
  State_68646_Name = {
    Text = "<RedQuality1:Temporäre Auflösung>"
  },
  State_68647_Name = {
    Text = "„Kern des reinen Klangs · Wahnsinn\""
  },
  State_68680_Desc = {
    Text = "Entferne Urweltsplitter"
  },
  State_68680_Name = {
    Text = "Entferne Urweltsplitter"
  },
  State_68704_Desc = {
    Text = "Bis Tohuwabohus wahre Ankunft noch [DescArg1] Runden..."
  },
  State_68704_Name = {Text = "Erscheinen"},
  State_68829_Desc = {
    Text = "Beim Erleiden von Aktivem Schaden oder Tentakelschaden wird Immunität gegen SCH gewährt und 1 Stapel abgezogen. Wird zu Rundenbeginn entfernt."
  },
  State_68829_Name = {
    Text = "<ParcloseColour: Temporäre Barriere>"
  },
  State_68829_WeaponDesc = {
    Text = "Erlittener Schaden –99%. Jedes Mal, wenn Schaden erlitten wird, wird 1 Stapelung verloren."
  },
  State_70026_Desc = {
    Text = "Diese Karte hat die Fähigkeit “Behalten“. Nach dem Ausspielen erhöht sich die temporäre kritische Trefferquote aller Erwachten um [StateArg1]%, und “Unsterbliche Herrschaft“ wird entfernt. Wenn das aktuelle Reich Aequor ist, erhalte 1 Punkt Arithmetica, nachdem “Unsterbliche Herrschaft“ entfernt wurde."
  },
  State_70026_Name = {
    Text = "<OrangeQuality:Unsterbliche Herrschaft>"
  },
  State_70031_Desc = {
    Text = "Team Unique: Zu Beginn des Kampfes erhält jede Befehlskarte des Ausrüsters im Ziehstapel mit Arithmetica-Kosten von 3 oder mehr den Effekt “Unsterbliche Herrschaft“: Diese Karte erhält “Behalten“, und nach dem Ausspielen erhöht sich die temporäre kritische Trefferquote aller Erwecker um <WeaponEffect_Num:[StateArg1]%,> und “Unsterbliche Herrschaft“ wird entfernt. Wenn das aktuelle Reich Aequor ist, erhält man nach der Entfernung von “Unsterbliche Herrschaft“ 1 Punkt Arithmetica."
  },
  State_70031_WeaponDesc = {
    Text = "Zu Beginn des Kampfes erhalten alle Befehlskarten des Ausrüsters im Ziehstapel mit Arithmetica-Kosten von 3 oder mehr den Effekt “Unsterbliche Herrschaft“: Diese Karte erhält “Behalten“; nach dem Ausspielen erhöht sich die temporäre Krit. Rate aller Erwecker um <WeaponEffect_Num:[StateArg1]%> und “Unsterbliche Herrschaft“ wird entfernt. Wenn das aktuelle Reich Aequor ist, erhält man nach der Entfernung von “Unsterbliche Herrschaft“ 1 Punkt Arithmetica."
  },
  State_70182_Desc = {
    Text = "Erhalte [DescArg1]% weniger Schild"
  },
  State_70182_Name = {
    Text = "<FragileColour:Zerbrechlich>"
  },
  State_70182_WeaponDesc = {
    Text = "Erhalte 33% weniger Schild"
  },
  State_70277_Desc = {
    Text = "Beim Erleiden von Aktivem Schaden oder Tentakelschaden werden [StateArg1]% des SCH in den Wiederherstellungsbetrag für den Blutroter Ofen umgewandelt, für [Layer] <plural value=\"[Layer]\" singular=\"Runde\" plural=\"Runden\">."
  },
  State_70277_Name = {
    Text = "Schöpfungsritual"
  },
  State_70287_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Am Rundenende erhöhen sich Schaden, Heilung und Schild aller „Fähigkeiten \" des Ausrüsters in der Hand um [StateArg1] %."
  },
  State_70287_Name = {
    Text = "Thron aus Blauem Stein"
  },
  State_70288_Desc = {
    Text = "Dieser Karten-Schaden, Heilung und Schild erhöhen sich um [DescArg1]%."
  },
  State_70288_Name = {
    Text = "Thron aus Blauem Stein"
  },
  State_70313_Desc = {
    Text = "Im Bosskampf erhält man am Beginn jeder Runde sowie nach der Freisetzung der Wahnsinnsexplosion durch „Schmelze Dorl“ 1 Schicht „<Zhongmowuqiling:Ende>“. „Ende“ kann maximal 10 Schichten aufweisen. Wird die 10. Schicht erreicht, wird 1 Karte „Nihil-Ende“ in die Hand gelegt."
  },
  State_70313_Name = {
    Text = "Weg der Vernichtung"
  },
  State_70318_Desc = {
    Text = "Füge allen Feinden [StateArg1] <plural value=\"[StateArg1]\" singular=\"Runde\" plural=\"Runden\"> <VulnerabilityIconKeywords:Verwundbar> zu, erhalte 1 Runde „Begeisterung \"-Zustand: Team-Schadenamplifikation +[StateArg2] %."
  },
  State_70318_Name = {
    Text = "Begeisterung"
  },
  State_70322_Desc = {
    Text = "Bei 10 Schichten „Ende“ wird 1 Karte „Das Ende der Leere“ in die Hand gelegt."
  },
  State_70322_Name = {Text = "Ende"},
  State_70330_Desc = {
    Text = "Erhalte 1 Runde „Begeisterung \"-Zustand: Schadenamplifikation des Teams um [Arg2] % erhöht."
  },
  State_70330_Name = {
    Text = "Begeisterung"
  },
  State_70346_Desc = {
    Text = "Fügt allen Feinden [StateArg1] Runden <WeaknessIconKeywords:Schwäche> hinzu und verringert in dieser Runde ihre <PowerIconKeywords:Kraft> um [Exhaustion:StateArg3] Punkte."
  },
  State_70346_Name = {Text = "Fluch"},
  State_70347_Desc = {
    Text = "Reduziert in dieser Runde die <PowerIconKeywords:Kraft> aller Feinde um [Exhaustion:StateArg3] Punkte."
  },
  State_70347_Name = {Text = "Fluch"},
  State_70374_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Wenn der Ausrüster in jeder Runde die ersten [StateArg1] Male angegriffen wird, verursacht er beim Angreifer <PVPEmptinessKeywords:Leere>."
  },
  State_70374_Name = {
    Text = "Puppe der Vergessenheit"
  },
  State_70379_Desc = {
    Text = "Verursacht beim Angreifer <PVPEmptinessKeywords:Leere>. Entfernt diesen Zustand nach einem erlittenen Angriff."
  },
  State_70379_Name = {
    Text = "Leere-Konter"
  },
  State_70443_Desc = {
    Text = "Bei 10 Schichten „Ende“ wird 1 Karte „Das Ende der Leere“ in die Hand gelegt."
  },
  State_70443_Name = {Text = "Ende"},
  State_70539_Name = {
    Text = "Seelenfäule"
  },
  State_70589_Desc = {
    Text = "Wenn du zwei Mal hintereinander Karten spielst, die einen niedrigeren Arithmetica-Verbrauch als die vorherige haben, wirst du 40/80 Gift auf alle Gegner anwenden, maximal 5 Mal pro Runde."
  },
  State_70590_Desc = {
    Text = "Nachdem Sie in einer Runde zum ersten Mal direkt Embryo verwendet haben, verursacht der aktive Schaden in dieser Runde Bluten in Höhe von 15/30 % des Schadens."
  },
  State_70593_Desc = {
    Text = "Nachdem du eine nicht abgeleitete Befehlskarte gespielt hast, mische 1 oder 2 vorübergehende Kopien dieser Karte mit um 2 reduziertem Arithmetica-Verbrauch in den Ziehstapel. 3-Runden-Abklingzeit."
  },
  State_70594_Desc = {
    Text = "Am Ende der Runde: Wenn sich in Flutwelle-Haltung befindet, 32/64 Tentakelschaden erhalten. 3 Runden Abkühlzeit."
  },
  State_70595_Desc = {
    Text = "Zu Beginn des Kampfes fügt ihr allen Feinden 1280 Schichten Gift hinzu; im Bosskampf wird der Effekt verdoppelt."
  },
  State_70598_Desc = {
    Text = "Jedes Mal, wenn eine Karte in den Hyperraum gelangt, und falls diese Karte einen anderen Besitzer als die anderen Karten im Hyperraum besitzt, lege 1/2 „Inspiration“ auf deine Hand."
  },
  State_70600_Desc = {
    Text = "Am Ende der Runde werden 32 Lebenspunkte wiederhergestellt."
  },
  State_70600_Name = {
    Text = "Gesegnetes Blut"
  },
  State_70602_Desc = {
    Text = "Nach der Silberschlüsselerweckung 4 Karten ziehen."
  },
  State_70603_Desc = {
    Text = "Nach der Silber-Schlüssel-Awakening erhalten alle Erwecker 10 Wahnsinn."
  },
  State_70605_Desc = {
    Text = "Nach der Silberschlüsselerweckung 32 Punkte Stärke erhalten."
  },
  State_70607_Desc = {
    Text = "Wenn du zwei Mal hintereinander Karten spielst, die einen höheren Arithmetica-Verbrauch als die vorherige haben, erhältst du 24/48 Riposte. Dies kann pro Runde maximal 5 Mal ausgelöst werden."
  },
  State_70609_Desc = {
    Text = "Nach der Silberschlüsselerweckung 96 Schildpunkte erhalten."
  },
  State_70609_Name = {
    Text = "Schmetterlingspräparat"
  },
  State_70611_Desc = {
    Text = "Nach der Silberschlüsselerweckung erhöht sich der Basisschaden aller Erwecker um 25%/50%."
  },
  State_70614_Name = {
    Text = "Laserkiefer+"
  },
  State_70617_Desc = {
    Text = "In jeder Runde erhöht sich der verursachte Schaden bei den ersten fünf Schadensattacken um 15%/30%."
  },
  State_70618_Desc = {
    Text = "Zu Beginn der Runde ziehst du 1 Karte"
  },
  State_70619_Desc = {
    Text = "“Schlag“ verursacht Gift in Höhe von 10 %/20 % des Schadens, maximal 320/640 Schaden pro Runde."
  },
  State_70620_Desc = {
    Text = "Wenn der Feind angreift, erleidet er einmalig festen Schaden in Höhe von 25%/50% des eigenen maximalen Lebenswerts. Dieser Schaden erhält einen Gegenangriffs-Bonus von 100%/200% und kann pro Feind und Runde maximal einmal ausgelöst werden."
  },
  State_70620_Name = {
    Text = "Ritualdolch"
  },
  State_70621_Desc = {
    Text = "Nach der Silberschlüsselerweckung 192 Punkte Schild erhalten."
  },
  State_70621_Name = {
    Text = "Schmetterlingspräparat+"
  },
  State_70623_Desc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwachten 10 Wahnsinn"
  },
  State_70624_Desc = {
    Text = "Nach der Silberschlüsselerweckung erhalten alle Erwecker 20 Wahnsinn."
  },
  State_70628_Desc = {
    Text = "Zu Beginn der Runde ziehst du 2 Karten."
  },
  State_70629_Desc = {
    Text = "Beim ersten Verschlingen pro Runde erhalten andere Erwachte 10/20 Wahnsinn."
  },
  State_70635_Desc = {
    Text = "Nach der Silberschlüsselerweckung 416 Riposte-Punkte erhalten."
  },
  State_70636_Desc = {
    Text = "Beim Verlust von Leben erhältst du 10%/20% der verlorenen Lebensmenge als Purpurnen Ofen-Rückmeldemenge."
  },
  State_70637_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich die Tentakelobergrenze um 1/2. Du erhältst 1/2 Tentakel."
  },
  State_70641_Desc = {
    Text = "Vernichtung erhält 160/320 Schild, 3 Runden Abkühlzeit."
  },
  State_70641_Name = {
    Text = "Überstringuhr"
  },
  State_70643_Desc = {
    Text = "Zu Rundenbeginn erhalten Sie 1 Arithmetica"
  },
  State_70644_Desc = {
    Text = "Nach der Freisetzung von Exaltieren erhältst du 16/32 Punkte temporäre Macht."
  },
  State_70645_Desc = {
    Text = "Zu Rundenbeginn erhalten Sie 2 Arithmetica."
  },
  State_70646_Name = {
    Text = "Verlorenes Opfermesser+"
  },
  State_70647_Desc = {
    Text = "Alle Erwecker erhöhen den Basisschaden um 30%."
  },
  State_70648_Desc = {
    Text = "Zu Beginn des Kampfes fügen Sie allen Feinden 640 Schichten Gift hinzu. Im Bosskampf wird der Effekt verdoppelt."
  },
  State_70656_Desc = {
    Text = "„Schlag“ verursacht zusätzlich Schaden in Höhe von 60 % des ANGs des Erweckungskörpers, halbe Stärke, maximal 3-mal pro Runde auslösbar."
  },
  State_70657_Desc = {
    Text = "Zu Beginn des Kampfes erhält man 32 Stärke."
  },
  State_70660_Desc = {
    Text = "Zu Beginn des Kampfes erhält man 64 Stärke."
  },
  State_70661_Desc = {
    Text = "Nach Rundenende werden 64 Lebenspunkte wiederhergestellt."
  },
  State_70661_Name = {
    Text = "Blut der Gnade+"
  },
  State_70662_Desc = {
    Text = "Nach der Silberschlüsselerweckung erhalten Sie 2 Arithmetica-Punkte."
  },
  State_70664_Desc = {
    Text = "Nach der Silberschlüsselerweckung erhältst du 16 Punkte Stärke."
  },
  State_70666_Desc = {
    Text = "Nach Kampfbeginn erhältst du 100/200 Reichsbeherrschung. Die Basisvergiftung aller Erwachten und die Vergiftung durch Relikte wird um 10%/20% erhöht."
  },
  State_70667_Desc = {
    Text = "Nach der Silberschlüsselerweckung erhältst du 4 Arithmetica."
  },
  State_70670_Desc = {
    Text = "Zu Beginn des Kampfes erhält man 320 Rückstoß, im Bosskampf wird der Effekt verdoppelt."
  },
  State_70671_Desc = {
    Text = "Nach Eintritt in den Hyperraum-Zug löst die erste gespielte nicht abgeleitete Befehlskarte 1/2 Mal zusätzlich aus."
  },
  State_70678_Desc = {
    Text = "Zu Beginn des Kampfes erhält man 640 <RetaliateIconKeywords:Theke>, im Bosskampf wird der Effekt verdoppelt."
  },
  State_70681_Desc = {
    Text = "Alle Erwecker erhöhen den Basisschaden um 60%."
  },
  State_70682_Desc = {
    Text = "Wenn die Anzahl der Handkarten kleiner oder gleich 2 ist, ziehe 1/2 Karte. Maximal 2 Mal pro Runde."
  },
  State_70683_Desc = {
    Text = "Vernichtung verursacht, dass das Erwachte mit dem niedrigsten Wahnsinn 50/100 Wahnsinn erhält, 3 Runden Abkühlzeit."
  },
  State_70684_Desc = {
    Text = "Zu Beginn der Runde erhältst du, wenn das Leben unter 25 % liegt, 72/144 temporäre Stärke."
  },
  State_70685_Desc = {
    Text = "Nach der Silberschlüsselerweckung allen Feinden 416 Schichten Gift zufügen."
  },
  State_70686_Desc = {
    Text = "Nach dem Einsetzen der Verherrlichung erleiden alle Feinde <FixedDamage:Reinen SCH> in Höhe von 15%/30% deiner Max LP und werden mit 10%/20% Gift belegt."
  },
  State_70687_Name = {
    Text = "Überstringuhr+"
  },
  State_70689_Desc = {
    Text = "Nach der Silberschlüsselerweckung allen Feinden 832 Schichten Gift zufügen."
  },
  State_70690_Desc = {
    Text = "Nach dem Beginn des Kampfes erhältst du 100/200 Reichsbeherrschung. Der Basis-Rückstoßschaden aller Erwachten und der Rückstoßschaden durch Relikte wird um 10%/20% erhöht."
  },
  State_70691_Desc = {
    Text = "Jedes Mal, wenn Schaden verursacht wird, erhält man 4/8 temporäre Stärke, maximal 15 Mal pro Runde auslösbar."
  },
  State_70693_Desc = {
    Text = "Die automatisch erhaltene Embryo-Fusion wird um 100%/200% erhöht."
  },
  State_70694_Desc = {
    Text = "Nach der Silberschlüsselerweckung 2 Karten ziehen."
  },
  State_70695_Desc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwachten 5 Wahnsinn."
  },
  State_70696_Desc = {
    Text = "Nach der Silberschlüsselerweckung 208 Riposte-Punkte erhalten."
  },
  State_70698_Desc = {
    Text = "Bei VERT erhält man 200/400 temporären Gegenschlag, maximal 3-mal pro Runde auslösbar."
  },
  State_70804_Name = {Text = "Lebenszeit"},
  State_70805_Desc = {
    Text = "Zu Beginn des Kampfes erhalten alle Feinde 1/2 Schicht Schwäche. Bei Bossen wird der Effekt verdoppelt. Alle Erwecker erhöhen den Basisschaden um 15%/30%."
  },
  State_70806_Name = {
    Text = "Hand des Schutzes+"
  },
  State_70808_Desc = {
    Text = "Verwende die „Stille See“-Haltung, um allen Feinden 64/128 Erschöpfung zuzufügen. Abkühlung: 3 Runden."
  },
  State_70809_Desc = {
    Text = "Zu Beginn der Runde erhältst du 100/200 Schild, wenn das Leben unter 25 % liegt."
  },
  State_70809_Name = {
    Text = "Wächterhand"
  },
  State_70810_Desc = {
    Text = "Verwende die Haltung „Wogen“, um sofort alle Tentakel zu aktivieren und den Feind 1/2 Mal anzugreifen. 3 Runden Abkühlung."
  },
  State_70812_Desc = {
    Text = "Nach Beginn des Kampfes erhalten alle Feinde 1/2 Schicht Verwundbarkeit; bei Bossen wird der Effekt verdoppelt. Alle Erwecker erhöhen den Basisschaden um 15%/30%."
  },
  State_70832_Desc = {
    Text = "Einzigartig im Team: Zu Beginn des Kampfes erhält der Ausrüster <WeaponEffect_Num:[StateArg1]%> Wahnsinn basierend auf seiner Wahnsinnsregeneration. Der Effekt wird wiederholt, sobald der Ausrüster im Kampf zum ersten Mal Exaltation einsetzt."
  },
  State_70832_WeaponDesc = {
    Text = "Beim Kampfbeginn erhält der Ausrüster Wahnsinn in Höhe von <WeaponEffect_Num:[StateArg1]%> seiner Wahnsinnsregeneration (<WeaponEffect_Num:[DescArg1]>). Beim ersten Mal, wenn der Ausrüster im Kampf Exaltation einsetzt, wird dieser Effekt wiederholt."
  },
  State_70835_Desc = {
    Text = "Team Unique: Der durch den Ausrüster verursachte Wahnsinn, das Gift und die Lebensregeneration erhöhen sich um <WeaponEffect_Num:[StateArg1]%. Nach der Freisetzung der Verherrlichung erhält der Ausrüster Wahnsinn in Höhe von <WeaponEffect_Num:[StateArg2]%> seines aktuellen Wutverbrauchs."
  },
  State_70835_WeaponDesc = {
    Text = "Der vom Ausrüster verursachte Aliemus, Gift und die Lebensregeneration erhöhen sich um <WeaponEffect_Num:[StateArg1]%. Nach der Freisetzung der Verherrlichung erhält der Ausrüster Wahnsinn in Höhe von <WeaponEffect_Num:[StateArg2]%> seines aktuellen Wutverbrauchs."
  },
  State_70989_Desc = {
    Text = "Nach 4-maligem Auslösen von Exaltieren in einer Runde erhältst du 3/6 Arithmetica. Abklingzeit: 3 Runden."
  },
  State_71001_Desc = {
    Text = "Wenn du innerhalb einer Runde 4 Befehlskarten unterschiedlicher Erwachten spielst, erhalten alle Erwachten 20/40 Wahnsinn. Abklingzeit: 3 Runden."
  },
  State_71153_Desc = {
    Text = "Zu Beginn der Runde erhält Caecus 15 Aelius. Wenn Caecus Schild erhält, werden 50% der Schildmenge als Leben wiederhergestellt."
  },
  State_71154_Desc = {
    Text = "Zu Rundenbeginn erhält Aigis 15 Wahnsinn. Wenn Aigis Schaden an Feinden mit Verwundbarkeit verursacht, stiehlt sie außerdem 10 Punkte temporäre Macht. Dies ist maximal 5-mal pro Runde wirksam."
  },
  State_71155_Desc = {
    Text = "Zu Rundenbeginn erhält Leigh 15 Wahnsinn. Jedes Mal, wenn sie LP verliert, erhält sie 8 Punkte Stärke, maximal 10 Mal in jedem Kampf stapelbar. Nach 10 Stapelungen werden die Arithmetica-Kosten von “Schmerz und Vergnügen“ auf 1 reduziert, und die Schadensanzahl erhöht sich um 1."
  },
  State_71156_Desc = {
    Text = "Zu Rundenbeginn erhält Agrippa 15 Wahnsinn. Außerdem reduzieren „Ungeduldige Almosen“ den Arithmetica-Verbrauch von Agrippa in dieser Runde um 1. Dieser Effekt kann pro Runde nur einmal wirken."
  },
  State_71157_Desc = {
    Text = "Zu Beginn der Runde erhält Shan 15 Wahnsinn. Zu Beginn des Kampfes erhält jede Befehlskarte von Shan: „Behalten“, „Vorbereitung 1“ und 24 Punkte Schild."
  },
  State_71157_Name = {
    Text = "Dimensionsbild · Sanga"
  },
  State_71158_Desc = {
    Text = "Zu Rundenbeginn erhält Puppe 15 Wahnsinn. Nach Beginn des Kampfes wird der Arithmetica-Verbrauch von Puppes „Äquivalenter Austausch“ auf 0 gesetzt. Nach dem Ausspielen zieht sie in der nächsten Runde zusätzlich 2 Karten."
  },
  State_71159_Desc = {
    Text = "Zu Beginn jeder Runde erhält Faros 15 Wahnsinn. Für jeden verursachten Tentakelschaden erhöht sich das Gift, das Faros in diesem Kampf verursacht, um 1 %, maximal 100 %."
  },
  State_71160_Desc = {
    Text = "Zu Beginn der Runde erhält „24“ 15 Aliemus. Wenn „24“ zu Beginn der Runde in der „deprimierten Persönlichkeit“ ist, erhält er zusätzlich 25 Aliemus. Ist er in der „manischen Persönlichkeit“, erhöht sich die temporäre Krit. Rate und der temporäre Kritische Schaden um 35%."
  },
  State_71161_Desc = {
    Text = "Zu Beginn jeder Runde erhält Ohnmacht 15 Aelius. Bei jedem Auslösen des Todeswiderstands steigen die von Ohnmacht während dieser Erkundung erzeugten Schild-, Gegenangriffs- und Heilungseffekte um 20%. Dieser Effekt kann maximal 5-mal aktiviert werden."
  },
  State_71162_Desc = {
    Text = "Zu Rundenbeginn erhält Goliath 15 Wahnsinn. Falls Goliath innerhalb einer Runde 3 Mal Schaden verursacht, erhält der von ihm verursachte Schaden in diesem Kampf einen zusätzlichen 1-fachen Machtbonus. Abklingzeit: 3 Runden."
  },
  State_71163_Desc = {
    Text = "Zu Rundenbeginn erhält Blutkette-Hilo 15 Wahnsinn. Bei aktivem Schaden von Blutkette · Hilo wird zusätzlich 20 % Blutung hinzugefügt, nach dem Tod eines Feindes verursacht sie bei anderen Feinden Blutung in Höhe des überschüssigen Schadens."
  },
  State_71164_Desc = {
    Text = "Zu Beginn der Runde erhält Aurita 15 Wahnsinn. Die Anzahl der Schadensanwendungen von „Drüsen-Spaltung“ wird um 1 erhöht. Nach dem Ausspielen von Auritas „VERT“ wird 1 Karte „Drüsen-Spaltung“ in die Hand gelegt."
  },
  State_71166_Desc = {
    Text = "Zu Rundenbeginn erhält Lily 15 Wahnsinn. Die maximale Geduldsgrenze von Lily erhöht sich um 100 %. Beim Freisetzen von „Unsterbliche Blume auf dem Schlamm“ oder „Schutzschlag“ werden 8 % der Geduldstufen als Leben wiederhergestellt."
  },
  State_71167_Desc = {
    Text = "Zu Rundenbeginn erhält Lotan 15 Wahnsinn. Nach dem ersten Ausspielen von Lotans „VERT“ in jeder Runde legt ihr 2 zusätzliche Karten mit Kosten und Leere namens „Stolzes Schwert“ in die Hand."
  },
  State_71168_Desc = {
    Text = "Zu Rundenbeginn erhält Pandia 15 Wahnsinn. Zu Rundenbeginn erhält sie 64 Punkte Theke. Für je 4 Punkte nicht-temporäre Theke erhöht sich der Schaden von Pandias Befehlskarten um 1."
  },
  State_71169_Desc = {
    Text = "Zu Rundenbeginn erhält Hilo 15 Wahnsinn. Jedes Mal, wenn eine Karte abgelegt wird, erhält „Hilo“ 5 Wahnsinn."
  },
  State_71170_Desc = {
    Text = "Zu Rundenbeginn erhält Tawil 15 Wahnsinn. Wenn in einer Runde 6 Befehlskarten von Tawil gespielt wurden, lege 1 Karte „Silberschlüssel Dämmerung“ in die Hand. Abklingzeit: 3 Runden."
  },
  State_71171_Desc = {
    Text = "Am Beginn ihres Zuges erhält Miryam 15 Wahnsinn und nimmt 1 “Eucharistie“ auf die Hand."
  },
  State_71172_Desc = {
    Text = "Zu Beginn der Runde erhält Schmelzblüte Dore 15 Wahnsinn. Nachdem Schmelzblüte Dore die Wahnsinnsexplosion ausgelöst hat, erhält jedes andere Erwachte 1 Punkt Wahnsinn für jeweils 20 verbrauchte Wahnsinnspunkte."
  },
  State_71173_Desc = {
    Text = "Zu Beginn der Runde erhält Salvador 15 Aliemus. Jedes Mal, wenn er den Blutroten Ofen ansammelt, erhält er zusätzlich 5 % Stärke. Salvadors “Schlag“ und “Ende des Leidens“ genießen zusätzlich einen 1-fachen Stärke-Bonus."
  },
  State_71175_Desc = {
    Text = "Zu Beginn der Runde erhält Nautila 15 Wahnsinn. Nachdem Nautilas „Wahnsinnsexplosion“ ausgelöst wurde, erhaltet ihr eine Vergeltung in Höhe von 50 % des aktuellen Schildes, maximal 1 Mal pro Runde."
  },
  State_71177_Desc = {
    Text = "Zu Rundenbeginn erhält Liz 15 Wahnsinn. „Tanz der Vernichtung“: Die abgelegten Karten wirken zusätzlich 1 Mal. Abklingzeit: 3 Runden."
  },
  State_71178_Desc = {
    Text = "Zu Beginn der Runde erhält Ramona 15 Wahnsinn. Jede dritte von Ramona ausgespielte Befehlskarte wirkt zusätzlich 1 Mal."
  },
  State_71179_Desc = {
    Text = "Zu Beginn der Runde erhält Yuwachasi 15 Wahnsinn. Der Wahnsinnsverbrauch von Yuwachasi wird um 10 reduziert. Bei jedem Auslösen einer Wahnsinnsexplosion verringert sich der Wahnsinnsverbrauch zusätzlich um 5, und pro Runde können 2 Wahnsinnsexplosionen ausgelöst werden."
  },
  State_71180_Desc = {
    Text = "Zu Rundenbeginn erhält Alva 15 Aliemus. Wenn Alva in der vorherigen Runde 2 Karten “VERT“ gespielt hat, lege 1 Karte “Präzisionshieb“ mit Kosten in die Hand; wenn sie 2 Karten “Schlag“ gespielt hat, lege 1 Karte “Kampfstellung“ mit Kosten in die Hand."
  },
  State_71181_Desc = {
    Text = "Zu Rundenbeginn erhält Sorel 15 Aliemus. Jedes Mal, wenn Sorel Schaden verursacht, erhöht sich die Embryofusion um 10, maximal 10 Mal pro Runde. Nach 10-maliger Aktivierung erhöht sich Sorels Krit. Schaden in diesem Kampf um 20%."
  },
  State_71182_Desc = {
    Text = "Am Beginn des Zuges erhält Hamlyn 15 Wahnsinn. Die Ressourcenkosten der “Seelenouvertüre“ werden um 1 reduziert und die Basisanzahl an Schadensintervallen erhöht sich um 1."
  },
  State_71183_Desc = {
    Text = "Zu Rundenbeginn erhält Thais 15 Wahnsinn. Wenn Thais innerhalb einer Runde 2 Befehlskarten spielt, erhält sie 1 Karte „Heiliger Sohn“ und 72 Punkte temporäre Kraft. Abklingzeit: 3 Runden."
  },
  State_71187_Desc = {
    Text = "Zu Rundenbeginn erhält Celeste 15 Wahnsinn. Bevor die Runde endet, greift für jede Befehlskarte von Celeste auf der Hand ein Tentakel den Feind an und stellt 8 Leben wieder her."
  },
  State_71188_Desc = {
    Text = "Zu Rundenbeginn erhält Murphy 15 Punkte Wahnsinn. Murphys „Schlag“ und „VERT“ können 25 % des „Opfers“ in temporären Tentakelschaden umwandeln, jedoch maximal einmal pro Runde wirksam."
  },
  State_71189_Desc = {
    Text = "Zu Rundenbeginn erhält Nymphaea 15 Aelius. Nach dem Spielen von Nymphaeas “Schlag“ erhöht sich das von “Nymphaea“ in diesem Kampf verursachte Gift um 20 %. Nach dem Spielen von Nymphaeas “VERT“ wird bei allen Feinden 50 % Gift ausgelöst. Dies kann pro Runde maximal einmalig wirksam werden."
  },
  State_71190_Desc = {
    Text = "Zu Beginn der Runde erhält Ogier 15 Wahnsinn. Nach dem ersten Ausspielen von Ogiers „Speer der Durchdringung“ oder „Schlag“ in dieser Runde erhöhen sich die in dieser Runde erzeugten Schutzschilde und die Macht um 50 %."
  },
  State_71191_Desc = {
    Text = "Zu Rundenbeginn erhält Ryker 15 Aliemus. Das Ergebnis des ersten Würfelergebnisses jeder Runde ist immer 6."
  },
  State_71192_Desc = {
    Text = "Zu Beginn der Runde erhält Ring-Ramona 15 Wahnsinn. Beim ersten Auslösen von „Schleife“ pro Runde erhältst du 500 Punkte s-Energie und 1 Stufe Negentropie."
  },
  State_71193_Desc = {
    Text = "Zu Rundenbeginn erhält Tulu 15 Wahnsinn. Tulus Wahnsinnsverbrauch wird um 10 reduziert. Nach der Auslösung von Exaltieren werden sofort 2 temporäre Tentakel erzeugt."
  },
  State_71194_Desc = {
    Text = "Zu Beginn jeder Runde erhält Karen 15 Wahnsinn. Das Ausspielen von “Stille Wache“ gibt doppelt so viel verbrauchtes Arithmetica zurück. Abklingzeit: 3 Runden."
  },
  State_71271_Desc = {
    Text = "Zu Beginn jeder Runde erhält Ohrla 15 Aelius. Zu Beginn des Kampfes erhält sie jeweils 1 Schicht der Metaphern aller Emotionen. Die Effekte der „Metapher“ werden um 50 % verstärkt."
  },
  State_71272_Desc = {
    Text = "Am Beginn des Zuges erhält Jenkins 15 Wahnsinn und Endschaden +5%. Der Basisschaden und der verursachte Schaden von „Braun, ANG!“ steigen um 200%."
  },
  State_71273_Desc = {
    Text = "Zu Rundenbeginn erhält Daphdail 15 Wahnsinn und 1 “Inspiration“-Karte. Jedes Ausspielen von “Heterogene Gezeiten“ erhöht dauerhaft den erlangten Machtgewinn während dieser Erkundung um 25 %, maximal bis zu 300 %."
  },
  State_71274_Desc = {
    Text = "Zu Rundenbeginn erhält Tinktur 15 Punkte Wahnsinn. Wenn Tinkturs Befehlskarte den Sprung auslöst, wird sie in die Hand zurückgenommen. Dies ist pro Runde maximal 3 Mal wirksam."
  },
  State_71275_Desc = {
    Text = "Zu Beginn der Runde erhält Wanda 15 Wahnsinn und 1 Schicht “Traumführer“. Falls die aktuelle Runde eine hyperdimensionale Runde ist, lege zusätzlich je eine temporäre Karte “Wirbelsägenkette“ und “Verlorener Wächter“ auf die Hand."
  },
  State_71276_Desc = {
    Text = "Zu Rundenbeginn erhält Erika 15 Wahnsinn. Wenn Erika innerhalb einer Runde 3 Befehlskarten ausspielt, erhält sie 1 “Inspiration“ und die Stärke- und Wachsamkeitsboni von “Elektromagnetische Explosion“ in diesem Kampf werden um das 1-fache gesteigert."
  },
  State_71277_Desc = {
    Text = "Zu Rundenbeginn erhält Casiah 15 Wahnsinn. Für jede gezogene Karte erhält Casiah 1 Punkt Wahnsinn. Wenn Casiah Wahnsinnsexplosion auslöst, verlieren alle Feinde 32 Punkte Stärke."
  },
  State_71278_Desc = {
    Text = "Am Beginn des Zuges erhält Wenkel 15 Wahnsinn. Jedes Mal, wenn ein anderer Erwachter eine Wahnexplosion auslöst, erhält Wenkel 5 Wahnsinn-Punkte, und die Ressourcenkosten von „Geistige Rekonstruktion“ in seiner Hand werden um 1 reduziert."
  },
  State_71279_Desc = {
    Text = "Team-Schadenamplifikation um [StateArg1]% erhöht, hält [Layer] <plural value=\"[Layer]\" singular=\"Runde\" plural=\"Runden\"> an."
  },
  State_71279_Name = {
    Text = "Begeisterung"
  },
  State_71503_Name = {
    Text = "“Endgültige Form“: Zusätzlich 3 Karten ziehen, 3 Rechenpunkte erhalten, [DescArg1] % <IntoxicationIconKeywords:Vergiftung> bei allen Feinden auslösen, das Wahnsinnsmaximum von “Schmelzen·Puppe“ um 50 Punkte erhöhen, maximal 3-mal"
  },
  State_71581_Name = {
    Text = "Seelenschmiede-Begabung"
  },
  State_71589_Name = {
    Text = "Aktiviere 1 Tentakel, greife den Feind an und heile 8 Punkte wieder auf."
  },
  State_71605_Name = {
    Text = "Erhalte [StateArg1] Schildpunkte"
  },
  State_71650_Desc = {
    Text = "Nach dem Tod wiederbeleben und unterschiedlich viele Doppelgänger beschwören, aber nach der Wiederbelebung werden keine Stärkungen oder Immunitäten gewährt. Kann noch [Layer]-mal wirken."
  },
  State_71650_Name = {
    Text = "Beast of Myriad Dimensions"
  },
  State_71651_Desc = {
    Text = "Jedes Mal, wenn du Leben verlierst, verlierst du [StateArg1] Punkte temporäre Stärke. Kann noch [Layer]-mal wirken, die Anzahl der Wirkungen wird pro Runde zurückgesetzt."
  },
  State_71651_Name = {
    Text = "Hut des Gentlemans"
  },
  State_71707_Desc = {
    Text = "Für jede erlittene Instanz von Aktivem Schaden werden [StateArg1] LP wiederhergestellt, für [Layer] <plural value=\"[Layer]\" singular=\"Runde\" plural=\"Runden\">."
  },
  State_71707_Name = {
    Text = "Caecus: Unterstützung"
  },
  State_71708_Desc = {
    Text = "Am Ende der Runde erhält jeder Erwachte [DescArg1] Wahnsinn für jede Karte in deiner Hand."
  },
  State_71708_Name = {
    Text = "Kassia·Unterstützung"
  },
  State_71709_Desc = {
    Text = "Am Ende der Runde erhältst du 35 Wahnsinn, wirkt [Layer] Runden lang."
  },
  State_71709_Name = {
    Text = "Wenkler·Unterstützung"
  },
  State_71711_Desc = {
    Text = "Schaden des Erweckungskörpers um 25 % erhöht, hält [Layer] Runden an."
  },
  State_71711_Name = {
    Text = "Jenkin: Unterstützung"
  },
  State_71712_Desc = {
    Text = "Beim Verursachen von Aktivem Schaden wird einmal 1 Tentakelangriff ausgelöst, für [Layer] <plural value=\"[Layer]\" singular=\"Runde\" plural=\"Runden\">."
  },
  State_71712_Name = {
    Text = "Oritta·Unterstützung"
  },
  State_71712_WeaponDesc = {
    Text = "Wenn Mondlicht Schaden verursacht, greift [StateArg1] Tentakel das Ziel an"
  },
  State_71713_Desc = {
    Text = "Jedes Mal, wenn du “Verschlingen“ ausführst, ziehst du 2 “Schlag“-Karten und reduziert deren Arithmetica-Kosten um 1 für [Layer] Runden."
  },
  State_71713_Name = {
    Text = "Shiro·Unterstützung"
  },
  State_71740_Desc = {
    Text = "Nach Beginn der nächsten Runde, erhältst du [Layer] Schildpunkte"
  },
  State_71740_Name = {
    Text = "Reya Unterstützungs-Schild"
  },
  State_71741_Desc = {
    Text = "Nach Beginn der nächsten Runde erhältst du einen Schild in Höhe des in dieser Runde verlorenen Lebens, der [Layer] Runden lang wirkt."
  },
  State_71741_Name = {
    Text = "Leigh: Unterstützung"
  },
  State_71741_WeaponDesc = {
    Text = "Nach Beginn der nächsten Runde, erhalte Schild in Höhe des verlorenen Lebens der letzten Runde"
  },
  State_71742_Desc = {
    Text = "Schadensbonus für Schlagkarten um [Layer] %"
  },
  State_71742_Name = {
    Text = "Shiro·Unterstützung"
  },
  State_71742_WeaponDesc = {
    Text = "In dieser Runde „Schlag“-Kartenschaden +[Layer] %"
  },
  State_71837_Desc = {
    Text = "Zu Beginn der nächsten Runde erleidest du Verwundbarkeit."
  },
  State_71837_Name = {
    Text = "Verzögerter ANGswiderstand"
  },
  State_71839_Desc = {
    Text = "Beim Einsatz von „Erwachen“ erhält man [Layer] Punkte Arithmetica. Befindet sich das aktuelle Reich im Zustand „Tiefsee“, werden zusätzlich [Layer] temporäre Tentakel erzeugt."
  },
  State_71839_Name = {
    Text = "Sterne segnen"
  },
  State_71856_Desc = {
    Text = "Jedes Mal, wenn du Leben verlierst, verlierst du [StateArg1] Punkte temporäre Stärke. Kann noch [Layer]-mal wirken, die Anzahl der Wirkungen wird pro Runde zurückgesetzt."
  },
  State_71856_Name = {
    Text = "Hut des Gentlemans"
  },
  State_72016_Name = {
    Text = "Blut und Fleisch Beherrschung"
  },
  State_72018_WeaponDesc = {
    Text = "Jeder erlittene Schaden erhöht den Wahnsinn aller Erwachten um 1 Punkt"
  },
  State_72033_Name = {Text = "Tentakel"},
  State_72036_Name = {
    Text = "Chaotische Berufseinführung"
  },
  State_72079_Name = {
    Text = "Tobende Wellen"
  },
  State_72102_Desc = {
    Text = "Klassisches „Vorabend des Vergessens“-Spielerlebnis."
  },
  State_72102_Name = {
    Text = "Vergessenes Kapitel"
  },
  State_72137_Name = {
    Text = "Rechenleistung voll"
  },
  State_72206_Name = {
    Text = "Forschungsfortschritt “[DescArg1] / 15“"
  },
  State_72208_Name = {
    Text = "Forschungsfortschritt “[DescArg1] / 2“"
  },
  State_72212_Name = {
    Text = "Forschungsfortschritt “[DescArg1] / 10“"
  },
  State_72213_Name = {
    Text = "Forschungsfortschritt “[DescArg1] / 30“"
  },
  State_72220_Name = {
    Text = "Forschungsfortschritt: “[DescArg1] / 5“"
  },
  State_73518_Desc = {
    Text = "Verursachter Schaden wird um 100 % erhöht. Nachdem Leben verloren geht, wird dieser Status entfernt, dafür aber ein Schild von 50 % der maximalen Gesundheit erhalten."
  },
  State_73518_Name = {
    Text = "“Attentäter“"
  },
  State_73520_Desc = {
    Text = "Beim Tod 1 Lebenspunkt behalten und gegen alle Schäden immun sein, die Intention in „Verbindung lösen“ umwandeln."
  },
  State_73520_Name = {
    Text = "“Verketter“"
  },
  State_73533_Desc = {
    Text = "Am Ende des Zuges werden keine Handkarten abgeworfen. Zu Beginn des Kampfes wird das Handkartenlimit des Spielers auf 8 gesetzt."
  },
  State_73533_Name = {Text = "Hive-Sinne"},
  State_73535_Desc = {
    Text = "In der eigenen Runde wird erlittener Schaden um 75 % reduziert. Bei einer Verringerung der Stärke werden nur 50 % der Stärke-Schichten reduziert."
  },
  State_73535_Name = {
    Text = "Selbstschutz"
  },
  State_73566_Desc = {
    Text = "Nachdem eine Nicht-Befehlskarte ausgespielt wurde, erhalte [Power:StateArg1] Punkte<PowerIconKeywords:Kraft> und <Block:[Block:StateArg2]> Punkte Schild."
  },
  State_73566_Name = {
    Text = "“Kommunikator“"
  },
  State_73567_Desc = {
    Text = "Nachdem eine Nicht-Befehlskarte ausgespielt wurde, erhalte [Power:StateArg1] Punkte<PowerIconKeywords:Kraft> und <Block:[Block:StateArg2]> Punkte Schild."
  },
  State_73567_Name = {
    Text = "“Kommunikator“"
  },
  State_73570_Desc = {
    Text = "Nachdem eine Nicht-Befehlskarte ausgespielt wurde, erhalte [Power:StateArg1] Punkte<PowerIconKeywords:Kraft> und <Block:[Block:StateArg2]> Punkte Schild."
  },
  State_73570_Name = {
    Text = "“Kommunikator“"
  },
  State_73573_Desc = {
    Text = "Nachdem eine Nicht-Befehlskarte ausgespielt wurde, erhalte [Power:StateArg1] Punkte<PowerIconKeywords:Kraft> und <Block:[Block:StateArg2]> Punkte Schild."
  },
  State_73573_Name = {
    Text = "“Kommunikator“"
  },
  State_73649_Desc = {
    Text = "Der Schaden des Teams wird um [Layer]% stark erhöht."
  },
  State_73649_Name = {
    Text = "Puppe der Vergessenheit"
  },
  State_73655_Name = {
    Text = "Organische Form Kennzeichen"
  },
  State_73664_Name = {
    Text = "Schmuckstück Organische Form Effekt"
  },
  State_73664_WeaponDesc = {
    Text = "Nach der Nutzung der Wahnsinnsexplosion werden die Schutzschilde und die Heilungskraft des Ausrüstenden in dieser Runde verdoppelt"
  },
  State_74012_Desc = {
    Text = "Verursacht [StateArg1]% des maximalen Lebens aller Feinde als <RealDamage:Festgesetzter Schaden> (Minimum: [DescArg1]). Danach wird die spezielle Fähigkeit von „Schmelzen · Dor“ in „Ende“ geändert."
  },
  State_74012_Name = {
    Text = "Das Ende der Illusion"
  },
  State_74013_Desc = {
    Text = "Verursacht [StateArg1]% der maximalen Lebenspunkte aller Feinde als <RealDamage:Festgesetzter Schaden>, dieser Schaden unterschreitet nicht 500% des eigenen maximalen Lebens. Danach wird die spezielle Fähigkeit von „Schmelzen · Dor“ in „Ende“ geändert."
  },
  State_74013_Name = {
    Text = "Das Ende der Illusion"
  },
  State_74014_Desc = {
    Text = "Verursacht bei allen Feinden [StateArg1]% ihres maximalen Lebens als <RealDamage:Festgesetzter Schaden> (dieser Schaden liegt nicht unter 500% des eigenen maximalen Lebens) und stellt 30% der verlorenen Lebenspunkte wieder her. Danach wird die spezielle Fähigkeit von „Schmelzen · Dor“ in „Ende“ geändert."
  },
  State_74014_Name = {
    Text = "Das Ende der Illusion"
  },
  State_74015_Desc = {
    Text = "Verursacht bei allen Feinden [StateArg1]% ihrer maximalen Lebenspunkte als <RealDamage:Festgesetzter Schaden> (Minimum: [DescArg1]) und stellt <Heal:[Heal:DescArg2]> Lebenspunkte wieder her. Danach wird die spezielle Fähigkeit von „Schmelzen · Dor“ in „Ende“ geändert."
  },
  State_74015_Name = {
    Text = "Das Ende der Illusion"
  },
  State_74019_Desc = {
    Text = "Alle Erwecker erhöhen die Vergiftung, den Konter und den Basisschaden um [Layer]%."
  },
  State_74019_Name = {
    Text = "Wahnsinnseinsteckung"
  },
  State_74142_Desc = {
    Text = "Nach Beginn der Erkundung erhöhen sich Körperkraft, ANG und VERT um [StateArg1]%"
  },
  State_74142_Name = {
    Text = "Seelenschmiede-Begabung"
  },
  State_74219_Name = {
    Text = "Nach dem Ausspielen in die Hand zurückkehren"
  },
  State_74273_Desc = {
    Text = "Beim aktiven Schaden von Blutkette · Helot wird zusätzlich [StateArg1] % Blutung hinzugefügt und hält [Layer] Runden lang an."
  },
  State_74273_Name = {
    Text = "Blutige Fesseln"
  },
  State_74771_Desc = {
    Text = "用于1次Exaltieren释放所需的Wahnsinn值。"
  },
  State_74771_Name = {Text = "Wutlimit"},
  State_74788_Desc = {
    Text = "\n·Paradox vorhanden: Zu Beginn der Erkundung werden 75% des Todeswiderstands in einen Bonus auf die maximalen Lebenspunkte umgewandelt, wobei maximal 300% Todeswiderstand umgewandelt werden können und die maximalen Lebenspunkte um höchstens 10% erhöht werden. Jedes Mal, wenn der Todeswiderstand ausgelöst wird, wird zusätzlich 1 Karte „Silberschlüssel-Glanz\" in die Hand gelegt. \n·Unendliche Wunde: Im Anführer Kampf wird die Menge an Lebenswiederherstellung, die unser Team erhält, um 25% verringert, jedes Mal, wenn sie 100% der maximalen Lebenspunkte erreicht, aber der Gesamttodeswiderstand um 25% erhöht, maximal 3 Mal auslösbar. \n·Prisma-Linse: Zu Beginn der Runde, wenn der Gegenangriff 750% der maximalen Lebenspunkte überschreitet, wird die überschüssige Menge halbiert, und der permanente Gegenangriff kann bis zu 2250% der maximalen Lebenspunkte gestapelt werden; wenn der Feind 1000% der maximalen Lebenspunkte vergiftet, wird die überschüssige Menge halbiert, und die Vergiftung kann bis zu 3000% der maximalen Lebenspunkte gestapelt werden. Jedes 4% der Schadensverstärkungsattribute des Teams erhöht die oben genannten Obergrenzen um 1%. Der durch Gegenangriff erhaltene Schadensbonus der Erwecker wird um 70% verringert, aber der gesamte verursachte Vergiftungsschaden und der Gegenangriff erhöhen sich um 10%. Zu Beginn der Runde des Gegners erhält man für jedes aktivierte Gnosis temporären Gegenangriff in Höhe von 25% des aktuellen permanenten Gegenangriffs und löst bei allen Feinden 25% Vergiftung aus. \n·Schicksalslichtkegel: Die Rundenanzahl, in der gewöhnliche Monster „Blick\" freisetzen, wird auf 6 Runden geändert. Alle Kämpfe haben eine Begrenzung von 15 Runden, aber zu Beginn der 15. Runde wird 1 Karte „Lichtkegelgrenze\" in die Hand gelegt: Erhalte maximales Keyflare und alle Erwecker erhalten maximales Aliemus."
  },
  State_74788_Name = {
    Text = "(Vorübergehend veraltet)"
  },
  State_74791_Desc = {
    Text = "\nArithmetica-Harmonie: Für jede Befehlskarte, die nach der 10. in einem Zug gespielt wird, erhält man 1 „Arithmetica-Harmonie“. Jede Stapelung erhöht die Kartenkosten um 1 Arithmetica, die dann in 100 % der Keyflare-Regeneration des Erweckers umgewandelt wird (stapelbar). Stapelungen werden beim Betreten des Hyperraums zurückgesetzt.\nRechenleistung voll: Beim Spielen einer Karte wird ihr Arithmetica-Kostenreduzierungseffekt in diesem Zug entfernt. Wenn die aktuelle Arithmetica 12 überschreitet, wird jeder überschüssige Punkt in 300 % der durchschnittlichen Keyflare-Regeneration des Teams umgewandelt.\nWutausgleich: Der Effekt des erhöhten Aliemus-% wird halbiert. Jede Verherrlichung erhöht den Basis-Aliemus um 10. Am Zugende erhält man für jeden Erwecker, der keine Verherrlichung durchgeführt hat, 200 % der durchschnittlichen Keyflare-Regeneration des Teams."
  },
  State_74791_Name = {
    Text = "Schlüsselenergie harmonisieren"
  },
  State_74809_Name = {
    Text = "“Endgültige Form“: Zusätzlich 3 Karten ziehen, 3 Rechenpunkte erhalten, [DescArg1] % <IntoxicationIconKeywords:Vergiftung> bei allen Feinden auslösen, das Wahnsinnsmaximum von “Schmelzen·Puppe“ um 50 Punkte erhöhen, maximal 3-mal"
  },
  State_74826_Name = {
    Text = "Verursacht zufällig [DescArg1] <FixedDamage:Reinen SCH> [DescArg2] <plural value=\"[DescArg2]\" singular=\"Mal\" plural=\"Mal\"> (profitiert von 1× <PowerIconKeywords:STR>)"
  },
  State_74827_Name = {
    Text = "In dieser Runde erhöhen alle Erweckten die kritische Trefferchance und den kritischen Schaden um [DescArg1]%"
  },
  State_74828_Name = {
    Text = "Fügt allen Feinden [DescArg1] Schichten Gift zu"
  },
  State_74829_Name = {
    Text = "Verursacht <FixedDamage:Reinen SCH> an allen Feinden in Höhe von [DescArg1]% ihrer fehlenden LP"
  },
  State_74830_Name = {
    Text = "Erhalte [DescArg1] Kraft"
  },
  State_74831_Name = {
    Text = "Alle Erwachten erhalten [DescArg1] Wahnsinn"
  },
  State_74847_Desc = {
    Text = "Einzigartig im Team: Der Grundschaden der ersten Befehlskarte, die der Ausrüster pro Runde einsetzt, erhöht sich um <WeaponEffect_Num:[StateArg1]%>. Wenn er den Hyperraum betritt, erhält der Ausrüster <WeaponEffect_Num:[StateArg2]> Punkte Wahnsinn."
  },
  State_74847_WeaponDesc = {
    Text = "Der Grundschaden der ersten Befehlskarte, die der Ausrüster pro Runde einsetzt, erhöht sich um <WeaponEffect_Num:[StateArg1]%>. Wenn er den <DimensionalSpaceIconKeywords:Hyperraum> betritt, erhält der Ausrüster <WeaponEffect_Num:[StateArg2]> Punkte Wahnsinn."
  },
  State_74879_Name = {
    Text = "Erhalte [DescArg1] Punkte Arithmetica"
  },
  State_74881_Name = {
    Text = "Wähle 1 Erwachten, erhalte [DescArg1] Wahnsinn"
  },
  State_74882_Name = {
    Text = "Erhalte [DescArg1] Punkte Reichsbeherrschung"
  },
  State_74883_Name = {
    Text = "Die nächsten [DescArg1] ausgespielten Befehlskarten erhalten zusätzlich [DescArg2] Punkte Schlüsselenergie."
  },
  State_74884_Name = {
    Text = "Der in dieser Runde verursachte Giftschaden, Konter und Blutung erhöhen sich um [DescArg1]%"
  },
  State_74885_Name = {
    Text = "Alle Erwachten erhalten [DescArg1] Wahnsinn"
  },
  State_74887_Name = {
    Text = "Erhalte [DescArg1] Schildpunkte"
  },
  State_74888_Name = {
    Text = "Erhalte [DescArg1] Punkt Todeswiderstand"
  },
  State_74889_Name = {
    Text = "Erhalte [DescArg1] Schichten Konter"
  },
  State_74890_Name = {
    Text = "Stehle allen Feinden [DescArg1] temporäre Kraft"
  },
  State_74891_Name = {
    Text = "Verursacht zufällig [DescArg1] <FixedDamage:Reinen SCH> [DescArg2] <plural value=\"[DescArg2]\" singular=\"Mal\" plural=\"Mal\"> (profitiert von 1× <PowerIconKeywords:STR>)"
  },
  State_74910_Desc = {
    Text = "Team Unique: Wenn der Ausrüster der Erwecker „Ramona“ ist, wird die beim Abschluss der Stufe erhaltene Synchro-Rate um +<WeaponEffect_Num:[StateArg1]%> erhöht."
  },
  State_74910_WeaponDesc = {
    Text = "Wenn der Ausrüster die Erweckungseinheit „Ramona“ ist, erhöht sich die bei Abschluss des Levels erhaltene Affinität um <WeaponEffect_Num:[StateArg1]%>."
  },
  State_74932_Desc = {
    Text = "Beim Ausspielen von „Schlag“-, „VERT“- oder „Fähigkeit“-Karten werden die entsprechenden Effekte der „Verbotenen Transaktion“ verstärkt."
  },
  State_74932_Name = {Text = "Tabuhandel"},
  State_74947_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Zu Beginn des Zuges wird dem Feind mit <HPAndShieldMin:niedrigstem Leben und Schild> [StateArg1] Stapel Aktionssperre auferlegt. Nachdem der Träger einen Gegner besiegt, wird dieser Effekt sofort einmal ausgelöst."
  },
  State_74947_Name = {
    Text = "Hexenbreitkrempenhut"
  },
  State_74948_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nachdem “Verherrlichung“ ausgelöst wurde, verliert der Gegner mit dem höchsten Aliemus [StateArg1] Aliemus und erhält <PVPEmptinessKeywords:Leere>."
  },
  State_74948_Name = {
    Text = "Hypnotisches Pendel"
  },
  State_76236_Desc = {
    Text = "\nKeyflare-Erwecken: Wenn der Keyflare voll ist, kann zusätzlich „Keyflare-Erwecken\" gewählt werden, um die Erwecken-Karte des bestimmten Erweckers auf die Hand zu legen und ihr für diesen Kampf „Behalten\" zu gewähren. „Keyflare-Erwecken\" kann nur einmal pro Runde ausgelöst werden und hat eine unabhängige Abklingzeit von „Posse\".\nKeyflare-Überlastung: Bei der Verwendung von „Keyflare-Erwecken\" werden für jeden erweckten Erwecker 1000 Keyflare abgezogen, was dazu führen kann, dass der Keyflare negativ wird.\nArchivierungseinkerbung: Für jede Posse, die der Schutzherr besitzt, erhöht sich die Tiefe der „Forschungstiefe von Objekten\" und „Tiefe der Erkenntnisforschung\" um 1%, bis zu 50%. Alle R-Schicksalsrad-Effekte werden so geändert, dass die Chance, dass das Dimensionsbild-Relikt des Ausrüsters erscheint, um 100% erhöht wird."
  },
  State_76236_Name = {
    Text = "Strahlender Silberglanz"
  },
  State_76277_Desc = {
    Text = "Team Unique: Nach Beginn des Anführer Kampfes werden maximal 50 schwarze Siegel verbraucht. Für jeden verbrauchten Punkt schwarzes Siegel erhältst du <WeaponEffect_Num:[StateArg1]%> <DeathResistanceIconKeywords: Todwiderstand>. Im Sternekapitel wird der Effekt geändert zu: “Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76277_WeaponDesc = {
    Text = "Nach Beginn des Anführer Kampfes beträgt der Verbrauch maximal 50 schwarze Siegel. Für jeden verbrauchten Punkt schwarzes Mal erhältst du <WeaponEffect_Num:[StateArg1]%> <DeathResistanceIconKeywords: Todwiderstand>. Im Sternekapitel wird der Effekt geändert in: “Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76278_Desc = {
    Text = "Team Unique: Bei jedem Betreten eines neuen Feldes werden <WeaponEffect_Num:[StateArg1]%> der verlorenen Lebenspunkte wiederhergestellt. Nach der Verwendung des Notfall-Gnosis-Körpers erhöhen sich die kritische Rate und der kritische Schaden aller Erwecker um 100 %. Im Kapitel „Sterne“ wird der Effekt ersetzt durch: „Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76278_WeaponDesc = {
    Text = "Bei jedem Betreten eines neuen Feldes stelle [StateArg1]% des verlorenen Blutes ([DescArg1]) wieder her. Nach der Nutzung des Notfall-Gnosis-Körpers erhöhen sich die kritische Rate und der kritische Schaden aller Erwecker um 100%. Im Kapitel „Sterne“ wird der Effekt ersetzt durch: „Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76279_Desc = {
    Text = "Team Unique: Der Preis für das Erwecken von Erweckern in der Fusionsnarbe wird um <WeaponEffect_Num:[StateArg1]> Punkte schwarzes Mal gesenkt. Der Ausrüster erhält Inhärent für die Gnosis-Erweckung. Im Sternekapitel wird der Effekt geändert in: “Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76279_WeaponDesc = {
    Text = "Der Preis für das Erwecken des Erweckers in der Fusionsnarbe wird um <WeaponEffect_Num:[StateArg1]> Punkte schwarzes Mal gesenkt. Der Gnosis des Ausrüsters erhält Inhärent. Im Sternekapitel wird der Effekt geändert in: “Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76280_Desc = {
    Text = "Team Unique: Die Wiederherstellung am Rastplatz erhöht sich um <WeaponEffect_Num:[StateArg1]%, nach der Auswahl der LP-Wiederherstellung werden 2 “Einblick“ in das Deck gemischt. Im Sternekapitel wird der Effekt wie folgt geändert: “Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76280_WeaponDesc = {
    Text = "Die Heilung am Rastplatz erhöht sich um <WeaponEffect_Num:[StateArg1]%>. Wähle nach der Heilung LP wiederherzustellen, füge 2 „Einblick“ in dein Deck hinzu. Im Kapitel „Sterne“ wird der Effekt geändert in: „Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76281_Desc = {
    Text = "Team Unique: Nach dem Kampf erhält der Erwachte mit dem niedrigsten Aliemus <WeaponEffect_Num:[StateArg1]> Punkte Aliemus. Im Sternekapitel wird der Effekt ersetzt durch: “Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76281_WeaponDesc = {
    Text = "Nach dem Kampf erhält der Erwachte mit dem niedrigsten Wahnsinn <WeaponEffect_Num:[Energy:StateArg1]> Punkte Wahnsinn. Im Kapitel „Sterne“ wird der Effekt ersetzt durch: „Die Wahrscheinlichkeit, dass das Dimensionsabbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76282_Desc = {
    Text = "Team Unique: Fusionsnarben-Aktualisierungsanzahl +1, Aktualisierungspreis reduziert sich um <WeaponEffect_Num:[StateArg1]> Punkte schwarzes Mal. Im Sternekapitel wird der Effekt geändert in: “Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76282_WeaponDesc = {
    Text = "Erneuerung der D-Marke +1, Erneuerungspreis reduziert sich um <WeaponEffect_Num:[StateArg1]> schwarzes Siegel. Im Kapitel „Sterne“ wird der Effekt geändert in: „Die Wahrscheinlichkeit, dass das Dimensionsabbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76283_Desc = {
    Text = "Team Unique: Die Fusionsnarben-Schöpfungsleiste wird auf 3 geändert, wobei eines eine Fluchkreatur ist. Nach dem Kauf einer Fluchkreatur erhältst du <WeaponEffect_Num:[StateArg1]> Punkte schwarzes Mal. Im Sternekapitel wird der Effekt zu: “Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76283_WeaponDesc = {
    Text = "Die Fusionsnarben-Schöpfungsleiste wird auf 3 reduziert, wobei eines eine Fluchkreatur ist. Nach dem Kauf einer Fluchkreatur erhält man <WeaponEffect_Num:[StateArg1]> Punkte schwarzes Mal. Im Sternekapitel wird der Effekt geändert in: “Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76284_Desc = {
    Text = "Team Unique: Nach dem Beginn des Kapitels erhält jeder Erwecker <WeaponEffect_Num:[StateArg1]> Punkte Aliemus. Nach dem Beginn des Anführer Kampfes ziehe 2 Karten. Im Kapitel „Sterne“ wird der Effekt zu: „Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76284_WeaponDesc = {
    Text = "Nachdem das Kapitel begonnen hat, erhalten alle Erwecker <WeaponEffect_Num:[Energy:StateArg1]> Punkte Aliemus. Nach Beginn des Anführer Kampfes ziehe 2 Karten. Im Kapitel „Sterne“ wird der Effekt ersetzt durch: „Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76285_Desc = {
    Text = "Team Unique: Nach Beginn des Kapitels erhältst du <WeaponEffect_Num:[StateArg1]> Punkte Keyflare. Nach Beginn des Anführer Kampfes erhältst du 2 Punkte Arithmetica. Im Sternekapitel wird der Effekt wie folgt geändert: “Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76285_WeaponDesc = {
    Text = "Nachdem das Kapitel begonnen hat, erhältst du <WeaponEffect_Num:[StateArg1]> Punkte Keyflare. Nach Beginn des Anführer Kampfes erhältst du 2 Punkte Arithmetica. Im Kapitel „Sterne“ wird der Effekt zu: „Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76286_Desc = {
    Text = "Einzigartig im Team: Der Rastplatz bietet eine zusätzliche Option: Entferne bis zu 3 Symptome und erhalte <WeaponEffect_Num:[StateArg1]> Punkte schwarzes Mal. Im Kapitel „Sterne“ wird der Effekt geändert in: „Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76286_WeaponDesc = {
    Text = "Der Rastplatz bietet eine zusätzliche Option: Entferne bis zu 3 Symptome und erhalte <WeaponEffect_Num:[StateArg1]> Punkte schwarzes Mal. Im Sternekapitel wird der Effekt geändert in: “Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76287_Desc = {
    Text = "Team Unique: Die Anzahl der wählbaren Gebete nach einem normalen Kampf erhöht sich auf 4. Die Gebete der Ausrüsterkarten haben eine <WeaponEffect_Num:[StateArg1]%> Chance, zu hochwertigen Gebeten aufzusteigen. Im Sternekapitel wird der Effekt geändert in: “Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76287_WeaponDesc = {
    Text = "Die Anzahl der wählbaren Gebete nach dem normalen Kampf erhöht sich auf 4, die Gebete der Ausrüsterkarten haben eine <WeaponEffect_Num:[StateArg1]%> Chance, auf fortgeschrittene Gebete aufzusteigen. Im Sternekapitel wird der Effekt wie folgt geändert: “Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76288_Desc = {
    Text = "Einzigartig im Team: Nach dem Kampf erhältst du <WeaponEffect_Num:[StateArg1]> Punkte s-Energie. Im Kapitel „Sterne“ wird der Effekt wie folgt geändert: „Die Wahrscheinlichkeit, dass das Dimensionsabbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76288_WeaponDesc = {
    Text = "Nach dem Kampf erhältst du <WeaponEffect_Num:[StateArg1]> Punkte s-Energie. Im Kapitel „Sterne“ wird der Effekt wie folgt geändert: „Die Wahrscheinlichkeit, dass das Dimensionsabbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76289_Desc = {
    Text = "Einzigartig im Team: Sichtfeld +1 während der Erkundung, nach vollständiger Kartenansicht erhältst du <WeaponEffect_Num:[StateArg1]> Punkte schwarzes Mal. Zu Beginn des Anführer Kampfes erhalten alle Feinde 1 Runde <WeaknessIconKeywords:Schwäche> und <VulnerabilityIconKeywords:Verwundbarkeit>. Im Kapitel „Sterne“ wird der Effekt zu: „Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76289_WeaponDesc = {
    Text = "Sichtfeld +1 während der Erkundung, nach vollständiger Öffnung der Kartenansicht erhältst du <WeaponEffect_Num:[StateArg1]> Punkte schwarzes Mal. Zu Beginn des Anführer Kampfes erhalten alle Feinde für 1 Runde <WeaknessIconKeywords:Schwäche> und <VulnerabilityIconKeywords:Verwundbarkeit>. Im Sternekapitel wird der Effekt zu: “Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76290_Desc = {
    Text = "Einzigartig im Team: Nach dem Ende eines normalen Kampfes kannst du wählen, das Gebet aufzugeben, wodurch das Lebenslimit um <WeaponEffect_Num:[StateArg1]%> erhöht wird. Dieser Effekt kann maximal 2 Mal ausgelöst werden. Im Kapitel „Sterne“ wird der Effekt geändert zu: „Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76290_WeaponDesc = {
    Text = "Nach dem normalen Kampf kannst du das Gebet freigeben, um das Lebenslimit um <WeaponEffect_Num:[DescArg1]> zu erhöhen. Dieser Effekt kann maximal 2 Mal aktiviert werden. Im Sternekapitel wird der Effekt zu: “Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76291_Desc = {
    Text = "Einzigartig im Team: Nach dem Beginn des Kapitels erhältst du <WeaponEffect_Num:[StateArg1]> Punkte schwarzes Mal. Relikt-Obergrenze +2. Im Sternekapitel wird der Effekt zu: “Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76291_WeaponDesc = {
    Text = "Nachdem das Kapitel begonnen hat, erhältst du <WeaponEffect_Num:[StateArg1]> Punkte schwarzes Siegel. Relikt-Obergrenze +2. Im Kapitel „Sterne“ wird der Effekt zu: „Die Wahrscheinlichkeit, dass das Dimensionsabbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76292_Desc = {
    Text = "Team Unique: An der Verkaufsstelle für Fusionsnarbe dürfen Symptomkarten verkauft werden. Nach dem Verkauf einer Symptomkarte erhältst du <WeaponEffect_Num:[StateArg1]> Punkte schwarzes Mal. Im Sternekapitel wird der Effekt zu: “Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76292_WeaponDesc = {
    Text = "Am Verkaufsstand für Fusionsnarben können Symptomkarten verkauft werden. Nach dem Verkauf einer Symptomkarte erhältst du <WeaponEffect_Num:[StateArg1]> Punkte schwarzes Mal. Im Sternekapitel wird der Effekt geändert in: “Die Wahrscheinlichkeit, dass das Dimensionsbild des Ausrüsters als Relikt erscheint, erhöht sich um 100 %“."
  },
  State_76321_Name = {
    Text = "Prisma-Linse"
  },
  State_76323_Name = {
    Text = "Wutausgleich"
  },
  State_76324_Name = {
    Text = "Arithmetica-Harmonie"
  },
  State_76325_Desc = {
    Text = "Nachdem [DescArg1] Befehlskarten ausgespielt wurden, tritt der Status “Arithmetica-Ausgleich“ ein."
  },
  State_76325_Name = {
    Text = "Arithmetica-Harmonie"
  },
  State_76326_Name = {
    Text = "Paradox vorhanden"
  },
  State_76328_Name = {
    Text = "Schicksalslichtkegel"
  },
  State_76337_Name = {
    Text = "Unendliche Wunde"
  },
  State_76338_Desc = {
    Text = "Spieler erhält [Layer]% weniger Heilung."
  },
  State_76338_Name = {
    Text = "Unendliche Wunde"
  },
  State_76430_Name = {
    Text = "Dimensionsbild · Lily"
  },
  State_76433_Name = {
    Text = "Arithmetica-Harmonie"
  },
  State_76434_Desc = {
    Text = "Jedes Mal, wenn eine Befehlskarte ausgespielt wird, erhält man zusätzlich 100 % der s-Energie aus der Silberschlüsselaufladung des Wachkörpers, sofern zusätzliche Arithmetica durch Arithmetica-Ausgleich verbraucht wurde. Dies ist stapelbar."
  },
  State_76434_Name = {
    Text = "Arithmetica-Harmonie"
  },
  State_76435_Name = {
    Text = "Prisma-Linse"
  },
  State_76528_Name = {
    Text = "Diese Karte wird als “Schlag“ betrachtet."
  },
  State_76529_Desc = {
    Text = "Beim Aufheben wählt man eine Karte eines Erweckers, um die Zugkosten um 1 zu senken, nach dem Ausspielen 1 Karte zu ziehen und diese als „Schlag“ zu betrachten"
  },
  State_76533_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Bei Ausrüstung und am Ende der Runde dem Gegner zufällige [StateArg1] Handkarten mit [StateArg2] Schichten <PVPAcheKeywords:Verborgener Schmerz> verleihen."
  },
  State_76533_Name = {
    Text = "Verschleierte Qual"
  },
  State_76553_Desc = {
    Text = "Die Arithmetica dieser Karte verbraucht [StateArg1] weniger."
  },
  State_76553_Name = {
    Text = "Millionen liebevolle Blicke"
  },
  State_77686_Name = {
    Text = "Cybernetische Form"
  },
  State_77688_Desc = {
    Text = "Zu Beginn der fünften Runde oder wenn der Tod droht, wird man gegen den Tod immun und die Absicht ändert sich zu „Maschinelle Erleuchtung“."
  },
  State_77688_Name = {
    Text = "Fleisch schwach"
  },
  State_77690_Desc = {
    Text = "Wechselt man in die „halb-mechanische Form“, erhält man pro Schicht des „Endes“ zusätzlich 10 % maximales Leben. In der „halb-mechanischen Form“ wird „Schmelzen·Puppe“ mit zunehmender Schichtanzahl von „Ende“ bedrohlichere Fähigkeiten einsetzen."
  },
  State_77690_Name = {Text = "Ende"},
  State_77692_Desc = {
    Text = "Am Ende der Runde 2 ätzende Kreaturen beschwören, maximal 2 gleichzeitig. Wenn eine beschworene ätzende Kreatur stirbt, verliert “Schmelzflut·Dohl“ 5 % ihres maximalen Lebens."
  },
  State_77692_Name = {Text = "Abgrundtor"},
  State_77693_Desc = {
    Text = "Nach ihrem Tod verliert “Schmelzende Dore“ 5 % ihres maximalen Lebens."
  },
  State_77693_Name = {Text = "Schmelzen"},
  State_78102_Desc = {
    Text = "Verursachter Schaden um 15 % reduziert, erlittener Schaden um 30 % erhöht, bis zum Kampfende."
  },
  State_78102_Name = {
    Text = "Übertaktungsparalyse"
  },
  State_78694_Desc = {
    Text = "Beim Kampfbeginn erhältst du [Arg1] Stärke. Zu Beginn jeder Runde erhältst du für je [Arg2] Punkte permanente Stärke [Arg3] Punkte temporäre Stärke, maximal [Arg4] Punkte temporäre Stärke, und am Ende der Runde verlierst du die Hälfte des Schildes, das durch dieses Relikt erhaltene temporäre Stärke gewährt."
  },
  State_78696_Desc = {
    Text = "Nach der Silberschlüsselerweckung [Arg1] “Fähigkeit“-Karten des entsprechenden Erwachten auswählen, diese verbrauchen und [Arg2] zusätzlich verbrauchte Kopien in den Kartenstapel mischen."
  },
  State_78697_Desc = {
    Text = "Zu Beginn der Runde erhältst du [Arg2] Schichten Gift. Für jeden leeren Platz im Hyperraum erhältst du [Arg1] Punkt(e) Stärke."
  },
  State_78698_Desc = {
    Text = "Obergrenze der Rechenleistung -[Arg1]. Erhalte 1 Punkt Rechenleistung für jede gespielte Karte mit einem Rechenleistungsverbrauch von [Arg2] oder mehr. Maximal [Arg3] Mal pro Runde."
  },
  State_78699_Desc = {
    Text = "Nach dem Ziehen von Karten ziehe zusätzlich [Arg1] Karten, aber wähle [Arg2] Handkarten aus und lege sie ab."
  },
  State_78700_Desc = {
    Text = "Alle Erwecker erhöhen den Basisschaden um [Arg1]%. Zusätzlich steigt der Wert bei jeder Neumischung des Kartenstapels um [Arg2]%, wobei jedoch eine Karte “Taumeln“ auf die Hand genommen wird. Die maximale Erhöhung beträgt [Arg3]%."
  },
  State_78701_Desc = {
    Text = "Zu Beginn der Runde, falls mehr als [Arg1] permanente Tentakel vorhanden sind, verliere [Arg2] Tentakel und erhalte stattdessen [Arg3] temporäre Tentakel, andernfalls erhalte [Arg4] temporäre Tentakel."
  },
  State_78702_Desc = {
    Text = "Nach der Silberschlüsselerweckung zusätzlich [Arg1] Punkte Silber-Schlüssel-Energie verbrauchen, um den Arithmetica-Verbrauch der erhaltenen Erleuchtung-des-Wissens-Karte auf 0 zu reduzieren; nach dem Ausspielen erhält der entsprechende Erwachte zusätzlich [Arg2] Punkte Wahnsinn."
  },
  State_78703_Desc = {
    Text = "Zu Beginn des Kampfes verursacht [Arg1] Giftschaden bei allen Feinden. Vor Rundenbeginn werden [Arg2]% des Gifts bei den Feinden entfernt und [Arg3]% der entfernten Menge als Bluten angewandt."
  },
  State_78710_Desc = {
    Text = "Jede gespielte Befehlskarte erhöht den finalen Schaden des entsprechenden Erwachten in dieser Runde um [Arg1]%, führt aber zum Verlust von [Arg2] Punkten Wahnsinn. Der Effekt ist maximal [Arg3]-mal pro Runde auslösbar."
  },
  State_78712_Desc = {
    Text = "Zu Rundenbeginn erhöht sich die Embryofusion um +[Arg1]. Dein Embryo wird am Ende der Runde verworfen."
  },
  State_78713_Desc = {
    Text = "Zu Rundenbeginn erhältst du [Arg1] Punkte Gegenangriff. Nach [Arg2] Auslösungen von Verherrlichung in einer Runde entferne [Arg3]% permanenten Gegenangriff und erhalte [Arg4]% temporären Gegenangriff entsprechend der entfernten Menge, Abklingzeit: [Arg5] Runden."
  },
  State_78781_Desc = {
    Text = "Temporäre Stärke des Ziels senken, um die gleiche Menge temporäre Stärke zu erhalten."
  },
  State_78781_Name = {
    Text = "<TouquKeywords: stehlen>"
  },
  State_79405_Desc = {
    Text = "Nach dem Spielen erhöht sich „Erinnerung an Klarheit“ um 1. Wenn es 10 erreicht, wird es für 1 Runde gesperrt und 3 „Inspiration“ werden erhalten. Zu Beginn der nächsten Runde wird es auf 5 zurückgesetzt."
  },
  State_79405_Name = {
    Text = "Die wahre Vergangenheit"
  },
  State_79406_Desc = {
    Text = "Nach dem Ausspielen wird “Erinnerung an Klarheit“ um 1 reduziert. Wenn es 0 erreicht, wird es 1 Runde lang gesperrt und alle Erwecker erhalten 30 Aelius. Zu Beginn der nächsten Runde wird es auf 5 zurückgesetzt."
  },
  State_79406_Name = {
    Text = "Glamouröse Illusion"
  },
  State_80052_Desc = {Text = "Test"},
  State_80052_Name = {Text = "Test123"},
  State_80052_WeaponDesc = {Text = "Test"},
  State_80161_Desc = {
    Text = "Team Unique: Der Grundschaden des Ausrüsters bei der Verherrlichung erhöht sich um <WeaponEffect_Num:[StateArg1]%>, die Keyflare-Regeneration erhöht sich um <WeaponEffect_Num:[StateArg2]%>. Nach dem Eintritt in die Ultra-Runde erhalten alle Erwecker <WeaponEffect_Num:[StateArg4]> Punkte Aliemus. Nach der Freigabe von“Vernichtung“erhält der Ausrüster <WeaponEffect_Num:[StateArg3]> Punkte Aliemus."
  },
  State_80161_WeaponDesc = {
    Text = "Der Grundschaden der Wut-Exaltation des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>, die Keyflare-Regeneration erhöht sich um <WeaponEffect_Num:[DescArg1]>. Nach dem Betreten der Ultra-Runde erhalten alle Erwecker <WeaponEffect_Num:[StateArg4]> Punkte Aliemus. Nach der Freigabe von “Vernichtung“ erhält der Ausrüster <WeaponEffect_Num:[StateArg3]> Punkte Aliemus."
  },
  State_80174_Desc = {
    Text = "Einzigartig im Team: Die Silberschlüsselaufladung des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>. Nach Beginn des ersten Kampfes werden allen Feinden 1 Schicht Schwäche und Verwundbarkeit hinzugefügt."
  },
  State_80174_WeaponDesc = {
    Text = "Die Silberschlüsselaufladung des Ausrüsters wird um <WeaponEffect_Num:[DescArg1]> erhöht. Nach Beginn des ersten Kampfes erhalten alle Feinde 1 Schicht <WeaknessIconKeywords:Schwäche> und <VulnerabilityIconKeywords:Verwundbarkeit>."
  },
  State_80207_Desc = {
    Text = "Wenn diese Karte nach dem Spielen „Dimensionsgleiter\" auslöst, wird der Folgeeffekt ausgelöst. Arithmetica-Kosten –1, wenn aus dem Hyperraum entnommen."
  },
  State_80207_Name = {
    Text = "<WormholeKeywords:Quasar>"
  },
  State_80328_Desc = {
    Text = "Ihre Emotionen, ihre Erkenntnis und alles andere ist für immer mit dem Kollektivwillen verbunden. Maximal 15 Schichten. „Empathie“ kann durch Clemantines Wahnsinnsausbruch „Lebensrekonstruktionsheilung“ in einen Nachteil verwandelt werden."
  },
  State_80328_Name = {Text = "Symbiose"},
  State_80331_Desc = {
    Text = "Unter der Erosion des Schwarms sind deine Schwächen vollständig entblößt. Der in dieser Runde erlittene Aktive Schaden und Tentakelschaden wird um [DescArg1]% erhöht."
  },
  State_80331_Name = {
    Text = "<D13Colour:Geistige Verletzung>"
  },
  State_80332_Desc = {
    Text = "Ihre Emotionen, ihre Erkenntnis und alles andere ist für immer mit dem Kollektivwillen verbunden, maximal 10 Schichten. „Empathie“ kann durch Clemantines Wahnsinnsausbruch „Lebensrekonstruktions-Heilung“ in einen Nachteil verwandelt werden."
  },
  State_80332_Name = {Text = "Symbiose"},
  State_80335_Desc = {
    Text = "Unter der Erosion des Schwarms sind deine Schwächen vollständig entblößt. Der in dieser Runde erlittene Aktive Schaden und Tentakelschaden wird um [DescArg1]% erhöht."
  },
  State_80335_Name = {
    Text = "<D13Colour:Geistige Verletzung>"
  },
  State_80336_Desc = {
    Text = "Unter der Erosion des Schwarms liegen deine Ängste bloß. Der in dieser Runde verursachte Aktive Schaden und Tentakelschaden wird um [DescArg1]% reduziert."
  },
  State_80336_Name = {
    Text = "<D13Colour:Phobische Fixierung>"
  },
  State_80338_Desc = {
    Text = "Unter der Erosion des Schwarms liegen deine Ängste bloß. Der in dieser Runde verursachte Aktive Schaden und Tentakelschaden wird um [DescArg1]% reduziert."
  },
  State_80338_Name = {
    Text = "<D13Colour:Phobische Fixierung>"
  },
  State_80575_Desc = {
    Text = "Nachdem aktiver Schaden oder Tentakelschaden erlitten wurde, wird eine gleichwertige Menge an „Alte Glut“ entfernt und 300 % des entfernten Werts an Gesundheit verloren. Bei anderen Schadensarten wird nur die Hälfte entfernt. Die Stapel von „Alte Glut“ werden pro Runde zurückgesetzt."
  },
  State_80575_Name = {Text = "Alte Glut"},
  State_80644_Name = {
    Text = "Zustand@Licht der Transzendenz"
  },
  State_80773_Desc = {
    Text = "Erlittener STR-▼-Effekt –50%. Während der eigenen Runde: erlittener Nicht-Aktiver Schaden und Tentakelschaden +100%."
  },
  State_80773_Name = {
    Text = "Extradimensionales Antikörper"
  },
  State_80774_Desc = {
    Text = "Nachdem aktiver Schaden oder Tentakelschaden erlitten wurde, wird eine gleichwertige Menge an “Alte Glut“ entfernt und 300 % des entfernten Werts an LP verloren. Bei anderen Schadensarten wird nur die Hälfte entfernt. Die Stapel von “Alte Glut“ werden pro Runde zurückgesetzt. Nach vollständiger Entfernung von “Alte Glut“ erhält man 50 Schichten “Festung“."
  },
  State_80774_Name = {Text = "Alte Glut"},
  State_80777_Desc = {
    Text = "Zu Beginn des Kampfes wird die kritische Trefferquote aller Erwecker um 10 % reduziert. Nach dem Tod erhält ein anderer Verbündeter [DescArg1] Stärkepunkte und [DescArg2] Schichten „Alte Glut“."
  },
  State_80777_Name = {
    Text = "Hive Empathy: Legacy"
  },
  State_80778_Desc = {
    Text = "Nach dem Tod erhalten andere Verbündete 1 Stapel „Temporärer Wahnsinn\"."
  },
  State_80778_Name = {
    Text = "Hive Empathie: Fusion"
  },
  State_80782_Desc = {
    Text = "In diesem Kampf wird die kritische Trefferchance aller Erwecker um [Layer] % reduziert."
  },
  State_80782_Name = {
    Text = "Kritische Trefferquote verringert"
  },
  State_80783_Desc = {
    Text = "Um Zugende 1 Stapel „Wahnsinn\" erhalten."
  },
  State_80783_Name = {
    Text = "Artgenossenband"
  },
  State_80784_Desc = {
    Text = "Wenn das Leben unter 50 % fällt, wird ein „Erstwandler“ hinter dir beschworen. Dieser Effekt kann pro Kampf nur einmal ausgelöst werden."
  },
  State_80784_Name = {
    Text = "Hive Empathy: Spaltung"
  },
  State_80785_Desc = {
    Text = "Stärke reduziert wirkt auf diesen Feind nur zu 50%. Jedes Mal, wenn du Verherrlichung einsetzt, erhalte 1 Stapel „Temporärer Wahnsinn\"."
  },
  State_80785_Name = {
    Text = "Hive Empathy: Dimension"
  },
  State_80788_Desc = {
    Text = "Stärke reduziert wirkt auf diesen Feind nur zu 25%. Jedes Mal, wenn du Verherrlichung einsetzt, erhalte 1 Stapel „Temporärer Wahnsinn\"."
  },
  State_80788_Name = {
    Text = "Hive Empathy: Dimension"
  },
  State_80789_Desc = {
    Text = "Erlittener Aktiver Schaden und Tentakelschaden +100%, hält 1 Runde an."
  },
  State_80789_Name = {
    Text = "Ruhezustand"
  },
  State_80790_Desc = {
    Text = "Nach der Verwandlung wird jede Schicht der Leere und des Geistes sie perfekt machen..."
  },
  State_80790_Name = {
    Text = "Kosmisches Äther"
  },
  State_80792_Desc = {
    Text = "Immer wenn du eine Verherrlichung einsetzt, erhalte 1 Stapel „Temporärer Wahnsinn\"."
  },
  State_80792_Name = {
    Text = "Hive Empathy: Dimension"
  },
  State_80794_Desc = {
    Text = "Karte kann nicht ausgespielt werden und bleibt am Ende der Runde weiterhin auf der Hand."
  },
  State_80794_Name = {
    Text = "<Boundkeywords:Binden>"
  },
  State_80807_Desc = {
    Text = "Zu Beginn der fünften Runde oder im Nahen des Todes entferne alle anderen Feinde und wechsel die Absicht zu „Augenblick der Verwandlung“."
  },
  State_80807_Name = {
    Text = "Metamorphose-Moment"
  },
  State_80809_Desc = {
    Text = "Am Ende der Runde werden Karten mit „Nichtigkeit“ in der Hand abgeworfen."
  },
  State_80809_Name = {
    Text = "<PVPVoidKeyColour:Nichtigkeit>"
  },
  State_80810_Desc = {
    Text = "Nachdem aktiver Schaden oder Tentakelschaden erlitten wurde, wird eine gleichwertige Menge an „Alte Glut“ entfernt und 300 % des entfernten Werts an Gesundheit verloren. Bei anderen Schadensarten wird nur die Hälfte entfernt. Die Stapel von „Alte Glut“ werden pro Runde zurückgesetzt."
  },
  State_80810_Name = {Text = "Alte Glut"},
  State_80827_Desc = {
    Text = "Jedes Mal, wenn insgesamt 15 Karten gespielt wurden, ersetze die aktuelle Intention durch „Wundenhieb“ (derzeit verbleiben [Layer] Karten)."
  },
  State_80827_Name = {
    Text = "Wütende Strafe"
  },
  State_81022_WeaponDesc = {
    Text = "Jeder erlittene Schaden erhöht den Wahnsinn aller Erwachten um 1 Punkt"
  },
  State_81027_Desc = {
    Text = "Diese Karte gehört zum „Zerg\", hat -1 Arithmetica-Kosten und wird beim Ausspielen „verbraucht\"."
  },
  State_81027_Name = {
    Text = "Lebensritual"
  },
  State_81054_Desc = {
    Text = "Unter dem Einfluss des Schwarms werden deine Ängste offenbart. Pro Stapelung wird der in diesem Zug ausgeteilte Aktive Schaden und Tentakelschaden um –3% reduziert, bis zu maximal 15 Stapelungen."
  },
  State_81054_Name = {
    Text = "<D13AFKeyWordQ1:Phobische Fixierung>"
  },
  State_81055_Desc = {
    Text = "Unter dem Einfluss des Schwarms werden deine Ängste offenbart. Pro Stapelung wird der in diesem Zug erlittene Aktive Schaden und Tentakelschaden um +3% erhöht, bis zu maximal 10 Stapelungen."
  },
  State_81055_Name = {
    Text = "<D13AFKeyWord2:Seelische Verletzung>"
  },
  State_81056_Desc = {
    Text = "Unter dem Einfluss des Schwarms werden deine Ängste offenbart. Pro Stapelung wird der in diesem Zug erlittene Aktive Schaden und Tentakelschaden um +3% erhöht, bis zu maximal 15 Stapelungen."
  },
  State_81056_Name = {
    Text = "<D13AFKeyWordQ2:Geistige Verletzung>"
  },
  State_81057_Desc = {
    Text = "Unter dem Einfluss des Schwarms werden deine Ängste offenbart. Pro Stapelung wird der in diesem Zug ausgeteilte Aktive Schaden und Tentakelschaden um –3% reduziert, bis zu maximal 10 Stapelungen."
  },
  State_81057_Name = {
    Text = "<D13AFKeyWord1:Phobische Fixierung>"
  },
  State_81058_Desc = {
    Text = "Ihre Emotionen, ihre Erkenntnis und alles andere ist für immer mit dem Kollektivwillen verbunden. „Empathie“ kann durch Clemantines Wahnsinnsausbruch „Lebensrekonstruktions-Heilung“ in einen Nachteil verwandelt werden, maximal 15 Schichten."
  },
  State_81058_Name = {
    Text = "<AnalysisKeywords3:Resonanz>"
  },
  State_81059_Desc = {
    Text = "Ihre Emotionen, ihre Erkenntnis und alles andere ist für immer mit dem Kollektivwillen verbunden. „Empathie“ kann durch Clemantines Wahnsinnsausbruch „Lebensrekonstruktions-Heilung“ in einen Nachteil verwandelt werden, maximal 10 Schichten."
  },
  State_81059_Name = {
    Text = "<AnalysisKeywords0:Resonanz>"
  },
  State_81073_Desc = {
    Text = "Nach erlittenem tödlichen Schaden sofort alle Lebenspunkte wiederherstellen und 80 % vorübergehende Verstärkung erhalten, einen „Erstwandler“ hinter sich beschwören, kann 2-mal ausgelöst werden."
  },
  State_81073_Name = {
    Text = "Hive Empathy: Spaltung"
  },
  State_81278_Desc = {
    Text = "Nach der ersten Freisetzung des Schlüsselbefehls jeder Runde erhalten alle Erwecker 10 Aelius, die Freisetzung des Schlüsselbefehls erhöht jedoch den Verbrauch dauerhaft um 10 %"
  },
  State_81278_Name = {
    Text = "Silberschlüssel-Inhibierung"
  },
  State_81312_Desc = {
    Text = "Nach erlittenem kritischen Schaden alle Lebenspunkte wiederherstellen und 50 Schichten vorübergehende Verstärkung erhalten. Kann [Layer]-mal ausgelöst werden."
  },
  State_81312_Name = {
    Text = "Kosmische Wiedergeburt"
  },
  State_81331_Desc = {
    Text = "Zu Beginn der Runde einen Erwachten wählen und alle seine Karten sowie seinen Wahnsinnsausbruch für 3 Runden versiegeln."
  },
  State_81331_Name = {
    Text = "Gedankengefängnis"
  },
  State_81340_Desc = {
    Text = "Diese Karte ist versiegelt und kann nicht ausgespielt werden. Die Versiegelung wird nach [Layer] Runden aufgehoben."
  },
  State_81340_Name = {
    Text = "<Seal1:Kartenversiegelung>"
  },
  State_81341_Desc = {
    Text = "Dieser Wandler kann seinen Wahnsinnsausbruch nicht verwenden, da er versiegelt ist. Die Versiegelung wird nach [Layer] Runden aufgehoben."
  },
  State_81341_Name = {
    Text = "<Seal1:Wutversiegelung>"
  },
  State_81354_Desc = {
    Text = "Nach dem Ausspielen erleidet man [DescArg1] Schaden. Wird sie nicht ausgespielt, wird sie am Rundenende verbraucht."
  },
  State_81354_Name = {
    Text = "<BurningKeywords:brennen>"
  },
  State_81356_Desc = {
    Text = "Setzt die Karte in Brand. Nach dem Ausspielen [DescArg1] Schaden erleiden. Wenn sie am Ende der Runde noch in der Hand ist, wird sie verbraucht."
  },
  State_81356_Name = {
    Text = "<BurningKeywords:brennen>"
  },
  State_81356_WeaponDesc = {
    Text = "Jede Schicht Verzögerung erhöht die Arithmetica-Kosten der Karte um 1 Punkt"
  },
  State_83587_Desc = {
    Text = "Kann den Effekt beim Auswählen von „Aufbruch in die Wellen“ verstärken. Begrenzung auf 10 Schichten."
  },
  State_83587_Name = {
    Text = "“Setze Segel“"
  },
  State_83589_Desc = {
    Text = "Kann den Effekt beim Auswählen von „Ufer erreicht, kurz pausieren“ verstärken. Begrenzung auf 10 Schichten."
  },
  State_83589_Name = {
    Text = "“Anker werfen“"
  },
  State_83593_Desc = {
    Text = "In dieser Runde verursachter Endschaden aller Erweckten erhöht sich um [Value]%"
  },
  State_83593_Name = {
    Text = "Gesamtschaden"
  },
  State_83596_Desc = {
    Text = "Maximale Handgröße +1. Zu Beginn des Zuges, falls das Deck keine “Dilemma des Navigators“ enthält, lege sie in die Hand. Jedes Mal, wenn der Anführer 10% Max LP verliert, erhalte 1 Schicht “Setze Segel“; jedes Mal, wenn du 10% Max LP verlierst, erhalte 1 Schicht “Anker werfen“."
  },
  State_83596_Name = {
    Text = "Erasmus' Führung - “Segel setzen“"
  },
  State_83607_Desc = {
    Text = "Boss sammelt 10% Lebensverlust-Markierung"
  },
  State_83607_Name = {
    Text = "Status@Der Boss sammelt eine 10%-Lebensverlustmarkierung"
  },
  State_83609_Desc = {
    Text = "Spieler sammelt eine 10%-Lebensverlustmarkierung"
  },
  State_83609_Name = {
    Text = "Status@Spieler erhält eine Markierung für 10% Lebensverlust"
  },
  State_83614_Desc = {
    Text = "Spieler hat 10% Lebenspunkte"
  },
  State_83614_Name = {
    Text = "Status@Spieler: 10% Lebenspunkte"
  },
  State_83615_Desc = {
    Text = "Verliere [Layer] Lebenspunkte, um 1 Schicht “Segel setzen“ zu erhalten."
  },
  State_83615_Name = {
    Text = "“Set Sail“ Fortschritt"
  },
  State_83616_Desc = {
    Text = "Verliere [Layer] Lebenspunkte, um 1 Schicht “Anker“ zu erhalten."
  },
  State_83616_Name = {
    Text = "“Moored Off“ Fortschritt"
  },
  State_83617_Desc = {
    Text = "Anführer mit 10% Lebenspunkten"
  },
  State_83617_Name = {
    Text = "Status@Boss 10% Lebenspunkte"
  },
  State_83618_Desc = {
    Text = "Testweise liegt die aktuelle Lebenspunktzahl bei [Layer] Punkten."
  },
  State_83618_Name = {
    Text = "Feindliches aktuelles Leben"
  },
  State_83619_Desc = {
    Text = "Testweise beträgt das maximale Leben [Layer] Punkte."
  },
  State_83619_Name = {
    Text = "Feindliche maximale Lebenanzahl"
  },
  State_83620_Desc = {
    Text = "Der aktuelle Wert von Parameter 4 multipliziert mit 100 ergibt [Layer] Punkte."
  },
  State_83620_Name = {
    Text = "Parameterdruck"
  },
  State_83621_Desc = {
    Text = "Zwischenwert der 10%-Lebensverlustzählung des Bosses"
  },
  State_83621_Name = {
    Text = "Status@Boss 10% Lebensverlust-Zähler Zwischenwert"
  },
  State_83622_Desc = {
    Text = "Spieler: Mittelwert der 10%-Lebensverlustzählung"
  },
  State_83622_Name = {
    Text = "Status@Spieler: 10% Lebensverlust-Zähler Zwischenwert"
  },
  State_83627_Desc = {
    Text = "Verliere [DescArg1] Lebenspunkte, um 1 Schicht “Segel setzen“ zu erhalten"
  },
  State_83627_Name = {
    Text = "“Set Sail“ Fortschritt"
  },
  State_83805_Name = {Text = "Nachbeben"},
  State_83807_Name = {
    Text = "Versunken im Tiefgründigen"
  },
  State_83808_Desc = {
    Text = "Wenn diese Karte abgelegt wird, wird der Effekt „Nachklang“ ausgelöst."
  },
  State_83808_Name = {
    Text = "<RippleKeywords:Nachbeben>"
  },
  State_83811_Desc = {
    Text = "Erhalte zusätzlich [Layer]% Tentakelschaden."
  },
  State_83812_Desc = {
    Text = "Erhalte zusätzlich [Layer]% Tentakelschaden."
  },
  State_83814_Desc = {
    Text = "Anführer mit 10% Lebenspunkten"
  },
  State_83814_Name = {
    Text = "Anführer: 10% Lebenswert"
  },
  State_84140_Desc = {
    Text = "In diesem Kampf wurden [Layer] Karten “Drüsenaufspaltung“ durch “Lärmendes Meer“ verbraucht."
  },
  State_84140_Name = {
    Text = "Tosender Ozean"
  },
  State_84184_Name = {
    Text = "Diese Fähigkeit erhält einen zusätzlichen [Layer]%igen Stärkebonus"
  },
  State_84255_Desc = {
    Text = "Einzigartig für das Team: Beim Kampfbeginn erhält der Träger einen Schild in Höhe von <WeaponEffect_Num:[StateArg1]%> seiner VERT. Nachdem der Todeswiderstand ausgelöst wurde, tritt dieser Effekt zu Beginn der nächsten Runde erneut ein."
  },
  State_84255_Name = {
    Text = "Seenavigator"
  },
  State_84255_WeaponDesc = {
    Text = "Beim Kampfbeginn <WeaponEffect_Num:[Block:DescArg1]> Schildpunkte erhalten. Nach Auslösen des Todeswiderstands wird dieser Effekt zu Beginn der nächsten Runde erneut ausgelöst."
  },
  State_84257_Desc = {
    Text = "Team Unique: Der durch die Verherrlichung des Ausrüsters verursachte Schild erhöht sich um <WeaponEffect_Num:[StateArg1]%>, nach der Freisetzung der Verherrlichung erhöht sich der temporäre kritische Schaden aller Erwecker um <WeaponEffect_Num:[StateArg2]%, wobei jede zusätzliche Tentakel um 1% erhöht. Nach der erstmaligen Auslösung des Todeswiderstands während der Erkundung wird zu Beginn der nächsten Runde <WeaponEffect_Num:[StateArg3]%> des maximalen Lebens wiederhergestellt."
  },
  State_84257_WeaponDesc = {
    Text = "Der durch die Wut-Explosion des Ausrüsters verursachte Schutzschild erhöht sich um <WeaponEffect_Num:[StateArg1]%>, nach der Freisetzung der Wut-Explosion erhöht sich der temporäre kritische Schaden aller Erwecker um <WeaponEffect_Num:[StateArg2]%, wobei jede Tentakel zusätzlich um 1% erhöht wird. Nach dem ersten Auslösen des Todeswiderstands in jeder Erkundung regeneriert sich zu Beginn der nächsten Runde <WeaponEffect_Num:[StateArg3]%> der maximalen Gesundheit."
  },
  State_84272_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Am Ende der Runde wird dem Verbündeten mit dem meisten verlorenen Leben <Heal:[Heal:StateArg1]> Leben wiederhergestellt."
  },
  State_84272_Name = {
    Text = "Seenavigator"
  },
  State_84273_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Bei der Ausrüstung und zu Beginn der Runde erhält man [StateArg1] Schichten <PVPProtectiveKeywords:Barriere>, wenn man keine <PVPProtectiveKeywords:Barriere> hat, andernfalls <Energy:[Energy:StateArg2]> Wahnsinn."
  },
  State_84273_Name = {
    Text = "Flammengebundener Navigator"
  },
  State_84364_Desc = {
    Text = "Kritischer Schaden +[Layer]%"
  },
  State_84364_Name = {
    Text = "Krit. Schaden"
  },
  State_84368_Desc = {
    Text = "Noch [Layer] Runden Abkühlung."
  },
  State_84368_Name = {
    Text = "Versunken im Tiefgründigen"
  },
  State_84375_Desc = {
    Text = "Zu Beginn der Runde erhältst du [Layer] Schildpunkte."
  },
  State_84375_Name = {
    Text = "Seenavigator"
  },
  State_84376_Desc = {
    Text = "Zu Beginn der Runde erhältst du [Layer] Heilung."
  },
  State_84376_Name = {
    Text = "Flammengebundener Navigator"
  },
  State_84399_Desc = {
    Text = "Am Ende jeder Runde erhöht sich der erlittene Schaden um 5 %, und der Charakter erhält 2 Schichten Barriere."
  },
  State_84399_Name = {
    Text = "Versunken im Tiefgründigen"
  },
  State_84400_Desc = {
    Text = "Nach Beginn der nächsten Runde wird jede Schicht <PVPProtectiveKeywords:Barriere> in 1 Schicht <ReinforcePVEKeywords:verstärkt> umgewandelt."
  },
  State_84400_Name = {
    Text = "“Navigation“"
  },
  State_84402_Desc = {
    Text = "Erhöht den erlittenen Schaden um [Layer]%."
  },
  State_84402_Name = {
    Text = "Überziehungsstärke"
  },
  State_89340_Desc = {
    Text = "Erhalte zusätzlich [Layer]% Tentakelschaden."
  },
  State_89340_Name = {
    Text = "Tentakel Verwundbarkeit"
  },
  State_89422_Desc = {
    Text = "Alle Erwachten erzeugen 100 % mehr Wahnsinn und können pro Runde zweimal die Wahnexplosion auslösen."
  },
  State_89422_Name = {
    Text = "“Unnachgiebiges Herz“"
  },
  State_89447_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Maximale Handgröße +[StateArg2]. Nach „Verherrlichung„ erhältst du [StateArg1] Arithmetica."
  },
  State_89447_Name = {
    Text = "Unerträgliche Freiheit"
  },
  State_89448_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Am Ende des Zuges erhält der Verbündete mit den niedrigsten Lebenspunkten und Schild [StateArg1] <PVPDerivativeCardKeywords_16:\"Onyx-Feder\">."
  },
  State_89448_Name = {
    Text = "Einsame Feder"
  },
  State_89554_Name = {
    Text = "Schicksalslichtkegel"
  },
  State_89555_Desc = {
    Text = "Team Unique: Nachdem der Ausrüster Verherrlichung einsetzt, erhöht sich der Verherrlichungs-Grundschaden um +<WeaponEffect_Num:[StateArg1]%>, Rollen-Schild und LP-Wiederherstellung +<WeaponEffect_Num:[StateArg2]%>, bis zu 5 Mal stapelbar. Während der Erkundung wird die vom Ausrüster erhaltene Synchro-Rate um +<WeaponEffect_Num:[StateArg3]%> erhöht."
  },
  State_89555_WeaponDesc = {
    Text = "Nachdem der Ausrüster die Verherrlichung freigibt, erhöht sich der Grundschaden der Verherrlichung um <WeaponEffect_Num:[StateArg1]%>, während der Schild und die Lebensregeneration um <WeaponEffect_Num:[StateArg2]%> erhöht werden, maximal 5 Mal stapelbar. Nach Abschluss der Erkundung erhöht sich die Synchronisationsrate des Ausrüsters um <WeaponEffect_Num:[StateArg3]%>."
  },
  State_89557_Name = {
    Text = "Prisma-Linse"
  },
  State_89559_Desc = {
    Text = "\\n·Existenzparadoxon: Zu Beginn der Erkundung werden 75 % des Todeswiderstands in einen Bonus auf die maximalen Lebenspunkte umgewandelt, bis zu 300 % Todeswiderstand können umgewandelt werden, und die maximalen Lebenspunkte können um bis zu 10 % erhöht werden. Jedes Mal, wenn der Todeswiderstand ausgelöst wird, wird zusätzlich 1 Karte „Silberschlüssel-Schimmer\" in die Hand gelegt.\\n·Bodenlose Wundnarbe: Im Bosskampf wird jedes Mal, wenn die erhaltene Lebenserholung 100 % des Lebenslimits erreicht, der nachfolgende Lebenserhol-Effekt um 25 % verringert, aber die aktuelle Gesamtmenge des Todeswiderstands um 25 % erhöht; dies kann bis zu 3 Mal ausgelöst werden.\\n·Prismalinse: Zu Beginn der Runde: Wenn der Gegenangriff 2000 % des Lebenslimits überschreitet, werden die überschüssigen Stapel halbiert, und der permanente Gegenangriff kann sich bis zu 6000 % des Lebenslimits stapeln; wenn die Vergiftung des Feindes 3000 % des Lebenslimits überschreitet, werden die überschüssigen Stapel halbiert, und die Vergiftung kann sich bis zu 9000 % des Lebenslimits stapeln. Der Schadensbonus, den der Erweckte durch Gegenangriff erhält, wird um 70 % verringert, aber alle verursachten Vergiftungen und Gegenangriffe werden um 10 % erhöht. Für jeden erweckten Erweckten: Nach Rundenende erhält man 25 % des aktuellen permanenten Gegenangriffs als temporären Gegenangriff; am Ende der feindlichen Runde werden zusätzlich 25 % Vergiftung bei allen Feinden ausgelöst.\\n·Schicksalslichtkegel: Die Anzahl der Runden, in denen gewöhnliche Monster „Starren\" einsetzen, wird auf 6 Runden geändert. Zu Beginn von Runde 15 wird 1 Karte „Lichtkegel-Grenze\" in die Hand gelegt: Füllt die Silberschlüssel-Energie und den Wahnsinn aller Erweckten auf den Maximalwert auf."
  },
  State_89559_Name = {
    Text = "Raumzeitverzerrung"
  },
  State_89567_Desc = {
    Text = "Die Arithmetica dieser Karte verbraucht [StateArg1] weniger."
  },
  State_89567_Name = {
    Text = "Wiedergeburt in der versunkenen Erde"
  },
  State_89568_Desc = {
    Text = "<PVPWeaponKeywords:Schicksalsrad>: Nach dem Tod des Ausrüsters werden alle „Fähigkeiten“ mit einem Berechnungsverbrauch von -[StateArg1] in den Ziehstapel gemischt, und der Eigentümer wird zum Verbündeten mit dem höchsten verbleibenden Leben geändert."
  },
  State_89568_Name = {
    Text = "Wiedergeburt in der versunkenen Erde"
  },
  State_89571_Name = {
    Text = "“Brennendes Theater“"
  },
  State_89572_Desc = {
    Text = "Zu Beginn der Runde füge zufällig [DescArg1] Karten im Handdeck <BurningKeywords:Verbrennung> hinzu und erhalte [DescArg2] Punkte temporäre Stärke. Nach jeweils 2 Runden erhöht sich die Anzahl der hinzugefügten brennenden Karten um 1, die erhaltene temporäre Stärke erhöht sich um [DescArg3] Punkte."
  },
  State_89572_Name = {
    Text = "“Brennendes Theater“"
  },
  State_89626_Desc = {
    Text = "Nach der Silberschlüssel-Erweckung 1 „Silberschlüssel-Glanz“-Karte auf die Hand nehmen. Wenn alle Erwachten erwacht sind, am Rundenbeginn zufällig 1 Unterstützungs-Karte eines Erwachten erhalten."
  },
  State_89631_Desc = {
    Text = "Zusätzliche [Layer] Sprünge"
  },
  State_89634_Desc = {Text = "Wecken 4"},
  State_89634_Name = {Text = "Wecken 4"},
  State_89637_Desc = {
    Text = "Die erste Befehlskarte jeder Runde wird einmal zusätzlich wirksam. Bei Vernichtung wird 1 Tentakel erzeugt. Nachdem der Tentakel in die Haltung „Brüllend“ gewechselt ist, lösen die nächsten 2 Befehlskarten automatisch den Sprungeffekt aus und betreten den Hyperraum. Abkühlung: 3 Runden."
  },
  State_89640_Desc = {
    Text = "Reichsbeherrschung um 200 Punkte erhöht. Beim Verbrauch des Purpurnen Ofens wird der Tentakelschaden um 15 % des verbrauchten Betrags erhöht. Bei jedem Tentakelangriff werden [Arg3] Punkte Purpurner Ofen angesammelt."
  },
  State_89642_Desc = {
    Text = "Maximale Handgröße +2, nach Freigeben der Verherrlichung wird der vorübergehende Gesamtschaden um 10 % erhöht. Wenn eine Karte in den Hyperraum gelangt, wird 1 “Embryo“ in “Nachkomme der Reinheit“ umgewandelt. Für jeden erzeugten “Embryo“ wird die Arithmetica-Kosten einer zufälligen Karte im Hyperraum um 1 gesenkt."
  },
  State_89669_Desc = {
    Text = "Silberschlüsselerweckung 4"
  },
  State_89669_Name = {
    Text = "Silberschlüsselerweckung 4"
  },
  State_89759_Desc = {
    Text = "Nach der Freisetzung des Bande erhält Ramona 50 % temporäre kritische Rate."
  },
  State_89759_Name = {
    Text = "Wertvolle Bindung"
  },
  State_90023_Name = {
    Text = "Status für die Konfigurationstabelle mit Konstanten, vorübergehend veraltet."
  },
  State_90059_Desc = {
    Text = "Wenn in dieser Runde aktiver Schaden oder Tentakelschaden erlitten wird, wird Korrosion in gleicher Menge entfernt und LP in Höhe von [DescArg1]% der entfernten Menge verloren. Bei anderem erlittenen Schaden wird Korrosion in Höhe von 50% des Schadens entfernt."
  },
  State_90059_Name = {Text = "Korrosion"},
  State_90094_Name = {
    Text = "Schwarze Feder"
  },
  State_90218_Desc = {
    Text = "Team Unique: Maximale Handgröße +2, gleichartige Effekte können sich nicht stapeln. Der Ausrüster erhöht Schild und Grundschaden um <WeaponEffect_Num:[StateArg1]%>, erhält <WeaponEffect_Num:[StateArg2]> Punkte Aliemus, wenn er in die Ultra-Runde eintritt. Nach der Freigabe von “Vernichtung“ erhalten alle Erwecker vorübergehend Krit. Schaden +<WeaponEffect_Num:[StateArg3]%>, 3 Runden Abklingzeit."
  },
  State_90218_WeaponDesc = {
    Text = "Maximale Handgröße +2, gleichartige Effekte sind nicht stapelbar. Der Ausrüster erhöht Schild und Grundschaden um <WeaponEffect_Num:[StateArg1]%>, erhält <WeaponEffect_Num:[StateArg2]> Punkte Wahnsinn, wenn er in die Ultra-Runde eintritt. Nach der Freigabe von “Vernichtung“ erhalten alle Erwecker vorübergehenden kritischen Schaden +<WeaponEffect_Num:[StateArg3]%, 3 Runden Abkühlung."
  },
  State_90221_Desc = {
    Text = "Einzigartig für das Team: Die Schilde des Trägers erhöhen sich um <WeaponEffect_Num:[StateArg1]%>. Zu Rundenende erhält man einen Schild in Höhe von <WeaponEffect_Num:[StateArg2]%> der VERT des Trägers, wobei die VERT jede Runde um 2 % ansteigt."
  },
  State_90221_Name = {
    Text = "Einsame Feder"
  },
  State_90221_WeaponDesc = {
    Text = "Schilde, die vom Träger erzeugt werden, erhöhen sich um <WeaponEffect_Num:[StateArg1]%>. Am Rundenende erhält man <WeaponEffect_Num:[Block:DescArg1]> Schildpunkte."
  },
  State_90294_Desc = {
    Text = "Wenn in dieser Runde aktiver Schaden oder Tentakelschaden erlitten wird, wird Korrosion in gleicher Menge entfernt und LP in Höhe von [DescArg1]% der entfernten Menge verloren. Bei anderem erlittenen Schaden wird Korrosion in Höhe von 50% des Schadens entfernt."
  },
  State_90294_Name = {
    Text = "<Corrosion:Korrosion>"
  },
  State_90591_Name = {
    Text = "Lege [Layer] Karten „Inspiration“ in die Hand"
  },
  State_90594_Name = {
    Text = "und [Layer] temporäre Alarm"
  },
  State_90599_Name = {
    Text = "Verleiht allen Erwachten [Layer] Wahnsinn"
  },
  State_90600_Name = {
    Text = "Erhalte [Layer] Punkte Silberschlüssel-Energie"
  },
  State_90601_Name = {
    Text = "(剩余 [DescArg1] 次 <harmonyKeyWord:“Harmonisierung“>)"
  },
  State_90603_Name = {
    Text = "Erhalte [Layer] temporäre Stärke"
  },
  State_90604_Name = {
    Text = "Stelle [Layer] HP wieder her, erhöht sich mit verlorenem HP"
  },
  State_90696_Desc = {
    Text = "Beim Ausspielen wird zuvor 1 “Gewürz“ entdeckt, hinzugefügt und dessen Effekt ausgelöst. Im Bosskampf erhöht sich die Anzahl der Harmonisierungen um 1."
  },
  State_90696_Name = {
    Text = "<harmonyKeyWord:Harmonisierung>"
  },
  State_91106_Desc = {
    Text = "Jede Schicht Fanatismus fügt dem aktiven Schaden und Tentakelschaden 10 % des Schadens als <BleedingIconKeywords:Bluten> hinzu."
  },
  State_91106_Name = {Text = "Wahnsinn"},
  State_91165_Name = {Text = "Blasses Ei"},
  State_91235_Desc = {
    Text = "Beim Verlieren von LP wird eine gleiche Anzahl von Stapelungen reduziert. Wenn Verletzung 0 erreicht, erhalten alle Erwecker 10 Aliemus und die Verletzungs-Stapelungen werden zurückgesetzt."
  },
  State_91235_Name = {Text = "Verletzung"},
  State_91236_Name = {
    Text = "Römische Aktion wendet die Lebenspunkte des Anführers an"
  },
  State_91329_Desc = {
    Text = "Die Arithmetica dieser Karte verbraucht [StateArg1] weniger."
  },
  State_91329_Name = {
    Text = "Makabre Delikatessen"
  },
  State_91521_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Am Ende des Zuges mische [StateArg1] <PVPDerivativeCardKeywords_17:\"Einblick\"> in die Hand."
  },
  State_91521_Name = {
    Text = "Drill zur schnellen Bereitstellung"
  },
  State_91522_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Bei Ausrüstung und am Ende der Runde fügt der Ausrüster dem Hinterreihe-Feind <Damage:[Damage:StateArg1]> Schaden zu."
  },
  State_91522_Name = {
    Text = "Von der Dunkelheit zur Dunkelheit"
  },
  State_91676_Desc = {
    Text = "Die genauen Effekte hängen von der allgemeinen Schlaglogik ab."
  },
  State_91706_Desc = {
    Text = "Zu Beginn der nächsten Runde erhalten Sie Arithmetica in Höhe der Schichten."
  },
  State_91706_Name = {
    Text = "<CardKeyWord:Behalte Arithmetica>"
  },
  State_91717_Desc = {
    Text = "Es können maximal 3 Trümmer angesammelt werden. Wird das Limit erreicht, kann die nächste „Nekrotische Gala\" sie verzehren und ihren Effekt verstärken. Die Trümmer werden in den nächsten Kampf übernommen."
  },
  State_91717_Name = {Text = "Trümmer"},
  State_91759_Desc = {
    Text = "Schwarze Feder kann die Fähigkeit von „Heiliger Sohn · Schwarze Feder“ stärken."
  },
  State_91759_Name = {
    Text = "Schwarze Feder"
  },
  State_91761_Desc = {
    Text = "Wenn der Schild von „Heiliger Sohn – Schwarze Feder“ nicht durchbrochen wird, bleiben 50 % davon bis zur nächsten Runde erhalten, und am Ende der Runde erhält man 1 Schicht <Guaiwuheiyu:Schwarze Feder>."
  },
  State_91761_Name = {
    Text = "Überragende Ambitionen"
  },
  State_91797_Desc = {
    Text = "Nach dem Ausspielen dieser Karte erhalten die vorderen Feinde gleich viele Schichten Schild."
  },
  State_91797_Name = {
    Text = "<PVPredKeyword:Verborgener Schmerz>"
  },
  State_91799_Desc = {
    Text = "Nach dem Ausspielen dieser Karte erhalten die vorderen Feinde [Layer] Schild."
  },
  State_91799_Name = {
    Text = "<PVPredKeyword:Verschleierte Qual [Layer]>"
  },
  State_91809_Desc = {
    Text = "Die Arithmetica dieser Karte verringert sich um -[Layer]."
  },
  State_91809_Name = {
    Text = "Konzentration"
  },
  State_91819_Desc = {
    Text = "Erhält die entsprechende Verbesserung basierend auf der aktuellen Kampfrunde."
  },
  State_91819_Name = {
    Text = "<CardKeyWord:Wachstum>"
  },
  State_91827_Desc = {
    Text = "„Schlag“ wählt ein Ziel und verdrängt vor dem „Schlag“ alle positiven Zustände des Ziels zu den Erwachten dahinter."
  },
  State_91827_Name = {
    Text = "<CardKeyWord:Der Ruf der Tiefsee>"
  },
  State_94410_Name = {
    Text = "Zu Beginn jeder Runde und nach dem Ende einer Aktion wird versucht, das leere Deck des Spielers zurückzusetzen; wenn es nicht leer ist, wird es nicht zurückgesetzt."
  },
  State_94411_Name = {
    Text = "Zu Beginn jeder Runde und nach dem Ende einer Aktion wird versucht, das leere Spieler-Deck zurückzusetzen; wenn es nicht leer ist, erfolgt keine Rücksetzung."
  },
  State_94426_Name = {
    Text = "Passivschild"
  },
  State_94540_Desc = {
    Text = "Wenn sich hinter dem Ziel kein anderer Erwachter befindet, entferne den positiven Zustand des Ziels."
  },
  State_94540_Name = {
    Text = "<CardKeyWord:Vertreibung positiver Zustände>"
  },
  State_94600_Desc = {
    Text = "Nach erlittenem tödlichem Schaden 1 Schicht entfernen und 5 % der maximalen Lebenspunkte wiederherstellen. Jede weitere Auslösung innerhalb dieser Runde erhöht die Wiederherstellung um 1 %."
  },
  State_94600_Name = {
    Text = "Todwiderstand"
  },
  State_94603_Name = {
    Text = "Ghul-Markierung"
  },
  State_94608_Name = {
    Text = "Todeswiderstands-Aktivierungscounter"
  },
  State_94623_Desc = {
    Text = "Jede Schicht Fanatismus fügt dem aktiven Schaden und Tentakelschaden 10 % des Schadens als <BleedingIconKeywords:Bluten> hinzu."
  },
  State_94623_Name = {
    Text = "<Kuangre:Wahnsinn>"
  },
  State_94657_Desc = {
    Text = "Beim Töten eines Gegners oder Auslösen seines Wiederbelebungseffekts den entsprechenden Effekt auslösen"
  },
  State_94657_Name = {
    Text = "<KillKeywords:Ausknocken>"
  },
  State_94692_Desc = {
    Text = "Nach erlittenem tödlichem Schaden 1 Schicht entfernen und 5 % der maximalen Lebenspunkte wiederherstellen. Jede weitere Auslösung innerhalb dieser Runde erhöht die Wiederherstellung um 1 %."
  },
  State_94692_Name = {
    Text = "<Guaiwusiwangdikang: Todeswiderstand>"
  },
  State_94693_Desc = {
    Text = "Zu Rundenbeginn, wenn andere Verbündete vorhanden sind, verliere [DescArg1] Lebenspunkte und füge dem Verbündeten mit den meisten Leben 1 Schicht <Guaiwusiwangdikang:Todeswiderstand> und [DescArg2] Punkte <PowerIconKeywords:Macht> hinzu."
  },
  State_94693_Name = {
    Text = "Verrottete Leichenteile"
  },
  State_94708_Desc = {
    Text = "Zu Rundenbeginn, wenn andere Verbündete vorhanden sind, verliere [DescArg1] Lebenspunkte und füge dem Verbündeten mit den höchsten Lebenspunkten 1 Schicht <Guaiwusiwangdikang:Todeswiderstand> und [DescArg2] Punkte <Duren:Giftklinge> hinzu."
  },
  State_94708_Name = {
    Text = "Gemeinsame Nahrungsaufnahme in der Tiefsee"
  },
  State_94730_Desc = {
    Text = "Wenn ungeblockter Schaden verursacht wird, füge pro Schicht [Layer] Punkte <IntoxicationIconKeywords:Vergiftung> hinzu."
  },
  State_94730_Name = {Text = "Giftklinge"},
  State_94993_Desc = {
    Text = "Anzahl der Himmelserschütternden Wutwellen pro Runde zurücksetzen."
  },
  State_94993_Name = {
    Text = "Himmelserschütternde Wutwellen-Rücksetzungen"
  },
  State_94994_Desc = {
    Text = "Jede Schicht erhöht die ANGszahl um 1, verliert 1 Schicht bei kritischen Treffern, mindestens 1 Schicht, alle Schichten gehen am Rundenende verloren."
  },
  State_94994_Name = {
    Text = "Himmelserschütternde Wutwellen-Anzahl"
  },
  State_94995_Desc = {
    Text = "Bei jedem erlittenen krit. Schaden erhältst du 3 % <Baojidikang:vorübergehend Krit. Widerstand>. Bei jedem verursachten Schaden wird einer zufälligen Karte eine „Tiefentauchmarke\" hinzugefügt."
  },
  State_94995_Name = {
    Text = "Tiefsee-Opferritual"
  },
  State_94996_Desc = {
    Text = "Beim ANG erhält man temporäre Stärke in Höhe der Schichten."
  },
  State_94996_Name = {Text = "Wut"},
  State_94997_Desc = {
    Text = "Bei jedem erlittenen Krit. Schaden erhältst du 5% <Baojidikang:Temporär Krit. Widerstand>. Bei jedem verursachten Schaden wird einer zufälligen Karte die „Tiefentauchmarke\" hinzugefügt."
  },
  State_94997_Name = {
    Text = "Tiefsee-Opferritual"
  },
  State_94998_Desc = {
    Text = "Beim Auslösen von <Guaiwusiwangdikang: Todeswiderstand> wird einer zufälligen Karte im Nachziehstapel oder im Handstapel <SlowIconKeywords:Verlangsamung> hinzugefügt."
  },
  State_94998_Name = {
    Text = "Verkörperung der Verzweiflung"
  },
  State_94999_Desc = {
    Text = "Pro Runde die Anzahl der Himmelsfressenden Wellen zurücksetzen."
  },
  State_94999_Name = {
    Text = "Himmelsfressende Welle: Anzahl zurücksetzen"
  },
  State_95000_Desc = {
    Text = "Immun gegen negative Zustände."
  },
  State_95000_Name = {
    Text = "Immun gegen negative Status"
  },
  State_95001_Desc = {
    Text = "Jede Schicht erhöht die ANGszahl um 1, verliert 1 Schicht bei kritischen Treffern, mindestens 1 Schicht, alle Schichten gehen am Rundenende verloren."
  },
  State_95001_Name = {
    Text = "Himmelsfressende Welle Anzahl"
  },
  State_95002_Desc = {
    Text = "Innerhalb dieser Runde wird die Wahrscheinlichkeit, von einem kritischen Treffer betroffen zu sein, um [Layer]% reduziert."
  },
  State_95002_Name = {
    Text = "Vorübergehende kritische Resistenz"
  },
  State_95002_WeaponDesc = {
    Text = "Innerhalb dieser Runde wird die Wahrscheinlichkeit, von einem kritischen Treffer betroffen zu sein, um [Layer]% reduziert."
  },
  State_95035_Desc = {
    Text = "Wenn ungeblockter Schaden verursacht wird, füge pro Schicht 1 Punkt <IntoxicationIconKeywords:Vergiftung> hinzu."
  },
  State_95035_Name = {
    Text = "<Duren: Giftklinge>"
  },
  State_95038_Desc = {
    Text = "Beim ANG erhält man temporäre Stärke in Höhe der Schichten."
  },
  State_95038_Name = {
    Text = "<Kuangbao: Raserei>"
  },
  State_95040_Desc = {
    Text = "Verlorenes Leben aufzeichnen"
  },
  State_95040_Name = {
    Text = "Verlorenes Leben aufzeichnen"
  },
  State_95932_Name = {
    Text = "Ghul aussaugen und warten"
  },
  State_95937_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: “Verherrlichung“ zieht [StateArg1] Karten, wobei zuerst eigene “Fähigkeit“-Karten gezogen werden, und deren Arithmetica-Kosten - [StateArg2] sind."
  },
  State_95937_Name = {
    Text = "Makabre Delikatessen"
  },
  State_95938_Desc = {
    Text = "Jedes Mal, wenn eine Karte entfernt wird, erhöht sich die Sättigung um 1 Schicht. Maximale Stapelgrenze: 10"
  },
  State_95938_Name = {Text = "Sättigung"},
  State_95943_Desc = {
    Text = "Verursachter Schaden vorübergehend um 30 % reduziert."
  },
  State_95943_Name = {
    Text = "Interferenz"
  },
  State_95944_Desc = {
    Text = "Team Unique: Der Grundschaden des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]>, und für jeden getöteten Gegner erhöht sich die kritische Trefferquote des Ausrüsters in dieser Erkundung um 2% und der Grundschaden der Verherrlichung erhöht sich um <WeaponEffect_Num:[StateArg2]>, maximal 10 Mal stapelbar. Wenn das aktuelle Reich „Fleisch“ ist, erhält der Ausrüster zusätzlich <WeaponEffect_Num:[StateArg4]> Punkte Wahnsinn, mit einer Abklingzeit von 3 Runden."
  },
  State_95944_WeaponDesc = {
    Text = "Der Grundschaden des Ausrüsters wird um <WeaponEffect_Num:[StateArg1]%> erhöht. Bei jedem Töten erhöht sich die Krit. Rate des Ausrüsters in dieser Erkundung um 2%, und der Grundschaden der Verherrlichung erhöht sich um <WeaponEffect_Num:[StateArg2]%>, maximal 10 Mal stapelbar. Wenn das aktuelle Reich „Fleisch“ ist, erhält der Ausrüster zusätzlich <WeaponEffect_Num:[StateArg4]> Punkte Aliemus, mit einer Abklingzeit von 3 Runden."
  },
  State_95948_Name = {
    Text = "Ghul saugen"
  },
  State_95949_Desc = {
    Text = "Nach dem Ausspielen verliert Durschein die Hälfte seiner <Guaiwucanhai:Trümmer>."
  },
  State_95949_Name = {Text = "Überfall"},
  State_95953_Desc = {
    Text = "Der Heileffekt des Todeswiderstands wird auf das 5-Fache gesteigert."
  },
  State_95953_Name = {
    Text = "Vorhang der Träume"
  },
  State_95954_Name = {
    Text = "Ghul aussaugen - Erwachende Version"
  },
  State_95960_Desc = {
    Text = "Die Anzahl der Trümmer erhöht die Wirkung von „Trümmer sammeln“."
  },
  State_95960_Name = {Text = "Trümmer"},
  State_95962_Name = {
    Text = "Tötungszahl"
  },
  State_95964_Desc = {
    Text = "Einzigartig im Team: Der Grundschaden, den der Ausrüster verursacht, erhöht sich um <WeaponEffect_Num:[StateArg1]%>. Wenn das aktuelle Reich „Fleisch“ ist, werden beim Ausschalten eines Gegners <WeaponEffect_Num:[StateArg2]%> der ANGsstärke des Ausrüsters als Purpurner Ofen angesammelt."
  },
  State_95964_WeaponDesc = {
    Text = "Der Grundschaden des Ausrüsters wird um <WeaponEffect_Num:[StateArg1]%> erhöht. Wenn das aktuelle Reich „Fleisch“ ist, werden beim Eliminieren eines Gegners <WeaponEffect_Num:[DescArg1]> Punkte des Purpurnen Ofens angesammelt."
  },
  State_95966_Desc = {
    Text = "Zu Beginn der nächsten Runde ziehe [Layer] Karten des entsprechenden Erwachten."
  },
  State_95966_Name = {
    Text = "Grausame Homage"
  },
  State_95967_Desc = {
    Text = "Die Anzahl der Trümmer erhöht die Wirkung von „Trümmer sammeln“."
  },
  State_95967_Name = {
    Text = "<Guaiwucanhai:Trümmer>"
  },
  State_95968_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Bei der Ausrüstung erhältst du [StateArg1] <StrongEffectKeywords:stark>. Der überschüssige Schaden beim Besiegen eines Feindes wird an die hinteren Kämpfer weitergeleitet."
  },
  State_95968_Name = {
    Text = "Kuss der Ruhe"
  },
  State_96167_Desc = {
    Text = "Kann nicht aufgehoben werden. Nach dem Töten des Erweckers erhalten andere Verbündete [StateArg1] <StrongEffectKeywords:Amplifikation>."
  },
  State_96167_Name = {
    Text = "Brennende Asche des Schwarzen Sterns"
  },
  State_96183_Desc = {
    Text = "Am Ende der Runde, wenn keine anderen Verbündeten auf dem Feld sind, wechselt der Gegner seine Intention zu „Selbstzerstörung“"
  },
  State_96183_Name = {
    Text = "Ghoul Selbstzerstörung"
  },
  State_96193_Name = {
    Text = "Essen vor der Mahlzeit"
  },
  State_96330_Desc = {
    Text = "Jedes Mal, wenn Durexain 1% Leben verliert, erhöhen sich der Grundschaden, der Schild und der Wahnsinn seiner Befehlskarten um 1%."
  },
  State_96330_Name = {
    Text = "Geisterflüstern"
  },
  State_96352_Name = {
    Text = "Ursprünglicher Ghul-Zähler"
  },
  State_96354_Name = {
    Text = "Anfängliche maximale Gesundheit"
  },
  State_96355_Desc = {
    Text = "Kritische Trefferwahrscheinlichkeit um [Layer]% reduziert."
  },
  State_96355_Name = {
    Text = "Krit. Widerstand"
  },
  State_96355_WeaponDesc = {
    Text = "In diesem Kampf wird die Wahrscheinlichkeit, kritisch getroffen zu werden, um [Layer]% verringert."
  },
  State_96356_Desc = {
    Text = "Erhalte pro [DescArg1] verlorene Lebenspunkte [DescArg2] Stufen <ReinforcePVEKeywords:Verstärkung>, maximal [DescArg3] Stufen. Erhöht nach dem Auslösen von “<Guaiwusiwangdikang:Todwiderstand>“ die maximale Lebenspunktzahl um [DescArg4] %."
  },
  State_96356_Name = {
    Text = "Schutz von Ilaine"
  },
  State_96357_Desc = {
    Text = "Nach Rundenende +gleiche Anzahl an Stärke"
  },
  State_96357_Name = {
    Text = "<Fennu: Wut>"
  },
  State_96358_Desc = {
    Text = "Kritische Trefferwahrscheinlichkeit um [Layer] % reduziert."
  },
  State_96358_Name = {
    Text = "<Baojidikang:Kritische Resistenz>"
  },
  State_96412_Name = {
    Text = "Fabel der Gier - Überwachung"
  },
  State_96416_Desc = {
    Text = "Kritische Trefferwahrscheinlichkeit um [Layer]% reduziert."
  },
  State_96416_Name = {
    Text = "Krit. Widerstand"
  },
  State_96603_Name = {
    Text = "Falls diese Karte in dieser Runde nicht gespielt wird, wird zu Beginn der nächsten Runde einmal der Effekt „Harmonisierung“ ausgelöst"
  },
  State_96610_Name = {
    Text = "Erster Todeswiderstand"
  },
  State_96613_Name = {
    Text = "<Riesenkraft Überwachung>"
  },
  State_96650_Desc = {
    Text = "Pro Schicht wird die kritische Trefferchance aller Erwecker um [DescArg1]% erhöht, maximal 3 Schichten."
  },
  State_96650_Name = {
    Text = "<ExclamationPointColour:Hitze>"
  },
  State_96719_Desc = {
    Text = "Wenn in dieser Runde eine <BurningKeywords:brennende> Karte ausgespielt wird, erhältst du keine <Heat:Hitze> mehr, stattdessen wird 1 Punkt <Heat:Hitze> verbraucht, um die Wirkung 2-mal auszulösen. Am Ende der Runde wird <Heat:Hitze> entfernt."
  },
  State_96719_Name = {
    Text = "<BurningColor:Explosionsüberlastung>"
  },
  State_96731_Desc = {
    Text = "Wenn in dieser Runde eine <BurningKeywords:brennende> Karte ausgespielt wird, erhältst du keine <Heat:Hitze> mehr, sondern verbrauchst 1 Punkt <Heat:Hitze>, um die Wirkung 2-mal auszulösen. Am Ende der Runde wird <Heat:Hitze> entfernt."
  },
  State_96731_Name = {
    Text = "<Overload:Explosionsüberlastung>"
  },
  State_96732_Desc = {
    Text = "Pro Schicht wird die kritische Rate aller Erwecker um [DescArg1]% erhöht, maximal 3 Schichten."
  },
  State_96732_Name = {
    Text = "<Heat:Wärme>"
  },
  State_96740_Desc = {
    Text = "Der nächste erlittene aktive Schaden erhöht sich um 25 %, am Beginn der Runde entfernt."
  },
  State_96740_Name = {
    Text = "<CardKeyWord:Schwachstelle>"
  },
  State_96741_Desc = {
    Text = "Nach dem Ausspielen: Falls die verbleibende Arithmetica größer als [StateArg1] ist, werden zusätzlich [StateArg1] Arithmetica verbraucht, um den nachfolgenden Effekt auszulösen."
  },
  State_96741_Name = {
    Text = "<CardKeyWord:Arithmetica-Überlastung>"
  },
  State_96742_Name = {
    Text = "Arithmetica-Überlastung Trigger-Markierung"
  },
  State_96743_Desc = {
    Text = "Nach dem Ausspielen: Falls die verbleibende Arithmetica die für eine Arithmetica-Überlastung erforderliche Menge überschreitet, werden zusätzliche Arithmetica verbraucht, um den nachfolgenden Effekt auszulösen."
  },
  State_96743_Name = {
    Text = "<CardKeyWord:Arithmetica-Überlastung>"
  },
  State_96744_Desc = {
    Text = "Der nächste erlittene aktive Schaden erhöht sich um 25 %, am Beginn der Runde entfernt."
  },
  State_96744_Name = {Text = "Zögern"},
  State_96774_Desc = {
    Text = "Bei jedem erlittenen kritischen Schaden erhältst du 3% temporäre kritische Resistenz."
  },
  State_96774_Name = {
    Text = "Tiefsee-Geist"
  },
  State_96780_Desc = {
    Text = "Die Karte bleibt erhalten, wird beim Ausspielen oder Wegwerfen jedoch die Kontamination entfernen und 1 Tiefenwandler-Klumpen beschwören, maximal 2 Stück. Falls kein Platz zum Beschweren vorhanden ist, erhält das Tiefenwandler-Marionette sofort [DescArg1] Macht und [DescArg2] Leben."
  },
  State_96780_Name = {
    Text = "<Kuangluan:Seefahrer-Wahnsinn>"
  },
  State_96783_Desc = {
    Text = "Jede Runde werden 2 Karten mit „<Kuangluan:Seefahrer-Raserei>\" belegt."
  },
  State_96783_Name = {
    Text = "Seefahrer-Ritual"
  },
  State_96784_Desc = {
    Text = "Kann die ANGe der Korrosionspuppe reduzieren, maximal 5 Schichten."
  },
  State_96784_Name = {Text = "Chaos"},
  State_96808_Desc = {
    Text = "Für jeden Verlust von [DescArg1] Lebenspunkten erhältst du 15 Schichten “<ReinforcePVEKeywords:Festung>“, maximal 75 Schichten. Nach der Zerstörung wird alles geleert und du erhältst 1 Schicht “<Chaos:Chaos>“. Wenn “Wiederherstellung des Gewebes“ noch nie aktiviert wurde, wechselt die Absicht nach erlittenem tödlichen Schaden zu “Wiederherstellung des Gewebes“ und wird immun gegen allen Schaden."
  },
  State_96808_Name = {
    Text = "“Chimärenpuppe“"
  },
  State_96809_Name = {
    Text = "Chimärenpuppe-Zähler"
  },
  State_96810_Desc = {
    Text = "Verursachter Schaden um 25 % reduziert."
  },
  State_96810_Name = {
    Text = "Vorhang der Träume"
  },
  State_96813_Name = {
    Text = "Rekombinationsmarker"
  },
  State_97114_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: „Schlag“ erhält [StateArg1] Arithmetica, „Fähigkeit“ Schaden +[StateArg2]%."
  },
  State_97114_Name = {
    Text = "Ankommende Sonne"
  },
  State_97118_Name = {
    Text = "Chimärenpuppe zerstören"
  },
  State_97119_Desc = {
    Text = "Die Karte bleibt erhalten, wird beim Ausspielen oder Wegwerfen jedoch die Kontamination entfernen und 1 Tiefenwandler-Klumpen beschwören, maximal 2 Stück. Falls kein Platz zum Beschweren vorhanden ist, erhält das Tiefenwandler-Marionette sofort [DescArg1] Macht und [DescArg2] Leben."
  },
  State_97119_Name = {
    Text = "<Kuangluan:Seefahrer-Wahnsinn>"
  },
  State_97120_Desc = {
    Text = "Durch den magischen Kreis geschützt wird der Schaden, den alle Feinde verursachen, um 25 % reduziert."
  },
  State_97120_Name = {
    Text = "Vorhang der Träume"
  },
  State_97131_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Pro 1 Arithmetica, die die „Fähigkeit \" kostet, erhöht sich der Schaden um [StateArg1] %. Nach einem Töten erhöht sich der durch „Verherrlichung\" verursachte Schaden um [StateArg2] %, aktueller Bonus [DescArg1] %."
  },
  State_97131_Name = {
    Text = "Bernsteinfarbener Tod"
  },
  State_97134_Desc = {
    Text = "Verursachter Gesamtschaden um 50 % erhöht."
  },
  State_97134_Name = {
    Text = "Chant der Selene"
  },
  State_97135_Desc = {
    Text = "Verursachter Endschaden um 25 % erhöht."
  },
  State_97135_Name = {
    Text = "Selene-Flüstern"
  },
  State_97136_Desc = {
    Text = "Verursachter Gesamtschaden um 100 % erhöht."
  },
  State_97136_Name = {
    Text = "Selene-Gesang"
  },
  State_97137_Desc = {
    Text = "Nach dem Abwerfen in die Hand zurückkehren."
  },
  State_97137_Name = {
    Text = "Nach dem Abwerfen in die Hand zurückkehren"
  },
  State_97137_WeaponDesc = {
    Text = "Beim Ziehen bist du für 1 Runde geschwächt. Nach der Benutzung werden alle Gegner für 1 Runde geschwächt. Nicht verkäuflich"
  },
  State_97219_Desc = {
    Text = "Die nächsten <plural value=\"[Layer]\" singular=\"Karte\" plural=\"Karten\">, die Wanda spielt, wirken 1 zusätzliches Mal."
  },
  State_97219_Name = {
    Text = "Königin der Dornen"
  },
  State_97251_Desc = {
    Text = "·Wird nicht zum bevorzugten Angriffsziel der Gegner und kann von Gegnern nicht als Einzelziel ausgewählt werden, wenn der schleichende Erwecker \n·Beim Erlangen von Schleich wird der eigene Spott und der Schleich anderer Verbündeter entfernt. Wenn es keine anderen Verbündeten gibt oder ein Gegner den Spott erhält, wird der Schleich entfernt."
  },
  State_97251_Name = {Text = "Schleichen"},
  State_97252_Desc = {
    Text = "·Wird nicht zum bevorzugten Angriffsziel der Gegner und kann von Gegnern nicht als Einzelziel gewählt werden, wenn der Erwecker im Schleichmodus ist.\n·Beim Erlangen von Schleich wird der eigene Spott und der Schleich anderer Verbündeter entfernt. Wenn keine anderen Verbündeten vorhanden sind oder ein Feind Spott erhält, wird der Schleich aufgehoben."
  },
  State_97252_Name = {
    Text = "<CardKeyWord:Versteckung>"
  },
  State_97339_Name = {
    Text = "Mythag-Meisterschaftspokal"
  },
  State_97742_Desc = {
    Text = "Jedes Mal, wenn Aktiver Schaden erlitten wird, wird der SCH-Quelle [Layer] <FixedDamage:Reiner SCH> zugefügt."
  },
  State_97742_Name = {
    Text = "Gegenangriff"
  },
  State_97743_Desc = {
    Text = "Erhöhe den verursachten aktiven Schaden um [Layer] Punkte."
  },
  State_97743_Name = {
    Text = "<PowerColourKeywords:Kraft>"
  },
  State_97744_Desc = {
    Text = "Erlittener SCH –[Layer]%."
  },
  State_97744_Name = {
    Text = "<ReinforceColour:verstärkt>"
  },
  State_97744_WeaponDesc = {
    Text = "Verursachter Gesamtschaden um [DescArg1] % reduziert"
  },
  State_97938_Desc = {
    Text = "Endgültiger Schaden wird um [DescArg1] % erhöht."
  },
  State_97938_Name = {
    Text = "Mythag-Meisterschaftspokal"
  },
  State_97939_Desc = {
    Text = "Verursachter Gesamtschaden um 50 % erhöht."
  },
  State_97939_Name = {
    Text = "Mythag Meisterschaftspokal"
  },
  State_97941_Desc = {
    Text = "Grundschaden um 100 % erhöht."
  },
  State_97941_Name = {
    Text = "Mythag-Meisterschaftspokal"
  },
  State_97942_Desc = {
    Text = "Beim Freisetzen von Exaltieren erhält man 35 Punkte Wahnsinn."
  },
  State_97942_Name = {
    Text = "Mythag-Meisterschaftspokal"
  },
  State_97943_Name = {
    Text = "Zähler für Rechenleistungsbehalte"
  },
  State_98055_Desc = {
    Text = "Am Ende der Runde, erzeuge 1 Tentakel. Entferne diesen Zustand nach dem Erwachen"
  },
  State_98055_Name = {Text = "Schlaf"},
  State_98060_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, sein Leben wiedererlangen und in seiner wahren Form mit dem Kampf beginnen"
  },
  State_98060_Name = {
    Text = "Nicht erweckt"
  },
  State_98068_Desc = {
    Text = "Bei 10 Schichten „Explosive Hitze“ erhältst du 2 Punkte Arithmetica, und alle „Gigantischen Flares“ werden in „Tausendfache Flares“ umgewandelt."
  },
  State_98068_Name = {
    Text = "<BaoyanKeywords:Flammeninferno>"
  },
  State_98139_Desc = {
    Text = "Nach Beginn der Runde des Gegners wird zufällig 1 Handkarte mit <BurningKeywords:brennen> belegt."
  },
  State_98139_Name = {
    Text = "Status@Monster Katigula Erwachenssymbol"
  },
  State_98140_Desc = {
    Text = "Wechsel die Absicht nach dem Ansammeln von 10 Schichten <MonsterExFlameKeywords:Flammeninferno> in den extrem hohen Schaden von “Unzählige Strahlenausbrüche“!"
  },
  State_98140_Name = {
    Text = "<BurningColor:Flammeninferno>"
  },
  State_98147_Desc = {
    Text = "Wenn der Feind <BurningKeywords:Brennen> Karten spielt, gewähre dir 1 Stapel <MonsterExFlameKeywords:Verbrennung>, reduziere aber vorübergehend [DescArg1] <PowerIconKeywords:STR>."
  },
  State_98147_Name = {
    Text = "Status@Monster Katigora Brennender Wächter"
  },
  State_98148_Desc = {
    Text = "Dieser Erwecker ist noch ungeweckt... wird er kurz vor dem Fall erwachen, wirft alle verbleibenden Handkarten ab und verleiht <BurningKeywords:brennen>, LP-Wiederherstellung und beginnt in seiner wahren Form mit dem Kampf."
  },
  State_98148_Name = {
    Text = "Nicht erweckt"
  },
  State_98302_Desc = {
    Text = "Einzigartig im Team: Der Grundschaden des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>, die verursachte Kraft um <WeaponEffect_Num:[StateArg2]%>. Nachdem eine Befehlskarte des Ausrüsters gespielt wurde, erhält man temporäre Kraft in Höhe von <WeaponEffect_Num:[StateArg3]%> der Angriffskraft des Ausrüsters, maximal 5 Mal pro Runde auslösbar."
  },
  State_98302_WeaponDesc = {
    Text = "Der Grundschaden des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>, und die verursachte Kraft steigt um <WeaponEffect_Num:[StateArg2]%>. Nachdem eine Befehlskarte des Ausrüsters gespielt wurde, erhält man <WeaponEffect_Num:[Power:DescArg1]> Punkte an vorübergehender Stärke. Dies kann pro Runde maximal 5-mal ausgelöst werden (momentan: [DescArg2]/5 Mal)."
  },
  State_98323_Desc = {
    Text = "Nach dem Abwerfen kehrt die Karte erneut in die Hand zurück"
  },
  State_98323_Name = {
    Text = "Nach dem Abwerfen kehrt es auf die Hand zurück"
  },
  State_98341_Desc = {
    Text = "Kann mit anderen Primärfarben gemischt werden, um eine neue Farbe zu erzeugen."
  },
  State_98341_Name = {
    Text = "<Yellow:Primärfarbe Gelb>"
  },
  State_98344_Desc = {
    Text = "Kann mit anderen Primärfarben gemischt werden, um eine neue Farbe zu erzeugen."
  },
  State_98344_Name = {
    Text = "<Red:Primärfarbe · Rot>"
  },
  State_98345_Desc = {
    Text = "Kann mit anderen Primärfarben gemischt werden, um neue Farben zu erzeugen."
  },
  State_98345_Name = {
    Text = "<Blue:Primärfarbe Blau>"
  },
  State_98366_Desc = {
    Text = "Zu Beginn der Runde: Wenn die s-Energie größer als [Arg1] ist, werden [Arg1] Punkte s-Energie verbraucht, um 1 <DerivativeCardKeywords_115:“Höhere Inspiration“> auf die Hand zu legen."
  },
  State_98435_Desc = {
    Text = "Aus der Mischung von Rot und Blau, bei jeder Verursachung von aktivem Schaden erhält man <Block: [DescArg1]> Punkte Schild."
  },
  State_98435_Name = {
    Text = "<PurpleKeyWord:Imagination·Lila>"
  },
  State_98436_Desc = {
    Text = "Durch die Mischung von Rot und Gelb erhält der entsprechende Erwachte nach der Freisetzung von Wahnsinnsexplosion <Energy:15> Wahnsinn."
  },
  State_98436_Name = {
    Text = "<ExclamationPointColour:Vision·Orange>"
  },
  State_98437_Desc = {
    Text = "Erhöht den verursachten Endschaden um 10 %."
  },
  State_98437_Name = {
    Text = "<Red:Primärfarbe Rot>"
  },
  State_98438_Desc = {
    Text = "Entstanden aus einer Mischung von Gelb und Blau, heile <Heal:[DescArg1]> Lebenspunkte, wenn du “Verteidigung“ spielst."
  },
  State_98438_Name = {
    Text = "<GreenWord:Vision · Grün>"
  },
  State_98439_Desc = {
    Text = "Hergestellt aus einer Mischung von Gelb und Blau, heile <Heal:[DescArg1]> Punkte Leben, wenn du “Verteidigung“ spielst."
  },
  State_98439_Name = {
    Text = "<GreenWord:Vision · Grün>"
  },
  State_98440_Desc = {
    Text = "Entstanden aus einer Mischung aus Rot und Blau, erhält man bei jedem verursachten aktiven Schaden <Block: [DescArg1]> Schild."
  },
  State_98440_Name = {
    Text = "<PurpleKeyWord:Imagination·Lila>"
  },
  State_98441_Desc = {
    Text = "Entstanden aus der Mischung von Rot und Gelb, erhält der entsprechende Erwecker nach der Freisetzung von Wahnsinnsexplosion <Energy:15> Punkte Wahnsinn."
  },
  State_98441_Name = {
    Text = "<ExclamationPointColour:Vision·Orange>"
  },
  State_98444_Desc = {
    Text = "Einzigartig im Team: Der Grundschaden des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>. Nachdem 5 Befehlskarten des Ausrüsters ausgespielt wurden, erhält der Ausrüster <WeaponEffect_Num:[StateArg2]%> kritische Trefferquote. Dieser Effekt kann pro Runde nur einmal ausgelöst werden."
  },
  State_98444_WeaponDesc = {
    Text = "Der Grundschaden des Ausrüsters erhöht sich um <WeaponEffect_Num:[StateArg1]%>. Nachdem 5 Befehlskarten des Ausrüsters ausgespielt wurden, erhält der Ausrüster <WeaponEffect_Num:[StateArg2]%> kritische Trefferquote. Dieser Effekt kann pro Runde nur einmal ausgelöst werden (momentan wurden [DescArg1]/5 Karten ausgespielt)."
  },
  State_98466_Name = {
    Text = "<HuoyanKeywords1:Lebendiges Feuer 1>"
  },
  State_98468_Name = {
    Text = "<HuoyanKeywords3:Lebendiges Feuer 3>"
  },
  State_98470_Name = {
    Text = "<HuoyanKeywords2:Lebendiges Feuer 2>"
  },
  State_98474_Desc = {
    Text = "Die Grundfarben, die durch Mischung andere Farben erzeugen können, bestehen aus Rot, Gelb und Blau."
  },
  State_98474_Name = {
    Text = "Primärfarbe"
  },
  State_98484_Name = {
    Text = "Ertrinken in Trauer"
  },
  State_98485_Desc = {
    Text = "Der Gesamtschaden und die Stärke dieser Karte +[DescArg1] %; Rollen-Schild und Aliemus +[DescArg2] %. Erhält „Behalten \". Nach dem Ausspielen werden alle „Lebendige Flamme\"-Stapelungen verbraucht und 1 Stapelung „Lebendige Flamme \" auf eine andere Katyusha-Befehlskarte auf der Hand übertragen."
  },
  State_98485_Name = {
    Text = "<HuoyanKeywords2:Lebendiges Feuer 2>"
  },
  State_98486_Desc = {
    Text = "Der Gesamtschaden und die Stärke dieser Karte +[DescArg1] %; Rollen-Schild und Aliemus +[DescArg2] %. Erhält „Behalten \". Nach dem Ausspielen werden alle „Lebendige Flamme\"-Stapelungen verbraucht und 1 Stapelung „Lebendige Flamme \" auf eine andere Katyusha-Befehlskarte auf der Hand übertragen."
  },
  State_98486_Name = {
    Text = "<HuoyanKeywords3:Lebendiges Feuer 3>"
  },
  State_98487_Desc = {
    Text = "Der Gesamtschaden und die Stärke dieser Karte +[DescArg1] %; Rollen-Schild und Aliemus +[DescArg2] %. Erhält „Behalten \". Nach dem Ausspielen werden alle „Lebendige Flamme\"-Stapelungen verbraucht und 1 Stapelung „Lebendige Flamme \" auf eine andere Katyusha-Befehlskarte auf der Hand übertragen."
  },
  State_98487_Name = {
    Text = "<HuoyanKeywords1:Lebendiges Feuer 1>"
  },
  State_98488_Desc = {
    Text = "Jede Stufe von „Lebendige Flamme“ erhöht den endgültigen Schaden, Schild, Wahnsinn und Stärke der Karte um 30 %, stapelbar bis zu 3 Stufen. Karten mit „Lebendige Flamme“ erhalten «Behalten», verbrauchen beim Ausspielen alle Stufen von „Lebendige Flamme“ und leiten 1 Stufe „Lebendige Flamme“ auf eine andere «Befehlskarte» von Katigoras auf der Hand weiter."
  },
  State_98488_Name = {
    Text = "<HuoyanKeywords:Lebendige Flamme>"
  },
  State_98492_Desc = {
    Text = "Nach Beginn der Erkundung erhöhen sich Körperbau, Angriff und Verteidigung um [StateArg1]%"
  },
  State_98492_Name = {
    Text = "Seelenschmiede-Begabung"
  },
  State_98495_Desc = {
    Text = "Nach Beginn der Erkundung erhöhen sich Körperbau, Angriff und Verteidigung um [StateArg1]%"
  },
  State_98495_Name = {
    Text = "Seelenschmiede-Begabung"
  },
  State_98507_Desc = {
    Text = "Nach Beginn der Erkundung erhöhen sich Körperbau, Angriff und Verteidigung um [StateArg1]%."
  },
  State_98507_Name = {
    Text = "Seelenschmiede-Begabung"
  },
  State_98511_Name = {
    Text = "Ableitungskarte erhalten"
  },
  State_98551_Desc = {
    Text = "Kampfbeginn: Domänenbeherrschung +[Arg1]. Zu Beginn ungerader Runden ziehst du 1 Karte, zu Beginn gerader Runden erhältst du 1 Punkt Arithmetica."
  },
  State_98553_Desc = {
    Text = "Jedes Mal, wenn ein “Embryo“ generiert wird, erhältst du [Arg1] Punkte Purpurner Ofen. Dies kann pro Runde maximal 3-mal ausgelöst werden."
  },
  State_98555_Desc = {
    Text = "Beim Kampfbeginn erhältst du [Arg1]% verstärkte Effekte. Ziehe [Arg2] Karten, nachdem zum ersten Mal in der Runde Gift angewendet wurde."
  },
  State_98556_Desc = {
    Text = "Alle Erwachten erhöhen die Basiswirkung von Lebensregeneration und Schilden um [Arg1]%."
  },
  State_98557_Desc = {
    Text = "Jedes Mal, wenn 1 „Embryo“ generiert wird, erhältst du [Arg1] Punkte Purpurner Ofen. Dies kann pro Runde maximal 3-mal ausgelöst werden."
  },
  State_98559_Desc = {
    Text = "Beim Ziehen oder Verwerfen einer Karte erhält man [Arg1] temporäre Stärke, maximal [Arg2] Stärke stapelbar."
  },
  State_98560_Desc = {
    Text = "Alle Erwecker erhöhen den Basisschaden um [Arg1]%. Bevor ein Erwecker die Wahnexplosion auslöst, wird dessen Basisschaden vorübergehend um [Arg2]% erhöht."
  },
  State_98561_Desc = {
    Text = "Zu Beginn der Runde erhöht sich die temporäre Schadensintensität um +[Arg1]%, wenn das Leben unter 50% liegt. Wenn das Leben unter 25% liegt, ziehe zusätzlich [Arg2] Karten und erhalte [Arg2] Arithmetica."
  },
  State_98562_Desc = {
    Text = "Nachdem aktiver oder Tentakelschaden verursacht wurde, erhöht sich der Tentakelschaden, den das Ziel in dieser Runde erleidet, um [Arg1] %, maximal 20 Mal pro Runde auslösbar."
  },
  State_98563_Desc = {
    Text = "Kampfbeginn: Erhalte [Arg1] <PowerIconKeywords:Stärke>. Für jede ausgespielte Karte mit <DepleteIconKeywords:Verbrauch> erhält man [Arg2] temporäre <PowerIconKeywords:Stärke>, maximal [Arg3]-mal auslösbar."
  },
  State_98564_Desc = {
    Text = "Bei“Wahnsinnsausbruch“werden [Arg1] s-Energie gewährt, maximal 3-mal pro Runde auslösbar"
  },
  State_98565_Desc = {
    Text = "Jedes Mal, wenn eine Karte in den Hyperraum gelangt, ziehe [Arg1] Befehlskarten des Eigentümers dieser Karte aus dem Deck. Falls keine Karten gezogen werden können, erhältst du stattdessen entsprechend viel Arithmetica. Dieser Effekt kann pro Runde maximal 2 Mal ausgelöst werden."
  },
  State_98567_Desc = {
    Text = "Vor Rundenende erhält der zugehörige Erwachte für jede Befehlskarte in deiner Hand [Arg1] Wahnsinn."
  },
  State_98568_Desc = {
    Text = "Beim Kampfbeginn erhältst du eine Schadensverstärkung von +[Arg1]%. Nachdem du aktiven Schaden verursacht hast, löst du [Arg2] Vergiftung auf alle Gegner aus. Dies kann pro Runde maximal 5-mal zusätzlich ausgelöst werden."
  },
  State_98569_Desc = {
    Text = "Nach dem ersten “Schlüsselbefehl“ jeder Runde allen Feinden [Arg1] Schichten Gift hinzufügen und [Arg2] Schichten Gegenschlag erhalten."
  },
  State_98571_Desc = {
    Text = "Nach der Silberschlüsselerweckung [Arg1] Leben wiederherstellen und [Arg2] Punkte s-Energie erhalten."
  },
  State_98571_Name = {
    Text = "Reise-Sonnenschirm"
  },
  State_98572_Desc = {
    Text = "Nach dem zweiten Freisetzen des “Bande“ in jeder Runde erhältst du [Arg1] Punkte s-Energie, und alle Erwachten erhalten [Arg2] Punkte Wahnsinn."
  },
  State_98575_Desc = {
    Text = "Beim Kampfbeginn +[Arg1]% Schadensverstärkung erhalten. Nach verursachtem aktivem Schaden [Arg2] Vergiftung auf alle Gegner auslösen, maximal 5-mal pro Runde zusätzlich ausführbar."
  },
  State_98576_Desc = {
    Text = "Beim Kampfbeginn werden allen Feinden [Arg1] Schichten Schwäche und Verwundbarkeit zugefügt. Dieser Effekt wird auch durch “Vernichtung“ ausgelöst, hat jedoch eine Abklingzeit von 3 Runden."
  },
  State_98577_Desc = {
    Text = "Alle Erwecker erhöhen den Basisschaden um [Arg1]%. Bevor der Erwecker die Wahnexplosion auslöst, wird sein Basisschaden vorübergehend um [Arg2]% erhöht."
  },
  State_98579_Desc = {
    Text = "Zu Beginn der Runde erhöht sich die temporäre Schadensintensität um +[Arg1]%, wenn das Leben unter 50 % liegt. Wenn das Leben unter 25 % liegt, ziehe zusätzlich [Arg2] Karten und erhalte [Arg2] Arithmetica."
  },
  State_98581_Desc = {
    Text = "Alle Erwachten erhalten bei ihrer ersten Befehlskarte jeder Runde [Arg1] Punkte s-Energie."
  },
  State_98582_Desc = {
    Text = "Nach dem fünfmaligen Einsatz von \"exaltieren\" wirken die nächsten [Arg1] Nicht-Derivationsbefehlskarten 1 zusätzliches Mal."
  },
  State_98583_Desc = {
    Text = "Alle Erwachten erhalten bei ihrer ersten Befehlskarte in jeder Runde [Arg1] Punkte s-Energie."
  },
  State_98586_Desc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwachten, deren Wahnsinn nicht ausreicht, um die Wahnexplosion auszulösen, [Arg1] Punkte Wahnsinn."
  },
  State_98587_Desc = {
    Text = "Beim Ziehen oder Verwerfen einer Karte erhält man [Arg1] temporäre Stärke, bis zu [Arg2] temporäre Stärke."
  },
  State_98588_Desc = {
    Text = "Vor Rundenende erhält der zugehörige Erwachte für jede Befehlskarte in deiner Hand [Arg1] Wahnsinn."
  },
  State_98589_Desc = {
    Text = "Zu Beginn des Kampfes verlieren alle Feinde temporär [Arg1] Kraft. Das Verwenden des „Purpurnen Ofens“ löst diesen Effekt ebenfalls aus, hat jedoch eine Abkühlzeit von 3 Runden."
  },
  State_98590_Desc = {
    Text = "Beim Kampfbeginn [Arg1]% Stärke erhalten. Beim ersten Giftanwenden pro Runde [Arg2] Karten ziehen."
  },
  State_98591_Desc = {
    Text = "Nach dem ersten “Schlüsselbefehl“ jeder Runde erhalten alle Feinde [Arg1] Schichten Gift, und Sie erhalten [Arg2] Schichten Gegenschlag."
  },
  State_98596_Desc = {
    Text = "Beim ersten “Schlüsselbefehl“ jeder Runde werden [Arg1]% der verbrauchten s-Energie erstattet."
  },
  State_98597_Desc = {
    Text = "Nach der Silberschlüsselerweckung [Arg1] Leben wiederherstellen und [Arg2] Punkte s-Energie erhalten."
  },
  State_98597_Name = {
    Text = "Reise-Sonnenschirm+"
  },
  State_98598_Desc = {
    Text = "Beim Kampfbeginn erhält man [Arg1] Stärke. Für jede ausgespielte Karte mit „Kosten“ erhält man [Arg2] temporäre Stärke, maximal [Arg3]-mal auslösbar."
  },
  State_98600_Desc = {
    Text = "Zu Beginn des Kampfes verlieren alle Feinde temporär [Arg1] Kraft. Das Verwenden des „Purpurnen Ofens“ löst diesen Effekt ebenfalls aus, hat jedoch eine Abkühlzeit von 3 Runden."
  },
  State_98602_Desc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. In jeder Runde beim ersten Gegenschlag 1/2 Arithmetica erhalten."
  },
  State_98603_Desc = {
    Text = "Zu Beginn des Kampfes Schadenamplifikation +[Arg1]% erhalten. Nach dem Erleiden von aktivem Schaden oder Tentakelschaden [Arg2] Gegenangriff erhalten, bis zu 3 Mal pro Runde."
  },
  State_98604_Desc = {
    Text = "Zu Beginn des Kampfes Schadenamplifikation +[Arg1]% erhalten. Nach dem Erleiden von aktivem Schaden oder Tentakelschaden [Arg2] Gegenangriff erhalten, bis zu 3 Mal pro Runde."
  },
  State_98606_Desc = {
    Text = "Jedes Mal, wenn eine Karte in den Hyperraum gelangt, ziehe [Arg1] Befehlskarten des Besitzers dieser Karte aus dem Deck. Wenn keine Karten gezogen werden können, erhältst du stattdessen die entsprechende Menge an Arithmetica. Dieser Effekt kann pro Runde maximal 2 Mal ausgelöst werden."
  },
  State_98607_Desc = {
    Text = "Beim ersten “Schlüsselbefehl“ jeder Runde alle Tentakel aktivieren, um [Arg1]-mal gegen die Gegner zu attackieren und 50 % Schaden zu verursachen."
  },
  State_98608_Desc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Für jede gespielte Befehlskarte eines anderen Erweckers erhältst du zusätzlich 15/30% temporäre Schadensverstärkung."
  },
  State_98610_Desc = {
    Text = "Nach der Silberschlüssel-Erweckung erhalten die 2/4 Karten mit der höchsten Arithmetica-Power in der Hand vor dem nächsten Ausspielen die Effekte „Behalten“ und „Vorbereitung“ sowie 100/200 Silberschlüssel-Energie."
  },
  State_98611_Desc = {
    Text = "Am Kampfbeginn erhöht sich die Domänenbeherrschung um +[Arg1]. Zu Beginn ungerader Runden ziehst du 1 Karte, zu Beginn gerader Runden erhältst du 1 Punkt Arithmetica."
  },
  State_98612_Desc = {
    Text = "Beim ersten “Schlüsselbefehl“ jeder Runde erhöht sich die temporäre Schadensverstärkung um +[Arg1] %, je niedriger das Leben, desto stärker der Effekt."
  },
  State_98613_Desc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Für jede gespielte Befehlskarte eines anderen Erweckers erhält man zusätzlich 15/30% temporäre Schadensverstärkung."
  },
  State_98614_Desc = {
    Text = "Nach dem fünfmaligen Einsatz von \"exaltieren\" wirken die nächsten [Arg1] Nicht-Derivationsbefehlskarten 1 zusätzliches Mal."
  },
  State_98615_Desc = {
    Text = "Beim ersten “Schlüsselbefehl“ jeder Runde werden [Arg1]% der verbrauchten Silberschlüsselenergie zurückerstattet."
  },
  State_98616_Desc = {
    Text = "Alle Erwachten erhöhen die Basiswirkung von Heilung und Schilden um [Arg1]%."
  },
  State_98617_Desc = {
    Text = "Nachdem aktiver oder Tentakelschaden verursacht wurde, erhöht sich der Tentakelschaden, den das Ziel in dieser Runde erleidet, um [Arg1] %. Pro Runde maximal 20-mal auslösbar."
  },
  State_98619_Desc = {
    Text = "Wenn am Ende der Runde die s-Energie voll ist, [Arg1] Punkte s-Energie verbrauchen, um eine Karte “Silberschlüssel-Schimmer“ in die Hand zu legen."
  },
  State_98621_Desc = {
    Text = "Wenn am Ende des Zuges die s-Energie voll ist, [Arg1] Punkte s-Energie verbrauchen, um eine Karte „Silberschlüssel-Dämmerung“ in die Hand zu legen."
  },
  State_98623_Desc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwachten, deren Wahnsinn nicht ausreicht, um die Wahnexplosion auszulösen, [Arg1] Punkte Wahnsinn."
  },
  State_98624_Desc = {
    Text = "Zu Kampfbeginn und nachdem der Todeswiderstand ausgelöst wurde, erhält man [Arg1] Punkte s-Energie."
  },
  State_98625_Desc = {
    Text = "Beim Kampfbeginn Schwäche und Verwundbarkeit mit [Arg1] Schichten an alle Feinde verursachen. Dieser Effekt wird auch nach „Vernichtung“ ausgelöst, hat jedoch eine Abkühlzeit von 3 Runden."
  },
  State_98626_Desc = {
    Text = "Beim ersten “Schlüsselbefehl“ jeder Runde erhöht sich die vorübergehende Schadensintensität um +[Arg1] %, je niedriger das Leben, desto stärker ist der Effekt."
  },
  State_98627_Desc = {
    Text = "Bei «Wahnsinnsausbruch» erhältst du [Arg1] s-Energie, maximal 3 Mal pro Runde auslösbar."
  },
  State_98628_Desc = {
    Text = "Beim ersten “Schlüsselbefehl“ jeder Runde alle Tentakel aktivieren, um [Arg1]-mal gegen die Gegner zu attackieren und 50% Schaden zu verursachen."
  },
  State_98629_Desc = {
    Text = "Nach dem zweiten Freisetzen des “Bande“ in jeder Runde erhältst du [Arg1] Punkte s-Energie, und alle Erwachten erhalten [Arg2] Punkte Wahnsinn."
  },
  State_98630_Desc = {
    Text = "Zu Kampfbeginn und nach dem Auslösen des Todeswiderstands erhält man [Arg1] Punkte Silberschlüssel-Energie."
  },
  State_98632_Desc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Zu Rundenbeginn, beim ersten Mal, wenn ein Hinterhalt ausgelöst wird, erhält man 1/2 Arithmetica."
  },
  State_98686_Desc = {
    Text = "Die nächste [Layer]-Karte, nicht abgeleitete Befehlskarte, wirkt einmal zusätzlich."
  },
  State_98686_Name = {
    Text = "Nicht abgeleitete Befehlskarte, doppelt wirken"
  },
  State_98739_Desc = {
    Text = "Wenn die Absicht in „Blasser Wirbel“ umgewandelt wird, erhöht sich die Anzahl der Schadensangriffe entsprechend der Schichtanzahl des Status. Der Status wird am Ende der Runde geleert. Erreicht der Status 3 Schichten, wird die Absicht sofort in „Blasser Wirbel“ umgewandelt."
  },
  State_98739_Name = {
    Text = "Kuss der Spinnefrau"
  },
  State_98742_Desc = {
    Text = "Die verursachten Vergiftungsschichten erhöhen sich um 100%. Am Ende jeder Runde erhält man <Block:[Block:DescArg1]> Schild."
  },
  State_98742_Name = {
    Text = "Pfad der Verlorenen"
  },
  State_98743_Desc = {
    Text = "Nachdem innerhalb einer Runde [DescArg1] Schaden erlitten wurde, erhält man 75 Schichten temporäre Verstärkung, die Intention wird in „Ungeduldige Gaben“ umgewandelt, der Steinigungseffekt wird aufgehoben und man erhält 1 Schicht „Kuss der Spinne“."
  },
  State_98743_Name = {
    Text = "Übertrittler"
  },
  State_98752_Desc = {
    Text = "Setzt die Karte in Brand. Nach dem Ausspielen erleidet man 5% Schaden des maximalen Lebens. Wenn sie am Rundenende noch auf der Hand ist, wird sie verbraucht."
  },
  State_98752_Name = {
    Text = "<BurningKeywords2:Verbrennung>"
  },
  State_98752_WeaponDesc = {
    Text = "Jede Schicht Verzögerung erhöht die Arithmetica-Kosten der Karte um 1 Punkt"
  },
  State_98887_Name = {
    Text = "künstliche Seele"
  },
  State_98889_Desc = {
    Text = "Lege die abgeleitete Befehlskarte oder die Unterstützungskarte mit <DepleteIconKeywords:Verbrauch> nach dem ersten Spielen jeder Runde in den Ablagestapel."
  },
  State_98889_Name = {
    Text = "künstliche Seele"
  },
  State_98912_Desc = {
    Text = "Pro Schicht wird der Endschaden aller Erwecker um 20% reduziert."
  },
  State_98912_Name = {
    Text = "<LostWay:verloren>"
  },
  State_98913_Desc = {
    Text = "Pro Schicht wird der Endschaden aller Erwecker um 20% reduziert."
  },
  State_98913_Name = {Text = "Verloren"},
  State_99007_Desc = {
    Text = "Nach dem Ausspielen wird nicht in den Ablagestapel gelegt, sondern aus dem Deck entfernt"
  },
  State_99007_Name = {
    Text = "<DepleteIconKeywords:Verbrauch>"
  },
  State_99007_WeaponDesc = {
    Text = "Nach dem Ausspielen wird die Karte nicht in den Ablagestapel gelegt und kann in diesem Kampf nicht erneut verwendet werden"
  },
  State_99053_Desc = {
    Text = "<PVPWeaponKeywords:Rad des Schicksals>: Nach dem “Wahnsinnsausbruch“ zieht ein anderer Verbündeter [StateArg1] Karten."
  },
  State_99053_Name = {
    Text = "Pinsel des Verlangens"
  },
  State_99055_Desc = {
    Text = "<PVPWeaponKeywords:Schicksrad>: Nach „Verherrlichung\" wird zufällig [StateArg1] eigene „Fähigkeit\"-Karten in die Hand gelegt und ihre Arithmetica-Kosten auf 0 gesetzt."
  },
  State_99055_Name = {
    Text = "Paradoxon des Realismus"
  },
  State_99056_Desc = {
    Text = "Einzigartig im Team: Nach der Freisetzung des Bande erhöht sich die kritische Rate des Ausrüstenden temporär um <WeaponEffect_Num:[StateArg1]%>."
  },
  State_99056_WeaponDesc = {
    Text = "Nach der Freisetzung des Bande erhöht sich die temporäre kritische Rate des Ausrüsters um <WeaponEffect_Num:[StateArg1]%>."
  },
  State_99134_Desc = {
    Text = "“Maler“ verwendete Farbstoffe, die die Fähigkeitseffekte verstärken. Nach dem Ausspielen einer “<ColorInkKeywords:Farbige Tinte>“ oder “<ErosionColorInkKeywords:Auflösende Tinte>“ Karte erhält sie 1 Schicht, maximal 10 Schichten."
  },
  State_99134_Name = {
    Text = "Phantasma-Farbe"
  },
  State_99237_Name = {
    Text = "Status Schmuck Aufstieg"
  },
  State_99237_WeaponDesc = {
    Text = "Der Ausrüstende verursacht eine Erhöhung des Grundschadens um 10%. Wenn der Schaden des Ausrüstenden stark mehr als 20% beträgt, erhöht sich der Grundschaden zusätzlich um 10%"
  },
  State_99238_Name = {
    Text = "Status Schmuck Humus"
  },
  State_99238_WeaponDesc = {
    Text = "Der Ausrüstende verursacht eine Erhöhung des Grundschadens um 10%. Wenn der Schaden des Ausrüstenden stark mehr als 20% beträgt, erhöht sich der Grundschaden zusätzlich um 10%"
  },
  State_99239_Name = {
    Text = "Status Schmuck Styx"
  },
  State_99239_WeaponDesc = {
    Text = "Der Ausrüstende verursacht eine Erhöhung des Grundschadens um 10%. Wenn der Schaden des Ausrüstenden stark mehr als 20% beträgt, erhöht sich der Grundschaden zusätzlich um 10%"
  },
  State_99258_Desc = {
    Text = "Einzigartig im Team: Nach der zweiten Freisetzung des Schlüssels in jeder Runde besteht eine Wahrscheinlichkeit von <WeaponEffect_Num:[StateArg1]%>, 1 Karte des Ausrüsters zu ziehen. Nach dem Spielen der dritten Karte des Ausrüsters in jeder Runde erhältst du <WeaponEffect_Num:[StateArg2]> Punkte s-Energie."
  },
  State_99258_WeaponDesc = {
    Text = "Nach der zweiten Freisetzung des Schlüssels in jeder Runde besteht eine Wahrscheinlichkeit von <WeaponEffect_Num:[StateArg1]%>, 1 Karte des Ausrüsters zu ziehen. Nach dem Spielen der dritten Karte des Ausrüsters in jeder Runde erhältst du <WeaponEffect_Num:[StateArg2]> Punkte s-Energie."
  },
  State_99294_Desc = {
    Text = "Die Wut, die alle Erwecker verursachen, erhöht sich um [DescArg1]%, die Arithmetica und die Befehlskarten können bis zur nächsten Runde behalten werden. Die Wutsteigerung des prächtigen Kapitels."
  },
  State_99294_Name = {
    Text = "“ Freude “"
  },
  State_99295_Desc = {
    Text = "Die von allen Erwachenen erzeugte Aelius erhöht sich um [StateArg1]%, und Arithmetica- und Befehlskarten können in die nächste Runde übernommen werden. Der Aelius des Prachtkapitels erhöht sich ebenfalls."
  },
  State_99295_Name = {
    Text = "“ Freude “"
  },
  State_99336_Desc = {
    Text = "„Farben“ des „Malers“, die die Fähigkeitseffekte verstärken. Nach dem Ausspielen einer „<ColorInkKeywords:Farbige Tinte>“ oder „<ErosionColorInkKeywords:Auflösung-farbige Tinte>“ Karte erhält sie 1 Schicht, maximal 10 Schichten."
  },
  State_99336_Name = {
    Text = "<DecayDye:Phantasma-Farbe>"
  },
  State_99533_Name = {
    Text = "Schmuckstück Mädchenkokon"
  },
  State_99533_WeaponDesc = {
    Text = "Nach Kampfbeginn, wenn der Träger Chaos-Klasse ist, +25% ANGskraft"
  },
  State_99534_Name = {
    Text = "süße Schnecke"
  },
  State_99534_WeaponDesc = {
    Text = "Der Schild und die Lebensregeneration des Trägers werden um 6% erhöht. Wenn die Domänenbeherrschung des Trägers über 50 liegt, wird der Schild und die Lebensregeneration zusätzlich um 6% erhöht"
  },
  State_99640_Desc = {
    Text = "Wenn du aktuell 10 Schichten Kreativität hast, verbraucht Pickman nach der Auslösung der Wahnsinnsexplosion alle Kreativität, wodurch alle Erwachten 15 Punkte Wahnsinn erhalten und 1 Schicht “Wahnsinn“ erhalten. Die Obergrenze für Kreativität beträgt 10 Schichten und kann in den nächsten Kampf übertragen werden."
  },
  State_99640_Name = {
    Text = "Kreativität"
  },
  State_99723_Desc = {
    Text = "Team-Unique: Der Wahnsinn und die Stärke des Ausrüsters erhöhen sich um <WeaponEffect_Num:[StateArg1]%. Nach der Freisetzung von Aelius erhöht sich der endgültige Schaden, der Schild und die Lebensrückgewinnung der nächsten anderen Erwecker in dieser Runde um <WeaponEffect_Num:[StateArg2]%. Wenn bei dieser Aelius Freisetzung “Verschlingen“ ausgelöst wird, erhält der Ausrüster <WeaponEffect_Num:[StateArg3]> Punkte Aelius."
  },
  State_99723_WeaponDesc = {
    Text = "Der Wahnsinn und die Stärke, die der Ausrüster verursacht, erhöhen sich um <WeaponEffect_Num:[StateArg1]%. Nach dem Einsatz der Wut-Exaltation wird der endgültige Schaden, der Schild und die Lebensregeneration der nächsten Wahnexplosion anderer Erwachter in dieser Runde um <WeaponEffect_Num:[StateArg2]%> erhöht. Wenn diese Wut-Exaltation “Verschlingen“ auslöst, erhält der Ausrüster <WeaponEffect_Num:[StateArg3]> Punkte Wahnsinn."
  }
})
return Text_State
