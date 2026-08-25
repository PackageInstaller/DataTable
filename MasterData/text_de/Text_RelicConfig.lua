__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_RelicConfig = readonly({
  RelicConfig_100300_BattleDesc = {
    Text = "Nach Beginn des Kampfes erhältst du 3 Schichten “<MindWall:Geistige Wand>“ und 1 Schicht “<TrueConfess:Geständnis>“. Nach 3 Auslösungen von “<MindWall:Geistige Wand>“ erhältst du 1 Schicht “<BarrierCrash:Barrierenzerfall>“. Nach dem Auslösen des Wahnsinns wird “<TrueConfess:Geständnis>“ in “<ShadowSelf:Schattenpersönlichkeit>“ geändert."
  },
  RelicConfig_100300_Desc = {
    Text = "Nach Beginn des Kampfes erhältst du 3 Schichten “<MindWall:Geistige Wand>“ und 1 Schicht “<TrueConfess:Geständnis>“. Nach 3 Auslösungen von “<MindWall:Geistige Wand>“ erhältst du 1 Schicht “<BarrierCrash:Barrierenzerfall>“. Nach der Freisetzung des Wahnsinns wird “<TrueConfess:Geständnis>“ in “<ShadowSelf:Persönlichkeitsschatten>“ geändert."
  },
  RelicConfig_100300_Name = {
    Text = "Seelenanalyse"
  },
  RelicConfig_100300_StoryDesc = {
    Text = "Sieh genau auf dein Herz, triff keine falsche Wahl."
  },
  RelicConfig_100399_BattleDesc = {
    Text = "Nach dem Auslösen des Effekts <DevouredIconKeywords:Verschlingen> erhalten andere Erwachte [Arg1] Wahnsinn, dieser kann pro Runde nur einmal wirken."
  },
  RelicConfig_100399_Desc = {
    Text = "Nach Aktivierung des <DevouredIconKeywords:Verschlingen>-Effekts erhalten andere Erwachte [Arg1] Wahnsinn, der pro Runde nur einmal wirksam sein kann."
  },
  RelicConfig_100399_Name = {
    Text = "<OrangeQuality:Nachgeahmtes Goldenes Traumland+>"
  },
  RelicConfig_100399_StoryDesc = {
    Text = "Der Tag der Verwandlung ist dein Todestag"
  },
  RelicConfig_100400_BattleDesc = {
    Text = "Heile am Rundenende [Heal:Arg1] LP."
  },
  RelicConfig_100400_Desc = {
    Text = "Heile am Rundenende [Heal:Arg1] LP."
  },
  RelicConfig_100400_Name = {
    Text = "<OrangeQuality:Nachgeahmtes Blut der Gnade+>"
  },
  RelicConfig_100400_StoryDesc = {
    Text = "Es ist süß und vollmundig, mit einem Hauch von Rosenduft"
  },
  RelicConfig_100401_BattleDesc = {
    Text = "Erhalte beim Verlust von Leben [Arg1]% der Lebensverlustmenge an Blutrotem Ofen."
  },
  RelicConfig_100401_Desc = {
    Text = "Erhalte beim Verlust von Leben [Arg1]% der Lebensverlustmenge des Blutroten Ofens."
  },
  RelicConfig_100401_Name = {
    Text = "<OrangeQuality:Nachgeahmte Rostige Stahlsäge+>"
  },
  RelicConfig_100401_StoryDesc = {
    Text = "Der Anatom sieht in seinem Leben keine schönen Frauen, nur einen Sack voller Knochen, entzündete Nerven durch Krankheiten, Muskeln und Gewebe"
  },
  RelicConfig_100402_BattleDesc = {
    Text = "Beim Aufheben wird auf alle Feinde [Arg1] Schichten <VulnerabilityIconKeywords:Verwundbarkeit> angewendet. Der Basisschaden aller Erwecker erhöht sich um [Arg2]%."
  },
  RelicConfig_100402_Desc = {
    Text = "Beim Aufheben wird auf alle Feinde [Arg1] Schichten <VulnerabilityIconKeywords:Verwundbarkeit> angewendet. Der Basisschaden aller Erwecker erhöht sich um [Arg2]%."
  },
  RelicConfig_100402_Name = {
    Text = "<WhiteQuality:Nachgeahmte Frühlinszeremonie>"
  },
  RelicConfig_100402_StoryDesc = {
    Text = "Im Lachen der Nacht gleitet die Silhouette des Kanus mühelos über den See"
  },
  RelicConfig_100404_BattleDesc = {
    Text = "Beim Freisetzen von “Wahnsinnsausbruch“ erhältst du [Arg1] vorübergehend <PowerIconKeywords:Stärke>."
  },
  RelicConfig_100404_Desc = {
    Text = "Nach der Freisetzung von “Wahnsinnsausbruch“ erhältst du [Arg1] vorübergehend<PowerIconKeywords:Stärke>."
  },
  RelicConfig_100404_Name = {
    Text = "<WhiteQuality:Nachgeahmtes Eisenschloss>"
  },
  RelicConfig_100404_StoryDesc = {
    Text = "Eine dicke und solide Sperre, ohne Schlüssel schwer zu öffnen.\nNatürlich ist das für einen Meisterdieb kein Problem"
  },
  RelicConfig_100405_BattleDesc = {
    Text = "Beim Aufheben wird auf alle Feinde [Arg1] Schichten <WeaknessIconKeywords:Schwäche> angewendet. Der Basisschaden aller Erwecker erhöht sich um [Arg2]%."
  },
  RelicConfig_100405_Desc = {
    Text = "Beim Aufheben wird auf alle Feinde [Arg1] Schichten <WeaknessIconKeywords:Schwäche> angewendet. Der Basisschaden aller Erwecker erhöht sich um [Arg2]%."
  },
  RelicConfig_100405_Name = {
    Text = "<WhiteQuality:Nachgeahmtes Bösartiges Kind>"
  },
  RelicConfig_100405_StoryDesc = {
    Text = "Geboren aus reinem Bösen, auch wenn es nicht sein Wille war"
  },
  RelicConfig_100406_BattleDesc = {
    Text = "Nach Aktivierung des <DevouredIconKeywords:Verschlingen>-Effekts erhalten andere Erwachte [Arg1] Wahnsinn, pro Runde kann es nur einmal wirken."
  },
  RelicConfig_100406_Desc = {
    Text = "Nach dem Auslösen des <DevouredIconKeywords:Verschlingen>-Effekts erhalten andere Erwachte [Arg1] Wahnsinn, der pro Runde nur einmal wirksam sein kann."
  },
  RelicConfig_100406_Name = {
    Text = "<WhiteQuality:Nachgeahmtes Goldenes Traumland>"
  },
  RelicConfig_100406_StoryDesc = {
    Text = "Der Tag der Verwandlung ist dein Todestag"
  },
  RelicConfig_100407_BattleDesc = {
    Text = "Jedes Mal, wenn du Schaden verursachst, erhältst du [Arg1] vorübergehende <PowerIconKeywords:Stärke>, maximal 15-mal pro Runde auslösbar."
  },
  RelicConfig_100407_Desc = {
    Text = "Jedes Mal, wenn du Schaden verursachst, erhältst du [Arg1] vorübergehende <PowerIconKeywords:Stärke>, maximal 15-mal pro Runde auslösbar."
  },
  RelicConfig_100407_Name = {
    Text = "<WhiteQuality:Nachgeahmter Filigraner Achat>"
  },
  RelicConfig_100407_StoryDesc = {
    Text = "Es sollte nur eine normale Achatmusterung sein. Wahrscheinlich"
  },
  RelicConfig_100408_BattleDesc = {
    Text = "Beim Freisetzen von “Wahnsinnsausbruch“ erhältst du [Arg1] vorübergehend <PowerIconKeywords:Stärke>."
  },
  RelicConfig_100408_Desc = {
    Text = "Beim Freisetzen von “Wahnsinnsausbruch“ erhältst du [Arg1] vorübergehend <PowerIconKeywords:Stärke>."
  },
  RelicConfig_100408_Name = {
    Text = "<OrangeQuality:Nachgeahmtes Eisenschloss+>"
  },
  RelicConfig_100408_StoryDesc = {
    Text = "Eine dicke und solide Sperre, ohne Schlüssel schwer zu öffnen.\nNatürlich ist das für einen Meisterdieb kein Problem"
  },
  RelicConfig_100409_BattleDesc = {
    Text = "Beim Aufheben wird auf alle Feinde [Arg1] Schichten <WeaknessIconKeywords:Schwäche> angewendet. Der Basisschaden aller Erwecker erhöht sich um [Arg2]%."
  },
  RelicConfig_100409_Desc = {
    Text = "Beim Aufheben wird auf alle Feinde [Arg1] Schichten <WeaknessIconKeywords:Schwäche> angewendet. Der Basisschaden aller Erwecker erhöht sich um [Arg2]%."
  },
  RelicConfig_100409_Name = {
    Text = "<OrangeQuality:Nachgeahmtes Bösartiges Kind+>"
  },
  RelicConfig_100409_StoryDesc = {
    Text = "Geboren aus reinem Bösen, auch wenn es nicht sein Wille war"
  },
  RelicConfig_100410_BattleDesc = {
    Text = "Jedes Mal, wenn du Schaden verursachst, erhältst du [Arg1] vorübergehende <PowerIconKeywords:Stärke>, maximal 15-mal pro Runde auslösbar."
  },
  RelicConfig_100410_Desc = {
    Text = "Jedes Mal, wenn du Schaden verursachst, erhältst du [Arg1] temporäre <PowerIconKeywords:Stärke>, maximal 15-mal pro Runde auslösbar."
  },
  RelicConfig_100410_Name = {
    Text = "<OrangeQuality:Nachgeahmter Filigraner Achat+>"
  },
  RelicConfig_100410_StoryDesc = {
    Text = "Es sollte nur eine normale Achatmusterung sein. Wahrscheinlich"
  },
  RelicConfig_100411_BattleDesc = {
    Text = "Beim Aufheben wird auf alle Feinde [Arg1] Schichten <VulnerabilityIconKeywords:Verwundbarkeit> angewendet. Der Basisschaden aller Erwecker erhöht sich um [Arg2]%."
  },
  RelicConfig_100411_Desc = {
    Text = "Beim Aufheben wird auf alle Feinde [Arg1] Schichten <VulnerabilityIconKeywords:Verwundbarkeit> angewendet. Der Basisschaden aller Erwecker erhöht sich um [Arg2]%."
  },
  RelicConfig_100411_Name = {
    Text = "<OrangeQuality:Nachgeahmte Frühlinszeremonie+>"
  },
  RelicConfig_100411_StoryDesc = {
    Text = "Im Lachen der Nacht gleitet die Silhouette des Kanus mühelos über den See"
  },
  RelicConfig_100412_BattleDesc = {
    Text = "Heile am Rundenende [Heal:Arg1] LP."
  },
  RelicConfig_100412_Desc = {
    Text = "Heile am Rundenende [Heal:Arg1] LP."
  },
  RelicConfig_100412_Name = {
    Text = "<WhiteQuality:Nachgeahmtes Blut der Gnade>"
  },
  RelicConfig_100412_StoryDesc = {
    Text = "Es ist süß und vollmundig, mit einem Hauch von Rosenduft"
  },
  RelicConfig_100413_BattleDesc = {
    Text = "Erhalte beim Verlust von Leben [Arg1]% der Lebensverlustmenge des Blutroten Ofens."
  },
  RelicConfig_100413_Desc = {
    Text = "Erhalte bei Verlust von Leben [Arg1]% der Lebensverlustmenge des Blutroten Ofens."
  },
  RelicConfig_100413_Name = {
    Text = "<WhiteQuality:Farbe: Rostige Stahlsäge>"
  },
  RelicConfig_100413_StoryDesc = {
    Text = "Der Anatom sieht in seinem Leben keine schönen Frauen, nur einen Sack voller Knochen, entzündete Nerven durch Krankheiten, Muskeln und Gewebe"
  },
  RelicConfig_100539_BattleDesc = {
    Text = "Nach der ersten direkten Anwendung von “Embryo“ in jeder Runde verursacht aktiver Schaden in dieser Runde <BleedingIconKeywords:Bluten> in Höhe von [Arg1]% des Schadens."
  },
  RelicConfig_100539_Desc = {
    Text = "Nach der ersten direkten Anwendung von “Embryo“ in jeder Runde verursacht aktiver Schaden in dieser Runde <BleedingIconKeywords:Bluten> in Höhe von [Arg1]%."
  },
  RelicConfig_100539_Name = {
    Text = "<WhiteQuality:Bemaltes Blutige Kopfsteinpflaster>"
  },
  RelicConfig_100539_StoryDesc = {
    Text = "Eins, zwei, drei, vier, fünf"
  },
  RelicConfig_100540_BattleDesc = {
    Text = "Nach der ersten direkten Anwendung von “Embryo“ in jeder Runde verursacht aktiver Schaden in dieser Runde <BleedingIconKeywords:Bluten> in Höhe von [Arg1]%."
  },
  RelicConfig_100540_Desc = {
    Text = "Nach der ersten direkten Nutzung von “Embryo“ in jeder Runde verursacht aktiver Schaden in dieser Runde <BleedingIconKeywords:Bluten> in Höhe von [Arg1]%."
  },
  RelicConfig_100540_Name = {
    Text = "<OrangeQuality:Nachgeahmtes Blutige Kopfsteinpflaster+>"
  },
  RelicConfig_100540_StoryDesc = {
    Text = "Eins, zwei, drei, vier, fünf"
  },
  RelicConfig_116382_BattleDesc = {
    Text = "Ein rostiger Schlüsselbund. Kann zum Öffnen von Schlössern verwendet werden"
  },
  RelicConfig_116382_Desc = {
    Text = "Ein rostiger Schlüsselbund. Kann zum Öffnen von Schlössern verwendet werden"
  },
  RelicConfig_116382_Name = {
    Text = "Rostiger Schlüssel"
  },
  RelicConfig_116383_BattleDesc = {
    Text = "Ein rostiger Schlüsselbund. Kann zum Öffnen von Schlössern verwendet werden"
  },
  RelicConfig_116383_Desc = {
    Text = "Ein rostiger Schlüsselbund. Kann zum Öffnen von Schlössern verwendet werden"
  },
  RelicConfig_116383_Name = {
    Text = "Rostiger Schlüssel"
  },
  RelicConfig_116384_BattleDesc = {
    Text = "Ein rostiger Schlüsselbund. Kann zum Öffnen von Schlössern verwendet werden"
  },
  RelicConfig_116384_Desc = {
    Text = "Ein rostiger Schlüsselbund. Kann zum Öffnen von Schlössern verwendet werden"
  },
  RelicConfig_116384_Name = {
    Text = "Rostiger Schlüssel"
  },
  RelicConfig_119371_BattleDesc = {
    Text = "Maximale Handgröße +1. \n Zu Beginn des Zuges, falls alle Rituale nicht abgeschlossen sind, erhalte <SacrificeKeyWord:Opferritual> von 10% der maximalen LP. Lege 1 Karte “<DerivativeCardKeywords_119:Götter verehren>“ in die Hand, maximal 1 Karte halten."
  },
  RelicConfig_119371_Desc = {
    Text = "Maximale Handgröße +1. \n Zu Beginn des Zuges, falls alle Rituale nicht abgeschlossen sind, erhalte 10% des maximalen LP als <SacrificeKeyWord:Opferritual>. Lege 1 Karte “<DerivativeCardKeywords_119:Götter verehren>“ in die Hand, maximal 1 Karte behalten."
  },
  RelicConfig_119371_Name = {
    Text = "Messingraucher"
  },
  RelicConfig_119371_StoryDesc = {
    Text = "“Dieser Räucherofen wurde nach den Handwerken von Lemuria gefertigt. Möge er Ihnen jede Nacht einen ruhigen Schlaf bescheren. Miryam.“"
  },
  RelicConfig_120372_BattleDesc = {
    Text = "Maximale Handgröße +[Arg1]. Zu Beginn des Zuges lege [Arg2] Karten „<PVPDerivativeCardKeywords_11:Ungleicher Austausch>\" in die Hand."
  },
  RelicConfig_120372_Desc = {
    Text = "Maximale Handgröße +[Arg1]. Zu Beginn des Zuges lege [Arg2] Karten „<PVPDerivativeCardKeywords_11:Ungleicher Austausch>\" in die Hand."
  },
  RelicConfig_120372_Name = {
    Text = "<OrangeQuality:Kaleidoskop>"
  },
  RelicConfig_120373_BattleDesc = {
    Text = "Die ersten [Arg1] “<PVPWeaponKeywords:Rad des Schicksals>“ haben Arithmetica-Kosten -5/-3/-1/+1, ziehe 1 Karte."
  },
  RelicConfig_120373_Desc = {
    Text = "Die ersten [Arg1] “<PVPWeaponKeywords:Schicksrad>“ haben Arithmetica-Kosten -5/-3/-1/+1, ziehe 1 Karte."
  },
  RelicConfig_120373_Name = {
    Text = "<OrangeQuality:Mythag-Insignien>"
  },
  RelicConfig_121214_BattleDesc = {
    Text = "Schaden immun"
  },
  RelicConfig_121214_Desc = {
    Text = "Schaden immun"
  },
  RelicConfig_121214_Name = {
    Text = "Nichtigkeits-Testschöpfung"
  },
  RelicConfig_121689_BattleDesc = {
    Text = "Verursachter Gesamtschaden um 250 % erhöht, jeder verursachte Schaden reduziert um 50 % und erhöht das verursachte Schutzschild um 10 %, maximal 5 Mal auslösbar, wird nach Beginn jeder Runde zurückgesetzt."
  },
  RelicConfig_121689_Desc = {
    Text = "Verursachter Gesamtschaden um 250 % erhöht, jeder verursachte Schaden reduziert sich um 50 % und erhöht den erhaltenen Schild um 10 %, maximal 5 Mal auslösbar, Rücksetzung nach Beginn jeder Runde."
  },
  RelicConfig_121689_Name = {
    Text = "<OrangeQuality:“Der Rückweg aus reinem Silber· Geburt“>"
  },
  RelicConfig_121690_BattleDesc = {
    Text = "Zu Beginn des Kampfes wähle 3 Karten aus, um ihnen “<RippleKeywords:Nachbeben>: Ziehe eine Karte, erhalte [Arg3] Punkte vorübergehende <PowerIconKeywords:Stärke>“ zu verleihen. Zu Beginn der Runde ziehe 2 Karten mit <RippleKeywords:Nachbeben>; alle <RippleKeywords:Nachbeben>-Effekte werden zusätzlich einmal ausgelöst. Nach 10 Auslösungen von <RippleKeywords:Nachbeben> füge 1 <DerivativeCardKeywords_1:Echos verlorener Schatten> deiner Hand hinzu."
  },
  RelicConfig_121690_Desc = {
    Text = "Kampf beginnt, wähle 3 Karten, um ihnen “<RippleKeywords:Nachbeben>: Ziehe eine Karte, erhalte [Arg3] Punkte vorübergehende <PowerIconKeywords:Stärke>“ zu verleihen. Zu Beginn der Runde ziehe 2 Karten mit <RippleKeywords:Nachbeben>, alle <RippleKeywords:Nachbeben>-Effekte werden zusätzlich einmal ausgelöst. Nach 10 Auslösungen von <RippleKeywords:Nachbeben> füge 1 <DerivativeCardKeywords_1:Echos verlorener Schatten> deiner Hand hinzu."
  },
  RelicConfig_121690_Name = {
    Text = "<OrangeQuality:“Der Rückweg aus reinem Silber· Wahnsinn“>"
  },
  RelicConfig_121691_BattleDesc = {
    Text = "Der Gesamtschaden der Verherrlichung aller Erwecker erhöht sich um 100%. Jedes Mal, wenn ein Erwecker die Verherrlichung einsetzt, erhält man Keyflare in Höhe von 500% des Basis-Aliemus des betreffenden Erweckten Körpers, und das Basis-Aliemus aller Erwecker wird um 20 gesenkt, maximal 5 Mal."
  },
  RelicConfig_121691_Desc = {
    Text = "Der Gesamtschaden der Verherrlichung aller Erwecker erhöht sich um 100%. Jedes Mal, wenn ein Erwecker die Verherrlichung einsetzt, erhält man Keyflare in Höhe von 500% des Basis-Aliemus des betreffenden Erweckten Körpers, und das Basis-Aliemus aller Erwecker wird um 20 gesenkt, maximal 5 Mal."
  },
  RelicConfig_121691_Name = {
    Text = "<OrangeQuality:“Der Rückweg aus reinem Silber· Angst“>"
  },
  RelicConfig_121692_BattleDesc = {
    Text = "Alle Erwecker erhöhen den <RetaliateIconKeywords:Gegenangriff>, <IntoxicationIconKeywords:Gift>, Schild und Lebensregeneration um 50%. Am Ende der Runde erhält man einen temporären <RetaliateIconKeywords:Gegenangriff> von 500% des aktuellen Schildes."
  },
  RelicConfig_121692_Desc = {
    Text = "Alle Erwecker erhöhen den <RetaliateIconKeywords:Gegenangriff>, <IntoxicationIconKeywords:Gift>, Schild und Lebensregeneration um 50%. Am Ende der Runde erhält man vorübergehend 500% des aktuellen Schildes an <RetaliateIconKeywords:Gegenangriff>."
  },
  RelicConfig_121692_Name = {
    Text = "<OrangeQuality:“Der Rückweg aus reinem Silber· Häresie“>"
  },
  RelicConfig_121693_BattleDesc = {
    Text = "Maximale Handgröße +5. Zu Beginn des Zuges ziehe 2 Karten und erhalte 2 Punkte Arithmetica. Jedes Mal, wenn das Deck zurückgesetzt wird, erhalte [Arg3] Punkte <PowerIconKeywords:Stärke> und [Arg4] Punkte vorübergehend <AlertIconKeywords:Wachsam>, generiere je 1 Karte jeder nicht abgeleiteten Befehlskarte des Erweckers mit dem höchsten Wahnsinn und lege sie in den Ziehstapel, wodurch ihre Arithmetica-Kosten um 1 gesenkt werden."
  },
  RelicConfig_121693_Desc = {
    Text = "Maximale Handgröße +5. Zu Rundenbeginn ziehe 2 Karten und erhalte 2 Punkte Arithmetica. Jedes Mal, wenn das Deck zurückgesetzt wird, erhalte [Arg3] Punkte <PowerIconKeywords:Stärke> und [Arg4] Punkte vorübergehendes <AlertIconKeywords:Wachsam>, generiere für jeden Erwecker mit dem höchsten Wahnsinn jeweils 1 nicht abgeleitete Befehlskarte und lege sie in den Ziehstapel, wobei ihre Arithmetica-Kosten um 1 gesenkt werden."
  },
  RelicConfig_121693_Name = {
    Text = "<OrangeQuality:“Der Rückweg aus reinem Silber· Scathe“>"
  },
  RelicConfig_121694_BattleDesc = {
    Text = "Alle Erwecker erhalten in jeder Runde beim ersten Spielen einer „Befehlskarte“ 25 Punkte Aliemus und legen eine Karte <DerivativeCardKeywords_4:„Einblick“> auf die Hand. Nach dem Auslösen von „Verherrlichung“ 4 Mal wird der <Seal:Versiegelt>-Zustand aller Erwecker aufgehoben und alle Erwecker erhalten 50 Punkte Aliemus."
  },
  RelicConfig_121694_Desc = {
    Text = "Alle Erwecker erhalten bei der ersten “Befehlskarte“ pro Runde 25 Punkte Aliemus und legen eine <DerivativeCardKeywords_4:Einblick> auf die Hand. Nach dem Auslösen von “Verherrlichung“ 4 Mal wird der <Seal:Versiegelt>-Zustand aller Erwecker aufgehoben und alle Erwecker erhalten 50 Punkte Aliemus."
  },
  RelicConfig_121694_Name = {
    Text = "<OrangeQuality:“Der Rückweg aus reinem Silber· Täuschung“>"
  },
  RelicConfig_121695_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhältst du [Arg4] Punkte <PowerIconKeywords:Stärke>, die Obergrenze der Silberschlüssel-Energie wird um 100 % erhöht. Die erhaltene Silberschlüssel-Energie pro Punkt Arithmetica-Kosten erhöht sich um 100 %. Nach der Silberschlüssel-Erweckung oder der Freisetzung des Schlüsselbefehls erhältst du temporär <PowerIconKeywords:Stärke>, die 20 % des aktuellen <PowerIconKeywords:Stärke> entspricht, und alle Erwecker erhalten 20 Punkte Aliemus."
  },
  RelicConfig_121695_Desc = {
    Text = "Zu Beginn des Kampfes erhältst du [Arg4] Punkte <PowerIconKeywords:Stärke>, die maximale Speicherung der s-Energie erhöht sich um 100 %. Die erhaltene s-Energie pro Punkt Arithmetica-Kosten erhöht sich um 100 %. Nach der Silberschlüsselerweckung oder Freisetzung des Schlüsselbefehls erhältst du temporär <PowerIconKeywords:Stärke>, die 20 % der aktuellen <PowerIconKeywords:Stärke> entspricht, und alle Erwecker erhalten 20 Punkte Aliemus."
  },
  RelicConfig_121695_Name = {
    Text = "<OrangeQuality:“Der Rückweg aus reinem Silber· Klagelied“>"
  },
  RelicConfig_122625_BattleDesc = {
    Text = "Zu Beginn des Kampfes lege [Arg1] \"<PVPDerivativeCardKeywords_25:Silvias roter Tee>\" auf die Hand."
  },
  RelicConfig_122625_Desc = {
    Text = "Zu Beginn des Kampfes lege [Arg1] \"<PVPDerivativeCardKeywords_25:Silvias roter Tee>\" auf die Hand."
  },
  RelicConfig_122625_Name = {
    Text = "<OrangeQuality:Ceylon schwarzer Tee>"
  },
  RelicConfig_122626_BattleDesc = {
    Text = "Lege in jeder Runde [Arg1] Karten “<PVPDerivativeCardKeywords_14:Realitätsnachahmung>“ in den Ziehstapel, der Besitzer ist ein zufälliger Erwecker."
  },
  RelicConfig_122626_Desc = {
    Text = "Lege in jeder Runde [Arg1] Karten in den Ziehstapel: <PVPDerivativeCardKeywords_14:Realitätsnachahmung>, deren Besitzer ein zufälliger Erwecker ist."
  },
  RelicConfig_122626_Name = {
    Text = "<OrangeQuality:Magische Handschuhe>"
  },
  RelicConfig_122627_BattleDesc = {
    Text = "Der erste gespielte “Fähigkeit“ pro Runde verursacht  [Arg1]% mehr Schaden, Heilung und Schild."
  },
  RelicConfig_122627_Desc = {
    Text = "Der Schaden, die Heilung und der Schild des ersten gespielten “Fähigkeit“ in jeder Runde erhöhen sich um [Arg1]% ."
  },
  RelicConfig_122627_Name = {
    Text = "<OrangeQuality:Rubinbrosche>"
  },
  RelicConfig_122628_BattleDesc = {
    Text = "Nach Ende der Runde, zusätzlich <Energy:[Arg1]> Aliemus erhalten."
  },
  RelicConfig_122628_Desc = {
    Text = "Nach dem Ende der Runde, erhalte zusätzlich <Energy:[Arg1]> Aliemus."
  },
  RelicConfig_122628_Name = {
    Text = "<OrangeQuality:Albtraummanifestation>"
  },
  RelicConfig_122629_BattleDesc = {
    Text = "Im Ziehstapel gibt es doppelt so viele Erwecker-Karten. Nach dem Spielen einer Karte, wenn die Handkartenanzahl in dieser Runde zum ersten Mal kleiner als [Arg1] ist, ziehe [Arg2] Karten."
  },
  RelicConfig_122629_Desc = {
    Text = "Im Ziehstapel wird es doppelt so viele Erwecker-Karten geben. Nach dem Spielen einer Karte, wenn die Anzahl der Handkarten in dieser Runde zum ersten Mal kleiner als [Arg1] ist, ziehe [Arg2] Karten."
  },
  RelicConfig_122629_Name = {
    Text = "<OrangeQuality:Fröhliche Schallplatte>"
  },
  RelicConfig_122630_BattleDesc = {
    Text = "Maximale Handgröße +[Arg1]. Lege in jeder Runde [Arg2] Karten “<PVPDerivativeCardKeywords_13:Funus Aeternum>“ in den Ziehstapel."
  },
  RelicConfig_122630_Desc = {
    Text = "Maximale Handgröße +[Arg1]. Lege in jedem Zug [Arg2] Karten “<PVPDerivativeCardKeywords_13:Funus Aeternum>“ in den Ziehstapel."
  },
  RelicConfig_122630_Name = {
    Text = "<OrangeQuality:Verlorenes Opfermesser>"
  },
  RelicConfig_122768_BattleDesc = {
    Text = "Zu Beginn der Runde ziehe [Arg1] „Schlag“-Karten mit Arithmetica-Kosten -1. Nach der Freisetzung von Exalt erzeuge [Arg2] „Schlag“-Karten des entsprechenden Erweckers mit <DepleteIconKeywords:Erschöpfen>, <PrepareKeypvewords:Vorbereiten 1> und <RetainIconKeywords:Behalten>. \n Für jeden [Arg3] „Schlag“, der innerhalb von 1 Runde gespielt wird, erhalte [Arg4] temporäre <PowerIconKeywords:Stärke>; nach dem Spielen von [Arg5] „Schlag“-Karten ziehe [Arg6] Karten und erhalte [Arg7] Arithmetica; nach dem Spielen von [Arg8] „Schlag“-Karten erhalten alle Erwecker [Arg9] Aliemus."
  },
  RelicConfig_122768_Desc = {
    Text = "Zu Beginn der Runde ziehe [Arg1] „Schlag“-Karten mit Arithmetica-Kosten -1. Nach der Freisetzung von Exalt erzeuge [Arg2] „Schlag“-Karten des entsprechenden Erweckers mit <DepleteIconKeywords:Erschöpfen>, <PrepareKeypvewords:Vorbereiten 1> und <RetainIconKeywords:Behalten>. \n Für jeden [Arg3] „Schlag“, der innerhalb von 1 Runde gespielt wird, erhalte [Arg4] temporäre <PowerIconKeywords:Stärke>; nach dem Spielen von [Arg5] „Schlag“-Karten ziehe [Arg6] Karten und erhalte [Arg7] Arithmetica; nach dem Spielen von [Arg8] „Schlag“-Karten erhalten alle Erwecker [Arg9] Aliemus."
  },
  RelicConfig_122768_Name = {
    Text = "Echo der anderen Welt"
  },
  RelicConfig_122768_StoryDesc = {
    Text = "Echos, die im Nebel einer anderen Welt vermischen, führen zu Verzerrung, Wahnsinn und unbestreitbarer Realität."
  },
  RelicConfig_123724_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Mouchette [Arg1] Punkte Aliemus und erzeugt 1 vorübergehenden „Schlag \" mit Arithmetica-Kosten von 0. Jedes Mal, wenn „Dramatische Begegnung\" ausgelöst wird, erhöht sich der Effekt der grundlegenden Schadens- und Schlag-Schadenserhöhung von „Glänzender☆Wirbelsturm \" in diesem Kampf um [Arg2] %."
  },
  RelicConfig_123724_Desc = {
    Text = "Zu Rundenbeginn erhält Mouchette [Arg1] Punkte Aliemus und erzeugt 1 vorübergehenden „Schlag \" mit Arithmetica-Kosten von 0. Jedes Mal, wenn „Dramatische Begegnung\" ausgelöst wird, erhöht sich der Effekt der grundlegenden Schadens- und Schlag-Schadenserhöhung von „Glänzender☆Wirbelsturm \" in diesem Kampf um [Arg2] %."
  },
  RelicConfig_123724_Name = {
    Text = "<OrangeQuality:Dimensionale Abbildung: Moxia>"
  },
  RelicConfig_125488_BattleDesc = {
    Text = "Alle Erwecker erhalten beim ersten Spielen einer Befehlskarte in jeder Runde [Arg1] Punkte Aliemus. Wenn in einer Runde insgesamt 4 Befehlskarten gespielt werden, die verschiedenen Erweckern zugeordnet sind, wird allen Gegnern [Arg2]% der maximalen Lebenspunkte unserer Seite als <IntoxicationIconKeywords:Gift> zugefügt."
  },
  RelicConfig_125488_Desc = {
    Text = "Alle Erwecker erhalten beim ersten Spielen einer Befehlskarte pro Runde [Arg1] Punkte Aliemus. Nachdem in einer Runde 4 Befehlskarten gespielt wurden, die verschiedenen Erweckern zugeordnet sind, wird allen Feinden [Arg2]% unserer maximalen Lebenspunkte <IntoxicationIconKeywords:Gift> zugefügt."
  },
  RelicConfig_125488_Name = {
    Text = "Die Eitelkeit der Konkubinen"
  },
  RelicConfig_125489_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Xu [Arg1] Aliemus und fügt allen Feinden 1 Stapel von <WitherKeywords:Verzaubert> hinzu. Die erste Befehlskarte, die Xu in jeder Runde spielt, löst immer den „Resonanz“-Effekt aus."
  },
  RelicConfig_125489_Desc = {
    Text = "Zu Rundenbeginn erhält Xu [Arg1] Aliemus und fügt allen Feinden 1 Stapel von <WitherKeywords:Verzaubert> hinzu. Die erste Befehlskarte, die Xu in jeder Runde spielt, löst immer den „Resonanz“-Effekt aus."
  },
  RelicConfig_125489_Name = {
    Text = "<OrangeQuality:Dimensionale Abbildung: Xu>"
  },
  RelicConfig_126673_BattleDesc = {
    Text = "Maximale Handgröße +3. Zeichne die ersten 3 nicht abgeleiteten Befehlskarten auf, die in jeder Runde gespielt werden, und zu Beginn der Runde 3 Runden später, reduziere ihre Arithmetica-Kosten um 1 und füge Kopien mit <DepleteIconKeywords:Ermüden> deiner Hand hinzu."
  },
  RelicConfig_126673_Desc = {
    Text = "Maximale Handgröße +3. Zeichne die ersten 3 nicht abgeleiteten Befehlskarten auf, die in jeder Runde gespielt werden, und zu Beginn der Runde 3 Runden später, reduziere ihre Arithmetica-Kosten um 1 und füge Kopien mit <DepleteIconKeywords:Ermüden> deiner Hand hinzu."
  },
  RelicConfig_126673_Name = {
    Text = "Vorherbestimmtes Rad"
  },
  RelicConfig_126673_StoryDesc = {
    Text = "Für immer dreht sich das Rad."
  },
  RelicConfig_129304_BattleDesc = {
    Text = "<OrangeQuality:Goldene Harmonie>: „Arithmetica-Harmonie \" erhöht die Arithmetica-Kosten jetzt nur noch um 1. Jedes 1 % Schadenamplifikation erhöht die Tiefe der Erkenntnisforschung um 1 %.\n<OrangeQuality:Dimensionsgeschenk>: Zu Beginn der Erkundung erhältst du zufällig 1 Dimensionsbild-Relikt. Handlimit +2.\n<OrangeQuality:Segensritual>: Die Belohnung für das Besiegen des Anführers in Phase 1 und Phase 2 wird durch eine Auswahl aus 3 gesegneten Relikten ersetzt.\n<RedQuality:Fernreise Müdigkeit>: Alle LP-Regenerationseffekte im Kampf werden um 50 % reduziert. Wenn bei „Verblasste Knochen\"„Bestattung \" gewählt wird, ändert sich der Effekt auf Wiederherstellung von 25 % Max LP.\n<RedQuality:Betäubungszeichen>: Zu Beginn des Kampfes werden der aktuelle Aliemus und die Keyflare aller Erwecker um 50 % reduziert.\n<RedQuality:Ewiger Nachtkorridor>: Zu Beginn der Erkundung wird das Basis-Aliemus und die Keyflare-Obergrenze aller Erwecker um 50 % erhöht."
  },
  RelicConfig_129304_Desc = {
    Text = "<OrangeQuality:Goldene Harmonie>: „Arithmetica-Harmonie \" erhöht die Arithmetica-Kosten jetzt nur noch um 1. Jedes 1 % Schadenamplifikation erhöht die Tiefe der Erkenntnisforschung um 1 %.\n<OrangeQuality:Dimensionsgeschenk>: Zu Beginn der Erkundung erhältst du zufällig 1 Dimensionsbild-Relikt. Handlimit +2.\n<OrangeQuality:Segensritual>: Die Belohnung für das Besiegen des Anführers in Phase 1 und Phase 2 wird durch eine Auswahl aus 3 gesegneten Relikten ersetzt.\n<RedQuality:Fernreise Müdigkeit>: Alle LP-Regenerationseffekte im Kampf werden um 50 % reduziert. Wenn bei „Verblasste Knochen\"„Bestattung \" gewählt wird, ändert sich der Effekt auf Wiederherstellung von 25 % Max LP.\n<RedQuality:Betäubungszeichen>: Zu Beginn des Kampfes werden der aktuelle Aliemus und die Keyflare aller Erwecker um 50 % reduziert.\n<RedQuality:Ewiger Nachtkorridor>: Zu Beginn der Erkundung wird das Basis-Aliemus und die Keyflare-Obergrenze aller Erwecker um 50 % erhöht."
  },
  RelicConfig_129304_Name = {
    Text = "<OrangeQuality:Kleine“N“Chaos-Kamera>"
  },
  RelicConfig_129304_StoryDesc = {
    Text = "Verdammtes! Die Kamera ist völlig kaputt! Hä? Wie kann sie noch funktionieren? Moment mal! Was sind das für Einschränkungen?!"
  },
  RelicConfig_129305_BattleDesc = {
    Text = "<OrangeQuality:Goldene Harmonie>: „Arithmetica-Harmonie \" erhöht die Arithmetica-Kosten jetzt nur noch um 1. Jedes 1 % Schadenamplifikation erhöht die Tiefe der Erkenntnisforschung um 1 %.\n<RedQuality:Fernreise Müdigkeit>: Alle LP-Regenerationseffekte im Kampf werden um 50 % reduziert. Wenn bei „Verblasste Knochen\"„Bestattung \" gewählt wird, ändert sich der Effekt auf Wiederherstellung von 25 % Max LP."
  },
  RelicConfig_129305_Desc = {
    Text = "<OrangeQuality:Goldene Harmonie>: „Arithmetica-Harmonie \" erhöht die Arithmetica-Kosten jetzt nur noch um 1. Jedes 1 % Schadenamplifikation erhöht die Tiefe der Erkenntnisforschung um 1 %.\n<RedQuality:Fernreise Müdigkeit>: Alle LP-Regenerationseffekte im Kampf werden um 50 % reduziert. Wenn bei „Verblasste Knochen\"„Bestattung \" gewählt wird, ändert sich der Effekt auf Wiederherstellung von 25 % Max LP."
  },
  RelicConfig_129305_Name = {
    Text = "<OrangeQuality:Vollständige Kamera von “N“>"
  },
  RelicConfig_129305_StoryDesc = {
    Text = "Schau nicht mehr, das ist die Kamera! Brandneu aus der Fabrik, faire Preise, keine Tricks."
  },
  RelicConfig_129306_BattleDesc = {
    Text = "<OrangeQuality:Goldene Harmonie>: „Arithmetica-Harmonie \" erhöht die Arithmetica-Kosten jetzt nur noch um 1. Jedes 1 % Schadenamplifikation erhöht die Tiefe der Erkenntnisforschung um 1 %.\n<OrangeQuality:Dimensionsgeschenk>: Zu Beginn der Erkundung erhältst du zufällig 1 Dimensionsbild-Relikt. Handlimit +1.\n<RedQuality:Fernreise Müdigkeit>: Alle LP-Regenerationseffekte im Kampf werden um 50 % reduziert. Wenn bei „Verblasste Knochen\"„Bestattung \" gewählt wird, ändert sich der Effekt auf Wiederherstellung von 25 % Max LP.\n<RedQuality:Betäubungszeichen>: Zu Beginn des Kampfes werden der aktuelle Aliemus und die Keyflare aller Erwecker um 50 % reduziert."
  },
  RelicConfig_129306_Desc = {
    Text = "<OrangeQuality:Goldene Harmonie>: „Arithmetica-Harmonie \" erhöht die Arithmetica-Kosten jetzt nur noch um 1. Jedes 1 % Schadenamplifikation erhöht die Tiefe der Erkenntnisforschung um 1 %.\n<OrangeQuality:Dimensionsgeschenk>: Zu Beginn der Erkundung erhältst du zufällig 1 Dimensionsbild-Relikt. Handlimit +1.\n<RedQuality:Fernreise Müdigkeit>: Alle LP-Regenerationseffekte im Kampf werden um 50 % reduziert. Wenn bei „Verblasste Knochen\"„Bestattung \" gewählt wird, ändert sich der Effekt auf Wiederherstellung von 25 % Max LP.\n<RedQuality:Betäubungszeichen>: Zu Beginn des Kampfes werden der aktuelle Aliemus und die Keyflare aller Erwecker um 50 % reduziert."
  },
  RelicConfig_129306_Name = {
    Text = "<OrangeQuality:Alte Kamera von “N“>"
  },
  RelicConfig_129306_StoryDesc = {
    Text = "Verdammt! Die Kamera ist kaputt! Lass mich mal schauen, ob ich sie reparieren kann... Sie ist eingeschaltet! Aber es fühlt sich irgendwie seltsam an..."
  },
  RelicConfig_131079_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Mosk [Arg1] Aliemus. Die erste „Aufladen!\" oder „Laden!\" in jeder Runde wirkt 2 Mal."
  },
  RelicConfig_131079_Desc = {
    Text = "Zu Rundenbeginn erhält Mosk [Arg1] Aliemus. Die erste „Aufladen!\" oder „Laden!\" in jeder Runde wirkt 2 Mal."
  },
  RelicConfig_131079_Name = {
    Text = "<OrangeQuality:Dimensionsbild·Mosk>"
  },
  RelicConfig_131080_BattleDesc = {
    Text = "Zu Beginn der ersten 3 Runden wird „Otterdilemma\" einmal pro Runde aktiviert. Zu Beginn der 5. Runde entferne alle negativen Effekte von „Otterdilemma\" und erhalte „<DerivativeCardKeywords_135:Nachfolgeaufprall!>\"."
  },
  RelicConfig_131080_Desc = {
    Text = "Zu Beginn der ersten 3 Runden wird „Otterdilemma\" einmal pro Runde aktiviert. Zu Beginn der 5. Runde entferne alle negativen Effekte von „Otterdilemma\" und erhalte „<DerivativeCardKeywords_135:Nachfolgeaufprall!>\"."
  },
  RelicConfig_131080_Name = {
    Text = "Kohleball, der Zweite"
  },
  RelicConfig_131080_StoryDesc = {
    Text = "Frau Mosk sagte streng, das ist das Relikt. \n„Bösewicht, beiß ihn!\""
  },
  RelicConfig_131178_BattleDesc = {
    Text = "Zu Beginn des Kampfes wird eine „<DerivativeCardKeywords_134:Verbotene Wahrheit>\" ins Deck gemischt. Ziehen +[Arg1] pro Zug. Nach dem Spielen einer Befehlskarte wird [Arg2] Befehlskarten in der Hand des Gegners zufällig <ErosionColorInkKeywords:Wahrnehmungsverzerrung> gewährt."
  },
  RelicConfig_131178_Desc = {
    Text = "Zu Beginn des Kampfes wird eine „<DerivativeCardKeywords_134:Verbotene Wahrheit>\" ins Deck gemischt. Ziehen +[Arg1] pro Zug. Nach dem Spielen einer Befehlskarte wird [Arg2] Befehlskarten in der Hand des Gegners zufällig <ErosionColorInkKeywords:Wahrnehmungsverzerrung> gewährt."
  },
  RelicConfig_131178_Name = {
    Text = "Ozean-Notizen"
  },
  RelicConfig_131178_StoryDesc = {
    Text = "Die aufgezeichneten Inhalte enthalten siebzig Mason-Primzahlen."
  },
  RelicConfig_132540_BattleDesc = {
    Text = "Schaden immun"
  },
  RelicConfig_132540_Name = {
    Text = "Sammlungstest-Artefakt"
  },
  RelicConfig_13740_BattleDesc = {
    Text = "Kritische Rate +15%. Zu Beginn der Runde, wenn das Leben unter 25% ([Arg1]) liegt, erhöht sich die kritische Rate in dieser Runde um 30%"
  },
  RelicConfig_13740_Desc = {
    Text = "Kritische Rate +15%. Zu Beginn der Runde, wenn das Leben unter 25% liegt, erhöht sich die kritische Rate in dieser Runde um 30%"
  },
  RelicConfig_13740_Name = {
    Text = "<OrangeQuality:Astrolabium der Geheimnisse>"
  },
  RelicConfig_13740_StoryDesc = {
    Text = "Die Geheimnisse des Universums"
  },
  RelicConfig_13741_BattleDesc = {
    Text = "Kritischer Schaden +15%. Schaden gegen Gegner mit Schild ist garantiert kritisch"
  },
  RelicConfig_13741_Desc = {
    Text = "Kritischer Schaden +15%. Schaden gegen Gegner mit Schild ist garantiert kritisch"
  },
  RelicConfig_13741_Name = {
    Text = "<WhiteQuality:Ästhetik>"
  },
  RelicConfig_13741_StoryDesc = {
    Text = "Wachsbildner: Der Helfer des Arztes, der Gast des Bestattungsunternehmers, der Ernährer der Grabkäfer"
  },
  RelicConfig_13742_BattleDesc = {
    Text = "Kritischer Schaden +50%. Jeder dritte ANG ist garantiert kritisch"
  },
  RelicConfig_13742_Desc = {
    Text = "Kritischer Schaden +50%. Jeder dritte ANG ist garantiert kritisch"
  },
  RelicConfig_13742_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Meditation“>"
  },
  RelicConfig_13743_BattleDesc = {
    Text = "Zu Rundenbeginn erhält das am wenigsten wahnsinnige Erweckungswesen 15 Wahnsinn. Wenn Sie 2 Mal hintereinander eine Karte mit niedrigerem Arithmetica-Verbrauch spielen, erhält das am wenigsten wahnsinnige Erweckungswesen 15 Wahnsinn"
  },
  RelicConfig_13743_Desc = {
    Text = "Zu Rundenbeginn erhält das am wenigsten wahnsinnige Erweckungswesen 15 Wahnsinn. Wenn Sie 2 Mal hintereinander eine Karte mit niedrigerem Arithmetica-Verbrauch spielen, erhält das am wenigsten wahnsinnige Erweckungswesen 15 Wahnsinn"
  },
  RelicConfig_13743_Name = {
    Text = "<OrangeQuality:Arcana-Relikt>"
  },
  RelicConfig_13743_StoryDesc = {
    Text = "Ende des Schicksals"
  },
  RelicConfig_13744_BattleDesc = {
    Text = "Zu Beginn der Runde erhält das Erwachte mit dem niedrigsten Wahnsinn 15 Wahnsinn"
  },
  RelicConfig_13744_Desc = {
    Text = "Zu Beginn der Runde erhält das Erwachte mit dem niedrigsten Wahnsinn 15 Wahnsinn"
  },
  RelicConfig_13744_Name = {
    Text = "<WhiteQuality:Lorbeer-Manschettenknöpfe>"
  },
  RelicConfig_13744_StoryDesc = {
    Text = "Silberne Manschettenknöpfe mit Lorbeerblattmuster.\nSie sind fein gearbeitet und glänzend, und sie trugen einst die Freundschaft zweier Kinder"
  },
  RelicConfig_13745_BattleDesc = {
    Text = "Der Effekt des Reichbonus wird auf 50% erhöht, zu Beginn der Stufe wird deine Glücksmarkierung verdoppelt"
  },
  RelicConfig_13745_Desc = {
    Text = "Der Effekt des Reichbonus wird auf 50% erhöht, zu Beginn der Stufe wird deine Glücksmarkierung verdoppelt"
  },
  RelicConfig_13745_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Tiefer Schlaf“>"
  },
  RelicConfig_13747_BattleDesc = {
    Text = "Immunität gegen 1 Tod, nach Auslösung sofort 10% Leben wiederherstellen, nach 3 Auslösungen dauerhaft ungültig"
  },
  RelicConfig_13747_Desc = {
    Text = "Immunität gegen 1 Tod, nach Auslösung sofort 10% Leben wiederherstellen, nach 3 Auslösungen dauerhaft ungültig"
  },
  RelicConfig_13747_Name = {
    Text = "<WhiteQuality:☆Notfallnahrung☆>"
  },
  RelicConfig_13747_StoryDesc = {
    Text = "Nur im Notfall, besser nicht essen"
  },
  RelicConfig_13748_BattleDesc = {
    Text = "Zu Beginn des Kampfes wird bei allen Karten mit einem Verbrauch von 1 dieser aktuellen Arithmetica der Schaden in diesem Kampf um [Arg1] Punkte und der Schild um [Arg2] Punkte erhöht"
  },
  RelicConfig_13748_Desc = {
    Text = "Zu Beginn des Kampfes wird bei allen Karten mit einem Verbrauch von 1 dieser aktuellen Arithmetica der Schaden in diesem Kampf um [Arg1] Punkte und der Schild um [Arg2] Punkte erhöht"
  },
  RelicConfig_13748_Name = {
    Text = "<OrangeQuality:Unschuldige Marie>"
  },
  RelicConfig_13748_StoryDesc = {
    Text = "Logik ist wie ein Cocktail, zu viel davon verliert seinen Nutzen"
  },
  RelicConfig_13749_BattleDesc = {
    Text = "Alle 4 Züge wird der erlittene Aktiv- und Tentakelschaden aller Gegner in dieser Runde verdoppelt. Aber nach der Freisetzung von Verherrlichung in dieser Runde werden alle Erwecker 1 Runde versiegelt"
  },
  RelicConfig_13749_Desc = {
    Text = "Alle 4 Züge wird der erlittene Aktiv- und Tentakelschaden aller Gegner in dieser Runde verdoppelt. Aber nach der Freisetzung von Verherrlichung in dieser Runde werden alle Erwecker 1 Runde versiegelt"
  },
  RelicConfig_13749_Name = {
    Text = "<RedQuality:Knochen des Pfades>"
  },
  RelicConfig_13749_StoryDesc = {
    Text = "Ein heiliger Teil.\nTrotz der Trennung vom Körper sind seine Spuren überall"
  },
  RelicConfig_13750_BattleDesc = {
    Text = "Am Ende der Runde, wenn kein Schild vorhanden ist, erhalte 1 Schicht Immunität gegen einen Schaden <ParcloseIconKeywords:Barriere>. Wirkt nur einmal pro Kampf"
  },
  RelicConfig_13750_Desc = {
    Text = "Am Ende der Runde, wenn kein Schild vorhanden ist, erhalte 1 Schicht Immunität gegen einen Schaden <ParcloseIconKeywords:Barriere>. Wirkt nur einmal pro Kampf"
  },
  RelicConfig_13750_Name = {
    Text = "<WhiteQuality:☆Schmerztabletten☆>"
  },
  RelicConfig_13750_StoryDesc = {
    Text = "Der Effekt ist nicht so dauerhaft"
  },
  RelicConfig_13751_BattleDesc = {
    Text = "Kritische Rate erhöht um 25%, der erste verursachte Schaden pro Runde wird verdoppelt"
  },
  RelicConfig_13751_Desc = {
    Text = "Kritische Rate erhöht um 25%, der erste verursachte Schaden pro Runde wird verdoppelt"
  },
  RelicConfig_13751_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Vertiefung“>"
  },
  RelicConfig_13752_BattleDesc = {
    Text = "Zu Beginn der Runde regenerierst du [Arg1] Leben. Wenn dein Leben unter 50% liegt, regenerierst du [Arg2] Leben"
  },
  RelicConfig_13752_Desc = {
    Text = "Zu Beginn der Runde regenerierst du [Arg1] Leben. Wenn dein Leben unter 50% liegt, regenerierst du [Arg2] Leben"
  },
  RelicConfig_13752_Name = {
    Text = "<WhiteQuality:Blut der Gnade>"
  },
  RelicConfig_13752_StoryDesc = {
    Text = "Es ist süß und vollmundig, mit einem Hauch von Rosenduft"
  },
  RelicConfig_13753_BattleDesc = {
    Text = "Das ist ein wirksames Auftragrelikt"
  },
  RelicConfig_13753_Desc = {
    Text = "Das ist ein wirksames Auftragrelikt"
  },
  RelicConfig_13753_Name = {
    Text = "Aufgabenkreationstest"
  },
  RelicConfig_13753_StoryDesc = {
    Text = "Ergänze den Inhalt des Artefakts"
  },
  RelicConfig_13754_BattleDesc = {
    Text = "Der fünfte Schaden, den du verursachst, ist immer ein kritischer Treffer"
  },
  RelicConfig_13754_Desc = {
    Text = "Der fünfte Schaden, den du verursachst, ist immer ein kritischer Treffer"
  },
  RelicConfig_13754_Name = {
    Text = "<WhiteQuality:Sehhilfe>"
  },
  RelicConfig_13754_StoryDesc = {
    Text = "Jemand fand durch sie die Wahrheit heraus"
  },
  RelicConfig_13755_BattleDesc = {
    Text = "Zu Beginn der Runde, für jede Karte im <DimensionalSpaceIconKeywords:Hyperdimensionalen Raum> erhalte [Arg1] temporäre <PowerIconKeywords:Kraft>, wenn es eine Hyperdimensionale Runde ist, erhalte [Arg2] temporäre <PowerIconKeywords:Kraft>"
  },
  RelicConfig_13755_Desc = {
    Text = "Zu Beginn der Runde, für jede Karte im <DimensionalSpaceIconKeywords:Hyperdimensionalen Raum> erhalte [Arg1] temporäre <PowerIconKeywords:Kraft>, wenn es eine Hyperdimensionale Runde ist, erhalte [Arg2] temporäre <PowerIconKeywords:Kraft>"
  },
  RelicConfig_13755_Name = {
    Text = "<WhiteQuality:Prisma>"
  },
  RelicConfig_13755_StoryDesc = {
    Text = "“Licht besteht aus sieben Farben.“"
  },
  RelicConfig_13756_BattleDesc = {
    Text = "Beim Aufnehmen verliere alle anderen Relikte und erhalte zufällig 2 goldene Relikte"
  },
  RelicConfig_13756_Desc = {
    Text = "Beim Aufnehmen verliere alle anderen Relikte und erhalte zufällig 2 goldene Relikte"
  },
  RelicConfig_13756_Name = {
    Text = "<RedQuality:☆Umgekehrte Betrachtung☆>"
  },
  RelicConfig_13756_StoryDesc = {
    Text = "In seltsamen Epochen sind Blumen die ersten Beobachter der Menschheit.\nBeweg dich nicht, sie bevorzugen ruhige Ausstellungsstücke"
  },
  RelicConfig_13757_BattleDesc = {
    Text = "Die achte Befehlskarte, die du spielst, hat eine doppelte Wirkung"
  },
  RelicConfig_13757_Desc = {
    Text = "Die achte Befehlskarte, die du spielst, hat eine doppelte Wirkung"
  },
  RelicConfig_13757_Name = {
    Text = "<OrangeQuality:Sternenwein>"
  },
  RelicConfig_13757_StoryDesc = {
    Text = "Zwischen den Sternen wandern"
  },
  RelicConfig_13758_BattleDesc = {
    Text = "Beim Aufnehmen erhöht sich die maximale Gesundheit um [Arg1] Punkte, der beim ANG erhaltene Wahnsinn erhöht sich um 2 Punkte"
  },
  RelicConfig_13758_Desc = {
    Text = "Beim Aufnehmen erhöht sich die maximale Gesundheit um [Arg1] Punkte, der beim ANG erhaltene Wahnsinn erhöht sich um 2 Punkte"
  },
  RelicConfig_13758_Name = {
    Text = "<WhiteQuality:Süße Tinte>"
  },
  RelicConfig_13758_StoryDesc = {
    Text = "Man sagt, es sei Teufelsblut, aber hey, probier es mal!"
  },
  RelicConfig_13759_BattleDesc = {
    Text = "Beim Freisetzen von Aelius, wenn ein Feind 1 Schaden verursachen will, wird er mit [Arg1] Schichten<IntoxicationIconKeywords:Gift> belegt"
  },
  RelicConfig_13759_Desc = {
    Text = "Beim Freisetzen von Aelius, wenn ein Feind 1 Schaden verursachen will, wird er mit [Arg1] Schichten<IntoxicationIconKeywords:Gift> belegt"
  },
  RelicConfig_13759_Name = {
    Text = "<WhiteQuality:☆Laserkiefer☆>"
  },
  RelicConfig_13759_StoryDesc = {
    Text = "Die Knochen, in der privaten Sammlung eines Sammlers ausgestellt.\nDer Sammler war besessen von dem schönen Leuchten, bewunderte es Tag und Nacht und verdorrte schließlich, wurde schließlich zu seinem Gleichgesinnten"
  },
  RelicConfig_13760_BattleDesc = {
    Text = "Maximale Arithmetica erhöht sich um 1. Wenn du 2 Mal hintereinander Karten spielst, die eine höhere Arithmetica-Kosten haben als die vorhergehende, erhältst du 1 Arithmetica"
  },
  RelicConfig_13760_Desc = {
    Text = "Maximale Arithmetica erhöht sich um 1. Wenn du 2 Mal hintereinander Karten spielst, die eine höhere Arithmetica-Kosten haben als die vorhergehende, erhältst du 1 Arithmetica"
  },
  RelicConfig_13760_Name = {
    Text = "<OrangeQuality:Arcana-Aufzeichnungen>"
  },
  RelicConfig_13760_StoryDesc = {
    Text = "Verlauf des Schicksals"
  },
  RelicConfig_13761_BattleDesc = {
    Text = "Zu Rundenbeginn, wenn die Anzahl der verbleibenden Handkarten aus der letzten Runde mehr als 3 ist, erhalten Sie 2 Arithmetica"
  },
  RelicConfig_13761_Desc = {
    Text = "Zu Rundenbeginn, wenn die Anzahl der verbleibenden Handkarten aus der letzten Runde mehr als 3 ist, erhalten Sie 2 Arithmetica"
  },
  RelicConfig_13761_Name = {
    Text = "<WhiteQuality:Mythag Emblem>"
  },
  RelicConfig_13761_StoryDesc = {
    Text = "Die Abzeichen, die an die Ermittler der Mythag Universität verteilt werden, symbolisieren nicht nur die Identität des Trägers, sondern dienen auch als Kommunikationsmittel"
  },
  RelicConfig_13762_BattleDesc = {
    Text = "Wenn du „VERT“ spielst, erhalte [Arg1] Punkte <RetaliateIconKeywords: Gegenangriff>"
  },
  RelicConfig_13762_Desc = {
    Text = "Wenn du „VERT“ spielst, erhalte [Arg1] Punkte <RetaliateIconKeywords: Gegenangriff>"
  },
  RelicConfig_13762_Name = {
    Text = "Veränderte Brennnesselweste"
  },
  RelicConfig_13762_StoryDesc = {
    Text = "Unidentifizierbare Flüssigkeit"
  },
  RelicConfig_13763_BattleDesc = {
    Text = "Beim Kampfbeginn [Arg1] Schild erhalten. Zu Rundenbeginn, wenn man Schild hat, Schild- und Heilungseffekte +50%"
  },
  RelicConfig_13763_Desc = {
    Text = "Beim Kampfbeginn [Arg1] Schild erhalten. Zu Rundenbeginn, wenn man Schild hat, Schild- und Heilungseffekte +50%"
  },
  RelicConfig_13763_Name = {
    Text = "Bewahrer des entarteten Gartens"
  },
  RelicConfig_13764_BattleDesc = {
    Text = "Nach dem Aufheben erhält man dauerhaft [Arg1] <PowerIconKeywords:Kraft>"
  },
  RelicConfig_13764_Desc = {
    Text = "Nach dem Aufheben erhält man dauerhaft [Arg1] <PowerIconKeywords:Kraft>"
  },
  RelicConfig_13764_Name = {
    Text = "<WhiteQuality:Rubinbrosche>"
  },
  RelicConfig_13764_StoryDesc = {
    Text = "Rotes Blut sickert durch"
  },
  RelicConfig_13766_BattleDesc = {
    Text = "Beim Aufheben wählt man eine Karte und verleiht ihr zwei dreifach verstärkende Effekte. (Hinweis: Ähnlich wie tausend Fata Morgana Karten.)"
  },
  RelicConfig_13766_Desc = {
    Text = "Beim Aufheben wählt man eine Karte und verleiht ihr zwei dreifach verstärkende Effekte. (Hinweis: Ähnlich wie tausend Fata Morgana Karten.)"
  },
  RelicConfig_13766_Name = {
    Text = "<OrangeQuality:☆Meister-Schreibmaschine☆>"
  },
  RelicConfig_13766_StoryDesc = {
    Text = "Es gibt Gerüchte, dass die wahren Meisterwerke von Schreibmaschinen geschrieben wurden"
  },
  RelicConfig_13767_BattleDesc = {
    Text = "Beim Aufheben erhält man 3 aus 1 zufällige fortgeschrittene Gebete und verleiht sie der entsprechenden Karte"
  },
  RelicConfig_13767_Desc = {
    Text = "Beim Aufheben erhält man 3 aus 1 zufällige fortgeschrittene Gebete und verleiht sie der entsprechenden Karte"
  },
  RelicConfig_13767_Name = {
    Text = "<WhiteQuality:Reindes Papyrus>"
  },
  RelicConfig_13767_StoryDesc = {
    Text = "Hier ist die Frage: 10 Mönche teilen 6 Brote, wie viel bekommt jeder?"
  },
  RelicConfig_13768_BattleDesc = {
    Text = "Max Arithmetica erhöht sich um 2. Nachdem du “Schlag“ oder “VERT“ gespielt hast, erhält der entsprechende Erwecker 5 Punkte Aliemus. Nach der Freigabe der Verherrlichung erhältst du 1 “Schlag“-Karte mit Nichtigkeitskosten für den entsprechenden Erwecker. Nach der Freigabe der Posse erhältst du zufällig 1 “VERT“-Karte mit Nichtigkeitskosten."
  },
  RelicConfig_13768_Desc = {
    Text = "Max Arithmetica erhöht sich um 2. Nachdem du “Schlag“ oder “VERT“ gespielt hast, erhält der entsprechende Erwecker 5 Punkte Aliemus. Nach der Freigabe der Verherrlichung erhältst du 1 “Schlag“-Karte mit Nichtigkeit-Verbrauch des entsprechenden Erweckers, nach der Freigabe der Posse erhältst du zufällig 1 “VERT“-Karte mit Nichtigkeit-Verbrauch."
  },
  RelicConfig_13768_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Flügel“>"
  },
  RelicConfig_13769_BattleDesc = {
    Text = "Zu Rundenbeginn <EmbryoFusionIconKeywords:Embryofusion> +30. Alle Ihre <DevouredIconKeywords:Verschlingen>-Effekte werden zu <UnlimitedDevouredIconKeywords:Unendlichem Verschlingen>"
  },
  RelicConfig_13769_Desc = {
    Text = "Zu Rundenbeginn <EmbryoFusionIconKeywords:Embryofusion> +30. Alle Ihre <DevouredIconKeywords:Verschlingen>-Effekte werden zu <UnlimitedDevouredIconKeywords:Unendlichem Verschlingen>"
  },
  RelicConfig_13769_Name = {
    Text = "<RedQuality:Wimmelnde Nabelschnur>"
  },
  RelicConfig_13769_StoryDesc = {
    Text = "Um den Hals gewickelt"
  },
  RelicConfig_13770_BattleDesc = {
    Text = "Zu Beginn der Runde erhalte [Arg1] Schild, und erhöhe diesen Schildwert jede Runde um [Arg2]"
  },
  RelicConfig_13770_Desc = {
    Text = "Zu Beginn der Runde erhalte [Arg1] Schild, und erhöhe diesen Schildwert jede Runde um [Arg2]"
  },
  RelicConfig_13770_Name = {
    Text = "<WhiteQuality:Schutzhand>"
  },
  RelicConfig_13770_StoryDesc = {
    Text = "Segnende Hand, feste Faust"
  },
  RelicConfig_13771_BattleDesc = {
    Text = "Die Silber-Schlüsselaufladung aller Erwecker erhöht sich um 30. Nach dem Freisetzen der Bande mischen 3 Karten <DerivativeCardKeywords_4:„Inspiration“> in dein Deck"
  },
  RelicConfig_13771_Desc = {
    Text = "Die Silber-Schlüsselaufladung aller Erwecker erhöht sich um 30. Nach dem Freisetzen der Bande mischen 3 Karten <DerivativeCardKeywords_4:„Inspiration“> in dein Deck"
  },
  RelicConfig_13771_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Leichter Schlaf“>"
  },
  RelicConfig_13772_BattleDesc = {
    Text = "Nach Kampfende zusätzliche 75 schwarze Siegel und 1 Symptomkarte erhalten"
  },
  RelicConfig_13772_Desc = {
    Text = "Nach Kampfende zusätzliche 75 schwarze Siegel und 1 Symptomkarte erhalten"
  },
  RelicConfig_13772_Name = {
    Text = "<RedQuality:Jadeabdruck>"
  },
  RelicConfig_13772_StoryDesc = {
    Text = "Dieser Abdruck ist tausend Jahre unvergänglich"
  },
  RelicConfig_13773_BattleDesc = {
    Text = "Für jeden verursachten aktiven Schaden fügst du dir selbst [Arg1] Schichten <BleedingIconKeywords:Bluten> hinzu und fügst dem beschädigten Ziel [Arg2] Schichten <BleedingIconKeywords:Bluten> hinzu. Für jeden getöteten Gegner wird der <BleedingIconKeywords:Bluten> Zustand bei dir dispergiert"
  },
  RelicConfig_13773_Desc = {
    Text = "Für jeden verursachten aktiven Schaden fügst du dir selbst [Arg1] Schichten <BleedingIconKeywords:Bluten> hinzu und fügst dem beschädigten Ziel [Arg2] Schichten <BleedingIconKeywords:Bluten> hinzu. Für jeden getöteten Gegner wird der <BleedingIconKeywords:Bluten> Zustand bei dir dispergiert"
  },
  RelicConfig_13773_Name = {
    Text = "<RedQuality:Schwarmbewusstsein>"
  },
  RelicConfig_13773_StoryDesc = {
    Text = "Verflechten, symbiotisch, gruppieren; Angst, Unbekanntes, Kontrolle"
  },
  RelicConfig_13774_BattleDesc = {
    Text = "Wenn du eine Karte spielst, die tatsächlich 3 Arithmetica kostet, ziehe 1 Karte und erhalte 2 Arithmetica; wenn du eine Karte spielst, die tatsächlich 4 oder mehr Arithmetica kostet, sinken die Arithmetica Kosten anderer Handkarten um 1"
  },
  RelicConfig_13774_Desc = {
    Text = "Wenn du eine Karte spielst, die tatsächlich 3 Arithmetica kostet, ziehe 1 Karte und erhalte 2 Arithmetica; wenn du eine Karte spielst, die tatsächlich 4 oder mehr Arithmetica kostet, sinken die Arithmetica Kosten anderer Handkarten um 1"
  },
  RelicConfig_13774_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Auge“>"
  },
  RelicConfig_13775_BattleDesc = {
    Text = "Nach dem Aufheben wähle eine Befehlskarte, um ihr „angeboren“, „behalten“ und „nach dem Ausspielen eine Karte ziehen“ zu verleihen"
  },
  RelicConfig_13775_Desc = {
    Text = "Nach dem Aufheben wähle eine Befehlskarte, um ihr „angeboren“, „behalten“ und „nach dem Ausspielen eine Karte ziehen“ zu verleihen"
  },
  RelicConfig_13775_Name = {
    Text = "<WhiteQuality:Aktenordner>"
  },
  RelicConfig_13775_StoryDesc = {
    Text = "Pssst, das ist ein geheimes Geschäft, das nur dir und mir gehört"
  },
  RelicConfig_13776_BattleDesc = {
    Text = "Nach Kampfbeginn erhältst du 1 Tentakel"
  },
  RelicConfig_13776_Desc = {
    Text = "Nach Kampfbeginn erhältst du 1 Tentakel"
  },
  RelicConfig_13776_Name = {
    Text = "<WhiteQuality:Gelbe Schnecke>"
  },
  RelicConfig_13776_StoryDesc = {
    Text = "Diese kleine gelbe Schnecke stammt aus edlem Hause, mit perfektem, makellosem Hintergrund"
  },
  RelicConfig_13777_BattleDesc = {
    Text = "Bei ungeraden Runden, wenn es verbleibende Arithmetica gibt, ziehst du 2 zusätzliche Karten in der nächsten Runde; bei geraden Runden, wenn es verbleibende Handkarten gibt, erhältst du 2 zusätzliche Arithmetica in der nächsten Runde"
  },
  RelicConfig_13777_Desc = {
    Text = "Bei ungeraden Runden, wenn es verbleibende Arithmetica gibt, ziehst du 2 zusätzliche Karten in der nächsten Runde; bei geraden Runden, wenn es verbleibende Handkarten gibt, erhältst du 2 zusätzliche Arithmetica in der nächsten Runde"
  },
  RelicConfig_13777_Name = {
    Text = "<OrangeQuality:Sonnen-Mond-Rad>"
  },
  RelicConfig_13777_StoryDesc = {
    Text = "Rate mal, schwarz oder weiß?"
  },
  RelicConfig_13778_BattleDesc = {
    Text = "Tentakelobergrenze erhöht sich um 1. Wenn die Gesundheit unter 50% liegt, <TentacleInjurieIconKeywords:Tentakelschaden> erhöht sich um [Arg1]"
  },
  RelicConfig_13778_Desc = {
    Text = "Tentakelobergrenze erhöht sich um 1. Wenn die Gesundheit unter 50% liegt, <TentacleInjurieIconKeywords:Tentakelschaden> erhöht sich um [Arg1]"
  },
  RelicConfig_13778_Name = {
    Text = "<OrangeQuality:Lied der See>"
  },
  RelicConfig_13778_StoryDesc = {
    Text = "Es wird gesagt, dass ungenießbare Tiere wie das Gewebe-Nudelkrebse etwa 80% der Nährstoffe aus dem Ozean aufnehmen"
  },
  RelicConfig_13779_BattleDesc = {
    Text = "Zu Beginn der Runde ziehe 1 Karte, am Ende der Runde kannst du 1 Handkarte behalten"
  },
  RelicConfig_13779_Desc = {
    Text = "Zu Beginn der Runde ziehe 1 Karte, am Ende der Runde kannst du 1 Handkarte behalten"
  },
  RelicConfig_13779_Name = {
    Text = "<OrangeQuality:Propheten-Wunschlampe>"
  },
  RelicConfig_13779_StoryDesc = {
    Text = "Erfülle deinen Wunsch"
  },
  RelicConfig_13780_BattleDesc = {
    Text = "Nach jeder Auslösung von Verherrlichung erhältst du 1 Karte <DerivativeCardKeywords_7:“Giftige Infusion“>. Wenn du 3 Karten <DerivativeCardKeywords_7:“Giftige Infusion“> in deiner Hand hast, kombiniere sie zu einer Karte, die <IntoxicationIconKeywords:Gift> auslöst, <DerivativeCardKeywords_8:“Giftiger Ausbruch“>."
  },
  RelicConfig_13780_Desc = {
    Text = "Nach jeder Auslösung von Verherrlichung erhältst du 1 Karte <DerivativeCardKeywords_7:“Giftige Infusion“>. Wenn du 3 Karten <DerivativeCardKeywords_7:“Giftige Infusion“> in der Hand hast, kombiniere sie zu einer Karte, die <IntoxicationIconKeywords:Gift> auslöst, <DerivativeCardKeywords_8:“Giftiger Ausbruch“>."
  },
  RelicConfig_13780_Name = {
    Text = "<OrangeQuality:Seltsame Zunge>"
  },
  RelicConfig_13780_StoryDesc = {
    Text = "Er ist kein Dämon, aber er flüstert von jenseits der Welt"
  },
  RelicConfig_13781_BattleDesc = {
    Text = "Für jeden verbrauchten schwarzen Siegel erhält jeder Erwecker 1 Punkt Aelius"
  },
  RelicConfig_13781_Desc = {
    Text = "Für jeden verbrauchten schwarzen Siegel erhält jeder Erwecker 1 Punkt Aelius"
  },
  RelicConfig_13781_Name = {
    Text = "Umgekehrte Blume"
  },
  RelicConfig_13782_BattleDesc = {
    Text = "Schaden immun"
  },
  RelicConfig_13782_Desc = {
    Text = "Schaden immun"
  },
  RelicConfig_13782_Name = {
    Text = "Testschöpfung"
  },
  RelicConfig_13783_BattleDesc = {
    Text = "Nach der 3. gespielten Karte jeder Runde lege 1 <DerivativeCardKeywords_4:„Inspiration“> in den Ablagestapel. Nach der 6. gespielten Karte füge 1 <DerivativeCardKeywords_4:„Inspiration“> aus dem Ablagestapel der Hand hinzu"
  },
  RelicConfig_13783_Desc = {
    Text = "Nach der 3. gespielten Karte jeder Runde lege 1 <DerivativeCardKeywords_4:„Inspiration“> in den Ablagestapel. Nach der 6. gespielten Karte füge 1 <DerivativeCardKeywords_4:„Inspiration“> aus dem Ablagestapel der Hand hinzu"
  },
  RelicConfig_13783_Name = {
    Text = "<WhiteQuality:Licht der Zivilisation>"
  },
  RelicConfig_13783_StoryDesc = {
    Text = "Ein Meteor, der die Nacht durchbricht"
  },
  RelicConfig_13784_BattleDesc = {
    Text = "Zu Beginn jeder Runde erhält man für jeden Gegner 1 Arithmetica. Wenn man einen Gegner mit aktivem Schaden tötet, erleidet ein anderer Gegner die gleiche Menge an übermäßigem Schaden durch <BleedingIconKeywords:Bluten>"
  },
  RelicConfig_13784_Desc = {
    Text = "Zu Beginn jeder Runde erhält man für jeden Gegner 1 Arithmetica. Wenn man einen Gegner mit aktivem Schaden tötet, erleidet ein anderer Gegner die gleiche Menge an übermäßigem Schaden durch <BleedingIconKeywords:Bluten>"
  },
  RelicConfig_13784_Name = {
    Text = "<OrangeQuality:Lied der Massen>"
  },
  RelicConfig_13784_StoryDesc = {
    Text = "Geboren, um deine Ohren zu quälen"
  },
  RelicConfig_13785_BattleDesc = {
    Text = "Beim Ende der Runde <EmbryoFusionIconKeywords:Embryofusion> +15, wenn sich <DerivativeCardKeywords_2:„Embryo\"> in der Hand befindet, stelle [Arg1] LP wieder her."
  },
  RelicConfig_13785_Desc = {
    Text = "Beim Ende der Runde <EmbryoFusionIconKeywords:Embryofusion> +15, wenn sich <DerivativeCardKeywords_2:„Embryo\"> in der Hand befindet, stelle [Arg1] LP wieder her."
  },
  RelicConfig_13785_Name = {
    Text = "<WhiteQuality:Pestdiagnose>"
  },
  RelicConfig_13785_StoryDesc = {
    Text = "Pest—ein zufälliger Ausdruck der unbewussten Unruhe der Natur"
  },
  RelicConfig_13786_BattleDesc = {
    Text = "Nach der Freisetzung von Exaltieren erhältst du [Arg1] Punkte temporäre <PowerIconKeywords:Macht>"
  },
  RelicConfig_13786_Desc = {
    Text = "Nach der Freisetzung von Exaltieren erhältst du [Arg1] Punkte temporäre <PowerIconKeywords:Macht>"
  },
  RelicConfig_13786_Name = {
    Text = "<WhiteQuality:Schweres Schloss>"
  },
  RelicConfig_13786_StoryDesc = {
    Text = "Eine dicke und solide Sperre, ohne Schlüssel schwer zu öffnen.\nNatürlich ist das für einen Meisterdieb kein Problem"
  },
  RelicConfig_13787_BattleDesc = {
    Text = "Zu Beginn des Zuges füge einem zufälligen Gegner [Arg1] <FixedDamage:Reinen SCH> zu. Nachdem „Schlag“ in diesem Kampf 7 Mal gespielt wurde, ändert sich der zugefügte SCH auf [Arg2]. Nachdem „Schlag“ 21 Mal gespielt wurde, füge sofort allen Gegnern [Arg3] <FixedDamage:Reinen SCH> zu."
  },
  RelicConfig_13787_Desc = {
    Text = "Zu Beginn des Zuges füge einem zufälligen Gegner [Arg1] <FixedDamage:Reinen SCH> zu. Nachdem „Schlag“ in diesem Kampf 7 Mal gespielt wurde, ändert sich der zugefügte SCH auf [Arg2]. Nachdem „Schlag“ 21 Mal gespielt wurde, füge sofort allen Gegnern [Arg3] <FixedDamage:Reinen SCH> zu."
  },
  RelicConfig_13787_Name = {
    Text = "<OrangeQuality:Altes Puzzle>"
  },
  RelicConfig_13787_StoryDesc = {
    Text = "Ein Kunstwerk, das einst in einem schweren Rahmen eingefasst war, fehlte seit dem Tag der Ausstellung ein Stück"
  },
  RelicConfig_13788_BattleDesc = {
    Text = "Obergrenze der Krakenarme um 2 verringert. Am Rundenende greifen alle Krakenarme einmal zusätzlich an"
  },
  RelicConfig_13788_Desc = {
    Text = "Obergrenze der Krakenarme um 2 verringert. Am Rundenende greifen alle Krakenarme einmal zusätzlich an"
  },
  RelicConfig_13788_Name = {
    Text = "<RedQuality:Heiliger Schmerzarm>"
  },
  RelicConfig_13788_StoryDesc = {
    Text = "Genieße den Schmerz"
  },
  RelicConfig_13789_BattleDesc = {
    Text = "Jedes Mal, wenn das Deck neu gemischt wird, erhält man [Arg1] <PowerIconKeywords:Stärke>"
  },
  RelicConfig_13789_Desc = {
    Text = "Jedes Mal, wenn das Deck neu gemischt wird, erhält man [Arg1] <PowerIconKeywords:Stärke>"
  },
  RelicConfig_13789_Name = {
    Text = "<WhiteQuality:Weinende Pfeife>"
  },
  RelicConfig_13789_StoryDesc = {
    Text = "Ist das das Ergebnis von Hass oder Rache?"
  },
  RelicConfig_13790_BattleDesc = {
    Text = "Bei jeder Bewegung auf der Karte erhält man 10 schwarze Siegel, jedoch erhöht der geistige Druck durch die Kartenbewegung um 10 Punkte"
  },
  RelicConfig_13790_Desc = {
    Text = "Bei jeder Bewegung auf der Karte erhält man 10 schwarze Siegel, jedoch erhöht der geistige Druck durch die Kartenbewegung um 10 Punkte"
  },
  RelicConfig_13790_Name = {
    Text = "Bodenloser Beutel"
  },
  RelicConfig_13791_BattleDesc = {
    Text = "Beim Aufheben dieses Artefakts wählt man eine Befehlskarte und fügt eine Kopie davon dem Deck hinzu"
  },
  RelicConfig_13791_Desc = {
    Text = "Beim Aufheben dieses Artefakts wählt man eine Befehlskarte und fügt eine Kopie davon dem Deck hinzu"
  },
  RelicConfig_13791_Name = {
    Text = "<WhiteQuality:Flüchtiges Feuer>"
  },
  RelicConfig_13791_StoryDesc = {
    Text = "Flackerndes Licht, schwache Hoffnung"
  },
  RelicConfig_13792_BattleDesc = {
    Text = "Jedes Mal, wenn du LP verlierst, <EmbryoFusionIconKeywords:Embryofusion>+10. Wenn die LP unter 50 % fallen, wird der Effekt verdoppelt."
  },
  RelicConfig_13792_Desc = {
    Text = "Jedes Mal, wenn du LP verlierst, <EmbryoFusionIconKeywords:Embryofusion>+10. Wenn die LP unter 50 % fallen, wird der Effekt verdoppelt."
  },
  RelicConfig_13792_Name = {
    Text = "<WhiteQuality:Rostige Metallsäge>"
  },
  RelicConfig_13792_StoryDesc = {
    Text = "Der Anatom sieht in seinem Leben keine schönen Frauen, nur einen Sack voller Knochen, entzündete Nerven durch Krankheiten, Muskeln und Gewebe"
  },
  RelicConfig_13793_BattleDesc = {
    Text = "Beim Aufheben wird der Siegelertrag der Gruppe auf 150 % des ursprünglichen Wertes erhöht. Nach der Wiederherstellung von Lebenspunkten erhalten alle Erwecker 3 Punkte Aliemus; nach dem Verlust von Lebenspunkten erhält man [Arg1] Punkte <PowerIconKeywords:Stärke> und Tentakelschaden, maximal 5 Mal pro Runde."
  },
  RelicConfig_13793_Desc = {
    Text = "Beim Aufheben wird der Ertrag an schwarzen Malen der Gruppe auf 150 % des ursprünglichen Wertes erhöht. Nach der Wiederherstellung von Lebenspunkten erhalten alle Erwecker 3 Punkte Aliemus; nach dem Verlust von Lebenspunkten erhältst du [Arg1] Punkte <PowerIconKeywords:Stärke> und Tentakelschaden, der insgesamt maximal 5 Mal pro Runde wirksam wird."
  },
  RelicConfig_13793_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Mond“>"
  },
  RelicConfig_13794_BattleDesc = {
    Text = "Nach dem Ende der Runde erhalten alle Erwecker 5 Wahnsinn. Für jeden verbleibenden Punkt Arithmetica erhalten alle Erwecker zusätzlich 3 Wahnsinn"
  },
  RelicConfig_13794_Desc = {
    Text = "Nach dem Ende der Runde erhalten alle Erwecker 5 Wahnsinn. Für jeden verbleibenden Punkt Arithmetica erhalten alle Erwecker zusätzlich 3 Wahnsinn"
  },
  RelicConfig_13794_Name = {
    Text = "<OrangeQuality:Prototyp-Batterie>"
  },
  RelicConfig_13794_StoryDesc = {
    Text = "Tragbare Hoffnung"
  },
  RelicConfig_13795_BattleDesc = {
    Text = "Maximale Arithmetica erhöht sich um 1"
  },
  RelicConfig_13795_Desc = {
    Text = "Maximale Arithmetica erhöht sich um 1"
  },
  RelicConfig_13795_Name = {
    Text = "<WhiteQuality:Aktivinjektor>"
  },
  RelicConfig_13795_StoryDesc = {
    Text = "Zuckungen sind auch eine Form von Aktivität"
  },
  RelicConfig_13796_BattleDesc = {
    Text = "Wenn die Lebenspunkte unter 50% am Ende des Kampfes liegen, zu einem Silberrelikt aufwerten"
  },
  RelicConfig_13796_Desc = {
    Text = "Wenn die LP am Ende des Kampfes unter 50 % liegen, zu einer Silbernen Schöpfung aufwerten."
  },
  RelicConfig_13796_Name = {
    Text = "Altes Notizbuch 2"
  },
  RelicConfig_13796_StoryDesc = {
    Text = "Ein altes Tagebuch, vollgestopft mit Beilagen, enthält auf den ersten Blick Karten von Elworth, Experimentaufzeichnungen und Briefe mit Dreieckskorrosionsspuren.\nDie Schrift am Anfang ist ordentlich, wird aber zunehmend schlampig"
  },
  RelicConfig_13797_BattleDesc = {
    Text = "Nachdem du 3 ANGskarten gespielt hast, werde ein goldenes Relikt"
  },
  RelicConfig_13797_Desc = {
    Text = "Spiele 3 Schlagkarten, um zu einer Goldenen Kreation aufzusteigen."
  },
  RelicConfig_13797_Name = {
    Text = "Altes Notizbuch 1"
  },
  RelicConfig_13797_StoryDesc = {
    Text = "Ein altes Tagebuch, vollgestopft mit Beilagen, enthält auf den ersten Blick Karten von Elworth, Experimentaufzeichnungen und Briefe mit Dreieckskorrosionsspuren.\nDie Schrift am Anfang ist ordentlich, wird aber zunehmend schlampig"
  },
  RelicConfig_13798_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhalten alle deine symptomatischen Karten <NothingnessIconKeywords: Nichtigkeit>, und für jede symptomatische Karte im Deck erhältst du [Arg1] <PowerIconKeywords: Kraft>"
  },
  RelicConfig_13798_Desc = {
    Text = "Zu Beginn des Kampfes erhalten alle deine symptomatischen Karten <NothingnessIconKeywords: Nichtigkeit>, und für jede symptomatische Karte im Deck erhältst du [Arg1] <PowerIconKeywords: Kraft>"
  },
  RelicConfig_13798_Name = {
    Text = "<WhiteQuality:Harfords Elixier>"
  },
  RelicConfig_13798_StoryDesc = {
    Text = "Unbekannte Droge.\nEs heißt, der berühmte Geiger Erik bevorzugt sie"
  },
  RelicConfig_13799_BattleDesc = {
    Text = "Zu Beginn der ersten Kampfrunde füge <DerivativeCardKeywords_1:„Echo des Schattens“> deiner Hand hinzu; in der zweiten Runde <DerivativeCardKeywords_41:„Silberschlüssel-Resonanz“>; in der dritten Runde <DerivativeCardKeywords_39:„Echo der Vergangenheit“>"
  },
  RelicConfig_13799_Desc = {
    Text = "Zu Beginn der ersten Kampfrunde füge <DerivativeCardKeywords_1:„Echo des Schattens“> deiner Hand hinzu; in der zweiten Runde <DerivativeCardKeywords_41:„Silberschlüssel-Resonanz“>; in der dritten Runde <DerivativeCardKeywords_39:„Echo der Vergangenheit“>"
  },
  RelicConfig_13799_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Sternenhimmel“>"
  },
  RelicConfig_13800_BattleDesc = {
    Text = "Zu Beginn der Runde füge 1 <DerivativeCardKeywords_6: „Sonnenschirm“> zu deiner Hand hinzu. Nachdem du 6 Karten gespielt hast, erhöhe alle <DerivativeCardKeywords_6: „Sonnenschirm“><AlertIconKeywords:Alarm> in deiner Hand um [Arg2]"
  },
  RelicConfig_13800_Desc = {
    Text = "Zu Beginn der Runde füge 1 <DerivativeCardKeywords_6: „Sonnenschirm“> zu deiner Hand hinzu. Nachdem du 6 Karten gespielt hast, erhöhe alle <DerivativeCardKeywords_6: „Sonnenschirm“><AlertIconKeywords:Alarm> in deiner Hand um [Arg2]"
  },
  RelicConfig_13800_Name = {
    Text = "<WhiteQuality:Reiseschirm>"
  },
  RelicConfig_13800_StoryDesc = {
    Text = "Blühen im lichtlosen Land"
  },
  RelicConfig_13801_BattleDesc = {
    Text = "Im regulären Kampf wird das Leben aller Feinde um 30% erhöht, und bei einem Sieg im Kampf erhält man zusätzlich 25 schwarze Siegel"
  },
  RelicConfig_13801_Desc = {
    Text = "Im regulären Kampf wird das Leben aller Feinde um 30% erhöht, und bei einem Sieg im Kampf erhält man zusätzlich 25 schwarze Siegel"
  },
  RelicConfig_13801_Name = {
    Text = "Zerfetzte Kriegsflagge"
  },
  RelicConfig_13802_BattleDesc = {
    Text = "Beim Aufheben erhöht sich die maximale Gesundheit um [Arg1] Punkte. Wenn die Gesundheit beim Aufheben unter 25 % liegt, wird die Erhöhung der maximalen Gesundheit auf [Arg2] Punkte reduziert"
  },
  RelicConfig_13802_Desc = {
    Text = "Beim Aufheben erhöht sich die maximale Gesundheit um [Arg1] Punkte. Wenn die Gesundheit beim Aufheben unter 25 % liegt, wird die Erhöhung der maximalen Gesundheit auf [Arg2] Punkte reduziert"
  },
  RelicConfig_13802_Name = {
    Text = "<WhiteQuality:Ceylon-Tee>"
  },
  RelicConfig_13802_StoryDesc = {
    Text = "Gesunde Ernährung beginnt bei uns"
  },
  RelicConfig_13803_BattleDesc = {
    Text = "Alle 3 Runden erhält man 3 temporäre Tentakel"
  },
  RelicConfig_13803_Desc = {
    Text = "Alle 3 Runden erhält man 3 temporäre Tentakel"
  },
  RelicConfig_13803_Name = {
    Text = "<WhiteQuality:Tauchhelm>"
  },
  RelicConfig_13803_StoryDesc = {
    Text = "Träume sind Sterne und Ozeane!"
  },
  RelicConfig_13804_BattleDesc = {
    Text = "Am Ende der Runde erhalte [Arg1] Schild. Wenn dein Schild 0 oder ein Vielfaches von 3 ist, erhalte [Arg2] <PowerIconKeywords:Stärke>"
  },
  RelicConfig_13804_Desc = {
    Text = "Am Ende der Runde erhalte [Arg1] Schild. Wenn dein Schild 0 oder ein Vielfaches von 3 ist, erhalte [Arg2] <PowerIconKeywords:Stärke>"
  },
  RelicConfig_13804_Name = {
    Text = "<OrangeQuality:Notrufsignal>"
  },
  RelicConfig_13804_StoryDesc = {
    Text = "Er hat keine Rettung bekommen"
  },
  RelicConfig_13806_BattleDesc = {
    Text = "Wenn du eine Symptom-Karte ziehst, erhältst du [Arg1] Punkte temporäre <PowerIconKeywords:Macht>. Für jede verfluchte Relikt erhöhst du deine kritische Rate und deinen kritischen Schaden um 10%"
  },
  RelicConfig_13806_Desc = {
    Text = "Wenn du eine Symptom-Karte ziehst, erhältst du [Arg1] Punkte temporäre <PowerIconKeywords:Macht>. Für jede verfluchte Relikt erhöhst du deine kritische Rate und deinen kritischen Schaden um 10%"
  },
  RelicConfig_13806_Name = {
    Text = "<OrangeQuality:Abyss-Kommunikation>"
  },
  RelicConfig_13806_StoryDesc = {
    Text = "In der menschenleeren Vorstadt klingelte das Telefon in der einsamen Telefonzelle.\n„Dunkel... zisch... endlose... zisch zisch... Dunkelheit...“"
  },
  RelicConfig_13807_BattleDesc = {
    Text = "Zu Beginn des Kampfes <EmbryoFusionIconKeywords:Embryofusion> +50. Für jeden Erweckten Körper, der mindestens 50 Aliemus hat, wird der Effekt einmal zusätzlich aktiviert"
  },
  RelicConfig_13807_Desc = {
    Text = "Zu Beginn des Kampfes <EmbryoFusionIconKeywords:Embryofusion> +50. Für jeden Erweckten Körper, der mindestens 50 Aliemus hat, wird der Effekt einmal zusätzlich aktiviert"
  },
  RelicConfig_13807_Name = {
    Text = "<WhiteQuality:Liebes Kind>"
  },
  RelicConfig_13807_StoryDesc = {
    Text = "Der Tischler fertigte für seine Frau eine lebensechte Puppe an, die ihren Sohn ersetzen und in ihrem Bauch schlafen würde"
  },
  RelicConfig_13808_BattleDesc = {
    Text = "Nachdem Aelius freigesetzt wurde, lege eine zufällige Karte des entsprechenden Erweckers in deine Hand, die Karte erhält <DepleteIconKeywords:erschöpfen> und <NothingnessIconKeywords:Nihil>. Am Ende des Kampfes gewinne [Arg1] Punkte Leben zurück"
  },
  RelicConfig_13808_Desc = {
    Text = "Nachdem Aelius freigesetzt wurde, lege eine zufällige Karte des entsprechenden Erweckers in deine Hand, die Karte erhält <DepleteIconKeywords:erschöpfen> und <NothingnessIconKeywords:Nihil>. Am Ende des Kampfes gewinne [Arg1] Punkte Leben zurück"
  },
  RelicConfig_13808_Name = {
    Text = "<WhiteQuality:Doktor Tasche>"
  },
  RelicConfig_13808_StoryDesc = {
    Text = "Der Reisekoffer, der den Arzt repräsentiert, ist sehr schwer.\n\nWer ihn öffnet, ist möglicherweise kein echter Arzt.\n"
  },
  RelicConfig_13809_BattleDesc = {
    Text = "Alle Schöpfungspreise um 20 gesenkt"
  },
  RelicConfig_13809_Desc = {
    Text = "Alle Schöpfungspreise um 20 gesenkt"
  },
  RelicConfig_13809_Name = {
    Text = "<WhiteQuality:Wortgewandt>"
  },
  RelicConfig_13809_StoryDesc = {
    Text = "Nicht nur Händler sind redegewandt, auch Gläubige"
  },
  RelicConfig_13811_BattleDesc = {
    Text = "Jedes 3. Mal, wenn „Schlag“ gespielt wird, füge allen Gegnern [Arg1] <FixedDamage:Reinen SCH> zu. Der entsprechende Erwecker erhält 15 Aliemus."
  },
  RelicConfig_13811_Desc = {
    Text = "Jedes 3. Mal, wenn „Schlag“ gespielt wird, füge allen Gegnern [Arg1] <FixedDamage:Reinen SCH> zu. Der entsprechende Erwecker erhält 15 Aliemus."
  },
  RelicConfig_13811_Name = {
    Text = "<WhiteQuality:Rostiges Weidenblattmesser>"
  },
  RelicConfig_13811_StoryDesc = {
    Text = "Nicht geeignet zum Schneiden von Lebewesen"
  },
  RelicConfig_13812_BattleDesc = {
    Text = "Beim Aufnehmen erhöht sich die maximale Gesundheit um 100 %, zu Beginn der Runde verliere [Arg1] Punkte Leben"
  },
  RelicConfig_13812_Desc = {
    Text = "Beim Aufnehmen erhöht sich die maximale Gesundheit um 100 %, zu Beginn der Runde verliere [Arg1] Punkte Leben"
  },
  RelicConfig_13812_Name = {
    Text = "<RedQuality:☆Fleisch des Unsterblichen☆>"
  },
  RelicConfig_13812_StoryDesc = {
    Text = "“Meereslebewesen neigen dazu, Gliedmaßen zur Flucht abzutrennen.“"
  },
  RelicConfig_13813_BattleDesc = {
    Text = "Zu Beginn des Kampfes wird die aktuelle Gesundheit von Elite- und Bossgegnern um 20% reduziert"
  },
  RelicConfig_13813_Desc = {
    Text = "Zu Beginn des Kampfes wird die aktuelle Gesundheit von Elite- und Bossgegnern um 20% reduziert"
  },
  RelicConfig_13813_Name = {
    Text = "<WhiteQuality:☆Alter Anker☆>"
  },
  RelicConfig_13813_StoryDesc = {
    Text = "Geh nach Hause, mein alter Seemann"
  },
  RelicConfig_13814_BattleDesc = {
    Text = "Am Ende der Runde erhalten alle Erwachten 2 Wahnsinn für jede ungespielte Karte in deiner Hand"
  },
  RelicConfig_13814_Desc = {
    Text = "Am Ende der Runde erhalten alle Erwachten 2 Wahnsinn für jede ungespielte Karte in deiner Hand"
  },
  RelicConfig_13814_Name = {
    Text = "<WhiteQuality:Unwuchtige Waage>"
  },
  RelicConfig_13814_StoryDesc = {
    Text = "Symbolisiert keine Gerechtigkeit mehr"
  },
  RelicConfig_13815_BattleDesc = {
    Text = "Beim Aufnehmen wähle 1 Karte, deren Rechenleistung dauerhaft auf 1 gesetzt wird"
  },
  RelicConfig_13815_Desc = {
    Text = "Beim Aufnehmen wähle 1 Karte, deren Rechenleistung dauerhaft auf 1 gesetzt wird"
  },
  RelicConfig_13815_Name = {
    Text = "<WhiteQuality:☆Feinprothese☆>"
  },
  RelicConfig_13815_StoryDesc = {
    Text = "Ein nicht mehr reines Auge"
  },
  RelicConfig_13816_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhält jeder Feind [Arg1] Punkte<RetaliateIconKeywords:Theke>. Jedes Mal, wenn Schaden verursacht wird, erhält der Erwecker mit dem niedrigsten Wahnsinn 6 Punkte Aelius"
  },
  RelicConfig_13816_Desc = {
    Text = "Zu Beginn des Kampfes erhält jeder Feind [Arg1] Punkte<RetaliateIconKeywords:Theke>. Jedes Mal, wenn Schaden verursacht wird, erhält der Erwecker mit dem niedrigsten Wahnsinn 6 Punkte Aelius"
  },
  RelicConfig_13816_Name = {
    Text = "<RedQuality:☆Heulende Glocke☆>"
  },
  RelicConfig_13816_StoryDesc = {
    Text = "Ding Ling, Ding Ling, das Kind weint;\nDing Ling, Ding Ling, das Kind schreit.\nDing Ling, Ding Ling, das Kind jammert;\nDing Ling, Ding Ling, es hat Hunger, du weißt es"
  },
  RelicConfig_13817_BattleDesc = {
    Text = "Jedes Mal, wenn 6 Befehlskarten gespielt werden, <TentacleInjurieIconKeywords:Tentakelschaden> +[Arg1]"
  },
  RelicConfig_13817_Desc = {
    Text = "Jedes Mal, wenn 6 Befehlskarten gespielt werden, <TentacleInjurieIconKeywords:Tentakelschaden> +[Arg1]"
  },
  RelicConfig_13817_Name = {
    Text = "<WhiteQuality:Bandwurm>"
  },
  RelicConfig_13817_StoryDesc = {
    Text = "Solange unser Gehirn ein Rätsel bleibt, ist es nicht überraschend, dass es voller Tentakel ist"
  },
  RelicConfig_13818_BattleDesc = {
    Text = "Kritische Rate erhöht um 50%, aber zu Beginn des Kampfes <FragileIconKeywords:zerbrechlich> für 3 Runden"
  },
  RelicConfig_13818_Desc = {
    Text = "Kritische Rate erhöht um 50%, aber zu Beginn des Kampfes <FragileIconKeywords:zerbrechlich> für 3 Runden"
  },
  RelicConfig_13818_Name = {
    Text = "<RedQuality:Seltsame Klaue>"
  },
  RelicConfig_13818_StoryDesc = {
    Text = "Unidentifizierbare Spezies"
  },
  RelicConfig_13819_BattleDesc = {
    Text = "Wenn du eine Karte spielst, die 3 oder mehr Arithmetica kostet, ziehe 1 Karte und erhalte 1 Punkt Arithmetica"
  },
  RelicConfig_13819_Desc = {
    Text = "Wenn du eine Karte spielst, die 3 oder mehr Arithmetica kostet, ziehe 1 Karte und erhalte 1 Punkt Arithmetica"
  },
  RelicConfig_13819_Name = {
    Text = "<OrangeQuality:☆Verlorene Schönheit☆>"
  },
  RelicConfig_13819_StoryDesc = {
    Text = "Niemand erinnert sich mehr an ihre Schönheit"
  },
  RelicConfig_13820_BattleDesc = {
    Text = "Jedes Mal, wenn du eine Symptom-Karte erhältst, erhöht sich die maximale Gesundheit um [Arg1] Punkte"
  },
  RelicConfig_13820_Desc = {
    Text = "Jedes Mal, wenn du eine Symptom-Karte erhältst, erhöht sich die maximale Gesundheit um [Arg1] Punkte"
  },
  RelicConfig_13820_Name = {
    Text = "<WhiteQuality:☆Weihrauchpräparat☆>"
  },
  RelicConfig_13820_StoryDesc = {
    Text = "“Süßer, verlockender Duft.“"
  },
  RelicConfig_13821_BattleDesc = {
    Text = "Nach der Freisetzung von Exaltieren ziehe 1 Karte. Wenn die Lebenspunkte unter 25% liegen, ziehe zusätzlich 1 Karte"
  },
  RelicConfig_13821_Desc = {
    Text = "Nach der Freisetzung von Exaltieren ziehe 1 Karte. Wenn die Lebenspunkte unter 25% liegen, ziehe zusätzlich 1 Karte"
  },
  RelicConfig_13821_Name = {
    Text = "<OrangeQuality:Leserad des Wissens>"
  },
  RelicConfig_13821_StoryDesc = {
    Text = "Achte beim Lesen auf deine Sicherheit"
  },
  RelicConfig_13822_BattleDesc = {
    Text = "Pro Runde bei aktivem Schaden [Arg1] Punkte temporären <TentacleInjurieIconKeywords:Tentakelschaden> erhöhen, bis zu 3 Mal stapelbar. Bei voller Schicht wird ein temporärer Tentakel erzeugt, der das Tentakellimit ignoriert"
  },
  RelicConfig_13822_Desc = {
    Text = "Pro Runde bei aktivem Schaden [Arg1] Punkte temporären <TentacleInjurieIconKeywords:Tentakelschaden> erhöhen, bis zu 3 Mal stapelbar. Bei voller Schicht wird ein temporärer Tentakel erzeugt, der das Tentakellimit ignoriert"
  },
  RelicConfig_13822_Name = {
    Text = "<OrangeQuality:Freuden des Strudels>"
  },
  RelicConfig_13822_StoryDesc = {
    Text = "Herr des ewigen Schlafs, erwarte dich im Traum"
  },
  RelicConfig_13823_BattleDesc = {
    Text = "Die [Arg1] Befehlskarte, die du spielst, hat eine doppelte Wirkung und kehrt in deine Hand zurück"
  },
  RelicConfig_13823_Desc = {
    Text = "Die [Arg1] Befehlskarte, die du spielst, hat eine doppelte Wirkung und kehrt in deine Hand zurück"
  },
  RelicConfig_13823_Name = {
    Text = "<OrangeQuality:Sternenwein+>"
  },
  RelicConfig_13823_StoryDesc = {
    Text = "Zwischen den Sternen wandern"
  },
  RelicConfig_13824_BattleDesc = {
    Text = "Zu Beginn jeder Runde erhöht sich <DeathResistanceIconKeywords:Todwiderstand> um 10% (In diesem Level wird der erhaltene Todwiderstand bei jedem Auslösen um die Hälfte reduziert). Wenn der <DeathResistanceIconKeywords:Todwiderstand> über 100% liegt, erhöht sich <ProficientInRealmsIconKeywords:Reichsbeherrschung> um 100."
  },
  RelicConfig_13824_Desc = {
    Text = "Zu Beginn jeder Runde erhöht sich <DeathResistanceIconKeywords:Todwiderstand> um 10% (Bei jedem Auslösen des Todeswiderstands in diesem Level wird der erhaltene Todeswiderstand halbiert). Wenn der <DeathResistanceIconKeywords:Todwiderstand> über 100% liegt, erhöht sich <ProficientInRealmsIconKeywords:Reichsbeherrschung> um 100."
  },
  RelicConfig_13824_Name = {
    Text = "<WhiteQuality:Meerjungfrauenträne>"
  },
  RelicConfig_13824_StoryDesc = {
    Text = "Leg es nicht ins Wasser"
  },
  RelicConfig_13825_BattleDesc = {
    Text = "Für 10 verbrauchte schwarze Siegel kehre [Arg1] Punkte Leben zurück"
  },
  RelicConfig_13825_Desc = {
    Text = "Für 10 verbrauchte schwarze Siegel kehre 1% Leben zurück"
  },
  RelicConfig_13825_Name = {
    Text = "Umgekehrte Wurzel"
  },
  RelicConfig_13826_BattleDesc = {
    Text = "Wenn du eine Buffkarte, Symptomkarte oder Zustandkarte spielst, erhält der Erwecker mit dem niedrigsten Aliemus 10 Aliemus."
  },
  RelicConfig_13826_Desc = {
    Text = "Wenn du eine Buffkarte, Symptomkarte oder Zustandkarte spielst, erhält der Erwecker mit dem niedrigsten Aliemus 10 Aliemus."
  },
  RelicConfig_13826_Name = {
    Text = "<WhiteQuality:Briefmarkenalbum>"
  },
  RelicConfig_13826_StoryDesc = {
    Text = "Quantifizierte Gedanken"
  },
  RelicConfig_13827_BattleDesc = {
    Text = "Beim Aufnehmen erhält man 75 schwarze Siegel. Wähle 1 Relikt und verwandele es in 1 zufälliges verfluchtes Relikt"
  },
  RelicConfig_13827_Desc = {
    Text = "Beim Aufnehmen erhält man 75 schwarze Siegel. Wähle 1 Relikt und verwandele es in 1 zufälliges verfluchtes Relikt"
  },
  RelicConfig_13827_Name = {
    Text = "<RedQuality:Verfluchter Stein>"
  },
  RelicConfig_13827_StoryDesc = {
    Text = "Beim Streicheln hörte er den Ruf der Tiefsee"
  },
  RelicConfig_13828_BattleDesc = {
    Text = "Nachdem in jeder Runde die erste Befehlskarte in den Ablagestapel gelegt wurde, wird die Arithmetica-Kosten für diese Karte um 1 reduziert und eine temporäre Kopie in den Ziehstapel gemischt"
  },
  RelicConfig_13828_Desc = {
    Text = "Nachdem in jeder Runde die erste Befehlskarte in den Ablagestapel gelegt wurde, wird die Arithmetica-Kosten für diese Karte um 1 reduziert und eine temporäre Kopie in den Ziehstapel gemischt"
  },
  RelicConfig_13828_Name = {
    Text = "<WhiteQuality:Stumme Phonograph>"
  },
  RelicConfig_13828_StoryDesc = {
    Text = "Seine Stimme verschwand im Wind"
  },
  RelicConfig_13829_BattleDesc = {
    Text = "Ein rostiger Schlüsselbund. Kann zum Öffnen von Schlössern verwendet werden"
  },
  RelicConfig_13829_Desc = {
    Text = "Ein rostiger Schlüsselbund. Kann zum Öffnen von Schlössern verwendet werden"
  },
  RelicConfig_13829_Name = {
    Text = "Rostiger Schlüssel"
  },
  RelicConfig_13830_BattleDesc = {
    Text = "Bei der Lebensrückgewinnung erhältst du auch [Arg1] Punkte Schild. Nach Runde 3 erhältst du [Arg2] Punkte <AlertIconKeywords:Alarm>"
  },
  RelicConfig_13830_Desc = {
    Text = "Bei der Lebensrückgewinnung erhältst du auch [Arg1] Punkte Schild. Nach Runde 3 erhältst du [Arg2] Punkte <AlertIconKeywords:Alarm>"
  },
  RelicConfig_13830_Name = {
    Text = "<WhiteQuality:Schmetterlingspräparat>"
  },
  RelicConfig_13830_StoryDesc = {
    Text = "Bis heute wird er von jemandem tief geliebt"
  },
  RelicConfig_13831_BattleDesc = {
    Text = "Jedes Mal, wenn eine Befehlskarte in den <DimensionalSpaceIconKeywords:Hyperraum> geht, erhält der entsprechende Erwachte 15 Wahnsinn"
  },
  RelicConfig_13831_Desc = {
    Text = "Jedes Mal, wenn eine Befehlskarte in den <DimensionalSpaceIconKeywords:Hyperraum> geht, erhält der entsprechende Erwachte 15 Wahnsinn"
  },
  RelicConfig_13831_Name = {
    Text = "<WhiteQuality:Zeitwurm>"
  },
  RelicConfig_13831_StoryDesc = {
    Text = "Eine Taschenuhr, die gleichzeitig im Uhrengeschäft und im Insektenmuseum existiert.\nNach dem Beginn des Holozäns wurde sie in die Universitätskollektion aufgenommen"
  },
  RelicConfig_13832_BattleDesc = {
    Text = "Nach dem Betreten der Ultra-Runde werden eigene <WeaknessIconKeywords:Schwäche> und <FragileIconKeywords:Zerbrechlich> aufgehoben und alle Feinde für 3 Runden <WeaknessIconKeywords:Schwäche> und <VulnerabilityIconKeywords:Verwundbar> gemacht. Der Gesamtschaden aller Erwecker in dieser Runde erhöht sich um 15 %."
  },
  RelicConfig_13832_Desc = {
    Text = "Nach dem Betreten der Ultra-Runde werden eigene <WeaknessIconKeywords:Schwäche> und <FragileIconKeywords:Zerbrechlich> aufgehoben und alle Feinde für 3 Runden <WeaknessIconKeywords:Schwäche> und <VulnerabilityIconKeywords:Verwundbar> gemacht. Der Gesamtschaden aller Erwecker in dieser Runde erhöht sich um 15 %."
  },
  RelicConfig_13832_Name = {
    Text = "<WhiteQuality:Supersaiten-Taschenuhr>"
  },
  RelicConfig_13832_StoryDesc = {
    Text = "“Oh, die Taschenuhr ist stehen geblieben.“"
  },
  RelicConfig_13833_BattleDesc = {
    Text = "Für jeden verursachten Schaden fügst du dem Ziel [Arg1] Schichten <IntoxicationIconKeywords:Gift> hinzu. Wenn die Auslösungen in diesem Kampf 25 erreichen, wird sofort <IntoxicationIconKeywords:Gift> auf alle Gegner aktiviert"
  },
  RelicConfig_13833_Desc = {
    Text = "Für jeden verursachten Schaden fügst du dem Ziel [Arg1] Schichten <IntoxicationIconKeywords:Gift> hinzu. Wenn die Auslösungen in diesem Kampf 25 erreichen, wird sofort <IntoxicationIconKeywords:Gift> auf alle Gegner aktiviert"
  },
  RelicConfig_13833_Name = {
    Text = "<OrangeQuality:☆Staubige Nähmaschine☆>"
  },
  RelicConfig_13833_StoryDesc = {
    Text = "Eine liebevolle Mutter, die die Wunden des Herzens näht"
  },
  RelicConfig_13834_BattleDesc = {
    Text = "Nach jedem 5. Erhalt von Schild erhältst du gleichzeitig <RetaliateIconKeywords:Rückschlag>, dessen Wert dem [Arg1]% des erhobenen Schildes entspricht"
  },
  RelicConfig_13834_Desc = {
    Text = "Nach jedem 5. Erhalt von Schild erhältst du gleichzeitig <RetaliateIconKeywords:Rückschlag>, dessen Wert dem [Arg1]% des erhobenen Schildes entspricht"
  },
  RelicConfig_13834_Name = {
    Text = "<OrangeQuality:Weisheitsfragment>"
  },
  RelicConfig_13834_StoryDesc = {
    Text = "“Menschen sind so dumm, sie glauben blind an das Alte.“"
  },
  RelicConfig_13835_BattleDesc = {
    Text = "Zu Beginn der Runde ziehst du 1 Karte"
  },
  RelicConfig_13835_Desc = {
    Text = "Zu Beginn der Runde ziehst du 1 Karte"
  },
  RelicConfig_13835_Name = {
    Text = "<WhiteQuality:Kompass>"
  },
  RelicConfig_13835_StoryDesc = {
    Text = "Es zeigt nicht die Richtung, nur das Magnetfeld"
  },
  RelicConfig_13836_BattleDesc = {
    Text = "Zu Beginn des Kampfes werden <DerivativeCardKeywords_3:„Krämpfe“> und <DerivativeCardKeywords_4:„Inspiration“> zufällig in den <DimensionalSpaceIconKeywords:Hyperraum> gelegt, bis das Limit erreicht ist. Nach Eintritt in die Hyperraumrunde erhält man [Arg1] <PowerIconKeywords:Stärke>"
  },
  RelicConfig_13836_Desc = {
    Text = "Zu Beginn des Kampfes werden <DerivativeCardKeywords_3:„Krämpfe“> und <DerivativeCardKeywords_4:„Inspiration“> zufällig in den <DimensionalSpaceIconKeywords:Hyperraum> gelegt, bis das Limit erreicht ist. Nach Eintritt in die Hyperraumrunde erhält man [Arg1] <PowerIconKeywords:Stärke>"
  },
  RelicConfig_13836_Name = {
    Text = "<RedQuality:Alfonsos Artefakt>"
  },
  RelicConfig_13836_StoryDesc = {
    Text = "Im Gegensatz zum unbeständigen Schicksal, folgen die Sterne ihren eigenen Gesetzen"
  },
  RelicConfig_13837_BattleDesc = {
    Text = "Nach dem Aufheben erhält man 100% <DeathResistanceIconKeywords:Todwiderstand> (In diesem Level wird der erhaltene Todwiderstand bei jedem Auslösen um die Hälfte reduziert). Nach dem Auslösen des <DeathResistanceIconKeywords:Todwiderstands> werden zu Beginn jeder Runde in diesem Kampf [Arg1] Lebenspunkte wiederhergestellt."
  },
  RelicConfig_13837_Desc = {
    Text = "Beim Aufheben erhält man 100% <DeathResistanceIconKeywords:Todwiderstand> (In diesem Level wird der erhaltene Todwiderstand bei jedem Auslösen um die Hälfte reduziert). Nach dem Auslösen des <DeathResistanceIconKeywords:Todwiderstands> werden zu Beginn jeder Runde in diesem Kampf [Arg1] Lebenspunkte wiederhergestellt."
  },
  RelicConfig_13837_Name = {
    Text = "<WhiteQuality:Wiederbelebung>"
  },
  RelicConfig_13837_StoryDesc = {
    Text = "Ein Muss für jeden Abenteurer. Wenn du dich zu sehr darauf verlässt, wird es ein Teil von dir"
  },
  RelicConfig_13838_BattleDesc = {
    Text = "Das ist ein wirksames Auftragrelikt 2"
  },
  RelicConfig_13838_Desc = {
    Text = "Das ist ein wirksames Auftragrelikt 2"
  },
  RelicConfig_13838_Name = {
    Text = "Aufgabenkreationstest 2"
  },
  RelicConfig_13838_StoryDesc = {
    Text = "Ergänze den Inhalt des Artefakts"
  },
  RelicConfig_13839_BattleDesc = {
    Text = "Beim Ausspielen der letzten Karte auf der Hand zieht man 2 Karten. Maximal 2 Mal pro Runde"
  },
  RelicConfig_13839_Desc = {
    Text = "Beim Ausspielen der letzten Karte auf der Hand zieht man 2 Karten. Maximal 2 Mal pro Runde"
  },
  RelicConfig_13839_Name = {
    Text = "<WhiteQuality:☆Magische Handschuhe☆>"
  },
  RelicConfig_13839_StoryDesc = {
    Text = "“Keine Angst, das ist nur Magie.“"
  },
  RelicConfig_13840_BattleDesc = {
    Text = "Alle 3 Runden erhalten alle Feinde 1 Schicht <WeaknessIconKeywords:Schwäche>. Schaden an <WeaknessIconKeywords:schwachen> Feinden erhöht deine temporäre <PowerIconKeywords:Kraft> um [Arg1], maximal 3 Mal pro Runde"
  },
  RelicConfig_13840_Desc = {
    Text = "Alle 3 Runden erhalten alle Feinde 1 Schicht <WeaknessIconKeywords:Symptom: Schwäche>. Nach Schaden an einem Feind mit <WeaknessIconKeywords:Symptom: Schwäche> erhalte [Arg1] Temporäre <PowerIconKeywords:Kraft>, maximal 3 Mal pro Runde"
  },
  RelicConfig_13840_Name = {
    Text = "<WhiteQuality:Bösewicht>"
  },
  RelicConfig_13840_StoryDesc = {
    Text = "Geboren aus reinem Bösen, auch wenn es nicht sein Wille war"
  },
  RelicConfig_13841_BattleDesc = {
    Text = "Der kritische Schaden aller „Schläge“ wird um 20% erhöht. Zu Beginn des Kampfes erhältst du eine Karte <DerivativeCardKeywords_40: „Wunderschöne Momente“>"
  },
  RelicConfig_13841_Desc = {
    Text = "Der kritische Schaden aller „Schläge“ wird um 20% erhöht. Zu Beginn des Kampfes erhältst du eine Karte <DerivativeCardKeywords_40: „Wunderschöne Momente“>"
  },
  RelicConfig_13841_Name = {
    Text = "<WhiteQuality:Schöner Moment>"
  },
  RelicConfig_13841_StoryDesc = {
    Text = "Bewahre die flüchtige Schönheit für immer"
  },
  RelicConfig_13842_BattleDesc = {
    Text = "Immun gegen tödlichen Schaden, der nicht die Überlebensfähigkeit aktiviert hat, heilt [Arg1] Leben und macht dieses Relikt dauerhaft wirkungslos"
  },
  RelicConfig_13842_Desc = {
    Text = "Immun gegen tödlichen Schaden, der nicht die Überlebensfähigkeit aktiviert hat, heilt [Arg1] Leben und macht dieses Relikt dauerhaft wirkungslos"
  },
  RelicConfig_13842_Name = {
    Text = "<OrangeQuality:Stellvertreterpuppe>"
  },
  RelicConfig_13842_StoryDesc = {
    Text = "Hihihi, hihihi. Du schuldest mir was, oder?"
  },
  RelicConfig_13844_BattleDesc = {
    Text = "Wenn du <WeaknessIconKeywords:Schwäche> verursachst, erhältst du [Arg1] Schildpunkte; bei <VulnerabilityIconKeywords:Verwundbarkeit> erhältst du [Arg2] Punkte temporäre <PowerIconKeywords:Kraft>. Wenn beide Effekte in einer Runde ausgelöst werden, erhältst du zusätzlich [Arg1] Schildpunkte und [Arg2] Punkte temporäre <PowerIconKeywords:Kraft>."
  },
  RelicConfig_13844_Desc = {
    Text = "Wenn du <WeaknessIconKeywords:Schwäche> verursachst, erhältst du [Arg1] Schildpunkte; bei <VulnerabilityIconKeywords:Verwundbarkeit> erhältst du [Arg2] Punkte temporäre <PowerIconKeywords:Kraft>. Wenn beide Effekte in einer Runde ausgelöst werden, erhältst du zusätzlich [Arg1] Schildpunkte und [Arg2] Punkte temporäre <PowerIconKeywords:Kraft>."
  },
  RelicConfig_13844_Name = {
    Text = "<OrangeQuality:Schwerer Bilderrahmen>"
  },
  RelicConfig_13844_StoryDesc = {
    Text = "Das letzte Werk eines wahnsinnigen Künstlers, angeblich sieht man darin sein erschrecktes Gesicht"
  },
  RelicConfig_13845_BattleDesc = {
    Text = "Wenn die letzte 1 Arithmetica aufgebraucht wird, gewinne 2 Arithmetica. Dies kann pro Runde maximal 2 Mal ausgelöst werden"
  },
  RelicConfig_13845_Desc = {
    Text = "Wenn die letzte 1 Arithmetica aufgebraucht wird, gewinne 2 Arithmetica. Dies kann pro Runde maximal 2 Mal ausgelöst werden"
  },
  RelicConfig_13845_Name = {
    Text = "<OrangeQuality:☆Silberne Differenzmaschine☆>"
  },
  RelicConfig_13845_StoryDesc = {
    Text = "“Es hat die Geschichte verändert.“"
  },
  RelicConfig_13846_BattleDesc = {
    Text = "Jedes Mal, wenn du Leben verlierst, erhältst du [Arg1] Punkte <PowerIconKeywords:Kraft>, maximal 10 Mal pro Kampf. Bei voller Schicht regeneriere 25 % des verlorenen Lebens"
  },
  RelicConfig_13846_Desc = {
    Text = "Jedes Mal, wenn du Leben verlierst, erhältst du [Arg1] Punkte <PowerIconKeywords:Kraft>, maximal 10 Mal pro Kampf. Bei voller Schicht regeneriere 25 % des verlorenen Lebens"
  },
  RelicConfig_13846_Name = {
    Text = "<OrangeQuality:Oberste Ehre>"
  },
  RelicConfig_13846_StoryDesc = {
    Text = "Elegante, mysteriöse schwarze Kurzhaarkatze, die in einem fernen Wüstenland als göttliche Inkarnation verehrt wird. Doch der Name dieser Gottheit ist heute unbekannt.\nVerehrt, bewundert, vergessen – vielleicht das Schicksal der Götter"
  },
  RelicConfig_13847_BattleDesc = {
    Text = "Verursacht 20% mehr Schaden an Feinden mit negativen Zuständen, der Mörder erhält 20 Wahnsinn"
  },
  RelicConfig_13847_Desc = {
    Text = "Verursacht 20% mehr Schaden an Feinden mit negativen Zuständen, der Mörder erhält 20 Wahnsinn"
  },
  RelicConfig_13847_Name = {
    Text = "<OrangeQuality:Priesterstab>"
  },
  RelicConfig_13847_StoryDesc = {
    Text = "Unerlaubte Frömmigkeit"
  },
  RelicConfig_13848_BattleDesc = {
    Text = "Nach dem Aufheben wird die Beherrschung der Gruppenregion auf 150% des ursprünglichen Werts erhöht. Nach dem Ausspielen der fünften Befehlskarte in jeder Runde erhalten alle Erwachten 20 Wahnsinn"
  },
  RelicConfig_13848_Desc = {
    Text = "Nach dem Aufheben wird die Beherrschung der Gruppenregion auf 150% des ursprünglichen Werts erhöht. Nach dem Ausspielen der fünften Befehlskarte in jeder Runde erhalten alle Erwachten 20 Wahnsinn"
  },
  RelicConfig_13848_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Unrein“>"
  },
  RelicConfig_13849_BattleDesc = {
    Text = "Pro Runde nach dem 3. Schaden [Arg1] Punkte Schild erhalten. Nach dem 6. Schaden [Arg2] Punkte <PowerIconKeywords:Kraft> erhalten"
  },
  RelicConfig_13849_Desc = {
    Text = "Pro Runde nach dem 3. Schaden [Arg1] Punkte Schild erhalten. Nach dem 6. Schaden [Arg2] Punkte <PowerIconKeywords:Kraft> erhalten"
  },
  RelicConfig_13849_Name = {
    Text = "<WhiteQuality:Notausgang>"
  },
  RelicConfig_13849_StoryDesc = {
    Text = "Es scheint, dass er auch nicht entkommen konnte"
  },
  RelicConfig_13851_BattleDesc = {
    Text = "Bei jedem <DevouredIconKeywords:Verschlingen> stehle [Arg1] temporäre <PowerIconKeywords:Kraft> von allen Feinden"
  },
  RelicConfig_13851_Desc = {
    Text = "Bei jedem <DevouredIconKeywords:Verschlingen> stehle [Arg1] temporäre <PowerIconKeywords:Kraft> von allen Feinden"
  },
  RelicConfig_13851_Name = {
    Text = "<OrangeQuality:Meisterdieb>"
  },
  RelicConfig_13851_StoryDesc = {
    Text = "Ein perfektes Werkzeug für Mord und Raub"
  },
  RelicConfig_13852_BattleDesc = {
    Text = "Beim Aufheben wählt man einen Erwecker und erweckt ihn, die Zugkosten seiner Erweckungskarte werden permanent um 1 gesenkt"
  },
  RelicConfig_13852_Desc = {
    Text = "Beim Aufheben wählt man einen Erwecker und erweckt ihn, die Zugkosten seiner Erweckungskarte werden permanent um 1 gesenkt"
  },
  RelicConfig_13852_Name = {
    Text = "<WhiteQuality:Eierzeit>"
  },
  RelicConfig_13852_StoryDesc = {
    Text = "Genieße es, aber iss es nicht"
  },
  RelicConfig_13853_BattleDesc = {
    Text = "Jedes Mal, wenn Schaden verursacht wird, erhalte [Arg1] Temporären <RetaliateIconKeywords:Konter>, bis zu 5 Mal pro Runde. Beim 5. Auslöser lege eine <DerivativeCardKeywords_4:„Einblick\"> in den Ziehstapel"
  },
  RelicConfig_13853_Desc = {
    Text = "Jedes Mal, wenn Schaden verursacht wird, erhalte [Arg1] Temporären <RetaliateIconKeywords:Konter>, bis zu 5 Mal pro Runde. Beim 5. Auslöser lege eine <DerivativeCardKeywords_4:„Einblick\"> in den Ziehstapel"
  },
  RelicConfig_13853_Name = {
    Text = "<WhiteQuality:Verlorenes Opfermesser>"
  },
  RelicConfig_13853_StoryDesc = {
    Text = "Ein gekrümmtes Opfermesser, häufig in Ritualen verwendet"
  },
  RelicConfig_13854_BattleDesc = {
    Text = "Zu Rundenbeginn ziehen Sie 2 Karten und erhalten 2 Punkte Arithmetica. Jedes Mal, wenn Sie eine Befehlskarte oder Gnosis aufwecken, ändert sich deren Arithmetica-Verbrauch zufällig (0-4)"
  },
  RelicConfig_13854_Desc = {
    Text = "Zu Rundenbeginn ziehen Sie 2 Karten und erhalten 2 Punkte Arithmetica. Jedes Mal, wenn Sie eine Befehlskarte oder Gnosis aufwecken, ändert sich deren Arithmetica-Verbrauch zufällig (0-4)"
  },
  RelicConfig_13854_Name = {
    Text = "<RedQuality: Zauberhut>"
  },
  RelicConfig_13854_StoryDesc = {
    Text = "Willkommen im Wunderland-Zirkus von Fräulein Casiah! Sei vorsichtig und berühre die Zauberutensilien nicht einfach so. Wenn du dich nicht in Acht nimmst und gebissen wirst, wäre das schlecht. \n Schließlich war das letzte Mal, als es Blut schmeckte, die Folge sehr gruselig. \n\n Der Zylinder blinzelte mit den Augen, als ob er jederzeit aus seinem Kokon schlüpfen könnte."
  },
  RelicConfig_13855_BattleDesc = {
    Text = "Zu Beginn des Zuges und immer wenn LP wiederhergestellt wird, erhalte [Arg1] <RetaliateIconKeywords:Gegenangriff>. Kann bis zu 3 Mal pro Zug ausgelöst werden. Wenn das Limit erreicht wird, löse 100% <RetaliateIconKeywords:Gegenangriff> gegen alle Gegner aus."
  },
  RelicConfig_13855_Desc = {
    Text = "Zu Beginn des Zuges und immer wenn LP wiederhergestellt wird, erhalte [Arg1] <RetaliateIconKeywords:Gegenangriff>. Kann bis zu 3 Mal pro Zug ausgelöst werden. Wenn das Limit erreicht wird, löse 100% <RetaliateIconKeywords:Gegenangriff> gegen alle Gegner aus."
  },
  RelicConfig_13855_Name = {
    Text = "<OrangeQuality:Spieluhr>"
  },
  RelicConfig_13855_StoryDesc = {
    Text = "In Dexters Anwesen gibt es viele Sammlungen. Bevor es zerbrach, war die kleine Spieluhr das Lieblingsspielzeug von Miss Dexter. \nDie Zeit verging, und als Miss Dexter sie wiederfand, waren die Zahnräder locker und die Musik verstimmt, aber sie drehte sich immer noch"
  },
  RelicConfig_13856_BattleDesc = {
    Text = "Der kritische Schaden erhöht sich um 15%. Die kritische Rate für \"Schlag\" erhöht sich um 40%"
  },
  RelicConfig_13856_Desc = {
    Text = "Der kritische Schaden erhöht sich um 15%. Die kritische Rate für \"Schlag\" erhöht sich um 40%"
  },
  RelicConfig_13856_Name = {
    Text = "<WhiteQuality:Weiße Rabenschnabel>"
  },
  RelicConfig_13856_StoryDesc = {
    Text = "Vor ihm gibt es keine Geheimnisse"
  },
  RelicConfig_13857_BattleDesc = {
    Text = "Nach der Freisetzung von Exaltieren erhältst du [Arg1] Punkte <RetaliateIconKeywords:Theke>. Wenn dies im Kampf zum 6. Mal aktiviert wird, verdoppeln sich deine <RetaliateIconKeywords:Theke>"
  },
  RelicConfig_13857_Desc = {
    Text = "Nach der Freisetzung von Exaltieren erhältst du [Arg1] Punkte <RetaliateIconKeywords:Theke>. Wenn dies im Kampf zum 6. Mal aktiviert wird, verdoppeln sich deine <RetaliateIconKeywords:Theke>"
  },
  RelicConfig_13857_Name = {
    Text = "<OrangeQuality:☆Sextant☆>"
  },
  RelicConfig_13857_StoryDesc = {
    Text = "Deine Führung führt nur in die Irre"
  },
  RelicConfig_13858_BattleDesc = {
    Text = "Jede Runde zusätzlich eine Karte ziehen, erhält man 1 Punkt Arithmetica"
  },
  RelicConfig_13858_Desc = {
    Text = "Jede Runde zusätzlich eine Karte ziehen, erhält man 1 Punkt Arithmetica"
  },
  RelicConfig_13858_Name = {
    Text = "<OrangeQuality:☆Schöne Erinnerungen☆>"
  },
  RelicConfig_13858_StoryDesc = {
    Text = "Jemand blieb für immer in jenem Sommer"
  },
  RelicConfig_13859_BattleDesc = {
    Text = "Zu Beginn der Runde ziehst du 1 Karte. Zu Beginn des Kampfes wird 1 <DerivativeCardKeywords_4:„Inspiration“> in dein Deck gemischt. Nach jedem Kampf erhöht sich die Anzahl der gemischten <DerivativeCardKeywords_4:„Inspiration“> um 1, maximal 3 Mal"
  },
  RelicConfig_13859_Desc = {
    Text = "Zu Beginn der Runde ziehst du 1 Karte. Zu Beginn des Kampfes wird 1 <DerivativeCardKeywords_4:„Inspiration“> in dein Deck gemischt. Nach jedem Kampf erhöht sich die Anzahl der gemischten <DerivativeCardKeywords_4:„Inspiration“> um 1, maximal 3 Mal"
  },
  RelicConfig_13859_Name = {
    Text = "<OrangeQuality:Prasno-Spiegel>"
  },
  RelicConfig_13859_StoryDesc = {
    Text = "Spiel von Licht und Schatten"
  },
  RelicConfig_13860_BattleDesc = {
    Text = "Jedes Mal, wenn dieselbe Karte eines Erwachens nacheinander gespielt wird, erhält das Erwachen 8 Wahnsinn"
  },
  RelicConfig_13860_Desc = {
    Text = "Jedes Mal, wenn dieselbe Karte eines Erwachens nacheinander gespielt wird, erhält das Erwachen 8 Wahnsinn"
  },
  RelicConfig_13860_Name = {
    Text = "<WhiteQuality:Präzisionsuhr>"
  },
  RelicConfig_13860_StoryDesc = {
    Text = "Eine der bösartigsten Erfindungen der Menschheit"
  },
  RelicConfig_13861_BattleDesc = {
    Text = "Beim Aufheben wählt man eine Karte eines Erweckers, um die Zugkosten um 1 zu senken und diese als „Schlag“ zu betrachten"
  },
  RelicConfig_13861_Desc = {
    Text = "Beim Aufheben wählt man eine Karte eines Erweckers, um die Zugkosten um 1 zu senken und diese als „Schlag“ zu betrachten"
  },
  RelicConfig_13861_Name = {
    Text = "<OrangeQuality:Zufälliger Fehler>"
  },
  RelicConfig_13861_StoryDesc = {
    Text = "Lach aus vollem Herzen!"
  },
  RelicConfig_13862_BattleDesc = {
    Text = "Nach dem Aufheben verliert man dauerhaft [Arg1] <PowerIconKeywords:Kraft>. Bei jedem verursachten Schaden werden [Arg2] Lebenspunkte wiederhergestellt, maximal 6 Mal pro Runde"
  },
  RelicConfig_13862_Desc = {
    Text = "Nach dem Aufheben verliert man dauerhaft [Arg1] <PowerIconKeywords:Kraft>. Bei jedem verursachten Schaden werden [Arg2] Lebenspunkte wiederhergestellt, maximal 6 Mal pro Runde"
  },
  RelicConfig_13862_Name = {
    Text = "<RedQuality:Kuss der Neunaugen>"
  },
  RelicConfig_13862_StoryDesc = {
    Text = "Willst du einen tiefen Kuss? Einen, der dich umbringt"
  },
  RelicConfig_13863_BattleDesc = {
    Text = "Im ersten Zug jedes Kampfes erhält man 3 Punkte Arithmetica"
  },
  RelicConfig_13863_Desc = {
    Text = "Im ersten Zug jedes Kampfes erhält man 3 Punkte Arithmetica"
  },
  RelicConfig_13863_Name = {
    Text = "<WhiteQuality:Taschenuhrspiegel>"
  },
  RelicConfig_13863_StoryDesc = {
    Text = "Erinnerungen erstarren in der Vergangenheit, tief im Schwarz vergraben"
  },
  RelicConfig_13864_BattleDesc = {
    Text = "Nach der ersten gespielten Befehlskarte jeder Runde füge 1 „Schlag“ des entsprechenden Wächters der Hand hinzu und verleihe ihm <NothingnessIconKeywords:Nichtigkeit> und <DepleteIconKeywords:Verbrauch>"
  },
  RelicConfig_13864_Desc = {
    Text = "Nach der ersten gespielten Befehlskarte jeder Runde füge 1 „Schlag“ des entsprechenden Wächters der Hand hinzu und verleihe ihm <NothingnessIconKeywords:Nichtigkeit> und <DepleteIconKeywords:Verbrauch>"
  },
  RelicConfig_13864_Name = {
    Text = "<WhiteQuality:Neue Achse>"
  },
  RelicConfig_13864_StoryDesc = {
    Text = "Vom Land in die Stadt, von der Katastrophe zur Wiedergeburt"
  },
  RelicConfig_13865_BattleDesc = {
    Text = "Nach der ersten gespielten Befehlskarte jeder Runde füge 1 „VERT“ des entsprechenden Wächters der Hand hinzu und verleihe ihm <NothingnessIconKeywords:Nichtigkeit> und <DepleteIconKeywords:Verbrauch>"
  },
  RelicConfig_13865_Desc = {
    Text = "Nach der ersten gespielten Befehlskarte jeder Runde füge 1 „VERT“ des entsprechenden Wächters der Hand hinzu und verleihe ihm <NothingnessIconKeywords:Nichtigkeit> und <DepleteIconKeywords:Verbrauch>"
  },
  RelicConfig_13865_Name = {
    Text = "<WhiteQuality:Stille Ouvertüre>"
  },
  RelicConfig_13865_StoryDesc = {
    Text = "Die Geige des berühmten Violinisten Erik Eckstein.\nHeute kann sie nicht mehr gespielt werden"
  },
  RelicConfig_13866_BattleDesc = {
    Text = "Alle 3 Runden erhalten alle Feinde 1 Schicht <VulnerabilityIconKeywords:Verwundbarkeit>. Schaden an <VulnerabilityIconKeywords:verwundbaren> Feinden reduziert ihre temporäre <PowerIconKeywords:Kraft> um [Arg1], maximal 3 Mal pro Runde"
  },
  RelicConfig_13866_Desc = {
    Text = "Alle 3 Runden erhalten alle Feinde 1 Schicht <VulnerabilityIconKeywords:Verwundbarkeit>. Schaden an <VulnerabilityIconKeywords:verwundbaren> Feinden reduziert ihre temporäre <PowerIconKeywords:Kraft> um [Arg1], maximal 3 Mal pro Runde"
  },
  RelicConfig_13866_Name = {
    Text = "<WhiteQuality:Frühlingsopfer>"
  },
  RelicConfig_13866_StoryDesc = {
    Text = "Im Lachen der Nacht gleitet die Silhouette des Kanus mühelos über den See"
  },
  RelicConfig_13867_BattleDesc = {
    Text = "Handkartenlimit erhöht um 3, aber die Anzahl der gezogenen Karten pro Zug sinkt um 1. Am Ende des Zuges alle Symptomkarten und Zustandskarten ablegen, andere Karten behalten"
  },
  RelicConfig_13867_Desc = {
    Text = "Handkartenlimit erhöht um 3, aber die Anzahl der gezogenen Karten pro Zug sinkt um 1. Am Ende des Zuges alle Symptomkarten und Zustandskarten ablegen, andere Karten behalten"
  },
  RelicConfig_13867_Name = {
    Text = "<RedQuality:Bewusstseinsgravur>"
  },
  RelicConfig_13867_StoryDesc = {
    Text = "Der alte Stamm glaubte, dass das Einritzen spezieller Symbole auf den Schädel eines Toten seine Seele für immer bei ihnen halten würde"
  },
  RelicConfig_13868_BattleDesc = {
    Text = "Nach 4 Auslösungen von Exaltieren senken sich die Arithmetica-Kosten für alle Handkarten um 1"
  },
  RelicConfig_13868_Desc = {
    Text = "Nach 4 Auslösungen von Exaltieren senken sich die Arithmetica-Kosten für alle Handkarten um 1"
  },
  RelicConfig_13868_Name = {
    Text = "<WhiteQuality:☆Fluchtplan☆>"
  },
  RelicConfig_13868_StoryDesc = {
    Text = "“Nach dem Einsteigen, finden Sie zuerst den nächstgelegenen Notausgang zur Kabine.“"
  },
  RelicConfig_13869_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Reichsbeherrschung> +100. Jeder aktive Schaden erhöht temporären Tentakelschaden um [Arg1], jeder Tentakelschaden gibt [Arg2] Schild. Maximal 6 Mal pro Runde"
  },
  RelicConfig_13869_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Reichsbeherrschung> +100. Jeder aktive Schaden erhöht temporären Tentakelschaden um [Arg1], jeder Tentakelschaden gibt [Arg2] Schild. Maximal 6 Mal pro Runde"
  },
  RelicConfig_13869_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Albtraum“>"
  },
  RelicConfig_13870_BattleDesc = {
    Text = "Bei der Erschöpfung von 1 Punkt Arithmetica erhält der entsprechende Erwecker 2 Punkte Aelius"
  },
  RelicConfig_13870_Desc = {
    Text = "Bei der Erschöpfung von 1 Punkt Arithmetica erhält der entsprechende Erwecker 2 Punkte Aelius"
  },
  RelicConfig_13870_Name = {
    Text = "<WhiteQuality:Silberne Schnallenband>"
  },
  RelicConfig_13870_StoryDesc = {
    Text = "Ein Band, das am Tatort gefunden wurde, wurde gewaltsam in zwei Teile gerissen.\nEin Teil schwebte aus großer Höhe herab und landete in der Hand eines Mädchens"
  },
  RelicConfig_13871_BattleDesc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwecker 10 Aelius. Beim Aufsammeln verringert sich die maximale Gesundheit um 30%"
  },
  RelicConfig_13871_Desc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwecker 10 Aelius. Beim Aufsammeln verringert sich die maximale Gesundheit um 30%"
  },
  RelicConfig_13871_Name = {
    Text = "<RedQuality:Albtraumerscheinung>"
  },
  RelicConfig_13871_StoryDesc = {
    Text = "Vorsicht, unkontrollierter Tiefschlaf kann alles verschlingen, ohne dass du es merkst"
  },
  RelicConfig_13873_BattleDesc = {
    Text = "Nachdem du „<ExaltIconKeywords: Wecken der Gnosis>“ gespielt hast, entferne alle Schilde der Feinde"
  },
  RelicConfig_13873_Desc = {
    Text = "Nachdem du „<ExaltIconKeywords: Wecken der Gnosis>“ gespielt hast, entferne alle Schilde der Feinde"
  },
  RelicConfig_13873_Name = {
    Text = "Schwarzer Spiegel"
  },
  RelicConfig_13874_BattleDesc = {
    Text = "In ungeraden Runden, wenn die Anzahl der verbleibenden Handkarten 0 ist, ziehe 2 Karten; in geraden Runden, wenn die verbleibende Rechenleistung 0 ist, erhalte 2 Einheiten Rechenleistung"
  },
  RelicConfig_13874_Desc = {
    Text = "In ungeraden Runden, wenn die Anzahl der verbleibenden Handkarten 0 ist, ziehe 2 Karten; in geraden Runden, wenn die verbleibende Rechenleistung 0 ist, erhalte 2 Einheiten Rechenleistung"
  },
  RelicConfig_13874_Name = {
    Text = "Mutierter goldener Führer"
  },
  RelicConfig_13875_BattleDesc = {
    Text = "Nachdem du „ANG“ und „VERT“ gespielt hast, erhält der entsprechende Erwecker 35 Aelius. Aber ihre Arithmetica Kosten erhöhen sich um 1"
  },
  RelicConfig_13875_Desc = {
    Text = "Nachdem du „ANG“ und „VERT“ gespielt hast, erhält der entsprechende Erwecker 35 Aelius. Aber ihre Arithmetica Kosten erhöhen sich um 1"
  },
  RelicConfig_13875_Name = {
    Text = "<RedQuality:Verstümmeltes Gesicht>"
  },
  RelicConfig_13875_StoryDesc = {
    Text = "Wessen Gesicht, voller Schrecken, in der Zeit erstarrt"
  },
  RelicConfig_13877_BattleDesc = {
    Text = "Nachdem du in einem Zug das 2. Schild erhalten hast, erhalte [Arg1] <plural value=\"[Arg1]\" singular=\"Stapelung\" plural=\"Stapelungen\"> <RetaliateIconKeywords:Gegenangriff>. Nachdem du in einem Zug das 4. Schild erhalten hast, löse 100% <RetaliateIconKeywords:Gegenangriff> gegen alle Gegner aus."
  },
  RelicConfig_13877_Desc = {
    Text = "Nachdem du in einem Zug das 2. Schild erhalten hast, erhalte [Arg1] <plural value=\"[Arg1]\" singular=\"Stapelung\" plural=\"Stapelungen\"> <RetaliateIconKeywords:Gegenangriff>. Nachdem du in einem Zug das 4. Schild erhalten hast, löse 100% <RetaliateIconKeywords:Gegenangriff> gegen alle Gegner aus."
  },
  RelicConfig_13877_Name = {
    Text = "<WhiteQuality:Wissen>"
  },
  RelicConfig_13877_StoryDesc = {
    Text = "Es hat unzählige freiwillige oder unfreiwillige Geheimnisse weitergegeben"
  },
  RelicConfig_13878_BattleDesc = {
    Text = "Jedes Mal, wenn die 6. Befehlskarte gespielt wird, kehrt sie aus dem Ablagestapel auf die Hand zurück"
  },
  RelicConfig_13878_Desc = {
    Text = "Jedes Mal, wenn die 6. Befehlskarte gespielt wird, kehrt sie aus dem Ablagestapel auf die Hand zurück"
  },
  RelicConfig_13878_Name = {
    Text = "<OrangeQuality:Im Abendlicht>"
  },
  RelicConfig_13878_StoryDesc = {
    Text = "Lass uns ein Foto machen! Erlebe den echten Schmerz"
  },
  RelicConfig_13879_BattleDesc = {
    Text = "Nach 5 Auslösungen von Exaltieren erhält der Erwecker, der Exaltieren ausgelöst hat, 100 Aelius"
  },
  RelicConfig_13879_Desc = {
    Text = "Nach 5 Auslösungen von Exaltieren erhält der Erwecker, der Exaltieren ausgelöst hat, 100 Aelius"
  },
  RelicConfig_13879_Name = {
    Text = "<OrangeQuality:Kleines Bündel>"
  },
  RelicConfig_13879_StoryDesc = {
    Text = "Trägt Hoffnung, Segen und Liebe"
  },
  RelicConfig_13880_BattleDesc = {
    Text = "Beim Verursachen von aktivem Schaden erhält man [Arg1] Schild. Beim Heilen erhält man [Arg2] temporäre <PowerIconKeywords:Kraft>"
  },
  RelicConfig_13880_Desc = {
    Text = "Beim Verursachen von aktivem Schaden erhält man [Arg1] Schild. Beim Heilen erhält man [Arg2] temporäre <PowerIconKeywords:Kraft>"
  },
  RelicConfig_13880_Name = {
    Text = "<OrangeQuality:Unser Zuhause>"
  },
  RelicConfig_13880_StoryDesc = {
    Text = "Sie waren vorher zusammen und werden es auch immer sein. Sie sind eine liebevolle Familie"
  },
  RelicConfig_13881_BattleDesc = {
    Text = "Zu Beginn ungerader Runden erhältst du [Arg1] Punkte temporäre<PowerIconKeywords:Macht>. Zu Beginn gerader Runden erhältst du [Arg2] Punkte temporäre<AlertIconKeywords:Alarm>"
  },
  RelicConfig_13881_Desc = {
    Text = "Zu Beginn ungerader Runden erhältst du [Arg1] Punkte temporäre<PowerIconKeywords:Macht>. Zu Beginn gerader Runden erhältst du [Arg2] Punkte temporäre<AlertIconKeywords:Alarm>"
  },
  RelicConfig_13881_Name = {
    Text = "<WhiteQuality:Zwillingspuppe>"
  },
  RelicConfig_13881_StoryDesc = {
    Text = "Zwillinge sind ein Geschenk der alten Zeit, ein Gleichnis für die Zukunft"
  },
  RelicConfig_13882_BattleDesc = {
    Text = "Der erste gespielte Befehlskarte-Wächter jeder Runde erhält am Rundenende 20 Wahnsinn. Wenn du das „Hingabe“-Artefakt hast, erhalten andere Wächter 5 Wahnsinn"
  },
  RelicConfig_13882_Desc = {
    Text = "Der erste gespielte Befehlskarte-Wächter jeder Runde erhält am Rundenende 20 Wahnsinn. Wenn du das „Hingabe“-Artefakt hast, erhalten andere Wächter 5 Wahnsinn"
  },
  RelicConfig_13882_Name = {
    Text = "<WhiteQuality:Mutterstatue>"
  },
  RelicConfig_13882_StoryDesc = {
    Text = "“Hier, du kannst alles haben, bitte, verschone ihn.“"
  },
  RelicConfig_13883_BattleDesc = {
    Text = "Jedes Mal, wenn ein Erwachter 1 Mal <DevouredIconKeywords:verschlingt>, erhalten andere Erwachte 10 Wahnsinn"
  },
  RelicConfig_13883_Desc = {
    Text = "Jedes Mal, wenn ein Erwachter 1 Mal <DevouredIconKeywords:verschlingt>, erhalten andere Erwachte 10 Wahnsinn"
  },
  RelicConfig_13883_Name = {
    Text = "<OrangeQuality:Goldener Traum>"
  },
  RelicConfig_13883_StoryDesc = {
    Text = "Der Tag der Verwandlung ist dein Todestag"
  },
  RelicConfig_13884_BattleDesc = {
    Text = "“Schlag“ fügt allen Feinden [Arg1] Schichten <IntoxicationIconKeywords:Vergiftung> hinzu"
  },
  RelicConfig_13884_Desc = {
    Text = "“Schlag“ fügt allen Feinden [Arg1] Schichten <IntoxicationIconKeywords:Vergiftung> hinzu"
  },
  RelicConfig_13884_Name = {
    Text = "<WhiteQuality:Neurotoxin>"
  },
  RelicConfig_13884_StoryDesc = {
    Text = "Extrahieren, verfeinern"
  },
  RelicConfig_13885_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhältst du 1 <DerivativeCardKeywords_1:„Echo der Schatten“>. In Bosskämpfen erhältst du zusätzlich 1 <DerivativeCardKeywords_1:„Echo der Schatten“>"
  },
  RelicConfig_13885_Desc = {
    Text = "Zu Beginn des Kampfes erhältst du 1 <DerivativeCardKeywords_1:„Echo der Schatten“>. In Bosskämpfen erhältst du zusätzlich 1 <DerivativeCardKeywords_1:„Echo der Schatten“>"
  },
  RelicConfig_13885_Name = {
    Text = "<WhiteQuality:Kommunikationsgerät>"
  },
  RelicConfig_13885_StoryDesc = {
    Text = "Erwartung oder Angst vor dem Moment, in dem es klingelt"
  },
  RelicConfig_13886_BattleDesc = {
    Text = "Bei jedem Zurücksetzen des Decks, füge 2 Karten <DerivativeCardKeywords_5:„Dreizack“> und 1 Karte <DerivativeCardKeywords_6:„Sonnenschirm“> zu deiner Hand hinzu"
  },
  RelicConfig_13886_Desc = {
    Text = "Bei jedem Zurücksetzen des Decks, füge 2 Karten <DerivativeCardKeywords_5:„Dreizack“> und 1 Karte <DerivativeCardKeywords_6:„Sonnenschirm“> zu deiner Hand hinzu"
  },
  RelicConfig_13886_Name = {
    Text = "<WhiteQuality:☆Damenhandtasche☆>"
  },
  RelicConfig_13886_StoryDesc = {
    Text = "Es sollte Feinheit tragen, nicht den Tod"
  },
  RelicConfig_13887_BattleDesc = {
    Text = "Zu Rundenbeginn fügen Sie 1 <DerivativeCardKeywords_5:“Dreizack“> Ihrer Hand hinzu. Nach Auslösen der Wahnsinnsexplosion erhöhen sich alle <DerivativeCardKeywords_5:“Dreizack“><PowerIconKeywords:Macht> in Ihrer Hand um [Arg2]"
  },
  RelicConfig_13887_Desc = {
    Text = "Zu Rundenbeginn fügen Sie 1 <DerivativeCardKeywords_5:“Dreizack“> Ihrer Hand hinzu. Nach Auslösen der Wahnsinnsexplosion erhöhen sich alle <DerivativeCardKeywords_5:“Dreizack“><PowerIconKeywords:Macht> in Ihrer Hand um [Arg2]"
  },
  RelicConfig_13887_Name = {
    Text = "<WhiteQuality:Dreizack>"
  },
  RelicConfig_13887_StoryDesc = {
    Text = "Egal wie man es betrachtet, es ist sehr gewöhnlich"
  },
  RelicConfig_13888_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhältst du [Arg1] Schild. Nach 7 gespielten „VERT“ in diesem Kampf erhältst du sofort [Arg2] Schild. Nach 21 gespielten „VERT“ erhältst du eine temporäre Barriere"
  },
  RelicConfig_13888_Desc = {
    Text = "Zu Beginn des Kampfes erhältst du [Arg1] Schild. Nach 7 gespielten „VERT“ in diesem Kampf erhältst du sofort [Arg2] Schild. Nach 21 gespielten „VERT“ erhältst du eine temporäre Barriere"
  },
  RelicConfig_13888_Name = {
    Text = "<WhiteQuality:Putney Morgenzeitung>"
  },
  RelicConfig_13888_StoryDesc = {
    Text = "Ihr treuester Toilettenbegleiter"
  },
  RelicConfig_13889_BattleDesc = {
    Text = "Nach dem Eintritt in den ultra Zustand erhält man 3 Punkte Arithmetica"
  },
  RelicConfig_13889_Desc = {
    Text = "Nach dem Eintritt in den ultra Zustand erhält man 3 Punkte Arithmetica"
  },
  RelicConfig_13889_Name = {
    Text = "<WhiteQuality:Schimmer Sanduhr>"
  },
  RelicConfig_13889_StoryDesc = {
    Text = "Eine messbare Zeit"
  },
  RelicConfig_13890_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhalten alle Feinde 1 Runde <WeaknessIconKeywords:Schwäche> und <VulnerabilityIconKeywords:Verwundbarkeit>. In Bosskämpfen zusätzlich 2 Runden <WeaknessIconKeywords:Schwäche> und <VulnerabilityIconKeywords:Verwundbarkeit>"
  },
  RelicConfig_13890_Desc = {
    Text = "Zu Beginn des Kampfes erhalten alle Feinde 1 Runde <WeaknessIconKeywords:Schwäche> und <VulnerabilityIconKeywords:Verwundbarkeit>. In Bosskämpfen zusätzlich 2 Runden <WeaknessIconKeywords:Schwäche> und <VulnerabilityIconKeywords:Verwundbarkeit>"
  },
  RelicConfig_13890_Name = {
    Text = "<WhiteQuality:Chamäleonzwangjacke>"
  },
  RelicConfig_13890_StoryDesc = {
    Text = "Nicht nur Zeit kann Stoffe verfärben, auch Angst und Schmerz"
  },
  RelicConfig_13891_BattleDesc = {
    Text = "Wenn die erste ausgespielte Befehlskarte jeder Runde den Sprung-Effekt auslöst, ziehe 1 Karte, andernfalls erhalte 1 Punkt Rechenleistung. Im ultra Raum sind beide oben genannten Effekte gleichzeitig aktiv"
  },
  RelicConfig_13891_Desc = {
    Text = "Wenn die erste ausgespielte Befehlskarte jeder Runde den Sprung-Effekt auslöst, ziehe 1 Karte, andernfalls erhalte 1 Punkt Rechenleistung. Im ultra Raum sind beide oben genannten Effekte gleichzeitig aktiv"
  },
  RelicConfig_13891_Name = {
    Text = "<OrangeQuality:Sprungvorrichtung>"
  },
  RelicConfig_13891_StoryDesc = {
    Text = "Wirft verzerrte Schatten"
  },
  RelicConfig_13892_BattleDesc = {
    Text = "Erhalte eine Aufgabe. Nach Abschluss der Aufgabe erhältst du eine Belohnung. [Ereignis-Platzhalter für die Aufgabe]"
  },
  RelicConfig_13892_Desc = {
    Text = "Erhalte eine Aufgabe. Nach Abschluss der Aufgabe erhältst du eine Belohnung. [Ereignis-Platzhalter für die Aufgabe]"
  },
  RelicConfig_13892_Name = {
    Text = "<WhiteQuality:Altes Tagebuch>"
  },
  RelicConfig_13892_StoryDesc = {
    Text = "Ein altes Tagebuch, vollgestopft mit Beilagen, enthält auf den ersten Blick Karten von Elworth, Experimentaufzeichnungen und Briefe mit Dreieckskorrosionsspuren.\nDie Schrift am Anfang ist ordentlich, wird aber zunehmend schlampig"
  },
  RelicConfig_13893_BattleDesc = {
    Text = "Nach jedem 4. Erhalt von Schildwert stelle 50% des Schildwerts als Leben wieder her"
  },
  RelicConfig_13893_Desc = {
    Text = "Nach jedem 4. Erhalt von Schildwert stelle 50% des Schildwerts als Leben wieder her"
  },
  RelicConfig_13893_Name = {
    Text = "<WhiteQuality:Seemannspfeife>"
  },
  RelicConfig_13893_StoryDesc = {
    Text = "Abgesehen von Meerjungfrauen, kann das Pfeifen auch Stürme, stinkende Stiefel und alte Seemänner herbeirufen, die seit hundert Tagen nicht geduscht haben"
  },
  RelicConfig_13894_BattleDesc = {
    Text = "Wenn du in der letzten Runde 4 oder weniger Karten gespielt hast, wird die erste Karte in dieser Runde zweimal wirksam"
  },
  RelicConfig_13894_Desc = {
    Text = "Wenn du in der letzten Runde 4 oder weniger Karten gespielt hast, wird die erste Karte in dieser Runde zweimal wirksam"
  },
  RelicConfig_13894_Name = {
    Text = "<OrangeQuality:☆Albtraum-Seelenlampe☆>"
  },
  RelicConfig_13894_StoryDesc = {
    Text = "Traum einführen"
  },
  RelicConfig_13895_BattleDesc = {
    Text = "Jedes Mal, wenn du Leben verlierst, erhält der Erwachte mit dem wenigsten Wahnsinn 10 Wahnsinn. Bei 5 Mal Leben verlieren, regeneriere 20 % des verlorenen Lebens"
  },
  RelicConfig_13895_Desc = {
    Text = "Jedes Mal, wenn du Leben verlierst, erhält der Erwachte mit dem wenigsten Wahnsinn 10 Wahnsinn. Bei 5 Mal Leben verlieren, regeneriere 20 % des verlorenen Lebens"
  },
  RelicConfig_13895_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Analyse“>"
  },
  RelicConfig_13896_BattleDesc = {
    Text = "Maximale Arithmetica erhöht sich um 2. Jedes Mal, wenn das Kartenstapel zurückgesetzt wird, füge 1 Karte <DerivativeCardKeywords_9:„Stolpern“> dem Ziehstapel hinzu"
  },
  RelicConfig_13896_Desc = {
    Text = "Maximale Arithmetica erhöht sich um 2. Jedes Mal, wenn das Kartenstapel zurückgesetzt wird, füge 1 Karte <DerivativeCardKeywords_9:„Stolpern“> dem Ziehstapel hinzu"
  },
  RelicConfig_13896_Name = {
    Text = "<RedQuality:Schwarze Kerze>"
  },
  RelicConfig_13896_StoryDesc = {
    Text = "Brennende Klarheit, in Illusionen fallen"
  },
  RelicConfig_13897_BattleDesc = {
    Text = "“<ExaltIconKeywords:Gnosis wecken>“ am Rundenende behalten"
  },
  RelicConfig_13897_Desc = {
    Text = "“<ExaltIconKeywords:Gnosis wecken>“ am Rundenende behalten"
  },
  RelicConfig_13897_Name = {
    Text = "Weißer Spiegel"
  },
  RelicConfig_13898_BattleDesc = {
    Text = "Für jeden erwachten Erwecker erhöht sich die <ProficientInRealmsIconKeywords: Meisterung der Bereiche> um 35. Nach dem Ausspielen von „<ExaltIconKeywords: Gnosis wecken>“ erhält man zufällig 2 Befehlskarten für diesen Erwecker und fügt „erschöpfen“ hinzu"
  },
  RelicConfig_13898_Desc = {
    Text = "Für jeden erwachten Erwecker erhöht sich die <ProficientInRealmsIconKeywords: Meisterung der Bereiche> um 35. Nach dem Ausspielen von „<ExaltIconKeywords: Gnosis wecken>“ erhält man zufällig 2 Befehlskarten für diesen Erwecker und fügt „erschöpfen“ hinzu"
  },
  RelicConfig_13898_Name = {
    Text = "<OrangeQuality:Sein Orakel>"
  },
  RelicConfig_13898_StoryDesc = {
    Text = "Er sagte, fürchte dich nicht"
  },
  RelicConfig_13899_BattleDesc = {
    Text = "Zu Beginn der Runde erhöht sich <ProficientInRealmsIconKeywords:Reichsbeherrschung> um 50. Wenn du keinen negativen Zustand hast, erhöht sich <ProficientInRealmsIconKeywords:Reichsbeherrschung> um 150"
  },
  RelicConfig_13899_Desc = {
    Text = "Zu Beginn der Runde erhöht sich <ProficientInRealmsIconKeywords:Reichsbeherrschung> um 50. Wenn du keinen negativen Zustand hast, erhöht sich <ProficientInRealmsIconKeywords:Reichsbeherrschung> um 150"
  },
  RelicConfig_13899_Name = {
    Text = "<WhiteQuality:☆„Freiheit ehren“☆>"
  },
  RelicConfig_13899_StoryDesc = {
    Text = "Eine Handvoll nostalgischer Silberkerne"
  },
  RelicConfig_13900_BattleDesc = {
    Text = "Nach der Verwendung von „Exaltieren“ reduziert sich der Rechenaufwand aller Handkarten um -1"
  },
  RelicConfig_13900_Desc = {
    Text = "Nach der Verwendung von „Exaltieren“ reduziert sich der Rechenaufwand aller Handkarten um -1"
  },
  RelicConfig_13900_Name = {
    Text = "Licht der veränderten Zivilisation"
  },
  RelicConfig_13901_BattleDesc = {
    Text = "Für jede ausgespielte Befehlskarte erhält man [Arg2]% <DeathResistanceIconKeywords:Todwiderstand> (Für jedes Mal, wenn der Todwiderstand in diesem Level ausgelöst wird, wird der erhaltene Todwiderstand halbiert). Wenn dein <DeathResistanceIconKeywords:Todwiderstand> 100% oder mehr beträgt, erhältst du stattdessen [Arg1] Punkte vorübergehende <PowerIconKeywords:Stärke>."
  },
  RelicConfig_13901_Desc = {
    Text = "Für jede ausgespielte Befehlskarte erhält man [Arg2]% <DeathResistanceIconKeywords:Todwiderstand> (Jedes Mal, wenn der Todwiderstand in diesem Level ausgelöst wird, wird der erhaltene Todwiderstand halbiert). Wenn dein <DeathResistanceIconKeywords:Todwiderstand> 100% oder mehr beträgt, erhältst du stattdessen [Arg1] Punkte vorübergehende <PowerIconKeywords:Stärke>."
  },
  RelicConfig_13901_Name = {
    Text = "<OrangeQuality:Schlangenhaut>"
  },
  RelicConfig_13901_StoryDesc = {
    Text = "Wiedergeburt aus der Selbstverstümmelung"
  },
  RelicConfig_13902_BattleDesc = {
    Text = "Zu Beginn des Zuges erhalte [Arg2] Schild. Am Ende des Zuges füge einem zufälligen Gegner <FixedDamage:Reinen SCH> in Höhe von [Arg1]% deines aktuellen Schilds zu. Der SCH-Effekt wird in Anführer Kämpfen verdoppelt."
  },
  RelicConfig_13902_Desc = {
    Text = "Zu Beginn des Zuges erhalte [Arg2] Schild. Am Ende des Zuges füge einem zufälligen Gegner <FixedDamage:Reinen SCH> in Höhe von [Arg1]% deines aktuellen Schilds zu. Der SCH-Effekt wird in Anführer Kämpfen verdoppelt."
  },
  RelicConfig_13902_Name = {
    Text = "<WhiteQuality:Goldener Führer>"
  },
  RelicConfig_13902_StoryDesc = {
    Text = "Öffne es, wenn du die Orientierung verloren hast, aber sei vorsichtig – seine Korona darf nicht im Sonnenlicht gesehen werden"
  },
  RelicConfig_13904_BattleDesc = {
    Text = "Verstecke die Absichten der Monster. Erhalte 1 Punkt Rechenleistung pro Runde, ziehe 1 Karte"
  },
  RelicConfig_13904_Desc = {
    Text = "Verstecke die Absichten der Monster. Erhalte 1 Punkt Rechenleistung pro Runde, ziehe 1 Karte"
  },
  RelicConfig_13904_Name = {
    Text = "<RedQuality:Verführerische Glocke>"
  },
  RelicConfig_13904_StoryDesc = {
    Text = "Ding Ling Ling, Ding Ling Ling"
  },
  RelicConfig_13905_BattleDesc = {
    Text = "Nach Beginn des Kampfes erhältst du [Arg2] Schichten <RetaliateIconKeywords: Konter>. Wenn du „VERT“ spielst, erhältst du [Arg1] Schichten <RetaliateIconKeywords: Konter>"
  },
  RelicConfig_13905_Desc = {
    Text = "Nach Beginn des Kampfes erhältst du [Arg2] Schichten <RetaliateIconKeywords: Konter>. Wenn du „VERT“ spielst, erhältst du [Arg1] Schichten <RetaliateIconKeywords: Konter>"
  },
  RelicConfig_13905_Name = {
    Text = "<WhiteQuality:Brennnesselweste>"
  },
  RelicConfig_13905_StoryDesc = {
    Text = "Unidentifizierbare Flüssigkeit"
  },
  RelicConfig_13906_BattleDesc = {
    Text = "Das ist ein wirksames Wochenrelikt 4"
  },
  RelicConfig_13906_Desc = {
    Text = "Das ist ein wirksames Wochenrelikt 4"
  },
  RelicConfig_13906_Name = {
    Text = "Wöchentliche Herausforderung 4"
  },
  RelicConfig_13907_BattleDesc = {
    Text = "Zu Beginn der Runde, wenn im letzten Zug mehr als 3 Karten gespielt wurden, ziehe 2 Karten"
  },
  RelicConfig_13907_Desc = {
    Text = "Zu Beginn der Runde, wenn im letzten Zug mehr als 3 Karten gespielt wurden, ziehe 2 Karten"
  },
  RelicConfig_13907_Name = {
    Text = "<WhiteQuality:Neues Portemonnaie>"
  },
  RelicConfig_13907_StoryDesc = {
    Text = "Ein ledernes Portemonnaie, das das Wappen der Mythag Universität trägt.\nJetzt ist es völlig leer, es ist nichts darin"
  },
  RelicConfig_13908_BattleDesc = {
    Text = "Nach der Verwendung von „Exaltieren“ erhält der zugehörige Erwecker [Arg1] Punkte Wut"
  },
  RelicConfig_13908_Desc = {
    Text = "Nach der Verwendung von „Exaltieren“ erhält der zugehörige Erwecker [Arg1] Punkte Wut"
  },
  RelicConfig_13908_Name = {
    Text = "Schleier des namenlosen Gottes der Verwandlung"
  },
  RelicConfig_13909_BattleDesc = {
    Text = "Nach dem Auslösen von „Wahnsinnsexplosion“ verliere 8% deines aktuellen Lebens und stehle [Arg1] Punkte temporäre<PowerIconKeywords:Stärke> von allen Feinden. Wenn nur 1 Feind vorhanden ist, zusätzlich [Arg2] Punkte temporäre<PowerIconKeywords:Stärke>"
  },
  RelicConfig_13909_Desc = {
    Text = "Nach dem Auslösen von „Wahnsinnsexplosion“ verliere 8% deines aktuellen Lebens und stehle [Arg1] Punkte temporäre<PowerIconKeywords:Stärke> von allen Feinden. Wenn nur 1 Feind vorhanden ist, zusätzlich [Arg2] Punkte temporäre<PowerIconKeywords:Stärke>"
  },
  RelicConfig_13909_Name = {
    Text = "<RedQuality:Unglücksvogel>"
  },
  RelicConfig_13909_StoryDesc = {
    Text = "Der ausgetrocknete Körper stieß einen Schrei aus"
  },
  RelicConfig_13910_BattleDesc = {
    Text = "Nachdem Aelius freigesetzt wurde, erhalten die entsprechenden Erwecker 10 Aelius und [Arg1] Punkte Schild"
  },
  RelicConfig_13910_Desc = {
    Text = "Nachdem Aelius freigesetzt wurde, erhalten die entsprechenden Erwecker 10 Aelius und [Arg1] Punkte Schild"
  },
  RelicConfig_13910_Name = {
    Text = "<OrangeQuality:Schleier des namenlosen Gottes>"
  },
  RelicConfig_13910_StoryDesc = {
    Text = "Gott nicht direkt ansehen"
  },
  RelicConfig_13911_BattleDesc = {
    Text = "Der letzte gespielte Befehlskarte-Wächter erhält am Rundenende 20 Wahnsinn. Wenn du das „Mutterbild“ hast, erhalten andere Wächter 5 Wahnsinn"
  },
  RelicConfig_13911_Desc = {
    Text = "Der letzte gespielte Befehlskarte-Wächter erhält am Rundenende 20 Wahnsinn. Wenn du das „Mutterbild“ hast, erhalten andere Wächter 5 Wahnsinn"
  },
  RelicConfig_13911_Name = {
    Text = "<WhiteQuality:Hingabe>"
  },
  RelicConfig_13911_StoryDesc = {
    Text = "“Hier, du kannst alles haben, bitte, verschone mich.“"
  },
  RelicConfig_13912_BattleDesc = {
    Text = "Am Ende der Runde, für jede verbleibende Handkarte, erhält man zu Beginn der nächsten Runde 1 Punkt Arithmetica"
  },
  RelicConfig_13912_Desc = {
    Text = "Am Ende der Runde, für jede verbleibende Handkarte, erhält man zu Beginn der nächsten Runde 1 Punkt Arithmetica"
  },
  RelicConfig_13912_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Darstellung“>"
  },
  RelicConfig_13913_BattleDesc = {
    Text = "Zu Rundenbeginn, wenn Ihr Leben über [Arg1] ist, verlieren Sie [Arg1] Lebenspunkte und erhalten in dieser Runde [Arg2] Punkte <PowerIconKeywords:Macht> und [Arg3] Punkte <AlertIconKeywords:Alarm>"
  },
  RelicConfig_13913_Desc = {
    Text = "Zu Rundenbeginn, wenn Ihr Leben über [Arg1] ist, verlieren Sie [Arg1] Lebenspunkte und erhalten in dieser Runde [Arg2] Punkte <PowerIconKeywords:Macht> und [Arg3] Punkte <AlertIconKeywords:Alarm>"
  },
  RelicConfig_13913_Name = {
    Text = "<RedQuality:Glied der Erlösung>"
  },
  RelicConfig_13913_StoryDesc = {
    Text = "Ein heiliger Teil.\nTrotz der Trennung vom Körper strahlt er noch Wärme aus"
  },
  RelicConfig_13914_BattleDesc = {
    Text = "“Schaden“ erhält 2 Punkte Arithmetica, verworfen zufällig 1 Karte; „VERT“ zieht 2 Karten und verliert 1 Punkt Arithmetica. Maximal 3 mal pro Runde aktiv"
  },
  RelicConfig_13914_Desc = {
    Text = "“Schaden“ erhält 2 Punkte Arithmetica, verworfen zufällig 1 Karte; „VERT“ zieht 2 Karten und verliert 1 Punkt Arithmetica. Maximal 3 mal pro Runde aktiv"
  },
  RelicConfig_13914_Name = {
    Text = "<RedQuality:Fröhliche Platte>"
  },
  RelicConfig_13914_StoryDesc = {
    Text = "Aufgenommenes Album des letzten Auftritts des berühmten Geigers.\nSeitdem kann es Feuer bringen"
  },
  RelicConfig_13915_BattleDesc = {
    Text = "Der Effekt des Reichbonus wird auf 50% erhöht, zu Beginn der Stufe verdoppelt sich dein <ProficientInRealmsIconKeywords:Reichsbeherrschung>"
  },
  RelicConfig_13915_Desc = {
    Text = "Der Effekt des Reichbonus wird auf 50% erhöht, zu Beginn der Stufe verdoppelt sich dein <ProficientInRealmsIconKeywords:Reichsbeherrschung>"
  },
  RelicConfig_13915_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“In Träumen“>"
  },
  RelicConfig_13916_BattleDesc = {
    Text = "Nach dem Auslösen einer Verherrlichung wirkt die nächste ausgespielte Befehlskarte 2 Mal"
  },
  RelicConfig_13916_Desc = {
    Text = "Nach dem Auslösen einer Verherrlichung wirkt die nächste ausgespielte Befehlskarte 2 Mal"
  },
  RelicConfig_13916_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Tauchen“>"
  },
  RelicConfig_13917_BattleDesc = {
    Text = "Wenn die Absicht des Feindes ANG ist, verringert sich seine <PowerIconKeywords:Macht> vorübergehend um [Arg1] Punkte nach erlittenem Schaden, andernfalls fügt es gleichwertigen <BleedingIconKeywords:Bluten> in Höhe von 25% des Schadens hinzu und kann pro Runde maximal 6 Mal ausgelöst werden"
  },
  RelicConfig_13917_Desc = {
    Text = "Wenn die Absicht des Feindes ANG ist, verringert sich seine <PowerIconKeywords:Macht> vorübergehend um [Arg1] Punkte nach erlittenem Schaden, andernfalls fügt es gleichwertigen <BleedingIconKeywords:Bluten> in Höhe von 25% des Schadens hinzu und kann pro Runde maximal 6 Mal ausgelöst werden"
  },
  RelicConfig_13917_Name = {
    Text = "<WhiteQuality:Alienherz>"
  },
  RelicConfig_13917_StoryDesc = {
    Text = "Zwei eng verbundene „Herzen“"
  },
  RelicConfig_13918_BattleDesc = {
    Text = "Jedes Mal, wenn du Schaden verursachst, erhältst du [Arg1] Punkte temporäre <PowerIconKeywords:Stärke>, maximal 3 Mal stapelbar. Bei voller Stapelung wird der Effekt verdoppelt."
  },
  RelicConfig_13918_Desc = {
    Text = "Jedes Mal, wenn du Schaden verursachst, erhältst du [Arg1] Punkte temporäre <PowerIconKeywords:Stärke>, maximal 3 Mal stapelbar. Bei voller Stapelung wird der Effekt verdoppelt."
  },
  RelicConfig_13918_Name = {
    Text = "<WhiteQuality:Bandachat>"
  },
  RelicConfig_13918_StoryDesc = {
    Text = "Es sollte nur eine normale Achatmusterung sein. Wahrscheinlich"
  },
  RelicConfig_13919_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Reichsbeherrschung> +50. Wähle beim Aufheben ein Artefakt und ersetze es durch ein zufälliges"
  },
  RelicConfig_13919_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Reichsbeherrschung> +50. Wähle beim Aufheben ein Artefakt und ersetze es durch ein zufälliges"
  },
  RelicConfig_13919_Name = {
    Text = "<WhiteQuality:Kaleidoskop>"
  },
  RelicConfig_13919_StoryDesc = {
    Text = "Alles, was du siehst und denkst, ist Illusion"
  },
  RelicConfig_13920_BattleDesc = {
    Text = "Schwächeeffekt um 5 % erhöht. Beim Anwenden von <WeaknessIconKeywords:Schwäche> vorübergehend [Arg1] <PowerIconKeywords:Kraft> stehlen"
  },
  RelicConfig_13920_Desc = {
    Text = "Schwächeeffekt um 5% erhöht. Beim Anwenden von <WeaknessIconKeywords:Symptom: Schwäche> vorübergehend [Arg1] <PowerIconKeywords:Kraft> vom Ziel stehlen"
  },
  RelicConfig_13920_Name = {
    Text = "<WhiteQuality:Verblasstes Foto>"
  },
  RelicConfig_13920_StoryDesc = {
    Text = "Verschwommene Fotos tragen verschwommene Erinnerungen, oder vielleicht ist es das Fehlen von Erinnerungen, das die Fotos verblassen lässt."
  },
  RelicConfig_13921_BattleDesc = {
    Text = "Nach dem Aufheben wähle zwei Befehlskarten zum Entfernen und erhalte [Arg1] <PowerIconKeywords:Kraft>"
  },
  RelicConfig_13921_Desc = {
    Text = "Nach dem Aufheben wähle zwei Befehlskarten zum Entfernen und erhalte [Arg1] <PowerIconKeywords:Kraft>"
  },
  RelicConfig_13921_Name = {
    Text = "<RedQuality:Asche des brennenden Schwarzen Sterns>"
  },
  RelicConfig_13921_StoryDesc = {
    Text = "Das Feuer ist nicht erloschen"
  },
  RelicConfig_13922_BattleDesc = {
    Text = "Nach dem Auslösen der Wahnexplosion zweimal pro Runde erhalten alle Erwecker 8 Punkte Wahn, nach dreimaligem Auslösen erhalten alle Erwecker weitere 8 Punkte Wahn"
  },
  RelicConfig_13922_Desc = {
    Text = "Nach dem Auslösen der Wahnexplosion zweimal pro Runde erhalten alle Erwecker 8 Punkte Wahn, nach dreimaligem Auslösen erhalten alle Erwecker weitere 8 Punkte Wahn"
  },
  RelicConfig_13922_Name = {
    Text = "<OrangeQuality:Blut der Vergessenen>"
  },
  RelicConfig_13922_StoryDesc = {
    Text = "Schmilzt allmählich"
  },
  RelicConfig_13923_BattleDesc = {
    Text = "Für jeden verursachten Schaden erhältst du [Arg1] Schild. Zu Beginn jeder Runde erhältst du für je 3 verbleibende Schilde 1 temporäre <PowerIconKeywords:Kraft> und Tentakelschaden"
  },
  RelicConfig_13923_Desc = {
    Text = "Für jeden verursachten Schaden erhältst du [Arg1] Schild. Zu Beginn jeder Runde erhältst du für je 3 verbleibende Schilde 1 temporäre <PowerIconKeywords:Kraft> und Tentakelschaden"
  },
  RelicConfig_13923_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Geheimnis“>"
  },
  RelicConfig_13924_BattleDesc = {
    Text = "Jedes Mal, wenn der <TransitionIconKeywords:Sprung> Effekt ausgelöst wird, stehle allen Feinden [Arg1] temporäre <PowerIconKeywords:Stärke>. Wenn nur ein Feind vorhanden ist, stehle zusätzlich [Arg2] temporäre <PowerIconKeywords:Stärke>"
  },
  RelicConfig_13924_Desc = {
    Text = "Jedes Mal, wenn der <TransitionIconKeywords:Sprung> Effekt ausgelöst wird, stehle allen Feinden [Arg1] temporäre <PowerIconKeywords:Stärke>. Wenn nur ein Feind vorhanden ist, stehle zusätzlich [Arg2] temporäre <PowerIconKeywords:Stärke>"
  },
  RelicConfig_13924_Name = {
    Text = "<OrangeQuality:Raumverzerrer>"
  },
  RelicConfig_13924_StoryDesc = {
    Text = "Sprung ins Nichts"
  },
  RelicConfig_13925_BattleDesc = {
    Text = "Zu Rundenbeginn ziehen Sie 1 Karte. Wenn Sie 2 Mal hintereinander eine Karte mit dem gleichen Arithmetica-Verbrauch wie die vorherige Karte spielen, ziehen Sie zusätzlich 1 Karte, maximal 3 Mal pro Runde"
  },
  RelicConfig_13925_Desc = {
    Text = "Zu Rundenbeginn ziehen Sie 1 Karte. Wenn Sie 2 Mal hintereinander eine Karte mit dem gleichen Arithmetica-Verbrauch wie die vorherige Karte spielen, ziehen Sie zusätzlich 1 Karte, maximal 3 Mal pro Runde"
  },
  RelicConfig_13925_Name = {
    Text = "<OrangeQuality:Allwissenheitsritual>"
  },
  RelicConfig_13925_StoryDesc = {
    Text = "Allwissend und allmächtig"
  },
  RelicConfig_13926_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhält man für jede 1 Orison im Deck [Arg1] Punkte<PowerIconKeywords:Macht>, für jede 1 Relikt wird [Arg2] Punkte Leben wiederhergestellt"
  },
  RelicConfig_13926_Desc = {
    Text = "Zu Beginn des Kampfes erhält man für jede 1 Orison im Deck [Arg1] Punkte<PowerIconKeywords:Macht>, für jede 1 Relikt wird [Arg2] Punkte Leben wiederhergestellt"
  },
  RelicConfig_13926_Name = {
    Text = "<OrangeQuality:☆Gildenmedaille☆>"
  },
  RelicConfig_13926_StoryDesc = {
    Text = "“Setz es auf, und du bist ein Mitglied der Lentinen-Handelsgesellschaft.“"
  },
  RelicConfig_13927_BattleDesc = {
    Text = "Beim Aufnehmen wird 1 Symptomkarte entfernt. 1 zufälliges Relikt wird auf ein fortgeschrittenes Relikt aufgewertet"
  },
  RelicConfig_13927_Desc = {
    Text = "Beim Aufnehmen wird 1 Symptomkarte entfernt. 1 zufälliges Relikt wird auf ein fortgeschrittenes Relikt aufgewertet"
  },
  RelicConfig_13927_Name = {
    Text = "<WhiteQuality:Glückshasenpfote>"
  },
  RelicConfig_13927_StoryDesc = {
    Text = "Für das Kaninchen war es nicht so glücklich"
  },
  RelicConfig_13928_BattleDesc = {
    Text = "Kritische Rate erhöht um 15%. Für jede gespielte Karte erhöht sich die temporäre kritische Rate um 5%"
  },
  RelicConfig_13928_Desc = {
    Text = "Kritische Rate erhöht um 15%. Für jede gespielte Karte erhöht sich die temporäre kritische Rate um 5%"
  },
  RelicConfig_13928_Name = {
    Text = "<OrangeQuality:Memphis-Ritualspiegel>"
  },
  RelicConfig_13928_StoryDesc = {
    Text = "“Was hast du darin gesehen?“"
  },
  RelicConfig_13929_BattleDesc = {
    Text = "Jedes Mal, wenn du LP verlierst, erhalte [Arg1] <plural value=\"[Arg1]\" singular=\"Stapelung\" plural=\"Stapelungen\"> <RetaliateIconKeywords:Gegenangriff>. Wenn dies der 3. Auslöser in einem einzelnen Zug ist, löse 100% <RetaliateIconKeywords:Gegenangriff> gegen alle Gegner aus."
  },
  RelicConfig_13929_Desc = {
    Text = "Jedes Mal, wenn du LP verlierst, erhalte [Arg1] <plural value=\"[Arg1]\" singular=\"Stapelung\" plural=\"Stapelungen\"> <RetaliateIconKeywords:Gegenangriff>. Wenn dies der 3. Auslöser in einem einzelnen Zug ist, löse 100% <RetaliateIconKeywords:Gegenangriff> gegen alle Gegner aus."
  },
  RelicConfig_13929_Name = {
    Text = "<WhiteQuality:Erinnerungstaschenuhr>"
  },
  RelicConfig_13929_StoryDesc = {
    Text = "Mit Erinnerungen und Trauer vorwärts ins Unbekannte"
  },
  RelicConfig_13930_BattleDesc = {
    Text = "Am Ende der Runde füge allen Feinden [Arg1] Schicht <IntoxicationIconKeywords:Vergiftung> für jede Karte in deiner Hand hinzu"
  },
  RelicConfig_13930_Desc = {
    Text = "Am Ende der Runde füge allen Feinden [Arg1] Schicht <IntoxicationIconKeywords:Vergiftung> für jede Karte in deiner Hand hinzu"
  },
  RelicConfig_13930_Name = {
    Text = "<WhiteQuality:Verdächtige Salbe>"
  },
  RelicConfig_13930_StoryDesc = {
    Text = "Eine selbstgemachte Wundsalbe, bitte nicht ohne ärztlichen Rat verwenden"
  },
  RelicConfig_13931_BattleDesc = {
    Text = "Nach dem Aufheben erhält man [Arg1] <PowerIconKeywords:Kraft>. Jedes Mal, wenn ein <DerivativeCardKeywords_2:“Embryo“> fusioniert wird, erhält man [Arg2] temporäre <PowerIconKeywords:Kraft>"
  },
  RelicConfig_13931_Desc = {
    Text = "Nach dem Aufheben erhält man [Arg1] <PowerIconKeywords:Kraft>. Jedes Mal, wenn ein <DerivativeCardKeywords_2:“Embryo“> fusioniert wird, erhält man [Arg2] temporäre <PowerIconKeywords:Kraft>"
  },
  RelicConfig_13931_Name = {
    Text = "<WhiteQuality:Blutiger Kiesel>"
  },
  RelicConfig_13931_StoryDesc = {
    Text = "Eins, zwei, drei, vier, fünf"
  },
  RelicConfig_13932_BattleDesc = {
    Text = "Nach jedem 3. Einsatz von „VERT“ erhalte [Arg1] Schild, erhalte 15 Wahnsinn für das entsprechende Erwachen"
  },
  RelicConfig_13932_Desc = {
    Text = "Nach jedem 3. Einsatz von „VERT“ erhalte [Arg1] Schild, erhalte 15 Wahnsinn für das entsprechende Erwachen"
  },
  RelicConfig_13932_Name = {
    Text = "<WhiteQuality:Schweigehandschuhe>"
  },
  RelicConfig_13932_StoryDesc = {
    Text = "Sie waren mit unzähligen Blut, Tränen und Schimmel befleckt"
  },
  RelicConfig_13933_BattleDesc = {
    Text = "Das ist ein wirksames Wochenrelikt 6"
  },
  RelicConfig_13933_Desc = {
    Text = "Das ist ein wirksames Wochenrelikt 6"
  },
  RelicConfig_13933_Name = {
    Text = "Wöchentliche Herausforderung 6"
  },
  RelicConfig_13934_BattleDesc = {
    Text = "Das ist ein wirksames Wochenrelikt 5"
  },
  RelicConfig_13934_Desc = {
    Text = "Das ist ein wirksames Wochenrelikt 5"
  },
  RelicConfig_13934_Name = {
    Text = "Wöchentliche Herausforderung 5"
  },
  RelicConfig_13935_BattleDesc = {
    Text = "Kritische Rate +10%. Nach dem ersten kritischen Treffer in jeder Runde erhöht sich die kritische Rate um 20%. Nach dem dritten kritischen Treffer in jeder Runde erhöht sich der kritische Schaden um 50%"
  },
  RelicConfig_13935_Desc = {
    Text = "Kritische Rate +10%. Nach dem ersten kritischen Treffer in jeder Runde erhöht sich die kritische Rate um 20%. Nach dem dritten kritischen Treffer in jeder Runde erhöht sich der kritische Schaden um 50%"
  },
  RelicConfig_13935_Name = {
    Text = "<WhiteQuality:Festtagssegen>"
  },
  RelicConfig_13935_StoryDesc = {
    Text = "Es sollte Liebenden Segen bringen"
  },
  RelicConfig_13936_BattleDesc = {
    Text = "Das ist ein wirksames Wochenrelikt 3"
  },
  RelicConfig_13936_Desc = {
    Text = "Das ist ein wirksames Wochenrelikt 3"
  },
  RelicConfig_13936_Name = {
    Text = "Wöchentliche Herausforderung 3"
  },
  RelicConfig_13937_BattleDesc = {
    Text = "Das ist ein wirksames Wochenrelikt 2"
  },
  RelicConfig_13937_Desc = {
    Text = "Das ist ein wirksames Wochenrelikt 2"
  },
  RelicConfig_13937_Name = {
    Text = "Wöchentliche Herausforderung 2"
  },
  RelicConfig_13938_BattleDesc = {
    Text = "Das ist ein wirksames Wochenrelikt 1"
  },
  RelicConfig_13938_Desc = {
    Text = "Das ist ein wirksames Wochenrelikt 1"
  },
  RelicConfig_13938_Name = {
    Text = "Wöchentliche Herausforderung 1"
  },
  RelicConfig_13939_BattleDesc = {
    Text = "Zu Beginn der 3. Runde, kritische Rate im Kampf +15%, füge 1 Karte <DerivativeCardKeywords_39:“Echos der Vergangenheit“> deiner Hand hinzu"
  },
  RelicConfig_13939_Desc = {
    Text = "Zu Beginn der 3. Runde, kritische Rate im Kampf +15%, füge 1 Karte <DerivativeCardKeywords_39:“Echos der Vergangenheit“> deiner Hand hinzu"
  },
  RelicConfig_13939_Name = {
    Text = "<OrangeQuality:Opfergaben der Vergangenheit>"
  },
  RelicConfig_13939_StoryDesc = {
    Text = "Einst geopferte Gegenstände"
  },
  RelicConfig_13940_BattleDesc = {
    Text = "Wenn du ein Schild hast, gewährt dieses Artefakt [Arg1] temporäre <PowerIconKeywords:Kraft>. Wenn dein Schild höher ist als dein aktuelles Leben, gewährt es zusätzlich [Arg2] temporäre <PowerIconKeywords:Kraft>"
  },
  RelicConfig_13940_Desc = {
    Text = "Wenn du ein Schild hast, gewährt dieses Artefakt [Arg1] temporäre <PowerIconKeywords:Kraft>. Wenn dein Schild höher ist als dein aktuelles Leben, gewährt es zusätzlich [Arg2] temporäre <PowerIconKeywords:Kraft>"
  },
  RelicConfig_13940_Name = {
    Text = "<WhiteQuality:Taubenfederfächer>"
  },
  RelicConfig_13940_StoryDesc = {
    Text = "Fein, teuer, aber nicht sehr praktisch"
  },
  RelicConfig_13941_BattleDesc = {
    Text = "“Schlag“ stellt [Arg1] Lebenspunkte wieder her, reduziert [Arg1] Schichten <IntoxicationIconKeywords:Vergiftung>"
  },
  RelicConfig_13941_Desc = {
    Text = "“Schlag“ stellt [Arg1] Lebenspunkte wieder her, reduziert [Arg1] Schichten <IntoxicationIconKeywords:Vergiftung>"
  },
  RelicConfig_13941_Name = {
    Text = "<WhiteQuality:Blutstillzange>"
  },
  RelicConfig_13941_StoryDesc = {
    Text = "“Schnell, gib es mir!“"
  },
  RelicConfig_13942_BattleDesc = {
    Text = "Für jeden Tentakel erhält man am Ende des Zuges [Arg1] Punkte Schild. Wenn der Tentakel im Zustand des stillen Meeres ist, erhält dieser Effekt zusätzlich 50% Schild"
  },
  RelicConfig_13942_Desc = {
    Text = "Für jeden Tentakel erhält man am Ende des Zuges [Arg1] Punkte Schild. Wenn der Tentakel im Zustand des stillen Meeres ist, erhält dieser Effekt zusätzlich 50% Schild"
  },
  RelicConfig_13942_Name = {
    Text = "<WhiteQuality:Unbekanntes Glied>"
  },
  RelicConfig_13942_StoryDesc = {
    Text = "Vorsicht, es ist scharf"
  },
  RelicConfig_139929_BattleDesc = {
    Text = "Zu Zugbeginn erhält Shaye [Arg1] Aliemus. Für je 100 durch Shayes Verherrlichung verbrauchte Aliemus wird ein zufällig generierter „Skill\" 1 zusätzliches Mal ausgelöst."
  },
  RelicConfig_139929_Desc = {
    Text = "Zu Zugbeginn erhält Shaye [Arg1] Aliemus. Für je 100 durch Shayes Verherrlichung verbrauchte Aliemus wird ein zufällig generierter „Skill\" 1 zusätzliches Mal ausgelöst."
  },
  RelicConfig_139929_Name = {
    Text = "<OrangeQuality:Dimensionsbild·Shaye>"
  },
  RelicConfig_140276_BattleDesc = {
    Text = "<OrangeQuality:Verzweiflung>: Zu Rundenbeginn wird pro 1% verlorener maximaler LP der temporäre Endschaden um 5% erhöht. Falls in der letzten Runde Todeswiderstand ausgelöst wurde, wird dieser Effekt verdoppelt.\n<RedQuality:Suprematie>: Die maximalen LP aller Feinde werden um 300% erhöht."
  },
  RelicConfig_140276_Desc = {
    Text = "<OrangeQuality:Verzweiflung>: Zu Rundenbeginn wird pro 1% verlorener maximaler LP der temporäre Endschaden um 5% erhöht. Falls in der letzten Runde Todeswiderstand ausgelöst wurde, wird dieser Effekt verdoppelt.\n<RedQuality:Suprematie>: Die maximalen LP aller Feinde werden um 300% erhöht."
  },
  RelicConfig_140276_Name = {
    Text = "<RedQuality:Dimension-Pendel-Überlebenskampf>"
  },
  RelicConfig_140277_BattleDesc = {
    Text = "<OrangeQuality:Proliferation>: Wenn ein Erwachter pro Runde zum ersten Mal eine „Fertigkeit\" ausspielt, werden 2 temporäre Originalkopien davon erzeugt. Beim Ausspielen von Befehlskarten mit Rechenleistungskosten von 0 oder 1 erhalten alle Erwachten 5 Punkte Raserei.\n<RedQuality:Festung>: Beim Ausspielen von Karten mit ursprünglichen Rechenleistungskosten von 3 oder mehr erhalten alle Feinde einen Schild in Höhe von 20% ihrer maximalen LP."
  },
  RelicConfig_140277_Desc = {
    Text = "<OrangeQuality:Proliferation>: Wenn ein Erwachter pro Runde zum ersten Mal eine „Fertigkeit\" ausspielt, werden 2 temporäre Originalkopien davon erzeugt. Beim Ausspielen von Befehlskarten mit Rechenleistungskosten von 0 oder 1 erhalten alle Erwachten 5 Punkte Raserei.\n<RedQuality:Festung>: Beim Ausspielen von Karten mit ursprünglichen Rechenleistungskosten von 3 oder mehr erhalten alle Feinde einen Schild in Höhe von 20% ihrer maximalen LP."
  },
  RelicConfig_140277_Name = {
    Text = "<RedQuality:Dimensionspendel–Wachsam>"
  },
  RelicConfig_140278_BattleDesc = {
    Text = "<OrangeQuality:Regeneration>: Erhaltene Schild– und Heilungseffekte werden um 25% erhöht. Bei Lebensheilung oder Schilderhalt wird pro 1% maximaler LP an Heilung oder Schildeffekt 10% temporäre Schadensverstärkung erhalten.\n<RedQuality:Flüstern>: Pro Runde wird eine Stärkeverringerung in Höhe von 10% der maximalen LP erhalten."
  },
  RelicConfig_140278_Desc = {
    Text = "<OrangeQuality:Regeneration>: Erhaltene Schild– und Heilungseffekte werden um 25% erhöht. Bei Lebensheilung oder Schilderhalt wird pro 1% maximaler LP an Heilung oder Schildeffekt 10% temporäre Schadensverstärkung erhalten.\n<RedQuality:Flüstern>: Pro Runde wird eine Stärkeverringerung in Höhe von 10% der maximalen LP erhalten."
  },
  RelicConfig_140278_Name = {
    Text = "<RedQuality:Dimensionspendel–Schrecken>"
  },
  RelicConfig_140279_BattleDesc = {
    Text = "<OrangeQuality:Morgendämmerung>: Die Basis–Raserei aller Erwachten wird um 30 Punkte gesenkt. Der Endschaden der ersten Raserei–Eruption pro Runde wird um 200% erhöht, Schild– und Lebensregeneration um 100%. Nach jeweils 5 Raserei–Eruptionen wird 1 Erwachter zum Erwachen ausgewählt und der Verstärkungseffekt der Raserei–Eruption wird aufgefrischt.\n<RedQuality:Erschöpfung>: Die Basis–Silberschlüssel–Energie wird um 200% erhöht."
  },
  RelicConfig_140279_Desc = {
    Text = "<OrangeQuality:Morgendämmerung>: Die Basis–Raserei aller Erwachten wird um 30 Punkte gesenkt. Der Endschaden der ersten Raserei–Eruption pro Runde wird um 200% erhöht, Schild– und Lebensregeneration um 100%. Nach jeweils 5 Raserei–Eruptionen wird 1 Erwachter zum Erwachen ausgewählt und der Verstärkungseffekt der Raserei–Eruption wird aufgefrischt.\n<RedQuality:Erschöpfung>: Die Basis–Silberschlüssel–Energie wird um 200% erhöht."
  },
  RelicConfig_140279_Name = {
    Text = "<RedQuality:Dimensionspendel–Voodoo>"
  },
  RelicConfig_140280_BattleDesc = {
    Text = "<OrangeQuality:Erwachen>: Nach der ersten Raserei–Eruption pro Runde wird die Abklingzeit der Raserei–Eruption dieses Erwachten zurückgesetzt und er erhält 50 Raserei. Es werden temporäre Kopien aller „Fertigkeiten\" mit Rechenleistungskosten von 0 erzeugt.\n<RedQuality:Siegel>: Nach der ersten Raserei–Eruption pro Runde werden die anderen Erwachten versiegelt."
  },
  RelicConfig_140280_Desc = {
    Text = "<OrangeQuality:Erwachen>: Nach der ersten Raserei–Eruption pro Runde wird die Abklingzeit der Raserei–Eruption dieses Erwachten zurückgesetzt und er erhält 50 Raserei. Es werden temporäre Kopien aller „Fertigkeiten\" mit Rechenleistungskosten von 0 erzeugt.\n<RedQuality:Siegel>: Nach der ersten Raserei–Eruption pro Runde werden die anderen Erwachten versiegelt."
  },
  RelicConfig_140280_Name = {
    Text = "<RedQuality:Dimensionspendel–Duell>"
  },
  RelicConfig_140281_BattleDesc = {
    Text = "<OrangeQuality:Echo>: Zu Rundenbeginn werden die 3 Befehlskarten mit den höchsten Rechenleistungskosten aus dem Ziehstapel gezogen. Die erste ausgespielte Befehlskarte pro Runde wird 2–mal ausgelöst.\n<RedQuality:Benommenheit>: Nach dem Ausspielen einer Befehlskarte werden alle anderen Befehlskarten abgeworfen, deren Rechenleistungskosten nicht niedriger sind."
  },
  RelicConfig_140281_Desc = {
    Text = "<OrangeQuality:Echo>: Zu Rundenbeginn werden die 3 Befehlskarten mit den höchsten Rechenleistungskosten aus dem Ziehstapel gezogen. Die erste ausgespielte Befehlskarte pro Runde wird 2–mal ausgelöst.\n<RedQuality:Benommenheit>: Nach dem Ausspielen einer Befehlskarte werden alle anderen Befehlskarten abgeworfen, deren Rechenleistungskosten nicht niedriger sind."
  },
  RelicConfig_140281_Name = {
    Text = "<RedQuality:Dimension-Pendel-Verwirrung>"
  },
  RelicConfig_140282_BattleDesc = {
    Text = "<OrangeQuality:Große Macht>: Die von allen Erwachten verursachte <PowerIconKeywords:Stärke> wird um 50% erhöht. Bei jedem verursachten Schadenseffekt werden [Arg2] Punkte temporäre <PowerIconKeywords:Stärke> erhalten.\n<RedQuality:Formlos>: Zu Kampfbeginn erhalten alle Feinde 50 Stapel <ParcloseIconKeywords:Barriere>."
  },
  RelicConfig_140282_Desc = {
    Text = "<OrangeQuality:Große Macht>: Die von allen Erwachten verursachte <PowerIconKeywords:Stärke> wird um 50% erhöht. Bei jedem verursachten Schadenseffekt werden [Arg2] Punkte temporäre <PowerIconKeywords:Stärke> erhalten.\n<RedQuality:Formlos>: Zu Kampfbeginn erhalten alle Feinde 50 Stapel <ParcloseIconKeywords:Barriere>."
  },
  RelicConfig_140282_Name = {
    Text = "<RedQuality:Dimensionspendel–Lauern>"
  },
  RelicConfig_140840_BattleDesc = {
    Text = "Maximale Handgröße +1. Zu Kampfbeginn wird 1 „<DerivativeCardKeywords_148:Albtraumreiter>\"-Karte in die Hand gelegt. Wenn der „Basisschlag\" eines Erweckten Körpers gespielt wird, sinken die Arithmetica-Kosten des „<DerivativeCardKeywords_148:Albtraumreiters>\" um 1 und alle Feinde erleiden [Arg1] Korrosion. Wenn die „Basisverteidigung\" eines Erweckten Körpers gespielt wird, erhält man [Arg2] Stärke und der Gesamtschaden-Effekt sowie die Stärke des nächsten gespielten „<DerivativeCardKeywords_148:Albtraumreiters>\" werden um [Arg3] % erhöht."
  },
  RelicConfig_140840_Desc = {
    Text = "Maximale Handgröße +1. Zu Kampfbeginn wird 1 „<DerivativeCardKeywords_148:Albtraumreiter>\"-Karte in die Hand gelegt. Wenn der „Basisschlag\" eines Erweckten Körpers gespielt wird, sinken die Arithmetica-Kosten des „<DerivativeCardKeywords_148:Albtraumreiters>\" um 1 und alle Feinde erleiden [Arg1] Korrosion. Wenn die „Basisverteidigung\" eines Erweckten Körpers gespielt wird, erhält man [Arg2] Stärke und der Gesamtschaden-Effekt sowie die Stärke des nächsten gespielten „<DerivativeCardKeywords_148:Albtraumreiters>\" werden um [Arg3] % erhöht."
  },
  RelicConfig_140840_Name = {
    Text = "Die vergebliche Mühe"
  },
  RelicConfig_140840_StoryDesc = {
    Text = "Der Vergebliche fürchtet Veränderung, fürchtet, dass Dinge seiner Kontrolle entgleiten, und in seinem tiefsten Inneren fürchtet er in Hysterie den Verlust.\n Er bläst immer wieder Die Pfeife, um durch ihren Klang alles zu beherrschen, doch er konnte nichts festhalten."
  },
  RelicConfig_143665_BattleDesc = {
    Text = "Pontos erhält [Arg1] Aliemus zu Beginn des Zuges. Beim Aufheben werden zu Beginn des nächsten Kampfes 3 Permanent-„Der Knechtgaunt\"-Karten generiert. Pontos erhält 3 Aliemus, nachdem ein „Der Knechtgaunt\" gespielt wurde."
  },
  RelicConfig_143665_Desc = {
    Text = "Pontos erhält [Arg1] Aliemus zu Beginn des Zuges. Beim Aufheben werden zu Beginn des nächsten Kampfes 3 Permanent-„Der Knechtgaunt\"-Karten generiert. Pontos erhält 3 Aliemus, nachdem ein „Der Knechtgaunt\" gespielt wurde."
  },
  RelicConfig_143665_Name = {
    Text = "<OrangeQuality:Dimensionsbild: Pontos>"
  },
  RelicConfig_145438_BattleDesc = {
    Text = "Zu Beginn des Zuges [Arg1] Aliemus erhalten. Nach dem Einsetzen von „Mundus-Trennung\" wird zu Beginn des nächsten Zuges die Verfolgung: „Netherklinge\" ausgeführt: Fügt allen Gegnern Schaden in Höhe von 400 % des ANG von Lotan: Cetarchon zu. Diese Verfolgung profitiert vom Schadenbonus, den „Mundus-Trennung\" durch „Große Klinge: Walfall\" erhält, und gilt als „Schlag\"."
  },
  RelicConfig_145438_Desc = {
    Text = "Zu Beginn des Zuges [Arg1] Aliemus erhalten. Nach dem Einsetzen von „Mundus-Trennung\" wird zu Beginn des nächsten Zuges die Verfolgung: „Netherklinge\" ausgeführt: Fügt allen Gegnern Schaden in Höhe von 400 % des ANG von Lotan: Cetarchon zu. Diese Verfolgung profitiert vom Schadenbonus, den „Mundus-Trennung\" durch „Große Klinge: Walfall\" erhält, und gilt als „Schlag\"."
  },
  RelicConfig_145438_Name = {
    Text = "<OrangeQuality:Dimensionsbild: Lotan: Cetarchon>"
  },
  RelicConfig_146128_BattleDesc = {
    Text = "Maximale Handgröße +1. Zu Beginn des Kampfes oder nachdem du „<DerivativeCardKeywords_157:Knochen des Schwertes>\" gespielt hast, lege 1 „<DerivativeCardKeywords_155:Knochen des Wahnsinns>\" auf die Hand und mische 1 „<DerivativeCardKeywords_156:Knochen des Schmerzes>\" in den Ziehstapel. Wenn du in einer Runde sowohl „<DerivativeCardKeywords_155:Knochen des Wahnsinns>\" als auch „<DerivativeCardKeywords_156:Knochen des Schmerzes>\" spielst, verschmelze diese beiden Karten zu „<DerivativeCardKeywords_157:Knochen des Schwertes>\" und lege sie auf die Hand."
  },
  RelicConfig_146128_Desc = {
    Text = "Maximale Handgröße +1. Zu Beginn des Kampfes oder nachdem du „<DerivativeCardKeywords_157:Knochen des Schwertes>\" gespielt hast, lege 1 „<DerivativeCardKeywords_155:Knochen des Wahnsinns>\" auf die Hand und mische 1 „<DerivativeCardKeywords_156:Knochen des Schmerzes>\" in den Ziehstapel. Wenn du in einer Runde sowohl „<DerivativeCardKeywords_155:Knochen des Wahnsinns>\" als auch „<DerivativeCardKeywords_156:Knochen des Schmerzes>\" spielst, verschmelze diese beiden Karten zu „<DerivativeCardKeywords_157:Knochen des Schwertes>\" und lege sie auf die Hand."
  },
  RelicConfig_146128_Name = {
    Text = "Rüstung aus Walknochen"
  },
  RelicConfig_146128_StoryDesc = {
    Text = "Die Knochen von Leviathan schützen die Auserwählten und machen sie unbesiegbar und unsterblich."
  },
  RelicConfig_147547_BattleDesc = {
    Text = "Zu Beginn jeder Runde erhält Casiah [Arg1] Wahnsinn. Für jede gezogene Karte erhält Casiah zusätzlich [Arg2] Wahnsinn. Wenn Casiah ihre Wahnsinnsexplosion aktiviert, verlieren alle Feinde [Arg3] Stärkepunkte."
  },
  RelicConfig_147547_Desc = {
    Text = "Zu Beginn jeder Runde erhält Casiah [Arg1] Wahnsinn. Für jede gezogene Karte erhält Casiah zusätzlich [Arg2] Wahnsinn. Wenn Casiah ihre Wahnsinnsexplosion aktiviert, verlieren alle Feinde [Arg3] Stärkepunkte."
  },
  RelicConfig_147547_Name = {
    Text = "<OrangeQuality:Dimensionales Abbild – Cassia>"
  },
  RelicConfig_147665_BattleDesc = {
    Text = "Arithmetica-Grenze und Ziehen pro Runde +1. Zu Rundenbeginn <FaxianKeywords:Entdecken> 3 „<Caroboo_Tips:Pistoles de Marie>“ und wähle eine davon. Nur 1 davon ist echt: Wählt man die echte, erhält man ihren positiven Effekt und zerstreut einen zufälligen negativen Zustand an sich selbst; wählt man die falsche, erleidet man ihren negativen Effekt und beim nächsten <FaxianKeywords:Entdecken> erhöht sich die Anzahl echter Optionen um +1 und der Effekt verdoppelt sich – nach Auswahl der echten wird dies zurückgesetzt."
  },
  RelicConfig_147665_Desc = {
    Text = "Arithmetica-Grenze und Ziehen pro Runde +1. Zu Rundenbeginn <FaxianKeywords:Entdecken> 3 „<Caroboo_Tips:Pistoles de Marie>“ und wähle eine davon. Nur 1 davon ist echt: Wählt man die echte, erhält man ihren positiven Effekt und zerstreut einen zufälligen negativen Zustand an sich selbst; wählt man die falsche, erleidet man ihren negativen Effekt und beim nächsten <FaxianKeywords:Entdecken> erhöht sich die Anzahl echter Optionen um +1 und der Effekt verdoppelt sich – nach Auswahl der echten wird dies zurückgesetzt."
  },
  RelicConfig_147665_Name = {
    Text = "Pistoles de Marie"
  },
  RelicConfig_147665_StoryDesc = {
    Text = "Süß und kostbar... oder doch nicht?"
  },
  RelicConfig_148525_BattleDesc = {
    Text = "Zu Beginn des Zuges erhält Eidgebundener · Ogier [Arg1] Aliemus, und „Dunkler Surge“ reduziert die Anzahl der Züge nicht mehr."
  },
  RelicConfig_148525_Desc = {
    Text = "Zu Beginn des Zuges erhält Eidgebundener · Ogier [Arg1] Aliemus, und „Dunkler Surge“ reduziert die Anzahl der Züge nicht mehr."
  },
  RelicConfig_148525_Name = {
    Text = "<OrangeQuality:Dimensionsbild·Negativeid·Ogier>"
  },
  RelicConfig_149665_BattleDesc = {
    Text = "Das aktuelle Gelände gilt als „Eisfeld.“\nIn Hyperborea: Nach der Ziehphase werden auf die 2 nicht eingefrorenen Befehlskarten mit den höchsten Arithmetica-Kosten auf der Hand je 1 Stapel <SlowIconKeywords:Stagnierung> und <RetainIconKeywords:Behalten> angewendet. Wenn eine Befehlskarte mindestens 3 Stapel <SlowIconKeywords:Stagnierung> hat, werden ihre <SlowIconKeywords:Stagnierung> und <RetainIconKeywords:Behalten> (aus diesem Kampf erhalten) entfernt, sie wird eingefroren und erhält 25 Stapel <TempPowerKeywords2:Verstärkung>."
  },
  RelicConfig_149665_Desc = {
    Text = "Das aktuelle Gelände gilt als „Eisfeld.“\nIn Hyperborea: Nach der Ziehphase werden auf die 2 nicht eingefrorenen Befehlskarten mit den höchsten Arithmetica-Kosten auf der Hand je 1 Stapel <SlowIconKeywords:Stagnierung> und <RetainIconKeywords:Behalten> angewendet. Wenn eine Befehlskarte mindestens 3 Stapel <SlowIconKeywords:Stagnierung> hat, werden ihre <SlowIconKeywords:Stagnierung> und <RetainIconKeywords:Behalten> (aus diesem Kampf erhalten) entfernt, sie wird eingefroren und erhält 25 Stapel <TempPowerKeywords2:Verstärkung>."
  },
  RelicConfig_149665_Name = {
    Text = "<OrangeQuality:Kristallkugel>"
  },
  RelicConfig_149665_StoryDesc = {
    Text = "Es bringt nicht die Kälte.\nEs erinnert die Erde nur daran, dass der Winter nie gegangen ist."
  },
  RelicConfig_20164_BattleDesc = {
    Text = "Für jeden verursachten Schaden erhältst du [Arg1] Punkte temporäre <PowerIconKeywords:Macht>, maximal 5 Schichten. Bei maximalen Schichten erhältst du [Arg1] Punkte <PowerIconKeywords:Macht>"
  },
  RelicConfig_20164_Desc = {
    Text = "Für jeden verursachten Schaden erhältst du [Arg1] Punkte temporäre <PowerIconKeywords:Macht>, maximal 5 Schichten. Bei maximalen Schichten erhältst du [Arg1] Punkte <PowerIconKeywords:Macht>"
  },
  RelicConfig_20164_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Wachlos“>"
  },
  RelicConfig_20165_BattleDesc = {
    Text = "Beim Aufheben werden alle Erwecker erweckt. Nach dem Ausspielen von <ExaltIconKeywords:Gnosis wecken> erhält man zufällig 2 Befehlskarten dieses Erweckers und fügt „erschöpfen“ und „Nichtigkeit“ hinzu"
  },
  RelicConfig_20165_Desc = {
    Text = "Beim Aufheben werden alle Erwecker erweckt. Nach dem Ausspielen von <ExaltIconKeywords:Gnosis wecken> erhält man zufällig 2 Befehlskarten dieses Erweckers und fügt „erschöpfen“ und „Nichtigkeit“ hinzu"
  },
  RelicConfig_20165_Name = {
    Text = "<OrangeQuality:Sein Orakel+>"
  },
  RelicConfig_20165_StoryDesc = {
    Text = "Er sagte, fürchte dich nicht"
  },
  RelicConfig_20166_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Reichsbeherrschung> +100. Die erste Karte jeder Runde zurück auf die Hand legen. Zu Beginn der Hyperrunde: Handkartenlimit +5 und deine Handkarten kopieren"
  },
  RelicConfig_20166_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Reichsbeherrschung> +100. Lege die erste Karte, die in jeder Runde gespielt wird, aus dem Ablagestapel zurück auf die Hand. Zu Beginn der Ultra-Runde: Handkartenlimit +5 und kopiere deine Handkarten, die kopierten Karten erhalten <NothingnessIconKeywords:Nichtigkeit> und <DepleteIconKeywords:Verbrauch>."
  },
  RelicConfig_20166_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Traum rauben“>"
  },
  RelicConfig_20167_BattleDesc = {
    Text = "Am Ende der Runde, gibt es überschüssige Arithmetica, zieht man in der nächsten Runde zusätzlich 2 Karten; wenn übrig gebliebene Handkarten, erhält man in der nächsten Runde zusätzlich 2 Arithmetica"
  },
  RelicConfig_20167_Desc = {
    Text = "Am Ende der Runde, gibt es überschüssige Arithmetica, zieht man in der nächsten Runde zusätzlich 2 Karten; wenn übrig gebliebene Handkarten, erhält man in der nächsten Runde zusätzlich 2 Arithmetica"
  },
  RelicConfig_20167_Name = {
    Text = "<OrangeQuality:Sonnen-Mond-Rad+>"
  },
  RelicConfig_20167_StoryDesc = {
    Text = "Rate mal, schwarz oder weiß?"
  },
  RelicConfig_20168_BattleDesc = {
    Text = "Tentakelobergrenze +2. Nach der Auslösung von Exaltieren, Tentakelschaden +[Arg1]. Wenn in einer Runde 3-mal Exaltieren ausgelöst wird, werden alle Tentakel einmal aktiviert"
  },
  RelicConfig_20168_Desc = {
    Text = "Tentakelobergrenze +2. Nach der Auslösung von Exaltieren, Tentakelschaden +[Arg1]. Wenn in einer Runde 3-mal Exaltieren ausgelöst wird, werden alle Tentakel einmal aktiviert"
  },
  RelicConfig_20168_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Leichter Schlaf“>"
  },
  RelicConfig_20169_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:Reichsbeherrschung> +100. Für jede gespielte Karte <EmbryoFusionIconKeywords:Embryofusion> +10; wenn die LP unter 25% fallen, erhöht sich auf 20%. Maximal 10 Mal pro Runde aktiv"
  },
  RelicConfig_20169_Desc = {
    Text = "<ProficientInRealmsIconKeywords:Reichsbeherrschung> +100. Für jede gespielte Karte <EmbryoFusionIconKeywords:Embryofusion> +10; wenn die LP unter 25% fallen, erhöht sich auf 20%. Maximal 10 Mal pro Runde aktiv"
  },
  RelicConfig_20169_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Strömung“>"
  },
  RelicConfig_20170_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhält jeder Erwecker 50 Punkte Aelius. Lege 2 Karten<DerivativeCardKeywords_1:„Nachklang der Schatten“> in die Hand"
  },
  RelicConfig_20170_Desc = {
    Text = "Zu Beginn des Kampfes erhält jeder Erwecker 50 Punkte Aelius. Lege 2 Karten<DerivativeCardKeywords_1:„Nachklang der Schatten“> in die Hand"
  },
  RelicConfig_20170_Name = {
    Text = "<OrangeQuality:Kommunikationsgerät+>"
  },
  RelicConfig_20170_StoryDesc = {
    Text = "Erwartung oder Angst vor dem Moment, in dem es klingelt"
  },
  RelicConfig_20171_BattleDesc = {
    Text = "Beim Aufheben erhält man zufällig 1 Silberrelikt, 1 goldenes Relikt und 1 verfluchtes Relikt"
  },
  RelicConfig_20171_Desc = {
    Text = "Beim Aufheben erhält man zufällig 1 Silberrelikt, 1 goldenes Relikt und 1 verfluchtes Relikt"
  },
  RelicConfig_20171_Name = {
    Text = "<OrangeQuality:Umgekehrte Betrachtung+>"
  },
  RelicConfig_20171_StoryDesc = {
    Text = "In seltsamen Epochen sind Blumen die ersten Beobachter der Menschheit.\nBeweg dich nicht, sie bevorzugen ruhige Ausstellungsstücke"
  },
  RelicConfig_20172_BattleDesc = {
    Text = "Erhalte 1 <DerivativeCardKeywords_4:„Inspiration“> bei 3 gespielten Befehlskarten pro Runde, eine weitere bei 6 und wähle zu Beginn der nächsten Runde 2 Karten aus dem Deck"
  },
  RelicConfig_20172_Desc = {
    Text = "Erhalte 1 <DerivativeCardKeywords_4:„Inspiration“> bei 3 gespielten Befehlskarten pro Runde, eine weitere bei 6 und wähle zu Beginn der nächsten Runde 2 Karten aus dem Deck"
  },
  RelicConfig_20172_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Echos“>"
  },
  RelicConfig_20173_BattleDesc = {
    Text = "Schaden gegen Feinde im negativen Zustand um 50% erhöht, 100 Wahnsinn nach dem Töten eines Feindes erhalten"
  },
  RelicConfig_20173_Desc = {
    Text = "Schaden gegen Feinde im negativen Zustand um 50% erhöht, 100 Wahnsinn nach dem Töten eines Feindes erhalten"
  },
  RelicConfig_20173_Name = {
    Text = "<OrangeQuality:Priesterstab+>"
  },
  RelicConfig_20173_StoryDesc = {
    Text = "Unerlaubte Frömmigkeit"
  },
  RelicConfig_20174_BattleDesc = {
    Text = "Beim Aufnehmen: Team-Schadenamplifikation x150%. Zu Beginn des Zuges füge einem zufälligen Gegner [Arg1] <FixedDamage:Reinen SCH> zu. Für jede in diesem Kampf eingesetzte Posse erhöht sich der zugefügte SCH um [Arg2]. Dieser SCH-Bonus profitiert vom Team-Schadenamplifikations-Bonus."
  },
  RelicConfig_20174_Desc = {
    Text = "Beim Aufnehmen: Team-Schadenamplifikation x150%. Zu Beginn des Zuges füge einem zufälligen Gegner [Arg1] <FixedDamage:Reinen SCH> zu. Für jede in diesem Kampf eingesetzte Posse erhöht sich der zugefügte SCH um [Arg2]. Dieser SCH-Bonus profitiert vom Team-Schadenamplifikations-Bonus."
  },
  RelicConfig_20174_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Verloren“>"
  },
  RelicConfig_20175_BattleDesc = {
    Text = "Erhöht den Effekt von<WeaknessIconKeywords:Schwäche> um 8%, den von<VulnerabilityIconKeywords:Verwundbarkeit> um 25%. Beim Anwenden von<WeaknessIconKeywords:Schwäche> oder<VulnerabilityIconKeywords:Verwundbarkeit> wird vorübergehend [Arg1] Punkte<PowerIconKeywords:Stärke> des Ziels gestohlen"
  },
  RelicConfig_20175_Desc = {
    Text = "Erhöht den Effekt von<WeaknessIconKeywords:Schwäche> um 8%, den von<VulnerabilityIconKeywords:Verwundbarkeit> um 25%. Beim Anwenden von<WeaknessIconKeywords:Schwäche> oder<VulnerabilityIconKeywords:Verwundbarkeit> wird vorübergehend [Arg1] Punkte<PowerIconKeywords:Stärke> des Ziels gestohlen"
  },
  RelicConfig_20175_Name = {
    Text = "<OrangeQuality:Verblasstes Foto+>"
  },
  RelicConfig_20175_StoryDesc = {
    Text = "Verschwommene Fotos tragen verschwommene Erinnerungen, oder vielleicht ist es das Fehlen von Erinnerungen, das die Fotos verblassen lässt."
  },
  RelicConfig_20176_BattleDesc = {
    Text = "Zu Beginn jeder Runde erhält man für jeden Gegner 2 Arithmetica. Wenn man einen Gegner mit aktivem Schaden tötet, erleidet ein anderer Gegner doppelten übermäßigen Schaden durch <BleedingIconKeywords:Bluten>"
  },
  RelicConfig_20176_Desc = {
    Text = "Zu Beginn jeder Runde erhält man für jeden Gegner 2 Arithmetica. Wenn man einen Gegner mit aktivem Schaden tötet, erleidet ein anderer Gegner doppelten übermäßigen Schaden durch <BleedingIconKeywords:Bluten>"
  },
  RelicConfig_20176_Name = {
    Text = "<OrangeQuality:Lied der Massen+>"
  },
  RelicConfig_20176_StoryDesc = {
    Text = "Geboren, um deine Ohren zu quälen"
  },
  RelicConfig_20177_BattleDesc = {
    Text = "Nach dem Aufheben verdoppelt sich der Widerstand gegen den Tod. Nach erlittenem Schaden wird dem Ziel zusätzlich 50% des Schadens als <BleedingIconKeywords:Bluten> auferlegt. Jedes Mal, wenn der Widerstand gegen den Tod ausgelöst wird, wird bei allen Gegnern sofort 1 Mal Bluten ausgelöst"
  },
  RelicConfig_20177_Desc = {
    Text = "Nach dem Aufheben verdoppelt sich der Widerstand gegen den Tod. Nach erlittenem Schaden wird dem Ziel zusätzlich 50% des Schadens als <BleedingIconKeywords:Bluten> auferlegt. Jedes Mal, wenn der Widerstand gegen den Tod ausgelöst wird, wird bei allen Gegnern sofort 1 Mal Bluten ausgelöst"
  },
  RelicConfig_20177_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Auferstehung“>"
  },
  RelicConfig_20178_BattleDesc = {
    Text = "Für jeden verursachten aktiven Schaden erhältst du 3 Punkte Aelius und fügst dem Ziel [Arg1] Schichten <IntoxicationIconKeywords:Gift> hinzu. Wenn die Auslösungen in diesem Kampf 25 erreichen, wird sofort <IntoxicationIconKeywords:Gift> auf alle Gegner aktiviert"
  },
  RelicConfig_20178_Desc = {
    Text = "Für jeden verursachten aktiven Schaden erhältst du 3 Punkte Aelius und fügst dem Ziel [Arg1] Schichten <IntoxicationIconKeywords:Gift> hinzu. Wenn die Auslösungen in diesem Kampf 25 erreichen, wird sofort <IntoxicationIconKeywords:Gift> auf alle Gegner aktiviert"
  },
  RelicConfig_20178_Name = {
    Text = "<OrangeQuality:Staubige Nähmaschine+>"
  },
  RelicConfig_20178_StoryDesc = {
    Text = "Eine liebevolle Mutter, die die Wunden des Herzens näht"
  },
  RelicConfig_21906_BattleDesc = {
    Text = "“Schaden“ erhält 3 Punkte Arithmetica, verworfen zufällig 1 Karte; „VERT“ zieht 3 Karten und verliert 1 Punkt Arithmetica"
  },
  RelicConfig_21906_Desc = {
    Text = "“Schaden“ erhält 3 Punkte Arithmetica, verworfen zufällig 1 Karte; „VERT“ zieht 3 Karten und verliert 1 Punkt Arithmetica"
  },
  RelicConfig_21906_Name = {
    Text = "<RedQuality:Fröhliche Platte+>"
  },
  RelicConfig_21906_StoryDesc = {
    Text = "Aufgenommenes Album des letzten Auftritts des berühmten Geigers.\nSeitdem kann es Feuer bringen"
  },
  RelicConfig_23688_BattleDesc = {
    Text = "Bei jeder Auslösung von Verschlingen erhält man 30 Punkte <EmbryoFusionIconKeywords:Embryo-Fusion> und [Arg1] Punkte <PowerIconKeywords:Kraft>. Wenn es in einer Runde die 2. Auslösung ist, erhält man 1 Punkt Arithmetica und zieht 1 Karte; wenn es die 3. Auslösung in einer Runde ist, erhält man 2 Punkte Arithmetica und zieht 2 Karten."
  },
  RelicConfig_23688_Desc = {
    Text = "Für jede Auslösung von Verschlingen erhältst du 30 Punkte <EmbryoFusionIconKeywords:Embryo-Fusion> und [Arg1] Punkte <PowerIconKeywords:Kraft>. Wenn es die 2. Auslösung in einer Runde ist, erhältst du 1 Punkt Arithmetica und ziehst 1 Karte; wenn es die 3. Auslösung in einer Runde ist, erhältst du 2 Punkte Arithmetica und ziehst 2 Karten."
  },
  RelicConfig_23688_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Rückschlag“>"
  },
  RelicConfig_23689_BattleDesc = {
    Text = "Nach dem Aufnehmen erhalten alle Erwecker 30 Punkte Wahnsinn. Bei jeder Auslösung der Verherrlichung erhöht sich die Zählung um 1 Punkt. Nach dem Freisetzen des Schlüsselbefehls erhältst du [Arg1] Punkte temporäre Vorsicht, [Arg2] Punkte temporäre <PowerIconKeywords:Stärke> und alle Erwecker erhalten 6 Punkte Wahnsinn. Alle Zählungen werden verbraucht, und jeder Punkt Zählung hat 1 zusätzliche Wirkung."
  },
  RelicConfig_23689_Desc = {
    Text = "Nach dem Aufnehmen erhalten alle Erwecker 30 Punkte Wahnsinn. Bei jeder Freisetzung der Verherrlichung erhöht sich die Zählung um 1 Punkt. Nach dem Freigeben des Schlüsselbefehls erhältst du [Arg1] Punkte temporäre Wachsamkeit, [Arg2] Punkte temporäre <PowerIconKeywords:Stärke> und alle Erwecker erhalten 6 Punkte Wahnsinn. Alle Zählungen werden verbraucht, wobei jede Zählung 1 zusätzliche Wirkung hat."
  },
  RelicConfig_23689_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Aufladung“>"
  },
  RelicConfig_23690_BattleDesc = {
    Text = "Für jeden zusätzlichen Punkt Arithmetica oder jede zusätzlich gezogene Karte stehle allen Gegnern [Arg1] Punkte <PowerIconKeywords:Macht>, erhalte 4% temporäre kritische Trefferquote, Elite- oder Anführer-Kampfeffekt wird verdoppelt. Nach Beginn der Ultra-Runde erhalte [Arg2] Punkte <PowerIconKeywords:Macht>, kritischer Schaden +15%."
  },
  RelicConfig_23690_Desc = {
    Text = "Für jede zusätzlich erhaltene 1 Punkt Arithmetica oder jede zusätzlich gezogene 1 Karte stehle allen Gegnern [Arg1] Punkte <PowerIconKeywords:Macht>, erhalte 4% temporäre kritische Trefferquote, Elite- oder Anführer-Kampfeffekt verdoppeln. Nach Beginn der Ultra-Runde erhalte [Arg2] Punkte <PowerIconKeywords:Macht>, kritischer Schaden +15%."
  },
  RelicConfig_23690_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Riss“>"
  },
  RelicConfig_23691_BattleDesc = {
    Text = "Für je 5 verursachte Schäden erhältst du [Arg1] Leben. Für jeden verlorenen Lebenspunkt +[Arg2] Tentakelschaden, bei Verlust von mehr als [Arg3] Punkten, aktiviere alle Tentakel 1 Mal"
  },
  RelicConfig_23691_Desc = {
    Text = "Für jeden 5. verursachten Schaden regenerierst du [Arg1] Lebenspunkte. Für jeden Verlust von Lebenspunkten erhöht sich der Tentakelschaden um +[Arg2], und wenn du mehr als 10% deiner maximalen Gesundheit verlierst, aktivierst du alle Tentakel einmal"
  },
  RelicConfig_23691_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Flut“>"
  },
  RelicConfig_35135_BattleDesc = {
    Text = "Für jeden verursachten Schaden erhältst du [Arg1] Punkte temporäre <PowerIconKeywords:Stärke> und [Arg2] Punkte temporären Tentakelschaden, maximal 12 Mal pro Runde auslösbar. Wenn in einer Runde 4 Mal Schaden verursacht wurde, füge allen Feinden 1 Schicht Verwundbar hinzu und erhalte [Arg3] Punkte Schild. Wenn 8 Mal Schaden verursacht wurde, füge allen Feinden 1 Schicht Schwäche hinzu und regeneriere [Arg3] Punkte LP."
  },
  RelicConfig_35135_Desc = {
    Text = "Für jeden verursachten Schaden erhältst du [Arg1] Punkte temporäre <PowerIconKeywords:Stärke> und [Arg2] Punkte temporären Tentakelschaden, maximal 12 Mal pro Runde auslösbar. Wenn in einer Runde 4 Mal Schaden verursacht wurde, füge allen Feinden 1 Schicht Verwundbarkeit hinzu und erhalte [Arg3] Punkte Schild. Wenn 8 Mal Schaden verursacht wurde, füge allen Feinden 1 Schicht Schwäche hinzu und regeneriere [Arg3] Punkte LP."
  },
  RelicConfig_35135_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Verliebt“>"
  },
  RelicConfig_35136_BattleDesc = {
    Text = "“Der Schaden von „Schaden“ und der durch „VERT“ erhaltene Schild erhöht sich um 30%. Wenn in einer Runde 4 oder mehr „Schaden“ und „VERT“ ausgespielt wurden, ziehe zu Beginn der nächsten Runde 2 Karten und erhalte 1 Punkt Arithmetica"
  },
  RelicConfig_35136_Desc = {
    Text = "“Der Schaden von „Schaden“ und der durch „VERT“ erhaltene Schild erhöht sich um 30%. Wenn in einer Runde 4 oder mehr „Schaden“ und „VERT“ ausgespielt wurden, ziehe zu Beginn der nächsten Runde 2 Karten und erhalte 1 Punkt Arithmetica"
  },
  RelicConfig_35136_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Eigensinn“>"
  },
  RelicConfig_35137_BattleDesc = {
    Text = "Jedes Mal, wenn eine Karte gespielt wird, erhalte [Arg1] temporäre <PowerIconKeywords:Stärke> und heile [Arg2] Leben. Nach aktivem Schaden entferne [Arg2] temporäre <PowerIconKeywords:Stärke>. Erwachen erhält 30 Wahnsinn für jeden getöteten Feind"
  },
  RelicConfig_35137_Desc = {
    Text = "Jedes Mal, wenn eine Karte gespielt wird, erhalte [Arg1] temporäre <PowerIconKeywords:Stärke> und heile [Arg2] Leben. Nach aktivem Schaden entferne [Arg2] temporäre <PowerIconKeywords:Stärke>. Erwachen erhält 30 Wahnsinn für jeden getöteten Feind"
  },
  RelicConfig_35137_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Akkumulation“>"
  },
  RelicConfig_35138_BattleDesc = {
    Text = "Nach dem Freisetzen von Verherrlichung wird einem zufälligen Feind [Arg1] Punkte Gift zugefügt. Für jede gespielte Befehlskarte erhältst du [Arg2] Punkte vorübergehenden Gegenangriff. Am Ende jeder 4 Runden wird allen Feinden Schaden in Höhe der Summe der Giftstapelungen bei den Feinden und der Gegenangriffstapelungen bei dir zugefügt."
  },
  RelicConfig_35138_Desc = {
    Text = "Nach dem Freisetzen von Verherrlichung wird einem zufälligen Feind [Arg1] Punkte Gift zugefügt. Jedes Mal, wenn du eine Befehlskarte spielst, erhältst du [Arg2] Punkte vorübergehenden Gegenangriff. Am Ende jeder 4 Runden wird allen Feinden Schaden zugefügt, der der Summe der Vergiftungsschichten der Feinde und der eigenen Gegenangriffsschichten entspricht."
  },
  RelicConfig_35138_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Ausbreitung“>"
  },
  RelicConfig_35139_BattleDesc = {
    Text = "Beim Aufnehmen erhöht sich der Schadensbonus der Gruppe um 30 %. Jeder vierte verursachte Schaden ist garantiert ein kritischer Treffer, und der kritische Schaden erhöht sich um 50 %, falls dieser Schaden einen Kill verursacht hat, erhalte 5 Punkte schwarze Siegel"
  },
  RelicConfig_35139_Desc = {
    Text = "Beim Aufnehmen erhöht sich der Schadensbonus der Gruppe um 30 %. Jeder vierte verursachte Schaden ist garantiert ein kritischer Treffer, und der kritische Schaden erhöht sich um 50 %, falls dieser Schaden einen Kill verursacht hat, erhalte 5 Punkte schwarze Siegel"
  },
  RelicConfig_35139_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Ende“>"
  },
  RelicConfig_36823_BattleDesc = {
    Text = "Nach dem Auslösen von „Wahnsinnsexplosion“ ziehe 1 Karte. Für jede abgelegte Karte erhalten alle Erwachenden 3 Punkte Wahnsinn, maximal 15 Punkte pro Runde"
  },
  RelicConfig_36823_Desc = {
    Text = "Nach dem Auslösen von „Wahnsinnsexplosion“ ziehe 1 Karte. Für jede abgelegte Karte erhalten alle Erwachenden 3 Punkte Wahnsinn, maximal 15 Punkte pro Runde"
  },
  RelicConfig_36823_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Hin und Her“>"
  },
  RelicConfig_36824_BattleDesc = {
    Text = "Jedes Mal, wenn Arithmetica erschöpft wird, ziehe 1 Karte, maximal 5 Mal pro Runde. Jedes Mal, wenn das Deck zurückgesetzt wird, erhalte 2 Punkte Arithmetica"
  },
  RelicConfig_36824_Desc = {
    Text = "Jedes Mal, wenn Arithmetica erschöpft wird, ziehe 1 Karte, maximal 5 Mal pro Runde. Jedes Mal, wenn das Deck zurückgesetzt wird, erhalte 2 Punkte Arithmetica"
  },
  RelicConfig_36824_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Schlaflos“>"
  },
  RelicConfig_39302_BattleDesc = {
    Text = "Für jeden 4. verursachten Schaden wird 1 Karte <DerivativeCardKeywords_4:„Inspiration“> in den Ziehstapel gemischt, maximal 3 Mal pro Runde. Nach Auslösung von Exaltieren spielst du alle Karten <DerivativeCardKeywords_4:„Inspiration“> aus deinem Deck aus und verbrauchst sie"
  },
  RelicConfig_39302_Desc = {
    Text = "Für jeden 4. verursachten Schaden wird 1 Karte <DerivativeCardKeywords_4:„Inspiration“> in den Ziehstapel gemischt, maximal 3 Mal pro Runde. Nach Auslösung von Exaltieren spielst du alle Karten <DerivativeCardKeywords_4:„Inspiration“> aus deinem Deck aus und verbrauchst sie"
  },
  RelicConfig_39302_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Traumverlust“>"
  },
  RelicConfig_39303_BattleDesc = {
    Text = "Wenn die aktuelle Arithmetica ungerade ist, gilt dies als zusätzlich [Arg2] Punkte temporäre Wachsamkeit. Wenn die aktuelle Arithmetica gerade ist, gilt dies als zusätzlich [Arg1] Punkte temporäre <PowerIconKeywords:Stärke> und [Arg3] Punkte temporärer Tentakelschaden. Für jede goldene Kreation erhöht sich der Effekt dieses Relikts um 50%, für jede verfluchte Kreatur um 80%."
  },
  RelicConfig_39303_Desc = {
    Text = "Wenn die aktuelle Arithmetica ungerade ist, gilt dies als zusätzlich [Arg2] Punkte temporäre Wachsamkeit. Wenn die aktuelle Arithmetica gerade ist, gilt dies als zusätzlich [Arg1] Punkte temporäre <PowerIconKeywords:Stärke> und [Arg3] Punkte temporärer Tentakelschaden. Für jedes goldene Relikt erhöht sich der Effekt dieses Relikts um 50%, für jedes verfluchte Relikt um 80%."
  },
  RelicConfig_39303_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Schrecktraum“>"
  },
  RelicConfig_44192_BattleDesc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwecker 20 Aelius. Beim Aufsammeln reduziert sich die maximale Gesundheit um 50%"
  },
  RelicConfig_44192_Desc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwecker 20 Aelius. Beim Aufsammeln reduziert sich die maximale Gesundheit um 50%"
  },
  RelicConfig_44192_Name = {
    Text = "<RedQuality:Sünde·Albtraumerscheinung>"
  },
  RelicConfig_44192_StoryDesc = {
    Text = "Tiefer Schlaf ist Verlangen, das dich unbemerkt verschlingt"
  },
  RelicConfig_44300_BattleDesc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwecker 25 Aelius. Beim Aufsammeln wird die maximale Gesundheit auf das 3-fache erhöht"
  },
  RelicConfig_44300_Desc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwecker 25 Aelius. Beim Aufsammeln wird die maximale Gesundheit auf das 3-fache erhöht"
  },
  RelicConfig_44300_Name = {
    Text = "<OrangeQuality:Gesegnet: Albtraum-Illusion>"
  },
  RelicConfig_44300_StoryDesc = {
    Text = "Keine Angst, keine Zweifel. Dies ist nur ein flüchtiger Traum, das Licht des Vaters scheint immer noch auf dich"
  },
  RelicConfig_44592_BattleDesc = {
    Text = "Nach Kampfende 100 schwarze Siegel und 2 Symptomkarten erhalten"
  },
  RelicConfig_44592_Desc = {
    Text = "Nach Kampfende 100 schwarze Siegel und 2 Symptomkarten erhalten"
  },
  RelicConfig_44592_Name = {
    Text = "<RedQuality:Sünde·Jadeabdruck>"
  },
  RelicConfig_44592_StoryDesc = {
    Text = "Die alten Sünden sind hier eingraviert"
  },
  RelicConfig_44593_BattleDesc = {
    Text = "Beim Aufnehmen verwandle dich in 1 zufälliges verfluchtes Relikt, ausgenommen von dir selbst, erhalte 75 schwarze Siegel"
  },
  RelicConfig_44593_Desc = {
    Text = "Beim Aufnehmen verwandle dich in 1 zufälliges verfluchtes Relikt, ausgenommen von dir selbst, erhalte 75 schwarze Siegel"
  },
  RelicConfig_44593_Name = {
    Text = "<RedQuality:Sünde·Verfluchter Stein>"
  },
  RelicConfig_44593_StoryDesc = {
    Text = "Hör mal, da ruft jemand drinnen"
  },
  RelicConfig_44594_BattleDesc = {
    Text = "Alle 2 Züge wird der erlittene Aktiv- und Tentakelschaden aller Gegner in dieser Runde verdoppelt. Aber nach der Freisetzung von Verherrlichung in dieser Runde werden alle Erwecker 1 Runde versiegelt, und man selbst wird Verwundbar"
  },
  RelicConfig_44594_Desc = {
    Text = "Alle 2 Züge wird der erlittene Aktiv- und Tentakelschaden aller Gegner in dieser Runde verdoppelt. Aber nach der Freisetzung von Verherrlichung in dieser Runde werden alle Erwecker 1 Runde versiegelt, und man selbst wird Verwundbar"
  },
  RelicConfig_44594_Name = {
    Text = "<RedQuality:Sünde·Knochen des Pfades>"
  },
  RelicConfig_44594_StoryDesc = {
    Text = "Ein heiliger Teil.\nNach der Trennung vom Körper wurde er von Sünde durchdrungen"
  },
  RelicConfig_44597_BattleDesc = {
    Text = "Für jeden verursachten aktiven Schaden fügst du dir selbst [Arg1] Schichten <BleedingIconKeywords:Bluten> hinzu und fügst dem beschädigten Ziel [Arg2] Schichten <BleedingIconKeywords:Bluten> hinzu"
  },
  RelicConfig_44597_Desc = {
    Text = "Für jeden verursachten aktiven Schaden fügst du dir selbst [Arg1] Schichten <BleedingIconKeywords:Bluten> hinzu und fügst dem beschädigten Ziel [Arg2] Schichten <BleedingIconKeywords:Bluten> hinzu"
  },
  RelicConfig_44597_Name = {
    Text = "<RedQuality:Sünde·Schwarmbewusstsein>"
  },
  RelicConfig_44597_StoryDesc = {
    Text = "Verflechten, symbiotisch, gruppieren; Angst, Unbekanntes, Kontrolle"
  },
  RelicConfig_44598_BattleDesc = {
    Text = "Nach dem Auslösen von „Wahnsinnsexplosion“ verliere 12% deines aktuellen Lebens und stehle [Arg1] Punkte temporäre<PowerIconKeywords:Stärke> von allen Feinden. Wenn nur 1 Feind vorhanden ist, zusätzlich [Arg2] Punkte temporäre<PowerIconKeywords:Stärke>"
  },
  RelicConfig_44598_Desc = {
    Text = "Nach dem Auslösen von „Wahnsinnsexplosion“ verliere 12% deines aktuellen Lebens und stehle [Arg1] Punkte temporäre<PowerIconKeywords:Stärke> von allen Feinden. Wenn nur 1 Feind vorhanden ist, zusätzlich [Arg2] Punkte temporäre<PowerIconKeywords:Stärke>"
  },
  RelicConfig_44598_Name = {
    Text = "<RedQuality:Sünde·Unglücksvogel>"
  },
  RelicConfig_44598_StoryDesc = {
    Text = "Arme Kreaturen, die durch Gier starben, klagen mit ihren ausgetrockneten Brusthöhlen schrill"
  },
  RelicConfig_44603_BattleDesc = {
    Text = "Handkartenlimit erhöht um 5, zu Beginn des Kampfes 6 Karten ziehen. Am Ende des Zuges alle Symptomkarten und Zustandskarten ablegen, andere Karten behalten, aber die Anzahl der gezogenen Karten pro Zug wird um 2 verringert"
  },
  RelicConfig_44603_Desc = {
    Text = "Handkartenlimit erhöht um 5, zu Beginn des Kampfes 6 Karten ziehen. Am Ende des Zuges alle Symptomkarten und Zustandskarten ablegen, andere Karten behalten, aber die Anzahl der gezogenen Karten pro Zug wird um 2 verringert"
  },
  RelicConfig_44603_Name = {
    Text = "<RedQuality:Sünde·Bewusstseinsgravur>"
  },
  RelicConfig_44603_StoryDesc = {
    Text = "Der Gierige sieht andere als Objekte und genießt ihr Leid"
  },
  RelicConfig_44608_BattleDesc = {
    Text = "Nach dem Aufheben verliert man dauerhaft [Arg1] <PowerIconKeywords:Kraft>. Bei jedem verursachten Schaden werden [Arg2] Lebenspunkte wiederhergestellt, maximal 6 Mal pro Runde"
  },
  RelicConfig_44608_Desc = {
    Text = "Nach dem Aufheben verliert man dauerhaft [Arg1] <PowerIconKeywords:Kraft>. Bei jedem verursachten Schaden werden [Arg2] Lebenspunkte wiederhergestellt, maximal 6 Mal pro Runde"
  },
  RelicConfig_44608_Name = {
    Text = "<RedQuality:Sünde·Kuss der Neunaugen>"
  },
  RelicConfig_44608_StoryDesc = {
    Text = "Sein Kuss wird dich verzaubern – natürlich könnte es auch dich selbst verzaubern"
  },
  RelicConfig_44609_BattleDesc = {
    Text = "Maximale Arithmetica erhöht sich um 3. Jedes Mal, wenn das Kartenstapel zurückgesetzt wird, füge 2 Karten <DerivativeCardKeywords_9:„Stolpern“> dem Ziehstapel hinzu"
  },
  RelicConfig_44609_Desc = {
    Text = "Maximale Arithmetica erhöht sich um 3. Jedes Mal, wenn das Kartenstapel zurückgesetzt wird, füge 2 Karten <DerivativeCardKeywords_9:„Stolpern“> dem Ziehstapel hinzu"
  },
  RelicConfig_44609_Name = {
    Text = "<RedQuality:Sünde·Schwarze Kerze>"
  },
  RelicConfig_44609_StoryDesc = {
    Text = "Brennende Vernunft, in Wahnsinn stürzen"
  },
  RelicConfig_44610_BattleDesc = {
    Text = "Kritische Rate und kritischer Schaden erhöhen sich um 50%. Zu Beginn jeder Runde, <FragileIconKeywords:zerbrechlich> für 1 Runde"
  },
  RelicConfig_44610_Desc = {
    Text = "Kritische Rate und kritischer Schaden erhöhen sich um 50%. Zu Beginn jeder Runde, <FragileIconKeywords:zerbrechlich> für 1 Runde"
  },
  RelicConfig_44610_Name = {
    Text = "<RedQuality:Sünde·Seltsame Klaue>"
  },
  RelicConfig_44610_StoryDesc = {
    Text = "Von Verlangen verzerrte Klaue."
  },
  RelicConfig_44654_BattleDesc = {
    Text = "Maximale Arithmetica erhöht sich um 4. Jedes Mal, wenn das Kartenstapel zurückgesetzt wird, füge 4 Karten <DerivativeCardKeywords_4:„Inspiration“> dem Ziehstapel hinzu"
  },
  RelicConfig_44654_Desc = {
    Text = "Maximale Arithmetica erhöht sich um 4. Jedes Mal, wenn das Kartenstapel zurückgesetzt wird, füge 4 Karten <DerivativeCardKeywords_4:„Inspiration“> dem Ziehstapel hinzu"
  },
  RelicConfig_44654_Name = {
    Text = "<OrangeQuality:Gesegnet: Schwarze Kerze>"
  },
  RelicConfig_44654_StoryDesc = {
    Text = "Brenne Verlangen, erlange Erlösung"
  },
  RelicConfig_44656_BattleDesc = {
    Text = "Relikt-Obergrenze +[Arg1], Erneuerung im „D-Marke“ +1. Nach dem Kampf erhält man 125 das schwarze Siegel, beim Aufnehmen können bis zu 6 Symptom-Karten zum Löschen ausgewählt werden"
  },
  RelicConfig_44656_Desc = {
    Text = "Relikt-Obergrenze +[Arg1], Erneuerung im „D-Marke“ +1. Nach dem Kampf erhält man 125 das schwarze Siegel, beim Aufnehmen können bis zu 6 Symptom-Karten zum Löschen ausgewählt werden"
  },
  RelicConfig_44656_Name = {
    Text = "<OrangeQuality:Gesegnet: Jadeabdruck>"
  },
  RelicConfig_44656_StoryDesc = {
    Text = "Die Erlösung des Vaters hat den Schmerz genommen"
  },
  RelicConfig_44658_BattleDesc = {
    Text = "Nach dem Freisetzen von Aelius erhältst du [Arg1] Punkte temporäre Macht und stiehlst [Arg1] Punkte temporäre<PowerIconKeywords:Macht> von allen feindlichen Zielen. Wenn nur ein Feind vorhanden ist, stiehl zusätzlich [Arg2] Punkte temporäre<PowerIconKeywords:Macht>"
  },
  RelicConfig_44658_Desc = {
    Text = "Nach dem Freisetzen von Aelius erhältst du [Arg1] Punkte temporäre Macht und stiehlst [Arg1] Punkte temporäre<PowerIconKeywords:Macht> von allen feindlichen Zielen. Wenn nur ein Feind vorhanden ist, stiehl zusätzlich [Arg2] Punkte temporäre<PowerIconKeywords:Macht>"
  },
  RelicConfig_44658_Name = {
    Text = "<OrangeQuality:Gesegnet: Ritualvogel des Unheils>"
  },
  RelicConfig_44658_StoryDesc = {
    Text = "Das Licht der Vergebung umhüllt die Überreste der Gier, und die verstorbenen Vögel dürfen ihr letztes Lied singen."
  },
  RelicConfig_44659_BattleDesc = {
    Text = "Für jeden verursachten aktiven Schaden regenerierst du [Arg1] Leben und fügst dem beschädigten Ziel [Arg2] Schichten <BleedingIconKeywords:Bluten> hinzu"
  },
  RelicConfig_44659_Desc = {
    Text = "Für jeden verursachten aktiven Schaden regenerierst du [Arg1] Leben und fügst dem beschädigten Ziel [Arg2] Schichten <BleedingIconKeywords:Bluten> hinzu"
  },
  RelicConfig_44659_Name = {
    Text = "<OrangeQuality:Gesegnet: Schwarmbewusstsein>"
  },
  RelicConfig_44659_StoryDesc = {
    Text = "Verflechten, symbiotisch, gruppieren; Einheit, Koexistenz, Schutz"
  },
  RelicConfig_44660_BattleDesc = {
    Text = "Handkartenlimit erhöht um 5, zu Beginn des Kampfes Handkarten auf das Limit auffüllen. Am Zuganfang zusätzlich 1 Karte ziehen, am Ende des Zuges alle Symptomkarten und Zustandskarten ablegen, andere Karten behalten"
  },
  RelicConfig_44660_Desc = {
    Text = "Handkartenlimit erhöht um 5, zu Beginn des Kampfes Handkarten auf das Limit auffüllen. Am Zuganfang zusätzlich 1 Karte ziehen, am Ende des Zuges alle Symptomkarten und Zustandskarten ablegen, andere Karten behalten"
  },
  RelicConfig_44660_Name = {
    Text = "<OrangeQuality:Gesegnet: Bewusstseinsgravur>"
  },
  RelicConfig_44660_StoryDesc = {
    Text = "Der Gierige trägt seine Fehler im Herzen und sucht Buße für seine Vergangenheit"
  },
  RelicConfig_44662_BattleDesc = {
    Text = "Alle 2 Züge wird der erlittene Aktiv- und Tentakelschaden aller Gegner in dieser Runde verdoppelt, und für jede einmalige Freisetzung von Verherrlichung in dieser Runde wird 1 negativer Zustand zufällig aufgelöst."
  },
  RelicConfig_44662_Desc = {
    Text = "Alle 2 Züge wird der erlittene Aktiv- und Tentakelschaden aller Gegner in dieser Runde verdoppelt, und für jede einmalige Freisetzung von Verherrlichung in dieser Runde wird 1 negativer Zustand zufällig aufgelöst."
  },
  RelicConfig_44662_Name = {
    Text = "<OrangeQuality:Gesegnet·Überreste des Pfadläufers>"
  },
  RelicConfig_44662_StoryDesc = {
    Text = "Ein heiliger Teil.\nTrotz der Trennung vom Körper sind seine Spuren überall"
  },
  RelicConfig_44663_BattleDesc = {
    Text = "Kritische Rate erhöht um 50%, kritischer Schaden erhöht um 100%"
  },
  RelicConfig_44663_Desc = {
    Text = "Kritische Rate erhöht um 50%, kritischer Schaden erhöht um 100%"
  },
  RelicConfig_44663_Name = {
    Text = "<OrangeQuality:Gesegnet: Seltsame Klaue>"
  },
  RelicConfig_44663_StoryDesc = {
    Text = "Alle Wünsche wurden aufgegeben"
  },
  RelicConfig_44664_BattleDesc = {
    Text = "Nach dem Aufheben erhält man dauerhaft [Arg1] <PowerIconKeywords:Kraft>. Bei jedem verursachten Schaden werden [Arg2] Lebenspunkte wiederhergestellt, maximal 6 Mal pro Runde"
  },
  RelicConfig_44664_Desc = {
    Text = "Nach dem Aufheben erhält man dauerhaft [Arg1] <PowerIconKeywords:Kraft>. Bei jedem verursachten Schaden werden [Arg2] Lebenspunkte wiederhergestellt, maximal 6 Mal pro Runde"
  },
  RelicConfig_44664_Name = {
    Text = "<OrangeQuality:Gesegnet: Kuss der Neunaugen>"
  },
  RelicConfig_44664_StoryDesc = {
    Text = "Lehne diesen verführerischen Kuss ab, die Umarmung des Vaters ist wärmer als jede Dunkelheit"
  },
  RelicConfig_47444_BattleDesc = {
    Text = "“Schaden“ und „VERT“ erhalten zusätzlich 50 Silberschlüssel-Energie. Jedes Mal, wenn du eine Karte mit 2 oder mehr Arithmetica verbrauchst, ziehe eine Karte mit 1 Arithmetica-Kosten und mache diese zu 0. Maximal 3 mal pro Runde"
  },
  RelicConfig_47444_Desc = {
    Text = "“Schaden“ und „VERT“ erhalten zusätzlich 50 Silberschlüssel-Energie. Jedes Mal, wenn du eine Karte mit 2 oder mehr Arithmetica verbrauchst, ziehe eine Karte mit 1 Arithmetica-Kosten und mache diese zu 0. Maximal 3 mal pro Runde"
  },
  RelicConfig_47444_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Zwillinge“>"
  },
  RelicConfig_50338_BattleDesc = {
    Text = "Zu Beginn des Kampfes werden alle <ExaltIconKeywords: Gnosis> der Erwecker in den Stapel gemischt. Nach der 6. Runde wird Thais jede Runde Kampfhilfe leisten"
  },
  RelicConfig_50338_Desc = {
    Text = "Zu Beginn des Kampfes werden alle <ExaltIconKeywords: Gnosis> der Erwecker in den Stapel gemischt. Nach der 6. Runde wird Thais jede Runde Kampfhilfe leisten"
  },
  RelicConfig_50338_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Verliebt“>"
  },
  RelicConfig_50338_StoryDesc = {
    Text = "Er sagte, fürchte dich nicht"
  },
  RelicConfig_50385_BattleDesc = {
    Text = "Beim Aufnehmen wähle 1 Karte, deren Rechenleistung dauerhaft auf 1 gesetzt wird"
  },
  RelicConfig_50385_Desc = {
    Text = "Beim Aufnehmen wähle 1 Karte, deren Rechenleistung dauerhaft auf 1 gesetzt wird"
  },
  RelicConfig_50385_Name = {
    Text = "<WhiteQuality:☆Erschöpfter Schüler☆>"
  },
  RelicConfig_50385_StoryDesc = {
    Text = "Ohne das kostbare Wasser der Wüste sind ihre Augen ausgetrocknet"
  },
  RelicConfig_50487_BattleDesc = {
    Text = "Zu Kampfbeginn der ersten Runde <DerivativeCardKeywords_46:“Prion Virus“> auf die Hand nehmen; in der 3. Runde <DerivativeCardKeywords_49:“Gefräßiger ANG“> auf die Hand nehmen; nach dem Auslösen von Widerstand <DerivativeCardKeywords_52:“Wiederbelebungskokon“> auf die Hand nehmen"
  },
  RelicConfig_50487_Desc = {
    Text = "Zu Kampfbeginn der ersten Runde <DerivativeCardKeywords_46:“Prion Virus“> auf die Hand nehmen; in der 3. Runde <DerivativeCardKeywords_49:“Gefräßiger ANG“> auf die Hand nehmen; nach dem Auslösen von Widerstand <DerivativeCardKeywords_52:“Wiederbelebungskokon“> auf die Hand nehmen"
  },
  RelicConfig_50487_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“der Segen“>"
  },
  RelicConfig_50488_BattleDesc = {
    Text = "Am Ende der Runde: Der Erwachte mit dem niedrigsten Wahnsinn erhält 35 Wahnsinn. Wenn das verbleibende Leben ≥50% ist, erhalte [Arg1] <PowerIconKeywords:Kraft>. Wenn das verbleibende Leben <50% ist, stelle [Arg2] Leben wieder her"
  },
  RelicConfig_50488_Desc = {
    Text = "Am Ende der Runde: Der Erwachte mit dem niedrigsten Wahnsinn erhält 35 Wahnsinn. Wenn das aktuelle Leben ≥50% ist, erhalte [Arg1] <PowerIconKeywords:Kraft>. Wenn das aktuelle Leben <50% ist, stelle [Arg2] Leben wieder her"
  },
  RelicConfig_50488_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Gleichgewicht“>"
  },
  RelicConfig_50489_BattleDesc = {
    Text = "Kritische Rate und kritischer Schaden erhöhen sich um 100%. Für jeden verursachten Schaden sinken die kritischen Treffer und der kritische Schaden aller Erwecker um 10%, maximal 50%. Für jeden verursachten Schaden wird das verursachte Gift und der Gegenangriff in dieser Runde um 10% erhöht, maximal 50%."
  },
  RelicConfig_50489_Desc = {
    Text = "Kritische Rate und kritischer Schaden erhöhen sich um 100%. Für jede verursachte Schaden/ Tentakelschaden in dieser Runde: Alle Erwecker haben einen kritischen Treffs- und kritischen Schaden von 10% weniger, maximal 50%. Verursachtes Gift und Gegenangriff werden um 10% erhöht, maximal 50%"
  },
  RelicConfig_50489_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Verschiebung“>"
  },
  RelicConfig_51686_BattleDesc = {
    Text = "Für jede gespielte Befehlskarte, die einem anderen Erwecker als der vorherigen gehört, erhält der entsprechende Erwecker 3 Punkte Aliemus und sammelt 1 Schicht “Vitalität“. Wenn 10 Schichten gesammelt werden, werden alle “Vitalität“-Schichten geleert und jeder Erwecker erhält eine zufällige Befehlskarte mit Arithmetica-Kosten -1 und “Verbrauch“. Maximal 1-mal pro Runde wirksam."
  },
  RelicConfig_51686_Desc = {
    Text = "Jede ausgespielte Befehlskarte, die einem anderen Erwecker gehört als die vorherige, gewährt dem entsprechenden Erwecker 3 Punkte Aliemus und sammelt 1 Schicht “Vitalität“. Wenn 10 Schichten erreicht sind, werden alle “Vitalität“-Schichten zurückgesetzt, und es wird für jeden Erwecker eine zufällige Befehlskarte mit Arithmetica-Kosten -1 und “Verbrauch“ in die Hand gelegt, maximal 1-mal pro Runde wirksam."
  },
  RelicConfig_51686_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Ableitung“>"
  },
  RelicConfig_51687_BattleDesc = {
    Text = "Nicht “Schlag“ oder “VERT“, wenn die Befehlskarte gespielt wird und diese Karte keine abgeleitete Karte ist, erhält der entsprechende Erwecker 15 Punkte Aliemus, maximal 5 Mal pro Runde. Beim ersten Auslösen in jeder Runde wird die gespielte Karte auch zurück zur Hand genommen."
  },
  RelicConfig_51687_Desc = {
    Text = "Wenn eine Befehlskarte gespielt wird, die nicht „Schlag\" oder „VERT\" ist, und diese Karte keine abgeleitete Karte ist, erhält der entsprechende Erwecker 15 Punkte Aliemus, maximal 5 Mal pro Runde. Beim ersten Auslösen in jeder Runde wird die gespielte Karte auch zurück zur Hand genommen."
  },
  RelicConfig_51687_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Projektion“>"
  },
  RelicConfig_51688_BattleDesc = {
    Text = "Beim Aufheben wird zu allen Befehlskarten „Behalten“ hinzugefügt. Am Ende der Runde, wenn die Handkartenzahl 5 oder mehr beträgt, werden zufällig 3 Handkarten zugkosten um 1 gesenkt, andernfalls zieht man 3 Karten"
  },
  RelicConfig_51688_Desc = {
    Text = "Beim Aufheben wird zu allen Befehlskarten „Behalten“ hinzugefügt. Am Ende der Runde, wenn die Handkartenzahl 5 oder mehr beträgt, werden zufällig 3 Handkarten zugkosten um 1 gesenkt, andernfalls zieht man 3 Karten"
  },
  RelicConfig_51688_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Wachstube“>"
  },
  RelicConfig_51689_BattleDesc = {
    Text = "Zu Beginn des Kampfes werden 3 zufällige Symptom-Karten in das Deck gelegt. Zu Beginn der Runde wird 1 Karte gezogen. Für jede ausgelegte Symptom-Karte erhält man 2 Punkte Arithmetica. Für jede abgeworfene Symptom-Karte erhalten alle Erwecker 5 Punkte Aelius, maximal 5 Auslösungen pro Runde"
  },
  RelicConfig_51689_Desc = {
    Text = "Zu Beginn des Kampfes werden 3 zufällige Symptom-Karten in das Deck gelegt. Zu Beginn der Runde wird 1 Karte gezogen. Für jede ausgelegte Symptom-Karte erhält man 2 Punkte Arithmetica. Für jede abgeworfene Symptom-Karte erhalten alle Erwecker 5 Punkte Aelius, maximal 5 Auslösungen pro Runde"
  },
  RelicConfig_51689_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Epidemie“>"
  },
  RelicConfig_55847_BattleDesc = {
    Text = "Simulationskampf Standard-Set 7"
  },
  RelicConfig_55847_Desc = {
    Text = "Simulationskampf Standard-Set 7"
  },
  RelicConfig_55847_Name = {
    Text = "<RedQuality:☆Simulationsartefakt☆>"
  },
  RelicConfig_55847_StoryDesc = {
    Text = "In seltsamen Epochen sind Blumen die ersten Beobachter der Menschheit.\nBeweg dich nicht, sie bevorzugen ruhige Ausstellungsstücke"
  },
  RelicConfig_55874_BattleDesc = {
    Text = "Nach dem Kampf erhält man [Arg1] Schichten „Tinte“, bei 2 Schichten wird „Tinte“ verbraucht und 1 „Bild“ zufällig ins Deck gelegt"
  },
  RelicConfig_55874_Desc = {
    Text = "Nach dem Kampf erhält man [Arg1] Schichten „Tinte“, bei 2 Schichten wird „Tinte“ verbraucht und 1 „Bild“ zufällig ins Deck gelegt"
  },
  RelicConfig_55874_Name = {
    Text = "<OrangeQuality:Horlas Feder und Tinte>"
  },
  RelicConfig_55874_StoryDesc = {
    Text = "Die alten Sünden sind hier eingraviert"
  },
  RelicConfig_56355_BattleDesc = {
    Text = "Handkartenlimit +2, zu Beginn der Runde ziehe 1 Karte. Nach dem Kampf erhalte [Arg1] Schicht „Tinte“, bei 2 Schichten „Tinte“ verbrauche sie und wähle 1 „Bild“ in dein Deck"
  },
  RelicConfig_56355_Desc = {
    Text = "Handkartenlimit +2, zu Beginn der Runde ziehe 1 Karte. Nach dem Kampf erhalte [Arg1] Schicht „Tinte“, bei 2 Schichten „Tinte“ verbrauche sie und wähle 1 „Bild“ in dein Deck"
  },
  RelicConfig_56355_Name = {
    Text = "<OrangeQuality:Horlas Feder und Tinte>"
  },
  RelicConfig_56355_StoryDesc = {
    Text = "Die alten Sünden sind hier eingraviert"
  },
  RelicConfig_56356_BattleDesc = {
    Text = "Nach dem Kampf erhält man [Arg1] Schichten „Tinte“, bei 2 Schichten wird „Tinte“ verbraucht und man wählt 1 „Bild“ ins Deck"
  },
  RelicConfig_56356_Desc = {
    Text = "Nach dem Kampf erhält man [Arg1] Schichten „Tinte“, bei 2 Schichten wird „Tinte“ verbraucht und man wählt 1 „Bild“ ins Deck"
  },
  RelicConfig_56356_Name = {
    Text = "<OrangeQuality:Horlas Feder und Tinte>"
  },
  RelicConfig_56356_StoryDesc = {
    Text = "Die alten Sünden sind hier eingraviert"
  },
  RelicConfig_57667_BattleDesc = {
    Text = "Zu Beginn hat man 2 Schichten Göttliche Macht. Nach der dritten Runde kann man zu Beginn jeder Runde wählen, Göttliche Macht zu verbrauchen, um unterschiedliche Effekte zu erhalten, oder Göttliche Macht wiederherzustellen. Bei erlittenem tödlichem Schaden wird man wiederbelebt und verbraucht alle Göttlichen Mächte, wobei jede Schicht 10 % des Lebens wiederherstellt. Dies kann nur einmal aktiv werden."
  },
  RelicConfig_57667_Desc = {
    Text = "Zu Beginn hast du 2 Schichten Göttlicher Macht. Nach der dritten Runde kannst du zu Beginn jeder Runde wählen, die Göttliche Macht zu verbrauchen, um unterschiedliche Effekte zu erhalten oder Göttliche Macht wiederherzustellen. Wenn du tödlichen Schaden erleidest, wirst du wiederbelebt und verbrauchst alle Schichten Göttlicher Macht, jede Schicht stellt 10% Leben wieder her, kann jedoch nur einmal aktiviert werden."
  },
  RelicConfig_57667_Name = {
    Text = "<OrangeQuality:Schutz der Muttergöttin>"
  },
  RelicConfig_57732_BattleDesc = {
    Text = "Alle Erwecker erhöhen die kritische Rate um 15%. Die zufälligen Effekte der Rykers und Würfel erhöhen das Endergebnis um 1"
  },
  RelicConfig_57732_Desc = {
    Text = "Alle Erwecker erhöhen die kritische Rate um 15%. Die zufälligen Effekte der Rykers und Würfel erhöhen das Endergebnis um 1"
  },
  RelicConfig_57732_Name = {
    Text = "<OrangeQuality:Edler Glücksmantel>"
  },
  RelicConfig_57732_StoryDesc = {
    Text = "Die alten Sünden sind hier eingraviert"
  },
  RelicConfig_57733_BattleDesc = {
    Text = "Zu Beginn der Runde und beim Auslösen von Ryker oder den Würfeln erhältst du 100 Punkte s-Energie und 4% kritischen Schaden, maximal 50% kritischen Schaden, der am Ende des Kampfes entfernt wird"
  },
  RelicConfig_57733_Desc = {
    Text = "Zu Beginn der Runde und beim Auslösen von Ryker oder den Würfeln erhältst du 100 Punkte s-Energie und 4% kritischen Schaden, maximal 50% kritischen Schaden, der am Ende des Kampfes entfernt wird"
  },
  RelicConfig_57733_Name = {
    Text = "<OrangeQuality:Feiner Großmaulknopf>"
  },
  RelicConfig_57733_StoryDesc = {
    Text = "Die alten Sünden sind hier eingraviert"
  },
  RelicConfig_57734_BattleDesc = {
    Text = "Jedes Mal, wenn ein Schlüsselbefehl freigesetzt wird, lege 1 \"Leuchtender Hausmittel-Würfel\" auf die Hand"
  },
  RelicConfig_57734_Desc = {
    Text = "Jedes Mal, wenn ein Schlüsselbefehl freigesetzt wird, lege 1 \"Leuchtender Hausmittel-Würfel\" auf die Hand"
  },
  RelicConfig_57734_Name = {
    Text = "<OrangeQuality:Glänzender Würfel>"
  },
  RelicConfig_57734_StoryDesc = {
    Text = "Die alten Sünden sind hier eingraviert"
  },
  RelicConfig_57735_BattleDesc = {
    Text = "Zu Beginn der Runde und beim Auslösen von Ryker oder den Würfeln erhältst du 50 Punkte s-Energie und 2% kritischen Schaden, maximal 30% kritischen Schaden, der am Ende des Kampfes entfernt wird"
  },
  RelicConfig_57735_Desc = {
    Text = "Zu Beginn der Runde und beim Auslösen von Ryker oder den Würfeln erhältst du 50 Punkte s-Energie und 2% kritischen Schaden, maximal 30% kritischen Schaden, der am Ende des Kampfes entfernt wird"
  },
  RelicConfig_57735_Name = {
    Text = "<OrangeQuality:Großer Knopf>"
  },
  RelicConfig_57735_StoryDesc = {
    Text = "Die alten Sünden sind hier eingraviert"
  },
  RelicConfig_57736_BattleDesc = {
    Text = "Jedes Mal, wenn ein Schlüsselbefehl freigesetzt wird, lege 1 \"Hausmittel-Würfel\" auf die Hand"
  },
  RelicConfig_57736_Desc = {
    Text = "Jedes Mal, wenn ein Schlüsselbefehl freigesetzt wird, lege 1 \"Hausmittel-Würfel\" auf die Hand"
  },
  RelicConfig_57736_Name = {
    Text = "<OrangeQuality:Glückswürfel>"
  },
  RelicConfig_57736_StoryDesc = {
    Text = "Die alten Sünden sind hier eingraviert"
  },
  RelicConfig_57737_BattleDesc = {
    Text = "Alle Erwecker erhöhen die kritische Rate um 10%. Die zufälligen Effekte aller Rykers und Würfel zeigen keinen Minimalwert"
  },
  RelicConfig_57737_Desc = {
    Text = "Alle Erwecker erhöhen die kritische Rate um 10%. Die zufälligen Effekte aller Rykers und Würfel zeigen keinen Minimalwert"
  },
  RelicConfig_57737_Name = {
    Text = "<OrangeQuality:Glücksmantel>"
  },
  RelicConfig_57737_StoryDesc = {
    Text = "Die alten Sünden sind hier eingraviert"
  },
  RelicConfig_57791_BattleDesc = {
    Text = "Relikt-Obergrenze +1. In den ersten fünf Runden nach Kampfbeginn erhält man am Beginn jeder Runde ein Relikt, darunter „Rubinbrosche, gewundenes Achat, Rettungssignal, Unheilritualvogel, Chrono-Pendel·Faszination“"
  },
  RelicConfig_57791_Desc = {
    Text = "Relikt-Obergrenze +1. In den ersten fünf Runden nach Kampfbeginn erhält man am Beginn jeder Runde ein Relikt, darunter „Rubinbrosche, gewundenes Achat, Rettungssignal, Unheilritualvogel, Chrono-Pendel·Faszination“"
  },
  RelicConfig_57791_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Schatz des gesunkenen Schiffs“>"
  },
  RelicConfig_57791_StoryDesc = {
    Text = "Es wird gesagt, dass Lemuria in diesen Gewässern gefallen ist. Wer kann es sich leisten, das Geheimnis des Schiffswrackschatzes nicht zu erkunden?"
  },
  RelicConfig_57792_BattleDesc = {
    Text = "Relikt-Obergrenze +1. In den ersten fünf Runden nach Kampfbeginn erhält man am Beginn jeder Runde ein Relikt, darunter „Dreizack, Auslandsbriefmarkenmappe, Arkana-Aufzeichnung, Bewusstseinsinschrift, Chrono-Pendel·Aufladung“"
  },
  RelicConfig_57792_Desc = {
    Text = "Relikt-Obergrenze +1. In den ersten fünf Runden nach Kampfbeginn erhält man am Beginn jeder Runde ein Relikt, darunter „Dreizack, Auslandsbriefmarkenmappe, Arkana-Aufzeichnung, Bewusstseinsinschrift, Chrono-Pendel·Aufladung“"
  },
  RelicConfig_57792_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Schatz des gesunkenen Schiffs“>"
  },
  RelicConfig_57792_StoryDesc = {
    Text = "Die Legende besagt, dass Lemuria in diesen Gewässern gefallen ist. Wer kann sich zurückhalten, das Geheimnis des Schiffswrackschatzes zu erforschen?"
  },
  RelicConfig_57793_BattleDesc = {
    Text = "Relikt-Obergrenze +1. In den ersten fünf Runden nach Kampfbeginn erhält man am Beginn jeder Runde ein Relikt, darunter „Laserkinn, verdächtige Salbe, staubige Nähmaschine, fremdartige Zunge, Chrono-Pendel·Gezeiten“"
  },
  RelicConfig_57793_Desc = {
    Text = "Relikt-Obergrenze +1. In den ersten fünf Runden nach Kampfbeginn erhält man am Beginn jeder Runde ein Relikt, darunter „Laserkinn, verdächtige Salbe, staubige Nähmaschine, fremdartige Zunge, Chrono-Pendel·Gezeiten“"
  },
  RelicConfig_57793_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Schatz des gesunkenen Schiffs“>"
  },
  RelicConfig_57793_StoryDesc = {
    Text = "Es wird gesagt, dass Lemuria in diesen Gewässern gefallen ist. Wer kann sich zurückhalten, das Geheimnis des versunkenen Schatzes zu erkunden?"
  },
  RelicConfig_57794_BattleDesc = {
    Text = "Relikt-Maximalwert +1. In den ersten fünf Runden nach Kampfbeginn erhältst du am Beginn jeder Runde ein Relikt, darunter „Brennessel-Rücken, Uhr des Verstorbenen, Zitate der Weisen, Arm der Rettung, Chrono-Pendel·Ausbreitung“"
  },
  RelicConfig_57794_Desc = {
    Text = "Relikt-Maximalwert +1. In den ersten fünf Runden nach Kampfbeginn erhältst du am Beginn jeder Runde ein Relikt, darunter „Brennessel-Rücken, Uhr des Verstorbenen, Zitate der Weisen, Arm der Rettung, Chrono-Pendel·Ausbreitung“"
  },
  RelicConfig_57794_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Schatz des gesunkenen Schiffs“>"
  },
  RelicConfig_57794_StoryDesc = {
    Text = "Es wird gesagt, dass Lemuria in diesen Gewässern gefallen ist. Wer kann widerstehen, das Geheimnis des Schiffswrackschatzes zu erforschen?"
  },
  RelicConfig_57795_BattleDesc = {
    Text = "Relikt-Obergrenze +1. In den ersten fünf Runden nach Kampfbeginn erhält man am Beginn jeder Runde ein Relikt, darunter „Rostige Weideklinge, Blutstillzange, alte Puzzles, Schwarmbewusstsein, Chrono-Pendel·Zwillingsgeburt“"
  },
  RelicConfig_57795_Desc = {
    Text = "Relikt-Obergrenze +1. In den ersten fünf Runden nach Kampfbeginn erhält man am Beginn jeder Runde ein Relikt, darunter „Rostige Weideklinge, Blutstillzange, alte Puzzles, Schwarmbewusstsein, Chrono-Pendel·Zwillingsgeburt“"
  },
  RelicConfig_57795_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Schatz des gesunkenen Schiffs“>"
  },
  RelicConfig_57795_StoryDesc = {
    Text = "Es wird gesagt, dass Lemuria in diesen Gewässern gefallen ist. Wer kann widerstehen, das Geheimnis des Schiffswrackschatzes zu erkunden?"
  },
  RelicConfig_57796_BattleDesc = {
    Text = "Relikt-Obergrenze +1. In den ersten fünf Runden nach Kampfbeginn erhält man am Beginn jeder Runde ein Relikt, darunter „Präzisionszeitmesser, Lorbeerknöpfe, Schleier des namenlosen Gottes, Alptraumdarstellung, Chrono-Pendel·Gleichgewicht“"
  },
  RelicConfig_57796_Desc = {
    Text = "Relikt-Obergrenze +1. In den ersten fünf Runden nach Kampfbeginn erhält man am Beginn jeder Runde ein Relikt, darunter „Präzisionszeitmesser, Lorbeerknöpfe, Schleier des namenlosen Gottes, Alptraumdarstellung, Chrono-Pendel·Gleichgewicht“"
  },
  RelicConfig_57796_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Schatz des gesunkenen Schiffs“>"
  },
  RelicConfig_57796_StoryDesc = {
    Text = "Die Legende besagt, dass Lemuria in diesen Gewässern gefallen ist. Wer kann es sich verkneifen, das Geheimnis des Schiffswrackschatzes zu erforschen?"
  },
  RelicConfig_57797_BattleDesc = {
    Text = "Relikt-Maximalwert +1. In den ersten fünf Runden nach Kampfbeginn erhältst du am Beginn jeder Runde ein Relikt, darunter „neues Portemonnaie, Mythag Emblem, Sternenwein, Kuss des Neunaugen, Chrono-Pendel·Auge“"
  },
  RelicConfig_57797_Desc = {
    Text = "Relikt-Maximalwert +1. In den ersten fünf Runden nach Kampfbeginn erhältst du am Beginn jeder Runde ein Relikt, darunter „neues Portemonnaie, Mythag Emblem, Sternenwein, Kuss des Neunaugen, Chrono-Pendel·Auge“"
  },
  RelicConfig_57797_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Schatz des gesunkenen Schiffs“>"
  },
  RelicConfig_57797_StoryDesc = {
    Text = "Es wird gesagt, dass Lemuria in diesen Gewässern gefallen ist. Wer kann es sich verkneifen, das Geheimnis des Schiffswrackschatzes zu erkunden?"
  },
  RelicConfig_58872_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. In den nächsten 5 Runden wird am Anfang jeder Runde 1 Relikt erhalten, darunter \"Rostige Weidenklinge, Neue Achse, Unser Heim, Kurioser Haken, Chrono-Pendel·Faszination\""
  },
  RelicConfig_58872_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. In den nächsten 5 Runden wird am Anfang jeder Runde 1 Relikt erhalten, darunter \"Rostige Weidenklinge, Neue Achse, Unser Heim, Kurioser Haken, Chrono-Pendel·Faszination\""
  },
  RelicConfig_58872_Name = {
    Text = "<OrangeQuality:Zeitpendel“Schatz α“>"
  },
  RelicConfig_58873_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. In den nächsten 5 Runden wird am Anfang jeder Runde 1 Relikt erhalten, darunter \"Süßes Tinte, Stummes Grammophon, Wein der Sterne, Zauberhut, Chrono-Pendel·Verwirrung\""
  },
  RelicConfig_58873_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. In den nächsten 5 Runden wird am Anfang jeder Runde 1 Relikt erhalten, darunter \"Süßes Tinte, Stummes Grammophon, Wein der Sterne, Zauberhut, Chrono-Pendel·Verwirrung\""
  },
  RelicConfig_58873_Name = {
    Text = "<OrangeQuality:Zeitpendel“Schatz β“>"
  },
  RelicConfig_59118_BattleDesc = {
    Text = "Am Anfang der Runde erhältst du 1 „Rykers Glückswürfel“, dessen geworfene Punkte +1 erhöhen. Zu Beginn der Runde erhalten alle Erwecker 4% kritischen Schaden, maximal 100%"
  },
  RelicConfig_59118_Desc = {
    Text = "Am Anfang der Runde erhältst du 1 „Rykers Glückswürfel“, dessen geworfene Punkte +1 erhöhen. Zu Beginn der Runde erhalten alle Erwecker 4% kritischen Schaden, maximal 100%"
  },
  RelicConfig_59118_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Chaos Geschenk“>"
  },
  RelicConfig_59118_StoryDesc = {
    Text = "Die alten Sünden sind hier eingraviert"
  },
  RelicConfig_59687_BattleDesc = {
    Text = "Simulationskampf Standard-Set 7"
  },
  RelicConfig_59687_Desc = {
    Text = "Simulationskampf Standard-Set 7"
  },
  RelicConfig_59687_Name = {
    Text = "<RedQuality:☆Simulationsartefakt☆>"
  },
  RelicConfig_59687_StoryDesc = {
    Text = "In seltsamen Epochen sind Blumen die ersten Beobachter der Menschheit.\nBeweg dich nicht, sie bevorzugen ruhige Ausstellungsstücke"
  },
  RelicConfig_60723_BattleDesc = {
    Text = "Max Arithmetica erhöht sich um 1, zu Rundenbeginn ziehe zusätzlich 1 Karte, du erhältst 1 “Symphonie der Harmonie“. Wenn 3 hintereinander ausgespielte Befehlskarten den gleichen Arithmetica-Verbrauch haben, erhalten alle Erwecker 20 Punkte Aliemus; zu Rundenbeginn und nach der Auslösung wird die Anzahl zurückgesetzt."
  },
  RelicConfig_60723_Desc = {
    Text = "Max Arithmetica erhöht sich um 1, zu Beginn der Runde ziehe zusätzlich 1 Karte, du erhältst 1 “Symphonie der Harmonie“. Wenn 3 hintereinander ausgespielte Befehlskarten die gleiche Arithmetica haben, erhalten alle Erwecker 20 Punkte Aliemus, die Anzahl wird zu Beginn der Runde und nach dem Auslösen zurückgesetzt."
  },
  RelicConfig_60723_Name = {
    Text = "<OrangeQuality:Taktstock>"
  },
  RelicConfig_60723_StoryDesc = {
    Text = [[
Der feine Taktstock hat mehr Kraft als ein Brecheisen.
Dirigiert Noten, Seelen, Schicksale]]
  },
  RelicConfig_60724_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhält man \"verwundbar\"-Orison und \"Explosion\"-Orison sowie deren fortgeschrittene Orison, wähle sie auf den Karten aus"
  },
  RelicConfig_60724_Desc = {
    Text = "Zu Beginn des Kampfes erhält man \"verwundbar\"-Orison und \"Explosion\"-Orison sowie deren fortgeschrittene Orison, wähle sie auf den Karten aus"
  },
  RelicConfig_60724_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Botschaft des Direktors“>"
  },
  RelicConfig_60724_StoryDesc = {
    Text = "Die Worte des Missaga-Gründers hallen in deinen Ohren.\nMöge der Silberschlüssel den Weg weisen, Hüter des Geheimnisses von Missaga"
  },
  RelicConfig_60725_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhält man \"Aelius\"-Orison und \"Katalysator\"-Orison sowie deren fortgeschrittene Orison, wähle sie auf den Karten aus"
  },
  RelicConfig_60725_Desc = {
    Text = "Zu Beginn des Kampfes erhält man \"Aelius\"-Orison und \"Katalysator\"-Orison sowie deren fortgeschrittene Orison, wähle sie auf den Karten aus"
  },
  RelicConfig_60725_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Botschaft des Direktors“>"
  },
  RelicConfig_60725_StoryDesc = {
    Text = "Die Worte des Missaga-Gründers hallen in deinen Ohren.\nMöge der Silberschlüssel den Weg weisen, Hüter des Geheimnisses von Missaga"
  },
  RelicConfig_60726_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhält man \"Schwäche\"-Orison und \"Berechnung\"-Orison sowie deren fortgeschrittene Orison, wähle sie auf den Karten aus"
  },
  RelicConfig_60726_Desc = {
    Text = "Zu Beginn des Kampfes erhält man \"Schwäche\"-Orison und \"Berechnung\"-Orison sowie deren fortgeschrittene Orison, wähle sie auf den Karten aus"
  },
  RelicConfig_60726_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Botschaft des Direktors“>"
  },
  RelicConfig_60726_StoryDesc = {
    Text = "Die Worte des Missaga-Gründers hallen in deinen Ohren.\nMöge der Silberschlüssel den Weg weisen, Hüter des Geheimnisses von Missaga"
  },
  RelicConfig_60727_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhält man \"Eisenwand\"-Orison und \"Zauberhafte Hände\"-Orison sowie deren fortgeschrittene Orison, wähle sie auf den Karten aus"
  },
  RelicConfig_60727_Desc = {
    Text = "Zu Beginn des Kampfes erhält man \"Eisenwand\"-Orison und \"Zauberhafte Hände\"-Orison sowie deren fortgeschrittene Orison, wähle sie auf den Karten aus"
  },
  RelicConfig_60727_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Botschaft des Direktors“>"
  },
  RelicConfig_60727_StoryDesc = {
    Text = "Die Worte des Missaga-Gründers hallen in deinen Ohren.\nMöge der Silberschlüssel den Weg weisen, Hüter des Geheimnisses von Missaga"
  },
  RelicConfig_60728_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhält man \"Kreation\"-Orison und \"Echos\"-Orison sowie deren fortgeschrittene Orison, wähle sie auf den Karten aus"
  },
  RelicConfig_60728_Desc = {
    Text = "Zu Beginn des Kampfes erhält man \"Kreation\"-Orison und \"Echos\"-Orison sowie deren fortgeschrittene Orison, wähle sie auf den Karten aus"
  },
  RelicConfig_60728_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Botschaft des Direktors“>"
  },
  RelicConfig_60728_StoryDesc = {
    Text = "Die Worte des Missaga-Gründers hallen in deinen Ohren.\nMöge der Silberschlüssel den Weg weisen, Hüter des Geheimnisses von Missaga"
  },
  RelicConfig_60729_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhält man \"Zauberhafte Hände\"-Orison und \"Inspiration\"-Orison sowie deren fortgeschrittene Orison, wähle sie auf den Karten aus"
  },
  RelicConfig_60729_Desc = {
    Text = "Zu Beginn des Kampfes erhält man \"Zauberhafte Hände\"-Orison und \"Inspiration\"-Orison sowie deren fortgeschrittene Orison, wähle sie auf den Karten aus"
  },
  RelicConfig_60729_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Botschaft des Direktors“>"
  },
  RelicConfig_60729_StoryDesc = {
    Text = "Die Worte des Missaga-Gründers hallen in deinen Ohren.\nMöge der Silberschlüssel den Weg weisen, Hüter des Geheimnisses von Missaga"
  },
  RelicConfig_60730_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhält man \"Rohheit\"-Orison und \"Erschöpfung\"-Orison sowie deren fortgeschrittene Orison, wähle sie auf den Karten aus"
  },
  RelicConfig_60730_Desc = {
    Text = "Zu Beginn des Kampfes erhält man \"Rohheit\"-Orison und \"Erschöpfung\"-Orison sowie deren fortgeschrittene Orison, wähle sie auf den Karten aus"
  },
  RelicConfig_60730_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Botschaft des Direktors“>"
  },
  RelicConfig_60730_StoryDesc = {
    Text = "Die Worte des Missaga-Gründers hallen in deinen Ohren.\nMöge der Silberschlüssel den Weg weisen, Hüter des Geheimnisses von Missaga"
  },
  RelicConfig_60731_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhält man 2 \"Ensemble\"-Orison sowie deren fortgeschrittene Orison, wähle sie auf den Karten aus"
  },
  RelicConfig_60731_Desc = {
    Text = "Zu Beginn des Kampfes erhält man 2 \"Ensemble\"-Orison sowie deren fortgeschrittene Orison, wähle sie auf den Karten aus"
  },
  RelicConfig_60731_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Botschaft des Direktors“>"
  },
  RelicConfig_60731_StoryDesc = {
    Text = "Die Worte des Missaga-Gründers hallen in deinen Ohren.\nMöge der Silberschlüssel den Weg weisen, Hüter des Geheimnisses von Missaga"
  },
  RelicConfig_60732_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhält man \"Berechnung\"-Orison und \"Spiegel\"-Orison sowie deren fortgeschrittene Orison, wähle sie auf den Karten aus"
  },
  RelicConfig_60732_Desc = {
    Text = "Zu Beginn des Kampfes erhält man \"Berechnung\"-Orison und \"Spiegel\"-Orison sowie deren fortgeschrittene Orison, wähle sie auf den Karten aus"
  },
  RelicConfig_60732_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Botschaft des Direktors“>"
  },
  RelicConfig_60732_StoryDesc = {
    Text = "Die Worte des Missaga-Gründers hallen in deinen Ohren.\nMöge der Silberschlüssel den Weg weisen, Hüter des Geheimnisses von Missaga"
  },
  RelicConfig_65376_BattleDesc = {
    Text = "Zu Beginn [Arg1] Expeditionsteilnehmer. Zu Beginn des Kampfes werden 5 Karten <DerivativeCardKeywords_73:Verdacht> in das Deck gemischt"
  },
  RelicConfig_65376_Desc = {
    Text = "Zu Beginn [Arg1] Forschungsteam-Mitglieder. Zu Beginn des Kampfes werden 5 <DerivativeCardKeywords_73:Verdacht> in das Deck gemischt."
  },
  RelicConfig_65376_Name = {
    Text = "<OrangeQuality:Expeditionsteam>"
  },
  RelicConfig_65376_StoryDesc = {
    Text = "Die Worte des Missaga-Gründers hallen in deinen Ohren.\nMöge der Silberschlüssel den Weg weisen, Hüter des Geheimnisses von Missaga"
  },
  RelicConfig_65406_BattleDesc = {
    Text = "Zu Beginn der Runde, erhalte [Arg1] <DerivativeCardKeywords_71:„Strahlendes menschliches Licht“>.\n<D05EX_Relic:Deine Bemühungen waren es wert. Du hast das Forschungsteam fast vollständig gerettet, und die Überlebenden sind dir aufrichtig dankbar.>"
  },
  RelicConfig_65406_Desc = {
    Text = "Zu Beginn der Runde, erhalte [Arg1] <DerivativeCardKeywords_71:„Strahlendes menschliches Licht“>.\n<D05EX_Relic:Deine Bemühungen waren es wert. Du hast das Forschungsteam fast vollständig gerettet, und die Überlebenden sind dir aufrichtig dankbar.>"
  },
  RelicConfig_65406_Name = {
    Text = "<OrangeQuality:Rettungsmedaille: Platin>"
  },
  RelicConfig_65406_StoryDesc = {
    Text = "Deine Mühen haben sich gelohnt, du hast fast das gesamte Forschungsteam gerettet, und die Überlebenden sind dir aufrichtig dankbar"
  },
  RelicConfig_65407_BattleDesc = {
    Text = "Zu Beginn der Runde, erhalte [Arg1] <DerivativeCardKeywords_72:“Brillanz der Menschlichkeit“>.\n<D05EX_Relic:Du hast unglaubliche Wunder geschaffen, alle Menschen haben die Katastrophe überlebt. Du bist der große Held in den Herzen der Menschen, und deine Legende wird vielleicht rund um den Schneeberg erzählt werden.>"
  },
  RelicConfig_65407_Desc = {
    Text = "Zu Beginn der Runde, erhalte [Arg1] <DerivativeCardKeywords_72:“Brillanz der Menschlichkeit“>.\n<D05EX_Relic:Du hast ein unglaubliches Wunder geschaffen, alle Menschen haben die Katastrophe überlebt. Du bist der große Held in den Herzen der Menschen, und deine Legende wird vielleicht rund um den Schneeberg verbreitet werden.>"
  },
  RelicConfig_65407_Name = {
    Text = "<OrangeQuality:Rettungsmedaille: Diamant>"
  },
  RelicConfig_65407_StoryDesc = {
    Text = "Du hast ein unglaubliches Wunder geschaffen, alle haben die Katastrophe überlebt, du bist der große Held in den Herzen der Menschen. Deine Legende wird vielleicht rund um den Schneeberg erzählt werden"
  },
  RelicConfig_65408_BattleDesc = {
    Text = "Zu Beginn der Runde, erhalte [Arg1] <DerivativeCardKeywords_68:“Glanz der Menschlichkeit“>.\n<D05EX_Relic:Um aus den Schneebergen zu kommen, hast du eine strategie mit Priorität auf Effizienz gewählt und beobachtest, wie die Menschen einer nach dem anderen sterben. In den Blick der Überlebenden liegt mehr Angst als Dankbarkeit.>"
  },
  RelicConfig_65408_Desc = {
    Text = "Zu Beginn der Runde, erhalte [Arg1] <DerivativeCardKeywords_68:“Glanz der Menschlichkeit“>.\n<D05EX_Relic:Um aus dem Schneeberg zu kommen, hast du eine strategie mit Priorität auf Nutzen gewählt und beobachtet, wie die Menschen einer nach dem anderen starben. In den Blick der Überlebenden liegt mehr Angst als Dankbarkeit.>"
  },
  RelicConfig_65408_Name = {
    Text = "<OrangeQuality:Rettungsmedaille·Bronze>"
  },
  RelicConfig_65408_StoryDesc = {
    Text = "Um den Schneeberg zu überwinden, hast du eine gewinnorientierte Strategie gewählt und beobachtet, wie die Leute nacheinander sterben. Das Licht der Überlebenden zeigt mehr Angst als Dankbarkeit"
  },
  RelicConfig_65409_BattleDesc = {
    Text = "Zu Beginn der Runde, erhalte [Arg1] <DerivativeCardKeywords_69:„Schwaches menschliches Licht“>.\n<D05EX_Relic:Du hast es vielleicht versucht, obwohl die Hälfte der Menschen starb, hast du zumindest die andere Hälfte gerettet. Opfer sind unvermeidlich.>"
  },
  RelicConfig_65409_Desc = {
    Text = "Zu Beginn der Runde, erhalte [Arg1] <DerivativeCardKeywords_69:„Schwaches menschliches Licht“>.\n<D05EX_Relic:Du hast es vielleicht versucht, obwohl die Hälfte der Menschen starb, hast du zumindest die andere Hälfte gerettet. Opfer sind unvermeidlich.>"
  },
  RelicConfig_65409_Name = {
    Text = "<OrangeQuality:Rettungsmedaille: Silber>"
  },
  RelicConfig_65409_StoryDesc = {
    Text = "Vielleicht hast du es versucht, und obwohl die Hälfte gestorben ist, hast du zumindest die andere Hälfte gerettet. Opfer sind unvermeidlich"
  },
  RelicConfig_65410_BattleDesc = {
    Text = "Zu Beginn der Runde, erhalte [Arg1] <DerivativeCardKeywords_70:„Menschliches Licht“>.\n<D05EX_Relic:Du hast die meisten Menschen gerettet und ihr tragisches Schicksal verändert. Du hast dein Bestes gegeben, oder?>"
  },
  RelicConfig_65410_Desc = {
    Text = "Zu Beginn der Runde, erhalte [Arg1] <DerivativeCardKeywords_70:„Menschliches Licht“>.\n<D05EX_Relic:Du hast die meisten Menschen gerettet und ihr tragisches Schicksal verändert. Du hast dein Bestes gegeben, oder?>"
  },
  RelicConfig_65410_Name = {
    Text = "<OrangeQuality:Rettungsmedaille·Gold>"
  },
  RelicConfig_65410_StoryDesc = {
    Text = "Du hast die meisten Menschen gerettet und ihr tragisches Schicksal verändert. Du hast dein Bestes gegeben, oder?"
  },
  RelicConfig_65456_BattleDesc = {
    Text = "Zu Beginn des Kampfes werden 3 zufällige „Symptome“ ins Deck gemischt, bei „Symptome“ +[Arg1] Stärke.\n<D05EX_Relic:Mit deiner Hilfe hat kein Mitglied der Expedition überlebt. Du hast kaltblütig den größten Nutzen für dich selbst gezogen, aber war es das wirklich wert?>"
  },
  RelicConfig_65456_Desc = {
    Text = "Zu Beginn des Kampfes werden 3 zufällige „Symptome“ ins Deck gemischt, bei „Symptome“ +[Arg1] Stärke.\n<D05EX_Relic:Mit deiner Hilfe hat kein Mitglied der Expedition überlebt. Du hast kaltblütig den größten Nutzen für dich selbst gezogen, aber war es das wirklich wert?>"
  },
  RelicConfig_65456_Name = {
    Text = "<OrangeQuality:Abzeichen des Einzelgängers>"
  },
  RelicConfig_65456_StoryDesc = {
    Text = "Mit deiner Hilfe überlebte niemand aus dem Forschungsteam. Du hast den größten Nutzen daraus gezogen, aber war es das wert?"
  },
  RelicConfig_65569_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. In den nächsten 5 Runden wird am Anfang jeder Runde 1 Relikt erhalten, darunter \"Kommunikationsgerät, Frühlingsfest, Priesterstab, Unglückszeremonien-Vogel, Chrono-Pendel·Projektion\""
  },
  RelicConfig_65569_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. In den nächsten 5 Runden wird am Anfang jeder Runde 1 Relikt erhalten, darunter \"Kommunikationsgerät, Frühlingsfest, Priesterstab, Unglückszeremonien-Vogel, Chrono-Pendel·Projektion\""
  },
  RelicConfig_65569_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Schatz δ“>"
  },
  RelicConfig_65570_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. In den nächsten 5 Runden wird am Anfang jeder Runde 1 Relikt erhalten, darunter \"Mythag Emblem, Doktor's Koffer, Prototyp-Batterie, Bewusstseinsgravur, Chrono-Pendel·Evolution\""
  },
  RelicConfig_65570_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. In den nächsten 5 Runden wird am Anfang jeder Runde 1 Relikt erhalten, darunter \"Mythag Emblem, Doktor's Koffer, Prototyp-Batterie, Bewusstseinsgravur, Chrono-Pendel·Evolution\""
  },
  RelicConfig_65570_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Schatz γ“>"
  },
  RelicConfig_66515_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. In den nächsten 5 Runden wird am Anfang jeder Runde 1 Relikt erhalten, darunter \"Putney Morning News, Ästhetikprinzipien, Lied der Mobben, Unvollkommene Gesichter, Chrono-Pendel·Wechsel\""
  },
  RelicConfig_66515_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. In den nächsten 5 Runden wird am Anfang jeder Runde 1 Relikt erhalten, darunter \"Putney Morning News, Ästhetikprinzipien, Lied der Mobben, Unvollkommene Gesichter, Chrono-Pendel·Wechsel\""
  },
  RelicConfig_66515_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Schatz ε“>"
  },
  RelicConfig_66518_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. In ungeraden Runden findet 1 Relikt, insgesamt 5 Mal"
  },
  RelicConfig_66518_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. In ungeraden Runden findet 1 Relikt, insgesamt 5 Mal"
  },
  RelicConfig_66518_Name = {
    Text = "<OrangeQuality:Zeitpendel“Wunsch β“>"
  },
  RelicConfig_66519_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. In ungeraden Runden findet 1 Relikt, insgesamt 5 Mal"
  },
  RelicConfig_66519_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. In ungeraden Runden findet 1 Relikt, insgesamt 5 Mal"
  },
  RelicConfig_66519_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Wunsch α“>"
  },
  RelicConfig_67690_BattleDesc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwecker 25 Aelius. Beim Aufsammeln wird die maximale Gesundheit auf das 1,5-fache erhöht"
  },
  RelicConfig_67690_Desc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwecker 25 Aelius. Beim Aufsammeln wird die maximale Gesundheit auf das 1,5-fache erhöht"
  },
  RelicConfig_67690_Name = {
    Text = "<OrangeQuality:Gesegnet·Albtraumdarstellung β>"
  },
  RelicConfig_67690_StoryDesc = {
    Text = "Keine Angst, keine Zweifel. Dies ist nur ein flüchtiger Traum, das Licht des Vaters scheint immer noch auf dich"
  },
  RelicConfig_67788_BattleDesc = {
    Text = "Beim Aufheben erhält man 3 Punkte Zugkraft"
  },
  RelicConfig_67788_Desc = {
    Text = "Beim Aufheben erhält man 3 Punkte Zugkraft"
  },
  RelicConfig_67788_Name = {
    Text = "<WhiteQuality:Taschenuhrspiegel>"
  },
  RelicConfig_67788_StoryDesc = {
    Text = "Erinnerungen erstarren in der Vergangenheit, tief im Schwarz vergraben"
  },
  RelicConfig_67789_BattleDesc = {
    Text = "Beim Aufheben wird 1 <DerivativeCardKeywords_1:„Echo der Schatten“> auf die Hand gelegt"
  },
  RelicConfig_67789_Desc = {
    Text = "Beim Aufheben wird 1 <DerivativeCardKeywords_1:„Echo der Schatten“> auf die Hand gelegt"
  },
  RelicConfig_67789_Name = {
    Text = "<WhiteQuality:Kommunikationsgerät>"
  },
  RelicConfig_67789_StoryDesc = {
    Text = "Erwartung oder Angst vor dem Moment, in dem es klingelt"
  },
  RelicConfig_67790_BattleDesc = {
    Text = "Der kritische Schaden aller „Schläge“ wird um 20% erhöht. Beim Aufheben erhältst du eine Karte <DerivativeCardKeywords_40: „Wunderschöne Momente“>"
  },
  RelicConfig_67790_Desc = {
    Text = "Der kritische Schaden aller „Schläge“ wird um 20% erhöht. Beim Aufheben erhältst du eine Karte <DerivativeCardKeywords_40: „Wunderschöne Momente“>"
  },
  RelicConfig_67790_Name = {
    Text = "<WhiteQuality:Schöner Moment>"
  },
  RelicConfig_67790_StoryDesc = {
    Text = "Bewahre die flüchtige Schönheit für immer"
  },
  RelicConfig_67791_BattleDesc = {
    Text = "Beim Aufheben wird auf alle Feinde für 1 Runde <WeaknessIconKeywords:Schwäche> und <VulnerabilityIconKeywords:verwundbar> angewendet"
  },
  RelicConfig_67791_Desc = {
    Text = "Beim Aufheben wird auf alle Feinde für 1 Runde <WeaknessIconKeywords:Schwäche> und <VulnerabilityIconKeywords:verwundbar> angewendet"
  },
  RelicConfig_67791_Name = {
    Text = "<WhiteQuality:Chamäleonzwangjacke>"
  },
  RelicConfig_67791_StoryDesc = {
    Text = "Nicht nur Zeit kann Stoffe verfärben, auch Angst und Schmerz"
  },
  RelicConfig_67793_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhält jeder Erwecker 50 Punkte Aelius. Lege 2 Karten<DerivativeCardKeywords_1:„Nachklang der Schatten“> in die Hand"
  },
  RelicConfig_67793_Desc = {
    Text = "Beim Aufheben erhalten alle Erwecker 50 Punkte Aelius, und 2 <DerivativeCardKeywords_1:„Echo der Schatten“> werden auf die Hand gelegt"
  },
  RelicConfig_67793_Name = {
    Text = "<OrangeQuality:Kommunikationsgerät +β>"
  },
  RelicConfig_67793_StoryDesc = {
    Text = "Erwartung oder Angst vor dem Moment, in dem es klingelt"
  },
  RelicConfig_67794_BattleDesc = {
    Text = "Handkartenlimit erhöht um 5, zu Beginn des Kampfes Handkarten auf das Limit auffüllen. Am Zuganfang zusätzlich 1 Karte ziehen, am Ende des Zuges alle Symptomkarten und Zustandskarten ablegen, andere Karten behalten"
  },
  RelicConfig_67794_Desc = {
    Text = "Handkartenlimit erhöht um 5, zu Beginn des Kampfes Handkarten auf das Limit auffüllen. Am Zuganfang zusätzlich 1 Karte ziehen, am Ende des Zuges alle Symptomkarten und Zustandskarten ablegen, andere Karten behalten"
  },
  RelicConfig_67794_Name = {
    Text = "<OrangeQuality:Gesegnet·Bewusstseinsprägung β>"
  },
  RelicConfig_67794_StoryDesc = {
    Text = "Der Gierige trägt seine Fehler im Herzen und sucht Buße für seine Vergangenheit"
  },
  RelicConfig_67818_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn der Runde findet zufällig 5 Mal einen \"Relikt\" oder \"Unterstützung\""
  },
  RelicConfig_67818_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn der Runde findet zufällig 5 Mal einen \"Relikt\" oder \"Unterstützung\""
  },
  RelicConfig_67818_Name = {
    Text = "<OrangeQuality:“Mundator-Tür ε“>"
  },
  RelicConfig_67819_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn der Runde findet zufällig 5 Mal einen \"Relikt\" oder \"Unterstützung\""
  },
  RelicConfig_67819_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn der Runde findet zufällig 5 Mal einen \"Relikt\" oder \"Unterstützung\""
  },
  RelicConfig_67819_Name = {
    Text = "<OrangeQuality:“Mundator-Tür ζ“>"
  },
  RelicConfig_67820_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn der Runde findet zufällig 5 Mal einen \"Relikt\" oder \"Unterstützung\""
  },
  RelicConfig_67820_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn der Runde findet zufällig 5 Mal einen \"Relikt\" oder \"Unterstützung\""
  },
  RelicConfig_67820_Name = {
    Text = "<OrangeQuality:“Mundator-Tür θ“>"
  },
  RelicConfig_67821_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn der Runde findet zufällig 5 Mal einen \"Relikt\" oder \"Unterstützung\""
  },
  RelicConfig_67821_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn der Runde findet zufällig 5 Mal einen \"Relikt\" oder \"Unterstützung\""
  },
  RelicConfig_67821_Name = {
    Text = "<OrangeQuality:“Mundator-Tür γ“>"
  },
  RelicConfig_67822_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn der Runde findet zufällig 5 Mal einen \"Relikt\" oder \"Unterstützung\""
  },
  RelicConfig_67822_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn der Runde findet zufällig 5 Mal einen \"Relikt\" oder \"Unterstützung\""
  },
  RelicConfig_67822_Name = {
    Text = "<OrangeQuality:“Mundator-Tür α“>"
  },
  RelicConfig_67823_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn der Runde findet zufällig 5 Mal einen \"Relikt\" oder \"Unterstützung\""
  },
  RelicConfig_67823_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn der Runde findet zufällig 5 Mal einen \"Relikt\" oder \"Unterstützung\""
  },
  RelicConfig_67823_Name = {
    Text = "<OrangeQuality:“Mundator-Tür η“>"
  },
  RelicConfig_67824_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn der Runde findet zufällig 5 Mal einen \"Relikt\" oder \"Unterstützung\""
  },
  RelicConfig_67824_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn der Runde findet zufällig 5 Mal einen \"Relikt\" oder \"Unterstützung\""
  },
  RelicConfig_67824_Name = {
    Text = "<OrangeQuality:“Mundator-Tür δ“>"
  },
  RelicConfig_67825_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn der Runde findet zufällig 5 Mal einen \"Relikt\" oder \"Unterstützung\""
  },
  RelicConfig_67825_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn der Runde findet zufällig 5 Mal einen \"Relikt\" oder \"Unterstützung\""
  },
  RelicConfig_67825_Name = {
    Text = "<OrangeQuality:“Mundator-Tür β“>"
  },
  RelicConfig_67826_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn der Runde findet zufällig 5 Mal einen \"Relikt\" oder \"Unterstützung\""
  },
  RelicConfig_67826_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn der Runde findet zufällig 5 Mal einen \"Relikt\" oder \"Unterstützung\""
  },
  RelicConfig_67826_Name = {
    Text = "<OrangeQuality:“Mundator-Tür ι“>"
  },
  RelicConfig_68651_BattleDesc = {
    Text = "Zu Beginn des Kampfes erwecke alle Erwecker, lege <DerivativeCardKeywords_84:“Dämmerung: Unvollendete Wachsskulptur“> auf die Hand, kopiere alle Karten des Ziehstapels. Ziehe jede Runde zusätzlich 5 Karten und erhalte 5 Punkte Arithmetica. Nach dem Spielen von “Schlag“ oder “VERT“ erhältst du [Arg1] Punkte Schild."
  },
  RelicConfig_68651_Desc = {
    Text = "Zu Beginn des Kampfes wecke alle Erwecker und lege <DerivativeCardKeywords_84:“Dämmerung: Unvollendete Wachsskulptur“> auf die Hand, kopiere alle Karten des Ziehstapels. Ziehe zusätzlich 5 Karten pro Runde und erhalte 5 Punkte Arithmetica. Nach dem Spielen von “Schlag“ oder “VERT“ erhältst du [Arg1] Punkte Schild."
  },
  RelicConfig_68651_Name = {
    Text = "<OrangeQuality:«Kern aus Silber – Angst»>"
  },
  RelicConfig_68652_BattleDesc = {
    Text = "Zu Beginn des Kampfes wecke alle Erwecker und füge <DerivativeCardKeywords_85:“Dämmerung: Mutiertes Herz“> deiner Hand hinzu. Zu Beginn der Runde kannst du beliebig viele Handkarten abwerfen und gleich viele Karten ziehen. In ungeraden Runden erhältst du [Arg1] Punkte temporäre STR und füge “<DerivativeCardKeywords_97:Unnachgiebiger Wille β“> deiner Hand hinzu. In geraden Runden erhältst du [Arg2] Punkte temporäre Vorsicht und füge <DerivativeCardKeywords_98:“Versteckenβ“> deiner Hand hinzu."
  },
  RelicConfig_68652_Desc = {
    Text = "Zu Beginn des Kampfes wecke alle Erwecker und lege <DerivativeCardKeywords_85:“Dämmerung: Mutiertes Herz“> auf die Hand. Zu Beginn der Runde kannst du beliebig viele Handkarten abwerfen und die gleiche Anzahl an Karten ziehen. In ungeraden Runden erhältst du [Arg1] Punkte temporäre STR und lege <DerivativeCardKeywords_97:“Unnachgiebiger Wille β“> auf die Hand. In geraden Runden erhältst du [Arg2] Punkte temporäre Vorsicht und lege <DerivativeCardKeywords_98:“Versteckenβ“> auf die Hand."
  },
  RelicConfig_68652_Name = {
    Text = "<OrangeQuality:“Kern aus reinem Silber · Beißendes Frösteln“>"
  },
  RelicConfig_68653_BattleDesc = {
    Text = "Zu Beginn des Kampfes erwecke alle Erwecker und lege <DerivativeCardKeywords_83:“Dämmerung: Unschuldiges Gegengeschenk“> in die Hand. Alle Erwecker können pro Runde zusätzlich 1 Mal eine Verherrlichung auslösen, und nach dem Auslösen der Verherrlichung wird die Kraft des Gegners um [Arg2] Punkte reduziert. Zu Beginn der Runde erhalten alle Erwecker [Arg1] Punkte Aliemus."
  },
  RelicConfig_68653_Desc = {
    Text = "Zu Beginn des Kampfes erwecke alle Erwachten und lege <DerivativeCardKeywords_83:“Dämmerung: Unschuldiges Gegengeschenk“> in deine Hand. Alle Erwachten können in jeder Runde zusätzlich 1 Mal die Verherrlichung auslösen, nach der Auslösung der Verherrlichung wird die Kraft des Gegners um [Arg2] Punkte reduziert. Zu Beginn der Runde erhalten alle Erwachten [Arg1] Punkte Aliemus."
  },
  RelicConfig_68653_Name = {
    Text = "<OrangeQuality:“Kern aus reinem Silber · Klage“>"
  },
  RelicConfig_68654_BattleDesc = {
    Text = "Zu Beginn des Kampfes alle Erwecker erwecken, lege <DerivativeCardKeywords_88:“Dämmerung: Utopischer Schleier“> auf die Hand, die maximale Handgröße des Teams +2, die Speicherkapazität der Schlüsselenergie +100%. Nach der Freigabe der Posse erhalten alle Erwecker vorübergehend +[Arg1]% kritische Trefferquote und kritischen Schaden, erhalten einen Schild, der 20% der maximalen Gesundheit entspricht, ziehe Karten, bis die Handgröße erreicht ist."
  },
  RelicConfig_68654_Desc = {
    Text = "Zu Beginn des Kampfes alle Erwecker erwecken, lege <DerivativeCardKeywords_88:“Dämmerung: Utopischer Schleier“> auf die Hand, die maximale Handgröße des Teams +2, die maximale Speicherung von Keyflare +100%. Nach dem Freigeben der Posse erhalten alle Erwecker vorübergehend Krit. Rate und Krit. Schaden + [Arg1] %, erhalte einen Schild, der 20% der maximalen LP entspricht, ziehe Karten bis die Handgröße erreicht ist."
  },
  RelicConfig_68654_Name = {
    Text = "<OrangeQuality:“Kern aus reinem Silber · Wahnsinnig“>"
  },
  RelicConfig_68655_BattleDesc = {
    Text = "Zu Beginn des Kampfes werden alle Erwecker erweckt und <DerivativeCardKeywords_89:“Dämmerung: Samen der Fülle“> auf die Hand genommen. Am Ende der Runde werden die verbleibenden Arithmetica behalten und keine Handkarten mehr abgeworfen. Für jeden verursachten aktiven Schaden erhältst du [Arg1] temporäre Stärke und [Arg2] Schild."
  },
  RelicConfig_68655_Desc = {
    Text = "Zu Beginn des Kampfes werden alle Erwecker erweckt und <DerivativeCardKeywords_89:“Dämmerung: Samen der Fülle“> auf die Hand genommen. Am Ende der Runde werden die verbleibenden Arithmetica behalten und keine Karten mehr abgeworfen. Für jeden verursachten aktiven Schaden erhältst du [Arg1] temporäre Stärke und [Arg2] Schild."
  },
  RelicConfig_68655_Name = {
    Text = "<OrangeQuality:“Kern aus reinem Silber · Erscheinen“>"
  },
  RelicConfig_68656_BattleDesc = {
    Text = "Zu Beginn des Kampfes erwecke alle Erwecker und lege <DerivativeCardKeywords_86:„Dämmerung: Honigmet“> auf die Hand. Der Kritische Schaden aller Erwecker wird auf das 1,5-fache erhöht. Am Ende der Runde erhalten Erwecker, die „Verherrlichung“ nicht ausgelöst haben, [Arg1] Punkte Aliemus. Wenn die Anzahl der gespielten Karten kleiner als [Arg2] ist, ziehe in der nächsten Runde 2 Karten und erhalte 2 Punkte Arithmetica."
  },
  RelicConfig_68656_Desc = {
    Text = "Zu Beginn des Kampfes erwecke alle Erwecker und lege <DerivativeCardKeywords_86:„Dämmerung: Honigmet“> in die Hand. Der kritische Schaden aller Erwecker wird auf das 1,5-fache erhöht. Am Ende der Runde erhält der Erwecker, der „Wahnsinnsexplosion“ nicht ausgelöst hat, [Arg1] Punkte Aelius. Wenn die gespielte Kartenanzahl kleiner ist als [Arg2], ziehe in der nächsten Runde 2 Karten und erhalte 2 Punkte Arithmetica."
  },
  RelicConfig_68656_Name = {
    Text = "<OrangeQuality:“Kern aus reinem Silber · Hintergründig“>"
  },
  RelicConfig_68657_BattleDesc = {
    Text = "Zu Kampfbeginn: Erwecke alle Erwecker, lege <DerivativeCardKeywords_87:„Dämmerung: Das Urteil des Vollstreckers“> auf die Hand und verdopple die Schadenamplifikation des Teams. Der von dir verursachte Symptom: Schwäche-Effekt erhöht sich von 25% auf 50%. Am Ende jedes Zuges erhalte Schild in Höhe von [Arg1]% der Max LP und füge allen Gegnern <FixedDamage:Reinen SCH> in Höhe von [Arg2] x Schild zu."
  },
  RelicConfig_68657_Desc = {
    Text = "Zu Kampfbeginn: Erwecke alle Erwecker, lege <DerivativeCardKeywords_87:„Dämmerung: Das Urteil des Vollstreckers“> auf die Hand und verdopple die Schadenamplifikation des Teams. Der von dir verursachte Symptom: Schwäche-Effekt erhöht sich von 25% auf 50%. Am Ende jedes Zuges erhalte Schild in Höhe von [Arg1]% der Max LP und füge allen Gegnern <FixedDamage:Reinen SCH> in Höhe von [Arg2] x Schild zu."
  },
  RelicConfig_68657_Name = {
    Text = "<OrangeQuality:“Kern aus reinem Silber · Aberglaube“>"
  },
  RelicConfig_68886_BattleDesc = {
    Text = "Der Schaden, die Heilung und der Schild von Tawil werden um 50 % erhöht. Zu Beginn des Kampfes erhält Tawil 120 Punkte Wahnsinn."
  },
  RelicConfig_68886_Desc = {
    Text = "Schaden, Schild und Heilung von Tawil erhöhen sich um 50 %. Zu Beginn des Kampfes erhält Tawil 120 Punkte Wahnsinn."
  },
  RelicConfig_68886_Name = {
    Text = "<OrangeQuality:“Auge der Allwissenheit“>"
  },
  RelicConfig_68886_StoryDesc = {
    Text = "Von der Türschwelle aus betritt Er den einzig richtigen Weg."
  },
  RelicConfig_69319_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. In ungeraden Runden findet 1 Relikt, insgesamt 5 Mal"
  },
  RelicConfig_69319_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. In ungeraden Runden findet 1 Relikt, insgesamt 5 Mal"
  },
  RelicConfig_69319_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Wunsch ε“>"
  },
  RelicConfig_69320_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. In ungeraden Runden findet 1 Relikt, insgesamt 5 Mal"
  },
  RelicConfig_69320_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. In ungeraden Runden findet 1 Relikt, insgesamt 5 Mal"
  },
  RelicConfig_69320_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Wunsch γ“>"
  },
  RelicConfig_69321_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. In ungeraden Runden findet 1 Relikt, insgesamt 5 Mal"
  },
  RelicConfig_69321_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. In ungeraden Runden findet 1 Relikt, insgesamt 5 Mal"
  },
  RelicConfig_69321_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Wunsch δ“>"
  },
  RelicConfig_70042_BattleDesc = {
    Text = "Zu Rundenbeginn, sammle 1 Punkt “Abgrundenergie“ und wähle “Schlaf“ oder “Erwachen“. Schlaf: Sammle zusätzlich 1 Punkt “Abgrundenergie“. Erwachen: Verbrauche 1/5/10 Punkte “Abgrundenergie“, um Tulus Unterstützung zu erhalten. Je mehr “Abgrundenergie“ verbraucht wird, desto stärker ist die Unterstützung von Tulu."
  },
  RelicConfig_70042_Desc = {
    Text = "Zu Rundenbeginn, sammle 1 Punkt “Abgrundenergie“ und wähle “Schlaf“ oder “Erwachen“. Schlaf: Sammle zusätzlich 1 Punkt “Abgrundenergie“. Erwachen: Verbrauche 1/5/10 Punkte “Abgrundenergie“, um Tulus Unterstützung zu erhalten. Je mehr “Abgrundenergie“ verbraucht wird, desto stärker ist die Unterstützung von Tulu."
  },
  RelicConfig_70042_Name = {
    Text = "<OrangeQuality:Macht des Gotteskönigs>"
  },
  RelicConfig_70084_BattleDesc = {
    Text = "Zu Beginn des Kampfes werden alle <ExaltIconKeywords:Gnosis> der Erwecker in den Ziehstapel gemischt."
  },
  RelicConfig_70084_Desc = {
    Text = "Zu Beginn des Kampfes werden alle <ExaltIconKeywords:Gnosis> der Erwecker in den Ziehstapel gemischt."
  },
  RelicConfig_70084_Name = {
    Text = "<OrangeQuality:Wecken>"
  },
  RelicConfig_70700_BattleDesc = {
    Text = "Alle Erwecker erhöhen den Basisschaden um [Arg1]%."
  },
  RelicConfig_70700_Desc = {
    Text = "Alle Erwecker erhöhen den Basisschaden um [Arg1]%."
  },
  RelicConfig_70700_Name = {
    Text = "<WhiteQuality:Weinende Pfeife>"
  },
  RelicConfig_70700_StoryDesc = {
    Text = "Ist das das Ergebnis von Hass oder Rache?"
  },
  RelicConfig_70701_BattleDesc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwachten [Arg1] Wahnsinn."
  },
  RelicConfig_70701_Desc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwachten [Arg1] Wahnsinn."
  },
  RelicConfig_70701_Name = {
    Text = "<WhiteQuality:Prototyp-Batterie>"
  },
  RelicConfig_70701_StoryDesc = {
    Text = "Tragbare Hoffnung"
  },
  RelicConfig_70702_BattleDesc = {
    Text = "Nach der Freisetzung von „Exaltieren“ erhältst du [Arg1] temporäre <PowerIconKeywords:Macht>."
  },
  RelicConfig_70702_Desc = {
    Text = "Nach der Freisetzung von „Exaltieren“ erhältst du [Arg1] temporäre <PowerIconKeywords:Macht>."
  },
  RelicConfig_70702_Name = {
    Text = "<OrangeQuality:Zurückschließen+>"
  },
  RelicConfig_70702_StoryDesc = {
    Text = "Eine dicke und solide Sperre, ohne Schlüssel schwer zu öffnen.\nNatürlich ist das für einen Meisterdieb kein Problem"
  },
  RelicConfig_70703_BattleDesc = {
    Text = "„Schlag“ verursacht zusätzlich [Arg1]% des ANGs des Erweckungskörpers als Schaden, maximal 3-mal pro Runde auslösbar."
  },
  RelicConfig_70703_Desc = {
    Text = "„Schlag“ verursacht zusätzlich [Arg1]% des ANGs des Erweckungskörpers als Schaden, maximal 3-mal pro Runde auslösbar."
  },
  RelicConfig_70703_Name = {
    Text = "<WhiteQuality:Rostiges Weidenblattmesser>"
  },
  RelicConfig_70703_StoryDesc = {
    Text = "Nicht geeignet zum Schneiden von Lebewesen"
  },
  RelicConfig_70704_BattleDesc = {
    Text = "Nach der Silberschlüssel-Erweckung allen Feinden [Arg1] <IntoxicationIconKeywords:Vergiftung> auferlegen und [Arg2] Silberschlüssel-Energie erhalten."
  },
  RelicConfig_70704_Desc = {
    Text = "Nach der Silberschlüssel-Erweckung allen Feinden [Arg1] <IntoxicationIconKeywords:Vergiftung> auferlegen und [Arg2] Silberschlüssel-Energie erhalten."
  },
  RelicConfig_70704_Name = {
    Text = "<OrangeQuality:Zweifelhafte Salbe+>"
  },
  RelicConfig_70704_StoryDesc = {
    Text = "Eine selbstgemachte Wundsalbe, bitte nicht ohne ärztlichen Rat verwenden"
  },
  RelicConfig_70705_BattleDesc = {
    Text = "“Schlag“ fügt Gift hinzu, das [Arg1]% des Schadens entspricht, maximal [Arg2] Punkte pro Runde."
  },
  RelicConfig_70705_Desc = {
    Text = "“Schlag“ fügt Gift hinzu, das [Arg1]% des Schadens entspricht, maximal [Arg2] Punkte pro Runde."
  },
  RelicConfig_70705_Name = {
    Text = "<OrangeQuality:Fremde Zunge+>"
  },
  RelicConfig_70705_StoryDesc = {
    Text = "Er ist kein Dämon, aber er flüstert von jenseits der Welt"
  },
  RelicConfig_70706_BattleDesc = {
    Text = "Die automatisch erhaltene Menge von <EmbryoFusionIconKeywords:Embryo-Fusion> erhöht sich um [Arg1]%."
  },
  RelicConfig_70706_Desc = {
    Text = "Die automatisch erhaltene Menge von <EmbryoFusionIconKeywords:Embryo-Fusion> erhöht sich um [Arg1]%."
  },
  RelicConfig_70706_Name = {
    Text = "<WhiteQuality:Pestdiagnose>"
  },
  RelicConfig_70706_StoryDesc = {
    Text = "Pest—ein zufälliger Ausdruck der unbewussten Unruhe der Natur"
  },
  RelicConfig_70707_BattleDesc = {
    Text = "Nach der Silberschlüsselerweckung erhalten alle Erwachten [Arg1] Wahnsinn und [Arg2] s-Energie."
  },
  RelicConfig_70707_Desc = {
    Text = "Nach der Silberschlüsselerweckung erhalten alle Erwachten [Arg1] Wahnsinn und [Arg2] s-Energie."
  },
  RelicConfig_70707_Name = {
    Text = "<OrangeQuality:Lorbeermanschettenknöpfe+>"
  },
  RelicConfig_70707_StoryDesc = {
    Text = "Silberne Manschettenknöpfe mit Lorbeerblattmuster.\nSie sind fein gearbeitet und glänzend, und sie trugen einst die Freundschaft zweier Kinder"
  },
  RelicConfig_70708_BattleDesc = {
    Text = "Nach Beginn des Kampfes erhältst du [Arg1] <ProficientInRealmsIconKeywords:Reichsbeherrschung>. Die <IntoxicationIconKeywords:Vergiftung> aller Erwachten und die <IntoxicationIconKeywords:Vergiftung> von Relikten wird um [Arg2]% erhöht."
  },
  RelicConfig_70708_Desc = {
    Text = "Nach Beginn des Kampfes erhältst du [Arg1] <ProficientInRealmsIconKeywords:Reichsbeherrschung>. Die <IntoxicationIconKeywords:Vergiftung> aller Erwachten und die <IntoxicationIconKeywords:Vergiftung> von Relikten wird um [Arg2]% erhöht."
  },
  RelicConfig_70708_Name = {
    Text = "<OrangeQuality:Staubige Nähmaschine+>"
  },
  RelicConfig_70708_StoryDesc = {
    Text = "Eine liebevolle Mutter, die die Wunden des Herzens näht"
  },
  RelicConfig_70709_BattleDesc = {
    Text = "Nach Eintritt in den Hyperraum-Zug löst die erste gespielte nicht abgeleitete Befehlskarte [Arg1]-Mal zusätzlich aus."
  },
  RelicConfig_70709_Desc = {
    Text = "Nach Eintritt in den Hyperraum-Zug löst die erste gespielte nicht abgeleitete Befehlskarte [Arg1]-Mal zusätzlich aus."
  },
  RelicConfig_70709_Name = {
    Text = "<WhiteQuality:Schimmer Sanduhr>"
  },
  RelicConfig_70709_StoryDesc = {
    Text = "Eine messbare Zeit"
  },
  RelicConfig_70711_BattleDesc = {
    Text = "Nach der Silberschlüssel-Erweckung [Arg1] <RetaliateIconKeywords:Gegenangriff> erhalten und [Arg2] Silberschlüssel-Energie sammeln."
  },
  RelicConfig_70711_Desc = {
    Text = "Nach der Silberschlüssel-Erweckung [Arg1] <RetaliateIconKeywords:Gegenangriff> erhalten und [Arg2] Silberschlüssel-Energie sammeln."
  },
  RelicConfig_70711_Name = {
    Text = "<OrangeQuality:Weisheitsfragment+>"
  },
  RelicConfig_70711_StoryDesc = {
    Text = "“Menschen sind so dumm, sie glauben blind an das Alte.“"
  },
  RelicConfig_70712_BattleDesc = {
    Text = "Nach der Silberschlüssel-Aktivierung erhalten Sie [Arg1] <PowerIconKeywords:Stärke> und [Arg2] Silberschlüssel-Energie."
  },
  RelicConfig_70712_Desc = {
    Text = "Nach der Silberschlüssel-Aktivierung erhalten Sie [Arg1] <PowerIconKeywords:Stärke> und [Arg2] Silberschlüssel-Energie."
  },
  RelicConfig_70712_Name = {
    Text = "<WhiteQuality:Unser Zuhause>"
  },
  RelicConfig_70712_StoryDesc = {
    Text = "Sie waren vorher zusammen und werden es auch immer sein. Sie sind eine liebevolle Familie"
  },
  RelicConfig_70713_BattleDesc = {
    Text = "Beim Verlust von Leben erhält man [Arg1] % der verlorenen Lebensmenge als Rückmeldung des Purpurnen Ofens."
  },
  RelicConfig_70713_Desc = {
    Text = "Beim Verlust von Leben erhält man [Arg1] % der verlorenen Lebensmenge als Rückmeldung des Purpurnen Ofens."
  },
  RelicConfig_70713_Name = {
    Text = "<WhiteQuality:Rostige Metallsäge>"
  },
  RelicConfig_70713_StoryDesc = {
    Text = "Der Anatom sieht in seinem Leben keine schönen Frauen, nur einen Sack voller Knochen, entzündete Nerven durch Krankheiten, Muskeln und Gewebe"
  },
  RelicConfig_70714_BattleDesc = {
    Text = "Nach Beginn des Kampfes erhältst du [Arg1] <ProficientInRealmsIconKeywords:Bereichsbeherrschung>. Der <RetaliateIconKeywords:Gegenangriff>-Schaden aller Erwachten und Relikts wird um [Arg2]% erhöht."
  },
  RelicConfig_70714_Desc = {
    Text = "Nach Beginn des Kampfes erhältst du [Arg1] <ProficientInRealmsIconKeywords:Bereichsbeherrschung>. Der <RetaliateIconKeywords:Gegenangriff>-Schaden aller Erwachten und Relikts wird um [Arg2]% erhöht."
  },
  RelicConfig_70714_Name = {
    Text = "<WhiteQuality:Wissen>"
  },
  RelicConfig_70714_StoryDesc = {
    Text = "Es hat unzählige freiwillige oder unfreiwillige Geheimnisse weitergegeben"
  },
  RelicConfig_70715_BattleDesc = {
    Text = "Nach der Silberschlüsselerweckung [Arg1] Karten ziehen und [Arg2] Punkte s-Energie erhalten."
  },
  RelicConfig_70715_Desc = {
    Text = "Nach der Silberschlüsselerweckung [Arg1] Karten ziehen und [Arg2] Punkte s-Energie erhalten."
  },
  RelicConfig_70715_Name = {
    Text = "<OrangeQuality:Neuer Geldbeutel+>"
  },
  RelicConfig_70715_StoryDesc = {
    Text = "Ein ledernes Portemonnaie, das das Wappen der Mythag Universität trägt.\nJetzt ist es völlig leer, es ist nichts darin"
  },
  RelicConfig_70717_BattleDesc = {
    Text = "Zu Beginn der Runde ziehst du [Arg1] Karten."
  },
  RelicConfig_70717_Desc = {
    Text = "Zu Beginn der Runde ziehst du [Arg1] Karten."
  },
  RelicConfig_70717_Name = {
    Text = "<OrangeQuality:Richtkompass+>"
  },
  RelicConfig_70717_StoryDesc = {
    Text = "Es zeigt nicht die Richtung, nur das Magnetfeld"
  },
  RelicConfig_70718_BattleDesc = {
    Text = "Nach dem Einsetzen von „Verherrlichung“ erleiden alle Gegner [Arg1] <FixedDamage:Reinen SCH> und lösen [Arg2]% <IntoxicationIconKeywords:Gift> aus."
  },
  RelicConfig_70718_Desc = {
    Text = "Nach dem Einsetzen von „Verherrlichung“ erleiden alle Gegner 1 Instanz <FixedDamage:Reinen SCH> in Höhe von [Arg2]% der Max LP des Teams und lösen [Arg2]% <IntoxicationIconKeywords:Gift> aus."
  },
  RelicConfig_70718_Name = {
    Text = "<WhiteQuality:Laserkiefer>"
  },
  RelicConfig_70718_StoryDesc = {
    Text = "Die Knochen, in der privaten Sammlung eines Sammlers ausgestellt.\nDer Sammler war besessen von dem schönen Leuchten, bewunderte es Tag und Nacht und verdorrte schließlich, wurde schließlich zu seinem Gleichgesinnten"
  },
  RelicConfig_70719_BattleDesc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwachten [Arg1] Wahnsinn."
  },
  RelicConfig_70719_Desc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwachten [Arg1] Wahnsinn."
  },
  RelicConfig_70719_Name = {
    Text = "<OrangeQuality:Prototyp-Batterie+>"
  },
  RelicConfig_70719_StoryDesc = {
    Text = "Tragbare Hoffnung"
  },
  RelicConfig_70720_BattleDesc = {
    Text = "Zu Beginn der Runde erhältst du [Arg1] temporäre <PowerIconKeywords:Kraft>, wenn dein Leben unter 25 % liegt."
  },
  RelicConfig_70720_Desc = {
    Text = "Zu Beginn der Runde erhältst du [Arg1] temporäre <PowerIconKeywords:Kraft>, wenn dein Leben unter 25 % liegt."
  },
  RelicConfig_70720_Name = {
    Text = "<WhiteQuality:Erhabene Gunst>"
  },
  RelicConfig_70720_StoryDesc = {
    Text = "Elegante, mysteriöse schwarze Kurzhaarkatze, die in einem fernen Wüstenland als göttliche Inkarnation verehrt wird. Doch der Name dieser Gottheit ist heute unbekannt.\nVerehrt, bewundert, vergessen – vielleicht das Schicksal der Götter"
  },
  RelicConfig_70721_BattleDesc = {
    Text = "Nach 4-maligem Auslösen von „Exaltieren“ in einer Runde erhältst du [Arg1] Arithmetica. Abklingzeit: 3 Runden."
  },
  RelicConfig_70721_Desc = {
    Text = "Nach 4-maligem Auslösen von „Exaltieren“ in einer Runde erhältst du [Arg1] Arithmetica. Abklingzeit: 3 Runden."
  },
  RelicConfig_70721_Name = {
    Text = "<WhiteQuality:Silberne Differenzmaschine>"
  },
  RelicConfig_70721_StoryDesc = {
    Text = "“Es hat die Geschichte verändert.“"
  },
  RelicConfig_70722_BattleDesc = {
    Text = "Nach der Silberschlüssel-Aktivierung erhalten Sie [Arg1] <PowerIconKeywords:Stärke> und [Arg2] Silberschlüssel-Energie."
  },
  RelicConfig_70722_Desc = {
    Text = "Nach der Silberschlüssel-Aktivierung erhalten Sie [Arg1] <PowerIconKeywords:Stärke> und [Arg2] Silberschlüssel-Energie."
  },
  RelicConfig_70722_Name = {
    Text = "<OrangeQuality:Unser Zuhause+>"
  },
  RelicConfig_70722_StoryDesc = {
    Text = "Sie waren vorher zusammen und werden es auch immer sein. Sie sind eine liebevolle Familie"
  },
  RelicConfig_70723_BattleDesc = {
    Text = "Wenn du zwei Mal hintereinander Karten mit höherem Arithmetica-Verbrauch als die vorherige spielst, erhältst du [Arg1] <RetaliateIconKeywords:Gegenangriff>, maximal 3-mal pro Runde auslösbar."
  },
  RelicConfig_70723_Desc = {
    Text = "Wenn du zwei Mal hintereinander Karten mit höherem Arithmetica-Verbrauch als die vorherige spielst, erhältst du [Arg1] <RetaliateIconKeywords:Gegenangriff>, maximal 3-mal pro Runde auslösbar."
  },
  RelicConfig_70723_Name = {
    Text = "<OrangeQuality:Arkana-Aufzeichnung+>"
  },
  RelicConfig_70723_StoryDesc = {
    Text = "Verlauf des Schicksals"
  },
  RelicConfig_70724_BattleDesc = {
    Text = "Kampfbeginn: Erhalte [Arg1] Punkt<PowerIconKeywords:Kraft>."
  },
  RelicConfig_70724_Desc = {
    Text = "Kampfbeginn: Erhalte [Arg1] Punkt<PowerIconKeywords:Kraft>."
  },
  RelicConfig_70724_Name = {
    Text = "<OrangeQuality:Rubinbrosche+>"
  },
  RelicConfig_70724_StoryDesc = {
    Text = "Rotes Blut sickert durch"
  },
  RelicConfig_70725_BattleDesc = {
    Text = "Nach Kampfbeginn werden allen Feinden [Arg1] Schichten <WeaknessIconKeywords:Schwäche> hinzugefügt; bei Bosskämpfen wird der Effekt verdoppelt. Der Basisschaden aller Erwecker erhöht sich um [Arg2]%."
  },
  RelicConfig_70725_Desc = {
    Text = "Nach Kampfbeginn werden allen Feinden [Arg1] Schichten <WeaknessIconKeywords:Schwäche> hinzugefügt; bei Bosskämpfen wird der Effekt verdoppelt. Der Basisschaden aller Erwecker erhöht sich um [Arg2]%."
  },
  RelicConfig_70725_Name = {
    Text = "<OrangeQuality:Bösewicht+>"
  },
  RelicConfig_70725_StoryDesc = {
    Text = "Geboren aus reinem Bösen, auch wenn es nicht sein Wille war"
  },
  RelicConfig_70726_BattleDesc = {
    Text = "Vernichtung: Erhalte [Arg1] Schild, 3 Runden Abkühlung."
  },
  RelicConfig_70726_Desc = {
    Text = "Vernichtung: Erhalte [Arg1] Schild, 3 Runden Abkühlung."
  },
  RelicConfig_70726_Name = {
    Text = "<WhiteQuality:Supersaiten-Taschenuhr>"
  },
  RelicConfig_70726_StoryDesc = {
    Text = "“Oh, die Taschenuhr ist stehen geblieben.“"
  },
  RelicConfig_70727_BattleDesc = {
    Text = "Heile am Rundenende [Heal:Arg1] LP."
  },
  RelicConfig_70727_Desc = {
    Text = "Heile am Rundenende [Heal:Arg1] LP."
  },
  RelicConfig_70727_Name = {
    Text = "<OrangeQuality:Blut der Gnade+>"
  },
  RelicConfig_70727_StoryDesc = {
    Text = "Es ist süß und vollmundig, mit einem Hauch von Rosenduft"
  },
  RelicConfig_70728_BattleDesc = {
    Text = "Verwende die Stille-See-Haltung, um allen Feinden [Arg1] temporäre <PowerIconKeywords:Kraft> abzunehmen, 3 Runden Abkühlung."
  },
  RelicConfig_70728_Desc = {
    Text = "Verwende die Stille-See-Haltung, um allen Feinden [Arg1] temporäre <PowerIconKeywords:Kraft> abzunehmen, 3 Runden Abkühlung."
  },
  RelicConfig_70728_Name = {
    Text = "<OrangeQuality:Unbekanntes Glied+>"
  },
  RelicConfig_70728_StoryDesc = {
    Text = "Vorsicht, es ist scharf"
  },
  RelicConfig_70730_BattleDesc = {
    Text = "Kampfbeginn: Erhalte [Arg1] Punkt<PowerIconKeywords:Kraft>."
  },
  RelicConfig_70730_Desc = {
    Text = "Kampfbeginn: Erhalte [Arg1] Punkt<PowerIconKeywords:Kraft>."
  },
  RelicConfig_70730_Name = {
    Text = "<WhiteQuality:Rubinbrosche>"
  },
  RelicConfig_70730_StoryDesc = {
    Text = "Rotes Blut sickert durch"
  },
  RelicConfig_70731_BattleDesc = {
    Text = "Wenn von einem Gegner angegriffen, füge ihm [Arg1] Festgesetzten Schaden zu. Dieser SCH profitiert von einem [Arg2]% <RetaliateIconKeywords:Gegenangriff>-Bonus. Jeder Gegner kann diesen Effekt bis zu 1 Mal pro Zug auslösen."
  },
  RelicConfig_70731_Desc = {
    Text = "Wenn von einem Gegner angegriffen, füge Festgesetzten Schaden in Höhe von [Arg3]% der Max LP des Teams zu. Dieser SCH profitiert von einem [Arg2]% <RetaliateIconKeywords:Gegenangriff>-Bonus. Jeder Gegner kann diesen Effekt bis zu 1 Mal pro Zug auslösen."
  },
  RelicConfig_70731_Name = {
    Text = "<OrangeQuality:Vergessenes Ritualmesser+>"
  },
  RelicConfig_70731_StoryDesc = {
    Text = "Ein gekrümmtes Opfermesser, häufig in Ritualen verwendet"
  },
  RelicConfig_70732_BattleDesc = {
    Text = "Nach Eintritt in den Hyperraum-Zug löst die erste gespielte nicht abgeleitete Befehlskarte [Arg1]-Mal zusätzlich aus."
  },
  RelicConfig_70732_Desc = {
    Text = "Nach Eintritt in den Hyperraum-Zug löst die erste gespielte nicht abgeleitete Befehlskarte [Arg1]-Mal zusätzlich aus."
  },
  RelicConfig_70732_Name = {
    Text = "<OrangeQuality:Schimmer-Sanduhr+>"
  },
  RelicConfig_70732_StoryDesc = {
    Text = "Eine messbare Zeit"
  },
  RelicConfig_70733_BattleDesc = {
    Text = "Die automatisch erhaltene Menge von <EmbryoFusionIconKeywords:Embryo-Fusion> erhöht sich um [Arg1]%."
  },
  RelicConfig_70733_Desc = {
    Text = "Die automatisch erhaltene Menge von <EmbryoFusionIconKeywords:Embryo-Fusion> erhöht sich um [Arg1]%."
  },
  RelicConfig_70733_Name = {
    Text = "<OrangeQuality:Seuchen-Diagnosebuch+>"
  },
  RelicConfig_70733_StoryDesc = {
    Text = "Pest—ein zufälliger Ausdruck der unbewussten Unruhe der Natur"
  },
  RelicConfig_70734_BattleDesc = {
    Text = "Nach der Silberschlüssel-Aktivierung wird der Basisschaden aller Erwecker um [Arg1]% erhöht und [Arg2] s-Energie gewährt."
  },
  RelicConfig_70734_Desc = {
    Text = "Nach der Silberschlüssel-Aktivierung wird der Basisschaden aller Erwecker um [Arg1]% erhöht und [Arg2] s-Energie gewährt."
  },
  RelicConfig_70734_Name = {
    Text = "<WhiteQuality:Astrolabium der Geheimnisse>"
  },
  RelicConfig_70734_StoryDesc = {
    Text = "Die Geheimnisse des Universums"
  },
  RelicConfig_70735_BattleDesc = {
    Text = "Wenn du zwei Mal hintereinander Karten mit niedrigerem Arithmetica-Verbrauch als die vorherige ausspielst, fügst du allen Gegnern [Arg1] Schichten <IntoxicationIconKeywords:Gift> hinzu. Maximal 3 Auslösungen pro Runde."
  },
  RelicConfig_70735_Desc = {
    Text = "Wenn du zwei Mal hintereinander Karten mit niedrigerem Arithmetica-Verbrauch als die vorherige ausspielst, fügst du allen Gegnern [Arg1] Schichten <IntoxicationIconKeywords:Gift> hinzu. Maximal 3 Auslösungen pro Runde."
  },
  RelicConfig_70735_Name = {
    Text = "<OrangeQuality:Arkanum-Relikt+>"
  },
  RelicConfig_70735_StoryDesc = {
    Text = "Ende des Schicksals"
  },
  RelicConfig_70736_BattleDesc = {
    Text = "Verwende die Stille-See-Haltung, um allen Feinden [Arg1] temporäre <PowerIconKeywords:Kraft> abzunehmen, 3 Runden Abkühlung."
  },
  RelicConfig_70736_Desc = {
    Text = "Verwende die Stille-See-Haltung, um allen Feinden [Arg1] temporäre <PowerIconKeywords:Kraft> abzunehmen, 3 Runden Abkühlung."
  },
  RelicConfig_70736_Name = {
    Text = "<WhiteQuality:Unbekanntes Glied>"
  },
  RelicConfig_70736_StoryDesc = {
    Text = "Vorsicht, es ist scharf"
  },
  RelicConfig_70737_BattleDesc = {
    Text = "Nach dem Spielen einer Karte: Wenn die Anzahl der Handkarten ≤ [Arg1], ziehe [Arg2] Karten. Maximal [Arg3] Mal pro Runde auslösbar."
  },
  RelicConfig_70737_Desc = {
    Text = "Nach dem Spielen einer Karte: Wenn die Anzahl der Handkarten ≤ [Arg1], ziehe [Arg2] Karten. Maximal [Arg3] Mal pro Runde auslösbar."
  },
  RelicConfig_70737_Name = {
    Text = "<WhiteQuality:Zauberhandschuhe>"
  },
  RelicConfig_70737_StoryDesc = {
    Text = "“Keine Angst, das ist nur Magie.“"
  },
  RelicConfig_70738_BattleDesc = {
    Text = "Heile am Rundenende [Heal:Arg1] LP."
  },
  RelicConfig_70738_Desc = {
    Text = "Heile am Rundenende [Heal:Arg1] LP."
  },
  RelicConfig_70738_Name = {
    Text = "<WhiteQuality:Blut der Gnade>"
  },
  RelicConfig_70738_StoryDesc = {
    Text = "Es ist süß und vollmundig, mit einem Hauch von Rosenduft"
  },
  RelicConfig_70739_BattleDesc = {
    Text = "Nach der Silberschlüsselerweckung erhältst du [Arg1] Schild und [Arg2] s-Energie."
  },
  RelicConfig_70739_Desc = {
    Text = "Nach der Silberschlüsselerweckung erhältst du [Arg1] Schild und [Arg2] s-Energie."
  },
  RelicConfig_70739_Name = {
    Text = "<WhiteQuality:Schmetterlingspräparat>"
  },
  RelicConfig_70739_StoryDesc = {
    Text = "Bis heute wird er von jemandem tief geliebt"
  },
  RelicConfig_70740_BattleDesc = {
    Text = "Nach der Silberschlüssel-Aktivierung wird der Basisschaden aller Erwecker um [Arg1]% erhöht und [Arg2] s-Energie gewährt."
  },
  RelicConfig_70740_Desc = {
    Text = "Nach der Silberschlüssel-Aktivierung wird der Basisschaden aller Erwecker um [Arg1]% erhöht und [Arg2] s-Energie gewährt."
  },
  RelicConfig_70740_Name = {
    Text = "<OrangeQuality:Okkultes Astrolabium+>"
  },
  RelicConfig_70740_StoryDesc = {
    Text = "Die Geheimnisse des Universums"
  },
  RelicConfig_70741_BattleDesc = {
    Text = "Maximale Arithmetica erhöht sich um [Arg1]."
  },
  RelicConfig_70741_Desc = {
    Text = "Maximale Arithmetica erhöht sich um [Arg1]."
  },
  RelicConfig_70741_Name = {
    Text = "<OrangeQuality:Aktiv-Spritze+>"
  },
  RelicConfig_70741_StoryDesc = {
    Text = "Zuckungen sind auch eine Form von Aktivität"
  },
  RelicConfig_70742_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich die Tentakelobergrenze um [Arg1], du erhältst [Arg2] Tentakel."
  },
  RelicConfig_70742_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich die Tentakelobergrenze um [Arg1], du erhältst [Arg2] Tentakel."
  },
  RelicConfig_70742_Name = {
    Text = "<WhiteQuality:Lied der See>"
  },
  RelicConfig_70742_StoryDesc = {
    Text = "Es wird gesagt, dass ungenießbare Tiere wie das Gewebe-Nudelkrebse etwa 80% der Nährstoffe aus dem Ozean aufnehmen"
  },
  RelicConfig_70743_BattleDesc = {
    Text = "Beim ersten <DevouredIconKeywords:Verschlingen> pro Runde erhalten andere Erwachte [Arg1] Wahnsinn."
  },
  RelicConfig_70743_Desc = {
    Text = "Beim ersten <DevouredIconKeywords:Verschlingen> pro Runde erhalten andere Erwachte [Arg1] Wahnsinn."
  },
  RelicConfig_70743_Name = {
    Text = "<WhiteQuality:Goldener Traum>"
  },
  RelicConfig_70743_StoryDesc = {
    Text = "Der Tag der Verwandlung ist dein Todestag"
  },
  RelicConfig_70744_BattleDesc = {
    Text = "Nachdem du eine nicht abgeleitete Befehlskarte gespielt hast, mische [Arg1] vorübergehende Kopien dieser Karte mit um 2 reduziertem Arithmetica-Verbrauch in den Ziehstapel. Abklingzeit: 3 Runden."
  },
  RelicConfig_70744_Desc = {
    Text = "Nachdem du eine nicht abgeleitete Befehlskarte gespielt hast, mische [Arg1] vorübergehende Kopien dieser Karte mit um 2 reduziertem Arithmetica-Verbrauch in den Ziehstapel. Abklingzeit: 3 Runden."
  },
  RelicConfig_70744_Name = {
    Text = "<OrangeQuality:Stummer Phonograph+>"
  },
  RelicConfig_70744_StoryDesc = {
    Text = "Seine Stimme verschwand im Wind"
  },
  RelicConfig_70745_BattleDesc = {
    Text = "Kampfbeginn: Erhalte [Arg1] <RetaliateIconKeywords:Theke>; im Bosskampf wird der Effekt verdoppelt."
  },
  RelicConfig_70745_Desc = {
    Text = "Kampfbeginn: Erhalte [Arg1] <RetaliateIconKeywords:Theke>; im Bosskampf wird der Effekt verdoppelt."
  },
  RelicConfig_70745_Name = {
    Text = "<OrangeQuality:Stechendes Brennnesselwams+>"
  },
  RelicConfig_70745_StoryDesc = {
    Text = "Unidentifizierbare Flüssigkeit"
  },
  RelicConfig_70746_BattleDesc = {
    Text = "Zu Beginn der Runde erhältst du [Arg1] temporäre <PowerIconKeywords:Kraft>, wenn dein Leben unter 25 % liegt."
  },
  RelicConfig_70746_Desc = {
    Text = "Zu Beginn der Runde erhältst du [Arg1] temporäre <PowerIconKeywords:Kraft>, wenn dein Leben unter 25 % liegt."
  },
  RelicConfig_70746_Name = {
    Text = "<OrangeQuality:Oberste Ehre+>"
  },
  RelicConfig_70746_StoryDesc = {
    Text = "Elegante, mysteriöse schwarze Kurzhaarkatze, die in einem fernen Wüstenland als göttliche Inkarnation verehrt wird. Doch der Name dieser Gottheit ist heute unbekannt.\nVerehrt, bewundert, vergessen – vielleicht das Schicksal der Götter"
  },
  RelicConfig_70747_BattleDesc = {
    Text = "Nach dem Spielen einer Karte: Wenn die Anzahl der Handkarten ≤ [Arg1], ziehe [Arg2] Karten. Maximal [Arg3] Mal pro Runde auslösbar."
  },
  RelicConfig_70747_Desc = {
    Text = "Nach dem Spielen einer Karte: Wenn die Anzahl der Handkarten ≤ [Arg1], ziehe [Arg2] Karten. Maximal [Arg3] Mal pro Runde auslösbar."
  },
  RelicConfig_70747_Name = {
    Text = "<OrangeQuality:Zauberhandschuhe+>"
  },
  RelicConfig_70747_StoryDesc = {
    Text = "“Keine Angst, das ist nur Magie.“"
  },
  RelicConfig_70748_BattleDesc = {
    Text = "Nach der Silberschlüsselerweckung erhältst du [Arg1] Schild und [Arg2] s-Energie."
  },
  RelicConfig_70748_Desc = {
    Text = "Nach der Silberschlüsselerweckung erhältst du [Arg1] Schild und [Arg2] s-Energie."
  },
  RelicConfig_70748_Name = {
    Text = "<OrangeQuality:Schmetterlingspräparat+>"
  },
  RelicConfig_70748_StoryDesc = {
    Text = "Bis heute wird er von jemandem tief geliebt"
  },
  RelicConfig_70749_BattleDesc = {
    Text = "Jedes Mal, wenn eine Karte in den Hyperraum gelangt, und falls diese Karte einen anderen Besitzer als die anderen Karten im Hyperraum hat, füge [Arg1] <DerivativeCardKeywords_4:„Inspiration“> deiner Hand hinzu."
  },
  RelicConfig_70749_Desc = {
    Text = "Jedes Mal, wenn eine Karte in den Hyperraum gelangt, und falls diese Karte einen anderen Besitzer als die anderen Karten im Hyperraum hat, füge [Arg1] <DerivativeCardKeywords_4:„Inspiration“> deiner Hand hinzu."
  },
  RelicConfig_70749_Name = {
    Text = "<OrangeQuality:Alfonsos Artefakt+>"
  },
  RelicConfig_70749_StoryDesc = {
    Text = "Im Gegensatz zum unbeständigen Schicksal, folgen die Sterne ihren eigenen Gesetzen"
  },
  RelicConfig_70750_BattleDesc = {
    Text = "Wenn du zwei Mal hintereinander Karten mit höherem Arithmetica-Verbrauch als die vorherige spielst, erhältst du [Arg1] <RetaliateIconKeywords:Gegenangriff>, maximal 3-mal pro Runde auslösbar."
  },
  RelicConfig_70750_Desc = {
    Text = "Wenn du zwei Mal hintereinander Karten mit höherem Arithmetica-Verbrauch als die vorherige spielst, erhältst du [Arg1] <RetaliateIconKeywords:Gegenangriff>, maximal 3-mal pro Runde auslösbar."
  },
  RelicConfig_70750_Name = {
    Text = "<WhiteQuality:Arkana-Aufzeichnung>"
  },
  RelicConfig_70750_StoryDesc = {
    Text = "Verlauf des Schicksals"
  },
  RelicConfig_70751_BattleDesc = {
    Text = "Nach der Silberschlüsselerweckung erhältst du [Arg1] Arithmetica und [Arg2] s-Energie."
  },
  RelicConfig_70751_Desc = {
    Text = "Nach der Silberschlüsselerweckung erhältst du [Arg1] Arithmetica und [Arg2] s-Energie."
  },
  RelicConfig_70751_Name = {
    Text = "<WhiteQuality:Mythag Emblem>"
  },
  RelicConfig_70751_StoryDesc = {
    Text = "Die Abzeichen, die an die Ermittler der Mythag Universität verteilt werden, symbolisieren nicht nur die Identität des Trägers, sondern dienen auch als Kommunikationsmittel"
  },
  RelicConfig_70752_BattleDesc = {
    Text = "Nach der Silberschlüssel-Erweckung [Arg1] <RetaliateIconKeywords:Gegenangriff> erhalten und [Arg2] Silberschlüssel-Energie sammeln."
  },
  RelicConfig_70752_Desc = {
    Text = "Nach der Silberschlüssel-Erweckung [Arg1] <RetaliateIconKeywords:Gegenangriff> erhalten und [Arg2] Silberschlüssel-Energie sammeln."
  },
  RelicConfig_70752_Name = {
    Text = "<WhiteQuality:Weisheitsfragment>"
  },
  RelicConfig_70752_StoryDesc = {
    Text = "“Menschen sind so dumm, sie glauben blind an das Alte.“"
  },
  RelicConfig_70753_BattleDesc = {
    Text = "Nach Beginn des Kampfes erhalten alle Feinde [Arg1] Schichten <VulnerabilityIconKeywords:Verwundbarkeit>, im Bosskampf wird der Effekt verdoppelt. Alle Erwecker erhöhen den Basisschaden um [Arg2]%."
  },
  RelicConfig_70753_Desc = {
    Text = "Nach Beginn des Kampfes erhalten alle Feinde [Arg1] Schichten <VulnerabilityIconKeywords:Verwundbarkeit>, im Bosskampf wird der Effekt verdoppelt. Alle Erwecker erhöhen den Basisschaden um [Arg2]%."
  },
  RelicConfig_70753_Name = {
    Text = "<OrangeQuality:Frühlingsopfer+>"
  },
  RelicConfig_70753_StoryDesc = {
    Text = "Im Lachen der Nacht gleitet die Silhouette des Kanus mühelos über den See"
  },
  RelicConfig_70754_BattleDesc = {
    Text = "Nachdem du in einer Runde zum ersten Mal direkt “Embryo“ verwendet hast, verursacht der aktive Schaden in dieser Runde [Arg1] % Schaden in Form von <BleedingIconKeywords:Bluten>."
  },
  RelicConfig_70754_Desc = {
    Text = "Nachdem du in einer Runde zum ersten Mal direkt “Embryo“ verwendet hast, verursacht der aktive Schaden in dieser Runde [Arg1] % Schaden in Form von <BleedingIconKeywords:Bluten>."
  },
  RelicConfig_70754_Name = {
    Text = "<WhiteQuality:Blutiger Kiesel>"
  },
  RelicConfig_70754_StoryDesc = {
    Text = "Eins, zwei, drei, vier, fünf"
  },
  RelicConfig_70755_BattleDesc = {
    Text = "Jedes Mal, wenn du Schaden verursachst, erhältst du [Arg1] temporäre <PowerIconKeywords:Stärke>, maximal 15 Mal pro Runde auslösbar."
  },
  RelicConfig_70755_Desc = {
    Text = "Jedes Mal, wenn du Schaden verursachst, erhältst du [Arg1] temporäre <PowerIconKeywords:Stärke>, maximal 15 Mal pro Runde auslösbar."
  },
  RelicConfig_70755_Name = {
    Text = "<OrangeQuality:Bandachat+>"
  },
  RelicConfig_70755_StoryDesc = {
    Text = "Es sollte nur eine normale Achatmusterung sein. Wahrscheinlich"
  },
  RelicConfig_70756_BattleDesc = {
    Text = "Nach der Silberschlüsselerweckung erhältst du [Arg1] Arithmetica und [Arg2] s-Energie."
  },
  RelicConfig_70756_Desc = {
    Text = "Nach der Silberschlüsselerweckung erhältst du [Arg1] Arithmetica und [Arg2] s-Energie."
  },
  RelicConfig_70756_Name = {
    Text = "<OrangeQuality:Medaillon der Mysag+>"
  },
  RelicConfig_70756_StoryDesc = {
    Text = "Die Abzeichen, die an die Ermittler der Mythag Universität verteilt werden, symbolisieren nicht nur die Identität des Trägers, sondern dienen auch als Kommunikationsmittel"
  },
  RelicConfig_70757_BattleDesc = {
    Text = "Verwende die Haltung „Wogen“, um sofort alle Tentakel zu aktivieren und den Feind [Arg1] Mal anzugreifen. (3-Runden-Abkühlung)"
  },
  RelicConfig_70757_Desc = {
    Text = "Verwende die Haltung „Wogen“, um sofort alle Tentakel zu aktivieren und den Feind [Arg1] Mal anzugreifen. (3-Runden-Abkühlung)"
  },
  RelicConfig_70757_Name = {
    Text = "<WhiteQuality:Freuden des Strudels>"
  },
  RelicConfig_70757_StoryDesc = {
    Text = "Herr des ewigen Schlafs, erwarte dich im Traum"
  },
  RelicConfig_70758_BattleDesc = {
    Text = "Wenn du zwei Mal hintereinander Karten mit niedrigerem Arithmetica-Verbrauch als die vorherige ausspielst, fügst du allen Gegnern [Arg1] Schichten <IntoxicationIconKeywords:Gift> hinzu. Maximal 3 Auslösungen pro Runde."
  },
  RelicConfig_70758_Desc = {
    Text = "Wenn du zwei Mal hintereinander Karten mit niedrigerem Arithmetica-Verbrauch als die vorherige ausspielst, fügst du allen Gegnern [Arg1] Schichten <IntoxicationIconKeywords:Gift> hinzu. Maximal 3 Auslösungen pro Runde."
  },
  RelicConfig_70758_Name = {
    Text = "<WhiteQuality:Arcana-Relikt>"
  },
  RelicConfig_70758_StoryDesc = {
    Text = "Ende des Schicksals"
  },
  RelicConfig_70759_BattleDesc = {
    Text = "Nach Kampfbeginn werden allen Feinden [Arg1] Schichten <WeaknessIconKeywords:Schwäche> hinzugefügt; bei Bosskämpfen wird der Effekt verdoppelt. Der Basisschaden aller Erwecker erhöht sich um [Arg2]%."
  },
  RelicConfig_70759_Desc = {
    Text = "Nach Kampfbeginn werden allen Feinden [Arg1] Schichten <WeaknessIconKeywords:Schwäche> hinzugefügt; bei Bosskämpfen wird der Effekt verdoppelt. Der Basisschaden aller Erwecker erhöht sich um [Arg2]%."
  },
  RelicConfig_70759_Name = {
    Text = "<WhiteQuality:Bösewicht>"
  },
  RelicConfig_70759_StoryDesc = {
    Text = "Geboren aus reinem Bösen, auch wenn es nicht sein Wille war"
  },
  RelicConfig_70760_BattleDesc = {
    Text = "Zu Beginn des Kampfes fügen Sie allen Feinden [Arg1] <IntoxicationIconKeywords:Vergiftung> hinzu. Im Bosskampf wird der Effekt verdoppelt."
  },
  RelicConfig_70760_Desc = {
    Text = "Zu Beginn des Kampfes fügen Sie allen Feinden [Arg1] <IntoxicationIconKeywords:Vergiftung> hinzu. Im Bosskampf wird der Effekt verdoppelt."
  },
  RelicConfig_70760_Name = {
    Text = "<WhiteQuality:Neurotoxin>"
  },
  RelicConfig_70760_StoryDesc = {
    Text = "Extrahieren, verfeinern"
  },
  RelicConfig_70761_BattleDesc = {
    Text = "Nach Beginn des Kampfes erhalten alle Feinde [Arg1] Schichten <VulnerabilityIconKeywords:Verwundbarkeit>, im Bosskampf wird der Effekt verdoppelt. Alle Erwecker erhöhen den Basisschaden um [Arg2]%."
  },
  RelicConfig_70761_Desc = {
    Text = "Nach Beginn des Kampfes erhalten alle Feinde [Arg1] Schichten <VulnerabilityIconKeywords:Verwundbarkeit>, im Bosskampf wird der Effekt verdoppelt. Alle Erwecker erhöhen den Basisschaden um [Arg2]%."
  },
  RelicConfig_70761_Name = {
    Text = "<WhiteQuality:Frühlingsopfer>"
  },
  RelicConfig_70761_StoryDesc = {
    Text = "Im Lachen der Nacht gleitet die Silhouette des Kanus mühelos über den See"
  },
  RelicConfig_70762_BattleDesc = {
    Text = "Nach 4-maligem Auslösen von „Exaltieren“ in einer Runde erhältst du [Arg1] Arithmetica. Abklingzeit: 3 Runden."
  },
  RelicConfig_70762_Desc = {
    Text = "Nach 4-maligem Auslösen von „Exaltieren“ in einer Runde erhältst du [Arg1] Arithmetica. Abklingzeit: 3 Runden."
  },
  RelicConfig_70762_Name = {
    Text = "<OrangeQuality:Silberner Differenzmotor+>"
  },
  RelicConfig_70762_StoryDesc = {
    Text = "“Es hat die Geschichte verändert.“"
  },
  RelicConfig_70763_BattleDesc = {
    Text = "Nach der Freisetzung von „Exaltieren“ erhältst du [Arg1] temporäre <PowerIconKeywords:Macht>."
  },
  RelicConfig_70763_Desc = {
    Text = "Nach der Freisetzung von „Exaltieren“ erhältst du [Arg1] temporäre <PowerIconKeywords:Macht>."
  },
  RelicConfig_70763_Name = {
    Text = "<WhiteQuality:Schweres Schloss>"
  },
  RelicConfig_70763_StoryDesc = {
    Text = "Eine dicke und solide Sperre, ohne Schlüssel schwer zu öffnen.\nNatürlich ist das für einen Meisterdieb kein Problem"
  },
  RelicConfig_70764_BattleDesc = {
    Text = "Wenn von einem Gegner angegriffen, füge ihm [Arg1] Festgesetzten Schaden zu. Dieser SCH profitiert von einem [Arg2]% <RetaliateIconKeywords:Gegenangriff>-Bonus. Jeder Gegner kann diesen Effekt bis zu 1 Mal pro Zug auslösen."
  },
  RelicConfig_70764_Desc = {
    Text = "Wenn von einem Gegner angegriffen, füge Festgesetzten Schaden in Höhe von [Arg3]% der Max LP des Teams zu. Dieser SCH profitiert von einem [Arg2]% <RetaliateIconKeywords:Gegenangriff>-Bonus. Jeder Gegner kann diesen Effekt bis zu 1 Mal pro Zug auslösen."
  },
  RelicConfig_70764_Name = {
    Text = "<WhiteQuality:Verlorenes Opfermesser>"
  },
  RelicConfig_70764_StoryDesc = {
    Text = "Ein gekrümmtes Opfermesser, häufig in Ritualen verwendet"
  },
  RelicConfig_70765_BattleDesc = {
    Text = "Jedes Mal, wenn du Schaden verursachst, erhältst du [Arg1] temporäre <PowerIconKeywords:Stärke>, maximal 15 Mal pro Runde auslösbar."
  },
  RelicConfig_70765_Desc = {
    Text = "Jedes Mal, wenn du Schaden verursachst, erhältst du [Arg1] temporäre <PowerIconKeywords:Stärke>, maximal 15 Mal pro Runde auslösbar."
  },
  RelicConfig_70765_Name = {
    Text = "<WhiteQuality:Bandachat>"
  },
  RelicConfig_70765_StoryDesc = {
    Text = "Es sollte nur eine normale Achatmusterung sein. Wahrscheinlich"
  },
  RelicConfig_70766_BattleDesc = {
    Text = "Zu Beginn der Runde erhältst du [Arg1] Schild, wenn das Leben unter 25 % liegt."
  },
  RelicConfig_70766_Desc = {
    Text = "Zu Beginn der Runde erhältst du [Arg1] Schild, wenn das Leben unter 25 % liegt."
  },
  RelicConfig_70766_Name = {
    Text = "<WhiteQuality:Schutzhand>"
  },
  RelicConfig_70766_StoryDesc = {
    Text = "Segnende Hand, feste Faust"
  },
  RelicConfig_70767_BattleDesc = {
    Text = "Vernichtung lässt das Erwachte mit dem niedrigsten Wahnsinn [Arg1] Wahnsinn erhalten, 3 Runden Abkühlung."
  },
  RelicConfig_70767_Desc = {
    Text = "Vernichtung lässt das Erwachte mit dem niedrigsten Wahnsinn [Arg1] Wahnsinn erhalten, 3 Runden Abkühlung."
  },
  RelicConfig_70767_Name = {
    Text = "<WhiteQuality:Zeitwurm>"
  },
  RelicConfig_70767_StoryDesc = {
    Text = "Eine Taschenuhr, die gleichzeitig im Uhrengeschäft und im Insektenmuseum existiert.\nNach dem Beginn des Holozäns wurde sie in die Universitätskollektion aufgenommen"
  },
  RelicConfig_70768_BattleDesc = {
    Text = "Nach Beginn des Kampfes erhältst du [Arg1] <ProficientInRealmsIconKeywords:Bereichsbeherrschung>. Der <RetaliateIconKeywords:Gegenangriff>-Schaden aller Erwachten und Relikts wird um [Arg2]% erhöht."
  },
  RelicConfig_70768_Desc = {
    Text = "Nach Beginn des Kampfes erhältst du [Arg1] <ProficientInRealmsIconKeywords:Bereichsbeherrschung>. Der <RetaliateIconKeywords:Gegenangriff>-Schaden aller Erwachten und Relikts wird um [Arg2]% erhöht."
  },
  RelicConfig_70768_Name = {
    Text = "<OrangeQuality:Wissen+>"
  },
  RelicConfig_70768_StoryDesc = {
    Text = "Es hat unzählige freiwillige oder unfreiwillige Geheimnisse weitergegeben"
  },
  RelicConfig_70769_BattleDesc = {
    Text = "Nachdem du in einer Runde zum ersten Mal direkt “Embryo“ verwendet hast, verursacht der aktive Schaden in dieser Runde [Arg1] % Schaden in Form von <BleedingIconKeywords:Bluten>."
  },
  RelicConfig_70769_Desc = {
    Text = "Nachdem du in einer Runde zum ersten Mal direkt “Embryo“ verwendet hast, verursacht der aktive Schaden in dieser Runde [Arg1] % Schaden in Form von <BleedingIconKeywords:Bluten>."
  },
  RelicConfig_70769_Name = {
    Text = "<OrangeQuality:Blutiger Kiesel+>"
  },
  RelicConfig_70769_StoryDesc = {
    Text = "Eins, zwei, drei, vier, fünf"
  },
  RelicConfig_70770_BattleDesc = {
    Text = "Zu Beginn der Runde ziehst du [Arg1] Karten."
  },
  RelicConfig_70770_Desc = {
    Text = "Zu Beginn der Runde ziehst du [Arg1] Karten."
  },
  RelicConfig_70770_Name = {
    Text = "<WhiteQuality:Kompass>"
  },
  RelicConfig_70770_StoryDesc = {
    Text = "Es zeigt nicht die Richtung, nur das Magnetfeld"
  },
  RelicConfig_70771_BattleDesc = {
    Text = "„Schlag“ verursacht zusätzlich Schaden in Höhe von 2×[Arg1] % des ANGs des Erweckungskörpers, maximal 3-mal pro Runde auslösbar."
  },
  RelicConfig_70771_Desc = {
    Text = "„Schlag“ verursacht zusätzlich Schaden in Höhe von 2×[Arg1] % des ANGs des Erweckungskörpers, maximal 3-mal pro Runde auslösbar."
  },
  RelicConfig_70771_Name = {
    Text = "<OrangeQuality:Rostige Klinge+>"
  },
  RelicConfig_70771_StoryDesc = {
    Text = "Nicht geeignet zum Schneiden von Lebewesen"
  },
  RelicConfig_70772_BattleDesc = {
    Text = "Nach der Silberschlüsselerweckung [Arg1] Karten ziehen und [Arg2] Punkte s-Energie erhalten."
  },
  RelicConfig_70772_Desc = {
    Text = "Nach der Silberschlüsselerweckung [Arg1] Karten ziehen und [Arg2] Punkte s-Energie erhalten."
  },
  RelicConfig_70772_Name = {
    Text = "<WhiteQuality:Neues Portemonnaie>"
  },
  RelicConfig_70772_StoryDesc = {
    Text = "Ein ledernes Portemonnaie, das das Wappen der Mythag Universität trägt.\nJetzt ist es völlig leer, es ist nichts darin"
  },
  RelicConfig_70774_BattleDesc = {
    Text = "In jeder Runde erhöht sich der verursachte Schaden bei den ersten fünf Schadensangriffen um [Arg1]%."
  },
  RelicConfig_70774_Desc = {
    Text = "In jeder Runde erhöht sich der verursachte Schaden bei den ersten fünf Schadensangriffen um [Arg1]%."
  },
  RelicConfig_70774_Name = {
    Text = "<WhiteQuality:Sehhilfe>"
  },
  RelicConfig_70774_StoryDesc = {
    Text = "Jemand fand durch sie die Wahrheit heraus"
  },
  RelicConfig_70776_BattleDesc = {
    Text = "Kampfbeginn: Erhalte [Arg1] <RetaliateIconKeywords:Theke>; im Bosskampf wird der Effekt verdoppelt."
  },
  RelicConfig_70776_Desc = {
    Text = "Kampfbeginn: Erhalte [Arg1] <RetaliateIconKeywords:Theke>; im Bosskampf wird der Effekt verdoppelt."
  },
  RelicConfig_70776_Name = {
    Text = "<WhiteQuality:Brennnesselweste>"
  },
  RelicConfig_70776_StoryDesc = {
    Text = "Unidentifizierbare Flüssigkeit"
  },
  RelicConfig_70777_BattleDesc = {
    Text = "Nachdem du nacheinander 4 Befehlskarten unterschiedlicher Erwachten gespielt hast, erhalten alle Erwachten [Arg1] Wahnsinn. Abklingzeit: 3 Runden."
  },
  RelicConfig_70777_Desc = {
    Text = "Nachdem du nacheinander 4 Befehlskarten unterschiedlicher Erwachten gespielt hast, erhalten alle Erwachten [Arg1] Wahnsinn. Abklingzeit: 3 Runden."
  },
  RelicConfig_70777_Name = {
    Text = "<WhiteQuality:Schleier des namenlosen Gottes>"
  },
  RelicConfig_70777_StoryDesc = {
    Text = "Gott nicht direkt ansehen"
  },
  RelicConfig_70778_BattleDesc = {
    Text = "Zu Beginn des Kampfes fügen Sie allen Feinden [Arg1] <IntoxicationIconKeywords:Vergiftung> hinzu. Im Bosskampf wird der Effekt verdoppelt."
  },
  RelicConfig_70778_Desc = {
    Text = "Zu Beginn des Kampfes fügen Sie allen Feinden [Arg1] <IntoxicationIconKeywords:Vergiftung> hinzu. Im Bosskampf wird der Effekt verdoppelt."
  },
  RelicConfig_70778_Name = {
    Text = "<OrangeQuality:Neurotoxin+>"
  },
  RelicConfig_70778_StoryDesc = {
    Text = "Extrahieren, verfeinern"
  },
  RelicConfig_70779_BattleDesc = {
    Text = "Nach der Silberschlüssel-Erweckung allen Feinden [Arg1] <IntoxicationIconKeywords:Vergiftung> auferlegen und [Arg2] Silberschlüssel-Energie erhalten."
  },
  RelicConfig_70779_Desc = {
    Text = "Nach der Silberschlüssel-Erweckung allen Feinden [Arg1] <IntoxicationIconKeywords:Vergiftung> auferlegen und [Arg2] Silberschlüssel-Energie erhalten."
  },
  RelicConfig_70779_Name = {
    Text = "<WhiteQuality:Verdächtige Salbe>"
  },
  RelicConfig_70779_StoryDesc = {
    Text = "Eine selbstgemachte Wundsalbe, bitte nicht ohne ärztlichen Rat verwenden"
  },
  RelicConfig_70780_BattleDesc = {
    Text = "“Schlag“ fügt Gift hinzu, das [Arg1]% des Schadens entspricht, maximal [Arg2] Punkte pro Runde."
  },
  RelicConfig_70780_Desc = {
    Text = "“Schlag“ fügt Gift hinzu, das [Arg1]% des Schadens entspricht, maximal [Arg2] Punkte pro Runde."
  },
  RelicConfig_70780_Name = {
    Text = "<WhiteQuality:Fremde Zunge>"
  },
  RelicConfig_70780_StoryDesc = {
    Text = "Er ist kein Dämon, aber er flüstert von jenseits der Welt"
  },
  RelicConfig_70781_BattleDesc = {
    Text = "Zu Beginn der Runde erhältst du [Arg1] Schild, wenn das Leben unter 25 % liegt."
  },
  RelicConfig_70781_Desc = {
    Text = "Zu Beginn der Runde erhältst du [Arg1] Schild, wenn das Leben unter 25 % liegt."
  },
  RelicConfig_70781_Name = {
    Text = "<OrangeQuality:Schutzhand+>"
  },
  RelicConfig_70781_StoryDesc = {
    Text = "Segnende Hand, feste Faust"
  },
  RelicConfig_70782_BattleDesc = {
    Text = "Beim Verlust von Leben erhält man [Arg1] % der verlorenen Lebensmenge als Rückmeldung des Purpurnen Ofens."
  },
  RelicConfig_70782_Desc = {
    Text = "Beim Verlust von Leben erhält man [Arg1] % der verlorenen Lebensmenge als Rückmeldung des Purpurnen Ofens."
  },
  RelicConfig_70782_Name = {
    Text = "<OrangeQuality:Rostige Metallsäge+>"
  },
  RelicConfig_70782_StoryDesc = {
    Text = "Der Anatom sieht in seinem Leben keine schönen Frauen, nur einen Sack voller Knochen, entzündete Nerven durch Krankheiten, Muskeln und Gewebe"
  },
  RelicConfig_70783_BattleDesc = {
    Text = "In jeder Runde erhöht sich der verursachte Schaden bei den ersten fünf Schadensangriffen um [Arg1]%."
  },
  RelicConfig_70783_Desc = {
    Text = "In jeder Runde erhöht sich der verursachte Schaden bei den ersten fünf Schadensangriffen um [Arg1]%."
  },
  RelicConfig_70783_Name = {
    Text = "<OrangeQuality:Sehkorrektur+>"
  },
  RelicConfig_70783_StoryDesc = {
    Text = "Jemand fand durch sie die Wahrheit heraus"
  },
  RelicConfig_70784_BattleDesc = {
    Text = "Jedes Mal, wenn eine Karte in den Hyperraum gelangt, und falls diese Karte einen anderen Besitzer als die anderen Karten im Hyperraum hat, füge [Arg1] <DerivativeCardKeywords_4:„Inspiration“> deiner Hand hinzu."
  },
  RelicConfig_70784_Desc = {
    Text = "Jedes Mal, wenn eine Karte in den Hyperraum gelangt, und falls diese Karte einen anderen Besitzer als die anderen Karten im Hyperraum hat, füge [Arg1] <DerivativeCardKeywords_4:„Inspiration“> deiner Hand hinzu."
  },
  RelicConfig_70784_Name = {
    Text = "<WhiteQuality:Alfonsos Artefakt>"
  },
  RelicConfig_70784_StoryDesc = {
    Text = "Im Gegensatz zum unbeständigen Schicksal, folgen die Sterne ihren eigenen Gesetzen"
  },
  RelicConfig_70785_BattleDesc = {
    Text = "Nachdem du nacheinander 4 Befehlskarten unterschiedlicher Erwachten gespielt hast, erhalten alle Erwachten [Arg1] Wahnsinn. Abklingzeit: 3 Runden."
  },
  RelicConfig_70785_Desc = {
    Text = "Nachdem du nacheinander 4 Befehlskarten unterschiedlicher Erwachten gespielt hast, erhalten alle Erwachten [Arg1] Wahnsinn. Abklingzeit: 3 Runden."
  },
  RelicConfig_70785_Name = {
    Text = "<OrangeQuality:Schleier des namenlosen Gottes+>"
  },
  RelicConfig_70785_StoryDesc = {
    Text = "Gott nicht direkt ansehen"
  },
  RelicConfig_70786_BattleDesc = {
    Text = "Am Ende der Runde erhält man, wenn man sich in der Flutwelle-Haltung befindet, [Arg1] <TentacleInjurieIconKeywords:Tentakelschaden>. Abkühlung: 3 Runden."
  },
  RelicConfig_70786_Desc = {
    Text = "Am Ende der Runde erhält man, wenn man sich in der Flutwelle-Haltung befindet, [Arg1] <TentacleInjurieIconKeywords:Tentakelschaden>. Abkühlung: 3 Runden."
  },
  RelicConfig_70786_Name = {
    Text = "<WhiteQuality:Bandwurm>"
  },
  RelicConfig_70786_StoryDesc = {
    Text = "Solange unser Gehirn ein Rätsel bleibt, ist es nicht überraschend, dass es voller Tentakel ist"
  },
  RelicConfig_70787_BattleDesc = {
    Text = "Alle Erwecker erhöhen den Basisschaden um [Arg1]%."
  },
  RelicConfig_70787_Desc = {
    Text = "Alle Erwecker erhöhen den Basisschaden um [Arg1]%."
  },
  RelicConfig_70787_Name = {
    Text = "<OrangeQuality:Weinende Pfeife+>"
  },
  RelicConfig_70787_StoryDesc = {
    Text = "Ist das das Ergebnis von Hass oder Rache?"
  },
  RelicConfig_70788_BattleDesc = {
    Text = "Nach der Silberschlüsselerweckung erhalten alle Erwachten [Arg1] Wahnsinn und [Arg2] s-Energie."
  },
  RelicConfig_70788_Desc = {
    Text = "Nach der Silberschlüsselerweckung erhalten alle Erwachten [Arg1] Wahnsinn und [Arg2] s-Energie."
  },
  RelicConfig_70788_Name = {
    Text = "<WhiteQuality:Lorbeer-Manschettenknöpfe>"
  },
  RelicConfig_70788_StoryDesc = {
    Text = "Silberne Manschettenknöpfe mit Lorbeerblattmuster.\nSie sind fein gearbeitet und glänzend, und sie trugen einst die Freundschaft zweier Kinder"
  },
  RelicConfig_70789_BattleDesc = {
    Text = "Nach Beginn des Kampfes erhältst du [Arg1] <ProficientInRealmsIconKeywords:Reichsbeherrschung>. Die <IntoxicationIconKeywords:Vergiftung> aller Erwachten und die <IntoxicationIconKeywords:Vergiftung> von Relikten wird um [Arg2]% erhöht."
  },
  RelicConfig_70789_Desc = {
    Text = "Nach Beginn des Kampfes erhältst du [Arg1] <ProficientInRealmsIconKeywords:Reichsbeherrschung>. Die <IntoxicationIconKeywords:Vergiftung> aller Erwachten und die <IntoxicationIconKeywords:Vergiftung> von Relikten wird um [Arg2]% erhöht."
  },
  RelicConfig_70789_Name = {
    Text = "<WhiteQuality:Staubige Nähmaschine>"
  },
  RelicConfig_70789_StoryDesc = {
    Text = "Eine liebevolle Mutter, die die Wunden des Herzens näht"
  },
  RelicConfig_70790_BattleDesc = {
    Text = "Vernichtung lässt das Erwachte mit dem niedrigsten Wahnsinn [Arg1] Wahnsinn erhalten, 3 Runden Abkühlung."
  },
  RelicConfig_70790_Desc = {
    Text = "Vernichtung lässt das Erwachte mit dem niedrigsten Wahnsinn [Arg1] Wahnsinn erhalten, 3 Runden Abkühlung."
  },
  RelicConfig_70790_Name = {
    Text = "<OrangeQuality:Zeitwurm+>"
  },
  RelicConfig_70790_StoryDesc = {
    Text = "Eine Taschenuhr, die gleichzeitig im Uhrengeschäft und im Insektenmuseum existiert.\nNach dem Beginn des Holozäns wurde sie in die Universitätskollektion aufgenommen"
  },
  RelicConfig_70791_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich die Tentakelobergrenze um [Arg1], du erhältst [Arg2] Tentakel."
  },
  RelicConfig_70791_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich die Tentakelobergrenze um [Arg1], du erhältst [Arg2] Tentakel."
  },
  RelicConfig_70791_Name = {
    Text = "<OrangeQuality:Meereskind-Lied+>"
  },
  RelicConfig_70791_StoryDesc = {
    Text = "Es wird gesagt, dass ungenießbare Tiere wie das Gewebe-Nudelkrebse etwa 80% der Nährstoffe aus dem Ozean aufnehmen"
  },
  RelicConfig_70792_BattleDesc = {
    Text = "Am Ende der Runde erhält man, wenn man sich in der Flutwelle-Haltung befindet, [Arg1] <TentacleInjurieIconKeywords:Tentakelschaden>. Abkühlung: 3 Runden."
  },
  RelicConfig_70792_Desc = {
    Text = "Am Ende der Runde erhält man, wenn man sich in der Flutwelle-Haltung befindet, [Arg1] <TentacleInjurieIconKeywords:Tentakelschaden>. Abkühlung: 3 Runden."
  },
  RelicConfig_70792_Name = {
    Text = "<OrangeQuality:Bandwurm+>"
  },
  RelicConfig_70792_StoryDesc = {
    Text = "Solange unser Gehirn ein Rätsel bleibt, ist es nicht überraschend, dass es voller Tentakel ist"
  },
  RelicConfig_70793_BattleDesc = {
    Text = "Beim ersten <DevouredIconKeywords:Verschlingen> pro Runde erhalten andere Erwachte [Arg1] Wahnsinn."
  },
  RelicConfig_70793_Desc = {
    Text = "Beim ersten <DevouredIconKeywords:Verschlingen> pro Runde erhalten andere Erwachte [Arg1] Wahnsinn."
  },
  RelicConfig_70793_Name = {
    Text = "<OrangeQuality:Goldener Traum+>"
  },
  RelicConfig_70793_StoryDesc = {
    Text = "Der Tag der Verwandlung ist dein Todestag"
  },
  RelicConfig_70794_BattleDesc = {
    Text = "Vernichtung: Erhalte [Arg1] Schild, 3 Runden Abkühlung."
  },
  RelicConfig_70794_Desc = {
    Text = "Vernichtung: Erhalte [Arg1] Schild, 3 Runden Abkühlung."
  },
  RelicConfig_70794_Name = {
    Text = "<OrangeQuality:Supersaiten-Taschenuhr+>"
  },
  RelicConfig_70794_StoryDesc = {
    Text = "“Oh, die Taschenuhr ist stehen geblieben.“"
  },
  RelicConfig_70795_BattleDesc = {
    Text = "Nachdem du eine nicht abgeleitete Befehlskarte gespielt hast, mische [Arg1] vorübergehende Kopien dieser Karte mit um 2 reduziertem Arithmetica-Verbrauch in den Ziehstapel. Abklingzeit: 3 Runden."
  },
  RelicConfig_70795_Desc = {
    Text = "Nachdem du eine nicht abgeleitete Befehlskarte gespielt hast, mische [Arg1] vorübergehende Kopien dieser Karte mit um 2 reduziertem Arithmetica-Verbrauch in den Ziehstapel. Abklingzeit: 3 Runden."
  },
  RelicConfig_70795_Name = {
    Text = "<WhiteQuality:Stumme Phonograph>"
  },
  RelicConfig_70795_StoryDesc = {
    Text = "Seine Stimme verschwand im Wind"
  },
  RelicConfig_70796_BattleDesc = {
    Text = "Nach dem Einsetzen von „Verherrlichung“ erleiden alle Gegner [Arg1] <FixedDamage:Reinen SCH> und lösen [Arg2]% <IntoxicationIconKeywords:Gift> aus."
  },
  RelicConfig_70796_Desc = {
    Text = "Nach dem Einsetzen von „Verherrlichung“ erleiden alle Gegner 1 Instanz <FixedDamage:Reinen SCH> in Höhe von [Arg2]% der Max LP des Teams und lösen [Arg2]% <IntoxicationIconKeywords:Gift> aus."
  },
  RelicConfig_70796_Name = {
    Text = "<OrangeQuality:Laserkiefer+>"
  },
  RelicConfig_70796_StoryDesc = {
    Text = "Die Knochen, in der privaten Sammlung eines Sammlers ausgestellt.\nDer Sammler war besessen von dem schönen Leuchten, bewunderte es Tag und Nacht und verdorrte schließlich, wurde schließlich zu seinem Gleichgesinnten"
  },
  RelicConfig_70797_BattleDesc = {
    Text = "Maximale Arithmetica erhöht sich um [Arg1]."
  },
  RelicConfig_70797_Desc = {
    Text = "Maximale Arithmetica erhöht sich um [Arg1]."
  },
  RelicConfig_70797_Name = {
    Text = "<WhiteQuality:Aktivinjektor>"
  },
  RelicConfig_70797_StoryDesc = {
    Text = "Zuckungen sind auch eine Form von Aktivität"
  },
  RelicConfig_70798_BattleDesc = {
    Text = "Verwende die Haltung „Wogen“, um sofort alle Tentakel zu aktivieren und den Feind [Arg1] Mal anzugreifen. (3-Runden-Abkühlung)"
  },
  RelicConfig_70798_Desc = {
    Text = "Verwende die Haltung „Wogen“, um sofort alle Tentakel zu aktivieren und den Feind [Arg1] Mal anzugreifen. (3-Runden-Abkühlung)"
  },
  RelicConfig_70798_Name = {
    Text = "<OrangeQuality:Wollust der Schraube+>"
  },
  RelicConfig_70798_StoryDesc = {
    Text = "Herr des ewigen Schlafs, erwarte dich im Traum"
  },
  RelicConfig_70799_BattleDesc = {
    Text = "Bei VERT erhält man [Arg1] temporären <RetaliateIconKeywords:Gegenangriff>, maximal 3 Mal pro Runde auslösbar."
  },
  RelicConfig_70799_Desc = {
    Text = "Bei VERT erhält man [Arg1] temporären <RetaliateIconKeywords:Gegenangriff>, maximal 3 Mal pro Runde auslösbar."
  },
  RelicConfig_70799_Name = {
    Text = "<OrangeQuality:Erinnerungsuhr eines Verstorbenen+>"
  },
  RelicConfig_70799_StoryDesc = {
    Text = "Mit Erinnerungen und Trauer vorwärts ins Unbekannte"
  },
  RelicConfig_70800_BattleDesc = {
    Text = "Bei VERT erhält man [Arg1] temporären <RetaliateIconKeywords:Gegenangriff>, maximal 3 Mal pro Runde auslösbar."
  },
  RelicConfig_70800_Desc = {
    Text = "Bei VERT erhält man [Arg1] temporären <RetaliateIconKeywords:Gegenangriff>, maximal 3 Mal pro Runde auslösbar."
  },
  RelicConfig_70800_Name = {
    Text = "<WhiteQuality:Erinnerungstaschenuhr>"
  },
  RelicConfig_70800_StoryDesc = {
    Text = "Mit Erinnerungen und Trauer vorwärts ins Unbekannte"
  },
  RelicConfig_70986_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn ungerader Runden wählt man 1 von 2 Relikten aus, das 5 ungerade Runden lang wirkt."
  },
  RelicConfig_70986_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn ungerader Runden wählt man 1 von 2 Relikten aus, das 5 ungerade Runden lang wirkt."
  },
  RelicConfig_70986_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Wunsch η“>"
  },
  RelicConfig_70987_BattleDesc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn ungerader Runden wählt man 1 von 2 Relikten aus, das 5 ungerade Runden lang wirkt."
  },
  RelicConfig_70987_Desc = {
    Text = "Zu Beginn des Kampfes erhöht sich das Arithmetica-Limit um 1, alle Erwecker werden erweckt. Zu Beginn ungerader Runden wählt man 1 von 2 Relikten aus, das 5 ungerade Runden lang wirkt."
  },
  RelicConfig_70987_Name = {
    Text = "<OrangeQuality:Chrono-Pendel“Wunsch ζ“>"
  },
  RelicConfig_71195_BattleDesc = {
    Text = "Zu Beginn der Runde erhält Ring-Ramona [Arg1] Wahnsinn. Beim ersten Auslösen von „Schleife“ pro Runde erhältst du [Arg2] Einheiten s-Energie und [Arg3] Stufen „Negentropie“."
  },
  RelicConfig_71195_Desc = {
    Text = "Zu Beginn der Runde erhält Ring-Ramona [Arg1] Wahnsinn. Beim ersten Auslösen von „Schleife“ pro Runde erhältst du [Arg2] Einheiten s-Energie und [Arg3] Stufen „Negentropie“."
  },
  RelicConfig_71195_Name = {
    Text = "<OrangeQuality:Dimensionale Resonanz - Rundgang - Ramona>"
  },
  RelicConfig_71196_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Lotan [Arg1] Wahnsinn. Nach dem ersten Ausspielen von Lotans „VERT“ in jeder Runde lege [Arg2] zusätzliche Karten mit Kosten und Leere namens „Stolzes Schwert“ in die Hand."
  },
  RelicConfig_71196_Desc = {
    Text = "Zu Rundenbeginn erhält Lotan [Arg1] Wahnsinn. Nach dem ersten Ausspielen von Lotans „VERT“ in jeder Runde lege [Arg2] zusätzliche Karten mit Kosten und Leere namens „Stolzes Schwert“ in die Hand."
  },
  RelicConfig_71196_Name = {
    Text = "<OrangeQuality:Dimensionales Abbild – Lothan>"
  },
  RelicConfig_71197_BattleDesc = {
    Text = "Zu Beginn der Runde erhält Ramona [Arg1] Wahnsinn. Jede [Arg2]-te ausgespielte Befehlskarte von Ramona wird zusätzlich einmal wirksam und verleiht dir [Arg3] Punkte Silberenergie."
  },
  RelicConfig_71197_Desc = {
    Text = "Zu Beginn der Runde erhält Ramona [Arg1] Wahnsinn. Jede [Arg2]-te ausgespielte Befehlskarte von Ramona wird zusätzlich einmal wirksam und verleiht dir [Arg3] Punkte Silberenergie."
  },
  RelicConfig_71197_Name = {
    Text = "<OrangeQuality:Dimensionales Abbild · Ramona>"
  },
  RelicConfig_71230_BattleDesc = {
    Text = "Zu Beginn des Zuges erhält Leigh [Arg1] Aliemus. Jedes Mal, wenn LP verloren werden, erhält sie [Arg2] Stärke, maximal [Arg3] Mal pro Kampf stapelbar. Nach [Arg3] Stapelungen werden die Arithmetica-Kosten von „Schmerz und Vergnügen\" um 2 gesenkt und die Schadensanzahl um 1 erhöht."
  },
  RelicConfig_71230_Desc = {
    Text = "Zu Beginn des Zuges erhält Leigh [Arg1] Aliemus. Jedes Mal, wenn LP verloren werden, erhält sie [Arg2] Stärke, maximal [Arg3] Mal pro Kampf stapelbar. Nach [Arg3] Stapelungen werden die Arithmetica-Kosten von „Schmerz und Vergnügen\" um 2 gesenkt und die Schadensanzahl um 1 erhöht."
  },
  RelicConfig_71230_Name = {
    Text = "<OrangeQuality:Dimensionsabbild·Leia>"
  },
  RelicConfig_71231_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Aurita [Arg1] Wahnsinn. Die Anzahl der Schadensanwendungen von „Drüsenspaltung“ wird um [Arg2] erhöht. Nach dem Ausspielen von Auritas „VERT“ wird 1 Karte „Drüsenspaltung“ auf die Hand gelegt."
  },
  RelicConfig_71231_Desc = {
    Text = "Zu Rundenbeginn erhält Aurita [Arg1] Wahnsinn. Die Anzahl der Schadensanwendungen von „Drüsenspaltung“ wird um [Arg2] erhöht. Nach dem Ausspielen von Auritas „VERT“ wird 1 Karte „Drüsenspaltung“ auf die Hand gelegt."
  },
  RelicConfig_71231_Name = {
    Text = "<OrangeQuality:Dimensionales Abbild · Oreta>"
  },
  RelicConfig_71232_BattleDesc = {
    Text = "Zu Beginn der Runde erhält Tinktur [Arg1] Wahnsinn. Wenn Tinkturs Befehlskarte den Sprung auslöst, kehrt sie in ihre Hand zurück und reduziert vor dem Ausspielen die Arithmetica-Kosten um 1; dieser Effekt kann pro Runde maximal [Arg2]-mal ausgelöst werden."
  },
  RelicConfig_71232_Desc = {
    Text = "Zu Beginn der Runde erhält Tinktur [Arg1] Wahnsinn. Wenn Tinkturs Befehlskarte den Sprung auslöst, kehrt sie in ihre Hand zurück und reduziert vor dem Ausspielen die Arithmetica-Kosten um 1; dieser Effekt kann pro Runde maximal [Arg2]-mal ausgelöst werden."
  },
  RelicConfig_71232_Name = {
    Text = "<OrangeQuality:Dimensionales Echo·Tinktur>"
  },
  RelicConfig_71233_BattleDesc = {
    Text = "Zu Beginn der Runde erhält Nautila [Arg1] Wahnsinn. Nachdem Nautilas “Wahnsinnsexplosion“ ausgelöst wurde, erhält man eine Vergeltung in Höhe von [Arg2] % des aktuellen Schildes sowie einen verzögerten Schild. Pro Runde maximal 1-mal auslösbar."
  },
  RelicConfig_71233_Desc = {
    Text = "Zu Beginn der Runde erhält Nautila [Arg1] Aliemus. Nachdem Nautilas „Verherrlichung \" ausgelöst wurde, erhält man Konter und Verzögerten Schild in Höhe von [Arg2] % des aktuellen Schildes. Pro Runde maximal 1-mal auslösbar."
  },
  RelicConfig_71233_Name = {
    Text = "<OrangeQuality:Dimensionsprojektion: Nodira>"
  },
  RelicConfig_71234_BattleDesc = {
    Text = "Am Anfang der Runde erhält Schmelze · Puppe [Arg1] Wahnsinn. Nachdem Schmelze Puppe die Wahnexplosion ausgelöst hat, erhält jeder andere Erwachte 1 Punkt Wahnsinn für jeweils [Arg2] verbrauchte Punkte Wahnsinn."
  },
  RelicConfig_71234_Desc = {
    Text = "Zu Beginn der Runde erhält Doll: Inferno [Arg1] Aliemus. Nachdem Doll: Inferno die Verherrlichung ausgelöst hat, erhält jeder andere Erwecker 1 Punkt Aliemus für jeweils [Arg2] verbrauchte Punkte Aliemus."
  },
  RelicConfig_71234_Name = {
    Text = "<OrangeQuality:Dimensio-Bild · Schmelze · Dore>"
  },
  RelicConfig_71235_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Helot [Arg1] Aelius. Jedes Mal, wenn eine Karte abgelegt wird, erhält Helot [Arg2] Punkte Aelius."
  },
  RelicConfig_71235_Desc = {
    Text = "Zu Rundenbeginn erhält Helot [Arg1] Aelius. Jedes Mal, wenn eine Karte abgelegt wird, erhält Helot [Arg2] Punkte Aelius."
  },
  RelicConfig_71235_Name = {
    Text = "<OrangeQuality:Dimensionales Echo·Shiro>"
  },
  RelicConfig_71236_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Daphdail [Arg1] Wahnsinn und 1 “Inspiration“-Karte. Die erlangte Macht von “Heterogene Gezeiten“ wird um [Arg2] % gesteigert; jedes Ausspielen erhöht diese während der aktuellen Erkundung zusätzlich und dauerhaft um [Arg3] %, maximal um [Arg4] %."
  },
  RelicConfig_71236_Desc = {
    Text = "Zu Rundenbeginn erhält Daphdail [Arg1] Wahnsinn und 1 “Inspiration“-Karte. Die erlangte Macht von “Heterogene Gezeiten“ wird um [Arg2] % gesteigert; jedes Ausspielen erhöht diese während der aktuellen Erkundung zusätzlich und dauerhaft um [Arg3] %, maximal um [Arg4] %."
  },
  RelicConfig_71236_Name = {
    Text = "<OrangeQuality:Dimensionales Echo - Daphdelle>"
  },
  RelicConfig_71237_BattleDesc = {
    Text = "Zu Beginn der Runde erhält Wanda [Arg1] Aliemus und  [Arg2] Schichten “Traumköder“. Falls es sich um eine Ultra-Runde handelt, lege zusätzlich 1 temporäre Karte “Wirbelsäulennadelketten“ und “Hüter der Verlorenen“ auf die Hand und lasse Wandas nächste Befehlskarte 2 Mal wirken."
  },
  RelicConfig_71237_Desc = {
    Text = "Zu Beginn der Runde erhält Wanda [Arg1] Aliemus und [Arg2] Schichten “Traumköder“. Falls es eine Ultra-Runde ist, lege zusätzlich 1 vorübergehende Karte “Wirbelsäulennadelketten“ und “Hüter der Verlorenen“ auf die Hand und lasse Wandas nächste Befehlskarte 2 Mal wirksam werden."
  },
  RelicConfig_71237_Name = {
    Text = "<OrangeQuality:Dimensionales Bild · Wanda>"
  },
  RelicConfig_71238_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Agrippa [Arg1] Wahnsinn. „Ungeduldige Almosen“ reduzieren zudem Agrippas Arithmetica-Verbrauch in dieser Runde um [Arg2]. Dieser Effekt kann pro Runde nur einmal wirken."
  },
  RelicConfig_71238_Desc = {
    Text = "Zu Rundenbeginn erhält Agrippa [Arg1] Wahnsinn. „Ungeduldige Almosen“ reduzieren zudem Agrippas Arithmetica-Verbrauch in dieser Runde um [Arg2]. Dieser Effekt kann pro Runde nur einmal wirken."
  },
  RelicConfig_71238_Name = {
    Text = "<OrangeQuality:Dimensionales Hologramm - Agrippa>"
  },
  RelicConfig_71239_BattleDesc = {
    Text = "Zu Rundenbeginn erhält “24“ [Arg1] Aliemus. Zu Rundenbeginn erhält “24“, wenn sie sich in der “deprimierten Persönlichkeit“ befindet, zusätzlich [Arg2] Aliemus; wenn sie sich in der “manischen Persönlichkeit“ befindet, werden die temporäre Krit. Trefferquote und der temporäre Krit. Schaden von “24“ um [Arg2]% erhöht."
  },
  RelicConfig_71239_Desc = {
    Text = "Zu Rundenbeginn erhält “24“ [Arg1] Aliemus. Zu Rundenbeginn erhält “24“, wenn sie sich in der “deprimierten Persönlichkeit“ befinden, zusätzlich [Arg2] Aliemus; wenn sie sich in der “manischen Persönlichkeit“ befinden, erhöht sich die temporäre kritische Trefferquote und der temporäre kritische Schaden von “24“ um [Arg2]%."
  },
  RelicConfig_71239_Name = {
    Text = "<OrangeQuality:Dimensio-Bild „24“>"
  },
  RelicConfig_71240_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Liz [Arg1] Wahnsinn. „Tanz zur Zerstörung“: Die abgelegten Karten wirken zusätzlich 1 Mal. Abklingzeit: 3 Runden."
  },
  RelicConfig_71240_Desc = {
    Text = "Zu Rundenbeginn erhält Liz [Arg1] Wahnsinn. „Tanz zur Zerstörung“: Die abgelegten Karten wirken zusätzlich 1 Mal. Abklingzeit: 3 Runden."
  },
  RelicConfig_71240_Name = {
    Text = "<OrangeQuality:Dimensionales Abbild·Liz>"
  },
  RelicConfig_71241_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Blutkette-Hilo [Arg1] Wahnsinn. Bei aktivem Schaden von Blutkette · Hilo wird zusätzlich [Arg2] % Blutung hinzugefügt. Nach dem Tod eines Feindes verursacht sie bei anderen Feinden Blutung in Höhe des überschüssigen Schadens."
  },
  RelicConfig_71241_Desc = {
    Text = "Zu Rundenbeginn erhält Helot: Kette [Arg1] Aliemus. Beim Aktiven Schaden von Helot: Kette wird zusätzlich [Arg2] % Blutung hinzugefügt. Nach dem Tod eines Feindes verursacht sie bei anderen Feinden Blutung in Höhe des überschüssigen Schadens."
  },
  RelicConfig_71241_Name = {
    Text = "<OrangeQuality:Dimensionales Echo - Blutkette - Shiro>"
  },
  RelicConfig_71242_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Celeste [Arg1] Aliemus. Bevor die Runde endet, greift pro Befehlskarte von Celeste auf der Hand ein Tentakel den Feind an und stellt [Heal:Arg2] LP wieder her."
  },
  RelicConfig_71242_Desc = {
    Text = "Zu Rundenbeginn erhält Celeste [Arg1] Aliemus. Bevor die Runde endet, greift pro Befehlskarte von Celeste auf der Hand ein Tentakel den Feind an und stellt [Heal:Arg2] LP wieder her."
  },
  RelicConfig_71242_Name = {
    Text = "<OrangeQuality:Dimensionales Echo - Celest>"
  },
  RelicConfig_71243_BattleDesc = {
    Text = "Zu Beginn jeder Runde erhält Casiah [Arg1] Wahnsinn. Für jede gezogene Karte erhält Casiah zusätzlich [Arg2] Wahnsinn. Wenn Casiah ihre Wahnsinnsexplosion aktiviert, verlieren alle Feinde [Arg3] Stärkepunkte."
  },
  RelicConfig_71243_Desc = {
    Text = "Zu Beginn jeder Runde erhält Casiah [Arg1] Wahnsinn. Für jede gezogene Karte erhält Casiah zusätzlich [Arg2] Wahnsinn. Wenn Casiah ihre Wahnsinnsexplosion aktiviert, verlieren alle Feinde [Arg3] Stärkepunkte."
  },
  RelicConfig_71243_Name = {
    Text = "<OrangeQuality:Dimensionales Abbild – Cassia>"
  },
  RelicConfig_71244_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Sorel [Arg1] Aliemus. Jedes Mal, wenn Sorel Schaden verursacht, erhöht sich die Embryofusion um +[Arg2], maximal [Arg3]-<plural value=\"[Arg3]\" singular=\"mal\" plural=\"mal\"> pro Runde. Nach 10-maliger Aktivierung erhöht sich der Gesamtschaden von Sorel in diesem Kampf um +[Arg4] %."
  },
  RelicConfig_71244_Desc = {
    Text = "Zu Rundenbeginn erhält Sorel [Arg1] Aliemus. Jedes Mal, wenn Sorel Schaden verursacht, erhöht sich die Embryofusion um +[Arg2], maximal [Arg3]-<plural value=\"[Arg3]\" singular=\"mal\" plural=\"mal\"> pro Runde. Nach 10-maliger Aktivierung erhöht sich der Gesamtschaden von Sorel in diesem Kampf um +[Arg4] %."
  },
  RelicConfig_71244_Name = {
    Text = "<OrangeQuality:Dimensionales Echo·Sorel>"
  },
  RelicConfig_71245_BattleDesc = {
    Text = "Zu Beginn der Runde erhält Ogier [Arg1] Wahnsinn. Wenn Ogier in dieser Runde zum ersten Mal “Speer“ oder “Schlag“ ausspielt, erhöhen sich der in dieser Runde erzeugte Schild und die Macht um [Arg2] %."
  },
  RelicConfig_71245_Desc = {
    Text = "Zu Beginn der Runde erhält Ogier [Arg1] Wahnsinn. Wenn Ogier in dieser Runde zum ersten Mal “Speer“ oder “Schlag“ ausspielt, erhöhen sich der in dieser Runde erzeugte Schild und die Macht um [Arg2] %."
  },
  RelicConfig_71245_Name = {
    Text = "<OrangeQuality:Dimensionales Bild · Ogier>"
  },
  RelicConfig_71246_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Alva [Arg1] Aliemus. Wenn Alva in einer Runde die [Arg2] Karte “VERT“ spielt, erhält sie eine “Präzisionshieb“-Karte mit Verbrauch auf die Hand; beim Spielen der [Arg3] Karte “Schlag“ erhält sie eine “Kampfstellung“-Karte mit Verbrauch auf die Hand."
  },
  RelicConfig_71246_Desc = {
    Text = "Zu Rundenbeginn erhält Alva [Arg1] Aliemus. Wenn Alva innerhalb einer Runde die [Arg2]. Karte “VERT“ spielt, erhält sie 1 Karte mit Verbrauch “Präzisionshieb“ auf die Hand; beim Ausspielen der [Arg3]. Karte “Schlag“ erhält sie 1 Karte mit Verbrauch “Kampfstellung“ auf die Hand."
  },
  RelicConfig_71246_Name = {
    Text = "<OrangeQuality:Dimensionales Abbild – Elwa>"
  },
  RelicConfig_71247_BattleDesc = {
    Text = "Am Beginn des Zuges erhält Jenkins [Arg1] Wahnsinn und der Endschaden erhöht sich um [Arg2]%. Der Basis- und verursachte Schaden von „Braun, ANG!“ steigt um [Arg3]%."
  },
  RelicConfig_71247_Desc = {
    Text = "Am Beginn des Zuges erhält Jenkins [Arg1] Wahnsinn und der Endschaden erhöht sich um [Arg2]%. Der Basis- und verursachte Schaden von „Braun, ANG!“ steigt um [Arg3]%."
  },
  RelicConfig_71247_Name = {
    Text = "<OrangeQuality:Dimensionales Bild · Jenkins>"
  },
  RelicConfig_71248_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Puppe [Arg1] Aelius. Nach Beginn des Kampfes wird der Arithmetica-Verbrauch von Puppes „Äquivalenter Austausch“ auf 0 gesetzt. Nach dem Ausspielen zieht sie in der nächsten Runde zusätzlich [Arg2] Karten."
  },
  RelicConfig_71248_Desc = {
    Text = "Zu Rundenbeginn erhält Puppe [Arg1] Aelius. Nach Beginn des Kampfes wird der Arithmetica-Verbrauch von Puppes „Äquivalenter Austausch“ auf 0 gesetzt. Nach dem Ausspielen zieht sie in der nächsten Runde zusätzlich [Arg2] Karten."
  },
  RelicConfig_71248_Name = {
    Text = "<OrangeQuality:Dimensionales Bild · Dore>"
  },
  RelicConfig_71249_BattleDesc = {
    Text = "Zu Beginn der Runde erhält Ryker [Arg1] Aliemus. Das erste Würfelergebnis jeder Runde ist immer das Maximum."
  },
  RelicConfig_71249_Desc = {
    Text = "Zu Beginn der Runde erhält Ryker [Arg1] Aliemus. Das erste Würfelergebnis jeder Runde ist immer das Maximum."
  },
  RelicConfig_71249_Name = {
    Text = "<OrangeQuality:Dimensionales Porträt·Leck>"
  },
  RelicConfig_71250_BattleDesc = {
    Text = "Am Beginn ihres Zuges erhält Miryam [Arg1] Wahnsinn und nimmt 1 “Eucharistie“ auf die Hand."
  },
  RelicConfig_71250_Desc = {
    Text = "Am Beginn ihres Zuges erhält Miryam [Arg1] Wahnsinn und nimmt 1 “Eucharistie“ auf die Hand."
  },
  RelicConfig_71250_Name = {
    Text = "<OrangeQuality:Dimensionsbild-Miriam>"
  },
  RelicConfig_71251_BattleDesc = {
    Text = "Am Beginn seines Zuges erhält Wenkel [Arg1] Wahnsinn. Jedes Mal, wenn ein anderer Erwachter eine Wahnexplosion auslöst, erhält Wenkel [Arg2] Wahnsinnspunkte, und die Arithmetica-Kosten von „Geistige Rekonstruktion“ in seiner Hand werden um [Arg3] reduziert."
  },
  RelicConfig_71251_Desc = {
    Text = "Am Beginn seines Zuges erhält Wenkel [Arg1] Wahnsinn. Jedes Mal, wenn ein anderer Erwachter eine Wahnexplosion auslöst, erhält Wenkel [Arg2] Wahnsinnspunkte, und die Arithmetica-Kosten von „Geistige Rekonstruktion“ in seiner Hand werden um [Arg3] reduziert."
  },
  RelicConfig_71251_Name = {
    Text = "<OrangeQuality:Dimensionsbild • Winkel>"
  },
  RelicConfig_71252_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Tulu [Arg1] Aliemus. Tulus Basis-Aliemus –[Arg2]. Nach der Auslösung von Verherrlichung werden sofort [Arg3] temporäre Tentakel erzeugt."
  },
  RelicConfig_71252_Desc = {
    Text = "Zu Rundenbeginn erhält Tulu [Arg1] Aliemus. Tulus Basis-Aliemus –[Arg2]. Nach der Auslösung von Verherrlichung werden sofort [Arg3] temporäre Tentakel erzeugt."
  },
  RelicConfig_71252_Name = {
    Text = "<OrangeQuality:Dimensionales Abbild · Tulu>"
  },
  RelicConfig_71253_BattleDesc = {
    Text = "Zu Beginn jeder Runde erhält Faint [Arg1] Aelius. Der von Faint verursachte Schild, Gegenangriff und die Lebensrückgewinnung erhöhen sich um [Arg2]%, und bei jedem Auslösen des Todwiderstands wird dieser Effekt in dieser Erkundung um [Arg3]% erhöht, maximal [Arg4] Mal aktiv."
  },
  RelicConfig_71253_Desc = {
    Text = "Zu Beginn jeder Runde erhält Faint [Arg1] Aelius. Der Schild, der Gegenangriff und die Heilung, die Faint verursacht, steigen um [Arg2] %. Jedes Mal, wenn der Todwiderstand ausgelöst wird, erhöht sich dieser Effekt während dieser Erkundung um [Arg3] %, maximal [Arg4] Mal."
  },
  RelicConfig_71253_Name = {
    Text = "<OrangeQuality:Dimensionales Abbild – Feint>"
  },
  RelicConfig_71254_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Tawil [Arg1] Aliemus. Wenn in einer Runde [Arg2] von Tawils Befehlskarten gespielt werden, füge 1 <DerivativeCardKeywords_67:\"Silberner Schlüssel: Morgen\"> zur Hand hinzu. Abklingzeit: [Arg3] Runden."
  },
  RelicConfig_71254_Desc = {
    Text = "Zu Rundenbeginn erhält Tawil [Arg1] Aliemus. Wenn in einer Runde [Arg2] von Tawils Befehlskarten gespielt werden, füge 1 <DerivativeCardKeywords_67:\"Silberner Schlüssel: Morgen\"> zur Hand hinzu. Abklingzeit: [Arg3] Runden."
  },
  RelicConfig_71254_Name = {
    Text = "<OrangeQuality:Dimensionales Abbild · Tawei>"
  },
  RelicConfig_71255_BattleDesc = {
    Text = "Zu Beginn des Zuges erhält Hameln [Arg1] Aliemus. Die Arithmetica-Kosten der „Seelen-Ouvertüre\" werden um [Arg2] gesenkt, die Anzahl der Grundschadentreffer wird um [Arg3] erhöht."
  },
  RelicConfig_71255_Desc = {
    Text = "Zu Beginn des Zuges erhält Hameln [Arg1] Aliemus. Die Arithmetica-Kosten der „Seelen-Ouvertüre\" werden um [Arg2] gesenkt, die Anzahl der Grundschadentreffer wird um [Arg3] erhöht."
  },
  RelicConfig_71255_Name = {
    Text = "<OrangeQuality:Dimensionales Abbild · Hamlin>"
  },
  RelicConfig_71256_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Horla [Arg1] Wahnsinn. Zu Kampfbeginn erhältst du jeweils [Arg2] Schichten aller Emotionen-Metaphern. Der Effekt der „Metapher“ wird um 50% erhöht."
  },
  RelicConfig_71256_Desc = {
    Text = "Zu Rundenbeginn erhält Horla [Arg1] Wahnsinn. Zu Kampfbeginn erhältst du jeweils [Arg2] Schichten aller Emotionen-Metaphern. Der Effekt der „Metapher“ wird um 50% erhöht."
  },
  RelicConfig_71256_Name = {
    Text = "<OrangeQuality:Dimensionsabbildung · Horla>"
  },
  RelicConfig_71257_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Murphy [Arg1] Wahnsinn. Murphys „Schlag“ und „VERT“ können [Arg2]% des „Opfers“ in temporären Tentakelschaden umwandeln, jedoch maximal einmal pro Runde wirksam."
  },
  RelicConfig_71257_Desc = {
    Text = "Zu Rundenbeginn erhält Murphy [Arg1] Wahnsinn. Murphys „Schlag“ und „VERT“ können [Arg2]% des „Opfers“ in temporären Tentakelschaden umwandeln, jedoch maximal einmal pro Runde wirksam."
  },
  RelicConfig_71257_Name = {
    Text = "<OrangeQuality:Dimensionales Echo · Murphy>"
  },
  RelicConfig_71258_BattleDesc = {
    Text = "Am Rundenbeginn erhält Uvhash [Arg1] Aliemus. Uvhashs Basis-Aliemus –[Arg2]. Bei jedem Auslösen von Verherrlichung wird er zusätzlich um 5 reduziert, und pro Runde kann Verherrlichung [Arg3]-<plural value=\"[Arg3]\" singular=\"mal\" plural=\"mal\"> ausgelöst werden."
  },
  RelicConfig_71258_Desc = {
    Text = "Am Rundenbeginn erhält Uvhash [Arg1] Aliemus. Uvhashs Basis-Aliemus –[Arg2]. Bei jedem Auslösen von Verherrlichung wird er zusätzlich um 5 reduziert, und pro Runde kann Verherrlichung [Arg3]-<plural value=\"[Arg3]\" singular=\"mal\" plural=\"mal\"> ausgelöst werden."
  },
  RelicConfig_71258_Name = {
    Text = "<OrangeQuality:Dimensionsbild·Ejuhashi>"
  },
  RelicConfig_71259_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Aigis [Arg1] Wahnsinn. Wenn Aigis Schaden an Feinden mit Verwundbarkeit verursacht, stiehlt sie außerdem [Arg2] Punkte temporäre Stärke, maximal [Arg3] Mal pro Runde."
  },
  RelicConfig_71259_Desc = {
    Text = "Zu Rundenbeginn erhält Aigis [Arg1] Wahnsinn. Wenn Aigis Schaden an Feinden mit Verwundbarkeit verursacht, stiehlt sie außerdem [Arg2] Punkte temporäre Stärke, maximal [Arg3] Mal pro Runde."
  },
  RelicConfig_71259_Name = {
    Text = "<OrangeQuality:Dimensionenbild Aijisi>"
  },
  RelicConfig_71260_BattleDesc = {
    Text = "Zu Beginn der Runde erhält Thais [Arg1] Aliemus. Nachdem [Arg2] Befehlskarten in einer Runde gespielt wurden, erhält Thais 1 „Heiliges Kind“ und [Arg3] Temporäre Stärke, mit einer Abklingzeit von [Arg4] Runden."
  },
  RelicConfig_71260_Desc = {
    Text = "Zu Beginn der Runde erhält Thais [Arg1] Aliemus. Nachdem [Arg2] Befehlskarten in einer Runde gespielt wurden, erhält Thais 1 „Heiliges Kind“ und [Arg3] Temporäre Stärke, mit einer Abklingzeit von [Arg4] Runden."
  },
  RelicConfig_71260_Name = {
    Text = "<OrangeQuality:Dimensionales Abbild · Pikeman>"
  },
  RelicConfig_71261_BattleDesc = {
    Text = "Zu Beginn jeder Runde erhält Faros [Arg1] Wahnsinn. Für jeweils 2 verursachte Tentakelschäden erhöht sich das Gift und der Schild, den Faros in diesem Kampf gewährt, um [Arg2]%, maximal 50%."
  },
  RelicConfig_71261_Desc = {
    Text = "Zu Beginn jeder Runde erhält Faros [Arg1] Wahnsinn. Für jeweils 2 verursachte Tentakelschäden erhöht sich das Gift und der Schild, den Faros in diesem Kampf gewährt, um [Arg2]%, maximal 50%."
  },
  RelicConfig_71261_Name = {
    Text = "<OrangeQuality:Dimensionsnachbild·Faros>"
  },
  RelicConfig_71262_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Pandia [Arg1] Aelius. Nachdem Pandia Aelius ausgelöst hat, erhält sie dauerhaften <RetaliateIconKeywords:Gegenangriff> in Höhe von [Arg2] % des temporären <RetaliateIconKeywords:Gegenangriff>."
  },
  RelicConfig_71262_Desc = {
    Text = "Zu Rundenbeginn erhält Pandia [Arg1] Aelius. Nachdem Pandia Aelius ausgelöst hat, erhält sie dauerhaften <RetaliateIconKeywords:Gegenangriff> in Höhe von [Arg2] % des temporären <RetaliateIconKeywords:Gegenangriff>."
  },
  RelicConfig_71262_Name = {
    Text = "<OrangeQuality:Dimensionschaft - Pandia>"
  },
  RelicConfig_71263_BattleDesc = {
    Text = "Zu Beginn der Runde erhält Lily [Arg1] Aliemus. Lilys Erdulden-Limit erhöht sich um 100%. Wenn sie \"Blume auf Schleim\" oder \"Schutzschlag\" freisetzt, regeneriert sie 8% des Lebens aus den \"Erdulden\"-Stapel."
  },
  RelicConfig_71263_Desc = {
    Text = "Zu Beginn der Runde erhält Lily [Arg1] Aliemus. Lilys Erdulden-Limit erhöht sich um 100%. Wenn sie \"Blume auf Schleim\" oder \"Schutzschlag\" freisetzt, regeneriert sie 8% des Lebens aus den \"Erdulden\"-Stapel."
  },
  RelicConfig_71263_Name = {
    Text = "<OrangeQuality:Dimensionales Abbild · Lili>"
  },
  RelicConfig_71264_BattleDesc = {
    Text = "Zu Beginn jeder Runde erhält Karen [Arg1] Wahnsinn. Das Ausspielen von “Stille Wache“ gibt doppelt so viel verbrauchte Arithmetica zurück. Abklingzeit: [Arg2] Runden."
  },
  RelicConfig_71264_Desc = {
    Text = "Zu Beginn jeder Runde erhält Karen [Arg1] Wahnsinn. Das Ausspielen von “Stille Wache“ gibt doppelt so viel verbrauchte Arithmetica zurück. Abklingzeit: [Arg2] Runden."
  },
  RelicConfig_71264_Name = {
    Text = "<OrangeQuality:Dimensionales Bildnis · Jalen>"
  },
  RelicConfig_71265_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Salvador [Arg1] Aliemus. Jedes Mal, wenn er den Blutroten Ofen auflädt, erhält er zusätzlich [Arg2]% Stärke. Salvadors “Schlag“ und “Ende des Leidens“ genießen zusätzlich einen [Arg3]-fachen Stärkebonus."
  },
  RelicConfig_71265_Desc = {
    Text = "Zu Rundenbeginn erhält Salvador [Arg1] Aliemus. Jedes Mal, wenn er den Blutroten Ofen auflädt, erhält er zusätzlich [Arg2]% Stärke. Salvadors “Schlag“ und “Ende des Leidens“ genießen zusätzlich einen [Arg3]-fachen Stärke-Bonus."
  },
  RelicConfig_71265_Name = {
    Text = "<OrangeQuality:Dimensionales Hologramm – Salvador>"
  },
  RelicConfig_71266_BattleDesc = {
    Text = "Zu Beginn der Runde erhält Caecus [Arg1] Wahnsinn. Wenn Caecus Schild erhält, werden [Arg2]% der Schildmenge als Leben regeneriert."
  },
  RelicConfig_71266_Desc = {
    Text = "Zu Beginn der Runde erhält Caecus [Arg1] Wahnsinn. Wenn Caecus Schild erhält, werden [Arg2]% der Schildmenge als Leben regeneriert."
  },
  RelicConfig_71266_Name = {
    Text = "<OrangeQuality:Dimensionales Abbild·Kyx>"
  },
  RelicConfig_71267_BattleDesc = {
    Text = "Zu Beginn jeder Runde erhält Nymphaea [Arg1] Aliemus. Nach dem Spielen von Nymphaeas “Schlag“ erhöht sich das von “Nymphaea“ in diesem Kampf verursachte Gift um [Arg2]%, nach dem Spielen von Nymphaeas “VERT“ wird bei allen Feinden [Arg3]% Gift ausgelöst. Maximal einmal pro Runde."
  },
  RelicConfig_71267_Desc = {
    Text = "Zu Beginn jeder Runde erhält Nymphaea [Arg1] Aliemus. Nach dem Spielen von Nymphaeas “Schlag“ erhöht sich das von “Nymphaea“ in diesem Kampf verursachte Gift um [Arg2]%, nach dem Spielen von Nymphaeas “VERT“ wird bei allen Feinden [Arg3]% Gift ausgelöst. Maximal einmal pro Runde."
  },
  RelicConfig_71267_Name = {
    Text = "<OrangeQuality:Dimensionsprojektion · Ning Feiya>"
  },
  RelicConfig_71268_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Erika [Arg1] Wahnsinn. Wenn Erika innerhalb einer Runde [Arg2] Befehlskarten ausspielt, erhält sie 2 Arithmetica-Punkte, und die Stärke- und Wachsamkeitsboni von “Elektromagnetische Explosion“ in diesem Kampf werden um das 1-fache erhöht."
  },
  RelicConfig_71268_Desc = {
    Text = "Zu Rundenbeginn erhält Erika [Arg1] Wahnsinn. Wenn Erika innerhalb einer Runde [Arg2] Befehlskarten ausspielt, erhält sie 2 Arithmetica-Punkte, und die Stärke- und Wachsamkeitsboni von “Elektromagnetische Explosion“ in diesem Kampf werden um das 1-fache erhöht."
  },
  RelicConfig_71268_Name = {
    Text = "<OrangeQuality:Dimensionales Abbild: Erika>"
  },
  RelicConfig_71269_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Goliath [Arg1] Wahnsinn. Wenn Goliath innerhalb einer Runde [Arg2]-mal Schaden verursacht, erhält der von Goliath verursachte Schaden in diesem Kampf zusätzlich einen 1-fachen Machtbonus. Abklingzeit: 3 Runden."
  },
  RelicConfig_71269_Desc = {
    Text = "Zu Rundenbeginn erhält Goliath [Arg1] Wahnsinn. Wenn Goliath innerhalb einer Runde [Arg2]-mal Schaden verursacht, erhält der von Goliath verursachte Schaden in diesem Kampf zusätzlich einen 1-fachen Machtbonus. Abklingzeit: 3 Runden."
  },
  RelicConfig_71269_Name = {
    Text = "<OrangeQuality:Dimensio-Bildnis·Goliath>"
  },
  RelicConfig_71270_BattleDesc = {
    Text = "Zu Beginn der Runde erhält Shan [Arg1] Wahnsinn. Zu Beginn des Kampfes erhält jede Befehlskarte von Shan: Behalten, Vorbereitung 1 und [Arg2] Schild."
  },
  RelicConfig_71270_Desc = {
    Text = "Zu Beginn der Runde erhält Shan [Arg1] Wahnsinn. Zu Beginn des Kampfes erhält jede Befehlskarte von Shan: Behalten, Vorbereitung 1 und [Arg2] Schild."
  },
  RelicConfig_71270_Name = {
    Text = "<OrangeQuality:Dimensionales Bild · Schimmer>"
  },
  RelicConfig_71662_BattleDesc = {
    Text = "Zu Beginn jeder geraden Runde wird 1 <DerivativeCardKeywords_105:„Unendlicher Silberkern-Schatz“> auf die Hand gelegt."
  },
  RelicConfig_71662_Desc = {
    Text = "Zu Beginn jeder geraden Runde wird 1 <DerivativeCardKeywords_105:„Unendlicher Silberkern-Schatz“> auf die Hand gelegt."
  },
  RelicConfig_71662_Name = {
    Text = "<OrangeQuality:Katzenschatz>"
  },
  RelicConfig_72226_BattleDesc = {
    Text = "Maximale Handgröße +1. Zu Beginn des Zuges, falls derzeit keine Forschung durchgeführt wird, wähle eine noch nicht durchgeführte Forschung aus, erhalte nach Abschluss der Forschung das entsprechende Forschungsergebnis von Schmelzen·Doll. Wenn 3 Forschungen abgeschlossen sind, lege “Das Ende der Illusion“ in die Hand, dieses Relikt wird ungültig."
  },
  RelicConfig_72226_Desc = {
    Text = "Maximale Handgröße +1. Zu Beginn des Zuges, falls derzeit keine Forschung durchgeführt wurde, wähle eine nicht durchgeführte Forschung, nach Abschluss der Forschung erhältst du das entsprechende Forschungsergebnis von Schmelzen·Doll. Nach Abschluss von 3 Forschungen wird “Das Ende der Illusion“ in die Hand gelegt, und dieses Relikt wird ungültig."
  },
  RelicConfig_72226_Name = {
    Text = "Endgültiges Forschungsmanuskript"
  },
  RelicConfig_74832_BattleDesc = {
    Text = "Maximale Handgröße +1. Zu Beginn des Zuges erhältst du eine benutzerdefinierte “Tabuhandel“. Nachdem du “Tabuhandel“ gespielt hast, kann es in der nächsten Runde erneut ausgelöst werden. Wenn du “Tabuhandel“ in Hand hast, wird das Spielen von unterschiedlichen Typen von “Befehlskarten“ die entsprechenden Effekte darin aufsteigen."
  },
  RelicConfig_74832_Desc = {
    Text = "Maximale Handgröße +1. Zu Beginn der Runde erhältst du eine benutzerdefinierte “Tabuhandel“. Nach dem Spielen des “Tabuhandels“ kann es in der nächsten Runde erneut ausgelöst werden. Wenn du den “Tabuhandel“ in der Hand hast, wird das Spielen von verschiedenen Arten von “Befehlskarten“ die entsprechenden Effekte aufwerten."
  },
  RelicConfig_74832_Name = {
    Text = "Tausend Gesichter - Einladung"
  },
  RelicConfig_74832_StoryDesc = {
    Text = "Der Text auf dem Brief verändert sich ständig und wird zu einem unwiderstehlichen Verlangen."
  },
  RelicConfig_78664_BattleDesc = {
    Text = "Nachdem du in einer Runde 4 Befehlskarten von unterschiedlichen Erweckern gespielt hast, erhöhen sich die endgültigen Schäden aller Erwecker in dieser Runde um [Arg1]%, wobei sie [Arg2] Punkte Wahnsinn verlieren, maximal 1-mal pro Runde wirksam."
  },
  RelicConfig_78664_Desc = {
    Text = "Nachdem du in einer Runde 4 Befehlskarten von unterschiedlichen Erweckern gespielt hast, erhöhen sich die endgültigen Schäden aller Erwecker in dieser Runde um [Arg1]%, wobei sie [Arg2] Punkte Wahnsinn verlieren, maximal 1-mal pro Runde wirksam."
  },
  RelicConfig_78664_Name = {
    Text = "<RedQuality:Seltsame Klaue>"
  },
  RelicConfig_78664_StoryDesc = {
    Text = "Unidentifizierbare Spezies"
  },
  RelicConfig_78665_BattleDesc = {
    Text = "Zu Rundenbeginn ziehst du [Arg1] Karten weniger. Für jede gespielte Karte mit einem tatsächlichen Arithmetica-Verbrauch von mindestens [Arg2] erhältst du 1 Punkt Arithmetica, maximal [Arg3] Mal pro Runde."
  },
  RelicConfig_78665_Desc = {
    Text = "Zu Rundenbeginn ziehst du [Arg1] Karten weniger. Für jede gespielte Karte mit einem tatsächlichen Arithmetica-Verbrauch von mindestens [Arg2] erhältst du 1 Punkt Arithmetica, maximal [Arg3] Mal pro Runde."
  },
  RelicConfig_78665_Name = {
    Text = "<RedQuality:Heulende Glocke>"
  },
  RelicConfig_78665_StoryDesc = {
    Text = "Ding Ling, Ding Ling, das Kind weint;\nDing Ling, Ding Ling, das Kind schreit.\nDing Ling, Ding Ling, das Kind jammert;\nDing Ling, Ding Ling, es hat Hunger, du weißt es"
  },
  RelicConfig_78666_BattleDesc = {
    Text = "Zu Rundenbeginn erhältst du [Arg1] Punkte Gegenangriff. Nach [Arg2]-maligem Auslösen von Verherrlichung in einer Runde entfernst du [Arg3]% deines permanenten Gegenangriffs und erhältst vorübergehend [Arg4]% der entfernten Menge als Gegenangriff, mit einer Abklingzeit von [Arg5] Runden."
  },
  RelicConfig_78666_Desc = {
    Text = "Zu Rundenbeginn erhältst du [Arg1] Punkte Gegenangriff. Nach dem Freigeben von [Arg2] Verherrlichungen in einer Runde entferne dir [Arg3]% dauerhaften Gegenangriff und erhalte [Arg4]% temporären Gegenangriff basierend auf der Menge, Abklingzeit: [Arg5] Runden."
  },
  RelicConfig_78666_Name = {
    Text = "<RedQuality:Knochen des Pfades>"
  },
  RelicConfig_78666_StoryDesc = {
    Text = "Ein heiliger Teil.\nTrotz der Trennung vom Körper sind seine Spuren überall"
  },
  RelicConfig_78667_BattleDesc = {
    Text = "Nach der Ziehphase zusätzlich [Arg1] Karten ziehen und [Arg2] Handkarten auswählen und abzuwerfen."
  },
  RelicConfig_78667_Desc = {
    Text = "Nach der Ziehphase zusätzlich [Arg1] Karten ziehen und [Arg2] Handkarten auswählen und abzuwerfen."
  },
  RelicConfig_78667_Name = {
    Text = "<RedQuality: Zauberhut>"
  },
  RelicConfig_78667_StoryDesc = {
    Text = "Willkommen im Wunderland-Zirkus von Fräulein Casiah! Sei vorsichtig und berühre die Zauberutensilien nicht einfach so. Wenn du dich nicht aufpasst und gebissen wirst, wird das schlimm. \n Schließlich war das letzte Mal, als es Blut schmeckte, die Folge sehr schrecklich. \n\n Der Zylinder zwinkerte, als ob er jederzeit aus seinem Kokon schlüpfen könnte."
  },
  RelicConfig_78668_BattleDesc = {
    Text = "Nach dem Keyflare-Erwecken wähle [Arg1] nicht abgeleitete Befehlskarte des entsprechenden Erweckers in deiner Hand. Erschöpfe diese Karte, um jeweils [Arg2] Basiskopie davon in den Ziehstapel, die Hand und den Ablagestapel zu legen."
  },
  RelicConfig_78668_Desc = {
    Text = "Nach dem Keyflare-Erwecken wähle [Arg1] nicht abgeleitete Befehlskarte des entsprechenden Erweckers in deiner Hand. Erschöpfe diese Karte, um jeweils [Arg2] Basiskopie davon in den Ziehstapel, die Hand und den Ablagestapel zu legen."
  },
  RelicConfig_78668_Name = {
    Text = "<RedQuality:Jadeabdruck>"
  },
  RelicConfig_78668_StoryDesc = {
    Text = "Dieser Abdruck ist tausend Jahre unvergänglich"
  },
  RelicConfig_78669_BattleDesc = {
    Text = "Beim Kampfbeginn erhältst du [Arg1] Stärke. Zu Beginn jeder Runde erhältst du für je [Arg2] Punkte permanente Stärke [Arg3] Punkte temporäre Stärke, maximal [Arg4] Punkte temporäre Stärke, und am Rundenende verlierst du die Hälfte des Schildes, die durch dieses Relikt erhaltene temporäre Stärke gewährt."
  },
  RelicConfig_78669_Desc = {
    Text = "Beim Kampfbeginn erhältst du [Arg1] Stärke. Zu Beginn jeder Runde erhältst du für je [Arg2] permanente Stärke [Arg3] temporäre Stärke, maximal [Arg4] temporäre Stärke, und am Ende der Runde verlierst du die Hälfte des Schildes, die du durch dieses Relikt an temporärer Stärke erhalten hast."
  },
  RelicConfig_78669_Name = {
    Text = "<RedQuality:Unglücksvogel>"
  },
  RelicConfig_78669_StoryDesc = {
    Text = "Der ausgetrocknete Körper stieß einen Schrei aus"
  },
  RelicConfig_78670_BattleDesc = {
    Text = "Alle Erwecker erhöhen den Basisschaden um [Arg1]%. Zusätzlich steigt der Wert bei jeder Neumischung des Kartenstapels um [Arg2]%, wobei jedoch eine Karte “Taumeln“ auf die Hand genommen wird. Die maximale Erhöhung beträgt [Arg3]%."
  },
  RelicConfig_78670_Desc = {
    Text = "Alle Erwecker erhöhen den Basisschaden um [Arg1]%. Zusätzlich steigt der Wert bei jeder Neumischung des Kartenstapels um [Arg2]%, wobei jedoch eine Karte “Taumeln“ auf die Hand genommen wird. Die maximale Erhöhung beträgt [Arg3]%."
  },
  RelicConfig_78670_Name = {
    Text = "<RedQuality:Schwarze Kerze>"
  },
  RelicConfig_78670_StoryDesc = {
    Text = "Brennende Klarheit, in Illusionen fallen"
  },
  RelicConfig_78671_BattleDesc = {
    Text = "Zu Rundenbeginn erhöht sich der Embryo-Fusionsgrad um [Arg1] %. Dein „Embryo\" wird am Ende der Runde abgeworfen."
  },
  RelicConfig_78671_Desc = {
    Text = "Zu Rundenbeginn erhöht sich der Embryo-Fusionsgrad um [Arg1] %. Dein „Embryo\" wird am Ende der Runde abgeworfen."
  },
  RelicConfig_78671_Name = {
    Text = "<RedQuality:Wimmelnde Nabelschnur>"
  },
  RelicConfig_78671_StoryDesc = {
    Text = "Um den Hals gewickelt"
  },
  RelicConfig_78672_BattleDesc = {
    Text = "Zu Beginn der Runde erleidet ihr [Arg2] Schichten Vergiftung und erhaltet für jeden leeren Platz im Hyperraum [Arg1] Punkte Stärke."
  },
  RelicConfig_78672_Desc = {
    Text = "Zu Beginn der Runde erleidet ihr [Arg2] Schichten Vergiftung und erhaltet für jeden leeren Platz im Hyperraum [Arg1] Punkte Stärke."
  },
  RelicConfig_78672_Name = {
    Text = "<RedQuality:Schwarmbewusstsein>"
  },
  RelicConfig_78672_StoryDesc = {
    Text = "Verflechten, symbiotisch, gruppieren; Angst, Unbekanntes, Kontrolle"
  },
  RelicConfig_78673_BattleDesc = {
    Text = "Nach der Silberschlüsselerweckung zusätzlich [Arg1] Punkte Silber-Schlüssel-Energie verbrauchen, um den Arithmetica-Verbrauch der erhaltenen Erleuchtung-des-Wissens-Karte auf 0 zu reduzieren; nach dem Ausspielen erhält der entsprechende Erwachte zusätzlich [Arg2] Punkte Wahnsinn."
  },
  RelicConfig_78673_Desc = {
    Text = "Nach der Silberschlüsselerweckung zusätzlich [Arg1] Punkte Silber-Schlüssel-Energie verbrauchen, um den Arithmetica-Verbrauch der erhaltenen Erleuchtung-des-Wissens-Karte auf 0 zu reduzieren; nach dem Ausspielen erhält der entsprechende Erwachte zusätzlich [Arg2] Punkte Wahnsinn."
  },
  RelicConfig_78673_Name = {
    Text = "<RedQuality:Bewusstseinsgravur>"
  },
  RelicConfig_78673_StoryDesc = {
    Text = "Der alte Stamm glaubte, dass das Einritzen spezieller Symbole auf den Schädel eines Toten seine Seele für immer bei ihnen halten würde"
  },
  RelicConfig_78674_BattleDesc = {
    Text = "Beim Kampfbeginn [Arg1] Gift auf alle Gegner auslösen. Zu Beginn der Runde [Arg2]% des Gifts des Gegners entfernen und [Arg3]% der entfernten Menge als Bluten auferlegen."
  },
  RelicConfig_78674_Desc = {
    Text = "Beim Kampfbeginn [Arg1] Gift auf alle Gegner auslösen. Zu Beginn der Runde [Arg2]% des Gifts des Gegners entfernen und [Arg3]% der entfernten Menge als Bluten auferlegen."
  },
  RelicConfig_78674_Name = {
    Text = "<RedQuality:Glied der Erlösung>"
  },
  RelicConfig_78674_StoryDesc = {
    Text = "Ein heiliger Teil.\nTrotz der Trennung vom Körper strahlt er noch Wärme aus"
  },
  RelicConfig_78675_BattleDesc = {
    Text = "Zu Beginn der Runde: Wenn mehr als [Arg1] permanente Tentakel vorhanden sind, verliere [Arg2] Tentakel und erhalte [Arg3] temporäre Tentakel. Andernfalls erhältst du [Arg4] permanente Tentakel."
  },
  RelicConfig_78675_Desc = {
    Text = "Zu Beginn der Runde: Wenn mehr als [Arg1] permanente Tentakel vorhanden sind, verliere [Arg2] Tentakel und erhalte [Arg3] temporäre Tentakel. Andernfalls erhältst du [Arg4] permanente Tentakel."
  },
  RelicConfig_78675_Name = {
    Text = "<RedQuality:Heiliger Schmerzarm>"
  },
  RelicConfig_78675_StoryDesc = {
    Text = "Genieße den Schmerz"
  },
  RelicConfig_79408_BattleDesc = {
    Text = "Maximale Handgröße +2, Ziehen +2. “Klare Erinnerung“ beginnt mit 5 Stufen; das Spielen von markierten Karten verändert “Klare Erinnerung“. Wenn “Klare Erinnerung“ unter 5 liegt, erhöht sich der Gesamtschaden um 10% für jeden Punkt, während der Schild und die Lebenspunkte um 5% verringert werden; wenn “Klare Erinnerung“ über 5 liegt, erhöht sich der Schild und die Lebenspunkte um 5% für jeden Punkt, während der Gesamtschaden um 10% verringert wird."
  },
  RelicConfig_79408_Desc = {
    Text = "Maximale Handgröße +2, Ziehen +2. “Klare Erinnerung“ beginnt mit 5 Schichten. Das Ausspielen von markierten Karten verändert “Klare Erinnerung“. Wenn “Klare Erinnerung“ unter 5 liegt, erhöht sich der Gesamtschaden um 10 % für jeden Punkt unter 5, während der Schild und die Lebenspunkte-Antworten um 5 % sinken; wenn “Klare Erinnerung“ über 5 liegt, erhöht sich der Schild und die Lebenspunkte-Antworten um 5 % für jeden Punkt über 5, während der Gesamtschaden um 10 % sinkt."
  },
  RelicConfig_79408_Name = {
    Text = "“Speicher“ und “Traum“"
  },
  RelicConfig_79408_StoryDesc = {
    Text = "“Komm, hör mir zu.“\n“Lass mich deine Erinnerungen und Träume.“\n“zu einem unübertroffenen köstlichen Dessert herstellen.“"
  },
  RelicConfig_80340_BattleDesc = {
    Text = "Zu Beginn der Runde erhält Clementine [Arg1] Wahnsinn. Die Anzahl der Effekte ihrer Befehlskarten – Schaden, Schild, Heilung, Wahnsinns- und S-Energiegewinn – erhöht sich um 1."
  },
  RelicConfig_80340_Desc = {
    Text = "Zu Beginn der Runde erhält Clementine [Arg1] Wahnsinn. Die Anzahl der Effekte ihrer Befehlskarten – Schaden, Schild, Heilung, Wahnsinns- und S-Energiegewinn – erhöht sich um 1."
  },
  RelicConfig_80340_Name = {
    Text = "<OrangeQuality:Dimensionenbildnis · Clementine>"
  },
  RelicConfig_83509_BattleDesc = {
    Text = "Bei Beginn der Erkundung erhöht sich das Relikt-Limit um 1. Die “Tiefsee“-Reichs-Erwecker erhalten ihr “Dimensionsabbild“. Für jeden “Tiefsee“-Reichs-Erwecker im Team erhöht sich das Relikt-Limit um 1."
  },
  RelicConfig_83509_Desc = {
    Text = "Bei Beginn der Erkundung erhöht sich das Relikt-Limit um 1. Die “Tiefsee“-Reichs-Erwecker erhalten ihr “Dimensionsabbild“. Für jeden “Tiefsee“-Reichs-Erwecker im Team erhöht sich das Relikt-Limit um 1."
  },
  RelicConfig_83509_Name = {
    Text = "<OrangeQuality:“Tiefsee-Ring“>"
  },
  RelicConfig_83509_StoryDesc = {
    Text = "“Es hat die Geschichte verändert.“"
  },
  RelicConfig_83510_BattleDesc = {
    Text = "Bei Beginn der Erkundung erhöht sich das Relikt-Limit um 1. Die “Fleisch“-Reichs-Erwecker erhalten ihr “Dimensionenbild“. Für jeden “Fleisch“-Reichs-Erwecker im Team erhöht sich das Relikt-Limit um 1."
  },
  RelicConfig_83510_Desc = {
    Text = "Bei Beginn der Erkundung erhöht sich das Relikt-Limit um 1. Die “Fleisch“-Reichs-Erwecker erhalten ihr “Dimensionenbild“. Für jeden “Fleisch“-Reichs-Erwecker im Team erhöht sich das Relikt-Limit um 1."
  },
  RelicConfig_83510_Name = {
    Text = "<OrangeQuality:“Blut-und-Fleisch-Ring“>"
  },
  RelicConfig_83510_StoryDesc = {
    Text = "Nie schwach, bereits aufgestiegen."
  },
  RelicConfig_83511_BattleDesc = {
    Text = "Bei Beginn der Erkundung erhöht sich das Relikt-Limit um 1. Die „Überdimensional“-Reichs-Erwecker erhalten ihr „Dimensionenbild“. Für jeden „Überdimensional“-Reichs-Erwecker im Team erhöht sich das Relikt-Limit um 1."
  },
  RelicConfig_83511_Desc = {
    Text = "Bei Beginn der Erkundung erhöht sich das Relikt-Limit um 1. Die „Überdimensional“-Reichs-Erwecker erhalten ihr „Dimensionenbild“. Für jeden „Überdimensional“-Reichs-Erwecker im Team erhöht sich das Relikt-Limit um 1."
  },
  RelicConfig_83511_Name = {
    Text = "<OrangeQuality:“Hyperdimensionaler Ring“>"
  },
  RelicConfig_83511_StoryDesc = {
    Text = "Unendliche Dimensionen überlagern sich, in diesem Moment bin ich unendlich vollständig."
  },
  RelicConfig_83512_BattleDesc = {
    Text = "Bei Beginn der Erkundung erhöht sich das Relikt-Limit um 1. Die „Chaos“-Reichs-Erwecker erhalten ihr „Dimensionenbild“. Für jeden „Chaos“-Reichs-Erwecker im Team erhöht sich das Relikt-Limit um 1."
  },
  RelicConfig_83512_Desc = {
    Text = "Bei Beginn der Erkundung erhöht sich das Relikt-Limit um 1. Die „Chaos“-Reichs-Erwecker erhalten ihr „Dimensionenbild“. Für jeden „Chaos“-Reichs-Erwecker im Team erhöht sich das Relikt-Limit um 1."
  },
  RelicConfig_83512_Name = {
    Text = "<OrangeQuality:“Chaos-Finger“>"
  },
  RelicConfig_83512_StoryDesc = {
    Text = "Chaos ist formlos, Chaos ist substanzlos, Chaos ist bereits mit allem verschmolzen."
  },
  RelicConfig_83606_BattleDesc = {
    Text = "Maximale Handgröße +1. Zu Beginn des Zuges, falls keine “Entscheidung des Navigators“ vorhanden ist, lege sie in die Hand. \n Jedes Mal, wenn der Anführer 10 % seiner ursprünglichen maximalen LP verliert, erhalte 1 Schicht “Setze Segel“, Begrenzung auf 10 Schichten, “Setze Segel“ kann den Effekt von “Anker abwerfen“ verstärken. \n Jedes Mal, wenn du 10 % deiner ursprünglichen maximalen LP verlierst, erhalte 1 Schicht “Anker werfen“, Begrenzung auf 10 Schichten, “Anker werfen“ kann den Effekt von “Hafenruhe“ verstärken."
  },
  RelicConfig_83606_Desc = {
    Text = "Maximale Handgröße +1. Zu Beginn des Zuges, falls keine “Entscheidung des Navigators“ vorhanden ist, lege sie in die Hand. \n Jedes Mal, wenn der Anführer 10% seiner maximalen Lebenspunkte verliert, erhalte 1 Schicht “Setze Segel“, maximal 10 Schichten. “Setze Segel“ kann den Effekt von “Anker abwerfen“ verstärken. \n Jedes Mal, wenn du 10% deiner maximalen Lebenspunkte verlierst, erhalte 1 Schicht “Anker werfen“, maximal 10 Schichten. “Anker werfen“ kann den Effekt von “Hafenruhe“ verstärken."
  },
  RelicConfig_83606_Name = {
    Text = "Erasmus' Anleitung"
  },
  RelicConfig_83606_StoryDesc = {
    Text = "Der blitzende Donner wird den Weg weisen."
  },
  RelicConfig_84112_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Agrippa [Arg1] Wahnsinn. „Ungeduldige Almosen“ reduzieren zudem Agrippas Arithmetica-Verbrauch in dieser Runde um [Arg2]. Dieser Effekt kann pro Runde nur einmal wirken."
  },
  RelicConfig_84112_Desc = {
    Text = "Zu Rundenbeginn erhält Agrippa [Arg1] Wahnsinn. „Ungeduldige Almosen“ reduzieren zudem Agrippas Arithmetica-Verbrauch in dieser Runde um [Arg2]. Dieser Effekt kann pro Runde nur einmal wirken."
  },
  RelicConfig_84112_Name = {
    Text = "<OrangeQuality:Dimensionales Hologramm - Agrippa>"
  },
  RelicConfig_84113_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Caraboo [Arg1] Aliemus. Caraboos „Segen“-Karten bieten beim <FaxianKeywords:Entdecken> 1 zusätzliche Option. Caraboos Verherrlichung verursacht Korrosions-Stapelungen in Höhe des zugefügten Schadens."
  },
  RelicConfig_84113_Desc = {
    Text = "Zu Rundenbeginn erhält Caraboo [Arg1] Aliemus. Caraboos „Segen“-Karten bieten beim <FaxianKeywords:Entdecken> 1 zusätzliche Option. Caraboos Verherrlichung verursacht Korrosions-Stapelungen in Höhe des zugefügten Schadens."
  },
  RelicConfig_84113_Name = {
    Text = "<OrangeQuality:Dimensionsbild: Caraboo>"
  },
  RelicConfig_84114_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Pickman [Arg1] Wahnsinn. Für jede Schicht “Kreativität“, die er erhält, senkt sich zufällig die Arithmetica-Kosten einer Handkarte in dieser Runde um 1. Wenn Pickman “Kreativität“ ausgibt, erhalten alle Erwecker zusätzlich [Arg2] Punkte Wahnsinn."
  },
  RelicConfig_84114_Desc = {
    Text = "Zu Rundenbeginn erhält Pickman [Arg1] Wahnsinn. Für jede Schicht “Kreativität“, die er erhält, senkt sich zufällig die Arithmetica-Kosten einer Handkarte in dieser Runde um 1. Wenn Pickman “Kreativität“ ausgibt, erhalten alle Erwecker zusätzlich [Arg2] Punkte Wahnsinn."
  },
  RelicConfig_84114_Name = {
    Text = "<OrangeQuality:Dimensionales Abbild · Pikeman>"
  },
  RelicConfig_84116_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Erika [Arg1] Wahnsinn. Wenn Erika innerhalb einer Runde [Arg2] Befehlskarten ausspielt, erhält sie 2 Arithmetica-Punkte, und die Stärke- und Wachsamkeitsboni von “Elektromagnetische Explosion“ in diesem Kampf werden um das 1-fache erhöht."
  },
  RelicConfig_84116_Desc = {
    Text = "Zu Rundenbeginn erhält Erika [Arg1] Wahnsinn. Wenn Erika innerhalb einer Runde [Arg2] Befehlskarten ausspielt, erhält sie 2 Arithmetica-Punkte, und die Stärke- und Wachsamkeitsboni von “Elektromagnetische Explosion“ in diesem Kampf werden um das 1-fache erhöht."
  },
  RelicConfig_84116_Name = {
    Text = "<OrangeQuality:Dimensionales Abbild: Erika>"
  },
  RelicConfig_84117_BattleDesc = {
    Text = "Zu Beginn der Runde erhält Murphy: fauxborn [Arg1] Wahnsinn. \"Spiral Waltz\" aktiviert 3 Mal bei jeder 3. Freisetzung."
  },
  RelicConfig_84117_Desc = {
    Text = "Zu Beginn der Runde erhält Murphy: fauxborn [Arg1] Wahnsinn. \"Spiral Waltz\" aktiviert 3 Mal bei jeder 3. Freisetzung."
  },
  RelicConfig_84117_Name = {
    Text = "<OrangeQuality:Dimensionales Bild · Schimmer>"
  },
  RelicConfig_84118_BattleDesc = {
    Text = "Zu Beginn jeder Runde erhält Casiah [Arg1] Wahnsinn. Für jede gezogene Karte erhält Casiah zusätzlich [Arg2] Wahnsinn. Wenn Casiah ihre Wahnsinnsexplosion aktiviert, verlieren alle Feinde [Arg3] Stärkepunkte."
  },
  RelicConfig_84118_Desc = {
    Text = "Zu Beginn jeder Runde erhält Casiah [Arg1] Wahnsinn. Für jede gezogene Karte erhält Casiah zusätzlich [Arg2] Wahnsinn. Wenn Casiah ihre Wahnsinnsexplosion aktiviert, verlieren alle Feinde [Arg3] Stärkepunkte."
  },
  RelicConfig_84118_Name = {
    Text = "<OrangeQuality:Dimensionales Abbild – Cassia>"
  },
  RelicConfig_84119_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Murphy [Arg1] Wahnsinn. Murphys „Schlag“ und „VERT“ können [Arg2]% des „Opfers“ in temporären Tentakelschaden umwandeln, jedoch maximal einmal pro Runde wirksam."
  },
  RelicConfig_84119_Desc = {
    Text = "Zu Rundenbeginn erhält Murphy [Arg1] Wahnsinn. Murphys „Schlag“ und „VERT“ können [Arg2]% des „Opfers“ in temporären Tentakelschaden umwandeln, jedoch maximal einmal pro Runde wirksam."
  },
  RelicConfig_84119_Name = {
    Text = "<OrangeQuality:Dimensionales Echo · Murphy>"
  },
  RelicConfig_84121_BattleDesc = {
    Text = "Arachne erhält zu Rundenbeginn [Arg1] Aliemus. „Schlag\" und „Verteidigung\" lösen sofort Verfolgung: „Endlose Fäden\" einmal aus, wobei jede maximal einmal pro Runde wirkt."
  },
  RelicConfig_84121_Desc = {
    Text = "Arachne erhält zu Rundenbeginn [Arg1] Aliemus. „Schlag\" und „Verteidigung\" lösen sofort Verfolgung: „Endlose Fäden\" einmal aus, wobei jede maximal einmal pro Runde wirkt."
  },
  RelicConfig_84121_Name = {
    Text = "<OrangeQuality:Dimensionsbild·Arachne>"
  },
  RelicConfig_84122_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Tulu [Arg1] Wahnsinn. Tulus Wahnsinnsverbrauch wird um [Arg2] reduziert. Nach der Auslösung von Exaltieren werden sofort [Arg3] temporäre Tentakel erzeugt."
  },
  RelicConfig_84122_Desc = {
    Text = "Zu Rundenbeginn erhält Tulu [Arg1] Wahnsinn. Tulus Wahnsinnsverbrauch wird um [Arg2] reduziert. Nach der Auslösung von Exaltieren werden sofort [Arg3] temporäre Tentakel erzeugt."
  },
  RelicConfig_84122_Name = {
    Text = "<OrangeQuality:Dimensionales Abbild · Tulu>"
  },
  RelicConfig_84123_BattleDesc = {
    Text = "Zu Beginn der Runde erhält Pollux [Arg1] aliemus. Zu Beginn des Kampfes erhalte 1 \"Heiliges Herz\", das \"Heilige Herz\" macht alle Gegner beim 3. Spielverbrauch verwundbar und verursacht 2-mal Schaden."
  },
  RelicConfig_84123_Desc = {
    Text = "Zu Beginn der Runde erhält Pollux [Arg1] aliemus. Zu Beginn des Kampfes erhalte 1 \"Heiliges Herz\", das \"Heilige Herz\" macht alle Gegner beim 3. Spielverbrauch verwundbar und verursacht 2-mal Schaden."
  },
  RelicConfig_84123_Name = {
    Text = "<OrangeQuality:Dimensionsabbildung · Horla>"
  },
  RelicConfig_84124_BattleDesc = {
    Text = "Am Beginn des Zuges erhält Hamlyn [Arg1] Wahnsinn. Die Ressourcenkosten der “Seelenouvertüre“ werden um [Arg2] reduziert und die Basisanzahl an Schadensintervallen erhöht sich um [Arg3]."
  },
  RelicConfig_84124_Desc = {
    Text = "Am Beginn des Zuges erhält Hamlyn [Arg1] Wahnsinn. Die Ressourcenkosten der “Seelenouvertüre“ werden um [Arg2] reduziert und die Basisanzahl an Schadensintervallen erhöht sich um [Arg3]."
  },
  RelicConfig_84124_Name = {
    Text = "<OrangeQuality:Dimensionales Abbild · Hamlin>"
  },
  RelicConfig_84125_BattleDesc = {
    Text = "Zu Beginn der Runde erhält Katyusha [Arg1] Punkte Aliemus. Nach dem kumulativen Verbrauch von 10 Stapelungen „Lebendige Flamme\" ziehe sofort 1 Befehlskarte von Katyusha und gewähre ihr 3 Stapelungen „Lebendige Flamme\", in dieser Runde werden keine weiteren Stapelungen kumuliert."
  },
  RelicConfig_84125_Desc = {
    Text = "Zu Beginn der Runde erhält Katyusha [Arg1] Punkte Aliemus. Nach dem kumulativen Verbrauch von 10 Stapelungen „Lebendige Flamme\" ziehe sofort 1 Befehlskarte von Katyusha und gewähre ihr 3 Stapelungen „Lebendige Flamme\", in dieser Runde werden keine weiteren Stapelungen kumuliert."
  },
  RelicConfig_84125_Name = {
    Text = "<OrangeQuality:Dimensionales Abbild · Hamlin>"
  },
  RelicConfig_84126_BattleDesc = {
    Text = "Zu Beginn der Runde erhält Castor [Arg1] Wahnsinn. Zu Beginn des Kampfes erhält man 2 „Schwarze Feder“-Karten auf die Hand. Beim ersten Ausspielen einer „Schwarze Feder“-Karte pro Runde erhält man [Arg2] temporäre Stärkepunkte."
  },
  RelicConfig_84126_Desc = {
    Text = "Zu Beginn der Runde erhält Castor [Arg1] Wahnsinn. Zu Beginn des Kampfes erhält man 2 „Schwarze Feder“-Karten auf die Hand. Beim ersten Ausspielen einer „Schwarze Feder“-Karte pro Runde erhält man [Arg2] temporäre Stärkepunkte."
  },
  RelicConfig_84126_Name = {
    Text = "<OrangeQuality:Dimensionsbild·Castor>"
  },
  RelicConfig_84127_BattleDesc = {
    Text = "Zu Beginn der Runde erhält Corposant [Arg1] Aliemus und erhält 1 vorübergehenden Tentakel. Jedes Mal, wenn der Todwiderstand ausgelöst wird, erhält Corposant [Arg2] Punkte Aliemus und fügt eine “Bestrafung“ mit Arithmetica-Kosten von 0 und zusätzlichen Kosten in die Hand hinzu."
  },
  RelicConfig_84127_Desc = {
    Text = "Zu Beginn der Runde erhält Corposant [Arg1] Aliemus und erhält 1 vorübergehenden Tentakel. Jedes Mal, wenn der Todwiderstand ausgelöst wird, erhält Corposant [Arg2] Punkte Aliemus und fügt 1 Karte mit Arithmetica-Kosten von 0 und zusätzlichen Kosten namens “Blitzvergeltung“ seiner Hand hinzu."
  },
  RelicConfig_84127_Name = {
    Text = "<OrangeQuality:Dimensionsprojektion·Kepersant>"
  },
  RelicConfig_89252_BattleDesc = {
    Text = "Die Arithmetica-Grenze erhöht sich um 1, die Anzahl der gezogenen Karten pro Runde erhöht sich um 1, und zu Beginn des Kampfes erhält man [Arg1] Schichten “Schicksalsgefängnis“-Zähler. \n Jede Schicht “Schicksalsgefängnis“ verringert den Wahnsinn, der von allen Erweckern erzeugt wird, um [Arg2]%, und bei jeder Auslösung der Verherrlichung wird 1 Schicht “Schicksalsgefängnis“ reduziert. Nachdem alle “Schicksalsgefängnisse“ entfernt wurden, erhalten alle Erwecker [Arg3] Punkte Aliemus und erhalten “Unnachgiebiges Herz“: Der Wahnsinn, der von allen Erweckern erzeugt wird, erhöht sich um [Arg4]%, und jede Runde kann die Verherrlichung 2 Mal ausgelöst werden."
  },
  RelicConfig_89252_Desc = {
    Text = "Die Arithmetica-Grenze erhöht sich um 1, die Anzahl der zu ziehenden Karten pro Runde erhöht sich um 1, zu Beginn des Kampfes erhält man [Arg1] Schichten “Schicksalsfalle“. \n Jede Schicht “Schicksalsfalle“ reduziert den erzeugten Wahnsinn aller Erwecker um [Arg2]%. Bei jeder Auslösung der Wahnsinnsexplosion wird 1 Schicht “Schicksalsfalle“ entfernt. Nachdem alle “Schicksalsfallen“ entfernt wurden, erhalten alle Erwecker [Arg3] Punkte Aliemus und erhalten “Unnachgiebiges Herz“: Der erzeugte Wahnsinn aller Erwecker erhöht sich um [Arg4]%, und es können pro Runde 2 Wahnsinnsexplosionen ausgelöst werden."
  },
  RelicConfig_89252_Name = {
    Text = "Verfluchtes Feder"
  },
  RelicConfig_89252_StoryDesc = {
    Text = "Diese Feder kann nun nicht mehr hoch am Himmel fliegen."
  },
  RelicConfig_89645_BattleDesc = {
    Text = "Maximale Handgröße +2, nach der Freigabe der Verherrlichung wird der temporäre Gesamtschaden um 10 % erhöht. \n Wenn eine Karte in den Hyperraum geht, wird 1 “Embryo“ in der Hand in “Nachkomme der Reinheit“ umgewandelt. \n Für jedes erzeugte “Embryo“ wird die Arithmetica-Kosten einer zufälligen Karte im Hyperraum um 1 gesenkt."
  },
  RelicConfig_89645_Desc = {
    Text = "Maximale Handgröße +2, nach der Freigabe der Verherrlichung wird der temporäre Gesamtschaden um 10 % erhöht. \n Wenn eine Karte in den Hyperraum geht, wird 1 “Embryo“ in der Hand in “Nachkomme der Reinheit“ umgewandelt. \n Für jedes erzeugte “Embryo“ wird die Arithmetica-Kosten einer zufälligen Karte im Hyperraum um 1 gesenkt."
  },
  RelicConfig_89645_Name = {
    Text = "Superstring-Verrottungsblut-Trank"
  },
  RelicConfig_89646_BattleDesc = {
    Text = "Erhalte zu Rundenbeginn 250 Schlüsselstrahlen.\nNachdem du Schlüsselstrahlen geweckt hast, lege 1 <DerivativeCardKeywords_129:\"Silberner Schlüssel: Glanz\"> auf die Hand.\nEntdecke zu Rundenbeginn 1 Unterstützungs-Karte für Erwecker."
  },
  RelicConfig_89646_Desc = {
    Text = "Erhalte zu Rundenbeginn 250 Schlüsselstrahlen.\nNachdem du Schlüsselstrahlen geweckt hast, lege 1 <DerivativeCardKeywords_129:\"Silberner Schlüssel: Glanz\"> auf die Hand.\nEntdecke zu Rundenbeginn 1 Unterstützungs-Karte für Erwecker."
  },
  RelicConfig_89646_Name = {
    Text = "Integral entwickelter Trank"
  },
  RelicConfig_89647_BattleDesc = {
    Text = "Die erste Befehlskarte jeder Runde wird einmal zusätzlich wirksam. \n Bei Vernichtung wird 1 Tentakel erzeugt. \n Nachdem der Tentakel in die Haltung “Tobende Wellen“ gewechselt ist, löst der Sprungeffekt der nächsten Befehlskarte in dieser Runde garantiert aus und fügt 2 Basiskopien in den Hyperraum ein. Abkühlung: 3 Runden."
  },
  RelicConfig_89647_Desc = {
    Text = "Die erste Befehlskarte jeder Runde wird einmal zusätzlich wirksam. \n Bei Vernichtung wird 1 Tentakel erzeugt. \n Nachdem der Tentakel in die Haltung “Tobende Wellen“ gewechselt ist, löst der Sprungeffekt einer Befehlskarte in dieser Runde automatisch aus und fügt 2 Basiskopien in den Hyperraum ein, Abkühlung: 3 Runden."
  },
  RelicConfig_89647_Name = {
    Text = "Übergeordnetes Tiefsee-Präparat"
  },
  RelicConfig_89648_BattleDesc = {
    Text = "Reichsbeherrschung erhöht um 200 Punkte. \nBeim Verbrauch des Purpurnen Ofens wird der Tentakelschaden um 15 % des verbrauchten Betrags erhöht. \nBei jedem Tentakelangriff werden [Arg3] Punkte Purpurner Ofen angesammelt."
  },
  RelicConfig_89648_Desc = {
    Text = "Reichsbeherrschung erhöht um 200 Punkte. \nBeim Verbrauch des Purpurnen Ofens wird der Tentakelschaden um 15 % des verbrauchten Betrags erhöht. \nBei jedem Tentakelangriff werden [Arg3] Punkte Purpurner Ofen angesammelt."
  },
  RelicConfig_89648_Name = {
    Text = "Verfaultes Tiefsee-Serum"
  },
  RelicConfig_91096_BattleDesc = {
    Text = "Zu Rundenbeginn erhalten beide Seiten eine Schicht <Kuangre:Wahnsinn>, jede Schicht <Kuangre:Wahnsinn> fügt dem aktiven und Tentakelschaden 10 % des Schadens als <BleedingIconKeywords:Bluten> hinzu.\n Für jeden 20 % Schaden am Lebenspunkt des Anführers erhalten alle Erwecker 10 Wahnsinn.\n Zu Beginn des Kampfes werden <DerivativeCardKeywords_108:“Nachkommen inspirieren“> und <DerivativeCardKeywords_109:“Nachkommen schützen“> in den Ziehstapel gemischt."
  },
  RelicConfig_91096_Desc = {
    Text = "Zu Rundenbeginn erhält jede Seite eine Schicht <Kuangre:Fanatismus>, jede Schicht <Kuangre:Fanatismus> fügt dem aktiven und Tentakelschaden 10 % des Schadens als <BleedingIconKeywords:Bluten> hinzu.\nFür jeden 20 % Schaden am Lebenspunkt des Anführers erhalten alle Erwecker 10 Wahnsinn.\nZu Beginn des Kampfes werden <DerivativeCardKeywords_108:“Nachkommen inspirieren“> und <DerivativeCardKeywords_109:“Nachkommen schützen“> in den Ziehstapel gemischt."
  },
  RelicConfig_91096_Name = {Text = "Blasses Ei"},
  RelicConfig_91096_StoryDesc = {
    Text = [[
Anstacheln zur Geburt des Sohnes des Erblassens. 
 Vorsicht, sie kommen gleich.]]
  },
  RelicConfig_94695_BattleDesc = {
    Text = "Wenn ein Erwecker getötet wird, erhält jeder andere Verbündete [Arg1] Amplifikation. Dieser Effekt kann nur einmal pro Erwecker ausgelöst werden."
  },
  RelicConfig_94695_Desc = {
    Text = "Wenn ein Erwecker getötet wird, erhöht er die Amplifikation für andere Verbündete um [Arg1]. Dieser Effekt kann nur einmal pro Erwecker ausgelöst werden."
  },
  RelicConfig_94695_Name = {
    Text = "<OrangeQuality:Asche des brennenden Schwarzen Sterns>"
  },
  RelicConfig_94696_BattleDesc = {
    Text = "Nachdem der Kampf begonnen hat, lege [Arg1] <PVPDerivativeCardKeywords_21:Knochenerschütternde Umarmung> in die Hand."
  },
  RelicConfig_94696_Desc = {
    Text = "Nachdem der Kampf begonnen hat, lege [Arg1] <PVPDerivativeCardKeywords_21:Knochenerschütternde Umarmung> in die Hand."
  },
  RelicConfig_94696_Name = {
    Text = "<OrangeQuality:Aktivinjektor>"
  },
  RelicConfig_94697_BattleDesc = {
    Text = "Am Ende der Runde werden die Erwachten-Karten auf der Hand abgeworfen und entsprechend viele Karten gezogen."
  },
  RelicConfig_94697_Desc = {
    Text = "Am Ende der Runde werden die Erwachten-Karten auf der Hand abgeworfen und entsprechend viele Karten gezogen."
  },
  RelicConfig_94697_Name = {
    Text = "<OrangeQuality:Verführerische Windglocke>"
  },
  RelicConfig_94698_BattleDesc = {
    Text = "Nachdem der Kampf beginnt, lege [Arg1] <PVPDerivativeCardKeywords_22:Letzter Schlag, bester Schlag> und <PVPDerivativeCardKeywords_23:Stimmen in deinem Kopf> in den Nachziehstapel."
  },
  RelicConfig_94698_Desc = {
    Text = "Nachdem der Kampf beginnt, lege [Arg1] <PVPDerivativeCardKeywords_22:Letzter Schlag, bester Schlag> und <PVPDerivativeCardKeywords_23:Stimmen in deinem Kopf> in den Nachziehstapel."
  },
  RelicConfig_94698_Name = {
    Text = "<OrangeQuality:Alfonsos Artefakt>"
  },
  RelicConfig_95975_BattleDesc = {
    Text = "Handkartenlimit +1. \n Zu Beginn des Zuges, falls keine <DerivativeCardKeywords_111:„Seelenverschlingung“> vorhanden ist, lege sie in die Hand. Wenn „Sättigung“ 10 erreicht, verwandle sie in <DerivativeCardKeywords_112:„Speicherresonanz“>."
  },
  RelicConfig_95975_Desc = {
    Text = "Handkartenlimit +1. \n Zu Beginn des Zuges, falls keine „Seelenverschlingung“ vorhanden ist, lege sie in die Hand. Wenn „Sättigung“ 10 erreicht, verwandle sie in „Speicherresonanz“."
  },
  RelicConfig_95975_Name = {
    Text = "Knochenkelch"
  },
  RelicConfig_95975_StoryDesc = {
    Text = "“Der Blutmond steigt hoch, die Leichname sollen die Gläser erheben und trinken.“"
  },
  RelicConfig_95976_BattleDesc = {
    Text = "Zu Rundenbeginn erhält Dulsein [Arg1] Wahnsinn und [Arg2] Punkte Macht. Wenn Dulsein “Trümmer“ verzehrt, erhält er 20% temporäre Macht als permanente Macht."
  },
  RelicConfig_95976_Desc = {
    Text = "Zu Rundenbeginn erhält Dulsein [Arg1] Wahnsinn und [Arg2] Punkte Macht. Wenn Dulsein “Trümmer“ verzehrt, erhält er 20% temporäre Macht als permanente Macht."
  },
  RelicConfig_95976_Name = {
    Text = "<OrangeQuality:Dimensionales Echo - Durasain>"
  },
  RelicConfig_96652_BattleDesc = {
    Text = "<Heat:Hitze> kleiner als 3, wenn du 3 nicht brennende Befehlskarten spielst, erhält eine Befehlskarte in deiner Hand <BurningKeywords:brennen>. Wenn eine Karte mit <BurningKeywords:brennen> gespielt wird, sammle 1 Stufe <Heat:Hitze>, andernfalls wird sie verbraucht und du ziehst 1 Karte. Wenn <Heat:Hitze> 3 Stufen erreicht, erhältst du 3 Punkte Arithmetica, ziehe 3 Karten, alle Befehlskarten in deiner Hand erhalten <BurningKeywords:brennen> und gehen sofort in den Zustand <Overload:Überhitzung> über."
  },
  RelicConfig_96652_Desc = {
    Text = "<Heat:Hitze> kleiner als 3: Jedes Mal, wenn du 3 nicht brennende Befehlskarten spielst, erhält eine Befehlskarte in deiner Hand <BurningKeywords:brennen>. Wenn eine Karte mit <BurningKeywords:brennen> ausgespielt wird, sammle 1 Stufe <Heat:Hitze>, andernfalls wird sie verbraucht und du ziehst 1 Karte. Wenn <Heat:Hitze> 3 Stufen erreicht, erhältst du 3 Punkte Arithmetica, ziehst 3 Karten und alle Befehlskarten in deiner Hand erhalten <BurningKeywords:brennen> und gehen sofort in den Zustand <Overload:endlose Explosion>."
  },
  RelicConfig_96652_Name = {
    Text = "Schwarze Flamme"
  },
  RelicConfig_96652_StoryDesc = {
    Text = "Die pechschwarzen Flammen werden ihren Willen durchsetzen und alles bis zur Asche verbrennen."
  },
  RelicConfig_97344_BattleDesc = {
    Text = "Wenn du deine letzte Handkarte verlierst, ziehe 2 Karten und erhalte [Arg1] Punkte Silberschlüssel-Energie. Nach jedem Mischen des Decks erhöht sich der Tentakelschaden um [Arg2] Punkte."
  },
  RelicConfig_97344_Desc = {
    Text = "Wenn du deine letzte Handkarte verlierst, ziehe 2 Karten und erhalte [Arg1] Punkte Silberschlüssel-Energie. Nach jedem Mischen des Decks erhöht sich der Tentakelschaden um [Arg2] Punkte."
  },
  RelicConfig_97344_Name = {
    Text = "Mythag-Meisterschaftspokal"
  },
  RelicConfig_97344_StoryDesc = {
    Text = "Heute werden wir die Angst und den Schmerz vergessen und nur das Fest genießen."
  },
  RelicConfig_97345_BattleDesc = {
    Text = "Für jede 3 ausgespielten Befehlskarten erhalten Sie 1 Punkt Arithmetica und ziehen 1 Karte. Jeder aktive Schaden erhöht den temporären Gesamtschaden um 2 %, maximal bis zu 50 %."
  },
  RelicConfig_97345_Desc = {
    Text = "Für jede 3 ausgespielten Befehlskarten erhalten Sie 1 Punkt Arithmetica und ziehen 1 Karte. Jeder aktive Schadensangriff erhöht den temporären Endschaden um 2%, maximal bis zu 50%."
  },
  RelicConfig_97345_Name = {
    Text = "Mythag Meisterschaftspokal"
  },
  RelicConfig_97345_StoryDesc = {
    Text = "Heute werden wir die Angst vergessen, den Schmerz vergessen und nur das Fest genießen."
  },
  RelicConfig_97346_BattleDesc = {
    Text = "Alle Erwecker erhöhen ihre kritische Trefferchance um 30%. Zu Beginn ungerader Runden verlieren alle Feinde 25 % ihres aktuellen Lebens. Liegt der eigene Lebensanteil unter dem des Gegners, erhöht sich der verursachte Endschaden um 50 %. Liegt der eigene Lebensanteil über dem des Gegners, erhält man nach dem Auslösen der Wahnsinns-Explosion 35 Punkte Wahnsinn."
  },
  RelicConfig_97346_Desc = {
    Text = "Alle Erwecker erhalten eine um 30% erhöhte kritische Trefferchance. Zu Beginn ungerader Runden verlieren alle Feinde 25% ihres aktuellen Lebens. Liegt der eigene Lebensanteil unter dem des Gegners, erhöht sich der verursachte Endschaden um 50%. Ist der eigene Lebensanteil höher als der des Gegners, gewährt die Auslösung der Wahnsinnsexplosion 35 Punkte Wahnsinn."
  },
  RelicConfig_97346_Name = {
    Text = "Mythag-Meisterschaftspokal"
  },
  RelicConfig_97346_StoryDesc = {
    Text = "Heute werden wir die Angst vergessen, den Schmerz vergessen und nur feiern."
  },
  RelicConfig_97347_BattleDesc = {
    Text = "Die maximale Arithmetica erhöht sich um 2 Punkte, nicht verbrauchte Arithmetica kann bis zur nächsten Runde behalten werden. Wenn mehr als 2 Punkte Arithmetica behalten werden, erhalten alle Erwecker zu Beginn der nächsten Runde 20 Punkte Wahnsinn; wenn mehr als 4 Punkte Arithmetica behalten werden, erhöht sich der verursachte Grundschaden in der nächsten Runde um 100%."
  },
  RelicConfig_97347_Desc = {
    Text = "Die maximale Arithmetica erhöht sich um 2 Punkte, ungenutzte Arithmetica kann bis zur nächsten Runde behalten werden. Wenn mehr als 2 Punkte Arithmetica behalten werden, erhalten alle Erwecker zu Beginn der nächsten Runde 20 Punkte Wahnsinn; wenn mehr als 4 Punkte Arithmetica behalten werden, erhöht sich der Grundschaden in der nächsten Runde um 100%."
  },
  RelicConfig_97347_Name = {
    Text = "Mythag Meisterschaftspokal"
  },
  RelicConfig_97347_StoryDesc = {
    Text = "Heute werden wir die Angst und den Schmerz vergessen und nur das Fest genießen."
  },
  RelicConfig_98274_BattleDesc = {
    Text = "Handkartenlimit +1, am Kampfbeginn erhältst du «<DerivativeCardKeywords_116:Farbpalette>». \nZu Beginn deiner Runde erhältst du 1 «<PrimaryColor:Primärfarbe>», und zufällig erhalten 2 Befehlskarten «<ColorInkKeywords:Farbtinte>». Wenn du eine Karte mit «<ColorInkKeywords:Farbtinte>» ausspielst, erhältst du nacheinander 1 «<PrimaryColor:Primärfarbe>». \nDie ausgespielten «<PrimaryColor:Primärfarben>» werden auf der «<DerivativeCardKeywords_116:Farbpalette>» aufgezeichnet. Wenn sich auf der «<PrimaryColor:Farbpalette>» 2 verschiedene «<DerivativeCardKeywords_116:Primärfarben>» befinden, erhältst du einen dauerhaften Bonuseffekt. \nBefinden sich auf der «<PrimaryColor:Farbpalette>» 3 verschiedene «<DerivativeCardKeywords_116:Primärfarben>», verlieren alle Feinde sofort 5 % ihrer maximalen Lebenspunkte, und die «<DerivativeCardKeywords_116:Farbpalette>» wird geleert."
  },
  RelicConfig_98274_Desc = {
    Text = "Handkartenlimit +1, am Kampfbeginn erhältst du «<DerivativeCardKeywords_116:Farbpalette>». \nZu Beginn deiner Runde erhältst du 1 «<PrimaryColor:Primärfarbe>», und zufällig erhalten 2 Befehlskarten «<ColorInkKeywords:Farbtinte>». Wenn du eine Karte mit «<ColorInkKeywords:Farbtinte>» ausspielst, erhältst du nacheinander 1 «<PrimaryColor:Primärfarbe>». \nDie ausgespielten «<PrimaryColor:Primärfarben>» werden auf der «<DerivativeCardKeywords_116:Farbpalette>» aufgezeichnet. Wenn sich auf der «<PrimaryColor:Farbpalette>» 2 verschiedene «<DerivativeCardKeywords_116:Primärfarben>» befinden, erhältst du einen dauerhaften Bonuseffekt. \nBefinden sich auf der «<PrimaryColor:Farbpalette>» 3 verschiedene «<DerivativeCardKeywords_116:Primärfarben>», verlieren alle Feinde sofort 5 % ihrer maximalen Lebenspunkte, und die «<DerivativeCardKeywords_116:Farbpalette>» wird geleert."
  },
  RelicConfig_98274_Name = {
    Text = "Fremdartige Farbpalette"
  },
  RelicConfig_98274_StoryDesc = {
    Text = "In der Vision werden wir die Geburt der “Kunst“ bezeugen."
  },
  RelicConfig_98367_BattleDesc = {
    Text = "Alle Erweckten erhöhen die Basiswirkung von Heilung und Schilden um [Arg1]%."
  },
  RelicConfig_98367_Desc = {
    Text = "Alle Erwecker erhöhen die Basiswirkung von Lebensregeneration und Schild um [Arg1]%."
  },
  RelicConfig_98367_Name = {
    Text = "<WhiteQuality:Schlangenhaut>"
  },
  RelicConfig_98367_StoryDesc = {
    Text = "Wiedergeburt aus der Selbstverstümmelung"
  },
  RelicConfig_98368_BattleDesc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Für jede gespielte Befehlskarte eines anderen Erweckers zusätzlich [Arg1]% temporäre Schadensverstärkung erhalten."
  },
  RelicConfig_98368_Desc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Für jede gespielte Befehlskarte eines anderen Erweckers erhält man zusätzlich [Arg1]% temporäre Schadensverstärkung."
  },
  RelicConfig_98368_Name = {
    Text = "<OrangeQuality:Kaleidoskop+>"
  },
  RelicConfig_98368_StoryDesc = {
    Text = "Alles, was du siehst und denkst, ist Illusion"
  },
  RelicConfig_98369_BattleDesc = {
    Text = "Nach der Silberschlüsselerweckung erhalten die [Arg1] Karten mit dem höchsten Arithmetika-Wert in der Hand vor dem nächsten Ausspielen die Effekte Beibehalten und Vorbereitung sowie [Arg2] Punkte Silberschlüssel-Energie."
  },
  RelicConfig_98369_Desc = {
    Text = "Nach der Silberschlüsselerweckung erhalten die [Arg1] Karten mit dem höchsten Arithmetica-Wert in der Hand vor dem nächsten Ausspielen Beibehaltung und Vorbereitung sowie [Arg2] Punkte Silberschlüssel-Energie."
  },
  RelicConfig_98369_Name = {
    Text = "<WhiteQuality:Briefmarkenalbum>"
  },
  RelicConfig_98369_StoryDesc = {
    Text = "Quantifizierte Gedanken"
  },
  RelicConfig_98370_BattleDesc = {
    Text = "Beim Kampfbeginn entsteht [Arg1] Schichten Schwäche und Verwundbarkeit an allen Feinden. Dieser Effekt wird auch nach „Vernichtung“ ausgelöst, hat jedoch eine Abklingzeit von 3 Runden."
  },
  RelicConfig_98370_Desc = {
    Text = "Beim Kampfbeginn erhalten alle Feinde [Arg1] Schichten Schwäche und Verwundbarkeit. Dieser Effekt wird auch nach „Vernichtung“ ausgelöst, hat jedoch eine Abkühlzeit von 3 Runden."
  },
  RelicConfig_98370_Name = {
    Text = "<WhiteQuality:Raumverzerrer>"
  },
  RelicConfig_98370_StoryDesc = {
    Text = "Sprung ins Nichts"
  },
  RelicConfig_98371_BattleDesc = {
    Text = "Vor Rundenende erhält der zugehörige Erwachte jeder Befehlskarte in deiner Hand [Arg1] Wahnsinn."
  },
  RelicConfig_98371_Desc = {
    Text = "Vor Rundenende erhält der zugehörige Erwachte für jede Befehlskarte in deiner Hand [Arg1] Wahnsinn."
  },
  RelicConfig_98371_Name = {
    Text = "<WhiteQuality:Unwuchtige Waage>"
  },
  RelicConfig_98371_StoryDesc = {
    Text = "Symbolisiert keine Gerechtigkeit mehr"
  },
  RelicConfig_98372_BattleDesc = {
    Text = "Am Ende der Runde, wenn der Schlüsselstrahl voll ist, verbrauche [Arg1] Schlüsselstrahlen, um eine <DerivativeCardKeywords_129:\"Silberner Schlüssel: Glanz\"> in deine Hand zu legen."
  },
  RelicConfig_98372_Desc = {
    Text = "Am Ende der Runde, wenn der Schlüsselstrahl voll ist, verbrauche [Arg1] Schlüsselstrahlen, um eine <DerivativeCardKeywords_129:\"Silberner Schlüssel: Glanz\"> in deine Hand zu legen."
  },
  RelicConfig_98372_Name = {
    Text = "<WhiteQuality:Im Abendlicht>"
  },
  RelicConfig_98372_StoryDesc = {
    Text = "Lass uns ein Foto machen! Erlebe den echten Schmerz"
  },
  RelicConfig_98373_BattleDesc = {
    Text = "Beim Freisetzen von „Wahnsinnsausbruch“ erhältst du [Arg1] s-Energie. Dieser Effekt kann pro Runde maximal 3 Mal ausgelöst werden."
  },
  RelicConfig_98373_Desc = {
    Text = "Beim Freisetzen von „Wahnsinnsausbruch“ erhältst du [Arg1] s-Energie. Dieser Effekt kann pro Runde maximal 3 Mal ausgelöst werden."
  },
  RelicConfig_98373_Name = {
    Text = "<OrangeQuality:Schöner Moment+>"
  },
  RelicConfig_98373_StoryDesc = {
    Text = "Bewahre die flüchtige Schönheit für immer"
  },
  RelicConfig_98374_BattleDesc = {
    Text = "Beim ersten “Schlüsselbefehl“ jeder Runde allen Feinden [Arg1] Schichten Gift hinzufügen und [Arg2] Schichten Gegenschlag gewähren."
  },
  RelicConfig_98374_Desc = {
    Text = "Nach dem ersten “Schlüsselbefehl“ jeder Runde allen Feinden [Arg1] Schichten Gift hinzufügen und [Arg2] Schichten Gegenschlag erhalten."
  },
  RelicConfig_98374_Name = {
    Text = "<OrangeQuality:Wunschlampe des Propheten+>"
  },
  RelicConfig_98374_StoryDesc = {
    Text = "Erfülle deinen Wunsch"
  },
  RelicConfig_98375_BattleDesc = {
    Text = "Am Ende der Runde, wenn der Schlüsselstrahl voll ist, verbrauche [Arg1] Schlüsselstrahlen, um eine <DerivativeCardKeywords_67:\"Silberner Schlüssel: Morgen\"> in deine Hand zu legen."
  },
  RelicConfig_98375_Desc = {
    Text = "Am Ende der Runde, wenn der Schlüsselstrahl voll ist, verbrauche [Arg1] Schlüsselstrahlen, um eine <DerivativeCardKeywords_67:\"Silberner Schlüssel: Morgen\"> in deine Hand zu legen."
  },
  RelicConfig_98375_Name = {
    Text = "<OrangeQuality:Im Abendlicht+>"
  },
  RelicConfig_98375_StoryDesc = {
    Text = "Lass uns ein Foto machen! Erlebe den echten Schmerz"
  },
  RelicConfig_98376_BattleDesc = {
    Text = "Alle Erwecker erhöhen die Basiswirkung von Heilung und Schild um [Arg1]%."
  },
  RelicConfig_98376_Desc = {
    Text = "Alle Erweckten erhöhen die Basiswirkung von Heilung und Schilden um [Arg1]%."
  },
  RelicConfig_98376_Name = {
    Text = "<OrangeQuality:Schlangenhaut+>"
  },
  RelicConfig_98376_StoryDesc = {
    Text = "Wiedergeburt aus der Selbstverstümmelung"
  },
  RelicConfig_98377_BattleDesc = {
    Text = "Jedes Mal, wenn eine Karte in den Hyperraum gelangt, ziehe [Arg1] Befehlskarten des Eigentümers dieser Karte aus dem Deck. Falls keine Karten gezogen werden können, erhältst du stattdessen gleichwertige Arithmetica-Punkte. Dies kann pro Runde maximal 2 Mal ausgelöst werden."
  },
  RelicConfig_98377_Desc = {
    Text = "Jedes Mal, wenn eine Karte in den Hyperraum gelangt, ziehe [Arg1] Befehlskarten des Eigentümers dieser Karte aus dem Deck. Falls keine Karten gezogen werden können, erhältst du stattdessen gleichwertige Arithmetica-Punkte. Dieser Effekt kann pro Runde maximal 2 Mal ausgelöst werden."
  },
  RelicConfig_98377_Name = {
    Text = "<WhiteQuality:Prisma>"
  },
  RelicConfig_98377_StoryDesc = {
    Text = "“Licht besteht aus sieben Farben.“"
  },
  RelicConfig_98378_BattleDesc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Nach erlittenem Schaden [Arg2] Gegenangriff erhalten, maximal 3-mal pro Runde auslösbar."
  },
  RelicConfig_98378_Desc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Nach erlittenem Schaden [Arg2] Gegenangriff erhalten, maximal 3-mal pro Runde auslösbar."
  },
  RelicConfig_98378_Name = {
    Text = "<OrangeQuality:Notausgang+>"
  },
  RelicConfig_98378_StoryDesc = {
    Text = "Es scheint, dass er auch nicht entkommen konnte"
  },
  RelicConfig_98379_BattleDesc = {
    Text = "Nachdem aktiver oder Tentakelschaden verursacht wurde, erhöht sich der Tentakelschaden, den das Ziel in dieser Runde erleidet, um [Arg1] %, maximal 20-mal pro Runde auslösbar."
  },
  RelicConfig_98379_Desc = {
    Text = "Nachdem aktiver oder Tentakelschaden verursacht wurde, erhöht sich der Tentakelschaden, den das Ziel in dieser Runde erleidet, um [Arg1] %, maximal 20 Mal pro Runde auslösbar."
  },
  RelicConfig_98379_Name = {
    Text = "<WhiteQuality:Tauchhelm>"
  },
  RelicConfig_98379_StoryDesc = {
    Text = "Träume sind Sterne und Ozeane!"
  },
  RelicConfig_98380_BattleDesc = {
    Text = "Zu Kampfbeginn und nach Auslösen des Todeswiderstands erhält man [Arg1] Punkte s-Energie."
  },
  RelicConfig_98380_Desc = {
    Text = "Zu Beginn des Kampfes und nach Auslösen des Todeswiderstands erhält man [Arg1] Punkte s-Energie."
  },
  RelicConfig_98380_Name = {
    Text = "<WhiteQuality:Opfergaben der Vergangenheit>"
  },
  RelicConfig_98380_StoryDesc = {
    Text = "Einst geopferte Gegenstände"
  },
  RelicConfig_98381_BattleDesc = {
    Text = "Nach dem Keyflare-Erwecken wird [Heal:Arg1] LP wiederhergestellt und [Arg2] Keyflare erhalten."
  },
  RelicConfig_98381_Desc = {
    Text = "Nach dem Keyflare-Erwecken wird [Heal:Arg1] LP wiederhergestellt und [Arg2] Keyflare erhalten."
  },
  RelicConfig_98381_Name = {
    Text = "<WhiteQuality:Reiseschirm>"
  },
  RelicConfig_98381_StoryDesc = {
    Text = "Blühen im lichtlosen Land"
  },
  RelicConfig_98382_BattleDesc = {
    Text = "Nachdem die Schlacht begonnen hat, erhalten Sie [Arg1] <ProficientInRealmsIconKeywords:realm mastery>. Zu Beginn der ungeraden Züge ziehen Sie [Arg2] Karten, zu Beginn der geraden Züge erhalten Sie [Arg2] Punkte Arithmetika."
  },
  RelicConfig_98382_Desc = {
    Text = "Nachdem die Schlacht begonnen hat, erhalten Sie [Arg1] <ProficientInRealmsIconKeywords:realm mastery>. Zu Beginn der ungeraden Züge ziehen Sie [Arg2] Karten, zu Beginn der geraden Züge erhalten Sie [Arg2] Punkte Arithmetika."
  },
  RelicConfig_98382_Name = {
    Text = "<OrangeQuality:Sonnen-Mond-Rad+>"
  },
  RelicConfig_98382_StoryDesc = {
    Text = "Rate mal, schwarz oder weiß?"
  },
  RelicConfig_98383_BattleDesc = {
    Text = "Beim ersten “Schlüsselbefehl“ jeder Runde alle Tentakel aktivieren, um [Arg1] Mal gegen die Gegner zu attackieren, und 50% Schaden verursachen."
  },
  RelicConfig_98383_Desc = {
    Text = "Beim ersten “Schlüsselbefehl“ jeder Runde alle Tentakel aktivieren, um [Arg1]-mal gegen die Gegner zu attackieren, und 50 % Schaden verursachen."
  },
  RelicConfig_98383_Name = {
    Text = "<OrangeQuality:Gelbe Schnecke+>"
  },
  RelicConfig_98383_StoryDesc = {
    Text = "Diese kleine gelbe Schnecke stammt aus edlem Hause, mit perfektem, makellosem Hintergrund"
  },
  RelicConfig_98384_BattleDesc = {
    Text = "Alle Erwecker erhöhen den Basisschaden um [Arg1]%. Bevor der Erwecker die Wahnexplosion auslöst, wird der Basisschaden des Erweckers vorübergehend um [Arg2]% erhöht."
  },
  RelicConfig_98384_Desc = {
    Text = "Alle Erwecker erhöhen den Basisschaden um [Arg1]%. Vor der Freisetzung der Wahnexplosion wird der Basisschaden des Erwachens, das die Wahnexplosion freisetzt, vorübergehend um [Arg2]% erhöht."
  },
  RelicConfig_98384_Name = {
    Text = "<WhiteQuality:Blut der Vergessenen>"
  },
  RelicConfig_98384_StoryDesc = {
    Text = "Schmilzt allmählich"
  },
  RelicConfig_98385_BattleDesc = {
    Text = "Beim ersten “Schlüsselbefehl“ jeder Runde allen Feinden [Arg1] Schichten Gift zuweisen und [Arg2] Schichten Gegenschlag erhalten."
  },
  RelicConfig_98385_Desc = {
    Text = "Nach dem ersten “Schlüsselbefehl“ jeder Runde fügen Sie allen Feinden [Arg1] Schichten Gift hinzu und erhalten [Arg2] Schichten Gegenschlag."
  },
  RelicConfig_98385_Name = {
    Text = "<WhiteQuality:Propheten-Wunschlampe>"
  },
  RelicConfig_98385_StoryDesc = {
    Text = "Erfülle deinen Wunsch"
  },
  RelicConfig_98386_BattleDesc = {
    Text = "Zu Beginn des Zugs, wenn das Leben unter 50% liegt, wird der Schaden vorübergehend um [Arg1]% erhöht. Wenn das Leben unter 25% liegt, ziehe zusätzliche [Arg2] Karten und gewinne [Arg2] Arithmetica."
  },
  RelicConfig_98386_Desc = {
    Text = "Zu Beginn des Zugs, wenn das Leben unter 50% liegt, wird der Schaden vorübergehend um [Arg1]% erhöht. Wenn das Leben unter 25% liegt, ziehe zusätzliche [Arg2] Karten und gewinne [Arg2] Arithmetica."
  },
  RelicConfig_98386_Name = {
    Text = "<WhiteQuality:Doktor Tasche>"
  },
  RelicConfig_98386_StoryDesc = {
    Text = "Der Reisekoffer, der den Arzt repräsentiert, ist sehr schwer.\n\nWer ihn öffnet, ist möglicherweise kein echter Arzt.\n"
  },
  RelicConfig_98387_BattleDesc = {
    Text = "Beim Kampfbeginn [Arg1] Schichten Schwäche und Verwundbarkeit an allen Feinden verursachen. Dieser Effekt wird auch nach „Vernichtung“ ausgelöst, hat jedoch eine Abklingzeit von 3 Runden."
  },
  RelicConfig_98387_Desc = {
    Text = "Beim Kampfbeginn erhalten alle Feinde [Arg1] Schichten Schwäche und Verwundbarkeit. Dieser Effekt wird auch nach „Vernichtung“ ausgelöst, hat jedoch eine Abkühlzeit von 3 Runden."
  },
  RelicConfig_98387_Name = {
    Text = "<OrangeQuality:Raumkrümmungsinstrument+>"
  },
  RelicConfig_98387_StoryDesc = {
    Text = "Sprung ins Nichts"
  },
  RelicConfig_98388_BattleDesc = {
    Text = "Zu Beginn des Kampfes und nach Auslösen des Todeswiderstands erhältst du [Arg1] Punkte s-Energie."
  },
  RelicConfig_98388_Desc = {
    Text = "Zu Kampfbeginn und nach Auslösen des Todeswiderstands erhältst du [Arg1] Punkte s-Energie."
  },
  RelicConfig_98388_Name = {
    Text = "<OrangeQuality:Vergangene Opfergaben+>"
  },
  RelicConfig_98388_StoryDesc = {
    Text = "Einst geopferte Gegenstände"
  },
  RelicConfig_98389_BattleDesc = {
    Text = "Nachdem die Schlacht begonnen hat, erhalten Sie [Arg1] <ProficientInRealmsIconKeywords:realm mastery>. Zu Beginn der ungeraden Züge ziehen Sie [Arg2] Karten, zu Beginn der geraden Züge erhalten Sie [Arg2] Punkte Arithmetika."
  },
  RelicConfig_98389_Desc = {
    Text = "Nachdem die Schlacht begonnen hat, erhalten Sie [Arg1] <ProficientInRealmsIconKeywords:realm mastery>. Zu Beginn der ungeraden Züge ziehen Sie [Arg2] Karten, zu Beginn der geraden Züge erhalten Sie [Arg2] Punkte Arithmetika."
  },
  RelicConfig_98389_Name = {
    Text = "<WhiteQuality:Sonnen- und Mondrad>"
  },
  RelicConfig_98389_StoryDesc = {
    Text = "Rate mal, schwarz oder weiß?"
  },
  RelicConfig_98390_BattleDesc = {
    Text = "Beim Ziehen oder Verwerfen einer Karte erhält man [Arg1] temporäre Stärke. Maximal 15-mal pro Runde auslösbar."
  },
  RelicConfig_98390_Desc = {
    Text = "Beim Ziehen oder Verwerfen einer Karte erhält man [Arg1] temporäre Stärke. Maximal 15 Mal pro Runde auslösbar."
  },
  RelicConfig_98390_Name = {
    Text = "<WhiteQuality:Stille Ouvertüre>"
  },
  RelicConfig_98390_StoryDesc = {
    Text = "Die Geige des berühmten Violinisten Erik Eckstein.\nHeute kann sie nicht mehr gespielt werden"
  },
  RelicConfig_98391_BattleDesc = {
    Text = "Beim ersten “Schlüsselbefehl“ jeder Runde erhöht sich die temporäre Schadensintensität um +[Arg2]%, je niedriger das Leben, desto stärker der Effekt."
  },
  RelicConfig_98391_Desc = {
    Text = "Beim ersten “Schlüsselbefehl“ jeder Runde erhöht sich die vorübergehende Schadensintensität um +[Arg1]%. Je niedriger das Leben, desto stärker ist der Effekt."
  },
  RelicConfig_98391_Name = {
    Text = "<WhiteQuality:Harfords Elixier>"
  },
  RelicConfig_98391_StoryDesc = {
    Text = "Unbekannte Droge.\nEs heißt, der berühmte Geiger Erik bevorzugt sie"
  },
  RelicConfig_98392_BattleDesc = {
    Text = "Beim ersten “Schlüsselbefehl“ jeder Runde erhöht sich die temporäre Schadensintensität um +[Arg2]%. Der Effekt ist stärker, je niedriger das Leben ist."
  },
  RelicConfig_98392_Desc = {
    Text = "Beim ersten “Schlüsselbefehl“ jeder Runde erhöht sich die temporäre Schadensintensität um +[Arg1]%. Der Effekt ist stärker, je niedriger das Leben ist."
  },
  RelicConfig_98392_Name = {
    Text = "<OrangeQuality:Haftonikum+>"
  },
  RelicConfig_98392_StoryDesc = {
    Text = "Unbekannte Droge.\nEs heißt, der berühmte Geiger Erik bevorzugt sie"
  },
  RelicConfig_98393_BattleDesc = {
    Text = "Alle Erwachten erhalten bei ihrer ersten Befehlskarte pro Runde [Arg1] Punkte s-Energie."
  },
  RelicConfig_98393_Desc = {
    Text = "Alle Erwachten erhalten pro Runde bei ihrer ersten Befehlskarte [Arg1] Punkte s-Energie."
  },
  RelicConfig_98393_Name = {
    Text = "<WhiteQuality:Wortgewandt>"
  },
  RelicConfig_98393_StoryDesc = {
    Text = "Nicht nur Händler sind redegewandt, auch Gläubige"
  },
  RelicConfig_98394_BattleDesc = {
    Text = "Beim ersten “Schlüsselbefehl“ jeder Runde werden [Arg1]% der verbrauchten Silberschlüsselenergie zurückerstattet."
  },
  RelicConfig_98394_Desc = {
    Text = "Beim ersten “Bande“ jeder Runde werden [Arg1]% der verbrauchten s-Energie zurückerstattet."
  },
  RelicConfig_98394_Name = {
    Text = "<WhiteQuality:Glückshasenpfote>"
  },
  RelicConfig_98394_StoryDesc = {
    Text = "Für das Kaninchen war es nicht so glücklich"
  },
  RelicConfig_98395_BattleDesc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Nach jedem aktiven Schaden [Arg2] Gift auf alle Gegner auslösen, maximal 5-mal pro Runde."
  },
  RelicConfig_98395_Desc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Nach jedem aktiven Schaden [Arg2] Schichten Gift auf alle Gegner anwenden, maximal 5-mal pro Runde auslösbar."
  },
  RelicConfig_98395_Name = {
    Text = "<OrangeQuality:Priesterstab+>"
  },
  RelicConfig_98395_StoryDesc = {
    Text = "Unerlaubte Frömmigkeit"
  },
  RelicConfig_98396_BattleDesc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Für jede gespielte Befehlskarte eines anderen Erweckers erhält man zusätzlich [Arg1]% temporäre Schadensverstärkung."
  },
  RelicConfig_98396_Desc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Für jede gespielte Befehlskarte eines anderen Erweckers zusätzlich [Arg1]% temporäre Schadensverstärkung erhalten."
  },
  RelicConfig_98396_Name = {
    Text = "<WhiteQuality:Kaleidoskop>"
  },
  RelicConfig_98396_StoryDesc = {
    Text = "Alles, was du siehst und denkst, ist Illusion"
  },
  RelicConfig_98397_BattleDesc = {
    Text = "Nach dem zweiten Freisetzen des “Schlüsselbefehls“ in jeder Runde erhältst du [Arg1] Punkte s-Energie, und alle Erwachten erhalten [Arg2] Punkte Wahnsinn."
  },
  RelicConfig_98397_Desc = {
    Text = "Nach dem zweiten Freisetzen des “Schlüsselbefehls“ pro Runde erhältst du [Arg1] Punkte s-Energie, und alle Erwachten erhalten [Arg2] Punkte Wahnsinn."
  },
  RelicConfig_98397_Name = {
    Text = "<OrangeQuality:Präzisionsuhr+>"
  },
  RelicConfig_98397_StoryDesc = {
    Text = "Eine der bösartigsten Erfindungen der Menschheit"
  },
  RelicConfig_98398_BattleDesc = {
    Text = "Zu Beginn des Kampfes verlieren alle Feinde temporär [Arg1] Kraft. Das Verwenden des „Purpurnen Ofens“ löst diesen Effekt ebenfalls aus, hat jedoch eine Abkühlzeit von 3 Runden."
  },
  RelicConfig_98398_Desc = {
    Text = "Zu Beginn des Kampfes verlieren alle Feinde [Arg1] temporäre Kraft. Das Verwenden des „Purpurnen Ofens“ löst diesen Effekt ebenfalls aus, hat jedoch eine Abklingzeit von 3 Runden."
  },
  RelicConfig_98398_Name = {
    Text = "<OrangeQuality:Meisterdieb+>"
  },
  RelicConfig_98398_StoryDesc = {
    Text = "Ein perfektes Werkzeug für Mord und Raub"
  },
  RelicConfig_98399_BattleDesc = {
    Text = "Nach dem zweiten Freisetzen des “Schlüsselbefehls“ pro Runde erhältst du [Arg1] Punkte s-Energie, alle Erwachten erhalten [Arg2] Punkte Wahnsinn."
  },
  RelicConfig_98399_Desc = {
    Text = "Nach dem zweiten Freisetzen des “Schlüsselbefehls“ jeder Runde erhältst du [Arg1] Punkte s-Energie, und alle Erwecker erhalten [Arg2] Punkte Wahnsinn."
  },
  RelicConfig_98399_Name = {
    Text = "<WhiteQuality:Präzisionsuhr>"
  },
  RelicConfig_98399_StoryDesc = {
    Text = "Eine der bösartigsten Erfindungen der Menschheit"
  },
  RelicConfig_98400_BattleDesc = {
    Text = "Beim Ziehen oder Verwerfen einer Karte erhält man [Arg1] temporäre Stärke. Maximal 15-mal pro Runde auslösbar."
  },
  RelicConfig_98400_Desc = {
    Text = "Beim Ziehen oder Ablegen einer Karte erhält man [Arg1] temporäre Stärke. Maximal 15-mal pro Runde auslösbar."
  },
  RelicConfig_98400_Name = {
    Text = "<OrangeQuality:Stille Ouvertüre+>"
  },
  RelicConfig_98400_StoryDesc = {
    Text = "Die Geige des berühmten Violinisten Erik Eckstein.\nHeute kann sie nicht mehr gespielt werden"
  },
  RelicConfig_98401_BattleDesc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Wenn man zum ersten Mal in der Runde einen Gegenschlag erhält, [Arg2] Arithmetica erhalten."
  },
  RelicConfig_98401_Desc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Wenn ein Gegenschlag zum ersten Mal in der Runde erfolgt, [Arg2] Arithmetica erhalten."
  },
  RelicConfig_98401_Name = {
    Text = "<OrangeQuality:Putney Morning Post+>"
  },
  RelicConfig_98401_StoryDesc = {
    Text = "Ihr treuester Toilettenbegleiter"
  },
  RelicConfig_98402_BattleDesc = {
    Text = "Nachdem aktiver oder Tentakelschaden verursacht wurde, erhöht sich der Tentakelschaden, den das Ziel in dieser Runde erleidet, um [Arg1] %. Dies kann pro Runde maximal 20 Mal ausgelöst werden."
  },
  RelicConfig_98402_Desc = {
    Text = "Nachdem aktiver oder Tentakelschaden verursacht wurde, erhöht sich der Tentakelschaden, den das Ziel in dieser Runde erleidet, um [Arg1] %, maximal 20-mal pro Runde auslösbar."
  },
  RelicConfig_98402_Name = {
    Text = "<OrangeQuality:Tauchhelm+>"
  },
  RelicConfig_98402_StoryDesc = {
    Text = "Träume sind Sterne und Ozeane!"
  },
  RelicConfig_98403_BattleDesc = {
    Text = "Beim Kampfbeginn erhältst du [Arg1] Kraft. Für jede gespielte Karte mit „Kosten“ erhältst du [Arg2] temporäre Kraft, maximal 10 Mal pro Runde auslösbar."
  },
  RelicConfig_98403_Desc = {
    Text = "Beim Kampfbeginn erhält man [Arg1] Stärke. Für jede ausgespielte Karte mit „Kosten“ erhält man [Arg2] temporäre Stärke, maximal 10-mal pro Runde auslösbar."
  },
  RelicConfig_98403_Name = {
    Text = "<OrangeQuality:Kleines Musikdöschen+>"
  },
  RelicConfig_98403_StoryDesc = {
    Text = "In Dexters Anwesen gibt es viele Sammlungen. Bevor es zerbrach, war die kleine Spieluhr das Lieblingsspielzeug von Miss Dexter. \nDie Zeit verging, und als Miss Dexter sie wiederfand, waren die Zahnräder locker und die Musik verstimmt, aber sie drehte sich immer noch"
  },
  RelicConfig_98404_BattleDesc = {
    Text = "Beim Freisetzen von „Wahnsinnsausbruch“ erhältst du [Arg1] s-Energie. Dieser Effekt kann pro Runde maximal 3 Mal ausgelöst werden."
  },
  RelicConfig_98404_Desc = {
    Text = "Nach dem Auslösen von „Wahnsinnsausbruch“ erhältst du [Arg1] s-Energie. Dieser Effekt kann pro Runde maximal 3 Mal ausgelöst werden."
  },
  RelicConfig_98404_Name = {
    Text = "<WhiteQuality:Schöner Moment>"
  },
  RelicConfig_98404_StoryDesc = {
    Text = "Bewahre die flüchtige Schönheit für immer"
  },
  RelicConfig_98405_BattleDesc = {
    Text = "Alle Erwachten erhalten bei ihrer ersten Befehlskarte in jeder Runde [Arg1] Punkte s-Energie."
  },
  RelicConfig_98405_Desc = {
    Text = "Alle Erwachten erhalten bei ihrer ersten Befehlskarte in jeder Runde [Arg1] Punkte s-Energie."
  },
  RelicConfig_98405_Name = {
    Text = "<OrangeQuality:Wortgewandt+>"
  },
  RelicConfig_98405_StoryDesc = {
    Text = "Nicht nur Händler sind redegewandt, auch Gläubige"
  },
  RelicConfig_98406_BattleDesc = {
    Text = "Jedes Mal, wenn ein “Embryo“ generiert wird, [Arg1] Punkte Purpurner Ofen erhalten, maximal 3-mal pro Runde auslösbar."
  },
  RelicConfig_98406_Desc = {
    Text = "Jedes Mal, wenn 1 „Embryo“ generiert wird, [Arg1] Punkte Purpurner Ofen erhalten, pro Runde maximal 3-mal auslösbar."
  },
  RelicConfig_98406_Name = {
    Text = "<OrangeQuality:Liebling+>"
  },
  RelicConfig_98406_StoryDesc = {
    Text = "Der Tischler fertigte für seine Frau eine lebensechte Puppe an, die ihren Sohn ersetzen und in ihrem Bauch schlafen würde"
  },
  RelicConfig_98407_BattleDesc = {
    Text = "Beim ersten “Schlüsselbefehl“ jeder Runde werden [Arg1]% der verbrauchten s-Energie zurückerstattet."
  },
  RelicConfig_98407_Desc = {
    Text = "Beim ersten “Bande“ jeder Runde werden [Arg1]% der verbrauchten Silberschlüsselenergie zurückgegeben."
  },
  RelicConfig_98407_Name = {
    Text = "<OrangeQuality:Glückshasenpfote+>"
  },
  RelicConfig_98407_StoryDesc = {
    Text = "Für das Kaninchen war es nicht so glücklich"
  },
  RelicConfig_98408_BattleDesc = {
    Text = "Zu Beginn der Runde erhalten alle Erwachten, deren Wahnsinn nicht ausreicht, um die Wahnexplosion auszulösen, [Arg1] Punkte Wahnsinn."
  },
  RelicConfig_98408_Desc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwachten, deren Wahnsinn nicht ausreicht, um die Wahnexplosion auszulösen, [Arg1] Punkte Wahnsinn."
  },
  RelicConfig_98408_Name = {
    Text = "<WhiteQuality:Eierzeit>"
  },
  RelicConfig_98408_StoryDesc = {
    Text = "Genieße es, aber iss es nicht"
  },
  RelicConfig_98409_BattleDesc = {
    Text = "Zu Beginn des Kampfes verlieren alle Feinde temporär [Arg1] Kraft. Das Verwenden des „Purpurnen Ofens“ löst diesen Effekt ebenfalls aus, hat jedoch eine Abkühlzeit von 3 Runden."
  },
  RelicConfig_98409_Desc = {
    Text = "Zu Beginn des Kampfes verlieren alle Feinde temporär [Arg1] Kraft. Das Verwenden des „Purpurnen Ofens“ löst diesen Effekt ebenfalls aus, hat jedoch eine Abklingzeit von 3 Runden."
  },
  RelicConfig_98409_Name = {
    Text = "<WhiteQuality:Meisterdieb>"
  },
  RelicConfig_98409_StoryDesc = {
    Text = "Ein perfektes Werkzeug für Mord und Raub"
  },
  RelicConfig_98410_BattleDesc = {
    Text = "Jedes Mal, wenn ein “Embryo“ generiert wird, erhältst du [Arg1] Punkte Purpurner Ofen. Dies kann pro Runde maximal 3-mal ausgelöst werden."
  },
  RelicConfig_98410_Desc = {
    Text = "Jedes Mal, wenn 1 „Embryo“ generiert wird, erhältst du [Arg1] Punkte des Purpurnen Ofens. Dies kann pro Runde maximal 3-mal ausgelöst werden."
  },
  RelicConfig_98410_Name = {
    Text = "<WhiteQuality:Liebes Kind>"
  },
  RelicConfig_98410_StoryDesc = {
    Text = "Der Tischler fertigte für seine Frau eine lebensechte Puppe an, die ihren Sohn ersetzen und in ihrem Bauch schlafen würde"
  },
  RelicConfig_98411_BattleDesc = {
    Text = "Zu Beginn des Zuges, falls die Silberschlüssel-Energie größer als [Arg1] ist, verbrauche [Arg1] Silberschlüssel-Energie, um 1 <DerivativeCardKeywords_115:«Höhere Inspiration»> auf die Hand zu legen."
  },
  RelicConfig_98411_Desc = {
    Text = "Zu Beginn des Zuges, falls die Silberschlüssel-Energie größer als [Arg1] ist, verbrauche [Arg1] Silberschlüssel-Energie, um 1 <DerivativeCardKeywords_115:«Höhere Inspiration»> auf die Hand zu legen."
  },
  RelicConfig_98411_Name = {
    Text = "<RedQuality:Albtraumerscheinung>"
  },
  RelicConfig_98411_StoryDesc = {
    Text = "Vorsicht, unkontrollierter Tiefschlaf kann alles verschlingen, ohne dass du es merkst"
  },
  RelicConfig_98412_BattleDesc = {
    Text = "Nach 5 Auslösungen von „Wahnsinnsexplosion“ wirkt die nächste [Arg1]-Karte, nicht abgeleitete Befehlskarte, 1 Mal zusätzlich."
  },
  RelicConfig_98412_Desc = {
    Text = "Nach 5 Auslösungen von „Exaltieren“ wirkt die nächste [Arg1]-Karte, nicht abgeleitete Befehlskarte, einmal zusätzlich."
  },
  RelicConfig_98412_Name = {
    Text = "<OrangeQuality:Sternenwein+>"
  },
  RelicConfig_98412_StoryDesc = {
    Text = "Zwischen den Sternen wandern"
  },
  RelicConfig_98413_BattleDesc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Nach erlittenem Schaden [Arg2] Gegenangriff erhalten, maximal 3-mal pro Runde auslösbar."
  },
  RelicConfig_98413_Desc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Nach erlittenem Schaden [Arg2] Gegenangriff erhalten, maximal 3-mal pro Runde auslösbar."
  },
  RelicConfig_98413_Name = {
    Text = "<WhiteQuality:Notausgang>"
  },
  RelicConfig_98413_StoryDesc = {
    Text = "Es scheint, dass er auch nicht entkommen konnte"
  },
  RelicConfig_98414_BattleDesc = {
    Text = "Alle Erwecker erhöhen den Basisschaden um [Arg1]%. Vor der Auslösung der Wahnexplosion erhöht sich der Basisschaden des Erwachten, der die Wahnexplosion auslöst, vorübergehend um [Arg2]%."
  },
  RelicConfig_98414_Desc = {
    Text = "Alle Erwecker erhöhen den Basisschaden um [Arg1]%. Vor dem Auslösen der Wahnexplosion wird der Basisschaden des Erwachters, der die Wahnexplosion auslöst, vorübergehend um [Arg2]% erhöht."
  },
  RelicConfig_98414_Name = {
    Text = "<OrangeQuality:Blut der Vergessenen+>"
  },
  RelicConfig_98414_StoryDesc = {
    Text = "Schmilzt allmählich"
  },
  RelicConfig_98415_BattleDesc = {
    Text = "Nach dem Keyflare-Erwecken wird [Heal:Arg1] LP wiederhergestellt und [Arg2] Keyflare erhalten."
  },
  RelicConfig_98415_Desc = {
    Text = "Nach dem Keyflare-Erwecken wird [Heal:Arg1] LP wiederhergestellt und [Arg2] Keyflare erhalten."
  },
  RelicConfig_98415_Name = {
    Text = "<OrangeQuality:Reiseschirm+>"
  },
  RelicConfig_98415_StoryDesc = {
    Text = "Blühen im lichtlosen Land"
  },
  RelicConfig_98416_BattleDesc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Erhält man in der Runde zum ersten Mal einen Gegenschlag, erhält man [Arg2] Arithmetica."
  },
  RelicConfig_98416_Desc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Wenn man innerhalb einer Runde zum ersten Mal einen Gegenschlag erhält, [Arg2] Arithmetica erhalten."
  },
  RelicConfig_98416_Name = {
    Text = "<WhiteQuality:Putney Morgenzeitung>"
  },
  RelicConfig_98416_StoryDesc = {
    Text = "Ihr treuester Toilettenbegleiter"
  },
  RelicConfig_98417_BattleDesc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwachten, deren Wahnsinn nicht ausreicht, um die Wahnexplosion auszulösen, [Arg1] Punkte Wahnsinn."
  },
  RelicConfig_98417_Desc = {
    Text = "Zu Beginn jeder Runde erhalten alle Erwachten, deren Wahnsinn nicht ausreicht, um die Wahnexplosion auszulösen, [Arg1] Punkte Wahnsinn."
  },
  RelicConfig_98417_Name = {
    Text = "<OrangeQuality:Ostereierzeit+>"
  },
  RelicConfig_98417_StoryDesc = {
    Text = "Genieße es, aber iss es nicht"
  },
  RelicConfig_98418_BattleDesc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Sobald Gift zum ersten Mal in der Runde angewendet wird, [Arg2] Karten ziehen."
  },
  RelicConfig_98418_Desc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Wenn zum ersten Mal in der Runde Gift angewendet wird, [Arg2] Karten ziehen."
  },
  RelicConfig_98418_Name = {
    Text = "<OrangeQuality:Papyrus Rhind+>"
  },
  RelicConfig_98418_StoryDesc = {
    Text = "Hier ist die Frage: 10 Mönche teilen 6 Brote, wie viel bekommt jeder?"
  },
  RelicConfig_98419_BattleDesc = {
    Text = "Nach jeder 5. Auslösung von „Wahnsinnsexplosion“ wirkt die nächste [Arg1]-Karte, nicht abgeleitete Befehlskarte, 1 Mal zusätzlich."
  },
  RelicConfig_98419_Desc = {
    Text = "Nach 5 Auslösungen von „Exaltieren“ wirkt die nächste [Arg1]-Karte, nicht abgeleitete Befehlskarte, 1 Mal zusätzlich."
  },
  RelicConfig_98419_Name = {
    Text = "<WhiteQuality:Sternenwein>"
  },
  RelicConfig_98419_StoryDesc = {
    Text = "Zwischen den Sternen wandern"
  },
  RelicConfig_98420_BattleDesc = {
    Text = "Jedes Mal, wenn eine Karte in den Hyperraum gelangt, ziehe [Arg1] Befehlskarten des Besitzers dieser Karte aus dem Deck. Falls keine Karten gezogen werden können, erhältst du stattdessen Arithmetica in gleicher Menge. Dies kann pro Runde maximal 2 Mal ausgelöst werden."
  },
  RelicConfig_98420_Desc = {
    Text = "Jedes Mal, wenn eine Karte in den Hyperraum gelangt, ziehe [Arg1] Befehlskarten des Eigentümers dieser Karte aus dem Deck. Falls keine Karten gezogen werden können, erhältst du stattdessen entsprechend viel Arithmetica. Dies kann pro Runde maximal 2 Mal ausgelöst werden."
  },
  RelicConfig_98420_Name = {
    Text = "<OrangeQuality:Prisma+>"
  },
  RelicConfig_98420_StoryDesc = {
    Text = "“Licht besteht aus sieben Farben.“"
  },
  RelicConfig_98421_BattleDesc = {
    Text = "Nach der Silberschlüssel-Erweckung erhalten die [Arg1] Karten mit der höchsten Arithmetik in der Hand vor dem nächsten Ausspielen Beibehaltung und Vorbereitung sowie [Arg2] Punkte Silberschlüssel-Energie."
  },
  RelicConfig_98421_Desc = {
    Text = "Nach der Silberschlüsselerweckung erhalten die [Arg1] Karten mit dem höchsten Arithmetik-Wert in der Hand vor dem nächsten Ausspielen die Effekte „Beibehalten“ und „Vorbereitung“ sowie [Arg2] Punkte Silberschlüssel-Energie."
  },
  RelicConfig_98421_Name = {
    Text = "<OrangeQuality:Fremdenland-Briefmarkenhalter+>"
  },
  RelicConfig_98421_StoryDesc = {
    Text = "Quantifizierte Gedanken"
  },
  RelicConfig_98422_BattleDesc = {
    Text = "Vor Rundenende erhält der zugehörige Erwachte für jede Befehlskarte in deiner Hand [Arg1] Wahnsinn."
  },
  RelicConfig_98422_Desc = {
    Text = "Vor Rundenende erhält der zugehörige Erwachte für jede Befehlskarte in deiner Hand [Arg1] Wahnsinn."
  },
  RelicConfig_98422_Name = {
    Text = "<OrangeQuality:Ungleichgewichtige Waage+>"
  },
  RelicConfig_98422_StoryDesc = {
    Text = "Symbolisiert keine Gerechtigkeit mehr"
  },
  RelicConfig_98423_BattleDesc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Nach jedem aktiven Schaden [Arg2] Schichten Gift auf alle Gegner auslösen, maximal 5-mal pro Runde auslösbar."
  },
  RelicConfig_98423_Desc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Nach jedem aktiven Schaden [Arg2] Schichten Gift auf alle Gegner anwenden, maximal 5-mal pro Runde auslösbar."
  },
  RelicConfig_98423_Name = {
    Text = "<WhiteQuality:Priesterstab>"
  },
  RelicConfig_98423_StoryDesc = {
    Text = "Unerlaubte Frömmigkeit"
  },
  RelicConfig_98424_BattleDesc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Sobald in der Runde zum ersten Mal Gift angewendet wurde, [Arg2] Karten ziehen."
  },
  RelicConfig_98424_Desc = {
    Text = "Beim Kampfbeginn [Arg1]% Schadensverstärkung erhalten. Sobald Gift zum ersten Mal in der Runde angewendet wird, [Arg2] Karten ziehen."
  },
  RelicConfig_98424_Name = {
    Text = "<WhiteQuality:Reindes Papyrus>"
  },
  RelicConfig_98424_StoryDesc = {
    Text = "Hier ist die Frage: 10 Mönche teilen 6 Brote, wie viel bekommt jeder?"
  },
  RelicConfig_98425_BattleDesc = {
    Text = "Beim Kampfbeginn erhält man [Arg1] Kraft. Für jede ausgespielte Karte mit „Kosten“ erhält man [Arg2] temporäre Kraft, maximal 10 Mal pro Runde auslösbar."
  },
  RelicConfig_98425_Desc = {
    Text = "Beim Kampfbeginn erhältst du [Arg1] Kraft. Für jede ausgespielte Karte mit „Kosten“ erhältst du [Arg2] temporäre Kraft, maximal 10 Mal pro Runde auslösbar."
  },
  RelicConfig_98425_Name = {
    Text = "<WhiteQuality:Spieluhr>"
  },
  RelicConfig_98425_StoryDesc = {
    Text = "In Dexters Anwesen gibt es viele Sammlungen. Bevor es zerbrach, war die kleine Spieluhr das Lieblingsspielzeug von Miss Dexter. \nDie Zeit verging, und als Miss Dexter sie wiederfand, waren die Zahnräder locker und die Musik verstimmt, aber sie drehte sich immer noch"
  },
  RelicConfig_98426_BattleDesc = {
    Text = "Beim ersten “Schlüsselbefehl“ jeder Runde alle Tentakel aktivieren, um [Arg1]-Mal gegen die Gegner zu attackieren, und 50% Schaden verursachen."
  },
  RelicConfig_98426_Desc = {
    Text = "Beim ersten “Schlüsselbefehl“ jeder Runde alle Tentakel aktivieren, um [Arg1]-Mal gegen die Gegner zu attackieren und 50% Schaden zu verursachen."
  },
  RelicConfig_98426_Name = {
    Text = "<WhiteQuality:Gelbe Schnecke>"
  },
  RelicConfig_98426_StoryDesc = {
    Text = "Diese kleine gelbe Schnecke stammt aus edlem Hause, mit perfektem, makellosem Hintergrund"
  },
  RelicConfig_98427_BattleDesc = {
    Text = "Zu Beginn des Zugs, wenn das Leben unter 50% liegt, wird der Schaden vorübergehend um [Arg1]% erhöht. Wenn das Leben unter 25% liegt, ziehe zusätzliche [Arg2] Karten und gewinne [Arg2] Arithmetica."
  },
  RelicConfig_98427_Desc = {
    Text = "Zu Beginn des Zugs, wenn das Leben unter 50% liegt, wird der Schaden vorübergehend um [Arg1]% erhöht. Wenn das Leben unter 25% liegt, ziehe zusätzliche [Arg2] Karten und gewinne [Arg2] Arithmetica."
  },
  RelicConfig_98427_Name = {
    Text = "<OrangeQuality:Arztkoffer+>"
  },
  RelicConfig_98427_StoryDesc = {
    Text = "Der Reisekoffer, der den Arzt repräsentiert, ist sehr schwer.\n\nWer ihn öffnet, ist möglicherweise kein echter Arzt.\n"
  },
  RelicConfig_98891_BattleDesc = {
    Text = "Nach Beginn des Kampfes erhalte 5 Schichten „<LostWay:verloren>\", nach dem Spielen von 3 Befehlskarten wird 1 Schicht entfernt. \n Nachdem alle „<LostWay:verloren>\" entfernt wurden, erhalten alle Erwecker 100 Punkte Aliemus, und nach dem Spielen von 3 Befehlskarten werden [Arg1] Lebenspunkte wiederhergestellt, und es wird <Corrosion:Korrosion> in Höhe von 1% der maximalen Lebenspunkte des feindlichen Frontangreifers angewendet."
  },
  RelicConfig_98891_Desc = {
    Text = "Nach Beginn des Kampfes erhalte 5 Schichten „<LostWay:verloren>\", nach dem Spielen von 3 Befehlskarten wird 1 Schicht entfernt. \n Nachdem alle „<LostWay:verloren>\" entfernt wurden, erhalten alle Erwecker 100 Punkte Aliemus, und nach dem Spielen von 3 Befehlskarten werden [Arg1] Lebenspunkte wiederhergestellt, und es wird <Corrosion:Korrosion> in Höhe von 1% der maximalen Lebenspunkte des feindlichen Frontangreifers angewendet."
  },
  RelicConfig_98891_Name = {
    Text = "künstliche Seele"
  },
  RelicConfig_98891_StoryDesc = {
    Text = "Selbst wenn die Erfahrungen düster sind, wird die rettende Laterne im Tod wieder leuchten."
  }
})
return Text_RelicConfig
