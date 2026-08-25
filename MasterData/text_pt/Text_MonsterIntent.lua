__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MonsterIntent = readonly({
  ["MonsterIntent_怪物意图不明_Name"] = {
    Text = "Desconhecido"
  },
  ["MonsterIntent_怪物意图不明_TipId"] = {
    Text = "A ação do próximo turno é imprevisível"
  },
  ["MonsterIntent_怪物意图不明呢喃1_Name"] = {
    Text = "Desconhecido"
  },
  ["MonsterIntent_怪物意图不明呢喃1_TipId"] = {
    Text = "A ação do próximo turno é imprevisível"
  },
  ["MonsterIntent_怪物意图不明呢喃2_Name"] = {
    Text = "Desconhecido"
  },
  ["MonsterIntent_怪物意图不明呢喃2_TipId"] = {
    Text = "A ação do próximo turno é imprevisível"
  },
  ["MonsterIntent_怪物意图不明呢喃3_Name"] = {
    Text = "Desconhecido"
  },
  ["MonsterIntent_怪物意图不明呢喃3_TipId"] = {
    Text = "A ação do próximo turno é imprevisível"
  },
  ["MonsterIntent_怪物意图不明呢喃4_Name"] = {
    Text = "Desconhecido"
  },
  ["MonsterIntent_怪物意图不明呢喃4_TipId"] = {
    Text = "A ação do próximo turno é imprevisível"
  },
  ["MonsterIntent_怪物意图不明呢喃5_Name"] = {
    Text = "Desconhecido"
  },
  ["MonsterIntent_怪物意图不明呢喃5_TipId"] = {
    Text = "A ação do próximo turno é imprevisível"
  },
  ["MonsterIntent_怪物意图不明呢喃6_Name"] = {
    Text = "Desconhecido"
  },
  ["MonsterIntent_怪物意图不明呢喃6_TipId"] = {
    Text = "A ação do próximo turno é imprevisível"
  },
  ["MonsterIntent_怪物意图人面犬重攻击_Name"] = {Text = "golpear"},
  ["MonsterIntent_怪物意图人面犬重攻击_TipId"] = {
    Text = "Causará {s1} de dano à nossa equipe"
  },
  ["MonsterIntent_怪物意图削弱_Name"] = {
    Text = "Enfraquecer"
  },
  ["MonsterIntent_怪物意图削弱_TipId"] = {
    Text = "Aplicará um efeito negativo em nossa equipe"
  },
  ["MonsterIntent_怪物意图强力削弱_Name"] = {
    Text = "Enfraquecer"
  },
  ["MonsterIntent_怪物意图强力削弱_TipId"] = {
    Text = "Aplicará um efeito negativo forte em nossa equipe"
  },
  ["MonsterIntent_怪物意图强力强化_Name"] = {Text = "Reforço"},
  ["MonsterIntent_怪物意图强力强化_TipId"] = {
    Text = "Fortalecerá"
  },
  ["MonsterIntent_怪物意图强化DCB02_2_Name"] = {Text = "Reforço"},
  ["MonsterIntent_怪物意图强化DCB02_2_TipId"] = {
    Text = "Fortalecerá"
  },
  ["MonsterIntent_怪物意图强化DCB02_4_Name"] = {Text = "Reforço"},
  ["MonsterIntent_怪物意图强化DCB02_4_TipId"] = {
    Text = "Fortalecerá"
  },
  ["MonsterIntent_怪物意图强化_Name"] = {Text = "Reforço"},
  ["MonsterIntent_怪物意图强化_TipId"] = {
    Text = "Fortalecerá"
  },
  ["MonsterIntent_怪物意图攻击_Name"] = {Text = "golpear"},
  ["MonsterIntent_怪物意图攻击_TipId"] = {
    Text = "Causará {s1} de dano à nossa equipe"
  },
  ["MonsterIntent_怪物意图攻击和削弱_Name"] = {
    Text = "Golpe & Enfraquecer"
  },
  ["MonsterIntent_怪物意图攻击和削弱_TipId"] = {
    Text = "Causará {s1} de dano à nossa equipe e aplicará um efeito negativo"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_Name"] = {
    Text = "Golpe & Enfraquecer"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_TipId"] = {
    Text = "Causará {s1} de dano à nossa equipe e aplicará um efeito negativo"
  },
  ["MonsterIntent_怪物意图攻击和强化_Name"] = {
    Text = "Golpe & Fortalecer"
  },
  ["MonsterIntent_怪物意图攻击和强化_TipId"] = {
    Text = "Causará {s1} de dano à nossa equipe e se fortalecerá"
  },
  ["MonsterIntent_怪物意图攻击和防御_Name"] = {
    Text = "Golpe & Defesa"
  },
  ["MonsterIntent_怪物意图攻击和防御_TipId"] = {
    Text = "Causará {s1} de dano à nossa equipe e aplicará um escudo"
  },
  ["MonsterIntent_怪物意图狂气_Name"] = {
    Text = "Fúria Explosiva"
  },
  ["MonsterIntent_怪物意图狂气_TipId"] = {
    Text = "A próxima rodada liberará a exaltação"
  },
  ["MonsterIntent_怪物意图狂气非攻击_Name"] = {
    Text = "Fúria Explosiva"
  },
  ["MonsterIntent_怪物意图狂气非攻击_TipId"] = {
    Text = "A próxima rodada liberará a exaltação"
  },
  ["MonsterIntent_怪物意图眩晕_Name"] = {Text = "Tontura"},
  ["MonsterIntent_怪物意图眩晕_TipId"] = {
    Text = "Em estado de atordoamento, não pode agir"
  },
  ["MonsterIntent_怪物意图超级狂气_Name"] = {
    Text = "Fúria Explosiva"
  },
  ["MonsterIntent_怪物意图超级狂气_TipId"] = {
    Text = "A próxima rodada liberará a exaltação"
  },
  ["MonsterIntent_怪物意图释放终结_Name"] = {
    Text = "Fúria Explosiva"
  },
  ["MonsterIntent_怪物意图释放终结_TipId"] = {
    Text = "A próxima rodada irá eliminar o jogador."
  },
  ["MonsterIntent_怪物意图重攻击_Name"] = {Text = "golpear"},
  ["MonsterIntent_怪物意图重攻击_TipId"] = {
    Text = "Causará {s1} de dano à nossa equipe"
  },
  ["MonsterIntent_怪物意图防御_Name"] = {Text = "Defesa"},
  ["MonsterIntent_怪物意图防御_TipId"] = {
    Text = "Aplicará um escudo"
  },
  ["MonsterIntent_怪物意图防御和削弱_Name"] = {
    Text = "Defesa & Enfraquecimento"
  },
  ["MonsterIntent_怪物意图防御和削弱_TipId"] = {
    Text = "Aplicará um escudo e um efeito negativo em nossa equipe"
  },
  ["MonsterIntent_怪物意图防御和强化_Name"] = {
    Text = "Defesa & Fortalecer"
  },
  ["MonsterIntent_怪物意图防御和强化_TipId"] = {
    Text = "Aplicará um escudo e se fortalecerá"
  }
})
return Text_MonsterIntent
