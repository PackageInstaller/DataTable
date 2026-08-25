__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MonsterIntent = readonly({
  ["MonsterIntent_怪物意图不明_Name"] = {
    Text = "Sconosciuto"
  },
  ["MonsterIntent_怪物意图不明_TipId"] = {
    Text = "L'intenzione del nemico non può essere percepita."
  },
  ["MonsterIntent_怪物意图不明呢喃1_Name"] = {
    Text = "Sconosciuto"
  },
  ["MonsterIntent_怪物意图不明呢喃1_TipId"] = {
    Text = "L'intenzione del nemico non può essere percepita."
  },
  ["MonsterIntent_怪物意图不明呢喃2_Name"] = {
    Text = "Sconosciuto"
  },
  ["MonsterIntent_怪物意图不明呢喃2_TipId"] = {
    Text = "L'intenzione del nemico non può essere percepita."
  },
  ["MonsterIntent_怪物意图不明呢喃3_Name"] = {
    Text = "Sconosciuto"
  },
  ["MonsterIntent_怪物意图不明呢喃3_TipId"] = {
    Text = "L'intenzione del nemico non può essere percepita."
  },
  ["MonsterIntent_怪物意图不明呢喃4_Name"] = {
    Text = "Sconosciuto"
  },
  ["MonsterIntent_怪物意图不明呢喃4_TipId"] = {
    Text = "L'intenzione del nemico non può essere percepita."
  },
  ["MonsterIntent_怪物意图不明呢喃5_Name"] = {
    Text = "Sconosciuto"
  },
  ["MonsterIntent_怪物意图不明呢喃5_TipId"] = {
    Text = "L'intenzione del nemico non può essere percepita."
  },
  ["MonsterIntent_怪物意图不明呢喃6_Name"] = {
    Text = "Sconosciuto"
  },
  ["MonsterIntent_怪物意图不明呢喃6_TipId"] = {
    Text = "L'intenzione del nemico non può essere percepita."
  },
  ["MonsterIntent_怪物意图人面犬重攻击_Name"] = {Text = "Colpo"},
  ["MonsterIntent_怪物意图人面犬重攻击_TipId"] = {
    Text = "Infligge {s1} DAN agli alleati."
  },
  ["MonsterIntent_怪物意图削弱_Name"] = {
    Text = "Indebolimento"
  },
  ["MonsterIntent_怪物意图削弱_TipId"] = {
    Text = "Applica effetti negativi alla tua squadra."
  },
  ["MonsterIntent_怪物意图强力削弱_Name"] = {
    Text = "Indebolimento"
  },
  ["MonsterIntent_怪物意图强力削弱_TipId"] = {
    Text = "Applica un potente effetto negativo alla tua squadra."
  },
  ["MonsterIntent_怪物意图强力强化_Name"] = {Text = "Potenzia"},
  ["MonsterIntent_怪物意图强力强化_TipId"] = {
    Text = "Il nemico potenzierà se stesso."
  },
  ["MonsterIntent_怪物意图强化DCB02_2_Name"] = {Text = "Potenzia"},
  ["MonsterIntent_怪物意图强化DCB02_2_TipId"] = {
    Text = "Il nemico potenzierà se stesso."
  },
  ["MonsterIntent_怪物意图强化DCB02_4_Name"] = {Text = "Potenzia"},
  ["MonsterIntent_怪物意图强化DCB02_4_TipId"] = {
    Text = "Il nemico potenzierà se stesso."
  },
  ["MonsterIntent_怪物意图强化_Name"] = {Text = "Potenzia"},
  ["MonsterIntent_怪物意图强化_TipId"] = {
    Text = "Il nemico potenzierà se stesso."
  },
  ["MonsterIntent_怪物意图攻击_Name"] = {Text = "Colpo"},
  ["MonsterIntent_怪物意图攻击_TipId"] = {
    Text = "Infligge {s1} DAN agli alleati."
  },
  ["MonsterIntent_怪物意图攻击和削弱_Name"] = {
    Text = "Colpo e Indebolimento"
  },
  ["MonsterIntent_怪物意图攻击和削弱_TipId"] = {
    Text = "Infliggerà {s1} Danni alla tua squadra e applicherà effetti negativi."
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_Name"] = {
    Text = "Colpo e Indebolimento"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_TipId"] = {
    Text = "Infliggerà {s1} Danni alla tua squadra e applicherà effetti negativi."
  },
  ["MonsterIntent_怪物意图攻击和强化_Name"] = {
    Text = "Colpo e Potenziamento"
  },
  ["MonsterIntent_怪物意图攻击和强化_TipId"] = {
    Text = "Infligge {s1} DAN alla tua squadra e applica Potenziamento."
  },
  ["MonsterIntent_怪物意图攻击和防御_Name"] = {
    Text = "Colpo e Difesa"
  },
  ["MonsterIntent_怪物意图攻击和防御_TipId"] = {
    Text = "Infliggerà {s1} DAN alla tua squadra e otterrà Scudo del Personaggio."
  },
  ["MonsterIntent_怪物意图狂气_Name"] = {
    Text = "Esaltazione"
  },
  ["MonsterIntent_怪物意图狂气_TipId"] = {
    Text = "Il nemico scatenerà Esaltazione al prossimo turno."
  },
  ["MonsterIntent_怪物意图狂气非攻击_Name"] = {
    Text = "Esaltazione"
  },
  ["MonsterIntent_怪物意图狂气非攻击_TipId"] = {
    Text = "Il nemico scatenerà Esaltazione al prossimo turno."
  },
  ["MonsterIntent_怪物意图眩晕_Name"] = {
    Text = "Stordimento"
  },
  ["MonsterIntent_怪物意图眩晕_TipId"] = {
    Text = "Stordito e impossibilitato ad agire."
  },
  ["MonsterIntent_怪物意图超级狂气_Name"] = {
    Text = "Esaltazione"
  },
  ["MonsterIntent_怪物意图超级狂气_TipId"] = {
    Text = "Il nemico scatenerà Esaltazione al prossimo turno."
  },
  ["MonsterIntent_怪物意图释放终结_Name"] = {
    Text = "Esaltazione"
  },
  ["MonsterIntent_怪物意图释放终结_TipId"] = {
    Text = "Il nemico ti eliminerà al prossimo turno."
  },
  ["MonsterIntent_怪物意图重攻击_Name"] = {Text = "Colpo"},
  ["MonsterIntent_怪物意图重攻击_TipId"] = {
    Text = "Infligge {s1} DAN agli alleati."
  },
  ["MonsterIntent_怪物意图防御_Name"] = {Text = "Difesa"},
  ["MonsterIntent_怪物意图防御_TipId"] = {
    Text = "Il nemico otterrà Scudo del Personaggio."
  },
  ["MonsterIntent_怪物意图防御和削弱_Name"] = {
    Text = "Difesa e Indebolimento"
  },
  ["MonsterIntent_怪物意图防御和削弱_TipId"] = {
    Text = "Otterrà Scudo del Personaggio e infliggerà debuff alla tua squadra."
  },
  ["MonsterIntent_怪物意图防御和强化_Name"] = {
    Text = "Difesa e Potenziamento"
  },
  ["MonsterIntent_怪物意图防御和强化_TipId"] = {
    Text = "Otterrà Scudo del Personaggio e potenziamenti."
  }
})
return Text_MonsterIntent
