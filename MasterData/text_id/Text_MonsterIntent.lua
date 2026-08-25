__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MonsterIntent = readonly({
  ["MonsterIntent_怪物意图不明_Name"] = {
    Text = "Tidak diketahui"
  },
  ["MonsterIntent_怪物意图不明_TipId"] = {
    Text = "Tindakan pada giliran berikutnya tidak dapat diprediksi."
  },
  ["MonsterIntent_怪物意图不明呢喃1_Name"] = {
    Text = "Tidak diketahui"
  },
  ["MonsterIntent_怪物意图不明呢喃1_TipId"] = {
    Text = "Tindakan pada giliran berikutnya tidak dapat diprediksi."
  },
  ["MonsterIntent_怪物意图不明呢喃2_Name"] = {
    Text = "Tidak diketahui"
  },
  ["MonsterIntent_怪物意图不明呢喃2_TipId"] = {
    Text = "Tindakan pada giliran berikutnya tidak dapat diprediksi."
  },
  ["MonsterIntent_怪物意图不明呢喃3_Name"] = {
    Text = "Tidak diketahui"
  },
  ["MonsterIntent_怪物意图不明呢喃3_TipId"] = {
    Text = "Tindakan pada giliran berikutnya tidak dapat diprediksi."
  },
  ["MonsterIntent_怪物意图不明呢喃4_Name"] = {
    Text = "Tidak diketahui"
  },
  ["MonsterIntent_怪物意图不明呢喃4_TipId"] = {
    Text = "Tindakan pada giliran berikutnya tidak dapat diprediksi."
  },
  ["MonsterIntent_怪物意图不明呢喃5_Name"] = {
    Text = "Tidak diketahui"
  },
  ["MonsterIntent_怪物意图不明呢喃5_TipId"] = {
    Text = "Tindakan pada giliran berikutnya tidak dapat diprediksi."
  },
  ["MonsterIntent_怪物意图不明呢喃6_Name"] = {
    Text = "Tidak diketahui"
  },
  ["MonsterIntent_怪物意图不明呢喃6_TipId"] = {
    Text = "Tindakan pada giliran berikutnya tidak dapat diprediksi."
  },
  ["MonsterIntent_怪物意图人面犬重攻击_Name"] = {Text = "Pukulan"},
  ["MonsterIntent_怪物意图人面犬重攻击_TipId"] = {
    Text = "Akan menyebabkan {s1} poin kerusakan pada tim kita."
  },
  ["MonsterIntent_怪物意图削弱_Name"] = {Text = "Melemahkan"},
  ["MonsterIntent_怪物意图削弱_TipId"] = {
    Text = "Akan memberikan Efek negatif pada pihak kami."
  },
  ["MonsterIntent_怪物意图强力削弱_Name"] = {Text = "Melemahkan"},
  ["MonsterIntent_怪物意图强力削弱_TipId"] = {
    Text = "Akan memberikan efek negatif yang kuat pada pihak kita."
  },
  ["MonsterIntent_怪物意图强力强化_Name"] = {Text = "Memperkuat"},
  ["MonsterIntent_怪物意图强力强化_TipId"] = {
    Text = "Akan dilakukan penguatan."
  },
  ["MonsterIntent_怪物意图强化DCB02_2_Name"] = {Text = "Memperkuat"},
  ["MonsterIntent_怪物意图强化DCB02_2_TipId"] = {
    Text = "Akan dilakukan penguatan."
  },
  ["MonsterIntent_怪物意图强化DCB02_4_Name"] = {Text = "Memperkuat"},
  ["MonsterIntent_怪物意图强化DCB02_4_TipId"] = {
    Text = "Akan dilakukan penguatan."
  },
  ["MonsterIntent_怪物意图强化_Name"] = {Text = "Memperkuat"},
  ["MonsterIntent_怪物意图强化_TipId"] = {
    Text = "Akan dilakukan penguatan."
  },
  ["MonsterIntent_怪物意图攻击_Name"] = {Text = "Pukulan"},
  ["MonsterIntent_怪物意图攻击_TipId"] = {
    Text = "Akan menyebabkan {s1} poin kerusakan pada tim kita."
  },
  ["MonsterIntent_怪物意图攻击和削弱_Name"] = {
    Text = "Pukul & Lemahkan"
  },
  ["MonsterIntent_怪物意图攻击和削弱_TipId"] = {
    Text = "Akan memberikan {s1} poin kerusakan kepada tim kita dan menerapkan efek negatif kepada tim kita."
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_Name"] = {
    Text = "Pukul & Lemahkan"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_TipId"] = {
    Text = "Akan memberikan {s1} poin kerusakan kepada tim kita dan menerapkan efek negatif kepada tim kita."
  },
  ["MonsterIntent_怪物意图攻击和强化_Name"] = {
    Text = "Pukulan & Memperkuat"
  },
  ["MonsterIntent_怪物意图攻击和强化_TipId"] = {
    Text = "Akan memberikan {s1} poin kerusakan kepada tim kita dan memperkuat."
  },
  ["MonsterIntent_怪物意图攻击和防御_Name"] = {
    Text = "Serangan & Pertahanan"
  },
  ["MonsterIntent_怪物意图攻击和防御_TipId"] = {
    Text = "Akan memberikan {s1} poin kerusakan kepada tim kita, lalu menerapkan perisai."
  },
  ["MonsterIntent_怪物意图狂气_Name"] = {Text = "Exalt"},
  ["MonsterIntent_怪物意图狂气_TipId"] = {
    Text = "Putaran berikutnya akan segera melepaskan Aliemus Muliakan."
  },
  ["MonsterIntent_怪物意图狂气非攻击_Name"] = {Text = "Exalt"},
  ["MonsterIntent_怪物意图狂气非攻击_TipId"] = {
    Text = "Putaran berikutnya akan segera melepaskan Aliemus Muliakan."
  },
  ["MonsterIntent_怪物意图眩晕_Name"] = {Text = "Stun"},
  ["MonsterIntent_怪物意图眩晕_TipId"] = {
    Text = "Berada dalam keadaan pusing, tidak dapat melakukan tindakan."
  },
  ["MonsterIntent_怪物意图超级狂气_Name"] = {Text = "Exalt"},
  ["MonsterIntent_怪物意图超级狂气_TipId"] = {
    Text = "Putaran berikutnya akan segera melepaskan Aliemus Muliakan."
  },
  ["MonsterIntent_怪物意图释放终结_Name"] = {Text = "Exalt"},
  ["MonsterIntent_怪物意图释放终结_TipId"] = {
    Text = "Giliran berikutnya akan mengeliminasi pemain."
  },
  ["MonsterIntent_怪物意图重攻击_Name"] = {Text = "Pukulan"},
  ["MonsterIntent_怪物意图重攻击_TipId"] = {
    Text = "Akan menyebabkan {s1} poin kerusakan pada tim kita."
  },
  ["MonsterIntent_怪物意图防御_Name"] = {Text = "Pertahanan"},
  ["MonsterIntent_怪物意图防御_TipId"] = {
    Text = "Akan memberikan Perisai."
  },
  ["MonsterIntent_怪物意图防御和削弱_Name"] = {
    Text = "Pertahanan & Pelemahan"
  },
  ["MonsterIntent_怪物意图防御和削弱_TipId"] = {
    Text = "Akan memberikan Perisai dan menerapkan Efek negatif pada sekutu kita."
  },
  ["MonsterIntent_怪物意图防御和强化_Name"] = {
    Text = "Pertahanan & Memperkuat"
  },
  ["MonsterIntent_怪物意图防御和强化_TipId"] = {
    Text = "Akan memberikan Perisai dan Memperkuat."
  }
})
return Text_MonsterIntent
