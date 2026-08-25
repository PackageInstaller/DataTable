__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MonsterIntent = readonly({
  ["MonsterIntent_怪物意图不明_Name"] = {
    Text = "알 수 없음"
  },
  ["MonsterIntent_怪物意图不明_TipId"] = {
    Text = "다음 턴의 행동을 예측할 수 없습니다."
  },
  ["MonsterIntent_怪物意图不明呢喃1_Name"] = {
    Text = "알 수 없음"
  },
  ["MonsterIntent_怪物意图不明呢喃1_TipId"] = {
    Text = "다음 턴의 행동은 예측할 수 없습니다."
  },
  ["MonsterIntent_怪物意图不明呢喃2_Name"] = {
    Text = "알 수 없음"
  },
  ["MonsterIntent_怪物意图不明呢喃2_TipId"] = {
    Text = "다음 턴의 행동을 예측할 수 없습니다."
  },
  ["MonsterIntent_怪物意图不明呢喃3_Name"] = {
    Text = "알 수 없음"
  },
  ["MonsterIntent_怪物意图不明呢喃3_TipId"] = {
    Text = "다음 턴의 행동을 예측할 수 없습니다."
  },
  ["MonsterIntent_怪物意图不明呢喃4_Name"] = {
    Text = "알 수 없음"
  },
  ["MonsterIntent_怪物意图不明呢喃4_TipId"] = {
    Text = "다음 턴의 행동을 예측할 수 없습니다."
  },
  ["MonsterIntent_怪物意图不明呢喃5_Name"] = {
    Text = "알 수 없음"
  },
  ["MonsterIntent_怪物意图不明呢喃5_TipId"] = {
    Text = "다음 턴의 행동을 예측할 수 없습니다."
  },
  ["MonsterIntent_怪物意图不明呢喃6_Name"] = {
    Text = "알 수 없음"
  },
  ["MonsterIntent_怪物意图不明呢喃6_TipId"] = {
    Text = "다음 턴의 행동을 예측할 수 없습니다."
  },
  ["MonsterIntent_怪物意图人面犬重攻击_Name"] = {Text = "타격"},
  ["MonsterIntent_怪物意图人面犬重攻击_TipId"] = {
    Text = "아군에게 {s1} 피해를 가합니다."
  },
  ["MonsterIntent_怪物意图削弱_Name"] = {Text = "약화"},
  ["MonsterIntent_怪物意图削弱_TipId"] = {
    Text = "아군에게 부정적인 효과를 부여힙니다."
  },
  ["MonsterIntent_怪物意图强力削弱_Name"] = {Text = "약화"},
  ["MonsterIntent_怪物意图强力削弱_TipId"] = {
    Text = "아군에게 강력한 부정적인 효과를 부여힙니다."
  },
  ["MonsterIntent_怪物意图强力强化_Name"] = {Text = "강화"},
  ["MonsterIntent_怪物意图强力强化_TipId"] = {
    Text = "강화를 진행합니다."
  },
  ["MonsterIntent_怪物意图强化DCB02_2_Name"] = {Text = "강화"},
  ["MonsterIntent_怪物意图强化DCB02_2_TipId"] = {
    Text = "강화를 진행합니다."
  },
  ["MonsterIntent_怪物意图强化DCB02_4_Name"] = {Text = "강화"},
  ["MonsterIntent_怪物意图强化DCB02_4_TipId"] = {
    Text = "강화를 진행합니다."
  },
  ["MonsterIntent_怪物意图强化_Name"] = {Text = "강화"},
  ["MonsterIntent_怪物意图强化_TipId"] = {
    Text = "강화를 진행합니다."
  },
  ["MonsterIntent_怪物意图攻击_Name"] = {Text = "타격"},
  ["MonsterIntent_怪物意图攻击_TipId"] = {
    Text = "아군에게 {s1} 피해를 가합니다."
  },
  ["MonsterIntent_怪物意图攻击和削弱_Name"] = {
    Text = "타격&약화"
  },
  ["MonsterIntent_怪物意图攻击和削弱_TipId"] = {
    Text = "아군에게 {s1} 피해를 가하고, 부정적인 효과를 부여힙니다."
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_Name"] = {
    Text = "타격&약화"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_TipId"] = {
    Text = "아군에게 {s1} 피해를 가하고, 부정적인 효과를 부여힙니다."
  },
  ["MonsterIntent_怪物意图攻击和强化_Name"] = {
    Text = "타격&강화"
  },
  ["MonsterIntent_怪物意图攻击和强化_TipId"] = {
    Text = "아군에게 {s1} 피해를 가하고, 강화를 진행합니다."
  },
  ["MonsterIntent_怪物意图攻击和防御_Name"] = {
    Text = "타격&방어"
  },
  ["MonsterIntent_怪物意图攻击和防御_TipId"] = {
    Text = "아군에게 {s1} 피해를 가히고, 방어막을 얻습니다."
  },
  ["MonsterIntent_怪物意图狂气_Name"] = {
    Text = "광기 폭발"
  },
  ["MonsterIntent_怪物意图狂气_TipId"] = {
    Text = "다음 턴에 광기 폭발을 발동합니다"
  },
  ["MonsterIntent_怪物意图狂气非攻击_Name"] = {
    Text = "광기 폭발"
  },
  ["MonsterIntent_怪物意图狂气非攻击_TipId"] = {
    Text = "다음 턴에 광기 폭발을 발동합니다"
  },
  ["MonsterIntent_怪物意图眩晕_Name"] = {Text = "기절"},
  ["MonsterIntent_怪物意图眩晕_TipId"] = {
    Text = "기절 상태로, 행동할 수 없습니다."
  },
  ["MonsterIntent_怪物意图超级狂气_Name"] = {
    Text = "광기 폭발"
  },
  ["MonsterIntent_怪物意图超级狂气_TipId"] = {
    Text = "다음 턴에 광기 폭발을 발동합니다."
  },
  ["MonsterIntent_怪物意图释放终结_Name"] = {
    Text = "광기 폭발"
  },
  ["MonsterIntent_怪物意图释放终结_TipId"] = {
    Text = "다음 턴에 플레이어가 사망합니다."
  },
  ["MonsterIntent_怪物意图重攻击_Name"] = {Text = "타격"},
  ["MonsterIntent_怪物意图重攻击_TipId"] = {
    Text = "아군에게 {s1} 피해를 가합니다."
  },
  ["MonsterIntent_怪物意图防御_Name"] = {Text = "방어"},
  ["MonsterIntent_怪物意图防御_TipId"] = {
    Text = "방어막을 얻습니다."
  },
  ["MonsterIntent_怪物意图防御和削弱_Name"] = {
    Text = "타격&약화"
  },
  ["MonsterIntent_怪物意图防御和削弱_TipId"] = {
    Text = "방어막을 얻고, 아군에게 부정적인 효과를 부여힙니다."
  },
  ["MonsterIntent_怪物意图防御和强化_Name"] = {
    Text = "방어&강화"
  },
  ["MonsterIntent_怪物意图防御和强化_TipId"] = {
    Text = "방어막을 얻고, 강화를 진행합니다."
  }
})
return Text_MonsterIntent
