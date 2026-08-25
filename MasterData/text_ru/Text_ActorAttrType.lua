__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ActorAttrType = readonly({
  ActorAttrType_121209_AttributeDesc = {
    Text = "Уровень запретных знаний соответствует уровню Хранителя тайн и определяет эффекты следующих 3 видов глубины исследований. Если средний Уровень пробуждённых в отряде больше или равен уровню Хранителя тайн, то Уровень запретных знаний равен среднему значению между средним уровнем пробуждённых в отряде и уровнем Хранителя тайн.\nГлубина исследования живого: <Blue:{s1}>\n·Определяет силу эффекта преобразования каждых 100 ед. телосложения пробуждённого в здоровье отряда.\nГлубина исследования материи: <Blue:{s2}>\n·Определяет силу эффектов силы, урона щупальцами, щита, восстановления здоровья и снижения силы, вызываемых творениями, печатями и ключ-приказами.\nГлубина исследования сознания: <Blue:{s3}>\n·Определяет силу эффектов фиксированного отравления, фиксированной контратаки, фиксированного урона и фиксированного кровотечения, вызываемых творениями, печатями и ключ-приказами.\n"
  },
  ActorAttrType_121209_Text = {
    Text = "Уровень запретных знаний"
  },
  ActorAttrType_18103_Text = {Text = "Щит"},
  ActorAttrType_18104_Text = {
    Text = "Бонус % урона удара"
  },
  ActorAttrType_18105_AttributeUpText = {
    Text = "Критический Урон+{s1}"
  },
  ActorAttrType_18105_Text = {
    Text = "Крит. Урон"
  },
  ActorAttrType_18106_Text = {
    Text = "Усиление щита"
  },
  ActorAttrType_18107_AttributeUpText = {
    Text = "АТК+{s1}"
  },
  ActorAttrType_18107_Text = {Text = "АТК"},
  ActorAttrType_18108_Text = {Text = "Тело"},
  ActorAttrType_18109_Text = {
    Text = "Бонус % урона карт"
  },
  ActorAttrType_18110_Text = {
    Text = "Корректировка % хрупкости"
  },
  ActorAttrType_18111_Text = {
    Text = "Бонус % получаемого щита"
  },
  ActorAttrType_18112_AttributeUpText = {
    Text = "ЗЩТ +{s1}"
  },
  ActorAttrType_18112_Text = {
    Text = "ЗЩТ повышена"
  },
  ActorAttrType_18113_AttributeDesc = {
    Text = "Эффективность восстановления безумия пробуждающим телом"
  },
  ActorAttrType_18113_Text = {
    Text = "Начальный алиемус"
  },
  ActorAttrType_18114_AttributeDesc = {
    Text = "Чем выше телосложение, тем выше максимальное здоровье пробуждающего тела. \n Чем выше Уровень расследования Хранителя тайн, тем сильнее влияние Тело на максимальное здоровье пробуждающего тела."
  },
  ActorAttrType_18114_AttributeUpText = {
    Text = "Тело+{s1}"
  },
  ActorAttrType_18114_Text = {Text = "Тело"},
  ActorAttrType_18115_AttributeDesc = {
    Text = "Возвращаемый очаг ярости после прибытия источника и освобождения пробуждающего тела"
  },
  ActorAttrType_18115_AttributeUpText = {
    Text = "Расход алиемуса- +{s1}"
  },
  ActorAttrType_18115_Text = {
    Text = "Расход алиемуса-"
  },
  ActorAttrType_18116_AttributeDesc = {
    Text = "Чем выше телосложение, тем выше максимальное здоровье пробуждающего тела. \n Чем выше Уровень расследования Хранителя тайн, тем сильнее влияние Тело на максимальное здоровье пробуждающего тела."
  },
  ActorAttrType_18116_AttributeUpText = {
    Text = "Тело+{s1}"
  },
  ActorAttrType_18116_Text = {
    Text = "повышение Тело"
  },
  ActorAttrType_18117_Text = {
    Text = "Урон шупалец"
  },
  ActorAttrType_18118_Text = {
    Text = "Ячейка Ультра"
  },
  ActorAttrType_18119_Text = {
    Text = "Бонус % получаемого урона"
  },
  ActorAttrType_18120_AttributeDesc = {
    Text = "Максимальное накопление Алиемуса и расход Алиемуса при активации Вознесения равны базовому Алиемусу Пробуждённого."
  },
  ActorAttrType_18120_AttributeUpText = {
    Text = "Предел безумия+{s1}"
  },
  ActorAttrType_18120_Text = {
    Text = "Базовый Алиемус"
  },
  ActorAttrType_18121_AttributeDesc = {
    Text = "Уровень навыка 2"
  },
  ActorAttrType_18121_AttributeUpText = {
    Text = "Навык 2 Уровень+{s1}"
  },
  ActorAttrType_18121_Text = {
    Text = "Уровень навыка 2"
  },
  ActorAttrType_18122_AttributeDesc = {
    Text = "Уровень защиты"
  },
  ActorAttrType_18122_AttributeUpText = {
    Text = "Уровень защиты +{s1}"
  },
  ActorAttrType_18122_Text = {
    Text = "Уровень защиты"
  },
  ActorAttrType_18123_Text = {
    Text = "Бонус фикс. числа ударов"
  },
  ActorAttrType_18124_Text = {
    Text = "Бонус фиксированного щита"
  },
  ActorAttrType_18125_Text = {
    Text = "Бонус фикс. получаемого щита"
  },
  ActorAttrType_18126_AttributeDesc = {
    Text = "Мастерство границ команды равно сумме мастерства границ всех Пробуждённых в команде. Мастерство границ может повысить Эффект таланта границы команды. Если текущая команда - «Чистый Эквор/Чистая Плоть/Чистый Ультра», Эффект мастерства границ удваивается.\n·Каждый раз, когда в команде царства <Blue:Хаос> имеется 1 очко мастерства границ, после использования Воспоминания все Пробуждённые дополнительно получают <Blue:0.05> очков Алиемуса.\n·Каждый раз, когда в команде царства <Blue:Эквор> имеется 1 очко мастерства границ, после активации Вознесения есть <Blue:0.25％> вероятность получить 1 Уровень щупальца(вероятность выше 100% может дать несколько уровней), щит, полученный при переключении на «Спокойное море», увеличивает <Blue:0.01％> максимальное здоровье, а щупальцы, вызванные активным уроном в «Девятом валу», увеличивают <Blue:0.02%> Урон от щупалец.\n·Каждый раз, когда в команде царства <Blue:Каро> имеется 1 очко мастерства границ, при первом срабатывании Поглощения за каждый ход дополнительно получают щит, равный <Blue:0.01%> от максимального здоровья, и временную силу <Blue:0.005%>(увеличивается при потере здоровья, максимум до 100%).\n·Каждый раз, когда в команде царства <Blue:Ультра> имеется 1 очко мастерства границ, в начале хода есть <Blue:0.125%> вероятность получить 1 карту «Озарение»(вероятность выше 100% может дать несколько карт)."
  },
  ActorAttrType_18126_AttributeUpText = {
    Text = "Мастерство границ+{s1}"
  },
  ActorAttrType_18126_Text = {
    Text = "Мастерство царства"
  },
  ActorAttrType_18127_Text = {Text = "ОЗ"},
  ActorAttrType_18128_AttributeUpText = {
    Text = "АТК+{s1}"
  },
  ActorAttrType_18128_Text = {
    Text = "АТК повышена"
  },
  ActorAttrType_18129_AttributeDesc = {
    Text = "Чем выше бонус к базовому урону, тем больше Урон, наносимый пробуждающим телом"
  },
  ActorAttrType_18129_AttributeUpText = {
    Text = "Базовый Урон +{s1}"
  },
  ActorAttrType_18129_Text = {
    Text = "Базовый Урон"
  },
  ActorAttrType_18130_Text = {
    Text = "Уровень"
  },
  ActorAttrType_18131_AttributeDesc = {
    Text = "В конце хода пробуждающее тело автоматически получает Лечение очага ярости (в режиме темы — после каждого действия)"
  },
  ActorAttrType_18131_AttributeUpText = {
    Text = "Безумие автоматическое восстановление+{s1}"
  },
  ActorAttrType_18131_Text = {
    Text = "Автовосст. алиемуса"
  },
  ActorAttrType_18132_Text = {
    Text = "Уровень просветления"
  },
  ActorAttrType_18133_Text = {
    Text = "Бонус % получаемого алиемуса"
  },
  ActorAttrType_18134_Text = {
    Text = "Лимит слияния зародыша"
  },
  ActorAttrType_18135_Text = {
    Text = "Текущий алиемус"
  },
  ActorAttrType_18136_Text = {
    Text = "Бонус фикс. получаемого урона"
  },
  ActorAttrType_18137_AttributeDesc = {
    Text = "При наложении пробуждающим телом щита и эффекта восстановления увеличивается коэффициент значений щита и восстановления"
  },
  ActorAttrType_18137_AttributeUpText = {
    Text = "Щит и лечение сильнодействующий +{s1}"
  },
  ActorAttrType_18137_Text = {
    Text = "Усиление щита и исцеления"
  },
  ActorAttrType_18138_Text = {
    Text = "Усиление исцеления"
  },
  ActorAttrType_18139_AttributeDesc = {
    Text = "При разыгрывании Командной карты или Возвышении, за каждую потраченную 1 единицу Арифметики получите {s1} единиц Ключесвета. По мере увеличения этого атрибута дополнительный прирост Ключесвета постепенно снижается."
  },
  ActorAttrType_18139_AttributeUpText = {
    Text = "Серебряный ключ подзарядки+{s1}"
  },
  ActorAttrType_18139_Text = {
    Text = "Уровень заряда Ключесвета"
  },
  ActorAttrType_18140_Text = {
    Text = "Кол-во сопротивлений смерти"
  },
  ActorAttrType_18141_AttributeDesc = {
    Text = "Уровень удара"
  },
  ActorAttrType_18141_AttributeUpText = {
    Text = "Уровень атаки+{s1}"
  },
  ActorAttrType_18141_Text = {
    Text = "Уровень удара"
  },
  ActorAttrType_18142_AttributeDesc = {
    Text = "Процентное увеличение базового урона всех пробуждённых, наложенных уровней фиксированного яда и фиксированной контратаки, начального ущерба от щупалец в царстве Эквор."
  },
  ActorAttrType_18142_AttributeUpText = {
    Text = "Урон сильнодействующий+{s1}"
  },
  ActorAttrType_18142_Text = {
    Text = "Усиление урона"
  },
  ActorAttrType_18143_Text = {
    Text = "Бонус % урона вознесения"
  },
  ActorAttrType_18144_AttributeDesc = {
    Text = "Вероятность сопротивления критическому удару при нанесении активного урона пробуждающим телом"
  },
  ActorAttrType_18144_AttributeUpText = {
    Text = "Критическое сопротивление+{s1}"
  },
  ActorAttrType_18144_Text = {
    Text = "Крит. сопротивление"
  },
  ActorAttrType_18145_AttributeDesc = {
    Text = "Уровень прибытия Истока"
  },
  ActorAttrType_18145_AttributeUpText = {
    Text = "Источник прибытия: Уровень + {s1}"
  },
  ActorAttrType_18145_Text = {
    Text = "Уровень прибытия Истока"
  },
  ActorAttrType_18146_Text = {
    Text = "Бонус фиксированного лечения"
  },
  ActorAttrType_18147_AttributeUpText = {
    Text = "Шанс удачной гравировки +{s1}"
  },
  ActorAttrType_18147_Text = {
    Text = "Вероятность удачного грифа"
  },
  ActorAttrType_18148_Text = {
    Text = "Бонус фикс. лечения"
  },
  ActorAttrType_18149_Text = {
    Text = "повышение Тело"
  },
  ActorAttrType_18150_Text = {
    Text = "Корректировка % слабости"
  },
  ActorAttrType_18151_AttributeDesc = {
    Text = "Сопротивление смерти команды равно сумме сопротивления смерти пробуждённых в команде.\nПри получении смертельного урона в бою есть вероятность сохранить 1 очко жизни, после срабатывания дополнительно получите 2 очка арифметики и возьмите 2 карты, текущее и последующее Сопротивление смерти уменьшается вдвое и продолжается до завершения расследования."
  },
  ActorAttrType_18151_AttributeUpText = {
    Text = "Сопротивление смерти+{s1}"
  },
  ActorAttrType_18151_Text = {
    Text = "Сопротивление смерти"
  },
  ActorAttrType_18152_Text = {
    Text = "Бонус % алиемуса"
  },
  ActorAttrType_18154_Text = {
    Text = "Лимит щупалец"
  },
  ActorAttrType_18155_AttributeDesc = {
    Text = "Процентное увеличение дропа чёрной Печать пакиа после победы в бою."
  },
  ActorAttrType_18155_AttributeUpText = {
    Text = "Чёрный Отпечаток падает+{s1}"
  },
  ActorAttrType_18155_Text = {
    Text = "Выпадение печатей"
  },
  ActorAttrType_18156_Text = {
    Text = "Бонус фикс. получемого алиемуса"
  },
  ActorAttrType_18157_Text = {
    Text = "Скрытые намерения"
  },
  ActorAttrType_18158_Text = {
    Text = "Бонус фиксированного урона"
  },
  ActorAttrType_18159_AttributeUpText = {
    Text = "Критический шанс+{s1}"
  },
  ActorAttrType_18159_Text = {
    Text = "Крит. шанс"
  },
  ActorAttrType_18160_AttributeDesc = {
    Text = "Уровень навыка 1"
  },
  ActorAttrType_18160_AttributeUpText = {
    Text = "Навык 1 Уровень +{s1}"
  },
  ActorAttrType_18160_Text = {
    Text = "Уровень навыка 1"
  },
  ActorAttrType_18161_Text = {
    Text = "Уровень"
  },
  ActorAttrType_18162_Text = {
    Text = "Усиление урона"
  },
  ActorAttrType_18163_Text = {
    Text = "Количество шупалец"
  },
  ActorAttrType_18164_Text = {
    Text = "Бонус % получаемого лечения"
  },
  ActorAttrType_18165_Text = {
    Text = "Макс. арифметика"
  },
  ActorAttrType_18166_Text = {
    Text = "Корректировка % уязвимости"
  },
  ActorAttrType_18167_AttributeUpText = {
    Text = "ЗЩТ +{s1}"
  },
  ActorAttrType_18167_Text = {Text = "ЗЩТ"},
  ActorAttrType_18168_AttributeDesc = {
    Text = "Уровень возвышение"
  },
  ActorAttrType_18168_AttributeUpText = {
    Text = "Уровень Просветления духа +{s1}"
  },
  ActorAttrType_18168_Text = {
    Text = "Уровень возвышение"
  },
  ActorAttrType_21322_Text = {
    Text = "Восст. ключесвета"
  },
  ActorAttrType_22207_AttributeDesc = {
    Text = "После каждого освобождения вспышки безумия получите {s1} очков безумия. С увеличением этого свойства дополнительный бонус будет постепенно ослабевать."
  },
  ActorAttrType_22207_AttributeUpText = {
    Text = "Уровень восстановления безумия +{s1}"
  },
  ActorAttrType_22207_Text = {
    Text = "Уровень восст. алиемуса"
  },
  ActorAttrType_22214_Text = {
    Text = "Восстановление алиемуса"
  }
})
return Text_ActorAttrType
