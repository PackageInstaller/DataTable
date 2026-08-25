__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TrinketSuitEffect = readonly({
  TrinketSuitEffect_18335_Name = {Text = "Aprilhymne"},
  TrinketSuitEffect_18335_SuitEffectDesc_1 = {
    Text = "Kritischer Schaden +7,2%"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_2 = {
    Text = "Die Gruppe ist einzigartig: Zu Beginn der Runde, wenn die Gesamtheit des Lebens des Gegners über 75% liegt, erhält der Ausrüster temporär +35% kritische Rate und kritischen Schaden"
  },
  TrinketSuitEffect_18336_Name = {
    Text = "Ringgedicht (unvollständig)"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_1 = {
    Text = "Todeswiderstand +16,8%"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_2 = {
    Text = "Nach Beginn einer geraden Runde wird die Arithmetica-Kosten einer zufälligen Handkarte um 1 reduziert"
  },
  TrinketSuitEffect_18337_Name = {
    Text = "Rückkehrlinie"
  },
  TrinketSuitEffect_18337_SuitEffectDesc_1 = {
    Text = "Reichsbeherrschung +12"
  },
  TrinketSuitEffect_18337_SuitEffectDesc_2 = {
    Text = "Team Unique: Beim Kampfbeginn erhältst du eine Stärke von 12% der Angriffskraft des Ausrüsters. Wenn das aktuelle Reich Aequor ist, ändert sich der Effekt zu: „Zu Beginn jeder Runde gibt es (50+0,25*Reichsbeherrschung des Teams)% Chance, 1 Schicht Tentakelansammlung zu erhalten. Bei über 100% können mehrere Schichten erhalten werden, die Wahrscheinlichkeit verdoppelt sich im Anführer Kampf.“"
  },
  TrinketSuitEffect_18338_Name = {
    Text = "Fluchkaninchen"
  },
  TrinketSuitEffect_18338_SuitEffectDesc_1 = {
    Text = "Reichsbeherrschung +12"
  },
  TrinketSuitEffect_18338_SuitEffectDesc_2 = {
    Text = "Der Schild und die Lebensregeneration des Trägers werden um 12% erhöht"
  },
  TrinketSuitEffect_18339_Name = {Text = "Antinomie"},
  TrinketSuitEffect_18339_SuitEffectDesc_1 = {
    Text = "Silberschlüsselaufladungsgrad +7.2"
  },
  TrinketSuitEffect_18339_SuitEffectDesc_2 = {
    Text = "<TeamUnique:Team Unique>: Erhöht den Basis-Aliemus des Ausrüsters um 20. Erhöht die Krit. Rate, den Krit. Schaden, den Rollen-Schild und die LP-Wiederherstellung der Befehlskarten des Ausrüsters um 20%."
  },
  TrinketSuitEffect_18340_Name = {
    Text = "Organische Form"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_1 = {
    Text = "Schwarze Stempel fallen +3,6%"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_2 = {
    Text = "Die Gruppe ist einzigartig. Zu Beginn der Erkundung wird bis zu 100% Widerstand gegen den Tod abgezogen. Für jeden abgezogenen 1% Widerstand gegen den Tod erhöht sich der durch den Ausrüster verursachte Wahnsinn um 0,15%"
  },
  TrinketSuitEffect_18341_Name = {
    Text = "Scharlachrotes Pochen"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_1 = {
    Text = "Kritischer Schaden +7,2%"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_2 = {
    Text = "Nach der Freisetzung des Bande erhält der Ausrüstende 30% temporäre kritische Rate"
  },
  TrinketSuitEffect_18342_Name = {
    Text = "Standard Mystik SSR"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_1 = {
    Text = "Todeswiderstand +16,8%"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_2 = {
    Text = "Der Ausrüstende verursacht 15% mehr Schaden, Heilung und Schutzschild"
  },
  TrinketSuitEffect_18343_Name = {
    Text = "Standard Bündnis R"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_1 = {
    Text = "Todeswiderstand +16,8%"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_2 = {
    Text = "Der Ausrüstende verursacht 15% mehr Schaden, Heilung und Schutzschild"
  },
  TrinketSuitEffect_18344_Name = {
    Text = "Maschinengott herabsteigen"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_1 = {
    Text = "Reichsbeherrschung +12"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_2 = {
    Text = "Im ersten Zug jedes Kampfes erhält man 1 Punkt Arithmetica, im Bosskampf zusätzlich alle 4 Runden 1 Punkt Arithmetica"
  },
  TrinketSuitEffect_18345_Name = {
    Text = "Lichtsynthese-Fest"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_1 = {
    Text = "Starker Schaden +4.8%"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Team Unique>: Nachdem die Befehlskarte des Ausrüsters den Hyperraum betritt, erhöht sich die Embryofusion um +25~50. Je niedriger die aktuellen LP, desto höher die erhaltene Embryofusion."
  },
  TrinketSuitEffect_18346_Name = {
    Text = "Wiederentwicklung"
  },
  TrinketSuitEffect_18346_SuitEffectDesc_1 = {
    Text = "Wahnsinnsaufladungsstufe +2.4"
  },
  TrinketSuitEffect_18346_SuitEffectDesc_2 = {
    Text = "Einzigartig im Team: Zu Beginn der Erkundung erhält der Ausrüster 35 Punkte Aelius. Nach der Nutzung von Aelius erhält der Ausrüster am Ende jeder Runde in diesem Kampf 2 Punkte Aelius, dieser Effekt kann bis zu 3 Mal gestapelt werden"
  },
  TrinketSuitEffect_18347_Name = {
    Text = "Lebensentzug"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_1 = {
    Text = "Silberschlüsselaufladungsgrad +7.2"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_2 = {
    Text = "<TeamUnique: Team Unique>: Am Ende der Runde erhält der Ausrüster Keyflare in Höhe von 200% seiner Keyflare-Regeneration. Wenn das aktuelle Reich „Fleisch\" ist, ändert sich der Effekt zu: Für je 5 Punkte Keyflare-Regeneration, Embryofusion +1."
  },
  TrinketSuitEffect_18348_Name = {
    Text = "Traum der Medizin"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_1 = {
    Text = "Starker Schaden +4.8%"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_2 = {
    Text = "Die Gruppe ist einzigartig. Erhalt des schwarzen Siegels -8 am Ende des Kampfes, bei Kampfbeginn wird der originale Kopie der nicht-angreifenden Verteidigungs-Befehlskarte des Ausrüsters in den Ziehstapel gemischt, maximal 1 pro Art"
  },
  TrinketSuitEffect_18349_Name = {
    Text = "süße Schnecke"
  },
  TrinketSuitEffect_18349_SuitEffectDesc_1 = {
    Text = "Todeswiderstand +16,8%"
  },
  TrinketSuitEffect_18349_SuitEffectDesc_2 = {
    Text = "Team Unique. Nach der Verwendung von „Vernichtung“, wenn man sich in dieser Runde im Zustand des „Ruhigen Meeres“ befindet, erhöhen sich die Schild- und Heilungseffekte des Ausrüsters in dieser Runde um 30 %."
  },
  TrinketSuitEffect_18350_Name = {
    Text = "Theaterkatze (Unvollständig)"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_1 = {
    Text = "Todeswiderstand +16,8%"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_2 = {
    Text = "Ausrüster: Schaden gegen Feinde mit > 75% Leben ist immer kritisch"
  },
  TrinketSuitEffect_18351_Name = {
    Text = "Ring der 36 Räume"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_1 = {
    Text = "Wahnsinnsaufladungsstufe +2.4"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_2 = {
    Text = "Die Gruppe ist einzigartig. Die Obergrenze der s-Energie und der Verbrauch von Bande +200, die kritische Rate, der kritische Schaden, der Schild und die Wiederherstellung von Leben beim Exaltieren des Ausrüsters erhöhen sich um 30%"
  },
  TrinketSuitEffect_18352_Name = {
    Text = "Verzerrte Zwillinge·Weiß"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_1 = {
    Text = "Todeswiderstand +16,8%"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_2 = {
    Text = "Nach Beginn einer geraden Runde wird eine Karte mit <NothingnessIconKeywords: Nichtigkeit> und <DepleteIconKeywords: erschöpfen> der Ausrüstungsfähigkeiten \"VERT\" deiner Hand hinzugefügt"
  },
  TrinketSuitEffect_18353_Name = {
    Text = "Scharlachrote Umarmung"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_1 = {
    Text = "Kritische Rate +4.8%"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_2 = {
    Text = "Wenn der Ausrüster Schaden verursacht, erhält er 35 Punkte s-Energie. Bei kritischem Schaden erhöht sich dies auf 70 Punkte s-Energie, maximal 3 Mal pro Runde"
  },
  TrinketSuitEffect_18354_Name = {
    Text = "Standard Bündnis SR"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_1 = {
    Text = "Todeswiderstand +16,8%"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_2 = {
    Text = "Der Ausrüstende verursacht 15% mehr Schaden, Heilung und Schutzschild"
  },
  TrinketSuitEffect_18355_Name = {
    Text = "Unbefleckte Apokalypse"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_1 = {
    Text = "Silberschlüsselaufladungsgrad +7.2"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_2 = {
    Text = "Team-Einzigartig: Nach dem Freisetzen der Bande regeneriert der Ausrüster 12% seines Lebens, wobei der Effekt mit dem Verlust an Leben ansteigt, maximal bis zu 24% seines Lebens"
  },
  TrinketSuitEffect_18356_Name = {
    Text = "Steppenwolf"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_1 = {
    Text = "Starker Schaden +4.8%"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_2 = {
    Text = "Der Ausrüstende verursacht eine Erhöhung des Grundschadens um 20%, und die verursachte <IntoxicationIconKeywords:Vergiftung> und <RetaliateIconKeywords:Retaliation> erhöhen sich um 10%"
  },
  TrinketSuitEffect_18357_Name = {Text = "Ferne Fest"},
  TrinketSuitEffect_18357_SuitEffectDesc_1 = {
    Text = "Schwarze Stempel fallen +3,6%"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_2 = {
    Text = "Zu Beginn der Erkundung erhalten Sie 10 schwarze Siegel. Der „VERT“ des Ausrüsters erhöht die Schildwirkung um 60 %"
  },
  TrinketSuitEffect_18358_Name = {
    Text = "Verzerrte Zwillinge·schwarz"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_1 = {
    Text = "Kritische Rate +4.8%"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_2 = {
    Text = "Füge zu Beginn einer ungeraden Runde dem Deck eine „Schlag“-Karte mit <NothingnessIconKeywords:Nichtigkeit> und <DepleteIconKeywords:Verbrauch> hinzu"
  },
  TrinketSuitEffect_18359_Name = {
    Text = "Mädchenpuppe"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_1 = {
    Text = "Kritische Rate +4.8%"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_2 = {
    Text = "Team Unique. Nach dem ersten Verbrauch von Embryo pro Runde erhält der Ausrüster für jeden vorhandenen Tentakel 10% vorübergehenden kritischen Schaden."
  },
  TrinketSuitEffect_18360_Name = {
    Text = "Flüstern des Begräbnisplatzes"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_1 = {
    Text = "Todeswiderstand +16,8%"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_2 = {
    Text = "Zu Beginn des Levels <DeathResistanceIconKeywords:Widerstand> erhöhen sich um 25%. Nach Auslösen des Todeswiderstands erhält der Ausrüster 50 Punkte Aelius"
  },
  TrinketSuitEffect_99234_Name = {Text = "Humus"},
  TrinketSuitEffect_99234_SuitEffectDesc_1 = {
    Text = "Temporärer Text"
  },
  TrinketSuitEffect_99234_SuitEffectDesc_2 = {
    Text = "Temporärer Text"
  },
  TrinketSuitEffect_99235_Name = {
    Text = "Flugaufstieg"
  },
  TrinketSuitEffect_99235_SuitEffectDesc_1 = {
    Text = "Temporärer Text"
  },
  TrinketSuitEffect_99235_SuitEffectDesc_2 = {
    Text = "Temporärer Text"
  },
  TrinketSuitEffect_99236_Name = {Text = "Styx"},
  TrinketSuitEffect_99236_SuitEffectDesc_1 = {
    Text = "Temporärer Text"
  },
  TrinketSuitEffect_99236_SuitEffectDesc_2 = {
    Text = "Temporärer Text"
  }
})
return Text_TrinketSuitEffect
