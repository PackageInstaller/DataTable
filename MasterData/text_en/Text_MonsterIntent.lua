__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MonsterIntent = readonly({
  ["MonsterIntent_怪物意图不明_Name"] = {Text = "Unknown"},
  ["MonsterIntent_怪物意图不明_TipId"] = {
    Text = "Enemy's intention cannot be perceived."
  },
  ["MonsterIntent_怪物意图不明呢喃1_Name"] = {Text = "Unknown"},
  ["MonsterIntent_怪物意图不明呢喃1_TipId"] = {
    Text = "Enemy's intention cannot be perceived."
  },
  ["MonsterIntent_怪物意图不明呢喃2_Name"] = {Text = "Unknown"},
  ["MonsterIntent_怪物意图不明呢喃2_TipId"] = {
    Text = "Enemy's intention cannot be perceived."
  },
  ["MonsterIntent_怪物意图不明呢喃3_Name"] = {Text = "Unknown"},
  ["MonsterIntent_怪物意图不明呢喃3_TipId"] = {
    Text = "Enemy's intention cannot be perceived."
  },
  ["MonsterIntent_怪物意图不明呢喃4_Name"] = {Text = "Unknown"},
  ["MonsterIntent_怪物意图不明呢喃4_TipId"] = {
    Text = "Enemy's intention cannot be perceived."
  },
  ["MonsterIntent_怪物意图不明呢喃5_Name"] = {Text = "Unknown"},
  ["MonsterIntent_怪物意图不明呢喃5_TipId"] = {
    Text = "Enemy's intention cannot be perceived."
  },
  ["MonsterIntent_怪物意图不明呢喃6_Name"] = {Text = "Unknown"},
  ["MonsterIntent_怪物意图不明呢喃6_TipId"] = {
    Text = "Enemy's intention cannot be perceived."
  },
  ["MonsterIntent_怪物意图人面犬重攻击_Name"] = {Text = "Strike"},
  ["MonsterIntent_怪物意图人面犬重攻击_TipId"] = {
    Text = "Will deal {s1} DMG to team."
  },
  ["MonsterIntent_怪物意图削弱_Name"] = {Text = "Weaken"},
  ["MonsterIntent_怪物意图削弱_TipId"] = {
    Text = "Will inflict debuff on team."
  },
  ["MonsterIntent_怪物意图强力削弱_Name"] = {Text = "Weaken"},
  ["MonsterIntent_怪物意图强力削弱_TipId"] = {
    Text = "Will inflict strong debuff on team."
  },
  ["MonsterIntent_怪物意图强力强化_Name"] = {Text = "Enhance"},
  ["MonsterIntent_怪物意图强力强化_TipId"] = {
    Text = "Enemy will enhance themselves."
  },
  ["MonsterIntent_怪物意图强化DCB02_2_Name"] = {Text = "Enhance"},
  ["MonsterIntent_怪物意图强化DCB02_2_TipId"] = {
    Text = "Enemy will enhance themselves."
  },
  ["MonsterIntent_怪物意图强化DCB02_4_Name"] = {Text = "Enhance"},
  ["MonsterIntent_怪物意图强化DCB02_4_TipId"] = {
    Text = "Enemy will enhance themselves."
  },
  ["MonsterIntent_怪物意图强化_Name"] = {Text = "Enhance"},
  ["MonsterIntent_怪物意图强化_TipId"] = {
    Text = "Enemy will enhance themselves."
  },
  ["MonsterIntent_怪物意图攻击_Name"] = {Text = "Strike"},
  ["MonsterIntent_怪物意图攻击_TipId"] = {
    Text = "Will deal {s1} DMG to team."
  },
  ["MonsterIntent_怪物意图攻击和削弱_Name"] = {
    Text = "Strike&Weaken"
  },
  ["MonsterIntent_怪物意图攻击和削弱_TipId"] = {
    Text = "Will deal {s1} DMG to team and inflict debuff."
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_Name"] = {
    Text = "Strike&Weaken"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_TipId"] = {
    Text = "Will deal {s1} DMG to team and inflict debuff."
  },
  ["MonsterIntent_怪物意图攻击和强化_Name"] = {
    Text = "Strike&Enhance"
  },
  ["MonsterIntent_怪物意图攻击和强化_TipId"] = {
    Text = "Will deal {s1} DMG to team and apply Enhance."
  },
  ["MonsterIntent_怪物意图攻击和防御_Name"] = {
    Text = "Strike&Defense"
  },
  ["MonsterIntent_怪物意图攻击和防御_TipId"] = {
    Text = "Will deal {s1} DMG to team and gain Shield."
  },
  ["MonsterIntent_怪物意图狂气_Name"] = {Text = "Exalt"},
  ["MonsterIntent_怪物意图狂气_TipId"] = {
    Text = "Enemy will unleash Exalt next turn."
  },
  ["MonsterIntent_怪物意图狂气非攻击_Name"] = {Text = "Exalt"},
  ["MonsterIntent_怪物意图狂气非攻击_TipId"] = {
    Text = "Enemy will unleash Exalt next turn."
  },
  ["MonsterIntent_怪物意图眩晕_Name"] = {Text = "Stun"},
  ["MonsterIntent_怪物意图眩晕_TipId"] = {
    Text = "Stunned and unable to act."
  },
  ["MonsterIntent_怪物意图超级狂气_Name"] = {Text = "Exalt"},
  ["MonsterIntent_怪物意图超级狂气_TipId"] = {
    Text = "Enemy will unleash Exalt next turn."
  },
  ["MonsterIntent_怪物意图释放终结_Name"] = {Text = "Exalt"},
  ["MonsterIntent_怪物意图释放终结_TipId"] = {
    Text = "Enemy will eliminate you next turn."
  },
  ["MonsterIntent_怪物意图重攻击_Name"] = {Text = "Strike"},
  ["MonsterIntent_怪物意图重攻击_TipId"] = {
    Text = "Will deal {s1} DMG to team."
  },
  ["MonsterIntent_怪物意图防御_Name"] = {Text = "Defense"},
  ["MonsterIntent_怪物意图防御_TipId"] = {
    Text = "Enemy will gain Shield."
  },
  ["MonsterIntent_怪物意图防御和削弱_Name"] = {
    Text = "Defense&Weaken"
  },
  ["MonsterIntent_怪物意图防御和削弱_TipId"] = {
    Text = "Will gain Shield and inflict debuff on team."
  },
  ["MonsterIntent_怪物意图防御和强化_Name"] = {
    Text = "Defense&Enhance"
  },
  ["MonsterIntent_怪物意图防御和强化_TipId"] = {
    Text = "Will gain Shield and enhancements."
  }
})
return Text_MonsterIntent
