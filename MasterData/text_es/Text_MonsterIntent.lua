__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MonsterIntent = readonly({
  ["MonsterIntent_怪物意图不明_Name"] = {
    Text = "Desconocido"
  },
  ["MonsterIntent_怪物意图不明_TipId"] = {
    Text = "La acción del próximo turno es indetectable"
  },
  ["MonsterIntent_怪物意图不明呢喃1_Name"] = {
    Text = "Desconocido"
  },
  ["MonsterIntent_怪物意图不明呢喃1_TipId"] = {
    Text = "La acción del próximo turno es indetectable"
  },
  ["MonsterIntent_怪物意图不明呢喃2_Name"] = {
    Text = "Desconocido"
  },
  ["MonsterIntent_怪物意图不明呢喃2_TipId"] = {
    Text = "La acción del próximo turno es indetectable"
  },
  ["MonsterIntent_怪物意图不明呢喃3_Name"] = {
    Text = "Desconocido"
  },
  ["MonsterIntent_怪物意图不明呢喃3_TipId"] = {
    Text = "La acción del próximo turno es indetectable"
  },
  ["MonsterIntent_怪物意图不明呢喃4_Name"] = {
    Text = "Desconocido"
  },
  ["MonsterIntent_怪物意图不明呢喃4_TipId"] = {
    Text = "La acción del próximo turno es indetectable"
  },
  ["MonsterIntent_怪物意图不明呢喃5_Name"] = {
    Text = "Desconocido"
  },
  ["MonsterIntent_怪物意图不明呢喃5_TipId"] = {
    Text = "La acción del próximo turno es indetectable"
  },
  ["MonsterIntent_怪物意图不明呢喃6_Name"] = {
    Text = "Desconocido"
  },
  ["MonsterIntent_怪物意图不明呢喃6_TipId"] = {
    Text = "La acción del próximo turno es indetectable"
  },
  ["MonsterIntent_怪物意图人面犬重攻击_Name"] = {Text = "golpear"},
  ["MonsterIntent_怪物意图人面犬重攻击_TipId"] = {
    Text = "Causará {s1} puntos de daño a nuestro equipo"
  },
  ["MonsterIntent_怪物意图削弱_Name"] = {Text = "Debilitar"},
  ["MonsterIntent_怪物意图削弱_TipId"] = {
    Text = "Aplicará un efecto negativo a nuestro equipo"
  },
  ["MonsterIntent_怪物意图强力削弱_Name"] = {Text = "Debilitar"},
  ["MonsterIntent_怪物意图强力削弱_TipId"] = {
    Text = "Aplicará un fuerte efecto negativo a nuestro equipo"
  },
  ["MonsterIntent_怪物意图强力强化_Name"] = {Text = "Refuerzo"},
  ["MonsterIntent_怪物意图强力强化_TipId"] = {
    Text = "Se fortalecerá"
  },
  ["MonsterIntent_怪物意图强化DCB02_2_Name"] = {Text = "Refuerzo"},
  ["MonsterIntent_怪物意图强化DCB02_2_TipId"] = {
    Text = "Se fortalecerá"
  },
  ["MonsterIntent_怪物意图强化DCB02_4_Name"] = {Text = "Refuerzo"},
  ["MonsterIntent_怪物意图强化DCB02_4_TipId"] = {
    Text = "Se fortalecerá"
  },
  ["MonsterIntent_怪物意图强化_Name"] = {Text = "Refuerzo"},
  ["MonsterIntent_怪物意图强化_TipId"] = {
    Text = "Se fortalecerá"
  },
  ["MonsterIntent_怪物意图攻击_Name"] = {Text = "golpear"},
  ["MonsterIntent_怪物意图攻击_TipId"] = {
    Text = "Causará {s1} puntos de daño a nuestro equipo"
  },
  ["MonsterIntent_怪物意图攻击和削弱_Name"] = {
    Text = "Golpe & Debilitar"
  },
  ["MonsterIntent_怪物意图攻击和削弱_TipId"] = {
    Text = "Causará {s1} puntos de daño a nuestro equipo y aplicará un efecto negativo"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_Name"] = {
    Text = "Golpe & Debilitar"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_TipId"] = {
    Text = "Causará {s1} puntos de daño a nuestro equipo y aplicará un efecto negativo"
  },
  ["MonsterIntent_怪物意图攻击和强化_Name"] = {
    Text = "Golpe & Fortalecer"
  },
  ["MonsterIntent_怪物意图攻击和强化_TipId"] = {
    Text = "Causará {s1} puntos de daño a nuestro equipo y se fortalecerá"
  },
  ["MonsterIntent_怪物意图攻击和防御_Name"] = {
    Text = "Golpe & DEF"
  },
  ["MonsterIntent_怪物意图攻击和防御_TipId"] = {
    Text = "Causará {s1} puntos de daño a nuestro equipo y aplicará un escudo"
  },
  ["MonsterIntent_怪物意图狂气_Name"] = {Text = "Exaltar"},
  ["MonsterIntent_怪物意图狂气_TipId"] = {
    Text = "La siguiente ronda liberará la exaltación"
  },
  ["MonsterIntent_怪物意图狂气非攻击_Name"] = {Text = "Exaltar"},
  ["MonsterIntent_怪物意图狂气非攻击_TipId"] = {
    Text = "La siguiente ronda liberará la exaltación"
  },
  ["MonsterIntent_怪物意图眩晕_Name"] = {Text = "Aturdir"},
  ["MonsterIntent_怪物意图眩晕_TipId"] = {
    Text = "En estado de aturdimiento, no puede actuar"
  },
  ["MonsterIntent_怪物意图超级狂气_Name"] = {Text = "Exaltar"},
  ["MonsterIntent_怪物意图超级狂气_TipId"] = {
    Text = "La siguiente ronda liberará la exaltación"
  },
  ["MonsterIntent_怪物意图释放终结_Name"] = {Text = "Exaltar"},
  ["MonsterIntent_怪物意图释放终结_TipId"] = {
    Text = "La siguiente ronda pondrá fin al jugador."
  },
  ["MonsterIntent_怪物意图重攻击_Name"] = {Text = "golpear"},
  ["MonsterIntent_怪物意图重攻击_TipId"] = {
    Text = "Causará {s1} puntos de daño a nuestro equipo"
  },
  ["MonsterIntent_怪物意图防御_Name"] = {Text = "DEF"},
  ["MonsterIntent_怪物意图防御_TipId"] = {
    Text = "Aplicará un escudo"
  },
  ["MonsterIntent_怪物意图防御和削弱_Name"] = {
    Text = "DEF & Debilitamiento"
  },
  ["MonsterIntent_怪物意图防御和削弱_TipId"] = {
    Text = "Aplicará un escudo y un efecto negativo a nuestro equipo"
  },
  ["MonsterIntent_怪物意图防御和强化_Name"] = {
    Text = "DEF & Fortalecer"
  },
  ["MonsterIntent_怪物意图防御和强化_TipId"] = {
    Text = "Aplicará un escudo y se fortalecerá"
  }
})
return Text_MonsterIntent
