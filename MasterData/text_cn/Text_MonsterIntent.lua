__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MonsterIntent = readonly({
  ["MonsterIntent_怪物意图不明_Name"] = {Text = "不明"},
  ["MonsterIntent_怪物意图不明_TipId"] = {
    Text = "下一回合的行动无法探知。"
  },
  ["MonsterIntent_怪物意图不明呢喃1_Name"] = {Text = "不明"},
  ["MonsterIntent_怪物意图不明呢喃1_TipId"] = {
    Text = "下一回合的行动无法探知。"
  },
  ["MonsterIntent_怪物意图不明呢喃2_Name"] = {Text = "不明"},
  ["MonsterIntent_怪物意图不明呢喃2_TipId"] = {
    Text = "下一回合的行动无法探知。"
  },
  ["MonsterIntent_怪物意图不明呢喃3_Name"] = {Text = "不明"},
  ["MonsterIntent_怪物意图不明呢喃3_TipId"] = {
    Text = "下一回合的行动无法探知。"
  },
  ["MonsterIntent_怪物意图不明呢喃4_Name"] = {Text = "不明"},
  ["MonsterIntent_怪物意图不明呢喃4_TipId"] = {
    Text = "下一回合的行动无法探知。"
  },
  ["MonsterIntent_怪物意图不明呢喃5_Name"] = {Text = "不明"},
  ["MonsterIntent_怪物意图不明呢喃5_TipId"] = {
    Text = "下一回合的行动无法探知。"
  },
  ["MonsterIntent_怪物意图不明呢喃6_Name"] = {Text = "不明"},
  ["MonsterIntent_怪物意图不明呢喃6_TipId"] = {
    Text = "下一回合的行动无法探知。"
  },
  ["MonsterIntent_怪物意图人面犬重攻击_Name"] = {Text = "打击"},
  ["MonsterIntent_怪物意图人面犬重攻击_TipId"] = {
    Text = "将对我方造成{s1}点伤害。"
  },
  ["MonsterIntent_怪物意图削弱_Name"] = {Text = "削弱"},
  ["MonsterIntent_怪物意图削弱_TipId"] = {
    Text = "将对我方施加负面效果。"
  },
  ["MonsterIntent_怪物意图强力削弱_Name"] = {Text = "削弱"},
  ["MonsterIntent_怪物意图强力削弱_TipId"] = {
    Text = "将对我方施加强力负面效果。"
  },
  ["MonsterIntent_怪物意图强力强化_Name"] = {Text = "强化"},
  ["MonsterIntent_怪物意图强力强化_TipId"] = {
    Text = "将进行强化。"
  },
  ["MonsterIntent_怪物意图强化DCB02_2_Name"] = {Text = "强化"},
  ["MonsterIntent_怪物意图强化DCB02_2_TipId"] = {
    Text = "将进行强化。"
  },
  ["MonsterIntent_怪物意图强化DCB02_4_Name"] = {Text = "强化"},
  ["MonsterIntent_怪物意图强化DCB02_4_TipId"] = {
    Text = "将进行强化。"
  },
  ["MonsterIntent_怪物意图强化_Name"] = {Text = "强化"},
  ["MonsterIntent_怪物意图强化_TipId"] = {
    Text = "将进行强化。"
  },
  ["MonsterIntent_怪物意图攻击_Name"] = {Text = "打击"},
  ["MonsterIntent_怪物意图攻击_TipId"] = {
    Text = "将对我方造成{s1}点伤害。"
  },
  ["MonsterIntent_怪物意图攻击和削弱_Name"] = {
    Text = "打击&削弱"
  },
  ["MonsterIntent_怪物意图攻击和削弱_TipId"] = {
    Text = "将对我方造成{s1}点伤害，并对我方施加负面效果。"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_Name"] = {
    Text = "打击&削弱"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_TipId"] = {
    Text = "将对我方造成{s1}点伤害，并对我方施加负面效果。"
  },
  ["MonsterIntent_怪物意图攻击和强化_Name"] = {
    Text = "打击&强化"
  },
  ["MonsterIntent_怪物意图攻击和强化_TipId"] = {
    Text = "将对我方造成{s1}点伤害，并进行强化。"
  },
  ["MonsterIntent_怪物意图攻击和防御_Name"] = {
    Text = "打击&防御"
  },
  ["MonsterIntent_怪物意图攻击和防御_TipId"] = {
    Text = "将对我方造成{s1}点伤害，并施加护盾。"
  },
  ["MonsterIntent_怪物意图狂气_Name"] = {
    Text = "狂气爆发"
  },
  ["MonsterIntent_怪物意图狂气_TipId"] = {
    Text = "下一回合即将释放狂气爆发"
  },
  ["MonsterIntent_怪物意图狂气非攻击_Name"] = {
    Text = "狂气爆发"
  },
  ["MonsterIntent_怪物意图狂气非攻击_TipId"] = {
    Text = "下一回合即将释放狂气爆发"
  },
  ["MonsterIntent_怪物意图眩晕_Name"] = {Text = "眩晕"},
  ["MonsterIntent_怪物意图眩晕_TipId"] = {
    Text = "处于眩晕状态，无法行动。"
  },
  ["MonsterIntent_怪物意图超级狂气_Name"] = {
    Text = "狂气爆发"
  },
  ["MonsterIntent_怪物意图超级狂气_TipId"] = {
    Text = "下一回合即将释放狂气爆发"
  },
  ["MonsterIntent_怪物意图释放终结_Name"] = {
    Text = "狂气爆发"
  },
  ["MonsterIntent_怪物意图释放终结_TipId"] = {
    Text = "下一回合即将终结玩家。"
  },
  ["MonsterIntent_怪物意图重攻击_Name"] = {Text = "打击"},
  ["MonsterIntent_怪物意图重攻击_TipId"] = {
    Text = "将对我方造成{s1}点伤害。"
  },
  ["MonsterIntent_怪物意图防御_Name"] = {Text = "防御"},
  ["MonsterIntent_怪物意图防御_TipId"] = {
    Text = "将施加护盾。"
  },
  ["MonsterIntent_怪物意图防御和削弱_Name"] = {
    Text = "防御&削弱"
  },
  ["MonsterIntent_怪物意图防御和削弱_TipId"] = {
    Text = "将施加护盾，并对我方施加负面效果。"
  },
  ["MonsterIntent_怪物意图防御和强化_Name"] = {
    Text = "防御&强化"
  },
  ["MonsterIntent_怪物意图防御和强化_TipId"] = {
    Text = "将施加护盾，并进行强化。"
  }
})
return Text_MonsterIntent
