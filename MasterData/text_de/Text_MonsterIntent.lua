__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MonsterIntent = readonly({
  ["MonsterIntent_怪物意图不明_Name"] = {Text = "Unbekannt"},
  ["MonsterIntent_怪物意图不明_TipId"] = {
    Text = "Die Aktionen des nächsten Zuges sind nicht vorhersehbar"
  },
  ["MonsterIntent_怪物意图不明呢喃1_Name"] = {Text = "Unbekannt"},
  ["MonsterIntent_怪物意图不明呢喃1_TipId"] = {
    Text = "Die Aktionen des nächsten Zuges sind nicht vorhersehbar"
  },
  ["MonsterIntent_怪物意图不明呢喃2_Name"] = {Text = "Unbekannt"},
  ["MonsterIntent_怪物意图不明呢喃2_TipId"] = {
    Text = "Die Aktionen des nächsten Zuges sind nicht vorhersehbar"
  },
  ["MonsterIntent_怪物意图不明呢喃3_Name"] = {Text = "Unbekannt"},
  ["MonsterIntent_怪物意图不明呢喃3_TipId"] = {
    Text = "Die Aktionen des nächsten Zuges sind nicht vorhersehbar"
  },
  ["MonsterIntent_怪物意图不明呢喃4_Name"] = {Text = "Unbekannt"},
  ["MonsterIntent_怪物意图不明呢喃4_TipId"] = {
    Text = "Die Aktionen des nächsten Zuges sind nicht vorhersehbar"
  },
  ["MonsterIntent_怪物意图不明呢喃5_Name"] = {Text = "Unbekannt"},
  ["MonsterIntent_怪物意图不明呢喃5_TipId"] = {
    Text = "Die Aktionen des nächsten Zuges sind nicht vorhersehbar"
  },
  ["MonsterIntent_怪物意图不明呢喃6_Name"] = {Text = "Unbekannt"},
  ["MonsterIntent_怪物意图不明呢喃6_TipId"] = {
    Text = "Die Aktionen des nächsten Zuges sind nicht vorhersehbar"
  },
  ["MonsterIntent_怪物意图人面犬重攻击_Name"] = {Text = "Schlag"},
  ["MonsterIntent_怪物意图人面犬重攻击_TipId"] = {
    Text = "Wird uns {s1} Schaden zufügen"
  },
  ["MonsterIntent_怪物意图削弱_Name"] = {Text = "Schwächen"},
  ["MonsterIntent_怪物意图削弱_TipId"] = {
    Text = "Wird einen negativen Effekt auf uns anwenden"
  },
  ["MonsterIntent_怪物意图强力削弱_Name"] = {Text = "Schwächen"},
  ["MonsterIntent_怪物意图强力削弱_TipId"] = {
    Text = "Wird einen starken negativen Effekt auf uns anwenden"
  },
  ["MonsterIntent_怪物意图强力强化_Name"] = {
    Text = "Verstärkung"
  },
  ["MonsterIntent_怪物意图强力强化_TipId"] = {
    Text = "Wird verstärken"
  },
  ["MonsterIntent_怪物意图强化DCB02_2_Name"] = {
    Text = "Verstärkung"
  },
  ["MonsterIntent_怪物意图强化DCB02_2_TipId"] = {
    Text = "Wird verstärken"
  },
  ["MonsterIntent_怪物意图强化DCB02_4_Name"] = {
    Text = "Verstärkung"
  },
  ["MonsterIntent_怪物意图强化DCB02_4_TipId"] = {
    Text = "Wird verstärken"
  },
  ["MonsterIntent_怪物意图强化_Name"] = {
    Text = "Verstärkung"
  },
  ["MonsterIntent_怪物意图强化_TipId"] = {
    Text = "Wird verstärken"
  },
  ["MonsterIntent_怪物意图攻击_Name"] = {Text = "Schlag"},
  ["MonsterIntent_怪物意图攻击_TipId"] = {
    Text = "Wird uns {s1} Schaden zufügen"
  },
  ["MonsterIntent_怪物意图攻击和削弱_Name"] = {
    Text = "Schlag & Schwächung"
  },
  ["MonsterIntent_怪物意图攻击和削弱_TipId"] = {
    Text = "Wird uns {s1} Schaden zufügen und einen negativen Effekt anwenden"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_Name"] = {
    Text = "Schlag & Schwächung"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_TipId"] = {
    Text = "Wird uns {s1} Schaden zufügen und einen negativen Effekt anwenden"
  },
  ["MonsterIntent_怪物意图攻击和强化_Name"] = {
    Text = "Schlag & Stärken"
  },
  ["MonsterIntent_怪物意图攻击和强化_TipId"] = {
    Text = "Wird uns {s1} Schaden zufügen und verstärken"
  },
  ["MonsterIntent_怪物意图攻击和防御_Name"] = {
    Text = "Schlag & VERT"
  },
  ["MonsterIntent_怪物意图攻击和防御_TipId"] = {
    Text = "Wird uns {s1} Schaden zufügen und einen Schild anwenden."
  },
  ["MonsterIntent_怪物意图狂气_Name"] = {
    Text = "Verherrlichung"
  },
  ["MonsterIntent_怪物意图狂气_TipId"] = {
    Text = "Die nächste Runde wird bald einen Exaltieren freisetzen"
  },
  ["MonsterIntent_怪物意图狂气非攻击_Name"] = {
    Text = "Verherrlichung"
  },
  ["MonsterIntent_怪物意图狂气非攻击_TipId"] = {
    Text = "Die nächste Runde wird bald einen Exaltieren freisetzen"
  },
  ["MonsterIntent_怪物意图眩晕_Name"] = {Text = "Betäuben"},
  ["MonsterIntent_怪物意图眩晕_TipId"] = {
    Text = "Im Zustand Betäubung, keine Aktion möglich"
  },
  ["MonsterIntent_怪物意图超级狂气_Name"] = {
    Text = "Verherrlichung"
  },
  ["MonsterIntent_怪物意图超级狂气_TipId"] = {
    Text = "Die nächste Runde wird bald einen Exaltieren freisetzen"
  },
  ["MonsterIntent_怪物意图释放终结_Name"] = {
    Text = "Verherrlichung"
  },
  ["MonsterIntent_怪物意图释放终结_TipId"] = {
    Text = "Die nächste Runde wird den Spieler töten."
  },
  ["MonsterIntent_怪物意图重攻击_Name"] = {Text = "Schlag"},
  ["MonsterIntent_怪物意图重攻击_TipId"] = {
    Text = "Wird uns {s1} Schaden zufügen"
  },
  ["MonsterIntent_怪物意图防御_Name"] = {Text = "VERT"},
  ["MonsterIntent_怪物意图防御_TipId"] = {
    Text = "Wird einen Schild anwenden"
  },
  ["MonsterIntent_怪物意图防御和削弱_Name"] = {
    Text = "VERT & Schwächung"
  },
  ["MonsterIntent_怪物意图防御和削弱_TipId"] = {
    Text = "Wird einen Schild anwenden und einen negativen Effekt auf uns anwenden"
  },
  ["MonsterIntent_怪物意图防御和强化_Name"] = {
    Text = "VERT & Verstärkung"
  },
  ["MonsterIntent_怪物意图防御和强化_TipId"] = {
    Text = "Wird einen Schild anwenden und verstärken"
  }
})
return Text_MonsterIntent
