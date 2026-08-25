__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MonsterIntent = readonly({
  ["MonsterIntent_怪物意图不明_Name"] = {Text = "Inconnu"},
  ["MonsterIntent_怪物意图不明_TipId"] = {
    Text = "Action du prochain tour indétectable"
  },
  ["MonsterIntent_怪物意图不明呢喃1_Name"] = {Text = "Inconnu"},
  ["MonsterIntent_怪物意图不明呢喃1_TipId"] = {
    Text = "Action du prochain tour indétectable"
  },
  ["MonsterIntent_怪物意图不明呢喃2_Name"] = {Text = "Inconnu"},
  ["MonsterIntent_怪物意图不明呢喃2_TipId"] = {
    Text = "Action du prochain tour indétectable"
  },
  ["MonsterIntent_怪物意图不明呢喃3_Name"] = {Text = "Inconnu"},
  ["MonsterIntent_怪物意图不明呢喃3_TipId"] = {
    Text = "Action du prochain tour indétectable"
  },
  ["MonsterIntent_怪物意图不明呢喃4_Name"] = {Text = "Inconnu"},
  ["MonsterIntent_怪物意图不明呢喃4_TipId"] = {
    Text = "Action du prochain tour indétectable"
  },
  ["MonsterIntent_怪物意图不明呢喃5_Name"] = {Text = "Inconnu"},
  ["MonsterIntent_怪物意图不明呢喃5_TipId"] = {
    Text = "Action du prochain tour indétectable"
  },
  ["MonsterIntent_怪物意图不明呢喃6_Name"] = {Text = "Inconnu"},
  ["MonsterIntent_怪物意图不明呢喃6_TipId"] = {
    Text = "Action du prochain tour indétectable"
  },
  ["MonsterIntent_怪物意图人面犬重攻击_Name"] = {Text = "Attaque"},
  ["MonsterIntent_怪物意图人面犬重攻击_TipId"] = {
    Text = "Infligera {s1} points de dégâts à notre équipe"
  },
  ["MonsterIntent_怪物意图削弱_Name"] = {Text = "Affaiblir"},
  ["MonsterIntent_怪物意图削弱_TipId"] = {
    Text = "Appliquera un effet négatif à notre équipe"
  },
  ["MonsterIntent_怪物意图强力削弱_Name"] = {Text = "Affaiblir"},
  ["MonsterIntent_怪物意图强力削弱_TipId"] = {
    Text = "Appliquera un puissant effet négatif à notre équipe"
  },
  ["MonsterIntent_怪物意图强力强化_Name"] = {
    Text = "Renforcement"
  },
  ["MonsterIntent_怪物意图强力强化_TipId"] = {Text = "Renforcera"},
  ["MonsterIntent_怪物意图强化DCB02_2_Name"] = {
    Text = "Renforcement"
  },
  ["MonsterIntent_怪物意图强化DCB02_2_TipId"] = {Text = "Renforcera"},
  ["MonsterIntent_怪物意图强化DCB02_4_Name"] = {
    Text = "Renforcement"
  },
  ["MonsterIntent_怪物意图强化DCB02_4_TipId"] = {Text = "Renforcera"},
  ["MonsterIntent_怪物意图强化_Name"] = {
    Text = "Renforcement"
  },
  ["MonsterIntent_怪物意图强化_TipId"] = {Text = "Renforcera"},
  ["MonsterIntent_怪物意图攻击_Name"] = {Text = "Attaque"},
  ["MonsterIntent_怪物意图攻击_TipId"] = {
    Text = "Infligera {s1} points de dégâts à notre équipe"
  },
  ["MonsterIntent_怪物意图攻击和削弱_Name"] = {
    Text = "Frappe & Affaiblit"
  },
  ["MonsterIntent_怪物意图攻击和削弱_TipId"] = {
    Text = "Infligera {s1} points de dégâts et appliquera un effet négatif à notre équipe"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_Name"] = {
    Text = "Frappe & Affaiblit"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_TipId"] = {
    Text = "Infligera {s1} points de dégâts et appliquera un effet négatif à notre équipe"
  },
  ["MonsterIntent_怪物意图攻击和强化_Name"] = {
    Text = "Attaque & renforcement"
  },
  ["MonsterIntent_怪物意图攻击和强化_TipId"] = {
    Text = "Infligera {s1} points de dégâts et renforcera"
  },
  ["MonsterIntent_怪物意图攻击和防御_Name"] = {
    Text = "Frappe & Défense"
  },
  ["MonsterIntent_怪物意图攻击和防御_TipId"] = {
    Text = "Infligera {s1} points de dégâts et appliquera un bouclier"
  },
  ["MonsterIntent_怪物意图狂气_Name"] = {Text = "Exaltation"},
  ["MonsterIntent_怪物意图狂气_TipId"] = {
    Text = "Une nouvelle explosion de folie sera libérée au prochain tour"
  },
  ["MonsterIntent_怪物意图狂气非攻击_Name"] = {Text = "Exaltation"},
  ["MonsterIntent_怪物意图狂气非攻击_TipId"] = {
    Text = "Une nouvelle explosion de folie sera libérée au prochain tour"
  },
  ["MonsterIntent_怪物意图眩晕_Name"] = {
    Text = "Étourdissement"
  },
  ["MonsterIntent_怪物意图眩晕_TipId"] = {
    Text = "En état d'étourdissement, impossible d'agir"
  },
  ["MonsterIntent_怪物意图超级狂气_Name"] = {Text = "Exaltation"},
  ["MonsterIntent_怪物意图超级狂气_TipId"] = {
    Text = "Une nouvelle explosion de folie sera libérée au prochain tour"
  },
  ["MonsterIntent_怪物意图释放终结_Name"] = {Text = "Exaltation"},
  ["MonsterIntent_怪物意图释放终结_TipId"] = {
    Text = "Le joueur sera éliminé au prochain tour."
  },
  ["MonsterIntent_怪物意图重攻击_Name"] = {Text = "Attaque"},
  ["MonsterIntent_怪物意图重攻击_TipId"] = {
    Text = "Infligera {s1} points de dégâts à notre équipe"
  },
  ["MonsterIntent_怪物意图防御_Name"] = {Text = "Défense"},
  ["MonsterIntent_怪物意图防御_TipId"] = {
    Text = "Appliquera un bouclier"
  },
  ["MonsterIntent_怪物意图防御和削弱_Name"] = {
    Text = "Défense & affaiblissement"
  },
  ["MonsterIntent_怪物意图防御和削弱_TipId"] = {
    Text = "Appliquera un bouclier et un effet négatif à notre équipe"
  },
  ["MonsterIntent_怪物意图防御和强化_Name"] = {
    Text = "Défense & Renforcer"
  },
  ["MonsterIntent_怪物意图防御和强化_TipId"] = {
    Text = "Appliquera un bouclier et renforcera"
  }
})
return Text_MonsterIntent
