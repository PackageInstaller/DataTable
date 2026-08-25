__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MonsterIntent = readonly({
  ["MonsterIntent_怪物意图不明_TipId"] = {
    Text = "次のターンの行動は予測不可能。"
  },
  ["MonsterIntent_怪物意图不明呢喃1_TipId"] = {
    Text = "次のターンの行動は予測不可能。"
  },
  ["MonsterIntent_怪物意图不明呢喃2_TipId"] = {
    Text = "次のターンの行動は予測不可能。"
  },
  ["MonsterIntent_怪物意图不明呢喃3_TipId"] = {
    Text = "次のターンの行動は予測不可能。"
  },
  ["MonsterIntent_怪物意图不明呢喃4_TipId"] = {
    Text = "次のターンの行動は予測不可能。"
  },
  ["MonsterIntent_怪物意图不明呢喃5_TipId"] = {
    Text = "次のターンの行動は予測不可能。"
  },
  ["MonsterIntent_怪物意图不明呢喃6_TipId"] = {
    Text = "次のターンの行動は予測不可能。"
  },
  ["MonsterIntent_怪物意图人面犬重攻击_Name"] = {Text = "攻撃"},
  ["MonsterIntent_怪物意图人面犬重攻击_TipId"] = {
    Text = "味方に{s1}ダメージを与える。"
  },
  ["MonsterIntent_怪物意图削弱_Name"] = {Text = "弱体化"},
  ["MonsterIntent_怪物意图削弱_TipId"] = {
    Text = "味方にデバフを付与する。"
  },
  ["MonsterIntent_怪物意图强力削弱_Name"] = {Text = "弱体化"},
  ["MonsterIntent_怪物意图强力削弱_TipId"] = {
    Text = "味方に強力なデバフを付与する。"
  },
  ["MonsterIntent_怪物意图强力强化_Name"] = {Text = "強化"},
  ["MonsterIntent_怪物意图强力强化_TipId"] = {
    Text = "強化する。"
  },
  ["MonsterIntent_怪物意图强化DCB02_2_Name"] = {Text = "強化"},
  ["MonsterIntent_怪物意图强化DCB02_2_TipId"] = {
    Text = "強化する。"
  },
  ["MonsterIntent_怪物意图强化DCB02_4_Name"] = {Text = "強化"},
  ["MonsterIntent_怪物意图强化DCB02_4_TipId"] = {
    Text = "強化する。"
  },
  ["MonsterIntent_怪物意图强化_Name"] = {Text = "強化"},
  ["MonsterIntent_怪物意图强化_TipId"] = {
    Text = "強化する。"
  },
  ["MonsterIntent_怪物意图攻击_Name"] = {Text = "攻撃"},
  ["MonsterIntent_怪物意图攻击_TipId"] = {
    Text = "味方に{s1}ダメージを与える。"
  },
  ["MonsterIntent_怪物意图攻击和削弱_Name"] = {
    Text = "攻撃&弱体化"
  },
  ["MonsterIntent_怪物意图攻击和削弱_TipId"] = {
    Text = "味方に{s1}ダメージを与え、デバフを付与する。"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_Name"] = {
    Text = "攻撃&弱体化"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_TipId"] = {
    Text = "味方に{s1}ダメージを与え、デバフを付与する。"
  },
  ["MonsterIntent_怪物意图攻击和强化_Name"] = {
    Text = "攻撃&強化"
  },
  ["MonsterIntent_怪物意图攻击和强化_TipId"] = {
    Text = "味方に{s1}ダメージを与え、強化する。"
  },
  ["MonsterIntent_怪物意图攻击和防御_Name"] = {
    Text = "攻撃&防御"
  },
  ["MonsterIntent_怪物意图攻击和防御_TipId"] = {
    Text = "味方に{s1}ダメージを与え、シールドを付与する。"
  },
  ["MonsterIntent_怪物意图狂气_Name"] = {
    Text = "狂気解放"
  },
  ["MonsterIntent_怪物意图狂气_TipId"] = {
    Text = "次のターンで狂気解放を発動。"
  },
  ["MonsterIntent_怪物意图狂气非攻击_Name"] = {
    Text = "狂気解放"
  },
  ["MonsterIntent_怪物意图狂气非攻击_TipId"] = {
    Text = "次のターンで狂気解放を発動。"
  },
  ["MonsterIntent_怪物意图眩晕_Name"] = {Text = "眩暈"},
  ["MonsterIntent_怪物意图眩晕_TipId"] = {
    Text = "眩暈状態では行動できない。"
  },
  ["MonsterIntent_怪物意图超级狂气_Name"] = {
    Text = "狂気解放"
  },
  ["MonsterIntent_怪物意图超级狂气_TipId"] = {
    Text = "次のターンで狂気解放を発動。"
  },
  ["MonsterIntent_怪物意图释放终结_Name"] = {
    Text = "狂気解放"
  },
  ["MonsterIntent_怪物意图释放终结_TipId"] = {
    Text = "次のターンでプレイヤーを終了させる。"
  },
  ["MonsterIntent_怪物意图重攻击_Name"] = {Text = "攻撃"},
  ["MonsterIntent_怪物意图重攻击_TipId"] = {
    Text = "味方に{s1}ダメージを与える。"
  },
  ["MonsterIntent_怪物意图防御_TipId"] = {
    Text = "シールドを付与する。"
  },
  ["MonsterIntent_怪物意图防御和削弱_Name"] = {
    Text = "防御&弱体化"
  },
  ["MonsterIntent_怪物意图防御和削弱_TipId"] = {
    Text = "シールドを付与し、味方にデバフを付与する。"
  },
  ["MonsterIntent_怪物意图防御和强化_Name"] = {
    Text = "防御&強化"
  },
  ["MonsterIntent_怪物意图防御和强化_TipId"] = {
    Text = "シールドを付与し、強化する。"
  }
})
return Text_MonsterIntent
