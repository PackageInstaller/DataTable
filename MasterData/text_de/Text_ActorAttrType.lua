__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ActorAttrType = readonly({
  ActorAttrType_121209_AttributeDesc = {
    Text = "Das Niveau des verbotenen Wissens entspricht dem Niveau des Schutzherrn und bestimmt die Effekte der folgenden 3 Forschungsvertiefungen. Wenn der Durchschnitt des Niveaus der erweckten Einheiten in der Formation größer oder gleich dem Niveau des Schutzherrn ist, wird das Niveau des verbotenen Wissens als Durchschnitt des Niveaus der erweckten Einheiten in der Formation und dem Niveau des Schutzherrn genommen. \nTiefe der lebenden Forschung: <Blue:{s1}> \n· Bestimmt die Stärke des Effekts, mit dem jede 100 Punkte Konstitution in Gesundheitswerte des Teams umgewandelt werden. \nForschungstiefe von Objekten: <Blue:{s2}> \n· Bestimmt die Stärke der Effekte, die von Relikten, Gebeten und Posse verursacht werden, wie Stärke, Tentakelschaden, Schild, LP-Wiederherstellung und STR▼. \nTiefe der Erkenntnisforschung: <Blue:{s3}> \n· Bestimmt die Stärke der Effekte, die von Relikten, Gebeten und Posse verursacht werden, wie fester Gift, fester Gegenangriff, fester Schaden und festes Bluten. \n"
  },
  ActorAttrType_121209_Text = {
    Text = "Verbotenes Wissenslevel"
  },
  ActorAttrType_18103_Text = {
    Text = "Rollen-Schild"
  },
  ActorAttrType_18104_Text = {
    Text = "Schlagkarten-Schadensprozentsatz-Korrektur"
  },
  ActorAttrType_18105_AttributeUpText = {
    Text = "Kritischer Schaden +{s1}"
  },
  ActorAttrType_18105_Text = {
    Text = "Krit. Schaden"
  },
  ActorAttrType_18106_Text = {
    Text = "Schutzschild erhöht"
  },
  ActorAttrType_18107_AttributeUpText = {Text = "ANG+{s1}"},
  ActorAttrType_18107_Text = {Text = "ANG"},
  ActorAttrType_18108_Text = {Text = "KON"},
  ActorAttrType_18109_Text = {
    Text = "Karten-Schadensprozentsatz-Anpassung"
  },
  ActorAttrType_18110_Text = {
    Text = "Verwundbarer Prozentsatz Anpassung"
  },
  ActorAttrType_18111_Text = {
    Text = "Erhaltener Schildprozentsatz-Anpassung"
  },
  ActorAttrType_18112_AttributeUpText = {
    Text = "VERT + {s1}"
  },
  ActorAttrType_18112_Text = {
    Text = "VERT erhöht"
  },
  ActorAttrType_18113_AttributeDesc = {
    Text = "Effizienz der Wahnsinnsaufladung des erweckten Körpers"
  },
  ActorAttrType_18113_Text = {
    Text = "Eröffnungswut"
  },
  ActorAttrType_18114_AttributeDesc = {
    Text = "Je höher die Konstitution, desto höher wird die maximale Gesundheit des Erweckers. \nJe höher das Ermittlerlevel des Hüters, desto stärker wird der Einfluss der Konstitution auf die maximale Gesundheit des Erweckers"
  },
  ActorAttrType_18114_AttributeUpText = {
    Text = "Körperbau+{s1}"
  },
  ActorAttrType_18114_Text = {Text = "KON"},
  ActorAttrType_18115_AttributeDesc = {
    Text = "Nach der Beschwörung des Wachkörpers wird der zurückgegebene Wahnsinnswert"
  },
  ActorAttrType_18115_AttributeUpText = {
    Text = "Wahnsinnsverbrauch reduziert+{s1}"
  },
  ActorAttrType_18115_Text = {
    Text = "Wutverbrauch verringert"
  },
  ActorAttrType_18116_AttributeDesc = {
    Text = "Je höher die Konstitution, desto höher wird die maximale Gesundheit des Erweckers. \nJe höher das Ermittlerlevel des Hüters, desto stärker wird der Einfluss der Konstitution auf die maximale Gesundheit des Erweckers"
  },
  ActorAttrType_18116_AttributeUpText = {
    Text = "Körperbau+{s1}"
  },
  ActorAttrType_18116_Text = {
    Text = "Körperliche Verfassung erhöhen"
  },
  ActorAttrType_18117_Text = {
    Text = "Tentakelschaden"
  },
  ActorAttrType_18118_Text = {
    Text = "Ultra-Slots"
  },
  ActorAttrType_18119_Text = {
    Text = "Erhaltener Schadenprozentsatz-Korrektur"
  },
  ActorAttrType_18120_AttributeDesc = {
    Text = "Das Wutlimit und der Wutverbrauch für die Verherrlichung des Erweckers entsprechen beide seinem Basis-Aliemus."
  },
  ActorAttrType_18120_AttributeUpText = {
    Text = "Wahnsinnsobergrenze+{s1}"
  },
  ActorAttrType_18120_Text = {
    Text = "Basis-Aliemus"
  },
  ActorAttrType_18121_AttributeDesc = {
    Text = "Fertigkeitslevel 2"
  },
  ActorAttrType_18121_AttributeUpText = {
    Text = "Fähigkeit 2 Stufe +{s1}"
  },
  ActorAttrType_18121_Text = {
    Text = "Fertigkeitslevel 2"
  },
  ActorAttrType_18122_AttributeDesc = {Text = "VERTsstufe"},
  ActorAttrType_18122_AttributeUpText = {
    Text = "VERTsstufe +{s1}"
  },
  ActorAttrType_18122_Text = {Text = "VERTsstufe"},
  ActorAttrType_18123_Text = {
    Text = "Schadenanzahl-Festwert-Korrektur"
  },
  ActorAttrType_18124_Text = {
    Text = "Verursacht eine feste Schildwertänderung"
  },
  ActorAttrType_18125_Text = {
    Text = "Erhaltene Schild-Festwert-Korrektur"
  },
  ActorAttrType_18126_AttributeDesc = {
    Text = "Die Meisterschaft des Reichs des Teams entspricht der Summe der Meisterschaft des Reichs aller Erwachten im Team. Die Meisterschaft des Reichs kann die Effekte des Reichs-Erbes des Teams verbessern. Wenn das aktuelle Team \"Reine Ruhige See/Reine Caro/Reine Ultra\" ist, wird der Effekt der Meisterschaft des Reichs verdoppelt.\n· Für <Blue:Chaos> Reichsteams gilt: Für jeden Punkt Meisterschaft des Reichs, nach der Entfaltung der Bande, erhält jeder Erwachte zusätzlich <Blue:0.05> Punkte von Aliemus.\n· Für <Blue:Aequor> Reichsteams gilt: Für jeden Punkt Meisterschaft des Reichs gibt es eine <Blue:0.25%> Chance, beim Entfalten des Exalt einen zusätzlichen Stapel Tentakelsammlung zu erhalten (Chancen über 100% können mehrere Stapel gewähren). Beim Wechsel zu \"Ruhige See\" erhöht sich die erhaltene Menge an Schild um <Blue:0.01%> Max HP, und der Tentakelschaden, der durch den aktiven Schaden in \"Tobsuchtswellen\" verursacht wird, erhöht sich um <Blue:0.02%> Tentakelschaden.\n· Für <Blue:Caro> Reichsteams gilt: Für jeden Punkt Meisterschaft des Reichs gewährt die erste in jeder Runde ausgelöste Verschlingen zusätzlich einen Schild in Höhe von <Blue:0.01%> Max HP und Temporäre Stärke von <Blue:0.005%> (steigt basierend auf verlorenem HP, bis zu einem Maximum von 100%).\n· Für <Blue:Ultra> Reichsteams gilt: Für jeden Punkt Meisterschaft des Reichs besteht zu Beginn der Runde eine <Blue:0.125%> Chance, 1 \"Einblick\" zu erhalten (Chancen über 100% können mehrere Kopien gewähren)."
  },
  ActorAttrType_18126_AttributeUpText = {
    Text = "Reichsbeherrschung+{s1}"
  },
  ActorAttrType_18126_Text = {
    Text = "Reichsbeherrschung"
  },
  ActorAttrType_18127_Text = {Text = "LP"},
  ActorAttrType_18128_AttributeUpText = {Text = "ANG+{s1}"},
  ActorAttrType_18128_Text = {
    Text = "ANG erhöht"
  },
  ActorAttrType_18129_AttributeDesc = {
    Text = "Je höher der Grundschadensbonus, desto höher der Schaden des Erwachens"
  },
  ActorAttrType_18129_AttributeUpText = {
    Text = "Grundschaden +{s1}"
  },
  ActorAttrType_18129_Text = {
    Text = "Grundschaden"
  },
  ActorAttrType_18130_Text = {Text = "Level"},
  ActorAttrType_18131_AttributeDesc = {
    Text = "Am Ende der Runde, automatische Wahnsinnsregeneration der Erwachten (im Aufgabenmodus nach jeder Aktion der Erwachten)"
  },
  ActorAttrType_18131_AttributeUpText = {
    Text = "Automatische Wahnsinnsaufladung+{s1}"
  },
  ActorAttrType_18131_Text = {
    Text = "Automatische Wut-Antwort"
  },
  ActorAttrType_18132_Text = {
    Text = "Erleuchtungsstufe"
  },
  ActorAttrType_18133_Text = {
    Text = "Anpassung des Prozentsatzes der erlittenen Wut"
  },
  ActorAttrType_18134_Text = {
    Text = "Embryonal Fusion Obergrenze"
  },
  ActorAttrType_18135_Text = {
    Text = "Rolle mit aktueller Wut"
  },
  ActorAttrType_18136_Text = {
    Text = "Feste Schadenswerte anpassen, die erlitten werden"
  },
  ActorAttrType_18137_AttributeDesc = {
    Text = "Wenn der Wachkörper einen Schild und Heilungseffekt anwendet, erhöht sich die Proportion der Schild- und Heilswerte"
  },
  ActorAttrType_18137_AttributeUpText = {
    Text = "Schild und Heilung stark + {s1}"
  },
  ActorAttrType_18137_Text = {
    Text = "Schild und Heilung verstärkt"
  },
  ActorAttrType_18138_Text = {
    Text = "Heilung erhöht"
  },
  ActorAttrType_18139_AttributeDesc = {
    Text = "Beim Spielen einer Befehlskarte oder beim Erwecken erhältst du pro verbrauchter 1 Arithmetica {s1} Keyflare. Mit zunehmendem Attributwert nimmt der zusätzliche Keyflare-Gewinn schrittweise ab."
  },
  ActorAttrType_18139_AttributeUpText = {
    Text = "Silberschlüsselaufladung +{s1}"
  },
  ActorAttrType_18139_Text = {
    Text = "Silberner Schlüssel Aufladelevel"
  },
  ActorAttrType_18140_Text = {
    Text = "Anzahl der Todwiderstände"
  },
  ActorAttrType_18141_AttributeDesc = {
    Text = "Schlagstufe"
  },
  ActorAttrType_18141_AttributeUpText = {
    Text = "ANGsstufe +{s1}"
  },
  ActorAttrType_18141_Text = {
    Text = "Schlagstufe"
  },
  ActorAttrType_18142_AttributeDesc = {
    Text = "Erhöht die Prozentangabe aller von Erweckten verursachten „Grundschäden“, auferlegten „Vergiftungen mit festem Wert“ und „Gegenangriffe mit festem Wert“ sowie den anfänglichen Tentakelschaden im Tiefsee-Grenzgebiet."
  },
  ActorAttrType_18142_AttributeUpText = {
    Text = "Starker Schaden+{s1}"
  },
  ActorAttrType_18142_Text = {
    Text = "Schadenamplifikation"
  },
  ActorAttrType_18143_Text = {
    Text = "Anpassung des Schadensprozents des Wutanfalls"
  },
  ActorAttrType_18144_AttributeDesc = {
    Text = "Widerstand gegen kritische Treffer bei aktivem Schaden des Erweckungskörpers"
  },
  ActorAttrType_18144_AttributeUpText = {
    Text = "Kritische Resistenz +{s1}"
  },
  ActorAttrType_18144_Text = {
    Text = "Krit. Widerstand"
  },
  ActorAttrType_18145_AttributeDesc = {
    Text = "Genesis Ankunft Stufe"
  },
  ActorAttrType_18145_AttributeUpText = {
    Text = "Genesis Ankunft Stufe +{s1}"
  },
  ActorAttrType_18145_Text = {
    Text = "Genesis Ankunft Stufe"
  },
  ActorAttrType_18146_Text = {
    Text = "Erhaltene Heilungsfestwertkorrektur"
  },
  ActorAttrType_18147_AttributeUpText = {
    Text = "Glücksmarkierungsrate + {s1}"
  },
  ActorAttrType_18147_Text = {
    Text = "Glückliche Gravur Rate"
  },
  ActorAttrType_18148_Text = {
    Text = "Verursacht Korrektur des festen Heilungswerts"
  },
  ActorAttrType_18149_Text = {
    Text = "Körperliche Verfassung erhöhen"
  },
  ActorAttrType_18150_Text = {
    Text = "Schwäche-Prozentanpassung"
  },
  ActorAttrType_18151_AttributeDesc = {
    Text = "Der Todwiderstand des Teams entspricht der Summe des Todwiderstands aller Erwecker im Team. \n Bei einem tödlichen Schaden im Kampf gibt es eine Chance, 1 Lebenspunkt zu behalten. Nach der Auslösung erhält man in der nächsten Runde zusätzlich 2 Punkte Arithmetica und zieht 2 Karten. Der aktuelle und zukünftige Todwiderstand wird halbiert und bleibt bis zum Ende der Ermittlung bestehen."
  },
  ActorAttrType_18151_AttributeUpText = {
    Text = "Todeswiderstand +{s1}"
  },
  ActorAttrType_18151_Text = {
    Text = "Todwiderstand"
  },
  ActorAttrType_18152_Text = {
    Text = "Verursacht eine Anpassung des Wut-Prozents"
  },
  ActorAttrType_18154_Text = {
    Text = "Tentakel-Limit"
  },
  ActorAttrType_18155_AttributeDesc = {
    Text = "Erhöht den Prozentsatz des schwarzen Siegels, das nach einem Sieg im Kampf von den Feinden fällt"
  },
  ActorAttrType_18155_AttributeUpText = {
    Text = "Schwarze Stempel fallen +{s1}"
  },
  ActorAttrType_18155_Text = {
    Text = "Siegelertrag"
  },
  ActorAttrType_18156_Text = {
    Text = "Erhalten Sie die Festwertanpassung der Wut"
  },
  ActorAttrType_18157_Text = {
    Text = "Versteckte Absichten"
  },
  ActorAttrType_18158_Text = {
    Text = "Schaden-Fixwert-Anpassung"
  },
  ActorAttrType_18159_AttributeUpText = {
    Text = "Kritische Rate +{s1}"
  },
  ActorAttrType_18159_Text = {Text = "Krit. Rate"},
  ActorAttrType_18160_AttributeDesc = {
    Text = "Fertigkeit 1 Level"
  },
  ActorAttrType_18160_AttributeUpText = {
    Text = "Fähigkeit 1 Stufe +{s1}"
  },
  ActorAttrType_18160_Text = {
    Text = "Fertigkeit 1 Level"
  },
  ActorAttrType_18161_Text = {Text = "Level"},
  ActorAttrType_18162_Text = {
    Text = "Schaden erhöht"
  },
  ActorAttrType_18163_Text = {
    Text = "Tentakelanzahl"
  },
  ActorAttrType_18164_Text = {
    Text = "Erhaltene Heilung Prozentsatz Modifikator"
  },
  ActorAttrType_18165_Text = {
    Text = "Max Arithmetica"
  },
  ActorAttrType_18166_Text = {
    Text = "Verwundbarkeitsprozent-Anpassung"
  },
  ActorAttrType_18167_AttributeUpText = {
    Text = "VERT + {s1}"
  },
  ActorAttrType_18167_Text = {Text = "VERT"},
  ActorAttrType_18168_AttributeDesc = {
    Text = "Gnosis-Erwachungsstufe"
  },
  ActorAttrType_18168_AttributeUpText = {
    Text = "Gnosis-Erwecken-Level+{s1}"
  },
  ActorAttrType_18168_Text = {
    Text = "Gnosis-Erwachungsstufe"
  },
  ActorAttrType_21322_Text = {
    Text = "Keyflare-Regeneration"
  },
  ActorAttrType_22207_AttributeDesc = {
    Text = "Nach jeder Auslösung von Aelius erhältst du {s1} Punkte Aelius. Mit der Zunahme dieser Eigenschaft verringert sich der zusätzliche Effekt allmählich"
  },
  ActorAttrType_22207_AttributeUpText = {
    Text = "Wahnsinnsaufladungsstufe+{s1}"
  },
  ActorAttrType_22207_Text = {
    Text = "Wutregenerations-Level"
  },
  ActorAttrType_22214_Text = {
    Text = "Wutregeneration"
  }
})
return Text_ActorAttrType
