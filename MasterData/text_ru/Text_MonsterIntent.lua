__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_MonsterIntent = readonly({
  ["MonsterIntent_怪物意图不明_Name"] = {
    Text = "Авидья"
  },
  ["MonsterIntent_怪物意图不明_TipId"] = {
    Text = "Действие на следующий ход невозможно предугадать."
  },
  ["MonsterIntent_怪物意图不明呢喃1_Name"] = {
    Text = "Авидья"
  },
  ["MonsterIntent_怪物意图不明呢喃1_TipId"] = {
    Text = "Действие на следующий ход невозможно предугадать."
  },
  ["MonsterIntent_怪物意图不明呢喃2_Name"] = {
    Text = "Авидья"
  },
  ["MonsterIntent_怪物意图不明呢喃2_TipId"] = {
    Text = "Действие на следующий ход невозможно предугадать."
  },
  ["MonsterIntent_怪物意图不明呢喃3_Name"] = {
    Text = "Авидья"
  },
  ["MonsterIntent_怪物意图不明呢喃3_TipId"] = {
    Text = "Действие на следующий ход невозможно предугадать."
  },
  ["MonsterIntent_怪物意图不明呢喃4_Name"] = {
    Text = "Авидья"
  },
  ["MonsterIntent_怪物意图不明呢喃4_TipId"] = {
    Text = "Действие на следующий ход невозможно предугадать."
  },
  ["MonsterIntent_怪物意图不明呢喃5_Name"] = {
    Text = "Авидья"
  },
  ["MonsterIntent_怪物意图不明呢喃5_TipId"] = {
    Text = "Действие на следующий ход невозможно предугадать."
  },
  ["MonsterIntent_怪物意图不明呢喃6_Name"] = {
    Text = "Авидья"
  },
  ["MonsterIntent_怪物意图不明呢喃6_TipId"] = {
    Text = "Действие на следующий ход невозможно предугадать."
  },
  ["MonsterIntent_怪物意图人面犬重攻击_Name"] = {
    Text = "ударить"
  },
  ["MonsterIntent_怪物意图人面犬重攻击_TipId"] = {
    Text = "Нанесёт нам Урон в размере {s1} очков."
  },
  ["MonsterIntent_怪物意图削弱_Name"] = {
    Text = "Ошеломление"
  },
  ["MonsterIntent_怪物意图削弱_TipId"] = {
    Text = "Применит к нам отрицательный Эффект."
  },
  ["MonsterIntent_怪物意图强力削弱_Name"] = {
    Text = "Ошеломление"
  },
  ["MonsterIntent_怪物意图强力削弱_TipId"] = {
    Text = "Нанесёт мощный негативный Эффект на мы."
  },
  ["MonsterIntent_怪物意图强力强化_Name"] = {
    Text = "Усиление"
  },
  ["MonsterIntent_怪物意图强力强化_TipId"] = {
    Text = "Будет Усиление!"
  },
  ["MonsterIntent_怪物意图强化DCB02_2_Name"] = {
    Text = "Усиление"
  },
  ["MonsterIntent_怪物意图强化DCB02_2_TipId"] = {
    Text = "Будет Усиление!"
  },
  ["MonsterIntent_怪物意图强化DCB02_4_Name"] = {
    Text = "Усиление"
  },
  ["MonsterIntent_怪物意图强化DCB02_4_TipId"] = {
    Text = "Будет Усиление!"
  },
  ["MonsterIntent_怪物意图强化_Name"] = {
    Text = "Усиление"
  },
  ["MonsterIntent_怪物意图强化_TipId"] = {
    Text = "Будет Усиление!"
  },
  ["MonsterIntent_怪物意图攻击_Name"] = {
    Text = "ударить"
  },
  ["MonsterIntent_怪物意图攻击_TipId"] = {
    Text = "Нанесёт нам Урон в размере {s1} очков."
  },
  ["MonsterIntent_怪物意图攻击和削弱_Name"] = {
    Text = "Ударить&ослабление"
  },
  ["MonsterIntent_怪物意图攻击和削弱_TipId"] = {
    Text = "Нанесёт нам Урон на {s1} очков и наложит на нас негативный Эффект."
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_Name"] = {
    Text = "Ударить&ослабление"
  },
  ["MonsterIntent_怪物意图攻击和削弱卡茜亚隔空取物_TipId"] = {
    Text = "Нанесёт нам Урон на {s1} очков и наложит на нас негативный Эффект."
  },
  ["MonsterIntent_怪物意图攻击和强化_Name"] = {
    Text = "Ударить&Усиление"
  },
  ["MonsterIntent_怪物意图攻击和强化_TipId"] = {
    Text = "Нанесёт нам {s1} урона и применит Усиление."
  },
  ["MonsterIntent_怪物意图攻击和防御_Name"] = {
    Text = "Ударить&защита"
  },
  ["MonsterIntent_怪物意图攻击和防御_TipId"] = {
    Text = "Нанесёт нам {s1} урона и наложит щит."
  },
  ["MonsterIntent_怪物意图狂气_Name"] = {
    Text = "Вознесение"
  },
  ["MonsterIntent_怪物意图狂气_TipId"] = {
    Text = "Следующим ходом будет активирована вспышка безумия"
  },
  ["MonsterIntent_怪物意图狂气非攻击_Name"] = {
    Text = "Вознесение"
  },
  ["MonsterIntent_怪物意图狂气非攻击_TipId"] = {
    Text = "Следующим ходом будет активирована вспышка безумия"
  },
  ["MonsterIntent_怪物意图眩晕_Name"] = {
    Text = "Оглушение"
  },
  ["MonsterIntent_怪物意图眩晕_TipId"] = {
    Text = "Находится в состоянии ошеломления, не в состоянии действовать."
  },
  ["MonsterIntent_怪物意图超级狂气_Name"] = {
    Text = "Вознесение"
  },
  ["MonsterIntent_怪物意图超级狂气_TipId"] = {
    Text = "Следующим ходом будет активирована вспышка безумия"
  },
  ["MonsterIntent_怪物意图释放终结_Name"] = {
    Text = "Вознесение"
  },
  ["MonsterIntent_怪物意图释放终结_TipId"] = {
    Text = "Следующий ход завершает игрока."
  },
  ["MonsterIntent_怪物意图重攻击_Name"] = {
    Text = "ударить"
  },
  ["MonsterIntent_怪物意图重攻击_TipId"] = {
    Text = "Нанесёт нам Урон в размере {s1} очков."
  },
  ["MonsterIntent_怪物意图防御_Name"] = {
    Text = "защита"
  },
  ["MonsterIntent_怪物意图防御_TipId"] = {
    Text = "Щит будет активирован."
  },
  ["MonsterIntent_怪物意图防御和削弱_Name"] = {
    Text = "защита & ослабление"
  },
  ["MonsterIntent_怪物意图防御和削弱_TipId"] = {
    Text = "Накладывает щит и применяет отрицательный Эффект на нас."
  },
  ["MonsterIntent_怪物意图防御和强化_Name"] = {
    Text = "защита&Усиление"
  },
  ["MonsterIntent_怪物意图防御和强化_TipId"] = {
    Text = "Будет накладываться щит и усиливаться."
  }
})
return Text_MonsterIntent
