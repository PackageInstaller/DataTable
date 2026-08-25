__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_EnchantConfig = readonly({
  EnchantConfig_119927_Desc = {
    Text = "После применения дополнительно активируется [Arg1] раз, <DepleteIconKeywords:расход>. <RippleKeywords:Эхо>: возьмите 2 карты."
  },
  EnchantConfig_119927_Name = {
    Text = "<BlueQuality:Эхо пропасти>"
  },
  EnchantConfig_18169_Desc = {
    Text = "Сыграйте картой и получите [Arg1] единиц вычислительной мощности."
  },
  EnchantConfig_18169_Name = {
    Text = "<WhiteQuality:стратегический расчёт>"
  },
  EnchantConfig_18170_Desc = {
    Text = "После розыгрыша получить [Arg1] заряд(а) <RetaliateIconKeywords:Контратаки>, активировать [Arg2]% <RetaliateIconKeywords:Контратаки> против всех врагов."
  },
  EnchantConfig_18170_Name = {
    Text = "<OrangeQuality:высшие шипы>"
  },
  EnchantConfig_18171_Desc = {
    Text = "После применения дополнительно активируется [Arg1] раз, получить [Arg2] очков чёрной Печать пакиа, <DepleteIconKeywords:расход>, <GuyouKeywords:врождённое>."
  },
  EnchantConfig_18171_Name = {
    Text = "<OrangeQuality:высшее эхо>"
  },
  EnchantConfig_18172_Desc = {
    Text = "Снимает со всех врагов [Arg1] очков временной <PowerIconKeywords:силы>."
  },
  EnchantConfig_18172_Name = {
    Text = "<WhiteQuality:истощение>"
  },
  EnchantConfig_18173_Desc = {
    Text = "После розыгрыша <EmbryoFusionIconKeywords:эмбриональная фузия> +[Arg1]."
  },
  EnchantConfig_18173_Name = {
    Text = "<OrangeQuality:высший Уровень жажды крови>"
  },
  EnchantConfig_18174_Desc = {
    Text = "Выстрел наносит <VulnerabilityIconKeywords:уязвимость> всем врагам [Arg1] ходов."
  },
  EnchantConfig_18174_Name = {
    Text = "<OrangeQuality:высшая уязвимость>"
  },
  EnchantConfig_18175_Desc = {
    Text = "Выстрел вызывает атаку 1 щупальце [Arg1] раз."
  },
  EnchantConfig_18175_Name = {
    Text = "<OrangeQuality:высший управление>"
  },
  EnchantConfig_18176_Desc = {
    Text = "Выстрел вызывает атаку 1 щупальце [Arg1] раз."
  },
  EnchantConfig_18176_Name = {
    Text = "<WhiteQuality:управление>"
  },
  EnchantConfig_18177_Desc = {
    Text = "Сыграйте и возьмите [Arg1] карты."
  },
  EnchantConfig_18177_Name = {
    Text = "<OrangeQuality:высший мастер>"
  },
  EnchantConfig_18178_Desc = {
    Text = "После начала боя в колоду для розыгрыша добавляются [Arg1] временные копии, оригинальные карты и зеркальные карты получают <RetainIconKeywords:сохранение>."
  },
  EnchantConfig_18178_Name = {
    Text = "<OrangeQuality:высший зеркальный>"
  },
  EnchantConfig_18179_Desc = {
    Text = "После удара получаете [Arg1] очков <PowerIconKeywords:Огромная Огромная Огромная Огромная сила>."
  },
  EnchantConfig_18179_Name = {
    Text = "<OrangeQuality:высшее усилие>"
  },
  EnchantConfig_18180_Desc = {
    Text = "После использования пробуждающее тело получит [Arg1] очков безумия."
  },
  EnchantConfig_18180_Name = {
    Text = "<OrangeQuality:высший бешеность>"
  },
  EnchantConfig_18181_Desc = {
    Text = "После использования накладывает на всех врагов [Arg1] слоев <IntoxicationIconKeywords:Яд>, заставляя всех врагов активировать [Arg2]% <IntoxicationIconKeywords:Яда>."
  },
  EnchantConfig_18181_Name = {
    Text = "<OrangeQuality:высший токсин>"
  },
  EnchantConfig_18182_Desc = {
    Text = "Разыграв, перетасуйте [Arg1] карт <DerivativeCardKeywords_4:\"Озарение\"> в колоду для розыгрыша. \"Озарение\": получите 1 арифметику. Вытяните 1 карту, <RetainIconKeywords:Удержание>, <DepleteIconKeywords:расход>."
  },
  EnchantConfig_18182_Name = {
    Text = "<WhiteQuality:вдохновение>"
  },
  EnchantConfig_18183_Desc = {
    Text = "Выстрел наносит <VulnerabilityIconKeywords:уязвимость> всем врагам [Arg1] ходов."
  },
  EnchantConfig_18183_Name = {
    Text = "<WhiteQuality:уязвимость>"
  },
  EnchantConfig_18184_Desc = {
    Text = "Вы получите [Arg1] очков щита после использования."
  },
  EnchantConfig_18184_Name = {
    Text = "<OrangeQuality:высший Уровень Железной Стены>"
  },
  EnchantConfig_18185_Desc = {
    Text = "После использования накладывает на всех врагов [Arg1] слоев <IntoxicationIconKeywords:Яд>, заставляя всех врагов активировать [Arg2]% <IntoxicationIconKeywords:Яда>."
  },
  EnchantConfig_18185_Name = {
    Text = "<WhiteQuality:токсин>"
  },
  EnchantConfig_18186_Desc = {
    Text = "После начала боя в колоду для розыгрыша добавляются [Arg1] временные копии, оригинальные карты и зеркальные карты получают <RetainIconKeywords:сохранение>."
  },
  EnchantConfig_18186_Name = {
    Text = "<WhiteQuality:отражение>"
  },
  EnchantConfig_18187_Desc = {
    Text = "После использования получите [Arg1] временных <PowerIconKeywords:Огромная Огромная Огромная Огромная сила>. Карта с гравировкой также получает этот бонус <PowerIconKeywords:Огромная Огромная Огромная Огромная сила>."
  },
  EnchantConfig_18187_Name = {
    Text = "<OrangeQuality:высший вспышка>"
  },
  EnchantConfig_18188_Desc = {
    Text = "Сыграйте и возьмите [Arg1] карты."
  },
  EnchantConfig_18188_Name = {
    Text = "<WhiteQuality:чудесная рука>"
  },
  EnchantConfig_18189_Desc = {
    Text = "Разыграв, перетасуйте [Arg1] карт <DerivativeCardKeywords_4:\"Озарение\"> в колоду для розыгрыша. \"Озарение\": получите 1 арифметику. Вытяните 1 карту, <RetainIconKeywords:Удержание>, <DepleteIconKeywords:расход>."
  },
  EnchantConfig_18189_Name = {
    Text = "<OrangeQuality:высшее вдохновение>"
  },
  EnchantConfig_18190_Desc = {
    Text = "После применения <WeaknessIconKeywords:слабость> у всех врагов на [Arg1] ход."
  },
  EnchantConfig_18190_Name = {
    Text = "<OrangeQuality:высший слабость>"
  },
  EnchantConfig_18191_Desc = {
    Text = "После розыгрыша <EmbryoFusionIconKeywords:эмбриональная фузия> +[Arg1]."
  },
  EnchantConfig_18191_Name = {
    Text = "<WhiteQuality:кровожадность>"
  },
  EnchantConfig_18192_Desc = {
    Text = "После применения <WeaknessIconKeywords:слабость> у всех врагов на [Arg1] ход."
  },
  EnchantConfig_18192_Name = {
    Text = "<WhiteQuality:слабость>"
  },
  EnchantConfig_18193_Desc = {
    Text = "Снимает со всех врагов [Arg1] очков временной <PowerIconKeywords:силы>."
  },
  EnchantConfig_18193_Name = {
    Text = "<OrangeQuality:высший Уровень изнеможения>"
  },
  EnchantConfig_18194_Desc = {
    Text = "После использования добавьте [Arg1] копий карты во временное <DimensionalSpaceIconKeywords:Ультра пространство>."
  },
  EnchantConfig_18194_Name = {
    Text = "<OrangeQuality:высший скачок>"
  },
  EnchantConfig_18195_Desc = {
    Text = "После удара получаете [Arg1] очков <PowerIconKeywords:Огромная Огромная Огромная Огромная сила>."
  },
  EnchantConfig_18195_Name = {
    Text = "<WhiteQuality:Огромная Огромная Огромная Огромная сила грубой мощи>"
  },
  EnchantConfig_18196_Desc = {
    Text = "Вы получите [Arg1] очков щита после использования."
  },
  EnchantConfig_18196_Name = {
    Text = "<WhiteQuality:железная стена>"
  },
  EnchantConfig_18197_Desc = {
    Text = "Сыграйте картой и получите [Arg1] единиц вычислительной мощности."
  },
  EnchantConfig_18197_Name = {
    Text = "<OrangeQuality:высший расчёт>"
  },
  EnchantConfig_18198_Desc = {
    Text = "После применения другие пробуждающие тела получают [Arg1] безумия."
  },
  EnchantConfig_18198_Name = {
    Text = "<OrangeQuality:продвинутый каталитический>"
  },
  EnchantConfig_18199_Desc = {
    Text = "После розыгрыша получить [Arg1] заряд(а) <RetaliateIconKeywords:Контратаки>, активировать [Arg2]% <RetaliateIconKeywords:Контратаки> против всех врагов."
  },
  EnchantConfig_18199_Name = {
    Text = "<WhiteQuality:шипы>"
  },
  EnchantConfig_18200_Desc = {
    Text = "После применения дополнительно активируется [Arg1] раз, получить [Arg2] очков чёрной Печать пакиа, <DepleteIconKeywords:расход>, <GuyouKeywords:врождённое>."
  },
  EnchantConfig_18200_Name = {
    Text = "<WhiteQuality:эхо>"
  },
  EnchantConfig_18201_Desc = {
    Text = "После использования пробуждающее тело получит [Arg1] очков безумия."
  },
  EnchantConfig_18201_Name = {
    Text = "<WhiteQuality:бешенство>"
  },
  EnchantConfig_18202_Desc = {
    Text = "После использования получите [Arg1] временных <PowerIconKeywords:Огромная Огромная Огромная Огромная сила>. Карта с гравировкой также получает этот бонус <PowerIconKeywords:Огромная Огромная Огромная Огромная сила>."
  },
  EnchantConfig_18202_Name = {
    Text = "<WhiteQuality:взрыв>"
  },
  EnchantConfig_18203_Desc = {
    Text = "После применения другие пробуждающие тела получают [Arg1] безумия."
  },
  EnchantConfig_18203_Name = {
    Text = "<WhiteQuality:катализ>"
  },
  EnchantConfig_18204_Desc = {
    Text = "После использования добавьте [Arg1] копий карты во временное <DimensionalSpaceIconKeywords:Ультра пространство>."
  },
  EnchantConfig_18204_Name = {
    Text = "<WhiteQuality:трансгрессия>"
  },
  EnchantConfig_48006_Desc = {
    Text = "Каждый ход первое нанесение урона срабатывает дважды."
  },
  EnchantConfig_48006_Name = {
    Text = "<WhiteQuality:ансамбль>"
  },
  EnchantConfig_48007_Desc = {
    Text = "Каждый ход первое применение активируется 3 раза."
  },
  EnchantConfig_48007_Name = {
    Text = "<WhiteQuality:высший ансамбль>"
  },
  EnchantConfig_49108_Desc = {
    Text = "Карта получает <RetainIconKeywords:удержание>. Если она остается в руке к концу хода, вы получаете копию с <RetainIconKeywords:удержанием> и <DepleteIconKeywords:расходом>."
  },
  EnchantConfig_49108_Name = {
    Text = "<WhiteQuality:зачатие>"
  },
  EnchantConfig_59530_Desc = {
    Text = "После розыгрыша сбросьте все карты, не связанные с этим пробуждением, получите 5 случайных карт, не связанных с пробуждением. Эффект срабатывает только 1 раз за бой."
  },
  EnchantConfig_59530_Name = {
    Text = "<OrangeQuality:логика удовольствия>"
  },
  EnchantConfig_59531_Desc = {
    Text = "После розыгрыша вытяните 2 карты, их расход арифметики уменьшается на фактический расход арифметики гравировочной карты; срабатывает лишь 1 раз за бой."
  },
  EnchantConfig_59531_Name = {
    Text = "<OrangeQuality:Причина Мудрости>"
  },
  EnchantConfig_59532_Desc = {
    Text = "После использования получите 3 исходные копии с <RetainIconKeywords:сохранением> и <DepleteIconKeywords:расходом>, Эффект срабатывает только 1 раз за бой."
  },
  EnchantConfig_59532_Name = {
    Text = "<OrangeQuality:Закон размножения>"
  },
  EnchantConfig_67415_Desc = {
    Text = "После розыгрыша сбросьте все карты, не связанные с этим пробуждением, получите 5 случайных карт, не связанных с пробуждением. Эффект срабатывает только 1 раз за бой."
  },
  EnchantConfig_67415_Name = {
    Text = "<RedQuality:Высшая логика удовольствия>"
  },
  EnchantConfig_67416_Desc = {
    Text = "После розыгрыша вытяните 4 карты, их расход арифметики уменьшается на фактический расход арифметики гравировочной карты; срабатывает лишь 1 раз за бой."
  },
  EnchantConfig_67416_Name = {
    Text = "<RedQuality:Высшая причина мудрости>"
  },
  EnchantConfig_67417_Desc = {
    Text = "После розыгрыша получите 3 начальные копии с расходом арифметики –1 и добавлением <RetainIconKeywords:сохранения> и <DepleteIconKeywords:расхода>, срабатывает лишь 1 раз за бой."
  },
  EnchantConfig_67417_Name = {
    Text = "<RedQuality:высший Принцип размножения>"
  }
})
return Text_EnchantConfig
