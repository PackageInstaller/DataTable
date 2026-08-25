__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MonsterIntent = readonly({
  ["MonsterIntent_怪物意图不明_Name"] = {Text = "Bilinmeyen"},
  ["MonsterIntent_怪物意图不明_TipId"] = {
    Text = "Düşmanın niyeti algılanamıyor."
  },
  ["MonsterIntent_怪物意图不明呢喃1_Name"] = {Text = "Bilinmeyen"},
  ["MonsterIntent_怪物意图不明呢喃1_TipId"] = {
    Text = "Düşmanın niyeti algılanamıyor."
  },
  ["MonsterIntent_怪物意图不明呢喃2_Name"] = {Text = "Bilinmeyen"},
  ["MonsterIntent_怪物意图不明呢喃2_TipId"] = {
    Text = "Düşmanın niyeti algılanamıyor."
  },
  ["MonsterIntent_怪物意图不明呢喃3_Name"] = {Text = "Bilinmeyen"},
  ["MonsterIntent_怪物意图不明呢喃3_TipId"] = {
    Text = "Düşmanın niyeti algılanamıyor."
  },
  ["MonsterIntent_怪物意图不明呢喃4_Name"] = {Text = "Bilinmeyen"},
  ["MonsterIntent_怪物意图不明呢喃4_TipId"] = {
    Text = "Düşmanın niyeti algılanamıyor."
  },
  ["MonsterIntent_怪物意图不明呢喃5_Name"] = {Text = "Bilinmeyen"},
  ["MonsterIntent_怪物意图不明呢喃5_TipId"] = {
    Text = "Düşmanın niyeti algılanamıyor."
  },
  ["MonsterIntent_怪物意图不明呢喃6_Name"] = {Text = "Bilinmeyen"},
  ["MonsterIntent_怪物意图不明呢喃6_TipId"] = {
    Text = "Düşmanın niyeti algılanamıyor."
  },
  ["MonsterIntent_怪物意图人面犬重攻击_Name"] = {Text = "Darbe"},
  ["MonsterIntent_怪物意图人面犬重攻击_TipId"] = {
    Text = "Müttefiklere {s1} Hasar verir."
  },
  ["MonsterIntent_怪物意图削弱_Name"] = {Text = "Zayıflat"},
  ["MonsterIntent_怪物意图削弱_TipId"] = {
    Text = "Takımına olumsuz etkiler uygular."
  },
  ["MonsterIntent_怪物意图强力削弱_Name"] = {Text = "Zayıflat"},
  ["MonsterIntent_怪物意图强力削弱_TipId"] = {
    Text = "Takımına güçlü bir olumsuz etki uygular."
  },
  ["MonsterIntent_怪物意图强力强化_Name"] = {Text = "Geliştir"},
  ["MonsterIntent_怪物意图强力强化_TipId"] = {
    Text = "Düşman kendini güçlendirecek."
  },
  ["MonsterIntent_怪物意图强化DCB02_2_Name"] = {Text = "Geliştir"},
  ["MonsterIntent_怪物意图强化DCB02_2_TipId"] = {
    Text = "Düşman kendini güçlendirecek."
  },
  ["MonsterIntent_怪物意图强化DCB02_4_Name"] = {Text = "Geliştir"},
  ["MonsterIntent_怪物意图强化DCB02_4_TipId"] = {
    Text = "Düşman kendini güçlendirecek."
  },
  ["MonsterIntent_怪物意图强化_Name"] = {Text = "Geliştir"},
  ["MonsterIntent_怪物意图强化_TipId"] = {
    Text = "Düşman kendini güçlendirecek."
  },
  ["MonsterIntent_怪物意图攻击_Name"] = {Text = "Darbe"},
  ["MonsterIntent_怪物意图攻击_TipId"] = {
    Text = "Müttefiklere {s1} Hasar verir."
  },
  ["MonsterIntent_怪物意图攻击和削弱_Name"] = {
    Text = "Darbe&Zayıflat"
  },
  ["MonsterIntent_怪物意图攻击和削弱_TipId"] = {
    Text = "Takımına {s1} Hasar verecek ve olumsuz etkiler uygulayacak."
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_Name"] = {
    Text = "Darbe&Zayıflat"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_TipId"] = {
    Text = "Takımına {s1} Hasar verecek ve olumsuz etkiler uygulayacak."
  },
  ["MonsterIntent_怪物意图攻击和强化_Name"] = {
    Text = "Darbe&Güçlendir"
  },
  ["MonsterIntent_怪物意图攻击和强化_TipId"] = {
    Text = "Takımına {s1} DMG ver ve Güçlendirme uygula."
  },
  ["MonsterIntent_怪物意图攻击和防御_Name"] = {
    Text = "Darbe&Savunma"
  },
  ["MonsterIntent_怪物意图攻击和防御_TipId"] = {
    Text = "Takımına {s1} DMG verecek ve Karakter Kalkanı kazanacak."
  },
  ["MonsterIntent_怪物意图狂气_Name"] = {
    Text = "Taşkınlık"
  },
  ["MonsterIntent_怪物意图狂气_TipId"] = {
    Text = "Düşman gelecek tur Taşkınlık'ı serbest bırakacak."
  },
  ["MonsterIntent_怪物意图狂气非攻击_Name"] = {
    Text = "Taşkınlık"
  },
  ["MonsterIntent_怪物意图狂气非攻击_TipId"] = {
    Text = "Düşman gelecek tur Taşkınlık'ı serbest bırakacak."
  },
  ["MonsterIntent_怪物意图眩晕_Name"] = {Text = "Sersemlet"},
  ["MonsterIntent_怪物意图眩晕_TipId"] = {
    Text = "Sersemlemiş ve hareket edemiyor."
  },
  ["MonsterIntent_怪物意图超级狂气_Name"] = {
    Text = "Taşkınlık"
  },
  ["MonsterIntent_怪物意图超级狂气_TipId"] = {
    Text = "Düşman gelecek tur Taşkınlık'ı serbest bırakacak."
  },
  ["MonsterIntent_怪物意图释放终结_Name"] = {
    Text = "Taşkınlık"
  },
  ["MonsterIntent_怪物意图释放终结_TipId"] = {
    Text = "Düşman seni gelecek tur ortadan kaldıracak."
  },
  ["MonsterIntent_怪物意图重攻击_Name"] = {Text = "Darbe"},
  ["MonsterIntent_怪物意图重攻击_TipId"] = {
    Text = "Müttefiklere {s1} Hasar verir."
  },
  ["MonsterIntent_怪物意图防御_Name"] = {Text = "Savunma"},
  ["MonsterIntent_怪物意图防御_TipId"] = {
    Text = "Düşman Karakter Kalkanı kazanacak."
  },
  ["MonsterIntent_怪物意图防御和削弱_Name"] = {
    Text = "Savunma&Zayıflat"
  },
  ["MonsterIntent_怪物意图防御和削弱_TipId"] = {
    Text = "Karakter Kalkanı kazanacak ve ekibine zayıflatmalar uygulayacak."
  },
  ["MonsterIntent_怪物意图防御和强化_Name"] = {
    Text = "Savunma&Güçlendir"
  },
  ["MonsterIntent_怪物意图防御和强化_TipId"] = {
    Text = "Karakter Kalkanı ve güçlendirmeler kazanacak."
  }
})
return Text_MonsterIntent
